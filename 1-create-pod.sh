#!/bin/bash

source ./config.sh

sudo podman pod create --name ${HOSTNAME} \
                       -p 88:88 -p 88:88/udp -p 389:389 -p 636:636 -p 464:464 -p 464:464/udp \
                       -p ${PHPLDAPADMIN_PORT}:${PHPLDAPADMIN_PORT} \
                       -p 4040:4040 -p 8020:8020 -p 8032:8032 -p 8042:8042 -p 8050:8050 -p 8088:8088 \
                       -p 50070:50070 -p 50010:50010 -p 50020:50020 -p 50075:50075 -p 50090:50090
