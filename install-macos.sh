mkdir -p "$HOME/Library/Application Support/pip"
rm -rf -- "$HOME/Library/Application Support/pip/pip.conf"
ln -s "$ROOT/.config/pip/pip.conf" "$HOME/Library/Application Support/pip/pip.conf"
