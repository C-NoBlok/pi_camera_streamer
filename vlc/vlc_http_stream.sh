#!/bin/bash

while
cvlc --play-and-exit -vvv rtsp://localhost:$RSTP_HOST_PORT$RSTP_HOST_PATH --sout \
                "#transcode{vcodec=theo,vb=800,acodec=vorb,ab=128,\
		channels=2,samplerate=44100,scodec=none}:\
		http{mux=ogg,dst=:r$HTTP_STREAM_PORT$RSTP_HOST_PATH}"; 
	do
		echo "Waiting on streaming to be available..."
		sleep 1
	done
