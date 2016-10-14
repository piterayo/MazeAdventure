;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module UI_MainMenu
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _print_transparent_text
	.globl _cpct_drawSolidBox
	.globl _ui_mainmenu_entrySelected
	.globl _ui_mainmenu_entryIndex
	.globl _ui_mainmenu_lastEntry
	.globl _ui_mainmenu_buttonWidths
	.globl _ui_mainmenu_buttonText
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
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_ui_mainmenu_lastEntry::
	.ds 1
_ui_mainmenu_entryIndex::
	.ds 1
_ui_mainmenu_entrySelected::
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
;src/UI_MainMenu.c:35: void ui_mainmenu_init(){
;	---------------------------------
; Function ui_mainmenu_init
; ---------------------------------
_ui_mainmenu_init::
;src/UI_MainMenu.c:36: ui_mainmenu_lastEntry=0;
	ld	hl,#_ui_mainmenu_lastEntry + 0
	ld	(hl), #0x00
;src/UI_MainMenu.c:37: ui_mainmenu_entryIndex=0;
	ld	hl,#_ui_mainmenu_entryIndex + 0
	ld	(hl), #0x00
;src/UI_MainMenu.c:38: ui_mainmenu_entrySelected=0;
	ld	hl,#_ui_mainmenu_entrySelected + 0
	ld	(hl), #0x00
	ret
_ui_mainmenu_entriesPosition:
	.dw #0xC410
	.dw #0xE4B0
	.dw #0xC5A0
	.dw #0xE640
	.dw #0xC730
_ui_mainmenu_buttonText:
	.dw __str_0
	.dw __str_1
	.dw __str_2
	.dw __str_3
	.dw __str_4
_ui_mainmenu_buttonWidths:
	.db #0x14	; 20
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
__str_4:
	.ascii "EXIT"
	.db 0x00
;src/UI_MainMenu.c:41: void ui_mainmenu_next_entry(){
;	---------------------------------
; Function ui_mainmenu_next_entry
; ---------------------------------
_ui_mainmenu_next_entry::
;src/UI_MainMenu.c:42: if(ui_mainmenu_entryIndex<(UI_MAINMENU_ENTRIES-1)){
;src/UI_MainMenu.c:43: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	cp	a,#0x04
	ret	NC
	ld	(#_ui_mainmenu_lastEntry + 0),a
;src/UI_MainMenu.c:44: ++ui_mainmenu_entryIndex;
	ld	hl, #_ui_mainmenu_entryIndex+0
	inc	(hl)
	ret
;src/UI_MainMenu.c:48: void ui_mainmenu_previous_entry(){
;	---------------------------------
; Function ui_mainmenu_previous_entry
; ---------------------------------
_ui_mainmenu_previous_entry::
;src/UI_MainMenu.c:49: if(ui_mainmenu_entryIndex>0){
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	or	a, a
	ret	Z
;src/UI_MainMenu.c:50: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	ld	(#_ui_mainmenu_lastEntry + 0),a
;src/UI_MainMenu.c:51: --ui_mainmenu_entryIndex;
	ld	hl, #_ui_mainmenu_entryIndex+0
	dec	(hl)
	ret
;src/UI_MainMenu.c:55: void ui_mainmenu_unselect_entry(){
;	---------------------------------
; Function ui_mainmenu_unselect_entry
; ---------------------------------
_ui_mainmenu_unselect_entry::
;src/UI_MainMenu.c:56: ui_mainmenu_entrySelected=0;
	ld	hl,#_ui_mainmenu_entrySelected + 0
	ld	(hl), #0x00
	ret
;src/UI_MainMenu.c:59: void ui_mainmenu_select_entry(){
;	---------------------------------
; Function ui_mainmenu_select_entry
; ---------------------------------
_ui_mainmenu_select_entry::
;src/UI_MainMenu.c:60: ui_mainmenu_entrySelected=1;
	ld	hl,#_ui_mainmenu_entrySelected + 0
	ld	(hl), #0x01
	ret
;src/UI_MainMenu.c:64: void ui_mainmenu_render_refresh(){
;	---------------------------------
; Function ui_mainmenu_render_refresh
; ---------------------------------
_ui_mainmenu_render_refresh::
;src/UI_MainMenu.c:67: color = (ui_mainmenu_entrySelected)? g_colors[4]: g_colors[5];
	ld	a,(#_ui_mainmenu_entrySelected + 0)
	or	a, a
	jr	Z,00105$
	ld	a, (#(_g_colors + 0x0004) + 0)
	jr	00106$
00105$:
	ld	a, (#(_g_colors + 0x0005) + 0)
00106$:
	ld	e,a
;src/UI_MainMenu.c:68: cpct_drawSolidBox(ui_mainmenu_entriesPosition[ui_mainmenu_entryIndex],color, ui_mainmenu_buttonWidths, UI_MAINMENU_BUTTON_HEIGHT);
	ld	hl,#_ui_mainmenu_buttonWidths + 0
	ld	d, (hl)
	ld	iy,#_ui_mainmenu_entryIndex
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	ld	bc,#_ui_mainmenu_entriesPosition
	add	hl,bc
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,#0x10
	push	af
	inc	sp
	push	de
	push	bc
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/UI_MainMenu.c:69: print_transparent_text(ui_mainmenu_buttonText[ui_mainmenu_entryIndex], ui_mainmenu_entriesPosition[ui_mainmenu_entryIndex], 3);
	ld	iy,#_ui_mainmenu_entryIndex
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl,#_ui_mainmenu_entriesPosition
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
;src/UI_MainMenu.c:71: if(ui_mainmenu_lastEntry!=ui_mainmenu_entryIndex){
	ld	a,(#_ui_mainmenu_lastEntry + 0)
	ld	iy,#_ui_mainmenu_entryIndex
	sub	a, 0 (iy)
	ret	Z
;src/UI_MainMenu.c:72: color = g_colors[2];
	ld	hl,#_g_colors+2
	ld	e,(hl)
;src/UI_MainMenu.c:73: cpct_drawSolidBox(ui_mainmenu_entriesPosition[ui_mainmenu_lastEntry],color, ui_mainmenu_buttonWidths, UI_MAINMENU_BUTTON_HEIGHT);
	ld	hl,#_ui_mainmenu_buttonWidths + 0
	ld	d, (hl)
	ld	iy,#_ui_mainmenu_lastEntry
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	ld	bc,#_ui_mainmenu_entriesPosition
	add	hl,bc
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,#0x10
	push	af
	inc	sp
	push	de
	push	bc
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/UI_MainMenu.c:74: print_transparent_text(ui_mainmenu_buttonText[ui_mainmenu_lastEntry], ui_mainmenu_entriesPosition[ui_mainmenu_lastEntry], 3);
	ld	iy,#_ui_mainmenu_lastEntry
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl,#_ui_mainmenu_entriesPosition
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
;src/UI_MainMenu.c:75: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	ld	(#_ui_mainmenu_lastEntry + 0),a
	ret
;src/UI_MainMenu.c:82: void ui_mainmenu_render_all(){
;	---------------------------------
; Function ui_mainmenu_render_all
; ---------------------------------
_ui_mainmenu_render_all::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;src/UI_MainMenu.c:86: while(n){
	ld	-3 (ix),#0x05
00101$:
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00103$
;src/UI_MainMenu.c:87: --n;
	dec	-3 (ix)
;src/UI_MainMenu.c:88: color = (n==ui_mainmenu_entryIndex)?((ui_mainmenu_entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	sub	a, -3 (ix)
	jr	NZ,00106$
	ld	a,(#_ui_mainmenu_entrySelected + 0)
	or	a, a
	jr	Z,00108$
	ld	a, (#_g_colors + 4)
	jr	00107$
00108$:
	ld	a, (#_g_colors + 5)
	jr	00107$
00106$:
	ld	a, (#_g_colors + 2)
00107$:
	ld	c,a
;src/UI_MainMenu.c:89: cpct_drawSolidBox(ui_mainmenu_entriesPosition[n],color, ui_mainmenu_buttonWidths, UI_MAINMENU_BUTTON_HEIGHT);
	ld	hl,#_ui_mainmenu_buttonWidths + 0
	ld	b, (hl)
	ld	l,-3 (ix)
	ld	h,#0x00
	add	hl, hl
	ex	de,hl
	ld	hl,#_ui_mainmenu_entriesPosition
	add	hl,de
	ld	-2 (ix),l
	ld	-1 (ix),h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	pop	iy
	push	de
	ld	a,#0x10
	push	af
	inc	sp
	push	bc
	push	iy
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
	pop	de
;src/UI_MainMenu.c:90: print_transparent_text(ui_mainmenu_buttonText[n], ui_mainmenu_entriesPosition[n], 3);
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	hl,#_ui_mainmenu_buttonText
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
	jr	00101$
00103$:
;src/UI_MainMenu.c:93: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	ld	(#_ui_mainmenu_lastEntry + 0),a
	ld	sp, ix
	pop	ix
	ret
;src/UI_MainMenu.c:96: u8 ui_mainmenu_get_entry(){
;	---------------------------------
; Function ui_mainmenu_get_entry
; ---------------------------------
_ui_mainmenu_get_entry::
;src/UI_MainMenu.c:97: return ui_mainmenu_entryIndex;
	ld	iy,#_ui_mainmenu_entryIndex
	ld	l,0 (iy)
	ret
;src/UI_MainMenu.c:100: u8 ui_mainmenu_is_selected(){
;	---------------------------------
; Function ui_mainmenu_is_selected
; ---------------------------------
_ui_mainmenu_is_selected::
;src/UI_MainMenu.c:101: return ui_mainmenu_entrySelected;
	ld	iy,#_ui_mainmenu_entrySelected
	ld	l,0 (iy)
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__ui_mainmenu_lastEntry:
	.db #0x00	; 0
__xinit__ui_mainmenu_entryIndex:
	.db #0x00	; 0
__xinit__ui_mainmenu_entrySelected:
	.db #0x00	; 0
	.area _CABS (ABS)
