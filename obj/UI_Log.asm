;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module UI_Log
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ui_log_render
	.globl _print_text
	.globl _cpct_memcpy
	.globl _ui_log_textStrings
	.globl _ui_log_currentString
	.globl _ui_log_init
	.globl _ui_log_add_log
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_ui_log_currentString::
	.ds 1
_ui_log_textStrings::
	.ds 72
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
;src/UI_Log.c:16: void ui_log_init(){
;	---------------------------------
; Function ui_log_init
; ---------------------------------
_ui_log_init::
;src/UI_Log.c:18: ui_log_currentString=0;
	ld	hl,#_ui_log_currentString + 0
	ld	(hl), #0x00
;src/UI_Log.c:19: print_text("LOG", UI_LOG_TITLE_POSITION, UI_LOG_BG_COLOR, UI_LOG_FG_COLOR);
	ld	hl,#0x0301
	push	hl
	ld	hl,#0xC0E6
	push	hl
	ld	hl,#___str_0
	push	hl
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;src/UI_Log.c:20: while(n){
	ld	c,#0x08
	ld	de,#0x0048
00101$:
	ld	a,c
	or	a, a
	ret	Z
;src/UI_Log.c:21: --n;
	ld	a,e
	add	a,#0xF7
	ld	e,a
	ld	a,d
	adc	a,#0xFF
	ld	d,a
	dec	c
;src/UI_Log.c:22: ui_log_textStrings[n][0]=0;
	ld	hl,#_ui_log_textStrings
	add	hl,de
	ld	(hl),#0x00
;src/UI_Log.c:23: ui_log_textStrings[n][8]=0;
	ld	hl,#_ui_log_textStrings
	add	hl,de
	push	de
	ld	de,#0x0008
	add	hl, de
	pop	de
	ld	(hl),#0x00
	jr	00101$
___str_0:
	.ascii "LOG"
	.db 0x00
;src/UI_Log.c:27: void ui_log_add_log(const char* const newLog){
;	---------------------------------
; Function ui_log_add_log
; ---------------------------------
_ui_log_add_log::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/UI_Log.c:29: ui_log_currentString = (ui_log_currentString+1) & 7;
	ld	a,(#_ui_log_currentString + 0)
	inc	a
	and	a, #0x07
	ld	(#_ui_log_currentString + 0),a
;src/UI_Log.c:31: cpct_memcpy(ui_log_textStrings[ui_log_currentString], newLog, 8);
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	de,(_ui_log_currentString)
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	de,#_ui_log_textStrings
	add	hl,de
	ld	de,#0x0008
	push	de
	push	bc
	push	hl
	call	_cpct_memcpy
	pop	ix
	ret
;src/UI_Log.c:35: void ui_log_render(){
;	---------------------------------
; Function ui_log_render
; ---------------------------------
_ui_log_render::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/UI_Log.c:39: while(i){
	ld	bc,#0xC180
	ld	-1 (ix),#0x08
00101$:
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00104$
;src/UI_Log.c:40: ui_log_currentString=((ui_log_currentString+1)&7);
	ld	a,(#_ui_log_currentString + 0)
	inc	a
	and	a, #0x07
	ld	(#_ui_log_currentString + 0),a
;src/UI_Log.c:41: print_text(ui_log_textStrings[ui_log_currentString], pos, UI_LOG_BG_COLOR, UI_LOG_FG_COLOR);
	ld	de,(_ui_log_currentString)
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	de,#_ui_log_textStrings
	add	hl,de
	ex	de,hl
	push	bc
	ld	hl,#0x0301
	push	hl
	push	bc
	push	de
	call	_print_text
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	pop	bc
;src/UI_Log.c:42: pos+=80;
	ld	hl,#0x0050
	add	hl,bc
	ld	c,l
	ld	b,h
;src/UI_Log.c:43: --i;
	dec	-1 (ix)
	jr	00101$
00104$:
	inc	sp
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
