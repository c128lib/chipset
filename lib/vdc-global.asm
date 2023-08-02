#importonce

#import "vdc.asm"

.filenamespace c128lib

/**
  Go to 40 columns mode

  @since 0.6.0
*/
.macro @c128lib_Go40() { Go40() }
/**
  Go to 80 columns mode

  @since 0.6.0
*/
.macro @c128lib_Go80() { Go80() }
/**
  Calculates memory offset of text cell specified by given coordinates
  on 80 cols screen

  @param[in] xPos X coord on Vdc screen
  @param[in] yPos Y coord on Vdc screen
  @return Memory offset of Vdc specified coordinate

  @since 0.6.0
*/
.function @c128lib_getTextOffset80Col(xPos, yPos) { .return getTextOffset80Col(xPos, yPos) }

/**
  Calculate byte with hi nibble to foreground color and low nibble
  to background color.

  @param[in] background Background color
  @param[in] foreground Foreground color

  @since 0.6.0
*/
.function @c128lib_CalculateBackgroundAndForeground(background, foreground) { .return CalculateBackgroundAndForeground(background, foreground); }
.function @c128lib_CalculateAttributeByte(attributes, color) { .return CalculateAttributeByte(attributes, color); }
/**
  Returns the address start of Vdc display memory data. This
  is stored in Vdc register SCREEN_MEMORY_STARTING_HIGH_ADDRESS and 
  SCREEN_MEMORY_STARTING_LOW_ADDRESS.
  The 16-bit value is stored in $FB and $FC.

  @since 0.6.0
*/
.macro @c128lib_GetVdcDisplayStart() { GetVdcDisplayStart() }
/**
  Set the pointer to the RAM area that is to be updated.
  The update pointer is stored in Vdc register CURRENT_MEMORY_HIGH_ADDRESS
  and CURRENT_MEMORY_LOW_ADDRESS.

  @param[in] address Address of update area

  @since 0.6.0
*/
.macro @c128lib_SetVdcUpdateAddress(address) { SetVdcUpdateAddress(address) }
/**
  Translates between Vic and Vdc color codes.

  @param[in] viccolor Vic color code to translate

  @since 0.6.0
*/
.macro @c128lib_GetVdcColor(viccolor) { GetVdcColor(viccolor) }

/**
  Write a value into Vdc register without using kernal
  routine instead of pure instruction. It needs register
  number in X and value to write in A.
  It costs 11 bytes and 14 cycles.

  @since 0.6.0
*/
.macro @c128lib_WriteVdc() { WriteVdc() }
/**
  Read a value from Vdc register without using kernal
  routine instead of pure instruction. It needs register
  number in X and value is written in A.
  It costs 11 bytes and 14 cycles.

  @since 0.6.0
*/
.macro @c128lib_ReadVdc() { ReadVdc() }
/**
  Set background and foreground color, also disable bit 6 of
  HORIZONTAL_SMOOTH_SCROLLING register

  @since 0.6.0
*/
.macro @c128lib_SetBackgroundForegroundColor(background, foreground) { SetBackgroundForegroundColor(background, foreground) }
/**
  Set background and foreground color, also disable bit 6 of
  HORIZONTAL_SMOOTH_SCROLLING register. Use vars instead of labels.
  Warning: high nibble of background must be 0, it's up to developer
  to check this.

  @since 0.6.0
*/
.macro @c128lib_SetBackgroundForegroundColorWithVars(background, foreground) { SetBackgroundForegroundColorWithVars(background, foreground) }
/**
  Read from Vdc internal memory and write it to Vic screen memory by
  using coordinates.

  @param[in] xPos X coord on Vdc screen
  @param[in] yPos Y coord on Vdc screen
  @param[in] destination Vdc screen memory absolute address
  @param[in] qty Number of byte to copy

  @since 0.6.0
*/
.macro @c128lib_ReadFromVdcMemoryByCoordinates(xPos, yPos, destination, qty) { ReadFromVdcMemoryByCoordinates(xPos, yPos, destination, qty) }
/**
  Read from Vdc internal memory and write it to Vic screen memory by
  using source address.

  @param[in] source Vdc memory absolute address
  @param[in] destination Vic screen memory absolute address
  @param[in] qty Number of byte to copy

  @since 0.6.0
*/
.macro @c128lib_ReadFromVdcMemoryByAddress(source, destination, qty) { ReadFromVdcMemoryByAddress(source, destination, qty) }
/**
  Read from Vic screen memory and write it to Vdc internal memory by
  using coordinates.

  @param[in] xPos X coord on Vic screen
  @param[in] yPos Y coord on Vic screen
  @param[in] destination Vdc internal memory absolute address
  @param[in] qty Number of byte to copy

  @since 0.6.0
*/
.macro @c128lib_WriteToVdcMemoryByCoordinates(source, xPos, yPos, qty) { WriteToVdcMemoryByCoordinates(source, xPos, yPos, qty) }
/**
  Read from Vic screen memory and write it to Vdc internal memory by
  using coordinates.

  @param[in] source Vdc memory absolute address
  @param[in] destination Vic screen memory absolute address
  @param[in] qty Number of byte to copy

  @since 0.6.0
*/
.macro @c128lib_WriteToVdcMemoryByAddress(source, destination, qty) { WriteToVdcMemoryByAddress(source, destination, qty) }

/**
  Write a value into Vdc register. It uses kernal
  routine instead of pure instruction.
  It costs 7 bytes and 12 cycles.

  @param[in] register Register to write on
  @param[in] value Value to write

  @since 0.6.0
*/
.macro @c128lib_WriteVdcWithKernal(register, value) { WriteVdcWithKernal(register, value) }
/**
  Read a value from Vdc register. It uses kernal
  routine instead of pure instruction.
  It costs 7 bytes and 8 cycles.

  @param[in] register Register to read

  @since 0.6.0
*/
.macro @c128lib_ReadVdcWithKernal(register) { ReadVdcWithKernal(register) }

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
