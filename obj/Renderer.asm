;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module Renderer
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _draw_column_to_buffer
	.globl _draw_column_to_buffer_enemy
	.globl _draw_column_to_buffer_object
	.globl _draw_column_to_buffer_untextured
	.globl _calculate_cells_in_view
	.globl _cpct_memset
	.globl _offsets_cells_in_view
	.globl _cells_in_view_array
	.globl _g_texturedWalls
	.globl _g_pixelMask
	.globl _g_colors
	.globl _g_palette
	.globl _render_draw_to_buffer
	.globl _draw_minimap_to_buffer
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
;src/Renderer.c:53: void calculate_cells_in_view(){
;	---------------------------------
; Function calculate_cells_in_view
; ---------------------------------
_calculate_cells_in_view::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-14
	add	hl,sp
	ld	sp,hl
;src/Renderer.c:55: u8 offset=0, n=0, j, i;
	ld	-6 (ix),#0x00
	ld	-7 (ix),#0x00
;src/Renderer.c:58: if(player_direction.y!=0){
	ld	hl, #_player_direction + 1
	ld	a,(hl)
	ld	-2 (ix), a
	or	a, a
	jr	Z,00102$
;src/Renderer.c:59: vert=1;
	ld	-14 (ix),#0x01
;src/Renderer.c:60: dy=player_direction.y;
	ld	c,-2 (ix)
	ld	-12 (ix),c
;src/Renderer.c:61: dx=-player_direction.y;
	xor	a, a
	sub	a, -2 (ix)
	ld	-11 (ix), a
;src/Renderer.c:63: x0 = player_position.x-(17*dx);
	ld	hl,#_player_position+0
	ld	c,(hl)
	ld	l,-11 (ix)
	ld	e,l
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	a,c
	sub	a, l
	ld	-10 (ix),a
;src/Renderer.c:64: y0 = player_position.y+(6*dy);
	ld	hl,#_player_position+1
	ld	c,(hl)
	ld	l,-12 (ix)
	ld	e,l
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, bc
	ld	c,l
	jr	00103$
00102$:
;src/Renderer.c:67: vert=0;
	ld	-14 (ix),#0x00
;src/Renderer.c:68: dy=player_direction.x;
	ld	hl, #_player_direction + 0
	ld	a,(hl)
	ld	-2 (ix), a
	ld	-12 (ix),a
;src/Renderer.c:69: dx=player_direction.x;
	ld	a,-2 (ix)
	ld	-11 (ix),a
;src/Renderer.c:71: y0 = player_position.y-(17*dy);
	ld	hl, #_player_position + 1
	ld	c,(hl)
	ld	l,-12 (ix)
	ld	e,l
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	a,c
	sub	a, l
	ld	c,a
;src/Renderer.c:72: x0 = player_position.x+(6*dx);
	ld	hl, #_player_position + 0
	ld	b,(hl)
	ld	a,-2 (ix)
	ld	e,a
	add	a, a
	add	a, e
	add	a, a
	ld	e,a
	ld	l,b
	add	hl, de
	ld	-10 (ix),l
00103$:
;src/Renderer.c:76: x=x0;
	ld	e,-10 (ix)
;src/Renderer.c:77: y=y0;
	ld	-13 (ix),c
;src/Renderer.c:79: for(j=0;j<6;++j){
	ld	a,-11 (ix)
	rlca
	and	a,#0x01
	ld	-2 (ix),a
	ld	a,-12 (ix)
	rlca
	and	a,#0x01
	ld	-3 (ix),a
	ld	-8 (ix),#0x00
;src/Renderer.c:81: for(i=offset;i<35-offset;++i){
00138$:
	ld	a,-7 (ix)
	ld	-1 (ix),a
	ld	a,-6 (ix)
	ld	-9 (ix),a
00125$:
	ld	l,-6 (ix)
	ld	h,#0x00
	ld	a,#0x23
	sub	a, l
	ld	l,a
	ld	a,#0x00
	sbc	a, h
	ld	h,a
	ld	a, -9 (ix)
	ld	d, #0x00
	sub	a, l
	ld	a,d
	sbc	a, h
	jp	PO, 00181$
	xor	a, #0x80
00181$:
	jp	P,00143$
;src/Renderer.c:84: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
	ld	hl,(_cells_in_view_array)
	ld	a,l
	add	a, -1 (ix)
	ld	-5 (ix),a
	ld	a,h
	adc	a, #0x00
	ld	-4 (ix),a
;src/Renderer.c:83: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
	bit	7, e
	jr	NZ,00105$
	ld	a,e
	xor	a, #0x80
	sub	a, #0xA0
	jr	NC,00105$
	bit	7, -13 (ix)
	jr	NZ,00105$
	ld	a,-13 (ix)
	xor	a, #0x80
	sub	a, #0xA0
	jr	NC,00105$
;src/Renderer.c:84: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
	ld	a,e
	ld	d,a
	rla
	sbc	a, a
	ld	b, d
	add	a,#0x60
	ld	d,a
	ld	l,-13 (ix)
	ld	a,-13 (ix)
	rla
	sbc	a, a
	ld	h,a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a,b
	add	a, l
	ld	l,a
	ld	a,d
	adc	a, h
	ld	h,a
	ld	b,(hl)
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	(hl),b
	jr	00106$
00105$:
;src/Renderer.c:87: cells_in_view_array[n]=CELLTYPE_WALL1;
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	(hl),#0x81
00106$:
;src/Renderer.c:91: if(vert){
	ld	a,-14 (ix)
	or	a, a
	jr	Z,00111$
;src/Renderer.c:92: x+=dx;
	ld	a,e
	add	a, -11 (ix)
	ld	e,a
	jr	00112$
00111$:
;src/Renderer.c:95: y+=dy;
	ld	a,-13 (ix)
	add	a, -12 (ix)
	ld	-13 (ix),a
00112$:
;src/Renderer.c:97: ++n;
	inc	-1 (ix)
;src/Renderer.c:81: for(i=offset;i<35-offset;++i){
	inc	-9 (ix)
	jp	00125$
00143$:
	ld	a,-1 (ix)
	ld	-7 (ix),a
;src/Renderer.c:99: offset=offsets_cells_in_view[j];
	ld	a,#<(_offsets_cells_in_view)
	add	a, -8 (ix)
	ld	l,a
	ld	a,#>(_offsets_cells_in_view)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
;src/Renderer.c:103: if(dx<0) x=x0-offset;
	ld	-6 (ix), a
	ld	-5 (ix),a
;src/Renderer.c:101: if(vert){
	ld	a,-14 (ix)
	or	a, a
	jr	Z,00121$
;src/Renderer.c:102: y-=dy;
	ld	a,-13 (ix)
	sub	a, -12 (ix)
	ld	-13 (ix),a
;src/Renderer.c:103: if(dx<0) x=x0-offset;
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00115$
	ld	a,-10 (ix)
	sub	a, -5 (ix)
	ld	e,a
	jr	00128$
00115$:
;src/Renderer.c:104: else x=x0+offset;
	ld	a,-10 (ix)
	add	a, -5 (ix)
	ld	e,a
	jr	00128$
00121$:
;src/Renderer.c:108: x-=dx;
	ld	a,e
	sub	a, -11 (ix)
	ld	e,a
;src/Renderer.c:109: if(dy<0) y=y0-offset;
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00118$
	ld	a,c
	sub	a, -5 (ix)
	ld	-13 (ix),a
	jr	00128$
00118$:
;src/Renderer.c:110: else y=y0+offset;
	ld	a,c
	add	a, -5 (ix)
	ld	-13 (ix),a
00128$:
;src/Renderer.c:79: for(j=0;j<6;++j){
	inc	-8 (ix)
	ld	a,-8 (ix)
	sub	a, #0x06
	jp	C,00138$
	ld	sp, ix
	pop	ix
	ret
_g_palette:
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x0D	; 13
	.db #0x1A	; 26
	.db #0x06	; 6
	.db #0x0F	; 15
	.db #0x01	; 1
	.db #0x09	; 9
	.db #0x19	; 25
	.db #0x03	; 3
	.db #0x12	; 18
	.db #0x05	; 5
	.db #0x0E	; 14
	.db #0x0F	; 15
	.db #0x11	; 17
	.db #0x13	; 19
_g_colors:
	.db #0x00	; 0
	.db #0xC0	; 192
	.db #0x0C	; 12
	.db #0xCC	; 204
	.db #0x30	; 48	'0'
	.db #0xF0	; 240
	.db #0x3C	; 60
	.db #0xFC	; 252
	.db #0x03	; 3
	.db #0xC3	; 195
	.db #0x0F	; 15
	.db #0xCF	; 207
	.db #0x33	; 51	'3'
	.db #0xF3	; 243
	.db #0x3F	; 63
	.db #0xFF	; 255
_g_pixelMask:
	.db #0xAA	; 170
	.db #0x55	; 85	'U'
_g_texturedWalls:
	.db #0x01	; 1
_cells_in_view_array:
	.dw #0x9EA0
_offsets_cells_in_view:
	.db #0x08	; 8
	.db #0x0C	; 12
	.db #0x0E	; 14
	.db #0x0F	; 15
	.db #0x10	; 16
;src/Renderer.c:118: void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
;	---------------------------------
; Function draw_column_to_buffer_untextured
; ---------------------------------
_draw_column_to_buffer_untextured::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;src/Renderer.c:119: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a, 4 (ix)
	srl	a
	ld	c,a
	ld	a,#0x00
	add	a,#0x8B
	ld	b,a
;src/Renderer.c:121: u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
	ld	de,#_g_colors+0
	ld	l,6 (ix)
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	-2 (ix),a
;src/Renderer.c:122: u8 pixMask = g_pixelMask[column&1];
	ld	de,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l,a
	ld	h,#0x00
	add	hl,de
	ld	e,(hl)
;src/Renderer.c:131: if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
	ld	a,#0x64
	sub	a, 5 (ix)
	jr	NC,00102$
	ld	5 (ix),#0x64
00102$:
;src/Renderer.c:133: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
	ld	l,5 (ix)
	srl	l
	ld	a,#0x32
	sub	a, l
;src/Renderer.c:136: pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
	push	de
	ld	e,a
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	pop	de
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:138: j=lineHeight;
	ld	d,5 (ix)
;src/Renderer.c:140: for(j;j;--j){
	ld	a,e
	cpl
	ld	-1 (ix),a
	ld	a,e
	and	a, -2 (ix)
	ld	e,a
00105$:
	ld	a,d
	or	a, a
	jr	Z,00107$
;src/Renderer.c:141: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, -1 (ix)
;src/Renderer.c:143: *pvmem = val|(w_color&pixMask);
	or	a, e
	ld	(bc),a
;src/Renderer.c:145: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:140: for(j;j;--j){
	dec	d
	jr	00105$
00107$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:149: void draw_column_to_buffer_object(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
;	---------------------------------
; Function draw_column_to_buffer_object
; ---------------------------------
_draw_column_to_buffer_object::
;src/Renderer.c:151: }
	ret
;src/Renderer.c:153: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
;	---------------------------------
; Function draw_column_to_buffer_enemy
; ---------------------------------
_draw_column_to_buffer_enemy::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-14
	add	hl,sp
	ld	sp,hl
;src/Renderer.c:170: u16 texture_line=0;
	ld	hl,#0x0000
	ex	(sp), hl
;src/Renderer.c:172: if(texture_column>=4 && texture_column<28){
	ld	a,7 (ix)
	sub	a, #0x04
	jp	C,00112$
	ld	a,7 (ix)
	sub	a, #0x1C
	jp	NC,00112$
;src/Renderer.c:175: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(index-1)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
	ld	c,6 (ix)
	ld	b,#0x00
	dec	bc
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc,#0x7800
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	a, 7 (ix)
	ld	d, #0x00
	add	a,#0xFC
	ld	e,a
	ld	a,d
	adc	a,#0xFF
	ld	d,a
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	-9 (ix),l
	ld	-8 (ix),h
;src/Renderer.c:177: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a,4 (ix)
	srl	a
	add	a, #0x00
	ld	-6 (ix),a
	ld	a,#0x00
	adc	a, #0x8B
	ld	-5 (ix),a
;src/Renderer.c:179: pixMask = g_pixelMask[column&1];
	ld	bc,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l, a
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-7 (ix),a
;src/Renderer.c:181: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
	ld	a,5 (ix)
	srl	a
	add	a, #0x32
	ld	-10 (ix),a
;src/Renderer.c:182: lineHeight = (lineHeight*3)/4;
	ld	c,5 (ix)
	ld	b,#0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	-2 (ix),l
	ld	-1 (ix),h
	ld	a,-2 (ix)
	ld	-4 (ix),a
	ld	a,-1 (ix)
	ld	-3 (ix),a
	bit	7, -1 (ix)
	jr	Z,00114$
	ld	a,-2 (ix)
	add	a, #0x03
	ld	-4 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-3 (ix),a
00114$:
	ld	b,-4 (ix)
	ld	c,-3 (ix)
	sra	c
	rr	b
	sra	c
	rr	b
;src/Renderer.c:183: enemy_top_height = ground_height - lineHeight;
	ld	a,-10 (ix)
	sub	a, b
	ld	c,a
;src/Renderer.c:185: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
	ld	e,b
	ld	d,#0x00
	push	bc
	push	de
	ld	hl,#0x1800
	push	hl
	call	__divsint
	pop	af
	pop	af
	pop	bc
	ld	-12 (ix),l
	ld	-11 (ix),h
;src/Renderer.c:186: j=lineHeight;
	ld	d,b
;src/Renderer.c:188: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
	ld	a,#0x64
	sub	a, b
	jr	NC,00102$
;src/Renderer.c:189: j=90;
	ld	d,#0x5A
00102$:
;src/Renderer.c:192: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
	ld	b,#0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a,-6 (ix)
	add	a, l
	ld	c,a
	ld	a,-5 (ix)
	adc	a, h
	ld	b,a
;src/Renderer.c:194: for(j;j;--j){
	ld	a,-7 (ix)
	cpl
	ld	e,a
00110$:
	ld	a,d
	or	a, a
	jr	Z,00112$
;src/Renderer.c:196: color= *(texture+(texture_line/256));
	ld	l,-13 (ix)
	ld	h,#0x00
	ld	a,-9 (ix)
	add	a, l
	ld	l,a
	ld	a,-8 (ix)
	adc	a, h
	ld	h,a
	ld	a,(hl)
;src/Renderer.c:198: if(color){
	ld	-4 (ix), a
	or	a, a
	jr	Z,00104$
;src/Renderer.c:199: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, e
	ld	l,a
;src/Renderer.c:201: color = (color&pixMask);
	ld	a,-4 (ix)
	and	a, -7 (ix)
;src/Renderer.c:203: *pvmem = val|color;
	or	a, l
	ld	(bc),a
00104$:
;src/Renderer.c:206: texture_line += texture_line_add;
	ld	a,-14 (ix)
	add	a, -12 (ix)
	ld	-14 (ix),a
	ld	a,-13 (ix)
	adc	a, -11 (ix)
	ld	-13 (ix),a
;src/Renderer.c:208: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:194: for(j;j;--j){
	dec	d
	jr	00110$
00112$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:214: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
;	---------------------------------
; Function draw_column_to_buffer
; ---------------------------------
_draw_column_to_buffer::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-15
	add	hl,sp
	ld	sp,hl
;src/Renderer.c:215: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a,4 (ix)
	srl	a
	add	a, #0x00
	ld	-2 (ix),a
	ld	a,#0x00
	adc	a, #0x8B
	ld	-1 (ix),a
;src/Renderer.c:218: u8 pixMask = g_pixelMask[column&1];
	ld	bc,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l, a
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-15 (ix),a
;src/Renderer.c:223: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
	ld	a, 6 (ix)
	add	a, a
	add	a, a
	ld	b,a
	ld	c,#0x00
	ld	hl,#0x6400
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	l,7 (ix)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	-10 (ix),l
	ld	-9 (ix),h
;src/Renderer.c:225: u8 j=lineHeight;
	ld	a,5 (ix)
;src/Renderer.c:231: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
	ld	-11 (ix), a
	ld	-4 (ix),a
	ld	-3 (ix),#0x00
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	hl,#0x2000
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-14 (ix),l
	ld	-13 (ix),h
;src/Renderer.c:232: u16 wall_texture_line=0;
	ld	-8 (ix),#0x00
	ld	-7 (ix),#0x00
;src/Renderer.c:234: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
	ld	c,-11 (ix)
	srl	c
	ld	a,#0x32
	sub	a, c
	ld	-12 (ix),a
;src/Renderer.c:238: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
	ld	a,#0x64
	sub	a, -11 (ix)
	jr	NC,00102$
;src/Renderer.c:239: ceiling_height=0;
	ld	-12 (ix),#0x00
;src/Renderer.c:240: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
	ld	a,-4 (ix)
	add	a,#0x9C
	ld	c,a
	ld	a,-3 (ix)
	adc	a,#0xFF
	ld	b,a
	ld	-6 (ix),c
	ld	-5 (ix),b
	bit	7, b
	jr	Z,00111$
	ld	a,-4 (ix)
	add	a, #0x9D
	ld	-6 (ix),a
	ld	a,-3 (ix)
	adc	a, #0xFF
	ld	-5 (ix),a
00111$:
	ld	c,-6 (ix)
	ld	b,-5 (ix)
	sra	b
	rr	c
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	push	bc
	call	__mulint
	pop	af
	pop	af
	ld	-8 (ix),l
	ld	-7 (ix),h
;src/Renderer.c:241: j=SCREEN_TEXTURE_HEIGHT;
	ld	-11 (ix),#0x64
00102$:
;src/Renderer.c:244: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
	ld	c,-12 (ix)
	ld	b,#0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a,-2 (ix)
	add	a, l
	ld	c,a
	ld	a,-1 (ix)
	adc	a, h
	ld	b,a
;src/Renderer.c:246: for(j;j;--j){
	ld	a,-15 (ix)
	cpl
	ld	-6 (ix),a
	ld	d,-11 (ix)
00107$:
	ld	a,d
	or	a, a
	jr	Z,00109$
;src/Renderer.c:248: w_color = *(texture+(wall_texture_line/256));
	ld	a, -7 (ix)
	ld	h, #0x00
	add	a, -10 (ix)
	ld	l,a
	ld	a,h
	adc	a, -9 (ix)
	ld	h,a
	ld	e,(hl)
;src/Renderer.c:250: if(w_color){
	ld	a,e
	or	a, a
	jr	Z,00104$
;src/Renderer.c:252: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, -6 (ix)
	ld	l,a
;src/Renderer.c:254: w_color = (w_color&pixMask);
	ld	a,e
	and	a, -15 (ix)
;src/Renderer.c:256: *pvmem = val|w_color;
	or	a, l
	ld	(bc),a
00104$:
;src/Renderer.c:260: wall_texture_line += wall_texture_line_add;
	ld	a,-8 (ix)
	add	a, -14 (ix)
	ld	-8 (ix),a
	ld	a,-7 (ix)
	adc	a, -13 (ix)
	ld	-7 (ix),a
;src/Renderer.c:262: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:246: for(j;j;--j){
	dec	d
	jr	00107$
00109$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:266: void render_draw_to_buffer(){//TODO Optimize
;	---------------------------------
; Function render_draw_to_buffer
; ---------------------------------
_render_draw_to_buffer::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-58
	add	hl,sp
	ld	sp,hl
;src/Renderer.c:276: u8 zHeight = 5;
	ld	-56 (ix),#0x05
;src/Renderer.c:282: u8 offsetDiff = 16;
	ld	-50 (ix),#0x10
;src/Renderer.c:287: u8 lineStart = 0;
	ld	-52 (ix),#0x00
;src/Renderer.c:289: u8 lateralWallWidth=0;
	ld	-53 (ix),#0x00
;src/Renderer.c:301: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
	ld	hl, #_g_colors + 6
	ld	b,(hl)
	ld	hl,#0x07A8
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x8B00
	push	hl
	call	_cpct_memset
;src/Renderer.c:302: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
	ld	hl, #_g_colors + 1
	ld	b,(hl)
	ld	hl,#0x0050
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x92A8
	push	hl
	call	_cpct_memset
;src/Renderer.c:303: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
	ld	hl, #_g_colors + 7
	ld	b,(hl)
	ld	hl,#0x07A8
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x92F8
	push	hl
	call	_cpct_memset
;src/Renderer.c:305: calculate_cells_in_view();
	call	_calculate_cells_in_view
;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-24 (ix),l
	ld	-23 (ix),h
;src/Renderer.c:307: if(g_texturedWalls){
	ld	a,(#_g_texturedWalls + 0)
	or	a, a
	jp	Z,00358$
;src/Renderer.c:309: do{
	ld	-58 (ix),#0x06
00175$:
;src/Renderer.c:311: --z;
	dec	-58 (ix)
;src/Renderer.c:315: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-56 (ix)
	srl	a
	ld	-18 (ix),a
	ld	a,-58 (ix)
	or	a, a
	jr	Z,00262$
	ld	c,-18 (ix)
	jr	00263$
00262$:
	ld	c,#0x00
00263$:
	ld	-15 (ix),c
;src/Renderer.c:316: lateralWallSlope=0;
	ld	-13 (ix),#0x00
;src/Renderer.c:317: lateralWallSlopeCounter=0;
	ld	-5 (ix),#0x00
;src/Renderer.c:318: xHeight=0;
	ld	-32 (ix),#0x00
;src/Renderer.c:320: lateralWallCounter = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:322: newCell=1;
	ld	-37 (ix),#0x01
;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
	ld	a,-52 (ix)
	ld	-30 (ix),a
	ld	-29 (ix),#0x00
	ld	c,-30 (ix)
	ld	b,-29 (ix)
	inc	bc
	ld	l,-24 (ix)
	ld	h,-23 (ix)
	add	hl,bc
	ld	a,(hl)
	ld	-38 (ix),a
;src/Renderer.c:325: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
	ld	a,-24 (ix)
	add	a, -52 (ix)
	ld	l,a
	ld	a,-23 (ix)
	adc	a, #0x00
	ld	h,a
	ld	c,(hl)
;src/Renderer.c:326: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00102$
;src/Renderer.c:327: lastWallId=lastCellWasWall;
	ld	-34 (ix),c
;src/Renderer.c:328: lastCellWasWall=1;
	ld	-31 (ix),#0x01
	jr	00296$
00102$:
;src/Renderer.c:331: lastCellWasWall=0;
	ld	-31 (ix),#0x00
;src/Renderer.c:332: lastWallId=CELLTYPE_FLOOR;
	ld	-34 (ix),#0x00
;src/Renderer.c:335: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
00296$:
	ld	-54 (ix),#0x00
	ld	-57 (ix),#0x00
00252$:
;src/Renderer.c:337: if (xCellCount == zHeight)
	ld	a,-56 (ix)
	sub	a, -15 (ix)
	jr	NZ,00105$
;src/Renderer.c:339: ++xCell;
	inc	-54 (ix)
;src/Renderer.c:340: xCellCount = 0;
	ld	-15 (ix),#0x00
;src/Renderer.c:341: newCell=1;
	ld	-37 (ix),#0x01
;src/Renderer.c:342: currentCellID=cells_in_view_array[xCell + lineStart + 1];
	ld	a,-54 (ix)
	ld	-26 (ix),a
	ld	-25 (ix),#0x00
	ld	a,-30 (ix)
	add	a, -26 (ix)
	ld	-26 (ix),a
	ld	a,-29 (ix)
	adc	a, -25 (ix)
	ld	-25 (ix),a
	inc	-26 (ix)
	jr	NZ,00608$
	inc	-25 (ix)
00608$:
	ld	a,-24 (ix)
	add	a, -26 (ix)
	ld	-26 (ix),a
	ld	a,-23 (ix)
	adc	a, -25 (ix)
	ld	-25 (ix),a
	ld	l,-26 (ix)
	ld	h,-25 (ix)
	ld	a,(hl)
	ld	-38 (ix),a
00105$:
;src/Renderer.c:344: if(!(x%2)){
	ld	a,-57 (ix)
	and	a, #0x01
	ld	-26 (ix),a
;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-38 (ix)
	and	a, #0x80
	ld	-33 (ix),a
;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-15 (ix)
	ld	-40 (ix),a
	ld	-39 (ix),#0x00
	ld	a,-56 (ix)
	ld	-14 (ix),a
;src/Renderer.c:344: if(!(x%2)){
	ld	a,-26 (ix)
	or	a, a
	jp	NZ,00118$
;src/Renderer.c:345: if ((lateralWallCounter == 0)||newCell)
	ld	a,-41 (ix)
	or	a, a
	jr	Z,00114$
	ld	a,-37 (ix)
	or	a, a
	jp	Z,00118$
00114$:
;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-33 (ix)
	or	a, a
	jr	Z,00112$
;src/Renderer.c:349: lateralWallCounter = 0;//(zHeight - xCellCount);
	ld	-41 (ix),#0x00
;src/Renderer.c:350: lateralWallSlope = 0;
	ld	-13 (ix),#0x00
;src/Renderer.c:351: xHeight = zHeight;
	ld	a,-56 (ix)
	ld	-32 (ix),a
;src/Renderer.c:352: color = currentCellID&0b01111111;
	ld	a,-38 (ix)
	and	a, #0x7F
	ld	-8 (ix),a
;src/Renderer.c:353: lastCellWasWall = 1;
	ld	-31 (ix),#0x01
;src/Renderer.c:354: lastWallId=currentCellID;
	ld	a,-38 (ix)
	ld	-34 (ix),a
	jr	00113$
00112$:
;src/Renderer.c:357: if(lateralWallCounter==0){//Lateral wall not finished
	ld	a,-41 (ix)
	or	a, a
	jr	NZ,00113$
;src/Renderer.c:358: if (lastCellWasWall)
	ld	a,-31 (ix)
	or	a, a
	jr	Z,00107$
;src/Renderer.c:361: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-50 (ix)
	sub	a, -54 (ix)
	add	a, a
	inc	a
;src/Renderer.c:362: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-13 (ix), a
	srl	a
	ld	-5 (ix),a
;src/Renderer.c:363: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-56 (ix)
	ld	h,-13 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00609$:
	add	hl,hl
	jr	NC,00610$
	add	hl,de
00610$:
	djnz	00609$
;src/Renderer.c:364: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
	ld	a,l
	and	a, #0xFC
	set	0, a
	srl	a
	srl	a
	sub	a, -15 (ix)
;src/Renderer.c:365: lateralWallWidth=lateralWallCounter;
	ld	-41 (ix), a
	ld	-53 (ix),a
;src/Renderer.c:366: lastCellWasWall = 0;
	ld	-31 (ix),#0x00
;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	l,-40 (ix)
	ld	h,-39 (ix)
	add	hl, hl
	ld	c,-13 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-14 (ix)
	sub	a, l
	ld	-32 (ix),a
;src/Renderer.c:368: color = lastWallId&0b01111111;
	ld	a,-34 (ix)
	and	a, #0x7F
	ld	-8 (ix),a
	jr	00113$
00107$:
;src/Renderer.c:372: xHeight = 0;
	ld	-32 (ix),#0x00
;src/Renderer.c:373: lastCellWasWall = 0;
	ld	-31 (ix),#0x00
;src/Renderer.c:374: lateralWallSlope=0;
	ld	-13 (ix),#0x00
;src/Renderer.c:375: lastWallId=0;
	ld	-34 (ix),#0x00
00113$:
;src/Renderer.c:379: newCell=0;
	ld	-37 (ix),#0x00
00118$:
;src/Renderer.c:382: if (lateralWallCounter > 0)
	ld	a,-41 (ix)
	or	a, a
	jr	Z,00124$
;src/Renderer.c:385: if (lateralWallSlope != 0)
	ld	a,-13 (ix)
	or	a, a
	jr	Z,00122$
;src/Renderer.c:387: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-5 (ix)
	sub	a, -13 (ix)
	jr	NZ,00120$
;src/Renderer.c:389: lateralWallSlopeCounter = 0;
	ld	-5 (ix),#0x00
;src/Renderer.c:390: xHeight -= 2;
	dec	-32 (ix)
	dec	-32 (ix)
00120$:
;src/Renderer.c:392: ++lateralWallSlopeCounter;
	inc	-5 (ix)
00122$:
;src/Renderer.c:395: --lateralWallCounter;
	dec	-41 (ix)
00124$:
;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-56 (ix)
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
;src/Renderer.c:398: if (!(x%2))
	ld	a,-26 (ix)
	or	a, a
	jp	NZ,00136$
;src/Renderer.c:408: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	ld	b,-57 (ix)
	srl	b
;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	l,-40 (ix)
	ld	h,-39 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	ld	e,-2 (ix)
	ld	d,-1 (ix)
	push	de
	push	hl
	call	__divsint
	pop	af
	pop	af
	pop	bc
	ld	c,l
;src/Renderer.c:400: if(xHeight > 0){
	ld	a,-32 (ix)
	or	a, a
	jr	Z,00129$
;src/Renderer.c:401: if (lateralWallCounter > 0)
	ld	a,-41 (ix)
	or	a, a
	jr	Z,00126$
;src/Renderer.c:403: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
	ld	e,-53 (ix)
	ld	d,#0x00
	ld	l,-41 (ix)
	ld	h,#0x00
	ld	a,e
	sub	a, l
	ld	l,a
	ld	a,d
	sbc	a, h
	ld	h,a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	push	de
	push	hl
	call	__divsint
	pop	af
	pop	af
	pop	bc
	ld	d,l
	jr	00127$
00126$:
;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	d,c
00127$:
;src/Renderer.c:408: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	push	bc
	push	de
	inc	sp
	ld	h,-8 (ix)
	ld	l,-32 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer
	pop	af
	pop	af
	pop	bc
00129$:
;src/Renderer.c:410: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-33 (ix)
	or	a, a
	jr	NZ,00136$
;src/Renderer.c:411: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-38 (ix)
	and	a, #0x0F
	jr	Z,00136$
;src/Renderer.c:412: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	a,c
	push	af
	inc	sp
	ld	h,-38 (ix)
	ld	l,-56 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:414: else if(currentCellID&CELL_ITEM_MASK){
00136$:
;src/Renderer.c:420: ++xCellCount;
	inc	-15 (ix)
;src/Renderer.c:335: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	inc	-57 (ix)
;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-24 (ix),l
	ld	-23 (ix),h
;src/Renderer.c:335: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	ld	a,-57 (ix)
	sub	a, #0x50
	jp	C,00252$
;src/Renderer.c:427: xCellCount = (z) ? (zHeight >> 1) : 0 ;
	ld	a,-58 (ix)
	or	a, a
	jr	Z,00264$
	ld	c,-18 (ix)
	jr	00265$
00264$:
	ld	c,#0x00
00265$:
	ld	-40 (ix),c
;src/Renderer.c:428: lateralWallSlope=0;
	ld	-33 (ix),#0x00
;src/Renderer.c:429: lateralWallSlopeCounter=0;
	ld	-26 (ix),#0x00
;src/Renderer.c:430: xHeight=0;
	ld	-31 (ix),#0x00
;src/Renderer.c:432: lateralWallCounter = 0;
	ld	-34 (ix),#0x00
;src/Renderer.c:433: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	a,-50 (ix)
	add	a, a
	ld	c,a
	ld	a,-52 (ix)
	add	a, c
	ld	-38 (ix), a
	ld	c, a
	inc	c
	inc	c
;src/Renderer.c:435: newCell=1;
	ld	-30 (ix),#0x01
;src/Renderer.c:436: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	-36 (ix),c
	ld	-35 (ix),#0x00
	ld	e,-36 (ix)
	ld	d,-35 (ix)
	dec	de
	ld	l,-24 (ix)
	ld	h,-23 (ix)
	add	hl,de
	ld	a,(hl)
	ld	-37 (ix),a
;src/Renderer.c:438: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
	ld	l,-24 (ix)
	ld	h,-23 (ix)
	ld	b,#0x00
	add	hl, bc
	ld	c,(hl)
;src/Renderer.c:439: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00139$
;src/Renderer.c:440: lastWallId=lastCellWasWall;
	ld	-41 (ix),c
;src/Renderer.c:441: lastCellWasWall=1;
	ld	-32 (ix),#0x01
	jr	00315$
00139$:
;src/Renderer.c:444: lastCellWasWall=0;
	ld	-32 (ix),#0x00
;src/Renderer.c:445: lastWallId=CELLTYPE_FLOOR;
	ld	-41 (ix),#0x00
;src/Renderer.c:448: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
00315$:
	ld	-54 (ix),#0x00
	ld	-57 (ix),#0x9F
00254$:
;src/Renderer.c:451: if (xCellCount == zHeight)
	ld	a,-56 (ix)
	sub	a, -40 (ix)
	jr	NZ,00142$
;src/Renderer.c:453: ++xCell;
	inc	-54 (ix)
;src/Renderer.c:454: xCellCount = 0;
	ld	-40 (ix),#0x00
;src/Renderer.c:455: newCell=1;
	ld	-30 (ix),#0x01
;src/Renderer.c:456: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
	ld	a,-54 (ix)
	ld	-28 (ix),a
	ld	-27 (ix),#0x00
	ld	a,-36 (ix)
	sub	a, -28 (ix)
	ld	-28 (ix),a
	ld	a,-35 (ix)
	sbc	a, -27 (ix)
	ld	-27 (ix),a
	ld	l,-28 (ix)
	ld	h,-27 (ix)
	dec	hl
	ld	-28 (ix),l
	ld	-27 (ix),h
	ld	a,-24 (ix)
	add	a, -28 (ix)
	ld	-28 (ix),a
	ld	a,-23 (ix)
	adc	a, -27 (ix)
	ld	-27 (ix),a
	ld	l,-28 (ix)
	ld	h,-27 (ix)
	ld	a,(hl)
	ld	-37 (ix),a
00142$:
;src/Renderer.c:458: if(!(x%2)){
	ld	a,-57 (ix)
	and	a, #0x01
	ld	-28 (ix),a
;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-37 (ix)
	and	a, #0x80
	ld	-5 (ix),a
;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-40 (ix)
	ld	-22 (ix),a
	ld	-21 (ix),#0x00
;src/Renderer.c:458: if(!(x%2)){
	ld	a,-28 (ix)
	or	a, a
	jp	NZ,00155$
;src/Renderer.c:459: if (lateralWallCounter == 0 || newCell)
	ld	a,-34 (ix)
	or	a, a
	jr	Z,00151$
	ld	a,-30 (ix)
	or	a, a
	jp	Z,00155$
00151$:
;src/Renderer.c:461: if ( currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-5 (ix)
	or	a, a
	jr	Z,00149$
;src/Renderer.c:463: lateralWallCounter = 0;
	ld	-34 (ix),#0x00
;src/Renderer.c:464: lateralWallSlope = 0;
	ld	-33 (ix),#0x00
;src/Renderer.c:465: xHeight = zHeight;
	ld	a,-56 (ix)
	ld	-31 (ix),a
;src/Renderer.c:466: color = currentCellID&0b01111111;
	ld	a,-37 (ix)
	and	a, #0x7F
	ld	-8 (ix),a
;src/Renderer.c:467: lastCellWasWall = 1;
	ld	-32 (ix),#0x01
;src/Renderer.c:468: lastWallId=currentCellID;
	ld	a,-37 (ix)
	ld	-41 (ix),a
	jp	00150$
00149$:
;src/Renderer.c:470: else if(lateralWallCounter==0){
	ld	a,-34 (ix)
	or	a, a
	jp	NZ,00150$
;src/Renderer.c:471: if (lastCellWasWall)
	ld	a,-32 (ix)
	or	a, a
	jr	Z,00144$
;src/Renderer.c:474: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-50 (ix)
	sub	a, -54 (ix)
	add	a, a
	inc	a
;src/Renderer.c:475: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-33 (ix), a
	srl	a
	ld	-26 (ix),a
;src/Renderer.c:476: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-56 (ix)
	ld	h,-33 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00617$:
	add	hl,hl
	jr	NC,00618$
	add	hl,de
00618$:
	djnz	00617$
;src/Renderer.c:477: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
	ld	c,l
	ld	b,#0x00
	ld	a,l
	and	a, #0x03
	ld	e,a
	ld	d,#0x00
	ld	a,c
	sub	a, e
	ld	c,a
	ld	a,b
	sbc	a, d
	ld	b,a
	ld	e, c
	ld	d, b
	inc	de
	ld	l, e
	ld	h, d
	bit	7, d
	jr	Z,00266$
	ld	hl,#0x0004
	add	hl,bc
00266$:
	sra	h
	rr	l
	sra	h
	rr	l
	ld	c,-40 (ix)
	ld	a,l
	sub	a, c
;src/Renderer.c:478: lateralWallWidth=lateralWallCounter;
	ld	-34 (ix), a
	ld	-53 (ix),a
;src/Renderer.c:479: lastCellWasWall = 0;
	ld	-32 (ix),#0x00
;src/Renderer.c:480: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
	ld	l,-22 (ix)
	ld	h,-21 (ix)
	add	hl, hl
	ld	c,-33 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-14 (ix)
	sub	a, l
	ld	-31 (ix),a
;src/Renderer.c:481: color = lastWallId&0b01111111;
	ld	a,-41 (ix)
	and	a, #0x7F
	ld	-8 (ix),a
	jr	00150$
00144$:
;src/Renderer.c:485: xHeight = 0;
	ld	-31 (ix),#0x00
;src/Renderer.c:486: lastCellWasWall = 0;
	ld	-32 (ix),#0x00
;src/Renderer.c:487: lateralWallSlope=0;
	ld	-33 (ix),#0x00
;src/Renderer.c:488: lastWallId=0;
	ld	-41 (ix),#0x00
00150$:
;src/Renderer.c:491: newCell=0;
	ld	-30 (ix),#0x00
00155$:
;src/Renderer.c:496: if (lateralWallCounter > 0)
	ld	a,-34 (ix)
	or	a, a
	jr	Z,00161$
;src/Renderer.c:499: if (lateralWallSlope != 0)
	ld	a,-33 (ix)
	or	a, a
	jr	Z,00159$
;src/Renderer.c:501: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-33 (ix)
	sub	a, -26 (ix)
	jr	NZ,00157$
;src/Renderer.c:503: lateralWallSlopeCounter = 0;
	ld	-26 (ix),#0x00
;src/Renderer.c:504: xHeight -= 2;
	dec	-31 (ix)
	dec	-31 (ix)
00157$:
;src/Renderer.c:506: ++lateralWallSlopeCounter;
	inc	-26 (ix)
00159$:
;src/Renderer.c:508: --lateralWallCounter;
	dec	-34 (ix)
00161$:
;src/Renderer.c:512: if (!(x%2))
	ld	a,-28 (ix)
	or	a, a
	jp	NZ,00173$
;src/Renderer.c:525: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	ld	a,-57 (ix)
	srl	a
	ld	-28 (ix),a
;src/Renderer.c:522: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-2 (ix)
	sub	a, -22 (ix)
	ld	-22 (ix),a
	ld	a,-1 (ix)
	sbc	a, -21 (ix)
	ld	-21 (ix),a
	ld	a,#0x05+1
	jr	00622$
00621$:
	sla	-22 (ix)
	rl	-21 (ix)
00622$:
	dec	a
	jr	NZ,00621$
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-22 (ix)
	ld	h,-21 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-21 (ix),h
	ld	-22 (ix), l
	ld	-22 (ix), l
;src/Renderer.c:515: if(xHeight > 0){
	ld	a,-31 (ix)
	or	a, a
	jr	Z,00166$
;src/Renderer.c:517: if (lateralWallCounter > 0)
	ld	a,-34 (ix)
	or	a, a
	jr	Z,00163$
;src/Renderer.c:519: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
	ld	a,-34 (ix)
	ld	-20 (ix),a
	ld	-19 (ix),#0x00
	ld	a,#0x05+1
	jr	00624$
00623$:
	sla	-20 (ix)
	rl	-19 (ix)
00624$:
	dec	a
	jr	NZ,00623$
	ld	a,-53 (ix)
	ld	-17 (ix),a
	ld	-16 (ix),#0x00
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	b,l
	jr	00164$
00163$:
;src/Renderer.c:522: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	b,-22 (ix)
00164$:
;src/Renderer.c:525: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	push	bc
	inc	sp
	ld	h,-8 (ix)
	ld	l,-31 (ix)
	push	hl
	ld	a,-28 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer
	pop	af
	pop	af
00166$:
;src/Renderer.c:528: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-5 (ix)
	or	a, a
	jr	NZ,00173$
;src/Renderer.c:529: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-37 (ix)
	and	a, #0x0F
	jr	Z,00173$
;src/Renderer.c:530: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	h,-22 (ix)
	ld	l,-37 (ix)
	push	hl
	ld	h,-56 (ix)
	ld	l,-28 (ix)
	push	hl
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:532: else if(currentCellID&CELL_ITEM_MASK){
00173$:
;src/Renderer.c:537: ++xCellCount;
	inc	-40 (ix)
;src/Renderer.c:448: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	dec	-57 (ix)
;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-24 (ix),l
	ld	-23 (ix),h
;src/Renderer.c:448: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	ld	a,-57 (ix)
	sub	a, #0x50
	jp	NC,00254$
;src/Renderer.c:544: lineStart = lineStart + (offsetDiff * 2) + 3;
	ld	a,-38 (ix)
	add	a, #0x03
	ld	-52 (ix),a
;src/Renderer.c:545: zHeight += zHeight;
	sla	-56 (ix)
;src/Renderer.c:546: offsetDiff = offsetDiff >> 1;
	srl	-50 (ix)
;src/Renderer.c:548: }while(z);
	ld	a,-58 (ix)
	or	a, a
	jp	NZ,00175$
	jp	00260$
;src/Renderer.c:553: do{
00358$:
	ld	-58 (ix),#0x06
00246$:
;src/Renderer.c:555: --z;
	dec	-58 (ix)
;src/Renderer.c:315: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-56 (ix)
	srl	a
	ld	-17 (ix),a
;src/Renderer.c:559: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-58 (ix)
	or	a, a
	jr	Z,00267$
	ld	c,-17 (ix)
	jr	00268$
00267$:
	ld	c,#0x00
00268$:
	ld	-55 (ix),c
;src/Renderer.c:560: lateralWallSlope=0;
	ld	-44 (ix),#0x00
;src/Renderer.c:561: lateralWallSlopeCounter=0;
	ld	-49 (ix),#0x00
;src/Renderer.c:562: xHeight=0;
	ld	-42 (ix),#0x00
;src/Renderer.c:564: lateralWallCounter = 0;
	ld	-20 (ix),#0x00
;src/Renderer.c:566: newCell=1;
	ld	-46 (ix),#0x01
;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
	ld	a,-52 (ix)
	ld	-22 (ix),a
	ld	-21 (ix),#0x00
;src/Renderer.c:567: currentCellID = cells_in_view_array[lineStart + 1];
	ld	c,-22 (ix)
	ld	b,-21 (ix)
	inc	bc
	ld	l,-24 (ix)
	ld	h,-23 (ix)
	add	hl,bc
	ld	a,(hl)
	ld	-47 (ix),a
;src/Renderer.c:569: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
	ld	a,-24 (ix)
	add	a, -52 (ix)
	ld	l,a
	ld	a,-23 (ix)
	adc	a, #0x00
	ld	h,a
	ld	c,(hl)
;src/Renderer.c:570: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00179$
;src/Renderer.c:571: lastWallId=lastCellWasWall;
	ld	-45 (ix),c
;src/Renderer.c:572: lastCellWasWall=1;
	ld	-28 (ix),#0x01
	jr	00336$
00179$:
;src/Renderer.c:575: lastCellWasWall=0;
	ld	-28 (ix),#0x00
;src/Renderer.c:576: lastWallId=CELLTYPE_FLOOR;
	ld	-45 (ix),#0x00
;src/Renderer.c:579: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
00336$:
	ld	-54 (ix),#0x00
	ld	-57 (ix),#0x00
00256$:
;src/Renderer.c:581: if (xCellCount == zHeight)
	ld	a,-55 (ix)
	sub	a, -56 (ix)
	jr	NZ,00182$
;src/Renderer.c:583: ++xCell;
	inc	-54 (ix)
;src/Renderer.c:584: xCellCount = 0;
	ld	-55 (ix),#0x00
;src/Renderer.c:585: newCell=1;
	ld	-46 (ix),#0x01
;src/Renderer.c:586: currentCellID=cells_in_view_array[xCell + lineStart + 1];
	ld	a,-54 (ix)
	ld	-36 (ix),a
	ld	-35 (ix),#0x00
	ld	a,-22 (ix)
	add	a, -36 (ix)
	ld	-36 (ix),a
	ld	a,-21 (ix)
	adc	a, -35 (ix)
	ld	-35 (ix),a
	inc	-36 (ix)
	jr	NZ,00629$
	inc	-35 (ix)
00629$:
	ld	a,-36 (ix)
	add	a, -24 (ix)
	ld	-36 (ix),a
	ld	a,-35 (ix)
	adc	a, -23 (ix)
	ld	-35 (ix),a
	ld	l,-36 (ix)
	ld	h,-35 (ix)
	ld	a,(hl)
	ld	-47 (ix),a
00182$:
;src/Renderer.c:588: if(!(x%2)){
	ld	a,-57 (ix)
	and	a, #0x01
	ld	-36 (ix),a
;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-47 (ix)
	and	a, #0x80
	ld	-2 (ix),a
;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-55 (ix)
	ld	-40 (ix),a
	ld	-39 (ix),#0x00
	ld	a,-56 (ix)
	ld	-8 (ix),a
;src/Renderer.c:588: if(!(x%2)){
	ld	a,-36 (ix)
	or	a, a
	jp	NZ,00195$
;src/Renderer.c:589: if ((lateralWallCounter == 0)||newCell)
	ld	a,-20 (ix)
	or	a, a
	jr	Z,00191$
	ld	a,-46 (ix)
	or	a, a
	jp	Z,00195$
00191$:
;src/Renderer.c:591: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00189$
;src/Renderer.c:593: lateralWallCounter = 0;//(zHeight - xCellCount);
	ld	-20 (ix),#0x00
;src/Renderer.c:594: lateralWallSlope = 0;
	ld	-44 (ix),#0x00
;src/Renderer.c:595: xHeight = zHeight;
	ld	a,-56 (ix)
	ld	-42 (ix),a
;src/Renderer.c:596: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
	ld	a,-47 (ix)
	sub	a, #0x80
	jr	NZ,00269$
	ld	c,#0x0C
	jr	00270$
00269$:
	ld	c,#0x0E
00270$:
	ld	-48 (ix),c
;src/Renderer.c:597: lastCellWasWall = 1;
	ld	-28 (ix),#0x01
;src/Renderer.c:598: lastWallId=currentCellID;
	ld	a,-47 (ix)
	ld	-45 (ix),a
	jp	00190$
00189$:
;src/Renderer.c:601: if(lateralWallCounter==0){//Lateral wall not finished
	ld	a,-20 (ix)
	or	a, a
	jp	NZ,00190$
;src/Renderer.c:602: if (lastCellWasWall)
	ld	a,-28 (ix)
	or	a, a
	jp	Z,00184$
;src/Renderer.c:605: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-50 (ix)
	sub	a, -54 (ix)
	add	a, a
	inc	a
;src/Renderer.c:606: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-44 (ix), a
	srl	a
	ld	-49 (ix),a
;src/Renderer.c:607: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-56 (ix)
	ld	h,-44 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00632$:
	add	hl,hl
	jr	NC,00633$
	add	hl,de
00633$:
	djnz	00632$
	ld	-14 (ix), l
	ld	a, l
;src/Renderer.c:608: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
	ld	-43 (ix), a
	and	a, #0xFC
	ld	-14 (ix), a
	set	0, a
	ld	-14 (ix), a
	srl	a
	srl	a
	sub	a, -55 (ix)
	ld	-20 (ix),a
;src/Renderer.c:610: lastCellWasWall = 0;
	ld	-28 (ix),#0x00
;src/Renderer.c:611: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-40 (ix)
	ld	-26 (ix),a
	ld	a,-39 (ix)
	ld	-25 (ix),a
	sla	-26 (ix)
	rl	-25 (ix)
	ld	a,-44 (ix)
	ld	-30 (ix),a
	ld	-29 (ix),#0x00
	ld	l,-30 (ix)
	ld	h,-29 (ix)
	push	hl
	ld	l,-26 (ix)
	ld	h,-25 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-25 (ix),h
	ld	-26 (ix), l
	ld	-14 (ix), l
	ld	a,-8 (ix)
	sub	a, -14 (ix)
	ld	-42 (ix),a
;src/Renderer.c:612: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
	ld	a,-45 (ix)
	sub	a, #0x80
	jr	NZ,00271$
	ld	c,#0x0F
	jr	00272$
00271$:
	ld	c,#0x0D
00272$:
	ld	-48 (ix),c
	jr	00190$
00184$:
;src/Renderer.c:616: xHeight = 0;
	ld	-42 (ix),#0x00
;src/Renderer.c:617: lastCellWasWall = 0;
	ld	-28 (ix),#0x00
;src/Renderer.c:618: lateralWallSlope=0;
	ld	-44 (ix),#0x00
;src/Renderer.c:619: lastWallId=0;
	ld	-45 (ix),#0x00
00190$:
;src/Renderer.c:623: newCell=0;
	ld	-46 (ix),#0x00
00195$:
;src/Renderer.c:626: if (lateralWallCounter > 0)
	ld	a,-20 (ix)
	or	a, a
	jr	Z,00201$
;src/Renderer.c:629: if (lateralWallSlope != 0)
	ld	a,-44 (ix)
	or	a, a
	jr	Z,00199$
;src/Renderer.c:631: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-44 (ix)
	sub	a, -49 (ix)
	jr	NZ,00197$
;src/Renderer.c:633: lateralWallSlopeCounter = 0;
	ld	-49 (ix),#0x00
;src/Renderer.c:634: xHeight -= 2;
	dec	-42 (ix)
	dec	-42 (ix)
00197$:
;src/Renderer.c:636: ++lateralWallSlopeCounter;
	inc	-49 (ix)
00199$:
;src/Renderer.c:639: --lateralWallCounter;
	dec	-20 (ix)
00201$:
;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-56 (ix)
	ld	-26 (ix),a
	ld	-25 (ix),#0x00
;src/Renderer.c:642: if (!(x%2))
	ld	a,-36 (ix)
	or	a, a
	jr	NZ,00210$
;src/Renderer.c:645: draw_column_to_buffer_untextured(x/2, xHeight, color);
	ld	a,-57 (ix)
	srl	a
	ld	-36 (ix),a
;src/Renderer.c:644: if(xHeight > 0){
	ld	a,-42 (ix)
	or	a, a
	jr	Z,00203$
;src/Renderer.c:645: draw_column_to_buffer_untextured(x/2, xHeight, color);
	ld	h,-48 (ix)
	ld	l,-42 (ix)
	push	hl
	ld	a,-36 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer_untextured
	pop	af
	inc	sp
00203$:
;src/Renderer.c:648: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-2 (ix)
	or	a, a
	jr	NZ,00210$
;src/Renderer.c:649: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-47 (ix)
	and	a, #0x0F
	jr	Z,00210$
;src/Renderer.c:650: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	a,-40 (ix)
	ld	-2 (ix),a
	ld	a,-39 (ix)
	ld	-1 (ix),a
	ld	a,#0x05+1
	jr	00642$
00641$:
	sla	-2 (ix)
	rl	-1 (ix)
00642$:
	dec	a
	jr	NZ,00641$
	ld	l,-26 (ix)
	ld	h,-25 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-1 (ix),h
	ld	-2 (ix), l
	ld	b, l
	push	bc
	inc	sp
	ld	h,-47 (ix)
	ld	l,-56 (ix)
	push	hl
	ld	a,-36 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:652: else if(currentCellID&CELL_ITEM_MASK){
00210$:
;src/Renderer.c:658: ++xCellCount;
	inc	-55 (ix)
;src/Renderer.c:579: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	inc	-57 (ix)
;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-24 (ix),l
	ld	-23 (ix),h
;src/Renderer.c:579: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	ld	a,-57 (ix)
	sub	a, #0x50
	jp	C,00256$
;src/Renderer.c:665: xCellCount = (z) ? (zHeight >> 1) : 0 ;
	ld	a,-58 (ix)
	or	a, a
	jr	Z,00273$
	ld	a,-17 (ix)
	ld	-17 (ix),a
	jr	00274$
00273$:
	ld	-17 (ix),#0x00
00274$:
	ld	a,-17 (ix)
	ld	-17 (ix),a
;src/Renderer.c:666: lateralWallSlope=0;
	ld	-20 (ix),#0x00
;src/Renderer.c:667: lateralWallSlopeCounter=0;
	ld	-22 (ix),#0x00
;src/Renderer.c:668: xHeight=0;
	ld	-28 (ix),#0x00
;src/Renderer.c:670: lateralWallCounter = 0;
	ld	-36 (ix),#0x00
;src/Renderer.c:433: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	a,-50 (ix)
	add	a, a
	ld	-2 (ix),a
	ld	a,-52 (ix)
	add	a, -2 (ix)
;src/Renderer.c:671: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	-2 (ix), a
	add	a, #0x02
	ld	-51 (ix),a
;src/Renderer.c:673: newCell=1;
	ld	-14 (ix),#0x01
;src/Renderer.c:436: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	a,-51 (ix)
	ld	-40 (ix),a
	ld	-39 (ix),#0x00
;src/Renderer.c:674: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	a,-40 (ix)
	add	a,#0xFF
	ld	-30 (ix),a
	ld	a,-39 (ix)
	adc	a,#0xFF
	ld	-29 (ix),a
	ld	a,-24 (ix)
	add	a, -30 (ix)
	ld	-30 (ix),a
	ld	a,-23 (ix)
	adc	a, -29 (ix)
	ld	-29 (ix),a
	ld	l,-30 (ix)
	ld	h,-29 (ix)
	ld	a,(hl)
	ld	-33 (ix),a
;src/Renderer.c:676: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
	ld	a,-24 (ix)
	add	a, -51 (ix)
	ld	-30 (ix),a
	ld	a,-23 (ix)
	adc	a, #0x00
	ld	-29 (ix),a
	ld	l,-30 (ix)
	ld	h,-29 (ix)
	ld	a,(hl)
	ld	-31 (ix),a
;src/Renderer.c:677: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, -31 (ix)
	jr	Z,00213$
;src/Renderer.c:678: lastWallId=lastCellWasWall;
;src/Renderer.c:679: lastCellWasWall=1;
	ld	-34 (ix),#0x01
	jr	00356$
00213$:
;src/Renderer.c:682: lastCellWasWall=0;
	ld	-34 (ix),#0x00
;src/Renderer.c:683: lastWallId=CELLTYPE_FLOOR;
	ld	-31 (ix),#0x00
;src/Renderer.c:686: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
00356$:
	ld	-54 (ix),#0x00
	ld	-57 (ix),#0x9F
00258$:
;src/Renderer.c:689: if (xCellCount == zHeight)
	ld	a,-56 (ix)
	sub	a, -17 (ix)
	jr	NZ,00216$
;src/Renderer.c:691: ++xCell;
	inc	-54 (ix)
;src/Renderer.c:692: xCellCount = 0;
	ld	-17 (ix),#0x00
;src/Renderer.c:693: newCell=1;
	ld	-14 (ix),#0x01
;src/Renderer.c:694: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
	ld	a,-54 (ix)
	ld	-30 (ix),a
	ld	-29 (ix),#0x00
	ld	a,-40 (ix)
	sub	a, -30 (ix)
	ld	-30 (ix),a
	ld	a,-39 (ix)
	sbc	a, -29 (ix)
	ld	-29 (ix),a
	ld	l,-30 (ix)
	ld	h,-29 (ix)
	dec	hl
	ld	-30 (ix),l
	ld	-29 (ix),h
	ld	a,-24 (ix)
	add	a, -30 (ix)
	ld	-30 (ix),a
	ld	a,-23 (ix)
	adc	a, -29 (ix)
	ld	-29 (ix),a
	ld	l,-30 (ix)
	ld	h,-29 (ix)
	ld	a,(hl)
	ld	-33 (ix),a
00216$:
;src/Renderer.c:696: if(!(x%2)){
	ld	a,-57 (ix)
	and	a, #0x01
	ld	-38 (ix),a
;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-33 (ix)
	and	a, #0x80
	ld	-30 (ix),a
;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-17 (ix)
	ld	-12 (ix),a
	ld	-11 (ix),#0x00
;src/Renderer.c:696: if(!(x%2)){
	ld	a,-38 (ix)
	or	a, a
	jp	NZ,00229$
;src/Renderer.c:697: if (lateralWallCounter == 0 || newCell)
	ld	a,-36 (ix)
	or	a, a
	jr	Z,00225$
	ld	a,-14 (ix)
	or	a, a
	jp	Z,00229$
00225$:
;src/Renderer.c:699: if ( currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-30 (ix)
	or	a, a
	jr	Z,00223$
;src/Renderer.c:701: lateralWallCounter = 0;
	ld	-36 (ix),#0x00
;src/Renderer.c:702: lateralWallSlope = 0;
	ld	-20 (ix),#0x00
;src/Renderer.c:703: xHeight = zHeight;
	ld	a,-56 (ix)
	ld	-28 (ix),a
;src/Renderer.c:704: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
	ld	a,-33 (ix)
	sub	a, #0x80
	jr	NZ,00275$
	ld	-37 (ix),#0x0C
	jr	00276$
00275$:
	ld	-37 (ix),#0x0E
00276$:
	ld	a,-37 (ix)
	ld	-48 (ix),a
;src/Renderer.c:705: lastCellWasWall = 1;
	ld	-34 (ix),#0x01
;src/Renderer.c:706: lastWallId=currentCellID;
	ld	a,-33 (ix)
	ld	-31 (ix),a
	jp	00224$
00223$:
;src/Renderer.c:708: else if(lateralWallCounter==0){
	ld	a,-36 (ix)
	or	a, a
	jp	NZ,00224$
;src/Renderer.c:709: if (lastCellWasWall)
	ld	a,-34 (ix)
	or	a, a
	jp	Z,00218$
;src/Renderer.c:712: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-50 (ix)
	sub	a, -54 (ix)
	add	a, a
	inc	a
;src/Renderer.c:713: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-20 (ix), a
	srl	a
	ld	-22 (ix),a
;src/Renderer.c:714: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-56 (ix)
	ld	h,-20 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00648$:
	add	hl,hl
	jr	NC,00649$
	add	hl,de
00649$:
	djnz	00648$
;src/Renderer.c:715: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
	ld	-37 (ix), l
	ld	-10 (ix), l
	ld	-9 (ix),#0x00
	ld	a,-37 (ix)
	and	a, #0x03
	ld	-37 (ix), a
	ld	-7 (ix),a
	ld	-6 (ix),#0x00
	ld	a,-10 (ix)
	sub	a, -7 (ix)
	ld	-7 (ix),a
	ld	a,-9 (ix)
	sbc	a, -6 (ix)
	ld	-6 (ix),a
	ld	a,-7 (ix)
	add	a, #0x01
	ld	-10 (ix),a
	ld	a,-6 (ix)
	adc	a, #0x00
	ld	-9 (ix),a
	ld	a,-10 (ix)
	ld	-4 (ix),a
	ld	a,-9 (ix)
	ld	-3 (ix),a
	bit	7, -9 (ix)
	jr	Z,00277$
	ld	a,-7 (ix)
	add	a, #0x04
	ld	-4 (ix),a
	ld	a,-6 (ix)
	adc	a, #0x00
	ld	-3 (ix),a
00277$:
	ld	c,-4 (ix)
	ld	b,-3 (ix)
	sra	b
	rr	c
	sra	b
	rr	c
	ld	b,-17 (ix)
	ld	a,c
	sub	a, b
	ld	-36 (ix),a
;src/Renderer.c:717: lastCellWasWall = 0;
	ld	-34 (ix),#0x00
;src/Renderer.c:718: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	add	hl, hl
	ld	c,-20 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-8 (ix)
	sub	a, l
	ld	-28 (ix),a
;src/Renderer.c:719: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
	ld	a,-31 (ix)
	sub	a, #0x80
	jr	NZ,00278$
	ld	c,#0x0F
	jr	00279$
00278$:
	ld	c,#0x0D
00279$:
	ld	-48 (ix),c
	jr	00224$
00218$:
;src/Renderer.c:723: xHeight = 0;
	ld	-28 (ix),#0x00
;src/Renderer.c:724: lastCellWasWall = 0;
	ld	-34 (ix),#0x00
;src/Renderer.c:725: lateralWallSlope=0;
	ld	-20 (ix),#0x00
;src/Renderer.c:726: lastWallId=0;
	ld	-31 (ix),#0x00
00224$:
;src/Renderer.c:729: newCell=0;
	ld	-14 (ix),#0x00
00229$:
;src/Renderer.c:734: if (lateralWallCounter > 0)
	ld	a,-36 (ix)
	or	a, a
	jr	Z,00235$
;src/Renderer.c:737: if (lateralWallSlope != 0)
	ld	a,-20 (ix)
	or	a, a
	jr	Z,00233$
;src/Renderer.c:739: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-20 (ix)
	sub	a, -22 (ix)
	jr	NZ,00231$
;src/Renderer.c:741: lateralWallSlopeCounter = 0;
	ld	-22 (ix),#0x00
;src/Renderer.c:742: xHeight -= 2;
	dec	-28 (ix)
	dec	-28 (ix)
00231$:
;src/Renderer.c:744: ++lateralWallSlopeCounter;
	inc	-22 (ix)
00233$:
;src/Renderer.c:746: --lateralWallCounter;
	dec	-36 (ix)
00235$:
;src/Renderer.c:750: if (!(x%2))
	ld	a,-38 (ix)
	or	a, a
	jr	NZ,00244$
;src/Renderer.c:755: draw_column_to_buffer_untextured(x/2, xHeight, color);
	ld	b,-57 (ix)
	srl	b
;src/Renderer.c:753: if(xHeight > 0){
	ld	a,-28 (ix)
	or	a, a
	jr	Z,00237$
;src/Renderer.c:755: draw_column_to_buffer_untextured(x/2, xHeight, color);
	push	bc
	ld	h,-48 (ix)
	ld	l,-28 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_untextured
	pop	af
	inc	sp
	pop	bc
00237$:
;src/Renderer.c:758: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-30 (ix)
	or	a, a
	jr	NZ,00244$
;src/Renderer.c:759: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-33 (ix)
	and	a, #0x0F
	jr	Z,00244$
;src/Renderer.c:760: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	a,-26 (ix)
	sub	a, -12 (ix)
	ld	l,a
	ld	a,-25 (ix)
	sbc	a, -11 (ix)
	ld	h,a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	ld	e,-26 (ix)
	ld	d,-25 (ix)
	push	de
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	d,l
	pop	bc
	push	de
	inc	sp
	ld	h,-33 (ix)
	ld	l,-56 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:762: else if(currentCellID&CELL_ITEM_MASK){
00244$:
;src/Renderer.c:767: ++xCellCount;
	inc	-17 (ix)
;src/Renderer.c:686: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	dec	-57 (ix)
;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-24 (ix),l
	ld	-23 (ix),h
;src/Renderer.c:686: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	ld	a,-57 (ix)
	sub	a, #0x50
	jp	NC,00258$
;src/Renderer.c:774: lineStart = lineStart + (offsetDiff * 2) + 3;
	ld	a,-2 (ix)
	add	a, #0x03
	ld	-52 (ix),a
;src/Renderer.c:775: zHeight += zHeight;
	sla	-56 (ix)
;src/Renderer.c:776: offsetDiff = offsetDiff >> 1;
	srl	-50 (ix)
;src/Renderer.c:778: }while(z);
	ld	a,-58 (ix)
	or	a, a
	jp	NZ,00246$
00260$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:784: void draw_minimap_to_buffer(){
;	---------------------------------
; Function draw_minimap_to_buffer
; ---------------------------------
_draw_minimap_to_buffer::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-11
	add	hl,sp
	ld	sp,hl
;src/Renderer.c:787: u8* ptr = MINIMAP_BUFFER;
	ld	bc,#0x9AA0
;src/Renderer.c:792: y=(player_position.y-MINIMAP_HEIGHT_HALF);
	ld	a, (#(_player_position + 0x0001) + 0)
	add	a,#0xF8
	ld	e,a
;src/Renderer.c:794: for(j=0;j<MINIMAP_HEIGHT;++j){
	ld	d,#0x00
;src/Renderer.c:795: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
00137$:
	ld	a,e
	rlca
	and	a,#0x01
	ld	-6 (ix),a
	ld	a,e
	xor	a, #0x80
	sub	a, #0xA0
	ld	a,#0x00
	rla
	ld	-1 (ix),a
	ld	-10 (ix),#0x00
00122$:
;src/Renderer.c:796: x=(player_position.x-MINIMAP_WIDTH_HALF);
	ld	a, (#_player_position + 0)
	add	a,#0xF8
	ld	-7 (ix),a
;src/Renderer.c:797: for(i=0;i<MINIMAP_WIDTH;++i){
	ld	-11 (ix),#0x00
00120$:
;src/Renderer.c:800: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	iy,#0x0010
	add	iy, bc
;src/Renderer.c:798: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
	bit	7, -7 (ix)
	jr	NZ,00111$
	ld	a,-7 (ix)
	xor	a, #0x80
	sub	a, #0xA0
	jr	NC,00111$
	ld	a,-6 (ix)
	or	a, a
	jr	NZ,00111$
	bit	0,-1 (ix)
	jr	NZ,00112$
00111$:
;src/Renderer.c:799: *ptr=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	(bc),a
;src/Renderer.c:800: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	0 (iy), a
	jp	00113$
00112$:
;src/Renderer.c:802: else if((x==player_position.x)&&(y==player_position.y)){
	ld	a,-7 (ix)
	ld	-3 (ix),a
	ld	a,-7 (ix)
	rla
	sbc	a, a
	ld	-2 (ix),a
	ld	a, (#_player_position + 0)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
	ld	-5 (ix),e
	ld	a,e
	rla
	sbc	a, a
	ld	-4 (ix),a
	ld	a,-3 (ix)
	sub	a, -9 (ix)
	jr	NZ,00108$
	ld	a,-2 (ix)
	sub	a, -8 (ix)
	jr	NZ,00108$
	ld	a, (#(_player_position + 0x0001) + 0)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
	ld	a,-5 (ix)
	sub	a, -9 (ix)
	jr	NZ,00108$
	ld	a,-4 (ix)
	sub	a, -8 (ix)
	jr	NZ,00108$
;src/Renderer.c:803: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
	ld	a, (#(_g_colors + 0x0004) + 0)
	ld	(bc),a
;src/Renderer.c:804: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
	ld	a, (#(_g_colors + 0x0004) + 0)
	ld	0 (iy), a
	jr	00113$
00108$:
;src/Renderer.c:807: val = (*(u8*)(MAP_MEM+x+y*MAP_WIDTH));
	ld	a,-3 (ix)
	add	a, #0x00
	ld	-9 (ix),a
	ld	a,-2 (ix)
	adc	a, #0x60
	ld	-8 (ix),a
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a,-9 (ix)
	add	a, l
	ld	l,a
	ld	a,-8 (ix)
	adc	a, h
	ld	h,a
	ld	h,(hl)
;src/Renderer.c:809: if(val==CELLTYPE_DOOR){
	ld	a,h
	sub	a, #0x80
	jr	NZ,00105$
;src/Renderer.c:810: *ptr=g_colors[MINIMAP_EXIT_COLOR];
	ld	a, (#(_g_colors + 0x0005) + 0)
	ld	(bc),a
;src/Renderer.c:811: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
	ld	a, (#(_g_colors + 0x0005) + 0)
	ld	0 (iy), a
	jr	00113$
00105$:
;src/Renderer.c:813: else if(val&CELL_WALL_MASK){
	add	hl, hl
	jr	NC,00102$
;src/Renderer.c:814: *ptr=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	(bc),a
;src/Renderer.c:815: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	0 (iy), a
	jr	00113$
00102$:
;src/Renderer.c:818: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
	ld	a, (#(_g_colors + 0x0003) + 0)
	ld	(bc),a
;src/Renderer.c:819: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
	ld	a, (#(_g_colors + 0x0003) + 0)
	ld	0 (iy), a
00113$:
;src/Renderer.c:822: ++x;
	inc	-7 (ix)
;src/Renderer.c:823: ++ptr;
	inc	bc
;src/Renderer.c:797: for(i=0;i<MINIMAP_WIDTH;++i){
	inc	-11 (ix)
	ld	a,-11 (ix)
	sub	a, #0x10
	jp	C,00120$
;src/Renderer.c:795: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
	inc	-10 (ix)
	ld	a,-10 (ix)
	sub	a, #0x04
	jp	C,00122$
;src/Renderer.c:826: ++y;
	inc	e
;src/Renderer.c:794: for(j=0;j<MINIMAP_HEIGHT;++j){
	inc	d
	ld	a,d
	sub	a, #0x10
	jp	C,00137$
	ld	sp, ix
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
