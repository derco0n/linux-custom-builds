 #!/bin/bash

#DOWNLOADPATH="https://mirrors.edge.kernel.org/pub/linux/kernel/v4.x/"
#KERNEL="linux-4.20.9.tar.xz"  # Change Archive as needed...

DOWNLOADPATH="https://github.com/multipath-tcp/mptcp_net-next/archive/"
KERNEL="export.zip"  # Change Archive as needed...

KERNELDIR="Linux-Upstream-MPTCP"

wget $DOWNLOADPATH$KERNEL
echo Unpacking $KERNEL
unzip $KERNEL -d ./$KERNELDIR

#echo "Kernel: $KERNEL"
echo "Kernel: $KERNELDIR"

#KDIR1=`echo "$KERNEL" | cut -f 1 -d '.'`
#KDIR2=`echo "$KERNEL" | cut -f 2 -d '.'`
#KDIR3=`echo "$KERNEL" | cut -f 3 -d '.'`

#KERNELDIR="$KDIR1.$KDIR2.$KDIR3"
#KERNELDIR="$KDIR1.$KDIR2"

echo "Kerneldir: $KERNELDIR ..."

echo Linking Scripts into $KERNELDIR ...
ln -s ../build-kernel.sh ./$KERNELDIR/build-kernel.sh
ln -s ../make-config.sh ./$KERNELDIR/make-config.sh
ln -s ../install-kernels.sh ./$KERNELDIR/install-kernels.sh


