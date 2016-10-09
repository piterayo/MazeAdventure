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
;src/Renderer.c:207: void calculate_cells_in_view(){
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
;src/Renderer.c:209: u8 offset=0, n=0, j, i;
	ld	-6 (ix),#0x00
	ld	-7 (ix),#0x00
;src/Renderer.c:212: if(PLAYER_direction.y!=0){
	ld	a,(#_PLAYER_direction + 1)
	ld	-3 (ix), a
	or	a, a
	jr	Z,00102$
;src/Renderer.c:213: vert=1;
	ld	-14 (ix),#0x01
;src/Renderer.c:214: dy=PLAYER_direction.y;
	ld	c,-3 (ix)
	ld	-12 (ix),c
;src/Renderer.c:215: dx=-PLAYER_direction.y;
	xor	a, a
	sub	a, -3 (ix)
	ld	-11 (ix), a
;src/Renderer.c:217: x0 = PLAYER_position.x-(17*dx);
	ld	hl,#_PLAYER_position+0
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
;src/Renderer.c:218: y0 = PLAYER_position.y+(6*dy);
	ld	hl,#_PLAYER_position+1
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
;src/Renderer.c:221: vert=0;
	ld	-14 (ix),#0x00
;src/Renderer.c:222: dy=PLAYER_direction.x;
	ld	a,(#_PLAYER_direction + 0)
	ld	-3 (ix), a
	ld	-12 (ix),a
;src/Renderer.c:223: dx=PLAYER_direction.x;
	ld	a,-3 (ix)
	ld	-11 (ix),a
;src/Renderer.c:225: y0 = PLAYER_position.y-(17*dy);
	ld	hl, #_PLAYER_position + 1
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
;src/Renderer.c:226: x0 = PLAYER_position.x+(6*dx);
	ld	hl, #_PLAYER_position + 0
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
;src/Renderer.c:230: x=x0;
	ld	e,-10 (ix)
;src/Renderer.c:231: y=y0;
	ld	-13 (ix),c
;src/Renderer.c:233: for(j=0;j<6;++j){
	ld	a,-11 (ix)
	rlca
	and	a,#0x01
	ld	-3 (ix),a
	ld	a,-12 (ix)
	rlca
	and	a,#0x01
	ld	-5 (ix),a
	ld	-8 (ix),#0x00
;src/Renderer.c:235: for(i=offset;i<35-offset;++i){
00138$:
	ld	a,-7 (ix)
	ld	-4 (ix),a
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
;src/Renderer.c:238: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
	ld	hl,(_cells_in_view_array)
	ld	a,l
	add	a, -4 (ix)
	ld	-2 (ix),a
	ld	a,h
	adc	a, #0x00
	ld	-1 (ix),a
;src/Renderer.c:237: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
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
;src/Renderer.c:238: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
	ld	a,e
	ld	d,a
	rla
	sbc	a, a
	ld	l,a
	ld	a,d
	add	a, #0x40
	ld	b,a
	ld	a,l
	adc	a, #0x00
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
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),b
	jr	00106$
00105$:
;src/Renderer.c:241: cells_in_view_array[n]=1;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),#0x01
00106$:
;src/Renderer.c:245: if(vert){
	ld	a,-14 (ix)
	or	a, a
	jr	Z,00111$
;src/Renderer.c:246: x+=dx;
	ld	a,e
	add	a, -11 (ix)
	ld	e,a
	jr	00112$
00111$:
;src/Renderer.c:249: y+=dy;
	ld	a,-13 (ix)
	add	a, -12 (ix)
	ld	-13 (ix),a
00112$:
;src/Renderer.c:251: ++n;
	inc	-4 (ix)
;src/Renderer.c:235: for(i=offset;i<35-offset;++i){
	inc	-9 (ix)
	jp	00125$
00143$:
	ld	a,-4 (ix)
	ld	-7 (ix),a
;src/Renderer.c:253: offset=offsets_cells_in_view[j];
	ld	a,#<(_offsets_cells_in_view)
	add	a, -8 (ix)
	ld	l,a
	ld	a,#>(_offsets_cells_in_view)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
;src/Renderer.c:257: if(dx<0) x=x0-offset;
	ld	-6 (ix), a
	ld	-2 (ix),a
;src/Renderer.c:255: if(vert){
	ld	a,-14 (ix)
	or	a, a
	jr	Z,00121$
;src/Renderer.c:256: y-=dy;
	ld	a,-13 (ix)
	sub	a, -12 (ix)
	ld	-13 (ix),a
;src/Renderer.c:257: if(dx<0) x=x0-offset;
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00115$
	ld	a,-10 (ix)
	sub	a, -2 (ix)
	ld	e,a
	jr	00128$
00115$:
;src/Renderer.c:258: else x=x0+offset;
	ld	a,-10 (ix)
	add	a, -2 (ix)
	ld	e,a
	jr	00128$
00121$:
;src/Renderer.c:262: x-=dx;
	ld	a,e
	sub	a, -11 (ix)
	ld	e,a
;src/Renderer.c:263: if(dy<0) y=y0-offset;
	ld	a,-5 (ix)
	or	a, a
	jr	Z,00118$
	ld	a,c
	sub	a, -2 (ix)
	ld	-13 (ix),a
	jr	00128$
00118$:
;src/Renderer.c:264: else y=y0+offset;
	ld	a,c
	add	a, -2 (ix)
	ld	-13 (ix),a
00128$:
;src/Renderer.c:233: for(j=0;j<6;++j){
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
	.db #0x01	; 1
	.db #0x09	; 9
	.db #0x03	; 3
	.db #0x18	; 24
	.db #0x12	; 18
	.db #0x05	; 5
	.db #0x0E	; 14
	.db #0x0F	; 15
	.db #0x10	; 16
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
	.dw #0x38E0
_offsets_cells_in_view:
	.db #0x08	; 8
	.db #0x0C	; 12
	.db #0x0E	; 14
	.db #0x0F	; 15
	.db #0x10	; 16
;src/Renderer.c:272: void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
;	---------------------------------
; Function draw_column_to_buffer_untextured
; ---------------------------------
_draw_column_to_buffer_untextured::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;src/Renderer.c:273: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a, 4 (ix)
	srl	a
	add	a, #0x40
	ld	c,a
	ld	a,#0x00
	adc	a, #0x29
	ld	b,a
;src/Renderer.c:275: u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
	ld	de,#_g_colors+0
	ld	l,6 (ix)
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	-2 (ix),a
;src/Renderer.c:276: u8 pixMask = g_pixelMask[column&1];
	ld	de,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l,a
	ld	h,#0x00
	add	hl,de
	ld	e,(hl)
;src/Renderer.c:285: if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
	ld	a,#0x64
	sub	a, 5 (ix)
	jr	NC,00102$
	ld	5 (ix),#0x64
00102$:
;src/Renderer.c:287: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
	ld	l,5 (ix)
	srl	l
	ld	a,#0x32
	sub	a, l
;src/Renderer.c:290: pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
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
;src/Renderer.c:292: j=lineHeight;
	ld	d,5 (ix)
;src/Renderer.c:294: for(j;j;--j){
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
;src/Renderer.c:295: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, -1 (ix)
;src/Renderer.c:297: *pvmem = val|(w_color&pixMask);
	or	a, e
	ld	(bc),a
;src/Renderer.c:299: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:294: for(j;j;--j){
	dec	d
	jr	00105$
00107$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:303: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
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
;src/Renderer.c:320: u16 texture_line=0;
	ld	-10 (ix),#0x00
	ld	-9 (ix),#0x00
;src/Renderer.c:322: if(texture_column>=4 && texture_column<28){
	ld	a,7 (ix)
	sub	a, #0x04
	jp	C,00112$
	ld	a,7 (ix)
	sub	a, #0x1C
	jp	NC,00112$
;src/Renderer.c:325: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(index-1)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
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
	ld	bc,#0x1840
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
;src/Renderer.c:327: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a,4 (ix)
	srl	a
	add	a, #0x40
	ld	-2 (ix),a
	ld	a,#0x00
	adc	a, #0x29
	ld	-1 (ix),a
;src/Renderer.c:329: pixMask = g_pixelMask[column&1];
	ld	bc,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l, a
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-12 (ix),a
;src/Renderer.c:331: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
	ld	a,5 (ix)
	srl	a
	add	a, #0x32
	ld	-11 (ix),a
;src/Renderer.c:332: lineHeight = (lineHeight*3)/4;
	ld	c,5 (ix)
	ld	b,#0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	-4 (ix),l
	ld	-3 (ix),h
	ld	a,-4 (ix)
	ld	-6 (ix),a
	ld	a,-3 (ix)
	ld	-5 (ix),a
	bit	7, -3 (ix)
	jr	Z,00114$
	ld	a,-4 (ix)
	add	a, #0x03
	ld	-6 (ix),a
	ld	a,-3 (ix)
	adc	a, #0x00
	ld	-5 (ix),a
00114$:
	ld	b,-6 (ix)
	ld	c,-5 (ix)
	sra	c
	rr	b
	sra	c
	rr	b
;src/Renderer.c:333: enemy_top_height = ground_height - lineHeight;
	ld	a,-11 (ix)
	sub	a, b
	ld	c,a
;src/Renderer.c:335: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
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
	ld	-8 (ix),l
	ld	-7 (ix),h
;src/Renderer.c:336: j=lineHeight;
	ld	d,b
;src/Renderer.c:338: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
	ld	a,#0x64
	sub	a, b
	jr	NC,00102$
;src/Renderer.c:339: j=90;
	ld	d,#0x5A
00102$:
;src/Renderer.c:342: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
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
;src/Renderer.c:344: for(j;j;--j){
	ld	a,-12 (ix)
	cpl
	ld	e,a
00110$:
	ld	a,d
	or	a, a
	jr	Z,00112$
;src/Renderer.c:346: w_color= *(texture+(texture_line/256));
	ld	l,-9 (ix)
	ld	h,#0x00
	ld	a,-14 (ix)
	add	a, l
	ld	l,a
	ld	a,-13 (ix)
	adc	a, h
	ld	h,a
	ld	a,(hl)
;src/Renderer.c:348: if(w_color){
	ld	-6 (ix), a
	or	a, a
	jr	Z,00104$
;src/Renderer.c:349: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, e
	ld	l,a
;src/Renderer.c:351: w_color = (w_color&pixMask);
	ld	a,-6 (ix)
	and	a, -12 (ix)
;src/Renderer.c:353: *pvmem = val|w_color;
	or	a, l
	ld	(bc),a
00104$:
;src/Renderer.c:356: texture_line += texture_line_add;
	ld	a,-10 (ix)
	add	a, -8 (ix)
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a, -7 (ix)
	ld	-9 (ix),a
;src/Renderer.c:358: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:344: for(j;j;--j){
	dec	d
	jr	00110$
00112$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:364: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
;	---------------------------------
; Function draw_column_to_buffer
; ---------------------------------
_draw_column_to_buffer::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-16
	add	hl,sp
	ld	sp,hl
;src/Renderer.c:365: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a,4 (ix)
	srl	a
	add	a, #0x40
	ld	-2 (ix),a
	ld	a,#0x00
	adc	a, #0x29
	ld	-1 (ix),a
;src/Renderer.c:368: u8 pixMask = g_pixelMask[column&1];
	ld	bc,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l, a
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-11 (ix),a
;src/Renderer.c:373: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
	ld	a, 6 (ix)
	add	a, a
	add	a, a
	ld	b,a
	ld	c,#0x00
	ld	hl,#0x0440
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
;src/Renderer.c:375: u8 j=lineHeight;
	ld	a,5 (ix)
;src/Renderer.c:381: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
	ld	-15 (ix), a
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
	ld	-8 (ix),l
	ld	-7 (ix),h
;src/Renderer.c:382: u16 wall_texture_line=0;
	ld	-13 (ix),#0x00
	ld	-12 (ix),#0x00
;src/Renderer.c:384: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
	ld	c,-15 (ix)
	srl	c
	ld	a,#0x32
	sub	a, c
	ld	-14 (ix),a
;src/Renderer.c:388: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
	ld	a,#0x64
	sub	a, -15 (ix)
	jr	NC,00102$
;src/Renderer.c:389: ceiling_height=0;
	ld	-14 (ix),#0x00
;src/Renderer.c:390: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
	ld	a,-6 (ix)
	add	a,#0x9C
	ld	c,a
	ld	a,-5 (ix)
	adc	a,#0xFF
	ld	b,a
	ld	-4 (ix),c
	ld	-3 (ix),b
	bit	7, b
	jr	Z,00109$
	ld	a,-6 (ix)
	add	a, #0x9D
	ld	-4 (ix),a
	ld	a,-5 (ix)
	adc	a, #0xFF
	ld	-3 (ix),a
00109$:
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
	ld	-13 (ix),l
	ld	-12 (ix),h
;src/Renderer.c:391: j=SCREEN_TEXTURE_HEIGHT;
	ld	-15 (ix),#0x64
00102$:
;src/Renderer.c:394: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
	ld	c,-14 (ix)
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
;src/Renderer.c:396: for(j;j;--j){
	ld	a,-11 (ix)
	cpl
	ld	e,a
	ld	d,-15 (ix)
00105$:
	ld	a,d
	or	a, a
	jr	Z,00107$
;src/Renderer.c:397: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, e
	ld	-16 (ix),a
;src/Renderer.c:399: w_color = (*(texture+(wall_texture_line/256))&pixMask);
	ld	a, -12 (ix)
	ld	h, #0x00
	add	a, -10 (ix)
	ld	l,a
	ld	a,h
	adc	a, -9 (ix)
	ld	h,a
	ld	a,(hl)
	and	a, -11 (ix)
;src/Renderer.c:401: *pvmem = val|w_color;
	or	a, -16 (ix)
	ld	(bc),a
;src/Renderer.c:403: wall_texture_line += wall_texture_line_add;
	ld	a,-13 (ix)
	add	a, -8 (ix)
	ld	-13 (ix),a
	ld	a,-12 (ix)
	adc	a, -7 (ix)
	ld	-12 (ix),a
;src/Renderer.c:405: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:396: for(j;j;--j){
	dec	d
	jr	00105$
00107$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:409: void render_draw_to_buffer(){//TODO Optimize
;	---------------------------------
; Function render_draw_to_buffer
; ---------------------------------
_render_draw_to_buffer::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-62
	add	hl,sp
	ld	sp,hl
;src/Renderer.c:419: u8 zHeight = 5;
	ld	-56 (ix),#0x05
;src/Renderer.c:425: u8 offsetDiff = 16;
	ld	-50 (ix),#0x10
;src/Renderer.c:430: u8 lineStart = 0;
	ld	-55 (ix),#0x00
;src/Renderer.c:432: u8 lateralWallWidth=0;
	ld	-59 (ix),#0x00
;src/Renderer.c:444: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
	ld	hl, #_g_colors + 5
	ld	b,(hl)
	ld	hl,#0x07A8
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x2940
	push	hl
	call	_cpct_memset
;src/Renderer.c:445: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
	ld	hl, #_g_colors + 1
	ld	b,(hl)
	ld	hl,#0x0050
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x30E8
	push	hl
	call	_cpct_memset
;src/Renderer.c:446: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
	ld	hl, #_g_colors + 6
	ld	b,(hl)
	ld	hl,#0x07A8
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x3138
	push	hl
	call	_cpct_memset
;src/Renderer.c:448: calculate_cells_in_view();
	call	_calculate_cells_in_view
;src/Renderer.c:466: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-8 (ix),l
	ld	-7 (ix),h
;src/Renderer.c:450: if(g_texturedWalls){
	ld	a,(#_g_texturedWalls + 0)
	or	a, a
	jp	Z,00358$
;src/Renderer.c:452: do{
	ld	-62 (ix),#0x06
00175$:
;src/Renderer.c:454: --z;
	dec	-62 (ix)
;src/Renderer.c:458: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-56 (ix)
	srl	a
	ld	-6 (ix),a
	ld	a,-62 (ix)
	or	a, a
	jr	Z,00262$
	ld	c,-6 (ix)
	jr	00263$
00262$:
	ld	c,#0x00
00263$:
	ld	-5 (ix),c
;src/Renderer.c:459: lateralWallSlope=0;
	ld	-3 (ix),#0x00
;src/Renderer.c:460: lateralWallSlopeCounter=0;
	ld	-1 (ix),#0x00
;src/Renderer.c:461: xHeight=0;
	ld	-4 (ix),#0x00
;src/Renderer.c:463: lateralWallCounter = 0;
	ld	-2 (ix),#0x00
;src/Renderer.c:465: newCell=1;
	ld	-14 (ix),#0x01
;src/Renderer.c:466: currentCellID = cells_in_view_array[lineStart + 1];
	ld	a,-55 (ix)
	ld	-10 (ix),a
	ld	-9 (ix),#0x00
	ld	c,-10 (ix)
	ld	b,-9 (ix)
	inc	bc
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	add	hl,bc
	ld	a,(hl)
	ld	-36 (ix),a
;src/Renderer.c:468: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
	ld	a,-8 (ix)
	add	a, -55 (ix)
	ld	l,a
	ld	a,-7 (ix)
	adc	a, #0x00
	ld	h,a
	ld	c,(hl)
;src/Renderer.c:469: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00102$
;src/Renderer.c:470: lastWallId=lastCellWasWall;
	ld	-39 (ix),c
;src/Renderer.c:471: lastCellWasWall=1;
	ld	-41 (ix),#0x01
	jr	00296$
00102$:
;src/Renderer.c:474: lastCellWasWall=0;
	ld	-41 (ix),#0x00
;src/Renderer.c:475: lastWallId=CELLTYPE_FLOOR;
	ld	-39 (ix),#0x00
;src/Renderer.c:478: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
00296$:
	ld	-57 (ix),#0x00
	ld	-61 (ix),#0x00
00252$:
;src/Renderer.c:480: if (xCellCount == zHeight)
	ld	a,-56 (ix)
	sub	a, -5 (ix)
	jr	NZ,00105$
;src/Renderer.c:482: ++xCell;
	inc	-57 (ix)
;src/Renderer.c:483: xCellCount = 0;
	ld	-5 (ix),#0x00
;src/Renderer.c:484: newCell=1;
	ld	-14 (ix),#0x01
;src/Renderer.c:485: currentCellID=cells_in_view_array[xCell + lineStart + 1];
	ld	a,-57 (ix)
	ld	-38 (ix),a
	ld	-37 (ix),#0x00
	ld	a,-10 (ix)
	add	a, -38 (ix)
	ld	-38 (ix),a
	ld	a,-9 (ix)
	adc	a, -37 (ix)
	ld	-37 (ix),a
	inc	-38 (ix)
	jr	NZ,00608$
	inc	-37 (ix)
00608$:
	ld	a,-8 (ix)
	add	a, -38 (ix)
	ld	-38 (ix),a
	ld	a,-7 (ix)
	adc	a, -37 (ix)
	ld	-37 (ix),a
	ld	l,-38 (ix)
	ld	h,-37 (ix)
	ld	a,(hl)
	ld	-36 (ix),a
00105$:
;src/Renderer.c:487: if(!(x%2)){
	ld	a,-61 (ix)
	and	a, #0x01
	ld	-38 (ix),a
;src/Renderer.c:490: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-36 (ix)
	and	a, #0x80
	ld	-40 (ix),a
;src/Renderer.c:510: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-5 (ix)
	ld	-20 (ix),a
	ld	-19 (ix),#0x00
	ld	a,-56 (ix)
	ld	-31 (ix),a
;src/Renderer.c:487: if(!(x%2)){
	ld	a,-38 (ix)
	or	a, a
	jp	NZ,00118$
;src/Renderer.c:488: if ((lateralWallCounter == 0)||newCell)
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00114$
	ld	a,-14 (ix)
	or	a, a
	jp	Z,00118$
00114$:
;src/Renderer.c:490: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-40 (ix)
	or	a, a
	jr	Z,00112$
;src/Renderer.c:492: lateralWallCounter = 0;//(zHeight - xCellCount);
	ld	-2 (ix),#0x00
;src/Renderer.c:493: lateralWallSlope = 0;
	ld	-3 (ix),#0x00
;src/Renderer.c:494: xHeight = zHeight;
	ld	a,-56 (ix)
	ld	-4 (ix),a
;src/Renderer.c:495: color = currentCellID&0b01111111;
	ld	a,-36 (ix)
	and	a, #0x7F
	ld	-13 (ix),a
;src/Renderer.c:496: lastCellWasWall = 1;
	ld	-41 (ix),#0x01
;src/Renderer.c:497: lastWallId=currentCellID;
	ld	a,-36 (ix)
	ld	-39 (ix),a
	jr	00113$
00112$:
;src/Renderer.c:500: if(lateralWallCounter==0){//Lateral wall not finished
	ld	a,-2 (ix)
	or	a, a
	jr	NZ,00113$
;src/Renderer.c:501: if (lastCellWasWall)
	ld	a,-41 (ix)
	or	a, a
	jr	Z,00107$
;src/Renderer.c:504: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-50 (ix)
	sub	a, -57 (ix)
	add	a, a
	inc	a
;src/Renderer.c:505: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-3 (ix), a
	srl	a
	ld	-1 (ix),a
;src/Renderer.c:506: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-56 (ix)
	ld	h,-3 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00609$:
	add	hl,hl
	jr	NC,00610$
	add	hl,de
00610$:
	djnz	00609$
;src/Renderer.c:507: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
	ld	a,l
	and	a, #0xFC
	set	0, a
	srl	a
	srl	a
	sub	a, -5 (ix)
;src/Renderer.c:508: lateralWallWidth=lateralWallCounter;
	ld	-2 (ix), a
	ld	-59 (ix),a
;src/Renderer.c:509: lastCellWasWall = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:510: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	add	hl, hl
	ld	c,-3 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-31 (ix)
	sub	a, l
	ld	-4 (ix),a
;src/Renderer.c:511: color = lastWallId&0b01111111;
	ld	a,-39 (ix)
	and	a, #0x7F
	ld	-13 (ix),a
	jr	00113$
00107$:
;src/Renderer.c:515: xHeight = 0;
	ld	-4 (ix),#0x00
;src/Renderer.c:516: lastCellWasWall = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:517: lateralWallSlope=0;
	ld	-3 (ix),#0x00
;src/Renderer.c:518: lastWallId=0;
	ld	-39 (ix),#0x00
00113$:
;src/Renderer.c:522: newCell=0;
	ld	-14 (ix),#0x00
00118$:
;src/Renderer.c:525: if (lateralWallCounter > 0)
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00124$
;src/Renderer.c:528: if (lateralWallSlope != 0)
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00122$
;src/Renderer.c:530: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-1 (ix)
	sub	a, -3 (ix)
	jr	NZ,00120$
;src/Renderer.c:532: lateralWallSlopeCounter = 0;
	ld	-1 (ix),#0x00
;src/Renderer.c:533: xHeight -= 2;
	dec	-4 (ix)
	dec	-4 (ix)
00120$:
;src/Renderer.c:535: ++lateralWallSlopeCounter;
	inc	-1 (ix)
00122$:
;src/Renderer.c:538: --lateralWallCounter;
	dec	-2 (ix)
00124$:
;src/Renderer.c:549: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-56 (ix)
	ld	-12 (ix),a
	ld	-11 (ix),#0x00
;src/Renderer.c:541: if (!(x%2))
	ld	a,-38 (ix)
	or	a, a
	jp	NZ,00136$
;src/Renderer.c:543: if(xHeight > 0){
	ld	a,-4 (ix)
	or	a, a
	jr	Z,00136$
;src/Renderer.c:549: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c,-12 (ix)
	ld	b,-11 (ix)
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	c,l
;src/Renderer.c:544: if (lateralWallCounter > 0)
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00126$
;src/Renderer.c:546: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
	ld	e,-59 (ix)
	ld	d,#0x00
	ld	b,-2 (ix)
	ld	h,#0x00
	ld	a,e
	sub	a, b
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
;src/Renderer.c:549: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	d,c
00127$:
;src/Renderer.c:551: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	ld	b,-61 (ix)
	srl	b
	push	bc
	push	de
	inc	sp
	ld	h,-13 (ix)
	ld	l,-4 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer
	pop	af
	pop	af
	pop	bc
;src/Renderer.c:552: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-40 (ix)
	or	a, a
	jr	NZ,00136$
;src/Renderer.c:553: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-36 (ix)
	and	a, #0x0F
	jr	Z,00136$
;src/Renderer.c:554: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	a,c
	push	af
	inc	sp
	ld	h,-36 (ix)
	ld	l,-56 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:556: else if(currentCellID&CELL_ITEM_MASK){
00136$:
;src/Renderer.c:563: ++xCellCount;
	inc	-5 (ix)
;src/Renderer.c:478: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	inc	-61 (ix)
;src/Renderer.c:466: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-8 (ix),l
	ld	-7 (ix),h
;src/Renderer.c:478: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	ld	a,-61 (ix)
	sub	a, #0x50
	jp	C,00252$
;src/Renderer.c:570: xCellCount = (z) ? (zHeight >> 1) : 0 ;
	ld	a,-62 (ix)
	or	a, a
	jr	Z,00264$
	ld	c,-6 (ix)
	jr	00265$
00264$:
	ld	c,#0x00
00265$:
	ld	-20 (ix),c
;src/Renderer.c:571: lateralWallSlope=0;
	ld	-40 (ix),#0x00
;src/Renderer.c:572: lateralWallSlopeCounter=0;
	ld	-38 (ix),#0x00
;src/Renderer.c:573: xHeight=0;
	ld	-41 (ix),#0x00
;src/Renderer.c:575: lateralWallCounter = 0;
	ld	-39 (ix),#0x00
;src/Renderer.c:576: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	a,-50 (ix)
	add	a, a
	ld	c,a
	ld	a,-55 (ix)
	add	a, c
	ld	-36 (ix), a
	ld	c, a
	inc	c
	inc	c
;src/Renderer.c:578: newCell=1;
	ld	-10 (ix),#0x01
;src/Renderer.c:579: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	-22 (ix),c
	ld	-21 (ix),#0x00
	ld	e,-22 (ix)
	ld	d,-21 (ix)
	dec	de
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	add	hl,de
	ld	a,(hl)
	ld	-14 (ix),a
;src/Renderer.c:581: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	b,#0x00
	add	hl, bc
	ld	c,(hl)
;src/Renderer.c:582: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00139$
;src/Renderer.c:583: lastWallId=lastCellWasWall;
	ld	-2 (ix),c
;src/Renderer.c:584: lastCellWasWall=1;
	ld	-4 (ix),#0x01
	jr	00315$
00139$:
;src/Renderer.c:587: lastCellWasWall=0;
	ld	-4 (ix),#0x00
;src/Renderer.c:588: lastWallId=CELLTYPE_FLOOR;
	ld	-2 (ix),#0x00
;src/Renderer.c:591: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
00315$:
	ld	-57 (ix),#0x00
	ld	-61 (ix),#0x9F
00254$:
;src/Renderer.c:594: if (xCellCount == zHeight)
	ld	a,-56 (ix)
	sub	a, -20 (ix)
	jr	NZ,00142$
;src/Renderer.c:596: ++xCell;
	inc	-57 (ix)
;src/Renderer.c:597: xCellCount = 0;
	ld	-20 (ix),#0x00
;src/Renderer.c:598: newCell=1;
	ld	-10 (ix),#0x01
;src/Renderer.c:599: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
	ld	a,-57 (ix)
	ld	-18 (ix),a
	ld	-17 (ix),#0x00
	ld	a,-22 (ix)
	sub	a, -18 (ix)
	ld	-18 (ix),a
	ld	a,-21 (ix)
	sbc	a, -17 (ix)
	ld	-17 (ix),a
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	dec	hl
	ld	-18 (ix),l
	ld	-17 (ix),h
	ld	a,-8 (ix)
	add	a, -18 (ix)
	ld	-18 (ix),a
	ld	a,-7 (ix)
	adc	a, -17 (ix)
	ld	-17 (ix),a
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	ld	a,(hl)
	ld	-14 (ix),a
00142$:
;src/Renderer.c:601: if(!(x%2)){
	ld	a,-61 (ix)
	and	a, #0x01
	ld	-18 (ix),a
;src/Renderer.c:490: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-14 (ix)
	and	a, #0x80
	ld	-1 (ix),a
;src/Renderer.c:510: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-20 (ix)
	ld	-16 (ix),a
	ld	-15 (ix),#0x00
;src/Renderer.c:601: if(!(x%2)){
	ld	a,-18 (ix)
	or	a, a
	jp	NZ,00155$
;src/Renderer.c:602: if (lateralWallCounter == 0 || newCell)
	ld	a,-39 (ix)
	or	a, a
	jr	Z,00151$
	ld	a,-10 (ix)
	or	a, a
	jp	Z,00155$
00151$:
;src/Renderer.c:604: if ( currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00149$
;src/Renderer.c:606: lateralWallCounter = 0;
	ld	-39 (ix),#0x00
;src/Renderer.c:607: lateralWallSlope = 0;
	ld	-40 (ix),#0x00
;src/Renderer.c:608: xHeight = zHeight;
	ld	a,-56 (ix)
	ld	-41 (ix),a
;src/Renderer.c:609: color = currentCellID&0b01111111;
	ld	a,-14 (ix)
	and	a, #0x7F
	ld	-13 (ix),a
;src/Renderer.c:610: lastCellWasWall = 1;
	ld	-4 (ix),#0x01
;src/Renderer.c:611: lastWallId=currentCellID;
	ld	a,-14 (ix)
	ld	-2 (ix),a
	jp	00150$
00149$:
;src/Renderer.c:613: else if(lateralWallCounter==0){
	ld	a,-39 (ix)
	or	a, a
	jp	NZ,00150$
;src/Renderer.c:614: if (lastCellWasWall)
	ld	a,-4 (ix)
	or	a, a
	jr	Z,00144$
;src/Renderer.c:617: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-50 (ix)
	sub	a, -57 (ix)
	add	a, a
	inc	a
;src/Renderer.c:618: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-40 (ix), a
	srl	a
	ld	-38 (ix),a
;src/Renderer.c:619: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-56 (ix)
	ld	h,-40 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00617$:
	add	hl,hl
	jr	NC,00618$
	add	hl,de
00618$:
	djnz	00617$
;src/Renderer.c:620: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
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
	ld	c,-20 (ix)
	ld	a,l
	sub	a, c
;src/Renderer.c:621: lateralWallWidth=lateralWallCounter;
	ld	-39 (ix), a
	ld	-59 (ix),a
;src/Renderer.c:622: lastCellWasWall = 0;
	ld	-4 (ix),#0x00
;src/Renderer.c:623: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	add	hl, hl
	ld	c,-40 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-31 (ix)
	sub	a, l
	ld	-41 (ix),a
;src/Renderer.c:624: color = lastWallId&0b01111111;
	ld	a,-2 (ix)
	and	a, #0x7F
	ld	-13 (ix),a
	jr	00150$
00144$:
;src/Renderer.c:628: xHeight = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:629: lastCellWasWall = 0;
	ld	-4 (ix),#0x00
;src/Renderer.c:630: lateralWallSlope=0;
	ld	-40 (ix),#0x00
;src/Renderer.c:631: lastWallId=0;
	ld	-2 (ix),#0x00
00150$:
;src/Renderer.c:634: newCell=0;
	ld	-10 (ix),#0x00
00155$:
;src/Renderer.c:639: if (lateralWallCounter > 0)
	ld	a,-39 (ix)
	or	a, a
	jr	Z,00161$
;src/Renderer.c:642: if (lateralWallSlope != 0)
	ld	a,-40 (ix)
	or	a, a
	jr	Z,00159$
;src/Renderer.c:644: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-40 (ix)
	sub	a, -38 (ix)
	jr	NZ,00157$
;src/Renderer.c:646: lateralWallSlopeCounter = 0;
	ld	-38 (ix),#0x00
;src/Renderer.c:647: xHeight -= 2;
	dec	-41 (ix)
	dec	-41 (ix)
00157$:
;src/Renderer.c:649: ++lateralWallSlopeCounter;
	inc	-38 (ix)
00159$:
;src/Renderer.c:651: --lateralWallCounter;
	dec	-39 (ix)
00161$:
;src/Renderer.c:655: if (!(x%2))
	ld	a,-18 (ix)
	or	a, a
	jp	NZ,00173$
;src/Renderer.c:658: if(xHeight > 0){
	ld	a,-41 (ix)
	or	a, a
	jp	Z,00173$
;src/Renderer.c:665: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-12 (ix)
	sub	a, -16 (ix)
	ld	-16 (ix),a
	ld	a,-11 (ix)
	sbc	a, -15 (ix)
	ld	-15 (ix),a
	ld	a,#0x05+1
	jr	00622$
00621$:
	sla	-16 (ix)
	rl	-15 (ix)
00622$:
	dec	a
	jr	NZ,00621$
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-15 (ix),h
	ld	-16 (ix), l
	ld	-16 (ix), l
;src/Renderer.c:660: if (lateralWallCounter > 0)
	ld	a,-39 (ix)
	or	a, a
	jr	Z,00163$
;src/Renderer.c:662: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
	ld	a,-39 (ix)
	ld	-18 (ix),a
	ld	-17 (ix),#0x00
	ld	a,#0x05+1
	jr	00624$
00623$:
	sla	-18 (ix)
	rl	-17 (ix)
00624$:
	dec	a
	jr	NZ,00623$
	ld	a,-59 (ix)
	ld	-33 (ix),a
	ld	-32 (ix),#0x00
	ld	l,-33 (ix)
	ld	h,-32 (ix)
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	d,l
	jr	00164$
00163$:
;src/Renderer.c:665: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	d,-16 (ix)
00164$:
;src/Renderer.c:668: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	ld	b,-61 (ix)
	srl	b
	push	bc
	push	de
	inc	sp
	ld	h,-13 (ix)
	ld	l,-41 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer
	pop	af
	pop	af
	pop	bc
;src/Renderer.c:670: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00173$
;src/Renderer.c:671: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-14 (ix)
	and	a, #0x0F
	jr	Z,00173$
;src/Renderer.c:672: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	h,-16 (ix)
	ld	l,-14 (ix)
	push	hl
	ld	a,-56 (ix)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:674: else if(currentCellID&CELL_ITEM_MASK){
00173$:
;src/Renderer.c:680: ++xCellCount;
	inc	-20 (ix)
;src/Renderer.c:591: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	dec	-61 (ix)
;src/Renderer.c:466: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-8 (ix),l
	ld	-7 (ix),h
;src/Renderer.c:591: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	ld	a,-61 (ix)
	sub	a, #0x50
	jp	NC,00254$
;src/Renderer.c:687: lineStart = lineStart + (offsetDiff * 2) + 3;
	ld	a,-36 (ix)
	add	a, #0x03
	ld	-55 (ix),a
;src/Renderer.c:688: zHeight += zHeight;
	sla	-56 (ix)
;src/Renderer.c:689: offsetDiff = offsetDiff >> 1;
	srl	-50 (ix)
;src/Renderer.c:691: }while(z);
	ld	a,-62 (ix)
	or	a, a
	jp	NZ,00175$
	jp	00260$
;src/Renderer.c:696: do{
00358$:
	ld	-62 (ix),#0x06
00246$:
;src/Renderer.c:698: --z;
	dec	-62 (ix)
;src/Renderer.c:458: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-56 (ix)
	srl	a
	ld	-33 (ix),a
;src/Renderer.c:702: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-62 (ix)
	or	a, a
	jr	Z,00267$
	ld	c,-33 (ix)
	jr	00268$
00267$:
	ld	c,#0x00
00268$:
	ld	-49 (ix),c
;src/Renderer.c:703: lateralWallSlope=0;
	ld	-60 (ix),#0x00
;src/Renderer.c:704: lateralWallSlopeCounter=0;
	ld	-51 (ix),#0x00
;src/Renderer.c:705: xHeight=0;
	ld	-48 (ix),#0x00
;src/Renderer.c:707: lateralWallCounter = 0;
	ld	-16 (ix),#0x00
;src/Renderer.c:709: newCell=1;
	ld	-47 (ix),#0x01
;src/Renderer.c:466: currentCellID = cells_in_view_array[lineStart + 1];
	ld	a,-55 (ix)
	ld	-18 (ix),a
	ld	-17 (ix),#0x00
;src/Renderer.c:710: currentCellID = cells_in_view_array[lineStart + 1];
	ld	c,-18 (ix)
	ld	b,-17 (ix)
	inc	bc
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	add	hl,bc
	ld	a,(hl)
	ld	-46 (ix),a
;src/Renderer.c:712: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
	ld	a,-8 (ix)
	add	a, -55 (ix)
	ld	l,a
	ld	a,-7 (ix)
	adc	a, #0x00
	ld	h,a
	ld	c,(hl)
;src/Renderer.c:713: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00179$
;src/Renderer.c:714: lastWallId=lastCellWasWall;
	ld	-53 (ix),c
;src/Renderer.c:715: lastCellWasWall=1;
	ld	-22 (ix),#0x01
	jr	00336$
00179$:
;src/Renderer.c:718: lastCellWasWall=0;
	ld	-22 (ix),#0x00
;src/Renderer.c:719: lastWallId=CELLTYPE_FLOOR;
	ld	-53 (ix),#0x00
;src/Renderer.c:722: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
00336$:
	ld	-57 (ix),#0x00
	ld	-61 (ix),#0x00
00256$:
;src/Renderer.c:724: if (xCellCount == zHeight)
	ld	a,-49 (ix)
	sub	a, -56 (ix)
	jr	NZ,00182$
;src/Renderer.c:726: ++xCell;
	inc	-57 (ix)
;src/Renderer.c:727: xCellCount = 0;
	ld	-49 (ix),#0x00
;src/Renderer.c:728: newCell=1;
	ld	-47 (ix),#0x01
;src/Renderer.c:729: currentCellID=cells_in_view_array[xCell + lineStart + 1];
	ld	a,-57 (ix)
	ld	-12 (ix),a
	ld	-11 (ix),#0x00
	ld	a,-18 (ix)
	add	a, -12 (ix)
	ld	-12 (ix),a
	ld	a,-17 (ix)
	adc	a, -11 (ix)
	ld	-11 (ix),a
	inc	-12 (ix)
	jr	NZ,00629$
	inc	-11 (ix)
00629$:
	ld	a,-12 (ix)
	add	a, -8 (ix)
	ld	-12 (ix),a
	ld	a,-11 (ix)
	adc	a, -7 (ix)
	ld	-11 (ix),a
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	ld	a,(hl)
	ld	-46 (ix),a
00182$:
;src/Renderer.c:731: if(!(x%2)){
	ld	a,-61 (ix)
	and	a, #0x01
	ld	-12 (ix),a
;src/Renderer.c:490: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-46 (ix)
	and	a, #0x80
	ld	-13 (ix),a
;src/Renderer.c:510: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-49 (ix)
	ld	-20 (ix),a
	ld	-19 (ix),#0x00
	ld	a,-56 (ix)
	ld	-31 (ix),a
;src/Renderer.c:731: if(!(x%2)){
	ld	a,-12 (ix)
	or	a, a
	jp	NZ,00195$
;src/Renderer.c:732: if ((lateralWallCounter == 0)||newCell)
	ld	a,-16 (ix)
	or	a, a
	jr	Z,00191$
	ld	a,-47 (ix)
	or	a, a
	jp	Z,00195$
00191$:
;src/Renderer.c:734: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-13 (ix)
	or	a, a
	jr	Z,00189$
;src/Renderer.c:736: lateralWallCounter = 0;//(zHeight - xCellCount);
	ld	-16 (ix),#0x00
;src/Renderer.c:737: lateralWallSlope = 0;
	ld	-60 (ix),#0x00
;src/Renderer.c:738: xHeight = zHeight;
	ld	a,-56 (ix)
	ld	-48 (ix),a
;src/Renderer.c:739: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
	ld	a,-46 (ix)
	sub	a, #0x80
	jr	NZ,00269$
	ld	c,#0x0C
	jr	00270$
00269$:
	ld	c,#0x0E
00270$:
	ld	-58 (ix),c
;src/Renderer.c:740: lastCellWasWall = 1;
	ld	-22 (ix),#0x01
;src/Renderer.c:741: lastWallId=currentCellID;
	ld	a,-46 (ix)
	ld	-53 (ix),a
	jp	00190$
00189$:
;src/Renderer.c:744: if(lateralWallCounter==0){//Lateral wall not finished
	ld	a,-16 (ix)
	or	a, a
	jp	NZ,00190$
;src/Renderer.c:745: if (lastCellWasWall)
	ld	a,-22 (ix)
	or	a, a
	jp	Z,00184$
;src/Renderer.c:748: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-50 (ix)
	sub	a, -57 (ix)
	add	a, a
	inc	a
;src/Renderer.c:749: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-60 (ix), a
	srl	a
	ld	-51 (ix),a
;src/Renderer.c:750: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-56 (ix)
	ld	h,-60 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00632$:
	add	hl,hl
	jr	NC,00633$
	add	hl,de
00633$:
	djnz	00632$
	ld	-40 (ix), l
	ld	a, l
;src/Renderer.c:751: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
	ld	-52 (ix), a
	and	a, #0xFC
	ld	-40 (ix), a
	set	0, a
	ld	-40 (ix), a
	srl	a
	srl	a
	sub	a, -49 (ix)
	ld	-16 (ix),a
;src/Renderer.c:753: lastCellWasWall = 0;
	ld	-22 (ix),#0x00
;src/Renderer.c:754: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-20 (ix)
	ld	-38 (ix),a
	ld	a,-19 (ix)
	ld	-37 (ix),a
	sla	-38 (ix)
	rl	-37 (ix)
	ld	a,-60 (ix)
	ld	-10 (ix),a
	ld	-9 (ix),#0x00
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-38 (ix)
	ld	h,-37 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-37 (ix),h
	ld	-38 (ix), l
	ld	-40 (ix), l
	ld	a,-31 (ix)
	sub	a, -40 (ix)
	ld	-48 (ix),a
;src/Renderer.c:755: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
	ld	a,-53 (ix)
	sub	a, #0x80
	jr	NZ,00271$
	ld	c,#0x0F
	jr	00272$
00271$:
	ld	c,#0x0D
00272$:
	ld	-58 (ix),c
	jr	00190$
00184$:
;src/Renderer.c:759: xHeight = 0;
	ld	-48 (ix),#0x00
;src/Renderer.c:760: lastCellWasWall = 0;
	ld	-22 (ix),#0x00
;src/Renderer.c:761: lateralWallSlope=0;
	ld	-60 (ix),#0x00
;src/Renderer.c:762: lastWallId=0;
	ld	-53 (ix),#0x00
00190$:
;src/Renderer.c:766: newCell=0;
	ld	-47 (ix),#0x00
00195$:
;src/Renderer.c:769: if (lateralWallCounter > 0)
	ld	a,-16 (ix)
	or	a, a
	jr	Z,00201$
;src/Renderer.c:772: if (lateralWallSlope != 0)
	ld	a,-60 (ix)
	or	a, a
	jr	Z,00199$
;src/Renderer.c:774: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-60 (ix)
	sub	a, -51 (ix)
	jr	NZ,00197$
;src/Renderer.c:776: lateralWallSlopeCounter = 0;
	ld	-51 (ix),#0x00
;src/Renderer.c:777: xHeight -= 2;
	dec	-48 (ix)
	dec	-48 (ix)
00197$:
;src/Renderer.c:779: ++lateralWallSlopeCounter;
	inc	-51 (ix)
00199$:
;src/Renderer.c:782: --lateralWallCounter;
	dec	-16 (ix)
00201$:
;src/Renderer.c:549: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-56 (ix)
	ld	-38 (ix),a
	ld	-37 (ix),#0x00
;src/Renderer.c:785: if (!(x%2))
	ld	a,-12 (ix)
	or	a, a
	jr	NZ,00210$
;src/Renderer.c:787: if(xHeight > 0){
	ld	a,-48 (ix)
	or	a, a
	jr	Z,00210$
;src/Renderer.c:788: draw_column_to_buffer_untextured(x/2, xHeight, color);
	ld	a,-61 (ix)
	srl	a
	ld	-12 (ix),a
	ld	h,-58 (ix)
	ld	l,-48 (ix)
	push	hl
	ld	a,-12 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer_untextured
	pop	af
	inc	sp
;src/Renderer.c:790: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-13 (ix)
	or	a, a
	jr	NZ,00210$
;src/Renderer.c:791: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-46 (ix)
	and	a, #0x0F
	jr	Z,00210$
;src/Renderer.c:792: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	a,#0x05+1
	jr	00642$
00641$:
	sla	-20 (ix)
	rl	-19 (ix)
00642$:
	dec	a
	jr	NZ,00641$
	ld	l,-38 (ix)
	ld	h,-37 (ix)
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
	push	bc
	inc	sp
	ld	h,-46 (ix)
	ld	l,-56 (ix)
	push	hl
	ld	a,-12 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:794: else if(currentCellID&CELL_ITEM_MASK){
00210$:
;src/Renderer.c:801: ++xCellCount;
	inc	-49 (ix)
;src/Renderer.c:722: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	inc	-61 (ix)
;src/Renderer.c:466: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-8 (ix),l
	ld	-7 (ix),h
;src/Renderer.c:722: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	ld	a,-61 (ix)
	sub	a, #0x50
	jp	C,00256$
;src/Renderer.c:808: xCellCount = (z) ? (zHeight >> 1) : 0 ;
	ld	a,-62 (ix)
	or	a, a
	jr	Z,00273$
	ld	a,-33 (ix)
	ld	-33 (ix),a
	jr	00274$
00273$:
	ld	-33 (ix),#0x00
00274$:
	ld	a,-33 (ix)
	ld	-33 (ix),a
;src/Renderer.c:809: lateralWallSlope=0;
	ld	-16 (ix),#0x00
;src/Renderer.c:810: lateralWallSlopeCounter=0;
	ld	-18 (ix),#0x00
;src/Renderer.c:811: xHeight=0;
	ld	-22 (ix),#0x00
;src/Renderer.c:813: lateralWallCounter = 0;
	ld	-12 (ix),#0x00
;src/Renderer.c:576: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	a,-50 (ix)
	add	a, a
	ld	-13 (ix),a
	ld	a,-55 (ix)
	add	a, -13 (ix)
;src/Renderer.c:814: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	-13 (ix), a
	add	a, #0x02
	ld	-54 (ix),a
;src/Renderer.c:816: newCell=1;
	ld	-20 (ix),#0x01
;src/Renderer.c:579: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	a,-54 (ix)
	ld	-10 (ix),a
	ld	-9 (ix),#0x00
;src/Renderer.c:817: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	a,-10 (ix)
	add	a,#0xFF
	ld	-35 (ix),a
	ld	a,-9 (ix)
	adc	a,#0xFF
	ld	-34 (ix),a
	ld	a,-8 (ix)
	add	a, -35 (ix)
	ld	-35 (ix),a
	ld	a,-7 (ix)
	adc	a, -34 (ix)
	ld	-34 (ix),a
	ld	l,-35 (ix)
	ld	h,-34 (ix)
	ld	a,(hl)
	ld	-35 (ix),a
;src/Renderer.c:819: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
	ld	a,-8 (ix)
	add	a, -54 (ix)
	ld	-43 (ix),a
	ld	a,-7 (ix)
	adc	a, #0x00
	ld	-42 (ix),a
	ld	l,-43 (ix)
	ld	h,-42 (ix)
	ld	a,(hl)
	ld	-43 (ix),a
;src/Renderer.c:820: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, -43 (ix)
	jr	Z,00213$
;src/Renderer.c:821: lastWallId=lastCellWasWall;
	ld	a,-43 (ix)
	ld	-43 (ix),a
;src/Renderer.c:822: lastCellWasWall=1;
	ld	-40 (ix),#0x01
	jr	00356$
00213$:
;src/Renderer.c:825: lastCellWasWall=0;
	ld	-40 (ix),#0x00
;src/Renderer.c:826: lastWallId=CELLTYPE_FLOOR;
	ld	-43 (ix),#0x00
;src/Renderer.c:829: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
00356$:
	ld	-57 (ix),#0x00
	ld	-61 (ix),#0x9F
00258$:
;src/Renderer.c:832: if (xCellCount == zHeight)
	ld	a,-56 (ix)
	sub	a, -33 (ix)
	jr	NZ,00216$
;src/Renderer.c:834: ++xCell;
	inc	-57 (ix)
;src/Renderer.c:835: xCellCount = 0;
	ld	-33 (ix),#0x00
;src/Renderer.c:836: newCell=1;
	ld	-20 (ix),#0x01
;src/Renderer.c:837: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
	ld	a,-57 (ix)
	ld	-28 (ix),a
	ld	-27 (ix),#0x00
	ld	a,-10 (ix)
	sub	a, -28 (ix)
	ld	-28 (ix),a
	ld	a,-9 (ix)
	sbc	a, -27 (ix)
	ld	-27 (ix),a
	ld	l,-28 (ix)
	ld	h,-27 (ix)
	dec	hl
	ld	-28 (ix),l
	ld	-27 (ix),h
	ld	a,-8 (ix)
	add	a, -28 (ix)
	ld	-28 (ix),a
	ld	a,-7 (ix)
	adc	a, -27 (ix)
	ld	-27 (ix),a
	ld	l,-28 (ix)
	ld	h,-27 (ix)
	ld	a,(hl)
	ld	-35 (ix),a
00216$:
;src/Renderer.c:839: if(!(x%2)){
	ld	a,-61 (ix)
	and	a, #0x01
	ld	-28 (ix),a
;src/Renderer.c:490: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-35 (ix)
	and	a, #0x80
	ld	-41 (ix),a
;src/Renderer.c:510: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-33 (ix)
	ld	-24 (ix),a
	ld	-23 (ix),#0x00
;src/Renderer.c:839: if(!(x%2)){
	ld	a,-28 (ix)
	or	a, a
	jp	NZ,00229$
;src/Renderer.c:840: if (lateralWallCounter == 0 || newCell)
	ld	a,-12 (ix)
	or	a, a
	jr	Z,00225$
	ld	a,-20 (ix)
	or	a, a
	jp	Z,00229$
00225$:
;src/Renderer.c:842: if ( currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-41 (ix)
	or	a, a
	jr	Z,00223$
;src/Renderer.c:844: lateralWallCounter = 0;
	ld	-12 (ix),#0x00
;src/Renderer.c:845: lateralWallSlope = 0;
	ld	-16 (ix),#0x00
;src/Renderer.c:846: xHeight = zHeight;
	ld	a,-56 (ix)
	ld	-22 (ix),a
;src/Renderer.c:847: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
	ld	a,-35 (ix)
	sub	a, #0x80
	jr	NZ,00275$
	ld	-39 (ix),#0x0C
	jr	00276$
00275$:
	ld	-39 (ix),#0x0E
00276$:
	ld	a,-39 (ix)
	ld	-58 (ix),a
;src/Renderer.c:848: lastCellWasWall = 1;
	ld	-40 (ix),#0x01
;src/Renderer.c:849: lastWallId=currentCellID;
	ld	a,-35 (ix)
	ld	-43 (ix),a
	jp	00224$
00223$:
;src/Renderer.c:851: else if(lateralWallCounter==0){
	ld	a,-12 (ix)
	or	a, a
	jp	NZ,00224$
;src/Renderer.c:852: if (lastCellWasWall)
	ld	a,-40 (ix)
	or	a, a
	jp	Z,00218$
;src/Renderer.c:855: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-50 (ix)
	sub	a, -57 (ix)
	add	a, a
	inc	a
;src/Renderer.c:856: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-16 (ix), a
	srl	a
	ld	-18 (ix),a
;src/Renderer.c:857: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-56 (ix)
	ld	h,-16 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00648$:
	add	hl,hl
	jr	NC,00649$
	add	hl,de
00649$:
	djnz	00648$
;src/Renderer.c:858: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
	ld	-39 (ix), l
	ld	-26 (ix), l
	ld	-25 (ix),#0x00
	ld	a,-39 (ix)
	and	a, #0x03
	ld	-39 (ix), a
	ld	-45 (ix),a
	ld	-44 (ix),#0x00
	ld	a,-26 (ix)
	sub	a, -45 (ix)
	ld	-45 (ix),a
	ld	a,-25 (ix)
	sbc	a, -44 (ix)
	ld	-44 (ix),a
	ld	a,-45 (ix)
	add	a, #0x01
	ld	-26 (ix),a
	ld	a,-44 (ix)
	adc	a, #0x00
	ld	-25 (ix),a
	ld	a,-26 (ix)
	ld	-30 (ix),a
	ld	a,-25 (ix)
	ld	-29 (ix),a
	bit	7, -25 (ix)
	jr	Z,00277$
	ld	a,-45 (ix)
	add	a, #0x04
	ld	-30 (ix),a
	ld	a,-44 (ix)
	adc	a, #0x00
	ld	-29 (ix),a
00277$:
	ld	c,-30 (ix)
	ld	b,-29 (ix)
	sra	b
	rr	c
	sra	b
	rr	c
	ld	b,-33 (ix)
	ld	a,c
	sub	a, b
	ld	-12 (ix),a
;src/Renderer.c:860: lastCellWasWall = 0;
	ld	-40 (ix),#0x00
;src/Renderer.c:861: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
	ld	l,-24 (ix)
	ld	h,-23 (ix)
	add	hl, hl
	ld	c,-16 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-31 (ix)
	sub	a, l
	ld	-22 (ix),a
;src/Renderer.c:862: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
	ld	a,-43 (ix)
	sub	a, #0x80
	jr	NZ,00278$
	ld	c,#0x0F
	jr	00279$
00278$:
	ld	c,#0x0D
00279$:
	ld	-58 (ix),c
	jr	00224$
00218$:
;src/Renderer.c:866: xHeight = 0;
	ld	-22 (ix),#0x00
;src/Renderer.c:867: lastCellWasWall = 0;
	ld	-40 (ix),#0x00
;src/Renderer.c:868: lateralWallSlope=0;
	ld	-16 (ix),#0x00
;src/Renderer.c:869: lastWallId=0;
	ld	-43 (ix),#0x00
00224$:
;src/Renderer.c:872: newCell=0;
	ld	-20 (ix),#0x00
00229$:
;src/Renderer.c:877: if (lateralWallCounter > 0)
	ld	a,-12 (ix)
	or	a, a
	jr	Z,00235$
;src/Renderer.c:880: if (lateralWallSlope != 0)
	ld	a,-16 (ix)
	or	a, a
	jr	Z,00233$
;src/Renderer.c:882: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-16 (ix)
	sub	a, -18 (ix)
	jr	NZ,00231$
;src/Renderer.c:884: lateralWallSlopeCounter = 0;
	ld	-18 (ix),#0x00
;src/Renderer.c:885: xHeight -= 2;
	dec	-22 (ix)
	dec	-22 (ix)
00231$:
;src/Renderer.c:887: ++lateralWallSlopeCounter;
	inc	-18 (ix)
00233$:
;src/Renderer.c:889: --lateralWallCounter;
	dec	-12 (ix)
00235$:
;src/Renderer.c:893: if (!(x%2))
	ld	a,-28 (ix)
	or	a, a
	jr	NZ,00244$
;src/Renderer.c:896: if(xHeight > 0){
	ld	a,-22 (ix)
	or	a, a
	jr	Z,00244$
;src/Renderer.c:898: draw_column_to_buffer_untextured(x/2, xHeight, color);
	ld	b,-61 (ix)
	srl	b
	push	bc
	ld	h,-58 (ix)
	ld	l,-22 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_untextured
	pop	af
	inc	sp
	pop	bc
;src/Renderer.c:900: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-41 (ix)
	or	a, a
	jr	NZ,00244$
;src/Renderer.c:901: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-35 (ix)
	and	a, #0x0F
	jr	Z,00244$
;src/Renderer.c:902: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	a,-38 (ix)
	sub	a, -24 (ix)
	ld	l,a
	ld	a,-37 (ix)
	sbc	a, -23 (ix)
	ld	h,a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	ld	e,-38 (ix)
	ld	d,-37 (ix)
	push	de
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	d,l
	pop	bc
	push	de
	inc	sp
	ld	h,-35 (ix)
	ld	l,-56 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:904: else if(currentCellID&CELL_ITEM_MASK){
00244$:
;src/Renderer.c:910: ++xCellCount;
	inc	-33 (ix)
;src/Renderer.c:829: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	dec	-61 (ix)
;src/Renderer.c:466: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-8 (ix),l
	ld	-7 (ix),h
;src/Renderer.c:829: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	ld	a,-61 (ix)
	sub	a, #0x50
	jp	NC,00258$
;src/Renderer.c:917: lineStart = lineStart + (offsetDiff * 2) + 3;
	ld	a,-13 (ix)
	add	a, #0x03
	ld	-55 (ix),a
;src/Renderer.c:918: zHeight += zHeight;
	sla	-56 (ix)
;src/Renderer.c:919: offsetDiff = offsetDiff >> 1;
	srl	-50 (ix)
;src/Renderer.c:921: }while(z);
	ld	a,-62 (ix)
	or	a, a
	jp	NZ,00246$
00260$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:929: void draw_minimap_to_buffer(){
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
;src/Renderer.c:932: u8* ptr = MINIMAP_BUFFER;
	ld	bc,#0x1C40
;src/Renderer.c:937: y=(PLAYER_position.y-MINIMAP_HEIGHT_HALF);
	ld	a, (#(_PLAYER_position + 0x0001) + 0)
	add	a,#0xF8
	ld	e,a
;src/Renderer.c:939: for(j=0;j<MINIMAP_HEIGHT;++j){
	ld	d,#0x00
;src/Renderer.c:940: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
00135$:
	ld	a,e
	rlca
	and	a,#0x01
	ld	-7 (ix),a
	ld	a,e
	xor	a, #0x80
	sub	a, #0xA0
	ld	a,#0x00
	rla
	ld	-6 (ix),a
	ld	-10 (ix),#0x00
00120$:
;src/Renderer.c:941: x=(PLAYER_position.x-MINIMAP_WIDTH_HALF);
	ld	a, (#_PLAYER_position + 0)
	add	a,#0xF8
	ld	-1 (ix),a
;src/Renderer.c:942: for(i=0;i<MINIMAP_WIDTH;++i){
	ld	-11 (ix),#0x00
00118$:
;src/Renderer.c:945: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	iy,#0x0010
	add	iy, bc
;src/Renderer.c:943: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
	bit	7, -1 (ix)
	jr	NZ,00109$
	ld	a,-1 (ix)
	xor	a, #0x80
	sub	a, #0xA0
	jr	NC,00109$
	ld	a,-7 (ix)
	or	a, a
	jr	NZ,00109$
	bit	0,-6 (ix)
	jr	NZ,00110$
00109$:
;src/Renderer.c:944: *ptr=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	(bc),a
;src/Renderer.c:945: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	0 (iy), a
	jp	00111$
00110$:
;src/Renderer.c:947: else if((x==PLAYER_position.x)&&(y==PLAYER_position.y)){
	ld	a,-1 (ix)
	ld	-9 (ix),a
	ld	a,-1 (ix)
	rla
	sbc	a, a
	ld	-8 (ix),a
	ld	a, (#_PLAYER_position + 0)
	ld	-3 (ix),a
	ld	-2 (ix),#0x00
	ld	-5 (ix),e
	ld	a,e
	rla
	sbc	a, a
	ld	-4 (ix),a
	ld	a,-9 (ix)
	sub	a, -3 (ix)
	jr	NZ,00106$
	ld	a,-8 (ix)
	sub	a, -2 (ix)
	jr	NZ,00106$
	ld	a, (#(_PLAYER_position + 0x0001) + 0)
	ld	-3 (ix),a
	ld	-2 (ix),#0x00
	ld	a,-5 (ix)
	sub	a, -3 (ix)
	jr	NZ,00106$
	ld	a,-4 (ix)
	sub	a, -2 (ix)
	jr	NZ,00106$
;src/Renderer.c:948: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
	ld	a, (#(_g_colors + 0x0004) + 0)
	ld	(bc),a
;src/Renderer.c:949: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
	ld	a, (#(_g_colors + 0x0004) + 0)
	ld	0 (iy), a
	jr	00111$
00106$:
;src/Renderer.c:952: switch(*(u8*)(MAP_MEM+x+y*MAP_WIDTH)){
	ld	a,-9 (ix)
	add	a, #0x40
	ld	-3 (ix),a
	ld	a,-8 (ix)
	adc	a, #0x00
	ld	-2 (ix),a
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a,-3 (ix)
	add	a, l
	ld	l,a
	ld	a,-2 (ix)
	adc	a, h
	ld	h,a
	ld	l,(hl)
	ld	a,l
	or	a, a
	jr	Z,00101$
	ld	a,l
	sub	a, #0x80
	jr	Z,00102$
	jr	00103$
;src/Renderer.c:953: case CELLTYPE_FLOOR:{
00101$:
;src/Renderer.c:954: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
	ld	a, (#(_g_colors + 0x0003) + 0)
	ld	(bc),a
;src/Renderer.c:955: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
	ld	a, (#(_g_colors + 0x0003) + 0)
	ld	0 (iy), a
;src/Renderer.c:956: break;
	jr	00111$
;src/Renderer.c:958: case CELLTYPE_DOOR:{
00102$:
;src/Renderer.c:959: *ptr=g_colors[MINIMAP_EXIT_COLOR];
	ld	a, (#(_g_colors + 0x0008) + 0)
	ld	(bc),a
;src/Renderer.c:960: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
	ld	a, (#(_g_colors + 0x0008) + 0)
	ld	0 (iy), a
;src/Renderer.c:961: break;
	jr	00111$
;src/Renderer.c:963: default:{
00103$:
;src/Renderer.c:964: *ptr=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	(bc),a
;src/Renderer.c:965: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	0 (iy), a
;src/Renderer.c:968: }
00111$:
;src/Renderer.c:970: ++x;
	inc	-1 (ix)
;src/Renderer.c:971: ++ptr;
	inc	bc
;src/Renderer.c:942: for(i=0;i<MINIMAP_WIDTH;++i){
	inc	-11 (ix)
	ld	a,-11 (ix)
	sub	a, #0x10
	jp	C,00118$
;src/Renderer.c:940: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
	inc	-10 (ix)
	ld	a,-10 (ix)
	sub	a, #0x04
	jp	C,00120$
;src/Renderer.c:974: ++y;
	inc	e
;src/Renderer.c:939: for(j=0;j<MINIMAP_HEIGHT;++j){
	inc	d
	ld	a,d
	sub	a, #0x10
	jp	C,00135$
	ld	sp, ix
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
