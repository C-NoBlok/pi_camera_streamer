# FROM raspbian/stretch:latest
FROM ubuntu:bionic

run apt-get update
run apt-get install -y vlc

workdir /home
add ./vlc_http_stream.sh ./vlc_http_stream.sh

run groupadd -r vlc && useradd --no-log-init -r -g vlc vlc
user vlc:vlc

cmd ["sh", "vlc_http_stream.sh"]
