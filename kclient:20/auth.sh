#! /bin/bash
# @edt Sergi Muñoz Carmona
# auth.sh
# -----------------

authconfig  --enableshadow --enablelocauthorize --enableldap \
            --ldapserver='ldap.sergi.cat' --ldapbase='dc=edt,dc=org' \
            --enablekrb5 --krb5kdc='kserver.sergi.cat' \
            --krb5adminserver='kserver.sergi.cat' --krb5realm='SERGI.CAT' \
            --updateall

