;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_MainMenu
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _cpct_drawStringM0
	.globl _cpct_isKeyPressed
	.globl _cpct_memset
	.globl _state_mainmenu_enter
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
;src/State_MainMenu.c:10: void state_mainmenu_enter(){
;	---------------------------------
; Function state_mainmenu_enter
; ---------------------------------
_state_mainmenu_enter::
;src/State_MainMenu.c:11: cpct_memset(CPCT_VMEM_START, g_colors[12], 0x4000);
	ld	hl,#_g_colors+12
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/State_MainMenu.c:12: cpct_drawStringM0("MAIN MENU", CPCT_VMEM_START, 0, 1);
	ld	hl,#0x0100
	push	hl
	ld	h, #0xC0
	push	hl
	ld	hl,#___str_0
	push	hl
	call	_cpct_drawStringM0
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	ret
___str_0:
	.ascii "MAIN MENU"
	.db 0x00
;src/State_MainMenu.c:15: void state_mainmenu_input(){
;	---------------------------------
; Function state_mainmenu_input
; ---------------------------------
_state_mainmenu_input::
;src/State_MainMenu.c:16: if(cpct_isKeyPressed(Key_Return)){
	ld	hl,#0x0402
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	ret	Z
;src/State_MainMenu.c:17: statemanager_set_state(STATE_INGAME);
	ld	a,#0x01
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_MainMenu.c:18: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_MainMenu.c:22: void state_mainmenu_update(){
;	---------------------------------
; Function state_mainmenu_update
; ---------------------------------
_state_mainmenu_update::
;src/State_MainMenu.c:24: }
	ret
;src/State_MainMenu.c:26: void state_mainmenu_render(){
;	---------------------------------
; Function state_mainmenu_render
; ---------------------------------
_state_mainmenu_render::
;src/State_MainMenu.c:28: }
	ret
;src/State_MainMenu.c:30: void state_mainmenu_exit(){
;	---------------------------------
; Function state_mainmenu_exit
; ---------------------------------
_state_mainmenu_exit::
;src/State_MainMenu.c:32: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
