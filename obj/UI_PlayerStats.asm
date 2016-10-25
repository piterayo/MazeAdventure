;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module UI_PlayerStats
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _integer_to_string
	.globl _print_text
	.globl _cpct_drawSolidBox
	.globl _strings
	.globl _ui_playerstats_render_all
	.globl _ui_playerstats_render_hp
	.globl _ui_playerstats_render_attack
	.globl _ui_playerstats_render_defense
	.globl _ui_playerstats_render_potions
	.globl _ui_playerstats_render_scrolls
	.globl _ui_playerstats_render_key
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
;src/UI_PlayerStats.c:24: void ui_playerstats_render_all(){
;	---------------------------------
; Function ui_playerstats_render_all
; ---------------------------------
_ui_playerstats_render_all::
;src/UI_PlayerStats.c:25: print_text("STATS", UI_PLAYERSTATS_POSITION+1,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xC0A1
	push	hl
	ld	hl,#___str_0
	push	hl
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;src/UI_PlayerStats.c:26: ui_playerstats_render_hp();
	call	_ui_playerstats_render_hp
;src/UI_PlayerStats.c:27: ui_playerstats_render_attack();
	call	_ui_playerstats_render_attack
;src/UI_PlayerStats.c:28: ui_playerstats_render_defense();
	call	_ui_playerstats_render_defense
;src/UI_PlayerStats.c:29: ui_playerstats_render_potions();
	call	_ui_playerstats_render_potions
;src/UI_PlayerStats.c:30: ui_playerstats_render_scrolls();
	call	_ui_playerstats_render_scrolls
;src/UI_PlayerStats.c:31: ui_playerstats_render_key();
	jp  _ui_playerstats_render_key
_strings:
	.dw __str_1
	.dw __str_2
	.dw __str_3
	.dw __str_4
	.dw __str_5
___str_0:
	.ascii "STATS"
	.db 0x00
__str_1:
	.ascii "+"
	.db 0x00
__str_2:
	.ascii "#"
	.db 0x00
__str_3:
	.ascii "&"
	.db 0x00
__str_4:
	.ascii "~"
	.db 0x00
__str_5:
	.ascii "$"
	.db 0x00
;src/UI_PlayerStats.c:35: void ui_playerstats_render_hp(){
;	---------------------------------
; Function ui_playerstats_render_hp
; ---------------------------------
_ui_playerstats_render_hp::
;src/UI_PlayerStats.c:36: u8 h = 1+((u16)player_health_points*9)/255;
	ld	hl,#_player_health_points + 0
	ld	c, (hl)
	ld	b,#0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	bc,#0x00FF
	push	bc
	push	hl
	call	__divuint
	pop	af
	pop	af
	ld	b,l
	inc	b
;src/UI_PlayerStats.c:37: print_text("HP", UI_PLAYERSTATS_POSITION+160,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
	push	bc
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xC140
	push	hl
	ld	hl,#___str_6
	push	hl
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	bc
;src/UI_PlayerStats.c:40: cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[UI_PLAYERSTATS_HEALTHBAR_BG_COLOR], 10,4);
	ld	hl, #_g_colors + 4
	ld	d,(hl)
	push	bc
	ld	hl,#0x040A
	push	hl
	push	de
	inc	sp
	ld	hl,#0xC944
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
	pop	bc
;src/UI_PlayerStats.c:41: if(!player_is_dead) cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[UI_PLAYERSTATS_HEALTHBAR_FG_COLOR], h,4);
	ld	a,(#_player_is_dead + 0)
	or	a, a
	ret	NZ
	ld	hl, #_g_colors + 5
	ld	d,(hl)
	ld	a,#0x04
	push	af
	inc	sp
	ld	c, d
	push	bc
	ld	hl,#0xC944
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
	ret
___str_6:
	.ascii "HP"
	.db 0x00
;src/UI_PlayerStats.c:45: void ui_playerstats_render_attack(){
;	---------------------------------
; Function ui_playerstats_render_attack
; ---------------------------------
_ui_playerstats_render_attack::
;src/UI_PlayerStats.c:46: print_text(strings[0], UI_PLAYERSTATS_POSITION+320,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
	ld	bc, (#_strings + 0)
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xC1E0
	push	hl
	push	bc
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;src/UI_PlayerStats.c:47: print_text(integer_to_string(player_attack_value,'d'), UI_PLAYERSTATS_POSITION+324,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
	ld	a,#0x64
	push	af
	inc	sp
	ld	a,(_player_attack_value)
	push	af
	inc	sp
	call	_integer_to_string
	pop	af
	ld	c,l
	ld	b,h
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xC1E4
	push	hl
	push	bc
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	ret
;src/UI_PlayerStats.c:50: void ui_playerstats_render_defense(){
;	---------------------------------
; Function ui_playerstats_render_defense
; ---------------------------------
_ui_playerstats_render_defense::
;src/UI_PlayerStats.c:51: print_text(strings[1], UI_PLAYERSTATS_POSITION+400,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
	ld	bc, (#(_strings + 0x0002) + 0)
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xC230
	push	hl
	push	bc
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;src/UI_PlayerStats.c:52: print_text(integer_to_string(player_defense_value,'d'), UI_PLAYERSTATS_POSITION+404,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
	ld	a,#0x64
	push	af
	inc	sp
	ld	a,(_player_defense_value)
	push	af
	inc	sp
	call	_integer_to_string
	pop	af
	ld	c,l
	ld	b,h
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xC234
	push	hl
	push	bc
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	ret
;src/UI_PlayerStats.c:55: void ui_playerstats_render_potions(){
;	---------------------------------
; Function ui_playerstats_render_potions
; ---------------------------------
_ui_playerstats_render_potions::
;src/UI_PlayerStats.c:56: print_text(strings[2], UI_PLAYERSTATS_POSITION+480,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
	ld	bc, (#(_strings + 0x0004) + 0)
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xC280
	push	hl
	push	bc
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;src/UI_PlayerStats.c:57: print_text(integer_to_string(player_potion_count,'d'), UI_PLAYERSTATS_POSITION+484,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
	ld	a,#0x64
	push	af
	inc	sp
	ld	a,(_player_potion_count)
	push	af
	inc	sp
	call	_integer_to_string
	pop	af
	ld	c,l
	ld	b,h
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xC284
	push	hl
	push	bc
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	ret
;src/UI_PlayerStats.c:60: void ui_playerstats_render_scrolls(){
;	---------------------------------
; Function ui_playerstats_render_scrolls
; ---------------------------------
_ui_playerstats_render_scrolls::
;src/UI_PlayerStats.c:61: print_text(strings[3], UI_PLAYERSTATS_POSITION+560,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
	ld	bc, (#(_strings + 0x0006) + 0)
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xC2D0
	push	hl
	push	bc
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;src/UI_PlayerStats.c:62: print_text(integer_to_string(player_scroll_count,'d'), UI_PLAYERSTATS_POSITION+564, UI_PLAYERSTATS_BG_TEXT_COLOR,UI_PLAYERSTATS_TEXT_COLOR);
	ld	a,#0x64
	push	af
	inc	sp
	ld	a,(_player_scroll_count)
	push	af
	inc	sp
	call	_integer_to_string
	pop	af
	ld	c,l
	ld	b,h
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xC2D4
	push	hl
	push	bc
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	ret
;src/UI_PlayerStats.c:65: void ui_playerstats_render_key(){
;	---------------------------------
; Function ui_playerstats_render_key
; ---------------------------------
_ui_playerstats_render_key::
;src/UI_PlayerStats.c:66: print_text(strings[4], UI_PLAYERSTATS_POSITION+640,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
	ld	bc, (#(_strings + 0x0008) + 0)
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xC320
	push	hl
	push	bc
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;src/UI_PlayerStats.c:67: if(player_has_key){
	ld	a,(#_player_has_key + 0)
	or	a, a
	jr	Z,00102$
;src/UI_PlayerStats.c:68: print_text("YES", UI_PLAYERSTATS_POSITION+644,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xC324
	push	hl
	ld	hl,#___str_7
	push	hl
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	ret
00102$:
;src/UI_PlayerStats.c:71: print_text("NO", UI_PLAYERSTATS_POSITION+646,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xC326
	push	hl
	ld	hl,#___str_8
	push	hl
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	ret
___str_7:
	.ascii "YES"
	.db 0x00
___str_8:
	.ascii "NO"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
