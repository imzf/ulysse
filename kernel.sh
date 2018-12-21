#!/bin/sh
mkdir -p outdir
export ARCH="arm64"
export SUBARCH="arm64"
export CROSS_COMPILE=$PWD/aarch64-linux-android-4.9/bin/aarch64-linux-android-
make -C $PWD O=outdir ARCH=arm64 ugglite_msm8937_defconfig
make -j4 -C $PWD O=outdir ARCH=arm64
curl -O https://raw.githubusercontent.com/rockymadden/transfer-cli/master/src/transfer
chmod +x transfer
transfer upload -f outdir/arch/arm64/boot/
