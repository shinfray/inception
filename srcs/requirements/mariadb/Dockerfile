FROM debian:bullseye

RUN apt-get -y update && apt-get upgrade -y && apt-get -y install \
  mariadb-server \
  && rm -rf /var/lib/apt/lists/*

ARG MYSQL_DATABASE
ARG MYSQL_USER

RUN --mount=type=secret,id=db_password,required \
  --mount=type=secret,id=db_root_password,required \
  service mariadb start \
  && mysql -e "CREATE DATABASE $MYSQL_DATABASE" \
  && mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$(head -n 1 /run/secrets/db_password)'" \
  && mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%'" \
  && mysql -e "FLUSH PRIVILEGES;" \
  && mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$(head -n 1 /run/secrets/db_root_password)'"

ENTRYPOINT ["/usr/sbin/mysqld"]
CMD ["--bind-address", "0.0.0.0"]
