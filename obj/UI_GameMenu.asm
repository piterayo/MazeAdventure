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
	.globl _entrySelected
	.globl _entryIndex
	.globl _lastEntry
	.globl _buttonWidths
	.globl _buttonText
	.globl _entriesPosition
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
_lastEntry::
	.ds 1
_entryIndex::
	.ds 1
_entrySelected::
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
;src/UI_GameMenu.c:38: void ui_gamemenu_init(){
;	---------------------------------
; Function ui_gamemenu_init
; ---------------------------------
_ui_gamemenu_init::
;src/UI_GameMenu.c:39: lastEntry=0;
	ld	hl,#_lastEntry + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:40: entryIndex=0;
	ld	hl,#_entryIndex + 0
	ld	(hl), #0x00
;src/UI_GameMenu.c:41: entrySelected=0;
	ld	hl,#_entrySelected + 0
	ld	(hl), #0x00
	ret
_entriesPosition:
	.dw #0xC550
	.dw #0xC6E3
	.dw #0xC566
	.dw #0xC584
	.dw #0xC593
	.dw #0xC723
_buttonText:
	.dw __str_0
	.dw __str_1
	.dw __str_2
	.dw __str_3
	.dw __str_4
	.dw __str_5
_buttonWidths:
	.db #0x06	; 6
	.db #0x16	; 22
	.db #0x06	; 6
	.db #0x0D	; 13
	.db #0x0D	; 13
	.db #0x0D	; 13
__str_0:
	.ascii "<"
	.db 0x00
__str_1:
	.ascii "MOVE"
	.db 0x00
__str_2:
	.ascii ">"
	.db 0x00
__str_3:
	.ascii "ATTACK"
	.db 0x00
__str_4:
	.ascii "INV"
	.db 0x00
__str_5:
	.ascii "PAUSE"
	.db 0x00
;src/UI_GameMenu.c:44: void ui_gamemenu_next_entry(){
;	---------------------------------
; Function ui_gamemenu_next_entry
; ---------------------------------
_ui_gamemenu_next_entry::
;src/UI_GameMenu.c:45: if(entryIndex<(ENTRIES-1)){
;src/UI_GameMenu.c:46: lastEntry=entryIndex;
	ld	a,(#_entryIndex + 0)
	cp	a,#0x05
	ret	NC
	ld	(#_lastEntry + 0),a
;src/UI_GameMenu.c:47: ++entryIndex;
	ld	hl, #_entryIndex+0
	inc	(hl)
	ret
;src/UI_GameMenu.c:51: void ui_gamemenu_previous_entry(){
;	---------------------------------
; Function ui_gamemenu_previous_entry
; ---------------------------------
_ui_gamemenu_previous_entry::
;src/UI_GameMenu.c:52: if(entryIndex>0){
	ld	a,(#_entryIndex + 0)
	or	a, a
	ret	Z
;src/UI_GameMenu.c:53: lastEntry=entryIndex;
	ld	a,(#_entryIndex + 0)
	ld	(#_lastEntry + 0),a
;src/UI_GameMenu.c:54: --entryIndex;
	ld	hl, #_entryIndex+0
	dec	(hl)
	ret
;src/UI_GameMenu.c:58: void ui_gamemenu_unselect_entry(){
;	---------------------------------
; Function ui_gamemenu_unselect_entry
; ---------------------------------
_ui_gamemenu_unselect_entry::
;src/UI_GameMenu.c:59: entrySelected=0;
	ld	hl,#_entrySelected + 0
	ld	(hl), #0x00
	ret
;src/UI_GameMenu.c:62: void ui_gamemenu_select_entry(){
;	---------------------------------
; Function ui_gamemenu_select_entry
; ---------------------------------
_ui_gamemenu_select_entry::
;src/UI_GameMenu.c:63: entrySelected=1;
	ld	hl,#_entrySelected + 0
	ld	(hl), #0x01
	ret
;src/UI_GameMenu.c:67: void ui_gamemenu_render_refresh(){
;	---------------------------------
; Function ui_gamemenu_render_refresh
; ---------------------------------
_ui_gamemenu_render_refresh::
;src/UI_GameMenu.c:70: color = (entrySelected)? g_colors[4]: g_colors[5];
	ld	a,(#_entrySelected + 0)
	or	a, a
	jr	Z,00105$
	ld	a, (#(_g_colors + 0x0004) + 0)
	jr	00106$
00105$:
	ld	a, (#(_g_colors + 0x0005) + 0)
00106$:
	ld	c,a
;src/UI_GameMenu.c:71: cpct_drawSolidBox(entriesPosition[entryIndex],color, buttonWidths[entryIndex], BUTTON_HEIGHT);
	ld	a,(#_entryIndex + 0)
	add	a, #<(_buttonWidths)
	ld	e,a
	ld	a,#0x00
	adc	a, #>(_buttonWidths)
	ld	d,a
	ld	a,(de)
	ld	b,a
	ld	iy,#_entryIndex
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	ld	de,#_entriesPosition
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
;src/UI_GameMenu.c:72: print_transparent_text(buttonText[entryIndex], entriesPosition[entryIndex], 3);
	ld	iy,#_entryIndex
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl,#_entriesPosition
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#_buttonText
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
;src/UI_GameMenu.c:74: if(lastEntry!=entryIndex){
	ld	a,(#_lastEntry + 0)
	ld	iy,#_entryIndex
	sub	a, 0 (iy)
	ret	Z
;src/UI_GameMenu.c:75: color = g_colors[2];
	ld	hl,#_g_colors+2
	ld	e,(hl)
;src/UI_GameMenu.c:76: cpct_drawSolidBox(entriesPosition[lastEntry],color, buttonWidths[lastEntry], BUTTON_HEIGHT);
	ld	a,#<(_buttonWidths)
	ld	hl,#_lastEntry
	add	a, (hl)
	ld	c,a
	ld	a,#>(_buttonWidths)
	adc	a, #0x00
	ld	b,a
	ld	a,(bc)
	ld	d,a
	ld	iy,#_lastEntry
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	ld	bc,#_entriesPosition
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
;src/UI_GameMenu.c:77: print_transparent_text(buttonText[lastEntry], entriesPosition[lastEntry], 3);
	ld	iy,#_lastEntry
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl,#_entriesPosition
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#_buttonText
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
	ret
;src/UI_GameMenu.c:82: void ui_gamemenu_render_all(){
;	---------------------------------
; Function ui_gamemenu_render_all
; ---------------------------------
_ui_gamemenu_render_all::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;src/UI_GameMenu.c:86: while(n){
	ld	-3 (ix),#0x06
00101$:
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00104$
;src/UI_GameMenu.c:87: --n;
	dec	-3 (ix)
;src/UI_GameMenu.c:88: color = (n==entryIndex)?((entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
	ld	a,(#_entryIndex + 0)
	sub	a, -3 (ix)
	jr	NZ,00106$
	ld	a,(#_entrySelected + 0)
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
;src/UI_GameMenu.c:89: cpct_drawSolidBox(entriesPosition[n],color, buttonWidths[n], BUTTON_HEIGHT);
	ld	a,#<(_buttonWidths)
	add	a, -3 (ix)
	ld	l,a
	ld	a,#>(_buttonWidths)
	adc	a, #0x00
	ld	h,a
	ld	b,(hl)
	ld	l,-3 (ix)
	ld	h,#0x00
	add	hl, hl
	ex	de,hl
	ld	hl,#_entriesPosition
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
;src/UI_GameMenu.c:90: print_transparent_text(buttonText[n], entriesPosition[n], 3);
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	hl,#_buttonText
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
00104$:
	ld	sp, ix
	pop	ix
	ret
;src/UI_GameMenu.c:96: u8 ui_gamemenu_get_entry(){
;	---------------------------------
; Function ui_gamemenu_get_entry
; ---------------------------------
_ui_gamemenu_get_entry::
;src/UI_GameMenu.c:97: return entryIndex;
	ld	iy,#_entryIndex
	ld	l,0 (iy)
	ret
;src/UI_GameMenu.c:100: u8 ui_gamemenu_is_selected(){
;	---------------------------------
; Function ui_gamemenu_is_selected
; ---------------------------------
_ui_gamemenu_is_selected::
;src/UI_GameMenu.c:101: return entrySelected;
	ld	iy,#_entrySelected
	ld	l,0 (iy)
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__lastEntry:
	.db #0x00	; 0
__xinit__entryIndex:
	.db #0x00	; 0
__xinit__entrySelected:
	.db #0x00	; 0
	.area _CABS (ABS)
