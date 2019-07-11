#!/bin/bash
#cp /boot/config-`uname -r` ./.config
make mrproper
make clean

cp ../confs/.config-aw17 ./.config # Normal-config
#cp ../confs/.config-aw17_stripped_modules ./.config # config with stripped modules

make oldconfig

#make localmodconfig #Just include currently loaded modules

make menuconfig

make prepare
