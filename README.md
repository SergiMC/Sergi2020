# Pràctica Kerberos (ldap+samba+kerberos+client+nfs)
@edt Sergi Muñoz Carmona ASIX M11 2019-2020

## Imatges en Dockerhub:
Podeu trobar les imatges docker al Dockerhub de [sergimc](https://hub.docker.com/u/sergimc/)
* **ldapserver:20** [ldapserver](https://hub.docker.com/repository/docker/sergimc/ldapserver) (#tag: 20)
* **samba:20** [samba](https://hub.docker.com/repository/docker/sergimc/samba/general) (#tag: 20)
* **kserver:20** [kserver](https://hub.docker.com/repository/docker/sergimc/kserver) (#tag: 20)
* **kclient:20** [kclient](https://hub.docker.com/repository/docker/sergimc/kclient) (#tag:20)
* **nfsserver:20** [nfsserver](https://hub.docker.com/repository/docker/sergimc/nfsserver) (#tag:20)

## Imatges:
**sergimc/ldapserver:20** Servidor LDAP amb les dades de la base de dades dc=edt,dc=org Requereix de l'ús d'un servidor ldap.

**sergimc/samba:20** Servidor SAMBA que l'utilitzarem per tal de compartir els homes dels usuaris samba. 
Requereix de l'ús d'un servidor ldad i d'un hostpam (en aquest cas el kclient).

**sergimc/kclient:20** Host client amb PAM amb autenticació AP de  kerberos i IP de ldap.

**sergimc/kserver:20** Servidor kerberos detach. Servidor que autentica els usuaris (AP autentication provides) i crea els principals dels usuaris LDAP.

 **nfsserver:20** Servidor nfs

## Arquitectura i descripció:

Pràctica que utilitzarem LDAP,SAMBA,KERBEROS,CLIENT,NFS. Crearem un client que autentica usuaris globals i locals. Aquests usuaris s'autentiquen contra ldap i kerberos i es munten els seus homes via SAMBA o NFS.

**netcompose**: Una xarxa propia per als containers implicats.

**sergimc/ldapserver:20**  Un servidor ldap en funcionament amb els usuaris de xarxa.

**sergimc/samba:20** Un servidor SAMBA que l'utilitzarem per tal de compartit els homes dels usuaris samba.

**sergimc/kclient:20** Host client amb PAM amb autenticació AP de  kerberos i IP de ldap.

**sergimc/kserver:20** Servidor kerberos detach. Servidor que autentica els usuaris (AP autentication provides) i crea els principals dels usuaris LDAP.

 **nfsserver:20** Servidor nfs.

## Execució

Generarem 5 dockers amb les seves imatges corresponents amb la seva network adient.

```
docker network create netcompose

docker run --rm --name ldap.sergi.cat --hostname ldap.sergi.cat --net netcompose -d sergimc/ldapserver:20
docker run --rm --name kserver.sergi.cat --hostname kserver.sergi.cat --net netcompose -d sergimc/kserver:20
docker run --rm --name samba --hostname samba --net netcompose --privileged -d sergimc/samba:20
docker run --rm --name nfsserver --hostname nfsserver --net netcompose --privileged -d sergimc/nfsserver:20
docker run --rm --name kclient.sergi.cat -h kclient.sergi.cat --net netcompose --privileged -it sergimc/kclient:20 
```

## Verificacions

* Dins del kclient verifiquem que el home de l'usuari autenticat es munta correctament.

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
Comprovarem que hi ha connexió del client al servidor ldap amb l'ordre **ldapsearch**.
* Hem de tenir en compte la IP que té el nostre servidor LDAP.

* **Verificació LDAP:**

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
* **Verificació KERBEROS:**

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
