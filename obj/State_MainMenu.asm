;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_MainMenu
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _draw_main_bg
	.globl _dec_main_bg
	.globl _level_set_level
	.globl _player_init
	.globl _statemanager_exit_game
	.globl _statemanager_input_accepted
	.globl _statemanager_set_state
	.globl _ui_mainmenu_render_refresh
	.globl _ui_mainmenu_render_all
	.globl _ui_mainmenu_unselect_entry
	.globl _ui_mainmenu_select_entry
	.globl _ui_mainmenu_previous_entry
	.globl _ui_mainmenu_next_entry
	.globl _ui_mainmenu_is_selected
	.globl _ui_mainmenu_get_entry
	.globl _ui_mainmenu_init
	.globl _cpct_hflipSpriteM0
	.globl _cpct_drawSprite
	.globl _cpct_isKeyPressed
	.globl _cpct_memcpy
	.globl _cpct_memset
	.globl _state_mainmenu_enter
	.globl _state_mainmenu_return
	.globl _state_mainmenu_input
	.globl _state_mainmenu_update
	.globl _state_mainmenu_render
	.globl _state_mainmenu_exit
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
;src/State_MainMenu.c:24: void dec_main_bg(){
;	---------------------------------
; Function dec_main_bg
; ---------------------------------
_dec_main_bg::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-9
	add	hl,sp
	ld	sp,hl
;src/State_MainMenu.c:29: newPos=0;
	ld	-9 (ix),#0x00
;src/State_MainMenu.c:30: texture_set = menu_bg;
	ld	-8 (ix),#<(_menu_bg)
	ld	-7 (ix),#>(_menu_bg)
;src/State_MainMenu.c:32: position=MANUALLY_ALLOCATED_MEMORY_START;
	ld	bc,#0x88D0
;src/State_MainMenu.c:33: *position=0;
	ld	hl,#0x88D0
	ld	(hl),#0x00
;src/State_MainMenu.c:36: while(length){
	ld	de,#0x06CF
00106$:
	ld	a,d
	or	a,e
	jp	Z,00108$
;src/State_MainMenu.c:37: value = g_colors[(*texture_set)&0x0F];
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	a,(hl)
	ld	-5 (ix), a
	and	a, #0x0F
	add	a,#<(_g_colors)
	ld	l,a
	ld	a,#>(_g_colors)
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/State_MainMenu.c:38: counter = ((*texture_set)>>4)+1;
	ld	a,-5 (ix)
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0F
	inc	a
	ld	-5 (ix),a
;src/State_MainMenu.c:39: while(counter){
	ld	a,l
	and	a, #0xAA
	ld	-4 (ix),a
	ld	a,l
	and	a, #0x55
	ld	-2 (ix),a
	ld	a,-9 (ix)
	ld	-6 (ix),a
00103$:
	ld	a,-5 (ix)
	or	a, a
	jr	Z,00119$
;src/State_MainMenu.c:40: *position=(*position)|((newPos&1)?(value&0b01010101):(value&0b10101010));
	push	bc
	pop	iy
	ld	a,(bc)
	ld	-3 (ix),a
	ld	a,-6 (ix)
	and	a, #0x01
	ld	-1 (ix), a
	or	a, a
	jr	Z,00111$
	ld	a,-2 (ix)
	jr	00112$
00111$:
	ld	a,-4 (ix)
00112$:
	or	a, -3 (ix)
	ld	0 (iy), a
;src/State_MainMenu.c:41: if(newPos&1){
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00102$
;src/State_MainMenu.c:42: ++position;
	inc	bc
;src/State_MainMenu.c:43: *position=0;
	xor	a, a
	ld	(bc),a
00102$:
;src/State_MainMenu.c:45: ++newPos;
	inc	-6 (ix)
;src/State_MainMenu.c:46: --counter;
	dec	-5 (ix)
	jr	00103$
00119$:
	ld	a,-6 (ix)
	ld	-9 (ix),a
;src/State_MainMenu.c:48: ++texture_set;
	inc	-8 (ix)
	jr	NZ,00139$
	inc	-7 (ix)
00139$:
;src/State_MainMenu.c:49: --length;
	dec	de
	jp	00106$
00108$:
;src/State_MainMenu.c:52: cpct_memcpy((MANUALLY_ALLOCATED_MEMORY_START+4000),MANUALLY_ALLOCATED_MEMORY_START,4000);
	ld	hl,#0x0FA0
	push	hl
	ld	hl,#0x88D0
	push	hl
	ld	hl,#0x9870
	push	hl
	call	_cpct_memcpy
;src/State_MainMenu.c:53: cpct_hflipSpriteM0 (40, 100, (MANUALLY_ALLOCATED_MEMORY_START+4000));
	ld	hl,#0x9870
	push	hl
	ld	hl,#0x6428
	push	hl
	call	_cpct_hflipSpriteM0
	ld	sp, ix
	pop	ix
	ret
;src/State_MainMenu.c:56: void draw_main_bg(){
;	---------------------------------
; Function draw_main_bg
; ---------------------------------
_draw_main_bg::
;src/State_MainMenu.c:57: cpct_drawSprite (MANUALLY_ALLOCATED_MEMORY_START, cpctm_screenPtr(CPCT_VMEM_START, 0, 100),40,100);
	ld	hl,#0x6428
	push	hl
	ld	hl,#0xE3C0
	push	hl
	ld	hl,#0x88D0
	push	hl
	call	_cpct_drawSprite
;src/State_MainMenu.c:58: cpct_drawSprite ((MANUALLY_ALLOCATED_MEMORY_START+4000), cpctm_screenPtr(CPCT_VMEM_START, 40, 100), 40, 100);
	ld	hl,#0x6428
	push	hl
	ld	hl,#0xE3E8
	push	hl
	ld	hl,#0x9870
	push	hl
	call	_cpct_drawSprite
	ret
;src/State_MainMenu.c:61: void state_mainmenu_enter(){
;	---------------------------------
; Function state_mainmenu_enter
; ---------------------------------
_state_mainmenu_enter::
;src/State_MainMenu.c:63: cpct_memset(CPCT_VMEM_START, g_colors[7], 0x4000);
	ld	hl, #(_g_colors + 0x0007) + 0
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/State_MainMenu.c:64: setMenuPalette();
	call	_setMenuPalette
;src/State_MainMenu.c:65: dec_main_bg();
	call	_dec_main_bg
;src/State_MainMenu.c:66: draw_main_bg();
	call	_draw_main_bg
;src/State_MainMenu.c:67: camelot_warriors_mode=0;
	ld	hl,#_camelot_warriors_mode + 0
	ld	(hl), #0x00
;src/State_MainMenu.c:68: ui_mainmenu_init();
	call	_ui_mainmenu_init
;src/State_MainMenu.c:69: ui_mainmenu_render_all();
	call	_ui_mainmenu_render_all
	ret
;src/State_MainMenu.c:73: void state_mainmenu_return() {
;	---------------------------------
; Function state_mainmenu_return
; ---------------------------------
_state_mainmenu_return::
;src/State_MainMenu.c:74: cpct_memset(CPCT_VMEM_START, g_colors[7], 0x4000);
	ld	hl, #(_g_colors + 0x0007) + 0
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/State_MainMenu.c:75: draw_main_bg();
	call	_draw_main_bg
;src/State_MainMenu.c:76: ui_mainmenu_render_all();
	call	_ui_mainmenu_render_all
	ret
;src/State_MainMenu.c:79: void state_mainmenu_input(){
;	---------------------------------
; Function state_mainmenu_input
; ---------------------------------
_state_mainmenu_input::
;src/State_MainMenu.c:80: if(cpct_isKeyPressed(Key_CursorUp)){
	ld	hl,#0x0100
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00107$
;src/State_MainMenu.c:81: ui_mainmenu_previous_entry();
	call	_ui_mainmenu_previous_entry
;src/State_MainMenu.c:82: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00107$:
;src/State_MainMenu.c:84: else if(cpct_isKeyPressed(Key_CursorDown)){
	ld	hl,#0x0400
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00104$
;src/State_MainMenu.c:85: ui_mainmenu_next_entry();
	call	_ui_mainmenu_next_entry
;src/State_MainMenu.c:86: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00104$:
;src/State_MainMenu.c:88: else if(cpct_isKeyPressed(Key_Return)){
	ld	hl,#0x0402
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	ret	Z
;src/State_MainMenu.c:89: ui_mainmenu_select_entry();
	call	_ui_mainmenu_select_entry
;src/State_MainMenu.c:90: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_MainMenu.c:94: void state_mainmenu_update(){
;	---------------------------------
; Function state_mainmenu_update
; ---------------------------------
_state_mainmenu_update::
;src/State_MainMenu.c:95: if(ui_mainmenu_is_selected()){
	call	_ui_mainmenu_is_selected
	ld	a,l
	or	a, a
	ret	Z
;src/State_MainMenu.c:96: ui_mainmenu_render_refresh();
	call	_ui_mainmenu_render_refresh
;src/State_MainMenu.c:97: switch(ui_mainmenu_get_entry()){
	call	_ui_mainmenu_get_entry
	ld	e,l
	ld	a,#0x04
	sub	a, e
	jp	C,_ui_mainmenu_unselect_entry
	ld	d,#0x00
	ld	hl,#00119$
	add	hl,de
	add	hl,de
;src/State_MainMenu.c:98: case 0:{
	jp	(hl)
00119$:
	jr	00101$
	jr	00102$
	jr	00103$
	jr	00104$
	jr	00105$
00101$:
;src/State_MainMenu.c:99: level_set_level(0);
	xor	a, a
	push	af
	inc	sp
	call	_level_set_level
	inc	sp
;src/State_MainMenu.c:100: level_seed=0;
	ld	hl,#0x0000
	ld	(_level_seed),hl
;src/State_MainMenu.c:101: player_init();
	call	_player_init
;src/State_MainMenu.c:102: statemanager_set_state(STATE_LOADLEVEL);
	ld	a,#0x03
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_MainMenu.c:103: break;
	jp	_ui_mainmenu_unselect_entry
;src/State_MainMenu.c:105: case 1:{
00102$:
;src/State_MainMenu.c:106: statemanager_set_state(STATE_LOADGAME);
	ld	a,#0x0A
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_MainMenu.c:107: break;
	jp	_ui_mainmenu_unselect_entry
;src/State_MainMenu.c:109: case 2:{
00103$:
;src/State_MainMenu.c:110: statemanager_set_state(STATE_OPTIONS);
	ld	a,#0x04
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_MainMenu.c:111: break;
	jp	_ui_mainmenu_unselect_entry
;src/State_MainMenu.c:113: case 3:{
00104$:
;src/State_MainMenu.c:114: statemanager_set_state(STATE_CREDITS);
	ld	a,#0x06
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/State_MainMenu.c:115: break;
	jp	_ui_mainmenu_unselect_entry
;src/State_MainMenu.c:117: case 4:{
00105$:
;src/State_MainMenu.c:118: statemanager_exit_game();
	call	_statemanager_exit_game
;src/State_MainMenu.c:121: }
;src/State_MainMenu.c:122: ui_mainmenu_unselect_entry();
	jp  _ui_mainmenu_unselect_entry
;src/State_MainMenu.c:126: void state_mainmenu_render() {
;	---------------------------------
; Function state_mainmenu_render
; ---------------------------------
_state_mainmenu_render::
;src/State_MainMenu.c:127: ui_mainmenu_render_refresh();
	jp  _ui_mainmenu_render_refresh
;src/State_MainMenu.c:130: void state_mainmenu_exit(){
;	---------------------------------
; Function state_mainmenu_exit
; ---------------------------------
_state_mainmenu_exit::
;src/State_MainMenu.c:132: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
