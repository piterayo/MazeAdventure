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
	.globl _generate_final_map
	.globl _get_random_wall
	.globl _level_get_level
	.globl _player_get_direction_index
	.globl _player_turn_left
	.globl _cpct_restoreState_mxor_u8
	.globl _cpct_setSeed_mxor
	.globl _cpct_getRandom_mxor_u8
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
_rand_seed::
	.ds 2
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
;src/Map.c:14: u16 map_get_seed(){
;	---------------------------------
; Function map_get_seed
; ---------------------------------
_map_get_seed::
;src/Map.c:15: return rand_seed;
	ld	hl,(_rand_seed)
	ret
;src/Map.c:18: u8 get_random_wall(){
;	---------------------------------
; Function get_random_wall
; ---------------------------------
_get_random_wall::
;src/Map.c:19: u8 cellType = cpct_getRandom_mxor_u8 ();
	call	_cpct_getRandom_mxor_u8
;src/Map.c:20: if(cellType&1){ //1,3,5,7
	bit	0, l
	jr	Z,00108$
;src/Map.c:21: return CELLTYPE_WALL1;
	ld	l,#0x81
	ret
00108$:
;src/Map.c:24: if(cellType&3){//2,6
	ld	a,l
	and	a, #0x03
	jr	Z,00105$
;src/Map.c:25: return CELLTYPE_WALL2;
	ld	l,#0x82
	ret
00105$:
;src/Map.c:28: if(cellType&7){//4
	ld	a,l
	and	a, #0x07
	jr	Z,00102$
;src/Map.c:29: return CELLTYPE_WALL3;
	ld	l,#0x83
	ret
00102$:
;src/Map.c:32: return CELLTYPE_WALL4;  
	ld	l,#0x84
	ret
;src/Map.c:38: void generate_final_map(){
;	---------------------------------
; Function generate_final_map
; ---------------------------------
_generate_final_map::
;src/Map.c:43: while(m>=MAP_MEM){
	ld	hl,#0x8CD0
00101$:
	ld	a,l
	sub	a, #0xD0
	ld	a,h
	sbc	a, #0x88
	jr	C,00103$
;src/Map.c:44: *m=CELLTYPE_WALL1;
	ld	(hl),#0x81
;src/Map.c:45: --m;
	dec	hl
	jr	00101$
00103$:
;src/Map.c:48: for(i=1;i<KING_LEVEL_WIDTH-1;++i){
	ld	c,#0x01
;src/Map.c:49: for(j=1;j<KING_LEVEL_HEIGHT-1;++j){
00124$:
	ld	b,#0x01
00110$:
;src/Map.c:50: map[j][i]=CELLTYPE_FLOOR;//get_random_wall();
	ld	l,b
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de,#0x88D0
	add	hl,de
	ld	e,c
	ld	d,#0x00
	add	hl,de
	ld	(hl),#0x00
;src/Map.c:49: for(j=1;j<KING_LEVEL_HEIGHT-1;++j){
	inc	b
	ld	a,b
	sub	a, #0x08
	jr	C,00110$
;src/Map.c:48: for(i=1;i<KING_LEVEL_WIDTH-1;++i){
	inc	c
	ld	a,c
	sub	a, #0x08
	jr	C,00124$
;src/Map.c:54: for(i=2;i<7;i+=2){
	ld	c,#0x02
00114$:
;src/Map.c:55: map[i][2]=(cpct_getRandom_mxor_u8 ()%2)?CELLTYPE_WALL2:CELLTYPE_WALL3;//get_random_wall();
	ld	l,c
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #0x88D0
	add	hl, de
	ld	e,l
	ld	d,h
	inc	hl
	inc	hl
	push	hl
	push	bc
	push	de
	call	_cpct_getRandom_mxor_u8
	ld	a,l
	pop	de
	pop	bc
	pop	hl
	rrca
	jr	NC,00118$
	ld	b,#0x82
	jr	00119$
00118$:
	ld	b,#0x83
00119$:
	ld	(hl),b
;src/Map.c:56: map[i][6]=(cpct_getRandom_mxor_u8 ()%2)?CELLTYPE_WALL2:CELLTYPE_WALL3;//get_random_wall();
	ld	hl,#0x0006
	add	hl,de
	push	hl
	push	bc
	call	_cpct_getRandom_mxor_u8
	ld	a,l
	pop	bc
	pop	hl
	rrca
	jr	NC,00120$
	ld	b,#0x82
	jr	00121$
00120$:
	ld	b,#0x83
00121$:
	ld	(hl),b
;src/Map.c:54: for(i=2;i<7;i+=2){
	inc	c
	inc	c
	ld	a,c
	sub	a, #0x07
	jr	C,00114$
;src/Map.c:59: map[KING_LEVEL_EXIT_Y][KING_LEVEL_EXIT_X] = CELLTYPE_DOOR;
	ld	hl,#0x88D4
	ld	(hl),#0x80
;src/Map.c:62: while(player_get_direction_index()!=MOVEMENT_NORTH){
00107$:
	call	_player_get_direction_index
	ld	a,l
	sub	a, #0x02
	jr	Z,00109$
;src/Map.c:63: player_turn_left();
	call	_player_turn_left
	jr	00107$
00109$:
;src/Map.c:66: *(i8*)&(player_position.x) = KING_LEVEL_PLAYER_X;
	ld	hl,#_player_position
	ld	(hl),#0x04
;src/Map.c:67: *(i8*)&(player_position.y) = KING_LEVEL_PLAYER_Y;
	ld	hl,#(_player_position + 0x0001)
	ld	(hl),#0x07
	ret
;src/Map.c:71: void generate_map(){
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
;src/Map.c:74: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
	ld	-15 (ix),#0x83
	ld	-14 (ix),#0x03
;src/Map.c:80: u16 wallListCount = 0;
	ld	hl,#0x0000
	ex	(sp), hl
;src/Map.c:81: u16 lastStackItem = 0;
	ld	-13 (ix),#0x00
	ld	-12 (ix),#0x00
;src/Map.c:83: cpct_memset (GENERATOR_DATA_PTR, 0, 4096);
	ld	hl,#0x1000
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	hl,#0x8CD0
	push	hl
	call	_cpct_memset
;src/Map.c:85: (*cellStack).x = (cpct_getRandom_mxor_u8 ()%(MAP_WIDTH-2))+1; //RANDOM
	call	_cpct_getRandom_mxor_u8
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
	ld	hl,#0x8CD0
	ld	(hl),c
;src/Map.c:86: (*cellStack).y = (cpct_getRandom_mxor_u8 ()%(MAP_HEIGHT-2))+1; //RANDOM
	call	_cpct_getRandom_mxor_u8
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
	ld	hl,#0x8CD1
	ld	(hl),c
;src/Map.c:88: rotatePlayer = cpct_getRandom_mxor_u8 ()%4;
	call	_cpct_getRandom_mxor_u8
	ld	a,l
	and	a, #0x03
	ld	c,a
;src/Map.c:89: while(rotatePlayer){
00101$:
	ld	a,c
	or	a, a
	jr	Z,00103$
;src/Map.c:90: player_turn_left();
	push	bc
	call	_player_turn_left
	pop	bc
;src/Map.c:91: --rotatePlayer;
	dec	c
	jr	00101$
00103$:
;src/Map.c:94: *(i8*)&(player_position.x) = (*cellStack).y;
	ld	bc,#_player_position+0
	ld	a,(#0x8CD1)
	ld	(bc),a
;src/Map.c:95: *(i8*)&(player_position.y) = (*cellStack).x;
	ld	bc,#_player_position+1
	ld	a,(#0x8CD0)
	ld	(bc),a
;src/Map.c:97: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
	ld	hl,#0x0400
	push	hl
	ld	a,#0x87
	push	af
	inc	sp
	ld	hl,#0x88D0
	push	hl
	call	_cpct_memset
;src/Map.c:100: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
	ld	hl,#0x8CD0
	ld	l,(hl)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc,#0x88D0
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	hl,#0x8CD1
	ld	l, (hl)
	ld	h,#0x00
	add	hl,bc
	ld	(hl),#0x00
;src/Map.c:103: for(i=0;i<MAP_WIDTH;++i){
	ld	c,#0x00
00170$:
;src/Map.c:104: map[0][i]=CELLTYPE_WALL1;//get_random_wall();
	ld	hl,#0x88D0
	ld	b,#0x00
	add	hl, bc
	ld	(hl),#0x81
;src/Map.c:105: map[MAP_HEIGHT-1][i]=CELLTYPE_WALL1;//get_random_wall();
	ld	hl,#0x8CB0
	ld	b,#0x00
	add	hl, bc
	ld	(hl),#0x81
;src/Map.c:103: for(i=0;i<MAP_WIDTH;++i){
	inc	c
	ld	a,c
	sub	a, #0x20
	jr	C,00170$
;src/Map.c:108: for(i=0;i<MAP_HEIGHT-1;++i){
	ld	c,#0x00
00172$:
;src/Map.c:109: map[i][0]=CELLTYPE_WALL1;//get_random_wall();
	ld	l,c
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de,hl
	ld	hl,#0x88D0
	add	hl,de
	ld	(hl),#0x81
;src/Map.c:110: map[i][MAP_WIDTH-1]=CELLTYPE_WALL1;//get_random_wall();
	ld	hl,#0x88D0
	add	hl,de
	ld	de,#0x001F
	add	hl,de
	ld	(hl),#0x81
;src/Map.c:108: for(i=0;i<MAP_HEIGHT-1;++i){
	inc	c
	ld	a,c
	sub	a, #0x1F
	jr	C,00172$
;src/Map.c:113: while(remainingCells>0){
	ld	hl,#0x0002
	add	hl,sp
	ld	-6 (ix),l
	ld	-5 (ix),h
00167$:
	ld	a,-14 (ix)
	or	a,-15 (ix)
	jp	Z,00174$
;src/Map.c:114: wallListPosition = wallList+wallListCount;
	pop	hl
	push	hl
	add	hl, hl
	ld	a,l
	add	a, #0xD0
	ld	-4 (ix),a
	ld	a,h
	adc	a, #0x90
	ld	-3 (ix),a
;src/Map.c:115: while(wallListCount<MAP_SIZE){
	pop	bc
	push	bc
00137$:
;src/Map.c:118: currentPos.y = (*wallListPosition).y;
	ld	a,-6 (ix)
	add	a, #0x01
	ld	-2 (ix),a
	ld	a,-5 (ix)
	adc	a, #0x00
	ld	-1 (ix),a
;src/Map.c:115: while(wallListCount<MAP_SIZE){
	ld	a,b
	sub	a, #0x04
	jp	NC,00209$
;src/Map.c:117: currentPos.x = (*wallListPosition).x;
	ld	hl,#0x0002
	add	hl,sp
	ex	de,hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	a,(hl)
	ld	(de),a
;src/Map.c:118: currentPos.y = (*wallListPosition).y;
	ld	e,-4 (ix)
	ld	d,-3 (ix)
	inc	de
	ld	a,(de)
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),a
;src/Map.c:120: convertToFloor=0;
	ld	-11 (ix),#0x00
;src/Map.c:121: surroundedByWalls=1;
	ld	-16 (ix),#0x01
;src/Map.c:123: if(currentPos.x>0){
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	a,(hl)
	ld	-8 (ix),a
;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-7 (ix),a
	ld	a,-8 (ix)
	ld	-10 (ix),a
	ld	-9 (ix),#0x00
;src/Map.c:123: if(currentPos.x>0){
	ld	a,-8 (ix)
	or	a, a
	jr	Z,00112$
;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	dec	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	de
	ld	de,#0x88D0
	add	hl, de
	pop	de
	ld	a,l
	add	a, -7 (ix)
	ld	l,a
	ld	a,h
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:125: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00109$
;src/Map.c:126: convertToFloor  = 1;
	ld	-11 (ix),#0x01
	jr	00112$
00109$:
;src/Map.c:128: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00112$
;src/Map.c:129: surroundedByWalls = 0;
	ld	-16 (ix),#0x00
00112$:
;src/Map.c:132: if(currentPos.x < (MAP_WIDTH-1)){
	ld	a,-8 (ix)
	sub	a, #0x1F
	jr	NC,00119$
;src/Map.c:134: adjacentType = map[currentPos.x+1][currentPos.y];
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	de
	ld	de,#0x88D0
	add	hl, de
	pop	de
	ld	a,l
	add	a, -7 (ix)
	ld	l,a
	ld	a,h
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:135: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00116$
;src/Map.c:136: convertToFloor  = 1;
	ld	-11 (ix),#0x01
	jr	00119$
00116$:
;src/Map.c:138: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00119$
;src/Map.c:139: surroundedByWalls = 0;
	ld	-16 (ix),#0x00
00119$:
;src/Map.c:144: adjacentType = map[currentPos.x][currentPos.y-1];
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a,l
	add	a, #0xD0
	ld	-10 (ix),a
	ld	a,h
	adc	a, #0x88
	ld	-9 (ix),a
;src/Map.c:142: if(currentPos.y > 0){
	ld	a,-7 (ix)
	or	a, a
	jr	Z,00126$
;src/Map.c:144: adjacentType = map[currentPos.x][currentPos.y-1];
	ld	l,-7 (ix)
	dec	l
	ld	a,-10 (ix)
	add	a, l
	ld	l,a
	ld	a,-9 (ix)
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:145: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00123$
;src/Map.c:146: convertToFloor  = 1;
	ld	-11 (ix),#0x01
	jr	00126$
00123$:
;src/Map.c:148: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00126$
;src/Map.c:149: surroundedByWalls = 0;
	ld	-16 (ix),#0x00
00126$:
;src/Map.c:152: if(currentPos.y < (MAP_HEIGHT-1)){
	ld	a,-7 (ix)
	sub	a, #0x1F
	jr	NC,00133$
;src/Map.c:154: adjacentType = map[currentPos.x][currentPos.y+1];
	ld	l,-7 (ix)
	inc	l
	ld	a,-10 (ix)
	add	a, l
	ld	l,a
	ld	a,-9 (ix)
	adc	a, #0x00
	ld	h,a
	ld	l,(hl)
;src/Map.c:155: if(adjacentType == CELLTYPE_UNDEFINED){
	ld	a,l
	sub	a, #0x87
	jr	NZ,00130$
;src/Map.c:156: convertToFloor  = 1;
	ld	-11 (ix),#0x01
	jr	00133$
00130$:
;src/Map.c:158: else if(adjacentType == CELLTYPE_FLOOR){
	ld	a,l
	or	a, a
	jr	NZ,00133$
;src/Map.c:159: surroundedByWalls = 0;
	ld	-16 (ix),#0x00
00133$:
;src/Map.c:163: (*wallListPosition).x = (*(wallList+wallListCount)).x;
	ld	l, c
	ld	h, b
	add	hl, hl
	ld	iy,#0x90D0
	push	bc
	ld	c, l
	ld	b, h
	add	iy, bc
	pop	bc
	ld	a, 0 (iy)
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),a
;src/Map.c:164: (*wallListPosition).y = (*(wallList+wallListCount)).y;
	push	iy
	pop	hl
	inc	hl
	ld	a,(hl)
	ld	(de),a
;src/Map.c:165: --wallListCount;
	dec	bc
	inc	sp
	inc	sp
	push	bc
;src/Map.c:168: if((convertToFloor)&&(!surroundedByWalls)){
	ld	a,-11 (ix)
	or	a, a
	jr	Z,00135$
	ld	a,-16 (ix)
	or	a, a
	jr	NZ,00135$
;src/Map.c:169: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	l,(hl)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc,#0x88D0
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,bc
	ld	(hl),#0x00
;src/Map.c:171: ++lastStackItem;
	inc	-13 (ix)
	jr	NZ,00334$
	inc	-12 (ix)
00334$:
;src/Map.c:172: (*(cellStack+lastStackItem)).x = currentPos.x;
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	add	hl, hl
	ld	bc, #0x8CD0
	add	hl,bc
	ld	c, l
	ld	b, h
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	a,(hl)
	ld	(bc),a
;src/Map.c:173: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	bc
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	(bc),a
;src/Map.c:176: break;
	jr	00209$
00135$:
;src/Map.c:178: --wallListPosition;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	dec	hl
	dec	hl
	ld	-4 (ix),l
	ld	-3 (ix),h
	jp	00137$
;src/Map.c:180: while(lastStackItem<MAP_SIZE){
00209$:
	ld	a,-15 (ix)
	ld	-10 (ix),a
	ld	a,-14 (ix)
	ld	-9 (ix),a
	ld	a,-20 (ix)
	ld	-4 (ix),a
	ld	a,-19 (ix)
	ld	-3 (ix),a
00164$:
	ld	a,-12 (ix)
	sub	a, #0x04
	jp	NC,00167$
;src/Map.c:181: currentPos.x=(*(lastStackItem+cellStack)).x;
	ld	hl,#0x0002
	add	hl,sp
	ld	c,l
	ld	b,h
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	add	hl, hl
	ld	iy,#0x8CD0
	ex	de,hl
	add	iy, de
	ld	a, 0 (iy)
	ld	(bc),a
;src/Map.c:182: currentPos.y=(*(lastStackItem+cellStack)).y;
	ld	c,1 (iy)
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),c
;src/Map.c:183: --lastStackItem;
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	dec	hl
	ld	-13 (ix),l
	ld	-12 (ix),h
;src/Map.c:184: cellType = map[currentPos.x][currentPos.y];
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	l,(hl)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de,#0x88D0
	add	hl,de
	ld	e,c
	ld	d,#0x00
	add	hl,de
	ld	c,(hl)
;src/Map.c:186: if(cellType == CELLTYPE_UNDEFINED){
	ld	a,c
	sub	a, #0x87
	jr	NZ,00144$
;src/Map.c:188: if(cpct_getRandom_mxor_u8 ()&1){//WALL
	call	_cpct_getRandom_mxor_u8
	bit	0, l
	jr	Z,00141$
;src/Map.c:189: cellType = get_random_wall();
	call	_get_random_wall
	ld	c,l
	jr	00142$
00141$:
;src/Map.c:192: cellType = CELLTYPE_FLOOR;
	ld	c,#0x00
00142$:
;src/Map.c:194: map[currentPos.x][currentPos.y]=cellType;
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
	ld	hl,#0x88D0
	add	hl,de
	ex	de,hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,de
	ld	(hl),c
;src/Map.c:195: --remainingCells;
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	dec	hl
	ld	-10 (ix),l
	ld	-9 (ix),h
	ld	a,-10 (ix)
	ld	-15 (ix),a
	ld	a,-9 (ix)
	ld	-14 (ix),a
00144$:
;src/Map.c:123: if(currentPos.x>0){
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	a,(hl)
	ld	-7 (ix),a
;src/Map.c:198: if((cellType == CELLTYPE_FLOOR)){
	ld	a,c
	or	a, a
	jp	NZ,00162$
;src/Map.c:199: if(currentPos.x>0){
	ld	a,-7 (ix)
	or	a, a
	jr	Z,00148$
;src/Map.c:200: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-7 (ix)
	ld	h,#0x00
	dec	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc,#0x88D0
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
;src/Map.c:201: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jr	NZ,00148$
;src/Map.c:203: ++lastStackItem;
	inc	-13 (ix)
	jr	NZ,00340$
	inc	-12 (ix)
00340$:
;src/Map.c:204: (*(cellStack+lastStackItem)).x = currentPos.x-1;
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	add	hl, hl
	ld	bc,#0x8CD0
	add	hl,bc
	ld	c,-7 (ix)
	dec	c
	ld	(hl),c
;src/Map.c:205: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	(bc),a
00148$:
;src/Map.c:209: if(currentPos.x < (MAP_WIDTH-1)){
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	c,(hl)
	ld	a,c
	sub	a, #0x1F
	jr	NC,00152$
;src/Map.c:211: adjacentType = map[currentPos.x+1][currentPos.y];
	ld	l,c
	ld	h,#0x00
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de,hl
	ld	hl,#0x88D0
	add	hl,de
	ex	de,hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	l, (hl)
	ld	h,#0x00
	add	hl,de
	ld	a,(hl)
;src/Map.c:212: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jr	NZ,00152$
;src/Map.c:215: ++lastStackItem;
	inc	-13 (ix)
	jr	NZ,00343$
	inc	-12 (ix)
00343$:
;src/Map.c:216: (*(cellStack+lastStackItem)).x = currentPos.x+1;
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	add	hl, hl
	ld	de,#0x8CD0
	add	hl,de
	inc	c
	ld	(hl),c
;src/Map.c:217: (*(cellStack+lastStackItem)).y = currentPos.y;
	inc	hl
	ld	c,l
	ld	b,h
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	(bc),a
00152$:
;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	c,(hl)
;src/Map.c:221: if(currentPos.y > 0){
	ld	a,c
	or	a, a
	jr	Z,00156$
;src/Map.c:223: adjacentType = map[currentPos.x][currentPos.y-1];
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
	ld	de,#0x88D0
	add	hl,de
	dec	c
	ld	e,c
	ld	d,#0x00
	add	hl,de
	ld	a,(hl)
;src/Map.c:224: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jr	NZ,00156$
;src/Map.c:227: ++lastStackItem;
	inc	-13 (ix)
	jr	NZ,00346$
	inc	-12 (ix)
00346$:
;src/Map.c:228: (*(cellStack+lastStackItem)).x = currentPos.x;
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	add	hl, hl
	ld	de,#0x8CD0
	add	hl,de
	ld	(hl),b
;src/Map.c:229: (*(cellStack+lastStackItem)).y = currentPos.y-1;
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
;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	b,(hl)
;src/Map.c:233: if(currentPos.y < (MAP_HEIGHT-1)){
	ld	a,b
	sub	a, #0x1F
	jp	NC,00164$
;src/Map.c:235: adjacentType = map[currentPos.x][currentPos.y+1];
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
	ld	de,#0x88D0
	add	hl,de
	inc	b
	ld	e,b
	ld	d,#0x00
	add	hl,de
	ld	a,(hl)
;src/Map.c:236: if(adjacentType == CELLTYPE_UNDEFINED){
	sub	a, #0x87
	jp	NZ,00164$
;src/Map.c:239: ++lastStackItem;
	inc	-13 (ix)
	jr	NZ,00349$
	inc	-12 (ix)
00349$:
;src/Map.c:240: (*(cellStack+lastStackItem)).x = currentPos.x;
	ld	l,-13 (ix)
	ld	h,-12 (ix)
	add	hl, hl
	ld	de,#0x8CD0
	add	hl,de
	ld	(hl),c
;src/Map.c:241: (*(cellStack+lastStackItem)).y = currentPos.y+1;
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
;src/Map.c:247: ++wallListCount;
	inc	-4 (ix)
	jr	NZ,00350$
	inc	-3 (ix)
00350$:
	ld	a,-4 (ix)
	ld	-20 (ix),a
	ld	a,-3 (ix)
	ld	-19 (ix),a
;src/Map.c:248: (*(wallList+wallListCount)).x = currentPos.x;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	add	hl, hl
	ld	bc,#0x90D0
	add	hl,bc
	ld	a,-7 (ix)
	ld	(hl),a
;src/Map.c:249: (*(wallList+wallListCount)).y = currentPos.y;
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
;src/Map.c:255: void generate_exit_door(){
;	---------------------------------
; Function generate_exit_door
; ---------------------------------
_generate_exit_door::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-13
	add	hl,sp
	ld	sp,hl
;src/Map.c:256: u8 x=(cpct_getRandom_mxor_u8 ()%32);
	call	_cpct_getRandom_mxor_u8
	ld	a,l
	and	a, #0x1F
	ld	c,a
;src/Map.c:257: u8 y=(cpct_getRandom_mxor_u8 ()%32);
	push	bc
	call	_cpct_getRandom_mxor_u8
	pop	bc
	ld	a,l
	and	a, #0x1F
	ld	e,a
;src/Map.c:258: u8 door_not_positioned=1;
	ld	-7 (ix),#0x01
;src/Map.c:265: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
	ld	b,#0x00
	ld	hl,#0x88D0
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
;src/Map.c:270: lastVal = (position-1);
	ld	e,c
	ld	d,b
	dec	de
;src/Map.c:271: nextVal = (position+1);
	ld	hl,#0x0001
	add	hl,bc
	ld	-9 (ix),l
	ld	-8 (ix),h
;src/Map.c:272: topVal = (position-MAP_WIDTH);
	ld	a,c
	add	a,#0xE0
	ld	-11 (ix),a
	ld	a,b
	adc	a,#0xFF
	ld	-10 (ix),a
;src/Map.c:273: bottomVal = (position+MAP_WIDTH);
	ld	hl,#0x0020
	add	hl,bc
	ex	(sp), hl
;src/Map.c:275: while(door_not_positioned){
00138$:
	ld	a,-7 (ix)
	or	a, a
	jp	Z,00141$
;src/Map.c:276: if((*position)!=CELLTYPE_FLOOR){
	ld	a,(bc)
	or	a, a
	jp	Z,00135$
;src/Map.c:277: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
	ld	a,(de)
	ld	-4 (ix),a
	ld	a,e
	sub	a, #0xD0
	ld	a,d
	sbc	a, #0x88
	ld	a,#0x00
	rla
	ld	-5 (ix),a
	ld	a,-9 (ix)
	sub	a, #0xD0
	ld	a,-8 (ix)
	sbc	a, #0x8C
	ld	a,#0x00
	rla
	ld	-6 (ix),a
;src/Map.c:278: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	a,(hl)
	ld	-1 (ix),a
	ld	a,-11 (ix)
	sub	a, #0xD0
	ld	a,-10 (ix)
	sbc	a, #0x88
	ld	a,#0x00
	rla
	ld	-2 (ix),a
	ld	a,-13 (ix)
	sub	a, #0xD0
	ld	a,-12 (ix)
	sbc	a, #0x8C
	ld	a,#0x00
	rla
	ld	-3 (ix),a
;src/Map.c:277: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
	ld	a,-4 (ix)
	or	a, a
	jr	NZ,00133$
	ld	a,-5 (ix)
	or	a, a
	jr	Z,00129$
00133$:
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	a,(hl)
	or	a, a
	jr	NZ,00128$
	bit	0,-6 (ix)
	jr	NZ,00129$
00128$:
;src/Map.c:278: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
	pop	hl
	push	hl
	ld	l,(hl)
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00111$
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00107$
00111$:
	ld	a,l
	or	a, a
	jr	NZ,00107$
	ld	a,-3 (ix)
	or	a, a
	jr	Z,00107$
;src/Map.c:279: door_not_positioned=0;
	ld	-7 (ix),#0x00
;src/Map.c:280: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
	jp	00135$
00107$:
;src/Map.c:282: else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
	ld	a,l
	or	a, a
	jr	NZ,00105$
	ld	a,-3 (ix)
	or	a, a
	jr	NZ,00135$
00105$:
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00135$
	ld	a,-2 (ix)
	or	a, a
	jr	NZ,00135$
;src/Map.c:283: door_not_positioned=0;
	ld	-7 (ix),#0x00
;src/Map.c:284: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
	jr	00135$
00129$:
;src/Map.c:287: else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00127$
	ld	a,-2 (ix)
	or	a, a
	jr	Z,00135$
00127$:
	pop	hl
	push	hl
	ld	a,(hl)
	or	a, a
	jr	NZ,00123$
	ld	a,-3 (ix)
	or	a, a
	jr	NZ,00135$
00123$:
;src/Map.c:277: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	l,(hl)
;src/Map.c:288: if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
	ld	a,-4 (ix)
	or	a, a
	jr	NZ,00122$
	ld	a,-5 (ix)
	or	a, a
	jr	Z,00118$
00122$:
	ld	a,l
	or	a, a
	jr	NZ,00118$
	bit	0,-6 (ix)
	jr	Z,00118$
;src/Map.c:289: door_not_positioned=0;
	ld	-7 (ix),#0x00
;src/Map.c:290: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
	jr	00135$
00118$:
;src/Map.c:292: else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
	ld	a,l
	or	a, a
	jr	NZ,00116$
	bit	0,-6 (ix)
	jr	NZ,00135$
00116$:
	ld	a,-4 (ix)
	or	a, a
	jr	NZ,00135$
	ld	a,-5 (ix)
	or	a, a
	jr	NZ,00135$
;src/Map.c:293: door_not_positioned=0;
	ld	-7 (ix),#0x00
;src/Map.c:294: *position=CELLTYPE_DOOR;
	ld	a,#0x80
	ld	(bc),a
00135$:
;src/Map.c:298: ++position;
	inc	bc
;src/Map.c:299: ++lastVal;
	inc	de
;src/Map.c:300: ++nextVal;
	inc	-9 (ix)
	jr	NZ,00223$
	inc	-8 (ix)
00223$:
;src/Map.c:301: ++topVal;
	inc	-11 (ix)
	jr	NZ,00224$
	inc	-10 (ix)
00224$:
;src/Map.c:302: ++bottomVal;
	inc	-13 (ix)
	jr	NZ,00225$
	inc	-12 (ix)
00225$:
;src/Map.c:303: if(position==END_OF_MAP_MEM){
	ld	a,c
	sub	a, #0xD0
	jp	NZ,00138$
	ld	a,b
	sub	a, #0x8C
	jp	NZ,00138$
;src/Map.c:304: position = MAP_MEM;
	ld	bc,#0x88D0
;src/Map.c:305: lastVal = (position-1);
	ld	de,#0x88CF
;src/Map.c:306: nextVal = (position+1);
	ld	-9 (ix),#0xD1
	ld	-8 (ix),#0x88
;src/Map.c:307: topVal = (position-MAP_WIDTH);
	ld	-11 (ix),#0xB0
	ld	-10 (ix),#0x88
;src/Map.c:308: bottomVal = (position+MAP_WIDTH);
	ld	hl,#0x88F0
	ex	(sp), hl
	jp	00138$
00141$:
	ld	sp, ix
	pop	ix
	ret
;src/Map.c:314: void generate_level(){
;	---------------------------------
; Function generate_level
; ---------------------------------
_generate_level::
;src/Map.c:315: generate_level_with_seed(r_counter);
	ld	hl,(_r_counter)
	push	hl
	call	_generate_level_with_seed
	pop	af
	ret
;src/Map.c:318: void generate_level_with_seed(u16 seed) {
;	---------------------------------
; Function generate_level_with_seed
; ---------------------------------
_generate_level_with_seed::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Map.c:320: rand_seed=seed;
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	(_rand_seed),bc
;src/Map.c:323: cpct_setSeed_mxor(((seed+level_get_level())&0xFFFE) + 1);
	push	bc
	call	_level_get_level
	pop	bc
	ld	h,#0x00
	add	hl,bc
	res	0, l
	inc	hl
	ld	de,#0x0000
	call	_cpct_setSeed_mxor
;src/Map.c:324: cpct_restoreState_mxor_u8();
	call	_cpct_restoreState_mxor_u8
;src/Map.c:326: if(level_get_level()<KING_LEVEL){
	call	_level_get_level
	ld	a,l
	sub	a, #0x20
	jr	NC,00102$
;src/Map.c:327: generate_map();
	call	_generate_map
;src/Map.c:328: generate_exit_door();
	call	_generate_exit_door
	jr	00104$
00102$:
;src/Map.c:331: generate_final_map();
	call	_generate_final_map
00104$:
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
