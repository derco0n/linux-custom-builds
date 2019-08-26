#!/bin/bash

# Builds kernels for all Targets

# Targets
declare -a targets=("aw17r4" "eeepc") # Targets-Array

## now loop through the above array
for i in "${targets[@]}"
do
	echo "Building for $i"
	./make-config.sh $i auto
	./build-kernel.sh $i
	echo "Build for $i ended."
	echo ""
	echo "###################"
	echo ""
done



