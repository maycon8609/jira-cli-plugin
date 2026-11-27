#!/usr/bin/env bash
set -euo pipefail

BIN_DEST="$HOME/.local/bin/jira"
SKILL_DEST="$HOME/.gemini/config/skills/jira"

echo "=== Uninstalling jira-cli-plugin ==="

if [ -L "$BIN_DEST" ]; then
  rm "$BIN_DEST"
  echo "✓ Executable symlink $BIN_DEST removed."
  if [ -f "$BIN_DEST.bak" ]; then
    mv "$BIN_DEST.bak" "$BIN_DEST"
    echo "✓ Previous backup restored at $BIN_DEST."
  fi
fi

if [ -L "$SKILL_DEST" ]; then
  rm "$SKILL_DEST"
  echo "✓ Skill symlink $SKILL_DEST removed."
fi

if [ -L "$HOME/.agents/skills/jira" ]; then
  rm "$HOME/.agents/skills/jira"
  echo "✓ Skill symlink $HOME/.agents/skills/jira removed."
fi

echo "Uninstallation completed."
