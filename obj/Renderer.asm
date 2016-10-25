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
	.globl _item_get_at
	.globl _enemy_get_at
	.globl _cpct_memset
	.globl _offsets_cells_in_view
	.globl _cells_in_view_array
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
	ld	-3 (ix), a
	or	a, a
	jr	Z,00102$
;src/Renderer.c:57: vert=1;
	ld	-14 (ix),#0x01
;src/Renderer.c:58: dy=player_direction.y;
	ld	c,-3 (ix)
	ld	-12 (ix),c
;src/Renderer.c:59: dx=-player_direction.y;
	xor	a, a
	sub	a, -3 (ix)
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
	ld	-3 (ix), a
	ld	-12 (ix),a
;src/Renderer.c:67: dx=player_direction.x;
	ld	a,-3 (ix)
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
	ld	a,-3 (ix)
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
	ld	-3 (ix),a
	ld	a,-12 (ix)
	rlca
	and	a,#0x01
	ld	-1 (ix),a
	ld	-8 (ix),#0x00
;src/Renderer.c:79: for(i=offset;i<35-offset;++i){
00138$:
	ld	a,-7 (ix)
	ld	-2 (ix),a
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
	add	a, -2 (ix)
	ld	-5 (ix),a
	ld	a,h
	adc	a, #0x00
	ld	-4 (ix),a
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
	ld	l,a
	rla
	sbc	a, a
	ld	h,a
	ld	a,l
	add	a, #0xD0
	ld	b,a
	ld	a,h
	adc	a, #0x88
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
	ld	a,l
	add	a, b
	ld	l,a
	ld	a,h
	adc	a, d
	ld	h,a
	ld	b,(hl)
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	(hl),b
	jr	00106$
00105$:
;src/Renderer.c:85: cells_in_view_array[n]=CELLTYPE_WALL1;
	ld	l,-5 (ix)
	ld	h,-4 (ix)
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
	inc	-2 (ix)
;src/Renderer.c:79: for(i=offset;i<35-offset;++i){
	inc	-9 (ix)
	jp	00125$
00143$:
	ld	a,-2 (ix)
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
	ld	-5 (ix),a
;src/Renderer.c:99: if(vert){
	ld	a,-14 (ix)
	or	a, a
	jr	Z,00121$
;src/Renderer.c:100: y-=dy;
	ld	a,-13 (ix)
	sub	a, -12 (ix)
	ld	-13 (ix),a
;src/Renderer.c:101: if(dx<0) x=x0-offset;
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00115$
	ld	a,-10 (ix)
	sub	a, -5 (ix)
	ld	e,a
	jr	00128$
00115$:
;src/Renderer.c:102: else x=x0+offset;
	ld	a,-10 (ix)
	add	a, -5 (ix)
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
	sub	a, -5 (ix)
	ld	-13 (ix),a
	jr	00128$
00118$:
;src/Renderer.c:108: else y=y0+offset;
	ld	a,c
	add	a, -5 (ix)
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
_cells_in_view_array:
	.dw #0xBDF0
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
	add	a, #0x50
	ld	c,a
	ld	a,#0x00
	adc	a, #0xAA
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
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-9
	add	hl,sp
	ld	sp,hl
;src/Renderer.c:164: u16 texture_line=0;
	ld	hl,#0x0000
	ex	(sp), hl
;src/Renderer.c:167: if(texture_column>=8 && texture_column<24){
	ld	a,7 (ix)
	sub	a, #0x08
	jp	C,00110$
	ld	a,7 (ix)
	sub	a, #0x18
	jp	NC,00110$
;src/Renderer.c:169: index = index>>4;
	ld	a,6 (ix)
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0F
;src/Renderer.c:172: texture = (u8*)(UNCOMPRESSED_OBJECT_TEXTURES + ((ITEM_SPRITE_WIDTH*ITEM_SPRITE_HEIGHT)*(item_get_at(index-1)->type)) + ((texture_column-8)*ITEM_SPRITE_WIDTH));
	ld	6 (ix), a
	ld	b, a
	dec	b
	push	bc
	inc	sp
	call	_item_get_at
	inc	sp
	inc	hl
	inc	hl
	inc	hl
	ld	b, (hl)
	ld	c,#0x00
	ld	hl,#0xA550
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	a, 7 (ix)
	ld	d, #0x00
	add	a,#0xF8
	ld	l,a
	ld	a,d
	adc	a,#0xFF
	ld	h,a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	-5 (ix),l
	ld	-4 (ix),h
;src/Renderer.c:174: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a, 4 (ix)
	srl	a
	add	a, #0x50
	ld	c,a
	ld	a,#0x00
	adc	a, #0xAA
	ld	b,a
;src/Renderer.c:176: pixMask = g_pixelMask[column&1];
	ld	de,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l,a
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	-3 (ix),a
;src/Renderer.c:178: lineHeight = (lineHeight)/2;
	srl	5 (ix)
;src/Renderer.c:179: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight/2);
	ld	a,5 (ix)
	srl	a
	add	a, #0x32
;src/Renderer.c:180: item_top_height = ground_height - lineHeight;
	sub	a, 5 (ix)
	ld	e,a
;src/Renderer.c:182: texture_line_add = (256*ITEM_SPRITE_HEIGHT)/lineHeight;
	ld	l,5 (ix)
	ld	h,#0x00
	push	bc
	push	de
	push	hl
	ld	hl,#0x1000
	push	hl
	call	__divsint
	pop	af
	pop	af
	pop	de
	pop	bc
	ld	-7 (ix),l
	ld	-6 (ix),h
;src/Renderer.c:183: j=lineHeight;
	ld	a,5 (ix)
	ld	-2 (ix),a
;src/Renderer.c:189: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * item_top_height;
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:191: for(j;j;--j){
	ld	a,-3 (ix)
	cpl
	ld	-1 (ix),a
00108$:
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00110$
;src/Renderer.c:193: color= *(texture+(texture_line/256));
	ld	e,-8 (ix)
	ld	d,#0x00
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	add	hl,de
	ld	e,(hl)
;src/Renderer.c:195: if(color){
	ld	a,e
	or	a, a
	jr	Z,00102$
;src/Renderer.c:196: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, -1 (ix)
	ld	l,a
;src/Renderer.c:198: color = (color&pixMask);
	ld	a,e
	and	a, -3 (ix)
;src/Renderer.c:200: *pvmem = val|color;
	or	a, l
	ld	(bc),a
00102$:
;src/Renderer.c:203: texture_line += texture_line_add;
	ld	a,-9 (ix)
	add	a, -7 (ix)
	ld	-9 (ix),a
	ld	a,-8 (ix)
	adc	a, -6 (ix)
	ld	-8 (ix),a
;src/Renderer.c:205: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:191: for(j;j;--j){
	dec	-2 (ix)
	jr	00108$
00110$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:212: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
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
;src/Renderer.c:229: u16 texture_line=0;
	ld	-9 (ix),#0x00
	ld	-8 (ix),#0x00
;src/Renderer.c:231: if(texture_column>=4 && texture_column<28){
	ld	a,7 (ix)
	sub	a, #0x04
	jp	C,00112$
	ld	a,7 (ix)
	sub	a, #0x1C
	jp	NC,00112$
;src/Renderer.c:234: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(enemy_get_at(index-1)->type)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
	ld	b,6 (ix)
	dec	b
	push	bc
	inc	sp
	call	_enemy_get_at
	inc	sp
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
	ld	bc,#0xA0D0
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
;src/Renderer.c:236: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a,4 (ix)
	srl	a
	add	a, #0x50
	ld	-6 (ix),a
	ld	a,#0x00
	adc	a, #0xAA
	ld	-5 (ix),a
;src/Renderer.c:238: pixMask = g_pixelMask[column&1];
	ld	bc,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l, a
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-7 (ix),a
;src/Renderer.c:240: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
	ld	a,5 (ix)
	srl	a
	add	a, #0x32
	ld	-12 (ix),a
;src/Renderer.c:241: lineHeight = (lineHeight*3)/4;
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
;src/Renderer.c:242: enemy_top_height = ground_height - lineHeight;
	ld	a,-12 (ix)
	sub	a, b
	ld	c,a
;src/Renderer.c:244: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
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
	ld	-11 (ix),l
	ld	-10 (ix),h
;src/Renderer.c:245: j=lineHeight;
	ld	d,b
;src/Renderer.c:247: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
	ld	a,#0x64
	sub	a, b
	jr	NC,00102$
;src/Renderer.c:248: j=90;
	ld	d,#0x5A
00102$:
;src/Renderer.c:251: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
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
;src/Renderer.c:253: for(j;j;--j){
	ld	a,-7 (ix)
	cpl
	ld	e,a
00110$:
	ld	a,d
	or	a, a
	jr	Z,00112$
;src/Renderer.c:255: color= *(texture+(texture_line/256));
	ld	l,-8 (ix)
	ld	h,#0x00
	ld	a,-14 (ix)
	add	a, l
	ld	l,a
	ld	a,-13 (ix)
	adc	a, h
	ld	h,a
	ld	a,(hl)
;src/Renderer.c:257: if(color){
	ld	-4 (ix), a
	or	a, a
	jr	Z,00104$
;src/Renderer.c:258: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, e
	ld	l,a
;src/Renderer.c:260: color = (color&pixMask);
	ld	a,-4 (ix)
	and	a, -7 (ix)
;src/Renderer.c:262: *pvmem = val|color;
	or	a, l
	ld	(bc),a
00104$:
;src/Renderer.c:265: texture_line += texture_line_add;
	ld	a,-9 (ix)
	add	a, -11 (ix)
	ld	-9 (ix),a
	ld	a,-8 (ix)
	adc	a, -10 (ix)
	ld	-8 (ix),a
;src/Renderer.c:267: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:253: for(j;j;--j){
	dec	d
	jr	00110$
00112$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:359: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
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
;src/Renderer.c:360: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a,4 (ix)
	srl	a
	add	a, #0x50
	ld	-6 (ix),a
	ld	a,#0x00
	adc	a, #0xAA
	ld	-5 (ix),a
;src/Renderer.c:363: u8 pixMask = g_pixelMask[column&1];
	ld	bc,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l, a
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-13 (ix),a
;src/Renderer.c:368: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
	ld	a, 6 (ix)
	add	a, a
	add	a, a
	ld	b,a
	ld	c,#0x00
	ld	hl,#0x8CD0
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
;src/Renderer.c:370: u8 j=lineHeight;
	ld	a,5 (ix)
;src/Renderer.c:376: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
	ld	-11 (ix), a
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	hl,#0x2000
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-8 (ix),l
	ld	-7 (ix),h
;src/Renderer.c:377: u16 wall_texture_line=0;
	ld	hl,#0x0000
	ex	(sp), hl
;src/Renderer.c:379: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
	ld	c,-11 (ix)
	srl	c
	ld	a,#0x32
	sub	a, c
	ld	-12 (ix),a
;src/Renderer.c:383: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
	ld	a,#0x64
	sub	a, -11 (ix)
	jr	NC,00102$
;src/Renderer.c:384: ceiling_height=0;
	ld	-12 (ix),#0x00
;src/Renderer.c:385: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
	ld	a,-2 (ix)
	add	a,#0x9C
	ld	c,a
	ld	a,-1 (ix)
	adc	a,#0xFF
	ld	b,a
	ld	-4 (ix),c
	ld	-3 (ix),b
	bit	7, b
	jr	Z,00111$
	ld	a,-2 (ix)
	add	a, #0x9D
	ld	-4 (ix),a
	ld	a,-1 (ix)
	adc	a, #0xFF
	ld	-3 (ix),a
00111$:
	ld	c,-4 (ix)
	ld	b,-3 (ix)
	sra	b
	rr	c
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	push	bc
	call	__mulint
	pop	af
	pop	af
	inc	sp
	inc	sp
	push	hl
;src/Renderer.c:386: j=SCREEN_TEXTURE_HEIGHT;
	ld	-11 (ix),#0x64
00102$:
;src/Renderer.c:389: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
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
	ld	a,-6 (ix)
	add	a, l
	ld	c,a
	ld	a,-5 (ix)
	adc	a, h
	ld	b,a
;src/Renderer.c:391: for(j;j;--j){
	ld	a,-13 (ix)
	cpl
	ld	-4 (ix),a
	ld	d,-11 (ix)
00107$:
	ld	a,d
	or	a, a
	jr	Z,00109$
;src/Renderer.c:393: w_color = *(texture+(wall_texture_line/256));
	ld	a, -14 (ix)
	ld	h, #0x00
	add	a, -10 (ix)
	ld	l,a
	ld	a,h
	adc	a, -9 (ix)
	ld	h,a
	ld	e,(hl)
;src/Renderer.c:395: if(w_color){
	ld	a,e
	or	a, a
	jr	Z,00104$
;src/Renderer.c:397: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, -4 (ix)
	ld	l,a
;src/Renderer.c:399: w_color = (w_color&pixMask);
	ld	a,e
	and	a, -13 (ix)
;src/Renderer.c:401: *pvmem = val|w_color;
	or	a, l
	ld	(bc),a
00104$:
;src/Renderer.c:405: wall_texture_line += wall_texture_line_add;
	ld	a,-15 (ix)
	add	a, -8 (ix)
	ld	-15 (ix),a
	ld	a,-14 (ix)
	adc	a, -7 (ix)
	ld	-14 (ix),a
;src/Renderer.c:407: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:391: for(j;j;--j){
	dec	d
	jr	00107$
00109$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:411: void render_draw_to_buffer(){//TODO Optimize
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
;src/Renderer.c:423: u8 zHeight = 5;
	ld	-46 (ix),#0x05
;src/Renderer.c:433: u8 offsetDiff = 16;
	ld	-49 (ix),#0x10
;src/Renderer.c:438: u8 lineStart = 0;
	ld	-57 (ix),#0x00
;src/Renderer.c:440: u8 lateralWallWidth=0;
	ld	-50 (ix),#0x00
;src/Renderer.c:452: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
	ld	hl, #_g_colors + 7
	ld	b,(hl)
	ld	hl,#0x07A8
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xAA50
	push	hl
	call	_cpct_memset
;src/Renderer.c:453: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
	ld	hl, #_g_colors + 1
	ld	b,(hl)
	ld	hl,#0x0050
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xB1F8
	push	hl
	call	_cpct_memset
;src/Renderer.c:454: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
	ld	hl, #_g_colors + 8
	ld	b,(hl)
	ld	hl,#0x07A8
	push	hl
	push	bc
	inc	sp
	ld	hl,#0xB248
	push	hl
	call	_cpct_memset
;src/Renderer.c:456: calculate_cells_in_view();
	call	_calculate_cells_in_view
;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-25 (ix),l
	ld	-24 (ix),h
;src/Renderer.c:458: if(textures_on){
	ld	a,(#_textures_on + 0)
	or	a, a
	jp	Z,00370$
;src/Renderer.c:460: do{
	ld	-54 (ix),#0x06
00179$:
;src/Renderer.c:462: --z;
	dec	-54 (ix)
;src/Renderer.c:466: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-46 (ix)
	srl	a
	ld	-21 (ix),a
	ld	a,-54 (ix)
	or	a, a
	jr	Z,00270$
	ld	c,-21 (ix)
	jr	00271$
00270$:
	ld	c,#0x00
00271$:
	ld	-18 (ix),c
;src/Renderer.c:467: lateralWallSlope=0;
	ld	-16 (ix),#0x00
;src/Renderer.c:468: lateralWallSlopeCounter=0;
	ld	-7 (ix),#0x00
;src/Renderer.c:469: xHeight=0;
	ld	-38 (ix),#0x00
;src/Renderer.c:472: lateralWallCounter = 0;
	ld	-39 (ix),#0x00
;src/Renderer.c:474: newCell=1;
	ld	-36 (ix),#0x01
;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
	ld	a,-57 (ix)
	ld	-29 (ix),a
	ld	-28 (ix),#0x00
	ld	c,-29 (ix)
	ld	b,-28 (ix)
	inc	bc
	ld	l,-25 (ix)
	ld	h,-24 (ix)
	add	hl,bc
	ld	a,(hl)
	ld	-37 (ix),a
;src/Renderer.c:477: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
	ld	a,-25 (ix)
	add	a, -57 (ix)
	ld	l,a
	ld	a,-24 (ix)
	adc	a, #0x00
	ld	h,a
	ld	c,(hl)
;src/Renderer.c:478: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00102$
;src/Renderer.c:479: lastWallId=lastCellWasWall;
	ld	-41 (ix),c
;src/Renderer.c:480: lastCellWasWall=1;
	ld	-17 (ix),#0x01
	jr	00305$
00102$:
;src/Renderer.c:483: lastCellWasWall=0;
	ld	-17 (ix),#0x00
;src/Renderer.c:484: lastWallId=CELLTYPE_FLOOR;
	ld	-41 (ix),#0x00
;src/Renderer.c:487: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
00305$:
	ld	-47 (ix),#0x00
	ld	-45 (ix),#0x00
00260$:
;src/Renderer.c:489: if (xCellCount == zHeight)
	ld	a,-46 (ix)
	sub	a, -18 (ix)
	jr	NZ,00105$
;src/Renderer.c:491: ++xCell;
	inc	-47 (ix)
;src/Renderer.c:492: xCellCount = 0;
	ld	-18 (ix),#0x00
;src/Renderer.c:493: newCell=1;
	ld	-36 (ix),#0x01
;src/Renderer.c:494: currentCellID=cells_in_view_array[xCell + lineStart + 1];
	ld	a,-47 (ix)
	ld	-11 (ix),a
	ld	-10 (ix),#0x00
	ld	a,-29 (ix)
	add	a, -11 (ix)
	ld	-11 (ix),a
	ld	a,-28 (ix)
	adc	a, -10 (ix)
	ld	-10 (ix),a
	inc	-11 (ix)
	jr	NZ,00632$
	inc	-10 (ix)
00632$:
	ld	a,-25 (ix)
	add	a, -11 (ix)
	ld	-11 (ix),a
	ld	a,-24 (ix)
	adc	a, -10 (ix)
	ld	-10 (ix),a
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	a,(hl)
	ld	-37 (ix),a
00105$:
;src/Renderer.c:496: if(!(x%2)){
	ld	a,-45 (ix)
	and	a, #0x01
	ld	-11 (ix),a
;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-37 (ix)
	and	a, #0x80
	ld	-40 (ix),a
;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-18 (ix)
	ld	-27 (ix),a
	ld	-26 (ix),#0x00
	ld	a,-46 (ix)
	ld	-23 (ix),a
;src/Renderer.c:496: if(!(x%2)){
	ld	a,-11 (ix)
	or	a, a
	jp	NZ,00118$
;src/Renderer.c:497: if ((lateralWallCounter == 0)||newCell)
	ld	a,-39 (ix)
	or	a, a
	jr	Z,00114$
	ld	a,-36 (ix)
	or	a, a
	jp	Z,00118$
00114$:
;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-40 (ix)
	or	a, a
	jr	Z,00112$
;src/Renderer.c:501: lateralWallCounter = 0;//(zHeight - xCellCount);
	ld	-39 (ix),#0x00
;src/Renderer.c:502: lateralWallSlope = 0;
	ld	-16 (ix),#0x00
;src/Renderer.c:503: xHeight = zHeight;
	ld	a,-46 (ix)
	ld	-38 (ix),a
;src/Renderer.c:504: color = currentCellID&0b01111111;
	ld	a,-37 (ix)
	and	a, #0x7F
	ld	-22 (ix),a
;src/Renderer.c:505: lastCellWasWall = 1;
	ld	-17 (ix),#0x01
;src/Renderer.c:506: lastWallId=currentCellID;
	ld	a,-37 (ix)
	ld	-41 (ix),a
	jr	00113$
00112$:
;src/Renderer.c:509: if(lateralWallCounter==0){//Lateral wall not finished
	ld	a,-39 (ix)
	or	a, a
	jr	NZ,00113$
;src/Renderer.c:510: if (lastCellWasWall)
	ld	a,-17 (ix)
	or	a, a
	jr	Z,00107$
;src/Renderer.c:513: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-49 (ix)
	sub	a, -47 (ix)
	add	a, a
	inc	a
;src/Renderer.c:514: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-16 (ix), a
	srl	a
	ld	-7 (ix),a
;src/Renderer.c:515: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-46 (ix)
	ld	h,-16 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00633$:
	add	hl,hl
	jr	NC,00634$
	add	hl,de
00634$:
	djnz	00633$
;src/Renderer.c:516: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
	ld	a,l
	and	a, #0xFC
	set	0, a
	srl	a
	srl	a
	sub	a, -18 (ix)
;src/Renderer.c:517: lateralWallWidth=lateralWallCounter;
	ld	-39 (ix), a
	ld	-50 (ix),a
;src/Renderer.c:518: lastCellWasWall = 0;
	ld	-17 (ix),#0x00
;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	l,-27 (ix)
	ld	h,-26 (ix)
	add	hl, hl
	ld	c,-16 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-23 (ix)
	sub	a, l
	ld	-38 (ix),a
;src/Renderer.c:520: color = lastWallId&0b01111111;
	ld	a,-41 (ix)
	and	a, #0x7F
	ld	-22 (ix),a
	jr	00113$
00107$:
;src/Renderer.c:524: xHeight = 0;
	ld	-38 (ix),#0x00
;src/Renderer.c:525: lastCellWasWall = 0;
	ld	-17 (ix),#0x00
;src/Renderer.c:526: lateralWallSlope=0;
	ld	-16 (ix),#0x00
;src/Renderer.c:527: lastWallId=0;
	ld	-41 (ix),#0x00
00113$:
;src/Renderer.c:531: newCell=0;
	ld	-36 (ix),#0x00
00118$:
;src/Renderer.c:534: if (lateralWallCounter > 0)
	ld	a,-39 (ix)
	or	a, a
	jr	Z,00124$
;src/Renderer.c:537: if (lateralWallSlope != 0)
	ld	a,-16 (ix)
	or	a, a
	jr	Z,00122$
;src/Renderer.c:539: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-7 (ix)
	sub	a, -16 (ix)
	jr	NZ,00120$
;src/Renderer.c:541: lateralWallSlopeCounter = 0;
	ld	-7 (ix),#0x00
;src/Renderer.c:542: xHeight -= 2;
	dec	-38 (ix)
	dec	-38 (ix)
00120$:
;src/Renderer.c:544: ++lateralWallSlopeCounter;
	inc	-7 (ix)
00122$:
;src/Renderer.c:547: --lateralWallCounter;
	dec	-39 (ix)
00124$:
;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-46 (ix)
	ld	-20 (ix),a
	ld	-19 (ix),#0x00
;src/Renderer.c:550: if (!(x%2))
	ld	a,-11 (ix)
	or	a, a
	jp	NZ,00138$
;src/Renderer.c:560: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	ld	b,-45 (ix)
	srl	b
;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	l,-27 (ix)
	ld	h,-26 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	ld	e,-20 (ix)
	ld	d,-19 (ix)
	push	de
	push	hl
	call	__divsint
	pop	af
	pop	af
	pop	bc
	ld	c,l
;src/Renderer.c:552: if(xHeight > 0){
	ld	a,-38 (ix)
	or	a, a
	jr	Z,00129$
;src/Renderer.c:553: if (lateralWallCounter > 0)
	ld	a,-39 (ix)
	or	a, a
	jr	Z,00126$
;src/Renderer.c:555: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
	ld	e,-50 (ix)
	ld	d,#0x00
	ld	l,-39 (ix)
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
	ld	d,l
	pop	bc
	jr	00127$
00126$:
;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	d,c
00127$:
;src/Renderer.c:560: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	push	bc
	push	de
	inc	sp
	ld	h,-22 (ix)
	ld	l,-38 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer
	pop	af
	pop	af
	pop	bc
00129$:
;src/Renderer.c:562: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-40 (ix)
	or	a, a
	jr	NZ,00138$
;src/Renderer.c:563: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-37 (ix)
	and	a, #0x0F
	jr	Z,00133$
;src/Renderer.c:564: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	a,c
	push	af
	inc	sp
	ld	h,-37 (ix)
	ld	l,-46 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
	jr	00138$
00133$:
;src/Renderer.c:566: else if(currentCellID&CELL_ITEM_MASK){
	ld	a,-37 (ix)
	and	a, #0x70
	jr	Z,00138$
;src/Renderer.c:567: draw_column_to_buffer_object(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	a,c
	push	af
	inc	sp
	ld	h,-37 (ix)
	ld	l,-46 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_object
	pop	af
	pop	af
00138$:
;src/Renderer.c:572: ++xCellCount;
	inc	-18 (ix)
;src/Renderer.c:487: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	inc	-45 (ix)
;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-25 (ix),l
	ld	-24 (ix),h
;src/Renderer.c:487: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	ld	a,-45 (ix)
	sub	a, #0x50
	jp	C,00260$
;src/Renderer.c:579: xCellCount = (z) ? (zHeight >> 1) : 0 ;
	ld	a,-54 (ix)
	or	a, a
	jr	Z,00272$
	ld	c,-21 (ix)
	jr	00273$
00272$:
	ld	c,#0x00
00273$:
	ld	-27 (ix),c
;src/Renderer.c:580: lateralWallSlope=0;
	ld	-40 (ix),#0x00
;src/Renderer.c:581: lateralWallSlopeCounter=0;
	ld	-11 (ix),#0x00
;src/Renderer.c:582: xHeight=0;
	ld	-17 (ix),#0x00
;src/Renderer.c:584: lateralWallCounter = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:585: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	a,-49 (ix)
	add	a, a
	ld	c,a
	ld	a,-57 (ix)
	add	a, c
	ld	-37 (ix), a
	ld	c, a
	inc	c
	inc	c
;src/Renderer.c:587: newCell=1;
	ld	-29 (ix),#0x01
;src/Renderer.c:588: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	-15 (ix),c
	ld	-14 (ix),#0x00
	ld	e,-15 (ix)
	ld	d,-14 (ix)
	dec	de
	ld	l,-25 (ix)
	ld	h,-24 (ix)
	add	hl,de
	ld	a,(hl)
	ld	-36 (ix),a
;src/Renderer.c:590: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
	ld	l,-25 (ix)
	ld	h,-24 (ix)
	ld	b,#0x00
	add	hl, bc
	ld	c,(hl)
;src/Renderer.c:591: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00141$
;src/Renderer.c:592: lastWallId=lastCellWasWall;
	ld	-39 (ix),c
;src/Renderer.c:593: lastCellWasWall=1;
	ld	-38 (ix),#0x01
	jr	00325$
00141$:
;src/Renderer.c:596: lastCellWasWall=0;
	ld	-38 (ix),#0x00
;src/Renderer.c:597: lastWallId=CELLTYPE_FLOOR;
	ld	-39 (ix),#0x00
;src/Renderer.c:600: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
00325$:
	ld	-47 (ix),#0x00
	ld	-45 (ix),#0x9F
00262$:
;src/Renderer.c:603: if (xCellCount == zHeight)
	ld	a,-46 (ix)
	sub	a, -27 (ix)
	jr	NZ,00144$
;src/Renderer.c:605: ++xCell;
	inc	-47 (ix)
;src/Renderer.c:606: xCellCount = 0;
	ld	-27 (ix),#0x00
;src/Renderer.c:607: newCell=1;
	ld	-29 (ix),#0x01
;src/Renderer.c:608: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
	ld	a,-47 (ix)
	ld	-13 (ix),a
	ld	-12 (ix),#0x00
	ld	a,-15 (ix)
	sub	a, -13 (ix)
	ld	-13 (ix),a
	ld	a,-14 (ix)
	sbc	a, -12 (ix)
	ld	-12 (ix),a
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	dec	hl
	ld	-13 (ix),l
	ld	-12 (ix),h
	ld	a,-25 (ix)
	add	a, -13 (ix)
	ld	-13 (ix),a
	ld	a,-24 (ix)
	adc	a, -12 (ix)
	ld	-12 (ix),a
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	ld	a,(hl)
	ld	-36 (ix),a
00144$:
;src/Renderer.c:610: if(!(x%2)){
	ld	a,-45 (ix)
	and	a, #0x01
	ld	-13 (ix),a
;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-36 (ix)
	and	a, #0x80
	ld	-7 (ix),a
;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-27 (ix)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
;src/Renderer.c:610: if(!(x%2)){
	ld	a,-13 (ix)
	or	a, a
	jp	NZ,00157$
;src/Renderer.c:611: if (lateralWallCounter == 0 || newCell)
	ld	a,-41 (ix)
	or	a, a
	jr	Z,00153$
	ld	a,-29 (ix)
	or	a, a
	jp	Z,00157$
00153$:
;src/Renderer.c:613: if ( currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-7 (ix)
	or	a, a
	jr	Z,00151$
;src/Renderer.c:615: lateralWallCounter = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:616: lateralWallSlope = 0;
	ld	-40 (ix),#0x00
;src/Renderer.c:617: xHeight = zHeight;
	ld	a,-46 (ix)
	ld	-17 (ix),a
;src/Renderer.c:618: color = currentCellID&0b01111111;
	ld	a,-36 (ix)
	and	a, #0x7F
	ld	-22 (ix),a
;src/Renderer.c:619: lastCellWasWall = 1;
	ld	-38 (ix),#0x01
;src/Renderer.c:620: lastWallId=currentCellID;
	ld	a,-36 (ix)
	ld	-39 (ix),a
	jp	00152$
00151$:
;src/Renderer.c:622: else if(lateralWallCounter==0){
	ld	a,-41 (ix)
	or	a, a
	jp	NZ,00152$
;src/Renderer.c:623: if (lastCellWasWall)
	ld	a,-38 (ix)
	or	a, a
	jr	Z,00146$
;src/Renderer.c:626: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-49 (ix)
	sub	a, -47 (ix)
	add	a, a
	inc	a
;src/Renderer.c:627: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-40 (ix), a
	srl	a
	ld	-11 (ix),a
;src/Renderer.c:628: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-46 (ix)
	ld	h,-40 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00642$:
	add	hl,hl
	jr	NC,00643$
	add	hl,de
00643$:
	djnz	00642$
;src/Renderer.c:629: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
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
	jr	Z,00274$
	ld	hl,#0x0004
	add	hl,bc
00274$:
	sra	h
	rr	l
	sra	h
	rr	l
	ld	c,-27 (ix)
	ld	a,l
	sub	a, c
;src/Renderer.c:630: lateralWallWidth=lateralWallCounter;
	ld	-41 (ix), a
	ld	-50 (ix),a
;src/Renderer.c:631: lastCellWasWall = 0;
	ld	-38 (ix),#0x00
;src/Renderer.c:632: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	add	hl, hl
	ld	c,-40 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-23 (ix)
	sub	a, l
	ld	-17 (ix),a
;src/Renderer.c:633: color = lastWallId&0b01111111;
	ld	a,-39 (ix)
	and	a, #0x7F
	ld	-22 (ix),a
	jr	00152$
00146$:
;src/Renderer.c:637: xHeight = 0;
	ld	-17 (ix),#0x00
;src/Renderer.c:638: lastCellWasWall = 0;
	ld	-38 (ix),#0x00
;src/Renderer.c:639: lateralWallSlope=0;
	ld	-40 (ix),#0x00
;src/Renderer.c:640: lastWallId=0;
	ld	-39 (ix),#0x00
00152$:
;src/Renderer.c:643: newCell=0;
	ld	-29 (ix),#0x00
00157$:
;src/Renderer.c:648: if (lateralWallCounter > 0)
	ld	a,-41 (ix)
	or	a, a
	jr	Z,00163$
;src/Renderer.c:651: if (lateralWallSlope != 0)
	ld	a,-40 (ix)
	or	a, a
	jr	Z,00161$
;src/Renderer.c:653: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-40 (ix)
	sub	a, -11 (ix)
	jr	NZ,00159$
;src/Renderer.c:655: lateralWallSlopeCounter = 0;
	ld	-11 (ix),#0x00
;src/Renderer.c:656: xHeight -= 2;
	dec	-17 (ix)
	dec	-17 (ix)
00159$:
;src/Renderer.c:658: ++lateralWallSlopeCounter;
	inc	-11 (ix)
00161$:
;src/Renderer.c:660: --lateralWallCounter;
	dec	-41 (ix)
00163$:
;src/Renderer.c:664: if (!(x%2))
	ld	a,-13 (ix)
	or	a, a
	jp	NZ,00177$
;src/Renderer.c:677: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	ld	a,-45 (ix)
	srl	a
	ld	-13 (ix),a
;src/Renderer.c:674: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-20 (ix)
	sub	a, -9 (ix)
	ld	-9 (ix),a
	ld	a,-19 (ix)
	sbc	a, -8 (ix)
	ld	-8 (ix),a
	ld	a,#0x05+1
	jr	00647$
00646$:
	sla	-9 (ix)
	rl	-8 (ix)
00647$:
	dec	a
	jr	NZ,00646$
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-8 (ix),h
	ld	-9 (ix), l
	ld	-9 (ix), l
;src/Renderer.c:667: if(xHeight > 0){
	ld	a,-17 (ix)
	or	a, a
	jr	Z,00168$
;src/Renderer.c:669: if (lateralWallCounter > 0)
	ld	a,-41 (ix)
	or	a, a
	jr	Z,00165$
;src/Renderer.c:671: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
	ld	a,-41 (ix)
	ld	-6 (ix),a
	ld	-5 (ix),#0x00
	ld	a,#0x05+1
	jr	00649$
00648$:
	sla	-6 (ix)
	rl	-5 (ix)
00649$:
	dec	a
	jr	NZ,00648$
	ld	a,-50 (ix)
	ld	-4 (ix),a
	ld	-3 (ix),#0x00
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	b,l
	jr	00166$
00165$:
;src/Renderer.c:674: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	b,-9 (ix)
00166$:
;src/Renderer.c:677: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	push	bc
	inc	sp
	ld	h,-22 (ix)
	ld	l,-17 (ix)
	push	hl
	ld	a,-13 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer
	pop	af
	pop	af
00168$:
;src/Renderer.c:680: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-7 (ix)
	or	a, a
	jr	NZ,00177$
;src/Renderer.c:681: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-36 (ix)
	and	a, #0x0F
	jr	Z,00172$
;src/Renderer.c:682: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	h,-9 (ix)
	ld	l,-36 (ix)
	push	hl
	ld	h,-46 (ix)
	ld	l,-13 (ix)
	push	hl
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
	jr	00177$
00172$:
;src/Renderer.c:684: else if(currentCellID&CELL_ITEM_MASK){
	ld	a,-36 (ix)
	and	a, #0x70
	jr	Z,00177$
;src/Renderer.c:685: draw_column_to_buffer_object(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	h,-9 (ix)
	ld	l,-36 (ix)
	push	hl
	ld	h,-46 (ix)
	ld	l,-13 (ix)
	push	hl
	call	_draw_column_to_buffer_object
	pop	af
	pop	af
00177$:
;src/Renderer.c:689: ++xCellCount;
	inc	-27 (ix)
;src/Renderer.c:600: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	dec	-45 (ix)
;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-25 (ix),l
	ld	-24 (ix),h
;src/Renderer.c:600: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	ld	a,-45 (ix)
	sub	a, #0x50
	jp	NC,00262$
;src/Renderer.c:720: lineStart = lineStart + (offsetDiff * 2) + 3;
	ld	a,-37 (ix)
	add	a, #0x03
	ld	-57 (ix),a
;src/Renderer.c:721: zHeight += zHeight;
	sla	-46 (ix)
;src/Renderer.c:722: offsetDiff = offsetDiff >> 1;
	srl	-49 (ix)
;src/Renderer.c:724: }while(z);
	ld	a,-54 (ix)
	or	a, a
	jp	NZ,00179$
	jp	00268$
;src/Renderer.c:729: do{
00370$:
	ld	-54 (ix),#0x06
00254$:
;src/Renderer.c:731: --z;
	dec	-54 (ix)
;src/Renderer.c:466: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-46 (ix)
	srl	a
	ld	-4 (ix),a
;src/Renderer.c:735: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-54 (ix)
	or	a, a
	jr	Z,00275$
	ld	c,-4 (ix)
	jr	00276$
00275$:
	ld	c,#0x00
00276$:
	ld	-53 (ix),c
;src/Renderer.c:736: lateralWallSlope=0;
	ld	-52 (ix),#0x00
;src/Renderer.c:737: lateralWallSlopeCounter=0;
	ld	-48 (ix),#0x00
;src/Renderer.c:738: xHeight=0;
	ld	-55 (ix),#0x00
;src/Renderer.c:740: lateralWallCounter = 0;
	ld	-6 (ix),#0x00
;src/Renderer.c:742: newCell=1;
	ld	-43 (ix),#0x01
;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
	ld	a,-57 (ix)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
;src/Renderer.c:743: currentCellID = cells_in_view_array[lineStart + 1];
	ld	c,-9 (ix)
	ld	b,-8 (ix)
	inc	bc
	ld	l,-25 (ix)
	ld	h,-24 (ix)
	add	hl,bc
	ld	a,(hl)
	ld	-44 (ix),a
;src/Renderer.c:745: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
	ld	a,-25 (ix)
	add	a, -57 (ix)
	ld	l,a
	ld	a,-24 (ix)
	adc	a, #0x00
	ld	h,a
	ld	c,(hl)
;src/Renderer.c:746: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00183$
;src/Renderer.c:747: lastWallId=lastCellWasWall;
	ld	-42 (ix),c
;src/Renderer.c:748: lastCellWasWall=1;
	ld	-13 (ix),#0x01
	jr	00347$
00183$:
;src/Renderer.c:751: lastCellWasWall=0;
	ld	-13 (ix),#0x00
;src/Renderer.c:752: lastWallId=CELLTYPE_FLOOR;
	ld	-42 (ix),#0x00
;src/Renderer.c:755: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
00347$:
	ld	-47 (ix),#0x00
	ld	-45 (ix),#0x00
00264$:
;src/Renderer.c:757: if (xCellCount == zHeight)
	ld	a,-53 (ix)
	sub	a, -46 (ix)
	jr	NZ,00186$
;src/Renderer.c:759: ++xCell;
	inc	-47 (ix)
;src/Renderer.c:760: xCellCount = 0;
	ld	-53 (ix),#0x00
;src/Renderer.c:761: newCell=1;
	ld	-43 (ix),#0x01
;src/Renderer.c:762: currentCellID=cells_in_view_array[xCell + lineStart + 1];
	ld	a,-47 (ix)
	ld	-15 (ix),a
	ld	-14 (ix),#0x00
	ld	a,-9 (ix)
	add	a, -15 (ix)
	ld	-15 (ix),a
	ld	a,-8 (ix)
	adc	a, -14 (ix)
	ld	-14 (ix),a
	inc	-15 (ix)
	jr	NZ,00655$
	inc	-14 (ix)
00655$:
	ld	a,-15 (ix)
	add	a, -25 (ix)
	ld	-15 (ix),a
	ld	a,-14 (ix)
	adc	a, -24 (ix)
	ld	-14 (ix),a
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	ld	a,(hl)
	ld	-44 (ix),a
00186$:
;src/Renderer.c:764: if(!(x%2)){
	ld	a,-45 (ix)
	and	a, #0x01
	ld	-15 (ix),a
;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-44 (ix)
	and	a, #0x80
	ld	-20 (ix),a
;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-53 (ix)
	ld	-27 (ix),a
	ld	-26 (ix),#0x00
	ld	a,-46 (ix)
	ld	-22 (ix),a
;src/Renderer.c:764: if(!(x%2)){
	ld	a,-15 (ix)
	or	a, a
	jp	NZ,00199$
;src/Renderer.c:765: if ((lateralWallCounter == 0)||newCell)
	ld	a,-6 (ix)
	or	a, a
	jr	Z,00195$
	ld	a,-43 (ix)
	or	a, a
	jp	Z,00199$
00195$:
;src/Renderer.c:767: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-20 (ix)
	or	a, a
	jr	Z,00193$
;src/Renderer.c:769: lateralWallCounter = 0;//(zHeight - xCellCount);
	ld	-6 (ix),#0x00
;src/Renderer.c:770: lateralWallSlope = 0;
	ld	-52 (ix),#0x00
;src/Renderer.c:771: xHeight = zHeight;
	ld	a,-46 (ix)
	ld	-55 (ix),a
;src/Renderer.c:772: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
	ld	a,-44 (ix)
	sub	a, #0x80
	jr	NZ,00277$
	ld	c,#0x09
	jr	00278$
00277$:
	ld	c,#0x0B
00278$:
	ld	-58 (ix),c
;src/Renderer.c:773: lastCellWasWall = 1;
	ld	-13 (ix),#0x01
;src/Renderer.c:774: lastWallId=currentCellID;
	ld	a,-44 (ix)
	ld	-42 (ix),a
	jp	00194$
00193$:
;src/Renderer.c:777: if(lateralWallCounter==0){//Lateral wall not finished
	ld	a,-6 (ix)
	or	a, a
	jp	NZ,00194$
;src/Renderer.c:778: if (lastCellWasWall)
	ld	a,-13 (ix)
	or	a, a
	jp	Z,00188$
;src/Renderer.c:781: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-49 (ix)
	sub	a, -47 (ix)
	add	a, a
	inc	a
;src/Renderer.c:782: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-52 (ix), a
	srl	a
	ld	-48 (ix),a
;src/Renderer.c:783: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-46 (ix)
	ld	h,-52 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00658$:
	add	hl,hl
	jr	NC,00659$
	add	hl,de
00659$:
	djnz	00658$
	ld	-23 (ix), l
	ld	a, l
;src/Renderer.c:784: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
	ld	-51 (ix), a
	and	a, #0xFC
	ld	-23 (ix), a
	set	0, a
	ld	-23 (ix), a
	srl	a
	srl	a
	sub	a, -53 (ix)
	ld	-6 (ix),a
;src/Renderer.c:786: lastCellWasWall = 0;
	ld	-13 (ix),#0x00
;src/Renderer.c:787: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-27 (ix)
	ld	-11 (ix),a
	ld	a,-26 (ix)
	ld	-10 (ix),a
	sla	-11 (ix)
	rl	-10 (ix)
	ld	a,-52 (ix)
	ld	-29 (ix),a
	ld	-28 (ix),#0x00
	ld	l,-29 (ix)
	ld	h,-28 (ix)
	push	hl
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-10 (ix),h
	ld	-11 (ix), l
	ld	-23 (ix), l
	ld	a,-22 (ix)
	sub	a, -23 (ix)
	ld	-55 (ix),a
;src/Renderer.c:788: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
	ld	a,-42 (ix)
	sub	a, #0x80
	jr	NZ,00279$
	ld	c,#0x0A
	jr	00280$
00279$:
	ld	c,#0x0C
00280$:
	ld	-58 (ix),c
	jr	00194$
00188$:
;src/Renderer.c:792: xHeight = 0;
	ld	-55 (ix),#0x00
;src/Renderer.c:793: lastCellWasWall = 0;
	ld	-13 (ix),#0x00
;src/Renderer.c:794: lateralWallSlope=0;
	ld	-52 (ix),#0x00
;src/Renderer.c:795: lastWallId=0;
	ld	-42 (ix),#0x00
00194$:
;src/Renderer.c:799: newCell=0;
	ld	-43 (ix),#0x00
00199$:
;src/Renderer.c:802: if (lateralWallCounter > 0)
	ld	a,-6 (ix)
	or	a, a
	jr	Z,00205$
;src/Renderer.c:805: if (lateralWallSlope != 0)
	ld	a,-52 (ix)
	or	a, a
	jr	Z,00203$
;src/Renderer.c:807: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-52 (ix)
	sub	a, -48 (ix)
	jr	NZ,00201$
;src/Renderer.c:809: lateralWallSlopeCounter = 0;
	ld	-48 (ix),#0x00
;src/Renderer.c:810: xHeight -= 2;
	dec	-55 (ix)
	dec	-55 (ix)
00201$:
;src/Renderer.c:812: ++lateralWallSlopeCounter;
	inc	-48 (ix)
00203$:
;src/Renderer.c:815: --lateralWallCounter;
	dec	-6 (ix)
00205$:
;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-46 (ix)
	ld	-11 (ix),a
	ld	-10 (ix),#0x00
;src/Renderer.c:818: if (!(x%2))
	ld	a,-15 (ix)
	or	a, a
	jp	NZ,00216$
;src/Renderer.c:821: draw_column_to_buffer_untextured(x/2, xHeight, color);
	ld	a,-45 (ix)
	srl	a
	ld	-15 (ix),a
;src/Renderer.c:820: if(xHeight > 0){
	ld	a,-55 (ix)
	or	a, a
	jr	Z,00207$
;src/Renderer.c:821: draw_column_to_buffer_untextured(x/2, xHeight, color);
	ld	h,-58 (ix)
	ld	l,-55 (ix)
	push	hl
	ld	a,-15 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer_untextured
	pop	af
	inc	sp
00207$:
;src/Renderer.c:824: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-20 (ix)
	or	a, a
	jr	NZ,00216$
;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-27 (ix)
	ld	-20 (ix),a
	ld	a,-26 (ix)
	ld	-19 (ix),a
	ld	a,#0x05+1
	jr	00667$
00666$:
	sla	-20 (ix)
	rl	-19 (ix)
00667$:
	dec	a
	jr	NZ,00666$
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-19 (ix),h
	ld	-20 (ix), l
	ld	b, l
;src/Renderer.c:825: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-44 (ix)
	and	a, #0x0F
	jr	Z,00211$
;src/Renderer.c:826: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
	push	bc
	inc	sp
	ld	h,-44 (ix)
	ld	l,-46 (ix)
	push	hl
	ld	a,-15 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
	jr	00216$
00211$:
;src/Renderer.c:828: else if(currentCellID&CELL_ITEM_MASK){
	ld	a,-44 (ix)
	and	a, #0x70
	jr	Z,00216$
;src/Renderer.c:829: draw_column_to_buffer_object(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
	push	bc
	inc	sp
	ld	h,-44 (ix)
	ld	l,-46 (ix)
	push	hl
	ld	a,-15 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer_object
	pop	af
	pop	af
00216$:
;src/Renderer.c:834: ++xCellCount;
	inc	-53 (ix)
;src/Renderer.c:755: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	inc	-45 (ix)
;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-25 (ix),l
	ld	-24 (ix),h
;src/Renderer.c:755: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	ld	a,-45 (ix)
	sub	a, #0x50
	jp	C,00264$
;src/Renderer.c:841: xCellCount = (z) ? (zHeight >> 1) : 0 ;
	ld	a,-54 (ix)
	or	a, a
	jr	Z,00281$
	ld	a,-4 (ix)
	ld	-4 (ix),a
	jr	00282$
00281$:
	ld	-4 (ix),#0x00
00282$:
	ld	a,-4 (ix)
	ld	-4 (ix),a
;src/Renderer.c:842: lateralWallSlope=0;
	ld	-6 (ix),#0x00
;src/Renderer.c:843: lateralWallSlopeCounter=0;
	ld	-9 (ix),#0x00
;src/Renderer.c:844: xHeight=0;
	ld	-13 (ix),#0x00
;src/Renderer.c:846: lateralWallCounter = 0;
	ld	-15 (ix),#0x00
;src/Renderer.c:585: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	a,-49 (ix)
	add	a, a
	ld	-20 (ix),a
	ld	a,-57 (ix)
	add	a, -20 (ix)
;src/Renderer.c:847: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	-20 (ix), a
	add	a, #0x02
	ld	-56 (ix),a
;src/Renderer.c:849: newCell=1;
	ld	-23 (ix),#0x01
;src/Renderer.c:588: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	a,-56 (ix)
	ld	-27 (ix),a
	ld	-26 (ix),#0x00
;src/Renderer.c:850: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	a,-27 (ix)
	add	a,#0xFF
	ld	-29 (ix),a
	ld	a,-26 (ix)
	adc	a,#0xFF
	ld	-28 (ix),a
	ld	a,-25 (ix)
	add	a, -29 (ix)
	ld	-29 (ix),a
	ld	a,-24 (ix)
	adc	a, -28 (ix)
	ld	-28 (ix),a
	ld	l,-29 (ix)
	ld	h,-28 (ix)
	ld	a,(hl)
	ld	-40 (ix),a
;src/Renderer.c:852: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
	ld	a,-25 (ix)
	add	a, -56 (ix)
	ld	-29 (ix),a
	ld	a,-24 (ix)
	adc	a, #0x00
	ld	-28 (ix),a
	ld	l,-29 (ix)
	ld	h,-28 (ix)
	ld	a,(hl)
	ld	-17 (ix),a
;src/Renderer.c:853: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, -17 (ix)
	jr	Z,00219$
;src/Renderer.c:854: lastWallId=lastCellWasWall;
;src/Renderer.c:855: lastCellWasWall=1;
	ld	-41 (ix),#0x01
	jr	00368$
00219$:
;src/Renderer.c:858: lastCellWasWall=0;
	ld	-41 (ix),#0x00
;src/Renderer.c:859: lastWallId=CELLTYPE_FLOOR;
	ld	-17 (ix),#0x00
;src/Renderer.c:862: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
00368$:
	ld	-47 (ix),#0x00
	ld	-45 (ix),#0x9F
00266$:
;src/Renderer.c:865: if (xCellCount == zHeight)
	ld	a,-46 (ix)
	sub	a, -4 (ix)
	jr	NZ,00222$
;src/Renderer.c:867: ++xCell;
	inc	-47 (ix)
;src/Renderer.c:868: xCellCount = 0;
	ld	-4 (ix),#0x00
;src/Renderer.c:869: newCell=1;
	ld	-23 (ix),#0x01
;src/Renderer.c:870: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
	ld	a,-47 (ix)
	ld	-29 (ix),a
	ld	-28 (ix),#0x00
	ld	a,-27 (ix)
	sub	a, -29 (ix)
	ld	-29 (ix),a
	ld	a,-26 (ix)
	sbc	a, -28 (ix)
	ld	-28 (ix),a
	ld	l,-29 (ix)
	ld	h,-28 (ix)
	dec	hl
	ld	-29 (ix),l
	ld	-28 (ix),h
	ld	a,-25 (ix)
	add	a, -29 (ix)
	ld	-29 (ix),a
	ld	a,-24 (ix)
	adc	a, -28 (ix)
	ld	-28 (ix),a
	ld	l,-29 (ix)
	ld	h,-28 (ix)
	ld	a,(hl)
	ld	-40 (ix),a
00222$:
;src/Renderer.c:872: if(!(x%2)){
	ld	a,-45 (ix)
	and	a, #0x01
	ld	-37 (ix),a
;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-40 (ix)
	and	a, #0x80
	ld	-29 (ix),a
;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-4 (ix)
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
;src/Renderer.c:872: if(!(x%2)){
	ld	a,-37 (ix)
	or	a, a
	jp	NZ,00235$
;src/Renderer.c:873: if (lateralWallCounter == 0 || newCell)
	ld	a,-15 (ix)
	or	a, a
	jr	Z,00231$
	ld	a,-23 (ix)
	or	a, a
	jp	Z,00235$
00231$:
;src/Renderer.c:875: if ( currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-29 (ix)
	or	a, a
	jr	Z,00229$
;src/Renderer.c:877: lateralWallCounter = 0;
	ld	-15 (ix),#0x00
;src/Renderer.c:878: lateralWallSlope = 0;
	ld	-6 (ix),#0x00
;src/Renderer.c:879: xHeight = zHeight;
	ld	a,-46 (ix)
	ld	-13 (ix),a
;src/Renderer.c:880: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
	ld	a,-40 (ix)
	sub	a, #0x80
	jr	NZ,00283$
	ld	-36 (ix),#0x09
	jr	00284$
00283$:
	ld	-36 (ix),#0x0B
00284$:
	ld	a,-36 (ix)
	ld	-58 (ix),a
;src/Renderer.c:881: lastCellWasWall = 1;
	ld	-41 (ix),#0x01
;src/Renderer.c:882: lastWallId=currentCellID;
	ld	a,-40 (ix)
	ld	-17 (ix),a
	jp	00230$
00229$:
;src/Renderer.c:884: else if(lateralWallCounter==0){
	ld	a,-15 (ix)
	or	a, a
	jp	NZ,00230$
;src/Renderer.c:885: if (lastCellWasWall)
	ld	a,-41 (ix)
	or	a, a
	jp	Z,00224$
;src/Renderer.c:888: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-49 (ix)
	sub	a, -47 (ix)
	add	a, a
	inc	a
;src/Renderer.c:889: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-6 (ix), a
	srl	a
	ld	-9 (ix),a
;src/Renderer.c:890: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-46 (ix)
	ld	h,-6 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00675$:
	add	hl,hl
	jr	NC,00676$
	add	hl,de
00676$:
	djnz	00675$
;src/Renderer.c:891: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
	ld	-36 (ix), l
	ld	-31 (ix), l
	ld	-30 (ix),#0x00
	ld	a,-36 (ix)
	and	a, #0x03
	ld	-36 (ix), a
	ld	-33 (ix),a
	ld	-32 (ix),#0x00
	ld	a,-31 (ix)
	sub	a, -33 (ix)
	ld	-33 (ix),a
	ld	a,-30 (ix)
	sbc	a, -32 (ix)
	ld	-32 (ix),a
	ld	a,-33 (ix)
	add	a, #0x01
	ld	-31 (ix),a
	ld	a,-32 (ix)
	adc	a, #0x00
	ld	-30 (ix),a
	ld	a,-31 (ix)
	ld	-35 (ix),a
	ld	a,-30 (ix)
	ld	-34 (ix),a
	bit	7, -30 (ix)
	jr	Z,00285$
	ld	a,-33 (ix)
	add	a, #0x04
	ld	-35 (ix),a
	ld	a,-32 (ix)
	adc	a, #0x00
	ld	-34 (ix),a
00285$:
	ld	c,-35 (ix)
	ld	b,-34 (ix)
	sra	b
	rr	c
	sra	b
	rr	c
	ld	b,-4 (ix)
	ld	a,c
	sub	a, b
	ld	-15 (ix),a
;src/Renderer.c:893: lastCellWasWall = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:894: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	add	hl, hl
	ld	c,-6 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-22 (ix)
	sub	a, l
	ld	-13 (ix),a
;src/Renderer.c:895: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
	ld	a,-17 (ix)
	sub	a, #0x80
	jr	NZ,00286$
	ld	c,#0x0A
	jr	00287$
00286$:
	ld	c,#0x0C
00287$:
	ld	-58 (ix),c
	jr	00230$
00224$:
;src/Renderer.c:899: xHeight = 0;
	ld	-13 (ix),#0x00
;src/Renderer.c:900: lastCellWasWall = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:901: lateralWallSlope=0;
	ld	-6 (ix),#0x00
;src/Renderer.c:902: lastWallId=0;
	ld	-17 (ix),#0x00
00230$:
;src/Renderer.c:905: newCell=0;
	ld	-23 (ix),#0x00
00235$:
;src/Renderer.c:910: if (lateralWallCounter > 0)
	ld	a,-15 (ix)
	or	a, a
	jr	Z,00241$
;src/Renderer.c:913: if (lateralWallSlope != 0)
	ld	a,-6 (ix)
	or	a, a
	jr	Z,00239$
;src/Renderer.c:915: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-6 (ix)
	sub	a, -9 (ix)
	jr	NZ,00237$
;src/Renderer.c:917: lateralWallSlopeCounter = 0;
	ld	-9 (ix),#0x00
;src/Renderer.c:918: xHeight -= 2;
	dec	-13 (ix)
	dec	-13 (ix)
00237$:
;src/Renderer.c:920: ++lateralWallSlopeCounter;
	inc	-9 (ix)
00239$:
;src/Renderer.c:922: --lateralWallCounter;
	dec	-15 (ix)
00241$:
;src/Renderer.c:926: if (!(x%2))
	ld	a,-37 (ix)
	or	a, a
	jr	NZ,00252$
;src/Renderer.c:931: draw_column_to_buffer_untextured(x/2, xHeight, color);
	ld	b,-45 (ix)
	srl	b
;src/Renderer.c:929: if(xHeight > 0){
	ld	a,-13 (ix)
	or	a, a
	jr	Z,00243$
;src/Renderer.c:931: draw_column_to_buffer_untextured(x/2, xHeight, color);
	push	bc
	ld	h,-58 (ix)
	ld	l,-13 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_untextured
	pop	af
	inc	sp
	pop	bc
00243$:
;src/Renderer.c:934: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-29 (ix)
	or	a, a
	jr	NZ,00252$
;src/Renderer.c:674: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-11 (ix)
	sub	a, -2 (ix)
	ld	l,a
	ld	a,-10 (ix)
	sbc	a, -1 (ix)
	ld	h,a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	ld	e,-11 (ix)
	ld	d,-10 (ix)
	push	de
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	d,l
	pop	bc
;src/Renderer.c:935: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-40 (ix)
	and	a, #0x0F
	jr	Z,00247$
;src/Renderer.c:936: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
	push	de
	inc	sp
	ld	h,-40 (ix)
	ld	l,-46 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
	jr	00252$
00247$:
;src/Renderer.c:938: else if(currentCellID&CELL_ITEM_MASK){
	ld	a,-40 (ix)
	and	a, #0x70
	jr	Z,00252$
;src/Renderer.c:939: draw_column_to_buffer_object(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
	push	de
	inc	sp
	ld	h,-40 (ix)
	ld	l,-46 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_object
	pop	af
	pop	af
00252$:
;src/Renderer.c:943: ++xCellCount;
	inc	-4 (ix)
;src/Renderer.c:862: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	dec	-45 (ix)
;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-25 (ix),l
	ld	-24 (ix),h
;src/Renderer.c:862: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	ld	a,-45 (ix)
	sub	a, #0x50
	jp	NC,00266$
;src/Renderer.c:972: lineStart = lineStart + (offsetDiff * 2) + 3;
	ld	a,-20 (ix)
	add	a, #0x03
	ld	-57 (ix),a
;src/Renderer.c:973: zHeight += zHeight;
	sla	-46 (ix)
;src/Renderer.c:974: offsetDiff = offsetDiff >> 1;
	srl	-49 (ix)
;src/Renderer.c:976: }while(z);
	ld	a,-54 (ix)
	or	a, a
	jp	NZ,00254$
00268$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:982: void draw_minimap_to_buffer(){
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
;src/Renderer.c:985: u8* ptr = MINIMAP_BUFFER;
	ld	bc,#0xB9F0
;src/Renderer.c:990: y=(player_position.y-MINIMAP_HEIGHT_HALF);
	ld	a, (#(_player_position + 0x0001) + 0)
	add	a,#0xF8
	ld	e,a
;src/Renderer.c:992: for(j=0;j<MINIMAP_HEIGHT;++j){
	ld	d,#0x00
;src/Renderer.c:993: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
00141$:
	ld	a,e
	rlca
	and	a,#0x01
	ld	-8 (ix),a
	ld	a,e
	xor	a, #0x80
	sub	a, #0xA0
	ld	a,#0x00
	rla
	ld	-1 (ix),a
	ld	-10 (ix),#0x00
00125$:
;src/Renderer.c:994: x=(player_position.x-MINIMAP_WIDTH_HALF);
	ld	a, (#_player_position + 0)
	add	a,#0xF8
	ld	-9 (ix),a
;src/Renderer.c:995: for(i=0;i<MINIMAP_WIDTH;++i){
	ld	-11 (ix),#0x00
00123$:
;src/Renderer.c:998: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	iy,#0x0010
	add	iy, bc
;src/Renderer.c:996: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
	bit	7, -9 (ix)
	jr	NZ,00114$
	ld	a,-9 (ix)
	xor	a, #0x80
	sub	a, #0xA0
	jr	NC,00114$
	ld	a,-8 (ix)
	or	a, a
	jr	NZ,00114$
	bit	0,-1 (ix)
	jr	NZ,00115$
00114$:
;src/Renderer.c:997: *ptr=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	(bc),a
;src/Renderer.c:998: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	0 (iy), a
	jp	00116$
00115$:
;src/Renderer.c:1000: else if((x==player_position.x)&&(y==player_position.y)){
	ld	a,-9 (ix)
	ld	-3 (ix),a
	ld	a,-9 (ix)
	rla
	sbc	a, a
	ld	-2 (ix),a
	ld	a, (#_player_position + 0)
	ld	-7 (ix),a
	ld	-6 (ix),#0x00
	ld	-5 (ix),e
	ld	a,e
	rla
	sbc	a, a
	ld	-4 (ix),a
	ld	a,-3 (ix)
	sub	a, -7 (ix)
	jr	NZ,00111$
	ld	a,-2 (ix)
	sub	a, -6 (ix)
	jr	NZ,00111$
	ld	a, (#(_player_position + 0x0001) + 0)
	ld	-7 (ix),a
	ld	-6 (ix),#0x00
	ld	a,-5 (ix)
	sub	a, -7 (ix)
	jr	NZ,00111$
	ld	a,-4 (ix)
	sub	a, -6 (ix)
	jr	NZ,00111$
;src/Renderer.c:1001: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
	ld	a, (#(_g_colors + 0x0004) + 0)
	ld	(bc),a
;src/Renderer.c:1002: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
	ld	a, (#(_g_colors + 0x0004) + 0)
	ld	0 (iy), a
	jr	00116$
00111$:
;src/Renderer.c:1005: val = (*(u8*)(MAP_MEM+x+y*MAP_WIDTH));
	ld	a, -3 (ix)
	ld	h, -2 (ix)
	add	a, #0xD0
	ld	-7 (ix),a
	ld	a,h
	adc	a, #0x88
	ld	-6 (ix),a
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a,-7 (ix)
	add	a, l
	ld	l,a
	ld	a,-6 (ix)
	adc	a, h
	ld	h,a
	ld	l,(hl)
;src/Renderer.c:1007: if(val==CELLTYPE_DOOR){
	ld	a,l
	sub	a, #0x80
	jr	NZ,00108$
;src/Renderer.c:1008: *ptr=g_colors[MINIMAP_EXIT_COLOR];
	ld	a, (#(_g_colors + 0x0005) + 0)
	ld	(bc),a
;src/Renderer.c:1009: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
	ld	a, (#(_g_colors + 0x0005) + 0)
	ld	0 (iy), a
	jr	00116$
00108$:
;src/Renderer.c:1011: else if(val&CELL_WALL_MASK){
	bit	7, l
	jr	Z,00105$
;src/Renderer.c:1012: *ptr=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	(bc),a
;src/Renderer.c:1013: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	0 (iy), a
	jr	00116$
00105$:
;src/Renderer.c:1015: else if(val&CELL_ENEMY_MASK){
	ld	a,l
	and	a, #0x0F
	jr	Z,00102$
;src/Renderer.c:1016: *ptr=g_colors[MINIMAP_ENEMY_COLOR];
	ld	a, (#(_g_colors + 0x0006) + 0)
	ld	(bc),a
;src/Renderer.c:1017: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_ENEMY_COLOR];
	ld	a, (#(_g_colors + 0x0006) + 0)
	ld	0 (iy), a
	jr	00116$
00102$:
;src/Renderer.c:1024: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
	ld	a, (#(_g_colors + 0x0003) + 0)
	ld	(bc),a
;src/Renderer.c:1025: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
	ld	a, (#(_g_colors + 0x0003) + 0)
	ld	0 (iy), a
00116$:
;src/Renderer.c:1028: ++x;
	inc	-9 (ix)
;src/Renderer.c:1029: ++ptr;
	inc	bc
;src/Renderer.c:995: for(i=0;i<MINIMAP_WIDTH;++i){
	inc	-11 (ix)
	ld	a,-11 (ix)
	sub	a, #0x10
	jp	C,00123$
;src/Renderer.c:993: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
	inc	-10 (ix)
	ld	a,-10 (ix)
	sub	a, #0x04
	jp	C,00125$
;src/Renderer.c:1032: ++y;
	inc	e
;src/Renderer.c:992: for(j=0;j<MINIMAP_HEIGHT;++j){
	inc	d
	ld	a,d
	sub	a, #0x10
	jp	C,00141$
	ld	sp, ix
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
