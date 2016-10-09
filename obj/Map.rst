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
   417A                      55 _init_generator::
                             56 ;src/Map.c:11: cpct_setSeed_lcg_u8(rand_seed);
   417A FD 21 84 41   [14]   57 	ld	iy,#_rand_seed
   417E FD 6E 00      [19]   58 	ld	l,0 (iy)
   4181 C3 E4 6B      [10]   59 	jp  _cpct_setSeed_lcg_u8
   4184                      60 _rand_seed:
   4184 00                   61 	.db #0x00	; 0
                             62 ;src/Map.c:14: u8 get_random_wall(){
                             63 ;	---------------------------------
                             64 ; Function get_random_wall
                             65 ; ---------------------------------
   4185                      66 _get_random_wall::
                             67 ;src/Map.c:15: u8 cellType = cpct_getRandom_lcg_u8();
   4185 CD 7E 6C      [17]   68 	call	_cpct_getRandom_lcg_u8
                             69 ;src/Map.c:16: if(cellType&1){
   4188 CB 45         [ 8]   70 	bit	0, l
   418A 28 03         [12]   71 	jr	Z,00108$
                             72 ;src/Map.c:17: return CELLTYPE_WALL1;
   418C 2E 81         [ 7]   73 	ld	l,#0x81
   418E C9            [10]   74 	ret
   418F                      75 00108$:
                             76 ;src/Map.c:20: if(cellType&3){
   418F 7D            [ 4]   77 	ld	a,l
   4190 E6 03         [ 7]   78 	and	a, #0x03
   4192 28 03         [12]   79 	jr	Z,00105$
                             80 ;src/Map.c:21: return CELLTYPE_WALL2;
   4194 2E 82         [ 7]   81 	ld	l,#0x82
   4196 C9            [10]   82 	ret
   4197                      83 00105$:
                             84 ;src/Map.c:24: if(cellType&5){
   4197 7D            [ 4]   85 	ld	a,l
   4198 E6 05         [ 7]   86 	and	a, #0x05
   419A 28 03         [12]   87 	jr	Z,00102$
                             88 ;src/Map.c:25: return CELLTYPE_WALL3;
   419C 2E 83         [ 7]   89 	ld	l,#0x83
   419E C9            [10]   90 	ret
   419F                      91 00102$:
                             92 ;src/Map.c:28: return CELLTYPE_WALL4;  
   419F 2E 84         [ 7]   93 	ld	l,#0x84
   41A1 C9            [10]   94 	ret
                             95 ;src/Map.c:34: void generate_map(){
                             96 ;	---------------------------------
                             97 ; Function generate_map
                             98 ; ---------------------------------
   41A2                      99 _generate_map::
   41A2 DD E5         [15]  100 	push	ix
   41A4 DD 21 00 00   [14]  101 	ld	ix,#0
   41A8 DD 39         [15]  102 	add	ix,sp
   41AA 21 EB FF      [10]  103 	ld	hl,#-21
   41AD 39            [11]  104 	add	hl,sp
   41AE F9            [ 6]  105 	ld	sp,hl
                            106 ;src/Map.c:37: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
   41AF DD 36 F1 83   [19]  107 	ld	-15 (ix),#0x83
   41B3 DD 36 F2 03   [19]  108 	ld	-14 (ix),#0x03
                            109 ;src/Map.c:43: u16 wallListCount = 0;
   41B7 DD 36 ED 00   [19]  110 	ld	-19 (ix),#0x00
   41BB DD 36 EE 00   [19]  111 	ld	-18 (ix),#0x00
                            112 ;src/Map.c:44: u16 lastStackItem = 0;
   41BF 21 00 00      [10]  113 	ld	hl,#0x0000
   41C2 E3            [19]  114 	ex	(sp), hl
                            115 ;src/Map.c:46: (*cellStack).x = (cpct_getRandom_lcg_u8()%(MAP_WIDTH-2))+1; //RANDOM
   41C3 CD 7E 6C      [17]  116 	call	_cpct_getRandom_lcg_u8
   41C6 45            [ 4]  117 	ld	b,l
   41C7 3E 1E         [ 7]  118 	ld	a,#0x1E
   41C9 F5            [11]  119 	push	af
   41CA 33            [ 6]  120 	inc	sp
   41CB C5            [11]  121 	push	bc
   41CC 33            [ 6]  122 	inc	sp
   41CD CD CD 6B      [17]  123 	call	__moduchar
   41D0 F1            [10]  124 	pop	af
   41D1 4D            [ 4]  125 	ld	c,l
   41D2 0C            [ 4]  126 	inc	c
   41D3 21 40 29      [10]  127 	ld	hl,#0x2940
   41D6 71            [ 7]  128 	ld	(hl),c
                            129 ;src/Map.c:47: (*cellStack).y = (cpct_getRandom_lcg_u8()%(MAP_HEIGHT-2))+1; //RANDOM
   41D7 CD 7E 6C      [17]  130 	call	_cpct_getRandom_lcg_u8
   41DA 45            [ 4]  131 	ld	b,l
   41DB 3E 1E         [ 7]  132 	ld	a,#0x1E
   41DD F5            [11]  133 	push	af
   41DE 33            [ 6]  134 	inc	sp
   41DF C5            [11]  135 	push	bc
   41E0 33            [ 6]  136 	inc	sp
   41E1 CD CD 6B      [17]  137 	call	__moduchar
   41E4 F1            [10]  138 	pop	af
   41E5 4D            [ 4]  139 	ld	c,l
   41E6 0C            [ 4]  140 	inc	c
   41E7 21 41 29      [10]  141 	ld	hl,#0x2941
   41EA 71            [ 7]  142 	ld	(hl),c
                            143 ;src/Map.c:50: *(i8*)&(PLAYER_position.x) = (*cellStack).y;
   41EB DD 36 FB AC   [19]  144 	ld	-5 (ix),#<(_PLAYER_position)
   41EF DD 36 FC 48   [19]  145 	ld	-4 (ix),#>(_PLAYER_position)
   41F3 2E 41         [ 7]  146 	ld	l, #0x41
   41F5 7E            [ 7]  147 	ld	a,(hl)
   41F6 DD 77 FD      [19]  148 	ld	-3 (ix),a
   41F9 DD 6E FB      [19]  149 	ld	l,-5 (ix)
   41FC DD 66 FC      [19]  150 	ld	h,-4 (ix)
   41FF DD 7E FD      [19]  151 	ld	a,-3 (ix)
   4202 77            [ 7]  152 	ld	(hl),a
                            153 ;src/Map.c:51: *(i8*)&(PLAYER_position.y) = (*cellStack).x;
   4203 DD 36 FB AD   [19]  154 	ld	-5 (ix),#<((_PLAYER_position + 0x0001))
   4207 DD 36 FC 48   [19]  155 	ld	-4 (ix),#>((_PLAYER_position + 0x0001))
   420B 21 40 29      [10]  156 	ld	hl,#0x2940
   420E 4E            [ 7]  157 	ld	c,(hl)
   420F DD 6E FB      [19]  158 	ld	l,-5 (ix)
   4212 DD 66 FC      [19]  159 	ld	h,-4 (ix)
   4215 71            [ 7]  160 	ld	(hl),c
                            161 ;src/Map.c:53: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   4216 21 00 04      [10]  162 	ld	hl,#0x0400
   4219 E5            [11]  163 	push	hl
   421A 3E 87         [ 7]  164 	ld	a,#0x87
   421C F5            [11]  165 	push	af
   421D 33            [ 6]  166 	inc	sp
   421E 21 40 00      [10]  167 	ld	hl,#0x0040
   4221 E5            [11]  168 	push	hl
   4222 CD 9D 6C      [17]  169 	call	_cpct_memset
                            170 ;src/Map.c:55: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   4225 3A 40 29      [13]  171 	ld	a,(#0x2940)
   4228 DD 77 FD      [19]  172 	ld	-3 (ix), a
   422B DD 77 FB      [19]  173 	ld	-5 (ix),a
   422E DD 36 FC 00   [19]  174 	ld	-4 (ix),#0x00
   4232 3E 06         [ 7]  175 	ld	a,#0x05+1
   4234 18 08         [12]  176 	jr	00315$
   4236                     177 00314$:
   4236 DD CB FB 26   [23]  178 	sla	-5 (ix)
   423A DD CB FC 16   [23]  179 	rl	-4 (ix)
   423E                     180 00315$:
   423E 3D            [ 4]  181 	dec	a
   423F 20 F5         [12]  182 	jr	NZ,00314$
   4241 DD 7E FB      [19]  183 	ld	a,-5 (ix)
   4244 C6 40         [ 7]  184 	add	a, #0x40
   4246 DD 77 FB      [19]  185 	ld	-5 (ix),a
   4249 DD 7E FC      [19]  186 	ld	a,-4 (ix)
   424C CE 00         [ 7]  187 	adc	a, #0x00
   424E DD 77 FC      [19]  188 	ld	-4 (ix),a
   4251 21 41 29      [10]  189 	ld	hl,#0x2941
   4254 4E            [ 7]  190 	ld	c,(hl)
   4255 DD 6E FB      [19]  191 	ld	l,-5 (ix)
   4258 DD 66 FC      [19]  192 	ld	h,-4 (ix)
   425B 06 00         [ 7]  193 	ld	b,#0x00
   425D 09            [11]  194 	add	hl, bc
   425E 36 00         [10]  195 	ld	(hl),#0x00
                            196 ;src/Map.c:58: for(i=0;i<MAP_WIDTH;++i){
   4260 DD 36 F3 00   [19]  197 	ld	-13 (ix),#0x00
   4264                     198 00167$:
                            199 ;src/Map.c:59: map[0][i]=get_random_wall();
   4264 DD 7E F3      [19]  200 	ld	a,-13 (ix)
   4267 C6 40         [ 7]  201 	add	a, #0x40
   4269 DD 77 FB      [19]  202 	ld	-5 (ix),a
   426C 3E 00         [ 7]  203 	ld	a,#0x00
   426E CE 00         [ 7]  204 	adc	a, #0x00
   4270 DD 77 FC      [19]  205 	ld	-4 (ix),a
   4273 CD 85 41      [17]  206 	call	_get_random_wall
   4276 DD 75 FD      [19]  207 	ld	-3 (ix),l
   4279 DD 6E FB      [19]  208 	ld	l,-5 (ix)
   427C DD 66 FC      [19]  209 	ld	h,-4 (ix)
   427F DD 7E FD      [19]  210 	ld	a,-3 (ix)
   4282 77            [ 7]  211 	ld	(hl),a
                            212 ;src/Map.c:60: map[MAP_HEIGHT-1][i]=get_random_wall();
   4283 DD 7E F3      [19]  213 	ld	a,-13 (ix)
   4286 C6 20         [ 7]  214 	add	a, #0x20
   4288 DD 77 FB      [19]  215 	ld	-5 (ix),a
   428B 3E 00         [ 7]  216 	ld	a,#0x00
   428D CE 04         [ 7]  217 	adc	a, #0x04
   428F DD 77 FC      [19]  218 	ld	-4 (ix),a
   4292 CD 85 41      [17]  219 	call	_get_random_wall
   4295 4D            [ 4]  220 	ld	c,l
   4296 DD 6E FB      [19]  221 	ld	l,-5 (ix)
   4299 DD 66 FC      [19]  222 	ld	h,-4 (ix)
   429C 71            [ 7]  223 	ld	(hl),c
                            224 ;src/Map.c:58: for(i=0;i<MAP_WIDTH;++i){
   429D DD 34 F3      [23]  225 	inc	-13 (ix)
   42A0 DD 7E F3      [19]  226 	ld	a,-13 (ix)
   42A3 D6 20         [ 7]  227 	sub	a, #0x20
   42A5 38 BD         [12]  228 	jr	C,00167$
                            229 ;src/Map.c:63: for(i=1;i<MAP_HEIGHT-1;++i){
   42A7 DD 36 F3 01   [19]  230 	ld	-13 (ix),#0x01
   42AB                     231 00169$:
                            232 ;src/Map.c:64: map[i][0]=get_random_wall();
   42AB DD 7E F3      [19]  233 	ld	a,-13 (ix)
   42AE DD 77 FB      [19]  234 	ld	-5 (ix),a
   42B1 DD 36 FC 00   [19]  235 	ld	-4 (ix),#0x00
   42B5 3E 06         [ 7]  236 	ld	a,#0x05+1
   42B7 18 08         [12]  237 	jr	00317$
   42B9                     238 00316$:
   42B9 DD CB FB 26   [23]  239 	sla	-5 (ix)
   42BD DD CB FC 16   [23]  240 	rl	-4 (ix)
   42C1                     241 00317$:
   42C1 3D            [ 4]  242 	dec	a
   42C2 20 F5         [12]  243 	jr	NZ,00316$
   42C4 DD 7E FB      [19]  244 	ld	a,-5 (ix)
   42C7 C6 40         [ 7]  245 	add	a, #0x40
   42C9 DD 77 FE      [19]  246 	ld	-2 (ix),a
   42CC DD 7E FC      [19]  247 	ld	a,-4 (ix)
   42CF CE 00         [ 7]  248 	adc	a, #0x00
   42D1 DD 77 FF      [19]  249 	ld	-1 (ix),a
   42D4 CD 85 41      [17]  250 	call	_get_random_wall
   42D7 DD 75 FD      [19]  251 	ld	-3 (ix),l
   42DA DD 6E FE      [19]  252 	ld	l,-2 (ix)
   42DD DD 66 FF      [19]  253 	ld	h,-1 (ix)
   42E0 DD 7E FD      [19]  254 	ld	a,-3 (ix)
   42E3 77            [ 7]  255 	ld	(hl),a
                            256 ;src/Map.c:65: map[i][MAP_WIDTH-1]=get_random_wall();
   42E4 DD 7E FB      [19]  257 	ld	a,-5 (ix)
   42E7 C6 40         [ 7]  258 	add	a, #0x40
   42E9 DD 77 FE      [19]  259 	ld	-2 (ix),a
   42EC DD 7E FC      [19]  260 	ld	a,-4 (ix)
   42EF CE 00         [ 7]  261 	adc	a, #0x00
   42F1 DD 77 FF      [19]  262 	ld	-1 (ix),a
   42F4 DD 7E FE      [19]  263 	ld	a,-2 (ix)
   42F7 C6 1F         [ 7]  264 	add	a, #0x1F
   42F9 4F            [ 4]  265 	ld	c,a
   42FA DD 7E FF      [19]  266 	ld	a,-1 (ix)
   42FD CE 00         [ 7]  267 	adc	a, #0x00
   42FF 47            [ 4]  268 	ld	b,a
   4300 C5            [11]  269 	push	bc
   4301 CD 85 41      [17]  270 	call	_get_random_wall
   4304 7D            [ 4]  271 	ld	a,l
   4305 C1            [10]  272 	pop	bc
   4306 02            [ 7]  273 	ld	(bc),a
                            274 ;src/Map.c:63: for(i=1;i<MAP_HEIGHT-1;++i){
   4307 DD 34 F3      [23]  275 	inc	-13 (ix)
   430A DD 7E F3      [19]  276 	ld	a,-13 (ix)
   430D D6 1F         [ 7]  277 	sub	a, #0x1F
   430F 38 9A         [12]  278 	jr	C,00169$
                            279 ;src/Map.c:68: while(remainingCells>0){
   4311 21 04 00      [10]  280 	ld	hl,#0x0004
   4314 39            [11]  281 	add	hl,sp
   4315 DD 75 FE      [19]  282 	ld	-2 (ix),l
   4318 DD 74 FF      [19]  283 	ld	-1 (ix),h
   431B                     284 00164$:
   431B DD 7E F2      [19]  285 	ld	a,-14 (ix)
   431E DD B6 F1      [19]  286 	or	a,-15 (ix)
   4321 CA EA 46      [10]  287 	jp	Z,00171$
                            288 ;src/Map.c:69: wallListPosition = wallList+wallListCount;
   4324 C1            [10]  289 	pop	bc
   4325 E1            [10]  290 	pop	hl
   4326 E5            [11]  291 	push	hl
   4327 C5            [11]  292 	push	bc
   4328 29            [11]  293 	add	hl, hl
   4329 7D            [ 4]  294 	ld	a,l
   432A C6 40         [ 7]  295 	add	a, #0x40
   432C DD 77 FB      [19]  296 	ld	-5 (ix),a
   432F 7C            [ 4]  297 	ld	a,h
   4330 CE 2D         [ 7]  298 	adc	a, #0x2D
   4332 DD 77 FC      [19]  299 	ld	-4 (ix),a
                            300 ;src/Map.c:70: while(wallListCount<MAP_SIZE){
   4335 D1            [10]  301 	pop	de
   4336 C1            [10]  302 	pop	bc
   4337 C5            [11]  303 	push	bc
   4338 D5            [11]  304 	push	de
   4339                     305 00134$:
                            306 ;src/Map.c:73: currentPos.y = (*wallListPosition).y;
   4339 DD 7E FE      [19]  307 	ld	a,-2 (ix)
   433C C6 01         [ 7]  308 	add	a, #0x01
   433E DD 77 F9      [19]  309 	ld	-7 (ix),a
   4341 DD 7E FF      [19]  310 	ld	a,-1 (ix)
   4344 CE 00         [ 7]  311 	adc	a, #0x00
   4346 DD 77 FA      [19]  312 	ld	-6 (ix),a
                            313 ;src/Map.c:70: while(wallListCount<MAP_SIZE){
   4349 78            [ 4]  314 	ld	a,b
   434A D6 04         [ 7]  315 	sub	a, #0x04
   434C D2 EB 44      [10]  316 	jp	NC,00204$
                            317 ;src/Map.c:72: currentPos.x = (*wallListPosition).x;
   434F 21 04 00      [10]  318 	ld	hl,#0x0004
   4352 39            [11]  319 	add	hl,sp
   4353 EB            [ 4]  320 	ex	de,hl
   4354 DD 6E FB      [19]  321 	ld	l,-5 (ix)
   4357 DD 66 FC      [19]  322 	ld	h,-4 (ix)
   435A 7E            [ 7]  323 	ld	a,(hl)
   435B 12            [ 7]  324 	ld	(de),a
                            325 ;src/Map.c:73: currentPos.y = (*wallListPosition).y;
   435C DD 5E FB      [19]  326 	ld	e,-5 (ix)
   435F DD 56 FC      [19]  327 	ld	d,-4 (ix)
   4362 13            [ 6]  328 	inc	de
   4363 1A            [ 7]  329 	ld	a,(de)
   4364 DD 6E F9      [19]  330 	ld	l,-7 (ix)
   4367 DD 66 FA      [19]  331 	ld	h,-6 (ix)
   436A 77            [ 7]  332 	ld	(hl),a
                            333 ;src/Map.c:75: convertToFloor=0;
   436B DD 36 F4 00   [19]  334 	ld	-12 (ix),#0x00
                            335 ;src/Map.c:76: surroundedByWalls=1;
   436F DD 36 F5 01   [19]  336 	ld	-11 (ix),#0x01
                            337 ;src/Map.c:78: if(currentPos.x>0){
   4373 DD 6E FE      [19]  338 	ld	l,-2 (ix)
   4376 DD 66 FF      [19]  339 	ld	h,-1 (ix)
   4379 7E            [ 7]  340 	ld	a,(hl)
   437A DD 77 FD      [19]  341 	ld	-3 (ix),a
                            342 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   437D DD 6E F9      [19]  343 	ld	l,-7 (ix)
   4380 DD 66 FA      [19]  344 	ld	h,-6 (ix)
   4383 7E            [ 7]  345 	ld	a,(hl)
   4384 DD 77 F6      [19]  346 	ld	-10 (ix),a
   4387 DD 7E FD      [19]  347 	ld	a,-3 (ix)
   438A DD 77 F7      [19]  348 	ld	-9 (ix),a
   438D DD 36 F8 00   [19]  349 	ld	-8 (ix),#0x00
                            350 ;src/Map.c:78: if(currentPos.x>0){
   4391 DD 7E FD      [19]  351 	ld	a,-3 (ix)
   4394 B7            [ 4]  352 	or	a, a
   4395 28 2F         [12]  353 	jr	Z,00109$
                            354 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   4397 DD 6E F7      [19]  355 	ld	l,-9 (ix)
   439A DD 66 F8      [19]  356 	ld	h,-8 (ix)
   439D 2B            [ 6]  357 	dec	hl
   439E 29            [11]  358 	add	hl, hl
   439F 29            [11]  359 	add	hl, hl
   43A0 29            [11]  360 	add	hl, hl
   43A1 29            [11]  361 	add	hl, hl
   43A2 29            [11]  362 	add	hl, hl
   43A3 D5            [11]  363 	push	de
   43A4 11 40 00      [10]  364 	ld	de,#0x0040
   43A7 19            [11]  365 	add	hl, de
   43A8 D1            [10]  366 	pop	de
   43A9 7D            [ 4]  367 	ld	a,l
   43AA DD 86 F6      [19]  368 	add	a, -10 (ix)
   43AD 6F            [ 4]  369 	ld	l,a
   43AE 7C            [ 4]  370 	ld	a,h
   43AF CE 00         [ 7]  371 	adc	a, #0x00
   43B1 67            [ 4]  372 	ld	h,a
   43B2 6E            [ 7]  373 	ld	l,(hl)
                            374 ;src/Map.c:80: if(adjacentType == CELLTYPE_UNDEFINED){
   43B3 7D            [ 4]  375 	ld	a,l
   43B4 D6 87         [ 7]  376 	sub	a, #0x87
   43B6 20 06         [12]  377 	jr	NZ,00106$
                            378 ;src/Map.c:81: convertToFloor  = 1;
   43B8 DD 36 F4 01   [19]  379 	ld	-12 (ix),#0x01
   43BC 18 08         [12]  380 	jr	00109$
   43BE                     381 00106$:
                            382 ;src/Map.c:83: else if(adjacentType == CELLTYPE_FLOOR){
   43BE 7D            [ 4]  383 	ld	a,l
   43BF B7            [ 4]  384 	or	a, a
   43C0 20 04         [12]  385 	jr	NZ,00109$
                            386 ;src/Map.c:84: surroundedByWalls = 0;
   43C2 DD 36 F5 00   [19]  387 	ld	-11 (ix),#0x00
   43C6                     388 00109$:
                            389 ;src/Map.c:87: if(currentPos.x < (MAP_WIDTH-1)){
   43C6 DD 7E FD      [19]  390 	ld	a,-3 (ix)
   43C9 D6 1F         [ 7]  391 	sub	a, #0x1F
   43CB 30 2F         [12]  392 	jr	NC,00116$
                            393 ;src/Map.c:89: adjacentType = map[currentPos.x+1][currentPos.y];
   43CD DD 6E F7      [19]  394 	ld	l,-9 (ix)
   43D0 DD 66 F8      [19]  395 	ld	h,-8 (ix)
   43D3 23            [ 6]  396 	inc	hl
   43D4 29            [11]  397 	add	hl, hl
   43D5 29            [11]  398 	add	hl, hl
   43D6 29            [11]  399 	add	hl, hl
   43D7 29            [11]  400 	add	hl, hl
   43D8 29            [11]  401 	add	hl, hl
   43D9 D5            [11]  402 	push	de
   43DA 11 40 00      [10]  403 	ld	de,#0x0040
   43DD 19            [11]  404 	add	hl, de
   43DE D1            [10]  405 	pop	de
   43DF 7D            [ 4]  406 	ld	a,l
   43E0 DD 86 F6      [19]  407 	add	a, -10 (ix)
   43E3 6F            [ 4]  408 	ld	l,a
   43E4 7C            [ 4]  409 	ld	a,h
   43E5 CE 00         [ 7]  410 	adc	a, #0x00
   43E7 67            [ 4]  411 	ld	h,a
   43E8 6E            [ 7]  412 	ld	l,(hl)
                            413 ;src/Map.c:90: if(adjacentType == CELLTYPE_UNDEFINED){
   43E9 7D            [ 4]  414 	ld	a,l
   43EA D6 87         [ 7]  415 	sub	a, #0x87
   43EC 20 06         [12]  416 	jr	NZ,00113$
                            417 ;src/Map.c:91: convertToFloor  = 1;
   43EE DD 36 F4 01   [19]  418 	ld	-12 (ix),#0x01
   43F2 18 08         [12]  419 	jr	00116$
   43F4                     420 00113$:
                            421 ;src/Map.c:93: else if(adjacentType == CELLTYPE_FLOOR){
   43F4 7D            [ 4]  422 	ld	a,l
   43F5 B7            [ 4]  423 	or	a, a
   43F6 20 04         [12]  424 	jr	NZ,00116$
                            425 ;src/Map.c:94: surroundedByWalls = 0;
   43F8 DD 36 F5 00   [19]  426 	ld	-11 (ix),#0x00
   43FC                     427 00116$:
                            428 ;src/Map.c:99: adjacentType = map[currentPos.x][currentPos.y-1];
   43FC DD 6E F7      [19]  429 	ld	l,-9 (ix)
   43FF DD 66 F8      [19]  430 	ld	h,-8 (ix)
   4402 29            [11]  431 	add	hl, hl
   4403 29            [11]  432 	add	hl, hl
   4404 29            [11]  433 	add	hl, hl
   4405 29            [11]  434 	add	hl, hl
   4406 29            [11]  435 	add	hl, hl
   4407 7D            [ 4]  436 	ld	a,l
   4408 C6 40         [ 7]  437 	add	a, #0x40
   440A DD 77 F7      [19]  438 	ld	-9 (ix),a
   440D 7C            [ 4]  439 	ld	a,h
   440E CE 00         [ 7]  440 	adc	a, #0x00
   4410 DD 77 F8      [19]  441 	ld	-8 (ix),a
                            442 ;src/Map.c:97: if(currentPos.y > 0){
   4413 DD 7E F6      [19]  443 	ld	a,-10 (ix)
   4416 B7            [ 4]  444 	or	a, a
   4417 28 23         [12]  445 	jr	Z,00123$
                            446 ;src/Map.c:99: adjacentType = map[currentPos.x][currentPos.y-1];
   4419 DD 6E F6      [19]  447 	ld	l,-10 (ix)
   441C 2D            [ 4]  448 	dec	l
   441D DD 7E F7      [19]  449 	ld	a,-9 (ix)
   4420 85            [ 4]  450 	add	a, l
   4421 6F            [ 4]  451 	ld	l,a
   4422 DD 7E F8      [19]  452 	ld	a,-8 (ix)
   4425 CE 00         [ 7]  453 	adc	a, #0x00
   4427 67            [ 4]  454 	ld	h,a
   4428 6E            [ 7]  455 	ld	l,(hl)
                            456 ;src/Map.c:100: if(adjacentType == CELLTYPE_UNDEFINED){
   4429 7D            [ 4]  457 	ld	a,l
   442A D6 87         [ 7]  458 	sub	a, #0x87
   442C 20 06         [12]  459 	jr	NZ,00120$
                            460 ;src/Map.c:101: convertToFloor  = 1;
   442E DD 36 F4 01   [19]  461 	ld	-12 (ix),#0x01
   4432 18 08         [12]  462 	jr	00123$
   4434                     463 00120$:
                            464 ;src/Map.c:103: else if(adjacentType == CELLTYPE_FLOOR){
   4434 7D            [ 4]  465 	ld	a,l
   4435 B7            [ 4]  466 	or	a, a
   4436 20 04         [12]  467 	jr	NZ,00123$
                            468 ;src/Map.c:104: surroundedByWalls = 0;
   4438 DD 36 F5 00   [19]  469 	ld	-11 (ix),#0x00
   443C                     470 00123$:
                            471 ;src/Map.c:107: if(currentPos.y < (MAP_HEIGHT-1)){
   443C DD 7E F6      [19]  472 	ld	a,-10 (ix)
   443F D6 1F         [ 7]  473 	sub	a, #0x1F
   4441 30 23         [12]  474 	jr	NC,00130$
                            475 ;src/Map.c:109: adjacentType = map[currentPos.x][currentPos.y+1];
   4443 DD 6E F6      [19]  476 	ld	l,-10 (ix)
   4446 2C            [ 4]  477 	inc	l
   4447 DD 7E F7      [19]  478 	ld	a,-9 (ix)
   444A 85            [ 4]  479 	add	a, l
   444B 6F            [ 4]  480 	ld	l,a
   444C DD 7E F8      [19]  481 	ld	a,-8 (ix)
   444F CE 00         [ 7]  482 	adc	a, #0x00
   4451 67            [ 4]  483 	ld	h,a
   4452 6E            [ 7]  484 	ld	l,(hl)
                            485 ;src/Map.c:110: if(adjacentType == CELLTYPE_UNDEFINED){
   4453 7D            [ 4]  486 	ld	a,l
   4454 D6 87         [ 7]  487 	sub	a, #0x87
   4456 20 06         [12]  488 	jr	NZ,00127$
                            489 ;src/Map.c:111: convertToFloor  = 1;
   4458 DD 36 F4 01   [19]  490 	ld	-12 (ix),#0x01
   445C 18 08         [12]  491 	jr	00130$
   445E                     492 00127$:
                            493 ;src/Map.c:113: else if(adjacentType == CELLTYPE_FLOOR){
   445E 7D            [ 4]  494 	ld	a,l
   445F B7            [ 4]  495 	or	a, a
   4460 20 04         [12]  496 	jr	NZ,00130$
                            497 ;src/Map.c:114: surroundedByWalls = 0;
   4462 DD 36 F5 00   [19]  498 	ld	-11 (ix),#0x00
   4466                     499 00130$:
                            500 ;src/Map.c:118: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   4466 69            [ 4]  501 	ld	l, c
   4467 60            [ 4]  502 	ld	h, b
   4468 29            [11]  503 	add	hl, hl
   4469 FD 21 40 2D   [14]  504 	ld	iy,#0x2D40
   446D C5            [11]  505 	push	bc
   446E 4D            [ 4]  506 	ld	c, l
   446F 44            [ 4]  507 	ld	b, h
   4470 FD 09         [15]  508 	add	iy, bc
   4472 C1            [10]  509 	pop	bc
   4473 FD 7E 00      [19]  510 	ld	a, 0 (iy)
   4476 DD 6E FB      [19]  511 	ld	l,-5 (ix)
   4479 DD 66 FC      [19]  512 	ld	h,-4 (ix)
   447C 77            [ 7]  513 	ld	(hl),a
                            514 ;src/Map.c:119: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   447D FD E5         [15]  515 	push	iy
   447F E1            [10]  516 	pop	hl
   4480 23            [ 6]  517 	inc	hl
   4481 7E            [ 7]  518 	ld	a,(hl)
   4482 12            [ 7]  519 	ld	(de),a
                            520 ;src/Map.c:120: --wallListCount;
   4483 0B            [ 6]  521 	dec	bc
   4484 DD 71 ED      [19]  522 	ld	-19 (ix),c
   4487 DD 70 EE      [19]  523 	ld	-18 (ix),b
                            524 ;src/Map.c:123: if((convertToFloor)&&(!surroundedByWalls)){
   448A DD 7E F4      [19]  525 	ld	a,-12 (ix)
   448D B7            [ 4]  526 	or	a, a
   448E 28 4A         [12]  527 	jr	Z,00132$
   4490 DD 7E F5      [19]  528 	ld	a,-11 (ix)
   4493 B7            [ 4]  529 	or	a, a
   4494 20 44         [12]  530 	jr	NZ,00132$
                            531 ;src/Map.c:124: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   4496 DD 6E FE      [19]  532 	ld	l,-2 (ix)
   4499 DD 66 FF      [19]  533 	ld	h,-1 (ix)
   449C 6E            [ 7]  534 	ld	l,(hl)
   449D 26 00         [ 7]  535 	ld	h,#0x00
   449F 29            [11]  536 	add	hl, hl
   44A0 29            [11]  537 	add	hl, hl
   44A1 29            [11]  538 	add	hl, hl
   44A2 29            [11]  539 	add	hl, hl
   44A3 29            [11]  540 	add	hl, hl
   44A4 01 40 00      [10]  541 	ld	bc,#0x0040
   44A7 09            [11]  542 	add	hl,bc
   44A8 4D            [ 4]  543 	ld	c,l
   44A9 44            [ 4]  544 	ld	b,h
   44AA DD 6E F9      [19]  545 	ld	l,-7 (ix)
   44AD DD 66 FA      [19]  546 	ld	h,-6 (ix)
   44B0 6E            [ 7]  547 	ld	l, (hl)
   44B1 26 00         [ 7]  548 	ld	h,#0x00
   44B3 09            [11]  549 	add	hl,bc
   44B4 36 00         [10]  550 	ld	(hl),#0x00
                            551 ;src/Map.c:126: ++lastStackItem;
   44B6 DD 34 EB      [23]  552 	inc	-21 (ix)
   44B9 20 03         [12]  553 	jr	NZ,00326$
   44BB DD 34 EC      [23]  554 	inc	-20 (ix)
   44BE                     555 00326$:
                            556 ;src/Map.c:127: (*(cellStack+lastStackItem)).x = currentPos.x;
   44BE E1            [10]  557 	pop	hl
   44BF E5            [11]  558 	push	hl
   44C0 29            [11]  559 	add	hl, hl
   44C1 01 40 29      [10]  560 	ld	bc, #0x2940
   44C4 09            [11]  561 	add	hl,bc
   44C5 4D            [ 4]  562 	ld	c, l
   44C6 44            [ 4]  563 	ld	b, h
   44C7 DD 6E FE      [19]  564 	ld	l,-2 (ix)
   44CA DD 66 FF      [19]  565 	ld	h,-1 (ix)
   44CD 7E            [ 7]  566 	ld	a,(hl)
   44CE 02            [ 7]  567 	ld	(bc),a
                            568 ;src/Map.c:128: (*(cellStack+lastStackItem)).y = currentPos.y;
   44CF 03            [ 6]  569 	inc	bc
   44D0 DD 6E F9      [19]  570 	ld	l,-7 (ix)
   44D3 DD 66 FA      [19]  571 	ld	h,-6 (ix)
   44D6 7E            [ 7]  572 	ld	a,(hl)
   44D7 02            [ 7]  573 	ld	(bc),a
                            574 ;src/Map.c:131: break;
   44D8 18 11         [12]  575 	jr	00204$
   44DA                     576 00132$:
                            577 ;src/Map.c:133: --wallListPosition;
   44DA DD 6E FB      [19]  578 	ld	l,-5 (ix)
   44DD DD 66 FC      [19]  579 	ld	h,-4 (ix)
   44E0 2B            [ 6]  580 	dec	hl
   44E1 2B            [ 6]  581 	dec	hl
   44E2 DD 75 FB      [19]  582 	ld	-5 (ix),l
   44E5 DD 74 FC      [19]  583 	ld	-4 (ix),h
   44E8 C3 39 43      [10]  584 	jp	00134$
                            585 ;src/Map.c:135: while(lastStackItem<MAP_SIZE){
   44EB                     586 00204$:
   44EB DD 7E F1      [19]  587 	ld	a,-15 (ix)
   44EE DD 77 F7      [19]  588 	ld	-9 (ix),a
   44F1 DD 7E F2      [19]  589 	ld	a,-14 (ix)
   44F4 DD 77 F8      [19]  590 	ld	-8 (ix),a
   44F7 DD 7E ED      [19]  591 	ld	a,-19 (ix)
   44FA DD 77 FB      [19]  592 	ld	-5 (ix),a
   44FD DD 7E EE      [19]  593 	ld	a,-18 (ix)
   4500 DD 77 FC      [19]  594 	ld	-4 (ix),a
   4503                     595 00161$:
   4503 DD 7E EC      [19]  596 	ld	a,-20 (ix)
   4506 D6 04         [ 7]  597 	sub	a, #0x04
   4508 D2 1B 43      [10]  598 	jp	NC,00164$
                            599 ;src/Map.c:136: currentPos.x=(*(lastStackItem+cellStack)).x;
   450B 21 04 00      [10]  600 	ld	hl,#0x0004
   450E 39            [11]  601 	add	hl,sp
   450F 4D            [ 4]  602 	ld	c,l
   4510 44            [ 4]  603 	ld	b,h
   4511 E1            [10]  604 	pop	hl
   4512 E5            [11]  605 	push	hl
   4513 29            [11]  606 	add	hl, hl
   4514 FD 21 40 29   [14]  607 	ld	iy,#0x2940
   4518 EB            [ 4]  608 	ex	de,hl
   4519 FD 19         [15]  609 	add	iy, de
   451B FD 7E 00      [19]  610 	ld	a, 0 (iy)
   451E 02            [ 7]  611 	ld	(bc),a
                            612 ;src/Map.c:137: currentPos.y=(*(lastStackItem+cellStack)).y;
   451F FD 4E 01      [19]  613 	ld	c,1 (iy)
   4522 DD 6E F9      [19]  614 	ld	l,-7 (ix)
   4525 DD 66 FA      [19]  615 	ld	h,-6 (ix)
   4528 71            [ 7]  616 	ld	(hl),c
                            617 ;src/Map.c:138: --lastStackItem;
   4529 E1            [10]  618 	pop	hl
   452A E5            [11]  619 	push	hl
   452B 2B            [ 6]  620 	dec	hl
   452C E3            [19]  621 	ex	(sp), hl
                            622 ;src/Map.c:139: cellType = map[currentPos.x][currentPos.y];
   452D DD 6E FE      [19]  623 	ld	l,-2 (ix)
   4530 DD 66 FF      [19]  624 	ld	h,-1 (ix)
   4533 6E            [ 7]  625 	ld	l,(hl)
   4534 26 00         [ 7]  626 	ld	h,#0x00
   4536 29            [11]  627 	add	hl, hl
   4537 29            [11]  628 	add	hl, hl
   4538 29            [11]  629 	add	hl, hl
   4539 29            [11]  630 	add	hl, hl
   453A 29            [11]  631 	add	hl, hl
   453B 11 40 00      [10]  632 	ld	de,#0x0040
   453E 19            [11]  633 	add	hl,de
   453F 59            [ 4]  634 	ld	e,c
   4540 16 00         [ 7]  635 	ld	d,#0x00
   4542 19            [11]  636 	add	hl,de
   4543 4E            [ 7]  637 	ld	c,(hl)
                            638 ;src/Map.c:141: if(cellType == CELLTYPE_UNDEFINED){
   4544 79            [ 4]  639 	ld	a,c
   4545 D6 87         [ 7]  640 	sub	a, #0x87
   4547 20 47         [12]  641 	jr	NZ,00141$
                            642 ;src/Map.c:143: if(cpct_getRandom_lcg_u8()&1){//WALL
   4549 CD 7E 6C      [17]  643 	call	_cpct_getRandom_lcg_u8
   454C CB 45         [ 8]  644 	bit	0, l
   454E 28 06         [12]  645 	jr	Z,00138$
                            646 ;src/Map.c:144: cellType = get_random_wall();
   4550 CD 85 41      [17]  647 	call	_get_random_wall
   4553 4D            [ 4]  648 	ld	c,l
   4554 18 02         [12]  649 	jr	00139$
   4556                     650 00138$:
                            651 ;src/Map.c:147: cellType = CELLTYPE_FLOOR;
   4556 0E 00         [ 7]  652 	ld	c,#0x00
   4558                     653 00139$:
                            654 ;src/Map.c:149: map[currentPos.x][currentPos.y]=cellType;
   4558 DD 6E FE      [19]  655 	ld	l,-2 (ix)
   455B DD 66 FF      [19]  656 	ld	h,-1 (ix)
   455E 6E            [ 7]  657 	ld	l,(hl)
   455F 26 00         [ 7]  658 	ld	h,#0x00
   4561 29            [11]  659 	add	hl, hl
   4562 29            [11]  660 	add	hl, hl
   4563 29            [11]  661 	add	hl, hl
   4564 29            [11]  662 	add	hl, hl
   4565 29            [11]  663 	add	hl, hl
   4566 EB            [ 4]  664 	ex	de,hl
   4567 21 40 00      [10]  665 	ld	hl,#0x0040
   456A 19            [11]  666 	add	hl,de
   456B EB            [ 4]  667 	ex	de,hl
   456C DD 6E F9      [19]  668 	ld	l,-7 (ix)
   456F DD 66 FA      [19]  669 	ld	h,-6 (ix)
   4572 6E            [ 7]  670 	ld	l, (hl)
   4573 26 00         [ 7]  671 	ld	h,#0x00
   4575 19            [11]  672 	add	hl,de
   4576 71            [ 7]  673 	ld	(hl),c
                            674 ;src/Map.c:150: --remainingCells;
   4577 DD 6E F7      [19]  675 	ld	l,-9 (ix)
   457A DD 66 F8      [19]  676 	ld	h,-8 (ix)
   457D 2B            [ 6]  677 	dec	hl
   457E DD 75 F7      [19]  678 	ld	-9 (ix),l
   4581 DD 74 F8      [19]  679 	ld	-8 (ix),h
   4584 DD 7E F7      [19]  680 	ld	a,-9 (ix)
   4587 DD 77 F1      [19]  681 	ld	-15 (ix),a
   458A DD 7E F8      [19]  682 	ld	a,-8 (ix)
   458D DD 77 F2      [19]  683 	ld	-14 (ix),a
   4590                     684 00141$:
                            685 ;src/Map.c:78: if(currentPos.x>0){
   4590 DD 6E FE      [19]  686 	ld	l,-2 (ix)
   4593 DD 66 FF      [19]  687 	ld	h,-1 (ix)
   4596 7E            [ 7]  688 	ld	a,(hl)
   4597 DD 77 F6      [19]  689 	ld	-10 (ix),a
                            690 ;src/Map.c:153: if((cellType == CELLTYPE_FLOOR)){
   459A 79            [ 4]  691 	ld	a,c
   459B B7            [ 4]  692 	or	a, a
   459C C2 B9 46      [10]  693 	jp	NZ,00159$
                            694 ;src/Map.c:154: if(currentPos.x>0){
   459F DD 7E F6      [19]  695 	ld	a,-10 (ix)
   45A2 B7            [ 4]  696 	or	a, a
   45A3 28 3F         [12]  697 	jr	Z,00145$
                            698 ;src/Map.c:155: adjacentType = map[currentPos.x-1][currentPos.y];
   45A5 DD 6E F6      [19]  699 	ld	l,-10 (ix)
   45A8 26 00         [ 7]  700 	ld	h,#0x00
   45AA 2B            [ 6]  701 	dec	hl
   45AB 29            [11]  702 	add	hl, hl
   45AC 29            [11]  703 	add	hl, hl
   45AD 29            [11]  704 	add	hl, hl
   45AE 29            [11]  705 	add	hl, hl
   45AF 29            [11]  706 	add	hl, hl
   45B0 01 40 00      [10]  707 	ld	bc,#0x0040
   45B3 09            [11]  708 	add	hl,bc
   45B4 4D            [ 4]  709 	ld	c,l
   45B5 44            [ 4]  710 	ld	b,h
   45B6 DD 6E F9      [19]  711 	ld	l,-7 (ix)
   45B9 DD 66 FA      [19]  712 	ld	h,-6 (ix)
   45BC 6E            [ 7]  713 	ld	l, (hl)
   45BD 26 00         [ 7]  714 	ld	h,#0x00
   45BF 09            [11]  715 	add	hl,bc
   45C0 7E            [ 7]  716 	ld	a,(hl)
                            717 ;src/Map.c:156: if(adjacentType == CELLTYPE_UNDEFINED){
   45C1 D6 87         [ 7]  718 	sub	a, #0x87
   45C3 20 1F         [12]  719 	jr	NZ,00145$
                            720 ;src/Map.c:158: ++lastStackItem;
   45C5 DD 34 EB      [23]  721 	inc	-21 (ix)
   45C8 20 03         [12]  722 	jr	NZ,00332$
   45CA DD 34 EC      [23]  723 	inc	-20 (ix)
   45CD                     724 00332$:
                            725 ;src/Map.c:159: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   45CD E1            [10]  726 	pop	hl
   45CE E5            [11]  727 	push	hl
   45CF 29            [11]  728 	add	hl, hl
   45D0 01 40 29      [10]  729 	ld	bc,#0x2940
   45D3 09            [11]  730 	add	hl,bc
   45D4 DD 4E F6      [19]  731 	ld	c,-10 (ix)
   45D7 0D            [ 4]  732 	dec	c
   45D8 71            [ 7]  733 	ld	(hl),c
                            734 ;src/Map.c:160: (*(cellStack+lastStackItem)).y = currentPos.y;
   45D9 23            [ 6]  735 	inc	hl
   45DA 4D            [ 4]  736 	ld	c,l
   45DB 44            [ 4]  737 	ld	b,h
   45DC DD 6E F9      [19]  738 	ld	l,-7 (ix)
   45DF DD 66 FA      [19]  739 	ld	h,-6 (ix)
   45E2 7E            [ 7]  740 	ld	a,(hl)
   45E3 02            [ 7]  741 	ld	(bc),a
   45E4                     742 00145$:
                            743 ;src/Map.c:164: if(currentPos.x < (MAP_WIDTH-1)){
   45E4 DD 6E FE      [19]  744 	ld	l,-2 (ix)
   45E7 DD 66 FF      [19]  745 	ld	h,-1 (ix)
   45EA 4E            [ 7]  746 	ld	c,(hl)
   45EB 79            [ 4]  747 	ld	a,c
   45EC D6 1F         [ 7]  748 	sub	a, #0x1F
   45EE 30 3A         [12]  749 	jr	NC,00149$
                            750 ;src/Map.c:166: adjacentType = map[currentPos.x+1][currentPos.y];
   45F0 69            [ 4]  751 	ld	l,c
   45F1 26 00         [ 7]  752 	ld	h,#0x00
   45F3 23            [ 6]  753 	inc	hl
   45F4 29            [11]  754 	add	hl, hl
   45F5 29            [11]  755 	add	hl, hl
   45F6 29            [11]  756 	add	hl, hl
   45F7 29            [11]  757 	add	hl, hl
   45F8 29            [11]  758 	add	hl, hl
   45F9 EB            [ 4]  759 	ex	de,hl
   45FA 21 40 00      [10]  760 	ld	hl,#0x0040
   45FD 19            [11]  761 	add	hl,de
   45FE EB            [ 4]  762 	ex	de,hl
   45FF DD 6E F9      [19]  763 	ld	l,-7 (ix)
   4602 DD 66 FA      [19]  764 	ld	h,-6 (ix)
   4605 6E            [ 7]  765 	ld	l, (hl)
   4606 26 00         [ 7]  766 	ld	h,#0x00
   4608 19            [11]  767 	add	hl,de
   4609 7E            [ 7]  768 	ld	a,(hl)
                            769 ;src/Map.c:167: if(adjacentType == CELLTYPE_UNDEFINED){
   460A D6 87         [ 7]  770 	sub	a, #0x87
   460C 20 1C         [12]  771 	jr	NZ,00149$
                            772 ;src/Map.c:170: ++lastStackItem;
   460E DD 34 EB      [23]  773 	inc	-21 (ix)
   4611 20 03         [12]  774 	jr	NZ,00335$
   4613 DD 34 EC      [23]  775 	inc	-20 (ix)
   4616                     776 00335$:
                            777 ;src/Map.c:171: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   4616 E1            [10]  778 	pop	hl
   4617 E5            [11]  779 	push	hl
   4618 29            [11]  780 	add	hl, hl
   4619 11 40 29      [10]  781 	ld	de,#0x2940
   461C 19            [11]  782 	add	hl,de
   461D 0C            [ 4]  783 	inc	c
   461E 71            [ 7]  784 	ld	(hl),c
                            785 ;src/Map.c:172: (*(cellStack+lastStackItem)).y = currentPos.y;
   461F 23            [ 6]  786 	inc	hl
   4620 4D            [ 4]  787 	ld	c,l
   4621 44            [ 4]  788 	ld	b,h
   4622 DD 6E F9      [19]  789 	ld	l,-7 (ix)
   4625 DD 66 FA      [19]  790 	ld	h,-6 (ix)
   4628 7E            [ 7]  791 	ld	a,(hl)
   4629 02            [ 7]  792 	ld	(bc),a
   462A                     793 00149$:
                            794 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   462A DD 6E F9      [19]  795 	ld	l,-7 (ix)
   462D DD 66 FA      [19]  796 	ld	h,-6 (ix)
   4630 4E            [ 7]  797 	ld	c,(hl)
                            798 ;src/Map.c:176: if(currentPos.y > 0){
   4631 79            [ 4]  799 	ld	a,c
   4632 B7            [ 4]  800 	or	a, a
   4633 28 3A         [12]  801 	jr	Z,00153$
                            802 ;src/Map.c:178: adjacentType = map[currentPos.x][currentPos.y-1];
   4635 DD 6E FE      [19]  803 	ld	l,-2 (ix)
   4638 DD 66 FF      [19]  804 	ld	h,-1 (ix)
   463B 46            [ 7]  805 	ld	b,(hl)
   463C 68            [ 4]  806 	ld	l,b
   463D 26 00         [ 7]  807 	ld	h,#0x00
   463F 29            [11]  808 	add	hl, hl
   4640 29            [11]  809 	add	hl, hl
   4641 29            [11]  810 	add	hl, hl
   4642 29            [11]  811 	add	hl, hl
   4643 29            [11]  812 	add	hl, hl
   4644 11 40 00      [10]  813 	ld	de,#0x0040
   4647 19            [11]  814 	add	hl,de
   4648 0D            [ 4]  815 	dec	c
   4649 59            [ 4]  816 	ld	e,c
   464A 16 00         [ 7]  817 	ld	d,#0x00
   464C 19            [11]  818 	add	hl,de
   464D 7E            [ 7]  819 	ld	a,(hl)
                            820 ;src/Map.c:179: if(adjacentType == CELLTYPE_UNDEFINED){
   464E D6 87         [ 7]  821 	sub	a, #0x87
   4650 20 1D         [12]  822 	jr	NZ,00153$
                            823 ;src/Map.c:182: ++lastStackItem;
   4652 DD 34 EB      [23]  824 	inc	-21 (ix)
   4655 20 03         [12]  825 	jr	NZ,00338$
   4657 DD 34 EC      [23]  826 	inc	-20 (ix)
   465A                     827 00338$:
                            828 ;src/Map.c:183: (*(cellStack+lastStackItem)).x = currentPos.x;
   465A E1            [10]  829 	pop	hl
   465B E5            [11]  830 	push	hl
   465C 29            [11]  831 	add	hl, hl
   465D 11 40 29      [10]  832 	ld	de,#0x2940
   4660 19            [11]  833 	add	hl,de
   4661 70            [ 7]  834 	ld	(hl),b
                            835 ;src/Map.c:184: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   4662 23            [ 6]  836 	inc	hl
   4663 4D            [ 4]  837 	ld	c,l
   4664 44            [ 4]  838 	ld	b,h
   4665 DD 6E F9      [19]  839 	ld	l,-7 (ix)
   4668 DD 66 FA      [19]  840 	ld	h,-6 (ix)
   466B 5E            [ 7]  841 	ld	e,(hl)
   466C 1D            [ 4]  842 	dec	e
   466D 7B            [ 4]  843 	ld	a,e
   466E 02            [ 7]  844 	ld	(bc),a
   466F                     845 00153$:
                            846 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   466F DD 6E F9      [19]  847 	ld	l,-7 (ix)
   4672 DD 66 FA      [19]  848 	ld	h,-6 (ix)
   4675 46            [ 7]  849 	ld	b,(hl)
                            850 ;src/Map.c:188: if(currentPos.y < (MAP_HEIGHT-1)){
   4676 78            [ 4]  851 	ld	a,b
   4677 D6 1F         [ 7]  852 	sub	a, #0x1F
   4679 D2 03 45      [10]  853 	jp	NC,00161$
                            854 ;src/Map.c:190: adjacentType = map[currentPos.x][currentPos.y+1];
   467C DD 6E FE      [19]  855 	ld	l,-2 (ix)
   467F DD 66 FF      [19]  856 	ld	h,-1 (ix)
   4682 4E            [ 7]  857 	ld	c,(hl)
   4683 69            [ 4]  858 	ld	l,c
   4684 26 00         [ 7]  859 	ld	h,#0x00
   4686 29            [11]  860 	add	hl, hl
   4687 29            [11]  861 	add	hl, hl
   4688 29            [11]  862 	add	hl, hl
   4689 29            [11]  863 	add	hl, hl
   468A 29            [11]  864 	add	hl, hl
   468B 11 40 00      [10]  865 	ld	de,#0x0040
   468E 19            [11]  866 	add	hl,de
   468F 04            [ 4]  867 	inc	b
   4690 58            [ 4]  868 	ld	e,b
   4691 16 00         [ 7]  869 	ld	d,#0x00
   4693 19            [11]  870 	add	hl,de
   4694 7E            [ 7]  871 	ld	a,(hl)
                            872 ;src/Map.c:191: if(adjacentType == CELLTYPE_UNDEFINED){
   4695 D6 87         [ 7]  873 	sub	a, #0x87
   4697 C2 03 45      [10]  874 	jp	NZ,00161$
                            875 ;src/Map.c:194: ++lastStackItem;
   469A DD 34 EB      [23]  876 	inc	-21 (ix)
   469D 20 03         [12]  877 	jr	NZ,00341$
   469F DD 34 EC      [23]  878 	inc	-20 (ix)
   46A2                     879 00341$:
                            880 ;src/Map.c:195: (*(cellStack+lastStackItem)).x = currentPos.x;
   46A2 E1            [10]  881 	pop	hl
   46A3 E5            [11]  882 	push	hl
   46A4 29            [11]  883 	add	hl, hl
   46A5 11 40 29      [10]  884 	ld	de,#0x2940
   46A8 19            [11]  885 	add	hl,de
   46A9 71            [ 7]  886 	ld	(hl),c
                            887 ;src/Map.c:196: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   46AA 23            [ 6]  888 	inc	hl
   46AB 4D            [ 4]  889 	ld	c,l
   46AC 44            [ 4]  890 	ld	b,h
   46AD DD 6E F9      [19]  891 	ld	l,-7 (ix)
   46B0 DD 66 FA      [19]  892 	ld	h,-6 (ix)
   46B3 7E            [ 7]  893 	ld	a,(hl)
   46B4 3C            [ 4]  894 	inc	a
   46B5 02            [ 7]  895 	ld	(bc),a
   46B6 C3 03 45      [10]  896 	jp	00161$
   46B9                     897 00159$:
                            898 ;src/Map.c:202: ++wallListCount;
   46B9 DD 34 FB      [23]  899 	inc	-5 (ix)
   46BC 20 03         [12]  900 	jr	NZ,00342$
   46BE DD 34 FC      [23]  901 	inc	-4 (ix)
   46C1                     902 00342$:
   46C1 DD 7E FB      [19]  903 	ld	a,-5 (ix)
   46C4 DD 77 ED      [19]  904 	ld	-19 (ix),a
   46C7 DD 7E FC      [19]  905 	ld	a,-4 (ix)
   46CA DD 77 EE      [19]  906 	ld	-18 (ix),a
                            907 ;src/Map.c:203: (*(wallList+wallListCount)).x = currentPos.x;
   46CD DD 6E FB      [19]  908 	ld	l,-5 (ix)
   46D0 DD 66 FC      [19]  909 	ld	h,-4 (ix)
   46D3 29            [11]  910 	add	hl, hl
   46D4 01 40 2D      [10]  911 	ld	bc,#0x2D40
   46D7 09            [11]  912 	add	hl,bc
   46D8 DD 7E F6      [19]  913 	ld	a,-10 (ix)
   46DB 77            [ 7]  914 	ld	(hl),a
                            915 ;src/Map.c:204: (*(wallList+wallListCount)).y = currentPos.y;
   46DC 23            [ 6]  916 	inc	hl
   46DD 4D            [ 4]  917 	ld	c,l
   46DE 44            [ 4]  918 	ld	b,h
   46DF DD 6E F9      [19]  919 	ld	l,-7 (ix)
   46E2 DD 66 FA      [19]  920 	ld	h,-6 (ix)
   46E5 7E            [ 7]  921 	ld	a,(hl)
   46E6 02            [ 7]  922 	ld	(bc),a
   46E7 C3 03 45      [10]  923 	jp	00161$
   46EA                     924 00171$:
   46EA DD F9         [10]  925 	ld	sp, ix
   46EC DD E1         [14]  926 	pop	ix
   46EE C9            [10]  927 	ret
                            928 ;src/Map.c:210: void generate_exit_door(){
                            929 ;	---------------------------------
                            930 ; Function generate_exit_door
                            931 ; ---------------------------------
   46EF                     932 _generate_exit_door::
   46EF DD E5         [15]  933 	push	ix
   46F1 DD 21 00 00   [14]  934 	ld	ix,#0
   46F5 DD 39         [15]  935 	add	ix,sp
   46F7 21 F4 FF      [10]  936 	ld	hl,#-12
   46FA 39            [11]  937 	add	hl,sp
   46FB F9            [ 6]  938 	ld	sp,hl
                            939 ;src/Map.c:211: u8 x=(cpct_getRandom_lcg_u8()%32);
   46FC CD 7E 6C      [17]  940 	call	_cpct_getRandom_lcg_u8
   46FF 7D            [ 4]  941 	ld	a,l
   4700 E6 1F         [ 7]  942 	and	a, #0x1F
   4702 4F            [ 4]  943 	ld	c,a
                            944 ;src/Map.c:212: u8 y=(cpct_getRandom_lcg_u8()%32);
   4703 C5            [11]  945 	push	bc
   4704 CD 7E 6C      [17]  946 	call	_cpct_getRandom_lcg_u8
   4707 C1            [10]  947 	pop	bc
   4708 7D            [ 4]  948 	ld	a,l
   4709 E6 1F         [ 7]  949 	and	a, #0x1F
   470B 5F            [ 4]  950 	ld	e,a
                            951 ;src/Map.c:213: u8 door_not_positioned=1;
   470C DD 36 F4 01   [19]  952 	ld	-12 (ix),#0x01
                            953 ;src/Map.c:220: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
   4710 06 00         [ 7]  954 	ld	b,#0x00
   4712 21 40 00      [10]  955 	ld	hl,#0x0040
   4715 09            [11]  956 	add	hl,bc
   4716 4D            [ 4]  957 	ld	c,l
   4717 44            [ 4]  958 	ld	b,h
   4718 6B            [ 4]  959 	ld	l,e
   4719 26 00         [ 7]  960 	ld	h,#0x00
   471B 29            [11]  961 	add	hl, hl
   471C 29            [11]  962 	add	hl, hl
   471D 29            [11]  963 	add	hl, hl
   471E 29            [11]  964 	add	hl, hl
   471F 29            [11]  965 	add	hl, hl
   4720 09            [11]  966 	add	hl,bc
   4721 4D            [ 4]  967 	ld	c,l
   4722 44            [ 4]  968 	ld	b,h
                            969 ;src/Map.c:225: lastVal = (position-1);
   4723 59            [ 4]  970 	ld	e,c
   4724 50            [ 4]  971 	ld	d,b
   4725 1B            [ 6]  972 	dec	de
                            973 ;src/Map.c:226: nextVal = (position+1);
   4726 21 01 00      [10]  974 	ld	hl,#0x0001
   4729 09            [11]  975 	add	hl,bc
   472A DD 75 F7      [19]  976 	ld	-9 (ix),l
   472D DD 74 F8      [19]  977 	ld	-8 (ix),h
                            978 ;src/Map.c:227: topVal = (position-MAP_WIDTH);
   4730 79            [ 4]  979 	ld	a,c
   4731 C6 E0         [ 7]  980 	add	a,#0xE0
   4733 DD 77 F5      [19]  981 	ld	-11 (ix),a
   4736 78            [ 4]  982 	ld	a,b
   4737 CE FF         [ 7]  983 	adc	a,#0xFF
   4739 DD 77 F6      [19]  984 	ld	-10 (ix),a
                            985 ;src/Map.c:228: bottomVal = (position+MAP_WIDTH);
   473C FD 21 20 00   [14]  986 	ld	iy,#0x0020
   4740 FD 09         [15]  987 	add	iy, bc
                            988 ;src/Map.c:230: while(door_not_positioned){
   4742                     989 00138$:
   4742 DD 7E F4      [19]  990 	ld	a,-12 (ix)
   4745 B7            [ 4]  991 	or	a, a
   4746 CA 9B 48      [10]  992 	jp	Z,00141$
                            993 ;src/Map.c:231: if((*position)!=CELLTYPE_FLOOR){
   4749 0A            [ 7]  994 	ld	a,(bc)
   474A B7            [ 4]  995 	or	a, a
   474B CA 5C 48      [10]  996 	jp	Z,00135$
                            997 ;src/Map.c:232: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   474E 1A            [ 7]  998 	ld	a,(de)
   474F DD 77 FF      [19]  999 	ld	-1 (ix),a
   4752 7B            [ 4] 1000 	ld	a,e
   4753 D6 40         [ 7] 1001 	sub	a, #0x40
   4755 7A            [ 4] 1002 	ld	a,d
   4756 DE 00         [ 7] 1003 	sbc	a, #0x00
   4758 3E 00         [ 7] 1004 	ld	a,#0x00
   475A 17            [ 4] 1005 	rla
   475B DD 77 FE      [19] 1006 	ld	-2 (ix),a
   475E DD 7E F7      [19] 1007 	ld	a,-9 (ix)
   4761 DD 77 FC      [19] 1008 	ld	-4 (ix),a
   4764 DD 7E F8      [19] 1009 	ld	a,-8 (ix)
   4767 DD 77 FD      [19] 1010 	ld	-3 (ix),a
                           1011 ;src/Map.c:233: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   476A DD 6E F5      [19] 1012 	ld	l,-11 (ix)
   476D DD 66 F6      [19] 1013 	ld	h,-10 (ix)
   4770 7E            [ 7] 1014 	ld	a,(hl)
   4771 DD 77 FB      [19] 1015 	ld	-5 (ix),a
   4774 DD 7E F5      [19] 1016 	ld	a,-11 (ix)
   4777 D6 40         [ 7] 1017 	sub	a, #0x40
   4779 DD 7E F6      [19] 1018 	ld	a,-10 (ix)
   477C DE 00         [ 7] 1019 	sbc	a, #0x00
   477E 3E 00         [ 7] 1020 	ld	a,#0x00
   4780 17            [ 4] 1021 	rla
   4781 DD 77 FA      [19] 1022 	ld	-6 (ix),a
   4784 FD E5         [15] 1023 	push	iy
   4786 E1            [10] 1024 	pop	hl
                           1025 ;src/Map.c:232: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   4787 DD 7E FC      [19] 1026 	ld	a,-4 (ix)
   478A D6 40         [ 7] 1027 	sub	a, #0x40
   478C DD 7E FD      [19] 1028 	ld	a,-3 (ix)
   478F DE 04         [ 7] 1029 	sbc	a, #0x04
   4791 3E 00         [ 7] 1030 	ld	a,#0x00
   4793 17            [ 4] 1031 	rla
   4794 DD 77 FC      [19] 1032 	ld	-4 (ix),a
                           1033 ;src/Map.c:233: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   4797 7D            [ 4] 1034 	ld	a,l
   4798 D6 40         [ 7] 1035 	sub	a, #0x40
   479A 7C            [ 4] 1036 	ld	a,h
   479B DE 04         [ 7] 1037 	sbc	a, #0x04
   479D 3E 00         [ 7] 1038 	ld	a,#0x00
   479F 17            [ 4] 1039 	rla
   47A0 DD 77 F9      [19] 1040 	ld	-7 (ix),a
                           1041 ;src/Map.c:232: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   47A3 DD 7E FF      [19] 1042 	ld	a,-1 (ix)
   47A6 B7            [ 4] 1043 	or	a, a
   47A7 20 06         [12] 1044 	jr	NZ,00133$
   47A9 DD 7E FE      [19] 1045 	ld	a,-2 (ix)
   47AC B7            [ 4] 1046 	or	a, a
   47AD 28 52         [12] 1047 	jr	Z,00129$
   47AF                    1048 00133$:
   47AF DD 6E F7      [19] 1049 	ld	l,-9 (ix)
   47B2 DD 66 F8      [19] 1050 	ld	h,-8 (ix)
   47B5 7E            [ 7] 1051 	ld	a,(hl)
   47B6 B7            [ 4] 1052 	or	a, a
   47B7 20 06         [12] 1053 	jr	NZ,00128$
   47B9 DD CB FC 46   [20] 1054 	bit	0,-4 (ix)
   47BD 20 42         [12] 1055 	jr	NZ,00129$
   47BF                    1056 00128$:
                           1057 ;src/Map.c:233: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   47BF FD 6E 00      [19] 1058 	ld	l, 0 (iy)
   47C2 DD 7E FB      [19] 1059 	ld	a,-5 (ix)
   47C5 B7            [ 4] 1060 	or	a, a
   47C6 20 06         [12] 1061 	jr	NZ,00111$
   47C8 DD 7E FA      [19] 1062 	ld	a,-6 (ix)
   47CB B7            [ 4] 1063 	or	a, a
   47CC 28 14         [12] 1064 	jr	Z,00107$
   47CE                    1065 00111$:
   47CE 7D            [ 4] 1066 	ld	a,l
   47CF B7            [ 4] 1067 	or	a, a
   47D0 20 10         [12] 1068 	jr	NZ,00107$
   47D2 DD 7E F9      [19] 1069 	ld	a,-7 (ix)
   47D5 B7            [ 4] 1070 	or	a, a
   47D6 28 0A         [12] 1071 	jr	Z,00107$
                           1072 ;src/Map.c:234: door_not_positioned=0;
   47D8 DD 36 F4 00   [19] 1073 	ld	-12 (ix),#0x00
                           1074 ;src/Map.c:235: *position=CELLTYPE_DOOR;
   47DC 3E 80         [ 7] 1075 	ld	a,#0x80
   47DE 02            [ 7] 1076 	ld	(bc),a
   47DF C3 5C 48      [10] 1077 	jp	00135$
   47E2                    1078 00107$:
                           1079 ;src/Map.c:237: else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
   47E2 7D            [ 4] 1080 	ld	a,l
   47E3 B7            [ 4] 1081 	or	a, a
   47E4 20 06         [12] 1082 	jr	NZ,00105$
   47E6 DD 7E F9      [19] 1083 	ld	a,-7 (ix)
   47E9 B7            [ 4] 1084 	or	a, a
   47EA 20 70         [12] 1085 	jr	NZ,00135$
   47EC                    1086 00105$:
   47EC DD 7E FB      [19] 1087 	ld	a,-5 (ix)
   47EF B7            [ 4] 1088 	or	a, a
   47F0 20 6A         [12] 1089 	jr	NZ,00135$
   47F2 DD 7E FA      [19] 1090 	ld	a,-6 (ix)
   47F5 B7            [ 4] 1091 	or	a, a
   47F6 20 64         [12] 1092 	jr	NZ,00135$
                           1093 ;src/Map.c:238: door_not_positioned=0;
   47F8 DD 36 F4 00   [19] 1094 	ld	-12 (ix),#0x00
                           1095 ;src/Map.c:239: *position=CELLTYPE_DOOR;
   47FC 3E 80         [ 7] 1096 	ld	a,#0x80
   47FE 02            [ 7] 1097 	ld	(bc),a
   47FF 18 5B         [12] 1098 	jr	00135$
   4801                    1099 00129$:
                           1100 ;src/Map.c:242: else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
   4801 DD 7E FB      [19] 1101 	ld	a,-5 (ix)
   4804 B7            [ 4] 1102 	or	a, a
   4805 20 06         [12] 1103 	jr	NZ,00127$
   4807 DD 7E FA      [19] 1104 	ld	a,-6 (ix)
   480A B7            [ 4] 1105 	or	a, a
   480B 28 4F         [12] 1106 	jr	Z,00135$
   480D                    1107 00127$:
   480D FD 7E 00      [19] 1108 	ld	a, 0 (iy)
   4810 B7            [ 4] 1109 	or	a, a
   4811 20 06         [12] 1110 	jr	NZ,00123$
   4813 DD 7E F9      [19] 1111 	ld	a,-7 (ix)
   4816 B7            [ 4] 1112 	or	a, a
   4817 20 43         [12] 1113 	jr	NZ,00135$
   4819                    1114 00123$:
                           1115 ;src/Map.c:232: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   4819 DD 6E F7      [19] 1116 	ld	l,-9 (ix)
   481C DD 66 F8      [19] 1117 	ld	h,-8 (ix)
   481F 6E            [ 7] 1118 	ld	l,(hl)
                           1119 ;src/Map.c:243: if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
   4820 DD 7E FF      [19] 1120 	ld	a,-1 (ix)
   4823 B7            [ 4] 1121 	or	a, a
   4824 20 06         [12] 1122 	jr	NZ,00122$
   4826 DD 7E FE      [19] 1123 	ld	a,-2 (ix)
   4829 B7            [ 4] 1124 	or	a, a
   482A 28 13         [12] 1125 	jr	Z,00118$
   482C                    1126 00122$:
   482C 7D            [ 4] 1127 	ld	a,l
   482D B7            [ 4] 1128 	or	a, a
   482E 20 0F         [12] 1129 	jr	NZ,00118$
   4830 DD CB FC 46   [20] 1130 	bit	0,-4 (ix)
   4834 28 09         [12] 1131 	jr	Z,00118$
                           1132 ;src/Map.c:244: door_not_positioned=0;
   4836 DD 36 F4 00   [19] 1133 	ld	-12 (ix),#0x00
                           1134 ;src/Map.c:245: *position=CELLTYPE_DOOR;
   483A 3E 80         [ 7] 1135 	ld	a,#0x80
   483C 02            [ 7] 1136 	ld	(bc),a
   483D 18 1D         [12] 1137 	jr	00135$
   483F                    1138 00118$:
                           1139 ;src/Map.c:247: else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
   483F 7D            [ 4] 1140 	ld	a,l
   4840 B7            [ 4] 1141 	or	a, a
   4841 20 06         [12] 1142 	jr	NZ,00116$
   4843 DD CB FC 46   [20] 1143 	bit	0,-4 (ix)
   4847 20 13         [12] 1144 	jr	NZ,00135$
   4849                    1145 00116$:
   4849 DD 7E FF      [19] 1146 	ld	a,-1 (ix)
   484C B7            [ 4] 1147 	or	a, a
   484D 20 0D         [12] 1148 	jr	NZ,00135$
   484F DD 7E FE      [19] 1149 	ld	a,-2 (ix)
   4852 B7            [ 4] 1150 	or	a, a
   4853 20 07         [12] 1151 	jr	NZ,00135$
                           1152 ;src/Map.c:248: door_not_positioned=0;
   4855 DD 36 F4 00   [19] 1153 	ld	-12 (ix),#0x00
                           1154 ;src/Map.c:249: *position=CELLTYPE_DOOR;
   4859 3E 80         [ 7] 1155 	ld	a,#0x80
   485B 02            [ 7] 1156 	ld	(bc),a
   485C                    1157 00135$:
                           1158 ;src/Map.c:253: ++position;
   485C 03            [ 6] 1159 	inc	bc
                           1160 ;src/Map.c:254: ++lastVal;
   485D 13            [ 6] 1161 	inc	de
                           1162 ;src/Map.c:255: ++nextVal;
   485E DD 34 F7      [23] 1163 	inc	-9 (ix)
   4861 20 03         [12] 1164 	jr	NZ,00223$
   4863 DD 34 F8      [23] 1165 	inc	-8 (ix)
   4866                    1166 00223$:
                           1167 ;src/Map.c:256: ++topVal;
   4866 DD 34 F5      [23] 1168 	inc	-11 (ix)
   4869 20 03         [12] 1169 	jr	NZ,00224$
   486B DD 34 F6      [23] 1170 	inc	-10 (ix)
   486E                    1171 00224$:
                           1172 ;src/Map.c:257: ++bottomVal;
   486E FD 23         [10] 1173 	inc	iy
                           1174 ;src/Map.c:258: if(position==END_OF_MAP_MEM){
   4870 69            [ 4] 1175 	ld	l, c
   4871 60            [ 4] 1176 	ld	h, b
   4872 7D            [ 4] 1177 	ld	a,l
   4873 D6 40         [ 7] 1178 	sub	a, #0x40
   4875 C2 42 47      [10] 1179 	jp	NZ,00138$
   4878 7C            [ 4] 1180 	ld	a,h
   4879 D6 04         [ 7] 1181 	sub	a, #0x04
   487B C2 42 47      [10] 1182 	jp	NZ,00138$
                           1183 ;src/Map.c:259: position = MAP_MEM;
   487E 01 40 00      [10] 1184 	ld	bc,#0x0040
                           1185 ;src/Map.c:260: lastVal = (position-1);
   4881 11 3F 00      [10] 1186 	ld	de,#0x003F
                           1187 ;src/Map.c:261: nextVal = (position+1);
   4884 DD 36 F7 41   [19] 1188 	ld	-9 (ix),#0x41
   4888 DD 36 F8 00   [19] 1189 	ld	-8 (ix),#0x00
                           1190 ;src/Map.c:262: topVal = (position-MAP_WIDTH);
   488C DD 36 F5 20   [19] 1191 	ld	-11 (ix),#0x20
   4890 DD 36 F6 00   [19] 1192 	ld	-10 (ix),#0x00
                           1193 ;src/Map.c:263: bottomVal = (position+MAP_WIDTH);
   4894 FD 21 60 00   [14] 1194 	ld	iy,#0x0060
   4898 C3 42 47      [10] 1195 	jp	00138$
   489B                    1196 00141$:
   489B DD F9         [10] 1197 	ld	sp, ix
   489D DD E1         [14] 1198 	pop	ix
   489F C9            [10] 1199 	ret
                           1200 ;src/Map.c:269: void generate_level(){
                           1201 ;	---------------------------------
                           1202 ; Function generate_level
                           1203 ; ---------------------------------
   48A0                    1204 _generate_level::
                           1205 ;src/Map.c:270: generate_map();
   48A0 CD A2 41      [17] 1206 	call	_generate_map
                           1207 ;src/Map.c:271: generate_exit_door();
   48A3 CD EF 46      [17] 1208 	call	_generate_exit_door
                           1209 ;src/Map.c:272: *(u8*)(MAP_MEM + 5 + MAP_WIDTH*5)=0b00000001;
   48A6 21 E5 00      [10] 1210 	ld	hl,#0x00E5
   48A9 36 01         [10] 1211 	ld	(hl),#0x01
   48AB C9            [10] 1212 	ret
                           1213 	.area _CODE
                           1214 	.area _INITIALIZER
                           1215 	.area _CABS (ABS)
