;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module StringInput
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _cpct_memset
	.globl _currentPos
	.globl _inputString
	.globl _ui_stringinput_init
	.globl _ui_stringinput_add_char
	.globl _ui_stringinput_get_string
	.globl _ui_stringinput_remove_char
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_inputString::
	.ds 19
_currentPos::
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
;src/StringInput.c:10: void ui_stringinput_init(){
;	---------------------------------
; Function ui_stringinput_init
; ---------------------------------
_ui_stringinput_init::
;src/StringInput.c:11: currentPos=0;
	ld	hl,#_currentPos + 0
	ld	(hl), #0x00
;src/StringInput.c:12: cpct_memset(inputString, 0, MAX_INPUT_STRING+1);
	ld	hl,#0x0013
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	hl,#_inputString
	push	hl
	call	_cpct_memset
	ret
;src/StringInput.c:15: void ui_stringinput_add_char(u8 c){
;	---------------------------------
; Function ui_stringinput_add_char
; ---------------------------------
_ui_stringinput_add_char::
;src/StringInput.c:16: if(currentPos<MAX_INPUT_STRING){
	ld	a,(#_currentPos + 0)
	sub	a, #0x12
	ret	NC
;src/StringInput.c:17: inputString[currentPos] = c;
	ld	bc,#_inputString+0
	ld	hl,(_currentPos)
	ld	h,#0x00
	add	hl,bc
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	ld	(hl),a
;src/StringInput.c:18: ++currentPos;
	ld	hl, #_currentPos+0
	inc	(hl)
	ret
;src/StringInput.c:22: char* const ui_stringinput_get_string(){
;	---------------------------------
; Function ui_stringinput_get_string
; ---------------------------------
_ui_stringinput_get_string::
;src/StringInput.c:23: return inputString;
	ld	hl,#_inputString
	ret
;src/StringInput.c:26: void ui_stringinput_remove_char(){
;	---------------------------------
; Function ui_stringinput_remove_char
; ---------------------------------
_ui_stringinput_remove_char::
;src/StringInput.c:27: if(currentPos>0){
	ld	a,(#_currentPos + 0)
	or	a, a
	ret	Z
;src/StringInput.c:28: --currentPos;
	ld	hl, #_currentPos+0
	dec	(hl)
;src/StringInput.c:29: inputString[currentPos] = 0;
	ld	bc,#_inputString+0
	ld	hl,(_currentPos)
	ld	h,#0x00
	add	hl,bc
	ld	(hl),#0x00
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
