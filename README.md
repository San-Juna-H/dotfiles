# Dotfiles

Personal setup for macOS and Linux.

## Install

```sh
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
sh install.sh
```

## What It Does

- Installs Homebrew if missing
- Installs `zsh` on Linux
- Installs `tmux`, `uv`, Powerlevel10k, zsh-autosuggestions, and zsh-syntax-highlighting
- Installs a uv-managed default Python
- Links `.zshrc`, `.p10k.zsh`, `.vimrc`, and pip config into `$HOME`
- Bootstraps `vim-plug` and installs configured Vim plugins on first Vim launch
- Adds Linuxbrew to `~/.bashrc` on Linux so `zsh` is found in new bash sessions

## Files

- `install.sh`
- `.zshrc`
- `.p10k.zsh`
- `.config/pip/pip.conf`
- `.vimrc`

Do not commit secrets, local credentials, or Git identity settings.
