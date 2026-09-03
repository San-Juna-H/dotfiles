# Dotfiles

Minimal shell, Vim, and Python setup for macOS and Linux.

## Install

```sh
git clone https://github.com/San-Juna-H/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The installer runs without confirmation prompts. It installs Homebrew when
needed, installs the packages in `Brewfile`, links the configuration files, and
installs Vim plugins. Existing link targets are moved to timestamped backup
files automatically.

The pip configuration rejects `pip install` outside a virtual environment. Use
a virtual environment or `uv`.

Git identity remains in the ignored `.gitconfig`. Do not commit secrets or
local credentials.
