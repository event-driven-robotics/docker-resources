Docker based on ros melodic, installing esim, including unreal from externally, intended for running on windows with docker for windows installed, on a machine which doesn't necessarily have a gpu or nvidia drivers. 
2020_03_18: first commit is WIP, i.e. it doesn't currently work. 

To use:

1) build the docker: , i.e. from the windows command line:

docker build <path_to_Dockerfile> -t esim

2) Download http://cs.jhu.edu/~qiuwch/release/unrealcv/RealisticRendering-Linux-0.3.10.zip and unzip it; the top level folder is called RealisticRendering

3) Modify the file RealisticRendering/LinuxNoEditor/playground.sh with the flag '-opengl3" added so that the final line reads: 

"$UE4_PROJECT_ROOT/RealisticRendering/Binaries/Linux/playground" RealisticRendering -opengl3 $@ 

4) Run an X-windows emulator, such as MobaXTerm; if you use MobaXterm, "x11 remote access" setting should be "full".

5) Find your ip address.

6) Run docker thus:

docker run -v <path_to_RealisticRendering>:/RealisticRendering  -e DISPLAY=<ip_address>:0.0  -it esim

An actual example from machine is like:

docker run -v C:/repos/extOther/RealisticRendering:/RealisticRendering  -e DISPLAY=10.0.0.11:0.0  -it esim

7) Once inside the docker, switch to being user unreal: 

su unreal

7.5) You may wish to confirm that x windows forwarding is working, by running:

glxgears

... this should pop you up a window with some spinning gears. 

8) Now try the instructions on this page:

https://github.com/uzh-rpg/rpg_esim/wiki/Photorealistic-Rendering-Engine-based-on-Unreal-Engine

... specifically:

./RealisticRendering/LinuxNoEditor/playground.sh
