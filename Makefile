#GCC flags (both C and C++)
GCCFLAGS+= -ffreestanding -O2 -Wall -Wextra

#Linker
ARCH64=elf_x86_64
ARCH32=elf_i386
LD=ld
LDFLAGS=--oformat=binary

#GCC
GCC=gcc
G++=g++

RUN=./scripts/run64.sh

#C exclusive flags
CFLAGS=-std=c2x $(GCCFLAGS)
#C++ exclusive flags
CPPFLAGS=-std=c++20 -fno-exceptions -fno-rtti $(GCCFLAGS)

BOOT_SRC = src/boot.s
BOOT_OBJ = build/boot.o

GEOS_SRC = src/GEOS.cpp
GEOS_OBJ = build/geos.o

geos_obj = $(GEOS_OBJ)

geos=./bin/geos.bin
ISO=GEOS.iso

all: print sys makeBootable

print:
	$(info boot: $(BOOT_OBJ))
	$(info GEOS: $(geos_OBJ))

sys: $(geos_obj)
	$(LD) -o $(geos) $(geos_obj) $(BOOT_OBJ)  $(LDFLAGS) -Tlink.ld -m $(ARCH32)

build/boot.o:
	$(GCC) -$(ARCH32) -o $(BOOT_OBJ) $(BOOT_SRC) $(GCCFLAGS) -m32

build/geos.o:
	$(G++) -$(ARCH32) -o $(GEOS_OBJ) $(GEOS_SRC) $(CPPFLAGS) -m32

makeBootable:
	mkdir -p isodir/boot/grub
	cp bin/geos.bin build/grub/geos.bin
	cp grub.cfg build/grub/grub/grub.cfg
	grub-mkrescue -o GEOS.iso build/grub

run: clean all
	$(RUN)

clean:
	clear
	rm -f ./**/*.o
	rm -f ./*.iso
	rm -f ./**/*.elf
	rm -f ./**/*.bin
	rm -f ./**/*.d