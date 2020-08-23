#!/bin/bash
# This will download the firmware files for intel i915
# Afterwards a update-initramfs should be done, this should avoid "missing firmware"-errors
# https://unix.stackexchange.com/questions/556946/possible-missing-firmware-lib-firmware-i915-for-module-i915
# D.Marx 2020/07


mkdir -p ./download
mkdir -p /lib/firmware/i915/
wget http://anduin.linuxfromscratch.org/sources/linux-firmware/i915/ -O ./download/firmware.list
for fle in $(cat ./download/firmware.list | grep "li" | grep ".bin" | cut -d"\"" -f2); do
	wget http://anduin.linuxfromscratch.org/sources/linux-firmware/i915/$fle -O ./download/$fle
	cp ./download/$fle /lib/firmware/i915/
	echo $fle
done

echo "all done."
rm ./download -rf
