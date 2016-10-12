;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _init
	.globl _interrupt_handler
	.globl _statemanager_main_loop
	.globl _statemanager_set_state
	.globl _level_init_palettes
	.globl _init_generator
	.globl _cpct_setPALColour
	.globl _cpct_setPalette
	.globl _cpct_fw2hw
	.globl _cpct_setVideoMode
	.globl _cpct_scanKeyboard_f
	.globl _cpct_memset
	.globl _cpct_setInterruptHandler
	.globl _cpct_disableFirmware
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
;src/main.c:29: void interrupt_handler(){
;	---------------------------------
; Function interrupt_handler
; ---------------------------------
_interrupt_handler::
;src/main.c:30: cpct_setBorder(g_palette[0]);
	ld	hl, #_g_palette + 0
	ld	b,(hl)
	push	bc
	inc	sp
	ld	a,#0x10
	push	af
	inc	sp
	call	_cpct_setPALColour
;src/main.c:33: cpct_setBorder(g_palette[1]);
	ld	hl, #_g_palette + 1
	ld	b,(hl)
	push	bc
	inc	sp
	ld	a,#0x10
	push	af
	inc	sp
	call	_cpct_setPALColour
	ret
;src/main.c:36: void init(){
;	---------------------------------
; Function init
; ---------------------------------
_init::
;src/main.c:37: cpct_disableFirmware();
	call	_cpct_disableFirmware
;src/main.c:38: cpct_setVideoMode(0);
	ld	l,#0x00
	call	_cpct_setVideoMode
;src/main.c:39: cpct_fw2hw(g_palette,16);
	ld	hl,#0x0010
	push	hl
	ld	hl,#_g_palette
	push	hl
	call	_cpct_fw2hw
;src/main.c:40: cpct_setInterruptHandler(interrupt_handler);
	ld	hl,#_interrupt_handler
	call	_cpct_setInterruptHandler
;src/main.c:41: level_init_palettes();
	call	_level_init_palettes
;src/main.c:42: cpct_setPalette(g_palette,16);
	ld	hl,#0x0010
	push	hl
	ld	hl,#_g_palette
	push	hl
	call	_cpct_setPalette
;src/main.c:43: cpct_setBorder(g_palette[12]);
	ld	hl, #_g_palette + 12
	ld	b,(hl)
	push	bc
	inc	sp
	ld	a,#0x10
	push	af
	inc	sp
	call	_cpct_setPALColour
;src/main.c:45: cpct_memset(CPCT_VMEM_START, g_colors[12], 0x4000);
	ld	hl, #(_g_colors + 0x000c) + 0
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
;src/main.c:47: cpct_scanKeyboard_f();
	call	_cpct_scanKeyboard_f
;src/main.c:48: init_generator();
	call	_init_generator
	ret
;src/main.c:51: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:52: init();
	call	_init
;src/main.c:54: statemanager_set_state(STATE_MAINMENU);
	xor	a, a
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/main.c:56: statemanager_main_loop();
	jp  _statemanager_main_loop
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
