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
;src/Textures.c:19: void uncompress_texture(u8* texture, u8* position, u8 sizeX, u8 sizeY){
;	---------------------------------
; Function uncompress_texture
; ---------------------------------
_uncompress_texture::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-8
	add	hl,sp
	ld	sp,hl
;src/Textures.c:20: u8 p1, p2, tex_height=sizeY, tex_width = sizeX;
	ld	a,9 (ix)
	ld	-6 (ix),a
	ld	c,8 (ix)
;src/Textures.c:26: while(sizeX){
	ld	-5 (ix),c
	ld	e,6 (ix)
	ld	d,7 (ix)
00104$:
	ld	a,-5 (ix)
	or	a, a
	jp	Z,00107$
;src/Textures.c:28: currPos = position;
	ld	-2 (ix),e
	ld	-1 (ix),d
;src/Textures.c:29: while(sizeY){
	ld	b,9 (ix)
	ld	a,4 (ix)
	ld	-4 (ix),a
	ld	a,5 (ix)
	ld	-3 (ix),a
00101$:
	ld	a,b
	or	a, a
	jr	Z,00113$
;src/Textures.c:30: p1 = (*texture) & g_pixelMask[0];
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	a,(hl)
	ld	hl, #_g_pixelMask + 0
	ld	l,(hl)
	and	a, l
;src/Textures.c:31: p1= p1 | (p1>>1);
	ld	l,a
	srl	a
	or	a, l
;src/Textures.c:32: *currPos = p1;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),a
;src/Textures.c:33: currPos+=tex_width;
	ld	a,-2 (ix)
	add	a, c
	ld	l,a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	h,a
	inc	sp
	inc	sp
	push	hl
;src/Textures.c:35: p2 = (*texture) & g_pixelMask[1];
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	a,(hl)
	ld	hl, #_g_pixelMask + 1
	ld	l,(hl)
	and	a, l
;src/Textures.c:36: p2 = p2 | (p2<<1);
	ld	l,a
	add	a, a
	or	a, l
;src/Textures.c:37: *currPos = p2;
	pop	hl
	push	hl
	ld	(hl),a
;src/Textures.c:38: currPos+=tex_width;
	ld	a,-8 (ix)
	add	a, c
	ld	-2 (ix),a
	ld	a,-7 (ix)
	adc	a, #0x00
	ld	-1 (ix),a
;src/Textures.c:39: --sizeY;
	dec	b
;src/Textures.c:40: ++texture;
	inc	-4 (ix)
	jr	NZ,00101$
	inc	-3 (ix)
	jr	00101$
00113$:
	ld	a,-4 (ix)
	ld	4 (ix),a
	ld	a,-3 (ix)
	ld	5 (ix),a
;src/Textures.c:42: --sizeX;
	dec	-5 (ix)
;src/Textures.c:43: sizeY=tex_height;
	ld	a,-6 (ix)
	ld	9 (ix),a
;src/Textures.c:44: ++position;
	inc	de
	jp	00104$
00107$:
	ld	sp, ix
	pop	ix
	ret
_theme_textures:
	.dw _level0_walls_tileset
	.dw _level1_walls_tileset
	.dw _level1_walls_tileset
	.dw _level1_walls_tileset
_enemy_textures:
	.dw _level0_enemies_tileset
	.dw _level0_enemies_tileset
	.dw _level0_enemies_tileset
	.dw _level0_enemies_tileset
;src/Textures.c:49: void uncompress_theme_textures(u8 level){//TODO implement
;	---------------------------------
; Function uncompress_theme_textures
; ---------------------------------
_uncompress_theme_textures::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Textures.c:50: uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_LEVEL_TEXTURES,TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
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
;src/Textures.c:51: uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+1024),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
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
;src/Textures.c:52: uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+2048),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
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
;src/Textures.c:53: uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+3072),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
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
;src/Textures.c:56: void uncompress_enemy_textures(u8 level){
;	---------------------------------
; Function uncompress_enemy_textures
; ---------------------------------
_uncompress_enemy_textures::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Textures.c:57: uncompress_texture(enemy_textures[level][0],(u8*)UNCOMPRESSED_ENEMY_TEXTURES,ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
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
;src/Textures.c:58: uncompress_texture(enemy_textures[level][1],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+576),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
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
;src/Textures.c:59: uncompress_texture(enemy_textures[level][2],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1152),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
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
;src/Textures.c:60: uncompress_texture(enemy_textures[level][3],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1728),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
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
;src/Textures.c:63: void uncompress_item_textures(){
;	---------------------------------
; Function uncompress_item_textures
; ---------------------------------
_uncompress_item_textures::
;src/Textures.c:65: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
