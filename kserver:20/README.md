# Kerberos Server
## @edt ASIX M11-SAD 2019-2020

**sergimc/kserver:20** servidor kerberos detach. Servidor que autentica els usuaris (AP *autentication provides*) i crea
els principals dels usuaris LDAP.

Les autenticacions dels usuaris es defineixen mitjançant el ticket de kerberos vàlid.

### Configuració

1. Configurem el fitxer **krb5.conf** i editem el REALM i Dominis.
2. Configurem el fitxer **kdc.conf** i editem el REALM.
3. Creem la base de dades amb l'eina **kdb5_util**.
4. Definim les acls dels principals al fitxer **kadm5.acl**.
5. Crearem els principals als usuaris que es volen incorporar al kerberos.


### Usuaris 

* Usuaris ldap: pere, marta , pau, jordi ,anna, admin.
* Usuaris admin Kerberos: pere/admin, marta/admin.


### Execució:

```
docker run --rm --name kserver.sergi.cat --hostname kserver.sergi.cat --net netcompose -d sergimc/kserver:20
```
### Comprovació:


