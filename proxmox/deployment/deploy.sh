#!/usr/bin/env bash

set -euxo pipefail

cache_time=$(ssh proxmox "[[ -f /var/lib/vz/template/cache/$1.tar.gz ]] && ls -l --time-style +%s /var/lib/vz/template/cache/${1}.tar.gz -h | cut -f6 -d\ " ) || true

if [ -z "$cache_time" ]; then
  cache_time="0"
fi

updated_time=$(ssh registry.lan docker image ls --format '\{\{.Repository\}\}\@{{.CreatedSince}}' | grep $1 | cut -d\@ -f2 | xargs -I{} date +%s -d "{}")

if (( $cache_time > $updated_time )); then
  echo Skipping due to latest image update on $(date -d @$updated_time ) and we store $(date -d @$cache_time)
  exit
fi

container=$(ssh registry docker create 127.0.0.1:80/$1)
ssh registry "docker export $container | gzip --fast > /mnt/export/${1}.tar.gz"
ssh registry docker rm $container
sleep 1
ssh proxmox.lan sudo mv /home/meowxiik/registry/${1}.tar.gz /var/lib/vz/template/cache/$1.tar.gz
