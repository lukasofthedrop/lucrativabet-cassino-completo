#!/bin/bash

# ========================================
#   DEPLOY RAILWAY - LUCRATIVABET
#   Por: ULTRATHINK
#   Deploy automatizado para Railway
# ========================================

set -e

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}   DEPLOY RAILWAY - LUCRATIVABET${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# 1. Verificar se Railway CLI está instalado
echo -e "${YELLOW}[1/8] Verificando Railway CLI...${NC}"
if ! command -v railway &> /dev/null; then
    echo -e "${RED}Railway CLI não instalado. Instalando...${NC}"
    curl -fsSL https://railway.app/install.sh | sh
fi
echo -e "${GREEN}✅ Railway CLI disponível${NC}"

# 2. Login no Railway (se necessário)
echo -e "${YELLOW}[2/8] Verificando autenticação Railway...${NC}"
railway whoami || railway login
echo -e "${GREEN}✅ Autenticado no Railway${NC}"

# 3. Gerar APP_KEY se não existir
echo -e "${YELLOW}[3/8] Gerando APP_KEY...${NC}"
if [ ! -f .env ]; then
    cp .env.railway .env
fi
php artisan key:generate --show
echo -e "${GREEN}✅ APP_KEY gerada${NC}"

# 4. Preparar build local
echo -e "${YELLOW}[4/8] Preparando build local...${NC}"
composer install --no-dev --optimize-autoloader
npm ci
npm run build
echo -e "${GREEN}✅ Build preparado${NC}"

# 5. Adicionar arquivos ao Git
echo -e "${YELLOW}[5/8] Preparando commit...${NC}"
git add railway.json nixpacks.toml Procfile .env.railway
git commit -m "🚀 Configuração Railway - Deploy LucrativaBet" || true
echo -e "${GREEN}✅ Arquivos commitados${NC}"

# 6. Criar novo projeto Railway (se não existir)
echo -e "${YELLOW}[6/8] Criando projeto Railway...${NC}"
railway init -n lucrativabet || echo "Projeto já existe"
echo -e "${GREEN}✅ Projeto Railway configurado${NC}"

# 7. Adicionar banco MySQL
echo -e "${YELLOW}[7/8] Provisionando MySQL...${NC}"
railway add mysql || echo "MySQL já existe"
echo -e "${GREEN}✅ MySQL provisionado${NC}"

# 8. Deploy
echo -e "${YELLOW}[8/8] Fazendo deploy...${NC}"
railway up
echo -e "${GREEN}✅ Deploy iniciado${NC}"

# Obter URL do deploy
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}   DEPLOY CONCLUÍDO!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${BLUE}📌 INFORMAÇÕES DO DEPLOY:${NC}"
railway status
echo ""
echo -e "${YELLOW}⚠️ PRÓXIMOS PASSOS:${NC}"
echo "1. Acessar dashboard Railway: https://railway.app/dashboard"
echo "2. Configurar variáveis de ambiente no painel"
echo "3. Adicionar domínio customizado (opcional)"
echo "4. Adicionar IP na whitelist PlayFiver"
echo ""
echo -e "${GREEN}✨ Deploy finalizado!${NC}"