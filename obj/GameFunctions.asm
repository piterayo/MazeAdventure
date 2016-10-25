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
	.globl _camelot_warriors_mode
	.globl _textures_on
	.globl _music_on
	.globl _r_counter
	.globl _movement_directionArray
	.globl _game_init
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_r_counter::
	.ds 2
_music_on::
	.ds 1
_textures_on::
	.ds 1
_camelot_warriors_mode::
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
;src/GameFunctions.c:16: void game_interrupt_handler(){
;	---------------------------------
; Function game_interrupt_handler
; ---------------------------------
_game_interrupt_handler::
;src/GameFunctions.c:17: ++r_counter;
	ld	hl, #_r_counter+0
	inc	(hl)
	ret	NZ
	ld	hl, #_r_counter+1
	inc	(hl)
	ret
;src/GameFunctions.c:25: void game_init(){
;	---------------------------------
; Function game_init
; ---------------------------------
_game_init::
;src/GameFunctions.c:26: cpct_disableFirmware();
	call	_cpct_disableFirmware
;src/GameFunctions.c:27: cpct_setVideoMode(0);
	ld	l,#0x00
	call	_cpct_setVideoMode
;src/GameFunctions.c:29: cpct_fw2hw(g_palette,16);
	ld	hl,#0x0010
	push	hl
	ld	hl,#_g_palette
	push	hl
	call	_cpct_fw2hw
;src/GameFunctions.c:31: cpct_setInterruptHandler(game_interrupt_handler);
	ld	hl,#_game_interrupt_handler
	call	_cpct_setInterruptHandler
;src/GameFunctions.c:32: level_init_palettes();
	call	_level_init_palettes
;src/GameFunctions.c:33: cpct_setPalette(g_palette,16);
	ld	hl,#0x0010
	push	hl
	ld	hl,#_g_palette
	push	hl
	call	_cpct_setPalette
;src/GameFunctions.c:34: cpct_setBorder(g_palette[1]);
	ld	hl, #_g_palette + 1
	ld	b,(hl)
	push	bc
	inc	sp
	ld	a,#0x10
	push	af
	inc	sp
	call	_cpct_setPALColour
;src/GameFunctions.c:36: music_on = 1;
	ld	hl,#_music_on + 0
	ld	(hl), #0x01
;src/GameFunctions.c:37: textures_on = 1;
	ld	hl,#_textures_on + 0
	ld	(hl), #0x01
;src/GameFunctions.c:40: camelot_warriors_mode=0;
	ld	hl,#_camelot_warriors_mode + 0
	ld	(hl), #0x00
	ret
_movement_directionArray:
	.db #0x01	;  1
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0xFF	; -1
	.db #0xFF	; -1
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x01	;  1
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
