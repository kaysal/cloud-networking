#!/bin/bash


# This script extracts the Enovy binary from the Docker image specified in $1:
# If no argument is given, it pulls from Istio Envoy Docker image:
#   https://hub.docker.com/r/istio/proxyv2
# The extracted Envoy binary will be put in the same directory as this script.
#
# Usage:
#   Docker is assumed to have been installed.
#   sudo /bin/bash -x </path/to/this/script>
#   Or, specify a particular image such as the one used in Istio:
#   sudo /bin/bash -x </path/to/this/script> docker.io/istio/proxyv2:<tag>


set -o errexit
set -o nounset
set -o pipefail


readonly IMAGE="${1:-istio/proxyv2:1.2.0}"
readonly ENVOY_PATH='/usr/local/bin/envoy'
readonly DEST_DIR=$(dirname "$0")


# Check Docker.
if ! docker --help &> /dev/null; then
  echo 'Docker is not installed.' >&2
  exit 1
fi

# Extract Envoy binary.
readonly CONTAINER=$(docker create "${IMAGE}")
echo "Created container ${CONTAINER} using image ${IMAGE}."
docker cp "${CONTAINER}":"${ENVOY_PATH}" "$DEST_DIR"
echo "Envoy binary has been copied into the $DEST_DIR directory."
# Clean up container we do not use.
docker rm "${CONTAINER}" >/dev/null
