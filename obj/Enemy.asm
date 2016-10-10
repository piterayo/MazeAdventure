;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module Enemy
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _abs
	.globl _enemyArray
	.globl _activeEnemies
	.globl _Enemy_spawn_new
	.globl _Enemy_update_logic
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_enemyArray::
	.ds 180
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
;src/Enemy.c:8: u8 abs(u8 n){
;	---------------------------------
; Function abs
; ---------------------------------
_abs::
;src/Enemy.c:9: return ~n+1;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	cpl
	ld	c,a
	inc	c
	ld	l,c
	ret
_activeEnemies:
	.db #0x00	; 0
;src/Enemy.c:12: void Enemy_spawn_new(){
;	---------------------------------
; Function Enemy_spawn_new
; ---------------------------------
_Enemy_spawn_new::
;src/Enemy.c:15: if(activeEnemies<15){
	ld	a,(#_activeEnemies + 0)
	sub	a, #0x0F
	ret	NC
;src/Enemy.c:16: while(i){
	ld	c,#0x0F
	ld	de,#0x00B4
00103$:
	ld	a,c
	or	a, a
	ret	Z
;src/Enemy.c:17: --i;
	ld	a,e
	add	a,#0xF4
	ld	e,a
	ld	a,d
	adc	a,#0xFF
	ld	d,a
	dec	c
;src/Enemy.c:18: if(enemyArray[i].hitPoints==0){
	ld	iy,#_enemyArray+0
	add	iy,de
	push	iy
	pop	hl
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	or	a,h
	jr	NZ,00103$
;src/Enemy.c:19: e = &enemyArray[i];
	push	iy
	pop	bc
;src/Enemy.c:21: e->textureId = 0;
	xor	a, a
	ld	(bc),a
;src/Enemy.c:23: e->hitPoints = 10;
	inc	bc
	inc	bc
	inc	bc
	ld	h,b
	ld	l, c
	ld	(hl),#0x0A
	inc	hl
	ld	(hl),#0x00
;src/Enemy.c:25: break;
	ret
;src/Enemy.c:31: void Enemy_update_logic(){
;	---------------------------------
; Function Enemy_update_logic
; ---------------------------------
_Enemy_update_logic::
;src/Enemy.c:33: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
