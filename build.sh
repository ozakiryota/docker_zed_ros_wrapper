#!/bin/bash

image="zed_ros_wrapper"
tag="latest"

docker build . \
    -t $image:$tag \
    --build-arg CACHEBUST=$(date +%s)