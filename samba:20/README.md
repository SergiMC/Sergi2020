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
    
Configuracio d'acceś al servidor LDAP:

-Per usuaris unix:
  - Samba requereix que els usuaris unix existeixin, poden ser locals o de xarxa via LDAP.
   El servidor samba ha d'estat configurat amb nscd i nslcd per poder accedir al ldap. Per
   poder confirmar i provar que tot està ben configurat, utilitzarem les eines getent  per poder
   llistar tots els usuaris i grups de xarxa.

- Per als homes:
  - Cal que els usuaris tinguin un directori home. Els usuaris locals ja tenen un directori al crear-se,
   cal crear els directoris als usuaris LDAP i assignar-li la propietat i el grup apropiat.
   
- Per als usuari samba:
  - Cal crear els comptes d'usuari samba (han d'existir el mateix usuari unix o ldap).
   Per a cada usuari crearem el seu compte amb l'ordre *smbpasswd* i assignant-li el passwd de samba.
   Es desarà en la base de dades ldap.
   
- PAM (dins del kclient:20)
  - Dins del **sergimc/kclient:20** configurarem el PAM per tal d'accedir als usuaris locals i als LDAP i utilitzant
    pam_mount.so per tal de muntar dins del home dels usuaris un home de xarxa via samba. 
    Necessitarem configurar el pam_mount.conf.xml que està a la ruta: */etc/security/pam_mount.conf.xml*
    per muntar el recurs samba dels homes.

### Execució:

Executem els containers per activar tota l'estructura.

```
docker network create netcompose

docker run --rm --name ldap.sergi.cat --hostname ldap.sergi.cat --net netcompose -d sergimc/ldapserver:20
docker run --rm --name kserver.sergi.cat --hostname kserver.sergi.cat --net netcompose -d sergimc/kserver:20
docker run --rm --name samba --hostname samba --net netcompose --privileged -d sergimc/samba:20
docker run --rm --name kclient.sergi.cat -h kclient.sergi.cat --net netcompose --privileged -it sergimc/kclient:20 

```

### Comprovacions:
Comprovarem que el servidor samba funciona correctament tant localment, com fora del docker.

Per comprovar localment utilitzarem l'ordre **smbclient** el qual ens connectarem a un usuari i llistarem els recursos.

*LOCALMENT:*
```
[root@samba docker]# smbclient -U pere //localhost/pere
Enter MYGROUP\pere's password: kpere
Try "help" to get a list of possible commands.
smb: \> ls
  .                                   D        0  Mon Nov 11 11:05:55 2019
  ..                                  D        0  Mon Nov 11 11:05:55 2019
  README.md                           N        2  Mon Nov 11 11:05:55 2019

```
Per comprovar desde fora, utilitzarem l'ordre **mount** i la ip del docker samba i el recurs que volem montar.

*FORA:*

```
mount -t cifs -o guest //172.24.0.4/documentation /mnt
[root@192 ~]# mount -t cifs
//172.24.0.4/documentation on /mnt type cifs (rw,relatime,vers=default,sec=none,cache=strict,domain=,uid=0,noforceuid,gid=0,noforcegid,addr=172.24.0.4,file_mode=0755,dir_mode=0755,nounix,serverino,mapposix,rsize=1048576,wsize=1048576,echo_interval=60,actimeo=1)
````


