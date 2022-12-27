#!/bin/bash
# Determine Threads used for decompression based on logical CPUs
################################################################
LOGICALCPUS=$(cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l)
THREADS=$(($LOGICALCPUS+1))


DOWNLOADPATH=""

#FUNCTIONS:
determine_newstablekernel () {
	# Checks Kernel.org for the newest stable source
	version=$(wget --output-document - --quiet https://www.kernel.org/ | grep -A 1 "latest_link")
	version=${version##*.tar.xz\">}
	version=${version%</a>}
	echo $version
}

determine_latestlongtermkernel () {
	# Checks Kernel.org for the latest longterm source
	version=$(wget --output-document - --quiet https://www.kernel.org/ | grep -A 1 "longterm" | grep "strong" | cut -d">" -f 3 | cut -d"<" -f1 | head -n 1)
	echo $version
}

determine_previouslongtermkernel () {
	# Checks Kernel.org for the latest longterm source
	version=$(wget --output-document - --quiet https://www.kernel.org/ | grep -A 1 "longterm" | grep "strong" | cut -d">" -f 3 | cut -d"<" -f1 | head -n 2 | tail -n 1)
	echo $version
}

determine_versiondots () {
	# Checks a String (Kernel-Version) for dots an counts them
	#echo $1 # DEBUG
	VERSIONDOTS=$(echo $1 | tr -cd '.' | wc -c)
	return $VERSIONDOTS
	}


#MAIN:
# Default ist newest kernel
echo "Choosing latest stable kernel..."
DOWNLOADPATH="https://mirrors.edge.kernel.org/pub/linux/kernel/v6.x/" # Todo: Should find a better way for this in the future
KERNELV="linux-$(determine_newstablekernel)"  # Change Archive as needed...

if ! [ -z "$1" ]; then
	#Argument is given
	if [[ "$1" == "longterm" ]]; then
		# longterm choosen instead
		echo "Choosing latest longterm kernel..."
		DOWNLOADPATH="https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/" # Todo: Should do this better in the future
		KERNELV="linux-$(determine_latestlongtermkernel)"  # Change Archive as needed...
	elif [[ "$1" == "longterm2" ]]; then
                # longterm choosen instead
                echo "Choosing prevoius longterm kernel..."
                DOWNLOADPATH="https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/" # Todo: Should do this better in the future
                KERNELV="linux-$(determine_previouslongtermkernel)"  # Change Archive as needed...
	fi
fi


#KERNELV="linux-4.19.73"  # Change Archive as needed to override previous value...

KERNELTAR="$KERNELV.tar"
KERNEL="$KERNELTAR.xz"
SIGN="$KERNELV.tar.sign" # Kernel Signature

echo "Removing old .tar(.gz/.xz/.sign)-files"
rm ./*.tar -f
rm ./*.tar.xz* -f
rm ./*.tar.gz* -f
rm ./*.tar.sign* -f

echo "Downloading Source for $KERNELV from kernel.org ..."
wget $DOWNLOADPATH$KERNEL

echo "Unpacking $KERNEL"
xz --decompress --threads=$THREADS $KERNEL

echo "Downloading GPG-Signatures for Signature-check"
gpg --locate-keys torvalds@kernel.org gregkh@kernel.org

echo "Getting Kernelsignature"
wget $DOWNLOADPATH$SIGN

if [ "$1" == "nogpg" ]; then
	echo "$1 is given. Skipping Signaturecheck"
else
	echo "checking signature"
	#CHECK=1

	gpg --trust-model tofu --verify $SIGN $KERNELTAR
	CHECK=$?
	#CHECK=$(gpg --trust-model tofu --verify $SIGN $KERNELTAR)

	#https://www.kernel.org/signature.html
	#Developer	Fingerprint
	#Linus Torvalds	ABAF 11C6 5A29 70B1 30AB  E3C4 79BE 3E43 0041 1886
	#Greg Kroah-Hartman	647F 2865 4894 E3BD 4571  99BE 38DB BDC8 6092 693E
	#Sasha Levin	E27E 5D8A 3403 A2EF 6687  3BBC DEA6 6FF7 9777 2CDC
	#Ben Hutchings	AC2B 29BD 34A6 AFDD B3F6  8F35 E7BF C8EC 9586 1109

	echo "GPG-Result is $CHECK"

	if [ $CHECK -ne 0 ]; then
		echo "Signature Check failed. Aborting."
		echo "This can happen if the kernel-tarball was modified after signing from the developers."
		echo "You can use \"nogpg\" to skip signature-checking."
		echo "Proceed at your own risk."
		exit 1
	else
		echo "Signature Check passed."
	fi
fi

echo "Untaring $KERNEL"
tar -xf $KERNELTAR

echo "Kernel: $KERNEL"

# Define Kerneldir by cutting of dots
determine_versiondots $KERNELV
DOTSTOCUT=$(($? + 1))

KERNELDIR=""

for ((i=1; i<=$DOTSTOCUT; i++)); do
	KDIR=`echo "$KERNEL" | cut -f $i -d '.'`
	if [ $i -gt 1 ]; then
		KERNELDIR="$KERNELDIR.$KDIR"
	else
		KERNELDIR="$KDIR"
	fi
done

echo "Kerneldir: $KERNELDIR ..."

echo "Linking Scripts into $KERNELDIR ..."
ln -s ../build-kernel.sh ./$KERNELDIR/build-kernel.sh
ln -s ../make-config.sh ./$KERNELDIR/make-config.sh
ln -s ../install-kernels.sh ./$KERNELDIR/install-kernels.sh
ln -s ../make-all.sh ./$KERNELDIR/make-all.sh

echo "All done. You may now \"cd $KERNELDIR\" and run the scripts to build your kernel(s)."
echo ""

exit 0
