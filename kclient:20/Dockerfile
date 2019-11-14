# Version: 0.0.1
# @edt Sergi Muñoz Carmona 2019-2020
# kclient 
# -------------------------------------
FROM fedora:27
LABEL author="@edt ASIX Sergi Muñoz Carmona"
LABEL description="kclient 2019-2020"
RUN dnf -y install krb5-workstation passwd authconfig pam_krb5 openldap-clients nss-pam-ldapd procps pam_mount cifs-utils openssh-clients
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]

