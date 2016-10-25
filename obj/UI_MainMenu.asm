;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module UI_MainMenu
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ui_mainmenu_render_button
	.globl _print_transparent_text
	.globl _cpct_drawSolidBox
	.globl _ui_mainmenu_entrySelected
	.globl _ui_mainmenu_entryIndex
	.globl _ui_mainmenu_lastEntry
	.globl _ui_mainmenu_buttonText
	.globl _ui_mainmenu_entriesTextPosition
	.globl _ui_mainmenu_entriesPosition
	.globl _ui_mainmenu_init
	.globl _ui_mainmenu_next_entry
	.globl _ui_mainmenu_previous_entry
	.globl _ui_mainmenu_unselect_entry
	.globl _ui_mainmenu_select_entry
	.globl _ui_mainmenu_render_refresh
	.globl _ui_mainmenu_render_all
	.globl _ui_mainmenu_get_entry
	.globl _ui_mainmenu_is_selected
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_ui_mainmenu_lastEntry::
	.ds 1
_ui_mainmenu_entryIndex::
	.ds 1
_ui_mainmenu_entrySelected::
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
;src/UI_MainMenu.c:53: void ui_mainmenu_init(){
;	---------------------------------
; Function ui_mainmenu_init
; ---------------------------------
_ui_mainmenu_init::
;src/UI_MainMenu.c:54: ui_mainmenu_lastEntry=0;
	ld	hl,#_ui_mainmenu_lastEntry + 0
	ld	(hl), #0x00
;src/UI_MainMenu.c:55: ui_mainmenu_entryIndex=0;
	ld	hl,#_ui_mainmenu_entryIndex + 0
	ld	(hl), #0x00
;src/UI_MainMenu.c:56: ui_mainmenu_entrySelected=0;
	ld	hl,#_ui_mainmenu_entrySelected + 0
	ld	(hl), #0x00
	ret
_ui_mainmenu_entriesPosition:
	.dw #0xE01E
	.dw #0xC10E
	.dw #0xE1AE
	.dw #0xC29E
_ui_mainmenu_entriesTextPosition:
	.dw #0xC870
	.dw #0xE90F
	.dw #0xCA01
	.dw #0xEAA1
_ui_mainmenu_buttonText:
	.dw __str_0
	.dw __str_1
	.dw __str_2
	.dw __str_3
__str_0:
	.ascii "NEW GAME"
	.db 0x00
__str_1:
	.ascii "LOAD GAME"
	.db 0x00
__str_2:
	.ascii "OPTIONS"
	.db 0x00
__str_3:
	.ascii "CREDITS"
	.db 0x00
;src/UI_MainMenu.c:59: void ui_mainmenu_next_entry(){
;	---------------------------------
; Function ui_mainmenu_next_entry
; ---------------------------------
_ui_mainmenu_next_entry::
;src/UI_MainMenu.c:60: if(ui_mainmenu_entryIndex<(UI_MAINMENU_ENTRIES-1)){
;src/UI_MainMenu.c:61: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	cp	a,#0x03
	ret	NC
	ld	(#_ui_mainmenu_lastEntry + 0),a
;src/UI_MainMenu.c:62: ++ui_mainmenu_entryIndex;
	ld	hl, #_ui_mainmenu_entryIndex+0
	inc	(hl)
	ret
;src/UI_MainMenu.c:66: void ui_mainmenu_previous_entry(){
;	---------------------------------
; Function ui_mainmenu_previous_entry
; ---------------------------------
_ui_mainmenu_previous_entry::
;src/UI_MainMenu.c:67: if(ui_mainmenu_entryIndex>0){
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	or	a, a
	ret	Z
;src/UI_MainMenu.c:68: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	ld	(#_ui_mainmenu_lastEntry + 0),a
;src/UI_MainMenu.c:69: --ui_mainmenu_entryIndex;
	ld	hl, #_ui_mainmenu_entryIndex+0
	dec	(hl)
	ret
;src/UI_MainMenu.c:73: void ui_mainmenu_unselect_entry(){
;	---------------------------------
; Function ui_mainmenu_unselect_entry
; ---------------------------------
_ui_mainmenu_unselect_entry::
;src/UI_MainMenu.c:74: ui_mainmenu_entrySelected=0;
	ld	hl,#_ui_mainmenu_entrySelected + 0
	ld	(hl), #0x00
	ret
;src/UI_MainMenu.c:77: void ui_mainmenu_select_entry(){
;	---------------------------------
; Function ui_mainmenu_select_entry
; ---------------------------------
_ui_mainmenu_select_entry::
;src/UI_MainMenu.c:78: ui_mainmenu_entrySelected=1;
	ld	hl,#_ui_mainmenu_entrySelected + 0
	ld	(hl), #0x01
	ret
;src/UI_MainMenu.c:81: void ui_mainmenu_render_button(u8 n){
;	---------------------------------
; Function ui_mainmenu_render_button
; ---------------------------------
_ui_mainmenu_render_button::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/UI_MainMenu.c:83: color = (n==ui_mainmenu_entryIndex)?((ui_mainmenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
	ld	a,4 (ix)
	ld	iy,#_ui_mainmenu_entryIndex
	sub	a, 0 (iy)
	jr	NZ,00103$
	ld	a,(#_ui_mainmenu_entrySelected + 0)
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
;src/UI_MainMenu.c:84: cpct_drawSolidBox(ui_mainmenu_entriesPosition[n],color, UI_MAINMENU_BUTTON_WIDTH, UI_MAINMENU_BUTTON_HEIGHT);
	ld	l,4 (ix)
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl,#_ui_mainmenu_entriesPosition
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	bc
	ld	hl,#0x1014
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
;src/UI_MainMenu.c:85: print_transparent_text(ui_mainmenu_buttonText[n], ui_mainmenu_entriesTextPosition[n], 3);
	ld	hl,#_ui_mainmenu_entriesTextPosition
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#_ui_mainmenu_buttonText
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
;src/UI_MainMenu.c:88: void ui_mainmenu_render_refresh(){
;	---------------------------------
; Function ui_mainmenu_render_refresh
; ---------------------------------
_ui_mainmenu_render_refresh::
;src/UI_MainMenu.c:90: ui_mainmenu_render_button(ui_mainmenu_entryIndex);
	ld	a,(_ui_mainmenu_entryIndex)
	push	af
	inc	sp
	call	_ui_mainmenu_render_button
	inc	sp
;src/UI_MainMenu.c:91: ui_mainmenu_render_button(ui_mainmenu_lastEntry);
	ld	a,(_ui_mainmenu_lastEntry)
	push	af
	inc	sp
	call	_ui_mainmenu_render_button
	inc	sp
;src/UI_MainMenu.c:93: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	ld	(#_ui_mainmenu_lastEntry + 0),a
	ret
;src/UI_MainMenu.c:97: void ui_mainmenu_render_all(){
;	---------------------------------
; Function ui_mainmenu_render_all
; ---------------------------------
_ui_mainmenu_render_all::
;src/UI_MainMenu.c:101: while(n){
	ld	b,#0x04
00101$:
	ld	a,b
	or	a, a
	jr	Z,00103$
;src/UI_MainMenu.c:102: --n;
	dec	b
;src/UI_MainMenu.c:103: ui_mainmenu_render_button(n);
	push	bc
	push	bc
	inc	sp
	call	_ui_mainmenu_render_button
	inc	sp
	pop	bc
	jr	00101$
00103$:
;src/UI_MainMenu.c:106: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	ld	(#_ui_mainmenu_lastEntry + 0),a
	ret
;src/UI_MainMenu.c:109: u8 ui_mainmenu_get_entry(){
;	---------------------------------
; Function ui_mainmenu_get_entry
; ---------------------------------
_ui_mainmenu_get_entry::
;src/UI_MainMenu.c:110: return ui_mainmenu_entryIndex;
	ld	iy,#_ui_mainmenu_entryIndex
	ld	l,0 (iy)
	ret
;src/UI_MainMenu.c:113: u8 ui_mainmenu_is_selected(){
;	---------------------------------
; Function ui_mainmenu_is_selected
; ---------------------------------
_ui_mainmenu_is_selected::
;src/UI_MainMenu.c:114: return ui_mainmenu_entrySelected;
	ld	iy,#_ui_mainmenu_entrySelected
	ld	l,0 (iy)
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
