FROM debian:bullseye

RUN apt-get -y update && apt-get upgrade -y && apt-get -y install \
  nginx \
  && rm -rf /var/lib/apt/lists/*

ARG DOMAIN_NAME

COPY tools/your_domain /etc/nginx/sites-available/${DOMAIN_NAME}

RUN sed -i "s/your_domain/${DOMAIN_NAME}/g" /etc/nginx/sites-available/${DOMAIN_NAME}

RUN ln -s /etc/nginx/sites-available/${DOMAIN_NAME} /etc/nginx/sites-enabled/

RUN sed -i '/server_names_hash_bucket_size/s/#\s*//' /etc/nginx/nginx.conf

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
