#!/usr/bin/env bash

. ./ready.source
terraform -chdir=hcl apply -destroy -auto-approve
