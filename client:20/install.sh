#! /bin/bash

cp /opt/docker/krb5.conf /etc/krb5.conf

groupadd localgrp01
groupadd localgrp02
useradd -g users -G localgrp01 local01
useradd -g users -G localgrp01 local02
useradd -g users -G localgrp01 local03
echo "local01" | passwd --stdin local01
echo "local02" | passwd --stdin local02
echo "local03" | passwd --stdin local03

useradd pere
useradd marta
useradd pau
useradd jordi
useradd admin
useradd anna
