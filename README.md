# Home Devops

## Goal

The goal of this setup is to automatically provision, deploy and configure the following machines:
- DNS Server
- Backup & Archive Server
- Virtual assistant server

## Quickstart

First, copy your SSH key to your Proxmox

```bash
ssh-copy-id <PROXMOX IP>
ssh-copy-id root@<PROXMOX IP>
```

Then you can build, upload and deploy the containers

```bash
make ensure-env # Tests your PC for dependencies
make build
make send
make deploy
```

## How it works

### 1. Prepare machines in local Docker - Build stage

On local Docker, we build all necessary containers - we will convert them to LXC later.

### 2. Send docker registry container to Proxmox - Bootstrap stage

We convert Docker Registry container to LXC and send it over to Proxmox. We then deploy the Docker registry to Proxmox. This is done to speed up the transport of the other containers.

### 3. Send over other Docker containers

We then use the Docker Registry running on Proxmox to copy all other containers. This is will be significantly faster than copying them one by one over scp.

### 4. Deploy containers using Terraform


# Machine specs

## Base mach

All machines are built from Arch Linux with Docker.

### DNS Server

Required to work with [Environment Overseer](https://github.com/richard-hajek/environment-overseer])

### Backup & Archive Server

Archive server uses Syncthing to connect to my clusterized data storage and backup data

### Virtual assistant server

Virtual assistant will run in Docker in this container.
