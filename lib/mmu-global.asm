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

/**
	Macro for Mmu configuration.

	@param[in] config Values for Mmu confiuration

	@note Config parameter can be filled with Mmu.IO_*, Mmu.ROM_LOW_*, Mmu.ROM_MID_*, Mmu.ROM_HI_*, Mmu.RAM*
	@code
	c128lib_SetMMUConfiguration(Mmu.RAM1 | Mmu.ROM_HI_RAM | Mmu.ROM_MID_RAM | Mmu.ROM_LOW_RAM | Mmu.IO_RAM)
	@endcode

	@remark Register .A will be modified.
	Flags N and Z will be affected.

	@since 0.6.0
*/
.macro @c128lib_SetMMUConfiguration(config) { SetMMUConfiguration(config) }
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
