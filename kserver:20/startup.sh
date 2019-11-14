#! /bin/bash
# @edt Sergi Muñoz Carmona 2019-2020
# Startup
# -------------------------------------
/opt/docker/install.sh && echo "Ok install"
/usr/sbin/krb5kdc
/usr/sbin/kadmind -nofork 
