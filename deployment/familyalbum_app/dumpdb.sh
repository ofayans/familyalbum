#!/bin/bash
. /root/sourceme
pg_dump -C -f /data/$1 -F p -d familyalbum_dev -h familyalbum_db -U jamesb0nd
