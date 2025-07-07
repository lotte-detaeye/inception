#!/bin/bash
set -e

# Load variables
export $(grep -v '^#' .env | xargs)
DB_PASSWORD=$(cat $DB_PASSWORD_FILE)
WP_PATH=/var/www/html
export $(cat /run/secrets/credentials | xargs)

# Wait for MariaDB
sleep 10

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
    	--dbpass="$DB_PASSWORD" \
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

# Add a post
EXISTS=$(wp --path="$WP_PATH" post list --post_type=post --allow-root --post_status=publish \
          --title="blessing the boats" --format=ids)

if [ -z "$EXISTS" ]; then
  wp post create  --path="$WP_PATH" \
    --allow-root \
    --post_type=post \
    --post_title="blessing the boats" \
  --post_content="$(cat <<EOF
by Lucille Clifton

                                    (at St. Mary's)
may the tide
that is entering even now
the lip of our understanding
carry you out
beyond the face of fear
may you kiss
the wind then turn from it
certain that it will
love your back     may you
open your eyes to water
water waving forever
and may you in your innocence
sail through this to that


EOF
)" \
     --post_status=publish \
     --post_author=$AUTHOR_ID
else
  echo "Post already exists with ID: $EXISTS"
fi

mkdir -p /run/php

exec php-fpm7.4 -F
