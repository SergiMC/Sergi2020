# Kerberos Client
## @edt ASIX M11-SAD Curs 2019-2020

**sergimc/** host amb PAM amb autenticació AP de  kerberos i IP de ldap.
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

#### Execució:
```
docker run --rm --name ldap.sergi.cat --hostname ldap.sergi.cat --net netcompose -d sergimc/ldapserver:20
docker run --rm --name kserver.sergi.cat --hostname kserver.sergi.cat --net netcompose -d sergimc/kserver:20
docker run --rm --name samba --hostname samba --net netcompose --privileged -d sergimc/samba:20
docker run --rm --name kclient.sergi.cat -h kclient.sergi.cat --net netcompose --privileged -it sergimc/kclient:20 
```

Test:

```
[root@kclient docker]# su - local01
reenter password for pam_mount:
[root@kclient docker]# su - pere
Creating directory '/tmp/home/pere'.
reenter password for pam_mount:
[pere@kclient ~]$ ll
total 0
drwxr-xr-x. 2 pere users 0 Nov 11 12:01 pere
[pere@kclient ~]$ pwd
/tmp/home/pere
[pere@kclient ~]$ mount -t cifs
//samba/pere on /tmp/home/pere/pere type cifs (rw,relatime,vers=default,cache=strict,username=pere,domain=,uid=5001,forceuid,gid=100,forcegid,addr=172.24.0.4,file_mode=0755,dir_mode=0755,nounix,serverino,mapposix,rsize=1048576,wsize=1048576,echo_interval=60,actimeo=1)



```

#### Comprovacions:

LDAP:

```
[pere@kclient ~]$ ldapsearch -x -LLL -h 172.24.0.2 -b "dc=edt,dc=org" dn
dn: dc=edt,dc=org

dn: ou=usuaris,dc=edt,dc=org

dn: uid=pau,ou=usuaris,dc=edt,dc=org

dn: uid=pere,ou=usuaris,dc=edt,dc=org

dn: uid=anna,ou=usuaris,dc=edt,dc=org

dn: uid=marta,ou=usuaris,dc=edt,dc=org

dn: uid=Jordi,ou=usuaris,dc=edt,dc=org

dn: uid=admin,ou=usuaris,dc=edt,dc=org

```
