# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lde-taey <lde-taey@student.42berlin.de>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/03/20 17:56:55 by lde-taey          #+#    #+#              #
#    Updated: 2025/07/02 19:51:19 by lde-taey         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE = docker compose -f srcs/docker-compose.yml
SERVICES := mariadb nginx wordpress
DATA_DIR = /home/lde-taey/data

.PHONY: all build rebuild up down re clean

all: build up
	
build:
	@echo "Building Docker images"
	$(COMPOSE) build

rebuild:
	@echo "Building Docker images from scratch"
	$(COMPOSE) build --no-cache

up:
	@echo "Starting all containers"
	$(COMPOSE) up -d

down:
	@echo "Stopping all containers"
	$(COMPOSE) down -v --remove-orphans

clean:
	@echo "Cleaning up everything (cache, containers, volumes, images)"
	@echo "Stopping containers..."
	@if [ -n "$$(docker ps -q)" ]; then docker stop $$(docker ps -q); fi
	@echo "Removing containers..."
	@if [ -n "$$(docker ps -a -q)" ]; then docker rm -v $$(docker ps -a -q); fi
	@echo "Removing images..."
	@if [ -n "$$(docker images -q)" ]; then docker rmi -f $$(docker images -q); fi
	@echo "Removing volumes..."
	@if [ -n "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); fi
	@echo "Cleaning data directories..."
	sudo rm -rf $(DATA_DIR)/mariadb/* 2>/dev/null || true 
	sudo rm -rf $(DATA_DIR)/wordpress/* 2>/dev/null || true
	@echo "Removing networks..."
	@if [ -n "$$(docker ps -q)" ]; then docker stop $$(docker ps -q); fi
	@echo "Cleaning up Docker system..."
	docker system prune -f

re: clean rebuild up