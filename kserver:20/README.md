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

Per comprovar que funcione el servidor correctament, utilitzarem les ordres *kinit*, *klist*, *kdestroy*,*kadmin*.

* L'ordre **kinit** ens autentica l'usuari i ens proporciona un ticket de kerberos. El ticket identifica l'usuari
i ens indica els privilegis que té l'usuari

```
[root@kserver docker]# kinit pere/admin
Password for pere/admin@SERGI.CAT: 
```

* L'ordre **klist** ens llista la informació obtinguda del ticket.

```
[root@kserver docker]# klist
Ticket cache: FILE:/tmp/krb5cc_0
Default principal: pere/admin@SERGI.CAT

Valid starting     Expires            Service principal
11/14/19 12:27:59  11/15/19 12:27:59  krbtgt/SERGI.CAT@SERGI.CAT

```
* L'ordre **kdestroy** elimina el ticket i ja no serà vàlid.

```
[root@kserver docker]# kdestroy

```
* L'ordre **kadmin** ens comunica amb el dimoni kadmind. Aquesta ordre s'utilitza per administrar la base de
dades de kerberos. En aquest cas, ens autenticarem amb un usuari privilegiat.
```
[root@kserver docker]# kadmin.local -p pere/admin
Authenticating as principal pere/admin with password.
kadmin.local:  listprincs
K/M@SERGI.CAT
anna/admin@SERGI.CAT
jordi@SERGI.CAT
julia@SERGI.CAT
kadmin/admin@SERGI.CAT
kadmin/changepw@SERGI.CAT
kadmin/kserver.sergi.cat@SERGI.CAT
kiprop/kserver.sergi.cat@SERGI.CAT
krbtgt/SERGI.CAT@SERGI.CAT
marta@SERGI.CAT
pau@SERGI.CAT
pere/admin@SERGI.CAT
kadmin.local:  

```
