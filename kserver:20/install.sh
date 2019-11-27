#! /bin/bash
# @edt Sergi Muñoz Carmona 2019-2020
# install
# -------------------------------------

#---------- Fitxers de configuració --------------#

cp /opt/docker/krb5.conf /etc/krb5.conf
cp /opt/docker/kdc.conf /var/kerberos/krb5kdc/kdc.conf
cp /opt/docker/kadm5.acl /var/kerberos/krb5kdc/kadm5.acl

#--- Creació de la base de dades i principals ---#

kdb5_util create -s -P masterkey
kadmin.local -q "addprinc -pw ksergi sergi"
kadmin.local -q "addprinc -pw kpere pere/admin"
kadmin.local -q "addprinc -pw kpere pere"
kadmin.local -q "addprinc -pw kanna anna/admin"
kadmin.local -q "addprinc -pw kpau pau"
kadmin.local -q "addprinc -pw kjordi jordi"
kadmin.local -q "addprinc -pw kmarta marta"



