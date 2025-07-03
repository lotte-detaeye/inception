FROM debian:bookworm

# Install mariadb
RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends \
		mariadb-client \
		mariadb-server \
		net-tools \
		gosu && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Handle permissions
RUN mkdir -p /run/mysqld 
RUN chown -R mysql:mysql /var/lib/mysql /etc/mysql /run/mysqld

# Copy a custom mariadb configuration file
COPY ./conf/mariadb.conf /etc/mysql/conf.d

# Create a startup script
COPY ./tools/start.sh /start.sh
RUN chmod +x /start.sh

# Start the script
CMD ["/start.sh"]