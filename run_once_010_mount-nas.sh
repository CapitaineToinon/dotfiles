#!/bin/bash
set -e

gum style --border rounded --padding "0 1" --bold "NAS Mount Setup"

gum log --level info "Fetching credentials from Proton Pass..."
USERNAME=$(pass-cli item view --vault-name Personal --item-title "Synology Home" --field username)
PASSWORD=$(pass-cli item view --vault-name Personal --item-title "Synology Home" --field password)
gum log --level info "Credentials fetched"

CREDS_FILE="/etc/samba/credentials.synology"
gum spin --title "Writing credentials file..." -- bash -c "
    sudo mkdir -p /etc/samba
    printf 'username=%s\npassword=%s\n' '$USERNAME' '$PASSWORD' | sudo tee '$CREDS_FILE' > /dev/null
    sudo chmod 600 '$CREDS_FILE'
    sudo chown root:root '$CREDS_FILE'
"
gum log --level info "Credentials written to $CREDS_FILE"

gum log --level info "Creating mount points..."
sudo mkdir -p /mnt/dog /mnt/home

USER_UID=$(id -u)
USER_GID=$(id -g)
OPTS="credentials=$CREDS_FILE,uid=$USER_UID,gid=$USER_GID,iocharset=utf8,vers=3.0,_netdev,nofail,x-systemd.automount,x-systemd.idle-timeout=60"

gum log --level info "Updating /etc/fstab..."
grep -q "home.capitainetoinon.ch/dog" /etc/fstab || \
    echo "//home.capitainetoinon.ch/dog /mnt/dog cifs $OPTS 0 0" | sudo tee -a /etc/fstab > /dev/null

grep -q "home.capitainetoinon.ch/home" /etc/fstab || \
    echo "//home.capitainetoinon.ch/home /mnt/home cifs $OPTS 0 0" | sudo tee -a /etc/fstab > /dev/null

gum spin --title "Reloading systemd..." -- sudo systemctl daemon-reload

if mountpoint -q /mnt/dog; then
    gum log --level warn "/mnt/dog already mounted, skipping"
else
    gum spin --title "Mounting /mnt/dog..." -- sudo mount /mnt/dog
    gum log --level info "Mounted /mnt/dog"
fi

if mountpoint -q /mnt/home; then
    gum log --level warn "/mnt/home already mounted, skipping"
else
    gum spin --title "Mounting /mnt/home..." -- sudo mount /mnt/home
    gum log --level info "Mounted /mnt/home"
fi

gum log --level info "Done"
