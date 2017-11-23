#!/usr/bin/env bash

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

# 5. Run integration tests if API_GATEWAY_ID present
if [ -n "${YOCTO_URL}" ]; then
    echo -e "\nStarting integration tests .."
    ./ci/integration-test.sh
else
    echo -e "\nSet YOCTO_URL to run integration tests"
fi

popd > /dev/null
