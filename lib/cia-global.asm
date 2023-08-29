/**
 * @file cia-global.asm
 * @brief Cia module
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

/**
  Configures memory "bank" (16K) which is directly addressable by VIC2 chip.

  @param[in] bank Bank to set

  @note Bank parameter can be filled with Cia.BANK_0, Cia.BANK_1, Cia.BANK_2, Cia.BANK_3

  @remark Register .A will be modified.
  Flags N, Z and C will be affected.

  @since 0.6.0
*/
.macro @c128lib_SetVICBank(bank) { SetVICBank(bank) }

/**
  Waits until return is pressed. It means a wait
  for a key down event.

  @remark Register .A will be modified.
  Flags N and Z will be affected.
  @remark Requires DETECTKEYPRESSED to be defined

  @since 0.6.0
*/
.macro @c128lib_WaitReturnPressed() { WaitReturnPressed() }
/**
  Waits until return is pressed and released. It means a wait
  for a key down and a key up event.

  @remark Register .A will be modified.
  Flags N and Z will be affected.
  @remark Requires DETECTKEYPRESSED to be defined

  @since 0.6.0
*/
.macro @c128lib_WaitReturnPressedAndReleased() { WaitReturnPressedAndReleased() }
/**
  Waits until space is pressed. It means a wait
  for a key down event.

  @remark Register .A will be modified.
  Flags N and Z will be affected.
  @remark Requires DETECTKEYPRESSED to be defined

  @since 0.6.0
*/
.macro @c128lib_WaitSpacePressed() { WaitSpacePressed() }
/**
  Waits until space is pressed and released. It means a wait
  for a key down and a key up event.

  @remark Register .A will be modified.
  Flags N and Z will be affected.
  @remark Requires DETECTKEYPRESSED to be defined

  @since 0.6.0
*/
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
