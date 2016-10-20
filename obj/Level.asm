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
	.globl _current_level
	.globl _level_palettes
	.globl _level_get_level
	.globl _level_set_level
	.globl _level_init_palettes
	.globl _level_load_level
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_current_level::
	.ds 1
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
;src/Level.c:19: u8 level_get_level(){
;	---------------------------------
; Function level_get_level
; ---------------------------------
_level_get_level::
;src/Level.c:20: return current_level;
	ld	iy,#_current_level
	ld	l,0 (iy)
	ret
_level_palettes:
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x03	; 3
	.db #0x05	; 5
	.db #0x0A	; 10
	.db #0x0E	; 14
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x14	; 20
	.db #0x0B	; 11
	.db #0x15	; 21
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x10	; 16
	.db #0x18	; 24
	.db #0x1A	; 26
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x0D	; 13
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x0B	; 11
	.db #0x10	; 16
	.db #0x12	; 18
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
;src/Level.c:23: void level_set_level(u8 l) __z88dk_fastcall{
;	---------------------------------
; Function level_set_level
; ---------------------------------
_level_set_level::
	ld	iy,#_current_level
	ld	0 (iy),l
;src/Level.c:24: current_level=l;
	ret
;src/Level.c:27: void level_init_palettes(){
;	---------------------------------
; Function level_init_palettes
; ---------------------------------
_level_init_palettes::
;src/Level.c:28: cpct_fw2hw(level_palettes[0],VARIABLE_COLORS);
	ld	hl,#0x0009
	push	hl
	ld	hl,#_level_palettes
	push	hl
	call	_cpct_fw2hw
;src/Level.c:29: cpct_fw2hw(level_palettes[1],VARIABLE_COLORS);
	ld	hl,#0x0009
	push	hl
	ld	hl,#(_level_palettes + 0x0009)
	push	hl
	call	_cpct_fw2hw
;src/Level.c:30: cpct_fw2hw(level_palettes[2],VARIABLE_COLORS);
	ld	hl,#0x0009
	push	hl
	ld	hl,#(_level_palettes + 0x0012)
	push	hl
	call	_cpct_fw2hw
;src/Level.c:31: cpct_fw2hw(level_palettes[3],VARIABLE_COLORS);
	ld	hl,#0x0009
	push	hl
	ld	hl,#(_level_palettes + 0x001b)
	push	hl
	call	_cpct_fw2hw
	ret
;src/Level.c:34: void setLevelPalette(u8 i){
;	---------------------------------
; Function setLevelPalette
; ---------------------------------
_setLevelPalette::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Level.c:35: cpct_memcpy(g_palette+SHARED_COLORS, level_palettes[i],VARIABLE_COLORS);
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
;src/Level.c:36: cpct_setPalette(g_palette,16);
	ld	hl,#0x0010
	push	hl
	ld	hl,#_g_palette
	push	hl
	call	_cpct_setPalette
	pop	ix
	ret
;src/Level.c:39: void level_load_level(){
;	---------------------------------
; Function level_load_level
; ---------------------------------
_level_load_level::
;src/Level.c:42: index =((current_level<8)?0:(
	ld	a,(#_current_level + 0)
	sub	a, #0x08
	jr	NC,00103$
	ld	b,#0x00
	jr	00104$
00103$:
;src/Level.c:43: (current_level<24)?1:(
	ld	a,(#_current_level + 0)
	sub	a, #0x18
	jr	NC,00105$
	ld	b,#0x01
	jr	00106$
00105$:
;src/Level.c:44: (current_level<56)?2:(
	ld	a,(#_current_level + 0)
	sub	a, #0x38
	jr	NC,00107$
	ld	b,#0x02
	jr	00108$
00107$:
;src/Level.c:45: (current_level<120)?3:0
	ld	a,(#_current_level + 0)
	sub	a, #0x78
	jr	NC,00109$
	ld	b,#0x03
	jr	00110$
00109$:
	ld	b,#0x00
00110$:
00108$:
00106$:
00104$:
;src/Level.c:48: uncompress_theme_textures(index);
	push	bc
	ld	l,b
	call	_uncompress_theme_textures
	pop	bc
;src/Level.c:49: uncompress_enemy_textures(index);
	push	bc
	ld	l,b
	call	_uncompress_enemy_textures
	inc	sp
	call	_setLevelPalette
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
