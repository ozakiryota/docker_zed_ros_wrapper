########## Pull ##########
FROM stereolabs/zed:3.7-gl-devel-cuda11.4-ubuntu20.04
########## Non-interactive ##########
ENV DEBIAN_FRONTEND=noninteractive
########## Common Tools ##########
RUN apt-get update && \
    apt-get install -y \
	    vim \
    	wget \
    	unzip \
    	git \
		python3-tk
########## ROS ##########
RUN apt-get update && \
	apt-get install -y \
		lsb-release \
		curl \
		gnupg2 && \
	sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
	curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
	apt-get update && \
	apt-get install -y ros-noetic-ros-base
########## ROS setup ##########
RUN mkdir -p ~/catkin_ws/src && \
	cd ~/catkin_ws && \
	/bin/bash -c "source /opt/ros/noetic/setup.bash; catkin_make" && \
	echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc && \
	echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc && \
	echo "export ROS_WORKSPACE=~/catkin_ws" >> ~/.bashrc
########## Cache Busting ##########
ARG CACHEBUST=1
########## zed_ros_wrapper ##########
RUN apt-get update && \
	apt-get install -y python3-rosdep && \
	rosdep init && \
	rosdep update && \
	cd ~/catkin_ws/src && \
	git clone --recursive https://github.com/stereolabs/zed-ros-wrapper.git && \
	cd ~/catkin_ws && \
	/bin/bash -c "source /opt/ros/noetic/setup.bash; rosdep install --from-paths src --ignore-src -r -y" && \
	/bin/bash -c "source /opt/ros/noetic/setup.bash; catkin_make -DCMAKE_BUILD_TYPE=Release"
########## Initial Position ##########
WORKDIR /root/catkin_ws/src