# 🚀 DEPLOY VIA DOCKER COMPOSE - LUCRATIVABET

## OPÇÃO 1: DOCKER HUB
1. Build local:
```bash
docker build -t lucrativabet-cassino .
docker tag lucrativabet-cassino:latest rkripto/lucrativabet-cassino:latest
docker push rkripto/lucrativabet-cassino:latest
```

2. No Railway:
- Criar serviço a partir da imagem: `rkripto/lucrativabet-cassino:latest`
- Configurar variáveis de ambiente

## OPÇÃO 2: RAILWAY COM GIT LOCAL
1. Comprimir projeto:
```bash
tar -czf lucrativabet-deploy.tar.gz --exclude=node_modules --exclude=vendor --exclude=.git .
```

2. Upload via Railway CLI:
```bash
railway login
railway project f105f2bb-9841-4d3c-8a57-dcca197f5ca7
railway up
```

## OPÇÃO 3: SUBIR PARA GITHUB NOVO
1. Criar novo repositório público
2. Fazer push do código
3. Conectar no Railway

## CONFIGURAÇÃO DAS VARIÁVEIS (após deploy):
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

## URL FINAL ESPERADA:
https://lucrativabet-cassino-production.up.railway.app