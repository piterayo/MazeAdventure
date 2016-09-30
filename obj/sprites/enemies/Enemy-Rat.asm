;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module Enemy_Rat
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _g_tile_Enemy_Rat
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
_g_tile_Enemy_Rat:
	.db #0x45	; 69	'E'
	.db #0x8A	; 138
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x8A	; 138
	.db #0x40	; 64
	.db #0x4D	; 77	'M'
	.db #0x8A	; 138
	.db #0x00	; 0
	.db #0x45	; 69	'E'
	.db #0xCF	; 207
	.db #0xCF	; 207
	.db #0x9F	; 159
	.db #0x2A	; 42
	.db #0x40	; 64
	.db #0x84	; 132
	.db #0x8A	; 138
	.db #0x00	; 0
	.db #0x95	; 149
	.db #0x4D	; 77	'M'
	.db #0x8A	; 138
	.db #0x84	; 132
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x4D	; 77	'M'
	.db #0x6A	; 106	'j'
	.db #0x84	; 132
	.db #0x6F	; 111	'o'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x95	; 149
	.db #0x2E	; 46
	.db #0x48	; 72	'H'
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x84	; 132
	.db #0x1D	; 29
	.db #0x6F	; 111	'o'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x3F	; 63
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x3F	; 63
	.db #0x8A	; 138
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x3F	; 63
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x3F	; 63
	.db #0x8A	; 138
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x95	; 149
	.db #0x0C	; 12
	.db #0xC0	; 192
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0xC0	; 192
	.db #0x0C	; 12
	.db #0x6F	; 111	'o'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x0C	; 12
	.db #0x18	; 24
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0x24	; 36
	.db #0x0C	; 12
	.db #0x4D	; 77	'M'
	.db #0x2A	; 42
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xC4	; 196
	.db #0x0C	; 12
	.db #0x18	; 24
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x24	; 36
	.db #0x0C	; 12
	.db #0xCD	; 205
	.db #0x3F	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0xCC	; 204
	.db #0x8C	; 140
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x4C	; 76	'L'
	.db #0xCC	; 204
	.db #0x80	; 128
	.db #0x3F	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0xC0	; 192
	.db #0x0C	; 12
	.db #0x4C	; 76	'L'
	.db #0x48	; 72	'H'
	.db #0x84	; 132
	.db #0x8C	; 140
	.db #0x0C	; 12
	.db #0xC0	; 192
	.db #0x95	; 149
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x8C	; 140
	.db #0x48	; 72	'H'
	.db #0x84	; 132
	.db #0x4C	; 76	'L'
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x4C	; 76	'L'
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0xC8	; 200
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x8A	; 138
	.db #0x40	; 64
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0xCC	; 204
	.db #0xC8	; 200
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC4	; 196
	.db #0xCC	; 204
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x8A	; 138
	.db #0x40	; 64
	.db #0x0C	; 12
	.db #0x4C	; 76	'L'
	.db #0x48	; 72	'H'
	.db #0x0C	; 12
	.db #0x4C	; 76	'L'
	.db #0x8C	; 140
	.db #0x0C	; 12
	.db #0x84	; 132
	.db #0x8C	; 140
	.db #0x0C	; 12
	.db #0x8A	; 138
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0x84	; 132
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x48	; 72	'H'
	.db #0x84	; 132
	.db #0x4D	; 77	'M'
	.db #0x2A	; 42
	.db #0x00	; 0
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x0C	; 12
	.db #0x4C	; 76	'L'
	.db #0x8C	; 140
	.db #0x0C	; 12
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0xC5	; 197
	.db #0x3F	; 63
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x48	; 72	'H'
	.db #0x4D	; 77	'M'
	.db #0x3F	; 63
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x4C	; 76	'L'
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x8C	; 140
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x4D	; 77	'M'
	.db #0x3F	; 63
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x4C	; 76	'L'
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x8C	; 140
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x4D	; 77	'M'
	.db #0x3F	; 63
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x9F	; 159
	.db #0x3F	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0xCF	; 207
	.db #0x8E	; 142
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x4D	; 77	'M'
	.db #0xCF	; 207
	.db #0x4D	; 77	'M'
	.db #0x3F	; 63
	.db #0x2A	; 42
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x0C	; 12
	.db #0x4D	; 77	'M'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x0C	; 12
	.db #0x9F	; 159
	.db #0x3F	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x0C	; 12
	.db #0x4D	; 77	'M'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x0C	; 12
	.db #0x8A	; 138
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
