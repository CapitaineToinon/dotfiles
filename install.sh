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

# store password
read -s -p "[$0] password for $USER:" PASSWORD

# basic echo before gum is installed
echo ""
echo "Doing a system update"

# check for updates
echo "$PASSWORD" | sh -c "sudo -S pacman -Syu --noconfirm &>/dev/null"

# install some mandotory packages
echo "$PASSWORD" | sh -c "sudo -S pacman -S --noconfirm base-devel git zsh rsync zip unzip gum jq &>/dev/null"

info "Installed required packages"

# copy zshrc
cp zsh/.zshrc "$HOME/.zshrc"
info "Copied .zshrc"

# oh my zsh
rm -rf "$HOME/.oh-my-zsh"
KEEP_ZSHRC=yes CHSH=no RUNZSH=no gum spin --title "Reinstalling oh-my-zsh" -- sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
info "Reinstalled oh-my-zsh"

# change command
gum spin --title "Changing default shell" -- sh -c "echo $PASSWORD | sudo -S chsh -s $(which zsh) $USER"
info "Changed default shell to zsh"

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
info "Installed fnm"

# install node 24
gum spin --title "Installing node 24" -- sh -c "fnm install 24 && fnm install 24"
info "Installed node 24"

# uninstall pyenv
if [ -d "$HOME/.pyenv" ]; then
	rm -rf "$HOME/.pyenv"
	info "Uninstalled pyenv"
fi

# install pyenv
gum spin --title "Installing pyenv" -- sh -c "curl -fsSL https://pyenv.run | bash"
info "Installed pyenv"

# uninstall uv
if [ -f "$HOME/.local/bin/uv" ]; then
	rm -f "$HOME/.local/bin/uv"
	rm -f "$HOME/.local/bin/uvx"
	info "Uninstalled uv"
fi

# install uv
gum spin --title "Installing uv" -- sh -c "curl -LsSf https://astral.sh/uv/install.sh | sh"
info "Installed uv"

# # install aur packages
gum confirm "Install packages with yay?" && gum spin --title "Installing packages" -- sh -c "yay -S --needed --noconfirm - <pacman.txt"
info "Installed yay packages"

# move nvim config
sync nvim "$HOME/.config/"
info "Synced nvim (editor) config"

# move ghostty config
sync ghostty "$HOME/.config/"
info "Synced ghostty (terminal) config"

# move swaync config
sync swaync "$HOME/.config/"
info "Synced swaync (notification center) config"

# move waybar config
sync waybar "$HOME/.config/"
info "Synced waybar (topbar) config"

# move hypr config
sync hypr "$HOME/.config/"
info "Synced hypr (hyprland ecosystem configs) configs"

# move vicinae config
sync vicinae "$HOME/.config/"
info "Synced vicinae (launcher) config"

# remove tmux plugins
rm -rf "$HOME/.config/tmux/plugins"
info "Removed current tmux plugins"

# move tmux config
sync tmux "$HOME/.config/" --exclude="plugins"
info "Synced tmux (pane manager) config"

# install tmux plugins
mkdir -p "$HOME/.config/tmux/plugins"
gum spin --title "Cloning tpm (tmux package manager)" -- git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
info "Reinstalled tmux plugins"

# install session script
cp scripts/session "$HOME/.local/bin/session"
info "Synced session (tmux session manager helper) script"

# move discord settings TODO
# if jq empty "~/.config/discord/settings.json" 2>/dev/null; then
# 	jq -s '.[0] * .[1]' "$HOME/.config/discord/settings.json" "$SCRIPT_DIR/discord/settings.json" >"$HOME/.config/discord/settings.json"
# 	info "Merged discord settings"
# else
# 	cp "$SCRIPT_DIR/discord/settings.json" "$HOME/.config/discord"
# 	info "Copied discord settings"
# fi

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

# reload waybar
if pgrep waybar; then
	pkill waybar
fi

hyprctl dispatch exec waybar
info "Restarted waybar"

# return to original directory
cd "$CURRENT_DIR"

# done
zsh
