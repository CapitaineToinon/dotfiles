#!/bin/bash
# See https://wiki.hypr.land/IPC/

on_workspace() {
	swaync-client --close-panel
}

handle() {
	case $1 in
	workspace*) on_workspace ;;
	esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
