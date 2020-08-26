#!/bin/bash

while
{
ffmpeg -f alsa -i plughw:2,0 \
		-f v4l2 -framerate $FRAME_RATE -video_size $STREAM_RESOLUTION -i /dev/video0 \
		-f rtsp rtsp://simple-rtsp:$RSTP_HOST_PORT$RSTP_HOST_PATH
	} ||
{
ffmpeg -f alsa -i plughw:1,0 \
		-f v4l2 -framerate $FRAME_RATE -video_size $STREAM_RESOLUTION -i /dev/video0 \
		-f rtsp rtsp://simple-rtsp:$RSTP_HOST_PORT$RSTP_HOST_PATH
	} ||
{
ffmpeg \
		-f v4l2 -framerate $FRAME_RATE -video_size $STREAM_RESOLUTION -i /dev/video0 \
		-f rtsp rtsp://simple-rtsp:$RSTP_HOST_PORT$RSTP_HOST_PATH
	};
do
	echo "Connecting with Camera and RSTP Servier..."
	sleep 1
done
