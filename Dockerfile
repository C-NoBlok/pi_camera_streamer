FROM ubuntu:latest

run apt-get update && apt-get -y upgrade 

run apt -y install alsa-base alsa-utils
run apt -y install ffmpeg

workdir /home
add ./stream.sh .

# cmd ["sh", "./stream.sh]

