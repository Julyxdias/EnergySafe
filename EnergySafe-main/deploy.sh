#!/bin/bash
set -e

echo "🚀 Iniciando deploy do EnergySafe..."

# ── 1. Verifica dependências ──────────────────────────────────
if ! command -v docker &> /dev/null; then
  echo "❌ Docker não encontrado. Instale com: curl -fsSL https://get.docker.com | sh"
  exit 1
fi

if ! command -v docker compose &> /dev/null; then
  echo "❌ Docker Compose não encontrado."
  exit 1
fi

# ── 2. Verifica .env ──────────────────────────────────────────
if [ ! -f .env ]; then
  echo "❌ Arquivo .env não encontrado. Copie o example.env e preencha."
  exit 1
fi

# ── 3. Verifica backup ────────────────────────────────────────
BACKUP_FILE="backup_20260529.sql"
if [ ! -f "$BACKUP_FILE" ]; then
  echo "⚠️  Backup '$BACKUP_FILE' não encontrado na raiz do projeto."
  echo "    Coloque o arquivo aqui antes de continuar."
  exit 1
fi

# ── 4. Remove linhas incompatíveis do backup (\\restrict) ─────
echo "🧹 Limpando backup para importação..."
grep -v '\\restrict' "$BACKUP_FILE" > backup_limpo.sql

# ── 5. Sobe apenas o banco primeiro ──────────────────────────
echo "🐘 Subindo PostgreSQL..."
docker compose up -d db

# Aguarda o banco ficar saudável
echo "⏳ Aguardando banco ficar pronto..."
until docker compose exec db pg_isready -U "$(grep POSTGRES_USER .env | cut -d= -f2)" -d "$(grep POSTGRES_DB .env | cut -d= -f2)" &> /dev/null; do
  sleep 2
done
echo "✅ Banco pronto!"

# ── 6. Importa o backup ───────────────────────────────────────
echo "📥 Importando backup..."
docker compose exec -T db psql \
  -U "$(grep POSTGRES_USER .env | cut -d= -f2)" \
  -d "$(grep POSTGRES_DB .env | cut -d= -f2)" \
  < backup_limpo.sql

echo "✅ Backup importado com sucesso!"

# ── 7. Sobe o restante dos serviços ──────────────────────────
echo "🔧 Subindo backend e nginx..."
docker compose up -d --build

# ── 8. Limpeza ────────────────────────────────────────────────
rm -f backup_limpo.sql

# ── 9. Status final ───────────────────────────────────────────
echo ""
echo "✅ Deploy concluído!"
echo ""
docker compose ps
echo ""
echo "📋 Logs do backend:"
docker compose logs --tail=20 backend
