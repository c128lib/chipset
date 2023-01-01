#import "vic2.asm"
#importonce
.filenamespace c128lib

.macro @c128lib_SetBorderAndBackgroundColor(borderColor, backgroundColor) { SetBorderAndBackgroundColor(borderColor, backgroundColor) }
.macro @c128lib_SetBorderAndBackgroundSameColor(color) { SetBorderAndBackgroundColor(color, color) }
.macro @c128lib_SetBorderColor(borderColor) { SetBorderColor(borderColor) }
.macro @c128lib_SetBackgroundColor(backgroundColor) { SetBackgroundColor(backgroundColor) }
.function @c128lib_getTextOffset(xPos, yPos) { .return getTextOffset(xPos, yPos) }
.macro @c128lib_SetBasicIrqActivity(active) { SetBasicIrqActivity(active) }
.macro @c128lib_SetScreenEditorIrq(active) { SetScreenEditorIrq(active) }
.macro @c128lib_SetScreenAndCharacterMemory(config) { SetScreenAndCharacterMemory(config) }
.macro @c128lib_SetScreenMemoryAndBitmapPointer(config) { SetScreenMemoryAndBitmapPointer(config) }

// .function @c128lib_getTextMemory(screenMem, charSet) { .return getTextMemory(screenMem, charSet) }
// .function @c128lib_getBitmapMemory(video, bitmap) { .return getBitmapMemory(video, bitmap) }
// .macro @c128lib_detectNtsc(onPalCallback, onNtscCallback) { detectNtsc(onPalCallback, onNtscCallback) }
.macro @c128lib_debugBorderStart() { debugBorderStart() }
.macro @c128lib_debugBorderEnd() { debugBorderEnd() }
.macro @c128lib_setRaster(rasterLine) { setRaster(rasterLine) }
.macro @c128lib_irqEnter() { irqEnter() }
.macro @c128lib_irqExit(intVector, rasterLine, memory) { irqExit(intVector, rasterLine, memory) }
.macro @c128lib_rotateCharRight(charPointer) { rotateCharRight(charPointer) }
.macro @c128lib_rotateCharBottom(charPointer, store) { rotateCharBottom(charPointer, store) }
.macro @c128lib_SpriteMove(spriteNo, speed, quadrant, deltaX, deltaY) { SpriteMove(spriteNo, speed, quadrant, deltaX, deltaY) }
