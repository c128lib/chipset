#importonce

#import "cia.asm"

.filenamespace c128lib

.macro @c128lib_SetVICBank(bank) { SetVICBank(bank) }

.macro @c128lib_IsReturnPressed() { IsReturnPressed() }
.macro @c128lib_IsReturnPressedAndReleased() { IsReturnPressedAndReleased() }
.macro @c128lib_IsSpacePressed() { IsSpacePressed() }
.macro @c128lib_IsSpacePressedAndReleased() { IsSpacePressedAndReleased() }

.macro @c128lib_GetFirePressedPort1() { GetFirePressedPort1() }
.macro @c128lib_GetFirePressedPort2() { GetFirePressedPort2() }
.macro @c128lib_disableCIAInterrupts() { disableCIAInterrupts() }
