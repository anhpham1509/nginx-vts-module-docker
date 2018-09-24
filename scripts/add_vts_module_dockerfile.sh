#!/usr/bin/env bash

set -e
set -o nounset
set -o pipefail

VTS_MODULE_VERSION=$1
if [[ -z ${VTS_MODULE_VERSION} ]]; then
    echo "Please specify vts module version to add into Dockerfile."
    exit 1
fi

GNU_SED="sed"
if [[ $(uname) == "Darwin" ]]; then
    GNU_SED="gsed"
fi

DOCKERFILE="Dockerfile"
MAINTAINER="Anh Pham"

# substitute maintainer
LABEL_SEARCH="LABEL maintainer.*\$"
LABEL_PATTERN="\".*\""
LABEL_REPLACE="\"${MAINTAINER}\""
${GNU_SED} -i -r "/${LABEL_SEARCH}/s/${LABEL_PATTERN}/${LABEL_REPLACE}/" ${DOCKERFILE}

# vts module env
ENV_PATTERN="ENV NGINX_VERSION.*\$"
ENV_APPEND="ENV NGINX_VTS_MODULE_VERSION ${VTS_MODULE_VERSION}"
${GNU_SED} -i -r "/${ENV_PATTERN}/a${ENV_APPEND}" ${DOCKERFILE}

# curl vts module
CURL_PATTERN="&& curl -fSL https:\/\/nginx.org\/download\/nginx.*.tar.gz.asc.*\$"
CURL_APPEND="\\\\t&& curl -fSL https://github.com/vozlt/nginx-module-vts/archive/\${NGINX_VTS_MODULE_VERSION}.tar.gz -o nginx-module-vts.tar.gz \\\\"
${GNU_SED} -i -r "/${CURL_PATTERN}/a${CURL_APPEND}" ${DOCKERFILE}

# decompress vts module
DECOMP_PATTERN="&& tar -zxC \/usr\/src -f nginx.tar.gz.*\$"
DECOMP_APPEND="\\\\t&& tar -zxC /usr/src -f nginx-module-vts.tar.gz \\\\"
${GNU_SED} -i -r "/${DECOMP_PATTERN}/a${DECOMP_APPEND}" ${DOCKERFILE}

# export vts path
EXPORT_PATTERN="&& rm nginx.tar.gz.*\$"
EXPORT_APPEND="\\\\t&& NGINX_MODULE_VTS_PATH=`echo /usr/src/nginx-module-vts\*` \\\\"
${GNU_SED} -i -r "/${EXPORT_PATTERN}/i${EXPORT_APPEND}" ${DOCKERFILE}

# remove gzip file
REMOVE_PATTERN="&& rm nginx.tar.gz.*$"
REMOVE_APPEND="\\\\t&& rm nginx-module-vts.tar.gz \\\\"
${GNU_SED} -i -r "/${REMOVE_PATTERN}/a${REMOVE_APPEND}" ${DOCKERFILE}

# add module in configuring nginx
CONFIG_SEARCH="&& .\/configure \$CONFIG"
CONFIG_PATTERN="\$CONFIG"
CONFIG_REPLACE="--add-module=\\\"\${NGINX_MODULE_VTS_PATH}\\\" &"
${GNU_SED} -i "/${CONFIG_SEARCH}/s/${CONFIG_PATTERN}/${CONFIG_REPLACE}/" ${DOCKERFILE}
