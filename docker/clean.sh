#!/usr/bin/env bash

for image in `docker image ls --format '{{ .Repository }}'`; do
  if [[ $image == *meowxiik* ]]; then
    docker image rm $image -f
  fi
done

docker system prune
