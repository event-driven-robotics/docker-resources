# Docker Resources
Docker images for EDPR related development environments.

## Table of Contents

   * [What is Docker?](#what-is-docker)
   * [Nomenclature](#nomenclature)
   * [Images descriptions](#images-descriptions)
   * [Getting started](#getting-started)
   * [Pulling pre-built images](#pulling-pre-built-images)
   * [Running an image into a container](#running-an-image-into-a-container)
   * [Running an image with OpenGL and NVIDIA support (Linux only)](#running-an-image-with-opengl-and-nvidia-support-linux-only)
   * [Getting helpers to easily run and start your containers (Linux only)](#getting-helpers-to-easily-run-and-start-your-containers-linux-only)
   * [Building the images yourself](#building-the-images-yourself)
   * [Useful commands](#useful-commands)

## What is Docker?

Docker provides a simple and effective way to share and maintain your development environment. Unlike virtual machines the Docker containers share the kernel with the host, but runs processes isolated from the rest of the system using the files contained in the image. The image is built using a Dockerfile, which is a set of instructions that define the base image (i.e. `ubuntu:bionic`), and eventual additional packages to be installed, environment variables to be set, config files to be modified, etc.

## Nomenclature

* **Image**: archive containing all the necessary files to run your containers. Multiple containers can be run from the same image.
* **Container**: active instance of an image. This is where you can run your applications and do your work.
* **Dockerfile**: file containing all the instructions to build your image.
* **Build**: process of creation of the image starting from a Dockerfile.
* **Run**: process of creation of a container which runs on top of an image.

## Images descriptions

You can find all the images on [DockerHub eventdrivenrobotics](https://hub.docker.com/orgs/eventdrivenrobotics):

  * [eventdrivenrobotics/yarp](https://github.com/event-driven-robotics/yarp-docker): installs yarp with python support and the event-driven repository.
  * [eventdrivenrobotics/esim](https://github.com/event-driven-robotics/esim-docker): builds on ros and sets up a workspace for the event-based simulator.
  * [eventdrivenrobotics/nvidia-docker-opengl](https://github.com/event-driven-robotics/nvidia-opengl-docker): builds on top of other to enable GPU support.
  * [eventdrivenrobotics/event-driven](https://github.com/event-driven-robotics/event-driven-docker): builds on top of yarp and adds event-driven features.
  * [eventdrivenrobotics/gazebo](https://github.com/event-driven-robotics/gazebo-docker): builds on top of yarp and adds the gazebo simulator (no ROS) together with the yarp plugins and the iCub model.
  * [eventdrivenrobotics/spinnaker](https://github.com/event-driven-robotics/spinnaker-docker): install Spinnaker environment (no OpenGL version).
  * [atis-gen3-docker](https://github.com/event-driven-robotics/atis-gen3-docker): install Prophesee drivers and dependencies needed to use correctly an Atis Gen3.

Please refer to the DockerHub organization for more details on the available tags. Tags that end with `_opengl` also come with NVIDIA and OpenGL support. Please follow the additional instructions [below](#running-an-image-with-opengl-and-nvidia-support-linux-only) if you want to use them.

## Getting started

Please follow the instructions at this [link](https://docs.docker.com/engine/install/) to install Docker on your computer. At the moment, all the images have been tested on Ubuntu 18.04, Ubuntu 18.10 and Ubuntu 20.04. Windows 10 and WSL have also been tested, but not thoroughly, so please report any issue when using other OSs. 

Once you are done with the installation, if you are not familiar with Docker, it is recommended to go through the official tutorials at this [link](https://docs.docker.com/get-started/).

## Pulling pre-built images

To pull one of the above images you can simply run:

```bash
docker pull eventdrivenrobotics/<IMAGE_NAME>:<TAG>
```

Please refer to the DockerHub repository of the specific image you want to pull for the list of available tags. If omitted the `latest` tag will be used by default.

## Running an image into a container

To run an image into a container you can run 

```bash
docker run -it --name <CONTAINER_NAME> <IMAGE_NAME>
```

**NOTE**: if the image is not available locally in your computer, Docker will look up on DockerHub for matching name and pull the image for you. In this way, you can skip the pull command.

There are several options that you can pass to the run command and it is recommended looking at the official documentation at this [link](https://docs.docker.com/engine/reference/run/). In this example, we are using the `-it` to open a bash prompt where we can start typing command that will run inside the container, isolated from the host system. Then, we are using the `--name` option to give a name to the container which would otherwise be given a random name from Docker.

## Running an image with OpenGL and NVIDIA support (Linux only)

To obtain NVIDIA and OpenGL support, you must first install the `nvidia-container-runtime` following the instruction at this [link](https://github.com/NVIDIA/nvidia-container-runtime).


Then, a few options must be added to the run command, as shown in the following:

```bash
docker run -it -v /dev/:/dev --runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=graphics --name <CONTAINER_NAME> <IMAGE_NAME>
```

⚠️ For newer versions of Ubuntu (>21.04) the nvidia-container-runtime might throw an error related to cgroup. (See [issue](https://github.com/NVIDIA/nvidia-docker/issues/1447)). To workaround this you can switch to the previous version of cgroup adding the following line to the kernel parameters `systemd.unified_cgroup_hierarchy=0`. Please refere to this [instructions](https://wiki.archlinux.org/title/Kernel_parameters#systemd-boot) to see how to modify these parameters.

## Getting helpers to easily run and start your containers (Linux only)

Since typing a run command with several options might become tedious, it is recommended to source the `bashrc_docker` available in this repo, which provides a few helpers to speed up your work-flow.

To do that, either download the file `bashrc_docker`  or clone this repo, and add to your `.bashrc` the following lines:

```bash
PATH_TO_CODE=/path/to/code
PATH_TO_DATA=/path/to/data
PATH_TO_APP=/path/to/app
source /path/to/bashrc_docker
```

where you need to specify the path to the `bashrc_docker` file you just downloaded and, optionally but strongly recommended, the path to where you keep your code, your data and your applications. These three directories will be shared with the running container so that you can work on the code that is stored in your host machine (and not risk to lose your work), get the data you need to run the code, and eventually run some applications (i.e. IDEs) from within your container. You will find them inside the container at `/data`, `/code`, `/apps`.

After restarting the bash, you will have available on your command line three functions with auto-complete support:

* `run_docker <IMAGE_NAME> <CONTAINER_NAME> [ADDITIONAL OPTIONS]`
Runs an image into a specified container with X server forwarding for running GUIs, and binds three directories from your host system as specified above.
* `run_docker_opengl <IMAGE_NAME> <CONTAINER_NAME> [ADDITIONAL OPTIONS]`
Adds the OpenGL specific options to `run_docker`.
* `start_docker <CONTAINER_NAME>`
Starts and executes a bash on the specified container (must be run first).

The above commands also enable screen forwarding. For it to properly work you need to authorize docker to run GUI on the XServer using the command:
`xhost local:docker`. This command needs to be run on every reboot. To avoid that and permanently authorize docker you can add the following lines to the `/etc/profile` file:

```
if [ "$DISPLAY" != "" ]
then
 xhost local:docker
fi
```

## Building the images yourself

Sometimes, you want to build the image yourself with different arguments or with some slight modification to the Dockerfile.

  Firstly, you have to clone this repo in your workspace: 

  ```bash
  git clone https://github.com/event-driven-robotics/docker-resources.git
  ```

  Then, you need to download the submodules which contain the Dockerfiles for each image:

   ```bash
   cd docker-resources
   git submodule update --init
   ```

   Now, you can run the build command. In this example we will build [eventdrivenrobotics/yarp](https://github.com/event-driven-robotics/yarp-docker):

   ```bash
   docker build -t yarp:custom_build yarp
   ```
   In this example, we are providing the `-t` option which allows us to specify a name and a tag in the form `image_name:tag`.

   Usually, if you need to build the image yourself, it is because you want to specify different build arguments, like in the following example:

  ```bash
  docker build -t yarp:v3.2.1 --build-arg YARP_VERSION=3.2.1
  ```

   Please refer to the specific repository you want to build for more details on the available build arguments.

   Again, it is recommended to go through the official documentation for the build command at this [link](https://docs.docker.com/engine/reference/commandline/build/).


 ## Useful commands 

  * `docker run -it --name <CONTAINER_NAME> <IMAGE_NAME>` to run a container in interactive mode.
  * `docker ps -a` to obtain the list of your containers.
  * `docker images` to obtain the list of your images.
  * `docker exec -it <CONTAINER_NAME> bash` to run a bash inside a container.
  * `docker build [OPTIONS] PATH | URL | -` to build Docker images from a Dockerfile. 
  * `docker rmi <IMAGE_NAME>`to remove an image. **NOTE**: all containers and images based on the image to remove must be removed first. 
  * `docker start <CONTAINER_NAME>`to start a container.
  * `docker stop <CONTAINER_NAME>`to stop a container.
  * `docker rm <CONTAINER_NAME>`to remove a container. **NOTE**: container must be stopped first.
