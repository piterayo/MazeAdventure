;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module UI_PauseMenu
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ui_pausemenu_render_button
	.globl _print_transparent_text
	.globl _cpct_drawSolidBox
	.globl _ui_pausemenu_entrySelected
	.globl _ui_pausemenu_entryIndex
	.globl _ui_pausemenu_lastEntry
	.globl _ui_pausemenu_buttonText
	.globl _ui_pausemenu_entriesTextPosition
	.globl _ui_pausemenu_entriesPosition
	.globl _ui_pausemenu_init
	.globl _ui_pausemenu_get_entry
	.globl _ui_pausemenu_is_selected
	.globl _ui_pausemenu_next_entry
	.globl _ui_pausemenu_previous_entry
	.globl _ui_pausemenu_select_entry
	.globl _ui_pausemenu_unselect_entry
	.globl _ui_pausemenu_render_refresh
	.globl _ui_pausemenu_render_all
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_ui_pausemenu_lastEntry::
	.ds 1
_ui_pausemenu_entryIndex::
	.ds 1
_ui_pausemenu_entrySelected::
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
;src/UI_PauseMenu.c:55: void ui_pausemenu_init(){
;	---------------------------------
; Function ui_pausemenu_init
; ---------------------------------
_ui_pausemenu_init::
;src/UI_PauseMenu.c:56: ui_pausemenu_lastEntry=0;
	ld	hl,#_ui_pausemenu_lastEntry + 0
	ld	(hl), #0x00
;src/UI_PauseMenu.c:57: ui_pausemenu_entryIndex=0;
	ld	hl,#_ui_pausemenu_entryIndex + 0
	ld	(hl), #0x00
;src/UI_PauseMenu.c:58: ui_pausemenu_entrySelected=0;
	ld	hl,#_ui_pausemenu_entrySelected + 0
	ld	(hl), #0x00
	ret
_ui_pausemenu_entriesPosition:
	.dw #0xC1AA
	.dw #0xC2EA
	.dw #0xC42A
	.dw #0xC56A
_ui_pausemenu_entriesTextPosition:
	.dw #0xCA00
	.dw #0xCB42
	.dw #0xCC7B
	.dw #0xCDC4
_ui_pausemenu_buttonText:
	.dw __str_0
	.dw __str_1
	.dw __str_2
	.dw __str_3
__str_0:
	.ascii "CONTINUE"
	.db 0x00
__str_1:
	.ascii "OPTIONS"
	.db 0x00
__str_2:
	.ascii "SAVE AND EXIT"
	.db 0x00
__str_3:
	.ascii "EXIT"
	.db 0x00
;src/UI_PauseMenu.c:61: u8 ui_pausemenu_get_entry(){
;	---------------------------------
; Function ui_pausemenu_get_entry
; ---------------------------------
_ui_pausemenu_get_entry::
;src/UI_PauseMenu.c:62: return ui_pausemenu_entryIndex;
	ld	iy,#_ui_pausemenu_entryIndex
	ld	l,0 (iy)
	ret
;src/UI_PauseMenu.c:65: u8 ui_pausemenu_is_selected(){
;	---------------------------------
; Function ui_pausemenu_is_selected
; ---------------------------------
_ui_pausemenu_is_selected::
;src/UI_PauseMenu.c:66: return ui_pausemenu_entrySelected;
	ld	iy,#_ui_pausemenu_entrySelected
	ld	l,0 (iy)
	ret
;src/UI_PauseMenu.c:69: void ui_pausemenu_next_entry(){
;	---------------------------------
; Function ui_pausemenu_next_entry
; ---------------------------------
_ui_pausemenu_next_entry::
;src/UI_PauseMenu.c:70: if(ui_pausemenu_entryIndex<(UI_PAUSEMENU_ENTRIES-1)){
;src/UI_PauseMenu.c:71: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
	ld	a,(#_ui_pausemenu_entryIndex + 0)
	cp	a,#0x03
	ret	NC
	ld	(#_ui_pausemenu_lastEntry + 0),a
;src/UI_PauseMenu.c:72: ++ui_pausemenu_entryIndex;
	ld	hl, #_ui_pausemenu_entryIndex+0
	inc	(hl)
	ret
;src/UI_PauseMenu.c:76: void ui_pausemenu_previous_entry(){
;	---------------------------------
; Function ui_pausemenu_previous_entry
; ---------------------------------
_ui_pausemenu_previous_entry::
;src/UI_PauseMenu.c:77: if(ui_pausemenu_entryIndex>0){
	ld	a,(#_ui_pausemenu_entryIndex + 0)
	or	a, a
	ret	Z
;src/UI_PauseMenu.c:78: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
	ld	a,(#_ui_pausemenu_entryIndex + 0)
	ld	(#_ui_pausemenu_lastEntry + 0),a
;src/UI_PauseMenu.c:79: --ui_pausemenu_entryIndex;
	ld	hl, #_ui_pausemenu_entryIndex+0
	dec	(hl)
	ret
;src/UI_PauseMenu.c:83: void ui_pausemenu_select_entry(){
;	---------------------------------
; Function ui_pausemenu_select_entry
; ---------------------------------
_ui_pausemenu_select_entry::
;src/UI_PauseMenu.c:84: ui_pausemenu_entrySelected=1;
	ld	hl,#_ui_pausemenu_entrySelected + 0
	ld	(hl), #0x01
	ret
;src/UI_PauseMenu.c:87: void ui_pausemenu_unselect_entry(){
;	---------------------------------
; Function ui_pausemenu_unselect_entry
; ---------------------------------
_ui_pausemenu_unselect_entry::
;src/UI_PauseMenu.c:88: ui_pausemenu_entrySelected=0;
	ld	hl,#_ui_pausemenu_entrySelected + 0
	ld	(hl), #0x00
	ret
;src/UI_PauseMenu.c:91: void ui_pausemenu_render_button(u8 n){
;	---------------------------------
; Function ui_pausemenu_render_button
; ---------------------------------
_ui_pausemenu_render_button::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/UI_PauseMenu.c:93: color = (n==ui_pausemenu_entryIndex)?((ui_pausemenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
	ld	a,4 (ix)
	ld	iy,#_ui_pausemenu_entryIndex
	sub	a, 0 (iy)
	jr	NZ,00103$
	ld	a,(#_ui_pausemenu_entrySelected + 0)
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
;src/UI_PauseMenu.c:94: cpct_drawSolidBox(ui_pausemenu_entriesPosition[n],color, UI_PAUSEMENU_BUTTON_WIDTH, UI_PAUSEMENU_BUTTON_HEIGHT);
	ld	l,4 (ix)
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl,#_ui_pausemenu_entriesPosition
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	bc
	ld	hl,#0x181C
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
;src/UI_PauseMenu.c:95: print_transparent_text(ui_pausemenu_buttonText[n], ui_pausemenu_entriesTextPosition[n], 3);
	ld	hl,#_ui_pausemenu_entriesTextPosition
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#_ui_pausemenu_buttonText
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
;src/UI_PauseMenu.c:98: void ui_pausemenu_render_refresh(){
;	---------------------------------
; Function ui_pausemenu_render_refresh
; ---------------------------------
_ui_pausemenu_render_refresh::
;src/UI_PauseMenu.c:100: ui_pausemenu_render_button(ui_pausemenu_entryIndex);
	ld	a,(_ui_pausemenu_entryIndex)
	push	af
	inc	sp
	call	_ui_pausemenu_render_button
	inc	sp
;src/UI_PauseMenu.c:101: ui_pausemenu_render_button(ui_pausemenu_lastEntry);
	ld	a,(_ui_pausemenu_lastEntry)
	push	af
	inc	sp
	call	_ui_pausemenu_render_button
	inc	sp
;src/UI_PauseMenu.c:103: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
	ld	a,(#_ui_pausemenu_entryIndex + 0)
	ld	(#_ui_pausemenu_lastEntry + 0),a
	ret
;src/UI_PauseMenu.c:106: void ui_pausemenu_render_all(){
;	---------------------------------
; Function ui_pausemenu_render_all
; ---------------------------------
_ui_pausemenu_render_all::
;src/UI_PauseMenu.c:110: while(n){
	ld	b,#0x04
00101$:
	ld	a,b
	or	a, a
	jr	Z,00103$
;src/UI_PauseMenu.c:111: --n;
	dec	b
;src/UI_PauseMenu.c:112: ui_pausemenu_render_button(n);
	push	bc
	push	bc
	inc	sp
	call	_ui_pausemenu_render_button
	inc	sp
	pop	bc
	jr	00101$
00103$:
;src/UI_PauseMenu.c:115: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
	ld	a,(#_ui_pausemenu_entryIndex + 0)
	ld	(#_ui_pausemenu_lastEntry + 0),a
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
