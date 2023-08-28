/**
 * @file vic2.asm
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

.filenamespace c128lib

.namespace Vic2 {

/** Vic2 first register https://c128lib.github.io/Reference/D000 */
.label VIC2                 = $D000
/** Sprite 0 x-coordinate https://c128lib.github.io/Reference/D000#D000 */
.label SPRITE_0_X           = VIC2 + $00
/** Sprite 0 y-coordinate https://c128lib.github.io/Reference/D000#D001 */
.label SPRITE_0_Y           = VIC2 + $01
/** Sprite 1 x-coordinate https://c128lib.github.io/Reference/D000#D002 */
.label SPRITE_1_X           = VIC2 + $02
/** Sprite 1 y-coordinate https://c128lib.github.io/Reference/D000#D003 */
.label SPRITE_1_Y           = VIC2 + $03
/** Sprite 2 x-coordinate https://c128lib.github.io/Reference/D000#D004 */
.label SPRITE_2_X           = VIC2 + $04
/** Sprite 2 y-coordinate https://c128lib.github.io/Reference/D000#D005 */
.label SPRITE_2_Y           = VIC2 + $05
/** Sprite 3 x-coordinate https://c128lib.github.io/Reference/D000#D006 */
.label SPRITE_3_X           = VIC2 + $06
/** Sprite 3 y-coordinate https://c128lib.github.io/Reference/D000#D007 */
.label SPRITE_3_Y           = VIC2 + $07
/** Sprite 4 x-coordinate https://c128lib.github.io/Reference/D000#D008 */
.label SPRITE_4_X           = VIC2 + $08
/** Sprite 4 y-coordinate https://c128lib.github.io/Reference/D000#D009 */
.label SPRITE_4_Y           = VIC2 + $09
/** Sprite 5 x-coordinate https://c128lib.github.io/Reference/D000#D00A */
.label SPRITE_5_X           = VIC2 + $0A
/** Sprite 5 y-coordinate https://c128lib.github.io/Reference/D000#D00B */
.label SPRITE_5_Y           = VIC2 + $0B
/** Sprite 6 x-coordinate https://c128lib.github.io/Reference/D000#D00C */
.label SPRITE_6_X           = VIC2 + $0C
/** Sprite 6 y-coordinate https://c128lib.github.io/Reference/D000#D00D */
.label SPRITE_6_Y           = VIC2 + $0D
/** Sprite 7 x-coordinate https://c128lib.github.io/Reference/D000#D00E */
.label SPRITE_7_X           = VIC2 + $0E
/** Sprite 7 y-coordinate https://c128lib.github.io/Reference/D000#D00F */
.label SPRITE_7_Y           = VIC2 + $0F
/** Sprite msb for setting x pos over 255 px https://c128lib.github.io/Reference/D000#D010 */
.label SPRITE_MSB_X         = VIC2 + $10
/** Vertical smooth scrolling and control register https://c128lib.github.io/Reference/D000#D011 */
.label CONTROL_1            = VIC2 + $11
/** Raster compare register https://c128lib.github.io/Reference/D000#D012 */
.label RASTER               = VIC2 + $12
/** Light pen horizontal position https://c128lib.github.io/Reference/D000#D013 */
.label LIGHTPEN_X           = VIC2 + $13
/** Light pen vertical position https://c128lib.github.io/Reference/D000#D014 */
.label LIGHTPEN_Y           = VIC2 + $14
/** Sprite enable register https://c128lib.github.io/Reference/D000#D015 */
.label SPRITE_ENABLE        = VIC2 + $15
/** Horizontal smooth scrolling and control register https://c128lib.github.io/Reference/D000#D016 */
.label CONTROL_2            = VIC2 + $16
/** Sprite vertical expansion register https://c128lib.github.io/Reference/D000#D017 */
.label SPRITE_EXPAND_Y      = VIC2 + $17
/** Screen and character base address register https://c128lib.github.io/Reference/D000#D018 */
.label MEMORY_CONTROL       = VIC2 + $18
/** Interrupt register https://c128lib.github.io/Reference/D000#D019 */
.label IRR                  = VIC2 + $19
/** Interrupt enable register https://c128lib.github.io/Reference/D000#D01A */
.label IMR                  = VIC2 + $1A
/** Sprite-to-foreground priority register https://c128lib.github.io/Reference/D000#D01B */
.label SPRITE_PRIORITY      = VIC2 + $1B
/** Sprite multicolor mode register https://c128lib.github.io/Reference/D000#D01C */
.label SPRITE_COL_MODE      = VIC2 + $1C
/** Sprite horizontal expansion register https://c128lib.github.io/Reference/D000#D01D */
.label SPRITE_EXPAND_X      = VIC2 + $1D
/** Sprite-to-sprite collision register https://c128lib.github.io/Reference/D000#D01E */
.label SPRITE_2S_COLLISION  = VIC2 + $1E
/** Sprite-foreground collision register https://c128lib.github.io/Reference/D000#D01F */
.label SPRITE_2B_COLLISION  = VIC2 + $1F
/** Border color register https://c128lib.github.io/Reference/D000#D020 */
.label BORDER_COL           = VIC2 + $20
/** Background color register 0 https://c128lib.github.io/Reference/D000#D021 */
.label BG_COL_0             = VIC2 + $21
/** Background color register 1 https://c128lib.github.io/Reference/D000#D022 */
.label BG_COL_1             = VIC2 + $22
/** Background color register 2 https://c128lib.github.io/Reference/D000#D023 */
.label BG_COL_2             = VIC2 + $23
/** Background color register 3 https://c128lib.github.io/Reference/D000#D024 */
.label BG_COL_3             = VIC2 + $24
/** Sprite multicolor color 0 register https://c128lib.github.io/Reference/D000#D025 */
.label SPRITE_COL_0         = VIC2 + $25
/** Sprite multicolor color 1 register https://c128lib.github.io/Reference/D000#D026 */
.label SPRITE_COL_1         = VIC2 + $26
/** Sprite 0 color https://c128lib.github.io/Reference/D000#D027 */
.label SPRITE_0_COLOR       = VIC2 + $27
/** Sprite 1 color https://c128lib.github.io/Reference/D000#D028 */
.label SPRITE_1_COLOR       = VIC2 + $28
/** Sprite 2 color https://c128lib.github.io/Reference/D000#D029 */
.label SPRITE_2_COLOR       = VIC2 + $29
/** Sprite 3 color https://c128lib.github.io/Reference/D000#D02A */
.label SPRITE_3_COLOR       = VIC2 + $2A
/** Sprite 4 color https://c128lib.github.io/Reference/D000#D02B */
.label SPRITE_4_COLOR       = VIC2 + $2B
/** Sprite 5 color https://c128lib.github.io/Reference/D000#D02C */
.label SPRITE_5_COLOR       = VIC2 + $2C
/** Sprite 6 color https://c128lib.github.io/Reference/D000#D02D */
.label SPRITE_6_COLOR       = VIC2 + $2D
/** Sprite 7 color https://c128lib.github.io/Reference/D000#D02E */
.label SPRITE_7_COLOR       = VIC2 + $2E
/** Extended keyboard scan-line control register https://c128lib.github.io/Reference/D000#D02F */
.label XSCAN                = VIC2 + $2F
/** Processor clock rate control register https://c128lib.github.io/Reference/D000#D030 */
.label CLKRATE              = VIC2 + $30

/** Sprite 0 movement control data */
.label SPRITE_MOTION_0      = $117E
/** Sprite 1 movement control data */
.label SPRITE_MOTION_1      = $1189
/** Sprite 2 movement control data */
.label SPRITE_MOTION_2      = $1194
/** Sprite 3 movement control data */
.label SPRITE_MOTION_3      = $119F
/** Sprite 4 movement control data */
.label SPRITE_MOTION_4      = $11AA
/** Sprite 5 movement control data */
.label SPRITE_MOTION_5      = $11B5
/** Sprite 6 movement control data */
.label SPRITE_MOTION_6      = $11C0
/** Sprite 7 movement control data */
.label SPRITE_MOTION_7      = $11CB
/** Offset between sprite control data pointers */
.label SPRITE_MOTION_OFFSET = $0B

.label SPRITE_MAIN_DIR_UP   = $00
.label SPRITE_MAIN_DIR_RIGHT = $01
.label SPRITE_MAIN_DIR_DOWN = $02
.label SPRITE_MAIN_DIR_LEFT = $03

/*
  Mask for sprite, used SPRITE_ENABLE, SPRITE_COL_MODE etc...
*/
.label SPRITE_MASK_0 = %00000001
.label SPRITE_MASK_1 = %00000010
.label SPRITE_MASK_2 = %00000100
.label SPRITE_MASK_3 = %00001000
.label SPRITE_MASK_4 = %00010000
.label SPRITE_MASK_5 = %00100000
.label SPRITE_MASK_6 = %01000000
.label SPRITE_MASK_7 = %10000000

/** Vic2 first shadow register  https://c128lib.github.io/Reference/11D6 */
.label SHADOW_VIC2          = $11D6
/** Sprite 0 shadow register x-coordinate https://c128lib.github.io/Reference/11D6#11D6 */
.label SHADOW_SPRITE_0_X    = SHADOW_VIC2 + $00
/** Sprite 0 shadow register y-coordinate https://c128lib.github.io/Reference/11D6#11D7 */
.label SHADOW_SPRITE_0_Y    = SHADOW_VIC2 + $01
/** Sprite 1 shadow register x-coordinate https://c128lib.github.io/Reference/11D6#11D8 */
.label SHADOW_SPRITE_1_X    = SHADOW_VIC2 + $02
/** Sprite 1 shadow register y-coordinate https://c128lib.github.io/Reference/11D6#11D9 */
.label SHADOW_SPRITE_1_Y    = SHADOW_VIC2 + $03
/** Sprite 2 shadow register x-coordinate https://c128lib.github.io/Reference/11D6#11DA */
.label SHADOW_SPRITE_2_X    = SHADOW_VIC2 + $04
/** Sprite 2 shadow register y-coordinate https://c128lib.github.io/Reference/11D6#11DB */
.label SHADOW_SPRITE_2_Y    = SHADOW_VIC2 + $05
/** Sprite 3 shadow register x-coordinate https://c128lib.github.io/Reference/11D6#11DC */
.label SHADOW_SPRITE_3_X    = SHADOW_VIC2 + $06
/** Sprite 3 shadow register y-coordinate https://c128lib.github.io/Reference/11D6#11DD */
.label SHADOW_SPRITE_3_Y    = SHADOW_VIC2 + $07
/** Sprite 4 shadow register x-coordinate https://c128lib.github.io/Reference/11D6#11DE */
.label SHADOW_SPRITE_4_X    = SHADOW_VIC2 + $08
/** Sprite 4 shadow register y-coordinate https://c128lib.github.io/Reference/11D6#11DF */
.label SHADOW_SPRITE_4_Y    = SHADOW_VIC2 + $09
/** Sprite 5 shadow register x-coordinate https://c128lib.github.io/Reference/11D6#11E0 */
.label SHADOW_SPRITE_5_X    = SHADOW_VIC2 + $0A
/** Sprite 5 shadow register y-coordinate https://c128lib.github.io/Reference/11D6#11E1 */
.label SHADOW_SPRITE_5_Y    = SHADOW_VIC2 + $0B
/** Sprite 6 shadow register x-coordinate https://c128lib.github.io/Reference/11D6#11E2 */
.label SHADOW_SPRITE_6_X    = SHADOW_VIC2 + $0C
/** Sprite 6 shadow register y-coordinate https://c128lib.github.io/Reference/11D6#11E3 */
.label SHADOW_SPRITE_6_Y    = SHADOW_VIC2 + $0D
/** Sprite 7 shadow register x-coordinate https://c128lib.github.io/Reference/11D6#11E4 */
.label SHADOW_SPRITE_7_X    = SHADOW_VIC2 + $0E
/** Sprite 7 shadow register y-coordinate https://c128lib.github.io/Reference/11D6#11E5 */
.label SHADOW_SPRITE_7_Y    = SHADOW_VIC2 + $0F
/** Sprite shadow register msb for setting x pos over 255 px https://c128lib.github.io/Reference/11D6#11E6 */
.label SHADOW_SPRITE_MSB_X  = SHADOW_VIC2 + $10
/** Sprite-to-sprite collision shadow register https://c128lib.github.io/Reference/11D6#11E7 */
.label SHADOW_SPRITE_2S_COLLISION = SHADOW_VIC2 + $11
/** Sprite-to-background collision shadow register https://c128lib.github.io/Reference/11D6#11E8 */
.label SHADOW_SPRITE_2B_COLLISION = SHADOW_VIC2 + $12
/** Light pen horizontal position shadow register https://c128lib.github.io/Reference/11D6#11E9 */
.label SHADOW_LIGHTPEN_X    = SHADOW_VIC2 + $13
/** Light pen vertical position shadow register https://c128lib.github.io/Reference/11D6#11EA */
.label SHADOW_LIGHTPEN_Y    = SHADOW_VIC2 + $14

.label COLOR_RAM            = $D800
.label TOP_SCREEN_RASTER_POS = 50

.label RASTER_MAX_PAL       = 312
.label RASTER_MAX_NTSC      = 263

/** Extra bit for raster register */
.label CONTROL_1_RASTER8  = %10000000
/** Extended background color mode */
.label CONTROL_1_ECM      = %01000000
/** Char mode or bitmapped mode */
.label CONTROL_1_BMM      = %00100000
/** Enable or disable Vic screen */
.label CONTROL_1_DEN      = %00010000
/** Vertical screen row count */
.label CONTROL_1_RSEL     = %00001000

/** Reset bit */
.label CONTROL_2_RES      = %00100000
/** Multicolor mode */
.label CONTROL_2_MCM      = %00010000
/** Horizontal screen column count */
.label CONTROL_2_CSEL     = %00001000

/** Irq status */
.label IRR_IRQ            = %10000000
/** Light pen signal */
.label IRR_LIGHTPEN       = %00001000
/** Sprite to sprite collision */
.label IRR_SPR_SPR        = %00000100
/** Sprite to background collision */
.label IRR_SPR_BG         = %00000010
/** Irq on raster line */
.label IRR_RASTER         = %00000001

/** Light pen interrupt */
.label IMR_LIGHTPEN       = %00001000
/** Sprite to sprite collision interrupt */
.label IMR_SPR_SPR        = %00000100
/** Sprite to background collision interrupt */
.label IMR_SPR_BG         = %00000010
/** Raster interrupt */
.label IMR_RASTER         = %00000001

// Graphic modes
.label STANDARD_TEXT_MODE     = %000
.label MULTICOLOR_TEXT_MODE   = %001
.label STANDARD_BITMAP_MODE   = %010
.label MULTICOLOR_BITMAP_MODE = %011
.label EXTENDED_TEXT_MODE     = %100

.label MODE_ECM               = %100
.label MODE_BMM               = %010
.label MODE_MCM               = %001

// Misc. constants
.label TEXT_SCREEN_WIDTH = 40

.label BASIC_IRQ_FLAG         = $12FD     // IRQ_WRAP_FLAG

.label SCREEN_EDITOR_IRQ_FLAG = $D8

// TIP(intoinside): c128ProgrammersReferenceGuide has a wrong example on page 231
// (manual page 223). $0A2C and $0A2D is wrongly written as $02AC and $02AC
/** VIC text screen and character base */
.label VIC_SCREEN_CHAR_SHADOW   = $0A2C
/** VIC bitmap and video matrix base */
.label VIC_BITMAP_VIDEO_SHADOW  = $0A2D

/** Char memory on $0000 */
.label CHAR_MEM_0000        = %00000000
/** Char memory on $0800 */
.label CHAR_MEM_0800        = %00000010
/** Char memory on $1000 */
.label CHAR_MEM_1000        = %00000100
/** Char memory on $1800 */
.label CHAR_MEM_1800        = %00000110
/** Char memory on $2000 */
.label CHAR_MEM_2000        = %00001000
/** Char memory on $2800 */
.label CHAR_MEM_2800        = %00001010
/** Char memory on $3000 */
.label CHAR_MEM_3000        = %00001100
/** Char memory on $0800 */
.label CHAR_MEM_3800        = %00001110

/** Screen memory on $0000 */
.label SCREEN_MEM_0000      = %00000000
/** Screen memory on $0400 */
.label SCREEN_MEM_0400      = %00010000
/** Screen memory on $0800 */
.label SCREEN_MEM_0800      = %00100000
/** Screen memory on $0c00 */
.label SCREEN_MEM_0C00      = %00110000
/** Screen memory on $1000 */
.label SCREEN_MEM_1000      = %01000000
/** Screen memory on $1400 */
.label SCREEN_MEM_1400      = %01010000
/** Screen memory on $1800 */
.label SCREEN_MEM_1800      = %01100000
/** Screen memory on $1c00 */
.label SCREEN_MEM_1C00      = %01110000
/** Screen memory on $2000 */
.label SCREEN_MEM_2000      = %10000000
/** Screen memory on $2400 */
.label SCREEN_MEM_2400      = %10010000
/** Screen memory on $2800 */
.label SCREEN_MEM_2800      = %10100000
/** Screen memory on $2c00 */
.label SCREEN_MEM_2C00      = %10110000
/** Screen memory on $3000 */
.label SCREEN_MEM_3000      = %11000000
/** Screen memory on $3400 */
.label SCREEN_MEM_3400      = %11010000
/** Screen memory on $3800 */
.label SCREEN_MEM_3800      = %11100000
/** Screen memory on $3c00 */
.label SCREEN_MEM_3C00      = %11110000

/** Bitmap memory on $0000 */
.label BITMAP_MEM_0000      = %00000000
/** Bitmap memory on $2000 */
.label BITMAP_MEM_2000      = %00001000

}

/**
  Set border and background color with optimization if possible.

  @param[in] borderColor Border color to be set
  @param[in] backgroundColor Background color to be set

  @remark Register .A will be modified.

  @note Use c128lib_SetBorderAndBackgroundColor in vic2-global.asm

  @since 0.6.0
*/
.macro SetBorderAndBackgroundColor(borderColor, backgroundColor) {
  lda #borderColor
  sta Vic2.BORDER_COL
  .if (borderColor != backgroundColor) {
    lda #backgroundColor
  }
  sta Vic2.BG_COL_0
}
.assert "SetBorderAndBackgroundColor(borderColor, backgroundColor) different color",  { SetBorderAndBackgroundColor(1, 2) }, {
  lda #1; sta $D020; lda #2; sta $D021
}
.assert "SetBorderAndBackgroundColor(borderColor, backgroundColor) same color",  { SetBorderAndBackgroundColor(3, 3) }, {
  lda #3; sta $D020; sta $D021
}

/**
  Set border color

  @param[in] borderColor Border color to be set

  @remark Register .A will be modified.

  @note Use c128lib_SetBorderColor in vic2-global.asm

  @since 0.6.0
*/
.macro SetBorderColor(borderColor) {
  lda #borderColor
  sta Vic2.BORDER_COL
}
.assert "SetBorderColor(borderColor)",  { SetBorderColor(1) }, {
  lda #1; sta $D020
}

/**
  Set background color

  @param[in] backgroundColor Background color to be set

  @remark Register .A will be modified.

  @note Use c128lib_SetBackgroundColor in vic2-global.asm

  @since 0.6.0
*/
.macro SetBackgroundColor(backgroundColor) {
  lda #backgroundColor
  sta Vic2.BG_COL_0
}
.assert "SetBackgroundColor(backgroundColor)",  { SetBackgroundColor(1) }, {
  lda #1; sta $D021
}

/*
  Calculates memory offset of text cell specified by given coordinates.

  Params:
    xPos - X coord
    yPos - Y coord
*/
.function getTextOffset(xPos, yPos) {
  .return xPos + Vic2.TEXT_SCREEN_WIDTH * yPos
}
.assert "getTextOffset(0,0) gives 0", getTextOffset(0, 0), 0
.assert "getTextOffset(39,0) gives 39", getTextOffset(39, 0), 39
.assert "getTextOffset(0,1) gives 40", getTextOffset(0, 1), 40
.assert "getTextOffset(19,12) gives 499", getTextOffset(19, 12), 499
.assert "getTextOffset(39,24) gives 999", getTextOffset(39, 24), 999

/*
  Combines screen and charset slots for memory control register.

  Params:
    screenMem - location of screen memory: 0..15
    charSet - location of charset definition: 0..7
*/
.function getTextMemory(screenMem, charSet) {
  .return charSet<<1 | screenMem<<4
}
.assert "getTextMemory(0, 0) returns $00",  getTextMemory(0, 0), %00000000
.assert "getTextMemory(15,7) returns $FE", getTextMemory(15, 7), %11111110
.assert "getTextMemory(4,2) returns %01000100", getTextMemory(4, 2), %01000100

/**
  Set Basic IRQ routine active or not.

  @param[in] active Activate or deactivate basic irq

  @remark Register .A will be modified.

  @note Use c128lib_SetBasicIrqActivity in vic2-global.asm

  @note Turning off the BASIC
  IRQ routine will give you direct access to the hardware registers,
  you should keep in mind that it will also effectively disable the
  BASIC statements MOVSPR, COLLISION, SOUND and PLAY

  @since 0.6.0
*/
.macro SetBasicIrqActivity(active) {
  .if (active == 0) {
    lda #1
  } else {
    lda #0
  }
    sta Vic2.BASIC_IRQ_FLAG
}
.assert "SetBasicIrqActivity() sets 1 to $12FD",  { SetBasicIrqActivity(0) }, {
  lda #1; sta $12FD
}
.assert "SetBasicIrqActivity() sets 0 to $12FD",  { SetBasicIrqActivity(1) }, {
  lda #0; sta $12FD
}

/**
  Set screen editor IRQ routine active or not. This gives you direct control
  over the VIC chip register settings (D018), but disables BASIC'S ability
  to change display modes.

  @param[in] active Activate or deactivate basic irq

  @remark Register .A will be modified.

  @note Use c128lib_SetScreenEditorIrq in vic2-global.asm

  @since 0.6.0
*/
.macro SetScreenEditorIrq(active) {
  .if (active == 0) {
    lda #$ff
  } else {
    lda #0
  }
    sta Vic2.SCREEN_EDITOR_IRQ_FLAG
}
.assert "SetScreenEditorIrq() sets $ff to $D8",  { SetScreenEditorIrq(0) }, {
  lda #$ff; sta $D8
}
.assert "SetScreenEditorIrq() sets 0 to $D8",  { SetScreenEditorIrq(1) }, {
  lda #0; sta $D8
}

/**
  Set screen memory and charset memory position by
  using shadow register.

  @param[in] config Screen memory and/or char memory configuration.

  @remark Register .A will be modified. Labels Vic2.CHAR* and
  Vic2.SCREEN_MEM* can ben used to compose.

  @note Use c128lib_SetScreenAndCharacterMemory in vic2-global.asm

  @since 0.6.0
*/
.macro SetScreenAndCharacterMemory(config) {
    lda #config
    sta Vic2.VIC_SCREEN_CHAR_SHADOW
}
.assert "SetScreenAndCharacterMemory(Vic2.CHAR_MEM_3800 | Vic2.SCREEN_MEM_3C00) sets char to $3800 and Screen to $3c00 in shaow MEMORY_CONTROL",  { SetScreenAndCharacterMemory(Vic2.CHAR_MEM_3800 | Vic2.SCREEN_MEM_3C00) }, {
  lda #%11111110; sta $0A2C
}

/**
  Set screen memory and bitmap memory pointer by
  using shadow register.

  @param[in] config Screen memory and/or bitmap memory configuration.

  @remark Register .A will be modified. Labels Vic2.CHAR* and
  Vic2.SCREEN_MEM* can ben used to compose.

  @note Use c128lib_SetScreenMemoryAndBitmapPointer in vic2-global.asm

  @since 0.6.0
*/
.macro SetScreenMemoryAndBitmapPointer(config) {
    lda #config
    sta Vic2.VIC_BITMAP_VIDEO_SHADOW
}
.assert "SetScreenMemoryAndBitmapPointer(Vic2.BITMAP_MEM_2000 | Vic2.SCREEN_MEM_3C00) sets bitmap to $2000 and Screen to $3c00 in shadow MEMORY_CONTROL",  { SetScreenMemoryAndBitmapPointer(Vic2.BITMAP_MEM_2000 | Vic2.SCREEN_MEM_3C00) }, {
  lda #%11111000; sta $0A2D
}

/**
  Configures memory for text mode

  @param[in] video Location of video ram: 0..15
  @param[in] charSet Location of charset definition: 0..7

  @remark Register .A will be modified

  @since 0.6.0
*/
.macro configureTextMemory(video, charSet) {
  lda #getTextMemory(video, charSet)
  sta Vic2.MEMORY_CONTROL
}
.assert "configureTextMemory(0, 0) sets $00 to MEMORY_CONTROL reg",  { configureTextMemory(0, 0) }, {
  lda #%00000000
  sta $D018
}
.assert "configureTextMemory(15,7) sets $FE to MEMORY_CONTROL reg", { configureTextMemory(15, 7) }, {
  lda #%11111110
  sta $D018
}
.assert "configureTextMemory(4,2) sets %01000100 to MEMORY_CONTROL reg", { configureTextMemory(4, 2) }, {
  lda #%01000100
  sta $D018
}

/*
  Combines video and bitmap slots into value of memory control register.

  Params:
    video - location of video ram: 0..15
    bitmap - location of bitmap definition: 0..1
*/
.function getBitmapMemory(video, bitmap) {
  .return bitmap<<3 | video<<4
}
.assert "getBitmapMemory(0, 0) returns $00", getBitmapMemory(0, 0), %00000000
.assert "getBitmapMemory(15, 1) returns %11111000", getBitmapMemory(15, 1), %11111000
.assert "getBitmapMemory(4, 1) returns %01001000", getBitmapMemory(4, 1), %01001000

/*
  Configure memory for bitmap mode

  Params:
    video - location of video ram: 0..15
    bitmap - location of bitmap definition: 0..1

  Mod: .A
*/
.macro configureBitmapMemory(video, bitmap) {
  lda #getBitmapMemory(video, bitmap)
  sta Vic2.MEMORY_CONTROL
}
.assert "configureBitmapMemory(0, 0) sets $00 to MEMORY_CONTROL reg", { configureBitmapMemory(0, 0) }, {
  lda #%00000000
  sta $D018
}
.assert "configureBitmapMemory(15, 1) sets %11111000 to MEMORY_CONTROL reg", { configureBitmapMemory(15, 1) }, {
  lda #%11111000
  sta $D018
}
.assert "configureBitmapMemory(4, 1) sets %01001000 to MEMORY_CONTROL reg", { configureBitmapMemory(4, 1) }, {
  lda #%01001000
  sta $D018
}

/*
  Calculates set bits for control 1 reg and specified gfx mode

  Params:
  mode mode designator according to predefined labels
*/
// .function calculateControl1ForMode(mode) {
//   .var result = $00
//   .if ((mode & MODE_ECM) == MODE_ECM) .eval result = result | CONTROL_1_ECM
//   .if ((mode & MODE_BMM) == MODE_BMM) .eval result = result | CONTROL_1_BMM
//   .return result
// }
// .assert "calculateControl1ForMode(STANDARD_TEXT_MODE) returns 0" , calculateControl1ForMode(STANDARD_TEXT_MODE), $00
// .assert "calculateControl1ForMode(MULTICOLOR_TEXT_MODE) returns 0", calculateControl1ForMode(MULTICOLOR_TEXT_MODE), $00
// .assert "calculateControl1ForMode(STANDARD_BITMAP_MODE) returns %00100000", calculateControl1ForMode(STANDARD_BITMAP_MODE), %00100000
// .assert "calculateControl1ForMode(MULTICOLOR_BITMAP_MODE) returns %00100000", calculateControl1ForMode(MULTICOLOR_BITMAP_MODE), %00100000
// .assert "calculateControl1ForMode(EXTENDED_TEXT_MODE) returns %01000000", calculateControl1ForMode(EXTENDED_TEXT_MODE), %01000000

/*
  Calculates set bits for control 2 reg and specified gfx mode

  Params:
  mode mode designator according to predefined labels
*/
// .function calculateControl2ForMode(mode) {
//   .var result = $00
//   .if ((mode & MODE_MCM) == MODE_MCM) .eval result = result | CONTROL_2_MCM
//   .return result
// }
// .assert "calculateControl2ForMode(STANDARD_TEXT_MODE) returns 0", calculateControl2ForMode(STANDARD_TEXT_MODE), $00
// .assert "calculateControl2ForMode(MULTICOLOR_TEXT_MODE) returns %00010000", calculateControl2ForMode(MULTICOLOR_TEXT_MODE), %00010000
// .assert "calculateControl2ForMode(STANDARD_BITMAP_MODE) returns 0", calculateControl2ForMode(STANDARD_BITMAP_MODE), %00000000
// .assert "calculateControl2ForMode(MULTICOLOR_BITMAP_MODE) returns %00010000", calculateControl2ForMode(MULTICOLOR_BITMAP_MODE), %00010000
// .assert "calculateControl2ForMode(EXTENDED_TEXT_MODE) returns 0", calculateControl2ForMode(EXTENDED_TEXT_MODE), %00000000

/*
  Sets given video mode according to predefined labels. Works in each and every case
  but might be not so optimal if modification of both CONTROL_1 and CONTROL_2 regs is
  not required. Use when precise timing is not critical.

  Params:
    mode - VIC-II video mode designator according to predefined labels
*/
// .macro setVideoMode(mode) {                // 24
//   lda CONTROL_2                             // 4
//   and #neg(CONTROL_2_MCM)                   // 2
//   ora #calculateControl2ForMode(mode)       // 2
//   sta CONTROL_2                             // 4

//   lda CONTROL_1                             // 4
//   and #neg(CONTROL_1_ECM | CONTROL_1_BMM)   // 2
//   ora #calculateControl1ForMode(mode)       // 2
//   sta CONTROL_1                             // 4
// }
// .assert "setVideoMode(STANDARD_TEXT_MODE) sets 0/0/0", { :setVideoMode(STANDARD_TEXT_MODE) }, {
//   lda CONTROL_2;and #%11101111;ora #$00;sta CONTROL_2
//   lda CONTROL_1;and #%10011111;ora #$00;sta CONTROL_1
// }
// .assert "setVideoMode(MULTICOLOR_TEXT_MODE) sets 0/0/1", { :setVideoMode(MULTICOLOR_TEXT_MODE) }, {
//   lda CONTROL_2;and #%11101111;ora #%00010000;sta CONTROL_2
//   lda CONTROL_1;and #%10011111;ora #$00;sta CONTROL_1
// }
// .assert "setVideoMode(STANDARD_BITMAP_MODE) sets 0/1/0", { :setVideoMode(STANDARD_BITMAP_MODE) }, {
//   lda CONTROL_2;and #%11101111;ora #$00;sta CONTROL_2
//   lda CONTROL_1;and #%10011111;ora #%00100000;sta CONTROL_1
// }
// .assert "setVideoMode(MULTICOLOR_BITMAP_MODE) sets 0/1/1", { :setVideoMode(MULTICOLOR_BITMAP_MODE) }, {
//   lda CONTROL_2;and #%11101111;ora #%00010000;sta CONTROL_2
//   lda CONTROL_1;and #%10011111;ora #%00100000;sta CONTROL_1
// }
// .assert "setVideoMode(EXTENDED_TEXT_MODE) sets 1/0/0", { :setVideoMode(EXTENDED_TEXT_MODE) }, {
//   lda CONTROL_2;and #%11101111;ora #$00;sta CONTROL_2
//   lda CONTROL_1;and #%10011111;ora #%01000000;sta CONTROL_1
// }

/**
  Configures VIC-II so that it fire IRQ when given "rasterLine" is drawn.

  @param[in] rasterLine Line where irq should trigger

  @remark Register .A will be modified.

  @note Use c128lib_setRaster in vic2-global.asm

  @since 0.6.0
*/
.macro setRaster(rasterLine) {
  lda #<rasterLine
  sta Vic2.RASTER
  lda Vic2.CONTROL_1
  .if (rasterLine > 255) {
    ora #Vic2.CONTROL_1_RASTER8
  } else {
    and #neg(Vic2.CONTROL_1_RASTER8)
  }
  sta Vic2.CONTROL_1
}
.assert "setRaster(0)", { setRaster(0) }, {
  lda #0; sta $d012; lda $d011; and #%01111111; sta $d011
}
.assert "setRaster($FF)", { setRaster($FF) }, {
  lda #$FF; sta $d012; lda $d011; and #%01111111; sta $d011
}
.assert "setRaster($100)", { setRaster($100) }, {
  lda #00; sta $d012; lda $d011; ora #%10000000; sta $d011
}
.assert "setRaster($1F7)", { setRaster($1F7) }, {
  lda #$F7; sta $d012; lda $d011; ora #%10000000; sta $d011
}
.assert "setRaster($1FF)", { setRaster($1FF) }, {
  lda #$FF; sta $d012; lda $d011; ora #%10000000; sta $d011
}

/*
  Call it when entering raster interrupt.

  Mod: .A
*/
.macro irqEnter() {
  pha
  tya
  pha
  txa
  pha
}

/*
  Call it at the end of raster interrupt.

  intVector - address of next interrupt handling routine
  rasterLine - at which raster line should we fire next interrupt
  memory - if true, rasterLine is taken from memory address, if false - absolute addressing is used

  Mod: .A .X .Y
*/
.macro irqExit(intVector, rasterLine, memory) {
  ldx #>intVector
  ldy #<intVector
  stx $FFFF
  sty $FFFE
  .if (memory) {
    lda rasterLine
    sta Vic2.RASTER
    lda Vic2.CONTROL_1
    ror rasterLine+1
    bcc doAnd
    ora #Vic2.CONTROL_1_RASTER8
    jmp next
  doAnd:
    and #neg(Vic2.CONTROL_1_RASTER8)
  next:
    sta Vic2.CONTROL_1
  } else {
    :setRaster(rasterLine)
  }
  sec
  dec Vic2.IRR
  pla
  tax
  pla
  tay
  pla
  rti
}

.macro debugBorder(color) {
  #if VISUAL_DEBUG
  lda #color
  sta BORDER_COL
  #endif
}

.macro debugBorderStart() {
  #if VISUAL_DEBUG
  inc BORDER_COL
  #endif
}

.macro debugBorderEnd() {
  #if VISUAL_DEBUG
  dec BORDER_COL
  #endif
}

/*
  NTSC detection routine written by J0X (https://csdb.dk/scener/?id=1221).
  It is so short and will be called only once so that I will code it as simple
  macro and not subroutine.

  This macro takes callback addresses for PAL and NTSC events as parameters. Callback
  will be ignored (not jumped into) if its value is 0 or less.

  Params:
    onPalCallback   subroutine address, it will be called (JSR) when PAL is detected
    onNtscCallback  subroutine address, it will be called (JSR) when NTSC is detected
*/
// .macro detectNtsc(onPalCallback, onNtscCallback) {
//   nextLine:
//     lda RASTER
//     busyWait:
//       cmp RASTER
//     beq busyWait
//   bmi nextLine
//   cmp #$20
//   bcc ntsc
//     .if (onPalCallback > 0) {
//       jsr onPalCallback
//     }
//   jmp end
//   ntsc:
//     .if (onNtscCallback > 0) {
//       jsr onNtscCallback
//     }
//   end:
// }

/*
  Rotates pointed character to the right.
  This is a hosted subroutine.
  This subroutine should be first installed by calling this macro with appropriate parameter (see below).

  Parameters:
    charPointer - should point to zero-page location (2 bytes). Location should contain address of the character to be rotated.

  Mod: .A .Y
*/
.macro rotateCharRight(charPointer) {
  ldy #0
  !:
    lda (charPointer),y
    clc
    lsr
    bcc next
      ora #%10000000
    next:
    sta (charPointer),y
    iny
    cpy #8
  bne !-
}

/*
  Rotates pointed character to the bottom.
  This is a hosted subroutine.
  This subroutine should be first installed by calling this macro with appropriate parameter (see below).

  Parameters:
    charPointer - should point to zero-page location (2 bytes). Location should contain address of the character to be rotated.
    store - should point to zero or non-zero location (1 byte). This location is used internaly, it's content will be destroyed after calling the subroutine.

  Mod: .A .Y
*/
.macro rotateCharBottom(charPointer, store) {
  ldy #7
  lda (charPointer),y
  sta store
  !:
    dey
    lda (charPointer),y
    iny
    sta (charPointer),y
    dey
  bne !-
  lda store
  sta (charPointer),y
}

#import "common/lib/common.asm"
