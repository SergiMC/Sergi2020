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

## Arquitectura i descripció:

Pràctica que utilitzarem LDAP,SAMBA,KERBEROS,CLIENT,NFS. Crearem un client que autentica usuaris globals i locals. Aquests usuaris s'autentiquen contra ldap i kerberos i es munten els seus homes via SAMBA o NFS.

**netcompose**: Una xarxa propia per als containers implicats.

**sergimc/ldapserver:20**  Un servidor ldap en funcionament amb els usuaris de xarxa.

**sergimc/samba:18homes** Un servidor SAMBA que l'utilitzarem per tal de compartit els homes dels usuaris samba.
