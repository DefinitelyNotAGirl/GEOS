	.file	"main.c"
# GNU C17 (GCC) version 12.2.0 (x86_64-elf)
#	compiled by GNU C version 12.2.0, GMP version 6.2.1, MPFR version 4.1.0-p13, MPC version 1.2.1, isl version isl-0.25-GMP

# warning: MPFR header version 4.1.0-p13 differs from library version 4.2.0.
# warning: MPC header version 1.2.1 differs from library version 1.3.1.
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mno-red-zone -maccumulate-outgoing-args -mtune=generic -march=x86-64 -fpic -ffreestanding -fno-stack-protector -fstack-check=no -fshort-wchar
	.text
	.globl	getVolume
	.type	getVolume, @function
getVolume:
.LFB0:
	pushq	%rbp	#
.LCFI0:
	movq	%rsp, %rbp	#,
.LCFI1:
	subq	$96, %rsp	#,
	movq	%rdi, -88(%rbp)	# image, image
# src/UEFI/main.c:55:     EFI_LOADED_IMAGE *loaded_image = NULL;                  /* image interface */
	movq	$0, -8(%rbp)	#, loaded_image
# src/UEFI/main.c:56:     EFI_GUID lipGuid = EFI_LOADED_IMAGE_PROTOCOL_GUID;      /* image interface GUID */
	movl	$1528508833, -32(%rbp)	#, lipGuid.Data1
	movw	$-27294, -28(%rbp)	#, lipGuid.Data2
	movw	$4562, -26(%rbp)	#, lipGuid.Data3
	movabsq	$4283602510276476814, %rax	#, tmp105
	movq	%rax, -24(%rbp)	# tmp105, lipGuid.Data4
# src/UEFI/main.c:58:     EFI_GUID fsGuid = EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID; /* file system interface GUID */
	movl	$-1773249758, -64(%rbp)	#, fsGuid.Data1
	movw	$25689, -60(%rbp)	#, fsGuid.Data2
	movw	$4562, -58(%rbp)	#, fsGuid.Data3
	movabsq	$4283602510276475278, %rax	#, tmp106
	movq	%rax, -56(%rbp)	# tmp106, fsGuid.Data4
# src/UEFI/main.c:62:     uefi_call_wrapper(BS->HandleProtocol, 3, image, &lipGuid, (void **) &loaded_image);
	leaq	-8(%rbp), %rcx	#, loaded_image.0_1
	leaq	-32(%rbp), %rdx	#, lipGuid.1_2
	movq	-88(%rbp), %rsi	# image, image.2_3
	movq	BS@GOTPCREL(%rip), %rax	#, tmp101
	movq	(%rax), %rax	# BS, BS.3_4
	movq	152(%rax), %rax	# BS.3_4->HandleProtocol, _5
	movq	%rax, %rdi	# _5,
	call	efi_call3@PLT	#
# src/UEFI/main.c:64:     uefi_call_wrapper(BS->HandleProtocol, 3, loaded_image->DeviceHandle, &fsGuid, (VOID*)&IOVolume);
	leaq	-40(%rbp), %rcx	#, IOVolume.4_6
	leaq	-64(%rbp), %rdx	#, fsGuid.5_7
	movq	-8(%rbp), %rax	# loaded_image, loaded_image.6_8
	movq	24(%rax), %rax	# loaded_image.6_8->DeviceHandle, _9
	movq	%rax, %rsi	# _9, _10
	movq	BS@GOTPCREL(%rip), %rax	#, tmp102
	movq	(%rax), %rax	# BS, BS.7_11
	movq	152(%rax), %rax	# BS.7_11->HandleProtocol, _12
	movq	%rax, %rdi	# _12,
	call	efi_call3@PLT	#
# src/UEFI/main.c:65:     uefi_call_wrapper(IOVolume->OpenVolume, 2, IOVolume, &Volume);
	leaq	-72(%rbp), %rdx	#, Volume.8_13
	movq	-40(%rbp), %rax	# IOVolume, IOVolume.9_14
	movq	%rax, %rcx	# IOVolume.9_14, IOVolume.10_15
	movq	-40(%rbp), %rax	# IOVolume, IOVolume.11_16
	movq	8(%rax), %rax	# IOVolume.11_16->OpenVolume, _17
	movq	%rcx, %rsi	# IOVolume.10_15,
	movq	%rax, %rdi	# _17,
	call	efi_call2@PLT	#
# src/UEFI/main.c:66:     return Volume;
	movq	-72(%rbp), %rax	# Volume, _32
# src/UEFI/main.c:67: }
	leave	
.LCFI2:
	ret	
.LFE0:
	.size	getVolume, .-getVolume
	.section	.rodata
	.align 2
.LC0:
	.string	"l"
	.string	"o"
	.string	"a"
	.string	"d"
	.string	"i"
	.string	"n"
	.string	"g"
	.string	" "
	.string	"f"
	.string	"i"
	.string	"l"
	.string	"e"
	.string	":"
	.string	" "
	.string	""
	.string	""
	.align 2
.LC1:
	.string	"\n"
	.string	""
	.string	""
	.align 2
.LC2:
	.string	"d"
	.string	"e"
	.string	"b"
	.string	"u"
	.string	"g"
	.string	" "
	.string	"3"
	.string	"\n"
	.string	""
	.string	""
	.align 2
.LC3:
	.string	"d"
	.string	"e"
	.string	"b"
	.string	"u"
	.string	"g"
	.string	" "
	.string	"4"
	.string	"\n"
	.string	""
	.string	""
	.align 2
.LC4:
	.string	"d"
	.string	"e"
	.string	"b"
	.string	"u"
	.string	"g"
	.string	" "
	.string	"6"
	.string	"\n"
	.string	""
	.string	""
	.align 2
.LC5:
	.string	"d"
	.string	"e"
	.string	"b"
	.string	"u"
	.string	"g"
	.string	" "
	.string	"7"
	.string	"\n"
	.string	""
	.string	""
	.text
	.globl	readFile
	.type	readFile, @function
readFile:
.LFB1:
	pushq	%rbp	#
.LCFI3:
	movq	%rsp, %rbp	#,
.LCFI4:
	subq	$48, %rsp	#,
	movq	%rdi, -24(%rbp)	# filename, filename
	movq	%rsi, -32(%rbp)	# Volume, Volume
	movq	%rdx, -40(%rbp)	# filesize, filesize
	movq	%rcx, -48(%rbp)	# Buffer, Buffer
# src/UEFI/main.c:71:     Print(L"loading file: ");
	leaq	.LC0(%rip), %rax	#, tmp96
	movq	%rax, %rdi	# tmp96,
	movl	$0, %eax	#,
	call	Print@PLT	#
# src/UEFI/main.c:72:     Print(filename);
	movq	-24(%rbp), %rax	# filename, tmp97
	movq	%rax, %rdi	# tmp97,
	movl	$0, %eax	#,
	call	Print@PLT	#
# src/UEFI/main.c:73:     Print(L"\n");
	leaq	.LC1(%rip), %rax	#, tmp98
	movq	%rax, %rdi	# tmp98,
	movl	$0, %eax	#,
	call	Print@PLT	#
# src/UEFI/main.c:74:     Print(L"debug 3\n");
	leaq	.LC2(%rip), %rax	#, tmp99
	movq	%rax, %rdi	# tmp99,
	movl	$0, %eax	#,
	call	Print@PLT	#
# src/UEFI/main.c:78:     uefi_call_wrapper(Volume->Open, 5, Volume, &FileHandle, filename, EFI_FILE_MODE_READ, EFI_FILE_READ_ONLY | EFI_FILE_HIDDEN | EFI_FILE_SYSTEM);
	movq	-24(%rbp), %rcx	# filename, filename.12_1
	leaq	-8(%rbp), %rdx	#, FileHandle.13_2
	movq	-32(%rbp), %rsi	# Volume, Volume.14_3
	movq	-32(%rbp), %rax	# Volume, tmp100
	movq	8(%rax), %rax	# Volume_19(D)->Open, _4
	movl	$7, %r9d	#,
	movl	$1, %r8d	#,
	movq	%rax, %rdi	# _4,
	call	efi_call5@PLT	#
# src/UEFI/main.c:79:     Print(L"debug 4\n");
	leaq	.LC3(%rip), %rax	#, tmp101
	movq	%rax, %rdi	# tmp101,
	movl	$0, %eax	#,
	call	Print@PLT	#
# src/UEFI/main.c:82:     uefi_call_wrapper(FileHandle->Read, 3, &FileHandle, &filesize, Buffer);
	movq	-48(%rbp), %rcx	# Buffer, Buffer.15_5
	leaq	-40(%rbp), %rdx	#, filesize.16_6
	leaq	-8(%rbp), %rsi	#, FileHandle.17_7
	movq	-8(%rbp), %rax	# FileHandle, FileHandle.18_8
	movq	32(%rax), %rax	# FileHandle.18_8->Read, _9
	movq	%rax, %rdi	# _9,
	call	efi_call3@PLT	#
# src/UEFI/main.c:83:     Print(L"debug 6\n");
	leaq	.LC4(%rip), %rax	#, tmp102
	movq	%rax, %rdi	# tmp102,
	movl	$0, %eax	#,
	call	Print@PLT	#
# src/UEFI/main.c:86:     uefi_call_wrapper(FileHandle->Close, 1, &FileHandle);
	leaq	-8(%rbp), %rdx	#, FileHandle.19_10
	movq	-8(%rbp), %rax	# FileHandle, FileHandle.20_11
	movq	16(%rax), %rax	# FileHandle.20_11->Close, _12
	movq	%rdx, %rsi	# FileHandle.19_10,
	movq	%rax, %rdi	# _12,
	call	efi_call1@PLT	#
# src/UEFI/main.c:87:     Print(L"debug 7\n");
	leaq	.LC5(%rip), %rax	#, tmp103
	movq	%rax, %rdi	# tmp103,
	movl	$0, %eax	#,
	call	Print@PLT	#
# src/UEFI/main.c:88:     return Buffer;
	movq	-48(%rbp), %rax	# Buffer, _27
# src/UEFI/main.c:89: }
	leave	
.LCFI5:
	ret	
.LFE1:
	.size	readFile, .-readFile
	.globl	BUFFER_GFS0
	.section	.bss
	.align 32
	.type	BUFFER_GFS0, @object
	.size	BUFFER_GFS0, 1552
BUFFER_GFS0:
	.zero	1552
	.globl	BUFFER_ACPI
	.align 32
	.type	BUFFER_ACPI, @object
	.size	BUFFER_ACPI, 1312
BUFFER_ACPI:
	.zero	1312
	.globl	BUFFER_AHCI
	.align 32
	.type	BUFFER_AHCI, @object
	.size	BUFFER_AHCI, 1312
BUFFER_AHCI:
	.zero	1312
	.globl	BUFFER_IDE
	.align 32
	.type	BUFFER_IDE, @object
	.size	BUFFER_IDE, 1312
BUFFER_IDE:
	.zero	1312
	.globl	BUFFER_SATA
	.align 32
	.type	BUFFER_SATA, @object
	.size	BUFFER_SATA, 1312
BUFFER_SATA:
	.zero	1312
	.section	.rodata
	.align 2
.LC6:
	.string	"H"
	.string	"e"
	.string	"l"
	.string	"l"
	.string	"o"
	.string	" "
	.string	"w"
	.string	"o"
	.string	"r"
	.string	"l"
	.string	"d"
	.string	"!"
	.string	"\n"
	.string	""
	.string	""
	.align 2
.LC7:
	.string	"d"
	.string	"e"
	.string	"b"
	.string	"u"
	.string	"g"
	.string	" "
	.string	"1"
	.string	"\n"
	.string	""
	.string	""
	.align 2
.LC8:
	.string	"d"
	.string	"e"
	.string	"b"
	.string	"u"
	.string	"g"
	.string	" "
	.string	"2"
	.string	"\n"
	.string	""
	.string	""
	.align 8
.LC9:
	.string	"/"
	.string	"G"
	.string	"E"
	.string	"O"
	.string	"S"
	.string	"/"
	.string	"G"
	.string	"F"
	.string	"S"
	.string	"0"
	.string	"."
	.string	"f"
	.string	"s"
	.string	"."
	.string	"d"
	.string	"l"
	.string	"l"
	.string	""
	.string	""
	.align 2
.LC10:
	.string	"/"
	.string	"G"
	.string	"E"
	.string	"O"
	.string	"S"
	.string	"/"
	.string	"A"
	.string	"C"
	.string	"P"
	.string	"I"
	.string	"."
	.string	"d"
	.string	"l"
	.string	"l"
	.string	""
	.string	""
	.align 2
.LC11:
	.string	"/"
	.string	"G"
	.string	"E"
	.string	"O"
	.string	"S"
	.string	"/"
	.string	"A"
	.string	"H"
	.string	"C"
	.string	"I"
	.string	"."
	.string	"d"
	.string	"l"
	.string	"l"
	.string	""
	.string	""
	.align 2
.LC12:
	.string	"/"
	.string	"G"
	.string	"E"
	.string	"O"
	.string	"S"
	.string	"/"
	.string	"I"
	.string	"D"
	.string	"E"
	.string	"."
	.string	"d"
	.string	"l"
	.string	"l"
	.string	""
	.string	""
	.align 2
.LC13:
	.string	"/"
	.string	"G"
	.string	"E"
	.string	"O"
	.string	"S"
	.string	"/"
	.string	"S"
	.string	"A"
	.string	"T"
	.string	"A"
	.string	"."
	.string	"d"
	.string	"l"
	.string	"l"
	.string	""
	.string	""
	.align 8
.LC14:
	.string	"f"
	.string	"i"
	.string	"l"
	.string	"e"
	.string	"s"
	.string	" "
	.string	"l"
	.string	"o"
	.string	"a"
	.string	"d"
	.string	"e"
	.string	"d"
	.string	" "
	.string	"t"
	.string	"o"
	.string	" "
	.string	"m"
	.string	"e"
	.string	"m"
	.string	"o"
	.string	"r"
	.string	"y"
	.string	"\n"
	.string	""
	.string	""
	.text
	.globl	efi_main
	.type	efi_main, @function
efi_main:
.LFB2:
	pushq	%rbp	#
.LCFI6:
	movq	%rsp, %rbp	#,
.LCFI7:
	subq	$64, %rsp	#,
	movq	%rdi, -56(%rbp)	# ImageHandle, ImageHandle
	movq	%rsi, -64(%rbp)	# SystemTable, SystemTable
# src/UEFI/main.c:99:     InitializeLib(ImageHandle, SystemTable);
	movq	-64(%rbp), %rdx	# SystemTable, tmp83
	movq	-56(%rbp), %rax	# ImageHandle, tmp84
	movq	%rdx, %rsi	# tmp83,
	movq	%rax, %rdi	# tmp84,
	call	InitializeLib@PLT	#
# src/UEFI/main.c:100:     Print(L"Hello world!\n");
	leaq	.LC6(%rip), %rax	#, tmp85
	movq	%rax, %rdi	# tmp85,
	movl	$0, %eax	#,
	call	Print@PLT	#
# src/UEFI/main.c:102:     Print(L"debug 1\n");
	leaq	.LC7(%rip), %rax	#, tmp86
	movq	%rax, %rdi	# tmp86,
	movl	$0, %eax	#,
	call	Print@PLT	#
# src/UEFI/main.c:103:     EFI_FILE_HANDLE Volume = getVolume(ImageHandle);
	movq	-56(%rbp), %rax	# ImageHandle, tmp87
	movq	%rax, %rdi	# tmp87,
	call	getVolume@PLT	#
	movq	%rax, -8(%rbp)	# tmp88, Volume
# src/UEFI/main.c:105:     Print(L"debug 2\n");
	leaq	.LC8(%rip), %rax	#, tmp89
	movq	%rax, %rdi	# tmp89,
	movl	$0, %eax	#,
	call	Print@PLT	#
# src/UEFI/main.c:106:     UINT8* gfs0_dll = readFile(L"/GEOS/GFS0.fs.dll"  ,Volume,GEOS_FSIZE_GFS0,BUFFER_GFS0);
	movq	-8(%rbp), %rax	# Volume, tmp90
	movq	BUFFER_GFS0@GOTPCREL(%rip), %rdx	#, tmp92
	movq	%rdx, %rcx	# tmp91,
	movl	$1552, %edx	#,
	movq	%rax, %rsi	# tmp90,
	leaq	.LC9(%rip), %rax	#, tmp93
	movq	%rax, %rdi	# tmp93,
	call	readFile@PLT	#
	movq	%rax, -16(%rbp)	# tmp94, gfs0_dll
# src/UEFI/main.c:107:     UINT8* ACPI_dll = readFile(L"/GEOS/ACPI.dll"     ,Volume,GEOS_FSIZE_ACPI,BUFFER_ACPI);
	movq	-8(%rbp), %rax	# Volume, tmp95
	movq	BUFFER_ACPI@GOTPCREL(%rip), %rdx	#, tmp97
	movq	%rdx, %rcx	# tmp96,
	movl	$1312, %edx	#,
	movq	%rax, %rsi	# tmp95,
	leaq	.LC10(%rip), %rax	#, tmp98
	movq	%rax, %rdi	# tmp98,
	call	readFile@PLT	#
	movq	%rax, -24(%rbp)	# tmp99, ACPI_dll
# src/UEFI/main.c:108:     UINT8* AHCI_dll = readFile(L"/GEOS/AHCI.dll"     ,Volume,GEOS_FSIZE_AHCI,BUFFER_AHCI);
	movq	-8(%rbp), %rax	# Volume, tmp100
	movq	BUFFER_AHCI@GOTPCREL(%rip), %rdx	#, tmp102
	movq	%rdx, %rcx	# tmp101,
	movl	$1312, %edx	#,
	movq	%rax, %rsi	# tmp100,
	leaq	.LC11(%rip), %rax	#, tmp103
	movq	%rax, %rdi	# tmp103,
	call	readFile@PLT	#
	movq	%rax, -32(%rbp)	# tmp104, AHCI_dll
# src/UEFI/main.c:109:     UINT8* IDE_dll  = readFile(L"/GEOS/IDE.dll"      ,Volume,GEOS_FSIZE_IDE ,BUFFER_IDE );
	movq	-8(%rbp), %rax	# Volume, tmp105
	movq	BUFFER_IDE@GOTPCREL(%rip), %rdx	#, tmp107
	movq	%rdx, %rcx	# tmp106,
	movl	$1312, %edx	#,
	movq	%rax, %rsi	# tmp105,
	leaq	.LC12(%rip), %rax	#, tmp108
	movq	%rax, %rdi	# tmp108,
	call	readFile@PLT	#
	movq	%rax, -40(%rbp)	# tmp109, IDE_dll
# src/UEFI/main.c:110:     UINT8* SATA_dll = readFile(L"/GEOS/SATA.dll"     ,Volume,GEOS_FSIZE_SATA,BUFFER_SATA);
	movq	-8(%rbp), %rax	# Volume, tmp110
	movq	BUFFER_SATA@GOTPCREL(%rip), %rdx	#, tmp112
	movq	%rdx, %rcx	# tmp111,
	movl	$1312, %edx	#,
	movq	%rax, %rsi	# tmp110,
	leaq	.LC13(%rip), %rax	#, tmp113
	movq	%rax, %rdi	# tmp113,
	call	readFile@PLT	#
	movq	%rax, -48(%rbp)	# tmp114, SATA_dll
# src/UEFI/main.c:113:     Print(L"files loaded to memory\n");
	leaq	.LC14(%rip), %rax	#, tmp115
	movq	%rax, %rdi	# tmp115,
	movl	$0, %eax	#,
	call	Print@PLT	#
.L6:
# src/UEFI/main.c:115:     while(1);
	jmp	.L6	#
.LFE2:
	.size	efi_main, .-efi_main
	.section	.eh_frame,"aw",@progbits
.Lframe1:
	.long	.LECIE1-.LSCIE1
.LSCIE1:
	.long	0
	.byte	0x3
	.string	"zR"
	.byte	0x1
	.byte	0x78
	.byte	0x10
	.byte	0x1
	.byte	0x1b
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.byte	0x90
	.byte	0x1
	.align 8
.LECIE1:
.LSFDE1:
	.long	.LEFDE1-.LASFDE1
.LASFDE1:
	.long	.LASFDE1-.Lframe1
	.long	.LFB0-.
	.long	.LFE0-.LFB0
	.byte	0
	.byte	0x4
	.long	.LCFI0-.LFB0
	.byte	0xe
	.byte	0x10
	.byte	0x86
	.byte	0x2
	.byte	0x4
	.long	.LCFI1-.LCFI0
	.byte	0xd
	.byte	0x6
	.byte	0x4
	.long	.LCFI2-.LCFI1
	.byte	0xc6
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.align 8
.LEFDE1:
.LSFDE3:
	.long	.LEFDE3-.LASFDE3
.LASFDE3:
	.long	.LASFDE3-.Lframe1
	.long	.LFB1-.
	.long	.LFE1-.LFB1
	.byte	0
	.byte	0x4
	.long	.LCFI3-.LFB1
	.byte	0xe
	.byte	0x10
	.byte	0x86
	.byte	0x2
	.byte	0x4
	.long	.LCFI4-.LCFI3
	.byte	0xd
	.byte	0x6
	.byte	0x4
	.long	.LCFI5-.LCFI4
	.byte	0xc6
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.align 8
.LEFDE3:
.LSFDE5:
	.long	.LEFDE5-.LASFDE5
.LASFDE5:
	.long	.LASFDE5-.Lframe1
	.long	.LFB2-.
	.long	.LFE2-.LFB2
	.byte	0
	.byte	0x4
	.long	.LCFI6-.LFB2
	.byte	0xe
	.byte	0x10
	.byte	0x86
	.byte	0x2
	.byte	0x4
	.long	.LCFI7-.LCFI6
	.byte	0xd
	.byte	0x6
	.align 8
.LEFDE5:
	.ident	"GCC: (GNU) 12.2.0"
