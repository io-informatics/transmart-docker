#!/bin/sh
mkdir /etc/ssl/private-copy; mv /etc/ssl/private/* /etc/ssl/private-copy/; rm -r /etc/ssl/private; mv /etc/ssl/private-copy /etc/ssl/private; chmod -R 0700 /etc/ssl/private; chown -R postgres /etc/ssl/private && /etc/init.d/postgresql start
cd /opt/transmart-data-1.2.4 && . ./vars && make -C solr start &
catalina.sh run
