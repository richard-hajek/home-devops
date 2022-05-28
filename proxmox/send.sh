#!/usr/bin/env bash

set -eoux pipefail

function process(){
  echo "Sending $1 image"
  dir=$2

  echo "Exporting to ${dir}"
  ./deployment/export.sh "${1}" "$dir"

  echo "Sending"
  ./deployment/upload.sh "${dir}" "${1}"
  
  if [[ $# == 3 ]] && [[ $3 == noclean ]]; then
    return
  fi

  echo "Cleaning up ${dir}"
  sudo rm -rf "${dir}"
  echo ''
}

if [[ $# == 1 ]]; then
  process $1 $(mktemp -d)
  exit 0
fi

if [[ $# == 2 ]]; then
  process $1 $(mktemp -d) noclean
  exit 0
fi

process archlinux-data "$(mktemp -d)"
process archlinux-kalliope "$(mktemp -d)"
process archlinux-docker "$(mktemp -d)"
