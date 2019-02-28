#!/bin/bash
#cp /boot/config-`uname -r` ./.config
cp ../confs/.config_eeepc-slim ./.config

make oldconfig

make menuconfig
