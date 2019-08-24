#!/bin/bash
case "$1" in
  aw17r4)
        echo "$1: Installing Kernel and Headers for Dell Alienware 17R4"
	TARGET="czmod-skylake"
        ;;
  eeepc)
        echo "$1: Installing Kernel and Headers for Asus EEEPC"
	TARGET="czmod-atom"
        ;;
  *)
        echo "$1: Unknown Targe. Aborting!"
        echo "Usage: install-kernels.sh <target>"
        echo "Possible targets:  \"aw17r4\", \"eeepc\""
        exit -1
        ;;
esac

sudo dpkg -i ../linux-image-*$TARGET*.deb ../linux-headers-*$TARGET*.deb
sudo update-grub
mv ../linux-image-*$TARGET*.deb ../olddebs/
mv ../linux-headers-*$TARGET*.deb ../olddebs/
