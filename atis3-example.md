## How to set up docker to use the ATIS gen 3 cameras:

To use the ATIS3 cameras we need to have *metavision* (previously *Prophesee*) libraries installed. There are two versions of the libraries depending on if you are using VGA (events-only, latest library version) or HVGA camera (intensity image, library version 1.4).

### Get the right docker image:

Grab the base image with all the right installs:

*VGA*

`docker clone eventdrivenrobotics/atis-gen3:latest`

*HVGA*

`docker clone eventdrivenrobotics/atis-gen3:1.4`

:warning: if you want to run docker without sudo you can give permission for your local user to run docker https://docs.docker.com/engine/install/linux-postinstall/

### Start the docker container

Before running docker we need to tell the host to accept GUI windows. On the host we need to run

`xhost local:docker`

to enable the X11 forwarding on the host side.

Then run a container with the right parameters:

`docker run -it --privileged -v /dev/bus/usb:/dev/bus/usb -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY eventdrivenrobotics/atis-gen3:latest`

The meaning of the options are:
* -i : interative
* -t : ?
* --privileged : give the docker rights to open devices (to read the camera over usb)
* -v /dev/bus/usb:/dev/bus/usb : mount the /dev folder so the docker can find the right device
* -v /tmp/.X11-unix:/tmp/.X11-unix : mount the temporary configuration for x11 to use the same options as the host
* -e DISPLAY=unix$DISPLAY : set the environment variable for X11 forwarding

:warning: remember to use `..atis-gen3:1.4` if you are using the HVGA camera

This will start the new container with a terminal. To close this container you can use `ctrl+d`. The container still exists (on the host type `docker ps -a` to see it's still there. Take note of the container name. Next time you want to open this same container you will need to:

`docker start <container_name>`

and then open a terminal inside the container:

`docker exec -it <container_name> bash`

:warning: To modify mounted drives and environment variables you will need to create a new container. See `<link to help page>` for more information.

:warning: Helper scripts are also available *LINK*

### Use the container

Installed applications:

*VGA*

`ls /usr/bin/meta*` to list the install metavision applications. The `metavision player` is the default for visualising and recording data.

*HVGA*

`ls /usr/bin/prop*` to list the installed prophesee applications. `prophesee_player` can be used to visualise and save data, if the player is not correctly visualising, you can use `prophesee_viewer` to get the output of the camera.

The docker also comes with installed libraries to begin development of applications which interface to the event-driven and YARP environments.

To read events over YARP:

1. start the YARP server `yarp server --write &`
2. start the atis-bridge `atis-bridge-sdk`
3. open a second docker terminal
3. check the port is open `yarp name list` should show `/atis3/AE:o` open.
4. visualise the output on the `vFramer` using the `yarpmanager` application. Run the `yarpmanager`, double click the `atis3-vis` application, `run all`, and `connect all`. The camera output should be visualised.

### Developing you own application

`cd /root/projects`

`git clone <your-project-url>`

Follow instructions *LINK* to make a default application to read events in C++ using event-driven.

Follow isntructions *LINK* to make a default application to read events in Python using event-driven.





