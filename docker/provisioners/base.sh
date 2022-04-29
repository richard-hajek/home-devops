#!/usr/bin/env bash

set -euxo pipefail

pacman --noconfirm -Syu docker python python-pip neovim neovim networkmanager sudo zsh git base base-devel lsb-release openssh unison docker-compose unison rsync --needed 
pacman --noconfirm -Syu dog bind htop screen net-tools traceroute
useradd -m -G docker,wheel -s /bin/zsh meowxiik

systemctl enable sshd

ln -s /usr/share/zoneinfo/Europe/Prague /etc/localtime

pswd=$(openssl rand -hex 12)

echo "root:${pswd}" | chpasswd
echo "meowxiik:${pswd}" | chpasswd

echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
