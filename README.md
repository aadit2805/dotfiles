# dotfiles

My macOS setup — shell, git, editor, tool configs.

## Setup on a new machine

```bash
gh repo clone aadit2805/dotfiles ~/Documents/dotfiles
~/Documents/dotfiles/bootstrap.sh
```

`bootstrap.sh` installs Homebrew, symlinks dotfiles, runs `brew bundle`,
sets modern bash as the default shell, installs nvm/bun/cargo/uv, and
fetches `z.sh` + `git-completion.bash`. Safe to re-run.

## Notes to self

**Same identity, new laptop** (personal email on work machine):
1. `ssh-keygen -t ed25519 -C "aadit2805@gmail.com" -f ~/.ssh/id_ed25519_signing`
2. Add the new pubkey to GitHub → SSH and GPG keys → **Signing Key**
3. Append the pubkey line to `git/config/allowed_signers` (keep old lines too)
4. Fresh logins: `gh auth login`, Claude Code, Codex

**Work identity, new laptop**: same as above, but first edit `git/gitconfig`
to swap `email` and `name`, and use the work email in the `ssh-keygen -C` flag.

**Font**: Ghostty config uses Berkeley Mono Trial — install separately or
edit `editor/ghostty/config` to use a free font.

## Not included (set up fresh)

`~/.ssh/`, `~/.git-credentials`, `~/.netrc`, `~/.npmrc`,
`~/.codex/auth.json`, `~/.config/gh/hosts.yml`.
