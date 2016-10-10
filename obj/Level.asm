;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module Level
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _setLevelPalette
	.globl _uncompress_enemy_textures
	.globl _uncompress_theme_textures
	.globl _cpct_setPalette
	.globl _cpct_fw2hw
	.globl _cpct_memcpy
	.globl _level_palettes
	.globl _level_init_palettes
	.globl _level_load_level
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
;src/Level.c:14: void level_init_palettes(){
;	---------------------------------
; Function level_init_palettes
; ---------------------------------
_level_init_palettes::
;src/Level.c:15: cpct_fw2hw(level_palettes[0],9);
	ld	hl,#0x0009
	push	hl
	ld	hl,#_level_palettes
	push	hl
	call	_cpct_fw2hw
;src/Level.c:16: cpct_fw2hw(level_palettes[1],9);
	ld	hl,#0x0009
	push	hl
	ld	hl,#(_level_palettes + 0x0009)
	push	hl
	call	_cpct_fw2hw
;src/Level.c:17: cpct_fw2hw(level_palettes[2],9);
	ld	hl,#0x0009
	push	hl
	ld	hl,#(_level_palettes + 0x0012)
	push	hl
	call	_cpct_fw2hw
;src/Level.c:18: cpct_fw2hw(level_palettes[3],9);
	ld	hl,#0x0009
	push	hl
	ld	hl,#(_level_palettes + 0x001b)
	push	hl
	call	_cpct_fw2hw
	ret
_level_palettes:
	.db #0x05	; 5
	.db #0x0A	; 10
	.db #0x11	; 17
	.db #0x0E	; 14
	.db #0x0C	; 12
	.db #0x09	; 9
	.db #0x0F	; 15
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x14	; 20
	.db #0x13	; 19
	.db #0x11	; 17
	.db #0x0E	; 14
	.db #0x12	; 18
	.db #0x09	; 9
	.db #0x0F	; 15
	.db #0x03	; 3
	.db #0x0A	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
;src/Level.c:21: void setLevelPalette(u8 i){
;	---------------------------------
; Function setLevelPalette
; ---------------------------------
_setLevelPalette::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Level.c:22: cpct_memcpy(g_palette+7, level_palettes[i],9);
	ld	bc,#_level_palettes+0
	ld	e,4 (ix)
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	hl,#0x0009
	push	hl
	push	bc
	ld	hl,#(_g_palette + 0x0007)
	push	hl
	call	_cpct_memcpy
;src/Level.c:23: cpct_setPalette(g_palette,16);
	ld	hl,#0x0010
	push	hl
	ld	hl,#_g_palette
	push	hl
	call	_cpct_setPalette
	pop	ix
	ret
;src/Level.c:26: void level_load_level(u8 l){
;	---------------------------------
; Function level_load_level
; ---------------------------------
_level_load_level::
;src/Level.c:29: index =((l<8)?0:(
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x08
	jr	NC,00103$
	ld	b,#0x00
	jr	00104$
00103$:
;src/Level.c:30: (l<24)?1:(
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x18
	jr	NC,00105$
	ld	b,#0x01
	jr	00106$
00105$:
;src/Level.c:31: (l<56)?2:(
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x38
	jr	NC,00107$
	ld	b,#0x02
	jr	00108$
00107$:
;src/Level.c:32: (l<120)?4:0
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x78
	jr	NC,00109$
	ld	b,#0x04
	jr	00110$
00109$:
	ld	b,#0x00
00110$:
00108$:
00106$:
00104$:
;src/Level.c:35: uncompress_theme_textures(index);
	push	bc
	push	bc
	inc	sp
	call	_uncompress_theme_textures
	inc	sp
	pop	bc
;src/Level.c:36: uncompress_enemy_textures(index);
	push	bc
	push	bc
	inc	sp
	call	_uncompress_enemy_textures
	inc	sp
	inc	sp
	call	_setLevelPalette
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
