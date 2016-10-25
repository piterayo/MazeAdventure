;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module UI_Inventory
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ui_inventory_render_button
	.globl _print_transparent_text
	.globl _cpct_drawSolidBox
	.globl _ui_inventory_entrySelected
	.globl _ui_inventory_entryIndex
	.globl _ui_inventory_lastEntry
	.globl _ui_inventory_buttonText
	.globl _ui_inventory_entriesTextPosition
	.globl _ui_inventory_entriesPosition
	.globl _ui_inventory_init
	.globl _ui_inventory_get_entry
	.globl _ui_inventory_is_selected
	.globl _ui_inventory_next_entry
	.globl _ui_inventory_previous_entry
	.globl _ui_inventory_select_entry
	.globl _ui_inventory_unselect_entry
	.globl _ui_inventory_render_refresh
	.globl _ui_inventory_render_all
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_ui_inventory_lastEntry::
	.ds 1
_ui_inventory_entryIndex::
	.ds 1
_ui_inventory_entrySelected::
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
;src/UI_Inventory.c:54: void ui_inventory_init(){
;	---------------------------------
; Function ui_inventory_init
; ---------------------------------
_ui_inventory_init::
;src/UI_Inventory.c:55: ui_inventory_lastEntry=0;
	ld	hl,#_ui_inventory_lastEntry + 0
	ld	(hl), #0x00
;src/UI_Inventory.c:56: ui_inventory_entryIndex=0;
	ld	hl,#_ui_inventory_entryIndex + 0
	ld	(hl), #0x00
;src/UI_Inventory.c:57: ui_inventory_entrySelected=0;
	ld	hl,#_ui_inventory_entrySelected + 0
	ld	(hl), #0x00
	ret
_ui_inventory_entriesPosition:
	.dw #0xC2FB
	.dw #0xE39B
	.dw #0xC482
_ui_inventory_entriesTextPosition:
	.dw #0xEAFE
	.dw #0xCBEE
	.dw #0xEC84
_ui_inventory_buttonText:
	.dw __str_0
	.dw __str_0
	.dw __str_1
__str_0:
	.ascii "USE"
	.db 0x00
__str_1:
	.ascii "EXIT"
	.db 0x00
;src/UI_Inventory.c:61: u8 ui_inventory_get_entry(){
;	---------------------------------
; Function ui_inventory_get_entry
; ---------------------------------
_ui_inventory_get_entry::
;src/UI_Inventory.c:62: return ui_inventory_entryIndex;
	ld	iy,#_ui_inventory_entryIndex
	ld	l,0 (iy)
	ret
;src/UI_Inventory.c:65: u8 ui_inventory_is_selected(){
;	---------------------------------
; Function ui_inventory_is_selected
; ---------------------------------
_ui_inventory_is_selected::
;src/UI_Inventory.c:66: return ui_inventory_entrySelected;
	ld	iy,#_ui_inventory_entrySelected
	ld	l,0 (iy)
	ret
;src/UI_Inventory.c:69: void ui_inventory_next_entry(){
;	---------------------------------
; Function ui_inventory_next_entry
; ---------------------------------
_ui_inventory_next_entry::
;src/UI_Inventory.c:70: if(ui_inventory_entryIndex<(UI_INVENTORY_ENTRIES-1)){
;src/UI_Inventory.c:71: ui_inventory_lastEntry=ui_inventory_entryIndex;
	ld	a,(#_ui_inventory_entryIndex + 0)
	cp	a,#0x02
	ret	NC
	ld	(#_ui_inventory_lastEntry + 0),a
;src/UI_Inventory.c:72: ++ui_inventory_entryIndex;
	ld	hl, #_ui_inventory_entryIndex+0
	inc	(hl)
	ret
;src/UI_Inventory.c:76: void ui_inventory_previous_entry(){
;	---------------------------------
; Function ui_inventory_previous_entry
; ---------------------------------
_ui_inventory_previous_entry::
;src/UI_Inventory.c:77: if(ui_inventory_entryIndex>0){
	ld	a,(#_ui_inventory_entryIndex + 0)
	or	a, a
	ret	Z
;src/UI_Inventory.c:78: ui_inventory_lastEntry=ui_inventory_entryIndex;
	ld	a,(#_ui_inventory_entryIndex + 0)
	ld	(#_ui_inventory_lastEntry + 0),a
;src/UI_Inventory.c:79: --ui_inventory_entryIndex;
	ld	hl, #_ui_inventory_entryIndex+0
	dec	(hl)
	ret
;src/UI_Inventory.c:84: void ui_inventory_select_entry(){
;	---------------------------------
; Function ui_inventory_select_entry
; ---------------------------------
_ui_inventory_select_entry::
;src/UI_Inventory.c:85: ui_inventory_entrySelected=1;
	ld	hl,#_ui_inventory_entrySelected + 0
	ld	(hl), #0x01
	ret
;src/UI_Inventory.c:88: void ui_inventory_unselect_entry(){
;	---------------------------------
; Function ui_inventory_unselect_entry
; ---------------------------------
_ui_inventory_unselect_entry::
;src/UI_Inventory.c:89: ui_inventory_entrySelected=0;
	ld	hl,#_ui_inventory_entrySelected + 0
	ld	(hl), #0x00
	ret
;src/UI_Inventory.c:92: void ui_inventory_render_button(u8 n){
;	---------------------------------
; Function ui_inventory_render_button
; ---------------------------------
_ui_inventory_render_button::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/UI_Inventory.c:94: color = (n==ui_inventory_entryIndex)?((ui_inventory_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
	ld	a,4 (ix)
	ld	iy,#_ui_inventory_entryIndex
	sub	a, 0 (iy)
	jr	NZ,00103$
	ld	a,(#_ui_inventory_entrySelected + 0)
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
;src/UI_Inventory.c:95: cpct_drawSolidBox(ui_inventory_entriesPosition[n],color, UI_INVENTORY_BUTTON_WIDTH, UI_INVENTORY_BUTTON_HEIGHT);
	ld	l,4 (ix)
	ld	h,#0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl,#_ui_inventory_entriesPosition
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
;src/UI_Inventory.c:96: print_transparent_text(ui_inventory_buttonText[n], ui_inventory_entriesTextPosition[n], 3);
	ld	hl,#_ui_inventory_entriesTextPosition
	add	hl,bc
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#_ui_inventory_buttonText
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
;src/UI_Inventory.c:100: void ui_inventory_render_refresh(){
;	---------------------------------
; Function ui_inventory_render_refresh
; ---------------------------------
_ui_inventory_render_refresh::
;src/UI_Inventory.c:102: ui_inventory_render_button(ui_inventory_entryIndex);
	ld	a,(_ui_inventory_entryIndex)
	push	af
	inc	sp
	call	_ui_inventory_render_button
	inc	sp
;src/UI_Inventory.c:103: ui_inventory_render_button(ui_inventory_lastEntry);
	ld	a,(_ui_inventory_lastEntry)
	push	af
	inc	sp
	call	_ui_inventory_render_button
	inc	sp
;src/UI_Inventory.c:105: ui_inventory_lastEntry=ui_inventory_entryIndex;
	ld	a,(#_ui_inventory_entryIndex + 0)
	ld	(#_ui_inventory_lastEntry + 0),a
	ret
;src/UI_Inventory.c:108: void ui_inventory_render_all(){
;	---------------------------------
; Function ui_inventory_render_all
; ---------------------------------
_ui_inventory_render_all::
;src/UI_Inventory.c:111: print_transparent_text("POTION", UI_INVENTORY_BUTTON_POTIONS_LABEL_POSITION, 3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xEAEA
	push	hl
	ld	hl,#___str_2
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/UI_Inventory.c:112: print_transparent_text("SCROLL", UI_INVENTORY_BUTTON_SCROLLS_LABEL_POSITION, 3);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xCBDA
	push	hl
	ld	hl,#___str_3
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/UI_Inventory.c:114: while(n){
	ld	b,#0x03
00101$:
	ld	a,b
	or	a, a
	jr	Z,00103$
;src/UI_Inventory.c:115: --n;
	dec	b
;src/UI_Inventory.c:116: ui_inventory_render_button(n);
	push	bc
	push	bc
	inc	sp
	call	_ui_inventory_render_button
	inc	sp
	pop	bc
	jr	00101$
00103$:
;src/UI_Inventory.c:119: ui_inventory_lastEntry=ui_inventory_entryIndex;
	ld	a,(#_ui_inventory_entryIndex + 0)
	ld	(#_ui_inventory_lastEntry + 0),a
	ret
___str_2:
	.ascii "POTION"
	.db 0x00
___str_3:
	.ascii "SCROLL"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
