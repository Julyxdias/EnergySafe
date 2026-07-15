# ⚡ EnergySafe

Plataforma IoT de monitoramento energético para instituições com múltiplas áreas físicas — escolas, universidades e hospitais-escola. O sistema mede o consumo de energia por circuito elétrico em tempo real e divide o valor da fatura mensal proporcionalmente ao consumo real de cada área, substituindo o rateio estimativo por um modelo baseado em dados medidos.

> O sistema **não controla cargas**. Ele monitora, registra, alerta e analisa.

🔗 **Produção:** [energysafe.eco.br](https://energysafe.eco.br) · **API:** [energysafe.eco.br/api](https://energysafe.eco.br/api/)

---

## 🎯 Problema resolvido

Em instituições com múltiplos setores (administrativo, TI, salas de aula, reitoria, UTI), a conta de energia costuma ser dividida igualmente ou por estimativa — o que é injusto e impossível de auditar.

O EnergySafe torna o rateio **justo, transparente e auditável**, baseado na medição real de consumo por circuito.

| | Antes | Com EnergySafe |
|---|---|---|
| Fatura de R$ 130.000 | dividida igualmente entre 4 andares | cada andar paga exatamente o que consumiu, em kWh medidos |

---

## 🏗️ Arquitetura

```
┌─────────────────────────────────────────────┐
│  CAMPO                                       │
│                                               │
│  SCT-013 (corrente) + ZMPT101B (tensão)      │
│          │                                   │
│      ESP32 (ADC + Wi-Fi)                     │
│          │                                   │
│          └──── POST /api/medicoes/ ──────┐   │
└───────────────────────────────────────────│──┘
                                             │
┌────────────────────────────────────────────▼┐
│  SERVIDOR (VPS + Docker + Nginx)             │
│                                               │
│  FastAPI ──────────────────► PostgreSQL      │
│     ├── Detecta alertas (Python)             │
│     ├── Calcula kWh (job noturno 00:05)      │
│     └── Gera PDF de rateio (ReportLab)       │
└───────────────────────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────┐
│  FRONTEND                                    │
│                                               │
│  Login ──► Painel Financeiro                 │
│        └── Painel de Manutenção              │
└───────────────────────────────────────────────┘
```

## 🧩 Componentes

| Componente | Descrição | Documentação |
|---|---|---|
| **Firmware ESP32** | Lê corrente e tensão em 3 fases (SCT-013 + ZMPT101B), calcula Irms/Vrms/Potência via EmonLib e envia via HTTPS a cada 60s. Buffer em SD card (`pending.csv`) para tolerância a quedas de rede. | [`firmware/`](./firmware) |
| **Backend API** | FastAPI + PostgreSQL. Recebe medições, detecta alertas, agrega consumo diário (integração trapezoidal), calcula rateio por área e gera relatórios em PDF. | [`backend/README.md`](./backend/README.md) |
| **Frontend** | Dashboard estático (HTML + CSS + JS + Chart.js) com painéis por perfil: financeiro e manutenção. | [`frontend/README.md`](./frontend/README.md) |
| **Infra (Nginx + Docker)** | Reverse proxy roteando `/api/` para o backend, TLS via Certbot, orquestração via Docker Compose. | [`nginx/`](./nginx), [`docker-compose.yml`](./docker-compose.yml) |

Visão detalhada do projeto, ODS alinhados e fluxo completo do rateio: veja [`frontend/ABOUT.md`](./frontend/ABOUT.md).

---

## 🗺️ Hierarquia de dados

```
Local   (ex: Prédio ADM)
  └── Área    (ex: 1º Andar)
        └── Quadro   (ex: QLT-301)
              └── Dispositivo  (ex: ESP32_ADM1_A301)
                    └── Canal  (ex: Fase A)
                          ├── Medições (série temporal)
                          ├── Consumo Diário (kWh/dia)
                          └── Alertas
```

## 🚨 Alertas automáticos

Gerados pelo backend a cada medição recebida:

| Tipo | Condição | Nível |
|---|---|---|
| `sobrecorrente` | corrente > 40 A | crítico |
| `consumo_fora_horario` | corrente > 10 A fora de 06h–22h | aviso |
| `queda_brusca` | corrente caiu > 70% em relação à anterior | crítico |

## 📐 Fluxo do rateio mensal

```
1. ESP32 envia medições a cada 60s      → tabela medicoes
2. Job noturno (00:05) acumula kWh      → tabela consumo_diario
3. Usuário cadastra o valor da fatura   → tabela faturas
4. Backend calcula rateio por área      → tabela rateio

Fórmula:
  R$ área = (kWh área / kWh total medido) × valor da fatura
```

---

## 🛠️ Stack tecnológica

| Camada | Tecnologia |
|---|---|
| Hardware | ESP32 + SCT-013-030 + ZMPT101B |
| Firmware | C++ (Arduino framework) + EmonLib |
| Backend | Python 3.11 + FastAPI + SQLAlchemy |
| Banco de dados | PostgreSQL 18 |
| Scheduler | APScheduler |
| Relatórios PDF | ReportLab |
| Frontend | HTML + CSS + JavaScript (vanilla) |
| Gráficos | Chart.js 4 |
| Infra | Docker Compose + Nginx + Certbot |

---

## 🚀 Como rodar localmente

### Pré-requisitos
- Docker e Docker Compose
- Python 3.11+ (se for rodar o backend fora de container)

### Com Docker (recomendado)

```bash
git clone https://github.com/Julyxdias/EnergySafe.git
cd EnergySafe

cp example.env .env
# edite o .env com usuário, senha e nome do banco

docker compose up -d --build
```

O Nginx expõe o frontend na porta 80/443 e roteia `/api/` para o backend.

### Backend isolado

```bash
cd backend
python -m venv venv
source venv/bin/activate    # Windows: venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload
```

Detalhes completos de endpoints, variáveis de ambiente e integração com a Enel SP: [`backend/README.md`](./backend/README.md).

### Frontend isolado

```bash
cd frontend
python -m http.server 5500
```

Ajuste a constante `API_BASE` em cada `.js` para apontar para o backend local ou de produção. Detalhes: [`frontend/README.md`](./frontend/README.md).

---

## 🌐 Alinhamento com os ODS

- **ODS 7 — Energia limpa e acessível:** tornar o consumo visível e mensurável cria a base para decisões de eficiência energética e redução de desperdício.
- **ODS 12 — Consumo e produção responsáveis:** o rateio baseado em dados reais incentiva o uso consciente de energia por setor da instituição.

---

## 👥 Time

Projeto acadêmico desenvolvido como sistema aplicado.

| Papel | Responsabilidade |
|---|---|---|
| Hardware & Firmware | Sensores, ESP32, calibração, buffer SD | Giovanna Hototian |
| Backend | API FastAPI, banco de dados, alertas, rateio | Julya Dias |
| Frontend | Dashboard, gráficos, exportação, UX | Karolaine Helena |

---

## 📜 Licença

MIT — livre para uso, modificação e distribuição. Veja [`LICENSE`](./LICENSE).
