Adds Nvidia/OpenGL support to other docker builds. 

Requires nvidia-container-toolkit: "https://github.com/NVIDIA/nvidia-docker"

-- USAGE

Build:
docker build nvidia_docker_opengl/ --build_arg from=<BASEIMAGE> -t <BASEIMAGE>:opengl

Run:
docker run -v /dev/:/dev --runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=graphics <BASEIMAGE>:opengl
