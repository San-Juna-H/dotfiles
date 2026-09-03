#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH= cd "$(dirname "$0")" && pwd)"
OS="$(uname -s)"

step() {
  printf '\n==> %s\n' "$1"
}

load_brew() {
  for brew_path in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    if [ -x "$brew_path" ]; then
      eval "$("$brew_path" shellenv)"
      return
    fi
  done
  command -v brew >/dev/null 2>&1
}

link_file() {
  src="$1"
  dest="$2"

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    return
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    backup="${dest}.backup.$(date +%Y%m%d-%H%M%S)"
    mv "$dest" "$backup"
    printf 'backed up: %s\n' "$backup"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  printf 'linked: %s -> %s\n' "$dest" "$src"
}

step "Homebrew"
if ! load_brew; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  load_brew
fi

step "Packages"
brew bundle install --file="$ROOT/Brewfile" --no-upgrade
uv python install --default

step "Dotfiles"
link_file "$ROOT/.zshrc" "$HOME/.zshrc"
link_file "$ROOT/.p10k.zsh" "$HOME/.p10k.zsh"
link_file "$ROOT/.vimrc" "$HOME/.vimrc"

if [ "$OS" = "Linux" ]; then
  link_file "$ROOT/.config/pip/pip.conf" "$HOME/.config/pip/pip.conf"
  line='eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"'
  touch "$HOME/.bashrc"
  grep -Fqx "$line" "$HOME/.bashrc" || printf '\n%s\n' "$line" >> "$HOME/.bashrc"
fi

if [ "$OS" = "Darwin" ]; then
  link_file "$ROOT/.config/pip/pip.conf" "$HOME/Library/Application Support/pip/pip.conf"
fi

step "Vim plugins"
plug_path="$HOME/.vim/autoload/plug.vim"
if [ ! -f "$plug_path" ]; then
  curl -fLo "$plug_path" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
vim -Nu "$ROOT/.vimrc" -n -es '+PlugInstall --sync' '+qall'

printf '\nDone. Restart your terminal.\n'
