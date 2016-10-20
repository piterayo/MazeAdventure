;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _statemanager_main_loop
	.globl _statemanager_set_state
	.globl _game_init
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
;src/main.c:27: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:29: game_init();
	call	_game_init
;src/main.c:31: statemanager_set_state(STATE_MAINMENU);
	ld	l,#0x00
	call	_statemanager_set_state
;src/main.c:33: statemanager_main_loop();
	jp  _statemanager_main_loop
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
