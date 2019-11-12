# Servidor SAMBA
## @edt Sergi Muñoz Carmona ASIX M11-ASO Curs 2019-2020

## Imatge servidor SAMBA en Dockerhub
Podeu trobar les imatges docker al Dockerhub de [sergimc](https://hub.docker.com/u/sergimc/)
* **samba:** [samba:20](https://cloud.docker.com/repository/docker/sergimc/samba) (#tag: 20)

### Imatge:

* **sergimc/samba:20** Servidor SAMBA que comparteix recursos anomenats shares dels usuaris locals i
LDAP(Unix). Es creen els directoris dels usuaris ldap, se'ls assigna la propietat i grup. S'exporten els
homes i shares dels usuaris.

Per posar en funcionament aquest model es necessàri un server ldap+kerberos+kclient

### Arquitectura:
Per a que dins d'un host es muntin els homes dels usuaris unix i ldap via samba necessitem:
  - Una xarxa propia per als conjunt de containers que utilitzem: netcompose.
  - Un servidor ldap amb els usuaris de xarxa: sergimc/ldapserver:20.
  - Un servidor samba que exporti els homes dels usuaris samba.
  - Un servidor kerberos que proporciona el servei d'autenticació dels usuaris.
  - Un kclient que està configurat amb el PAM per poder montar els homes dels usuaris i
    per comprovar les tasques.

#### Comprovacions:

LOCALMENT:
```
[root@samba docker]# smbclient -U pere //localhost/pere
Enter MYGROUP\pere's password: 
Try "help" to get a list of possible commands.
smb: \> ls
  .                                   D        0  Mon Nov 11 11:05:55 2019
  ..                                  D        0  Mon Nov 11 11:05:55 2019
  README.md                           N        2  Mon Nov 11 11:05:55 2019

```


FORA:

```
mount -t cifs -o guest //172.24.0.4/documentation /mnt
[root@192 ~]# mount -t cifs
//172.24.0.4/documentation on /mnt type cifs (rw,relatime,vers=default,sec=none,cache=strict,domain=,uid=0,noforceuid,gid=0,noforcegid,addr=172.24.0.4,file_mode=0755,dir_mode=0755,nounix,serverino,mapposix,rsize=1048576,wsize=1048576,echo_interval=60,actimeo=1)
````


