#!/usr/bin/env bash

for postfix in "" ".lan"; do
  for machine in kalliope docker data dns; do
    ssh meowxiik@${machine}${postfix} "echo ${machine}${postfix}"
  done
done
