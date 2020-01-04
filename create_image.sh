#!/bin/bash
VERSION=c7130471583d200ecd10606b10f116b1c00dfa42

if [ ! -d buildroot ]
then
	git clone https://github.com/buildroot/buildroot.git
	cd buildroot && git checkout $VERSION
	cd ../
fi

cp -a packages/puredata/ buildroot/package/

#apply patches to buildroot
cd buildroot
patch -p1 < ../patches/buildroot/0001-add-pd-config.patch
patch -p1 < ../patches/buildroot/0003-ssh-root-x11.patch
cd ..

make O=$PWD -C buildroot defconfig BR2_DEFCONFIG=../configs/buildroot-defconfig
make

