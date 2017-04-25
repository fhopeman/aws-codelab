#!/usr/bin/env bash

set -e

export AWS_REGION=${AWS_REGION:-'eu-central-1'}

for u in $(aws iam list-users | grep UserName | grep 'codelab-' | cut -d\" -f4); do
    aws iam delete-login-profile --user-name "${u}"
    aws iam remove-user-from-group --user-name "${u}" --group-name 'codelab'
    aws iam delete-user --user-name "${u}"
done