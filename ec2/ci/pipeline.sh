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

REGION=${REGION:-"eu-central-1"}

bundle check || bundle install

# 1. Deploy vpc
bundle exec autostacker24 update --template ec2/cf-templates/vpc.yaml \
    --params ec2/properties/vpc.yaml \
    --stack "vpc-${TEAM_NAME}" \
    --region "${REGION}" \
    --profile "${PROFILE}"

# 2. Deploy debug security group
#bundle exec autostacker24 update --template ec2/cf-templates/vpc-debug-security-group.yaml \
#    --stack "vpc-${TEAM_NAME}-debug-sg" \
#    --param VPCStackName="vpc-${TEAM_NAME}" \
#    --param TeamName="${TEAM_NAME}" \
#    --region "${REGION}" \
#    --profile "${PROFILE}"

# 3. Deploy yocto
#bundle exec autostacker24 update --template ec2/cf-templates/vpc-yocto.yaml \
#    --params ec2/properties/yocto.yaml \
#    --stack "vpc-${TEAM_NAME}-yocto" \
#    --region "${REGION}" \
#    --profile "${PROFILE}"

# 4. Run integration tests if YOCTO_URL present
if [ -n "${YOCTO_URL}" ]; then
    echo -e "\nStarting integration tests .."
    ./ec2/ci/integration-test.sh
else
    echo -e "\nSet YOCTO_URL to run integration tests"
fi
