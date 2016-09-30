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
;src/Renderer.c:200: void calculate_cells_in_view(){
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
;src/Renderer.c:202: u8 offset=0, n=0, j, i;
	ld	-6 (ix),#0x00
	ld	-7 (ix),#0x00
;src/Renderer.c:205: if(PLAYER_direction.y!=0){
	ld	a,(#_PLAYER_direction + 1)
	ld	-3 (ix), a
	or	a, a
	jr	Z,00102$
;src/Renderer.c:206: vert=1;
	ld	-14 (ix),#0x01
;src/Renderer.c:207: dy=PLAYER_direction.y;
	ld	c,-3 (ix)
	ld	-12 (ix),c
;src/Renderer.c:208: dx=-PLAYER_direction.y;
	xor	a, a
	sub	a, -3 (ix)
	ld	-11 (ix), a
;src/Renderer.c:210: x0 = PLAYER_position.x-(17*dx);
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
;src/Renderer.c:211: y0 = PLAYER_position.y+(6*dy);
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
;src/Renderer.c:214: vert=0;
	ld	-14 (ix),#0x00
;src/Renderer.c:215: dy=PLAYER_direction.x;
	ld	a,(#_PLAYER_direction + 0)
	ld	-3 (ix), a
	ld	-12 (ix),a
;src/Renderer.c:216: dx=PLAYER_direction.x;
	ld	a,-3 (ix)
	ld	-11 (ix),a
;src/Renderer.c:218: y0 = PLAYER_position.y-(17*dy);
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
;src/Renderer.c:219: x0 = PLAYER_position.x+(6*dx);
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
;src/Renderer.c:223: x=x0;
	ld	e,-10 (ix)
;src/Renderer.c:224: y=y0;
	ld	-13 (ix),c
;src/Renderer.c:226: for(j=0;j<6;++j){
	ld	a,-11 (ix)
	rlca
	and	a,#0x01
	ld	-3 (ix),a
	ld	a,-12 (ix)
	rlca
	and	a,#0x01
	ld	-5 (ix),a
	ld	-8 (ix),#0x00
;src/Renderer.c:228: for(i=offset;i<35-offset;++i){
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
;src/Renderer.c:231: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
	ld	hl,(_cells_in_view_array)
	ld	a,l
	add	a, -4 (ix)
	ld	-2 (ix),a
	ld	a,h
	adc	a, #0x00
	ld	-1 (ix),a
;src/Renderer.c:230: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
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
;src/Renderer.c:231: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
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
;src/Renderer.c:234: cells_in_view_array[n]=1;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),#0x01
00106$:
;src/Renderer.c:238: if(vert){
	ld	a,-14 (ix)
	or	a, a
	jr	Z,00111$
;src/Renderer.c:239: x+=dx;
	ld	a,e
	add	a, -11 (ix)
	ld	e,a
	jr	00112$
00111$:
;src/Renderer.c:242: y+=dy;
	ld	a,-13 (ix)
	add	a, -12 (ix)
	ld	-13 (ix),a
00112$:
;src/Renderer.c:244: ++n;
	inc	-4 (ix)
;src/Renderer.c:228: for(i=offset;i<35-offset;++i){
	inc	-9 (ix)
	jp	00125$
00143$:
	ld	a,-4 (ix)
	ld	-7 (ix),a
;src/Renderer.c:246: offset=offsets_cells_in_view[j];
	ld	a,#<(_offsets_cells_in_view)
	add	a, -8 (ix)
	ld	l,a
	ld	a,#>(_offsets_cells_in_view)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
;src/Renderer.c:250: if(dx<0) x=x0-offset;
	ld	-6 (ix), a
	ld	-2 (ix),a
;src/Renderer.c:248: if(vert){
	ld	a,-14 (ix)
	or	a, a
	jr	Z,00121$
;src/Renderer.c:249: y-=dy;
	ld	a,-13 (ix)
	sub	a, -12 (ix)
	ld	-13 (ix),a
;src/Renderer.c:250: if(dx<0) x=x0-offset;
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00115$
	ld	a,-10 (ix)
	sub	a, -2 (ix)
	ld	e,a
	jr	00128$
00115$:
;src/Renderer.c:251: else x=x0+offset;
	ld	a,-10 (ix)
	add	a, -2 (ix)
	ld	e,a
	jr	00128$
00121$:
;src/Renderer.c:255: x-=dx;
	ld	a,e
	sub	a, -11 (ix)
	ld	e,a
;src/Renderer.c:256: if(dy<0) y=y0-offset;
	ld	a,-5 (ix)
	or	a, a
	jr	Z,00118$
	ld	a,c
	sub	a, -2 (ix)
	ld	-13 (ix),a
	jr	00128$
00118$:
;src/Renderer.c:257: else y=y0+offset;
	ld	a,c
	add	a, -2 (ix)
	ld	-13 (ix),a
00128$:
;src/Renderer.c:226: for(j=0;j<6;++j){
	inc	-8 (ix)
	ld	a,-8 (ix)
	sub	a, #0x06
	jp	C,00138$
	ld	sp, ix
	pop	ix
	ret
_g_palette:
	.db #0x09	; 9
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x0D	; 13
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x0A	; 10
	.db #0x0B	; 11
	.db #0x0C	; 12
	.db #0x0D	; 13
	.db #0x0E	; 14
	.db #0x0F	; 15
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
	.dw #0x2BE0
_offsets_cells_in_view:
	.db #0x08	; 8
	.db #0x0C	; 12
	.db #0x0E	; 14
	.db #0x0F	; 15
	.db #0x10	; 16
;src/Renderer.c:263: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
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
;src/Renderer.c:264: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
	ld	a,4 (ix)
	srl	a
	add	a, #0x40
	ld	-12 (ix),a
	ld	a,#0x00
	adc	a, #0x1C
	ld	-11 (ix),a
;src/Renderer.c:266: u8 w_color, start=0,end=SCREEN_TEXTURE_HEIGHT;
	ld	-10 (ix),#0x00
	ld	-9 (ix),#0x64
;src/Renderer.c:267: u8 pixMask = pixelMask[column&1];
	ld	bc,#_pixelMask+0
	ld	a,4 (ix)
	and	a, #0x01
	ld	l, a
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-8 (ix),a
;src/Renderer.c:274: u8* texture = (u8*)(UNCOMPRESSED_LEVEL_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
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
	ld	-6 (ix),l
	ld	-5 (ix),h
;src/Renderer.c:282: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
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
	ld	-15 (ix),l
	ld	-14 (ix),h
;src/Renderer.c:283: u16 wall_texture_line=0;
	ld	hl,#0x0000
	ex	(sp), hl
;src/Renderer.c:288: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
	ld	c,5 (ix)
	srl	c
	ld	a,#0x32
	sub	a, c
;src/Renderer.c:289: ground_height = ceiling_height + lineHeight;
	ld	c,a
	add	a, 5 (ix)
	ld	-13 (ix),a
;src/Renderer.c:292: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
	ld	a,#0x64
	sub	a, 5 (ix)
	jr	NC,00118$
;src/Renderer.c:293: start=(lineHeight-SCREEN_TEXTURE_HEIGHT)/2;
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
;src/Renderer.c:294: end+=start;
	ld	-10 (ix), c
	ld	a, c
	add	a, #0x64
	ld	-9 (ix),a
;src/Renderer.c:295: ceiling_height=0;
	ld	c,#0x00
;src/Renderer.c:296: wall_texture_line = start * wall_texture_line_add;
	ld	e,-10 (ix)
	ld	d,#0x00
	push	bc
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	push	hl
	push	de
	call	__mulint
	pop	af
	pop	af
	pop	bc
	inc	sp
	inc	sp
	push	hl
;src/Renderer.c:301: for(j=start;j<end;++j){
00118$:
	ld	a,-8 (ix)
	cpl
	ld	-4 (ix),a
	ld	e,-12 (ix)
	ld	d,-11 (ix)
	ld	b,-10 (ix)
00108$:
	ld	a,b
	sub	a, -9 (ix)
	jr	NC,00110$
;src/Renderer.c:302: val =  ((*pvmem)&(~pixMask));
	ld	a,(de)
	and	a, -4 (ix)
	ld	-7 (ix),a
;src/Renderer.c:304: if((j>=ceiling_height) && (j<ground_height)){
	ld	a,b
	cp	a,c
	jr	C,00104$
	sub	a, -13 (ix)
	jr	NC,00104$
;src/Renderer.c:306: w_color = (*(texture+(wall_texture_line/256))&pixMask);
	ld	l,-16 (ix)
	ld	h,#0x00
	ld	a,-6 (ix)
	add	a, l
	ld	l,a
	ld	a,-5 (ix)
	adc	a, h
	ld	h,a
	ld	a,(hl)
	and	a, -8 (ix)
;src/Renderer.c:308: *pvmem = val|w_color;
	or	a, -7 (ix)
	ld	(de),a
;src/Renderer.c:310: wall_texture_line += wall_texture_line_add;
	ld	a,-17 (ix)
	add	a, -15 (ix)
	ld	-17 (ix),a
	ld	a,-16 (ix)
	adc	a, -14 (ix)
	ld	-16 (ix),a
00104$:
;src/Renderer.c:312: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
	ld	hl,#0x0028
	add	hl,de
	ex	de,hl
;src/Renderer.c:301: for(j=start;j<end;++j){
	inc	b
	jr	00108$
00110$:
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:316: void render_draw_to_buffer(){//TODO Optimize
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
;src/Renderer.c:326: u8 zHeight = 5;
	ld	-43 (ix),#0x05
;src/Renderer.c:332: u8 offsetDiff = 16;
	ld	-45 (ix),#0x10
;src/Renderer.c:337: u8 lineStart = 0;
	ld	-42 (ix),#0x00
;src/Renderer.c:339: u8 lateralWallWidth=0;
	ld	-35 (ix),#0x00
;src/Renderer.c:351: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
	ld	hl, #_g_colors + 1
	ld	b,(hl)
	ld	hl,#0x07A8
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x1C40
	push	hl
	call	_cpct_memset
;src/Renderer.c:352: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
	ld	hl, #_g_colors + 2
	ld	b,(hl)
	ld	hl,#0x0050
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x23E8
	push	hl
	call	_cpct_memset
;src/Renderer.c:353: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
	ld	hl, #_g_colors + 0
	ld	b,(hl)
	ld	hl,#0x07A8
	push	hl
	push	bc
	inc	sp
	ld	hl,#0x2438
	push	hl
	call	_cpct_memset
;src/Renderer.c:355: calculate_cells_in_view();
	call	_calculate_cells_in_view
;src/Renderer.c:358: do{
	ld	-31 (ix),#0x06
00165$:
;src/Renderer.c:360: --z;
	dec	-31 (ix)
;src/Renderer.c:364: xCellCount = (z) ? (zHeight >> 1) : 0;
	ld	a,-43 (ix)
	srl	a
	ld	-12 (ix),a
	ld	a,-31 (ix)
	or	a, a
	jr	Z,00174$
	ld	c,-12 (ix)
	jr	00175$
00174$:
	ld	c,#0x00
00175$:
	ld	-7 (ix),c
;src/Renderer.c:365: lateralWallSlope=0;
	ld	-6 (ix),#0x00
;src/Renderer.c:366: lateralWallSlopeCounter=0;
	ld	-14 (ix),#0x00
;src/Renderer.c:367: xHeight=0;
	ld	-29 (ix),#0x00
;src/Renderer.c:369: lateralWallCounter = 0;
	ld	-13 (ix),#0x00
;src/Renderer.c:371: newCell=1;
	ld	-5 (ix),#0x01
;src/Renderer.c:372: currentCellID = cells_in_view_array[lineStart + 1];
	ld	a,-42 (ix)
	ld	-25 (ix),a
	ld	-24 (ix),#0x00
	ld	c,-25 (ix)
	ld	b,-24 (ix)
	inc	bc
	ld	hl,(_cells_in_view_array)
	ld	-28 (ix),l
	ld	-27 (ix),h
	ld	l,-28 (ix)
	ld	h,-27 (ix)
	add	hl,bc
	ld	a,(hl)
	ld	-23 (ix),a
;src/Renderer.c:374: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
	ld	a,-28 (ix)
	add	a, -42 (ix)
	ld	l,a
	ld	a,-27 (ix)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
;src/Renderer.c:375: if(lastCellWasWall<5){
	ld	-22 (ix), a
	sub	a, #0x05
	jr	NC,00102$
;src/Renderer.c:376: lastWallId=lastCellWasWall;
;src/Renderer.c:377: lastCellWasWall=1;
	ld	-26 (ix),#0x01
	jr	00193$
00102$:
;src/Renderer.c:380: lastCellWasWall=0;
	ld	-26 (ix),#0x00
;src/Renderer.c:381: lastWallId=CELLTYPE_FLOOR;
	ld	-22 (ix),#0xFE
;src/Renderer.c:384: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
00193$:
	ld	-41 (ix),#0x00
	ld	-33 (ix),#0x00
00168$:
;src/Renderer.c:386: if (xCellCount == zHeight)
	ld	a,-43 (ix)
	sub	a, -7 (ix)
	jr	NZ,00105$
;src/Renderer.c:388: ++xCell;
	inc	-41 (ix)
;src/Renderer.c:389: xCellCount = 0;
	ld	-7 (ix),#0x00
;src/Renderer.c:390: newCell=1;
	ld	-5 (ix),#0x01
;src/Renderer.c:391: currentCellID=cells_in_view_array[xCell + lineStart + 1];
	ld	a,-41 (ix)
	ld	-21 (ix),a
	ld	-20 (ix),#0x00
	ld	a,-25 (ix)
	add	a, -21 (ix)
	ld	-21 (ix),a
	ld	a,-24 (ix)
	adc	a, -20 (ix)
	ld	-20 (ix),a
	inc	-21 (ix)
	jr	NZ,00320$
	inc	-20 (ix)
00320$:
	ld	a,-21 (ix)
	add	a, -28 (ix)
	ld	-21 (ix),a
	ld	a,-20 (ix)
	adc	a, -27 (ix)
	ld	-20 (ix),a
	ld	l,-21 (ix)
	ld	h,-20 (ix)
	ld	a,(hl)
	ld	-23 (ix),a
00105$:
;src/Renderer.c:393: if(!(x%2)){
	ld	a,-33 (ix)
	and	a, #0x01
	ld	-21 (ix),a
;src/Renderer.c:415: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-7 (ix)
	ld	-19 (ix),a
	ld	-18 (ix),#0x00
	ld	a,-43 (ix)
	ld	-15 (ix),a
;src/Renderer.c:393: if(!(x%2)){
	ld	a,-21 (ix)
	or	a, a
	jp	NZ,00118$
;src/Renderer.c:394: if ((lateralWallCounter == 0)||newCell)
	ld	a,-13 (ix)
	or	a, a
	jr	Z,00114$
	ld	a,-5 (ix)
	or	a, a
	jp	Z,00118$
00114$:
;src/Renderer.c:396: if (currentCellID < 5)//Wall
	ld	a,-23 (ix)
	sub	a, #0x05
	jr	NC,00112$
;src/Renderer.c:398: lateralWallCounter = 0;//(zHeight - xCellCount);
	ld	-13 (ix),#0x00
;src/Renderer.c:399: lateralWallSlope = 0;
	ld	-6 (ix),#0x00
;src/Renderer.c:400: xHeight = zHeight;
	ld	a,-43 (ix)
	ld	-29 (ix),a
;src/Renderer.c:401: color = currentCellID;
	ld	a,-23 (ix)
	ld	-44 (ix),a
;src/Renderer.c:402: lastCellWasWall = 1;
	ld	-26 (ix),#0x01
;src/Renderer.c:403: lastWallId=currentCellID;
	ld	a,-23 (ix)
	ld	-22 (ix),a
	jr	00113$
00112$:
;src/Renderer.c:405: else if(lateralWallCounter==0){//Lateral wall not finished
	ld	a,-13 (ix)
	or	a, a
	jr	NZ,00113$
;src/Renderer.c:406: if (lastCellWasWall)
	ld	a,-26 (ix)
	or	a, a
	jr	Z,00107$
;src/Renderer.c:409: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-45 (ix)
	sub	a, -41 (ix)
	add	a, a
	inc	a
;src/Renderer.c:410: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-6 (ix), a
	srl	a
	ld	-14 (ix),a
;src/Renderer.c:411: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-43 (ix)
	ld	h,-6 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00321$:
	add	hl,hl
	jr	NC,00322$
	add	hl,de
00322$:
	djnz	00321$
;src/Renderer.c:412: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
	ld	a,l
	and	a, #0xFC
	set	0, a
	srl	a
	srl	a
	sub	a, -7 (ix)
;src/Renderer.c:413: lateralWallWidth=lateralWallCounter;
	ld	-13 (ix), a
	ld	-35 (ix),a
;src/Renderer.c:414: lastCellWasWall = 0;
	ld	-26 (ix),#0x00
;src/Renderer.c:415: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	add	hl, hl
	ld	c,-6 (ix)
	ld	b,#0x00
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	a,-15 (ix)
	sub	a, l
	ld	-29 (ix),a
;src/Renderer.c:416: color = lastWallId;
	ld	a,-22 (ix)
	ld	-44 (ix),a
	jr	00113$
00107$:
;src/Renderer.c:420: xHeight = 0;
	ld	-29 (ix),#0x00
;src/Renderer.c:421: lastCellWasWall = 0;
	ld	-26 (ix),#0x00
;src/Renderer.c:422: lateralWallSlope=0;
	ld	-6 (ix),#0x00
;src/Renderer.c:423: lastWallId=0;
	ld	-22 (ix),#0x00
00113$:
;src/Renderer.c:426: newCell=0;
	ld	-5 (ix),#0x00
00118$:
;src/Renderer.c:429: if (lateralWallCounter > 0)
	ld	a,-13 (ix)
	or	a, a
	jr	Z,00124$
;src/Renderer.c:432: if (lateralWallSlope != 0)
	ld	a,-6 (ix)
	or	a, a
	jr	Z,00122$
;src/Renderer.c:434: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-6 (ix)
	sub	a, -14 (ix)
	jr	NZ,00120$
;src/Renderer.c:436: lateralWallSlopeCounter = 0;
	ld	-14 (ix),#0x00
;src/Renderer.c:437: xHeight -= 2;
	dec	-29 (ix)
	dec	-29 (ix)
00120$:
;src/Renderer.c:439: ++lateralWallSlopeCounter;
	inc	-14 (ix)
00122$:
;src/Renderer.c:442: --lateralWallCounter;
	dec	-13 (ix)
00124$:
;src/Renderer.c:453: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-43 (ix)
	ld	-11 (ix),a
	ld	-10 (ix),#0x00
;src/Renderer.c:445: if (!(x%2))
	ld	a,-21 (ix)
	or	a, a
	jr	NZ,00131$
;src/Renderer.c:447: if(xHeight > 0){
	ld	a,-29 (ix)
	or	a, a
	jr	Z,00131$
;src/Renderer.c:448: if (lateralWallCounter > 0)
	ld	a,-13 (ix)
	or	a, a
	jr	Z,00126$
;src/Renderer.c:450: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
	ld	c,-35 (ix)
	ld	b,#0x00
	ld	e,-13 (ix)
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
;src/Renderer.c:453: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c,-11 (ix)
	ld	b,-10 (ix)
	push	bc
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	b,l
00127$:
;src/Renderer.c:455: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	ld	d,-33 (ix)
	srl	d
	push	bc
	inc	sp
	ld	h,-44 (ix)
	ld	l,-29 (ix)
	push	hl
	push	de
	inc	sp
	call	_draw_column_to_buffer
	pop	af
	pop	af
00131$:
;src/Renderer.c:459: ++xCellCount;
	inc	-7 (ix)
;src/Renderer.c:384: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	inc	-33 (ix)
;src/Renderer.c:372: currentCellID = cells_in_view_array[lineStart + 1];
	ld	hl,(_cells_in_view_array)
	ld	-28 (ix),l
	ld	-27 (ix),h
;src/Renderer.c:384: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
	ld	a,-33 (ix)
	sub	a, #0x50
	jp	C,00168$
;src/Renderer.c:466: xCellCount = (z) ? (zHeight >> 1) : 0 ;
	ld	a,-31 (ix)
	or	a, a
	jr	Z,00176$
	ld	c,-12 (ix)
	jr	00177$
00176$:
	ld	c,#0x00
00177$:
	ld	-39 (ix),c
;src/Renderer.c:467: lateralWallSlope=0;
	ld	-38 (ix),#0x00
;src/Renderer.c:468: lateralWallSlopeCounter=0;
	ld	-30 (ix),#0x00
;src/Renderer.c:469: xHeight=0;
	ld	-32 (ix),#0x00
;src/Renderer.c:471: lateralWallCounter = 0;
	ld	-19 (ix),#0x00
;src/Renderer.c:472: lineEnd = lineStart + offsetDiff * 2 + 2;
	ld	a,-45 (ix)
	add	a, a
	ld	c,a
	ld	a,-42 (ix)
	add	a, c
	ld	-21 (ix), a
	ld	c, a
	inc	c
	inc	c
;src/Renderer.c:474: newCell=1;
	ld	-40 (ix),#0x01
;src/Renderer.c:475: currentCellID = cells_in_view_array[lineEnd - 1];
	ld	-25 (ix),c
	ld	-24 (ix),#0x00
	ld	e,-25 (ix)
	ld	d,-24 (ix)
	dec	de
	ld	l,-28 (ix)
	ld	h,-27 (ix)
	add	hl,de
	ld	a,(hl)
	ld	-37 (ix),a
;src/Renderer.c:477: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
	ld	l,-28 (ix)
	ld	h,-27 (ix)
	ld	b,#0x00
	add	hl, bc
	ld	c,(hl)
;src/Renderer.c:478: if(lastCellWasWall<5){
	ld	a,c
	sub	a, #0x05
	jr	NC,00134$
;src/Renderer.c:479: lastWallId=lastCellWasWall;
	ld	-36 (ix),c
;src/Renderer.c:480: lastCellWasWall=1;
	ld	-26 (ix),#0x01
	jr	00210$
00134$:
;src/Renderer.c:483: lastCellWasWall=0;
	ld	-26 (ix),#0x00
;src/Renderer.c:484: lastWallId=CELLTYPE_FLOOR;
	ld	-36 (ix),#0xFE
;src/Renderer.c:487: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
00210$:
	ld	-41 (ix),#0x00
	ld	-33 (ix),#0x9F
00170$:
;src/Renderer.c:490: if (xCellCount == zHeight)
	ld	a,-43 (ix)
	sub	a, -39 (ix)
	jr	NZ,00137$
;src/Renderer.c:492: ++xCell;
	inc	-41 (ix)
;src/Renderer.c:493: xCellCount = 0;
	ld	-39 (ix),#0x00
;src/Renderer.c:494: newCell=1;
	ld	-40 (ix),#0x01
;src/Renderer.c:495: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
	ld	a,-41 (ix)
	ld	-28 (ix),a
	ld	-27 (ix),#0x00
	ld	a,-25 (ix)
	sub	a, -28 (ix)
	ld	-28 (ix),a
	ld	a,-24 (ix)
	sbc	a, -27 (ix)
	ld	-27 (ix),a
	ld	l,-28 (ix)
	ld	h,-27 (ix)
	dec	hl
	ld	-28 (ix),l
	ld	-27 (ix),h
	ld	hl,(_cells_in_view_array)
	ld	-9 (ix),l
	ld	-8 (ix),h
	ld	a,-28 (ix)
	add	a, -9 (ix)
	ld	-9 (ix),a
	ld	a,-27 (ix)
	adc	a, -8 (ix)
	ld	-8 (ix),a
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	a,(hl)
	ld	-37 (ix),a
00137$:
;src/Renderer.c:497: if(!(x%2)){
	ld	a,-33 (ix)
	and	a, #0x01
	ld	-9 (ix),a
;src/Renderer.c:415: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
	ld	a,-39 (ix)
	ld	-28 (ix),a
	ld	-27 (ix),#0x00
;src/Renderer.c:497: if(!(x%2)){
	ld	a,-9 (ix)
	or	a, a
	jp	NZ,00150$
;src/Renderer.c:498: if (lateralWallCounter == 0 || newCell)
	ld	a,-19 (ix)
	or	a, a
	jr	Z,00146$
	ld	a,-40 (ix)
	or	a, a
	jp	Z,00150$
00146$:
;src/Renderer.c:500: if ( currentCellID < 5)//Wall
	ld	a,-37 (ix)
	sub	a, #0x05
	jr	NC,00144$
;src/Renderer.c:502: lateralWallCounter = 0;
	ld	-19 (ix),#0x00
;src/Renderer.c:503: lateralWallSlope = 0;
	ld	-38 (ix),#0x00
;src/Renderer.c:504: xHeight = zHeight;
	ld	a,-43 (ix)
	ld	-32 (ix),a
;src/Renderer.c:505: color = currentCellID;
	ld	a,-37 (ix)
	ld	-44 (ix),a
;src/Renderer.c:506: lastCellWasWall = 1;
	ld	-26 (ix),#0x01
;src/Renderer.c:507: lastWallId=currentCellID;
	ld	a,-37 (ix)
	ld	-36 (ix),a
	jp	00145$
00144$:
;src/Renderer.c:509: else if(lateralWallCounter==0){
	ld	a,-19 (ix)
	or	a, a
	jp	NZ,00145$
;src/Renderer.c:510: if (lastCellWasWall)
	ld	a,-26 (ix)
	or	a, a
	jp	Z,00139$
;src/Renderer.c:513: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
	ld	a,-45 (ix)
	sub	a, -41 (ix)
	add	a, a
	inc	a
;src/Renderer.c:514: lateralWallSlopeCounter = lateralWallSlope / 2;
	ld	-38 (ix), a
	srl	a
	ld	-30 (ix),a
;src/Renderer.c:515: lateralWallCounter = lateralWallSlope * zHeight;
	ld	e,-43 (ix)
	ld	h,-38 (ix)
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00327$:
	add	hl,hl
	jr	NC,00328$
	add	hl,de
00328$:
	djnz	00327$
	ld	-22 (ix), l
	ld	a, l
;src/Renderer.c:516: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
	ld	-34 (ix), a
	ld	-4 (ix),a
	ld	-3 (ix),#0x00
	ld	a,-34 (ix)
	and	a, #0x03
	ld	-22 (ix), a
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
	ld	a,-4 (ix)
	sub	a, -2 (ix)
	ld	-2 (ix),a
	ld	a,-3 (ix)
	sbc	a, -1 (ix)
	ld	-1 (ix),a
	ld	a,-2 (ix)
	add	a, #0x01
	ld	-4 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-3 (ix),a
	ld	a,-4 (ix)
	ld	-17 (ix),a
	ld	a,-3 (ix)
	ld	-16 (ix),a
	bit	7, -3 (ix)
	jr	Z,00178$
	ld	a,-2 (ix)
	add	a, #0x04
	ld	-17 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-16 (ix),a
00178$:
	sra	-16 (ix)
	rr	-17 (ix)
	sra	-16 (ix)
	rr	-17 (ix)
	ld	a,-17 (ix)
	ld	-17 (ix),a
	ld	c,-39 (ix)
	ld	a,-17 (ix)
	sub	a, c
;src/Renderer.c:517: lateralWallWidth=lateralWallCounter;
	ld	-19 (ix), a
	ld	-35 (ix),a
;src/Renderer.c:518: lastCellWasWall = 0;
	ld	-26 (ix),#0x00
;src/Renderer.c:519: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
	ld	a,-28 (ix)
	ld	-17 (ix),a
	ld	a,-27 (ix)
	ld	-16 (ix),a
	sla	-17 (ix)
	rl	-16 (ix)
	ld	a,-38 (ix)
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-16 (ix),h
	ld	-17 (ix), l
	ld	-17 (ix), l
	ld	a,-15 (ix)
	sub	a, -17 (ix)
	ld	-32 (ix),a
;src/Renderer.c:520: color = lastWallId;
	ld	a,-36 (ix)
	ld	-44 (ix),a
	jr	00145$
00139$:
;src/Renderer.c:524: xHeight = 0;
	ld	-32 (ix),#0x00
;src/Renderer.c:525: lastCellWasWall = 0;
	ld	-26 (ix),#0x00
;src/Renderer.c:526: lateralWallSlope=0;
	ld	-38 (ix),#0x00
;src/Renderer.c:527: lastWallId=0;
	ld	-36 (ix),#0x00
00145$:
;src/Renderer.c:530: newCell=0;
	ld	-40 (ix),#0x00
00150$:
;src/Renderer.c:535: if (lateralWallCounter > 0)
	ld	a,-19 (ix)
	or	a, a
	jr	Z,00156$
;src/Renderer.c:538: if (lateralWallSlope != 0)
	ld	a,-38 (ix)
	or	a, a
	jr	Z,00154$
;src/Renderer.c:540: if (lateralWallSlopeCounter == lateralWallSlope)
	ld	a,-30 (ix)
	sub	a, -38 (ix)
	jr	NZ,00152$
;src/Renderer.c:542: lateralWallSlopeCounter = 0;
	ld	-30 (ix),#0x00
;src/Renderer.c:543: xHeight -= 2;
	dec	-32 (ix)
	dec	-32 (ix)
00152$:
;src/Renderer.c:545: ++lateralWallSlopeCounter;
	inc	-30 (ix)
00154$:
;src/Renderer.c:547: --lateralWallCounter;
	dec	-19 (ix)
00156$:
;src/Renderer.c:551: if (!(x%2))
	ld	a,-9 (ix)
	or	a, a
	jp	NZ,00163$
;src/Renderer.c:554: if(xHeight > 0){
	ld	a,-32 (ix)
	or	a, a
	jp	Z,00163$
;src/Renderer.c:556: if (lateralWallCounter > 0)
	ld	a,-19 (ix)
	or	a, a
	jr	Z,00158$
;src/Renderer.c:558: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
	ld	a,-19 (ix)
	ld	-17 (ix),a
	ld	-16 (ix),#0x00
	ld	a,#0x05+1
	jr	00334$
00333$:
	sla	-17 (ix)
	rl	-16 (ix)
00334$:
	dec	a
	jr	NZ,00333$
	ld	a,-35 (ix)
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	d,l
	jr	00159$
00158$:
;src/Renderer.c:561: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
	ld	a,-11 (ix)
	sub	a, -28 (ix)
	ld	-17 (ix),a
	ld	a,-10 (ix)
	sbc	a, -27 (ix)
	ld	-16 (ix),a
	ld	a,#0x05+1
	jr	00336$
00335$:
	sla	-17 (ix)
	rl	-16 (ix)
00336$:
	dec	a
	jr	NZ,00335$
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	push	hl
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	push	hl
	call	__divsint
	pop	af
	pop	af
	ld	-16 (ix),h
	ld	-17 (ix), l
	ld	d, l
00159$:
;src/Renderer.c:564: draw_column_to_buffer(x/2, xHeight, color,tex_column);
	ld	b,-33 (ix)
	srl	b
	push	de
	inc	sp
	ld	h,-44 (ix)
	ld	l,-32 (ix)
	push	hl
	push	bc
	inc	sp
	call	_draw_column_to_buffer
	pop	af
	pop	af
00163$:
;src/Renderer.c:567: ++xCellCount;
	inc	-39 (ix)
;src/Renderer.c:487: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
	dec	-33 (ix)
	ld	a,-33 (ix)
	sub	a, #0x50
	jp	NC,00170$
;src/Renderer.c:574: lineStart = lineStart + (offsetDiff * 2) + 3;
	ld	a,-21 (ix)
	add	a, #0x03
	ld	-42 (ix),a
;src/Renderer.c:575: zHeight += zHeight;
	sla	-43 (ix)
;src/Renderer.c:576: offsetDiff = offsetDiff >> 1;
	srl	-45 (ix)
;src/Renderer.c:578: }while(z);
	ld	a,-31 (ix)
	or	a, a
	jp	NZ,00165$
	ld	sp, ix
	pop	ix
	ret
;src/Renderer.c:586: void draw_minimap_to_buffer(){
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
;src/Renderer.c:589: u8* ptr = MINIMAP_BUFFER;
	ld	bc,#0x1C40
;src/Renderer.c:594: y=(PLAYER_position.y-MINIMAP_HEIGHT_HALF);
	ld	a, (#(_PLAYER_position + 0x0001) + 0)
	add	a,#0xF8
	ld	e,a
;src/Renderer.c:596: for(j=0;j<MINIMAP_HEIGHT;++j){
	ld	d,#0x00
;src/Renderer.c:597: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
00133$:
	ld	a,e
	rlca
	and	a,#0x01
	ld	-8 (ix),a
	ld	a,e
	xor	a, #0x80
	sub	a, #0xA0
	ld	a,#0x00
	rla
	ld	-9 (ix),a
	ld	-11 (ix),#0x00
00119$:
;src/Renderer.c:598: x=(PLAYER_position.x-MINIMAP_WIDTH_HALF);
	ld	a, (#_PLAYER_position + 0)
	add	a,#0xF8
	ld	-1 (ix),a
;src/Renderer.c:599: for(i=0;i<MINIMAP_WIDTH;++i){
	ld	-10 (ix),#0x00
00117$:
;src/Renderer.c:602: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	iy,#0x0010
	add	iy, bc
;src/Renderer.c:600: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
	bit	7, -1 (ix)
	jr	NZ,00108$
	ld	a,-1 (ix)
	xor	a, #0x80
	sub	a, #0xA0
	jr	NC,00108$
	ld	a,-8 (ix)
	or	a, a
	jr	NZ,00108$
	bit	0,-9 (ix)
	jr	NZ,00109$
00108$:
;src/Renderer.c:601: *ptr=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0002) + 0)
	ld	(bc),a
;src/Renderer.c:602: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0002) + 0)
	ld	0 (iy), a
	jp	00110$
00109$:
;src/Renderer.c:604: else if((x==PLAYER_position.x)&&(y==PLAYER_position.y)){
	ld	a,-1 (ix)
	ld	-3 (ix),a
	ld	a,-1 (ix)
	rla
	sbc	a, a
	ld	-2 (ix),a
	ld	a, (#_PLAYER_position + 0)
	ld	-5 (ix),a
	ld	-4 (ix),#0x00
	ld	-7 (ix),e
	ld	a,e
	rla
	sbc	a, a
	ld	-6 (ix),a
	ld	a,-3 (ix)
	sub	a, -5 (ix)
	jr	NZ,00105$
	ld	a,-2 (ix)
	sub	a, -4 (ix)
	jr	NZ,00105$
	ld	a, (#(_PLAYER_position + 0x0001) + 0)
	ld	-5 (ix),a
	ld	-4 (ix),#0x00
	ld	a,-7 (ix)
	sub	a, -5 (ix)
	jr	NZ,00105$
	ld	a,-6 (ix)
	sub	a, -4 (ix)
	jr	NZ,00105$
;src/Renderer.c:605: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
	ld	a, (#(_g_colors + 0x0005) + 0)
	ld	(bc),a
;src/Renderer.c:606: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
	ld	a, (#(_g_colors + 0x0005) + 0)
	ld	0 (iy), a
	jr	00110$
00105$:
;src/Renderer.c:609: switch(*(u8*)(MAP_MEM+x+y*MAP_WIDTH)){
	ld	a,-3 (ix)
	add	a, #0x40
	ld	-5 (ix),a
	ld	a,-2 (ix)
	adc	a, #0x00
	ld	-4 (ix),a
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a,-5 (ix)
	add	a, l
	ld	l,a
	ld	a,-4 (ix)
	adc	a, h
	ld	h,a
	ld	a,(hl)
	sub	a, #0xFE
	jr	NZ,00102$
;src/Renderer.c:611: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
	ld	a, (#(_g_colors + 0x0003) + 0)
	ld	(bc),a
;src/Renderer.c:612: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
	ld	a, (#(_g_colors + 0x0003) + 0)
	ld	0 (iy), a
;src/Renderer.c:613: break;
	jr	00110$
;src/Renderer.c:615: default:{
00102$:
;src/Renderer.c:616: *ptr=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0002) + 0)
	ld	(bc),a
;src/Renderer.c:617: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
	ld	a, (#(_g_colors + 0x0002) + 0)
	ld	0 (iy), a
;src/Renderer.c:620: }
00110$:
;src/Renderer.c:622: ++x;
	inc	-1 (ix)
;src/Renderer.c:623: ++ptr;
	inc	bc
;src/Renderer.c:599: for(i=0;i<MINIMAP_WIDTH;++i){
	inc	-10 (ix)
	ld	a,-10 (ix)
	sub	a, #0x10
	jp	C,00117$
;src/Renderer.c:597: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
	inc	-11 (ix)
	ld	a,-11 (ix)
	sub	a, #0x04
	jp	C,00119$
;src/Renderer.c:626: ++y;
	inc	e
;src/Renderer.c:596: for(j=0;j<MINIMAP_HEIGHT;++j){
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
