;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module Player
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _player_directionArray
	.globl _player_directionIndex
	.globl _player_direction
	.globl _player_position
	.globl _player_turn_left
	.globl _player_turn_right
	.globl _player_move_forward
	.globl _player_get_direction_index
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
;src/Player.c:19: void player_turn_left(){
;	---------------------------------
; Function player_turn_left
; ---------------------------------
_player_turn_left::
;src/Player.c:20: *(u8*)&(player_directionIndex)=(player_directionIndex+2)&7;
	ld	bc,#_player_directionIndex+0
	ld	a,(#_player_directionIndex + 0)
	add	a, #0x02
	and	a, #0x07
	ld	(bc),a
;src/Player.c:21: *(i8*)&(player_direction.x) = player_directionArray[(player_directionIndex)];
	ld	bc,#_player_direction+0
	ld	de,#_player_directionArray+0
	ld	iy,#_player_directionIndex
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
;src/Player.c:22: *(i8*)&(player_direction.y) = player_directionArray[((player_directionIndex)+1)];
	ld	bc,#_player_direction+1
	ld	iy,#_player_directionIndex
	ld	l,0 (iy)
	inc	l
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
	ret
_player_position:
	.db #0x01	; 1
	.db #0x01	; 1
_player_direction:
	.db #0x01	;  1
	.db #0x00	;  0
_player_directionIndex:
	.db #0x00	; 0
_player_directionArray:
	.db #0x01	;  1
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0xFF	; -1
	.db #0xFF	; -1
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x01	;  1
;src/Player.c:25: void player_turn_right(){
;	---------------------------------
; Function player_turn_right
; ---------------------------------
_player_turn_right::
;src/Player.c:27: *(u8*)&(player_directionIndex)=(player_directionIndex-2)&7;
	ld	bc,#_player_directionIndex+0
	ld	a,(#_player_directionIndex + 0)
	add	a,#0xFE
	and	a, #0x07
	ld	(bc),a
;src/Player.c:28: *(i8*)&(player_direction.x) = player_directionArray[(player_directionIndex)];
	ld	bc,#_player_direction+0
	ld	de,#_player_directionArray+0
	ld	iy,#_player_directionIndex
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
;src/Player.c:29: *(i8*)&(player_direction.y) = player_directionArray[((player_directionIndex)+1)];
	ld	bc,#_player_direction+1
	ld	iy,#_player_directionIndex
	ld	l,0 (iy)
	inc	l
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
	ret
;src/Player.c:32: void player_move_forward(){
;	---------------------------------
; Function player_move_forward
; ---------------------------------
_player_move_forward::
;src/Player.c:33: *(i8*)&(player_position.x) = player_position.x + player_direction.x;
	ld	hl,#_player_position+0
	ld	c, l
	ld	b, h
	ld	d,(hl)
	ld	hl,#_player_direction+0
	ld	e,(hl)
	ld	a,d
	add	a, e
	ld	(bc),a
;src/Player.c:34: *(i8*)&(player_position.y) = player_position.y + player_direction.y;
	ld	hl,#_player_position+1
	ld	c, l
	ld	b, h
	ld	d,(hl)
	ld	hl,#_player_direction+1
	ld	e,(hl)
	ld	a,d
	add	a, e
	ld	(bc),a
	ret
;src/Player.c:37: u8 player_get_direction_index(){
;	---------------------------------
; Function player_get_direction_index
; ---------------------------------
_player_get_direction_index::
;src/Player.c:38: return player_directionIndex;
	ld	iy,#_player_directionIndex
	ld	l,0 (iy)
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
