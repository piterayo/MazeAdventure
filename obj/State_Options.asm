;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_Options
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
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
;src/State_Options.c:7: void state_options_enter(){
;	---------------------------------
; Function state_options_enter
; ---------------------------------
_state_options_enter::
;src/State_Options.c:9: }
	ret
;src/State_Options.c:11: void state_options_return(){
;	---------------------------------
; Function state_options_return
; ---------------------------------
_state_options_return::
;src/State_Options.c:13: }
	ret
;src/State_Options.c:15: void state_options_input(){
;	---------------------------------
; Function state_options_input
; ---------------------------------
_state_options_input::
;src/State_Options.c:17: }
	ret
;src/State_Options.c:19: void state_options_update(){
;	---------------------------------
; Function state_options_update
; ---------------------------------
_state_options_update::
;src/State_Options.c:21: }
	ret
;src/State_Options.c:23: void state_options_render(){
;	---------------------------------
; Function state_options_render
; ---------------------------------
_state_options_render::
;src/State_Options.c:25: }
	ret
;src/State_Options.c:27: void state_options_exit(){
;	---------------------------------
; Function state_options_exit
; ---------------------------------
_state_options_exit::
;src/State_Options.c:29: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
