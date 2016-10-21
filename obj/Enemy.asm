;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module Enemy
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _enemy_AI_shy
	.globl _enemy_AI_tactical
	.globl _enemy_AI_aggressive
	.globl _enemy_AI_passive
	.globl _enemy_roam
	.globl _enemy_new_enemy
	.globl _enemy_can_view
	.globl _dist
	.globl _abs
	.globl _ui_log_add_log
	.globl _integer_to_string
	.globl _cpct_getRandom_mxor_u8
	.globl _cpct_memset
	.globl _enemyArray
	.globl _activeEnemies
	.globl _enemy_get_at
	.globl _enemy_init_enemies
	.globl _enemy_try_new_spawn
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
	.ds 150
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
;src/Enemy.c:28: Enemy* const enemy_get_at(u8 index) __z88dk_fastcall{
;	---------------------------------
; Function enemy_get_at
; ---------------------------------
_enemy_get_at::
	ld	e,l
;src/Enemy.c:29: return (enemyArray+index);
	ld	bc,#_enemyArray+0
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl,bc
	ret
;src/Enemy.c:32: void enemy_init_enemies(){
;	---------------------------------
; Function enemy_init_enemies
; ---------------------------------
_enemy_init_enemies::
;src/Enemy.c:34: cpct_memset(enemyArray, 0, ENEMY_MAX_ENEMIES*sizeof(Enemy));
	ld	hl,#0x0096
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	hl,#_enemyArray
	push	hl
	call	_cpct_memset
;src/Enemy.c:35: activeEnemies=0;
	ld	hl,#_activeEnemies + 0
	ld	(hl), #0x00
;src/Enemy.c:37: while(activeEnemies<ENEMY_MAX_ENEMIES){
00101$:
	ld	a,(#_activeEnemies + 0)
	sub	a, #0x0F
	ret	NC
;src/Enemy.c:38: enemy_try_new_spawn();
	call	_enemy_try_new_spawn
	jr	00101$
;src/Enemy.c:44: i8 abs(i8 n) __z88dk_fastcall{
;	---------------------------------
; Function abs
; ---------------------------------
_abs::
;src/Enemy.c:45: if(n<0) n=-n;
	bit	7, l
	ret	Z
	xor	a, a
	sub	a, l
	ld	l,a
;src/Enemy.c:46: return n;
	ret
;src/Enemy.c:49: u8 dist(u8 x0, u8 y0, u8 x1, u8 y1){
;	---------------------------------
; Function dist
; ---------------------------------
_dist::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;src/Enemy.c:51: dx = abs(x1-x0);
	ld	a,6 (ix)
	sub	a, 4 (ix)
	ld	l,a
	call	_abs
	ld	c,l
;src/Enemy.c:52: dy = abs(y1-y0);
	ld	a,7 (ix)
	sub	a, 5 (ix)
	ld	l,a
	push	bc
	call	_abs
	pop	bc
;src/Enemy.c:54: if(dx>dy) return ((2*dx)+dy)/2;
	ld	-4 (ix),c
	ld	a,c
	rla
	sbc	a, a
	ld	-3 (ix),a
	ld	-2 (ix),l
	ld	a,l
	rla
	sbc	a, a
	ld	-1 (ix),a
	ld	a,l
	sub	a, c
	jp	PO, 00120$
	xor	a, #0x80
00120$:
	jp	P,00102$
	pop	hl
	push	hl
	add	hl, hl
	ld	e,-2 (ix)
	ld	d,-1 (ix)
	add	hl,de
	ld	e, l
	ld	d, h
	bit	7, h
	jr	Z,00106$
	ex	de,hl
	inc	de
00106$:
	sra	d
	rr	e
	ld	l,e
	jr	00104$
00102$:
;src/Enemy.c:55: else return ((2*dy)+dx)/2;
	pop	bc
	pop	hl
	push	hl
	push	bc
	add	hl, hl
	pop	de
	push	de
	add	hl,de
	ld	c, l
	ld	b, h
	bit	7, h
	jr	Z,00107$
	inc	hl
	ld	c,l
	ld	b,h
00107$:
	sra	b
	rr	c
	ld	l,c
00104$:
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:59: u8 enemy_can_view(u8 x0, u8 y0, u8 x1, u8 y1){
;	---------------------------------
; Function enemy_can_view
; ---------------------------------
_enemy_can_view::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-9
	add	hl,sp
	ld	sp,hl
;src/Enemy.c:63: dx = abs(x1-x0);
	ld	a,6 (ix)
	sub	a, 4 (ix)
	ld	l,a
	call	_abs
	ld	-9 (ix),l
;src/Enemy.c:64: dy = abs(y1-y0);
	ld	a,7 (ix)
	sub	a, 5 (ix)
	ld	l,a
	call	_abs
	ld	-7 (ix),l
;src/Enemy.c:66: sx = (x0<x1)?1:-1;
	ld	a,4 (ix)
	sub	a, 6 (ix)
	jr	NC,00117$
	ld	c,#0x01
	jr	00118$
00117$:
	ld	c,#0xFF
00118$:
;src/Enemy.c:67: sy = (y0<y1)?1:-1;
	ld	a,5 (ix)
	sub	a, 7 (ix)
	jr	NC,00119$
	ld	e,#0x01
	jr	00120$
00119$:
	ld	e,#0xFF
00120$:
	ld	-8 (ix),e
;src/Enemy.c:69: e1 = ((dx>dy)?dx:-dy)/2;
	ld	a,-9 (ix)
	ld	-4 (ix),a
	ld	a,-9 (ix)
	rla
	sbc	a, a
	ld	-3 (ix),a
	ld	a,-7 (ix)
	sub	a, -9 (ix)
	jp	PO, 00168$
	xor	a, #0x80
00168$:
	jp	P,00121$
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	jr	00122$
00121$:
	ld	e,-7 (ix)
	ld	a,-7 (ix)
	rla
	sbc	a, a
	ld	b,a
	xor	a, a
	sub	a, e
	ld	l,a
	ld	a, #0x00
	sbc	a, b
	ld	h,a
00122$:
	ld	b,l
	ld	d,h
	bit	7, h
	jr	Z,00123$
	inc	hl
	ld	b,l
	ld	d,h
00123$:
	ld	e, b
	sra	d
	rr	e
;src/Enemy.c:71: while(1){
00113$:
;src/Enemy.c:72: e2 = e1;
	ld	b,e
;src/Enemy.c:73: if (e2 >-dx) {
	xor	a, a
	sub	a, -4 (ix)
	ld	l,a
	ld	a, #0x00
	sbc	a, -3 (ix)
	ld	h,a
	ld	-2 (ix),e
	ld	a,e
	rla
	sbc	a, a
	ld	-1 (ix),a
	ld	a,l
	sub	a, -2 (ix)
	ld	a,h
	sbc	a, -1 (ix)
	jp	PO, 00169$
	xor	a, #0x80
00169$:
	jp	P,00102$
;src/Enemy.c:74: e1 -= dy;
	ld	a,e
	sub	a, -7 (ix)
	ld	e,a
;src/Enemy.c:75: x0 += sx;
	ld	l,4 (ix)
	add	hl, bc
	ld	4 (ix),l
00102$:
;src/Enemy.c:77: if (e2 < dy) {
	ld	a,b
	sub	a, -7 (ix)
	jp	PO, 00170$
	xor	a, #0x80
00170$:
	jp	P,00104$
;src/Enemy.c:78: e1 += dx;
	ld	a,e
	add	a, -9 (ix)
	ld	e,a
;src/Enemy.c:79: y0 += sy;
	ld	a, 5 (ix)
	add	a, -8 (ix)
	ld	5 (ix),a
00104$:
;src/Enemy.c:84: if((*(u8*)(MAP_MEM+(x0+(y0*MAP_WIDTH)))&CELL_WALL_MASK)||(
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
	ld	b,5 (ix)
	ld	d,#0x00
	ld	-6 (ix),b
	ld	-5 (ix),d
	ld	a,#0x05+1
	jr	00172$
00171$:
	sla	-6 (ix)
	rl	-5 (ix)
00172$:
	dec	a
	jr	NZ,00171$
	ld	a,-2 (ix)
	add	a, -6 (ix)
	ld	l,a
	ld	a,-1 (ix)
	adc	a, -5 (ix)
	ld	h,a
	push	de
	ld	de,#0x7000
	add	hl, de
	pop	de
	ld	h,(hl)
	add	hl, hl
	jr	C,00105$
;src/Enemy.c:85: (*(u8*)(MAP_MEM+((x0)+((y0-sy)*MAP_WIDTH)))&CELL_WALL_MASK)&&
	ld	l,-8 (ix)
	ld	a,-8 (ix)
	rla
	sbc	a, a
	ld	h,a
	ld	a,b
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
	ld	a,-2 (ix)
	add	a, l
	ld	l,a
	ld	a,-1 (ix)
	adc	a, h
	ld	h,a
	push	de
	ld	de,#0x7000
	add	hl, de
	pop	de
	ld	h,(hl)
	add	hl, hl
	jr	NC,00106$
;src/Enemy.c:86: (*(u8*)(MAP_MEM+((x0-sx)+(y0*MAP_WIDTH)))&CELL_WALL_MASK)
	ld	a,c
	ld	b,a
	rla
	sbc	a, a
	ld	d,a
	ld	a,-2 (ix)
	sub	a, b
	ld	l,a
	ld	a,-1 (ix)
	sbc	a, d
	ld	h,a
	ld	a,-6 (ix)
	add	a, l
	ld	l,a
	ld	a,-5 (ix)
	adc	a, h
	ld	h,a
	push	de
	ld	de,#0x7000
	add	hl, de
	pop	de
	ld	h,(hl)
	add	hl, hl
	jr	NC,00106$
00105$:
;src/Enemy.c:89: return 0;
	ld	l,#0x00
	jr	00115$
00106$:
;src/Enemy.c:91: if ((x0==x1 && y0==y1)){
	ld	a,4 (ix)
	sub	a, 6 (ix)
	jp	NZ,00113$
	ld	a,5 (ix)
	sub	a, 7 (ix)
	jp	NZ,00113$
;src/Enemy.c:96: return 1;
	ld	l,#0x01
00115$:
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:100: void enemy_new_enemy(Vec2u* position) __z88dk_fastcall{
;	---------------------------------
; Function enemy_new_enemy
; ---------------------------------
_enemy_new_enemy::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	ex	de,hl
;src/Enemy.c:102: Enemy* enemy=(enemyArray+ENEMY_MAX_ENEMIES);
	ld	bc,#_enemyArray+150
;src/Enemy.c:104: x=position->x;
	ld	a,(de)
	ld	-1 (ix),a
;src/Enemy.c:105: y=position->y;
	ex	de,hl
	inc	hl
	ld	a,(hl)
	ld	-2 (ix),a
;src/Enemy.c:108: while(i){
	ld	e,#0x0F
00103$:
	ld	a,e
	or	a, a
	jr	Z,00106$
;src/Enemy.c:109: --i;
	dec	e
;src/Enemy.c:110: --enemy;
	ld	a,c
	add	a,#0xF6
	ld	c,a
	ld	a,b
	adc	a,#0xFF
	ld	b,a
;src/Enemy.c:111: if(enemy->hitPoints==0){//TODO
	ld	iy,#0x0005
	add	iy, bc
	ld	a, 0 (iy)
	or	a, a
	jr	NZ,00103$
;src/Enemy.c:112: enemy->id=i;
	ld	a,e
	ld	(bc),a
;src/Enemy.c:114: enemy->type=0;
	ld	l, c
	ld	h, b
	inc	hl
	ld	(hl),#0x00
;src/Enemy.c:116: enemy->hitPoints=ENEMY_INITIAL_HP;
	ld	0 (iy), #0xFF
;src/Enemy.c:119: enemy->direction=0;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl),#0x00
;src/Enemy.c:121: enemy->position.x = x;
	inc	bc
	inc	bc
	inc	bc
	ld	a,-1 (ix)
	ld	(bc),a
;src/Enemy.c:122: enemy->position.y = y;
	inc	bc
	ld	a,-2 (ix)
	ld	(bc),a
;src/Enemy.c:124: *(u8*)(MAP_MEM+x+(y*MAP_WIDTH))=(i+1);
	ld	c,-1 (ix)
	ld	b,#0x00
	ld	hl,#0x7000
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	l,-2 (ix)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	inc	e
	ld	(hl),e
;src/Enemy.c:126: ++activeEnemies;
	ld	hl, #_activeEnemies+0
	inc	(hl)
;src/Enemy.c:127: break;
00106$:
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:134: u8 enemy_try_new_spawn(){
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
;src/Enemy.c:137: if(activeEnemies<ENEMY_MAX_ENEMIES){
	ld	a,(#_activeEnemies + 0)
	sub	a, #0x0F
	jr	NC,00106$
;src/Enemy.c:138: pos.x=cpct_getRandom_mxor_u8()%MAP_WIDTH;
	ld	hl,#0x0000
	add	hl,sp
	push	hl
	call	_cpct_getRandom_mxor_u8
	ld	a,l
	pop	hl
	and	a, #0x1F
	ld	(hl),a
;src/Enemy.c:139: pos.y=cpct_getRandom_mxor_u8()%MAP_HEIGHT;
	ld	hl,#0x0000
	add	hl,sp
	ld	-3 (ix),l
	ld	-2 (ix),h
	inc	hl
	push	hl
	call	_cpct_getRandom_mxor_u8
	pop	bc
	ld	a,l
	and	a, #0x1F
	ld	-4 (ix), a
	ld	(bc),a
;src/Enemy.c:141: if((*(u8*)(MAP_MEM+pos.x+(pos.y*MAP_WIDTH))&(CELL_WALL_MASK|CELL_ENEMY_MASK))==0){
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	ld	a,(hl)
	ld	-5 (ix), a
	ld	e, a
	ld	d,#0x00
	ld	hl,#0x7000
	add	hl,de
	ex	de,hl
	ld	a,(bc)
	ld	-1 (ix),a
	ld	l,-4 (ix)
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
;src/Enemy.c:142: if(dist(player_position.x, player_position.y, pos.x, pos.y)>ENEMY_VIEW_DISTANCE){
	ld	hl, #_player_position + 1
	ld	c,(hl)
	ld	hl, #_player_position + 0
	ld	e,(hl)
	ld	h,-1 (ix)
	ld	l,-5 (ix)
	push	hl
	ld	d, c
	push	de
	call	_dist
	pop	af
	pop	af
	ld	a,#0x06
	sub	a, l
	jr	NC,00106$
;src/Enemy.c:143: enemy_new_enemy(&pos);
	ld	l,-3 (ix)
	ld	h,-2 (ix)
	call	_enemy_new_enemy
;src/Enemy.c:144: return 1;
	ld	l,#0x01
	jr	00107$
00106$:
;src/Enemy.c:148: return 0;
	ld	l,#0x00
00107$:
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:151: void enemy_roam(Enemy* e) __z88dk_fastcall{
;	---------------------------------
; Function enemy_roam
; ---------------------------------
_enemy_roam::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-19
	add	hl,sp
	ld	sp,hl
	ld	-2 (ix),l
	ld	-1 (ix),h
;src/Enemy.c:157: x=e->position.x;
	ld	a,-2 (ix)
	add	a, #0x03
	ld	-8 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-7 (ix),a
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	a,(hl)
	ld	-6 (ix),a
;src/Enemy.c:158: y=e->position.y;
	ld	a,-8 (ix)
	add	a, #0x01
	ld	-5 (ix),a
	ld	a,-7 (ix)
	adc	a, #0x00
	ld	-4 (ix),a
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	a,(hl)
	ld	-3 (ix),a
;src/Enemy.c:160: d=e->direction;
	ld	a,-2 (ix)
	add	a, #0x02
	ld	-11 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-10 (ix),a
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	a,(hl)
	ld	-9 (ix),a
;src/Enemy.c:162: ui_log_add_log(integer_to_string(e->id,'d'));
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	b,(hl)
	ld	a,#0x64
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_integer_to_string
	ex	(sp),hl
	call	_ui_log_add_log
	pop	af
;src/Enemy.c:164: dx=movement_directionArray[d];
	ld	a,-9 (ix)
	add	a, #<(_movement_directionArray)
	ld	l,a
	ld	a,#0x00
	adc	a, #>(_movement_directionArray)
	ld	h,a
	ld	a,(hl)
	ld	-12 (ix),a
;src/Enemy.c:165: dy=movement_directionArray[d+1];
	ld	c,-9 (ix)
	inc	c
	ld	hl,#_movement_directionArray
	ld	b,#0x00
	add	hl, bc
	ld	a,(hl)
	ld	-13 (ix),a
;src/Enemy.c:167: m=0;
	ld	-19 (ix),#0x00
;src/Enemy.c:169: if((map[(x+dx) + (y+dy)*MAP_WIDTH])&(CELL_WALL_MASK|CELL_ENEMY_MASK)){//If wall or enemy forward
	ld	a,-6 (ix)
	ld	-17 (ix),a
	ld	-16 (ix),#0x00
	ld	c,-12 (ix)
	ld	a,-12 (ix)
	rla
	sbc	a, a
	ld	b,a
	ld	a,-17 (ix)
	add	a, c
	ld	c,a
	ld	a,-16 (ix)
	adc	a, b
	ld	b,a
	ld	a,-3 (ix)
	ld	-15 (ix),a
	ld	-14 (ix),#0x00
	ld	e,-13 (ix)
	ld	a,-13 (ix)
	rla
	sbc	a, a
	ld	d,a
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	add	hl,de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	bc,#0x7000
	add	hl,bc
	ld	a,(hl)
	and	a, #0x8F
	jp	Z,00120$
;src/Enemy.c:171: d=((e->direction+2)&7);
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	c,(hl)
	ld	a,c
	add	a, #0x02
	and	a, #0x07
	ld	e,a
;src/Enemy.c:173: dx=movement_directionArray[d];
	ld	hl,#_movement_directionArray
	ld	d,#0x00
	add	hl, de
	ld	b,(hl)
;src/Enemy.c:174: dy=movement_directionArray[d+1];
	inc	e
	ld	hl,#_movement_directionArray
	ld	d,#0x00
	add	hl, de
	ld	l,(hl)
;src/Enemy.c:176: ml=(map[x+dx + (y+dy)*MAP_WIDTH]);
	ld	a,b
	ld	e,a
	rla
	sbc	a, a
	ld	d,a
	ld	a,-17 (ix)
	add	a, e
	ld	e,a
	ld	a,-16 (ix)
	adc	a, d
	ld	d,a
	ld	a,l
	rla
	sbc	a, a
	ld	h,a
	ld	a,-15 (ix)
	add	a, l
	ld	l,a
	ld	a,-14 (ix)
	adc	a, h
	ld	h,a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,de
	ld	de,#0x7000
	add	hl,de
	ld	a,(hl)
	ld	-18 (ix),a
;src/Enemy.c:178: d=((e->direction-2)&7);
	dec	c
	dec	c
	ld	a,c
	and	a, #0x07
;src/Enemy.c:180: dx=movement_directionArray[d];
	ld	-9 (ix),a
	add	a,#<(_movement_directionArray)
	ld	l,a
	ld	a,#>(_movement_directionArray)
	adc	a, #0x00
	ld	h,a
	ld	c,(hl)
;src/Enemy.c:181: dy=movement_directionArray[d+1];
	ld	e,-9 (ix)
	inc	e
	ld	hl,#_movement_directionArray
	ld	d,#0x00
	add	hl, de
	ld	e,(hl)
;src/Enemy.c:183: mr=(map[x+dx + (y+dy)*MAP_WIDTH]);
	ld	a,c
	rla
	sbc	a, a
	ld	b,a
	ld	a,-17 (ix)
	add	a, c
	ld	c,a
	ld	a,-16 (ix)
	adc	a, b
	ld	b,a
	ld	a,e
	rla
	sbc	a, a
	ld	d,a
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	add	hl,de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	bc,#0x7000
	add	hl,bc
	ld	b,(hl)
;src/Enemy.c:186: if(cpct_getRandom_mxor_u8()%2){//Turn left then right
	push	bc
	call	_cpct_getRandom_mxor_u8
	pop	bc
	ld	a,l
	and	a, #0x01
	ld	l,a
;src/Enemy.c:187: if(!(ml&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move left
	ld	a,-18 (ix)
	and	a, #0x8F
	ld	c,a
;src/Enemy.c:191: else if(!(mr&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move right
	ld	a,b
	and	a, #0x8F
	ld	e,a
;src/Enemy.c:186: if(cpct_getRandom_mxor_u8()%2){//Turn left then right
	ld	a,l
	or	a, a
	jr	Z,00112$
;src/Enemy.c:187: if(!(ml&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move left
	ld	a,c
	or	a, a
	jr	NZ,00104$
;src/Enemy.c:188: d=((e->direction+2)&7);
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	a,(hl)
	add	a, #0x02
	and	a, #0x07
	ld	-9 (ix),a
;src/Enemy.c:189: m=1;
	ld	-19 (ix),#0x01
	jr	00113$
00104$:
;src/Enemy.c:191: else if(!(mr&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move right
	ld	a,e
	or	a, a
	jr	NZ,00113$
;src/Enemy.c:192: d=((e->direction-2)&7);
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	a,(hl)
	add	a,#0xFE
	and	a, #0x07
	ld	-9 (ix),a
;src/Enemy.c:193: m=1;
	ld	-19 (ix),#0x01
	jr	00113$
00112$:
;src/Enemy.c:198: if(!(mr&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move left
	ld	a,e
	or	a, a
	jr	NZ,00109$
;src/Enemy.c:199: d=((e->direction-2)&7);
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	a,(hl)
	add	a,#0xFE
	and	a, #0x07
	ld	-9 (ix),a
;src/Enemy.c:200: m=1;
	ld	-19 (ix),#0x01
	jr	00113$
00109$:
;src/Enemy.c:202: else if(!(ml&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move right
	ld	a,c
	or	a, a
	jr	NZ,00113$
;src/Enemy.c:203: d=((e->direction+2)&7);
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	a,(hl)
	add	a, #0x02
	and	a, #0x07
	ld	-9 (ix),a
;src/Enemy.c:204: m=1;
	ld	-19 (ix),#0x01
00113$:
;src/Enemy.c:208: if(!m){
	ld	a,-19 (ix)
	or	a, a
	jr	NZ,00117$
;src/Enemy.c:210: d=((e->direction+4)&7);
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	a,(hl)
	add	a, #0x04
	and	a, #0x07
;src/Enemy.c:212: dx=movement_directionArray[d];
	ld	-9 (ix),a
	add	a,#<(_movement_directionArray)
	ld	l,a
	ld	a,#>(_movement_directionArray)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
	ld	-12 (ix),a
;src/Enemy.c:213: dy=movement_directionArray[d+1];
	ld	c,-9 (ix)
	inc	c
	ld	hl,#_movement_directionArray
	ld	b,#0x00
	add	hl, bc
	ld	a,(hl)
	ld	-13 (ix),a
;src/Enemy.c:215: if(!((map[x+dx + (y+dy)*MAP_WIDTH])&(CELL_WALL_MASK|CELL_ENEMY_MASK))){
	ld	c,-12 (ix)
	ld	a,-12 (ix)
	rla
	sbc	a, a
	ld	b,a
	ld	a,-17 (ix)
	add	a, c
	ld	c,a
	ld	a,-16 (ix)
	adc	a, b
	ld	b,a
	ld	e,-13 (ix)
	ld	a,-13 (ix)
	rla
	sbc	a, a
	ld	d,a
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	add	hl,de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	bc,#0x7000
	add	hl,bc
	ld	a,(hl)
	and	a, #0x8F
	jr	NZ,00121$
;src/Enemy.c:216: m=1;
	ld	-19 (ix),#0x01
	jr	00121$
00117$:
;src/Enemy.c:221: dx=movement_directionArray[d];
	ld	a,#<(_movement_directionArray)
	add	a, -9 (ix)
	ld	l,a
	ld	a,#>(_movement_directionArray)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
	ld	-12 (ix),a
;src/Enemy.c:222: dy=movement_directionArray[d+1];
	ld	c,-9 (ix)
	inc	c
	ld	hl,#_movement_directionArray
	ld	b,#0x00
	add	hl, bc
	ld	a,(hl)
	ld	-13 (ix),a
	jr	00121$
00120$:
;src/Enemy.c:227: m=1;
	ld	-19 (ix),#0x01
00121$:
;src/Enemy.c:230: if(m){
	ld	a,-19 (ix)
	or	a, a
	jr	Z,00124$
;src/Enemy.c:231: (map[x + (y)*MAP_WIDTH]) &= (CELL_ITEM_MASK|CELL_WALL_MASK);
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	e,-17 (ix)
	ld	d,-16 (ix)
	add	hl,de
	ld	bc,#0x7000
	add	hl,bc
	ld	a,(hl)
	and	a, #0xF0
	ld	(hl),a
;src/Enemy.c:235: x+=dx;
	ld	a, -6 (ix)
	add	a, -12 (ix)
	ld	c,a
;src/Enemy.c:236: y+=dy;
	ld	a, -3 (ix)
	add	a, -13 (ix)
	ld	e,a
;src/Enemy.c:238: e->direction = d;
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	a,-9 (ix)
	ld	(hl),a
;src/Enemy.c:240: e->position.x = x;
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	(hl),c
;src/Enemy.c:241: e->position.y = y;
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	(hl),e
;src/Enemy.c:244: (map[x + (y)*MAP_WIDTH]) |= (e->id)+1;
	ld	b,#0x00
	ld	h,#0x00
	ld	l, e
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	bc,#0x7000
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	a,(bc)
	ld	e,a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	inc	a
	or	a, e
	ld	(bc),a
00124$:
	ld	sp, ix
	pop	ix
	ret
;src/Enemy.c:248: void enemy_AI_passive(Enemy* e) __z88dk_fastcall{
;	---------------------------------
; Function enemy_AI_passive
; ---------------------------------
_enemy_AI_passive::
	ld	c,l
	ld	b,h
;src/Enemy.c:252: hp=e->hitPoints;
	push	bc
	pop	iy
;src/Enemy.c:255: if(hp < ENEMY_INITIAL_HP){//Aggresive
;src/Enemy.c:258: else if(hp < ENEMY_INITIAL_HP/4){ //Flee
	ld	a, 5 (iy)
	cp	a,#0xFF
	ret	C
	sub	a, #0x3F
	ret	C
;src/Enemy.c:262: enemy_roam(e);        
	ld	l, c
	ld	h, b
	jp  _enemy_roam
;src/Enemy.c:266: void enemy_AI_aggressive(Enemy* e){
;	---------------------------------
; Function enemy_AI_aggressive
; ---------------------------------
_enemy_AI_aggressive::
;src/Enemy.c:268: }
	ret
;src/Enemy.c:270: void enemy_AI_tactical(Enemy* e){
;	---------------------------------
; Function enemy_AI_tactical
; ---------------------------------
_enemy_AI_tactical::
;src/Enemy.c:272: }
	ret
;src/Enemy.c:274: void enemy_AI_shy(Enemy* e){
;	---------------------------------
; Function enemy_AI_shy
; ---------------------------------
_enemy_AI_shy::
;src/Enemy.c:276: }
	ret
;src/Enemy.c:278: void enemy_update(){
;	---------------------------------
; Function enemy_update
; ---------------------------------
_enemy_update::
;src/Enemy.c:280: Enemy* enemy=enemyArray;
	ld	bc,#_enemyArray+0
;src/Enemy.c:282: for(i;i;--i){
	ld	d,#0x0F
00110$:
	ld	a,d
	or	a, a
	ret	Z
;src/Enemy.c:283: if(enemy->hitPoints){
	push	bc
	pop	iy
	ld	a,5 (iy)
	or	a, a
	jr	Z,00107$
;src/Enemy.c:284: switch(enemy->type){
	ld	l, c
	ld	h, b
	inc	hl
	ld	e,(hl)
	ld	a,#0x03
	sub	a, e
	jr	C,00107$
	push	de
	ld	d,#0x00
	ld	hl,#00131$
	add	hl,de
	add	hl,de
;src/Enemy.c:285: case 0:{
	pop	de
	jp	(hl)
00131$:
	jr	00101$
	jr	00107$
	jr	00107$
	jr	00104$
00101$:
;src/Enemy.c:286: enemy_AI_passive(enemy);
	push	bc
	push	de
	ld	l, c
	ld	h, b
	call	_enemy_AI_passive
	pop	de
	pop	bc
;src/Enemy.c:287: break;
;src/Enemy.c:289: case 1:{
;src/Enemy.c:291: break;
;src/Enemy.c:293: case 2:{
;src/Enemy.c:295: break;
;src/Enemy.c:297: case 3:{
;src/Enemy.c:301: }
00104$:
00107$:
;src/Enemy.c:311: ++enemy;
	ld	hl,#0x000A
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Enemy.c:282: for(i;i;--i){
	dec	d
	jr	00110$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
