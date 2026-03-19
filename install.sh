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
command -v pacman >/dev/null 2>&1 || {
	echo >&2 "I require pacman but it's not installed. Aborting."
	exit 1
}

# ensure gum is installed
command -v gum >/dev/null 2>&1 || {
	sudo pacman -Syu --noconfirm && sudo pacman -S --noconfirm gum
}

# store password
PASSWORD=$(gum input --password --placeholder "Type your password")

# login for a while
echo "$PASSWORD" | sudo -S true

# check for updates
gum spin --title "Updating system..." -- sudo pacman -Syu --noconfirm
info "Updated system"

# install some mandotory packages
gum spin --title "Installing required packages" -- sudo pacman -S --noconfirm \
	base-devel \
	git \
	zsh \
	rsync \
	zip \
	unzip

info "Installed required packages"

# copy zshrc
cp zsh/.zshrc "$HOME/.zshrc"
info "Copied .zshrc"

# oh my zsh
rm -rf "$HOME/.oh-my-zsh"
KEEP_ZSHRC=yes CHSH=no RUNZSH=no gum spin --title "Reinstalling oh-my-zsh" -- sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
info "Reinstalled oh-my-zsh"

# change command
echo "$PASSWORD" | sudo -S chsh -s $(which zsh) $USER
info "Changed default command to zsh"

# install yay package manager if not already installed
if ! command -v yay >/dev/null 2>&1; then
	cd /tmp
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	info "Installed yyay"
else
	info "yay is already installed"
fi

# uninstall fnm
if [ -f "$HOME/.fnm" ]; then
	rm -f "$HOME/.fnm"
	info "Uninstalled fnm"
fi

# install fnm
gum spin --title "Installing fnm" -- sh -c "curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell"

# uninstall pyenv
if [ -d "$HOME/.pyenv" ]; then
	rm -rf "$HOME/.pyenv"
	info "Uninstalled pyenv"
fi

# install pyenv
gum spin --title "Installing pyenv" -- sh -c "curl -fsSL https://pyenv.run | bash"

exit 1

# uninstall uv
if [ -f "$HOME/.local/bin/uv" ]; then
	rm -f "$HOME/.local/bin/uv"
	rm -f "$HOME/.local/bin/uvx"
	info "Uninstalled uv"
fi

# install uv
gum spin --title "Installing uv" -- sh -c "curl -LsSf https://astral.sh/uv/install.sh | sh"

# # install aur packages
gum confirm "Install packages with yay?" && gum spin --title "Installing packages" -- sh -c "yay -S --needed --noconfirm - <pacman.txt"

# move nvim config
sync nvim "$HOME/.config/"

# move ghostty config
sync ghostty "$HOME/.config/"

# move swaync config
sync swaync "$HOME/.config/"

# move waybar config
sync waybar "$HOME/.config/"

# move hypr config
sync hypr "$HOME/.config/"

# move vicinae config
sync vicinae "$HOME/.config/"

# remove tmux plugins
rm -rf "$HOME/.config/tmux/plugins"

# move tmux config
sync tmux "$HOME/.config/" --exclude="plugins"

# install tmux plugins
mkdir -p "$HOME/.config/tmux/plugins"
git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"

# install session script
cp scripts/session "$HOME/.local/bin/session"

# return to original directory
cd "$CURRENT_DIR"

# setup docker
# if the docker group doesn't exist, create it
if ! grep -q docker /etc/group; then
	echo "$PASSWORD" | sudo -s groupadd docker
	info "Created the docker group"
else
	info "docker group already exists"
fi

# if the user is not in the docker group, add them
if ! id -Gn | grep -qw docker; then
	echo "$PASSWORD" | sudo -S usermod -aG docker $USER
	info "Added $USER to the docker group"
else
	info "$USER is already in the docker group"
fi

# enable docker daemon
echo "$PASSWORD" | sudo -S systemctl enable docker.service
echo "$PASSWORD" | sudo -S systemctl enable containerd.service
info "Enabled the docker services"

# done
zsh
