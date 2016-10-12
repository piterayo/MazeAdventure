;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_PauseMenu
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _statemanager_close_state
	.globl _cpct_getScreenPtr
	.globl _cpct_drawSolidBox
	.globl _cpct_isKeyPressed
	.globl _state_pausemenu_enter
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
;src/State_PauseMenu.c:10: void state_pausemenu_enter(){
;	---------------------------------
; Function state_pausemenu_enter
; ---------------------------------
_state_pausemenu_enter::
;src/State_PauseMenu.c:12: ptr=cpct_getScreenPtr(CPCT_VMEM_START, 20, 40 );
	ld	hl,#0x2814
	push	hl
	ld	hl,#0xC000
	push	hl
	call	_cpct_getScreenPtr
	ld	c,l
	ld	b,h
;src/State_PauseMenu.c:13: cpct_drawSolidBox (ptr, 255, 40, 120);
	ld	hl,#0x7828
	push	hl
	ld	a,#0xFF
	push	af
	inc	sp
	push	bc
	call	_cpct_drawSolidBox
	pop	af
;src/State_PauseMenu.c:14: ptr=cpct_getScreenPtr(CPCT_VMEM_START, 20, 80 );
	inc	sp
	ld	hl,#0x5014
	ex	(sp),hl
	ld	hl,#0xC000
	push	hl
	call	_cpct_getScreenPtr
	ret
;src/State_PauseMenu.c:17: void state_pausemenu_input(){
;	---------------------------------
; Function state_pausemenu_input
; ---------------------------------
_state_pausemenu_input::
;src/State_PauseMenu.c:19: if(cpct_isKeyPressed(Key_P)){
	ld	hl,#0x0803
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00104$
;src/State_PauseMenu.c:20: statemanager_set_state(STATE_INGAME);
	ld	a,#0x01
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_PauseMenu.c:21: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00104$:
;src/State_PauseMenu.c:23: else if(cpct_isKeyPressed(Key_Esc)){
	ld	hl,#0x0408
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	ret	Z
;src/State_PauseMenu.c:24: statemanager_set_state(STATE_MAINMENU);
	xor	a, a
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_PauseMenu.c:25: statemanager_close_state(STATE_INGAME);
	ld	a,#0x01
	push	af
	inc	sp
	call	_statemanager_close_state
	inc	sp
;src/State_PauseMenu.c:26: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_PauseMenu.c:30: void state_pausemenu_update(){
;	---------------------------------
; Function state_pausemenu_update
; ---------------------------------
_state_pausemenu_update::
;src/State_PauseMenu.c:32: }
	ret
;src/State_PauseMenu.c:34: void state_pausemenu_render(){
;	---------------------------------
; Function state_pausemenu_render
; ---------------------------------
_state_pausemenu_render::
;src/State_PauseMenu.c:36: }
	ret
;src/State_PauseMenu.c:38: void state_pausemenu_exit(){
;	---------------------------------
; Function state_pausemenu_exit
; ---------------------------------
_state_pausemenu_exit::
;src/State_PauseMenu.c:40: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
