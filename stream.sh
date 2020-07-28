#!/bin/bash
ffmpeg \
	-f v4l2 \
	-framerate 25 \
	-video_size 640x480 \
	-i /dev/video0 \
	-hls_time 4 \
	-hls_list_size 5 \
	-hls_flags delete_segments \
	video_stream/picam.m3u8 
