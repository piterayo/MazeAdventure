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
	.globl _cpct_akp_stop
	.globl _cpct_akp_musicPlay
	.globl _cpct_akp_musicInit
	.globl _cpct_setPALColour
	.globl _cpct_setPalette
	.globl _cpct_fw2hw
	.globl _cpct_setVideoMode
	.globl _cpct_setInterruptHandler
	.globl _cpct_disableFirmware
	.globl _camelot_warriors_mode
	.globl _currentMusic
	.globl _syncmusic_counter
	.globl _textures_on
	.globl _music_on
	.globl _r_counter
	.globl _movement_directionArray
	.globl _set_music
	.globl _remove_music
	.globl _stop_music
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
_syncmusic_counter::
	.ds 1
_currentMusic::
	.ds 2
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
;src/GameFunctions.c:19: void game_interrupt_handler(){
;	---------------------------------
; Function game_interrupt_handler
; ---------------------------------
_game_interrupt_handler::
;src/GameFunctions.c:20: ++r_counter;
	ld	hl, #_r_counter+0
	inc	(hl)
	jr	NZ,00126$
	ld	hl, #_r_counter+1
	inc	(hl)
00126$:
;src/GameFunctions.c:21: ++syncmusic_counter;
	ld	hl, #_syncmusic_counter+0
	inc	(hl)
;src/GameFunctions.c:22: if(syncmusic_counter==6){
	ld	a,(#_syncmusic_counter + 0)
	sub	a, #0x06
	ret	NZ
;src/GameFunctions.c:23: syncmusic_counter=0;
	ld	hl,#_syncmusic_counter + 0
	ld	(hl), #0x00
;src/GameFunctions.c:24: if(currentMusic && music_on){
	ld	a,(#_currentMusic + 1)
	ld	hl,#_currentMusic + 0
	or	a,(hl)
	ret	Z
	ld	a,(#_music_on + 0)
	or	a, a
	ret	Z
;src/GameFunctions.c:25: cpct_akp_musicPlay();
	call	_cpct_akp_musicPlay
;src/GameFunctions.c:26: if (cpct_akp_songLoopTimes > 0){
	ld	a,(#_cpct_akp_songLoopTimes + 0)
	or	a, a
	ret	Z
;src/GameFunctions.c:27: cpct_akp_musicInit(currentMusic);
	ld	hl,(_currentMusic)
	push	hl
	call	_cpct_akp_musicInit
	pop	af
	ret
;src/GameFunctions.c:38: void set_music(void* m){
;	---------------------------------
; Function set_music
; ---------------------------------
_set_music::
;src/GameFunctions.c:39: currentMusic=m;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	ld	(#_currentMusic + 0),a
	ld	hl, #2+1
	add	hl, sp
	ld	a, (hl)
	ld	(#_currentMusic + 1),a
;src/GameFunctions.c:40: cpct_akp_musicInit(currentMusic);
	ld	hl,(_currentMusic)
	push	hl
	call	_cpct_akp_musicInit
	pop	af
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
;src/GameFunctions.c:43: void remove_music(){
;	---------------------------------
; Function remove_music
; ---------------------------------
_remove_music::
;src/GameFunctions.c:44: cpct_akp_stop();
	call	_cpct_akp_stop
;src/GameFunctions.c:45: currentMusic=0;
	ld	hl,#0x0000
	ld	(_currentMusic),hl
	ret
;src/GameFunctions.c:48: void stop_music(){
;	---------------------------------
; Function stop_music
; ---------------------------------
_stop_music::
;src/GameFunctions.c:49: cpct_akp_stop();
	jp  _cpct_akp_stop
;src/GameFunctions.c:52: void game_init(){
;	---------------------------------
; Function game_init
; ---------------------------------
_game_init::
;src/GameFunctions.c:53: cpct_disableFirmware();
	call	_cpct_disableFirmware
;src/GameFunctions.c:54: cpct_setVideoMode(0);
	ld	l,#0x00
	call	_cpct_setVideoMode
;src/GameFunctions.c:56: cpct_fw2hw(g_palette,16);
	ld	hl,#0x0010
	push	hl
	ld	hl,#_g_palette
	push	hl
	call	_cpct_fw2hw
;src/GameFunctions.c:58: cpct_setInterruptHandler(game_interrupt_handler);
	ld	hl,#_game_interrupt_handler
	call	_cpct_setInterruptHandler
;src/GameFunctions.c:59: level_init_palettes();
	call	_level_init_palettes
;src/GameFunctions.c:60: cpct_setPalette(g_palette,16);
	ld	hl,#0x0010
	push	hl
	ld	hl,#_g_palette
	push	hl
	call	_cpct_setPalette
;src/GameFunctions.c:61: cpct_setBorder(g_palette[1]);
	ld	hl, #_g_palette + 1
	ld	b,(hl)
	push	bc
	inc	sp
	ld	a,#0x10
	push	af
	inc	sp
	call	_cpct_setPALColour
;src/GameFunctions.c:63: music_on = 1;
	ld	hl,#_music_on + 0
	ld	(hl), #0x01
;src/GameFunctions.c:64: textures_on = 1;
	ld	hl,#_textures_on + 0
	ld	(hl), #0x01
;src/GameFunctions.c:66: syncmusic_counter=0;
	ld	hl,#_syncmusic_counter + 0
	ld	(hl), #0x00
;src/GameFunctions.c:67: currentMusic = 0;
	ld	hl,#0x0000
	ld	(_currentMusic),hl
;src/GameFunctions.c:71: camelot_warriors_mode=0;
	ld	hl,#_camelot_warriors_mode + 0
	ld	(hl), #0x00
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
