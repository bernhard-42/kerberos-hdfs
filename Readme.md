# A tiny kerberized hdfs cluster (pseudo distributed)

## Images

### KDC image

Uses [sssd-kerberos-server-clients](https://github.com/bernhard-42/sssd-kerberos-server-clients)

```bash
git clone git@github.com:bernhard-42/sssd-kerberos-server-clients.git
cd sssd-kerberos-server-clients
```

Edit `config-standalone.sh`

```bash
sudo ./podman-build 1.0.0
```

### Hadoop image

Uses [tiny-hadoop](https://github.com/bernhard-42/tiny-hadoop)

```bash
git clone git@github.com:bernhard-42/tiny-hadoop.git
cd tiny-hadoop
git checkout kerberos
```

Edit `config.sh`

```bash
sudo ./podman-build
```

### Result

```bash
sudo podman images

REPOSITORY                            TAG      IMAGE ID       CREATED          SIZE
localhost/tiny-hadoop                 1.0.0    1c92e17201d4   22 seconds ago   1.49 GB
localhost/ldap-kdc-acme.localdomain   1.0.0    bca53efe6594   8 minutes ago    248 MB
docker.io/library/ubuntu              18.04    2ca708c1c9cc   2 weeks ago      66.6 MB
```

## The kerberos-hdfs pod

```bash
rm -f hadoop.keytab krb5.conf client-installer.tgz
```

```bash
cp ../sssd-kerberos-server-clients/target/client-installer.tgz .
```

```bash
1-create-pod.sh
```

```bash
2-run-kdc.sh
```

```bash
3-create-hadoop-keytab.sh
ls -l hadoop.keytab krb5.conf
```

```bash
4-start-hadoop.sh
```

```bash
5-configure-kerberos.sh
```

```bash
6-kerberize-hdfs.sh
```
