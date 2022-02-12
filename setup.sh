#!/bin/bash

kool run setup

USER=`grep DB_USER .env | cut -f2 -d '='`
PASS=`grep DB_PASS .env | cut -f2 -d '='`
ROOT_PASS=`grep MYSQL_ROOT_PASS docker-compose.yml | awk '{ print $2 }' |  cut -f2 -d "'"`

kool exec database mysql -v -u root -p"$ROOT_PASS" laravel -e "CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS';" 2>/dev/null
kool exec database mysql -v -u root -p"$ROOT_PASS" laravel -e "GRANT ALL ON *.* TO '$USER'@'%';" 2>/dev/null
kool exec database mysql -v -u root -p"$ROOT_PASS" laravel -e "FLUSH PRIVILEGES;" 2>/dev/null

kool run reset

kool status