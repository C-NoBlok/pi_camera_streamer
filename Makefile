.PHONY: help

# This self documents the make file
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

deploy: stop ## Deploys rtsp, ffmpeg, and vlc clients
	docker build --tag ffmpeg:latest ffmpeg/.
	docker build --tag vlc:latest vlc/.
	docker run --rm -d --network=host --name rtsp aler9/rtsp-simple-server
	docker run -it -d --env-file ./.env --privileged --device=/dev/vchiq:/dev/vchiq --device=/dev/snd:/dev/snd --name ffmpeg ffmpeg:latest
	docker run -it -d --env-file ./.env -p 8080:8080 --name vlc vlc:latest

stop:  ## stops rtsp, ffmpeg and vlc clients
	( docker stop ffmpeg && docker rm ffmpeg ) || true
	( docker stop rtsp && docker rm rtsp ) || true
	( docker stop vlc && docker rm vlc ) || true
	

build-ffmpeg: ## build docker container for pi_stream
	docker build --tag pi_stream:latest ffmpeg

build-vlc: ## Build docker container for vlc
	docker build --tag vlc:latest vlc

run-ffmpeg: ## Runs pi_stream container
	docker run -it --privileged -v ~/video_stream:/home/video_stream --name ffmpeg ffmpeg:latest
	
run-vlc: ## Runs pi_stream container
	docker run -it --env-file .env --name vlc vlc:latest

b-run-ffmpeg: ## Starts container in bash
	docker run -it --privileged -v ~/video_stream:/home/video_stream ffmpeg:latest /bin/bash
	
b-run-vlc: ## Starts container in bash
	docker run -it vlc:latest /bin/bash

clean-stream: ## clean video stream folder
	rm ~/video_stream/picam*

stop-ffmpeg: ## stops pi_stream container
	docker stop ffmpeg
	docker rm ffmpeg

stop-vlc: ## stops pi_stream container
	docker stop vlc
	docker rm vlc

up: ## spins up nginx and pi_stream stream
	python3 ./nginx/html_gen.py
	docker-compose up -d

down: ## tears down docker containers
	docker-compose down

up-build: ## setups up docker compose building new images
	docker-compose up -d --build

picam-stream: ## starts picam stream and publihes to local rtsp server:
	sh ./ffmpeg/wireless_stream.sh
	

simple-rtsp:  ## deploy rtsp-simple-server docker container
	docker run --rm -d --network=host aler9/rtsp-simple-server

rtsp2http:  ## Uses vlc to transcode rtsp signal to http
	vlc --intf dummy -vvv rtsp://localhost:8554/picam --sout \
		'#transcode{vcodec=theo,vb=800,acodec=vorb,ab=128,\
		channels=2,samplerate=44100,scodec=none}:http{mux=ogg,dst=:8080/picam}'

pi-stream: simple-rtsp picam-stream rtsp2http ## Launch pi streaming components
