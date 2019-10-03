#!/bin/bash
source ./config.sh
echo $REALM
CID=$(sudo podman ps | awk '/ldap-kdc/ {print $1}')

sudo podman exec -it $CID bash -c "echo \"ank -pw secret hdfs/${HOSTNAME}@${REALM}\" | kadmin.local"
sudo podman exec -it $CID bash -c "echo \"ank -pw secret HTTP/${HOSTNAME}@${REALM}\" | kadmin.local"

sudo podman exec -it $CID bash -c 'mkdir /etc/security/keytabs/'
sudo podman exec -it $CID bash -c "echo \"xst -norandkey -k /etc/security/keytabs/hadoop.keytab hdfs/${HOSTNAME}@${REALM}\" | kadmin.local"
sudo podman exec -it $CID bash -c "echo \"xst -norandkey -k /etc/security/keytabs/hadoop.keytab HTTP/${HOSTNAME}@${REALM}\" | kadmin.local"

sudo podman cp $CID:/etc/security/keytabs/hadoop.keytab .

sudo podman cp $CID:/etc/krb5.conf .
# sed -i "s/127.0.0.1/$(hostname -i)/g" krb5.conf
sed -i '/\[dbdefaults\]/,$d' krb5.conf
