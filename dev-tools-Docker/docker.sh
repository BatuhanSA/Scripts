#!/bin/bash 


./clean.sh

docker build . -t test

docker run -it --name DooD-Testing  -v /var/run/docker.sock:/var/run/docker.sock test


# docker wait DooD-Testing

# container_id=$(docker ps -aq --filter "name=DooD-Testing")

# docker cp $container_id:/autograder-server/output_DooD.txt ../

# docker rm -f $container_id

# bash clean.sh
