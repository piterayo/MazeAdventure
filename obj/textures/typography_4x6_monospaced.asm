;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module typography_4x6_monospaced
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _typography_4x6_monospaced
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
_typography_4x6_monospaced:
	.db #0x4C	; 76	'L'
	.db #0x4C	; 76	'L'
	.db #0xEE	; 238
	.db #0x4A	; 74	'J'
	.db #0x4E	; 78	'N'
	.db #0xA8	; 168
	.db #0xAA	; 170
	.db #0x4C	; 76	'L'
	.db #0x4C	; 76	'L'
	.db #0x6E	; 110	'n'
	.db #0xAA	; 170
	.db #0xAA	; 170
	.db #0xAE	; 174
	.db #0xE4	; 228
	.db #0x4C	; 76	'L'
	.db #0x8E	; 142
	.db #0x6E	; 110	'n'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0xAA	; 170
	.db #0xAA	; 170
	.db #0x88	; 136
	.db #0xAA	; 170
	.db #0x42	; 66	'B'
	.db #0xA8	; 168
	.db #0xEA	; 234
	.db #0xAA	; 170
	.db #0xAA	; 170
	.db #0x84	; 132
	.db #0xAA	; 170
	.db #0xAA	; 170
	.db #0xA2	; 162
	.db #0xAC	; 172
	.db #0xA2	; 162
	.db #0x88	; 136
	.db #0x82	; 130
	.db #0xAA	; 170
	.db #0x4A	; 74	'J'
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0xAC	; 172
	.db #0x8A	; 138
	.db #0x88	; 136
	.db #0x8A	; 138
	.db #0x42	; 66	'B'
	.db #0xA8	; 168
	.db #0xEE	; 238
	.db #0xAA	; 170
	.db #0xAA	; 170
	.db #0x84	; 132
	.db #0xAA	; 170
	.db #0xA4	; 164
	.db #0xA4	; 164
	.db #0xA4	; 164
	.db #0x24	; 36
	.db #0xAC	; 172
	.db #0xC4	; 196
	.db #0x4A	; 74	'J'
	.db #0x42	; 66	'B'
	.db #0x04	; 4
	.db #0xB0	; 176
	.db #0xAA	; 170
	.db #0x8A	; 138
	.db #0xCC	; 204
	.db #0xAE	; 174
	.db #0x42	; 66	'B'
	.db #0xC8	; 200
	.db #0xAE	; 174
	.db #0xAC	; 172
	.db #0xAC	; 172
	.db #0x44	; 68	'D'
	.db #0xAA	; 170
	.db #0xA4	; 164
	.db #0x44	; 68	'D'
	.db #0xA4	; 164
	.db #0x42	; 66	'B'
	.db #0xE2	; 226
	.db #0xA4	; 164
	.db #0xA6	; 166
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0xD0	; 208
	.db #0xEA	; 234
	.db #0xAA	; 170
	.db #0x88	; 136
	.db #0xAA	; 170
	.db #0x4A	; 74	'J'
	.db #0xA8	; 168
	.db #0xAA	; 170
	.db #0xA8	; 168
	.db #0xCA	; 202
	.db #0x24	; 36
	.db #0xA4	; 164
	.db #0x4A	; 74	'J'
	.db #0x48	; 72	'H'
	.db #0xA4	; 164
	.db #0x82	; 130
	.db #0x22	; 34
	.db #0xA8	; 168
	.db #0xA2	; 162
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xA0	; 160
	.db #0xAE	; 174
	.db #0x4C	; 76	'L'
	.db #0xE8	; 232
	.db #0xEA	; 234
	.db #0x44	; 68	'D'
	.db #0xAE	; 174
	.db #0xAA	; 170
	.db #0x48	; 72	'H'
	.db #0x2A	; 42
	.db #0xC4	; 196
	.db #0x44	; 68	'D'
	.db #0xAA	; 170
	.db #0x4E	; 78	'N'
	.db #0xEE	; 238
	.db #0xEC	; 236
	.db #0x2C	; 44
	.db #0x48	; 72	'H'
	.db #0x4C	; 76	'L'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x70	; 112	'p'
	.area _INITIALIZER
	.area _CABS (ABS)
