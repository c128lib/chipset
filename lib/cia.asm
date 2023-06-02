/**
  @file cia.asm
  @brief Cia module

  @copyright MIT Licensed
  @date 2022
*/

#importonce
.filenamespace c128lib

.namespace Cia {

/** I/O port data registers D1PRA */
.label CIA1               = $DC00
/** I/O port data registers D1PRA */
.label CIA1_DATA_PORT_A   = CIA1 + $00
/** I/O port data registers D1PRB */
.label CIA1_DATA_PORT_B   = CIA1 + $01
/** Data direction registers D1DDRA */
.label CIA1_DATA_DIR_A    = CIA1 + $02
/** Data direction registers D1DDRB */
.label CIA1_DATA_DIR_B    = CIA1 + $03
/** Timer A latch/counter registers D1T1L */
.label CIA1_TIMER_A_LO    = CIA1 + $04
/** Timer A latch/counter registers D1T1H */
.label CIA1_TIMER_A_HI    = CIA1 + $05
/** Timer B latch/counter registers D1T2L */
.label CIA1_TIMER_B_LO    = CIA1 + $06
/** Timer B latch/counter registers D1T2H */
.label CIA1_TIMER_B_HI    = CIA1 + $07
/** Time-of-day clock registers D1TOD1 */
.label CIA1_TOD_SEC10     = CIA1 + $08
/** Time-of-day clock registers D1TODS */
.label CIA1_TOD_SEC       = CIA1 + $09
/** Time-of-day clock registers D1TODM */
.label CIA1_TOD_MIN       = CIA1 + $0A
/** Time-of-day clock registers D1TODH */
.label CIA1_TOD_HOUR      = CIA1 + $0B
/** Serial data register D1SDR */
.label CIA1_IO_BUFFER     = CIA1 + $0C
/** Interrupt control register D1ICR */
.label CIA1_IRQ_CONTROL   = CIA1 + $0D
/** Control register A D1CRA */
.label CIA1_CONTROL_A     = CIA1 + $0E
/** Control register B D1CRB */
.label CIA1_CONTROL_B     = CIA1 + $0F

/** I/O port data registers D2PRA */
.label CIA2               = $DD00
/** I/O port data registers D2PRA */
.label CIA2_DATA_PORT_A   = CIA2 + $00
/** I/O port data registers D2PRB */
.label CIA2_DATA_PORT_B   = CIA2 + $01
/** Data direction registers D2DDRA */
.label CIA2_DATA_DIR_A    = CIA2 + $02
/** Data direction registers D2DDRA */
.label CIA2_DATA_DIR_B    = CIA2 + $03
/** Timer A latch/counter registers D2T1L */
.label CIA2_TIMER_A_LO    = CIA2 + $04
/** Timer A latch/counter registers D2T1H */
.label CIA2_TIMER_A_HI    = CIA2 + $05
/** Timer B latch/counter registers D2T2L */
.label CIA2_TIMER_B_LO    = CIA2 + $06
/** Timer B latch/counter registers D2T2H */
.label CIA2_TIMER_B_HI    = CIA2 + $07
/** Time-of-day clock registers D2TOD1 */
.label CIA2_TOD_SEC10     = CIA2 + $08
/** Time-of-day clock registers D2TODS */
.label CIA2_TOD_SEC       = CIA2 + $09
/** Time-of-day clock registers D2TODM */
.label CIA2_TOD_MIN       = CIA2 + $0A
/** Time-of-day clock registers D2TODH */
.label CIA2_TOD_HOUR      = CIA2 + $0B
/** Serial data register D2SDR */
.label CIA2_IO_BUFFER     = CIA2 + $0C
/** Interrupt control register D2ICR */
.label CIA2_IRQ_CONTROL   = CIA2 + $0D
/** Control register B D2CRA */
.label CIA2_CONTROL_A     = CIA2 + $0E
/** Control register B D2CRA */
.label CIA2_CONTROL_B     = CIA2 + $0F

/** Mask for joystick up direction detection */
.label JOY_UP           = %00001
/** Mask for joystick down direction detection */
.label JOY_DOWN         = %00010
/** Mask for joystick left direction detection */
.label JOY_LEFT         = %00100
/** Mask for joystick right direction detection */
.label JOY_RIGHT        = %01000
/** Mask for joystick fire pressed detection */
.label JOY_FIRE         = %10000

/** Mask for Vic-2 bank 0 selection ($0000-$3FFF) */
.label BANK_0           = %00000011
/** Mask for Vic-2 bank 1 selection ($4000-$7FFF) */
.label BANK_1           = %00000010
/** Mask for Vic-2 bank 2 selection ($8000-$BFFF) */
.label BANK_2           = %00000001
/** Mask for Vic-2 bank 3 selection ($C000-$FFFF) */
.label BANK_3           = %00000000

}

/**
  Configures memory "bank" (16K) which is directly addressable by VIC2 chip.

  @param[in] bank Bank to set

  @note Bank parameter can be filled with Cia.BANK_0, Cia.BANK_1, Cia.BANK_2, Cia.BANK_3
  @note Use c128lib_SetVICBank in cia-global.asm

  @remark Register .A will be modified.
  Flags N, Z and C will be affected.

  @since 0.6.0
*/
.macro SetVICBank(bank) {
  lda Cia.CIA2_DATA_PORT_A
  and #%11111100
  ora #[bank & %00000011]
  sta Cia.CIA2_DATA_PORT_A
}
.assert "SetVICBank(BANK_0) sets 11", { SetVICBank(Cia.BANK_0) }, {
  lda $DD00
  and #%11111100
  ora #%00000011
  sta $DD00
}
.assert "SetVICBank(BANK_3) sets 00", { SetVICBank(Cia.BANK_3) }, {
  lda $DD00
  and #%11111100
  ora #%00000000
  sta $DD00
}

#if DETECTKEYPRESSED
DetectKeyPressed: {
    sei
    lda #%11111111
    sta c128lib.Cia.CIA1_DATA_DIR_A
    lda #%00000000
    sta c128lib.Cia.CIA1_DATA_DIR_B

    lda MaskOnPortA
    sta c128lib.Cia.CIA1_DATA_PORT_A
    lda c128lib.Cia.CIA1_DATA_PORT_B
    and MaskOnPortB
    beq Pressed
    lda #$00
    jmp !+
  Pressed:
    lda #$01
  !:
    cli
    rts

  MaskOnPortA:    .byte $00
  MaskOnPortB:    .byte $00
}
#endif

.macro IsReturnPressed() {
  #if (!DETECTKEYPRESSED)
    .error "You should use #define DETECTKEYPRESSED"
  #else
    lda #%11111110
    sta DetectKeyPressed.MaskOnPortA
    lda #%00000010
    sta DetectKeyPressed.MaskOnPortB
  !:
    jsr DetectKeyPressed
    beq !-
  #endif
}

.macro IsReturnPressedAndReleased() {
  #if (!DETECTKEYPRESSED)
    .error "You should use #define DETECTKEYPRESSED"
  #else
    lda #%11111110
    sta DetectKeyPressed.MaskOnPortA
    lda #%00000010
    sta DetectKeyPressed.MaskOnPortB
  !:
    jsr DetectKeyPressed
    beq !-
  !:
    jsr DetectKeyPressed
    bne !-
  #endif
}

.macro IsSpacePressed() {
  #if (!DETECTKEYPRESSED)
    .error "You should use #define DETECTKEYPRESSED"
  #else
    lda #%01111111
    sta DetectKeyPressed.MaskOnPortA
    lda #%00010000
    sta DetectKeyPressed.MaskOnPortB
  !:
    jsr DetectKeyPressed
    beq !-
  #endif
}

.macro IsSpacePressedAndReleased() {
  #if (!DETECTKEYPRESSED)
    .error "You should use #define DETECTKEYPRESSED"
  #else
    lda #%01111111
    sta DetectKeyPressed.MaskOnPortA
    lda #%00010000
    sta DetectKeyPressed.MaskOnPortB
  !:
    jsr DetectKeyPressed
    beq !-
  !:
    jsr DetectKeyPressed
    bne !-
  #endif
}

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

  @note Use c128lib_GetFirePressedPort1 in cia-global.asm

  @since 0.6.0
*/
.macro GetFirePressedPort1() {
  lda Cia.CIA1_DATA_PORT_B
  and #Cia.JOY_FIRE
}

/**
  Check if joystick port 2 fire button is pressed.
  Accumulator will be 0 if button is pressed

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @note Use c128lib_GetFirePressedPort2 in cia-global.asm

  @since 0.6.0
*/
.macro GetFirePressedPort2() {
  lda Cia.CIA1_DATA_PORT_A
  and #Cia.JOY_FIRE
}

.macro disableCIAInterrupts() {
  lda #$7f
  sta Cia.CIA1_IRQ_CONTROL
  sta Cia.CIA2_IRQ_CONTROL
  lda Cia.CIA1_IRQ_CONTROL
  lda Cia.CIA2_IRQ_CONTROL
}
