#!/usr/bin/env bash

if [ -z "${API_GATEWAY_ID}" ]; then
    echo "Please set environment variable API_GATEWAY_ID"
    exit 1
fi

echo -e "\nSending message .."
curl -XPOST \
    -d '{"username":"testuser","message": "test message"}' \
    "https://${API_GATEWAY_ID}.execute-api.eu-central-1.amazonaws.com/LATEST/chat"
success=$?
if [ ${success} -eq 0 ]; then
    echo -e "\nSend message successfully .."
else
    echo -e "\nSending message failed .."
    exit 2
fi

echo -e "\nReading messages .."
curl -s "https://${API_GATEWAY_ID}.execute-api.eu-central-1.amazonaws.com/LATEST/chat"
success=$?
if [ ${success} -eq 0 ]; then
    echo -e "\nRead messages successfully .."
else
    echo -e "\nReading messages failed .."
    exit 3
fi
