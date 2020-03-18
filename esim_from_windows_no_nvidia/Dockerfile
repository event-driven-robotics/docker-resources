FROM ros:melodic

RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update && \
        apt-get install -y \
        python-catkin-tools \
        python-vcstool \
        ros-melodic-pcl-ros \
        libglfw3 libglfw3-dev \
        libglm-dev \
        ros-melodic-hector-trajectory-server \
        git \
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
		libglu1-mesa-dev \
		freeglut3-dev \
		mesa-common-dev \
		mesa-utils \
		ffmpeg \
		gedit \
		nano \
	&& apt-get autoremove \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN mkdir -p /sim_ws/src
WORKDIR /sim_ws
RUN catkin config --extend /opt/ros/melodic --cmake-args -DCMAKE_BUILD_TYPE=Release

WORKDIR /sim_ws/src
RUN git clone https://github.com/uzh-rpg/rpg_esim.git
RUN sed -i -e's/git\@github.com:/https:\/\/github.com\//g' rpg_esim/dependencies.yaml

RUN vcs-import < rpg_esim/dependencies.yaml

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
RUN /bin/bash -c 'source /ros_entrypoint.sh && catkin build esim_ros'

RUN echo "source /sim_ws/devel/setup.bash" >> ~/.bashrc

RUN useradd -ms /bin/bash unreal

RUN sed -i -e 's/\/home\/user//g' /sim_ws/src/rpg_esim/event_camera_simulator/esim_ros/cfg/multi_objects.conf
RUN sed -i -e 's/\/home\/user//g' /sim_ws/src/rpg_esim/event_camera_simulator/esim_ros/cfg/opengl.conf
RUN sed -i -e 's/\/home\/user//g' /sim_ws/src/rpg_esim/event_camera_simulator/esim_ros/cfg/example.conf
RUN sed -i -e 's/\/home\/user//g' /sim_ws/src/rpg_esim/event_camera_simulator/esim_ros/cfg/obstacle.conf
RUN sed -i -e 's/\/home\/user//g' /sim_ws/src/rpg_esim/event_camera_simulator/esim_ros/cfg/panorama.conf 
RUN sed -i -e 's/\/home\/user//g' /sim_ws/src/rpg_esim/event_camera_simulator/esim_ros/cfg/unrealcv.conf 
RUN sed -i -e 's/\/home\/user//g' /sim_ws/src/rpg_esim/event_camera_simulator/esim_ros/cfg/sponza.conf 

RUN pip3 install youtube-dl

RUN echo "unreal:Docker!" | chpasswd

WORKDIR /