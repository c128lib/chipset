/**
 * @file vic2-global.asm
 * @brief Vic2 module
 * @details Macros for Vic2 support
 *
 * @copyright Copyright (c) 2023 c128lib - https://github.com/c128lib
 *
 * MIT License
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * @date 2022
 */

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

  Character memory selection

  - c128lib.Vic2.CHAR_MEM_0000 Character memory on $0000
  - c128lib.Vic2.CHAR_MEM_0800 Character memory on $0800
  - c128lib.Vic2.CHAR_MEM_1000 Character memory on $1000
  - c128lib.Vic2.CHAR_MEM_1800 Character memory on $1800
  - c128lib.Vic2.CHAR_MEM_2000 Character memory on $2000
  - c128lib.Vic2.CHAR_MEM_2800 Character memory on $2800
  - c128lib.Vic2.CHAR_MEM_3000 Character memory on $3000
  - c128lib.Vic2.CHAR_MEM_3800 Character memory on $3800

  If omitted, c128lib.Vic2.CHAR_MEM_0000 will be used.

  Character memory offset must be added to current bank selected.
  For ex. if Vic bank 1 ($4000) is selected, CHAR_MEM_0800 will point to $4000 + $0800

  Screen memory selection

  - c128lib.Vic2.SCREEN_MEM_0000 Screen memory on $0000
  - c128lib.Vic2.SCREEN_MEM_0400 Screen memory on $0400
  - c128lib.Vic2.SCREEN_MEM_0800 Screen memory on $0800
  - c128lib.Vic2.SCREEN_MEM_0C00 Screen memory on $0c00
  - c128lib.Vic2.SCREEN_MEM_1000 Screen memory on $1000
  - c128lib.Vic2.SCREEN_MEM_1400 Screen memory on $1400
  - c128lib.Vic2.SCREEN_MEM_1800 Screen memory on $1800
  - c128lib.Vic2.SCREEN_MEM_1C00 Screen memory on $1c00
  - c128lib.Vic2.SCREEN_MEM_2000 Screen memory on $2000
  - c128lib.Vic2.SCREEN_MEM_2400 Screen memory on $2400
  - c128lib.Vic2.SCREEN_MEM_2800 Screen memory on $2800
  - c128lib.Vic2.SCREEN_MEM_2C00 Screen memory on $2c00
  - c128lib.Vic2.SCREEN_MEM_3000 Screen memory on $3000
  - c128lib.Vic2.SCREEN_MEM_3400 Screen memory on $3400
  - c128lib.Vic2.SCREEN_MEM_3800 Screen memory on $3800
  - c128lib.Vic2.SCREEN_MEM_3C00 Screen memory on $3c00

  If omitted, c128lib.Vic2.SCREEN_MEM_0000 will be used.

  Screen memory offset must be added to current bank selected.
  For ex. if Vic bank 1 ($4000) is selected, SCREEN_MEM_0C00 will point to $4000 + $0c00

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @code
  c128lib_SetScreenAndCharacterMemory(c128lib.Vic2.CHAR_MEM_2800 | c128lib.Vic2.SCREEN_MEM_0400)
  @endcode

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
  Configures Vic2 so that it fire IRQ when given "rasterLine" is drawn.

  @param[in] rasterLine Line where irq should trigger

  @remark Register .A will be modified.

  @since 0.6.0
*/
.macro @c128lib_setRaster(rasterLine) { setRaster(rasterLine) }
.macro @c128lib_irqEnter() { irqEnter() }
.macro @c128lib_irqExit(intVector, rasterLine, memory) { irqExit(intVector, rasterLine, memory) }
.macro @c128lib_rotateCharRight(charPointer) { rotateCharRight(charPointer) }
.macro @c128lib_rotateCharBottom(charPointer, store) { rotateCharBottom(charPointer, store) }
