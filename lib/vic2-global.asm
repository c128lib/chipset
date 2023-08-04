#importonce

#import "vic2.asm"

.filenamespace c128lib

/**
  Set border and background color with optimization if possible.

  @param[in] borderColor Border color to be set
  @param[in] backgroundColor Background color to be set

  @remark Register .A will be modified.

  @since 0.6.0
*/
.macro @c128lib_SetBorderAndBackgroundColor(borderColor, backgroundColor) { SetBorderAndBackgroundColor(borderColor, backgroundColor) }
.macro @c128lib_SetBorderAndBackgroundSameColor(color) { SetBorderAndBackgroundColor(color, color) }
/**
  Set border color

  @param[in] borderColor Border color to be set

  @remark Register .A will be modified.

  @since 0.6.0
*/
.macro @c128lib_SetBorderColor(borderColor) { SetBorderColor(borderColor) }
/**
  Set background color

  @param[in] backgroundColor Background color to be set

  @remark Register .A will be modified.

  @since 0.6.0
*/
.macro @c128lib_SetBackgroundColor(backgroundColor) { SetBackgroundColor(backgroundColor) }
.function @c128lib_getTextOffset(xPos, yPos) { .return getTextOffset(xPos, yPos) }
/**
  Set Basic IRQ routine active or not.

  @param[in] active Activate or deactivate basic irq

  @remark Register .A will be modified.

  @note Turning off the BASIC
  IRQ routine will give you direct access to the hardware registers,
  you should keep in mind that it will also effectively disable the
  BASIC statements MOVSPR, COLLISION, SOUND and PLAY

  @since 0.6.0
*/
.macro @c128lib_SetBasicIrqActivity(active) { SetBasicIrqActivity(active) }
/**
  Set screen editor IRQ routine active or not. This gives you direct control
  over the VIC chip register settings (D018), but disables BASIC'S ability
  to change display modes.

  @param[in] active Activate or deactivate basic irq

  @remark Register .A will be modified.

  @since 0.6.0
*/
.macro @c128lib_SetScreenEditorIrq(active) { SetScreenEditorIrq(active) }
/**
  Set screen memory and charset memory position by
  using shadow register.

  @param[in] config Screen memory and/or char memory configuration.

  @remark Register .A will be modified. Labels Vic2.CHAR* and
  Vic2.SCREEN_MEM* can ben used to compose.

  @since 0.6.0
*/
.macro @c128lib_SetScreenAndCharacterMemory(config) { SetScreenAndCharacterMemory(config) }
.macro @c128lib_SetScreenMemoryAndBitmapPointer(config) { SetScreenMemoryAndBitmapPointer(config) }

// .function @c128lib_getTextMemory(screenMem, charSet) { .return getTextMemory(screenMem, charSet) }
// .function @c128lib_getBitmapMemory(video, bitmap) { .return getBitmapMemory(video, bitmap) }
// .macro @c128lib_detectNtsc(onPalCallback, onNtscCallback) { detectNtsc(onPalCallback, onNtscCallback) }
.macro @c128lib_debugBorderStart() { debugBorderStart() }
.macro @c128lib_debugBorderEnd() { debugBorderEnd() }
/**
  Configures VIC-II so that it fire IRQ when given "rasterLine" is drawn.

  @param[in] rasterLine Line where irq should trigger

  @remark Register .A will be modified.

  @since 0.6.0
*/
.macro @c128lib_setRaster(rasterLine) { setRaster(rasterLine) }
.macro @c128lib_irqEnter() { irqEnter() }
.macro @c128lib_irqExit(intVector, rasterLine, memory) { irqExit(intVector, rasterLine, memory) }
.macro @c128lib_rotateCharRight(charPointer) { rotateCharRight(charPointer) }
.macro @c128lib_rotateCharBottom(charPointer, store) { rotateCharBottom(charPointer, store) }
