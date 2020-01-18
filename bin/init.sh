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

#cloud.conf file content:
#
#echo 'this is a cloud.conf'
## Google Cloud settings
#GC_BIRDS_CRED_FILE_PATH='/Users/alexandra/XProject/birds/birds/google_cred.json'
#GC_BIRDS_PROJECT_ID='sonorous-mix-245813'
#GC_BIRDS_IMAGE_BUCKET_ID='birdsuzb_images'
#
## Postgres settings. Connect to your dev db using "rails db".
#DATABASE_PORT=5432
#DATABASE_HOST=34.89.189.108
#DATABASE_USERNAME=birds_user
#DATABASE_PASSWORD=mo2vwzxk5cmnc1a1
#DATABASE_NAME=birds_production
