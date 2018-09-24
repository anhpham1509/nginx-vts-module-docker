#!/usr/bin/env bash

set -e
set -o nounset
set -o pipefail

if [[ ${CIRCLE_BRANCH} != "master" ]]; then
    if [[ $(git log origin/${CIRCLE_BRANCH}..${CIRCLE_BRANCH}) ]]; then
        echo "Pushing BOT changes"
        git push --set-upstream pushback $CIRCLE_BRANCH
        exit 1
    fi
fi
