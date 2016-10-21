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
	.globl _enemy_get_at
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
;src/Renderer.c:51: void calculate_cells_in_view(){
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
;src/Renderer.c:53: u8 offset=0, n=0, j, i;
	ld	-6 (ix),#0x00
	ld	-7 (ix),#0x00
;src/Renderer.c:56: if(player_direction.y!=0){
	ld	hl, #_player_direction + 1
	ld	a,(hl)
	ld	-4 (ix), a
	or	a, a
	jr	Z,00102$
;src/Renderer.c:57: vert=1;
	ld	-14 (ix),#0x01
;src/Renderer.c:58: dy=player_direction.y;
	ld	c,-4 (ix)
	ld	-12 (ix),c
;src/Renderer.c:59: dx=-player_direction.y;
	xor	a, a
	sub	a, -4 (ix)
	ld	-11 (ix), a
;src/Renderer.c:61: x0 = player_position.x-(17*dx);
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
;src/Renderer.c:62: y0 = player_position.y+(6*dy);
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
;src/Renderer.c:65: vert=0;
	ld	-14 (ix),#0x00
;src/Renderer.c:66: dy=player_direction.x;
	ld	hl, #_player_direction + 0
	ld	a,(hl)
	ld	-4 (ix), a
	ld	-12 (ix),a
;src/Renderer.c:67: dx=player_direction.x;
	ld	a,-4 (ix)
	ld	-11 (ix),a
;src/Renderer.c:69: y0 = player_position.y-(17*dy);
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
;src/Renderer.c:70: x0 = player_position.x+(6*dx);
	ld	hl, #_player_position + 0
	ld	b,(hl)
	ld	a,-4 (ix)
	ld	e,a
	add	a, a
	add	a, e
	add	a, a
	ld	e,a
	ld	l,b
	add	hl, de
	ld	-10 (ix),l
00103$:
;src/Renderer.c:74: x=x0;
	ld	e,-10 (ix)
;src/Renderer.c:75: y=y0;
	ld	-13 (ix),c
;src/Renderer.c:77: for(j=0;j<6;++j){
	ld	a,-11 (ix)
	rlca
	and	a,#0x01
	ld	-4 (ix),a
	ld	a,-12 (ix)
	rlca
	and	a,#0x01
	ld	-1 (ix),a
	ld	-8 (ix),#0x00
;src/Renderer.c:79: for(i=offset;i<35-offset;++i){
00138$:
	ld	a,-7 (ix)
	ld	-5 (ix),a
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
;src/Renderer.c:82: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
	ld	hl,(_cells_in_view_array)
	ld	a,l
	add	a, -5 (ix)
	ld	-3 (ix),a
	ld	a,h
	adc	a, #0x00
	ld	-2 (ix),a
;src/Renderer.c:81: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
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
;src/Renderer.c:82: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
	ld	a,e
	ld	d,a
	rla
	sbc	a, a
	ld	b, d
	add	a,#0x70
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
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	(hl),b
	jr	00106$
00105$:
;src/Renderer.c:85: cells_in_view_array[n]=CELLTYPE_WALL1;
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	(hl),#0x81
00106$:
;src/Renderer.c:89: if(vert){
	ld	a,-14 (ix)
	or	a, a
	jr	Z,00111$
;src/Renderer.c:90: x+=dx;
	ld	a,e
	add	a, -11 (ix)
	ld	e,a
	jr	00112$
00111$:
;src/Renderer.c:93: y+=dy;
	ld	a,-13 (ix)
	add	a, -12 (ix)
	ld	-13 (ix),a
00112$:
;src/Renderer.c:95: ++n;
	inc	-5 (ix)
;src/Renderer.c:79: for(i=offset;i<35-offset;++i){
	inc	-9 (ix)
	jp	00125$
00143$:
	ld	a,-5 (ix)
	ld	-7 (ix),a
;src/Renderer.c:97: offset=offsets_cells_in_view[j];
	ld	a,#<(_offsets_cells_in_view)
	add	a, -8 (ix)
	ld	l,a
	ld	a,#>(_offsets_cells_in_view)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
;src/Renderer.c:101: if(dx<0) x=x0-offset;
	ld	-6 (ix), a
	ld	-3 (ix),a
;src/Renderer.c:99: if(vert){
	ld	a,-14 (ix)
	or	a, a
	jr	Z,00121$
;src/Renderer.c:100: y-=dy;
	ld	a,-13 (ix)
	sub	a, -12 (ix)
	ld	-13 (ix),a
;src/Renderer.c:101: if(dx<0) x=x0-offset;
	ld	a,-4 (ix)
	or	a, a
	jr	Z,00115$
	ld	a,-10 (ix)
	sub	a, -3 (ix)
	ld	e,a
	jr	00128$
00115$:
;src/Renderer.c:102: else x=x0+offset;
	ld	a,-10 (ix)
	add	a, -3 (ix)
	ld	e,a
	jr	00128$
00121$:
;src/Renderer.c:106: x-=dx;
	ld	a,e
	sub	a, -11 (ix)
	ld	e,a
;src/Renderer.c:107: if(dy<0) y=y0-offset;
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00118$
	ld	a,c
	sub	a, -3 (ix)
	ld	-13 (ix),a
	jr	00128$
00118$:
;src/Renderer.c:108: else y=y0+offset;
	ld	a,c
	add	a, -3 (ix)
	ld	-13 (ix),a
00128$:
;src/Renderer.c:77: for(j=0;j<6;++j){
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
	.db #0x09	; 9
	.db #0x0F	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
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
	.dw #0xAEA0
_offsets_cells_in_view:
	.db #0x08	; 8
	.db #0x0C	; 12
	.db #0x0E	; 14
	.db #0x0F	; 15
	.db #0x10	; 16
;src/Renderer.c:116: void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
;	---------------------------------
; Function draw_column_to_buffer_untextured
; ---------------------------------
_draw_column_to_buffer_untextured::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;src/Renderer.c:117: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a, 4 (ix)
	srl	a
	ld	c,a
	ld	a,#0x00
	add	a,#0x9B
	ld	b,a
;src/Renderer.c:119: u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
	ld	de,#_g_colors+0
	ld	l,6 (ix)
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	-2 (ix),a
;src/Renderer.c:120: u8 pixMask = g_pixelMask[column&1];
	ld	de,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l,a
	ld	h,#0x00
	add	hl,de
	ld	e,(hl)
;src/Renderer.c:129: if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
	ld	a,#0x64
	sub	a, 5 (ix)
	jr	NC,00102$
	ld	5 (ix),#0x64
00102$:
;src/Renderer.c:131: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
	ld	l,5 (ix)
	srl	l
	ld	a,#0x32
	sub	a, l
;src/Renderer.c:134: pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
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
;src/Renderer.c:136: j=lineHeight;
	ld	d,5 (ix)
;src/Renderer.c:138: for(j;j;--j){
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
;src/Renderer.c:139: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, -1 (ix)
;src/Renderer.c:141: *pvmem = val|(w_color&pixMask);
	or	a, e
	ld	(bc),a
;src/Renderer.c:143: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:138: for(j;j;--j){
	dec	d
	jr	00105$
00107$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:147: void draw_column_to_buffer_object(u8 column, u8 lineHeight, u8 index, u8 texture_column){
;	---------------------------------
; Function draw_column_to_buffer_object
; ---------------------------------
_draw_column_to_buffer_object::
;src/Renderer.c:149: }
	ret
;src/Renderer.c:152: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
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
;src/Renderer.c:169: u16 texture_line=0;
	ld	-11 (ix),#0x00
	ld	-10 (ix),#0x00
;src/Renderer.c:171: if(texture_column>=4 && texture_column<28){
	ld	a,7 (ix)
	sub	a, #0x04
	jp	C,00112$
	ld	a,7 (ix)
	sub	a, #0x1C
	jp	NC,00112$
;src/Renderer.c:174: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(enemy_get_at(index-1)->type)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
	ld	l,6 (ix)
	dec	l
	call	_enemy_get_at
	inc	hl
	ld	c,(hl)
	ld	b,#0x00
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
	ld	bc,#0x8800
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
	inc	sp
	inc	sp
	push	hl
;src/Renderer.c:176: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a,4 (ix)
	srl	a
	add	a, #0x00
	ld	-6 (ix),a
	ld	a,#0x00
	adc	a, #0x9B
	ld	-5 (ix),a
;src/Renderer.c:178: pixMask = g_pixelMask[column&1];
	ld	bc,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l, a
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-12 (ix),a
;src/Renderer.c:180: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
	ld	a,5 (ix)
	srl	a
	add	a, #0x32
	ld	-7 (ix),a
;src/Renderer.c:181: lineHeight = (lineHeight*3)/4;
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
;src/Renderer.c:182: enemy_top_height = ground_height - lineHeight;
	ld	a,-7 (ix)
	sub	a, b
	ld	c,a
;src/Renderer.c:184: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
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
	ld	-9 (ix),l
	ld	-8 (ix),h
;src/Renderer.c:185: j=lineHeight;
	ld	d,b
;src/Renderer.c:187: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
	ld	a,#0x64
	sub	a, b
	jr	NC,00102$
;src/Renderer.c:188: j=90;
	ld	d,#0x5A
00102$:
;src/Renderer.c:191: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
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
;src/Renderer.c:193: for(j;j;--j){
	ld	a,-12 (ix)
	cpl
	ld	e,a
00110$:
	ld	a,d
	or	a, a
	jr	Z,00112$
;src/Renderer.c:195: color= *(texture+(texture_line/256));
	ld	l,-10 (ix)
	ld	h,#0x00
	ld	a,-14 (ix)
	add	a, l
	ld	l,a
	ld	a,-13 (ix)
	adc	a, h
	ld	h,a
	ld	a,(hl)
;src/Renderer.c:197: if(color){
	ld	-4 (ix), a
	or	a, a
	jr	Z,00104$
;src/Renderer.c:198: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, e
	ld	l,a
;src/Renderer.c:200: color = (color&pixMask);
	ld	a,-4 (ix)
	and	a, -12 (ix)
;src/Renderer.c:202: *pvmem = val|color;
	or	a, l
	ld	(bc),a
00104$:
;src/Renderer.c:205: texture_line += texture_line_add;
	ld	a,-11 (ix)
	add	a, -9 (ix)
	ld	-11 (ix),a
	ld	a,-10 (ix)
	adc	a, -8 (ix)
	ld	-10 (ix),a
;src/Renderer.c:207: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:193: for(j;j;--j){
	dec	d
	jr	00110$
00112$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:299: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
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
;src/Renderer.c:300: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a,4 (ix)
	srl	a
	add	a, #0x00
	ld	-2 (ix),a
	ld	a,#0x00
	adc	a, #0x9B
	ld	-1 (ix),a
;src/Renderer.c:303: u8 pixMask = g_pixelMask[column&1];
	ld	bc,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l, a
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-8 (ix),a
;src/Renderer.c:308: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
	ld	a, 6 (ix)
	add	a, a
	add	a, a
	ld	b,a
	ld	c,#0x00
	ld	hl,#0x7400
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
	ld	-12 (ix),l
	ld	-11 (ix),h
;src/Renderer.c:310: u8 j=lineHeight;
	ld	a,5 (ix)
;src/Renderer.c:316: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
	ld	-7 (ix), a
	ld	-6 (ix),a
	ld	-5 (ix),#0x00
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	hl,#0x2000
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-14 (ix),l
	ld	-13 (ix),h
;src/Renderer.c:317: u16 wall_texture_line=0;
	ld	-10 (ix),#0x00
	ld	-9 (ix),#0x00
;src/Renderer.c:319: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
	ld	c,-7 (ix)
	srl	c
	ld	a,#0x32
	sub	a, c
	ld	-15 (ix),a
;src/Renderer.c:323: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
	ld	a,#0x64
	sub	a, -7 (ix)
	jr	NC,00102$
;src/Renderer.c:324: ceiling_height=0;
	ld	-15 (ix),#0x00
;src/Renderer.c:325: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
	ld	a,-6 (ix)
	add	a,#0x9C
	ld	c,a
	ld	a,-5 (ix)
	adc	a,#0xFF
	ld	b,a
	ld	-4 (ix),c
	ld	-3 (ix),b
	bit	7, b
	jr	Z,00111$
	ld	a,-6 (ix)
	add	a, #0x9D
	ld	-4 (ix),a
	ld	a,-5 (ix)
	adc	a, #0xFF
	ld	-3 (ix),a
00111$:
	ld	c,-4 (ix)
	ld	b,-3 (ix)
	sra	b
	rr	c
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	push	bc
	call	__mulint
	pop	af
	pop	af
	ld	-10 (ix),l
	ld	-9 (ix),h
;src/Renderer.c:326: j=SCREEN_TEXTURE_HEIGHT;
	ld	-7 (ix),#0x64
00102$:
;src/Renderer.c:329: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
	ld	c,-15 (ix)
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
;src/Renderer.c:331: for(j;j;--j){
	ld	a,-8 (ix)
	cpl
	ld	-4 (ix),a
	ld	d,-7 (ix)
00107$:
	ld	a,d
	or	a, a
	jr	Z,00109$
;src/Renderer.c:333: w_color = *(texture+(wall_texture_line/256));
	ld	a, -9 (ix)
	ld	h, #0x00
	add	a, -12 (ix)
	ld	l,a
	ld	a,h
	adc	a, -11 (ix)
	ld	h,a
	ld	e,(hl)
;src/Renderer.c:335: if(w_color){
	ld	a,e
	or	a, a
	jr	Z,00104$
;src/Renderer.c:337: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, -4 (ix)
	ld	l,a
;src/Renderer.c:339: w_color = (w_color&pixMask);
	ld	a,e
	and	a, -8 (ix)
;src/Renderer.c:341: *pvmem = val|w_color;
	or	a, l
	ld	(bc),a
00104$:
;src/Renderer.c:345: wall_texture_line += wall_texture_line_add;
	ld	a,-10 (ix)
	add	a, -14 (ix)
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a, -13 (ix)
	ld	-9 (ix),a
;src/Renderer.c:347: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:331: for(j;j;--j){
	dec	d
	jr	00107$
00109$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:351: void render_draw_to_buffer(){//TODO Optimize
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
;src/Renderer.c:363: u8 zHeight = 5;
	ld	-57 (ix),#0x05
;src/Renderer.c:373: u8 offsetDiff = 16;
	ld	-50 (ix),#0x10
;src/Renderer.c:378: u8 lineStart = 0;
	ld	-43 (ix),#0x00
;src/Renderer.c:380: u8 lateralWallWidth=0;
	ld	-45 (ix),#0x00
;src/Renderer.c:392: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
	ld	hl, #_g_colors + 7
	ld	b,(hl)
	ld	hl,#0x07A8
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x9B00
	push	hl
	call	_cpct_memset
;src/Renderer.c:393: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
	ld	hl, #_g_colors + 1
	ld	b,(hl)
	ld	hl,#0x0050
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xA2A8
	push	hl
	call	_cpct_memset
;src/Renderer.c:394: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
	ld	hl, #_g_colors + 8
	ld	b,(hl)
	ld	hl,#0x07A8
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xA2F8
	push	hl
	call	_cpct_memset
;src/Renderer.c:396: calculate_cells_in_view();
	call	_calculate_cells_in_view
;src/Renderer.c:415: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-36 (ix),l
	ld	-35 (ix),h
;src/Renderer.c:398: if(g_texturedWalls){
	ld	a,(#_g_texturedWalls + 0)
	or	a, a
	jp	Z,00358$
;src/Renderer.c:400: do{
	ld	-53 (ix),#0x06
00175$:
;src/Renderer.c:402: --z;
	dec	-53 (ix)
;src/Renderer.c:406: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-57 (ix)
	srl	a
	ld	-18 (ix),a
	ld	a,-53 (ix)
	or	a, a
	jr	Z,00262$
	ld	c,-18 (ix)
	jr	00263$
00262$:
	ld	c,#0x00
00263$:
	ld	-13 (ix),c
;src/Renderer.c:407: lateralWallSlope=0;
	ld	-10 (ix),#0x00
;src/Renderer.c:408: lateralWallSlopeCounter=0;
	ld	-8 (ix),#0x00
;src/Renderer.c:409: xHeight=0;
	ld	-3 (ix),#0x00
;src/Renderer.c:412: lateralWallCounter = 0;
	ld	-38 (ix),#0x00
;src/Renderer.c:414: newCell=1;
	ld	-27 (ix),#0x01
;src/Renderer.c:415: currentCellID = cells_in_view_array[lineStart + 1];
	ld	a,-43 (ix)
	ld	-23 (ix),a
	ld	-22 (ix),#0x00
	ld	c,-23 (ix)
	ld	b,-22 (ix)
	inc	bc
	ld	l,-36 (ix)
	ld	h,-35 (ix)
	add	hl,bc
	ld	a,(hl)
	ld	-28 (ix),a
;src/Renderer.c:417: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
	ld	a,-36 (ix)
	add	a, -43 (ix)
	ld	l,a
	ld	a,-35 (ix)
	adc	a, #0x00
	ld	h,a
	ld	c,(hl)
;src/Renderer.c:418: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00102$
;src/Renderer.c:419: lastWallId=lastCellWasWall;
	ld	-41 (ix),c
;src/Renderer.c:420: lastCellWasWall=1;
	ld	-37 (ix),#0x01
	jr	00296$
00102$:
;src/Renderer.c:423: lastCellWasWall=0;
	ld	-37 (ix),#0x00
;src/Renderer.c:424: lastWallId=CELLTYPE_FLOOR;
	ld	-41 (ix),#0x00
;src/Renderer.c:427: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
00296$:
	ld	-44 (ix),#0x00
	ld	-51 (ix),#0x00
00252$:
;src/Renderer.c:429: if (xCellCount == zHeight)
	ld	a,-57 (ix)
	sub	a, -13 (ix)
	jr	NZ,00105$
;src/Renderer.c:431: ++xCell;
	inc	-44 (ix)
;src/Renderer.c:432: xCellCount = 0;
	ld	-13 (ix),#0x00
;src/Renderer.c:433: newCell=1;
	ld	-27 (ix),#0x01
;src/Renderer.c:434: currentCellID=cells_in_view_array[xCell + lineStart + 1];
	ld	a,-44 (ix)
	ld	-30 (ix),a
	ld	-29 (ix),#0x00
	ld	a,-23 (ix)
	add	a, -30 (ix)
	ld	-30 (ix),a
	ld	a,-22 (ix)
	adc	a, -29 (ix)
	ld	-29 (ix),a
	inc	-30 (ix)
	jr	NZ,00608$
	inc	-29 (ix)
00608$:
	ld	a,-36 (ix)
	add	a, -30 (ix)
	ld	-30 (ix),a
	ld	a,-35 (ix)
	adc	a, -29 (ix)
	ld	-29 (ix),a
	ld	l,-30 (ix)
	ld	h,-29 (ix)
	ld	a,(hl)
	ld	-28 (ix),a
00105$:
;src/Renderer.c:436: if(!(x%2)){
	ld	a,-51 (ix)
	and	a, #0x01
	ld	-30 (ix),a
;src/Renderer.c:439: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-28 (ix)
	and	a, #0x80
	ld	-21 (ix),a
;src/Renderer.c:459: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-13 (ix)
	ld	-32 (ix),a
	ld	-31 (ix),#0x00
	ld	a,-57 (ix)
	ld	-26 (ix),a
;src/Renderer.c:436: if(!(x%2)){
	ld	a,-30 (ix)
	or	a, a
	jp	NZ,00118$
;src/Renderer.c:437: if ((lateralWallCounter == 0)||newCell)
	ld	a,-38 (ix)
	or	a, a
	jr	Z,00114$
	ld	a,-27 (ix)
	or	a, a
	jp	Z,00118$
00114$:
;src/Renderer.c:439: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-21 (ix)
	or	a, a
	jr	Z,00112$
;src/Renderer.c:441: lateralWallCounter = 0;//(zHeight - xCellCount);
	ld	-38 (ix),#0x00
;src/Renderer.c:442: lateralWallSlope = 0;
	ld	-10 (ix),#0x00
;src/Renderer.c:443: xHeight = zHeight;
	ld	a,-57 (ix)
	ld	-3 (ix),a
;src/Renderer.c:444: color = currentCellID&0b01111111;
	ld	a,-28 (ix)
	and	a, #0x7F
	ld	-9 (ix),a
;src/Renderer.c:445: lastCellWasWall = 1;
	ld	-37 (ix),#0x01
;src/Renderer.c:446: lastWallId=currentCellID;
	ld	a,-28 (ix)
	ld	-41 (ix),a
	jr	00113$
00112$:
;src/Renderer.c:449: if(lateralWallCounter==0){//Lateral wall not finished
	ld	a,-38 (ix)
	or	a, a
	jr	NZ,00113$
;src/Renderer.c:450: if (lastCellWasWall)
	ld	a,-37 (ix)
	or	a, a
	jr	Z,00107$
;src/Renderer.c:453: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-50 (ix)
	sub	a, -44 (ix)
	add	a, a
	inc	a
;src/Renderer.c:454: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-10 (ix), a
	srl	a
	ld	-8 (ix),a
;src/Renderer.c:455: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-57 (ix)
	ld	h,-10 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00609$:
	add	hl,hl
	jr	NC,00610$
	add	hl,de
00610$:
	djnz	00609$
;src/Renderer.c:456: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
	ld	a,l
	and	a, #0xFC
	set	0, a
	srl	a
	srl	a
	sub	a, -13 (ix)
;src/Renderer.c:457: lateralWallWidth=lateralWallCounter;
	ld	-38 (ix), a
	ld	-45 (ix),a
;src/Renderer.c:458: lastCellWasWall = 0;
	ld	-37 (ix),#0x00
;src/Renderer.c:459: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	l,-32 (ix)
	ld	h,-31 (ix)
	add	hl, hl
	ld	c,-10 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-26 (ix)
	sub	a, l
	ld	-3 (ix),a
;src/Renderer.c:460: color = lastWallId&0b01111111;
	ld	a,-41 (ix)
	and	a, #0x7F
	ld	-9 (ix),a
	jr	00113$
00107$:
;src/Renderer.c:464: xHeight = 0;
	ld	-3 (ix),#0x00
;src/Renderer.c:465: lastCellWasWall = 0;
	ld	-37 (ix),#0x00
;src/Renderer.c:466: lateralWallSlope=0;
	ld	-10 (ix),#0x00
;src/Renderer.c:467: lastWallId=0;
	ld	-41 (ix),#0x00
00113$:
;src/Renderer.c:471: newCell=0;
	ld	-27 (ix),#0x00
00118$:
;src/Renderer.c:474: if (lateralWallCounter > 0)
	ld	a,-38 (ix)
	or	a, a
	jr	Z,00124$
;src/Renderer.c:477: if (lateralWallSlope != 0)
	ld	a,-10 (ix)
	or	a, a
	jr	Z,00122$
;src/Renderer.c:479: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-8 (ix)
	sub	a, -10 (ix)
	jr	NZ,00120$
;src/Renderer.c:481: lateralWallSlopeCounter = 0;
	ld	-8 (ix),#0x00
;src/Renderer.c:482: xHeight -= 2;
	dec	-3 (ix)
	dec	-3 (ix)
00120$:
;src/Renderer.c:484: ++lateralWallSlopeCounter;
	inc	-8 (ix)
00122$:
;src/Renderer.c:487: --lateralWallCounter;
	dec	-38 (ix)
00124$:
;src/Renderer.c:498: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-57 (ix)
	ld	-5 (ix),a
	ld	-4 (ix),#0x00
;src/Renderer.c:490: if (!(x%2))
	ld	a,-30 (ix)
	or	a, a
	jp	NZ,00136$
;src/Renderer.c:500: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	ld	b,-51 (ix)
	srl	b
;src/Renderer.c:498: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	l,-32 (ix)
	ld	h,-31 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	ld	e,-5 (ix)
	ld	d,-4 (ix)
	push	de
	push	hl
	call	__divsint
	pop	af
	pop	af
	pop	bc
	ld	c,l
;src/Renderer.c:492: if(xHeight > 0){
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00129$
;src/Renderer.c:493: if (lateralWallCounter > 0)
	ld	a,-38 (ix)
	or	a, a
	jr	Z,00126$
;src/Renderer.c:495: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
	ld	e,-45 (ix)
	ld	d,#0x00
	ld	l,-38 (ix)
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
;src/Renderer.c:498: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	d,c
00127$:
;src/Renderer.c:500: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	push	bc
	push	de
	inc	sp
	ld	h,-9 (ix)
	ld	l,-3 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer
	pop	af
	pop	af
	pop	bc
00129$:
;src/Renderer.c:502: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-21 (ix)
	or	a, a
	jr	NZ,00136$
;src/Renderer.c:503: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-28 (ix)
	and	a, #0x0F
	jr	Z,00136$
;src/Renderer.c:504: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	a,c
	push	af
	inc	sp
	ld	h,-28 (ix)
	ld	l,-57 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:506: else if(currentCellID&CELL_ITEM_MASK){
00136$:
;src/Renderer.c:512: ++xCellCount;
	inc	-13 (ix)
;src/Renderer.c:427: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	inc	-51 (ix)
;src/Renderer.c:415: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-36 (ix),l
	ld	-35 (ix),h
;src/Renderer.c:427: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	ld	a,-51 (ix)
	sub	a, #0x50
	jp	C,00252$
;src/Renderer.c:519: xCellCount = (z) ? (zHeight >> 1) : 0 ;
	ld	a,-53 (ix)
	or	a, a
	jr	Z,00264$
	ld	c,-18 (ix)
	jr	00265$
00264$:
	ld	c,#0x00
00265$:
	ld	-32 (ix),c
;src/Renderer.c:520: lateralWallSlope=0;
	ld	-21 (ix),#0x00
;src/Renderer.c:521: lateralWallSlopeCounter=0;
	ld	-30 (ix),#0x00
;src/Renderer.c:522: xHeight=0;
	ld	-37 (ix),#0x00
;src/Renderer.c:524: lateralWallCounter = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:525: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	a,-50 (ix)
	add	a, a
	ld	c,a
	ld	a,-43 (ix)
	add	a, c
	ld	-28 (ix), a
	ld	c, a
	inc	c
	inc	c
;src/Renderer.c:527: newCell=1;
	ld	-23 (ix),#0x01
;src/Renderer.c:528: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	-2 (ix),c
	ld	-1 (ix),#0x00
	ld	e,-2 (ix)
	ld	d,-1 (ix)
	dec	de
	ld	l,-36 (ix)
	ld	h,-35 (ix)
	add	hl,de
	ld	a,(hl)
	ld	-27 (ix),a
;src/Renderer.c:530: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
	ld	l,-36 (ix)
	ld	h,-35 (ix)
	ld	b,#0x00
	add	hl, bc
	ld	c,(hl)
;src/Renderer.c:531: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00139$
;src/Renderer.c:532: lastWallId=lastCellWasWall;
	ld	-38 (ix),c
;src/Renderer.c:533: lastCellWasWall=1;
	ld	-3 (ix),#0x01
	jr	00315$
00139$:
;src/Renderer.c:536: lastCellWasWall=0;
	ld	-3 (ix),#0x00
;src/Renderer.c:537: lastWallId=CELLTYPE_FLOOR;
	ld	-38 (ix),#0x00
;src/Renderer.c:540: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
00315$:
	ld	-44 (ix),#0x00
	ld	-51 (ix),#0x9F
00254$:
;src/Renderer.c:543: if (xCellCount == zHeight)
	ld	a,-57 (ix)
	sub	a, -32 (ix)
	jr	NZ,00142$
;src/Renderer.c:545: ++xCell;
	inc	-44 (ix)
;src/Renderer.c:546: xCellCount = 0;
	ld	-32 (ix),#0x00
;src/Renderer.c:547: newCell=1;
	ld	-23 (ix),#0x01
;src/Renderer.c:548: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
	ld	a,-44 (ix)
	ld	-40 (ix),a
	ld	-39 (ix),#0x00
	ld	a,-2 (ix)
	sub	a, -40 (ix)
	ld	-40 (ix),a
	ld	a,-1 (ix)
	sbc	a, -39 (ix)
	ld	-39 (ix),a
	ld	l,-40 (ix)
	ld	h,-39 (ix)
	dec	hl
	ld	-40 (ix),l
	ld	-39 (ix),h
	ld	a,-36 (ix)
	add	a, -40 (ix)
	ld	-40 (ix),a
	ld	a,-35 (ix)
	adc	a, -39 (ix)
	ld	-39 (ix),a
	ld	l,-40 (ix)
	ld	h,-39 (ix)
	ld	a,(hl)
	ld	-27 (ix),a
00142$:
;src/Renderer.c:550: if(!(x%2)){
	ld	a,-51 (ix)
	and	a, #0x01
	ld	-40 (ix),a
;src/Renderer.c:439: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-27 (ix)
	and	a, #0x80
	ld	-8 (ix),a
;src/Renderer.c:459: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-32 (ix)
	ld	-34 (ix),a
	ld	-33 (ix),#0x00
;src/Renderer.c:550: if(!(x%2)){
	ld	a,-40 (ix)
	or	a, a
	jp	NZ,00155$
;src/Renderer.c:551: if (lateralWallCounter == 0 || newCell)
	ld	a,-41 (ix)
	or	a, a
	jr	Z,00151$
	ld	a,-23 (ix)
	or	a, a
	jp	Z,00155$
00151$:
;src/Renderer.c:553: if ( currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-8 (ix)
	or	a, a
	jr	Z,00149$
;src/Renderer.c:555: lateralWallCounter = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:556: lateralWallSlope = 0;
	ld	-21 (ix),#0x00
;src/Renderer.c:557: xHeight = zHeight;
	ld	a,-57 (ix)
	ld	-37 (ix),a
;src/Renderer.c:558: color = currentCellID&0b01111111;
	ld	a,-27 (ix)
	and	a, #0x7F
	ld	-9 (ix),a
;src/Renderer.c:559: lastCellWasWall = 1;
	ld	-3 (ix),#0x01
;src/Renderer.c:560: lastWallId=currentCellID;
	ld	a,-27 (ix)
	ld	-38 (ix),a
	jp	00150$
00149$:
;src/Renderer.c:562: else if(lateralWallCounter==0){
	ld	a,-41 (ix)
	or	a, a
	jp	NZ,00150$
;src/Renderer.c:563: if (lastCellWasWall)
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00144$
;src/Renderer.c:566: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-50 (ix)
	sub	a, -44 (ix)
	add	a, a
	inc	a
;src/Renderer.c:567: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-21 (ix), a
	srl	a
	ld	-30 (ix),a
;src/Renderer.c:568: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-57 (ix)
	ld	h,-21 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00617$:
	add	hl,hl
	jr	NC,00618$
	add	hl,de
00618$:
	djnz	00617$
;src/Renderer.c:569: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
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
	ld	c,-32 (ix)
	ld	a,l
	sub	a, c
;src/Renderer.c:570: lateralWallWidth=lateralWallCounter;
	ld	-41 (ix), a
	ld	-45 (ix),a
;src/Renderer.c:571: lastCellWasWall = 0;
	ld	-3 (ix),#0x00
;src/Renderer.c:572: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
	ld	l,-34 (ix)
	ld	h,-33 (ix)
	add	hl, hl
	ld	c,-21 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-26 (ix)
	sub	a, l
	ld	-37 (ix),a
;src/Renderer.c:573: color = lastWallId&0b01111111;
	ld	a,-38 (ix)
	and	a, #0x7F
	ld	-9 (ix),a
	jr	00150$
00144$:
;src/Renderer.c:577: xHeight = 0;
	ld	-37 (ix),#0x00
;src/Renderer.c:578: lastCellWasWall = 0;
	ld	-3 (ix),#0x00
;src/Renderer.c:579: lateralWallSlope=0;
	ld	-21 (ix),#0x00
;src/Renderer.c:580: lastWallId=0;
	ld	-38 (ix),#0x00
00150$:
;src/Renderer.c:583: newCell=0;
	ld	-23 (ix),#0x00
00155$:
;src/Renderer.c:588: if (lateralWallCounter > 0)
	ld	a,-41 (ix)
	or	a, a
	jr	Z,00161$
;src/Renderer.c:591: if (lateralWallSlope != 0)
	ld	a,-21 (ix)
	or	a, a
	jr	Z,00159$
;src/Renderer.c:593: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-21 (ix)
	sub	a, -30 (ix)
	jr	NZ,00157$
;src/Renderer.c:595: lateralWallSlopeCounter = 0;
	ld	-30 (ix),#0x00
;src/Renderer.c:596: xHeight -= 2;
	dec	-37 (ix)
	dec	-37 (ix)
00157$:
;src/Renderer.c:598: ++lateralWallSlopeCounter;
	inc	-30 (ix)
00159$:
;src/Renderer.c:600: --lateralWallCounter;
	dec	-41 (ix)
00161$:
;src/Renderer.c:604: if (!(x%2))
	ld	a,-40 (ix)
	or	a, a
	jp	NZ,00173$
;src/Renderer.c:617: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	ld	a,-51 (ix)
	srl	a
	ld	-40 (ix),a
;src/Renderer.c:614: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-5 (ix)
	sub	a, -34 (ix)
	ld	-34 (ix),a
	ld	a,-4 (ix)
	sbc	a, -33 (ix)
	ld	-33 (ix),a
	ld	a,#0x05+1
	jr	00622$
00621$:
	sla	-34 (ix)
	rl	-33 (ix)
00622$:
	dec	a
	jr	NZ,00621$
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	push	hl
	ld	l,-34 (ix)
	ld	h,-33 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-33 (ix),h
	ld	-34 (ix), l
	ld	-34 (ix), l
;src/Renderer.c:607: if(xHeight > 0){
	ld	a,-37 (ix)
	or	a, a
	jr	Z,00166$
;src/Renderer.c:609: if (lateralWallCounter > 0)
	ld	a,-41 (ix)
	or	a, a
	jr	Z,00163$
;src/Renderer.c:611: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
	ld	a,-41 (ix)
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
	ld	a,-45 (ix)
	ld	-25 (ix),a
	ld	-24 (ix),#0x00
	ld	l,-25 (ix)
	ld	h,-24 (ix)
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
;src/Renderer.c:614: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	b,-34 (ix)
00164$:
;src/Renderer.c:617: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	push	bc
	inc	sp
	ld	h,-9 (ix)
	ld	l,-37 (ix)
	push	hl
	ld	a,-40 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer
	pop	af
	pop	af
00166$:
;src/Renderer.c:620: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-8 (ix)
	or	a, a
	jr	NZ,00173$
;src/Renderer.c:621: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-27 (ix)
	and	a, #0x0F
	jr	Z,00173$
;src/Renderer.c:622: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	h,-34 (ix)
	ld	l,-27 (ix)
	push	hl
	ld	h,-57 (ix)
	ld	l,-40 (ix)
	push	hl
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:624: else if(currentCellID&CELL_ITEM_MASK){
00173$:
;src/Renderer.c:629: ++xCellCount;
	inc	-32 (ix)
;src/Renderer.c:540: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	dec	-51 (ix)
;src/Renderer.c:415: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-36 (ix),l
	ld	-35 (ix),h
;src/Renderer.c:540: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	ld	a,-51 (ix)
	sub	a, #0x50
	jp	NC,00254$
;src/Renderer.c:660: lineStart = lineStart + (offsetDiff * 2) + 3;
	ld	a,-28 (ix)
	add	a, #0x03
	ld	-43 (ix),a
;src/Renderer.c:661: zHeight += zHeight;
	sla	-57 (ix)
;src/Renderer.c:662: offsetDiff = offsetDiff >> 1;
	srl	-50 (ix)
;src/Renderer.c:664: }while(z);
	ld	a,-53 (ix)
	or	a, a
	jp	NZ,00175$
	jp	00260$
;src/Renderer.c:669: do{
00358$:
	ld	-53 (ix),#0x06
00246$:
;src/Renderer.c:671: --z;
	dec	-53 (ix)
;src/Renderer.c:406: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-57 (ix)
	srl	a
	ld	-25 (ix),a
;src/Renderer.c:675: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-53 (ix)
	or	a, a
	jr	Z,00267$
	ld	c,-25 (ix)
	jr	00268$
00267$:
	ld	c,#0x00
00268$:
	ld	-54 (ix),c
;src/Renderer.c:676: lateralWallSlope=0;
	ld	-58 (ix),#0x00
;src/Renderer.c:677: lateralWallSlopeCounter=0;
	ld	-49 (ix),#0x00
;src/Renderer.c:678: xHeight=0;
	ld	-56 (ix),#0x00
;src/Renderer.c:680: lateralWallCounter = 0;
	ld	-20 (ix),#0x00
;src/Renderer.c:682: newCell=1;
	ld	-48 (ix),#0x01
;src/Renderer.c:415: currentCellID = cells_in_view_array[lineStart + 1];
	ld	a,-43 (ix)
	ld	-34 (ix),a
	ld	-33 (ix),#0x00
;src/Renderer.c:683: currentCellID = cells_in_view_array[lineStart + 1];
	ld	c,-34 (ix)
	ld	b,-33 (ix)
	inc	bc
	ld	l,-36 (ix)
	ld	h,-35 (ix)
	add	hl,bc
	ld	a,(hl)
	ld	-52 (ix),a
;src/Renderer.c:685: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
	ld	a,-36 (ix)
	add	a, -43 (ix)
	ld	l,a
	ld	a,-35 (ix)
	adc	a, #0x00
	ld	h,a
	ld	c,(hl)
;src/Renderer.c:686: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00179$
;src/Renderer.c:687: lastWallId=lastCellWasWall;
	ld	-46 (ix),c
;src/Renderer.c:688: lastCellWasWall=1;
	ld	-40 (ix),#0x01
	jr	00336$
00179$:
;src/Renderer.c:691: lastCellWasWall=0;
	ld	-40 (ix),#0x00
;src/Renderer.c:692: lastWallId=CELLTYPE_FLOOR;
	ld	-46 (ix),#0x00
;src/Renderer.c:695: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
00336$:
	ld	-44 (ix),#0x00
	ld	-51 (ix),#0x00
00256$:
;src/Renderer.c:697: if (xCellCount == zHeight)
	ld	a,-54 (ix)
	sub	a, -57 (ix)
	jr	NZ,00182$
;src/Renderer.c:699: ++xCell;
	inc	-44 (ix)
;src/Renderer.c:700: xCellCount = 0;
	ld	-54 (ix),#0x00
;src/Renderer.c:701: newCell=1;
	ld	-48 (ix),#0x01
;src/Renderer.c:702: currentCellID=cells_in_view_array[xCell + lineStart + 1];
	ld	a,-44 (ix)
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
	ld	a,-34 (ix)
	add	a, -2 (ix)
	ld	-2 (ix),a
	ld	a,-33 (ix)
	adc	a, -1 (ix)
	ld	-1 (ix),a
	inc	-2 (ix)
	jr	NZ,00629$
	inc	-1 (ix)
00629$:
	ld	a,-2 (ix)
	add	a, -36 (ix)
	ld	-2 (ix),a
	ld	a,-1 (ix)
	adc	a, -35 (ix)
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-52 (ix),a
00182$:
;src/Renderer.c:704: if(!(x%2)){
	ld	a,-51 (ix)
	and	a, #0x01
	ld	-2 (ix),a
;src/Renderer.c:439: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-52 (ix)
	and	a, #0x80
	ld	-5 (ix),a
;src/Renderer.c:459: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-54 (ix)
	ld	-32 (ix),a
	ld	-31 (ix),#0x00
	ld	a,-57 (ix)
	ld	-9 (ix),a
;src/Renderer.c:704: if(!(x%2)){
	ld	a,-2 (ix)
	or	a, a
	jp	NZ,00195$
;src/Renderer.c:705: if ((lateralWallCounter == 0)||newCell)
	ld	a,-20 (ix)
	or	a, a
	jr	Z,00191$
	ld	a,-48 (ix)
	or	a, a
	jp	Z,00195$
00191$:
;src/Renderer.c:707: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-5 (ix)
	or	a, a
	jr	Z,00189$
;src/Renderer.c:709: lateralWallCounter = 0;//(zHeight - xCellCount);
	ld	-20 (ix),#0x00
;src/Renderer.c:710: lateralWallSlope = 0;
	ld	-58 (ix),#0x00
;src/Renderer.c:711: xHeight = zHeight;
	ld	a,-57 (ix)
	ld	-56 (ix),a
;src/Renderer.c:712: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
	ld	a,-52 (ix)
	sub	a, #0x80
	jr	NZ,00269$
	ld	c,#0x09
	jr	00270$
00269$:
	ld	c,#0x0B
00270$:
	ld	-47 (ix),c
;src/Renderer.c:713: lastCellWasWall = 1;
	ld	-40 (ix),#0x01
;src/Renderer.c:714: lastWallId=currentCellID;
	ld	a,-52 (ix)
	ld	-46 (ix),a
	jp	00190$
00189$:
;src/Renderer.c:717: if(lateralWallCounter==0){//Lateral wall not finished
	ld	a,-20 (ix)
	or	a, a
	jp	NZ,00190$
;src/Renderer.c:718: if (lastCellWasWall)
	ld	a,-40 (ix)
	or	a, a
	jp	Z,00184$
;src/Renderer.c:721: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-50 (ix)
	sub	a, -44 (ix)
	add	a, a
	inc	a
;src/Renderer.c:722: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-58 (ix), a
	srl	a
	ld	-49 (ix),a
;src/Renderer.c:723: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-57 (ix)
	ld	h,-58 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00632$:
	add	hl,hl
	jr	NC,00633$
	add	hl,de
00633$:
	djnz	00632$
	ld	-26 (ix), l
	ld	a, l
;src/Renderer.c:724: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
	ld	-55 (ix), a
	and	a, #0xFC
	ld	-26 (ix), a
	set	0, a
	ld	-26 (ix), a
	srl	a
	srl	a
	sub	a, -54 (ix)
	ld	-20 (ix),a
;src/Renderer.c:726: lastCellWasWall = 0;
	ld	-40 (ix),#0x00
;src/Renderer.c:727: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-32 (ix)
	ld	-30 (ix),a
	ld	a,-31 (ix)
	ld	-29 (ix),a
	sla	-30 (ix)
	rl	-29 (ix)
	ld	a,-58 (ix)
	ld	-23 (ix),a
	ld	-22 (ix),#0x00
	ld	l,-23 (ix)
	ld	h,-22 (ix)
	push	hl
	ld	l,-30 (ix)
	ld	h,-29 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-29 (ix),h
	ld	-30 (ix), l
	ld	-26 (ix), l
	ld	a,-9 (ix)
	sub	a, -26 (ix)
	ld	-56 (ix),a
;src/Renderer.c:728: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
	ld	a,-46 (ix)
	sub	a, #0x80
	jr	NZ,00271$
	ld	c,#0x0A
	jr	00272$
00271$:
	ld	c,#0x0C
00272$:
	ld	-47 (ix),c
	jr	00190$
00184$:
;src/Renderer.c:732: xHeight = 0;
	ld	-56 (ix),#0x00
;src/Renderer.c:733: lastCellWasWall = 0;
	ld	-40 (ix),#0x00
;src/Renderer.c:734: lateralWallSlope=0;
	ld	-58 (ix),#0x00
;src/Renderer.c:735: lastWallId=0;
	ld	-46 (ix),#0x00
00190$:
;src/Renderer.c:739: newCell=0;
	ld	-48 (ix),#0x00
00195$:
;src/Renderer.c:742: if (lateralWallCounter > 0)
	ld	a,-20 (ix)
	or	a, a
	jr	Z,00201$
;src/Renderer.c:745: if (lateralWallSlope != 0)
	ld	a,-58 (ix)
	or	a, a
	jr	Z,00199$
;src/Renderer.c:747: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-58 (ix)
	sub	a, -49 (ix)
	jr	NZ,00197$
;src/Renderer.c:749: lateralWallSlopeCounter = 0;
	ld	-49 (ix),#0x00
;src/Renderer.c:750: xHeight -= 2;
	dec	-56 (ix)
	dec	-56 (ix)
00197$:
;src/Renderer.c:752: ++lateralWallSlopeCounter;
	inc	-49 (ix)
00199$:
;src/Renderer.c:755: --lateralWallCounter;
	dec	-20 (ix)
00201$:
;src/Renderer.c:498: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-57 (ix)
	ld	-30 (ix),a
	ld	-29 (ix),#0x00
;src/Renderer.c:758: if (!(x%2))
	ld	a,-2 (ix)
	or	a, a
	jr	NZ,00210$
;src/Renderer.c:761: draw_column_to_buffer_untextured(x/2, xHeight, color);
	ld	a,-51 (ix)
	srl	a
	ld	-2 (ix),a
;src/Renderer.c:760: if(xHeight > 0){
	ld	a,-56 (ix)
	or	a, a
	jr	Z,00203$
;src/Renderer.c:761: draw_column_to_buffer_untextured(x/2, xHeight, color);
	ld	h,-47 (ix)
	ld	l,-56 (ix)
	push	hl
	ld	a,-2 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer_untextured
	pop	af
	inc	sp
00203$:
;src/Renderer.c:764: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-5 (ix)
	or	a, a
	jr	NZ,00210$
;src/Renderer.c:765: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-52 (ix)
	and	a, #0x0F
	jr	Z,00210$
;src/Renderer.c:766: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	a,-32 (ix)
	ld	-5 (ix),a
	ld	a,-31 (ix)
	ld	-4 (ix),a
	ld	a,#0x05+1
	jr	00642$
00641$:
	sla	-5 (ix)
	rl	-4 (ix)
00642$:
	dec	a
	jr	NZ,00641$
	ld	l,-30 (ix)
	ld	h,-29 (ix)
	push	hl
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-4 (ix),h
	ld	-5 (ix), l
	ld	b, l
	push	bc
	inc	sp
	ld	h,-52 (ix)
	ld	l,-57 (ix)
	push	hl
	ld	a,-2 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:768: else if(currentCellID&CELL_ITEM_MASK){
00210$:
;src/Renderer.c:774: ++xCellCount;
	inc	-54 (ix)
;src/Renderer.c:695: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	inc	-51 (ix)
;src/Renderer.c:415: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-36 (ix),l
	ld	-35 (ix),h
;src/Renderer.c:695: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	ld	a,-51 (ix)
	sub	a, #0x50
	jp	C,00256$
;src/Renderer.c:781: xCellCount = (z) ? (zHeight >> 1) : 0 ;
	ld	a,-53 (ix)
	or	a, a
	jr	Z,00273$
	ld	a,-25 (ix)
	ld	-25 (ix),a
	jr	00274$
00273$:
	ld	-25 (ix),#0x00
00274$:
	ld	a,-25 (ix)
	ld	-25 (ix),a
;src/Renderer.c:782: lateralWallSlope=0;
	ld	-20 (ix),#0x00
;src/Renderer.c:783: lateralWallSlopeCounter=0;
	ld	-34 (ix),#0x00
;src/Renderer.c:784: xHeight=0;
	ld	-40 (ix),#0x00
;src/Renderer.c:786: lateralWallCounter = 0;
	ld	-2 (ix),#0x00
;src/Renderer.c:525: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	a,-50 (ix)
	add	a, a
	ld	-5 (ix),a
	ld	a,-43 (ix)
	add	a, -5 (ix)
;src/Renderer.c:787: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	-5 (ix), a
	add	a, #0x02
	ld	-42 (ix),a
;src/Renderer.c:789: newCell=1;
	ld	-26 (ix),#0x01
;src/Renderer.c:528: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	a,-42 (ix)
	ld	-32 (ix),a
	ld	-31 (ix),#0x00
;src/Renderer.c:790: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	a,-32 (ix)
	add	a,#0xFF
	ld	-23 (ix),a
	ld	a,-31 (ix)
	adc	a,#0xFF
	ld	-22 (ix),a
	ld	a,-36 (ix)
	add	a, -23 (ix)
	ld	-23 (ix),a
	ld	a,-35 (ix)
	adc	a, -22 (ix)
	ld	-22 (ix),a
	ld	l,-23 (ix)
	ld	h,-22 (ix)
	ld	a,(hl)
	ld	-21 (ix),a
;src/Renderer.c:792: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
	ld	a,-36 (ix)
	add	a, -42 (ix)
	ld	-23 (ix),a
	ld	a,-35 (ix)
	adc	a, #0x00
	ld	-22 (ix),a
	ld	l,-23 (ix)
	ld	h,-22 (ix)
	ld	a,(hl)
	ld	-37 (ix),a
;src/Renderer.c:793: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, -37 (ix)
	jr	Z,00213$
;src/Renderer.c:794: lastWallId=lastCellWasWall;
;src/Renderer.c:795: lastCellWasWall=1;
	ld	-41 (ix),#0x01
	jr	00356$
00213$:
;src/Renderer.c:798: lastCellWasWall=0;
	ld	-41 (ix),#0x00
;src/Renderer.c:799: lastWallId=CELLTYPE_FLOOR;
	ld	-37 (ix),#0x00
;src/Renderer.c:802: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
00356$:
	ld	-44 (ix),#0x00
	ld	-51 (ix),#0x9F
00258$:
;src/Renderer.c:805: if (xCellCount == zHeight)
	ld	a,-57 (ix)
	sub	a, -25 (ix)
	jr	NZ,00216$
;src/Renderer.c:807: ++xCell;
	inc	-44 (ix)
;src/Renderer.c:808: xCellCount = 0;
	ld	-25 (ix),#0x00
;src/Renderer.c:809: newCell=1;
	ld	-26 (ix),#0x01
;src/Renderer.c:810: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
	ld	a,-44 (ix)
	ld	-23 (ix),a
	ld	-22 (ix),#0x00
	ld	a,-32 (ix)
	sub	a, -23 (ix)
	ld	-23 (ix),a
	ld	a,-31 (ix)
	sbc	a, -22 (ix)
	ld	-22 (ix),a
	ld	l,-23 (ix)
	ld	h,-22 (ix)
	dec	hl
	ld	-23 (ix),l
	ld	-22 (ix),h
	ld	a,-36 (ix)
	add	a, -23 (ix)
	ld	-23 (ix),a
	ld	a,-35 (ix)
	adc	a, -22 (ix)
	ld	-22 (ix),a
	ld	l,-23 (ix)
	ld	h,-22 (ix)
	ld	a,(hl)
	ld	-21 (ix),a
00216$:
;src/Renderer.c:812: if(!(x%2)){
	ld	a,-51 (ix)
	and	a, #0x01
	ld	-28 (ix),a
;src/Renderer.c:439: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-21 (ix)
	and	a, #0x80
	ld	-23 (ix),a
;src/Renderer.c:459: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-25 (ix)
	ld	-17 (ix),a
	ld	-16 (ix),#0x00
;src/Renderer.c:812: if(!(x%2)){
	ld	a,-28 (ix)
	or	a, a
	jp	NZ,00229$
;src/Renderer.c:813: if (lateralWallCounter == 0 || newCell)
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00225$
	ld	a,-26 (ix)
	or	a, a
	jp	Z,00229$
00225$:
;src/Renderer.c:815: if ( currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-23 (ix)
	or	a, a
	jr	Z,00223$
;src/Renderer.c:817: lateralWallCounter = 0;
	ld	-2 (ix),#0x00
;src/Renderer.c:818: lateralWallSlope = 0;
	ld	-20 (ix),#0x00
;src/Renderer.c:819: xHeight = zHeight;
	ld	a,-57 (ix)
	ld	-40 (ix),a
;src/Renderer.c:820: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
	ld	a,-21 (ix)
	sub	a, #0x80
	jr	NZ,00275$
	ld	-27 (ix),#0x09
	jr	00276$
00275$:
	ld	-27 (ix),#0x0B
00276$:
	ld	a,-27 (ix)
	ld	-47 (ix),a
;src/Renderer.c:821: lastCellWasWall = 1;
	ld	-41 (ix),#0x01
;src/Renderer.c:822: lastWallId=currentCellID;
	ld	a,-21 (ix)
	ld	-37 (ix),a
	jp	00224$
00223$:
;src/Renderer.c:824: else if(lateralWallCounter==0){
	ld	a,-2 (ix)
	or	a, a
	jp	NZ,00224$
;src/Renderer.c:825: if (lastCellWasWall)
	ld	a,-41 (ix)
	or	a, a
	jp	Z,00218$
;src/Renderer.c:828: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-50 (ix)
	sub	a, -44 (ix)
	add	a, a
	inc	a
;src/Renderer.c:829: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-20 (ix), a
	srl	a
	ld	-34 (ix),a
;src/Renderer.c:830: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-57 (ix)
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
;src/Renderer.c:831: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
	ld	-27 (ix), l
	ld	-15 (ix), l
	ld	-14 (ix),#0x00
	ld	a,-27 (ix)
	and	a, #0x03
	ld	-27 (ix), a
	ld	-12 (ix),a
	ld	-11 (ix),#0x00
	ld	a,-15 (ix)
	sub	a, -12 (ix)
	ld	-12 (ix),a
	ld	a,-14 (ix)
	sbc	a, -11 (ix)
	ld	-11 (ix),a
	ld	a,-12 (ix)
	add	a, #0x01
	ld	-15 (ix),a
	ld	a,-11 (ix)
	adc	a, #0x00
	ld	-14 (ix),a
	ld	a,-15 (ix)
	ld	-7 (ix),a
	ld	a,-14 (ix)
	ld	-6 (ix),a
	bit	7, -14 (ix)
	jr	Z,00277$
	ld	a,-12 (ix)
	add	a, #0x04
	ld	-7 (ix),a
	ld	a,-11 (ix)
	adc	a, #0x00
	ld	-6 (ix),a
00277$:
	ld	c,-7 (ix)
	ld	b,-6 (ix)
	sra	b
	rr	c
	sra	b
	rr	c
	ld	b,-25 (ix)
	ld	a,c
	sub	a, b
	ld	-2 (ix),a
;src/Renderer.c:833: lastCellWasWall = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:834: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	add	hl, hl
	ld	c,-20 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-9 (ix)
	sub	a, l
	ld	-40 (ix),a
;src/Renderer.c:835: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
	ld	a,-37 (ix)
	sub	a, #0x80
	jr	NZ,00278$
	ld	c,#0x0A
	jr	00279$
00278$:
	ld	c,#0x0C
00279$:
	ld	-47 (ix),c
	jr	00224$
00218$:
;src/Renderer.c:839: xHeight = 0;
	ld	-40 (ix),#0x00
;src/Renderer.c:840: lastCellWasWall = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:841: lateralWallSlope=0;
	ld	-20 (ix),#0x00
;src/Renderer.c:842: lastWallId=0;
	ld	-37 (ix),#0x00
00224$:
;src/Renderer.c:845: newCell=0;
	ld	-26 (ix),#0x00
00229$:
;src/Renderer.c:850: if (lateralWallCounter > 0)
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00235$
;src/Renderer.c:853: if (lateralWallSlope != 0)
	ld	a,-20 (ix)
	or	a, a
	jr	Z,00233$
;src/Renderer.c:855: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-20 (ix)
	sub	a, -34 (ix)
	jr	NZ,00231$
;src/Renderer.c:857: lateralWallSlopeCounter = 0;
	ld	-34 (ix),#0x00
;src/Renderer.c:858: xHeight -= 2;
	dec	-40 (ix)
	dec	-40 (ix)
00231$:
;src/Renderer.c:860: ++lateralWallSlopeCounter;
	inc	-34 (ix)
00233$:
;src/Renderer.c:862: --lateralWallCounter;
	dec	-2 (ix)
00235$:
;src/Renderer.c:866: if (!(x%2))
	ld	a,-28 (ix)
	or	a, a
	jr	NZ,00244$
;src/Renderer.c:871: draw_column_to_buffer_untextured(x/2, xHeight, color);
	ld	b,-51 (ix)
	srl	b
;src/Renderer.c:869: if(xHeight > 0){
	ld	a,-40 (ix)
	or	a, a
	jr	Z,00237$
;src/Renderer.c:871: draw_column_to_buffer_untextured(x/2, xHeight, color);
	push	bc
	ld	h,-47 (ix)
	ld	l,-40 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_untextured
	pop	af
	inc	sp
	pop	bc
00237$:
;src/Renderer.c:874: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-23 (ix)
	or	a, a
	jr	NZ,00244$
;src/Renderer.c:875: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-21 (ix)
	and	a, #0x0F
	jr	Z,00244$
;src/Renderer.c:876: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	a,-30 (ix)
	sub	a, -17 (ix)
	ld	l,a
	ld	a,-29 (ix)
	sbc	a, -16 (ix)
	ld	h,a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	ld	e,-30 (ix)
	ld	d,-29 (ix)
	push	de
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	d,l
	pop	bc
	push	de
	inc	sp
	ld	h,-21 (ix)
	ld	l,-57 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:878: else if(currentCellID&CELL_ITEM_MASK){
00244$:
;src/Renderer.c:883: ++xCellCount;
	inc	-25 (ix)
;src/Renderer.c:802: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	dec	-51 (ix)
;src/Renderer.c:415: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-36 (ix),l
	ld	-35 (ix),h
;src/Renderer.c:802: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	ld	a,-51 (ix)
	sub	a, #0x50
	jp	NC,00258$
;src/Renderer.c:912: lineStart = lineStart + (offsetDiff * 2) + 3;
	ld	a,-5 (ix)
	add	a, #0x03
	ld	-43 (ix),a
;src/Renderer.c:913: zHeight += zHeight;
	sla	-57 (ix)
;src/Renderer.c:914: offsetDiff = offsetDiff >> 1;
	srl	-50 (ix)
;src/Renderer.c:916: }while(z);
	ld	a,-53 (ix)
	or	a, a
	jp	NZ,00246$
00260$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:922: void draw_minimap_to_buffer(){
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
;src/Renderer.c:925: u8* ptr = MINIMAP_BUFFER;
	ld	bc,#0xAAA0
;src/Renderer.c:930: y=(player_position.y-MINIMAP_HEIGHT_HALF);
	ld	a, (#(_player_position + 0x0001) + 0)
	add	a,#0xF8
	ld	e,a
;src/Renderer.c:932: for(j=0;j<MINIMAP_HEIGHT;++j){
	ld	d,#0x00
;src/Renderer.c:933: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
00137$:
	ld	a,e
	rlca
	and	a,#0x01
	ld	-5 (ix),a
	ld	a,e
	xor	a, #0x80
	sub	a, #0xA0
	ld	a,#0x00
	rla
	ld	-1 (ix),a
	ld	-11 (ix),#0x00
00122$:
;src/Renderer.c:934: x=(player_position.x-MINIMAP_WIDTH_HALF);
	ld	a, (#_player_position + 0)
	add	a,#0xF8
	ld	-4 (ix),a
;src/Renderer.c:935: for(i=0;i<MINIMAP_WIDTH;++i){
	ld	-10 (ix),#0x00
00120$:
;src/Renderer.c:938: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	iy,#0x0010
	add	iy, bc
;src/Renderer.c:936: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
	bit	7, -4 (ix)
	jr	NZ,00111$
	ld	a,-4 (ix)
	xor	a, #0x80
	sub	a, #0xA0
	jr	NC,00111$
	ld	a,-5 (ix)
	or	a, a
	jr	NZ,00111$
	bit	0,-1 (ix)
	jr	NZ,00112$
00111$:
;src/Renderer.c:937: *ptr=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	(bc),a
;src/Renderer.c:938: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	0 (iy), a
	jp	00113$
00112$:
;src/Renderer.c:940: else if((x==player_position.x)&&(y==player_position.y)){
	ld	a,-4 (ix)
	ld	-3 (ix),a
	ld	a,-4 (ix)
	rla
	sbc	a, a
	ld	-2 (ix),a
	ld	a, (#_player_position + 0)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
	ld	-7 (ix),e
	ld	a,e
	rla
	sbc	a, a
	ld	-6 (ix),a
	ld	a,-3 (ix)
	sub	a, -9 (ix)
	jr	NZ,00108$
	ld	a,-2 (ix)
	sub	a, -8 (ix)
	jr	NZ,00108$
	ld	a, (#(_player_position + 0x0001) + 0)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
	ld	a,-7 (ix)
	sub	a, -9 (ix)
	jr	NZ,00108$
	ld	a,-6 (ix)
	sub	a, -8 (ix)
	jr	NZ,00108$
;src/Renderer.c:941: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
	ld	a, (#(_g_colors + 0x0004) + 0)
	ld	(bc),a
;src/Renderer.c:942: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
	ld	a, (#(_g_colors + 0x0004) + 0)
	ld	0 (iy), a
	jr	00113$
00108$:
;src/Renderer.c:945: val = (*(u8*)(MAP_MEM+x+y*MAP_WIDTH));
	ld	a,-3 (ix)
	add	a, #0x00
	ld	-9 (ix),a
	ld	a,-2 (ix)
	adc	a, #0x70
	ld	-8 (ix),a
	ld	l,-7 (ix)
	ld	h,-6 (ix)
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
;src/Renderer.c:947: if(val==CELLTYPE_DOOR){
	ld	a,h
	sub	a, #0x80
	jr	NZ,00105$
;src/Renderer.c:948: *ptr=g_colors[MINIMAP_EXIT_COLOR];
	ld	a, (#(_g_colors + 0x0005) + 0)
	ld	(bc),a
;src/Renderer.c:949: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
	ld	a, (#(_g_colors + 0x0005) + 0)
	ld	0 (iy), a
	jr	00113$
00105$:
;src/Renderer.c:951: else if(val&CELL_WALL_MASK){
	add	hl, hl
	jr	NC,00102$
;src/Renderer.c:952: *ptr=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	(bc),a
;src/Renderer.c:953: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	0 (iy), a
	jr	00113$
00102$:
;src/Renderer.c:956: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
	ld	a, (#(_g_colors + 0x0003) + 0)
	ld	(bc),a
;src/Renderer.c:957: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
	ld	a, (#(_g_colors + 0x0003) + 0)
	ld	0 (iy), a
00113$:
;src/Renderer.c:960: ++x;
	inc	-4 (ix)
;src/Renderer.c:961: ++ptr;
	inc	bc
;src/Renderer.c:935: for(i=0;i<MINIMAP_WIDTH;++i){
	inc	-10 (ix)
	ld	a,-10 (ix)
	sub	a, #0x10
	jp	C,00120$
;src/Renderer.c:933: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
	inc	-11 (ix)
	ld	a,-11 (ix)
	sub	a, #0x04
	jp	C,00122$
;src/Renderer.c:964: ++y;
	inc	e
;src/Renderer.c:932: for(j=0;j<MINIMAP_HEIGHT;++j){
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
