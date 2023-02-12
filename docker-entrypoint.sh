#!/bin/bash

if [ "${1}" == "shell" ]; then
  exec /bin/bash
  exit 0
fi

# Create persistence from skel if not already created
if [ ! -d /www/server/panel ]; then
  echo "Preparing for first run ..."
  tar xvJf /www-skel.tar.xz -C / >/dev/null
  tar xvJf /etc-skel.tar.xz -C / >/dev/null
fi

# Start aaPanel
if [ -d /www/server/panel ]; then
  apt-get update

  bt 3
  tail -F --retry /tmp/panelExec.log
  tail -f /dev/null
else
  echo "Unable to start aaPanel"
  exit 1
fi
