#!/bin/bash
#cp /boot/config-`uname -r` ./.config
cp ../confs/.config_eeepc-slim5 ./.config

make oldconfig

make menuconfig
