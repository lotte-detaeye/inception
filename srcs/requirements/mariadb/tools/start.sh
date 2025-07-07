#!/bin/bash
set -e

MARIADB_ROOT_PASSWORD=$(cat $MARIADB_ROOT_PASSWORD_FILE)
MARIADB_PASSWORD=$(cat $MARIADB_PASSWORD_FILE)

# if [ ! -d "/var/lib/mysql/mysql/" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    
    # Start MariaDB in background for setup (and make sure it listens to 
	# all network interfaces)
    gosu mysql mysqld --bind-address=0.0.0.0 &
    MYSQL_PID=$!
    
    # Wait for it to start
	while ! mysql -u root -e "SELECT 1" >/dev/null 2>&1; do
		echo "Waiting for MariaDB to start..."
		sleep 1
	done
    
    # Set up everything (no password needed initially)
    mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MARIADB_ROOT_PASSWORD}');"
    mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;"
    mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"
    mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO '${MARIADB_USER}'@'%';"
    mysql -u root -p${MARIADB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"
    
    # Stop background process
    kill $MYSQL_PID
    wait $MYSQL_PID
    
    echo "Database initialization completed."
# fi

echo "Starting MariaDB..."
exec gosu mysql mysqld --bind-address=0.0.0.0
