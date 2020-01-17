#!/bin/bash
set -e

echo "This is an init.sh file"

exec $@

##!/usr/bin/env bash
#
#echo $(pwd)
#echo '- init.sh -'
#env_file_location=${1:-'conf/prod.conf'}
#echo $env_file_location
#
#set -a
#source $env_file_location
#set +a