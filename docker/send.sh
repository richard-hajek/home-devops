#!/usr/bin/env bash

set -euxo pipefail

if [[ ! -f /etc/docker/daemon.json ]]; then
  sudo bash -c "echo '{\"insecure-registries\":[\"registry.lan:80\"]}' > /etc/docker/daemon.json"
  sudo systemctl restart docker
fi


for image in `docker image ls --format '{{ .Repository }}'`; do

  if ! [[ $image == *registry.lan:80* ]]; then
    continue
  fi

  docker push $image
done
