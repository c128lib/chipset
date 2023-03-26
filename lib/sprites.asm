/*
 * c128lib - Sprites
 */
#importonce

#import "vic2.asm"

.filenamespace c128lib

/* 
  Calculates sprite X position register address
*/
.function spriteXReg(spriteNo) {
  .return Vic2.VIC2 + spriteNo * 2
}
.assert "Reg address for sprite0 X pos", spriteXReg(0), $d000
.assert "Reg address for sprite7 X pos", spriteXReg(7), $d00e

/* 
  Calculates sprite X position shadow register address
*/
.function spriteShadowXReg(spriteNo) {
  .return Vic2.SHADOW_VIC2 + spriteNo * 2
}
.assert "Shadow reg address for sprite0 X pos", spriteShadowXReg(0), $11d6
.assert "Shadow reg address for sprite7 X pos", spriteShadowXReg(7), $11e4


/* 
  Calculates sprite Y position register address
*/
.function spriteYReg(spriteNo) {
  .return spriteXReg(spriteNo) + 1
}
.assert "Reg address for sprite0 Y pos", spriteYReg(0), $d001
.assert "Reg address for sprite7 Y pos", spriteYReg(7), $d00f

/* 
  Calculates sprite Y position shadow register address
*/
.function spriteShadowYReg(spriteNo) {
  .return spriteShadowXReg(spriteNo) + 1
}
.assert "Shadow reg address for sprite0 Y pos", spriteShadowYReg(0), $11d7
.assert "Shadow reg address for sprite7 Y pos", spriteShadowYReg(7), $11e5


/* 
  Calculates sprite bit position
*/
.function spriteMask(spriteNo) {
  .return pow(2, spriteNo)
}
.assert "Bit mask for sprite 0", spriteMask(0), %00000001
.assert "Bit mask for sprite 7", spriteMask(7), %10000000


/* 
  Calculate sprite color register address
*/
.function spriteColorReg(spriteNo) {
  .return Vic2.SPRITE_0_COLOR + spriteNo
}
.assert "Reg address for sprite0 color", spriteColorReg(0), $d027
.assert "Reg address for sprite7 color", spriteColorReg(7), $d02e


/* 
  Sets X position of given sprite (uses sprite MSB register if necessary)
  MOD: A
*/
.macro SetSpriteXPosition(spriteNo, x) {
  .if (x > 255) {
    lda #<x
    sta spriteXReg(spriteNo)
    lda Vic2.SPRITE_MSB_X
    ora #spriteMask(spriteNo)
    sta Vic2.SPRITE_MSB_X
  } else {
    lda #x
    sta spriteXReg(spriteNo)
  }
}
.assert "SetSpriteXPosition stores X in SPRITE_X reg", { SetSpriteXPosition(3, 5) }, { 
  lda #$05
  sta $d006 
}
.assert "SetSpriteXPosition stores X in SPRITE_X and MSB regs", { SetSpriteXPosition(3, 257) },  {
  lda #$01
  sta $d006 
  lda $d010
  ora #%00001000
  sta $d010
}

/* 
  Sets X position of given sprite (uses sprite MSB register if necessary)
  with shadow registers.
  MOD: A
*/
.macro SetSpriteXPositionWithShadow(spriteNo, x) {
  .if (x > 255) {
    lda #<x
    sta spriteShadowXReg(spriteNo)
    lda Vic2.SHADOW_SPRITE_MSB_X
    ora #spriteMask(spriteNo)
    sta Vic2.SHADOW_SPRITE_MSB_X
  } else {
    lda #x
    sta spriteShadowXReg(spriteNo)
  }
}
.assert "SetSpriteXPositionWithShadow stores X in SPRITE_X reg", { SetSpriteXPositionWithShadow(3, 5) }, { 
  lda #$05
  sta $11dc 
}
.assert "SetSpriteXPositionWithShadow stores X in SPRITE_X and MSB regs", { SetSpriteXPositionWithShadow(3, 257) },  {
  lda #$01
  sta $11dc 
  lda $11e6
  ora #%00001000
  sta $11e6
}

/* 
  Sets Y position of given sprite
  MOD: A
*/
.macro SetSpriteYPosition(spriteNo, y) {
  lda #y
  sta spriteYReg(spriteNo)
}
.assert "SetSpriteYPosition stores Y in SPRITE_Y reg", { SetSpriteYPosition(3, 5) },  {
  lda #$05
  sta $D007
}

/* 
  Sets Y position of given sprite with shadow registers
  MOD: A
*/
.macro SetSpriteYPositionWithShadow(spriteNo, y) {
  lda #y
  sta spriteShadowYReg(spriteNo)
}
.assert "SetSpriteYPositionWithShadow stores Y in SPRITE_Y reg", { SetSpriteYPositionWithShadow(3, 5) },  {
  lda #$05
  sta $11dd
}

/* 
  Sets X,Y position of given sprite
  MOD A
*/
.macro SetSpritePosition(spriteNo, x, y) {
  .if (x <= 255) {
    lda #x
    sta spriteXReg(spriteNo)
    .if (x != y) {
      lda #y
    }
    sta spriteYReg(spriteNo)
  } else {
    lda #<x
    sta spriteXReg(spriteNo)
    lda Vic2.SPRITE_MSB_X
    ora #spriteMask(spriteNo)
    sta Vic2.SPRITE_MSB_X
    lda #y
    sta spriteYReg(spriteNo)
  }
}
.assert "SetSpritePosition stores position in SPRITE_* reg (x and y equals)", { SetSpritePosition(3, 5, 5) }, { 
  lda #$05
  sta $d006 
  sta $d007 
}
.assert "SetSpritePosition stores position in SPRITE_* reg (x and y not equals)", { SetSpritePosition(3, 5, 15) }, { 
  lda #$05
  sta $d006 
  lda #15
  sta $d007 
}
.assert "SetSpritePosition stores position in SPRITE_* and MSB regs", { SetSpritePosition(3, 300, 15) },  {
  lda #44
  sta $d006 
  lda $d010
  ora #%00001000
  sta $d010
  lda #15
  sta $d007 
}

/* 
  Sets X,Y position of given sprite with shadow registers
  MOD A
*/
.macro SetSpritePositionWithShadow(spriteNo, x, y) {
  .if (x <= 255) {
    lda #x
    sta spriteShadowXReg(spriteNo)
    .if (x != y) {
      lda #y
    }
    sta spriteShadowYReg(spriteNo)
  } else {
    lda #<x
    sta spriteShadowXReg(spriteNo)
    lda Vic2.SHADOW_SPRITE_MSB_X
    ora #spriteMask(spriteNo)
    sta Vic2.SHADOW_SPRITE_MSB_X
    lda #y
    sta spriteShadowYReg(spriteNo)
  }
}
.assert "SetSpritePositionWithShadow stores position in SPRITE_* reg (x and y equals)", { SetSpritePositionWithShadow(3, 5, 5) }, { 
  lda #$05
  sta $11dc 
  sta $11dd 
}
.assert "SetSpritePositionWithShadow stores position in SPRITE_* reg (x and y not equals)", { SetSpritePositionWithShadow(3, 5, 15) }, { 
  lda #$05
  sta $11dc 
  lda #15
  sta $11dd 
}
.assert "SetSpritePositionWithShadow stores position in SPRITE_* and MSB regs", { SetSpritePositionWithShadow(3, 300, 15) },  {
  lda #44
  sta $11dc 
  lda $11e6
  ora #%00001000
  sta $11e6
  lda #15
  sta $11dd 
}

.function GetSpriteMovementStartingAddress(spriteNo) {
  .return Vic2.SPRITE_MOTION_0 + (Vic2.SPRITE_MOTION_OFFSET * spriteNo);
}

/*
  Define sprite movement

  Params:
  spriteNo - number of sprite (0..7)
  speed - speed of sprite
  quadrant - determines main direction of sprite (use SPRITE_MAIN_DIR_* labels)
  deltaX - move sprite on X each interrupt
  deltaY - move sprite on Y each interrupt

*/
.macro SpriteMove(spriteNo, speed, quadrant, deltaX, deltaY) {
  .errorif (spriteNo < 0 || spriteNo > 7), "spriteNo must be from 0 to 7"
  .errorif (speed < 0 || speed > 255), "speed must be from 0 to 255"
  .errorif (quadrant < Vic2.SPRITE_MAIN_DIR_UP || quadrant > Vic2.SPRITE_MAIN_DIR_LEFT), "quadrant must be from SPRITE_MAIN_DIR_UP to SPRITE_MAIN_DIR_LEFT"
    lda #speed
    sta GetSpriteMovementStartingAddress(spriteNo)
    lda #quadrant
    sta GetSpriteMovementStartingAddress(spriteNo) + 2
    lda #(<deltaX)
    sta GetSpriteMovementStartingAddress(spriteNo) + 3
    lda #(>deltaX)
    sta GetSpriteMovementStartingAddress(spriteNo) + 4
    lda #(<deltaY)
    sta GetSpriteMovementStartingAddress(spriteNo) + 5
    lda #(>deltaY)
    sta GetSpriteMovementStartingAddress(spriteNo) + 6
    lda #0
    sta GetSpriteMovementStartingAddress(spriteNo) + 1
    sta GetSpriteMovementStartingAddress(spriteNo) + 7
    sta GetSpriteMovementStartingAddress(spriteNo) + 8
    sta GetSpriteMovementStartingAddress(spriteNo) + 9
    sta GetSpriteMovementStartingAddress(spriteNo) + 10
}
.asserterror "SpriteMove(-1, 1, SPRITE_MAIN_DIR_UP, $1234, $beef)", { SpriteMove(-1, 1, Vic2.SPRITE_MAIN_DIR_UP, $1234, $beef) }
.asserterror "SpriteMove(8, 1, SPRITE_MAIN_DIR_UP, $1234, $beef)", { SpriteMove(8, 1, Vic2.SPRITE_MAIN_DIR_UP, $1234, $beef) }
.asserterror "SpriteMove(0, -1, SPRITE_MAIN_DIR_UP, $1234, $beef)", { SpriteMove(0, -1, Vic2.SPRITE_MAIN_DIR_UP, $1234, $beef) }
.asserterror "SpriteMove(0, 256, SPRITE_MAIN_DIR_UP, $1234, $beef)", { SpriteMove(0, 256, Vic2.SPRITE_MAIN_DIR_UP, $1234, $beef) }
.asserterror "SpriteMove(0, 0, -1, $1234, $beef)", { SpriteMove(0, 0, -1, $1234, $beef) }
.asserterror "SpriteMove(0, 0, 4, $1234, $beef)", { SpriteMove(0, 0, 4, $1234, $beef) }
.assert "SpriteMove(0, 1, SPRITE_MAIN_DIR_UP, $1234, $beef)", { SpriteMove(0, 1, Vic2.SPRITE_MAIN_DIR_UP, $1234, $beef) }, {
  lda #1; sta $117E; lda #0; sta $1180; lda #$34; sta $1181; lda #$12; sta $1182; lda #$ef; sta $1183; lda #$be; sta $1184;
  lda #0; sta $117F; sta $1185; sta $1186; sta $1187; sta $1188 
}

/*
  Enable one or more sprite.

  Params:
  mask - sprite mask (use SPRITE_MASK_* eventually with | to enable more sprite at once)

*/
.macro SpriteEnable(mask) {
    lda Vic2.SPRITE_ENABLE
    ora #mask
    sta Vic2.SPRITE_ENABLE
}
.assert "SpriteEnable(Vic2.SPRITE_MASK_0 | Vic2.SPRITE_MASK_3 | Vic2.SPRITE_MASK_7)", { SpriteEnable(Vic2.SPRITE_MASK_0 | Vic2.SPRITE_MASK_3 | Vic2.SPRITE_MASK_7) }, {
  lda $D015; ora #%10001001; sta $D015
}

/*
  Disable one or more sprite.

  Params:
  mask - sprite mask (use SPRITE_MASK_* eventually with | to disable more sprite at once)

*/
.macro SpriteDisable(mask) {
    lda Vic2.SPRITE_ENABLE
    and #neg(mask)
    sta Vic2.SPRITE_ENABLE
}
.assert "SpriteDisable(Vic2.SPRITE_MASK_0 | Vic2.SPRITE_MASK_3 | Vic2.SPRITE_MASK_7)", { SpriteDisable(Vic2.SPRITE_MASK_0 | Vic2.SPRITE_MASK_3 | Vic2.SPRITE_MASK_7) }, {
  lda $D015; and #%01110110; sta $D015
}

/*
  Enable multicolor setting for one or more sprite.

  Params:
  mask - sprite mask (use SPRITE_MASK_* eventually with | to enable setting for more sprite at once)

*/
.macro SpriteEnableMulticolor(mask) {
    lda Vic2.SPRITE_COL_MODE
    ora #mask
    sta Vic2.SPRITE_COL_MODE
}
.assert "SpriteEnableMulticolor(Vic2.SPRITE_MASK_0 | Vic2.SPRITE_MASK_3 | Vic2.SPRITE_MASK_7)", { SpriteEnableMulticolor(Vic2.SPRITE_MASK_0 | Vic2.SPRITE_MASK_3 | Vic2.SPRITE_MASK_7) }, {
  lda $D01C; ora #%10001001; sta $D01C
}

/*
  Disable multicolor setting for one or more sprite.

  Params:
  mask - sprite mask (use SPRITE_MASK_* eventually with | to disable setting for more sprite at once)

*/
.macro SpriteDisableMulticolor(mask) {
    lda Vic2.SPRITE_COL_MODE
    and #neg(mask)
    sta Vic2.SPRITE_COL_MODE
}
.assert "SpriteDisableMulticolor(Vic2.SPRITE_MASK_0 | Vic2.SPRITE_MASK_3 | Vic2.SPRITE_MASK_7)", { SpriteDisableMulticolor(Vic2.SPRITE_MASK_0 | Vic2.SPRITE_MASK_3 | Vic2.SPRITE_MASK_7) }, {
  lda $D01C; and #%01110110; sta $D01C
}

/*
  Set main color for a sprite

  Params:
  spriteNo - sprite number (from 0 to 7)
  color - color to set

*/
.macro SpriteColor(spriteNo, color) {
    lda #color
    sta Vic2.SPRITE_0_COLOR + spriteNo
}
.assert "SpriteColor(2, WHITE)", { SpriteColor(2, WHITE) }, {
  lda #1; sta $D029
}

/*
  Set sprite multi color 0

  Params:
  color - color to set

*/
.macro SpriteMultiColor0(color) {
    lda #color
    sta Vic2.SPRITE_COL_0
}
.assert "SpriteMultiColor0(WHITE)", { SpriteMultiColor0(WHITE) }, {
  lda #1; sta $D025
}

/*
  Set sprite multi color 1

  Params:
  color - color to set

*/
.macro SpriteMultiColor1(color) {
    lda #color
    sta Vic2.SPRITE_COL_1
}
.assert "SpriteMultiColor1(WHITE)", { SpriteMultiColor1(WHITE) }, {
  lda #1; sta $D026
}

.macro sh(data) {
  .assert "Hires sprite line length must be 24", data.size(), 24
  .byte convertHires(data.substring(0, 8)), convertHires(data.substring(8, 16)), convertHires(data.substring(16,24))
}

.macro sm(data) {
  .assert "Multicolor sprite line length must be 12", data.size(), 12
  .byte convertMultic(data.substring(0, 4)), convertMultic(data.substring(4, 8)), convertMultic(data.substring(8,12))
}
