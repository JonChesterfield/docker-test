#!/bin/bash

# Like our CI package/mkImage.sh but with lots hacked out

# USAGE: mkImage.sh IMAGE
#
# Environment variables:
#   BASE_DOCKER_TAG - Tag to use for the base image (if one of ours). This is useful, for example, to create a remote
#                     development image that is based on your personal CI image but has extra keys in its
#                     authorized_keys and thus should be tagged differently.
#   DOCKER_TAG - Tag to personalize the image. By default, the calling user's username unless running in CI (in which
#                case, "latest"").



set -ETeuo pipefail
cd "$(dirname "$0")"
[ -f /.dockerenv ] && echo "$0 should be run outside of docker."

IMAGE="$1"

if [ -z "${DOCKER_TAG:-}" ] ; then
    DOCKER_TAG=":$(whoami)"
else
    DOCKER_TAG=":${DOCKER_TAG}"
fi
if [ -z "${BASE_DOCKER_TAG:-}" ] ; then
    BASE_DOCKER_TAG="${DOCKER_TAG}"
else
    BASE_DOCKER_TAG=":${BASE_DOCKER_TAG}"
fi

SRC="$(realpath .)"
cd "${SRC}/images"

# Unfortunately, Docker's change tracking requires scribbling in the source tree. Erase the scribbling.
function onExit
{
    rm -rf "${SRC}/package/images"/{authorized_keys,bin}
}
trap onExit EXIT


# Build the image.

# We are root in this image
CI_UID=0

ROCM_VERSION=7.1.0

echo "Using DOCKER_TAG $DOCKER_TAG"
echo "Using BASE_DOCKER_TAG $BASE_DOCKER_TAG"


# Writing jc in the middle of the name to distinguish from the production images
OUTPUT_NAME="redscale-jc-${IMAGE}${DOCKER_TAG}"
OUTPUT_TYPE=image


docker build \
    --progress=plain -f "${IMAGE}.dockerfile" \
    ${DOCKER_BUILD_EXTRA_ARGS:-} \
    --output="type=${OUTPUT_TYPE},oci-mediatypes=true,compression=zstd,force-compression=true,name=${OUTPUT_NAME}" .


cd -
