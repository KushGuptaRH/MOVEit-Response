#!/bin/bash

# podman machine start

ansible-galaxy collection install kushguptarh.moveit_response --force

echo 'podman machine started'

ansible-builder build --tag moveit_ee:latest

echo 'new ee built'

podman push localhost/moveit_ee:latest quay.io/kugupta/moveit_ee:latest

echo 'image pushed to quay'

podman image prune -a -f

echo 'podman artifacts cleaned'

# podman machine stop

echo 'see ya next bug'