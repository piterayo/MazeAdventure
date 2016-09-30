;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module Textures
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _uncompress_texture
	.globl _theme_textures
	.globl _uncompress_theme_textures
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
;src/Textures.c:12: void uncompress_texture(u8* texture, u8* position){
;	---------------------------------
; Function uncompress_texture
; ---------------------------------
_uncompress_texture::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-6
	add	hl,sp
	ld	sp,hl
;src/Textures.c:19: while(i){
	ld	-3 (ix),#0x20
	ld	e,6 (ix)
	ld	d,7 (ix)
00104$:
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00107$
;src/Textures.c:22: currPos = position;
	ld	-2 (ix),e
	ld	-1 (ix),d
;src/Textures.c:23: while(j){//TEXTURE_HEIGHT_HALF -> 2 pixels per byte of compressed texture
	ld	-4 (ix),#0x10
	ld	c,4 (ix)
	ld	b,5 (ix)
00101$:
	ld	a,-4 (ix)
	or	a, a
	jr	Z,00113$
;src/Textures.c:24: p1 = (*texture) & pixelMask[0];
	ld	a,(bc)
	ld	hl, #_pixelMask + 0
	ld	l,(hl)
	and	a, l
;src/Textures.c:25: p1= p1 | (p1>>1);
	ld	l,a
	srl	a
	or	a, l
;src/Textures.c:26: *currPos = p1;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),a
;src/Textures.c:27: currPos+=TEXTURE_WIDTH;
	ld	a,-2 (ix)
	add	a, #0x20
	ld	-6 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-5 (ix),a
;src/Textures.c:29: p2 = (*texture) & pixelMask[1];
	ld	a,(bc)
	ld	hl, #_pixelMask + 1
	ld	l,(hl)
	and	a, l
;src/Textures.c:30: p2 = p2 | (p2<<1);
	ld	l,a
	add	a, a
	or	a, l
;src/Textures.c:31: *currPos = p2;
	pop	hl
	push	hl
	ld	(hl),a
;src/Textures.c:32: currPos+=TEXTURE_WIDTH;
	ld	a,-6 (ix)
	add	a, #0x20
	ld	-2 (ix),a
	ld	a,-5 (ix)
	adc	a, #0x00
	ld	-1 (ix),a
;src/Textures.c:33: --j;
	dec	-4 (ix)
;src/Textures.c:34: ++texture;
	inc	bc
	jr	00101$
00113$:
	ld	4 (ix),c
	ld	5 (ix),b
;src/Textures.c:36: --i;
	dec	-3 (ix)
;src/Textures.c:37: ++position;
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
;src/Textures.c:42: void uncompress_theme_textures(u8 level){//TODO implement
;	---------------------------------
; Function uncompress_theme_textures
; ---------------------------------
_uncompress_theme_textures::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Textures.c:43: uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_LEVEL_TEXTURES);
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
	ld	hl,#0x0840
	push	hl
	push	de
	call	_uncompress_texture
	pop	af
	pop	af
	pop	bc
;src/Textures.c:44: uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+1024));
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
	ld	hl,#0x0C40
	push	hl
	push	de
	call	_uncompress_texture
	pop	af
	pop	af
	pop	bc
;src/Textures.c:45: uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+2048));
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
	ld	hl,#0x1040
	push	hl
	push	de
	call	_uncompress_texture
	pop	af
	pop	af
;src/Textures.c:46: uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+3072));
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
	ld	hl,#0x1440
	push	hl
	push	bc
	call	_uncompress_texture
	pop	af
	pop	af
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
