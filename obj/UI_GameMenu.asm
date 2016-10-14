;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module UI_GameMenu
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _print_transparent_text
	.globl _cpct_drawSolidBox
	.globl _ui_gamemenu_action
	.globl _ui_gamemenu_entrySelected
	.globl _ui_gamemenu_entryIndex
	.globl _ui_gamemenu_lastEntry
	.globl _ui_gamemenu_buttonWidths
	.globl _ui_gamemenu_buttonText
	.globl _ui_gamemenu_action_buttonText
	.globl _ui_gamemenu_entriesPosition
	.globl _ui_gamemenu_init
	.globl _ui_gamemenu_next_entry
	.globl _ui_gamemenu_previous_entry
	.globl _ui_gamemenu_unselect_entry
	.globl _ui_gamemenu_select_entry
	.globl _ui_gamemenu_render_refresh
	.globl _ui_gamemenu_render_all
	.globl _ui_gamemenu_get_entry
	.globl _ui_gamemenu_is_selected
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
;src/UI_GameMenu.c:44: void ui_gamemenu_init(){
;	---------------------------------
; Function ui_gamemenu_init
; ---------------------------------
_ui_gamemenu_init::
;src/UI_GameMenu.c:45: ui_gamemenu_lastEntry=0;
	ld	hl,#_ui_gamemenu_lastEntry + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:46: ui_gamemenu_entryIndex=0;
	ld	hl,#_ui_gamemenu_entryIndex + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:47: ui_gamemenu_entrySelected=0;
	ld	hl,#_ui_gamemenu_entrySelected + 0
	ld	(hl), #0x00
	ret
_ui_gamemenu_entriesPosition:
	.dw #0xC550
	.dw #0xC6E3
	.dw #0xC566
	.dw #0xC584
	.dw #0xC593
	.dw #0xC723
_ui_gamemenu_action_buttonText:
	.dw __str_0
	.dw __str_1
	.dw __str_2
_ui_gamemenu_buttonText:
	.dw __str_3
	.dw __str_4
	.dw __str_5
	.dw __str_6
	.dw __str_7
	.dw __str_8
_ui_gamemenu_buttonWidths:
	.db #0x06	; 6
	.db #0x16	; 22
	.db #0x06	; 6
	.db #0x0D	; 13
	.db #0x0D	; 13
	.db #0x0D	; 13
__str_0:
	.ascii "PICK UP"
	.db 0x00
__str_1:
	.ascii "ATTACK"
	.db 0x00
__str_2:
	.ascii "NEXT LEVEL"
	.db 0x00
__str_3:
	.ascii "<"
	.db 0x00
__str_4:
	.ascii "MOVE"
	.db 0x00
__str_5:
	.ascii ">"
	.db 0x00
__str_6:
	.db 0x00
__str_7:
	.ascii "INV"
	.db 0x00
__str_8:
	.ascii "PAUSE"
	.db 0x00
;src/UI_GameMenu.c:50: void ui_gamemenu_next_entry(){
;	---------------------------------
; Function ui_gamemenu_next_entry
; ---------------------------------
_ui_gamemenu_next_entry::
;src/UI_GameMenu.c:51: if(ui_gamemenu_entryIndex<(UI_GAMEMENU_ENTRIES-1)){
;src/UI_GameMenu.c:52: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	cp	a,#0x05
	ret	NC
	ld	(#_ui_gamemenu_lastEntry + 0),a
;src/UI_GameMenu.c:53: ++ui_gamemenu_entryIndex;
	ld	hl, #_ui_gamemenu_entryIndex+0
	inc	(hl)
	ret
;src/UI_GameMenu.c:57: void ui_gamemenu_previous_entry(){
;	---------------------------------
; Function ui_gamemenu_previous_entry
; ---------------------------------
_ui_gamemenu_previous_entry::
;src/UI_GameMenu.c:58: if(ui_gamemenu_entryIndex>0){
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	or	a, a
	ret	Z
;src/UI_GameMenu.c:59: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	ld	(#_ui_gamemenu_lastEntry + 0),a
;src/UI_GameMenu.c:60: --ui_gamemenu_entryIndex;
	ld	hl, #_ui_gamemenu_entryIndex+0
	dec	(hl)
	ret
;src/UI_GameMenu.c:64: void ui_gamemenu_unselect_entry(){
;	---------------------------------
; Function ui_gamemenu_unselect_entry
; ---------------------------------
_ui_gamemenu_unselect_entry::
;src/UI_GameMenu.c:65: ui_gamemenu_entrySelected=0;
	ld	hl,#_ui_gamemenu_entrySelected + 0
	ld	(hl), #0x00
	ret
;src/UI_GameMenu.c:68: void ui_gamemenu_select_entry(){
;	---------------------------------
; Function ui_gamemenu_select_entry
; ---------------------------------
_ui_gamemenu_select_entry::
;src/UI_GameMenu.c:69: ui_gamemenu_entrySelected=1;
	ld	hl,#_ui_gamemenu_entrySelected + 0
	ld	(hl), #0x01
	ret
;src/UI_GameMenu.c:73: void ui_gamemenu_render_refresh(){
;	---------------------------------
; Function ui_gamemenu_render_refresh
; ---------------------------------
_ui_gamemenu_render_refresh::
;src/UI_GameMenu.c:76: color = (ui_gamemenu_entrySelected)? g_colors[4]: g_colors[5];
	ld	a,(#_ui_gamemenu_entrySelected + 0)
	or	a, a
	jr	Z,00105$
	ld	a, (#(_g_colors + 0x0004) + 0)
	jr	00106$
00105$:
	ld	a, (#(_g_colors + 0x0005) + 0)
00106$:
	ld	c,a
;src/UI_GameMenu.c:77: cpct_drawSolidBox(ui_gamemenu_entriesPosition[ui_gamemenu_entryIndex],color, ui_gamemenu_buttonWidths[ui_gamemenu_entryIndex], UI_GAMEMENU_BUTTON_HEIGHT);
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	add	a, #<(_ui_gamemenu_buttonWidths)
	ld	e,a
	ld	a,#0x00
	adc	a, #>(_ui_gamemenu_buttonWidths)
	ld	d,a
	ld	a,(de)
	ld	b,a
	ld	iy,#_ui_gamemenu_entryIndex
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	ld	de,#_ui_gamemenu_entriesPosition
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x18
	push	af
	inc	sp
	push	bc
	push	de
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/UI_GameMenu.c:78: print_transparent_text(ui_gamemenu_buttonText[ui_gamemenu_entryIndex], ui_gamemenu_entriesPosition[ui_gamemenu_entryIndex], 3);
	ld	iy,#_ui_gamemenu_entryIndex
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl,#_ui_gamemenu_entriesPosition
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#_ui_gamemenu_buttonText
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
;src/UI_GameMenu.c:80: if(ui_gamemenu_lastEntry!=ui_gamemenu_entryIndex){
	ld	a,(#_ui_gamemenu_lastEntry + 0)
	ld	iy,#_ui_gamemenu_entryIndex
	sub	a, 0 (iy)
	ret	Z
;src/UI_GameMenu.c:81: color = g_colors[2];
	ld	hl,#_g_colors+2
	ld	e,(hl)
;src/UI_GameMenu.c:82: cpct_drawSolidBox(ui_gamemenu_entriesPosition[ui_gamemenu_lastEntry],color, ui_gamemenu_buttonWidths[ui_gamemenu_lastEntry], UI_GAMEMENU_BUTTON_HEIGHT);
	ld	a,#<(_ui_gamemenu_buttonWidths)
	ld	hl,#_ui_gamemenu_lastEntry
	add	a, (hl)
	ld	c,a
	ld	a,#>(_ui_gamemenu_buttonWidths)
	adc	a, #0x00
	ld	b,a
	ld	a,(bc)
	ld	d,a
	ld	iy,#_ui_gamemenu_lastEntry
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	ld	bc,#_ui_gamemenu_entriesPosition
	add	hl,bc
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,#0x18
	push	af
	inc	sp
	push	de
	push	bc
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/UI_GameMenu.c:83: print_transparent_text(ui_gamemenu_buttonText[ui_gamemenu_lastEntry], ui_gamemenu_entriesPosition[ui_gamemenu_lastEntry], 3);
	ld	iy,#_ui_gamemenu_lastEntry
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl,#_ui_gamemenu_entriesPosition
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#_ui_gamemenu_buttonText
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
;src/UI_GameMenu.c:84: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	ld	(#_ui_gamemenu_lastEntry + 0),a
	ret
;src/UI_GameMenu.c:89: void ui_gamemenu_render_all(){
;	---------------------------------
; Function ui_gamemenu_render_all
; ---------------------------------
_ui_gamemenu_render_all::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;src/UI_GameMenu.c:93: while(n){
	ld	-3 (ix),#0x06
00101$:
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00103$
;src/UI_GameMenu.c:94: --n;
	dec	-3 (ix)
;src/UI_GameMenu.c:95: color = (n==ui_gamemenu_entryIndex)?((ui_gamemenu_entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	sub	a, -3 (ix)
	jr	NZ,00106$
	ld	a,(#_ui_gamemenu_entrySelected + 0)
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
;src/UI_GameMenu.c:96: cpct_drawSolidBox(ui_gamemenu_entriesPosition[n],color, ui_gamemenu_buttonWidths[n], UI_GAMEMENU_BUTTON_HEIGHT);
	ld	a,#<(_ui_gamemenu_buttonWidths)
	add	a, -3 (ix)
	ld	l,a
	ld	a,#>(_ui_gamemenu_buttonWidths)
	adc	a, #0x00
	ld	h,a
	ld	b,(hl)
	ld	l,-3 (ix)
	ld	h,#0x00
	add	hl, hl
	ex	de,hl
	ld	hl,#_ui_gamemenu_entriesPosition
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
;src/UI_GameMenu.c:97: print_transparent_text(ui_gamemenu_buttonText[n], ui_gamemenu_entriesPosition[n], 3);
	ld	l,-2 (ix)
	ld	h,-1 (ix)
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
	jp	00101$
00103$:
;src/UI_GameMenu.c:100: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
	ld	a,(#_ui_gamemenu_entryIndex + 0)
	ld	(#_ui_gamemenu_lastEntry + 0),a
	ld	sp, ix
	pop	ix
	ret
;src/UI_GameMenu.c:103: u8 ui_gamemenu_get_entry(){
;	---------------------------------
; Function ui_gamemenu_get_entry
; ---------------------------------
_ui_gamemenu_get_entry::
;src/UI_GameMenu.c:104: return ui_gamemenu_entryIndex;
	ld	iy,#_ui_gamemenu_entryIndex
	ld	l,0 (iy)
	ret
;src/UI_GameMenu.c:107: u8 ui_gamemenu_is_selected(){
;	---------------------------------
; Function ui_gamemenu_is_selected
; ---------------------------------
_ui_gamemenu_is_selected::
;src/UI_GameMenu.c:108: return ui_gamemenu_entrySelected;
	ld	iy,#_ui_gamemenu_entrySelected
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
__xinit__ui_gamemenu_action:
	.db #0x00	; 0
	.area _CABS (ABS)
