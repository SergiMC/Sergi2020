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

#### Comprovació de l'execució:

Ens autentiquem com a usuari pau i comprovem que s'ha muntat el home correctament.

```
[root@kclient docker]# su - local01
[local01@kclient ~]$ su - pau
pam_mount password:
Creating directory '/tmp/home/pau'.
[pau@kclient ~]$ ll
total 0
drwxr-xr-x. 2 pau users 0 Nov 27 12:08 pau
[pau@kclient ~]$ mount -t cifs
//samba/pau on /tmp/home/pau/pau type cifs (rw,relatime,vers=default,cache=strict,username=pau,domain=,uid=5000,forceuid,gid=100,forcegid,addr=172.24.0.4,file_mode=0755,dir_mode=0755,nounix,serverino,mapposix,rsize=1048576,wsize=1048576,echo_interval=60,actimeo=1)
```

#### Comprovacio dels servidors desde la part de client.

Comprovarem que hi ha connexió del client al servidor ldap amb l'ordre **ldapsearch**.
* Hem de tenir en compte la IP que té el nostre servidor LDAP.

LDAP:

```
[root@kclient docker]# ldapsearch -x -LLL -h 172.24.0.2 -b "dc=edt,dc=org" dn
dn: dc=edt,dc=org

dn: ou=usuaris,dc=edt,dc=org

dn: cn=admin,ou=grups,dc=edt,dc=org

dn: cn=alumnes,ou=grups,dc=edt,dc=org

dn: cn=profes,ou=grups,dc=edt,dc=org

dn: uid=pau,ou=usuaris,dc=edt,dc=org

dn: uid=pere,ou=usuaris,dc=edt,dc=org

dn: uid=Jordi,ou=usuaris,dc=edt,dc=org

dn: uid=marta,ou=usuaris,dc=edt,dc=org

dn: uid=anna,ou=usuaris,dc=edt,dc=org

dn: uid=Sergi,ou=usuaris,dc=edt,dc=org

dn: uid=admin,ou=usuaris,dc=edt,dc=org

```
KERBEROS:

Per comprovar que funcioni el servidor correctament, utilitzarem les ordres *kinit*, *klist*, *kdestroy*,*kadmin*.

* L'ordre **kinit** ens autentica l'usuari i ens proporciona un ticket de kerberos. El ticket identifica l'usuari
i ens indica els privilegis que té l'usuari

```
[root@kclient docker]# kinit pere/admin
Password for pere/admin@SERGI.CAT: 
```

* L'ordre **klist** ens llista la informació obtinguda del ticket.

```
[root@kclient docker]# klist
Ticket cache: FILE:/tmp/krb5cc_0
Default principal: pere/admin@SERGI.CAT
```
* L'ordre **kdestroy** elimina el ticket i ja no serà vàlid.

```
Valid starting     Expires            Service principal
11/14/19 11:54:50  11/15/19 11:54:50  krbtgt/SERGI.CAT@SERGI.CAT

[root@kclient docker]# kdestroy
```
* L'ordre **kadmin** ens comunica amb el dimoni kadmind. Aquesta ordre s'utilitza per administrar la base de
dades de kerberos. En aquest cas, ens autenticarem amb un usuari privilegiat.

```
[root@kclient docker]# kadmin -p pere/admin
Authenticating as principal pere/admin with password.
Password for pere/admin@SERGI.CAT: 
kadmin:  listprincs
K/M@SERGI.CAT
anna/admin@SERGI.CAT
jordi@SERGI.CAT
kadmin/admin@SERGI.CAT
kadmin/changepw@SERGI.CAT
kadmin/kserver.sergi.cat@SERGI.CAT
kiprop/kserver.sergi.cat@SERGI.CAT
krbtgt/SERGI.CAT@SERGI.CAT
marta@SERGI.CAT
pau@SERGI.CAT
pere/admin@SERGI.CAT
sergi@SERGI.CAT


```
