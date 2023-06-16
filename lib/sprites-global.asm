/**
  @file sprites-global.asm
  @brief Sprites module

  @copyright MIT Licensed
  @date 2022
*/

#importonce

#import "sprites.asm"

.filenamespace c128lib

/**
  Sets X position of given sprite (uses sprite MSB register if necessary)

  @param[in] spriteNo Number of the sprite to move
  @param[in] x X position of sprite

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SetSpriteXPosition(spriteNo, x) { SetSpriteXPosition(spriteNo, x) }

/**
  Sets X position of given sprite (uses sprite MSB register if necessary)
  using shadow registers

  @param[in] spriteNo Number of the sprite to move
  @param[in] x X position of sprite

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SetSpriteXPositionWithShadow(spriteNo, x) { SetSpriteXPositionWithShadow(spriteNo, x) }

/**
  Sets y position of given sprite

  @param[in] spriteNo Number of the sprite to move
  @param[in] y Y position of sprite

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SetSpriteYPosition(spriteNo, y) { SetSpriteYPosition(spriteNo, y) }

/**
  Sets y position of given sprite using shadow registers

  @param[in] spriteNo Number of the sprite to move
  @param[in] y Y position of sprite

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SetSpriteYPositionWithShadow(spriteNo, y) { SetSpriteYPositionWithShadow(spriteNo, y) }

/**
  Sets x and y position of given sprite

  @param[in] spriteNo Number of the sprite to move
  @param[in] x X position of sprite
  @param[in] y Y position of sprite

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SetSpritePosition(spriteNo, x, y) { SetSpritePosition(spriteNo, x, y) }

/**
  Sets x and y position of given sprite using shadow registers

  @param[in] spriteNo Number of the sprite to move
  @param[in] x X position of sprite
  @param[in] y Y position of sprite

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SetSpritePositionWithShadow(spriteNo, x, y) { SetSpritePositionWithShadow(spriteNo, x, y) }

/**
  Define sprite movement

  @param[in] spriteNo Number of the sprite to set movement
  @param[in] speed Speed of sprite
  @param[in] quadrant Determines main direction of sprite (use SPRITE_MAIN_DIR_* labels)
  @param[in] deltaX move sprite on X each interrupt
  @param[in] deltaY move sprite on Y each interrupt

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SpriteMove(spriteNo, speed, quadrant, deltaX, deltaY) { SpriteMove(spriteNo, speed, quadrant, deltaX, deltaY) }

/**
  Enable one or more sprite.

  @param[in] mask Sprite mask
    (use SPRITE_MASK_* eventually with | to enable more sprite at once)

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SpriteEnable(mask) { SpriteEnable(mask) }

/**
  Disable one or more sprite.

  @param[in] mask Sprite mask
    (use SPRITE_MASK_* eventually with | to disable more sprite at once)

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SpriteDisable(mask) { SpriteDisable(mask) }

/**
  Enable multicolor setting for one or more sprite.

  @param[in] mask Sprite mask
    (use SPRITE_MASK_* eventually with | to set multicolor on more sprite at once)

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SpriteEnableMulticolor(mask) { SpriteEnableMulticolor(mask) }

/**
  Disable multicolor setting for one or more sprite.

  @param[in] mask Sprite mask
    (use SPRITE_MASK_* eventually with | to unset multicolor on more sprite at once)

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SpriteDisableMulticolor(mask) { SpriteDisableMulticolor(mask) }

/**
  Disable multicolor setting for one or more sprite.

  @param[in] spriteNo Number of the sprite to set movement
  @param[in] color Color to set

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SpriteColor(spriteNo, color) { SpriteColor(spriteNo, color) }

/**
  Set sprite multi color 0

  @param[in] color Color to set

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SpriteMultiColor0(color) { SpriteMultiColor0(color) }

/**
  Set sprite multi color 1

  @param[in] color Color to set

  @remark Register .A will be modified.
  Flags N and Z will be affected.

  @since 0.6.0
*/
.macro @c128lib_SpriteMultiColor1(color) { SpriteMultiColor1(color) }

.macro @c128lib_sh(data) { sh(data) }
.macro @c128lib_sm(data) { sm(data) }
