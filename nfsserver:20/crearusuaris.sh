#!/bin/bash
# Script "temporal" de creació d'usuaris per disposar de home en el servidor nfs
# Els usuaris són de ldap, caldria simplement crear el seu home i assignar-los els permisos
# i propietat pertinents, però no crear-los
groupadd -g 600 profes
# groupadd -g 10 admin --> en realitat el 10 és el grup wheel

useradd -u 5000 -g 100 -m -d /var/tmp/home/pau pau
useradd -u 5001 -g 100 -m -d /var/tmp/home/pere pere
useradd -u 5002 -g 600 -m -d /var/tmp/home/anna anna
useradd -u 5003 -g 600 -m -d /var/tmp/home/marta marta
useradd -u 5004 -g 100 -m -d /var/tmp/home/jordi jordi
useradd -u 10 -g 10 -m -d /var/tmp/home/admin admin


pere:*:5001:100:Pere Pou:/tmp/home/pere:
anna:*:5002:600:Anna Pou:/tmp/home/anna:
marta:*:5003:600:Marta Mas:/tmp/home/marta:
jordi:*:5004:100:Jordi Mas:/tmp/home/jordi:
admin:*:10:10:Administrador Sistema:/tmp/home/admin:

mkdir /tmp/home
mkdir /tmp/home/pere
mkdir /tmp/home/anna
mkdir /tmp/home/marta
mkdir /tmp/home/jordi
mkdir /tmp/home/admin
chown pere.users /tmp/home/pere
chown anna.alumnes /tmp/home/anna
chown marta.alumnes /tmp/home/marta
chown jordi.users /tmp/home/jordi
chown admin.wheel /tmp/home/admin


