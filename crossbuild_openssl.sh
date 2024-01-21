#!/bin/bash

NUM_OF_CORES=12
ROOTDIR=${PWD}
Compiler_postfix=$1

echo "rootdir " $ROOTDIR
echo "build libs with "  $NUM_OF_CORES  "Cores"

CCompiler="arm-linux-gnueabihf-gcc"
CxxCompiler="arm-linux-gnueabihf-g++"

DIR=$ROOTDIR"/opensslbuild"


if [ -d "$DIR" ]; then
  echo "Directory exists .. nothing todo"
else
  echo "Directory not existing" + "$DIR"

  mkdir opensslbuild

  cd $ROOTDIR/openssl

  ./Configure linux-generic32 shared  -DL_ENDIAN --prefix=/home --openssldir=/home
  make -j$NUM_OF_CORES CC=$CCompiler RANLIB=arm-linux-gnueabihf-ranlib LD=arm-linux-gnueabihf-ld MAKEDEPPROG=$CCompiler PROCESSOR=ARM


  cp $ROOTDIR/openssl/*.so* $ROOTDIR/opensslbuild
  cp -r $ROOTDIR/openssl/include/* $ROOTDIR/opensslbuild
fi