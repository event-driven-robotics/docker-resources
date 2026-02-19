yarp detect --write
yarpdataplayer & sleep 5 && \
echo load /data/ | yarp rpc /yarpdataplayer/rpc:i && sleep infinity