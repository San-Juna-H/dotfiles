#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH= cd "$(dirname "$0")" && pwd)"
OS="$(uname -s)"

die() {
  printf 'error: %s\n' "$1" >&2
  exit 1
}

step() {
  printf '\n==> %s\n' "$1"
}

brew_env() {
  for brew_path in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    [ -x "$brew_path" ] && eval "$("$brew_path" shellenv)" && return 0
  done

  command -v brew >/dev/null 2>&1
}

brew_install() {
  brew list "$1" >/dev/null 2>&1 || brew install "$1"
}

link() {
  mkdir -p "$(dirname "$2")"
  rm -f "$2"
  ln -s "$1" "$2"
}

ensure_line() {
  file="$1"
  line="$2"

  touch "$file"
  if ! grep -Fqx "$line" "$file"; then
    if [ -s "$file" ]; then
      printf '\n%s\n' "$line" >> "$file"
    else
      printf '%s\n' "$line" >> "$file"
    fi
  fi
}

case "$OS" in
  Darwin|Linux) ;;
  *) die "unsupported OS: $OS" ;;
esac

step "Homebrew"
if ! brew_env; then
  command -v curl >/dev/null 2>&1 || die "curl is required"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew_env || die "brew is not available after install"
fi

step "Packages"
[ "$OS" = "Linux" ] && brew_install zsh
brew_install tmux
brew_install uv
brew_install powerlevel10k
brew_install zsh-autosuggestions
brew_install zsh-syntax-highlighting

step "Python"
uv python install --default

step "Dotfiles"
link "$ROOT/.zshrc" "$HOME/.zshrc"
link "$ROOT/.p10k.zsh" "$HOME/.p10k.zsh"
link "$ROOT/.vimrc" "$HOME/.vimrc"
link "$ROOT/.config/pip/pip.conf" "$HOME/.config/pip/pip.conf"

if [ "$OS" = "Linux" ]; then
  ensure_line "$HOME/.bashrc" 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"'
fi

if [ "$OS" = "Darwin" ]; then
  link "$ROOT/.config/pip/pip.conf" "$HOME/Library/Application Support/pip/pip.conf"
fi

if [ "$OS" = "Linux" ]; then
  printf '\nDone. Restart your terminal or run: source ~/.bashrc && exec zsh\n'
else
  printf '\nDone. Restart your terminal or run: exec zsh\n'
fi
