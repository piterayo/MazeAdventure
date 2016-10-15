;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_MainMenu
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _level_set_level
	.globl _print_transparent_text
	.globl _statemanager_exit_game
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _ui_mainmenu_render_refresh
	.globl _ui_mainmenu_render_all
	.globl _ui_mainmenu_unselect_entry
	.globl _ui_mainmenu_select_entry
	.globl _ui_mainmenu_previous_entry
	.globl _ui_mainmenu_next_entry
	.globl _ui_mainmenu_is_selected
	.globl _ui_mainmenu_get_entry
	.globl _ui_mainmenu_init
	.globl _cpct_isKeyPressed
	.globl _cpct_memset
	.globl _state_mainmenu_enter
	.globl _state_mainmenu_return
	.globl _state_mainmenu_input
	.globl _state_mainmenu_update
	.globl _state_mainmenu_render
	.globl _state_mainmenu_exit
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
;src/State_MainMenu.c:16: void state_mainmenu_enter(){
;	---------------------------------
; Function state_mainmenu_enter
; ---------------------------------
_state_mainmenu_enter::
;src/State_MainMenu.c:17: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
	ld	hl,#_g_colors+1
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/State_MainMenu.c:18: print_transparent_text("MAIN MENU", CPCT_VMEM_START, 3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xC000
	push	hl
	ld	hl,#___str_0
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/State_MainMenu.c:21: ui_mainmenu_init();
	call	_ui_mainmenu_init
;src/State_MainMenu.c:22: ui_mainmenu_render_all();
	call	_ui_mainmenu_render_all
	ret
___str_0:
	.ascii "MAIN MENU"
	.db 0x00
;src/State_MainMenu.c:26: void state_mainmenu_return(){
;	---------------------------------
; Function state_mainmenu_return
; ---------------------------------
_state_mainmenu_return::
;src/State_MainMenu.c:27: ui_mainmenu_render_all();
	jp  _ui_mainmenu_render_all
;src/State_MainMenu.c:31: void state_mainmenu_input(){
;	---------------------------------
; Function state_mainmenu_input
; ---------------------------------
_state_mainmenu_input::
;src/State_MainMenu.c:32: if(cpct_isKeyPressed(Key_CursorUp)){
	ld	hl,#0x0100
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00107$
;src/State_MainMenu.c:33: ui_mainmenu_previous_entry();
	call	_ui_mainmenu_previous_entry
;src/State_MainMenu.c:34: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00107$:
;src/State_MainMenu.c:36: else if(cpct_isKeyPressed(Key_CursorDown)){
	ld	hl,#0x0400
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00104$
;src/State_MainMenu.c:37: ui_mainmenu_next_entry();
	call	_ui_mainmenu_next_entry
;src/State_MainMenu.c:38: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00104$:
;src/State_MainMenu.c:40: else if(cpct_isKeyPressed(Key_Return)){
	ld	hl,#0x0402
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	ret	Z
;src/State_MainMenu.c:41: ui_mainmenu_select_entry();
	call	_ui_mainmenu_select_entry
;src/State_MainMenu.c:42: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_MainMenu.c:46: void state_mainmenu_update(){
;	---------------------------------
; Function state_mainmenu_update
; ---------------------------------
_state_mainmenu_update::
;src/State_MainMenu.c:47: if(ui_mainmenu_is_selected()){
	call	_ui_mainmenu_is_selected
	ld	a,l
	or	a, a
	ret	Z
;src/State_MainMenu.c:48: ui_mainmenu_render_refresh();
	call	_ui_mainmenu_render_refresh
;src/State_MainMenu.c:49: switch(ui_mainmenu_get_entry()){
	call	_ui_mainmenu_get_entry
	ld	e,l
	ld	a,#0x04
	sub	a, e
	jp	C,_ui_mainmenu_unselect_entry
	ld	d,#0x00
	ld	hl,#00119$
	add	hl,de
	add	hl,de
;src/State_MainMenu.c:50: case 0:{
	jp	(hl)
00119$:
	jr	00101$
	jr	00106$
	jr	00106$
	jr	00106$
	jr	00105$
00101$:
;src/State_MainMenu.c:51: level_set_level(0);
	xor	a, a
	push	af
	inc	sp
	call	_level_set_level
	inc	sp
;src/State_MainMenu.c:52: statemanager_set_state(STATE_LOADLEVEL);
	ld	a,#0x03
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_MainMenu.c:53: break;
	jp	_ui_mainmenu_unselect_entry
;src/State_MainMenu.c:55: case 1:{
;src/State_MainMenu.c:57: break;
	jp	_ui_mainmenu_unselect_entry
;src/State_MainMenu.c:59: case 2:{
;src/State_MainMenu.c:61: break;
	jp	_ui_mainmenu_unselect_entry
;src/State_MainMenu.c:63: case 3:{
;src/State_MainMenu.c:65: break;
	jp	_ui_mainmenu_unselect_entry
;src/State_MainMenu.c:67: case 4:{
00105$:
;src/State_MainMenu.c:68: statemanager_exit_game();
	call	_statemanager_exit_game
;src/State_MainMenu.c:71: }
00106$:
;src/State_MainMenu.c:72: ui_mainmenu_unselect_entry();
	jp  _ui_mainmenu_unselect_entry
;src/State_MainMenu.c:76: void state_mainmenu_render(){
;	---------------------------------
; Function state_mainmenu_render
; ---------------------------------
_state_mainmenu_render::
;src/State_MainMenu.c:77: ui_mainmenu_render_refresh();
	jp  _ui_mainmenu_render_refresh
;src/State_MainMenu.c:80: void state_mainmenu_exit(){
;	---------------------------------
; Function state_mainmenu_exit
; ---------------------------------
_state_mainmenu_exit::
;src/State_MainMenu.c:82: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
