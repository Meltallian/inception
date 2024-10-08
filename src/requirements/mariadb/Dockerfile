FROM debian

RUN apt-get update -y && apt-get install mariadb-server -y

#clean cache files
RUN rm -rf /var/lib/apt/lists/*  

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/mariadb.sh /tmp/mariadb.sh

# Make sure the script is executable
RUN chmod +x /tmp/mariadb.sh  

CMD ["/tmp/mariadb.sh"]

# FROM alpine:3.13

# RUN    apk update && apk upgrade && apk add --no-cache \
#         mariadb \
#         mariadb-client bash
        
# COPY tools/mariadb.sh /tmp/configure.sh

# RUN rm -rf /var/lib/mysql/

# RUN chmod +x /tmp/configure.sh

# ENTRYPOINT ["sh", "/tmp/configure.sh"]
# CMD ["/usr/bin/mysqld --user=mysql --console"]
# CMD ["mysqld --user=mysql"]