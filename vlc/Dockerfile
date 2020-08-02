FROM raspbian/stretch:latest

run apt-get clean && apt-get update && apt-get -y upgrade

run apt -y install vlc

workdir /home
add ./vlc_http_stream.sh ./vlc_http_stream.sh

run groupadd -r vlc && useradd --no-log-init -r -g vlc vlc
user vlc:vlc

cmd ["sh", "vlc_http_stream.sh"]
