#!/bin/sh
mkdir -p outdir
export ARCH="arm64"
export SUBARCH="arm64"
export CROSS_COMPILE=$PWD/aarch64-linux-android-4.9/bin/aarch64-linux-android-
make -C $PWD O=outdir ARCH=arm64 ugglite_miui_defconfig
make -j4 -C $PWD O=outdir ARCH=arm64
git clone https://github.com/imzf/lazyflasher.git
cp -T outdir/arch/arm64/boot/Image.gz-dtb lazyflasher/Image.gz
cp -T outdir/drivers/staging/prima/wlan.ko lazyflasher/modules/wlan.ko
cd lazyflasher
make -j3
mkdir -p out
cp *.zip out
curl -O https://raw.githubusercontent.com/rockymadden/transfer-cli/master/src/transfer
chmod +x transfer
./transfer upload -f out
cd ..
cp -T lazyflasher/*.zip miui-kernel.zip
