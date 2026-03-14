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
pacman -Qqet >pacman.txt

# nvim
sync "$HOME/.config/nvim" .

# ghostty
sync "$HOME/.config/ghostty" .

# hypr
sync "$HOME/.config/hypr" .

# waybar
sync "$HOME/.config/waybar" .

# swaync
sync "$HOME/.config/swaync" .

# tmux
sync "$HOME/.config/tmux" . --exclude="plugins"

# vicinae
sync "$HOME/.config/vicinae" .

# zsh
cp "$HOME/.zshrc" "zsh/.zshrc"

# return to original directory
cd "$CURRENT_DIR"

# done
echo "Import complete."
