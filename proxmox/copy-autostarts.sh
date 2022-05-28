#!/usr/bin/env bash

scp root@proxmox.lan:/var/lib/vz/snippets/autostarts.pl remote.autostarts.pl

diff remote.autostarts.pl autostarts.pl > /dev/null && exit 0
diff remote.autostarts.pl autostarts.pl

echo "Continue?"
read 
scp ./autostarts.pl root@proxmox.lan:/var/lib/vz/snippets/
rm autostarts.pl
