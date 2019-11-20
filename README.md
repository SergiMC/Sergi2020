# Pràctica Kerberos (ldap+samba+kerberos+client+nfs)
@edt Sergi Muñoz Carmona ASIX M11 2019-2020

## Imatges en Dockerhub:
Podeu trobar les imatges docker al Dockerhub de [sergimc](https://hub.docker.com/u/sergimc/)
* **ldapserver:20** [ldapserver](https://hub.docker.com/repository/docker/sergimc/ldapserver) (#tag: 20)
* **samba:20** [samba](https://hub.docker.com/repository/docker/sergimc/samba/general) (#tag: 20)
* **kserver:20** [kserver](https://hub.docker.com/repository/docker/sergimc/kserver) (#tag: 20)
* **kclient:20** [kclient](https://hub.docker.com/repository/docker/sergimc/kclient) (#tag:20)
* **nfsserver:20** [nfsserver]()

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

#### Verificacions

