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
pacman -Qqe > pacman.txt

# nvim
sync "$HOME/.config/nvim" .

# wezterm
sync "$HOME/.config/wezterm" .

# hypr
sync "$HOME/.config/hypr" .

# kitty
sync "$HOME/.config/kitty" .

# waybar
sync "$HOME/.config/waybar" .

# return to original directory
cd "$CURRENT_DIR"

# done
echo "Import complete."

