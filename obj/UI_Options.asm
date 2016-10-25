;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module UI_Options
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ui_options_render_button
	.globl _print_transparent_text
	.globl _cpct_drawSolidBox
	.globl _ui_options_entrySelected
	.globl _ui_options_entryIndex
	.globl _ui_options_lastEntry
	.globl _ui_options_buttonText
	.globl _ui_options_on_off
	.globl _ui_options_entriesTextPosition
	.globl _ui_options_entriesPosition
	.globl _ui_options_set_strings
	.globl _ui_options_init
	.globl _ui_options_get_entry
	.globl _ui_options_is_selected
	.globl _ui_options_next_entry
	.globl _ui_options_previous_entry
	.globl _ui_options_select_entry
	.globl _ui_options_unselect_entry
	.globl _ui_options_render_refresh
	.globl _ui_options_render_all
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_ui_options_lastEntry::
	.ds 1
_ui_options_entryIndex::
	.ds 1
_ui_options_entrySelected::
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
;src/UI_Options.c:58: void ui_options_set_strings(){
;	---------------------------------
; Function ui_options_set_strings
; ---------------------------------
_ui_options_set_strings::
;src/UI_Options.c:59: *(char**)(ui_options_buttonText)=ui_options_on_off[textures_on];
	ld	bc,#_ui_options_on_off+0
	ld	iy,#_textures_on
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	(_ui_options_buttonText), de
;src/UI_Options.c:60: *(char**)(ui_options_buttonText+1)=ui_options_on_off[music_on];
	ld	iy,#_music_on
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	add	hl,bc
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	((_ui_options_buttonText + 0x0002)), bc
	ret
_ui_options_entriesPosition:
	.dw #0xC2FB
	.dw #0xE39B
	.dw #0xC482
_ui_options_entriesTextPosition:
	.dw #0xEAFE
	.dw #0xCBEE
	.dw #0xEC84
_ui_options_on_off:
	.dw __str_0
	.dw __str_1
_ui_options_buttonText:
	.dw __str_2
	.dw __str_2
	.dw __str_3
__str_0:
	.ascii "OFF"
	.db 0x00
__str_1:
	.ascii "ON"
	.db 0x00
__str_2:
	.db 0x00
__str_3:
	.ascii "EXIT"
	.db 0x00
;src/UI_Options.c:64: void ui_options_init(){
;	---------------------------------
; Function ui_options_init
; ---------------------------------
_ui_options_init::
;src/UI_Options.c:65: ui_options_lastEntry=0;
	ld	hl,#_ui_options_lastEntry + 0
	ld	(hl), #0x00
;src/UI_Options.c:66: ui_options_entryIndex=0;
	ld	hl,#_ui_options_entryIndex + 0
	ld	(hl), #0x00
;src/UI_Options.c:67: ui_options_entrySelected=0;
	ld	hl,#_ui_options_entrySelected + 0
	ld	(hl), #0x00
;src/UI_Options.c:68: ui_options_set_strings();
	jp  _ui_options_set_strings
;src/UI_Options.c:72: u8 ui_options_get_entry(){
;	---------------------------------
; Function ui_options_get_entry
; ---------------------------------
_ui_options_get_entry::
;src/UI_Options.c:73: return ui_options_entryIndex;
	ld	iy,#_ui_options_entryIndex
	ld	l,0 (iy)
	ret
;src/UI_Options.c:76: u8 ui_options_is_selected(){
;	---------------------------------
; Function ui_options_is_selected
; ---------------------------------
_ui_options_is_selected::
;src/UI_Options.c:77: return ui_options_entrySelected;
	ld	iy,#_ui_options_entrySelected
	ld	l,0 (iy)
	ret
;src/UI_Options.c:80: void ui_options_next_entry(){
;	---------------------------------
; Function ui_options_next_entry
; ---------------------------------
_ui_options_next_entry::
;src/UI_Options.c:81: if(ui_options_entryIndex<(UI_OPTIONS_ENTRIES-1)){
;src/UI_Options.c:82: ui_options_lastEntry=ui_options_entryIndex;
	ld	a,(#_ui_options_entryIndex + 0)
	cp	a,#0x02
	ret	NC
	ld	(#_ui_options_lastEntry + 0),a
;src/UI_Options.c:83: ++ui_options_entryIndex;
	ld	hl, #_ui_options_entryIndex+0
	inc	(hl)
	ret
;src/UI_Options.c:87: void ui_options_previous_entry(){
;	---------------------------------
; Function ui_options_previous_entry
; ---------------------------------
_ui_options_previous_entry::
;src/UI_Options.c:88: if(ui_options_entryIndex>0){
	ld	a,(#_ui_options_entryIndex + 0)
	or	a, a
	ret	Z
;src/UI_Options.c:89: ui_options_lastEntry=ui_options_entryIndex;
	ld	a,(#_ui_options_entryIndex + 0)
	ld	(#_ui_options_lastEntry + 0),a
;src/UI_Options.c:90: --ui_options_entryIndex;
	ld	hl, #_ui_options_entryIndex+0
	dec	(hl)
	ret
;src/UI_Options.c:95: void ui_options_select_entry(){
;	---------------------------------
; Function ui_options_select_entry
; ---------------------------------
_ui_options_select_entry::
;src/UI_Options.c:96: ui_options_entrySelected=1;
	ld	hl,#_ui_options_entrySelected + 0
	ld	(hl), #0x01
	ret
;src/UI_Options.c:99: void ui_options_unselect_entry(){
;	---------------------------------
; Function ui_options_unselect_entry
; ---------------------------------
_ui_options_unselect_entry::
;src/UI_Options.c:100: ui_options_entrySelected=0;
	ld	hl,#_ui_options_entrySelected + 0
	ld	(hl), #0x00
	ret
;src/UI_Options.c:103: void ui_options_render_button(u8 n){
;	---------------------------------
; Function ui_options_render_button
; ---------------------------------
_ui_options_render_button::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/UI_Options.c:105: color = (n==ui_options_entryIndex)?((ui_options_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
	ld	a,4 (ix)
	ld	iy,#_ui_options_entryIndex
	sub	a, 0 (iy)
	jr	NZ,00103$
	ld	a,(#_ui_options_entrySelected + 0)
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
;src/UI_Options.c:106: cpct_drawSolidBox(ui_options_entriesPosition[n],color, UI_OPTIONS_BUTTON_WIDTH, UI_OPTIONS_BUTTON_HEIGHT);
	ld	l,4 (ix)
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl,#_ui_options_entriesPosition
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
;src/UI_Options.c:107: print_transparent_text(ui_options_buttonText[n], ui_options_entriesTextPosition[n], 3);
	ld	hl,#_ui_options_entriesTextPosition
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#_ui_options_buttonText
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
;src/UI_Options.c:111: void ui_options_render_refresh(){
;	---------------------------------
; Function ui_options_render_refresh
; ---------------------------------
_ui_options_render_refresh::
;src/UI_Options.c:113: ui_options_render_button(ui_options_entryIndex);
	ld	a,(_ui_options_entryIndex)
	push	af
	inc	sp
	call	_ui_options_render_button
	inc	sp
;src/UI_Options.c:114: ui_options_render_button(ui_options_lastEntry);
	ld	a,(_ui_options_lastEntry)
	push	af
	inc	sp
	call	_ui_options_render_button
	inc	sp
;src/UI_Options.c:116: ui_options_lastEntry=ui_options_entryIndex;
	ld	a,(#_ui_options_entryIndex + 0)
	ld	(#_ui_options_lastEntry + 0),a
	ret
;src/UI_Options.c:119: void ui_options_render_all(){
;	---------------------------------
; Function ui_options_render_all
; ---------------------------------
_ui_options_render_all::
;src/UI_Options.c:122: print_transparent_text("TEXTURES", UI_OPTIONS_BUTTON_TEXT_LABEL_POSITION, 3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xEAEA
	push	hl
	ld	hl,#___str_4
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/UI_Options.c:123: print_transparent_text("MUSIC", UI_OPTIONS_BUTTON_MUSIC_LABEL_POSITION, 3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xCBDA
	push	hl
	ld	hl,#___str_5
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/UI_Options.c:125: while(n){
	ld	b,#0x03
00101$:
	ld	a,b
	or	a, a
	jr	Z,00103$
;src/UI_Options.c:126: --n;
	dec	b
;src/UI_Options.c:127: ui_options_render_button(n);
	push	bc
	push	bc
	inc	sp
	call	_ui_options_render_button
	inc	sp
	pop	bc
	jr	00101$
00103$:
;src/UI_Options.c:130: ui_options_lastEntry=ui_options_entryIndex;
	ld	a,(#_ui_options_entryIndex + 0)
	ld	(#_ui_options_lastEntry + 0),a
	ret
___str_4:
	.ascii "TEXTURES"
	.db 0x00
___str_5:
	.ascii "MUSIC"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
