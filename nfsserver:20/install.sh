#! /bin/bash
# @edt ASIX Sergi Muñoz Carmona 2019-2020
# instal.lacio
# -------------------------------------
groupadd localgrp01
useradd -g users -G localgrp01 local01
useradd -g users -G localgrp01 local02
useradd -g users -G localgrp01 local03
echo "local01" | passwd --stdin local01
echo "local02" | passwd --stdin local02
echo "local03" | passwd --stdin local03

cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf

/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"

# --------- Creació dels homes dels usuaris LDAP-------------#

mkdir /tmp/home
mkdir /tmp/home/anna
mkdir /tmp/home/marta
mkdir /tmp/home/sergi


#--------------- Xixa als homes dels usuaris ----------------#

cp README.md /tmp/home/anna
cp README.md /tmp/home/marta
cp README.md /tmp/home/sergi

#Apliquem els permissos i associem els homes als usuaris i grups#

chown -R pere.users /tmp/home/anna
chown -R pau.users /tmp/home/marta
chown -R jordi.users /tmp/home/sergi


cp /opt/docker/exports /etc/exports
mkdir /run/rpcbind 
touch /run/rpcbind/rpcbind.lock
