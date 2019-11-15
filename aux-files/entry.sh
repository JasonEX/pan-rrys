#!/bin/sh
adduser -D www-data 
groupmod -o -g ${GID} www-data
usermod -o -u ${UID} www-data
chown -R www-data:www-data /rrys

su -c '/rrys/rrshareweb/rrshareweb' www-data

exec "$@"