#!/bin/bash
set -e

echo "This is an init.sh file"

FILE=/usr/conf/cloud.conf
if [[ -f "$FILE" ]]; then
  echo "cloud.conf exists."
  set -a
  . /usr/conf/cloud.conf
  set +a
  printenv
else
  echo "cloud.conf NOT exists."
fi

exec $@