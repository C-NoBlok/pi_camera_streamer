.PHONY: help

# This self documents the make file
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


build: ## build docker container for pi_stream
	docker build --tag pi_stream:latest .

run: ## Runs pi_stream container
	docker run -it --privileged -v ~/video_stream:/home/video_stream --name pi_stream pi_stream:latest

run-bash: ## Starts container in bash
	docker run -it --privileged -v ~/video_stream:/home/video_stream pi_stream:latest /bin/bash

clean-stream: ## clean video stream folder
	rm ~/video_stream/picam*

stop: ## stops pi_stream container
	docker stop pi_stream
	docker rm pi_stream

up: ## spins up nginx and pi_stream stream
	docker-compose up -d

down: ## tears down docker containers
	docker-compose down


