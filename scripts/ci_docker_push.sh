#!/usr/bin/env bash

set -e
set -o nounset
set -o pipefail

DOCKER_IMAGE=$1
if [[ -z ${DOCKER_IMAGE} ]]; then
    echo "Please specify image to push to remote repository."
    exit 1
fi

docker push ${DOCKER_IMAGE}
