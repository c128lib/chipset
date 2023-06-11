#importonce

#import "mmu.asm"
.filenamespace c128lib

.macro @c128lib_SetCommonRAM(config) { SetCommonRAM(config) }
/**
  Macro for Mmu configuration.

  @param[in] config Values for Mmu confiuration

  @note Config parameter can be filled with Mmu.IO_*, Mmu.ROM_LOW_*, Mmu.ROM_MID_*, Mmu.ROM_HI_*, Mmu.RAM*
  @code
  SetMMUConfiguration(Mmu.RAM1 | Mmu.ROM_HI_RAM | Mmu.ROM_MID_RAM | Mmu.ROM_LOW_RAM | Mmu.IO_RAM)
  @endcode

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SetMMUConfiguration(config) { SetMMUConfiguration(config) }
.macro @c128lib_SetMMULoadConfiguration(config) { SetMMULoadConfiguration(config) }
.macro @c128lib_SetBankConfiguration(config) { SetBankConfiguration(config) }
.macro @c128lib_SetVICRAMBank(value) { SetVICRAMBank(value) }
.macro @c128lib_SetIOBank(bank, bankname) { SetIOBank(bank, bankname) }
