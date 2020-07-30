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

up-build: ## setups up docker compose building new images
	docker-compose up --build

picam-stream: ## starts picam stream and publihes to local rtsp server:
	ffmpeg -f alsa -i plughw:2,0 \
		-f v4l2 -framerate 25 -video_size 640x480 -i /dev/video0 \
		-f rtsp rtsp://localhost:8554/picam

simple-rtsp:  ## deploy rtsp-simple-server docker container
	docker run --rm -it --network=host aler9/rtsp-simple-server

rtsp2http:  ## Uses vlc to transcode rtsp signal to http
	vlc --intf dummy -vvv rtsp://localhost:8554/picam --sout \
		'#transcode{vcodec=theo,vb=800,acodec=vorb,ab=128,\
		channels=2,samplerate=44100,scodec=none}:http{mux=ogg,dst=:8080/picam}'

pi-stream: simple-rtsp picam-stream rtsp2http
