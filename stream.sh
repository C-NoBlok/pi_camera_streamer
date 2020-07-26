ffmpeg \
	-f v4l2 \
	-framerate 25 \
	-video_size 640x480 \
	-i /dev/video0 \
	-hls_time 10 \
	-hls_list_size 10 \
	-start_number 1 \
	video_stream/picam.m3u8 
