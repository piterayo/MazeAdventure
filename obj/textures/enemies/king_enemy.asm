;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module king_enemy
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _king_enemy
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
_king_enemy:
	.db #0xF0	; 240
	.db #0xF0	; 240
	.db #0x10	; 16
	.db #0x58	; 88	'X'
	.db #0xF0	; 240
	.db #0x10	; 16
	.db #0x18	; 24
	.db #0x29	; 41
	.db #0x04	; 4
	.db #0x18	; 24
	.db #0xD0	; 208
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x13	; 19
	.db #0x29	; 41
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0xB0	; 176
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x04	; 4
	.db #0x19	; 25
	.db #0x03	; 3
	.db #0x39	; 57	'9'
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x24	; 36
	.db #0x50	; 80	'P'
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x12	; 18
	.db #0x08	; 8
	.db #0x59	; 89	'Y'
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x44	; 68	'D'
	.db #0x50	; 80	'P'
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x12	; 18
	.db #0x14	; 20
	.db #0x29	; 41
	.db #0x04	; 4
	.db #0x18	; 24
	.db #0x44	; 68	'D'
	.db #0x60	; 96
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x11	; 17
	.db #0x44	; 68	'D'
	.db #0x08	; 8
	.db #0x71	; 113	'q'
	.db #0x29	; 41
	.db #0x21	; 33
	.db #0x04	; 4
	.db #0x09	; 9
	.db #0x33	; 51	'3'
	.db #0x11	; 17
	.db #0x23	; 35
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x23	; 35
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x2F	; 47
	.db #0x01	; 1
	.db #0x13	; 19
	.db #0x42	; 66	'B'
	.db #0x01	; 1
	.db #0x13	; 19
	.db #0x01	; 1
	.db #0x42	; 66	'B'
	.db #0x01	; 1
	.db #0x29	; 41
	.db #0x04	; 4
	.db #0x2F	; 47
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x12	; 18
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x12	; 18
	.db #0x41	; 65	'A'
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x3F	; 63
	.db #0x01	; 1
	.db #0x22	; 34
	.db #0x03	; 3
	.db #0x12	; 18
	.db #0x01	; 1
	.db #0x22	; 34
	.db #0x01	; 1
	.db #0x44	; 68	'D'
	.db #0x29	; 41
	.db #0x04	; 4
	.db #0x2F	; 47
	.db #0x01	; 1
	.db #0x52	; 82	'R'
	.db #0x01	; 1
	.db #0x22	; 34
	.db #0x41	; 65	'A'
	.db #0x10	; 16
	.db #0x19	; 25
	.db #0x2F	; 47
	.db #0x01	; 1
	.db #0x62	; 98	'b'
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0x01	; 1
	.db #0x42	; 66	'B'
	.db #0x01	; 1
	.db #0x2A	; 42
	.db #0x21	; 33
	.db #0x04	; 4
	.db #0x09	; 9
	.db #0x32	; 50	'2'
	.db #0x11	; 17
	.db #0x22	; 34
	.db #0x01	; 1
	.db #0x42	; 66	'B'
	.db #0x01	; 1
	.db #0x50	; 80	'P'
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x31	; 49	'1'
	.db #0x14	; 20
	.db #0x91	; 145
	.db #0x50	; 80	'P'
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x12	; 18
	.db #0x21	; 33
	.db #0x94	; 148
	.db #0x60	; 96
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x12	; 18
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0x21	; 33
	.db #0x00	; 0
	.db #0x64	; 100	'd'
	.db #0x60	; 96
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x52	; 82	'R'
	.db #0x01	; 1
	.db #0x30	; 48	'0'
	.db #0x24	; 36
	.db #0x70	; 112	'p'
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x02	; 2
	.db #0x29	; 41
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0xF0	; 240
	.db #0x10	; 16
	.db #0x04	; 4
	.db #0x13	; 19
	.db #0x19	; 25
	.db #0x01	; 1
	.db #0xF0	; 240
	.db #0x14	; 20
	.db #0x13	; 19
	.db #0x09	; 9
	.db #0xF0	; 240
	.db #0x00	; 0
	.db #0x14	; 20
	.db #0x13	; 19
	.db #0xF0	; 240
	.db #0x10	; 16
	.db #0x14	; 20
	.db #0x13	; 19
	.area _INITIALIZER
	.area _CABS (ABS)