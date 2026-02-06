#!/bin/bash

# these pick up defaults but not necessarily the right ones
export DOCKER_TAG="latest"

# and DOCKER_TAG env variables pick up defaults

./package/mkImage.sh derived-ubuntu24.04
