#!/bin/bash
export PGPASSWORD="Y0unevergueS$"
export APP_SETTINGS=config.DevelopmentConfig
export DATABASE_URL="postgresql://JAmesB0nd:$PGPASSWORD@localhost/familyalbum_dev"
export MEDIA_FOLDER=/data
export MEDIA_THUMBNAIL_FOLDER=/data/thumbnails
export FAMILYALBUM_SECRET_KEY='U neveR gues$'
/usr/sbin/sshd -D 
