#!/bin/bash

CID=$(sudo podman ps | awk '/hadoop/ {print $1}')
sudo podman cp client-installer.tgz $CID:/tmp
sudo podman exec -it $CID bash -c 'cd /tmp; tar -zxvf client-installer.tgz'
sudo podman exec -it $CID bash -c 'cd /tmp; export DOCKER=1; ./create-client.sh'
