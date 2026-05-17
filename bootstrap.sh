#!/usr/bin/env bash
# Bootstrap a fresh Mac: install Homebrew, run install.sh, install runtime
# managers, set bash as the default shell, fetch helper scripts.
#
# Safe to re-run — each step skips if already done.
#
# Usage: ~/Documents/dotfiles/bootstrap.sh

set -euo pipefail

DOT="$(cd "$(dirname "$0")" && pwd)"

say() { printf "\n\033[1;34m==>\033[0m %s\n" "$*"; }
skip() { printf "    \033[2mskip:\033[0m %s\n" "$*"; }

# --- 1. Homebrew -------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
    say "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    skip "Homebrew already installed"
fi

# --- 2. Symlink dotfiles -----------------------------------------------------
say "Symlinking dotfiles"
"$DOT/install.sh"

# --- 3. Brewfile -------------------------------------------------------------
say "Installing Brewfile packages"
brew bundle --file "$DOT/brew/Brewfile"

# --- 4. Default shell: modern bash from Homebrew ----------------------------
BREW_BASH="/opt/homebrew/bin/bash"
if [ -x "$BREW_BASH" ]; then
    if ! grep -qx "$BREW_BASH" /etc/shells; then
        say "Adding $BREW_BASH to /etc/shells (sudo)"
        echo "$BREW_BASH" | sudo tee -a /etc/shells >/dev/null
    else
        skip "$BREW_BASH already in /etc/shells"
    fi
    if [ "$SHELL" != "$BREW_BASH" ]; then
        say "Setting default shell to $BREW_BASH"
        chsh -s "$BREW_BASH"
    else
        skip "Default shell already $BREW_BASH"
    fi
fi

# --- 5. Runtime managers -----------------------------------------------------
if [ ! -d "$HOME/.nvm" ]; then
    say "Installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
else
    skip "nvm already installed"
fi

if ! command -v bun >/dev/null 2>&1 && [ ! -d "$HOME/.bun" ]; then
    say "Installing bun"
    curl -fsSL https://bun.sh/install | bash
else
    skip "bun already installed"
fi

if ! command -v cargo >/dev/null 2>&1 && [ ! -d "$HOME/.cargo" ]; then
    say "Installing rust/cargo"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
    skip "rust/cargo already installed"
fi

if [ ! -f "$HOME/.local/bin/uv" ] && ! command -v uv >/dev/null 2>&1; then
    say "Installing uv"
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    skip "uv already installed"
fi

# --- 6. Helper scripts the shell sources ------------------------------------
if [ ! -f "$HOME/z.sh" ]; then
    say "Fetching z.sh"
    curl -fsSL https://raw.githubusercontent.com/rupa/z/master/z.sh -o "$HOME/z.sh"
else
    skip "~/z.sh already present"
fi

if [ ! -f "$HOME/.git-completion.bash" ]; then
    say "Fetching git-completion.bash"
    curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
        -o "$HOME/.git-completion.bash"
else
    skip "~/.git-completion.bash already present"
fi

say "Bootstrap complete. Open a new terminal."
echo "    Remaining manual steps (see README): SSH signing key, gh auth login,"
echo "    Claude/Codex logins, Berkeley Mono font (or change ghostty font)."
