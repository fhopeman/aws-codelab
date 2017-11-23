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
    --stack "vpc-${TEAM_NAME}" \
    --region "${REGION}" \
    --profile "${PROFILE}"

# 2. Deploy debug security group
#bundle exec autostacker24 validate --template cf-templates/vpc-debug-security-group.yaml \
#    --profile "${PROFILE}" \
#    --region "${REGION}"
#bundle exec autostacker24 update --template cf-templates/vpc-debug-security-group.yaml \
#    --stack "vpc-${TEAM_NAME}-debug-sg" \
#    --param VPCStackName="vpc-${TEAM_NAME}" \
#    --param TeamName="${TEAM_NAME}" \
#    --region "${REGION}" \
#    --profile "${PROFILE}"

# 3. Deploy yocto
#bundle exec autostacker24 validate --template cf-templates/vpc-yocto.yaml \
#    --profile "${PROFILE}" \
#    --region "${REGION}"
#bundle exec autostacker24 update --template cf-templates/vpc-yocto.yaml \
#    --params properties/yocto.yaml \
#    --stack "vpc-${TEAM_NAME}-yocto" \
#    --region "${REGION}" \
#    --profile "${PROFILE}"

# 4. Run integration tests if YOCTO_URL present
if [ -n "${YOCTO_URL}" ]; then
    echo -e "\nStarting integration tests .."
    ./ci/integration-test.sh
else
    echo -e "\nSet YOCTO_URL to run integration tests"
fi

popd > /dev/null
