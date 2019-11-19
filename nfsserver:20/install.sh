#! /bin/bash
# @edt ASIX M06 2018-2019
# instal.lacio
#  - crear usuaris locals
# -------------------------------------
mkdir /var//tmp/home

mkdir /var//tmp/home/anna
mkdir /var//tmp/home/marta
mkdir /var//tmp/home/sergi



cp README.md /var//tmp/home/anna
cp README.md /var//tmp/home/marta
cp README.md /var//tmp/home/sergi



chown -R anna.alumnes /var/tmp/home/anna
chown -R marta.alumnes /var/tmp/home/marta
chown -R sergi.alumnes /var/tmp/home/sergi


bash /opt/docker/auth.sh
cp -ra  /opt/docker/nslcd.conf /etc/nslcd.conf
cp -ra /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp -ra /opt/docker/nsswitch.conf /etc/nsswitch.conf
#cp -ra /opt/docker/system-auth-edt /etc/pam.d/system-auth-edt
#cp -ra /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml
#ln -ra -sf /etc/pam.d/system-auth-edt /etc/pam.d/system-auth

cp /opt/docker/exports /etc/exports
mkdir /run/rpcbind 
touch /run/rpcbind/rpcbind.lock

