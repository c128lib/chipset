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

/*
 Sets IO input channel. Use logical file number.

 Syntax:    SetInputChannel(1)
 */
.macro SetInputChannel(parameter) {
  ldx #parameter
  jsr CHKIN
}

/*
 Sets IO output channel. Use logical file number.

 Syntax:    SetOutputChannel(1)
 */
.macro SetOutputChannel(parameter) {
  ldx #parameter
  jsr CHKOUT
}
