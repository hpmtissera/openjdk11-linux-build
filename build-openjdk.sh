#!/usr/bin/env bash

set -e

OPENJDK_VERSION=$1
TAR_FILENAME_SUFFIX=`echo $OPENJDK_VERSION | tr + _`

if [ "${OPENJDK_VERSION}" = "" ]; then
   echo "Error: Must specify desired OpenJDK version."
   exit 1
fi

hg clone --rev=1 https://hg.openjdk.java.net/jdk-updates/jdk11u /jdk11
cd /jdk11
hg pull
hg update jdk-$OPENJDK_VERSION

sh ./configure --with-boot-jdk=/usr/local/jdk-11.0.1 --disable-warnings-as-errors --with-native-debug-symbols=none --with-debug-level=release --with-jvm-variants=server --enable-unlimited-crypto --without-version-opt --disable-manpages

make images

# remove unnecessary files
cd build/linux-x86_64-normal-server-release/images/jdk

rm -rf demo
find . -name "src.zip" -exec rm -f {} \;

cd ..

mv jdk openjdk-$OPENJDK_VERSION

tar -zcvf OpenJDK11U-jdk_aarch64_linux_$TAR_FILENAME_SUFFIX.tar.gz openjdk-$OPENJDK_VERSION

mv OpenJDK11U-jdk_aarch64_linux_$TAR_FILENAME_SUFFIX.tar.gz /tmp
