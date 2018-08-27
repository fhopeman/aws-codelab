#!/usr/bin/env bash

if [ -z "${PROFILE}" ]; then
    echo "Please set environment variable PROFILE"
    exit 1
fi

if [ -z "${TEAM_NAME}" ]; then
    echo "Please set environment variable TEAM_NAME"
    exit 1
fi

bundle exec autostacker24 delete --stack "lambda-chat-${TEAM_NAME}-api" --profile "${PROFILE}"
bundle exec autostacker24 delete --stack "lambda-chat-${TEAM_NAME}-read" --profile "${PROFILE}"
bundle exec autostacker24 delete --stack "lambda-chat-${TEAM_NAME}-write" --profile "${PROFILE}"
bundle exec autostacker24 delete --stack "lambda-chat-${TEAM_NAME}-resources" --profile "${PROFILE}"
