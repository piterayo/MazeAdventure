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
                             16 	.globl _cpct_restoreState_mxor_u8
                             17 	.globl _cpct_setSeed_mxor
                             18 	.globl _cpct_getRandom_mxor_u8
                             19 	.globl _cpct_memset
                             20 	.globl _rand_seed
                             21 	.globl _map_get_seed
                             22 	.globl _generate_level
                             23 	.globl _generate_level_with_seed
                             24 ;--------------------------------------------------------
                             25 ; special function registers
                             26 ;--------------------------------------------------------
                             27 ;--------------------------------------------------------
                             28 ; ram data
                             29 ;--------------------------------------------------------
                             30 	.area _DATA
                             31 ;--------------------------------------------------------
                             32 ; ram data
                             33 ;--------------------------------------------------------
                             34 	.area _INITIALIZED
   4FA4                      35 _rand_seed::
   4FA4                      36 	.ds 1
                             37 ;--------------------------------------------------------
                             38 ; absolute external ram data
                             39 ;--------------------------------------------------------
                             40 	.area _DABS (ABS)
                             41 ;--------------------------------------------------------
                             42 ; global & static initialisations
                             43 ;--------------------------------------------------------
                             44 	.area _HOME
                             45 	.area _GSINIT
                             46 	.area _GSFINAL
                             47 	.area _GSINIT
                             48 ;--------------------------------------------------------
                             49 ; Home
                             50 ;--------------------------------------------------------
                             51 	.area _HOME
                             52 	.area _HOME
                             53 ;--------------------------------------------------------
                             54 ; code
                             55 ;--------------------------------------------------------
                             56 	.area _CODE
                             57 ;src/Map.c:14: u8 map_get_seed(){
                             58 ;	---------------------------------
                             59 ; Function map_get_seed
                             60 ; ---------------------------------
   0198                      61 _map_get_seed::
                             62 ;src/Map.c:15: return rand_seed;
   0198 FD 21 A4 4F   [14]   63 	ld	iy,#_rand_seed
   019C FD 6E 00      [19]   64 	ld	l,0 (iy)
   019F C9            [10]   65 	ret
                             66 ;src/Map.c:18: u8 get_random_wall(){
                             67 ;	---------------------------------
                             68 ; Function get_random_wall
                             69 ; ---------------------------------
   01A0                      70 _get_random_wall::
                             71 ;src/Map.c:19: u8 cellType = cpct_getRandom_mxor_u8 ();
   01A0 CD 20 4D      [17]   72 	call	_cpct_getRandom_mxor_u8
                             73 ;src/Map.c:20: if(cellType&1){
   01A3 CB 45         [ 8]   74 	bit	0, l
   01A5 28 03         [12]   75 	jr	Z,00108$
                             76 ;src/Map.c:21: return CELLTYPE_WALL1;
   01A7 2E 81         [ 7]   77 	ld	l,#0x81
   01A9 C9            [10]   78 	ret
   01AA                      79 00108$:
                             80 ;src/Map.c:24: if(cellType&3){
   01AA 7D            [ 4]   81 	ld	a,l
   01AB E6 03         [ 7]   82 	and	a, #0x03
   01AD 28 03         [12]   83 	jr	Z,00105$
                             84 ;src/Map.c:25: return CELLTYPE_WALL2;
   01AF 2E 82         [ 7]   85 	ld	l,#0x82
   01B1 C9            [10]   86 	ret
   01B2                      87 00105$:
                             88 ;src/Map.c:28: if(cellType&5){
   01B2 7D            [ 4]   89 	ld	a,l
   01B3 E6 05         [ 7]   90 	and	a, #0x05
   01B5 28 03         [12]   91 	jr	Z,00102$
                             92 ;src/Map.c:29: return CELLTYPE_WALL3;
   01B7 2E 83         [ 7]   93 	ld	l,#0x83
   01B9 C9            [10]   94 	ret
   01BA                      95 00102$:
                             96 ;src/Map.c:32: return CELLTYPE_WALL4;  
   01BA 2E 84         [ 7]   97 	ld	l,#0x84
   01BC C9            [10]   98 	ret
                             99 ;src/Map.c:38: void generate_map(){
                            100 ;	---------------------------------
                            101 ; Function generate_map
                            102 ; ---------------------------------
   01BD                     103 _generate_map::
   01BD DD E5         [15]  104 	push	ix
   01BF DD 21 00 00   [14]  105 	ld	ix,#0
   01C3 DD 39         [15]  106 	add	ix,sp
   01C5 21 EC FF      [10]  107 	ld	hl,#-20
   01C8 39            [11]  108 	add	hl,sp
   01C9 F9            [ 6]  109 	ld	sp,hl
                            110 ;src/Map.c:41: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
   01CA DD 36 F2 83   [19]  111 	ld	-14 (ix),#0x83
   01CE DD 36 F3 03   [19]  112 	ld	-13 (ix),#0x03
                            113 ;src/Map.c:47: u16 wallListCount = 0;
   01D2 DD 36 EE 00   [19]  114 	ld	-18 (ix),#0x00
   01D6 DD 36 EF 00   [19]  115 	ld	-17 (ix),#0x00
                            116 ;src/Map.c:48: u16 lastStackItem = 0;
   01DA 21 00 00      [10]  117 	ld	hl,#0x0000
   01DD E3            [19]  118 	ex	(sp), hl
                            119 ;src/Map.c:50: cpct_memset (GENERATOR_DATA_PTR, 0, 4096);
   01DE 21 00 10      [10]  120 	ld	hl,#0x1000
   01E1 E5            [11]  121 	push	hl
   01E2 AF            [ 4]  122 	xor	a, a
   01E3 F5            [11]  123 	push	af
   01E4 33            [ 6]  124 	inc	sp
   01E5 26 74         [ 7]  125 	ld	h, #0x74
   01E7 E5            [11]  126 	push	hl
   01E8 CD 9A 4D      [17]  127 	call	_cpct_memset
                            128 ;src/Map.c:52: (*cellStack).x = (cpct_getRandom_mxor_u8 ()%(MAP_WIDTH-2))+1; //RANDOM
   01EB CD 20 4D      [17]  129 	call	_cpct_getRandom_mxor_u8
   01EE 45            [ 4]  130 	ld	b,l
   01EF 3E 1E         [ 7]  131 	ld	a,#0x1E
   01F1 F5            [11]  132 	push	af
   01F2 33            [ 6]  133 	inc	sp
   01F3 C5            [11]  134 	push	bc
   01F4 33            [ 6]  135 	inc	sp
   01F5 CD 81 4C      [17]  136 	call	__moduchar
   01F8 F1            [10]  137 	pop	af
   01F9 4D            [ 4]  138 	ld	c,l
   01FA 0C            [ 4]  139 	inc	c
   01FB 21 00 74      [10]  140 	ld	hl,#0x7400
   01FE 71            [ 7]  141 	ld	(hl),c
                            142 ;src/Map.c:53: (*cellStack).y = (cpct_getRandom_mxor_u8 ()%(MAP_HEIGHT-2))+1; //RANDOM
   01FF CD 20 4D      [17]  143 	call	_cpct_getRandom_mxor_u8
   0202 45            [ 4]  144 	ld	b,l
   0203 3E 1E         [ 7]  145 	ld	a,#0x1E
   0205 F5            [11]  146 	push	af
   0206 33            [ 6]  147 	inc	sp
   0207 C5            [11]  148 	push	bc
   0208 33            [ 6]  149 	inc	sp
   0209 CD 81 4C      [17]  150 	call	__moduchar
   020C F1            [10]  151 	pop	af
   020D 4D            [ 4]  152 	ld	c,l
   020E 0C            [ 4]  153 	inc	c
   020F 21 01 74      [10]  154 	ld	hl,#0x7401
   0212 71            [ 7]  155 	ld	(hl),c
                            156 ;src/Map.c:55: rotatePlayer = cpct_getRandom_mxor_u8 ()%4;
   0213 CD 20 4D      [17]  157 	call	_cpct_getRandom_mxor_u8
   0216 7D            [ 4]  158 	ld	a,l
   0217 E6 03         [ 7]  159 	and	a, #0x03
   0219 4F            [ 4]  160 	ld	c,a
                            161 ;src/Map.c:56: while(rotatePlayer){
   021A                     162 00101$:
   021A 79            [ 4]  163 	ld	a,c
   021B B7            [ 4]  164 	or	a, a
   021C 28 08         [12]  165 	jr	Z,00103$
                            166 ;src/Map.c:57: player_turn_left();
   021E C5            [11]  167 	push	bc
   021F CD 5B 08      [17]  168 	call	_player_turn_left
   0222 C1            [10]  169 	pop	bc
                            170 ;src/Map.c:58: --rotatePlayer;
   0223 0D            [ 4]  171 	dec	c
   0224 18 F4         [12]  172 	jr	00101$
   0226                     173 00103$:
                            174 ;src/Map.c:61: *(i8*)&(player_position.x) = (*cellStack).y;
   0226 01 89 08      [10]  175 	ld	bc,#_player_position+0
   0229 3A 01 74      [13]  176 	ld	a,(#0x7401)
   022C 02            [ 7]  177 	ld	(bc),a
                            178 ;src/Map.c:62: *(i8*)&(player_position.y) = (*cellStack).x;
   022D 01 8A 08      [10]  179 	ld	bc,#_player_position+1
   0230 3A 00 74      [13]  180 	ld	a,(#0x7400)
   0233 02            [ 7]  181 	ld	(bc),a
                            182 ;src/Map.c:64: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   0234 21 00 04      [10]  183 	ld	hl,#0x0400
   0237 E5            [11]  184 	push	hl
   0238 3E 87         [ 7]  185 	ld	a,#0x87
   023A F5            [11]  186 	push	af
   023B 33            [ 6]  187 	inc	sp
   023C 26 70         [ 7]  188 	ld	h, #0x70
   023E E5            [11]  189 	push	hl
   023F CD 9A 4D      [17]  190 	call	_cpct_memset
                            191 ;src/Map.c:67: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   0242 21 00 74      [10]  192 	ld	hl,#0x7400
   0245 6E            [ 7]  193 	ld	l,(hl)
   0246 26 00         [ 7]  194 	ld	h,#0x00
   0248 29            [11]  195 	add	hl, hl
   0249 29            [11]  196 	add	hl, hl
   024A 29            [11]  197 	add	hl, hl
   024B 29            [11]  198 	add	hl, hl
   024C 29            [11]  199 	add	hl, hl
   024D 01 00 70      [10]  200 	ld	bc,#0x7000
   0250 09            [11]  201 	add	hl,bc
   0251 4D            [ 4]  202 	ld	c,l
   0252 44            [ 4]  203 	ld	b,h
   0253 21 01 74      [10]  204 	ld	hl,#0x7401
   0256 6E            [ 7]  205 	ld	l, (hl)
   0257 26 00         [ 7]  206 	ld	h,#0x00
   0259 09            [11]  207 	add	hl,bc
   025A 36 00         [10]  208 	ld	(hl),#0x00
                            209 ;src/Map.c:70: for(i=0;i<MAP_WIDTH;++i){
   025C 0E 00         [ 7]  210 	ld	c,#0x00
   025E                     211 00170$:
                            212 ;src/Map.c:71: map[0][i]=CELLTYPE_WALL1;//get_random_wall();
   025E 21 00 70      [10]  213 	ld	hl,#0x7000
   0261 06 00         [ 7]  214 	ld	b,#0x00
   0263 09            [11]  215 	add	hl, bc
   0264 36 81         [10]  216 	ld	(hl),#0x81
                            217 ;src/Map.c:72: map[MAP_HEIGHT-1][i]=CELLTYPE_WALL1;//get_random_wall();
   0266 21 E0 73      [10]  218 	ld	hl,#0x73E0
   0269 06 00         [ 7]  219 	ld	b,#0x00
   026B 09            [11]  220 	add	hl, bc
   026C 36 81         [10]  221 	ld	(hl),#0x81
                            222 ;src/Map.c:70: for(i=0;i<MAP_WIDTH;++i){
   026E 0C            [ 4]  223 	inc	c
   026F 79            [ 4]  224 	ld	a,c
   0270 D6 20         [ 7]  225 	sub	a, #0x20
   0272 38 EA         [12]  226 	jr	C,00170$
                            227 ;src/Map.c:75: for(i=1;i<MAP_HEIGHT-1;++i){
   0274 0E 01         [ 7]  228 	ld	c,#0x01
   0276                     229 00172$:
                            230 ;src/Map.c:76: map[i][0]=CELLTYPE_WALL1;//get_random_wall();
   0276 69            [ 4]  231 	ld	l,c
   0277 26 00         [ 7]  232 	ld	h,#0x00
   0279 29            [11]  233 	add	hl, hl
   027A 29            [11]  234 	add	hl, hl
   027B 29            [11]  235 	add	hl, hl
   027C 29            [11]  236 	add	hl, hl
   027D 29            [11]  237 	add	hl, hl
   027E EB            [ 4]  238 	ex	de,hl
   027F 21 00 70      [10]  239 	ld	hl,#0x7000
   0282 19            [11]  240 	add	hl,de
   0283 36 81         [10]  241 	ld	(hl),#0x81
                            242 ;src/Map.c:77: map[i][MAP_WIDTH-1]=CELLTYPE_WALL1;//get_random_wall();
   0285 21 00 70      [10]  243 	ld	hl,#0x7000
   0288 19            [11]  244 	add	hl,de
   0289 11 1F 00      [10]  245 	ld	de,#0x001F
   028C 19            [11]  246 	add	hl,de
   028D 36 81         [10]  247 	ld	(hl),#0x81
                            248 ;src/Map.c:75: for(i=1;i<MAP_HEIGHT-1;++i){
   028F 0C            [ 4]  249 	inc	c
   0290 79            [ 4]  250 	ld	a,c
   0291 D6 1F         [ 7]  251 	sub	a, #0x1F
   0293 38 E1         [12]  252 	jr	C,00172$
                            253 ;src/Map.c:80: while(remainingCells>0){
   0295 21 04 00      [10]  254 	ld	hl,#0x0004
   0298 39            [11]  255 	add	hl,sp
   0299 DD 75 FA      [19]  256 	ld	-6 (ix),l
   029C DD 74 FB      [19]  257 	ld	-5 (ix),h
   029F                     258 00167$:
   029F DD 7E F3      [19]  259 	ld	a,-13 (ix)
   02A2 DD B6 F2      [19]  260 	or	a,-14 (ix)
   02A5 CA 6D 06      [10]  261 	jp	Z,00174$
                            262 ;src/Map.c:81: wallListPosition = wallList+wallListCount;
   02A8 C1            [10]  263 	pop	bc
   02A9 E1            [10]  264 	pop	hl
   02AA E5            [11]  265 	push	hl
   02AB C5            [11]  266 	push	bc
   02AC 29            [11]  267 	add	hl, hl
   02AD 7D            [ 4]  268 	ld	a,l
   02AE C6 00         [ 7]  269 	add	a, #0x00
   02B0 DD 77 FC      [19]  270 	ld	-4 (ix),a
   02B3 7C            [ 4]  271 	ld	a,h
   02B4 CE 78         [ 7]  272 	adc	a, #0x78
   02B6 DD 77 FD      [19]  273 	ld	-3 (ix),a
                            274 ;src/Map.c:82: while(wallListCount<MAP_SIZE){
   02B9 D1            [10]  275 	pop	de
   02BA C1            [10]  276 	pop	bc
   02BB C5            [11]  277 	push	bc
   02BC D5            [11]  278 	push	de
   02BD                     279 00137$:
                            280 ;src/Map.c:85: currentPos.y = (*wallListPosition).y;
   02BD DD 7E FA      [19]  281 	ld	a,-6 (ix)
   02C0 C6 01         [ 7]  282 	add	a, #0x01
   02C2 DD 77 FE      [19]  283 	ld	-2 (ix),a
   02C5 DD 7E FB      [19]  284 	ld	a,-5 (ix)
   02C8 CE 00         [ 7]  285 	adc	a, #0x00
   02CA DD 77 FF      [19]  286 	ld	-1 (ix),a
                            287 ;src/Map.c:82: while(wallListCount<MAP_SIZE){
   02CD 78            [ 4]  288 	ld	a,b
   02CE D6 04         [ 7]  289 	sub	a, #0x04
   02D0 D2 6E 04      [10]  290 	jp	NC,00209$
                            291 ;src/Map.c:84: currentPos.x = (*wallListPosition).x;
   02D3 21 04 00      [10]  292 	ld	hl,#0x0004
   02D6 39            [11]  293 	add	hl,sp
   02D7 EB            [ 4]  294 	ex	de,hl
   02D8 DD 6E FC      [19]  295 	ld	l,-4 (ix)
   02DB DD 66 FD      [19]  296 	ld	h,-3 (ix)
   02DE 7E            [ 7]  297 	ld	a,(hl)
   02DF 12            [ 7]  298 	ld	(de),a
                            299 ;src/Map.c:85: currentPos.y = (*wallListPosition).y;
   02E0 DD 5E FC      [19]  300 	ld	e,-4 (ix)
   02E3 DD 56 FD      [19]  301 	ld	d,-3 (ix)
   02E6 13            [ 6]  302 	inc	de
   02E7 1A            [ 7]  303 	ld	a,(de)
   02E8 DD 6E FE      [19]  304 	ld	l,-2 (ix)
   02EB DD 66 FF      [19]  305 	ld	h,-1 (ix)
   02EE 77            [ 7]  306 	ld	(hl),a
                            307 ;src/Map.c:87: convertToFloor=0;
   02EF DD 36 F5 00   [19]  308 	ld	-11 (ix),#0x00
                            309 ;src/Map.c:88: surroundedByWalls=1;
   02F3 DD 36 F4 01   [19]  310 	ld	-12 (ix),#0x01
                            311 ;src/Map.c:90: if(currentPos.x>0){
   02F7 DD 6E FA      [19]  312 	ld	l,-6 (ix)
   02FA DD 66 FB      [19]  313 	ld	h,-5 (ix)
   02FD 7E            [ 7]  314 	ld	a,(hl)
   02FE DD 77 F8      [19]  315 	ld	-8 (ix),a
                            316 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   0301 DD 6E FE      [19]  317 	ld	l,-2 (ix)
   0304 DD 66 FF      [19]  318 	ld	h,-1 (ix)
   0307 7E            [ 7]  319 	ld	a,(hl)
   0308 DD 77 F9      [19]  320 	ld	-7 (ix),a
   030B DD 7E F8      [19]  321 	ld	a,-8 (ix)
   030E DD 77 F6      [19]  322 	ld	-10 (ix),a
   0311 DD 36 F7 00   [19]  323 	ld	-9 (ix),#0x00
                            324 ;src/Map.c:90: if(currentPos.x>0){
   0315 DD 7E F8      [19]  325 	ld	a,-8 (ix)
   0318 B7            [ 4]  326 	or	a, a
   0319 28 2F         [12]  327 	jr	Z,00112$
                            328 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   031B DD 6E F6      [19]  329 	ld	l,-10 (ix)
   031E DD 66 F7      [19]  330 	ld	h,-9 (ix)
   0321 2B            [ 6]  331 	dec	hl
   0322 29            [11]  332 	add	hl, hl
   0323 29            [11]  333 	add	hl, hl
   0324 29            [11]  334 	add	hl, hl
   0325 29            [11]  335 	add	hl, hl
   0326 29            [11]  336 	add	hl, hl
   0327 D5            [11]  337 	push	de
   0328 11 00 70      [10]  338 	ld	de,#0x7000
   032B 19            [11]  339 	add	hl, de
   032C D1            [10]  340 	pop	de
   032D 7D            [ 4]  341 	ld	a,l
   032E DD 86 F9      [19]  342 	add	a, -7 (ix)
   0331 6F            [ 4]  343 	ld	l,a
   0332 7C            [ 4]  344 	ld	a,h
   0333 CE 00         [ 7]  345 	adc	a, #0x00
   0335 67            [ 4]  346 	ld	h,a
   0336 6E            [ 7]  347 	ld	l,(hl)
                            348 ;src/Map.c:92: if(adjacentType == CELLTYPE_UNDEFINED){
   0337 7D            [ 4]  349 	ld	a,l
   0338 D6 87         [ 7]  350 	sub	a, #0x87
   033A 20 06         [12]  351 	jr	NZ,00109$
                            352 ;src/Map.c:93: convertToFloor  = 1;
   033C DD 36 F5 01   [19]  353 	ld	-11 (ix),#0x01
   0340 18 08         [12]  354 	jr	00112$
   0342                     355 00109$:
                            356 ;src/Map.c:95: else if(adjacentType == CELLTYPE_FLOOR){
   0342 7D            [ 4]  357 	ld	a,l
   0343 B7            [ 4]  358 	or	a, a
   0344 20 04         [12]  359 	jr	NZ,00112$
                            360 ;src/Map.c:96: surroundedByWalls = 0;
   0346 DD 36 F4 00   [19]  361 	ld	-12 (ix),#0x00
   034A                     362 00112$:
                            363 ;src/Map.c:99: if(currentPos.x < (MAP_WIDTH-1)){
   034A DD 7E F8      [19]  364 	ld	a,-8 (ix)
   034D D6 1F         [ 7]  365 	sub	a, #0x1F
   034F 30 2F         [12]  366 	jr	NC,00119$
                            367 ;src/Map.c:101: adjacentType = map[currentPos.x+1][currentPos.y];
   0351 DD 6E F6      [19]  368 	ld	l,-10 (ix)
   0354 DD 66 F7      [19]  369 	ld	h,-9 (ix)
   0357 23            [ 6]  370 	inc	hl
   0358 29            [11]  371 	add	hl, hl
   0359 29            [11]  372 	add	hl, hl
   035A 29            [11]  373 	add	hl, hl
   035B 29            [11]  374 	add	hl, hl
   035C 29            [11]  375 	add	hl, hl
   035D D5            [11]  376 	push	de
   035E 11 00 70      [10]  377 	ld	de,#0x7000
   0361 19            [11]  378 	add	hl, de
   0362 D1            [10]  379 	pop	de
   0363 7D            [ 4]  380 	ld	a,l
   0364 DD 86 F9      [19]  381 	add	a, -7 (ix)
   0367 6F            [ 4]  382 	ld	l,a
   0368 7C            [ 4]  383 	ld	a,h
   0369 CE 00         [ 7]  384 	adc	a, #0x00
   036B 67            [ 4]  385 	ld	h,a
   036C 6E            [ 7]  386 	ld	l,(hl)
                            387 ;src/Map.c:102: if(adjacentType == CELLTYPE_UNDEFINED){
   036D 7D            [ 4]  388 	ld	a,l
   036E D6 87         [ 7]  389 	sub	a, #0x87
   0370 20 06         [12]  390 	jr	NZ,00116$
                            391 ;src/Map.c:103: convertToFloor  = 1;
   0372 DD 36 F5 01   [19]  392 	ld	-11 (ix),#0x01
   0376 18 08         [12]  393 	jr	00119$
   0378                     394 00116$:
                            395 ;src/Map.c:105: else if(adjacentType == CELLTYPE_FLOOR){
   0378 7D            [ 4]  396 	ld	a,l
   0379 B7            [ 4]  397 	or	a, a
   037A 20 04         [12]  398 	jr	NZ,00119$
                            399 ;src/Map.c:106: surroundedByWalls = 0;
   037C DD 36 F4 00   [19]  400 	ld	-12 (ix),#0x00
   0380                     401 00119$:
                            402 ;src/Map.c:111: adjacentType = map[currentPos.x][currentPos.y-1];
   0380 DD 6E F6      [19]  403 	ld	l,-10 (ix)
   0383 DD 66 F7      [19]  404 	ld	h,-9 (ix)
   0386 29            [11]  405 	add	hl, hl
   0387 29            [11]  406 	add	hl, hl
   0388 29            [11]  407 	add	hl, hl
   0389 29            [11]  408 	add	hl, hl
   038A 29            [11]  409 	add	hl, hl
   038B 7D            [ 4]  410 	ld	a,l
   038C C6 00         [ 7]  411 	add	a, #0x00
   038E DD 77 F6      [19]  412 	ld	-10 (ix),a
   0391 7C            [ 4]  413 	ld	a,h
   0392 CE 70         [ 7]  414 	adc	a, #0x70
   0394 DD 77 F7      [19]  415 	ld	-9 (ix),a
                            416 ;src/Map.c:109: if(currentPos.y > 0){
   0397 DD 7E F9      [19]  417 	ld	a,-7 (ix)
   039A B7            [ 4]  418 	or	a, a
   039B 28 23         [12]  419 	jr	Z,00126$
                            420 ;src/Map.c:111: adjacentType = map[currentPos.x][currentPos.y-1];
   039D DD 6E F9      [19]  421 	ld	l,-7 (ix)
   03A0 2D            [ 4]  422 	dec	l
   03A1 DD 7E F6      [19]  423 	ld	a,-10 (ix)
   03A4 85            [ 4]  424 	add	a, l
   03A5 6F            [ 4]  425 	ld	l,a
   03A6 DD 7E F7      [19]  426 	ld	a,-9 (ix)
   03A9 CE 00         [ 7]  427 	adc	a, #0x00
   03AB 67            [ 4]  428 	ld	h,a
   03AC 6E            [ 7]  429 	ld	l,(hl)
                            430 ;src/Map.c:112: if(adjacentType == CELLTYPE_UNDEFINED){
   03AD 7D            [ 4]  431 	ld	a,l
   03AE D6 87         [ 7]  432 	sub	a, #0x87
   03B0 20 06         [12]  433 	jr	NZ,00123$
                            434 ;src/Map.c:113: convertToFloor  = 1;
   03B2 DD 36 F5 01   [19]  435 	ld	-11 (ix),#0x01
   03B6 18 08         [12]  436 	jr	00126$
   03B8                     437 00123$:
                            438 ;src/Map.c:115: else if(adjacentType == CELLTYPE_FLOOR){
   03B8 7D            [ 4]  439 	ld	a,l
   03B9 B7            [ 4]  440 	or	a, a
   03BA 20 04         [12]  441 	jr	NZ,00126$
                            442 ;src/Map.c:116: surroundedByWalls = 0;
   03BC DD 36 F4 00   [19]  443 	ld	-12 (ix),#0x00
   03C0                     444 00126$:
                            445 ;src/Map.c:119: if(currentPos.y < (MAP_HEIGHT-1)){
   03C0 DD 7E F9      [19]  446 	ld	a,-7 (ix)
   03C3 D6 1F         [ 7]  447 	sub	a, #0x1F
   03C5 30 23         [12]  448 	jr	NC,00133$
                            449 ;src/Map.c:121: adjacentType = map[currentPos.x][currentPos.y+1];
   03C7 DD 6E F9      [19]  450 	ld	l,-7 (ix)
   03CA 2C            [ 4]  451 	inc	l
   03CB DD 7E F6      [19]  452 	ld	a,-10 (ix)
   03CE 85            [ 4]  453 	add	a, l
   03CF 6F            [ 4]  454 	ld	l,a
   03D0 DD 7E F7      [19]  455 	ld	a,-9 (ix)
   03D3 CE 00         [ 7]  456 	adc	a, #0x00
   03D5 67            [ 4]  457 	ld	h,a
   03D6 6E            [ 7]  458 	ld	l,(hl)
                            459 ;src/Map.c:122: if(adjacentType == CELLTYPE_UNDEFINED){
   03D7 7D            [ 4]  460 	ld	a,l
   03D8 D6 87         [ 7]  461 	sub	a, #0x87
   03DA 20 06         [12]  462 	jr	NZ,00130$
                            463 ;src/Map.c:123: convertToFloor  = 1;
   03DC DD 36 F5 01   [19]  464 	ld	-11 (ix),#0x01
   03E0 18 08         [12]  465 	jr	00133$
   03E2                     466 00130$:
                            467 ;src/Map.c:125: else if(adjacentType == CELLTYPE_FLOOR){
   03E2 7D            [ 4]  468 	ld	a,l
   03E3 B7            [ 4]  469 	or	a, a
   03E4 20 04         [12]  470 	jr	NZ,00133$
                            471 ;src/Map.c:126: surroundedByWalls = 0;
   03E6 DD 36 F4 00   [19]  472 	ld	-12 (ix),#0x00
   03EA                     473 00133$:
                            474 ;src/Map.c:130: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   03EA 69            [ 4]  475 	ld	l, c
   03EB 60            [ 4]  476 	ld	h, b
   03EC 29            [11]  477 	add	hl, hl
   03ED FD 21 00 78   [14]  478 	ld	iy,#0x7800
   03F1 C5            [11]  479 	push	bc
   03F2 4D            [ 4]  480 	ld	c, l
   03F3 44            [ 4]  481 	ld	b, h
   03F4 FD 09         [15]  482 	add	iy, bc
   03F6 C1            [10]  483 	pop	bc
   03F7 FD 7E 00      [19]  484 	ld	a, 0 (iy)
   03FA DD 6E FC      [19]  485 	ld	l,-4 (ix)
   03FD DD 66 FD      [19]  486 	ld	h,-3 (ix)
   0400 77            [ 7]  487 	ld	(hl),a
                            488 ;src/Map.c:131: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   0401 FD E5         [15]  489 	push	iy
   0403 E1            [10]  490 	pop	hl
   0404 23            [ 6]  491 	inc	hl
   0405 7E            [ 7]  492 	ld	a,(hl)
   0406 12            [ 7]  493 	ld	(de),a
                            494 ;src/Map.c:132: --wallListCount;
   0407 0B            [ 6]  495 	dec	bc
   0408 DD 71 EE      [19]  496 	ld	-18 (ix),c
   040B DD 70 EF      [19]  497 	ld	-17 (ix),b
                            498 ;src/Map.c:135: if((convertToFloor)&&(!surroundedByWalls)){
   040E DD 7E F5      [19]  499 	ld	a,-11 (ix)
   0411 B7            [ 4]  500 	or	a, a
   0412 28 49         [12]  501 	jr	Z,00135$
   0414 DD 7E F4      [19]  502 	ld	a,-12 (ix)
   0417 B7            [ 4]  503 	or	a, a
   0418 20 43         [12]  504 	jr	NZ,00135$
                            505 ;src/Map.c:136: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   041A DD 6E FA      [19]  506 	ld	l,-6 (ix)
   041D DD 66 FB      [19]  507 	ld	h,-5 (ix)
   0420 6E            [ 7]  508 	ld	l,(hl)
   0421 26 00         [ 7]  509 	ld	h,#0x00
   0423 29            [11]  510 	add	hl, hl
   0424 29            [11]  511 	add	hl, hl
   0425 29            [11]  512 	add	hl, hl
   0426 29            [11]  513 	add	hl, hl
   0427 29            [11]  514 	add	hl, hl
   0428 01 00 70      [10]  515 	ld	bc,#0x7000
   042B 09            [11]  516 	add	hl,bc
   042C 4D            [ 4]  517 	ld	c,l
   042D 44            [ 4]  518 	ld	b,h
   042E DD 6E FE      [19]  519 	ld	l,-2 (ix)
   0431 DD 66 FF      [19]  520 	ld	h,-1 (ix)
   0434 6E            [ 7]  521 	ld	l, (hl)
   0435 26 00         [ 7]  522 	ld	h,#0x00
   0437 09            [11]  523 	add	hl,bc
   0438 36 00         [10]  524 	ld	(hl),#0x00
                            525 ;src/Map.c:138: ++lastStackItem;
   043A DD 34 EC      [23]  526 	inc	-20 (ix)
   043D 20 03         [12]  527 	jr	NZ,00334$
   043F DD 34 ED      [23]  528 	inc	-19 (ix)
   0442                     529 00334$:
                            530 ;src/Map.c:139: (*(cellStack+lastStackItem)).x = currentPos.x;
   0442 E1            [10]  531 	pop	hl
   0443 E5            [11]  532 	push	hl
   0444 29            [11]  533 	add	hl, hl
   0445 4D            [ 4]  534 	ld	c, l
   0446 7C            [ 4]  535 	ld	a,h
   0447 C6 74         [ 7]  536 	add	a,#0x74
   0449 47            [ 4]  537 	ld	b,a
   044A DD 6E FA      [19]  538 	ld	l,-6 (ix)
   044D DD 66 FB      [19]  539 	ld	h,-5 (ix)
   0450 7E            [ 7]  540 	ld	a,(hl)
   0451 02            [ 7]  541 	ld	(bc),a
                            542 ;src/Map.c:140: (*(cellStack+lastStackItem)).y = currentPos.y;
   0452 03            [ 6]  543 	inc	bc
   0453 DD 6E FE      [19]  544 	ld	l,-2 (ix)
   0456 DD 66 FF      [19]  545 	ld	h,-1 (ix)
   0459 7E            [ 7]  546 	ld	a,(hl)
   045A 02            [ 7]  547 	ld	(bc),a
                            548 ;src/Map.c:143: break;
   045B 18 11         [12]  549 	jr	00209$
   045D                     550 00135$:
                            551 ;src/Map.c:145: --wallListPosition;
   045D DD 6E FC      [19]  552 	ld	l,-4 (ix)
   0460 DD 66 FD      [19]  553 	ld	h,-3 (ix)
   0463 2B            [ 6]  554 	dec	hl
   0464 2B            [ 6]  555 	dec	hl
   0465 DD 75 FC      [19]  556 	ld	-4 (ix),l
   0468 DD 74 FD      [19]  557 	ld	-3 (ix),h
   046B C3 BD 02      [10]  558 	jp	00137$
                            559 ;src/Map.c:147: while(lastStackItem<MAP_SIZE){
   046E                     560 00209$:
   046E DD 7E F2      [19]  561 	ld	a,-14 (ix)
   0471 DD 77 F6      [19]  562 	ld	-10 (ix),a
   0474 DD 7E F3      [19]  563 	ld	a,-13 (ix)
   0477 DD 77 F7      [19]  564 	ld	-9 (ix),a
   047A DD 7E EE      [19]  565 	ld	a,-18 (ix)
   047D DD 77 FC      [19]  566 	ld	-4 (ix),a
   0480 DD 7E EF      [19]  567 	ld	a,-17 (ix)
   0483 DD 77 FD      [19]  568 	ld	-3 (ix),a
   0486                     569 00164$:
   0486 DD 7E ED      [19]  570 	ld	a,-19 (ix)
   0489 D6 04         [ 7]  571 	sub	a, #0x04
   048B D2 9F 02      [10]  572 	jp	NC,00167$
                            573 ;src/Map.c:148: currentPos.x=(*(lastStackItem+cellStack)).x;
   048E 21 04 00      [10]  574 	ld	hl,#0x0004
   0491 39            [11]  575 	add	hl,sp
   0492 4D            [ 4]  576 	ld	c,l
   0493 44            [ 4]  577 	ld	b,h
   0494 E1            [10]  578 	pop	hl
   0495 E5            [11]  579 	push	hl
   0496 29            [11]  580 	add	hl, hl
   0497 FD 21 00 74   [14]  581 	ld	iy,#0x7400
   049B EB            [ 4]  582 	ex	de,hl
   049C FD 19         [15]  583 	add	iy, de
   049E FD 7E 00      [19]  584 	ld	a, 0 (iy)
   04A1 02            [ 7]  585 	ld	(bc),a
                            586 ;src/Map.c:149: currentPos.y=(*(lastStackItem+cellStack)).y;
   04A2 FD 4E 01      [19]  587 	ld	c,1 (iy)
   04A5 DD 6E FE      [19]  588 	ld	l,-2 (ix)
   04A8 DD 66 FF      [19]  589 	ld	h,-1 (ix)
   04AB 71            [ 7]  590 	ld	(hl),c
                            591 ;src/Map.c:150: --lastStackItem;
   04AC E1            [10]  592 	pop	hl
   04AD E5            [11]  593 	push	hl
   04AE 2B            [ 6]  594 	dec	hl
   04AF E3            [19]  595 	ex	(sp), hl
                            596 ;src/Map.c:151: cellType = map[currentPos.x][currentPos.y];
   04B0 DD 6E FA      [19]  597 	ld	l,-6 (ix)
   04B3 DD 66 FB      [19]  598 	ld	h,-5 (ix)
   04B6 6E            [ 7]  599 	ld	l,(hl)
   04B7 26 00         [ 7]  600 	ld	h,#0x00
   04B9 29            [11]  601 	add	hl, hl
   04BA 29            [11]  602 	add	hl, hl
   04BB 29            [11]  603 	add	hl, hl
   04BC 29            [11]  604 	add	hl, hl
   04BD 29            [11]  605 	add	hl, hl
   04BE 11 00 70      [10]  606 	ld	de,#0x7000
   04C1 19            [11]  607 	add	hl,de
   04C2 59            [ 4]  608 	ld	e,c
   04C3 16 00         [ 7]  609 	ld	d,#0x00
   04C5 19            [11]  610 	add	hl,de
   04C6 4E            [ 7]  611 	ld	c,(hl)
                            612 ;src/Map.c:153: if(cellType == CELLTYPE_UNDEFINED){
   04C7 79            [ 4]  613 	ld	a,c
   04C8 D6 87         [ 7]  614 	sub	a, #0x87
   04CA 20 47         [12]  615 	jr	NZ,00144$
                            616 ;src/Map.c:155: if(cpct_getRandom_mxor_u8 ()&1){//WALL
   04CC CD 20 4D      [17]  617 	call	_cpct_getRandom_mxor_u8
   04CF CB 45         [ 8]  618 	bit	0, l
   04D1 28 06         [12]  619 	jr	Z,00141$
                            620 ;src/Map.c:156: cellType = get_random_wall();
   04D3 CD A0 01      [17]  621 	call	_get_random_wall
   04D6 4D            [ 4]  622 	ld	c,l
   04D7 18 02         [12]  623 	jr	00142$
   04D9                     624 00141$:
                            625 ;src/Map.c:159: cellType = CELLTYPE_FLOOR;
   04D9 0E 00         [ 7]  626 	ld	c,#0x00
   04DB                     627 00142$:
                            628 ;src/Map.c:161: map[currentPos.x][currentPos.y]=cellType;
   04DB DD 6E FA      [19]  629 	ld	l,-6 (ix)
   04DE DD 66 FB      [19]  630 	ld	h,-5 (ix)
   04E1 6E            [ 7]  631 	ld	l,(hl)
   04E2 26 00         [ 7]  632 	ld	h,#0x00
   04E4 29            [11]  633 	add	hl, hl
   04E5 29            [11]  634 	add	hl, hl
   04E6 29            [11]  635 	add	hl, hl
   04E7 29            [11]  636 	add	hl, hl
   04E8 29            [11]  637 	add	hl, hl
   04E9 EB            [ 4]  638 	ex	de,hl
   04EA 21 00 70      [10]  639 	ld	hl,#0x7000
   04ED 19            [11]  640 	add	hl,de
   04EE EB            [ 4]  641 	ex	de,hl
   04EF DD 6E FE      [19]  642 	ld	l,-2 (ix)
   04F2 DD 66 FF      [19]  643 	ld	h,-1 (ix)
   04F5 6E            [ 7]  644 	ld	l, (hl)
   04F6 26 00         [ 7]  645 	ld	h,#0x00
   04F8 19            [11]  646 	add	hl,de
   04F9 71            [ 7]  647 	ld	(hl),c
                            648 ;src/Map.c:162: --remainingCells;
   04FA DD 6E F6      [19]  649 	ld	l,-10 (ix)
   04FD DD 66 F7      [19]  650 	ld	h,-9 (ix)
   0500 2B            [ 6]  651 	dec	hl
   0501 DD 75 F6      [19]  652 	ld	-10 (ix),l
   0504 DD 74 F7      [19]  653 	ld	-9 (ix),h
   0507 DD 7E F6      [19]  654 	ld	a,-10 (ix)
   050A DD 77 F2      [19]  655 	ld	-14 (ix),a
   050D DD 7E F7      [19]  656 	ld	a,-9 (ix)
   0510 DD 77 F3      [19]  657 	ld	-13 (ix),a
   0513                     658 00144$:
                            659 ;src/Map.c:90: if(currentPos.x>0){
   0513 DD 6E FA      [19]  660 	ld	l,-6 (ix)
   0516 DD 66 FB      [19]  661 	ld	h,-5 (ix)
   0519 7E            [ 7]  662 	ld	a,(hl)
   051A DD 77 F9      [19]  663 	ld	-7 (ix),a
                            664 ;src/Map.c:165: if((cellType == CELLTYPE_FLOOR)){
   051D 79            [ 4]  665 	ld	a,c
   051E B7            [ 4]  666 	or	a, a
   051F C2 3C 06      [10]  667 	jp	NZ,00162$
                            668 ;src/Map.c:166: if(currentPos.x>0){
   0522 DD 7E F9      [19]  669 	ld	a,-7 (ix)
   0525 B7            [ 4]  670 	or	a, a
   0526 28 3F         [12]  671 	jr	Z,00148$
                            672 ;src/Map.c:167: adjacentType = map[currentPos.x-1][currentPos.y];
   0528 DD 6E F9      [19]  673 	ld	l,-7 (ix)
   052B 26 00         [ 7]  674 	ld	h,#0x00
   052D 2B            [ 6]  675 	dec	hl
   052E 29            [11]  676 	add	hl, hl
   052F 29            [11]  677 	add	hl, hl
   0530 29            [11]  678 	add	hl, hl
   0531 29            [11]  679 	add	hl, hl
   0532 29            [11]  680 	add	hl, hl
   0533 01 00 70      [10]  681 	ld	bc,#0x7000
   0536 09            [11]  682 	add	hl,bc
   0537 4D            [ 4]  683 	ld	c,l
   0538 44            [ 4]  684 	ld	b,h
   0539 DD 6E FE      [19]  685 	ld	l,-2 (ix)
   053C DD 66 FF      [19]  686 	ld	h,-1 (ix)
   053F 6E            [ 7]  687 	ld	l, (hl)
   0540 26 00         [ 7]  688 	ld	h,#0x00
   0542 09            [11]  689 	add	hl,bc
   0543 7E            [ 7]  690 	ld	a,(hl)
                            691 ;src/Map.c:168: if(adjacentType == CELLTYPE_UNDEFINED){
   0544 D6 87         [ 7]  692 	sub	a, #0x87
   0546 20 1F         [12]  693 	jr	NZ,00148$
                            694 ;src/Map.c:170: ++lastStackItem;
   0548 DD 34 EC      [23]  695 	inc	-20 (ix)
   054B 20 03         [12]  696 	jr	NZ,00340$
   054D DD 34 ED      [23]  697 	inc	-19 (ix)
   0550                     698 00340$:
                            699 ;src/Map.c:171: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   0550 E1            [10]  700 	pop	hl
   0551 E5            [11]  701 	push	hl
   0552 29            [11]  702 	add	hl, hl
   0553 01 00 74      [10]  703 	ld	bc,#0x7400
   0556 09            [11]  704 	add	hl,bc
   0557 DD 4E F9      [19]  705 	ld	c,-7 (ix)
   055A 0D            [ 4]  706 	dec	c
   055B 71            [ 7]  707 	ld	(hl),c
                            708 ;src/Map.c:172: (*(cellStack+lastStackItem)).y = currentPos.y;
   055C 23            [ 6]  709 	inc	hl
   055D 4D            [ 4]  710 	ld	c,l
   055E 44            [ 4]  711 	ld	b,h
   055F DD 6E FE      [19]  712 	ld	l,-2 (ix)
   0562 DD 66 FF      [19]  713 	ld	h,-1 (ix)
   0565 7E            [ 7]  714 	ld	a,(hl)
   0566 02            [ 7]  715 	ld	(bc),a
   0567                     716 00148$:
                            717 ;src/Map.c:176: if(currentPos.x < (MAP_WIDTH-1)){
   0567 DD 6E FA      [19]  718 	ld	l,-6 (ix)
   056A DD 66 FB      [19]  719 	ld	h,-5 (ix)
   056D 4E            [ 7]  720 	ld	c,(hl)
   056E 79            [ 4]  721 	ld	a,c
   056F D6 1F         [ 7]  722 	sub	a, #0x1F
   0571 30 3A         [12]  723 	jr	NC,00152$
                            724 ;src/Map.c:178: adjacentType = map[currentPos.x+1][currentPos.y];
   0573 69            [ 4]  725 	ld	l,c
   0574 26 00         [ 7]  726 	ld	h,#0x00
   0576 23            [ 6]  727 	inc	hl
   0577 29            [11]  728 	add	hl, hl
   0578 29            [11]  729 	add	hl, hl
   0579 29            [11]  730 	add	hl, hl
   057A 29            [11]  731 	add	hl, hl
   057B 29            [11]  732 	add	hl, hl
   057C EB            [ 4]  733 	ex	de,hl
   057D 21 00 70      [10]  734 	ld	hl,#0x7000
   0580 19            [11]  735 	add	hl,de
   0581 EB            [ 4]  736 	ex	de,hl
   0582 DD 6E FE      [19]  737 	ld	l,-2 (ix)
   0585 DD 66 FF      [19]  738 	ld	h,-1 (ix)
   0588 6E            [ 7]  739 	ld	l, (hl)
   0589 26 00         [ 7]  740 	ld	h,#0x00
   058B 19            [11]  741 	add	hl,de
   058C 7E            [ 7]  742 	ld	a,(hl)
                            743 ;src/Map.c:179: if(adjacentType == CELLTYPE_UNDEFINED){
   058D D6 87         [ 7]  744 	sub	a, #0x87
   058F 20 1C         [12]  745 	jr	NZ,00152$
                            746 ;src/Map.c:182: ++lastStackItem;
   0591 DD 34 EC      [23]  747 	inc	-20 (ix)
   0594 20 03         [12]  748 	jr	NZ,00343$
   0596 DD 34 ED      [23]  749 	inc	-19 (ix)
   0599                     750 00343$:
                            751 ;src/Map.c:183: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   0599 E1            [10]  752 	pop	hl
   059A E5            [11]  753 	push	hl
   059B 29            [11]  754 	add	hl, hl
   059C 11 00 74      [10]  755 	ld	de,#0x7400
   059F 19            [11]  756 	add	hl,de
   05A0 0C            [ 4]  757 	inc	c
   05A1 71            [ 7]  758 	ld	(hl),c
                            759 ;src/Map.c:184: (*(cellStack+lastStackItem)).y = currentPos.y;
   05A2 23            [ 6]  760 	inc	hl
   05A3 4D            [ 4]  761 	ld	c,l
   05A4 44            [ 4]  762 	ld	b,h
   05A5 DD 6E FE      [19]  763 	ld	l,-2 (ix)
   05A8 DD 66 FF      [19]  764 	ld	h,-1 (ix)
   05AB 7E            [ 7]  765 	ld	a,(hl)
   05AC 02            [ 7]  766 	ld	(bc),a
   05AD                     767 00152$:
                            768 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   05AD DD 6E FE      [19]  769 	ld	l,-2 (ix)
   05B0 DD 66 FF      [19]  770 	ld	h,-1 (ix)
   05B3 4E            [ 7]  771 	ld	c,(hl)
                            772 ;src/Map.c:188: if(currentPos.y > 0){
   05B4 79            [ 4]  773 	ld	a,c
   05B5 B7            [ 4]  774 	or	a, a
   05B6 28 3A         [12]  775 	jr	Z,00156$
                            776 ;src/Map.c:190: adjacentType = map[currentPos.x][currentPos.y-1];
   05B8 DD 6E FA      [19]  777 	ld	l,-6 (ix)
   05BB DD 66 FB      [19]  778 	ld	h,-5 (ix)
   05BE 46            [ 7]  779 	ld	b,(hl)
   05BF 68            [ 4]  780 	ld	l,b
   05C0 26 00         [ 7]  781 	ld	h,#0x00
   05C2 29            [11]  782 	add	hl, hl
   05C3 29            [11]  783 	add	hl, hl
   05C4 29            [11]  784 	add	hl, hl
   05C5 29            [11]  785 	add	hl, hl
   05C6 29            [11]  786 	add	hl, hl
   05C7 11 00 70      [10]  787 	ld	de,#0x7000
   05CA 19            [11]  788 	add	hl,de
   05CB 0D            [ 4]  789 	dec	c
   05CC 59            [ 4]  790 	ld	e,c
   05CD 16 00         [ 7]  791 	ld	d,#0x00
   05CF 19            [11]  792 	add	hl,de
   05D0 7E            [ 7]  793 	ld	a,(hl)
                            794 ;src/Map.c:191: if(adjacentType == CELLTYPE_UNDEFINED){
   05D1 D6 87         [ 7]  795 	sub	a, #0x87
   05D3 20 1D         [12]  796 	jr	NZ,00156$
                            797 ;src/Map.c:194: ++lastStackItem;
   05D5 DD 34 EC      [23]  798 	inc	-20 (ix)
   05D8 20 03         [12]  799 	jr	NZ,00346$
   05DA DD 34 ED      [23]  800 	inc	-19 (ix)
   05DD                     801 00346$:
                            802 ;src/Map.c:195: (*(cellStack+lastStackItem)).x = currentPos.x;
   05DD E1            [10]  803 	pop	hl
   05DE E5            [11]  804 	push	hl
   05DF 29            [11]  805 	add	hl, hl
   05E0 11 00 74      [10]  806 	ld	de,#0x7400
   05E3 19            [11]  807 	add	hl,de
   05E4 70            [ 7]  808 	ld	(hl),b
                            809 ;src/Map.c:196: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   05E5 23            [ 6]  810 	inc	hl
   05E6 4D            [ 4]  811 	ld	c,l
   05E7 44            [ 4]  812 	ld	b,h
   05E8 DD 6E FE      [19]  813 	ld	l,-2 (ix)
   05EB DD 66 FF      [19]  814 	ld	h,-1 (ix)
   05EE 5E            [ 7]  815 	ld	e,(hl)
   05EF 1D            [ 4]  816 	dec	e
   05F0 7B            [ 4]  817 	ld	a,e
   05F1 02            [ 7]  818 	ld	(bc),a
   05F2                     819 00156$:
                            820 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   05F2 DD 6E FE      [19]  821 	ld	l,-2 (ix)
   05F5 DD 66 FF      [19]  822 	ld	h,-1 (ix)
   05F8 46            [ 7]  823 	ld	b,(hl)
                            824 ;src/Map.c:200: if(currentPos.y < (MAP_HEIGHT-1)){
   05F9 78            [ 4]  825 	ld	a,b
   05FA D6 1F         [ 7]  826 	sub	a, #0x1F
   05FC D2 86 04      [10]  827 	jp	NC,00164$
                            828 ;src/Map.c:202: adjacentType = map[currentPos.x][currentPos.y+1];
   05FF DD 6E FA      [19]  829 	ld	l,-6 (ix)
   0602 DD 66 FB      [19]  830 	ld	h,-5 (ix)
   0605 4E            [ 7]  831 	ld	c,(hl)
   0606 69            [ 4]  832 	ld	l,c
   0607 26 00         [ 7]  833 	ld	h,#0x00
   0609 29            [11]  834 	add	hl, hl
   060A 29            [11]  835 	add	hl, hl
   060B 29            [11]  836 	add	hl, hl
   060C 29            [11]  837 	add	hl, hl
   060D 29            [11]  838 	add	hl, hl
   060E 11 00 70      [10]  839 	ld	de,#0x7000
   0611 19            [11]  840 	add	hl,de
   0612 04            [ 4]  841 	inc	b
   0613 58            [ 4]  842 	ld	e,b
   0614 16 00         [ 7]  843 	ld	d,#0x00
   0616 19            [11]  844 	add	hl,de
   0617 7E            [ 7]  845 	ld	a,(hl)
                            846 ;src/Map.c:203: if(adjacentType == CELLTYPE_UNDEFINED){
   0618 D6 87         [ 7]  847 	sub	a, #0x87
   061A C2 86 04      [10]  848 	jp	NZ,00164$
                            849 ;src/Map.c:206: ++lastStackItem;
   061D DD 34 EC      [23]  850 	inc	-20 (ix)
   0620 20 03         [12]  851 	jr	NZ,00349$
   0622 DD 34 ED      [23]  852 	inc	-19 (ix)
   0625                     853 00349$:
                            854 ;src/Map.c:207: (*(cellStack+lastStackItem)).x = currentPos.x;
   0625 E1            [10]  855 	pop	hl
   0626 E5            [11]  856 	push	hl
   0627 29            [11]  857 	add	hl, hl
   0628 11 00 74      [10]  858 	ld	de,#0x7400
   062B 19            [11]  859 	add	hl,de
   062C 71            [ 7]  860 	ld	(hl),c
                            861 ;src/Map.c:208: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   062D 23            [ 6]  862 	inc	hl
   062E 4D            [ 4]  863 	ld	c,l
   062F 44            [ 4]  864 	ld	b,h
   0630 DD 6E FE      [19]  865 	ld	l,-2 (ix)
   0633 DD 66 FF      [19]  866 	ld	h,-1 (ix)
   0636 7E            [ 7]  867 	ld	a,(hl)
   0637 3C            [ 4]  868 	inc	a
   0638 02            [ 7]  869 	ld	(bc),a
   0639 C3 86 04      [10]  870 	jp	00164$
   063C                     871 00162$:
                            872 ;src/Map.c:214: ++wallListCount;
   063C DD 34 FC      [23]  873 	inc	-4 (ix)
   063F 20 03         [12]  874 	jr	NZ,00350$
   0641 DD 34 FD      [23]  875 	inc	-3 (ix)
   0644                     876 00350$:
   0644 DD 7E FC      [19]  877 	ld	a,-4 (ix)
   0647 DD 77 EE      [19]  878 	ld	-18 (ix),a
   064A DD 7E FD      [19]  879 	ld	a,-3 (ix)
   064D DD 77 EF      [19]  880 	ld	-17 (ix),a
                            881 ;src/Map.c:215: (*(wallList+wallListCount)).x = currentPos.x;
   0650 DD 6E FC      [19]  882 	ld	l,-4 (ix)
   0653 DD 66 FD      [19]  883 	ld	h,-3 (ix)
   0656 29            [11]  884 	add	hl, hl
   0657 01 00 78      [10]  885 	ld	bc,#0x7800
   065A 09            [11]  886 	add	hl,bc
   065B DD 7E F9      [19]  887 	ld	a,-7 (ix)
   065E 77            [ 7]  888 	ld	(hl),a
                            889 ;src/Map.c:216: (*(wallList+wallListCount)).y = currentPos.y;
   065F 23            [ 6]  890 	inc	hl
   0660 4D            [ 4]  891 	ld	c,l
   0661 44            [ 4]  892 	ld	b,h
   0662 DD 6E FE      [19]  893 	ld	l,-2 (ix)
   0665 DD 66 FF      [19]  894 	ld	h,-1 (ix)
   0668 7E            [ 7]  895 	ld	a,(hl)
   0669 02            [ 7]  896 	ld	(bc),a
   066A C3 86 04      [10]  897 	jp	00164$
   066D                     898 00174$:
   066D DD F9         [10]  899 	ld	sp, ix
   066F DD E1         [14]  900 	pop	ix
   0671 C9            [10]  901 	ret
                            902 ;src/Map.c:222: void generate_exit_door(){
                            903 ;	---------------------------------
                            904 ; Function generate_exit_door
                            905 ; ---------------------------------
   0672                     906 _generate_exit_door::
   0672 DD E5         [15]  907 	push	ix
   0674 DD 21 00 00   [14]  908 	ld	ix,#0
   0678 DD 39         [15]  909 	add	ix,sp
   067A 21 F2 FF      [10]  910 	ld	hl,#-14
   067D 39            [11]  911 	add	hl,sp
   067E F9            [ 6]  912 	ld	sp,hl
                            913 ;src/Map.c:223: u8 x=(cpct_getRandom_mxor_u8 ()%32);
   067F CD 20 4D      [17]  914 	call	_cpct_getRandom_mxor_u8
   0682 7D            [ 4]  915 	ld	a,l
   0683 E6 1F         [ 7]  916 	and	a, #0x1F
   0685 4F            [ 4]  917 	ld	c,a
                            918 ;src/Map.c:224: u8 y=(cpct_getRandom_mxor_u8 ()%32);
   0686 C5            [11]  919 	push	bc
   0687 CD 20 4D      [17]  920 	call	_cpct_getRandom_mxor_u8
   068A C1            [10]  921 	pop	bc
   068B 7D            [ 4]  922 	ld	a,l
   068C E6 1F         [ 7]  923 	and	a, #0x1F
   068E 5F            [ 4]  924 	ld	e,a
                            925 ;src/Map.c:225: u8 door_not_positioned=1;
   068F DD 36 F6 01   [19]  926 	ld	-10 (ix),#0x01
                            927 ;src/Map.c:232: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
   0693 06 00         [ 7]  928 	ld	b,#0x00
   0695 21 00 70      [10]  929 	ld	hl,#0x7000
   0698 09            [11]  930 	add	hl,bc
   0699 4D            [ 4]  931 	ld	c,l
   069A 44            [ 4]  932 	ld	b,h
   069B 6B            [ 4]  933 	ld	l,e
   069C 26 00         [ 7]  934 	ld	h,#0x00
   069E 29            [11]  935 	add	hl, hl
   069F 29            [11]  936 	add	hl, hl
   06A0 29            [11]  937 	add	hl, hl
   06A1 29            [11]  938 	add	hl, hl
   06A2 29            [11]  939 	add	hl, hl
   06A3 09            [11]  940 	add	hl,bc
   06A4 4D            [ 4]  941 	ld	c,l
   06A5 44            [ 4]  942 	ld	b,h
                            943 ;src/Map.c:237: lastVal = (position-1);
   06A6 59            [ 4]  944 	ld	e,c
   06A7 50            [ 4]  945 	ld	d,b
   06A8 1B            [ 6]  946 	dec	de
                            947 ;src/Map.c:238: nextVal = (position+1);
   06A9 21 01 00      [10]  948 	ld	hl,#0x0001
   06AC 09            [11]  949 	add	hl,bc
   06AD DD 75 F4      [19]  950 	ld	-12 (ix),l
   06B0 DD 74 F5      [19]  951 	ld	-11 (ix),h
                            952 ;src/Map.c:239: topVal = (position-MAP_WIDTH);
   06B3 79            [ 4]  953 	ld	a,c
   06B4 C6 E0         [ 7]  954 	add	a,#0xE0
   06B6 DD 77 F2      [19]  955 	ld	-14 (ix),a
   06B9 78            [ 4]  956 	ld	a,b
   06BA CE FF         [ 7]  957 	adc	a,#0xFF
   06BC DD 77 F3      [19]  958 	ld	-13 (ix),a
                            959 ;src/Map.c:240: bottomVal = (position+MAP_WIDTH);
   06BF FD 21 20 00   [14]  960 	ld	iy,#0x0020
   06C3 FD 09         [15]  961 	add	iy, bc
                            962 ;src/Map.c:242: while(door_not_positioned){
   06C5                     963 00138$:
   06C5 DD 7E F6      [19]  964 	ld	a,-10 (ix)
   06C8 B7            [ 4]  965 	or	a, a
   06C9 CA 19 08      [10]  966 	jp	Z,00141$
                            967 ;src/Map.c:243: if((*position)!=CELLTYPE_FLOOR){
   06CC 0A            [ 7]  968 	ld	a,(bc)
   06CD B7            [ 4]  969 	or	a, a
   06CE CA DF 07      [10]  970 	jp	Z,00135$
                            971 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   06D1 1A            [ 7]  972 	ld	a,(de)
   06D2 DD 77 FA      [19]  973 	ld	-6 (ix),a
   06D5 DD 73 F7      [19]  974 	ld	-9 (ix),e
   06D8 DD 72 F8      [19]  975 	ld	-8 (ix),d
   06DB DD 7E F4      [19]  976 	ld	a,-12 (ix)
   06DE DD 77 FE      [19]  977 	ld	-2 (ix),a
   06E1 DD 7E F5      [19]  978 	ld	a,-11 (ix)
   06E4 DD 77 FF      [19]  979 	ld	-1 (ix),a
                            980 ;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   06E7 E1            [10]  981 	pop	hl
   06E8 E5            [11]  982 	push	hl
   06E9 7E            [ 7]  983 	ld	a,(hl)
   06EA DD 77 FD      [19]  984 	ld	-3 (ix),a
   06ED DD 7E F2      [19]  985 	ld	a,-14 (ix)
   06F0 DD 77 FB      [19]  986 	ld	-5 (ix),a
   06F3 DD 7E F3      [19]  987 	ld	a,-13 (ix)
   06F6 DD 77 FC      [19]  988 	ld	-4 (ix),a
   06F9 FD E5         [15]  989 	push	iy
   06FB E1            [10]  990 	pop	hl
                            991 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   06FC DD 7E F8      [19]  992 	ld	a,-8 (ix)
   06FF D6 70         [ 7]  993 	sub	a, #0x70
   0701 3E 00         [ 7]  994 	ld	a,#0x00
   0703 17            [ 4]  995 	rla
   0704 DD 77 F7      [19]  996 	ld	-9 (ix),a
   0707 DD 7E FF      [19]  997 	ld	a,-1 (ix)
   070A D6 74         [ 7]  998 	sub	a, #0x74
   070C 3E 00         [ 7]  999 	ld	a,#0x00
   070E 17            [ 4] 1000 	rla
   070F DD 77 FE      [19] 1001 	ld	-2 (ix),a
                           1002 ;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   0712 DD 7E FC      [19] 1003 	ld	a,-4 (ix)
   0715 D6 70         [ 7] 1004 	sub	a, #0x70
   0717 3E 00         [ 7] 1005 	ld	a,#0x00
   0719 17            [ 4] 1006 	rla
   071A DD 77 FB      [19] 1007 	ld	-5 (ix),a
   071D 7C            [ 4] 1008 	ld	a,h
   071E D6 74         [ 7] 1009 	sub	a, #0x74
   0720 3E 00         [ 7] 1010 	ld	a,#0x00
   0722 17            [ 4] 1011 	rla
   0723 DD 77 F9      [19] 1012 	ld	-7 (ix),a
                           1013 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   0726 DD 7E FA      [19] 1014 	ld	a,-6 (ix)
   0729 B7            [ 4] 1015 	or	a, a
   072A 20 06         [12] 1016 	jr	NZ,00133$
   072C DD 7E F7      [19] 1017 	ld	a,-9 (ix)
   072F B7            [ 4] 1018 	or	a, a
   0730 28 52         [12] 1019 	jr	Z,00129$
   0732                    1020 00133$:
   0732 DD 6E F4      [19] 1021 	ld	l,-12 (ix)
   0735 DD 66 F5      [19] 1022 	ld	h,-11 (ix)
   0738 7E            [ 7] 1023 	ld	a,(hl)
   0739 B7            [ 4] 1024 	or	a, a
   073A 20 06         [12] 1025 	jr	NZ,00128$
   073C DD CB FE 46   [20] 1026 	bit	0,-2 (ix)
   0740 20 42         [12] 1027 	jr	NZ,00129$
   0742                    1028 00128$:
                           1029 ;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   0742 FD 6E 00      [19] 1030 	ld	l, 0 (iy)
   0745 DD 7E FD      [19] 1031 	ld	a,-3 (ix)
   0748 B7            [ 4] 1032 	or	a, a
   0749 20 06         [12] 1033 	jr	NZ,00111$
   074B DD 7E FB      [19] 1034 	ld	a,-5 (ix)
   074E B7            [ 4] 1035 	or	a, a
   074F 28 14         [12] 1036 	jr	Z,00107$
   0751                    1037 00111$:
   0751 7D            [ 4] 1038 	ld	a,l
   0752 B7            [ 4] 1039 	or	a, a
   0753 20 10         [12] 1040 	jr	NZ,00107$
   0755 DD 7E F9      [19] 1041 	ld	a,-7 (ix)
   0758 B7            [ 4] 1042 	or	a, a
   0759 28 0A         [12] 1043 	jr	Z,00107$
                           1044 ;src/Map.c:246: door_not_positioned=0;
   075B DD 36 F6 00   [19] 1045 	ld	-10 (ix),#0x00
                           1046 ;src/Map.c:247: *position=CELLTYPE_DOOR;
   075F 3E 80         [ 7] 1047 	ld	a,#0x80
   0761 02            [ 7] 1048 	ld	(bc),a
   0762 C3 DF 07      [10] 1049 	jp	00135$
   0765                    1050 00107$:
                           1051 ;src/Map.c:249: else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
   0765 7D            [ 4] 1052 	ld	a,l
   0766 B7            [ 4] 1053 	or	a, a
   0767 20 06         [12] 1054 	jr	NZ,00105$
   0769 DD 7E F9      [19] 1055 	ld	a,-7 (ix)
   076C B7            [ 4] 1056 	or	a, a
   076D 20 70         [12] 1057 	jr	NZ,00135$
   076F                    1058 00105$:
   076F DD 7E FD      [19] 1059 	ld	a,-3 (ix)
   0772 B7            [ 4] 1060 	or	a, a
   0773 20 6A         [12] 1061 	jr	NZ,00135$
   0775 DD 7E FB      [19] 1062 	ld	a,-5 (ix)
   0778 B7            [ 4] 1063 	or	a, a
   0779 20 64         [12] 1064 	jr	NZ,00135$
                           1065 ;src/Map.c:250: door_not_positioned=0;
   077B DD 36 F6 00   [19] 1066 	ld	-10 (ix),#0x00
                           1067 ;src/Map.c:251: *position=CELLTYPE_DOOR;
   077F 3E 80         [ 7] 1068 	ld	a,#0x80
   0781 02            [ 7] 1069 	ld	(bc),a
   0782 18 5B         [12] 1070 	jr	00135$
   0784                    1071 00129$:
                           1072 ;src/Map.c:254: else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
   0784 DD 7E FD      [19] 1073 	ld	a,-3 (ix)
   0787 B7            [ 4] 1074 	or	a, a
   0788 20 06         [12] 1075 	jr	NZ,00127$
   078A DD 7E FB      [19] 1076 	ld	a,-5 (ix)
   078D B7            [ 4] 1077 	or	a, a
   078E 28 4F         [12] 1078 	jr	Z,00135$
   0790                    1079 00127$:
   0790 FD 7E 00      [19] 1080 	ld	a, 0 (iy)
   0793 B7            [ 4] 1081 	or	a, a
   0794 20 06         [12] 1082 	jr	NZ,00123$
   0796 DD 7E F9      [19] 1083 	ld	a,-7 (ix)
   0799 B7            [ 4] 1084 	or	a, a
   079A 20 43         [12] 1085 	jr	NZ,00135$
   079C                    1086 00123$:
                           1087 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   079C DD 6E F4      [19] 1088 	ld	l,-12 (ix)
   079F DD 66 F5      [19] 1089 	ld	h,-11 (ix)
   07A2 6E            [ 7] 1090 	ld	l,(hl)
                           1091 ;src/Map.c:255: if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
   07A3 DD 7E FA      [19] 1092 	ld	a,-6 (ix)
   07A6 B7            [ 4] 1093 	or	a, a
   07A7 20 06         [12] 1094 	jr	NZ,00122$
   07A9 DD 7E F7      [19] 1095 	ld	a,-9 (ix)
   07AC B7            [ 4] 1096 	or	a, a
   07AD 28 13         [12] 1097 	jr	Z,00118$
   07AF                    1098 00122$:
   07AF 7D            [ 4] 1099 	ld	a,l
   07B0 B7            [ 4] 1100 	or	a, a
   07B1 20 0F         [12] 1101 	jr	NZ,00118$
   07B3 DD CB FE 46   [20] 1102 	bit	0,-2 (ix)
   07B7 28 09         [12] 1103 	jr	Z,00118$
                           1104 ;src/Map.c:256: door_not_positioned=0;
   07B9 DD 36 F6 00   [19] 1105 	ld	-10 (ix),#0x00
                           1106 ;src/Map.c:257: *position=CELLTYPE_DOOR;
   07BD 3E 80         [ 7] 1107 	ld	a,#0x80
   07BF 02            [ 7] 1108 	ld	(bc),a
   07C0 18 1D         [12] 1109 	jr	00135$
   07C2                    1110 00118$:
                           1111 ;src/Map.c:259: else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
   07C2 7D            [ 4] 1112 	ld	a,l
   07C3 B7            [ 4] 1113 	or	a, a
   07C4 20 06         [12] 1114 	jr	NZ,00116$
   07C6 DD CB FE 46   [20] 1115 	bit	0,-2 (ix)
   07CA 20 13         [12] 1116 	jr	NZ,00135$
   07CC                    1117 00116$:
   07CC DD 7E FA      [19] 1118 	ld	a,-6 (ix)
   07CF B7            [ 4] 1119 	or	a, a
   07D0 20 0D         [12] 1120 	jr	NZ,00135$
   07D2 DD 7E F7      [19] 1121 	ld	a,-9 (ix)
   07D5 B7            [ 4] 1122 	or	a, a
   07D6 20 07         [12] 1123 	jr	NZ,00135$
                           1124 ;src/Map.c:260: door_not_positioned=0;
   07D8 DD 36 F6 00   [19] 1125 	ld	-10 (ix),#0x00
                           1126 ;src/Map.c:261: *position=CELLTYPE_DOOR;
   07DC 3E 80         [ 7] 1127 	ld	a,#0x80
   07DE 02            [ 7] 1128 	ld	(bc),a
   07DF                    1129 00135$:
                           1130 ;src/Map.c:265: ++position;
   07DF 03            [ 6] 1131 	inc	bc
                           1132 ;src/Map.c:266: ++lastVal;
   07E0 13            [ 6] 1133 	inc	de
                           1134 ;src/Map.c:267: ++nextVal;
   07E1 DD 34 F4      [23] 1135 	inc	-12 (ix)
   07E4 20 03         [12] 1136 	jr	NZ,00223$
   07E6 DD 34 F5      [23] 1137 	inc	-11 (ix)
   07E9                    1138 00223$:
                           1139 ;src/Map.c:268: ++topVal;
   07E9 DD 34 F2      [23] 1140 	inc	-14 (ix)
   07EC 20 03         [12] 1141 	jr	NZ,00224$
   07EE DD 34 F3      [23] 1142 	inc	-13 (ix)
   07F1                    1143 00224$:
                           1144 ;src/Map.c:269: ++bottomVal;
   07F1 FD 23         [10] 1145 	inc	iy
                           1146 ;src/Map.c:270: if(position==END_OF_MAP_MEM){
   07F3 69            [ 4] 1147 	ld	l, c
   07F4 60            [ 4] 1148 	ld	h, b
   07F5 7D            [ 4] 1149 	ld	a,l
   07F6 B7            [ 4] 1150 	or	a, a
   07F7 C2 C5 06      [10] 1151 	jp	NZ,00138$
   07FA 7C            [ 4] 1152 	ld	a,h
   07FB D6 74         [ 7] 1153 	sub	a, #0x74
   07FD C2 C5 06      [10] 1154 	jp	NZ,00138$
                           1155 ;src/Map.c:271: position = MAP_MEM;
   0800 01 00 70      [10] 1156 	ld	bc,#0x7000
                           1157 ;src/Map.c:272: lastVal = (position-1);
   0803 11 FF 6F      [10] 1158 	ld	de,#0x6FFF
                           1159 ;src/Map.c:273: nextVal = (position+1);
   0806 DD 36 F4 01   [19] 1160 	ld	-12 (ix),#0x01
   080A DD 36 F5 70   [19] 1161 	ld	-11 (ix),#0x70
                           1162 ;src/Map.c:274: topVal = (position-MAP_WIDTH);
   080E 21 E0 6F      [10] 1163 	ld	hl,#0x6FE0
   0811 E3            [19] 1164 	ex	(sp), hl
                           1165 ;src/Map.c:275: bottomVal = (position+MAP_WIDTH);
   0812 FD 21 20 70   [14] 1166 	ld	iy,#0x7020
   0816 C3 C5 06      [10] 1167 	jp	00138$
   0819                    1168 00141$:
   0819 DD F9         [10] 1169 	ld	sp, ix
   081B DD E1         [14] 1170 	pop	ix
   081D C9            [10] 1171 	ret
                           1172 ;src/Map.c:281: void generate_level(){
                           1173 ;	---------------------------------
                           1174 ; Function generate_level
                           1175 ; ---------------------------------
   081E                    1176 _generate_level::
                           1177 ;src/Map.c:282: generate_level_with_seed(r_counter);
   081E FD 21 A1 4F   [14] 1178 	ld	iy,#_r_counter
   0822 FD 6E 00      [19] 1179 	ld	l,0 (iy)
   0825 C3 28 08      [10] 1180 	jp  _generate_level_with_seed
                           1181 ;src/Map.c:285: void generate_level_with_seed(u8 seed) __z88dk_fastcall{
                           1182 ;	---------------------------------
                           1183 ; Function generate_level_with_seed
                           1184 ; ---------------------------------
   0828                    1185 _generate_level_with_seed::
   0828 4D            [ 4] 1186 	ld	c,l
                           1187 ;src/Map.c:287: rand_seed=seed;
   0829 21 A4 4F      [10] 1188 	ld	hl,#_rand_seed + 0
   082C 71            [ 7] 1189 	ld	(hl), c
                           1190 ;src/Map.c:290: cpct_setSeed_mxor(((seed+level_get_level())&0xFFFE) + 1);
   082D 06 00         [ 7] 1191 	ld	b,#0x00
   082F C5            [11] 1192 	push	bc
   0830 CD BA 00      [17] 1193 	call	_level_get_level
   0833 C1            [10] 1194 	pop	bc
   0834 26 00         [ 7] 1195 	ld	h,#0x00
   0836 09            [11] 1196 	add	hl,bc
   0837 CB 85         [ 8] 1197 	res	0, l
   0839 23            [ 6] 1198 	inc	hl
   083A 11 00 00      [10] 1199 	ld	de,#0x0000
   083D CD 12 4D      [17] 1200 	call	_cpct_setSeed_mxor
                           1201 ;src/Map.c:291: cpct_restoreState_mxor_u8();
   0840 CD 1A 4D      [17] 1202 	call	_cpct_restoreState_mxor_u8
                           1203 ;src/Map.c:294: generate_map();
   0843 CD BD 01      [17] 1204 	call	_generate_map
                           1205 ;src/Map.c:295: generate_exit_door();
   0846 CD 72 06      [17] 1206 	call	_generate_exit_door
                           1207 ;src/Map.c:298: *(u8*)(MAP_MEM + 6 + MAP_WIDTH*5)=0b00000001;
   0849 21 A6 70      [10] 1208 	ld	hl,#0x70A6
   084C 36 01         [10] 1209 	ld	(hl),#0x01
                           1210 ;src/Map.c:299: *(u8*)(MAP_MEM + 7 + MAP_WIDTH*5)=0b00000010;
   084E 2E A7         [ 7] 1211 	ld	l, #0xA7
   0850 36 02         [10] 1212 	ld	(hl),#0x02
                           1213 ;src/Map.c:300: *(u8*)(MAP_MEM + 8 + MAP_WIDTH*5)=0b00000011;
   0852 2E A8         [ 7] 1214 	ld	l, #0xA8
   0854 36 03         [10] 1215 	ld	(hl),#0x03
                           1216 ;src/Map.c:301: *(u8*)(MAP_MEM + 9 + MAP_WIDTH*5)=0b00000100;
   0856 2E A9         [ 7] 1217 	ld	l, #0xA9
   0858 36 04         [10] 1218 	ld	(hl),#0x04
   085A C9            [10] 1219 	ret
                           1220 	.area _CODE
                           1221 	.area _INITIALIZER
   4FB0                    1222 __xinit__rand_seed:
   4FB0 00                 1223 	.db #0x00	; 0
                           1224 	.area _CABS (ABS)
