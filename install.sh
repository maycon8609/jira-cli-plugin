#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_SRC="$DIR/bin/jira"
BIN_DEST="$HOME/.local/bin/jira"
SKILL_SRC="$DIR/skills/jira"
SKILL_DEST="$HOME/.gemini/config/skills/jira"

echo "=== Instalador do jira-cli-plugin ==="

# 1. Checa Python 3
if ! command -v python3 &>/dev/null; then
  echo "Erro: Python 3 é obrigatório para executar o CLI do Jira." >&2
  exit 1
fi

# 2. Instala binário no ~/.local/bin
mkdir -p "$HOME/.local/bin"
if [ -e "$BIN_DEST" ] && [ ! -L "$BIN_DEST" ]; then
  echo "Fazendo backup do arquivo existente para $BIN_DEST.bak..."
  mv "$BIN_DEST" "$BIN_DEST.bak"
fi
ln -sf "$BIN_SRC" "$BIN_DEST"
chmod +x "$BIN_SRC" "$BIN_DEST"
echo "✓ Executável 'jira' linkado em $BIN_DEST"

# 3. Instala skill no Antigravity / Gemini CLI e ~/.agents
if [ -d "$HOME/.gemini/config/skills" ]; then
  ln -sfn "$SKILL_SRC" "$SKILL_DEST"
  echo "✓ Skill 'jira' linkada em $SKILL_DEST"
fi

if [ -d "$HOME/.agents/skills" ]; then
  ln -sfn "$SKILL_SRC" "$HOME/.agents/skills/jira"
  echo "✓ Skill 'jira' linkada em $HOME/.agents/skills/jira"
fi

# 4. Verifica PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  echo ""
  echo "Dica: Adicione ~/.local/bin ao seu PATH se ainda não estiver configurado:"
  echo '  export PATH="$HOME/.local/bin:$PATH"'
fi

echo ""
echo "Instalação concluída com sucesso!"
echo "Para configurar suas credenciais do Jira, basta executar:"
echo "  jira --config"
