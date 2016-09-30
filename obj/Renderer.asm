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
	.globl _calculate_cells_in_view
	.globl _cpct_memset
	.globl _offsets_cells_in_view
	.globl _cells_in_view_array
	.globl _pixelMask
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
;src/Renderer.c:206: void calculate_cells_in_view(){
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
;src/Renderer.c:208: u8 offset=0, n=0, j, i;
	ld	-6 (ix),#0x00
	ld	-7 (ix),#0x00
;src/Renderer.c:211: if(PLAYER_direction.y!=0){
	ld	a,(#_PLAYER_direction + 1)
	ld	-4 (ix), a
	or	a, a
	jr	Z,00102$
;src/Renderer.c:212: vert=1;
	ld	-14 (ix),#0x01
;src/Renderer.c:213: dy=PLAYER_direction.y;
	ld	c,-4 (ix)
	ld	-12 (ix),c
;src/Renderer.c:214: dx=-PLAYER_direction.y;
	xor	a, a
	sub	a, -4 (ix)
	ld	-11 (ix), a
;src/Renderer.c:216: x0 = PLAYER_position.x-(17*dx);
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
;src/Renderer.c:217: y0 = PLAYER_position.y+(6*dy);
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
;src/Renderer.c:220: vert=0;
	ld	-14 (ix),#0x00
;src/Renderer.c:221: dy=PLAYER_direction.x;
	ld	a,(#_PLAYER_direction + 0)
	ld	-4 (ix), a
	ld	-12 (ix),a
;src/Renderer.c:222: dx=PLAYER_direction.x;
	ld	a,-4 (ix)
	ld	-11 (ix),a
;src/Renderer.c:224: y0 = PLAYER_position.y-(17*dy);
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
;src/Renderer.c:225: x0 = PLAYER_position.x+(6*dx);
	ld	hl, #_PLAYER_position + 0
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
;src/Renderer.c:229: x=x0;
	ld	e,-10 (ix)
;src/Renderer.c:230: y=y0;
	ld	-13 (ix),c
;src/Renderer.c:232: for(j=0;j<6;++j){
	ld	a,-11 (ix)
	rlca
	and	a,#0x01
	ld	-4 (ix),a
	ld	a,-12 (ix)
	rlca
	and	a,#0x01
	ld	-1 (ix),a
	ld	-8 (ix),#0x00
;src/Renderer.c:234: for(i=offset;i<35-offset;++i){
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
;src/Renderer.c:237: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
	ld	hl,(_cells_in_view_array)
	ld	a,l
	add	a, -5 (ix)
	ld	-3 (ix),a
	ld	a,h
	adc	a, #0x00
	ld	-2 (ix),a
;src/Renderer.c:236: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
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
;src/Renderer.c:237: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
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
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	(hl),b
	jr	00106$
00105$:
;src/Renderer.c:240: cells_in_view_array[n]=1;
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	(hl),#0x01
00106$:
;src/Renderer.c:244: if(vert){
	ld	a,-14 (ix)
	or	a, a
	jr	Z,00111$
;src/Renderer.c:245: x+=dx;
	ld	a,e
	add	a, -11 (ix)
	ld	e,a
	jr	00112$
00111$:
;src/Renderer.c:248: y+=dy;
	ld	a,-13 (ix)
	add	a, -12 (ix)
	ld	-13 (ix),a
00112$:
;src/Renderer.c:250: ++n;
	inc	-5 (ix)
;src/Renderer.c:234: for(i=offset;i<35-offset;++i){
	inc	-9 (ix)
	jp	00125$
00143$:
	ld	a,-5 (ix)
	ld	-7 (ix),a
;src/Renderer.c:252: offset=offsets_cells_in_view[j];
	ld	a,#<(_offsets_cells_in_view)
	add	a, -8 (ix)
	ld	l,a
	ld	a,#>(_offsets_cells_in_view)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
;src/Renderer.c:256: if(dx<0) x=x0-offset;
	ld	-6 (ix), a
	ld	-3 (ix),a
;src/Renderer.c:254: if(vert){
	ld	a,-14 (ix)
	or	a, a
	jr	Z,00121$
;src/Renderer.c:255: y-=dy;
	ld	a,-13 (ix)
	sub	a, -12 (ix)
	ld	-13 (ix),a
;src/Renderer.c:256: if(dx<0) x=x0-offset;
	ld	a,-4 (ix)
	or	a, a
	jr	Z,00115$
	ld	a,-10 (ix)
	sub	a, -3 (ix)
	ld	e,a
	jr	00128$
00115$:
;src/Renderer.c:257: else x=x0+offset;
	ld	a,-10 (ix)
	add	a, -3 (ix)
	ld	e,a
	jr	00128$
00121$:
;src/Renderer.c:261: x-=dx;
	ld	a,e
	sub	a, -11 (ix)
	ld	e,a
;src/Renderer.c:262: if(dy<0) y=y0-offset;
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00118$
	ld	a,c
	sub	a, -3 (ix)
	ld	-13 (ix),a
	jr	00128$
00118$:
;src/Renderer.c:263: else y=y0+offset;
	ld	a,c
	add	a, -3 (ix)
	ld	-13 (ix),a
00128$:
;src/Renderer.c:232: for(j=0;j<6;++j){
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
_pixelMask:
	.db #0xAA	; 170
	.db #0x55	; 85	'U'
_cells_in_view_array:
	.dw #0x3AE0
_offsets_cells_in_view:
	.db #0x08	; 8
	.db #0x0C	; 12
	.db #0x0E	; 14
	.db #0x0F	; 15
	.db #0x10	; 16
;src/Renderer.c:269: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
;	---------------------------------
; Function draw_column_to_buffer
; ---------------------------------
_draw_column_to_buffer::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-17
	add	hl,sp
	ld	sp,hl
;src/Renderer.c:270: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a,4 (ix)
	srl	a
	add	a, #0x40
	ld	-6 (ix),a
	ld	a,#0x00
	adc	a, #0x2B
	ld	-5 (ix),a
;src/Renderer.c:272: u8 w_color, start=0,end=SCREEN_TEXTURE_HEIGHT;
	ld	-8 (ix),#0x00
	ld	-7 (ix),#0x64
;src/Renderer.c:273: u8 pixMask = pixelMask[column&1];
	ld	bc,#_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l, a
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-9 (ix),a
;src/Renderer.c:280: u8* texture = (u8*)(UNCOMPRESSED_LEVEL_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
	ld	a, 6 (ix)
	add	a, a
	add	a, a
	ld	b,a
	ld	c,#0x00
	ld	hl,#0x0840
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
	ld	-16 (ix),l
	ld	-15 (ix),h
;src/Renderer.c:288: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
	ld	a,5 (ix)
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
	ld	-13 (ix),l
	ld	-12 (ix),h
;src/Renderer.c:289: u16 wall_texture_line=0;
	ld	-11 (ix),#0x00
	ld	-10 (ix),#0x00
;src/Renderer.c:294: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
	ld	c,5 (ix)
	srl	c
	ld	a,#0x32
	sub	a, c
;src/Renderer.c:295: ground_height = ceiling_height + lineHeight;
	ld	c,a
	add	a, 5 (ix)
	ld	-14 (ix),a
;src/Renderer.c:298: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
	ld	a,#0x64
	sub	a, 5 (ix)
	jr	NC,00118$
;src/Renderer.c:299: start=(lineHeight-SCREEN_TEXTURE_HEIGHT)/2;
	ld	a,-2 (ix)
	add	a,#0x9C
	ld	c,a
	ld	a,-1 (ix)
	adc	a,#0xFF
	ld	b,a
	ld	-4 (ix),c
	ld	-3 (ix),b
	bit	7, b
	jr	Z,00112$
	ld	a,-2 (ix)
	add	a, #0x9D
	ld	-4 (ix),a
	ld	a,-1 (ix)
	adc	a, #0xFF
	ld	-3 (ix),a
00112$:
	ld	c,-4 (ix)
	ld	b,-3 (ix)
	sra	b
	rr	c
;src/Renderer.c:300: end+=start;
	ld	-8 (ix), c
	ld	a, c
	add	a, #0x64
	ld	-7 (ix),a
;src/Renderer.c:301: ceiling_height=0;
	ld	c,#0x00
;src/Renderer.c:302: wall_texture_line = start * wall_texture_line_add;
	ld	e,-8 (ix)
	ld	d,#0x00
	push	bc
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	push	hl
	push	de
	call	__mulint
	pop	af
	pop	af
	pop	bc
	ld	-11 (ix),l
	ld	-10 (ix),h
;src/Renderer.c:307: for(j=start;j<end;++j){
00118$:
	ld	a,-9 (ix)
	cpl
	ld	-4 (ix),a
	ld	e,-6 (ix)
	ld	d,-5 (ix)
	ld	b,-8 (ix)
00108$:
	ld	a,b
	sub	a, -7 (ix)
	jr	NC,00110$
;src/Renderer.c:308: val =  ((*pvmem)&(~pixMask));
	ld	a,(de)
	and	a, -4 (ix)
	ld	-17 (ix),a
;src/Renderer.c:310: if((j>=ceiling_height) && (j<ground_height)){
	ld	a,b
	cp	a,c
	jr	C,00104$
	sub	a, -14 (ix)
	jr	NC,00104$
;src/Renderer.c:312: w_color = (*(texture+(wall_texture_line/256))&pixMask);
	ld	l,-10 (ix)
	ld	h,#0x00
	ld	a,-16 (ix)
	add	a, l
	ld	l,a
	ld	a,-15 (ix)
	adc	a, h
	ld	h,a
	ld	a,(hl)
	and	a, -9 (ix)
;src/Renderer.c:314: *pvmem = val|w_color;
	or	a, -17 (ix)
	ld	(de),a
;src/Renderer.c:316: wall_texture_line += wall_texture_line_add;
	ld	a,-11 (ix)
	add	a, -13 (ix)
	ld	-11 (ix),a
	ld	a,-10 (ix)
	adc	a, -12 (ix)
	ld	-10 (ix),a
00104$:
;src/Renderer.c:318: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,de
	ex	de,hl
;src/Renderer.c:307: for(j=start;j<end;++j){
	inc	b
	jr	00108$
00110$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:322: void render_draw_to_buffer(){//TODO Optimize
;	---------------------------------
; Function render_draw_to_buffer
; ---------------------------------
_render_draw_to_buffer::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-45
	add	hl,sp
	ld	sp,hl
;src/Renderer.c:332: u8 zHeight = 5;
	ld	-41 (ix),#0x05
;src/Renderer.c:338: u8 offsetDiff = 16;
	ld	-34 (ix),#0x10
;src/Renderer.c:343: u8 lineStart = 0;
	ld	-35 (ix),#0x00
;src/Renderer.c:345: u8 lateralWallWidth=0;
	ld	-36 (ix),#0x00
;src/Renderer.c:357: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
	ld	hl, #_g_colors + 5
	ld	b,(hl)
	ld	hl,#0x07A8
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x2B40
	push	hl
	call	_cpct_memset
;src/Renderer.c:358: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
	ld	hl, #_g_colors + 1
	ld	b,(hl)
	ld	hl,#0x0050
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x32E8
	push	hl
	call	_cpct_memset
;src/Renderer.c:359: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
	ld	hl, #_g_colors + 6
	ld	b,(hl)
	ld	hl,#0x07A8
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x3338
	push	hl
	call	_cpct_memset
;src/Renderer.c:361: calculate_cells_in_view();
	call	_calculate_cells_in_view
;src/Renderer.c:364: do{
	ld	-44 (ix),#0x06
00165$:
;src/Renderer.c:366: --z;
	dec	-44 (ix)
;src/Renderer.c:370: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-41 (ix)
	srl	a
	ld	-15 (ix),a
	ld	a,-44 (ix)
	or	a, a
	jr	Z,00174$
	ld	c,-15 (ix)
	jr	00175$
00174$:
	ld	c,#0x00
00175$:
	ld	-10 (ix),c
;src/Renderer.c:371: lateralWallSlope=0;
	ld	-9 (ix),#0x00
;src/Renderer.c:372: lateralWallSlopeCounter=0;
	ld	-16 (ix),#0x00
;src/Renderer.c:373: xHeight=0;
	ld	-27 (ix),#0x00
;src/Renderer.c:375: lateralWallCounter = 0;
	ld	-26 (ix),#0x00
;src/Renderer.c:377: newCell=1;
	ld	-23 (ix),#0x01
;src/Renderer.c:378: currentCellID = cells_in_view_array[lineStart + 1];
	ld	a,-35 (ix)
	ld	-22 (ix),a
	ld	-21 (ix),#0x00
	ld	c,-22 (ix)
	ld	b,-21 (ix)
	inc	bc
	ld	hl,(_cells_in_view_array)
	ld	-20 (ix),l
	ld	-19 (ix),h
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	add	hl,bc
	ld	a,(hl)
	ld	-14 (ix),a
;src/Renderer.c:380: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
	ld	a,-20 (ix)
	add	a, -35 (ix)
	ld	l,a
	ld	a,-19 (ix)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
;src/Renderer.c:381: if(lastCellWasWall<5){
	ld	-11 (ix), a
	sub	a, #0x05
	jr	NC,00102$
;src/Renderer.c:382: lastWallId=lastCellWasWall;
;src/Renderer.c:383: lastCellWasWall=1;
	ld	-8 (ix),#0x01
	jr	00193$
00102$:
;src/Renderer.c:386: lastCellWasWall=0;
	ld	-8 (ix),#0x00
;src/Renderer.c:387: lastWallId=CELLTYPE_FLOOR;
	ld	-11 (ix),#0xFE
;src/Renderer.c:390: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
00193$:
	ld	-42 (ix),#0x00
	ld	-30 (ix),#0x00
00168$:
;src/Renderer.c:392: if (xCellCount == zHeight)
	ld	a,-41 (ix)
	sub	a, -10 (ix)
	jr	NZ,00105$
;src/Renderer.c:394: ++xCell;
	inc	-42 (ix)
;src/Renderer.c:395: xCellCount = 0;
	ld	-10 (ix),#0x00
;src/Renderer.c:396: newCell=1;
	ld	-23 (ix),#0x01
;src/Renderer.c:397: currentCellID=cells_in_view_array[xCell + lineStart + 1];
	ld	a,-42 (ix)
	ld	-7 (ix),a
	ld	-6 (ix),#0x00
	ld	a,-22 (ix)
	add	a, -7 (ix)
	ld	-7 (ix),a
	ld	a,-21 (ix)
	adc	a, -6 (ix)
	ld	-6 (ix),a
	inc	-7 (ix)
	jr	NZ,00320$
	inc	-6 (ix)
00320$:
	ld	a,-7 (ix)
	add	a, -20 (ix)
	ld	-7 (ix),a
	ld	a,-6 (ix)
	adc	a, -19 (ix)
	ld	-6 (ix),a
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	ld	-14 (ix),a
00105$:
;src/Renderer.c:399: if(!(x%2)){
	ld	a,-30 (ix)
	and	a, #0x01
	ld	-7 (ix),a
;src/Renderer.c:421: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-10 (ix)
	ld	-5 (ix),a
	ld	-4 (ix),#0x00
	ld	a,-41 (ix)
	ld	-3 (ix),a
;src/Renderer.c:399: if(!(x%2)){
	ld	a,-7 (ix)
	or	a, a
	jp	NZ,00118$
;src/Renderer.c:400: if ((lateralWallCounter == 0)||newCell)
	ld	a,-26 (ix)
	or	a, a
	jr	Z,00114$
	ld	a,-23 (ix)
	or	a, a
	jp	Z,00118$
00114$:
;src/Renderer.c:402: if (currentCellID < 5)//Wall
	ld	a,-14 (ix)
	sub	a, #0x05
	jr	NC,00112$
;src/Renderer.c:404: lateralWallCounter = 0;//(zHeight - xCellCount);
	ld	-26 (ix),#0x00
;src/Renderer.c:405: lateralWallSlope = 0;
	ld	-9 (ix),#0x00
;src/Renderer.c:406: xHeight = zHeight;
	ld	a,-41 (ix)
	ld	-27 (ix),a
;src/Renderer.c:407: color = currentCellID;
	ld	a,-14 (ix)
	ld	-43 (ix),a
;src/Renderer.c:408: lastCellWasWall = 1;
	ld	-8 (ix),#0x01
;src/Renderer.c:409: lastWallId=currentCellID;
	ld	a,-14 (ix)
	ld	-11 (ix),a
	jr	00113$
00112$:
;src/Renderer.c:411: else if(lateralWallCounter==0){//Lateral wall not finished
	ld	a,-26 (ix)
	or	a, a
	jr	NZ,00113$
;src/Renderer.c:412: if (lastCellWasWall)
	ld	a,-8 (ix)
	or	a, a
	jr	Z,00107$
;src/Renderer.c:415: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-34 (ix)
	sub	a, -42 (ix)
	add	a, a
	inc	a
;src/Renderer.c:416: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-9 (ix), a
	srl	a
	ld	-16 (ix),a
;src/Renderer.c:417: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-41 (ix)
	ld	h,-9 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00321$:
	add	hl,hl
	jr	NC,00322$
	add	hl,de
00322$:
	djnz	00321$
;src/Renderer.c:418: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
	ld	a,l
	and	a, #0xFC
	set	0, a
	srl	a
	srl	a
	sub	a, -10 (ix)
;src/Renderer.c:419: lateralWallWidth=lateralWallCounter;
	ld	-26 (ix), a
	ld	-36 (ix),a
;src/Renderer.c:420: lastCellWasWall = 0;
	ld	-8 (ix),#0x00
;src/Renderer.c:421: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	add	hl, hl
	ld	c,-9 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-3 (ix)
	sub	a, l
	ld	-27 (ix),a
;src/Renderer.c:422: color = lastWallId;
	ld	a,-11 (ix)
	ld	-43 (ix),a
	jr	00113$
00107$:
;src/Renderer.c:426: xHeight = 0;
	ld	-27 (ix),#0x00
;src/Renderer.c:427: lastCellWasWall = 0;
	ld	-8 (ix),#0x00
;src/Renderer.c:428: lateralWallSlope=0;
	ld	-9 (ix),#0x00
;src/Renderer.c:429: lastWallId=0;
	ld	-11 (ix),#0x00
00113$:
;src/Renderer.c:432: newCell=0;
	ld	-23 (ix),#0x00
00118$:
;src/Renderer.c:435: if (lateralWallCounter > 0)
	ld	a,-26 (ix)
	or	a, a
	jr	Z,00124$
;src/Renderer.c:438: if (lateralWallSlope != 0)
	ld	a,-9 (ix)
	or	a, a
	jr	Z,00122$
;src/Renderer.c:440: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-9 (ix)
	sub	a, -16 (ix)
	jr	NZ,00120$
;src/Renderer.c:442: lateralWallSlopeCounter = 0;
	ld	-16 (ix),#0x00
;src/Renderer.c:443: xHeight -= 2;
	dec	-27 (ix)
	dec	-27 (ix)
00120$:
;src/Renderer.c:445: ++lateralWallSlopeCounter;
	inc	-16 (ix)
00122$:
;src/Renderer.c:448: --lateralWallCounter;
	dec	-26 (ix)
00124$:
;src/Renderer.c:459: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-41 (ix)
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
;src/Renderer.c:451: if (!(x%2))
	ld	a,-7 (ix)
	or	a, a
	jr	NZ,00131$
;src/Renderer.c:453: if(xHeight > 0){
	ld	a,-27 (ix)
	or	a, a
	jr	Z,00131$
;src/Renderer.c:454: if (lateralWallCounter > 0)
	ld	a,-26 (ix)
	or	a, a
	jr	Z,00126$
;src/Renderer.c:456: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
	ld	c,-36 (ix)
	ld	b,#0x00
	ld	e,-26 (ix)
	ld	d,#0x00
	ld	a,c
	sub	a, e
	ld	l,a
	ld	a,b
	sbc	a, d
	ld	h,a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	b,l
	jr	00127$
00126$:
;src/Renderer.c:459: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c,-2 (ix)
	ld	b,-1 (ix)
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	b,l
00127$:
;src/Renderer.c:461: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	ld	d,-30 (ix)
	srl	d
	push	bc
	inc	sp
	ld	h,-43 (ix)
	ld	l,-27 (ix)
	push	hl
	push	de
	inc	sp
	call	_draw_column_to_buffer
	pop	af
	pop	af
00131$:
;src/Renderer.c:465: ++xCellCount;
	inc	-10 (ix)
;src/Renderer.c:390: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	inc	-30 (ix)
;src/Renderer.c:378: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-20 (ix),l
	ld	-19 (ix),h
;src/Renderer.c:390: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	ld	a,-30 (ix)
	sub	a, #0x50
	jp	C,00168$
;src/Renderer.c:472: xCellCount = (z) ? (zHeight >> 1) : 0 ;
	ld	a,-44 (ix)
	or	a, a
	jr	Z,00176$
	ld	c,-15 (ix)
	jr	00177$
00176$:
	ld	c,#0x00
00177$:
	ld	-40 (ix),c
;src/Renderer.c:473: lateralWallSlope=0;
	ld	-39 (ix),#0x00
;src/Renderer.c:474: lateralWallSlopeCounter=0;
	ld	-31 (ix),#0x00
;src/Renderer.c:475: xHeight=0;
	ld	-45 (ix),#0x00
;src/Renderer.c:477: lateralWallCounter = 0;
	ld	-5 (ix),#0x00
;src/Renderer.c:478: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	a,-34 (ix)
	add	a, a
	ld	c,a
	ld	a,-35 (ix)
	add	a, c
	ld	-7 (ix), a
	ld	c, a
	inc	c
	inc	c
;src/Renderer.c:480: newCell=1;
	ld	-33 (ix),#0x01
;src/Renderer.c:481: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	-22 (ix),c
	ld	-21 (ix),#0x00
	ld	e,-22 (ix)
	ld	d,-21 (ix)
	dec	de
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	add	hl,de
	ld	a,(hl)
	ld	-32 (ix),a
;src/Renderer.c:483: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	ld	b,#0x00
	add	hl, bc
	ld	c,(hl)
;src/Renderer.c:484: if(lastCellWasWall<5){
	ld	a,c
	sub	a, #0x05
	jr	NC,00134$
;src/Renderer.c:485: lastWallId=lastCellWasWall;
	ld	-37 (ix),c
;src/Renderer.c:486: lastCellWasWall=1;
	ld	-8 (ix),#0x01
	jr	00210$
00134$:
;src/Renderer.c:489: lastCellWasWall=0;
	ld	-8 (ix),#0x00
;src/Renderer.c:490: lastWallId=CELLTYPE_FLOOR;
	ld	-37 (ix),#0xFE
;src/Renderer.c:493: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
00210$:
	ld	-42 (ix),#0x00
	ld	-30 (ix),#0x9F
00170$:
;src/Renderer.c:496: if (xCellCount == zHeight)
	ld	a,-41 (ix)
	sub	a, -40 (ix)
	jr	NZ,00137$
;src/Renderer.c:498: ++xCell;
	inc	-42 (ix)
;src/Renderer.c:499: xCellCount = 0;
	ld	-40 (ix),#0x00
;src/Renderer.c:500: newCell=1;
	ld	-33 (ix),#0x01
;src/Renderer.c:501: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
	ld	a,-42 (ix)
	ld	-20 (ix),a
	ld	-19 (ix),#0x00
	ld	a,-22 (ix)
	sub	a, -20 (ix)
	ld	-20 (ix),a
	ld	a,-21 (ix)
	sbc	a, -19 (ix)
	ld	-19 (ix),a
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	dec	hl
	ld	-20 (ix),l
	ld	-19 (ix),h
	ld	hl,(_cells_in_view_array)
	ld	-29 (ix),l
	ld	-28 (ix),h
	ld	a,-20 (ix)
	add	a, -29 (ix)
	ld	-29 (ix),a
	ld	a,-19 (ix)
	adc	a, -28 (ix)
	ld	-28 (ix),a
	ld	l,-29 (ix)
	ld	h,-28 (ix)
	ld	a,(hl)
	ld	-32 (ix),a
00137$:
;src/Renderer.c:503: if(!(x%2)){
	ld	a,-30 (ix)
	and	a, #0x01
	ld	-29 (ix),a
;src/Renderer.c:421: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-40 (ix)
	ld	-20 (ix),a
	ld	-19 (ix),#0x00
;src/Renderer.c:503: if(!(x%2)){
	ld	a,-29 (ix)
	or	a, a
	jp	NZ,00150$
;src/Renderer.c:504: if (lateralWallCounter == 0 || newCell)
	ld	a,-5 (ix)
	or	a, a
	jr	Z,00146$
	ld	a,-33 (ix)
	or	a, a
	jp	Z,00150$
00146$:
;src/Renderer.c:506: if ( currentCellID < 5)//Wall
	ld	a,-32 (ix)
	sub	a, #0x05
	jr	NC,00144$
;src/Renderer.c:508: lateralWallCounter = 0;
	ld	-5 (ix),#0x00
;src/Renderer.c:509: lateralWallSlope = 0;
	ld	-39 (ix),#0x00
;src/Renderer.c:510: xHeight = zHeight;
	ld	a,-41 (ix)
	ld	-45 (ix),a
;src/Renderer.c:511: color = currentCellID;
	ld	a,-32 (ix)
	ld	-43 (ix),a
;src/Renderer.c:512: lastCellWasWall = 1;
	ld	-8 (ix),#0x01
;src/Renderer.c:513: lastWallId=currentCellID;
	ld	a,-32 (ix)
	ld	-37 (ix),a
	jp	00145$
00144$:
;src/Renderer.c:515: else if(lateralWallCounter==0){
	ld	a,-5 (ix)
	or	a, a
	jp	NZ,00145$
;src/Renderer.c:516: if (lastCellWasWall)
	ld	a,-8 (ix)
	or	a, a
	jp	Z,00139$
;src/Renderer.c:519: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-34 (ix)
	sub	a, -42 (ix)
	add	a, a
	inc	a
;src/Renderer.c:520: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-39 (ix), a
	srl	a
	ld	-31 (ix),a
;src/Renderer.c:521: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-41 (ix)
	ld	h,-39 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00327$:
	add	hl,hl
	jr	NC,00328$
	add	hl,de
00328$:
	djnz	00327$
	ld	-11 (ix), l
	ld	a, l
;src/Renderer.c:522: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
	ld	-38 (ix), a
	ld	-18 (ix),a
	ld	-17 (ix),#0x00
	ld	a,-38 (ix)
	and	a, #0x03
	ld	-11 (ix), a
	ld	-13 (ix),a
	ld	-12 (ix),#0x00
	ld	a,-18 (ix)
	sub	a, -13 (ix)
	ld	-13 (ix),a
	ld	a,-17 (ix)
	sbc	a, -12 (ix)
	ld	-12 (ix),a
	ld	a,-13 (ix)
	add	a, #0x01
	ld	-18 (ix),a
	ld	a,-12 (ix)
	adc	a, #0x00
	ld	-17 (ix),a
	ld	a,-18 (ix)
	ld	-25 (ix),a
	ld	a,-17 (ix)
	ld	-24 (ix),a
	bit	7, -17 (ix)
	jr	Z,00178$
	ld	a,-13 (ix)
	add	a, #0x04
	ld	-25 (ix),a
	ld	a,-12 (ix)
	adc	a, #0x00
	ld	-24 (ix),a
00178$:
	sra	-24 (ix)
	rr	-25 (ix)
	sra	-24 (ix)
	rr	-25 (ix)
	ld	a,-25 (ix)
	ld	-25 (ix),a
	ld	c,-40 (ix)
	ld	a,-25 (ix)
	sub	a, c
;src/Renderer.c:523: lateralWallWidth=lateralWallCounter;
	ld	-5 (ix), a
	ld	-36 (ix),a
;src/Renderer.c:524: lastCellWasWall = 0;
	ld	-8 (ix),#0x00
;src/Renderer.c:525: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
	ld	a,-20 (ix)
	ld	-25 (ix),a
	ld	a,-19 (ix)
	ld	-24 (ix),a
	sla	-25 (ix)
	rl	-24 (ix)
	ld	a,-39 (ix)
	ld	-13 (ix),a
	ld	-12 (ix),#0x00
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	push	hl
	ld	l,-25 (ix)
	ld	h,-24 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-24 (ix),h
	ld	-25 (ix), l
	ld	-25 (ix), l
	ld	a,-3 (ix)
	sub	a, -25 (ix)
	ld	-45 (ix),a
;src/Renderer.c:526: color = lastWallId;
	ld	a,-37 (ix)
	ld	-43 (ix),a
	jr	00145$
00139$:
;src/Renderer.c:530: xHeight = 0;
	ld	-45 (ix),#0x00
;src/Renderer.c:531: lastCellWasWall = 0;
	ld	-8 (ix),#0x00
;src/Renderer.c:532: lateralWallSlope=0;
	ld	-39 (ix),#0x00
;src/Renderer.c:533: lastWallId=0;
	ld	-37 (ix),#0x00
00145$:
;src/Renderer.c:536: newCell=0;
	ld	-33 (ix),#0x00
00150$:
;src/Renderer.c:541: if (lateralWallCounter > 0)
	ld	a,-5 (ix)
	or	a, a
	jr	Z,00156$
;src/Renderer.c:544: if (lateralWallSlope != 0)
	ld	a,-39 (ix)
	or	a, a
	jr	Z,00154$
;src/Renderer.c:546: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-31 (ix)
	sub	a, -39 (ix)
	jr	NZ,00152$
;src/Renderer.c:548: lateralWallSlopeCounter = 0;
	ld	-31 (ix),#0x00
;src/Renderer.c:549: xHeight -= 2;
	dec	-45 (ix)
	dec	-45 (ix)
00152$:
;src/Renderer.c:551: ++lateralWallSlopeCounter;
	inc	-31 (ix)
00154$:
;src/Renderer.c:553: --lateralWallCounter;
	dec	-5 (ix)
00156$:
;src/Renderer.c:557: if (!(x%2))
	ld	a,-29 (ix)
	or	a, a
	jp	NZ,00163$
;src/Renderer.c:560: if(xHeight > 0){
	ld	a,-45 (ix)
	or	a, a
	jp	Z,00163$
;src/Renderer.c:562: if (lateralWallCounter > 0)
	ld	a,-5 (ix)
	or	a, a
	jr	Z,00158$
;src/Renderer.c:564: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
	ld	a,-5 (ix)
	ld	-25 (ix),a
	ld	-24 (ix),#0x00
	ld	a,#0x05+1
	jr	00334$
00333$:
	sla	-25 (ix)
	rl	-24 (ix)
00334$:
	dec	a
	jr	NZ,00333$
	ld	a,-36 (ix)
	ld	-13 (ix),a
	ld	-12 (ix),#0x00
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	push	hl
	ld	l,-25 (ix)
	ld	h,-24 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	d,l
	jr	00159$
00158$:
;src/Renderer.c:567: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-2 (ix)
	sub	a, -20 (ix)
	ld	-25 (ix),a
	ld	a,-1 (ix)
	sbc	a, -19 (ix)
	ld	-24 (ix),a
	ld	a,#0x05+1
	jr	00336$
00335$:
	sla	-25 (ix)
	rl	-24 (ix)
00336$:
	dec	a
	jr	NZ,00335$
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-25 (ix)
	ld	h,-24 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-24 (ix),h
	ld	-25 (ix), l
	ld	d, l
00159$:
;src/Renderer.c:570: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	ld	b,-30 (ix)
	srl	b
	push	de
	inc	sp
	ld	h,-43 (ix)
	ld	l,-45 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer
	pop	af
	pop	af
00163$:
;src/Renderer.c:573: ++xCellCount;
	inc	-40 (ix)
;src/Renderer.c:493: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	dec	-30 (ix)
	ld	a,-30 (ix)
	sub	a, #0x50
	jp	NC,00170$
;src/Renderer.c:580: lineStart = lineStart + (offsetDiff * 2) + 3;
	ld	a,-7 (ix)
	add	a, #0x03
	ld	-35 (ix),a
;src/Renderer.c:581: zHeight += zHeight;
	sla	-41 (ix)
;src/Renderer.c:582: offsetDiff = offsetDiff >> 1;
	srl	-34 (ix)
;src/Renderer.c:584: }while(z);
	ld	a,-44 (ix)
	or	a, a
	jp	NZ,00165$
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:592: void draw_minimap_to_buffer(){
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
;src/Renderer.c:595: u8* ptr = MINIMAP_BUFFER;
	ld	bc,#0x1C40
;src/Renderer.c:600: y=(PLAYER_position.y-MINIMAP_HEIGHT_HALF);
	ld	a, (#(_PLAYER_position + 0x0001) + 0)
	add	a,#0xF8
	ld	e,a
;src/Renderer.c:602: for(j=0;j<MINIMAP_HEIGHT;++j){
	ld	d,#0x00
;src/Renderer.c:603: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
00133$:
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
00119$:
;src/Renderer.c:604: x=(PLAYER_position.x-MINIMAP_WIDTH_HALF);
	ld	a, (#_PLAYER_position + 0)
	add	a,#0xF8
	ld	-3 (ix),a
;src/Renderer.c:605: for(i=0;i<MINIMAP_WIDTH;++i){
	ld	-11 (ix),#0x00
00117$:
;src/Renderer.c:608: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	iy,#0x0010
	add	iy, bc
;src/Renderer.c:606: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
	bit	7, -3 (ix)
	jr	NZ,00108$
	ld	a,-3 (ix)
	xor	a, #0x80
	sub	a, #0xA0
	jr	NC,00108$
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00108$
	bit	0,-2 (ix)
	jr	NZ,00109$
00108$:
;src/Renderer.c:607: *ptr=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	(bc),a
;src/Renderer.c:608: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	0 (iy), a
	jp	00110$
00109$:
;src/Renderer.c:610: else if((x==PLAYER_position.x)&&(y==PLAYER_position.y)){
	ld	a,-3 (ix)
	ld	-5 (ix),a
	ld	a,-3 (ix)
	rla
	sbc	a, a
	ld	-4 (ix),a
	ld	a, (#_PLAYER_position + 0)
	ld	-7 (ix),a
	ld	-6 (ix),#0x00
	ld	-9 (ix),e
	ld	a,e
	rla
	sbc	a, a
	ld	-8 (ix),a
	ld	a,-5 (ix)
	sub	a, -7 (ix)
	jr	NZ,00105$
	ld	a,-4 (ix)
	sub	a, -6 (ix)
	jr	NZ,00105$
	ld	a, (#(_PLAYER_position + 0x0001) + 0)
	ld	-7 (ix),a
	ld	-6 (ix),#0x00
	ld	a,-9 (ix)
	sub	a, -7 (ix)
	jr	NZ,00105$
	ld	a,-8 (ix)
	sub	a, -6 (ix)
	jr	NZ,00105$
;src/Renderer.c:611: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
	ld	a, (#(_g_colors + 0x0005) + 0)
	ld	(bc),a
;src/Renderer.c:612: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
	ld	a, (#(_g_colors + 0x0005) + 0)
	ld	0 (iy), a
	jr	00110$
00105$:
;src/Renderer.c:615: switch(*(u8*)(MAP_MEM+x+y*MAP_WIDTH)){
	ld	a,-5 (ix)
	add	a, #0x40
	ld	-7 (ix),a
	ld	a,-4 (ix)
	adc	a, #0x00
	ld	-6 (ix),a
	ld	l,-9 (ix)
	ld	h,-8 (ix)
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
	ld	a,(hl)
	sub	a, #0xFE
	jr	NZ,00102$
;src/Renderer.c:617: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
	ld	a, (#(_g_colors + 0x0003) + 0)
	ld	(bc),a
;src/Renderer.c:618: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
	ld	a, (#(_g_colors + 0x0003) + 0)
	ld	0 (iy), a
;src/Renderer.c:619: break;
	jr	00110$
;src/Renderer.c:621: default:{
00102$:
;src/Renderer.c:622: *ptr=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	(bc),a
;src/Renderer.c:623: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0001) + 0)
	ld	0 (iy), a
;src/Renderer.c:626: }
00110$:
;src/Renderer.c:628: ++x;
	inc	-3 (ix)
;src/Renderer.c:629: ++ptr;
	inc	bc
;src/Renderer.c:605: for(i=0;i<MINIMAP_WIDTH;++i){
	inc	-11 (ix)
	ld	a,-11 (ix)
	sub	a, #0x10
	jp	C,00117$
;src/Renderer.c:603: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
	inc	-10 (ix)
	ld	a,-10 (ix)
	sub	a, #0x04
	jp	C,00119$
;src/Renderer.c:632: ++y;
	inc	e
;src/Renderer.c:602: for(j=0;j<MINIMAP_HEIGHT;++j){
	inc	d
	ld	a,d
	sub	a, #0x10
	jp	C,00133$
	ld	sp, ix
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
