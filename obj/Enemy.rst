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
   7CE5                      49 _activeEnemies::
   7CE5                      50 	.ds 1
   7CE6                      51 _enemyArray::
   7CE6                      52 	.ds 120
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
   0040                      81 _enemy_get_at::
   0040 DD E5         [15]   82 	push	ix
   0042 DD 21 00 00   [14]   83 	ld	ix,#0
   0046 DD 39         [15]   84 	add	ix,sp
                             85 ;src/Enemy.c:35: return (enemyArray+index);
   0048 01 E6 7C      [10]   86 	ld	bc,#_enemyArray+0
   004B DD 6E 04      [19]   87 	ld	l,4 (ix)
   004E 26 00         [ 7]   88 	ld	h,#0x00
   0050 29            [11]   89 	add	hl, hl
   0051 29            [11]   90 	add	hl, hl
   0052 29            [11]   91 	add	hl, hl
   0053 09            [11]   92 	add	hl,bc
   0054 DD E1         [14]   93 	pop	ix
   0056 C9            [10]   94 	ret
                             95 ;src/Enemy.c:38: void enemy_init_enemies(){
                             96 ;	---------------------------------
                             97 ; Function enemy_init_enemies
                             98 ; ---------------------------------
   0057                      99 _enemy_init_enemies::
                            100 ;src/Enemy.c:40: cpct_memset(enemyArray, 0, ENEMY_MAX_ENEMIES*sizeof(Enemy));
   0057 21 78 00      [10]  101 	ld	hl,#0x0078
   005A E5            [11]  102 	push	hl
   005B AF            [ 4]  103 	xor	a, a
   005C F5            [11]  104 	push	af
   005D 33            [ 6]  105 	inc	sp
   005E 21 E6 7C      [10]  106 	ld	hl,#_enemyArray
   0061 E5            [11]  107 	push	hl
   0062 CD 9A 7B      [17]  108 	call	_cpct_memset
                            109 ;src/Enemy.c:41: activeEnemies=0;
   0065 21 E5 7C      [10]  110 	ld	hl,#_activeEnemies + 0
   0068 36 00         [10]  111 	ld	(hl), #0x00
                            112 ;src/Enemy.c:43: if(level_get_level()!=KING_LEVEL){
   006A CD F0 0F      [17]  113 	call	_level_get_level
   006D 7D            [ 4]  114 	ld	a,l
   006E D6 20         [ 7]  115 	sub	a, #0x20
   0070 28 0B         [12]  116 	jr	Z,00105$
                            117 ;src/Enemy.c:44: while(activeEnemies<ENEMY_MAX_ENEMIES){
   0072                     118 00101$:
   0072 3A E5 7C      [13]  119 	ld	a,(#_activeEnemies + 0)
   0075 D6 0F         [ 7]  120 	sub	a, #0x0F
   0077 D0            [11]  121 	ret	NC
                            122 ;src/Enemy.c:45: enemy_try_new_spawn();  
   0078 CD BC 03      [17]  123 	call	_enemy_try_new_spawn
   007B 18 F5         [12]  124 	jr	00101$
   007D                     125 00105$:
                            126 ;src/Enemy.c:49: activeEnemies=1;
   007D 21 E5 7C      [10]  127 	ld	hl,#_activeEnemies + 0
   0080 36 01         [10]  128 	ld	(hl), #0x01
                            129 ;src/Enemy.c:51: enemyArray->id=0;
   0082 21 E6 7C      [10]  130 	ld	hl,#_enemyArray
   0085 36 00         [10]  131 	ld	(hl),#0x00
                            132 ;src/Enemy.c:53: enemyArray->type=1;
   0087 21 E7 7C      [10]  133 	ld	hl,#(_enemyArray + 0x0001)
   008A 36 01         [10]  134 	ld	(hl),#0x01
                            135 ;src/Enemy.c:55: enemyArray->hitPoints=ENEMY_INITIAL_HP;
   008C 21 EB 7C      [10]  136 	ld	hl,#(_enemyArray + 0x0005)
   008F 36 FF         [10]  137 	ld	(hl),#0xFF
                            138 ;src/Enemy.c:57: enemyArray->attackValue = 64;
   0091 21 EC 7C      [10]  139 	ld	hl,#(_enemyArray + 0x0006)
   0094 36 40         [10]  140 	ld	(hl),#0x40
                            141 ;src/Enemy.c:58: enemyArray->defenseValue = 54;
   0096 21 ED 7C      [10]  142 	ld	hl,#(_enemyArray + 0x0007)
   0099 36 36         [10]  143 	ld	(hl),#0x36
                            144 ;src/Enemy.c:60: enemyArray->direction=MOVEMENT_SOUTH;
   009B 21 E8 7C      [10]  145 	ld	hl,#(_enemyArray + 0x0002)
   009E 36 06         [10]  146 	ld	(hl),#0x06
                            147 ;src/Enemy.c:62: enemyArray->position.x = KING_LEVEL_KING_X;
   00A0 21 E9 7C      [10]  148 	ld	hl,#(_enemyArray + 0x0003)
   00A3 36 04         [10]  149 	ld	(hl),#0x04
                            150 ;src/Enemy.c:63: enemyArray->position.y = KING_LEVEL_KING_Y;
   00A5 21 EA 7C      [10]  151 	ld	hl,#(_enemyArray + 0x0004)
   00A8 36 02         [10]  152 	ld	(hl),#0x02
                            153 ;src/Enemy.c:65: *(u8*)(MAP_MEM + KING_LEVEL_KING_X + (KING_LEVEL_KING_Y*MAP_WIDTH)) = 1;
   00AA 21 14 89      [10]  154 	ld	hl,#0x8914
   00AD 36 01         [10]  155 	ld	(hl),#0x01
   00AF C9            [10]  156 	ret
                            157 ;src/Enemy.c:71: i8 abs(i8 n) {
                            158 ;	---------------------------------
                            159 ; Function abs
                            160 ; ---------------------------------
   00B0                     161 _abs::
                            162 ;src/Enemy.c:72: if(n<0) n=-n;
   00B0 FD 21 02 00   [14]  163 	ld	iy,#2
   00B4 FD 39         [15]  164 	add	iy,sp
   00B6 FD CB 00 7E   [20]  165 	bit	7,0 (iy)
   00BA 28 07         [12]  166 	jr	Z,00102$
   00BC AF            [ 4]  167 	xor	a, a
   00BD FD 96 00      [19]  168 	sub	a, 0 (iy)
   00C0 FD 77 00      [19]  169 	ld	0 (iy),a
   00C3                     170 00102$:
                            171 ;src/Enemy.c:73: return n;
   00C3 FD 21 02 00   [14]  172 	ld	iy,#2
   00C7 FD 39         [15]  173 	add	iy,sp
   00C9 FD 6E 00      [19]  174 	ld	l,0 (iy)
   00CC C9            [10]  175 	ret
                            176 ;src/Enemy.c:76: u8 dist(u8 x0, u8 y0, u8 x1, u8 y1){
                            177 ;	---------------------------------
                            178 ; Function dist
                            179 ; ---------------------------------
   00CD                     180 _dist::
                            181 ;src/Enemy.c:78: dx = abs(x1-x0);
   00CD 21 02 00      [10]  182 	ld	hl,#2
   00D0 39            [11]  183 	add	hl,sp
   00D1 FD 21 04 00   [14]  184 	ld	iy,#4
   00D5 FD 39         [15]  185 	add	iy,sp
   00D7 FD 7E 00      [19]  186 	ld	a,0 (iy)
   00DA 96            [ 7]  187 	sub	a, (hl)
   00DB 47            [ 4]  188 	ld	b,a
   00DC C5            [11]  189 	push	bc
   00DD 33            [ 6]  190 	inc	sp
   00DE CD B0 00      [17]  191 	call	_abs
   00E1 33            [ 6]  192 	inc	sp
   00E2 4D            [ 4]  193 	ld	c,l
                            194 ;src/Enemy.c:79: dy = abs(y1-y0);
   00E3 21 03 00      [10]  195 	ld	hl,#3
   00E6 39            [11]  196 	add	hl,sp
   00E7 FD 21 05 00   [14]  197 	ld	iy,#5
   00EB FD 39         [15]  198 	add	iy,sp
   00ED FD 7E 00      [19]  199 	ld	a,0 (iy)
   00F0 96            [ 7]  200 	sub	a, (hl)
   00F1 47            [ 4]  201 	ld	b,a
   00F2 C5            [11]  202 	push	bc
   00F3 C5            [11]  203 	push	bc
   00F4 33            [ 6]  204 	inc	sp
   00F5 CD B0 00      [17]  205 	call	_abs
   00F8 33            [ 6]  206 	inc	sp
   00F9 C1            [10]  207 	pop	bc
                            208 ;src/Enemy.c:81: return dx+dy;
   00FA 09            [11]  209 	add	hl, bc
   00FB C9            [10]  210 	ret
                            211 ;src/Enemy.c:85: u8 enemy_can_view(Enemy* e){
                            212 ;	---------------------------------
                            213 ; Function enemy_can_view
                            214 ; ---------------------------------
   00FC                     215 _enemy_can_view::
   00FC DD E5         [15]  216 	push	ix
   00FE DD 21 00 00   [14]  217 	ld	ix,#0
   0102 DD 39         [15]  218 	add	ix,sp
   0104 21 F1 FF      [10]  219 	ld	hl,#-15
   0107 39            [11]  220 	add	hl,sp
   0108 F9            [ 6]  221 	ld	sp,hl
                            222 ;src/Enemy.c:89: x0 = player_position.x;
   0109 21 75 18      [10]  223 	ld	hl,#_player_position+0
   010C 4E            [ 7]  224 	ld	c,(hl)
                            225 ;src/Enemy.c:90: y0 = player_position.y;
   010D 3A 76 18      [13]  226 	ld	a,(#_player_position+1)
   0110 DD 77 F1      [19]  227 	ld	-15 (ix),a
                            228 ;src/Enemy.c:92: x1 = e->position.x;
   0113 DD 5E 04      [19]  229 	ld	e,4 (ix)
   0116 DD 56 05      [19]  230 	ld	d,5 (ix)
   0119 D5            [11]  231 	push	de
   011A FD E1         [14]  232 	pop	iy
   011C FD 7E 03      [19]  233 	ld	a,3 (iy)
   011F DD 77 F2      [19]  234 	ld	-14 (ix),a
                            235 ;src/Enemy.c:93: y1 = e->position.y;
   0122 D5            [11]  236 	push	de
   0123 FD E1         [14]  237 	pop	iy
   0125 FD 7E 04      [19]  238 	ld	a,4 (iy)
   0128 DD 77 F5      [19]  239 	ld	-11 (ix),a
                            240 ;src/Enemy.c:95: mask = (CELL_WALL_MASK|CELL_ENEMY_MASK)^(e->id+1);
   012B 1A            [ 7]  241 	ld	a,(de)
   012C 3C            [ 4]  242 	inc	a
   012D EE 8F         [ 7]  243 	xor	a, #0x8F
   012F DD 77 F4      [19]  244 	ld	-12 (ix),a
                            245 ;src/Enemy.c:97: dx = abs(x1-x0);
   0132 DD 7E F2      [19]  246 	ld	a,-14 (ix)
   0135 91            [ 4]  247 	sub	a, c
   0136 47            [ 4]  248 	ld	b,a
   0137 C5            [11]  249 	push	bc
   0138 C5            [11]  250 	push	bc
   0139 33            [ 6]  251 	inc	sp
   013A CD B0 00      [17]  252 	call	_abs
   013D 33            [ 6]  253 	inc	sp
   013E C1            [10]  254 	pop	bc
   013F DD 75 F9      [19]  255 	ld	-7 (ix),l
                            256 ;src/Enemy.c:98: dy = abs(y1-y0);
   0142 DD 7E F5      [19]  257 	ld	a,-11 (ix)
   0145 DD 96 F1      [19]  258 	sub	a, -15 (ix)
   0148 47            [ 4]  259 	ld	b,a
   0149 C5            [11]  260 	push	bc
   014A C5            [11]  261 	push	bc
   014B 33            [ 6]  262 	inc	sp
   014C CD B0 00      [17]  263 	call	_abs
   014F 33            [ 6]  264 	inc	sp
   0150 C1            [10]  265 	pop	bc
   0151 DD 75 F7      [19]  266 	ld	-9 (ix),l
                            267 ;src/Enemy.c:100: sx = (x0<x1)?1:-1;
   0154 79            [ 4]  268 	ld	a,c
   0155 DD 96 F2      [19]  269 	sub	a, -14 (ix)
   0158 E2 5D 01      [10]  270 	jp	PO, 00168$
   015B EE 80         [ 7]  271 	xor	a, #0x80
   015D                     272 00168$:
   015D F2 64 01      [10]  273 	jp	P,00117$
   0160 06 01         [ 7]  274 	ld	b,#0x01
   0162 18 02         [12]  275 	jr	00118$
   0164                     276 00117$:
   0164 06 FF         [ 7]  277 	ld	b,#0xFF
   0166                     278 00118$:
   0166 DD 70 F8      [19]  279 	ld	-8 (ix),b
                            280 ;src/Enemy.c:101: sy = (y0<y1)?1:-1;
   0169 DD 7E F1      [19]  281 	ld	a,-15 (ix)
   016C DD 96 F5      [19]  282 	sub	a, -11 (ix)
   016F E2 74 01      [10]  283 	jp	PO, 00169$
   0172 EE 80         [ 7]  284 	xor	a, #0x80
   0174                     285 00169$:
   0174 F2 7B 01      [10]  286 	jp	P,00119$
   0177 1E 01         [ 7]  287 	ld	e,#0x01
   0179 18 02         [12]  288 	jr	00120$
   017B                     289 00119$:
   017B 1E FF         [ 7]  290 	ld	e,#0xFF
   017D                     291 00120$:
   017D DD 73 F6      [19]  292 	ld	-10 (ix),e
                            293 ;src/Enemy.c:103: e1 = ((dx>dy)?dx:-dy)/2;
   0180 DD 7E F9      [19]  294 	ld	a,-7 (ix)
   0183 DD 77 FE      [19]  295 	ld	-2 (ix),a
   0186 DD 7E F9      [19]  296 	ld	a,-7 (ix)
   0189 17            [ 4]  297 	rla
   018A 9F            [ 4]  298 	sbc	a, a
   018B DD 77 FF      [19]  299 	ld	-1 (ix),a
   018E DD 7E F7      [19]  300 	ld	a,-9 (ix)
   0191 DD 96 F9      [19]  301 	sub	a, -7 (ix)
   0194 E2 99 01      [10]  302 	jp	PO, 00170$
   0197 EE 80         [ 7]  303 	xor	a, #0x80
   0199                     304 00170$:
   0199 F2 A4 01      [10]  305 	jp	P,00121$
   019C DD 6E FE      [19]  306 	ld	l,-2 (ix)
   019F DD 66 FF      [19]  307 	ld	h,-1 (ix)
   01A2 18 10         [12]  308 	jr	00122$
   01A4                     309 00121$:
   01A4 DD 5E F7      [19]  310 	ld	e,-9 (ix)
   01A7 DD 7E F7      [19]  311 	ld	a,-9 (ix)
   01AA 17            [ 4]  312 	rla
   01AB 9F            [ 4]  313 	sbc	a, a
   01AC 57            [ 4]  314 	ld	d,a
   01AD AF            [ 4]  315 	xor	a, a
   01AE 93            [ 4]  316 	sub	a, e
   01AF 6F            [ 4]  317 	ld	l,a
   01B0 3E 00         [ 7]  318 	ld	a, #0x00
   01B2 9A            [ 4]  319 	sbc	a, d
   01B3 67            [ 4]  320 	ld	h,a
   01B4                     321 00122$:
   01B4 5D            [ 4]  322 	ld	e, l
   01B5 54            [ 4]  323 	ld	d, h
   01B6 CB 7C         [ 8]  324 	bit	7, h
   01B8 28 02         [12]  325 	jr	Z,00123$
   01BA EB            [ 4]  326 	ex	de,hl
   01BB 13            [ 6]  327 	inc	de
   01BC                     328 00123$:
   01BC 43            [ 4]  329 	ld	b,e
   01BD CB 2A         [ 8]  330 	sra	d
   01BF CB 18         [ 8]  331 	rr	b
                            332 ;src/Enemy.c:105: while(1){
   01C1                     333 00113$:
                            334 ;src/Enemy.c:106: e2 = e1;
   01C1 DD 70 F3      [19]  335 	ld	-13 (ix),b
                            336 ;src/Enemy.c:107: if (e2 >-dx) {
   01C4 AF            [ 4]  337 	xor	a, a
   01C5 DD 96 FE      [19]  338 	sub	a, -2 (ix)
   01C8 5F            [ 4]  339 	ld	e,a
   01C9 3E 00         [ 7]  340 	ld	a, #0x00
   01CB DD 9E FF      [19]  341 	sbc	a, -1 (ix)
   01CE 57            [ 4]  342 	ld	d,a
   01CF 78            [ 4]  343 	ld	a,b
   01D0 6F            [ 4]  344 	ld	l,a
   01D1 17            [ 4]  345 	rla
   01D2 9F            [ 4]  346 	sbc	a, a
   01D3 67            [ 4]  347 	ld	h,a
   01D4 7B            [ 4]  348 	ld	a,e
   01D5 95            [ 4]  349 	sub	a, l
   01D6 7A            [ 4]  350 	ld	a,d
   01D7 9C            [ 4]  351 	sbc	a, h
   01D8 E2 DD 01      [10]  352 	jp	PO, 00171$
   01DB EE 80         [ 7]  353 	xor	a, #0x80
   01DD                     354 00171$:
   01DD F2 EA 01      [10]  355 	jp	P,00102$
                            356 ;src/Enemy.c:108: e1 -= dy;
   01E0 78            [ 4]  357 	ld	a,b
   01E1 DD 96 F7      [19]  358 	sub	a, -9 (ix)
   01E4 47            [ 4]  359 	ld	b,a
                            360 ;src/Enemy.c:109: x0 += sx;
   01E5 79            [ 4]  361 	ld	a,c
   01E6 DD 86 F8      [19]  362 	add	a, -8 (ix)
   01E9 4F            [ 4]  363 	ld	c,a
   01EA                     364 00102$:
                            365 ;src/Enemy.c:111: if (e2 < dy) {
   01EA DD 7E F3      [19]  366 	ld	a,-13 (ix)
   01ED DD 96 F7      [19]  367 	sub	a, -9 (ix)
   01F0 E2 F5 01      [10]  368 	jp	PO, 00172$
   01F3 EE 80         [ 7]  369 	xor	a, #0x80
   01F5                     370 00172$:
   01F5 F2 06 02      [10]  371 	jp	P,00104$
                            372 ;src/Enemy.c:112: e1 += dx;
   01F8 78            [ 4]  373 	ld	a,b
   01F9 DD 86 F9      [19]  374 	add	a, -7 (ix)
   01FC 47            [ 4]  375 	ld	b,a
                            376 ;src/Enemy.c:113: y0 += sy;
   01FD DD 7E F1      [19]  377 	ld	a,-15 (ix)
   0200 DD 86 F6      [19]  378 	add	a, -10 (ix)
   0203 DD 77 F1      [19]  379 	ld	-15 (ix),a
   0206                     380 00104$:
                            381 ;src/Enemy.c:116: if((*(u8*)(MAP_MEM+(x0+(y0*MAP_WIDTH)))&(mask))||(
   0206 79            [ 4]  382 	ld	a,c
   0207 5F            [ 4]  383 	ld	e,a
   0208 17            [ 4]  384 	rla
   0209 9F            [ 4]  385 	sbc	a, a
   020A 57            [ 4]  386 	ld	d,a
   020B DD 7E F1      [19]  387 	ld	a,-15 (ix)
   020E DD 77 FA      [19]  388 	ld	-6 (ix),a
   0211 DD 7E F1      [19]  389 	ld	a,-15 (ix)
   0214 17            [ 4]  390 	rla
   0215 9F            [ 4]  391 	sbc	a, a
   0216 DD 77 FB      [19]  392 	ld	-5 (ix),a
   0219 DD 7E FA      [19]  393 	ld	a,-6 (ix)
   021C DD 77 FC      [19]  394 	ld	-4 (ix),a
   021F DD 7E FB      [19]  395 	ld	a,-5 (ix)
   0222 DD 77 FD      [19]  396 	ld	-3 (ix),a
   0225 3E 06         [ 7]  397 	ld	a,#0x05+1
   0227 18 08         [12]  398 	jr	00174$
   0229                     399 00173$:
   0229 DD CB FC 26   [23]  400 	sla	-4 (ix)
   022D DD CB FD 16   [23]  401 	rl	-3 (ix)
   0231                     402 00174$:
   0231 3D            [ 4]  403 	dec	a
   0232 20 F5         [12]  404 	jr	NZ,00173$
   0234 DD 6E FC      [19]  405 	ld	l,-4 (ix)
   0237 DD 66 FD      [19]  406 	ld	h,-3 (ix)
   023A 19            [11]  407 	add	hl,de
   023B D5            [11]  408 	push	de
   023C 11 D0 88      [10]  409 	ld	de,#0x88D0
   023F 19            [11]  410 	add	hl, de
   0240 D1            [10]  411 	pop	de
   0241 7E            [ 7]  412 	ld	a,(hl)
   0242 DD A6 F4      [19]  413 	and	a, -12 (ix)
   0245 B7            [ 4]  414 	or	a, a
   0246 20 47         [12]  415 	jr	NZ,00105$
                            416 ;src/Enemy.c:117: (*(u8*)(MAP_MEM+((x0)+((y0-sy)*MAP_WIDTH)))&(mask))&&
   0248 DD 6E F6      [19]  417 	ld	l,-10 (ix)
   024B DD 7E F6      [19]  418 	ld	a,-10 (ix)
   024E 17            [ 4]  419 	rla
   024F 9F            [ 4]  420 	sbc	a, a
   0250 67            [ 4]  421 	ld	h,a
   0251 DD 7E FA      [19]  422 	ld	a,-6 (ix)
   0254 95            [ 4]  423 	sub	a, l
   0255 6F            [ 4]  424 	ld	l,a
   0256 DD 7E FB      [19]  425 	ld	a,-5 (ix)
   0259 9C            [ 4]  426 	sbc	a, h
   025A 67            [ 4]  427 	ld	h,a
   025B 29            [11]  428 	add	hl, hl
   025C 29            [11]  429 	add	hl, hl
   025D 29            [11]  430 	add	hl, hl
   025E 29            [11]  431 	add	hl, hl
   025F 29            [11]  432 	add	hl, hl
   0260 19            [11]  433 	add	hl,de
   0261 D5            [11]  434 	push	de
   0262 11 D0 88      [10]  435 	ld	de,#0x88D0
   0265 19            [11]  436 	add	hl, de
   0266 D1            [10]  437 	pop	de
   0267 7E            [ 7]  438 	ld	a,(hl)
   0268 DD A6 F4      [19]  439 	and	a, -12 (ix)
   026B B7            [ 4]  440 	or	a, a
   026C 28 25         [12]  441 	jr	Z,00106$
                            442 ;src/Enemy.c:118: (*(u8*)(MAP_MEM+((x0-sx)+(y0*MAP_WIDTH)))&(mask))
   026E DD 6E F8      [19]  443 	ld	l,-8 (ix)
   0271 DD 7E F8      [19]  444 	ld	a,-8 (ix)
   0274 17            [ 4]  445 	rla
   0275 9F            [ 4]  446 	sbc	a, a
   0276 67            [ 4]  447 	ld	h,a
   0277 7B            [ 4]  448 	ld	a,e
   0278 95            [ 4]  449 	sub	a, l
   0279 5F            [ 4]  450 	ld	e,a
   027A 7A            [ 4]  451 	ld	a,d
   027B 9C            [ 4]  452 	sbc	a, h
   027C 57            [ 4]  453 	ld	d,a
   027D DD 6E FC      [19]  454 	ld	l,-4 (ix)
   0280 DD 66 FD      [19]  455 	ld	h,-3 (ix)
   0283 19            [11]  456 	add	hl,de
   0284 11 D0 88      [10]  457 	ld	de,#0x88D0
   0287 19            [11]  458 	add	hl,de
   0288 7E            [ 7]  459 	ld	a,(hl)
   0289 DD A6 F4      [19]  460 	and	a, -12 (ix)
   028C B7            [ 4]  461 	or	a, a
   028D 28 04         [12]  462 	jr	Z,00106$
   028F                     463 00105$:
                            464 ;src/Enemy.c:121: return 0;
   028F 2E 00         [ 7]  465 	ld	l,#0x00
   0291 18 12         [12]  466 	jr	00115$
   0293                     467 00106$:
                            468 ;src/Enemy.c:123: if ((x0==x1 && y0==y1)){
   0293 DD 7E F2      [19]  469 	ld	a,-14 (ix)
   0296 91            [ 4]  470 	sub	a, c
   0297 C2 C1 01      [10]  471 	jp	NZ,00113$
   029A DD 7E F1      [19]  472 	ld	a,-15 (ix)
   029D DD 96 F5      [19]  473 	sub	a, -11 (ix)
   02A0 C2 C1 01      [10]  474 	jp	NZ,00113$
                            475 ;src/Enemy.c:128: return 1;
   02A3 2E 01         [ 7]  476 	ld	l,#0x01
   02A5                     477 00115$:
   02A5 DD F9         [10]  478 	ld	sp, ix
   02A7 DD E1         [14]  479 	pop	ix
   02A9 C9            [10]  480 	ret
                            481 ;src/Enemy.c:131: u8 enemy_is_adjacent_to_player(Enemy* e){    
                            482 ;	---------------------------------
                            483 ; Function enemy_is_adjacent_to_player
                            484 ; ---------------------------------
   02AA                     485 _enemy_is_adjacent_to_player::
   02AA DD E5         [15]  486 	push	ix
   02AC DD 21 00 00   [14]  487 	ld	ix,#0
   02B0 DD 39         [15]  488 	add	ix,sp
   02B2 F5            [11]  489 	push	af
                            490 ;src/Enemy.c:132: return (dist(player_position.x,player_position.y,e->position.x,e->position.y)==1);
   02B3 DD 6E 04      [19]  491 	ld	l,4 (ix)
   02B6 DD 66 05      [19]  492 	ld	h,5 (ix)
   02B9 E5            [11]  493 	push	hl
   02BA FD E1         [14]  494 	pop	iy
   02BC 11 04 00      [10]  495 	ld	de, #0x0004
   02BF 19            [11]  496 	add	hl, de
   02C0 7E            [ 7]  497 	ld	a,(hl)
   02C1 DD 77 FF      [19]  498 	ld	-1 (ix),a
   02C4 FD 7E 03      [19]  499 	ld	a,3 (iy)
   02C7 DD 77 FE      [19]  500 	ld	-2 (ix),a
   02CA 21 76 18      [10]  501 	ld	hl, #_player_position + 1
   02CD 4E            [ 7]  502 	ld	c,(hl)
   02CE 21 75 18      [10]  503 	ld	hl, #_player_position + 0
   02D1 5E            [ 7]  504 	ld	e,(hl)
   02D2 DD 66 FF      [19]  505 	ld	h,-1 (ix)
   02D5 DD 6E FE      [19]  506 	ld	l,-2 (ix)
   02D8 E5            [11]  507 	push	hl
   02D9 51            [ 4]  508 	ld	d, c
   02DA D5            [11]  509 	push	de
   02DB CD CD 00      [17]  510 	call	_dist
   02DE F1            [10]  511 	pop	af
   02DF F1            [10]  512 	pop	af
   02E0 2D            [ 4]  513 	dec	l
   02E1 20 04         [12]  514 	jr	NZ,00103$
   02E3 3E 01         [ 7]  515 	ld	a,#0x01
   02E5 18 01         [12]  516 	jr	00104$
   02E7                     517 00103$:
   02E7 AF            [ 4]  518 	xor	a,a
   02E8                     519 00104$:
   02E8 6F            [ 4]  520 	ld	l,a
   02E9 DD F9         [10]  521 	ld	sp, ix
   02EB DD E1         [14]  522 	pop	ix
   02ED C9            [10]  523 	ret
                            524 ;src/Enemy.c:136: void enemy_new_enemy(Vec2u* position) {
                            525 ;	---------------------------------
                            526 ; Function enemy_new_enemy
                            527 ; ---------------------------------
   02EE                     528 _enemy_new_enemy::
   02EE DD E5         [15]  529 	push	ix
   02F0 DD 21 00 00   [14]  530 	ld	ix,#0
   02F4 DD 39         [15]  531 	add	ix,sp
   02F6 F5            [11]  532 	push	af
   02F7 F5            [11]  533 	push	af
   02F8 3B            [ 6]  534 	dec	sp
                            535 ;src/Enemy.c:138: Enemy* enemy=(enemyArray+ENEMY_MAX_ENEMIES);
   02F9 01 5E 7D      [10]  536 	ld	bc,#_enemyArray+120
                            537 ;src/Enemy.c:141: x=position->x;
   02FC DD 6E 04      [19]  538 	ld	l,4 (ix)
   02FF DD 66 05      [19]  539 	ld	h,5 (ix)
   0302 7E            [ 7]  540 	ld	a,(hl)
   0303 DD 77 FE      [19]  541 	ld	-2 (ix),a
                            542 ;src/Enemy.c:142: y=position->y;
   0306 23            [ 6]  543 	inc	hl
   0307 7E            [ 7]  544 	ld	a,(hl)
   0308 DD 77 FF      [19]  545 	ld	-1 (ix),a
                            546 ;src/Enemy.c:144: memPos = (MAP_MEM+x+(y*MAP_WIDTH));
   030B DD 5E FE      [19]  547 	ld	e,-2 (ix)
   030E 16 00         [ 7]  548 	ld	d,#0x00
   0310 21 D0 88      [10]  549 	ld	hl,#0x88D0
   0313 19            [11]  550 	add	hl,de
   0314 EB            [ 4]  551 	ex	de,hl
   0315 DD 6E FF      [19]  552 	ld	l,-1 (ix)
   0318 26 00         [ 7]  553 	ld	h,#0x00
   031A 29            [11]  554 	add	hl, hl
   031B 29            [11]  555 	add	hl, hl
   031C 29            [11]  556 	add	hl, hl
   031D 29            [11]  557 	add	hl, hl
   031E 29            [11]  558 	add	hl, hl
   031F 19            [11]  559 	add	hl,de
   0320 33            [ 6]  560 	inc	sp
   0321 33            [ 6]  561 	inc	sp
   0322 E5            [11]  562 	push	hl
                            563 ;src/Enemy.c:146: while(i){
   0323 DD 36 FD 0F   [19]  564 	ld	-3 (ix),#0x0F
   0327                     565 00103$:
   0327 DD 7E FD      [19]  566 	ld	a,-3 (ix)
   032A B7            [ 4]  567 	or	a, a
   032B CA B7 03      [10]  568 	jp	Z,00106$
                            569 ;src/Enemy.c:147: --i;
   032E DD 35 FD      [23]  570 	dec	-3 (ix)
                            571 ;src/Enemy.c:148: --enemy;
   0331 79            [ 4]  572 	ld	a,c
   0332 C6 F8         [ 7]  573 	add	a,#0xF8
   0334 4F            [ 4]  574 	ld	c,a
   0335 78            [ 4]  575 	ld	a,b
   0336 CE FF         [ 7]  576 	adc	a,#0xFF
   0338 47            [ 4]  577 	ld	b,a
                            578 ;src/Enemy.c:149: if(enemy->hitPoints==0){
   0339 21 05 00      [10]  579 	ld	hl,#0x0005
   033C 09            [11]  580 	add	hl,bc
   033D EB            [ 4]  581 	ex	de,hl
   033E 1A            [ 7]  582 	ld	a,(de)
   033F B7            [ 4]  583 	or	a, a
   0340 20 E5         [12]  584 	jr	NZ,00103$
                            585 ;src/Enemy.c:150: enemy->id=i;
   0342 DD 7E FD      [19]  586 	ld	a,-3 (ix)
   0345 02            [ 7]  587 	ld	(bc),a
                            588 ;src/Enemy.c:152: enemy->type=cpct_getRandom_mxor_u8()&1;
   0346 69            [ 4]  589 	ld	l, c
   0347 60            [ 4]  590 	ld	h, b
   0348 23            [ 6]  591 	inc	hl
   0349 E5            [11]  592 	push	hl
   034A C5            [11]  593 	push	bc
   034B D5            [11]  594 	push	de
   034C CD 97 7A      [17]  595 	call	_cpct_getRandom_mxor_u8
   034F 7D            [ 4]  596 	ld	a,l
   0350 D1            [10]  597 	pop	de
   0351 C1            [10]  598 	pop	bc
   0352 E1            [10]  599 	pop	hl
   0353 E6 01         [ 7]  600 	and	a, #0x01
   0355 77            [ 7]  601 	ld	(hl),a
                            602 ;src/Enemy.c:154: enemy->hitPoints=ENEMY_INITIAL_HP;
   0356 3E FF         [ 7]  603 	ld	a,#0xFF
   0358 12            [ 7]  604 	ld	(de),a
                            605 ;src/Enemy.c:156: enemy->attackValue = (10)+level_get_level()+(cpct_getRandom_mxor_u8()&7);
   0359 21 06 00      [10]  606 	ld	hl,#0x0006
   035C 09            [11]  607 	add	hl,bc
   035D E5            [11]  608 	push	hl
   035E C5            [11]  609 	push	bc
   035F CD F0 0F      [17]  610 	call	_level_get_level
   0362 7D            [ 4]  611 	ld	a,l
   0363 C1            [10]  612 	pop	bc
   0364 E1            [10]  613 	pop	hl
   0365 C6 0A         [ 7]  614 	add	a, #0x0A
   0367 5F            [ 4]  615 	ld	e,a
   0368 E5            [11]  616 	push	hl
   0369 C5            [11]  617 	push	bc
   036A D5            [11]  618 	push	de
   036B CD 97 7A      [17]  619 	call	_cpct_getRandom_mxor_u8
   036E 7D            [ 4]  620 	ld	a,l
   036F D1            [10]  621 	pop	de
   0370 C1            [10]  622 	pop	bc
   0371 E1            [10]  623 	pop	hl
   0372 E6 07         [ 7]  624 	and	a, #0x07
   0374 83            [ 4]  625 	add	a,e
   0375 77            [ 7]  626 	ld	(hl),a
                            627 ;src/Enemy.c:157: enemy->defenseValue = level_get_level()+(cpct_getRandom_mxor_u8()&7);
   0376 21 07 00      [10]  628 	ld	hl,#0x0007
   0379 09            [11]  629 	add	hl,bc
   037A E5            [11]  630 	push	hl
   037B C5            [11]  631 	push	bc
   037C CD F0 0F      [17]  632 	call	_level_get_level
   037F 5D            [ 4]  633 	ld	e,l
   0380 D5            [11]  634 	push	de
   0381 CD 97 7A      [17]  635 	call	_cpct_getRandom_mxor_u8
   0384 7D            [ 4]  636 	ld	a,l
   0385 D1            [10]  637 	pop	de
   0386 C1            [10]  638 	pop	bc
   0387 E1            [10]  639 	pop	hl
   0388 E6 07         [ 7]  640 	and	a, #0x07
   038A 83            [ 4]  641 	add	a,e
   038B 77            [ 7]  642 	ld	(hl),a
                            643 ;src/Enemy.c:159: enemy->direction=(cpct_getRandom_mxor_u8()&3)*2;
   038C 59            [ 4]  644 	ld	e, c
   038D 50            [ 4]  645 	ld	d, b
   038E 13            [ 6]  646 	inc	de
   038F 13            [ 6]  647 	inc	de
   0390 C5            [11]  648 	push	bc
   0391 D5            [11]  649 	push	de
   0392 CD 97 7A      [17]  650 	call	_cpct_getRandom_mxor_u8
   0395 D1            [10]  651 	pop	de
   0396 C1            [10]  652 	pop	bc
   0397 7D            [ 4]  653 	ld	a,l
   0398 E6 03         [ 7]  654 	and	a, #0x03
   039A 87            [ 4]  655 	add	a, a
   039B 12            [ 7]  656 	ld	(de),a
                            657 ;src/Enemy.c:161: enemy->position.x = x;
   039C 03            [ 6]  658 	inc	bc
   039D 03            [ 6]  659 	inc	bc
   039E 03            [ 6]  660 	inc	bc
   039F DD 7E FE      [19]  661 	ld	a,-2 (ix)
   03A2 02            [ 7]  662 	ld	(bc),a
                            663 ;src/Enemy.c:162: enemy->position.y = y;
   03A3 03            [ 6]  664 	inc	bc
   03A4 DD 7E FF      [19]  665 	ld	a,-1 (ix)
   03A7 02            [ 7]  666 	ld	(bc),a
                            667 ;src/Enemy.c:164: *memPos=(i+1)|(*memPos);
   03A8 DD 4E FD      [19]  668 	ld	c,-3 (ix)
   03AB 0C            [ 4]  669 	inc	c
   03AC E1            [10]  670 	pop	hl
   03AD E5            [11]  671 	push	hl
   03AE 7E            [ 7]  672 	ld	a,(hl)
   03AF B1            [ 4]  673 	or	a, c
   03B0 E1            [10]  674 	pop	hl
   03B1 E5            [11]  675 	push	hl
   03B2 77            [ 7]  676 	ld	(hl),a
                            677 ;src/Enemy.c:166: ++activeEnemies;
   03B3 21 E5 7C      [10]  678 	ld	hl, #_activeEnemies+0
   03B6 34            [11]  679 	inc	(hl)
                            680 ;src/Enemy.c:167: break;
   03B7                     681 00106$:
   03B7 DD F9         [10]  682 	ld	sp, ix
   03B9 DD E1         [14]  683 	pop	ix
   03BB C9            [10]  684 	ret
                            685 ;src/Enemy.c:213: u8 enemy_try_new_spawn(){
                            686 ;	---------------------------------
                            687 ; Function enemy_try_new_spawn
                            688 ; ---------------------------------
   03BC                     689 _enemy_try_new_spawn::
   03BC DD E5         [15]  690 	push	ix
   03BE DD 21 00 00   [14]  691 	ld	ix,#0
   03C2 DD 39         [15]  692 	add	ix,sp
   03C4 21 F9 FF      [10]  693 	ld	hl,#-7
   03C7 39            [11]  694 	add	hl,sp
   03C8 F9            [ 6]  695 	ld	sp,hl
                            696 ;src/Enemy.c:216: if(activeEnemies<ENEMY_MAX_ENEMIES){
   03C9 3A E5 7C      [13]  697 	ld	a,(#_activeEnemies + 0)
   03CC D6 0F         [ 7]  698 	sub	a, #0x0F
   03CE 30 74         [12]  699 	jr	NC,00106$
                            700 ;src/Enemy.c:217: pos.x=cpct_getRandom_mxor_u8()%MAP_WIDTH;
   03D0 21 00 00      [10]  701 	ld	hl,#0x0000
   03D3 39            [11]  702 	add	hl,sp
   03D4 E5            [11]  703 	push	hl
   03D5 CD 97 7A      [17]  704 	call	_cpct_getRandom_mxor_u8
   03D8 7D            [ 4]  705 	ld	a,l
   03D9 E1            [10]  706 	pop	hl
   03DA E6 1F         [ 7]  707 	and	a, #0x1F
   03DC 77            [ 7]  708 	ld	(hl),a
                            709 ;src/Enemy.c:218: pos.y=cpct_getRandom_mxor_u8()%MAP_HEIGHT;
   03DD 21 00 00      [10]  710 	ld	hl,#0x0000
   03E0 39            [11]  711 	add	hl,sp
   03E1 DD 75 FE      [19]  712 	ld	-2 (ix),l
   03E4 DD 74 FF      [19]  713 	ld	-1 (ix),h
   03E7 23            [ 6]  714 	inc	hl
   03E8 E5            [11]  715 	push	hl
   03E9 CD 97 7A      [17]  716 	call	_cpct_getRandom_mxor_u8
   03EC C1            [10]  717 	pop	bc
   03ED 7D            [ 4]  718 	ld	a,l
   03EE E6 1F         [ 7]  719 	and	a, #0x1F
   03F0 DD 77 FD      [19]  720 	ld	-3 (ix), a
   03F3 02            [ 7]  721 	ld	(bc),a
                            722 ;src/Enemy.c:220: if((*(u8*)(MAP_MEM+pos.x+(pos.y*MAP_WIDTH))&(CELL_WALL_MASK|CELL_ENEMY_MASK))==0){
   03F4 DD 6E FE      [19]  723 	ld	l,-2 (ix)
   03F7 DD 66 FF      [19]  724 	ld	h,-1 (ix)
   03FA 7E            [ 7]  725 	ld	a,(hl)
   03FB DD 77 FB      [19]  726 	ld	-5 (ix), a
   03FE 5F            [ 4]  727 	ld	e, a
   03FF 16 00         [ 7]  728 	ld	d,#0x00
   0401 21 D0 88      [10]  729 	ld	hl,#0x88D0
   0404 19            [11]  730 	add	hl,de
   0405 EB            [ 4]  731 	ex	de,hl
   0406 0A            [ 7]  732 	ld	a,(bc)
   0407 DD 77 FC      [19]  733 	ld	-4 (ix),a
   040A DD 6E FD      [19]  734 	ld	l,-3 (ix)
   040D 26 00         [ 7]  735 	ld	h,#0x00
   040F 29            [11]  736 	add	hl, hl
   0410 29            [11]  737 	add	hl, hl
   0411 29            [11]  738 	add	hl, hl
   0412 29            [11]  739 	add	hl, hl
   0413 29            [11]  740 	add	hl, hl
   0414 19            [11]  741 	add	hl,de
   0415 7E            [ 7]  742 	ld	a,(hl)
   0416 E6 8F         [ 7]  743 	and	a, #0x8F
   0418 20 2A         [12]  744 	jr	NZ,00106$
                            745 ;src/Enemy.c:221: if(dist(player_position.x, player_position.y, pos.x, pos.y)>ENEMY_VIEW_DISTANCE){
   041A 21 76 18      [10]  746 	ld	hl, #_player_position + 1
   041D 4E            [ 7]  747 	ld	c,(hl)
   041E 21 75 18      [10]  748 	ld	hl, #_player_position + 0
   0421 5E            [ 7]  749 	ld	e,(hl)
   0422 DD 66 FC      [19]  750 	ld	h,-4 (ix)
   0425 DD 6E FB      [19]  751 	ld	l,-5 (ix)
   0428 E5            [11]  752 	push	hl
   0429 51            [ 4]  753 	ld	d, c
   042A D5            [11]  754 	push	de
   042B CD CD 00      [17]  755 	call	_dist
   042E F1            [10]  756 	pop	af
   042F F1            [10]  757 	pop	af
   0430 3E 06         [ 7]  758 	ld	a,#0x06
   0432 95            [ 4]  759 	sub	a, l
   0433 30 0F         [12]  760 	jr	NC,00106$
                            761 ;src/Enemy.c:222: enemy_new_enemy(&pos);
   0435 DD 4E FE      [19]  762 	ld	c,-2 (ix)
   0438 DD 46 FF      [19]  763 	ld	b,-1 (ix)
   043B C5            [11]  764 	push	bc
   043C CD EE 02      [17]  765 	call	_enemy_new_enemy
   043F F1            [10]  766 	pop	af
                            767 ;src/Enemy.c:223: return 1;
   0440 2E 01         [ 7]  768 	ld	l,#0x01
   0442 18 02         [12]  769 	jr	00107$
   0444                     770 00106$:
                            771 ;src/Enemy.c:227: return 0;
   0444 2E 00         [ 7]  772 	ld	l,#0x00
   0446                     773 00107$:
   0446 DD F9         [10]  774 	ld	sp, ix
   0448 DD E1         [14]  775 	pop	ix
   044A C9            [10]  776 	ret
                            777 ;src/Enemy.c:230: u8 enemy_collision_at_dir(Vec2u* pos, u8 dir){
                            778 ;	---------------------------------
                            779 ; Function enemy_collision_at_dir
                            780 ; ---------------------------------
   044B                     781 _enemy_collision_at_dir::
   044B DD E5         [15]  782 	push	ix
   044D DD 21 00 00   [14]  783 	ld	ix,#0
   0451 DD 39         [15]  784 	add	ix,sp
   0453 F5            [11]  785 	push	af
   0454 3B            [ 6]  786 	dec	sp
                            787 ;src/Enemy.c:235: dx = movement_directionArray[dir];
   0455 01 F8 0B      [10]  788 	ld	bc,#_movement_directionArray+0
   0458 DD 6E 06      [19]  789 	ld	l,6 (ix)
   045B 26 00         [ 7]  790 	ld	h,#0x00
   045D 09            [11]  791 	add	hl,bc
   045E 5E            [ 7]  792 	ld	e,(hl)
                            793 ;src/Enemy.c:236: dy = movement_directionArray[dir+1];
   045F DD 56 06      [19]  794 	ld	d,6 (ix)
   0462 14            [ 4]  795 	inc	d
   0463 6A            [ 4]  796 	ld	l,d
   0464 26 00         [ 7]  797 	ld	h,#0x00
   0466 09            [11]  798 	add	hl,bc
   0467 7E            [ 7]  799 	ld	a,(hl)
   0468 DD 77 FD      [19]  800 	ld	-3 (ix),a
                            801 ;src/Enemy.c:238: val = *(u8*)(MAP_MEM + (pos->x + dx) + ((pos->y + dy)*MAP_WIDTH));
   046B DD 4E 04      [19]  802 	ld	c,4 (ix)
   046E DD 46 05      [19]  803 	ld	b,5 (ix)
   0471 0A            [ 7]  804 	ld	a,(bc)
   0472 6F            [ 4]  805 	ld	l,a
   0473 26 00         [ 7]  806 	ld	h,#0x00
   0475 7B            [ 4]  807 	ld	a,e
   0476 17            [ 4]  808 	rla
   0477 9F            [ 4]  809 	sbc	a, a
   0478 57            [ 4]  810 	ld	d,a
   0479 19            [11]  811 	add	hl,de
   047A DD 75 FE      [19]  812 	ld	-2 (ix),l
   047D DD 74 FF      [19]  813 	ld	-1 (ix),h
   0480 EB            [ 4]  814 	ex	de,hl
   0481 21 D0 88      [10]  815 	ld	hl,#0x88D0
   0484 19            [11]  816 	add	hl,de
   0485 EB            [ 4]  817 	ex	de,hl
   0486 69            [ 4]  818 	ld	l, c
   0487 60            [ 4]  819 	ld	h, b
   0488 23            [ 6]  820 	inc	hl
   0489 4E            [ 7]  821 	ld	c,(hl)
   048A 06 00         [ 7]  822 	ld	b,#0x00
   048C DD 6E FD      [19]  823 	ld	l,-3 (ix)
   048F DD 7E FD      [19]  824 	ld	a,-3 (ix)
   0492 17            [ 4]  825 	rla
   0493 9F            [ 4]  826 	sbc	a, a
   0494 67            [ 4]  827 	ld	h,a
   0495 09            [11]  828 	add	hl,bc
   0496 4D            [ 4]  829 	ld	c,l
   0497 44            [ 4]  830 	ld	b,h
   0498 29            [11]  831 	add	hl, hl
   0499 29            [11]  832 	add	hl, hl
   049A 29            [11]  833 	add	hl, hl
   049B 29            [11]  834 	add	hl, hl
   049C 29            [11]  835 	add	hl, hl
   049D 19            [11]  836 	add	hl,de
   049E 7E            [ 7]  837 	ld	a,(hl)
                            838 ;src/Enemy.c:240: if((val & (CELL_WALL_MASK|CELL_ENEMY_MASK)) || (((pos->x + dx) == player_position.x) && ((pos->y + dy) == player_position.y))) return 1;
   049F E6 8F         [ 7]  839 	and	a, #0x8F
   04A1 20 20         [12]  840 	jr	NZ,00101$
   04A3 21 75 18      [10]  841 	ld	hl,#_player_position+0
   04A6 5E            [ 7]  842 	ld	e,(hl)
   04A7 16 00         [ 7]  843 	ld	d,#0x00
   04A9 DD 7E FE      [19]  844 	ld	a,-2 (ix)
   04AC 93            [ 4]  845 	sub	a, e
   04AD 20 18         [12]  846 	jr	NZ,00102$
   04AF DD 7E FF      [19]  847 	ld	a,-1 (ix)
   04B2 92            [ 4]  848 	sub	a, d
   04B3 20 12         [12]  849 	jr	NZ,00102$
   04B5 21 76 18      [10]  850 	ld	hl,#_player_position+1
   04B8 5E            [ 7]  851 	ld	e,(hl)
   04B9 16 00         [ 7]  852 	ld	d,#0x00
   04BB 79            [ 4]  853 	ld	a,c
   04BC 93            [ 4]  854 	sub	a, e
   04BD 20 08         [12]  855 	jr	NZ,00102$
   04BF 78            [ 4]  856 	ld	a,b
   04C0 92            [ 4]  857 	sub	a, d
   04C1 20 04         [12]  858 	jr	NZ,00102$
   04C3                     859 00101$:
   04C3 2E 01         [ 7]  860 	ld	l,#0x01
   04C5 18 02         [12]  861 	jr	00105$
   04C7                     862 00102$:
                            863 ;src/Enemy.c:241: return 0;
   04C7 2E 00         [ 7]  864 	ld	l,#0x00
   04C9                     865 00105$:
   04C9 DD F9         [10]  866 	ld	sp, ix
   04CB DD E1         [14]  867 	pop	ix
   04CD C9            [10]  868 	ret
                            869 ;src/Enemy.c:244: u8 enemy_get_distance_to_obstacle(Enemy* e, u8 direction){
                            870 ;	---------------------------------
                            871 ; Function enemy_get_distance_to_obstacle
                            872 ; ---------------------------------
   04CE                     873 _enemy_get_distance_to_obstacle::
   04CE DD E5         [15]  874 	push	ix
   04D0 DD 21 00 00   [14]  875 	ld	ix,#0
   04D4 DD 39         [15]  876 	add	ix,sp
   04D6 21 F9 FF      [10]  877 	ld	hl,#-7
   04D9 39            [11]  878 	add	hl,sp
   04DA F9            [ 6]  879 	ld	sp,hl
                            880 ;src/Enemy.c:250: dx = movement_directionArray[direction];
   04DB 01 F8 0B      [10]  881 	ld	bc,#_movement_directionArray+0
   04DE DD 6E 06      [19]  882 	ld	l,6 (ix)
   04E1 26 00         [ 7]  883 	ld	h,#0x00
   04E3 09            [11]  884 	add	hl,bc
   04E4 7E            [ 7]  885 	ld	a,(hl)
   04E5 DD 77 F9      [19]  886 	ld	-7 (ix),a
                            887 ;src/Enemy.c:251: dy = movement_directionArray[direction+1];
   04E8 DD 5E 06      [19]  888 	ld	e,6 (ix)
   04EB 1C            [ 4]  889 	inc	e
   04EC 6B            [ 4]  890 	ld	l,e
   04ED 26 00         [ 7]  891 	ld	h,#0x00
   04EF 09            [11]  892 	add	hl,bc
   04F0 7E            [ 7]  893 	ld	a,(hl)
   04F1 DD 77 FD      [19]  894 	ld	-3 (ix),a
                            895 ;src/Enemy.c:254: position.x = e->position.x;
   04F4 21 02 00      [10]  896 	ld	hl,#0x0002
   04F7 39            [11]  897 	add	hl,sp
   04F8 4D            [ 4]  898 	ld	c,l
   04F9 44            [ 4]  899 	ld	b,h
   04FA DD 5E 04      [19]  900 	ld	e,4 (ix)
   04FD DD 56 05      [19]  901 	ld	d,5 (ix)
   0500 6B            [ 4]  902 	ld	l, e
   0501 62            [ 4]  903 	ld	h, d
   0502 23            [ 6]  904 	inc	hl
   0503 23            [ 6]  905 	inc	hl
   0504 23            [ 6]  906 	inc	hl
   0505 7E            [ 7]  907 	ld	a,(hl)
   0506 02            [ 7]  908 	ld	(bc),a
                            909 ;src/Enemy.c:255: position.y = e->position.y;
   0507 21 02 00      [10]  910 	ld	hl,#0x0002
   050A 39            [11]  911 	add	hl,sp
   050B DD 75 FE      [19]  912 	ld	-2 (ix),l
   050E DD 74 FF      [19]  913 	ld	-1 (ix),h
   0511 23            [ 6]  914 	inc	hl
   0512 4D            [ 4]  915 	ld	c,l
   0513 44            [ 4]  916 	ld	b,h
   0514 D5            [11]  917 	push	de
   0515 FD E1         [14]  918 	pop	iy
   0517 FD 7E 04      [19]  919 	ld	a,4 (iy)
   051A 02            [ 7]  920 	ld	(bc),a
                            921 ;src/Enemy.c:259: while(!(enemy_collision_at_dir(&position, direction))){
   051B DD 5E FE      [19]  922 	ld	e,-2 (ix)
   051E DD 56 FF      [19]  923 	ld	d,-1 (ix)
   0521 DD 36 FA 00   [19]  924 	ld	-6 (ix),#0x00
   0525                     925 00101$:
   0525 D5            [11]  926 	push	de
   0526 FD E1         [14]  927 	pop	iy
   0528 C5            [11]  928 	push	bc
   0529 D5            [11]  929 	push	de
   052A DD 7E 06      [19]  930 	ld	a,6 (ix)
   052D F5            [11]  931 	push	af
   052E 33            [ 6]  932 	inc	sp
   052F FD E5         [15]  933 	push	iy
   0531 CD 4B 04      [17]  934 	call	_enemy_collision_at_dir
   0534 F1            [10]  935 	pop	af
   0535 33            [ 6]  936 	inc	sp
   0536 D1            [10]  937 	pop	de
   0537 C1            [10]  938 	pop	bc
   0538 7D            [ 4]  939 	ld	a,l
   0539 B7            [ 4]  940 	or	a, a
   053A 20 1B         [12]  941 	jr	NZ,00103$
                            942 ;src/Enemy.c:260: ++count;
   053C DD 34 FA      [23]  943 	inc	-6 (ix)
                            944 ;src/Enemy.c:261: position.x += dx;
   053F DD 6E FE      [19]  945 	ld	l,-2 (ix)
   0542 DD 66 FF      [19]  946 	ld	h,-1 (ix)
   0545 7E            [ 7]  947 	ld	a, (hl)
   0546 DD 86 F9      [19]  948 	add	a, -7 (ix)
   0549 DD 6E FE      [19]  949 	ld	l,-2 (ix)
   054C DD 66 FF      [19]  950 	ld	h,-1 (ix)
   054F 77            [ 7]  951 	ld	(hl),a
                            952 ;src/Enemy.c:262: position.y += dy;
   0550 0A            [ 7]  953 	ld	a,(bc)
   0551 DD 86 FD      [19]  954 	add	a, -3 (ix)
   0554 02            [ 7]  955 	ld	(bc),a
   0555 18 CE         [12]  956 	jr	00101$
   0557                     957 00103$:
                            958 ;src/Enemy.c:265: return count;
   0557 DD 6E FA      [19]  959 	ld	l,-6 (ix)
   055A DD F9         [10]  960 	ld	sp, ix
   055C DD E1         [14]  961 	pop	ix
   055E C9            [10]  962 	ret
                            963 ;src/Enemy.c:268: void enemy_remove(Enemy* e){
                            964 ;	---------------------------------
                            965 ; Function enemy_remove
                            966 ; ---------------------------------
   055F                     967 _enemy_remove::
   055F DD E5         [15]  968 	push	ix
   0561 DD 21 00 00   [14]  969 	ld	ix,#0
   0565 DD 39         [15]  970 	add	ix,sp
                            971 ;src/Enemy.c:273: e->hitPoints=0;
   0567 DD 5E 04      [19]  972 	ld	e,4 (ix)
   056A DD 56 05      [19]  973 	ld	d,5 (ix)
   056D 21 05 00      [10]  974 	ld	hl,#0x0005
   0570 19            [11]  975 	add	hl,de
   0571 36 00         [10]  976 	ld	(hl),#0x00
                            977 ;src/Enemy.c:275: (map[e->position.x + (e->position.y)*MAP_WIDTH]) &= (CELL_ITEM_MASK);
   0573 6B            [ 4]  978 	ld	l, e
   0574 62            [ 4]  979 	ld	h, d
   0575 23            [ 6]  980 	inc	hl
   0576 23            [ 6]  981 	inc	hl
   0577 23            [ 6]  982 	inc	hl
   0578 4E            [ 7]  983 	ld	c,(hl)
   0579 06 00         [ 7]  984 	ld	b,#0x00
   057B D5            [11]  985 	push	de
   057C FD E1         [14]  986 	pop	iy
   057E FD 6E 04      [19]  987 	ld	l,4 (iy)
   0581 26 00         [ 7]  988 	ld	h,#0x00
   0583 29            [11]  989 	add	hl, hl
   0584 29            [11]  990 	add	hl, hl
   0585 29            [11]  991 	add	hl, hl
   0586 29            [11]  992 	add	hl, hl
   0587 29            [11]  993 	add	hl, hl
   0588 09            [11]  994 	add	hl,bc
   0589 01 D0 88      [10]  995 	ld	bc,#0x88D0
   058C 09            [11]  996 	add	hl,bc
   058D 7E            [ 7]  997 	ld	a,(hl)
   058E E6 70         [ 7]  998 	and	a, #0x70
   0590 77            [ 7]  999 	ld	(hl),a
                           1000 ;src/Enemy.c:276: --activeEnemies;
   0591 21 E5 7C      [10] 1001 	ld	hl, #_activeEnemies+0
   0594 35            [11] 1002 	dec	(hl)
   0595 DD E1         [14] 1003 	pop	ix
   0597 C9            [10] 1004 	ret
                           1005 ;src/Enemy.c:279: void enemy_move(Enemy* e, u8 d){
                           1006 ;	---------------------------------
                           1007 ; Function enemy_move
                           1008 ; ---------------------------------
   0598                    1009 _enemy_move::
   0598 DD E5         [15] 1010 	push	ix
   059A DD 21 00 00   [14] 1011 	ld	ix,#0
   059E DD 39         [15] 1012 	add	ix,sp
   05A0 21 F8 FF      [10] 1013 	ld	hl,#-8
   05A3 39            [11] 1014 	add	hl,sp
   05A4 F9            [ 6] 1015 	ld	sp,hl
                           1016 ;src/Enemy.c:287: x = e->position.x;
   05A5 DD 5E 04      [19] 1017 	ld	e,4 (ix)
   05A8 DD 56 05      [19] 1018 	ld	d,5 (ix)
   05AB 21 03 00      [10] 1019 	ld	hl,#0x0003
   05AE 19            [11] 1020 	add	hl,de
   05AF DD 75 FB      [19] 1021 	ld	-5 (ix),l
   05B2 DD 74 FC      [19] 1022 	ld	-4 (ix),h
   05B5 DD 6E FB      [19] 1023 	ld	l,-5 (ix)
   05B8 DD 66 FC      [19] 1024 	ld	h,-4 (ix)
   05BB 7E            [ 7] 1025 	ld	a,(hl)
   05BC DD 77 FA      [19] 1026 	ld	-6 (ix),a
                           1027 ;src/Enemy.c:288: y = e->position.y;
   05BF 21 04 00      [10] 1028 	ld	hl,#0x0004
   05C2 19            [11] 1029 	add	hl,de
   05C3 DD 75 FD      [19] 1030 	ld	-3 (ix),l
   05C6 DD 74 FE      [19] 1031 	ld	-2 (ix),h
   05C9 DD 6E FD      [19] 1032 	ld	l,-3 (ix)
   05CC DD 66 FE      [19] 1033 	ld	h,-2 (ix)
   05CF 7E            [ 7] 1034 	ld	a,(hl)
   05D0 DD 77 FF      [19] 1035 	ld	-1 (ix),a
                           1036 ;src/Enemy.c:291: (map[x + (y)*MAP_WIDTH]) &= (CELL_ITEM_MASK);
   05D3 DD 4E FA      [19] 1037 	ld	c,-6 (ix)
   05D6 06 00         [ 7] 1038 	ld	b,#0x00
   05D8 DD 6E FF      [19] 1039 	ld	l,-1 (ix)
   05DB 26 00         [ 7] 1040 	ld	h,#0x00
   05DD 29            [11] 1041 	add	hl, hl
   05DE 29            [11] 1042 	add	hl, hl
   05DF 29            [11] 1043 	add	hl, hl
   05E0 29            [11] 1044 	add	hl, hl
   05E1 29            [11] 1045 	add	hl, hl
   05E2 09            [11] 1046 	add	hl,bc
   05E3 01 D0 88      [10] 1047 	ld	bc,#0x88D0
   05E6 09            [11] 1048 	add	hl,bc
   05E7 7E            [ 7] 1049 	ld	a,(hl)
   05E8 E6 70         [ 7] 1050 	and	a, #0x70
   05EA 77            [ 7] 1051 	ld	(hl),a
                           1052 ;src/Enemy.c:293: dx=movement_directionArray[d];
   05EB 01 F8 0B      [10] 1053 	ld	bc,#_movement_directionArray+0
   05EE DD 6E 06      [19] 1054 	ld	l,6 (ix)
   05F1 26 00         [ 7] 1055 	ld	h,#0x00
   05F3 09            [11] 1056 	add	hl,bc
   05F4 7E            [ 7] 1057 	ld	a,(hl)
   05F5 DD 77 F8      [19] 1058 	ld	-8 (ix),a
                           1059 ;src/Enemy.c:294: dy=movement_directionArray[d+1];
   05F8 DD 6E 06      [19] 1060 	ld	l,6 (ix)
   05FB 2C            [ 4] 1061 	inc	l
   05FC 26 00         [ 7] 1062 	ld	h,#0x00
   05FE 09            [11] 1063 	add	hl,bc
   05FF 46            [ 7] 1064 	ld	b,(hl)
                           1065 ;src/Enemy.c:297: x+=dx;
   0600 DD 7E FA      [19] 1066 	ld	a, -6 (ix)
   0603 DD 86 F8      [19] 1067 	add	a, -8 (ix)
   0606 4F            [ 4] 1068 	ld	c,a
                           1069 ;src/Enemy.c:298: y+=dy;
   0607 DD 7E FF      [19] 1070 	ld	a, -1 (ix)
   060A 80            [ 4] 1071 	add	a, b
   060B DD 77 F9      [19] 1072 	ld	-7 (ix),a
                           1073 ;src/Enemy.c:300: e->direction = d;
   060E 6B            [ 4] 1074 	ld	l, e
   060F 62            [ 4] 1075 	ld	h, d
   0610 23            [ 6] 1076 	inc	hl
   0611 23            [ 6] 1077 	inc	hl
   0612 DD 7E 06      [19] 1078 	ld	a,6 (ix)
   0615 77            [ 7] 1079 	ld	(hl),a
                           1080 ;src/Enemy.c:302: e->position.x = x;
   0616 DD 6E FB      [19] 1081 	ld	l,-5 (ix)
   0619 DD 66 FC      [19] 1082 	ld	h,-4 (ix)
   061C 71            [ 7] 1083 	ld	(hl),c
                           1084 ;src/Enemy.c:303: e->position.y = y;
   061D DD 6E FD      [19] 1085 	ld	l,-3 (ix)
   0620 DD 66 FE      [19] 1086 	ld	h,-2 (ix)
   0623 DD 7E F9      [19] 1087 	ld	a,-7 (ix)
   0626 77            [ 7] 1088 	ld	(hl),a
                           1089 ;src/Enemy.c:306: (map[x + (y)*MAP_WIDTH]) |= ((e->id)+1);
   0627 06 00         [ 7] 1090 	ld	b,#0x00
   0629 DD 6E F9      [19] 1091 	ld	l,-7 (ix)
   062C 26 00         [ 7] 1092 	ld	h,#0x00
   062E 29            [11] 1093 	add	hl, hl
   062F 29            [11] 1094 	add	hl, hl
   0630 29            [11] 1095 	add	hl, hl
   0631 29            [11] 1096 	add	hl, hl
   0632 29            [11] 1097 	add	hl, hl
   0633 09            [11] 1098 	add	hl, bc
   0634 E5            [11] 1099 	push	hl
   0635 FD E1         [14] 1100 	pop	iy
   0637 01 D0 88      [10] 1101 	ld	bc,#0x88D0
   063A FD 09         [15] 1102 	add	iy, bc
   063C FD 4E 00      [19] 1103 	ld	c, 0 (iy)
   063F 1A            [ 7] 1104 	ld	a,(de)
   0640 3C            [ 4] 1105 	inc	a
   0641 B1            [ 4] 1106 	or	a, c
   0642 FD 77 00      [19] 1107 	ld	0 (iy), a
   0645 DD F9         [10] 1108 	ld	sp, ix
   0647 DD E1         [14] 1109 	pop	ix
   0649 C9            [10] 1110 	ret
                           1111 ;src/Enemy.c:309: u8 enemy_attack_enemy(Enemy* e){
                           1112 ;	---------------------------------
                           1113 ; Function enemy_attack_enemy
                           1114 ; ---------------------------------
   064A                    1115 _enemy_attack_enemy::
   064A DD E5         [15] 1116 	push	ix
   064C DD 21 00 00   [14] 1117 	ld	ix,#0
   0650 DD 39         [15] 1118 	add	ix,sp
   0652 3B            [ 6] 1119 	dec	sp
                           1120 ;src/Enemy.c:311: const char* t = "    DMG";
                           1121 ;src/Enemy.c:312: dmg = (player_attack_value - e->defenseValue);
   0653 DD 4E 04      [19] 1122 	ld	c,4 (ix)
   0656 DD 46 05      [19] 1123 	ld	b,5 (ix)
   0659 C5            [11] 1124 	push	bc
   065A FD E1         [14] 1125 	pop	iy
   065C FD 5E 07      [19] 1126 	ld	e,7 (iy)
   065F 3A 8C 7D      [13] 1127 	ld	a,(#_player_attack_value + 0)
   0662 93            [ 4] 1128 	sub	a, e
                           1129 ;src/Enemy.c:313: if(dmg<1) dmg = 1;
   0663 DD 77 FF      [19] 1130 	ld	-1 (ix), a
   0666 EE 80         [ 7] 1131 	xor	a, #0x80
   0668 D6 81         [ 7] 1132 	sub	a, #0x81
   066A 30 04         [12] 1133 	jr	NC,00102$
   066C DD 36 FF 01   [19] 1134 	ld	-1 (ix),#0x01
   0670                    1135 00102$:
                           1136 ;src/Enemy.c:315: cpct_memcpy(t,integer_to_string(dmg,'d'),3);
   0670 C5            [11] 1137 	push	bc
   0671 3E 64         [ 7] 1138 	ld	a,#0x64
   0673 F5            [11] 1139 	push	af
   0674 33            [ 6] 1140 	inc	sp
   0675 DD 7E FF      [19] 1141 	ld	a,-1 (ix)
   0678 F5            [11] 1142 	push	af
   0679 33            [ 6] 1143 	inc	sp
   067A CD 84 3C      [17] 1144 	call	_integer_to_string
   067D F1            [10] 1145 	pop	af
   067E 11 03 00      [10] 1146 	ld	de,#0x0003
   0681 D5            [11] 1147 	push	de
   0682 E5            [11] 1148 	push	hl
   0683 21 E4 06      [10] 1149 	ld	hl,#___str_0
   0686 E5            [11] 1150 	push	hl
   0687 CD 92 7B      [17] 1151 	call	_cpct_memcpy
   068A 3E 03         [ 7] 1152 	ld	a,#0x03
   068C F5            [11] 1153 	push	af
   068D 33            [ 6] 1154 	inc	sp
   068E 21 EC 06      [10] 1155 	ld	hl,#___str_1
   0691 E5            [11] 1156 	push	hl
   0692 CD 81 47      [17] 1157 	call	_ui_log_add_log
   0695 F1            [10] 1158 	pop	af
   0696 33            [ 6] 1159 	inc	sp
   0697 3E 05         [ 7] 1160 	ld	a,#0x05
   0699 F5            [11] 1161 	push	af
   069A 33            [ 6] 1162 	inc	sp
   069B 21 E4 06      [10] 1163 	ld	hl,#___str_0
   069E E5            [11] 1164 	push	hl
   069F CD 81 47      [17] 1165 	call	_ui_log_add_log
   06A2 F1            [10] 1166 	pop	af
   06A3 33            [ 6] 1167 	inc	sp
   06A4 CD CC 47      [17] 1168 	call	_ui_log_render
   06A7 C1            [10] 1169 	pop	bc
                           1170 ;src/Enemy.c:320: if(e->hitPoints>(u8)dmg){
   06A8 21 05 00      [10] 1171 	ld	hl,#0x0005
   06AB 09            [11] 1172 	add	hl,bc
   06AC 5E            [ 7] 1173 	ld	e,(hl)
   06AD DD 7E FF      [19] 1174 	ld	a, -1 (ix)
   06B0 93            [ 4] 1175 	sub	a, e
   06B1 30 09         [12] 1176 	jr	NC,00107$
                           1177 ;src/Enemy.c:321: e->hitPoints -= dmg;
   06B3 7B            [ 4] 1178 	ld	a,e
   06B4 DD 96 FF      [19] 1179 	sub	a, -1 (ix)
   06B7 77            [ 7] 1180 	ld	(hl),a
                           1181 ;src/Enemy.c:322: return 0;
   06B8 2E 00         [ 7] 1182 	ld	l,#0x00
   06BA 18 24         [12] 1183 	jr	00109$
   06BC                    1184 00107$:
                           1185 ;src/Enemy.c:326: enemy_remove(e);
   06BC C5            [11] 1186 	push	bc
   06BD C5            [11] 1187 	push	bc
   06BE CD 5F 05      [17] 1188 	call	_enemy_remove
   06C1 F1            [10] 1189 	pop	af
   06C2 CD 97 7A      [17] 1190 	call	_cpct_getRandom_mxor_u8
   06C5 C1            [10] 1191 	pop	bc
   06C6 CB 45         [ 8] 1192 	bit	0, l
   06C8 20 0A         [12] 1193 	jr	NZ,00103$
   06CA C5            [11] 1194 	push	bc
   06CB CD F0 0F      [17] 1195 	call	_level_get_level
   06CE C1            [10] 1196 	pop	bc
   06CF 7D            [ 4] 1197 	ld	a,l
   06D0 D6 20         [ 7] 1198 	sub	a, #0x20
   06D2 20 0A         [12] 1199 	jr	NZ,00104$
   06D4                    1200 00103$:
                           1201 ;src/Enemy.c:329: item_try_new_spawn_at(&(e->position));
   06D4 03            [ 6] 1202 	inc	bc
   06D5 03            [ 6] 1203 	inc	bc
   06D6 03            [ 6] 1204 	inc	bc
   06D7 60            [ 4] 1205 	ld	h,b
   06D8 69            [ 4] 1206 	ld	l, c
   06D9 E5            [11] 1207 	push	hl
   06DA CD 1A 0E      [17] 1208 	call	_item_try_new_spawn_at
   06DD F1            [10] 1209 	pop	af
   06DE                    1210 00104$:
                           1211 ;src/Enemy.c:332: return 1;
   06DE 2E 01         [ 7] 1212 	ld	l,#0x01
   06E0                    1213 00109$:
   06E0 33            [ 6] 1214 	inc	sp
   06E1 DD E1         [14] 1215 	pop	ix
   06E3 C9            [10] 1216 	ret
   06E4                    1217 ___str_0:
   06E4 20 20 20 20 44 4D  1218 	.ascii "    DMG"
        47
   06EB 00                 1219 	.db 0x00
   06EC                    1220 ___str_1:
   06EC 59 4F 55 20 4D 41  1221 	.ascii "YOU MAKE"
        4B 45
   06F4 00                 1222 	.db 0x00
                           1223 ;src/Enemy.c:336: void enemy_attack(Enemy* e){
                           1224 ;	---------------------------------
                           1225 ; Function enemy_attack
                           1226 ; ---------------------------------
   06F5                    1227 _enemy_attack::
   06F5 DD E5         [15] 1228 	push	ix
   06F7 DD 21 00 00   [14] 1229 	ld	ix,#0
   06FB DD 39         [15] 1230 	add	ix,sp
                           1231 ;src/Enemy.c:338: const char* t = "    HP";
                           1232 ;src/Enemy.c:339: dmg = (e->attackValue - player_defense_value);
   06FD DD 6E 04      [19] 1233 	ld	l,4 (ix)
   0700 DD 66 05      [19] 1234 	ld	h,5 (ix)
   0703 11 06 00      [10] 1235 	ld	de, #0x0006
   0706 19            [11] 1236 	add	hl, de
   0707 4E            [ 7] 1237 	ld	c,(hl)
   0708 21 8B 7D      [10] 1238 	ld	hl,#_player_defense_value
   070B 79            [ 4] 1239 	ld	a,c
   070C 96            [ 7] 1240 	sub	a, (hl)
                           1241 ;src/Enemy.c:340: if(dmg<1) dmg = 1;
   070D 47            [ 4] 1242 	ld	b,a
   070E EE 80         [ 7] 1243 	xor	a, #0x80
   0710 D6 81         [ 7] 1244 	sub	a, #0x81
   0712 30 02         [12] 1245 	jr	NC,00102$
   0714 06 01         [ 7] 1246 	ld	b,#0x01
   0716                    1247 00102$:
                           1248 ;src/Enemy.c:342: cpct_memcpy(t,integer_to_string(dmg,'d'),3);
   0716 C5            [11] 1249 	push	bc
   0717 3E 64         [ 7] 1250 	ld	a,#0x64
   0719 F5            [11] 1251 	push	af
   071A 33            [ 6] 1252 	inc	sp
   071B C5            [11] 1253 	push	bc
   071C 33            [ 6] 1254 	inc	sp
   071D CD 84 3C      [17] 1255 	call	_integer_to_string
   0720 F1            [10] 1256 	pop	af
   0721 11 03 00      [10] 1257 	ld	de,#0x0003
   0724 D5            [11] 1258 	push	de
   0725 E5            [11] 1259 	push	hl
   0726 21 6A 07      [10] 1260 	ld	hl,#___str_2
   0729 E5            [11] 1261 	push	hl
   072A CD 92 7B      [17] 1262 	call	_cpct_memcpy
   072D 3E 03         [ 7] 1263 	ld	a,#0x03
   072F F5            [11] 1264 	push	af
   0730 33            [ 6] 1265 	inc	sp
   0731 21 71 07      [10] 1266 	ld	hl,#___str_3
   0734 E5            [11] 1267 	push	hl
   0735 CD 81 47      [17] 1268 	call	_ui_log_add_log
   0738 F1            [10] 1269 	pop	af
   0739 33            [ 6] 1270 	inc	sp
   073A 3E 04         [ 7] 1271 	ld	a,#0x04
   073C F5            [11] 1272 	push	af
   073D 33            [ 6] 1273 	inc	sp
   073E 21 6A 07      [10] 1274 	ld	hl,#___str_2
   0741 E5            [11] 1275 	push	hl
   0742 CD 81 47      [17] 1276 	call	_ui_log_add_log
   0745 F1            [10] 1277 	pop	af
   0746 33            [ 6] 1278 	inc	sp
   0747 CD CC 47      [17] 1279 	call	_ui_log_render
   074A C1            [10] 1280 	pop	bc
                           1281 ;src/Enemy.c:347: if(player_health_points>(u8)dmg){
   074B 78            [ 4] 1282 	ld	a, b
   074C FD 21 8D 7D   [14] 1283 	ld	iy,#_player_health_points
   0750 FD 96 00      [19] 1284 	sub	a, 0 (iy)
   0753 30 0A         [12] 1285 	jr	NC,00104$
                           1286 ;src/Enemy.c:348: player_health_points -= dmg;
   0755 3A 8D 7D      [13] 1287 	ld	a,(#_player_health_points + 0)
   0758 21 8D 7D      [10] 1288 	ld	hl, #_player_health_points
   075B 90            [ 4] 1289 	sub	a, b
   075C 77            [ 7] 1290 	ld	(hl),a
   075D 18 05         [12] 1291 	jr	00105$
   075F                    1292 00104$:
                           1293 ;src/Enemy.c:351: player_is_dead = 1;
   075F 21 8E 7D      [10] 1294 	ld	hl,#_player_is_dead + 0
   0762 36 01         [10] 1295 	ld	(hl), #0x01
   0764                    1296 00105$:
                           1297 ;src/Enemy.c:353: ui_playerstats_render_hp();
   0764 CD 25 4C      [17] 1298 	call	_ui_playerstats_render_hp
   0767 DD E1         [14] 1299 	pop	ix
   0769 C9            [10] 1300 	ret
   076A                    1301 ___str_2:
   076A 20 20 20 20 48 50  1302 	.ascii "    HP"
   0770 00                 1303 	.db 0x00
   0771                    1304 ___str_3:
   0771 59 4F 55 20 4C 4F  1305 	.ascii "YOU LOSE"
        53 45
   0779 00                 1306 	.db 0x00
                           1307 ;src/Enemy.c:356: void enemy_go_to_player(Enemy* e){//NOT WORKING
                           1308 ;	---------------------------------
                           1309 ; Function enemy_go_to_player
                           1310 ; ---------------------------------
   077A                    1311 _enemy_go_to_player::
   077A DD E5         [15] 1312 	push	ix
   077C DD 21 00 00   [14] 1313 	ld	ix,#0
   0780 DD 39         [15] 1314 	add	ix,sp
   0782 F5            [11] 1315 	push	af
   0783 F5            [11] 1316 	push	af
                           1317 ;src/Enemy.c:361: dx=player_position.x-e->position.x;
   0784 21 75 18      [10] 1318 	ld	hl,#_player_position+0
   0787 5E            [ 7] 1319 	ld	e,(hl)
   0788 DD 4E 04      [19] 1320 	ld	c,4 (ix)
   078B DD 46 05      [19] 1321 	ld	b,5 (ix)
   078E 21 03 00      [10] 1322 	ld	hl,#0x0003
   0791 09            [11] 1323 	add	hl,bc
   0792 DD 75 FD      [19] 1324 	ld	-3 (ix),l
   0795 DD 74 FE      [19] 1325 	ld	-2 (ix),h
   0798 DD 6E FD      [19] 1326 	ld	l,-3 (ix)
   079B DD 66 FE      [19] 1327 	ld	h,-2 (ix)
   079E 56            [ 7] 1328 	ld	d,(hl)
   079F 7B            [ 4] 1329 	ld	a,e
   07A0 92            [ 4] 1330 	sub	a, d
   07A1 DD 77 FC      [19] 1331 	ld	-4 (ix),a
                           1332 ;src/Enemy.c:362: dy=player_position.y-e->position.y;
   07A4 21 76 18      [10] 1333 	ld	hl,#_player_position+1
   07A7 5E            [ 7] 1334 	ld	e,(hl)
   07A8 C5            [11] 1335 	push	bc
   07A9 FD E1         [14] 1336 	pop	iy
   07AB FD 56 04      [19] 1337 	ld	d,4 (iy)
   07AE 7B            [ 4] 1338 	ld	a,e
   07AF 92            [ 4] 1339 	sub	a, d
   07B0 6F            [ 4] 1340 	ld	l,a
                           1341 ;src/Enemy.c:364: dirX = (dx>0)?MOVEMENT_EAST:MOVEMENT_WEST;
   07B1 AF            [ 4] 1342 	xor	a, a
   07B2 DD 96 FC      [19] 1343 	sub	a, -4 (ix)
   07B5 E2 BA 07      [10] 1344 	jp	PO, 00136$
   07B8 EE 80         [ 7] 1345 	xor	a, #0x80
   07BA                    1346 00136$:
   07BA F2 C1 07      [10] 1347 	jp	P,00112$
   07BD 1E 00         [ 7] 1348 	ld	e,#0x00
   07BF 18 02         [12] 1349 	jr	00113$
   07C1                    1350 00112$:
   07C1 1E 04         [ 7] 1351 	ld	e,#0x04
   07C3                    1352 00113$:
                           1353 ;src/Enemy.c:365: dirY = (dy>0)?MOVEMENT_SOUTH:MOVEMENT_NORTH;
   07C3 AF            [ 4] 1354 	xor	a, a
   07C4 95            [ 4] 1355 	sub	a, l
   07C5 E2 CA 07      [10] 1356 	jp	PO, 00137$
   07C8 EE 80         [ 7] 1357 	xor	a, #0x80
   07CA                    1358 00137$:
   07CA F2 D1 07      [10] 1359 	jp	P,00114$
   07CD 16 06         [ 7] 1360 	ld	d,#0x06
   07CF 18 02         [12] 1361 	jr	00115$
   07D1                    1362 00114$:
   07D1 16 02         [ 7] 1363 	ld	d,#0x02
   07D3                    1364 00115$:
                           1365 ;src/Enemy.c:367: if(abs(dx)>abs(dy)){
   07D3 E5            [11] 1366 	push	hl
   07D4 C5            [11] 1367 	push	bc
   07D5 D5            [11] 1368 	push	de
   07D6 DD 7E FC      [19] 1369 	ld	a,-4 (ix)
   07D9 F5            [11] 1370 	push	af
   07DA 33            [ 6] 1371 	inc	sp
   07DB CD B0 00      [17] 1372 	call	_abs
   07DE 33            [ 6] 1373 	inc	sp
   07DF DD 75 FF      [19] 1374 	ld	-1 (ix),l
   07E2 D1            [10] 1375 	pop	de
   07E3 C1            [10] 1376 	pop	bc
   07E4 E1            [10] 1377 	pop	hl
   07E5 C5            [11] 1378 	push	bc
   07E6 D5            [11] 1379 	push	de
   07E7 7D            [ 4] 1380 	ld	a,l
   07E8 F5            [11] 1381 	push	af
   07E9 33            [ 6] 1382 	inc	sp
   07EA CD B0 00      [17] 1383 	call	_abs
   07ED 33            [ 6] 1384 	inc	sp
   07EE D1            [10] 1385 	pop	de
   07EF C1            [10] 1386 	pop	bc
   07F0 7D            [ 4] 1387 	ld	a,l
   07F1 DD 96 FF      [19] 1388 	sub	a, -1 (ix)
   07F4 E2 F9 07      [10] 1389 	jp	PO, 00138$
   07F7 EE 80         [ 7] 1390 	xor	a, #0x80
   07F9                    1391 00138$:
   07F9 F2 28 08      [10] 1392 	jp	P,00108$
                           1393 ;src/Enemy.c:368: if(!enemy_collision_at_dir(&(e->position),dirX)){
   07FC C5            [11] 1394 	push	bc
   07FD D5            [11] 1395 	push	de
   07FE 7B            [ 4] 1396 	ld	a,e
   07FF F5            [11] 1397 	push	af
   0800 33            [ 6] 1398 	inc	sp
   0801 DD 6E FD      [19] 1399 	ld	l,-3 (ix)
   0804 DD 66 FE      [19] 1400 	ld	h,-2 (ix)
   0807 E5            [11] 1401 	push	hl
   0808 CD 4B 04      [17] 1402 	call	_enemy_collision_at_dir
   080B F1            [10] 1403 	pop	af
   080C 33            [ 6] 1404 	inc	sp
   080D D1            [10] 1405 	pop	de
   080E C1            [10] 1406 	pop	bc
   080F 7D            [ 4] 1407 	ld	a,l
   0810 B7            [ 4] 1408 	or	a, a
   0811 20 0B         [12] 1409 	jr	NZ,00102$
                           1410 ;src/Enemy.c:371: enemy_move(e, dirX);
   0813 7B            [ 4] 1411 	ld	a,e
   0814 F5            [11] 1412 	push	af
   0815 33            [ 6] 1413 	inc	sp
   0816 C5            [11] 1414 	push	bc
   0817 CD 98 05      [17] 1415 	call	_enemy_move
   081A F1            [10] 1416 	pop	af
   081B 33            [ 6] 1417 	inc	sp
   081C 18 33         [12] 1418 	jr	00110$
   081E                    1419 00102$:
                           1420 ;src/Enemy.c:376: enemy_move(e, dirY);
   081E D5            [11] 1421 	push	de
   081F 33            [ 6] 1422 	inc	sp
   0820 C5            [11] 1423 	push	bc
   0821 CD 98 05      [17] 1424 	call	_enemy_move
   0824 F1            [10] 1425 	pop	af
   0825 33            [ 6] 1426 	inc	sp
   0826 18 29         [12] 1427 	jr	00110$
   0828                    1428 00108$:
                           1429 ;src/Enemy.c:380: if(!enemy_collision_at_dir(&(e->position),dirY)){
   0828 C5            [11] 1430 	push	bc
   0829 D5            [11] 1431 	push	de
   082A D5            [11] 1432 	push	de
   082B 33            [ 6] 1433 	inc	sp
   082C DD 6E FD      [19] 1434 	ld	l,-3 (ix)
   082F DD 66 FE      [19] 1435 	ld	h,-2 (ix)
   0832 E5            [11] 1436 	push	hl
   0833 CD 4B 04      [17] 1437 	call	_enemy_collision_at_dir
   0836 F1            [10] 1438 	pop	af
   0837 33            [ 6] 1439 	inc	sp
   0838 D1            [10] 1440 	pop	de
   0839 C1            [10] 1441 	pop	bc
   083A 7D            [ 4] 1442 	ld	a,l
   083B B7            [ 4] 1443 	or	a, a
   083C 20 0A         [12] 1444 	jr	NZ,00105$
                           1445 ;src/Enemy.c:383: enemy_move(e, dirY);
   083E D5            [11] 1446 	push	de
   083F 33            [ 6] 1447 	inc	sp
   0840 C5            [11] 1448 	push	bc
   0841 CD 98 05      [17] 1449 	call	_enemy_move
   0844 F1            [10] 1450 	pop	af
   0845 33            [ 6] 1451 	inc	sp
   0846 18 09         [12] 1452 	jr	00110$
   0848                    1453 00105$:
                           1454 ;src/Enemy.c:388: enemy_move(e, dirX);
   0848 7B            [ 4] 1455 	ld	a,e
   0849 F5            [11] 1456 	push	af
   084A 33            [ 6] 1457 	inc	sp
   084B C5            [11] 1458 	push	bc
   084C CD 98 05      [17] 1459 	call	_enemy_move
   084F F1            [10] 1460 	pop	af
   0850 33            [ 6] 1461 	inc	sp
   0851                    1462 00110$:
   0851 DD F9         [10] 1463 	ld	sp, ix
   0853 DD E1         [14] 1464 	pop	ix
   0855 C9            [10] 1465 	ret
                           1466 ;src/Enemy.c:394: void enemy_flee(Enemy* e) {
                           1467 ;	---------------------------------
                           1468 ; Function enemy_flee
                           1469 ; ---------------------------------
   0856                    1470 _enemy_flee::
   0856 DD E5         [15] 1471 	push	ix
   0858 DD 21 00 00   [14] 1472 	ld	ix,#0
   085C DD 39         [15] 1473 	add	ix,sp
   085E 21 F9 FF      [10] 1474 	ld	hl,#-7
   0861 39            [11] 1475 	add	hl,sp
   0862 F9            [ 6] 1476 	ld	sp,hl
                           1477 ;src/Enemy.c:398: distFromPlayX = abs(player_position.x - e->position.x);
   0863 3A 75 18      [13] 1478 	ld	a,(#_player_position+0)
   0866 DD 77 FF      [19] 1479 	ld	-1 (ix),a
   0869 DD 4E 04      [19] 1480 	ld	c,4 (ix)
   086C DD 46 05      [19] 1481 	ld	b,5 (ix)
   086F 59            [ 4] 1482 	ld	e, c
   0870 50            [ 4] 1483 	ld	d, b
   0871 13            [ 6] 1484 	inc	de
   0872 13            [ 6] 1485 	inc	de
   0873 13            [ 6] 1486 	inc	de
   0874 1A            [ 7] 1487 	ld	a,(de)
   0875 6F            [ 4] 1488 	ld	l,a
   0876 DD 7E FF      [19] 1489 	ld	a,-1 (ix)
   0879 95            [ 4] 1490 	sub	a, l
   087A 67            [ 4] 1491 	ld	h,a
   087B C5            [11] 1492 	push	bc
   087C D5            [11] 1493 	push	de
   087D E5            [11] 1494 	push	hl
   087E 33            [ 6] 1495 	inc	sp
   087F CD B0 00      [17] 1496 	call	_abs
   0882 33            [ 6] 1497 	inc	sp
   0883 D1            [10] 1498 	pop	de
   0884 C1            [10] 1499 	pop	bc
   0885 DD 75 F9      [19] 1500 	ld	-7 (ix),l
                           1501 ;src/Enemy.c:399: distFromPlayY = abs(player_position.y - e->position.y);
   0888 3A 76 18      [13] 1502 	ld	a,(#(_player_position + 0x0001) + 0)
   088B DD 77 FF      [19] 1503 	ld	-1 (ix),a
   088E 21 04 00      [10] 1504 	ld	hl,#0x0004
   0891 09            [11] 1505 	add	hl,bc
   0892 DD 75 FD      [19] 1506 	ld	-3 (ix),l
   0895 DD 74 FE      [19] 1507 	ld	-2 (ix),h
   0898 DD 6E FD      [19] 1508 	ld	l,-3 (ix)
   089B DD 66 FE      [19] 1509 	ld	h,-2 (ix)
   089E 6E            [ 7] 1510 	ld	l,(hl)
   089F DD 7E FF      [19] 1511 	ld	a,-1 (ix)
   08A2 95            [ 4] 1512 	sub	a, l
   08A3 67            [ 4] 1513 	ld	h,a
   08A4 C5            [11] 1514 	push	bc
   08A5 D5            [11] 1515 	push	de
   08A6 E5            [11] 1516 	push	hl
   08A7 33            [ 6] 1517 	inc	sp
   08A8 CD B0 00      [17] 1518 	call	_abs
   08AB 33            [ 6] 1519 	inc	sp
   08AC D1            [10] 1520 	pop	de
   08AD C1            [10] 1521 	pop	bc
                           1522 ;src/Enemy.c:401: if(distFromPlayX>distFromPlayY){//Flee X
   08AE 7D            [ 4] 1523 	ld	a,l
   08AF DD 96 F9      [19] 1524 	sub	a, -7 (ix)
   08B2 30 16         [12] 1525 	jr	NC,00102$
                           1526 ;src/Enemy.c:402: fleeFromDir=(player_position.x<e->position.x)?MOVEMENT_EAST:MOVEMENT_WEST;
   08B4 3A 75 18      [13] 1527 	ld	a,(#_player_position + 0)
   08B7 DD 77 FF      [19] 1528 	ld	-1 (ix),a
   08BA 1A            [ 7] 1529 	ld	a,(de)
   08BB 5F            [ 4] 1530 	ld	e,a
   08BC DD 7E FF      [19] 1531 	ld	a,-1 (ix)
   08BF 93            [ 4] 1532 	sub	a, e
   08C0 30 04         [12] 1533 	jr	NC,00120$
   08C2 3E 00         [ 7] 1534 	ld	a,#0x00
   08C4 18 19         [12] 1535 	jr	00103$
   08C6                    1536 00120$:
   08C6 3E 04         [ 7] 1537 	ld	a,#0x04
   08C8 18 15         [12] 1538 	jr	00103$
   08CA                    1539 00102$:
                           1540 ;src/Enemy.c:405: fleeFromDir=(player_position.y<e->position.y)?MOVEMENT_NORTH:MOVEMENT_SOUTH;
   08CA 21 76 18      [10] 1541 	ld	hl, #(_player_position + 0x0001) + 0
   08CD 5E            [ 7] 1542 	ld	e,(hl)
   08CE DD 6E FD      [19] 1543 	ld	l,-3 (ix)
   08D1 DD 66 FE      [19] 1544 	ld	h,-2 (ix)
   08D4 56            [ 7] 1545 	ld	d,(hl)
   08D5 7B            [ 4] 1546 	ld	a,e
   08D6 92            [ 4] 1547 	sub	a, d
   08D7 30 04         [12] 1548 	jr	NC,00122$
   08D9 3E 02         [ 7] 1549 	ld	a,#0x02
   08DB 18 02         [12] 1550 	jr	00123$
   08DD                    1551 00122$:
   08DD 3E 06         [ 7] 1552 	ld	a,#0x06
   08DF                    1553 00123$:
   08DF                    1554 00103$:
                           1555 ;src/Enemy.c:408: df = (fleeFromDir+4)&7;
   08DF C6 04         [ 7] 1556 	add	a, #0x04
   08E1 E6 07         [ 7] 1557 	and	a, #0x07
                           1558 ;src/Enemy.c:409: dl = (df+2)&7;
   08E3 DD 77 FA      [19] 1559 	ld	-6 (ix), a
   08E6 C6 02         [ 7] 1560 	add	a, #0x02
   08E8 E6 07         [ 7] 1561 	and	a, #0x07
   08EA DD 77 FC      [19] 1562 	ld	-4 (ix),a
                           1563 ;src/Enemy.c:410: dr = (df-2)&7;
   08ED DD 7E FA      [19] 1564 	ld	a,-6 (ix)
   08F0 C6 FE         [ 7] 1565 	add	a,#0xFE
   08F2 E6 07         [ 7] 1566 	and	a, #0x07
   08F4 5F            [ 4] 1567 	ld	e,a
                           1568 ;src/Enemy.c:412: distf = enemy_get_distance_to_obstacle(e, df);
   08F5 C5            [11] 1569 	push	bc
   08F6 D5            [11] 1570 	push	de
   08F7 DD 7E FA      [19] 1571 	ld	a,-6 (ix)
   08FA F5            [11] 1572 	push	af
   08FB 33            [ 6] 1573 	inc	sp
   08FC C5            [11] 1574 	push	bc
   08FD CD CE 04      [17] 1575 	call	_enemy_get_distance_to_obstacle
   0900 F1            [10] 1576 	pop	af
   0901 33            [ 6] 1577 	inc	sp
   0902 D1            [10] 1578 	pop	de
   0903 C1            [10] 1579 	pop	bc
   0904 DD 75 FB      [19] 1580 	ld	-5 (ix),l
                           1581 ;src/Enemy.c:413: distl = enemy_get_distance_to_obstacle(e, dl);
   0907 C5            [11] 1582 	push	bc
   0908 D5            [11] 1583 	push	de
   0909 DD 7E FC      [19] 1584 	ld	a,-4 (ix)
   090C F5            [11] 1585 	push	af
   090D 33            [ 6] 1586 	inc	sp
   090E DD 6E 04      [19] 1587 	ld	l,4 (ix)
   0911 DD 66 05      [19] 1588 	ld	h,5 (ix)
   0914 E5            [11] 1589 	push	hl
   0915 CD CE 04      [17] 1590 	call	_enemy_get_distance_to_obstacle
   0918 F1            [10] 1591 	pop	af
   0919 33            [ 6] 1592 	inc	sp
   091A D1            [10] 1593 	pop	de
   091B C1            [10] 1594 	pop	bc
                           1595 ;src/Enemy.c:414: distr = enemy_get_distance_to_obstacle(e, dr);
   091C E5            [11] 1596 	push	hl
   091D C5            [11] 1597 	push	bc
   091E D5            [11] 1598 	push	de
   091F 7B            [ 4] 1599 	ld	a,e
   0920 F5            [11] 1600 	push	af
   0921 33            [ 6] 1601 	inc	sp
   0922 DD 6E 04      [19] 1602 	ld	l,4 (ix)
   0925 DD 66 05      [19] 1603 	ld	h,5 (ix)
   0928 E5            [11] 1604 	push	hl
   0929 CD CE 04      [17] 1605 	call	_enemy_get_distance_to_obstacle
   092C F1            [10] 1606 	pop	af
   092D 33            [ 6] 1607 	inc	sp
   092E 7D            [ 4] 1608 	ld	a,l
   092F D1            [10] 1609 	pop	de
   0930 C1            [10] 1610 	pop	bc
   0931 E1            [10] 1611 	pop	hl
   0932 57            [ 4] 1612 	ld	d,a
                           1613 ;src/Enemy.c:416: if(distf>distl && distf>distr){
   0933 7D            [ 4] 1614 	ld	a,l
   0934 DD 96 FB      [19] 1615 	sub	a, -5 (ix)
   0937 30 0E         [12] 1616 	jr	NC,00113$
   0939 7A            [ 4] 1617 	ld	a,d
   093A DD 96 FB      [19] 1618 	sub	a, -5 (ix)
   093D 30 08         [12] 1619 	jr	NC,00113$
                           1620 ;src/Enemy.c:417: d = df;
   093F DD 5E FA      [19] 1621 	ld	e,-6 (ix)
                           1622 ;src/Enemy.c:418: dist = distf;
   0942 DD 6E FB      [19] 1623 	ld	l,-5 (ix)
   0945 18 22         [12] 1624 	jr	00114$
   0947                    1625 00113$:
                           1626 ;src/Enemy.c:420: else if(distl>distf && distl>distr){
   0947 DD 7E FB      [19] 1627 	ld	a,-5 (ix)
   094A 95            [ 4] 1628 	sub	a, l
   094B 30 09         [12] 1629 	jr	NC,00109$
   094D 7A            [ 4] 1630 	ld	a,d
   094E 95            [ 4] 1631 	sub	a, l
   094F 30 05         [12] 1632 	jr	NC,00109$
                           1633 ;src/Enemy.c:421: d=dl;
   0951 DD 5E FC      [19] 1634 	ld	e,-4 (ix)
                           1635 ;src/Enemy.c:422: dist=distl;
   0954 18 13         [12] 1636 	jr	00114$
   0956                    1637 00109$:
                           1638 ;src/Enemy.c:424: else if(distr>distf && distr>distl){
   0956 DD 7E FB      [19] 1639 	ld	a,-5 (ix)
   0959 92            [ 4] 1640 	sub	a, d
   095A 30 07         [12] 1641 	jr	NC,00105$
   095C 7D            [ 4] 1642 	ld	a,l
   095D 92            [ 4] 1643 	sub	a, d
   095E 30 03         [12] 1644 	jr	NC,00105$
                           1645 ;src/Enemy.c:425: d=dr;
                           1646 ;src/Enemy.c:426: dist=distr;
   0960 6A            [ 4] 1647 	ld	l,d
   0961 18 06         [12] 1648 	jr	00114$
   0963                    1649 00105$:
                           1650 ;src/Enemy.c:429: d=df;
   0963 DD 5E FA      [19] 1651 	ld	e,-6 (ix)
                           1652 ;src/Enemy.c:430: dist=distf;
   0966 DD 6E FB      [19] 1653 	ld	l,-5 (ix)
   0969                    1654 00114$:
                           1655 ;src/Enemy.c:433: if(dist){
   0969 7D            [ 4] 1656 	ld	a,l
   096A B7            [ 4] 1657 	or	a, a
   096B 28 09         [12] 1658 	jr	Z,00118$
                           1659 ;src/Enemy.c:434: enemy_move(e,d);
   096D 7B            [ 4] 1660 	ld	a,e
   096E F5            [11] 1661 	push	af
   096F 33            [ 6] 1662 	inc	sp
   0970 C5            [11] 1663 	push	bc
   0971 CD 98 05      [17] 1664 	call	_enemy_move
   0974 F1            [10] 1665 	pop	af
   0975 33            [ 6] 1666 	inc	sp
   0976                    1667 00118$:
   0976 DD F9         [10] 1668 	ld	sp, ix
   0978 DD E1         [14] 1669 	pop	ix
   097A C9            [10] 1670 	ret
                           1671 ;src/Enemy.c:439: void enemy_roam(Enemy* e) {
                           1672 ;	---------------------------------
                           1673 ; Function enemy_roam
                           1674 ; ---------------------------------
   097B                    1675 _enemy_roam::
   097B DD E5         [15] 1676 	push	ix
   097D DD 21 00 00   [14] 1677 	ld	ix,#0
   0981 DD 39         [15] 1678 	add	ix,sp
   0983 21 F8 FF      [10] 1679 	ld	hl,#-8
   0986 39            [11] 1680 	add	hl,sp
   0987 F9            [ 6] 1681 	ld	sp,hl
                           1682 ;src/Enemy.c:440: u8 d, nd=0;
   0988 0E 00         [ 7] 1683 	ld	c,#0x00
                           1684 ;src/Enemy.c:444: d = e->direction;
   098A DD 7E 04      [19] 1685 	ld	a,4 (ix)
   098D DD 77 FE      [19] 1686 	ld	-2 (ix),a
   0990 DD 7E 05      [19] 1687 	ld	a,5 (ix)
   0993 DD 77 FF      [19] 1688 	ld	-1 (ix),a
   0996 DD 5E FE      [19] 1689 	ld	e,-2 (ix)
   0999 DD 56 FF      [19] 1690 	ld	d,-1 (ix)
   099C 13            [ 6] 1691 	inc	de
   099D 13            [ 6] 1692 	inc	de
   099E 1A            [ 7] 1693 	ld	a,(de)
   099F 47            [ 4] 1694 	ld	b,a
                           1695 ;src/Enemy.c:445: pos = &(e->position);
   09A0 DD 7E FE      [19] 1696 	ld	a,-2 (ix)
   09A3 C6 03         [ 7] 1697 	add	a, #0x03
   09A5 DD 77 FC      [19] 1698 	ld	-4 (ix),a
   09A8 DD 7E FF      [19] 1699 	ld	a,-1 (ix)
   09AB CE 00         [ 7] 1700 	adc	a, #0x00
   09AD DD 77 FD      [19] 1701 	ld	-3 (ix),a
                           1702 ;src/Enemy.c:447: if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
   09B0 C5            [11] 1703 	push	bc
   09B1 D5            [11] 1704 	push	de
   09B2 C5            [11] 1705 	push	bc
   09B3 33            [ 6] 1706 	inc	sp
   09B4 DD 6E FC      [19] 1707 	ld	l,-4 (ix)
   09B7 DD 66 FD      [19] 1708 	ld	h,-3 (ix)
   09BA E5            [11] 1709 	push	hl
   09BB CD 4B 04      [17] 1710 	call	_enemy_collision_at_dir
   09BE F1            [10] 1711 	pop	af
   09BF 33            [ 6] 1712 	inc	sp
   09C0 D1            [10] 1713 	pop	de
   09C1 C1            [10] 1714 	pop	bc
   09C2 7D            [ 4] 1715 	ld	a,l
   09C3 B7            [ 4] 1716 	or	a, a
   09C4 20 07         [12] 1717 	jr	NZ,00102$
                           1718 ;src/Enemy.c:449: directions[nd]=d;
   09C6 21 00 00      [10] 1719 	ld	hl,#0x0000
   09C9 39            [11] 1720 	add	hl,sp
   09CA 70            [ 7] 1721 	ld	(hl),b
                           1722 ;src/Enemy.c:450: ++nd;
   09CB 0E 01         [ 7] 1723 	ld	c,#0x01
   09CD                    1724 00102$:
                           1725 ;src/Enemy.c:454: d=((e->direction+2)&7);
   09CD 1A            [ 7] 1726 	ld	a,(de)
   09CE C6 02         [ 7] 1727 	add	a, #0x02
   09D0 E6 07         [ 7] 1728 	and	a, #0x07
   09D2 47            [ 4] 1729 	ld	b,a
                           1730 ;src/Enemy.c:456: if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
   09D3 C5            [11] 1731 	push	bc
   09D4 D5            [11] 1732 	push	de
   09D5 C5            [11] 1733 	push	bc
   09D6 33            [ 6] 1734 	inc	sp
   09D7 DD 6E FC      [19] 1735 	ld	l,-4 (ix)
   09DA DD 66 FD      [19] 1736 	ld	h,-3 (ix)
   09DD E5            [11] 1737 	push	hl
   09DE CD 4B 04      [17] 1738 	call	_enemy_collision_at_dir
   09E1 F1            [10] 1739 	pop	af
   09E2 33            [ 6] 1740 	inc	sp
   09E3 D1            [10] 1741 	pop	de
   09E4 C1            [10] 1742 	pop	bc
   09E5 7D            [ 4] 1743 	ld	a,l
   09E6 B7            [ 4] 1744 	or	a, a
   09E7 20 0D         [12] 1745 	jr	NZ,00104$
                           1746 ;src/Enemy.c:458: directions[nd]=d;
   09E9 21 00 00      [10] 1747 	ld	hl,#0x0000
   09EC 39            [11] 1748 	add	hl,sp
   09ED 7D            [ 4] 1749 	ld	a,l
   09EE 81            [ 4] 1750 	add	a, c
   09EF 6F            [ 4] 1751 	ld	l,a
   09F0 7C            [ 4] 1752 	ld	a,h
   09F1 CE 00         [ 7] 1753 	adc	a, #0x00
   09F3 67            [ 4] 1754 	ld	h,a
   09F4 70            [ 7] 1755 	ld	(hl),b
                           1756 ;src/Enemy.c:459: ++nd;
   09F5 0C            [ 4] 1757 	inc	c
   09F6                    1758 00104$:
                           1759 ;src/Enemy.c:463: d=((e->direction-2)&7);
   09F6 1A            [ 7] 1760 	ld	a,(de)
   09F7 C6 FE         [ 7] 1761 	add	a,#0xFE
   09F9 E6 07         [ 7] 1762 	and	a, #0x07
   09FB 47            [ 4] 1763 	ld	b,a
                           1764 ;src/Enemy.c:465: if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
   09FC C5            [11] 1765 	push	bc
   09FD D5            [11] 1766 	push	de
   09FE C5            [11] 1767 	push	bc
   09FF 33            [ 6] 1768 	inc	sp
   0A00 DD 6E FC      [19] 1769 	ld	l,-4 (ix)
   0A03 DD 66 FD      [19] 1770 	ld	h,-3 (ix)
   0A06 E5            [11] 1771 	push	hl
   0A07 CD 4B 04      [17] 1772 	call	_enemy_collision_at_dir
   0A0A F1            [10] 1773 	pop	af
   0A0B 33            [ 6] 1774 	inc	sp
   0A0C D1            [10] 1775 	pop	de
   0A0D C1            [10] 1776 	pop	bc
   0A0E 7D            [ 4] 1777 	ld	a,l
   0A0F B7            [ 4] 1778 	or	a, a
   0A10 20 0D         [12] 1779 	jr	NZ,00106$
                           1780 ;src/Enemy.c:467: directions[nd]=d;
   0A12 21 00 00      [10] 1781 	ld	hl,#0x0000
   0A15 39            [11] 1782 	add	hl,sp
   0A16 7D            [ 4] 1783 	ld	a,l
   0A17 81            [ 4] 1784 	add	a, c
   0A18 6F            [ 4] 1785 	ld	l,a
   0A19 7C            [ 4] 1786 	ld	a,h
   0A1A CE 00         [ 7] 1787 	adc	a, #0x00
   0A1C 67            [ 4] 1788 	ld	h,a
   0A1D 70            [ 7] 1789 	ld	(hl),b
                           1790 ;src/Enemy.c:468: ++nd;
   0A1E 0C            [ 4] 1791 	inc	c
   0A1F                    1792 00106$:
                           1793 ;src/Enemy.c:472: if(nd==0){//If cannot move any other direction than back
   0A1F 79            [ 4] 1794 	ld	a,c
   0A20 B7            [ 4] 1795 	or	a, a
   0A21 20 1D         [12] 1796 	jr	NZ,00110$
                           1797 ;src/Enemy.c:474: d=((e->direction+4)&7);
   0A23 1A            [ 7] 1798 	ld	a,(de)
   0A24 C6 04         [ 7] 1799 	add	a, #0x04
   0A26 E6 07         [ 7] 1800 	and	a, #0x07
   0A28 47            [ 4] 1801 	ld	b,a
                           1802 ;src/Enemy.c:476: if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
   0A29 C5            [11] 1803 	push	bc
   0A2A C5            [11] 1804 	push	bc
   0A2B 33            [ 6] 1805 	inc	sp
   0A2C DD 6E FC      [19] 1806 	ld	l,-4 (ix)
   0A2F DD 66 FD      [19] 1807 	ld	h,-3 (ix)
   0A32 E5            [11] 1808 	push	hl
   0A33 CD 4B 04      [17] 1809 	call	_enemy_collision_at_dir
   0A36 F1            [10] 1810 	pop	af
   0A37 33            [ 6] 1811 	inc	sp
   0A38 C1            [10] 1812 	pop	bc
   0A39 7D            [ 4] 1813 	ld	a,l
   0A3A B7            [ 4] 1814 	or	a, a
   0A3B 20 1F         [12] 1815 	jr	NZ,00111$
                           1816 ;src/Enemy.c:478: ++nd;
   0A3D 0C            [ 4] 1817 	inc	c
   0A3E 18 1C         [12] 1818 	jr	00111$
   0A40                    1819 00110$:
                           1820 ;src/Enemy.c:483: d=directions[cpct_getRandom_mxor_u8()%(nd)];
   0A40 21 00 00      [10] 1821 	ld	hl,#0x0000
   0A43 39            [11] 1822 	add	hl,sp
   0A44 E5            [11] 1823 	push	hl
   0A45 C5            [11] 1824 	push	bc
   0A46 CD 97 7A      [17] 1825 	call	_cpct_getRandom_mxor_u8
   0A49 55            [ 4] 1826 	ld	d,l
   0A4A C1            [10] 1827 	pop	bc
   0A4B C5            [11] 1828 	push	bc
   0A4C 79            [ 4] 1829 	ld	a,c
   0A4D F5            [11] 1830 	push	af
   0A4E 33            [ 6] 1831 	inc	sp
   0A4F D5            [11] 1832 	push	de
   0A50 33            [ 6] 1833 	inc	sp
   0A51 CD 39 7A      [17] 1834 	call	__moduchar
   0A54 F1            [10] 1835 	pop	af
   0A55 5D            [ 4] 1836 	ld	e,l
   0A56 C1            [10] 1837 	pop	bc
   0A57 E1            [10] 1838 	pop	hl
   0A58 16 00         [ 7] 1839 	ld	d,#0x00
   0A5A 19            [11] 1840 	add	hl,de
   0A5B 46            [ 7] 1841 	ld	b,(hl)
   0A5C                    1842 00111$:
                           1843 ;src/Enemy.c:486: if(nd){//If can move
   0A5C 79            [ 4] 1844 	ld	a,c
   0A5D B7            [ 4] 1845 	or	a, a
   0A5E 28 0E         [12] 1846 	jr	Z,00114$
                           1847 ;src/Enemy.c:487: enemy_move(e, d);
   0A60 C5            [11] 1848 	push	bc
   0A61 33            [ 6] 1849 	inc	sp
   0A62 DD 6E FE      [19] 1850 	ld	l,-2 (ix)
   0A65 DD 66 FF      [19] 1851 	ld	h,-1 (ix)
   0A68 E5            [11] 1852 	push	hl
   0A69 CD 98 05      [17] 1853 	call	_enemy_move
   0A6C F1            [10] 1854 	pop	af
   0A6D 33            [ 6] 1855 	inc	sp
   0A6E                    1856 00114$:
   0A6E DD F9         [10] 1857 	ld	sp, ix
   0A70 DD E1         [14] 1858 	pop	ix
   0A72 C9            [10] 1859 	ret
                           1860 ;src/Enemy.c:491: void enemy_AI_passive(Enemy* e) {
                           1861 ;	---------------------------------
                           1862 ; Function enemy_AI_passive
                           1863 ; ---------------------------------
   0A73                    1864 _enemy_AI_passive::
   0A73 DD E5         [15] 1865 	push	ix
   0A75 DD 21 00 00   [14] 1866 	ld	ix,#0
   0A79 DD 39         [15] 1867 	add	ix,sp
   0A7B F5            [11] 1868 	push	af
   0A7C 3B            [ 6] 1869 	dec	sp
                           1870 ;src/Enemy.c:494: x = e->position.x;
   0A7D DD 4E 04      [19] 1871 	ld	c,4 (ix)
   0A80 DD 46 05      [19] 1872 	ld	b,5 (ix)
   0A83 C5            [11] 1873 	push	bc
   0A84 FD E1         [14] 1874 	pop	iy
   0A86 FD 7E 03      [19] 1875 	ld	a,3 (iy)
   0A89 DD 77 FE      [19] 1876 	ld	-2 (ix),a
                           1877 ;src/Enemy.c:495: y = e->position.y;
   0A8C 69            [ 4] 1878 	ld	l, c
   0A8D 60            [ 4] 1879 	ld	h, b
   0A8E 11 04 00      [10] 1880 	ld	de, #0x0004
   0A91 19            [11] 1881 	add	hl, de
   0A92 5E            [ 7] 1882 	ld	e,(hl)
                           1883 ;src/Enemy.c:497: hp=e->hitPoints;
   0A93 C5            [11] 1884 	push	bc
   0A94 FD E1         [14] 1885 	pop	iy
   0A96 FD 7E 05      [19] 1886 	ld	a,5 (iy)
   0A99 DD 77 FD      [19] 1887 	ld	-3 (ix),a
                           1888 ;src/Enemy.c:499: if(dist(player_position.x, player_position.y, x,y)<ENEMY_VIEW_DISTANCE){
   0A9C 21 76 18      [10] 1889 	ld	hl, #_player_position + 1
   0A9F 56            [ 7] 1890 	ld	d,(hl)
   0AA0 3A 75 18      [13] 1891 	ld	a,(#_player_position + 0)
   0AA3 DD 77 FF      [19] 1892 	ld	-1 (ix),a
   0AA6 C5            [11] 1893 	push	bc
   0AA7 7B            [ 4] 1894 	ld	a,e
   0AA8 F5            [11] 1895 	push	af
   0AA9 33            [ 6] 1896 	inc	sp
   0AAA DD 7E FE      [19] 1897 	ld	a,-2 (ix)
   0AAD F5            [11] 1898 	push	af
   0AAE 33            [ 6] 1899 	inc	sp
   0AAF D5            [11] 1900 	push	de
   0AB0 33            [ 6] 1901 	inc	sp
   0AB1 DD 7E FF      [19] 1902 	ld	a,-1 (ix)
   0AB4 F5            [11] 1903 	push	af
   0AB5 33            [ 6] 1904 	inc	sp
   0AB6 CD CD 00      [17] 1905 	call	_dist
   0AB9 F1            [10] 1906 	pop	af
   0ABA F1            [10] 1907 	pop	af
   0ABB C1            [10] 1908 	pop	bc
   0ABC 7D            [ 4] 1909 	ld	a,l
   0ABD D6 06         [ 7] 1910 	sub	a, #0x06
   0ABF 30 39         [12] 1911 	jr	NC,00112$
                           1912 ;src/Enemy.c:500: if(enemy_can_view(e)){
   0AC1 C5            [11] 1913 	push	bc
   0AC2 C5            [11] 1914 	push	bc
   0AC3 CD FC 00      [17] 1915 	call	_enemy_can_view
   0AC6 F1            [10] 1916 	pop	af
   0AC7 C1            [10] 1917 	pop	bc
   0AC8 7D            [ 4] 1918 	ld	a,l
   0AC9 B7            [ 4] 1919 	or	a, a
   0ACA 28 2E         [12] 1920 	jr	Z,00112$
                           1921 ;src/Enemy.c:501: if(hp < ENEMY_INITIAL_HP){//Aggresive
   0ACC DD 7E FD      [19] 1922 	ld	a,-3 (ix)
   0ACF D6 FF         [ 7] 1923 	sub	a, #0xFF
   0AD1 30 19         [12] 1924 	jr	NC,00107$
                           1925 ;src/Enemy.c:502: if(enemy_is_adjacent_to_player(e)){//Attack
   0AD3 C5            [11] 1926 	push	bc
   0AD4 C5            [11] 1927 	push	bc
   0AD5 CD AA 02      [17] 1928 	call	_enemy_is_adjacent_to_player
   0AD8 F1            [10] 1929 	pop	af
   0AD9 C1            [10] 1930 	pop	bc
   0ADA 7D            [ 4] 1931 	ld	a,l
   0ADB B7            [ 4] 1932 	or	a, a
   0ADC 28 07         [12] 1933 	jr	Z,00102$
                           1934 ;src/Enemy.c:503: enemy_attack(e);
   0ADE C5            [11] 1935 	push	bc
   0ADF CD F5 06      [17] 1936 	call	_enemy_attack
   0AE2 F1            [10] 1937 	pop	af
                           1938 ;src/Enemy.c:504: return;
   0AE3 18 1A         [12] 1939 	jr	00113$
   0AE5                    1940 00102$:
                           1941 ;src/Enemy.c:507: enemy_go_to_player(e);
   0AE5 C5            [11] 1942 	push	bc
   0AE6 CD 7A 07      [17] 1943 	call	_enemy_go_to_player
   0AE9 F1            [10] 1944 	pop	af
                           1945 ;src/Enemy.c:508: return;
   0AEA 18 13         [12] 1946 	jr	00113$
   0AEC                    1947 00107$:
                           1948 ;src/Enemy.c:511: else if(hp < ENEMY_INITIAL_HP/4){ //Flee
   0AEC DD 7E FD      [19] 1949 	ld	a,-3 (ix)
   0AEF D6 3F         [ 7] 1950 	sub	a, #0x3F
   0AF1 30 07         [12] 1951 	jr	NC,00112$
                           1952 ;src/Enemy.c:512: enemy_flee(e);
   0AF3 C5            [11] 1953 	push	bc
   0AF4 CD 56 08      [17] 1954 	call	_enemy_flee
   0AF7 F1            [10] 1955 	pop	af
                           1956 ;src/Enemy.c:513: return;
   0AF8 18 05         [12] 1957 	jr	00113$
   0AFA                    1958 00112$:
                           1959 ;src/Enemy.c:517: enemy_roam(e);   
   0AFA C5            [11] 1960 	push	bc
   0AFB CD 7B 09      [17] 1961 	call	_enemy_roam
   0AFE F1            [10] 1962 	pop	af
   0AFF                    1963 00113$:
   0AFF DD F9         [10] 1964 	ld	sp, ix
   0B01 DD E1         [14] 1965 	pop	ix
   0B03 C9            [10] 1966 	ret
                           1967 ;src/Enemy.c:520: void enemy_AI_aggressive(Enemy* e){
                           1968 ;	---------------------------------
                           1969 ; Function enemy_AI_aggressive
                           1970 ; ---------------------------------
   0B04                    1971 _enemy_AI_aggressive::
   0B04 DD E5         [15] 1972 	push	ix
   0B06 DD 21 00 00   [14] 1973 	ld	ix,#0
   0B0A DD 39         [15] 1974 	add	ix,sp
   0B0C F5            [11] 1975 	push	af
                           1976 ;src/Enemy.c:523: x = e->position.x;
   0B0D DD 4E 04      [19] 1977 	ld	c,4 (ix)
   0B10 DD 46 05      [19] 1978 	ld	b,5 (ix)
   0B13 C5            [11] 1979 	push	bc
   0B14 FD E1         [14] 1980 	pop	iy
   0B16 FD 7E 03      [19] 1981 	ld	a,3 (iy)
   0B19 DD 77 FF      [19] 1982 	ld	-1 (ix),a
                           1983 ;src/Enemy.c:524: y = e->position.y;
   0B1C C5            [11] 1984 	push	bc
   0B1D FD E1         [14] 1985 	pop	iy
   0B1F FD 7E 04      [19] 1986 	ld	a,4 (iy)
   0B22 DD 77 FE      [19] 1987 	ld	-2 (ix),a
                           1988 ;src/Enemy.c:526: if(dist(player_position.x, player_position.y, x,y)<ENEMY_VIEW_DISTANCE){
   0B25 21 76 18      [10] 1989 	ld	hl, #_player_position + 1
   0B28 56            [ 7] 1990 	ld	d,(hl)
   0B29 21 75 18      [10] 1991 	ld	hl, #_player_position + 0
   0B2C 5E            [ 7] 1992 	ld	e,(hl)
   0B2D C5            [11] 1993 	push	bc
   0B2E DD 66 FE      [19] 1994 	ld	h,-2 (ix)
   0B31 DD 6E FF      [19] 1995 	ld	l,-1 (ix)
   0B34 E5            [11] 1996 	push	hl
   0B35 D5            [11] 1997 	push	de
   0B36 CD CD 00      [17] 1998 	call	_dist
   0B39 F1            [10] 1999 	pop	af
   0B3A F1            [10] 2000 	pop	af
   0B3B C1            [10] 2001 	pop	bc
   0B3C 7D            [ 4] 2002 	ld	a,l
   0B3D D6 06         [ 7] 2003 	sub	a, #0x06
   0B3F 30 24         [12] 2004 	jr	NC,00107$
                           2005 ;src/Enemy.c:527: if(enemy_can_view(e)){
   0B41 C5            [11] 2006 	push	bc
   0B42 C5            [11] 2007 	push	bc
   0B43 CD FC 00      [17] 2008 	call	_enemy_can_view
   0B46 F1            [10] 2009 	pop	af
   0B47 C1            [10] 2010 	pop	bc
   0B48 7D            [ 4] 2011 	ld	a,l
   0B49 B7            [ 4] 2012 	or	a, a
   0B4A 28 19         [12] 2013 	jr	Z,00107$
                           2014 ;src/Enemy.c:528: if(enemy_is_adjacent_to_player(e)){//Attack
   0B4C C5            [11] 2015 	push	bc
   0B4D C5            [11] 2016 	push	bc
   0B4E CD AA 02      [17] 2017 	call	_enemy_is_adjacent_to_player
   0B51 F1            [10] 2018 	pop	af
   0B52 C1            [10] 2019 	pop	bc
   0B53 7D            [ 4] 2020 	ld	a,l
   0B54 B7            [ 4] 2021 	or	a, a
   0B55 28 07         [12] 2022 	jr	Z,00102$
                           2023 ;src/Enemy.c:529: enemy_attack(e);
   0B57 C5            [11] 2024 	push	bc
   0B58 CD F5 06      [17] 2025 	call	_enemy_attack
   0B5B F1            [10] 2026 	pop	af
                           2027 ;src/Enemy.c:530: return;
   0B5C 18 0C         [12] 2028 	jr	00108$
   0B5E                    2029 00102$:
                           2030 ;src/Enemy.c:533: enemy_go_to_player(e);
   0B5E C5            [11] 2031 	push	bc
   0B5F CD 7A 07      [17] 2032 	call	_enemy_go_to_player
   0B62 F1            [10] 2033 	pop	af
                           2034 ;src/Enemy.c:534: return;
   0B63 18 05         [12] 2035 	jr	00108$
   0B65                    2036 00107$:
                           2037 ;src/Enemy.c:538: enemy_roam(e);     
   0B65 C5            [11] 2038 	push	bc
   0B66 CD 7B 09      [17] 2039 	call	_enemy_roam
   0B69 F1            [10] 2040 	pop	af
   0B6A                    2041 00108$:
   0B6A DD F9         [10] 2042 	ld	sp, ix
   0B6C DD E1         [14] 2043 	pop	ix
   0B6E C9            [10] 2044 	ret
                           2045 ;src/Enemy.c:585: void enemy_update(){
                           2046 ;	---------------------------------
                           2047 ; Function enemy_update
                           2048 ; ---------------------------------
   0B6F                    2049 _enemy_update::
                           2050 ;src/Enemy.c:587: Enemy* enemy=enemyArray;
   0B6F 01 E6 7C      [10] 2051 	ld	bc,#_enemyArray+0
                           2052 ;src/Enemy.c:589: for(i;i;--i){
   0B72 1E 0F         [ 7] 2053 	ld	e,#0x0F
   0B74                    2054 00108$:
   0B74 7B            [ 4] 2055 	ld	a,e
   0B75 B7            [ 4] 2056 	or	a, a
   0B76 C8            [11] 2057 	ret	Z
                           2058 ;src/Enemy.c:590: if(enemy->hitPoints){
   0B77 C5            [11] 2059 	push	bc
   0B78 FD E1         [14] 2060 	pop	iy
   0B7A FD 7E 05      [19] 2061 	ld	a,5 (iy)
   0B7D B7            [ 4] 2062 	or	a, a
   0B7E 28 21         [12] 2063 	jr	Z,00105$
                           2064 ;src/Enemy.c:591: switch(enemy->type){
   0B80 69            [ 4] 2065 	ld	l, c
   0B81 60            [ 4] 2066 	ld	h, b
   0B82 23            [ 6] 2067 	inc	hl
   0B83 56            [ 7] 2068 	ld	d,(hl)
   0B84 7A            [ 4] 2069 	ld	a,d
   0B85 B7            [ 4] 2070 	or	a, a
   0B86 28 05         [12] 2071 	jr	Z,00101$
   0B88 15            [ 4] 2072 	dec	d
   0B89 28 0D         [12] 2073 	jr	Z,00102$
   0B8B 18 14         [12] 2074 	jr	00105$
                           2075 ;src/Enemy.c:592: case 0:{
   0B8D                    2076 00101$:
                           2077 ;src/Enemy.c:593: enemy_AI_passive(enemy);
   0B8D C5            [11] 2078 	push	bc
   0B8E D5            [11] 2079 	push	de
   0B8F C5            [11] 2080 	push	bc
   0B90 CD 73 0A      [17] 2081 	call	_enemy_AI_passive
   0B93 F1            [10] 2082 	pop	af
   0B94 D1            [10] 2083 	pop	de
   0B95 C1            [10] 2084 	pop	bc
                           2085 ;src/Enemy.c:594: break;
   0B96 18 09         [12] 2086 	jr	00105$
                           2087 ;src/Enemy.c:596: case 1:{
   0B98                    2088 00102$:
                           2089 ;src/Enemy.c:597: enemy_AI_aggressive(enemy);
   0B98 C5            [11] 2090 	push	bc
   0B99 D5            [11] 2091 	push	de
   0B9A C5            [11] 2092 	push	bc
   0B9B CD 04 0B      [17] 2093 	call	_enemy_AI_aggressive
   0B9E F1            [10] 2094 	pop	af
   0B9F D1            [10] 2095 	pop	de
   0BA0 C1            [10] 2096 	pop	bc
                           2097 ;src/Enemy.c:608: }
   0BA1                    2098 00105$:
                           2099 ;src/Enemy.c:610: ++enemy;
   0BA1 21 08 00      [10] 2100 	ld	hl,#0x0008
   0BA4 09            [11] 2101 	add	hl,bc
   0BA5 4D            [ 4] 2102 	ld	c,l
   0BA6 44            [ 4] 2103 	ld	b,h
                           2104 ;src/Enemy.c:589: for(i;i;--i){
   0BA7 1D            [ 4] 2105 	dec	e
   0BA8 18 CA         [12] 2106 	jr	00108$
                           2107 	.area _CODE
                           2108 	.area _INITIALIZER
                           2109 	.area _CABS (ABS)
