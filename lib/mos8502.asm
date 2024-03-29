/*
 * c128lib - 8502
 *
 * References available at
 * https://www.cubic.org/~doj/c64/mapping128.pdf
 */
#importonce

.filenamespace c128lib

.namespace Mos8502 {
  
/*
  MOS8502 Registers
*/
.label MOS_8502_DIRECTION       = $00
.label MOS_8502_IO              = $01

/*
  I/O Register bits.
*/
.label CASETTE_MOTOR_OFF        = %00100000
.label CASETTE_SWITCH_CLOSED    = %00010000
.label CASETTE_DATA             = %00001000
.label PLA_CHAREN               = %00000100
.label PLA_HIRAM                = %00000010
.label PLA_LORAM                = %00000001

/*
  Possible I/O & PLA configurations.
*/
.label RAM_RAM_RAM              = %000
.label RAM_CHAR_RAM             = PLA_LORAM
.label RAM_CHAR_KERNAL          = PLA_HIRAM
.label BASIC_CHAR_KERNAL        = PLA_LORAM | PLA_HIRAM
.label RAM_IO_RAM               = PLA_CHAREN | PLA_LORAM
.label RAM_IO_KERNAL            = PLA_CHAREN | PLA_HIRAM
.label BASIC_IO_KERNAL          = PLA_CHAREN | PLA_LORAM | PLA_HIRAM

}

.macro configureMemory(config) {
    lda Mos8502.MOS_8502_IO
    and #%11111000
    ora #[config & %00000111]
    sta Mos8502.MOS_8502_IO
}

/*
  Disable NMI by pointing NMI vector to rti
*/
.macro disableNMI() {
    lda #<nmi
    sta c128lib.NMI_LO
    lda #>nmi
    sta c128lib.NMI_HI
    jmp end
  nmi: 
    rti
  end:
}
