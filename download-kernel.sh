 #!/bin/bash

DOWNLOADPATH="https://mirrors.edge.kernel.org/pub/linux/kernel/v4.x/"
KERNEL="linux-4.20.9.tar.xz"  # Change Archive as needed...

wget $DOWNLOADPATH$KERNEL
echo Unpacking $KERNEL
tar -Jxf $KERNEL

KERNELDIR=$KERNEL | cut -f 1 -d '.'

echo Linking Scripts into $KERNELDIR ...
ln -s ./build-kernel.sh ./$KERNELDIR/build-kernel.sh
ln -s ./make-config.sh ./$KERNELDIR/make-config.sh
ln -s ./install-kernels.sh ./$KERNELDIR/install-kernels.sh


