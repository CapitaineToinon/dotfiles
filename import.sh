#!/bin/bash

# set errors
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

# packages
gum confirm "Do you wish to import your pacman packages too?" && pacman -Qqet >pacman.txt

# nvim
sync "$HOME/.config/nvim" "$SCRIPT_DIR"
info "Imported neovim"

# ghostty
sync "$HOME/.config/ghostty" "$SCRIPT_DIR"
info "Imported ghostty"

# hypr
sync "$HOME/.config/hypr" "$SCRIPT_DIR"
info "Imported hyprland ecosystem"

# waybar
sync "$HOME/.config/waybar" "$SCRIPT_DIR"
info "Imported waybar"

# swaync
sync "$HOME/.config/swaync" "$SCRIPT_DIR"
info "Imported swaync"

# tmux
sync "$HOME/.config/tmux" "$SCRIPT_DIR" --exclude="plugins"
info "Imported tmux"

# vicinae
sync "$HOME/.config/vicinae" "$SCRIPT_DIR"
info "Imported vicinae"

# zsh
cp "$HOME/.zshrc" "$SCRIPT_DIR/zsh/.zshrc"
info "Imported .zshrc"

# return to original directory
cd "$CURRENT_DIR"

# done
info "Import complete."
