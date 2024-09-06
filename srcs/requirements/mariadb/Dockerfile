
FROM debian:11
# && apt upgrade
RUN apt-get update -y && apt-get install -y mariadb-server -y && \
	rm -rf /var/lib/apt/lists/*

RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.

COPY init.sql /etc/mysql/init.sql
COPY script.sh .

RUN mkdir /run/mysqld && chmod +x script.sh

CMD ["./script.sh"]