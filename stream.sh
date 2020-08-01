#!/bin/bash

ffmpeg -f alsa -i plughw:2,0 \
		-f v4l2 -framerate 25 -video_size 640x480 -i /dev/video0 \
		-f rtsp rtsp://rtsp:${RSTP_HOST_PORT}
