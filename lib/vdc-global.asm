#import "vdc.asm"
#importonce
.filenamespace c128lib

.macro @c128lib_Go40() { Go40() }
.macro @c128lib_Go80() { Go80() }
.function @c128lib_getTextOffset80Col(xPos, yPos) { .return getTextOffset80Col(xPos, yPos) }

.function @c128lib_CalculateBackgroundAndForeground(background, foreground) { .return CalculateBackgroundAndForeground(background, foreground); }
.function @c128lib_CalculateAttributeByte(attributes, color) { .return CalculateAttributeByte(attributes, color); }
.macro @c128lib_GetVdcDisplayStart() { GetVdcDisplayStart() }
.macro @c128lib_SetVdcUpdateAddress(address) { SetVdcUpdateAddress(address) }
.macro @c128lib_GetVdcColor(viccolor) { GetVdcColor(viccolor) }
.macro @c128lib_WriteVdc() { WriteVdc() }
.macro @c128lib_ReadVdc() { ReadVdc() }
.macro @c128lib_SetBackgroundForegroundColor(background, foreground) { SetBackgroundForegroundColor(background, foreground) }
.macro @c128lib_SetBackgroundForegroundColorWithVars(background, foreground) { SetBackgroundForegroundColorWithVars(background, foreground) }
.macro @c128lib_ReadFromVdcMemoryByCoordinates(xPos, yPos, destination, qty) { ReadFromVdcMemoryByCoordinates(xPos, yPos, destination, qty) }
.macro @c128lib_ReadFromVdcMemoryByAddress(source, destination, qty) { ReadFromVdcMemoryByAddress(source, destination, qty) }
.macro @c128lib_WriteToVdcMemoryByCoordinates(source, xPos, yPos, qty) { WriteToVdcMemoryByCoordinates(source, xPos, yPos, qty) }
.macro @c128lib_WriteToVdcMemoryByAddress(source, destination, qty) { WriteToVdcMemoryByAddress(source, destination, qty) }

.macro @c128lib_WriteVdcWithKernal(register, value) { WriteVdcWithKernal(register, value) }
.macro @c128lib_ReadVdcWithKernal(register, value) { ReadVdcWithKernal(register, value) }

// .macro @c128lib_Print80Str(address) { Print80Str(address) }
.macro @c128lib_FillScreen(char) { FillScreen(char) }
.macro @c128lib_FillAttribute(byte) { FillAttribute(byte) }
.macro @c128lib_MoveAttributePointerTo00() { MoveAttributePointerTo00() }
.macro @c128lib_PrintCharAtPosition(char, x, y) { PrintCharAtPosition(char, x, y) }
.macro @c128lib_PositionXy(x, y) { PositionXy(x, y) }
.macro @c128lib_PositionAttrXy(x, y) { PositionAttrXy(x, y) }
.macro @c128lib_RepeatByte(times) { RepeatByte(times) }
.macro @c128lib_WriteByte(byteToWrite) { WriteByte(byteToWrite) }
.macro @c128lib_SetRamPointer(address) { SetRamPointer(address) }
.macro @c128lib_InitText() { InitText() }
