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
docker run --rm --name ldap --hostname ldap --network XXXX -d sergimc/ldapserver:20

```
#### Comprovació

Comprovem que ldap està funcionant correctament i mostra els usuaris/dn's amb l'ordre ldapsearch en local.

```
[root@ldap docker]# ldapsearch -x -LLL -h localhost -b "dc=edt,dc=org" dn
dn: dc=edt,dc=org

dn: ou=maquines,dc=edt,dc=org

dn: ou=clients,dc=edt,dc=org

dn: ou=productes,dc=edt,dc=org

dn: ou=usuaris,dc=edt,dc=org

dn: ou=hosts,dc=edt,dc=org

dn: ou=keys,dc=edt,dc=org

dn: ou=certs,dc=edt,dc=org

dn: ou=domains,dc=edt,dc=org

dn: o=asia,ou=clients,dc=edt,dc=org

dn: o=africa,ou=clients,dc=edt,dc=org

dn: o=europa,ou=clients,dc=edt,dc=org

dn: o=eu,o=europa,ou=clients,dc=edt,dc=org

dn: o=noneu,o=europa,ou=clients,dc=edt,dc=org

dn: uid=pau,ou=usuaris,dc=edt,dc=org

dn: uid=pere,ou=usuaris,dc=edt,dc=org

dn: uid=anna,ou=usuaris,dc=edt,dc=org

dn: uid=marta,ou=usuaris,dc=edt,dc=org

dn: uid=Jordi,ou=usuaris,dc=edt,dc=org

dn: uid=admin,ou=usuaris,dc=edt,dc=org

```
