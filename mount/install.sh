#!/bin/bash

set -e

declare -a ENTRIES=(
	"//192.168.1.41/homes/yourusername  /mnt/nas/home  cifs  credentials=/etc/nas-credentials,uid=1000,gid=1000,_netdev,nofail  0  0"
	"//192.168.1.100/media  /mnt/nas/media  cifs  credentials=/etc/nas-credentials,uid=1000,gid=1000,_netdev,nofail  0  0"
)

for ENTRY in "${ENTRIES[@]}"; do
	if ! grep -qF "$ENTRY" /etc/fstab; then
		echo "$ENTRY" | sudo tee -a /etc/fstab
	fi
done

mkdir -p /mnt/dog/home
mkdir -p /mnt/dog/songs
