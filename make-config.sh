#!/bin/bash
#cp /boot/config-`uname -r` ./.config
make mrproper
make clean

cp ../confs/.config_eeepc-strippedmodules ./.config
#cp ../confs/.config_eeepc-slim5 ./.config

make oldconfig

#make localmodconfig #Just include currently loaded modules

make menuconfig
