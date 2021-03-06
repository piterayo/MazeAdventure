;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_LoadLevel
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _savegame_Save
	.globl _item_init_items
	.globl _enemy_init_enemies
	.globl _level_load_level
	.globl _level_get_level
	.globl _generate_level
	.globl _generate_level_with_seed
	.globl _print_transparent_text
	.globl _set_music
	.globl _remove_music
	.globl _draw_minimap_to_buffer
	.globl _render_draw_to_buffer
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _cpct_memset
	.globl _level_seed
	.globl _state_loadlevel_enter
	.globl _state_loadlevel_return
	.globl _state_loadlevel_input
	.globl _state_loadlevel_update
	.globl _state_loadlevel_render
	.globl _state_loadlevel_exit
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_level_seed::
	.ds 2
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
;src/State_LoadLevel.c:20: void state_loadlevel_enter(){
;	---------------------------------
; Function state_loadlevel_enter
; ---------------------------------
_state_loadlevel_enter::
;src/State_LoadLevel.c:22: if(level_get_level()<=(KING_LEVEL)){
	call	_level_get_level
	ld	a,#0x20
	sub	a, l
	ret	C
;src/State_LoadLevel.c:23: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
	ld	hl,#_g_colors+1
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/State_LoadLevel.c:25: print_transparent_text("LOADING", 0xe391, 3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xE391
	push	hl
	ld	hl,#___str_0
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/State_LoadLevel.c:27: if(level_seed) generate_level_with_seed(level_seed);
	ld	a,(#_level_seed + 1)
	ld	hl,#_level_seed + 0
	or	a,(hl)
	jr	Z,00102$
	ld	hl,(_level_seed)
	push	hl
	call	_generate_level_with_seed
	pop	af
	jr	00103$
00102$:
;src/State_LoadLevel.c:28: else generate_level();
	call	_generate_level
00103$:
;src/State_LoadLevel.c:29: level_load_level();
	call	_level_load_level
;src/State_LoadLevel.c:31: enemy_init_enemies();
	call	_enemy_init_enemies
;src/State_LoadLevel.c:32: item_init_items();
	call	_item_init_items
;src/State_LoadLevel.c:34: savegame_Save();
	call	_savegame_Save
;src/State_LoadLevel.c:36: render_draw_to_buffer();
	call	_render_draw_to_buffer
;src/State_LoadLevel.c:37: draw_minimap_to_buffer();
	call	_draw_minimap_to_buffer
;src/State_LoadLevel.c:39: set_music(GameMusic);
	ld	hl,#_GameMusic
	push	hl
	call	_set_music
	pop	af
;src/State_LoadLevel.c:41: level_seed=0;
	ld	hl,#0x0000
	ld	(_level_seed),hl
	ret
___str_0:
	.ascii "LOADING"
	.db 0x00
;src/State_LoadLevel.c:46: void state_loadlevel_return(){
;	---------------------------------
; Function state_loadlevel_return
; ---------------------------------
_state_loadlevel_return::
;src/State_LoadLevel.c:48: }
	ret
;src/State_LoadLevel.c:51: void state_loadlevel_input() {
;	---------------------------------
; Function state_loadlevel_input
; ---------------------------------
_state_loadlevel_input::
;src/State_LoadLevel.c:52: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_LoadLevel.c:55: void state_loadlevel_update(){
;	---------------------------------
; Function state_loadlevel_update
; ---------------------------------
_state_loadlevel_update::
;src/State_LoadLevel.c:56: if(level_get_level()<=(KING_LEVEL)){
	call	_level_get_level
	ld	a,#0x20
	sub	a, l
	jr	C,00102$
;src/State_LoadLevel.c:57: statemanager_set_state(STATE_INGAME);
	ld	a,#0x01
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
	ret
00102$:
;src/State_LoadLevel.c:60: remove_music();
	call	_remove_music
;src/State_LoadLevel.c:61: statemanager_set_state(STATE_VICTORY);
	ld	a,#0x07
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
	ret
;src/State_LoadLevel.c:65: void state_loadlevel_render(){
;	---------------------------------
; Function state_loadlevel_render
; ---------------------------------
_state_loadlevel_render::
;src/State_LoadLevel.c:67: }
	ret
;src/State_LoadLevel.c:69: void state_loadlevel_exit(){
;	---------------------------------
; Function state_loadlevel_exit
; ---------------------------------
_state_loadlevel_exit::
;src/State_LoadLevel.c:71: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
