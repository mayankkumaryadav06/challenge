#!/bin/bash

set -e
# Send the log output from this script to startup-script.log, syslog, and the console
exec > >(tee /var/log/instance_startup.log|logger -t instance_startup -s 2>/dev/console) 2>&1

echo "Starting service"
sudo systemctl enable --now ops
