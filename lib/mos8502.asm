/*
 * Requires KickAssembler v5.x
 * (c) 2022 Raffaele Intorcia
 */
#importonce

.filenamespace c128lib

/*
 * MOS8502 Registers.
 */
.label MOS_8502_DIRECTION       = $00
.label MOS_8502_IO              = $01

/*
 * MMU (mirrored from $d500)
 */
.label MMUCR		    = $ff00 	// bank configuration register
.label PCRA 		    = $ff01 	// preconfig register A
.label PCRB 		    = $ff02 	// preconfig register B
.label PCRC 		    = $ff03 	// preconfig register C
.label PCRD 		    = $ff04 	// preconfig register D
.label MMUMCR		    = $ff05 	// cpu mode configuration register
.label MMURCR 		  = $ff06 	// ram configuration register

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
 Banking, RAM configurations

 bits:
 0:   $d000-$dfff (i/o block, ram or rom)
 1:   $4000-$7fff (lower basic rom)
 2-3: $8000-$bfff (upper basic rom, monitor, internal/external ROM)
 4-5: $c000-$ffff (char ROM, kernal, internal/external ROM, RAM)
 6:   select RAM block

 Setting a bit means RAM, clearing means ROM.
 Use the BASIC Bank configuration numbers.

 Syntax:		:SetBankConfiguration(number)
----------------------------------------------------------*/
.macro SetBankConfiguration(id) {
	.if(id==0) {
		lda #%00111111 	// no roms, RAM 0
	}
	.if(id==1) {
		lda #%01111111 	// no roms, RAM 1
	}
	.if(id==12) {
		lda #%00000110 	// internal function ROM, Kernal and IO, RAM 0
	}
	.if(id==14) {
		lda #%00000001 	// all roms, char ROM, RAM 0
	}
	.if(id==15) {
		lda #%00000000  // all roms, RAM 0. default setting.
	}
	.if(id==99) {
		lda #%00001110  // IO, kernal, RAM0. No basic,48K RAM.
	}
	sta MMUCR
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
