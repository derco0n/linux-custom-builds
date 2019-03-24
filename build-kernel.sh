#!/bin/bash
BUILD_START=$(date +"%s")

export CONCURRENCY_LEVEL=2 
export CHOST="x86_64-pc-Linux-gnu" 
export CFLAGS="-march=native -O2 -pipe" 
export CXXFLAGS="$CFLAGS"
export CCACHE_DIR="/media/co0n/7a59f274-2a0c-4233-a4bf-03233b45a7e9/ccachedir"


echo "Start Kernel build..."
echo "#####################"
echo ""
fakeroot make-kpkg  --initrd -j9 --append-to-version=-czm0d kernel_image kernel_headers

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$Yellow Build ended after $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
