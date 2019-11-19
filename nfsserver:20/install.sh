#! /bin/bash
# @edt ASIX M06 2018-2019
# instal.lacio
#  - crear usuaris locals
# -------------------------------------
#groupadd localgrp01
#groupadd localgrp02
#useradd -g users -G localgrp01 local01
#useradd -g users -G localgrp01 local02
#useradd -g users -G localgrp01 local03
#useradd -g users -G localgrp02 local04
#useradd -g users -G localgrp02 local05
#useradd -g users -G localgrp02 local06
#echo "local01" | passwd --stdin local01
#echo "local02" | passwd --stdin local02
#echo "local03" | passwd --stdin local03
#echo "local04" | passwd --stdin local04
#echo "local05" | passwd --stdin local05
#echo "local06" | passwd --stdin local06

mkdir /var//tmp/home
mkdir /var//tmp/home/pere
mkdir /var//tmp/home/anna
mkdir /var//tmp/home/marta
mkdir /var//tmp/home/jordi
mkdir /var//tmp/home/admin

cp README.md /var//tmp/home/pere
cp README.md /var//tmp/home/anna
cp README.md /var//tmp/home/marta
cp README.md /var//tmp/home/jordi
cp README.md /var//tmp/home/admin

chown -R pere.users /var/tmp/home/pere
chown -R anna.alumnes /var/tmp/home/anna
chown -R marta.alumnes /var/tmp/home/marta
chown -R jordi.users /var/tmp/home/jordi
chown -R admin.wheel /var/tmp/home/admin

bash /opt/docker/auth.sh
cp -ra  /opt/docker/nslcd.conf /etc/nslcd.conf
cp -ra /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp -ra /opt/docker/nsswitch.conf /etc/nsswitch.conf
cp -ra /opt/docker/system-auth-edt /etc/pam.d/system-auth-edt
cp -ra /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml
ln -ra -sf /etc/pam.d/system-auth-edt /etc/pam.d/system-auth

cp /opt/docker/exports /etc/exports
mkdir /run/rpcbind 
touch /run/rpcbind/rpcbind.lock

