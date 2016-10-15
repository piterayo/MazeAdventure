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
                             15 	.globl _player_turn_left
                             16 	.globl _cpct_setSeed_lcg_u8
                             17 	.globl _cpct_getRandom_lcg_u8
                             18 	.globl _cpct_memset
                             19 	.globl _rand_seed
                             20 	.globl _map_get_seed
                             21 	.globl _generate_level
                             22 	.globl _generate_level_with_seed
                             23 ;--------------------------------------------------------
                             24 ; special function registers
                             25 ;--------------------------------------------------------
                             26 ;--------------------------------------------------------
                             27 ; ram data
                             28 ;--------------------------------------------------------
                             29 	.area _DATA
                             30 ;--------------------------------------------------------
                             31 ; ram data
                             32 ;--------------------------------------------------------
                             33 	.area _INITIALIZED
   4AAA                      34 _rand_seed::
   4AAA                      35 	.ds 1
                             36 ;--------------------------------------------------------
                             37 ; absolute external ram data
                             38 ;--------------------------------------------------------
                             39 	.area _DABS (ABS)
                             40 ;--------------------------------------------------------
                             41 ; global & static initialisations
                             42 ;--------------------------------------------------------
                             43 	.area _HOME
                             44 	.area _GSINIT
                             45 	.area _GSFINAL
                             46 	.area _GSINIT
                             47 ;--------------------------------------------------------
                             48 ; Home
                             49 ;--------------------------------------------------------
                             50 	.area _HOME
                             51 	.area _HOME
                             52 ;--------------------------------------------------------
                             53 ; code
                             54 ;--------------------------------------------------------
                             55 	.area _CODE
                             56 ;src/Map.c:14: u8 map_get_seed(){
                             57 ;	---------------------------------
                             58 ; Function map_get_seed
                             59 ; ---------------------------------
   019E                      60 _map_get_seed::
                             61 ;src/Map.c:15: return rand_seed;
   019E FD 21 AA 4A   [14]   62 	ld	iy,#_rand_seed
   01A2 FD 6E 00      [19]   63 	ld	l,0 (iy)
   01A5 C9            [10]   64 	ret
                             65 ;src/Map.c:18: u8 get_random_wall(){
                             66 ;	---------------------------------
                             67 ; Function get_random_wall
                             68 ; ---------------------------------
   01A6                      69 _get_random_wall::
                             70 ;src/Map.c:19: u8 cellType = cpct_getRandom_lcg_u8();
   01A6 CD 7E 48      [17]   71 	call	_cpct_getRandom_lcg_u8
                             72 ;src/Map.c:20: if(cellType&1){
   01A9 CB 45         [ 8]   73 	bit	0, l
   01AB 28 03         [12]   74 	jr	Z,00108$
                             75 ;src/Map.c:21: return CELLTYPE_WALL1;
   01AD 2E 81         [ 7]   76 	ld	l,#0x81
   01AF C9            [10]   77 	ret
   01B0                      78 00108$:
                             79 ;src/Map.c:24: if(cellType&3){
   01B0 7D            [ 4]   80 	ld	a,l
   01B1 E6 03         [ 7]   81 	and	a, #0x03
   01B3 28 03         [12]   82 	jr	Z,00105$
                             83 ;src/Map.c:25: return CELLTYPE_WALL2;
   01B5 2E 82         [ 7]   84 	ld	l,#0x82
   01B7 C9            [10]   85 	ret
   01B8                      86 00105$:
                             87 ;src/Map.c:28: if(cellType&5){
   01B8 7D            [ 4]   88 	ld	a,l
   01B9 E6 05         [ 7]   89 	and	a, #0x05
   01BB 28 03         [12]   90 	jr	Z,00102$
                             91 ;src/Map.c:29: return CELLTYPE_WALL3;
   01BD 2E 83         [ 7]   92 	ld	l,#0x83
   01BF C9            [10]   93 	ret
   01C0                      94 00102$:
                             95 ;src/Map.c:32: return CELLTYPE_WALL4;  
   01C0 2E 84         [ 7]   96 	ld	l,#0x84
   01C2 C9            [10]   97 	ret
                             98 ;src/Map.c:38: void generate_map(){
                             99 ;	---------------------------------
                            100 ; Function generate_map
                            101 ; ---------------------------------
   01C3                     102 _generate_map::
   01C3 DD E5         [15]  103 	push	ix
   01C5 DD 21 00 00   [14]  104 	ld	ix,#0
   01C9 DD 39         [15]  105 	add	ix,sp
   01CB 21 EC FF      [10]  106 	ld	hl,#-20
   01CE 39            [11]  107 	add	hl,sp
   01CF F9            [ 6]  108 	ld	sp,hl
                            109 ;src/Map.c:41: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
   01D0 DD 36 F2 83   [19]  110 	ld	-14 (ix),#0x83
   01D4 DD 36 F3 03   [19]  111 	ld	-13 (ix),#0x03
                            112 ;src/Map.c:47: u16 wallListCount = 0;
   01D8 DD 36 EE 00   [19]  113 	ld	-18 (ix),#0x00
   01DC DD 36 EF 00   [19]  114 	ld	-17 (ix),#0x00
                            115 ;src/Map.c:48: u16 lastStackItem = 0;
   01E0 21 00 00      [10]  116 	ld	hl,#0x0000
   01E3 E3            [19]  117 	ex	(sp), hl
                            118 ;src/Map.c:50: cpct_memset (GENERATOR_DATA_PTR, 0, 4096);
   01E4 21 00 10      [10]  119 	ld	hl,#0x1000
   01E7 E5            [11]  120 	push	hl
   01E8 AF            [ 4]  121 	xor	a, a
   01E9 F5            [11]  122 	push	af
   01EA 33            [ 6]  123 	inc	sp
   01EB 26 64         [ 7]  124 	ld	h, #0x64
   01ED E5            [11]  125 	push	hl
   01EE CD A5 48      [17]  126 	call	_cpct_memset
                            127 ;src/Map.c:52: (*cellStack).x = (cpct_getRandom_lcg_u8()%(MAP_WIDTH-2))+1; //RANDOM
   01F1 CD 7E 48      [17]  128 	call	_cpct_getRandom_lcg_u8
   01F4 45            [ 4]  129 	ld	b,l
   01F5 3E 1E         [ 7]  130 	ld	a,#0x1E
   01F7 F5            [11]  131 	push	af
   01F8 33            [ 6]  132 	inc	sp
   01F9 C5            [11]  133 	push	bc
   01FA 33            [ 6]  134 	inc	sp
   01FB CD CC 47      [17]  135 	call	__moduchar
   01FE F1            [10]  136 	pop	af
   01FF 4D            [ 4]  137 	ld	c,l
   0200 0C            [ 4]  138 	inc	c
   0201 21 00 64      [10]  139 	ld	hl,#0x6400
   0204 71            [ 7]  140 	ld	(hl),c
                            141 ;src/Map.c:53: (*cellStack).y = (cpct_getRandom_lcg_u8()%(MAP_HEIGHT-2))+1; //RANDOM
   0205 CD 7E 48      [17]  142 	call	_cpct_getRandom_lcg_u8
   0208 45            [ 4]  143 	ld	b,l
   0209 3E 1E         [ 7]  144 	ld	a,#0x1E
   020B F5            [11]  145 	push	af
   020C 33            [ 6]  146 	inc	sp
   020D C5            [11]  147 	push	bc
   020E 33            [ 6]  148 	inc	sp
   020F CD CC 47      [17]  149 	call	__moduchar
   0212 F1            [10]  150 	pop	af
   0213 4D            [ 4]  151 	ld	c,l
   0214 0C            [ 4]  152 	inc	c
   0215 21 01 64      [10]  153 	ld	hl,#0x6401
   0218 71            [ 7]  154 	ld	(hl),c
                            155 ;src/Map.c:55: rotatePlayer = cpct_getRandom_lcg_u8()%4;
   0219 CD 7E 48      [17]  156 	call	_cpct_getRandom_lcg_u8
   021C 7D            [ 4]  157 	ld	a,l
   021D E6 03         [ 7]  158 	and	a, #0x03
   021F 4F            [ 4]  159 	ld	c,a
                            160 ;src/Map.c:56: while(rotatePlayer){
   0220                     161 00101$:
   0220 79            [ 4]  162 	ld	a,c
   0221 B7            [ 4]  163 	or	a, a
   0222 28 08         [12]  164 	jr	Z,00103$
                            165 ;src/Map.c:57: player_turn_left();
   0224 C5            [11]  166 	push	bc
   0225 CD 5B 08      [17]  167 	call	_player_turn_left
   0228 C1            [10]  168 	pop	bc
                            169 ;src/Map.c:58: --rotatePlayer;
   0229 0D            [ 4]  170 	dec	c
   022A 18 F4         [12]  171 	jr	00101$
   022C                     172 00103$:
                            173 ;src/Map.c:61: *(i8*)&(player_position.x) = (*cellStack).y;
   022C 01 89 08      [10]  174 	ld	bc,#_player_position+0
   022F 3A 01 64      [13]  175 	ld	a,(#0x6401)
   0232 02            [ 7]  176 	ld	(bc),a
                            177 ;src/Map.c:62: *(i8*)&(player_position.y) = (*cellStack).x;
   0233 01 8A 08      [10]  178 	ld	bc,#_player_position+1
   0236 3A 00 64      [13]  179 	ld	a,(#0x6400)
   0239 02            [ 7]  180 	ld	(bc),a
                            181 ;src/Map.c:64: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   023A 21 00 04      [10]  182 	ld	hl,#0x0400
   023D E5            [11]  183 	push	hl
   023E 3E 87         [ 7]  184 	ld	a,#0x87
   0240 F5            [11]  185 	push	af
   0241 33            [ 6]  186 	inc	sp
   0242 26 60         [ 7]  187 	ld	h, #0x60
   0244 E5            [11]  188 	push	hl
   0245 CD A5 48      [17]  189 	call	_cpct_memset
                            190 ;src/Map.c:67: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   0248 21 00 64      [10]  191 	ld	hl,#0x6400
   024B 6E            [ 7]  192 	ld	l,(hl)
   024C 26 00         [ 7]  193 	ld	h,#0x00
   024E 29            [11]  194 	add	hl, hl
   024F 29            [11]  195 	add	hl, hl
   0250 29            [11]  196 	add	hl, hl
   0251 29            [11]  197 	add	hl, hl
   0252 29            [11]  198 	add	hl, hl
   0253 01 00 60      [10]  199 	ld	bc,#0x6000
   0256 09            [11]  200 	add	hl,bc
   0257 4D            [ 4]  201 	ld	c,l
   0258 44            [ 4]  202 	ld	b,h
   0259 21 01 64      [10]  203 	ld	hl,#0x6401
   025C 6E            [ 7]  204 	ld	l, (hl)
   025D 26 00         [ 7]  205 	ld	h,#0x00
   025F 09            [11]  206 	add	hl,bc
   0260 36 00         [10]  207 	ld	(hl),#0x00
                            208 ;src/Map.c:70: for(i=0;i<MAP_WIDTH;++i){
   0262 0E 00         [ 7]  209 	ld	c,#0x00
   0264                     210 00170$:
                            211 ;src/Map.c:71: map[0][i]=CELLTYPE_WALL1;//get_random_wall();
   0264 21 00 60      [10]  212 	ld	hl,#0x6000
   0267 06 00         [ 7]  213 	ld	b,#0x00
   0269 09            [11]  214 	add	hl, bc
   026A 36 81         [10]  215 	ld	(hl),#0x81
                            216 ;src/Map.c:72: map[MAP_HEIGHT-1][i]=CELLTYPE_WALL1;//get_random_wall();
   026C 21 E0 63      [10]  217 	ld	hl,#0x63E0
   026F 06 00         [ 7]  218 	ld	b,#0x00
   0271 09            [11]  219 	add	hl, bc
   0272 36 81         [10]  220 	ld	(hl),#0x81
                            221 ;src/Map.c:70: for(i=0;i<MAP_WIDTH;++i){
   0274 0C            [ 4]  222 	inc	c
   0275 79            [ 4]  223 	ld	a,c
   0276 D6 20         [ 7]  224 	sub	a, #0x20
   0278 38 EA         [12]  225 	jr	C,00170$
                            226 ;src/Map.c:75: for(i=1;i<MAP_HEIGHT-1;++i){
   027A 0E 01         [ 7]  227 	ld	c,#0x01
   027C                     228 00172$:
                            229 ;src/Map.c:76: map[i][0]=CELLTYPE_WALL1;//get_random_wall();
   027C 69            [ 4]  230 	ld	l,c
   027D 26 00         [ 7]  231 	ld	h,#0x00
   027F 29            [11]  232 	add	hl, hl
   0280 29            [11]  233 	add	hl, hl
   0281 29            [11]  234 	add	hl, hl
   0282 29            [11]  235 	add	hl, hl
   0283 29            [11]  236 	add	hl, hl
   0284 EB            [ 4]  237 	ex	de,hl
   0285 21 00 60      [10]  238 	ld	hl,#0x6000
   0288 19            [11]  239 	add	hl,de
   0289 36 81         [10]  240 	ld	(hl),#0x81
                            241 ;src/Map.c:77: map[i][MAP_WIDTH-1]=CELLTYPE_WALL1;//get_random_wall();
   028B 21 00 60      [10]  242 	ld	hl,#0x6000
   028E 19            [11]  243 	add	hl,de
   028F 11 1F 00      [10]  244 	ld	de,#0x001F
   0292 19            [11]  245 	add	hl,de
   0293 36 81         [10]  246 	ld	(hl),#0x81
                            247 ;src/Map.c:75: for(i=1;i<MAP_HEIGHT-1;++i){
   0295 0C            [ 4]  248 	inc	c
   0296 79            [ 4]  249 	ld	a,c
   0297 D6 1F         [ 7]  250 	sub	a, #0x1F
   0299 38 E1         [12]  251 	jr	C,00172$
                            252 ;src/Map.c:80: while(remainingCells>0){
   029B 21 04 00      [10]  253 	ld	hl,#0x0004
   029E 39            [11]  254 	add	hl,sp
   029F DD 75 FA      [19]  255 	ld	-6 (ix),l
   02A2 DD 74 FB      [19]  256 	ld	-5 (ix),h
   02A5                     257 00167$:
   02A5 DD 7E F3      [19]  258 	ld	a,-13 (ix)
   02A8 DD B6 F2      [19]  259 	or	a,-14 (ix)
   02AB CA 73 06      [10]  260 	jp	Z,00174$
                            261 ;src/Map.c:81: wallListPosition = wallList+wallListCount;
   02AE C1            [10]  262 	pop	bc
   02AF E1            [10]  263 	pop	hl
   02B0 E5            [11]  264 	push	hl
   02B1 C5            [11]  265 	push	bc
   02B2 29            [11]  266 	add	hl, hl
   02B3 7D            [ 4]  267 	ld	a,l
   02B4 C6 00         [ 7]  268 	add	a, #0x00
   02B6 DD 77 FC      [19]  269 	ld	-4 (ix),a
   02B9 7C            [ 4]  270 	ld	a,h
   02BA CE 68         [ 7]  271 	adc	a, #0x68
   02BC DD 77 FD      [19]  272 	ld	-3 (ix),a
                            273 ;src/Map.c:82: while(wallListCount<MAP_SIZE){
   02BF D1            [10]  274 	pop	de
   02C0 C1            [10]  275 	pop	bc
   02C1 C5            [11]  276 	push	bc
   02C2 D5            [11]  277 	push	de
   02C3                     278 00137$:
                            279 ;src/Map.c:85: currentPos.y = (*wallListPosition).y;
   02C3 DD 7E FA      [19]  280 	ld	a,-6 (ix)
   02C6 C6 01         [ 7]  281 	add	a, #0x01
   02C8 DD 77 FE      [19]  282 	ld	-2 (ix),a
   02CB DD 7E FB      [19]  283 	ld	a,-5 (ix)
   02CE CE 00         [ 7]  284 	adc	a, #0x00
   02D0 DD 77 FF      [19]  285 	ld	-1 (ix),a
                            286 ;src/Map.c:82: while(wallListCount<MAP_SIZE){
   02D3 78            [ 4]  287 	ld	a,b
   02D4 D6 04         [ 7]  288 	sub	a, #0x04
   02D6 D2 74 04      [10]  289 	jp	NC,00209$
                            290 ;src/Map.c:84: currentPos.x = (*wallListPosition).x;
   02D9 21 04 00      [10]  291 	ld	hl,#0x0004
   02DC 39            [11]  292 	add	hl,sp
   02DD EB            [ 4]  293 	ex	de,hl
   02DE DD 6E FC      [19]  294 	ld	l,-4 (ix)
   02E1 DD 66 FD      [19]  295 	ld	h,-3 (ix)
   02E4 7E            [ 7]  296 	ld	a,(hl)
   02E5 12            [ 7]  297 	ld	(de),a
                            298 ;src/Map.c:85: currentPos.y = (*wallListPosition).y;
   02E6 DD 5E FC      [19]  299 	ld	e,-4 (ix)
   02E9 DD 56 FD      [19]  300 	ld	d,-3 (ix)
   02EC 13            [ 6]  301 	inc	de
   02ED 1A            [ 7]  302 	ld	a,(de)
   02EE DD 6E FE      [19]  303 	ld	l,-2 (ix)
   02F1 DD 66 FF      [19]  304 	ld	h,-1 (ix)
   02F4 77            [ 7]  305 	ld	(hl),a
                            306 ;src/Map.c:87: convertToFloor=0;
   02F5 DD 36 F5 00   [19]  307 	ld	-11 (ix),#0x00
                            308 ;src/Map.c:88: surroundedByWalls=1;
   02F9 DD 36 F4 01   [19]  309 	ld	-12 (ix),#0x01
                            310 ;src/Map.c:90: if(currentPos.x>0){
   02FD DD 6E FA      [19]  311 	ld	l,-6 (ix)
   0300 DD 66 FB      [19]  312 	ld	h,-5 (ix)
   0303 7E            [ 7]  313 	ld	a,(hl)
   0304 DD 77 F8      [19]  314 	ld	-8 (ix),a
                            315 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   0307 DD 6E FE      [19]  316 	ld	l,-2 (ix)
   030A DD 66 FF      [19]  317 	ld	h,-1 (ix)
   030D 7E            [ 7]  318 	ld	a,(hl)
   030E DD 77 F9      [19]  319 	ld	-7 (ix),a
   0311 DD 7E F8      [19]  320 	ld	a,-8 (ix)
   0314 DD 77 F6      [19]  321 	ld	-10 (ix),a
   0317 DD 36 F7 00   [19]  322 	ld	-9 (ix),#0x00
                            323 ;src/Map.c:90: if(currentPos.x>0){
   031B DD 7E F8      [19]  324 	ld	a,-8 (ix)
   031E B7            [ 4]  325 	or	a, a
   031F 28 2F         [12]  326 	jr	Z,00112$
                            327 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   0321 DD 6E F6      [19]  328 	ld	l,-10 (ix)
   0324 DD 66 F7      [19]  329 	ld	h,-9 (ix)
   0327 2B            [ 6]  330 	dec	hl
   0328 29            [11]  331 	add	hl, hl
   0329 29            [11]  332 	add	hl, hl
   032A 29            [11]  333 	add	hl, hl
   032B 29            [11]  334 	add	hl, hl
   032C 29            [11]  335 	add	hl, hl
   032D D5            [11]  336 	push	de
   032E 11 00 60      [10]  337 	ld	de,#0x6000
   0331 19            [11]  338 	add	hl, de
   0332 D1            [10]  339 	pop	de
   0333 7D            [ 4]  340 	ld	a,l
   0334 DD 86 F9      [19]  341 	add	a, -7 (ix)
   0337 6F            [ 4]  342 	ld	l,a
   0338 7C            [ 4]  343 	ld	a,h
   0339 CE 00         [ 7]  344 	adc	a, #0x00
   033B 67            [ 4]  345 	ld	h,a
   033C 6E            [ 7]  346 	ld	l,(hl)
                            347 ;src/Map.c:92: if(adjacentType == CELLTYPE_UNDEFINED){
   033D 7D            [ 4]  348 	ld	a,l
   033E D6 87         [ 7]  349 	sub	a, #0x87
   0340 20 06         [12]  350 	jr	NZ,00109$
                            351 ;src/Map.c:93: convertToFloor  = 1;
   0342 DD 36 F5 01   [19]  352 	ld	-11 (ix),#0x01
   0346 18 08         [12]  353 	jr	00112$
   0348                     354 00109$:
                            355 ;src/Map.c:95: else if(adjacentType == CELLTYPE_FLOOR){
   0348 7D            [ 4]  356 	ld	a,l
   0349 B7            [ 4]  357 	or	a, a
   034A 20 04         [12]  358 	jr	NZ,00112$
                            359 ;src/Map.c:96: surroundedByWalls = 0;
   034C DD 36 F4 00   [19]  360 	ld	-12 (ix),#0x00
   0350                     361 00112$:
                            362 ;src/Map.c:99: if(currentPos.x < (MAP_WIDTH-1)){
   0350 DD 7E F8      [19]  363 	ld	a,-8 (ix)
   0353 D6 1F         [ 7]  364 	sub	a, #0x1F
   0355 30 2F         [12]  365 	jr	NC,00119$
                            366 ;src/Map.c:101: adjacentType = map[currentPos.x+1][currentPos.y];
   0357 DD 6E F6      [19]  367 	ld	l,-10 (ix)
   035A DD 66 F7      [19]  368 	ld	h,-9 (ix)
   035D 23            [ 6]  369 	inc	hl
   035E 29            [11]  370 	add	hl, hl
   035F 29            [11]  371 	add	hl, hl
   0360 29            [11]  372 	add	hl, hl
   0361 29            [11]  373 	add	hl, hl
   0362 29            [11]  374 	add	hl, hl
   0363 D5            [11]  375 	push	de
   0364 11 00 60      [10]  376 	ld	de,#0x6000
   0367 19            [11]  377 	add	hl, de
   0368 D1            [10]  378 	pop	de
   0369 7D            [ 4]  379 	ld	a,l
   036A DD 86 F9      [19]  380 	add	a, -7 (ix)
   036D 6F            [ 4]  381 	ld	l,a
   036E 7C            [ 4]  382 	ld	a,h
   036F CE 00         [ 7]  383 	adc	a, #0x00
   0371 67            [ 4]  384 	ld	h,a
   0372 6E            [ 7]  385 	ld	l,(hl)
                            386 ;src/Map.c:102: if(adjacentType == CELLTYPE_UNDEFINED){
   0373 7D            [ 4]  387 	ld	a,l
   0374 D6 87         [ 7]  388 	sub	a, #0x87
   0376 20 06         [12]  389 	jr	NZ,00116$
                            390 ;src/Map.c:103: convertToFloor  = 1;
   0378 DD 36 F5 01   [19]  391 	ld	-11 (ix),#0x01
   037C 18 08         [12]  392 	jr	00119$
   037E                     393 00116$:
                            394 ;src/Map.c:105: else if(adjacentType == CELLTYPE_FLOOR){
   037E 7D            [ 4]  395 	ld	a,l
   037F B7            [ 4]  396 	or	a, a
   0380 20 04         [12]  397 	jr	NZ,00119$
                            398 ;src/Map.c:106: surroundedByWalls = 0;
   0382 DD 36 F4 00   [19]  399 	ld	-12 (ix),#0x00
   0386                     400 00119$:
                            401 ;src/Map.c:111: adjacentType = map[currentPos.x][currentPos.y-1];
   0386 DD 6E F6      [19]  402 	ld	l,-10 (ix)
   0389 DD 66 F7      [19]  403 	ld	h,-9 (ix)
   038C 29            [11]  404 	add	hl, hl
   038D 29            [11]  405 	add	hl, hl
   038E 29            [11]  406 	add	hl, hl
   038F 29            [11]  407 	add	hl, hl
   0390 29            [11]  408 	add	hl, hl
   0391 7D            [ 4]  409 	ld	a,l
   0392 C6 00         [ 7]  410 	add	a, #0x00
   0394 DD 77 F6      [19]  411 	ld	-10 (ix),a
   0397 7C            [ 4]  412 	ld	a,h
   0398 CE 60         [ 7]  413 	adc	a, #0x60
   039A DD 77 F7      [19]  414 	ld	-9 (ix),a
                            415 ;src/Map.c:109: if(currentPos.y > 0){
   039D DD 7E F9      [19]  416 	ld	a,-7 (ix)
   03A0 B7            [ 4]  417 	or	a, a
   03A1 28 23         [12]  418 	jr	Z,00126$
                            419 ;src/Map.c:111: adjacentType = map[currentPos.x][currentPos.y-1];
   03A3 DD 6E F9      [19]  420 	ld	l,-7 (ix)
   03A6 2D            [ 4]  421 	dec	l
   03A7 DD 7E F6      [19]  422 	ld	a,-10 (ix)
   03AA 85            [ 4]  423 	add	a, l
   03AB 6F            [ 4]  424 	ld	l,a
   03AC DD 7E F7      [19]  425 	ld	a,-9 (ix)
   03AF CE 00         [ 7]  426 	adc	a, #0x00
   03B1 67            [ 4]  427 	ld	h,a
   03B2 6E            [ 7]  428 	ld	l,(hl)
                            429 ;src/Map.c:112: if(adjacentType == CELLTYPE_UNDEFINED){
   03B3 7D            [ 4]  430 	ld	a,l
   03B4 D6 87         [ 7]  431 	sub	a, #0x87
   03B6 20 06         [12]  432 	jr	NZ,00123$
                            433 ;src/Map.c:113: convertToFloor  = 1;
   03B8 DD 36 F5 01   [19]  434 	ld	-11 (ix),#0x01
   03BC 18 08         [12]  435 	jr	00126$
   03BE                     436 00123$:
                            437 ;src/Map.c:115: else if(adjacentType == CELLTYPE_FLOOR){
   03BE 7D            [ 4]  438 	ld	a,l
   03BF B7            [ 4]  439 	or	a, a
   03C0 20 04         [12]  440 	jr	NZ,00126$
                            441 ;src/Map.c:116: surroundedByWalls = 0;
   03C2 DD 36 F4 00   [19]  442 	ld	-12 (ix),#0x00
   03C6                     443 00126$:
                            444 ;src/Map.c:119: if(currentPos.y < (MAP_HEIGHT-1)){
   03C6 DD 7E F9      [19]  445 	ld	a,-7 (ix)
   03C9 D6 1F         [ 7]  446 	sub	a, #0x1F
   03CB 30 23         [12]  447 	jr	NC,00133$
                            448 ;src/Map.c:121: adjacentType = map[currentPos.x][currentPos.y+1];
   03CD DD 6E F9      [19]  449 	ld	l,-7 (ix)
   03D0 2C            [ 4]  450 	inc	l
   03D1 DD 7E F6      [19]  451 	ld	a,-10 (ix)
   03D4 85            [ 4]  452 	add	a, l
   03D5 6F            [ 4]  453 	ld	l,a
   03D6 DD 7E F7      [19]  454 	ld	a,-9 (ix)
   03D9 CE 00         [ 7]  455 	adc	a, #0x00
   03DB 67            [ 4]  456 	ld	h,a
   03DC 6E            [ 7]  457 	ld	l,(hl)
                            458 ;src/Map.c:122: if(adjacentType == CELLTYPE_UNDEFINED){
   03DD 7D            [ 4]  459 	ld	a,l
   03DE D6 87         [ 7]  460 	sub	a, #0x87
   03E0 20 06         [12]  461 	jr	NZ,00130$
                            462 ;src/Map.c:123: convertToFloor  = 1;
   03E2 DD 36 F5 01   [19]  463 	ld	-11 (ix),#0x01
   03E6 18 08         [12]  464 	jr	00133$
   03E8                     465 00130$:
                            466 ;src/Map.c:125: else if(adjacentType == CELLTYPE_FLOOR){
   03E8 7D            [ 4]  467 	ld	a,l
   03E9 B7            [ 4]  468 	or	a, a
   03EA 20 04         [12]  469 	jr	NZ,00133$
                            470 ;src/Map.c:126: surroundedByWalls = 0;
   03EC DD 36 F4 00   [19]  471 	ld	-12 (ix),#0x00
   03F0                     472 00133$:
                            473 ;src/Map.c:130: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   03F0 69            [ 4]  474 	ld	l, c
   03F1 60            [ 4]  475 	ld	h, b
   03F2 29            [11]  476 	add	hl, hl
   03F3 FD 21 00 68   [14]  477 	ld	iy,#0x6800
   03F7 C5            [11]  478 	push	bc
   03F8 4D            [ 4]  479 	ld	c, l
   03F9 44            [ 4]  480 	ld	b, h
   03FA FD 09         [15]  481 	add	iy, bc
   03FC C1            [10]  482 	pop	bc
   03FD FD 7E 00      [19]  483 	ld	a, 0 (iy)
   0400 DD 6E FC      [19]  484 	ld	l,-4 (ix)
   0403 DD 66 FD      [19]  485 	ld	h,-3 (ix)
   0406 77            [ 7]  486 	ld	(hl),a
                            487 ;src/Map.c:131: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   0407 FD E5         [15]  488 	push	iy
   0409 E1            [10]  489 	pop	hl
   040A 23            [ 6]  490 	inc	hl
   040B 7E            [ 7]  491 	ld	a,(hl)
   040C 12            [ 7]  492 	ld	(de),a
                            493 ;src/Map.c:132: --wallListCount;
   040D 0B            [ 6]  494 	dec	bc
   040E DD 71 EE      [19]  495 	ld	-18 (ix),c
   0411 DD 70 EF      [19]  496 	ld	-17 (ix),b
                            497 ;src/Map.c:135: if((convertToFloor)&&(!surroundedByWalls)){
   0414 DD 7E F5      [19]  498 	ld	a,-11 (ix)
   0417 B7            [ 4]  499 	or	a, a
   0418 28 49         [12]  500 	jr	Z,00135$
   041A DD 7E F4      [19]  501 	ld	a,-12 (ix)
   041D B7            [ 4]  502 	or	a, a
   041E 20 43         [12]  503 	jr	NZ,00135$
                            504 ;src/Map.c:136: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   0420 DD 6E FA      [19]  505 	ld	l,-6 (ix)
   0423 DD 66 FB      [19]  506 	ld	h,-5 (ix)
   0426 6E            [ 7]  507 	ld	l,(hl)
   0427 26 00         [ 7]  508 	ld	h,#0x00
   0429 29            [11]  509 	add	hl, hl
   042A 29            [11]  510 	add	hl, hl
   042B 29            [11]  511 	add	hl, hl
   042C 29            [11]  512 	add	hl, hl
   042D 29            [11]  513 	add	hl, hl
   042E 01 00 60      [10]  514 	ld	bc,#0x6000
   0431 09            [11]  515 	add	hl,bc
   0432 4D            [ 4]  516 	ld	c,l
   0433 44            [ 4]  517 	ld	b,h
   0434 DD 6E FE      [19]  518 	ld	l,-2 (ix)
   0437 DD 66 FF      [19]  519 	ld	h,-1 (ix)
   043A 6E            [ 7]  520 	ld	l, (hl)
   043B 26 00         [ 7]  521 	ld	h,#0x00
   043D 09            [11]  522 	add	hl,bc
   043E 36 00         [10]  523 	ld	(hl),#0x00
                            524 ;src/Map.c:138: ++lastStackItem;
   0440 DD 34 EC      [23]  525 	inc	-20 (ix)
   0443 20 03         [12]  526 	jr	NZ,00334$
   0445 DD 34 ED      [23]  527 	inc	-19 (ix)
   0448                     528 00334$:
                            529 ;src/Map.c:139: (*(cellStack+lastStackItem)).x = currentPos.x;
   0448 E1            [10]  530 	pop	hl
   0449 E5            [11]  531 	push	hl
   044A 29            [11]  532 	add	hl, hl
   044B 4D            [ 4]  533 	ld	c, l
   044C 7C            [ 4]  534 	ld	a,h
   044D C6 64         [ 7]  535 	add	a,#0x64
   044F 47            [ 4]  536 	ld	b,a
   0450 DD 6E FA      [19]  537 	ld	l,-6 (ix)
   0453 DD 66 FB      [19]  538 	ld	h,-5 (ix)
   0456 7E            [ 7]  539 	ld	a,(hl)
   0457 02            [ 7]  540 	ld	(bc),a
                            541 ;src/Map.c:140: (*(cellStack+lastStackItem)).y = currentPos.y;
   0458 03            [ 6]  542 	inc	bc
   0459 DD 6E FE      [19]  543 	ld	l,-2 (ix)
   045C DD 66 FF      [19]  544 	ld	h,-1 (ix)
   045F 7E            [ 7]  545 	ld	a,(hl)
   0460 02            [ 7]  546 	ld	(bc),a
                            547 ;src/Map.c:143: break;
   0461 18 11         [12]  548 	jr	00209$
   0463                     549 00135$:
                            550 ;src/Map.c:145: --wallListPosition;
   0463 DD 6E FC      [19]  551 	ld	l,-4 (ix)
   0466 DD 66 FD      [19]  552 	ld	h,-3 (ix)
   0469 2B            [ 6]  553 	dec	hl
   046A 2B            [ 6]  554 	dec	hl
   046B DD 75 FC      [19]  555 	ld	-4 (ix),l
   046E DD 74 FD      [19]  556 	ld	-3 (ix),h
   0471 C3 C3 02      [10]  557 	jp	00137$
                            558 ;src/Map.c:147: while(lastStackItem<MAP_SIZE){
   0474                     559 00209$:
   0474 DD 7E F2      [19]  560 	ld	a,-14 (ix)
   0477 DD 77 F6      [19]  561 	ld	-10 (ix),a
   047A DD 7E F3      [19]  562 	ld	a,-13 (ix)
   047D DD 77 F7      [19]  563 	ld	-9 (ix),a
   0480 DD 7E EE      [19]  564 	ld	a,-18 (ix)
   0483 DD 77 FC      [19]  565 	ld	-4 (ix),a
   0486 DD 7E EF      [19]  566 	ld	a,-17 (ix)
   0489 DD 77 FD      [19]  567 	ld	-3 (ix),a
   048C                     568 00164$:
   048C DD 7E ED      [19]  569 	ld	a,-19 (ix)
   048F D6 04         [ 7]  570 	sub	a, #0x04
   0491 D2 A5 02      [10]  571 	jp	NC,00167$
                            572 ;src/Map.c:148: currentPos.x=(*(lastStackItem+cellStack)).x;
   0494 21 04 00      [10]  573 	ld	hl,#0x0004
   0497 39            [11]  574 	add	hl,sp
   0498 4D            [ 4]  575 	ld	c,l
   0499 44            [ 4]  576 	ld	b,h
   049A E1            [10]  577 	pop	hl
   049B E5            [11]  578 	push	hl
   049C 29            [11]  579 	add	hl, hl
   049D FD 21 00 64   [14]  580 	ld	iy,#0x6400
   04A1 EB            [ 4]  581 	ex	de,hl
   04A2 FD 19         [15]  582 	add	iy, de
   04A4 FD 7E 00      [19]  583 	ld	a, 0 (iy)
   04A7 02            [ 7]  584 	ld	(bc),a
                            585 ;src/Map.c:149: currentPos.y=(*(lastStackItem+cellStack)).y;
   04A8 FD 4E 01      [19]  586 	ld	c,1 (iy)
   04AB DD 6E FE      [19]  587 	ld	l,-2 (ix)
   04AE DD 66 FF      [19]  588 	ld	h,-1 (ix)
   04B1 71            [ 7]  589 	ld	(hl),c
                            590 ;src/Map.c:150: --lastStackItem;
   04B2 E1            [10]  591 	pop	hl
   04B3 E5            [11]  592 	push	hl
   04B4 2B            [ 6]  593 	dec	hl
   04B5 E3            [19]  594 	ex	(sp), hl
                            595 ;src/Map.c:151: cellType = map[currentPos.x][currentPos.y];
   04B6 DD 6E FA      [19]  596 	ld	l,-6 (ix)
   04B9 DD 66 FB      [19]  597 	ld	h,-5 (ix)
   04BC 6E            [ 7]  598 	ld	l,(hl)
   04BD 26 00         [ 7]  599 	ld	h,#0x00
   04BF 29            [11]  600 	add	hl, hl
   04C0 29            [11]  601 	add	hl, hl
   04C1 29            [11]  602 	add	hl, hl
   04C2 29            [11]  603 	add	hl, hl
   04C3 29            [11]  604 	add	hl, hl
   04C4 11 00 60      [10]  605 	ld	de,#0x6000
   04C7 19            [11]  606 	add	hl,de
   04C8 59            [ 4]  607 	ld	e,c
   04C9 16 00         [ 7]  608 	ld	d,#0x00
   04CB 19            [11]  609 	add	hl,de
   04CC 4E            [ 7]  610 	ld	c,(hl)
                            611 ;src/Map.c:153: if(cellType == CELLTYPE_UNDEFINED){
   04CD 79            [ 4]  612 	ld	a,c
   04CE D6 87         [ 7]  613 	sub	a, #0x87
   04D0 20 47         [12]  614 	jr	NZ,00144$
                            615 ;src/Map.c:155: if(cpct_getRandom_lcg_u8()&1){//WALL
   04D2 CD 7E 48      [17]  616 	call	_cpct_getRandom_lcg_u8
   04D5 CB 45         [ 8]  617 	bit	0, l
   04D7 28 06         [12]  618 	jr	Z,00141$
                            619 ;src/Map.c:156: cellType = get_random_wall();
   04D9 CD A6 01      [17]  620 	call	_get_random_wall
   04DC 4D            [ 4]  621 	ld	c,l
   04DD 18 02         [12]  622 	jr	00142$
   04DF                     623 00141$:
                            624 ;src/Map.c:159: cellType = CELLTYPE_FLOOR;
   04DF 0E 00         [ 7]  625 	ld	c,#0x00
   04E1                     626 00142$:
                            627 ;src/Map.c:161: map[currentPos.x][currentPos.y]=cellType;
   04E1 DD 6E FA      [19]  628 	ld	l,-6 (ix)
   04E4 DD 66 FB      [19]  629 	ld	h,-5 (ix)
   04E7 6E            [ 7]  630 	ld	l,(hl)
   04E8 26 00         [ 7]  631 	ld	h,#0x00
   04EA 29            [11]  632 	add	hl, hl
   04EB 29            [11]  633 	add	hl, hl
   04EC 29            [11]  634 	add	hl, hl
   04ED 29            [11]  635 	add	hl, hl
   04EE 29            [11]  636 	add	hl, hl
   04EF EB            [ 4]  637 	ex	de,hl
   04F0 21 00 60      [10]  638 	ld	hl,#0x6000
   04F3 19            [11]  639 	add	hl,de
   04F4 EB            [ 4]  640 	ex	de,hl
   04F5 DD 6E FE      [19]  641 	ld	l,-2 (ix)
   04F8 DD 66 FF      [19]  642 	ld	h,-1 (ix)
   04FB 6E            [ 7]  643 	ld	l, (hl)
   04FC 26 00         [ 7]  644 	ld	h,#0x00
   04FE 19            [11]  645 	add	hl,de
   04FF 71            [ 7]  646 	ld	(hl),c
                            647 ;src/Map.c:162: --remainingCells;
   0500 DD 6E F6      [19]  648 	ld	l,-10 (ix)
   0503 DD 66 F7      [19]  649 	ld	h,-9 (ix)
   0506 2B            [ 6]  650 	dec	hl
   0507 DD 75 F6      [19]  651 	ld	-10 (ix),l
   050A DD 74 F7      [19]  652 	ld	-9 (ix),h
   050D DD 7E F6      [19]  653 	ld	a,-10 (ix)
   0510 DD 77 F2      [19]  654 	ld	-14 (ix),a
   0513 DD 7E F7      [19]  655 	ld	a,-9 (ix)
   0516 DD 77 F3      [19]  656 	ld	-13 (ix),a
   0519                     657 00144$:
                            658 ;src/Map.c:90: if(currentPos.x>0){
   0519 DD 6E FA      [19]  659 	ld	l,-6 (ix)
   051C DD 66 FB      [19]  660 	ld	h,-5 (ix)
   051F 7E            [ 7]  661 	ld	a,(hl)
   0520 DD 77 F9      [19]  662 	ld	-7 (ix),a
                            663 ;src/Map.c:165: if((cellType == CELLTYPE_FLOOR)){
   0523 79            [ 4]  664 	ld	a,c
   0524 B7            [ 4]  665 	or	a, a
   0525 C2 42 06      [10]  666 	jp	NZ,00162$
                            667 ;src/Map.c:166: if(currentPos.x>0){
   0528 DD 7E F9      [19]  668 	ld	a,-7 (ix)
   052B B7            [ 4]  669 	or	a, a
   052C 28 3F         [12]  670 	jr	Z,00148$
                            671 ;src/Map.c:167: adjacentType = map[currentPos.x-1][currentPos.y];
   052E DD 6E F9      [19]  672 	ld	l,-7 (ix)
   0531 26 00         [ 7]  673 	ld	h,#0x00
   0533 2B            [ 6]  674 	dec	hl
   0534 29            [11]  675 	add	hl, hl
   0535 29            [11]  676 	add	hl, hl
   0536 29            [11]  677 	add	hl, hl
   0537 29            [11]  678 	add	hl, hl
   0538 29            [11]  679 	add	hl, hl
   0539 01 00 60      [10]  680 	ld	bc,#0x6000
   053C 09            [11]  681 	add	hl,bc
   053D 4D            [ 4]  682 	ld	c,l
   053E 44            [ 4]  683 	ld	b,h
   053F DD 6E FE      [19]  684 	ld	l,-2 (ix)
   0542 DD 66 FF      [19]  685 	ld	h,-1 (ix)
   0545 6E            [ 7]  686 	ld	l, (hl)
   0546 26 00         [ 7]  687 	ld	h,#0x00
   0548 09            [11]  688 	add	hl,bc
   0549 7E            [ 7]  689 	ld	a,(hl)
                            690 ;src/Map.c:168: if(adjacentType == CELLTYPE_UNDEFINED){
   054A D6 87         [ 7]  691 	sub	a, #0x87
   054C 20 1F         [12]  692 	jr	NZ,00148$
                            693 ;src/Map.c:170: ++lastStackItem;
   054E DD 34 EC      [23]  694 	inc	-20 (ix)
   0551 20 03         [12]  695 	jr	NZ,00340$
   0553 DD 34 ED      [23]  696 	inc	-19 (ix)
   0556                     697 00340$:
                            698 ;src/Map.c:171: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   0556 E1            [10]  699 	pop	hl
   0557 E5            [11]  700 	push	hl
   0558 29            [11]  701 	add	hl, hl
   0559 01 00 64      [10]  702 	ld	bc,#0x6400
   055C 09            [11]  703 	add	hl,bc
   055D DD 4E F9      [19]  704 	ld	c,-7 (ix)
   0560 0D            [ 4]  705 	dec	c
   0561 71            [ 7]  706 	ld	(hl),c
                            707 ;src/Map.c:172: (*(cellStack+lastStackItem)).y = currentPos.y;
   0562 23            [ 6]  708 	inc	hl
   0563 4D            [ 4]  709 	ld	c,l
   0564 44            [ 4]  710 	ld	b,h
   0565 DD 6E FE      [19]  711 	ld	l,-2 (ix)
   0568 DD 66 FF      [19]  712 	ld	h,-1 (ix)
   056B 7E            [ 7]  713 	ld	a,(hl)
   056C 02            [ 7]  714 	ld	(bc),a
   056D                     715 00148$:
                            716 ;src/Map.c:176: if(currentPos.x < (MAP_WIDTH-1)){
   056D DD 6E FA      [19]  717 	ld	l,-6 (ix)
   0570 DD 66 FB      [19]  718 	ld	h,-5 (ix)
   0573 4E            [ 7]  719 	ld	c,(hl)
   0574 79            [ 4]  720 	ld	a,c
   0575 D6 1F         [ 7]  721 	sub	a, #0x1F
   0577 30 3A         [12]  722 	jr	NC,00152$
                            723 ;src/Map.c:178: adjacentType = map[currentPos.x+1][currentPos.y];
   0579 69            [ 4]  724 	ld	l,c
   057A 26 00         [ 7]  725 	ld	h,#0x00
   057C 23            [ 6]  726 	inc	hl
   057D 29            [11]  727 	add	hl, hl
   057E 29            [11]  728 	add	hl, hl
   057F 29            [11]  729 	add	hl, hl
   0580 29            [11]  730 	add	hl, hl
   0581 29            [11]  731 	add	hl, hl
   0582 EB            [ 4]  732 	ex	de,hl
   0583 21 00 60      [10]  733 	ld	hl,#0x6000
   0586 19            [11]  734 	add	hl,de
   0587 EB            [ 4]  735 	ex	de,hl
   0588 DD 6E FE      [19]  736 	ld	l,-2 (ix)
   058B DD 66 FF      [19]  737 	ld	h,-1 (ix)
   058E 6E            [ 7]  738 	ld	l, (hl)
   058F 26 00         [ 7]  739 	ld	h,#0x00
   0591 19            [11]  740 	add	hl,de
   0592 7E            [ 7]  741 	ld	a,(hl)
                            742 ;src/Map.c:179: if(adjacentType == CELLTYPE_UNDEFINED){
   0593 D6 87         [ 7]  743 	sub	a, #0x87
   0595 20 1C         [12]  744 	jr	NZ,00152$
                            745 ;src/Map.c:182: ++lastStackItem;
   0597 DD 34 EC      [23]  746 	inc	-20 (ix)
   059A 20 03         [12]  747 	jr	NZ,00343$
   059C DD 34 ED      [23]  748 	inc	-19 (ix)
   059F                     749 00343$:
                            750 ;src/Map.c:183: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   059F E1            [10]  751 	pop	hl
   05A0 E5            [11]  752 	push	hl
   05A1 29            [11]  753 	add	hl, hl
   05A2 11 00 64      [10]  754 	ld	de,#0x6400
   05A5 19            [11]  755 	add	hl,de
   05A6 0C            [ 4]  756 	inc	c
   05A7 71            [ 7]  757 	ld	(hl),c
                            758 ;src/Map.c:184: (*(cellStack+lastStackItem)).y = currentPos.y;
   05A8 23            [ 6]  759 	inc	hl
   05A9 4D            [ 4]  760 	ld	c,l
   05AA 44            [ 4]  761 	ld	b,h
   05AB DD 6E FE      [19]  762 	ld	l,-2 (ix)
   05AE DD 66 FF      [19]  763 	ld	h,-1 (ix)
   05B1 7E            [ 7]  764 	ld	a,(hl)
   05B2 02            [ 7]  765 	ld	(bc),a
   05B3                     766 00152$:
                            767 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   05B3 DD 6E FE      [19]  768 	ld	l,-2 (ix)
   05B6 DD 66 FF      [19]  769 	ld	h,-1 (ix)
   05B9 4E            [ 7]  770 	ld	c,(hl)
                            771 ;src/Map.c:188: if(currentPos.y > 0){
   05BA 79            [ 4]  772 	ld	a,c
   05BB B7            [ 4]  773 	or	a, a
   05BC 28 3A         [12]  774 	jr	Z,00156$
                            775 ;src/Map.c:190: adjacentType = map[currentPos.x][currentPos.y-1];
   05BE DD 6E FA      [19]  776 	ld	l,-6 (ix)
   05C1 DD 66 FB      [19]  777 	ld	h,-5 (ix)
   05C4 46            [ 7]  778 	ld	b,(hl)
   05C5 68            [ 4]  779 	ld	l,b
   05C6 26 00         [ 7]  780 	ld	h,#0x00
   05C8 29            [11]  781 	add	hl, hl
   05C9 29            [11]  782 	add	hl, hl
   05CA 29            [11]  783 	add	hl, hl
   05CB 29            [11]  784 	add	hl, hl
   05CC 29            [11]  785 	add	hl, hl
   05CD 11 00 60      [10]  786 	ld	de,#0x6000
   05D0 19            [11]  787 	add	hl,de
   05D1 0D            [ 4]  788 	dec	c
   05D2 59            [ 4]  789 	ld	e,c
   05D3 16 00         [ 7]  790 	ld	d,#0x00
   05D5 19            [11]  791 	add	hl,de
   05D6 7E            [ 7]  792 	ld	a,(hl)
                            793 ;src/Map.c:191: if(adjacentType == CELLTYPE_UNDEFINED){
   05D7 D6 87         [ 7]  794 	sub	a, #0x87
   05D9 20 1D         [12]  795 	jr	NZ,00156$
                            796 ;src/Map.c:194: ++lastStackItem;
   05DB DD 34 EC      [23]  797 	inc	-20 (ix)
   05DE 20 03         [12]  798 	jr	NZ,00346$
   05E0 DD 34 ED      [23]  799 	inc	-19 (ix)
   05E3                     800 00346$:
                            801 ;src/Map.c:195: (*(cellStack+lastStackItem)).x = currentPos.x;
   05E3 E1            [10]  802 	pop	hl
   05E4 E5            [11]  803 	push	hl
   05E5 29            [11]  804 	add	hl, hl
   05E6 11 00 64      [10]  805 	ld	de,#0x6400
   05E9 19            [11]  806 	add	hl,de
   05EA 70            [ 7]  807 	ld	(hl),b
                            808 ;src/Map.c:196: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   05EB 23            [ 6]  809 	inc	hl
   05EC 4D            [ 4]  810 	ld	c,l
   05ED 44            [ 4]  811 	ld	b,h
   05EE DD 6E FE      [19]  812 	ld	l,-2 (ix)
   05F1 DD 66 FF      [19]  813 	ld	h,-1 (ix)
   05F4 5E            [ 7]  814 	ld	e,(hl)
   05F5 1D            [ 4]  815 	dec	e
   05F6 7B            [ 4]  816 	ld	a,e
   05F7 02            [ 7]  817 	ld	(bc),a
   05F8                     818 00156$:
                            819 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   05F8 DD 6E FE      [19]  820 	ld	l,-2 (ix)
   05FB DD 66 FF      [19]  821 	ld	h,-1 (ix)
   05FE 46            [ 7]  822 	ld	b,(hl)
                            823 ;src/Map.c:200: if(currentPos.y < (MAP_HEIGHT-1)){
   05FF 78            [ 4]  824 	ld	a,b
   0600 D6 1F         [ 7]  825 	sub	a, #0x1F
   0602 D2 8C 04      [10]  826 	jp	NC,00164$
                            827 ;src/Map.c:202: adjacentType = map[currentPos.x][currentPos.y+1];
   0605 DD 6E FA      [19]  828 	ld	l,-6 (ix)
   0608 DD 66 FB      [19]  829 	ld	h,-5 (ix)
   060B 4E            [ 7]  830 	ld	c,(hl)
   060C 69            [ 4]  831 	ld	l,c
   060D 26 00         [ 7]  832 	ld	h,#0x00
   060F 29            [11]  833 	add	hl, hl
   0610 29            [11]  834 	add	hl, hl
   0611 29            [11]  835 	add	hl, hl
   0612 29            [11]  836 	add	hl, hl
   0613 29            [11]  837 	add	hl, hl
   0614 11 00 60      [10]  838 	ld	de,#0x6000
   0617 19            [11]  839 	add	hl,de
   0618 04            [ 4]  840 	inc	b
   0619 58            [ 4]  841 	ld	e,b
   061A 16 00         [ 7]  842 	ld	d,#0x00
   061C 19            [11]  843 	add	hl,de
   061D 7E            [ 7]  844 	ld	a,(hl)
                            845 ;src/Map.c:203: if(adjacentType == CELLTYPE_UNDEFINED){
   061E D6 87         [ 7]  846 	sub	a, #0x87
   0620 C2 8C 04      [10]  847 	jp	NZ,00164$
                            848 ;src/Map.c:206: ++lastStackItem;
   0623 DD 34 EC      [23]  849 	inc	-20 (ix)
   0626 20 03         [12]  850 	jr	NZ,00349$
   0628 DD 34 ED      [23]  851 	inc	-19 (ix)
   062B                     852 00349$:
                            853 ;src/Map.c:207: (*(cellStack+lastStackItem)).x = currentPos.x;
   062B E1            [10]  854 	pop	hl
   062C E5            [11]  855 	push	hl
   062D 29            [11]  856 	add	hl, hl
   062E 11 00 64      [10]  857 	ld	de,#0x6400
   0631 19            [11]  858 	add	hl,de
   0632 71            [ 7]  859 	ld	(hl),c
                            860 ;src/Map.c:208: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   0633 23            [ 6]  861 	inc	hl
   0634 4D            [ 4]  862 	ld	c,l
   0635 44            [ 4]  863 	ld	b,h
   0636 DD 6E FE      [19]  864 	ld	l,-2 (ix)
   0639 DD 66 FF      [19]  865 	ld	h,-1 (ix)
   063C 7E            [ 7]  866 	ld	a,(hl)
   063D 3C            [ 4]  867 	inc	a
   063E 02            [ 7]  868 	ld	(bc),a
   063F C3 8C 04      [10]  869 	jp	00164$
   0642                     870 00162$:
                            871 ;src/Map.c:214: ++wallListCount;
   0642 DD 34 FC      [23]  872 	inc	-4 (ix)
   0645 20 03         [12]  873 	jr	NZ,00350$
   0647 DD 34 FD      [23]  874 	inc	-3 (ix)
   064A                     875 00350$:
   064A DD 7E FC      [19]  876 	ld	a,-4 (ix)
   064D DD 77 EE      [19]  877 	ld	-18 (ix),a
   0650 DD 7E FD      [19]  878 	ld	a,-3 (ix)
   0653 DD 77 EF      [19]  879 	ld	-17 (ix),a
                            880 ;src/Map.c:215: (*(wallList+wallListCount)).x = currentPos.x;
   0656 DD 6E FC      [19]  881 	ld	l,-4 (ix)
   0659 DD 66 FD      [19]  882 	ld	h,-3 (ix)
   065C 29            [11]  883 	add	hl, hl
   065D 01 00 68      [10]  884 	ld	bc,#0x6800
   0660 09            [11]  885 	add	hl,bc
   0661 DD 7E F9      [19]  886 	ld	a,-7 (ix)
   0664 77            [ 7]  887 	ld	(hl),a
                            888 ;src/Map.c:216: (*(wallList+wallListCount)).y = currentPos.y;
   0665 23            [ 6]  889 	inc	hl
   0666 4D            [ 4]  890 	ld	c,l
   0667 44            [ 4]  891 	ld	b,h
   0668 DD 6E FE      [19]  892 	ld	l,-2 (ix)
   066B DD 66 FF      [19]  893 	ld	h,-1 (ix)
   066E 7E            [ 7]  894 	ld	a,(hl)
   066F 02            [ 7]  895 	ld	(bc),a
   0670 C3 8C 04      [10]  896 	jp	00164$
   0673                     897 00174$:
   0673 DD F9         [10]  898 	ld	sp, ix
   0675 DD E1         [14]  899 	pop	ix
   0677 C9            [10]  900 	ret
                            901 ;src/Map.c:222: void generate_exit_door(){
                            902 ;	---------------------------------
                            903 ; Function generate_exit_door
                            904 ; ---------------------------------
   0678                     905 _generate_exit_door::
   0678 DD E5         [15]  906 	push	ix
   067A DD 21 00 00   [14]  907 	ld	ix,#0
   067E DD 39         [15]  908 	add	ix,sp
   0680 21 F2 FF      [10]  909 	ld	hl,#-14
   0683 39            [11]  910 	add	hl,sp
   0684 F9            [ 6]  911 	ld	sp,hl
                            912 ;src/Map.c:223: u8 x=(cpct_getRandom_lcg_u8()%32);
   0685 CD 7E 48      [17]  913 	call	_cpct_getRandom_lcg_u8
   0688 7D            [ 4]  914 	ld	a,l
   0689 E6 1F         [ 7]  915 	and	a, #0x1F
   068B 4F            [ 4]  916 	ld	c,a
                            917 ;src/Map.c:224: u8 y=(cpct_getRandom_lcg_u8()%32);
   068C C5            [11]  918 	push	bc
   068D CD 7E 48      [17]  919 	call	_cpct_getRandom_lcg_u8
   0690 C1            [10]  920 	pop	bc
   0691 7D            [ 4]  921 	ld	a,l
   0692 E6 1F         [ 7]  922 	and	a, #0x1F
   0694 5F            [ 4]  923 	ld	e,a
                            924 ;src/Map.c:225: u8 door_not_positioned=1;
   0695 DD 36 F2 01   [19]  925 	ld	-14 (ix),#0x01
                            926 ;src/Map.c:232: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
   0699 06 00         [ 7]  927 	ld	b,#0x00
   069B 21 00 60      [10]  928 	ld	hl,#0x6000
   069E 09            [11]  929 	add	hl,bc
   069F 4D            [ 4]  930 	ld	c,l
   06A0 44            [ 4]  931 	ld	b,h
   06A1 6B            [ 4]  932 	ld	l,e
   06A2 26 00         [ 7]  933 	ld	h,#0x00
   06A4 29            [11]  934 	add	hl, hl
   06A5 29            [11]  935 	add	hl, hl
   06A6 29            [11]  936 	add	hl, hl
   06A7 29            [11]  937 	add	hl, hl
   06A8 29            [11]  938 	add	hl, hl
   06A9 09            [11]  939 	add	hl,bc
   06AA 4D            [ 4]  940 	ld	c,l
   06AB 44            [ 4]  941 	ld	b,h
                            942 ;src/Map.c:237: lastVal = (position-1);
   06AC 59            [ 4]  943 	ld	e,c
   06AD 50            [ 4]  944 	ld	d,b
   06AE 1B            [ 6]  945 	dec	de
                            946 ;src/Map.c:238: nextVal = (position+1);
   06AF 21 01 00      [10]  947 	ld	hl,#0x0001
   06B2 09            [11]  948 	add	hl,bc
   06B3 DD 75 F5      [19]  949 	ld	-11 (ix),l
   06B6 DD 74 F6      [19]  950 	ld	-10 (ix),h
                            951 ;src/Map.c:239: topVal = (position-MAP_WIDTH);
   06B9 79            [ 4]  952 	ld	a,c
   06BA C6 E0         [ 7]  953 	add	a,#0xE0
   06BC DD 77 F3      [19]  954 	ld	-13 (ix),a
   06BF 78            [ 4]  955 	ld	a,b
   06C0 CE FF         [ 7]  956 	adc	a,#0xFF
   06C2 DD 77 F4      [19]  957 	ld	-12 (ix),a
                            958 ;src/Map.c:240: bottomVal = (position+MAP_WIDTH);
   06C5 FD 21 20 00   [14]  959 	ld	iy,#0x0020
   06C9 FD 09         [15]  960 	add	iy, bc
                            961 ;src/Map.c:242: while(door_not_positioned){
   06CB                     962 00138$:
   06CB DD 7E F2      [19]  963 	ld	a,-14 (ix)
   06CE B7            [ 4]  964 	or	a, a
   06CF CA 27 08      [10]  965 	jp	Z,00141$
                            966 ;src/Map.c:243: if((*position)!=CELLTYPE_FLOOR){
   06D2 0A            [ 7]  967 	ld	a,(bc)
   06D3 B7            [ 4]  968 	or	a, a
   06D4 CA E9 07      [10]  969 	jp	Z,00135$
                            970 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   06D7 1A            [ 7]  971 	ld	a,(de)
   06D8 DD 77 FD      [19]  972 	ld	-3 (ix),a
   06DB DD 73 F7      [19]  973 	ld	-9 (ix),e
   06DE DD 72 F8      [19]  974 	ld	-8 (ix),d
   06E1 DD 7E F5      [19]  975 	ld	a,-11 (ix)
   06E4 DD 77 FB      [19]  976 	ld	-5 (ix),a
   06E7 DD 7E F6      [19]  977 	ld	a,-10 (ix)
   06EA DD 77 FC      [19]  978 	ld	-4 (ix),a
                            979 ;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   06ED DD 6E F3      [19]  980 	ld	l,-13 (ix)
   06F0 DD 66 F4      [19]  981 	ld	h,-12 (ix)
   06F3 7E            [ 7]  982 	ld	a,(hl)
   06F4 DD 77 FA      [19]  983 	ld	-6 (ix),a
   06F7 DD 7E F3      [19]  984 	ld	a,-13 (ix)
   06FA DD 77 FE      [19]  985 	ld	-2 (ix),a
   06FD DD 7E F4      [19]  986 	ld	a,-12 (ix)
   0700 DD 77 FF      [19]  987 	ld	-1 (ix),a
   0703 FD E5         [15]  988 	push	iy
   0705 E1            [10]  989 	pop	hl
                            990 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   0706 DD 7E F8      [19]  991 	ld	a,-8 (ix)
   0709 D6 60         [ 7]  992 	sub	a, #0x60
   070B 3E 00         [ 7]  993 	ld	a,#0x00
   070D 17            [ 4]  994 	rla
   070E DD 77 F7      [19]  995 	ld	-9 (ix),a
   0711 DD 7E FC      [19]  996 	ld	a,-4 (ix)
   0714 D6 64         [ 7]  997 	sub	a, #0x64
   0716 3E 00         [ 7]  998 	ld	a,#0x00
   0718 17            [ 4]  999 	rla
   0719 DD 77 FB      [19] 1000 	ld	-5 (ix),a
                           1001 ;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   071C DD 7E FF      [19] 1002 	ld	a,-1 (ix)
   071F D6 60         [ 7] 1003 	sub	a, #0x60
   0721 3E 00         [ 7] 1004 	ld	a,#0x00
   0723 17            [ 4] 1005 	rla
   0724 DD 77 FE      [19] 1006 	ld	-2 (ix),a
   0727 7C            [ 4] 1007 	ld	a,h
   0728 D6 64         [ 7] 1008 	sub	a, #0x64
   072A 3E 00         [ 7] 1009 	ld	a,#0x00
   072C 17            [ 4] 1010 	rla
   072D DD 77 F9      [19] 1011 	ld	-7 (ix),a
                           1012 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   0730 DD 7E FD      [19] 1013 	ld	a,-3 (ix)
   0733 B7            [ 4] 1014 	or	a, a
   0734 20 06         [12] 1015 	jr	NZ,00133$
   0736 DD 7E F7      [19] 1016 	ld	a,-9 (ix)
   0739 B7            [ 4] 1017 	or	a, a
   073A 28 52         [12] 1018 	jr	Z,00129$
   073C                    1019 00133$:
   073C DD 6E F5      [19] 1020 	ld	l,-11 (ix)
   073F DD 66 F6      [19] 1021 	ld	h,-10 (ix)
   0742 7E            [ 7] 1022 	ld	a,(hl)
   0743 B7            [ 4] 1023 	or	a, a
   0744 20 06         [12] 1024 	jr	NZ,00128$
   0746 DD CB FB 46   [20] 1025 	bit	0,-5 (ix)
   074A 20 42         [12] 1026 	jr	NZ,00129$
   074C                    1027 00128$:
                           1028 ;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   074C FD 6E 00      [19] 1029 	ld	l, 0 (iy)
   074F DD 7E FA      [19] 1030 	ld	a,-6 (ix)
   0752 B7            [ 4] 1031 	or	a, a
   0753 20 06         [12] 1032 	jr	NZ,00111$
   0755 DD 7E FE      [19] 1033 	ld	a,-2 (ix)
   0758 B7            [ 4] 1034 	or	a, a
   0759 28 14         [12] 1035 	jr	Z,00107$
   075B                    1036 00111$:
   075B 7D            [ 4] 1037 	ld	a,l
   075C B7            [ 4] 1038 	or	a, a
   075D 20 10         [12] 1039 	jr	NZ,00107$
   075F DD 7E F9      [19] 1040 	ld	a,-7 (ix)
   0762 B7            [ 4] 1041 	or	a, a
   0763 28 0A         [12] 1042 	jr	Z,00107$
                           1043 ;src/Map.c:246: door_not_positioned=0;
   0765 DD 36 F2 00   [19] 1044 	ld	-14 (ix),#0x00
                           1045 ;src/Map.c:247: *position=CELLTYPE_DOOR;
   0769 3E 80         [ 7] 1046 	ld	a,#0x80
   076B 02            [ 7] 1047 	ld	(bc),a
   076C C3 E9 07      [10] 1048 	jp	00135$
   076F                    1049 00107$:
                           1050 ;src/Map.c:249: else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
   076F 7D            [ 4] 1051 	ld	a,l
   0770 B7            [ 4] 1052 	or	a, a
   0771 20 06         [12] 1053 	jr	NZ,00105$
   0773 DD 7E F9      [19] 1054 	ld	a,-7 (ix)
   0776 B7            [ 4] 1055 	or	a, a
   0777 20 70         [12] 1056 	jr	NZ,00135$
   0779                    1057 00105$:
   0779 DD 7E FA      [19] 1058 	ld	a,-6 (ix)
   077C B7            [ 4] 1059 	or	a, a
   077D 20 6A         [12] 1060 	jr	NZ,00135$
   077F DD 7E FE      [19] 1061 	ld	a,-2 (ix)
   0782 B7            [ 4] 1062 	or	a, a
   0783 20 64         [12] 1063 	jr	NZ,00135$
                           1064 ;src/Map.c:250: door_not_positioned=0;
   0785 DD 36 F2 00   [19] 1065 	ld	-14 (ix),#0x00
                           1066 ;src/Map.c:251: *position=CELLTYPE_DOOR;
   0789 3E 80         [ 7] 1067 	ld	a,#0x80
   078B 02            [ 7] 1068 	ld	(bc),a
   078C 18 5B         [12] 1069 	jr	00135$
   078E                    1070 00129$:
                           1071 ;src/Map.c:254: else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
   078E DD 7E FA      [19] 1072 	ld	a,-6 (ix)
   0791 B7            [ 4] 1073 	or	a, a
   0792 20 06         [12] 1074 	jr	NZ,00127$
   0794 DD 7E FE      [19] 1075 	ld	a,-2 (ix)
   0797 B7            [ 4] 1076 	or	a, a
   0798 28 4F         [12] 1077 	jr	Z,00135$
   079A                    1078 00127$:
   079A FD 7E 00      [19] 1079 	ld	a, 0 (iy)
   079D B7            [ 4] 1080 	or	a, a
   079E 20 06         [12] 1081 	jr	NZ,00123$
   07A0 DD 7E F9      [19] 1082 	ld	a,-7 (ix)
   07A3 B7            [ 4] 1083 	or	a, a
   07A4 20 43         [12] 1084 	jr	NZ,00135$
   07A6                    1085 00123$:
                           1086 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   07A6 DD 6E F5      [19] 1087 	ld	l,-11 (ix)
   07A9 DD 66 F6      [19] 1088 	ld	h,-10 (ix)
   07AC 6E            [ 7] 1089 	ld	l,(hl)
                           1090 ;src/Map.c:255: if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
   07AD DD 7E FD      [19] 1091 	ld	a,-3 (ix)
   07B0 B7            [ 4] 1092 	or	a, a
   07B1 20 06         [12] 1093 	jr	NZ,00122$
   07B3 DD 7E F7      [19] 1094 	ld	a,-9 (ix)
   07B6 B7            [ 4] 1095 	or	a, a
   07B7 28 13         [12] 1096 	jr	Z,00118$
   07B9                    1097 00122$:
   07B9 7D            [ 4] 1098 	ld	a,l
   07BA B7            [ 4] 1099 	or	a, a
   07BB 20 0F         [12] 1100 	jr	NZ,00118$
   07BD DD CB FB 46   [20] 1101 	bit	0,-5 (ix)
   07C1 28 09         [12] 1102 	jr	Z,00118$
                           1103 ;src/Map.c:256: door_not_positioned=0;
   07C3 DD 36 F2 00   [19] 1104 	ld	-14 (ix),#0x00
                           1105 ;src/Map.c:257: *position=CELLTYPE_DOOR;
   07C7 3E 80         [ 7] 1106 	ld	a,#0x80
   07C9 02            [ 7] 1107 	ld	(bc),a
   07CA 18 1D         [12] 1108 	jr	00135$
   07CC                    1109 00118$:
                           1110 ;src/Map.c:259: else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
   07CC 7D            [ 4] 1111 	ld	a,l
   07CD B7            [ 4] 1112 	or	a, a
   07CE 20 06         [12] 1113 	jr	NZ,00116$
   07D0 DD CB FB 46   [20] 1114 	bit	0,-5 (ix)
   07D4 20 13         [12] 1115 	jr	NZ,00135$
   07D6                    1116 00116$:
   07D6 DD 7E FD      [19] 1117 	ld	a,-3 (ix)
   07D9 B7            [ 4] 1118 	or	a, a
   07DA 20 0D         [12] 1119 	jr	NZ,00135$
   07DC DD 7E F7      [19] 1120 	ld	a,-9 (ix)
   07DF B7            [ 4] 1121 	or	a, a
   07E0 20 07         [12] 1122 	jr	NZ,00135$
                           1123 ;src/Map.c:260: door_not_positioned=0;
   07E2 DD 36 F2 00   [19] 1124 	ld	-14 (ix),#0x00
                           1125 ;src/Map.c:261: *position=CELLTYPE_DOOR;
   07E6 3E 80         [ 7] 1126 	ld	a,#0x80
   07E8 02            [ 7] 1127 	ld	(bc),a
   07E9                    1128 00135$:
                           1129 ;src/Map.c:265: ++position;
   07E9 03            [ 6] 1130 	inc	bc
                           1131 ;src/Map.c:266: ++lastVal;
   07EA 13            [ 6] 1132 	inc	de
                           1133 ;src/Map.c:267: ++nextVal;
   07EB DD 34 F5      [23] 1134 	inc	-11 (ix)
   07EE 20 03         [12] 1135 	jr	NZ,00223$
   07F0 DD 34 F6      [23] 1136 	inc	-10 (ix)
   07F3                    1137 00223$:
                           1138 ;src/Map.c:268: ++topVal;
   07F3 DD 34 F3      [23] 1139 	inc	-13 (ix)
   07F6 20 03         [12] 1140 	jr	NZ,00224$
   07F8 DD 34 F4      [23] 1141 	inc	-12 (ix)
   07FB                    1142 00224$:
                           1143 ;src/Map.c:269: ++bottomVal;
   07FB FD 23         [10] 1144 	inc	iy
                           1145 ;src/Map.c:270: if(position==END_OF_MAP_MEM){
   07FD 69            [ 4] 1146 	ld	l, c
   07FE 60            [ 4] 1147 	ld	h, b
   07FF 7D            [ 4] 1148 	ld	a,l
   0800 B7            [ 4] 1149 	or	a, a
   0801 C2 CB 06      [10] 1150 	jp	NZ,00138$
   0804 7C            [ 4] 1151 	ld	a,h
   0805 D6 64         [ 7] 1152 	sub	a, #0x64
   0807 C2 CB 06      [10] 1153 	jp	NZ,00138$
                           1154 ;src/Map.c:271: position = MAP_MEM;
   080A 01 00 60      [10] 1155 	ld	bc,#0x6000
                           1156 ;src/Map.c:272: lastVal = (position-1);
   080D 11 FF 5F      [10] 1157 	ld	de,#0x5FFF
                           1158 ;src/Map.c:273: nextVal = (position+1);
   0810 DD 36 F5 01   [19] 1159 	ld	-11 (ix),#0x01
   0814 DD 36 F6 60   [19] 1160 	ld	-10 (ix),#0x60
                           1161 ;src/Map.c:274: topVal = (position-MAP_WIDTH);
   0818 DD 36 F3 E0   [19] 1162 	ld	-13 (ix),#0xE0
   081C DD 36 F4 5F   [19] 1163 	ld	-12 (ix),#0x5F
                           1164 ;src/Map.c:275: bottomVal = (position+MAP_WIDTH);
   0820 FD 21 20 60   [14] 1165 	ld	iy,#0x6020
   0824 C3 CB 06      [10] 1166 	jp	00138$
   0827                    1167 00141$:
   0827 DD F9         [10] 1168 	ld	sp, ix
   0829 DD E1         [14] 1169 	pop	ix
   082B C9            [10] 1170 	ret
                           1171 ;src/Map.c:281: void generate_level(){
                           1172 ;	---------------------------------
                           1173 ; Function generate_level
                           1174 ; ---------------------------------
   082C                    1175 _generate_level::
                           1176 ;src/Map.c:282: generate_level_with_seed(r_counter);
   082C 3A A9 4A      [13] 1177 	ld	a,(_r_counter)
   082F F5            [11] 1178 	push	af
   0830 33            [ 6] 1179 	inc	sp
   0831 CD 36 08      [17] 1180 	call	_generate_level_with_seed
   0834 33            [ 6] 1181 	inc	sp
   0835 C9            [10] 1182 	ret
                           1183 ;src/Map.c:285: void generate_level_with_seed(u8 seed){
                           1184 ;	---------------------------------
                           1185 ; Function generate_level_with_seed
                           1186 ; ---------------------------------
   0836                    1187 _generate_level_with_seed::
                           1188 ;src/Map.c:287: rand_seed=seed;
   0836 21 02 00      [10] 1189 	ld	hl, #2+0
   0839 39            [11] 1190 	add	hl, sp
   083A 7E            [ 7] 1191 	ld	a, (hl)
   083B 32 AA 4A      [13] 1192 	ld	(#_rand_seed + 0),a
                           1193 ;src/Map.c:288: cpct_setSeed_lcg_u8(seed+level_get_level());
   083E CD B5 00      [17] 1194 	call	_level_get_level
   0841 FD 21 02 00   [14] 1195 	ld	iy,#2
   0845 FD 39         [15] 1196 	add	iy,sp
   0847 FD 7E 00      [19] 1197 	ld	a,0 (iy)
   084A 85            [ 4] 1198 	add	a, l
   084B 6F            [ 4] 1199 	ld	l,a
   084C CD 24 48      [17] 1200 	call	_cpct_setSeed_lcg_u8
                           1201 ;src/Map.c:290: generate_map();
   084F CD C3 01      [17] 1202 	call	_generate_map
                           1203 ;src/Map.c:291: generate_exit_door();
   0852 CD 78 06      [17] 1204 	call	_generate_exit_door
                           1205 ;src/Map.c:292: *(u8*)(MAP_MEM + 6 + MAP_WIDTH*5)=0b00000001;
   0855 21 A6 60      [10] 1206 	ld	hl,#0x60A6
   0858 36 01         [10] 1207 	ld	(hl),#0x01
   085A C9            [10] 1208 	ret
                           1209 	.area _CODE
                           1210 	.area _INITIALIZER
   4AB7                    1211 __xinit__rand_seed:
   4AB7 00                 1212 	.db #0x00	; 0
                           1213 	.area _CABS (ABS)
