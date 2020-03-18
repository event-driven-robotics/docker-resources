FROM ubuntu:latest

RUN apt-get update && \
        apt-get install -y \
		libglu1-mesa-dev \
		freeglut3-dev \
		mesa-common-dev \
		mesa-utils \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

CMD glxgears
