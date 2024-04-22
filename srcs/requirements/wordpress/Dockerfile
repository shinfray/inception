FROM debian:bullseye

RUN apt-get -y update && apt-get upgrade -y && apt-get -y install \
  curl \
  php-fpm \
  php-mysql \
  && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

RUN service php7.4-fpm start

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp

ARG DOMAIN_NAME

WORKDIR /var/www/${DOMAIN_NAME}/html

RUN wp core download --allow-root

COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]
