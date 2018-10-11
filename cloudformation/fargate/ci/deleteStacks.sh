#!/usr/bin/env bash

set -e

if [ -z "${PROFILE}" ]; then
    echo "Please set environment variable PROFILE"
    exit 1
fi

if [ -z "${TEAM_NAME}" ]; then
    echo "Please set environment variable TEAM_NAME"
    exit 1
fi

bundle exec autostacker24 delete --stack "${TEAM_NAME}-yocto" --profile "${PROFILE}"
bundle exec autostacker24 delete --stack "${TEAM_NAME}-resources" --profile "${PROFILE}"
bundle exec autostacker24 delete --stack "${TEAM_NAME}-vpc" --profile "${PROFILE}"
