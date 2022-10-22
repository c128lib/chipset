#import "cia.asm"

/*
 * Requires KickAssembler v5.x
 * (c) 2022 Raffaele Intorcia
 */
#importonce
.filenamespace c128lib

.macro @c128lib_SetVICBank(bank) { SetVICBank(bank) }
