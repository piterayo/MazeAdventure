;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module Textures
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _uncompress_item_textures
	.globl _uncompress_texture
	.globl _enemy_textures
	.globl _theme_textures
	.globl _uncompress_theme_textures
	.globl _uncompress_enemy_textures
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/Textures.c:17: void uncompress_texture(u8* texture, u8* position, u8 sizeX, u8 sizeY){
;	---------------------------------
; Function uncompress_texture
; ---------------------------------
_uncompress_texture::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-7
	add	hl,sp
	ld	sp,hl
;src/Textures.c:18: u8 p1, p2, tex_height=sizeY;
	ld	a,9 (ix)
	ld	-5 (ix),a
;src/Textures.c:24: while(sizeX){
	ld	a,8 (ix)
	ld	-4 (ix),a
	ld	e,6 (ix)
	ld	d,7 (ix)
00104$:
	ld	a,-4 (ix)
	or	a, a
	jr	Z,00107$
;src/Textures.c:26: currPos = position;
	ld	-3 (ix),e
	ld	-2 (ix),d
;src/Textures.c:27: while(sizeY){
	ld	a,9 (ix)
	ld	-1 (ix),a
	ld	c,4 (ix)
	ld	b,5 (ix)
00101$:
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00113$
;src/Textures.c:28: p1 = (*texture) & pixelMask[0];
	ld	a,(bc)
	ld	hl, #_pixelMask + 0
	ld	l,(hl)
	and	a, l
;src/Textures.c:29: p1= p1 | (p1>>1);
	ld	l,a
	srl	a
	or	a, l
;src/Textures.c:30: *currPos = p1;
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	(hl),a
;src/Textures.c:31: currPos+=TEXTURE_WIDTH;
	ld	a,-3 (ix)
	add	a, #0x20
	ld	-7 (ix),a
	ld	a,-2 (ix)
	adc	a, #0x00
	ld	-6 (ix),a
;src/Textures.c:33: p2 = (*texture) & pixelMask[1];
	ld	a,(bc)
	ld	hl, #_pixelMask + 1
	ld	l,(hl)
	and	a, l
;src/Textures.c:34: p2 = p2 | (p2<<1);
	ld	l,a
	add	a, a
	or	a, l
;src/Textures.c:35: *currPos = p2;
	pop	hl
	push	hl
	ld	(hl),a
;src/Textures.c:36: currPos+=TEXTURE_WIDTH;
	ld	a,-7 (ix)
	add	a, #0x20
	ld	-3 (ix),a
	ld	a,-6 (ix)
	adc	a, #0x00
	ld	-2 (ix),a
;src/Textures.c:37: --sizeY;
	dec	-1 (ix)
;src/Textures.c:38: ++texture;
	inc	bc
	jr	00101$
00113$:
	ld	4 (ix),c
	ld	5 (ix),b
;src/Textures.c:40: --sizeX;
	dec	-4 (ix)
;src/Textures.c:41: sizeY=tex_height;
	ld	a,-5 (ix)
	ld	9 (ix),a
;src/Textures.c:42: ++position;
	inc	de
	jr	00104$
00107$:
	ld	sp, ix
	pop	ix
	ret
_theme_textures:
	.dw _g_tile_walls_0
	.dw _g_tile_walls_0
	.dw _g_tile_walls_0
	.dw _g_tile_walls_0
_enemy_textures:
	.dw _level0_enemies_tileset
	.dw _level0_enemies_tileset
	.dw _level0_enemies_tileset
	.dw _level0_enemies_tileset
;src/Textures.c:47: void uncompress_theme_textures(u8 level){//TODO implement
;	---------------------------------
; Function uncompress_theme_textures
; ---------------------------------
_uncompress_theme_textures::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Textures.c:48: uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_LEVEL_TEXTURES,TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
	ld	bc,#_theme_textures+0
	ld	l,4 (ix)
	ld	h,#0x00
	add	hl, hl
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	e,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, e
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	bc
	ld	hl,#0x1020
	push	hl
	ld	hl,#0x0840
	push	hl
	push	de
	call	_uncompress_texture
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	bc
;src/Textures.c:49: uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+1024),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
	ld	l, c
	ld	h, b
	ld	e,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, e
	inc	hl
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	bc
	ld	hl,#0x1020
	push	hl
	ld	hl,#0x0C40
	push	hl
	push	de
	call	_uncompress_texture
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	bc
;src/Textures.c:50: uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+2048),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
	ld	l, c
	ld	h, b
	ld	e,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, e
	ld	de, #0x0004
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	bc
	ld	hl,#0x1020
	push	hl
	ld	l, #0x40
	push	hl
	push	de
	call	_uncompress_texture
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;src/Textures.c:51: uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+3072),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
	pop	hl
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, c
	ld	de, #0x0006
	add	hl, de
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	hl,#0x1020
	push	hl
	ld	hl,#0x1440
	push	hl
	push	bc
	call	_uncompress_texture
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	ix
	ret
;src/Textures.c:54: void uncompress_enemy_textures(u8 level){
;	---------------------------------
; Function uncompress_enemy_textures
; ---------------------------------
_uncompress_enemy_textures::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Textures.c:55: uncompress_texture(enemy_textures[level][0],(u8*)UNCOMPRESSED_ENEMY_TEXTURES,ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
	ld	bc,#_enemy_textures+0
	ld	l,4 (ix)
	ld	h,#0x00
	add	hl, hl
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	e,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, e
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	bc
	ld	hl,#0x0C18
	push	hl
	ld	hl,#0x1840
	push	hl
	push	de
	call	_uncompress_texture
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	bc
;src/Textures.c:56: uncompress_texture(enemy_textures[level][1],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+576),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
	ld	l, c
	ld	h, b
	ld	e,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, e
	inc	hl
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	bc
	ld	hl,#0x0C18
	push	hl
	ld	hl,#0x1A80
	push	hl
	push	de
	call	_uncompress_texture
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	bc
;src/Textures.c:57: uncompress_texture(enemy_textures[level][2],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1152),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
	ld	l, c
	ld	h, b
	ld	e,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, e
	ld	de, #0x0004
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	bc
	ld	hl,#0x0C18
	push	hl
	ld	hl,#0x1CC0
	push	hl
	push	de
	call	_uncompress_texture
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;src/Textures.c:58: uncompress_texture(enemy_textures[level][3],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1728),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
	pop	hl
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, c
	ld	de, #0x0006
	add	hl, de
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	hl,#0x0C18
	push	hl
	ld	hl,#0x1F00
	push	hl
	push	bc
	call	_uncompress_texture
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	ix
	ret
;src/Textures.c:61: void uncompress_item_textures(){
;	---------------------------------
; Function uncompress_item_textures
; ---------------------------------
_uncompress_item_textures::
;src/Textures.c:63: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
