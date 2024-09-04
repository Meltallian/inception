
FROM debian:11

#WordPress is a PHP application that requires a web server (like Nginx or Apache) 
#and a PHP processor (like php-fpm) to run.
#Simply installing WordPress without setting up a PHP processor would not 
#allow the PHP code in WordPress to be executed.
## php-mysqli is for php to be able to access the database
### curl is to dl the script to install the wordpress webste
#Added --no-install-recommends to avoid installing unnecessary packages, helping to keep the image lean.
#Added ca-certificate so wordpress can download the link in the script
RUN apt-get update && apt-get install -y --no-install-recommends php-fpm \
	-y php-mysqli \
	curl \
	ca-certificates

#fix an error where directory was missing
RUN	mkdir -p /run/php && chown www-data:www-data /run/php 


COPY www.conf /etc/php/7.4/fpm/pool.d/
COPY script.sh .

RUN chmod +x script.sh

CMD ["./script.sh"]