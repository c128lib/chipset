/**
  @file cia-global.asm
  @brief Cia module

  @copyright MIT Licensed
  @date 2022
*/

#importonce

.filenamespace c128lib

/**
  Configures memory "bank" (16K) which is directly addressable by VIC2 chip.

  @param[in] bank Bank to set

  @note Bank parameter can be filled with Cia.BANK_0, Cia.BANK_1, Cia.BANK_2, Cia.BANK_3

  @remark Register .A will be modified.
  Flags N, Z and C will be affected.

  @since 0.6.0
*/
.macro @c128lib_SetVICBank(bank) { SetVICBank(bank) }

.macro @c128lib_WaitReturnPressed() { WaitReturnPressed() }
.macro @c128lib_WaitReturnPressedAndReleased() { WaitReturnPressedAndReleased() }
.macro @c128lib_WaitSpacePressed() { WaitSpacePressed() }
.macro @c128lib_WaitSpacePressedAndReleased() { WaitSpacePressedAndReleased() }

/**
  Check if joystick port 1 fire button is pressed.
  Accumulator will be 0 if button is pressed

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @attention Using control port 1 for joystick input can have an undesiderable
  side effect. Since the input lines of that port are also used for
  reading the keyboard, the keyscan routine ($C55D) has no way to tell
  whether the port lines are beign grounded by keypresses of joystick
  presses. As a result, moving a joystick effectively generates a keypress,
  and certain keypresses produce the same effect as moving the joystick.

  @since 0.6.0
*/
.macro @c128lib_GetFirePressedPort1() { GetFirePressedPort1() }

/**
  Check if joystick port 2 fire button is pressed.
  Accumulator will be 0 if button is pressed

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_GetFirePressedPort2() { GetFirePressedPort2() }
.macro @c128lib_disableCIAInterrupts() { disableCIAInterrupts() }

#import "cia.asm"
