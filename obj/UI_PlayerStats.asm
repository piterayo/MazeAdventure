;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module UI_PlayerStats
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _print_transparent_text
	.globl _cpct_drawSolidBox
	.globl _strings
	.globl _ui_playerstats_render
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
;src/UI_PlayerStats.c:20: void ui_playerstats_render(){
;	---------------------------------
; Function ui_playerstats_render
; ---------------------------------
_ui_playerstats_render::
;src/UI_PlayerStats.c:21: print_transparent_text("STATS", UI_PLAYERSTATS_POSITION+1, UI_PLAYERSTATS_TEXT_COLOR);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xC0A1
	push	hl
	ld	hl,#___str_0
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/UI_PlayerStats.c:23: print_transparent_text("HP", UI_PLAYERSTATS_POSITION+160, UI_PLAYERSTATS_TEXT_COLOR);
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xC140
	push	hl
	ld	hl,#___str_1
	push	hl
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/UI_PlayerStats.c:24: cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[UI_PLAYERSTATS_HEALTHBAR_FG_COLOR], 10,4);
	ld	hl,#_g_colors+5
	ld	b,(hl)
	ld	hl,#0x040A
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xC944
	push	hl
	call	_cpct_drawSolidBox
	pop	af
	pop	af
	inc	sp
;src/UI_PlayerStats.c:25: print_transparent_text(strings[0], UI_PLAYERSTATS_POSITION+240, UI_PLAYERSTATS_TEXT_COLOR);
	ld	bc, (#_strings + 0)
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xC190
	push	hl
	push	bc
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/UI_PlayerStats.c:26: print_transparent_text(strings[1], UI_PLAYERSTATS_POSITION+320, UI_PLAYERSTATS_TEXT_COLOR);
	ld	bc, (#_strings + 2)
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xC1E0
	push	hl
	push	bc
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/UI_PlayerStats.c:27: print_transparent_text(strings[2], UI_PLAYERSTATS_POSITION+400, UI_PLAYERSTATS_TEXT_COLOR);
	ld	bc, (#_strings + 4)
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xC230
	push	hl
	push	bc
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/UI_PlayerStats.c:28: print_transparent_text(strings[3], UI_PLAYERSTATS_POSITION+480, UI_PLAYERSTATS_TEXT_COLOR);
	ld	bc, (#_strings + 6)
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xC280
	push	hl
	push	bc
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
;src/UI_PlayerStats.c:29: print_transparent_text(strings[4], UI_PLAYERSTATS_POSITION+560, UI_PLAYERSTATS_TEXT_COLOR);
	ld	bc, (#_strings + 8)
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#0xC2D0
	push	hl
	push	bc
	call	_print_transparent_text
	pop	af
	pop	af
	inc	sp
	ret
_strings:
	.dw __str_2
	.dw __str_3
	.dw __str_4
	.dw __str_5
	.dw __str_6
___str_0:
	.ascii "STATS"
	.db 0x00
___str_1:
	.ascii "HP"
	.db 0x00
__str_2:
	.ascii " 10:10"
	.db 0x00
__str_3:
	.ascii "+ 1.00"
	.db 0x00
__str_4:
	.ascii "# 0.00"
	.db 0x00
__str_5:
	.ascii "&  000"
	.db 0x00
__str_6:
	.ascii "$    0"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
