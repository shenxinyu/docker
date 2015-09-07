#!/bin/sh

/usr/sbin/sshd
mkdir -p /sgn/log/dw

cp /usr/share/zoneinfo/UTC /etc/localtime
cp /root/actord.cf /root/actor/etc/
#init database and gen map
/etc/init.d/mysqld start
./dragon-server-code/sql/initDB.sh
mysql -uroot -e"CREATE DATABASE GameConfig" && \
mysql -uroot GameConfig < ./dragon-server-code/sql/GameConfig/GameConfig.sql
#php dragon-server-code/cmd/generateKingdomMap.php 1
#php dragon-server-code/cmd/generateKingdomMap.php 2
#php dragon-server-code/cmd/generateKingdomMap.php 3
#php dragon-server-code/cmd/generateKingdomMap.php 4
/etc/init.d/mysqld stop

/usr/bin/supervisord

