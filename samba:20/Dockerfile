# Version: 0.0.1
# @edt Sergi Muñoz Carmona
# Servidor Samba
# -------------------------------------
FROM fedora:27
LABEL author="@edt ASIX SergiMC"
LABEL description="SAMBA server 2019-2020"
RUN dnf -y install procps passwd samba samba-client openldap-clients nss-pam-ldapd authconfig pam_mount
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]

