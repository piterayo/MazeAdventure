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
;src/UI_MainMenu.c:55: void ui_mainmenu_init(){
;	---------------------------------
; Function ui_mainmenu_init
; ---------------------------------
_ui_mainmenu_init::
;src/UI_MainMenu.c:56: ui_mainmenu_lastEntry=0;
	ld	hl,#_ui_mainmenu_lastEntry + 0
	ld	(hl), #0x00
;src/UI_MainMenu.c:57: ui_mainmenu_entryIndex=0;
	ld	hl,#_ui_mainmenu_entryIndex + 0
	ld	(hl), #0x00
;src/UI_MainMenu.c:58: ui_mainmenu_entrySelected=0;
	ld	hl,#_ui_mainmenu_entrySelected + 0
	ld	(hl), #0x00
	ret
_ui_mainmenu_entriesPosition:
	.dw #0xC42E
	.dw #0xE4CE
	.dw #0xC5BE
	.dw #0xE65E
	.dw #0xC74E
_ui_mainmenu_entriesTextPosition:
	.dw #0xEC30
	.dw #0xCD1F
	.dw #0xEDC1
	.dw #0xCEB1
	.dw #0xEF54
_ui_mainmenu_buttonText:
	.dw __str_0
	.dw __str_1
	.dw __str_2
	.dw __str_3
	.dw __str_4
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
;src/UI_MainMenu.c:61: void ui_mainmenu_next_entry(){
;	---------------------------------
; Function ui_mainmenu_next_entry
; ---------------------------------
_ui_mainmenu_next_entry::
;src/UI_MainMenu.c:62: if(ui_mainmenu_entryIndex<(UI_MAINMENU_ENTRIES-1)){
;src/UI_MainMenu.c:63: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	cp	a,#0x04
	ret	NC
	ld	(#_ui_mainmenu_lastEntry + 0),a
;src/UI_MainMenu.c:64: ++ui_mainmenu_entryIndex;
	ld	hl, #_ui_mainmenu_entryIndex+0
	inc	(hl)
	ret
;src/UI_MainMenu.c:68: void ui_mainmenu_previous_entry(){
;	---------------------------------
; Function ui_mainmenu_previous_entry
; ---------------------------------
_ui_mainmenu_previous_entry::
;src/UI_MainMenu.c:69: if(ui_mainmenu_entryIndex>0){
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	or	a, a
	ret	Z
;src/UI_MainMenu.c:70: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	ld	(#_ui_mainmenu_lastEntry + 0),a
;src/UI_MainMenu.c:71: --ui_mainmenu_entryIndex;
	ld	hl, #_ui_mainmenu_entryIndex+0
	dec	(hl)
	ret
;src/UI_MainMenu.c:75: void ui_mainmenu_unselect_entry(){
;	---------------------------------
; Function ui_mainmenu_unselect_entry
; ---------------------------------
_ui_mainmenu_unselect_entry::
;src/UI_MainMenu.c:76: ui_mainmenu_entrySelected=0;
	ld	hl,#_ui_mainmenu_entrySelected + 0
	ld	(hl), #0x00
	ret
;src/UI_MainMenu.c:79: void ui_mainmenu_select_entry(){
;	---------------------------------
; Function ui_mainmenu_select_entry
; ---------------------------------
_ui_mainmenu_select_entry::
;src/UI_MainMenu.c:80: ui_mainmenu_entrySelected=1;
	ld	hl,#_ui_mainmenu_entrySelected + 0
	ld	(hl), #0x01
	ret
;src/UI_MainMenu.c:83: void ui_mainmenu_render_button(u8 n){
;	---------------------------------
; Function ui_mainmenu_render_button
; ---------------------------------
_ui_mainmenu_render_button::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/UI_MainMenu.c:85: color = (n==ui_mainmenu_entryIndex)?((ui_mainmenu_entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
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
	ld	a, (#(_g_colors + 0x0005) + 0)
	jr	00104$
00103$:
	ld	a, (#(_g_colors + 0x0002) + 0)
00104$:
	ld	b,a
;src/UI_MainMenu.c:86: cpct_drawSolidBox(ui_mainmenu_entriesPosition[n],color, UI_MAINMENU_BUTTON_WIDTH, UI_MAINMENU_BUTTON_HEIGHT);
	ld	l,4 (ix)
	ld	h,#0x00
	add	hl, hl
	ex	de,hl
	ld	hl,#_ui_mainmenu_entriesPosition
	add	hl,de
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	pop	iy
	push	de
	ld	hl,#0x1014
	push	hl
	push	bc
	inc	sp
	push	iy
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
	pop	de
;src/UI_MainMenu.c:87: print_transparent_text(ui_mainmenu_buttonText[n], ui_mainmenu_entriesTextPosition[n], 3);
	ld	hl,#_ui_mainmenu_entriesTextPosition
	add	hl,de
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
	pop	ix
	ret
;src/UI_MainMenu.c:90: void ui_mainmenu_render_refresh(){
;	---------------------------------
; Function ui_mainmenu_render_refresh
; ---------------------------------
_ui_mainmenu_render_refresh::
;src/UI_MainMenu.c:92: ui_mainmenu_render_button(ui_mainmenu_entryIndex);
	ld	a,(_ui_mainmenu_entryIndex)
	push	af
	inc	sp
	call	_ui_mainmenu_render_button
	inc	sp
;src/UI_MainMenu.c:93: ui_mainmenu_render_button(ui_mainmenu_lastEntry);
	ld	a,(_ui_mainmenu_lastEntry)
	push	af
	inc	sp
	call	_ui_mainmenu_render_button
	inc	sp
;src/UI_MainMenu.c:95: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	ld	(#_ui_mainmenu_lastEntry + 0),a
	ret
;src/UI_MainMenu.c:99: void ui_mainmenu_render_all(){
;	---------------------------------
; Function ui_mainmenu_render_all
; ---------------------------------
_ui_mainmenu_render_all::
;src/UI_MainMenu.c:103: while(n){
	ld	b,#0x05
00101$:
	ld	a,b
	or	a, a
	jr	Z,00103$
;src/UI_MainMenu.c:104: --n;
	dec	b
;src/UI_MainMenu.c:105: ui_mainmenu_render_button(n);
	push	bc
	push	bc
	inc	sp
	call	_ui_mainmenu_render_button
	inc	sp
	pop	bc
	jr	00101$
00103$:
;src/UI_MainMenu.c:108: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
	ld	a,(#_ui_mainmenu_entryIndex + 0)
	ld	(#_ui_mainmenu_lastEntry + 0),a
	ret
;src/UI_MainMenu.c:111: u8 ui_mainmenu_get_entry(){
;	---------------------------------
; Function ui_mainmenu_get_entry
; ---------------------------------
_ui_mainmenu_get_entry::
;src/UI_MainMenu.c:112: return ui_mainmenu_entryIndex;
	ld	iy,#_ui_mainmenu_entryIndex
	ld	l,0 (iy)
	ret
;src/UI_MainMenu.c:115: u8 ui_mainmenu_is_selected(){
;	---------------------------------
; Function ui_mainmenu_is_selected
; ---------------------------------
_ui_mainmenu_is_selected::
;src/UI_MainMenu.c:116: return ui_mainmenu_entrySelected;
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
