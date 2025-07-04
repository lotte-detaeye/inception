FROM debian:bookworm

# Install Nginx and other useful programs
RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends \ 
		curl \
		iputils-ping \
		nginx \
		openssl \
		vim  && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Make sure there is a TSL certificate
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
-keyout /etc/nginx/ssl/inception.key \
-subj "/C=GE/ST=Berlin/L=Berlin/O=42/CN=inception.test"

# Change ownership and permissions
RUN chown www-data:www-data /etc/nginx/ssl
RUN chmod -R 700 /etc/nginx/ssl

# Copy necessary html files
# COPY ./tools/ /usr/share/nginx/html/

# Create a custom NginX configuration file (copying happens in yaml file)
# RUN mkdir -p /var/run/nginx /var/log/nginx /run/nginx /var/lib/nginx

# Change ownership and permissions
# RUN chown -R www-data:www-data /usr/share/nginx/html /var/lib/nginx /var/run/nginx /var/log/nginx /run/nginx
RUN chmod -R 755 /usr/share/nginx/html/ 
# /var/lib/nginx /var/run/nginx /var/log/nginx /run/nginx

# Expose port 443 for HTTPS traffic
EXPOSE 443

# Start NginX in the foreground
CMD ["nginx", "-g", "daemon off;"]