#!/bin/sh

if [ ! -f /var/www/${DOMAIN_NAME}/html/wp-config.php ]; then

wp config create \
  --dbhost="${MYSQL_HOST}" \
  --dbname="${MYSQL_DATABASE}" \
  --dbuser="${MYSQL_USER}" \
  --dbpass="$(head -n 1 /run/secrets/db_password)" \
  --allow-root

wp core install \
  --url="${DOMAIN_NAME}" \
  --title="${WP_TITLE}" \
  --admin_user="${WP_ROOT_USER}" \
  --admin_password="$(head -n 1 /run/secrets/wp_root_user_password)" \
  --admin_email="${WP_ROOT_EMAIL}" \
  --allow-root

wp user create \
  "${WP_USER}" "${WP_EMAIL}" \
  --role=contributor \
  --user_pass="$(head -n 1 /run/secrets/wp_user_password)" \
  --allow-root \
  --path="/var/www/${DOMAIN_NAME}/html"

fi

php-fpm7.4 -F
