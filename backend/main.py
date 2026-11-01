from fastapi import Depends, FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager

from database import engine
import models
from routes import (
    locais, areas, quadros, dispositivos,
    canais, medicoes, alertas,
    consumo, faturas, tarifas, metas,
    jobs, relatorios
)

# APScheduler — job noturno de consumo_diario
from apscheduler.schedulers.background import BackgroundScheduler
from routes.jobs import job_noturno

# Autenticação / perfis
from auth import (
    router as auth_router, exigir_perfis,
    PERFIL_MANUTENCAO, PERFIL_FINANCEIRO, PERFIL_MASTER,
)

# Qualquer usuário logado / só um perfil (o master sempre passa)
QUALQUER_LOGADO = exigir_perfis()
SO_MANUTENCAO   = exigir_perfis(PERFIL_MANUTENCAO)
SO_FINANCEIRO   = exigir_perfis(PERFIL_FINANCEIRO)
SO_MASTER       = exigir_perfis(PERFIL_MASTER)
# POST /medicoes/ e POST /alertas/ continuam ABERTOS: são o ESP32 enviando dados (sem login).
# Leituras, resolver e excluir exigem perfil manutenção.
MANUTENCAO_POST_LIVRE = exigir_perfis(PERFIL_MANUTENCAO, livre_para=("POST",))

scheduler = BackgroundScheduler(timezone="America/Sao_Paulo")
scheduler.add_job(job_noturno, "cron", hour=0, minute=5)  # todo dia 00:05


@asynccontextmanager
async def lifespan(app: FastAPI):
    models.Base.metadata.create_all(bind=engine)
    scheduler.start()
    yield
    scheduler.shutdown()


app = FastAPI(
    title="EnergySafe API",
    description="Monitoramento energético: Local → Área → Quadro → Dispositivo → Canal → Medição → Alerta",
    version="2.0.0",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "https://energy-safe.vercel.app",
        "https://energy-safe-9m2q.vercel.app",
        "https://energysafe.eco.br",
        "https://www.energysafe.eco.br",
        "http://localhost:5500",
        "http://127.0.0.1:5500",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Autenticação (login público)
app.include_router(auth_router)

# Estrutura física — qualquer usuário logado (as duas telas usam)
app.include_router(locais.router,       dependencies=[Depends(QUALQUER_LOGADO)])
app.include_router(areas.router,        dependencies=[Depends(QUALQUER_LOGADO)])
app.include_router(quadros.router,      dependencies=[Depends(QUALQUER_LOGADO)])
app.include_router(dispositivos.router, dependencies=[Depends(QUALQUER_LOGADO)])
app.include_router(canais.router,       dependencies=[Depends(QUALQUER_LOGADO)])

# Medições e alertas — manutenção (POST liberado p/ o ESP32)
app.include_router(medicoes.router, dependencies=[Depends(MANUTENCAO_POST_LIVRE)])
app.include_router(alertas.router,  dependencies=[Depends(MANUTENCAO_POST_LIVRE)])

# Financeiro — consumo é lido também pela tela de manutenção
app.include_router(consumo.router,  dependencies=[Depends(QUALQUER_LOGADO)])
app.include_router(faturas.router,  dependencies=[Depends(SO_FINANCEIRO)])
app.include_router(tarifas.router,  dependencies=[Depends(SO_FINANCEIRO)])
app.include_router(metas.router,    dependencies=[Depends(SO_FINANCEIRO)])

# Operacional
app.include_router(jobs.router,       dependencies=[Depends(SO_MASTER)])
app.include_router(relatorios.router, dependencies=[Depends(SO_FINANCEIRO)])


@app.get("/", tags=["Health"])
def health_check():
    return {"status": "ok", "service": "EnergySafe API", "version": "2.0.0"}
