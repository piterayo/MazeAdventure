;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_Options
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ui_options_set_strings
	.globl _ui_options_render_all
	.globl _ui_options_render_refresh
	.globl _ui_options_unselect_entry
	.globl _ui_options_select_entry
	.globl _ui_options_previous_entry
	.globl _ui_options_next_entry
	.globl _ui_options_is_selected
	.globl _ui_options_get_entry
	.globl _ui_options_init
	.globl _statemanager_input_accepted
	.globl _statemanager_close_state
	.globl _cpct_drawSolidBox
	.globl _cpct_isKeyPressed
	.globl _state_options_enter
	.globl _state_options_return
	.globl _state_options_input
	.globl _state_options_update
	.globl _state_options_render
	.globl _state_options_exit
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
;src/State_Options.c:13: void state_options_enter(){
;	---------------------------------
; Function state_options_enter
; ---------------------------------
_state_options_enter::
;src/State_Options.c:14: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[4], 34, 80);
	ld	hl, #_g_colors + 4
	ld	b,(hl)
	ld	hl,#0x5022
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xC297
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/State_Options.c:15: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 68), g_colors[1], 32, 72);
	ld	hl, #_g_colors + 1
	ld	b,(hl)
	ld	hl,#0x4820
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xE298
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/State_Options.c:16: ui_options_init();
	call	_ui_options_init
;src/State_Options.c:17: ui_options_render_all();
	jp  _ui_options_render_all
;src/State_Options.c:20: void state_options_return(){
;	---------------------------------
; Function state_options_return
; ---------------------------------
_state_options_return::
;src/State_Options.c:22: }
	ret
;src/State_Options.c:24: void state_options_input(){
;	---------------------------------
; Function state_options_input
; ---------------------------------
_state_options_input::
;src/State_Options.c:25: if(cpct_isKeyPressed(Key_CursorUp)){
	ld	hl,#0x0100
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00107$
;src/State_Options.c:26: ui_options_previous_entry();
	call	_ui_options_previous_entry
;src/State_Options.c:27: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00107$:
;src/State_Options.c:29: else if(cpct_isKeyPressed(Key_CursorDown)){
	ld	hl,#0x0400
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00104$
;src/State_Options.c:30: ui_options_next_entry();
	call	_ui_options_next_entry
;src/State_Options.c:31: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00104$:
;src/State_Options.c:33: else if(cpct_isKeyPressed(Key_Return)){
	ld	hl,#0x0402
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	ret	Z
;src/State_Options.c:34: ui_options_select_entry();
	call	_ui_options_select_entry
;src/State_Options.c:35: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_Options.c:39: void state_options_update(){
;	---------------------------------
; Function state_options_update
; ---------------------------------
_state_options_update::
;src/State_Options.c:40: if(ui_options_is_selected()){
	call	_ui_options_is_selected
	ld	a,l
	or	a, a
	jp	Z,_ui_options_unselect_entry
;src/State_Options.c:41: ui_options_render_refresh();
	call	_ui_options_render_refresh
;src/State_Options.c:42: switch(ui_options_get_entry()){
	call	_ui_options_get_entry
	ld	e,l
	ld	a,#0x02
	sub	a, e
	jp	C,_ui_options_unselect_entry
	ld	d,#0x00
	ld	hl,#00117$
	add	hl,de
	add	hl,de
;src/State_Options.c:43: case 0:{//Textures
	jp	(hl)
00117$:
	jr	00101$
	jr	00102$
	jr	00103$
00101$:
;src/State_Options.c:44: textures_on=!textures_on;
	ld	a,(#_textures_on + 0)
	sub	a,#0x01
	ld	a,#0x00
	rla
	ld	c,a
	ld	hl,#_textures_on + 0
	ld	(hl), c
;src/State_Options.c:45: ui_options_set_strings();
	call	_ui_options_set_strings
;src/State_Options.c:46: break;
	jp	_ui_options_unselect_entry
;src/State_Options.c:48: case 1:{//Sound
00102$:
;src/State_Options.c:49: music_on=!music_on;
	ld	a,(#_music_on + 0)
	sub	a,#0x01
	ld	a,#0x00
	rla
	ld	c,a
	ld	hl,#_music_on + 0
	ld	(hl), c
;src/State_Options.c:50: ui_options_set_strings();
	call	_ui_options_set_strings
;src/State_Options.c:51: break;
	jp	_ui_options_unselect_entry
;src/State_Options.c:53: case 2:{
00103$:
;src/State_Options.c:54: statemanager_close_state();
	call	_statemanager_close_state
;src/State_Options.c:57: }
;src/State_Options.c:59: ui_options_unselect_entry();
	jp  _ui_options_unselect_entry
;src/State_Options.c:62: void state_options_render(){
;	---------------------------------
; Function state_options_render
; ---------------------------------
_state_options_render::
;src/State_Options.c:63: ui_options_render_refresh();
	jp  _ui_options_render_refresh
;src/State_Options.c:66: void state_options_exit(){
;	---------------------------------
; Function state_options_exit
; ---------------------------------
_state_options_exit::
;src/State_Options.c:67: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[1], 34, 80);
	ld	hl, #(_g_colors + 0x0001) + 0
	ld	b,(hl)
	ld	hl,#0x5022
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xC297
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
