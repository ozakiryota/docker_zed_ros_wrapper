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
	--privileged \
	--net=host \
	$image:$tag \
	bash -c "\
		source /opt/ros/noetic/setup.bash ; \
		source ~/catkin_ws/devel/setup.bash ; \
		roslaunch zed_wrapper zed.launch"