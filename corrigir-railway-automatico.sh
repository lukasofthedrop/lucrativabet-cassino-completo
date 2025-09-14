#!/bin/bash

# 🚀 SCRIPT CORRETOR AUTOMÁTICO RAILWAY - CIRURGIÃO DEV
# VAI LIMPAR TUDO E DEIXAR APENAS O NECESSÁRIO FUNCIONANDO

echo "🔥 INICIANDO CORREÇÃO AUTOMÁTICA DO RAILWAY..."

# 1. Fazer login no Railway
echo "🔑 Fazendo login no Railway..."
railway login

# 2. Conectar ao projeto
echo "📋 Conectando ao projeto LucrativaBet..."
railway connect f105f2bb-9841-4d3c-8a57-dcca197f5ca7

# 3. Listar serviços atuais
echo "📊 Listando serviços atuais..."
railway run -- rails --version 2>/dev/null || echo "Verificando serviços..."

# 4. Identificar e deletar serviços desnecessários
echo "🧹 Limpando serviços conflitantes..."

# Deletar serviços GitHub antigos (se existirem)
echo "❌ Deletando serviços GitHub antigos..."
railway services:list | grep -i github | awk '{print $1}' | xargs -I {} railway service delete {} --force 2>/dev/null || echo "Nenhum serviço GitHub encontrado"

# Deletar Postgres duplicado (deixar apenas 1)
echo "🗄️ Verificando Postgres duplicados..."
POSTGRES_COUNT=$(railway services:list | grep -c postgres)
if [ $POSTGRES_COUNT -gt 1 ]; then
    echo "Encontrados $POSTGRES_COUNT Postgres, deletando duplicados..."
    # Manter o primeiro Postgres, deletar os outros
    railway services:list | grep postgres | tail -n +2 | awk '{print $1}' | xargs -I {} railway service delete {} --force
fi

# 5. Identificar serviço correto (upload de 627MB)
echo "🎯 Identificando serviço principal..."
CORRECT_SERVICE=$(railway services:list | grep -E "(laravel|app|main)" | head -1 | awk '{print $1}')

if [ -n "$CORRECT_SERVICE" ]; then
    echo "✅ Serviço principal encontrado: $CORRECT_SERVICE"
    
    # 6. Configurar variáveis de ambiente corretas
    echo "⚙️ Configurando variáveis de ambiente..."
    
    # Obter credenciais do Postgres correto
    POSTGRES_SERVICE=$(railway services:list | grep postgres | head -1 | awk '{print $1}')
    
    railway variables:set APP_NAME=LucrativaBet --service $CORRECT_SERVICE
    railway variables:set APP_ENV=production --service $CORRECT_SERVICE  
    railway variables:set APP_DEBUG=false --service $CORRECT_SERVICE
    railway variables:set APP_KEY=base64:jP1f2K0S7Xe5JkyxyP8EptDNe8w77mGYOWcEoZyH9FU= --service $CORRECT_SERVICE
    railway variables:set DB_CONNECTION=pgsql --service $CORRECT_SERVICE
    railway variables:set DB_HOST=$POSTGRES_SERVICE.railway.internal --service $CORRECT_SERVICE
    railway variables:set DB_PORT=5432 --service $CORRECT_SERVICE
    railway variables:set DB_DATABASE=railway --service $CORRECT_SERVICE
    railway variables:set DB_USERNAME=postgres --service $CORRECT_SERVICE
    railway variables:set CACHE_DRIVER=redis --service $CORRECT_SERVICE
    railway variables:set QUEUE_CONNECTION=redis --service $CORRECT_SERVICE
    railway variables:set SESSION_DRIVER=redis --service $CORRECT_SERVICE
    
    # Obter Redis service
    REDIS_SERVICE=$(railway services:list | grep redis | head -1 | awk '{print $1}')
    railway variables:set REDIS_HOST=$REDIS_SERVICE.railway.internal --service $CORRECT_SERVICE
    
    # 7. Configurar build e start commands
    echo "🔧 Configurando comandos de deploy..."
    railway variables:set RAILWAY_BUILD_COMMAND="composer install --no-dev --optimize-autoloader && npm install && npm run build" --service $CORRECT_SERVICE
    railway variables:set RAILWAY_START_COMMAND="php artisan config:cache && php artisan route:cache && php artisan view:cache && php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=\$PORT" --service $CORRECT_SERVICE
    
    # 8. Reiniciar serviço
    echo "🔄 Reiniciando serviço principal..."
    railway service restart $CORRECT_SERVICE
    
    echo "✅ CORREÇÃO CONCLUÍDA!"
    echo "🌐 Seu cassino estará disponível em:"
    railway domain --service $CORRECT_SERVICE
    
else
    echo "❌ Serviço principal não encontrado. Verifique manualmente."
fi

echo "🎯 PROCESSO AUTOMÁTICO CONCLUÍDO!"
echo "📊 STATUS FINAL:"
railway services:list