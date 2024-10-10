# Define the path to the docker-compose file in the srcs folder
DCOMPOSE_FILE := srcs/docker-compose.yml

# Default target to bring up the docker-compose services
up:
	@echo "Starting Docker Compose services..."
	docker compose -f $(DCOMPOSE_FILE) up

# Bring down the docker-compose services
down:
	@echo "Stopping Docker Compose services..."
	docker compose -f $(DCOMPOSE_FILE) down

# Build the docker-compose services without cache
build:
	@echo "Building Docker Compose services..."
	docker compose -f $(DCOMPOSE_FILE) build --no-cache


# View docker-compose logs
logs:
	@echo "Showing logs for Docker Compose services..."
	docker compose -f $(DCOMPOSE_FILE) logs -f

# Stop services without removing containers, volumes, networks
stop:
	@echo "Stopping Docker Compose services..."
	docker compose -f $(DCOMPOSE_FILE) stop

# Remove all unused images, containers, and networks (cleanup)
cleanup:
	@echo "Cleaning up unused Docker resources..."
	docker system prune -f

# Remove all Docker volumes
volume-killer:
	@echo "Removing all Docker volumes..."
	docker volume prune -f