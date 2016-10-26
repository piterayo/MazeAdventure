;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_Credits
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _statemanager_input_accepted
	.globl _statemanager_close_state
	.globl _print_transparent_text
	.globl _cpct_drawSolidBox
	.globl _cpct_isAnyKeyPressed_f
	.globl _state_credits_enter
	.globl _state_credits_return
	.globl _state_credits_input
	.globl _state_credits_update
	.globl _state_credits_render
	.globl _state_credits_exit
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
;src/State_Credits.c:16: void state_credits_enter(){
;	---------------------------------
; Function state_credits_enter
; ---------------------------------
_state_credits_enter::
;src/State_Credits.c:18: cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,14,46),g_colors[4],52,92);
	ld	hl, #_g_colors + 4
	ld	b,(hl)
	ld	hl,#0x5C34
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xF19E
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/State_Credits.c:19: cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,15,50),g_colors[1],50,84);
	ld	hl, #_g_colors + 1
	ld	b,(hl)
	ld	hl,#0x5432
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xD1EF
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/State_Credits.c:21: print_transparent_text("CODING:", cpctm_screenPtr((u16)CPCT_VMEM_START,16,54),3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xF1F0
	push	hl
	ld	hl,#___str_0
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/State_Credits.c:22: print_transparent_text("Albert Sirvent @piterayo",cpctm_screenPtr((u16)CPCT_VMEM_START,16,62),3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xF240
	push	hl
	ld	hl,#___str_1
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/State_Credits.c:24: print_transparent_text("ART:",cpctm_screenPtr((u16)CPCT_VMEM_START,16,78),3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xF2E0
	push	hl
	ld	hl,#___str_2
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/State_Credits.c:25: print_transparent_text("Alejandro Padilla",cpctm_screenPtr((u16)CPCT_VMEM_START,16,86),3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xF330
	push	hl
	ld	hl,#___str_3
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/State_Credits.c:27: print_transparent_text("MUSIC:",cpctm_screenPtr((u16)CPCT_VMEM_START,16,102),3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xF3D0
	push	hl
	ld	hl,#___str_4
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/State_Credits.c:28: print_transparent_text("Carlos Blaya",cpctm_screenPtr((u16)CPCT_VMEM_START,16,110),3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xF420
	push	hl
	ld	hl,#___str_5
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
	ret
___str_0:
	.ascii "CODING:"
	.db 0x00
___str_1:
	.ascii "Albert Sirvent @piterayo"
	.db 0x00
___str_2:
	.ascii "ART:"
	.db 0x00
___str_3:
	.ascii "Alejandro Padilla"
	.db 0x00
___str_4:
	.ascii "MUSIC:"
	.db 0x00
___str_5:
	.ascii "Carlos Blaya"
	.db 0x00
;src/State_Credits.c:32: void state_credits_return(){
;	---------------------------------
; Function state_credits_return
; ---------------------------------
_state_credits_return::
;src/State_Credits.c:34: }
	ret
;src/State_Credits.c:36: void state_credits_input(){
;	---------------------------------
; Function state_credits_input
; ---------------------------------
_state_credits_input::
;src/State_Credits.c:37: if(cpct_isAnyKeyPressed_f ()){
	call	_cpct_isAnyKeyPressed_f
	ld	a,l
	or	a, a
	ret	Z
;src/State_Credits.c:38: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_Credits.c:42: void state_credits_update(){
;	---------------------------------
; Function state_credits_update
; ---------------------------------
_state_credits_update::
;src/State_Credits.c:43: statemanager_close_state();
	jp  _statemanager_close_state
;src/State_Credits.c:46: void state_credits_render(){
;	---------------------------------
; Function state_credits_render
; ---------------------------------
_state_credits_render::
;src/State_Credits.c:48: }
	ret
;src/State_Credits.c:50: void state_credits_exit(){
;	---------------------------------
; Function state_credits_exit
; ---------------------------------
_state_credits_exit::
;src/State_Credits.c:51: cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,14,46),g_colors[1],52,92);
	ld	hl, #(_g_colors + 0x0001) + 0
	ld	b,(hl)
	ld	hl,#0x5C34
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xF19E
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
