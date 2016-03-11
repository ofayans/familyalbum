FROM fedora:latest
RUN dnf install -y postgresql-server vim openssh-server less
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN sed -ir 's/.*ssh_host_ecdsa_key//' /etc/ssh/sshd_config
ADD .ssh /root/.ssh
ADD step2.sh /root/step2.sh
RUN chmod 755 /root/step2.sh
RUN chmod 600 /root/.ssh/ -R
USER postgres
RUN initdb /var/lib/pgsql/data
# Configure postgres
RUN echo "host all all 0.0.0.0/0 md5" >> /var/lib/pgsql/data/pg_hba.conf
RUN echo "listen_addresses = '*'" >> /var/lib/pgsql/data/postgresql.conf
ADD create_role.sql /var/lib/pgsql/create_role.sql
ADD db_backup.sql /var/lib/pgsql/db_backup.sql
WORKDIR /var/lib/pgsql
USER root
ENV PGPASSWORD='Y0unevergueS$'
EXPOSE 22 5432
CMD /root/step2.sh
