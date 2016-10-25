;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_Victory
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _print_transparent_text
	.globl _cpct_isAnyKeyPressed_f
	.globl _cpct_memset
	.globl _state_victory_enter
	.globl _state_victory_return
	.globl _state_victory_input
	.globl _state_victory_update
	.globl _state_victory_render
	.globl _state_victory_exit
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
;src/State_Victory.c:15: void state_victory_enter(){
;	---------------------------------
; Function state_victory_enter
; ---------------------------------
_state_victory_enter::
;src/State_Victory.c:16: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
	ld	hl,#_g_colors+1
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/State_Victory.c:17: print_transparent_text("CONGRATULATIONS!", cpctm_screenPtr((u16)CPCT_VMEM_START,24,92), 3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xE388
	push	hl
	ld	hl,#___str_0
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/State_Victory.c:18: print_transparent_text("YOU HAVE DEFEATED THE EVIL KING!", cpctm_screenPtr((u16)CPCT_VMEM_START,8,100), 3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xE3C8
	push	hl
	ld	hl,#___str_1
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
	ret
___str_0:
	.ascii "CONGRATULATIONS!"
	.db 0x00
___str_1:
	.ascii "YOU HAVE DEFEATED THE EVIL KING!"
	.db 0x00
;src/State_Victory.c:21: void state_victory_return(){
;	---------------------------------
; Function state_victory_return
; ---------------------------------
_state_victory_return::
;src/State_Victory.c:23: }
	ret
;src/State_Victory.c:25: void state_victory_input(){
;	---------------------------------
; Function state_victory_input
; ---------------------------------
_state_victory_input::
;src/State_Victory.c:26: if(cpct_isAnyKeyPressed_f ()){
	call	_cpct_isAnyKeyPressed_f
	ld	a,l
	or	a, a
	ret	Z
;src/State_Victory.c:27: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_Victory.c:31: void state_victory_update(){
;	---------------------------------
; Function state_victory_update
; ---------------------------------
_state_victory_update::
;src/State_Victory.c:32: statemanager_set_state(STATE_MAINMENU);
	xor	a, a
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
	ret
;src/State_Victory.c:35: void state_victory_render(){
;	---------------------------------
; Function state_victory_render
; ---------------------------------
_state_victory_render::
;src/State_Victory.c:37: }
	ret
;src/State_Victory.c:39: void state_victory_exit(){
;	---------------------------------
; Function state_victory_exit
; ---------------------------------
_state_victory_exit::
;src/State_Victory.c:41: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
