;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module Player
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _PLAYER_directionArray
	.globl _PLAYER_directionIndex
	.globl _PLAYER_direction
	.globl _PLAYER_position
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
	.area _CODE
_PLAYER_position:
	.db #0x01	; 1
	.db #0x01	; 1
_PLAYER_direction:
	.db #0x01	;  1
	.db #0x00	;  0
_PLAYER_directionIndex:
	.db #0x00	; 0
_PLAYER_directionArray:
	.db #0x01	;  1
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0xFF	; -1
	.db #0xFF	; -1
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x01	;  1
	.area _INITIALIZER
	.area _CABS (ABS)
