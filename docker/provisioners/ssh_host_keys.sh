#!/usr/bin/env bash

# Fix perms
chown -R root:root /etc/ssh
chmod 600 /etc/ssh/*_key
chmod 644 /etc/ssh/*.pub

# Hide them so Proxmox won't overwrite all them
mkdir -p /etc/ssh/keys_backup
cp /etc/ssh/*_key /etc/ssh/keys_backup
cp /etc/ssh/*.pub /etc/ssh/keys_backup
