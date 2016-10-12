;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_InGame
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _renderCompass
	.globl _level_load_level
	.globl _draw_minimap_to_buffer
	.globl _render_draw_to_buffer
	.globl _generate_level
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _cpct_drawSprite
	.globl _cpct_isKeyPressed
	.globl _cpct_memset
	.globl _needRender
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
;src/State_InGame.c:18: void state_ingame_enter(){
;	---------------------------------
; Function state_ingame_enter
; ---------------------------------
_state_ingame_enter::
;src/State_InGame.c:19: if(!isInitialized){
	ld	a,(#_isInitialized + 0)
	or	a, a
	jr	NZ,00102$
;src/State_InGame.c:20: generate_level();
	call	_generate_level
;src/State_InGame.c:21: level_load_level(0);
	xor	a, a
	push	af
	inc	sp
	call	_level_load_level
	inc	sp
;src/State_InGame.c:22: render_draw_to_buffer();
	call	_render_draw_to_buffer
;src/State_InGame.c:23: draw_minimap_to_buffer();
	call	_draw_minimap_to_buffer
;src/State_InGame.c:24: *(u8*)&isInitialized = 1;
	ld	hl,#_isInitialized
	ld	(hl),#0x01
00102$:
;src/State_InGame.c:26: cpct_memset(CPCT_VMEM_START, g_colors[12], 0x4000);
	ld	hl,#_g_colors+12
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/State_InGame.c:27: state_ingame_render();
	call	_state_ingame_render
	ret
_isInitialized:
	.db #0x00	; 0
_needRender:
	.db #0x00	; 0
;src/State_InGame.c:30: void state_ingame_input(){
;	---------------------------------
; Function state_ingame_input
; ---------------------------------
_state_ingame_input::
;src/State_InGame.c:32: if(cpct_isKeyPressed(Key_CursorLeft)){
	ld	hl,#0x0101
	call	_cpct_isKeyPressed
	ld	a, l
	or	a, a
	jr	Z,00122$
;src/State_InGame.c:33: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
	ld	bc,#_PLAYER_directionIndex+0
	ld	a,(#_PLAYER_directionIndex + 0)
	add	a, #0x02
	and	a, #0x07
	ld	(bc),a
;src/State_InGame.c:34: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
	ld	bc,#_PLAYER_direction+0
	ld	de,#_PLAYER_directionArray+0
	ld	iy,#_PLAYER_directionIndex
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
;src/State_InGame.c:35: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
	ld	bc,#_PLAYER_direction+1
	ld	iy,#_PLAYER_directionIndex
	ld	l,0 (iy)
	inc	l
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
;src/State_InGame.c:37: *(u8*)&needRender = 1;
	ld	hl,#_needRender
	ld	(hl),#0x01
;src/State_InGame.c:38: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00122$:
;src/State_InGame.c:40: else if(cpct_isKeyPressed(Key_CursorRight)){
	ld	hl,#0x0200
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00119$
;src/State_InGame.c:41: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex-2)&7;
	ld	bc,#_PLAYER_directionIndex+0
	ld	a,(#_PLAYER_directionIndex + 0)
	add	a,#0xFE
	and	a, #0x07
	ld	(bc),a
;src/State_InGame.c:42: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
	ld	de,#_PLAYER_direction+0
	ld	bc,#_PLAYER_directionArray+0
	ld	iy,#_PLAYER_directionIndex
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	(de),a
;src/State_InGame.c:43: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
	ld	hl,#_PLAYER_directionIndex + 0
	ld	e, (hl)
	inc	e
	ld	l,e
	ld	h,#0x00
	add	hl,bc
	ld	c,(hl)
	ld	hl,#(_PLAYER_direction + 0x0001)
	ld	(hl),c
;src/State_InGame.c:44: *(u8*)&needRender = 1;
	ld	hl,#_needRender
	ld	(hl),#0x01
;src/State_InGame.c:45: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00119$:
;src/State_InGame.c:47: else if(cpct_isKeyPressed(Key_CursorUp)){
	ld	hl,#0x0100
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00116$
;src/State_InGame.c:48: *(i8*)&(PLAYER_position.x) = PLAYER_position.x + PLAYER_direction.x;
	ld	hl,#_PLAYER_position+0
	ld	c, l
	ld	b, h
	ld	d,(hl)
	ld	hl,#_PLAYER_direction+0
	ld	e,(hl)
	ld	a,d
	add	a, e
	ld	(bc),a
;src/State_InGame.c:49: *(i8*)&(PLAYER_position.y) = PLAYER_position.y + PLAYER_direction.y;
	ld	hl,#_PLAYER_position+1
	ld	c, l
	ld	b, h
	ld	d,(hl)
	ld	hl,#_PLAYER_direction+1
	ld	e,(hl)
	ld	a,d
	add	a, e
	ld	(bc),a
;src/State_InGame.c:51: *(u8*)&needRender = 1;
	ld	hl,#_needRender
	ld	(hl),#0x01
;src/State_InGame.c:52: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00116$:
;src/State_InGame.c:54: else if(cpct_isKeyPressed(Key_CursorDown)){
	ld	hl,#0x0400
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00113$
;src/State_InGame.c:55: *(i8*)&(PLAYER_position.x) = PLAYER_position.x - PLAYER_direction.x;
	ld	hl,#_PLAYER_position+0
	ld	c, l
	ld	b, h
	ld	d,(hl)
	ld	hl,#_PLAYER_direction+0
	ld	e,(hl)
	ld	a,d
	sub	a, e
	ld	(bc),a
;src/State_InGame.c:56: *(i8*)&(PLAYER_position.y) = PLAYER_position.y - PLAYER_direction.y;
	ld	hl,#_PLAYER_position+1
	ld	c, l
	ld	b, h
	ld	d,(hl)
	ld	hl,#_PLAYER_direction+1
	ld	e,(hl)
	ld	a,d
	sub	a, e
	ld	(bc),a
;src/State_InGame.c:58: *(u8*)&needRender = 1;
	ld	hl,#_needRender
	ld	(hl),#0x01
;src/State_InGame.c:59: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00113$:
;src/State_InGame.c:61: else if(cpct_isKeyPressed(Key_0)){
	ld	hl,#0x0104
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00110$
;src/State_InGame.c:62: level_load_level(0);
	xor	a, a
	push	af
	inc	sp
	call	_level_load_level
	inc	sp
;src/State_InGame.c:63: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00110$:
;src/State_InGame.c:65: else if(cpct_isKeyPressed(Key_1)){ 
	ld	hl,#0x0108
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00107$
;src/State_InGame.c:66: level_load_level(9);
	ld	a,#0x09
	push	af
	inc	sp
	call	_level_load_level
	inc	sp
;src/State_InGame.c:67: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00107$:
;src/State_InGame.c:69: else if(cpct_isKeyPressed(Key_T)){
	ld	hl,#0x0806
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00104$
;src/State_InGame.c:70: *(u8*)&g_texturedWalls = !g_texturedWalls;
	ld	a,(#_g_texturedWalls + 0)
	sub	a,#0x01
	ld	a,#0x00
	rla
	ld	c,a
	ld	hl,#_g_texturedWalls
	ld	(hl),c
;src/State_InGame.c:71: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00104$:
;src/State_InGame.c:73: else if(cpct_isKeyPressed(Key_P)){
	ld	hl,#0x0803
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	ret	Z
;src/State_InGame.c:74: statemanager_set_state(STATE_PAUSEMENU);
	ld	a,#0x02
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_InGame.c:75: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_InGame.c:79: void state_ingame_update(){
;	---------------------------------
; Function state_ingame_update
; ---------------------------------
_state_ingame_update::
;src/State_InGame.c:80: if(needRender){
	ld	a,(#_needRender + 0)
	or	a, a
	ret	Z
;src/State_InGame.c:81: render_draw_to_buffer();
	call	_render_draw_to_buffer
;src/State_InGame.c:82: draw_minimap_to_buffer();
	call	_draw_minimap_to_buffer
;src/State_InGame.c:83: *(u8*)&needRender = 0;
	ld	hl,#_needRender
	ld	(hl),#0x00
	ret
;src/State_InGame.c:88: void state_ingame_render(){
;	---------------------------------
; Function state_ingame_render
; ---------------------------------
_state_ingame_render::
;src/State_InGame.c:89: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
	ld	hl,#0x6428
	push	hl
	ld	hl,#0xC0B4
	push	hl
	ld	hl,#0x2940
	push	hl
	call	_cpct_drawSprite
;src/State_InGame.c:90: renderCompass();
	call	_renderCompass
;src/State_InGame.c:91: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
	ld	hl,#0x4010
	push	hl
	ld	hl,#0xC570
	push	hl
	ld	hl,#0x38E0
	push	hl
	call	_cpct_drawSprite
	ret
;src/State_InGame.c:94: void state_ingame_exit(){
;	---------------------------------
; Function state_ingame_exit
; ---------------------------------
_state_ingame_exit::
;src/State_InGame.c:95: *(u8*)&isInitialized = 0;
	ld	hl,#_isInitialized
	ld	(hl),#0x00
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
