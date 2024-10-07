# FROM debian

# RUN apt-get update -y && apt-get install mariadb-server -y

# # \
# 	# && rm -rf /var/lib/apt/lists/*

# # RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client bash

# # COPY conf/mysqld.conf /etc/mysql/mariadb.conf.d/

# COPY ./tools/mariadb.sh /tmp/mariadb.sh

# #might not exist so we create
# # RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld 
# # Make sure the script is executable
# # RUN chmod +x /tmp/mariadb.sh  

# # CMD ["bash /mariadb.sh"] 
# # cmd ["bash"]
# ENTRYPOINT ["sh", "/tmp/mariadb.sh"]

FROM alpine:3.13

RUN    apk update && apk upgrade && apk add --no-cache \
        mariadb \
        mariadb-client
        
COPY tools/mariadb.sh /tmp/configure.sh

ENTRYPOINT ["sh", "/tmp/configure.sh"]