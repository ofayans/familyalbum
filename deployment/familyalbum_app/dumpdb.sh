#!/bin/bash
. /root/sourceme
pg_dump -f /data/$1 -F t -d familyalbum_dev -h familyalbum_db -U jamesb0nd
