#!/usr/bin/env bash

set -e
set -o nounset
set -o pipefail

GNU_SED="sed"
if [[ $(uname) == "Darwin" ]]; then
    GNU_SED="gsed"
fi

CONFIG_FILE="nginx.conf"
# start vts module in configuration
VTS_PATTERN="include \/etc\/nginx\/conf.d\/\*.conf;"
VTS_APPEND="\\\\t# vts module\\n\\tvhost_traffic_status_zone;\\n"
${GNU_SED} -i -r "/${VTS_PATTERN}/i${VTS_APPEND}" ${CONFIG_FILE}

# add vts module route
DEFAULT_CONFIG_FILE="nginx.vh.default.conf"
ROUTE_PATTERN="^}$"
ROUTE_APPEND="\\\\n\\tlocation /status {\\n\\t\\tallow 127.0.0.1;\\n\\n\\t\\tvhost_traffic_status_display;\\n\\t\\tvhost_traffic_status_display_format json;\\n\\t}"
${GNU_SED} -i -r "/${ROUTE_PATTERN}/i${ROUTE_APPEND}" ${DEFAULT_CONFIG_FILE}
