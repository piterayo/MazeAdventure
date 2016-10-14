;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module StateManager
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _statemanager_update_state
	.globl _statemanager_render_state
	.globl _statemanager_manage_input
	.globl _statemanager_change_state
	.globl _cpct_waitVSYNC
	.globl _cpct_scanKeyboard_f
	.globl _last_keyboardStatusBuffer
	.globl _inputReceived
	.globl _changeToState
	.globl _currentState
	.globl _stateArray
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _scan_input
	.globl _statemanager_close_state
	.globl _statemanager_main_loop
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
;src/StateManager.c:52: void statemanager_change_state(){
;	---------------------------------
; Function statemanager_change_state
; ---------------------------------
_statemanager_change_state::
;src/StateManager.c:53: if(changeToState){
	ld	hl,#_changeToState + 0
	ld	c, (hl)
	ld	a,(#_changeToState + 0)
	or	a, a
	ret	Z
;src/StateManager.c:54: *(u8*)&currentState = changeToState-1;
	ld	hl,#_currentState+0
	dec	c
	ld	(hl),c
;src/StateManager.c:55: stateArray[currentState].enterState();
	ld	bc,#_stateArray+0
	ld	hl,#_currentState + 0
	ld	e, (hl)
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl,bc
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, c
	call	___sdcc_call_hl
;src/StateManager.c:56: *(u8*)&changeToState = 0;
	ld	hl,#_changeToState
	ld	(hl),#0x00
	ret
_stateArray:
	.dw _state_mainmenu_enter
	.dw _state_mainmenu_input
	.dw _state_mainmenu_update
	.dw _state_mainmenu_render
	.dw _state_mainmenu_exit
	.dw _state_ingame_enter
	.dw _state_ingame_input
	.dw _state_ingame_update
	.dw _state_ingame_render
	.dw _state_ingame_exit
	.dw _state_pausemenu_enter
	.dw _state_pausemenu_input
	.dw _state_pausemenu_update
	.dw _state_pausemenu_render
	.dw _state_pausemenu_exit
_currentState:
	.db #0x00	; 0
_changeToState:
	.db #0x00	; 0
_inputReceived:
	.db #0x00	; 0
_last_keyboardStatusBuffer:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
;src/StateManager.c:60: void statemanager_input_accepted(){
;	---------------------------------
; Function statemanager_input_accepted
; ---------------------------------
_statemanager_input_accepted::
;src/StateManager.c:61: *(u8*)&inputReceived=1;
	ld	hl,#_inputReceived
	ld	(hl),#0x01
	ret
;src/StateManager.c:64: void statemanager_set_state(u8 state){
;	---------------------------------
; Function statemanager_set_state
; ---------------------------------
_statemanager_set_state::
;src/StateManager.c:65: *(u8*)&changeToState = state+1;
	ld	bc,#_changeToState+0
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	inc	a
	ld	(bc),a
	ret
;src/StateManager.c:68: void scan_input(){
;	---------------------------------
; Function scan_input
; ---------------------------------
_scan_input::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	dec	sp
;src/StateManager.c:69: u8 t,n=10, anyKeyPressed=0xFF;
	ld	-3 (ix),#0xFF
;src/StateManager.c:70: u8* currentStatus=(cpct_keyboardStatusBuffer+n);
;src/StateManager.c:71: u8* lastStatus=(((u8*)last_keyboardStatusBuffer)+n);
;src/StateManager.c:73: cpct_scanKeyboard_f();
	call	_cpct_scanKeyboard_f
;src/StateManager.c:74: while(n){
	ld	-5 (ix),#0x0A
	ld	bc,#(_cpct_keyboardStatusBuffer + 0x000a)
	ld	de,#(_last_keyboardStatusBuffer + 0x000a)
00101$:
	ld	a,-5 (ix)
	or	a, a
	jr	Z,00104$
;src/StateManager.c:75: --n;
	dec	-5 (ix)
;src/StateManager.c:76: --currentStatus;
	dec	bc
;src/StateManager.c:77: --lastStatus;
	dec	de
;src/StateManager.c:79: t=*(currentStatus);
	ld	a,(bc)
	ld	-4 (ix),a
;src/StateManager.c:80: anyKeyPressed&=t;
	ld	a,-3 (ix)
	and	a, -4 (ix)
	ld	-3 (ix),a
;src/StateManager.c:81: *currentStatus=((*lastStatus)|(~t));
	ld	a,(de)
	ld	-2 (ix),a
	ld	a,-4 (ix)
	cpl
	ld	-1 (ix),a
	ld	a,-2 (ix)
	or	a, -1 (ix)
	ld	(bc),a
;src/StateManager.c:82: *lastStatus=t;
	ld	a,-4 (ix)
	ld	(de),a
	jr	00101$
00104$:
	ld	sp, ix
	pop	ix
	ret
;src/StateManager.c:89: void statemanager_manage_input(){
;	---------------------------------
; Function statemanager_manage_input
; ---------------------------------
_statemanager_manage_input::
;src/StateManager.c:90: while(!inputReceived){
00101$:
	ld	a,(#_inputReceived + 0)
	or	a, a
	jr	NZ,00103$
;src/StateManager.c:91: scan_input();
	call	_scan_input
;src/StateManager.c:92: stateArray[currentState].inputState();
	ld	hl,#_currentState + 0
	ld	c, (hl)
	ld	b,#0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	de,#_stateArray
	add	hl,de
	inc	hl
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, c
	call	___sdcc_call_hl
	jr	00101$
00103$:
;src/StateManager.c:94: *(u8*)&inputReceived=0;
	ld	hl,#_inputReceived
	ld	(hl),#0x00
	ret
;src/StateManager.c:97: void statemanager_render_state(){
;	---------------------------------
; Function statemanager_render_state
; ---------------------------------
_statemanager_render_state::
;src/StateManager.c:98: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/StateManager.c:99: stateArray[currentState].renderState();
	ld	bc,#_stateArray+0
	ld	hl,#_currentState + 0
	ld	e, (hl)
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl,bc
	ld	de, #0x0006
	add	hl, de
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, c
	jp  ___sdcc_call_hl
;src/StateManager.c:102: void statemanager_close_state(u8 state){
;	---------------------------------
; Function statemanager_close_state
; ---------------------------------
_statemanager_close_state::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/StateManager.c:103: stateArray[state].exitState();
	ld	bc,#_stateArray+0
	ld	e,4 (ix)
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl,bc
	ld	de, #0x0008
	add	hl, de
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, c
	pop	ix
	jp	___sdcc_call_hl
;src/StateManager.c:106: void statemanager_update_state(){
;	---------------------------------
; Function statemanager_update_state
; ---------------------------------
_statemanager_update_state::
;src/StateManager.c:107: stateArray[currentState].updateState();
	ld	bc,#_stateArray+0
	ld	hl,#_currentState + 0
	ld	e, (hl)
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl,bc
	ld	de, #0x0004
	add	hl, de
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, c
	jp  ___sdcc_call_hl
;src/StateManager.c:110: void statemanager_main_loop(){
;	---------------------------------
; Function statemanager_main_loop
; ---------------------------------
_statemanager_main_loop::
;src/StateManager.c:111: while(1) {
00102$:
;src/StateManager.c:112: statemanager_change_state();
	call	_statemanager_change_state
;src/StateManager.c:113: statemanager_manage_input();
	call	_statemanager_manage_input
;src/StateManager.c:114: statemanager_update_state();
	call	_statemanager_update_state
;src/StateManager.c:115: statemanager_render_state();
	call	_statemanager_render_state
	jr	00102$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
