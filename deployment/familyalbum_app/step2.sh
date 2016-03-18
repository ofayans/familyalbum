#!/bin/bash
export PGPASSWORD="Y0unevergueS$"
export APP_SETTINGS=config.DevelopmentConfig
export DATABASE_URL="postgresql://jamesb0nd:$PGPASSWORD@familyalbum_db/familyalbum_dev?client_encoding=utf8"
export MEDIA_FOLDER=/data
export MEDIA_THUMBNAIL_FOLDER=/data/thumbnails
export FAMILYALBUM_SECRET_KEY='U neveR gues$'
/usr/sbin/nginx
/usr/sbin/sshd -D 
