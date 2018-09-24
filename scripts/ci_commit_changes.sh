#!/usr/bin/env bash

set -e
set -o nounset
set -o pipefail

CHANGES=$1
if [[ -z ${CHANGES} ]]; then
    echo "Please specify changes to be committed."
    exit 1
fi


if [[ ${CIRCLE_BRANCH} != "master" ]]; then
    if [[ $(git status --porcelain) ]]; then
        git add --all
        git commit -m "BOT: ${CHANGES}."
    fi
fi
