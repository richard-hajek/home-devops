#!/usr/bin/env bash

set -eoux pipefail

if [[ $# == 1 ]]; then
  ./deployment/deploy.sh $1
  exit 0
fi

./deployment/deploy.sh archlinux-data
./deployment/deploy.sh archlinux-kalliope
./deployment/deploy.sh archlinux-docker
