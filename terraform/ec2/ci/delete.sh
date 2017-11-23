#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "$0")" ; pwd -P)"

pushd "${SCRIPT_DIR}/../tf-files" > /dev/null

terraform destroy -force

popd > /dev/null
