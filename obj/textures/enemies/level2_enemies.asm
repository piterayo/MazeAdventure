;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module level2_enemies
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _level2_enemies
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
_level2_enemies:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xB0	; 176
	.db #0x1D	; 29
	.db #0xE0	; 224
	.db #0x2D	; 45
	.db #0x30	; 48	'0'
	.db #0x1D	; 29
	.db #0xD0	; 208
	.db #0x0D	; 13
	.db #0x00	; 0
	.db #0x1D	; 29
	.db #0x50	; 80	'P'
	.db #0x0D	; 13
	.db #0xF0	; 240
	.db #0x90	; 144
	.db #0x2D	; 45
	.db #0xF0	; 240
	.db #0x40	; 64
	.db #0x1D	; 29
	.db #0x00	; 0
	.db #0x0D	; 13
	.db #0x80	; 128
	.db #0x3D	; 61
	.db #0xF0	; 240
	.db #0x20	; 32
	.db #0x0D	; 13
	.db #0x33	; 51	'3'
	.db #0x1D	; 29
	.db #0x10	; 16
	.db #0x0D	; 13
	.db #0xC0	; 192
	.db #0x0D	; 13
	.db #0x13	; 19
	.db #0x1C	; 28
	.db #0x23	; 35
	.db #0x1D	; 29
	.db #0x03	; 3
	.db #0x0D	; 13
	.db #0xA0	; 160
	.db #0x0D	; 13
	.db #0x13	; 19
	.db #0x0C	; 12
	.db #0x04	; 4
	.db #0x23	; 35
	.db #0x11	; 17
	.db #0x13	; 19
	.db #0x0D	; 13
	.db #0xA0	; 160
	.db #0x0D	; 13
	.db #0x33	; 51	'3'
	.db #0x01	; 1
	.db #0x23	; 35
	.db #0x11	; 17
	.db #0x03	; 3
	.db #0x0D	; 13
	.db #0x40	; 64
	.db #0x0D	; 13
	.db #0x40	; 64
	.db #0x0D	; 13
	.db #0x63	; 99	'c'
	.db #0x11	; 17
	.db #0x13	; 19
	.db #0x0D	; 13
	.db #0x30	; 48	'0'
	.db #0x1D	; 29
	.db #0x40	; 64
	.db #0x0D	; 13
	.db #0x13	; 19
	.db #0x0C	; 12
	.db #0x04	; 4
	.db #0x33	; 51	'3'
	.db #0x11	; 17
	.db #0x03	; 3
	.db #0x0D	; 13
	.db #0xA0	; 160
	.db #0x0D	; 13
	.db #0x23	; 35
	.db #0x1C	; 28
	.db #0x13	; 19
	.db #0x11	; 17
	.db #0x03	; 3
	.db #0x0D	; 13
	.db #0xC0	; 192
	.db #0x0D	; 13
	.db #0x43	; 67	'C'
	.db #0x0D	; 13
	.db #0x13	; 19
	.db #0x0D	; 13
	.db #0xE0	; 224
	.db #0x1D	; 29
	.db #0x13	; 19
	.db #0x0D	; 13
	.db #0x00	; 0
	.db #0x1D	; 29
	.db #0x30	; 48	'0'
	.db #0x1D	; 29
	.db #0xB0	; 176
	.db #0x1D	; 29
	.db #0x70	; 112	'p'
	.db #0x1D	; 29
	.db #0xF0	; 240
	.db #0x60	; 96
	.db #0x0D	; 13
	.db #0xF0	; 240
	.db #0x70	; 112	'p'
	.db #0x0D	; 13
	.db #0x50	; 80	'P'
	.db #0x0D	; 13
	.db #0x10	; 16
	.db #0x1D	; 29
	.db #0x30	; 48	'0'
	.db #0x0D	; 13
	.db #0xE0	; 224
	.db #0x3D	; 61
	.db #0x40	; 64
	.db #0x1D	; 29
	.db #0xF0	; 240
	.db #0x50	; 80	'P'
	.db #0x1D	; 29
	.db #0xF0	; 240
	.db #0xF0	; 240
	.area _INITIALIZER
	.area _CABS (ABS)
