#import "common/lib/common.asm"

/*
 * Set of variables, functions and macros
 * for handling VDC graphic processor.
 *
 * Requires KickAssembler v5.x
 * (c) 2022 Raffaele Intorcia
 */
#importonce
.filenamespace c128lib

.label COLOR80    = $ce5c

.label MODE       = $d7 

/*
 * VDC registers
 */
.label VDCADR     = $d600   // VDC address/status register
.label VDCDAT     = $d601   // VDC data register

.label SWAPPER     = $ff5f   // switch between 40 or 80 colums

/*
Go to 80 columns mode
*/
.macro Go80() {
  lda MODE        // are we in 80 columns mode?
  bmi !+          // bit 7 set? then yes
  jsr SWAPPER     // swap mode to 80 columns
!:
}

/*
Returns the address start of VDC display memory data. This
is stored in VDC register 12 and 13.
The 16-bit value is stored in $FB and $FC.

Syntax:    GetVDCDisplayStart()
*/
.macro GetVDCDisplayStart() {
  ldx #12
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
  ldx #18
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
  ldx viccolor
  lda COLOR80,x
}

.macro WriteVDC() {
    stx VDCADR
!:  bit VDCADR
    bpl !-
    sta VDCDAT
}

.macro ReadVDC() {
    stx VDCADR
!:  bit VDCADR
    bpl !-
    lda VDCDAT
}
