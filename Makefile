.PHONY: help

# This self documents the make file
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


build: ## build docker container for ffmpeg
	docker build --tag ffmpeg:latest .

run: ## Runs ffmpeg container
	docker run -it --name ffmpeg ffmpeg:latest

stop: ## stops ffmpeg container
	docker stop ffmpeg
	docker rm ffmpeg

up: ## spins up nginx and ffmpeg stream
	docker-compose up -d

down: ## tears down docker containers
	docker-compose down


