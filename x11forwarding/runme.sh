#!/bin/bash

# Build docker image

sudo docker build . -t x11forwarding

# Run docker image

# Replace your host ip address in the following line:
sudo docker run -e DISPLAY=10.0.0.7:0.0 --name x11forwarding x11forwarding

#Or you could try something fancy like this:
#ip="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
# Then take that ip variable and use in the docker call.
# ... but be careful, you might fall down a script hole.
 



