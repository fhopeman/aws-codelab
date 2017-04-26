#!/usr/bin/env bash

if [ -z "${PROFILE}" ]; then
    echo "Please set environment variable PROFILE"
    exit 1
fi

if [ -z "${TEAM_NAME}" ]; then
    echo "Please set environment variable API_GATEWAY_ID"
    exit 1
fi

# 1. Deploy app
bundle exec autostacker24 update --template lambda/cf-templates/chat.yaml \
    --stack lambda-chat-"${TEAM_NAME}" \
    --param TeamName="${TEAM_NAME}" \
    --profile "${PROFILE}"

# 2. Run integration tests if API_GATEWAY_ID present
if [ -n "${API_GATEWAY_ID}" ]; then
    echo -e "\nStarting integration tests .."
    ./lambda/ci/integration-test.sh
else
    echo -e "\nSet API_GATEWAY_ID to run integration tests"
fi
