#!/usr/bin/env bash
set -euo pipefail

BIN_DEST="$HOME/.local/bin/jira"
SKILL_DEST="$HOME/.gemini/config/skills/jira"

echo "=== Desinstalando jira-cli-plugin ==="

if [ -L "$BIN_DEST" ]; then
  rm "$BIN_DEST"
  echo "✓ Link do executável $BIN_DEST removido."
  if [ -f "$BIN_DEST.bak" ]; then
    mv "$BIN_DEST.bak" "$BIN_DEST"
    echo "✓ Backup anterior restaurado em $BIN_DEST."
  fi
fi

if [ -L "$SKILL_DEST" ]; then
  rm "$SKILL_DEST"
  echo "✓ Link da skill $SKILL_DEST removido."
fi

if [ -L "$HOME/.agents/skills/jira" ]; then
  rm "$HOME/.agents/skills/jira"
  echo "✓ Link da skill $HOME/.agents/skills/jira removido."
fi

echo "Desinstalação concluída."
