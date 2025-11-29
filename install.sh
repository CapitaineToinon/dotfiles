#!/bin/bash

# enable errors
set -e

# save current directory
CURRENT_DIR=$(pwd)

# change to the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# import common.sh
. ./common.sh

# validate environment
validate_environment

# ensure pacman exsists, error otherwise
command -v pacman >/dev/null 2>&1 || { echo >&2 "I require pacman but it's not installed. Aborting."; exit 1; }

# check for updates
sudo pacman -Syu --noconfirm

# install some mandotory packages
sudo pacman -S --noconfirm \
    base-devel \
    git \
    zsh \
	rsync

# copy zshrc
cp zsh/.zshrc "$HOME/.zshrc"

# install yay package manager if not already installed
if ! command -v yay >/dev/null 2>&1; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
fi

# uninstall fnm
if [ -f "$HOME/.fnm" ]; then
    rm -f "$HOME/.fnm"
fi

# install fnm
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell

# uninstall pyenv
if [ -d "$HOME/.pyenv" ]; then
    rm -rf "$HOME/.pyenv"
fi

# install pyenv
curl -fsSL https://pyenv.run | bash

# uninstall uv
if [ -f "$HOME/.local/bin/uv" ]; then
    rm -f "$HOME/.local/bin/uv"
	rm -f "$HOME/.local/bin/uvx"
fi

# install aur packages
yay -S --needed --noconfirm - < pacman.txt

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# install laravel sail globally
composer global require laravel/sail

# move nvim config
sync nvim "$HOME/.config/"

# move wezterm config
sync wezterm "$HOME/.config/"

# move hypr config
sync hypr "$HOME/.config/"

# move kitty config
sync kitty "$HOME/.config/"

# move waybar config
sync waybar "$HOME/.config/"

# remove tmux plugins
rm -rf "$HOME/.config/tmux/plugins"

# move tmux config
sync tmux "$HOME/.config/" --exclude="plugins"

# install tmux plugins
mkdir -p "$HOME/.config/tmux/plugins"
git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"

# install session script
cp session/session "$HOME/.local/bin/session"

# return to original directory
cd "$CURRENT_DIR"

# setup docker
# if the docker group doesn't exist, create it
if ! grep -q docker /etc/group; then
    sudo groupadd docker
fi

# if the user is not in the docker group, add them
if ! id -Gn | grep -qw docker; then
    sudo usermod -aG docker $USER
fi

# start docker daemon
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# done
echo "Installation complete. Please restart your terminal for changes to take effect."

