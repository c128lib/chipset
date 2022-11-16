#import "io.asm"
#importonce
.filenamespace c128lib

.macro @c128lib_SetIOBank(bank, bankname) { SetIOBank(bank, bankname) }
.macro @c128lib_OpenIOChannel(filenumber, devicenumber, secondary) { OpenIOChannel(filenumber, devicenumber, secondary) }
.macro @c128lib_SetIOName(length, address) { SetIOName(length, address) }
.macro @c128lib_SetInputChannel(parameter) { SetInputChannel(parameter) }
.macro @c128lib_SetOutputChannel(parameter) { SetOutputChannel(parameter) }
