#!/usr/bin/env bash

set -e

export AWS_REGION=${AWS_REGION:-'eu-central-1'}

if [ -z "${1}" ]; then
    echo "usage: ${0} num-of-users"
    exit 1
fi

userpassword="$(head -c 9 /dev/urandom  | openssl base64 -e)"
usergroup='codelab'

for i in $(seq 1 ${1}); do
    username="codelab-${i}"

    aws iam create-user \
        --user-name "${username}" \
        >/dev/null
    aws iam create-login-profile \
        --password-reset-required \
        --user-name "${username}" \
        --password "${userpassword}" \
        >/dev/null
    aws iam add-user-to-group \
        --user-name "${username}" \
        --group-name "${usergroup}" \
        >/dev/null

    echo "Username: ${username}"
    echo "Password: ${userpassword}"
    echo ''
done
