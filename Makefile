#GCC flags (both C and C++)
GCCFLAGS+=-O2 -g -c -Wall -Wextra -Wpedantic -Wstrict-aliasing
GCCFLAGS+=-Wno-pointer-arith -Wno-unused-parameter
GCCFLAGS+=-nostdlib -ffreestanding -fno-pie -fno-stack-protector
GCCFLAGS+=-fno-builtin-function -fno-builtin

#Linker
ARCH64=elf_x86_64
ARCH32=elf_i386
LD=ld
LDFLAGS=--oformat=binary

#GCC
CC=gcc

RUN=./scripts/run64.sh

#C exclusive flags
CFLAGS=-std=c2x -Wno-int-conversion -Wno-pointer-to-int-cast -Wno-int-to-pointer-cast -Wno-pedantic $(GCCFLAGS)
#C++ exclusive flags
CPPFLAGS=-std=c++20 -Wno-write-strings $(GCCFLAGS)

BOOT_SRC = src/boot/boot.s
BOOT_OBJ = build/boot.o

INIT64_SRC = src/init64/init64.c
INIT64_OBJ = build/init64.o

INIT64_SRC2 = src/init64/start.s
INIT64_OBJ2 = build/start.o

GEOS_SRC = src/GEOS.cpp
GEOS_OBJ = build/geos.o

GEOS_SRC2 = src/GEOS_LAUNCH.s
GEOS_OBJ2 = build/GEOS_LAUNCH.o

init64_obj = $(INIT64_OBJ) $(INIT64_OBJ2)
geos_obj = $(GEOS_OBJ) $(GEOS_OBJ2)

BOOT=./bin/boot.bin
init64=./bin/init64.bin
geos=./bin/geos.bin
ISO=GEOS.iso
all: print boot sys iso

print:
	$(info boot: $(BOOT_OBJ))
	$(info kernel: $(init64_obj))
	$(info GEOS: $(geos_OBJ))

boot: $(BOOT_OBJ)
	$(LD) -o $(BOOT) $(LDFLAGS) $^ -Ttext 0x7C00 -m $(ARCH32)

sys: $(init64_obj) $(geos_obj)
	$(LD) -o $(init64) $(init64_obj) $(LDFLAGS) -Tlink.ld -m $(ARCH32)
	$(LD) -o $(geos) $(geos_obj) $(LDFLAGS) -Tlink.geos.ld -m $(ARCH64)

build/boot.o:
	$(CC) -$(ARCH32) -o $(BOOT_OBJ) $(BOOT_SRC) $(GCCFLAGS) -m32

build/init64.o:
	$(CC) -$(ARCH32) -o $(INIT64_OBJ) $(INIT64_SRC) $(CFLAGS) -m32 -DGEOS_32bit

build/start.o:
	$(CC) -$(ARCH32) -o $(INIT64_OBJ2) $(INIT64_SRC2) $(CFLAGS) -m32

build/geos.o:
	g++ -$(ARCH64) -o $(GEOS_OBJ) $(GEOS_SRC) $(CPPFLAGS) -m64

build/GEOS_LAUNCH.o:
	gcc -$(ARCH64) -o $(GEOS_OBJ2) $(GEOS_SRC2) $(CPPFLAGS) -m64

iso: 
	dd if=/dev/zero of=$(ISO) bs=512 count=2880
	dd if=$(BOOT) of=$(ISO) conv=notrunc bs=512 seek=0 count=1
	dd if=$(init64) of=$(ISO) conv=notrunc bs=512 seek=1 count=2048
	dd if=$(geos) of=$(ISO) conv=notrunc bs=512 seek=6 count=2048

run: clean all
	$(RUN)

clean:
	clear
	rm -f ./**/*.o
	rm -f ./*.iso
	rm -f ./**/*.elf
	rm -f ./**/*.bin
	rm -f ./**/*.d