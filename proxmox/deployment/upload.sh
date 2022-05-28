#!/usr/bin/env bash

set -eux

rsync -z --progress $1/$2.tar.gz root@192.168.1.101:/var/lib/vz/template/cache/$2.tar.gz
