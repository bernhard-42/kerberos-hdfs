#!/bin/bash

CID=$(sudo podman ps | awk '/hadoop/ {print $1}')
sudo podman exec -it $CID mkdir /etc/security/keytabs
sudo podman cp hadoop.keytab $CID:/etc/security/keytabs
sudo podman exec -it $CID chmod 660 /etc/security/keytabs/hadoop.keytab
sudo podman exec -it $CID chown root:hadoop /etc/security/keytabs/hadoop.keytab
sudo podman exec -it $CID keytool -genkey -noprompt -alias hdfs \
 -dname "CN=acme.localdomain, OU=ID, O=ACME, L=Hadoop, S=Hdfs, C=DE" \
 -keystore /opt/hadoop/etc/hadoop/keystore -storepass secret -keypass secret
sudo podman exec -it $CID bash -lc "sudo -u hdfs /opt/hadoop/sbin/stop-dfs.sh"
sudo podman cp container_root/opt/ $CID:/
sudo podman exec -it $CID bash -lc "sudo -u hdfs /opt/hadoop/sbin/start-dfs.sh"