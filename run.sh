#!/bin/sh
chown -R postgres /etc/ssl/private
/etc/init.d/postgresql start
catalina.sh run
