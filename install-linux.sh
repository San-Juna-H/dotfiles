mkdir -p "$HOME/.config/pip"
rm -rf -- "$HOME/.config/pip/pip.conf"
ln -s "$ROOT/.config/pip/pip.conf" "$HOME/.config/pip/pip.conf"

zsh_path="$(command -v zsh)"
if ! grep -Fqx "$zsh_path" /etc/shells; then
  printf '%s\n' "$zsh_path" | sudo tee -a /etc/shells >/dev/null
fi
chsh -s "$zsh_path"
