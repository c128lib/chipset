#import "common/lib/kernal.asm"
#import "common/lib/screen-editor.asm"

/*
 * Requires KickAssembler v5.x
 * (c) 2022 Raffaele Intorcia
 *
 * References available at
 * https://c128lib.github.io/Reference/Vdc
 * https://c128lib.github.io/Reference/D600
*/
#importonce
.filenamespace c128lib

.namespace Vdc {

/*
  VDC color codes
*/
.label VDC_BLACK = 0
.label VDC_DARK_GRAY = 1
.label VDC_DARK_BLUE = 2
.label VDC_LIGHT_BLUE = 3
.label VDC_DARK_GREEN = 4
.label VDC_LIGHT_GREEN = 5
.label VDC_DARK_CYAN = 6
.label VDC_LIGHT_CYAN = 7
.label VDC_DARK_RED = 8
.label VDC_LIGHT_RED = 9
.label VDC_DARK_PURPLE = 10
.label VDC_LIGHT_PURPLE = 11
.label VDC_DARK_YELLOW = 12
.label VDC_LIGHT_YELLOW = 13
.label VDC_LIGHT_GRAY = 14
.label VDC_WHITE = 15

.label COLOR80    = $ce5c

.label MODE       = $d7

.label TEXT_SCREEN_80_COL_WIDTH = 80

/*
  VDC registers
*/
.label VDCADR     = $d600   // VDC address/status register
.label VDCDAT     = $d601   // VDC data register

/*
  VDC internal registers
*/
.label TOTALE_NUMBER_OF_HORIZONTAL_CHARACTER_POSITIONS    = $00
.label NUMBER_OF_VISIBILE_HORIZONTAL_CHARACTER_POSITIONS  = $01
.label HORIZONTAL_SYNC_POSITION                           = $02
.label HORIZONTAL_VERTICAL_SYNC_WIDTH                     = $03
.label NUMBER_SCREEN_ROWS                                 = $04
.label VERTICAL_FINE_ADJUSTMENT                           = $05
.label VISIBLE_SCREEN_ROWS                                = $06
.label VERTICAL_SYNC_POSITION                             = $07
.label INTERLACE_MODE_CONTRO_POSITION                     = $08
.label SCANLINES_PER_CHARACTER                            = $09
.label CURSOR_MODE_CONTROL                                = $0A
.label ENDING_SCAN_LINE                                   = $0B
.label SCREEN_MEMORY_STARTING_HIGH_ADDRESS                = $0C
.label SCREEN_MEMORY_STARTING_LOW_ADDRESS                 = $0D
.label CURSOR_POSITION_HIGH_ADDRESS                       = $0E
.label CURSOR_POSITION_LOW_ADDRESS                        = $0F
.label LIGHT_PEN_VERTICAL_POSITION                        = $10
.label LIGHT_PEN_HORIZONTAL_POSITION                      = $11
.label CURRENT_MEMORY_HIGH_ADDRESS                        = $12
.label CURRENT_MEMORY_LOW_ADDRESS                         = $13
.label ATTRIBUTE_MEMORY_HIGH_ADDRESS                      = $14
.label ATTRIBUTE_MEMORY_LOW_ADDRESS                       = $15
.label CHARACTER_HORIZONTAL_SIZE_CONTROL                  = $16
.label CHARACTER_VERTICAL_SIZE_CONTROL                    = $17
.label VERTICAL_SMOOTH_SCROLLING                          = $18
.label HORIZONTAL_SMOOTH_SCROLLING                        = $19
.label FOREGROUND_BACKGROUND_COLOR                        = $1A
.label ADDRESS_INCREMENT_PER_ROW                          = $1B
.label CHARACTER_SET_ADDRESS                              = $1C
.label UNDERLINE_SCAN_LINE_POSITION                       = $1D
.label NUMBER_OF_BYTES_FOR_BLOCK_WRITE_OR_COPY            = $1E
.label MEMORY_READ_WRITE                                  = $1F
.label BLOCK_COPY_SOURCE_HIGH_ADDRESS                     = $20
.label BLOCK_COPY_SOURCE_LOW_ADDRESS                      = $21
.label BEGINNING_POSITION_FOR_HORIZONTAL_BLANKING         = $22
.label ENDING_POSITION_FOR_HORIZONTAL_BLANKING            = $23
.label NUMBER_OF_MEMORY_REFRESH_CYCLER_PER_SCANLINE       = $24

}

/*
  Go to 40 columns mode
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

/*
  Go to 80 columns mode
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

/*
  Calculate byte with hi nibble to foreground color and low nibble
  to background color.
*/
.function CalculateBackgroundAndForeground(background, foreground) {
  .return ((foreground << 4) + background)
}

/*
  Set background and foreground color, also disable bit 6 of
  HORIZONTAL_SMOOTH_SCROLLING register
*/
.macro SetBackgroundForegroundColor(background, foreground) {
    lda #0
    ldx #Vdc.HORIZONTAL_SMOOTH_SCROLLING
    ReadVDC()

    and #%10111111
    WriteVDC()

    lda #CalculateBackgroundAndForeground(background, foreground)
    ldx #Vdc.FOREGROUND_BACKGROUND_COLOR
    WriteVDC()
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

/*
  Calculates memory offset of text cell specified by given coordinates
  on 80 cols screen

  Params:
  xPos - X coord
  yPos - Y coord
*/
.function getTextOffset80Col(xPos, yPos) {
  .return xPos + Vdc.TEXT_SCREEN_80_COL_WIDTH * yPos
}
.assert "getTextOffset80Col(0,0) gives 0", getTextOffset80Col(0, 0), 0
.assert "getTextOffset80Col(79,0) gives 39", getTextOffset80Col(79, 0), 79
.assert "getTextOffset80Col(0,1) gives 80", getTextOffset80Col(0, 1), 80
.assert "getTextOffset80Col(19,12) gives 979", getTextOffset80Col(19, 12), 979
.assert "getTextOffset80Col(79,24) gives 1959", getTextOffset80Col(79, 24), 1999

/*
  Returns the address start of VDC display memory data. This
  is stored in VDC register 12 and 13.
  The 16-bit value is stored in $FB and $FC.

  Syntax:    GetVDCDisplayStart()
*/
.macro GetVDCDisplayStart() {
  ldx #Vdc.SCREEN_MEMORY_STARTING_HIGH_ADDRESS
  ReadVDC()

  sta $fb
  inx
  ReadVDC()
  sta $fc
}

/*
  Set the pointer to the RAM area that is to be updated.
  The update pointer is stored in VDC register 18 and 19.

  Syntax:    SetVDCUpdateAddress($1200)

  This will point register 18 and 19 to $1200. This area
  can then be written to using WriteVDCRAM()
*/
.macro SetVDCUpdateAddress(address) {
  ldx #Vdc.CURRENT_MEMORY_HIGH_ADDRESS
  lda #>address
  WriteVDC();

  inx
  .var a1 = <address
  .var a2 = >address
  .if( a1 != a2) {
    lda #<address // include if different from hi-byte.
  }
  WriteVDC()
}

/*
  Translates between VIC and VDC color codes.

  Syntax:    GetVDCColor(0)
*/
.macro GetVDCColor(viccolor) {
  ldx #viccolor
  lda Vdc.COLOR80,x
}
.assert "GetVDCColor(0)", { GetVDCColor(0) }, {
  ldx #0; lda $ce5c,x
}

/*
  Write a value into Vdc register without using kernal
  routine instead of pure instruction. It needs register
  number in X and value to write in A.
  It costs 11 byte.

  Syntax:    WriteVDC()
*/
.macro WriteVDC() {
    stx Vdc.VDCADR
!:  bit Vdc.VDCADR
    bpl !-
    sta Vdc.VDCDAT
}
.assert "WriteVDC()", { WriteVDC() }, {
  stx $d600; bit $d600; bpl *-3; sta $d601
}

/*
  Read a value from Vdc register without using kernal
  routine instead of pure instruction. It needs register
  number in X and value is written in A.
  It costs 11 byte.

  Syntax:    ReadVDC()
*/
.macro ReadVDC() {
    stx Vdc.VDCADR
!:  bit Vdc.VDCADR
    bpl !-
    lda Vdc.VDCDAT
}
.assert "ReadVDC()", { ReadVDC() }, {
  stx $d600; bit $d600; bpl *-3; lda $d601
}

/*
  Write a value into Vdc register. It uses kernal
  routine instead of pure instruction.
  It costs 7 byte.

  Syntax:    WriteVDCWithKernal(FOREGROUND_BACKGROUND_COLOR, 11)
*/
.macro WriteVDCWithKernal(register, value) {
    ldx #register
    lda #value
    jsr c128lib.ScreenEditor.WRITEREG
}
.assert "WriteVDCWithKernal()", { WriteVDCWithKernal(1, 2) }, {
  ldx #1; lda #2; jsr $CDCC
}

/*
  Read a value from Vdc register. It uses kernal
  routine instead of pure instruction.
  It costs 7 byte.

  Syntax:    WriteVDCWithKernal(FOREGROUND_BACKGROUND_COLOR, 11)
*/
.macro ReadVDCWithKernal(register, value) {
    ldx #register
    lda #value
    jsr c128lib.ScreenEditor.READREG
}
.assert "ReadVDCWithKernal()", { ReadVDCWithKernal(1, 2) }, {
  ldx #1; lda #2; jsr $CDDA
}
