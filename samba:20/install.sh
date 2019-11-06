#! /bin/bash
# @edt ASIX M06 2018-2019
# instal.lacio
# -------------------------------------
groupadd localgrp01
groupadd localgrp02
useradd -g users -G localgrp01 local01
useradd -g users -G localgrp01 local02
useradd -g users -G localgrp01 local03
echo "local01" | passwd --stdin local01
echo "local02" | passwd --stdin local02
echo "local03" | passwd --stdin local03

#bash /opt/docker/auth.sh
cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf


/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"

# -----------------------------------------------------------
mkdir /tmp/home
mkdir /tmp/home/pere
mkdir /tmp/home/pau
mkdir /tmp/home/anna
mkdir /tmp/home/marta
mkdir /tmp/home/jordi
mkdir /tmp/home/admin

cp README.md /tmp/home/pere
cp README.md /tmp/home/pau
cp README.md /tmp/home/anna
cp README.md /tmp/home/marta
cp README.md /tmp/home/jordi
cp README.md /tmp/home/admin

chown -R pere.users /tmp/home/pere
chown -R pau.users /tmp/home/pau
chown -R anna.alumnes /tmp/home/anna
chown -R marta.alumnes /tmp/home/marta
chown -R jordi.users /tmp/home/jordi
chown -R admin.wheel /tmp/home/admin

# -----------------------------------------------------------
mkdir /var/lib/samba/public
chmod 777 /var/lib/samba/public
cp /opt/docker/* /var/lib/samba/public/.

mkdir /var/lib/samba/privat
#chmod 777 /var/lib/samba/privat
cp /opt/docker/smb.conf /etc/samba/smb.conf
cp /opt/docker/*.md /var/lib/samba/privat/.

useradd smbuser1
useradd smbuser2
useradd smbuser3

echo -e "smbuser1\nsmbuser1" | smbpasswd -a smbuser1
echo -e "smbuser2\nsmbuser2" | smbpasswd -a smbuser2
echo -e "smbuser3\nsmbuser3" | smbpasswd -a smbuser3

echo -e "kpere\nkpere" | smbpasswd -a pere
echo -e "kpau\nkpau" | smbpasswd -a pau
echo -e "kanna\nkanna" | smbpasswd -a anna
echo -e "kmarta\nkmarta" | smbpasswd -a marta
echo -e "kjordi\nkjordi" | smbpasswd -a jordi
echo -e "kadmin\nkadmin" | smbpasswd -a admin
echo "Ok users"
