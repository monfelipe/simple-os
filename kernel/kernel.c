#include "../include/kernel/fun.h"
#include "../i386/vga.h"

void kernel_main(void) {
    char hello[35];

	terminal_initialize();
    terminal_writestring("Welcome to felipe's os!\n");
    terminal_writestring("hello\n");
    terminal_putchar(hello);
}

/* 

    i686-elf-gcc -c ../i386/fun.c -o fun.o -ffreestanding -O2 -Wall -Wextra -I../include
    i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
    i686-elf-as ../i386/boot.s -o boot.o
    i686-elf-gcc -T ../i386/linker.ld -o myos -ffreestanding -O2 -nostdlib boot.o kernel.o fun.o -lgcc
    no arch/ i686-elf-gcc -c i386/string.c -o kernel/string.o -ffreestanding -O2 -Wall -Wextra
    i686-elf-gcc -T i386/linker.ld -o kernel/myos -ffreestanding -O2 -nostdlib kernel/boot.o kernel/kernel.o kernel/fun.o kernel/string.o -lgcc
    grub-mkrescue -o myos.iso isodir

*/