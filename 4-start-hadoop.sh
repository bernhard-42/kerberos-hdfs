#!/bin/bash
source ./config.sh

sudo podman rm -f hadoop 2> /dev/null

sudo mkdir -p /opt/container-fs/hadoop
sudo chmod 777 /opt/container-fs/hadoop

sudo podman run -d \
            --pod ${HOSTNAME} \
            --add-host kdc.acme.localdomain:127.0.0.1 \
            --name hadoop \
            -v /opt/container-fs/hadoop:/hadoop \
            tiny-hadoop:1.0.0 \
            /run.sh
