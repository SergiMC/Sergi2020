# UNDERCONSTRUCTION
# Kerberos khost
## @edt ASIX M11-SAD Curs 2018-2019

**edtasixm11/k18:khostpl** host amb PAM amb autenticació AP de  kerberos i IP de ldap.
  El servidor kerberos al que contacta s'ha de dir *kserver.edt.org*. El servidor ldap
  s'anomena ldap.edt.org. Aquest host es configura amb authconfig .
  
per generar autenticació PAM amb kerberos i ldap cal:

Part Global:
  * instal·lar procs passwd.
  * crear els usuaris i assignar password als locals.
  * un cop fet tot, configurar amb authconfig la autenticació local,
    kerberos i ldap.

Part Ldap:
 * instal·lar openldap-clients nss-pam-ldapd authconfig
 * copiar la configuració client /etc/openldap/ldap.conf.
 * copiar la configuració client /etc/nslcd.
 * copiar la configuració ns /etc/nsswitch.conf.
 * activar el servei nslcd
 * activar el servei nscd

Part Kerberos
 * instal·lar pam_krb5 authconfig
 * copiar /etc/krb5.conf per la configuració client kerberos

Authconfig:
```
authconfig  --enableshadow --enablelocauthorize --enableldap \
            --ldapserver='ldap.edt.org' --ldapbase='dc=edt,dc=org' \
            --enablekrb5 --krb5kdc='kserver.edt.org' \
            --krb5adminserver='kserver.edt.org' --krb5realm='EDT.ORG' \
            --updateall
```

#### Execució:
```
docker run --rm --name ldap.sergi.cat --hostname ldap.sergi.cat --net netcompose -d sergimc/ldapserver:20
docker run --rm --name kserver.sergi.cat --hostname kserver.sergi.cat --net netcompose -d sergimc/kserver:20
docker run --rm --name samba --hostname samba --net netcompose --privileged -d sergimc/samba:20
docker run --rm --name kclient.sergi.cat -h kclient.sergi.cat --net netcompose --privileged -it sergimc/kclient:20 
```

Test:

```
[root@khost docker]# su - local01
[local01@khost ~]$ su - user03
pam_mount password:
[user03@khost ~]$ id
uid=1005(user03) gid=100(users) groups=100(users),610(1asix),1001(kusers)


```
