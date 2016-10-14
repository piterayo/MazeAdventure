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
   4916                      34 _rand_seed::
   4916                      35 	.ds 1
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
   01AD                      60 _map_get_seed::
                             61 ;src/Map.c:15: return rand_seed;
   01AD FD 21 16 49   [14]   62 	ld	iy,#_rand_seed
   01B1 FD 6E 00      [19]   63 	ld	l,0 (iy)
   01B4 C9            [10]   64 	ret
                             65 ;src/Map.c:18: u8 get_random_wall(){
                             66 ;	---------------------------------
                             67 ; Function get_random_wall
                             68 ; ---------------------------------
   01B5                      69 _get_random_wall::
                             70 ;src/Map.c:19: u8 cellType = cpct_getRandom_lcg_u8();
   01B5 CD CA 46      [17]   71 	call	_cpct_getRandom_lcg_u8
                             72 ;src/Map.c:20: if(cellType&1){
   01B8 CB 45         [ 8]   73 	bit	0, l
   01BA 28 03         [12]   74 	jr	Z,00108$
                             75 ;src/Map.c:21: return CELLTYPE_WALL1;
   01BC 2E 81         [ 7]   76 	ld	l,#0x81
   01BE C9            [10]   77 	ret
   01BF                      78 00108$:
                             79 ;src/Map.c:24: if(cellType&3){
   01BF 7D            [ 4]   80 	ld	a,l
   01C0 E6 03         [ 7]   81 	and	a, #0x03
   01C2 28 03         [12]   82 	jr	Z,00105$
                             83 ;src/Map.c:25: return CELLTYPE_WALL2;
   01C4 2E 82         [ 7]   84 	ld	l,#0x82
   01C6 C9            [10]   85 	ret
   01C7                      86 00105$:
                             87 ;src/Map.c:28: if(cellType&5){
   01C7 7D            [ 4]   88 	ld	a,l
   01C8 E6 05         [ 7]   89 	and	a, #0x05
   01CA 28 03         [12]   90 	jr	Z,00102$
                             91 ;src/Map.c:29: return CELLTYPE_WALL3;
   01CC 2E 83         [ 7]   92 	ld	l,#0x83
   01CE C9            [10]   93 	ret
   01CF                      94 00102$:
                             95 ;src/Map.c:32: return CELLTYPE_WALL4;  
   01CF 2E 84         [ 7]   96 	ld	l,#0x84
   01D1 C9            [10]   97 	ret
                             98 ;src/Map.c:38: void generate_map(){
                             99 ;	---------------------------------
                            100 ; Function generate_map
                            101 ; ---------------------------------
   01D2                     102 _generate_map::
   01D2 DD E5         [15]  103 	push	ix
   01D4 DD 21 00 00   [14]  104 	ld	ix,#0
   01D8 DD 39         [15]  105 	add	ix,sp
   01DA 21 EC FF      [10]  106 	ld	hl,#-20
   01DD 39            [11]  107 	add	hl,sp
   01DE F9            [ 6]  108 	ld	sp,hl
                            109 ;src/Map.c:41: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
   01DF DD 36 F2 83   [19]  110 	ld	-14 (ix),#0x83
   01E3 DD 36 F3 03   [19]  111 	ld	-13 (ix),#0x03
                            112 ;src/Map.c:47: u16 wallListCount = 0;
   01E7 DD 36 EE 00   [19]  113 	ld	-18 (ix),#0x00
   01EB DD 36 EF 00   [19]  114 	ld	-17 (ix),#0x00
                            115 ;src/Map.c:48: u16 lastStackItem = 0;
   01EF 21 00 00      [10]  116 	ld	hl,#0x0000
   01F2 E3            [19]  117 	ex	(sp), hl
                            118 ;src/Map.c:50: cpct_memset (GENERATOR_DATA_PTR, 0, 4096);
   01F3 21 00 10      [10]  119 	ld	hl,#0x1000
   01F6 E5            [11]  120 	push	hl
   01F7 AF            [ 4]  121 	xor	a, a
   01F8 F5            [11]  122 	push	af
   01F9 33            [ 6]  123 	inc	sp
   01FA 26 64         [ 7]  124 	ld	h, #0x64
   01FC E5            [11]  125 	push	hl
   01FD CD F1 46      [17]  126 	call	_cpct_memset
                            127 ;src/Map.c:52: (*cellStack).x = (cpct_getRandom_lcg_u8()%(MAP_WIDTH-2))+1; //RANDOM
   0200 CD CA 46      [17]  128 	call	_cpct_getRandom_lcg_u8
   0203 45            [ 4]  129 	ld	b,l
   0204 3E 1E         [ 7]  130 	ld	a,#0x1E
   0206 F5            [11]  131 	push	af
   0207 33            [ 6]  132 	inc	sp
   0208 C5            [11]  133 	push	bc
   0209 33            [ 6]  134 	inc	sp
   020A CD 18 46      [17]  135 	call	__moduchar
   020D F1            [10]  136 	pop	af
   020E 4D            [ 4]  137 	ld	c,l
   020F 0C            [ 4]  138 	inc	c
   0210 21 00 64      [10]  139 	ld	hl,#0x6400
   0213 71            [ 7]  140 	ld	(hl),c
                            141 ;src/Map.c:53: (*cellStack).y = (cpct_getRandom_lcg_u8()%(MAP_HEIGHT-2))+1; //RANDOM
   0214 CD CA 46      [17]  142 	call	_cpct_getRandom_lcg_u8
   0217 45            [ 4]  143 	ld	b,l
   0218 3E 1E         [ 7]  144 	ld	a,#0x1E
   021A F5            [11]  145 	push	af
   021B 33            [ 6]  146 	inc	sp
   021C C5            [11]  147 	push	bc
   021D 33            [ 6]  148 	inc	sp
   021E CD 18 46      [17]  149 	call	__moduchar
   0221 F1            [10]  150 	pop	af
   0222 4D            [ 4]  151 	ld	c,l
   0223 0C            [ 4]  152 	inc	c
   0224 21 01 64      [10]  153 	ld	hl,#0x6401
   0227 71            [ 7]  154 	ld	(hl),c
                            155 ;src/Map.c:55: rotatePlayer = cpct_getRandom_lcg_u8()%4;
   0228 CD CA 46      [17]  156 	call	_cpct_getRandom_lcg_u8
   022B 7D            [ 4]  157 	ld	a,l
   022C E6 03         [ 7]  158 	and	a, #0x03
   022E 4F            [ 4]  159 	ld	c,a
                            160 ;src/Map.c:56: while(rotatePlayer){
   022F                     161 00101$:
   022F 79            [ 4]  162 	ld	a,c
   0230 B7            [ 4]  163 	or	a, a
   0231 28 08         [12]  164 	jr	Z,00103$
                            165 ;src/Map.c:57: player_turn_left();
   0233 C5            [11]  166 	push	bc
   0234 CD 6A 08      [17]  167 	call	_player_turn_left
   0237 C1            [10]  168 	pop	bc
                            169 ;src/Map.c:58: --rotatePlayer;
   0238 0D            [ 4]  170 	dec	c
   0239 18 F4         [12]  171 	jr	00101$
   023B                     172 00103$:
                            173 ;src/Map.c:61: *(i8*)&(player_position.x) = (*cellStack).y;
   023B 01 98 08      [10]  174 	ld	bc,#_player_position+0
   023E 3A 01 64      [13]  175 	ld	a,(#0x6401)
   0241 02            [ 7]  176 	ld	(bc),a
                            177 ;src/Map.c:62: *(i8*)&(player_position.y) = (*cellStack).x;
   0242 01 99 08      [10]  178 	ld	bc,#_player_position+1
   0245 3A 00 64      [13]  179 	ld	a,(#0x6400)
   0248 02            [ 7]  180 	ld	(bc),a
                            181 ;src/Map.c:64: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   0249 21 00 04      [10]  182 	ld	hl,#0x0400
   024C E5            [11]  183 	push	hl
   024D 3E 87         [ 7]  184 	ld	a,#0x87
   024F F5            [11]  185 	push	af
   0250 33            [ 6]  186 	inc	sp
   0251 26 60         [ 7]  187 	ld	h, #0x60
   0253 E5            [11]  188 	push	hl
   0254 CD F1 46      [17]  189 	call	_cpct_memset
                            190 ;src/Map.c:67: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   0257 21 00 64      [10]  191 	ld	hl,#0x6400
   025A 6E            [ 7]  192 	ld	l,(hl)
   025B 26 00         [ 7]  193 	ld	h,#0x00
   025D 29            [11]  194 	add	hl, hl
   025E 29            [11]  195 	add	hl, hl
   025F 29            [11]  196 	add	hl, hl
   0260 29            [11]  197 	add	hl, hl
   0261 29            [11]  198 	add	hl, hl
   0262 01 00 60      [10]  199 	ld	bc,#0x6000
   0265 09            [11]  200 	add	hl,bc
   0266 4D            [ 4]  201 	ld	c,l
   0267 44            [ 4]  202 	ld	b,h
   0268 21 01 64      [10]  203 	ld	hl,#0x6401
   026B 6E            [ 7]  204 	ld	l, (hl)
   026C 26 00         [ 7]  205 	ld	h,#0x00
   026E 09            [11]  206 	add	hl,bc
   026F 36 00         [10]  207 	ld	(hl),#0x00
                            208 ;src/Map.c:70: for(i=0;i<MAP_WIDTH;++i){
   0271 0E 00         [ 7]  209 	ld	c,#0x00
   0273                     210 00170$:
                            211 ;src/Map.c:71: map[0][i]=CELLTYPE_WALL1;//get_random_wall();
   0273 21 00 60      [10]  212 	ld	hl,#0x6000
   0276 06 00         [ 7]  213 	ld	b,#0x00
   0278 09            [11]  214 	add	hl, bc
   0279 36 81         [10]  215 	ld	(hl),#0x81
                            216 ;src/Map.c:72: map[MAP_HEIGHT-1][i]=CELLTYPE_WALL1;//get_random_wall();
   027B 21 E0 63      [10]  217 	ld	hl,#0x63E0
   027E 06 00         [ 7]  218 	ld	b,#0x00
   0280 09            [11]  219 	add	hl, bc
   0281 36 81         [10]  220 	ld	(hl),#0x81
                            221 ;src/Map.c:70: for(i=0;i<MAP_WIDTH;++i){
   0283 0C            [ 4]  222 	inc	c
   0284 79            [ 4]  223 	ld	a,c
   0285 D6 20         [ 7]  224 	sub	a, #0x20
   0287 38 EA         [12]  225 	jr	C,00170$
                            226 ;src/Map.c:75: for(i=1;i<MAP_HEIGHT-1;++i){
   0289 0E 01         [ 7]  227 	ld	c,#0x01
   028B                     228 00172$:
                            229 ;src/Map.c:76: map[i][0]=CELLTYPE_WALL1;//get_random_wall();
   028B 69            [ 4]  230 	ld	l,c
   028C 26 00         [ 7]  231 	ld	h,#0x00
   028E 29            [11]  232 	add	hl, hl
   028F 29            [11]  233 	add	hl, hl
   0290 29            [11]  234 	add	hl, hl
   0291 29            [11]  235 	add	hl, hl
   0292 29            [11]  236 	add	hl, hl
   0293 EB            [ 4]  237 	ex	de,hl
   0294 21 00 60      [10]  238 	ld	hl,#0x6000
   0297 19            [11]  239 	add	hl,de
   0298 36 81         [10]  240 	ld	(hl),#0x81
                            241 ;src/Map.c:77: map[i][MAP_WIDTH-1]=CELLTYPE_WALL1;//get_random_wall();
   029A 21 00 60      [10]  242 	ld	hl,#0x6000
   029D 19            [11]  243 	add	hl,de
   029E 11 1F 00      [10]  244 	ld	de,#0x001F
   02A1 19            [11]  245 	add	hl,de
   02A2 36 81         [10]  246 	ld	(hl),#0x81
                            247 ;src/Map.c:75: for(i=1;i<MAP_HEIGHT-1;++i){
   02A4 0C            [ 4]  248 	inc	c
   02A5 79            [ 4]  249 	ld	a,c
   02A6 D6 1F         [ 7]  250 	sub	a, #0x1F
   02A8 38 E1         [12]  251 	jr	C,00172$
                            252 ;src/Map.c:80: while(remainingCells>0){
   02AA 21 04 00      [10]  253 	ld	hl,#0x0004
   02AD 39            [11]  254 	add	hl,sp
   02AE DD 75 FA      [19]  255 	ld	-6 (ix),l
   02B1 DD 74 FB      [19]  256 	ld	-5 (ix),h
   02B4                     257 00167$:
   02B4 DD 7E F3      [19]  258 	ld	a,-13 (ix)
   02B7 DD B6 F2      [19]  259 	or	a,-14 (ix)
   02BA CA 82 06      [10]  260 	jp	Z,00174$
                            261 ;src/Map.c:81: wallListPosition = wallList+wallListCount;
   02BD C1            [10]  262 	pop	bc
   02BE E1            [10]  263 	pop	hl
   02BF E5            [11]  264 	push	hl
   02C0 C5            [11]  265 	push	bc
   02C1 29            [11]  266 	add	hl, hl
   02C2 7D            [ 4]  267 	ld	a,l
   02C3 C6 00         [ 7]  268 	add	a, #0x00
   02C5 DD 77 FC      [19]  269 	ld	-4 (ix),a
   02C8 7C            [ 4]  270 	ld	a,h
   02C9 CE 68         [ 7]  271 	adc	a, #0x68
   02CB DD 77 FD      [19]  272 	ld	-3 (ix),a
                            273 ;src/Map.c:82: while(wallListCount<MAP_SIZE){
   02CE D1            [10]  274 	pop	de
   02CF C1            [10]  275 	pop	bc
   02D0 C5            [11]  276 	push	bc
   02D1 D5            [11]  277 	push	de
   02D2                     278 00137$:
                            279 ;src/Map.c:85: currentPos.y = (*wallListPosition).y;
   02D2 DD 7E FA      [19]  280 	ld	a,-6 (ix)
   02D5 C6 01         [ 7]  281 	add	a, #0x01
   02D7 DD 77 FE      [19]  282 	ld	-2 (ix),a
   02DA DD 7E FB      [19]  283 	ld	a,-5 (ix)
   02DD CE 00         [ 7]  284 	adc	a, #0x00
   02DF DD 77 FF      [19]  285 	ld	-1 (ix),a
                            286 ;src/Map.c:82: while(wallListCount<MAP_SIZE){
   02E2 78            [ 4]  287 	ld	a,b
   02E3 D6 04         [ 7]  288 	sub	a, #0x04
   02E5 D2 83 04      [10]  289 	jp	NC,00209$
                            290 ;src/Map.c:84: currentPos.x = (*wallListPosition).x;
   02E8 21 04 00      [10]  291 	ld	hl,#0x0004
   02EB 39            [11]  292 	add	hl,sp
   02EC EB            [ 4]  293 	ex	de,hl
   02ED DD 6E FC      [19]  294 	ld	l,-4 (ix)
   02F0 DD 66 FD      [19]  295 	ld	h,-3 (ix)
   02F3 7E            [ 7]  296 	ld	a,(hl)
   02F4 12            [ 7]  297 	ld	(de),a
                            298 ;src/Map.c:85: currentPos.y = (*wallListPosition).y;
   02F5 DD 5E FC      [19]  299 	ld	e,-4 (ix)
   02F8 DD 56 FD      [19]  300 	ld	d,-3 (ix)
   02FB 13            [ 6]  301 	inc	de
   02FC 1A            [ 7]  302 	ld	a,(de)
   02FD DD 6E FE      [19]  303 	ld	l,-2 (ix)
   0300 DD 66 FF      [19]  304 	ld	h,-1 (ix)
   0303 77            [ 7]  305 	ld	(hl),a
                            306 ;src/Map.c:87: convertToFloor=0;
   0304 DD 36 F5 00   [19]  307 	ld	-11 (ix),#0x00
                            308 ;src/Map.c:88: surroundedByWalls=1;
   0308 DD 36 F4 01   [19]  309 	ld	-12 (ix),#0x01
                            310 ;src/Map.c:90: if(currentPos.x>0){
   030C DD 6E FA      [19]  311 	ld	l,-6 (ix)
   030F DD 66 FB      [19]  312 	ld	h,-5 (ix)
   0312 7E            [ 7]  313 	ld	a,(hl)
   0313 DD 77 F8      [19]  314 	ld	-8 (ix),a
                            315 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   0316 DD 6E FE      [19]  316 	ld	l,-2 (ix)
   0319 DD 66 FF      [19]  317 	ld	h,-1 (ix)
   031C 7E            [ 7]  318 	ld	a,(hl)
   031D DD 77 F9      [19]  319 	ld	-7 (ix),a
   0320 DD 7E F8      [19]  320 	ld	a,-8 (ix)
   0323 DD 77 F6      [19]  321 	ld	-10 (ix),a
   0326 DD 36 F7 00   [19]  322 	ld	-9 (ix),#0x00
                            323 ;src/Map.c:90: if(currentPos.x>0){
   032A DD 7E F8      [19]  324 	ld	a,-8 (ix)
   032D B7            [ 4]  325 	or	a, a
   032E 28 2F         [12]  326 	jr	Z,00112$
                            327 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   0330 DD 6E F6      [19]  328 	ld	l,-10 (ix)
   0333 DD 66 F7      [19]  329 	ld	h,-9 (ix)
   0336 2B            [ 6]  330 	dec	hl
   0337 29            [11]  331 	add	hl, hl
   0338 29            [11]  332 	add	hl, hl
   0339 29            [11]  333 	add	hl, hl
   033A 29            [11]  334 	add	hl, hl
   033B 29            [11]  335 	add	hl, hl
   033C D5            [11]  336 	push	de
   033D 11 00 60      [10]  337 	ld	de,#0x6000
   0340 19            [11]  338 	add	hl, de
   0341 D1            [10]  339 	pop	de
   0342 7D            [ 4]  340 	ld	a,l
   0343 DD 86 F9      [19]  341 	add	a, -7 (ix)
   0346 6F            [ 4]  342 	ld	l,a
   0347 7C            [ 4]  343 	ld	a,h
   0348 CE 00         [ 7]  344 	adc	a, #0x00
   034A 67            [ 4]  345 	ld	h,a
   034B 6E            [ 7]  346 	ld	l,(hl)
                            347 ;src/Map.c:92: if(adjacentType == CELLTYPE_UNDEFINED){
   034C 7D            [ 4]  348 	ld	a,l
   034D D6 87         [ 7]  349 	sub	a, #0x87
   034F 20 06         [12]  350 	jr	NZ,00109$
                            351 ;src/Map.c:93: convertToFloor  = 1;
   0351 DD 36 F5 01   [19]  352 	ld	-11 (ix),#0x01
   0355 18 08         [12]  353 	jr	00112$
   0357                     354 00109$:
                            355 ;src/Map.c:95: else if(adjacentType == CELLTYPE_FLOOR){
   0357 7D            [ 4]  356 	ld	a,l
   0358 B7            [ 4]  357 	or	a, a
   0359 20 04         [12]  358 	jr	NZ,00112$
                            359 ;src/Map.c:96: surroundedByWalls = 0;
   035B DD 36 F4 00   [19]  360 	ld	-12 (ix),#0x00
   035F                     361 00112$:
                            362 ;src/Map.c:99: if(currentPos.x < (MAP_WIDTH-1)){
   035F DD 7E F8      [19]  363 	ld	a,-8 (ix)
   0362 D6 1F         [ 7]  364 	sub	a, #0x1F
   0364 30 2F         [12]  365 	jr	NC,00119$
                            366 ;src/Map.c:101: adjacentType = map[currentPos.x+1][currentPos.y];
   0366 DD 6E F6      [19]  367 	ld	l,-10 (ix)
   0369 DD 66 F7      [19]  368 	ld	h,-9 (ix)
   036C 23            [ 6]  369 	inc	hl
   036D 29            [11]  370 	add	hl, hl
   036E 29            [11]  371 	add	hl, hl
   036F 29            [11]  372 	add	hl, hl
   0370 29            [11]  373 	add	hl, hl
   0371 29            [11]  374 	add	hl, hl
   0372 D5            [11]  375 	push	de
   0373 11 00 60      [10]  376 	ld	de,#0x6000
   0376 19            [11]  377 	add	hl, de
   0377 D1            [10]  378 	pop	de
   0378 7D            [ 4]  379 	ld	a,l
   0379 DD 86 F9      [19]  380 	add	a, -7 (ix)
   037C 6F            [ 4]  381 	ld	l,a
   037D 7C            [ 4]  382 	ld	a,h
   037E CE 00         [ 7]  383 	adc	a, #0x00
   0380 67            [ 4]  384 	ld	h,a
   0381 6E            [ 7]  385 	ld	l,(hl)
                            386 ;src/Map.c:102: if(adjacentType == CELLTYPE_UNDEFINED){
   0382 7D            [ 4]  387 	ld	a,l
   0383 D6 87         [ 7]  388 	sub	a, #0x87
   0385 20 06         [12]  389 	jr	NZ,00116$
                            390 ;src/Map.c:103: convertToFloor  = 1;
   0387 DD 36 F5 01   [19]  391 	ld	-11 (ix),#0x01
   038B 18 08         [12]  392 	jr	00119$
   038D                     393 00116$:
                            394 ;src/Map.c:105: else if(adjacentType == CELLTYPE_FLOOR){
   038D 7D            [ 4]  395 	ld	a,l
   038E B7            [ 4]  396 	or	a, a
   038F 20 04         [12]  397 	jr	NZ,00119$
                            398 ;src/Map.c:106: surroundedByWalls = 0;
   0391 DD 36 F4 00   [19]  399 	ld	-12 (ix),#0x00
   0395                     400 00119$:
                            401 ;src/Map.c:111: adjacentType = map[currentPos.x][currentPos.y-1];
   0395 DD 6E F6      [19]  402 	ld	l,-10 (ix)
   0398 DD 66 F7      [19]  403 	ld	h,-9 (ix)
   039B 29            [11]  404 	add	hl, hl
   039C 29            [11]  405 	add	hl, hl
   039D 29            [11]  406 	add	hl, hl
   039E 29            [11]  407 	add	hl, hl
   039F 29            [11]  408 	add	hl, hl
   03A0 7D            [ 4]  409 	ld	a,l
   03A1 C6 00         [ 7]  410 	add	a, #0x00
   03A3 DD 77 F6      [19]  411 	ld	-10 (ix),a
   03A6 7C            [ 4]  412 	ld	a,h
   03A7 CE 60         [ 7]  413 	adc	a, #0x60
   03A9 DD 77 F7      [19]  414 	ld	-9 (ix),a
                            415 ;src/Map.c:109: if(currentPos.y > 0){
   03AC DD 7E F9      [19]  416 	ld	a,-7 (ix)
   03AF B7            [ 4]  417 	or	a, a
   03B0 28 23         [12]  418 	jr	Z,00126$
                            419 ;src/Map.c:111: adjacentType = map[currentPos.x][currentPos.y-1];
   03B2 DD 6E F9      [19]  420 	ld	l,-7 (ix)
   03B5 2D            [ 4]  421 	dec	l
   03B6 DD 7E F6      [19]  422 	ld	a,-10 (ix)
   03B9 85            [ 4]  423 	add	a, l
   03BA 6F            [ 4]  424 	ld	l,a
   03BB DD 7E F7      [19]  425 	ld	a,-9 (ix)
   03BE CE 00         [ 7]  426 	adc	a, #0x00
   03C0 67            [ 4]  427 	ld	h,a
   03C1 6E            [ 7]  428 	ld	l,(hl)
                            429 ;src/Map.c:112: if(adjacentType == CELLTYPE_UNDEFINED){
   03C2 7D            [ 4]  430 	ld	a,l
   03C3 D6 87         [ 7]  431 	sub	a, #0x87
   03C5 20 06         [12]  432 	jr	NZ,00123$
                            433 ;src/Map.c:113: convertToFloor  = 1;
   03C7 DD 36 F5 01   [19]  434 	ld	-11 (ix),#0x01
   03CB 18 08         [12]  435 	jr	00126$
   03CD                     436 00123$:
                            437 ;src/Map.c:115: else if(adjacentType == CELLTYPE_FLOOR){
   03CD 7D            [ 4]  438 	ld	a,l
   03CE B7            [ 4]  439 	or	a, a
   03CF 20 04         [12]  440 	jr	NZ,00126$
                            441 ;src/Map.c:116: surroundedByWalls = 0;
   03D1 DD 36 F4 00   [19]  442 	ld	-12 (ix),#0x00
   03D5                     443 00126$:
                            444 ;src/Map.c:119: if(currentPos.y < (MAP_HEIGHT-1)){
   03D5 DD 7E F9      [19]  445 	ld	a,-7 (ix)
   03D8 D6 1F         [ 7]  446 	sub	a, #0x1F
   03DA 30 23         [12]  447 	jr	NC,00133$
                            448 ;src/Map.c:121: adjacentType = map[currentPos.x][currentPos.y+1];
   03DC DD 6E F9      [19]  449 	ld	l,-7 (ix)
   03DF 2C            [ 4]  450 	inc	l
   03E0 DD 7E F6      [19]  451 	ld	a,-10 (ix)
   03E3 85            [ 4]  452 	add	a, l
   03E4 6F            [ 4]  453 	ld	l,a
   03E5 DD 7E F7      [19]  454 	ld	a,-9 (ix)
   03E8 CE 00         [ 7]  455 	adc	a, #0x00
   03EA 67            [ 4]  456 	ld	h,a
   03EB 6E            [ 7]  457 	ld	l,(hl)
                            458 ;src/Map.c:122: if(adjacentType == CELLTYPE_UNDEFINED){
   03EC 7D            [ 4]  459 	ld	a,l
   03ED D6 87         [ 7]  460 	sub	a, #0x87
   03EF 20 06         [12]  461 	jr	NZ,00130$
                            462 ;src/Map.c:123: convertToFloor  = 1;
   03F1 DD 36 F5 01   [19]  463 	ld	-11 (ix),#0x01
   03F5 18 08         [12]  464 	jr	00133$
   03F7                     465 00130$:
                            466 ;src/Map.c:125: else if(adjacentType == CELLTYPE_FLOOR){
   03F7 7D            [ 4]  467 	ld	a,l
   03F8 B7            [ 4]  468 	or	a, a
   03F9 20 04         [12]  469 	jr	NZ,00133$
                            470 ;src/Map.c:126: surroundedByWalls = 0;
   03FB DD 36 F4 00   [19]  471 	ld	-12 (ix),#0x00
   03FF                     472 00133$:
                            473 ;src/Map.c:130: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   03FF 69            [ 4]  474 	ld	l, c
   0400 60            [ 4]  475 	ld	h, b
   0401 29            [11]  476 	add	hl, hl
   0402 FD 21 00 68   [14]  477 	ld	iy,#0x6800
   0406 C5            [11]  478 	push	bc
   0407 4D            [ 4]  479 	ld	c, l
   0408 44            [ 4]  480 	ld	b, h
   0409 FD 09         [15]  481 	add	iy, bc
   040B C1            [10]  482 	pop	bc
   040C FD 7E 00      [19]  483 	ld	a, 0 (iy)
   040F DD 6E FC      [19]  484 	ld	l,-4 (ix)
   0412 DD 66 FD      [19]  485 	ld	h,-3 (ix)
   0415 77            [ 7]  486 	ld	(hl),a
                            487 ;src/Map.c:131: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   0416 FD E5         [15]  488 	push	iy
   0418 E1            [10]  489 	pop	hl
   0419 23            [ 6]  490 	inc	hl
   041A 7E            [ 7]  491 	ld	a,(hl)
   041B 12            [ 7]  492 	ld	(de),a
                            493 ;src/Map.c:132: --wallListCount;
   041C 0B            [ 6]  494 	dec	bc
   041D DD 71 EE      [19]  495 	ld	-18 (ix),c
   0420 DD 70 EF      [19]  496 	ld	-17 (ix),b
                            497 ;src/Map.c:135: if((convertToFloor)&&(!surroundedByWalls)){
   0423 DD 7E F5      [19]  498 	ld	a,-11 (ix)
   0426 B7            [ 4]  499 	or	a, a
   0427 28 49         [12]  500 	jr	Z,00135$
   0429 DD 7E F4      [19]  501 	ld	a,-12 (ix)
   042C B7            [ 4]  502 	or	a, a
   042D 20 43         [12]  503 	jr	NZ,00135$
                            504 ;src/Map.c:136: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   042F DD 6E FA      [19]  505 	ld	l,-6 (ix)
   0432 DD 66 FB      [19]  506 	ld	h,-5 (ix)
   0435 6E            [ 7]  507 	ld	l,(hl)
   0436 26 00         [ 7]  508 	ld	h,#0x00
   0438 29            [11]  509 	add	hl, hl
   0439 29            [11]  510 	add	hl, hl
   043A 29            [11]  511 	add	hl, hl
   043B 29            [11]  512 	add	hl, hl
   043C 29            [11]  513 	add	hl, hl
   043D 01 00 60      [10]  514 	ld	bc,#0x6000
   0440 09            [11]  515 	add	hl,bc
   0441 4D            [ 4]  516 	ld	c,l
   0442 44            [ 4]  517 	ld	b,h
   0443 DD 6E FE      [19]  518 	ld	l,-2 (ix)
   0446 DD 66 FF      [19]  519 	ld	h,-1 (ix)
   0449 6E            [ 7]  520 	ld	l, (hl)
   044A 26 00         [ 7]  521 	ld	h,#0x00
   044C 09            [11]  522 	add	hl,bc
   044D 36 00         [10]  523 	ld	(hl),#0x00
                            524 ;src/Map.c:138: ++lastStackItem;
   044F DD 34 EC      [23]  525 	inc	-20 (ix)
   0452 20 03         [12]  526 	jr	NZ,00334$
   0454 DD 34 ED      [23]  527 	inc	-19 (ix)
   0457                     528 00334$:
                            529 ;src/Map.c:139: (*(cellStack+lastStackItem)).x = currentPos.x;
   0457 E1            [10]  530 	pop	hl
   0458 E5            [11]  531 	push	hl
   0459 29            [11]  532 	add	hl, hl
   045A 4D            [ 4]  533 	ld	c, l
   045B 7C            [ 4]  534 	ld	a,h
   045C C6 64         [ 7]  535 	add	a,#0x64
   045E 47            [ 4]  536 	ld	b,a
   045F DD 6E FA      [19]  537 	ld	l,-6 (ix)
   0462 DD 66 FB      [19]  538 	ld	h,-5 (ix)
   0465 7E            [ 7]  539 	ld	a,(hl)
   0466 02            [ 7]  540 	ld	(bc),a
                            541 ;src/Map.c:140: (*(cellStack+lastStackItem)).y = currentPos.y;
   0467 03            [ 6]  542 	inc	bc
   0468 DD 6E FE      [19]  543 	ld	l,-2 (ix)
   046B DD 66 FF      [19]  544 	ld	h,-1 (ix)
   046E 7E            [ 7]  545 	ld	a,(hl)
   046F 02            [ 7]  546 	ld	(bc),a
                            547 ;src/Map.c:143: break;
   0470 18 11         [12]  548 	jr	00209$
   0472                     549 00135$:
                            550 ;src/Map.c:145: --wallListPosition;
   0472 DD 6E FC      [19]  551 	ld	l,-4 (ix)
   0475 DD 66 FD      [19]  552 	ld	h,-3 (ix)
   0478 2B            [ 6]  553 	dec	hl
   0479 2B            [ 6]  554 	dec	hl
   047A DD 75 FC      [19]  555 	ld	-4 (ix),l
   047D DD 74 FD      [19]  556 	ld	-3 (ix),h
   0480 C3 D2 02      [10]  557 	jp	00137$
                            558 ;src/Map.c:147: while(lastStackItem<MAP_SIZE){
   0483                     559 00209$:
   0483 DD 7E F2      [19]  560 	ld	a,-14 (ix)
   0486 DD 77 F6      [19]  561 	ld	-10 (ix),a
   0489 DD 7E F3      [19]  562 	ld	a,-13 (ix)
   048C DD 77 F7      [19]  563 	ld	-9 (ix),a
   048F DD 7E EE      [19]  564 	ld	a,-18 (ix)
   0492 DD 77 FC      [19]  565 	ld	-4 (ix),a
   0495 DD 7E EF      [19]  566 	ld	a,-17 (ix)
   0498 DD 77 FD      [19]  567 	ld	-3 (ix),a
   049B                     568 00164$:
   049B DD 7E ED      [19]  569 	ld	a,-19 (ix)
   049E D6 04         [ 7]  570 	sub	a, #0x04
   04A0 D2 B4 02      [10]  571 	jp	NC,00167$
                            572 ;src/Map.c:148: currentPos.x=(*(lastStackItem+cellStack)).x;
   04A3 21 04 00      [10]  573 	ld	hl,#0x0004
   04A6 39            [11]  574 	add	hl,sp
   04A7 4D            [ 4]  575 	ld	c,l
   04A8 44            [ 4]  576 	ld	b,h
   04A9 E1            [10]  577 	pop	hl
   04AA E5            [11]  578 	push	hl
   04AB 29            [11]  579 	add	hl, hl
   04AC FD 21 00 64   [14]  580 	ld	iy,#0x6400
   04B0 EB            [ 4]  581 	ex	de,hl
   04B1 FD 19         [15]  582 	add	iy, de
   04B3 FD 7E 00      [19]  583 	ld	a, 0 (iy)
   04B6 02            [ 7]  584 	ld	(bc),a
                            585 ;src/Map.c:149: currentPos.y=(*(lastStackItem+cellStack)).y;
   04B7 FD 4E 01      [19]  586 	ld	c,1 (iy)
   04BA DD 6E FE      [19]  587 	ld	l,-2 (ix)
   04BD DD 66 FF      [19]  588 	ld	h,-1 (ix)
   04C0 71            [ 7]  589 	ld	(hl),c
                            590 ;src/Map.c:150: --lastStackItem;
   04C1 E1            [10]  591 	pop	hl
   04C2 E5            [11]  592 	push	hl
   04C3 2B            [ 6]  593 	dec	hl
   04C4 E3            [19]  594 	ex	(sp), hl
                            595 ;src/Map.c:151: cellType = map[currentPos.x][currentPos.y];
   04C5 DD 6E FA      [19]  596 	ld	l,-6 (ix)
   04C8 DD 66 FB      [19]  597 	ld	h,-5 (ix)
   04CB 6E            [ 7]  598 	ld	l,(hl)
   04CC 26 00         [ 7]  599 	ld	h,#0x00
   04CE 29            [11]  600 	add	hl, hl
   04CF 29            [11]  601 	add	hl, hl
   04D0 29            [11]  602 	add	hl, hl
   04D1 29            [11]  603 	add	hl, hl
   04D2 29            [11]  604 	add	hl, hl
   04D3 11 00 60      [10]  605 	ld	de,#0x6000
   04D6 19            [11]  606 	add	hl,de
   04D7 59            [ 4]  607 	ld	e,c
   04D8 16 00         [ 7]  608 	ld	d,#0x00
   04DA 19            [11]  609 	add	hl,de
   04DB 4E            [ 7]  610 	ld	c,(hl)
                            611 ;src/Map.c:153: if(cellType == CELLTYPE_UNDEFINED){
   04DC 79            [ 4]  612 	ld	a,c
   04DD D6 87         [ 7]  613 	sub	a, #0x87
   04DF 20 47         [12]  614 	jr	NZ,00144$
                            615 ;src/Map.c:155: if(cpct_getRandom_lcg_u8()&1){//WALL
   04E1 CD CA 46      [17]  616 	call	_cpct_getRandom_lcg_u8
   04E4 CB 45         [ 8]  617 	bit	0, l
   04E6 28 06         [12]  618 	jr	Z,00141$
                            619 ;src/Map.c:156: cellType = get_random_wall();
   04E8 CD B5 01      [17]  620 	call	_get_random_wall
   04EB 4D            [ 4]  621 	ld	c,l
   04EC 18 02         [12]  622 	jr	00142$
   04EE                     623 00141$:
                            624 ;src/Map.c:159: cellType = CELLTYPE_FLOOR;
   04EE 0E 00         [ 7]  625 	ld	c,#0x00
   04F0                     626 00142$:
                            627 ;src/Map.c:161: map[currentPos.x][currentPos.y]=cellType;
   04F0 DD 6E FA      [19]  628 	ld	l,-6 (ix)
   04F3 DD 66 FB      [19]  629 	ld	h,-5 (ix)
   04F6 6E            [ 7]  630 	ld	l,(hl)
   04F7 26 00         [ 7]  631 	ld	h,#0x00
   04F9 29            [11]  632 	add	hl, hl
   04FA 29            [11]  633 	add	hl, hl
   04FB 29            [11]  634 	add	hl, hl
   04FC 29            [11]  635 	add	hl, hl
   04FD 29            [11]  636 	add	hl, hl
   04FE EB            [ 4]  637 	ex	de,hl
   04FF 21 00 60      [10]  638 	ld	hl,#0x6000
   0502 19            [11]  639 	add	hl,de
   0503 EB            [ 4]  640 	ex	de,hl
   0504 DD 6E FE      [19]  641 	ld	l,-2 (ix)
   0507 DD 66 FF      [19]  642 	ld	h,-1 (ix)
   050A 6E            [ 7]  643 	ld	l, (hl)
   050B 26 00         [ 7]  644 	ld	h,#0x00
   050D 19            [11]  645 	add	hl,de
   050E 71            [ 7]  646 	ld	(hl),c
                            647 ;src/Map.c:162: --remainingCells;
   050F DD 6E F6      [19]  648 	ld	l,-10 (ix)
   0512 DD 66 F7      [19]  649 	ld	h,-9 (ix)
   0515 2B            [ 6]  650 	dec	hl
   0516 DD 75 F6      [19]  651 	ld	-10 (ix),l
   0519 DD 74 F7      [19]  652 	ld	-9 (ix),h
   051C DD 7E F6      [19]  653 	ld	a,-10 (ix)
   051F DD 77 F2      [19]  654 	ld	-14 (ix),a
   0522 DD 7E F7      [19]  655 	ld	a,-9 (ix)
   0525 DD 77 F3      [19]  656 	ld	-13 (ix),a
   0528                     657 00144$:
                            658 ;src/Map.c:90: if(currentPos.x>0){
   0528 DD 6E FA      [19]  659 	ld	l,-6 (ix)
   052B DD 66 FB      [19]  660 	ld	h,-5 (ix)
   052E 7E            [ 7]  661 	ld	a,(hl)
   052F DD 77 F9      [19]  662 	ld	-7 (ix),a
                            663 ;src/Map.c:165: if((cellType == CELLTYPE_FLOOR)){
   0532 79            [ 4]  664 	ld	a,c
   0533 B7            [ 4]  665 	or	a, a
   0534 C2 51 06      [10]  666 	jp	NZ,00162$
                            667 ;src/Map.c:166: if(currentPos.x>0){
   0537 DD 7E F9      [19]  668 	ld	a,-7 (ix)
   053A B7            [ 4]  669 	or	a, a
   053B 28 3F         [12]  670 	jr	Z,00148$
                            671 ;src/Map.c:167: adjacentType = map[currentPos.x-1][currentPos.y];
   053D DD 6E F9      [19]  672 	ld	l,-7 (ix)
   0540 26 00         [ 7]  673 	ld	h,#0x00
   0542 2B            [ 6]  674 	dec	hl
   0543 29            [11]  675 	add	hl, hl
   0544 29            [11]  676 	add	hl, hl
   0545 29            [11]  677 	add	hl, hl
   0546 29            [11]  678 	add	hl, hl
   0547 29            [11]  679 	add	hl, hl
   0548 01 00 60      [10]  680 	ld	bc,#0x6000
   054B 09            [11]  681 	add	hl,bc
   054C 4D            [ 4]  682 	ld	c,l
   054D 44            [ 4]  683 	ld	b,h
   054E DD 6E FE      [19]  684 	ld	l,-2 (ix)
   0551 DD 66 FF      [19]  685 	ld	h,-1 (ix)
   0554 6E            [ 7]  686 	ld	l, (hl)
   0555 26 00         [ 7]  687 	ld	h,#0x00
   0557 09            [11]  688 	add	hl,bc
   0558 7E            [ 7]  689 	ld	a,(hl)
                            690 ;src/Map.c:168: if(adjacentType == CELLTYPE_UNDEFINED){
   0559 D6 87         [ 7]  691 	sub	a, #0x87
   055B 20 1F         [12]  692 	jr	NZ,00148$
                            693 ;src/Map.c:170: ++lastStackItem;
   055D DD 34 EC      [23]  694 	inc	-20 (ix)
   0560 20 03         [12]  695 	jr	NZ,00340$
   0562 DD 34 ED      [23]  696 	inc	-19 (ix)
   0565                     697 00340$:
                            698 ;src/Map.c:171: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   0565 E1            [10]  699 	pop	hl
   0566 E5            [11]  700 	push	hl
   0567 29            [11]  701 	add	hl, hl
   0568 01 00 64      [10]  702 	ld	bc,#0x6400
   056B 09            [11]  703 	add	hl,bc
   056C DD 4E F9      [19]  704 	ld	c,-7 (ix)
   056F 0D            [ 4]  705 	dec	c
   0570 71            [ 7]  706 	ld	(hl),c
                            707 ;src/Map.c:172: (*(cellStack+lastStackItem)).y = currentPos.y;
   0571 23            [ 6]  708 	inc	hl
   0572 4D            [ 4]  709 	ld	c,l
   0573 44            [ 4]  710 	ld	b,h
   0574 DD 6E FE      [19]  711 	ld	l,-2 (ix)
   0577 DD 66 FF      [19]  712 	ld	h,-1 (ix)
   057A 7E            [ 7]  713 	ld	a,(hl)
   057B 02            [ 7]  714 	ld	(bc),a
   057C                     715 00148$:
                            716 ;src/Map.c:176: if(currentPos.x < (MAP_WIDTH-1)){
   057C DD 6E FA      [19]  717 	ld	l,-6 (ix)
   057F DD 66 FB      [19]  718 	ld	h,-5 (ix)
   0582 4E            [ 7]  719 	ld	c,(hl)
   0583 79            [ 4]  720 	ld	a,c
   0584 D6 1F         [ 7]  721 	sub	a, #0x1F
   0586 30 3A         [12]  722 	jr	NC,00152$
                            723 ;src/Map.c:178: adjacentType = map[currentPos.x+1][currentPos.y];
   0588 69            [ 4]  724 	ld	l,c
   0589 26 00         [ 7]  725 	ld	h,#0x00
   058B 23            [ 6]  726 	inc	hl
   058C 29            [11]  727 	add	hl, hl
   058D 29            [11]  728 	add	hl, hl
   058E 29            [11]  729 	add	hl, hl
   058F 29            [11]  730 	add	hl, hl
   0590 29            [11]  731 	add	hl, hl
   0591 EB            [ 4]  732 	ex	de,hl
   0592 21 00 60      [10]  733 	ld	hl,#0x6000
   0595 19            [11]  734 	add	hl,de
   0596 EB            [ 4]  735 	ex	de,hl
   0597 DD 6E FE      [19]  736 	ld	l,-2 (ix)
   059A DD 66 FF      [19]  737 	ld	h,-1 (ix)
   059D 6E            [ 7]  738 	ld	l, (hl)
   059E 26 00         [ 7]  739 	ld	h,#0x00
   05A0 19            [11]  740 	add	hl,de
   05A1 7E            [ 7]  741 	ld	a,(hl)
                            742 ;src/Map.c:179: if(adjacentType == CELLTYPE_UNDEFINED){
   05A2 D6 87         [ 7]  743 	sub	a, #0x87
   05A4 20 1C         [12]  744 	jr	NZ,00152$
                            745 ;src/Map.c:182: ++lastStackItem;
   05A6 DD 34 EC      [23]  746 	inc	-20 (ix)
   05A9 20 03         [12]  747 	jr	NZ,00343$
   05AB DD 34 ED      [23]  748 	inc	-19 (ix)
   05AE                     749 00343$:
                            750 ;src/Map.c:183: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   05AE E1            [10]  751 	pop	hl
   05AF E5            [11]  752 	push	hl
   05B0 29            [11]  753 	add	hl, hl
   05B1 11 00 64      [10]  754 	ld	de,#0x6400
   05B4 19            [11]  755 	add	hl,de
   05B5 0C            [ 4]  756 	inc	c
   05B6 71            [ 7]  757 	ld	(hl),c
                            758 ;src/Map.c:184: (*(cellStack+lastStackItem)).y = currentPos.y;
   05B7 23            [ 6]  759 	inc	hl
   05B8 4D            [ 4]  760 	ld	c,l
   05B9 44            [ 4]  761 	ld	b,h
   05BA DD 6E FE      [19]  762 	ld	l,-2 (ix)
   05BD DD 66 FF      [19]  763 	ld	h,-1 (ix)
   05C0 7E            [ 7]  764 	ld	a,(hl)
   05C1 02            [ 7]  765 	ld	(bc),a
   05C2                     766 00152$:
                            767 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   05C2 DD 6E FE      [19]  768 	ld	l,-2 (ix)
   05C5 DD 66 FF      [19]  769 	ld	h,-1 (ix)
   05C8 4E            [ 7]  770 	ld	c,(hl)
                            771 ;src/Map.c:188: if(currentPos.y > 0){
   05C9 79            [ 4]  772 	ld	a,c
   05CA B7            [ 4]  773 	or	a, a
   05CB 28 3A         [12]  774 	jr	Z,00156$
                            775 ;src/Map.c:190: adjacentType = map[currentPos.x][currentPos.y-1];
   05CD DD 6E FA      [19]  776 	ld	l,-6 (ix)
   05D0 DD 66 FB      [19]  777 	ld	h,-5 (ix)
   05D3 46            [ 7]  778 	ld	b,(hl)
   05D4 68            [ 4]  779 	ld	l,b
   05D5 26 00         [ 7]  780 	ld	h,#0x00
   05D7 29            [11]  781 	add	hl, hl
   05D8 29            [11]  782 	add	hl, hl
   05D9 29            [11]  783 	add	hl, hl
   05DA 29            [11]  784 	add	hl, hl
   05DB 29            [11]  785 	add	hl, hl
   05DC 11 00 60      [10]  786 	ld	de,#0x6000
   05DF 19            [11]  787 	add	hl,de
   05E0 0D            [ 4]  788 	dec	c
   05E1 59            [ 4]  789 	ld	e,c
   05E2 16 00         [ 7]  790 	ld	d,#0x00
   05E4 19            [11]  791 	add	hl,de
   05E5 7E            [ 7]  792 	ld	a,(hl)
                            793 ;src/Map.c:191: if(adjacentType == CELLTYPE_UNDEFINED){
   05E6 D6 87         [ 7]  794 	sub	a, #0x87
   05E8 20 1D         [12]  795 	jr	NZ,00156$
                            796 ;src/Map.c:194: ++lastStackItem;
   05EA DD 34 EC      [23]  797 	inc	-20 (ix)
   05ED 20 03         [12]  798 	jr	NZ,00346$
   05EF DD 34 ED      [23]  799 	inc	-19 (ix)
   05F2                     800 00346$:
                            801 ;src/Map.c:195: (*(cellStack+lastStackItem)).x = currentPos.x;
   05F2 E1            [10]  802 	pop	hl
   05F3 E5            [11]  803 	push	hl
   05F4 29            [11]  804 	add	hl, hl
   05F5 11 00 64      [10]  805 	ld	de,#0x6400
   05F8 19            [11]  806 	add	hl,de
   05F9 70            [ 7]  807 	ld	(hl),b
                            808 ;src/Map.c:196: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   05FA 23            [ 6]  809 	inc	hl
   05FB 4D            [ 4]  810 	ld	c,l
   05FC 44            [ 4]  811 	ld	b,h
   05FD DD 6E FE      [19]  812 	ld	l,-2 (ix)
   0600 DD 66 FF      [19]  813 	ld	h,-1 (ix)
   0603 5E            [ 7]  814 	ld	e,(hl)
   0604 1D            [ 4]  815 	dec	e
   0605 7B            [ 4]  816 	ld	a,e
   0606 02            [ 7]  817 	ld	(bc),a
   0607                     818 00156$:
                            819 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   0607 DD 6E FE      [19]  820 	ld	l,-2 (ix)
   060A DD 66 FF      [19]  821 	ld	h,-1 (ix)
   060D 46            [ 7]  822 	ld	b,(hl)
                            823 ;src/Map.c:200: if(currentPos.y < (MAP_HEIGHT-1)){
   060E 78            [ 4]  824 	ld	a,b
   060F D6 1F         [ 7]  825 	sub	a, #0x1F
   0611 D2 9B 04      [10]  826 	jp	NC,00164$
                            827 ;src/Map.c:202: adjacentType = map[currentPos.x][currentPos.y+1];
   0614 DD 6E FA      [19]  828 	ld	l,-6 (ix)
   0617 DD 66 FB      [19]  829 	ld	h,-5 (ix)
   061A 4E            [ 7]  830 	ld	c,(hl)
   061B 69            [ 4]  831 	ld	l,c
   061C 26 00         [ 7]  832 	ld	h,#0x00
   061E 29            [11]  833 	add	hl, hl
   061F 29            [11]  834 	add	hl, hl
   0620 29            [11]  835 	add	hl, hl
   0621 29            [11]  836 	add	hl, hl
   0622 29            [11]  837 	add	hl, hl
   0623 11 00 60      [10]  838 	ld	de,#0x6000
   0626 19            [11]  839 	add	hl,de
   0627 04            [ 4]  840 	inc	b
   0628 58            [ 4]  841 	ld	e,b
   0629 16 00         [ 7]  842 	ld	d,#0x00
   062B 19            [11]  843 	add	hl,de
   062C 7E            [ 7]  844 	ld	a,(hl)
                            845 ;src/Map.c:203: if(adjacentType == CELLTYPE_UNDEFINED){
   062D D6 87         [ 7]  846 	sub	a, #0x87
   062F C2 9B 04      [10]  847 	jp	NZ,00164$
                            848 ;src/Map.c:206: ++lastStackItem;
   0632 DD 34 EC      [23]  849 	inc	-20 (ix)
   0635 20 03         [12]  850 	jr	NZ,00349$
   0637 DD 34 ED      [23]  851 	inc	-19 (ix)
   063A                     852 00349$:
                            853 ;src/Map.c:207: (*(cellStack+lastStackItem)).x = currentPos.x;
   063A E1            [10]  854 	pop	hl
   063B E5            [11]  855 	push	hl
   063C 29            [11]  856 	add	hl, hl
   063D 11 00 64      [10]  857 	ld	de,#0x6400
   0640 19            [11]  858 	add	hl,de
   0641 71            [ 7]  859 	ld	(hl),c
                            860 ;src/Map.c:208: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   0642 23            [ 6]  861 	inc	hl
   0643 4D            [ 4]  862 	ld	c,l
   0644 44            [ 4]  863 	ld	b,h
   0645 DD 6E FE      [19]  864 	ld	l,-2 (ix)
   0648 DD 66 FF      [19]  865 	ld	h,-1 (ix)
   064B 7E            [ 7]  866 	ld	a,(hl)
   064C 3C            [ 4]  867 	inc	a
   064D 02            [ 7]  868 	ld	(bc),a
   064E C3 9B 04      [10]  869 	jp	00164$
   0651                     870 00162$:
                            871 ;src/Map.c:214: ++wallListCount;
   0651 DD 34 FC      [23]  872 	inc	-4 (ix)
   0654 20 03         [12]  873 	jr	NZ,00350$
   0656 DD 34 FD      [23]  874 	inc	-3 (ix)
   0659                     875 00350$:
   0659 DD 7E FC      [19]  876 	ld	a,-4 (ix)
   065C DD 77 EE      [19]  877 	ld	-18 (ix),a
   065F DD 7E FD      [19]  878 	ld	a,-3 (ix)
   0662 DD 77 EF      [19]  879 	ld	-17 (ix),a
                            880 ;src/Map.c:215: (*(wallList+wallListCount)).x = currentPos.x;
   0665 DD 6E FC      [19]  881 	ld	l,-4 (ix)
   0668 DD 66 FD      [19]  882 	ld	h,-3 (ix)
   066B 29            [11]  883 	add	hl, hl
   066C 01 00 68      [10]  884 	ld	bc,#0x6800
   066F 09            [11]  885 	add	hl,bc
   0670 DD 7E F9      [19]  886 	ld	a,-7 (ix)
   0673 77            [ 7]  887 	ld	(hl),a
                            888 ;src/Map.c:216: (*(wallList+wallListCount)).y = currentPos.y;
   0674 23            [ 6]  889 	inc	hl
   0675 4D            [ 4]  890 	ld	c,l
   0676 44            [ 4]  891 	ld	b,h
   0677 DD 6E FE      [19]  892 	ld	l,-2 (ix)
   067A DD 66 FF      [19]  893 	ld	h,-1 (ix)
   067D 7E            [ 7]  894 	ld	a,(hl)
   067E 02            [ 7]  895 	ld	(bc),a
   067F C3 9B 04      [10]  896 	jp	00164$
   0682                     897 00174$:
   0682 DD F9         [10]  898 	ld	sp, ix
   0684 DD E1         [14]  899 	pop	ix
   0686 C9            [10]  900 	ret
                            901 ;src/Map.c:222: void generate_exit_door(){
                            902 ;	---------------------------------
                            903 ; Function generate_exit_door
                            904 ; ---------------------------------
   0687                     905 _generate_exit_door::
   0687 DD E5         [15]  906 	push	ix
   0689 DD 21 00 00   [14]  907 	ld	ix,#0
   068D DD 39         [15]  908 	add	ix,sp
   068F 21 F2 FF      [10]  909 	ld	hl,#-14
   0692 39            [11]  910 	add	hl,sp
   0693 F9            [ 6]  911 	ld	sp,hl
                            912 ;src/Map.c:223: u8 x=(cpct_getRandom_lcg_u8()%32);
   0694 CD CA 46      [17]  913 	call	_cpct_getRandom_lcg_u8
   0697 7D            [ 4]  914 	ld	a,l
   0698 E6 1F         [ 7]  915 	and	a, #0x1F
   069A 4F            [ 4]  916 	ld	c,a
                            917 ;src/Map.c:224: u8 y=(cpct_getRandom_lcg_u8()%32);
   069B C5            [11]  918 	push	bc
   069C CD CA 46      [17]  919 	call	_cpct_getRandom_lcg_u8
   069F C1            [10]  920 	pop	bc
   06A0 7D            [ 4]  921 	ld	a,l
   06A1 E6 1F         [ 7]  922 	and	a, #0x1F
   06A3 5F            [ 4]  923 	ld	e,a
                            924 ;src/Map.c:225: u8 door_not_positioned=1;
   06A4 DD 36 F2 01   [19]  925 	ld	-14 (ix),#0x01
                            926 ;src/Map.c:232: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
   06A8 06 00         [ 7]  927 	ld	b,#0x00
   06AA 21 00 60      [10]  928 	ld	hl,#0x6000
   06AD 09            [11]  929 	add	hl,bc
   06AE 4D            [ 4]  930 	ld	c,l
   06AF 44            [ 4]  931 	ld	b,h
   06B0 6B            [ 4]  932 	ld	l,e
   06B1 26 00         [ 7]  933 	ld	h,#0x00
   06B3 29            [11]  934 	add	hl, hl
   06B4 29            [11]  935 	add	hl, hl
   06B5 29            [11]  936 	add	hl, hl
   06B6 29            [11]  937 	add	hl, hl
   06B7 29            [11]  938 	add	hl, hl
   06B8 09            [11]  939 	add	hl,bc
   06B9 4D            [ 4]  940 	ld	c,l
   06BA 44            [ 4]  941 	ld	b,h
                            942 ;src/Map.c:237: lastVal = (position-1);
   06BB 59            [ 4]  943 	ld	e,c
   06BC 50            [ 4]  944 	ld	d,b
   06BD 1B            [ 6]  945 	dec	de
                            946 ;src/Map.c:238: nextVal = (position+1);
   06BE 21 01 00      [10]  947 	ld	hl,#0x0001
   06C1 09            [11]  948 	add	hl,bc
   06C2 DD 75 F5      [19]  949 	ld	-11 (ix),l
   06C5 DD 74 F6      [19]  950 	ld	-10 (ix),h
                            951 ;src/Map.c:239: topVal = (position-MAP_WIDTH);
   06C8 79            [ 4]  952 	ld	a,c
   06C9 C6 E0         [ 7]  953 	add	a,#0xE0
   06CB DD 77 F3      [19]  954 	ld	-13 (ix),a
   06CE 78            [ 4]  955 	ld	a,b
   06CF CE FF         [ 7]  956 	adc	a,#0xFF
   06D1 DD 77 F4      [19]  957 	ld	-12 (ix),a
                            958 ;src/Map.c:240: bottomVal = (position+MAP_WIDTH);
   06D4 FD 21 20 00   [14]  959 	ld	iy,#0x0020
   06D8 FD 09         [15]  960 	add	iy, bc
                            961 ;src/Map.c:242: while(door_not_positioned){
   06DA                     962 00138$:
   06DA DD 7E F2      [19]  963 	ld	a,-14 (ix)
   06DD B7            [ 4]  964 	or	a, a
   06DE CA 36 08      [10]  965 	jp	Z,00141$
                            966 ;src/Map.c:243: if((*position)!=CELLTYPE_FLOOR){
   06E1 0A            [ 7]  967 	ld	a,(bc)
   06E2 B7            [ 4]  968 	or	a, a
   06E3 CA F8 07      [10]  969 	jp	Z,00135$
                            970 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   06E6 1A            [ 7]  971 	ld	a,(de)
   06E7 DD 77 FD      [19]  972 	ld	-3 (ix),a
   06EA DD 73 F7      [19]  973 	ld	-9 (ix),e
   06ED DD 72 F8      [19]  974 	ld	-8 (ix),d
   06F0 DD 7E F5      [19]  975 	ld	a,-11 (ix)
   06F3 DD 77 FB      [19]  976 	ld	-5 (ix),a
   06F6 DD 7E F6      [19]  977 	ld	a,-10 (ix)
   06F9 DD 77 FC      [19]  978 	ld	-4 (ix),a
                            979 ;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   06FC DD 6E F3      [19]  980 	ld	l,-13 (ix)
   06FF DD 66 F4      [19]  981 	ld	h,-12 (ix)
   0702 7E            [ 7]  982 	ld	a,(hl)
   0703 DD 77 FA      [19]  983 	ld	-6 (ix),a
   0706 DD 7E F3      [19]  984 	ld	a,-13 (ix)
   0709 DD 77 FE      [19]  985 	ld	-2 (ix),a
   070C DD 7E F4      [19]  986 	ld	a,-12 (ix)
   070F DD 77 FF      [19]  987 	ld	-1 (ix),a
   0712 FD E5         [15]  988 	push	iy
   0714 E1            [10]  989 	pop	hl
                            990 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   0715 DD 7E F8      [19]  991 	ld	a,-8 (ix)
   0718 D6 60         [ 7]  992 	sub	a, #0x60
   071A 3E 00         [ 7]  993 	ld	a,#0x00
   071C 17            [ 4]  994 	rla
   071D DD 77 F7      [19]  995 	ld	-9 (ix),a
   0720 DD 7E FC      [19]  996 	ld	a,-4 (ix)
   0723 D6 64         [ 7]  997 	sub	a, #0x64
   0725 3E 00         [ 7]  998 	ld	a,#0x00
   0727 17            [ 4]  999 	rla
   0728 DD 77 FB      [19] 1000 	ld	-5 (ix),a
                           1001 ;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   072B DD 7E FF      [19] 1002 	ld	a,-1 (ix)
   072E D6 60         [ 7] 1003 	sub	a, #0x60
   0730 3E 00         [ 7] 1004 	ld	a,#0x00
   0732 17            [ 4] 1005 	rla
   0733 DD 77 FE      [19] 1006 	ld	-2 (ix),a
   0736 7C            [ 4] 1007 	ld	a,h
   0737 D6 64         [ 7] 1008 	sub	a, #0x64
   0739 3E 00         [ 7] 1009 	ld	a,#0x00
   073B 17            [ 4] 1010 	rla
   073C DD 77 F9      [19] 1011 	ld	-7 (ix),a
                           1012 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   073F DD 7E FD      [19] 1013 	ld	a,-3 (ix)
   0742 B7            [ 4] 1014 	or	a, a
   0743 20 06         [12] 1015 	jr	NZ,00133$
   0745 DD 7E F7      [19] 1016 	ld	a,-9 (ix)
   0748 B7            [ 4] 1017 	or	a, a
   0749 28 52         [12] 1018 	jr	Z,00129$
   074B                    1019 00133$:
   074B DD 6E F5      [19] 1020 	ld	l,-11 (ix)
   074E DD 66 F6      [19] 1021 	ld	h,-10 (ix)
   0751 7E            [ 7] 1022 	ld	a,(hl)
   0752 B7            [ 4] 1023 	or	a, a
   0753 20 06         [12] 1024 	jr	NZ,00128$
   0755 DD CB FB 46   [20] 1025 	bit	0,-5 (ix)
   0759 20 42         [12] 1026 	jr	NZ,00129$
   075B                    1027 00128$:
                           1028 ;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   075B FD 6E 00      [19] 1029 	ld	l, 0 (iy)
   075E DD 7E FA      [19] 1030 	ld	a,-6 (ix)
   0761 B7            [ 4] 1031 	or	a, a
   0762 20 06         [12] 1032 	jr	NZ,00111$
   0764 DD 7E FE      [19] 1033 	ld	a,-2 (ix)
   0767 B7            [ 4] 1034 	or	a, a
   0768 28 14         [12] 1035 	jr	Z,00107$
   076A                    1036 00111$:
   076A 7D            [ 4] 1037 	ld	a,l
   076B B7            [ 4] 1038 	or	a, a
   076C 20 10         [12] 1039 	jr	NZ,00107$
   076E DD 7E F9      [19] 1040 	ld	a,-7 (ix)
   0771 B7            [ 4] 1041 	or	a, a
   0772 28 0A         [12] 1042 	jr	Z,00107$
                           1043 ;src/Map.c:246: door_not_positioned=0;
   0774 DD 36 F2 00   [19] 1044 	ld	-14 (ix),#0x00
                           1045 ;src/Map.c:247: *position=CELLTYPE_DOOR;
   0778 3E 80         [ 7] 1046 	ld	a,#0x80
   077A 02            [ 7] 1047 	ld	(bc),a
   077B C3 F8 07      [10] 1048 	jp	00135$
   077E                    1049 00107$:
                           1050 ;src/Map.c:249: else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
   077E 7D            [ 4] 1051 	ld	a,l
   077F B7            [ 4] 1052 	or	a, a
   0780 20 06         [12] 1053 	jr	NZ,00105$
   0782 DD 7E F9      [19] 1054 	ld	a,-7 (ix)
   0785 B7            [ 4] 1055 	or	a, a
   0786 20 70         [12] 1056 	jr	NZ,00135$
   0788                    1057 00105$:
   0788 DD 7E FA      [19] 1058 	ld	a,-6 (ix)
   078B B7            [ 4] 1059 	or	a, a
   078C 20 6A         [12] 1060 	jr	NZ,00135$
   078E DD 7E FE      [19] 1061 	ld	a,-2 (ix)
   0791 B7            [ 4] 1062 	or	a, a
   0792 20 64         [12] 1063 	jr	NZ,00135$
                           1064 ;src/Map.c:250: door_not_positioned=0;
   0794 DD 36 F2 00   [19] 1065 	ld	-14 (ix),#0x00
                           1066 ;src/Map.c:251: *position=CELLTYPE_DOOR;
   0798 3E 80         [ 7] 1067 	ld	a,#0x80
   079A 02            [ 7] 1068 	ld	(bc),a
   079B 18 5B         [12] 1069 	jr	00135$
   079D                    1070 00129$:
                           1071 ;src/Map.c:254: else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
   079D DD 7E FA      [19] 1072 	ld	a,-6 (ix)
   07A0 B7            [ 4] 1073 	or	a, a
   07A1 20 06         [12] 1074 	jr	NZ,00127$
   07A3 DD 7E FE      [19] 1075 	ld	a,-2 (ix)
   07A6 B7            [ 4] 1076 	or	a, a
   07A7 28 4F         [12] 1077 	jr	Z,00135$
   07A9                    1078 00127$:
   07A9 FD 7E 00      [19] 1079 	ld	a, 0 (iy)
   07AC B7            [ 4] 1080 	or	a, a
   07AD 20 06         [12] 1081 	jr	NZ,00123$
   07AF DD 7E F9      [19] 1082 	ld	a,-7 (ix)
   07B2 B7            [ 4] 1083 	or	a, a
   07B3 20 43         [12] 1084 	jr	NZ,00135$
   07B5                    1085 00123$:
                           1086 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   07B5 DD 6E F5      [19] 1087 	ld	l,-11 (ix)
   07B8 DD 66 F6      [19] 1088 	ld	h,-10 (ix)
   07BB 6E            [ 7] 1089 	ld	l,(hl)
                           1090 ;src/Map.c:255: if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
   07BC DD 7E FD      [19] 1091 	ld	a,-3 (ix)
   07BF B7            [ 4] 1092 	or	a, a
   07C0 20 06         [12] 1093 	jr	NZ,00122$
   07C2 DD 7E F7      [19] 1094 	ld	a,-9 (ix)
   07C5 B7            [ 4] 1095 	or	a, a
   07C6 28 13         [12] 1096 	jr	Z,00118$
   07C8                    1097 00122$:
   07C8 7D            [ 4] 1098 	ld	a,l
   07C9 B7            [ 4] 1099 	or	a, a
   07CA 20 0F         [12] 1100 	jr	NZ,00118$
   07CC DD CB FB 46   [20] 1101 	bit	0,-5 (ix)
   07D0 28 09         [12] 1102 	jr	Z,00118$
                           1103 ;src/Map.c:256: door_not_positioned=0;
   07D2 DD 36 F2 00   [19] 1104 	ld	-14 (ix),#0x00
                           1105 ;src/Map.c:257: *position=CELLTYPE_DOOR;
   07D6 3E 80         [ 7] 1106 	ld	a,#0x80
   07D8 02            [ 7] 1107 	ld	(bc),a
   07D9 18 1D         [12] 1108 	jr	00135$
   07DB                    1109 00118$:
                           1110 ;src/Map.c:259: else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
   07DB 7D            [ 4] 1111 	ld	a,l
   07DC B7            [ 4] 1112 	or	a, a
   07DD 20 06         [12] 1113 	jr	NZ,00116$
   07DF DD CB FB 46   [20] 1114 	bit	0,-5 (ix)
   07E3 20 13         [12] 1115 	jr	NZ,00135$
   07E5                    1116 00116$:
   07E5 DD 7E FD      [19] 1117 	ld	a,-3 (ix)
   07E8 B7            [ 4] 1118 	or	a, a
   07E9 20 0D         [12] 1119 	jr	NZ,00135$
   07EB DD 7E F7      [19] 1120 	ld	a,-9 (ix)
   07EE B7            [ 4] 1121 	or	a, a
   07EF 20 07         [12] 1122 	jr	NZ,00135$
                           1123 ;src/Map.c:260: door_not_positioned=0;
   07F1 DD 36 F2 00   [19] 1124 	ld	-14 (ix),#0x00
                           1125 ;src/Map.c:261: *position=CELLTYPE_DOOR;
   07F5 3E 80         [ 7] 1126 	ld	a,#0x80
   07F7 02            [ 7] 1127 	ld	(bc),a
   07F8                    1128 00135$:
                           1129 ;src/Map.c:265: ++position;
   07F8 03            [ 6] 1130 	inc	bc
                           1131 ;src/Map.c:266: ++lastVal;
   07F9 13            [ 6] 1132 	inc	de
                           1133 ;src/Map.c:267: ++nextVal;
   07FA DD 34 F5      [23] 1134 	inc	-11 (ix)
   07FD 20 03         [12] 1135 	jr	NZ,00223$
   07FF DD 34 F6      [23] 1136 	inc	-10 (ix)
   0802                    1137 00223$:
                           1138 ;src/Map.c:268: ++topVal;
   0802 DD 34 F3      [23] 1139 	inc	-13 (ix)
   0805 20 03         [12] 1140 	jr	NZ,00224$
   0807 DD 34 F4      [23] 1141 	inc	-12 (ix)
   080A                    1142 00224$:
                           1143 ;src/Map.c:269: ++bottomVal;
   080A FD 23         [10] 1144 	inc	iy
                           1145 ;src/Map.c:270: if(position==END_OF_MAP_MEM){
   080C 69            [ 4] 1146 	ld	l, c
   080D 60            [ 4] 1147 	ld	h, b
   080E 7D            [ 4] 1148 	ld	a,l
   080F B7            [ 4] 1149 	or	a, a
   0810 C2 DA 06      [10] 1150 	jp	NZ,00138$
   0813 7C            [ 4] 1151 	ld	a,h
   0814 D6 64         [ 7] 1152 	sub	a, #0x64
   0816 C2 DA 06      [10] 1153 	jp	NZ,00138$
                           1154 ;src/Map.c:271: position = MAP_MEM;
   0819 01 00 60      [10] 1155 	ld	bc,#0x6000
                           1156 ;src/Map.c:272: lastVal = (position-1);
   081C 11 FF 5F      [10] 1157 	ld	de,#0x5FFF
                           1158 ;src/Map.c:273: nextVal = (position+1);
   081F DD 36 F5 01   [19] 1159 	ld	-11 (ix),#0x01
   0823 DD 36 F6 60   [19] 1160 	ld	-10 (ix),#0x60
                           1161 ;src/Map.c:274: topVal = (position-MAP_WIDTH);
   0827 DD 36 F3 E0   [19] 1162 	ld	-13 (ix),#0xE0
   082B DD 36 F4 5F   [19] 1163 	ld	-12 (ix),#0x5F
                           1164 ;src/Map.c:275: bottomVal = (position+MAP_WIDTH);
   082F FD 21 20 60   [14] 1165 	ld	iy,#0x6020
   0833 C3 DA 06      [10] 1166 	jp	00138$
   0836                    1167 00141$:
   0836 DD F9         [10] 1168 	ld	sp, ix
   0838 DD E1         [14] 1169 	pop	ix
   083A C9            [10] 1170 	ret
                           1171 ;src/Map.c:281: void generate_level(){
                           1172 ;	---------------------------------
                           1173 ; Function generate_level
                           1174 ; ---------------------------------
   083B                    1175 _generate_level::
                           1176 ;src/Map.c:282: generate_level_with_seed(r_counter);
   083B 3A 15 49      [13] 1177 	ld	a,(_r_counter)
   083E F5            [11] 1178 	push	af
   083F 33            [ 6] 1179 	inc	sp
   0840 CD 45 08      [17] 1180 	call	_generate_level_with_seed
   0843 33            [ 6] 1181 	inc	sp
   0844 C9            [10] 1182 	ret
                           1183 ;src/Map.c:285: void generate_level_with_seed(u8 seed){
                           1184 ;	---------------------------------
                           1185 ; Function generate_level_with_seed
                           1186 ; ---------------------------------
   0845                    1187 _generate_level_with_seed::
                           1188 ;src/Map.c:287: rand_seed=seed;
   0845 21 02 00      [10] 1189 	ld	hl, #2+0
   0848 39            [11] 1190 	add	hl, sp
   0849 7E            [ 7] 1191 	ld	a, (hl)
   084A 32 16 49      [13] 1192 	ld	(#_rand_seed + 0),a
                           1193 ;src/Map.c:288: cpct_setSeed_lcg_u8(seed+level_get_level());
   084D CD C4 00      [17] 1194 	call	_level_get_level
   0850 FD 21 02 00   [14] 1195 	ld	iy,#2
   0854 FD 39         [15] 1196 	add	iy,sp
   0856 FD 7E 00      [19] 1197 	ld	a,0 (iy)
   0859 85            [ 4] 1198 	add	a, l
   085A 6F            [ 4] 1199 	ld	l,a
   085B CD 70 46      [17] 1200 	call	_cpct_setSeed_lcg_u8
                           1201 ;src/Map.c:290: generate_map();
   085E CD D2 01      [17] 1202 	call	_generate_map
                           1203 ;src/Map.c:291: generate_exit_door();
   0861 CD 87 06      [17] 1204 	call	_generate_exit_door
                           1205 ;src/Map.c:292: *(u8*)(MAP_MEM + 6 + MAP_WIDTH*5)=0b00000001;
   0864 21 A6 60      [10] 1206 	ld	hl,#0x60A6
   0867 36 01         [10] 1207 	ld	(hl),#0x01
   0869 C9            [10] 1208 	ret
                           1209 	.area _CODE
                           1210 	.area _INITIALIZER
   491F                    1211 __xinit__rand_seed:
   491F 00                 1212 	.db #0x00	; 0
                           1213 	.area _CABS (ABS)
