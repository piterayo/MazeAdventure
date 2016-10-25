;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module Player
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _player_directionIndex
	.globl _player_scroll_count
	.globl _player_potion_count
	.globl _player_has_key
	.globl _player_is_dead
	.globl _player_health_points
	.globl _player_attack_value
	.globl _player_defense_value
	.globl _player_direction
	.globl _player_position
	.globl _player_init
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
_player_defense_value::
	.ds 1
_player_attack_value::
	.ds 1
_player_health_points::
	.ds 1
_player_is_dead::
	.ds 1
_player_has_key::
	.ds 1
_player_potion_count::
	.ds 1
_player_scroll_count::
	.ds 1
_player_directionIndex::
	.ds 1
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
;src/Player.c:30: void player_init(){
;	---------------------------------
; Function player_init
; ---------------------------------
_player_init::
;src/Player.c:31: player_attack_value = 52;
	ld	hl,#_player_attack_value + 0
	ld	(hl), #0x34
;src/Player.c:32: player_defense_value = 8;
	ld	hl,#_player_defense_value + 0
	ld	(hl), #0x08
;src/Player.c:33: player_is_dead=0;
	ld	hl,#_player_is_dead + 0
	ld	(hl), #0x00
;src/Player.c:35: player_health_points = PLAYER_MAX_HP;
	ld	hl,#_player_health_points + 0
	ld	(hl), #0xFF
;src/Player.c:36: player_has_key=0;
	ld	hl,#_player_has_key + 0
	ld	(hl), #0x00
;src/Player.c:37: player_potion_count=0;
	ld	hl,#_player_potion_count + 0
	ld	(hl), #0x00
;src/Player.c:38: player_scroll_count=0;
	ld	hl,#_player_scroll_count + 0
	ld	(hl), #0x00
	ret
_player_position:
	.db #0x01	; 1
	.db #0x01	; 1
_player_direction:
	.db #0x01	;  1
	.db #0x00	;  0
;src/Player.c:42: void player_turn_left(){
;	---------------------------------
; Function player_turn_left
; ---------------------------------
_player_turn_left::
;src/Player.c:43: (player_directionIndex)=(player_directionIndex+2)&7;
	ld	a,(#_player_directionIndex + 0)
	add	a, #0x02
	and	a, #0x07
	ld	(#_player_directionIndex + 0),a
;src/Player.c:44: *(i8*)&(player_direction.x) = movement_directionArray[(player_directionIndex)];
	ld	de,#_movement_directionArray+0
	ld	hl,(_player_directionIndex)
	ld	h,#0x00
	add	hl,de
	ld	c,(hl)
	ld	hl,#_player_direction
	ld	(hl),c
;src/Player.c:45: *(i8*)&(player_direction.y) = movement_directionArray[((player_directionIndex)+1)];
	ld	bc,#_player_direction+1
	ld	iy,#_player_directionIndex
	ld	l,0 (iy)
	inc	l
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
	ret
;src/Player.c:48: void player_turn_right(){
;	---------------------------------
; Function player_turn_right
; ---------------------------------
_player_turn_right::
;src/Player.c:50: (player_directionIndex)=(player_directionIndex-2)&7;
	ld	a,(#_player_directionIndex + 0)
	add	a,#0xFE
	and	a, #0x07
	ld	(#_player_directionIndex + 0),a
;src/Player.c:51: *(i8*)&(player_direction.x) = movement_directionArray[(player_directionIndex)];
	ld	de,#_movement_directionArray+0
	ld	hl,(_player_directionIndex)
	ld	h,#0x00
	add	hl,de
	ld	c,(hl)
	ld	hl,#_player_direction
	ld	(hl),c
;src/Player.c:52: *(i8*)&(player_direction.y) = movement_directionArray[((player_directionIndex)+1)];
	ld	bc,#_player_direction+1
	ld	iy,#_player_directionIndex
	ld	l,0 (iy)
	inc	l
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
	ret
;src/Player.c:55: void player_move_forward(){
;	---------------------------------
; Function player_move_forward
; ---------------------------------
_player_move_forward::
;src/Player.c:56: *(i8*)&(player_position.x) = player_position.x + player_direction.x;
	ld	hl,#_player_position+0
	ld	c, l
	ld	b, h
	ld	d,(hl)
	ld	hl,#_player_direction+0
	ld	e,(hl)
	ld	a,d
	add	a, e
	ld	(bc),a
;src/Player.c:57: *(i8*)&(player_position.y) = player_position.y + player_direction.y;
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
;src/Player.c:60: u8 player_get_direction_index(){
;	---------------------------------
; Function player_get_direction_index
; ---------------------------------
_player_get_direction_index::
;src/Player.c:61: return player_directionIndex;
	ld	iy,#_player_directionIndex
	ld	l,0 (iy)
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
