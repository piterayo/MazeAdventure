;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module UI_GameMenu
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ui_gamemenu_render_button
	.globl _print_transparent_text
	.globl _cpct_drawSolidBox
	.globl _ui_gamemenu_action
	.globl _ui_gamemenu_can_move
	.globl _ui_gamemenu_entrySelected
	.globl _ui_gamemenu_entryIndex
	.globl _ui_gamemenu_lastEntry
	.globl _ui_gamemenu_buttonWidths
	.globl _ui_gamemenu_buttonText
	.globl _ui_gamemenu_action_buttonText
	.globl _ui_gamemenu_entriesTextPosition
	.globl _ui_gamemenu_entriesPosition
	.globl _ui_gamemenu_init
	.globl _ui_gamemenu_above_entry
	.globl _ui_gamemenu_below_entry
	.globl _ui_gamemenu_next_entry
	.globl _ui_gamemenu_previous_entry
	.globl _ui_gamemenu_unselect_entry
	.globl _ui_gamemenu_select_entry
	.globl _ui_gamemenu_render_refresh
	.globl _ui_gamemenu_render_all
	.globl _ui_gamemenu_get_entry
	.globl _ui_gamemenu_is_selected
	.globl _ui_gamemenu_update_action
	.globl _ui_gamemenu_get_movement
	.globl _ui_gamemenu_get_action
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
_ui_gamemenu_lastEntry::
	.ds 1
_ui_gamemenu_entryIndex::
	.ds 1
_ui_gamemenu_entrySelected::
	.ds 1
_ui_gamemenu_can_move::
	.ds 1
_ui_gamemenu_action::
	.ds 1
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
;src/UI_GameMenu.c:72: void ui_gamemenu_init(){
;	---------------------------------
; Function ui_gamemenu_init
; ---------------------------------
_ui_gamemenu_init::
;src/UI_GameMenu.c:73: ui_gamemenu_lastEntry=0;
	ld	hl,#_ui_gamemenu_lastEntry + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:74: ui_gamemenu_entryIndex=0;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:75: ui_gamemenu_entrySelected=0;
	ld	hl,#_ui_gamemenu_entrySelected + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:76: ui_gamemenu_update_action();
	jp  _ui_gamemenu_update_action
_ui_gamemenu_entriesPosition:
	.dw #0xC550
	.dw #0xC584
	.dw #0xC6E0
	.dw #0xC6E7
	.dw #0xC6F6
	.dw #0xC714
	.dw #0xC723
_ui_gamemenu_entriesTextPosition:
	.dw #0xCDA4
	.dw #0xCDD9
	.dw #0xCF32
	.dw #0xCF3A
	.dw #0xCF48
	.dw #0xCF67
	.dw #0xCF75
_ui_gamemenu_action_buttonText:
	.dw __str_0
	.dw __str_1
	.dw __str_2
	.db 0x00
	.db 0x00
_ui_gamemenu_buttonText:
	.dw __str_3
	.dw __str_4
	.dw __str_5
	.dw __str_3
	.dw __str_6
	.dw __str_7
	.dw __str_8
_ui_gamemenu_buttonWidths:
	.db #0x1C	; 28
	.db #0x1C	; 28
	.db #0x06	; 6
	.db #0x0E	; 14
	.db #0x06	; 6
	.db #0x0D	; 13
	.db #0x0D	; 13
__str_0:
	.ascii "NEXT LEVEL"
	.db 0x00
__str_1:
	.ascii "  ATTACK"
	.db 0x00
__str_2:
	.ascii "   PICK UP"
	.db 0x00
__str_3:
	.db 0x00
__str_4:
	.ascii "INVENTORY"
	.db 0x00
__str_5:
	.ascii "<"
	.db 0x00
__str_6:
	.ascii ">"
	.db 0x00
__str_7:
	.ascii "WAIT"
	.db 0x00
__str_8:
	.ascii "PAUSE"
	.db 0x00
;src/UI_GameMenu.c:79: void ui_gamemenu_above_entry(){
;	---------------------------------
; Function ui_gamemenu_above_entry
; ---------------------------------
_ui_gamemenu_above_entry::
;src/UI_GameMenu.c:80: if(ui_gamemenu_entryIndex>=2 && ui_gamemenu_entryIndex<5){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	cp	a,#0x02
	jr	C,00105$
	sub	a, #0x05
	jr	NC,00105$
;src/UI_GameMenu.c:81: ui_gamemenu_entryIndex=0;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x00
	ret
00105$:
;src/UI_GameMenu.c:83: else if(ui_gamemenu_entryIndex==5 || ui_gamemenu_entryIndex == 6){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	cp	a,#0x05
	jr	Z,00101$
	sub	a, #0x06
	ret	NZ
00101$:
;src/UI_GameMenu.c:84: ui_gamemenu_entryIndex=1;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x01
	ret
;src/UI_GameMenu.c:88: void ui_gamemenu_below_entry(){
;	---------------------------------
; Function ui_gamemenu_below_entry
; ---------------------------------
_ui_gamemenu_below_entry::
;src/UI_GameMenu.c:89: if(ui_gamemenu_entryIndex==0){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	or	a, a
	jr	NZ,00104$
;src/UI_GameMenu.c:90: ui_gamemenu_entryIndex=3;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x03
	ret
00104$:
;src/UI_GameMenu.c:92: else if(ui_gamemenu_entryIndex==1){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	dec	a
	ret	NZ
;src/UI_GameMenu.c:93: ui_gamemenu_entryIndex=5;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x05
	ret
;src/UI_GameMenu.c:97: void ui_gamemenu_next_entry(){
;	---------------------------------
; Function ui_gamemenu_next_entry
; ---------------------------------
_ui_gamemenu_next_entry::
;src/UI_GameMenu.c:98: if(ui_gamemenu_entryIndex<(UI_GAMEMENU_ENTRIES-1) && ui_gamemenu_entryIndex!=1){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	cp	a,#0x06
	ret	NC
	dec	a
	ret	Z
;src/UI_GameMenu.c:99: ++ui_gamemenu_entryIndex;
	ld	hl, #_ui_gamemenu_entryIndex+0
	inc	(hl)
	ret
;src/UI_GameMenu.c:103: void ui_gamemenu_previous_entry(){
;	---------------------------------
; Function ui_gamemenu_previous_entry
; ---------------------------------
_ui_gamemenu_previous_entry::
;src/UI_GameMenu.c:104: if(ui_gamemenu_entryIndex>0 && ui_gamemenu_entryIndex!=2){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	or	a, a
	ret	Z
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	sub	a, #0x02
	ret	Z
;src/UI_GameMenu.c:105: --ui_gamemenu_entryIndex;
	ld	hl, #_ui_gamemenu_entryIndex+0
	dec	(hl)
	ret
;src/UI_GameMenu.c:109: void ui_gamemenu_unselect_entry(){
;	---------------------------------
; Function ui_gamemenu_unselect_entry
; ---------------------------------
_ui_gamemenu_unselect_entry::
;src/UI_GameMenu.c:110: ui_gamemenu_entrySelected=0;
	ld	hl,#_ui_gamemenu_entrySelected + 0
	ld	(hl), #0x00
	ret
;src/UI_GameMenu.c:113: void ui_gamemenu_select_entry(){
;	---------------------------------
; Function ui_gamemenu_select_entry
; ---------------------------------
_ui_gamemenu_select_entry::
;src/UI_GameMenu.c:114: ui_gamemenu_entrySelected=1;
	ld	hl,#_ui_gamemenu_entrySelected + 0
	ld	(hl), #0x01
	ret
;src/UI_GameMenu.c:117: void ui_gamemenu_render_button(u8 n){
;	---------------------------------
; Function ui_gamemenu_render_button
; ---------------------------------
_ui_gamemenu_render_button::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/UI_GameMenu.c:119: color = (n==ui_gamemenu_entryIndex)?((ui_gamemenu_entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
	ld	a,4 (ix)
	ld	iy,#_ui_gamemenu_entryIndex
	sub	a, 0 (iy)
	jr	NZ,00111$
	ld	a,(#_ui_gamemenu_entrySelected + 0)
	or	a, a
	jr	Z,00113$
	ld	a, (#(_g_colors + 0x0004) + 0)
	jr	00112$
00113$:
	ld	a, (#(_g_colors + 0x0005) + 0)
	jr	00112$
00111$:
	ld	a, (#(_g_colors + 0x0002) + 0)
00112$:
	ld	c,a
;src/UI_GameMenu.c:120: cpct_drawSolidBox(ui_gamemenu_entriesPosition[n],color, ui_gamemenu_buttonWidths[n], UI_GAMEMENU_BUTTON_HEIGHT);
	ld	de,#_ui_gamemenu_buttonWidths+0
	ld	l,4 (ix)
	ld	h,#0x00
	add	hl,de
	ld	b,(hl)
	ld	l,4 (ix)
	ld	h,#0x00
	add	hl, hl
	ex	de,hl
	ld	hl,#_ui_gamemenu_entriesPosition
	add	hl,de
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	pop	iy
	push	de
	ld	a,#0x18
	push	af
	inc	sp
	push	bc
	push	iy
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
	pop	de
;src/UI_GameMenu.c:121: if(n==0 && ui_gamemenu_action){
	ld	a,4 (ix)
	or	a, a
	jr	NZ,00106$
	ld	a,(#_ui_gamemenu_action + 0)
	or	a, a
	jr	Z,00106$
;src/UI_GameMenu.c:122: print_transparent_text(ui_gamemenu_action_buttonText[ui_gamemenu_action-1], ui_gamemenu_entriesTextPosition[n], 3);
	ld	hl,#_ui_gamemenu_entriesTextPosition
	add	hl,de
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	hl,#_ui_gamemenu_action + 0
	ld	e, (hl)
	dec	e
	ld	h,#0x00
	ld	l, e
	add	hl, hl
	ld	de,#_ui_gamemenu_action_buttonText
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x03
	push	af
	inc	sp
	push	bc
	push	de
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
	jr	00109$
00106$:
;src/UI_GameMenu.c:124: else if(n==3 && ui_gamemenu_can_move){
	ld	a,4 (ix)
	sub	a, #0x03
	jr	NZ,00102$
	ld	a,(#_ui_gamemenu_can_move + 0)
	or	a, a
	jr	Z,00102$
;src/UI_GameMenu.c:125: print_transparent_text("MOVE", ui_gamemenu_entriesTextPosition[n], 3);
	ld	hl,#_ui_gamemenu_entriesTextPosition
	add	hl,de
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,#0x03
	push	af
	inc	sp
	push	bc
	ld	hl,#___str_9
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
	jr	00109$
00102$:
;src/UI_GameMenu.c:128: print_transparent_text(ui_gamemenu_buttonText[n], ui_gamemenu_entriesTextPosition[n], 3);
	ld	hl,#_ui_gamemenu_entriesTextPosition
	add	hl,de
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	hl,#_ui_gamemenu_buttonText
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x03
	push	af
	inc	sp
	push	bc
	push	de
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
00109$:
	pop	ix
	ret
___str_9:
	.ascii "MOVE"
	.db 0x00
;src/UI_GameMenu.c:132: void ui_gamemenu_render_refresh(){
;	---------------------------------
; Function ui_gamemenu_render_refresh
; ---------------------------------
_ui_gamemenu_render_refresh::
;src/UI_GameMenu.c:134: ui_gamemenu_render_button(ui_gamemenu_entryIndex);
	ld	a,(_ui_gamemenu_entryIndex)
	push	af
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
;src/UI_GameMenu.c:135: ui_gamemenu_render_button(ui_gamemenu_lastEntry);
	ld	a,(_ui_gamemenu_lastEntry)
	push	af
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
;src/UI_GameMenu.c:138: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	ld	(#_ui_gamemenu_lastEntry + 0),a
	ret
;src/UI_GameMenu.c:142: void ui_gamemenu_render_all(){
;	---------------------------------
; Function ui_gamemenu_render_all
; ---------------------------------
_ui_gamemenu_render_all::
;src/UI_GameMenu.c:146: while(n){
	ld	b,#0x07
00101$:
	ld	a,b
	or	a, a
	jr	Z,00103$
;src/UI_GameMenu.c:147: --n;
	dec	b
;src/UI_GameMenu.c:148: ui_gamemenu_render_button(n);
	push	bc
	push	bc
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
	pop	bc
	jr	00101$
00103$:
;src/UI_GameMenu.c:151: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	ld	(#_ui_gamemenu_lastEntry + 0),a
	ret
;src/UI_GameMenu.c:154: u8 ui_gamemenu_get_entry(){
;	---------------------------------
; Function ui_gamemenu_get_entry
; ---------------------------------
_ui_gamemenu_get_entry::
;src/UI_GameMenu.c:155: return ui_gamemenu_entryIndex;
	ld	iy,#_ui_gamemenu_entryIndex
	ld	l,0 (iy)
	ret
;src/UI_GameMenu.c:158: u8 ui_gamemenu_is_selected(){
;	---------------------------------
; Function ui_gamemenu_is_selected
; ---------------------------------
_ui_gamemenu_is_selected::
;src/UI_GameMenu.c:159: return ui_gamemenu_entrySelected;
	ld	iy,#_ui_gamemenu_entrySelected
	ld	l,0 (iy)
	ret
;src/UI_GameMenu.c:162: void ui_gamemenu_update_action(){
;	---------------------------------
; Function ui_gamemenu_update_action
; ---------------------------------
_ui_gamemenu_update_action::
;src/UI_GameMenu.c:163: u8 forward = *(u8*)(MAP_MEM + (player_position.x+player_direction.x) + (player_position.y+player_direction.y) * MAP_WIDTH);
	ld	hl, #_player_position + 0
	ld	c,(hl)
	ld	b,#0x00
	ld	a, (#_player_direction + 0)
	ld	l,a
	rla
	sbc	a, a
	ld	h,a
	add	hl,bc
	ld	bc,#0x6000
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	hl, #(_player_position + 0x0001) + 0
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
	ld	c,(hl)
;src/UI_GameMenu.c:165: ui_gamemenu_can_move=0;
	ld	hl,#_ui_gamemenu_can_move + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:166: ui_gamemenu_action=0;
	ld	hl,#_ui_gamemenu_action + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:168: if(forward&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00110$
;src/UI_GameMenu.c:169: if(forward==CELLTYPE_DOOR){
	ld	a,c
	sub	a, #0x80
	jr	NZ,00111$
;src/UI_GameMenu.c:170: ui_gamemenu_action=1;
	ld	hl,#_ui_gamemenu_action + 0
	ld	(hl), #0x01
	jr	00111$
00110$:
;src/UI_GameMenu.c:173: else if(forward&CELL_ENEMY_MASK) ui_gamemenu_action=2;
	ld	a,c
	and	a, #0x0F
	jr	Z,00107$
	ld	hl,#_ui_gamemenu_action + 0
	ld	(hl), #0x02
	jr	00111$
00107$:
;src/UI_GameMenu.c:174: else if(forward&CELL_ITEM_MASK) ui_gamemenu_action=3;
	ld	a,c
	and	a, #0x70
	jr	Z,00104$
	ld	hl,#_ui_gamemenu_action + 0
	ld	(hl), #0x03
	jr	00111$
00104$:
;src/UI_GameMenu.c:176: ui_gamemenu_can_move=1;
	ld	hl,#_ui_gamemenu_can_move + 0
	ld	(hl), #0x01
00111$:
;src/UI_GameMenu.c:178: ui_gamemenu_render_button(0);
	xor	a, a
	push	af
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
;src/UI_GameMenu.c:179: ui_gamemenu_render_button(3);
	ld	a,#0x03
	push	af
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
	ret
;src/UI_GameMenu.c:182: u8 ui_gamemenu_get_movement(){
;	---------------------------------
; Function ui_gamemenu_get_movement
; ---------------------------------
_ui_gamemenu_get_movement::
;src/UI_GameMenu.c:183: return ui_gamemenu_can_move;
	ld	iy,#_ui_gamemenu_can_move
	ld	l,0 (iy)
	ret
;src/UI_GameMenu.c:186: u8 ui_gamemenu_get_action(){
;	---------------------------------
; Function ui_gamemenu_get_action
; ---------------------------------
_ui_gamemenu_get_action::
;src/UI_GameMenu.c:187: return ui_gamemenu_action;
	ld	iy,#_ui_gamemenu_action
	ld	l,0 (iy)
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__ui_gamemenu_lastEntry:
	.db #0x00	; 0
__xinit__ui_gamemenu_entryIndex:
	.db #0x00	; 0
__xinit__ui_gamemenu_entrySelected:
	.db #0x00	; 0
__xinit__ui_gamemenu_can_move:
	.db #0x00	; 0
__xinit__ui_gamemenu_action:
	.db #0x00	; 0
	.area _CABS (ABS)
