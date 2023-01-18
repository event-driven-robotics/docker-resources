FROM eventdrivenrobotics/gazebo

ARG SOURCE_FOLDER=/usr/local/src
ARG BIPEDAL_LOCOMOTION_FRAMEWORK_VERSION=v0.11.1
ARG IDYNTREE_VERSION=v8.0.1
ARG OSQP_VERSION=v0.6.2
ARG OSQPEIGEN_VERSION=v0.8.0
ARG MANIF_VERSION=0.0.4
ARG LIEGROUPCONTROLLERS_VERSION=v0.1.1
ARG TOMLPLUSPLUS_VERSION=v2.5.0


RUN apt update && apt install -y libspdlog-dev

RUN cd $SOURCE_FOLDER && \
    git clone --depth=1 --branch=$IDYNTREE_VERSION https://github.com/robotology/idyntree.git && \
    cd idyntree && \
    mkdir build && \
    cd build/ && \
    cmake .. && \
    make -j `nproc` install

RUN cd $SOURCE_FOLDER && \
    git clone --depth=1 --branch=$OSQP_VERSION --recursive https://github.com/osqp/osqp && \
    cd osqp && \
    mkdir build && \
    cd build/ && \
    cmake .. && \
    make -j `nproc` install

RUN cd $SOURCE_FOLDER && \
    git clone --depth=1 --branch=$OSQPEIGEN_VERSION https://github.com/robotology/osqp-eigen.git && \
    cd osqp-eigen && \
    mkdir build && \
    cd build/ && \
    cmake .. && \
    make -j `nproc` install

RUN cd $SOURCE_FOLDER && \
    git clone --depth=1 --branch=$MANIF_VERSION https://github.com/artivis/manif.git && \
    cd manif && \
    mkdir build && \
    cd build/ && \
    cmake .. && \
    make -j `nproc` install

RUN cd $SOURCE_FOLDER && \
    git clone --depth=1 --branch=$LIEGROUPCONTROLLERS_VERSION https://github.com/ami-iit/lie-group-controllers.git && \
    cd lie-group-controllers && \
    mkdir build && \
    cd build/ && \
    cmake .. && \
    make -j `nproc` install

RUN cd $SOURCE_FOLDER && \
    git clone --depth=1 --branch=$TOMLPLUSPLUS_VERSION https://github.com/marzer/tomlplusplus.git && \
    cd tomlplusplus && \
    mkdir build && \
    cd build/ && \
    cmake .. && \
    make -j `nproc` install

RUN cd $SOURCE_FOLDER && \
    git clone --depth=1 --branch=$BIPEDAL_LOCOMOTION_FRAMEWORK_VERSION https://github.com/ami-iit/bipedal-locomotion-framework.git && \
    cd bipedal-locomotion-framework && \
    mkdir build && \
    cd build/ && \
    cmake .. && \
    make -j `nproc` install