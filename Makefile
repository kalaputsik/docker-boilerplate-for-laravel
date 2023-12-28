SERVICE_APP=app

help: ## Print help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

docker-reset: ## Reset docker: Stops and removes all containers, networks, and volumes. Then builds and starts the containers.
	@docker compose down -v --remove-orphans
	@docker compose build --no-cache
	@docker compose up -d --force-recreate --remove-orphans

docker-clean: ## Clean Docker: Removes all unused containers, networks, images, and volumes.
	@docker compose down -v --remove-orphans
	@docker system prune -af

app-cli: ## CLI into SERVICE_APP: Starts a shell in the app service's container.
	@docker compose exec -it ${SERVICE_APP} sh

create-laravel-project: ## Create Laravel project: Creates a new Laravel project in the app service's container.
	composer create-project laravel/laravel src
