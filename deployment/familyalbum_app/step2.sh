#!/bin/bash
. sourceme
/usr/sbin/nginx
/usr/bin/memcached -u memcached -d
/usr/sbin/sshd -D &
screen familyalbum/manage.py runserver
