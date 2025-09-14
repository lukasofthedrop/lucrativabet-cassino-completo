# 🚀 GUIA DEPLOY MANUAL RAILWAY - LUCRATIVABET

## 📋 SITUAÇÃO ATUAL
✅ **PROJETO LIMPO E OTIMIZADO**
- Arquivos de backup removidos (5.4MB + 524KB)
- Repositório Git limpo e atualizado
- Railway PRO configurado com todos os serviços
- Variáveis de ambiente configuradas

## 🔧 CONFIGURAÇÕES RAILWAY

### Project ID: `f105f2bb-9841-4d3c-8a57-dcca197f5ca7`
### Environment: `production`
### Services:
- **laravel-app** (ID: a7f633b8-49af-46a8-8de3-5b9a71e9cabc)
- **Postgres** (ID: 5a9c1e32-ef31-4f6e-9880-7016a0b7f5f6)  
- **Redis** (ID: b4286ecf-92af-4d10-9817-cf8504ea84ad)

## 🌐 URL DO PROJETO
https://laravel-app-production-a014.up.railway.app

## 📝 PASSO A PASSO PARA DEPLOY MANUAL

### 1. CONECTAR REPOSITÓRIO GITHUB AO RAILWAY
```bash
# No painel Railway do seu projeto:
# 1. Clique em "Settings"
# 2. Clique em "GitHub" 
# 3. Conecte seu repositório lucrativabet
# 4. Selecione a branch "main"
```

### 2. CONFIGURAR VARIÁVEIS DE AMBIENTE
As variáveis já estão configuradas no serviço, mas verifique:

```bash
# Variáveis críticas já configuradas:
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
REDIS_HOST=redis.railway.internal
REDIS_PASSWORD=wzFBxeltNhQvXEBTMgLSMuRuexDaZRYU
```

### 3. CONFIGURAR BUILD COMMAND
No painel Railway > Settings > Build:
```bash
Build Command: composer install --no-dev && npm install && npm run build
```

### 4. CONFIGURAR START COMMAND  
```bash
Start Command: php artisan serve --host=0.0.0.0 --port=$PORT
```

### 5. RODAR MIGRAÇÕES AUTOMATICAMENTE
Adicione este comando ao Start Command:
```bash
php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=$PORT
```

### 6. VERIFICAR HEALTH CHECK
- **Health Check Path**: `/`
- **Health Check Timeout**: `30`

## 🔍 VERIFICAÇÃO PÓS-DEPLOY

### 1. ACESSAR O SITE
URL: https://laravel-app-production-a014.up.railway.app

### 2. ACESSAR PAINEL ADMIN
URL: https://laravel-app-production-a014.up.railway.app/admin

### 3. VERIFICAR LOGS SE NECESSÁRIO
No painel Railway > Logs

## 🚨 SOLUÇÃO DE PROBLEMAS

### PROBLEMA: Build falha por falta de dependências
**SOLUÇÃO**: Verificar se o build command inclui npm install e npm run build

### PROBLEMA: Banco de dados não conecta
**SOLUÇÃO**: Verificar variáveis DB_* e se o serviço Postgres está rodando

### PROBLEMA: Assets não carregam
**SOLUÇÃO**: Rodar `php artisan asset:publish` e `php artisan view:clear`

### PROBLEMA: Permissões de arquivo
**SOLUÇÃO**: Adicionar comandos de permissão no build:
```bash
chmod -R 775 storage bootstrap/cache
```

## 📊 TAMANHO DO PROJETO
- **Total**: 2.1GB (compactado no push Git será menor)
- **node_modules**: 160MB
- **vendor**: 161MB  
- **public**: 347MB
- **Código-fonte**: ~8MB

## ✅ CHECKLIST FINAL

- [ ] Repositório GitHub conectado ao Railway
- [ ] Variáveis de ambiente configuradas
- [ ] Build command correto
- [ ] Start command correto
- [ ] Health check configurado
- [ ] Deploy realizado com sucesso
- [ ] Site acessível na URL
- [ ] Painel admin funcionando
- [ ] Banco de dados migrado

---

## 🎯 RESULTADO ESPERADO

Após seguir todos os passos, seu cassino LucrativaBet estará:
- ✅ 100% online na Railway
- ✅ Com painel admin funcional
- ✅ Banco de dados PostgreSQL configurado
- ✅ Cache Redis otimizado
- ✅ Todos os jogos e funcionalidades operando

---

*Gerado por CIRURGIÃO DEV em 13/09/2025*