#!/usr/bin/env bash

set -euxo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

dry=false

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -s|--softclean)
      echo "Deleting only containers"
      for $c in `docker ps -aq`; do docker rm $c -f; done
      exit 0
      ;;
    -c|--clean)
      echo "Deleting all containers and images..."
      for i in `docker image ls -q`; do docker image rm $i; done
      exit 0
      ;;
    -h|--help)
      print "At some point there will be help"
      exit 0
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

keys/generate.sh

docker build . -f DockerfileBase -t meowxiik/archlinux-base
docker build . -f DockerfileKalliope -t meowxiik/archlinux-kalliope
docker build . -f DockerfileData -t meowxiik/archlinux-data
docker build . -f DockerfileDocker -t meowxiik/archlinux-docker
docker build . -f DockerfileRegistry -t meowxiik/archlinux-registry

function retag(){
  docker tag meowxiik/archlinux-$1 registry.lan:80/archlinux-$1
}

retag base
retag kalliope
retag data
retag docker
