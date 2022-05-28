#!/usr/bin/env bash

target="archlinux-*"

[[ $# == 1 ]] && target="$1"

ssh root@proxmox "bash -c \"rm /var/lib/vz/template/cache/$target\""
