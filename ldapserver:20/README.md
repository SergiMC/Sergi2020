# LDAP
## @edt Sergi Muñoz Carmona ASIX M06-ASO Curs 2018-2019

## Imatge LDAP en Dockerhub:
Podeu trobar les imatges docker al Dockerhub de [sergimc](https://hub.docker.com/u/sergimc/)
* **ldap:** [ldap](https://cloud.docker.com/repository/docker/sergimc/ldapserver) (#tag: 18homes)


ASIX M06-ASO Escola del treball de barcelona

* **sergimc/ldapserver:20**  servidor ldap amb la base la dades dc=edt,dc=org.
Per posar en funcionament aquest model només es necessita un servidor ldap.


#### Configuració
Per configurar el servidor ldap, dispondrem de dos fitxers:

* *ldap.conf*
* *slapd.conf*

Els fitxers es situen en el directori **/etc/openldap/**

#### Execució

```
docker run --rm --name ldap --hostname ldap --network XXXX -d sergimc/ldapserver:20

```
