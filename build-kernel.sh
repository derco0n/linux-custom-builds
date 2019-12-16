#!/bin/bash

# Determine Threads based on logical CPUs
#########################################

#THREADS=9
LOGICALCPUS=$(cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l)
THREADS=$(($LOGICALCPUS+1))

echo "Found $LOGICALCPUS logical CPUs. "
echo "Compiling with $THREADS Threads."

# Determine compiler settings
#############################
# Optimizations:

# -O1 performs only optimizations that don't effect the compile time much.
# -O2 performs optimizations without trading space for speed
# -O3 performs maximal speed optimization
# -Os tries to make the executable as small as possible

case "$2" in
  O2)
	echo "$2: Compiler-optimization-flag is set."
	OPTIMIZATION="-O2"
	;;
  *)
	echo "No Compiler-optimization-flag is set. Using default..."
	OPTIMIZATION="-O3"
	;;
esac

echo "$Yellow Compiling with optimization: $OPTIMIZATION..."

# Optimize for CPU (set CFLAGS):
case "$1" in
  aw17r4)
        echo "$1: Compiling for Dell Alienware 17R4"
	#export CFLAGS="-march=native $OPTIMIZATION -pipe" #https://wiki.gentoo.org/wiki/Safe_CFLAGS#Intel #AW17R4 has a Skylake CPU
	export CFLAGS="-march=skylake $OPTIMIZATION -pipe" #https://wiki.gentoo.org/wiki/Safe_CFLAGS#Intel #AW17R4 has a Skylake CPU
	APPENDTEXT="-czm0d-skylake-$1"
        ;;
  eeepc)
        echo "$1: Compiling for Asus EEEPC"
	export CFLAGS="-march=atom -mtune=atom $OPTIMIZATION -pipe" #https://wiki.gentoo.org/wiki/Safe_CFLAGS
	APPENDTEXT="-czm0d-atom-$1"
        ;;
  winpad12)
        echo "$1: Compiling for Odys Winpad 12"
	export CFLAGS="-march=atom -mtune=atom -fexcess-precision=fast $OPTIMIZATION -pipe" #https://wiki.gentoo.org/wiki/Safe_CFLAGS
	APPENDTEXT="-czm0d-atom-$1"
        ;;
  probook650g3)
        echo "$1: Compiling for HP ProBook 650 G3"
	export CFLAGS="-march=skylake $OPTIMIZATION -pipe" #https://wiki.gentoo.org/wiki/Safe_CFLAGS#Probook 650 G3 has a Kaby Lake CPU
	APPENDTEXT="-czm0d-kabylake-$1"
        ;;
  *)
        echo "$1: Unknown Target. Aborting!"
        echo "Usage: build-kernel.sh <target> [optimization]"
        echo "Possible targets:  \"aw17r4\", \"eeepc\", \"winpad12\", \"probook650g3\""
        echo "Possible optimizations:  \"-O2 \(optimize for space, default is -03 [speed]\)\""
        exit -1
        ;;
esac

echo "CFLAGS are: $CFLAGS"

# Configuring Compiler
######################

export CXXFLAGS="$CFLAGS"

BUILD_START=$(date +"%s")

echo "$Yellow Start Kernel build..."
echo "$Yellow #####################"
echo ""
echo "$Yellow Build started at $(date)"
echo ""
#fakeroot make-kpkg -j $THREADS --verbose --initrd --arch-in-name --append-to-version=-czm0d kernel_image kernel_headers
make-kpkg -j $THREADS --verbose --initrd --arch-in-name --append-to-version=$APPENDTEXT kernel_image kernel_headers

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$Yellow Build ended after $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
