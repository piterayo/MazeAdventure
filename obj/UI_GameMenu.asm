;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module UI_GameMenu
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _cpct_setPALColour
	.globl _cpct_drawSolidBox
	.globl _entrySelected
	.globl _entryIndex
	.globl _buttonWidths
	.globl _buttonText
	.globl _entriesPosition
	.globl _ui_gamemenu_next_entry
	.globl _ui_gamemenu_previous_entry
	.globl _ui_gamemenu_unselect_entry
	.globl _ui_gamemenu_select_entry
	.globl _ui_gamemenu_render
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
;src/UI_GameMenu.c:36: void ui_gamemenu_next_entry(){
;	---------------------------------
; Function ui_gamemenu_next_entry
; ---------------------------------
_ui_gamemenu_next_entry::
;src/UI_GameMenu.c:37: if(entryIndex<(ENTRIES-1)){
	ld	a,(#_entryIndex + 0)
	sub	a, #0x05
	ret	NC
;src/UI_GameMenu.c:38: ++entryIndex;
	ld	hl, #_entryIndex+0
	inc	(hl)
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
	.dw __str_0
	.dw __str_2
	.dw __str_3
	.dw __str_4
_buttonWidths:
	.db #0x06	; 6
	.db #0x16	; 22
	.db #0x06	; 6
	.db #0x0D	; 13
	.db #0x0D	; 13
	.db #0x0D	; 13
__str_0:
	.db 0x00
__str_1:
	.ascii "MOVE"
	.db 0x00
__str_2:
	.ascii "ATTACK"
	.db 0x00
__str_3:
	.ascii "INV"
	.db 0x00
__str_4:
	.ascii "PAUSE"
	.db 0x00
;src/UI_GameMenu.c:42: void ui_gamemenu_previous_entry(){
;	---------------------------------
; Function ui_gamemenu_previous_entry
; ---------------------------------
_ui_gamemenu_previous_entry::
;src/UI_GameMenu.c:43: if(entryIndex>0){
	ld	a,(#_entryIndex + 0)
	or	a, a
	ret	Z
;src/UI_GameMenu.c:44: --entryIndex;
	ld	hl, #_entryIndex+0
	dec	(hl)
	ret
;src/UI_GameMenu.c:48: void ui_gamemenu_unselect_entry(){
;	---------------------------------
; Function ui_gamemenu_unselect_entry
; ---------------------------------
_ui_gamemenu_unselect_entry::
;src/UI_GameMenu.c:49: entrySelected=0;
	ld	hl,#_entrySelected + 0
	ld	(hl), #0x00
	ret
;src/UI_GameMenu.c:52: void ui_gamemenu_select_entry(){
;	---------------------------------
; Function ui_gamemenu_select_entry
; ---------------------------------
_ui_gamemenu_select_entry::
;src/UI_GameMenu.c:53: entrySelected=1;
	ld	hl,#_entrySelected + 0
	ld	(hl), #0x01
	ret
;src/UI_GameMenu.c:56: void ui_gamemenu_render(){
;	---------------------------------
; Function ui_gamemenu_render
; ---------------------------------
_ui_gamemenu_render::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/UI_GameMenu.c:59: cpct_setBorder(g_palette[0]);
	ld	hl, #_g_palette + 0
	ld	b,(hl)
	push	bc
	inc	sp
	ld	a,#0x10
	push	af
	inc	sp
	call	_cpct_setPALColour
;src/UI_GameMenu.c:61: while(n){
	ld	-1 (ix),#0x06
00101$:
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00103$
;src/UI_GameMenu.c:62: --n;
	dec	-1 (ix)
;src/UI_GameMenu.c:63: color = (n==entryIndex)?((entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
	ld	a,(#_entryIndex + 0)
	sub	a, -1 (ix)
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
;src/UI_GameMenu.c:64: cpct_drawSolidBox(entriesPosition[n],color, buttonWidths[n], BUTTON_HEIGHT);
	ld	a,#<(_buttonWidths)
	add	a, -1 (ix)
	ld	l,a
	ld	a,#>(_buttonWidths)
	adc	a, #0x00
	ld	h,a
	ld	b,(hl)
	ld	l,-1 (ix)
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
	jr	00101$
00103$:
;src/UI_GameMenu.c:67: cpct_setBorder(g_palette[1]);
	ld	hl, #_g_palette + 1
	ld	b,(hl)
	push	bc
	inc	sp
	ld	a,#0x10
	push	af
	inc	sp
	call	_cpct_setPALColour
	inc	sp
	pop	ix
	ret
;src/UI_GameMenu.c:71: u8 ui_gamemenu_get_entry(){
;	---------------------------------
; Function ui_gamemenu_get_entry
; ---------------------------------
_ui_gamemenu_get_entry::
;src/UI_GameMenu.c:72: return entryIndex;
	ld	iy,#_entryIndex
	ld	l,0 (iy)
	ret
;src/UI_GameMenu.c:75: u8 ui_gamemenu_is_selected(){
;	---------------------------------
; Function ui_gamemenu_is_selected
; ---------------------------------
_ui_gamemenu_is_selected::
;src/UI_GameMenu.c:76: return entrySelected;
	ld	iy,#_entrySelected
	ld	l,0 (iy)
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__entryIndex:
	.db #0x00	; 0
__xinit__entrySelected:
	.db #0x00	; 0
	.area _CABS (ABS)
