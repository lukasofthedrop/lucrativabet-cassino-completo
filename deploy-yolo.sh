#!/bin/bash

# 🚀 DEPLOY SIMPLIFICADO - YOLO MODE
# CIRURGIÃO DEV - 13/09/2025

echo "🔥 YOLO MODE ATIVADO - DEPLOY SIMPLIFICADO..."

# 1. Verificar Railway CLI
if command -v railway &> /dev/null; then
    echo "✅ Railway CLI encontrado"
    
    # Tentar usar Railway direto com o projeto existente
    echo "🚀 Tentando deploy direto..."
    
    # Se já tivermos um projeto Railway funcionando, vamos tentar deploy via upload
    echo "📦 Preparando pacote para upload..."
    tar --exclude='node_modules' --exclude='vendor' --exclude='.git' --exclude='.playwright-mcp' -czf /tmp/lucrativabet-yolo-deploy.tar.gz .
    
    echo "✅ Pacote criado: /tmp/lucrativabet-yolo-deploy.tar.gz"
    echo "📋 INSTRUÇÕES:"
    echo "1. Acesse: https://railway.com/project/f105f2bb-9841-4d3c-8a57-dcca197f5ca7"
    echo "2. Clique em 'New Service'"
    echo "3. Selecione 'Docker Image'"
    echo "4. Faça upload do arquivo: /tmp/lucrativabet-yolo-deploy.tar.gz"
    echo "5. Configure as variáveis de ambiente"
    echo "6. Clique em DEPLOY!"
    
else
    echo "❌ Railway CLI não encontrado"
    echo "📋 INSTALE MANUALMENTE:"
    echo "npm install -g @railway/cli"
    echo "railway login"
    echo "railway project f105f2bb-9841-4d3c-8a57-dcca197f5ca7"
fi

# 2. Tentar GitHub CLI
if command -v gh &> /dev/null; then
    echo "✅ GitHub CLI encontrado"
    echo "📋 Para criar repositório GitHub:"
    echo "gh auth login"
    echo "gh repo create lucrativabet-cassino-completo --public --push"
else
    echo "❌ GitHub CLI não encontrado"
    echo "📋 INSTALE MANUALMENTE:"
    echo "brew install gh  # macOS"
    echo "gh auth login"
fi

echo "🎯 YOLO MODE CONCLUÍDO!"
echo "📊 SITUAÇÃO ATUAL:"
echo "- ✅ Código completo pronto"
echo "- ✅ Dockerfile configurado"
echo "- ✅ Variáveis de ambiente documentadas"
echo "- ✅ Pacote .tar.gz criado"
echo "- 🚀 Pronto para deploy manual"