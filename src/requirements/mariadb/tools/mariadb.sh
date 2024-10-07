# #!/bin/sh
# if [ ! -d "/run/mysqld" ]; then
# 	mkdir -p /run/mysqld
# 	chown -R mysql:mysql /run/mysqld
# fi

# if [ ! -d "/var/lib/mysql/mysql" ]; then
# 	chown -R mysql:mysql /var/lib/mysql

# 	# service mariadb start

# 	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql -rpm > dev/null


# 	echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" > db1.sql
# 	echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD' ;" >> db1.sql
# 	echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';" >> db1.sql
# 	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> db1.sql
# 	echo "FLUSH PRIVILEGES;" >> db1.sql

# 	# kill $(cat /var/run/mysqld/mysqld.pid)
# 	mysqld --user=mysql --bootstrap < db1.sql
# 	# mysql < db1.sql
# fi

# exec mysqld --user=mysql --console

#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then

    chown -R mysql:mysql /var/lib/mysql

    # init database
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

    tfile=mktemp
    if [ ! -f "$tfile" ]; then
        return 1
    fi

    # https://stackoverflow.com/questions/10299148/mysql-error-1045-28000-access-denied-for-user-billlocalhost-using-passw
    cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM    mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '12345';

CREATE DATABASE $DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$DB_USER'@'%' IDENTIFIED by '$DB_PWD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';

FLUSH PRIVILEGES;
EOF
    # run init.sql
    /usr/bin/mysqld --user=mysql --bootstrap < $tfile
    rm -f $tfile
fi

exec /usr/bin/mysqld --user=mysql --console