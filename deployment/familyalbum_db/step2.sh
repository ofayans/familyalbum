#!/bin/bash

#STR=`date | md5sum | awk '{print $1}'`
#/usr/sbin/sshd -D -E /data/$STR.log
su postgres -c '/usr/bin/postgres -D /var/lib/pgsql/data' &
su postgres -c 'psql < /var/lib/pgsql/create_role.sql'
su postgres -c 'psql -U jamesb0nd -d familyalbum_dev < /var/lib/pgsql/db_backup.sql'
/usr/sbin/sshd -D
