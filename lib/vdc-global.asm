#import "vdc.asm"
#importonce
.filenamespace c128lib

.macro @c128lib_Go40() { Go40() }
.macro @c128lib_Go80() { Go80() }
.function @c128lib_getTextOffset80Col(xPos, yPos) { .return getTextOffset80Col(xPos, yPos) }
.macro @c128lib_GetVDCDisplayStart() { GetVDCDisplayStart() }
.macro @c128lib_SetVDCUpdateAddress(address) { SetVDCUpdateAddress(address) }
.macro @c128lib_GetVDCColor(viccolor) { GetVDCColor(viccolor) }
.macro @c128lib_WriteVDC() { WriteVDC() }
.macro @c128lib_ReadVDC() { ReadVDC() }
.macro @c128lib_SetBackgroundForegroundColor(background, foreground) { SetBackgroundForegroundColor(background, foreground) }
.macro @c128lib_SetBackgroundForegroundColorWithVars(background, foreground) { SetBackgroundForegroundColorWithVars(background, foreground) }
.macro @c128lib_WriteToVdcMemoryByCoordinates(source, xPos, yPos, qty) { WriteToVdcMemoryByCoordinates(source, xPos, yPos, qty) }
.macro @c128lib_WriteToVdcMemoryByAddress(source, destination, qty) { WriteToVdcMemoryByAddress(source, destination, qty) }
.macro @c128lib_ReadFromVdcMemoryByCoordinates(source, xPos, yPos, qty) { ReadFromVdcMemoryByCoordinates(source, xPos, yPos, qty) }
.macro @c128lib_ReadFromVdcMemoryByAddress(source, destination, qty) { ReadFromVdcMemoryByAddress(source, destination, qty) }

.macro @c128lib_WriteVDCWithKernal(register, value) { WriteVDCWithKernal(register, value) }
.macro @c128lib_ReadVDCWithKernal(register, value) { ReadVDCWithKernal(register, value) }
