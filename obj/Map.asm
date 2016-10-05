;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module Map
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _generate_exit_door
	.globl _generate_map
	.globl _get_random_wall
	.globl _cpct_setSeed_lcg_u8
	.globl _cpct_getRandom_lcg_u8
	.globl _cpct_memset
	.globl _rand_seed
	.globl _init_generator
	.globl _generate_level
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
;src/Map.c:14: u8 get_random_wall(){
;	---------------------------------
; Function get_random_wall
; ---------------------------------
_get_random_wall::
;src/Map.c:15: u8 cellType = cpct_getRandom_lcg_u8();
	call	_cpct_getRandom_lcg_u8
;src/Map.c:16: if(cellType&1){
	bit	0, l
	jr	Z,00108$
;src/Map.c:17: return CELLTYPE_WALL1;
	ld	l,#0x81
	ret
00108$:
;src/Map.c:20: if(cellType&3){
	ld	a,l
	and	a, #0x03
	jr	Z,00105$
;src/Map.c:21: return CELLTYPE_WALL2;
	ld	l,#0x82
	ret
00105$:
;src/Map.c:24: if(cellType&5){
	ld	a,l
	and	a, #0x05
	jr	Z,00102$
;src/Map.c:25: return CELLTYPE_WALL3;
	ld	l,#0x83
	ret
00102$:
;src/Map.c:28: return CELLTYPE_WALL4;  
	ld	l,#0x84
	ret
;src/Map.c:34: void generate_map(){
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
;src/Map.c:37: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
	ld	-15 (ix),#0x83
	ld	-14 (ix),#0x03
;src/Map.c:43: u16 wallListCount = 0;
	ld	-17 (ix),#0x00
	ld	-16 (ix),#0x00
;src/Map.c:44: u16 lastStackItem = 0;
	ld	-19 (ix),#0x00
	ld	-18 (ix),#0x00
;src/Map.c:46: (*cellStack).x = (cpct_getRandom_lcg_u8()%(MAP_WIDTH-2))+1; //RANDOM
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
	ld	hl,#0x2940
	ld	(hl),c
;src/Map.c:47: (*cellStack).y = (cpct_getRandom_lcg_u8()%(MAP_HEIGHT-2))+1; //RANDOM
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
	ld	hl,#0x2941
	ld	(hl),c
;src/Map.c:50: *(i8*)&(PLAYER_position.x) = (*cellStack).y;
	ld	-5 (ix),#<(_PLAYER_position)
	ld	-4 (ix),#>(_PLAYER_position)
	ld	l, #0x41
	ld	a,(hl)
	ld	-3 (ix),a
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	a,-3 (ix)
	ld	(hl),a
;src/Map.c:51: *(i8*)&(PLAYER_position.y) = (*cellStack).x;
	ld	-5 (ix),#<((_PLAYER_position + 0x0001))
	ld	-4 (ix),#>((_PLAYER_position + 0x0001))
	ld	hl,#0x2940
	ld	c,(hl)
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	(hl),c
;src/Map.c:53: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
	ld	hl,#0x0400
	push	hl
	ld	a,#0x87
	push	af
	inc	sp
	ld	hl,#0x0040
	push	hl
	call	_cpct_memset
;src/Map.c:55: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
	ld	a,(#0x2940)
	ld	-3 (ix), a
	ld	-5 (ix),a
	ld	-4 (ix),#0x00
	ld	a,#0x05+1
	jr	00315$
00314$:
	sla	-5 (ix)
	rl	-4 (ix)
00315$:
	dec	a
	jr	NZ,00314$
	ld	a,-5 (ix)
	add	a, #0x40
	ld	-5 (ix),a
	ld	a,-4 (ix)
	adc	a, #0x00
	ld	-4 (ix),a
	ld	hl,#0x2941
	ld	c,(hl)
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	b,#0x00
	add	hl, bc
	ld	(hl),#0x00
;src/Map.c:58: for(i=0;i<MAP_WIDTH;++i){
	ld	-13 (ix),#0x00
00167$:
;src/Map.c:59: map[0][i]=get_random_wall();
	ld	a,-13 (ix)
	add	a, #0x40
	ld	-5 (ix),a
	ld	a,#0x00
	adc	a, #0x00
	ld	-4 (ix),a
	call	_get_random_wall
	ld	-3 (ix),l
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	a,-3 (ix)
	ld	(hl),a
;src/Map.c:60: map[MAP_HEIGHT-1][i]=get_random_wall();
	ld	a,-13 (ix)
	add	a, #0x20
	ld	-5 (ix),a
	ld	a,#0x00
	adc	a, #0x04
	ld	-4 (ix),a
	call	_get_random_wall
	ld	c,l
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	(hl),c
;src/Map.c:58: for(i=0;i<MAP_WIDTH;++i){
	inc	-13 (ix)
	ld	a,-13 (ix)
	sub	a, #0x20
	jr	C,00167$
;src/Map.c:63: for(i=1;i<MAP_HEIGHT-1;++i){
	ld	-13 (ix),#0x01
00169$:
;src/Map.c:64: map[i][0]=get_random_wall();
	ld	a,-13 (ix)
	ld	-5 (ix),a
	ld	-4 (ix),#0x00
	ld	a,#0x05+1
	jr	00317$
00316$:
	sla	-5 (ix)
	rl	-4 (ix)
00317$:
	dec	a
	jr	NZ,00316$
	ld	a,-5 (ix)
	add	a, #0x40
	ld	-2 (ix),a
	ld	a,-4 (ix)
	adc	a, #0x00
	ld	-1 (ix),a
	call	_get_random_wall
	ld	-3 (ix),l
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,-3 (ix)
	ld	(hl),a
;src/Map.c:65: map[i][MAP_WIDTH-1]=get_random_wall();
	ld	a,-5 (ix)
	add	a, #0x40
	ld	-2 (ix),a
	ld	a,-4 (ix)
	adc	a, #0x00
	ld	-1 (ix),a
	ld	a,-2 (ix)
	add	a, #0x1F
	ld	c,a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	b,a
	push	bc
	call	_get_random_wall
	ld	a,l
	pop	bc
	ld	(bc),a
;src/Map.c:63: for(i=1;i<MAP_HEIGHT-1;++i){
	inc	-13 (ix)
	ld	a,-13 (ix)
	sub	a, #0x1F
	jr	C,00169$
;src/Map.c:68: while(remainingCells>0){
	ld	hl,#0x0000
	add	hl,sp
	ld	-2 (ix),l
	ld	-1 (ix),h
00164$:
	ld	a,-14 (ix)
	or	a,-15 (ix)
	jp	Z,00171$
;src/Map.c:69: wallListPosition = wallList+wallListCount;
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	add	hl, hl
	ld	a,l
	add	a, #0x40
	ld	-5 (ix),a
	ld	a,h
	adc	a, #0x2D
	ld	-4 (ix),a
;src/Map.c:70: while(wallListCount<MAP_SIZE){
	ld	c,-17 (ix)
	ld	b,-16 (ix)
00134$:
;src/Map.c:73: currentPos.y = (*wallListPosition).y;
	ld	a,-2 (ix)
	add	a, #0x01
	ld	-7 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-6 (ix),a
;src/Map.c:70: while(wallListCount<MAP_SIZE){
	ld	a,b
	sub	a, #0x04
	jp	NC,00204$
;src/Map.c:72: currentPos.x = (*wallListPosition).x;
	ld	hl,#0x0000
	add	hl,sp
	ex	de,hl
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	a,(hl)
	ld	(de),a
;src/Map.c:73: currentPos.y = (*wallListPosition).y;
	ld	e,-5 (ix)
	ld	d,-4 (ix)
	inc	de
	ld	a,(de)
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	(hl),a
;src/Map.c:75: convertToFloor=0;
	ld	-12 (ix),#0x00
;src/Map.c:76: surroundedByWalls=1;
	ld	-11 (ix),#0x01
;src/Map.c:78: if(currentPos.x>0){
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-3 (ix),a
;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	ld	-10 (ix),a
	ld	a,-3 (ix)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
;src/Map.c:78: if(currentPos.x>0){
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00109$
;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-9 (ix)
	ld	h,-8 (ix)
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
	add	a, -10 (ix)
	ld	l,a
	ld	a,h
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:80: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00106$
;src/Map.c:81: convertToFloor  = 1;
	ld	-12 (ix),#0x01
	jr	00109$
00106$:
;src/Map.c:83: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00109$
;src/Map.c:84: surroundedByWalls = 0;
	ld	-11 (ix),#0x00
00109$:
;src/Map.c:87: if(currentPos.x < (MAP_WIDTH-1)){
	ld	a,-3 (ix)
	sub	a, #0x1F
	jr	NC,00116$
;src/Map.c:89: adjacentType = map[currentPos.x+1][currentPos.y];
	ld	l,-9 (ix)
	ld	h,-8 (ix)
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
	add	a, -10 (ix)
	ld	l,a
	ld	a,h
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:90: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00113$
;src/Map.c:91: convertToFloor  = 1;
	ld	-12 (ix),#0x01
	jr	00116$
00113$:
;src/Map.c:93: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00116$
;src/Map.c:94: surroundedByWalls = 0;
	ld	-11 (ix),#0x00
00116$:
;src/Map.c:99: adjacentType = map[currentPos.x][currentPos.y-1];
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a,l
	add	a, #0x40
	ld	-9 (ix),a
	ld	a,h
	adc	a, #0x00
	ld	-8 (ix),a
;src/Map.c:97: if(currentPos.y > 0){
	ld	a,-10 (ix)
	or	a, a
	jr	Z,00123$
;src/Map.c:99: adjacentType = map[currentPos.x][currentPos.y-1];
	ld	l,-10 (ix)
	dec	l
	ld	a,-9 (ix)
	add	a, l
	ld	l,a
	ld	a,-8 (ix)
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:100: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00120$
;src/Map.c:101: convertToFloor  = 1;
	ld	-12 (ix),#0x01
	jr	00123$
00120$:
;src/Map.c:103: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00123$
;src/Map.c:104: surroundedByWalls = 0;
	ld	-11 (ix),#0x00
00123$:
;src/Map.c:107: if(currentPos.y < (MAP_HEIGHT-1)){
	ld	a,-10 (ix)
	sub	a, #0x1F
	jr	NC,00130$
;src/Map.c:109: adjacentType = map[currentPos.x][currentPos.y+1];
	ld	l,-10 (ix)
	inc	l
	ld	a,-9 (ix)
	add	a, l
	ld	l,a
	ld	a,-8 (ix)
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:110: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00127$
;src/Map.c:111: convertToFloor  = 1;
	ld	-12 (ix),#0x01
	jr	00130$
00127$:
;src/Map.c:113: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00130$
;src/Map.c:114: surroundedByWalls = 0;
	ld	-11 (ix),#0x00
00130$:
;src/Map.c:118: (*wallListPosition).x = (*(wallList+wallListCount)).x;
	ld	l, c
	ld	h, b
	add	hl, hl
	ld	iy,#0x2D40
	push	bc
	ld	c, l
	ld	b, h
	add	iy, bc
	pop	bc
	ld	a, 0 (iy)
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	(hl),a
;src/Map.c:119: (*wallListPosition).y = (*(wallList+wallListCount)).y;
	push	iy
	pop	hl
	inc	hl
	ld	a,(hl)
	ld	(de),a
;src/Map.c:120: --wallListCount;
	dec	bc
	ld	-17 (ix),c
	ld	-16 (ix),b
;src/Map.c:123: if((convertToFloor)&&(!surroundedByWalls)){
	ld	a,-12 (ix)
	or	a, a
	jr	Z,00132$
	ld	a,-11 (ix)
	or	a, a
	jr	NZ,00132$
;src/Map.c:124: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
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
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,bc
	ld	(hl),#0x00
;src/Map.c:126: ++lastStackItem;
	inc	-19 (ix)
	jr	NZ,00326$
	inc	-18 (ix)
00326$:
;src/Map.c:127: (*(cellStack+lastStackItem)).x = currentPos.x;
	pop	bc
	pop	hl
	push	hl
	push	bc
	add	hl, hl
	ld	bc, #0x2940
	add	hl,bc
	ld	c, l
	ld	b, h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	(bc),a
;src/Map.c:128: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	bc
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	ld	(bc),a
;src/Map.c:131: break;
	jr	00204$
00132$:
;src/Map.c:133: --wallListPosition;
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	dec	hl
	dec	hl
	ld	-5 (ix),l
	ld	-4 (ix),h
	jp	00134$
;src/Map.c:135: while(lastStackItem<MAP_SIZE){
00204$:
	ld	a,-15 (ix)
	ld	-9 (ix),a
	ld	a,-14 (ix)
	ld	-8 (ix),a
	ld	a,-17 (ix)
	ld	-5 (ix),a
	ld	a,-16 (ix)
	ld	-4 (ix),a
00161$:
	ld	a,-18 (ix)
	sub	a, #0x04
	jp	NC,00164$
;src/Map.c:136: currentPos.x=(*(lastStackItem+cellStack)).x;
	ld	hl,#0x0000
	add	hl,sp
	ld	c,l
	ld	b,h
	pop	de
	pop	hl
	push	hl
	push	de
	add	hl, hl
	ld	iy,#0x2940
	ex	de,hl
	add	iy, de
	ld	a, 0 (iy)
	ld	(bc),a
;src/Map.c:137: currentPos.y=(*(lastStackItem+cellStack)).y;
	ld	c,1 (iy)
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	(hl),c
;src/Map.c:138: --lastStackItem;
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	dec	hl
	ld	-19 (ix),l
	ld	-18 (ix),h
;src/Map.c:139: cellType = map[currentPos.x][currentPos.y];
	ld	l,-2 (ix)
	ld	h,-1 (ix)
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
;src/Map.c:141: if(cellType == CELLTYPE_UNDEFINED){
	ld	a,c
	sub	a, #0x87
	jr	NZ,00141$
;src/Map.c:143: if(cpct_getRandom_lcg_u8()&1){//WALL
	call	_cpct_getRandom_lcg_u8
	bit	0, l
	jr	Z,00138$
;src/Map.c:144: cellType = get_random_wall();
	call	_get_random_wall
	ld	c,l
	jr	00139$
00138$:
;src/Map.c:147: cellType = CELLTYPE_FLOOR;
	ld	c,#0x00
00139$:
;src/Map.c:149: map[currentPos.x][currentPos.y]=cellType;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
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
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,de
	ld	(hl),c
;src/Map.c:150: --remainingCells;
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	dec	hl
	ld	-9 (ix),l
	ld	-8 (ix),h
	ld	a,-9 (ix)
	ld	-15 (ix),a
	ld	a,-8 (ix)
	ld	-14 (ix),a
00141$:
;src/Map.c:78: if(currentPos.x>0){
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-10 (ix),a
;src/Map.c:153: if((cellType == CELLTYPE_FLOOR)){
	ld	a,c
	or	a, a
	jp	NZ,00159$
;src/Map.c:154: if(currentPos.x>0){
	ld	a,-10 (ix)
	or	a, a
	jr	Z,00145$
;src/Map.c:155: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-10 (ix)
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
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
;src/Map.c:156: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jr	NZ,00145$
;src/Map.c:158: ++lastStackItem;
	inc	-19 (ix)
	jr	NZ,00332$
	inc	-18 (ix)
00332$:
;src/Map.c:159: (*(cellStack+lastStackItem)).x = currentPos.x-1;
	pop	bc
	pop	hl
	push	hl
	push	bc
	add	hl, hl
	ld	bc,#0x2940
	add	hl,bc
	ld	c,-10 (ix)
	dec	c
	ld	(hl),c
;src/Map.c:160: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	ld	(bc),a
00145$:
;src/Map.c:164: if(currentPos.x < (MAP_WIDTH-1)){
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	c,(hl)
	ld	a,c
	sub	a, #0x1F
	jr	NC,00149$
;src/Map.c:166: adjacentType = map[currentPos.x+1][currentPos.y];
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
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
;src/Map.c:167: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jr	NZ,00149$
;src/Map.c:170: ++lastStackItem;
	inc	-19 (ix)
	jr	NZ,00335$
	inc	-18 (ix)
00335$:
;src/Map.c:171: (*(cellStack+lastStackItem)).x = currentPos.x+1;
	pop	de
	pop	hl
	push	hl
	push	de
	add	hl, hl
	ld	de,#0x2940
	add	hl,de
	inc	c
	ld	(hl),c
;src/Map.c:172: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	ld	(bc),a
00149$:
;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	c,(hl)
;src/Map.c:176: if(currentPos.y > 0){
	ld	a,c
	or	a, a
	jr	Z,00153$
;src/Map.c:178: adjacentType = map[currentPos.x][currentPos.y-1];
	ld	l,-2 (ix)
	ld	h,-1 (ix)
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
	ld	a,(hl)
;src/Map.c:179: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jr	NZ,00153$
;src/Map.c:182: ++lastStackItem;
	inc	-19 (ix)
	jr	NZ,00338$
	inc	-18 (ix)
00338$:
;src/Map.c:183: (*(cellStack+lastStackItem)).x = currentPos.x;
	pop	de
	pop	hl
	push	hl
	push	de
	add	hl, hl
	ld	de,#0x2940
	add	hl,de
	ld	(hl),b
;src/Map.c:184: (*(cellStack+lastStackItem)).y = currentPos.y-1;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	e,(hl)
	dec	e
	ld	a,e
	ld	(bc),a
00153$:
;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	b,(hl)
;src/Map.c:188: if(currentPos.y < (MAP_HEIGHT-1)){
	ld	a,b
	sub	a, #0x1F
	jp	NC,00161$
;src/Map.c:190: adjacentType = map[currentPos.x][currentPos.y+1];
	ld	l,-2 (ix)
	ld	h,-1 (ix)
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
	ld	a,(hl)
;src/Map.c:191: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jp	NZ,00161$
;src/Map.c:194: ++lastStackItem;
	inc	-19 (ix)
	jr	NZ,00341$
	inc	-18 (ix)
00341$:
;src/Map.c:195: (*(cellStack+lastStackItem)).x = currentPos.x;
	pop	de
	pop	hl
	push	hl
	push	de
	add	hl, hl
	ld	de,#0x2940
	add	hl,de
	ld	(hl),c
;src/Map.c:196: (*(cellStack+lastStackItem)).y = currentPos.y+1;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	inc	a
	ld	(bc),a
	jp	00161$
00159$:
;src/Map.c:202: ++wallListCount;
	inc	-5 (ix)
	jr	NZ,00342$
	inc	-4 (ix)
00342$:
	ld	a,-5 (ix)
	ld	-17 (ix),a
	ld	a,-4 (ix)
	ld	-16 (ix),a
;src/Map.c:203: (*(wallList+wallListCount)).x = currentPos.x;
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	add	hl, hl
	ld	bc,#0x2D40
	add	hl,bc
	ld	a,-10 (ix)
	ld	(hl),a
;src/Map.c:204: (*(wallList+wallListCount)).y = currentPos.y;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	ld	(bc),a
	jp	00161$
00171$:
	ld	sp, ix
	pop	ix
	ret
;src/Map.c:210: void generate_exit_door(){
;	---------------------------------
; Function generate_exit_door
; ---------------------------------
_generate_exit_door::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-7
	add	hl,sp
	ld	sp,hl
;src/Map.c:211: u8 x=(cpct_getRandom_lcg_u8()%32);
	call	_cpct_getRandom_lcg_u8
	ld	a,l
	and	a, #0x1F
	ld	c,a
;src/Map.c:212: u8 y=(cpct_getRandom_lcg_u8()%32);
	push	bc
	call	_cpct_getRandom_lcg_u8
	pop	bc
	ld	a,l
	and	a, #0x1F
	ld	e,a
;src/Map.c:213: u8 door_not_positioned=1;
	ld	-3 (ix),#0x01
;src/Map.c:220: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
	ld	b,#0x00
	ld	hl,#0x0040
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	l,e
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Map.c:225: lastVal = (position-1);
	ld	e,c
	ld	d,b
	dec	de
;src/Map.c:226: nextVal = (position+1);
	push	bc
	pop	iy
	inc	iy
;src/Map.c:227: topVal = (position-MAP_WIDTH);
	ld	a,c
	add	a,#0xE0
	ld	-7 (ix),a
	ld	a,b
	adc	a,#0xFF
	ld	-6 (ix),a
;src/Map.c:228: bottomVal = (position+MAP_WIDTH);
	ld	hl,#0x0020
	add	hl,bc
	ld	-5 (ix),l
	ld	-4 (ix),h
;src/Map.c:230: while(door_not_positioned){
00126$:
	ld	a,-3 (ix)
	or	a, a
	jp	Z,00129$
;src/Map.c:231: if((*position)!=CELLTYPE_FLOOR){
	ld	a,(bc)
	or	a, a
	jp	Z,00123$
;src/Map.c:232: if(((*lastVal)!=CELLTYPE_FLOOR) && ((*nextVal)!=CELLTYPE_FLOOR)){
	ld	a,(de)
	ld	-1 (ix),a
;src/Map.c:233: if(((*topVal)!=CELLTYPE_FLOOR) && ((*bottomVal)==CELLTYPE_FLOOR)){
	pop	hl
	push	hl
	ld	a,(hl)
	ld	-2 (ix),a
;src/Map.c:232: if(((*lastVal)!=CELLTYPE_FLOOR) && ((*nextVal)!=CELLTYPE_FLOOR)){
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00119$
	ld	a, 0 (iy)
	or	a, a
	jr	Z,00119$
;src/Map.c:233: if(((*topVal)!=CELLTYPE_FLOOR) && ((*bottomVal)==CELLTYPE_FLOOR)){
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	l,(hl)
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00105$
	ld	a,l
	or	a, a
	jr	NZ,00105$
;src/Map.c:234: door_not_positioned=0;
	ld	-3 (ix),#0x00
;src/Map.c:235: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
	jr	00123$
00105$:
;src/Map.c:237: else if(((*bottomVal)!=CELLTYPE_FLOOR) && ((*topVal)==CELLTYPE_FLOOR)){
	ld	a,l
	or	a, a
	jr	Z,00123$
	ld	a,-2 (ix)
	or	a, a
	jr	NZ,00123$
;src/Map.c:238: door_not_positioned=0;
	ld	-3 (ix),#0x00
;src/Map.c:239: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
	jr	00123$
00119$:
;src/Map.c:242: else if(((*topVal)!=CELLTYPE_FLOOR) && ((*bottomVal)!=CELLTYPE_FLOOR)){
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00123$
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	a,(hl)
	or	a, a
	jr	Z,00123$
;src/Map.c:232: if(((*lastVal)!=CELLTYPE_FLOOR) && ((*nextVal)!=CELLTYPE_FLOOR)){
	ld	l, 0 (iy)
;src/Map.c:243: if(((*lastVal)!=CELLTYPE_FLOOR) && ((*nextVal)==CELLTYPE_FLOOR)){
	ld	a,-1 (ix)
	or	a, a
	jr	Z,00112$
	ld	a,l
	or	a, a
	jr	NZ,00112$
;src/Map.c:244: door_not_positioned=0;
	ld	-3 (ix),#0x00
;src/Map.c:245: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
	jr	00123$
00112$:
;src/Map.c:247: else if(((*nextVal)!=CELLTYPE_FLOOR) && ((*lastVal)==CELLTYPE_FLOOR)){
	ld	a,l
	or	a, a
	jr	Z,00123$
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00123$
;src/Map.c:248: door_not_positioned=0;
	ld	-3 (ix),#0x00
;src/Map.c:249: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
00123$:
;src/Map.c:253: ++position;
	inc	bc
;src/Map.c:254: ++lastVal;
	inc	de
;src/Map.c:255: ++nextVal;
	inc	iy
;src/Map.c:256: ++topVal;
	inc	-7 (ix)
	jr	NZ,00195$
	inc	-6 (ix)
00195$:
;src/Map.c:257: ++bottomVal;
	inc	-5 (ix)
	jr	NZ,00196$
	inc	-4 (ix)
00196$:
;src/Map.c:258: if(position>END_OF_MAP_MEM){
	ld	l, c
	ld	h, b
	ld	a,#0x40
	cp	a, l
	ld	a,#0x04
	sbc	a, h
	jp	NC,00126$
;src/Map.c:259: position = MAP_MEM;
	ld	bc,#0x0040
;src/Map.c:260: lastVal = (position-1);
	ld	de,#0x003F
;src/Map.c:261: nextVal = (position+1);
	ld	iy,#0x0041
;src/Map.c:262: topVal = (position-MAP_WIDTH);
	ld	hl,#0x0020
	ex	(sp), hl
;src/Map.c:263: bottomVal = (position+MAP_WIDTH);
	ld	-5 (ix),#0x60
	ld	-4 (ix),#0x00
	jp	00126$
00129$:
	ld	sp, ix
	pop	ix
	ret
;src/Map.c:269: void generate_level(){
;	---------------------------------
; Function generate_level
; ---------------------------------
_generate_level::
;src/Map.c:270: generate_map();
	call	_generate_map
;src/Map.c:271: generate_exit_door();
	jp  _generate_exit_door
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
