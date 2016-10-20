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
;src/UI_GameMenu.c:74: void ui_gamemenu_init(){
;	---------------------------------
; Function ui_gamemenu_init
; ---------------------------------
_ui_gamemenu_init::
;src/UI_GameMenu.c:75: ui_gamemenu_lastEntry=0;
	ld	hl,#_ui_gamemenu_lastEntry + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:76: ui_gamemenu_entryIndex=0;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:77: ui_gamemenu_entrySelected=0;
	ld	hl,#_ui_gamemenu_entrySelected + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:78: ui_gamemenu_update_action();
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
;src/UI_GameMenu.c:81: void ui_gamemenu_above_entry(){
;	---------------------------------
; Function ui_gamemenu_above_entry
; ---------------------------------
_ui_gamemenu_above_entry::
;src/UI_GameMenu.c:82: if(ui_gamemenu_entryIndex>=2 && ui_gamemenu_entryIndex<5){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	cp	a,#0x02
	jr	C,00105$
	sub	a, #0x05
	jr	NC,00105$
;src/UI_GameMenu.c:83: ui_gamemenu_entryIndex=0;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x00
	ret
00105$:
;src/UI_GameMenu.c:85: else if(ui_gamemenu_entryIndex==5 || ui_gamemenu_entryIndex == 6){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	cp	a,#0x05
	jr	Z,00101$
	sub	a, #0x06
	ret	NZ
00101$:
;src/UI_GameMenu.c:86: ui_gamemenu_entryIndex=1;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x01
	ret
;src/UI_GameMenu.c:90: void ui_gamemenu_below_entry(){
;	---------------------------------
; Function ui_gamemenu_below_entry
; ---------------------------------
_ui_gamemenu_below_entry::
;src/UI_GameMenu.c:91: if(ui_gamemenu_entryIndex==0){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	or	a, a
	jr	NZ,00104$
;src/UI_GameMenu.c:92: ui_gamemenu_entryIndex=3;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x03
	ret
00104$:
;src/UI_GameMenu.c:94: else if(ui_gamemenu_entryIndex==1){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	dec	a
	ret	NZ
;src/UI_GameMenu.c:95: ui_gamemenu_entryIndex=5;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x05
	ret
;src/UI_GameMenu.c:99: void ui_gamemenu_next_entry(){
;	---------------------------------
; Function ui_gamemenu_next_entry
; ---------------------------------
_ui_gamemenu_next_entry::
;src/UI_GameMenu.c:100: if(ui_gamemenu_entryIndex<(UI_GAMEMENU_ENTRIES-1) && ui_gamemenu_entryIndex!=1){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	cp	a,#0x06
	ret	NC
	dec	a
	ret	Z
;src/UI_GameMenu.c:101: ++ui_gamemenu_entryIndex;
	ld	hl, #_ui_gamemenu_entryIndex+0
	inc	(hl)
	ret
;src/UI_GameMenu.c:105: void ui_gamemenu_previous_entry(){
;	---------------------------------
; Function ui_gamemenu_previous_entry
; ---------------------------------
_ui_gamemenu_previous_entry::
;src/UI_GameMenu.c:106: if(ui_gamemenu_entryIndex>0 && ui_gamemenu_entryIndex!=2){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	or	a, a
	ret	Z
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	sub	a, #0x02
	ret	Z
;src/UI_GameMenu.c:107: --ui_gamemenu_entryIndex;
	ld	hl, #_ui_gamemenu_entryIndex+0
	dec	(hl)
	ret
;src/UI_GameMenu.c:111: void ui_gamemenu_unselect_entry(){
;	---------------------------------
; Function ui_gamemenu_unselect_entry
; ---------------------------------
_ui_gamemenu_unselect_entry::
;src/UI_GameMenu.c:112: ui_gamemenu_entrySelected=0;
	ld	hl,#_ui_gamemenu_entrySelected + 0
	ld	(hl), #0x00
	ret
;src/UI_GameMenu.c:115: void ui_gamemenu_select_entry(){
;	---------------------------------
; Function ui_gamemenu_select_entry
; ---------------------------------
_ui_gamemenu_select_entry::
;src/UI_GameMenu.c:116: ui_gamemenu_entrySelected=1;
	ld	hl,#_ui_gamemenu_entrySelected + 0
	ld	(hl), #0x01
	ret
;src/UI_GameMenu.c:119: void ui_gamemenu_render_button(u8 n){
;	---------------------------------
; Function ui_gamemenu_render_button
; ---------------------------------
_ui_gamemenu_render_button::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;src/UI_GameMenu.c:121: color = (n==ui_gamemenu_entryIndex)?((ui_gamemenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
	ld	a,4 (ix)
	ld	iy,#_ui_gamemenu_entryIndex
	sub	a, 0 (iy)
	jr	NZ,00103$
	ld	a,(#_ui_gamemenu_entrySelected + 0)
	or	a, a
	jr	Z,00105$
	ld	a, (#(_g_colors + 0x0004) + 0)
	jr	00104$
00105$:
	ld	a, (#(_g_colors + 0x0006) + 0)
	jr	00104$
00103$:
	ld	a, (#(_g_colors + 0x0002) + 0)
00104$:
	ld	c,a
;src/UI_GameMenu.c:122: cpct_drawSolidBox(ui_gamemenu_entriesPosition[n],color, ui_gamemenu_buttonWidths[n], UI_GAMEMENU_BUTTON_HEIGHT);
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
	ld	a,(hl)
	ld	-2 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-1 (ix),a
	push	de
	ld	a,#0x18
	push	af
	inc	sp
	push	bc
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
	pop	de
;src/UI_GameMenu.c:123: print_transparent_text(ui_gamemenu_buttonText[n], ui_gamemenu_entriesTextPosition[n], 3);
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
	ld	sp,ix
	pop	ix
	ret
;src/UI_GameMenu.c:135: void ui_gamemenu_render_refresh(){
;	---------------------------------
; Function ui_gamemenu_render_refresh
; ---------------------------------
_ui_gamemenu_render_refresh::
;src/UI_GameMenu.c:137: ui_gamemenu_render_button(ui_gamemenu_entryIndex);
	ld	a,(_ui_gamemenu_entryIndex)
	push	af
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
;src/UI_GameMenu.c:138: ui_gamemenu_render_button(ui_gamemenu_lastEntry);
	ld	a,(_ui_gamemenu_lastEntry)
	push	af
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
;src/UI_GameMenu.c:141: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	ld	(#_ui_gamemenu_lastEntry + 0),a
	ret
;src/UI_GameMenu.c:145: void ui_gamemenu_render_all(){
;	---------------------------------
; Function ui_gamemenu_render_all
; ---------------------------------
_ui_gamemenu_render_all::
;src/UI_GameMenu.c:149: while(n){
	ld	b,#0x07
00101$:
	ld	a,b
	or	a, a
	jr	Z,00103$
;src/UI_GameMenu.c:150: --n;
	dec	b
;src/UI_GameMenu.c:151: ui_gamemenu_render_button(n);
	push	bc
	push	bc
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
	pop	bc
	jr	00101$
00103$:
;src/UI_GameMenu.c:154: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	ld	(#_ui_gamemenu_lastEntry + 0),a
	ret
;src/UI_GameMenu.c:157: u8 ui_gamemenu_get_entry(){
;	---------------------------------
; Function ui_gamemenu_get_entry
; ---------------------------------
_ui_gamemenu_get_entry::
;src/UI_GameMenu.c:158: return ui_gamemenu_entryIndex;
	ld	iy,#_ui_gamemenu_entryIndex
	ld	l,0 (iy)
	ret
;src/UI_GameMenu.c:161: u8 ui_gamemenu_is_selected(){
;	---------------------------------
; Function ui_gamemenu_is_selected
; ---------------------------------
_ui_gamemenu_is_selected::
;src/UI_GameMenu.c:162: return ui_gamemenu_entrySelected;
	ld	iy,#_ui_gamemenu_entrySelected
	ld	l,0 (iy)
	ret
;src/UI_GameMenu.c:165: void ui_gamemenu_update_action(){
;	---------------------------------
; Function ui_gamemenu_update_action
; ---------------------------------
_ui_gamemenu_update_action::
;src/UI_GameMenu.c:166: u8 forward = *(u8*)(MAP_MEM + (player_position.x+player_direction.x) + (player_position.y+player_direction.y) * MAP_WIDTH);
	ld	hl,#_player_position+0
	ld	c,(hl)
	ld	b,#0x00
	ld	a, (#_player_direction + 0)
	ld	l,a
	rla
	sbc	a, a
	ld	h,a
	add	hl,bc
	ld	bc,#0x7000
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
	ld	c,(hl)
;src/UI_GameMenu.c:169: ui_gamemenu_can_move=0;
	ld	hl,#_ui_gamemenu_can_move + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:170: *((char**)(ui_gamemenu_buttonText)+3)="";
	ld	hl,#___str_9
	ld	((_ui_gamemenu_buttonText + 0x0006)), hl
;src/UI_GameMenu.c:172: ui_gamemenu_action=0;
	ld	iy,#_ui_gamemenu_action
	ld	0 (iy),#0x00
;src/UI_GameMenu.c:173: *((char**)ui_gamemenu_buttonText)="";
	ld	(_ui_gamemenu_buttonText), hl
;src/UI_GameMenu.c:175: if(forward&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00110$
;src/UI_GameMenu.c:176: if(forward==CELLTYPE_DOOR){
	ld	a,c
	sub	a, #0x80
	jr	NZ,00111$
;src/UI_GameMenu.c:177: ui_gamemenu_action=1;
	ld	hl,#_ui_gamemenu_action + 0
	ld	(hl), #0x01
;src/UI_GameMenu.c:178: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[0];
	ld	bc, (#_ui_gamemenu_action_buttonText + 0)
	ld	(_ui_gamemenu_buttonText), bc
	jr	00111$
00110$:
;src/UI_GameMenu.c:181: else if(forward&CELL_ENEMY_MASK){
	ld	a,c
	and	a, #0x0F
	jr	Z,00107$
;src/UI_GameMenu.c:182: ui_gamemenu_action=2;
	ld	hl,#_ui_gamemenu_action + 0
	ld	(hl), #0x02
;src/UI_GameMenu.c:183: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[1];
	ld	bc, (#(_ui_gamemenu_action_buttonText + 0x0002) + 0)
	ld	(_ui_gamemenu_buttonText), bc
	jr	00111$
00107$:
;src/UI_GameMenu.c:185: else if(forward&CELL_ITEM_MASK){
	ld	a,c
	and	a, #0x70
	jr	Z,00104$
;src/UI_GameMenu.c:186: ui_gamemenu_action=3;
	ld	hl,#_ui_gamemenu_action + 0
	ld	(hl), #0x03
;src/UI_GameMenu.c:187: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[2];
	ld	bc, (#(_ui_gamemenu_action_buttonText + 0x0004) + 0)
	ld	(_ui_gamemenu_buttonText), bc
	jr	00111$
00104$:
;src/UI_GameMenu.c:190: ui_gamemenu_can_move=1;
	ld	hl,#_ui_gamemenu_can_move + 0
	ld	(hl), #0x01
;src/UI_GameMenu.c:191: *(char**)(ui_gamemenu_buttonText+3)="MOVE";
	ld	hl,#___str_10
	ld	((_ui_gamemenu_buttonText + 0x0006)), hl
00111$:
;src/UI_GameMenu.c:193: ui_gamemenu_render_button(0);
	xor	a, a
	push	af
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
;src/UI_GameMenu.c:194: ui_gamemenu_render_button(3);
	ld	a,#0x03
	push	af
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
	ret
___str_9:
	.db 0x00
___str_10:
	.ascii "MOVE"
	.db 0x00
;src/UI_GameMenu.c:197: u8 ui_gamemenu_get_movement(){
;	---------------------------------
; Function ui_gamemenu_get_movement
; ---------------------------------
_ui_gamemenu_get_movement::
;src/UI_GameMenu.c:198: return ui_gamemenu_can_move;
	ld	iy,#_ui_gamemenu_can_move
	ld	l,0 (iy)
	ret
;src/UI_GameMenu.c:201: u8 ui_gamemenu_get_action(){
;	---------------------------------
; Function ui_gamemenu_get_action
; ---------------------------------
_ui_gamemenu_get_action::
;src/UI_GameMenu.c:202: return ui_gamemenu_action;
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
