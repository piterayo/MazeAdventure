;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_SaveExit
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _savegame_get_saveString
	.globl _print_transparent_text
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _cpct_drawSolidBox
	.globl _cpct_isAnyKeyPressed_f
	.globl _state_saveexit_enter
	.globl _state_saveexit_return
	.globl _state_saveexit_input
	.globl _state_saveexit_update
	.globl _state_saveexit_render
	.globl _state_saveexit_exit
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
;src/State_SaveExit.c:17: void state_saveexit_enter(){
;	---------------------------------
; Function state_saveexit_enter
; ---------------------------------
_state_saveexit_enter::
;src/State_SaveExit.c:18: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 20, 80), g_colors[4], 40, 40);
	ld	hl, #_g_colors + 4
	ld	b,(hl)
	ld	hl,#0x2828
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xC334
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/State_SaveExit.c:19: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 21, 84), g_colors[1], 38, 32);
	ld	hl, #_g_colors + 1
	ld	b,(hl)
	ld	hl,#0x2026
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xE335
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/State_SaveExit.c:21: print_transparent_text(savegame_get_saveString(), cpctm_screenPtr(CPCT_VMEM_START, 22, 92), 3);
	call	_savegame_get_saveString
	ld	c,l
	ld	b,h
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xE386
	push	hl
	push	bc
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/State_SaveExit.c:22: print_transparent_text("PRESS ANY KEY", cpctm_screenPtr(CPCT_VMEM_START, 27, 100), 3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xE3DB
	push	hl
	ld	hl,#___str_0
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
	ret
___str_0:
	.ascii "PRESS ANY KEY"
	.db 0x00
;src/State_SaveExit.c:26: void state_saveexit_return(){
;	---------------------------------
; Function state_saveexit_return
; ---------------------------------
_state_saveexit_return::
;src/State_SaveExit.c:28: }
	ret
;src/State_SaveExit.c:30: void state_saveexit_input(){
;	---------------------------------
; Function state_saveexit_input
; ---------------------------------
_state_saveexit_input::
;src/State_SaveExit.c:31: if(cpct_isAnyKeyPressed_f()){
	call	_cpct_isAnyKeyPressed_f
	ld	a,l
	or	a, a
	ret	Z
;src/State_SaveExit.c:32: statemanager_set_state(STATE_MAINMENU);
	xor	a, a
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_SaveExit.c:33: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_SaveExit.c:37: void state_saveexit_update(){
;	---------------------------------
; Function state_saveexit_update
; ---------------------------------
_state_saveexit_update::
;src/State_SaveExit.c:39: }
	ret
;src/State_SaveExit.c:41: void state_saveexit_render(){
;	---------------------------------
; Function state_saveexit_render
; ---------------------------------
_state_saveexit_render::
;src/State_SaveExit.c:43: }
	ret
;src/State_SaveExit.c:45: void state_saveexit_exit(){
;	---------------------------------
; Function state_saveexit_exit
; ---------------------------------
_state_saveexit_exit::
;src/State_SaveExit.c:47: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
