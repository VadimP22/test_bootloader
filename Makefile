SHELL := /bin/bash

SRCS=$(wildcard src/*.c)
TARGETS=$(SRCS:src/%.c=%)


all:
	@echo "targets:"
	@echo "build [dist/bootloader.bin] - build bootloader.bin (raw binary file)"
	@echo "build_debug [dist/bootloader.gdb] - build gdb symbol table"
	@echo "run - run bootloader.bin using qemu"
	@echo "run_debug - run bootloader.bin in debug mode using qemu (it will be wait until you connect gdb)"
	@echo "gdb - run and attach gdb"
	@echo "clean - remove dist/"


gdb:
	@gdb dist/bootloader.gdb -x scripts/gdb/attach_gdb.txt


run:
	@qemu-system-x86_64 -drive file=dist/bootloader.bin,format=raw,index=0,media=disk -nographic


run_debug:
	@qemu-system-x86_64 -drive file=dist/bootloader.bin,format=raw,index=0,media=disk -s -S -nographic


build: pre_build compile_trampoline compile_c link
	@echo Building complete!


build_debug: build
	@ld -T scripts/linker/gdb_symbols.ld dist/*.o -o dist/bootloader.gdb


pre_build:
	@echo "Building bootloader"


clean:
	@echo "Removing ./dist"
	@rm -r dist


compile_c: $(TARGETS)
	@echo Compiled!

$(TARGETS):
	@echo Compiling $@.c
	@gcc -fno-pie -m16 -ffreestanding -g -c src/$@.c -o dist/$@.o -O0
	

compile_trampoline:
	@if [[ -e dist ]]; then echo "./dist exists"; else echo "Creating ./dist" && mkdir dist; fi
	@echo "Compiling trampoline.asm"
	@nasm -f elf -F dwarf -g trampoline.asm -o dist/trampoline.o


link:
	@echo "Linking .o files"
	@ld -T scripts/linker/link.ld dist/*.o -o dist/bootloader.bin


link_elf:
	@echo "Linking .o files"
	@ld -T scripts/linker/elf.ld dist/*.o -o dist/bootloader.elf
