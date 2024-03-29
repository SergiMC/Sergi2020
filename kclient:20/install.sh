#! /bin/bash
# @edt Sergi Muñoz Carmona 2019-2020
# install
# -------------------------------------

#-- Creació dels usuaris locals --#
groupadd local01
useradd -g users -G local01 local01
useradd -g users -G local01 local02
useradd -g users -G local01 local03
echo "local01" | passwd --stdin local01
echo "local02" | passwd --stdin local02
echo "local03" | passwd --stdin local03


cp /opt/docker/krb5.conf /etc/krb5.conf
bash /opt/docker/auth.sh

cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf

cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml
cp /opt/docker/system-auth-sergi /etc/pam.d/system-auth-sergi
cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml
ln -sf /etc/pam.d/system-auth-sergi /etc/pam.d/system-auth

