#!/bin/bash
#cp /boot/config-`uname -r` ./.config
make mrproper
make clean

cp ../confs/.config-aw17 ./.config

make oldconfig

make menuconfig

make prepare
