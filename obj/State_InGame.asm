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
	.globl _ui_gamemenu_get_movement
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
;src/State_InGame.c:21: void state_ingame_enter(){
;	---------------------------------
; Function state_ingame_enter
; ---------------------------------
_state_ingame_enter::
;src/State_InGame.c:22: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
	ld	hl, #(_g_colors + 0x0001) + 0
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/State_InGame.c:24: ui_gamemenu_init();
	call	_ui_gamemenu_init
;src/State_InGame.c:25: ui_gamemenu_render_all();
	call	_ui_gamemenu_render_all
;src/State_InGame.c:26: state_ingame_render();
	call	_state_ingame_render
	ret
_updateRenderBuffer:
	.db #0x00	; 0
;src/State_InGame.c:29: void state_ingame_return(){
;	---------------------------------
; Function state_ingame_return
; ---------------------------------
_state_ingame_return::
;src/State_InGame.c:30: ui_gamemenu_render_all();
	call	_ui_gamemenu_render_all
;src/State_InGame.c:31: state_ingame_render();
	jp  _state_ingame_render
;src/State_InGame.c:34: void state_ingame_input(){
;	---------------------------------
; Function state_ingame_input
; ---------------------------------
_state_ingame_input::
;src/State_InGame.c:36: if(cpct_isKeyPressed(Key_CursorLeft)){
	ld	hl,#0x0101
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00116$
;src/State_InGame.c:37: ui_gamemenu_previous_entry();
	call	_ui_gamemenu_previous_entry
;src/State_InGame.c:38: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00116$:
;src/State_InGame.c:40: else if(cpct_isKeyPressed(Key_CursorRight)){
	ld	hl,#0x0200
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00113$
;src/State_InGame.c:41: ui_gamemenu_next_entry();
	call	_ui_gamemenu_next_entry
;src/State_InGame.c:42: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00113$:
;src/State_InGame.c:44: else if(cpct_isKeyPressed(Key_CursorUp)){
	ld	hl,#0x0100
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00110$
;src/State_InGame.c:45: ui_gamemenu_above_entry();
	call	_ui_gamemenu_above_entry
;src/State_InGame.c:46: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00110$:
;src/State_InGame.c:48: else if(cpct_isKeyPressed(Key_CursorDown)){
	ld	hl,#0x0400
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00107$
;src/State_InGame.c:49: ui_gamemenu_below_entry();
	call	_ui_gamemenu_below_entry
;src/State_InGame.c:50: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00107$:
;src/State_InGame.c:52: else if(cpct_isKeyPressed(Key_Return)){
	ld	hl,#0x0402
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00104$
;src/State_InGame.c:53: ui_gamemenu_select_entry();
	call	_ui_gamemenu_select_entry
;src/State_InGame.c:54: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00104$:
;src/State_InGame.c:57: else if(cpct_isKeyPressed(Key_T)){
	ld	hl,#0x0806
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	ret	Z
;src/State_InGame.c:58: *(u8*)&g_texturedWalls = !g_texturedWalls;
	ld	a,(#_g_texturedWalls + 0)
	sub	a,#0x01
	ld	a,#0x00
	rla
	ld	c,a
	ld	hl,#_g_texturedWalls
	ld	(hl),c
;src/State_InGame.c:59: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_InGame.c:63: void state_ingame_update(){
;	---------------------------------
; Function state_ingame_update
; ---------------------------------
_state_ingame_update::
;src/State_InGame.c:66: if(ui_gamemenu_is_selected()){
	call	_ui_gamemenu_is_selected
	ld	a,l
	or	a, a
	jp	Z,00116$
;src/State_InGame.c:67: ui_gamemenu_render_refresh();
	call	_ui_gamemenu_render_refresh
;src/State_InGame.c:68: switch(ui_gamemenu_get_entry()){
	call	_ui_gamemenu_get_entry
	ld	e,l
	ld	a,#0x06
	sub	a, e
	jp	C,00114$
	ld	d,#0x00
	ld	hl,#00145$
	add	hl,de
	add	hl,de
	add	hl,de
	jp	(hl)
00145$:
	jp	00101$
	jp	00114$
	jp	00107$
	jp	00108$
	jp	00111$
	jp	00114$
	jp	00113$
;src/State_InGame.c:69: case 0:{//ACTION BUTTON
00101$:
;src/State_InGame.c:71: switch(ui_gamemenu_get_action()){
	call	_ui_gamemenu_get_action
	ld	e,l
	ld	a,e
	sub	a, #0x01
	jr	C,00114$
	ld	a,#0x03
	sub	a, e
	jr	C,00114$
	dec	e
	ld	d,#0x00
	ld	hl,#00146$
	add	hl,de
	add	hl,de
;src/State_InGame.c:72: case 1:{
	jp	(hl)
00146$:
	jr	00102$
	jr	00114$
	jr	00114$
00102$:
;src/State_InGame.c:73: level_set_level(level_get_level()+1);
	call	_level_get_level
	ld	b,l
	inc	b
	push	bc
	inc	sp
	call	_level_set_level
	inc	sp
;src/State_InGame.c:74: statemanager_close_state();
	call	_statemanager_close_state
;src/State_InGame.c:75: statemanager_set_state(STATE_LOADLEVEL);
	ld	a,#0x03
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_InGame.c:77: break;
	jr	00114$
;src/State_InGame.c:79: case 2:{
;src/State_InGame.c:81: break;
	jr	00114$
;src/State_InGame.c:83: case 3:{
;src/State_InGame.c:88: break;
	jr	00114$
;src/State_InGame.c:90: case 1:{//INVENTORY
;src/State_InGame.c:93: break;
	jr	00114$
;src/State_InGame.c:95: case 2:{//TURN LEFT
00107$:
;src/State_InGame.c:97: player_turn_left();
	call	_player_turn_left
;src/State_InGame.c:98: ui_gamemenu_update_action();
	call	_ui_gamemenu_update_action
;src/State_InGame.c:100: *(u8*)&updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer
	ld	(hl),#0x01
;src/State_InGame.c:101: break;
	jr	00114$
;src/State_InGame.c:103: case 3:{//MOVE
00108$:
;src/State_InGame.c:104: if(ui_gamemenu_get_movement()){//BYPASS IF FOR NOCLIP
	call	_ui_gamemenu_get_movement
	ld	a,l
	or	a, a
	jr	Z,00114$
;src/State_InGame.c:105: player_move_forward();
	call	_player_move_forward
;src/State_InGame.c:106: ui_gamemenu_update_action();
	call	_ui_gamemenu_update_action
;src/State_InGame.c:107: *(u8*)&updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer
	ld	(hl),#0x01
;src/State_InGame.c:109: break;
	jr	00114$
;src/State_InGame.c:111: case 4:{//TURN RIGHT
00111$:
;src/State_InGame.c:112: player_turn_right();
	call	_player_turn_right
;src/State_InGame.c:113: ui_gamemenu_update_action();
	call	_ui_gamemenu_update_action
;src/State_InGame.c:115: *(u8*)&updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer
;src/State_InGame.c:117: break;
;src/State_InGame.c:119: case 5:{//WAIT
;src/State_InGame.c:121: break;
	ld	(hl), #0x01
	jr	00114$
;src/State_InGame.c:123: case 6:{//PAUSE
00113$:
;src/State_InGame.c:124: statemanager_set_state(STATE_PAUSEMENU);
	ld	a,#0x02
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_InGame.c:127: }
00114$:
;src/State_InGame.c:128: ui_gamemenu_unselect_entry();
	call	_ui_gamemenu_unselect_entry
00116$:
;src/State_InGame.c:131: if(updateRenderBuffer){
	ld	a,(#_updateRenderBuffer + 0)
	or	a, a
	ret	Z
;src/State_InGame.c:132: render_draw_to_buffer();
	call	_render_draw_to_buffer
;src/State_InGame.c:133: draw_minimap_to_buffer();
	call	_draw_minimap_to_buffer
;src/State_InGame.c:134: *(u8*)&updateRenderBuffer = 0;
	ld	hl,#_updateRenderBuffer
	ld	(hl),#0x00
	ret
;src/State_InGame.c:139: void state_ingame_render(){
;	---------------------------------
; Function state_ingame_render
; ---------------------------------
_state_ingame_render::
;src/State_InGame.c:140: ui_gamemenu_render_refresh();
	call	_ui_gamemenu_render_refresh
;src/State_InGame.c:141: renderCompass();
	call	_renderCompass
;src/State_InGame.c:142: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
	ld	hl,#0x6428
	push	hl
	ld	hl,#0xC0B4
	push	hl
	ld	hl,#0x8B00
	push	hl
	call	_cpct_drawSprite
;src/State_InGame.c:143: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
	ld	hl,#0x4010
	push	hl
	ld	hl,#0xC522
	push	hl
	ld	hl,#0x9AA0
	push	hl
	call	_cpct_drawSprite
;src/State_InGame.c:144: ui_playerstats_render();
	call	_ui_playerstats_render
	ret
;src/State_InGame.c:147: void state_ingame_exit(){
;	---------------------------------
; Function state_ingame_exit
; ---------------------------------
_state_ingame_exit::
;src/State_InGame.c:149: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
