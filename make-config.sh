#!/bin/bash
#cp /boot/config-`uname -r` ./.config

case "$1" in
  aw17r4)
	echo "$1: Generating config for Dell Alienware 17R4"
	echo "Cleaning old config"
	make mrproper
	make clean

	#cp ../confs/.config-aw17 ./.config # Normal-config
	cp ../confs/.config-aw17_stripped_modules ./.config # config with stripped modules
	;;
  eeepc)
	echo "$1: Generating config for Asus EEEPC"
	echo "Cleaning old config"
	make mrproper
	make clean

	cp ../confs/.config_eeepc-strippedmodules ./.config
	;;
  winpad12)
	echo "$1: Generating config for Odys Winpad 12"
	echo "Cleaning old config"
	make mrproper
	make clean

	cp ../confs/.config-winpad12-strippedmodules ./.config
	;;
  probook650g3)
	echo "$1: Generating config for HP ProBook 650 G3"
	echo "Cleaning old config"
	make mrproper
	make clean

	cp ../confs/.config_probook650g3-strippedmodules ./.config
	;;
  *)
	echo "$1: Unknown Config. Aborting!"
	echo "Usage: make-config.sh <target>"
	echo "Possible targets:  \"aw17r4\", \"eeepc\", \"winpad12\", \"probook650g3\""
	exit -1
	;;
esac

make oldconfig

#make localmodconfig #Just include currently loaded modules


if [ "$2" != "auto" ]; then
	echo "Loading menuconfig in case you want to change something..."
	make menuconfig
else
	echo "$2 is given. omitting menuconfig..."
fi

make prepare
