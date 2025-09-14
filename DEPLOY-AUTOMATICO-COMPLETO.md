# 🚀 DEPLOY COMPLETO AUTOMÁTICO - PASSO A PASSO

## OPÇÃO 1: SCRIPT AUTOMÁTICO (RECOMENDADO)
```bash
# Execute este comando no terminal:
./deploy-completo-automatico.sh
```

O script vai:
1. ✅ Instalar GitHub CLI se necessário
2. ✅ Fazer login no GitHub
3. ✅ Criar repositório `lucrativabet-cassino-completo`
4. ✅ Enviar todo o código
5. ✅ Instalar Railway CLI
6. ✅ Login no Railway
7. ✅ Limpar serviços antigos
8. ✅ Criar novo serviço do GitHub
9. ✅ Configurar todas as variáveis
10. ✅ Disparar deploy automatico
11. ✅ Monitorar o deploy

## OPÇÃO 2: PASSOS MANUAIS

### 1. Instalar ferramentas:
```bash
# GitHub CLI
brew install gh  # macOS
# ou https://cli.github.com/

# Railway CLI  
npm install -g @railway/cli
```

### 2. Fazer logins:
```bash
gh auth login
railway login
```

### 3. Criar repositório e enviar:
```bash
gh repo create lucrativabet-cassino-completo --public --push
```

### 4. Configurar Railway:
```bash
railway project f105f2bb-9841-4d3c-8a57-dcca197f5ca7
railway service create github --repo https://github.com/SEU_USER/lucrativabet-cassino-completo.git
```

### 5. Configurar variáveis:
```bash
railway variables:set APP_NAME=LucrativaBet
railway variables:set APP_ENV=production
# ... (todas as outras variáveis)
```

## 📋 VARIÁVEIS DE AMBIENTE COMPLETAS:
```
APP_NAME=LucrativaBet
APP_ENV=production
APP_DEBUG=false
APP_KEY=base64:jP1f2K0S7Xe5JkyxyP8EptDNe8w77mGYOWcEoZyH9FU=
DB_CONNECTION=pgsql
DB_HOST=postgres.railway.internal
DB_PORT=5432
DB_DATABASE=railway
DB_USERNAME=postgres
DB_PASSWORD=pdqICDEcbrkwwBgtSBLiABntPtUWSQYh
CACHE_DRIVER=redis
QUEUE_CONNECTION=redis
SESSION_DRIVER=redis
REDIS_HOST=redis.railway.internal
REDIS_PASSWORD=wzFBxeltNhQvXEBTMgLSMuRuexDaZRYU
```

## 🎯 RESULTADO FINAL:
URL: https://lucrativabet-production.up.railway.app

**BASTA EXECUTAR O SCRIPT E TUDO SERÁ FEITO AUTOMATICAMENTE!** 🚀