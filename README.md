# Home Devops

## Goal

The goal of this setup is to automatically provision, deploy and configure the following machines:
- DNS Server
- Backup & Archive Server
- Virtual assistant server

## Quickstart

First, copy your SSH key to your Proxmox

```bash
ssh-copy-id root@<PROXMOX IP>
```

Then you can build, upload and deploy the containers

```bash
make ensure-env # Tests your PC for dependencies
make build
make deploy
```

## Base mach

All machines are built from Arch Linux with Docker.

### DNS Server

Required to work with [Environment Overseer](https://github.com/richard-hajek/environment-overseer])

### Backup & Archive Server

Archive server uses Syncthing to connect to my clusterized data storage and backup data

### Virtual assistant server

Virtual assistant will run in Docker in this container.
