# dotfiles

My macOS setup — shell, git, editor, tool configs.

## Setup on a new machine

```bash
gh repo clone aadit2805/dotfiles ~/Documents/dotfiles
~/Documents/dotfiles/install.sh
brew bundle --file ~/Documents/dotfiles/brew/Brewfile
xargs -n1 cursor install-extension < ~/Documents/dotfiles/editor/cursor/extensions.txt
```

## Notes to self

**Same identity, new laptop** (personal email on work machine):
1. `ssh-keygen -t ed25519 -C "aadit2805@gmail.com" -f ~/.ssh/id_ed25519_signing`
2. Add the new pubkey to GitHub → SSH and GPG keys → **Signing Key**
3. Append the pubkey line to `git/config/allowed_signers` (keep old lines too)
4. Fresh logins: `gh auth login`, Claude Code, Codex

**Work identity, new laptop**: same as above, but first edit `git/gitconfig`
to swap `email` and `name`, and use the work email in the `ssh-keygen -C` flag.

## Not included (set up fresh)

`~/.ssh/`, `~/.git-credentials`, `~/.netrc`, `~/.npmrc`,
`~/.codex/auth.json`, `~/.config/gh/hosts.yml`.
