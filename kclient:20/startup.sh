#! /bin/bash
# @edt Sergi Muñoz Carmona 2019-2020
# startup
# -------------------------------------
/opt/docker/install.sh && echo "Ok install"
/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"
/usr/sbin/rpcbind && echo "rpcbind Ok"
/usr/sbin/rpc.statd && echo "rpc.stad Ok"
/usr/sbin/rpc.nfsd && echo "rpc.nfsd Ok"
/usr/sbin/rpc.mountd && echo "rpc.mountd Ok"
/bin/bash

