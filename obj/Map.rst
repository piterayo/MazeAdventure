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
                             14 	.globl _cpct_setSeed_lcg_u8
                             15 	.globl _cpct_getRandom_lcg_u8
                             16 	.globl _cpct_memset
                             17 	.globl _rand_seed
                             18 	.globl _init_generator
                             19 	.globl _generate_level
                             20 ;--------------------------------------------------------
                             21 ; special function registers
                             22 ;--------------------------------------------------------
                             23 ;--------------------------------------------------------
                             24 ; ram data
                             25 ;--------------------------------------------------------
                             26 	.area _DATA
                             27 ;--------------------------------------------------------
                             28 ; ram data
                             29 ;--------------------------------------------------------
                             30 	.area _INITIALIZED
                             31 ;--------------------------------------------------------
                             32 ; absolute external ram data
                             33 ;--------------------------------------------------------
                             34 	.area _DABS (ABS)
                             35 ;--------------------------------------------------------
                             36 ; global & static initialisations
                             37 ;--------------------------------------------------------
                             38 	.area _HOME
                             39 	.area _GSINIT
                             40 	.area _GSFINAL
                             41 	.area _GSINIT
                             42 ;--------------------------------------------------------
                             43 ; Home
                             44 ;--------------------------------------------------------
                             45 	.area _HOME
                             46 	.area _HOME
                             47 ;--------------------------------------------------------
                             48 ; code
                             49 ;--------------------------------------------------------
                             50 	.area _CODE
                             51 ;src/Map.c:10: void init_generator(){
                             52 ;	---------------------------------
                             53 ; Function init_generator
                             54 ; ---------------------------------
   42C2                      55 _init_generator::
                             56 ;src/Map.c:11: cpct_setSeed_lcg_u8(rand_seed);
   42C2 FD 21 CC 42   [14]   57 	ld	iy,#_rand_seed
   42C6 FD 6E 00      [19]   58 	ld	l,0 (iy)
   42C9 C3 08 75      [10]   59 	jp  _cpct_setSeed_lcg_u8
   42CC                      60 _rand_seed:
   42CC 00                   61 	.db #0x00	; 0
                             62 ;src/Map.c:14: u8 get_random_wall(){
                             63 ;	---------------------------------
                             64 ; Function get_random_wall
                             65 ; ---------------------------------
   42CD                      66 _get_random_wall::
                             67 ;src/Map.c:15: u8 cellType = cpct_getRandom_lcg_u8();
   42CD CD A2 75      [17]   68 	call	_cpct_getRandom_lcg_u8
                             69 ;src/Map.c:16: if(cellType&1){
   42D0 CB 45         [ 8]   70 	bit	0, l
   42D2 28 03         [12]   71 	jr	Z,00108$
                             72 ;src/Map.c:17: return CELLTYPE_WALL1;
   42D4 2E 81         [ 7]   73 	ld	l,#0x81
   42D6 C9            [10]   74 	ret
   42D7                      75 00108$:
                             76 ;src/Map.c:20: if(cellType&3){
   42D7 7D            [ 4]   77 	ld	a,l
   42D8 E6 03         [ 7]   78 	and	a, #0x03
   42DA 28 03         [12]   79 	jr	Z,00105$
                             80 ;src/Map.c:21: return CELLTYPE_WALL2;
   42DC 2E 82         [ 7]   81 	ld	l,#0x82
   42DE C9            [10]   82 	ret
   42DF                      83 00105$:
                             84 ;src/Map.c:24: if(cellType&5){
   42DF 7D            [ 4]   85 	ld	a,l
   42E0 E6 05         [ 7]   86 	and	a, #0x05
   42E2 28 03         [12]   87 	jr	Z,00102$
                             88 ;src/Map.c:25: return CELLTYPE_WALL3;
   42E4 2E 83         [ 7]   89 	ld	l,#0x83
   42E6 C9            [10]   90 	ret
   42E7                      91 00102$:
                             92 ;src/Map.c:28: return CELLTYPE_WALL4;  
   42E7 2E 84         [ 7]   93 	ld	l,#0x84
   42E9 C9            [10]   94 	ret
                             95 ;src/Map.c:34: void generate_map(){
                             96 ;	---------------------------------
                             97 ; Function generate_map
                             98 ; ---------------------------------
   42EA                      99 _generate_map::
   42EA DD E5         [15]  100 	push	ix
   42EC DD 21 00 00   [14]  101 	ld	ix,#0
   42F0 DD 39         [15]  102 	add	ix,sp
   42F2 21 EB FF      [10]  103 	ld	hl,#-21
   42F5 39            [11]  104 	add	hl,sp
   42F6 F9            [ 6]  105 	ld	sp,hl
                            106 ;src/Map.c:37: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
   42F7 DD 36 F1 83   [19]  107 	ld	-15 (ix),#0x83
   42FB DD 36 F2 03   [19]  108 	ld	-14 (ix),#0x03
                            109 ;src/Map.c:43: u16 wallListCount = 0;
   42FF DD 36 ED 00   [19]  110 	ld	-19 (ix),#0x00
   4303 DD 36 EE 00   [19]  111 	ld	-18 (ix),#0x00
                            112 ;src/Map.c:44: u16 lastStackItem = 0;
   4307 21 00 00      [10]  113 	ld	hl,#0x0000
   430A E3            [19]  114 	ex	(sp), hl
                            115 ;src/Map.c:46: (*cellStack).x = (cpct_getRandom_lcg_u8()%(MAP_WIDTH-2))+1; //RANDOM
   430B CD A2 75      [17]  116 	call	_cpct_getRandom_lcg_u8
   430E 45            [ 4]  117 	ld	b,l
   430F 3E 1E         [ 7]  118 	ld	a,#0x1E
   4311 F5            [11]  119 	push	af
   4312 33            [ 6]  120 	inc	sp
   4313 C5            [11]  121 	push	bc
   4314 33            [ 6]  122 	inc	sp
   4315 CD F1 74      [17]  123 	call	__moduchar
   4318 F1            [10]  124 	pop	af
   4319 4D            [ 4]  125 	ld	c,l
   431A 0C            [ 4]  126 	inc	c
   431B 21 40 29      [10]  127 	ld	hl,#0x2940
   431E 71            [ 7]  128 	ld	(hl),c
                            129 ;src/Map.c:47: (*cellStack).y = (cpct_getRandom_lcg_u8()%(MAP_HEIGHT-2))+1; //RANDOM
   431F CD A2 75      [17]  130 	call	_cpct_getRandom_lcg_u8
   4322 45            [ 4]  131 	ld	b,l
   4323 3E 1E         [ 7]  132 	ld	a,#0x1E
   4325 F5            [11]  133 	push	af
   4326 33            [ 6]  134 	inc	sp
   4327 C5            [11]  135 	push	bc
   4328 33            [ 6]  136 	inc	sp
   4329 CD F1 74      [17]  137 	call	__moduchar
   432C F1            [10]  138 	pop	af
   432D 4D            [ 4]  139 	ld	c,l
   432E 0C            [ 4]  140 	inc	c
   432F 21 41 29      [10]  141 	ld	hl,#0x2941
   4332 71            [ 7]  142 	ld	(hl),c
                            143 ;src/Map.c:50: *(i8*)&(PLAYER_position.x) = (*cellStack).y;
   4333 DD 36 FB BA   [19]  144 	ld	-5 (ix),#<(_PLAYER_position)
   4337 DD 36 FC 49   [19]  145 	ld	-4 (ix),#>(_PLAYER_position)
   433B 2E 41         [ 7]  146 	ld	l, #0x41
   433D 7E            [ 7]  147 	ld	a,(hl)
   433E DD 77 FD      [19]  148 	ld	-3 (ix),a
   4341 DD 6E FB      [19]  149 	ld	l,-5 (ix)
   4344 DD 66 FC      [19]  150 	ld	h,-4 (ix)
   4347 DD 7E FD      [19]  151 	ld	a,-3 (ix)
   434A 77            [ 7]  152 	ld	(hl),a
                            153 ;src/Map.c:51: *(i8*)&(PLAYER_position.y) = (*cellStack).x;
   434B DD 36 FB BB   [19]  154 	ld	-5 (ix),#<((_PLAYER_position + 0x0001))
   434F DD 36 FC 49   [19]  155 	ld	-4 (ix),#>((_PLAYER_position + 0x0001))
   4353 21 40 29      [10]  156 	ld	hl,#0x2940
   4356 4E            [ 7]  157 	ld	c,(hl)
   4357 DD 6E FB      [19]  158 	ld	l,-5 (ix)
   435A DD 66 FC      [19]  159 	ld	h,-4 (ix)
   435D 71            [ 7]  160 	ld	(hl),c
                            161 ;src/Map.c:53: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   435E 21 00 04      [10]  162 	ld	hl,#0x0400
   4361 E5            [11]  163 	push	hl
   4362 3E 87         [ 7]  164 	ld	a,#0x87
   4364 F5            [11]  165 	push	af
   4365 33            [ 6]  166 	inc	sp
   4366 21 40 00      [10]  167 	ld	hl,#0x0040
   4369 E5            [11]  168 	push	hl
   436A CD C1 75      [17]  169 	call	_cpct_memset
                            170 ;src/Map.c:55: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   436D 3A 40 29      [13]  171 	ld	a,(#0x2940)
   4370 DD 77 FD      [19]  172 	ld	-3 (ix), a
   4373 DD 77 FB      [19]  173 	ld	-5 (ix),a
   4376 DD 36 FC 00   [19]  174 	ld	-4 (ix),#0x00
   437A 3E 06         [ 7]  175 	ld	a,#0x05+1
   437C 18 08         [12]  176 	jr	00315$
   437E                     177 00314$:
   437E DD CB FB 26   [23]  178 	sla	-5 (ix)
   4382 DD CB FC 16   [23]  179 	rl	-4 (ix)
   4386                     180 00315$:
   4386 3D            [ 4]  181 	dec	a
   4387 20 F5         [12]  182 	jr	NZ,00314$
   4389 DD 7E FB      [19]  183 	ld	a,-5 (ix)
   438C C6 40         [ 7]  184 	add	a, #0x40
   438E DD 77 FB      [19]  185 	ld	-5 (ix),a
   4391 DD 7E FC      [19]  186 	ld	a,-4 (ix)
   4394 CE 00         [ 7]  187 	adc	a, #0x00
   4396 DD 77 FC      [19]  188 	ld	-4 (ix),a
   4399 21 41 29      [10]  189 	ld	hl,#0x2941
   439C 4E            [ 7]  190 	ld	c,(hl)
   439D DD 6E FB      [19]  191 	ld	l,-5 (ix)
   43A0 DD 66 FC      [19]  192 	ld	h,-4 (ix)
   43A3 06 00         [ 7]  193 	ld	b,#0x00
   43A5 09            [11]  194 	add	hl, bc
   43A6 36 00         [10]  195 	ld	(hl),#0x00
                            196 ;src/Map.c:58: for(i=0;i<MAP_WIDTH;++i){
   43A8 0E 00         [ 7]  197 	ld	c,#0x00
   43AA                     198 00167$:
                            199 ;src/Map.c:59: map[0][i]=CELLTYPE_WALL1;//get_random_wall();
   43AA 21 40 00      [10]  200 	ld	hl,#0x0040
   43AD 06 00         [ 7]  201 	ld	b,#0x00
   43AF 09            [11]  202 	add	hl, bc
   43B0 36 81         [10]  203 	ld	(hl),#0x81
                            204 ;src/Map.c:60: map[MAP_HEIGHT-1][i]=CELLTYPE_WALL1;//get_random_wall();
   43B2 21 20 04      [10]  205 	ld	hl,#0x0420
   43B5 06 00         [ 7]  206 	ld	b,#0x00
   43B7 09            [11]  207 	add	hl, bc
   43B8 36 81         [10]  208 	ld	(hl),#0x81
                            209 ;src/Map.c:58: for(i=0;i<MAP_WIDTH;++i){
   43BA 0C            [ 4]  210 	inc	c
   43BB 79            [ 4]  211 	ld	a,c
   43BC D6 20         [ 7]  212 	sub	a, #0x20
   43BE 38 EA         [12]  213 	jr	C,00167$
                            214 ;src/Map.c:63: for(i=1;i<MAP_HEIGHT-1;++i){
   43C0 DD 36 F3 01   [19]  215 	ld	-13 (ix),#0x01
   43C4                     216 00169$:
                            217 ;src/Map.c:64: map[i][0]=CELLTYPE_WALL1;//get_random_wall();
   43C4 DD 7E F3      [19]  218 	ld	a,-13 (ix)
   43C7 DD 77 FB      [19]  219 	ld	-5 (ix),a
   43CA DD 36 FC 00   [19]  220 	ld	-4 (ix),#0x00
   43CE 3E 06         [ 7]  221 	ld	a,#0x05+1
   43D0 18 08         [12]  222 	jr	00317$
   43D2                     223 00316$:
   43D2 DD CB FB 26   [23]  224 	sla	-5 (ix)
   43D6 DD CB FC 16   [23]  225 	rl	-4 (ix)
   43DA                     226 00317$:
   43DA 3D            [ 4]  227 	dec	a
   43DB 20 F5         [12]  228 	jr	NZ,00316$
   43DD DD 7E FB      [19]  229 	ld	a,-5 (ix)
   43E0 C6 40         [ 7]  230 	add	a, #0x40
   43E2 DD 77 FE      [19]  231 	ld	-2 (ix),a
   43E5 DD 7E FC      [19]  232 	ld	a,-4 (ix)
   43E8 CE 00         [ 7]  233 	adc	a, #0x00
   43EA DD 77 FF      [19]  234 	ld	-1 (ix),a
   43ED DD 6E FE      [19]  235 	ld	l,-2 (ix)
   43F0 DD 66 FF      [19]  236 	ld	h,-1 (ix)
   43F3 36 81         [10]  237 	ld	(hl),#0x81
                            238 ;src/Map.c:65: map[i][MAP_WIDTH-1]=CELLTYPE_WALL1;//get_random_wall();
   43F5 DD 7E FB      [19]  239 	ld	a,-5 (ix)
   43F8 C6 40         [ 7]  240 	add	a, #0x40
   43FA DD 77 FE      [19]  241 	ld	-2 (ix),a
   43FD DD 7E FC      [19]  242 	ld	a,-4 (ix)
   4400 CE 00         [ 7]  243 	adc	a, #0x00
   4402 DD 77 FF      [19]  244 	ld	-1 (ix),a
   4405 DD 7E FE      [19]  245 	ld	a,-2 (ix)
   4408 C6 1F         [ 7]  246 	add	a, #0x1F
   440A DD 77 FE      [19]  247 	ld	-2 (ix),a
   440D DD 7E FF      [19]  248 	ld	a,-1 (ix)
   4410 CE 00         [ 7]  249 	adc	a, #0x00
   4412 DD 77 FF      [19]  250 	ld	-1 (ix),a
   4415 DD 6E FE      [19]  251 	ld	l,-2 (ix)
   4418 DD 66 FF      [19]  252 	ld	h,-1 (ix)
   441B 36 81         [10]  253 	ld	(hl),#0x81
                            254 ;src/Map.c:63: for(i=1;i<MAP_HEIGHT-1;++i){
   441D DD 34 F3      [23]  255 	inc	-13 (ix)
   4420 DD 7E F3      [19]  256 	ld	a,-13 (ix)
   4423 D6 1F         [ 7]  257 	sub	a, #0x1F
   4425 38 9D         [12]  258 	jr	C,00169$
                            259 ;src/Map.c:68: while(remainingCells>0){
   4427 21 04 00      [10]  260 	ld	hl,#0x0004
   442A 39            [11]  261 	add	hl,sp
   442B DD 75 FE      [19]  262 	ld	-2 (ix),l
   442E DD 74 FF      [19]  263 	ld	-1 (ix),h
   4431                     264 00164$:
   4431 DD 7E F2      [19]  265 	ld	a,-14 (ix)
   4434 DD B6 F1      [19]  266 	or	a,-15 (ix)
   4437 CA 00 48      [10]  267 	jp	Z,00171$
                            268 ;src/Map.c:69: wallListPosition = wallList+wallListCount;
   443A C1            [10]  269 	pop	bc
   443B E1            [10]  270 	pop	hl
   443C E5            [11]  271 	push	hl
   443D C5            [11]  272 	push	bc
   443E 29            [11]  273 	add	hl, hl
   443F 7D            [ 4]  274 	ld	a,l
   4440 C6 40         [ 7]  275 	add	a, #0x40
   4442 DD 77 FB      [19]  276 	ld	-5 (ix),a
   4445 7C            [ 4]  277 	ld	a,h
   4446 CE 2D         [ 7]  278 	adc	a, #0x2D
   4448 DD 77 FC      [19]  279 	ld	-4 (ix),a
                            280 ;src/Map.c:70: while(wallListCount<MAP_SIZE){
   444B D1            [10]  281 	pop	de
   444C C1            [10]  282 	pop	bc
   444D C5            [11]  283 	push	bc
   444E D5            [11]  284 	push	de
   444F                     285 00134$:
                            286 ;src/Map.c:73: currentPos.y = (*wallListPosition).y;
   444F DD 7E FE      [19]  287 	ld	a,-2 (ix)
   4452 C6 01         [ 7]  288 	add	a, #0x01
   4454 DD 77 F9      [19]  289 	ld	-7 (ix),a
   4457 DD 7E FF      [19]  290 	ld	a,-1 (ix)
   445A CE 00         [ 7]  291 	adc	a, #0x00
   445C DD 77 FA      [19]  292 	ld	-6 (ix),a
                            293 ;src/Map.c:70: while(wallListCount<MAP_SIZE){
   445F 78            [ 4]  294 	ld	a,b
   4460 D6 04         [ 7]  295 	sub	a, #0x04
   4462 D2 01 46      [10]  296 	jp	NC,00204$
                            297 ;src/Map.c:72: currentPos.x = (*wallListPosition).x;
   4465 21 04 00      [10]  298 	ld	hl,#0x0004
   4468 39            [11]  299 	add	hl,sp
   4469 EB            [ 4]  300 	ex	de,hl
   446A DD 6E FB      [19]  301 	ld	l,-5 (ix)
   446D DD 66 FC      [19]  302 	ld	h,-4 (ix)
   4470 7E            [ 7]  303 	ld	a,(hl)
   4471 12            [ 7]  304 	ld	(de),a
                            305 ;src/Map.c:73: currentPos.y = (*wallListPosition).y;
   4472 DD 5E FB      [19]  306 	ld	e,-5 (ix)
   4475 DD 56 FC      [19]  307 	ld	d,-4 (ix)
   4478 13            [ 6]  308 	inc	de
   4479 1A            [ 7]  309 	ld	a,(de)
   447A DD 6E F9      [19]  310 	ld	l,-7 (ix)
   447D DD 66 FA      [19]  311 	ld	h,-6 (ix)
   4480 77            [ 7]  312 	ld	(hl),a
                            313 ;src/Map.c:75: convertToFloor=0;
   4481 DD 36 F4 00   [19]  314 	ld	-12 (ix),#0x00
                            315 ;src/Map.c:76: surroundedByWalls=1;
   4485 DD 36 F5 01   [19]  316 	ld	-11 (ix),#0x01
                            317 ;src/Map.c:78: if(currentPos.x>0){
   4489 DD 6E FE      [19]  318 	ld	l,-2 (ix)
   448C DD 66 FF      [19]  319 	ld	h,-1 (ix)
   448F 7E            [ 7]  320 	ld	a,(hl)
   4490 DD 77 FD      [19]  321 	ld	-3 (ix),a
                            322 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   4493 DD 6E F9      [19]  323 	ld	l,-7 (ix)
   4496 DD 66 FA      [19]  324 	ld	h,-6 (ix)
   4499 7E            [ 7]  325 	ld	a,(hl)
   449A DD 77 F8      [19]  326 	ld	-8 (ix),a
   449D DD 7E FD      [19]  327 	ld	a,-3 (ix)
   44A0 DD 77 F6      [19]  328 	ld	-10 (ix),a
   44A3 DD 36 F7 00   [19]  329 	ld	-9 (ix),#0x00
                            330 ;src/Map.c:78: if(currentPos.x>0){
   44A7 DD 7E FD      [19]  331 	ld	a,-3 (ix)
   44AA B7            [ 4]  332 	or	a, a
   44AB 28 2F         [12]  333 	jr	Z,00109$
                            334 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   44AD DD 6E F6      [19]  335 	ld	l,-10 (ix)
   44B0 DD 66 F7      [19]  336 	ld	h,-9 (ix)
   44B3 2B            [ 6]  337 	dec	hl
   44B4 29            [11]  338 	add	hl, hl
   44B5 29            [11]  339 	add	hl, hl
   44B6 29            [11]  340 	add	hl, hl
   44B7 29            [11]  341 	add	hl, hl
   44B8 29            [11]  342 	add	hl, hl
   44B9 D5            [11]  343 	push	de
   44BA 11 40 00      [10]  344 	ld	de,#0x0040
   44BD 19            [11]  345 	add	hl, de
   44BE D1            [10]  346 	pop	de
   44BF 7D            [ 4]  347 	ld	a,l
   44C0 DD 86 F8      [19]  348 	add	a, -8 (ix)
   44C3 6F            [ 4]  349 	ld	l,a
   44C4 7C            [ 4]  350 	ld	a,h
   44C5 CE 00         [ 7]  351 	adc	a, #0x00
   44C7 67            [ 4]  352 	ld	h,a
   44C8 6E            [ 7]  353 	ld	l,(hl)
                            354 ;src/Map.c:80: if(adjacentType == CELLTYPE_UNDEFINED){
   44C9 7D            [ 4]  355 	ld	a,l
   44CA D6 87         [ 7]  356 	sub	a, #0x87
   44CC 20 06         [12]  357 	jr	NZ,00106$
                            358 ;src/Map.c:81: convertToFloor  = 1;
   44CE DD 36 F4 01   [19]  359 	ld	-12 (ix),#0x01
   44D2 18 08         [12]  360 	jr	00109$
   44D4                     361 00106$:
                            362 ;src/Map.c:83: else if(adjacentType == CELLTYPE_FLOOR){
   44D4 7D            [ 4]  363 	ld	a,l
   44D5 B7            [ 4]  364 	or	a, a
   44D6 20 04         [12]  365 	jr	NZ,00109$
                            366 ;src/Map.c:84: surroundedByWalls = 0;
   44D8 DD 36 F5 00   [19]  367 	ld	-11 (ix),#0x00
   44DC                     368 00109$:
                            369 ;src/Map.c:87: if(currentPos.x < (MAP_WIDTH-1)){
   44DC DD 7E FD      [19]  370 	ld	a,-3 (ix)
   44DF D6 1F         [ 7]  371 	sub	a, #0x1F
   44E1 30 2F         [12]  372 	jr	NC,00116$
                            373 ;src/Map.c:89: adjacentType = map[currentPos.x+1][currentPos.y];
   44E3 DD 6E F6      [19]  374 	ld	l,-10 (ix)
   44E6 DD 66 F7      [19]  375 	ld	h,-9 (ix)
   44E9 23            [ 6]  376 	inc	hl
   44EA 29            [11]  377 	add	hl, hl
   44EB 29            [11]  378 	add	hl, hl
   44EC 29            [11]  379 	add	hl, hl
   44ED 29            [11]  380 	add	hl, hl
   44EE 29            [11]  381 	add	hl, hl
   44EF D5            [11]  382 	push	de
   44F0 11 40 00      [10]  383 	ld	de,#0x0040
   44F3 19            [11]  384 	add	hl, de
   44F4 D1            [10]  385 	pop	de
   44F5 7D            [ 4]  386 	ld	a,l
   44F6 DD 86 F8      [19]  387 	add	a, -8 (ix)
   44F9 6F            [ 4]  388 	ld	l,a
   44FA 7C            [ 4]  389 	ld	a,h
   44FB CE 00         [ 7]  390 	adc	a, #0x00
   44FD 67            [ 4]  391 	ld	h,a
   44FE 6E            [ 7]  392 	ld	l,(hl)
                            393 ;src/Map.c:90: if(adjacentType == CELLTYPE_UNDEFINED){
   44FF 7D            [ 4]  394 	ld	a,l
   4500 D6 87         [ 7]  395 	sub	a, #0x87
   4502 20 06         [12]  396 	jr	NZ,00113$
                            397 ;src/Map.c:91: convertToFloor  = 1;
   4504 DD 36 F4 01   [19]  398 	ld	-12 (ix),#0x01
   4508 18 08         [12]  399 	jr	00116$
   450A                     400 00113$:
                            401 ;src/Map.c:93: else if(adjacentType == CELLTYPE_FLOOR){
   450A 7D            [ 4]  402 	ld	a,l
   450B B7            [ 4]  403 	or	a, a
   450C 20 04         [12]  404 	jr	NZ,00116$
                            405 ;src/Map.c:94: surroundedByWalls = 0;
   450E DD 36 F5 00   [19]  406 	ld	-11 (ix),#0x00
   4512                     407 00116$:
                            408 ;src/Map.c:99: adjacentType = map[currentPos.x][currentPos.y-1];
   4512 DD 6E F6      [19]  409 	ld	l,-10 (ix)
   4515 DD 66 F7      [19]  410 	ld	h,-9 (ix)
   4518 29            [11]  411 	add	hl, hl
   4519 29            [11]  412 	add	hl, hl
   451A 29            [11]  413 	add	hl, hl
   451B 29            [11]  414 	add	hl, hl
   451C 29            [11]  415 	add	hl, hl
   451D 7D            [ 4]  416 	ld	a,l
   451E C6 40         [ 7]  417 	add	a, #0x40
   4520 DD 77 F6      [19]  418 	ld	-10 (ix),a
   4523 7C            [ 4]  419 	ld	a,h
   4524 CE 00         [ 7]  420 	adc	a, #0x00
   4526 DD 77 F7      [19]  421 	ld	-9 (ix),a
                            422 ;src/Map.c:97: if(currentPos.y > 0){
   4529 DD 7E F8      [19]  423 	ld	a,-8 (ix)
   452C B7            [ 4]  424 	or	a, a
   452D 28 23         [12]  425 	jr	Z,00123$
                            426 ;src/Map.c:99: adjacentType = map[currentPos.x][currentPos.y-1];
   452F DD 6E F8      [19]  427 	ld	l,-8 (ix)
   4532 2D            [ 4]  428 	dec	l
   4533 DD 7E F6      [19]  429 	ld	a,-10 (ix)
   4536 85            [ 4]  430 	add	a, l
   4537 6F            [ 4]  431 	ld	l,a
   4538 DD 7E F7      [19]  432 	ld	a,-9 (ix)
   453B CE 00         [ 7]  433 	adc	a, #0x00
   453D 67            [ 4]  434 	ld	h,a
   453E 6E            [ 7]  435 	ld	l,(hl)
                            436 ;src/Map.c:100: if(adjacentType == CELLTYPE_UNDEFINED){
   453F 7D            [ 4]  437 	ld	a,l
   4540 D6 87         [ 7]  438 	sub	a, #0x87
   4542 20 06         [12]  439 	jr	NZ,00120$
                            440 ;src/Map.c:101: convertToFloor  = 1;
   4544 DD 36 F4 01   [19]  441 	ld	-12 (ix),#0x01
   4548 18 08         [12]  442 	jr	00123$
   454A                     443 00120$:
                            444 ;src/Map.c:103: else if(adjacentType == CELLTYPE_FLOOR){
   454A 7D            [ 4]  445 	ld	a,l
   454B B7            [ 4]  446 	or	a, a
   454C 20 04         [12]  447 	jr	NZ,00123$
                            448 ;src/Map.c:104: surroundedByWalls = 0;
   454E DD 36 F5 00   [19]  449 	ld	-11 (ix),#0x00
   4552                     450 00123$:
                            451 ;src/Map.c:107: if(currentPos.y < (MAP_HEIGHT-1)){
   4552 DD 7E F8      [19]  452 	ld	a,-8 (ix)
   4555 D6 1F         [ 7]  453 	sub	a, #0x1F
   4557 30 23         [12]  454 	jr	NC,00130$
                            455 ;src/Map.c:109: adjacentType = map[currentPos.x][currentPos.y+1];
   4559 DD 6E F8      [19]  456 	ld	l,-8 (ix)
   455C 2C            [ 4]  457 	inc	l
   455D DD 7E F6      [19]  458 	ld	a,-10 (ix)
   4560 85            [ 4]  459 	add	a, l
   4561 6F            [ 4]  460 	ld	l,a
   4562 DD 7E F7      [19]  461 	ld	a,-9 (ix)
   4565 CE 00         [ 7]  462 	adc	a, #0x00
   4567 67            [ 4]  463 	ld	h,a
   4568 6E            [ 7]  464 	ld	l,(hl)
                            465 ;src/Map.c:110: if(adjacentType == CELLTYPE_UNDEFINED){
   4569 7D            [ 4]  466 	ld	a,l
   456A D6 87         [ 7]  467 	sub	a, #0x87
   456C 20 06         [12]  468 	jr	NZ,00127$
                            469 ;src/Map.c:111: convertToFloor  = 1;
   456E DD 36 F4 01   [19]  470 	ld	-12 (ix),#0x01
   4572 18 08         [12]  471 	jr	00130$
   4574                     472 00127$:
                            473 ;src/Map.c:113: else if(adjacentType == CELLTYPE_FLOOR){
   4574 7D            [ 4]  474 	ld	a,l
   4575 B7            [ 4]  475 	or	a, a
   4576 20 04         [12]  476 	jr	NZ,00130$
                            477 ;src/Map.c:114: surroundedByWalls = 0;
   4578 DD 36 F5 00   [19]  478 	ld	-11 (ix),#0x00
   457C                     479 00130$:
                            480 ;src/Map.c:118: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   457C 69            [ 4]  481 	ld	l, c
   457D 60            [ 4]  482 	ld	h, b
   457E 29            [11]  483 	add	hl, hl
   457F FD 21 40 2D   [14]  484 	ld	iy,#0x2D40
   4583 C5            [11]  485 	push	bc
   4584 4D            [ 4]  486 	ld	c, l
   4585 44            [ 4]  487 	ld	b, h
   4586 FD 09         [15]  488 	add	iy, bc
   4588 C1            [10]  489 	pop	bc
   4589 FD 7E 00      [19]  490 	ld	a, 0 (iy)
   458C DD 6E FB      [19]  491 	ld	l,-5 (ix)
   458F DD 66 FC      [19]  492 	ld	h,-4 (ix)
   4592 77            [ 7]  493 	ld	(hl),a
                            494 ;src/Map.c:119: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   4593 FD E5         [15]  495 	push	iy
   4595 E1            [10]  496 	pop	hl
   4596 23            [ 6]  497 	inc	hl
   4597 7E            [ 7]  498 	ld	a,(hl)
   4598 12            [ 7]  499 	ld	(de),a
                            500 ;src/Map.c:120: --wallListCount;
   4599 0B            [ 6]  501 	dec	bc
   459A DD 71 ED      [19]  502 	ld	-19 (ix),c
   459D DD 70 EE      [19]  503 	ld	-18 (ix),b
                            504 ;src/Map.c:123: if((convertToFloor)&&(!surroundedByWalls)){
   45A0 DD 7E F4      [19]  505 	ld	a,-12 (ix)
   45A3 B7            [ 4]  506 	or	a, a
   45A4 28 4A         [12]  507 	jr	Z,00132$
   45A6 DD 7E F5      [19]  508 	ld	a,-11 (ix)
   45A9 B7            [ 4]  509 	or	a, a
   45AA 20 44         [12]  510 	jr	NZ,00132$
                            511 ;src/Map.c:124: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   45AC DD 6E FE      [19]  512 	ld	l,-2 (ix)
   45AF DD 66 FF      [19]  513 	ld	h,-1 (ix)
   45B2 6E            [ 7]  514 	ld	l,(hl)
   45B3 26 00         [ 7]  515 	ld	h,#0x00
   45B5 29            [11]  516 	add	hl, hl
   45B6 29            [11]  517 	add	hl, hl
   45B7 29            [11]  518 	add	hl, hl
   45B8 29            [11]  519 	add	hl, hl
   45B9 29            [11]  520 	add	hl, hl
   45BA 01 40 00      [10]  521 	ld	bc,#0x0040
   45BD 09            [11]  522 	add	hl,bc
   45BE 4D            [ 4]  523 	ld	c,l
   45BF 44            [ 4]  524 	ld	b,h
   45C0 DD 6E F9      [19]  525 	ld	l,-7 (ix)
   45C3 DD 66 FA      [19]  526 	ld	h,-6 (ix)
   45C6 6E            [ 7]  527 	ld	l, (hl)
   45C7 26 00         [ 7]  528 	ld	h,#0x00
   45C9 09            [11]  529 	add	hl,bc
   45CA 36 00         [10]  530 	ld	(hl),#0x00
                            531 ;src/Map.c:126: ++lastStackItem;
   45CC DD 34 EB      [23]  532 	inc	-21 (ix)
   45CF 20 03         [12]  533 	jr	NZ,00326$
   45D1 DD 34 EC      [23]  534 	inc	-20 (ix)
   45D4                     535 00326$:
                            536 ;src/Map.c:127: (*(cellStack+lastStackItem)).x = currentPos.x;
   45D4 E1            [10]  537 	pop	hl
   45D5 E5            [11]  538 	push	hl
   45D6 29            [11]  539 	add	hl, hl
   45D7 01 40 29      [10]  540 	ld	bc, #0x2940
   45DA 09            [11]  541 	add	hl,bc
   45DB 4D            [ 4]  542 	ld	c, l
   45DC 44            [ 4]  543 	ld	b, h
   45DD DD 6E FE      [19]  544 	ld	l,-2 (ix)
   45E0 DD 66 FF      [19]  545 	ld	h,-1 (ix)
   45E3 7E            [ 7]  546 	ld	a,(hl)
   45E4 02            [ 7]  547 	ld	(bc),a
                            548 ;src/Map.c:128: (*(cellStack+lastStackItem)).y = currentPos.y;
   45E5 03            [ 6]  549 	inc	bc
   45E6 DD 6E F9      [19]  550 	ld	l,-7 (ix)
   45E9 DD 66 FA      [19]  551 	ld	h,-6 (ix)
   45EC 7E            [ 7]  552 	ld	a,(hl)
   45ED 02            [ 7]  553 	ld	(bc),a
                            554 ;src/Map.c:131: break;
   45EE 18 11         [12]  555 	jr	00204$
   45F0                     556 00132$:
                            557 ;src/Map.c:133: --wallListPosition;
   45F0 DD 6E FB      [19]  558 	ld	l,-5 (ix)
   45F3 DD 66 FC      [19]  559 	ld	h,-4 (ix)
   45F6 2B            [ 6]  560 	dec	hl
   45F7 2B            [ 6]  561 	dec	hl
   45F8 DD 75 FB      [19]  562 	ld	-5 (ix),l
   45FB DD 74 FC      [19]  563 	ld	-4 (ix),h
   45FE C3 4F 44      [10]  564 	jp	00134$
                            565 ;src/Map.c:135: while(lastStackItem<MAP_SIZE){
   4601                     566 00204$:
   4601 DD 7E F1      [19]  567 	ld	a,-15 (ix)
   4604 DD 77 F6      [19]  568 	ld	-10 (ix),a
   4607 DD 7E F2      [19]  569 	ld	a,-14 (ix)
   460A DD 77 F7      [19]  570 	ld	-9 (ix),a
   460D DD 7E ED      [19]  571 	ld	a,-19 (ix)
   4610 DD 77 FB      [19]  572 	ld	-5 (ix),a
   4613 DD 7E EE      [19]  573 	ld	a,-18 (ix)
   4616 DD 77 FC      [19]  574 	ld	-4 (ix),a
   4619                     575 00161$:
   4619 DD 7E EC      [19]  576 	ld	a,-20 (ix)
   461C D6 04         [ 7]  577 	sub	a, #0x04
   461E D2 31 44      [10]  578 	jp	NC,00164$
                            579 ;src/Map.c:136: currentPos.x=(*(lastStackItem+cellStack)).x;
   4621 21 04 00      [10]  580 	ld	hl,#0x0004
   4624 39            [11]  581 	add	hl,sp
   4625 4D            [ 4]  582 	ld	c,l
   4626 44            [ 4]  583 	ld	b,h
   4627 E1            [10]  584 	pop	hl
   4628 E5            [11]  585 	push	hl
   4629 29            [11]  586 	add	hl, hl
   462A FD 21 40 29   [14]  587 	ld	iy,#0x2940
   462E EB            [ 4]  588 	ex	de,hl
   462F FD 19         [15]  589 	add	iy, de
   4631 FD 7E 00      [19]  590 	ld	a, 0 (iy)
   4634 02            [ 7]  591 	ld	(bc),a
                            592 ;src/Map.c:137: currentPos.y=(*(lastStackItem+cellStack)).y;
   4635 FD 4E 01      [19]  593 	ld	c,1 (iy)
   4638 DD 6E F9      [19]  594 	ld	l,-7 (ix)
   463B DD 66 FA      [19]  595 	ld	h,-6 (ix)
   463E 71            [ 7]  596 	ld	(hl),c
                            597 ;src/Map.c:138: --lastStackItem;
   463F E1            [10]  598 	pop	hl
   4640 E5            [11]  599 	push	hl
   4641 2B            [ 6]  600 	dec	hl
   4642 E3            [19]  601 	ex	(sp), hl
                            602 ;src/Map.c:139: cellType = map[currentPos.x][currentPos.y];
   4643 DD 6E FE      [19]  603 	ld	l,-2 (ix)
   4646 DD 66 FF      [19]  604 	ld	h,-1 (ix)
   4649 6E            [ 7]  605 	ld	l,(hl)
   464A 26 00         [ 7]  606 	ld	h,#0x00
   464C 29            [11]  607 	add	hl, hl
   464D 29            [11]  608 	add	hl, hl
   464E 29            [11]  609 	add	hl, hl
   464F 29            [11]  610 	add	hl, hl
   4650 29            [11]  611 	add	hl, hl
   4651 11 40 00      [10]  612 	ld	de,#0x0040
   4654 19            [11]  613 	add	hl,de
   4655 59            [ 4]  614 	ld	e,c
   4656 16 00         [ 7]  615 	ld	d,#0x00
   4658 19            [11]  616 	add	hl,de
   4659 4E            [ 7]  617 	ld	c,(hl)
                            618 ;src/Map.c:141: if(cellType == CELLTYPE_UNDEFINED){
   465A 79            [ 4]  619 	ld	a,c
   465B D6 87         [ 7]  620 	sub	a, #0x87
   465D 20 47         [12]  621 	jr	NZ,00141$
                            622 ;src/Map.c:143: if(cpct_getRandom_lcg_u8()&1){//WALL
   465F CD A2 75      [17]  623 	call	_cpct_getRandom_lcg_u8
   4662 CB 45         [ 8]  624 	bit	0, l
   4664 28 06         [12]  625 	jr	Z,00138$
                            626 ;src/Map.c:144: cellType = get_random_wall();
   4666 CD CD 42      [17]  627 	call	_get_random_wall
   4669 4D            [ 4]  628 	ld	c,l
   466A 18 02         [12]  629 	jr	00139$
   466C                     630 00138$:
                            631 ;src/Map.c:147: cellType = CELLTYPE_FLOOR;
   466C 0E 00         [ 7]  632 	ld	c,#0x00
   466E                     633 00139$:
                            634 ;src/Map.c:149: map[currentPos.x][currentPos.y]=cellType;
   466E DD 6E FE      [19]  635 	ld	l,-2 (ix)
   4671 DD 66 FF      [19]  636 	ld	h,-1 (ix)
   4674 6E            [ 7]  637 	ld	l,(hl)
   4675 26 00         [ 7]  638 	ld	h,#0x00
   4677 29            [11]  639 	add	hl, hl
   4678 29            [11]  640 	add	hl, hl
   4679 29            [11]  641 	add	hl, hl
   467A 29            [11]  642 	add	hl, hl
   467B 29            [11]  643 	add	hl, hl
   467C EB            [ 4]  644 	ex	de,hl
   467D 21 40 00      [10]  645 	ld	hl,#0x0040
   4680 19            [11]  646 	add	hl,de
   4681 EB            [ 4]  647 	ex	de,hl
   4682 DD 6E F9      [19]  648 	ld	l,-7 (ix)
   4685 DD 66 FA      [19]  649 	ld	h,-6 (ix)
   4688 6E            [ 7]  650 	ld	l, (hl)
   4689 26 00         [ 7]  651 	ld	h,#0x00
   468B 19            [11]  652 	add	hl,de
   468C 71            [ 7]  653 	ld	(hl),c
                            654 ;src/Map.c:150: --remainingCells;
   468D DD 6E F6      [19]  655 	ld	l,-10 (ix)
   4690 DD 66 F7      [19]  656 	ld	h,-9 (ix)
   4693 2B            [ 6]  657 	dec	hl
   4694 DD 75 F6      [19]  658 	ld	-10 (ix),l
   4697 DD 74 F7      [19]  659 	ld	-9 (ix),h
   469A DD 7E F6      [19]  660 	ld	a,-10 (ix)
   469D DD 77 F1      [19]  661 	ld	-15 (ix),a
   46A0 DD 7E F7      [19]  662 	ld	a,-9 (ix)
   46A3 DD 77 F2      [19]  663 	ld	-14 (ix),a
   46A6                     664 00141$:
                            665 ;src/Map.c:78: if(currentPos.x>0){
   46A6 DD 6E FE      [19]  666 	ld	l,-2 (ix)
   46A9 DD 66 FF      [19]  667 	ld	h,-1 (ix)
   46AC 7E            [ 7]  668 	ld	a,(hl)
   46AD DD 77 F8      [19]  669 	ld	-8 (ix),a
                            670 ;src/Map.c:153: if((cellType == CELLTYPE_FLOOR)){
   46B0 79            [ 4]  671 	ld	a,c
   46B1 B7            [ 4]  672 	or	a, a
   46B2 C2 CF 47      [10]  673 	jp	NZ,00159$
                            674 ;src/Map.c:154: if(currentPos.x>0){
   46B5 DD 7E F8      [19]  675 	ld	a,-8 (ix)
   46B8 B7            [ 4]  676 	or	a, a
   46B9 28 3F         [12]  677 	jr	Z,00145$
                            678 ;src/Map.c:155: adjacentType = map[currentPos.x-1][currentPos.y];
   46BB DD 6E F8      [19]  679 	ld	l,-8 (ix)
   46BE 26 00         [ 7]  680 	ld	h,#0x00
   46C0 2B            [ 6]  681 	dec	hl
   46C1 29            [11]  682 	add	hl, hl
   46C2 29            [11]  683 	add	hl, hl
   46C3 29            [11]  684 	add	hl, hl
   46C4 29            [11]  685 	add	hl, hl
   46C5 29            [11]  686 	add	hl, hl
   46C6 01 40 00      [10]  687 	ld	bc,#0x0040
   46C9 09            [11]  688 	add	hl,bc
   46CA 4D            [ 4]  689 	ld	c,l
   46CB 44            [ 4]  690 	ld	b,h
   46CC DD 6E F9      [19]  691 	ld	l,-7 (ix)
   46CF DD 66 FA      [19]  692 	ld	h,-6 (ix)
   46D2 6E            [ 7]  693 	ld	l, (hl)
   46D3 26 00         [ 7]  694 	ld	h,#0x00
   46D5 09            [11]  695 	add	hl,bc
   46D6 7E            [ 7]  696 	ld	a,(hl)
                            697 ;src/Map.c:156: if(adjacentType == CELLTYPE_UNDEFINED){
   46D7 D6 87         [ 7]  698 	sub	a, #0x87
   46D9 20 1F         [12]  699 	jr	NZ,00145$
                            700 ;src/Map.c:158: ++lastStackItem;
   46DB DD 34 EB      [23]  701 	inc	-21 (ix)
   46DE 20 03         [12]  702 	jr	NZ,00332$
   46E0 DD 34 EC      [23]  703 	inc	-20 (ix)
   46E3                     704 00332$:
                            705 ;src/Map.c:159: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   46E3 E1            [10]  706 	pop	hl
   46E4 E5            [11]  707 	push	hl
   46E5 29            [11]  708 	add	hl, hl
   46E6 01 40 29      [10]  709 	ld	bc,#0x2940
   46E9 09            [11]  710 	add	hl,bc
   46EA DD 4E F8      [19]  711 	ld	c,-8 (ix)
   46ED 0D            [ 4]  712 	dec	c
   46EE 71            [ 7]  713 	ld	(hl),c
                            714 ;src/Map.c:160: (*(cellStack+lastStackItem)).y = currentPos.y;
   46EF 23            [ 6]  715 	inc	hl
   46F0 4D            [ 4]  716 	ld	c,l
   46F1 44            [ 4]  717 	ld	b,h
   46F2 DD 6E F9      [19]  718 	ld	l,-7 (ix)
   46F5 DD 66 FA      [19]  719 	ld	h,-6 (ix)
   46F8 7E            [ 7]  720 	ld	a,(hl)
   46F9 02            [ 7]  721 	ld	(bc),a
   46FA                     722 00145$:
                            723 ;src/Map.c:164: if(currentPos.x < (MAP_WIDTH-1)){
   46FA DD 6E FE      [19]  724 	ld	l,-2 (ix)
   46FD DD 66 FF      [19]  725 	ld	h,-1 (ix)
   4700 4E            [ 7]  726 	ld	c,(hl)
   4701 79            [ 4]  727 	ld	a,c
   4702 D6 1F         [ 7]  728 	sub	a, #0x1F
   4704 30 3A         [12]  729 	jr	NC,00149$
                            730 ;src/Map.c:166: adjacentType = map[currentPos.x+1][currentPos.y];
   4706 69            [ 4]  731 	ld	l,c
   4707 26 00         [ 7]  732 	ld	h,#0x00
   4709 23            [ 6]  733 	inc	hl
   470A 29            [11]  734 	add	hl, hl
   470B 29            [11]  735 	add	hl, hl
   470C 29            [11]  736 	add	hl, hl
   470D 29            [11]  737 	add	hl, hl
   470E 29            [11]  738 	add	hl, hl
   470F EB            [ 4]  739 	ex	de,hl
   4710 21 40 00      [10]  740 	ld	hl,#0x0040
   4713 19            [11]  741 	add	hl,de
   4714 EB            [ 4]  742 	ex	de,hl
   4715 DD 6E F9      [19]  743 	ld	l,-7 (ix)
   4718 DD 66 FA      [19]  744 	ld	h,-6 (ix)
   471B 6E            [ 7]  745 	ld	l, (hl)
   471C 26 00         [ 7]  746 	ld	h,#0x00
   471E 19            [11]  747 	add	hl,de
   471F 7E            [ 7]  748 	ld	a,(hl)
                            749 ;src/Map.c:167: if(adjacentType == CELLTYPE_UNDEFINED){
   4720 D6 87         [ 7]  750 	sub	a, #0x87
   4722 20 1C         [12]  751 	jr	NZ,00149$
                            752 ;src/Map.c:170: ++lastStackItem;
   4724 DD 34 EB      [23]  753 	inc	-21 (ix)
   4727 20 03         [12]  754 	jr	NZ,00335$
   4729 DD 34 EC      [23]  755 	inc	-20 (ix)
   472C                     756 00335$:
                            757 ;src/Map.c:171: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   472C E1            [10]  758 	pop	hl
   472D E5            [11]  759 	push	hl
   472E 29            [11]  760 	add	hl, hl
   472F 11 40 29      [10]  761 	ld	de,#0x2940
   4732 19            [11]  762 	add	hl,de
   4733 0C            [ 4]  763 	inc	c
   4734 71            [ 7]  764 	ld	(hl),c
                            765 ;src/Map.c:172: (*(cellStack+lastStackItem)).y = currentPos.y;
   4735 23            [ 6]  766 	inc	hl
   4736 4D            [ 4]  767 	ld	c,l
   4737 44            [ 4]  768 	ld	b,h
   4738 DD 6E F9      [19]  769 	ld	l,-7 (ix)
   473B DD 66 FA      [19]  770 	ld	h,-6 (ix)
   473E 7E            [ 7]  771 	ld	a,(hl)
   473F 02            [ 7]  772 	ld	(bc),a
   4740                     773 00149$:
                            774 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   4740 DD 6E F9      [19]  775 	ld	l,-7 (ix)
   4743 DD 66 FA      [19]  776 	ld	h,-6 (ix)
   4746 4E            [ 7]  777 	ld	c,(hl)
                            778 ;src/Map.c:176: if(currentPos.y > 0){
   4747 79            [ 4]  779 	ld	a,c
   4748 B7            [ 4]  780 	or	a, a
   4749 28 3A         [12]  781 	jr	Z,00153$
                            782 ;src/Map.c:178: adjacentType = map[currentPos.x][currentPos.y-1];
   474B DD 6E FE      [19]  783 	ld	l,-2 (ix)
   474E DD 66 FF      [19]  784 	ld	h,-1 (ix)
   4751 46            [ 7]  785 	ld	b,(hl)
   4752 68            [ 4]  786 	ld	l,b
   4753 26 00         [ 7]  787 	ld	h,#0x00
   4755 29            [11]  788 	add	hl, hl
   4756 29            [11]  789 	add	hl, hl
   4757 29            [11]  790 	add	hl, hl
   4758 29            [11]  791 	add	hl, hl
   4759 29            [11]  792 	add	hl, hl
   475A 11 40 00      [10]  793 	ld	de,#0x0040
   475D 19            [11]  794 	add	hl,de
   475E 0D            [ 4]  795 	dec	c
   475F 59            [ 4]  796 	ld	e,c
   4760 16 00         [ 7]  797 	ld	d,#0x00
   4762 19            [11]  798 	add	hl,de
   4763 7E            [ 7]  799 	ld	a,(hl)
                            800 ;src/Map.c:179: if(adjacentType == CELLTYPE_UNDEFINED){
   4764 D6 87         [ 7]  801 	sub	a, #0x87
   4766 20 1D         [12]  802 	jr	NZ,00153$
                            803 ;src/Map.c:182: ++lastStackItem;
   4768 DD 34 EB      [23]  804 	inc	-21 (ix)
   476B 20 03         [12]  805 	jr	NZ,00338$
   476D DD 34 EC      [23]  806 	inc	-20 (ix)
   4770                     807 00338$:
                            808 ;src/Map.c:183: (*(cellStack+lastStackItem)).x = currentPos.x;
   4770 E1            [10]  809 	pop	hl
   4771 E5            [11]  810 	push	hl
   4772 29            [11]  811 	add	hl, hl
   4773 11 40 29      [10]  812 	ld	de,#0x2940
   4776 19            [11]  813 	add	hl,de
   4777 70            [ 7]  814 	ld	(hl),b
                            815 ;src/Map.c:184: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   4778 23            [ 6]  816 	inc	hl
   4779 4D            [ 4]  817 	ld	c,l
   477A 44            [ 4]  818 	ld	b,h
   477B DD 6E F9      [19]  819 	ld	l,-7 (ix)
   477E DD 66 FA      [19]  820 	ld	h,-6 (ix)
   4781 5E            [ 7]  821 	ld	e,(hl)
   4782 1D            [ 4]  822 	dec	e
   4783 7B            [ 4]  823 	ld	a,e
   4784 02            [ 7]  824 	ld	(bc),a
   4785                     825 00153$:
                            826 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   4785 DD 6E F9      [19]  827 	ld	l,-7 (ix)
   4788 DD 66 FA      [19]  828 	ld	h,-6 (ix)
   478B 46            [ 7]  829 	ld	b,(hl)
                            830 ;src/Map.c:188: if(currentPos.y < (MAP_HEIGHT-1)){
   478C 78            [ 4]  831 	ld	a,b
   478D D6 1F         [ 7]  832 	sub	a, #0x1F
   478F D2 19 46      [10]  833 	jp	NC,00161$
                            834 ;src/Map.c:190: adjacentType = map[currentPos.x][currentPos.y+1];
   4792 DD 6E FE      [19]  835 	ld	l,-2 (ix)
   4795 DD 66 FF      [19]  836 	ld	h,-1 (ix)
   4798 4E            [ 7]  837 	ld	c,(hl)
   4799 69            [ 4]  838 	ld	l,c
   479A 26 00         [ 7]  839 	ld	h,#0x00
   479C 29            [11]  840 	add	hl, hl
   479D 29            [11]  841 	add	hl, hl
   479E 29            [11]  842 	add	hl, hl
   479F 29            [11]  843 	add	hl, hl
   47A0 29            [11]  844 	add	hl, hl
   47A1 11 40 00      [10]  845 	ld	de,#0x0040
   47A4 19            [11]  846 	add	hl,de
   47A5 04            [ 4]  847 	inc	b
   47A6 58            [ 4]  848 	ld	e,b
   47A7 16 00         [ 7]  849 	ld	d,#0x00
   47A9 19            [11]  850 	add	hl,de
   47AA 7E            [ 7]  851 	ld	a,(hl)
                            852 ;src/Map.c:191: if(adjacentType == CELLTYPE_UNDEFINED){
   47AB D6 87         [ 7]  853 	sub	a, #0x87
   47AD C2 19 46      [10]  854 	jp	NZ,00161$
                            855 ;src/Map.c:194: ++lastStackItem;
   47B0 DD 34 EB      [23]  856 	inc	-21 (ix)
   47B3 20 03         [12]  857 	jr	NZ,00341$
   47B5 DD 34 EC      [23]  858 	inc	-20 (ix)
   47B8                     859 00341$:
                            860 ;src/Map.c:195: (*(cellStack+lastStackItem)).x = currentPos.x;
   47B8 E1            [10]  861 	pop	hl
   47B9 E5            [11]  862 	push	hl
   47BA 29            [11]  863 	add	hl, hl
   47BB 11 40 29      [10]  864 	ld	de,#0x2940
   47BE 19            [11]  865 	add	hl,de
   47BF 71            [ 7]  866 	ld	(hl),c
                            867 ;src/Map.c:196: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   47C0 23            [ 6]  868 	inc	hl
   47C1 4D            [ 4]  869 	ld	c,l
   47C2 44            [ 4]  870 	ld	b,h
   47C3 DD 6E F9      [19]  871 	ld	l,-7 (ix)
   47C6 DD 66 FA      [19]  872 	ld	h,-6 (ix)
   47C9 7E            [ 7]  873 	ld	a,(hl)
   47CA 3C            [ 4]  874 	inc	a
   47CB 02            [ 7]  875 	ld	(bc),a
   47CC C3 19 46      [10]  876 	jp	00161$
   47CF                     877 00159$:
                            878 ;src/Map.c:202: ++wallListCount;
   47CF DD 34 FB      [23]  879 	inc	-5 (ix)
   47D2 20 03         [12]  880 	jr	NZ,00342$
   47D4 DD 34 FC      [23]  881 	inc	-4 (ix)
   47D7                     882 00342$:
   47D7 DD 7E FB      [19]  883 	ld	a,-5 (ix)
   47DA DD 77 ED      [19]  884 	ld	-19 (ix),a
   47DD DD 7E FC      [19]  885 	ld	a,-4 (ix)
   47E0 DD 77 EE      [19]  886 	ld	-18 (ix),a
                            887 ;src/Map.c:203: (*(wallList+wallListCount)).x = currentPos.x;
   47E3 DD 6E FB      [19]  888 	ld	l,-5 (ix)
   47E6 DD 66 FC      [19]  889 	ld	h,-4 (ix)
   47E9 29            [11]  890 	add	hl, hl
   47EA 01 40 2D      [10]  891 	ld	bc,#0x2D40
   47ED 09            [11]  892 	add	hl,bc
   47EE DD 7E F8      [19]  893 	ld	a,-8 (ix)
   47F1 77            [ 7]  894 	ld	(hl),a
                            895 ;src/Map.c:204: (*(wallList+wallListCount)).y = currentPos.y;
   47F2 23            [ 6]  896 	inc	hl
   47F3 4D            [ 4]  897 	ld	c,l
   47F4 44            [ 4]  898 	ld	b,h
   47F5 DD 6E F9      [19]  899 	ld	l,-7 (ix)
   47F8 DD 66 FA      [19]  900 	ld	h,-6 (ix)
   47FB 7E            [ 7]  901 	ld	a,(hl)
   47FC 02            [ 7]  902 	ld	(bc),a
   47FD C3 19 46      [10]  903 	jp	00161$
   4800                     904 00171$:
   4800 DD F9         [10]  905 	ld	sp, ix
   4802 DD E1         [14]  906 	pop	ix
   4804 C9            [10]  907 	ret
                            908 ;src/Map.c:210: void generate_exit_door(){
                            909 ;	---------------------------------
                            910 ; Function generate_exit_door
                            911 ; ---------------------------------
   4805                     912 _generate_exit_door::
   4805 DD E5         [15]  913 	push	ix
   4807 DD 21 00 00   [14]  914 	ld	ix,#0
   480B DD 39         [15]  915 	add	ix,sp
   480D 21 F4 FF      [10]  916 	ld	hl,#-12
   4810 39            [11]  917 	add	hl,sp
   4811 F9            [ 6]  918 	ld	sp,hl
                            919 ;src/Map.c:211: u8 x=(cpct_getRandom_lcg_u8()%32);
   4812 CD A2 75      [17]  920 	call	_cpct_getRandom_lcg_u8
   4815 7D            [ 4]  921 	ld	a,l
   4816 E6 1F         [ 7]  922 	and	a, #0x1F
   4818 4F            [ 4]  923 	ld	c,a
                            924 ;src/Map.c:212: u8 y=(cpct_getRandom_lcg_u8()%32);
   4819 C5            [11]  925 	push	bc
   481A CD A2 75      [17]  926 	call	_cpct_getRandom_lcg_u8
   481D C1            [10]  927 	pop	bc
   481E 7D            [ 4]  928 	ld	a,l
   481F E6 1F         [ 7]  929 	and	a, #0x1F
   4821 5F            [ 4]  930 	ld	e,a
                            931 ;src/Map.c:213: u8 door_not_positioned=1;
   4822 DD 36 F6 01   [19]  932 	ld	-10 (ix),#0x01
                            933 ;src/Map.c:220: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
   4826 06 00         [ 7]  934 	ld	b,#0x00
   4828 21 40 00      [10]  935 	ld	hl,#0x0040
   482B 09            [11]  936 	add	hl,bc
   482C 4D            [ 4]  937 	ld	c,l
   482D 44            [ 4]  938 	ld	b,h
   482E 6B            [ 4]  939 	ld	l,e
   482F 26 00         [ 7]  940 	ld	h,#0x00
   4831 29            [11]  941 	add	hl, hl
   4832 29            [11]  942 	add	hl, hl
   4833 29            [11]  943 	add	hl, hl
   4834 29            [11]  944 	add	hl, hl
   4835 29            [11]  945 	add	hl, hl
   4836 09            [11]  946 	add	hl,bc
   4837 4D            [ 4]  947 	ld	c,l
   4838 44            [ 4]  948 	ld	b,h
                            949 ;src/Map.c:225: lastVal = (position-1);
   4839 59            [ 4]  950 	ld	e,c
   483A 50            [ 4]  951 	ld	d,b
   483B 1B            [ 6]  952 	dec	de
                            953 ;src/Map.c:226: nextVal = (position+1);
   483C 21 01 00      [10]  954 	ld	hl,#0x0001
   483F 09            [11]  955 	add	hl,bc
   4840 DD 75 F7      [19]  956 	ld	-9 (ix),l
   4843 DD 74 F8      [19]  957 	ld	-8 (ix),h
                            958 ;src/Map.c:227: topVal = (position-MAP_WIDTH);
   4846 79            [ 4]  959 	ld	a,c
   4847 C6 E0         [ 7]  960 	add	a,#0xE0
   4849 DD 77 F4      [19]  961 	ld	-12 (ix),a
   484C 78            [ 4]  962 	ld	a,b
   484D CE FF         [ 7]  963 	adc	a,#0xFF
   484F DD 77 F5      [19]  964 	ld	-11 (ix),a
                            965 ;src/Map.c:228: bottomVal = (position+MAP_WIDTH);
   4852 FD 21 20 00   [14]  966 	ld	iy,#0x0020
   4856 FD 09         [15]  967 	add	iy, bc
                            968 ;src/Map.c:230: while(door_not_positioned){
   4858                     969 00138$:
   4858 DD 7E F6      [19]  970 	ld	a,-10 (ix)
   485B B7            [ 4]  971 	or	a, a
   485C CA A9 49      [10]  972 	jp	Z,00141$
                            973 ;src/Map.c:231: if((*position)!=CELLTYPE_FLOOR){
   485F 0A            [ 7]  974 	ld	a,(bc)
   4860 B7            [ 4]  975 	or	a, a
   4861 CA 6E 49      [10]  976 	jp	Z,00135$
                            977 ;src/Map.c:232: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   4864 1A            [ 7]  978 	ld	a,(de)
   4865 DD 77 FB      [19]  979 	ld	-5 (ix),a
   4868 7B            [ 4]  980 	ld	a,e
   4869 D6 40         [ 7]  981 	sub	a, #0x40
   486B 7A            [ 4]  982 	ld	a,d
   486C DE 00         [ 7]  983 	sbc	a, #0x00
   486E 3E 00         [ 7]  984 	ld	a,#0x00
   4870 17            [ 4]  985 	rla
   4871 DD 77 F9      [19]  986 	ld	-7 (ix),a
   4874 DD 7E F7      [19]  987 	ld	a,-9 (ix)
   4877 DD 77 FE      [19]  988 	ld	-2 (ix),a
   487A DD 7E F8      [19]  989 	ld	a,-8 (ix)
   487D DD 77 FF      [19]  990 	ld	-1 (ix),a
                            991 ;src/Map.c:233: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   4880 E1            [10]  992 	pop	hl
   4881 E5            [11]  993 	push	hl
   4882 7E            [ 7]  994 	ld	a,(hl)
   4883 DD 77 FA      [19]  995 	ld	-6 (ix),a
   4886 DD 7E F4      [19]  996 	ld	a,-12 (ix)
   4889 D6 40         [ 7]  997 	sub	a, #0x40
   488B DD 7E F5      [19]  998 	ld	a,-11 (ix)
   488E DE 00         [ 7]  999 	sbc	a, #0x00
   4890 3E 00         [ 7] 1000 	ld	a,#0x00
   4892 17            [ 4] 1001 	rla
   4893 DD 77 FD      [19] 1002 	ld	-3 (ix),a
   4896 FD E5         [15] 1003 	push	iy
   4898 E1            [10] 1004 	pop	hl
                           1005 ;src/Map.c:232: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   4899 DD 7E FE      [19] 1006 	ld	a,-2 (ix)
   489C D6 40         [ 7] 1007 	sub	a, #0x40
   489E DD 7E FF      [19] 1008 	ld	a,-1 (ix)
   48A1 DE 04         [ 7] 1009 	sbc	a, #0x04
   48A3 3E 00         [ 7] 1010 	ld	a,#0x00
   48A5 17            [ 4] 1011 	rla
   48A6 DD 77 FE      [19] 1012 	ld	-2 (ix),a
                           1013 ;src/Map.c:233: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   48A9 7D            [ 4] 1014 	ld	a,l
   48AA D6 40         [ 7] 1015 	sub	a, #0x40
   48AC 7C            [ 4] 1016 	ld	a,h
   48AD DE 04         [ 7] 1017 	sbc	a, #0x04
   48AF 3E 00         [ 7] 1018 	ld	a,#0x00
   48B1 17            [ 4] 1019 	rla
   48B2 DD 77 FC      [19] 1020 	ld	-4 (ix),a
                           1021 ;src/Map.c:232: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   48B5 DD 7E FB      [19] 1022 	ld	a,-5 (ix)
   48B8 B7            [ 4] 1023 	or	a, a
   48B9 20 06         [12] 1024 	jr	NZ,00133$
   48BB DD 7E F9      [19] 1025 	ld	a,-7 (ix)
   48BE B7            [ 4] 1026 	or	a, a
   48BF 28 52         [12] 1027 	jr	Z,00129$
   48C1                    1028 00133$:
   48C1 DD 6E F7      [19] 1029 	ld	l,-9 (ix)
   48C4 DD 66 F8      [19] 1030 	ld	h,-8 (ix)
   48C7 7E            [ 7] 1031 	ld	a,(hl)
   48C8 B7            [ 4] 1032 	or	a, a
   48C9 20 06         [12] 1033 	jr	NZ,00128$
   48CB DD CB FE 46   [20] 1034 	bit	0,-2 (ix)
   48CF 20 42         [12] 1035 	jr	NZ,00129$
   48D1                    1036 00128$:
                           1037 ;src/Map.c:233: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   48D1 FD 6E 00      [19] 1038 	ld	l, 0 (iy)
   48D4 DD 7E FA      [19] 1039 	ld	a,-6 (ix)
   48D7 B7            [ 4] 1040 	or	a, a
   48D8 20 06         [12] 1041 	jr	NZ,00111$
   48DA DD 7E FD      [19] 1042 	ld	a,-3 (ix)
   48DD B7            [ 4] 1043 	or	a, a
   48DE 28 14         [12] 1044 	jr	Z,00107$
   48E0                    1045 00111$:
   48E0 7D            [ 4] 1046 	ld	a,l
   48E1 B7            [ 4] 1047 	or	a, a
   48E2 20 10         [12] 1048 	jr	NZ,00107$
   48E4 DD 7E FC      [19] 1049 	ld	a,-4 (ix)
   48E7 B7            [ 4] 1050 	or	a, a
   48E8 28 0A         [12] 1051 	jr	Z,00107$
                           1052 ;src/Map.c:234: door_not_positioned=0;
   48EA DD 36 F6 00   [19] 1053 	ld	-10 (ix),#0x00
                           1054 ;src/Map.c:235: *position=CELLTYPE_DOOR;
   48EE 3E 80         [ 7] 1055 	ld	a,#0x80
   48F0 02            [ 7] 1056 	ld	(bc),a
   48F1 C3 6E 49      [10] 1057 	jp	00135$
   48F4                    1058 00107$:
                           1059 ;src/Map.c:237: else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
   48F4 7D            [ 4] 1060 	ld	a,l
   48F5 B7            [ 4] 1061 	or	a, a
   48F6 20 06         [12] 1062 	jr	NZ,00105$
   48F8 DD 7E FC      [19] 1063 	ld	a,-4 (ix)
   48FB B7            [ 4] 1064 	or	a, a
   48FC 20 70         [12] 1065 	jr	NZ,00135$
   48FE                    1066 00105$:
   48FE DD 7E FA      [19] 1067 	ld	a,-6 (ix)
   4901 B7            [ 4] 1068 	or	a, a
   4902 20 6A         [12] 1069 	jr	NZ,00135$
   4904 DD 7E FD      [19] 1070 	ld	a,-3 (ix)
   4907 B7            [ 4] 1071 	or	a, a
   4908 20 64         [12] 1072 	jr	NZ,00135$
                           1073 ;src/Map.c:238: door_not_positioned=0;
   490A DD 36 F6 00   [19] 1074 	ld	-10 (ix),#0x00
                           1075 ;src/Map.c:239: *position=CELLTYPE_DOOR;
   490E 3E 80         [ 7] 1076 	ld	a,#0x80
   4910 02            [ 7] 1077 	ld	(bc),a
   4911 18 5B         [12] 1078 	jr	00135$
   4913                    1079 00129$:
                           1080 ;src/Map.c:242: else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
   4913 DD 7E FA      [19] 1081 	ld	a,-6 (ix)
   4916 B7            [ 4] 1082 	or	a, a
   4917 20 06         [12] 1083 	jr	NZ,00127$
   4919 DD 7E FD      [19] 1084 	ld	a,-3 (ix)
   491C B7            [ 4] 1085 	or	a, a
   491D 28 4F         [12] 1086 	jr	Z,00135$
   491F                    1087 00127$:
   491F FD 7E 00      [19] 1088 	ld	a, 0 (iy)
   4922 B7            [ 4] 1089 	or	a, a
   4923 20 06         [12] 1090 	jr	NZ,00123$
   4925 DD 7E FC      [19] 1091 	ld	a,-4 (ix)
   4928 B7            [ 4] 1092 	or	a, a
   4929 20 43         [12] 1093 	jr	NZ,00135$
   492B                    1094 00123$:
                           1095 ;src/Map.c:232: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   492B DD 6E F7      [19] 1096 	ld	l,-9 (ix)
   492E DD 66 F8      [19] 1097 	ld	h,-8 (ix)
   4931 6E            [ 7] 1098 	ld	l,(hl)
                           1099 ;src/Map.c:243: if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
   4932 DD 7E FB      [19] 1100 	ld	a,-5 (ix)
   4935 B7            [ 4] 1101 	or	a, a
   4936 20 06         [12] 1102 	jr	NZ,00122$
   4938 DD 7E F9      [19] 1103 	ld	a,-7 (ix)
   493B B7            [ 4] 1104 	or	a, a
   493C 28 13         [12] 1105 	jr	Z,00118$
   493E                    1106 00122$:
   493E 7D            [ 4] 1107 	ld	a,l
   493F B7            [ 4] 1108 	or	a, a
   4940 20 0F         [12] 1109 	jr	NZ,00118$
   4942 DD CB FE 46   [20] 1110 	bit	0,-2 (ix)
   4946 28 09         [12] 1111 	jr	Z,00118$
                           1112 ;src/Map.c:244: door_not_positioned=0;
   4948 DD 36 F6 00   [19] 1113 	ld	-10 (ix),#0x00
                           1114 ;src/Map.c:245: *position=CELLTYPE_DOOR;
   494C 3E 80         [ 7] 1115 	ld	a,#0x80
   494E 02            [ 7] 1116 	ld	(bc),a
   494F 18 1D         [12] 1117 	jr	00135$
   4951                    1118 00118$:
                           1119 ;src/Map.c:247: else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
   4951 7D            [ 4] 1120 	ld	a,l
   4952 B7            [ 4] 1121 	or	a, a
   4953 20 06         [12] 1122 	jr	NZ,00116$
   4955 DD CB FE 46   [20] 1123 	bit	0,-2 (ix)
   4959 20 13         [12] 1124 	jr	NZ,00135$
   495B                    1125 00116$:
   495B DD 7E FB      [19] 1126 	ld	a,-5 (ix)
   495E B7            [ 4] 1127 	or	a, a
   495F 20 0D         [12] 1128 	jr	NZ,00135$
   4961 DD 7E F9      [19] 1129 	ld	a,-7 (ix)
   4964 B7            [ 4] 1130 	or	a, a
   4965 20 07         [12] 1131 	jr	NZ,00135$
                           1132 ;src/Map.c:248: door_not_positioned=0;
   4967 DD 36 F6 00   [19] 1133 	ld	-10 (ix),#0x00
                           1134 ;src/Map.c:249: *position=CELLTYPE_DOOR;
   496B 3E 80         [ 7] 1135 	ld	a,#0x80
   496D 02            [ 7] 1136 	ld	(bc),a
   496E                    1137 00135$:
                           1138 ;src/Map.c:253: ++position;
   496E 03            [ 6] 1139 	inc	bc
                           1140 ;src/Map.c:254: ++lastVal;
   496F 13            [ 6] 1141 	inc	de
                           1142 ;src/Map.c:255: ++nextVal;
   4970 DD 34 F7      [23] 1143 	inc	-9 (ix)
   4973 20 03         [12] 1144 	jr	NZ,00223$
   4975 DD 34 F8      [23] 1145 	inc	-8 (ix)
   4978                    1146 00223$:
                           1147 ;src/Map.c:256: ++topVal;
   4978 DD 34 F4      [23] 1148 	inc	-12 (ix)
   497B 20 03         [12] 1149 	jr	NZ,00224$
   497D DD 34 F5      [23] 1150 	inc	-11 (ix)
   4980                    1151 00224$:
                           1152 ;src/Map.c:257: ++bottomVal;
   4980 FD 23         [10] 1153 	inc	iy
                           1154 ;src/Map.c:258: if(position==END_OF_MAP_MEM){
   4982 69            [ 4] 1155 	ld	l, c
   4983 60            [ 4] 1156 	ld	h, b
   4984 7D            [ 4] 1157 	ld	a,l
   4985 D6 40         [ 7] 1158 	sub	a, #0x40
   4987 C2 58 48      [10] 1159 	jp	NZ,00138$
   498A 7C            [ 4] 1160 	ld	a,h
   498B D6 04         [ 7] 1161 	sub	a, #0x04
   498D C2 58 48      [10] 1162 	jp	NZ,00138$
                           1163 ;src/Map.c:259: position = MAP_MEM;
   4990 01 40 00      [10] 1164 	ld	bc,#0x0040
                           1165 ;src/Map.c:260: lastVal = (position-1);
   4993 11 3F 00      [10] 1166 	ld	de,#0x003F
                           1167 ;src/Map.c:261: nextVal = (position+1);
   4996 DD 36 F7 41   [19] 1168 	ld	-9 (ix),#0x41
   499A DD 36 F8 00   [19] 1169 	ld	-8 (ix),#0x00
                           1170 ;src/Map.c:262: topVal = (position-MAP_WIDTH);
   499E 21 20 00      [10] 1171 	ld	hl,#0x0020
   49A1 E3            [19] 1172 	ex	(sp), hl
                           1173 ;src/Map.c:263: bottomVal = (position+MAP_WIDTH);
   49A2 FD 21 60 00   [14] 1174 	ld	iy,#0x0060
   49A6 C3 58 48      [10] 1175 	jp	00138$
   49A9                    1176 00141$:
   49A9 DD F9         [10] 1177 	ld	sp, ix
   49AB DD E1         [14] 1178 	pop	ix
   49AD C9            [10] 1179 	ret
                           1180 ;src/Map.c:269: void generate_level(){
                           1181 ;	---------------------------------
                           1182 ; Function generate_level
                           1183 ; ---------------------------------
   49AE                    1184 _generate_level::
                           1185 ;src/Map.c:270: generate_map();
   49AE CD EA 42      [17] 1186 	call	_generate_map
                           1187 ;src/Map.c:271: generate_exit_door();
   49B1 CD 05 48      [17] 1188 	call	_generate_exit_door
                           1189 ;src/Map.c:272: *(u8*)(MAP_MEM + 5 + MAP_WIDTH*5)=0b00000001;
   49B4 21 E5 00      [10] 1190 	ld	hl,#0x00E5
   49B7 36 01         [10] 1191 	ld	(hl),#0x01
   49B9 C9            [10] 1192 	ret
                           1193 	.area _CODE
                           1194 	.area _INITIALIZER
                           1195 	.area _CABS (ABS)
