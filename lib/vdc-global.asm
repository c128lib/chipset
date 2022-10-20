#import "vdc.asm"
#importonce
.filenamespace c128lib

.macro @c128lib_Go80() { Go80() }
.macro @c128lib_GetVDCDisplayStart() { GetVDCDisplayStart() }
.macro @c128lib_SetVDCUpdateAddress(address) { SetVDCUpdateAddress(address) }
.macro @c128lib_GetVDCColor(viccolor) { GetVDCColor(viccolor) }
