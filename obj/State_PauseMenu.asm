;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_PauseMenu
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ui_pausemenu_render_all
	.globl _ui_pausemenu_render_refresh
	.globl _ui_pausemenu_unselect_entry
	.globl _ui_pausemenu_select_entry
	.globl _ui_pausemenu_previous_entry
	.globl _ui_pausemenu_next_entry
	.globl _ui_pausemenu_is_selected
	.globl _ui_pausemenu_get_entry
	.globl _ui_pausemenu_init
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _statemanager_close_state
	.globl _cpct_drawSolidBox
	.globl _cpct_isKeyPressed
	.globl _state_pausemenu_enter
	.globl _state_pausemenu_return
	.globl _state_pausemenu_input
	.globl _state_pausemenu_update
	.globl _state_pausemenu_render
	.globl _state_pausemenu_exit
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
;src/State_PauseMenu.c:14: void state_pausemenu_enter(){
;	---------------------------------
; Function state_pausemenu_enter
; ---------------------------------
_state_pausemenu_enter::
;src/State_PauseMenu.c:15: cpct_drawSolidBox (SCREEN_PTR_AT(CPCT_VMEM_START, 23, 28), g_colors[4], 34, 144);
	ld	hl, #_g_colors + 4
	ld	b,(hl)
	ld	hl,#0x9022
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xE107
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/State_PauseMenu.c:16: cpct_drawSolidBox (SCREEN_PTR_AT(CPCT_VMEM_START, 24, 32), g_colors[1], 32, 136);
	ld	hl, #_g_colors + 1
	ld	b,(hl)
	ld	hl,#0x8820
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xC158
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/State_PauseMenu.c:17: ui_pausemenu_init();
	call	_ui_pausemenu_init
;src/State_PauseMenu.c:18: ui_pausemenu_render_all();
	jp  _ui_pausemenu_render_all
;src/State_PauseMenu.c:21: void state_pausemenu_return(){
;	---------------------------------
; Function state_pausemenu_return
; ---------------------------------
_state_pausemenu_return::
;src/State_PauseMenu.c:22: ui_pausemenu_render_all();
	jp  _ui_pausemenu_render_all
;src/State_PauseMenu.c:25: void state_pausemenu_input(){
;	---------------------------------
; Function state_pausemenu_input
; ---------------------------------
_state_pausemenu_input::
;src/State_PauseMenu.c:27: if(cpct_isKeyPressed(Key_CursorUp)){
	ld	hl,#0x0100
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00107$
;src/State_PauseMenu.c:28: ui_pausemenu_previous_entry();
	call	_ui_pausemenu_previous_entry
;src/State_PauseMenu.c:29: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00107$:
;src/State_PauseMenu.c:31: else if(cpct_isKeyPressed(Key_CursorDown)){
	ld	hl,#0x0400
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00104$
;src/State_PauseMenu.c:32: ui_pausemenu_next_entry();
	call	_ui_pausemenu_next_entry
;src/State_PauseMenu.c:33: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00104$:
;src/State_PauseMenu.c:35: else if(cpct_isKeyPressed(Key_Return)){
	ld	hl,#0x0402
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	ret	Z
;src/State_PauseMenu.c:36: ui_pausemenu_select_entry();
	call	_ui_pausemenu_select_entry
;src/State_PauseMenu.c:37: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_PauseMenu.c:42: void state_pausemenu_update(){
;	---------------------------------
; Function state_pausemenu_update
; ---------------------------------
_state_pausemenu_update::
;src/State_PauseMenu.c:43: if(ui_pausemenu_is_selected()){
	call	_ui_pausemenu_is_selected
	ld	a,l
	or	a, a
	jp	Z,_ui_pausemenu_unselect_entry
;src/State_PauseMenu.c:44: ui_pausemenu_render_refresh();
	call	_ui_pausemenu_render_refresh
;src/State_PauseMenu.c:45: switch(ui_pausemenu_get_entry()){
	call	_ui_pausemenu_get_entry
	ld	e,l
	ld	a,#0x03
	sub	a, e
	jp	C,_ui_pausemenu_unselect_entry
	ld	d,#0x00
	ld	hl,#00118$
	add	hl,de
	add	hl,de
	add	hl,de
	jp	(hl)
00118$:
	jp	00101$
	jp	_ui_pausemenu_unselect_entry
	jp	_ui_pausemenu_unselect_entry
	jp	00104$
;src/State_PauseMenu.c:46: case 0:{
00101$:
;src/State_PauseMenu.c:47: statemanager_close_state();
	call	_statemanager_close_state
;src/State_PauseMenu.c:48: break;
	jp	_ui_pausemenu_unselect_entry
;src/State_PauseMenu.c:50: case 1:{
;src/State_PauseMenu.c:52: break;
	jp	_ui_pausemenu_unselect_entry
;src/State_PauseMenu.c:54: case 2:{
;src/State_PauseMenu.c:56: break;
	jp	_ui_pausemenu_unselect_entry
;src/State_PauseMenu.c:58: case 3:{
00104$:
;src/State_PauseMenu.c:59: statemanager_set_state(STATE_MAINMENU);
	xor	a, a
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_PauseMenu.c:62: }
;src/State_PauseMenu.c:64: ui_pausemenu_unselect_entry();
	jp  _ui_pausemenu_unselect_entry
;src/State_PauseMenu.c:67: void state_pausemenu_render(){
;	---------------------------------
; Function state_pausemenu_render
; ---------------------------------
_state_pausemenu_render::
;src/State_PauseMenu.c:68: ui_pausemenu_render_refresh();
	jp  _ui_pausemenu_render_refresh
;src/State_PauseMenu.c:71: void state_pausemenu_exit(){
;	---------------------------------
; Function state_pausemenu_exit
; ---------------------------------
_state_pausemenu_exit::
;src/State_PauseMenu.c:72: cpct_drawSolidBox (SCREEN_PTR_AT(CPCT_VMEM_START, 23, 28), g_colors[1], 34, 144);
	ld	hl, #(_g_colors + 0x0001) + 0
	ld	b,(hl)
	ld	hl,#0x9022
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xE107
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
