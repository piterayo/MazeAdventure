;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_GameOver
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _level_get_level
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _integer_to_string
	.globl _print_transparent_text
	.globl _cpct_isAnyKeyPressed_f
	.globl _cpct_memset
	.globl _state_gameover_enter
	.globl _state_gameover_return
	.globl _state_gameover_input
	.globl _state_gameover_update
	.globl _state_gameover_render
	.globl _state_gameover_exit
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
;src/State_GameOver.c:15: void state_gameover_enter(){
;	---------------------------------
; Function state_gameover_enter
; ---------------------------------
_state_gameover_enter::
;src/State_GameOver.c:16: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
	ld	hl,#_g_colors+1
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/State_GameOver.c:17: print_transparent_text("GAME OVER", cpctm_screenPtr((u16)CPCT_VMEM_START,32,92), 3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xE390
	push	hl
	ld	hl,#___str_0
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/State_GameOver.c:18: print_transparent_text("LEVEL: ", cpctm_screenPtr((u16)CPCT_VMEM_START,30,100), 3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xE3DE
	push	hl
	ld	hl,#___str_1
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/State_GameOver.c:19: print_transparent_text(integer_to_string(level_get_level(),'d'), cpctm_screenPtr((u16)CPCT_VMEM_START,46,100), 3);
	call	_level_get_level
	ld	b,l
	ld	a,#0x64
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_integer_to_string
	pop	af
	ld	c,l
	ld	b,h
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xE3EE
	push	hl
	push	bc
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
	ret
___str_0:
	.ascii "GAME OVER"
	.db 0x00
___str_1:
	.ascii "LEVEL: "
	.db 0x00
;src/State_GameOver.c:22: void state_gameover_return(){
;	---------------------------------
; Function state_gameover_return
; ---------------------------------
_state_gameover_return::
;src/State_GameOver.c:24: }
	ret
;src/State_GameOver.c:26: void state_gameover_input(){
;	---------------------------------
; Function state_gameover_input
; ---------------------------------
_state_gameover_input::
;src/State_GameOver.c:27: if(cpct_isAnyKeyPressed_f ()){
	call	_cpct_isAnyKeyPressed_f
	ld	a,l
	or	a, a
	ret	Z
;src/State_GameOver.c:28: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_GameOver.c:32: void state_gameover_update(){
;	---------------------------------
; Function state_gameover_update
; ---------------------------------
_state_gameover_update::
;src/State_GameOver.c:33: statemanager_set_state(STATE_MAINMENU);
	xor	a, a
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
	ret
;src/State_GameOver.c:36: void state_gameover_render(){
;	---------------------------------
; Function state_gameover_render
; ---------------------------------
_state_gameover_render::
;src/State_GameOver.c:38: }
	ret
;src/State_GameOver.c:40: void state_gameover_exit(){
;	---------------------------------
; Function state_gameover_exit
; ---------------------------------
_state_gameover_exit::
;src/State_GameOver.c:42: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
