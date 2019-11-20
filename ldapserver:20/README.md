# LDAP
## @edt Sergi Muñoz Carmona ASIX M06/M11-ASO Curs 2019-2020

## Imatge LDAP en Dockerhub:
Podeu trobar les imatges docker al Dockerhub de [sergimc](https://hub.docker.com/u/sergimc/)

* **ldap:** [ldap](https://cloud.docker.com/repository/docker/sergimc/ldapserver) (#tag:20)

* **sergimc/ldapserver:20**  servidor ldap amb la base la dades dc=edt,dc=org.
Per posar en funcionament aquest model només es necessita un servidor ldap.

#### Configuració
Per configurar el servidor ldap, dispondrem de dos fitxers:

* *ldap.conf*
* *slapd.conf*

Els fitxers es situen en el directori **/etc/openldap/**

#### Execució

Executarem el docker amb l'ordre *docker run*.

```
docker run --rm --name ldap --hostname ldap --network netcompose -d sergimc/ldapserver:20

```
#### Comprovació

Comprovem que ldap està funcionant correctament i mostra els usuaris/dn's amb l'ordre **ldapsearch** en local.

```
[root@kclient docker]# ldapsearch -x -LLL -h localhost -b "dc=edt,dc=org" dn
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
