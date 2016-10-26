;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_InGame
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _state_ingame_update_buffers
	.globl _state_ingame_update_turn
	.globl _ui_log_render
	.globl _ui_log_init
	.globl _ui_playerstats_render_all
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
	.globl _state_inventory_object_used
	.globl _enemy_update
	.globl _enemy_try_new_spawn
	.globl _enemy_get_at
	.globl _enemy_attack_enemy
	.globl _item_pick_item
	.globl _item_get_at
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
_updateRenderBuffer::
	.ds 1
_action::
	.ds 1
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
;src/State_InGame.c:36: void state_ingame_enter(){
;	---------------------------------
; Function state_ingame_enter
; ---------------------------------
_state_ingame_enter::
;src/State_InGame.c:38: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
	ld	hl, #(_g_colors + 0x0001) + 0
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/State_InGame.c:40: ui_log_init();
	call	_ui_log_init
;src/State_InGame.c:42: action=NONE;
	ld	hl,#_action + 0
	ld	(hl), #0x00
;src/State_InGame.c:44: ui_gamemenu_init();
	call	_ui_gamemenu_init
;src/State_InGame.c:45: ui_gamemenu_render_all();
	call	_ui_gamemenu_render_all
;src/State_InGame.c:46: ui_playerstats_render_all();
	call	_ui_playerstats_render_all
;src/State_InGame.c:47: ui_log_render();
	call	_ui_log_render
;src/State_InGame.c:48: state_ingame_render();
	call	_state_ingame_render
	ret
;src/State_InGame.c:51: void state_ingame_update_turn(){
;	---------------------------------
; Function state_ingame_update_turn
; ---------------------------------
_state_ingame_update_turn::
;src/State_InGame.c:52: enemy_update();
	call	_enemy_update
;src/State_InGame.c:53: if(level_get_level()!=KING_LEVEL) enemy_try_new_spawn();
	call	_level_get_level
	ld	a,l
	sub	a, #0x20
	jr	Z,00102$
	call	_enemy_try_new_spawn
00102$:
;src/State_InGame.c:54: ui_gamemenu_update_action();
	call	_ui_gamemenu_update_action
;src/State_InGame.c:56: if(player_is_dead){//Game over
	ld	a,(#_player_is_dead + 0)
	or	a, a
	jr	Z,00104$
;src/State_InGame.c:57: statemanager_set_state(STATE_GAMEOVER);
	ld	a,#0x05
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
00104$:
;src/State_InGame.c:59: updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer + 0
	ld	(hl), #0x01
	ret
;src/State_InGame.c:62: void state_ingame_update_buffers(){
;	---------------------------------
; Function state_ingame_update_buffers
; ---------------------------------
_state_ingame_update_buffers::
;src/State_InGame.c:63: render_draw_to_buffer();
	call	_render_draw_to_buffer
;src/State_InGame.c:64: draw_minimap_to_buffer();
	jp  _draw_minimap_to_buffer
;src/State_InGame.c:67: void state_ingame_return(){
;	---------------------------------
; Function state_ingame_return
; ---------------------------------
_state_ingame_return::
;src/State_InGame.c:68: if(state_inventory_object_used()){
	call	_state_inventory_object_used
	ld	a,l
	or	a, a
	jr	Z,00102$
;src/State_InGame.c:69: state_ingame_update_turn();
	call	_state_ingame_update_turn
;src/State_InGame.c:70: state_ingame_update_buffers();
	call	_state_ingame_update_buffers
00102$:
;src/State_InGame.c:72: ui_gamemenu_unselect_entry();
	call	_ui_gamemenu_unselect_entry
;src/State_InGame.c:73: ui_gamemenu_render_all();
	call	_ui_gamemenu_render_all
;src/State_InGame.c:74: ui_playerstats_render_all();
	call	_ui_playerstats_render_all
;src/State_InGame.c:75: ui_log_render();
	call	_ui_log_render
;src/State_InGame.c:76: state_ingame_render();
	jp  _state_ingame_render
;src/State_InGame.c:79: void state_ingame_input(){
;	---------------------------------
; Function state_ingame_input
; ---------------------------------
_state_ingame_input::
;src/State_InGame.c:81: if(cpct_isKeyPressed(Key_CursorLeft)){
	ld	hl,#0x0101
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00113$
;src/State_InGame.c:82: ui_gamemenu_previous_entry();
	call	_ui_gamemenu_previous_entry
;src/State_InGame.c:83: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00113$:
;src/State_InGame.c:85: else if(cpct_isKeyPressed(Key_CursorRight)){
	ld	hl,#0x0200
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00110$
;src/State_InGame.c:86: ui_gamemenu_next_entry();
	call	_ui_gamemenu_next_entry
;src/State_InGame.c:87: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00110$:
;src/State_InGame.c:89: else if(cpct_isKeyPressed(Key_CursorUp)){
	ld	hl,#0x0100
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00107$
;src/State_InGame.c:90: ui_gamemenu_above_entry();
	call	_ui_gamemenu_above_entry
;src/State_InGame.c:91: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00107$:
;src/State_InGame.c:93: else if(cpct_isKeyPressed(Key_CursorDown)){
	ld	hl,#0x0400
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00104$
;src/State_InGame.c:94: ui_gamemenu_below_entry();
	call	_ui_gamemenu_below_entry
;src/State_InGame.c:95: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00104$:
;src/State_InGame.c:97: else if(cpct_isKeyPressed(Key_Return)){
	ld	hl,#0x0402
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	ret	Z
;src/State_InGame.c:98: ui_gamemenu_select_entry();
	call	_ui_gamemenu_select_entry
;src/State_InGame.c:99: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_InGame.c:109: void state_ingame_update(){
;	---------------------------------
; Function state_ingame_update
; ---------------------------------
_state_ingame_update::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/State_InGame.c:110: u8 forward = *(u8*)(MAP_MEM + (player_position.x+player_direction.x) + (player_position.y+player_direction.y) * MAP_WIDTH);
	ld	hl,#_player_position+0
	ld	c,(hl)
	ld	b,#0x00
	ld	a, (#_player_direction + 0)
	ld	l,a
	rla
	sbc	a, a
	ld	h,a
	add	hl,bc
	ld	bc,#0x88D0
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	hl,#_player_position+1
	ld	e,(hl)
	ld	d,#0x00
	ld	a, (#(_player_direction + 0x0001) + 0)
	ld	l,a
	rla
	sbc	a, a
	ld	h,a
	add	hl,de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	a,(hl)
	ld	-1 (ix),a
;src/State_InGame.c:113: updateRenderBuffer=0;
	ld	hl,#_updateRenderBuffer + 0
	ld	(hl), #0x00
;src/State_InGame.c:115: if(ui_gamemenu_is_selected()){
	call	_ui_gamemenu_is_selected
	ld	a,l
	or	a, a
	jp	Z,00116$
;src/State_InGame.c:116: ui_gamemenu_render_refresh();
	call	_ui_gamemenu_render_refresh
;src/State_InGame.c:117: switch(ui_gamemenu_get_entry()){
	call	_ui_gamemenu_get_entry
	ld	e,l
	ld	a,#0x06
	sub	a, e
	jp	C,00116$
	ld	d,#0x00
	ld	hl,#00151$
	add	hl,de
	add	hl,de
	add	hl,de
	jp	(hl)
00151$:
	jp	00101$
	jp	00106$
	jp	00107$
	jp	00108$
	jp	00111$
	jp	00112$
	jp	00113$
;src/State_InGame.c:118: case 0:{//ACTION BUTTON
00101$:
;src/State_InGame.c:120: switch(ui_gamemenu_get_action()){
	call	_ui_gamemenu_get_action
	ld	e,l
	ld	a,e
	sub	a, #0x01
	jr	C,00105$
	ld	a,#0x03
	sub	a, e
	jr	C,00105$
	dec	e
	ld	d,#0x00
	ld	hl,#00152$
	add	hl,de
	add	hl,de
;src/State_InGame.c:121: case 1:{
	jp	(hl)
00152$:
	jr	00102$
	jr	00103$
	jr	00104$
00102$:
;src/State_InGame.c:122: level_set_level(level_get_level()+1);
	call	_level_get_level
	ld	b,l
	inc	b
	push	bc
	inc	sp
	call	_level_set_level
	inc	sp
;src/State_InGame.c:123: statemanager_close_state();
	call	_statemanager_close_state
;src/State_InGame.c:124: statemanager_set_state(STATE_LOADLEVEL);
	ld	a,#0x03
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_InGame.c:126: break;
	jr	00105$
;src/State_InGame.c:128: case 2:{
00103$:
;src/State_InGame.c:129: action=ATTACK;
	ld	hl,#_action + 0
	ld	(hl), #0x02
;src/State_InGame.c:130: enemy_attack_enemy(enemy_get_at(forward-1));
	ld	b,-1 (ix)
	dec	b
	push	bc
	inc	sp
	call	_enemy_get_at
	inc	sp
	push	hl
	call	_enemy_attack_enemy
	pop	af
;src/State_InGame.c:131: break;
	jr	00105$
;src/State_InGame.c:133: case 3:{
00104$:
;src/State_InGame.c:134: action=PICK_OBJECT;
	ld	hl,#_action + 0
	ld	(hl), #0x03
;src/State_InGame.c:135: item_pick_item(item_get_at((forward)>>4)-1);
	ld	a,-1 (ix)
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0F
	ld	b,a
	push	bc
	inc	sp
	call	_item_get_at
	inc	sp
	ld	bc, #0xFFFB
	add	hl,bc
	push	hl
	call	_item_pick_item
	pop	af
;src/State_InGame.c:139: }
00105$:
;src/State_InGame.c:140: ui_gamemenu_unselect_entry();
	call	_ui_gamemenu_unselect_entry
;src/State_InGame.c:141: break;
	jr	00116$
;src/State_InGame.c:143: case 1:{//INVENTORY
00106$:
;src/State_InGame.c:145: statemanager_set_state(STATE_INVENTORY);                
	ld	a,#0x08
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_InGame.c:147: break;
	jr	00116$
;src/State_InGame.c:149: case 2:{//TURN LEFT
00107$:
;src/State_InGame.c:151: player_turn_left();
	call	_player_turn_left
;src/State_InGame.c:152: ui_gamemenu_update_action();
	call	_ui_gamemenu_update_action
;src/State_InGame.c:154: updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer + 0
	ld	(hl), #0x01
;src/State_InGame.c:155: ui_gamemenu_unselect_entry();
	call	_ui_gamemenu_unselect_entry
;src/State_InGame.c:156: break;
	jr	00116$
;src/State_InGame.c:158: case 3:{//MOVE
00108$:
;src/State_InGame.c:159: if(ui_gamemenu_get_movement()){//BYPASS IF FOR NOCLIP
	call	_ui_gamemenu_get_movement
	ld	a,l
	or	a, a
	jr	Z,00110$
;src/State_InGame.c:161: player_move_forward();
	call	_player_move_forward
;src/State_InGame.c:162: ui_gamemenu_update_action();
	call	_ui_gamemenu_update_action
;src/State_InGame.c:163: action=MOVE;
	ld	hl,#_action + 0
	ld	(hl), #0x01
00110$:
;src/State_InGame.c:167: ui_gamemenu_unselect_entry();
	call	_ui_gamemenu_unselect_entry
;src/State_InGame.c:168: break;
	jr	00116$
;src/State_InGame.c:170: case 4:{//TURN RIGHT
00111$:
;src/State_InGame.c:171: player_turn_right();
	call	_player_turn_right
;src/State_InGame.c:172: ui_gamemenu_update_action();
	call	_ui_gamemenu_update_action
;src/State_InGame.c:173: ui_gamemenu_unselect_entry();
	call	_ui_gamemenu_unselect_entry
;src/State_InGame.c:175: updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer + 0
	ld	(hl), #0x01
;src/State_InGame.c:177: break;
	jr	00116$
;src/State_InGame.c:179: case 5:{//WAIT
00112$:
;src/State_InGame.c:180: action=WAIT;
	ld	hl,#_action + 0
	ld	(hl), #0x04
;src/State_InGame.c:181: ui_gamemenu_unselect_entry();
	call	_ui_gamemenu_unselect_entry
;src/State_InGame.c:182: break;
	jr	00116$
;src/State_InGame.c:184: case 6:{//PAUSE
00113$:
;src/State_InGame.c:185: statemanager_set_state(STATE_PAUSEMENU);
	ld	a,#0x02
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_InGame.c:188: }
00116$:
;src/State_InGame.c:191: if(action!=NONE){
	ld	a,(#_action + 0)
	or	a, a
	jr	Z,00118$
;src/State_InGame.c:192: state_ingame_update_turn();
	call	_state_ingame_update_turn
00118$:
;src/State_InGame.c:195: if(updateRenderBuffer){
	ld	a,(#_updateRenderBuffer + 0)
	or	a, a
	jr	Z,00120$
;src/State_InGame.c:196: state_ingame_update_buffers();
	call	_state_ingame_update_buffers
00120$:
;src/State_InGame.c:198: action=NONE;
	ld	hl,#_action + 0
	ld	(hl), #0x00
	inc	sp
	pop	ix
	ret
;src/State_InGame.c:202: void state_ingame_render(){
;	---------------------------------
; Function state_ingame_render
; ---------------------------------
_state_ingame_render::
;src/State_InGame.c:203: ui_gamemenu_render_refresh();
	call	_ui_gamemenu_render_refresh
;src/State_InGame.c:204: renderCompass();
	call	_renderCompass
;src/State_InGame.c:205: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
	ld	hl,#0x6428
	push	hl
	ld	hl,#0xC0B4
	push	hl
	ld	hl,#0xAA50
	push	hl
	call	_cpct_drawSprite
;src/State_InGame.c:206: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
	ld	hl,#0x4010
	push	hl
	ld	hl,#0xC520
	push	hl
	ld	hl,#0xB9F0
	push	hl
	call	_cpct_drawSprite
	ret
;src/State_InGame.c:209: void state_ingame_exit(){
;	---------------------------------
; Function state_ingame_exit
; ---------------------------------
_state_ingame_exit::
;src/State_InGame.c:211: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
