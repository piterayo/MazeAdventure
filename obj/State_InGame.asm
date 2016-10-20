;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_InGame
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ui_playerstats_render
	.globl _ui_gamemenu_render_refresh
	.globl _ui_gamemenu_render_all
	.globl _ui_gamemenu_unselect_entry
	.globl _ui_gamemenu_select_entry
	.globl _ui_gamemenu_below_entry
	.globl _ui_gamemenu_above_entry
	.globl _ui_gamemenu_previous_entry
	.globl _ui_gamemenu_next_entry
	.globl _ui_gamemenu_is_selected
	.globl _ui_gamemenu_get_entry
	.globl _ui_gamemenu_get_action
	.globl _ui_gamemenu_update_action
	.globl _ui_gamemenu_init
	.globl _renderCompass
	.globl _level_get_level
	.globl _level_set_level
	.globl _draw_minimap_to_buffer
	.globl _render_draw_to_buffer
	.globl _player_move_forward
	.globl _player_turn_right
	.globl _player_turn_left
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _statemanager_close_state
	.globl _cpct_drawSprite
	.globl _cpct_isKeyPressed
	.globl _cpct_memset
	.globl _action
	.globl _updateRenderBuffer
	.globl _state_ingame_enter
	.globl _state_ingame_return
	.globl _state_ingame_input
	.globl _state_ingame_update
	.globl _state_ingame_render
	.globl _state_ingame_exit
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
;src/State_InGame.c:27: void state_ingame_enter(){
;	---------------------------------
; Function state_ingame_enter
; ---------------------------------
_state_ingame_enter::
;src/State_InGame.c:29: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
	ld	hl, #(_g_colors + 0x0001) + 0
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/State_InGame.c:31: ui_gamemenu_init();
	call	_ui_gamemenu_init
;src/State_InGame.c:32: ui_gamemenu_render_all();
	call	_ui_gamemenu_render_all
;src/State_InGame.c:33: state_ingame_render();
	call	_state_ingame_render
	ret
_updateRenderBuffer:
	.db #0x00	; 0
_action:
	.db #0x00	; 0
;src/State_InGame.c:36: void state_ingame_return(){
;	---------------------------------
; Function state_ingame_return
; ---------------------------------
_state_ingame_return::
;src/State_InGame.c:37: ui_gamemenu_render_all();
	call	_ui_gamemenu_render_all
;src/State_InGame.c:38: state_ingame_render();
	jp  _state_ingame_render
;src/State_InGame.c:41: void state_ingame_input(){
;	---------------------------------
; Function state_ingame_input
; ---------------------------------
_state_ingame_input::
;src/State_InGame.c:43: if(cpct_isKeyPressed(Key_CursorLeft)){
	ld	hl,#0x0101
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00119$
;src/State_InGame.c:44: ui_gamemenu_previous_entry();
	call	_ui_gamemenu_previous_entry
;src/State_InGame.c:45: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00119$:
;src/State_InGame.c:47: else if(cpct_isKeyPressed(Key_CursorRight)){
	ld	hl,#0x0200
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00116$
;src/State_InGame.c:48: ui_gamemenu_next_entry();
	call	_ui_gamemenu_next_entry
;src/State_InGame.c:49: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00116$:
;src/State_InGame.c:51: else if(cpct_isKeyPressed(Key_CursorUp)){
	ld	hl,#0x0100
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00113$
;src/State_InGame.c:52: ui_gamemenu_above_entry();
	call	_ui_gamemenu_above_entry
;src/State_InGame.c:53: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00113$:
;src/State_InGame.c:55: else if(cpct_isKeyPressed(Key_CursorDown)){
	ld	hl,#0x0400
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00110$
;src/State_InGame.c:56: ui_gamemenu_below_entry();
	call	_ui_gamemenu_below_entry
;src/State_InGame.c:57: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00110$:
;src/State_InGame.c:59: else if(cpct_isKeyPressed(Key_Return)){
	ld	hl,#0x0402
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00107$
;src/State_InGame.c:60: ui_gamemenu_select_entry();
	call	_ui_gamemenu_select_entry
;src/State_InGame.c:61: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00107$:
;src/State_InGame.c:64: else if(cpct_isKeyPressed(Key_T)){
	ld	hl,#0x0806
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00104$
;src/State_InGame.c:65: *(u8*)&g_texturedWalls = !g_texturedWalls;
	ld	a,(#_g_texturedWalls + 0)
	sub	a,#0x01
	ld	a,#0x00
	rla
	ld	c,a
	ld	hl,#_g_texturedWalls
	ld	(hl),c
;src/State_InGame.c:66: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00104$:
;src/State_InGame.c:68: else if(cpct_isKeyPressed(Key_Tab)){
	ld	hl,#0x1008
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	ret	Z
;src/State_InGame.c:69: level_set_level(level_get_level()+1);
	call	_level_get_level
	inc	l
	call	_level_set_level
;src/State_InGame.c:70: statemanager_close_state();
	call	_statemanager_close_state
;src/State_InGame.c:71: statemanager_set_state(STATE_LOADLEVEL);
	ld	l,#0x03
	call	_statemanager_set_state
;src/State_InGame.c:72: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_InGame.c:76: void state_ingame_update(){
;	---------------------------------
; Function state_ingame_update
; ---------------------------------
_state_ingame_update::
;src/State_InGame.c:78: *(u8*)&action=NONE;
	ld	hl,#_action
	ld	(hl),#0x00
;src/State_InGame.c:80: if(ui_gamemenu_is_selected()){
	call	_ui_gamemenu_is_selected
	ld	a,l
	or	a, a
	jp	Z,00114$
;src/State_InGame.c:81: ui_gamemenu_render_refresh();
	call	_ui_gamemenu_render_refresh
;src/State_InGame.c:82: switch(ui_gamemenu_get_entry()){
	call	_ui_gamemenu_get_entry
	ld	e,l
	ld	a,#0x06
	sub	a, e
	jr	C,00112$
	ld	d,#0x00
	ld	hl,#00139$
	add	hl,de
	add	hl,de
;src/State_InGame.c:83: case 0:{//ACTION BUTTON
	jp	(hl)
00139$:
	jr	00101$
	jr	00112$
	jr	00107$
	jr	00108$
	jr	00109$
	jr	00112$
	jr	00111$
00101$:
;src/State_InGame.c:85: switch(ui_gamemenu_get_action()){
	call	_ui_gamemenu_get_action
	ld	e,l
	ld	a,e
	sub	a, #0x01
	jr	C,00112$
	ld	a,#0x03
	sub	a, e
	jr	C,00112$
	dec	e
	ld	d,#0x00
	ld	hl,#00140$
	add	hl,de
	add	hl,de
;src/State_InGame.c:86: case 1:{
	jp	(hl)
00140$:
	jr	00102$
	jr	00112$
	jr	00112$
00102$:
;src/State_InGame.c:87: level_set_level(level_get_level()+1);
	call	_level_get_level
	inc	l
	call	_level_set_level
;src/State_InGame.c:88: statemanager_close_state();
	call	_statemanager_close_state
;src/State_InGame.c:89: statemanager_set_state(STATE_LOADLEVEL);
	ld	l,#0x03
	call	_statemanager_set_state
;src/State_InGame.c:91: break;
	jr	00112$
;src/State_InGame.c:93: case 2:{
;src/State_InGame.c:95: break;
	jr	00112$
;src/State_InGame.c:97: case 3:{
;src/State_InGame.c:102: break;
	jr	00112$
;src/State_InGame.c:104: case 1:{//INVENTORY
;src/State_InGame.c:107: break;
	jr	00112$
;src/State_InGame.c:109: case 2:{//TURN LEFT
00107$:
;src/State_InGame.c:111: player_turn_left();
	call	_player_turn_left
;src/State_InGame.c:112: ui_gamemenu_update_action();
	call	_ui_gamemenu_update_action
;src/State_InGame.c:114: *(u8*)&updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer
	ld	(hl),#0x01
;src/State_InGame.c:115: break;
	jr	00112$
;src/State_InGame.c:117: case 3:{//MOVE
00108$:
;src/State_InGame.c:119: player_move_forward();
	call	_player_move_forward
;src/State_InGame.c:120: ui_gamemenu_update_action();
	call	_ui_gamemenu_update_action
;src/State_InGame.c:121: *(u8*)&updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer
	ld	(hl),#0x01
;src/State_InGame.c:123: break;
	jr	00112$
;src/State_InGame.c:125: case 4:{//TURN RIGHT
00109$:
;src/State_InGame.c:126: player_turn_right();
	call	_player_turn_right
;src/State_InGame.c:127: ui_gamemenu_update_action();
	call	_ui_gamemenu_update_action
;src/State_InGame.c:129: *(u8*)&updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer
;src/State_InGame.c:131: break;
;src/State_InGame.c:133: case 5:{//WAIT
;src/State_InGame.c:135: break;
	ld	(hl), #0x01
	jr	00112$
;src/State_InGame.c:137: case 6:{//PAUSE
00111$:
;src/State_InGame.c:138: statemanager_set_state(STATE_PAUSEMENU);
	ld	l,#0x02
	call	_statemanager_set_state
;src/State_InGame.c:141: }
00112$:
;src/State_InGame.c:142: ui_gamemenu_unselect_entry();
	call	_ui_gamemenu_unselect_entry
00114$:
;src/State_InGame.c:145: if(updateRenderBuffer){
	ld	a,(#_updateRenderBuffer + 0)
	or	a, a
	ret	Z
;src/State_InGame.c:146: render_draw_to_buffer();
	call	_render_draw_to_buffer
;src/State_InGame.c:147: draw_minimap_to_buffer();
	call	_draw_minimap_to_buffer
;src/State_InGame.c:148: *(u8*)&updateRenderBuffer = 0;
	ld	hl,#_updateRenderBuffer
	ld	(hl),#0x00
	ret
;src/State_InGame.c:153: void state_ingame_render(){
;	---------------------------------
; Function state_ingame_render
; ---------------------------------
_state_ingame_render::
;src/State_InGame.c:154: ui_gamemenu_render_refresh();
	call	_ui_gamemenu_render_refresh
;src/State_InGame.c:155: renderCompass();
	call	_renderCompass
;src/State_InGame.c:156: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
	ld	hl,#0x6428
	push	hl
	ld	hl,#0xC0B4
	push	hl
	ld	hl,#0x9B00
	push	hl
	call	_cpct_drawSprite
;src/State_InGame.c:157: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
	ld	hl,#0x4010
	push	hl
	ld	hl,#0xC522
	push	hl
	ld	hl,#0xAAA0
	push	hl
	call	_cpct_drawSprite
;src/State_InGame.c:158: ui_playerstats_render();
	call	_ui_playerstats_render
	ret
;src/State_InGame.c:161: void state_ingame_exit(){
;	---------------------------------
; Function state_ingame_exit
; ---------------------------------
_state_ingame_exit::
;src/State_InGame.c:163: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
