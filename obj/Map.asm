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
	.globl _level_get_level
	.globl _cpct_setSeed_lcg_u8
	.globl _cpct_getRandom_lcg_u8
	.globl _cpct_memset
	.globl _rand_seed
	.globl _map_get_seed
	.globl _generate_level
	.globl _generate_level_with_seed
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
_rand_seed::
	.ds 1
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
;src/Map.c:14: u8 map_get_seed(){
;	---------------------------------
; Function map_get_seed
; ---------------------------------
_map_get_seed::
;src/Map.c:15: return rand_seed;
	ld	iy,#_rand_seed
	ld	l,0 (iy)
	ret
;src/Map.c:18: u8 get_random_wall(){
;	---------------------------------
; Function get_random_wall
; ---------------------------------
_get_random_wall::
;src/Map.c:19: u8 cellType = cpct_getRandom_lcg_u8();
	call	_cpct_getRandom_lcg_u8
;src/Map.c:20: if(cellType&1){
	bit	0, l
	jr	Z,00108$
;src/Map.c:21: return CELLTYPE_WALL1;
	ld	l,#0x81
	ret
00108$:
;src/Map.c:24: if(cellType&3){
	ld	a,l
	and	a, #0x03
	jr	Z,00105$
;src/Map.c:25: return CELLTYPE_WALL2;
	ld	l,#0x82
	ret
00105$:
;src/Map.c:28: if(cellType&5){
	ld	a,l
	and	a, #0x05
	jr	Z,00102$
;src/Map.c:29: return CELLTYPE_WALL3;
	ld	l,#0x83
	ret
00102$:
;src/Map.c:32: return CELLTYPE_WALL4;  
	ld	l,#0x84
	ret
;src/Map.c:38: void generate_map(){
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
;src/Map.c:41: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
	ld	-12 (ix),#0x83
	ld	-11 (ix),#0x03
;src/Map.c:47: u16 wallListCount = 0;
	ld	-19 (ix),#0x00
	ld	-18 (ix),#0x00
;src/Map.c:48: u16 lastStackItem = 0;
	ld	hl,#0x0000
	ex	(sp), hl
;src/Map.c:50: cpct_memset (GENERATOR_DATA_PTR, 0, 4096);
	ld	hl,#0x1000
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	h, #0x64
	push	hl
	call	_cpct_memset
;src/Map.c:52: (*cellStack).x = (cpct_getRandom_lcg_u8()%(MAP_WIDTH-2))+1; //RANDOM
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
	ld	hl,#0x6400
	ld	(hl),c
;src/Map.c:53: (*cellStack).y = (cpct_getRandom_lcg_u8()%(MAP_HEIGHT-2))+1; //RANDOM
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
	ld	hl,#0x6401
	ld	(hl),c
;src/Map.c:56: *(i8*)&(PLAYER_position.x) = (*cellStack).y;
	ld	-5 (ix),#<(_PLAYER_position)
	ld	-4 (ix),#>(_PLAYER_position)
	ld	l, #0x01
	ld	a,(hl)
	ld	-3 (ix),a
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	a,-3 (ix)
	ld	(hl),a
;src/Map.c:57: *(i8*)&(PLAYER_position.y) = (*cellStack).x;
	ld	-5 (ix),#<((_PLAYER_position + 0x0001))
	ld	-4 (ix),#>((_PLAYER_position + 0x0001))
	ld	hl,#0x6400
	ld	c,(hl)
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	(hl),c
;src/Map.c:59: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
	ld	hl,#0x0400
	push	hl
	ld	a,#0x87
	push	af
	inc	sp
	ld	h, #0x60
	push	hl
	call	_cpct_memset
;src/Map.c:62: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
	ld	a,(#0x6400)
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
	add	a, #0x00
	ld	-5 (ix),a
	ld	a,-4 (ix)
	adc	a, #0x60
	ld	-4 (ix),a
	ld	hl,#0x6401
	ld	c,(hl)
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	b,#0x00
	add	hl, bc
	ld	(hl),#0x00
;src/Map.c:65: for(i=0;i<MAP_WIDTH;++i){
	ld	c,#0x00
00167$:
;src/Map.c:66: map[0][i]=CELLTYPE_WALL1;//get_random_wall();
	ld	hl,#0x6000
	ld	b,#0x00
	add	hl, bc
	ld	(hl),#0x81
;src/Map.c:67: map[MAP_HEIGHT-1][i]=CELLTYPE_WALL1;//get_random_wall();
	ld	hl,#0x63E0
	ld	b,#0x00
	add	hl, bc
	ld	(hl),#0x81
;src/Map.c:65: for(i=0;i<MAP_WIDTH;++i){
	inc	c
	ld	a,c
	sub	a, #0x20
	jr	C,00167$
;src/Map.c:70: for(i=1;i<MAP_HEIGHT-1;++i){
	ld	-14 (ix),#0x01
00169$:
;src/Map.c:71: map[i][0]=CELLTYPE_WALL1;//get_random_wall();
	ld	a,-14 (ix)
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
	add	a, #0x00
	ld	-2 (ix),a
	ld	a,-4 (ix)
	adc	a, #0x60
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),#0x81
;src/Map.c:72: map[i][MAP_WIDTH-1]=CELLTYPE_WALL1;//get_random_wall();
	ld	a,-5 (ix)
	add	a, #0x00
	ld	-2 (ix),a
	ld	a,-4 (ix)
	adc	a, #0x60
	ld	-1 (ix),a
	ld	a,-2 (ix)
	add	a, #0x1F
	ld	-2 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),#0x81
;src/Map.c:70: for(i=1;i<MAP_HEIGHT-1;++i){
	inc	-14 (ix)
	ld	a,-14 (ix)
	sub	a, #0x1F
	jr	C,00169$
;src/Map.c:75: while(remainingCells>0){
	ld	hl,#0x0004
	add	hl,sp
	ld	-2 (ix),l
	ld	-1 (ix),h
00164$:
	ld	a,-11 (ix)
	or	a,-12 (ix)
	jp	Z,00171$
;src/Map.c:76: wallListPosition = wallList+wallListCount;
	pop	bc
	pop	hl
	push	hl
	push	bc
	add	hl, hl
	ld	a,l
	add	a, #0x00
	ld	-5 (ix),a
	ld	a,h
	adc	a, #0x68
	ld	-4 (ix),a
;src/Map.c:77: while(wallListCount<MAP_SIZE){
	pop	de
	pop	bc
	push	bc
	push	de
00134$:
;src/Map.c:80: currentPos.y = (*wallListPosition).y;
	ld	a,-2 (ix)
	add	a, #0x01
	ld	-7 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-6 (ix),a
;src/Map.c:77: while(wallListCount<MAP_SIZE){
	ld	a,b
	sub	a, #0x04
	jp	NC,00204$
;src/Map.c:79: currentPos.x = (*wallListPosition).x;
	ld	hl,#0x0004
	add	hl,sp
	ex	de,hl
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	a,(hl)
	ld	(de),a
;src/Map.c:80: currentPos.y = (*wallListPosition).y;
	ld	e,-5 (ix)
	ld	d,-4 (ix)
	inc	de
	ld	a,(de)
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	(hl),a
;src/Map.c:82: convertToFloor=0;
	ld	-13 (ix),#0x00
;src/Map.c:83: surroundedByWalls=1;
	ld	-15 (ix),#0x01
;src/Map.c:85: if(currentPos.x>0){
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-3 (ix),a
;src/Map.c:86: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	ld	-8 (ix),a
	ld	a,-3 (ix)
	ld	-10 (ix),a
	ld	-9 (ix),#0x00
;src/Map.c:85: if(currentPos.x>0){
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00109$
;src/Map.c:86: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	dec	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	de
	ld	de,#0x6000
	add	hl, de
	pop	de
	ld	a,l
	add	a, -8 (ix)
	ld	l,a
	ld	a,h
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:87: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00106$
;src/Map.c:88: convertToFloor  = 1;
	ld	-13 (ix),#0x01
	jr	00109$
00106$:
;src/Map.c:90: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00109$
;src/Map.c:91: surroundedByWalls = 0;
	ld	-15 (ix),#0x00
00109$:
;src/Map.c:94: if(currentPos.x < (MAP_WIDTH-1)){
	ld	a,-3 (ix)
	sub	a, #0x1F
	jr	NC,00116$
;src/Map.c:96: adjacentType = map[currentPos.x+1][currentPos.y];
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	de
	ld	de,#0x6000
	add	hl, de
	pop	de
	ld	a,l
	add	a, -8 (ix)
	ld	l,a
	ld	a,h
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:97: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00113$
;src/Map.c:98: convertToFloor  = 1;
	ld	-13 (ix),#0x01
	jr	00116$
00113$:
;src/Map.c:100: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00116$
;src/Map.c:101: surroundedByWalls = 0;
	ld	-15 (ix),#0x00
00116$:
;src/Map.c:106: adjacentType = map[currentPos.x][currentPos.y-1];
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a,l
	add	a, #0x00
	ld	-10 (ix),a
	ld	a,h
	adc	a, #0x60
	ld	-9 (ix),a
;src/Map.c:104: if(currentPos.y > 0){
	ld	a,-8 (ix)
	or	a, a
	jr	Z,00123$
;src/Map.c:106: adjacentType = map[currentPos.x][currentPos.y-1];
	ld	l,-8 (ix)
	dec	l
	ld	a,-10 (ix)
	add	a, l
	ld	l,a
	ld	a,-9 (ix)
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:107: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00120$
;src/Map.c:108: convertToFloor  = 1;
	ld	-13 (ix),#0x01
	jr	00123$
00120$:
;src/Map.c:110: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00123$
;src/Map.c:111: surroundedByWalls = 0;
	ld	-15 (ix),#0x00
00123$:
;src/Map.c:114: if(currentPos.y < (MAP_HEIGHT-1)){
	ld	a,-8 (ix)
	sub	a, #0x1F
	jr	NC,00130$
;src/Map.c:116: adjacentType = map[currentPos.x][currentPos.y+1];
	ld	l,-8 (ix)
	inc	l
	ld	a,-10 (ix)
	add	a, l
	ld	l,a
	ld	a,-9 (ix)
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:117: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00127$
;src/Map.c:118: convertToFloor  = 1;
	ld	-13 (ix),#0x01
	jr	00130$
00127$:
;src/Map.c:120: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00130$
;src/Map.c:121: surroundedByWalls = 0;
	ld	-15 (ix),#0x00
00130$:
;src/Map.c:125: (*wallListPosition).x = (*(wallList+wallListCount)).x;
	ld	l, c
	ld	h, b
	add	hl, hl
	ld	iy,#0x6800
	push	bc
	ld	c, l
	ld	b, h
	add	iy, bc
	pop	bc
	ld	a, 0 (iy)
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	(hl),a
;src/Map.c:126: (*wallListPosition).y = (*(wallList+wallListCount)).y;
	push	iy
	pop	hl
	inc	hl
	ld	a,(hl)
	ld	(de),a
;src/Map.c:127: --wallListCount;
	dec	bc
	ld	-19 (ix),c
	ld	-18 (ix),b
;src/Map.c:130: if((convertToFloor)&&(!surroundedByWalls)){
	ld	a,-13 (ix)
	or	a, a
	jr	Z,00132$
	ld	a,-15 (ix)
	or	a, a
	jr	NZ,00132$
;src/Map.c:131: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	l,(hl)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc,#0x6000
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,bc
	ld	(hl),#0x00
;src/Map.c:133: ++lastStackItem;
	inc	-21 (ix)
	jr	NZ,00326$
	inc	-20 (ix)
00326$:
;src/Map.c:134: (*(cellStack+lastStackItem)).x = currentPos.x;
	pop	hl
	push	hl
	add	hl, hl
	ld	c, l
	ld	a,h
	add	a,#0x64
	ld	b,a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	(bc),a
;src/Map.c:135: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	bc
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	ld	(bc),a
;src/Map.c:138: break;
	jr	00204$
00132$:
;src/Map.c:140: --wallListPosition;
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	dec	hl
	dec	hl
	ld	-5 (ix),l
	ld	-4 (ix),h
	jp	00134$
;src/Map.c:142: while(lastStackItem<MAP_SIZE){
00204$:
	ld	a,-12 (ix)
	ld	-10 (ix),a
	ld	a,-11 (ix)
	ld	-9 (ix),a
	ld	a,-19 (ix)
	ld	-5 (ix),a
	ld	a,-18 (ix)
	ld	-4 (ix),a
00161$:
	ld	a,-20 (ix)
	sub	a, #0x04
	jp	NC,00164$
;src/Map.c:143: currentPos.x=(*(lastStackItem+cellStack)).x;
	ld	hl,#0x0004
	add	hl,sp
	ld	c,l
	ld	b,h
	pop	hl
	push	hl
	add	hl, hl
	ld	iy,#0x6400
	ex	de,hl
	add	iy, de
	ld	a, 0 (iy)
	ld	(bc),a
;src/Map.c:144: currentPos.y=(*(lastStackItem+cellStack)).y;
	ld	c,1 (iy)
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	(hl),c
;src/Map.c:145: --lastStackItem;
	pop	hl
	push	hl
	dec	hl
	ex	(sp), hl
;src/Map.c:146: cellType = map[currentPos.x][currentPos.y];
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	l,(hl)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de,#0x6000
	add	hl,de
	ld	e,c
	ld	d,#0x00
	add	hl,de
	ld	c,(hl)
;src/Map.c:148: if(cellType == CELLTYPE_UNDEFINED){
	ld	a,c
	sub	a, #0x87
	jr	NZ,00141$
;src/Map.c:150: if(cpct_getRandom_lcg_u8()&1){//WALL
	call	_cpct_getRandom_lcg_u8
	bit	0, l
	jr	Z,00138$
;src/Map.c:151: cellType = get_random_wall();
	call	_get_random_wall
	ld	c,l
	jr	00139$
00138$:
;src/Map.c:154: cellType = CELLTYPE_FLOOR;
	ld	c,#0x00
00139$:
;src/Map.c:156: map[currentPos.x][currentPos.y]=cellType;
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
	ld	hl,#0x6000
	add	hl,de
	ex	de,hl
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,de
	ld	(hl),c
;src/Map.c:157: --remainingCells;
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	dec	hl
	ld	-10 (ix),l
	ld	-9 (ix),h
	ld	a,-10 (ix)
	ld	-12 (ix),a
	ld	a,-9 (ix)
	ld	-11 (ix),a
00141$:
;src/Map.c:85: if(currentPos.x>0){
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-8 (ix),a
;src/Map.c:160: if((cellType == CELLTYPE_FLOOR)){
	ld	a,c
	or	a, a
	jp	NZ,00159$
;src/Map.c:161: if(currentPos.x>0){
	ld	a,-8 (ix)
	or	a, a
	jr	Z,00145$
;src/Map.c:162: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-8 (ix)
	ld	h,#0x00
	dec	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc,#0x6000
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
;src/Map.c:163: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jr	NZ,00145$
;src/Map.c:165: ++lastStackItem;
	inc	-21 (ix)
	jr	NZ,00332$
	inc	-20 (ix)
00332$:
;src/Map.c:166: (*(cellStack+lastStackItem)).x = currentPos.x-1;
	pop	hl
	push	hl
	add	hl, hl
	ld	bc,#0x6400
	add	hl,bc
	ld	c,-8 (ix)
	dec	c
	ld	(hl),c
;src/Map.c:167: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	ld	(bc),a
00145$:
;src/Map.c:171: if(currentPos.x < (MAP_WIDTH-1)){
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	c,(hl)
	ld	a,c
	sub	a, #0x1F
	jr	NC,00149$
;src/Map.c:173: adjacentType = map[currentPos.x+1][currentPos.y];
	ld	l,c
	ld	h,#0x00
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de,hl
	ld	hl,#0x6000
	add	hl,de
	ex	de,hl
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
;src/Map.c:174: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jr	NZ,00149$
;src/Map.c:177: ++lastStackItem;
	inc	-21 (ix)
	jr	NZ,00335$
	inc	-20 (ix)
00335$:
;src/Map.c:178: (*(cellStack+lastStackItem)).x = currentPos.x+1;
	pop	hl
	push	hl
	add	hl, hl
	ld	de,#0x6400
	add	hl,de
	inc	c
	ld	(hl),c
;src/Map.c:179: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	ld	(bc),a
00149$:
;src/Map.c:86: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	c,(hl)
;src/Map.c:183: if(currentPos.y > 0){
	ld	a,c
	or	a, a
	jr	Z,00153$
;src/Map.c:185: adjacentType = map[currentPos.x][currentPos.y-1];
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
	ld	de,#0x6000
	add	hl,de
	dec	c
	ld	e,c
	ld	d,#0x00
	add	hl,de
	ld	a,(hl)
;src/Map.c:186: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jr	NZ,00153$
;src/Map.c:189: ++lastStackItem;
	inc	-21 (ix)
	jr	NZ,00338$
	inc	-20 (ix)
00338$:
;src/Map.c:190: (*(cellStack+lastStackItem)).x = currentPos.x;
	pop	hl
	push	hl
	add	hl, hl
	ld	de,#0x6400
	add	hl,de
	ld	(hl),b
;src/Map.c:191: (*(cellStack+lastStackItem)).y = currentPos.y-1;
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
;src/Map.c:86: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	b,(hl)
;src/Map.c:195: if(currentPos.y < (MAP_HEIGHT-1)){
	ld	a,b
	sub	a, #0x1F
	jp	NC,00161$
;src/Map.c:197: adjacentType = map[currentPos.x][currentPos.y+1];
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
	ld	de,#0x6000
	add	hl,de
	inc	b
	ld	e,b
	ld	d,#0x00
	add	hl,de
	ld	a,(hl)
;src/Map.c:198: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jp	NZ,00161$
;src/Map.c:201: ++lastStackItem;
	inc	-21 (ix)
	jr	NZ,00341$
	inc	-20 (ix)
00341$:
;src/Map.c:202: (*(cellStack+lastStackItem)).x = currentPos.x;
	pop	hl
	push	hl
	add	hl, hl
	ld	de,#0x6400
	add	hl,de
	ld	(hl),c
;src/Map.c:203: (*(cellStack+lastStackItem)).y = currentPos.y+1;
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
;src/Map.c:209: ++wallListCount;
	inc	-5 (ix)
	jr	NZ,00342$
	inc	-4 (ix)
00342$:
	ld	a,-5 (ix)
	ld	-19 (ix),a
	ld	a,-4 (ix)
	ld	-18 (ix),a
;src/Map.c:210: (*(wallList+wallListCount)).x = currentPos.x;
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	add	hl, hl
	ld	bc,#0x6800
	add	hl,bc
	ld	a,-8 (ix)
	ld	(hl),a
;src/Map.c:211: (*(wallList+wallListCount)).y = currentPos.y;
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
;src/Map.c:217: void generate_exit_door(){
;	---------------------------------
; Function generate_exit_door
; ---------------------------------
_generate_exit_door::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-14
	add	hl,sp
	ld	sp,hl
;src/Map.c:218: u8 x=(cpct_getRandom_lcg_u8()%32);
	call	_cpct_getRandom_lcg_u8
	ld	a,l
	and	a, #0x1F
	ld	c,a
;src/Map.c:219: u8 y=(cpct_getRandom_lcg_u8()%32);
	push	bc
	call	_cpct_getRandom_lcg_u8
	pop	bc
	ld	a,l
	and	a, #0x1F
	ld	e,a
;src/Map.c:220: u8 door_not_positioned=1;
	ld	-10 (ix),#0x01
;src/Map.c:227: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
	ld	b,#0x00
	ld	hl,#0x6000
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
;src/Map.c:232: lastVal = (position-1);
	ld	e,c
	ld	d,b
	dec	de
;src/Map.c:233: nextVal = (position+1);
	ld	hl,#0x0001
	add	hl,bc
	ld	-12 (ix),l
	ld	-11 (ix),h
;src/Map.c:234: topVal = (position-MAP_WIDTH);
	ld	a,c
	add	a,#0xE0
	ld	-14 (ix),a
	ld	a,b
	adc	a,#0xFF
	ld	-13 (ix),a
;src/Map.c:235: bottomVal = (position+MAP_WIDTH);
	ld	iy,#0x0020
	add	iy, bc
;src/Map.c:237: while(door_not_positioned){
00138$:
	ld	a,-10 (ix)
	or	a, a
	jp	Z,00141$
;src/Map.c:238: if((*position)!=CELLTYPE_FLOOR){
	ld	a,(bc)
	or	a, a
	jp	Z,00135$
;src/Map.c:239: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
	ld	a,(de)
	ld	-1 (ix),a
	ld	-4 (ix),e
	ld	-3 (ix),d
	ld	a,-12 (ix)
	ld	-6 (ix),a
	ld	a,-11 (ix)
	ld	-5 (ix),a
;src/Map.c:240: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
	pop	hl
	push	hl
	ld	a,(hl)
	ld	-2 (ix),a
	ld	a,-14 (ix)
	ld	-8 (ix),a
	ld	a,-13 (ix)
	ld	-7 (ix),a
	push	iy
	pop	hl
;src/Map.c:239: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
	ld	a,-3 (ix)
	sub	a, #0x60
	ld	a,#0x00
	rla
	ld	-4 (ix),a
	ld	a,-5 (ix)
	sub	a, #0x64
	ld	a,#0x00
	rla
	ld	-6 (ix),a
;src/Map.c:240: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
	ld	a,-7 (ix)
	sub	a, #0x60
	ld	a,#0x00
	rla
	ld	-8 (ix),a
	ld	a,h
	sub	a, #0x64
	ld	a,#0x00
	rla
	ld	-9 (ix),a
;src/Map.c:239: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00133$
	ld	a,-4 (ix)
	or	a, a
	jr	Z,00129$
00133$:
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	ld	a,(hl)
	or	a, a
	jr	NZ,00128$
	bit	0,-6 (ix)
	jr	NZ,00129$
00128$:
;src/Map.c:240: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
	ld	l, 0 (iy)
	ld	a,-2 (ix)
	or	a, a
	jr	NZ,00111$
	ld	a,-8 (ix)
	or	a, a
	jr	Z,00107$
00111$:
	ld	a,l
	or	a, a
	jr	NZ,00107$
	ld	a,-9 (ix)
	or	a, a
	jr	Z,00107$
;src/Map.c:241: door_not_positioned=0;
	ld	-10 (ix),#0x00
;src/Map.c:242: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
	jp	00135$
00107$:
;src/Map.c:244: else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
	ld	a,l
	or	a, a
	jr	NZ,00105$
	ld	a,-9 (ix)
	or	a, a
	jr	NZ,00135$
00105$:
	ld	a,-2 (ix)
	or	a, a
	jr	NZ,00135$
	ld	a,-8 (ix)
	or	a, a
	jr	NZ,00135$
;src/Map.c:245: door_not_positioned=0;
	ld	-10 (ix),#0x00
;src/Map.c:246: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
	jr	00135$
00129$:
;src/Map.c:249: else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
	ld	a,-2 (ix)
	or	a, a
	jr	NZ,00127$
	ld	a,-8 (ix)
	or	a, a
	jr	Z,00135$
00127$:
	ld	a, 0 (iy)
	or	a, a
	jr	NZ,00123$
	ld	a,-9 (ix)
	or	a, a
	jr	NZ,00135$
00123$:
;src/Map.c:239: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	ld	l,(hl)
;src/Map.c:250: if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00122$
	ld	a,-4 (ix)
	or	a, a
	jr	Z,00118$
00122$:
	ld	a,l
	or	a, a
	jr	NZ,00118$
	bit	0,-6 (ix)
	jr	Z,00118$
;src/Map.c:251: door_not_positioned=0;
	ld	-10 (ix),#0x00
;src/Map.c:252: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
	jr	00135$
00118$:
;src/Map.c:254: else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
	ld	a,l
	or	a, a
	jr	NZ,00116$
	bit	0,-6 (ix)
	jr	NZ,00135$
00116$:
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00135$
	ld	a,-4 (ix)
	or	a, a
	jr	NZ,00135$
;src/Map.c:255: door_not_positioned=0;
	ld	-10 (ix),#0x00
;src/Map.c:256: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
00135$:
;src/Map.c:260: ++position;
	inc	bc
;src/Map.c:261: ++lastVal;
	inc	de
;src/Map.c:262: ++nextVal;
	inc	-12 (ix)
	jr	NZ,00223$
	inc	-11 (ix)
00223$:
;src/Map.c:263: ++topVal;
	inc	-14 (ix)
	jr	NZ,00224$
	inc	-13 (ix)
00224$:
;src/Map.c:264: ++bottomVal;
	inc	iy
;src/Map.c:265: if(position==END_OF_MAP_MEM){
	ld	l, c
	ld	h, b
	ld	a,l
	or	a, a
	jp	NZ,00138$
	ld	a,h
	sub	a, #0x64
	jp	NZ,00138$
;src/Map.c:266: position = MAP_MEM;
	ld	bc,#0x6000
;src/Map.c:267: lastVal = (position-1);
	ld	de,#0x5FFF
;src/Map.c:268: nextVal = (position+1);
	ld	-12 (ix),#0x01
	ld	-11 (ix),#0x60
;src/Map.c:269: topVal = (position-MAP_WIDTH);
	ld	hl,#0x5FE0
	ex	(sp), hl
;src/Map.c:270: bottomVal = (position+MAP_WIDTH);
	ld	iy,#0x6020
	jp	00138$
00141$:
	ld	sp, ix
	pop	ix
	ret
;src/Map.c:276: void generate_level(){
;	---------------------------------
; Function generate_level
; ---------------------------------
_generate_level::
;src/Map.c:277: generate_level_with_seed(r_counter);
	ld	a,(_r_counter)
	push	af
	inc	sp
	call	_generate_level_with_seed
	inc	sp
	ret
;src/Map.c:280: void generate_level_with_seed(u8 seed){
;	---------------------------------
; Function generate_level_with_seed
; ---------------------------------
_generate_level_with_seed::
;src/Map.c:282: rand_seed=seed;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	ld	(#_rand_seed + 0),a
;src/Map.c:283: cpct_setSeed_lcg_u8(seed+level_get_level());
	call	_level_get_level
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	add	a, l
	ld	l,a
	call	_cpct_setSeed_lcg_u8
;src/Map.c:285: generate_map();
	call	_generate_map
;src/Map.c:286: generate_exit_door();
	call	_generate_exit_door
;src/Map.c:287: *(u8*)(MAP_MEM + 6 + MAP_WIDTH*5)=0b00000001;
	ld	hl,#0x60A6
	ld	(hl),#0x01
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__rand_seed:
	.db #0x00	; 0
	.area _CABS (ABS)
