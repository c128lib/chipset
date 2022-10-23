#import "vic2.asm"
#importonce
.filenamespace c128lib

.function @c128lib_getTextOffset(xPos, yPos) { .return getTextOffset(xPos, yPos) }
.function @c128lib_getTextOffset80Col(xPos, yPos) { .return getTextOffset80Col(xPos, yPos) }
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
