;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module GameFunctions
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _game_interrupt_handler
	.globl _level_init_palettes
	.globl _cpct_setPALColour
	.globl _cpct_setPalette
	.globl _cpct_fw2hw
	.globl _cpct_setVideoMode
	.globl _cpct_setInterruptHandler
	.globl _cpct_disableFirmware
	.globl _r_counter
	.globl _game_init
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
_r_counter::
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
;src/GameFunctions.c:11: void game_interrupt_handler(){
;	---------------------------------
; Function game_interrupt_handler
; ---------------------------------
_game_interrupt_handler::
;src/GameFunctions.c:13: ++r_counter;
	ld	hl, #_r_counter+0
	inc	(hl)
	ret
;src/GameFunctions.c:16: void game_init(){
;	---------------------------------
; Function game_init
; ---------------------------------
_game_init::
;src/GameFunctions.c:17: cpct_disableFirmware();
	call	_cpct_disableFirmware
;src/GameFunctions.c:18: cpct_setVideoMode(0);
	ld	l,#0x00
	call	_cpct_setVideoMode
;src/GameFunctions.c:19: cpct_fw2hw(g_palette,16);
	ld	hl,#0x0010
	push	hl
	ld	hl,#_g_palette
	push	hl
	call	_cpct_fw2hw
;src/GameFunctions.c:20: cpct_setInterruptHandler(game_interrupt_handler);
	ld	hl,#_game_interrupt_handler
	call	_cpct_setInterruptHandler
;src/GameFunctions.c:21: level_init_palettes();
	call	_level_init_palettes
;src/GameFunctions.c:22: cpct_setPalette(g_palette,16);
	ld	hl,#0x0010
	push	hl
	ld	hl,#_g_palette
	push	hl
	call	_cpct_setPalette
;src/GameFunctions.c:23: cpct_setBorder(g_palette[1]);
	ld	hl, #_g_palette + 1
	ld	b,(hl)
	push	bc
	inc	sp
	ld	a,#0x10
	push	af
	inc	sp
	call	_cpct_setPALColour
;src/GameFunctions.c:25: *((u8*)0x0000)=0xC9; //Set 0x0000 memory to always return
	ld	hl,#0x0000
	ld	(hl),#0xC9
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__r_counter:
	.db #0x00	; 0
	.area _CABS (ABS)
