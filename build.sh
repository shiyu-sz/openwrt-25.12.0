#!/bin/bash

clean() {
    rm -rf build_dir
    rm -rf staging_dir
    rm -rf bin
    rm -rf .config*
}

build_x86() {
    cp qemu_x86_64_defconfig .config
    make -j$(grep -c ^processor /proc/cpuinfo) 
}

build_x86() {
    cp qemu_aarch64_defconfig .config
    make -j$(grep -c ^processor /proc/cpuinfo) 
}

run_x86() {
    rm bin/targets/x86/64/openwrt-x86-64-generic-ext4-combined.img
    gunzip -k bin/targets/x86/64/openwrt-x86-64-generic-ext4-combined.img.gz
    # 只启动，无图形界面
    qemu-system-x86_64 -m 128 -smp 2 \
        -drive file=bin/targets/x86/64/openwrt-x86-64-generic-ext4-combined.img,format=raw \
        -net nic -net user,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:80 \
        -nographic

    # 带界面，用于测试lvgl和QT
    # qemu-system-x86_64 -m 256 \
    #     -drive file=bin/targets/x86/64/openwrt-x86-64-generic-ext4-combined.img,format=raw \
    #     -vga virtio \
    #     -display gtk \
    #     -net nic -net user,hostfwd=tcp::2222-:22
}

run_aarch64() {
    rm ./bin/targets/armsr/armv8/openwrt-armsr-armv8-generic-ext4-rootfs.img
    gunzip -k ./bin/targets/armsr/armv8/openwrt-armsr-armv8-generic-ext4-rootfs.img.gz
    # 只启动，无图形界面
    qemu-system-aarch64 -M virt -cpu cortex-a53 -nographic -smp 1 \
        -kernel ./bin/targets/armsr/armv8/openwrt-armsr-armv8-generic-kernel.bin -append "rootwait root=/dev/vda console=ttyAMA0" \
        -netdev user,id=eth0 -device virtio-net-device,netdev=eth0 \
        -drive file=./bin/targets/armsr/armv8/openwrt-armsr-armv8-generic-ext4-rootfs.img,if=none,format=raw,id=hd0 -device virtio-blk-device,drive=hd0
}

# mkdir -p /mnt/shared
# mount -t 9p -o trans=virtio,version=9p2000.L host0 /mnt/shared

build_package() {
    make package/${1}/{clean,compile} V=s
    make target/install V=s
}

if test "$1" = "clean" ; then
    clean
elif test "$1" = "x86" ; then
    build_x86
elif test "$1" = "run_x86" ; then
    run_x86
elif test "$1" = "aarch64" ; then
    build_aarch64
elif test "$1" = "run_aarch64" ; then
    run_aarch64
else
    build_package $1
fi
