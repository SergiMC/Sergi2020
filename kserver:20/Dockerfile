# Version: 0.0.1
# @edt Sergi Muñoz Carmona
# Servidor Kerberos
# -------------------------------------
FROM fedora:27
RUN dnf -y install krb5-server krb5-workstation krb5-libs
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]

