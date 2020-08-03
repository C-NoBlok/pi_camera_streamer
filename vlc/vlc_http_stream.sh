#!/bin/bash
sleep 10
cvlc -vvv rtsp://simple-rtsp:8554/picam --sout \
                "#transcode{vcodec=theo,vb=800,acodec=vorb,ab=128,\
		channels=2,samplerate=44100,scodec=none}:http{mux=ogg,dst=:r8080/picam}"
