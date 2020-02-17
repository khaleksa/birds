echo $(pwd)

env_file_location=${1:-'.env'}
echo $env_file_location

set -a
source $env_file_location
set +a