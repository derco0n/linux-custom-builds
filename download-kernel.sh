 #!/bin/bash

#DOWNLOADPATH="https://mirrors.edge.kernel.org/pub/linux/kernel/v4.x/"
#KERNEL="linux-4.20.9.tar.xz"  # Change Archive as needed...

DOWNLOADPATH="https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/"
KERNEL="linux-5.0.4.tar.xz"  # Change Archive as needed...

wget $DOWNLOADPATH$KERNEL
echo Unpacking $KERNEL
tar -Jxf $KERNEL

echo "Kernel: $KERNEL"

KDIR1=`echo "$KERNEL" | cut -f 1 -d '.'`
KDIR2=`echo "$KERNEL" | cut -f 2 -d '.'`
KDIR3=`echo "$KERNEL" | cut -f 3 -d '.'`

KERNELDIR="$KDIR1.$KDIR2.$KDIR3"
#KERNELDIR="$KDIR1.$KDIR2"


echo "Kerneldir: $KERNELDIR ..."

echo Linking Scripts into $KERNELDIR ...
ln -s ../build-kernel.sh ./$KERNELDIR/build-kernel.sh
ln -s ../make-config.sh ./$KERNELDIR/make-config.sh
ln -s ../install-kernels.sh ./$KERNELDIR/install-kernels.sh


