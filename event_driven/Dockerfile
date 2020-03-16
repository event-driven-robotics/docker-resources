FROM ubuntu:disco
#COPY --from=0 /var/lib/apt/lists/* /var/lib/apt/lists/

RUN apt update

ARG YARP_BRANCH=devel
ARG YARP_BUILD_TYPE=Debug

# Install useful packages
RUN apt install -y \
        build-essential \
        git \
        cmake \
        cmake-curses-gui \
        lsb-release \
        libssl-dev

RUN apt install -y \
    apt-transport-https \
    ca-certificates \
    gnupg \
    software-properties-common \
    wget

RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add - && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main' && \
    apt update && \
    apt install kitware-archive-keyring && \
    apt-key --keyring /etc/apt/trusted.gpg del C1F34CDD40CD72DA

#Install opencv
RUN DEBIAN_FRONTEND=noninteractive apt install libopencv-dev -y

# Install yarp dependencies
RUN apt install -y \
        libgsl-dev \
        libedit-dev \
        libace-dev \
        libeigen3-dev 

# Install swig for python bindings
RUN apt install swig -y 

# Configure virtual environment for python
RUN apt install python3-pip -y

RUN pip3 install \
    virtualenv \
    virtualenvwrapper

RUN ln -s /usr/bin/python3 /usr/bin/python && \
    echo 'source /usr/local/bin/virtualenvwrapper.sh' | cat - /root/.bashrc > temp && mv temp /root/.bashrc


# Install QT5 for GUIS 
# (NOTE: may be not compatible with nvidia drivers when forwarding screen)
RUN apt install -y \
	qtbase5-dev \
    qt5-default \
    qtdeclarative5-dev \
    qtmultimedia5-dev \
    qml-module-qtquick2 \
    qml-module-qtquick-window2 \
    qml-module-qtmultimedia \
    qml-module-qtquick-dialogs \
    qml-module-qtquick-controls

# Install YARP with GUIS and Python bindings
RUN cd /usr/local/src && \
    git clone https://github.com/robotology/yarp.git &&\
    cd yarp &&\
    git checkout $YARP_BRANCH &&\
    mkdir build && cd build &&\
    cmake -DCMAKE_BUILD_TYPE=$YARP_BUILD_TYPE \
          -DYARP_COMPILE_BINDINGS=ON \
          -DCREATE_PYTHON=ON \
          -DYARP_USE_PYTHON_VERSION=3 \
          .. &&\
    make -j 8 install

# RUN ln -s /usr/local/lib/python3/dist-packages/*yarp* /usr/local/lib/python3.7/dist-packages/

RUN yarp check
EXPOSE 10000/tcp 10000/udp

# Some QT-Apps don't show controls without this
ENV QT_X11_NO_MITSHM 1

# Setup HW Acceleration for Intel graphic cards
RUN apt install -y \
        libgl1-mesa-glx \
        libgl1-mesa-dri

# nvidia-docker hooks
# LABEL com.nvidia.volumes.needed="nvidia_driver"
# ENV PATH /usr/local/nvidia/bin:${PATH}
# ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# Event-driven libraries
RUN cd /usr/local/src && \
    git clone https://github.com/robotology/event-driven.git &&\
    cd event-driven &&\
    git checkout $YARP_BRANCH &&\
    mkdir build && cd build &&\
    cmake -DCMAKE_BUILD_TYPE=$YARP_BUILD_TYPE \
          .. &&\
    make -j 8 install

# Clean the image
RUN rm -r /var/lib/apt/lists/*
