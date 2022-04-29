#!/usr/bin/env bash

. ./ready.source

terraform -chdir=hcl apply -auto-approve -target=proxmox_lxc.buildbox
terraform -chdir=hcl apply -auto-approve -target=proxmox_lxc.data
terraform -chdir=hcl apply -auto-approve -target=proxmox_lxc.docker
terraform -chdir=hcl apply -auto-approve -target=proxmox_lxc.kalliope
