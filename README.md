# Docker Resources
Docker containers for EDPR related development environments

## Containers descriptions

You can find all containers on [dockerhub eventdrivenrobotics](https://hub.docker.com/orgs/eventdrivenrobotics)

  * eventdrivenrobotics/yarp: installs yarp with python support and the event-driven repository.
  * eventdrivenrobotics/esim: builds on ros and sets up a workspace for the event-based simulater.
  * eventdrivenrobotics/nvidia-docker-opengl: generic container that builds on top of other to enable GPU support.
  * eventdrivenrobotics/event-driven: generic container with event-driven yarp features.
  * eventdrivenrobotics/gazebo: generic container for robotic simulation.
  * eventdrivenrobotics/spinnaker: generic container with spinnaker environment (no opengl version).

## Installation  
  
  Firtsly, you have to clone this repo on your workspace: 
  
  `git clone https://github.com/event-driven-robotics/docker-resources.git`

  Then you need to download the containers from the dockerhub:

   `git submodule update --init`
   
  Now you only need to run your docker and create a container. Choose the image you want and give a name to the container:

  `run_docker_opengl eventdrivenrobotics/<image>:latest_opengl <container>`
  
  Once your container is created you can start your docker doing:
  
  `docker start <container>`
  
  `docker exec -it <container> bash` to open a new terminal. 
  
  If you want to make it fast put these lines into your .bashrc:
  
  ```
  start_docker(){
    if [ -z "$1" ]
    then
        echo "Provide container to start"
        echo "Usage: start_docker <container_name>"
        return
    fi
    docker start $1
    docker exec -it $1 bash
   }
   ```
   
   Now if you want to start your docker you only have to type:
   
   `start_docker <container name>`
  
 ## Useful commands 
  
  * `docker run -it --name <name>` to instanciate a container
  * `docker ps` to obtain the list of your containers
  * `docker exec -it <container> bash` to open a new terminal.
  * `docker build [OPTIONS] PATH | URL | -` to build Docker images from a Dockerfile. 
  * `docker image rm <image name or container name>`to remove an image.
  

