#!/usr/bin/env bash

set -euxo pipefail
pacman -S syncthing --noconfirm
mkdir /mnt/Cloud
chown meowxiik:meowxiik /mnt/Cloud
systemctl enable syncthing@meowxiik
