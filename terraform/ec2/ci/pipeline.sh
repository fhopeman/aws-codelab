#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" ; pwd -P)"

pushd "${SCRIPT_DIR}/../tf-files" > /dev/null

terraform init \
  -input=false

terraform plan \
  -input=false \
  -out plan.out

terraform apply \
  -input=false \
  plan.out

# Run integration tests if YOCTO_URL present
if [ -n "${YOCTO_URL}" ]; then
    echo -e "\nStarting integration tests .."
    ./ci/integration-test.sh
else
    echo -e "\nSet YOCTO_URL to run integration tests"
fi

popd > /dev/null
