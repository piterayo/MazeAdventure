;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module Enemy
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _enemy_AI_aggressive
	.globl _enemy_AI_passive
	.globl _enemy_roam
	.globl _enemy_flee
	.globl _enemy_go_to_player
	.globl _enemy_attack
	.globl _enemy_move
	.globl _enemy_remove
	.globl _enemy_get_distance_to_obstacle
	.globl _enemy_collision_at_dir
	.globl _enemy_new_enemy
	.globl _enemy_is_adjacent_to_player
	.globl _enemy_can_view
	.globl _dist
	.globl _abs
	.globl _level_get_level
	.globl _item_try_new_spawn_at
	.globl _ui_log_render
	.globl _ui_log_add_log
	.globl _integer_to_string
	.globl _ui_playerstats_render_hp
	.globl _cpct_getRandom_mxor_u8
	.globl _cpct_memcpy
	.globl _cpct_memset
	.globl _enemyArray
	.globl _activeEnemies
	.globl _enemy_get_at
	.globl _enemy_init_enemies
	.globl _enemy_try_new_spawn
	.globl _enemy_attack_enemy
	.globl _enemy_update
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_activeEnemies::
	.ds 1
_enemyArray::
	.ds 120
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
;src/Enemy.c:34: Enemy* const enemy_get_at(u8 index) {
;	---------------------------------
; Function enemy_get_at
; ---------------------------------
_enemy_get_at::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Enemy.c:35: return (enemyArray+index);
	ld	bc,#_enemyArray+0
	ld	l,4 (ix)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	pop	ix
	ret
;src/Enemy.c:38: void enemy_init_enemies(){
;	---------------------------------
; Function enemy_init_enemies
; ---------------------------------
_enemy_init_enemies::
;src/Enemy.c:40: cpct_memset(enemyArray, 0, ENEMY_MAX_ENEMIES*sizeof(Enemy));
	ld	hl,#0x0078
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	hl,#_enemyArray
	push	hl
	call	_cpct_memset
;src/Enemy.c:41: activeEnemies=0;
	ld	hl,#_activeEnemies + 0
	ld	(hl), #0x00
;src/Enemy.c:43: if(level_get_level()!=KING_LEVEL){
	call	_level_get_level
	ld	a,l
	sub	a, #0x20
	jr	Z,00105$
;src/Enemy.c:44: while(activeEnemies<ENEMY_MAX_ENEMIES){
00101$:
	ld	a,(#_activeEnemies + 0)
	sub	a, #0x0F
	ret	NC
;src/Enemy.c:45: enemy_try_new_spawn();  
	call	_enemy_try_new_spawn
	jr	00101$
00105$:
;src/Enemy.c:49: activeEnemies=1;
	ld	hl,#_activeEnemies + 0
	ld	(hl), #0x01
;src/Enemy.c:51: enemyArray->id=0;
	ld	hl,#_enemyArray
	ld	(hl),#0x00
;src/Enemy.c:53: enemyArray->type=1;
	ld	hl,#(_enemyArray + 0x0001)
	ld	(hl),#0x01
;src/Enemy.c:55: enemyArray->hitPoints=ENEMY_INITIAL_HP;
	ld	hl,#(_enemyArray + 0x0005)
	ld	(hl),#0xFF
;src/Enemy.c:57: enemyArray->attackValue = 64;
	ld	hl,#(_enemyArray + 0x0006)
	ld	(hl),#0x40
;src/Enemy.c:58: enemyArray->defenseValue = 54;
	ld	hl,#(_enemyArray + 0x0007)
	ld	(hl),#0x36
;src/Enemy.c:60: enemyArray->direction=MOVEMENT_SOUTH;
	ld	hl,#(_enemyArray + 0x0002)
	ld	(hl),#0x06
;src/Enemy.c:62: enemyArray->position.x = KING_LEVEL_KING_X;
	ld	hl,#(_enemyArray + 0x0003)
	ld	(hl),#0x04
;src/Enemy.c:63: enemyArray->position.y = KING_LEVEL_KING_Y;
	ld	hl,#(_enemyArray + 0x0004)
	ld	(hl),#0x02
;src/Enemy.c:65: *(u8*)(MAP_MEM + KING_LEVEL_KING_X + (KING_LEVEL_KING_Y*MAP_WIDTH)) = 1;
	ld	hl,#0x8914
	ld	(hl),#0x01
	ret
;src/Enemy.c:71: i8 abs(i8 n) {
;	---------------------------------
; Function abs
; ---------------------------------
_abs::
;src/Enemy.c:72: if(n<0) n=-n;
	ld	iy,#2
	add	iy,sp
	bit	7,0 (iy)
	jr	Z,00102$
	xor	a, a
	sub	a, 0 (iy)
	ld	0 (iy),a
00102$:
;src/Enemy.c:73: return n;
	ld	iy,#2
	add	iy,sp
	ld	l,0 (iy)
	ret
;src/Enemy.c:76: u8 dist(u8 x0, u8 y0, u8 x1, u8 y1){
;	---------------------------------
; Function dist
; ---------------------------------
_dist::
;src/Enemy.c:78: dx = abs(x1-x0);
	ld	hl,#2
	add	hl,sp
	ld	iy,#4
	add	iy,sp
	ld	a,0 (iy)
	sub	a, (hl)
	ld	b,a
	push	bc
	inc	sp
	call	_abs
	inc	sp
	ld	c,l
;src/Enemy.c:79: dy = abs(y1-y0);
	ld	hl,#3
	add	hl,sp
	ld	iy,#5
	add	iy,sp
	ld	a,0 (iy)
	sub	a, (hl)
	ld	b,a
	push	bc
	push	bc
	inc	sp
	call	_abs
	inc	sp
	pop	bc
;src/Enemy.c:81: return dx+dy;
	add	hl, bc
	ret
;src/Enemy.c:85: u8 enemy_can_view(Enemy* e){
;	---------------------------------
; Function enemy_can_view
; ---------------------------------
_enemy_can_view::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-15
	add	hl,sp
	ld	sp,hl
;src/Enemy.c:89: x0 = player_position.x;
	ld	hl,#_player_position+0
	ld	c,(hl)
;src/Enemy.c:90: y0 = player_position.y;
	ld	a,(#_player_position+1)
	ld	-14 (ix),a
;src/Enemy.c:92: x1 = e->position.x;
	ld	e,4 (ix)
	ld	d,5 (ix)
	push	de
	pop	iy
	ld	a,3 (iy)
	ld	-13 (ix),a
;src/Enemy.c:93: y1 = e->position.y;
	push	de
	pop	iy
	ld	a,4 (iy)
	ld	-15 (ix),a
;src/Enemy.c:95: mask = (CELL_WALL_MASK|CELL_ENEMY_MASK)^(e->id+1);
	ld	a,(de)
	inc	a
	xor	a, #0x8F
	ld	-10 (ix),a
;src/Enemy.c:97: dx = abs(x1-x0);
	ld	a,-13 (ix)
	sub	a, c
	ld	b,a
	push	bc
	push	bc
	inc	sp
	call	_abs
	inc	sp
	pop	bc
	ld	-7 (ix),l
;src/Enemy.c:98: dy = abs(y1-y0);
	ld	a,-15 (ix)
	sub	a, -14 (ix)
	ld	b,a
	push	bc
	push	bc
	inc	sp
	call	_abs
	inc	sp
	pop	bc
	ld	-9 (ix),l
;src/Enemy.c:100: sx = (x0<x1)?1:-1;
	ld	a,c
	sub	a, -13 (ix)
	jp	PO, 00168$
	xor	a, #0x80
00168$:
	jp	P,00117$
	ld	b,#0x01
	jr	00118$
00117$:
	ld	b,#0xFF
00118$:
	ld	-8 (ix),b
;src/Enemy.c:101: sy = (y0<y1)?1:-1;
	ld	a,-14 (ix)
	sub	a, -15 (ix)
	jp	PO, 00169$
	xor	a, #0x80
00169$:
	jp	P,00119$
	ld	e,#0x01
	jr	00120$
00119$:
	ld	e,#0xFF
00120$:
	ld	-11 (ix),e
;src/Enemy.c:103: e1 = ((dx>dy)?dx:-dy)/2;
	ld	a,-7 (ix)
	ld	-6 (ix),a
	ld	a,-7 (ix)
	rla
	sbc	a, a
	ld	-5 (ix),a
	ld	a,-9 (ix)
	sub	a, -7 (ix)
	jp	PO, 00170$
	xor	a, #0x80
00170$:
	jp	P,00121$
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	jr	00122$
00121$:
	ld	e,-9 (ix)
	ld	a,-9 (ix)
	rla
	sbc	a, a
	ld	d,a
	xor	a, a
	sub	a, e
	ld	l,a
	ld	a, #0x00
	sbc	a, d
	ld	h,a
00122$:
	ld	e, l
	ld	d, h
	bit	7, h
	jr	Z,00123$
	ex	de,hl
	inc	de
00123$:
	ld	b,e
	sra	d
	rr	b
;src/Enemy.c:105: while(1){
00113$:
;src/Enemy.c:106: e2 = e1;
	ld	-12 (ix),b
;src/Enemy.c:107: if (e2 >-dx) {
	xor	a, a
	sub	a, -6 (ix)
	ld	e,a
	ld	a, #0x00
	sbc	a, -5 (ix)
	ld	d,a
	ld	a,b
	ld	l,a
	rla
	sbc	a, a
	ld	h,a
	ld	a,e
	sub	a, l
	ld	a,d
	sbc	a, h
	jp	PO, 00171$
	xor	a, #0x80
00171$:
	jp	P,00102$
;src/Enemy.c:108: e1 -= dy;
	ld	a,b
	sub	a, -9 (ix)
	ld	b,a
;src/Enemy.c:109: x0 += sx;
	ld	a,c
	add	a, -8 (ix)
	ld	c,a
00102$:
;src/Enemy.c:111: if (e2 < dy) {
	ld	a,-12 (ix)
	sub	a, -9 (ix)
	jp	PO, 00172$
	xor	a, #0x80
00172$:
	jp	P,00104$
;src/Enemy.c:112: e1 += dx;
	ld	a,b
	add	a, -7 (ix)
	ld	b,a
;src/Enemy.c:113: y0 += sy;
	ld	a,-14 (ix)
	add	a, -11 (ix)
	ld	-14 (ix),a
00104$:
;src/Enemy.c:116: if((*(u8*)(MAP_MEM+(x0+(y0*MAP_WIDTH)))&(mask))||(
	ld	a,c
	ld	e,a
	rla
	sbc	a, a
	ld	d,a
	ld	a,-14 (ix)
	ld	-2 (ix),a
	ld	a,-14 (ix)
	rla
	sbc	a, a
	ld	-1 (ix),a
	ld	a,-2 (ix)
	ld	-4 (ix),a
	ld	a,-1 (ix)
	ld	-3 (ix),a
	ld	a,#0x05+1
	jr	00174$
00173$:
	sla	-4 (ix)
	rl	-3 (ix)
00174$:
	dec	a
	jr	NZ,00173$
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	add	hl,de
	push	de
	ld	de,#0x88D0
	add	hl, de
	pop	de
	ld	a,(hl)
	and	a, -10 (ix)
	or	a, a
	jr	NZ,00105$
;src/Enemy.c:117: (*(u8*)(MAP_MEM+((x0)+((y0-sy)*MAP_WIDTH)))&(mask))&&
	ld	l,-11 (ix)
	ld	a,-11 (ix)
	rla
	sbc	a, a
	ld	h,a
	ld	a,-2 (ix)
	sub	a, l
	ld	l,a
	ld	a,-1 (ix)
	sbc	a, h
	ld	h,a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,de
	push	de
	ld	de,#0x88D0
	add	hl, de
	pop	de
	ld	a,(hl)
	and	a, -10 (ix)
	or	a, a
	jr	Z,00106$
;src/Enemy.c:118: (*(u8*)(MAP_MEM+((x0-sx)+(y0*MAP_WIDTH)))&(mask))
	ld	l,-8 (ix)
	ld	a,-8 (ix)
	rla
	sbc	a, a
	ld	h,a
	ld	a,e
	sub	a, l
	ld	e,a
	ld	a,d
	sbc	a, h
	ld	d,a
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	add	hl,de
	ld	de,#0x88D0
	add	hl,de
	ld	a,(hl)
	and	a, -10 (ix)
	or	a, a
	jr	Z,00106$
00105$:
;src/Enemy.c:121: return 0;
	ld	l,#0x00
	jr	00115$
00106$:
;src/Enemy.c:123: if ((x0==x1 && y0==y1)){
	ld	a,-13 (ix)
	sub	a, c
	jp	NZ,00113$
	ld	a,-14 (ix)
	sub	a, -15 (ix)
	jp	NZ,00113$
;src/Enemy.c:128: return 1;
	ld	l,#0x01
00115$:
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:131: u8 enemy_is_adjacent_to_player(Enemy* e){    
;	---------------------------------
; Function enemy_is_adjacent_to_player
; ---------------------------------
_enemy_is_adjacent_to_player::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;src/Enemy.c:132: return (dist(player_position.x,player_position.y,e->position.x,e->position.y)==1);
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	pop	iy
	ld	de, #0x0004
	add	hl, de
	ld	a,(hl)
	ld	-1 (ix),a
	ld	a,3 (iy)
	ld	-2 (ix),a
	ld	hl, #_player_position + 1
	ld	c,(hl)
	ld	hl, #_player_position + 0
	ld	e,(hl)
	ld	h,-1 (ix)
	ld	l,-2 (ix)
	push	hl
	ld	d, c
	push	de
	call	_dist
	pop	af
	pop	af
	dec	l
	jr	NZ,00103$
	ld	a,#0x01
	jr	00104$
00103$:
	xor	a,a
00104$:
	ld	l,a
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:136: void enemy_new_enemy(Vec2u* position) {
;	---------------------------------
; Function enemy_new_enemy
; ---------------------------------
_enemy_new_enemy::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	dec	sp
;src/Enemy.c:138: Enemy* enemy=(enemyArray+ENEMY_MAX_ENEMIES);
	ld	bc,#_enemyArray+120
;src/Enemy.c:141: x=position->x;
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	a,(hl)
	ld	-5 (ix),a
;src/Enemy.c:142: y=position->y;
	inc	hl
	ld	a,(hl)
	ld	-1 (ix),a
;src/Enemy.c:144: memPos = (MAP_MEM+x+(y*MAP_WIDTH));
	ld	e,-5 (ix)
	ld	d,#0x00
	ld	hl,#0x88D0
	add	hl,de
	ex	de,hl
	ld	l,-1 (ix)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,de
	ld	-3 (ix),l
	ld	-2 (ix),h
;src/Enemy.c:146: while(i){
	ld	-4 (ix),#0x0F
00103$:
	ld	a,-4 (ix)
	or	a, a
	jp	Z,00106$
;src/Enemy.c:147: --i;
	dec	-4 (ix)
;src/Enemy.c:148: --enemy;
	ld	a,c
	add	a,#0xF8
	ld	c,a
	ld	a,b
	adc	a,#0xFF
	ld	b,a
;src/Enemy.c:149: if(enemy->hitPoints==0){
	ld	hl,#0x0005
	add	hl,bc
	ex	de,hl
	ld	a,(de)
	or	a, a
	jr	NZ,00103$
;src/Enemy.c:150: enemy->id=i;
	ld	a,-4 (ix)
	ld	(bc),a
;src/Enemy.c:152: enemy->type=cpct_getRandom_mxor_u8()&1;
	ld	l, c
	ld	h, b
	inc	hl
	push	hl
	push	bc
	push	de
	call	_cpct_getRandom_mxor_u8
	ld	a,l
	pop	de
	pop	bc
	pop	hl
	and	a, #0x01
	ld	(hl),a
;src/Enemy.c:154: enemy->hitPoints=ENEMY_INITIAL_HP;
	ld	a,#0xFF
	ld	(de),a
;src/Enemy.c:156: enemy->attackValue = (10)+level_get_level()+(cpct_getRandom_mxor_u8()&7);
	ld	hl,#0x0006
	add	hl,bc
	push	hl
	push	bc
	call	_level_get_level
	ld	a,l
	pop	bc
	pop	hl
	add	a, #0x0A
	ld	e,a
	push	hl
	push	bc
	push	de
	call	_cpct_getRandom_mxor_u8
	ld	a,l
	pop	de
	pop	bc
	pop	hl
	and	a, #0x07
	add	a,e
	ld	(hl),a
;src/Enemy.c:157: enemy->defenseValue = level_get_level()+(cpct_getRandom_mxor_u8()&7);
	ld	hl,#0x0007
	add	hl,bc
	push	hl
	push	bc
	call	_level_get_level
	ld	e,l
	push	de
	call	_cpct_getRandom_mxor_u8
	ld	a,l
	pop	de
	pop	bc
	pop	hl
	and	a, #0x07
	add	a,e
	ld	(hl),a
;src/Enemy.c:159: enemy->direction=(cpct_getRandom_mxor_u8()&3)*2;
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	push	bc
	push	de
	call	_cpct_getRandom_mxor_u8
	pop	de
	pop	bc
	ld	a,l
	and	a, #0x03
	add	a, a
	ld	(de),a
;src/Enemy.c:161: enemy->position.x = x;
	inc	bc
	inc	bc
	inc	bc
	ld	a,-5 (ix)
	ld	(bc),a
;src/Enemy.c:162: enemy->position.y = y;
	inc	bc
	ld	a,-1 (ix)
	ld	(bc),a
;src/Enemy.c:164: *memPos=(i+1)|(*memPos);
	ld	c,-4 (ix)
	inc	c
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	a,(hl)
	or	a, c
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	(hl),a
;src/Enemy.c:166: ++activeEnemies;
	ld	hl, #_activeEnemies+0
	inc	(hl)
;src/Enemy.c:167: break;
00106$:
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:213: u8 enemy_try_new_spawn(){
;	---------------------------------
; Function enemy_try_new_spawn
; ---------------------------------
_enemy_try_new_spawn::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-7
	add	hl,sp
	ld	sp,hl
;src/Enemy.c:216: if(activeEnemies<ENEMY_MAX_ENEMIES){
	ld	a,(#_activeEnemies + 0)
	sub	a, #0x0F
	jr	NC,00106$
;src/Enemy.c:217: pos.x=cpct_getRandom_mxor_u8()%MAP_WIDTH;
	ld	hl,#0x0000
	add	hl,sp
	push	hl
	call	_cpct_getRandom_mxor_u8
	ld	a,l
	pop	hl
	and	a, #0x1F
	ld	(hl),a
;src/Enemy.c:218: pos.y=cpct_getRandom_mxor_u8()%MAP_HEIGHT;
	ld	hl,#0x0000
	add	hl,sp
	ld	-2 (ix),l
	ld	-1 (ix),h
	inc	hl
	push	hl
	call	_cpct_getRandom_mxor_u8
	pop	bc
	ld	a,l
	and	a, #0x1F
	ld	-3 (ix), a
	ld	(bc),a
;src/Enemy.c:220: if((*(u8*)(MAP_MEM+pos.x+(pos.y*MAP_WIDTH))&(CELL_WALL_MASK|CELL_ENEMY_MASK))==0){
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-4 (ix), a
	ld	e, a
	ld	d,#0x00
	ld	hl,#0x88D0
	add	hl,de
	ex	de,hl
	ld	a,(bc)
	ld	-5 (ix),a
	ld	l,-3 (ix)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,de
	ld	a,(hl)
	and	a, #0x8F
	jr	NZ,00106$
;src/Enemy.c:221: if(dist(player_position.x, player_position.y, pos.x, pos.y)>ENEMY_VIEW_DISTANCE){
	ld	hl, #_player_position + 1
	ld	c,(hl)
	ld	hl, #_player_position + 0
	ld	e,(hl)
	ld	h,-5 (ix)
	ld	l,-4 (ix)
	push	hl
	ld	d, c
	push	de
	call	_dist
	pop	af
	pop	af
	ld	a,#0x06
	sub	a, l
	jr	NC,00106$
;src/Enemy.c:222: enemy_new_enemy(&pos);
	ld	c,-2 (ix)
	ld	b,-1 (ix)
	push	bc
	call	_enemy_new_enemy
	pop	af
;src/Enemy.c:223: return 1;
	ld	l,#0x01
	jr	00107$
00106$:
;src/Enemy.c:227: return 0;
	ld	l,#0x00
00107$:
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:230: u8 enemy_collision_at_dir(Vec2u* pos, u8 dir){
;	---------------------------------
; Function enemy_collision_at_dir
; ---------------------------------
_enemy_collision_at_dir::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;src/Enemy.c:235: dx = movement_directionArray[dir];
	ld	bc,#_movement_directionArray+0
	ld	l,6 (ix)
	ld	h,#0x00
	add	hl,bc
	ld	e,(hl)
;src/Enemy.c:236: dy = movement_directionArray[dir+1];
	ld	d,6 (ix)
	inc	d
	ld	l,d
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-3 (ix),a
;src/Enemy.c:238: val = *(u8*)(MAP_MEM + (pos->x + dx) + ((pos->y + dy)*MAP_WIDTH));
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	a,(bc)
	ld	l,a
	ld	h,#0x00
	ld	a,e
	rla
	sbc	a, a
	ld	d,a
	add	hl,de
	ld	-2 (ix),l
	ld	-1 (ix),h
	ex	de,hl
	ld	hl,#0x88D0
	add	hl,de
	ex	de,hl
	ld	l, c
	ld	h, b
	inc	hl
	ld	c,(hl)
	ld	b,#0x00
	ld	l,-3 (ix)
	ld	a,-3 (ix)
	rla
	sbc	a, a
	ld	h,a
	add	hl,bc
	ld	c,l
	ld	b,h
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,de
	ld	a,(hl)
;src/Enemy.c:240: if((val & (CELL_WALL_MASK|CELL_ENEMY_MASK)) || (((pos->x + dx) == player_position.x) && ((pos->y + dy) == player_position.y))) return 1;
	and	a, #0x8F
	jr	NZ,00101$
	ld	hl,#_player_position+0
	ld	e,(hl)
	ld	d,#0x00
	ld	a,-2 (ix)
	sub	a, e
	jr	NZ,00102$
	ld	a,-1 (ix)
	sub	a, d
	jr	NZ,00102$
	ld	hl,#_player_position+1
	ld	e,(hl)
	ld	d,#0x00
	ld	a,c
	sub	a, e
	jr	NZ,00102$
	ld	a,b
	sub	a, d
	jr	NZ,00102$
00101$:
	ld	l,#0x01
	jr	00105$
00102$:
;src/Enemy.c:241: return 0;
	ld	l,#0x00
00105$:
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:244: u8 enemy_get_distance_to_obstacle(Enemy* e, u8 direction){
;	---------------------------------
; Function enemy_get_distance_to_obstacle
; ---------------------------------
_enemy_get_distance_to_obstacle::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-7
	add	hl,sp
	ld	sp,hl
;src/Enemy.c:250: dx = movement_directionArray[direction];
	ld	bc,#_movement_directionArray+0
	ld	l,6 (ix)
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-5 (ix),a
;src/Enemy.c:251: dy = movement_directionArray[direction+1];
	ld	e,6 (ix)
	inc	e
	ld	l,e
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-7 (ix),a
;src/Enemy.c:254: position.x = e->position.x;
	ld	hl,#0x0003
	add	hl,sp
	ld	c,l
	ld	b,h
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a,(hl)
	ld	(bc),a
;src/Enemy.c:255: position.y = e->position.y;
	ld	hl,#0x0003
	add	hl,sp
	ld	-2 (ix),l
	ld	-1 (ix),h
	inc	hl
	ld	c,l
	ld	b,h
	push	de
	pop	iy
	ld	a,4 (iy)
	ld	(bc),a
;src/Enemy.c:259: while(!(enemy_collision_at_dir(&position, direction))){
	ld	e,-2 (ix)
	ld	d,-1 (ix)
	ld	-6 (ix),#0x00
00101$:
	push	de
	pop	iy
	push	bc
	push	de
	ld	a,6 (ix)
	push	af
	inc	sp
	push	iy
	call	_enemy_collision_at_dir
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	a,l
	or	a, a
	jr	NZ,00103$
;src/Enemy.c:260: ++count;
	inc	-6 (ix)
;src/Enemy.c:261: position.x += dx;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a, (hl)
	add	a, -5 (ix)
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),a
;src/Enemy.c:262: position.y += dy;
	ld	a,(bc)
	add	a, -7 (ix)
	ld	(bc),a
	jr	00101$
00103$:
;src/Enemy.c:265: return count;
	ld	l,-6 (ix)
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:268: void enemy_remove(Enemy* e){
;	---------------------------------
; Function enemy_remove
; ---------------------------------
_enemy_remove::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Enemy.c:273: e->hitPoints=0;
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	hl,#0x0005
	add	hl,de
	ld	(hl),#0x00
;src/Enemy.c:275: (map[e->position.x + (e->position.y)*MAP_WIDTH]) &= (CELL_ITEM_MASK);
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	c,(hl)
	ld	b,#0x00
	push	de
	pop	iy
	ld	l,4 (iy)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	bc,#0x88D0
	add	hl,bc
	ld	a,(hl)
	and	a, #0x70
	ld	(hl),a
;src/Enemy.c:276: --activeEnemies;
	ld	hl, #_activeEnemies+0
	dec	(hl)
	pop	ix
	ret
;src/Enemy.c:279: void enemy_move(Enemy* e, u8 d){
;	---------------------------------
; Function enemy_move
; ---------------------------------
_enemy_move::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-8
	add	hl,sp
	ld	sp,hl
;src/Enemy.c:287: x = e->position.x;
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	hl,#0x0003
	add	hl,de
	ld	-6 (ix),l
	ld	-5 (ix),h
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	a,(hl)
	ld	-1 (ix),a
;src/Enemy.c:288: y = e->position.y;
	ld	hl,#0x0004
	add	hl,de
	ld	-3 (ix),l
	ld	-2 (ix),h
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	a,(hl)
	ld	-4 (ix),a
;src/Enemy.c:291: (map[x + (y)*MAP_WIDTH]) &= (CELL_ITEM_MASK);
	ld	c,-1 (ix)
	ld	b,#0x00
	ld	l,-4 (ix)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	bc,#0x88D0
	add	hl,bc
	ld	a,(hl)
	and	a, #0x70
	ld	(hl),a
;src/Enemy.c:293: dx=movement_directionArray[d];
	ld	bc,#_movement_directionArray+0
	ld	l,6 (ix)
	ld	h,#0x00
	add	hl,bc
	ld	a,(hl)
	ld	-7 (ix),a
;src/Enemy.c:294: dy=movement_directionArray[d+1];
	ld	l,6 (ix)
	inc	l
	ld	h,#0x00
	add	hl,bc
	ld	b,(hl)
;src/Enemy.c:297: x+=dx;
	ld	a, -1 (ix)
	add	a, -7 (ix)
	ld	c,a
;src/Enemy.c:298: y+=dy;
	ld	a, -4 (ix)
	add	a, b
	ld	-8 (ix),a
;src/Enemy.c:300: e->direction = d;
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a,6 (ix)
	ld	(hl),a
;src/Enemy.c:302: e->position.x = x;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	(hl),c
;src/Enemy.c:303: e->position.y = y;
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	a,-8 (ix)
	ld	(hl),a
;src/Enemy.c:306: (map[x + (y)*MAP_WIDTH]) |= ((e->id)+1);
	ld	b,#0x00
	ld	l,-8 (ix)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	push	hl
	pop	iy
	ld	bc,#0x88D0
	add	iy, bc
	ld	c, 0 (iy)
	ld	a,(de)
	inc	a
	or	a, c
	ld	0 (iy), a
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:309: u8 enemy_attack_enemy(Enemy* e){
;	---------------------------------
; Function enemy_attack_enemy
; ---------------------------------
_enemy_attack_enemy::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/Enemy.c:311: const char* t = "    DMG";
;src/Enemy.c:312: dmg = (player_attack_value - e->defenseValue);
	ld	c,4 (ix)
	ld	b,5 (ix)
	push	bc
	pop	iy
	ld	e,7 (iy)
	ld	a,(#_player_attack_value + 0)
	sub	a, e
;src/Enemy.c:313: if(dmg<1) dmg = 1;
	ld	-1 (ix), a
	xor	a, #0x80
	sub	a, #0x81
	jr	NC,00102$
	ld	-1 (ix),#0x01
00102$:
;src/Enemy.c:315: cpct_memcpy(t,integer_to_string(dmg,'d'),3);
	push	bc
	ld	a,#0x64
	push	af
	inc	sp
	ld	a,-1 (ix)
	push	af
	inc	sp
	call	_integer_to_string
	pop	af
	ld	de,#0x0003
	push	de
	push	hl
	ld	hl,#___str_0
	push	hl
	call	_cpct_memcpy
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#___str_1
	push	hl
	call	_ui_log_add_log
	pop	af
	inc	sp
	ld	a,#0x05
	push	af
	inc	sp
	ld	hl,#___str_0
	push	hl
	call	_ui_log_add_log
	pop	af
	inc	sp
	call	_ui_log_render
	pop	bc
;src/Enemy.c:320: if(e->hitPoints>(u8)dmg){
	ld	hl,#0x0005
	add	hl,bc
	ld	e,(hl)
	ld	a, -1 (ix)
	sub	a, e
	jr	NC,00107$
;src/Enemy.c:321: e->hitPoints -= dmg;
	ld	a,e
	sub	a, -1 (ix)
	ld	(hl),a
;src/Enemy.c:322: return 0;
	ld	l,#0x00
	jr	00109$
00107$:
;src/Enemy.c:326: enemy_remove(e);
	push	bc
	push	bc
	call	_enemy_remove
	pop	af
	call	_cpct_getRandom_mxor_u8
	pop	bc
	bit	0, l
	jr	NZ,00103$
	push	bc
	call	_level_get_level
	pop	bc
	ld	a,l
	sub	a, #0x20
	jr	NZ,00104$
00103$:
;src/Enemy.c:329: item_try_new_spawn_at(&(e->position));
	inc	bc
	inc	bc
	inc	bc
	ld	h,b
	ld	l, c
	push	hl
	call	_item_try_new_spawn_at
	pop	af
00104$:
;src/Enemy.c:332: return 1;
	ld	l,#0x01
00109$:
	inc	sp
	pop	ix
	ret
___str_0:
	.ascii "    DMG"
	.db 0x00
___str_1:
	.ascii "YOU MAKE"
	.db 0x00
;src/Enemy.c:336: void enemy_attack(Enemy* e){
;	---------------------------------
; Function enemy_attack
; ---------------------------------
_enemy_attack::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Enemy.c:338: const char* t = "    HP";
;src/Enemy.c:339: dmg = (e->attackValue - player_defense_value);
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	de, #0x0006
	add	hl, de
	ld	c,(hl)
	ld	hl,#_player_defense_value
	ld	a,c
	sub	a, (hl)
;src/Enemy.c:340: if(dmg<1) dmg = 1;
	ld	b,a
	xor	a, #0x80
	sub	a, #0x81
	jr	NC,00102$
	ld	b,#0x01
00102$:
;src/Enemy.c:342: cpct_memcpy(t,integer_to_string(dmg,'d'),3);
	push	bc
	ld	a,#0x64
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_integer_to_string
	pop	af
	ld	de,#0x0003
	push	de
	push	hl
	ld	hl,#___str_2
	push	hl
	call	_cpct_memcpy
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#___str_3
	push	hl
	call	_ui_log_add_log
	pop	af
	inc	sp
	ld	a,#0x04
	push	af
	inc	sp
	ld	hl,#___str_2
	push	hl
	call	_ui_log_add_log
	pop	af
	inc	sp
	call	_ui_log_render
	pop	bc
;src/Enemy.c:347: if(player_health_points>(u8)dmg){
	ld	a, b
	ld	iy,#_player_health_points
	sub	a, 0 (iy)
	jr	NC,00104$
;src/Enemy.c:348: player_health_points -= dmg;
	ld	a,(#_player_health_points + 0)
	ld	hl, #_player_health_points
	sub	a, b
	ld	(hl),a
	jr	00105$
00104$:
;src/Enemy.c:351: player_is_dead = 1;
	ld	hl,#_player_is_dead + 0
	ld	(hl), #0x01
00105$:
;src/Enemy.c:353: ui_playerstats_render_hp();
	call	_ui_playerstats_render_hp
	pop	ix
	ret
___str_2:
	.ascii "    HP"
	.db 0x00
___str_3:
	.ascii "YOU LOSE"
	.db 0x00
;src/Enemy.c:356: void enemy_go_to_player(Enemy* e){//NOT WORKING
;	---------------------------------
; Function enemy_go_to_player
; ---------------------------------
_enemy_go_to_player::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;src/Enemy.c:361: dx=player_position.x-e->position.x;
	ld	hl,#_player_position+0
	ld	e,(hl)
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	hl,#0x0003
	add	hl,bc
	ld	-3 (ix),l
	ld	-2 (ix),h
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	d,(hl)
	ld	a,e
	sub	a, d
	ld	-4 (ix),a
;src/Enemy.c:362: dy=player_position.y-e->position.y;
	ld	hl,#_player_position+1
	ld	e,(hl)
	push	bc
	pop	iy
	ld	d,4 (iy)
	ld	a,e
	sub	a, d
	ld	l,a
;src/Enemy.c:364: dirX = (dx>0)?MOVEMENT_EAST:MOVEMENT_WEST;
	xor	a, a
	sub	a, -4 (ix)
	jp	PO, 00136$
	xor	a, #0x80
00136$:
	jp	P,00112$
	ld	e,#0x00
	jr	00113$
00112$:
	ld	e,#0x04
00113$:
;src/Enemy.c:365: dirY = (dy>0)?MOVEMENT_SOUTH:MOVEMENT_NORTH;
	xor	a, a
	sub	a, l
	jp	PO, 00137$
	xor	a, #0x80
00137$:
	jp	P,00114$
	ld	d,#0x06
	jr	00115$
00114$:
	ld	d,#0x02
00115$:
;src/Enemy.c:367: if(abs(dx)>abs(dy)){
	push	hl
	push	bc
	push	de
	ld	a,-4 (ix)
	push	af
	inc	sp
	call	_abs
	inc	sp
	ld	-1 (ix),l
	pop	de
	pop	bc
	pop	hl
	push	bc
	push	de
	ld	a,l
	push	af
	inc	sp
	call	_abs
	inc	sp
	pop	de
	pop	bc
	ld	a,l
	sub	a, -1 (ix)
	jp	PO, 00138$
	xor	a, #0x80
00138$:
	jp	P,00108$
;src/Enemy.c:368: if(!enemy_collision_at_dir(&(e->position),dirX)){
	push	bc
	push	de
	ld	a,e
	push	af
	inc	sp
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	push	hl
	call	_enemy_collision_at_dir
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	a,l
	or	a, a
	jr	NZ,00102$
;src/Enemy.c:371: enemy_move(e, dirX);
	ld	a,e
	push	af
	inc	sp
	push	bc
	call	_enemy_move
	pop	af
	inc	sp
	jr	00110$
00102$:
;src/Enemy.c:376: enemy_move(e, dirY);
	push	de
	inc	sp
	push	bc
	call	_enemy_move
	pop	af
	inc	sp
	jr	00110$
00108$:
;src/Enemy.c:380: if(!enemy_collision_at_dir(&(e->position),dirY)){
	push	bc
	push	de
	push	de
	inc	sp
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	push	hl
	call	_enemy_collision_at_dir
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	a,l
	or	a, a
	jr	NZ,00105$
;src/Enemy.c:383: enemy_move(e, dirY);
	push	de
	inc	sp
	push	bc
	call	_enemy_move
	pop	af
	inc	sp
	jr	00110$
00105$:
;src/Enemy.c:388: enemy_move(e, dirX);
	ld	a,e
	push	af
	inc	sp
	push	bc
	call	_enemy_move
	pop	af
	inc	sp
00110$:
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:394: void enemy_flee(Enemy* e) {
;	---------------------------------
; Function enemy_flee
; ---------------------------------
_enemy_flee::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-7
	add	hl,sp
	ld	sp,hl
;src/Enemy.c:398: distFromPlayX = abs(player_position.x - e->position.x);
	ld	a,(#_player_position+0)
	ld	-1 (ix),a
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ld	a,(de)
	ld	l,a
	ld	a,-1 (ix)
	sub	a, l
	ld	h,a
	push	bc
	push	de
	push	hl
	inc	sp
	call	_abs
	inc	sp
	pop	de
	pop	bc
	ld	-6 (ix),l
;src/Enemy.c:399: distFromPlayY = abs(player_position.y - e->position.y);
	ld	a,(#(_player_position + 0x0001) + 0)
	ld	-1 (ix),a
	ld	hl,#0x0004
	add	hl,bc
	ld	-3 (ix),l
	ld	-2 (ix),h
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	l,(hl)
	ld	a,-1 (ix)
	sub	a, l
	ld	h,a
	push	bc
	push	de
	push	hl
	inc	sp
	call	_abs
	inc	sp
	pop	de
	pop	bc
;src/Enemy.c:401: if(distFromPlayX>distFromPlayY){//Flee X
	ld	a,l
	sub	a, -6 (ix)
	jr	NC,00102$
;src/Enemy.c:402: fleeFromDir=(player_position.x<e->position.x)?MOVEMENT_EAST:MOVEMENT_WEST;
	ld	a,(#_player_position + 0)
	ld	-1 (ix),a
	ld	a,(de)
	ld	e,a
	ld	a,-1 (ix)
	sub	a, e
	jr	NC,00120$
	ld	a,#0x00
	jr	00103$
00120$:
	ld	a,#0x04
	jr	00103$
00102$:
;src/Enemy.c:405: fleeFromDir=(player_position.y<e->position.y)?MOVEMENT_NORTH:MOVEMENT_SOUTH;
	ld	hl, #(_player_position + 0x0001) + 0
	ld	e,(hl)
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	d,(hl)
	ld	a,e
	sub	a, d
	jr	NC,00122$
	ld	a,#0x02
	jr	00123$
00122$:
	ld	a,#0x06
00123$:
00103$:
;src/Enemy.c:408: df = (fleeFromDir+4)&7;
	add	a, #0x04
	and	a, #0x07
;src/Enemy.c:409: dl = (df+2)&7;
	ld	-5 (ix), a
	add	a, #0x02
	and	a, #0x07
	ld	-7 (ix),a
;src/Enemy.c:410: dr = (df-2)&7;
	ld	a,-5 (ix)
	add	a,#0xFE
	and	a, #0x07
	ld	e,a
;src/Enemy.c:412: distf = enemy_get_distance_to_obstacle(e, df);
	push	bc
	push	de
	ld	a,-5 (ix)
	push	af
	inc	sp
	push	bc
	call	_enemy_get_distance_to_obstacle
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	-4 (ix),l
;src/Enemy.c:413: distl = enemy_get_distance_to_obstacle(e, dl);
	push	bc
	push	de
	ld	a,-7 (ix)
	push	af
	inc	sp
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_enemy_get_distance_to_obstacle
	pop	af
	inc	sp
	pop	de
	pop	bc
;src/Enemy.c:414: distr = enemy_get_distance_to_obstacle(e, dr);
	push	hl
	push	bc
	push	de
	ld	a,e
	push	af
	inc	sp
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_enemy_get_distance_to_obstacle
	pop	af
	inc	sp
	ld	a,l
	pop	de
	pop	bc
	pop	hl
	ld	d,a
;src/Enemy.c:416: if(distf>distl && distf>distr){
	ld	a,l
	sub	a, -4 (ix)
	jr	NC,00113$
	ld	a,d
	sub	a, -4 (ix)
	jr	NC,00113$
;src/Enemy.c:417: d = df;
	ld	e,-5 (ix)
;src/Enemy.c:418: dist = distf;
	ld	l,-4 (ix)
	jr	00114$
00113$:
;src/Enemy.c:420: else if(distl>distf && distl>distr){
	ld	a,-4 (ix)
	sub	a, l
	jr	NC,00109$
	ld	a,d
	sub	a, l
	jr	NC,00109$
;src/Enemy.c:421: d=dl;
	ld	e,-7 (ix)
;src/Enemy.c:422: dist=distl;
	jr	00114$
00109$:
;src/Enemy.c:424: else if(distr>distf && distr>distl){
	ld	a,-4 (ix)
	sub	a, d
	jr	NC,00105$
	ld	a,l
	sub	a, d
	jr	NC,00105$
;src/Enemy.c:425: d=dr;
;src/Enemy.c:426: dist=distr;
	ld	l,d
	jr	00114$
00105$:
;src/Enemy.c:429: d=df;
	ld	e,-5 (ix)
;src/Enemy.c:430: dist=distf;
	ld	l,-4 (ix)
00114$:
;src/Enemy.c:433: if(dist){
	ld	a,l
	or	a, a
	jr	Z,00118$
;src/Enemy.c:434: enemy_move(e,d);
	ld	a,e
	push	af
	inc	sp
	push	bc
	call	_enemy_move
	pop	af
	inc	sp
00118$:
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:439: void enemy_roam(Enemy* e) {
;	---------------------------------
; Function enemy_roam
; ---------------------------------
_enemy_roam::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-8
	add	hl,sp
	ld	sp,hl
;src/Enemy.c:440: u8 d, nd=0;
	ld	c,#0x00
;src/Enemy.c:444: d = e->direction;
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
	ld	e,-2 (ix)
	ld	d,-1 (ix)
	inc	de
	inc	de
	ld	a,(de)
	ld	b,a
;src/Enemy.c:445: pos = &(e->position);
	ld	a,-2 (ix)
	add	a, #0x03
	ld	-8 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-7 (ix),a
;src/Enemy.c:447: if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
	push	bc
	push	de
	push	bc
	inc	sp
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	_enemy_collision_at_dir
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	a,l
	or	a, a
	jr	NZ,00102$
;src/Enemy.c:449: directions[nd]=d;
	ld	hl,#0x0002
	add	hl,sp
	ld	(hl),b
;src/Enemy.c:450: ++nd;
	ld	c,#0x01
00102$:
;src/Enemy.c:454: d=((e->direction+2)&7);
	ld	a,(de)
	add	a, #0x02
	and	a, #0x07
	ld	b,a
;src/Enemy.c:456: if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
	push	bc
	push	de
	push	bc
	inc	sp
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	_enemy_collision_at_dir
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	a,l
	or	a, a
	jr	NZ,00104$
;src/Enemy.c:458: directions[nd]=d;
	ld	hl,#0x0002
	add	hl,sp
	ld	a,l
	add	a, c
	ld	l,a
	ld	a,h
	adc	a, #0x00
	ld	h,a
	ld	(hl),b
;src/Enemy.c:459: ++nd;
	inc	c
00104$:
;src/Enemy.c:463: d=((e->direction-2)&7);
	ld	a,(de)
	add	a,#0xFE
	and	a, #0x07
	ld	b,a
;src/Enemy.c:465: if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
	push	bc
	push	de
	push	bc
	inc	sp
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	_enemy_collision_at_dir
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	a,l
	or	a, a
	jr	NZ,00106$
;src/Enemy.c:467: directions[nd]=d;
	ld	hl,#0x0002
	add	hl,sp
	ld	a,l
	add	a, c
	ld	l,a
	ld	a,h
	adc	a, #0x00
	ld	h,a
	ld	(hl),b
;src/Enemy.c:468: ++nd;
	inc	c
00106$:
;src/Enemy.c:472: if(nd==0){//If cannot move any other direction than back
	ld	a,c
	or	a, a
	jr	NZ,00110$
;src/Enemy.c:474: d=((e->direction+4)&7);
	ld	a,(de)
	add	a, #0x04
	and	a, #0x07
	ld	b,a
;src/Enemy.c:476: if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
	push	bc
	push	bc
	inc	sp
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	_enemy_collision_at_dir
	pop	af
	inc	sp
	pop	bc
	ld	a,l
	or	a, a
	jr	NZ,00111$
;src/Enemy.c:478: ++nd;
	inc	c
	jr	00111$
00110$:
;src/Enemy.c:483: d=directions[cpct_getRandom_mxor_u8()%(nd)];
	ld	hl,#0x0002
	add	hl,sp
	push	hl
	push	bc
	call	_cpct_getRandom_mxor_u8
	ld	d,l
	pop	bc
	push	bc
	ld	a,c
	push	af
	inc	sp
	push	de
	inc	sp
	call	__moduchar
	pop	af
	ld	e,l
	pop	bc
	pop	hl
	ld	d,#0x00
	add	hl,de
	ld	b,(hl)
00111$:
;src/Enemy.c:486: if(nd){//If can move
	ld	a,c
	or	a, a
	jr	Z,00114$
;src/Enemy.c:487: enemy_move(e, d);
	push	bc
	inc	sp
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	_enemy_move
	pop	af
	inc	sp
00114$:
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:491: void enemy_AI_passive(Enemy* e) {
;	---------------------------------
; Function enemy_AI_passive
; ---------------------------------
_enemy_AI_passive::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;src/Enemy.c:494: x = e->position.x;
	ld	c,4 (ix)
	ld	b,5 (ix)
	push	bc
	pop	iy
	ld	a,3 (iy)
	ld	-2 (ix),a
;src/Enemy.c:495: y = e->position.y;
	ld	l, c
	ld	h, b
	ld	de, #0x0004
	add	hl, de
	ld	e,(hl)
;src/Enemy.c:497: hp=e->hitPoints;
	push	bc
	pop	iy
	ld	a,5 (iy)
	ld	-3 (ix),a
;src/Enemy.c:499: if(dist(player_position.x, player_position.y, x,y)<ENEMY_VIEW_DISTANCE){
	ld	hl, #_player_position + 1
	ld	d,(hl)
	ld	a,(#_player_position + 0)
	ld	-1 (ix),a
	push	bc
	ld	a,e
	push	af
	inc	sp
	ld	a,-2 (ix)
	push	af
	inc	sp
	push	de
	inc	sp
	ld	a,-1 (ix)
	push	af
	inc	sp
	call	_dist
	pop	af
	pop	af
	pop	bc
	ld	a,l
	sub	a, #0x06
	jr	NC,00112$
;src/Enemy.c:500: if(enemy_can_view(e)){
	push	bc
	push	bc
	call	_enemy_can_view
	pop	af
	pop	bc
	ld	a,l
	or	a, a
	jr	Z,00112$
;src/Enemy.c:501: if(hp < ENEMY_INITIAL_HP){//Aggresive
	ld	a,-3 (ix)
	sub	a, #0xFF
	jr	NC,00107$
;src/Enemy.c:502: if(enemy_is_adjacent_to_player(e)){//Attack
	push	bc
	push	bc
	call	_enemy_is_adjacent_to_player
	pop	af
	pop	bc
	ld	a,l
	or	a, a
	jr	Z,00102$
;src/Enemy.c:503: enemy_attack(e);
	push	bc
	call	_enemy_attack
	pop	af
;src/Enemy.c:504: return;
	jr	00113$
00102$:
;src/Enemy.c:507: enemy_go_to_player(e);
	push	bc
	call	_enemy_go_to_player
	pop	af
;src/Enemy.c:508: return;
	jr	00113$
00107$:
;src/Enemy.c:511: else if(hp < ENEMY_INITIAL_HP/4){ //Flee
	ld	a,-3 (ix)
	sub	a, #0x3F
	jr	NC,00112$
;src/Enemy.c:512: enemy_flee(e);
	push	bc
	call	_enemy_flee
	pop	af
;src/Enemy.c:513: return;
	jr	00113$
00112$:
;src/Enemy.c:517: enemy_roam(e);   
	push	bc
	call	_enemy_roam
	pop	af
00113$:
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:520: void enemy_AI_aggressive(Enemy* e){
;	---------------------------------
; Function enemy_AI_aggressive
; ---------------------------------
_enemy_AI_aggressive::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;src/Enemy.c:523: x = e->position.x;
	ld	c,4 (ix)
	ld	b,5 (ix)
	push	bc
	pop	iy
	ld	a,3 (iy)
	ld	-2 (ix),a
;src/Enemy.c:524: y = e->position.y;
	push	bc
	pop	iy
	ld	a,4 (iy)
	ld	-1 (ix),a
;src/Enemy.c:526: if(dist(player_position.x, player_position.y, x,y)<ENEMY_VIEW_DISTANCE){
	ld	hl, #_player_position + 1
	ld	d,(hl)
	ld	hl, #_player_position + 0
	ld	e,(hl)
	push	bc
	ld	h,-1 (ix)
	ld	l,-2 (ix)
	push	hl
	push	de
	call	_dist
	pop	af
	pop	af
	pop	bc
	ld	a,l
	sub	a, #0x06
	jr	NC,00107$
;src/Enemy.c:527: if(enemy_can_view(e)){
	push	bc
	push	bc
	call	_enemy_can_view
	pop	af
	pop	bc
	ld	a,l
	or	a, a
	jr	Z,00107$
;src/Enemy.c:528: if(enemy_is_adjacent_to_player(e)){//Attack
	push	bc
	push	bc
	call	_enemy_is_adjacent_to_player
	pop	af
	pop	bc
	ld	a,l
	or	a, a
	jr	Z,00102$
;src/Enemy.c:529: enemy_attack(e);
	push	bc
	call	_enemy_attack
	pop	af
;src/Enemy.c:530: return;
	jr	00108$
00102$:
;src/Enemy.c:533: enemy_go_to_player(e);
	push	bc
	call	_enemy_go_to_player
	pop	af
;src/Enemy.c:534: return;
	jr	00108$
00107$:
;src/Enemy.c:538: enemy_roam(e);     
	push	bc
	call	_enemy_roam
	pop	af
00108$:
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:585: void enemy_update(){
;	---------------------------------
; Function enemy_update
; ---------------------------------
_enemy_update::
;src/Enemy.c:587: Enemy* enemy=enemyArray;
	ld	bc,#_enemyArray+0
;src/Enemy.c:589: for(i;i;--i){
	ld	e,#0x0F
00108$:
	ld	a,e
	or	a, a
	ret	Z
;src/Enemy.c:590: if(enemy->hitPoints){
	push	bc
	pop	iy
	ld	a,5 (iy)
	or	a, a
	jr	Z,00105$
;src/Enemy.c:591: switch(enemy->type){
	ld	l, c
	ld	h, b
	inc	hl
	ld	d,(hl)
	ld	a,d
	or	a, a
	jr	Z,00101$
	dec	d
	jr	Z,00102$
	jr	00105$
;src/Enemy.c:592: case 0:{
00101$:
;src/Enemy.c:593: enemy_AI_passive(enemy);
	push	bc
	push	de
	push	bc
	call	_enemy_AI_passive
	pop	af
	pop	de
	pop	bc
;src/Enemy.c:594: break;
	jr	00105$
;src/Enemy.c:596: case 1:{
00102$:
;src/Enemy.c:597: enemy_AI_aggressive(enemy);
	push	bc
	push	de
	push	bc
	call	_enemy_AI_aggressive
	pop	af
	pop	de
	pop	bc
;src/Enemy.c:608: }
00105$:
;src/Enemy.c:610: ++enemy;
	ld	hl,#0x0008
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Enemy.c:589: for(i;i;--i){
	dec	e
	jr	00108$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
