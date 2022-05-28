#!/usr/bin/env bash

set -euxo pipefail

pacman -Syu docker docker-compose --needed --noconfirm
systemctl enable docker

mkdir -p /etc/docker
cat << EOF > /etc/docker/daemon.json
{
  "data-root": "/mnt/Cloud/docker"
}
EOF
