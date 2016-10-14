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
	.globl _scan_input
	.globl _statemanager_change_state
	.globl _statemanager_drop_state
	.globl _cpct_waitVSYNC
	.globl _cpct_scanKeyboard_f
	.globl _last_keyboardStatusBuffer
	.globl _gameRunning
	.globl _inputReceived
	.globl _changeToState
	.globl _currentState
	.globl _closeState
	.globl _stateArray
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _statemanager_close_state
	.globl _statemanager_exit_game
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
;src/StateManager.c:79: void statemanager_drop_state(){
;	---------------------------------
; Function statemanager_drop_state
; ---------------------------------
_statemanager_drop_state::
;src/StateManager.c:80: if(closeState){
	ld	a,(#_closeState + 0)
	or	a, a
	ret	Z
;src/StateManager.c:81: stateArray[currentState].exitState();
	ld	bc,#_stateArray+0
	ld	hl,#_currentState + 0
	ld	e, (hl)
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	de, #0x000A
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	h,(hl)
	push	bc
	ld	l, e
	call	___sdcc_call_hl
	pop	bc
;src/StateManager.c:82: *(u8*)&currentState = stateArray[currentState].lastStateid;
	ld	hl,#_currentState + 0
	ld	e, (hl)
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl,bc
	inc	hl
	ld	c,(hl)
	ld	hl,#_currentState
	ld	(hl),c
;src/StateManager.c:83: *(u8*)&closeState=0;
	ld	hl,#_closeState
	ld	(hl),#0x00
	ret
_stateArray:
	.db #0x00	; 0
	.db #0x00	; 0
	.dw _state_mainmenu_enter
	.dw _state_mainmenu_input
	.dw _state_mainmenu_update
	.dw _state_mainmenu_render
	.dw _state_mainmenu_exit
	.db #0x01	; 1
	.db #0x00	; 0
	.dw _state_ingame_enter
	.dw _state_ingame_input
	.dw _state_ingame_update
	.dw _state_ingame_render
	.dw _state_ingame_exit
	.db #0x02	; 2
	.db #0x00	; 0
	.dw _state_pausemenu_enter
	.dw _state_pausemenu_input
	.dw _state_pausemenu_update
	.dw _state_pausemenu_render
	.dw _state_pausemenu_exit
	.db #0x03	; 3
	.db #0x00	; 0
	.dw _state_loadlevel_enter
	.dw _state_loadlevel_input
	.dw _state_loadlevel_update
	.dw _state_loadlevel_render
	.dw _state_loadlevel_exit
_closeState:
	.db #0x00	; 0
_currentState:
	.db #0x00	; 0
_changeToState:
	.db #0x00	; 0
_inputReceived:
	.db #0x00	; 0
_gameRunning:
	.db #0x01	; 1
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
;src/StateManager.c:87: void statemanager_change_state(){
;	---------------------------------
; Function statemanager_change_state
; ---------------------------------
_statemanager_change_state::
;src/StateManager.c:88: if(changeToState){
	ld	hl,#_changeToState + 0
	ld	c, (hl)
	ld	a,(#_changeToState + 0)
	or	a, a
	ret	Z
;src/StateManager.c:89: *(u8*)&(stateArray[changeToState-1].lastStateid) = currentState;
	ld	de,#_stateArray+0
	dec	c
	ld	b,#0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl,de
	inc	hl
	ld	iy,#_currentState
	ld	c,0 (iy)
	ld	(hl),c
;src/StateManager.c:90: *(u8*)&currentState = changeToState-1;
	ld	hl,#_currentState+0
	ld	iy,#_changeToState
	ld	c,0 (iy)
	dec	c
	ld	(hl),c
;src/StateManager.c:91: stateArray[currentState].enterState();
	ld	hl,#_currentState + 0
	ld	c, (hl)
	ld	b,#0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl,de
	inc	hl
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, c
	call	___sdcc_call_hl
;src/StateManager.c:92: *(u8*)&changeToState = 0;
	ld	hl,#_changeToState
	ld	(hl),#0x00
	ret
;src/StateManager.c:96: void statemanager_input_accepted(){
;	---------------------------------
; Function statemanager_input_accepted
; ---------------------------------
_statemanager_input_accepted::
;src/StateManager.c:97: *(u8*)&inputReceived=1;
	ld	hl,#_inputReceived
	ld	(hl),#0x01
	ret
;src/StateManager.c:100: void statemanager_set_state(u8 state){
;	---------------------------------
; Function statemanager_set_state
; ---------------------------------
_statemanager_set_state::
;src/StateManager.c:101: *(u8*)&changeToState = state+1;
	ld	bc,#_changeToState+0
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	inc	a
	ld	(bc),a
	ret
;src/StateManager.c:104: void scan_input(){
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
;src/StateManager.c:105: u8 t,n=10, anyKeyPressed=0xFF;
	ld	-3 (ix),#0xFF
;src/StateManager.c:106: u8* currentStatus=(cpct_keyboardStatusBuffer+n);
;src/StateManager.c:107: u8* lastStatus=(((u8*)last_keyboardStatusBuffer)+n);
;src/StateManager.c:109: cpct_scanKeyboard_f();
	call	_cpct_scanKeyboard_f
;src/StateManager.c:110: while(n){
	ld	-5 (ix),#0x0A
	ld	bc,#(_cpct_keyboardStatusBuffer + 0x000a)
	ld	de,#(_last_keyboardStatusBuffer + 0x000a)
00101$:
	ld	a,-5 (ix)
	or	a, a
	jr	Z,00104$
;src/StateManager.c:111: --n;
	dec	-5 (ix)
;src/StateManager.c:112: --currentStatus;
	dec	bc
;src/StateManager.c:113: --lastStatus;
	dec	de
;src/StateManager.c:115: t=*(currentStatus);
	ld	a,(bc)
	ld	-4 (ix),a
;src/StateManager.c:116: anyKeyPressed&=t;
	ld	a,-3 (ix)
	and	a, -4 (ix)
	ld	-3 (ix),a
;src/StateManager.c:117: *currentStatus=((*lastStatus)|(~t));
	ld	a,(de)
	ld	-2 (ix),a
	ld	a,-4 (ix)
	cpl
	ld	-1 (ix),a
	ld	a,-2 (ix)
	or	a, -1 (ix)
	ld	(bc),a
;src/StateManager.c:118: *lastStatus=t;
	ld	a,-4 (ix)
	ld	(de),a
	jr	00101$
00104$:
	ld	sp, ix
	pop	ix
	ret
;src/StateManager.c:125: void statemanager_manage_input(){
;	---------------------------------
; Function statemanager_manage_input
; ---------------------------------
_statemanager_manage_input::
;src/StateManager.c:126: while(!inputReceived){
00101$:
	ld	a,(#_inputReceived + 0)
	or	a, a
	jr	NZ,00103$
;src/StateManager.c:127: scan_input();
	call	_scan_input
;src/StateManager.c:128: stateArray[currentState].inputState();
	ld	hl,#_currentState + 0
	ld	c, (hl)
	ld	b,#0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	de,#_stateArray
	add	hl,de
	ld	de, #0x0004
	add	hl, de
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, c
	call	___sdcc_call_hl
	jr	00101$
00103$:
;src/StateManager.c:130: *(u8*)&inputReceived=0;
	ld	hl,#_inputReceived
	ld	(hl),#0x00
	ret
;src/StateManager.c:133: void statemanager_render_state(){
;	---------------------------------
; Function statemanager_render_state
; ---------------------------------
_statemanager_render_state::
;src/StateManager.c:134: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
;src/StateManager.c:135: stateArray[currentState].renderState();
	ld	bc,#_stateArray+0
	ld	hl,#_currentState + 0
	ld	e, (hl)
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	de, #0x0008
	add	hl, de
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, c
	jp  ___sdcc_call_hl
;src/StateManager.c:138: void statemanager_close_state(){
;	---------------------------------
; Function statemanager_close_state
; ---------------------------------
_statemanager_close_state::
;src/StateManager.c:139: *(u8*)&closeState=1;
	ld	hl,#_closeState
	ld	(hl),#0x01
	ret
;src/StateManager.c:142: void statemanager_update_state(){
;	---------------------------------
; Function statemanager_update_state
; ---------------------------------
_statemanager_update_state::
;src/StateManager.c:143: stateArray[currentState].updateState();
	ld	bc,#_stateArray+0
	ld	hl,#_currentState + 0
	ld	e, (hl)
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	de, #0x0006
	add	hl, de
	ld	c,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, c
	jp  ___sdcc_call_hl
;src/StateManager.c:146: void statemanager_exit_game(){
;	---------------------------------
; Function statemanager_exit_game
; ---------------------------------
_statemanager_exit_game::
;src/StateManager.c:147: *(u8*)&gameRunning=0;
	ld	hl,#_gameRunning
	ld	(hl),#0x00
	ret
;src/StateManager.c:150: void statemanager_main_loop(){
;	---------------------------------
; Function statemanager_main_loop
; ---------------------------------
_statemanager_main_loop::
;src/StateManager.c:151: while(gameRunning) {
00101$:
	ld	a,(#_gameRunning + 0)
	or	a, a
	ret	Z
;src/StateManager.c:152: statemanager_drop_state();
	call	_statemanager_drop_state
;src/StateManager.c:153: statemanager_change_state();
	call	_statemanager_change_state
;src/StateManager.c:154: statemanager_manage_input();
	call	_statemanager_manage_input
;src/StateManager.c:155: statemanager_update_state();
	call	_statemanager_update_state
;src/StateManager.c:156: statemanager_render_state();
	call	_statemanager_render_state
	jr	00101$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
