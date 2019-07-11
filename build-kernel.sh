#!/bin/bash
BUILD_START=$(date +"%s")

THREADS=9

export CHOST="x86_64-pc-Linux-gnu" #https://wiki.gentoo.org/wiki/CHOST #Targetarchitecture
#export CFLAGS="-march=native -O2 -pipe" #https://wiki.gentoo.org/wiki/Safe_CFLAGS#Intel
export CFLAGS="-march=skylake -O2 -pipe" #https://wiki.gentoo.org/wiki/Safe_CFLAGS#Intel #AW17R4 has a Skylake CPU
export CXXFLAGS="$CFLAGS"


echo "Start Kernel build..."
echo "#####################"
echo ""
#fakeroot make-kpkg -j $THREADS --verbose --initrd --arch-in-name --append-to-version=-czm0d kernel_image kernel_headers
make-kpkg -j $THREADS --verbose --initrd --arch-in-name --append-to-version=-czm0d-skylake kernel_image kernel_headers

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$Yellow Build ended after $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
