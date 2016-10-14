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
	.globl _ui_gamemenu_previous_entry
	.globl _ui_gamemenu_next_entry
	.globl _ui_gamemenu_is_selected
	.globl _ui_gamemenu_get_entry
	.globl _ui_gamemenu_init
	.globl _renderCompass
	.globl _level_load_level
	.globl _level_set_level
	.globl _draw_minimap_to_buffer
	.globl _render_draw_to_buffer
	.globl _player_move_forward
	.globl _player_turn_right
	.globl _player_turn_left
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _cpct_drawSprite
	.globl _cpct_isKeyPressed
	.globl _cpct_memset
	.globl _updateRenderBuffer
	.globl _state_ingame_enter
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
;src/State_InGame.c:23: void state_ingame_enter(){
;	---------------------------------
; Function state_ingame_enter
; ---------------------------------
_state_ingame_enter::
;src/State_InGame.c:24: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
	ld	hl, #(_g_colors + 0x0001) + 0
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/State_InGame.c:26: ui_gamemenu_init();
	call	_ui_gamemenu_init
;src/State_InGame.c:29: ui_gamemenu_render_all();
	call	_ui_gamemenu_render_all
;src/State_InGame.c:30: state_ingame_render();
	call	_state_ingame_render
	ret
_updateRenderBuffer:
	.db #0x00	; 0
;src/State_InGame.c:33: void state_ingame_input(){
;	---------------------------------
; Function state_ingame_input
; ---------------------------------
_state_ingame_input::
;src/State_InGame.c:35: if(cpct_isKeyPressed(Key_CursorLeft)){
	ld	hl,#0x0101
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00116$
;src/State_InGame.c:36: ui_gamemenu_previous_entry();
	call	_ui_gamemenu_previous_entry
;src/State_InGame.c:37: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00116$:
;src/State_InGame.c:39: else if(cpct_isKeyPressed(Key_CursorRight)){
	ld	hl,#0x0200
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00113$
;src/State_InGame.c:40: ui_gamemenu_next_entry();
	call	_ui_gamemenu_next_entry
;src/State_InGame.c:41: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00113$:
;src/State_InGame.c:43: else if(cpct_isKeyPressed(Key_Return)){
	ld	hl,#0x0402
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00110$
;src/State_InGame.c:44: ui_gamemenu_select_entry();
	call	_ui_gamemenu_select_entry
;src/State_InGame.c:45: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00110$:
;src/State_InGame.c:48: else if(cpct_isKeyPressed(Key_1)){
	ld	hl,#0x0108
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00107$
;src/State_InGame.c:49: level_set_level(0);
	xor	a, a
	push	af
	inc	sp
	call	_level_set_level
	inc	sp
;src/State_InGame.c:50: level_load_level();
	call	_level_load_level
;src/State_InGame.c:51: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00107$:
;src/State_InGame.c:53: else if(cpct_isKeyPressed(Key_2)){ 
	ld	hl,#0x0208
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00104$
;src/State_InGame.c:54: level_set_level(9);
	ld	a,#0x09
	push	af
	inc	sp
	call	_level_set_level
	inc	sp
;src/State_InGame.c:55: level_load_level();
	call	_level_load_level
;src/State_InGame.c:56: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00104$:
;src/State_InGame.c:58: else if(cpct_isKeyPressed(Key_T)){
	ld	hl,#0x0806
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	ret	Z
;src/State_InGame.c:59: *(u8*)&g_texturedWalls = !g_texturedWalls;
	ld	a,(#_g_texturedWalls + 0)
	sub	a,#0x01
	ld	a,#0x00
	rla
	ld	c,a
	ld	hl,#_g_texturedWalls
	ld	(hl),c
;src/State_InGame.c:60: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_InGame.c:64: void state_ingame_update(){
;	---------------------------------
; Function state_ingame_update
; ---------------------------------
_state_ingame_update::
;src/State_InGame.c:66: if(ui_gamemenu_is_selected()){
	call	_ui_gamemenu_is_selected
	ld	a,l
	or	a, a
	jr	Z,00109$
;src/State_InGame.c:67: ui_gamemenu_render_refresh();
	call	_ui_gamemenu_render_refresh
;src/State_InGame.c:68: switch(ui_gamemenu_get_entry()){
	call	_ui_gamemenu_get_entry
	ld	e,l
	ld	a,#0x05
	sub	a, e
	jr	C,00107$
	ld	d,#0x00
	ld	hl,#00126$
	add	hl,de
	add	hl,de
;src/State_InGame.c:69: case 0:{
	jp	(hl)
00126$:
	jr	00101$
	jr	00102$
	jr	00103$
	jr	00107$
	jr	00107$
	jr	00106$
00101$:
;src/State_InGame.c:71: player_turn_left();
	call	_player_turn_left
;src/State_InGame.c:74: *(u8*)&updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer
	ld	(hl),#0x01
;src/State_InGame.c:75: break;
	jr	00107$
;src/State_InGame.c:77: case 1:{
00102$:
;src/State_InGame.c:79: player_move_forward();
	call	_player_move_forward
;src/State_InGame.c:82: *(u8*)&updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer
	ld	(hl),#0x01
;src/State_InGame.c:83: break;
	jr	00107$
;src/State_InGame.c:85: case 2:{
00103$:
;src/State_InGame.c:87: player_turn_right();
	call	_player_turn_right
;src/State_InGame.c:89: *(u8*)&updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer
;src/State_InGame.c:90: break;
;src/State_InGame.c:92: case 3:{
;src/State_InGame.c:94: break;
;src/State_InGame.c:96: case 4:{
;src/State_InGame.c:98: break;
	ld	(hl), #0x01
	jr	00107$
;src/State_InGame.c:100: case 5:{
00106$:
;src/State_InGame.c:101: statemanager_set_state(STATE_PAUSEMENU);
	ld	a,#0x02
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_InGame.c:104: }
00107$:
;src/State_InGame.c:105: ui_gamemenu_unselect_entry();
	call	_ui_gamemenu_unselect_entry
00109$:
;src/State_InGame.c:108: if(updateRenderBuffer){
	ld	a,(#_updateRenderBuffer + 0)
	or	a, a
	ret	Z
;src/State_InGame.c:109: render_draw_to_buffer();
	call	_render_draw_to_buffer
;src/State_InGame.c:110: draw_minimap_to_buffer();
	call	_draw_minimap_to_buffer
;src/State_InGame.c:111: *(u8*)&updateRenderBuffer = 0;
	ld	hl,#_updateRenderBuffer
	ld	(hl),#0x00
	ret
;src/State_InGame.c:116: void state_ingame_render(){
;	---------------------------------
; Function state_ingame_render
; ---------------------------------
_state_ingame_render::
;src/State_InGame.c:117: ui_gamemenu_render_refresh();
	call	_ui_gamemenu_render_refresh
;src/State_InGame.c:118: ui_playerstats_render();
	call	_ui_playerstats_render
;src/State_InGame.c:119: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
	ld	hl,#0x6428
	push	hl
	ld	hl,#0xC0B4
	push	hl
	ld	hl,#0x8B00
	push	hl
	call	_cpct_drawSprite
;src/State_InGame.c:120: renderCompass();
	call	_renderCompass
;src/State_InGame.c:121: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
	ld	hl,#0x4010
	push	hl
	ld	hl,#0xC570
	push	hl
	ld	hl,#0x9AA0
	push	hl
	call	_cpct_drawSprite
	ret
;src/State_InGame.c:124: void state_ingame_exit(){
;	---------------------------------
; Function state_ingame_exit
; ---------------------------------
_state_ingame_exit::
;src/State_InGame.c:126: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
