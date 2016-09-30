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
	.globl _renderCompass
	.globl _uncompress_theme_textures
	.globl _draw_minimap_to_buffer
	.globl _render_draw_to_buffer
	.globl _generate_map
	.globl _init_generator
	.globl _cpct_setPALColour
	.globl _cpct_setPalette
	.globl _cpct_fw2hw
	.globl _cpct_setVideoMode
	.globl _cpct_drawSprite
	.globl _cpct_isKeyPressed
	.globl _cpct_scanKeyboard_f
	.globl _cpct_memset
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
;src/main.c:28: void init(){
;	---------------------------------
; Function init
; ---------------------------------
_init::
;src/main.c:29: cpct_disableFirmware();
	call	_cpct_disableFirmware
;src/main.c:30: cpct_setVideoMode(0);
	ld	l,#0x00
	call	_cpct_setVideoMode
;src/main.c:31: cpct_fw2hw(g_palette,16);
	ld	hl,#0x0010
	push	hl
	ld	hl,#_g_palette
	push	hl
	call	_cpct_fw2hw
;src/main.c:32: cpct_setPalette(g_palette,16);
	ld	hl,#0x0010
	push	hl
	ld	hl,#_g_palette
	push	hl
	call	_cpct_setPalette
;src/main.c:33: cpct_setBorder(g_palette[0]);
	ld	hl, #_g_palette + 0
	ld	b,(hl)
	push	bc
	inc	sp
	ld	a,#0x10
	push	af
	inc	sp
	call	_cpct_setPALColour
;src/main.c:35: cpct_memset(CPCT_VMEM_START, g_colors[15], 0x4000);
	ld	hl, #(_g_colors + 0x000f) + 0
	ld	b,(hl)
	ld	hl,#0x4000
	push	hl
	push	bc
	inc	sp
	ld	h, #0xC0
	push	hl
	call	_cpct_memset
	ret
;src/main.c:38: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:39: init();
	call	_init
;src/main.c:40: init_generator();
	call	_init_generator
;src/main.c:41: uncompress_theme_textures(0);
	xor	a, a
	push	af
	inc	sp
	call	_uncompress_theme_textures
	inc	sp
;src/main.c:42: cpct_setBorder(g_palette[1]);
	ld	hl, #_g_palette + 1
	ld	b,(hl)
	push	bc
	inc	sp
	ld	a,#0x10
	push	af
	inc	sp
	call	_cpct_setPALColour
;src/main.c:43: generate_map();
	call	_generate_map
;src/main.c:44: cpct_setBorder(g_palette[15]);
	ld	hl, #_g_palette + 15
	ld	b,(hl)
	push	bc
	inc	sp
	ld	a,#0x10
	push	af
	inc	sp
	call	_cpct_setPALColour
;src/main.c:45: render_draw_to_buffer();
	call	_render_draw_to_buffer
;src/main.c:46: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
	ld	hl,#0x6428
	push	hl
	ld	hl,#0xC014
	push	hl
	ld	hl,#0x1C40
	push	hl
	call	_cpct_drawSprite
;src/main.c:47: draw_minimap_to_buffer();
	call	_draw_minimap_to_buffer
;src/main.c:48: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
	ld	hl,#0x4010
	push	hl
	ld	hl,#0xC570
	push	hl
	ld	hl,#0x1C40
	push	hl
	call	_cpct_drawSprite
;src/main.c:51: while(1) {
00115$:
;src/main.c:52: u8 movement = 0;
	ld	c,#0x00
;src/main.c:53: cpct_scanKeyboard_f();
	push	bc
	call	_cpct_scanKeyboard_f
	ld	hl,#0x0101
	call	_cpct_isKeyPressed
	ld	e,l
	pop	bc
	ld	a,e
	or	a, a
	jr	Z,00110$
;src/main.c:55: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
	ld	bc,#_PLAYER_directionIndex+0
	ld	a,(#_PLAYER_directionIndex + 0)
	add	a, #0x02
	and	a, #0x07
	ld	(bc),a
;src/main.c:56: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
	ld	bc,#_PLAYER_directionArray+0
	ld	iy,#_PLAYER_directionIndex
	ld	l, 0 (iy)
	ld	h,#0x00
	add	hl,bc
	ld	e,(hl)
	ld	hl,#_PLAYER_direction
	ld	(hl),e
;src/main.c:57: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
	ld	hl,#_PLAYER_directionIndex + 0
	ld	e, (hl)
	inc	e
	ld	l,e
	ld	h,#0x00
	add	hl,bc
	ld	c,(hl)
	ld	hl,#(_PLAYER_direction + 0x0001)
	ld	(hl),c
;src/main.c:58: renderCompass();
	call	_renderCompass
;src/main.c:59: movement =1;
	ld	c,#0x01
	jp	00111$
00110$:
;src/main.c:61: else if(cpct_isKeyPressed(Key_CursorRight)){
	push	bc
	ld	hl,#0x0200
	call	_cpct_isKeyPressed
	pop	bc
	ld	a,l
	or	a, a
	jr	Z,00107$
;src/main.c:62: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex-2)&7;
	ld	bc,#_PLAYER_directionIndex+0
	ld	a,(#_PLAYER_directionIndex + 0)
	add	a,#0xFE
	and	a, #0x07
	ld	(bc),a
;src/main.c:63: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
	ld	bc,#_PLAYER_direction+0
	ld	de,#_PLAYER_directionArray+0
	ld	iy,#_PLAYER_directionIndex
	ld	l,0 (iy)
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
;src/main.c:64: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
	ld	bc,#_PLAYER_direction+1
	ld	iy,#_PLAYER_directionIndex
	ld	l,0 (iy)
	inc	l
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	(bc),a
;src/main.c:65: renderCompass();
	call	_renderCompass
;src/main.c:66: movement =1;
	ld	c,#0x01
	jr	00111$
00107$:
;src/main.c:68: else if(cpct_isKeyPressed(Key_CursorUp)){
	push	bc
	ld	hl,#0x0100
	call	_cpct_isKeyPressed
	pop	bc
	ld	a,l
	or	a, a
	jr	Z,00104$
;src/main.c:69: *(i8*)&(PLAYER_position.x) = PLAYER_position.x + PLAYER_direction.x;
	ld	hl,#_PLAYER_position+0
	ld	c, l
	ld	b, h
	ld	e,(hl)
	ld	hl, #_PLAYER_direction + 0
	ld	l,(hl)
	ld	a,e
	add	a, l
	ld	(bc),a
;src/main.c:70: *(i8*)&(PLAYER_position.y) = PLAYER_position.y + PLAYER_direction.y;
	ld	hl,#_PLAYER_position+1
	ld	c, l
	ld	b, h
	ld	e,(hl)
	ld	hl, #(_PLAYER_direction + 0x0001) + 0
	ld	l,(hl)
	ld	a,e
	add	a, l
	ld	(bc),a
;src/main.c:72: movement =1;
	ld	c,#0x01
	jr	00111$
00104$:
;src/main.c:74: else if(cpct_isKeyPressed(Key_CursorDown)){
	push	bc
	ld	hl,#0x0400
	call	_cpct_isKeyPressed
	pop	bc
	ld	a,l
	or	a, a
	jr	Z,00111$
;src/main.c:75: *(i8*)&(PLAYER_position.x) = PLAYER_position.x - PLAYER_direction.x;
	ld	hl,#_PLAYER_position+0
	ld	c, l
	ld	b, h
	ld	e,(hl)
	ld	hl, #_PLAYER_direction + 0
	ld	l,(hl)
	ld	a,e
	sub	a, l
	ld	(bc),a
;src/main.c:76: *(i8*)&(PLAYER_position.y) = PLAYER_position.y - PLAYER_direction.y;
	ld	hl,#_PLAYER_position+1
	ld	c, l
	ld	b, h
	ld	e,(hl)
	ld	hl, #(_PLAYER_direction + 0x0001) + 0
	ld	l,(hl)
	ld	a,e
	sub	a, l
	ld	(bc),a
;src/main.c:78: movement =1;
	ld	c,#0x01
00111$:
;src/main.c:80: if(movement){
	ld	a,c
	or	a, a
	jp	Z,00115$
;src/main.c:81: render_draw_to_buffer();
	call	_render_draw_to_buffer
;src/main.c:82: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
	ld	hl,#0x6428
	push	hl
	ld	hl,#0xC014
	push	hl
	ld	hl,#0x1C40
	push	hl
	call	_cpct_drawSprite
;src/main.c:83: draw_minimap_to_buffer();
	call	_draw_minimap_to_buffer
;src/main.c:84: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
	ld	hl,#0x4010
	push	hl
	ld	hl,#0xC570
	push	hl
	ld	hl,#0x1C40
	push	hl
	call	_cpct_drawSprite
	jp	00115$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
