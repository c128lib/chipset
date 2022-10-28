#import "cia.asm"

/*
 * Requires KickAssembler v5.x
 * (c) 2022 Raffaele Intorcia
 */
#importonce
.filenamespace c128lib

.macro @c128lib_SetVICBank(bank) { SetVICBank(bank) }
.macro @c128lib_GetFirePressedPort1() { GetFirePressedPort1() }
.macro @c128lib_GetFirePressedPort2() { GetFirePressedPort2() }
