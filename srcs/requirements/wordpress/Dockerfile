FROM debian:bookworm

# Create necessary directories
RUN mkdir -p /var/www/html

# Install php and necessary dependencies
RUN apt-get update -y && \
    apt-get upgrade -y && \ 
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        dnsutils \
        iputils-ping \
        gnupg2 \
        libzip-dev \
        lsb-release \
        mariadb-client \
        net-tools \
        procps \
        lsof \
        openssl \
        software-properties-common \
        tar \
        wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Add PHP repository
RUN curl -fsSL https://packages.sury.org/php/apt.gpg -o /etc/apt/trusted.gpg.d/php.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

# Install PHP and extensions
RUN apt-get update -y \
&& apt-get install -y php8.3 \
    php8.3-cli \
    php8.3-curl \
    php8.3-fpm \
    php8.3-mysql \
    php-json \
    php-common && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Make sure /usr/bin/php points to php8.3
RUN ln -sf /usr/bin/php8.3 /usr/bin/php

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy script to a place where it can be executed
COPY ./tools/wp-setup.sh /usr/local/bin/wp-setup.sh

# expose port 9000 for php to work
EXPOSE 9000

ENTRYPOINT ["wp-setup.sh"]

