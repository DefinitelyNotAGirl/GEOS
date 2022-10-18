.code64
.section .text
/* GEOS START SIGNATURE (GEOS_LAUNCH)*/
.quad 0x47454F53
.quad 0x5F4C4155
.quad 0x4E434800

.global _geos
_geos:
    call main
    hlt
