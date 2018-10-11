#!/usr/bin/env bash

set -e

if [ -z "${YOCTO_URL}" ]; then
    echo "Please set environment variable YOCTO_URL"
    exit 1
fi

echo -e "\nTry to fetch important information .."
curl -s "http://${YOCTO_URL}"
success=$?
if [ ${success} -eq 0 ]; then
    echo -e "\nSuccessful .."
else
    echo -e "\nFailed .."
    exit 2
fi
