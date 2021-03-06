;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module compass
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _compass_compass_3
	.globl _compass_compass_2
	.globl _compass_compass_1
	.globl _compass_compass_0
	.globl _compass_tileset
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
_compass_tileset:
	.dw _compass_compass_0
	.dw _compass_compass_1
	.dw _compass_compass_2
	.dw _compass_compass_3
_compass_compass_0:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x8C	; 140
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x4C	; 76	'L'
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x8C	; 140
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x4C	; 76	'L'
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0xC8	; 200
	.db #0xC4	; 196
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC8	; 200
	.db #0x8C	; 140
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x4C	; 76	'L'
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x8C	; 140
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x4C	; 76	'L'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x60	; 96
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x8C	; 140
	.db #0xC4	; 196
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC8	; 200
	.db #0x84	; 132
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0x60	; 96
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0x4C	; 76	'L'
	.db #0xC8	; 200
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0xC4	; 196
	.db #0x8C	; 140
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x4C	; 76	'L'
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x8C	; 140
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
_compass_compass_1:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x8C	; 140
	.db #0x4C	; 76	'L'
	.db #0x8C	; 140
	.db #0x4C	; 76	'L'
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x8C	; 140
	.db #0x48	; 72	'H'
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0x84	; 132
	.db #0x4C	; 76	'L'
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0xC8	; 200
	.db #0xC4	; 196
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC8	; 200
	.db #0x8C	; 140
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x4C	; 76	'L'
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
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
	.db #0x60	; 96
	.db #0x90	; 144
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x30	; 48	'0'
	.db #0x90	; 144
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x4C	; 76	'L'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x30	; 48	'0'
	.db #0x90	; 144
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x8C	; 140
	.db #0xC4	; 196
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x60	; 96
	.db #0x30	; 48	'0'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC8	; 200
	.db #0x84	; 132
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0x60	; 96
	.db #0x30	; 48	'0'
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0x4C	; 76	'L'
	.db #0xC8	; 200
	.db #0x60	; 96
	.db #0x90	; 144
	.db #0xC4	; 196
	.db #0x8C	; 140
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x4C	; 76	'L'
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x8C	; 140
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
_compass_compass_2:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x8C	; 140
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x4C	; 76	'L'
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x8C	; 140
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x4C	; 76	'L'
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0xC8	; 200
	.db #0xC4	; 196
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC8	; 200
	.db #0x8C	; 140
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x4C	; 76	'L'
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x4C	; 76	'L'
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0x90	; 144
	.db #0xC0	; 192
	.db #0x90	; 144
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x4C	; 76	'L'
	.db #0xC0	; 192
	.db #0x90	; 144
	.db #0xC0	; 192
	.db #0x90	; 144
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x8C	; 140
	.db #0xC4	; 196
	.db #0xC0	; 192
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC8	; 200
	.db #0x84	; 132
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0x4C	; 76	'L'
	.db #0xC8	; 200
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0xC4	; 196
	.db #0x8C	; 140
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x4C	; 76	'L'
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x8C	; 140
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
_compass_compass_3:
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x8C	; 140
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x4C	; 76	'L'
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x8C	; 140
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x4C	; 76	'L'
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0xC8	; 200
	.db #0xC4	; 196
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC8	; 200
	.db #0x8C	; 140
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x4C	; 76	'L'
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x64	; 100	'd'
	.db #0x98	; 152
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x4C	; 76	'L'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x64	; 100	'd'
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x8C	; 140
	.db #0xC4	; 196
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x64	; 100	'd'
	.db #0x98	; 152
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC8	; 200
	.db #0x84	; 132
	.db #0xC8	; 200
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x98	; 152
	.db #0xC0	; 192
	.db #0xC4	; 196
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0x4C	; 76	'L'
	.db #0xC8	; 200
	.db #0x64	; 100	'd'
	.db #0x98	; 152
	.db #0xC4	; 196
	.db #0x8C	; 140
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x4C	; 76	'L'
	.db #0xCC	; 204
	.db #0xCC	; 204
	.db #0x8C	; 140
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0xC0	; 192
	.db #0x84	; 132
	.db #0x0C	; 12
	.db #0x0C	; 12
	.db #0x48	; 72	'H'
	.db #0xC0	; 192
	.db #0xC0	; 192
	.area _INITIALIZER
	.area _CABS (ABS)
