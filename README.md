# dotfiles

Personal config for setting up a new Mac. Aimed at a work-machine setup —
nothing here references personal infra/credentials.

## Contents

```
shell/         zsh + bash configs, aliases, exports, functions
git/           gitconfig, global gitignore, allowed_signers
editor/
  vim/         vimrc
  vscode/      settings.json + extensions list
  cursor/      settings.json, keybindings, extensions list
  ghostty/     terminal config
  tmux.conf
tools/
  claude/      Claude Code settings (no auth — log in fresh)
  codex/       Codex config.toml (no auth)
brew/          Brewfile of installed CLI tools + apps
```

## Install on a new machine

```bash
git clone <this-repo> ~/Documents/dotfiles
cd ~/Documents/dotfiles
./install.sh
```

The script symlinks each file into `$HOME` so future edits in the repo
take effect immediately.

## Before first use — review

- **`git/gitconfig`** — email is `aadit2805@gmail.com` and signing key path
  points at `~/.ssh/id_ed25519_signing.pub`. For work, swap the email and
  generate a new signing key:
  ```bash
  ssh-keygen -t ed25519 -C "you@work.com" -f ~/.ssh/id_ed25519_signing
  ```
  Then update `git/config/allowed_signers` with the new pubkey.
- **`brew/Brewfile`** — review and remove anything you don't want on the
  work machine before running `brew bundle`.
- **VS Code / Cursor extensions** — extensions are listed in
  `editor/{vscode,cursor}/extensions.txt`; install with the snippet below.

## Install Homebrew packages

```bash
cd ~/Documents/dotfiles/brew
brew bundle
```

## Install editor extensions

```bash
xargs -n1 code   install-extension < ~/Documents/dotfiles/editor/vscode/extensions.txt
xargs -n1 cursor install-extension < ~/Documents/dotfiles/editor/cursor/extensions.txt
```

## What is intentionally NOT in this repo

These contain secrets or are machine-specific — set them up fresh:

- `~/.ssh/` (private keys)
- `~/.git-credentials`, `~/.netrc`, `~/.npmrc`
- `~/.codex/auth.json`, `~/.config/gh/hosts.yml` (OAuth tokens)
- shell histories, caches, large data dirs
