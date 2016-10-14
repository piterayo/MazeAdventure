;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_LoadLevel
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _level_load_level
	.globl _generate_level
	.globl _print_transparent_text
	.globl _draw_minimap_to_buffer
	.globl _render_draw_to_buffer
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _statemanager_close_state
	.globl _cpct_memset
	.globl _state_loadlevel_enter
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
;src/State_LoadLevel.c:10: void state_loadlevel_enter(){
;	---------------------------------
; Function state_loadlevel_enter
; ---------------------------------
_state_loadlevel_enter::
;src/State_LoadLevel.c:11: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
	ld	hl,#_g_colors+1
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/State_LoadLevel.c:13: print_transparent_text("LOADING", 0xe391, 3);
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
;src/State_LoadLevel.c:15: generate_level();
	call	_generate_level
;src/State_LoadLevel.c:16: level_load_level();
	call	_level_load_level
;src/State_LoadLevel.c:18: render_draw_to_buffer();
	call	_render_draw_to_buffer
;src/State_LoadLevel.c:19: draw_minimap_to_buffer();
	call	_draw_minimap_to_buffer
	ret
___str_0:
	.ascii "LOADING"
	.db 0x00
;src/State_LoadLevel.c:23: void state_loadlevel_input(){
;	---------------------------------
; Function state_loadlevel_input
; ---------------------------------
_state_loadlevel_input::
;src/State_LoadLevel.c:24: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_LoadLevel.c:27: void state_loadlevel_update(){
;	---------------------------------
; Function state_loadlevel_update
; ---------------------------------
_state_loadlevel_update::
;src/State_LoadLevel.c:28: statemanager_close_state();
	call	_statemanager_close_state
;src/State_LoadLevel.c:29: statemanager_set_state(STATE_INGAME);
	ld	a,#0x01
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
	ret
;src/State_LoadLevel.c:32: void state_loadlevel_render(){
;	---------------------------------
; Function state_loadlevel_render
; ---------------------------------
_state_loadlevel_render::
;src/State_LoadLevel.c:34: }
	ret
;src/State_LoadLevel.c:36: void state_loadlevel_exit(){
;	---------------------------------
; Function state_loadlevel_exit
; ---------------------------------
_state_loadlevel_exit::
;src/State_LoadLevel.c:38: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
