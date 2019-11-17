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

# --------- Creació dels homes dels usuaris LDAP-------------#

mkdir /tmp/home
mkdir /tmp/home/anna
mkdir /tmp/home/marta
mkdir /tmp/home/admin

#--------------- Xixa als homes dels usuaris ----------------#


cp README.md /tmp/home/anna
cp README.md /tmp/home/marta
cp README.md /tmp/home/admin

#Apliquem els permissos i associem els homes als usuaris i grups#

chown -R anna.alumnes /tmp/home/anna
chown -R marta.alumnes /tmp/home/marta
chown -R admin.wheel /tmp/home/admin

bash /opt/docker/auth.sh
cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf

