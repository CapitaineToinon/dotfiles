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

# ghostty
sync "$HOME/.config/ghostty" "$SCRIPT_DIR"

# hypr
sync "$HOME/.config/hypr" "$SCRIPT_DIR"

# waybar
sync "$HOME/.config/waybar" "$SCRIPT_DIR"

# swaync
sync "$HOME/.config/swaync" "$SCRIPT_DIR"

# tmux
sync "$HOME/.config/tmux" "$SCRIPT_DIR" --exclude="plugins"

# vicinae
sync "$HOME/.config/vicinae" "$SCRIPT_DIR"

# zsh
cp "$HOME/.zshrc" "$SCRIPT_DIR/zsh/.zshrc"

# return to original directory
cd "$CURRENT_DIR"

# done
echo "Import complete."
