;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module items_tileset
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _items_tileset
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
_items_tileset:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xA0	; 160
	.db #0x23	; 35
	.db #0x10	; 16
	.db #0x16	; 22
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x50	; 80	'P'
	.db #0x03	; 3
	.db #0x16	; 22
	.db #0x13	; 19
	.db #0x10	; 16
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x40	; 64
	.db #0x03	; 3
	.db #0x16	; 22
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x10	; 16
	.db #0x26	; 38
	.db #0x13	; 19
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x26	; 38
	.db #0x10	; 16
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xA6	; 166
	.db #0x10	; 16
	.db #0x16	; 22
	.db #0x90	; 144
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x16	; 22
	.db #0xA0	; 160
	.db #0x46	; 70	'F'
	.db #0xB0	; 176
	.db #0x26	; 38
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xB0	; 176
	.db #0x16	; 22
	.db #0xE0	; 224
	.db #0x06	; 6
	.db #0x40	; 64
	.db #0x93	; 147
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0xA3	; 163
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x10	; 16
	.db #0x93	; 147
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0xB0	; 176
	.db #0x06	; 6
	.db #0xD0	; 208
	.db #0x16	; 22
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x70	; 112	'p'
	.db #0x11	; 17
	.db #0xC0	; 192
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0xA0	; 160
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x12	; 18
	.db #0x01	; 1
	.db #0xA0	; 160
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0x31	; 49	'1'
	.db #0x90	; 144
	.db #0x11	; 17
	.db #0x33	; 51	'3'
	.db #0x21	; 33
	.db #0x50	; 80	'P'
	.db #0x01	; 1
	.db #0x13	; 19
	.db #0x32	; 50	'2'
	.db #0x23	; 35
	.db #0x01	; 1
	.db #0x40	; 64
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x22	; 34
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x50	; 80	'P'
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0x03	; 3
	.db #0x42	; 66	'B'
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x40	; 64
	.db #0x01	; 1
	.db #0x82	; 130
	.db #0x01	; 1
	.db #0x30	; 48	'0'
	.db #0x01	; 1
	.db #0x82	; 130
	.db #0x01	; 1
	.db #0x40	; 64
	.db #0x01	; 1
	.db #0x82	; 130
	.db #0x01	; 1
	.db #0x50	; 80	'P'
	.db #0x11	; 17
	.db #0x32	; 50	'2'
	.db #0x21	; 33
	.db #0x50	; 80	'P'
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0x31	; 49	'1'
	.db #0x80	; 128
	.db #0x01	; 1
	.db #0x22	; 34
	.db #0x01	; 1
	.db #0xB0	; 176
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0x01	; 1
	.db #0xC0	; 192
	.db #0x11	; 17
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x30	; 48	'0'
	.db #0x11	; 17
	.db #0xC0	; 192
	.db #0x01	; 1
	.db #0x14	; 20
	.db #0x01	; 1
	.db #0xA0	; 160
	.db #0x01	; 1
	.db #0x34	; 52	'4'
	.db #0x01	; 1
	.db #0x30	; 48	'0'
	.db #0x11	; 17
	.db #0x20	; 32
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x14	; 20
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x01	; 1
	.db #0x30	; 48	'0'
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x21	; 33
	.db #0x13	; 19
	.db #0x34	; 52	'4'
	.db #0x01	; 1
	.db #0x30	; 48	'0'
	.db #0x01	; 1
	.db #0x53	; 83	'S'
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x14	; 20
	.db #0x01	; 1
	.db #0x30	; 48	'0'
	.db #0x01	; 1
	.db #0x53	; 83	'S'
	.db #0x34	; 52	'4'
	.db #0x01	; 1
	.db #0x30	; 48	'0'
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x21	; 33
	.db #0x13	; 19
	.db #0x34	; 52	'4'
	.db #0x01	; 1
	.db #0x30	; 48	'0'
	.db #0x11	; 17
	.db #0x20	; 32
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x14	; 20
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x01	; 1
	.db #0x90	; 144
	.db #0x01	; 1
	.db #0x34	; 52	'4'
	.db #0x01	; 1
	.db #0xA0	; 160
	.db #0x01	; 1
	.db #0x14	; 20
	.db #0x01	; 1
	.db #0xC0	; 192
	.db #0x11	; 17
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x60	; 96
	.db #0x11	; 17
	.db #0xC0	; 192
	.db #0x01	; 1
	.db #0x13	; 19
	.db #0x01	; 1
	.db #0xB0	; 176
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x10	; 16
	.db #0x31	; 49	'1'
	.db #0x50	; 80	'P'
	.db #0x01	; 1
	.db #0x13	; 19
	.db #0x21	; 33
	.db #0x33	; 51	'3'
	.db #0x11	; 17
	.db #0x30	; 48	'0'
	.db #0x01	; 1
	.db #0x13	; 19
	.db #0x01	; 1
	.db #0x23	; 35
	.db #0x01	; 1
	.db #0x33	; 51	'3'
	.db #0x01	; 1
	.db #0x20	; 32
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x16	; 22
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x23	; 35
	.db #0x01	; 1
	.db #0x10	; 16
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x73	; 115	's'
	.db #0x01	; 1
	.db #0x10	; 16
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x33	; 51	'3'
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x23	; 35
	.db #0x01	; 1
	.db #0x10	; 16
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x13	; 19
	.db #0x01	; 1
	.db #0x23	; 35
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x10	; 16
	.db #0x01	; 1
	.db #0x13	; 19
	.db #0x01	; 1
	.db #0x23	; 35
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x20	; 32
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x43	; 67	'C'
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x30	; 48	'0'
	.db #0x01	; 1
	.db #0x33	; 51	'3'
	.db #0x11	; 17
	.db #0x33	; 51	'3'
	.db #0x01	; 1
	.db #0x40	; 64
	.db #0x31	; 49	'1'
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x13	; 19
	.db #0x01	; 1
	.db #0xC0	; 192
	.db #0x11	; 17
	.db #0xF0	; 240
	.area _INITIALIZER
	.area _CABS (ABS)
