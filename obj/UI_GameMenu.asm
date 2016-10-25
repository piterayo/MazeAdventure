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
	.globl _integer_to_string
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
;src/UI_GameMenu.c:77: void ui_gamemenu_init(){
;	---------------------------------
; Function ui_gamemenu_init
; ---------------------------------
_ui_gamemenu_init::
;src/UI_GameMenu.c:78: ui_gamemenu_lastEntry=0;
	ld	hl,#_ui_gamemenu_lastEntry + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:79: ui_gamemenu_entryIndex=0;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:80: ui_gamemenu_entrySelected=0;
	ld	hl,#_ui_gamemenu_entrySelected + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:81: ui_gamemenu_update_action();
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
	.ascii "  PICK UP"
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
;src/UI_GameMenu.c:84: void ui_gamemenu_above_entry(){
;	---------------------------------
; Function ui_gamemenu_above_entry
; ---------------------------------
_ui_gamemenu_above_entry::
;src/UI_GameMenu.c:85: if(ui_gamemenu_entryIndex>=2 && ui_gamemenu_entryIndex<5){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	cp	a,#0x02
	jr	C,00105$
	sub	a, #0x05
	jr	NC,00105$
;src/UI_GameMenu.c:86: ui_gamemenu_entryIndex=0;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x00
	ret
00105$:
;src/UI_GameMenu.c:88: else if(ui_gamemenu_entryIndex==5 || ui_gamemenu_entryIndex == 6){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	cp	a,#0x05
	jr	Z,00101$
	sub	a, #0x06
	ret	NZ
00101$:
;src/UI_GameMenu.c:89: ui_gamemenu_entryIndex=1;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x01
	ret
;src/UI_GameMenu.c:93: void ui_gamemenu_below_entry(){
;	---------------------------------
; Function ui_gamemenu_below_entry
; ---------------------------------
_ui_gamemenu_below_entry::
;src/UI_GameMenu.c:94: if(ui_gamemenu_entryIndex==0){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	or	a, a
	jr	NZ,00104$
;src/UI_GameMenu.c:95: ui_gamemenu_entryIndex=3;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x03
	ret
00104$:
;src/UI_GameMenu.c:97: else if(ui_gamemenu_entryIndex==1){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	dec	a
	ret	NZ
;src/UI_GameMenu.c:98: ui_gamemenu_entryIndex=5;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x05
	ret
;src/UI_GameMenu.c:102: void ui_gamemenu_next_entry(){
;	---------------------------------
; Function ui_gamemenu_next_entry
; ---------------------------------
_ui_gamemenu_next_entry::
;src/UI_GameMenu.c:103: if(ui_gamemenu_entryIndex<(UI_GAMEMENU_ENTRIES-1) && ui_gamemenu_entryIndex!=1){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	cp	a,#0x06
	ret	NC
	dec	a
	ret	Z
;src/UI_GameMenu.c:104: ++ui_gamemenu_entryIndex;
	ld	hl, #_ui_gamemenu_entryIndex+0
	inc	(hl)
	ret
;src/UI_GameMenu.c:108: void ui_gamemenu_previous_entry(){
;	---------------------------------
; Function ui_gamemenu_previous_entry
; ---------------------------------
_ui_gamemenu_previous_entry::
;src/UI_GameMenu.c:109: if(ui_gamemenu_entryIndex>0 && ui_gamemenu_entryIndex!=2){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	or	a, a
	ret	Z
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	sub	a, #0x02
	ret	Z
;src/UI_GameMenu.c:110: --ui_gamemenu_entryIndex;
	ld	hl, #_ui_gamemenu_entryIndex+0
	dec	(hl)
	ret
;src/UI_GameMenu.c:114: void ui_gamemenu_unselect_entry(){
;	---------------------------------
; Function ui_gamemenu_unselect_entry
; ---------------------------------
_ui_gamemenu_unselect_entry::
;src/UI_GameMenu.c:115: ui_gamemenu_entrySelected=0;
	ld	hl,#_ui_gamemenu_entrySelected + 0
	ld	(hl), #0x00
	ret
;src/UI_GameMenu.c:118: void ui_gamemenu_select_entry(){
;	---------------------------------
; Function ui_gamemenu_select_entry
; ---------------------------------
_ui_gamemenu_select_entry::
;src/UI_GameMenu.c:119: ui_gamemenu_entrySelected=1;
	ld	hl,#_ui_gamemenu_entrySelected + 0
	ld	(hl), #0x01
	ret
;src/UI_GameMenu.c:122: void ui_gamemenu_render_button(u8 n){
;	---------------------------------
; Function ui_gamemenu_render_button
; ---------------------------------
_ui_gamemenu_render_button::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;src/UI_GameMenu.c:124: color = (n==ui_gamemenu_entryIndex)?((ui_gamemenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
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
;src/UI_GameMenu.c:125: cpct_drawSolidBox(ui_gamemenu_entriesPosition[n],color, ui_gamemenu_buttonWidths[n], UI_GAMEMENU_BUTTON_HEIGHT);
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
;src/UI_GameMenu.c:126: print_transparent_text(ui_gamemenu_buttonText[n], ui_gamemenu_entriesTextPosition[n], 3);
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
;src/UI_GameMenu.c:138: void ui_gamemenu_render_refresh(){
;	---------------------------------
; Function ui_gamemenu_render_refresh
; ---------------------------------
_ui_gamemenu_render_refresh::
;src/UI_GameMenu.c:140: ui_gamemenu_render_button(ui_gamemenu_entryIndex);
	ld	a,(_ui_gamemenu_entryIndex)
	push	af
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
;src/UI_GameMenu.c:141: ui_gamemenu_render_button(ui_gamemenu_lastEntry);
	ld	a,(_ui_gamemenu_lastEntry)
	push	af
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
;src/UI_GameMenu.c:143: ui_gamemenu_render_button(0);
	xor	a, a
	push	af
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
;src/UI_GameMenu.c:144: ui_gamemenu_render_button(3);
	ld	a,#0x03
	push	af
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
;src/UI_GameMenu.c:147: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	ld	(#_ui_gamemenu_lastEntry + 0),a
	ret
;src/UI_GameMenu.c:151: void ui_gamemenu_render_all(){
;	---------------------------------
; Function ui_gamemenu_render_all
; ---------------------------------
_ui_gamemenu_render_all::
;src/UI_GameMenu.c:154: print_transparent_text("LEVEL ",UI_GAMEMENU_LEVEL_TEXT_POSITION, 3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xC000
	push	hl
	ld	hl,#___str_9
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/UI_GameMenu.c:155: print_transparent_text(integer_to_string(level_get_level(),'d'),UI_GAMEMENU_LEVEL_NUMBER_POSITION, 3);
	call	_level_get_level
	ld	b,l
	ld	a,#0x64
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_integer_to_string
	pop	af
	ld	c,l
	ld	b,h
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xC00C
	push	hl
	push	bc
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/UI_GameMenu.c:157: while(n){
	ld	b,#0x07
00101$:
	ld	a,b
	or	a, a
	jr	Z,00103$
;src/UI_GameMenu.c:158: --n;
	dec	b
;src/UI_GameMenu.c:159: ui_gamemenu_render_button(n);
	push	bc
	push	bc
	inc	sp
	call	_ui_gamemenu_render_button
	inc	sp
	pop	bc
	jr	00101$
00103$:
;src/UI_GameMenu.c:162: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	ld	(#_ui_gamemenu_lastEntry + 0),a
	ret
___str_9:
	.ascii "LEVEL "
	.db 0x00
;src/UI_GameMenu.c:165: u8 ui_gamemenu_get_entry(){
;	---------------------------------
; Function ui_gamemenu_get_entry
; ---------------------------------
_ui_gamemenu_get_entry::
;src/UI_GameMenu.c:166: return ui_gamemenu_entryIndex;
	ld	iy,#_ui_gamemenu_entryIndex
	ld	l,0 (iy)
	ret
;src/UI_GameMenu.c:169: u8 ui_gamemenu_is_selected(){
;	---------------------------------
; Function ui_gamemenu_is_selected
; ---------------------------------
_ui_gamemenu_is_selected::
;src/UI_GameMenu.c:170: return ui_gamemenu_entrySelected;
	ld	iy,#_ui_gamemenu_entrySelected
	ld	l,0 (iy)
	ret
;src/UI_GameMenu.c:173: void ui_gamemenu_update_action(){
;	---------------------------------
; Function ui_gamemenu_update_action
; ---------------------------------
_ui_gamemenu_update_action::
;src/UI_GameMenu.c:174: u8 forward = *(u8*)(MAP_MEM + (player_position.x+player_direction.x) + (player_position.y+player_direction.y) * MAP_WIDTH);
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
	ld	c,(hl)
;src/UI_GameMenu.c:177: ui_gamemenu_can_move=0;
	ld	hl,#_ui_gamemenu_can_move + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:178: *((char**)(ui_gamemenu_buttonText)+3)="";
	ld	hl,#___str_10
	ld	((_ui_gamemenu_buttonText + 0x0006)), hl
;src/UI_GameMenu.c:180: ui_gamemenu_action=0;
	ld	iy,#_ui_gamemenu_action
	ld	0 (iy),#0x00
;src/UI_GameMenu.c:181: *((char**)ui_gamemenu_buttonText)="";
	ld	(_ui_gamemenu_buttonText), hl
;src/UI_GameMenu.c:183: if(forward&CELL_ITEM_MASK){
	ld	a,c
	and	a, #0x70
	jr	Z,00102$
;src/UI_GameMenu.c:184: ui_gamemenu_action=3;
	ld	hl,#_ui_gamemenu_action + 0
	ld	(hl), #0x03
;src/UI_GameMenu.c:185: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[2];
	ld	de, (#(_ui_gamemenu_action_buttonText + 0x0004) + 0)
	ld	(_ui_gamemenu_buttonText), de
00102$:
;src/UI_GameMenu.c:187: if(forward&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00111$
;src/UI_GameMenu.c:188: if(forward==CELLTYPE_DOOR){
	ld	a,c
	sub	a, #0x80
	ret	NZ
;src/UI_GameMenu.c:189: if(player_has_key){
	ld	a,(#_player_has_key + 0)
	or	a, a
	ret	Z
;src/UI_GameMenu.c:190: ui_gamemenu_action=1;
	ld	hl,#_ui_gamemenu_action + 0
	ld	(hl), #0x01
;src/UI_GameMenu.c:191: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[0];
	ld	bc, (#_ui_gamemenu_action_buttonText + 0)
	ld	(_ui_gamemenu_buttonText), bc
	ret
00111$:
;src/UI_GameMenu.c:195: else if(forward&CELL_ENEMY_MASK){
	ld	a,c
	and	a, #0x0F
	jr	Z,00108$
;src/UI_GameMenu.c:196: ui_gamemenu_action=2;
	ld	hl,#_ui_gamemenu_action + 0
	ld	(hl), #0x02
;src/UI_GameMenu.c:197: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[1];
	ld	bc, (#(_ui_gamemenu_action_buttonText + 0x0002) + 0)
	ld	(_ui_gamemenu_buttonText), bc
	ret
00108$:
;src/UI_GameMenu.c:200: ui_gamemenu_can_move=1;
	ld	hl,#_ui_gamemenu_can_move + 0
	ld	(hl), #0x01
;src/UI_GameMenu.c:201: *(char**)(ui_gamemenu_buttonText+3)="MOVE";
	ld	hl,#___str_11
	ld	((_ui_gamemenu_buttonText + 0x0006)), hl
	ret
___str_10:
	.db 0x00
___str_11:
	.ascii "MOVE"
	.db 0x00
;src/UI_GameMenu.c:205: u8 ui_gamemenu_get_movement(){
;	---------------------------------
; Function ui_gamemenu_get_movement
; ---------------------------------
_ui_gamemenu_get_movement::
;src/UI_GameMenu.c:206: return ui_gamemenu_can_move;
	ld	iy,#_ui_gamemenu_can_move
	ld	l,0 (iy)
	ret
;src/UI_GameMenu.c:209: u8 ui_gamemenu_get_action(){
;	---------------------------------
; Function ui_gamemenu_get_action
; ---------------------------------
_ui_gamemenu_get_action::
;src/UI_GameMenu.c:210: return ui_gamemenu_action;
	ld	iy,#_ui_gamemenu_action
	ld	l,0 (iy)
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
