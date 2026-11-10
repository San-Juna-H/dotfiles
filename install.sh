#!/usr/bin/env sh
set -eu
ROOT="$(CDPATH= cd "$(dirname "$0")" && pwd)"
case "$(uname -s)" in
  Linux) platform=linux ;;
  Darwin) platform=macos ;;
  *) echo 'Only Linux and macOS are supported.' >&2; exit 1 ;;
esac

for brew_path in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [ -x "$brew_path" ]; then
    eval "$("$brew_path" shellenv)"
    break
  fi
done
if ! command -v brew >/dev/null 2>&1; then
  echo 'Install Homebrew first.' >&2
  exit 1
fi
if ! HOMEBREW_NO_AUTO_UPDATE=1 brew bundle check --no-upgrade --file="$ROOT/Brewfile"; then
  printf 'As the Homebrew owner, run: brew bundle install --file="%s/Brewfile" --no-upgrade\n' "$ROOT" >&2
  exit 1
fi

for name in .zshrc .p10k.zsh .vimrc; do
  rm -rf -- "$HOME/$name"
  ln -s "$ROOT/$name" "$HOME/$name"
done

plug_path="$HOME/.vim/autoload/plug.vim"
mkdir -p "$(dirname "$plug_path")"
curl -fsSL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -o "$plug_path.tmp"
mv "$plug_path.tmp" "$plug_path"
vim -Nu "$ROOT/.vimrc" -n -es '+PlugInstall --sync' '+qall'

. "$ROOT/install-$platform.sh"
printf '\nDone. Log out and log back in.\n'
