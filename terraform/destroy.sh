#!/usr/bin/env bash

. ./ready.source

target=""

if [[ $# == 1 ]]; then
  target="-target=$1"
fi

terraform -chdir=hcl apply -destroy -auto-approve $target

