FROM yarp:v3.3.1_opengl

ARG SOURCE_FOLDER=/usr/local/src

RUN apt update && \
	apt install -y \
	curl \
	git \
	gnupg2

RUN curl -sSL http://get.gazebosim.org | sh

RUN cd $SOURCE_FOLDER && \
     git clone https://github.com/event-driven-robotics/gazebo-yarp-plugins.git && \
     cd gazebo-yarp-plugins && \
     mkdir build && \
     cd build/ && \
     cmake .. && \
     make -j 8 install