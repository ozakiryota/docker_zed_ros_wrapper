#!/bin/bash

xhost +

image="zed_ros_wrapper"
tag="latest"

docker run \
	-it \
	--rm \
	-e "DISPLAY" \
	-v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--gpus all \
	--net=host \
	$image:$tag