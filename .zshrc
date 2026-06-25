# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

for brew_cmd in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [[ -x "$brew_cmd" ]]; then
    eval "$("$brew_cmd" shellenv)"
    break
  fi
done
unset brew_cmd

if command -v brew >/dev/null 2>&1; then
  BREW_PREFIX="$(brew --prefix)"

  [[ -r "$BREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme" ]] && source "$BREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"
  [[ -r "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

[[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

if [[ -n "${BREW_PREFIX:-}" ]]; then
  [[ -r "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
