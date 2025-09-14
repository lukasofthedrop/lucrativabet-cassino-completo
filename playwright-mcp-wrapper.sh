#!/bin/bash

# Playwright MCP Wrapper Script
# Executa o servidor MCP Playwright usando Smithery CLI

set -e

# Verifica se o Node.js está instalado
if ! command -v node &> /dev/null; then
    echo "Erro: Node.js não encontrado. Por favor, instale o Node.js."
    exit 1
fi

# Executa o servidor MCP Playwright usando Smithery CLI
exec npx -y @smithery/cli@latest run @microsoft/playwright-mcp --key b6ba40fa-b3bc-4b7b-b549-7b70f59eb0fb "$@"