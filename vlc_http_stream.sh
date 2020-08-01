#!/bin/bash

vlc --intf dummy -vvv rtsp://rtsp:($rtsp_host)/picam --sout \
                "#transcode{vcodec=theo,vb=800,acodec=vorb,ab=128,\
		channels=2,samplerate=44100,scodec=none}:http{mux=ogg,dst=:r'$HTTP_STREAM_PORT'/picam}"
