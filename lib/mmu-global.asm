#importonce

#import "mmu.asm"
.filenamespace c128lib

.macro @c128lib_SetCommonRAM(config) { SetCommonRAM(config) }
.macro @c128lib_SetMMUConfiguration(config) { SetMMUConfiguration(config) }
.macro @c128lib_SetMMULoadConfiguration(config) { SetMMULoadConfiguration(config) }
.macro @c128lib_SetBankConfiguration(config) { SetBankConfiguration(config) }
.macro @c128lib_SetVICRAMBank(value) { SetVICRAMBank(value) }
.macro @c128lib_SetIOBank(bank, bankname) { SetIOBank(bank, bankname) }
