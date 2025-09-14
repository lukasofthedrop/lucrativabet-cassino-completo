#!/bin/bash

# 🚀 SCRIPT AUTOMÁTICO DEPLOY COMPLETO - LUCRATIVABET
# CIRURGIÃO DEV - 13/09/2025

echo "🔥 INICIANDO DEPLOY COMPLETO AUTOMATIZADO..."

# 1. Verificar se gh CLI está instalado
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI não encontrado. Instalando..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install gh
    else
        echo "❌ Instale o GitHub CLI manualmente: https://cli.github.com/"
        exit 1
    fi
fi

# 2. Fazer login no GitHub
echo "🔑 Fazendo login no GitHub..."
gh auth login

# 3. Criar repositório
echo "📁 Criando repositório lucrativabet-cassino-completo..."
gh repo create lucrativabet-cassino-completo --public --description "Cassino LucrativaBet 100% funcional - Laravel + Filament + PostgreSQL + Redis" --source=. --remote=origin --push

# 4. Verificar se Railway CLI está instalado
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI não encontrado. Instalando..."
    npm install -g @railway/cli
fi

# 5. Login no Railway
echo "🚂 Fazendo login no Railway..."
railway login

# 6. Selecionar projeto
echo "📋 Selecionando projeto Railway..."
railway project f105f2bb-9841-4d3c-8a57-dcca197f5ca7

# 7. Limpar serviços antigos
echo "🧹 Limpando serviços antigos..."
railway services:list | grep -E "(laravel-app|laravel-simple)" | awk '{print $2}' | xargs -I {} railway service delete {} --force

# 8. Criar novo serviço do GitHub
echo "🚀 Criando novo serviço do GitHub..."
railway service create github --repo https://github.com/$(gh api user | jq -r '.login')/lucrativabet-cassino-completo.git --branch main

# 9. Configurar variáveis de ambiente
echo "⚙️ Configurando variáveis de ambiente..."
railway variables:set APP_NAME=LucrativaBet
railway variables:set APP_ENV=production
railway variables:set APP_DEBUG=false
railway variables:set APP_KEY=base64:jP1f2K0S7Xe5JkyxyP8EptDNe8w77mGYOWcEoZyH9FU=
railway variables:set DB_CONNECTION=pgsql
railway variables:set DB_HOST=postgres.railway.internal
railway variables:set DB_PORT=5432
railway variables:set DB_DATABASE=railway
railway variables:set DB_USERNAME=postgres
railway variables:set DB_PASSWORD=pdqICDEcbrkwwBgtSBLiABntPtUWSQYh
railway variables:set CACHE_DRIVER=redis
railway variables:set QUEUE_CONNECTION=redis
railway variables:set SESSION_DRIVER=redis
railway variables:set REDIS_HOST=redis.railway.internal
railway variables:set REDIS_PASSWORD=wzFBxeltNhQvXEBTMgLSMuRuexDaZRYU

# 10. Configurar build e start commands
echo "🔧 Configurando build e start commands..."
railway variables:set RAILWAY_BUILD_COMMAND="composer install --no-dev --optimize-autoloader && npm install && npm run build"
railway variables:set RAILWAY_START_COMMAND="php artisan config:cache && php artisan route:cache && php artisan view:cache && php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=\$PORT"

# 11. Disparar deploy
echo "🚀 Disparando deploy..."
railway up

# 12. Monitorar deploy
echo "🔍 Monitorando deploy..."
railway logs --follow

echo "✅ DEPLOY CONCLUÍDO!"
echo "🌐 URL do seu cassino: $(railway domain)"
echo "🔐 URL do admin: $(railway domain)/admin"