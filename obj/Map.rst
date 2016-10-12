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
   5187                      55 _init_generator::
                             56 ;src/Map.c:11: cpct_setSeed_lcg_u8(rand_seed);
   5187 FD 21 91 51   [14]   57 	ld	iy,#_rand_seed
   518B FD 6E 00      [19]   58 	ld	l,0 (iy)
   518E C3 27 8E      [10]   59 	jp  _cpct_setSeed_lcg_u8
   5191                      60 _rand_seed:
   5191 00                   61 	.db #0x00	; 0
                             62 ;src/Map.c:14: u8 get_random_wall(){
                             63 ;	---------------------------------
                             64 ; Function get_random_wall
                             65 ; ---------------------------------
   5192                      66 _get_random_wall::
                             67 ;src/Map.c:15: u8 cellType = cpct_getRandom_lcg_u8();
   5192 CD C2 8E      [17]   68 	call	_cpct_getRandom_lcg_u8
                             69 ;src/Map.c:16: if(cellType&1){
   5195 CB 45         [ 8]   70 	bit	0, l
   5197 28 03         [12]   71 	jr	Z,00108$
                             72 ;src/Map.c:17: return CELLTYPE_WALL1;
   5199 2E 81         [ 7]   73 	ld	l,#0x81
   519B C9            [10]   74 	ret
   519C                      75 00108$:
                             76 ;src/Map.c:20: if(cellType&3){
   519C 7D            [ 4]   77 	ld	a,l
   519D E6 03         [ 7]   78 	and	a, #0x03
   519F 28 03         [12]   79 	jr	Z,00105$
                             80 ;src/Map.c:21: return CELLTYPE_WALL2;
   51A1 2E 82         [ 7]   81 	ld	l,#0x82
   51A3 C9            [10]   82 	ret
   51A4                      83 00105$:
                             84 ;src/Map.c:24: if(cellType&5){
   51A4 7D            [ 4]   85 	ld	a,l
   51A5 E6 05         [ 7]   86 	and	a, #0x05
   51A7 28 03         [12]   87 	jr	Z,00102$
                             88 ;src/Map.c:25: return CELLTYPE_WALL3;
   51A9 2E 83         [ 7]   89 	ld	l,#0x83
   51AB C9            [10]   90 	ret
   51AC                      91 00102$:
                             92 ;src/Map.c:28: return CELLTYPE_WALL4;  
   51AC 2E 84         [ 7]   93 	ld	l,#0x84
   51AE C9            [10]   94 	ret
                             95 ;src/Map.c:34: void generate_map(){
                             96 ;	---------------------------------
                             97 ; Function generate_map
                             98 ; ---------------------------------
   51AF                      99 _generate_map::
   51AF DD E5         [15]  100 	push	ix
   51B1 DD 21 00 00   [14]  101 	ld	ix,#0
   51B5 DD 39         [15]  102 	add	ix,sp
   51B7 21 EB FF      [10]  103 	ld	hl,#-21
   51BA 39            [11]  104 	add	hl,sp
   51BB F9            [ 6]  105 	ld	sp,hl
                            106 ;src/Map.c:37: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
   51BC DD 36 F1 83   [19]  107 	ld	-15 (ix),#0x83
   51C0 DD 36 F2 03   [19]  108 	ld	-14 (ix),#0x03
                            109 ;src/Map.c:43: u16 wallListCount = 0;
   51C4 DD 36 ED 00   [19]  110 	ld	-19 (ix),#0x00
   51C8 DD 36 EE 00   [19]  111 	ld	-18 (ix),#0x00
                            112 ;src/Map.c:44: u16 lastStackItem = 0;
   51CC 21 00 00      [10]  113 	ld	hl,#0x0000
   51CF E3            [19]  114 	ex	(sp), hl
                            115 ;src/Map.c:46: (*cellStack).x = (cpct_getRandom_lcg_u8()%(MAP_WIDTH-2))+1; //RANDOM
   51D0 CD C2 8E      [17]  116 	call	_cpct_getRandom_lcg_u8
   51D3 45            [ 4]  117 	ld	b,l
   51D4 3E 1E         [ 7]  118 	ld	a,#0x1E
   51D6 F5            [11]  119 	push	af
   51D7 33            [ 6]  120 	inc	sp
   51D8 C5            [11]  121 	push	bc
   51D9 33            [ 6]  122 	inc	sp
   51DA CD 83 8D      [17]  123 	call	__moduchar
   51DD F1            [10]  124 	pop	af
   51DE 4D            [ 4]  125 	ld	c,l
   51DF 0C            [ 4]  126 	inc	c
   51E0 21 40 04      [10]  127 	ld	hl,#0x0440
   51E3 71            [ 7]  128 	ld	(hl),c
                            129 ;src/Map.c:47: (*cellStack).y = (cpct_getRandom_lcg_u8()%(MAP_HEIGHT-2))+1; //RANDOM
   51E4 CD C2 8E      [17]  130 	call	_cpct_getRandom_lcg_u8
   51E7 45            [ 4]  131 	ld	b,l
   51E8 3E 1E         [ 7]  132 	ld	a,#0x1E
   51EA F5            [11]  133 	push	af
   51EB 33            [ 6]  134 	inc	sp
   51EC C5            [11]  135 	push	bc
   51ED 33            [ 6]  136 	inc	sp
   51EE CD 83 8D      [17]  137 	call	__moduchar
   51F1 F1            [10]  138 	pop	af
   51F2 4D            [ 4]  139 	ld	c,l
   51F3 0C            [ 4]  140 	inc	c
   51F4 21 41 04      [10]  141 	ld	hl,#0x0441
   51F7 71            [ 7]  142 	ld	(hl),c
                            143 ;src/Map.c:50: *(i8*)&(PLAYER_position.x) = (*cellStack).y;
   51F8 DD 36 FB 7F   [19]  144 	ld	-5 (ix),#<(_PLAYER_position)
   51FC DD 36 FC 58   [19]  145 	ld	-4 (ix),#>(_PLAYER_position)
   5200 2E 41         [ 7]  146 	ld	l, #0x41
   5202 7E            [ 7]  147 	ld	a,(hl)
   5203 DD 77 FD      [19]  148 	ld	-3 (ix),a
   5206 DD 6E FB      [19]  149 	ld	l,-5 (ix)
   5209 DD 66 FC      [19]  150 	ld	h,-4 (ix)
   520C DD 7E FD      [19]  151 	ld	a,-3 (ix)
   520F 77            [ 7]  152 	ld	(hl),a
                            153 ;src/Map.c:51: *(i8*)&(PLAYER_position.y) = (*cellStack).x;
   5210 DD 36 FB 80   [19]  154 	ld	-5 (ix),#<((_PLAYER_position + 0x0001))
   5214 DD 36 FC 58   [19]  155 	ld	-4 (ix),#>((_PLAYER_position + 0x0001))
   5218 21 40 04      [10]  156 	ld	hl,#0x0440
   521B 4E            [ 7]  157 	ld	c,(hl)
   521C DD 6E FB      [19]  158 	ld	l,-5 (ix)
   521F DD 66 FC      [19]  159 	ld	h,-4 (ix)
   5222 71            [ 7]  160 	ld	(hl),c
                            161 ;src/Map.c:53: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   5223 21 00 04      [10]  162 	ld	hl,#0x0400
   5226 E5            [11]  163 	push	hl
   5227 3E 87         [ 7]  164 	ld	a,#0x87
   5229 F5            [11]  165 	push	af
   522A 33            [ 6]  166 	inc	sp
   522B 21 40 00      [10]  167 	ld	hl,#0x0040
   522E E5            [11]  168 	push	hl
   522F CD F1 8E      [17]  169 	call	_cpct_memset
                            170 ;src/Map.c:55: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   5232 3A 40 04      [13]  171 	ld	a,(#0x0440)
   5235 DD 77 FD      [19]  172 	ld	-3 (ix), a
   5238 DD 77 FB      [19]  173 	ld	-5 (ix),a
   523B DD 36 FC 00   [19]  174 	ld	-4 (ix),#0x00
   523F 3E 06         [ 7]  175 	ld	a,#0x05+1
   5241 18 08         [12]  176 	jr	00315$
   5243                     177 00314$:
   5243 DD CB FB 26   [23]  178 	sla	-5 (ix)
   5247 DD CB FC 16   [23]  179 	rl	-4 (ix)
   524B                     180 00315$:
   524B 3D            [ 4]  181 	dec	a
   524C 20 F5         [12]  182 	jr	NZ,00314$
   524E DD 7E FB      [19]  183 	ld	a,-5 (ix)
   5251 C6 40         [ 7]  184 	add	a, #0x40
   5253 DD 77 FB      [19]  185 	ld	-5 (ix),a
   5256 DD 7E FC      [19]  186 	ld	a,-4 (ix)
   5259 CE 00         [ 7]  187 	adc	a, #0x00
   525B DD 77 FC      [19]  188 	ld	-4 (ix),a
   525E 21 41 04      [10]  189 	ld	hl,#0x0441
   5261 4E            [ 7]  190 	ld	c,(hl)
   5262 DD 6E FB      [19]  191 	ld	l,-5 (ix)
   5265 DD 66 FC      [19]  192 	ld	h,-4 (ix)
   5268 06 00         [ 7]  193 	ld	b,#0x00
   526A 09            [11]  194 	add	hl, bc
   526B 36 00         [10]  195 	ld	(hl),#0x00
                            196 ;src/Map.c:58: for(i=0;i<MAP_WIDTH;++i){
   526D 0E 00         [ 7]  197 	ld	c,#0x00
   526F                     198 00167$:
                            199 ;src/Map.c:59: map[0][i]=CELLTYPE_WALL1;//get_random_wall();
   526F 21 40 00      [10]  200 	ld	hl,#0x0040
   5272 06 00         [ 7]  201 	ld	b,#0x00
   5274 09            [11]  202 	add	hl, bc
   5275 36 81         [10]  203 	ld	(hl),#0x81
                            204 ;src/Map.c:60: map[MAP_HEIGHT-1][i]=CELLTYPE_WALL1;//get_random_wall();
   5277 21 20 04      [10]  205 	ld	hl,#0x0420
   527A 06 00         [ 7]  206 	ld	b,#0x00
   527C 09            [11]  207 	add	hl, bc
   527D 36 81         [10]  208 	ld	(hl),#0x81
                            209 ;src/Map.c:58: for(i=0;i<MAP_WIDTH;++i){
   527F 0C            [ 4]  210 	inc	c
   5280 79            [ 4]  211 	ld	a,c
   5281 D6 20         [ 7]  212 	sub	a, #0x20
   5283 38 EA         [12]  213 	jr	C,00167$
                            214 ;src/Map.c:63: for(i=1;i<MAP_HEIGHT-1;++i){
   5285 DD 36 F3 01   [19]  215 	ld	-13 (ix),#0x01
   5289                     216 00169$:
                            217 ;src/Map.c:64: map[i][0]=CELLTYPE_WALL1;//get_random_wall();
   5289 DD 7E F3      [19]  218 	ld	a,-13 (ix)
   528C DD 77 FB      [19]  219 	ld	-5 (ix),a
   528F DD 36 FC 00   [19]  220 	ld	-4 (ix),#0x00
   5293 3E 06         [ 7]  221 	ld	a,#0x05+1
   5295 18 08         [12]  222 	jr	00317$
   5297                     223 00316$:
   5297 DD CB FB 26   [23]  224 	sla	-5 (ix)
   529B DD CB FC 16   [23]  225 	rl	-4 (ix)
   529F                     226 00317$:
   529F 3D            [ 4]  227 	dec	a
   52A0 20 F5         [12]  228 	jr	NZ,00316$
   52A2 DD 7E FB      [19]  229 	ld	a,-5 (ix)
   52A5 C6 40         [ 7]  230 	add	a, #0x40
   52A7 DD 77 FE      [19]  231 	ld	-2 (ix),a
   52AA DD 7E FC      [19]  232 	ld	a,-4 (ix)
   52AD CE 00         [ 7]  233 	adc	a, #0x00
   52AF DD 77 FF      [19]  234 	ld	-1 (ix),a
   52B2 DD 6E FE      [19]  235 	ld	l,-2 (ix)
   52B5 DD 66 FF      [19]  236 	ld	h,-1 (ix)
   52B8 36 81         [10]  237 	ld	(hl),#0x81
                            238 ;src/Map.c:65: map[i][MAP_WIDTH-1]=CELLTYPE_WALL1;//get_random_wall();
   52BA DD 7E FB      [19]  239 	ld	a,-5 (ix)
   52BD C6 40         [ 7]  240 	add	a, #0x40
   52BF DD 77 FE      [19]  241 	ld	-2 (ix),a
   52C2 DD 7E FC      [19]  242 	ld	a,-4 (ix)
   52C5 CE 00         [ 7]  243 	adc	a, #0x00
   52C7 DD 77 FF      [19]  244 	ld	-1 (ix),a
   52CA DD 7E FE      [19]  245 	ld	a,-2 (ix)
   52CD C6 1F         [ 7]  246 	add	a, #0x1F
   52CF DD 77 FE      [19]  247 	ld	-2 (ix),a
   52D2 DD 7E FF      [19]  248 	ld	a,-1 (ix)
   52D5 CE 00         [ 7]  249 	adc	a, #0x00
   52D7 DD 77 FF      [19]  250 	ld	-1 (ix),a
   52DA DD 6E FE      [19]  251 	ld	l,-2 (ix)
   52DD DD 66 FF      [19]  252 	ld	h,-1 (ix)
   52E0 36 81         [10]  253 	ld	(hl),#0x81
                            254 ;src/Map.c:63: for(i=1;i<MAP_HEIGHT-1;++i){
   52E2 DD 34 F3      [23]  255 	inc	-13 (ix)
   52E5 DD 7E F3      [19]  256 	ld	a,-13 (ix)
   52E8 D6 1F         [ 7]  257 	sub	a, #0x1F
   52EA 38 9D         [12]  258 	jr	C,00169$
                            259 ;src/Map.c:68: while(remainingCells>0){
   52EC 21 04 00      [10]  260 	ld	hl,#0x0004
   52EF 39            [11]  261 	add	hl,sp
   52F0 DD 75 FE      [19]  262 	ld	-2 (ix),l
   52F3 DD 74 FF      [19]  263 	ld	-1 (ix),h
   52F6                     264 00164$:
   52F6 DD 7E F2      [19]  265 	ld	a,-14 (ix)
   52F9 DD B6 F1      [19]  266 	or	a,-15 (ix)
   52FC CA C5 56      [10]  267 	jp	Z,00171$
                            268 ;src/Map.c:69: wallListPosition = wallList+wallListCount;
   52FF C1            [10]  269 	pop	bc
   5300 E1            [10]  270 	pop	hl
   5301 E5            [11]  271 	push	hl
   5302 C5            [11]  272 	push	bc
   5303 29            [11]  273 	add	hl, hl
   5304 7D            [ 4]  274 	ld	a,l
   5305 C6 40         [ 7]  275 	add	a, #0x40
   5307 DD 77 FB      [19]  276 	ld	-5 (ix),a
   530A 7C            [ 4]  277 	ld	a,h
   530B CE 08         [ 7]  278 	adc	a, #0x08
   530D DD 77 FC      [19]  279 	ld	-4 (ix),a
                            280 ;src/Map.c:70: while(wallListCount<MAP_SIZE){
   5310 D1            [10]  281 	pop	de
   5311 C1            [10]  282 	pop	bc
   5312 C5            [11]  283 	push	bc
   5313 D5            [11]  284 	push	de
   5314                     285 00134$:
                            286 ;src/Map.c:73: currentPos.y = (*wallListPosition).y;
   5314 DD 7E FE      [19]  287 	ld	a,-2 (ix)
   5317 C6 01         [ 7]  288 	add	a, #0x01
   5319 DD 77 F9      [19]  289 	ld	-7 (ix),a
   531C DD 7E FF      [19]  290 	ld	a,-1 (ix)
   531F CE 00         [ 7]  291 	adc	a, #0x00
   5321 DD 77 FA      [19]  292 	ld	-6 (ix),a
                            293 ;src/Map.c:70: while(wallListCount<MAP_SIZE){
   5324 78            [ 4]  294 	ld	a,b
   5325 D6 04         [ 7]  295 	sub	a, #0x04
   5327 D2 C6 54      [10]  296 	jp	NC,00204$
                            297 ;src/Map.c:72: currentPos.x = (*wallListPosition).x;
   532A 21 04 00      [10]  298 	ld	hl,#0x0004
   532D 39            [11]  299 	add	hl,sp
   532E EB            [ 4]  300 	ex	de,hl
   532F DD 6E FB      [19]  301 	ld	l,-5 (ix)
   5332 DD 66 FC      [19]  302 	ld	h,-4 (ix)
   5335 7E            [ 7]  303 	ld	a,(hl)
   5336 12            [ 7]  304 	ld	(de),a
                            305 ;src/Map.c:73: currentPos.y = (*wallListPosition).y;
   5337 DD 5E FB      [19]  306 	ld	e,-5 (ix)
   533A DD 56 FC      [19]  307 	ld	d,-4 (ix)
   533D 13            [ 6]  308 	inc	de
   533E 1A            [ 7]  309 	ld	a,(de)
   533F DD 6E F9      [19]  310 	ld	l,-7 (ix)
   5342 DD 66 FA      [19]  311 	ld	h,-6 (ix)
   5345 77            [ 7]  312 	ld	(hl),a
                            313 ;src/Map.c:75: convertToFloor=0;
   5346 DD 36 F4 00   [19]  314 	ld	-12 (ix),#0x00
                            315 ;src/Map.c:76: surroundedByWalls=1;
   534A DD 36 F5 01   [19]  316 	ld	-11 (ix),#0x01
                            317 ;src/Map.c:78: if(currentPos.x>0){
   534E DD 6E FE      [19]  318 	ld	l,-2 (ix)
   5351 DD 66 FF      [19]  319 	ld	h,-1 (ix)
   5354 7E            [ 7]  320 	ld	a,(hl)
   5355 DD 77 FD      [19]  321 	ld	-3 (ix),a
                            322 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   5358 DD 6E F9      [19]  323 	ld	l,-7 (ix)
   535B DD 66 FA      [19]  324 	ld	h,-6 (ix)
   535E 7E            [ 7]  325 	ld	a,(hl)
   535F DD 77 F8      [19]  326 	ld	-8 (ix),a
   5362 DD 7E FD      [19]  327 	ld	a,-3 (ix)
   5365 DD 77 F6      [19]  328 	ld	-10 (ix),a
   5368 DD 36 F7 00   [19]  329 	ld	-9 (ix),#0x00
                            330 ;src/Map.c:78: if(currentPos.x>0){
   536C DD 7E FD      [19]  331 	ld	a,-3 (ix)
   536F B7            [ 4]  332 	or	a, a
   5370 28 2F         [12]  333 	jr	Z,00109$
                            334 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   5372 DD 6E F6      [19]  335 	ld	l,-10 (ix)
   5375 DD 66 F7      [19]  336 	ld	h,-9 (ix)
   5378 2B            [ 6]  337 	dec	hl
   5379 29            [11]  338 	add	hl, hl
   537A 29            [11]  339 	add	hl, hl
   537B 29            [11]  340 	add	hl, hl
   537C 29            [11]  341 	add	hl, hl
   537D 29            [11]  342 	add	hl, hl
   537E D5            [11]  343 	push	de
   537F 11 40 00      [10]  344 	ld	de,#0x0040
   5382 19            [11]  345 	add	hl, de
   5383 D1            [10]  346 	pop	de
   5384 7D            [ 4]  347 	ld	a,l
   5385 DD 86 F8      [19]  348 	add	a, -8 (ix)
   5388 6F            [ 4]  349 	ld	l,a
   5389 7C            [ 4]  350 	ld	a,h
   538A CE 00         [ 7]  351 	adc	a, #0x00
   538C 67            [ 4]  352 	ld	h,a
   538D 6E            [ 7]  353 	ld	l,(hl)
                            354 ;src/Map.c:80: if(adjacentType == CELLTYPE_UNDEFINED){
   538E 7D            [ 4]  355 	ld	a,l
   538F D6 87         [ 7]  356 	sub	a, #0x87
   5391 20 06         [12]  357 	jr	NZ,00106$
                            358 ;src/Map.c:81: convertToFloor  = 1;
   5393 DD 36 F4 01   [19]  359 	ld	-12 (ix),#0x01
   5397 18 08         [12]  360 	jr	00109$
   5399                     361 00106$:
                            362 ;src/Map.c:83: else if(adjacentType == CELLTYPE_FLOOR){
   5399 7D            [ 4]  363 	ld	a,l
   539A B7            [ 4]  364 	or	a, a
   539B 20 04         [12]  365 	jr	NZ,00109$
                            366 ;src/Map.c:84: surroundedByWalls = 0;
   539D DD 36 F5 00   [19]  367 	ld	-11 (ix),#0x00
   53A1                     368 00109$:
                            369 ;src/Map.c:87: if(currentPos.x < (MAP_WIDTH-1)){
   53A1 DD 7E FD      [19]  370 	ld	a,-3 (ix)
   53A4 D6 1F         [ 7]  371 	sub	a, #0x1F
   53A6 30 2F         [12]  372 	jr	NC,00116$
                            373 ;src/Map.c:89: adjacentType = map[currentPos.x+1][currentPos.y];
   53A8 DD 6E F6      [19]  374 	ld	l,-10 (ix)
   53AB DD 66 F7      [19]  375 	ld	h,-9 (ix)
   53AE 23            [ 6]  376 	inc	hl
   53AF 29            [11]  377 	add	hl, hl
   53B0 29            [11]  378 	add	hl, hl
   53B1 29            [11]  379 	add	hl, hl
   53B2 29            [11]  380 	add	hl, hl
   53B3 29            [11]  381 	add	hl, hl
   53B4 D5            [11]  382 	push	de
   53B5 11 40 00      [10]  383 	ld	de,#0x0040
   53B8 19            [11]  384 	add	hl, de
   53B9 D1            [10]  385 	pop	de
   53BA 7D            [ 4]  386 	ld	a,l
   53BB DD 86 F8      [19]  387 	add	a, -8 (ix)
   53BE 6F            [ 4]  388 	ld	l,a
   53BF 7C            [ 4]  389 	ld	a,h
   53C0 CE 00         [ 7]  390 	adc	a, #0x00
   53C2 67            [ 4]  391 	ld	h,a
   53C3 6E            [ 7]  392 	ld	l,(hl)
                            393 ;src/Map.c:90: if(adjacentType == CELLTYPE_UNDEFINED){
   53C4 7D            [ 4]  394 	ld	a,l
   53C5 D6 87         [ 7]  395 	sub	a, #0x87
   53C7 20 06         [12]  396 	jr	NZ,00113$
                            397 ;src/Map.c:91: convertToFloor  = 1;
   53C9 DD 36 F4 01   [19]  398 	ld	-12 (ix),#0x01
   53CD 18 08         [12]  399 	jr	00116$
   53CF                     400 00113$:
                            401 ;src/Map.c:93: else if(adjacentType == CELLTYPE_FLOOR){
   53CF 7D            [ 4]  402 	ld	a,l
   53D0 B7            [ 4]  403 	or	a, a
   53D1 20 04         [12]  404 	jr	NZ,00116$
                            405 ;src/Map.c:94: surroundedByWalls = 0;
   53D3 DD 36 F5 00   [19]  406 	ld	-11 (ix),#0x00
   53D7                     407 00116$:
                            408 ;src/Map.c:99: adjacentType = map[currentPos.x][currentPos.y-1];
   53D7 DD 6E F6      [19]  409 	ld	l,-10 (ix)
   53DA DD 66 F7      [19]  410 	ld	h,-9 (ix)
   53DD 29            [11]  411 	add	hl, hl
   53DE 29            [11]  412 	add	hl, hl
   53DF 29            [11]  413 	add	hl, hl
   53E0 29            [11]  414 	add	hl, hl
   53E1 29            [11]  415 	add	hl, hl
   53E2 7D            [ 4]  416 	ld	a,l
   53E3 C6 40         [ 7]  417 	add	a, #0x40
   53E5 DD 77 F6      [19]  418 	ld	-10 (ix),a
   53E8 7C            [ 4]  419 	ld	a,h
   53E9 CE 00         [ 7]  420 	adc	a, #0x00
   53EB DD 77 F7      [19]  421 	ld	-9 (ix),a
                            422 ;src/Map.c:97: if(currentPos.y > 0){
   53EE DD 7E F8      [19]  423 	ld	a,-8 (ix)
   53F1 B7            [ 4]  424 	or	a, a
   53F2 28 23         [12]  425 	jr	Z,00123$
                            426 ;src/Map.c:99: adjacentType = map[currentPos.x][currentPos.y-1];
   53F4 DD 6E F8      [19]  427 	ld	l,-8 (ix)
   53F7 2D            [ 4]  428 	dec	l
   53F8 DD 7E F6      [19]  429 	ld	a,-10 (ix)
   53FB 85            [ 4]  430 	add	a, l
   53FC 6F            [ 4]  431 	ld	l,a
   53FD DD 7E F7      [19]  432 	ld	a,-9 (ix)
   5400 CE 00         [ 7]  433 	adc	a, #0x00
   5402 67            [ 4]  434 	ld	h,a
   5403 6E            [ 7]  435 	ld	l,(hl)
                            436 ;src/Map.c:100: if(adjacentType == CELLTYPE_UNDEFINED){
   5404 7D            [ 4]  437 	ld	a,l
   5405 D6 87         [ 7]  438 	sub	a, #0x87
   5407 20 06         [12]  439 	jr	NZ,00120$
                            440 ;src/Map.c:101: convertToFloor  = 1;
   5409 DD 36 F4 01   [19]  441 	ld	-12 (ix),#0x01
   540D 18 08         [12]  442 	jr	00123$
   540F                     443 00120$:
                            444 ;src/Map.c:103: else if(adjacentType == CELLTYPE_FLOOR){
   540F 7D            [ 4]  445 	ld	a,l
   5410 B7            [ 4]  446 	or	a, a
   5411 20 04         [12]  447 	jr	NZ,00123$
                            448 ;src/Map.c:104: surroundedByWalls = 0;
   5413 DD 36 F5 00   [19]  449 	ld	-11 (ix),#0x00
   5417                     450 00123$:
                            451 ;src/Map.c:107: if(currentPos.y < (MAP_HEIGHT-1)){
   5417 DD 7E F8      [19]  452 	ld	a,-8 (ix)
   541A D6 1F         [ 7]  453 	sub	a, #0x1F
   541C 30 23         [12]  454 	jr	NC,00130$
                            455 ;src/Map.c:109: adjacentType = map[currentPos.x][currentPos.y+1];
   541E DD 6E F8      [19]  456 	ld	l,-8 (ix)
   5421 2C            [ 4]  457 	inc	l
   5422 DD 7E F6      [19]  458 	ld	a,-10 (ix)
   5425 85            [ 4]  459 	add	a, l
   5426 6F            [ 4]  460 	ld	l,a
   5427 DD 7E F7      [19]  461 	ld	a,-9 (ix)
   542A CE 00         [ 7]  462 	adc	a, #0x00
   542C 67            [ 4]  463 	ld	h,a
   542D 6E            [ 7]  464 	ld	l,(hl)
                            465 ;src/Map.c:110: if(adjacentType == CELLTYPE_UNDEFINED){
   542E 7D            [ 4]  466 	ld	a,l
   542F D6 87         [ 7]  467 	sub	a, #0x87
   5431 20 06         [12]  468 	jr	NZ,00127$
                            469 ;src/Map.c:111: convertToFloor  = 1;
   5433 DD 36 F4 01   [19]  470 	ld	-12 (ix),#0x01
   5437 18 08         [12]  471 	jr	00130$
   5439                     472 00127$:
                            473 ;src/Map.c:113: else if(adjacentType == CELLTYPE_FLOOR){
   5439 7D            [ 4]  474 	ld	a,l
   543A B7            [ 4]  475 	or	a, a
   543B 20 04         [12]  476 	jr	NZ,00130$
                            477 ;src/Map.c:114: surroundedByWalls = 0;
   543D DD 36 F5 00   [19]  478 	ld	-11 (ix),#0x00
   5441                     479 00130$:
                            480 ;src/Map.c:118: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   5441 69            [ 4]  481 	ld	l, c
   5442 60            [ 4]  482 	ld	h, b
   5443 29            [11]  483 	add	hl, hl
   5444 FD 21 40 08   [14]  484 	ld	iy,#0x0840
   5448 C5            [11]  485 	push	bc
   5449 4D            [ 4]  486 	ld	c, l
   544A 44            [ 4]  487 	ld	b, h
   544B FD 09         [15]  488 	add	iy, bc
   544D C1            [10]  489 	pop	bc
   544E FD 7E 00      [19]  490 	ld	a, 0 (iy)
   5451 DD 6E FB      [19]  491 	ld	l,-5 (ix)
   5454 DD 66 FC      [19]  492 	ld	h,-4 (ix)
   5457 77            [ 7]  493 	ld	(hl),a
                            494 ;src/Map.c:119: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   5458 FD E5         [15]  495 	push	iy
   545A E1            [10]  496 	pop	hl
   545B 23            [ 6]  497 	inc	hl
   545C 7E            [ 7]  498 	ld	a,(hl)
   545D 12            [ 7]  499 	ld	(de),a
                            500 ;src/Map.c:120: --wallListCount;
   545E 0B            [ 6]  501 	dec	bc
   545F DD 71 ED      [19]  502 	ld	-19 (ix),c
   5462 DD 70 EE      [19]  503 	ld	-18 (ix),b
                            504 ;src/Map.c:123: if((convertToFloor)&&(!surroundedByWalls)){
   5465 DD 7E F4      [19]  505 	ld	a,-12 (ix)
   5468 B7            [ 4]  506 	or	a, a
   5469 28 4A         [12]  507 	jr	Z,00132$
   546B DD 7E F5      [19]  508 	ld	a,-11 (ix)
   546E B7            [ 4]  509 	or	a, a
   546F 20 44         [12]  510 	jr	NZ,00132$
                            511 ;src/Map.c:124: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   5471 DD 6E FE      [19]  512 	ld	l,-2 (ix)
   5474 DD 66 FF      [19]  513 	ld	h,-1 (ix)
   5477 6E            [ 7]  514 	ld	l,(hl)
   5478 26 00         [ 7]  515 	ld	h,#0x00
   547A 29            [11]  516 	add	hl, hl
   547B 29            [11]  517 	add	hl, hl
   547C 29            [11]  518 	add	hl, hl
   547D 29            [11]  519 	add	hl, hl
   547E 29            [11]  520 	add	hl, hl
   547F 01 40 00      [10]  521 	ld	bc,#0x0040
   5482 09            [11]  522 	add	hl,bc
   5483 4D            [ 4]  523 	ld	c,l
   5484 44            [ 4]  524 	ld	b,h
   5485 DD 6E F9      [19]  525 	ld	l,-7 (ix)
   5488 DD 66 FA      [19]  526 	ld	h,-6 (ix)
   548B 6E            [ 7]  527 	ld	l, (hl)
   548C 26 00         [ 7]  528 	ld	h,#0x00
   548E 09            [11]  529 	add	hl,bc
   548F 36 00         [10]  530 	ld	(hl),#0x00
                            531 ;src/Map.c:126: ++lastStackItem;
   5491 DD 34 EB      [23]  532 	inc	-21 (ix)
   5494 20 03         [12]  533 	jr	NZ,00326$
   5496 DD 34 EC      [23]  534 	inc	-20 (ix)
   5499                     535 00326$:
                            536 ;src/Map.c:127: (*(cellStack+lastStackItem)).x = currentPos.x;
   5499 E1            [10]  537 	pop	hl
   549A E5            [11]  538 	push	hl
   549B 29            [11]  539 	add	hl, hl
   549C 01 40 04      [10]  540 	ld	bc, #0x0440
   549F 09            [11]  541 	add	hl,bc
   54A0 4D            [ 4]  542 	ld	c, l
   54A1 44            [ 4]  543 	ld	b, h
   54A2 DD 6E FE      [19]  544 	ld	l,-2 (ix)
   54A5 DD 66 FF      [19]  545 	ld	h,-1 (ix)
   54A8 7E            [ 7]  546 	ld	a,(hl)
   54A9 02            [ 7]  547 	ld	(bc),a
                            548 ;src/Map.c:128: (*(cellStack+lastStackItem)).y = currentPos.y;
   54AA 03            [ 6]  549 	inc	bc
   54AB DD 6E F9      [19]  550 	ld	l,-7 (ix)
   54AE DD 66 FA      [19]  551 	ld	h,-6 (ix)
   54B1 7E            [ 7]  552 	ld	a,(hl)
   54B2 02            [ 7]  553 	ld	(bc),a
                            554 ;src/Map.c:131: break;
   54B3 18 11         [12]  555 	jr	00204$
   54B5                     556 00132$:
                            557 ;src/Map.c:133: --wallListPosition;
   54B5 DD 6E FB      [19]  558 	ld	l,-5 (ix)
   54B8 DD 66 FC      [19]  559 	ld	h,-4 (ix)
   54BB 2B            [ 6]  560 	dec	hl
   54BC 2B            [ 6]  561 	dec	hl
   54BD DD 75 FB      [19]  562 	ld	-5 (ix),l
   54C0 DD 74 FC      [19]  563 	ld	-4 (ix),h
   54C3 C3 14 53      [10]  564 	jp	00134$
                            565 ;src/Map.c:135: while(lastStackItem<MAP_SIZE){
   54C6                     566 00204$:
   54C6 DD 7E F1      [19]  567 	ld	a,-15 (ix)
   54C9 DD 77 F6      [19]  568 	ld	-10 (ix),a
   54CC DD 7E F2      [19]  569 	ld	a,-14 (ix)
   54CF DD 77 F7      [19]  570 	ld	-9 (ix),a
   54D2 DD 7E ED      [19]  571 	ld	a,-19 (ix)
   54D5 DD 77 FB      [19]  572 	ld	-5 (ix),a
   54D8 DD 7E EE      [19]  573 	ld	a,-18 (ix)
   54DB DD 77 FC      [19]  574 	ld	-4 (ix),a
   54DE                     575 00161$:
   54DE DD 7E EC      [19]  576 	ld	a,-20 (ix)
   54E1 D6 04         [ 7]  577 	sub	a, #0x04
   54E3 D2 F6 52      [10]  578 	jp	NC,00164$
                            579 ;src/Map.c:136: currentPos.x=(*(lastStackItem+cellStack)).x;
   54E6 21 04 00      [10]  580 	ld	hl,#0x0004
   54E9 39            [11]  581 	add	hl,sp
   54EA 4D            [ 4]  582 	ld	c,l
   54EB 44            [ 4]  583 	ld	b,h
   54EC E1            [10]  584 	pop	hl
   54ED E5            [11]  585 	push	hl
   54EE 29            [11]  586 	add	hl, hl
   54EF FD 21 40 04   [14]  587 	ld	iy,#0x0440
   54F3 EB            [ 4]  588 	ex	de,hl
   54F4 FD 19         [15]  589 	add	iy, de
   54F6 FD 7E 00      [19]  590 	ld	a, 0 (iy)
   54F9 02            [ 7]  591 	ld	(bc),a
                            592 ;src/Map.c:137: currentPos.y=(*(lastStackItem+cellStack)).y;
   54FA FD 4E 01      [19]  593 	ld	c,1 (iy)
   54FD DD 6E F9      [19]  594 	ld	l,-7 (ix)
   5500 DD 66 FA      [19]  595 	ld	h,-6 (ix)
   5503 71            [ 7]  596 	ld	(hl),c
                            597 ;src/Map.c:138: --lastStackItem;
   5504 E1            [10]  598 	pop	hl
   5505 E5            [11]  599 	push	hl
   5506 2B            [ 6]  600 	dec	hl
   5507 E3            [19]  601 	ex	(sp), hl
                            602 ;src/Map.c:139: cellType = map[currentPos.x][currentPos.y];
   5508 DD 6E FE      [19]  603 	ld	l,-2 (ix)
   550B DD 66 FF      [19]  604 	ld	h,-1 (ix)
   550E 6E            [ 7]  605 	ld	l,(hl)
   550F 26 00         [ 7]  606 	ld	h,#0x00
   5511 29            [11]  607 	add	hl, hl
   5512 29            [11]  608 	add	hl, hl
   5513 29            [11]  609 	add	hl, hl
   5514 29            [11]  610 	add	hl, hl
   5515 29            [11]  611 	add	hl, hl
   5516 11 40 00      [10]  612 	ld	de,#0x0040
   5519 19            [11]  613 	add	hl,de
   551A 59            [ 4]  614 	ld	e,c
   551B 16 00         [ 7]  615 	ld	d,#0x00
   551D 19            [11]  616 	add	hl,de
   551E 4E            [ 7]  617 	ld	c,(hl)
                            618 ;src/Map.c:141: if(cellType == CELLTYPE_UNDEFINED){
   551F 79            [ 4]  619 	ld	a,c
   5520 D6 87         [ 7]  620 	sub	a, #0x87
   5522 20 47         [12]  621 	jr	NZ,00141$
                            622 ;src/Map.c:143: if(cpct_getRandom_lcg_u8()&1){//WALL
   5524 CD C2 8E      [17]  623 	call	_cpct_getRandom_lcg_u8
   5527 CB 45         [ 8]  624 	bit	0, l
   5529 28 06         [12]  625 	jr	Z,00138$
                            626 ;src/Map.c:144: cellType = get_random_wall();
   552B CD 92 51      [17]  627 	call	_get_random_wall
   552E 4D            [ 4]  628 	ld	c,l
   552F 18 02         [12]  629 	jr	00139$
   5531                     630 00138$:
                            631 ;src/Map.c:147: cellType = CELLTYPE_FLOOR;
   5531 0E 00         [ 7]  632 	ld	c,#0x00
   5533                     633 00139$:
                            634 ;src/Map.c:149: map[currentPos.x][currentPos.y]=cellType;
   5533 DD 6E FE      [19]  635 	ld	l,-2 (ix)
   5536 DD 66 FF      [19]  636 	ld	h,-1 (ix)
   5539 6E            [ 7]  637 	ld	l,(hl)
   553A 26 00         [ 7]  638 	ld	h,#0x00
   553C 29            [11]  639 	add	hl, hl
   553D 29            [11]  640 	add	hl, hl
   553E 29            [11]  641 	add	hl, hl
   553F 29            [11]  642 	add	hl, hl
   5540 29            [11]  643 	add	hl, hl
   5541 EB            [ 4]  644 	ex	de,hl
   5542 21 40 00      [10]  645 	ld	hl,#0x0040
   5545 19            [11]  646 	add	hl,de
   5546 EB            [ 4]  647 	ex	de,hl
   5547 DD 6E F9      [19]  648 	ld	l,-7 (ix)
   554A DD 66 FA      [19]  649 	ld	h,-6 (ix)
   554D 6E            [ 7]  650 	ld	l, (hl)
   554E 26 00         [ 7]  651 	ld	h,#0x00
   5550 19            [11]  652 	add	hl,de
   5551 71            [ 7]  653 	ld	(hl),c
                            654 ;src/Map.c:150: --remainingCells;
   5552 DD 6E F6      [19]  655 	ld	l,-10 (ix)
   5555 DD 66 F7      [19]  656 	ld	h,-9 (ix)
   5558 2B            [ 6]  657 	dec	hl
   5559 DD 75 F6      [19]  658 	ld	-10 (ix),l
   555C DD 74 F7      [19]  659 	ld	-9 (ix),h
   555F DD 7E F6      [19]  660 	ld	a,-10 (ix)
   5562 DD 77 F1      [19]  661 	ld	-15 (ix),a
   5565 DD 7E F7      [19]  662 	ld	a,-9 (ix)
   5568 DD 77 F2      [19]  663 	ld	-14 (ix),a
   556B                     664 00141$:
                            665 ;src/Map.c:78: if(currentPos.x>0){
   556B DD 6E FE      [19]  666 	ld	l,-2 (ix)
   556E DD 66 FF      [19]  667 	ld	h,-1 (ix)
   5571 7E            [ 7]  668 	ld	a,(hl)
   5572 DD 77 F8      [19]  669 	ld	-8 (ix),a
                            670 ;src/Map.c:153: if((cellType == CELLTYPE_FLOOR)){
   5575 79            [ 4]  671 	ld	a,c
   5576 B7            [ 4]  672 	or	a, a
   5577 C2 94 56      [10]  673 	jp	NZ,00159$
                            674 ;src/Map.c:154: if(currentPos.x>0){
   557A DD 7E F8      [19]  675 	ld	a,-8 (ix)
   557D B7            [ 4]  676 	or	a, a
   557E 28 3F         [12]  677 	jr	Z,00145$
                            678 ;src/Map.c:155: adjacentType = map[currentPos.x-1][currentPos.y];
   5580 DD 6E F8      [19]  679 	ld	l,-8 (ix)
   5583 26 00         [ 7]  680 	ld	h,#0x00
   5585 2B            [ 6]  681 	dec	hl
   5586 29            [11]  682 	add	hl, hl
   5587 29            [11]  683 	add	hl, hl
   5588 29            [11]  684 	add	hl, hl
   5589 29            [11]  685 	add	hl, hl
   558A 29            [11]  686 	add	hl, hl
   558B 01 40 00      [10]  687 	ld	bc,#0x0040
   558E 09            [11]  688 	add	hl,bc
   558F 4D            [ 4]  689 	ld	c,l
   5590 44            [ 4]  690 	ld	b,h
   5591 DD 6E F9      [19]  691 	ld	l,-7 (ix)
   5594 DD 66 FA      [19]  692 	ld	h,-6 (ix)
   5597 6E            [ 7]  693 	ld	l, (hl)
   5598 26 00         [ 7]  694 	ld	h,#0x00
   559A 09            [11]  695 	add	hl,bc
   559B 7E            [ 7]  696 	ld	a,(hl)
                            697 ;src/Map.c:156: if(adjacentType == CELLTYPE_UNDEFINED){
   559C D6 87         [ 7]  698 	sub	a, #0x87
   559E 20 1F         [12]  699 	jr	NZ,00145$
                            700 ;src/Map.c:158: ++lastStackItem;
   55A0 DD 34 EB      [23]  701 	inc	-21 (ix)
   55A3 20 03         [12]  702 	jr	NZ,00332$
   55A5 DD 34 EC      [23]  703 	inc	-20 (ix)
   55A8                     704 00332$:
                            705 ;src/Map.c:159: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   55A8 E1            [10]  706 	pop	hl
   55A9 E5            [11]  707 	push	hl
   55AA 29            [11]  708 	add	hl, hl
   55AB 01 40 04      [10]  709 	ld	bc,#0x0440
   55AE 09            [11]  710 	add	hl,bc
   55AF DD 4E F8      [19]  711 	ld	c,-8 (ix)
   55B2 0D            [ 4]  712 	dec	c
   55B3 71            [ 7]  713 	ld	(hl),c
                            714 ;src/Map.c:160: (*(cellStack+lastStackItem)).y = currentPos.y;
   55B4 23            [ 6]  715 	inc	hl
   55B5 4D            [ 4]  716 	ld	c,l
   55B6 44            [ 4]  717 	ld	b,h
   55B7 DD 6E F9      [19]  718 	ld	l,-7 (ix)
   55BA DD 66 FA      [19]  719 	ld	h,-6 (ix)
   55BD 7E            [ 7]  720 	ld	a,(hl)
   55BE 02            [ 7]  721 	ld	(bc),a
   55BF                     722 00145$:
                            723 ;src/Map.c:164: if(currentPos.x < (MAP_WIDTH-1)){
   55BF DD 6E FE      [19]  724 	ld	l,-2 (ix)
   55C2 DD 66 FF      [19]  725 	ld	h,-1 (ix)
   55C5 4E            [ 7]  726 	ld	c,(hl)
   55C6 79            [ 4]  727 	ld	a,c
   55C7 D6 1F         [ 7]  728 	sub	a, #0x1F
   55C9 30 3A         [12]  729 	jr	NC,00149$
                            730 ;src/Map.c:166: adjacentType = map[currentPos.x+1][currentPos.y];
   55CB 69            [ 4]  731 	ld	l,c
   55CC 26 00         [ 7]  732 	ld	h,#0x00
   55CE 23            [ 6]  733 	inc	hl
   55CF 29            [11]  734 	add	hl, hl
   55D0 29            [11]  735 	add	hl, hl
   55D1 29            [11]  736 	add	hl, hl
   55D2 29            [11]  737 	add	hl, hl
   55D3 29            [11]  738 	add	hl, hl
   55D4 EB            [ 4]  739 	ex	de,hl
   55D5 21 40 00      [10]  740 	ld	hl,#0x0040
   55D8 19            [11]  741 	add	hl,de
   55D9 EB            [ 4]  742 	ex	de,hl
   55DA DD 6E F9      [19]  743 	ld	l,-7 (ix)
   55DD DD 66 FA      [19]  744 	ld	h,-6 (ix)
   55E0 6E            [ 7]  745 	ld	l, (hl)
   55E1 26 00         [ 7]  746 	ld	h,#0x00
   55E3 19            [11]  747 	add	hl,de
   55E4 7E            [ 7]  748 	ld	a,(hl)
                            749 ;src/Map.c:167: if(adjacentType == CELLTYPE_UNDEFINED){
   55E5 D6 87         [ 7]  750 	sub	a, #0x87
   55E7 20 1C         [12]  751 	jr	NZ,00149$
                            752 ;src/Map.c:170: ++lastStackItem;
   55E9 DD 34 EB      [23]  753 	inc	-21 (ix)
   55EC 20 03         [12]  754 	jr	NZ,00335$
   55EE DD 34 EC      [23]  755 	inc	-20 (ix)
   55F1                     756 00335$:
                            757 ;src/Map.c:171: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   55F1 E1            [10]  758 	pop	hl
   55F2 E5            [11]  759 	push	hl
   55F3 29            [11]  760 	add	hl, hl
   55F4 11 40 04      [10]  761 	ld	de,#0x0440
   55F7 19            [11]  762 	add	hl,de
   55F8 0C            [ 4]  763 	inc	c
   55F9 71            [ 7]  764 	ld	(hl),c
                            765 ;src/Map.c:172: (*(cellStack+lastStackItem)).y = currentPos.y;
   55FA 23            [ 6]  766 	inc	hl
   55FB 4D            [ 4]  767 	ld	c,l
   55FC 44            [ 4]  768 	ld	b,h
   55FD DD 6E F9      [19]  769 	ld	l,-7 (ix)
   5600 DD 66 FA      [19]  770 	ld	h,-6 (ix)
   5603 7E            [ 7]  771 	ld	a,(hl)
   5604 02            [ 7]  772 	ld	(bc),a
   5605                     773 00149$:
                            774 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   5605 DD 6E F9      [19]  775 	ld	l,-7 (ix)
   5608 DD 66 FA      [19]  776 	ld	h,-6 (ix)
   560B 4E            [ 7]  777 	ld	c,(hl)
                            778 ;src/Map.c:176: if(currentPos.y > 0){
   560C 79            [ 4]  779 	ld	a,c
   560D B7            [ 4]  780 	or	a, a
   560E 28 3A         [12]  781 	jr	Z,00153$
                            782 ;src/Map.c:178: adjacentType = map[currentPos.x][currentPos.y-1];
   5610 DD 6E FE      [19]  783 	ld	l,-2 (ix)
   5613 DD 66 FF      [19]  784 	ld	h,-1 (ix)
   5616 46            [ 7]  785 	ld	b,(hl)
   5617 68            [ 4]  786 	ld	l,b
   5618 26 00         [ 7]  787 	ld	h,#0x00
   561A 29            [11]  788 	add	hl, hl
   561B 29            [11]  789 	add	hl, hl
   561C 29            [11]  790 	add	hl, hl
   561D 29            [11]  791 	add	hl, hl
   561E 29            [11]  792 	add	hl, hl
   561F 11 40 00      [10]  793 	ld	de,#0x0040
   5622 19            [11]  794 	add	hl,de
   5623 0D            [ 4]  795 	dec	c
   5624 59            [ 4]  796 	ld	e,c
   5625 16 00         [ 7]  797 	ld	d,#0x00
   5627 19            [11]  798 	add	hl,de
   5628 7E            [ 7]  799 	ld	a,(hl)
                            800 ;src/Map.c:179: if(adjacentType == CELLTYPE_UNDEFINED){
   5629 D6 87         [ 7]  801 	sub	a, #0x87
   562B 20 1D         [12]  802 	jr	NZ,00153$
                            803 ;src/Map.c:182: ++lastStackItem;
   562D DD 34 EB      [23]  804 	inc	-21 (ix)
   5630 20 03         [12]  805 	jr	NZ,00338$
   5632 DD 34 EC      [23]  806 	inc	-20 (ix)
   5635                     807 00338$:
                            808 ;src/Map.c:183: (*(cellStack+lastStackItem)).x = currentPos.x;
   5635 E1            [10]  809 	pop	hl
   5636 E5            [11]  810 	push	hl
   5637 29            [11]  811 	add	hl, hl
   5638 11 40 04      [10]  812 	ld	de,#0x0440
   563B 19            [11]  813 	add	hl,de
   563C 70            [ 7]  814 	ld	(hl),b
                            815 ;src/Map.c:184: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   563D 23            [ 6]  816 	inc	hl
   563E 4D            [ 4]  817 	ld	c,l
   563F 44            [ 4]  818 	ld	b,h
   5640 DD 6E F9      [19]  819 	ld	l,-7 (ix)
   5643 DD 66 FA      [19]  820 	ld	h,-6 (ix)
   5646 5E            [ 7]  821 	ld	e,(hl)
   5647 1D            [ 4]  822 	dec	e
   5648 7B            [ 4]  823 	ld	a,e
   5649 02            [ 7]  824 	ld	(bc),a
   564A                     825 00153$:
                            826 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   564A DD 6E F9      [19]  827 	ld	l,-7 (ix)
   564D DD 66 FA      [19]  828 	ld	h,-6 (ix)
   5650 46            [ 7]  829 	ld	b,(hl)
                            830 ;src/Map.c:188: if(currentPos.y < (MAP_HEIGHT-1)){
   5651 78            [ 4]  831 	ld	a,b
   5652 D6 1F         [ 7]  832 	sub	a, #0x1F
   5654 D2 DE 54      [10]  833 	jp	NC,00161$
                            834 ;src/Map.c:190: adjacentType = map[currentPos.x][currentPos.y+1];
   5657 DD 6E FE      [19]  835 	ld	l,-2 (ix)
   565A DD 66 FF      [19]  836 	ld	h,-1 (ix)
   565D 4E            [ 7]  837 	ld	c,(hl)
   565E 69            [ 4]  838 	ld	l,c
   565F 26 00         [ 7]  839 	ld	h,#0x00
   5661 29            [11]  840 	add	hl, hl
   5662 29            [11]  841 	add	hl, hl
   5663 29            [11]  842 	add	hl, hl
   5664 29            [11]  843 	add	hl, hl
   5665 29            [11]  844 	add	hl, hl
   5666 11 40 00      [10]  845 	ld	de,#0x0040
   5669 19            [11]  846 	add	hl,de
   566A 04            [ 4]  847 	inc	b
   566B 58            [ 4]  848 	ld	e,b
   566C 16 00         [ 7]  849 	ld	d,#0x00
   566E 19            [11]  850 	add	hl,de
   566F 7E            [ 7]  851 	ld	a,(hl)
                            852 ;src/Map.c:191: if(adjacentType == CELLTYPE_UNDEFINED){
   5670 D6 87         [ 7]  853 	sub	a, #0x87
   5672 C2 DE 54      [10]  854 	jp	NZ,00161$
                            855 ;src/Map.c:194: ++lastStackItem;
   5675 DD 34 EB      [23]  856 	inc	-21 (ix)
   5678 20 03         [12]  857 	jr	NZ,00341$
   567A DD 34 EC      [23]  858 	inc	-20 (ix)
   567D                     859 00341$:
                            860 ;src/Map.c:195: (*(cellStack+lastStackItem)).x = currentPos.x;
   567D E1            [10]  861 	pop	hl
   567E E5            [11]  862 	push	hl
   567F 29            [11]  863 	add	hl, hl
   5680 11 40 04      [10]  864 	ld	de,#0x0440
   5683 19            [11]  865 	add	hl,de
   5684 71            [ 7]  866 	ld	(hl),c
                            867 ;src/Map.c:196: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   5685 23            [ 6]  868 	inc	hl
   5686 4D            [ 4]  869 	ld	c,l
   5687 44            [ 4]  870 	ld	b,h
   5688 DD 6E F9      [19]  871 	ld	l,-7 (ix)
   568B DD 66 FA      [19]  872 	ld	h,-6 (ix)
   568E 7E            [ 7]  873 	ld	a,(hl)
   568F 3C            [ 4]  874 	inc	a
   5690 02            [ 7]  875 	ld	(bc),a
   5691 C3 DE 54      [10]  876 	jp	00161$
   5694                     877 00159$:
                            878 ;src/Map.c:202: ++wallListCount;
   5694 DD 34 FB      [23]  879 	inc	-5 (ix)
   5697 20 03         [12]  880 	jr	NZ,00342$
   5699 DD 34 FC      [23]  881 	inc	-4 (ix)
   569C                     882 00342$:
   569C DD 7E FB      [19]  883 	ld	a,-5 (ix)
   569F DD 77 ED      [19]  884 	ld	-19 (ix),a
   56A2 DD 7E FC      [19]  885 	ld	a,-4 (ix)
   56A5 DD 77 EE      [19]  886 	ld	-18 (ix),a
                            887 ;src/Map.c:203: (*(wallList+wallListCount)).x = currentPos.x;
   56A8 DD 6E FB      [19]  888 	ld	l,-5 (ix)
   56AB DD 66 FC      [19]  889 	ld	h,-4 (ix)
   56AE 29            [11]  890 	add	hl, hl
   56AF 01 40 08      [10]  891 	ld	bc,#0x0840
   56B2 09            [11]  892 	add	hl,bc
   56B3 DD 7E F8      [19]  893 	ld	a,-8 (ix)
   56B6 77            [ 7]  894 	ld	(hl),a
                            895 ;src/Map.c:204: (*(wallList+wallListCount)).y = currentPos.y;
   56B7 23            [ 6]  896 	inc	hl
   56B8 4D            [ 4]  897 	ld	c,l
   56B9 44            [ 4]  898 	ld	b,h
   56BA DD 6E F9      [19]  899 	ld	l,-7 (ix)
   56BD DD 66 FA      [19]  900 	ld	h,-6 (ix)
   56C0 7E            [ 7]  901 	ld	a,(hl)
   56C1 02            [ 7]  902 	ld	(bc),a
   56C2 C3 DE 54      [10]  903 	jp	00161$
   56C5                     904 00171$:
   56C5 DD F9         [10]  905 	ld	sp, ix
   56C7 DD E1         [14]  906 	pop	ix
   56C9 C9            [10]  907 	ret
                            908 ;src/Map.c:210: void generate_exit_door(){
                            909 ;	---------------------------------
                            910 ; Function generate_exit_door
                            911 ; ---------------------------------
   56CA                     912 _generate_exit_door::
   56CA DD E5         [15]  913 	push	ix
   56CC DD 21 00 00   [14]  914 	ld	ix,#0
   56D0 DD 39         [15]  915 	add	ix,sp
   56D2 21 F4 FF      [10]  916 	ld	hl,#-12
   56D5 39            [11]  917 	add	hl,sp
   56D6 F9            [ 6]  918 	ld	sp,hl
                            919 ;src/Map.c:211: u8 x=(cpct_getRandom_lcg_u8()%32);
   56D7 CD C2 8E      [17]  920 	call	_cpct_getRandom_lcg_u8
   56DA 7D            [ 4]  921 	ld	a,l
   56DB E6 1F         [ 7]  922 	and	a, #0x1F
   56DD 4F            [ 4]  923 	ld	c,a
                            924 ;src/Map.c:212: u8 y=(cpct_getRandom_lcg_u8()%32);
   56DE C5            [11]  925 	push	bc
   56DF CD C2 8E      [17]  926 	call	_cpct_getRandom_lcg_u8
   56E2 C1            [10]  927 	pop	bc
   56E3 7D            [ 4]  928 	ld	a,l
   56E4 E6 1F         [ 7]  929 	and	a, #0x1F
   56E6 5F            [ 4]  930 	ld	e,a
                            931 ;src/Map.c:213: u8 door_not_positioned=1;
   56E7 DD 36 F6 01   [19]  932 	ld	-10 (ix),#0x01
                            933 ;src/Map.c:220: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
   56EB 06 00         [ 7]  934 	ld	b,#0x00
   56ED 21 40 00      [10]  935 	ld	hl,#0x0040
   56F0 09            [11]  936 	add	hl,bc
   56F1 4D            [ 4]  937 	ld	c,l
   56F2 44            [ 4]  938 	ld	b,h
   56F3 6B            [ 4]  939 	ld	l,e
   56F4 26 00         [ 7]  940 	ld	h,#0x00
   56F6 29            [11]  941 	add	hl, hl
   56F7 29            [11]  942 	add	hl, hl
   56F8 29            [11]  943 	add	hl, hl
   56F9 29            [11]  944 	add	hl, hl
   56FA 29            [11]  945 	add	hl, hl
   56FB 09            [11]  946 	add	hl,bc
   56FC 4D            [ 4]  947 	ld	c,l
   56FD 44            [ 4]  948 	ld	b,h
                            949 ;src/Map.c:225: lastVal = (position-1);
   56FE 59            [ 4]  950 	ld	e,c
   56FF 50            [ 4]  951 	ld	d,b
   5700 1B            [ 6]  952 	dec	de
                            953 ;src/Map.c:226: nextVal = (position+1);
   5701 21 01 00      [10]  954 	ld	hl,#0x0001
   5704 09            [11]  955 	add	hl,bc
   5705 DD 75 F7      [19]  956 	ld	-9 (ix),l
   5708 DD 74 F8      [19]  957 	ld	-8 (ix),h
                            958 ;src/Map.c:227: topVal = (position-MAP_WIDTH);
   570B 79            [ 4]  959 	ld	a,c
   570C C6 E0         [ 7]  960 	add	a,#0xE0
   570E DD 77 F4      [19]  961 	ld	-12 (ix),a
   5711 78            [ 4]  962 	ld	a,b
   5712 CE FF         [ 7]  963 	adc	a,#0xFF
   5714 DD 77 F5      [19]  964 	ld	-11 (ix),a
                            965 ;src/Map.c:228: bottomVal = (position+MAP_WIDTH);
   5717 FD 21 20 00   [14]  966 	ld	iy,#0x0020
   571B FD 09         [15]  967 	add	iy, bc
                            968 ;src/Map.c:230: while(door_not_positioned){
   571D                     969 00138$:
   571D DD 7E F6      [19]  970 	ld	a,-10 (ix)
   5720 B7            [ 4]  971 	or	a, a
   5721 CA 6E 58      [10]  972 	jp	Z,00141$
                            973 ;src/Map.c:231: if((*position)!=CELLTYPE_FLOOR){
   5724 0A            [ 7]  974 	ld	a,(bc)
   5725 B7            [ 4]  975 	or	a, a
   5726 CA 33 58      [10]  976 	jp	Z,00135$
                            977 ;src/Map.c:232: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   5729 1A            [ 7]  978 	ld	a,(de)
   572A DD 77 FB      [19]  979 	ld	-5 (ix),a
   572D 7B            [ 4]  980 	ld	a,e
   572E D6 40         [ 7]  981 	sub	a, #0x40
   5730 7A            [ 4]  982 	ld	a,d
   5731 DE 00         [ 7]  983 	sbc	a, #0x00
   5733 3E 00         [ 7]  984 	ld	a,#0x00
   5735 17            [ 4]  985 	rla
   5736 DD 77 F9      [19]  986 	ld	-7 (ix),a
   5739 DD 7E F7      [19]  987 	ld	a,-9 (ix)
   573C DD 77 FE      [19]  988 	ld	-2 (ix),a
   573F DD 7E F8      [19]  989 	ld	a,-8 (ix)
   5742 DD 77 FF      [19]  990 	ld	-1 (ix),a
                            991 ;src/Map.c:233: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   5745 E1            [10]  992 	pop	hl
   5746 E5            [11]  993 	push	hl
   5747 7E            [ 7]  994 	ld	a,(hl)
   5748 DD 77 FA      [19]  995 	ld	-6 (ix),a
   574B DD 7E F4      [19]  996 	ld	a,-12 (ix)
   574E D6 40         [ 7]  997 	sub	a, #0x40
   5750 DD 7E F5      [19]  998 	ld	a,-11 (ix)
   5753 DE 00         [ 7]  999 	sbc	a, #0x00
   5755 3E 00         [ 7] 1000 	ld	a,#0x00
   5757 17            [ 4] 1001 	rla
   5758 DD 77 FD      [19] 1002 	ld	-3 (ix),a
   575B FD E5         [15] 1003 	push	iy
   575D E1            [10] 1004 	pop	hl
                           1005 ;src/Map.c:232: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   575E DD 7E FE      [19] 1006 	ld	a,-2 (ix)
   5761 D6 40         [ 7] 1007 	sub	a, #0x40
   5763 DD 7E FF      [19] 1008 	ld	a,-1 (ix)
   5766 DE 04         [ 7] 1009 	sbc	a, #0x04
   5768 3E 00         [ 7] 1010 	ld	a,#0x00
   576A 17            [ 4] 1011 	rla
   576B DD 77 FE      [19] 1012 	ld	-2 (ix),a
                           1013 ;src/Map.c:233: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   576E 7D            [ 4] 1014 	ld	a,l
   576F D6 40         [ 7] 1015 	sub	a, #0x40
   5771 7C            [ 4] 1016 	ld	a,h
   5772 DE 04         [ 7] 1017 	sbc	a, #0x04
   5774 3E 00         [ 7] 1018 	ld	a,#0x00
   5776 17            [ 4] 1019 	rla
   5777 DD 77 FC      [19] 1020 	ld	-4 (ix),a
                           1021 ;src/Map.c:232: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   577A DD 7E FB      [19] 1022 	ld	a,-5 (ix)
   577D B7            [ 4] 1023 	or	a, a
   577E 20 06         [12] 1024 	jr	NZ,00133$
   5780 DD 7E F9      [19] 1025 	ld	a,-7 (ix)
   5783 B7            [ 4] 1026 	or	a, a
   5784 28 52         [12] 1027 	jr	Z,00129$
   5786                    1028 00133$:
   5786 DD 6E F7      [19] 1029 	ld	l,-9 (ix)
   5789 DD 66 F8      [19] 1030 	ld	h,-8 (ix)
   578C 7E            [ 7] 1031 	ld	a,(hl)
   578D B7            [ 4] 1032 	or	a, a
   578E 20 06         [12] 1033 	jr	NZ,00128$
   5790 DD CB FE 46   [20] 1034 	bit	0,-2 (ix)
   5794 20 42         [12] 1035 	jr	NZ,00129$
   5796                    1036 00128$:
                           1037 ;src/Map.c:233: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   5796 FD 6E 00      [19] 1038 	ld	l, 0 (iy)
   5799 DD 7E FA      [19] 1039 	ld	a,-6 (ix)
   579C B7            [ 4] 1040 	or	a, a
   579D 20 06         [12] 1041 	jr	NZ,00111$
   579F DD 7E FD      [19] 1042 	ld	a,-3 (ix)
   57A2 B7            [ 4] 1043 	or	a, a
   57A3 28 14         [12] 1044 	jr	Z,00107$
   57A5                    1045 00111$:
   57A5 7D            [ 4] 1046 	ld	a,l
   57A6 B7            [ 4] 1047 	or	a, a
   57A7 20 10         [12] 1048 	jr	NZ,00107$
   57A9 DD 7E FC      [19] 1049 	ld	a,-4 (ix)
   57AC B7            [ 4] 1050 	or	a, a
   57AD 28 0A         [12] 1051 	jr	Z,00107$
                           1052 ;src/Map.c:234: door_not_positioned=0;
   57AF DD 36 F6 00   [19] 1053 	ld	-10 (ix),#0x00
                           1054 ;src/Map.c:235: *position=CELLTYPE_DOOR;
   57B3 3E 80         [ 7] 1055 	ld	a,#0x80
   57B5 02            [ 7] 1056 	ld	(bc),a
   57B6 C3 33 58      [10] 1057 	jp	00135$
   57B9                    1058 00107$:
                           1059 ;src/Map.c:237: else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
   57B9 7D            [ 4] 1060 	ld	a,l
   57BA B7            [ 4] 1061 	or	a, a
   57BB 20 06         [12] 1062 	jr	NZ,00105$
   57BD DD 7E FC      [19] 1063 	ld	a,-4 (ix)
   57C0 B7            [ 4] 1064 	or	a, a
   57C1 20 70         [12] 1065 	jr	NZ,00135$
   57C3                    1066 00105$:
   57C3 DD 7E FA      [19] 1067 	ld	a,-6 (ix)
   57C6 B7            [ 4] 1068 	or	a, a
   57C7 20 6A         [12] 1069 	jr	NZ,00135$
   57C9 DD 7E FD      [19] 1070 	ld	a,-3 (ix)
   57CC B7            [ 4] 1071 	or	a, a
   57CD 20 64         [12] 1072 	jr	NZ,00135$
                           1073 ;src/Map.c:238: door_not_positioned=0;
   57CF DD 36 F6 00   [19] 1074 	ld	-10 (ix),#0x00
                           1075 ;src/Map.c:239: *position=CELLTYPE_DOOR;
   57D3 3E 80         [ 7] 1076 	ld	a,#0x80
   57D5 02            [ 7] 1077 	ld	(bc),a
   57D6 18 5B         [12] 1078 	jr	00135$
   57D8                    1079 00129$:
                           1080 ;src/Map.c:242: else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
   57D8 DD 7E FA      [19] 1081 	ld	a,-6 (ix)
   57DB B7            [ 4] 1082 	or	a, a
   57DC 20 06         [12] 1083 	jr	NZ,00127$
   57DE DD 7E FD      [19] 1084 	ld	a,-3 (ix)
   57E1 B7            [ 4] 1085 	or	a, a
   57E2 28 4F         [12] 1086 	jr	Z,00135$
   57E4                    1087 00127$:
   57E4 FD 7E 00      [19] 1088 	ld	a, 0 (iy)
   57E7 B7            [ 4] 1089 	or	a, a
   57E8 20 06         [12] 1090 	jr	NZ,00123$
   57EA DD 7E FC      [19] 1091 	ld	a,-4 (ix)
   57ED B7            [ 4] 1092 	or	a, a
   57EE 20 43         [12] 1093 	jr	NZ,00135$
   57F0                    1094 00123$:
                           1095 ;src/Map.c:232: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   57F0 DD 6E F7      [19] 1096 	ld	l,-9 (ix)
   57F3 DD 66 F8      [19] 1097 	ld	h,-8 (ix)
   57F6 6E            [ 7] 1098 	ld	l,(hl)
                           1099 ;src/Map.c:243: if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
   57F7 DD 7E FB      [19] 1100 	ld	a,-5 (ix)
   57FA B7            [ 4] 1101 	or	a, a
   57FB 20 06         [12] 1102 	jr	NZ,00122$
   57FD DD 7E F9      [19] 1103 	ld	a,-7 (ix)
   5800 B7            [ 4] 1104 	or	a, a
   5801 28 13         [12] 1105 	jr	Z,00118$
   5803                    1106 00122$:
   5803 7D            [ 4] 1107 	ld	a,l
   5804 B7            [ 4] 1108 	or	a, a
   5805 20 0F         [12] 1109 	jr	NZ,00118$
   5807 DD CB FE 46   [20] 1110 	bit	0,-2 (ix)
   580B 28 09         [12] 1111 	jr	Z,00118$
                           1112 ;src/Map.c:244: door_not_positioned=0;
   580D DD 36 F6 00   [19] 1113 	ld	-10 (ix),#0x00
                           1114 ;src/Map.c:245: *position=CELLTYPE_DOOR;
   5811 3E 80         [ 7] 1115 	ld	a,#0x80
   5813 02            [ 7] 1116 	ld	(bc),a
   5814 18 1D         [12] 1117 	jr	00135$
   5816                    1118 00118$:
                           1119 ;src/Map.c:247: else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
   5816 7D            [ 4] 1120 	ld	a,l
   5817 B7            [ 4] 1121 	or	a, a
   5818 20 06         [12] 1122 	jr	NZ,00116$
   581A DD CB FE 46   [20] 1123 	bit	0,-2 (ix)
   581E 20 13         [12] 1124 	jr	NZ,00135$
   5820                    1125 00116$:
   5820 DD 7E FB      [19] 1126 	ld	a,-5 (ix)
   5823 B7            [ 4] 1127 	or	a, a
   5824 20 0D         [12] 1128 	jr	NZ,00135$
   5826 DD 7E F9      [19] 1129 	ld	a,-7 (ix)
   5829 B7            [ 4] 1130 	or	a, a
   582A 20 07         [12] 1131 	jr	NZ,00135$
                           1132 ;src/Map.c:248: door_not_positioned=0;
   582C DD 36 F6 00   [19] 1133 	ld	-10 (ix),#0x00
                           1134 ;src/Map.c:249: *position=CELLTYPE_DOOR;
   5830 3E 80         [ 7] 1135 	ld	a,#0x80
   5832 02            [ 7] 1136 	ld	(bc),a
   5833                    1137 00135$:
                           1138 ;src/Map.c:253: ++position;
   5833 03            [ 6] 1139 	inc	bc
                           1140 ;src/Map.c:254: ++lastVal;
   5834 13            [ 6] 1141 	inc	de
                           1142 ;src/Map.c:255: ++nextVal;
   5835 DD 34 F7      [23] 1143 	inc	-9 (ix)
   5838 20 03         [12] 1144 	jr	NZ,00223$
   583A DD 34 F8      [23] 1145 	inc	-8 (ix)
   583D                    1146 00223$:
                           1147 ;src/Map.c:256: ++topVal;
   583D DD 34 F4      [23] 1148 	inc	-12 (ix)
   5840 20 03         [12] 1149 	jr	NZ,00224$
   5842 DD 34 F5      [23] 1150 	inc	-11 (ix)
   5845                    1151 00224$:
                           1152 ;src/Map.c:257: ++bottomVal;
   5845 FD 23         [10] 1153 	inc	iy
                           1154 ;src/Map.c:258: if(position==END_OF_MAP_MEM){
   5847 69            [ 4] 1155 	ld	l, c
   5848 60            [ 4] 1156 	ld	h, b
   5849 7D            [ 4] 1157 	ld	a,l
   584A D6 40         [ 7] 1158 	sub	a, #0x40
   584C C2 1D 57      [10] 1159 	jp	NZ,00138$
   584F 7C            [ 4] 1160 	ld	a,h
   5850 D6 04         [ 7] 1161 	sub	a, #0x04
   5852 C2 1D 57      [10] 1162 	jp	NZ,00138$
                           1163 ;src/Map.c:259: position = MAP_MEM;
   5855 01 40 00      [10] 1164 	ld	bc,#0x0040
                           1165 ;src/Map.c:260: lastVal = (position-1);
   5858 11 3F 00      [10] 1166 	ld	de,#0x003F
                           1167 ;src/Map.c:261: nextVal = (position+1);
   585B DD 36 F7 41   [19] 1168 	ld	-9 (ix),#0x41
   585F DD 36 F8 00   [19] 1169 	ld	-8 (ix),#0x00
                           1170 ;src/Map.c:262: topVal = (position-MAP_WIDTH);
   5863 21 20 00      [10] 1171 	ld	hl,#0x0020
   5866 E3            [19] 1172 	ex	(sp), hl
                           1173 ;src/Map.c:263: bottomVal = (position+MAP_WIDTH);
   5867 FD 21 60 00   [14] 1174 	ld	iy,#0x0060
   586B C3 1D 57      [10] 1175 	jp	00138$
   586E                    1176 00141$:
   586E DD F9         [10] 1177 	ld	sp, ix
   5870 DD E1         [14] 1178 	pop	ix
   5872 C9            [10] 1179 	ret
                           1180 ;src/Map.c:269: void generate_level(){
                           1181 ;	---------------------------------
                           1182 ; Function generate_level
                           1183 ; ---------------------------------
   5873                    1184 _generate_level::
                           1185 ;src/Map.c:270: generate_map();
   5873 CD AF 51      [17] 1186 	call	_generate_map
                           1187 ;src/Map.c:271: generate_exit_door();
   5876 CD CA 56      [17] 1188 	call	_generate_exit_door
                           1189 ;src/Map.c:272: *(u8*)(MAP_MEM + 6 + MAP_WIDTH*5)=0b00000001;
   5879 21 E6 00      [10] 1190 	ld	hl,#0x00E6
   587C 36 01         [10] 1191 	ld	(hl),#0x01
   587E C9            [10] 1192 	ret
                           1193 	.area _CODE
                           1194 	.area _INITIALIZER
                           1195 	.area _CABS (ABS)
