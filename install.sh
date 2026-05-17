#!/usr/bin/env bash
# Symlink dotfiles from this repo into $HOME.
# Existing files are backed up to ~/.dotfiles-backup-<timestamp>/.

set -euo pipefail

DOT="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

link() {
    local src="$1"
    local dst="$2"
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mkdir -p "$BACKUP"
        mv "$dst" "$BACKUP/"
        echo "backed up: $dst -> $BACKUP/"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo "linked: $dst -> $src"
}

# --- shell ---
link "$DOT/shell/zshrc"          "$HOME/.zshrc"
link "$DOT/shell/zshenv"         "$HOME/.zshenv"
link "$DOT/shell/bashrc"         "$HOME/.bashrc"
link "$DOT/shell/bash_profile"   "$HOME/.bash_profile"
link "$DOT/shell/bash_prompt"    "$HOME/.bash_prompt"
link "$DOT/shell/bash-preexec.sh" "$HOME/.bash-preexec.sh"
link "$DOT/shell/profile"        "$HOME/.profile"
link "$DOT/shell/aliases"        "$HOME/.aliases"
link "$DOT/shell/exports"        "$HOME/.exports"
link "$DOT/shell/inputrc"        "$HOME/.inputrc"
link "$DOT/shell/functions"      "$HOME/.functions"

# --- git ---
link "$DOT/git/gitconfig"             "$HOME/.gitconfig"
link "$DOT/git/gitignore_global"      "$HOME/.gitignore_global"
link "$DOT/git/config/allowed_signers" "$HOME/.config/git/allowed_signers"
link "$DOT/git/config/ignore"         "$HOME/.config/git/ignore"

# --- editor ---
link "$DOT/editor/vim/vimrc"  "$HOME/.vimrc"
link "$DOT/editor/tmux.conf"  "$HOME/.tmux.conf"

VSCODE_USER="$HOME/Library/Application Support/Code/User"
CURSOR_USER="$HOME/Library/Application Support/Cursor/User"
GHOSTTY_CFG="$HOME/.config/ghostty"

[ -d "$VSCODE_USER" ] && link "$DOT/editor/vscode/settings.json" "$VSCODE_USER/settings.json"
[ -d "$CURSOR_USER" ] && link "$DOT/editor/cursor/settings.json" "$CURSOR_USER/settings.json"
[ -d "$CURSOR_USER" ] && link "$DOT/editor/cursor/keybindings.json" "$CURSOR_USER/keybindings.json"
link "$DOT/editor/ghostty/config" "$GHOSTTY_CFG/config"

# --- tools ---
link "$DOT/tools/claude/settings.json"       "$HOME/.claude/settings.json"
link "$DOT/tools/claude/settings.local.json" "$HOME/.claude/settings.local.json"
link "$DOT/tools/codex/config.toml"          "$HOME/.codex/config.toml"

echo ""
echo "done. backups (if any) in: $BACKUP"
