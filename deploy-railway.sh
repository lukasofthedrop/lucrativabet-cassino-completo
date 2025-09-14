#!/bin/bash

# 🚀 SCRIPT DEPLOY AUTOMÁTICO RAILWAY - LUCRATIVABET
# CIRURGIÃO DEV - 13/09/2025

echo "🔥 INICIANDO DEPLOY AUTOMATIZADO LUCRATIVABET..."

# 1. Verificar se Railway CLI está instalado
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI não encontrado. Instalando..."
    npm install -g @railway/cli
fi

# 2. Login no Railway (se necessário)
echo "🔑 Verificando login Railway..."
railway whoami || railway login

# 3. Selecionar projeto
echo "📁 Selecionando projeto LucrativaBet-Producao..."
railway project f105f2bb-9841-4d3c-8a57-dcca197f5ca7

# 4. Selecionar ambiente
echo "🌍 Selecionando ambiente production..."
railway environment production

# 5. Adicionar variáveis de ambiente se não existirem
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
railway variables:set CACHE_DRIVER=redis
railway variables:set QUEUE_CONNECTION=redis
railway variables:set SESSION_DRIVER=redis
railway variables:set REDIS_HOST=redis.railway.internal

# 6. Configurar build command
echo "🔧 Configurando build command..."
railway build

# 7. Fazer upload dos arquivos
echo "📤 Enviando arquivos para o Railway..."
railway up

# 8. Verificar status do deploy
echo "🔍 Verificando status do deploy..."
railway status

# 9. Abrir o projeto no navegador
echo "🌐 Abrindo projeto no navegador..."
railway open

echo "✅ DEPLOY CONCLUÍDO!"
echo "📱 URL do seu projeto: https://laravel-app-production-a014.up.railway.app"
echo "🔐 URL do admin: https://laravel-app-production-a014.up.railway.app/admin"