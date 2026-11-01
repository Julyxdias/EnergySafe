"""
seed_users.py — cria (ou atualiza a senha de) os 3 usuários do EnergySafe.

No servidor (VPS), na pasta do projeto:
    docker compose exec backend python seed_users.py

As senhas são digitadas no terminal (não ficam no código nem no Git).
Rodar de novo redefine a senha dos usuários informados.
"""
from getpass import getpass

from auth import PERFIL_FINANCEIRO, PERFIL_MANUTENCAO, PERFIL_MASTER, hash_senha
from database import SessionLocal, engine
import models

USUARIOS = [
    ("manutencao@energia.com", PERFIL_MANUTENCAO),
    ("financeiro@energia.com", PERFIL_FINANCEIRO),
    ("master@energia.com", PERFIL_MASTER),
]


def main():
    models.Base.metadata.create_all(bind=engine)  # garante a tabela 'usuarios'
    db = SessionLocal()
    try:
        for email, perfil in USUARIOS:
            senha = getpass(f"Senha para {email} ({perfil}) [Enter = pular]: ")
            if not senha:
                print("  -> pulado")
                continue
            if len(senha) < 8:
                print("  -> senha curta (mín. 8 caracteres), pulado")
                continue
            u = db.query(models.Usuario).filter(models.Usuario.email == email).first()
            if u:
                u.senha_hash, u.perfil, u.ativo = hash_senha(senha), perfil, True
                print("  -> atualizado")
            else:
                db.add(models.Usuario(email=email, senha_hash=hash_senha(senha), perfil=perfil))
                print("  -> criado")
        db.commit()
    finally:
        db.close()


if __name__ == "__main__":
    main()
