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
;src/Renderer.c:208: void calculate_cells_in_view(){
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
;src/Renderer.c:210: u8 offset=0, n=0, j, i;
	ld	-6 (ix),#0x00
	ld	-7 (ix),#0x00
;src/Renderer.c:213: if(PLAYER_direction.y!=0){
	ld	a,(#_PLAYER_direction + 1)
	ld	-3 (ix), a
	or	a, a
	jr	Z,00102$
;src/Renderer.c:214: vert=1;
	ld	-14 (ix),#0x01
;src/Renderer.c:215: dy=PLAYER_direction.y;
	ld	c,-3 (ix)
	ld	-12 (ix),c
;src/Renderer.c:216: dx=-PLAYER_direction.y;
	xor	a, a
	sub	a, -3 (ix)
	ld	-11 (ix), a
;src/Renderer.c:218: x0 = PLAYER_position.x-(17*dx);
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
;src/Renderer.c:219: y0 = PLAYER_position.y+(6*dy);
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
;src/Renderer.c:222: vert=0;
	ld	-14 (ix),#0x00
;src/Renderer.c:223: dy=PLAYER_direction.x;
	ld	a,(#_PLAYER_direction + 0)
	ld	-3 (ix), a
	ld	-12 (ix),a
;src/Renderer.c:224: dx=PLAYER_direction.x;
	ld	a,-3 (ix)
	ld	-11 (ix),a
;src/Renderer.c:226: y0 = PLAYER_position.y-(17*dy);
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
;src/Renderer.c:227: x0 = PLAYER_position.x+(6*dx);
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
;src/Renderer.c:231: x=x0;
	ld	e,-10 (ix)
;src/Renderer.c:232: y=y0;
	ld	-13 (ix),c
;src/Renderer.c:234: for(j=0;j<6;++j){
	ld	a,-11 (ix)
	rlca
	and	a,#0x01
	ld	-3 (ix),a
	ld	a,-12 (ix)
	rlca
	and	a,#0x01
	ld	-5 (ix),a
	ld	-8 (ix),#0x00
;src/Renderer.c:236: for(i=offset;i<35-offset;++i){
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
;src/Renderer.c:239: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
	ld	hl,(_cells_in_view_array)
	ld	a,l
	add	a, -4 (ix)
	ld	-2 (ix),a
	ld	a,h
	adc	a, #0x00
	ld	-1 (ix),a
;src/Renderer.c:238: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
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
;src/Renderer.c:239: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
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
;src/Renderer.c:242: cells_in_view_array[n]=CELLTYPE_WALL1;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),#0x81
00106$:
;src/Renderer.c:246: if(vert){
	ld	a,-14 (ix)
	or	a, a
	jr	Z,00111$
;src/Renderer.c:247: x+=dx;
	ld	a,e
	add	a, -11 (ix)
	ld	e,a
	jr	00112$
00111$:
;src/Renderer.c:250: y+=dy;
	ld	a,-13 (ix)
	add	a, -12 (ix)
	ld	-13 (ix),a
00112$:
;src/Renderer.c:252: ++n;
	inc	-4 (ix)
;src/Renderer.c:236: for(i=offset;i<35-offset;++i){
	inc	-9 (ix)
	jp	00125$
00143$:
	ld	a,-4 (ix)
	ld	-7 (ix),a
;src/Renderer.c:254: offset=offsets_cells_in_view[j];
	ld	a,#<(_offsets_cells_in_view)
	add	a, -8 (ix)
	ld	l,a
	ld	a,#>(_offsets_cells_in_view)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
;src/Renderer.c:258: if(dx<0) x=x0-offset;
	ld	-6 (ix), a
	ld	-2 (ix),a
;src/Renderer.c:256: if(vert){
	ld	a,-14 (ix)
	or	a, a
	jr	Z,00121$
;src/Renderer.c:257: y-=dy;
	ld	a,-13 (ix)
	sub	a, -12 (ix)
	ld	-13 (ix),a
;src/Renderer.c:258: if(dx<0) x=x0-offset;
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00115$
	ld	a,-10 (ix)
	sub	a, -2 (ix)
	ld	e,a
	jr	00128$
00115$:
;src/Renderer.c:259: else x=x0+offset;
	ld	a,-10 (ix)
	add	a, -2 (ix)
	ld	e,a
	jr	00128$
00121$:
;src/Renderer.c:263: x-=dx;
	ld	a,e
	sub	a, -11 (ix)
	ld	e,a
;src/Renderer.c:264: if(dy<0) y=y0-offset;
	ld	a,-5 (ix)
	or	a, a
	jr	Z,00118$
	ld	a,c
	sub	a, -2 (ix)
	ld	-13 (ix),a
	jr	00128$
00118$:
;src/Renderer.c:265: else y=y0+offset;
	ld	a,c
	add	a, -2 (ix)
	ld	-13 (ix),a
00128$:
;src/Renderer.c:234: for(j=0;j<6;++j){
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
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x01	; 1
	.db #0x09	; 9
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
	.dw #0x38E0
_offsets_cells_in_view:
	.db #0x08	; 8
	.db #0x0C	; 12
	.db #0x0E	; 14
	.db #0x0F	; 15
	.db #0x10	; 16
;src/Renderer.c:273: void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
;	---------------------------------
; Function draw_column_to_buffer_untextured
; ---------------------------------
_draw_column_to_buffer_untextured::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;src/Renderer.c:274: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a, 4 (ix)
	srl	a
	add	a, #0x40
	ld	c,a
	ld	a,#0x00
	adc	a, #0x29
	ld	b,a
;src/Renderer.c:276: u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
	ld	de,#_g_colors+0
	ld	l,6 (ix)
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
	ld	-2 (ix),a
;src/Renderer.c:277: u8 pixMask = g_pixelMask[column&1];
	ld	de,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l,a
	ld	h,#0x00
	add	hl,de
	ld	e,(hl)
;src/Renderer.c:286: if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
	ld	a,#0x64
	sub	a, 5 (ix)
	jr	NC,00102$
	ld	5 (ix),#0x64
00102$:
;src/Renderer.c:288: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
	ld	l,5 (ix)
	srl	l
	ld	a,#0x32
	sub	a, l
;src/Renderer.c:291: pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
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
;src/Renderer.c:293: j=lineHeight;
	ld	d,5 (ix)
;src/Renderer.c:295: for(j;j;--j){
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
;src/Renderer.c:296: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, -1 (ix)
;src/Renderer.c:298: *pvmem = val|(w_color&pixMask);
	or	a, e
	ld	(bc),a
;src/Renderer.c:300: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:295: for(j;j;--j){
	dec	d
	jr	00105$
00107$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:304: void draw_column_to_buffer_object(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
;	---------------------------------
; Function draw_column_to_buffer_object
; ---------------------------------
_draw_column_to_buffer_object::
;src/Renderer.c:306: }
	ret
;src/Renderer.c:308: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
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
;src/Renderer.c:325: u16 texture_line=0;
	ld	-9 (ix),#0x00
	ld	-8 (ix),#0x00
;src/Renderer.c:327: if(texture_column>=4 && texture_column<28){
	ld	a,7 (ix)
	sub	a, #0x04
	jp	C,00112$
	ld	a,7 (ix)
	sub	a, #0x1C
	jp	NC,00112$
;src/Renderer.c:330: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(index-1)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
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
	ld	-11 (ix),l
	ld	-10 (ix),h
;src/Renderer.c:332: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a,4 (ix)
	srl	a
	add	a, #0x40
	ld	-6 (ix),a
	ld	a,#0x00
	adc	a, #0x29
	ld	-5 (ix),a
;src/Renderer.c:334: pixMask = g_pixelMask[column&1];
	ld	bc,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l, a
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-7 (ix),a
;src/Renderer.c:336: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
	ld	a,5 (ix)
	srl	a
	add	a, #0x32
	ld	-12 (ix),a
;src/Renderer.c:337: lineHeight = (lineHeight*3)/4;
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
;src/Renderer.c:338: enemy_top_height = ground_height - lineHeight;
	ld	a,-12 (ix)
	sub	a, b
	ld	c,a
;src/Renderer.c:340: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
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
	inc	sp
	inc	sp
	push	hl
;src/Renderer.c:341: j=lineHeight;
	ld	d,b
;src/Renderer.c:343: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
	ld	a,#0x64
	sub	a, b
	jr	NC,00102$
;src/Renderer.c:344: j=90;
	ld	d,#0x5A
00102$:
;src/Renderer.c:347: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
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
;src/Renderer.c:349: for(j;j;--j){
	ld	a,-7 (ix)
	cpl
	ld	e,a
00110$:
	ld	a,d
	or	a, a
	jr	Z,00112$
;src/Renderer.c:351: color= *(texture+(texture_line/256));
	ld	l,-8 (ix)
	ld	h,#0x00
	ld	a,-11 (ix)
	add	a, l
	ld	l,a
	ld	a,-10 (ix)
	adc	a, h
	ld	h,a
	ld	a,(hl)
;src/Renderer.c:353: if(color){
	ld	-4 (ix), a
	or	a, a
	jr	Z,00104$
;src/Renderer.c:354: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, e
	ld	l,a
;src/Renderer.c:356: color = (color&pixMask);
	ld	a,-4 (ix)
	and	a, -7 (ix)
;src/Renderer.c:358: *pvmem = val|color;
	or	a, l
	ld	(bc),a
00104$:
;src/Renderer.c:361: texture_line += texture_line_add;
	ld	a,-9 (ix)
	add	a, -14 (ix)
	ld	-9 (ix),a
	ld	a,-8 (ix)
	adc	a, -13 (ix)
	ld	-8 (ix),a
;src/Renderer.c:363: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:349: for(j;j;--j){
	dec	d
	jr	00110$
00112$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:369: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
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
;src/Renderer.c:370: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a,4 (ix)
	srl	a
	add	a, #0x40
	ld	-2 (ix),a
	ld	a,#0x00
	adc	a, #0x29
	ld	-1 (ix),a
;src/Renderer.c:373: u8 pixMask = g_pixelMask[column&1];
	ld	bc,#_g_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l, a
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-9 (ix),a
;src/Renderer.c:378: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
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
	ld	-8 (ix),l
	ld	-7 (ix),h
;src/Renderer.c:380: u8 j=lineHeight;
	ld	a,5 (ix)
;src/Renderer.c:386: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
	ld	-10 (ix), a
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
;src/Renderer.c:387: u16 wall_texture_line=0;
	ld	-12 (ix),#0x00
	ld	-11 (ix),#0x00
;src/Renderer.c:389: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
	ld	c,-10 (ix)
	srl	c
	ld	a,#0x32
	sub	a, c
	ld	-15 (ix),a
;src/Renderer.c:393: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
	ld	a,#0x64
	sub	a, -10 (ix)
	jr	NC,00102$
;src/Renderer.c:394: ceiling_height=0;
	ld	-15 (ix),#0x00
;src/Renderer.c:395: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
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
	ld	-12 (ix),l
	ld	-11 (ix),h
;src/Renderer.c:396: j=SCREEN_TEXTURE_HEIGHT;
	ld	-10 (ix),#0x64
00102$:
;src/Renderer.c:399: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
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
;src/Renderer.c:401: for(j;j;--j){
	ld	a,-9 (ix)
	cpl
	ld	-4 (ix),a
	ld	d,-10 (ix)
00107$:
	ld	a,d
	or	a, a
	jr	Z,00109$
;src/Renderer.c:403: w_color = *(texture+(wall_texture_line/256));
	ld	a, -11 (ix)
	ld	h, #0x00
	add	a, -8 (ix)
	ld	l,a
	ld	a,h
	adc	a, -7 (ix)
	ld	h,a
	ld	e,(hl)
;src/Renderer.c:405: if(w_color){
	ld	a,e
	or	a, a
	jr	Z,00104$
;src/Renderer.c:407: val =  ((*pvmem)&(~pixMask));
	ld	a,(bc)
	and	a, -4 (ix)
	ld	l,a
;src/Renderer.c:409: w_color = (w_color&pixMask);
	ld	a,e
	and	a, -9 (ix)
;src/Renderer.c:411: *pvmem = val|w_color;
	or	a, l
	ld	(bc),a
00104$:
;src/Renderer.c:415: wall_texture_line += wall_texture_line_add;
	ld	a,-12 (ix)
	add	a, -14 (ix)
	ld	-12 (ix),a
	ld	a,-11 (ix)
	adc	a, -13 (ix)
	ld	-11 (ix),a
;src/Renderer.c:417: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Renderer.c:401: for(j;j;--j){
	dec	d
	jr	00107$
00109$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:421: void render_draw_to_buffer(){//TODO Optimize
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
;src/Renderer.c:431: u8 zHeight = 5;
	ld	-43 (ix),#0x05
;src/Renderer.c:437: u8 offsetDiff = 16;
	ld	-54 (ix),#0x10
;src/Renderer.c:442: u8 lineStart = 0;
	ld	-49 (ix),#0x00
;src/Renderer.c:444: u8 lateralWallWidth=0;
	ld	-45 (ix),#0x00
;src/Renderer.c:456: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
	ld	hl, #_g_colors + 7
	ld	b,(hl)
	ld	hl,#0x07A8
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x2940
	push	hl
	call	_cpct_memset
;src/Renderer.c:457: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
	ld	hl, #_g_colors + 1
	ld	b,(hl)
	ld	hl,#0x0050
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x30E8
	push	hl
	call	_cpct_memset
;src/Renderer.c:458: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
	ld	hl, #_g_colors + 8
	ld	b,(hl)
	ld	hl,#0x07A8
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x3138
	push	hl
	call	_cpct_memset
;src/Renderer.c:460: calculate_cells_in_view();
	call	_calculate_cells_in_view
;src/Renderer.c:478: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-32 (ix),l
	ld	-31 (ix),h
;src/Renderer.c:462: if(g_texturedWalls){
	ld	a,(#_g_texturedWalls + 0)
	or	a, a
	jp	Z,00358$
;src/Renderer.c:464: do{
	ld	-56 (ix),#0x06
00175$:
;src/Renderer.c:466: --z;
	dec	-56 (ix)
;src/Renderer.c:470: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-43 (ix)
	srl	a
	ld	-26 (ix),a
	ld	a,-56 (ix)
	or	a, a
	jr	Z,00262$
	ld	c,-26 (ix)
	jr	00263$
00262$:
	ld	c,#0x00
00263$:
	ld	-24 (ix),c
;src/Renderer.c:471: lateralWallSlope=0;
	ld	-20 (ix),#0x00
;src/Renderer.c:472: lateralWallSlopeCounter=0;
	ld	-7 (ix),#0x00
;src/Renderer.c:473: xHeight=0;
	ld	-41 (ix),#0x00
;src/Renderer.c:475: lateralWallCounter = 0;
	ld	-23 (ix),#0x00
;src/Renderer.c:477: newCell=1;
	ld	-10 (ix),#0x01
;src/Renderer.c:478: currentCellID = cells_in_view_array[lineStart + 1];
	ld	a,-49 (ix)
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
	ld	c,-2 (ix)
	ld	b,-1 (ix)
	inc	bc
	ld	l,-32 (ix)
	ld	h,-31 (ix)
	add	hl,bc
	ld	a,(hl)
	ld	-30 (ix),a
;src/Renderer.c:480: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
	ld	a,-32 (ix)
	add	a, -49 (ix)
	ld	l,a
	ld	a,-31 (ix)
	adc	a, #0x00
	ld	h,a
	ld	c,(hl)
;src/Renderer.c:481: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00102$
;src/Renderer.c:482: lastWallId=lastCellWasWall;
	ld	-27 (ix),c
;src/Renderer.c:483: lastCellWasWall=1;
	ld	-25 (ix),#0x01
	jr	00296$
00102$:
;src/Renderer.c:486: lastCellWasWall=0;
	ld	-25 (ix),#0x00
;src/Renderer.c:487: lastWallId=CELLTYPE_FLOOR;
	ld	-27 (ix),#0x00
;src/Renderer.c:490: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
00296$:
	ld	-46 (ix),#0x00
	ld	-42 (ix),#0x00
00252$:
;src/Renderer.c:492: if (xCellCount == zHeight)
	ld	a,-43 (ix)
	sub	a, -24 (ix)
	jr	NZ,00105$
;src/Renderer.c:494: ++xCell;
	inc	-46 (ix)
;src/Renderer.c:495: xCellCount = 0;
	ld	-24 (ix),#0x00
;src/Renderer.c:496: newCell=1;
	ld	-10 (ix),#0x01
;src/Renderer.c:497: currentCellID=cells_in_view_array[xCell + lineStart + 1];
	ld	a,-46 (ix)
	ld	-19 (ix),a
	ld	-18 (ix),#0x00
	ld	a,-2 (ix)
	add	a, -19 (ix)
	ld	-19 (ix),a
	ld	a,-1 (ix)
	adc	a, -18 (ix)
	ld	-18 (ix),a
	inc	-19 (ix)
	jr	NZ,00608$
	inc	-18 (ix)
00608$:
	ld	a,-32 (ix)
	add	a, -19 (ix)
	ld	-19 (ix),a
	ld	a,-31 (ix)
	adc	a, -18 (ix)
	ld	-18 (ix),a
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	ld	a,(hl)
	ld	-30 (ix),a
00105$:
;src/Renderer.c:499: if(!(x%2)){
	ld	a,-42 (ix)
	and	a, #0x01
	ld	-19 (ix),a
;src/Renderer.c:502: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-30 (ix)
	and	a, #0x80
	ld	-13 (ix),a
;src/Renderer.c:522: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-24 (ix)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
	ld	a,-43 (ix)
	ld	-6 (ix),a
;src/Renderer.c:499: if(!(x%2)){
	ld	a,-19 (ix)
	or	a, a
	jp	NZ,00118$
;src/Renderer.c:500: if ((lateralWallCounter == 0)||newCell)
	ld	a,-23 (ix)
	or	a, a
	jr	Z,00114$
	ld	a,-10 (ix)
	or	a, a
	jp	Z,00118$
00114$:
;src/Renderer.c:502: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-13 (ix)
	or	a, a
	jr	Z,00112$
;src/Renderer.c:504: lateralWallCounter = 0;//(zHeight - xCellCount);
	ld	-23 (ix),#0x00
;src/Renderer.c:505: lateralWallSlope = 0;
	ld	-20 (ix),#0x00
;src/Renderer.c:506: xHeight = zHeight;
	ld	a,-43 (ix)
	ld	-41 (ix),a
;src/Renderer.c:507: color = currentCellID&0b01111111;
	ld	a,-30 (ix)
	and	a, #0x7F
	ld	-5 (ix),a
;src/Renderer.c:508: lastCellWasWall = 1;
	ld	-25 (ix),#0x01
;src/Renderer.c:509: lastWallId=currentCellID;
	ld	a,-30 (ix)
	ld	-27 (ix),a
	jr	00113$
00112$:
;src/Renderer.c:512: if(lateralWallCounter==0){//Lateral wall not finished
	ld	a,-23 (ix)
	or	a, a
	jr	NZ,00113$
;src/Renderer.c:513: if (lastCellWasWall)
	ld	a,-25 (ix)
	or	a, a
	jr	Z,00107$
;src/Renderer.c:516: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-54 (ix)
	sub	a, -46 (ix)
	add	a, a
	inc	a
;src/Renderer.c:517: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-20 (ix), a
	srl	a
	ld	-7 (ix),a
;src/Renderer.c:518: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-43 (ix)
	ld	h,-20 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00609$:
	add	hl,hl
	jr	NC,00610$
	add	hl,de
00610$:
	djnz	00609$
;src/Renderer.c:519: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
	ld	a,l
	and	a, #0xFC
	set	0, a
	srl	a
	srl	a
	sub	a, -24 (ix)
;src/Renderer.c:520: lateralWallWidth=lateralWallCounter;
	ld	-23 (ix), a
	ld	-45 (ix),a
;src/Renderer.c:521: lastCellWasWall = 0;
	ld	-25 (ix),#0x00
;src/Renderer.c:522: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	add	hl, hl
	ld	c,-20 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-6 (ix)
	sub	a, l
	ld	-41 (ix),a
;src/Renderer.c:523: color = lastWallId&0b01111111;
	ld	a,-27 (ix)
	and	a, #0x7F
	ld	-5 (ix),a
	jr	00113$
00107$:
;src/Renderer.c:527: xHeight = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:528: lastCellWasWall = 0;
	ld	-25 (ix),#0x00
;src/Renderer.c:529: lateralWallSlope=0;
	ld	-20 (ix),#0x00
;src/Renderer.c:530: lastWallId=0;
	ld	-27 (ix),#0x00
00113$:
;src/Renderer.c:534: newCell=0;
	ld	-10 (ix),#0x00
00118$:
;src/Renderer.c:537: if (lateralWallCounter > 0)
	ld	a,-23 (ix)
	or	a, a
	jr	Z,00124$
;src/Renderer.c:540: if (lateralWallSlope != 0)
	ld	a,-20 (ix)
	or	a, a
	jr	Z,00122$
;src/Renderer.c:542: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-7 (ix)
	sub	a, -20 (ix)
	jr	NZ,00120$
;src/Renderer.c:544: lateralWallSlopeCounter = 0;
	ld	-7 (ix),#0x00
;src/Renderer.c:545: xHeight -= 2;
	dec	-41 (ix)
	dec	-41 (ix)
00120$:
;src/Renderer.c:547: ++lateralWallSlopeCounter;
	inc	-7 (ix)
00122$:
;src/Renderer.c:550: --lateralWallCounter;
	dec	-23 (ix)
00124$:
;src/Renderer.c:561: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-43 (ix)
	ld	-4 (ix),a
	ld	-3 (ix),#0x00
;src/Renderer.c:553: if (!(x%2))
	ld	a,-19 (ix)
	or	a, a
	jp	NZ,00136$
;src/Renderer.c:563: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	ld	b,-42 (ix)
	srl	b
;src/Renderer.c:561: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	ld	e,-4 (ix)
	ld	d,-3 (ix)
	push	de
	push	hl
	call	__divsint
	pop	af
	pop	af
	pop	bc
	ld	c,l
;src/Renderer.c:555: if(xHeight > 0){
	ld	a,-41 (ix)
	or	a, a
	jr	Z,00129$
;src/Renderer.c:556: if (lateralWallCounter > 0)
	ld	a,-23 (ix)
	or	a, a
	jr	Z,00126$
;src/Renderer.c:558: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
	ld	e,-45 (ix)
	ld	d,#0x00
	ld	l,-23 (ix)
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
;src/Renderer.c:561: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	d,c
00127$:
;src/Renderer.c:563: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	push	bc
	push	de
	inc	sp
	ld	h,-5 (ix)
	ld	l,-41 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer
	pop	af
	pop	af
	pop	bc
00129$:
;src/Renderer.c:565: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-13 (ix)
	or	a, a
	jr	NZ,00136$
;src/Renderer.c:566: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-30 (ix)
	and	a, #0x0F
	jr	Z,00136$
;src/Renderer.c:567: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	a,c
	push	af
	inc	sp
	ld	h,-30 (ix)
	ld	l,-43 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:569: else if(currentCellID&CELL_ITEM_MASK){
00136$:
;src/Renderer.c:575: ++xCellCount;
	inc	-24 (ix)
;src/Renderer.c:490: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	inc	-42 (ix)
;src/Renderer.c:478: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-32 (ix),l
	ld	-31 (ix),h
;src/Renderer.c:490: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	ld	a,-42 (ix)
	sub	a, #0x50
	jp	C,00252$
;src/Renderer.c:582: xCellCount = (z) ? (zHeight >> 1) : 0 ;
	ld	a,-56 (ix)
	or	a, a
	jr	Z,00264$
	ld	c,-26 (ix)
	jr	00265$
00264$:
	ld	c,#0x00
00265$:
	ld	-9 (ix),c
;src/Renderer.c:583: lateralWallSlope=0;
	ld	-13 (ix),#0x00
;src/Renderer.c:584: lateralWallSlopeCounter=0;
	ld	-19 (ix),#0x00
;src/Renderer.c:585: xHeight=0;
	ld	-25 (ix),#0x00
;src/Renderer.c:587: lateralWallCounter = 0;
	ld	-27 (ix),#0x00
;src/Renderer.c:588: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	a,-54 (ix)
	add	a, a
	ld	c,a
	ld	a,-49 (ix)
	add	a, c
	ld	-30 (ix), a
	ld	c, a
	inc	c
	inc	c
;src/Renderer.c:590: newCell=1;
	ld	-2 (ix),#0x01
;src/Renderer.c:591: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	-34 (ix),c
	ld	-33 (ix),#0x00
	ld	e,-34 (ix)
	ld	d,-33 (ix)
	dec	de
	ld	l,-32 (ix)
	ld	h,-31 (ix)
	add	hl,de
	ld	a,(hl)
	ld	-10 (ix),a
;src/Renderer.c:593: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
	ld	l,-32 (ix)
	ld	h,-31 (ix)
	ld	b,#0x00
	add	hl, bc
	ld	c,(hl)
;src/Renderer.c:594: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00139$
;src/Renderer.c:595: lastWallId=lastCellWasWall;
	ld	-23 (ix),c
;src/Renderer.c:596: lastCellWasWall=1;
	ld	-41 (ix),#0x01
	jr	00315$
00139$:
;src/Renderer.c:599: lastCellWasWall=0;
	ld	-41 (ix),#0x00
;src/Renderer.c:600: lastWallId=CELLTYPE_FLOOR;
	ld	-23 (ix),#0x00
;src/Renderer.c:603: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
00315$:
	ld	-46 (ix),#0x00
	ld	-42 (ix),#0x9F
00254$:
;src/Renderer.c:606: if (xCellCount == zHeight)
	ld	a,-43 (ix)
	sub	a, -9 (ix)
	jr	NZ,00142$
;src/Renderer.c:608: ++xCell;
	inc	-46 (ix)
;src/Renderer.c:609: xCellCount = 0;
	ld	-9 (ix),#0x00
;src/Renderer.c:610: newCell=1;
	ld	-2 (ix),#0x01
;src/Renderer.c:611: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
	ld	a,-46 (ix)
	ld	-17 (ix),a
	ld	-16 (ix),#0x00
	ld	a,-34 (ix)
	sub	a, -17 (ix)
	ld	-17 (ix),a
	ld	a,-33 (ix)
	sbc	a, -16 (ix)
	ld	-16 (ix),a
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	dec	hl
	ld	-17 (ix),l
	ld	-16 (ix),h
	ld	a,-32 (ix)
	add	a, -17 (ix)
	ld	-17 (ix),a
	ld	a,-31 (ix)
	adc	a, -16 (ix)
	ld	-16 (ix),a
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	ld	a,(hl)
	ld	-10 (ix),a
00142$:
;src/Renderer.c:613: if(!(x%2)){
	ld	a,-42 (ix)
	and	a, #0x01
	ld	-17 (ix),a
;src/Renderer.c:502: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-10 (ix)
	and	a, #0x80
	ld	-7 (ix),a
;src/Renderer.c:522: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-9 (ix)
	ld	-38 (ix),a
	ld	-37 (ix),#0x00
;src/Renderer.c:613: if(!(x%2)){
	ld	a,-17 (ix)
	or	a, a
	jp	NZ,00155$
;src/Renderer.c:614: if (lateralWallCounter == 0 || newCell)
	ld	a,-27 (ix)
	or	a, a
	jr	Z,00151$
	ld	a,-2 (ix)
	or	a, a
	jp	Z,00155$
00151$:
;src/Renderer.c:616: if ( currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-7 (ix)
	or	a, a
	jr	Z,00149$
;src/Renderer.c:618: lateralWallCounter = 0;
	ld	-27 (ix),#0x00
;src/Renderer.c:619: lateralWallSlope = 0;
	ld	-13 (ix),#0x00
;src/Renderer.c:620: xHeight = zHeight;
	ld	a,-43 (ix)
	ld	-25 (ix),a
;src/Renderer.c:621: color = currentCellID&0b01111111;
	ld	a,-10 (ix)
	and	a, #0x7F
	ld	-5 (ix),a
;src/Renderer.c:622: lastCellWasWall = 1;
	ld	-41 (ix),#0x01
;src/Renderer.c:623: lastWallId=currentCellID;
	ld	a,-10 (ix)
	ld	-23 (ix),a
	jp	00150$
00149$:
;src/Renderer.c:625: else if(lateralWallCounter==0){
	ld	a,-27 (ix)
	or	a, a
	jp	NZ,00150$
;src/Renderer.c:626: if (lastCellWasWall)
	ld	a,-41 (ix)
	or	a, a
	jr	Z,00144$
;src/Renderer.c:629: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-54 (ix)
	sub	a, -46 (ix)
	add	a, a
	inc	a
;src/Renderer.c:630: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-13 (ix), a
	srl	a
	ld	-19 (ix),a
;src/Renderer.c:631: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-43 (ix)
	ld	h,-13 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00617$:
	add	hl,hl
	jr	NC,00618$
	add	hl,de
00618$:
	djnz	00617$
;src/Renderer.c:632: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
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
	ld	c,-9 (ix)
	ld	a,l
	sub	a, c
;src/Renderer.c:633: lateralWallWidth=lateralWallCounter;
	ld	-27 (ix), a
	ld	-45 (ix),a
;src/Renderer.c:634: lastCellWasWall = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:635: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
	ld	l,-38 (ix)
	ld	h,-37 (ix)
	add	hl, hl
	ld	c,-13 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-6 (ix)
	sub	a, l
	ld	-25 (ix),a
;src/Renderer.c:636: color = lastWallId&0b01111111;
	ld	a,-23 (ix)
	and	a, #0x7F
	ld	-5 (ix),a
	jr	00150$
00144$:
;src/Renderer.c:640: xHeight = 0;
	ld	-25 (ix),#0x00
;src/Renderer.c:641: lastCellWasWall = 0;
	ld	-41 (ix),#0x00
;src/Renderer.c:642: lateralWallSlope=0;
	ld	-13 (ix),#0x00
;src/Renderer.c:643: lastWallId=0;
	ld	-23 (ix),#0x00
00150$:
;src/Renderer.c:646: newCell=0;
	ld	-2 (ix),#0x00
00155$:
;src/Renderer.c:651: if (lateralWallCounter > 0)
	ld	a,-27 (ix)
	or	a, a
	jr	Z,00161$
;src/Renderer.c:654: if (lateralWallSlope != 0)
	ld	a,-13 (ix)
	or	a, a
	jr	Z,00159$
;src/Renderer.c:656: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-13 (ix)
	sub	a, -19 (ix)
	jr	NZ,00157$
;src/Renderer.c:658: lateralWallSlopeCounter = 0;
	ld	-19 (ix),#0x00
;src/Renderer.c:659: xHeight -= 2;
	dec	-25 (ix)
	dec	-25 (ix)
00157$:
;src/Renderer.c:661: ++lateralWallSlopeCounter;
	inc	-19 (ix)
00159$:
;src/Renderer.c:663: --lateralWallCounter;
	dec	-27 (ix)
00161$:
;src/Renderer.c:667: if (!(x%2))
	ld	a,-17 (ix)
	or	a, a
	jp	NZ,00173$
;src/Renderer.c:680: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	ld	a,-42 (ix)
	srl	a
	ld	-17 (ix),a
;src/Renderer.c:677: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-4 (ix)
	sub	a, -38 (ix)
	ld	-38 (ix),a
	ld	a,-3 (ix)
	sbc	a, -37 (ix)
	ld	-37 (ix),a
	ld	a,#0x05+1
	jr	00622$
00621$:
	sla	-38 (ix)
	rl	-37 (ix)
00622$:
	dec	a
	jr	NZ,00621$
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,-38 (ix)
	ld	h,-37 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-37 (ix),h
	ld	-38 (ix), l
	ld	-38 (ix), l
;src/Renderer.c:670: if(xHeight > 0){
	ld	a,-25 (ix)
	or	a, a
	jr	Z,00166$
;src/Renderer.c:672: if (lateralWallCounter > 0)
	ld	a,-27 (ix)
	or	a, a
	jr	Z,00163$
;src/Renderer.c:674: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
	ld	a,-27 (ix)
	ld	-29 (ix),a
	ld	-28 (ix),#0x00
	ld	a,#0x05+1
	jr	00624$
00623$:
	sla	-29 (ix)
	rl	-28 (ix)
00624$:
	dec	a
	jr	NZ,00623$
	ld	a,-45 (ix)
	ld	-15 (ix),a
	ld	-14 (ix),#0x00
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	push	hl
	ld	l,-29 (ix)
	ld	h,-28 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	b,l
	jr	00164$
00163$:
;src/Renderer.c:677: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	b,-38 (ix)
00164$:
;src/Renderer.c:680: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	push	bc
	inc	sp
	ld	h,-5 (ix)
	ld	l,-25 (ix)
	push	hl
	ld	a,-17 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer
	pop	af
	pop	af
00166$:
;src/Renderer.c:683: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-7 (ix)
	or	a, a
	jr	NZ,00173$
;src/Renderer.c:684: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-10 (ix)
	and	a, #0x0F
	jr	Z,00173$
;src/Renderer.c:685: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	h,-38 (ix)
	ld	l,-10 (ix)
	push	hl
	ld	h,-43 (ix)
	ld	l,-17 (ix)
	push	hl
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:687: else if(currentCellID&CELL_ITEM_MASK){
00173$:
;src/Renderer.c:692: ++xCellCount;
	inc	-9 (ix)
;src/Renderer.c:603: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	dec	-42 (ix)
;src/Renderer.c:478: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-32 (ix),l
	ld	-31 (ix),h
;src/Renderer.c:603: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	ld	a,-42 (ix)
	sub	a, #0x50
	jp	NC,00254$
;src/Renderer.c:699: lineStart = lineStart + (offsetDiff * 2) + 3;
	ld	a,-30 (ix)
	add	a, #0x03
	ld	-49 (ix),a
;src/Renderer.c:700: zHeight += zHeight;
	sla	-43 (ix)
;src/Renderer.c:701: offsetDiff = offsetDiff >> 1;
	srl	-54 (ix)
;src/Renderer.c:703: }while(z);
	ld	a,-56 (ix)
	or	a, a
	jp	NZ,00175$
	jp	00260$
;src/Renderer.c:708: do{
00358$:
	ld	-56 (ix),#0x06
00246$:
;src/Renderer.c:710: --z;
	dec	-56 (ix)
;src/Renderer.c:470: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-43 (ix)
	srl	a
	ld	-15 (ix),a
;src/Renderer.c:714: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-56 (ix)
	or	a, a
	jr	Z,00267$
	ld	c,-15 (ix)
	jr	00268$
00267$:
	ld	c,#0x00
00268$:
	ld	-55 (ix),c
;src/Renderer.c:715: lateralWallSlope=0;
	ld	-44 (ix),#0x00
;src/Renderer.c:716: lateralWallSlopeCounter=0;
	ld	-58 (ix),#0x00
;src/Renderer.c:717: xHeight=0;
	ld	-47 (ix),#0x00
;src/Renderer.c:719: lateralWallCounter = 0;
	ld	-29 (ix),#0x00
;src/Renderer.c:721: newCell=1;
	ld	-52 (ix),#0x01
;src/Renderer.c:478: currentCellID = cells_in_view_array[lineStart + 1];
	ld	a,-49 (ix)
	ld	-38 (ix),a
	ld	-37 (ix),#0x00
;src/Renderer.c:722: currentCellID = cells_in_view_array[lineStart + 1];
	ld	c,-38 (ix)
	ld	b,-37 (ix)
	inc	bc
	ld	l,-32 (ix)
	ld	h,-31 (ix)
	add	hl,bc
	ld	a,(hl)
	ld	-53 (ix),a
;src/Renderer.c:724: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
	ld	a,-32 (ix)
	add	a, -49 (ix)
	ld	l,a
	ld	a,-31 (ix)
	adc	a, #0x00
	ld	h,a
	ld	c,(hl)
;src/Renderer.c:725: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, c
	jr	Z,00179$
;src/Renderer.c:726: lastWallId=lastCellWasWall;
	ld	-57 (ix),c
;src/Renderer.c:727: lastCellWasWall=1;
	ld	-17 (ix),#0x01
	jr	00336$
00179$:
;src/Renderer.c:730: lastCellWasWall=0;
	ld	-17 (ix),#0x00
;src/Renderer.c:731: lastWallId=CELLTYPE_FLOOR;
	ld	-57 (ix),#0x00
;src/Renderer.c:734: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
00336$:
	ld	-46 (ix),#0x00
	ld	-42 (ix),#0x00
00256$:
;src/Renderer.c:736: if (xCellCount == zHeight)
	ld	a,-55 (ix)
	sub	a, -43 (ix)
	jr	NZ,00182$
;src/Renderer.c:738: ++xCell;
	inc	-46 (ix)
;src/Renderer.c:739: xCellCount = 0;
	ld	-55 (ix),#0x00
;src/Renderer.c:740: newCell=1;
	ld	-52 (ix),#0x01
;src/Renderer.c:741: currentCellID=cells_in_view_array[xCell + lineStart + 1];
	ld	a,-46 (ix)
	ld	-34 (ix),a
	ld	-33 (ix),#0x00
	ld	a,-38 (ix)
	add	a, -34 (ix)
	ld	-34 (ix),a
	ld	a,-37 (ix)
	adc	a, -33 (ix)
	ld	-33 (ix),a
	inc	-34 (ix)
	jr	NZ,00629$
	inc	-33 (ix)
00629$:
	ld	a,-34 (ix)
	add	a, -32 (ix)
	ld	-34 (ix),a
	ld	a,-33 (ix)
	adc	a, -31 (ix)
	ld	-33 (ix),a
	ld	l,-34 (ix)
	ld	h,-33 (ix)
	ld	a,(hl)
	ld	-53 (ix),a
00182$:
;src/Renderer.c:743: if(!(x%2)){
	ld	a,-42 (ix)
	and	a, #0x01
	ld	-34 (ix),a
;src/Renderer.c:502: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-53 (ix)
	and	a, #0x80
	ld	-4 (ix),a
;src/Renderer.c:522: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-55 (ix)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
	ld	a,-43 (ix)
	ld	-5 (ix),a
;src/Renderer.c:743: if(!(x%2)){
	ld	a,-34 (ix)
	or	a, a
	jp	NZ,00195$
;src/Renderer.c:744: if ((lateralWallCounter == 0)||newCell)
	ld	a,-29 (ix)
	or	a, a
	jr	Z,00191$
	ld	a,-52 (ix)
	or	a, a
	jp	Z,00195$
00191$:
;src/Renderer.c:746: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-4 (ix)
	or	a, a
	jr	Z,00189$
;src/Renderer.c:748: lateralWallCounter = 0;//(zHeight - xCellCount);
	ld	-29 (ix),#0x00
;src/Renderer.c:749: lateralWallSlope = 0;
	ld	-44 (ix),#0x00
;src/Renderer.c:750: xHeight = zHeight;
	ld	a,-43 (ix)
	ld	-47 (ix),a
;src/Renderer.c:751: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
	ld	a,-53 (ix)
	sub	a, #0x80
	jr	NZ,00269$
	ld	c,#0x0C
	jr	00270$
00269$:
	ld	c,#0x0E
00270$:
	ld	-50 (ix),c
;src/Renderer.c:752: lastCellWasWall = 1;
	ld	-17 (ix),#0x01
;src/Renderer.c:753: lastWallId=currentCellID;
	ld	a,-53 (ix)
	ld	-57 (ix),a
	jp	00190$
00189$:
;src/Renderer.c:756: if(lateralWallCounter==0){//Lateral wall not finished
	ld	a,-29 (ix)
	or	a, a
	jp	NZ,00190$
;src/Renderer.c:757: if (lastCellWasWall)
	ld	a,-17 (ix)
	or	a, a
	jp	Z,00184$
;src/Renderer.c:760: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-54 (ix)
	sub	a, -46 (ix)
	add	a, a
	inc	a
;src/Renderer.c:761: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-44 (ix), a
	srl	a
	ld	-58 (ix),a
;src/Renderer.c:762: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-43 (ix)
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
	ld	-6 (ix), l
	ld	a, l
;src/Renderer.c:763: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
	ld	-48 (ix), a
	and	a, #0xFC
	ld	-6 (ix), a
	set	0, a
	ld	-6 (ix), a
	srl	a
	srl	a
	sub	a, -55 (ix)
	ld	-29 (ix),a
;src/Renderer.c:765: lastCellWasWall = 0;
	ld	-17 (ix),#0x00
;src/Renderer.c:766: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-9 (ix)
	ld	-19 (ix),a
	ld	a,-8 (ix)
	ld	-18 (ix),a
	sla	-19 (ix)
	rl	-18 (ix)
	ld	a,-44 (ix)
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-18 (ix),h
	ld	-19 (ix), l
	ld	-6 (ix), l
	ld	a,-5 (ix)
	sub	a, -6 (ix)
	ld	-47 (ix),a
;src/Renderer.c:767: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
	ld	a,-57 (ix)
	sub	a, #0x80
	jr	NZ,00271$
	ld	c,#0x0F
	jr	00272$
00271$:
	ld	c,#0x0D
00272$:
	ld	-50 (ix),c
	jr	00190$
00184$:
;src/Renderer.c:771: xHeight = 0;
	ld	-47 (ix),#0x00
;src/Renderer.c:772: lastCellWasWall = 0;
	ld	-17 (ix),#0x00
;src/Renderer.c:773: lateralWallSlope=0;
	ld	-44 (ix),#0x00
;src/Renderer.c:774: lastWallId=0;
	ld	-57 (ix),#0x00
00190$:
;src/Renderer.c:778: newCell=0;
	ld	-52 (ix),#0x00
00195$:
;src/Renderer.c:781: if (lateralWallCounter > 0)
	ld	a,-29 (ix)
	or	a, a
	jr	Z,00201$
;src/Renderer.c:784: if (lateralWallSlope != 0)
	ld	a,-44 (ix)
	or	a, a
	jr	Z,00199$
;src/Renderer.c:786: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-44 (ix)
	sub	a, -58 (ix)
	jr	NZ,00197$
;src/Renderer.c:788: lateralWallSlopeCounter = 0;
	ld	-58 (ix),#0x00
;src/Renderer.c:789: xHeight -= 2;
	dec	-47 (ix)
	dec	-47 (ix)
00197$:
;src/Renderer.c:791: ++lateralWallSlopeCounter;
	inc	-58 (ix)
00199$:
;src/Renderer.c:794: --lateralWallCounter;
	dec	-29 (ix)
00201$:
;src/Renderer.c:561: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-43 (ix)
	ld	-19 (ix),a
	ld	-18 (ix),#0x00
;src/Renderer.c:797: if (!(x%2))
	ld	a,-34 (ix)
	or	a, a
	jr	NZ,00210$
;src/Renderer.c:800: draw_column_to_buffer_untextured(x/2, xHeight, color);
	ld	a,-42 (ix)
	srl	a
	ld	-34 (ix),a
;src/Renderer.c:799: if(xHeight > 0){
	ld	a,-47 (ix)
	or	a, a
	jr	Z,00203$
;src/Renderer.c:800: draw_column_to_buffer_untextured(x/2, xHeight, color);
	ld	h,-50 (ix)
	ld	l,-47 (ix)
	push	hl
	ld	a,-34 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer_untextured
	pop	af
	inc	sp
00203$:
;src/Renderer.c:803: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-4 (ix)
	or	a, a
	jr	NZ,00210$
;src/Renderer.c:804: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-53 (ix)
	and	a, #0x0F
	jr	Z,00210$
;src/Renderer.c:805: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	a,-9 (ix)
	ld	-4 (ix),a
	ld	a,-8 (ix)
	ld	-3 (ix),a
	ld	a,#0x05+1
	jr	00642$
00641$:
	sla	-4 (ix)
	rl	-3 (ix)
00642$:
	dec	a
	jr	NZ,00641$
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-3 (ix),h
	ld	-4 (ix), l
	ld	b, l
	push	bc
	inc	sp
	ld	h,-53 (ix)
	ld	l,-43 (ix)
	push	hl
	ld	a,-34 (ix)
	push	af
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:807: else if(currentCellID&CELL_ITEM_MASK){
00210$:
;src/Renderer.c:813: ++xCellCount;
	inc	-55 (ix)
;src/Renderer.c:734: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	inc	-42 (ix)
;src/Renderer.c:478: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-32 (ix),l
	ld	-31 (ix),h
;src/Renderer.c:734: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	ld	a,-42 (ix)
	sub	a, #0x50
	jp	C,00256$
;src/Renderer.c:820: xCellCount = (z) ? (zHeight >> 1) : 0 ;
	ld	a,-56 (ix)
	or	a, a
	jr	Z,00273$
	ld	a,-15 (ix)
	ld	-15 (ix),a
	jr	00274$
00273$:
	ld	-15 (ix),#0x00
00274$:
	ld	a,-15 (ix)
	ld	-15 (ix),a
;src/Renderer.c:821: lateralWallSlope=0;
	ld	-29 (ix),#0x00
;src/Renderer.c:822: lateralWallSlopeCounter=0;
	ld	-38 (ix),#0x00
;src/Renderer.c:823: xHeight=0;
	ld	-17 (ix),#0x00
;src/Renderer.c:825: lateralWallCounter = 0;
	ld	-34 (ix),#0x00
;src/Renderer.c:588: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	a,-54 (ix)
	add	a, a
	ld	-4 (ix),a
	ld	a,-49 (ix)
	add	a, -4 (ix)
;src/Renderer.c:826: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	-4 (ix), a
	add	a, #0x02
	ld	-51 (ix),a
;src/Renderer.c:828: newCell=1;
	ld	-6 (ix),#0x01
;src/Renderer.c:591: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	a,-51 (ix)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
;src/Renderer.c:829: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	a,-9 (ix)
	add	a,#0xFF
	ld	-2 (ix),a
	ld	a,-8 (ix)
	adc	a,#0xFF
	ld	-1 (ix),a
	ld	a,-32 (ix)
	add	a, -2 (ix)
	ld	-2 (ix),a
	ld	a,-31 (ix)
	adc	a, -1 (ix)
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-13 (ix),a
;src/Renderer.c:831: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
	ld	a,-32 (ix)
	add	a, -51 (ix)
	ld	-2 (ix),a
	ld	a,-31 (ix)
	adc	a, #0x00
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-25 (ix),a
;src/Renderer.c:832: if(lastCellWasWall&CELL_WALL_MASK){
	bit	7, -25 (ix)
	jr	Z,00213$
;src/Renderer.c:833: lastWallId=lastCellWasWall;
;src/Renderer.c:834: lastCellWasWall=1;
	ld	-27 (ix),#0x01
	jr	00356$
00213$:
;src/Renderer.c:837: lastCellWasWall=0;
	ld	-27 (ix),#0x00
;src/Renderer.c:838: lastWallId=CELLTYPE_FLOOR;
	ld	-25 (ix),#0x00
;src/Renderer.c:841: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
00356$:
	ld	-46 (ix),#0x00
	ld	-42 (ix),#0x9F
00258$:
;src/Renderer.c:844: if (xCellCount == zHeight)
	ld	a,-43 (ix)
	sub	a, -15 (ix)
	jr	NZ,00216$
;src/Renderer.c:846: ++xCell;
	inc	-46 (ix)
;src/Renderer.c:847: xCellCount = 0;
	ld	-15 (ix),#0x00
;src/Renderer.c:848: newCell=1;
	ld	-6 (ix),#0x01
;src/Renderer.c:849: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
	ld	a,-46 (ix)
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
	ld	a,-9 (ix)
	sub	a, -2 (ix)
	ld	-2 (ix),a
	ld	a,-8 (ix)
	sbc	a, -1 (ix)
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	dec	hl
	ld	-2 (ix),l
	ld	-1 (ix),h
	ld	a,-32 (ix)
	add	a, -2 (ix)
	ld	-2 (ix),a
	ld	a,-31 (ix)
	adc	a, -1 (ix)
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-13 (ix),a
00216$:
;src/Renderer.c:851: if(!(x%2)){
	ld	a,-42 (ix)
	and	a, #0x01
	ld	-30 (ix),a
;src/Renderer.c:502: if (currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-13 (ix)
	and	a, #0x80
	ld	-2 (ix),a
;src/Renderer.c:522: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-15 (ix)
	ld	-12 (ix),a
	ld	-11 (ix),#0x00
;src/Renderer.c:851: if(!(x%2)){
	ld	a,-30 (ix)
	or	a, a
	jp	NZ,00229$
;src/Renderer.c:852: if (lateralWallCounter == 0 || newCell)
	ld	a,-34 (ix)
	or	a, a
	jr	Z,00225$
	ld	a,-6 (ix)
	or	a, a
	jp	Z,00229$
00225$:
;src/Renderer.c:854: if ( currentCellID & CELL_WALL_MASK)//Wall
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00223$
;src/Renderer.c:856: lateralWallCounter = 0;
	ld	-34 (ix),#0x00
;src/Renderer.c:857: lateralWallSlope = 0;
	ld	-29 (ix),#0x00
;src/Renderer.c:858: xHeight = zHeight;
	ld	a,-43 (ix)
	ld	-17 (ix),a
;src/Renderer.c:859: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
	ld	a,-13 (ix)
	sub	a, #0x80
	jr	NZ,00275$
	ld	-10 (ix),#0x0C
	jr	00276$
00275$:
	ld	-10 (ix),#0x0E
00276$:
	ld	a,-10 (ix)
	ld	-50 (ix),a
;src/Renderer.c:860: lastCellWasWall = 1;
	ld	-27 (ix),#0x01
;src/Renderer.c:861: lastWallId=currentCellID;
	ld	a,-13 (ix)
	ld	-25 (ix),a
	jp	00224$
00223$:
;src/Renderer.c:863: else if(lateralWallCounter==0){
	ld	a,-34 (ix)
	or	a, a
	jp	NZ,00224$
;src/Renderer.c:864: if (lastCellWasWall)
	ld	a,-27 (ix)
	or	a, a
	jp	Z,00218$
;src/Renderer.c:867: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-54 (ix)
	sub	a, -46 (ix)
	add	a, a
	inc	a
;src/Renderer.c:868: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-29 (ix), a
	srl	a
	ld	-38 (ix),a
;src/Renderer.c:869: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-43 (ix)
	ld	h,-29 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00648$:
	add	hl,hl
	jr	NC,00649$
	add	hl,de
00649$:
	djnz	00648$
;src/Renderer.c:870: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
	ld	-10 (ix), l
	ld	-22 (ix), l
	ld	-21 (ix),#0x00
	ld	a,-10 (ix)
	and	a, #0x03
	ld	-10 (ix), a
	ld	-40 (ix),a
	ld	-39 (ix),#0x00
	ld	a,-22 (ix)
	sub	a, -40 (ix)
	ld	-40 (ix),a
	ld	a,-21 (ix)
	sbc	a, -39 (ix)
	ld	-39 (ix),a
	ld	a,-40 (ix)
	add	a, #0x01
	ld	-22 (ix),a
	ld	a,-39 (ix)
	adc	a, #0x00
	ld	-21 (ix),a
	ld	a,-22 (ix)
	ld	-36 (ix),a
	ld	a,-21 (ix)
	ld	-35 (ix),a
	bit	7, -21 (ix)
	jr	Z,00277$
	ld	a,-40 (ix)
	add	a, #0x04
	ld	-36 (ix),a
	ld	a,-39 (ix)
	adc	a, #0x00
	ld	-35 (ix),a
00277$:
	ld	c,-36 (ix)
	ld	b,-35 (ix)
	sra	b
	rr	c
	sra	b
	rr	c
	ld	b,-15 (ix)
	ld	a,c
	sub	a, b
	ld	-34 (ix),a
;src/Renderer.c:872: lastCellWasWall = 0;
	ld	-27 (ix),#0x00
;src/Renderer.c:873: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	add	hl, hl
	ld	c,-29 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-5 (ix)
	sub	a, l
	ld	-17 (ix),a
;src/Renderer.c:874: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
	ld	a,-25 (ix)
	sub	a, #0x80
	jr	NZ,00278$
	ld	c,#0x0F
	jr	00279$
00278$:
	ld	c,#0x0D
00279$:
	ld	-50 (ix),c
	jr	00224$
00218$:
;src/Renderer.c:878: xHeight = 0;
	ld	-17 (ix),#0x00
;src/Renderer.c:879: lastCellWasWall = 0;
	ld	-27 (ix),#0x00
;src/Renderer.c:880: lateralWallSlope=0;
	ld	-29 (ix),#0x00
;src/Renderer.c:881: lastWallId=0;
	ld	-25 (ix),#0x00
00224$:
;src/Renderer.c:884: newCell=0;
	ld	-6 (ix),#0x00
00229$:
;src/Renderer.c:889: if (lateralWallCounter > 0)
	ld	a,-34 (ix)
	or	a, a
	jr	Z,00235$
;src/Renderer.c:892: if (lateralWallSlope != 0)
	ld	a,-29 (ix)
	or	a, a
	jr	Z,00233$
;src/Renderer.c:894: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-29 (ix)
	sub	a, -38 (ix)
	jr	NZ,00231$
;src/Renderer.c:896: lateralWallSlopeCounter = 0;
	ld	-38 (ix),#0x00
;src/Renderer.c:897: xHeight -= 2;
	dec	-17 (ix)
	dec	-17 (ix)
00231$:
;src/Renderer.c:899: ++lateralWallSlopeCounter;
	inc	-38 (ix)
00233$:
;src/Renderer.c:901: --lateralWallCounter;
	dec	-34 (ix)
00235$:
;src/Renderer.c:905: if (!(x%2))
	ld	a,-30 (ix)
	or	a, a
	jr	NZ,00244$
;src/Renderer.c:910: draw_column_to_buffer_untextured(x/2, xHeight, color);
	ld	b,-42 (ix)
	srl	b
;src/Renderer.c:908: if(xHeight > 0){
	ld	a,-17 (ix)
	or	a, a
	jr	Z,00237$
;src/Renderer.c:910: draw_column_to_buffer_untextured(x/2, xHeight, color);
	push	bc
	ld	h,-50 (ix)
	ld	l,-17 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_untextured
	pop	af
	inc	sp
	pop	bc
00237$:
;src/Renderer.c:913: if(!(currentCellID&CELL_WALL_MASK)){
	ld	a,-2 (ix)
	or	a, a
	jr	NZ,00244$
;src/Renderer.c:914: if(currentCellID&CELL_ENEMY_MASK){
	ld	a,-13 (ix)
	and	a, #0x0F
	jr	Z,00244$
;src/Renderer.c:915: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
	ld	a,-19 (ix)
	sub	a, -12 (ix)
	ld	l,a
	ld	a,-18 (ix)
	sbc	a, -11 (ix)
	ld	h,a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	ld	e,-19 (ix)
	ld	d,-18 (ix)
	push	de
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	d,l
	pop	bc
	push	de
	inc	sp
	ld	h,-13 (ix)
	ld	l,-43 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer_enemy
	pop	af
	pop	af
;src/Renderer.c:917: else if(currentCellID&CELL_ITEM_MASK){
00244$:
;src/Renderer.c:922: ++xCellCount;
	inc	-15 (ix)
;src/Renderer.c:841: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	dec	-42 (ix)
;src/Renderer.c:478: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-32 (ix),l
	ld	-31 (ix),h
;src/Renderer.c:841: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	ld	a,-42 (ix)
	sub	a, #0x50
	jp	NC,00258$
;src/Renderer.c:929: lineStart = lineStart + (offsetDiff * 2) + 3;
	ld	a,-4 (ix)
	add	a, #0x03
	ld	-49 (ix),a
;src/Renderer.c:930: zHeight += zHeight;
	sla	-43 (ix)
;src/Renderer.c:931: offsetDiff = offsetDiff >> 1;
	srl	-54 (ix)
;src/Renderer.c:933: }while(z);
	ld	a,-56 (ix)
	or	a, a
	jp	NZ,00246$
00260$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:941: void draw_minimap_to_buffer(){
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
;src/Renderer.c:944: u8* ptr = MINIMAP_BUFFER;
	ld	bc,#0x1C40
;src/Renderer.c:949: y=(PLAYER_position.y-MINIMAP_HEIGHT_HALF);
	ld	a, (#(_PLAYER_position + 0x0001) + 0)
	add	a,#0xF8
	ld	e,a
;src/Renderer.c:951: for(j=0;j<MINIMAP_HEIGHT;++j){
	ld	d,#0x00
;src/Renderer.c:952: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
00137$:
	ld	a,e
	rlca
	and	a,#0x01
	ld	-1 (ix),a
	ld	a,e
	xor	a, #0x80
	sub	a, #0xA0
	ld	a,#0x00
	rla
	ld	-2 (ix),a
	ld	-10 (ix),#0x00
00122$:
;src/Renderer.c:953: x=(PLAYER_position.x-MINIMAP_WIDTH_HALF);
	ld	a, (#_PLAYER_position + 0)
	add	a,#0xF8
	ld	-5 (ix),a
;src/Renderer.c:954: for(i=0;i<MINIMAP_WIDTH;++i){
	ld	-11 (ix),#0x00
00120$:
;src/Renderer.c:957: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	iy,#0x0010
	add	iy, bc
;src/Renderer.c:955: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
	bit	7, -5 (ix)
	jr	NZ,00111$
	ld	a,-5 (ix)
	xor	a, #0x80
	sub	a, #0xA0
	jr	NC,00111$
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00111$
	bit	0,-2 (ix)
	jr	NZ,00112$
00111$:
;src/Renderer.c:956: *ptr=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	(bc),a
;src/Renderer.c:957: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	0 (iy), a
	jp	00113$
00112$:
;src/Renderer.c:959: else if((x==PLAYER_position.x)&&(y==PLAYER_position.y)){
	ld	a,-5 (ix)
	ld	-4 (ix),a
	ld	a,-5 (ix)
	rla
	sbc	a, a
	ld	-3 (ix),a
	ld	a, (#_PLAYER_position + 0)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
	ld	-7 (ix),e
	ld	a,e
	rla
	sbc	a, a
	ld	-6 (ix),a
	ld	a,-4 (ix)
	sub	a, -9 (ix)
	jr	NZ,00108$
	ld	a,-3 (ix)
	sub	a, -8 (ix)
	jr	NZ,00108$
	ld	a, (#(_PLAYER_position + 0x0001) + 0)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
	ld	a,-7 (ix)
	sub	a, -9 (ix)
	jr	NZ,00108$
	ld	a,-6 (ix)
	sub	a, -8 (ix)
	jr	NZ,00108$
;src/Renderer.c:960: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
	ld	a, (#(_g_colors + 0x0004) + 0)
	ld	(bc),a
;src/Renderer.c:961: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
	ld	a, (#(_g_colors + 0x0004) + 0)
	ld	0 (iy), a
	jr	00113$
00108$:
;src/Renderer.c:964: val = (*(u8*)(MAP_MEM+x+y*MAP_WIDTH));
	ld	a,-4 (ix)
	add	a, #0x40
	ld	-9 (ix),a
	ld	a,-3 (ix)
	adc	a, #0x00
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
;src/Renderer.c:966: if(val==CELLTYPE_DOOR){
	ld	a,h
	sub	a, #0x80
	jr	NZ,00105$
;src/Renderer.c:967: *ptr=g_colors[MINIMAP_EXIT_COLOR];
	ld	a, (#(_g_colors + 0x0008) + 0)
	ld	(bc),a
;src/Renderer.c:968: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
	ld	a, (#(_g_colors + 0x0008) + 0)
	ld	0 (iy), a
	jr	00113$
00105$:
;src/Renderer.c:970: else if(val&CELL_WALL_MASK){
	add	hl, hl
	jr	NC,00102$
;src/Renderer.c:971: *ptr=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	(bc),a
;src/Renderer.c:972: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	0 (iy), a
	jr	00113$
00102$:
;src/Renderer.c:975: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
	ld	a, (#(_g_colors + 0x0003) + 0)
	ld	(bc),a
;src/Renderer.c:976: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
	ld	a, (#(_g_colors + 0x0003) + 0)
	ld	0 (iy), a
00113$:
;src/Renderer.c:979: ++x;
	inc	-5 (ix)
;src/Renderer.c:980: ++ptr;
	inc	bc
;src/Renderer.c:954: for(i=0;i<MINIMAP_WIDTH;++i){
	inc	-11 (ix)
	ld	a,-11 (ix)
	sub	a, #0x10
	jp	C,00120$
;src/Renderer.c:952: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
	inc	-10 (ix)
	ld	a,-10 (ix)
	sub	a, #0x04
	jp	C,00122$
;src/Renderer.c:983: ++y;
	inc	e
;src/Renderer.c:951: for(j=0;j<MINIMAP_HEIGHT;++j){
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
