/*
 * c128lib - Mmu
 *
 * References available at
 * https://c128lib.github.io/Reference/Mmu
 * https://c128lib.github.io/Reference/D500
 */
#importonce

#import "common/lib/kernal.asm"

.filenamespace c128lib

.namespace Mmu {

.label CONFIGURATION        = $D500   // Bank configuration register
.label PRECONFIG_A          = $D501
.label PRECONFIG_B          = $D502
.label PRECONFIG_C          = $D503
.label PRECONFIG_D          = $D504
.label MODE_CONFIG          = $D505   // Cpu mode configuration register
.label RAM_CONFIG           = $D506   // Ram configuration register
.label PAGE0_PAGE_POINTER   = $D507
.label PAGE0_BLOCK_POINTER  = $D508
.label PAGE1_PAGE_POINTER   = $D509
.label PAGE1_BLOCK_POINTER  = $D50A
.label MMU_VERSION          = $D50B

.label LOAD_CONFIGURATION   = $FF00
.label LOAD_PRECONFIG_A     = $FF01
.label LOAD_PRECONFIG_B     = $FF02
.label LOAD_PRECONFIG_C     = $FF03
.label LOAD_PRECONFIG_D     = $FF04

// CONFIGURATION bit handling
// bit 0 - controls io active on $d000-$dfff
.label IO_ROM             = %00000000
.label IO_RAM             = %00000001

// bit 1 - controls rom low space $4000-$7fff (Basic low rom)
.label ROM_LOW_ROM        = %00000000
.label ROM_LOW_RAM        = %00000010

// bit 2-3 - controls rom mid space $8000-$bfff (Basic hi rom, ML monitor rom)
.label ROM_MID_ROM        = %00000000   // Upper portion of BASIC ROM ($8000-$AFFF), plus monitor ROM ($BOOO-$BFFF)
.label ROM_MID_INT        = %00000100   // Internal function ROM: refers to ROM in the free ROM socket on the 128 circuit board
.label ROM_MID_EXT        = %00001000   // External function ROM: refers to ROM in a cartridge plugged into the expansion port.
.label ROM_MID_RAM        = %00001100

// bit 4-5 - controls rom mid space $c000-$ffff (Screen editor rom, kernal rom)
.label ROM_HI             = %00000000   // Screen editor ROM ($c000-$cfff), character ROM ($d000-$Ddfff), Kemal ROM ($e000-$ffff)
.label ROM_HI_INT         = %00010000   // Internal function ROM: refers to ROM in the free ROM socket on the 128 circuit board.
.label ROM_HI_EXT         = %00100000   // External function ROM: refers to ROM in a cartridge plugged into the expansion port.
.label ROM_HI_RAM         = %00110000

// bit 6
.label RAM0               = %00000000
.label RAM1               = %01000000

// MODE_CONFIG bit handling
// bit 0 Cpu active
.label CPU_Z80            = %00000000
.label CPU_8502           = %00000001

// bit 3 Fast serial input/output
.label FASTSERIALINPUT    = %00000000
.label FASTSERIALOUTPUT   = %00001000

// bit 4 GAME
.label GAME_LOW           = %00000000
.label GAME_HI            = %00010000

// bit 5 EXROM
.label EXROM_LOW          = %00000000
.label EXROM_HI           = %00100000

// bit 6 Kernal 128/64
.label KERNAL_128         = %00000000
.label KERNAL_64          = %01000000

// bit 7 40/80 cols
.label COLS_80            = %00000000
.label COLS_40            = %10000000

// RAM_CONFIG bit handling
// bit 0-1 Amount of common ram
.label COMMON_RAM_1K      = %00000000
.label COMMON_RAM_4K      = %00000001
.label COMMON_RAM_8K      = %00000010
.label COMMON_RAM_16K     = %00000011

// bit 2-3 Position of common ram
.label COMMON_RAM_UNUSED  = %00000000
.label COMMON_RAM_BOTTOM  = %00000100
.label COMMON_RAM_TOP     = %00001000
.label COMMON_RAM_BOTH    = COMMON_RAM_BOTTOM | COMMON_RAM_TOP

}

/*
  Banking, RAM configurations

  Refer to IO_*, ROM_*, RAM* label to generate input value

  Syntax: SetMMUConfiguration(Mmu.RAM1 | Mmu.ROM_HI_RAM | Mmu.ROM_MID_RAM | Mmu.ROM_LOW_RAM | Mmu.IO_RAM)
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

/*
  Set mode configuration register.

  Syntax: SetModeConfig(Mmu.CPU_8502 | Mmu.KERNAL_C64)
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

/*
  Configure common RAM amount.

  RAM Bank 0 is always the visible RAM bank.
  Valid values are 1,4,8 and 16.
  For ex. if you choose 4K common ram at top and bottom
  you'll have 4K up and 4K bottom.

  Syntax:    SetCommonRAM(Mmu.COMMON_RAM_4K | Mmu.COMMON_RAM_BOTH)
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

/*
  Sets RAM bank that will be involved in I/O.
  Also sets bank where the filename will be found.
  Use the Basic bank definitions. (0-15)

  Syntax:    SetIOBank(15, 15)
*/
.macro SetIOBank(bank, bankname) {
  lda #bank
  ldx #bankname
  jsr c128lib.Kernal.SETBNK
}
.assert "SetIOBank(1, 2)", { SetIOBank(1, 2) }, {
  lda #1; ldx #2; jsr $FF68
}
