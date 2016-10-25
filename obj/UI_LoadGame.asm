;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module UI_LoadGame
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ui_loadgame_render_button
	.globl _ui_stringinput_get_string
	.globl _print_transparent_text
	.globl _print_text
	.globl _cpct_drawSolidBox
	.globl _ui_loadgame_entrySelected
	.globl _ui_loadgame_entryIndex
	.globl _ui_loadgame_lastEntry
	.globl _ui_loadgame_buttonText
	.globl _ui_loadgame_entriesTextPosition
	.globl _ui_loadgame_entriesPosition
	.globl _ui_loadgame_init
	.globl _ui_loadgame_get_entry
	.globl _ui_loadgame_is_selected
	.globl _ui_loadgame_next_entry
	.globl _ui_loadgame_previous_entry
	.globl _ui_loadgame_select_entry
	.globl _ui_loadgame_unselect_entry
	.globl _ui_loadgame_render_all
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_ui_loadgame_lastEntry::
	.ds 1
_ui_loadgame_entryIndex::
	.ds 1
_ui_loadgame_entrySelected::
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
;src/UI_LoadGame.c:48: void ui_loadgame_init(){
;	---------------------------------
; Function ui_loadgame_init
; ---------------------------------
_ui_loadgame_init::
;src/UI_LoadGame.c:49: ui_loadgame_lastEntry=0;
	ld	hl,#_ui_loadgame_lastEntry + 0
	ld	(hl), #0x00
;src/UI_LoadGame.c:50: ui_loadgame_entryIndex=0;
	ld	hl,#_ui_loadgame_entryIndex + 0
	ld	(hl), #0x00
;src/UI_LoadGame.c:51: ui_loadgame_entrySelected=0;
	ld	hl,#_ui_loadgame_entrySelected + 0
	ld	(hl), #0x00
	ret
_ui_loadgame_entriesPosition:
	.dw #0xEBD8
	.dw #0xEBEA
_ui_loadgame_entriesTextPosition:
	.dw #0xD42A
	.dw #0xD43C
_ui_loadgame_buttonText:
	.dw __str_0
	.dw __str_1
__str_0:
	.ascii "LOAD"
	.db 0x00
__str_1:
	.ascii "EXIT"
	.db 0x00
;src/UI_LoadGame.c:55: u8 ui_loadgame_get_entry(){
;	---------------------------------
; Function ui_loadgame_get_entry
; ---------------------------------
_ui_loadgame_get_entry::
;src/UI_LoadGame.c:56: return ui_loadgame_entryIndex;
	ld	iy,#_ui_loadgame_entryIndex
	ld	l,0 (iy)
	ret
;src/UI_LoadGame.c:59: u8 ui_loadgame_is_selected(){
;	---------------------------------
; Function ui_loadgame_is_selected
; ---------------------------------
_ui_loadgame_is_selected::
;src/UI_LoadGame.c:60: return ui_loadgame_entrySelected;
	ld	iy,#_ui_loadgame_entrySelected
	ld	l,0 (iy)
	ret
;src/UI_LoadGame.c:63: void ui_loadgame_next_entry(){
;	---------------------------------
; Function ui_loadgame_next_entry
; ---------------------------------
_ui_loadgame_next_entry::
;src/UI_LoadGame.c:64: if(ui_loadgame_entryIndex<(UI_LOADGAME_ENTRIES-1)){
	ld	a,(#_ui_loadgame_entryIndex + 0)
	xor	a, #0x80
	sub	a, #0x81
	ret	NC
;src/UI_LoadGame.c:65: ui_loadgame_lastEntry=ui_loadgame_entryIndex;
	ld	a,(#_ui_loadgame_entryIndex + 0)
	ld	hl,#_ui_loadgame_lastEntry + 0
	ld	(hl), a
;src/UI_LoadGame.c:66: ++ui_loadgame_entryIndex;
	ld	hl, #_ui_loadgame_entryIndex+0
	inc	(hl)
	ret
;src/UI_LoadGame.c:70: void ui_loadgame_previous_entry(){
;	---------------------------------
; Function ui_loadgame_previous_entry
; ---------------------------------
_ui_loadgame_previous_entry::
;src/UI_LoadGame.c:71: if(ui_loadgame_entryIndex>0){
	ld	a,(#_ui_loadgame_entryIndex + 0)
	or	a, a
	ret	Z
;src/UI_LoadGame.c:72: ui_loadgame_lastEntry=ui_loadgame_entryIndex;
	ld	a,(#_ui_loadgame_entryIndex + 0)
	ld	hl,#_ui_loadgame_lastEntry + 0
	ld	(hl), a
;src/UI_LoadGame.c:73: --ui_loadgame_entryIndex;
	ld	hl, #_ui_loadgame_entryIndex+0
	dec	(hl)
	ret
;src/UI_LoadGame.c:78: void ui_loadgame_select_entry(){
;	---------------------------------
; Function ui_loadgame_select_entry
; ---------------------------------
_ui_loadgame_select_entry::
;src/UI_LoadGame.c:79: ui_loadgame_entrySelected=1;
	ld	hl,#_ui_loadgame_entrySelected + 0
	ld	(hl), #0x01
	ret
;src/UI_LoadGame.c:82: void ui_loadgame_unselect_entry(){
;	---------------------------------
; Function ui_loadgame_unselect_entry
; ---------------------------------
_ui_loadgame_unselect_entry::
;src/UI_LoadGame.c:83: ui_loadgame_entrySelected=0;
	ld	hl,#_ui_loadgame_entrySelected + 0
	ld	(hl), #0x00
	ret
;src/UI_LoadGame.c:86: void ui_loadgame_render_button(u8 n){
;	---------------------------------
; Function ui_loadgame_render_button
; ---------------------------------
_ui_loadgame_render_button::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/UI_LoadGame.c:88: color = (n==ui_loadgame_entryIndex)?((ui_loadgame_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
	ld	a,4 (ix)
	ld	iy,#_ui_loadgame_entryIndex
	sub	a, 0 (iy)
	jr	NZ,00103$
	ld	a,(#_ui_loadgame_entrySelected + 0)
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
	ld	-1 (ix),a
;src/UI_LoadGame.c:89: cpct_drawSolidBox(ui_loadgame_entriesPosition[n],color, UI_LOADGAME_BUTTON_WIDTH, UI_LOADGAME_BUTTON_HEIGHT);
	ld	l,4 (ix)
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl,#_ui_loadgame_entriesPosition
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	bc
	ld	hl,#0x100C
	push	hl
	ld	a,-1 (ix)
	push	af
	inc	sp
	push	de
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
	pop	bc
;src/UI_LoadGame.c:90: print_transparent_text(ui_loadgame_buttonText[n], ui_loadgame_entriesTextPosition[n], 3);
	ld	hl,#_ui_loadgame_entriesTextPosition
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#_ui_loadgame_buttonText
	add	hl,bc
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,#0x03
	push	af
	inc	sp
	push	de
	push	bc
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
	inc	sp
	pop	ix
	ret
;src/UI_LoadGame.c:94: void ui_loadgame_render_all(){
;	---------------------------------
; Function ui_loadgame_render_all
; ---------------------------------
_ui_loadgame_render_all::
;src/UI_LoadGame.c:97: cpct_drawSolidBox(UI_LOADGAME_STRING_POSITION, g_colors[1], 36,6);
	ld	hl, #(_g_colors + 0x0001) + 0
	ld	b,(hl)
	ld	hl,#0x0624
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xDB86
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/UI_LoadGame.c:98: print_text(ui_stringinput_get_string(),UI_LOADGAME_STRING_POSITION, 1,3);
	call	_ui_stringinput_get_string
	ld	c,l
	ld	b,h
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xDB86
	push	hl
	push	bc
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;src/UI_LoadGame.c:100: while(n){
	ld	b,#0x02
00101$:
	ld	a,b
	or	a, a
	jr	Z,00103$
;src/UI_LoadGame.c:101: --n;
	dec	b
;src/UI_LoadGame.c:102: ui_loadgame_render_button(n);
	push	bc
	push	bc
	inc	sp
	call	_ui_loadgame_render_button
	inc	sp
	pop	bc
	jr	00101$
00103$:
;src/UI_LoadGame.c:105: ui_loadgame_lastEntry=ui_loadgame_entryIndex;
	ld	a,(#_ui_loadgame_entryIndex + 0)
	ld	(#_ui_loadgame_lastEntry + 0),a
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
