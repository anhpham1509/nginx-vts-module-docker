#!/usr/bin/env bash

set -e
set -o nounset
set -o pipefail

DOCKER_SERVER=""
echo ${DOCKER_PASSWORD} | docker login --username ${DOCKER_USER} --password-stdin ${DOCKER_SERVER}
