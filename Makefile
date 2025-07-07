COMPOSE = docker compose -f srcs/docker-compose.yml
SERVICES := mariadb nginx wordpress
DATA_DIR = /home/lde-taey/data

.PHONY: help all build rebuild up down re clean

help:
	@echo "You will also need a folder called '/home/dockerfolder/data' for the volumes"
	@echo ""
	@echo "Available commands:"
	@echo "  make all        - Default target: builds and starts containers"
	@echo "  make build      - Build Docker images"
	@echo "  make rebuild    - Build Docker images from scratch (no cache)"
	@echo "  make up         - Start all containers"
	@echo "  make down       - Stop all containers and remove volumes and orphans"
	@echo "  make clean      - Stop and remove all Docker containers, images, volumes, and local data"
	@echo "  make re         - Clean, rebuild, and start containers (same as 'make clean rebuild up')"
	@echo "  make help       - Show this help message"

all: build up
	
build:
	@echo "Building Docker images"
	$(COMPOSE) build

rebuild:
	@echo "Building Docker images from scratch"
	$(COMPOSE) build --no-cache

up:
	@echo "Starting all containers"
	$(COMPOSE) up

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
