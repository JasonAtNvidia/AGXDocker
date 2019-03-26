#!/bin/sh

BUILD_DATE=$(date -u +'%Y-%m-%d-%H:%M:%S')
CODE_NAME='bionic'
JETPACK_VERSION='4.2.0'
USER='developer'
USER_ID='1000'
TAG="jetpack-$JETPACK_VERSION-$CODE_NAME"

# use tar to dereference the symbolic links from the current directory,
# and then pipe them all to the docker build - command
tar -czh . | docker build - \
  --build-arg REPOSITORY=arm64v8/ubuntu \
  --build-arg TAG=$CODE_NAME \
  --build-arg BUILD_VERSION=$JETPACK_VERSION \
  --build-arg BUILD_DATE=$BUILD_DATE \
  --build-arg USER=$USER \
  --build-arg UID=$USER_ID \
  --tag=jetson-agx/pytorch:$TAG
