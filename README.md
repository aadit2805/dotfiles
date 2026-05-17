# dotfiles

My macOS setup — shell, git, editor, tool configs.

## Setup on a new machine

```bash
gh repo clone aadit2805/dotfiles ~/Documents/dotfiles
~/Documents/dotfiles/install.sh
brew bundle --file ~/Documents/dotfiles/brew/Brewfile
xargs -n1 cursor install-extension < ~/Documents/dotfiles/editor/cursor/extensions.txt
```

Then update `git/gitconfig` with the right email and generate a signing key:

```bash
ssh-keygen -t ed25519 -C "you@work.com" -f ~/.ssh/id_ed25519_signing
```

## Not included (set up fresh)

`~/.ssh/`, `~/.git-credentials`, `~/.netrc`, `~/.npmrc`,
`~/.codex/auth.json`, `~/.config/gh/hosts.yml`.
