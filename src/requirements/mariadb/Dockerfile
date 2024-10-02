FROM debian:11

RUN apt-get update -y && apt-get install mariadb-server -y \
	&& rm -rf /var/lib/apt/lists/*

COPY conf/mysqld.conf /etc/mysql/mariadb.conf.d/

COPY tools/mariadb.sh /


CMD ["/mariadb.sh"] 