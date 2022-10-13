
/*
 * Set of variables, functions and macros
 * for handling VDC graphic processor.
 *
 * Requires KickAssembler v5.x
 * (c) 2022 Raffaele Intorcia
 */
#import "common/lib/common.asm"
#importonce
.filenamespace c128lib

.label MODE 		= $d7 

/* ------------------------------------
 * VDC registers.
 * ------------------------------------ */
.label VDCADR 		= $d600 	// VDC address/status register
.label VDCDAT 		= $d601 	// VDC data register

.label SWAPPER 		= $ff5f 	// switch between 40 or 80 colums

/*----------------------------------------------------------
* Go to 80 columns mode
----------------------------------------------------------*/
.macro Go80 () {
	lda MODE 		// are we in 80 columns mode?
	bmi !+ 			// bit 7 set? then yes
	jsr SWAPPER		// swap mode to 80 columns
!:
}

.macro WriteVDC () {
    stx VDCADR
!:	bit VDCADR
    bpl !-
    sta VDCDAT
}

.macro ReadVDC () {
    stx VDCADR
!:	bit VDCADR
    bpl !-
    lda VDCDAT
}
