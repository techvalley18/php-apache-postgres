#!/bin/bash

service memcached start

service apache2 stop

rm -f /run/apache2/apache2.pid

source /etc/apache2/envvars
exec apache2 -D FOREGROUND
