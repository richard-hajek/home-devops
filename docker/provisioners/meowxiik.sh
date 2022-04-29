#!/usr/bin/env bash

set -euxo pipefail

pacman -S wget --noconfirm

sudo -u meowxiik --shell /bin/bash -- <<EOF

cd ~

git clone https://aur.archlinux.org/yay.git
( cd yay; makepkg -si --noconfirm )
rm -rf yay

sh -c "\$(curl -fsLS git.io/chezmoi)" -- init --apply richard-hajek || true # Allow to fail


sh -c "\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
bash ~/.bash_it/install.sh --silent

yay -S libcgroup --noconfirm
yay -S lazydocker-git --noconfirm

EOF


