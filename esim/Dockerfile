FROM ros:melodic

RUN apt-get update && \
        apt-get install -y \
        python-catkin-tools \
        python-vcstool \
        ros-melodic-pcl-ros \
        libglfw3 libglfw3-dev \
        libglm-dev \
        ros-melodic-hector-trajectory-server \
        git \
        #ros-melodic-opencv3 \
        autoconf \
        ros-melodic-eigen-conversions \
        ros-melodic-tf-conversions \
        libusb-1.0-0-dev \
        ros-melodic-camera-info-manager \
        ros-melodic-image-view \
        python3-catkin-pkg-modules \
        python3-pip \
        python3-tk \
        ros-melodic-rqt* \
        ros-melodic-rviz \
        vim \
        libglew-dev \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN mkdir -p /sim_ws/src
WORKDIR /sim_ws
RUN catkin config --extend /opt/ros/melodic --cmake-args -DCMAKE_BUILD_TYPE=Release

WORKDIR /sim_ws/src
RUN git clone https://github.com/uzh-rpg/rpg_esim.git
RUN git clone https://github.com/ethz-asl/catkin_boost_python_buildtool.git
RUN git clone https://github.com/ethz-asl/numpy_eigen.git
RUN git clone https://github.com/uzh-rpg/pangolin_catkin.git
RUN sed -i -e's/git\@github.com:/https:\/\/github.com\//g' rpg_esim/dependencies.yaml
RUN vcs-import < rpg_esim/dependencies.yaml

COPY circlesgrid.cpp rpg_dvs_ros/dvs_calibration/src/circlesgrid.cpp

WORKDIR /sim_ws/src/ze_oss
RUN touch imp_3rdparty_cuda_toolkit/CATKIN_IGNORE \
      imp_app_pangolin_example/CATKIN_IGNORE \
      imp_benchmark_aligned_allocator/CATKIN_IGNORE \
      imp_bridge_pangolin/CATKIN_IGNORE \
      imp_cu_core/CATKIN_IGNORE \
      imp_cu_correspondence/CATKIN_IGNORE \
      imp_cu_imgproc/CATKIN_IGNORE \
      imp_ros_rof_denoising/CATKIN_IGNORE \
      imp_tools_cmd/CATKIN_IGNORE \
      ze_data_provider/CATKIN_IGNORE \
      ze_geometry/CATKIN_IGNORE \
      ze_imu/CATKIN_IGNORE \
      ze_trajectory_analysis/CATKIN_IGNORE

RUN /bin/bash -c 'source /ros_entrypoint.sh && catkin build'

RUN echo "source /sim_ws/devel/setup.bash" >> ~/.bashrc
RUN cd /sim_ws/src && catkin_init_workspace

RUN useradd unreal

WORKDIR /