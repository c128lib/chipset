#import "common/lib/common.asm"
#import "common/lib/kernal.asm"

/*
 * Set of macros for handling IO.
 *
 * Requires KickAssembler v5.x
 * (c) 2022 Raffaele Intorcia
 */
#importonce
.filenamespace c128lib

/*
 Sets RAM bank that will be involved in I/O.
 Also sets bank where the filename will be found.
 Use the Basic bank definitions. (0-15)

 Syntax:    SetIOBank(15,15)
 */
.macro SetIOBank(bank, bankname) {
  lda #bank
  ldx #bankname
  jsr SETBNK
}
.assert "SetIOBank(1, 2)", { SetIOBank(1, 2) }, {
  lda #1; ldx #2; jsr $FF68
}

/*
 Opens IO channel.

 Syntax:    OpenIOChannel(15,8,15)
 */
.macro OpenIOChannel(filenumber, devicenumber,secondary) {
  lda #filenumber
  ldx #devicenumber
  ldy #secondary
  jsr SETLFS
}
.assert "OpenIOChannel(15, 8, 15)", { OpenIOChannel(15, 8, 15) }, {
  lda #15; ldx #8; ldy #15; jsr $FFBA
}

/*
 Sets IO filename

 Syntax:    SetIOName(4,$2000)
 */
.macro SetIOName(length, address) {
  lda #length
  ldx #<address
  ldy #>address
  jsr SETNAM
}
.assert "SetIOName(5, $beef)", { SetIOName(5, $beef) }, {
  lda #5; ldx #$ef; ldy #$be; jsr $FFBD
}

/*
 Sets IO input channel. Use logical file number.

 Syntax:    SetInputChannel(1)
 */
.macro SetInputChannel(parameter) {
  ldx #parameter
  jsr CHKIN
}
.assert "SetInputChannel(5)", { SetInputChannel(5) }, {
  ldx #5; jsr $FFC7
}

/*
 Sets IO output channel. Use logical file number.

 Syntax:    SetOutputChannel(1)
 */
.macro SetOutputChannel(parameter) {
  ldx #parameter
  jsr CHKOUT
}
.assert "SetOutputChannel(5)", { SetOutputChannel(5) }, {
  ldx #5; jsr $FFC9
}
