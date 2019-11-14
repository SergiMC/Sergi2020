#! /bin/bash
# @edt Sergi Muñoz Carmona 2019-2020
# startup
# -------------------------------------
/opt/docker/install.sh && echo "Ok install"
/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"
/bin/bash

