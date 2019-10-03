#!/bin/bash
source ./config.sh

sudo podman run -d --pod ${HOSTNAME} --name ldap-kdc ldap-kdc-${DOMAIN}:1.0.0
