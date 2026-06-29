#!/bin/bash
set -e

packages=(
    gum
)

yay -S --needed --noconfirm "${packages[@]}"
