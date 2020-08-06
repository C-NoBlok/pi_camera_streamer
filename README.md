# Http Streamer
## For raspberry pi using docker-compose

### Introduction

This package was developed to quickly deploy an http video stream of the camera and any audio connected to a raspberry pi. Docker-compose is used to build up the required components into different containers.

### Setup

A raspberry pi with a camera and optional audio source. Install [docker](https://docs.docker.com/engine/install/debian/) on the raspberry pi. [Docker-Compose](https://docs.docker.com/compose/install/) is also require if not installed along side docker.  [Docker-Compose](https://docs.docker.com/compose/install/). 

clone the repository into desired directory on the raspberry pi.

`git clone https://github.com/C-NoBlok/pi_camera_streamer.git`

Move into cloned directory.

`cd pi_camera_streamer`

Deploy using make command.

`make up`

or using using docker-compose.

`docker-compose up`

### Service

Example http stream can be viewed by visiting `http://localhost/` on the host machine or `http://<pi_IP_ADDRESS>`. 

The http stream is available on port `8080/picam` of the raspberry pi and can be embedded in html using the `<video>` tag.  

The `.env` file can be used to configure port and address settings.  

The docker containers are set to always restart. This means that they will automatically start when the raspberry pi is turned on.  This is convenient and provides good portability.