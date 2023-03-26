#importonce

#import "sprites.asm"

.filenamespace c128lib

.macro @c128lib_SetSpriteXPosition(spriteNo, x) { SetSpriteXPosition(spriteNo, x) }
.macro @c128lib_SetSpriteXPositionWithShadow(spriteNo, x) { SetSpriteXPositionWithShadow(spriteNo, x) }
.macro @c128lib_SetSpriteYPosition(spriteNo, y) { SetSpriteYPosition(spriteNo, y) }
.macro @c128lib_SetSpriteYPositionWithShadow(spriteNo, y) { SetSpriteYPositionWithShadow(spriteNo, y) }
.macro @c128lib_SetSpritePosition(spriteNo, x, y) { SetSpritePosition(spriteNo, x, y) }
.macro @c128lib_SetSpritePositionWithShadow(spriteNo, x, y) { SetSpritePositionWithShadow(spriteNo, x, y) }
.macro @c128lib_SpriteMove(spriteNo, speed, quadrant, deltaX, deltaY) { SpriteMove(spriteNo, speed, quadrant, deltaX, deltaY) }
.macro @c128lib_SpriteEnable(mask) { SpriteEnable(mask) }
.macro @c128lib_SpriteDisable(mask) { SpriteDisable(mask) }
.macro @c128lib_SpriteEnableMulticolor(mask) { SpriteEnableMulticolor(mask) }
.macro @c128lib_SpriteDisableMulticolor(mask) { SpriteDisableMulticolor(mask) }
.macro @c128lib_SpriteColor(spriteNo, color) { SpriteColor(spriteNo, color) }
.macro @c128lib_SpriteMultiColor0(color) { SpriteMultiColor0(color) }
.macro @c128lib_SpriteMultiColor1(color) { SpriteMultiColor1(color) }

.macro @c128lib_sh(data) { sh(data) }
.macro @c128lib_sm(data) { sm(data) }
