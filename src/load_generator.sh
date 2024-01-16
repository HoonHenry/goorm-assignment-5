#!/bin/bash
host=$1
term=$2
if [ -z "$host" ]; then
    echo "No host is given"
    exit 1
fi

if [ -z "$term" ]; then
    term="0.01"
fi

echo "The sleep time is set to ${term} sec and the hostname is ${host}"

kubectl run \
    -i \
    --rm \
    --tty \
    load-generator \
    --image=busybox:1.28 \
    --restart=Never -- \
    /bin/sh -c \
    "while sleep ${term}; do wget -q -O- ${host}; done"
