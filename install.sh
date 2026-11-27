#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_SRC="$DIR/bin/jira"
BIN_DEST="$HOME/.local/bin/jira"
SKILL_SRC="$DIR/skills/jira"
SKILL_DEST="$HOME/.gemini/config/skills/jira"

echo "=== Installing jira-cli-plugin ==="

# 1. Check Python 3
if ! command -v python3 &>/dev/null; then
  echo "Error: Python 3 is required to run the Jira CLI." >&2
  exit 1
fi

# 2. Install executable in ~/.local/bin
mkdir -p "$HOME/.local/bin"
if [ -e "$BIN_DEST" ] && [ ! -L "$BIN_DEST" ]; then
  echo "Backing up existing file to $BIN_DEST.bak..."
  mv "$BIN_DEST" "$BIN_DEST.bak"
fi
ln -sf "$BIN_SRC" "$BIN_DEST"
chmod +x "$BIN_SRC" "$BIN_DEST"
echo "✓ Executable 'jira' linked at $BIN_DEST"

# 3. Install skill for Antigravity / Gemini CLI and ~/.agents
if [ -d "$HOME/.gemini/config/skills" ]; then
  ln -sfn "$SKILL_SRC" "$SKILL_DEST"
  echo "✓ Skill 'jira' linked at $SKILL_DEST"
fi

if [ -d "$HOME/.agents/skills" ]; then
  ln -sfn "$SKILL_SRC" "$HOME/.agents/skills/jira"
  echo "✓ Skill 'jira' linked at $HOME/.agents/skills/jira"
fi

# 4. Check PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  echo ""
  echo "Tip: Add ~/.local/bin to your PATH if not already present:"
  echo '  export PATH="$HOME/.local/bin:$PATH"'
fi

echo ""
echo "Installation completed successfully!"
echo "To configure your Jira credentials, simply run:"
echo "  jira --config"
