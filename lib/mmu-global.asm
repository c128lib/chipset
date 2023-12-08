/**
 * @file mmu-global.asm
 * @brief Mmu module
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

#import "mmu.asm"

.filenamespace c128lib

/**
  Configure common RAM amount.

  RAM Bank 0 is always the visible RAM bank.
  Valid values are 1,4,8 and 16.
  For ex. if you choose 4K common ram at top and bottom
  you'll have 4K up and 4K bottom.

  @param[in] config Values for common ram configuration

  @note Config parameter can be filled with Mmu.COMMON_RAM_*
  @code
  c128lib_SetCommonRAM(Mmu.COMMON_RAM_16K | Mmu.COMMON_RAM_BOTH)
  @endcode

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SetCommonRAM(config) { SetCommonRAM(config) }

.macro @c128lib_SetMMUConfiguration(config) { SetMMUConfiguration(config) }
/**
  Banking and RAM configurations. Uses $FF00 instead of $D500.

  @param[in] config Values for Mmu confiuration

  I/O block selection

  - c128lib.Mmu.IO_ROM set I/O block visible on $D000-$DFFF
  - c128lib.Mmu.IO_RAM set area on $D000-$DFFF dependant from c128lib.Mmu.ROM_HI selection

  If omitted, c128lib.Mmu.IO_ROM will be used.

  Low-ram selection

  - c128lib.Mmu.ROM_LOW_ROM set active low rom BASIC ($4000-$7FFF)
  - c128lib.Mmu.ROM_LOW_RAM set ram active on $4000-$7FFF

  If omitted, c128lib.Mmu.ROM_LOW_ROM will be used.

  Mid-ram selection

  - c128lib.Mmu.ROM_MID_RAM set ram active on $8000-$AFFF and $B000-$BFFF
  - c128lib.Mmu.ROM_MID_EXT set external function ROM
  - c128lib.Mmu.ROM_MID_INT set internal function ROM
  - c128lib.Mmu.ROM_MID_ROM set active rom BASIC ($8000-$AFFF) and monitor ROM ($B000-$BFFF)

  If omitted, c128lib.Mmu.ROM_MID_ROM will be used.

  Hi-ram selection

  - c128lib.Mmu.ROM_HI_RAM set ram active on $C000-$CFFF, $D000-$DFFF and $E000-$FFFF
  - c128lib.Mmu.ROM_HI_EXT set external function ROM
  - c128lib.Mmu.ROM_HI_INT set internal function ROM
  - c128lib.Mmu.ROM_HI set active rom for Screen editor ($C000-$CFFF), character ($D000-$DFFF), Kernal ($E000-$FFFF)

  If omitted, c128lib.Mmu.ROM_HI will be used.

  Bank selection

  - c128lib.Mmu.RAM0 or c128lib.Mmu.RAM1 can be used to set ram bank 0 or 1. If omitted, bank 0 will be selected.

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @code
  c128lib_SetMMULoadConfiguration(c128lib.Mmu.RAM0 | c128lib.Mmu.ROM_HI | c128lib.Mmu.ROM_MID_RAM | c128lib.Mmu.ROM_LOW_ROM | c128lib.Mmu.IO_ROM)
  @endcode

  @since 0.6.0
*/
.macro @c128lib_SetMMULoadConfiguration(config) { SetMMULoadConfiguration(config) }
.macro @c128lib_SetBankConfiguration(config) { SetBankConfiguration(config) }
.macro @c128lib_SetVICRAMBank(value) { SetVICRAMBank(value) }

/**
  Sets RAM bank that will be involved in I/O.
  Also sets bank where the filename will be found.
  Use the Basic bank definitions. (0-15)

  @param[in] bank Values for setting bank
  @param[in] bankname Values filename

  @remark Register .A and .X will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SetIOBank(bank, bankname) { SetIOBank(bank, bankname) }

/**
  Set mode configuration register.

  @param[in] config Values for confiuration register

  @note Config parameter can be filled with Mmu.CPU_*, Mmu.FASTSERIAL*, Mmu.GAME_*, Mmu.EXROM_*, Mmu.KERNAL_*, Mmu.COLS_*
  @code
  c128lib_SetModeConfig(Mmu.CPU_* | Mmu.FASTSERIAL* | Mmu.GAME_* | Mmu.EXROM_* | Mmu.KERNAL_* | Mmu.COLS_*)
  @endcode

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SetModeConfig(config) { SetModeConfig(config) }
