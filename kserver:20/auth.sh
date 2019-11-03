#! /bin/bash
# @edt ASIX-M011 Sergi Muñoz
# Tasca Kerberos
# -----------------

authconfig  --enableshadow --enablelocauthorize --enableldap \
            --ldapserver='ldap.sergi.cat' --ldapbase='dc=edt,dc=org' \
            --enablekrb5 --krb5kdc='kserver.sergi.cat' \
            --krb5adminserver='kserver.sergi.cat' --krb5realm='SERGI.CAT' \
            --updateall

