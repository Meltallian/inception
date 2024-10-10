#!/bin/sh
# rm -rf /var/lib/mysql
if [ ! -d "/run/mysqld" ]; then

	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld #to ensure proper ownership
fi

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
	mkdir -p /var/lib/mysql
	chown -R mysql:mysql /var/lib/mysql
	echo "MAIS OUI LE SANG"
	# service mariadb start

	mysql_install_db --datadir=/var/lib/mysql --user=mysql  #initialize the data directory

	echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" > db1.sql #populate the database with sql commands
	echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD' ;" >> db1.sql
	echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';" >> db1.sql
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PWD' ;" >> db1.sql
	echo "FLUSH PRIVILEGES;" >> db1.sql

	mysqld --datadir=/var/lib/mysql --user=mysql &
	sleep 5
	mysql < db1.sql
	# chown -R mysql:mysql /var/lib/mysql
	sleep 3
	kill $(cat /run/mysqld/mysqld.pid)
fi
sleep 3
# sleep infinity

exec mysqld --datadir=/var/lib/mysql --user=mysql


#!/bin/sh

# echo "Starting mariadb....."

# if [ ! -d "/run/mysqld" ]; then
# 	echo "creating mysql runner"
#     mkdir -p /run/mysqld
#     chown -R mysql:mysql /run/mysqld
# fi

# if [ ! -d "/var/lib/mysql/mysql" ]; then
# 	echo "Initializing mysql"
# 	mkdir -p /var/lib/mysql
#     chown -R mysql:mysql /var/lib/mysql

#     # init database provoque peutetre une erreur qui mene a un restart.
#     mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

# 	echo "Mysql initialised"
    
# 	cat << EOF > db.db
# USE mysql;
# FLUSH PRIVILEGES;

# DELETE FROM    mysql.user WHERE User='';
# DROP DATABASE test;
# DELETE FROM mysql.db WHERE Db='test';
# DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

# ALTER USER 'root'@'localhost' IDENTIFIED BY '12345';

# CREATE DATABASE $DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
# CREATE USER '$DB_USER'@'%' IDENTIFIED by '$DB_PWD';
# GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';

# FLUSH PRIVILEGES;
# EOF
# #     # run init.sql
#     # /usr/bin/mysqld --user=mysql --bootstrap < db.db
# # 	echo "Mysql booted"

# #     rm -f $tfile
# fi 

# echo "Runing mysql"

# exec /usr/bin/mysqld --user=mysql --console
#fonctionne jusqua /usr/bin/mysqld mais exit 0 pour une raison inconnue
# sleep infinity