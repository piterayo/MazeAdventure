;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_InGame
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ui_gamemenu_render
	.globl _ui_gamemenu_unselect_entry
	.globl _ui_gamemenu_select_entry
	.globl _ui_gamemenu_previous_entry
	.globl _ui_gamemenu_next_entry
	.globl _ui_gamemenu_is_selected
	.globl _ui_gamemenu_get_entry
	.globl _renderCompass
	.globl _level_load_level
	.globl _level_set_level
	.globl _draw_minimap_to_buffer
	.globl _render_draw_to_buffer
	.globl _generate_level
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _cpct_drawSprite
	.globl _cpct_isKeyPressed
	.globl _cpct_memset
	.globl _updateRenderBuffer
	.globl _isInitialized
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
;src/State_InGame.c:20: void state_ingame_enter(){
;	---------------------------------
; Function state_ingame_enter
; ---------------------------------
_state_ingame_enter::
;src/State_InGame.c:21: if(!isInitialized){
	ld	a,(#_isInitialized + 0)
	or	a, a
	jr	NZ,00102$
;src/State_InGame.c:22: generate_level();
	call	_generate_level
;src/State_InGame.c:23: level_set_level(0);
	xor	a, a
	push	af
	inc	sp
	call	_level_set_level
	inc	sp
;src/State_InGame.c:24: level_load_level();
	call	_level_load_level
;src/State_InGame.c:25: render_draw_to_buffer();
	call	_render_draw_to_buffer
;src/State_InGame.c:26: draw_minimap_to_buffer();
	call	_draw_minimap_to_buffer
;src/State_InGame.c:27: *(u8*)&isInitialized = 1;
	ld	hl,#_isInitialized
	ld	(hl),#0x01
00102$:
;src/State_InGame.c:29: cpct_memset(CPCT_VMEM_START, g_colors[12], 0x4000);
	ld	hl,#_g_colors+12
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/State_InGame.c:30: state_ingame_render();
	call	_state_ingame_render
	ret
_isInitialized:
	.db #0x00	; 0
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
;src/State_InGame.c:47: else if(cpct_isKeyPressed(Key_1)){
	ld	hl,#0x0108
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00107$
;src/State_InGame.c:48: level_set_level(0);
	xor	a, a
	push	af
	inc	sp
	call	_level_set_level
	inc	sp
;src/State_InGame.c:49: level_load_level();
	call	_level_load_level
;src/State_InGame.c:50: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00107$:
;src/State_InGame.c:52: else if(cpct_isKeyPressed(Key_2)){ 
	ld	hl,#0x0208
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00104$
;src/State_InGame.c:53: level_set_level(9);
	ld	a,#0x09
	push	af
	inc	sp
	call	_level_set_level
	inc	sp
;src/State_InGame.c:54: level_load_level();
	call	_level_load_level
;src/State_InGame.c:55: statemanager_input_accepted();
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
;src/State_InGame.c:65: if(ui_gamemenu_is_selected()){
	call	_ui_gamemenu_is_selected
	ld	a,l
	or	a, a
	jp	Z,00109$
;src/State_InGame.c:66: ui_gamemenu_render();
	call	_ui_gamemenu_render
;src/State_InGame.c:67: switch(ui_gamemenu_get_entry()){
	call	_ui_gamemenu_get_entry
	ld	e,l
	ld	a,#0x05
	sub	a, e
	jp	C,00107$
;src/State_InGame.c:69: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
	ld	iy,#_PLAYER_directionIndex
	ld	c,0 (iy)
;src/State_InGame.c:67: switch(ui_gamemenu_get_entry()){
	ld	d,#0x00
	ld	hl,#00126$
	add	hl,de
	add	hl,de
	add	hl,de
	jp	(hl)
00126$:
	jp	00101$
	jp	00102$
	jp	00103$
	jp	00107$
	jp	00107$
	jp	00106$
;src/State_InGame.c:68: case 0:{
00101$:
;src/State_InGame.c:69: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
	ld	de,#_PLAYER_directionIndex+0
	inc	c
	inc	c
	ld	a,c
	and	a, #0x07
	ld	(de),a
;src/State_InGame.c:70: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
	ld	bc,#_PLAYER_direction+0
	ld	de,#_PLAYER_directionArray+0
	ld	iy,#_PLAYER_directionIndex
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
;src/State_InGame.c:71: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
	ld	bc,#_PLAYER_direction+1
	ld	iy,#_PLAYER_directionIndex
	ld	l,0 (iy)
	inc	l
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
;src/State_InGame.c:73: *(u8*)&updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer
	ld	(hl),#0x01
;src/State_InGame.c:74: break;
	jr	00107$
;src/State_InGame.c:76: case 1:{
00102$:
;src/State_InGame.c:77: *(i8*)&(PLAYER_position.x) = PLAYER_position.x + PLAYER_direction.x;
	ld	hl,#_PLAYER_position+0
	ld	c, l
	ld	b, h
	ld	e,(hl)
	ld	hl,#_PLAYER_direction+0
	ld	d,(hl)
	ld	a,e
	add	a, d
	ld	(bc),a
;src/State_InGame.c:78: *(i8*)&(PLAYER_position.y) = PLAYER_position.y + PLAYER_direction.y;
	ld	hl,#_PLAYER_position+1
	ld	c, l
	ld	b, h
	ld	e,(hl)
	ld	hl,#_PLAYER_direction+1
	ld	d,(hl)
	ld	a,e
	add	a, d
	ld	(bc),a
;src/State_InGame.c:80: *(u8*)&updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer
	ld	(hl),#0x01
;src/State_InGame.c:81: break;
	jr	00107$
;src/State_InGame.c:83: case 2:{
00103$:
;src/State_InGame.c:84: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex-2)&7;
	ld	de,#_PLAYER_directionIndex+0
	dec	c
	dec	c
	ld	a,c
	and	a, #0x07
	ld	(de),a
;src/State_InGame.c:85: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
	ld	bc,#_PLAYER_direction+0
	ld	de,#_PLAYER_directionArray+0
	ld	iy,#_PLAYER_directionIndex
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
;src/State_InGame.c:86: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
	ld	bc,#_PLAYER_direction+1
	ld	iy,#_PLAYER_directionIndex
	ld	l,0 (iy)
	inc	l
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
;src/State_InGame.c:87: *(u8*)&updateRenderBuffer = 1;
	ld	hl,#_updateRenderBuffer
;src/State_InGame.c:88: break;
;src/State_InGame.c:90: case 3:{
;src/State_InGame.c:92: break;
;src/State_InGame.c:94: case 4:{
;src/State_InGame.c:96: break;
	ld	(hl), #0x01
	jr	00107$
;src/State_InGame.c:98: case 5:{
00106$:
;src/State_InGame.c:99: statemanager_set_state(STATE_PAUSEMENU);
	ld	a,#0x02
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_InGame.c:102: }
00107$:
;src/State_InGame.c:103: ui_gamemenu_unselect_entry();
	call	_ui_gamemenu_unselect_entry
00109$:
;src/State_InGame.c:106: if(updateRenderBuffer){
	ld	a,(#_updateRenderBuffer + 0)
	or	a, a
	ret	Z
;src/State_InGame.c:107: render_draw_to_buffer();
	call	_render_draw_to_buffer
;src/State_InGame.c:108: draw_minimap_to_buffer();
	call	_draw_minimap_to_buffer
;src/State_InGame.c:109: *(u8*)&updateRenderBuffer = 0;
	ld	hl,#_updateRenderBuffer
	ld	(hl),#0x00
	ret
;src/State_InGame.c:114: void state_ingame_render(){
;	---------------------------------
; Function state_ingame_render
; ---------------------------------
_state_ingame_render::
;src/State_InGame.c:115: ui_gamemenu_render();
	call	_ui_gamemenu_render
;src/State_InGame.c:116: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
	ld	hl,#0x6428
	push	hl
	ld	hl,#0xC0B4
	push	hl
	ld	hl,#0x8B00
	push	hl
	call	_cpct_drawSprite
;src/State_InGame.c:117: renderCompass();
	call	_renderCompass
;src/State_InGame.c:118: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
	ld	hl,#0x4010
	push	hl
	ld	hl,#0xC570
	push	hl
	ld	hl,#0x9AA0
	push	hl
	call	_cpct_drawSprite
	ret
;src/State_InGame.c:121: void state_ingame_exit(){
;	---------------------------------
; Function state_ingame_exit
; ---------------------------------
_state_ingame_exit::
;src/State_InGame.c:122: *(u8*)&isInitialized = 0;
	ld	hl,#_isInitialized
	ld	(hl),#0x00
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
