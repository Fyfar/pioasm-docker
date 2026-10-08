#!/bin/sh
# Build and push fyfar/pioasm:<version from Dockerfile> and move :latest to it.
set -e
cd "$(dirname "$0")"
v=$(sed -n 's/^ARG PICO_SDK_VERSION=//p' Dockerfile)
docker build -t fyfar/pioasm:"$v" -t fyfar/pioasm:latest .
docker push fyfar/pioasm:"$v"
docker push fyfar/pioasm:latest
