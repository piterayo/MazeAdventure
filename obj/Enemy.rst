                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module Enemy
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _enemy_AI_aggressive
                             12 	.globl _enemy_AI_passive
                             13 	.globl _enemy_roam
                             14 	.globl _enemy_flee
                             15 	.globl _enemy_go_to_player
                             16 	.globl _enemy_attack
                             17 	.globl _enemy_move
                             18 	.globl _enemy_remove
                             19 	.globl _enemy_get_distance_to_obstacle
                             20 	.globl _enemy_collision_at_dir
                             21 	.globl _enemy_new_enemy
                             22 	.globl _enemy_is_adjacent_to_player
                             23 	.globl _enemy_can_view
                             24 	.globl _dist
                             25 	.globl _abs
                             26 	.globl _level_get_level
                             27 	.globl _item_try_new_spawn_at
                             28 	.globl _ui_log_render
                             29 	.globl _ui_log_add_log
                             30 	.globl _integer_to_string
                             31 	.globl _ui_playerstats_render_hp
                             32 	.globl _cpct_getRandom_mxor_u8
                             33 	.globl _cpct_memcpy
                             34 	.globl _cpct_memset
                             35 	.globl _enemyArray
                             36 	.globl _activeEnemies
                             37 	.globl _enemy_get_at
                             38 	.globl _enemy_init_enemies
                             39 	.globl _enemy_try_new_spawn
                             40 	.globl _enemy_attack_enemy
                             41 	.globl _enemy_update
                             42 ;--------------------------------------------------------
                             43 ; special function registers
                             44 ;--------------------------------------------------------
                             45 ;--------------------------------------------------------
                             46 ; ram data
                             47 ;--------------------------------------------------------
                             48 	.area _DATA
   865C                      49 _activeEnemies::
   865C                      50 	.ds 1
   865D                      51 _enemyArray::
   865D                      52 	.ds 120
                             53 ;--------------------------------------------------------
                             54 ; ram data
                             55 ;--------------------------------------------------------
                             56 	.area _INITIALIZED
                             57 ;--------------------------------------------------------
                             58 ; absolute external ram data
                             59 ;--------------------------------------------------------
                             60 	.area _DABS (ABS)
                             61 ;--------------------------------------------------------
                             62 ; global & static initialisations
                             63 ;--------------------------------------------------------
                             64 	.area _HOME
                             65 	.area _GSINIT
                             66 	.area _GSFINAL
                             67 	.area _GSINIT
                             68 ;--------------------------------------------------------
                             69 ; Home
                             70 ;--------------------------------------------------------
                             71 	.area _HOME
                             72 	.area _HOME
                             73 ;--------------------------------------------------------
                             74 ; code
                             75 ;--------------------------------------------------------
                             76 	.area _CODE
                             77 ;src/Enemy.c:34: Enemy* const enemy_get_at(u8 index) {
                             78 ;	---------------------------------
                             79 ; Function enemy_get_at
                             80 ; ---------------------------------
   0140                      81 _enemy_get_at::
   0140 DD E5         [15]   82 	push	ix
   0142 DD 21 00 00   [14]   83 	ld	ix,#0
   0146 DD 39         [15]   84 	add	ix,sp
                             85 ;src/Enemy.c:35: return (enemyArray+index);
   0148 01 5D 86      [10]   86 	ld	bc,#_enemyArray+0
   014B DD 6E 04      [19]   87 	ld	l,4 (ix)
   014E 26 00         [ 7]   88 	ld	h,#0x00
   0150 29            [11]   89 	add	hl, hl
   0151 29            [11]   90 	add	hl, hl
   0152 29            [11]   91 	add	hl, hl
   0153 09            [11]   92 	add	hl,bc
   0154 DD E1         [14]   93 	pop	ix
   0156 C9            [10]   94 	ret
                             95 ;src/Enemy.c:38: void enemy_init_enemies(){
                             96 ;	---------------------------------
                             97 ; Function enemy_init_enemies
                             98 ; ---------------------------------
   0157                      99 _enemy_init_enemies::
                            100 ;src/Enemy.c:40: cpct_memset(enemyArray, 0, ENEMY_MAX_ENEMIES*sizeof(Enemy));
   0157 21 78 00      [10]  101 	ld	hl,#0x0078
   015A E5            [11]  102 	push	hl
   015B AF            [ 4]  103 	xor	a, a
   015C F5            [11]  104 	push	af
   015D 33            [ 6]  105 	inc	sp
   015E 21 5D 86      [10]  106 	ld	hl,#_enemyArray
   0161 E5            [11]  107 	push	hl
   0162 CD 11 85      [17]  108 	call	_cpct_memset
                            109 ;src/Enemy.c:41: activeEnemies=0;
   0165 21 5C 86      [10]  110 	ld	hl,#_activeEnemies + 0
   0168 36 00         [10]  111 	ld	(hl), #0x00
                            112 ;src/Enemy.c:43: if(level_get_level()!=KING_LEVEL){
   016A CD 59 11      [17]  113 	call	_level_get_level
   016D 7D            [ 4]  114 	ld	a,l
   016E D6 20         [ 7]  115 	sub	a, #0x20
   0170 28 0B         [12]  116 	jr	Z,00105$
                            117 ;src/Enemy.c:44: while(activeEnemies<ENEMY_MAX_ENEMIES){
   0172                     118 00101$:
   0172 3A 5C 86      [13]  119 	ld	a,(#_activeEnemies + 0)
   0175 D6 0F         [ 7]  120 	sub	a, #0x0F
   0177 D0            [11]  121 	ret	NC
                            122 ;src/Enemy.c:45: enemy_try_new_spawn();  
   0178 CD C7 04      [17]  123 	call	_enemy_try_new_spawn
   017B 18 F5         [12]  124 	jr	00101$
   017D                     125 00105$:
                            126 ;src/Enemy.c:49: activeEnemies=1;
   017D 21 5C 86      [10]  127 	ld	hl,#_activeEnemies + 0
   0180 36 01         [10]  128 	ld	(hl), #0x01
                            129 ;src/Enemy.c:51: enemyArray->id=0;
   0182 21 5D 86      [10]  130 	ld	hl,#_enemyArray
   0185 36 00         [10]  131 	ld	(hl),#0x00
                            132 ;src/Enemy.c:53: enemyArray->type=1;
   0187 21 5E 86      [10]  133 	ld	hl,#(_enemyArray + 0x0001)
   018A 36 01         [10]  134 	ld	(hl),#0x01
                            135 ;src/Enemy.c:55: enemyArray->hitPoints=ENEMY_INITIAL_HP;
   018C 21 62 86      [10]  136 	ld	hl,#(_enemyArray + 0x0005)
   018F 36 FF         [10]  137 	ld	(hl),#0xFF
                            138 ;src/Enemy.c:57: enemyArray->attackValue = 64;
   0191 21 63 86      [10]  139 	ld	hl,#(_enemyArray + 0x0006)
   0194 36 40         [10]  140 	ld	(hl),#0x40
                            141 ;src/Enemy.c:58: enemyArray->defenseValue = 54;
   0196 21 64 86      [10]  142 	ld	hl,#(_enemyArray + 0x0007)
   0199 36 36         [10]  143 	ld	(hl),#0x36
                            144 ;src/Enemy.c:60: enemyArray->direction=MOVEMENT_SOUTH;
   019B 21 5F 86      [10]  145 	ld	hl,#(_enemyArray + 0x0002)
   019E 36 06         [10]  146 	ld	(hl),#0x06
                            147 ;src/Enemy.c:62: enemyArray->position.x = KING_LEVEL_KING_X;
   01A0 21 60 86      [10]  148 	ld	hl,#(_enemyArray + 0x0003)
   01A3 36 04         [10]  149 	ld	(hl),#0x04
                            150 ;src/Enemy.c:63: enemyArray->position.y = KING_LEVEL_KING_Y;
   01A5 21 61 86      [10]  151 	ld	hl,#(_enemyArray + 0x0004)
   01A8 36 02         [10]  152 	ld	(hl),#0x02
                            153 ;src/Enemy.c:65: *(u8*)(MAP_MEM + KING_LEVEL_KING_X + (KING_LEVEL_KING_Y*MAP_WIDTH)) = 1;
   01AA 21 14 89      [10]  154 	ld	hl,#0x8914
   01AD 36 01         [10]  155 	ld	(hl),#0x01
   01AF C9            [10]  156 	ret
                            157 ;src/Enemy.c:71: i8 abs(i8 n) {
                            158 ;	---------------------------------
                            159 ; Function abs
                            160 ; ---------------------------------
   01B0                     161 _abs::
                            162 ;src/Enemy.c:72: if(n<0) n=-n;
   01B0 FD 21 02 00   [14]  163 	ld	iy,#2
   01B4 FD 39         [15]  164 	add	iy,sp
   01B6 FD CB 00 7E   [20]  165 	bit	7,0 (iy)
   01BA 28 07         [12]  166 	jr	Z,00102$
   01BC AF            [ 4]  167 	xor	a, a
   01BD FD 96 00      [19]  168 	sub	a, 0 (iy)
   01C0 FD 77 00      [19]  169 	ld	0 (iy),a
   01C3                     170 00102$:
                            171 ;src/Enemy.c:73: return n;
   01C3 FD 21 02 00   [14]  172 	ld	iy,#2
   01C7 FD 39         [15]  173 	add	iy,sp
   01C9 FD 6E 00      [19]  174 	ld	l,0 (iy)
   01CC C9            [10]  175 	ret
                            176 ;src/Enemy.c:76: u8 dist(u8 x0, u8 y0, u8 x1, u8 y1){
                            177 ;	---------------------------------
                            178 ; Function dist
                            179 ; ---------------------------------
   01CD                     180 _dist::
                            181 ;src/Enemy.c:78: dx = abs(x1-x0);
   01CD 21 02 00      [10]  182 	ld	hl,#2
   01D0 39            [11]  183 	add	hl,sp
   01D1 FD 21 04 00   [14]  184 	ld	iy,#4
   01D5 FD 39         [15]  185 	add	iy,sp
   01D7 FD 7E 00      [19]  186 	ld	a,0 (iy)
   01DA 96            [ 7]  187 	sub	a, (hl)
   01DB 47            [ 4]  188 	ld	b,a
   01DC C5            [11]  189 	push	bc
   01DD 33            [ 6]  190 	inc	sp
   01DE CD B0 01      [17]  191 	call	_abs
   01E1 33            [ 6]  192 	inc	sp
   01E2 4D            [ 4]  193 	ld	c,l
                            194 ;src/Enemy.c:79: dy = abs(y1-y0);
   01E3 21 03 00      [10]  195 	ld	hl,#3
   01E6 39            [11]  196 	add	hl,sp
   01E7 FD 21 05 00   [14]  197 	ld	iy,#5
   01EB FD 39         [15]  198 	add	iy,sp
   01ED FD 7E 00      [19]  199 	ld	a,0 (iy)
   01F0 96            [ 7]  200 	sub	a, (hl)
   01F1 47            [ 4]  201 	ld	b,a
   01F2 C5            [11]  202 	push	bc
   01F3 C5            [11]  203 	push	bc
   01F4 33            [ 6]  204 	inc	sp
   01F5 CD B0 01      [17]  205 	call	_abs
   01F8 33            [ 6]  206 	inc	sp
   01F9 C1            [10]  207 	pop	bc
                            208 ;src/Enemy.c:81: return dx+dy;
   01FA 09            [11]  209 	add	hl, bc
   01FB C9            [10]  210 	ret
                            211 ;src/Enemy.c:85: u8 enemy_can_view(Enemy* e){
                            212 ;	---------------------------------
                            213 ; Function enemy_can_view
                            214 ; ---------------------------------
   01FC                     215 _enemy_can_view::
   01FC DD E5         [15]  216 	push	ix
   01FE DD 21 00 00   [14]  217 	ld	ix,#0
   0202 DD 39         [15]  218 	add	ix,sp
   0204 21 F1 FF      [10]  219 	ld	hl,#-15
   0207 39            [11]  220 	add	hl,sp
   0208 F9            [ 6]  221 	ld	sp,hl
                            222 ;src/Enemy.c:89: x0 = player_position.x;
   0209 21 EE 19      [10]  223 	ld	hl,#_player_position+0
   020C 4E            [ 7]  224 	ld	c,(hl)
                            225 ;src/Enemy.c:90: y0 = player_position.y;
   020D 3A EF 19      [13]  226 	ld	a,(#_player_position+1)
   0210 DD 77 F2      [19]  227 	ld	-14 (ix),a
                            228 ;src/Enemy.c:92: x1 = e->position.x;
   0213 DD 5E 04      [19]  229 	ld	e,4 (ix)
   0216 DD 56 05      [19]  230 	ld	d,5 (ix)
   0219 D5            [11]  231 	push	de
   021A FD E1         [14]  232 	pop	iy
   021C FD 7E 03      [19]  233 	ld	a,3 (iy)
   021F DD 77 F3      [19]  234 	ld	-13 (ix),a
                            235 ;src/Enemy.c:93: y1 = e->position.y;
   0222 D5            [11]  236 	push	de
   0223 FD E1         [14]  237 	pop	iy
   0225 FD 7E 04      [19]  238 	ld	a,4 (iy)
   0228 DD 77 F1      [19]  239 	ld	-15 (ix),a
                            240 ;src/Enemy.c:95: mask = (CELL_WALL_MASK|CELL_ENEMY_MASK)^(e->id+1);
   022B 1A            [ 7]  241 	ld	a,(de)
   022C 3C            [ 4]  242 	inc	a
   022D EE 8F         [ 7]  243 	xor	a, #0x8F
   022F DD 77 F6      [19]  244 	ld	-10 (ix),a
                            245 ;src/Enemy.c:97: dx = abs(x1-x0);
   0232 DD 7E F3      [19]  246 	ld	a,-13 (ix)
   0235 91            [ 4]  247 	sub	a, c
   0236 47            [ 4]  248 	ld	b,a
   0237 C5            [11]  249 	push	bc
   0238 C5            [11]  250 	push	bc
   0239 33            [ 6]  251 	inc	sp
   023A CD B0 01      [17]  252 	call	_abs
   023D 33            [ 6]  253 	inc	sp
   023E C1            [10]  254 	pop	bc
   023F DD 75 F9      [19]  255 	ld	-7 (ix),l
                            256 ;src/Enemy.c:98: dy = abs(y1-y0);
   0242 DD 7E F1      [19]  257 	ld	a,-15 (ix)
   0245 DD 96 F2      [19]  258 	sub	a, -14 (ix)
   0248 47            [ 4]  259 	ld	b,a
   0249 C5            [11]  260 	push	bc
   024A C5            [11]  261 	push	bc
   024B 33            [ 6]  262 	inc	sp
   024C CD B0 01      [17]  263 	call	_abs
   024F 33            [ 6]  264 	inc	sp
   0250 C1            [10]  265 	pop	bc
   0251 DD 75 F7      [19]  266 	ld	-9 (ix),l
                            267 ;src/Enemy.c:100: sx = (x0<x1)?1:-1;
   0254 79            [ 4]  268 	ld	a,c
   0255 DD 96 F3      [19]  269 	sub	a, -13 (ix)
   0258 E2 5D 02      [10]  270 	jp	PO, 00168$
   025B EE 80         [ 7]  271 	xor	a, #0x80
   025D                     272 00168$:
   025D F2 64 02      [10]  273 	jp	P,00117$
   0260 06 01         [ 7]  274 	ld	b,#0x01
   0262 18 02         [12]  275 	jr	00118$
   0264                     276 00117$:
   0264 06 FF         [ 7]  277 	ld	b,#0xFF
   0266                     278 00118$:
   0266 DD 70 F8      [19]  279 	ld	-8 (ix),b
                            280 ;src/Enemy.c:101: sy = (y0<y1)?1:-1;
   0269 DD 7E F2      [19]  281 	ld	a,-14 (ix)
   026C DD 96 F1      [19]  282 	sub	a, -15 (ix)
   026F E2 74 02      [10]  283 	jp	PO, 00169$
   0272 EE 80         [ 7]  284 	xor	a, #0x80
   0274                     285 00169$:
   0274 F2 7B 02      [10]  286 	jp	P,00119$
   0277 1E 01         [ 7]  287 	ld	e,#0x01
   0279 18 02         [12]  288 	jr	00120$
   027B                     289 00119$:
   027B 1E FF         [ 7]  290 	ld	e,#0xFF
   027D                     291 00120$:
   027D DD 73 F5      [19]  292 	ld	-11 (ix),e
                            293 ;src/Enemy.c:103: e1 = ((dx>dy)?dx:-dy)/2;
   0280 DD 7E F9      [19]  294 	ld	a,-7 (ix)
   0283 DD 77 FA      [19]  295 	ld	-6 (ix),a
   0286 DD 7E F9      [19]  296 	ld	a,-7 (ix)
   0289 17            [ 4]  297 	rla
   028A 9F            [ 4]  298 	sbc	a, a
   028B DD 77 FB      [19]  299 	ld	-5 (ix),a
   028E DD 7E F7      [19]  300 	ld	a,-9 (ix)
   0291 DD 96 F9      [19]  301 	sub	a, -7 (ix)
   0294 E2 99 02      [10]  302 	jp	PO, 00170$
   0297 EE 80         [ 7]  303 	xor	a, #0x80
   0299                     304 00170$:
   0299 F2 A4 02      [10]  305 	jp	P,00121$
   029C DD 6E FA      [19]  306 	ld	l,-6 (ix)
   029F DD 66 FB      [19]  307 	ld	h,-5 (ix)
   02A2 18 10         [12]  308 	jr	00122$
   02A4                     309 00121$:
   02A4 DD 5E F7      [19]  310 	ld	e,-9 (ix)
   02A7 DD 7E F7      [19]  311 	ld	a,-9 (ix)
   02AA 17            [ 4]  312 	rla
   02AB 9F            [ 4]  313 	sbc	a, a
   02AC 57            [ 4]  314 	ld	d,a
   02AD AF            [ 4]  315 	xor	a, a
   02AE 93            [ 4]  316 	sub	a, e
   02AF 6F            [ 4]  317 	ld	l,a
   02B0 3E 00         [ 7]  318 	ld	a, #0x00
   02B2 9A            [ 4]  319 	sbc	a, d
   02B3 67            [ 4]  320 	ld	h,a
   02B4                     321 00122$:
   02B4 5D            [ 4]  322 	ld	e, l
   02B5 54            [ 4]  323 	ld	d, h
   02B6 CB 7C         [ 8]  324 	bit	7, h
   02B8 28 02         [12]  325 	jr	Z,00123$
   02BA EB            [ 4]  326 	ex	de,hl
   02BB 13            [ 6]  327 	inc	de
   02BC                     328 00123$:
   02BC 43            [ 4]  329 	ld	b,e
   02BD CB 2A         [ 8]  330 	sra	d
   02BF CB 18         [ 8]  331 	rr	b
                            332 ;src/Enemy.c:105: while(1){
   02C1                     333 00113$:
                            334 ;src/Enemy.c:106: e2 = e1;
   02C1 DD 70 F4      [19]  335 	ld	-12 (ix),b
                            336 ;src/Enemy.c:107: if (e2 >-dx) {
   02C4 AF            [ 4]  337 	xor	a, a
   02C5 DD 96 FA      [19]  338 	sub	a, -6 (ix)
   02C8 5F            [ 4]  339 	ld	e,a
   02C9 3E 00         [ 7]  340 	ld	a, #0x00
   02CB DD 9E FB      [19]  341 	sbc	a, -5 (ix)
   02CE 57            [ 4]  342 	ld	d,a
   02CF 78            [ 4]  343 	ld	a,b
   02D0 6F            [ 4]  344 	ld	l,a
   02D1 17            [ 4]  345 	rla
   02D2 9F            [ 4]  346 	sbc	a, a
   02D3 67            [ 4]  347 	ld	h,a
   02D4 7B            [ 4]  348 	ld	a,e
   02D5 95            [ 4]  349 	sub	a, l
   02D6 7A            [ 4]  350 	ld	a,d
   02D7 9C            [ 4]  351 	sbc	a, h
   02D8 E2 DD 02      [10]  352 	jp	PO, 00171$
   02DB EE 80         [ 7]  353 	xor	a, #0x80
   02DD                     354 00171$:
   02DD F2 EA 02      [10]  355 	jp	P,00102$
                            356 ;src/Enemy.c:108: e1 -= dy;
   02E0 78            [ 4]  357 	ld	a,b
   02E1 DD 96 F7      [19]  358 	sub	a, -9 (ix)
   02E4 47            [ 4]  359 	ld	b,a
                            360 ;src/Enemy.c:109: x0 += sx;
   02E5 79            [ 4]  361 	ld	a,c
   02E6 DD 86 F8      [19]  362 	add	a, -8 (ix)
   02E9 4F            [ 4]  363 	ld	c,a
   02EA                     364 00102$:
                            365 ;src/Enemy.c:111: if (e2 < dy) {
   02EA DD 7E F4      [19]  366 	ld	a,-12 (ix)
   02ED DD 96 F7      [19]  367 	sub	a, -9 (ix)
   02F0 E2 F5 02      [10]  368 	jp	PO, 00172$
   02F3 EE 80         [ 7]  369 	xor	a, #0x80
   02F5                     370 00172$:
   02F5 F2 06 03      [10]  371 	jp	P,00104$
                            372 ;src/Enemy.c:112: e1 += dx;
   02F8 78            [ 4]  373 	ld	a,b
   02F9 DD 86 F9      [19]  374 	add	a, -7 (ix)
   02FC 47            [ 4]  375 	ld	b,a
                            376 ;src/Enemy.c:113: y0 += sy;
   02FD DD 7E F2      [19]  377 	ld	a,-14 (ix)
   0300 DD 86 F5      [19]  378 	add	a, -11 (ix)
   0303 DD 77 F2      [19]  379 	ld	-14 (ix),a
   0306                     380 00104$:
                            381 ;src/Enemy.c:116: if((*(u8*)(MAP_MEM+(x0+(y0*MAP_WIDTH)))&(mask))||(
   0306 79            [ 4]  382 	ld	a,c
   0307 5F            [ 4]  383 	ld	e,a
   0308 17            [ 4]  384 	rla
   0309 9F            [ 4]  385 	sbc	a, a
   030A 57            [ 4]  386 	ld	d,a
   030B DD 7E F2      [19]  387 	ld	a,-14 (ix)
   030E DD 77 FE      [19]  388 	ld	-2 (ix),a
   0311 DD 7E F2      [19]  389 	ld	a,-14 (ix)
   0314 17            [ 4]  390 	rla
   0315 9F            [ 4]  391 	sbc	a, a
   0316 DD 77 FF      [19]  392 	ld	-1 (ix),a
   0319 DD 7E FE      [19]  393 	ld	a,-2 (ix)
   031C DD 77 FC      [19]  394 	ld	-4 (ix),a
   031F DD 7E FF      [19]  395 	ld	a,-1 (ix)
   0322 DD 77 FD      [19]  396 	ld	-3 (ix),a
   0325 3E 06         [ 7]  397 	ld	a,#0x05+1
   0327 18 08         [12]  398 	jr	00174$
   0329                     399 00173$:
   0329 DD CB FC 26   [23]  400 	sla	-4 (ix)
   032D DD CB FD 16   [23]  401 	rl	-3 (ix)
   0331                     402 00174$:
   0331 3D            [ 4]  403 	dec	a
   0332 20 F5         [12]  404 	jr	NZ,00173$
   0334 DD 6E FC      [19]  405 	ld	l,-4 (ix)
   0337 DD 66 FD      [19]  406 	ld	h,-3 (ix)
   033A 19            [11]  407 	add	hl,de
   033B D5            [11]  408 	push	de
   033C 11 D0 88      [10]  409 	ld	de,#0x88D0
   033F 19            [11]  410 	add	hl, de
   0340 D1            [10]  411 	pop	de
   0341 7E            [ 7]  412 	ld	a,(hl)
   0342 DD A6 F6      [19]  413 	and	a, -10 (ix)
   0345 B7            [ 4]  414 	or	a, a
   0346 20 47         [12]  415 	jr	NZ,00105$
                            416 ;src/Enemy.c:117: (*(u8*)(MAP_MEM+((x0)+((y0-sy)*MAP_WIDTH)))&(mask))&&
   0348 DD 6E F5      [19]  417 	ld	l,-11 (ix)
   034B DD 7E F5      [19]  418 	ld	a,-11 (ix)
   034E 17            [ 4]  419 	rla
   034F 9F            [ 4]  420 	sbc	a, a
   0350 67            [ 4]  421 	ld	h,a
   0351 DD 7E FE      [19]  422 	ld	a,-2 (ix)
   0354 95            [ 4]  423 	sub	a, l
   0355 6F            [ 4]  424 	ld	l,a
   0356 DD 7E FF      [19]  425 	ld	a,-1 (ix)
   0359 9C            [ 4]  426 	sbc	a, h
   035A 67            [ 4]  427 	ld	h,a
   035B 29            [11]  428 	add	hl, hl
   035C 29            [11]  429 	add	hl, hl
   035D 29            [11]  430 	add	hl, hl
   035E 29            [11]  431 	add	hl, hl
   035F 29            [11]  432 	add	hl, hl
   0360 19            [11]  433 	add	hl,de
   0361 D5            [11]  434 	push	de
   0362 11 D0 88      [10]  435 	ld	de,#0x88D0
   0365 19            [11]  436 	add	hl, de
   0366 D1            [10]  437 	pop	de
   0367 7E            [ 7]  438 	ld	a,(hl)
   0368 DD A6 F6      [19]  439 	and	a, -10 (ix)
   036B B7            [ 4]  440 	or	a, a
   036C 28 25         [12]  441 	jr	Z,00106$
                            442 ;src/Enemy.c:118: (*(u8*)(MAP_MEM+((x0-sx)+(y0*MAP_WIDTH)))&(mask))
   036E DD 6E F8      [19]  443 	ld	l,-8 (ix)
   0371 DD 7E F8      [19]  444 	ld	a,-8 (ix)
   0374 17            [ 4]  445 	rla
   0375 9F            [ 4]  446 	sbc	a, a
   0376 67            [ 4]  447 	ld	h,a
   0377 7B            [ 4]  448 	ld	a,e
   0378 95            [ 4]  449 	sub	a, l
   0379 5F            [ 4]  450 	ld	e,a
   037A 7A            [ 4]  451 	ld	a,d
   037B 9C            [ 4]  452 	sbc	a, h
   037C 57            [ 4]  453 	ld	d,a
   037D DD 6E FC      [19]  454 	ld	l,-4 (ix)
   0380 DD 66 FD      [19]  455 	ld	h,-3 (ix)
   0383 19            [11]  456 	add	hl,de
   0384 11 D0 88      [10]  457 	ld	de,#0x88D0
   0387 19            [11]  458 	add	hl,de
   0388 7E            [ 7]  459 	ld	a,(hl)
   0389 DD A6 F6      [19]  460 	and	a, -10 (ix)
   038C B7            [ 4]  461 	or	a, a
   038D 28 04         [12]  462 	jr	Z,00106$
   038F                     463 00105$:
                            464 ;src/Enemy.c:121: return 0;
   038F 2E 00         [ 7]  465 	ld	l,#0x00
   0391 18 12         [12]  466 	jr	00115$
   0393                     467 00106$:
                            468 ;src/Enemy.c:123: if ((x0==x1 && y0==y1)){
   0393 DD 7E F3      [19]  469 	ld	a,-13 (ix)
   0396 91            [ 4]  470 	sub	a, c
   0397 C2 C1 02      [10]  471 	jp	NZ,00113$
   039A DD 7E F2      [19]  472 	ld	a,-14 (ix)
   039D DD 96 F1      [19]  473 	sub	a, -15 (ix)
   03A0 C2 C1 02      [10]  474 	jp	NZ,00113$
                            475 ;src/Enemy.c:128: return 1;
   03A3 2E 01         [ 7]  476 	ld	l,#0x01
   03A5                     477 00115$:
   03A5 DD F9         [10]  478 	ld	sp, ix
   03A7 DD E1         [14]  479 	pop	ix
   03A9 C9            [10]  480 	ret
                            481 ;src/Enemy.c:131: u8 enemy_is_adjacent_to_player(Enemy* e){    
                            482 ;	---------------------------------
                            483 ; Function enemy_is_adjacent_to_player
                            484 ; ---------------------------------
   03AA                     485 _enemy_is_adjacent_to_player::
   03AA DD E5         [15]  486 	push	ix
   03AC DD 21 00 00   [14]  487 	ld	ix,#0
   03B0 DD 39         [15]  488 	add	ix,sp
   03B2 F5            [11]  489 	push	af
                            490 ;src/Enemy.c:132: return (dist(player_position.x,player_position.y,e->position.x,e->position.y)==1);
   03B3 DD 6E 04      [19]  491 	ld	l,4 (ix)
   03B6 DD 66 05      [19]  492 	ld	h,5 (ix)
   03B9 E5            [11]  493 	push	hl
   03BA FD E1         [14]  494 	pop	iy
   03BC 11 04 00      [10]  495 	ld	de, #0x0004
   03BF 19            [11]  496 	add	hl, de
   03C0 7E            [ 7]  497 	ld	a,(hl)
   03C1 DD 77 FF      [19]  498 	ld	-1 (ix),a
   03C4 FD 7E 03      [19]  499 	ld	a,3 (iy)
   03C7 DD 77 FE      [19]  500 	ld	-2 (ix),a
   03CA 21 EF 19      [10]  501 	ld	hl, #_player_position + 1
   03CD 4E            [ 7]  502 	ld	c,(hl)
   03CE 21 EE 19      [10]  503 	ld	hl, #_player_position + 0
   03D1 5E            [ 7]  504 	ld	e,(hl)
   03D2 DD 66 FF      [19]  505 	ld	h,-1 (ix)
   03D5 DD 6E FE      [19]  506 	ld	l,-2 (ix)
   03D8 E5            [11]  507 	push	hl
   03D9 51            [ 4]  508 	ld	d, c
   03DA D5            [11]  509 	push	de
   03DB CD CD 01      [17]  510 	call	_dist
   03DE F1            [10]  511 	pop	af
   03DF F1            [10]  512 	pop	af
   03E0 2D            [ 4]  513 	dec	l
   03E1 20 04         [12]  514 	jr	NZ,00103$
   03E3 3E 01         [ 7]  515 	ld	a,#0x01
   03E5 18 01         [12]  516 	jr	00104$
   03E7                     517 00103$:
   03E7 AF            [ 4]  518 	xor	a,a
   03E8                     519 00104$:
   03E8 6F            [ 4]  520 	ld	l,a
   03E9 DD F9         [10]  521 	ld	sp, ix
   03EB DD E1         [14]  522 	pop	ix
   03ED C9            [10]  523 	ret
                            524 ;src/Enemy.c:136: void enemy_new_enemy(Vec2u* position) {
                            525 ;	---------------------------------
                            526 ; Function enemy_new_enemy
                            527 ; ---------------------------------
   03EE                     528 _enemy_new_enemy::
   03EE DD E5         [15]  529 	push	ix
   03F0 DD 21 00 00   [14]  530 	ld	ix,#0
   03F4 DD 39         [15]  531 	add	ix,sp
   03F6 F5            [11]  532 	push	af
   03F7 F5            [11]  533 	push	af
   03F8 3B            [ 6]  534 	dec	sp
                            535 ;src/Enemy.c:138: Enemy* enemy=(enemyArray+ENEMY_MAX_ENEMIES);
   03F9 01 D5 86      [10]  536 	ld	bc,#_enemyArray+120
                            537 ;src/Enemy.c:141: x=position->x;
   03FC DD 6E 04      [19]  538 	ld	l,4 (ix)
   03FF DD 66 05      [19]  539 	ld	h,5 (ix)
   0402 7E            [ 7]  540 	ld	a,(hl)
   0403 DD 77 FB      [19]  541 	ld	-5 (ix),a
                            542 ;src/Enemy.c:142: y=position->y;
   0406 23            [ 6]  543 	inc	hl
   0407 7E            [ 7]  544 	ld	a,(hl)
   0408 DD 77 FF      [19]  545 	ld	-1 (ix),a
                            546 ;src/Enemy.c:144: memPos = (MAP_MEM+x+(y*MAP_WIDTH));
   040B DD 5E FB      [19]  547 	ld	e,-5 (ix)
   040E 16 00         [ 7]  548 	ld	d,#0x00
   0410 21 D0 88      [10]  549 	ld	hl,#0x88D0
   0413 19            [11]  550 	add	hl,de
   0414 EB            [ 4]  551 	ex	de,hl
   0415 DD 6E FF      [19]  552 	ld	l,-1 (ix)
   0418 26 00         [ 7]  553 	ld	h,#0x00
   041A 29            [11]  554 	add	hl, hl
   041B 29            [11]  555 	add	hl, hl
   041C 29            [11]  556 	add	hl, hl
   041D 29            [11]  557 	add	hl, hl
   041E 29            [11]  558 	add	hl, hl
   041F 19            [11]  559 	add	hl,de
   0420 DD 75 FD      [19]  560 	ld	-3 (ix),l
   0423 DD 74 FE      [19]  561 	ld	-2 (ix),h
                            562 ;src/Enemy.c:146: while(i){
   0426 DD 36 FC 0F   [19]  563 	ld	-4 (ix),#0x0F
   042A                     564 00103$:
   042A DD 7E FC      [19]  565 	ld	a,-4 (ix)
   042D B7            [ 4]  566 	or	a, a
   042E CA C2 04      [10]  567 	jp	Z,00106$
                            568 ;src/Enemy.c:147: --i;
   0431 DD 35 FC      [23]  569 	dec	-4 (ix)
                            570 ;src/Enemy.c:148: --enemy;
   0434 79            [ 4]  571 	ld	a,c
   0435 C6 F8         [ 7]  572 	add	a,#0xF8
   0437 4F            [ 4]  573 	ld	c,a
   0438 78            [ 4]  574 	ld	a,b
   0439 CE FF         [ 7]  575 	adc	a,#0xFF
   043B 47            [ 4]  576 	ld	b,a
                            577 ;src/Enemy.c:149: if(enemy->hitPoints==0){
   043C 21 05 00      [10]  578 	ld	hl,#0x0005
   043F 09            [11]  579 	add	hl,bc
   0440 EB            [ 4]  580 	ex	de,hl
   0441 1A            [ 7]  581 	ld	a,(de)
   0442 B7            [ 4]  582 	or	a, a
   0443 20 E5         [12]  583 	jr	NZ,00103$
                            584 ;src/Enemy.c:150: enemy->id=i;
   0445 DD 7E FC      [19]  585 	ld	a,-4 (ix)
   0448 02            [ 7]  586 	ld	(bc),a
                            587 ;src/Enemy.c:152: enemy->type=cpct_getRandom_mxor_u8()&1;
   0449 69            [ 4]  588 	ld	l, c
   044A 60            [ 4]  589 	ld	h, b
   044B 23            [ 6]  590 	inc	hl
   044C E5            [11]  591 	push	hl
   044D C5            [11]  592 	push	bc
   044E D5            [11]  593 	push	de
   044F CD 0E 84      [17]  594 	call	_cpct_getRandom_mxor_u8
   0452 7D            [ 4]  595 	ld	a,l
   0453 D1            [10]  596 	pop	de
   0454 C1            [10]  597 	pop	bc
   0455 E1            [10]  598 	pop	hl
   0456 E6 01         [ 7]  599 	and	a, #0x01
   0458 77            [ 7]  600 	ld	(hl),a
                            601 ;src/Enemy.c:154: enemy->hitPoints=ENEMY_INITIAL_HP;
   0459 3E FF         [ 7]  602 	ld	a,#0xFF
   045B 12            [ 7]  603 	ld	(de),a
                            604 ;src/Enemy.c:156: enemy->attackValue = (10)+level_get_level()+(cpct_getRandom_mxor_u8()&7);
   045C 21 06 00      [10]  605 	ld	hl,#0x0006
   045F 09            [11]  606 	add	hl,bc
   0460 E5            [11]  607 	push	hl
   0461 C5            [11]  608 	push	bc
   0462 CD 59 11      [17]  609 	call	_level_get_level
   0465 7D            [ 4]  610 	ld	a,l
   0466 C1            [10]  611 	pop	bc
   0467 E1            [10]  612 	pop	hl
   0468 C6 0A         [ 7]  613 	add	a, #0x0A
   046A 5F            [ 4]  614 	ld	e,a
   046B E5            [11]  615 	push	hl
   046C C5            [11]  616 	push	bc
   046D D5            [11]  617 	push	de
   046E CD 0E 84      [17]  618 	call	_cpct_getRandom_mxor_u8
   0471 7D            [ 4]  619 	ld	a,l
   0472 D1            [10]  620 	pop	de
   0473 C1            [10]  621 	pop	bc
   0474 E1            [10]  622 	pop	hl
   0475 E6 07         [ 7]  623 	and	a, #0x07
   0477 83            [ 4]  624 	add	a,e
   0478 77            [ 7]  625 	ld	(hl),a
                            626 ;src/Enemy.c:157: enemy->defenseValue = level_get_level()+(cpct_getRandom_mxor_u8()&7);
   0479 21 07 00      [10]  627 	ld	hl,#0x0007
   047C 09            [11]  628 	add	hl,bc
   047D E5            [11]  629 	push	hl
   047E C5            [11]  630 	push	bc
   047F CD 59 11      [17]  631 	call	_level_get_level
   0482 5D            [ 4]  632 	ld	e,l
   0483 D5            [11]  633 	push	de
   0484 CD 0E 84      [17]  634 	call	_cpct_getRandom_mxor_u8
   0487 7D            [ 4]  635 	ld	a,l
   0488 D1            [10]  636 	pop	de
   0489 C1            [10]  637 	pop	bc
   048A E1            [10]  638 	pop	hl
   048B E6 07         [ 7]  639 	and	a, #0x07
   048D 83            [ 4]  640 	add	a,e
   048E 77            [ 7]  641 	ld	(hl),a
                            642 ;src/Enemy.c:159: enemy->direction=(cpct_getRandom_mxor_u8()&3)*2;
   048F 59            [ 4]  643 	ld	e, c
   0490 50            [ 4]  644 	ld	d, b
   0491 13            [ 6]  645 	inc	de
   0492 13            [ 6]  646 	inc	de
   0493 C5            [11]  647 	push	bc
   0494 D5            [11]  648 	push	de
   0495 CD 0E 84      [17]  649 	call	_cpct_getRandom_mxor_u8
   0498 D1            [10]  650 	pop	de
   0499 C1            [10]  651 	pop	bc
   049A 7D            [ 4]  652 	ld	a,l
   049B E6 03         [ 7]  653 	and	a, #0x03
   049D 87            [ 4]  654 	add	a, a
   049E 12            [ 7]  655 	ld	(de),a
                            656 ;src/Enemy.c:161: enemy->position.x = x;
   049F 03            [ 6]  657 	inc	bc
   04A0 03            [ 6]  658 	inc	bc
   04A1 03            [ 6]  659 	inc	bc
   04A2 DD 7E FB      [19]  660 	ld	a,-5 (ix)
   04A5 02            [ 7]  661 	ld	(bc),a
                            662 ;src/Enemy.c:162: enemy->position.y = y;
   04A6 03            [ 6]  663 	inc	bc
   04A7 DD 7E FF      [19]  664 	ld	a,-1 (ix)
   04AA 02            [ 7]  665 	ld	(bc),a
                            666 ;src/Enemy.c:164: *memPos=(i+1)|(*memPos);
   04AB DD 4E FC      [19]  667 	ld	c,-4 (ix)
   04AE 0C            [ 4]  668 	inc	c
   04AF DD 6E FD      [19]  669 	ld	l,-3 (ix)
   04B2 DD 66 FE      [19]  670 	ld	h,-2 (ix)
   04B5 7E            [ 7]  671 	ld	a,(hl)
   04B6 B1            [ 4]  672 	or	a, c
   04B7 DD 6E FD      [19]  673 	ld	l,-3 (ix)
   04BA DD 66 FE      [19]  674 	ld	h,-2 (ix)
   04BD 77            [ 7]  675 	ld	(hl),a
                            676 ;src/Enemy.c:166: ++activeEnemies;
   04BE 21 5C 86      [10]  677 	ld	hl, #_activeEnemies+0
   04C1 34            [11]  678 	inc	(hl)
                            679 ;src/Enemy.c:167: break;
   04C2                     680 00106$:
   04C2 DD F9         [10]  681 	ld	sp, ix
   04C4 DD E1         [14]  682 	pop	ix
   04C6 C9            [10]  683 	ret
                            684 ;src/Enemy.c:213: u8 enemy_try_new_spawn(){
                            685 ;	---------------------------------
                            686 ; Function enemy_try_new_spawn
                            687 ; ---------------------------------
   04C7                     688 _enemy_try_new_spawn::
   04C7 DD E5         [15]  689 	push	ix
   04C9 DD 21 00 00   [14]  690 	ld	ix,#0
   04CD DD 39         [15]  691 	add	ix,sp
   04CF 21 F9 FF      [10]  692 	ld	hl,#-7
   04D2 39            [11]  693 	add	hl,sp
   04D3 F9            [ 6]  694 	ld	sp,hl
                            695 ;src/Enemy.c:216: if(activeEnemies<ENEMY_MAX_ENEMIES){
   04D4 3A 5C 86      [13]  696 	ld	a,(#_activeEnemies + 0)
   04D7 D6 0F         [ 7]  697 	sub	a, #0x0F
   04D9 30 74         [12]  698 	jr	NC,00106$
                            699 ;src/Enemy.c:217: pos.x=cpct_getRandom_mxor_u8()%MAP_WIDTH;
   04DB 21 00 00      [10]  700 	ld	hl,#0x0000
   04DE 39            [11]  701 	add	hl,sp
   04DF E5            [11]  702 	push	hl
   04E0 CD 0E 84      [17]  703 	call	_cpct_getRandom_mxor_u8
   04E3 7D            [ 4]  704 	ld	a,l
   04E4 E1            [10]  705 	pop	hl
   04E5 E6 1F         [ 7]  706 	and	a, #0x1F
   04E7 77            [ 7]  707 	ld	(hl),a
                            708 ;src/Enemy.c:218: pos.y=cpct_getRandom_mxor_u8()%MAP_HEIGHT;
   04E8 21 00 00      [10]  709 	ld	hl,#0x0000
   04EB 39            [11]  710 	add	hl,sp
   04EC DD 75 FE      [19]  711 	ld	-2 (ix),l
   04EF DD 74 FF      [19]  712 	ld	-1 (ix),h
   04F2 23            [ 6]  713 	inc	hl
   04F3 E5            [11]  714 	push	hl
   04F4 CD 0E 84      [17]  715 	call	_cpct_getRandom_mxor_u8
   04F7 C1            [10]  716 	pop	bc
   04F8 7D            [ 4]  717 	ld	a,l
   04F9 E6 1F         [ 7]  718 	and	a, #0x1F
   04FB DD 77 FD      [19]  719 	ld	-3 (ix), a
   04FE 02            [ 7]  720 	ld	(bc),a
                            721 ;src/Enemy.c:220: if((*(u8*)(MAP_MEM+pos.x+(pos.y*MAP_WIDTH))&(CELL_WALL_MASK|CELL_ENEMY_MASK))==0){
   04FF DD 6E FE      [19]  722 	ld	l,-2 (ix)
   0502 DD 66 FF      [19]  723 	ld	h,-1 (ix)
   0505 7E            [ 7]  724 	ld	a,(hl)
   0506 DD 77 FC      [19]  725 	ld	-4 (ix), a
   0509 5F            [ 4]  726 	ld	e, a
   050A 16 00         [ 7]  727 	ld	d,#0x00
   050C 21 D0 88      [10]  728 	ld	hl,#0x88D0
   050F 19            [11]  729 	add	hl,de
   0510 EB            [ 4]  730 	ex	de,hl
   0511 0A            [ 7]  731 	ld	a,(bc)
   0512 DD 77 FB      [19]  732 	ld	-5 (ix),a
   0515 DD 6E FD      [19]  733 	ld	l,-3 (ix)
   0518 26 00         [ 7]  734 	ld	h,#0x00
   051A 29            [11]  735 	add	hl, hl
   051B 29            [11]  736 	add	hl, hl
   051C 29            [11]  737 	add	hl, hl
   051D 29            [11]  738 	add	hl, hl
   051E 29            [11]  739 	add	hl, hl
   051F 19            [11]  740 	add	hl,de
   0520 7E            [ 7]  741 	ld	a,(hl)
   0521 E6 8F         [ 7]  742 	and	a, #0x8F
   0523 20 2A         [12]  743 	jr	NZ,00106$
                            744 ;src/Enemy.c:221: if(dist(player_position.x, player_position.y, pos.x, pos.y)>ENEMY_VIEW_DISTANCE){
   0525 21 EF 19      [10]  745 	ld	hl, #_player_position + 1
   0528 4E            [ 7]  746 	ld	c,(hl)
   0529 21 EE 19      [10]  747 	ld	hl, #_player_position + 0
   052C 5E            [ 7]  748 	ld	e,(hl)
   052D DD 66 FB      [19]  749 	ld	h,-5 (ix)
   0530 DD 6E FC      [19]  750 	ld	l,-4 (ix)
   0533 E5            [11]  751 	push	hl
   0534 51            [ 4]  752 	ld	d, c
   0535 D5            [11]  753 	push	de
   0536 CD CD 01      [17]  754 	call	_dist
   0539 F1            [10]  755 	pop	af
   053A F1            [10]  756 	pop	af
   053B 3E 06         [ 7]  757 	ld	a,#0x06
   053D 95            [ 4]  758 	sub	a, l
   053E 30 0F         [12]  759 	jr	NC,00106$
                            760 ;src/Enemy.c:222: enemy_new_enemy(&pos);
   0540 DD 4E FE      [19]  761 	ld	c,-2 (ix)
   0543 DD 46 FF      [19]  762 	ld	b,-1 (ix)
   0546 C5            [11]  763 	push	bc
   0547 CD EE 03      [17]  764 	call	_enemy_new_enemy
   054A F1            [10]  765 	pop	af
                            766 ;src/Enemy.c:223: return 1;
   054B 2E 01         [ 7]  767 	ld	l,#0x01
   054D 18 02         [12]  768 	jr	00107$
   054F                     769 00106$:
                            770 ;src/Enemy.c:227: return 0;
   054F 2E 00         [ 7]  771 	ld	l,#0x00
   0551                     772 00107$:
   0551 DD F9         [10]  773 	ld	sp, ix
   0553 DD E1         [14]  774 	pop	ix
   0555 C9            [10]  775 	ret
                            776 ;src/Enemy.c:230: u8 enemy_collision_at_dir(Vec2u* pos, u8 dir){
                            777 ;	---------------------------------
                            778 ; Function enemy_collision_at_dir
                            779 ; ---------------------------------
   0556                     780 _enemy_collision_at_dir::
   0556 DD E5         [15]  781 	push	ix
   0558 DD 21 00 00   [14]  782 	ld	ix,#0
   055C DD 39         [15]  783 	add	ix,sp
   055E F5            [11]  784 	push	af
   055F 3B            [ 6]  785 	dec	sp
                            786 ;src/Enemy.c:235: dx = movement_directionArray[dir];
   0560 01 05 0D      [10]  787 	ld	bc,#_movement_directionArray+0
   0563 DD 6E 06      [19]  788 	ld	l,6 (ix)
   0566 26 00         [ 7]  789 	ld	h,#0x00
   0568 09            [11]  790 	add	hl,bc
   0569 5E            [ 7]  791 	ld	e,(hl)
                            792 ;src/Enemy.c:236: dy = movement_directionArray[dir+1];
   056A DD 56 06      [19]  793 	ld	d,6 (ix)
   056D 14            [ 4]  794 	inc	d
   056E 6A            [ 4]  795 	ld	l,d
   056F 26 00         [ 7]  796 	ld	h,#0x00
   0571 09            [11]  797 	add	hl,bc
   0572 7E            [ 7]  798 	ld	a,(hl)
   0573 DD 77 FD      [19]  799 	ld	-3 (ix),a
                            800 ;src/Enemy.c:238: val = *(u8*)(MAP_MEM + (pos->x + dx) + ((pos->y + dy)*MAP_WIDTH));
   0576 DD 4E 04      [19]  801 	ld	c,4 (ix)
   0579 DD 46 05      [19]  802 	ld	b,5 (ix)
   057C 0A            [ 7]  803 	ld	a,(bc)
   057D 6F            [ 4]  804 	ld	l,a
   057E 26 00         [ 7]  805 	ld	h,#0x00
   0580 7B            [ 4]  806 	ld	a,e
   0581 17            [ 4]  807 	rla
   0582 9F            [ 4]  808 	sbc	a, a
   0583 57            [ 4]  809 	ld	d,a
   0584 19            [11]  810 	add	hl,de
   0585 DD 75 FE      [19]  811 	ld	-2 (ix),l
   0588 DD 74 FF      [19]  812 	ld	-1 (ix),h
   058B EB            [ 4]  813 	ex	de,hl
   058C 21 D0 88      [10]  814 	ld	hl,#0x88D0
   058F 19            [11]  815 	add	hl,de
   0590 EB            [ 4]  816 	ex	de,hl
   0591 69            [ 4]  817 	ld	l, c
   0592 60            [ 4]  818 	ld	h, b
   0593 23            [ 6]  819 	inc	hl
   0594 4E            [ 7]  820 	ld	c,(hl)
   0595 06 00         [ 7]  821 	ld	b,#0x00
   0597 DD 6E FD      [19]  822 	ld	l,-3 (ix)
   059A DD 7E FD      [19]  823 	ld	a,-3 (ix)
   059D 17            [ 4]  824 	rla
   059E 9F            [ 4]  825 	sbc	a, a
   059F 67            [ 4]  826 	ld	h,a
   05A0 09            [11]  827 	add	hl,bc
   05A1 4D            [ 4]  828 	ld	c,l
   05A2 44            [ 4]  829 	ld	b,h
   05A3 29            [11]  830 	add	hl, hl
   05A4 29            [11]  831 	add	hl, hl
   05A5 29            [11]  832 	add	hl, hl
   05A6 29            [11]  833 	add	hl, hl
   05A7 29            [11]  834 	add	hl, hl
   05A8 19            [11]  835 	add	hl,de
   05A9 7E            [ 7]  836 	ld	a,(hl)
                            837 ;src/Enemy.c:240: if((val & (CELL_WALL_MASK|CELL_ENEMY_MASK)) || (((pos->x + dx) == player_position.x) && ((pos->y + dy) == player_position.y))) return 1;
   05AA E6 8F         [ 7]  838 	and	a, #0x8F
   05AC 20 20         [12]  839 	jr	NZ,00101$
   05AE 21 EE 19      [10]  840 	ld	hl,#_player_position+0
   05B1 5E            [ 7]  841 	ld	e,(hl)
   05B2 16 00         [ 7]  842 	ld	d,#0x00
   05B4 DD 7E FE      [19]  843 	ld	a,-2 (ix)
   05B7 93            [ 4]  844 	sub	a, e
   05B8 20 18         [12]  845 	jr	NZ,00102$
   05BA DD 7E FF      [19]  846 	ld	a,-1 (ix)
   05BD 92            [ 4]  847 	sub	a, d
   05BE 20 12         [12]  848 	jr	NZ,00102$
   05C0 21 EF 19      [10]  849 	ld	hl,#_player_position+1
   05C3 5E            [ 7]  850 	ld	e,(hl)
   05C4 16 00         [ 7]  851 	ld	d,#0x00
   05C6 79            [ 4]  852 	ld	a,c
   05C7 93            [ 4]  853 	sub	a, e
   05C8 20 08         [12]  854 	jr	NZ,00102$
   05CA 78            [ 4]  855 	ld	a,b
   05CB 92            [ 4]  856 	sub	a, d
   05CC 20 04         [12]  857 	jr	NZ,00102$
   05CE                     858 00101$:
   05CE 2E 01         [ 7]  859 	ld	l,#0x01
   05D0 18 02         [12]  860 	jr	00105$
   05D2                     861 00102$:
                            862 ;src/Enemy.c:241: return 0;
   05D2 2E 00         [ 7]  863 	ld	l,#0x00
   05D4                     864 00105$:
   05D4 DD F9         [10]  865 	ld	sp, ix
   05D6 DD E1         [14]  866 	pop	ix
   05D8 C9            [10]  867 	ret
                            868 ;src/Enemy.c:244: u8 enemy_get_distance_to_obstacle(Enemy* e, u8 direction){
                            869 ;	---------------------------------
                            870 ; Function enemy_get_distance_to_obstacle
                            871 ; ---------------------------------
   05D9                     872 _enemy_get_distance_to_obstacle::
   05D9 DD E5         [15]  873 	push	ix
   05DB DD 21 00 00   [14]  874 	ld	ix,#0
   05DF DD 39         [15]  875 	add	ix,sp
   05E1 21 F9 FF      [10]  876 	ld	hl,#-7
   05E4 39            [11]  877 	add	hl,sp
   05E5 F9            [ 6]  878 	ld	sp,hl
                            879 ;src/Enemy.c:250: dx = movement_directionArray[direction];
   05E6 01 05 0D      [10]  880 	ld	bc,#_movement_directionArray+0
   05E9 DD 6E 06      [19]  881 	ld	l,6 (ix)
   05EC 26 00         [ 7]  882 	ld	h,#0x00
   05EE 09            [11]  883 	add	hl,bc
   05EF 7E            [ 7]  884 	ld	a,(hl)
   05F0 DD 77 FB      [19]  885 	ld	-5 (ix),a
                            886 ;src/Enemy.c:251: dy = movement_directionArray[direction+1];
   05F3 DD 5E 06      [19]  887 	ld	e,6 (ix)
   05F6 1C            [ 4]  888 	inc	e
   05F7 6B            [ 4]  889 	ld	l,e
   05F8 26 00         [ 7]  890 	ld	h,#0x00
   05FA 09            [11]  891 	add	hl,bc
   05FB 7E            [ 7]  892 	ld	a,(hl)
   05FC DD 77 F9      [19]  893 	ld	-7 (ix),a
                            894 ;src/Enemy.c:254: position.x = e->position.x;
   05FF 21 03 00      [10]  895 	ld	hl,#0x0003
   0602 39            [11]  896 	add	hl,sp
   0603 4D            [ 4]  897 	ld	c,l
   0604 44            [ 4]  898 	ld	b,h
   0605 DD 5E 04      [19]  899 	ld	e,4 (ix)
   0608 DD 56 05      [19]  900 	ld	d,5 (ix)
   060B 6B            [ 4]  901 	ld	l, e
   060C 62            [ 4]  902 	ld	h, d
   060D 23            [ 6]  903 	inc	hl
   060E 23            [ 6]  904 	inc	hl
   060F 23            [ 6]  905 	inc	hl
   0610 7E            [ 7]  906 	ld	a,(hl)
   0611 02            [ 7]  907 	ld	(bc),a
                            908 ;src/Enemy.c:255: position.y = e->position.y;
   0612 21 03 00      [10]  909 	ld	hl,#0x0003
   0615 39            [11]  910 	add	hl,sp
   0616 DD 75 FE      [19]  911 	ld	-2 (ix),l
   0619 DD 74 FF      [19]  912 	ld	-1 (ix),h
   061C 23            [ 6]  913 	inc	hl
   061D 4D            [ 4]  914 	ld	c,l
   061E 44            [ 4]  915 	ld	b,h
   061F D5            [11]  916 	push	de
   0620 FD E1         [14]  917 	pop	iy
   0622 FD 7E 04      [19]  918 	ld	a,4 (iy)
   0625 02            [ 7]  919 	ld	(bc),a
                            920 ;src/Enemy.c:259: while(!(enemy_collision_at_dir(&position, direction))){
   0626 DD 5E FE      [19]  921 	ld	e,-2 (ix)
   0629 DD 56 FF      [19]  922 	ld	d,-1 (ix)
   062C DD 36 FA 00   [19]  923 	ld	-6 (ix),#0x00
   0630                     924 00101$:
   0630 D5            [11]  925 	push	de
   0631 FD E1         [14]  926 	pop	iy
   0633 C5            [11]  927 	push	bc
   0634 D5            [11]  928 	push	de
   0635 DD 7E 06      [19]  929 	ld	a,6 (ix)
   0638 F5            [11]  930 	push	af
   0639 33            [ 6]  931 	inc	sp
   063A FD E5         [15]  932 	push	iy
   063C CD 56 05      [17]  933 	call	_enemy_collision_at_dir
   063F F1            [10]  934 	pop	af
   0640 33            [ 6]  935 	inc	sp
   0641 D1            [10]  936 	pop	de
   0642 C1            [10]  937 	pop	bc
   0643 7D            [ 4]  938 	ld	a,l
   0644 B7            [ 4]  939 	or	a, a
   0645 20 1B         [12]  940 	jr	NZ,00103$
                            941 ;src/Enemy.c:260: ++count;
   0647 DD 34 FA      [23]  942 	inc	-6 (ix)
                            943 ;src/Enemy.c:261: position.x += dx;
   064A DD 6E FE      [19]  944 	ld	l,-2 (ix)
   064D DD 66 FF      [19]  945 	ld	h,-1 (ix)
   0650 7E            [ 7]  946 	ld	a, (hl)
   0651 DD 86 FB      [19]  947 	add	a, -5 (ix)
   0654 DD 6E FE      [19]  948 	ld	l,-2 (ix)
   0657 DD 66 FF      [19]  949 	ld	h,-1 (ix)
   065A 77            [ 7]  950 	ld	(hl),a
                            951 ;src/Enemy.c:262: position.y += dy;
   065B 0A            [ 7]  952 	ld	a,(bc)
   065C DD 86 F9      [19]  953 	add	a, -7 (ix)
   065F 02            [ 7]  954 	ld	(bc),a
   0660 18 CE         [12]  955 	jr	00101$
   0662                     956 00103$:
                            957 ;src/Enemy.c:265: return count;
   0662 DD 6E FA      [19]  958 	ld	l,-6 (ix)
   0665 DD F9         [10]  959 	ld	sp, ix
   0667 DD E1         [14]  960 	pop	ix
   0669 C9            [10]  961 	ret
                            962 ;src/Enemy.c:268: void enemy_remove(Enemy* e){
                            963 ;	---------------------------------
                            964 ; Function enemy_remove
                            965 ; ---------------------------------
   066A                     966 _enemy_remove::
   066A DD E5         [15]  967 	push	ix
   066C DD 21 00 00   [14]  968 	ld	ix,#0
   0670 DD 39         [15]  969 	add	ix,sp
                            970 ;src/Enemy.c:273: e->hitPoints=0;
   0672 DD 5E 04      [19]  971 	ld	e,4 (ix)
   0675 DD 56 05      [19]  972 	ld	d,5 (ix)
   0678 21 05 00      [10]  973 	ld	hl,#0x0005
   067B 19            [11]  974 	add	hl,de
   067C 36 00         [10]  975 	ld	(hl),#0x00
                            976 ;src/Enemy.c:275: (map[e->position.x + (e->position.y)*MAP_WIDTH]) &= (CELL_ITEM_MASK);
   067E 6B            [ 4]  977 	ld	l, e
   067F 62            [ 4]  978 	ld	h, d
   0680 23            [ 6]  979 	inc	hl
   0681 23            [ 6]  980 	inc	hl
   0682 23            [ 6]  981 	inc	hl
   0683 4E            [ 7]  982 	ld	c,(hl)
   0684 06 00         [ 7]  983 	ld	b,#0x00
   0686 D5            [11]  984 	push	de
   0687 FD E1         [14]  985 	pop	iy
   0689 FD 6E 04      [19]  986 	ld	l,4 (iy)
   068C 26 00         [ 7]  987 	ld	h,#0x00
   068E 29            [11]  988 	add	hl, hl
   068F 29            [11]  989 	add	hl, hl
   0690 29            [11]  990 	add	hl, hl
   0691 29            [11]  991 	add	hl, hl
   0692 29            [11]  992 	add	hl, hl
   0693 09            [11]  993 	add	hl,bc
   0694 01 D0 88      [10]  994 	ld	bc,#0x88D0
   0697 09            [11]  995 	add	hl,bc
   0698 7E            [ 7]  996 	ld	a,(hl)
   0699 E6 70         [ 7]  997 	and	a, #0x70
   069B 77            [ 7]  998 	ld	(hl),a
                            999 ;src/Enemy.c:276: --activeEnemies;
   069C 21 5C 86      [10] 1000 	ld	hl, #_activeEnemies+0
   069F 35            [11] 1001 	dec	(hl)
   06A0 DD E1         [14] 1002 	pop	ix
   06A2 C9            [10] 1003 	ret
                           1004 ;src/Enemy.c:279: void enemy_move(Enemy* e, u8 d){
                           1005 ;	---------------------------------
                           1006 ; Function enemy_move
                           1007 ; ---------------------------------
   06A3                    1008 _enemy_move::
   06A3 DD E5         [15] 1009 	push	ix
   06A5 DD 21 00 00   [14] 1010 	ld	ix,#0
   06A9 DD 39         [15] 1011 	add	ix,sp
   06AB 21 F8 FF      [10] 1012 	ld	hl,#-8
   06AE 39            [11] 1013 	add	hl,sp
   06AF F9            [ 6] 1014 	ld	sp,hl
                           1015 ;src/Enemy.c:287: x = e->position.x;
   06B0 DD 5E 04      [19] 1016 	ld	e,4 (ix)
   06B3 DD 56 05      [19] 1017 	ld	d,5 (ix)
   06B6 21 03 00      [10] 1018 	ld	hl,#0x0003
   06B9 19            [11] 1019 	add	hl,de
   06BA DD 75 FA      [19] 1020 	ld	-6 (ix),l
   06BD DD 74 FB      [19] 1021 	ld	-5 (ix),h
   06C0 DD 6E FA      [19] 1022 	ld	l,-6 (ix)
   06C3 DD 66 FB      [19] 1023 	ld	h,-5 (ix)
   06C6 7E            [ 7] 1024 	ld	a,(hl)
   06C7 DD 77 FF      [19] 1025 	ld	-1 (ix),a
                           1026 ;src/Enemy.c:288: y = e->position.y;
   06CA 21 04 00      [10] 1027 	ld	hl,#0x0004
   06CD 19            [11] 1028 	add	hl,de
   06CE DD 75 FD      [19] 1029 	ld	-3 (ix),l
   06D1 DD 74 FE      [19] 1030 	ld	-2 (ix),h
   06D4 DD 6E FD      [19] 1031 	ld	l,-3 (ix)
   06D7 DD 66 FE      [19] 1032 	ld	h,-2 (ix)
   06DA 7E            [ 7] 1033 	ld	a,(hl)
   06DB DD 77 FC      [19] 1034 	ld	-4 (ix),a
                           1035 ;src/Enemy.c:291: (map[x + (y)*MAP_WIDTH]) &= (CELL_ITEM_MASK);
   06DE DD 4E FF      [19] 1036 	ld	c,-1 (ix)
   06E1 06 00         [ 7] 1037 	ld	b,#0x00
   06E3 DD 6E FC      [19] 1038 	ld	l,-4 (ix)
   06E6 26 00         [ 7] 1039 	ld	h,#0x00
   06E8 29            [11] 1040 	add	hl, hl
   06E9 29            [11] 1041 	add	hl, hl
   06EA 29            [11] 1042 	add	hl, hl
   06EB 29            [11] 1043 	add	hl, hl
   06EC 29            [11] 1044 	add	hl, hl
   06ED 09            [11] 1045 	add	hl,bc
   06EE 01 D0 88      [10] 1046 	ld	bc,#0x88D0
   06F1 09            [11] 1047 	add	hl,bc
   06F2 7E            [ 7] 1048 	ld	a,(hl)
   06F3 E6 70         [ 7] 1049 	and	a, #0x70
   06F5 77            [ 7] 1050 	ld	(hl),a
                           1051 ;src/Enemy.c:293: dx=movement_directionArray[d];
   06F6 01 05 0D      [10] 1052 	ld	bc,#_movement_directionArray+0
   06F9 DD 6E 06      [19] 1053 	ld	l,6 (ix)
   06FC 26 00         [ 7] 1054 	ld	h,#0x00
   06FE 09            [11] 1055 	add	hl,bc
   06FF 7E            [ 7] 1056 	ld	a,(hl)
   0700 DD 77 F9      [19] 1057 	ld	-7 (ix),a
                           1058 ;src/Enemy.c:294: dy=movement_directionArray[d+1];
   0703 DD 6E 06      [19] 1059 	ld	l,6 (ix)
   0706 2C            [ 4] 1060 	inc	l
   0707 26 00         [ 7] 1061 	ld	h,#0x00
   0709 09            [11] 1062 	add	hl,bc
   070A 46            [ 7] 1063 	ld	b,(hl)
                           1064 ;src/Enemy.c:297: x+=dx;
   070B DD 7E FF      [19] 1065 	ld	a, -1 (ix)
   070E DD 86 F9      [19] 1066 	add	a, -7 (ix)
   0711 4F            [ 4] 1067 	ld	c,a
                           1068 ;src/Enemy.c:298: y+=dy;
   0712 DD 7E FC      [19] 1069 	ld	a, -4 (ix)
   0715 80            [ 4] 1070 	add	a, b
   0716 DD 77 F8      [19] 1071 	ld	-8 (ix),a
                           1072 ;src/Enemy.c:300: e->direction = d;
   0719 6B            [ 4] 1073 	ld	l, e
   071A 62            [ 4] 1074 	ld	h, d
   071B 23            [ 6] 1075 	inc	hl
   071C 23            [ 6] 1076 	inc	hl
   071D DD 7E 06      [19] 1077 	ld	a,6 (ix)
   0720 77            [ 7] 1078 	ld	(hl),a
                           1079 ;src/Enemy.c:302: e->position.x = x;
   0721 DD 6E FA      [19] 1080 	ld	l,-6 (ix)
   0724 DD 66 FB      [19] 1081 	ld	h,-5 (ix)
   0727 71            [ 7] 1082 	ld	(hl),c
                           1083 ;src/Enemy.c:303: e->position.y = y;
   0728 DD 6E FD      [19] 1084 	ld	l,-3 (ix)
   072B DD 66 FE      [19] 1085 	ld	h,-2 (ix)
   072E DD 7E F8      [19] 1086 	ld	a,-8 (ix)
   0731 77            [ 7] 1087 	ld	(hl),a
                           1088 ;src/Enemy.c:306: (map[x + (y)*MAP_WIDTH]) |= ((e->id)+1);
   0732 06 00         [ 7] 1089 	ld	b,#0x00
   0734 DD 6E F8      [19] 1090 	ld	l,-8 (ix)
   0737 26 00         [ 7] 1091 	ld	h,#0x00
   0739 29            [11] 1092 	add	hl, hl
   073A 29            [11] 1093 	add	hl, hl
   073B 29            [11] 1094 	add	hl, hl
   073C 29            [11] 1095 	add	hl, hl
   073D 29            [11] 1096 	add	hl, hl
   073E 09            [11] 1097 	add	hl, bc
   073F E5            [11] 1098 	push	hl
   0740 FD E1         [14] 1099 	pop	iy
   0742 01 D0 88      [10] 1100 	ld	bc,#0x88D0
   0745 FD 09         [15] 1101 	add	iy, bc
   0747 FD 4E 00      [19] 1102 	ld	c, 0 (iy)
   074A 1A            [ 7] 1103 	ld	a,(de)
   074B 3C            [ 4] 1104 	inc	a
   074C B1            [ 4] 1105 	or	a, c
   074D FD 77 00      [19] 1106 	ld	0 (iy), a
   0750 DD F9         [10] 1107 	ld	sp, ix
   0752 DD E1         [14] 1108 	pop	ix
   0754 C9            [10] 1109 	ret
                           1110 ;src/Enemy.c:309: u8 enemy_attack_enemy(Enemy* e){
                           1111 ;	---------------------------------
                           1112 ; Function enemy_attack_enemy
                           1113 ; ---------------------------------
   0755                    1114 _enemy_attack_enemy::
   0755 DD E5         [15] 1115 	push	ix
   0757 DD 21 00 00   [14] 1116 	ld	ix,#0
   075B DD 39         [15] 1117 	add	ix,sp
   075D 3B            [ 6] 1118 	dec	sp
                           1119 ;src/Enemy.c:311: const char* t = "    DMG";
                           1120 ;src/Enemy.c:312: dmg = (player_attack_value - e->defenseValue);
   075E DD 4E 04      [19] 1121 	ld	c,4 (ix)
   0761 DD 46 05      [19] 1122 	ld	b,5 (ix)
   0764 C5            [11] 1123 	push	bc
   0765 FD E1         [14] 1124 	pop	iy
   0767 FD 5E 07      [19] 1125 	ld	e,7 (iy)
   076A 3A 06 87      [13] 1126 	ld	a,(#_player_attack_value + 0)
   076D 93            [ 4] 1127 	sub	a, e
                           1128 ;src/Enemy.c:313: if(dmg<1) dmg = 1;
   076E DD 77 FF      [19] 1129 	ld	-1 (ix), a
   0771 EE 80         [ 7] 1130 	xor	a, #0x80
   0773 D6 81         [ 7] 1131 	sub	a, #0x81
   0775 30 04         [12] 1132 	jr	NC,00102$
   0777 DD 36 FF 01   [19] 1133 	ld	-1 (ix),#0x01
   077B                    1134 00102$:
                           1135 ;src/Enemy.c:315: cpct_memcpy(t,integer_to_string(dmg,'d'),3);
   077B C5            [11] 1136 	push	bc
   077C 3E 64         [ 7] 1137 	ld	a,#0x64
   077E F5            [11] 1138 	push	af
   077F 33            [ 6] 1139 	inc	sp
   0780 DD 7E FF      [19] 1140 	ld	a,-1 (ix)
   0783 F5            [11] 1141 	push	af
   0784 33            [ 6] 1142 	inc	sp
   0785 CD D2 3D      [17] 1143 	call	_integer_to_string
   0788 F1            [10] 1144 	pop	af
   0789 11 03 00      [10] 1145 	ld	de,#0x0003
   078C D5            [11] 1146 	push	de
   078D E5            [11] 1147 	push	hl
   078E 21 EF 07      [10] 1148 	ld	hl,#___str_0
   0791 E5            [11] 1149 	push	hl
   0792 CD 09 85      [17] 1150 	call	_cpct_memcpy
   0795 3E 03         [ 7] 1151 	ld	a,#0x03
   0797 F5            [11] 1152 	push	af
   0798 33            [ 6] 1153 	inc	sp
   0799 21 F7 07      [10] 1154 	ld	hl,#___str_1
   079C E5            [11] 1155 	push	hl
   079D CD CF 48      [17] 1156 	call	_ui_log_add_log
   07A0 F1            [10] 1157 	pop	af
   07A1 33            [ 6] 1158 	inc	sp
   07A2 3E 05         [ 7] 1159 	ld	a,#0x05
   07A4 F5            [11] 1160 	push	af
   07A5 33            [ 6] 1161 	inc	sp
   07A6 21 EF 07      [10] 1162 	ld	hl,#___str_0
   07A9 E5            [11] 1163 	push	hl
   07AA CD CF 48      [17] 1164 	call	_ui_log_add_log
   07AD F1            [10] 1165 	pop	af
   07AE 33            [ 6] 1166 	inc	sp
   07AF CD 1A 49      [17] 1167 	call	_ui_log_render
   07B2 C1            [10] 1168 	pop	bc
                           1169 ;src/Enemy.c:320: if(e->hitPoints>(u8)dmg){
   07B3 21 05 00      [10] 1170 	ld	hl,#0x0005
   07B6 09            [11] 1171 	add	hl,bc
   07B7 5E            [ 7] 1172 	ld	e,(hl)
   07B8 DD 7E FF      [19] 1173 	ld	a, -1 (ix)
   07BB 93            [ 4] 1174 	sub	a, e
   07BC 30 09         [12] 1175 	jr	NC,00107$
                           1176 ;src/Enemy.c:321: e->hitPoints -= dmg;
   07BE 7B            [ 4] 1177 	ld	a,e
   07BF DD 96 FF      [19] 1178 	sub	a, -1 (ix)
   07C2 77            [ 7] 1179 	ld	(hl),a
                           1180 ;src/Enemy.c:322: return 0;
   07C3 2E 00         [ 7] 1181 	ld	l,#0x00
   07C5 18 24         [12] 1182 	jr	00109$
   07C7                    1183 00107$:
                           1184 ;src/Enemy.c:326: enemy_remove(e);
   07C7 C5            [11] 1185 	push	bc
   07C8 C5            [11] 1186 	push	bc
   07C9 CD 6A 06      [17] 1187 	call	_enemy_remove
   07CC F1            [10] 1188 	pop	af
   07CD CD 0E 84      [17] 1189 	call	_cpct_getRandom_mxor_u8
   07D0 C1            [10] 1190 	pop	bc
   07D1 CB 45         [ 8] 1191 	bit	0, l
   07D3 20 0A         [12] 1192 	jr	NZ,00103$
   07D5 C5            [11] 1193 	push	bc
   07D6 CD 59 11      [17] 1194 	call	_level_get_level
   07D9 C1            [10] 1195 	pop	bc
   07DA 7D            [ 4] 1196 	ld	a,l
   07DB D6 20         [ 7] 1197 	sub	a, #0x20
   07DD 20 0A         [12] 1198 	jr	NZ,00104$
   07DF                    1199 00103$:
                           1200 ;src/Enemy.c:329: item_try_new_spawn_at(&(e->position));
   07DF 03            [ 6] 1201 	inc	bc
   07E0 03            [ 6] 1202 	inc	bc
   07E1 03            [ 6] 1203 	inc	bc
   07E2 60            [ 4] 1204 	ld	h,b
   07E3 69            [ 4] 1205 	ld	l, c
   07E4 E5            [11] 1206 	push	hl
   07E5 CD 83 0F      [17] 1207 	call	_item_try_new_spawn_at
   07E8 F1            [10] 1208 	pop	af
   07E9                    1209 00104$:
                           1210 ;src/Enemy.c:332: return 1;
   07E9 2E 01         [ 7] 1211 	ld	l,#0x01
   07EB                    1212 00109$:
   07EB 33            [ 6] 1213 	inc	sp
   07EC DD E1         [14] 1214 	pop	ix
   07EE C9            [10] 1215 	ret
   07EF                    1216 ___str_0:
   07EF 20 20 20 20 44 4D  1217 	.ascii "    DMG"
        47
   07F6 00                 1218 	.db 0x00
   07F7                    1219 ___str_1:
   07F7 59 4F 55 20 4D 41  1220 	.ascii "YOU MAKE"
        4B 45
   07FF 00                 1221 	.db 0x00
                           1222 ;src/Enemy.c:336: void enemy_attack(Enemy* e){
                           1223 ;	---------------------------------
                           1224 ; Function enemy_attack
                           1225 ; ---------------------------------
   0800                    1226 _enemy_attack::
   0800 DD E5         [15] 1227 	push	ix
   0802 DD 21 00 00   [14] 1228 	ld	ix,#0
   0806 DD 39         [15] 1229 	add	ix,sp
                           1230 ;src/Enemy.c:338: const char* t = "    HP";
                           1231 ;src/Enemy.c:339: dmg = (e->attackValue - player_defense_value);
   0808 DD 6E 04      [19] 1232 	ld	l,4 (ix)
   080B DD 66 05      [19] 1233 	ld	h,5 (ix)
   080E 11 06 00      [10] 1234 	ld	de, #0x0006
   0811 19            [11] 1235 	add	hl, de
   0812 4E            [ 7] 1236 	ld	c,(hl)
   0813 21 05 87      [10] 1237 	ld	hl,#_player_defense_value
   0816 79            [ 4] 1238 	ld	a,c
   0817 96            [ 7] 1239 	sub	a, (hl)
                           1240 ;src/Enemy.c:340: if(dmg<1) dmg = 1;
   0818 47            [ 4] 1241 	ld	b,a
   0819 EE 80         [ 7] 1242 	xor	a, #0x80
   081B D6 81         [ 7] 1243 	sub	a, #0x81
   081D 30 02         [12] 1244 	jr	NC,00102$
   081F 06 01         [ 7] 1245 	ld	b,#0x01
   0821                    1246 00102$:
                           1247 ;src/Enemy.c:342: cpct_memcpy(t,integer_to_string(dmg,'d'),3);
   0821 C5            [11] 1248 	push	bc
   0822 3E 64         [ 7] 1249 	ld	a,#0x64
   0824 F5            [11] 1250 	push	af
   0825 33            [ 6] 1251 	inc	sp
   0826 C5            [11] 1252 	push	bc
   0827 33            [ 6] 1253 	inc	sp
   0828 CD D2 3D      [17] 1254 	call	_integer_to_string
   082B F1            [10] 1255 	pop	af
   082C 11 03 00      [10] 1256 	ld	de,#0x0003
   082F D5            [11] 1257 	push	de
   0830 E5            [11] 1258 	push	hl
   0831 21 75 08      [10] 1259 	ld	hl,#___str_2
   0834 E5            [11] 1260 	push	hl
   0835 CD 09 85      [17] 1261 	call	_cpct_memcpy
   0838 3E 03         [ 7] 1262 	ld	a,#0x03
   083A F5            [11] 1263 	push	af
   083B 33            [ 6] 1264 	inc	sp
   083C 21 7C 08      [10] 1265 	ld	hl,#___str_3
   083F E5            [11] 1266 	push	hl
   0840 CD CF 48      [17] 1267 	call	_ui_log_add_log
   0843 F1            [10] 1268 	pop	af
   0844 33            [ 6] 1269 	inc	sp
   0845 3E 04         [ 7] 1270 	ld	a,#0x04
   0847 F5            [11] 1271 	push	af
   0848 33            [ 6] 1272 	inc	sp
   0849 21 75 08      [10] 1273 	ld	hl,#___str_2
   084C E5            [11] 1274 	push	hl
   084D CD CF 48      [17] 1275 	call	_ui_log_add_log
   0850 F1            [10] 1276 	pop	af
   0851 33            [ 6] 1277 	inc	sp
   0852 CD 1A 49      [17] 1278 	call	_ui_log_render
   0855 C1            [10] 1279 	pop	bc
                           1280 ;src/Enemy.c:347: if(player_health_points>(u8)dmg){
   0856 78            [ 4] 1281 	ld	a, b
   0857 FD 21 07 87   [14] 1282 	ld	iy,#_player_health_points
   085B FD 96 00      [19] 1283 	sub	a, 0 (iy)
   085E 30 0A         [12] 1284 	jr	NC,00104$
                           1285 ;src/Enemy.c:348: player_health_points -= dmg;
   0860 3A 07 87      [13] 1286 	ld	a,(#_player_health_points + 0)
   0863 21 07 87      [10] 1287 	ld	hl, #_player_health_points
   0866 90            [ 4] 1288 	sub	a, b
   0867 77            [ 7] 1289 	ld	(hl),a
   0868 18 05         [12] 1290 	jr	00105$
   086A                    1291 00104$:
                           1292 ;src/Enemy.c:351: player_is_dead = 1;
   086A 21 08 87      [10] 1293 	ld	hl,#_player_is_dead + 0
   086D 36 01         [10] 1294 	ld	(hl), #0x01
   086F                    1295 00105$:
                           1296 ;src/Enemy.c:353: ui_playerstats_render_hp();
   086F CD 73 4D      [17] 1297 	call	_ui_playerstats_render_hp
   0872 DD E1         [14] 1298 	pop	ix
   0874 C9            [10] 1299 	ret
   0875                    1300 ___str_2:
   0875 20 20 20 20 48 50  1301 	.ascii "    HP"
   087B 00                 1302 	.db 0x00
   087C                    1303 ___str_3:
   087C 59 4F 55 20 4C 4F  1304 	.ascii "YOU LOSE"
        53 45
   0884 00                 1305 	.db 0x00
                           1306 ;src/Enemy.c:356: void enemy_go_to_player(Enemy* e){//NOT WORKING
                           1307 ;	---------------------------------
                           1308 ; Function enemy_go_to_player
                           1309 ; ---------------------------------
   0885                    1310 _enemy_go_to_player::
   0885 DD E5         [15] 1311 	push	ix
   0887 DD 21 00 00   [14] 1312 	ld	ix,#0
   088B DD 39         [15] 1313 	add	ix,sp
   088D F5            [11] 1314 	push	af
   088E F5            [11] 1315 	push	af
                           1316 ;src/Enemy.c:361: dx=player_position.x-e->position.x;
   088F 21 EE 19      [10] 1317 	ld	hl,#_player_position+0
   0892 5E            [ 7] 1318 	ld	e,(hl)
   0893 DD 4E 04      [19] 1319 	ld	c,4 (ix)
   0896 DD 46 05      [19] 1320 	ld	b,5 (ix)
   0899 21 03 00      [10] 1321 	ld	hl,#0x0003
   089C 09            [11] 1322 	add	hl,bc
   089D DD 75 FD      [19] 1323 	ld	-3 (ix),l
   08A0 DD 74 FE      [19] 1324 	ld	-2 (ix),h
   08A3 DD 6E FD      [19] 1325 	ld	l,-3 (ix)
   08A6 DD 66 FE      [19] 1326 	ld	h,-2 (ix)
   08A9 56            [ 7] 1327 	ld	d,(hl)
   08AA 7B            [ 4] 1328 	ld	a,e
   08AB 92            [ 4] 1329 	sub	a, d
   08AC DD 77 FC      [19] 1330 	ld	-4 (ix),a
                           1331 ;src/Enemy.c:362: dy=player_position.y-e->position.y;
   08AF 21 EF 19      [10] 1332 	ld	hl,#_player_position+1
   08B2 5E            [ 7] 1333 	ld	e,(hl)
   08B3 C5            [11] 1334 	push	bc
   08B4 FD E1         [14] 1335 	pop	iy
   08B6 FD 56 04      [19] 1336 	ld	d,4 (iy)
   08B9 7B            [ 4] 1337 	ld	a,e
   08BA 92            [ 4] 1338 	sub	a, d
   08BB 6F            [ 4] 1339 	ld	l,a
                           1340 ;src/Enemy.c:364: dirX = (dx>0)?MOVEMENT_EAST:MOVEMENT_WEST;
   08BC AF            [ 4] 1341 	xor	a, a
   08BD DD 96 FC      [19] 1342 	sub	a, -4 (ix)
   08C0 E2 C5 08      [10] 1343 	jp	PO, 00136$
   08C3 EE 80         [ 7] 1344 	xor	a, #0x80
   08C5                    1345 00136$:
   08C5 F2 CC 08      [10] 1346 	jp	P,00112$
   08C8 1E 00         [ 7] 1347 	ld	e,#0x00
   08CA 18 02         [12] 1348 	jr	00113$
   08CC                    1349 00112$:
   08CC 1E 04         [ 7] 1350 	ld	e,#0x04
   08CE                    1351 00113$:
                           1352 ;src/Enemy.c:365: dirY = (dy>0)?MOVEMENT_SOUTH:MOVEMENT_NORTH;
   08CE AF            [ 4] 1353 	xor	a, a
   08CF 95            [ 4] 1354 	sub	a, l
   08D0 E2 D5 08      [10] 1355 	jp	PO, 00137$
   08D3 EE 80         [ 7] 1356 	xor	a, #0x80
   08D5                    1357 00137$:
   08D5 F2 DC 08      [10] 1358 	jp	P,00114$
   08D8 16 06         [ 7] 1359 	ld	d,#0x06
   08DA 18 02         [12] 1360 	jr	00115$
   08DC                    1361 00114$:
   08DC 16 02         [ 7] 1362 	ld	d,#0x02
   08DE                    1363 00115$:
                           1364 ;src/Enemy.c:367: if(abs(dx)>abs(dy)){
   08DE E5            [11] 1365 	push	hl
   08DF C5            [11] 1366 	push	bc
   08E0 D5            [11] 1367 	push	de
   08E1 DD 7E FC      [19] 1368 	ld	a,-4 (ix)
   08E4 F5            [11] 1369 	push	af
   08E5 33            [ 6] 1370 	inc	sp
   08E6 CD B0 01      [17] 1371 	call	_abs
   08E9 33            [ 6] 1372 	inc	sp
   08EA DD 75 FF      [19] 1373 	ld	-1 (ix),l
   08ED D1            [10] 1374 	pop	de
   08EE C1            [10] 1375 	pop	bc
   08EF E1            [10] 1376 	pop	hl
   08F0 C5            [11] 1377 	push	bc
   08F1 D5            [11] 1378 	push	de
   08F2 7D            [ 4] 1379 	ld	a,l
   08F3 F5            [11] 1380 	push	af
   08F4 33            [ 6] 1381 	inc	sp
   08F5 CD B0 01      [17] 1382 	call	_abs
   08F8 33            [ 6] 1383 	inc	sp
   08F9 D1            [10] 1384 	pop	de
   08FA C1            [10] 1385 	pop	bc
   08FB 7D            [ 4] 1386 	ld	a,l
   08FC DD 96 FF      [19] 1387 	sub	a, -1 (ix)
   08FF E2 04 09      [10] 1388 	jp	PO, 00138$
   0902 EE 80         [ 7] 1389 	xor	a, #0x80
   0904                    1390 00138$:
   0904 F2 33 09      [10] 1391 	jp	P,00108$
                           1392 ;src/Enemy.c:368: if(!enemy_collision_at_dir(&(e->position),dirX)){
   0907 C5            [11] 1393 	push	bc
   0908 D5            [11] 1394 	push	de
   0909 7B            [ 4] 1395 	ld	a,e
   090A F5            [11] 1396 	push	af
   090B 33            [ 6] 1397 	inc	sp
   090C DD 6E FD      [19] 1398 	ld	l,-3 (ix)
   090F DD 66 FE      [19] 1399 	ld	h,-2 (ix)
   0912 E5            [11] 1400 	push	hl
   0913 CD 56 05      [17] 1401 	call	_enemy_collision_at_dir
   0916 F1            [10] 1402 	pop	af
   0917 33            [ 6] 1403 	inc	sp
   0918 D1            [10] 1404 	pop	de
   0919 C1            [10] 1405 	pop	bc
   091A 7D            [ 4] 1406 	ld	a,l
   091B B7            [ 4] 1407 	or	a, a
   091C 20 0B         [12] 1408 	jr	NZ,00102$
                           1409 ;src/Enemy.c:371: enemy_move(e, dirX);
   091E 7B            [ 4] 1410 	ld	a,e
   091F F5            [11] 1411 	push	af
   0920 33            [ 6] 1412 	inc	sp
   0921 C5            [11] 1413 	push	bc
   0922 CD A3 06      [17] 1414 	call	_enemy_move
   0925 F1            [10] 1415 	pop	af
   0926 33            [ 6] 1416 	inc	sp
   0927 18 33         [12] 1417 	jr	00110$
   0929                    1418 00102$:
                           1419 ;src/Enemy.c:376: enemy_move(e, dirY);
   0929 D5            [11] 1420 	push	de
   092A 33            [ 6] 1421 	inc	sp
   092B C5            [11] 1422 	push	bc
   092C CD A3 06      [17] 1423 	call	_enemy_move
   092F F1            [10] 1424 	pop	af
   0930 33            [ 6] 1425 	inc	sp
   0931 18 29         [12] 1426 	jr	00110$
   0933                    1427 00108$:
                           1428 ;src/Enemy.c:380: if(!enemy_collision_at_dir(&(e->position),dirY)){
   0933 C5            [11] 1429 	push	bc
   0934 D5            [11] 1430 	push	de
   0935 D5            [11] 1431 	push	de
   0936 33            [ 6] 1432 	inc	sp
   0937 DD 6E FD      [19] 1433 	ld	l,-3 (ix)
   093A DD 66 FE      [19] 1434 	ld	h,-2 (ix)
   093D E5            [11] 1435 	push	hl
   093E CD 56 05      [17] 1436 	call	_enemy_collision_at_dir
   0941 F1            [10] 1437 	pop	af
   0942 33            [ 6] 1438 	inc	sp
   0943 D1            [10] 1439 	pop	de
   0944 C1            [10] 1440 	pop	bc
   0945 7D            [ 4] 1441 	ld	a,l
   0946 B7            [ 4] 1442 	or	a, a
   0947 20 0A         [12] 1443 	jr	NZ,00105$
                           1444 ;src/Enemy.c:383: enemy_move(e, dirY);
   0949 D5            [11] 1445 	push	de
   094A 33            [ 6] 1446 	inc	sp
   094B C5            [11] 1447 	push	bc
   094C CD A3 06      [17] 1448 	call	_enemy_move
   094F F1            [10] 1449 	pop	af
   0950 33            [ 6] 1450 	inc	sp
   0951 18 09         [12] 1451 	jr	00110$
   0953                    1452 00105$:
                           1453 ;src/Enemy.c:388: enemy_move(e, dirX);
   0953 7B            [ 4] 1454 	ld	a,e
   0954 F5            [11] 1455 	push	af
   0955 33            [ 6] 1456 	inc	sp
   0956 C5            [11] 1457 	push	bc
   0957 CD A3 06      [17] 1458 	call	_enemy_move
   095A F1            [10] 1459 	pop	af
   095B 33            [ 6] 1460 	inc	sp
   095C                    1461 00110$:
   095C DD F9         [10] 1462 	ld	sp, ix
   095E DD E1         [14] 1463 	pop	ix
   0960 C9            [10] 1464 	ret
                           1465 ;src/Enemy.c:394: void enemy_flee(Enemy* e) {
                           1466 ;	---------------------------------
                           1467 ; Function enemy_flee
                           1468 ; ---------------------------------
   0961                    1469 _enemy_flee::
   0961 DD E5         [15] 1470 	push	ix
   0963 DD 21 00 00   [14] 1471 	ld	ix,#0
   0967 DD 39         [15] 1472 	add	ix,sp
   0969 21 F9 FF      [10] 1473 	ld	hl,#-7
   096C 39            [11] 1474 	add	hl,sp
   096D F9            [ 6] 1475 	ld	sp,hl
                           1476 ;src/Enemy.c:398: distFromPlayX = abs(player_position.x - e->position.x);
   096E 3A EE 19      [13] 1477 	ld	a,(#_player_position+0)
   0971 DD 77 FF      [19] 1478 	ld	-1 (ix),a
   0974 DD 4E 04      [19] 1479 	ld	c,4 (ix)
   0977 DD 46 05      [19] 1480 	ld	b,5 (ix)
   097A 59            [ 4] 1481 	ld	e, c
   097B 50            [ 4] 1482 	ld	d, b
   097C 13            [ 6] 1483 	inc	de
   097D 13            [ 6] 1484 	inc	de
   097E 13            [ 6] 1485 	inc	de
   097F 1A            [ 7] 1486 	ld	a,(de)
   0980 6F            [ 4] 1487 	ld	l,a
   0981 DD 7E FF      [19] 1488 	ld	a,-1 (ix)
   0984 95            [ 4] 1489 	sub	a, l
   0985 67            [ 4] 1490 	ld	h,a
   0986 C5            [11] 1491 	push	bc
   0987 D5            [11] 1492 	push	de
   0988 E5            [11] 1493 	push	hl
   0989 33            [ 6] 1494 	inc	sp
   098A CD B0 01      [17] 1495 	call	_abs
   098D 33            [ 6] 1496 	inc	sp
   098E D1            [10] 1497 	pop	de
   098F C1            [10] 1498 	pop	bc
   0990 DD 75 FA      [19] 1499 	ld	-6 (ix),l
                           1500 ;src/Enemy.c:399: distFromPlayY = abs(player_position.y - e->position.y);
   0993 3A EF 19      [13] 1501 	ld	a,(#(_player_position + 0x0001) + 0)
   0996 DD 77 FF      [19] 1502 	ld	-1 (ix),a
   0999 21 04 00      [10] 1503 	ld	hl,#0x0004
   099C 09            [11] 1504 	add	hl,bc
   099D DD 75 FD      [19] 1505 	ld	-3 (ix),l
   09A0 DD 74 FE      [19] 1506 	ld	-2 (ix),h
   09A3 DD 6E FD      [19] 1507 	ld	l,-3 (ix)
   09A6 DD 66 FE      [19] 1508 	ld	h,-2 (ix)
   09A9 6E            [ 7] 1509 	ld	l,(hl)
   09AA DD 7E FF      [19] 1510 	ld	a,-1 (ix)
   09AD 95            [ 4] 1511 	sub	a, l
   09AE 67            [ 4] 1512 	ld	h,a
   09AF C5            [11] 1513 	push	bc
   09B0 D5            [11] 1514 	push	de
   09B1 E5            [11] 1515 	push	hl
   09B2 33            [ 6] 1516 	inc	sp
   09B3 CD B0 01      [17] 1517 	call	_abs
   09B6 33            [ 6] 1518 	inc	sp
   09B7 D1            [10] 1519 	pop	de
   09B8 C1            [10] 1520 	pop	bc
                           1521 ;src/Enemy.c:401: if(distFromPlayX>distFromPlayY){//Flee X
   09B9 7D            [ 4] 1522 	ld	a,l
   09BA DD 96 FA      [19] 1523 	sub	a, -6 (ix)
   09BD 30 16         [12] 1524 	jr	NC,00102$
                           1525 ;src/Enemy.c:402: fleeFromDir=(player_position.x<e->position.x)?MOVEMENT_EAST:MOVEMENT_WEST;
   09BF 3A EE 19      [13] 1526 	ld	a,(#_player_position + 0)
   09C2 DD 77 FF      [19] 1527 	ld	-1 (ix),a
   09C5 1A            [ 7] 1528 	ld	a,(de)
   09C6 5F            [ 4] 1529 	ld	e,a
   09C7 DD 7E FF      [19] 1530 	ld	a,-1 (ix)
   09CA 93            [ 4] 1531 	sub	a, e
   09CB 30 04         [12] 1532 	jr	NC,00120$
   09CD 3E 00         [ 7] 1533 	ld	a,#0x00
   09CF 18 19         [12] 1534 	jr	00103$
   09D1                    1535 00120$:
   09D1 3E 04         [ 7] 1536 	ld	a,#0x04
   09D3 18 15         [12] 1537 	jr	00103$
   09D5                    1538 00102$:
                           1539 ;src/Enemy.c:405: fleeFromDir=(player_position.y<e->position.y)?MOVEMENT_NORTH:MOVEMENT_SOUTH;
   09D5 21 EF 19      [10] 1540 	ld	hl, #(_player_position + 0x0001) + 0
   09D8 5E            [ 7] 1541 	ld	e,(hl)
   09D9 DD 6E FD      [19] 1542 	ld	l,-3 (ix)
   09DC DD 66 FE      [19] 1543 	ld	h,-2 (ix)
   09DF 56            [ 7] 1544 	ld	d,(hl)
   09E0 7B            [ 4] 1545 	ld	a,e
   09E1 92            [ 4] 1546 	sub	a, d
   09E2 30 04         [12] 1547 	jr	NC,00122$
   09E4 3E 02         [ 7] 1548 	ld	a,#0x02
   09E6 18 02         [12] 1549 	jr	00123$
   09E8                    1550 00122$:
   09E8 3E 06         [ 7] 1551 	ld	a,#0x06
   09EA                    1552 00123$:
   09EA                    1553 00103$:
                           1554 ;src/Enemy.c:408: df = (fleeFromDir+4)&7;
   09EA C6 04         [ 7] 1555 	add	a, #0x04
   09EC E6 07         [ 7] 1556 	and	a, #0x07
                           1557 ;src/Enemy.c:409: dl = (df+2)&7;
   09EE DD 77 FB      [19] 1558 	ld	-5 (ix), a
   09F1 C6 02         [ 7] 1559 	add	a, #0x02
   09F3 E6 07         [ 7] 1560 	and	a, #0x07
   09F5 DD 77 F9      [19] 1561 	ld	-7 (ix),a
                           1562 ;src/Enemy.c:410: dr = (df-2)&7;
   09F8 DD 7E FB      [19] 1563 	ld	a,-5 (ix)
   09FB C6 FE         [ 7] 1564 	add	a,#0xFE
   09FD E6 07         [ 7] 1565 	and	a, #0x07
   09FF 5F            [ 4] 1566 	ld	e,a
                           1567 ;src/Enemy.c:412: distf = enemy_get_distance_to_obstacle(e, df);
   0A00 C5            [11] 1568 	push	bc
   0A01 D5            [11] 1569 	push	de
   0A02 DD 7E FB      [19] 1570 	ld	a,-5 (ix)
   0A05 F5            [11] 1571 	push	af
   0A06 33            [ 6] 1572 	inc	sp
   0A07 C5            [11] 1573 	push	bc
   0A08 CD D9 05      [17] 1574 	call	_enemy_get_distance_to_obstacle
   0A0B F1            [10] 1575 	pop	af
   0A0C 33            [ 6] 1576 	inc	sp
   0A0D D1            [10] 1577 	pop	de
   0A0E C1            [10] 1578 	pop	bc
   0A0F DD 75 FC      [19] 1579 	ld	-4 (ix),l
                           1580 ;src/Enemy.c:413: distl = enemy_get_distance_to_obstacle(e, dl);
   0A12 C5            [11] 1581 	push	bc
   0A13 D5            [11] 1582 	push	de
   0A14 DD 7E F9      [19] 1583 	ld	a,-7 (ix)
   0A17 F5            [11] 1584 	push	af
   0A18 33            [ 6] 1585 	inc	sp
   0A19 DD 6E 04      [19] 1586 	ld	l,4 (ix)
   0A1C DD 66 05      [19] 1587 	ld	h,5 (ix)
   0A1F E5            [11] 1588 	push	hl
   0A20 CD D9 05      [17] 1589 	call	_enemy_get_distance_to_obstacle
   0A23 F1            [10] 1590 	pop	af
   0A24 33            [ 6] 1591 	inc	sp
   0A25 D1            [10] 1592 	pop	de
   0A26 C1            [10] 1593 	pop	bc
                           1594 ;src/Enemy.c:414: distr = enemy_get_distance_to_obstacle(e, dr);
   0A27 E5            [11] 1595 	push	hl
   0A28 C5            [11] 1596 	push	bc
   0A29 D5            [11] 1597 	push	de
   0A2A 7B            [ 4] 1598 	ld	a,e
   0A2B F5            [11] 1599 	push	af
   0A2C 33            [ 6] 1600 	inc	sp
   0A2D DD 6E 04      [19] 1601 	ld	l,4 (ix)
   0A30 DD 66 05      [19] 1602 	ld	h,5 (ix)
   0A33 E5            [11] 1603 	push	hl
   0A34 CD D9 05      [17] 1604 	call	_enemy_get_distance_to_obstacle
   0A37 F1            [10] 1605 	pop	af
   0A38 33            [ 6] 1606 	inc	sp
   0A39 7D            [ 4] 1607 	ld	a,l
   0A3A D1            [10] 1608 	pop	de
   0A3B C1            [10] 1609 	pop	bc
   0A3C E1            [10] 1610 	pop	hl
   0A3D 57            [ 4] 1611 	ld	d,a
                           1612 ;src/Enemy.c:416: if(distf>distl && distf>distr){
   0A3E 7D            [ 4] 1613 	ld	a,l
   0A3F DD 96 FC      [19] 1614 	sub	a, -4 (ix)
   0A42 30 0E         [12] 1615 	jr	NC,00113$
   0A44 7A            [ 4] 1616 	ld	a,d
   0A45 DD 96 FC      [19] 1617 	sub	a, -4 (ix)
   0A48 30 08         [12] 1618 	jr	NC,00113$
                           1619 ;src/Enemy.c:417: d = df;
   0A4A DD 5E FB      [19] 1620 	ld	e,-5 (ix)
                           1621 ;src/Enemy.c:418: dist = distf;
   0A4D DD 6E FC      [19] 1622 	ld	l,-4 (ix)
   0A50 18 22         [12] 1623 	jr	00114$
   0A52                    1624 00113$:
                           1625 ;src/Enemy.c:420: else if(distl>distf && distl>distr){
   0A52 DD 7E FC      [19] 1626 	ld	a,-4 (ix)
   0A55 95            [ 4] 1627 	sub	a, l
   0A56 30 09         [12] 1628 	jr	NC,00109$
   0A58 7A            [ 4] 1629 	ld	a,d
   0A59 95            [ 4] 1630 	sub	a, l
   0A5A 30 05         [12] 1631 	jr	NC,00109$
                           1632 ;src/Enemy.c:421: d=dl;
   0A5C DD 5E F9      [19] 1633 	ld	e,-7 (ix)
                           1634 ;src/Enemy.c:422: dist=distl;
   0A5F 18 13         [12] 1635 	jr	00114$
   0A61                    1636 00109$:
                           1637 ;src/Enemy.c:424: else if(distr>distf && distr>distl){
   0A61 DD 7E FC      [19] 1638 	ld	a,-4 (ix)
   0A64 92            [ 4] 1639 	sub	a, d
   0A65 30 07         [12] 1640 	jr	NC,00105$
   0A67 7D            [ 4] 1641 	ld	a,l
   0A68 92            [ 4] 1642 	sub	a, d
   0A69 30 03         [12] 1643 	jr	NC,00105$
                           1644 ;src/Enemy.c:425: d=dr;
                           1645 ;src/Enemy.c:426: dist=distr;
   0A6B 6A            [ 4] 1646 	ld	l,d
   0A6C 18 06         [12] 1647 	jr	00114$
   0A6E                    1648 00105$:
                           1649 ;src/Enemy.c:429: d=df;
   0A6E DD 5E FB      [19] 1650 	ld	e,-5 (ix)
                           1651 ;src/Enemy.c:430: dist=distf;
   0A71 DD 6E FC      [19] 1652 	ld	l,-4 (ix)
   0A74                    1653 00114$:
                           1654 ;src/Enemy.c:433: if(dist){
   0A74 7D            [ 4] 1655 	ld	a,l
   0A75 B7            [ 4] 1656 	or	a, a
   0A76 28 09         [12] 1657 	jr	Z,00118$
                           1658 ;src/Enemy.c:434: enemy_move(e,d);
   0A78 7B            [ 4] 1659 	ld	a,e
   0A79 F5            [11] 1660 	push	af
   0A7A 33            [ 6] 1661 	inc	sp
   0A7B C5            [11] 1662 	push	bc
   0A7C CD A3 06      [17] 1663 	call	_enemy_move
   0A7F F1            [10] 1664 	pop	af
   0A80 33            [ 6] 1665 	inc	sp
   0A81                    1666 00118$:
   0A81 DD F9         [10] 1667 	ld	sp, ix
   0A83 DD E1         [14] 1668 	pop	ix
   0A85 C9            [10] 1669 	ret
                           1670 ;src/Enemy.c:439: void enemy_roam(Enemy* e) {
                           1671 ;	---------------------------------
                           1672 ; Function enemy_roam
                           1673 ; ---------------------------------
   0A86                    1674 _enemy_roam::
   0A86 DD E5         [15] 1675 	push	ix
   0A88 DD 21 00 00   [14] 1676 	ld	ix,#0
   0A8C DD 39         [15] 1677 	add	ix,sp
   0A8E 21 F8 FF      [10] 1678 	ld	hl,#-8
   0A91 39            [11] 1679 	add	hl,sp
   0A92 F9            [ 6] 1680 	ld	sp,hl
                           1681 ;src/Enemy.c:440: u8 d, nd=0;
   0A93 0E 00         [ 7] 1682 	ld	c,#0x00
                           1683 ;src/Enemy.c:444: d = e->direction;
   0A95 DD 7E 04      [19] 1684 	ld	a,4 (ix)
   0A98 DD 77 FE      [19] 1685 	ld	-2 (ix),a
   0A9B DD 7E 05      [19] 1686 	ld	a,5 (ix)
   0A9E DD 77 FF      [19] 1687 	ld	-1 (ix),a
   0AA1 DD 5E FE      [19] 1688 	ld	e,-2 (ix)
   0AA4 DD 56 FF      [19] 1689 	ld	d,-1 (ix)
   0AA7 13            [ 6] 1690 	inc	de
   0AA8 13            [ 6] 1691 	inc	de
   0AA9 1A            [ 7] 1692 	ld	a,(de)
   0AAA 47            [ 4] 1693 	ld	b,a
                           1694 ;src/Enemy.c:445: pos = &(e->position);
   0AAB DD 7E FE      [19] 1695 	ld	a,-2 (ix)
   0AAE C6 03         [ 7] 1696 	add	a, #0x03
   0AB0 DD 77 F8      [19] 1697 	ld	-8 (ix),a
   0AB3 DD 7E FF      [19] 1698 	ld	a,-1 (ix)
   0AB6 CE 00         [ 7] 1699 	adc	a, #0x00
   0AB8 DD 77 F9      [19] 1700 	ld	-7 (ix),a
                           1701 ;src/Enemy.c:447: if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
   0ABB C5            [11] 1702 	push	bc
   0ABC D5            [11] 1703 	push	de
   0ABD C5            [11] 1704 	push	bc
   0ABE 33            [ 6] 1705 	inc	sp
   0ABF DD 6E F8      [19] 1706 	ld	l,-8 (ix)
   0AC2 DD 66 F9      [19] 1707 	ld	h,-7 (ix)
   0AC5 E5            [11] 1708 	push	hl
   0AC6 CD 56 05      [17] 1709 	call	_enemy_collision_at_dir
   0AC9 F1            [10] 1710 	pop	af
   0ACA 33            [ 6] 1711 	inc	sp
   0ACB D1            [10] 1712 	pop	de
   0ACC C1            [10] 1713 	pop	bc
   0ACD 7D            [ 4] 1714 	ld	a,l
   0ACE B7            [ 4] 1715 	or	a, a
   0ACF 20 07         [12] 1716 	jr	NZ,00102$
                           1717 ;src/Enemy.c:449: directions[nd]=d;
   0AD1 21 02 00      [10] 1718 	ld	hl,#0x0002
   0AD4 39            [11] 1719 	add	hl,sp
   0AD5 70            [ 7] 1720 	ld	(hl),b
                           1721 ;src/Enemy.c:450: ++nd;
   0AD6 0E 01         [ 7] 1722 	ld	c,#0x01
   0AD8                    1723 00102$:
                           1724 ;src/Enemy.c:454: d=((e->direction+2)&7);
   0AD8 1A            [ 7] 1725 	ld	a,(de)
   0AD9 C6 02         [ 7] 1726 	add	a, #0x02
   0ADB E6 07         [ 7] 1727 	and	a, #0x07
   0ADD 47            [ 4] 1728 	ld	b,a
                           1729 ;src/Enemy.c:456: if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
   0ADE C5            [11] 1730 	push	bc
   0ADF D5            [11] 1731 	push	de
   0AE0 C5            [11] 1732 	push	bc
   0AE1 33            [ 6] 1733 	inc	sp
   0AE2 DD 6E F8      [19] 1734 	ld	l,-8 (ix)
   0AE5 DD 66 F9      [19] 1735 	ld	h,-7 (ix)
   0AE8 E5            [11] 1736 	push	hl
   0AE9 CD 56 05      [17] 1737 	call	_enemy_collision_at_dir
   0AEC F1            [10] 1738 	pop	af
   0AED 33            [ 6] 1739 	inc	sp
   0AEE D1            [10] 1740 	pop	de
   0AEF C1            [10] 1741 	pop	bc
   0AF0 7D            [ 4] 1742 	ld	a,l
   0AF1 B7            [ 4] 1743 	or	a, a
   0AF2 20 0D         [12] 1744 	jr	NZ,00104$
                           1745 ;src/Enemy.c:458: directions[nd]=d;
   0AF4 21 02 00      [10] 1746 	ld	hl,#0x0002
   0AF7 39            [11] 1747 	add	hl,sp
   0AF8 7D            [ 4] 1748 	ld	a,l
   0AF9 81            [ 4] 1749 	add	a, c
   0AFA 6F            [ 4] 1750 	ld	l,a
   0AFB 7C            [ 4] 1751 	ld	a,h
   0AFC CE 00         [ 7] 1752 	adc	a, #0x00
   0AFE 67            [ 4] 1753 	ld	h,a
   0AFF 70            [ 7] 1754 	ld	(hl),b
                           1755 ;src/Enemy.c:459: ++nd;
   0B00 0C            [ 4] 1756 	inc	c
   0B01                    1757 00104$:
                           1758 ;src/Enemy.c:463: d=((e->direction-2)&7);
   0B01 1A            [ 7] 1759 	ld	a,(de)
   0B02 C6 FE         [ 7] 1760 	add	a,#0xFE
   0B04 E6 07         [ 7] 1761 	and	a, #0x07
   0B06 47            [ 4] 1762 	ld	b,a
                           1763 ;src/Enemy.c:465: if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
   0B07 C5            [11] 1764 	push	bc
   0B08 D5            [11] 1765 	push	de
   0B09 C5            [11] 1766 	push	bc
   0B0A 33            [ 6] 1767 	inc	sp
   0B0B DD 6E F8      [19] 1768 	ld	l,-8 (ix)
   0B0E DD 66 F9      [19] 1769 	ld	h,-7 (ix)
   0B11 E5            [11] 1770 	push	hl
   0B12 CD 56 05      [17] 1771 	call	_enemy_collision_at_dir
   0B15 F1            [10] 1772 	pop	af
   0B16 33            [ 6] 1773 	inc	sp
   0B17 D1            [10] 1774 	pop	de
   0B18 C1            [10] 1775 	pop	bc
   0B19 7D            [ 4] 1776 	ld	a,l
   0B1A B7            [ 4] 1777 	or	a, a
   0B1B 20 0D         [12] 1778 	jr	NZ,00106$
                           1779 ;src/Enemy.c:467: directions[nd]=d;
   0B1D 21 02 00      [10] 1780 	ld	hl,#0x0002
   0B20 39            [11] 1781 	add	hl,sp
   0B21 7D            [ 4] 1782 	ld	a,l
   0B22 81            [ 4] 1783 	add	a, c
   0B23 6F            [ 4] 1784 	ld	l,a
   0B24 7C            [ 4] 1785 	ld	a,h
   0B25 CE 00         [ 7] 1786 	adc	a, #0x00
   0B27 67            [ 4] 1787 	ld	h,a
   0B28 70            [ 7] 1788 	ld	(hl),b
                           1789 ;src/Enemy.c:468: ++nd;
   0B29 0C            [ 4] 1790 	inc	c
   0B2A                    1791 00106$:
                           1792 ;src/Enemy.c:472: if(nd==0){//If cannot move any other direction than back
   0B2A 79            [ 4] 1793 	ld	a,c
   0B2B B7            [ 4] 1794 	or	a, a
   0B2C 20 1D         [12] 1795 	jr	NZ,00110$
                           1796 ;src/Enemy.c:474: d=((e->direction+4)&7);
   0B2E 1A            [ 7] 1797 	ld	a,(de)
   0B2F C6 04         [ 7] 1798 	add	a, #0x04
   0B31 E6 07         [ 7] 1799 	and	a, #0x07
   0B33 47            [ 4] 1800 	ld	b,a
                           1801 ;src/Enemy.c:476: if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
   0B34 C5            [11] 1802 	push	bc
   0B35 C5            [11] 1803 	push	bc
   0B36 33            [ 6] 1804 	inc	sp
   0B37 DD 6E F8      [19] 1805 	ld	l,-8 (ix)
   0B3A DD 66 F9      [19] 1806 	ld	h,-7 (ix)
   0B3D E5            [11] 1807 	push	hl
   0B3E CD 56 05      [17] 1808 	call	_enemy_collision_at_dir
   0B41 F1            [10] 1809 	pop	af
   0B42 33            [ 6] 1810 	inc	sp
   0B43 C1            [10] 1811 	pop	bc
   0B44 7D            [ 4] 1812 	ld	a,l
   0B45 B7            [ 4] 1813 	or	a, a
   0B46 20 1F         [12] 1814 	jr	NZ,00111$
                           1815 ;src/Enemy.c:478: ++nd;
   0B48 0C            [ 4] 1816 	inc	c
   0B49 18 1C         [12] 1817 	jr	00111$
   0B4B                    1818 00110$:
                           1819 ;src/Enemy.c:483: d=directions[cpct_getRandom_mxor_u8()%(nd)];
   0B4B 21 02 00      [10] 1820 	ld	hl,#0x0002
   0B4E 39            [11] 1821 	add	hl,sp
   0B4F E5            [11] 1822 	push	hl
   0B50 C5            [11] 1823 	push	bc
   0B51 CD 0E 84      [17] 1824 	call	_cpct_getRandom_mxor_u8
   0B54 55            [ 4] 1825 	ld	d,l
   0B55 C1            [10] 1826 	pop	bc
   0B56 C5            [11] 1827 	push	bc
   0B57 79            [ 4] 1828 	ld	a,c
   0B58 F5            [11] 1829 	push	af
   0B59 33            [ 6] 1830 	inc	sp
   0B5A D5            [11] 1831 	push	de
   0B5B 33            [ 6] 1832 	inc	sp
   0B5C CD B0 83      [17] 1833 	call	__moduchar
   0B5F F1            [10] 1834 	pop	af
   0B60 5D            [ 4] 1835 	ld	e,l
   0B61 C1            [10] 1836 	pop	bc
   0B62 E1            [10] 1837 	pop	hl
   0B63 16 00         [ 7] 1838 	ld	d,#0x00
   0B65 19            [11] 1839 	add	hl,de
   0B66 46            [ 7] 1840 	ld	b,(hl)
   0B67                    1841 00111$:
                           1842 ;src/Enemy.c:486: if(nd){//If can move
   0B67 79            [ 4] 1843 	ld	a,c
   0B68 B7            [ 4] 1844 	or	a, a
   0B69 28 0E         [12] 1845 	jr	Z,00114$
                           1846 ;src/Enemy.c:487: enemy_move(e, d);
   0B6B C5            [11] 1847 	push	bc
   0B6C 33            [ 6] 1848 	inc	sp
   0B6D DD 6E FE      [19] 1849 	ld	l,-2 (ix)
   0B70 DD 66 FF      [19] 1850 	ld	h,-1 (ix)
   0B73 E5            [11] 1851 	push	hl
   0B74 CD A3 06      [17] 1852 	call	_enemy_move
   0B77 F1            [10] 1853 	pop	af
   0B78 33            [ 6] 1854 	inc	sp
   0B79                    1855 00114$:
   0B79 DD F9         [10] 1856 	ld	sp, ix
   0B7B DD E1         [14] 1857 	pop	ix
   0B7D C9            [10] 1858 	ret
                           1859 ;src/Enemy.c:491: void enemy_AI_passive(Enemy* e) {
                           1860 ;	---------------------------------
                           1861 ; Function enemy_AI_passive
                           1862 ; ---------------------------------
   0B7E                    1863 _enemy_AI_passive::
   0B7E DD E5         [15] 1864 	push	ix
   0B80 DD 21 00 00   [14] 1865 	ld	ix,#0
   0B84 DD 39         [15] 1866 	add	ix,sp
   0B86 F5            [11] 1867 	push	af
   0B87 3B            [ 6] 1868 	dec	sp
                           1869 ;src/Enemy.c:494: x = e->position.x;
   0B88 DD 4E 04      [19] 1870 	ld	c,4 (ix)
   0B8B DD 46 05      [19] 1871 	ld	b,5 (ix)
   0B8E C5            [11] 1872 	push	bc
   0B8F FD E1         [14] 1873 	pop	iy
   0B91 FD 7E 03      [19] 1874 	ld	a,3 (iy)
   0B94 DD 77 FE      [19] 1875 	ld	-2 (ix),a
                           1876 ;src/Enemy.c:495: y = e->position.y;
   0B97 69            [ 4] 1877 	ld	l, c
   0B98 60            [ 4] 1878 	ld	h, b
   0B99 11 04 00      [10] 1879 	ld	de, #0x0004
   0B9C 19            [11] 1880 	add	hl, de
   0B9D 5E            [ 7] 1881 	ld	e,(hl)
                           1882 ;src/Enemy.c:497: hp=e->hitPoints;
   0B9E C5            [11] 1883 	push	bc
   0B9F FD E1         [14] 1884 	pop	iy
   0BA1 FD 7E 05      [19] 1885 	ld	a,5 (iy)
   0BA4 DD 77 FD      [19] 1886 	ld	-3 (ix),a
                           1887 ;src/Enemy.c:499: if(dist(player_position.x, player_position.y, x,y)<ENEMY_VIEW_DISTANCE){
   0BA7 21 EF 19      [10] 1888 	ld	hl, #_player_position + 1
   0BAA 56            [ 7] 1889 	ld	d,(hl)
   0BAB 3A EE 19      [13] 1890 	ld	a,(#_player_position + 0)
   0BAE DD 77 FF      [19] 1891 	ld	-1 (ix),a
   0BB1 C5            [11] 1892 	push	bc
   0BB2 7B            [ 4] 1893 	ld	a,e
   0BB3 F5            [11] 1894 	push	af
   0BB4 33            [ 6] 1895 	inc	sp
   0BB5 DD 7E FE      [19] 1896 	ld	a,-2 (ix)
   0BB8 F5            [11] 1897 	push	af
   0BB9 33            [ 6] 1898 	inc	sp
   0BBA D5            [11] 1899 	push	de
   0BBB 33            [ 6] 1900 	inc	sp
   0BBC DD 7E FF      [19] 1901 	ld	a,-1 (ix)
   0BBF F5            [11] 1902 	push	af
   0BC0 33            [ 6] 1903 	inc	sp
   0BC1 CD CD 01      [17] 1904 	call	_dist
   0BC4 F1            [10] 1905 	pop	af
   0BC5 F1            [10] 1906 	pop	af
   0BC6 C1            [10] 1907 	pop	bc
   0BC7 7D            [ 4] 1908 	ld	a,l
   0BC8 D6 06         [ 7] 1909 	sub	a, #0x06
   0BCA 30 39         [12] 1910 	jr	NC,00112$
                           1911 ;src/Enemy.c:500: if(enemy_can_view(e)){
   0BCC C5            [11] 1912 	push	bc
   0BCD C5            [11] 1913 	push	bc
   0BCE CD FC 01      [17] 1914 	call	_enemy_can_view
   0BD1 F1            [10] 1915 	pop	af
   0BD2 C1            [10] 1916 	pop	bc
   0BD3 7D            [ 4] 1917 	ld	a,l
   0BD4 B7            [ 4] 1918 	or	a, a
   0BD5 28 2E         [12] 1919 	jr	Z,00112$
                           1920 ;src/Enemy.c:501: if(hp < ENEMY_INITIAL_HP){//Aggresive
   0BD7 DD 7E FD      [19] 1921 	ld	a,-3 (ix)
   0BDA D6 FF         [ 7] 1922 	sub	a, #0xFF
   0BDC 30 19         [12] 1923 	jr	NC,00107$
                           1924 ;src/Enemy.c:502: if(enemy_is_adjacent_to_player(e)){//Attack
   0BDE C5            [11] 1925 	push	bc
   0BDF C5            [11] 1926 	push	bc
   0BE0 CD AA 03      [17] 1927 	call	_enemy_is_adjacent_to_player
   0BE3 F1            [10] 1928 	pop	af
   0BE4 C1            [10] 1929 	pop	bc
   0BE5 7D            [ 4] 1930 	ld	a,l
   0BE6 B7            [ 4] 1931 	or	a, a
   0BE7 28 07         [12] 1932 	jr	Z,00102$
                           1933 ;src/Enemy.c:503: enemy_attack(e);
   0BE9 C5            [11] 1934 	push	bc
   0BEA CD 00 08      [17] 1935 	call	_enemy_attack
   0BED F1            [10] 1936 	pop	af
                           1937 ;src/Enemy.c:504: return;
   0BEE 18 1A         [12] 1938 	jr	00113$
   0BF0                    1939 00102$:
                           1940 ;src/Enemy.c:507: enemy_go_to_player(e);
   0BF0 C5            [11] 1941 	push	bc
   0BF1 CD 85 08      [17] 1942 	call	_enemy_go_to_player
   0BF4 F1            [10] 1943 	pop	af
                           1944 ;src/Enemy.c:508: return;
   0BF5 18 13         [12] 1945 	jr	00113$
   0BF7                    1946 00107$:
                           1947 ;src/Enemy.c:511: else if(hp < ENEMY_INITIAL_HP/4){ //Flee
   0BF7 DD 7E FD      [19] 1948 	ld	a,-3 (ix)
   0BFA D6 3F         [ 7] 1949 	sub	a, #0x3F
   0BFC 30 07         [12] 1950 	jr	NC,00112$
                           1951 ;src/Enemy.c:512: enemy_flee(e);
   0BFE C5            [11] 1952 	push	bc
   0BFF CD 61 09      [17] 1953 	call	_enemy_flee
   0C02 F1            [10] 1954 	pop	af
                           1955 ;src/Enemy.c:513: return;
   0C03 18 05         [12] 1956 	jr	00113$
   0C05                    1957 00112$:
                           1958 ;src/Enemy.c:517: enemy_roam(e);   
   0C05 C5            [11] 1959 	push	bc
   0C06 CD 86 0A      [17] 1960 	call	_enemy_roam
   0C09 F1            [10] 1961 	pop	af
   0C0A                    1962 00113$:
   0C0A DD F9         [10] 1963 	ld	sp, ix
   0C0C DD E1         [14] 1964 	pop	ix
   0C0E C9            [10] 1965 	ret
                           1966 ;src/Enemy.c:520: void enemy_AI_aggressive(Enemy* e){
                           1967 ;	---------------------------------
                           1968 ; Function enemy_AI_aggressive
                           1969 ; ---------------------------------
   0C0F                    1970 _enemy_AI_aggressive::
   0C0F DD E5         [15] 1971 	push	ix
   0C11 DD 21 00 00   [14] 1972 	ld	ix,#0
   0C15 DD 39         [15] 1973 	add	ix,sp
   0C17 F5            [11] 1974 	push	af
                           1975 ;src/Enemy.c:523: x = e->position.x;
   0C18 DD 4E 04      [19] 1976 	ld	c,4 (ix)
   0C1B DD 46 05      [19] 1977 	ld	b,5 (ix)
   0C1E C5            [11] 1978 	push	bc
   0C1F FD E1         [14] 1979 	pop	iy
   0C21 FD 7E 03      [19] 1980 	ld	a,3 (iy)
   0C24 DD 77 FE      [19] 1981 	ld	-2 (ix),a
                           1982 ;src/Enemy.c:524: y = e->position.y;
   0C27 C5            [11] 1983 	push	bc
   0C28 FD E1         [14] 1984 	pop	iy
   0C2A FD 7E 04      [19] 1985 	ld	a,4 (iy)
   0C2D DD 77 FF      [19] 1986 	ld	-1 (ix),a
                           1987 ;src/Enemy.c:526: if(dist(player_position.x, player_position.y, x,y)<ENEMY_VIEW_DISTANCE){
   0C30 21 EF 19      [10] 1988 	ld	hl, #_player_position + 1
   0C33 56            [ 7] 1989 	ld	d,(hl)
   0C34 21 EE 19      [10] 1990 	ld	hl, #_player_position + 0
   0C37 5E            [ 7] 1991 	ld	e,(hl)
   0C38 C5            [11] 1992 	push	bc
   0C39 DD 66 FF      [19] 1993 	ld	h,-1 (ix)
   0C3C DD 6E FE      [19] 1994 	ld	l,-2 (ix)
   0C3F E5            [11] 1995 	push	hl
   0C40 D5            [11] 1996 	push	de
   0C41 CD CD 01      [17] 1997 	call	_dist
   0C44 F1            [10] 1998 	pop	af
   0C45 F1            [10] 1999 	pop	af
   0C46 C1            [10] 2000 	pop	bc
   0C47 7D            [ 4] 2001 	ld	a,l
   0C48 D6 06         [ 7] 2002 	sub	a, #0x06
   0C4A 30 24         [12] 2003 	jr	NC,00107$
                           2004 ;src/Enemy.c:527: if(enemy_can_view(e)){
   0C4C C5            [11] 2005 	push	bc
   0C4D C5            [11] 2006 	push	bc
   0C4E CD FC 01      [17] 2007 	call	_enemy_can_view
   0C51 F1            [10] 2008 	pop	af
   0C52 C1            [10] 2009 	pop	bc
   0C53 7D            [ 4] 2010 	ld	a,l
   0C54 B7            [ 4] 2011 	or	a, a
   0C55 28 19         [12] 2012 	jr	Z,00107$
                           2013 ;src/Enemy.c:528: if(enemy_is_adjacent_to_player(e)){//Attack
   0C57 C5            [11] 2014 	push	bc
   0C58 C5            [11] 2015 	push	bc
   0C59 CD AA 03      [17] 2016 	call	_enemy_is_adjacent_to_player
   0C5C F1            [10] 2017 	pop	af
   0C5D C1            [10] 2018 	pop	bc
   0C5E 7D            [ 4] 2019 	ld	a,l
   0C5F B7            [ 4] 2020 	or	a, a
   0C60 28 07         [12] 2021 	jr	Z,00102$
                           2022 ;src/Enemy.c:529: enemy_attack(e);
   0C62 C5            [11] 2023 	push	bc
   0C63 CD 00 08      [17] 2024 	call	_enemy_attack
   0C66 F1            [10] 2025 	pop	af
                           2026 ;src/Enemy.c:530: return;
   0C67 18 0C         [12] 2027 	jr	00108$
   0C69                    2028 00102$:
                           2029 ;src/Enemy.c:533: enemy_go_to_player(e);
   0C69 C5            [11] 2030 	push	bc
   0C6A CD 85 08      [17] 2031 	call	_enemy_go_to_player
   0C6D F1            [10] 2032 	pop	af
                           2033 ;src/Enemy.c:534: return;
   0C6E 18 05         [12] 2034 	jr	00108$
   0C70                    2035 00107$:
                           2036 ;src/Enemy.c:538: enemy_roam(e);     
   0C70 C5            [11] 2037 	push	bc
   0C71 CD 86 0A      [17] 2038 	call	_enemy_roam
   0C74 F1            [10] 2039 	pop	af
   0C75                    2040 00108$:
   0C75 DD F9         [10] 2041 	ld	sp, ix
   0C77 DD E1         [14] 2042 	pop	ix
   0C79 C9            [10] 2043 	ret
                           2044 ;src/Enemy.c:585: void enemy_update(){
                           2045 ;	---------------------------------
                           2046 ; Function enemy_update
                           2047 ; ---------------------------------
   0C7A                    2048 _enemy_update::
                           2049 ;src/Enemy.c:587: Enemy* enemy=enemyArray;
   0C7A 01 5D 86      [10] 2050 	ld	bc,#_enemyArray+0
                           2051 ;src/Enemy.c:589: for(i;i;--i){
   0C7D 1E 0F         [ 7] 2052 	ld	e,#0x0F
   0C7F                    2053 00108$:
   0C7F 7B            [ 4] 2054 	ld	a,e
   0C80 B7            [ 4] 2055 	or	a, a
   0C81 C8            [11] 2056 	ret	Z
                           2057 ;src/Enemy.c:590: if(enemy->hitPoints){
   0C82 C5            [11] 2058 	push	bc
   0C83 FD E1         [14] 2059 	pop	iy
   0C85 FD 7E 05      [19] 2060 	ld	a,5 (iy)
   0C88 B7            [ 4] 2061 	or	a, a
   0C89 28 21         [12] 2062 	jr	Z,00105$
                           2063 ;src/Enemy.c:591: switch(enemy->type){
   0C8B 69            [ 4] 2064 	ld	l, c
   0C8C 60            [ 4] 2065 	ld	h, b
   0C8D 23            [ 6] 2066 	inc	hl
   0C8E 56            [ 7] 2067 	ld	d,(hl)
   0C8F 7A            [ 4] 2068 	ld	a,d
   0C90 B7            [ 4] 2069 	or	a, a
   0C91 28 05         [12] 2070 	jr	Z,00101$
   0C93 15            [ 4] 2071 	dec	d
   0C94 28 0D         [12] 2072 	jr	Z,00102$
   0C96 18 14         [12] 2073 	jr	00105$
                           2074 ;src/Enemy.c:592: case 0:{
   0C98                    2075 00101$:
                           2076 ;src/Enemy.c:593: enemy_AI_passive(enemy);
   0C98 C5            [11] 2077 	push	bc
   0C99 D5            [11] 2078 	push	de
   0C9A C5            [11] 2079 	push	bc
   0C9B CD 7E 0B      [17] 2080 	call	_enemy_AI_passive
   0C9E F1            [10] 2081 	pop	af
   0C9F D1            [10] 2082 	pop	de
   0CA0 C1            [10] 2083 	pop	bc
                           2084 ;src/Enemy.c:594: break;
   0CA1 18 09         [12] 2085 	jr	00105$
                           2086 ;src/Enemy.c:596: case 1:{
   0CA3                    2087 00102$:
                           2088 ;src/Enemy.c:597: enemy_AI_aggressive(enemy);
   0CA3 C5            [11] 2089 	push	bc
   0CA4 D5            [11] 2090 	push	de
   0CA5 C5            [11] 2091 	push	bc
   0CA6 CD 0F 0C      [17] 2092 	call	_enemy_AI_aggressive
   0CA9 F1            [10] 2093 	pop	af
   0CAA D1            [10] 2094 	pop	de
   0CAB C1            [10] 2095 	pop	bc
                           2096 ;src/Enemy.c:608: }
   0CAC                    2097 00105$:
                           2098 ;src/Enemy.c:610: ++enemy;
   0CAC 21 08 00      [10] 2099 	ld	hl,#0x0008
   0CAF 09            [11] 2100 	add	hl,bc
   0CB0 4D            [ 4] 2101 	ld	c,l
   0CB1 44            [ 4] 2102 	ld	b,h
                           2103 ;src/Enemy.c:589: for(i;i;--i){
   0CB2 1D            [ 4] 2104 	dec	e
   0CB3 18 CA         [12] 2105 	jr	00108$
                           2106 	.area _CODE
                           2107 	.area _INITIALIZER
                           2108 	.area _CABS (ABS)
