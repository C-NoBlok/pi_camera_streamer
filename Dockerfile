FROM raspbian/stretch:latest

run apt-get clean &&  apt-get update && apt-get -y upgrade 

run apt -y install alsa-base alsa-utils
run apt -y install ffmpeg
RUN apt-get install -y wget
RUN apt-get install libraspberrypi-bin -y
RUN usermod -a -G video root

workdir /home
add ./stream.sh .

cmd ["sh", "./stream.sh"]

