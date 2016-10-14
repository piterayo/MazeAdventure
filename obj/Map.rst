                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module Map
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _generate_exit_door
                             12 	.globl _generate_map
                             13 	.globl _get_random_wall
                             14 	.globl _level_get_level
                             15 	.globl _cpct_setSeed_lcg_u8
                             16 	.globl _cpct_getRandom_lcg_u8
                             17 	.globl _cpct_memset
                             18 	.globl _rand_seed
                             19 	.globl _map_get_seed
                             20 	.globl _generate_level
                             21 	.globl _generate_level_with_seed
                             22 ;--------------------------------------------------------
                             23 ; special function registers
                             24 ;--------------------------------------------------------
                             25 ;--------------------------------------------------------
                             26 ; ram data
                             27 ;--------------------------------------------------------
                             28 	.area _DATA
                             29 ;--------------------------------------------------------
                             30 ; ram data
                             31 ;--------------------------------------------------------
                             32 	.area _INITIALIZED
   4543                      33 _rand_seed::
   4543                      34 	.ds 1
                             35 ;--------------------------------------------------------
                             36 ; absolute external ram data
                             37 ;--------------------------------------------------------
                             38 	.area _DABS (ABS)
                             39 ;--------------------------------------------------------
                             40 ; global & static initialisations
                             41 ;--------------------------------------------------------
                             42 	.area _HOME
                             43 	.area _GSINIT
                             44 	.area _GSFINAL
                             45 	.area _GSINIT
                             46 ;--------------------------------------------------------
                             47 ; Home
                             48 ;--------------------------------------------------------
                             49 	.area _HOME
                             50 	.area _HOME
                             51 ;--------------------------------------------------------
                             52 ; code
                             53 ;--------------------------------------------------------
                             54 	.area _CODE
                             55 ;src/Map.c:14: u8 map_get_seed(){
                             56 ;	---------------------------------
                             57 ; Function map_get_seed
                             58 ; ---------------------------------
   01B8                      59 _map_get_seed::
                             60 ;src/Map.c:15: return rand_seed;
   01B8 FD 21 43 45   [14]   61 	ld	iy,#_rand_seed
   01BC FD 6E 00      [19]   62 	ld	l,0 (iy)
   01BF C9            [10]   63 	ret
                             64 ;src/Map.c:18: u8 get_random_wall(){
                             65 ;	---------------------------------
                             66 ; Function get_random_wall
                             67 ; ---------------------------------
   01C0                      68 _get_random_wall::
                             69 ;src/Map.c:19: u8 cellType = cpct_getRandom_lcg_u8();
   01C0 CD F7 42      [17]   70 	call	_cpct_getRandom_lcg_u8
                             71 ;src/Map.c:20: if(cellType&1){
   01C3 CB 45         [ 8]   72 	bit	0, l
   01C5 28 03         [12]   73 	jr	Z,00108$
                             74 ;src/Map.c:21: return CELLTYPE_WALL1;
   01C7 2E 81         [ 7]   75 	ld	l,#0x81
   01C9 C9            [10]   76 	ret
   01CA                      77 00108$:
                             78 ;src/Map.c:24: if(cellType&3){
   01CA 7D            [ 4]   79 	ld	a,l
   01CB E6 03         [ 7]   80 	and	a, #0x03
   01CD 28 03         [12]   81 	jr	Z,00105$
                             82 ;src/Map.c:25: return CELLTYPE_WALL2;
   01CF 2E 82         [ 7]   83 	ld	l,#0x82
   01D1 C9            [10]   84 	ret
   01D2                      85 00105$:
                             86 ;src/Map.c:28: if(cellType&5){
   01D2 7D            [ 4]   87 	ld	a,l
   01D3 E6 05         [ 7]   88 	and	a, #0x05
   01D5 28 03         [12]   89 	jr	Z,00102$
                             90 ;src/Map.c:29: return CELLTYPE_WALL3;
   01D7 2E 83         [ 7]   91 	ld	l,#0x83
   01D9 C9            [10]   92 	ret
   01DA                      93 00102$:
                             94 ;src/Map.c:32: return CELLTYPE_WALL4;  
   01DA 2E 84         [ 7]   95 	ld	l,#0x84
   01DC C9            [10]   96 	ret
                             97 ;src/Map.c:38: void generate_map(){
                             98 ;	---------------------------------
                             99 ; Function generate_map
                            100 ; ---------------------------------
   01DD                     101 _generate_map::
   01DD DD E5         [15]  102 	push	ix
   01DF DD 21 00 00   [14]  103 	ld	ix,#0
   01E3 DD 39         [15]  104 	add	ix,sp
   01E5 21 EB FF      [10]  105 	ld	hl,#-21
   01E8 39            [11]  106 	add	hl,sp
   01E9 F9            [ 6]  107 	ld	sp,hl
                            108 ;src/Map.c:41: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
   01EA DD 36 F4 83   [19]  109 	ld	-12 (ix),#0x83
   01EE DD 36 F5 03   [19]  110 	ld	-11 (ix),#0x03
                            111 ;src/Map.c:47: u16 wallListCount = 0;
   01F2 DD 36 ED 00   [19]  112 	ld	-19 (ix),#0x00
   01F6 DD 36 EE 00   [19]  113 	ld	-18 (ix),#0x00
                            114 ;src/Map.c:48: u16 lastStackItem = 0;
   01FA 21 00 00      [10]  115 	ld	hl,#0x0000
   01FD E3            [19]  116 	ex	(sp), hl
                            117 ;src/Map.c:50: cpct_memset (GENERATOR_DATA_PTR, 0, 4096);
   01FE 21 00 10      [10]  118 	ld	hl,#0x1000
   0201 E5            [11]  119 	push	hl
   0202 AF            [ 4]  120 	xor	a, a
   0203 F5            [11]  121 	push	af
   0204 33            [ 6]  122 	inc	sp
   0205 26 64         [ 7]  123 	ld	h, #0x64
   0207 E5            [11]  124 	push	hl
   0208 CD 26 43      [17]  125 	call	_cpct_memset
                            126 ;src/Map.c:52: (*cellStack).x = (cpct_getRandom_lcg_u8()%(MAP_WIDTH-2))+1; //RANDOM
   020B CD F7 42      [17]  127 	call	_cpct_getRandom_lcg_u8
   020E 45            [ 4]  128 	ld	b,l
   020F 3E 1E         [ 7]  129 	ld	a,#0x1E
   0211 F5            [11]  130 	push	af
   0212 33            [ 6]  131 	inc	sp
   0213 C5            [11]  132 	push	bc
   0214 33            [ 6]  133 	inc	sp
   0215 CD 45 42      [17]  134 	call	__moduchar
   0218 F1            [10]  135 	pop	af
   0219 4D            [ 4]  136 	ld	c,l
   021A 0C            [ 4]  137 	inc	c
   021B 21 00 64      [10]  138 	ld	hl,#0x6400
   021E 71            [ 7]  139 	ld	(hl),c
                            140 ;src/Map.c:53: (*cellStack).y = (cpct_getRandom_lcg_u8()%(MAP_HEIGHT-2))+1; //RANDOM
   021F CD F7 42      [17]  141 	call	_cpct_getRandom_lcg_u8
   0222 45            [ 4]  142 	ld	b,l
   0223 3E 1E         [ 7]  143 	ld	a,#0x1E
   0225 F5            [11]  144 	push	af
   0226 33            [ 6]  145 	inc	sp
   0227 C5            [11]  146 	push	bc
   0228 33            [ 6]  147 	inc	sp
   0229 CD 45 42      [17]  148 	call	__moduchar
   022C F1            [10]  149 	pop	af
   022D 4D            [ 4]  150 	ld	c,l
   022E 0C            [ 4]  151 	inc	c
   022F 21 01 64      [10]  152 	ld	hl,#0x6401
   0232 71            [ 7]  153 	ld	(hl),c
                            154 ;src/Map.c:56: *(i8*)&(PLAYER_position.x) = (*cellStack).y;
   0233 DD 36 FB DE   [19]  155 	ld	-5 (ix),#<(_PLAYER_position)
   0237 DD 36 FC 08   [19]  156 	ld	-4 (ix),#>(_PLAYER_position)
   023B 2E 01         [ 7]  157 	ld	l, #0x01
   023D 7E            [ 7]  158 	ld	a,(hl)
   023E DD 77 FD      [19]  159 	ld	-3 (ix),a
   0241 DD 6E FB      [19]  160 	ld	l,-5 (ix)
   0244 DD 66 FC      [19]  161 	ld	h,-4 (ix)
   0247 DD 7E FD      [19]  162 	ld	a,-3 (ix)
   024A 77            [ 7]  163 	ld	(hl),a
                            164 ;src/Map.c:57: *(i8*)&(PLAYER_position.y) = (*cellStack).x;
   024B DD 36 FB DF   [19]  165 	ld	-5 (ix),#<((_PLAYER_position + 0x0001))
   024F DD 36 FC 08   [19]  166 	ld	-4 (ix),#>((_PLAYER_position + 0x0001))
   0253 21 00 64      [10]  167 	ld	hl,#0x6400
   0256 4E            [ 7]  168 	ld	c,(hl)
   0257 DD 6E FB      [19]  169 	ld	l,-5 (ix)
   025A DD 66 FC      [19]  170 	ld	h,-4 (ix)
   025D 71            [ 7]  171 	ld	(hl),c
                            172 ;src/Map.c:59: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   025E 21 00 04      [10]  173 	ld	hl,#0x0400
   0261 E5            [11]  174 	push	hl
   0262 3E 87         [ 7]  175 	ld	a,#0x87
   0264 F5            [11]  176 	push	af
   0265 33            [ 6]  177 	inc	sp
   0266 26 60         [ 7]  178 	ld	h, #0x60
   0268 E5            [11]  179 	push	hl
   0269 CD 26 43      [17]  180 	call	_cpct_memset
                            181 ;src/Map.c:62: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   026C 3A 00 64      [13]  182 	ld	a,(#0x6400)
   026F DD 77 FD      [19]  183 	ld	-3 (ix), a
   0272 DD 77 FB      [19]  184 	ld	-5 (ix),a
   0275 DD 36 FC 00   [19]  185 	ld	-4 (ix),#0x00
   0279 3E 06         [ 7]  186 	ld	a,#0x05+1
   027B 18 08         [12]  187 	jr	00315$
   027D                     188 00314$:
   027D DD CB FB 26   [23]  189 	sla	-5 (ix)
   0281 DD CB FC 16   [23]  190 	rl	-4 (ix)
   0285                     191 00315$:
   0285 3D            [ 4]  192 	dec	a
   0286 20 F5         [12]  193 	jr	NZ,00314$
   0288 DD 7E FB      [19]  194 	ld	a,-5 (ix)
   028B C6 00         [ 7]  195 	add	a, #0x00
   028D DD 77 FB      [19]  196 	ld	-5 (ix),a
   0290 DD 7E FC      [19]  197 	ld	a,-4 (ix)
   0293 CE 60         [ 7]  198 	adc	a, #0x60
   0295 DD 77 FC      [19]  199 	ld	-4 (ix),a
   0298 21 01 64      [10]  200 	ld	hl,#0x6401
   029B 4E            [ 7]  201 	ld	c,(hl)
   029C DD 6E FB      [19]  202 	ld	l,-5 (ix)
   029F DD 66 FC      [19]  203 	ld	h,-4 (ix)
   02A2 06 00         [ 7]  204 	ld	b,#0x00
   02A4 09            [11]  205 	add	hl, bc
   02A5 36 00         [10]  206 	ld	(hl),#0x00
                            207 ;src/Map.c:65: for(i=0;i<MAP_WIDTH;++i){
   02A7 0E 00         [ 7]  208 	ld	c,#0x00
   02A9                     209 00167$:
                            210 ;src/Map.c:66: map[0][i]=CELLTYPE_WALL1;//get_random_wall();
   02A9 21 00 60      [10]  211 	ld	hl,#0x6000
   02AC 06 00         [ 7]  212 	ld	b,#0x00
   02AE 09            [11]  213 	add	hl, bc
   02AF 36 81         [10]  214 	ld	(hl),#0x81
                            215 ;src/Map.c:67: map[MAP_HEIGHT-1][i]=CELLTYPE_WALL1;//get_random_wall();
   02B1 21 E0 63      [10]  216 	ld	hl,#0x63E0
   02B4 06 00         [ 7]  217 	ld	b,#0x00
   02B6 09            [11]  218 	add	hl, bc
   02B7 36 81         [10]  219 	ld	(hl),#0x81
                            220 ;src/Map.c:65: for(i=0;i<MAP_WIDTH;++i){
   02B9 0C            [ 4]  221 	inc	c
   02BA 79            [ 4]  222 	ld	a,c
   02BB D6 20         [ 7]  223 	sub	a, #0x20
   02BD 38 EA         [12]  224 	jr	C,00167$
                            225 ;src/Map.c:70: for(i=1;i<MAP_HEIGHT-1;++i){
   02BF DD 36 F2 01   [19]  226 	ld	-14 (ix),#0x01
   02C3                     227 00169$:
                            228 ;src/Map.c:71: map[i][0]=CELLTYPE_WALL1;//get_random_wall();
   02C3 DD 7E F2      [19]  229 	ld	a,-14 (ix)
   02C6 DD 77 FB      [19]  230 	ld	-5 (ix),a
   02C9 DD 36 FC 00   [19]  231 	ld	-4 (ix),#0x00
   02CD 3E 06         [ 7]  232 	ld	a,#0x05+1
   02CF 18 08         [12]  233 	jr	00317$
   02D1                     234 00316$:
   02D1 DD CB FB 26   [23]  235 	sla	-5 (ix)
   02D5 DD CB FC 16   [23]  236 	rl	-4 (ix)
   02D9                     237 00317$:
   02D9 3D            [ 4]  238 	dec	a
   02DA 20 F5         [12]  239 	jr	NZ,00316$
   02DC DD 7E FB      [19]  240 	ld	a,-5 (ix)
   02DF C6 00         [ 7]  241 	add	a, #0x00
   02E1 DD 77 FE      [19]  242 	ld	-2 (ix),a
   02E4 DD 7E FC      [19]  243 	ld	a,-4 (ix)
   02E7 CE 60         [ 7]  244 	adc	a, #0x60
   02E9 DD 77 FF      [19]  245 	ld	-1 (ix),a
   02EC DD 6E FE      [19]  246 	ld	l,-2 (ix)
   02EF DD 66 FF      [19]  247 	ld	h,-1 (ix)
   02F2 36 81         [10]  248 	ld	(hl),#0x81
                            249 ;src/Map.c:72: map[i][MAP_WIDTH-1]=CELLTYPE_WALL1;//get_random_wall();
   02F4 DD 7E FB      [19]  250 	ld	a,-5 (ix)
   02F7 C6 00         [ 7]  251 	add	a, #0x00
   02F9 DD 77 FE      [19]  252 	ld	-2 (ix),a
   02FC DD 7E FC      [19]  253 	ld	a,-4 (ix)
   02FF CE 60         [ 7]  254 	adc	a, #0x60
   0301 DD 77 FF      [19]  255 	ld	-1 (ix),a
   0304 DD 7E FE      [19]  256 	ld	a,-2 (ix)
   0307 C6 1F         [ 7]  257 	add	a, #0x1F
   0309 DD 77 FE      [19]  258 	ld	-2 (ix),a
   030C DD 7E FF      [19]  259 	ld	a,-1 (ix)
   030F CE 00         [ 7]  260 	adc	a, #0x00
   0311 DD 77 FF      [19]  261 	ld	-1 (ix),a
   0314 DD 6E FE      [19]  262 	ld	l,-2 (ix)
   0317 DD 66 FF      [19]  263 	ld	h,-1 (ix)
   031A 36 81         [10]  264 	ld	(hl),#0x81
                            265 ;src/Map.c:70: for(i=1;i<MAP_HEIGHT-1;++i){
   031C DD 34 F2      [23]  266 	inc	-14 (ix)
   031F DD 7E F2      [19]  267 	ld	a,-14 (ix)
   0322 D6 1F         [ 7]  268 	sub	a, #0x1F
   0324 38 9D         [12]  269 	jr	C,00169$
                            270 ;src/Map.c:75: while(remainingCells>0){
   0326 21 04 00      [10]  271 	ld	hl,#0x0004
   0329 39            [11]  272 	add	hl,sp
   032A DD 75 FE      [19]  273 	ld	-2 (ix),l
   032D DD 74 FF      [19]  274 	ld	-1 (ix),h
   0330                     275 00164$:
   0330 DD 7E F5      [19]  276 	ld	a,-11 (ix)
   0333 DD B6 F4      [19]  277 	or	a,-12 (ix)
   0336 CA FE 06      [10]  278 	jp	Z,00171$
                            279 ;src/Map.c:76: wallListPosition = wallList+wallListCount;
   0339 C1            [10]  280 	pop	bc
   033A E1            [10]  281 	pop	hl
   033B E5            [11]  282 	push	hl
   033C C5            [11]  283 	push	bc
   033D 29            [11]  284 	add	hl, hl
   033E 7D            [ 4]  285 	ld	a,l
   033F C6 00         [ 7]  286 	add	a, #0x00
   0341 DD 77 FB      [19]  287 	ld	-5 (ix),a
   0344 7C            [ 4]  288 	ld	a,h
   0345 CE 68         [ 7]  289 	adc	a, #0x68
   0347 DD 77 FC      [19]  290 	ld	-4 (ix),a
                            291 ;src/Map.c:77: while(wallListCount<MAP_SIZE){
   034A D1            [10]  292 	pop	de
   034B C1            [10]  293 	pop	bc
   034C C5            [11]  294 	push	bc
   034D D5            [11]  295 	push	de
   034E                     296 00134$:
                            297 ;src/Map.c:80: currentPos.y = (*wallListPosition).y;
   034E DD 7E FE      [19]  298 	ld	a,-2 (ix)
   0351 C6 01         [ 7]  299 	add	a, #0x01
   0353 DD 77 F9      [19]  300 	ld	-7 (ix),a
   0356 DD 7E FF      [19]  301 	ld	a,-1 (ix)
   0359 CE 00         [ 7]  302 	adc	a, #0x00
   035B DD 77 FA      [19]  303 	ld	-6 (ix),a
                            304 ;src/Map.c:77: while(wallListCount<MAP_SIZE){
   035E 78            [ 4]  305 	ld	a,b
   035F D6 04         [ 7]  306 	sub	a, #0x04
   0361 D2 FF 04      [10]  307 	jp	NC,00204$
                            308 ;src/Map.c:79: currentPos.x = (*wallListPosition).x;
   0364 21 04 00      [10]  309 	ld	hl,#0x0004
   0367 39            [11]  310 	add	hl,sp
   0368 EB            [ 4]  311 	ex	de,hl
   0369 DD 6E FB      [19]  312 	ld	l,-5 (ix)
   036C DD 66 FC      [19]  313 	ld	h,-4 (ix)
   036F 7E            [ 7]  314 	ld	a,(hl)
   0370 12            [ 7]  315 	ld	(de),a
                            316 ;src/Map.c:80: currentPos.y = (*wallListPosition).y;
   0371 DD 5E FB      [19]  317 	ld	e,-5 (ix)
   0374 DD 56 FC      [19]  318 	ld	d,-4 (ix)
   0377 13            [ 6]  319 	inc	de
   0378 1A            [ 7]  320 	ld	a,(de)
   0379 DD 6E F9      [19]  321 	ld	l,-7 (ix)
   037C DD 66 FA      [19]  322 	ld	h,-6 (ix)
   037F 77            [ 7]  323 	ld	(hl),a
                            324 ;src/Map.c:82: convertToFloor=0;
   0380 DD 36 F3 00   [19]  325 	ld	-13 (ix),#0x00
                            326 ;src/Map.c:83: surroundedByWalls=1;
   0384 DD 36 F1 01   [19]  327 	ld	-15 (ix),#0x01
                            328 ;src/Map.c:85: if(currentPos.x>0){
   0388 DD 6E FE      [19]  329 	ld	l,-2 (ix)
   038B DD 66 FF      [19]  330 	ld	h,-1 (ix)
   038E 7E            [ 7]  331 	ld	a,(hl)
   038F DD 77 FD      [19]  332 	ld	-3 (ix),a
                            333 ;src/Map.c:86: adjacentType = map[currentPos.x-1][currentPos.y];
   0392 DD 6E F9      [19]  334 	ld	l,-7 (ix)
   0395 DD 66 FA      [19]  335 	ld	h,-6 (ix)
   0398 7E            [ 7]  336 	ld	a,(hl)
   0399 DD 77 F8      [19]  337 	ld	-8 (ix),a
   039C DD 7E FD      [19]  338 	ld	a,-3 (ix)
   039F DD 77 F6      [19]  339 	ld	-10 (ix),a
   03A2 DD 36 F7 00   [19]  340 	ld	-9 (ix),#0x00
                            341 ;src/Map.c:85: if(currentPos.x>0){
   03A6 DD 7E FD      [19]  342 	ld	a,-3 (ix)
   03A9 B7            [ 4]  343 	or	a, a
   03AA 28 2F         [12]  344 	jr	Z,00109$
                            345 ;src/Map.c:86: adjacentType = map[currentPos.x-1][currentPos.y];
   03AC DD 6E F6      [19]  346 	ld	l,-10 (ix)
   03AF DD 66 F7      [19]  347 	ld	h,-9 (ix)
   03B2 2B            [ 6]  348 	dec	hl
   03B3 29            [11]  349 	add	hl, hl
   03B4 29            [11]  350 	add	hl, hl
   03B5 29            [11]  351 	add	hl, hl
   03B6 29            [11]  352 	add	hl, hl
   03B7 29            [11]  353 	add	hl, hl
   03B8 D5            [11]  354 	push	de
   03B9 11 00 60      [10]  355 	ld	de,#0x6000
   03BC 19            [11]  356 	add	hl, de
   03BD D1            [10]  357 	pop	de
   03BE 7D            [ 4]  358 	ld	a,l
   03BF DD 86 F8      [19]  359 	add	a, -8 (ix)
   03C2 6F            [ 4]  360 	ld	l,a
   03C3 7C            [ 4]  361 	ld	a,h
   03C4 CE 00         [ 7]  362 	adc	a, #0x00
   03C6 67            [ 4]  363 	ld	h,a
   03C7 6E            [ 7]  364 	ld	l,(hl)
                            365 ;src/Map.c:87: if(adjacentType == CELLTYPE_UNDEFINED){
   03C8 7D            [ 4]  366 	ld	a,l
   03C9 D6 87         [ 7]  367 	sub	a, #0x87
   03CB 20 06         [12]  368 	jr	NZ,00106$
                            369 ;src/Map.c:88: convertToFloor  = 1;
   03CD DD 36 F3 01   [19]  370 	ld	-13 (ix),#0x01
   03D1 18 08         [12]  371 	jr	00109$
   03D3                     372 00106$:
                            373 ;src/Map.c:90: else if(adjacentType == CELLTYPE_FLOOR){
   03D3 7D            [ 4]  374 	ld	a,l
   03D4 B7            [ 4]  375 	or	a, a
   03D5 20 04         [12]  376 	jr	NZ,00109$
                            377 ;src/Map.c:91: surroundedByWalls = 0;
   03D7 DD 36 F1 00   [19]  378 	ld	-15 (ix),#0x00
   03DB                     379 00109$:
                            380 ;src/Map.c:94: if(currentPos.x < (MAP_WIDTH-1)){
   03DB DD 7E FD      [19]  381 	ld	a,-3 (ix)
   03DE D6 1F         [ 7]  382 	sub	a, #0x1F
   03E0 30 2F         [12]  383 	jr	NC,00116$
                            384 ;src/Map.c:96: adjacentType = map[currentPos.x+1][currentPos.y];
   03E2 DD 6E F6      [19]  385 	ld	l,-10 (ix)
   03E5 DD 66 F7      [19]  386 	ld	h,-9 (ix)
   03E8 23            [ 6]  387 	inc	hl
   03E9 29            [11]  388 	add	hl, hl
   03EA 29            [11]  389 	add	hl, hl
   03EB 29            [11]  390 	add	hl, hl
   03EC 29            [11]  391 	add	hl, hl
   03ED 29            [11]  392 	add	hl, hl
   03EE D5            [11]  393 	push	de
   03EF 11 00 60      [10]  394 	ld	de,#0x6000
   03F2 19            [11]  395 	add	hl, de
   03F3 D1            [10]  396 	pop	de
   03F4 7D            [ 4]  397 	ld	a,l
   03F5 DD 86 F8      [19]  398 	add	a, -8 (ix)
   03F8 6F            [ 4]  399 	ld	l,a
   03F9 7C            [ 4]  400 	ld	a,h
   03FA CE 00         [ 7]  401 	adc	a, #0x00
   03FC 67            [ 4]  402 	ld	h,a
   03FD 6E            [ 7]  403 	ld	l,(hl)
                            404 ;src/Map.c:97: if(adjacentType == CELLTYPE_UNDEFINED){
   03FE 7D            [ 4]  405 	ld	a,l
   03FF D6 87         [ 7]  406 	sub	a, #0x87
   0401 20 06         [12]  407 	jr	NZ,00113$
                            408 ;src/Map.c:98: convertToFloor  = 1;
   0403 DD 36 F3 01   [19]  409 	ld	-13 (ix),#0x01
   0407 18 08         [12]  410 	jr	00116$
   0409                     411 00113$:
                            412 ;src/Map.c:100: else if(adjacentType == CELLTYPE_FLOOR){
   0409 7D            [ 4]  413 	ld	a,l
   040A B7            [ 4]  414 	or	a, a
   040B 20 04         [12]  415 	jr	NZ,00116$
                            416 ;src/Map.c:101: surroundedByWalls = 0;
   040D DD 36 F1 00   [19]  417 	ld	-15 (ix),#0x00
   0411                     418 00116$:
                            419 ;src/Map.c:106: adjacentType = map[currentPos.x][currentPos.y-1];
   0411 DD 6E F6      [19]  420 	ld	l,-10 (ix)
   0414 DD 66 F7      [19]  421 	ld	h,-9 (ix)
   0417 29            [11]  422 	add	hl, hl
   0418 29            [11]  423 	add	hl, hl
   0419 29            [11]  424 	add	hl, hl
   041A 29            [11]  425 	add	hl, hl
   041B 29            [11]  426 	add	hl, hl
   041C 7D            [ 4]  427 	ld	a,l
   041D C6 00         [ 7]  428 	add	a, #0x00
   041F DD 77 F6      [19]  429 	ld	-10 (ix),a
   0422 7C            [ 4]  430 	ld	a,h
   0423 CE 60         [ 7]  431 	adc	a, #0x60
   0425 DD 77 F7      [19]  432 	ld	-9 (ix),a
                            433 ;src/Map.c:104: if(currentPos.y > 0){
   0428 DD 7E F8      [19]  434 	ld	a,-8 (ix)
   042B B7            [ 4]  435 	or	a, a
   042C 28 23         [12]  436 	jr	Z,00123$
                            437 ;src/Map.c:106: adjacentType = map[currentPos.x][currentPos.y-1];
   042E DD 6E F8      [19]  438 	ld	l,-8 (ix)
   0431 2D            [ 4]  439 	dec	l
   0432 DD 7E F6      [19]  440 	ld	a,-10 (ix)
   0435 85            [ 4]  441 	add	a, l
   0436 6F            [ 4]  442 	ld	l,a
   0437 DD 7E F7      [19]  443 	ld	a,-9 (ix)
   043A CE 00         [ 7]  444 	adc	a, #0x00
   043C 67            [ 4]  445 	ld	h,a
   043D 6E            [ 7]  446 	ld	l,(hl)
                            447 ;src/Map.c:107: if(adjacentType == CELLTYPE_UNDEFINED){
   043E 7D            [ 4]  448 	ld	a,l
   043F D6 87         [ 7]  449 	sub	a, #0x87
   0441 20 06         [12]  450 	jr	NZ,00120$
                            451 ;src/Map.c:108: convertToFloor  = 1;
   0443 DD 36 F3 01   [19]  452 	ld	-13 (ix),#0x01
   0447 18 08         [12]  453 	jr	00123$
   0449                     454 00120$:
                            455 ;src/Map.c:110: else if(adjacentType == CELLTYPE_FLOOR){
   0449 7D            [ 4]  456 	ld	a,l
   044A B7            [ 4]  457 	or	a, a
   044B 20 04         [12]  458 	jr	NZ,00123$
                            459 ;src/Map.c:111: surroundedByWalls = 0;
   044D DD 36 F1 00   [19]  460 	ld	-15 (ix),#0x00
   0451                     461 00123$:
                            462 ;src/Map.c:114: if(currentPos.y < (MAP_HEIGHT-1)){
   0451 DD 7E F8      [19]  463 	ld	a,-8 (ix)
   0454 D6 1F         [ 7]  464 	sub	a, #0x1F
   0456 30 23         [12]  465 	jr	NC,00130$
                            466 ;src/Map.c:116: adjacentType = map[currentPos.x][currentPos.y+1];
   0458 DD 6E F8      [19]  467 	ld	l,-8 (ix)
   045B 2C            [ 4]  468 	inc	l
   045C DD 7E F6      [19]  469 	ld	a,-10 (ix)
   045F 85            [ 4]  470 	add	a, l
   0460 6F            [ 4]  471 	ld	l,a
   0461 DD 7E F7      [19]  472 	ld	a,-9 (ix)
   0464 CE 00         [ 7]  473 	adc	a, #0x00
   0466 67            [ 4]  474 	ld	h,a
   0467 6E            [ 7]  475 	ld	l,(hl)
                            476 ;src/Map.c:117: if(adjacentType == CELLTYPE_UNDEFINED){
   0468 7D            [ 4]  477 	ld	a,l
   0469 D6 87         [ 7]  478 	sub	a, #0x87
   046B 20 06         [12]  479 	jr	NZ,00127$
                            480 ;src/Map.c:118: convertToFloor  = 1;
   046D DD 36 F3 01   [19]  481 	ld	-13 (ix),#0x01
   0471 18 08         [12]  482 	jr	00130$
   0473                     483 00127$:
                            484 ;src/Map.c:120: else if(adjacentType == CELLTYPE_FLOOR){
   0473 7D            [ 4]  485 	ld	a,l
   0474 B7            [ 4]  486 	or	a, a
   0475 20 04         [12]  487 	jr	NZ,00130$
                            488 ;src/Map.c:121: surroundedByWalls = 0;
   0477 DD 36 F1 00   [19]  489 	ld	-15 (ix),#0x00
   047B                     490 00130$:
                            491 ;src/Map.c:125: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   047B 69            [ 4]  492 	ld	l, c
   047C 60            [ 4]  493 	ld	h, b
   047D 29            [11]  494 	add	hl, hl
   047E FD 21 00 68   [14]  495 	ld	iy,#0x6800
   0482 C5            [11]  496 	push	bc
   0483 4D            [ 4]  497 	ld	c, l
   0484 44            [ 4]  498 	ld	b, h
   0485 FD 09         [15]  499 	add	iy, bc
   0487 C1            [10]  500 	pop	bc
   0488 FD 7E 00      [19]  501 	ld	a, 0 (iy)
   048B DD 6E FB      [19]  502 	ld	l,-5 (ix)
   048E DD 66 FC      [19]  503 	ld	h,-4 (ix)
   0491 77            [ 7]  504 	ld	(hl),a
                            505 ;src/Map.c:126: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   0492 FD E5         [15]  506 	push	iy
   0494 E1            [10]  507 	pop	hl
   0495 23            [ 6]  508 	inc	hl
   0496 7E            [ 7]  509 	ld	a,(hl)
   0497 12            [ 7]  510 	ld	(de),a
                            511 ;src/Map.c:127: --wallListCount;
   0498 0B            [ 6]  512 	dec	bc
   0499 DD 71 ED      [19]  513 	ld	-19 (ix),c
   049C DD 70 EE      [19]  514 	ld	-18 (ix),b
                            515 ;src/Map.c:130: if((convertToFloor)&&(!surroundedByWalls)){
   049F DD 7E F3      [19]  516 	ld	a,-13 (ix)
   04A2 B7            [ 4]  517 	or	a, a
   04A3 28 49         [12]  518 	jr	Z,00132$
   04A5 DD 7E F1      [19]  519 	ld	a,-15 (ix)
   04A8 B7            [ 4]  520 	or	a, a
   04A9 20 43         [12]  521 	jr	NZ,00132$
                            522 ;src/Map.c:131: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   04AB DD 6E FE      [19]  523 	ld	l,-2 (ix)
   04AE DD 66 FF      [19]  524 	ld	h,-1 (ix)
   04B1 6E            [ 7]  525 	ld	l,(hl)
   04B2 26 00         [ 7]  526 	ld	h,#0x00
   04B4 29            [11]  527 	add	hl, hl
   04B5 29            [11]  528 	add	hl, hl
   04B6 29            [11]  529 	add	hl, hl
   04B7 29            [11]  530 	add	hl, hl
   04B8 29            [11]  531 	add	hl, hl
   04B9 01 00 60      [10]  532 	ld	bc,#0x6000
   04BC 09            [11]  533 	add	hl,bc
   04BD 4D            [ 4]  534 	ld	c,l
   04BE 44            [ 4]  535 	ld	b,h
   04BF DD 6E F9      [19]  536 	ld	l,-7 (ix)
   04C2 DD 66 FA      [19]  537 	ld	h,-6 (ix)
   04C5 6E            [ 7]  538 	ld	l, (hl)
   04C6 26 00         [ 7]  539 	ld	h,#0x00
   04C8 09            [11]  540 	add	hl,bc
   04C9 36 00         [10]  541 	ld	(hl),#0x00
                            542 ;src/Map.c:133: ++lastStackItem;
   04CB DD 34 EB      [23]  543 	inc	-21 (ix)
   04CE 20 03         [12]  544 	jr	NZ,00326$
   04D0 DD 34 EC      [23]  545 	inc	-20 (ix)
   04D3                     546 00326$:
                            547 ;src/Map.c:134: (*(cellStack+lastStackItem)).x = currentPos.x;
   04D3 E1            [10]  548 	pop	hl
   04D4 E5            [11]  549 	push	hl
   04D5 29            [11]  550 	add	hl, hl
   04D6 4D            [ 4]  551 	ld	c, l
   04D7 7C            [ 4]  552 	ld	a,h
   04D8 C6 64         [ 7]  553 	add	a,#0x64
   04DA 47            [ 4]  554 	ld	b,a
   04DB DD 6E FE      [19]  555 	ld	l,-2 (ix)
   04DE DD 66 FF      [19]  556 	ld	h,-1 (ix)
   04E1 7E            [ 7]  557 	ld	a,(hl)
   04E2 02            [ 7]  558 	ld	(bc),a
                            559 ;src/Map.c:135: (*(cellStack+lastStackItem)).y = currentPos.y;
   04E3 03            [ 6]  560 	inc	bc
   04E4 DD 6E F9      [19]  561 	ld	l,-7 (ix)
   04E7 DD 66 FA      [19]  562 	ld	h,-6 (ix)
   04EA 7E            [ 7]  563 	ld	a,(hl)
   04EB 02            [ 7]  564 	ld	(bc),a
                            565 ;src/Map.c:138: break;
   04EC 18 11         [12]  566 	jr	00204$
   04EE                     567 00132$:
                            568 ;src/Map.c:140: --wallListPosition;
   04EE DD 6E FB      [19]  569 	ld	l,-5 (ix)
   04F1 DD 66 FC      [19]  570 	ld	h,-4 (ix)
   04F4 2B            [ 6]  571 	dec	hl
   04F5 2B            [ 6]  572 	dec	hl
   04F6 DD 75 FB      [19]  573 	ld	-5 (ix),l
   04F9 DD 74 FC      [19]  574 	ld	-4 (ix),h
   04FC C3 4E 03      [10]  575 	jp	00134$
                            576 ;src/Map.c:142: while(lastStackItem<MAP_SIZE){
   04FF                     577 00204$:
   04FF DD 7E F4      [19]  578 	ld	a,-12 (ix)
   0502 DD 77 F6      [19]  579 	ld	-10 (ix),a
   0505 DD 7E F5      [19]  580 	ld	a,-11 (ix)
   0508 DD 77 F7      [19]  581 	ld	-9 (ix),a
   050B DD 7E ED      [19]  582 	ld	a,-19 (ix)
   050E DD 77 FB      [19]  583 	ld	-5 (ix),a
   0511 DD 7E EE      [19]  584 	ld	a,-18 (ix)
   0514 DD 77 FC      [19]  585 	ld	-4 (ix),a
   0517                     586 00161$:
   0517 DD 7E EC      [19]  587 	ld	a,-20 (ix)
   051A D6 04         [ 7]  588 	sub	a, #0x04
   051C D2 30 03      [10]  589 	jp	NC,00164$
                            590 ;src/Map.c:143: currentPos.x=(*(lastStackItem+cellStack)).x;
   051F 21 04 00      [10]  591 	ld	hl,#0x0004
   0522 39            [11]  592 	add	hl,sp
   0523 4D            [ 4]  593 	ld	c,l
   0524 44            [ 4]  594 	ld	b,h
   0525 E1            [10]  595 	pop	hl
   0526 E5            [11]  596 	push	hl
   0527 29            [11]  597 	add	hl, hl
   0528 FD 21 00 64   [14]  598 	ld	iy,#0x6400
   052C EB            [ 4]  599 	ex	de,hl
   052D FD 19         [15]  600 	add	iy, de
   052F FD 7E 00      [19]  601 	ld	a, 0 (iy)
   0532 02            [ 7]  602 	ld	(bc),a
                            603 ;src/Map.c:144: currentPos.y=(*(lastStackItem+cellStack)).y;
   0533 FD 4E 01      [19]  604 	ld	c,1 (iy)
   0536 DD 6E F9      [19]  605 	ld	l,-7 (ix)
   0539 DD 66 FA      [19]  606 	ld	h,-6 (ix)
   053C 71            [ 7]  607 	ld	(hl),c
                            608 ;src/Map.c:145: --lastStackItem;
   053D E1            [10]  609 	pop	hl
   053E E5            [11]  610 	push	hl
   053F 2B            [ 6]  611 	dec	hl
   0540 E3            [19]  612 	ex	(sp), hl
                            613 ;src/Map.c:146: cellType = map[currentPos.x][currentPos.y];
   0541 DD 6E FE      [19]  614 	ld	l,-2 (ix)
   0544 DD 66 FF      [19]  615 	ld	h,-1 (ix)
   0547 6E            [ 7]  616 	ld	l,(hl)
   0548 26 00         [ 7]  617 	ld	h,#0x00
   054A 29            [11]  618 	add	hl, hl
   054B 29            [11]  619 	add	hl, hl
   054C 29            [11]  620 	add	hl, hl
   054D 29            [11]  621 	add	hl, hl
   054E 29            [11]  622 	add	hl, hl
   054F 11 00 60      [10]  623 	ld	de,#0x6000
   0552 19            [11]  624 	add	hl,de
   0553 59            [ 4]  625 	ld	e,c
   0554 16 00         [ 7]  626 	ld	d,#0x00
   0556 19            [11]  627 	add	hl,de
   0557 4E            [ 7]  628 	ld	c,(hl)
                            629 ;src/Map.c:148: if(cellType == CELLTYPE_UNDEFINED){
   0558 79            [ 4]  630 	ld	a,c
   0559 D6 87         [ 7]  631 	sub	a, #0x87
   055B 20 47         [12]  632 	jr	NZ,00141$
                            633 ;src/Map.c:150: if(cpct_getRandom_lcg_u8()&1){//WALL
   055D CD F7 42      [17]  634 	call	_cpct_getRandom_lcg_u8
   0560 CB 45         [ 8]  635 	bit	0, l
   0562 28 06         [12]  636 	jr	Z,00138$
                            637 ;src/Map.c:151: cellType = get_random_wall();
   0564 CD C0 01      [17]  638 	call	_get_random_wall
   0567 4D            [ 4]  639 	ld	c,l
   0568 18 02         [12]  640 	jr	00139$
   056A                     641 00138$:
                            642 ;src/Map.c:154: cellType = CELLTYPE_FLOOR;
   056A 0E 00         [ 7]  643 	ld	c,#0x00
   056C                     644 00139$:
                            645 ;src/Map.c:156: map[currentPos.x][currentPos.y]=cellType;
   056C DD 6E FE      [19]  646 	ld	l,-2 (ix)
   056F DD 66 FF      [19]  647 	ld	h,-1 (ix)
   0572 6E            [ 7]  648 	ld	l,(hl)
   0573 26 00         [ 7]  649 	ld	h,#0x00
   0575 29            [11]  650 	add	hl, hl
   0576 29            [11]  651 	add	hl, hl
   0577 29            [11]  652 	add	hl, hl
   0578 29            [11]  653 	add	hl, hl
   0579 29            [11]  654 	add	hl, hl
   057A EB            [ 4]  655 	ex	de,hl
   057B 21 00 60      [10]  656 	ld	hl,#0x6000
   057E 19            [11]  657 	add	hl,de
   057F EB            [ 4]  658 	ex	de,hl
   0580 DD 6E F9      [19]  659 	ld	l,-7 (ix)
   0583 DD 66 FA      [19]  660 	ld	h,-6 (ix)
   0586 6E            [ 7]  661 	ld	l, (hl)
   0587 26 00         [ 7]  662 	ld	h,#0x00
   0589 19            [11]  663 	add	hl,de
   058A 71            [ 7]  664 	ld	(hl),c
                            665 ;src/Map.c:157: --remainingCells;
   058B DD 6E F6      [19]  666 	ld	l,-10 (ix)
   058E DD 66 F7      [19]  667 	ld	h,-9 (ix)
   0591 2B            [ 6]  668 	dec	hl
   0592 DD 75 F6      [19]  669 	ld	-10 (ix),l
   0595 DD 74 F7      [19]  670 	ld	-9 (ix),h
   0598 DD 7E F6      [19]  671 	ld	a,-10 (ix)
   059B DD 77 F4      [19]  672 	ld	-12 (ix),a
   059E DD 7E F7      [19]  673 	ld	a,-9 (ix)
   05A1 DD 77 F5      [19]  674 	ld	-11 (ix),a
   05A4                     675 00141$:
                            676 ;src/Map.c:85: if(currentPos.x>0){
   05A4 DD 6E FE      [19]  677 	ld	l,-2 (ix)
   05A7 DD 66 FF      [19]  678 	ld	h,-1 (ix)
   05AA 7E            [ 7]  679 	ld	a,(hl)
   05AB DD 77 F8      [19]  680 	ld	-8 (ix),a
                            681 ;src/Map.c:160: if((cellType == CELLTYPE_FLOOR)){
   05AE 79            [ 4]  682 	ld	a,c
   05AF B7            [ 4]  683 	or	a, a
   05B0 C2 CD 06      [10]  684 	jp	NZ,00159$
                            685 ;src/Map.c:161: if(currentPos.x>0){
   05B3 DD 7E F8      [19]  686 	ld	a,-8 (ix)
   05B6 B7            [ 4]  687 	or	a, a
   05B7 28 3F         [12]  688 	jr	Z,00145$
                            689 ;src/Map.c:162: adjacentType = map[currentPos.x-1][currentPos.y];
   05B9 DD 6E F8      [19]  690 	ld	l,-8 (ix)
   05BC 26 00         [ 7]  691 	ld	h,#0x00
   05BE 2B            [ 6]  692 	dec	hl
   05BF 29            [11]  693 	add	hl, hl
   05C0 29            [11]  694 	add	hl, hl
   05C1 29            [11]  695 	add	hl, hl
   05C2 29            [11]  696 	add	hl, hl
   05C3 29            [11]  697 	add	hl, hl
   05C4 01 00 60      [10]  698 	ld	bc,#0x6000
   05C7 09            [11]  699 	add	hl,bc
   05C8 4D            [ 4]  700 	ld	c,l
   05C9 44            [ 4]  701 	ld	b,h
   05CA DD 6E F9      [19]  702 	ld	l,-7 (ix)
   05CD DD 66 FA      [19]  703 	ld	h,-6 (ix)
   05D0 6E            [ 7]  704 	ld	l, (hl)
   05D1 26 00         [ 7]  705 	ld	h,#0x00
   05D3 09            [11]  706 	add	hl,bc
   05D4 7E            [ 7]  707 	ld	a,(hl)
                            708 ;src/Map.c:163: if(adjacentType == CELLTYPE_UNDEFINED){
   05D5 D6 87         [ 7]  709 	sub	a, #0x87
   05D7 20 1F         [12]  710 	jr	NZ,00145$
                            711 ;src/Map.c:165: ++lastStackItem;
   05D9 DD 34 EB      [23]  712 	inc	-21 (ix)
   05DC 20 03         [12]  713 	jr	NZ,00332$
   05DE DD 34 EC      [23]  714 	inc	-20 (ix)
   05E1                     715 00332$:
                            716 ;src/Map.c:166: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   05E1 E1            [10]  717 	pop	hl
   05E2 E5            [11]  718 	push	hl
   05E3 29            [11]  719 	add	hl, hl
   05E4 01 00 64      [10]  720 	ld	bc,#0x6400
   05E7 09            [11]  721 	add	hl,bc
   05E8 DD 4E F8      [19]  722 	ld	c,-8 (ix)
   05EB 0D            [ 4]  723 	dec	c
   05EC 71            [ 7]  724 	ld	(hl),c
                            725 ;src/Map.c:167: (*(cellStack+lastStackItem)).y = currentPos.y;
   05ED 23            [ 6]  726 	inc	hl
   05EE 4D            [ 4]  727 	ld	c,l
   05EF 44            [ 4]  728 	ld	b,h
   05F0 DD 6E F9      [19]  729 	ld	l,-7 (ix)
   05F3 DD 66 FA      [19]  730 	ld	h,-6 (ix)
   05F6 7E            [ 7]  731 	ld	a,(hl)
   05F7 02            [ 7]  732 	ld	(bc),a
   05F8                     733 00145$:
                            734 ;src/Map.c:171: if(currentPos.x < (MAP_WIDTH-1)){
   05F8 DD 6E FE      [19]  735 	ld	l,-2 (ix)
   05FB DD 66 FF      [19]  736 	ld	h,-1 (ix)
   05FE 4E            [ 7]  737 	ld	c,(hl)
   05FF 79            [ 4]  738 	ld	a,c
   0600 D6 1F         [ 7]  739 	sub	a, #0x1F
   0602 30 3A         [12]  740 	jr	NC,00149$
                            741 ;src/Map.c:173: adjacentType = map[currentPos.x+1][currentPos.y];
   0604 69            [ 4]  742 	ld	l,c
   0605 26 00         [ 7]  743 	ld	h,#0x00
   0607 23            [ 6]  744 	inc	hl
   0608 29            [11]  745 	add	hl, hl
   0609 29            [11]  746 	add	hl, hl
   060A 29            [11]  747 	add	hl, hl
   060B 29            [11]  748 	add	hl, hl
   060C 29            [11]  749 	add	hl, hl
   060D EB            [ 4]  750 	ex	de,hl
   060E 21 00 60      [10]  751 	ld	hl,#0x6000
   0611 19            [11]  752 	add	hl,de
   0612 EB            [ 4]  753 	ex	de,hl
   0613 DD 6E F9      [19]  754 	ld	l,-7 (ix)
   0616 DD 66 FA      [19]  755 	ld	h,-6 (ix)
   0619 6E            [ 7]  756 	ld	l, (hl)
   061A 26 00         [ 7]  757 	ld	h,#0x00
   061C 19            [11]  758 	add	hl,de
   061D 7E            [ 7]  759 	ld	a,(hl)
                            760 ;src/Map.c:174: if(adjacentType == CELLTYPE_UNDEFINED){
   061E D6 87         [ 7]  761 	sub	a, #0x87
   0620 20 1C         [12]  762 	jr	NZ,00149$
                            763 ;src/Map.c:177: ++lastStackItem;
   0622 DD 34 EB      [23]  764 	inc	-21 (ix)
   0625 20 03         [12]  765 	jr	NZ,00335$
   0627 DD 34 EC      [23]  766 	inc	-20 (ix)
   062A                     767 00335$:
                            768 ;src/Map.c:178: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   062A E1            [10]  769 	pop	hl
   062B E5            [11]  770 	push	hl
   062C 29            [11]  771 	add	hl, hl
   062D 11 00 64      [10]  772 	ld	de,#0x6400
   0630 19            [11]  773 	add	hl,de
   0631 0C            [ 4]  774 	inc	c
   0632 71            [ 7]  775 	ld	(hl),c
                            776 ;src/Map.c:179: (*(cellStack+lastStackItem)).y = currentPos.y;
   0633 23            [ 6]  777 	inc	hl
   0634 4D            [ 4]  778 	ld	c,l
   0635 44            [ 4]  779 	ld	b,h
   0636 DD 6E F9      [19]  780 	ld	l,-7 (ix)
   0639 DD 66 FA      [19]  781 	ld	h,-6 (ix)
   063C 7E            [ 7]  782 	ld	a,(hl)
   063D 02            [ 7]  783 	ld	(bc),a
   063E                     784 00149$:
                            785 ;src/Map.c:86: adjacentType = map[currentPos.x-1][currentPos.y];
   063E DD 6E F9      [19]  786 	ld	l,-7 (ix)
   0641 DD 66 FA      [19]  787 	ld	h,-6 (ix)
   0644 4E            [ 7]  788 	ld	c,(hl)
                            789 ;src/Map.c:183: if(currentPos.y > 0){
   0645 79            [ 4]  790 	ld	a,c
   0646 B7            [ 4]  791 	or	a, a
   0647 28 3A         [12]  792 	jr	Z,00153$
                            793 ;src/Map.c:185: adjacentType = map[currentPos.x][currentPos.y-1];
   0649 DD 6E FE      [19]  794 	ld	l,-2 (ix)
   064C DD 66 FF      [19]  795 	ld	h,-1 (ix)
   064F 46            [ 7]  796 	ld	b,(hl)
   0650 68            [ 4]  797 	ld	l,b
   0651 26 00         [ 7]  798 	ld	h,#0x00
   0653 29            [11]  799 	add	hl, hl
   0654 29            [11]  800 	add	hl, hl
   0655 29            [11]  801 	add	hl, hl
   0656 29            [11]  802 	add	hl, hl
   0657 29            [11]  803 	add	hl, hl
   0658 11 00 60      [10]  804 	ld	de,#0x6000
   065B 19            [11]  805 	add	hl,de
   065C 0D            [ 4]  806 	dec	c
   065D 59            [ 4]  807 	ld	e,c
   065E 16 00         [ 7]  808 	ld	d,#0x00
   0660 19            [11]  809 	add	hl,de
   0661 7E            [ 7]  810 	ld	a,(hl)
                            811 ;src/Map.c:186: if(adjacentType == CELLTYPE_UNDEFINED){
   0662 D6 87         [ 7]  812 	sub	a, #0x87
   0664 20 1D         [12]  813 	jr	NZ,00153$
                            814 ;src/Map.c:189: ++lastStackItem;
   0666 DD 34 EB      [23]  815 	inc	-21 (ix)
   0669 20 03         [12]  816 	jr	NZ,00338$
   066B DD 34 EC      [23]  817 	inc	-20 (ix)
   066E                     818 00338$:
                            819 ;src/Map.c:190: (*(cellStack+lastStackItem)).x = currentPos.x;
   066E E1            [10]  820 	pop	hl
   066F E5            [11]  821 	push	hl
   0670 29            [11]  822 	add	hl, hl
   0671 11 00 64      [10]  823 	ld	de,#0x6400
   0674 19            [11]  824 	add	hl,de
   0675 70            [ 7]  825 	ld	(hl),b
                            826 ;src/Map.c:191: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   0676 23            [ 6]  827 	inc	hl
   0677 4D            [ 4]  828 	ld	c,l
   0678 44            [ 4]  829 	ld	b,h
   0679 DD 6E F9      [19]  830 	ld	l,-7 (ix)
   067C DD 66 FA      [19]  831 	ld	h,-6 (ix)
   067F 5E            [ 7]  832 	ld	e,(hl)
   0680 1D            [ 4]  833 	dec	e
   0681 7B            [ 4]  834 	ld	a,e
   0682 02            [ 7]  835 	ld	(bc),a
   0683                     836 00153$:
                            837 ;src/Map.c:86: adjacentType = map[currentPos.x-1][currentPos.y];
   0683 DD 6E F9      [19]  838 	ld	l,-7 (ix)
   0686 DD 66 FA      [19]  839 	ld	h,-6 (ix)
   0689 46            [ 7]  840 	ld	b,(hl)
                            841 ;src/Map.c:195: if(currentPos.y < (MAP_HEIGHT-1)){
   068A 78            [ 4]  842 	ld	a,b
   068B D6 1F         [ 7]  843 	sub	a, #0x1F
   068D D2 17 05      [10]  844 	jp	NC,00161$
                            845 ;src/Map.c:197: adjacentType = map[currentPos.x][currentPos.y+1];
   0690 DD 6E FE      [19]  846 	ld	l,-2 (ix)
   0693 DD 66 FF      [19]  847 	ld	h,-1 (ix)
   0696 4E            [ 7]  848 	ld	c,(hl)
   0697 69            [ 4]  849 	ld	l,c
   0698 26 00         [ 7]  850 	ld	h,#0x00
   069A 29            [11]  851 	add	hl, hl
   069B 29            [11]  852 	add	hl, hl
   069C 29            [11]  853 	add	hl, hl
   069D 29            [11]  854 	add	hl, hl
   069E 29            [11]  855 	add	hl, hl
   069F 11 00 60      [10]  856 	ld	de,#0x6000
   06A2 19            [11]  857 	add	hl,de
   06A3 04            [ 4]  858 	inc	b
   06A4 58            [ 4]  859 	ld	e,b
   06A5 16 00         [ 7]  860 	ld	d,#0x00
   06A7 19            [11]  861 	add	hl,de
   06A8 7E            [ 7]  862 	ld	a,(hl)
                            863 ;src/Map.c:198: if(adjacentType == CELLTYPE_UNDEFINED){
   06A9 D6 87         [ 7]  864 	sub	a, #0x87
   06AB C2 17 05      [10]  865 	jp	NZ,00161$
                            866 ;src/Map.c:201: ++lastStackItem;
   06AE DD 34 EB      [23]  867 	inc	-21 (ix)
   06B1 20 03         [12]  868 	jr	NZ,00341$
   06B3 DD 34 EC      [23]  869 	inc	-20 (ix)
   06B6                     870 00341$:
                            871 ;src/Map.c:202: (*(cellStack+lastStackItem)).x = currentPos.x;
   06B6 E1            [10]  872 	pop	hl
   06B7 E5            [11]  873 	push	hl
   06B8 29            [11]  874 	add	hl, hl
   06B9 11 00 64      [10]  875 	ld	de,#0x6400
   06BC 19            [11]  876 	add	hl,de
   06BD 71            [ 7]  877 	ld	(hl),c
                            878 ;src/Map.c:203: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   06BE 23            [ 6]  879 	inc	hl
   06BF 4D            [ 4]  880 	ld	c,l
   06C0 44            [ 4]  881 	ld	b,h
   06C1 DD 6E F9      [19]  882 	ld	l,-7 (ix)
   06C4 DD 66 FA      [19]  883 	ld	h,-6 (ix)
   06C7 7E            [ 7]  884 	ld	a,(hl)
   06C8 3C            [ 4]  885 	inc	a
   06C9 02            [ 7]  886 	ld	(bc),a
   06CA C3 17 05      [10]  887 	jp	00161$
   06CD                     888 00159$:
                            889 ;src/Map.c:209: ++wallListCount;
   06CD DD 34 FB      [23]  890 	inc	-5 (ix)
   06D0 20 03         [12]  891 	jr	NZ,00342$
   06D2 DD 34 FC      [23]  892 	inc	-4 (ix)
   06D5                     893 00342$:
   06D5 DD 7E FB      [19]  894 	ld	a,-5 (ix)
   06D8 DD 77 ED      [19]  895 	ld	-19 (ix),a
   06DB DD 7E FC      [19]  896 	ld	a,-4 (ix)
   06DE DD 77 EE      [19]  897 	ld	-18 (ix),a
                            898 ;src/Map.c:210: (*(wallList+wallListCount)).x = currentPos.x;
   06E1 DD 6E FB      [19]  899 	ld	l,-5 (ix)
   06E4 DD 66 FC      [19]  900 	ld	h,-4 (ix)
   06E7 29            [11]  901 	add	hl, hl
   06E8 01 00 68      [10]  902 	ld	bc,#0x6800
   06EB 09            [11]  903 	add	hl,bc
   06EC DD 7E F8      [19]  904 	ld	a,-8 (ix)
   06EF 77            [ 7]  905 	ld	(hl),a
                            906 ;src/Map.c:211: (*(wallList+wallListCount)).y = currentPos.y;
   06F0 23            [ 6]  907 	inc	hl
   06F1 4D            [ 4]  908 	ld	c,l
   06F2 44            [ 4]  909 	ld	b,h
   06F3 DD 6E F9      [19]  910 	ld	l,-7 (ix)
   06F6 DD 66 FA      [19]  911 	ld	h,-6 (ix)
   06F9 7E            [ 7]  912 	ld	a,(hl)
   06FA 02            [ 7]  913 	ld	(bc),a
   06FB C3 17 05      [10]  914 	jp	00161$
   06FE                     915 00171$:
   06FE DD F9         [10]  916 	ld	sp, ix
   0700 DD E1         [14]  917 	pop	ix
   0702 C9            [10]  918 	ret
                            919 ;src/Map.c:217: void generate_exit_door(){
                            920 ;	---------------------------------
                            921 ; Function generate_exit_door
                            922 ; ---------------------------------
   0703                     923 _generate_exit_door::
   0703 DD E5         [15]  924 	push	ix
   0705 DD 21 00 00   [14]  925 	ld	ix,#0
   0709 DD 39         [15]  926 	add	ix,sp
   070B 21 F2 FF      [10]  927 	ld	hl,#-14
   070E 39            [11]  928 	add	hl,sp
   070F F9            [ 6]  929 	ld	sp,hl
                            930 ;src/Map.c:218: u8 x=(cpct_getRandom_lcg_u8()%32);
   0710 CD F7 42      [17]  931 	call	_cpct_getRandom_lcg_u8
   0713 7D            [ 4]  932 	ld	a,l
   0714 E6 1F         [ 7]  933 	and	a, #0x1F
   0716 4F            [ 4]  934 	ld	c,a
                            935 ;src/Map.c:219: u8 y=(cpct_getRandom_lcg_u8()%32);
   0717 C5            [11]  936 	push	bc
   0718 CD F7 42      [17]  937 	call	_cpct_getRandom_lcg_u8
   071B C1            [10]  938 	pop	bc
   071C 7D            [ 4]  939 	ld	a,l
   071D E6 1F         [ 7]  940 	and	a, #0x1F
   071F 5F            [ 4]  941 	ld	e,a
                            942 ;src/Map.c:220: u8 door_not_positioned=1;
   0720 DD 36 F6 01   [19]  943 	ld	-10 (ix),#0x01
                            944 ;src/Map.c:227: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
   0724 06 00         [ 7]  945 	ld	b,#0x00
   0726 21 00 60      [10]  946 	ld	hl,#0x6000
   0729 09            [11]  947 	add	hl,bc
   072A 4D            [ 4]  948 	ld	c,l
   072B 44            [ 4]  949 	ld	b,h
   072C 6B            [ 4]  950 	ld	l,e
   072D 26 00         [ 7]  951 	ld	h,#0x00
   072F 29            [11]  952 	add	hl, hl
   0730 29            [11]  953 	add	hl, hl
   0731 29            [11]  954 	add	hl, hl
   0732 29            [11]  955 	add	hl, hl
   0733 29            [11]  956 	add	hl, hl
   0734 09            [11]  957 	add	hl,bc
   0735 4D            [ 4]  958 	ld	c,l
   0736 44            [ 4]  959 	ld	b,h
                            960 ;src/Map.c:232: lastVal = (position-1);
   0737 59            [ 4]  961 	ld	e,c
   0738 50            [ 4]  962 	ld	d,b
   0739 1B            [ 6]  963 	dec	de
                            964 ;src/Map.c:233: nextVal = (position+1);
   073A 21 01 00      [10]  965 	ld	hl,#0x0001
   073D 09            [11]  966 	add	hl,bc
   073E DD 75 F4      [19]  967 	ld	-12 (ix),l
   0741 DD 74 F5      [19]  968 	ld	-11 (ix),h
                            969 ;src/Map.c:234: topVal = (position-MAP_WIDTH);
   0744 79            [ 4]  970 	ld	a,c
   0745 C6 E0         [ 7]  971 	add	a,#0xE0
   0747 DD 77 F2      [19]  972 	ld	-14 (ix),a
   074A 78            [ 4]  973 	ld	a,b
   074B CE FF         [ 7]  974 	adc	a,#0xFF
   074D DD 77 F3      [19]  975 	ld	-13 (ix),a
                            976 ;src/Map.c:235: bottomVal = (position+MAP_WIDTH);
   0750 FD 21 20 00   [14]  977 	ld	iy,#0x0020
   0754 FD 09         [15]  978 	add	iy, bc
                            979 ;src/Map.c:237: while(door_not_positioned){
   0756                     980 00138$:
   0756 DD 7E F6      [19]  981 	ld	a,-10 (ix)
   0759 B7            [ 4]  982 	or	a, a
   075A CA AA 08      [10]  983 	jp	Z,00141$
                            984 ;src/Map.c:238: if((*position)!=CELLTYPE_FLOOR){
   075D 0A            [ 7]  985 	ld	a,(bc)
   075E B7            [ 4]  986 	or	a, a
   075F CA 70 08      [10]  987 	jp	Z,00135$
                            988 ;src/Map.c:239: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   0762 1A            [ 7]  989 	ld	a,(de)
   0763 DD 77 FF      [19]  990 	ld	-1 (ix),a
   0766 DD 73 FC      [19]  991 	ld	-4 (ix),e
   0769 DD 72 FD      [19]  992 	ld	-3 (ix),d
   076C DD 7E F4      [19]  993 	ld	a,-12 (ix)
   076F DD 77 FA      [19]  994 	ld	-6 (ix),a
   0772 DD 7E F5      [19]  995 	ld	a,-11 (ix)
   0775 DD 77 FB      [19]  996 	ld	-5 (ix),a
                            997 ;src/Map.c:240: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   0778 E1            [10]  998 	pop	hl
   0779 E5            [11]  999 	push	hl
   077A 7E            [ 7] 1000 	ld	a,(hl)
   077B DD 77 FE      [19] 1001 	ld	-2 (ix),a
   077E DD 7E F2      [19] 1002 	ld	a,-14 (ix)
   0781 DD 77 F8      [19] 1003 	ld	-8 (ix),a
   0784 DD 7E F3      [19] 1004 	ld	a,-13 (ix)
   0787 DD 77 F9      [19] 1005 	ld	-7 (ix),a
   078A FD E5         [15] 1006 	push	iy
   078C E1            [10] 1007 	pop	hl
                           1008 ;src/Map.c:239: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   078D DD 7E FD      [19] 1009 	ld	a,-3 (ix)
   0790 D6 60         [ 7] 1010 	sub	a, #0x60
   0792 3E 00         [ 7] 1011 	ld	a,#0x00
   0794 17            [ 4] 1012 	rla
   0795 DD 77 FC      [19] 1013 	ld	-4 (ix),a
   0798 DD 7E FB      [19] 1014 	ld	a,-5 (ix)
   079B D6 64         [ 7] 1015 	sub	a, #0x64
   079D 3E 00         [ 7] 1016 	ld	a,#0x00
   079F 17            [ 4] 1017 	rla
   07A0 DD 77 FA      [19] 1018 	ld	-6 (ix),a
                           1019 ;src/Map.c:240: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   07A3 DD 7E F9      [19] 1020 	ld	a,-7 (ix)
   07A6 D6 60         [ 7] 1021 	sub	a, #0x60
   07A8 3E 00         [ 7] 1022 	ld	a,#0x00
   07AA 17            [ 4] 1023 	rla
   07AB DD 77 F8      [19] 1024 	ld	-8 (ix),a
   07AE 7C            [ 4] 1025 	ld	a,h
   07AF D6 64         [ 7] 1026 	sub	a, #0x64
   07B1 3E 00         [ 7] 1027 	ld	a,#0x00
   07B3 17            [ 4] 1028 	rla
   07B4 DD 77 F7      [19] 1029 	ld	-9 (ix),a
                           1030 ;src/Map.c:239: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   07B7 DD 7E FF      [19] 1031 	ld	a,-1 (ix)
   07BA B7            [ 4] 1032 	or	a, a
   07BB 20 06         [12] 1033 	jr	NZ,00133$
   07BD DD 7E FC      [19] 1034 	ld	a,-4 (ix)
   07C0 B7            [ 4] 1035 	or	a, a
   07C1 28 52         [12] 1036 	jr	Z,00129$
   07C3                    1037 00133$:
   07C3 DD 6E F4      [19] 1038 	ld	l,-12 (ix)
   07C6 DD 66 F5      [19] 1039 	ld	h,-11 (ix)
   07C9 7E            [ 7] 1040 	ld	a,(hl)
   07CA B7            [ 4] 1041 	or	a, a
   07CB 20 06         [12] 1042 	jr	NZ,00128$
   07CD DD CB FA 46   [20] 1043 	bit	0,-6 (ix)
   07D1 20 42         [12] 1044 	jr	NZ,00129$
   07D3                    1045 00128$:
                           1046 ;src/Map.c:240: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   07D3 FD 6E 00      [19] 1047 	ld	l, 0 (iy)
   07D6 DD 7E FE      [19] 1048 	ld	a,-2 (ix)
   07D9 B7            [ 4] 1049 	or	a, a
   07DA 20 06         [12] 1050 	jr	NZ,00111$
   07DC DD 7E F8      [19] 1051 	ld	a,-8 (ix)
   07DF B7            [ 4] 1052 	or	a, a
   07E0 28 14         [12] 1053 	jr	Z,00107$
   07E2                    1054 00111$:
   07E2 7D            [ 4] 1055 	ld	a,l
   07E3 B7            [ 4] 1056 	or	a, a
   07E4 20 10         [12] 1057 	jr	NZ,00107$
   07E6 DD 7E F7      [19] 1058 	ld	a,-9 (ix)
   07E9 B7            [ 4] 1059 	or	a, a
   07EA 28 0A         [12] 1060 	jr	Z,00107$
                           1061 ;src/Map.c:241: door_not_positioned=0;
   07EC DD 36 F6 00   [19] 1062 	ld	-10 (ix),#0x00
                           1063 ;src/Map.c:242: *position=CELLTYPE_DOOR;
   07F0 3E 80         [ 7] 1064 	ld	a,#0x80
   07F2 02            [ 7] 1065 	ld	(bc),a
   07F3 C3 70 08      [10] 1066 	jp	00135$
   07F6                    1067 00107$:
                           1068 ;src/Map.c:244: else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
   07F6 7D            [ 4] 1069 	ld	a,l
   07F7 B7            [ 4] 1070 	or	a, a
   07F8 20 06         [12] 1071 	jr	NZ,00105$
   07FA DD 7E F7      [19] 1072 	ld	a,-9 (ix)
   07FD B7            [ 4] 1073 	or	a, a
   07FE 20 70         [12] 1074 	jr	NZ,00135$
   0800                    1075 00105$:
   0800 DD 7E FE      [19] 1076 	ld	a,-2 (ix)
   0803 B7            [ 4] 1077 	or	a, a
   0804 20 6A         [12] 1078 	jr	NZ,00135$
   0806 DD 7E F8      [19] 1079 	ld	a,-8 (ix)
   0809 B7            [ 4] 1080 	or	a, a
   080A 20 64         [12] 1081 	jr	NZ,00135$
                           1082 ;src/Map.c:245: door_not_positioned=0;
   080C DD 36 F6 00   [19] 1083 	ld	-10 (ix),#0x00
                           1084 ;src/Map.c:246: *position=CELLTYPE_DOOR;
   0810 3E 80         [ 7] 1085 	ld	a,#0x80
   0812 02            [ 7] 1086 	ld	(bc),a
   0813 18 5B         [12] 1087 	jr	00135$
   0815                    1088 00129$:
                           1089 ;src/Map.c:249: else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
   0815 DD 7E FE      [19] 1090 	ld	a,-2 (ix)
   0818 B7            [ 4] 1091 	or	a, a
   0819 20 06         [12] 1092 	jr	NZ,00127$
   081B DD 7E F8      [19] 1093 	ld	a,-8 (ix)
   081E B7            [ 4] 1094 	or	a, a
   081F 28 4F         [12] 1095 	jr	Z,00135$
   0821                    1096 00127$:
   0821 FD 7E 00      [19] 1097 	ld	a, 0 (iy)
   0824 B7            [ 4] 1098 	or	a, a
   0825 20 06         [12] 1099 	jr	NZ,00123$
   0827 DD 7E F7      [19] 1100 	ld	a,-9 (ix)
   082A B7            [ 4] 1101 	or	a, a
   082B 20 43         [12] 1102 	jr	NZ,00135$
   082D                    1103 00123$:
                           1104 ;src/Map.c:239: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   082D DD 6E F4      [19] 1105 	ld	l,-12 (ix)
   0830 DD 66 F5      [19] 1106 	ld	h,-11 (ix)
   0833 6E            [ 7] 1107 	ld	l,(hl)
                           1108 ;src/Map.c:250: if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
   0834 DD 7E FF      [19] 1109 	ld	a,-1 (ix)
   0837 B7            [ 4] 1110 	or	a, a
   0838 20 06         [12] 1111 	jr	NZ,00122$
   083A DD 7E FC      [19] 1112 	ld	a,-4 (ix)
   083D B7            [ 4] 1113 	or	a, a
   083E 28 13         [12] 1114 	jr	Z,00118$
   0840                    1115 00122$:
   0840 7D            [ 4] 1116 	ld	a,l
   0841 B7            [ 4] 1117 	or	a, a
   0842 20 0F         [12] 1118 	jr	NZ,00118$
   0844 DD CB FA 46   [20] 1119 	bit	0,-6 (ix)
   0848 28 09         [12] 1120 	jr	Z,00118$
                           1121 ;src/Map.c:251: door_not_positioned=0;
   084A DD 36 F6 00   [19] 1122 	ld	-10 (ix),#0x00
                           1123 ;src/Map.c:252: *position=CELLTYPE_DOOR;
   084E 3E 80         [ 7] 1124 	ld	a,#0x80
   0850 02            [ 7] 1125 	ld	(bc),a
   0851 18 1D         [12] 1126 	jr	00135$
   0853                    1127 00118$:
                           1128 ;src/Map.c:254: else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
   0853 7D            [ 4] 1129 	ld	a,l
   0854 B7            [ 4] 1130 	or	a, a
   0855 20 06         [12] 1131 	jr	NZ,00116$
   0857 DD CB FA 46   [20] 1132 	bit	0,-6 (ix)
   085B 20 13         [12] 1133 	jr	NZ,00135$
   085D                    1134 00116$:
   085D DD 7E FF      [19] 1135 	ld	a,-1 (ix)
   0860 B7            [ 4] 1136 	or	a, a
   0861 20 0D         [12] 1137 	jr	NZ,00135$
   0863 DD 7E FC      [19] 1138 	ld	a,-4 (ix)
   0866 B7            [ 4] 1139 	or	a, a
   0867 20 07         [12] 1140 	jr	NZ,00135$
                           1141 ;src/Map.c:255: door_not_positioned=0;
   0869 DD 36 F6 00   [19] 1142 	ld	-10 (ix),#0x00
                           1143 ;src/Map.c:256: *position=CELLTYPE_DOOR;
   086D 3E 80         [ 7] 1144 	ld	a,#0x80
   086F 02            [ 7] 1145 	ld	(bc),a
   0870                    1146 00135$:
                           1147 ;src/Map.c:260: ++position;
   0870 03            [ 6] 1148 	inc	bc
                           1149 ;src/Map.c:261: ++lastVal;
   0871 13            [ 6] 1150 	inc	de
                           1151 ;src/Map.c:262: ++nextVal;
   0872 DD 34 F4      [23] 1152 	inc	-12 (ix)
   0875 20 03         [12] 1153 	jr	NZ,00223$
   0877 DD 34 F5      [23] 1154 	inc	-11 (ix)
   087A                    1155 00223$:
                           1156 ;src/Map.c:263: ++topVal;
   087A DD 34 F2      [23] 1157 	inc	-14 (ix)
   087D 20 03         [12] 1158 	jr	NZ,00224$
   087F DD 34 F3      [23] 1159 	inc	-13 (ix)
   0882                    1160 00224$:
                           1161 ;src/Map.c:264: ++bottomVal;
   0882 FD 23         [10] 1162 	inc	iy
                           1163 ;src/Map.c:265: if(position==END_OF_MAP_MEM){
   0884 69            [ 4] 1164 	ld	l, c
   0885 60            [ 4] 1165 	ld	h, b
   0886 7D            [ 4] 1166 	ld	a,l
   0887 B7            [ 4] 1167 	or	a, a
   0888 C2 56 07      [10] 1168 	jp	NZ,00138$
   088B 7C            [ 4] 1169 	ld	a,h
   088C D6 64         [ 7] 1170 	sub	a, #0x64
   088E C2 56 07      [10] 1171 	jp	NZ,00138$
                           1172 ;src/Map.c:266: position = MAP_MEM;
   0891 01 00 60      [10] 1173 	ld	bc,#0x6000
                           1174 ;src/Map.c:267: lastVal = (position-1);
   0894 11 FF 5F      [10] 1175 	ld	de,#0x5FFF
                           1176 ;src/Map.c:268: nextVal = (position+1);
   0897 DD 36 F4 01   [19] 1177 	ld	-12 (ix),#0x01
   089B DD 36 F5 60   [19] 1178 	ld	-11 (ix),#0x60
                           1179 ;src/Map.c:269: topVal = (position-MAP_WIDTH);
   089F 21 E0 5F      [10] 1180 	ld	hl,#0x5FE0
   08A2 E3            [19] 1181 	ex	(sp), hl
                           1182 ;src/Map.c:270: bottomVal = (position+MAP_WIDTH);
   08A3 FD 21 20 60   [14] 1183 	ld	iy,#0x6020
   08A7 C3 56 07      [10] 1184 	jp	00138$
   08AA                    1185 00141$:
   08AA DD F9         [10] 1186 	ld	sp, ix
   08AC DD E1         [14] 1187 	pop	ix
   08AE C9            [10] 1188 	ret
                           1189 ;src/Map.c:276: void generate_level(){
                           1190 ;	---------------------------------
                           1191 ; Function generate_level
                           1192 ; ---------------------------------
   08AF                    1193 _generate_level::
                           1194 ;src/Map.c:277: generate_level_with_seed(r_counter);
   08AF 3A 42 45      [13] 1195 	ld	a,(_r_counter)
   08B2 F5            [11] 1196 	push	af
   08B3 33            [ 6] 1197 	inc	sp
   08B4 CD B9 08      [17] 1198 	call	_generate_level_with_seed
   08B7 33            [ 6] 1199 	inc	sp
   08B8 C9            [10] 1200 	ret
                           1201 ;src/Map.c:280: void generate_level_with_seed(u8 seed){
                           1202 ;	---------------------------------
                           1203 ; Function generate_level_with_seed
                           1204 ; ---------------------------------
   08B9                    1205 _generate_level_with_seed::
                           1206 ;src/Map.c:282: rand_seed=seed;
   08B9 21 02 00      [10] 1207 	ld	hl, #2+0
   08BC 39            [11] 1208 	add	hl, sp
   08BD 7E            [ 7] 1209 	ld	a, (hl)
   08BE 32 43 45      [13] 1210 	ld	(#_rand_seed + 0),a
                           1211 ;src/Map.c:283: cpct_setSeed_lcg_u8(seed+level_get_level());
   08C1 CD CF 00      [17] 1212 	call	_level_get_level
   08C4 FD 21 02 00   [14] 1213 	ld	iy,#2
   08C8 FD 39         [15] 1214 	add	iy,sp
   08CA FD 7E 00      [19] 1215 	ld	a,0 (iy)
   08CD 85            [ 4] 1216 	add	a, l
   08CE 6F            [ 4] 1217 	ld	l,a
   08CF CD 9D 42      [17] 1218 	call	_cpct_setSeed_lcg_u8
                           1219 ;src/Map.c:285: generate_map();
   08D2 CD DD 01      [17] 1220 	call	_generate_map
                           1221 ;src/Map.c:286: generate_exit_door();
   08D5 CD 03 07      [17] 1222 	call	_generate_exit_door
                           1223 ;src/Map.c:287: *(u8*)(MAP_MEM + 6 + MAP_WIDTH*5)=0b00000001;
   08D8 21 A6 60      [10] 1224 	ld	hl,#0x60A6
   08DB 36 01         [10] 1225 	ld	(hl),#0x01
   08DD C9            [10] 1226 	ret
                           1227 	.area _CODE
                           1228 	.area _INITIALIZER
   4548                    1229 __xinit__rand_seed:
   4548 00                 1230 	.db #0x00	; 0
                           1231 	.area _CABS (ABS)
