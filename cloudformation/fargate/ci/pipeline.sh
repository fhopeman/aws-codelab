#!/usr/bin/env bash

set -e

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

bundle exec autostacker24 validate --template cf-templates/vpc.yaml \
    --profile "${PROFILE}" \
    --region "${REGION}"

# 1. Deploy vpc
bundle exec autostacker24 update --template cf-templates/vpc.yaml \
    --params properties/vpc.yaml \
    --stack "${TEAM_NAME}-vpc" \
    --region "${REGION}" \
    --profile "${PROFILE}"

# 2. Deploy fargate resources
bundle exec autostacker24 validate --template cf-templates/resources.yaml \
    --profile "${PROFILE}" \
    --region "${REGION}"
bundle exec autostacker24 update --template cf-templates/resources.yaml \
    --stack "${TEAM_NAME}-resources" \
    --param VPCStackName="${TEAM_NAME}-vpc" \
    --param TeamName="${TEAM_NAME}" \
    --region "${REGION}" \
    --profile "${PROFILE}"

# 3. Deploy yocto
bundle exec autostacker24 validate --template cf-templates/service.yaml \
    --profile "${PROFILE}" \
    --region "${REGION}"
bundle exec autostacker24 update --template cf-templates/service.yaml \
    --stack "${TEAM_NAME}-yocto" \
    --param VPCStackName="${TEAM_NAME}-vpc" \
    --param ResourcesStackName="${TEAM_NAME}-resources" \
    --param TeamName="${TEAM_NAME}" \
    --region "${REGION}" \
    --profile "${PROFILE}"

# 4. Run integration tests if YOCTO_URL present
if [ -n "${YOCTO_URL}" ]; then
    echo -e "\nStarting integration tests .."
    ./ci/integration-test.sh
else
    echo -e "\nSet YOCTO_URL to run integration tests"
fi

popd > /dev/null
