#!/bin/bash

if grep open /proc/acpi/button/lid/LID/state; then
	hyprctl keyword monitor "eDP-1,2880x1800@120,auto,2"
else
	hyprctl keyword monitor "eDP-1,disable"
fi
