FROM debian:11

RUN apt-get update -y && apt-get install php-fpm php-mysql mariadb-client -y

RUN apt-get install curl -y

COPY tools/wp-script.sh /
COPY tools/wp-config.php /

RUN chmod +x /wp-script.sh

CMD ["/wp-script.sh"]