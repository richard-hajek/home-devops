#!/usr/bin/env bash

set -euxo pipefail

sudo -u meowxiik yay -S pi-hole-server --noconfirm
pacman -S --noconfirm php-sqlite lighttpd php-cgi
systemctl enable pihole-FTL lighttpd
