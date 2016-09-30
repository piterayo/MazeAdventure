;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module Map
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _cpct_setSeed_lcg_u8
	.globl _cpct_getRandom_lcg_u8
	.globl _cpct_memset
	.globl _rand_seed
	.globl _init_generator
	.globl _generate_map
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
;src/Map.c:10: void init_generator(){
;	---------------------------------
; Function init_generator
; ---------------------------------
_init_generator::
;src/Map.c:11: cpct_setSeed_lcg_u8(rand_seed);
	ld	iy,#_rand_seed
	ld	l,0 (iy)
	jp  _cpct_setSeed_lcg_u8
_rand_seed:
	.db #0x00	; 0
;src/Map.c:14: void generate_map(){
;	---------------------------------
; Function generate_map
; ---------------------------------
_generate_map::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-21
	add	hl,sp
	ld	sp,hl
;src/Map.c:17: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
	ld	-14 (ix),#0x83
	ld	-13 (ix),#0x03
;src/Map.c:23: u16 wallListCount = 0;
	ld	-19 (ix),#0x00
	ld	-18 (ix),#0x00
;src/Map.c:24: u16 lastStackItem = 0;
	ld	hl,#0x0000
	ex	(sp), hl
;src/Map.c:26: (*cellStack).x = (cpct_getRandom_lcg_u8()%(MAP_WIDTH-2))+1; //RANDOM
	call	_cpct_getRandom_lcg_u8
	ld	b,l
	ld	a,#0x1E
	push	af
	inc	sp
	push	bc
	inc	sp
	call	__moduchar
	pop	af
	ld	c,l
	inc	c
	ld	hl,#0x1C40
	ld	(hl),c
;src/Map.c:27: (*cellStack).y = (cpct_getRandom_lcg_u8()%(MAP_HEIGHT-2))+1; //RANDOM
	call	_cpct_getRandom_lcg_u8
	ld	b,l
	ld	a,#0x1E
	push	af
	inc	sp
	push	bc
	inc	sp
	call	__moduchar
	pop	af
	ld	c,l
	inc	c
	ld	hl,#0x1C41
	ld	(hl),c
;src/Map.c:30: *(i8*)&(PLAYER_position.x) = (*cellStack).y;
	ld	-6 (ix),#<(_PLAYER_position)
	ld	-5 (ix),#>(_PLAYER_position)
	ld	l, #0x41
	ld	a,(hl)
	ld	-4 (ix),a
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	a,-4 (ix)
	ld	(hl),a
;src/Map.c:31: *(i8*)&(PLAYER_position.y) = (*cellStack).x;
	ld	-6 (ix),#<((_PLAYER_position + 0x0001))
	ld	-5 (ix),#>((_PLAYER_position + 0x0001))
	ld	hl,#0x1C40
	ld	c,(hl)
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	(hl),c
;src/Map.c:33: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
	ld	hl,#0x0400
	push	hl
	ld	a,#0xFF
	push	af
	inc	sp
	ld	hl,#0x0040
	push	hl
	call	_cpct_memset
;src/Map.c:35: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
	ld	a,(#0x1C40)
	ld	-4 (ix), a
	ld	-6 (ix),a
	ld	-5 (ix),#0x00
	ld	a,#0x05+1
	jr	00315$
00314$:
	sla	-6 (ix)
	rl	-5 (ix)
00315$:
	dec	a
	jr	NZ,00314$
	ld	a,-6 (ix)
	add	a, #0x40
	ld	-6 (ix),a
	ld	a,-5 (ix)
	adc	a, #0x00
	ld	-5 (ix),a
	ld	hl,#0x1C41
	ld	c,(hl)
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	b,#0x00
	add	hl, bc
	ld	(hl),#0xFE
;src/Map.c:38: for(i=0;i<MAP_WIDTH;++i){
	ld	-15 (ix),#0x00
00167$:
;src/Map.c:39: map[0][i]=cpct_getRandom_lcg_u8()&3;
	ld	a,-15 (ix)
	add	a, #0x40
	ld	-6 (ix),a
	ld	a,#0x00
	adc	a, #0x00
	ld	-5 (ix),a
	call	_cpct_getRandom_lcg_u8
	ld	a,l
	and	a, #0x03
	ld	-4 (ix),a
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	a,-4 (ix)
	ld	(hl),a
;src/Map.c:40: map[MAP_HEIGHT-1][i]=cpct_getRandom_lcg_u8()&3;
	ld	a,-15 (ix)
	add	a, #0x20
	ld	-6 (ix),a
	ld	a,#0x00
	adc	a, #0x04
	ld	-5 (ix),a
	call	_cpct_getRandom_lcg_u8
	ld	a,l
	and	a, #0x03
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	(hl),a
;src/Map.c:38: for(i=0;i<MAP_WIDTH;++i){
	inc	-15 (ix)
	ld	a,-15 (ix)
	sub	a, #0x20
	jr	C,00167$
;src/Map.c:43: for(i=1;i<MAP_HEIGHT-1;++i){
	ld	-15 (ix),#0x01
00169$:
;src/Map.c:44: map[i][0]=cpct_getRandom_lcg_u8()&3;
	ld	a,-15 (ix)
	ld	-6 (ix),a
	ld	-5 (ix),#0x00
	ld	a,#0x05+1
	jr	00317$
00316$:
	sla	-6 (ix)
	rl	-5 (ix)
00317$:
	dec	a
	jr	NZ,00316$
	ld	a,-6 (ix)
	add	a, #0x40
	ld	-3 (ix),a
	ld	a,-5 (ix)
	adc	a, #0x00
	ld	-2 (ix),a
	call	_cpct_getRandom_lcg_u8
	ld	a,l
	and	a, #0x03
	ld	-4 (ix),a
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	a,-4 (ix)
	ld	(hl),a
;src/Map.c:45: map[i][MAP_WIDTH-1]=cpct_getRandom_lcg_u8()&3;
	ld	a,-6 (ix)
	add	a, #0x40
	ld	-3 (ix),a
	ld	a,-5 (ix)
	adc	a, #0x00
	ld	-2 (ix),a
	ld	a,-3 (ix)
	add	a, #0x1F
	ld	c,a
	ld	a,-2 (ix)
	adc	a, #0x00
	ld	b,a
	push	bc
	call	_cpct_getRandom_lcg_u8
	pop	bc
	ld	a,l
	and	a, #0x03
	ld	(bc),a
;src/Map.c:43: for(i=1;i<MAP_HEIGHT-1;++i){
	inc	-15 (ix)
	ld	a,-15 (ix)
	sub	a, #0x1F
	jr	C,00169$
;src/Map.c:48: while(remainingCells>0){
	ld	hl,#0x0004
	add	hl,sp
	ld	-3 (ix),l
	ld	-2 (ix),h
00164$:
	ld	a,-13 (ix)
	or	a,-14 (ix)
	jp	Z,00171$
;src/Map.c:49: wallListPosition = wallList+wallListCount;
	pop	bc
	pop	hl
	push	hl
	push	bc
	add	hl, hl
	ld	a,l
	add	a, #0x40
	ld	-6 (ix),a
	ld	a,h
	adc	a, #0x20
	ld	-5 (ix),a
;src/Map.c:50: while(wallListCount<MAP_SIZE){
	pop	de
	pop	bc
	push	bc
	push	de
00134$:
;src/Map.c:53: currentPos.y = (*wallListPosition).y;
	ld	a,-3 (ix)
	add	a, #0x01
	ld	-8 (ix),a
	ld	a,-2 (ix)
	adc	a, #0x00
	ld	-7 (ix),a
;src/Map.c:50: while(wallListCount<MAP_SIZE){
	ld	a,b
	sub	a, #0x04
	jp	NC,00204$
;src/Map.c:52: currentPos.x = (*wallListPosition).x;
	ld	hl,#0x0004
	add	hl,sp
	ex	de,hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	a,(hl)
	ld	(de),a
;src/Map.c:53: currentPos.y = (*wallListPosition).y;
	ld	e,-6 (ix)
	ld	d,-5 (ix)
	inc	de
	ld	a,(de)
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	(hl),a
;src/Map.c:55: convertToFloor=0;
	ld	-11 (ix),#0x00
;src/Map.c:56: surroundedByWalls=1;
	ld	-12 (ix),#0x01
;src/Map.c:58: if(currentPos.x>0){
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	a,(hl)
	ld	-4 (ix),a
;src/Map.c:59: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	a,(hl)
	ld	-1 (ix),a
	ld	a,-4 (ix)
	ld	-10 (ix),a
	ld	-9 (ix),#0x00
;src/Map.c:58: if(currentPos.x>0){
	ld	a,-4 (ix)
	or	a, a
	jr	Z,00109$
;src/Map.c:59: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	dec	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	de
	ld	de,#0x0040
	add	hl, de
	pop	de
	ld	a,l
	add	a, -1 (ix)
	ld	l,a
	ld	a,h
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:60: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	inc	a
	jr	NZ,00106$
;src/Map.c:61: convertToFloor  = 1;
	ld	-11 (ix),#0x01
	jr	00109$
00106$:
;src/Map.c:63: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	sub	a, #0xFE
	jr	NZ,00109$
;src/Map.c:64: surroundedByWalls = 0;
	ld	-12 (ix),#0x00
00109$:
;src/Map.c:67: if(currentPos.x < (MAP_WIDTH-1)){
	ld	a,-4 (ix)
	sub	a, #0x1F
	jr	NC,00116$
;src/Map.c:69: adjacentType = map[currentPos.x+1][currentPos.y];
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	de
	ld	de,#0x0040
	add	hl, de
	pop	de
	ld	a,l
	add	a, -1 (ix)
	ld	l,a
	ld	a,h
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:70: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	inc	a
	jr	NZ,00113$
;src/Map.c:71: convertToFloor  = 1;
	ld	-11 (ix),#0x01
	jr	00116$
00113$:
;src/Map.c:73: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	sub	a, #0xFE
	jr	NZ,00116$
;src/Map.c:74: surroundedByWalls = 0;
	ld	-12 (ix),#0x00
00116$:
;src/Map.c:79: adjacentType = map[currentPos.x][currentPos.y-1];
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a,l
	add	a, #0x40
	ld	-10 (ix),a
	ld	a,h
	adc	a, #0x00
	ld	-9 (ix),a
;src/Map.c:77: if(currentPos.y > 0){
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00123$
;src/Map.c:79: adjacentType = map[currentPos.x][currentPos.y-1];
	ld	l,-1 (ix)
	dec	l
	ld	a,-10 (ix)
	add	a, l
	ld	l,a
	ld	a,-9 (ix)
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:80: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	inc	a
	jr	NZ,00120$
;src/Map.c:81: convertToFloor  = 1;
	ld	-11 (ix),#0x01
	jr	00123$
00120$:
;src/Map.c:83: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	sub	a, #0xFE
	jr	NZ,00123$
;src/Map.c:84: surroundedByWalls = 0;
	ld	-12 (ix),#0x00
00123$:
;src/Map.c:87: if(currentPos.y < (MAP_HEIGHT-1)){
	ld	a,-1 (ix)
	sub	a, #0x1F
	jr	NC,00130$
;src/Map.c:89: adjacentType = map[currentPos.x][currentPos.y+1];
	ld	l,-1 (ix)
	inc	l
	ld	a,-10 (ix)
	add	a, l
	ld	l,a
	ld	a,-9 (ix)
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:90: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	inc	a
	jr	NZ,00127$
;src/Map.c:91: convertToFloor  = 1;
	ld	-11 (ix),#0x01
	jr	00130$
00127$:
;src/Map.c:93: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	sub	a, #0xFE
	jr	NZ,00130$
;src/Map.c:94: surroundedByWalls = 0;
	ld	-12 (ix),#0x00
00130$:
;src/Map.c:98: (*wallListPosition).x = (*(wallList+wallListCount)).x;
	ld	l, c
	ld	h, b
	add	hl, hl
	ld	iy,#0x2040
	push	bc
	ld	c, l
	ld	b, h
	add	iy, bc
	pop	bc
	ld	a, 0 (iy)
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	(hl),a
;src/Map.c:99: (*wallListPosition).y = (*(wallList+wallListCount)).y;
	push	iy
	pop	hl
	inc	hl
	ld	a,(hl)
	ld	(de),a
;src/Map.c:100: --wallListCount;
	dec	bc
	ld	-19 (ix),c
	ld	-18 (ix),b
;src/Map.c:103: if((convertToFloor)&&(!surroundedByWalls)){
	ld	a,-11 (ix)
	or	a, a
	jr	Z,00132$
	ld	a,-12 (ix)
	or	a, a
	jr	NZ,00132$
;src/Map.c:104: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	l,(hl)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc,#0x0040
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,bc
	ld	(hl),#0xFE
;src/Map.c:106: ++lastStackItem;
	inc	-21 (ix)
	jr	NZ,00334$
	inc	-20 (ix)
00334$:
;src/Map.c:107: (*(cellStack+lastStackItem)).x = currentPos.x;
	pop	hl
	push	hl
	add	hl, hl
	ld	bc, #0x1C40
	add	hl,bc
	ld	c, l
	ld	b, h
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	a,(hl)
	ld	(bc),a
;src/Map.c:108: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	bc
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	a,(hl)
	ld	(bc),a
;src/Map.c:111: break;
	jr	00204$
00132$:
;src/Map.c:113: --wallListPosition;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	dec	hl
	dec	hl
	ld	-6 (ix),l
	ld	-5 (ix),h
	jp	00134$
;src/Map.c:115: while(lastStackItem<MAP_SIZE){
00204$:
	ld	a,-14 (ix)
	ld	-10 (ix),a
	ld	a,-13 (ix)
	ld	-9 (ix),a
	ld	a,-19 (ix)
	ld	-6 (ix),a
	ld	a,-18 (ix)
	ld	-5 (ix),a
00161$:
	ld	a,-20 (ix)
	sub	a, #0x04
	jp	NC,00164$
;src/Map.c:116: currentPos.x=(*(lastStackItem+cellStack)).x;
	ld	hl,#0x0004
	add	hl,sp
	ld	c,l
	ld	b,h
	pop	hl
	push	hl
	add	hl, hl
	ld	iy,#0x1C40
	ex	de,hl
	add	iy, de
	ld	a, 0 (iy)
	ld	(bc),a
;src/Map.c:117: currentPos.y=(*(lastStackItem+cellStack)).y;
	ld	c,1 (iy)
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	(hl),c
;src/Map.c:118: --lastStackItem;
	pop	hl
	push	hl
	dec	hl
	ex	(sp), hl
;src/Map.c:119: cellType = map[currentPos.x][currentPos.y];
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	l,(hl)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de,#0x0040
	add	hl,de
	ld	e,c
	ld	d,#0x00
	add	hl,de
	ld	c,(hl)
;src/Map.c:121: if(cellType == CELLTYPE_UNDEFINED){
	ld	a,c
	inc	a
	jr	NZ,00141$
;src/Map.c:123: if(cpct_getRandom_lcg_u8()&1){//WALL
	call	_cpct_getRandom_lcg_u8
	bit	0, l
	jr	Z,00138$
;src/Map.c:124: cellType = cpct_getRandom_lcg_u8()&3;
	call	_cpct_getRandom_lcg_u8
	ld	a,l
	and	a, #0x03
	ld	c,a
	jr	00139$
00138$:
;src/Map.c:127: cellType = CELLTYPE_FLOOR;
	ld	c,#0xFE
00139$:
;src/Map.c:130: map[currentPos.x][currentPos.y]=cellType;
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	l,(hl)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de,hl
	ld	hl,#0x0040
	add	hl,de
	ex	de,hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,de
	ld	(hl),c
;src/Map.c:131: --remainingCells;
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	dec	hl
	ld	-10 (ix),l
	ld	-9 (ix),h
	ld	a,-10 (ix)
	ld	-14 (ix),a
	ld	a,-9 (ix)
	ld	-13 (ix),a
00141$:
;src/Map.c:58: if(currentPos.x>0){
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	a,(hl)
	ld	-1 (ix),a
;src/Map.c:134: if((cellType == CELLTYPE_FLOOR)){
	ld	a,c
	sub	a, #0xFE
	jp	NZ,00159$
;src/Map.c:135: if(currentPos.x>0){
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00145$
;src/Map.c:136: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-1 (ix)
	ld	h,#0x00
	dec	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc,#0x0040
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,bc
	ld	c,(hl)
;src/Map.c:137: if(adjacentType == CELLTYPE_UNDEFINED){
	inc	c
	jr	NZ,00145$
;src/Map.c:139: ++lastStackItem;
	inc	-21 (ix)
	jr	NZ,00342$
	inc	-20 (ix)
00342$:
;src/Map.c:140: (*(cellStack+lastStackItem)).x = currentPos.x-1;
	pop	hl
	push	hl
	add	hl, hl
	ld	bc,#0x1C40
	add	hl,bc
	ld	c,-1 (ix)
	dec	c
	ld	(hl),c
;src/Map.c:141: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	a,(hl)
	ld	(bc),a
00145$:
;src/Map.c:145: if(currentPos.x < (MAP_WIDTH-1)){
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	c,(hl)
	ld	a,c
	sub	a, #0x1F
	jr	NC,00149$
;src/Map.c:147: adjacentType = map[currentPos.x+1][currentPos.y];
	ld	l,c
	ld	h,#0x00
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de,hl
	ld	hl,#0x0040
	add	hl,de
	ex	de,hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,de
	ld	b,(hl)
;src/Map.c:148: if(adjacentType == CELLTYPE_UNDEFINED){
	inc	b
	jr	NZ,00149$
;src/Map.c:151: ++lastStackItem;
	inc	-21 (ix)
	jr	NZ,00345$
	inc	-20 (ix)
00345$:
;src/Map.c:152: (*(cellStack+lastStackItem)).x = currentPos.x+1;
	pop	hl
	push	hl
	add	hl, hl
	ld	de,#0x1C40
	add	hl,de
	inc	c
	ld	(hl),c
;src/Map.c:153: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	a,(hl)
	ld	(bc),a
00149$:
;src/Map.c:59: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	c,(hl)
;src/Map.c:157: if(currentPos.y > 0){
	ld	a,c
	or	a, a
	jr	Z,00153$
;src/Map.c:159: adjacentType = map[currentPos.x][currentPos.y-1];
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	b,(hl)
	ld	l,b
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de,#0x0040
	add	hl,de
	dec	c
	ld	e,c
	ld	d,#0x00
	add	hl,de
	ld	c,(hl)
;src/Map.c:160: if(adjacentType == CELLTYPE_UNDEFINED){
	inc	c
	jr	NZ,00153$
;src/Map.c:163: ++lastStackItem;
	inc	-21 (ix)
	jr	NZ,00348$
	inc	-20 (ix)
00348$:
;src/Map.c:164: (*(cellStack+lastStackItem)).x = currentPos.x;
	pop	hl
	push	hl
	add	hl, hl
	ld	de,#0x1C40
	add	hl,de
	ld	(hl),b
;src/Map.c:165: (*(cellStack+lastStackItem)).y = currentPos.y-1;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	e,(hl)
	dec	e
	ld	a,e
	ld	(bc),a
00153$:
;src/Map.c:59: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	b,(hl)
;src/Map.c:169: if(currentPos.y < (MAP_HEIGHT-1)){
	ld	a,b
	sub	a, #0x1F
	jp	NC,00161$
;src/Map.c:171: adjacentType = map[currentPos.x][currentPos.y+1];
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	c,(hl)
	ld	l,c
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de,#0x0040
	add	hl,de
	inc	b
	ld	e,b
	ld	d,#0x00
	add	hl,de
	ld	b,(hl)
;src/Map.c:172: if(adjacentType == CELLTYPE_UNDEFINED){
	inc	b
	jp	NZ,00161$
;src/Map.c:175: ++lastStackItem;
	inc	-21 (ix)
	jr	NZ,00351$
	inc	-20 (ix)
00351$:
;src/Map.c:176: (*(cellStack+lastStackItem)).x = currentPos.x;
	pop	hl
	push	hl
	add	hl, hl
	ld	de,#0x1C40
	add	hl,de
	ld	(hl),c
;src/Map.c:177: (*(cellStack+lastStackItem)).y = currentPos.y+1;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	a,(hl)
	inc	a
	ld	(bc),a
	jp	00161$
00159$:
;src/Map.c:183: ++wallListCount;
	inc	-6 (ix)
	jr	NZ,00352$
	inc	-5 (ix)
00352$:
	ld	a,-6 (ix)
	ld	-19 (ix),a
	ld	a,-5 (ix)
	ld	-18 (ix),a
;src/Map.c:184: (*(wallList+wallListCount)).x = currentPos.x;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	add	hl, hl
	ld	bc,#0x2040
	add	hl,bc
	ld	a,-1 (ix)
	ld	(hl),a
;src/Map.c:185: (*(wallList+wallListCount)).y = currentPos.y;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	a,(hl)
	ld	(bc),a
	jp	00161$
00171$:
	ld	sp, ix
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
