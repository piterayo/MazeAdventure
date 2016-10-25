;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module State_Inventory
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ui_inventory_render_all
	.globl _ui_inventory_render_refresh
	.globl _ui_inventory_unselect_entry
	.globl _ui_inventory_select_entry
	.globl _ui_inventory_previous_entry
	.globl _ui_inventory_next_entry
	.globl _ui_inventory_is_selected
	.globl _ui_inventory_get_entry
	.globl _ui_inventory_init
	.globl _item_use_scroll
	.globl _item_use_potion
	.globl _statemanager_input_accepted
	.globl _statemanager_close_state
	.globl _cpct_drawSolidBox
	.globl _cpct_isKeyPressed
	.globl _object_used
	.globl _state_inventory_enter
	.globl _state_inventory_return
	.globl _state_inventory_object_used
	.globl _state_inventory_input
	.globl _state_inventory_update
	.globl _state_inventory_render
	.globl _state_inventory_exit
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_object_used::
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
;src/State_Inventory.c:17: void state_inventory_enter(){
;	---------------------------------
; Function state_inventory_enter
; ---------------------------------
_state_inventory_enter::
;src/State_Inventory.c:18: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[4], 34, 80);
	ld	hl, #_g_colors + 4
	ld	b,(hl)
	ld	hl,#0x5022
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xC297
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/State_Inventory.c:19: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 68), g_colors[1], 32, 72);
	ld	hl, #_g_colors + 1
	ld	b,(hl)
	ld	hl,#0x4820
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xE298
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/State_Inventory.c:20: ui_inventory_init();
	call	_ui_inventory_init
;src/State_Inventory.c:21: ui_inventory_render_all();
	call	_ui_inventory_render_all
;src/State_Inventory.c:22: object_used=0;
	ld	hl,#_object_used + 0
	ld	(hl), #0x00
	ret
;src/State_Inventory.c:25: void state_inventory_return(){
;	---------------------------------
; Function state_inventory_return
; ---------------------------------
_state_inventory_return::
;src/State_Inventory.c:27: }
	ret
;src/State_Inventory.c:29: u8 state_inventory_object_used(){
;	---------------------------------
; Function state_inventory_object_used
; ---------------------------------
_state_inventory_object_used::
;src/State_Inventory.c:30: return object_used;
	ld	iy,#_object_used
	ld	l,0 (iy)
	ret
;src/State_Inventory.c:33: void state_inventory_input(){
;	---------------------------------
; Function state_inventory_input
; ---------------------------------
_state_inventory_input::
;src/State_Inventory.c:34: if(cpct_isKeyPressed(Key_CursorUp)){
	ld	hl,#0x0100
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00107$
;src/State_Inventory.c:35: ui_inventory_previous_entry();
	call	_ui_inventory_previous_entry
;src/State_Inventory.c:36: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00107$:
;src/State_Inventory.c:38: else if(cpct_isKeyPressed(Key_CursorDown)){
	ld	hl,#0x0400
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	jr	Z,00104$
;src/State_Inventory.c:39: ui_inventory_next_entry();
	call	_ui_inventory_next_entry
;src/State_Inventory.c:40: statemanager_input_accepted();
	jp  _statemanager_input_accepted
00104$:
;src/State_Inventory.c:42: else if(cpct_isKeyPressed(Key_Return)){
	ld	hl,#0x0402
	call	_cpct_isKeyPressed
	ld	a,l
	or	a, a
	ret	Z
;src/State_Inventory.c:43: ui_inventory_select_entry();
	call	_ui_inventory_select_entry
;src/State_Inventory.c:44: statemanager_input_accepted();
	jp  _statemanager_input_accepted
;src/State_Inventory.c:48: void state_inventory_update(){
;	---------------------------------
; Function state_inventory_update
; ---------------------------------
_state_inventory_update::
;src/State_Inventory.c:49: if(ui_inventory_is_selected()){
	call	_ui_inventory_is_selected
	ld	a,l
	or	a, a
	jp	Z,_ui_inventory_unselect_entry
;src/State_Inventory.c:50: ui_inventory_render_refresh();
	call	_ui_inventory_render_refresh
;src/State_Inventory.c:51: switch(ui_inventory_get_entry()){
	call	_ui_inventory_get_entry
	ld	a,l
	or	a, a
	jr	Z,00101$
	dec	l
	jr	Z,00102$
	jr	00103$
;src/State_Inventory.c:52: case 0:{//Potion
00101$:
;src/State_Inventory.c:53: object_used=item_use_potion();
	call	_item_use_potion
	ld	iy,#_object_used
	ld	0 (iy),l
;src/State_Inventory.c:54: break;
	jr	00103$
;src/State_Inventory.c:56: case 1:{//Scroll
00102$:
;src/State_Inventory.c:57: object_used=item_use_scroll();
	call	_item_use_scroll
	ld	iy,#_object_used
	ld	0 (iy),l
;src/State_Inventory.c:60: }
00103$:
;src/State_Inventory.c:61: statemanager_close_state();
	call	_statemanager_close_state
;src/State_Inventory.c:63: ui_inventory_unselect_entry();
	jp  _ui_inventory_unselect_entry
;src/State_Inventory.c:66: void state_inventory_render(){
;	---------------------------------
; Function state_inventory_render
; ---------------------------------
_state_inventory_render::
;src/State_Inventory.c:67: ui_inventory_render_refresh();
	jp  _ui_inventory_render_refresh
;src/State_Inventory.c:70: void state_inventory_exit(){
;	---------------------------------
; Function state_inventory_exit
; ---------------------------------
_state_inventory_exit::
;src/State_Inventory.c:71: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[1], 34, 80);
	ld	hl, #(_g_colors + 0x0001) + 0
	ld	b,(hl)
	ld	hl,#0x5022
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xC297
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
