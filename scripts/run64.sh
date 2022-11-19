qemu-system-x86_64 -drive format=raw,file=GEOS.iso -d in_asm,int,cpu_reset -no-reboot -no-shutdown -m 2500M -smp 1 2> /GEOS_LOG/qemu.log
