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
	.globl _uncompress_texture_rle
	.globl _enemy_textures_length
	.globl _enemy_textures
	.globl _theme_textures_length
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
;src/Textures.c:40: void uncompress_texture_rle(u8* position, u8* texture_set, u16 length){
;	---------------------------------
; Function uncompress_texture_rle
; ---------------------------------
_uncompress_texture_rle::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/Textures.c:43: while(length){
	ld	c,6 (ix)
	ld	b,7 (ix)
	ld	e,8 (ix)
	ld	d,9 (ix)
00104$:
	ld	a,d
	or	a,e
	jr	Z,00107$
;src/Textures.c:44: value = (*texture_set)&0x0F;
	ld	a,(bc)
	ld	h,a
	and	a, #0x0F
	ld	l,a
;src/Textures.c:45: counter = ((*texture_set)>>4)+1;
	ld	a,h
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0F
	inc	a
	ld	-1 (ix),a
;src/Textures.c:46: while(counter){
	ld	a,#<(_g_colors)
	add	a, l
	ld	l,a
	ld	a,#>(_g_colors)
	adc	a, #0x00
	ld	h,a
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	pop	iy
	pop	hl
00101$:
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00113$
;src/Textures.c:47: *position=g_colors[value];
	ld	a,(hl)
	ld	0 (iy), a
;src/Textures.c:48: ++position;
	inc	iy
;src/Textures.c:49: --counter;
	dec	-1 (ix)
	jr	00101$
00113$:
	push	iy
	pop	af
	ld	5 (ix),a
	push	iy
	dec	sp
	pop	af
	inc	sp
	ld	4 (ix),a
;src/Textures.c:51: ++texture_set;
	inc	bc
;src/Textures.c:52: --length;
	dec	de
	jr	00104$
00107$:
	inc	sp
	pop	ix
	ret
_theme_textures:
	.dw _level0_walls
	.dw _level1_walls
	.dw _level2_walls
	.dw _level3_walls
_theme_textures_length:
	.dw #0x05BD
	.dw #0x0855
	.dw #0x082E
	.dw #0x06F7
_enemy_textures:
	.dw _level0_enemies
	.dw _level1_enemies
	.dw _level2_enemies
	.dw _level3_enemies
	.dw _king_enemy
_enemy_textures_length:
	.dw #0x0084
	.dw #0x00AB
	.dw #0x007B
	.dw #0x00B7
	.dw #0x00B8
;src/Textures.c:56: void uncompress_theme_textures(u8 level) {//TODO implement
;	---------------------------------
; Function uncompress_theme_textures
; ---------------------------------
_uncompress_theme_textures::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Textures.c:57: uncompress_texture_rle((u8*)UNCOMPRESSED_TEXTURES, theme_textures[level], theme_textures_length[level]);    
	ld	l,4 (ix)
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl,#_theme_textures_length
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#_theme_textures+0
	add	hl,bc
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	push	de
	push	bc
	ld	hl,#0x8CD0
	push	hl
	call	_uncompress_texture_rle
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	ix
	ret
;src/Textures.c:61: void uncompress_enemy_textures(u8 level) {
;	---------------------------------
; Function uncompress_enemy_textures
; ---------------------------------
_uncompress_enemy_textures::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Textures.c:62: if(camelot_warriors_mode){
	ld	a,(#_camelot_warriors_mode + 0)
	or	a, a
	jr	Z,00102$
;src/Textures.c:63: uncompress_texture_rle((u8*)UNCOMPRESSED_RAT_TEXTURE,camelot_enemy,camelot_enemy_LENGTH);
	ld	hl,#0x007B
	push	hl
	ld	hl,#_camelot_enemy
	push	hl
	ld	hl,#0xA0D0
	push	hl
	call	_uncompress_texture_rle
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;src/Textures.c:64: uncompress_texture_rle((u8*)UNCOMPRESSED_ENEMY_TEXTURE,camelot_enemy,camelot_enemy_LENGTH);
	ld	hl,#0x007B
	push	hl
	ld	hl,#_camelot_enemy
	push	hl
	ld	hl,#0xA310
	push	hl
	call	_uncompress_texture_rle
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	jr	00104$
00102$:
;src/Textures.c:67: uncompress_texture_rle((u8*)UNCOMPRESSED_RAT_TEXTURE,rat_enemy,rat_enemy_LENGTH);
	ld	hl,#0x006C
	push	hl
	ld	hl,#_rat_enemy
	push	hl
	ld	hl,#0xA0D0
	push	hl
	call	_uncompress_texture_rle
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;src/Textures.c:68: uncompress_texture_rle((u8*)UNCOMPRESSED_ENEMY_TEXTURE,enemy_textures[level],enemy_textures_length[level]);
	ld	l,4 (ix)
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl,#_enemy_textures_length
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#_enemy_textures+0
	add	hl,bc
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	push	de
	push	bc
	ld	hl,#0xA310
	push	hl
	call	_uncompress_texture_rle
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
00104$:
	pop	ix
	ret
;src/Textures.c:72: void uncompress_item_textures(){
;	---------------------------------
; Function uncompress_item_textures
; ---------------------------------
_uncompress_item_textures::
;src/Textures.c:73: uncompress_texture_rle((u8*)UNCOMPRESSED_OBJECT_TEXTURES, items_tileset, items_tileset_LENGTH);
	ld	hl,#0x014A
	push	hl
	ld	hl,#_items_tileset
	push	hl
	ld	hl,#0xA550
	push	hl
	call	_uncompress_texture_rle
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
