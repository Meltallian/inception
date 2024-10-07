#!/bin/bash
if [ ! -d "/var/www/html" ]; then #si le dossier existe pas
  mkdir -p /var/www/html
fi

cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
if [ ! -f wp-cli.phar ]; then
    echo "wp-cli.phar download failed"
    exit 1
fi

chmod +x wp-cli.phar

# Download WordPress core
./wp-cli.phar core download --allow-root || { echo "WordPress download failed"; exit 1; }
# Create the wp-config.php file
./wp-cli.phar config create --dbname=wordpress --dbuser=wpuser --dbpass=password --dbhost=mariadb --allow-root || { echo "Config creation failed"; exit 1; }
# Install WordPress
./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root || { echo "WordPress install failed"; exit 1; }

#CMD sets the default command to be executed when the container starts.
#first is the executable and second is a flag that tells it to run in foreground
#and not background
php-fpm7.4 -F