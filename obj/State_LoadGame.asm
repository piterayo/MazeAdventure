;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_LoadGame
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ui_loadgame_render_all
	.globl _ui_loadgame_unselect_entry
	.globl _ui_loadgame_select_entry
	.globl _ui_loadgame_previous_entry
	.globl _ui_loadgame_next_entry
	.globl _ui_loadgame_is_selected
	.globl _ui_loadgame_get_entry
	.globl _ui_loadgame_init
	.globl _ui_stringinput_remove_char
	.globl _ui_stringinput_get_string
	.globl _ui_stringinput_add_char
	.globl _ui_stringinput_init
	.globl _savegame_Load
	.globl _statemanager_input_accepted
	.globl _statemanager_close_state
	.globl _cpct_drawSolidBox
	.globl _cpct_isKeyPressed
	.globl _state_loadgame_enter
	.globl _state_loadgame_return
	.globl _state_loadgame_input
	.globl _state_loadgame_update
	.globl _state_loadgame_render
	.globl _state_loadgame_exit
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
;src/State_LoadGame.c:17: void state_loadgame_enter(){
;	---------------------------------
; Function state_loadgame_enter
; ---------------------------------
_state_loadgame_enter::
;src/State_LoadGame.c:18: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 18, 79), g_colors[4], 44, 42);
	ld	hl, #_g_colors + 4
	ld	b,(hl)
	ld	hl,#0x2A2C
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xFAE2
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/State_LoadGame.c:19: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 19, 83), g_colors[1], 42, 34);
	ld	hl, #_g_colors + 1
	ld	b,(hl)
	ld	hl,#0x222A
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xDB33
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/State_LoadGame.c:20: ui_loadgame_init();
	call	_ui_loadgame_init
;src/State_LoadGame.c:21: ui_stringinput_init();
	call	_ui_stringinput_init
;src/State_LoadGame.c:22: ui_loadgame_render_all();
	jp  _ui_loadgame_render_all
;src/State_LoadGame.c:25: void state_loadgame_return(){
;	---------------------------------
; Function state_loadgame_return
; ---------------------------------
_state_loadgame_return::
;src/State_LoadGame.c:27: }
	ret
;src/State_LoadGame.c:30: void state_loadgame_input(){
;	---------------------------------
; Function state_loadgame_input
; ---------------------------------
_state_loadgame_input::
;src/State_LoadGame.c:33: if(cpct_isKeyPressed(Key_CursorLeft)){
	ld	hl,#0x0101
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00185$
;src/State_LoadGame.c:34: ui_loadgame_previous_entry();
	call	_ui_loadgame_previous_entry
;src/State_LoadGame.c:35: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00185$:
;src/State_LoadGame.c:37: else if(cpct_isKeyPressed(Key_CursorRight)){
	ld	hl,#0x0200
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00182$
;src/State_LoadGame.c:38: ui_loadgame_next_entry();
	call	_ui_loadgame_next_entry
;src/State_LoadGame.c:39: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00182$:
;src/State_LoadGame.c:41: else if(cpct_isKeyPressed(Key_Return)){
	ld	hl,#0x0402
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00179$
;src/State_LoadGame.c:42: ui_loadgame_select_entry();
	call	_ui_loadgame_select_entry
;src/State_LoadGame.c:43: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00179$:
;src/State_LoadGame.c:45: else if(cpct_isKeyPressed(Key_0)){
	ld	hl,#0x0104
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00176$
;src/State_LoadGame.c:46: ui_stringinput_add_char('0');
	ld	a,#0x30
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:47: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00176$:
;src/State_LoadGame.c:49: else if(cpct_isKeyPressed(Key_1)){
	ld	hl,#0x0108
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00173$
;src/State_LoadGame.c:50: ui_stringinput_add_char('1');
	ld	a,#0x31
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:51: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00173$:
;src/State_LoadGame.c:53: else if(cpct_isKeyPressed(Key_2)){
	ld	hl,#0x0208
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00170$
;src/State_LoadGame.c:54: ui_stringinput_add_char('2');
	ld	a,#0x32
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:55: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00170$:
;src/State_LoadGame.c:57: else if(cpct_isKeyPressed(Key_3)){
	ld	hl,#0x0207
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00167$
;src/State_LoadGame.c:58: ui_stringinput_add_char('3');
	ld	a,#0x33
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:59: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00167$:
;src/State_LoadGame.c:61: else if(cpct_isKeyPressed(Key_4)){
	ld	hl,#0x0107
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00164$
;src/State_LoadGame.c:62: ui_stringinput_add_char('4');
	ld	a,#0x34
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:63: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00164$:
;src/State_LoadGame.c:65: else if(cpct_isKeyPressed(Key_5)){
	ld	hl,#0x0206
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00161$
;src/State_LoadGame.c:66: ui_stringinput_add_char('5');
	ld	a,#0x35
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:67: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00161$:
;src/State_LoadGame.c:69: else if(cpct_isKeyPressed(Key_6)){
	ld	hl,#0x0106
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00158$
;src/State_LoadGame.c:70: ui_stringinput_add_char('6');
	ld	a,#0x36
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:71: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00158$:
;src/State_LoadGame.c:73: else if(cpct_isKeyPressed(Key_7)){
	ld	hl,#0x0205
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00155$
;src/State_LoadGame.c:74: ui_stringinput_add_char('7');
	ld	a,#0x37
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:75: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00155$:
;src/State_LoadGame.c:77: else if(cpct_isKeyPressed(Key_8)){
	ld	hl,#0x0105
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00152$
;src/State_LoadGame.c:78: ui_stringinput_add_char('8');
	ld	a,#0x38
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:79: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00152$:
;src/State_LoadGame.c:81: else if(cpct_isKeyPressed(Key_9)){
	ld	hl,#0x0204
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00149$
;src/State_LoadGame.c:82: ui_stringinput_add_char('9');
	ld	a,#0x39
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:83: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00149$:
;src/State_LoadGame.c:85: else if(cpct_isKeyPressed(Key_A)){
	ld	hl,#0x2008
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00146$
;src/State_LoadGame.c:86: ui_stringinput_add_char('A');
	ld	a,#0x41
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:87: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00146$:
;src/State_LoadGame.c:89: else if(cpct_isKeyPressed(Key_B)){
	ld	hl,#0x4006
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00143$
;src/State_LoadGame.c:90: ui_stringinput_add_char('B');
	ld	a,#0x42
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:91: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00143$:
;src/State_LoadGame.c:93: else if(cpct_isKeyPressed(Key_C)){
	ld	hl,#0x4007
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00140$
;src/State_LoadGame.c:94: ui_stringinput_add_char('C');
	ld	a,#0x43
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:95: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00140$:
;src/State_LoadGame.c:97: else if(cpct_isKeyPressed(Key_D)){
	ld	hl,#0x2007
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00137$
;src/State_LoadGame.c:98: ui_stringinput_add_char('D');
	ld	a,#0x44
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:99: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00137$:
;src/State_LoadGame.c:101: else if(cpct_isKeyPressed(Key_E)){
	ld	hl,#0x0407
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00134$
;src/State_LoadGame.c:102: ui_stringinput_add_char('E');
	ld	a,#0x45
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:103: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00134$:
;src/State_LoadGame.c:105: else if(cpct_isKeyPressed(Key_F)){
	ld	hl,#0x2006
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00131$
;src/State_LoadGame.c:106: ui_stringinput_add_char('F');
	ld	a,#0x46
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:107: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00131$:
;src/State_LoadGame.c:109: else if(cpct_isKeyPressed(Key_M)){
	ld	hl,#0x4004
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00128$
;src/State_LoadGame.c:110: ui_stringinput_add_char('M');
	ld	a,#0x4D
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:111: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00128$:
;src/State_LoadGame.c:113: else if(cpct_isKeyPressed(Key_I)){
	ld	hl,#0x0804
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00125$
;src/State_LoadGame.c:114: ui_stringinput_add_char('I');
	ld	a,#0x49
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:115: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00125$:
;src/State_LoadGame.c:117: else if(cpct_isKeyPressed(Key_L)){
	ld	hl,#0x1004
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00122$
;src/State_LoadGame.c:118: ui_stringinput_add_char('L');
	ld	a,#0x4C
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:119: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00122$:
;src/State_LoadGame.c:121: else if(cpct_isKeyPressed(Key_O)){
	ld	hl,#0x0404
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00119$
;src/State_LoadGame.c:122: ui_stringinput_add_char('O');
	ld	a,#0x4F
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:123: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00119$:
;src/State_LoadGame.c:125: else if(cpct_isKeyPressed(Key_T)){
	ld	hl,#0x0806
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00116$
;src/State_LoadGame.c:126: ui_stringinput_add_char('T');
	ld	a,#0x54
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:127: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00116$:
;src/State_LoadGame.c:129: else if(cpct_isKeyPressed(Key_W)){
	ld	hl,#0x0807
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00113$
;src/State_LoadGame.c:130: ui_stringinput_add_char('W');
	ld	a,#0x57
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:131: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00113$:
;src/State_LoadGame.c:133: else if(cpct_isKeyPressed(Key_R)){
	ld	hl,#0x0406
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00110$
;src/State_LoadGame.c:134: ui_stringinput_add_char('R');
	ld	a,#0x52
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:135: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00110$:
;src/State_LoadGame.c:137: else if(cpct_isKeyPressed(Key_S)){
	ld	hl,#0x1007
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00107$
;src/State_LoadGame.c:138: ui_stringinput_add_char('S');
	ld	a,#0x53
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:139: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00107$:
;src/State_LoadGame.c:141: else if(cpct_isKeyPressed(Key_Space)){
	ld	hl,#0x8005
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00104$
;src/State_LoadGame.c:142: ui_stringinput_add_char(' ');
	ld	a,#0x20
	push	af
	inc	sp
	call	_ui_stringinput_add_char
	inc	sp
;src/State_LoadGame.c:143: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00104$:
;src/State_LoadGame.c:145: else if(cpct_isKeyPressed(Key_Del)){
	ld	hl,#0x8009
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	ret	Z
;src/State_LoadGame.c:146: ui_stringinput_remove_char();
	call	_ui_stringinput_remove_char
;src/State_LoadGame.c:147: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_LoadGame.c:151: void state_loadgame_update(){
;	---------------------------------
; Function state_loadgame_update
; ---------------------------------
_state_loadgame_update::
;src/State_LoadGame.c:152: if(ui_loadgame_is_selected()){
	call	_ui_loadgame_is_selected
	ld	a,l
	or	a, a
	jp	Z,_ui_loadgame_unselect_entry
;src/State_LoadGame.c:153: ui_loadgame_render_all();
	call	_ui_loadgame_render_all
;src/State_LoadGame.c:154: switch(ui_loadgame_get_entry()){
	call	_ui_loadgame_get_entry
	ld	a,l
	or	a, a
	jr	Z,00101$
	dec	l
	jr	Z,00102$
	jp	_ui_loadgame_unselect_entry
;src/State_LoadGame.c:155: case 0:{
00101$:
;src/State_LoadGame.c:156: savegame_Load(ui_stringinput_get_string());
	call	_ui_stringinput_get_string
	push	hl
	call	_savegame_Load
	pop	af
;src/State_LoadGame.c:157: break;
	jp	_ui_loadgame_unselect_entry
;src/State_LoadGame.c:159: case 1:{//Try
00102$:
;src/State_LoadGame.c:160: statemanager_close_state();
	call	_statemanager_close_state
;src/State_LoadGame.c:163: }
;src/State_LoadGame.c:165: ui_loadgame_unselect_entry();
	jp  _ui_loadgame_unselect_entry
;src/State_LoadGame.c:168: void state_loadgame_render(){
;	---------------------------------
; Function state_loadgame_render
; ---------------------------------
_state_loadgame_render::
;src/State_LoadGame.c:169: ui_loadgame_render_all();
	jp  _ui_loadgame_render_all
;src/State_LoadGame.c:172: void state_loadgame_exit(){
;	---------------------------------
; Function state_loadgame_exit
; ---------------------------------
_state_loadgame_exit::
;src/State_LoadGame.c:173: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 18, 79), g_colors[1], 44, 42);
	ld	hl, #(_g_colors + 0x0001) + 0
	ld	b,(hl)
	ld	hl,#0x2A2C
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xFAE2
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
