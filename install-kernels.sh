#!/bin/bash
case "$1" in
  aw17r4)
        echo "$1: Installing Kernel and Headers for Dell Alienware 17R4"
	TARGET="czm0d-skylake-aw17r4"
        ;;
  eeepc)
        echo "$1: Installing Kernel and Headers for Asus EEEPC"
	TARGET="czm0d-atom-eeepc"
        ;;
  winpad12)
        echo "$1: Installing Kernel and Headers for Odys Winpad 12"
	TARGET="czm0d-atom-winpad12"
        ;;
  probook650g3)
        echo "$1: Installing Kernel and Headers for HP Probook 650 G3"
	TARGET="czm0d-kabylake-probook650g3"
        ;;
  *)
        echo "$1: Unknown Targe. Aborting!"
        echo "Usage: install-kernels.sh <target>"
        echo "Possible targets:  \"aw17r4\", \"eeepc\", \"winpad12\", \"probook650g3\""
        exit -1
        ;;
esac

sudo dpkg -i ../linux-image-*$TARGET*.deb ../linux-headers-*$TARGET*.deb
sudo update-grub
mkdir -p ../olddebs
echo "Installing Kernel"
mv ../linux-image-*$TARGET*.deb ../olddebs
echo "Installing Headers"
mv ../linux-headers-*$TARGET*.deb ../olddebs

echo "Done."
exit 0

