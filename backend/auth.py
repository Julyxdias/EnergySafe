"""
auth.py — Autenticação (JWT) e perfis de acesso do EnergySafe.

Perfis:
  manutencao : telas/dados de manutenção (medições, alertas, dispositivos...)
  financeiro : telas/dados financeiros (faturas, rateio, tarifas, metas, PDF)
  master     : acesso a tudo (sempre passa em qualquer verificação)

Variável de ambiente obrigatória (no .env do servidor — NUNCA commitar):
  SECRET_KEY=<string aleatória longa>
      gerar com:  python -c "import secrets; print(secrets.token_hex(32))"
Opcional:
  ACCESS_TOKEN_EXPIRE_MINUTES=480   (padrão: 8 horas)
"""
import os
import time
from datetime import datetime, timedelta, timezone
from typing import Optional

import bcrypt
import jwt
from fastapi import APIRouter, Depends, HTTPException, Request, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from pydantic import BaseModel, ConfigDict
from sqlalchemy.orm import Session

import models
from database import get_db

# ── configuração ─────────────────────────────────────────────────────────────
SECRET_KEY = os.getenv("SECRET_KEY")
if not SECRET_KEY:
    raise RuntimeError("SECRET_KEY não definida no .env do backend")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES", "480"))

PERFIL_MANUTENCAO = "manutencao"
PERFIL_FINANCEIRO = "financeiro"
PERFIL_MASTER = "master"
PERFIS_VALIDOS = (PERFIL_MANUTENCAO, PERFIL_FINANCEIRO, PERFIL_MASTER)

# auto_error=False: quem decide se falta token é a nossa dependência
# (assim rotas "livres" por método, como o POST do ESP32, continuam abertas)
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="auth/login/", auto_error=False)


# ── senha / token ────────────────────────────────────────────────────────────
def hash_senha(senha: str) -> str:
    return bcrypt.hashpw(senha.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")


def verificar_senha(senha: str, senha_hash: str) -> bool:
    try:
        return bcrypt.checkpw(senha.encode("utf-8"), senha_hash.encode("utf-8"))
    except ValueError:
        return False


_HASH_FALSO = hash_senha("energysafe-dummy")  # iguala o tempo quando o e-mail não existe


def criar_token(u: models.Usuario) -> str:
    exp = datetime.now(timezone.utc) + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    return jwt.encode({"sub": u.email, "perfil": u.perfil, "exp": exp}, SECRET_KEY, algorithm=ALGORITHM)


# ── proteção simples contra força bruta (em memória; 1 worker uvicorn) ───────
_MAX_FALHAS = 5
_JANELA_S = 300
_falhas: dict = {}  # email -> (qtd, inicio_da_janela)


def _bloqueado(email: str) -> bool:
    reg = _falhas.get(email)
    if not reg:
        return False
    qtd, ini = reg
    if time.time() - ini > _JANELA_S:
        _falhas.pop(email, None)
        return False
    return qtd >= _MAX_FALHAS


def _registrar_falha(email: str) -> None:
    qtd, ini = _falhas.get(email, (0, time.time()))
    if time.time() - ini > _JANELA_S:
        qtd, ini = 0, time.time()
    _falhas[email] = (qtd + 1, ini)


# ── dependências de autorização ──────────────────────────────────────────────
def _erro_401() -> HTTPException:
    return HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Sessão inválida ou expirada. Faça login novamente.",
        headers={"WWW-Authenticate": "Bearer"},
    )


def _usuario_do_token(token: Optional[str], db: Session) -> models.Usuario:
    if not token:
        raise _erro_401()
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
    except jwt.PyJWTError:
        raise _erro_401()
    email = payload.get("sub")
    u = db.query(models.Usuario).filter(models.Usuario.email == email).first() if email else None
    if not u or not u.ativo:
        raise _erro_401()
    return u


def get_usuario_atual(
    token: Optional[str] = Depends(oauth2_scheme), db: Session = Depends(get_db)
) -> models.Usuario:
    return _usuario_do_token(token, db)


def exigir_perfis(*perfis: str, livre_para: tuple = ()):
    """
    Exige login e que o perfil esteja em `perfis` (o master sempre passa).
    `livre_para`: métodos HTTP que NÃO exigem login (ex.: ("POST",) para o ESP32
    continuar enviando medições sem token).

    Uso em include_router:  dependencies=[Depends(exigir_perfis("financeiro"))]
    Perfis vazios = qualquer usuário logado.
    """
    permitidos = set(perfis) | {PERFIL_MASTER}

    def _checar(
        request: Request,
        token: Optional[str] = Depends(oauth2_scheme),
        db: Session = Depends(get_db),
    ):
        if request.method in livre_para:
            return None
        u = _usuario_do_token(token, db)
        if perfis and u.perfil not in permitidos:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Seu perfil não tem acesso a este recurso.",
            )
        return u

    return _checar


# ── rotas ────────────────────────────────────────────────────────────────────
class TokenOut(BaseModel):
    access_token: str
    token_type: str = "bearer"
    perfil: str
    email: str


class UsuarioOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    email: str
    perfil: str


router = APIRouter(prefix="/auth", tags=["Autenticação"])


@router.post("/login/", response_model=TokenOut)
def login(form: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    email = form.username.strip().lower()

    if _bloqueado(email):
        raise HTTPException(
            status_code=status.HTTP_429_TOO_MANY_REQUESTS,
            detail="Muitas tentativas. Aguarde alguns minutos e tente novamente.",
        )

    u = db.query(models.Usuario).filter(models.Usuario.email == email).first()
    ok = verificar_senha(form.password, u.senha_hash if u else _HASH_FALSO)
    if not u or not u.ativo or not ok:
        _registrar_falha(email)
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="E-mail ou senha incorretos.")

    _falhas.pop(email, None)
    return TokenOut(access_token=criar_token(u), perfil=u.perfil, email=u.email)


@router.get("/me/", response_model=UsuarioOut)
def me(u: models.Usuario = Depends(get_usuario_atual)):
    return u
