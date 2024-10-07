FROM debian:11

RUN apt-get update -y \
	&& apt install -y nginx && apt install openssl -y

COPY tools/nginx-script.sh /
#COPY conf/default /etc/nginx/sites-available/

RUN chmod +x /nginx-script.sh

CMD ["/nginx-script.sh"]