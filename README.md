# Dotfiles

Shell, Vim, and pip settings for macOS and Linux.

## Install

Install [Homebrew](https://brew.sh) manually, then clone:

```sh
git clone https://github.com/San-Juna-H/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Install shared packages as the Homebrew owner:

```sh
brew bundle install --file=./Brewfile --no-upgrade
```

Run in each account:

```sh
./install.sh
```

The installer checks required packages, replaces zsh, Powerlevel10k, Vim, and
pip settings without backups, and installs Vim plugins. On Linux, it also
sets zsh as the login shell; sudo and chsh may prompt for a password.
Log out and log back in afterward.

Keep this repository in place: settings are symbolic links to its files.
Python is installed separately. pip requires a virtual environment.
