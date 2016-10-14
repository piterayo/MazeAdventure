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
	.globl _player_turn_left
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
	ld	hl,#-20
	add	hl,sp
	ld	sp,hl
;src/Map.c:41: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
	ld	-14 (ix),#0x83
	ld	-13 (ix),#0x03
;src/Map.c:47: u16 wallListCount = 0;
	ld	-18 (ix),#0x00
	ld	-17 (ix),#0x00
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
;src/Map.c:55: rotatePlayer = cpct_getRandom_lcg_u8()%4;
	call	_cpct_getRandom_lcg_u8
	ld	a,l
	and	a, #0x03
	ld	c,a
;src/Map.c:56: while(rotatePlayer){
00101$:
	ld	a,c
	or	a, a
	jr	Z,00103$
;src/Map.c:57: player_turn_left();
	push	bc
	call	_player_turn_left
	pop	bc
;src/Map.c:58: --rotatePlayer;
	dec	c
	jr	00101$
00103$:
;src/Map.c:61: *(i8*)&(player_position.x) = (*cellStack).y;
	ld	bc,#_player_position+0
	ld	a,(#0x6401)
	ld	(bc),a
;src/Map.c:62: *(i8*)&(player_position.y) = (*cellStack).x;
	ld	bc,#_player_position+1
	ld	a,(#0x6400)
	ld	(bc),a
;src/Map.c:64: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
	ld	hl,#0x0400
	push	hl
	ld	a,#0x87
	push	af
	inc	sp
	ld	h, #0x60
	push	hl
	call	_cpct_memset
;src/Map.c:67: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
	ld	hl,#0x6400
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
	ld	hl,#0x6401
	ld	l, (hl)
	ld	h,#0x00
	add	hl,bc
	ld	(hl),#0x00
;src/Map.c:70: for(i=0;i<MAP_WIDTH;++i){
	ld	c,#0x00
00170$:
;src/Map.c:71: map[0][i]=CELLTYPE_WALL1;//get_random_wall();
	ld	hl,#0x6000
	ld	b,#0x00
	add	hl, bc
	ld	(hl),#0x81
;src/Map.c:72: map[MAP_HEIGHT-1][i]=CELLTYPE_WALL1;//get_random_wall();
	ld	hl,#0x63E0
	ld	b,#0x00
	add	hl, bc
	ld	(hl),#0x81
;src/Map.c:70: for(i=0;i<MAP_WIDTH;++i){
	inc	c
	ld	a,c
	sub	a, #0x20
	jr	C,00170$
;src/Map.c:75: for(i=1;i<MAP_HEIGHT-1;++i){
	ld	c,#0x01
00172$:
;src/Map.c:76: map[i][0]=CELLTYPE_WALL1;//get_random_wall();
	ld	l,c
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de,hl
	ld	hl,#0x6000
	add	hl,de
	ld	(hl),#0x81
;src/Map.c:77: map[i][MAP_WIDTH-1]=CELLTYPE_WALL1;//get_random_wall();
	ld	hl,#0x6000
	add	hl,de
	ld	de,#0x001F
	add	hl,de
	ld	(hl),#0x81
;src/Map.c:75: for(i=1;i<MAP_HEIGHT-1;++i){
	inc	c
	ld	a,c
	sub	a, #0x1F
	jr	C,00172$
;src/Map.c:80: while(remainingCells>0){
	ld	hl,#0x0004
	add	hl,sp
	ld	-6 (ix),l
	ld	-5 (ix),h
00167$:
	ld	a,-13 (ix)
	or	a,-14 (ix)
	jp	Z,00174$
;src/Map.c:81: wallListPosition = wallList+wallListCount;
	pop	bc
	pop	hl
	push	hl
	push	bc
	add	hl, hl
	ld	a,l
	add	a, #0x00
	ld	-4 (ix),a
	ld	a,h
	adc	a, #0x68
	ld	-3 (ix),a
;src/Map.c:82: while(wallListCount<MAP_SIZE){
	pop	de
	pop	bc
	push	bc
	push	de
00137$:
;src/Map.c:85: currentPos.y = (*wallListPosition).y;
	ld	a,-6 (ix)
	add	a, #0x01
	ld	-2 (ix),a
	ld	a,-5 (ix)
	adc	a, #0x00
	ld	-1 (ix),a
;src/Map.c:82: while(wallListCount<MAP_SIZE){
	ld	a,b
	sub	a, #0x04
	jp	NC,00209$
;src/Map.c:84: currentPos.x = (*wallListPosition).x;
	ld	hl,#0x0004
	add	hl,sp
	ex	de,hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	a,(hl)
	ld	(de),a
;src/Map.c:85: currentPos.y = (*wallListPosition).y;
	ld	e,-4 (ix)
	ld	d,-3 (ix)
	inc	de
	ld	a,(de)
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),a
;src/Map.c:87: convertToFloor=0;
	ld	-11 (ix),#0x00
;src/Map.c:88: surroundedByWalls=1;
	ld	-12 (ix),#0x01
;src/Map.c:90: if(currentPos.x>0){
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	a,(hl)
	ld	-8 (ix),a
;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-7 (ix),a
	ld	a,-8 (ix)
	ld	-10 (ix),a
	ld	-9 (ix),#0x00
;src/Map.c:90: if(currentPos.x>0){
	ld	a,-8 (ix)
	or	a, a
	jr	Z,00112$
;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
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
	add	a, -7 (ix)
	ld	l,a
	ld	a,h
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:92: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00109$
;src/Map.c:93: convertToFloor  = 1;
	ld	-11 (ix),#0x01
	jr	00112$
00109$:
;src/Map.c:95: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00112$
;src/Map.c:96: surroundedByWalls = 0;
	ld	-12 (ix),#0x00
00112$:
;src/Map.c:99: if(currentPos.x < (MAP_WIDTH-1)){
	ld	a,-8 (ix)
	sub	a, #0x1F
	jr	NC,00119$
;src/Map.c:101: adjacentType = map[currentPos.x+1][currentPos.y];
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
	add	a, -7 (ix)
	ld	l,a
	ld	a,h
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:102: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00116$
;src/Map.c:103: convertToFloor  = 1;
	ld	-11 (ix),#0x01
	jr	00119$
00116$:
;src/Map.c:105: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00119$
;src/Map.c:106: surroundedByWalls = 0;
	ld	-12 (ix),#0x00
00119$:
;src/Map.c:111: adjacentType = map[currentPos.x][currentPos.y-1];
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
;src/Map.c:109: if(currentPos.y > 0){
	ld	a,-7 (ix)
	or	a, a
	jr	Z,00126$
;src/Map.c:111: adjacentType = map[currentPos.x][currentPos.y-1];
	ld	l,-7 (ix)
	dec	l
	ld	a,-10 (ix)
	add	a, l
	ld	l,a
	ld	a,-9 (ix)
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:112: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00123$
;src/Map.c:113: convertToFloor  = 1;
	ld	-11 (ix),#0x01
	jr	00126$
00123$:
;src/Map.c:115: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00126$
;src/Map.c:116: surroundedByWalls = 0;
	ld	-12 (ix),#0x00
00126$:
;src/Map.c:119: if(currentPos.y < (MAP_HEIGHT-1)){
	ld	a,-7 (ix)
	sub	a, #0x1F
	jr	NC,00133$
;src/Map.c:121: adjacentType = map[currentPos.x][currentPos.y+1];
	ld	l,-7 (ix)
	inc	l
	ld	a,-10 (ix)
	add	a, l
	ld	l,a
	ld	a,-9 (ix)
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:122: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00130$
;src/Map.c:123: convertToFloor  = 1;
	ld	-11 (ix),#0x01
	jr	00133$
00130$:
;src/Map.c:125: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00133$
;src/Map.c:126: surroundedByWalls = 0;
	ld	-12 (ix),#0x00
00133$:
;src/Map.c:130: (*wallListPosition).x = (*(wallList+wallListCount)).x;
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
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),a
;src/Map.c:131: (*wallListPosition).y = (*(wallList+wallListCount)).y;
	push	iy
	pop	hl
	inc	hl
	ld	a,(hl)
	ld	(de),a
;src/Map.c:132: --wallListCount;
	dec	bc
	ld	-18 (ix),c
	ld	-17 (ix),b
;src/Map.c:135: if((convertToFloor)&&(!surroundedByWalls)){
	ld	a,-11 (ix)
	or	a, a
	jr	Z,00135$
	ld	a,-12 (ix)
	or	a, a
	jr	NZ,00135$
;src/Map.c:136: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
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
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,bc
	ld	(hl),#0x00
;src/Map.c:138: ++lastStackItem;
	inc	-20 (ix)
	jr	NZ,00334$
	inc	-19 (ix)
00334$:
;src/Map.c:139: (*(cellStack+lastStackItem)).x = currentPos.x;
	pop	hl
	push	hl
	add	hl, hl
	ld	c, l
	ld	a,h
	add	a,#0x64
	ld	b,a
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	a,(hl)
	ld	(bc),a
;src/Map.c:140: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	bc
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	(bc),a
;src/Map.c:143: break;
	jr	00209$
00135$:
;src/Map.c:145: --wallListPosition;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	dec	hl
	dec	hl
	ld	-4 (ix),l
	ld	-3 (ix),h
	jp	00137$
;src/Map.c:147: while(lastStackItem<MAP_SIZE){
00209$:
	ld	a,-14 (ix)
	ld	-10 (ix),a
	ld	a,-13 (ix)
	ld	-9 (ix),a
	ld	a,-18 (ix)
	ld	-4 (ix),a
	ld	a,-17 (ix)
	ld	-3 (ix),a
00164$:
	ld	a,-19 (ix)
	sub	a, #0x04
	jp	NC,00167$
;src/Map.c:148: currentPos.x=(*(lastStackItem+cellStack)).x;
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
;src/Map.c:149: currentPos.y=(*(lastStackItem+cellStack)).y;
	ld	c,1 (iy)
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),c
;src/Map.c:150: --lastStackItem;
	pop	hl
	push	hl
	dec	hl
	ex	(sp), hl
;src/Map.c:151: cellType = map[currentPos.x][currentPos.y];
	ld	l,-6 (ix)
	ld	h,-5 (ix)
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
;src/Map.c:153: if(cellType == CELLTYPE_UNDEFINED){
	ld	a,c
	sub	a, #0x87
	jr	NZ,00144$
;src/Map.c:155: if(cpct_getRandom_lcg_u8()&1){//WALL
	call	_cpct_getRandom_lcg_u8
	bit	0, l
	jr	Z,00141$
;src/Map.c:156: cellType = get_random_wall();
	call	_get_random_wall
	ld	c,l
	jr	00142$
00141$:
;src/Map.c:159: cellType = CELLTYPE_FLOOR;
	ld	c,#0x00
00142$:
;src/Map.c:161: map[currentPos.x][currentPos.y]=cellType;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
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
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,de
	ld	(hl),c
;src/Map.c:162: --remainingCells;
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	dec	hl
	ld	-10 (ix),l
	ld	-9 (ix),h
	ld	a,-10 (ix)
	ld	-14 (ix),a
	ld	a,-9 (ix)
	ld	-13 (ix),a
00144$:
;src/Map.c:90: if(currentPos.x>0){
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	a,(hl)
	ld	-7 (ix),a
;src/Map.c:165: if((cellType == CELLTYPE_FLOOR)){
	ld	a,c
	or	a, a
	jp	NZ,00162$
;src/Map.c:166: if(currentPos.x>0){
	ld	a,-7 (ix)
	or	a, a
	jr	Z,00148$
;src/Map.c:167: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-7 (ix)
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
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
;src/Map.c:168: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jr	NZ,00148$
;src/Map.c:170: ++lastStackItem;
	inc	-20 (ix)
	jr	NZ,00340$
	inc	-19 (ix)
00340$:
;src/Map.c:171: (*(cellStack+lastStackItem)).x = currentPos.x-1;
	pop	hl
	push	hl
	add	hl, hl
	ld	bc,#0x6400
	add	hl,bc
	ld	c,-7 (ix)
	dec	c
	ld	(hl),c
;src/Map.c:172: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	(bc),a
00148$:
;src/Map.c:176: if(currentPos.x < (MAP_WIDTH-1)){
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	c,(hl)
	ld	a,c
	sub	a, #0x1F
	jr	NC,00152$
;src/Map.c:178: adjacentType = map[currentPos.x+1][currentPos.y];
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
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
;src/Map.c:179: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jr	NZ,00152$
;src/Map.c:182: ++lastStackItem;
	inc	-20 (ix)
	jr	NZ,00343$
	inc	-19 (ix)
00343$:
;src/Map.c:183: (*(cellStack+lastStackItem)).x = currentPos.x+1;
	pop	hl
	push	hl
	add	hl, hl
	ld	de,#0x6400
	add	hl,de
	inc	c
	ld	(hl),c
;src/Map.c:184: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	(bc),a
00152$:
;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	c,(hl)
;src/Map.c:188: if(currentPos.y > 0){
	ld	a,c
	or	a, a
	jr	Z,00156$
;src/Map.c:190: adjacentType = map[currentPos.x][currentPos.y-1];
	ld	l,-6 (ix)
	ld	h,-5 (ix)
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
;src/Map.c:191: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jr	NZ,00156$
;src/Map.c:194: ++lastStackItem;
	inc	-20 (ix)
	jr	NZ,00346$
	inc	-19 (ix)
00346$:
;src/Map.c:195: (*(cellStack+lastStackItem)).x = currentPos.x;
	pop	hl
	push	hl
	add	hl, hl
	ld	de,#0x6400
	add	hl,de
	ld	(hl),b
;src/Map.c:196: (*(cellStack+lastStackItem)).y = currentPos.y-1;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	e,(hl)
	dec	e
	ld	a,e
	ld	(bc),a
00156$:
;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	b,(hl)
;src/Map.c:200: if(currentPos.y < (MAP_HEIGHT-1)){
	ld	a,b
	sub	a, #0x1F
	jp	NC,00164$
;src/Map.c:202: adjacentType = map[currentPos.x][currentPos.y+1];
	ld	l,-6 (ix)
	ld	h,-5 (ix)
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
;src/Map.c:203: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jp	NZ,00164$
;src/Map.c:206: ++lastStackItem;
	inc	-20 (ix)
	jr	NZ,00349$
	inc	-19 (ix)
00349$:
;src/Map.c:207: (*(cellStack+lastStackItem)).x = currentPos.x;
	pop	hl
	push	hl
	add	hl, hl
	ld	de,#0x6400
	add	hl,de
	ld	(hl),c
;src/Map.c:208: (*(cellStack+lastStackItem)).y = currentPos.y+1;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	inc	a
	ld	(bc),a
	jp	00164$
00162$:
;src/Map.c:214: ++wallListCount;
	inc	-4 (ix)
	jr	NZ,00350$
	inc	-3 (ix)
00350$:
	ld	a,-4 (ix)
	ld	-18 (ix),a
	ld	a,-3 (ix)
	ld	-17 (ix),a
;src/Map.c:215: (*(wallList+wallListCount)).x = currentPos.x;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	add	hl, hl
	ld	bc,#0x6800
	add	hl,bc
	ld	a,-7 (ix)
	ld	(hl),a
;src/Map.c:216: (*(wallList+wallListCount)).y = currentPos.y;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	(bc),a
	jp	00164$
00174$:
	ld	sp, ix
	pop	ix
	ret
;src/Map.c:222: void generate_exit_door(){
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
;src/Map.c:223: u8 x=(cpct_getRandom_lcg_u8()%32);
	call	_cpct_getRandom_lcg_u8
	ld	a,l
	and	a, #0x1F
	ld	c,a
;src/Map.c:224: u8 y=(cpct_getRandom_lcg_u8()%32);
	push	bc
	call	_cpct_getRandom_lcg_u8
	pop	bc
	ld	a,l
	and	a, #0x1F
	ld	e,a
;src/Map.c:225: u8 door_not_positioned=1;
	ld	-14 (ix),#0x01
;src/Map.c:232: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
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
;src/Map.c:237: lastVal = (position-1);
	ld	e,c
	ld	d,b
	dec	de
;src/Map.c:238: nextVal = (position+1);
	ld	hl,#0x0001
	add	hl,bc
	ld	-11 (ix),l
	ld	-10 (ix),h
;src/Map.c:239: topVal = (position-MAP_WIDTH);
	ld	a,c
	add	a,#0xE0
	ld	-13 (ix),a
	ld	a,b
	adc	a,#0xFF
	ld	-12 (ix),a
;src/Map.c:240: bottomVal = (position+MAP_WIDTH);
	ld	iy,#0x0020
	add	iy, bc
;src/Map.c:242: while(door_not_positioned){
00138$:
	ld	a,-14 (ix)
	or	a, a
	jp	Z,00141$
;src/Map.c:243: if((*position)!=CELLTYPE_FLOOR){
	ld	a,(bc)
	or	a, a
	jp	Z,00135$
;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
	ld	a,(de)
	ld	-3 (ix),a
	ld	-9 (ix),e
	ld	-8 (ix),d
	ld	a,-11 (ix)
	ld	-5 (ix),a
	ld	a,-10 (ix)
	ld	-4 (ix),a
;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	ld	a,(hl)
	ld	-6 (ix),a
	ld	a,-13 (ix)
	ld	-2 (ix),a
	ld	a,-12 (ix)
	ld	-1 (ix),a
	push	iy
	pop	hl
;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
	ld	a,-8 (ix)
	sub	a, #0x60
	ld	a,#0x00
	rla
	ld	-9 (ix),a
	ld	a,-4 (ix)
	sub	a, #0x64
	ld	a,#0x00
	rla
	ld	-5 (ix),a
;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
	ld	a,-1 (ix)
	sub	a, #0x60
	ld	a,#0x00
	rla
	ld	-2 (ix),a
	ld	a,h
	sub	a, #0x64
	ld	a,#0x00
	rla
	ld	-7 (ix),a
;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
	ld	a,-3 (ix)
	or	a, a
	jr	NZ,00133$
	ld	a,-9 (ix)
	or	a, a
	jr	Z,00129$
00133$:
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	a,(hl)
	or	a, a
	jr	NZ,00128$
	bit	0,-5 (ix)
	jr	NZ,00129$
00128$:
;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
	ld	l, 0 (iy)
	ld	a,-6 (ix)
	or	a, a
	jr	NZ,00111$
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00107$
00111$:
	ld	a,l
	or	a, a
	jr	NZ,00107$
	ld	a,-7 (ix)
	or	a, a
	jr	Z,00107$
;src/Map.c:246: door_not_positioned=0;
	ld	-14 (ix),#0x00
;src/Map.c:247: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
	jp	00135$
00107$:
;src/Map.c:249: else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
	ld	a,l
	or	a, a
	jr	NZ,00105$
	ld	a,-7 (ix)
	or	a, a
	jr	NZ,00135$
00105$:
	ld	a,-6 (ix)
	or	a, a
	jr	NZ,00135$
	ld	a,-2 (ix)
	or	a, a
	jr	NZ,00135$
;src/Map.c:250: door_not_positioned=0;
	ld	-14 (ix),#0x00
;src/Map.c:251: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
	jr	00135$
00129$:
;src/Map.c:254: else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
	ld	a,-6 (ix)
	or	a, a
	jr	NZ,00127$
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00135$
00127$:
	ld	a, 0 (iy)
	or	a, a
	jr	NZ,00123$
	ld	a,-7 (ix)
	or	a, a
	jr	NZ,00135$
00123$:
;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	l,(hl)
;src/Map.c:255: if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
	ld	a,-3 (ix)
	or	a, a
	jr	NZ,00122$
	ld	a,-9 (ix)
	or	a, a
	jr	Z,00118$
00122$:
	ld	a,l
	or	a, a
	jr	NZ,00118$
	bit	0,-5 (ix)
	jr	Z,00118$
;src/Map.c:256: door_not_positioned=0;
	ld	-14 (ix),#0x00
;src/Map.c:257: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
	jr	00135$
00118$:
;src/Map.c:259: else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
	ld	a,l
	or	a, a
	jr	NZ,00116$
	bit	0,-5 (ix)
	jr	NZ,00135$
00116$:
	ld	a,-3 (ix)
	or	a, a
	jr	NZ,00135$
	ld	a,-9 (ix)
	or	a, a
	jr	NZ,00135$
;src/Map.c:260: door_not_positioned=0;
	ld	-14 (ix),#0x00
;src/Map.c:261: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
00135$:
;src/Map.c:265: ++position;
	inc	bc
;src/Map.c:266: ++lastVal;
	inc	de
;src/Map.c:267: ++nextVal;
	inc	-11 (ix)
	jr	NZ,00223$
	inc	-10 (ix)
00223$:
;src/Map.c:268: ++topVal;
	inc	-13 (ix)
	jr	NZ,00224$
	inc	-12 (ix)
00224$:
;src/Map.c:269: ++bottomVal;
	inc	iy
;src/Map.c:270: if(position==END_OF_MAP_MEM){
	ld	l, c
	ld	h, b
	ld	a,l
	or	a, a
	jp	NZ,00138$
	ld	a,h
	sub	a, #0x64
	jp	NZ,00138$
;src/Map.c:271: position = MAP_MEM;
	ld	bc,#0x6000
;src/Map.c:272: lastVal = (position-1);
	ld	de,#0x5FFF
;src/Map.c:273: nextVal = (position+1);
	ld	-11 (ix),#0x01
	ld	-10 (ix),#0x60
;src/Map.c:274: topVal = (position-MAP_WIDTH);
	ld	-13 (ix),#0xE0
	ld	-12 (ix),#0x5F
;src/Map.c:275: bottomVal = (position+MAP_WIDTH);
	ld	iy,#0x6020
	jp	00138$
00141$:
	ld	sp, ix
	pop	ix
	ret
;src/Map.c:281: void generate_level(){
;	---------------------------------
; Function generate_level
; ---------------------------------
_generate_level::
;src/Map.c:282: generate_level_with_seed(r_counter);
	ld	a,(_r_counter)
	push	af
	inc	sp
	call	_generate_level_with_seed
	inc	sp
	ret
;src/Map.c:285: void generate_level_with_seed(u8 seed){
;	---------------------------------
; Function generate_level_with_seed
; ---------------------------------
_generate_level_with_seed::
;src/Map.c:287: rand_seed=seed;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	ld	(#_rand_seed + 0),a
;src/Map.c:288: cpct_setSeed_lcg_u8(seed+level_get_level());
	call	_level_get_level
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	add	a, l
	ld	l,a
	call	_cpct_setSeed_lcg_u8
;src/Map.c:290: generate_map();
	call	_generate_map
;src/Map.c:291: generate_exit_door();
	call	_generate_exit_door
;src/Map.c:292: *(u8*)(MAP_MEM + 6 + MAP_WIDTH*5)=0b00000001;
	ld	hl,#0x60A6
	ld	(hl),#0x01
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__rand_seed:
	.db #0x00	; 0
	.area _CABS (ABS)
