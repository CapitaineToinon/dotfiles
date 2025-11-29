#!/bin/bash

validate_environment() {
	# prevent script from running as root
	if [[ $EUID == 0 ]]; then
		echo "This script should not be run as root. Aborting."
		exit 1
	fi

	# exit if the user that ran originally was root
	# by checking if HOME is /root
	if [[ "$HOME" == "/root" ]]; then
		echo "This script should not be run as root. Aborting."
		exit 1
	fi

	# exit if HOME is empty, not set, / or not a directory
	if [[ -z "$HOME" || "$HOME" == "/" || ! -d "$HOME" ]]; then
		echo "HOME is not set or is not a directory. Aborting."
		exit 1
	fi
}

sync() {
    local from="$1"
    local to="$2"
    shift 2

	rsync -a --delete "$@" "$from" "$to"
}

