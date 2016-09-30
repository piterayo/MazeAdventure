;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module compass
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _g_tile_compass_3
	.globl _g_tile_compass_2
	.globl _g_tile_compass_1
	.globl _g_tile_compass_0
	.globl _g_tile_compass
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
_g_tile_compass:
	.dw _g_tile_compass_0
	.dw _g_tile_compass_1
	.dw _g_tile_compass_2
	.dw _g_tile_compass_3
_g_tile_compass_0:
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x0C	; 12
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x0C	; 12
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x26	; 38
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x19	; 25
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x8C	; 140
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x8C	; 140
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x26	; 38
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x19	; 25
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x0C	; 12
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x0C	; 12
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
_g_tile_compass_1:
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x0C	; 12
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0x0C	; 12
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x26	; 38
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x19	; 25
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x26	; 38
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x19	; 25
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x0C	; 12
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x0C	; 12
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
_g_tile_compass_2:
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x0C	; 12
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x0C	; 12
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x26	; 38
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x19	; 25
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x4C	; 76	'L'
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x4C	; 76	'L'
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x26	; 38
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x19	; 25
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x0C	; 12
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x0C	; 12
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
_g_tile_compass_3:
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x0C	; 12
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x0C	; 12
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x26	; 38
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x19	; 25
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x26	; 38
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x19	; 25
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x0C	; 12
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0x0C	; 12
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x48	; 72	'H'
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0x84	; 132
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x26	; 38
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x19	; 25
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.area _INITIALIZER
	.area _CABS (ABS)
