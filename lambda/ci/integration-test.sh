#!/usr/bin/env bash

if [ -z "${API_GATEWAY_ID}" ]; then
    echo "Please set environment variable API_GATEWAY_ID"
    exit 1
fi

echo -e "\nReading messages .."
responseCode=$(curl -sw '%{http_code}' "https://${API_GATEWAY_ID}.execute-api.eu-central-1.amazonaws.com/LATEST/chat" -o /dev/null)
echo "ResponseCode: ${responseCode}"
if [ ${responseCode} -eq 200 ]; then
    echo -e "Read messages successfully .."
else
    echo -e "Reading messages failed .."
    exit 3
fi

echo -e "\nSending message .."
responseCode=$(curl -XPOST \
                   -sw '%{http_code}' \
                   -d '{"username":"testuser","message": "test message"}' \
                   "https://${API_GATEWAY_ID}.execute-api.eu-central-1.amazonaws.com/LATEST/chat" \
                   -o /dev/null \
              )
echo "ResponseCode: ${responseCode}"
if [ ${responseCode} -eq 200 ]; then
    echo -e "Send message successfully .."
else
    echo -e "Sending message failed .."
    exit 2
fi
