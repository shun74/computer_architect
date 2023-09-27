#!/bin/bash
PROJECT_DIR=${PWD}

set -xue

QEMU=qemu-system-riscv32

OBJCOPY=/usr/bin/llvm-objcopy
CC=/usr/bin/clang

CFLAGS="-std=c11 -O2 -g3 -Wall -Wextra --target=riscv32 -ffreestanding -nostdlib"

# シェルをビルド
$CC $CFLAGS -Wl,-T./linker/user.ld -Wl,-Map=shell.map -o shell.elf \
    -Iinclude ./src/shell.c ./src/user.c ./src/common.c
$OBJCOPY --set-section-flags .bss=alloc,contents -O binary shell.elf shell.bin
$OBJCOPY -Ibinary -Oelf32-littleriscv shell.bin shell.bin.o

# カーネルをビルド
$CC $CFLAGS -Wl,-T./linker/kernel.ld -Wl,-Map=kernel.map -o kernel.elf \
    -Iinclude ./src/kernel.c ./src/common.c shell.bin.o

(cd disk && tar cf ../disk.tar --format=ustar ./*.txt)

$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot \
    -d unimp,guest_errors,int,cpu_reset -D qemu.log \
    -drive id=drive0,file=disk.tar,format=raw \
    -device virtio-blk-device,drive=drive0,bus=virtio-mmio-bus.0 \
    -kernel kernel.elf