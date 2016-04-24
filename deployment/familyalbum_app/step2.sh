#!/bin/bash
. /root/sourceme
/usr/sbin/nginx
/usr/bin/memcached -u memcached -d
/usr/sbin/sshd -D &
familyalbum/manage.py runserver
