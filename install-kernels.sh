#!/bin/bash
sudo dpkg -i ../linux-image-*.deb ../linux-headers-*.deb
sudo update-grub
mv ../linux-image-*.deb ../olddebs
mv ../linux-headers-*.deb ../olddebs
