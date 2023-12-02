/**
  @file vdc.asm
  @brief Vdc module

  @copyright MIT Licensed
  @date 2022
*/

#importonce

.filenamespace c128lib

.namespace Vdc {

/** Black color code */
.label VDC_BLACK = 0
/** Dark gray color code */
.label VDC_DARK_GRAY = 1
/** Dark blue color code */
.label VDC_DARK_BLUE = 2
/** Light blue color code */
.label VDC_LIGHT_BLUE = 3
/** Dark green color code */
.label VDC_DARK_GREEN = 4
/** Light green color code */
.label VDC_LIGHT_GREEN = 5
/** Dark cyan color code */
.label VDC_DARK_CYAN = 6
/** Light cyan color code */
.label VDC_LIGHT_CYAN = 7
/** Dark red color code */
.label VDC_DARK_RED = 8
/** Light red color code */
.label VDC_LIGHT_RED = 9
/** Dark purple color code */
.label VDC_DARK_PURPLE = 10
/** Light purple color code */
.label VDC_LIGHT_PURPLE = 11
/** Dark yellow color code */
.label VDC_DARK_YELLOW = 12
/** Light yellow color code */
.label VDC_LIGHT_YELLOW = 13
/** Light gray color code */
.label VDC_LIGHT_GRAY = 14
/** White color code */
.label VDC_WHITE = 15

.label COLOR80    = $ce5c

.label MODE       = $d7

.label TEXT_SCREEN_80_COL_WIDTH = 80

/** Vdc address/status register */
.label VDCADR     = $d600
/** Vdc data register */
.label VDCDAT     = $d601

/** Total number of horizontal character positions */
.label TOTALE_NUMBER_OF_HORIZONTAL_CHARACTER_POSITIONS    = $00
/** Number of visible horizontal character positions */
.label NUMBER_OF_VISIBILE_HORIZONTAL_CHARACTER_POSITIONS  = $01
/** Horizontal sync position */
.label HORIZONTAL_SYNC_POSITION                           = $02
/** Horizontal and vertical sync width */
.label HORIZONTAL_VERTICAL_SYNC_WIDTH                     = $03
/** Total number of screen rows */
.label NUMBER_SCREEN_ROWS                                 = $04
/** Vertical fine adjustment */
.label VERTICAL_FINE_ADJUSTMENT                           = $05
/** Number of visible screen rows */
.label VISIBLE_SCREEN_ROWS                                = $06
/** Vertical sync position */
.label VERTICAL_SYNC_POSITION                             = $07
/** Interlace mode control register */
.label INTERLACE_MODE_CONTRO_POSITION                     = $08
/** Number of scan lines per character */
.label SCANLINES_PER_CHARACTER                            = $09
/** Cursor mode control */
.label CURSOR_MODE_CONTROL                                = $0A
/** Ending scan line for cursor */
.label ENDING_SCAN_LINE                                   = $0B
/** Screen memory starting address (high byte) */
.label SCREEN_MEMORY_STARTING_HIGH_ADDRESS                = $0C
/** Screen memory starting address (low byte) */
.label SCREEN_MEMORY_STARTING_LOW_ADDRESS                 = $0D
/** Cursor position address (high byte) */
.label CURSOR_POSITION_HIGH_ADDRESS                       = $0E
/** Cursor position address (low byte) */
.label CURSOR_POSITION_LOW_ADDRESS                        = $0F
/** Light pen vertical position */
.label LIGHT_PEN_VERTICAL_POSITION                        = $10
/** Light pen horizontal position */
.label LIGHT_PEN_HORIZONTAL_POSITION                      = $11
/** Current memory address (high byte) */
.label CURRENT_MEMORY_HIGH_ADDRESS                        = $12
/** Current memory address (low byte) */
.label CURRENT_MEMORY_LOW_ADDRESS                         = $13
/** Attribute memory starting address (high byte) */
.label ATTRIBUTE_MEMORY_HIGH_ADDRESS                      = $14
/** Attribute memory starting address (low byte) */
.label ATTRIBUTE_MEMORY_LOW_ADDRESS                       = $15
/** Character horizontal size control register */
.label CHARACTER_HORIZONTAL_SIZE_CONTROL                  = $16
/** Character vertical size control register */
.label CHARACTER_VERTICAL_SIZE_CONTROL                    = $17
/** Vertical smooth scrolling and control register */
.label VERTICAL_SMOOTH_SCROLLING                          = $18
/** Horizontal smooth scrolling and control register */
.label HORIZONTAL_SMOOTH_SCROLLING                        = $19
/** Foreground/background color register */
.label FOREGROUND_BACKGROUND_COLOR                        = $1A
/** Address increment per row */
.label ADDRESS_INCREMENT_PER_ROW                          = $1B
/** Character set address and memory type register */
.label CHARACTER_SET_ADDRESS                              = $1C
/** Underline scan-line-position register */
.label UNDERLINE_SCAN_LINE_POSITION                       = $1D
/** Number of bytes for block write or copy */
.label NUMBER_OF_BYTES_FOR_BLOCK_WRITE_OR_COPY            = $1E
/** Memory read/write register */
.label MEMORY_READ_WRITE                                  = $1F
/** Block copy source address (high byte) */
.label BLOCK_COPY_SOURCE_HIGH_ADDRESS                     = $20
/** Block copy source address (low byte) */
.label BLOCK_COPY_SOURCE_LOW_ADDRESS                      = $21
/** Beginning position for horizontal blanking */
.label BEGINNING_POSITION_FOR_HORIZONTAL_BLANKING         = $22
/** Ending position for horizontal blanking */
.label ENDING_POSITION_FOR_HORIZONTAL_BLANKING            = $23
/** Number of memory refresh cycles per scan line */
.label NUMBER_OF_MEMORY_REFRESH_CYCLER_PER_SCANLINE       = $24

.label ATTRIBUTE_ALTERNATE  = %10000000;
.label ATTRIBUTE_REVERSE    = %01000000;
.label ATTRIBUTE_UNDERLINE  = %00100000;
.label ATTRIBUTE_BLINK      = %00010000;

// #if PRINT80STR
// #define WRITE80BYTE
// /*
//   Print a string on screen on current position.

//   Params:
//     A - low byte string address
//     Y - hi byte string address

//   Preconditions:
//     First byte of string is interpreted as length.
// */
// Print80Str:
//     sta str80
//     sty str80+1
//     ldy #0
//     lda (str80),y
//     sta count80
//     sta $0400
//   !:
//     iny
//     lda (str80),y
//     jsr Write80Byte
//     dec count80
//     bne !-
//     rts
// #endif

#if VDC_FILLSCREEN
#define VDC_MOVESCREENPOINTERTO00
#define VDC_WRITEBYTE
#define VDC_REPEATBYTE
/**
  Fill screen ram with a specific character.

  Params:
    A - character used to fill screen
*/
FillScreen:
    pha
    jsr MoveScreenPointerTo00
    pla
    jsr WriteByte
    lda #249
    jsr RepeatByte
    lda #250
    ldy #7
  !:
    jsr RepeatByte
    dey
    bne !-
    rts
#endif

#if VDC_FILLATTRIBUTE
#define VDC_MOVEATTRIBUTEPOINTERTO00
#define VDC_REPEATBYTE
#define VDC_WRITEBYTE
/**
  Fill attribute ram with a specific value.

  Params:
    A - value used to fill attribute ram
*/
FillAttribute: {
    pha
    jsr MoveAttributePointerTo00
    pla
    jsr WriteByte
    lda #249
    jsr RepeatByte
    lda #250
    ldy #7
  !:
    jsr RepeatByte
    dey
    bne !-
    rts
}
#endif

#if VDC_MOVESCREENPOINTERTO00
/**
  Move screen ram pointer to 0/0 on screen.
*/
MoveScreenPointerTo00: {
    lda vdcram
    ldx #CURRENT_MEMORY_LOW_ADDRESS
    WriteVdc()
    dex
    lda vdcram+1
    WriteVdc()
    rts
}
#endif

#if VDC_MOVEATTRIBUTEPOINTERTO00
/**
  Move ram pointer to 0/0 in attribute memory.
*/
MoveAttributePointerTo00: {
    lda vdcattr
    ldx #CURRENT_MEMORY_LOW_ADDRESS
    WriteVdc()
    dex
    lda vdcattr+1
    WriteVdc()
    rts
}
#endif

#if VDC_PRINTCHARATPOSITION
#define VDC_POSITIONXY
#define VDC_WRITEBYTE
/**
  Print a char at specific coordinates in screen memory.

  Params:
    A - character to print on screen
    X - column where to print
    Y - row where to print
*/
PrintCharAtPosition: {
    pha
    jsr PositionXy
    pla
    jsr WriteByte
    rts
}
#endif

#if VDC_POSITIONXY
/**
  Position the ram pointer at specific coordinates in screen memory.

  Params:
    X - column where to position
    Y - row where to position
*/
PositionXy: {
    lda #0
    sta high
    sty low
    asl low
    asl low           // Y times 4
    tya
    clc
    adc low
    sta low           // Y times 5
    ldy #4
  !:
    asl low
    rol high
    dey
    bne !-              // Y times 80 in low/high
    txa
    clc
    adc low
    sta low
    bcc !+
    inc high          // added X offset across screen
  !:
    lda vdcram
    clc
    adc low
    sta low
    lda vdcram+1
    adc high
    sta high          // added offset for start of screen RAM
    ldx #CURRENT_MEMORY_HIGH_ADDRESS
    lda high
    WriteVdc()
    inx
    lda low
    WriteVdc()
    rts
}
#endif

#if VDC_POSITIONATTRXY
/**
  Position the ram pointer at specific coordinates in attribute memory.

  Params:
    X - column where to position
    Y - row where to position
*/
PositionAttrXy: {
    lda #0
    sta high
    sty low
    asl low
    asl low           // Y times 4
    tya
    clc
    adc low
    sta low           // Y times 5
    ldy #4
  !:
    asl low
    rol high
    dey
    bne !-              // Y times 80 in low/high
    txa
    clc
    adc low
    sta low
    bcc !+
    inc high          // added X offset across screen
  !:
    lda vdcattr
    clc
    adc low
    sta low
    lda vdcattr+1
    adc high
    sta high          // added offset for start of attribute RAM
    ldx #CURRENT_MEMORY_HIGH_ADDRESS
    lda high
    WriteVdc()
    inx
    lda low
    WriteVdc()
    rts
}
#endif

#if VDC_REPEATBYTE
/**
  Pass the number of times in A.
*/
RepeatByte: {
    pha
    ldx #VERTICAL_SMOOTH_SCROLLING
    ReadVdc()
    and #$7f
    WriteVdc()
    pla
    ldx #NUMBER_OF_BYTES_FOR_BLOCK_WRITE_OR_COPY
    WriteVdc()
    rts
}
#endif

#if VDC_WRITEBYTE
/**
  Write a specific byte to current ram pointer.

  Params:
    A - byte to store
*/
WriteByte: {
    ldx #MEMORY_READ_WRITE
    WriteVdc()
    rts
}
#endif

#if VDC_SETRAMPOINTER
/**
  Set ram pointer.

  Params:
    A - low byte of address
    Y - high byte of address
*/
SetRamPointer: {
    ldx #CURRENT_MEMORY_LOW_ADDRESS
    WriteVdc()
    tya
    dex
    WriteVdc()
    rts
}
#endif

#if VDC_INITTEXT
/**
  Initialize Vdc for text display.
*/
InitText: {
    ldx #HORIZONTAL_SMOOTH_SCROLLING
    ReadVdc()
    and #$7f
    WriteVdc()              // set text mode
    ldx #SCREEN_MEMORY_STARTING_HIGH_ADDRESS
    ReadVdc()
    sta vdcram+1
    inx
    ReadVdc()
    sta vdcram            // save screen RAM address
    ldx #ATTRIBUTE_MEMORY_HIGH_ADDRESS
    ReadVdc()
    sta vdcattr+1
    inx
    ReadVdc()
    sta vdcattr           // save attribute RAM address

    rts
}
#endif

#if VDC_MOVESCREENPOINTERTO00 || VDC_MOVEATTRIBUTEPOINTERTO00 || VDC_POSITIONXY || VDC_POSITIONATTRXY || VDC_INITTEXT
  count:      .byte $fa
  high:       .byte $fc
  low:        .byte $fb
  str:        .byte $fd

  vdcram:     .word $0000
  vdcattr:    .word $0800
#endif

}

/**
  Go to 40 columns mode

  @note Use c128lib_Go40 in vdc-global.asm

  @since 0.6.0
*/
.macro Go40() {
  lda Vdc.MODE                // are we in 40 columns mode?
  bpl !+                      // bit 7 unset? then yes
  jsr c128lib.Kernal.SWAPPER  // swap mode to 40 columns
!:
}
.assert "Go40()", { Go40() },
{
  lda $d7; bpl *+5; jsr $FF5F
}

/**
  Go to 80 columns mode

  @note Use c128lib_Go80 in vdc-global.asm

  @since 0.6.0
*/
.macro Go80() {
  lda Vdc.MODE                // are we in 80 columns mode?
  bmi !+                      // bit 7 set? then yes
  jsr c128lib.Kernal.SWAPPER  // swap mode to 80 columns
!:
}
.assert "Go80()", { Go80() },
{
  lda $d7; bmi *+5; jsr $FF5F
}

.function CalculateAttributeByte(attributes, color) {
  .return attributes + color;
}

/**
  Calculate byte with hi nibble to foreground color and low nibble
  to background color.

  @param[in] background Background color
  @param[in] foreground Foreground color

  @since 0.6.0
*/
.function CalculateBackgroundAndForeground(background, foreground) {
  .return ((foreground << 4) + background)
}

/**
  Set background and foreground color, also disable bit 6 of
  HORIZONTAL_SMOOTH_SCROLLING register

  @note Use c128lib_SetBackgroundForegroundColor in vdc-global.asm

  @since 0.6.0
*/
.macro SetBackgroundForegroundColor(background, foreground) {
    lda #0
    ldx #Vdc.HORIZONTAL_SMOOTH_SCROLLING
    ReadVdc()

    and #%10111111
    WriteVdc()

    lda #CalculateBackgroundAndForeground(background, foreground)
    ldx #Vdc.FOREGROUND_BACKGROUND_COLOR
    WriteVdc()
}
.assert "SetBackgroundForegroundColor(background, foreground)", {
    SetBackgroundForegroundColor(Vdc.VDC_DARK_GREEN, Vdc.VDC_LIGHT_GREEN)
  }, {
    lda #0; ldx #$19;
    stx $d600; bit $d600; bpl *-3; lda $d601
    and #%10111111;
    stx $d600; bit $d600; bpl *-3; sta $d601
    lda #$54
    ldx #$1A
    stx $d600; bit $d600; bpl *-3; sta $d601
}

/**
  Set background and foreground color, also disable bit 6 of
  HORIZONTAL_SMOOTH_SCROLLING register. Use vars instead of labels.
  Warning: high nibble of background must be 0, it's up to developer
  to check this.

  @note Use c128lib_SetBackgroundForegroundColorWithVars in vdc-global.asm

  @since 0.6.0
*/
.macro SetBackgroundForegroundColorWithVars(background, foreground) {
    lda #0
    ldx #Vdc.HORIZONTAL_SMOOTH_SCROLLING
    ReadVdc()

    and #%10111111
    WriteVdc()

    lda foreground
    asl
    asl
    asl
    asl
    ora background
    ldx #Vdc.FOREGROUND_BACKGROUND_COLOR
    WriteVdc()
}
.assert "SetBackgroundForegroundColorWithVars(background, foreground)", {
    SetBackgroundForegroundColorWithVars($beef, $baab)
  }, {
    lda #0; ldx #$19;
    stx $d600; bit $d600; bpl *-3; lda $d601
    and #%10111111;
    stx $d600; bit $d600; bpl *-3; sta $d601
    lda $baab;
    asl; asl; asl; asl;
    ora $beef;
    ldx #$1A;
    stx $d600; bit $d600; bpl *-3; sta $d601
}

/**
  Read from Vdc internal memory and write it to Vic screen memory by
  using coordinates.

  @param[in] xPos X coord on Vdc screen
  @param[in] yPos Y coord on Vdc screen
  @param[in] destination Vic screen memory absolute address
  @param[in] qty Number of byte to copy

  @note Use c128lib_ReadFromVdcMemoryByCoordinates in vdc-global.asm

  @since 0.6.0
*/
.macro ReadFromVdcMemoryByCoordinates(xPos, yPos, destination, qty) {
  .errorif (xPos == -1 && yPos != -1), "xPos and yPos must be -1 at same time"
  .errorif (xPos != -1 && yPos == -1), "xPos and yPos must be -1 at same time"
  .errorif (xPos < -1 || yPos < -1), "xPos and yPos can't be lower than -1"
  .errorif (qty <= 0), "qty must be greater than 0"
  .errorif (qty > 255), "qty must be lower than 256"
  .if (xPos != -1 && yPos != -1) {
    ldx #$12
    lda #>getTextOffset80Col(xPos, yPos)
    jsr c128lib.ScreenEditor.WRITEREG
    lda #<getTextOffset80Col(xPos, yPos)
    inx
    jsr c128lib.ScreenEditor.WRITEREG
  }
    ldy #0
  CopyLoop:
    jsr c128lib.ScreenEditor.READ80
    sta destination, y
    iny
    cpy #qty
    bne CopyLoop
}
.asserterror "ReadFromVdcMemoryByCoordinates(-1, 0, $beef, 100)", { ReadFromVdcMemoryByCoordinates(-1, 0, $beef, 100) }
.asserterror "ReadFromVdcMemoryByCoordinates(0, -1, $beef, 100)", { ReadFromVdcMemoryByCoordinates(0, -1, $beef, 100) }
.asserterror "ReadFromVdcMemoryByCoordinates(-2, 0, $beef, 100)", { ReadFromVdcMemoryByCoordinates(-2, 0, $beef, 100) }
.asserterror "ReadFromVdcMemoryByCoordinates(0, -2, $beef, 100)", { ReadFromVdcMemoryByCoordinates(0, -2, $beef, 100) }
.asserterror "ReadFromVdcMemoryByCoordinates(-2, -2, $beef, 100)", { ReadFromVdcMemoryByCoordinates(-2, -2, $beef, 100) }
.asserterror "ReadFromVdcMemoryByCoordinates(2, 2, $beef, 0)", { ReadFromVdcMemoryByCoordinates(2, 2, $beef, 0) }
.asserterror "ReadFromVdcMemoryByCoordinates(2, 2, $beef, 256)", { ReadFromVdcMemoryByCoordinates(2, 2, $beef, 256) }
.assert "ReadFromVdcMemoryByCoordinates(-1, -1, $beef, 100)", { ReadFromVdcMemoryByCoordinates(-1, -1, $beef, 100) },
{
    ldy #0; jsr $CDD8; sta $beef, y; iny; cpy #100; bne *-9;
}
.assert "ReadFromVdcMemoryByCoordinates(1, 1, $beef, 100)", { ReadFromVdcMemoryByCoordinates(1, 1, $beef, 100) },
{
    ldx #$12; lda #0; jsr $CDCC; lda #81; inx; jsr $CDCC;
    ldy #0; jsr $CDD8; sta $beef, y; iny; cpy #100; bne *-9;
}
.assert "ReadFromVdcMemoryByCoordinates(1, 1, $beef, 255)", { ReadFromVdcMemoryByCoordinates(1, 1, $beef, 255) },
{
    ldx #$12; lda #0; jsr $CDCC; lda #81; inx; jsr $CDCC;
    ldy #0; jsr $CDD8; sta $beef, y; iny; cpy #255; bne *-9;
}

/**
  Read from Vdc internal memory and write it to Vic screen memory by
  using source address.

  @param[in] source Vdc memory absolute address
  @param[in] destination Vic screen memory absolute address
  @param[in] qty Number of byte to copy

  @note Use c128lib_ReadFromVdcMemoryByAddress in vdc-global.asm

  @since 0.6.0
*/
.macro ReadFromVdcMemoryByAddress(source, destination, qty) {
  .errorif (qty <= 0), "qty must be greater than 0"
  .errorif (qty > 255), "qty must be lower than 256"
    ldx #$12
    lda #>source
    jsr c128lib.ScreenEditor.WRITEREG
    lda #<source
    inx
    jsr c128lib.ScreenEditor.WRITEREG

    ldy #0
  CopyLoop:
    jsr c128lib.ScreenEditor.WRITE80
    sta destination, y
    iny
    cpy #qty
    bne CopyLoop
}
.asserterror "ReadFromVdcMemoryByAddress($beef, $baab, 0)", { ReadFromVdcMemoryByAddress($beef, $baab, 0) }
.asserterror "ReadFromVdcMemoryByAddress($beef, $baab, 256)", { ReadFromVdcMemoryByAddress($beef, $baab, 256) }
.assert "ReadFromVdcMemoryByAddress($beef, $baab, 100)", { ReadFromVdcMemoryByAddress($beef, $baab, 100) },
{
    ldx #$12; lda #$be; jsr $CDCC; lda #$ef; inx; jsr $CDCC;
    ldy #0; jsr $CDCA; sta $baab, y; iny; cpy #100; bne *-9;
}
.assert "ReadFromVdcMemoryByAddress($beef, $baab, 255)", { ReadFromVdcMemoryByAddress($beef, $baab, 255) },
{
    ldx #$12; lda #$be; jsr $CDCC; lda #$ef; inx; jsr $CDCC;
    ldy #0; jsr $CDCA; sta $baab, y; iny; cpy #255; bne *-9;
}

/**
  Read from Vic screen memory and write it to Vdc internal memory by
  using coordinates.

  @param[in] xPos X coord on Vic screen
  @param[in] yPos Y coord on Vic screen
  @param[in] destination Vdc internal memory absolute address
  @param[in] qty Number of byte to copy

  @note Use c128lib_WriteToVdcMemoryByCoordinates in vdc-global.asm

  @since 0.6.0
*/
.macro WriteToVdcMemoryByCoordinates(source, xPos, yPos, qty) {
  .errorif (xPos == -1 && yPos != -1), "xPos and yPos must be -1 at same time"
  .errorif (xPos != -1 && yPos == -1), "xPos and yPos must be -1 at same time"
  .errorif (xPos < -1 || yPos < -1), "xPos and yPos can't be lower than -1"
  .errorif (qty <= 0), "qty must be greater than 0"
  .errorif (qty > 255), "qty must be lower than 256"
  .if (xPos != -1 && yPos != -1) {
    ldx #$12
    lda #>getTextOffset80Col(xPos, yPos)
    jsr c128lib.ScreenEditor.WRITEREG
    lda #<getTextOffset80Col(xPos, yPos)
    inx
    jsr c128lib.ScreenEditor.WRITEREG
  }
    ldy #0
  CopyLoop:
    lda source, y
    jsr c128lib.ScreenEditor.WRITE80
    iny
    cpy #qty
    bne CopyLoop
}
.asserterror "WriteToVdcMemoryByCoordinates($beef, -1, 0, 100)", { WriteToVdcMemoryByCoordinates($beef, -1, 0, 100) }
.asserterror "WriteToVdcMemoryByCoordinates($beef, 0, -1, 100)", { WriteToVdcMemoryByCoordinates($beef, 0, -1, 100) }
.asserterror "WriteToVdcMemoryByCoordinates($beef, -2, 0, 100)", { WriteToVdcMemoryByCoordinates($beef, -2, 0, 100) }
.asserterror "WriteToVdcMemoryByCoordinates($beef, 0, -2, 100)", { WriteToVdcMemoryByCoordinates($beef, 0, -2, 100) }
.asserterror "WriteToVdcMemoryByCoordinates($beef, -2, -2, 100)", { WriteToVdcMemoryByCoordinates($beef, -2, -2, 100) }
.asserterror "WriteToVdcMemoryByCoordinates($beef, 2, 2, 0)", { WriteToVdcMemoryByCoordinates($beef, 2, 2, 0) }
.asserterror "WriteToVdcMemoryByCoordinates($beef, 2, 2, 256)", { WriteToVdcMemoryByCoordinates($beef, 2, 2, 256) }
.assert "WriteToVdcMemoryByCoordinates($beef, -1, -1, 100)", { WriteToVdcMemoryByCoordinates($beef, -1, -1, 100) },
{
    ldy #0; lda $beef, y; jsr $CDCA; iny; cpy #100; bne *-9;
}
.assert "WriteToVdcMemoryByCoordinates($beef, 1, 1, 100)", { WriteToVdcMemoryByCoordinates($beef, 1, 1, 100) },
{
    ldx #$12; lda #0; jsr $CDCC; lda #81; inx; jsr $CDCC;
    ldy #0; lda $beef, y; jsr $CDCA; iny; cpy #100; bne *-9;
}
.assert "WriteToVdcMemoryByCoordinates($beef, 1, 1, 255)", { WriteToVdcMemoryByCoordinates($beef, 1, 1, 255) },
{
    ldx #$12; lda #0; jsr $CDCC; lda #81; inx; jsr $CDCC;
    ldy #0; lda $beef, y; jsr $CDCA; iny; cpy #255; bne *-9;
}

/**
  Read from Vic screen memory and write it to Vdc internal memory by
  using coordinates.

  @param[in] source Vdc memory absolute address
  @param[in] destination Vic screen memory absolute address
  @param[in] qty Number of byte to copy

  @note Use c128lib_WriteToVdcMemoryByAddress in vdc-global.asm

  @since 0.6.0
*/
.macro WriteToVdcMemoryByAddress(source, destination, qty) {
  .errorif (qty <= 0), "qty must be greater than 0"
  .errorif (qty > 255), "qty must be lower than 256"
    ldx #$12
    lda #>destination
    jsr c128lib.ScreenEditor.WRITEREG
    lda #<destination
    inx
    jsr c128lib.ScreenEditor.WRITEREG

    ldy #0
  CopyLoop:
    lda source, y
    jsr c128lib.ScreenEditor.WRITE80
    iny
    cpy #qty
    bne CopyLoop
}
.asserterror "WriteToVdcMemoryByAddress($beef, $baab, 0)", { WriteToVdcMemoryByAddress($beef, $baab, 0) }
.asserterror "WriteToVdcMemoryByAddress($beef, $baab, 256)", { WriteToVdcMemoryByAddress($beef, $baab, 256) }
.assert "WriteToVdcMemoryByAddress($beef, $baab, 100)", { WriteToVdcMemoryByAddress($beef, $baab, 100) },
{
    ldx #$12; lda #$ba; jsr $CDCC; lda #$ab; inx; jsr $CDCC;
    ldy #0; lda $beef, y; jsr $CDCA; iny; cpy #100; bne *-9;
}
.assert "WriteToVdcMemoryByAddress($beef, $baab, 255)", { WriteToVdcMemoryByAddress($beef, $baab, 255) },
{
    ldx #$12; lda #$ba; jsr $CDCC; lda #$ab; inx; jsr $CDCC;
    ldy #0; lda $beef, y; jsr $CDCA; iny; cpy #255; bne *-9;
}

/**
  Calculates memory offset of text cell specified by given coordinates
  on 80 cols screen

  @param[in] xPos X coord on Vdc screen
  @param[in] yPos Y coord on Vdc screen
  @return Memory offset of Vdc specified coordinate

  @note Use c128lib_WriteToVdcMemoryByAddress in vdc-global.asm

  @since 0.6.0
*/
.function getTextOffset80Col(xPos, yPos) {
  .return xPos + Vdc.TEXT_SCREEN_80_COL_WIDTH * yPos
}
.assert "getTextOffset80Col(0,0) gives 0", getTextOffset80Col(0, 0), 0
.assert "getTextOffset80Col(79,0) gives 79", getTextOffset80Col(79, 0), 79
.assert "getTextOffset80Col(0,1) gives 80", getTextOffset80Col(0, 1), 80
.assert "getTextOffset80Col(19,12) gives 979", getTextOffset80Col(19, 12), 979
.assert "getTextOffset80Col(79,24) gives 1999", getTextOffset80Col(79, 24), 1999

/**
  Returns the address start of Vdc display memory data. This
  is stored in Vdc register SCREEN_MEMORY_STARTING_HIGH_ADDRESS and 
  SCREEN_MEMORY_STARTING_LOW_ADDRESS.
  The 16-bit value is stored in $FB and $FC.

  @note Use c128lib_GetVdcDisplayStart in vdc-global.asm

  @since 0.6.0
*/
.macro GetVdcDisplayStart() {
  ldx #Vdc.SCREEN_MEMORY_STARTING_HIGH_ADDRESS
  ReadVdc()

  sta $fb
  inx
  ReadVdc()
  sta $fc
}

/**
  Set the pointer to the RAM area that is to be updated.
  The update pointer is stored in Vdc register CURRENT_MEMORY_HIGH_ADDRESS
  and CURRENT_MEMORY_LOW_ADDRESS.

  @param[in] address Address of update area

  @note Use c128lib_SetVdcUpdateAddress in vdc-global.asm

  @since 0.6.0
*/
.macro SetVdcUpdateAddress(address) {
  ldx #Vdc.CURRENT_MEMORY_HIGH_ADDRESS
  lda #>address
  WriteVdc();

  inx
  .var a1 = <address
  .var a2 = >address
  .if (a1 != a2) {
    lda #<address // include if different from hi-byte.
  }
  WriteVdc()
}

/**
  Translates between Vic and Vdc color codes.

  @param[in] viccolor Vic color code to translate

  @note Use c128lib_GetVdcColor in vdc-global.asm

  @since 0.6.0
*/
.macro GetVdcColor(viccolor) {
  ldx #viccolor
  lda Vdc.COLOR80,x
}
.assert "GetVdcColor(0)", { GetVdcColor(0) }, {
  ldx #0; lda $ce5c,x
}

/**
  Write a value into Vdc register without using kernal
  routine instead of pure instruction. It needs register
  number in X and value to write in A.
  It costs 11 bytes and 14 cycles.

  @note Use c128lib_WriteVdc in vdc-global.asm

  @since 0.6.0
*/
.macro WriteVdc() {
    stx Vdc.VDCADR
!:  bit Vdc.VDCADR
    bpl !-
    sta Vdc.VDCDAT
}
.assert "WriteVdc()", { WriteVdc() }, {
  stx $d600; bit $d600; bpl *-3; sta $d601
}

/**
  Read a value from Vdc register without using kernal
  routine instead of pure instruction. It needs register
  number in X and value is written in A.
  It costs 11 bytes and 14 cycles.

  @note Use c128lib_ReadVdc in vdc-global.asm

  @since 0.6.0
*/
.macro ReadVdc() {
    stx Vdc.VDCADR
!:  bit Vdc.VDCADR
    bpl !-
    lda Vdc.VDCDAT
}
.assert "ReadVdc()", { ReadVdc() }, {
  stx $d600; bit $d600; bpl *-3; lda $d601
}

/**
  Write a value into Vdc register. It uses kernal
  routine instead of pure instruction.
  It costs 7 bytes and 12 cycles.

  @param[in] register Register to write on
  @param[in] value Value to write

  @note Use c128lib_WriteVdcWithKernal in vdc-global.asm

  @since 0.6.0
*/
.macro WriteVdcWithKernal(register, value) {
    ldx #register
    lda #value
    jsr c128lib.ScreenEditor.WRITEREG
}
.assert "WriteVdcWithKernal()", { WriteVdcWithKernal(1, 2) }, {
  ldx #1; lda #2; jsr $CDCC
}

/**
  Read a value from Vdc register. It uses kernal
  routine instead of pure instruction.
  It costs 7 bytes and 8 cycles.

  @param[in] register Register to read

  @note Use c128lib_ReadVdcWithKernal in vdc-global.asm

  @since 0.6.0
*/
.macro ReadVdcWithKernal(register) {
    ldx #register
    jsr c128lib.ScreenEditor.READREG
}
.assert "ReadVdcWithKernal()", { ReadVdcWithKernal(1) }, {
  ldx #1; jsr $CDDA
}

/**
  Fill Vdc screen with specific character.

  @param[in] char Charater used to fill screen

  @remarks Need VDC_FILLSCREEN to be defined

  @note Use c128lib_FillScreen in vdc-global.asm

  @since 0.6.0
*/
.macro FillScreen(char) {
#if !VDC_FILLSCREEN
    .error "You should use #define VDC_FILLSCREEN"
#else
    lda #char
    jsr Vdc.FillScreen
#endif
}

.macro FillAttribute(byte) {
#if !VDC_FILLATTRIBUTE
    .error "You should use #define VDC_FILLATTRIBUTE"
#else
    lda #byte
    jsr Vdc.FillAttribute
#endif
}

.macro MoveScreenPointerTo00() {
#if !VDC_MOVESCREENPOINTERTO00
    .error "You should use #define VDC_MOVESCREENPOINTERTO00"
#else
    jsr Vdc.MoveScreenPointerTo00
#endif
}

.macro MoveAttributePointerTo00() {
#if !VDC_MOVEATTRIBUTEPOINTERTO00
    .error "You should use #define VDC_MOVEATTRIBUTEPOINTERTO00"
#else
    jsr Vdc.MoveAttributePointerTo00
#endif
}

.macro PrintCharAtPosition(char, x, y) {
#if !VDC_PRINTCHARATPOSITION
    .error "You should use #define VDC_PRINTCHARATPOSITION"
#else
    lda #char
    ldx #x
    ldy #y
    jsr Vdc.PrintCharAtPosition
#endif
}

.macro PositionXy(x, y) {
#if !VDC_POSITIONXY
    .error "You should use #define VDC_POSITIONXY"
#else
    ldx #x
    ldy #y
    jsr Vdc.PositionXy
#endif
}

.macro PositionAttrXy(x, y) {
#if !VDC_POSITIONATTRXY
    .error "You should use #define VDC_POSITIONATTRXY"
#else
    ldx #x
    ldy #y
    jsr Vdc.PositionAttrXy
#endif
}

.macro RepeatByte(times) {
#if !VDC_REPEATBYTE
    .error "You should use #define VDC_REPEATBYTE"
#else
    lda #times
    jsr Vdc.RepeatByte
#endif
}

.macro WriteByte(byteToWrite) {
#if !VDC_WRITEBYTE
    .error "You should use #define VDC_WRITEBYTE"
#else
    lda #byteToWrite
    jsr Vdc.WriteByte
#endif
}

.macro SetRamPointer(address) {
#if !VDC_SETRAMPOINTER
    .error "You should use #define VDC_SETRAMPOINTER"
#else
    lda #<address
    ldy #>address
    jsr Vdc.SetRamPointer
#endif
}

.macro InitText() {
#if !VDC_INITTEXT
    .error "You should use #define VDC_INITTEXT"
#else
    jsr Vdc.InitText
#endif
}

// .macro Print80Str(address) {
//   #if !PRINT80STR
//     .error "You should use #define PRINT80STR"
//   #else
//     lda #>address
//     ldy #<address // low byte
//     jsr Vdc.Print80Str
//   #endif
// }

#import "common/lib/kernal.asm"
#import "common/lib/screen-editor.asm"
