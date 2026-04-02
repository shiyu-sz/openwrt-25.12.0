#!/bin/bash

build_clean() {
    rm -rf build_dir
    rm -rf staging_dir
    rm -rf bin
    rm -rf .config*
}

build_x86_64() {
    cp qemu_x86_64_defconfig .config
    make -j8 
}

run_x86_64() {
    gunzip bin/targets/x86/64/openwrt-x86-64-generic-ext4-combined.img.gz
    qemu-system-x86_64 \
        -m 128 \
        -smp 2 \
        -drive file=bin/targets/x86/64/openwrt-x86-64-generic-ext4-combined.img,format=raw \
        -net nic -net user,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:80 \
        -nographic
}

# mkdir -p /mnt/shared
# mount -t 9p -o trans=virtio,version=9p2000.L host0 /mnt/shared

build_package() {
    make ${1}-rebuild
    make
}

if test "$1" = "clean" ; then
    build_clean
elif test "$1" = "x86_64" ; then
    build_x86_64
elif test "$1" = "run_x86_64" ; then
    run_x86_64
else
    build_package $1
fi
