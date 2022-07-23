#!/bin/bash

Start=$(date +"%s")
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=${HOME}/toolchain/dtc/dtc-1.4.4/prebuilt/dtc
export KBUILD_BUILD_USER="blakbin.blogspot.com"
export KBUILD_BUILD_HOST="Project-Rumble"
make O=${HOME}/vayux/out ARCH=arm64 vayu_rumble_defconfig

make -j$(nproc --all)  O=${HOME}/vayux/out \
PATH="${HOME}/toolchain/clang/LLVM-10.0.9/bin:${HOME}/toolchain/gcc/aarch64-linux-android-4.9//bin:${PATH}" \
                                ARCH=arm64 \
                                REAL_CC=clang \
                                CROSS_COMPILE=aarch64-linux-android- \
                                CLANG_TRIPLE=aarch64-linux-gnu- | tee ${HOME}/vayux/out/kernel.log
End=$(date +"%s")
Diff=$(($End - $Start))
echo -e "$gre << Build completed in $(($Diff / 60)) minutes and $(($Diff % 60)) seconds >> \n $white"
