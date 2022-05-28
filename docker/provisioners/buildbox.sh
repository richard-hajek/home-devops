#!/usr/bin/env bash

git clone https://github.com/richard-hajek/aurbot.git /opt/aurbot/aurbot
cp /opt/aurbot/aurbot/aurbot.service /etc/systemd/system/
systemctl enable aurbot
#mkdir /var/lib/aurbot
#chown meowxiik:meowxiik /var/lib/aurbot
#chown -R meowxiik:meowxiik /opt/aurbot
