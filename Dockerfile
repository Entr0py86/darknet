FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04


MAINTAINER Loreto Parisi loretoparisi@gmail.com 

# working directory
WORKDIR /darknet
# set noninteractive for TZ data install. Need to pass TZ as env parameter to image
ARG DEBIAN_FRONTEND=noninteractive
# install
RUN \
	apt-get update && apt-get install -y \
	autoconf \
        automake \
	libtool \
	build-essential \
	git 
#	libopencv-dev

# addons
RUN \
	apt-get install -y \
	wget

# build repo
RUN \
	git clone https://github.com/Entr0py86/darknet
	
WORKDIR darknet
RUN \
	sed -i 's/GPU=.*/GPU=1/' Makefile && \
#	sed -i 's/OPENCV=.*/OPENCV=1/' Makefile && \
	make

# download weights full (accurate most) and tiny (faster , less accurate) models
# darknet rnns
RUN \ 
	wget https://pjreddie.com/media/files/yolov3.weights >/dev/null 2>&1
	
# test nvidia docker
CMD nvidia-smi -q

# defaults command
CMD ["bash"]


