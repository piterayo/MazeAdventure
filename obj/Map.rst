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
   4181 C3 17 64      [10]   59 	jp  _cpct_setSeed_lcg_u8
   4184                      60 _rand_seed:
   4184 00                   61 	.db #0x00	; 0
                             62 ;src/Map.c:14: u8 get_random_wall(){
                             63 ;	---------------------------------
                             64 ; Function get_random_wall
                             65 ; ---------------------------------
   4185                      66 _get_random_wall::
                             67 ;src/Map.c:15: u8 cellType = cpct_getRandom_lcg_u8();
   4185 CD B1 64      [17]   68 	call	_cpct_getRandom_lcg_u8
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
   41B7 DD 36 EF 00   [19]  110 	ld	-17 (ix),#0x00
   41BB DD 36 F0 00   [19]  111 	ld	-16 (ix),#0x00
                            112 ;src/Map.c:44: u16 lastStackItem = 0;
   41BF DD 36 ED 00   [19]  113 	ld	-19 (ix),#0x00
   41C3 DD 36 EE 00   [19]  114 	ld	-18 (ix),#0x00
                            115 ;src/Map.c:46: (*cellStack).x = (cpct_getRandom_lcg_u8()%(MAP_WIDTH-2))+1; //RANDOM
   41C7 CD B1 64      [17]  116 	call	_cpct_getRandom_lcg_u8
   41CA 45            [ 4]  117 	ld	b,l
   41CB 3E 1E         [ 7]  118 	ld	a,#0x1E
   41CD F5            [11]  119 	push	af
   41CE 33            [ 6]  120 	inc	sp
   41CF C5            [11]  121 	push	bc
   41D0 33            [ 6]  122 	inc	sp
   41D1 CD 00 64      [17]  123 	call	__moduchar
   41D4 F1            [10]  124 	pop	af
   41D5 4D            [ 4]  125 	ld	c,l
   41D6 0C            [ 4]  126 	inc	c
   41D7 21 40 29      [10]  127 	ld	hl,#0x2940
   41DA 71            [ 7]  128 	ld	(hl),c
                            129 ;src/Map.c:47: (*cellStack).y = (cpct_getRandom_lcg_u8()%(MAP_HEIGHT-2))+1; //RANDOM
   41DB CD B1 64      [17]  130 	call	_cpct_getRandom_lcg_u8
   41DE 45            [ 4]  131 	ld	b,l
   41DF 3E 1E         [ 7]  132 	ld	a,#0x1E
   41E1 F5            [11]  133 	push	af
   41E2 33            [ 6]  134 	inc	sp
   41E3 C5            [11]  135 	push	bc
   41E4 33            [ 6]  136 	inc	sp
   41E5 CD 00 64      [17]  137 	call	__moduchar
   41E8 F1            [10]  138 	pop	af
   41E9 4D            [ 4]  139 	ld	c,l
   41EA 0C            [ 4]  140 	inc	c
   41EB 21 41 29      [10]  141 	ld	hl,#0x2941
   41EE 71            [ 7]  142 	ld	(hl),c
                            143 ;src/Map.c:50: *(i8*)&(PLAYER_position.x) = (*cellStack).y;
   41EF DD 36 FB 27   [19]  144 	ld	-5 (ix),#<(_PLAYER_position)
   41F3 DD 36 FC 48   [19]  145 	ld	-4 (ix),#>(_PLAYER_position)
   41F7 2E 41         [ 7]  146 	ld	l, #0x41
   41F9 7E            [ 7]  147 	ld	a,(hl)
   41FA DD 77 FD      [19]  148 	ld	-3 (ix),a
   41FD DD 6E FB      [19]  149 	ld	l,-5 (ix)
   4200 DD 66 FC      [19]  150 	ld	h,-4 (ix)
   4203 DD 7E FD      [19]  151 	ld	a,-3 (ix)
   4206 77            [ 7]  152 	ld	(hl),a
                            153 ;src/Map.c:51: *(i8*)&(PLAYER_position.y) = (*cellStack).x;
   4207 DD 36 FB 28   [19]  154 	ld	-5 (ix),#<((_PLAYER_position + 0x0001))
   420B DD 36 FC 48   [19]  155 	ld	-4 (ix),#>((_PLAYER_position + 0x0001))
   420F 21 40 29      [10]  156 	ld	hl,#0x2940
   4212 4E            [ 7]  157 	ld	c,(hl)
   4213 DD 6E FB      [19]  158 	ld	l,-5 (ix)
   4216 DD 66 FC      [19]  159 	ld	h,-4 (ix)
   4219 71            [ 7]  160 	ld	(hl),c
                            161 ;src/Map.c:53: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   421A 21 00 04      [10]  162 	ld	hl,#0x0400
   421D E5            [11]  163 	push	hl
   421E 3E 87         [ 7]  164 	ld	a,#0x87
   4220 F5            [11]  165 	push	af
   4221 33            [ 6]  166 	inc	sp
   4222 21 40 00      [10]  167 	ld	hl,#0x0040
   4225 E5            [11]  168 	push	hl
   4226 CD D0 64      [17]  169 	call	_cpct_memset
                            170 ;src/Map.c:55: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   4229 3A 40 29      [13]  171 	ld	a,(#0x2940)
   422C DD 77 FD      [19]  172 	ld	-3 (ix), a
   422F DD 77 FB      [19]  173 	ld	-5 (ix),a
   4232 DD 36 FC 00   [19]  174 	ld	-4 (ix),#0x00
   4236 3E 06         [ 7]  175 	ld	a,#0x05+1
   4238 18 08         [12]  176 	jr	00315$
   423A                     177 00314$:
   423A DD CB FB 26   [23]  178 	sla	-5 (ix)
   423E DD CB FC 16   [23]  179 	rl	-4 (ix)
   4242                     180 00315$:
   4242 3D            [ 4]  181 	dec	a
   4243 20 F5         [12]  182 	jr	NZ,00314$
   4245 DD 7E FB      [19]  183 	ld	a,-5 (ix)
   4248 C6 40         [ 7]  184 	add	a, #0x40
   424A DD 77 FB      [19]  185 	ld	-5 (ix),a
   424D DD 7E FC      [19]  186 	ld	a,-4 (ix)
   4250 CE 00         [ 7]  187 	adc	a, #0x00
   4252 DD 77 FC      [19]  188 	ld	-4 (ix),a
   4255 21 41 29      [10]  189 	ld	hl,#0x2941
   4258 4E            [ 7]  190 	ld	c,(hl)
   4259 DD 6E FB      [19]  191 	ld	l,-5 (ix)
   425C DD 66 FC      [19]  192 	ld	h,-4 (ix)
   425F 06 00         [ 7]  193 	ld	b,#0x00
   4261 09            [11]  194 	add	hl, bc
   4262 36 00         [10]  195 	ld	(hl),#0x00
                            196 ;src/Map.c:58: for(i=0;i<MAP_WIDTH;++i){
   4264 DD 36 F3 00   [19]  197 	ld	-13 (ix),#0x00
   4268                     198 00167$:
                            199 ;src/Map.c:59: map[0][i]=get_random_wall();
   4268 DD 7E F3      [19]  200 	ld	a,-13 (ix)
   426B C6 40         [ 7]  201 	add	a, #0x40
   426D DD 77 FB      [19]  202 	ld	-5 (ix),a
   4270 3E 00         [ 7]  203 	ld	a,#0x00
   4272 CE 00         [ 7]  204 	adc	a, #0x00
   4274 DD 77 FC      [19]  205 	ld	-4 (ix),a
   4277 CD 85 41      [17]  206 	call	_get_random_wall
   427A DD 75 FD      [19]  207 	ld	-3 (ix),l
   427D DD 6E FB      [19]  208 	ld	l,-5 (ix)
   4280 DD 66 FC      [19]  209 	ld	h,-4 (ix)
   4283 DD 7E FD      [19]  210 	ld	a,-3 (ix)
   4286 77            [ 7]  211 	ld	(hl),a
                            212 ;src/Map.c:60: map[MAP_HEIGHT-1][i]=get_random_wall();
   4287 DD 7E F3      [19]  213 	ld	a,-13 (ix)
   428A C6 20         [ 7]  214 	add	a, #0x20
   428C DD 77 FB      [19]  215 	ld	-5 (ix),a
   428F 3E 00         [ 7]  216 	ld	a,#0x00
   4291 CE 04         [ 7]  217 	adc	a, #0x04
   4293 DD 77 FC      [19]  218 	ld	-4 (ix),a
   4296 CD 85 41      [17]  219 	call	_get_random_wall
   4299 4D            [ 4]  220 	ld	c,l
   429A DD 6E FB      [19]  221 	ld	l,-5 (ix)
   429D DD 66 FC      [19]  222 	ld	h,-4 (ix)
   42A0 71            [ 7]  223 	ld	(hl),c
                            224 ;src/Map.c:58: for(i=0;i<MAP_WIDTH;++i){
   42A1 DD 34 F3      [23]  225 	inc	-13 (ix)
   42A4 DD 7E F3      [19]  226 	ld	a,-13 (ix)
   42A7 D6 20         [ 7]  227 	sub	a, #0x20
   42A9 38 BD         [12]  228 	jr	C,00167$
                            229 ;src/Map.c:63: for(i=1;i<MAP_HEIGHT-1;++i){
   42AB DD 36 F3 01   [19]  230 	ld	-13 (ix),#0x01
   42AF                     231 00169$:
                            232 ;src/Map.c:64: map[i][0]=get_random_wall();
   42AF DD 7E F3      [19]  233 	ld	a,-13 (ix)
   42B2 DD 77 FB      [19]  234 	ld	-5 (ix),a
   42B5 DD 36 FC 00   [19]  235 	ld	-4 (ix),#0x00
   42B9 3E 06         [ 7]  236 	ld	a,#0x05+1
   42BB 18 08         [12]  237 	jr	00317$
   42BD                     238 00316$:
   42BD DD CB FB 26   [23]  239 	sla	-5 (ix)
   42C1 DD CB FC 16   [23]  240 	rl	-4 (ix)
   42C5                     241 00317$:
   42C5 3D            [ 4]  242 	dec	a
   42C6 20 F5         [12]  243 	jr	NZ,00316$
   42C8 DD 7E FB      [19]  244 	ld	a,-5 (ix)
   42CB C6 40         [ 7]  245 	add	a, #0x40
   42CD DD 77 FE      [19]  246 	ld	-2 (ix),a
   42D0 DD 7E FC      [19]  247 	ld	a,-4 (ix)
   42D3 CE 00         [ 7]  248 	adc	a, #0x00
   42D5 DD 77 FF      [19]  249 	ld	-1 (ix),a
   42D8 CD 85 41      [17]  250 	call	_get_random_wall
   42DB DD 75 FD      [19]  251 	ld	-3 (ix),l
   42DE DD 6E FE      [19]  252 	ld	l,-2 (ix)
   42E1 DD 66 FF      [19]  253 	ld	h,-1 (ix)
   42E4 DD 7E FD      [19]  254 	ld	a,-3 (ix)
   42E7 77            [ 7]  255 	ld	(hl),a
                            256 ;src/Map.c:65: map[i][MAP_WIDTH-1]=get_random_wall();
   42E8 DD 7E FB      [19]  257 	ld	a,-5 (ix)
   42EB C6 40         [ 7]  258 	add	a, #0x40
   42ED DD 77 FE      [19]  259 	ld	-2 (ix),a
   42F0 DD 7E FC      [19]  260 	ld	a,-4 (ix)
   42F3 CE 00         [ 7]  261 	adc	a, #0x00
   42F5 DD 77 FF      [19]  262 	ld	-1 (ix),a
   42F8 DD 7E FE      [19]  263 	ld	a,-2 (ix)
   42FB C6 1F         [ 7]  264 	add	a, #0x1F
   42FD 4F            [ 4]  265 	ld	c,a
   42FE DD 7E FF      [19]  266 	ld	a,-1 (ix)
   4301 CE 00         [ 7]  267 	adc	a, #0x00
   4303 47            [ 4]  268 	ld	b,a
   4304 C5            [11]  269 	push	bc
   4305 CD 85 41      [17]  270 	call	_get_random_wall
   4308 7D            [ 4]  271 	ld	a,l
   4309 C1            [10]  272 	pop	bc
   430A 02            [ 7]  273 	ld	(bc),a
                            274 ;src/Map.c:63: for(i=1;i<MAP_HEIGHT-1;++i){
   430B DD 34 F3      [23]  275 	inc	-13 (ix)
   430E DD 7E F3      [19]  276 	ld	a,-13 (ix)
   4311 D6 1F         [ 7]  277 	sub	a, #0x1F
   4313 38 9A         [12]  278 	jr	C,00169$
                            279 ;src/Map.c:68: while(remainingCells>0){
   4315 21 00 00      [10]  280 	ld	hl,#0x0000
   4318 39            [11]  281 	add	hl,sp
   4319 DD 75 FE      [19]  282 	ld	-2 (ix),l
   431C DD 74 FF      [19]  283 	ld	-1 (ix),h
   431F                     284 00164$:
   431F DD 7E F2      [19]  285 	ld	a,-14 (ix)
   4322 DD B6 F1      [19]  286 	or	a,-15 (ix)
   4325 CA 07 47      [10]  287 	jp	Z,00171$
                            288 ;src/Map.c:69: wallListPosition = wallList+wallListCount;
   4328 DD 6E EF      [19]  289 	ld	l,-17 (ix)
   432B DD 66 F0      [19]  290 	ld	h,-16 (ix)
   432E 29            [11]  291 	add	hl, hl
   432F 7D            [ 4]  292 	ld	a,l
   4330 C6 40         [ 7]  293 	add	a, #0x40
   4332 DD 77 FB      [19]  294 	ld	-5 (ix),a
   4335 7C            [ 4]  295 	ld	a,h
   4336 CE 2D         [ 7]  296 	adc	a, #0x2D
   4338 DD 77 FC      [19]  297 	ld	-4 (ix),a
                            298 ;src/Map.c:70: while(wallListCount<MAP_SIZE){
   433B DD 4E EF      [19]  299 	ld	c,-17 (ix)
   433E DD 46 F0      [19]  300 	ld	b,-16 (ix)
   4341                     301 00134$:
                            302 ;src/Map.c:73: currentPos.y = (*wallListPosition).y;
   4341 DD 7E FE      [19]  303 	ld	a,-2 (ix)
   4344 C6 01         [ 7]  304 	add	a, #0x01
   4346 DD 77 F9      [19]  305 	ld	-7 (ix),a
   4349 DD 7E FF      [19]  306 	ld	a,-1 (ix)
   434C CE 00         [ 7]  307 	adc	a, #0x00
   434E DD 77 FA      [19]  308 	ld	-6 (ix),a
                            309 ;src/Map.c:70: while(wallListCount<MAP_SIZE){
   4351 78            [ 4]  310 	ld	a,b
   4352 D6 04         [ 7]  311 	sub	a, #0x04
   4354 D2 F5 44      [10]  312 	jp	NC,00204$
                            313 ;src/Map.c:72: currentPos.x = (*wallListPosition).x;
   4357 21 00 00      [10]  314 	ld	hl,#0x0000
   435A 39            [11]  315 	add	hl,sp
   435B EB            [ 4]  316 	ex	de,hl
   435C DD 6E FB      [19]  317 	ld	l,-5 (ix)
   435F DD 66 FC      [19]  318 	ld	h,-4 (ix)
   4362 7E            [ 7]  319 	ld	a,(hl)
   4363 12            [ 7]  320 	ld	(de),a
                            321 ;src/Map.c:73: currentPos.y = (*wallListPosition).y;
   4364 DD 5E FB      [19]  322 	ld	e,-5 (ix)
   4367 DD 56 FC      [19]  323 	ld	d,-4 (ix)
   436A 13            [ 6]  324 	inc	de
   436B 1A            [ 7]  325 	ld	a,(de)
   436C DD 6E F9      [19]  326 	ld	l,-7 (ix)
   436F DD 66 FA      [19]  327 	ld	h,-6 (ix)
   4372 77            [ 7]  328 	ld	(hl),a
                            329 ;src/Map.c:75: convertToFloor=0;
   4373 DD 36 F4 00   [19]  330 	ld	-12 (ix),#0x00
                            331 ;src/Map.c:76: surroundedByWalls=1;
   4377 DD 36 F5 01   [19]  332 	ld	-11 (ix),#0x01
                            333 ;src/Map.c:78: if(currentPos.x>0){
   437B DD 6E FE      [19]  334 	ld	l,-2 (ix)
   437E DD 66 FF      [19]  335 	ld	h,-1 (ix)
   4381 7E            [ 7]  336 	ld	a,(hl)
   4382 DD 77 FD      [19]  337 	ld	-3 (ix),a
                            338 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   4385 DD 6E F9      [19]  339 	ld	l,-7 (ix)
   4388 DD 66 FA      [19]  340 	ld	h,-6 (ix)
   438B 7E            [ 7]  341 	ld	a,(hl)
   438C DD 77 F6      [19]  342 	ld	-10 (ix),a
   438F DD 7E FD      [19]  343 	ld	a,-3 (ix)
   4392 DD 77 F7      [19]  344 	ld	-9 (ix),a
   4395 DD 36 F8 00   [19]  345 	ld	-8 (ix),#0x00
                            346 ;src/Map.c:78: if(currentPos.x>0){
   4399 DD 7E FD      [19]  347 	ld	a,-3 (ix)
   439C B7            [ 4]  348 	or	a, a
   439D 28 2F         [12]  349 	jr	Z,00109$
                            350 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   439F DD 6E F7      [19]  351 	ld	l,-9 (ix)
   43A2 DD 66 F8      [19]  352 	ld	h,-8 (ix)
   43A5 2B            [ 6]  353 	dec	hl
   43A6 29            [11]  354 	add	hl, hl
   43A7 29            [11]  355 	add	hl, hl
   43A8 29            [11]  356 	add	hl, hl
   43A9 29            [11]  357 	add	hl, hl
   43AA 29            [11]  358 	add	hl, hl
   43AB D5            [11]  359 	push	de
   43AC 11 40 00      [10]  360 	ld	de,#0x0040
   43AF 19            [11]  361 	add	hl, de
   43B0 D1            [10]  362 	pop	de
   43B1 7D            [ 4]  363 	ld	a,l
   43B2 DD 86 F6      [19]  364 	add	a, -10 (ix)
   43B5 6F            [ 4]  365 	ld	l,a
   43B6 7C            [ 4]  366 	ld	a,h
   43B7 CE 00         [ 7]  367 	adc	a, #0x00
   43B9 67            [ 4]  368 	ld	h,a
   43BA 6E            [ 7]  369 	ld	l,(hl)
                            370 ;src/Map.c:80: if(adjacentType == CELLTYPE_UNDEFINED){
   43BB 7D            [ 4]  371 	ld	a,l
   43BC D6 87         [ 7]  372 	sub	a, #0x87
   43BE 20 06         [12]  373 	jr	NZ,00106$
                            374 ;src/Map.c:81: convertToFloor  = 1;
   43C0 DD 36 F4 01   [19]  375 	ld	-12 (ix),#0x01
   43C4 18 08         [12]  376 	jr	00109$
   43C6                     377 00106$:
                            378 ;src/Map.c:83: else if(adjacentType == CELLTYPE_FLOOR){
   43C6 7D            [ 4]  379 	ld	a,l
   43C7 B7            [ 4]  380 	or	a, a
   43C8 20 04         [12]  381 	jr	NZ,00109$
                            382 ;src/Map.c:84: surroundedByWalls = 0;
   43CA DD 36 F5 00   [19]  383 	ld	-11 (ix),#0x00
   43CE                     384 00109$:
                            385 ;src/Map.c:87: if(currentPos.x < (MAP_WIDTH-1)){
   43CE DD 7E FD      [19]  386 	ld	a,-3 (ix)
   43D1 D6 1F         [ 7]  387 	sub	a, #0x1F
   43D3 30 2F         [12]  388 	jr	NC,00116$
                            389 ;src/Map.c:89: adjacentType = map[currentPos.x+1][currentPos.y];
   43D5 DD 6E F7      [19]  390 	ld	l,-9 (ix)
   43D8 DD 66 F8      [19]  391 	ld	h,-8 (ix)
   43DB 23            [ 6]  392 	inc	hl
   43DC 29            [11]  393 	add	hl, hl
   43DD 29            [11]  394 	add	hl, hl
   43DE 29            [11]  395 	add	hl, hl
   43DF 29            [11]  396 	add	hl, hl
   43E0 29            [11]  397 	add	hl, hl
   43E1 D5            [11]  398 	push	de
   43E2 11 40 00      [10]  399 	ld	de,#0x0040
   43E5 19            [11]  400 	add	hl, de
   43E6 D1            [10]  401 	pop	de
   43E7 7D            [ 4]  402 	ld	a,l
   43E8 DD 86 F6      [19]  403 	add	a, -10 (ix)
   43EB 6F            [ 4]  404 	ld	l,a
   43EC 7C            [ 4]  405 	ld	a,h
   43ED CE 00         [ 7]  406 	adc	a, #0x00
   43EF 67            [ 4]  407 	ld	h,a
   43F0 6E            [ 7]  408 	ld	l,(hl)
                            409 ;src/Map.c:90: if(adjacentType == CELLTYPE_UNDEFINED){
   43F1 7D            [ 4]  410 	ld	a,l
   43F2 D6 87         [ 7]  411 	sub	a, #0x87
   43F4 20 06         [12]  412 	jr	NZ,00113$
                            413 ;src/Map.c:91: convertToFloor  = 1;
   43F6 DD 36 F4 01   [19]  414 	ld	-12 (ix),#0x01
   43FA 18 08         [12]  415 	jr	00116$
   43FC                     416 00113$:
                            417 ;src/Map.c:93: else if(adjacentType == CELLTYPE_FLOOR){
   43FC 7D            [ 4]  418 	ld	a,l
   43FD B7            [ 4]  419 	or	a, a
   43FE 20 04         [12]  420 	jr	NZ,00116$
                            421 ;src/Map.c:94: surroundedByWalls = 0;
   4400 DD 36 F5 00   [19]  422 	ld	-11 (ix),#0x00
   4404                     423 00116$:
                            424 ;src/Map.c:99: adjacentType = map[currentPos.x][currentPos.y-1];
   4404 DD 6E F7      [19]  425 	ld	l,-9 (ix)
   4407 DD 66 F8      [19]  426 	ld	h,-8 (ix)
   440A 29            [11]  427 	add	hl, hl
   440B 29            [11]  428 	add	hl, hl
   440C 29            [11]  429 	add	hl, hl
   440D 29            [11]  430 	add	hl, hl
   440E 29            [11]  431 	add	hl, hl
   440F 7D            [ 4]  432 	ld	a,l
   4410 C6 40         [ 7]  433 	add	a, #0x40
   4412 DD 77 F7      [19]  434 	ld	-9 (ix),a
   4415 7C            [ 4]  435 	ld	a,h
   4416 CE 00         [ 7]  436 	adc	a, #0x00
   4418 DD 77 F8      [19]  437 	ld	-8 (ix),a
                            438 ;src/Map.c:97: if(currentPos.y > 0){
   441B DD 7E F6      [19]  439 	ld	a,-10 (ix)
   441E B7            [ 4]  440 	or	a, a
   441F 28 23         [12]  441 	jr	Z,00123$
                            442 ;src/Map.c:99: adjacentType = map[currentPos.x][currentPos.y-1];
   4421 DD 6E F6      [19]  443 	ld	l,-10 (ix)
   4424 2D            [ 4]  444 	dec	l
   4425 DD 7E F7      [19]  445 	ld	a,-9 (ix)
   4428 85            [ 4]  446 	add	a, l
   4429 6F            [ 4]  447 	ld	l,a
   442A DD 7E F8      [19]  448 	ld	a,-8 (ix)
   442D CE 00         [ 7]  449 	adc	a, #0x00
   442F 67            [ 4]  450 	ld	h,a
   4430 6E            [ 7]  451 	ld	l,(hl)
                            452 ;src/Map.c:100: if(adjacentType == CELLTYPE_UNDEFINED){
   4431 7D            [ 4]  453 	ld	a,l
   4432 D6 87         [ 7]  454 	sub	a, #0x87
   4434 20 06         [12]  455 	jr	NZ,00120$
                            456 ;src/Map.c:101: convertToFloor  = 1;
   4436 DD 36 F4 01   [19]  457 	ld	-12 (ix),#0x01
   443A 18 08         [12]  458 	jr	00123$
   443C                     459 00120$:
                            460 ;src/Map.c:103: else if(adjacentType == CELLTYPE_FLOOR){
   443C 7D            [ 4]  461 	ld	a,l
   443D B7            [ 4]  462 	or	a, a
   443E 20 04         [12]  463 	jr	NZ,00123$
                            464 ;src/Map.c:104: surroundedByWalls = 0;
   4440 DD 36 F5 00   [19]  465 	ld	-11 (ix),#0x00
   4444                     466 00123$:
                            467 ;src/Map.c:107: if(currentPos.y < (MAP_HEIGHT-1)){
   4444 DD 7E F6      [19]  468 	ld	a,-10 (ix)
   4447 D6 1F         [ 7]  469 	sub	a, #0x1F
   4449 30 23         [12]  470 	jr	NC,00130$
                            471 ;src/Map.c:109: adjacentType = map[currentPos.x][currentPos.y+1];
   444B DD 6E F6      [19]  472 	ld	l,-10 (ix)
   444E 2C            [ 4]  473 	inc	l
   444F DD 7E F7      [19]  474 	ld	a,-9 (ix)
   4452 85            [ 4]  475 	add	a, l
   4453 6F            [ 4]  476 	ld	l,a
   4454 DD 7E F8      [19]  477 	ld	a,-8 (ix)
   4457 CE 00         [ 7]  478 	adc	a, #0x00
   4459 67            [ 4]  479 	ld	h,a
   445A 6E            [ 7]  480 	ld	l,(hl)
                            481 ;src/Map.c:110: if(adjacentType == CELLTYPE_UNDEFINED){
   445B 7D            [ 4]  482 	ld	a,l
   445C D6 87         [ 7]  483 	sub	a, #0x87
   445E 20 06         [12]  484 	jr	NZ,00127$
                            485 ;src/Map.c:111: convertToFloor  = 1;
   4460 DD 36 F4 01   [19]  486 	ld	-12 (ix),#0x01
   4464 18 08         [12]  487 	jr	00130$
   4466                     488 00127$:
                            489 ;src/Map.c:113: else if(adjacentType == CELLTYPE_FLOOR){
   4466 7D            [ 4]  490 	ld	a,l
   4467 B7            [ 4]  491 	or	a, a
   4468 20 04         [12]  492 	jr	NZ,00130$
                            493 ;src/Map.c:114: surroundedByWalls = 0;
   446A DD 36 F5 00   [19]  494 	ld	-11 (ix),#0x00
   446E                     495 00130$:
                            496 ;src/Map.c:118: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   446E 69            [ 4]  497 	ld	l, c
   446F 60            [ 4]  498 	ld	h, b
   4470 29            [11]  499 	add	hl, hl
   4471 FD 21 40 2D   [14]  500 	ld	iy,#0x2D40
   4475 C5            [11]  501 	push	bc
   4476 4D            [ 4]  502 	ld	c, l
   4477 44            [ 4]  503 	ld	b, h
   4478 FD 09         [15]  504 	add	iy, bc
   447A C1            [10]  505 	pop	bc
   447B FD 7E 00      [19]  506 	ld	a, 0 (iy)
   447E DD 6E FB      [19]  507 	ld	l,-5 (ix)
   4481 DD 66 FC      [19]  508 	ld	h,-4 (ix)
   4484 77            [ 7]  509 	ld	(hl),a
                            510 ;src/Map.c:119: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   4485 FD E5         [15]  511 	push	iy
   4487 E1            [10]  512 	pop	hl
   4488 23            [ 6]  513 	inc	hl
   4489 7E            [ 7]  514 	ld	a,(hl)
   448A 12            [ 7]  515 	ld	(de),a
                            516 ;src/Map.c:120: --wallListCount;
   448B 0B            [ 6]  517 	dec	bc
   448C DD 71 EF      [19]  518 	ld	-17 (ix),c
   448F DD 70 F0      [19]  519 	ld	-16 (ix),b
                            520 ;src/Map.c:123: if((convertToFloor)&&(!surroundedByWalls)){
   4492 DD 7E F4      [19]  521 	ld	a,-12 (ix)
   4495 B7            [ 4]  522 	or	a, a
   4496 28 4C         [12]  523 	jr	Z,00132$
   4498 DD 7E F5      [19]  524 	ld	a,-11 (ix)
   449B B7            [ 4]  525 	or	a, a
   449C 20 46         [12]  526 	jr	NZ,00132$
                            527 ;src/Map.c:124: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   449E DD 6E FE      [19]  528 	ld	l,-2 (ix)
   44A1 DD 66 FF      [19]  529 	ld	h,-1 (ix)
   44A4 6E            [ 7]  530 	ld	l,(hl)
   44A5 26 00         [ 7]  531 	ld	h,#0x00
   44A7 29            [11]  532 	add	hl, hl
   44A8 29            [11]  533 	add	hl, hl
   44A9 29            [11]  534 	add	hl, hl
   44AA 29            [11]  535 	add	hl, hl
   44AB 29            [11]  536 	add	hl, hl
   44AC 01 40 00      [10]  537 	ld	bc,#0x0040
   44AF 09            [11]  538 	add	hl,bc
   44B0 4D            [ 4]  539 	ld	c,l
   44B1 44            [ 4]  540 	ld	b,h
   44B2 DD 6E F9      [19]  541 	ld	l,-7 (ix)
   44B5 DD 66 FA      [19]  542 	ld	h,-6 (ix)
   44B8 6E            [ 7]  543 	ld	l, (hl)
   44B9 26 00         [ 7]  544 	ld	h,#0x00
   44BB 09            [11]  545 	add	hl,bc
   44BC 36 00         [10]  546 	ld	(hl),#0x00
                            547 ;src/Map.c:126: ++lastStackItem;
   44BE DD 34 ED      [23]  548 	inc	-19 (ix)
   44C1 20 03         [12]  549 	jr	NZ,00326$
   44C3 DD 34 EE      [23]  550 	inc	-18 (ix)
   44C6                     551 00326$:
                            552 ;src/Map.c:127: (*(cellStack+lastStackItem)).x = currentPos.x;
   44C6 C1            [10]  553 	pop	bc
   44C7 E1            [10]  554 	pop	hl
   44C8 E5            [11]  555 	push	hl
   44C9 C5            [11]  556 	push	bc
   44CA 29            [11]  557 	add	hl, hl
   44CB 01 40 29      [10]  558 	ld	bc, #0x2940
   44CE 09            [11]  559 	add	hl,bc
   44CF 4D            [ 4]  560 	ld	c, l
   44D0 44            [ 4]  561 	ld	b, h
   44D1 DD 6E FE      [19]  562 	ld	l,-2 (ix)
   44D4 DD 66 FF      [19]  563 	ld	h,-1 (ix)
   44D7 7E            [ 7]  564 	ld	a,(hl)
   44D8 02            [ 7]  565 	ld	(bc),a
                            566 ;src/Map.c:128: (*(cellStack+lastStackItem)).y = currentPos.y;
   44D9 03            [ 6]  567 	inc	bc
   44DA DD 6E F9      [19]  568 	ld	l,-7 (ix)
   44DD DD 66 FA      [19]  569 	ld	h,-6 (ix)
   44E0 7E            [ 7]  570 	ld	a,(hl)
   44E1 02            [ 7]  571 	ld	(bc),a
                            572 ;src/Map.c:131: break;
   44E2 18 11         [12]  573 	jr	00204$
   44E4                     574 00132$:
                            575 ;src/Map.c:133: --wallListPosition;
   44E4 DD 6E FB      [19]  576 	ld	l,-5 (ix)
   44E7 DD 66 FC      [19]  577 	ld	h,-4 (ix)
   44EA 2B            [ 6]  578 	dec	hl
   44EB 2B            [ 6]  579 	dec	hl
   44EC DD 75 FB      [19]  580 	ld	-5 (ix),l
   44EF DD 74 FC      [19]  581 	ld	-4 (ix),h
   44F2 C3 41 43      [10]  582 	jp	00134$
                            583 ;src/Map.c:135: while(lastStackItem<MAP_SIZE){
   44F5                     584 00204$:
   44F5 DD 7E F1      [19]  585 	ld	a,-15 (ix)
   44F8 DD 77 F7      [19]  586 	ld	-9 (ix),a
   44FB DD 7E F2      [19]  587 	ld	a,-14 (ix)
   44FE DD 77 F8      [19]  588 	ld	-8 (ix),a
   4501 DD 7E EF      [19]  589 	ld	a,-17 (ix)
   4504 DD 77 FB      [19]  590 	ld	-5 (ix),a
   4507 DD 7E F0      [19]  591 	ld	a,-16 (ix)
   450A DD 77 FC      [19]  592 	ld	-4 (ix),a
   450D                     593 00161$:
   450D DD 7E EE      [19]  594 	ld	a,-18 (ix)
   4510 D6 04         [ 7]  595 	sub	a, #0x04
   4512 D2 1F 43      [10]  596 	jp	NC,00164$
                            597 ;src/Map.c:136: currentPos.x=(*(lastStackItem+cellStack)).x;
   4515 21 00 00      [10]  598 	ld	hl,#0x0000
   4518 39            [11]  599 	add	hl,sp
   4519 4D            [ 4]  600 	ld	c,l
   451A 44            [ 4]  601 	ld	b,h
   451B D1            [10]  602 	pop	de
   451C E1            [10]  603 	pop	hl
   451D E5            [11]  604 	push	hl
   451E D5            [11]  605 	push	de
   451F 29            [11]  606 	add	hl, hl
   4520 FD 21 40 29   [14]  607 	ld	iy,#0x2940
   4524 EB            [ 4]  608 	ex	de,hl
   4525 FD 19         [15]  609 	add	iy, de
   4527 FD 7E 00      [19]  610 	ld	a, 0 (iy)
   452A 02            [ 7]  611 	ld	(bc),a
                            612 ;src/Map.c:137: currentPos.y=(*(lastStackItem+cellStack)).y;
   452B FD 4E 01      [19]  613 	ld	c,1 (iy)
   452E DD 6E F9      [19]  614 	ld	l,-7 (ix)
   4531 DD 66 FA      [19]  615 	ld	h,-6 (ix)
   4534 71            [ 7]  616 	ld	(hl),c
                            617 ;src/Map.c:138: --lastStackItem;
   4535 DD 6E ED      [19]  618 	ld	l,-19 (ix)
   4538 DD 66 EE      [19]  619 	ld	h,-18 (ix)
   453B 2B            [ 6]  620 	dec	hl
   453C DD 75 ED      [19]  621 	ld	-19 (ix),l
   453F DD 74 EE      [19]  622 	ld	-18 (ix),h
                            623 ;src/Map.c:139: cellType = map[currentPos.x][currentPos.y];
   4542 DD 6E FE      [19]  624 	ld	l,-2 (ix)
   4545 DD 66 FF      [19]  625 	ld	h,-1 (ix)
   4548 6E            [ 7]  626 	ld	l,(hl)
   4549 26 00         [ 7]  627 	ld	h,#0x00
   454B 29            [11]  628 	add	hl, hl
   454C 29            [11]  629 	add	hl, hl
   454D 29            [11]  630 	add	hl, hl
   454E 29            [11]  631 	add	hl, hl
   454F 29            [11]  632 	add	hl, hl
   4550 11 40 00      [10]  633 	ld	de,#0x0040
   4553 19            [11]  634 	add	hl,de
   4554 59            [ 4]  635 	ld	e,c
   4555 16 00         [ 7]  636 	ld	d,#0x00
   4557 19            [11]  637 	add	hl,de
   4558 4E            [ 7]  638 	ld	c,(hl)
                            639 ;src/Map.c:141: if(cellType == CELLTYPE_UNDEFINED){
   4559 79            [ 4]  640 	ld	a,c
   455A D6 87         [ 7]  641 	sub	a, #0x87
   455C 20 47         [12]  642 	jr	NZ,00141$
                            643 ;src/Map.c:143: if(cpct_getRandom_lcg_u8()&1){//WALL
   455E CD B1 64      [17]  644 	call	_cpct_getRandom_lcg_u8
   4561 CB 45         [ 8]  645 	bit	0, l
   4563 28 06         [12]  646 	jr	Z,00138$
                            647 ;src/Map.c:144: cellType = get_random_wall();
   4565 CD 85 41      [17]  648 	call	_get_random_wall
   4568 4D            [ 4]  649 	ld	c,l
   4569 18 02         [12]  650 	jr	00139$
   456B                     651 00138$:
                            652 ;src/Map.c:147: cellType = CELLTYPE_FLOOR;
   456B 0E 00         [ 7]  653 	ld	c,#0x00
   456D                     654 00139$:
                            655 ;src/Map.c:149: map[currentPos.x][currentPos.y]=cellType;
   456D DD 6E FE      [19]  656 	ld	l,-2 (ix)
   4570 DD 66 FF      [19]  657 	ld	h,-1 (ix)
   4573 6E            [ 7]  658 	ld	l,(hl)
   4574 26 00         [ 7]  659 	ld	h,#0x00
   4576 29            [11]  660 	add	hl, hl
   4577 29            [11]  661 	add	hl, hl
   4578 29            [11]  662 	add	hl, hl
   4579 29            [11]  663 	add	hl, hl
   457A 29            [11]  664 	add	hl, hl
   457B EB            [ 4]  665 	ex	de,hl
   457C 21 40 00      [10]  666 	ld	hl,#0x0040
   457F 19            [11]  667 	add	hl,de
   4580 EB            [ 4]  668 	ex	de,hl
   4581 DD 6E F9      [19]  669 	ld	l,-7 (ix)
   4584 DD 66 FA      [19]  670 	ld	h,-6 (ix)
   4587 6E            [ 7]  671 	ld	l, (hl)
   4588 26 00         [ 7]  672 	ld	h,#0x00
   458A 19            [11]  673 	add	hl,de
   458B 71            [ 7]  674 	ld	(hl),c
                            675 ;src/Map.c:150: --remainingCells;
   458C DD 6E F7      [19]  676 	ld	l,-9 (ix)
   458F DD 66 F8      [19]  677 	ld	h,-8 (ix)
   4592 2B            [ 6]  678 	dec	hl
   4593 DD 75 F7      [19]  679 	ld	-9 (ix),l
   4596 DD 74 F8      [19]  680 	ld	-8 (ix),h
   4599 DD 7E F7      [19]  681 	ld	a,-9 (ix)
   459C DD 77 F1      [19]  682 	ld	-15 (ix),a
   459F DD 7E F8      [19]  683 	ld	a,-8 (ix)
   45A2 DD 77 F2      [19]  684 	ld	-14 (ix),a
   45A5                     685 00141$:
                            686 ;src/Map.c:78: if(currentPos.x>0){
   45A5 DD 6E FE      [19]  687 	ld	l,-2 (ix)
   45A8 DD 66 FF      [19]  688 	ld	h,-1 (ix)
   45AB 7E            [ 7]  689 	ld	a,(hl)
   45AC DD 77 F6      [19]  690 	ld	-10 (ix),a
                            691 ;src/Map.c:153: if((cellType == CELLTYPE_FLOOR)){
   45AF 79            [ 4]  692 	ld	a,c
   45B0 B7            [ 4]  693 	or	a, a
   45B1 C2 D6 46      [10]  694 	jp	NZ,00159$
                            695 ;src/Map.c:154: if(currentPos.x>0){
   45B4 DD 7E F6      [19]  696 	ld	a,-10 (ix)
   45B7 B7            [ 4]  697 	or	a, a
   45B8 28 41         [12]  698 	jr	Z,00145$
                            699 ;src/Map.c:155: adjacentType = map[currentPos.x-1][currentPos.y];
   45BA DD 6E F6      [19]  700 	ld	l,-10 (ix)
   45BD 26 00         [ 7]  701 	ld	h,#0x00
   45BF 2B            [ 6]  702 	dec	hl
   45C0 29            [11]  703 	add	hl, hl
   45C1 29            [11]  704 	add	hl, hl
   45C2 29            [11]  705 	add	hl, hl
   45C3 29            [11]  706 	add	hl, hl
   45C4 29            [11]  707 	add	hl, hl
   45C5 01 40 00      [10]  708 	ld	bc,#0x0040
   45C8 09            [11]  709 	add	hl,bc
   45C9 4D            [ 4]  710 	ld	c,l
   45CA 44            [ 4]  711 	ld	b,h
   45CB DD 6E F9      [19]  712 	ld	l,-7 (ix)
   45CE DD 66 FA      [19]  713 	ld	h,-6 (ix)
   45D1 6E            [ 7]  714 	ld	l, (hl)
   45D2 26 00         [ 7]  715 	ld	h,#0x00
   45D4 09            [11]  716 	add	hl,bc
   45D5 7E            [ 7]  717 	ld	a,(hl)
                            718 ;src/Map.c:156: if(adjacentType == CELLTYPE_UNDEFINED){
   45D6 D6 87         [ 7]  719 	sub	a, #0x87
   45D8 20 21         [12]  720 	jr	NZ,00145$
                            721 ;src/Map.c:158: ++lastStackItem;
   45DA DD 34 ED      [23]  722 	inc	-19 (ix)
   45DD 20 03         [12]  723 	jr	NZ,00332$
   45DF DD 34 EE      [23]  724 	inc	-18 (ix)
   45E2                     725 00332$:
                            726 ;src/Map.c:159: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   45E2 C1            [10]  727 	pop	bc
   45E3 E1            [10]  728 	pop	hl
   45E4 E5            [11]  729 	push	hl
   45E5 C5            [11]  730 	push	bc
   45E6 29            [11]  731 	add	hl, hl
   45E7 01 40 29      [10]  732 	ld	bc,#0x2940
   45EA 09            [11]  733 	add	hl,bc
   45EB DD 4E F6      [19]  734 	ld	c,-10 (ix)
   45EE 0D            [ 4]  735 	dec	c
   45EF 71            [ 7]  736 	ld	(hl),c
                            737 ;src/Map.c:160: (*(cellStack+lastStackItem)).y = currentPos.y;
   45F0 23            [ 6]  738 	inc	hl
   45F1 4D            [ 4]  739 	ld	c,l
   45F2 44            [ 4]  740 	ld	b,h
   45F3 DD 6E F9      [19]  741 	ld	l,-7 (ix)
   45F6 DD 66 FA      [19]  742 	ld	h,-6 (ix)
   45F9 7E            [ 7]  743 	ld	a,(hl)
   45FA 02            [ 7]  744 	ld	(bc),a
   45FB                     745 00145$:
                            746 ;src/Map.c:164: if(currentPos.x < (MAP_WIDTH-1)){
   45FB DD 6E FE      [19]  747 	ld	l,-2 (ix)
   45FE DD 66 FF      [19]  748 	ld	h,-1 (ix)
   4601 4E            [ 7]  749 	ld	c,(hl)
   4602 79            [ 4]  750 	ld	a,c
   4603 D6 1F         [ 7]  751 	sub	a, #0x1F
   4605 30 3C         [12]  752 	jr	NC,00149$
                            753 ;src/Map.c:166: adjacentType = map[currentPos.x+1][currentPos.y];
   4607 69            [ 4]  754 	ld	l,c
   4608 26 00         [ 7]  755 	ld	h,#0x00
   460A 23            [ 6]  756 	inc	hl
   460B 29            [11]  757 	add	hl, hl
   460C 29            [11]  758 	add	hl, hl
   460D 29            [11]  759 	add	hl, hl
   460E 29            [11]  760 	add	hl, hl
   460F 29            [11]  761 	add	hl, hl
   4610 EB            [ 4]  762 	ex	de,hl
   4611 21 40 00      [10]  763 	ld	hl,#0x0040
   4614 19            [11]  764 	add	hl,de
   4615 EB            [ 4]  765 	ex	de,hl
   4616 DD 6E F9      [19]  766 	ld	l,-7 (ix)
   4619 DD 66 FA      [19]  767 	ld	h,-6 (ix)
   461C 6E            [ 7]  768 	ld	l, (hl)
   461D 26 00         [ 7]  769 	ld	h,#0x00
   461F 19            [11]  770 	add	hl,de
   4620 7E            [ 7]  771 	ld	a,(hl)
                            772 ;src/Map.c:167: if(adjacentType == CELLTYPE_UNDEFINED){
   4621 D6 87         [ 7]  773 	sub	a, #0x87
   4623 20 1E         [12]  774 	jr	NZ,00149$
                            775 ;src/Map.c:170: ++lastStackItem;
   4625 DD 34 ED      [23]  776 	inc	-19 (ix)
   4628 20 03         [12]  777 	jr	NZ,00335$
   462A DD 34 EE      [23]  778 	inc	-18 (ix)
   462D                     779 00335$:
                            780 ;src/Map.c:171: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   462D D1            [10]  781 	pop	de
   462E E1            [10]  782 	pop	hl
   462F E5            [11]  783 	push	hl
   4630 D5            [11]  784 	push	de
   4631 29            [11]  785 	add	hl, hl
   4632 11 40 29      [10]  786 	ld	de,#0x2940
   4635 19            [11]  787 	add	hl,de
   4636 0C            [ 4]  788 	inc	c
   4637 71            [ 7]  789 	ld	(hl),c
                            790 ;src/Map.c:172: (*(cellStack+lastStackItem)).y = currentPos.y;
   4638 23            [ 6]  791 	inc	hl
   4639 4D            [ 4]  792 	ld	c,l
   463A 44            [ 4]  793 	ld	b,h
   463B DD 6E F9      [19]  794 	ld	l,-7 (ix)
   463E DD 66 FA      [19]  795 	ld	h,-6 (ix)
   4641 7E            [ 7]  796 	ld	a,(hl)
   4642 02            [ 7]  797 	ld	(bc),a
   4643                     798 00149$:
                            799 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   4643 DD 6E F9      [19]  800 	ld	l,-7 (ix)
   4646 DD 66 FA      [19]  801 	ld	h,-6 (ix)
   4649 4E            [ 7]  802 	ld	c,(hl)
                            803 ;src/Map.c:176: if(currentPos.y > 0){
   464A 79            [ 4]  804 	ld	a,c
   464B B7            [ 4]  805 	or	a, a
   464C 28 3C         [12]  806 	jr	Z,00153$
                            807 ;src/Map.c:178: adjacentType = map[currentPos.x][currentPos.y-1];
   464E DD 6E FE      [19]  808 	ld	l,-2 (ix)
   4651 DD 66 FF      [19]  809 	ld	h,-1 (ix)
   4654 46            [ 7]  810 	ld	b,(hl)
   4655 68            [ 4]  811 	ld	l,b
   4656 26 00         [ 7]  812 	ld	h,#0x00
   4658 29            [11]  813 	add	hl, hl
   4659 29            [11]  814 	add	hl, hl
   465A 29            [11]  815 	add	hl, hl
   465B 29            [11]  816 	add	hl, hl
   465C 29            [11]  817 	add	hl, hl
   465D 11 40 00      [10]  818 	ld	de,#0x0040
   4660 19            [11]  819 	add	hl,de
   4661 0D            [ 4]  820 	dec	c
   4662 59            [ 4]  821 	ld	e,c
   4663 16 00         [ 7]  822 	ld	d,#0x00
   4665 19            [11]  823 	add	hl,de
   4666 7E            [ 7]  824 	ld	a,(hl)
                            825 ;src/Map.c:179: if(adjacentType == CELLTYPE_UNDEFINED){
   4667 D6 87         [ 7]  826 	sub	a, #0x87
   4669 20 1F         [12]  827 	jr	NZ,00153$
                            828 ;src/Map.c:182: ++lastStackItem;
   466B DD 34 ED      [23]  829 	inc	-19 (ix)
   466E 20 03         [12]  830 	jr	NZ,00338$
   4670 DD 34 EE      [23]  831 	inc	-18 (ix)
   4673                     832 00338$:
                            833 ;src/Map.c:183: (*(cellStack+lastStackItem)).x = currentPos.x;
   4673 D1            [10]  834 	pop	de
   4674 E1            [10]  835 	pop	hl
   4675 E5            [11]  836 	push	hl
   4676 D5            [11]  837 	push	de
   4677 29            [11]  838 	add	hl, hl
   4678 11 40 29      [10]  839 	ld	de,#0x2940
   467B 19            [11]  840 	add	hl,de
   467C 70            [ 7]  841 	ld	(hl),b
                            842 ;src/Map.c:184: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   467D 23            [ 6]  843 	inc	hl
   467E 4D            [ 4]  844 	ld	c,l
   467F 44            [ 4]  845 	ld	b,h
   4680 DD 6E F9      [19]  846 	ld	l,-7 (ix)
   4683 DD 66 FA      [19]  847 	ld	h,-6 (ix)
   4686 5E            [ 7]  848 	ld	e,(hl)
   4687 1D            [ 4]  849 	dec	e
   4688 7B            [ 4]  850 	ld	a,e
   4689 02            [ 7]  851 	ld	(bc),a
   468A                     852 00153$:
                            853 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   468A DD 6E F9      [19]  854 	ld	l,-7 (ix)
   468D DD 66 FA      [19]  855 	ld	h,-6 (ix)
   4690 46            [ 7]  856 	ld	b,(hl)
                            857 ;src/Map.c:188: if(currentPos.y < (MAP_HEIGHT-1)){
   4691 78            [ 4]  858 	ld	a,b
   4692 D6 1F         [ 7]  859 	sub	a, #0x1F
   4694 D2 0D 45      [10]  860 	jp	NC,00161$
                            861 ;src/Map.c:190: adjacentType = map[currentPos.x][currentPos.y+1];
   4697 DD 6E FE      [19]  862 	ld	l,-2 (ix)
   469A DD 66 FF      [19]  863 	ld	h,-1 (ix)
   469D 4E            [ 7]  864 	ld	c,(hl)
   469E 69            [ 4]  865 	ld	l,c
   469F 26 00         [ 7]  866 	ld	h,#0x00
   46A1 29            [11]  867 	add	hl, hl
   46A2 29            [11]  868 	add	hl, hl
   46A3 29            [11]  869 	add	hl, hl
   46A4 29            [11]  870 	add	hl, hl
   46A5 29            [11]  871 	add	hl, hl
   46A6 11 40 00      [10]  872 	ld	de,#0x0040
   46A9 19            [11]  873 	add	hl,de
   46AA 04            [ 4]  874 	inc	b
   46AB 58            [ 4]  875 	ld	e,b
   46AC 16 00         [ 7]  876 	ld	d,#0x00
   46AE 19            [11]  877 	add	hl,de
   46AF 7E            [ 7]  878 	ld	a,(hl)
                            879 ;src/Map.c:191: if(adjacentType == CELLTYPE_UNDEFINED){
   46B0 D6 87         [ 7]  880 	sub	a, #0x87
   46B2 C2 0D 45      [10]  881 	jp	NZ,00161$
                            882 ;src/Map.c:194: ++lastStackItem;
   46B5 DD 34 ED      [23]  883 	inc	-19 (ix)
   46B8 20 03         [12]  884 	jr	NZ,00341$
   46BA DD 34 EE      [23]  885 	inc	-18 (ix)
   46BD                     886 00341$:
                            887 ;src/Map.c:195: (*(cellStack+lastStackItem)).x = currentPos.x;
   46BD D1            [10]  888 	pop	de
   46BE E1            [10]  889 	pop	hl
   46BF E5            [11]  890 	push	hl
   46C0 D5            [11]  891 	push	de
   46C1 29            [11]  892 	add	hl, hl
   46C2 11 40 29      [10]  893 	ld	de,#0x2940
   46C5 19            [11]  894 	add	hl,de
   46C6 71            [ 7]  895 	ld	(hl),c
                            896 ;src/Map.c:196: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   46C7 23            [ 6]  897 	inc	hl
   46C8 4D            [ 4]  898 	ld	c,l
   46C9 44            [ 4]  899 	ld	b,h
   46CA DD 6E F9      [19]  900 	ld	l,-7 (ix)
   46CD DD 66 FA      [19]  901 	ld	h,-6 (ix)
   46D0 7E            [ 7]  902 	ld	a,(hl)
   46D1 3C            [ 4]  903 	inc	a
   46D2 02            [ 7]  904 	ld	(bc),a
   46D3 C3 0D 45      [10]  905 	jp	00161$
   46D6                     906 00159$:
                            907 ;src/Map.c:202: ++wallListCount;
   46D6 DD 34 FB      [23]  908 	inc	-5 (ix)
   46D9 20 03         [12]  909 	jr	NZ,00342$
   46DB DD 34 FC      [23]  910 	inc	-4 (ix)
   46DE                     911 00342$:
   46DE DD 7E FB      [19]  912 	ld	a,-5 (ix)
   46E1 DD 77 EF      [19]  913 	ld	-17 (ix),a
   46E4 DD 7E FC      [19]  914 	ld	a,-4 (ix)
   46E7 DD 77 F0      [19]  915 	ld	-16 (ix),a
                            916 ;src/Map.c:203: (*(wallList+wallListCount)).x = currentPos.x;
   46EA DD 6E FB      [19]  917 	ld	l,-5 (ix)
   46ED DD 66 FC      [19]  918 	ld	h,-4 (ix)
   46F0 29            [11]  919 	add	hl, hl
   46F1 01 40 2D      [10]  920 	ld	bc,#0x2D40
   46F4 09            [11]  921 	add	hl,bc
   46F5 DD 7E F6      [19]  922 	ld	a,-10 (ix)
   46F8 77            [ 7]  923 	ld	(hl),a
                            924 ;src/Map.c:204: (*(wallList+wallListCount)).y = currentPos.y;
   46F9 23            [ 6]  925 	inc	hl
   46FA 4D            [ 4]  926 	ld	c,l
   46FB 44            [ 4]  927 	ld	b,h
   46FC DD 6E F9      [19]  928 	ld	l,-7 (ix)
   46FF DD 66 FA      [19]  929 	ld	h,-6 (ix)
   4702 7E            [ 7]  930 	ld	a,(hl)
   4703 02            [ 7]  931 	ld	(bc),a
   4704 C3 0D 45      [10]  932 	jp	00161$
   4707                     933 00171$:
   4707 DD F9         [10]  934 	ld	sp, ix
   4709 DD E1         [14]  935 	pop	ix
   470B C9            [10]  936 	ret
                            937 ;src/Map.c:210: void generate_exit_door(){
                            938 ;	---------------------------------
                            939 ; Function generate_exit_door
                            940 ; ---------------------------------
   470C                     941 _generate_exit_door::
   470C DD E5         [15]  942 	push	ix
   470E DD 21 00 00   [14]  943 	ld	ix,#0
   4712 DD 39         [15]  944 	add	ix,sp
   4714 21 F9 FF      [10]  945 	ld	hl,#-7
   4717 39            [11]  946 	add	hl,sp
   4718 F9            [ 6]  947 	ld	sp,hl
                            948 ;src/Map.c:211: u8 x=(cpct_getRandom_lcg_u8()%32);
   4719 CD B1 64      [17]  949 	call	_cpct_getRandom_lcg_u8
   471C 7D            [ 4]  950 	ld	a,l
   471D E6 1F         [ 7]  951 	and	a, #0x1F
   471F 4F            [ 4]  952 	ld	c,a
                            953 ;src/Map.c:212: u8 y=(cpct_getRandom_lcg_u8()%32);
   4720 C5            [11]  954 	push	bc
   4721 CD B1 64      [17]  955 	call	_cpct_getRandom_lcg_u8
   4724 C1            [10]  956 	pop	bc
   4725 7D            [ 4]  957 	ld	a,l
   4726 E6 1F         [ 7]  958 	and	a, #0x1F
   4728 5F            [ 4]  959 	ld	e,a
                            960 ;src/Map.c:213: u8 door_not_positioned=1;
   4729 DD 36 FD 01   [19]  961 	ld	-3 (ix),#0x01
                            962 ;src/Map.c:220: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
   472D 06 00         [ 7]  963 	ld	b,#0x00
   472F 21 40 00      [10]  964 	ld	hl,#0x0040
   4732 09            [11]  965 	add	hl,bc
   4733 4D            [ 4]  966 	ld	c,l
   4734 44            [ 4]  967 	ld	b,h
   4735 6B            [ 4]  968 	ld	l,e
   4736 26 00         [ 7]  969 	ld	h,#0x00
   4738 29            [11]  970 	add	hl, hl
   4739 29            [11]  971 	add	hl, hl
   473A 29            [11]  972 	add	hl, hl
   473B 29            [11]  973 	add	hl, hl
   473C 29            [11]  974 	add	hl, hl
   473D 09            [11]  975 	add	hl,bc
   473E 4D            [ 4]  976 	ld	c,l
   473F 44            [ 4]  977 	ld	b,h
                            978 ;src/Map.c:225: lastVal = (position-1);
   4740 59            [ 4]  979 	ld	e,c
   4741 50            [ 4]  980 	ld	d,b
   4742 1B            [ 6]  981 	dec	de
                            982 ;src/Map.c:226: nextVal = (position+1);
   4743 C5            [11]  983 	push	bc
   4744 FD E1         [14]  984 	pop	iy
   4746 FD 23         [10]  985 	inc	iy
                            986 ;src/Map.c:227: topVal = (position-MAP_WIDTH);
   4748 79            [ 4]  987 	ld	a,c
   4749 C6 E0         [ 7]  988 	add	a,#0xE0
   474B DD 77 F9      [19]  989 	ld	-7 (ix),a
   474E 78            [ 4]  990 	ld	a,b
   474F CE FF         [ 7]  991 	adc	a,#0xFF
   4751 DD 77 FA      [19]  992 	ld	-6 (ix),a
                            993 ;src/Map.c:228: bottomVal = (position+MAP_WIDTH);
   4754 21 20 00      [10]  994 	ld	hl,#0x0020
   4757 09            [11]  995 	add	hl,bc
   4758 DD 75 FB      [19]  996 	ld	-5 (ix),l
   475B DD 74 FC      [19]  997 	ld	-4 (ix),h
                            998 ;src/Map.c:230: while(door_not_positioned){
   475E                     999 00126$:
   475E DD 7E FD      [19] 1000 	ld	a,-3 (ix)
   4761 B7            [ 4] 1001 	or	a, a
   4762 CA 1C 48      [10] 1002 	jp	Z,00129$
                           1003 ;src/Map.c:231: if((*position)!=CELLTYPE_FLOOR){
   4765 0A            [ 7] 1004 	ld	a,(bc)
   4766 B7            [ 4] 1005 	or	a, a
   4767 CA E4 47      [10] 1006 	jp	Z,00123$
                           1007 ;src/Map.c:232: if(((*lastVal)!=CELLTYPE_FLOOR) && ((*nextVal)!=CELLTYPE_FLOOR)){
   476A 1A            [ 7] 1008 	ld	a,(de)
   476B DD 77 FF      [19] 1009 	ld	-1 (ix),a
                           1010 ;src/Map.c:233: if(((*topVal)!=CELLTYPE_FLOOR) && ((*bottomVal)==CELLTYPE_FLOOR)){
   476E E1            [10] 1011 	pop	hl
   476F E5            [11] 1012 	push	hl
   4770 7E            [ 7] 1013 	ld	a,(hl)
   4771 DD 77 FE      [19] 1014 	ld	-2 (ix),a
                           1015 ;src/Map.c:232: if(((*lastVal)!=CELLTYPE_FLOOR) && ((*nextVal)!=CELLTYPE_FLOOR)){
   4774 DD 7E FF      [19] 1016 	ld	a,-1 (ix)
   4777 B7            [ 4] 1017 	or	a, a
   4778 28 33         [12] 1018 	jr	Z,00119$
   477A FD 7E 00      [19] 1019 	ld	a, 0 (iy)
   477D B7            [ 4] 1020 	or	a, a
   477E 28 2D         [12] 1021 	jr	Z,00119$
                           1022 ;src/Map.c:233: if(((*topVal)!=CELLTYPE_FLOOR) && ((*bottomVal)==CELLTYPE_FLOOR)){
   4780 DD 6E FB      [19] 1023 	ld	l,-5 (ix)
   4783 DD 66 FC      [19] 1024 	ld	h,-4 (ix)
   4786 6E            [ 7] 1025 	ld	l,(hl)
   4787 DD 7E FE      [19] 1026 	ld	a,-2 (ix)
   478A B7            [ 4] 1027 	or	a, a
   478B 28 0D         [12] 1028 	jr	Z,00105$
   478D 7D            [ 4] 1029 	ld	a,l
   478E B7            [ 4] 1030 	or	a, a
   478F 20 09         [12] 1031 	jr	NZ,00105$
                           1032 ;src/Map.c:234: door_not_positioned=0;
   4791 DD 36 FD 00   [19] 1033 	ld	-3 (ix),#0x00
                           1034 ;src/Map.c:235: *position=CELLTYPE_DOOR;
   4795 3E 80         [ 7] 1035 	ld	a,#0x80
   4797 02            [ 7] 1036 	ld	(bc),a
   4798 18 4A         [12] 1037 	jr	00123$
   479A                    1038 00105$:
                           1039 ;src/Map.c:237: else if(((*bottomVal)!=CELLTYPE_FLOOR) && ((*topVal)==CELLTYPE_FLOOR)){
   479A 7D            [ 4] 1040 	ld	a,l
   479B B7            [ 4] 1041 	or	a, a
   479C 28 46         [12] 1042 	jr	Z,00123$
   479E DD 7E FE      [19] 1043 	ld	a,-2 (ix)
   47A1 B7            [ 4] 1044 	or	a, a
   47A2 20 40         [12] 1045 	jr	NZ,00123$
                           1046 ;src/Map.c:238: door_not_positioned=0;
   47A4 DD 36 FD 00   [19] 1047 	ld	-3 (ix),#0x00
                           1048 ;src/Map.c:239: *position=CELLTYPE_DOOR;
   47A8 3E 80         [ 7] 1049 	ld	a,#0x80
   47AA 02            [ 7] 1050 	ld	(bc),a
   47AB 18 37         [12] 1051 	jr	00123$
   47AD                    1052 00119$:
                           1053 ;src/Map.c:242: else if(((*topVal)!=CELLTYPE_FLOOR) && ((*bottomVal)!=CELLTYPE_FLOOR)){
   47AD DD 7E FE      [19] 1054 	ld	a,-2 (ix)
   47B0 B7            [ 4] 1055 	or	a, a
   47B1 28 31         [12] 1056 	jr	Z,00123$
   47B3 DD 6E FB      [19] 1057 	ld	l,-5 (ix)
   47B6 DD 66 FC      [19] 1058 	ld	h,-4 (ix)
   47B9 7E            [ 7] 1059 	ld	a,(hl)
   47BA B7            [ 4] 1060 	or	a, a
   47BB 28 27         [12] 1061 	jr	Z,00123$
                           1062 ;src/Map.c:232: if(((*lastVal)!=CELLTYPE_FLOOR) && ((*nextVal)!=CELLTYPE_FLOOR)){
   47BD FD 6E 00      [19] 1063 	ld	l, 0 (iy)
                           1064 ;src/Map.c:243: if(((*lastVal)!=CELLTYPE_FLOOR) && ((*nextVal)==CELLTYPE_FLOOR)){
   47C0 DD 7E FF      [19] 1065 	ld	a,-1 (ix)
   47C3 B7            [ 4] 1066 	or	a, a
   47C4 28 0D         [12] 1067 	jr	Z,00112$
   47C6 7D            [ 4] 1068 	ld	a,l
   47C7 B7            [ 4] 1069 	or	a, a
   47C8 20 09         [12] 1070 	jr	NZ,00112$
                           1071 ;src/Map.c:244: door_not_positioned=0;
   47CA DD 36 FD 00   [19] 1072 	ld	-3 (ix),#0x00
                           1073 ;src/Map.c:245: *position=CELLTYPE_DOOR;
   47CE 3E 80         [ 7] 1074 	ld	a,#0x80
   47D0 02            [ 7] 1075 	ld	(bc),a
   47D1 18 11         [12] 1076 	jr	00123$
   47D3                    1077 00112$:
                           1078 ;src/Map.c:247: else if(((*nextVal)!=CELLTYPE_FLOOR) && ((*lastVal)==CELLTYPE_FLOOR)){
   47D3 7D            [ 4] 1079 	ld	a,l
   47D4 B7            [ 4] 1080 	or	a, a
   47D5 28 0D         [12] 1081 	jr	Z,00123$
   47D7 DD 7E FF      [19] 1082 	ld	a,-1 (ix)
   47DA B7            [ 4] 1083 	or	a, a
   47DB 20 07         [12] 1084 	jr	NZ,00123$
                           1085 ;src/Map.c:248: door_not_positioned=0;
   47DD DD 36 FD 00   [19] 1086 	ld	-3 (ix),#0x00
                           1087 ;src/Map.c:249: *position=CELLTYPE_DOOR;
   47E1 3E 80         [ 7] 1088 	ld	a,#0x80
   47E3 02            [ 7] 1089 	ld	(bc),a
   47E4                    1090 00123$:
                           1091 ;src/Map.c:253: ++position;
   47E4 03            [ 6] 1092 	inc	bc
                           1093 ;src/Map.c:254: ++lastVal;
   47E5 13            [ 6] 1094 	inc	de
                           1095 ;src/Map.c:255: ++nextVal;
   47E6 FD 23         [10] 1096 	inc	iy
                           1097 ;src/Map.c:256: ++topVal;
   47E8 DD 34 F9      [23] 1098 	inc	-7 (ix)
   47EB 20 03         [12] 1099 	jr	NZ,00195$
   47ED DD 34 FA      [23] 1100 	inc	-6 (ix)
   47F0                    1101 00195$:
                           1102 ;src/Map.c:257: ++bottomVal;
   47F0 DD 34 FB      [23] 1103 	inc	-5 (ix)
   47F3 20 03         [12] 1104 	jr	NZ,00196$
   47F5 DD 34 FC      [23] 1105 	inc	-4 (ix)
   47F8                    1106 00196$:
                           1107 ;src/Map.c:258: if(position>END_OF_MAP_MEM){
   47F8 69            [ 4] 1108 	ld	l, c
   47F9 60            [ 4] 1109 	ld	h, b
   47FA 3E 40         [ 7] 1110 	ld	a,#0x40
   47FC BD            [ 4] 1111 	cp	a, l
   47FD 3E 04         [ 7] 1112 	ld	a,#0x04
   47FF 9C            [ 4] 1113 	sbc	a, h
   4800 D2 5E 47      [10] 1114 	jp	NC,00126$
                           1115 ;src/Map.c:259: position = MAP_MEM;
   4803 01 40 00      [10] 1116 	ld	bc,#0x0040
                           1117 ;src/Map.c:260: lastVal = (position-1);
   4806 11 3F 00      [10] 1118 	ld	de,#0x003F
                           1119 ;src/Map.c:261: nextVal = (position+1);
   4809 FD 21 41 00   [14] 1120 	ld	iy,#0x0041
                           1121 ;src/Map.c:262: topVal = (position-MAP_WIDTH);
   480D 21 20 00      [10] 1122 	ld	hl,#0x0020
   4810 E3            [19] 1123 	ex	(sp), hl
                           1124 ;src/Map.c:263: bottomVal = (position+MAP_WIDTH);
   4811 DD 36 FB 60   [19] 1125 	ld	-5 (ix),#0x60
   4815 DD 36 FC 00   [19] 1126 	ld	-4 (ix),#0x00
   4819 C3 5E 47      [10] 1127 	jp	00126$
   481C                    1128 00129$:
   481C DD F9         [10] 1129 	ld	sp, ix
   481E DD E1         [14] 1130 	pop	ix
   4820 C9            [10] 1131 	ret
                           1132 ;src/Map.c:269: void generate_level(){
                           1133 ;	---------------------------------
                           1134 ; Function generate_level
                           1135 ; ---------------------------------
   4821                    1136 _generate_level::
                           1137 ;src/Map.c:270: generate_map();
   4821 CD A2 41      [17] 1138 	call	_generate_map
                           1139 ;src/Map.c:271: generate_exit_door();
   4824 C3 0C 47      [10] 1140 	jp  _generate_exit_door
                           1141 	.area _CODE
                           1142 	.area _INITIALIZER
                           1143 	.area _CABS (ABS)
