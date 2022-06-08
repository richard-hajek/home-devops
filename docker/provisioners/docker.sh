#!/usr/bin/env bash

set -euxo pipefail

pacman -Syu docker docker-compose --needed --noconfirm
systemctl enable docker
