all: up

up: dep
	@docker compose -f srcs/docker-compose.yml up -d

down: 
	@docker compose -f srcs/docker-compose.yml down

start: 
	@docker compose -f srcs/docker-compose.yml start

stop: 
	@docker compose -f srcs/docker-compose.yml stop

status: 
	@docker ps

re: dep
	@docker compose -f srcs/docker-compose.yml up -d --build

clean: 
	@docker compose -f srcs/docker-compose.yml down --rmi all -v

destroy:
	@tools/destroy.sh

update_ssl_certificate:
	@tools/update_ssl_certificate.sh

dep: 
	@sudo tools/check_hosts.sh
	@mkdir -p $$HOME/data/mariadb
	@mkdir -p $$HOME/data/wordpress
	@tools/generate_missing_secrets.sh

.PHONY: all up down start stop status re clean destroy update_ssl_certificate dep
