#!/bin/bash
set -e

WP_PATH="/var/www/html"

# WordPress DB credentials (hardcoded for now, or sourced from Docker env)
DB_NAME="wordpress"
DB_USER="dbuser"
DB_PASS="hello2000"
DB_HOST="mariadb:3306"

ADMIN_USER="site_manager"
ADMIN_EMAIL="lde-taey@student.42berlin.de"
ADMIN_PASS="heatWave42!"
SITE_URL="https://lde-taey.42.fr" # TODO is this right?
SITE_TITLE="Welcome to the Interwebz"

# Extra user credentials
EXTRA_USER="Mr. Bojangles"
EXTRA_PASS="hellothere"
EXTRA_EMAIL="mrbojangles@yahoo.com"
EXTRA_ROLE="author"   # roles: subscriber, contributor, author, editor

sleep 15

# Download WordPress if missing
if [ ! -f /var/www/html/wp-config.php ]; then
	echo "Installing Wordpress"
	wget https://wordpress.org/wordpress-6.8.tar.gz -P /tmp
	tar -xzf /tmp/wordpress-6.8.tar.gz -C /var/www/html --strip-components=1
	rm /tmp/wordpress-6.8.tar.gz
	chown -R www-data:www-data /var/www/html
  chmod -R 755 /var/www/html
fi

# Create wp-config.php
if [ ! -f /var/www/html/wp-config.php ]; then
	wp config create --allow-root \
		--dbname="$DB_NAME" \
    	--dbuser="$DB_USER" \
    	--dbpass="$DB_PASS" \
    	--dbhost="$DB_HOST" \
  		--path="$WP_PATH"
fi

# Install core if not yet installed
if ! wp core is-installed --path="$WP_PATH" --allow-root; then
  echo "Installing WordPress core..."
  wp core install \
    --url="$SITE_URL" \
    --title="$SITE_TITLE" \
    --admin_user="$ADMIN_USER" \
    --admin_password="$ADMIN_PASS" \
    --admin_email="$ADMIN_EMAIL" \
    --path="$WP_PATH" \
    --allow-root
fi

# Add extra user if not already created
if ! wp user get "$EXTRA_USER" --path="$WP_PATH" --allow-root >/dev/null 2>&1; then
  echo "Creating extra user: $EXTRA_USER"
  wp user create "$EXTRA_USER" "$EXTRA_EMAIL" \
    --user_pass="$EXTRA_PASS" \
    --role="$EXTRA_ROLE" \
    --path="$WP_PATH" \
    --allow-root
fi

# Remove default 'admin' user if accidentally added
if wp user get admin --path="$WP_PATH" --allow-root >/dev/null 2>&1; then
	echo "Removing insecure admin user..."
	wp user delete admin --reassign="$ADMIN_USER" --path="$WP_PATH" --allow-root
fi

exec php-fpm8.3 -F
