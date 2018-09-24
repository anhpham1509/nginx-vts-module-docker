#!/usr/bin/env bash

set -e
set -o nounset
set -o pipefail

NGINX_VERSION=$1

if [[ -z ${NGINX_VERSION} ]]; then
    echo "Please specify nginx version to fetch."
    exit 1
fi

REPO_URL="git@github.com:nginxinc/docker-nginx.git"

TMP_DIR="tmp"
REPO_TMP_DIR="${TMP_DIR}/nginx_official"
NGINX_TMP_DIR="${REPO_TMP_DIR}/mainline/alpine"

NGINX_DIR="."

function cleanTmpDir() {
    rm -rf ${TMP_DIR}
}

cleanTmpDir

mkdir -p ${TMP_DIR}
git clone --single-branch --branch ${NGINX_VERSION} ${REPO_URL} ${REPO_TMP_DIR}
mv ${NGINX_TMP_DIR}/* ${NGINX_DIR}

cleanTmpDir