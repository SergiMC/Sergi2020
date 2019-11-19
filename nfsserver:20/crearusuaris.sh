#!/bin/bash
# Script "temporal" de creació d'usuaris per disposar de home en el servidor nfs
# Els usuaris són de ldap, caldria simplement crear el seu home i assignar-los els permisos
# i propietat pertinents, però no crear-los
groupadd -g 600 profes
# groupadd -g 10 admin --> en realitat el 10 és el grup wheel

useradd -u 5003 -g 600 -m -d /var/tmp/home/anna anna
useradd -u 5004 -g 600 -m -d /var/tmp/home/marta marta
useradd -u 5005 -g 600 -m -d /var/tmp/home/sergi sergi



anna:*:5003:600:Anna Pou:/tmp/home/anna:
marta:*:5004:600:Marta Mas:/tmp/home/marta:
sergi:*:5005:Sergi Mas:/tmp/home/sergi:

mkdir /tmp/home

mkdir /tmp/home/anna
mkdir /tmp/home/marta
mkdir /tmp/home/sergi


chown anna.alumnes /tmp/home/anna
chown marta.alumnes /tmp/home/marta
chown sergi.alumnes /tmp/home/sergi
