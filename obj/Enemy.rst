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
                             11 	.globl _enemy_AI_shy
                             12 	.globl _enemy_AI_tactical
                             13 	.globl _enemy_AI_aggressive
                             14 	.globl _enemy_AI_passive
                             15 	.globl _enemy_roam
                             16 	.globl _enemy_new_enemy
                             17 	.globl _enemy_can_view
                             18 	.globl _dist
                             19 	.globl _abs
                             20 	.globl _ui_log_add_log
                             21 	.globl _integer_to_string
                             22 	.globl _cpct_getRandom_mxor_u8
                             23 	.globl _cpct_memset
                             24 	.globl _enemyArray
                             25 	.globl _activeEnemies
                             26 	.globl _enemy_get_at
                             27 	.globl _enemy_init_enemies
                             28 	.globl _enemy_try_new_spawn
                             29 	.globl _enemy_update
                             30 ;--------------------------------------------------------
                             31 ; special function registers
                             32 ;--------------------------------------------------------
                             33 ;--------------------------------------------------------
                             34 ; ram data
                             35 ;--------------------------------------------------------
                             36 	.area _DATA
   5A8F                      37 _activeEnemies::
   5A8F                      38 	.ds 1
   5A90                      39 _enemyArray::
   5A90                      40 	.ds 150
                             41 ;--------------------------------------------------------
                             42 ; ram data
                             43 ;--------------------------------------------------------
                             44 	.area _INITIALIZED
                             45 ;--------------------------------------------------------
                             46 ; absolute external ram data
                             47 ;--------------------------------------------------------
                             48 	.area _DABS (ABS)
                             49 ;--------------------------------------------------------
                             50 ; global & static initialisations
                             51 ;--------------------------------------------------------
                             52 	.area _HOME
                             53 	.area _GSINIT
                             54 	.area _GSFINAL
                             55 	.area _GSINIT
                             56 ;--------------------------------------------------------
                             57 ; Home
                             58 ;--------------------------------------------------------
                             59 	.area _HOME
                             60 	.area _HOME
                             61 ;--------------------------------------------------------
                             62 ; code
                             63 ;--------------------------------------------------------
                             64 	.area _CODE
                             65 ;src/Enemy.c:28: Enemy* const enemy_get_at(u8 index) __z88dk_fastcall{
                             66 ;	---------------------------------
                             67 ; Function enemy_get_at
                             68 ; ---------------------------------
   0040                      69 _enemy_get_at::
   0040 5D            [ 4]   70 	ld	e,l
                             71 ;src/Enemy.c:29: return (enemyArray+index);
   0041 01 90 5A      [10]   72 	ld	bc,#_enemyArray+0
   0044 16 00         [ 7]   73 	ld	d,#0x00
   0046 6B            [ 4]   74 	ld	l, e
   0047 62            [ 4]   75 	ld	h, d
   0048 29            [11]   76 	add	hl, hl
   0049 29            [11]   77 	add	hl, hl
   004A 19            [11]   78 	add	hl, de
   004B 29            [11]   79 	add	hl, hl
   004C 09            [11]   80 	add	hl,bc
   004D C9            [10]   81 	ret
                             82 ;src/Enemy.c:32: void enemy_init_enemies(){
                             83 ;	---------------------------------
                             84 ; Function enemy_init_enemies
                             85 ; ---------------------------------
   004E                      86 _enemy_init_enemies::
                             87 ;src/Enemy.c:34: cpct_memset(enemyArray, 0, ENEMY_MAX_ENEMIES*sizeof(Enemy));
   004E 21 96 00      [10]   88 	ld	hl,#0x0096
   0051 E5            [11]   89 	push	hl
   0052 AF            [ 4]   90 	xor	a, a
   0053 F5            [11]   91 	push	af
   0054 33            [ 6]   92 	inc	sp
   0055 21 90 5A      [10]   93 	ld	hl,#_enemyArray
   0058 E5            [11]   94 	push	hl
   0059 CD 44 59      [17]   95 	call	_cpct_memset
                             96 ;src/Enemy.c:35: activeEnemies=0;
   005C 21 8F 5A      [10]   97 	ld	hl,#_activeEnemies + 0
   005F 36 00         [10]   98 	ld	(hl), #0x00
                             99 ;src/Enemy.c:37: while(activeEnemies<ENEMY_MAX_ENEMIES){
   0061                     100 00101$:
   0061 3A 8F 5A      [13]  101 	ld	a,(#_activeEnemies + 0)
   0064 D6 0F         [ 7]  102 	sub	a, #0x0F
   0066 D0            [11]  103 	ret	NC
                            104 ;src/Enemy.c:38: enemy_try_new_spawn();
   0067 CD CB 02      [17]  105 	call	_enemy_try_new_spawn
   006A 18 F5         [12]  106 	jr	00101$
                            107 ;src/Enemy.c:44: i8 abs(i8 n) __z88dk_fastcall{
                            108 ;	---------------------------------
                            109 ; Function abs
                            110 ; ---------------------------------
   006C                     111 _abs::
                            112 ;src/Enemy.c:45: if(n<0) n=-n;
   006C CB 7D         [ 8]  113 	bit	7, l
   006E C8            [11]  114 	ret	Z
   006F AF            [ 4]  115 	xor	a, a
   0070 95            [ 4]  116 	sub	a, l
   0071 6F            [ 4]  117 	ld	l,a
                            118 ;src/Enemy.c:46: return n;
   0072 C9            [10]  119 	ret
                            120 ;src/Enemy.c:49: u8 dist(u8 x0, u8 y0, u8 x1, u8 y1){
                            121 ;	---------------------------------
                            122 ; Function dist
                            123 ; ---------------------------------
   0073                     124 _dist::
   0073 DD E5         [15]  125 	push	ix
   0075 DD 21 00 00   [14]  126 	ld	ix,#0
   0079 DD 39         [15]  127 	add	ix,sp
   007B F5            [11]  128 	push	af
   007C F5            [11]  129 	push	af
                            130 ;src/Enemy.c:51: dx = abs(x1-x0);
   007D DD 7E 06      [19]  131 	ld	a,6 (ix)
   0080 DD 96 04      [19]  132 	sub	a, 4 (ix)
   0083 6F            [ 4]  133 	ld	l,a
   0084 CD 6C 00      [17]  134 	call	_abs
   0087 4D            [ 4]  135 	ld	c,l
                            136 ;src/Enemy.c:52: dy = abs(y1-y0);
   0088 DD 7E 07      [19]  137 	ld	a,7 (ix)
   008B DD 96 05      [19]  138 	sub	a, 5 (ix)
   008E 6F            [ 4]  139 	ld	l,a
   008F C5            [11]  140 	push	bc
   0090 CD 6C 00      [17]  141 	call	_abs
   0093 C1            [10]  142 	pop	bc
                            143 ;src/Enemy.c:54: if(dx>dy) return ((2*dx)+dy)/2;
   0094 DD 71 FC      [19]  144 	ld	-4 (ix),c
   0097 79            [ 4]  145 	ld	a,c
   0098 17            [ 4]  146 	rla
   0099 9F            [ 4]  147 	sbc	a, a
   009A DD 77 FD      [19]  148 	ld	-3 (ix),a
   009D DD 75 FE      [19]  149 	ld	-2 (ix),l
   00A0 7D            [ 4]  150 	ld	a,l
   00A1 17            [ 4]  151 	rla
   00A2 9F            [ 4]  152 	sbc	a, a
   00A3 DD 77 FF      [19]  153 	ld	-1 (ix),a
   00A6 7D            [ 4]  154 	ld	a,l
   00A7 91            [ 4]  155 	sub	a, c
   00A8 E2 AD 00      [10]  156 	jp	PO, 00120$
   00AB EE 80         [ 7]  157 	xor	a, #0x80
   00AD                     158 00120$:
   00AD F2 C9 00      [10]  159 	jp	P,00102$
   00B0 E1            [10]  160 	pop	hl
   00B1 E5            [11]  161 	push	hl
   00B2 29            [11]  162 	add	hl, hl
   00B3 DD 5E FE      [19]  163 	ld	e,-2 (ix)
   00B6 DD 56 FF      [19]  164 	ld	d,-1 (ix)
   00B9 19            [11]  165 	add	hl,de
   00BA 5D            [ 4]  166 	ld	e, l
   00BB 54            [ 4]  167 	ld	d, h
   00BC CB 7C         [ 8]  168 	bit	7, h
   00BE 28 02         [12]  169 	jr	Z,00106$
   00C0 EB            [ 4]  170 	ex	de,hl
   00C1 13            [ 6]  171 	inc	de
   00C2                     172 00106$:
   00C2 CB 2A         [ 8]  173 	sra	d
   00C4 CB 1B         [ 8]  174 	rr	e
   00C6 6B            [ 4]  175 	ld	l,e
   00C7 18 16         [12]  176 	jr	00104$
   00C9                     177 00102$:
                            178 ;src/Enemy.c:55: else return ((2*dy)+dx)/2;
   00C9 C1            [10]  179 	pop	bc
   00CA E1            [10]  180 	pop	hl
   00CB E5            [11]  181 	push	hl
   00CC C5            [11]  182 	push	bc
   00CD 29            [11]  183 	add	hl, hl
   00CE D1            [10]  184 	pop	de
   00CF D5            [11]  185 	push	de
   00D0 19            [11]  186 	add	hl,de
   00D1 4D            [ 4]  187 	ld	c, l
   00D2 44            [ 4]  188 	ld	b, h
   00D3 CB 7C         [ 8]  189 	bit	7, h
   00D5 28 03         [12]  190 	jr	Z,00107$
   00D7 23            [ 6]  191 	inc	hl
   00D8 4D            [ 4]  192 	ld	c,l
   00D9 44            [ 4]  193 	ld	b,h
   00DA                     194 00107$:
   00DA CB 28         [ 8]  195 	sra	b
   00DC CB 19         [ 8]  196 	rr	c
   00DE 69            [ 4]  197 	ld	l,c
   00DF                     198 00104$:
   00DF DD F9         [10]  199 	ld	sp, ix
   00E1 DD E1         [14]  200 	pop	ix
   00E3 C9            [10]  201 	ret
                            202 ;src/Enemy.c:59: u8 enemy_can_view(u8 x0, u8 y0, u8 x1, u8 y1){
                            203 ;	---------------------------------
                            204 ; Function enemy_can_view
                            205 ; ---------------------------------
   00E4                     206 _enemy_can_view::
   00E4 DD E5         [15]  207 	push	ix
   00E6 DD 21 00 00   [14]  208 	ld	ix,#0
   00EA DD 39         [15]  209 	add	ix,sp
   00EC 21 F7 FF      [10]  210 	ld	hl,#-9
   00EF 39            [11]  211 	add	hl,sp
   00F0 F9            [ 6]  212 	ld	sp,hl
                            213 ;src/Enemy.c:63: dx = abs(x1-x0);
   00F1 DD 7E 06      [19]  214 	ld	a,6 (ix)
   00F4 DD 96 04      [19]  215 	sub	a, 4 (ix)
   00F7 6F            [ 4]  216 	ld	l,a
   00F8 CD 6C 00      [17]  217 	call	_abs
   00FB DD 75 F7      [19]  218 	ld	-9 (ix),l
                            219 ;src/Enemy.c:64: dy = abs(y1-y0);
   00FE DD 7E 07      [19]  220 	ld	a,7 (ix)
   0101 DD 96 05      [19]  221 	sub	a, 5 (ix)
   0104 6F            [ 4]  222 	ld	l,a
   0105 CD 6C 00      [17]  223 	call	_abs
   0108 DD 75 F9      [19]  224 	ld	-7 (ix),l
                            225 ;src/Enemy.c:66: sx = (x0<x1)?1:-1;
   010B DD 7E 04      [19]  226 	ld	a,4 (ix)
   010E DD 96 06      [19]  227 	sub	a, 6 (ix)
   0111 30 04         [12]  228 	jr	NC,00117$
   0113 0E 01         [ 7]  229 	ld	c,#0x01
   0115 18 02         [12]  230 	jr	00118$
   0117                     231 00117$:
   0117 0E FF         [ 7]  232 	ld	c,#0xFF
   0119                     233 00118$:
                            234 ;src/Enemy.c:67: sy = (y0<y1)?1:-1;
   0119 DD 7E 05      [19]  235 	ld	a,5 (ix)
   011C DD 96 07      [19]  236 	sub	a, 7 (ix)
   011F 30 04         [12]  237 	jr	NC,00119$
   0121 1E 01         [ 7]  238 	ld	e,#0x01
   0123 18 02         [12]  239 	jr	00120$
   0125                     240 00119$:
   0125 1E FF         [ 7]  241 	ld	e,#0xFF
   0127                     242 00120$:
   0127 DD 73 F8      [19]  243 	ld	-8 (ix),e
                            244 ;src/Enemy.c:69: e1 = ((dx>dy)?dx:-dy)/2;
   012A DD 7E F7      [19]  245 	ld	a,-9 (ix)
   012D DD 77 FC      [19]  246 	ld	-4 (ix),a
   0130 DD 7E F7      [19]  247 	ld	a,-9 (ix)
   0133 17            [ 4]  248 	rla
   0134 9F            [ 4]  249 	sbc	a, a
   0135 DD 77 FD      [19]  250 	ld	-3 (ix),a
   0138 DD 7E F9      [19]  251 	ld	a,-7 (ix)
   013B DD 96 F7      [19]  252 	sub	a, -9 (ix)
   013E E2 43 01      [10]  253 	jp	PO, 00168$
   0141 EE 80         [ 7]  254 	xor	a, #0x80
   0143                     255 00168$:
   0143 F2 4E 01      [10]  256 	jp	P,00121$
   0146 DD 6E FC      [19]  257 	ld	l,-4 (ix)
   0149 DD 66 FD      [19]  258 	ld	h,-3 (ix)
   014C 18 10         [12]  259 	jr	00122$
   014E                     260 00121$:
   014E DD 5E F9      [19]  261 	ld	e,-7 (ix)
   0151 DD 7E F9      [19]  262 	ld	a,-7 (ix)
   0154 17            [ 4]  263 	rla
   0155 9F            [ 4]  264 	sbc	a, a
   0156 47            [ 4]  265 	ld	b,a
   0157 AF            [ 4]  266 	xor	a, a
   0158 93            [ 4]  267 	sub	a, e
   0159 6F            [ 4]  268 	ld	l,a
   015A 3E 00         [ 7]  269 	ld	a, #0x00
   015C 98            [ 4]  270 	sbc	a, b
   015D 67            [ 4]  271 	ld	h,a
   015E                     272 00122$:
   015E 45            [ 4]  273 	ld	b,l
   015F 54            [ 4]  274 	ld	d,h
   0160 CB 7C         [ 8]  275 	bit	7, h
   0162 28 03         [12]  276 	jr	Z,00123$
   0164 23            [ 6]  277 	inc	hl
   0165 45            [ 4]  278 	ld	b,l
   0166 54            [ 4]  279 	ld	d,h
   0167                     280 00123$:
   0167 58            [ 4]  281 	ld	e, b
   0168 CB 2A         [ 8]  282 	sra	d
   016A CB 1B         [ 8]  283 	rr	e
                            284 ;src/Enemy.c:71: while(1){
   016C                     285 00113$:
                            286 ;src/Enemy.c:72: e2 = e1;
   016C 43            [ 4]  287 	ld	b,e
                            288 ;src/Enemy.c:73: if (e2 >-dx) {
   016D AF            [ 4]  289 	xor	a, a
   016E DD 96 FC      [19]  290 	sub	a, -4 (ix)
   0171 6F            [ 4]  291 	ld	l,a
   0172 3E 00         [ 7]  292 	ld	a, #0x00
   0174 DD 9E FD      [19]  293 	sbc	a, -3 (ix)
   0177 67            [ 4]  294 	ld	h,a
   0178 DD 73 FE      [19]  295 	ld	-2 (ix),e
   017B 7B            [ 4]  296 	ld	a,e
   017C 17            [ 4]  297 	rla
   017D 9F            [ 4]  298 	sbc	a, a
   017E DD 77 FF      [19]  299 	ld	-1 (ix),a
   0181 7D            [ 4]  300 	ld	a,l
   0182 DD 96 FE      [19]  301 	sub	a, -2 (ix)
   0185 7C            [ 4]  302 	ld	a,h
   0186 DD 9E FF      [19]  303 	sbc	a, -1 (ix)
   0189 E2 8E 01      [10]  304 	jp	PO, 00169$
   018C EE 80         [ 7]  305 	xor	a, #0x80
   018E                     306 00169$:
   018E F2 9D 01      [10]  307 	jp	P,00102$
                            308 ;src/Enemy.c:74: e1 -= dy;
   0191 7B            [ 4]  309 	ld	a,e
   0192 DD 96 F9      [19]  310 	sub	a, -7 (ix)
   0195 5F            [ 4]  311 	ld	e,a
                            312 ;src/Enemy.c:75: x0 += sx;
   0196 DD 6E 04      [19]  313 	ld	l,4 (ix)
   0199 09            [11]  314 	add	hl, bc
   019A DD 75 04      [19]  315 	ld	4 (ix),l
   019D                     316 00102$:
                            317 ;src/Enemy.c:77: if (e2 < dy) {
   019D 78            [ 4]  318 	ld	a,b
   019E DD 96 F9      [19]  319 	sub	a, -7 (ix)
   01A1 E2 A6 01      [10]  320 	jp	PO, 00170$
   01A4 EE 80         [ 7]  321 	xor	a, #0x80
   01A6                     322 00170$:
   01A6 F2 B7 01      [10]  323 	jp	P,00104$
                            324 ;src/Enemy.c:78: e1 += dx;
   01A9 7B            [ 4]  325 	ld	a,e
   01AA DD 86 F7      [19]  326 	add	a, -9 (ix)
   01AD 5F            [ 4]  327 	ld	e,a
                            328 ;src/Enemy.c:79: y0 += sy;
   01AE DD 7E 05      [19]  329 	ld	a, 5 (ix)
   01B1 DD 86 F8      [19]  330 	add	a, -8 (ix)
   01B4 DD 77 05      [19]  331 	ld	5 (ix),a
   01B7                     332 00104$:
                            333 ;src/Enemy.c:84: if((*(u8*)(MAP_MEM+(x0+(y0*MAP_WIDTH)))&CELL_WALL_MASK)||(
   01B7 DD 7E 04      [19]  334 	ld	a,4 (ix)
   01BA DD 77 FE      [19]  335 	ld	-2 (ix),a
   01BD DD 36 FF 00   [19]  336 	ld	-1 (ix),#0x00
   01C1 DD 46 05      [19]  337 	ld	b,5 (ix)
   01C4 16 00         [ 7]  338 	ld	d,#0x00
   01C6 DD 70 FA      [19]  339 	ld	-6 (ix),b
   01C9 DD 72 FB      [19]  340 	ld	-5 (ix),d
   01CC 3E 06         [ 7]  341 	ld	a,#0x05+1
   01CE 18 08         [12]  342 	jr	00172$
   01D0                     343 00171$:
   01D0 DD CB FA 26   [23]  344 	sla	-6 (ix)
   01D4 DD CB FB 16   [23]  345 	rl	-5 (ix)
   01D8                     346 00172$:
   01D8 3D            [ 4]  347 	dec	a
   01D9 20 F5         [12]  348 	jr	NZ,00171$
   01DB DD 7E FE      [19]  349 	ld	a,-2 (ix)
   01DE DD 86 FA      [19]  350 	add	a, -6 (ix)
   01E1 6F            [ 4]  351 	ld	l,a
   01E2 DD 7E FF      [19]  352 	ld	a,-1 (ix)
   01E5 DD 8E FB      [19]  353 	adc	a, -5 (ix)
   01E8 67            [ 4]  354 	ld	h,a
   01E9 D5            [11]  355 	push	de
   01EA 11 00 70      [10]  356 	ld	de,#0x7000
   01ED 19            [11]  357 	add	hl, de
   01EE D1            [10]  358 	pop	de
   01EF 66            [ 7]  359 	ld	h,(hl)
   01F0 29            [11]  360 	add	hl, hl
   01F1 38 4B         [12]  361 	jr	C,00105$
                            362 ;src/Enemy.c:85: (*(u8*)(MAP_MEM+((x0)+((y0-sy)*MAP_WIDTH)))&CELL_WALL_MASK)&&
   01F3 DD 6E F8      [19]  363 	ld	l,-8 (ix)
   01F6 DD 7E F8      [19]  364 	ld	a,-8 (ix)
   01F9 17            [ 4]  365 	rla
   01FA 9F            [ 4]  366 	sbc	a, a
   01FB 67            [ 4]  367 	ld	h,a
   01FC 78            [ 4]  368 	ld	a,b
   01FD 95            [ 4]  369 	sub	a, l
   01FE 6F            [ 4]  370 	ld	l,a
   01FF 7A            [ 4]  371 	ld	a,d
   0200 9C            [ 4]  372 	sbc	a, h
   0201 67            [ 4]  373 	ld	h,a
   0202 29            [11]  374 	add	hl, hl
   0203 29            [11]  375 	add	hl, hl
   0204 29            [11]  376 	add	hl, hl
   0205 29            [11]  377 	add	hl, hl
   0206 29            [11]  378 	add	hl, hl
   0207 DD 7E FE      [19]  379 	ld	a,-2 (ix)
   020A 85            [ 4]  380 	add	a, l
   020B 6F            [ 4]  381 	ld	l,a
   020C DD 7E FF      [19]  382 	ld	a,-1 (ix)
   020F 8C            [ 4]  383 	adc	a, h
   0210 67            [ 4]  384 	ld	h,a
   0211 D5            [11]  385 	push	de
   0212 11 00 70      [10]  386 	ld	de,#0x7000
   0215 19            [11]  387 	add	hl, de
   0216 D1            [10]  388 	pop	de
   0217 66            [ 7]  389 	ld	h,(hl)
   0218 29            [11]  390 	add	hl, hl
   0219 30 27         [12]  391 	jr	NC,00106$
                            392 ;src/Enemy.c:86: (*(u8*)(MAP_MEM+((x0-sx)+(y0*MAP_WIDTH)))&CELL_WALL_MASK)
   021B 79            [ 4]  393 	ld	a,c
   021C 47            [ 4]  394 	ld	b,a
   021D 17            [ 4]  395 	rla
   021E 9F            [ 4]  396 	sbc	a, a
   021F 57            [ 4]  397 	ld	d,a
   0220 DD 7E FE      [19]  398 	ld	a,-2 (ix)
   0223 90            [ 4]  399 	sub	a, b
   0224 6F            [ 4]  400 	ld	l,a
   0225 DD 7E FF      [19]  401 	ld	a,-1 (ix)
   0228 9A            [ 4]  402 	sbc	a, d
   0229 67            [ 4]  403 	ld	h,a
   022A DD 7E FA      [19]  404 	ld	a,-6 (ix)
   022D 85            [ 4]  405 	add	a, l
   022E 6F            [ 4]  406 	ld	l,a
   022F DD 7E FB      [19]  407 	ld	a,-5 (ix)
   0232 8C            [ 4]  408 	adc	a, h
   0233 67            [ 4]  409 	ld	h,a
   0234 D5            [11]  410 	push	de
   0235 11 00 70      [10]  411 	ld	de,#0x7000
   0238 19            [11]  412 	add	hl, de
   0239 D1            [10]  413 	pop	de
   023A 66            [ 7]  414 	ld	h,(hl)
   023B 29            [11]  415 	add	hl, hl
   023C 30 04         [12]  416 	jr	NC,00106$
   023E                     417 00105$:
                            418 ;src/Enemy.c:89: return 0;
   023E 2E 00         [ 7]  419 	ld	l,#0x00
   0240 18 14         [12]  420 	jr	00115$
   0242                     421 00106$:
                            422 ;src/Enemy.c:91: if ((x0==x1 && y0==y1)){
   0242 DD 7E 04      [19]  423 	ld	a,4 (ix)
   0245 DD 96 06      [19]  424 	sub	a, 6 (ix)
   0248 C2 6C 01      [10]  425 	jp	NZ,00113$
   024B DD 7E 05      [19]  426 	ld	a,5 (ix)
   024E DD 96 07      [19]  427 	sub	a, 7 (ix)
   0251 C2 6C 01      [10]  428 	jp	NZ,00113$
                            429 ;src/Enemy.c:96: return 1;
   0254 2E 01         [ 7]  430 	ld	l,#0x01
   0256                     431 00115$:
   0256 DD F9         [10]  432 	ld	sp, ix
   0258 DD E1         [14]  433 	pop	ix
   025A C9            [10]  434 	ret
                            435 ;src/Enemy.c:100: void enemy_new_enemy(Vec2u* position) __z88dk_fastcall{
                            436 ;	---------------------------------
                            437 ; Function enemy_new_enemy
                            438 ; ---------------------------------
   025B                     439 _enemy_new_enemy::
   025B DD E5         [15]  440 	push	ix
   025D DD 21 00 00   [14]  441 	ld	ix,#0
   0261 DD 39         [15]  442 	add	ix,sp
   0263 F5            [11]  443 	push	af
   0264 EB            [ 4]  444 	ex	de,hl
                            445 ;src/Enemy.c:102: Enemy* enemy=(enemyArray+ENEMY_MAX_ENEMIES);
   0265 01 26 5B      [10]  446 	ld	bc,#_enemyArray+150
                            447 ;src/Enemy.c:104: x=position->x;
   0268 1A            [ 7]  448 	ld	a,(de)
   0269 DD 77 FF      [19]  449 	ld	-1 (ix),a
                            450 ;src/Enemy.c:105: y=position->y;
   026C EB            [ 4]  451 	ex	de,hl
   026D 23            [ 6]  452 	inc	hl
   026E 7E            [ 7]  453 	ld	a,(hl)
   026F DD 77 FE      [19]  454 	ld	-2 (ix),a
                            455 ;src/Enemy.c:108: while(i){
   0272 1E 0F         [ 7]  456 	ld	e,#0x0F
   0274                     457 00103$:
   0274 7B            [ 4]  458 	ld	a,e
   0275 B7            [ 4]  459 	or	a, a
   0276 28 4E         [12]  460 	jr	Z,00106$
                            461 ;src/Enemy.c:109: --i;
   0278 1D            [ 4]  462 	dec	e
                            463 ;src/Enemy.c:110: --enemy;
   0279 79            [ 4]  464 	ld	a,c
   027A C6 F6         [ 7]  465 	add	a,#0xF6
   027C 4F            [ 4]  466 	ld	c,a
   027D 78            [ 4]  467 	ld	a,b
   027E CE FF         [ 7]  468 	adc	a,#0xFF
   0280 47            [ 4]  469 	ld	b,a
                            470 ;src/Enemy.c:111: if(enemy->hitPoints==0){//TODO
   0281 FD 21 05 00   [14]  471 	ld	iy,#0x0005
   0285 FD 09         [15]  472 	add	iy, bc
   0287 FD 7E 00      [19]  473 	ld	a, 0 (iy)
   028A B7            [ 4]  474 	or	a, a
   028B 20 E7         [12]  475 	jr	NZ,00103$
                            476 ;src/Enemy.c:112: enemy->id=i;
   028D 7B            [ 4]  477 	ld	a,e
   028E 02            [ 7]  478 	ld	(bc),a
                            479 ;src/Enemy.c:114: enemy->type=0;
   028F 69            [ 4]  480 	ld	l, c
   0290 60            [ 4]  481 	ld	h, b
   0291 23            [ 6]  482 	inc	hl
   0292 36 00         [10]  483 	ld	(hl),#0x00
                            484 ;src/Enemy.c:116: enemy->hitPoints=ENEMY_INITIAL_HP;
   0294 FD 36 00 FF   [19]  485 	ld	0 (iy), #0xFF
                            486 ;src/Enemy.c:119: enemy->direction=0;
   0298 69            [ 4]  487 	ld	l, c
   0299 60            [ 4]  488 	ld	h, b
   029A 23            [ 6]  489 	inc	hl
   029B 23            [ 6]  490 	inc	hl
   029C 36 00         [10]  491 	ld	(hl),#0x00
                            492 ;src/Enemy.c:121: enemy->position.x = x;
   029E 03            [ 6]  493 	inc	bc
   029F 03            [ 6]  494 	inc	bc
   02A0 03            [ 6]  495 	inc	bc
   02A1 DD 7E FF      [19]  496 	ld	a,-1 (ix)
   02A4 02            [ 7]  497 	ld	(bc),a
                            498 ;src/Enemy.c:122: enemy->position.y = y;
   02A5 03            [ 6]  499 	inc	bc
   02A6 DD 7E FE      [19]  500 	ld	a,-2 (ix)
   02A9 02            [ 7]  501 	ld	(bc),a
                            502 ;src/Enemy.c:124: *(u8*)(MAP_MEM+x+(y*MAP_WIDTH))=(i+1);
   02AA DD 4E FF      [19]  503 	ld	c,-1 (ix)
   02AD 06 00         [ 7]  504 	ld	b,#0x00
   02AF 21 00 70      [10]  505 	ld	hl,#0x7000
   02B2 09            [11]  506 	add	hl,bc
   02B3 4D            [ 4]  507 	ld	c,l
   02B4 44            [ 4]  508 	ld	b,h
   02B5 DD 6E FE      [19]  509 	ld	l,-2 (ix)
   02B8 26 00         [ 7]  510 	ld	h,#0x00
   02BA 29            [11]  511 	add	hl, hl
   02BB 29            [11]  512 	add	hl, hl
   02BC 29            [11]  513 	add	hl, hl
   02BD 29            [11]  514 	add	hl, hl
   02BE 29            [11]  515 	add	hl, hl
   02BF 09            [11]  516 	add	hl,bc
   02C0 1C            [ 4]  517 	inc	e
   02C1 73            [ 7]  518 	ld	(hl),e
                            519 ;src/Enemy.c:126: ++activeEnemies;
   02C2 21 8F 5A      [10]  520 	ld	hl, #_activeEnemies+0
   02C5 34            [11]  521 	inc	(hl)
                            522 ;src/Enemy.c:127: break;
   02C6                     523 00106$:
   02C6 DD F9         [10]  524 	ld	sp, ix
   02C8 DD E1         [14]  525 	pop	ix
   02CA C9            [10]  526 	ret
                            527 ;src/Enemy.c:134: u8 enemy_try_new_spawn(){
                            528 ;	---------------------------------
                            529 ; Function enemy_try_new_spawn
                            530 ; ---------------------------------
   02CB                     531 _enemy_try_new_spawn::
   02CB DD E5         [15]  532 	push	ix
   02CD DD 21 00 00   [14]  533 	ld	ix,#0
   02D1 DD 39         [15]  534 	add	ix,sp
   02D3 21 F9 FF      [10]  535 	ld	hl,#-7
   02D6 39            [11]  536 	add	hl,sp
   02D7 F9            [ 6]  537 	ld	sp,hl
                            538 ;src/Enemy.c:137: if(activeEnemies<ENEMY_MAX_ENEMIES){
   02D8 3A 8F 5A      [13]  539 	ld	a,(#_activeEnemies + 0)
   02DB D6 0F         [ 7]  540 	sub	a, #0x0F
   02DD 30 72         [12]  541 	jr	NC,00106$
                            542 ;src/Enemy.c:138: pos.x=cpct_getRandom_mxor_u8()%MAP_WIDTH;
   02DF 21 00 00      [10]  543 	ld	hl,#0x0000
   02E2 39            [11]  544 	add	hl,sp
   02E3 E5            [11]  545 	push	hl
   02E4 CD C2 58      [17]  546 	call	_cpct_getRandom_mxor_u8
   02E7 7D            [ 4]  547 	ld	a,l
   02E8 E1            [10]  548 	pop	hl
   02E9 E6 1F         [ 7]  549 	and	a, #0x1F
   02EB 77            [ 7]  550 	ld	(hl),a
                            551 ;src/Enemy.c:139: pos.y=cpct_getRandom_mxor_u8()%MAP_HEIGHT;
   02EC 21 00 00      [10]  552 	ld	hl,#0x0000
   02EF 39            [11]  553 	add	hl,sp
   02F0 DD 75 FD      [19]  554 	ld	-3 (ix),l
   02F3 DD 74 FE      [19]  555 	ld	-2 (ix),h
   02F6 23            [ 6]  556 	inc	hl
   02F7 E5            [11]  557 	push	hl
   02F8 CD C2 58      [17]  558 	call	_cpct_getRandom_mxor_u8
   02FB C1            [10]  559 	pop	bc
   02FC 7D            [ 4]  560 	ld	a,l
   02FD E6 1F         [ 7]  561 	and	a, #0x1F
   02FF DD 77 FC      [19]  562 	ld	-4 (ix), a
   0302 02            [ 7]  563 	ld	(bc),a
                            564 ;src/Enemy.c:141: if((*(u8*)(MAP_MEM+pos.x+(pos.y*MAP_WIDTH))&(CELL_WALL_MASK|CELL_ENEMY_MASK))==0){
   0303 DD 6E FD      [19]  565 	ld	l,-3 (ix)
   0306 DD 66 FE      [19]  566 	ld	h,-2 (ix)
   0309 7E            [ 7]  567 	ld	a,(hl)
   030A DD 77 FB      [19]  568 	ld	-5 (ix), a
   030D 5F            [ 4]  569 	ld	e, a
   030E 16 00         [ 7]  570 	ld	d,#0x00
   0310 21 00 70      [10]  571 	ld	hl,#0x7000
   0313 19            [11]  572 	add	hl,de
   0314 EB            [ 4]  573 	ex	de,hl
   0315 0A            [ 7]  574 	ld	a,(bc)
   0316 DD 77 FF      [19]  575 	ld	-1 (ix),a
   0319 DD 6E FC      [19]  576 	ld	l,-4 (ix)
   031C 26 00         [ 7]  577 	ld	h,#0x00
   031E 29            [11]  578 	add	hl, hl
   031F 29            [11]  579 	add	hl, hl
   0320 29            [11]  580 	add	hl, hl
   0321 29            [11]  581 	add	hl, hl
   0322 29            [11]  582 	add	hl, hl
   0323 19            [11]  583 	add	hl,de
   0324 7E            [ 7]  584 	ld	a,(hl)
   0325 E6 8F         [ 7]  585 	and	a, #0x8F
   0327 20 28         [12]  586 	jr	NZ,00106$
                            587 ;src/Enemy.c:142: if(dist(player_position.x, player_position.y, pos.x, pos.y)>ENEMY_VIEW_DISTANCE){
   0329 21 5B 0E      [10]  588 	ld	hl, #_player_position + 1
   032C 4E            [ 7]  589 	ld	c,(hl)
   032D 21 5A 0E      [10]  590 	ld	hl, #_player_position + 0
   0330 5E            [ 7]  591 	ld	e,(hl)
   0331 DD 66 FF      [19]  592 	ld	h,-1 (ix)
   0334 DD 6E FB      [19]  593 	ld	l,-5 (ix)
   0337 E5            [11]  594 	push	hl
   0338 51            [ 4]  595 	ld	d, c
   0339 D5            [11]  596 	push	de
   033A CD 73 00      [17]  597 	call	_dist
   033D F1            [10]  598 	pop	af
   033E F1            [10]  599 	pop	af
   033F 3E 06         [ 7]  600 	ld	a,#0x06
   0341 95            [ 4]  601 	sub	a, l
   0342 30 0D         [12]  602 	jr	NC,00106$
                            603 ;src/Enemy.c:143: enemy_new_enemy(&pos);
   0344 DD 6E FD      [19]  604 	ld	l,-3 (ix)
   0347 DD 66 FE      [19]  605 	ld	h,-2 (ix)
   034A CD 5B 02      [17]  606 	call	_enemy_new_enemy
                            607 ;src/Enemy.c:144: return 1;
   034D 2E 01         [ 7]  608 	ld	l,#0x01
   034F 18 02         [12]  609 	jr	00107$
   0351                     610 00106$:
                            611 ;src/Enemy.c:148: return 0;
   0351 2E 00         [ 7]  612 	ld	l,#0x00
   0353                     613 00107$:
   0353 DD F9         [10]  614 	ld	sp, ix
   0355 DD E1         [14]  615 	pop	ix
   0357 C9            [10]  616 	ret
                            617 ;src/Enemy.c:151: void enemy_roam(Enemy* e) __z88dk_fastcall{
                            618 ;	---------------------------------
                            619 ; Function enemy_roam
                            620 ; ---------------------------------
   0358                     621 _enemy_roam::
   0358 DD E5         [15]  622 	push	ix
   035A DD 21 00 00   [14]  623 	ld	ix,#0
   035E DD 39         [15]  624 	add	ix,sp
   0360 21 ED FF      [10]  625 	ld	hl,#-19
   0363 39            [11]  626 	add	hl,sp
   0364 F9            [ 6]  627 	ld	sp,hl
   0365 DD 75 FE      [19]  628 	ld	-2 (ix),l
   0368 DD 74 FF      [19]  629 	ld	-1 (ix),h
                            630 ;src/Enemy.c:157: x=e->position.x;
   036B DD 7E FE      [19]  631 	ld	a,-2 (ix)
   036E C6 03         [ 7]  632 	add	a, #0x03
   0370 DD 77 F8      [19]  633 	ld	-8 (ix),a
   0373 DD 7E FF      [19]  634 	ld	a,-1 (ix)
   0376 CE 00         [ 7]  635 	adc	a, #0x00
   0378 DD 77 F9      [19]  636 	ld	-7 (ix),a
   037B DD 6E F8      [19]  637 	ld	l,-8 (ix)
   037E DD 66 F9      [19]  638 	ld	h,-7 (ix)
   0381 7E            [ 7]  639 	ld	a,(hl)
   0382 DD 77 FA      [19]  640 	ld	-6 (ix),a
                            641 ;src/Enemy.c:158: y=e->position.y;
   0385 DD 7E F8      [19]  642 	ld	a,-8 (ix)
   0388 C6 01         [ 7]  643 	add	a, #0x01
   038A DD 77 FB      [19]  644 	ld	-5 (ix),a
   038D DD 7E F9      [19]  645 	ld	a,-7 (ix)
   0390 CE 00         [ 7]  646 	adc	a, #0x00
   0392 DD 77 FC      [19]  647 	ld	-4 (ix),a
   0395 DD 6E FB      [19]  648 	ld	l,-5 (ix)
   0398 DD 66 FC      [19]  649 	ld	h,-4 (ix)
   039B 7E            [ 7]  650 	ld	a,(hl)
   039C DD 77 FD      [19]  651 	ld	-3 (ix),a
                            652 ;src/Enemy.c:160: d=e->direction;
   039F DD 7E FE      [19]  653 	ld	a,-2 (ix)
   03A2 C6 02         [ 7]  654 	add	a, #0x02
   03A4 DD 77 F5      [19]  655 	ld	-11 (ix),a
   03A7 DD 7E FF      [19]  656 	ld	a,-1 (ix)
   03AA CE 00         [ 7]  657 	adc	a, #0x00
   03AC DD 77 F6      [19]  658 	ld	-10 (ix),a
   03AF DD 6E F5      [19]  659 	ld	l,-11 (ix)
   03B2 DD 66 F6      [19]  660 	ld	h,-10 (ix)
   03B5 7E            [ 7]  661 	ld	a,(hl)
   03B6 DD 77 F7      [19]  662 	ld	-9 (ix),a
                            663 ;src/Enemy.c:162: ui_log_add_log(integer_to_string(e->id,'d'));
   03B9 DD 6E FE      [19]  664 	ld	l,-2 (ix)
   03BC DD 66 FF      [19]  665 	ld	h,-1 (ix)
   03BF 46            [ 7]  666 	ld	b,(hl)
   03C0 3E 64         [ 7]  667 	ld	a,#0x64
   03C2 F5            [11]  668 	push	af
   03C3 33            [ 6]  669 	inc	sp
   03C4 C5            [11]  670 	push	bc
   03C5 33            [ 6]  671 	inc	sp
   03C6 CD 1B 25      [17]  672 	call	_integer_to_string
   03C9 E3            [19]  673 	ex	(sp),hl
   03CA CD 24 2D      [17]  674 	call	_ui_log_add_log
   03CD F1            [10]  675 	pop	af
                            676 ;src/Enemy.c:164: dx=movement_directionArray[d];
   03CE DD 7E F7      [19]  677 	ld	a,-9 (ix)
   03D1 C6 B6         [ 7]  678 	add	a, #<(_movement_directionArray)
   03D3 6F            [ 4]  679 	ld	l,a
   03D4 3E 00         [ 7]  680 	ld	a,#0x00
   03D6 CE 06         [ 7]  681 	adc	a, #>(_movement_directionArray)
   03D8 67            [ 4]  682 	ld	h,a
   03D9 7E            [ 7]  683 	ld	a,(hl)
   03DA DD 77 F4      [19]  684 	ld	-12 (ix),a
                            685 ;src/Enemy.c:165: dy=movement_directionArray[d+1];
   03DD DD 4E F7      [19]  686 	ld	c,-9 (ix)
   03E0 0C            [ 4]  687 	inc	c
   03E1 21 B6 06      [10]  688 	ld	hl,#_movement_directionArray
   03E4 06 00         [ 7]  689 	ld	b,#0x00
   03E6 09            [11]  690 	add	hl, bc
   03E7 7E            [ 7]  691 	ld	a,(hl)
   03E8 DD 77 F3      [19]  692 	ld	-13 (ix),a
                            693 ;src/Enemy.c:167: m=0;
   03EB DD 36 ED 00   [19]  694 	ld	-19 (ix),#0x00
                            695 ;src/Enemy.c:169: if((map[(x+dx) + (y+dy)*MAP_WIDTH])&(CELL_WALL_MASK|CELL_ENEMY_MASK)){//If wall or enemy forward
   03EF DD 7E FA      [19]  696 	ld	a,-6 (ix)
   03F2 DD 77 EF      [19]  697 	ld	-17 (ix),a
   03F5 DD 36 F0 00   [19]  698 	ld	-16 (ix),#0x00
   03F9 DD 4E F4      [19]  699 	ld	c,-12 (ix)
   03FC DD 7E F4      [19]  700 	ld	a,-12 (ix)
   03FF 17            [ 4]  701 	rla
   0400 9F            [ 4]  702 	sbc	a, a
   0401 47            [ 4]  703 	ld	b,a
   0402 DD 7E EF      [19]  704 	ld	a,-17 (ix)
   0405 81            [ 4]  705 	add	a, c
   0406 4F            [ 4]  706 	ld	c,a
   0407 DD 7E F0      [19]  707 	ld	a,-16 (ix)
   040A 88            [ 4]  708 	adc	a, b
   040B 47            [ 4]  709 	ld	b,a
   040C DD 7E FD      [19]  710 	ld	a,-3 (ix)
   040F DD 77 F1      [19]  711 	ld	-15 (ix),a
   0412 DD 36 F2 00   [19]  712 	ld	-14 (ix),#0x00
   0416 DD 5E F3      [19]  713 	ld	e,-13 (ix)
   0419 DD 7E F3      [19]  714 	ld	a,-13 (ix)
   041C 17            [ 4]  715 	rla
   041D 9F            [ 4]  716 	sbc	a, a
   041E 57            [ 4]  717 	ld	d,a
   041F DD 6E F1      [19]  718 	ld	l,-15 (ix)
   0422 DD 66 F2      [19]  719 	ld	h,-14 (ix)
   0425 19            [11]  720 	add	hl,de
   0426 29            [11]  721 	add	hl, hl
   0427 29            [11]  722 	add	hl, hl
   0428 29            [11]  723 	add	hl, hl
   0429 29            [11]  724 	add	hl, hl
   042A 29            [11]  725 	add	hl, hl
   042B 09            [11]  726 	add	hl,bc
   042C 01 00 70      [10]  727 	ld	bc,#0x7000
   042F 09            [11]  728 	add	hl,bc
   0430 7E            [ 7]  729 	ld	a,(hl)
   0431 E6 8F         [ 7]  730 	and	a, #0x8F
   0433 CA B7 05      [10]  731 	jp	Z,00120$
                            732 ;src/Enemy.c:171: d=((e->direction+2)&7);
   0436 DD 6E F5      [19]  733 	ld	l,-11 (ix)
   0439 DD 66 F6      [19]  734 	ld	h,-10 (ix)
   043C 4E            [ 7]  735 	ld	c,(hl)
   043D 79            [ 4]  736 	ld	a,c
   043E C6 02         [ 7]  737 	add	a, #0x02
   0440 E6 07         [ 7]  738 	and	a, #0x07
   0442 5F            [ 4]  739 	ld	e,a
                            740 ;src/Enemy.c:173: dx=movement_directionArray[d];
   0443 21 B6 06      [10]  741 	ld	hl,#_movement_directionArray
   0446 16 00         [ 7]  742 	ld	d,#0x00
   0448 19            [11]  743 	add	hl, de
   0449 46            [ 7]  744 	ld	b,(hl)
                            745 ;src/Enemy.c:174: dy=movement_directionArray[d+1];
   044A 1C            [ 4]  746 	inc	e
   044B 21 B6 06      [10]  747 	ld	hl,#_movement_directionArray
   044E 16 00         [ 7]  748 	ld	d,#0x00
   0450 19            [11]  749 	add	hl, de
   0451 6E            [ 7]  750 	ld	l,(hl)
                            751 ;src/Enemy.c:176: ml=(map[x+dx + (y+dy)*MAP_WIDTH]);
   0452 78            [ 4]  752 	ld	a,b
   0453 5F            [ 4]  753 	ld	e,a
   0454 17            [ 4]  754 	rla
   0455 9F            [ 4]  755 	sbc	a, a
   0456 57            [ 4]  756 	ld	d,a
   0457 DD 7E EF      [19]  757 	ld	a,-17 (ix)
   045A 83            [ 4]  758 	add	a, e
   045B 5F            [ 4]  759 	ld	e,a
   045C DD 7E F0      [19]  760 	ld	a,-16 (ix)
   045F 8A            [ 4]  761 	adc	a, d
   0460 57            [ 4]  762 	ld	d,a
   0461 7D            [ 4]  763 	ld	a,l
   0462 17            [ 4]  764 	rla
   0463 9F            [ 4]  765 	sbc	a, a
   0464 67            [ 4]  766 	ld	h,a
   0465 DD 7E F1      [19]  767 	ld	a,-15 (ix)
   0468 85            [ 4]  768 	add	a, l
   0469 6F            [ 4]  769 	ld	l,a
   046A DD 7E F2      [19]  770 	ld	a,-14 (ix)
   046D 8C            [ 4]  771 	adc	a, h
   046E 67            [ 4]  772 	ld	h,a
   046F 29            [11]  773 	add	hl, hl
   0470 29            [11]  774 	add	hl, hl
   0471 29            [11]  775 	add	hl, hl
   0472 29            [11]  776 	add	hl, hl
   0473 29            [11]  777 	add	hl, hl
   0474 19            [11]  778 	add	hl,de
   0475 11 00 70      [10]  779 	ld	de,#0x7000
   0478 19            [11]  780 	add	hl,de
   0479 7E            [ 7]  781 	ld	a,(hl)
   047A DD 77 EE      [19]  782 	ld	-18 (ix),a
                            783 ;src/Enemy.c:178: d=((e->direction-2)&7);
   047D 0D            [ 4]  784 	dec	c
   047E 0D            [ 4]  785 	dec	c
   047F 79            [ 4]  786 	ld	a,c
   0480 E6 07         [ 7]  787 	and	a, #0x07
                            788 ;src/Enemy.c:180: dx=movement_directionArray[d];
   0482 DD 77 F7      [19]  789 	ld	-9 (ix),a
   0485 C6 B6         [ 7]  790 	add	a,#<(_movement_directionArray)
   0487 6F            [ 4]  791 	ld	l,a
   0488 3E 06         [ 7]  792 	ld	a,#>(_movement_directionArray)
   048A CE 00         [ 7]  793 	adc	a, #0x00
   048C 67            [ 4]  794 	ld	h,a
   048D 4E            [ 7]  795 	ld	c,(hl)
                            796 ;src/Enemy.c:181: dy=movement_directionArray[d+1];
   048E DD 5E F7      [19]  797 	ld	e,-9 (ix)
   0491 1C            [ 4]  798 	inc	e
   0492 21 B6 06      [10]  799 	ld	hl,#_movement_directionArray
   0495 16 00         [ 7]  800 	ld	d,#0x00
   0497 19            [11]  801 	add	hl, de
   0498 5E            [ 7]  802 	ld	e,(hl)
                            803 ;src/Enemy.c:183: mr=(map[x+dx + (y+dy)*MAP_WIDTH]);
   0499 79            [ 4]  804 	ld	a,c
   049A 17            [ 4]  805 	rla
   049B 9F            [ 4]  806 	sbc	a, a
   049C 47            [ 4]  807 	ld	b,a
   049D DD 7E EF      [19]  808 	ld	a,-17 (ix)
   04A0 81            [ 4]  809 	add	a, c
   04A1 4F            [ 4]  810 	ld	c,a
   04A2 DD 7E F0      [19]  811 	ld	a,-16 (ix)
   04A5 88            [ 4]  812 	adc	a, b
   04A6 47            [ 4]  813 	ld	b,a
   04A7 7B            [ 4]  814 	ld	a,e
   04A8 17            [ 4]  815 	rla
   04A9 9F            [ 4]  816 	sbc	a, a
   04AA 57            [ 4]  817 	ld	d,a
   04AB DD 6E F1      [19]  818 	ld	l,-15 (ix)
   04AE DD 66 F2      [19]  819 	ld	h,-14 (ix)
   04B1 19            [11]  820 	add	hl,de
   04B2 29            [11]  821 	add	hl, hl
   04B3 29            [11]  822 	add	hl, hl
   04B4 29            [11]  823 	add	hl, hl
   04B5 29            [11]  824 	add	hl, hl
   04B6 29            [11]  825 	add	hl, hl
   04B7 09            [11]  826 	add	hl,bc
   04B8 01 00 70      [10]  827 	ld	bc,#0x7000
   04BB 09            [11]  828 	add	hl,bc
   04BC 46            [ 7]  829 	ld	b,(hl)
                            830 ;src/Enemy.c:186: if(cpct_getRandom_mxor_u8()%2){//Turn left then right
   04BD C5            [11]  831 	push	bc
   04BE CD C2 58      [17]  832 	call	_cpct_getRandom_mxor_u8
   04C1 C1            [10]  833 	pop	bc
   04C2 7D            [ 4]  834 	ld	a,l
   04C3 E6 01         [ 7]  835 	and	a, #0x01
   04C5 6F            [ 4]  836 	ld	l,a
                            837 ;src/Enemy.c:187: if(!(ml&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move left
   04C6 DD 7E EE      [19]  838 	ld	a,-18 (ix)
   04C9 E6 8F         [ 7]  839 	and	a, #0x8F
   04CB 4F            [ 4]  840 	ld	c,a
                            841 ;src/Enemy.c:191: else if(!(mr&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move right
   04CC 78            [ 4]  842 	ld	a,b
   04CD E6 8F         [ 7]  843 	and	a, #0x8F
   04CF 5F            [ 4]  844 	ld	e,a
                            845 ;src/Enemy.c:186: if(cpct_getRandom_mxor_u8()%2){//Turn left then right
   04D0 7D            [ 4]  846 	ld	a,l
   04D1 B7            [ 4]  847 	or	a, a
   04D2 28 30         [12]  848 	jr	Z,00112$
                            849 ;src/Enemy.c:187: if(!(ml&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move left
   04D4 79            [ 4]  850 	ld	a,c
   04D5 B7            [ 4]  851 	or	a, a
   04D6 20 14         [12]  852 	jr	NZ,00104$
                            853 ;src/Enemy.c:188: d=((e->direction+2)&7);
   04D8 DD 6E F5      [19]  854 	ld	l,-11 (ix)
   04DB DD 66 F6      [19]  855 	ld	h,-10 (ix)
   04DE 7E            [ 7]  856 	ld	a,(hl)
   04DF C6 02         [ 7]  857 	add	a, #0x02
   04E1 E6 07         [ 7]  858 	and	a, #0x07
   04E3 DD 77 F7      [19]  859 	ld	-9 (ix),a
                            860 ;src/Enemy.c:189: m=1;
   04E6 DD 36 ED 01   [19]  861 	ld	-19 (ix),#0x01
   04EA 18 46         [12]  862 	jr	00113$
   04EC                     863 00104$:
                            864 ;src/Enemy.c:191: else if(!(mr&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move right
   04EC 7B            [ 4]  865 	ld	a,e
   04ED B7            [ 4]  866 	or	a, a
   04EE 20 42         [12]  867 	jr	NZ,00113$
                            868 ;src/Enemy.c:192: d=((e->direction-2)&7);
   04F0 DD 6E F5      [19]  869 	ld	l,-11 (ix)
   04F3 DD 66 F6      [19]  870 	ld	h,-10 (ix)
   04F6 7E            [ 7]  871 	ld	a,(hl)
   04F7 C6 FE         [ 7]  872 	add	a,#0xFE
   04F9 E6 07         [ 7]  873 	and	a, #0x07
   04FB DD 77 F7      [19]  874 	ld	-9 (ix),a
                            875 ;src/Enemy.c:193: m=1;
   04FE DD 36 ED 01   [19]  876 	ld	-19 (ix),#0x01
   0502 18 2E         [12]  877 	jr	00113$
   0504                     878 00112$:
                            879 ;src/Enemy.c:198: if(!(mr&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move left
   0504 7B            [ 4]  880 	ld	a,e
   0505 B7            [ 4]  881 	or	a, a
   0506 20 14         [12]  882 	jr	NZ,00109$
                            883 ;src/Enemy.c:199: d=((e->direction-2)&7);
   0508 DD 6E F5      [19]  884 	ld	l,-11 (ix)
   050B DD 66 F6      [19]  885 	ld	h,-10 (ix)
   050E 7E            [ 7]  886 	ld	a,(hl)
   050F C6 FE         [ 7]  887 	add	a,#0xFE
   0511 E6 07         [ 7]  888 	and	a, #0x07
   0513 DD 77 F7      [19]  889 	ld	-9 (ix),a
                            890 ;src/Enemy.c:200: m=1;
   0516 DD 36 ED 01   [19]  891 	ld	-19 (ix),#0x01
   051A 18 16         [12]  892 	jr	00113$
   051C                     893 00109$:
                            894 ;src/Enemy.c:202: else if(!(ml&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move right
   051C 79            [ 4]  895 	ld	a,c
   051D B7            [ 4]  896 	or	a, a
   051E 20 12         [12]  897 	jr	NZ,00113$
                            898 ;src/Enemy.c:203: d=((e->direction+2)&7);
   0520 DD 6E F5      [19]  899 	ld	l,-11 (ix)
   0523 DD 66 F6      [19]  900 	ld	h,-10 (ix)
   0526 7E            [ 7]  901 	ld	a,(hl)
   0527 C6 02         [ 7]  902 	add	a, #0x02
   0529 E6 07         [ 7]  903 	and	a, #0x07
   052B DD 77 F7      [19]  904 	ld	-9 (ix),a
                            905 ;src/Enemy.c:204: m=1;
   052E DD 36 ED 01   [19]  906 	ld	-19 (ix),#0x01
   0532                     907 00113$:
                            908 ;src/Enemy.c:208: if(!m){
   0532 DD 7E ED      [19]  909 	ld	a,-19 (ix)
   0535 B7            [ 4]  910 	or	a, a
   0536 20 60         [12]  911 	jr	NZ,00117$
                            912 ;src/Enemy.c:210: d=((e->direction+4)&7);
   0538 DD 6E F5      [19]  913 	ld	l,-11 (ix)
   053B DD 66 F6      [19]  914 	ld	h,-10 (ix)
   053E 7E            [ 7]  915 	ld	a,(hl)
   053F C6 04         [ 7]  916 	add	a, #0x04
   0541 E6 07         [ 7]  917 	and	a, #0x07
                            918 ;src/Enemy.c:212: dx=movement_directionArray[d];
   0543 DD 77 F7      [19]  919 	ld	-9 (ix),a
   0546 C6 B6         [ 7]  920 	add	a,#<(_movement_directionArray)
   0548 6F            [ 4]  921 	ld	l,a
   0549 3E 06         [ 7]  922 	ld	a,#>(_movement_directionArray)
   054B CE 00         [ 7]  923 	adc	a, #0x00
   054D 67            [ 4]  924 	ld	h,a
   054E 7E            [ 7]  925 	ld	a,(hl)
   054F DD 77 F4      [19]  926 	ld	-12 (ix),a
                            927 ;src/Enemy.c:213: dy=movement_directionArray[d+1];
   0552 DD 4E F7      [19]  928 	ld	c,-9 (ix)
   0555 0C            [ 4]  929 	inc	c
   0556 21 B6 06      [10]  930 	ld	hl,#_movement_directionArray
   0559 06 00         [ 7]  931 	ld	b,#0x00
   055B 09            [11]  932 	add	hl, bc
   055C 7E            [ 7]  933 	ld	a,(hl)
   055D DD 77 F3      [19]  934 	ld	-13 (ix),a
                            935 ;src/Enemy.c:215: if(!((map[x+dx + (y+dy)*MAP_WIDTH])&(CELL_WALL_MASK|CELL_ENEMY_MASK))){
   0560 DD 4E F4      [19]  936 	ld	c,-12 (ix)
   0563 DD 7E F4      [19]  937 	ld	a,-12 (ix)
   0566 17            [ 4]  938 	rla
   0567 9F            [ 4]  939 	sbc	a, a
   0568 47            [ 4]  940 	ld	b,a
   0569 DD 7E EF      [19]  941 	ld	a,-17 (ix)
   056C 81            [ 4]  942 	add	a, c
   056D 4F            [ 4]  943 	ld	c,a
   056E DD 7E F0      [19]  944 	ld	a,-16 (ix)
   0571 88            [ 4]  945 	adc	a, b
   0572 47            [ 4]  946 	ld	b,a
   0573 DD 5E F3      [19]  947 	ld	e,-13 (ix)
   0576 DD 7E F3      [19]  948 	ld	a,-13 (ix)
   0579 17            [ 4]  949 	rla
   057A 9F            [ 4]  950 	sbc	a, a
   057B 57            [ 4]  951 	ld	d,a
   057C DD 6E F1      [19]  952 	ld	l,-15 (ix)
   057F DD 66 F2      [19]  953 	ld	h,-14 (ix)
   0582 19            [11]  954 	add	hl,de
   0583 29            [11]  955 	add	hl, hl
   0584 29            [11]  956 	add	hl, hl
   0585 29            [11]  957 	add	hl, hl
   0586 29            [11]  958 	add	hl, hl
   0587 29            [11]  959 	add	hl, hl
   0588 09            [11]  960 	add	hl,bc
   0589 01 00 70      [10]  961 	ld	bc,#0x7000
   058C 09            [11]  962 	add	hl,bc
   058D 7E            [ 7]  963 	ld	a,(hl)
   058E E6 8F         [ 7]  964 	and	a, #0x8F
   0590 20 29         [12]  965 	jr	NZ,00121$
                            966 ;src/Enemy.c:216: m=1;
   0592 DD 36 ED 01   [19]  967 	ld	-19 (ix),#0x01
   0596 18 23         [12]  968 	jr	00121$
   0598                     969 00117$:
                            970 ;src/Enemy.c:221: dx=movement_directionArray[d];
   0598 3E B6         [ 7]  971 	ld	a,#<(_movement_directionArray)
   059A DD 86 F7      [19]  972 	add	a, -9 (ix)
   059D 6F            [ 4]  973 	ld	l,a
   059E 3E 06         [ 7]  974 	ld	a,#>(_movement_directionArray)
   05A0 CE 00         [ 7]  975 	adc	a, #0x00
   05A2 67            [ 4]  976 	ld	h,a
   05A3 7E            [ 7]  977 	ld	a,(hl)
   05A4 DD 77 F4      [19]  978 	ld	-12 (ix),a
                            979 ;src/Enemy.c:222: dy=movement_directionArray[d+1];
   05A7 DD 4E F7      [19]  980 	ld	c,-9 (ix)
   05AA 0C            [ 4]  981 	inc	c
   05AB 21 B6 06      [10]  982 	ld	hl,#_movement_directionArray
   05AE 06 00         [ 7]  983 	ld	b,#0x00
   05B0 09            [11]  984 	add	hl, bc
   05B1 7E            [ 7]  985 	ld	a,(hl)
   05B2 DD 77 F3      [19]  986 	ld	-13 (ix),a
   05B5 18 04         [12]  987 	jr	00121$
   05B7                     988 00120$:
                            989 ;src/Enemy.c:227: m=1;
   05B7 DD 36 ED 01   [19]  990 	ld	-19 (ix),#0x01
   05BB                     991 00121$:
                            992 ;src/Enemy.c:230: if(m){
   05BB DD 7E ED      [19]  993 	ld	a,-19 (ix)
   05BE B7            [ 4]  994 	or	a, a
   05BF 28 5D         [12]  995 	jr	Z,00124$
                            996 ;src/Enemy.c:231: (map[x + (y)*MAP_WIDTH]) &= (CELL_ITEM_MASK|CELL_WALL_MASK);
   05C1 DD 6E F1      [19]  997 	ld	l,-15 (ix)
   05C4 DD 66 F2      [19]  998 	ld	h,-14 (ix)
   05C7 29            [11]  999 	add	hl, hl
   05C8 29            [11] 1000 	add	hl, hl
   05C9 29            [11] 1001 	add	hl, hl
   05CA 29            [11] 1002 	add	hl, hl
   05CB 29            [11] 1003 	add	hl, hl
   05CC DD 5E EF      [19] 1004 	ld	e,-17 (ix)
   05CF DD 56 F0      [19] 1005 	ld	d,-16 (ix)
   05D2 19            [11] 1006 	add	hl,de
   05D3 01 00 70      [10] 1007 	ld	bc,#0x7000
   05D6 09            [11] 1008 	add	hl,bc
   05D7 7E            [ 7] 1009 	ld	a,(hl)
   05D8 E6 F0         [ 7] 1010 	and	a, #0xF0
   05DA 77            [ 7] 1011 	ld	(hl),a
                           1012 ;src/Enemy.c:235: x+=dx;
   05DB DD 7E FA      [19] 1013 	ld	a, -6 (ix)
   05DE DD 86 F4      [19] 1014 	add	a, -12 (ix)
   05E1 4F            [ 4] 1015 	ld	c,a
                           1016 ;src/Enemy.c:236: y+=dy;
   05E2 DD 7E FD      [19] 1017 	ld	a, -3 (ix)
   05E5 DD 86 F3      [19] 1018 	add	a, -13 (ix)
   05E8 5F            [ 4] 1019 	ld	e,a
                           1020 ;src/Enemy.c:238: e->direction = d;
   05E9 DD 6E F5      [19] 1021 	ld	l,-11 (ix)
   05EC DD 66 F6      [19] 1022 	ld	h,-10 (ix)
   05EF DD 7E F7      [19] 1023 	ld	a,-9 (ix)
   05F2 77            [ 7] 1024 	ld	(hl),a
                           1025 ;src/Enemy.c:240: e->position.x = x;
   05F3 DD 6E F8      [19] 1026 	ld	l,-8 (ix)
   05F6 DD 66 F9      [19] 1027 	ld	h,-7 (ix)
   05F9 71            [ 7] 1028 	ld	(hl),c
                           1029 ;src/Enemy.c:241: e->position.y = y;
   05FA DD 6E FB      [19] 1030 	ld	l,-5 (ix)
   05FD DD 66 FC      [19] 1031 	ld	h,-4 (ix)
   0600 73            [ 7] 1032 	ld	(hl),e
                           1033 ;src/Enemy.c:244: (map[x + (y)*MAP_WIDTH]) |= (e->id)+1;
   0601 06 00         [ 7] 1034 	ld	b,#0x00
   0603 26 00         [ 7] 1035 	ld	h,#0x00
   0605 6B            [ 4] 1036 	ld	l, e
   0606 29            [11] 1037 	add	hl, hl
   0607 29            [11] 1038 	add	hl, hl
   0608 29            [11] 1039 	add	hl, hl
   0609 29            [11] 1040 	add	hl, hl
   060A 29            [11] 1041 	add	hl, hl
   060B 09            [11] 1042 	add	hl,bc
   060C 01 00 70      [10] 1043 	ld	bc,#0x7000
   060F 09            [11] 1044 	add	hl,bc
   0610 4D            [ 4] 1045 	ld	c,l
   0611 44            [ 4] 1046 	ld	b,h
   0612 0A            [ 7] 1047 	ld	a,(bc)
   0613 5F            [ 4] 1048 	ld	e,a
   0614 DD 6E FE      [19] 1049 	ld	l,-2 (ix)
   0617 DD 66 FF      [19] 1050 	ld	h,-1 (ix)
   061A 7E            [ 7] 1051 	ld	a,(hl)
   061B 3C            [ 4] 1052 	inc	a
   061C B3            [ 4] 1053 	or	a, e
   061D 02            [ 7] 1054 	ld	(bc),a
   061E                    1055 00124$:
   061E DD F9         [10] 1056 	ld	sp, ix
   0620 DD E1         [14] 1057 	pop	ix
   0622 C9            [10] 1058 	ret
                           1059 ;src/Enemy.c:248: void enemy_AI_passive(Enemy* e) __z88dk_fastcall{
                           1060 ;	---------------------------------
                           1061 ; Function enemy_AI_passive
                           1062 ; ---------------------------------
   0623                    1063 _enemy_AI_passive::
   0623 4D            [ 4] 1064 	ld	c,l
   0624 44            [ 4] 1065 	ld	b,h
                           1066 ;src/Enemy.c:252: hp=e->hitPoints;
   0625 C5            [11] 1067 	push	bc
   0626 FD E1         [14] 1068 	pop	iy
                           1069 ;src/Enemy.c:255: if(hp < ENEMY_INITIAL_HP){//Aggresive
                           1070 ;src/Enemy.c:258: else if(hp < ENEMY_INITIAL_HP/4){ //Flee
   0628 FD 7E 05      [19] 1071 	ld	a, 5 (iy)
   062B FE FF         [ 7] 1072 	cp	a,#0xFF
   062D D8            [11] 1073 	ret	C
   062E D6 3F         [ 7] 1074 	sub	a, #0x3F
   0630 D8            [11] 1075 	ret	C
                           1076 ;src/Enemy.c:262: enemy_roam(e);        
   0631 69            [ 4] 1077 	ld	l, c
   0632 60            [ 4] 1078 	ld	h, b
   0633 C3 58 03      [10] 1079 	jp  _enemy_roam
                           1080 ;src/Enemy.c:266: void enemy_AI_aggressive(Enemy* e){
                           1081 ;	---------------------------------
                           1082 ; Function enemy_AI_aggressive
                           1083 ; ---------------------------------
   0636                    1084 _enemy_AI_aggressive::
                           1085 ;src/Enemy.c:268: }
   0636 C9            [10] 1086 	ret
                           1087 ;src/Enemy.c:270: void enemy_AI_tactical(Enemy* e){
                           1088 ;	---------------------------------
                           1089 ; Function enemy_AI_tactical
                           1090 ; ---------------------------------
   0637                    1091 _enemy_AI_tactical::
                           1092 ;src/Enemy.c:272: }
   0637 C9            [10] 1093 	ret
                           1094 ;src/Enemy.c:274: void enemy_AI_shy(Enemy* e){
                           1095 ;	---------------------------------
                           1096 ; Function enemy_AI_shy
                           1097 ; ---------------------------------
   0638                    1098 _enemy_AI_shy::
                           1099 ;src/Enemy.c:276: }
   0638 C9            [10] 1100 	ret
                           1101 ;src/Enemy.c:278: void enemy_update(){
                           1102 ;	---------------------------------
                           1103 ; Function enemy_update
                           1104 ; ---------------------------------
   0639                    1105 _enemy_update::
                           1106 ;src/Enemy.c:280: Enemy* enemy=enemyArray;
   0639 01 90 5A      [10] 1107 	ld	bc,#_enemyArray+0
                           1108 ;src/Enemy.c:282: for(i;i;--i){
   063C 16 0F         [ 7] 1109 	ld	d,#0x0F
   063E                    1110 00110$:
   063E 7A            [ 4] 1111 	ld	a,d
   063F B7            [ 4] 1112 	or	a, a
   0640 C8            [11] 1113 	ret	Z
                           1114 ;src/Enemy.c:283: if(enemy->hitPoints){
   0641 C5            [11] 1115 	push	bc
   0642 FD E1         [14] 1116 	pop	iy
   0644 FD 7E 05      [19] 1117 	ld	a,5 (iy)
   0647 B7            [ 4] 1118 	or	a, a
   0648 28 24         [12] 1119 	jr	Z,00107$
                           1120 ;src/Enemy.c:284: switch(enemy->type){
   064A 69            [ 4] 1121 	ld	l, c
   064B 60            [ 4] 1122 	ld	h, b
   064C 23            [ 6] 1123 	inc	hl
   064D 5E            [ 7] 1124 	ld	e,(hl)
   064E 3E 03         [ 7] 1125 	ld	a,#0x03
   0650 93            [ 4] 1126 	sub	a, e
   0651 38 1B         [12] 1127 	jr	C,00107$
   0653 D5            [11] 1128 	push	de
   0654 16 00         [ 7] 1129 	ld	d,#0x00
   0656 21 5D 06      [10] 1130 	ld	hl,#00131$
   0659 19            [11] 1131 	add	hl,de
   065A 19            [11] 1132 	add	hl,de
                           1133 ;src/Enemy.c:285: case 0:{
   065B D1            [10] 1134 	pop	de
   065C E9            [ 4] 1135 	jp	(hl)
   065D                    1136 00131$:
   065D 18 06         [12] 1137 	jr	00101$
   065F 18 0D         [12] 1138 	jr	00107$
   0661 18 0B         [12] 1139 	jr	00107$
   0663 18 09         [12] 1140 	jr	00104$
   0665                    1141 00101$:
                           1142 ;src/Enemy.c:286: enemy_AI_passive(enemy);
   0665 C5            [11] 1143 	push	bc
   0666 D5            [11] 1144 	push	de
   0667 69            [ 4] 1145 	ld	l, c
   0668 60            [ 4] 1146 	ld	h, b
   0669 CD 23 06      [17] 1147 	call	_enemy_AI_passive
   066C D1            [10] 1148 	pop	de
   066D C1            [10] 1149 	pop	bc
                           1150 ;src/Enemy.c:287: break;
                           1151 ;src/Enemy.c:289: case 1:{
                           1152 ;src/Enemy.c:291: break;
                           1153 ;src/Enemy.c:293: case 2:{
                           1154 ;src/Enemy.c:295: break;
                           1155 ;src/Enemy.c:297: case 3:{
                           1156 ;src/Enemy.c:301: }
   066E                    1157 00104$:
   066E                    1158 00107$:
                           1159 ;src/Enemy.c:311: ++enemy;
   066E 21 0A 00      [10] 1160 	ld	hl,#0x000A
   0671 09            [11] 1161 	add	hl,bc
   0672 4D            [ 4] 1162 	ld	c,l
   0673 44            [ 4] 1163 	ld	b,h
                           1164 ;src/Enemy.c:282: for(i;i;--i){
   0674 15            [ 4] 1165 	dec	d
   0675 18 C7         [12] 1166 	jr	00110$
                           1167 	.area _CODE
                           1168 	.area _INITIALIZER
                           1169 	.area _CABS (ABS)
