/**
 * @file mmu.asm
 * @brief Mmu module
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

.namespace Mmu {

/** Configuration register https://c128lib.github.io/Reference/D500#D500 */
.label CONFIGURATION        = $D500
/** Preconfiguration register A https://c128lib.github.io/Reference/D500#D501 */
.label PRECONFIG_A          = $D501
/** Preconfiguration register B https://c128lib.github.io/Reference/D500#D502 */
.label PRECONFIG_B          = $D502
/** Preconfiguration register C https://c128lib.github.io/Reference/D500#D503 */
.label PRECONFIG_C          = $D503
/** Preconfiguration register D https://c128lib.github.io/Reference/D500#D504 */
.label PRECONFIG_D          = $D504
/** Mode configuration register https://c128lib.github.io/Reference/D500#D505 */
.label MODE_CONFIG          = $D505
/** RAM configuration register https://c128lib.github.io/Reference/D500#D506 */
.label RAM_CONFIG           = $D506
/** Page 0 pointer https://c128lib.github.io/Reference/D500#D507 */
.label PAGE0_PAGE_POINTER   = $D507
/** Page 0 block pointer https://c128lib.github.io/Reference/D500#D508 */
.label PAGE0_BLOCK_POINTER  = $D508
/** Page 1 pointer https://c128lib.github.io/Reference/D500#D509 */
.label PAGE1_PAGE_POINTER   = $D509
/** Page 1 block pointer https://c128lib.github.io/Reference/D500#D50A */
.label PAGE1_BLOCK_POINTER  = $D50A
/** Version register https://c128lib.github.io/Reference/D500#D50B */
.label MMU_VERSION          = $D50B
/** Configuration register https://c128lib.github.io/Reference/FF00#FF00 */
.label LOAD_CONFIGURATION   = $FF00
/** Load configuration register A https://c128lib.github.io/Reference/FF00#FF01 */
.label LOAD_PRECONFIG_A     = $FF01
/** Load configuration register B https://c128lib.github.io/Reference/FF00#FF02 */
.label LOAD_PRECONFIG_B     = $FF02
/** Load configuration register C https://c128lib.github.io/Reference/FF00#FF03 */
.label LOAD_PRECONFIG_C     = $FF03
/** Load configuration register D https://c128lib.github.io/Reference/FF00#FF04 */
.label LOAD_PRECONFIG_D     = $FF04

/** Mask for configuration bit 0 to set ROM active on address $d000-$dfff */
.label IO_ROM             = %00000000
/** Mask for configuration bit 0 to set RAM active on address $d000-$dfff */
.label IO_RAM             = %00000001

/** Mask for configuration bit 1 to set ROM active on address $4000-$7fff (Basic low rom) */
.label ROM_LOW_ROM        = %00000000
/** Mask for configuration bit 1 to set RAM active on address $4000-$7fff (Basic low rom) */
.label ROM_LOW_RAM        = %00000010

/** Mask for configuration bits 2-3 to set ROM active on upper portion of BASIC ROM ($8000-$AFFF), plus monitor ROM ($B000-$BFFF) */
.label ROM_MID_ROM        = %00000000
/** Mask for configuration bits 2-3 to set internal function ROM: refers to ROM in the free ROM socket on the 128 circuit board */
.label ROM_MID_INT        = %00000100
/** Mask for configuration bits 2-3 to set xxternal function ROM: refers to ROM in a cartridge plugged into the expansion port. */
.label ROM_MID_EXT        = %00001000
/** Mask for configuration bits 2-3 to set RAM active on upper portion of BASIC ROM ($8000-$AFFF), plus monitor ROM ($B000-$BFFF) */
.label ROM_MID_RAM        = %00001100

// bit 4-5 - controls rom mid space $c000-$ffff (Screen editor rom, kernal rom)
/** Mask for configuration bits 4-5 to set ROM active on screen editor ROM ($c000-$cfff), character ROM ($d000-$Ddfff), Kemal ROM ($e000-$ffff) */
.label ROM_HI             = %00000000
/** Mask for configuration bits 4-5 to set internal function ROM: refers to ROM in the free ROM socket on the 128 circuit board. */
.label ROM_HI_INT         = %00010000
/** Mask for configuration bits 4-5 to set external function ROM: refers to ROM in a cartridge plugged into the expansion port. */
.label ROM_HI_EXT         = %00100000
/** Mask for configuration bits 4-5 to set RAM active on screen editor ROM ($c000-$cfff), character ROM ($d000-$Ddfff), Kemal ROM ($e000-$ffff) */
.label ROM_HI_RAM         = %00110000

/** Mask for configuration bit 6 to set block 0 active */
.label RAM0               = %00000000
/** Mask for configuration bit 6 to set block 1 active */
.label RAM1               = %01000000

/** Mask for bit 0 for selecting Z80 cpu to run  */
.label CPU_Z80            = %00000000
/** Mask for bit 0 for selecting 8502 cpu to run  */
.label CPU_8502           = %00000001

/** Mask for bit 3 for selecting fast serial input */
.label FASTSERIALINPUT    = %00000000
/** Mask for bit 3 for selecting fast serial output */
.label FASTSERIALOUTPUT   = %00001000

/** Mask for bit 4 for GAME pin low */
.label GAME_LOW           = %00000000
/** Mask for bit 4 for GAME pin high */
.label GAME_HI            = %00010000

/** Mask for bit 5 for EXROM pin low */
.label EXROM_LOW          = %00000000
/** Mask for bit 5 for EXROM pin high */
.label EXROM_HI           = %00100000

/** Mask for bit 6 for selecting 128 Kernal rom */
.label KERNAL_128         = %00000000
/** Mask for bit 6 for selecting 64 Kernal rom */
.label KERNAL_64          = %01000000

/** Mask for bit 7 for selecting 40/80 keyboard key switch status to 80 col */
.label COLS_80            = %00000000
/** Mask for bit 7 for selecting 40/80 keyboard key switch status to 40 col */
.label COLS_40            = %10000000

/** Mask for bits 0-1 to set 1k of common ram */
.label COMMON_RAM_1K      = %00000000
/** Mask for bits 0-1 to set 4k of common ram */
.label COMMON_RAM_4K      = %00000001
/** Mask for bits 0-1 to set 8k of common ram */
.label COMMON_RAM_8K      = %00000010
/** Mask for bits 0-1 to set 16k of common ram */
.label COMMON_RAM_16K     = %00000011

/** Mask for bits 2-3 to disable common ram  */
.label COMMON_RAM_UNUSED  = %00000000
/** Mask for bits 2-3 to set common ram on bottom (near $0000) */
.label COMMON_RAM_BOTTOM  = %00000100
/** Mask for bits 2-3 to set common ram on top (near $FFFF) */
.label COMMON_RAM_TOP     = %00001000
/** Mask for bits 2-3 to set common ram on bottom and top */
.label COMMON_RAM_BOTH    = COMMON_RAM_BOTTOM | COMMON_RAM_TOP

/** Mask for bit 7 to set Vic bank on ram block 0 */
.label VIC_BANK_ON_RAM_0  = %00000000
/** Mask for bit 7 to set Vic bank on ram block 1 */
.label VIC_BANK_ON_RAM_1  = %01000000
/** Mask for bit 7 to set Vic bank on ram block 2 */
.label VIC_BANK_ON_RAM_2  = %10000000
/** Mask for bit 7 to set Vic bank on ram block 3 */
.label VIC_BANK_ON_RAM_3  = %11000000

}

/**
	Macro for Mmu configuration.

	@param[in] config Values for Mmu confiuration

	@note Config parameter can be filled with Mmu.IO_*, Mmu.ROM_LOW_*, Mmu.ROM_MID_*, Mmu.ROM_HI_*, Mmu.RAM*

	@remark Register .A will be modified.
	Flags N and Z will be affected.

	@note Use c128lib_SetMMUConfiguration in mmu-global.asm

	@since 0.6.0
*/
.macro SetMMUConfiguration(config) {
		lda #config
		sta Mmu.CONFIGURATION
}
.assert "SetMMUConfiguration(RAM1 | ROM_HI_RAM | ROM_MID_RAM | ROM_LOW_RAM | IO_RAM) sets accumulator to 7f", { SetMMUConfiguration(Mmu.RAM1 | Mmu.ROM_HI_RAM | Mmu.ROM_MID_RAM | Mmu.ROM_LOW_RAM | Mmu.IO_RAM) }, {
	lda #%01111111; sta $d500
}

/*
	Banking, RAM configurations. Uses $FF00 instead of $D500.

	Refer to IO_*, ROM_*, RAM* label to generate input value

	Syntax: SetMMULoadConfiguration(Mmu.RAM0 | Mmu.ROM_HI | Mmu.ROM_MID_RAM | Mmu.ROM_LOW_ROM | Mmu.IO_ROM)
*/
.macro SetMMULoadConfiguration(config) {
		lda #config
		sta Mmu.LOAD_CONFIGURATION
}
.assert "SetMMULoadConfiguration(RAM1 | ROM_HI_RAM | ROM_MID_RAM | ROM_LOW_RAM | IO_RAM) sets accumulator to 7f", { SetMMULoadConfiguration(Mmu.RAM1 | Mmu.ROM_HI_RAM | Mmu.ROM_MID_RAM | Mmu.ROM_LOW_RAM | Mmu.IO_RAM) }, {
	lda #%01111111; sta $ff00
}

/*
	Banking, RAM configurations

	bits:
	0:   $d000-$dfff (i/o block, ram or rom)
	1:   $4000-$7fff (lower basic rom)
	2-3: $8000-$bfff (upper basic rom, monitor, internal/external ROM)
	4-5: $c000-$ffff (char ROM, kernal, internal/external ROM, RAM)
	6:   select RAM block

	Setting a bit means RAM, clearing means ROM.
	Use the BASIC Bank configuration numbers.

	Syntax: SetBankConfiguration(number)
*/
.macro SetBankConfiguration(id) {
		.if(id==0) {
			lda #%00111111   // no roms, RAM 0
		}
		.if(id==1) {
			lda #%01111111   // no roms, RAM 1
		}
		.if(id==12) {
			lda #%00000110   // internal function ROM, Kernal and IO, RAM 0
		}
		.if(id==14) {
			lda #%00000001   // all roms, char ROM, RAM 0
		}
		.if(id==15) {
			lda #%00000000  // all roms, RAM 0. default setting.
		}
		.if(id==99) {
			lda #%00001110  // IO, kernal, RAM0. No basic,48K RAM.
		}
		sta Mmu.LOAD_CONFIGURATION
}

/**
	Set mode configuration register.

	@param[in] config Values for confiuration register

	@note Config parameter can be filled with Mmu.CPU_*, Mmu.FASTSERIAL*, Mmu.GAME_*, Mmu.EXROM_*, Mmu.KERNAL_*, Mmu.COLS_*

	@note Use c128lib_SetModeConfig in mmu-global.asm

	@remark Register .A will be modified.
	Flags N and Z will be affected.

	@since 0.6.0
*/
.macro SetModeConfig(config) {
		lda #config
		sta Mmu.MODE_CONFIG
}
.assert "SetModeConfig(CPU_8502 | FASTSERIALOUTPUT | GAME_HI | EXROM_HI | KERNAL_64 | COLS_40) sets accumulator to 0f", {
		SetModeConfig(Mmu.CPU_8502 | Mmu.FASTSERIALOUTPUT | Mmu.GAME_HI | Mmu.EXROM_HI | Mmu.KERNAL_64 | Mmu.COLS_40)
}, {
	lda #%11111001; sta $d505
}

/**
	Configure common RAM amount.

	RAM Bank 0 is always the visible RAM bank.
	Valid values are 1,4,8 and 16.
	For ex. if you choose 4K common ram at top and bottom
	you'll have 4K up and 4K bottom.

	@param[in] config Values for common ram configuration

	@remark Register .A will be modified.
	Flags N and Z will be affected.

	@note Config parameter can be filled with Mmu.COMMON_RAM_*

	@note Use c128lib_SetCommonRAM in mmu-global.asm

	@since 0.6.0
*/
.macro SetCommonRAM(config) {
		lda #config
		sta Mmu.RAM_CONFIG
}
.assert "SetCommonRAM(COMMON_RAM_16K | COMMON_RAM_BOTH) sets accumulator to 0f", { SetCommonRAM(Mmu.COMMON_RAM_16K | Mmu.COMMON_RAM_BOTH) }, {
	lda #%00001111; sta $d506
}

/*
	Set RAM block that the VIC chip will use, bit 6 of MMUCR.
	Only useful for text display. Pretty useless, really.
	Kernal routines use RAM0, so you need to roll your own routines.

	Use SetVICBank() to set the 16k block that the VIC will use in that block.

	Syntax:    SetVICRamBank(0 or 1)
*/
.macro SetVICRAMBank(value) {
		lda Mmu.RAM_CONFIG
		and #%10111111       // clear bit 6
		.if(value==1) {
			ora #%01111111     // enable bit 6
		}
		sta Mmu.RAM_CONFIG
}
.assert "SetVICRAMBank(0) sets accumulator to 0f", { SetVICRAMBank(0) }, {
	lda $d506;and #%10111111;sta $d506
}
.assert "SetVICRAMBank(1) sets accumulator to 0f", { SetVICRAMBank(1) }, {
	lda $d506;and #%10111111;ora #%01111111;sta $d506
}

/**
	Sets RAM bank that will be involved in I/O.
	Also sets bank where the filename will be found.
	Use the Basic bank definitions. (0-15)

	@param[in] bank Values for setting bank
	@param[in] bankname Values filename

	@remark Register .A and .X will be modified.
	Flags N and Z will be affected.

	@note Use c128lib_SetIOBank in mmu-global.asm

	@since 0.6.0
*/
.macro SetIOBank(bank, bankname) {
	lda #bank
	ldx #bankname
	jsr c128lib.Kernal.SETBNK
}
.assert "SetIOBank(1, 2)", { SetIOBank(1, 2) }, {
	lda #1; ldx #2; jsr $FF68
}

#import "common/lib/kernal.asm"
