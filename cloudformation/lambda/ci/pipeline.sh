#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "$0")" ; pwd -P)"

if [ -z "${PROFILE}" ]; then
    echo "Please set environment variable PROFILE"
    exit 1
fi

if [ -z "${TEAM_NAME}" ]; then
    echo "Please set environment variable TEAM_NAME"
    exit 1
fi

REGION=${REGION:-"eu-central-1"}

pushd "${SCRIPT_DIR}/.." > /dev/null

bundle check || bundle install

# 1. Deploy resources
bundle exec autostacker24 validate --template cf-templates/chat-resources.yaml \
    --profile "${PROFILE}" \
    --region "${REGION}"

bundle exec autostacker24 update --template cf-templates/chat-resources.yaml \
    --stack "lambda-chat-${TEAM_NAME}-resources" \
    --param TeamName="${TEAM_NAME}" \
    --profile "${PROFILE}" \
    --region "${REGION}"

# 2. Deploy read lambda
#bundle exec autostacker24 validate --template cf-templates/chat-read.yaml \
#    --profile "${PROFILE}" \
#    --region "${REGION}"
#bundle exec autostacker24 update --template cf-templates/chat-read.yaml \
#    --stack "lambda-chat-${TEAM_NAME}-read" \
#    --param TeamName="${TEAM_NAME}" \
#    --profile "${PROFILE}" \
#    --region "${REGION}"

# 3. Deploy write lambda
#bundle exec autostacker24 validate --template cf-templates/chat-write.yaml \
#    --profile "${PROFILE}" \
#    --region "${REGION}"
#bundle exec autostacker24 update --template cf-templates/chat-write.yaml \
#    --stack "lambda-chat-${TEAM_NAME}-write" \
#    --param TeamName="${TEAM_NAME}" \
#    --profile "${PROFILE}" \
#    --region "${REGION}"

# 4. Deploy api
#bundle exec autostacker24 validate --template cf-templates/chat-api.yaml \
#    --profile "${PROFILE}" \
#    --region "${REGION}"
#bundle exec autostacker24 update --template cf-templates/chat-api.yaml \
#    --stack "lambda-chat-${TEAM_NAME}-api" \
#    --param TeamName="${TEAM_NAME}" \
#    --profile "${PROFILE}" \
#    --region "${REGION}"

# 5. Run integration tests if API_GATEWAY_ID present
if [ -n "${API_GATEWAY_ID}" ]; then
    echo -e "\nStarting integration tests .."
    ./ci/integration-test.sh
else
    echo -e "\nSet API_GATEWAY_ID to run integration tests"
fi

popd > /dev/null
