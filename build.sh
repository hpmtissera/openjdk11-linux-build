#!/usr/bin/env bash

echo -e "This script will build OpenJDK 11 for Linux x86_64\n"

OPENJDK_VERSION=$1

if [ "${OPENJDK_VERSION}" = "" ]; then
   echo -n "Enter the OpenJDK 11 version number to build [default: 11.0.4+11]: "
   read OPENJDK_VERSION
fi

if [ "${OPENJDK_VERSION}" = "" ]; then
   OPENJDK_VERSION="11.0.4+11"
fi

TAR_FILENAME_SUFFIX=`echo $OPENJDK_VERSION | tr + _`

docker build -t openjdk-build .
docker run --volume "$(pwd):/opt/build" --cidfile=containerid  -u root openjdk-build sh -c "/opt/build/build-openjdk.sh ${OPENJDK_VERSION}"

CONTAINER_ID=$(cat containerid)
docker cp ${CONTAINER_ID}:/tmp/OpenJDK11U-jdk_aarch64_linux_$TAR_FILENAME_SUFFIX.tar.gz ./
docker rm -f ${CONTAINER_ID}
rm containerid
