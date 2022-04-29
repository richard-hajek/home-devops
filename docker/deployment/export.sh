#!/usr/bin/env bash

set -eux

container=$(docker create meowxiik/$1)
docker export $container | gzip --rsyncable --fast > ${2}/${1}.tar.gz
docker rm $container
