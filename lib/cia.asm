/*
 * Requires KickAssembler v5.x
 * (c) 2022 Raffaele Intorcia
 *
 * References available at
 * https://c128lib.github.io/Reference/Cia
 * https://c128lib.github.io/Reference/DC00
 * https://c128lib.github.io/Reference/DD00
 */
#importonce
.filenamespace c128lib

.namespace Cia {

// CIA1
.label CIA1               = $DC00
.label CIA1_DATA_PORT_A   = CIA1 + $00
.label CIA1_DATA_PORT_B   = CIA1 + $01
.label CIA1_DATA_DIR_A    = CIA1 + $02
.label CIA1_DATA_DIR_B    = CIA1 + $03
.label CIA1_TIMER_A_LO    = CIA1 + $04
.label CIA1_TIMER_A_HI    = CIA1 + $05
.label CIA1_TIMER_B_LO    = CIA1 + $06
.label CIA1_TIMER_B_HI    = CIA1 + $07
.label CIA1_TOD_SEC10     = CIA1 + $08
.label CIA1_TOD_SEC       = CIA1 + $09
.label CIA1_TOD_MIN       = CIA1 + $0A
.label CIA1_TOD_HOUR      = CIA1 + $0B
.label CIA1_IO_BUFFER     = CIA1 + $0C
.label CIA1_IRQ_CONTROL   = CIA1 + $0D
.label CIA1_CONTROL_A     = CIA1 + $0E
.label CIA1_CONTROL_B     = CIA1 + $0F

// CIA2
.label CIA2               = $DD00
.label CIA2_DATA_PORT_A   = CIA2 + $00
.label CIA2_DATA_PORT_B   = CIA2 + $01
.label CIA2_DATA_DIR_A    = CIA2 + $02
.label CIA2_DATA_DIR_B    = CIA2 + $03
.label CIA2_TIMER_A_LO    = CIA2 + $04
.label CIA2_TIMER_A_HI    = CIA2 + $05
.label CIA2_TIMER_B_LO    = CIA2 + $06
.label CIA2_TIMER_B_HI    = CIA2 + $07
.label CIA2_TOD_SEC10     = CIA2 + $08
.label CIA2_TOD_SEC       = CIA2 + $09
.label CIA2_TOD_MIN       = CIA2 + $0A
.label CIA2_TOD_HOUR      = CIA2 + $0B
.label CIA2_IO_BUFFER     = CIA2 + $0C
.label CIA2_IRQ_CONTROL   = CIA2 + $0D
.label CIA2_CONTROL_A     = CIA2 + $0E
.label CIA2_CONTROL_B     = CIA2 + $0F

// Joystick flags
.label JOY_UP           = %00001
.label JOY_DOWN         = %00010
.label JOY_LEFT         = %00100
.label JOY_RIGHT        = %01000
.label JOY_FIRE         = %10000

// VIC-II memory banks
.label BANK_0           = %00000011   // $0000-$3FFF
.label BANK_1           = %00000010   // $4000-$7FFF
.label BANK_2           = %00000001   // $8000-$BFFF
.label BANK_3           = %00000000   // $C000-$FFFF

}

/*
  Configures memory "bank" (16K) which is directly addressable by VIC2 chip.
 
  MOD: A
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

/*
  Check if joystick port 1 fire button is pressed.

  TIP: using control port 1 for joystick input can have an undesiderable
  side effect. Since the input lines of that port are also used for
  reading the keyboard, the keyscan routine ($C55D) has no way to tell
  whether the port lines are beign grounded by keypresses of joystick
  presses. As a result, moving a joystick effectively generates a keypress,
  and certain keypresses produce the same effect as moving the joystick.

  Accumulator will be 0 if button is pressed
*/
.macro GetFirePressedPort1() {
  lda Cia.CIA1_DATA_PORT_B
  and #Cia.JOY_FIRE
}

/*
  Check if joystick port 2 fire button is pressed.
  Accumulator will be 0 if button is pressed
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
