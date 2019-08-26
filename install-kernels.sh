#!/bin/bash
case "$1" in
  aw17r4)
        echo "$1: Installing Kernel and Headers for Dell Alienware 17R4"
	#TARGET="czmod-skylake"
        ;;
  eeepc)
        echo "$1: Installing Kernel and Headers for Asus EEEPC"
	#TARGET="czmod-atom"
        ;;
  *)
        echo "$1: Unknown Targe. Aborting!"
        echo "Usage: install-kernels.sh <target>"
        echo "Possible targets:  \"aw17r4\", \"eeepc\""
        exit -1
        ;;
esac

sudo dpkg -i ../linux-image-*$1*.deb ../linux-headers-*$1*.deb
sudo update-grub
mkdir -p ../olddebs
mv ../linux-image-*$1*.deb ../olddebs
mv ../linux-headers-*$1*.deb ../olddebs
