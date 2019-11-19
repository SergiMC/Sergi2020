# Kerberos Client
## @edt ASIX M11-SAD Curs 2019-2020

**sergimc/kclient:20** Host client amb PAM amb autenticació AP de  kerberos i IP de ldap.
  
### Instal·lació

Part Global:
  * Crearem els usuaris i els assignarem el password als locals
  * Amb authconfig, configurarem la part local

Part Ldap:
 * Editarem i configurarem els fitxers de la part client: 
    - ldap.conf
    - nslcd
    - nsswitch.conf
 * Activarem els serveis nslcd i nscd

Part Kerberos
 * Editarem i configurarem el fitxer client **krb5.conf** 


#### Execució:
```
docker run --rm --name ldap.sergi.cat --hostname ldap.sergi.cat --net netcompose -d sergimc/ldapserver:20
docker run --rm --name kserver.sergi.cat --hostname kserver.sergi.cat --net netcompose -d sergimc/kserver:20
docker run --rm --name samba --hostname samba --net netcompose --privileged -d sergimc/samba:20
docker run --rm --name nfsserver --hostname nfsserver --net netcompose --privileged -d sergimc/nfsserver:20
docker run --rm --name kclient.sergi.cat -h kclient.sergi.cat --net netcompose --privileged -it sergimc/kclient:20 
```

Test:

```
[root@kclient docker]# su - pere
Creating directory '/tmp/home/pere'.
reenter password for pam_mount:
[pere@kclient ~]$ ll
total 0
drwxr-xr-x. 2 pere users 0 Nov 14 11:50 pere
[pere@kclient ~]$ pwd
/tmp/home/pere
[pere@kclient ~]$ mount -t cifs
//samba/pere on /tmp/home/pere/pere type cifs (rw,relatime,vers=default,cache=strict,username=pere,domain=,uid=5001,forceuid,gid=100,forcegid,addr=172.24.0.4,file_mode=0755,dir_mode=0755,nounix,serverino,mapposix,rsize=1048576,wsize=1048576,echo_interval=60,actimeo=1)

```

#### Comprovacions:

Comprovarem que hi ha connexió del client al servidor ldap amb l'ordre **ldapsearch**.
* Hem de tenir en compte la IP que té el nostre servidor LDAP.

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
KERBEROS:

```
[root@kclient docker]# kinit pere/admin
Password for pere/admin@SERGI.CAT: 
[root@kclient docker]# klist
Ticket cache: FILE:/tmp/krb5cc_0
Default principal: pere/admin@SERGI.CAT

Valid starting     Expires            Service principal
11/14/19 11:54:50  11/15/19 11:54:50  krbtgt/SERGI.CAT@SERGI.CAT

[root@kclient docker]# kdestroy

[root@kclient docker]# kinit pau
Password for pau@SERGI.CAT: 
[root@kclient docker]# klist
Ticket cache: FILE:/tmp/krb5cc_0
Default principal: pau@SERGI.CAT

Valid starting     Expires            Service principal
11/14/19 11:55:57  11/15/19 11:55:57  krbtgt/SERGI.CAT@SERGI.CAT

[root@kclient docker]# kadmin -p pere/admin
Authenticating as principal pere/admin with password.
Password for pere/admin@SERGI.CAT: 
kadmin:  listprincs
K/M@SERGI.CAT
anna/admin@SERGI.CAT
jordi@SERGI.CAT
julia@SERGI.CAT
kadmin/admin@SERGI.CAT
kadmin/changepw@SERGI.CAT
kadmin/kserver.sergi.cat@SERGI.CAT
kiprop/kserver.sergi.cat@SERGI.CAT
krbtgt/SERGI.CAT@SERGI.CAT
marta@SERGI.CAT
pau@SERGI.CAT
pere/admin@SERGI.CAT



```
