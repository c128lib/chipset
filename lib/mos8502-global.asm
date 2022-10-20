#import "mos8502.asm"
#importonce
.filenamespace c128lib

.macro @c128lib_configureMemory(config) { configureMemory(config) }
.macro @c128lib_SetMMUConfiguration(config) { SetMMUConfiguration(config) }
.macro @c128lib_SetBankConfiguration(config) { SetBankConfiguration(config) }
.macro @c128lib_SetCommonRAM(config) { SetCommonRAM(config) }
