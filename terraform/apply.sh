#!/usr/bin/env bash

. ./ready.source


if [[ $# == 1 ]]; then
  terraform -chdir=hcl apply -auto-approve -target=$1
  exit 0
fi

terraform -chdir=hcl apply -auto-approve -target=proxmox_lxc.buildbox
terraform -chdir=hcl apply -auto-approve -target=proxmox_lxc.data
terraform -chdir=hcl apply -auto-approve -target=proxmox_lxc.docker
terraform -chdir=hcl apply -auto-approve -target=proxmox_lxc.kalliope
terraform -chdir=hcl apply -auto-approve -target=proxmox_lxc.registry
