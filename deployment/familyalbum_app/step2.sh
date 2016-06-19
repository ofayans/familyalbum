#!/bin/bash
. /root/sourceme
/usr/bin/memcached -u memcached -d
/usr/sbin/sshd -D
