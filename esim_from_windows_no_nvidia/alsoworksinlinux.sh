#!/bin/bash

# Prepare folders

mkdir ~/esim
cp Dockerfile ~/esim/
mkdir ~/unreal_zoo && cd ~/unreal_zoo
wget http://cs.jhu.edu/~qiuwch/release/unrealcv/RealisticRendering-Linux-0.3.10.zip
unzip RealisticRendering-Linux-0.3.10.zip
rm RealisticRendering-Linux-0.3.10.zip
cd

# Build docker images

sudo docker build esim/ -t esim

# Remove unnecessary folders

rm -r ~/esim/

# Run docker image

sudo docker run -v /dev/:/dev -v ~/unreal_zoo/RealisticRendering:/RealisticRendering -v /tmp/.X11-unix/:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY --name esim -it esim
