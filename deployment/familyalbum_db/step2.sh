#!/bin/bash

#STR=`date | md5sum | awk '{print $1}'`
#/usr/sbin/sshd -D -E /data/$STR.log
# su postgres -c '/usr/bin/postgres -D /var/lib/pgsql/data' &
# su postgres -c 'psql < /var/lib/pgsql/create_db.sql' &&
# su postgres -c 'psql familyalbum_dev < db_backup.sql'
/usr/sbin/sshd -D
