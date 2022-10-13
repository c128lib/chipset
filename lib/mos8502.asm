#importonce

.filenamespace c128lib

/*
 * MOS8502 Registers.
 */
.label MOS_8502_DIRECTION       = $00
.label MOS_8502_IO              = $01

.label MMURCR 		              = $ff06 	// Ram configuration register

/*
 * I/O Register bits.
 */
.label CASETTE_MOTOR_OFF        = %00100000
.label CASETTE_SWITCH_CLOSED    = %00010000
.label CASETTE_DATA             = %00001000
.label PLA_CHAREN               = %00000100
.label PLA_HIRAM                = %00000010
.label PLA_LORAM                = %00000001

/*
 * Possible I/O & PLA configurations.
 */
.label RAM_RAM_RAM              = %000
.label RAM_CHAR_RAM             = PLA_LORAM
.label RAM_CHAR_KERNAL          = PLA_HIRAM
.label BASIC_CHAR_KERNAL        = PLA_LORAM | PLA_HIRAM
.label RAM_IO_RAM               = PLA_CHAREN | PLA_LORAM
.label RAM_IO_KERNAL            = PLA_CHAREN | PLA_HIRAM
.label BASIC_IO_KERNAL          = PLA_CHAREN | PLA_LORAM | PLA_HIRAM

.macro configureMemory(config) {
  lda MOS_8502_IO
  and #%11111000
  ora #[config & %00000111]
  sta MOS_8502_IO
}

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

/*----------------------------------------------------------
Configure common RAM amount.

RAM Bank 0 is always the visible RAM bank.
Valid values are 1,4,8 and 16.

Syntax:		:SetCommonRAM(1)
----------------------------------------------------------*/
.macro SetCommonRAM(amount) {
	lda MMURCR
	and #%11111100 			// clear bits 0 and 1. this is also option 1
	.if(amount==4) {
		ora #%00000001
	}
	.if(amount==8) {
		ora #%00000010
	}
	.if(amount==16) {
		ora #%00000011
	}
	sta MMURCR
}

/*----------------------------------------------------------
Configure where common RAM is enabled. Top, bottom, or both.
Valid options are 1, 2 or 3.
1 = bottom (default)
2 = top
3 = bottom and top

Syntax:		:SetCommonEnabled(1)
----------------------------------------------------------*/
.macro SetCommonEnabled(option) {
	lda MMURCR
	and #%11110011 			// clear bits 2 and 3
	ora #option*4
	sta MMURCR
}

/*----------------------------------------------------------
 Set RAM block that the VIC chip will use, bit 6 of MMUCR.
 Only useful for text display. Pretty useless, really.
 Kernal routines use RAM0, so you need to roll your own routines.

 Use SetVICBank() to set the 16k block that the VIC will use in that block.

 Syntax:		:SetVICRamBank(0 or 1)
 ----------------------------------------------------------*/
.macro SetVICRAMBank(value) {
	lda MMURCR
	and #%10111111 			// clear bit 6
	.if(value==1) {
		ora #%01111111 		// enable bit 6
	}
	sta MMURCR
}
