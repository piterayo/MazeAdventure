;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module UI_Compass
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _cpct_drawSprite
	.globl _renderCompass
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
;src/UI_Compass.c:6: void renderCompass(){
;	---------------------------------
; Function renderCompass
; ---------------------------------
_renderCompass::
;src/UI_Compass.c:7: cpct_drawSprite(compass_tileset[PLAYER_directionIndex/2],COMPASS_POSITION,8,16);
	ld	bc,#_compass_tileset+0
	ld	iy,#_PLAYER_directionIndex
	ld	l,0 (iy)
	srl	l
	ld	h,#0x00
	add	hl, hl
	add	hl,bc
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	hl,#0x1008
	push	hl
	ld	hl,#0xC024
	push	hl
	push	bc
	call	_cpct_drawSprite
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
