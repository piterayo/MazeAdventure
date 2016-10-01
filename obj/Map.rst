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
   4173                      55 _init_generator::
                             56 ;src/Map.c:11: cpct_setSeed_lcg_u8(rand_seed);
   4173 FD 21 7D 41   [14]   57 	ld	iy,#_rand_seed
   4177 FD 6E 00      [19]   58 	ld	l,0 (iy)
   417A C3 72 63      [10]   59 	jp  _cpct_setSeed_lcg_u8
   417D                      60 _rand_seed:
   417D 00                   61 	.db #0x00	; 0
                             62 ;src/Map.c:14: u8 get_random_wall(){
                             63 ;	---------------------------------
                             64 ; Function get_random_wall
                             65 ; ---------------------------------
   417E                      66 _get_random_wall::
                             67 ;src/Map.c:15: u8 cellType = cpct_getRandom_lcg_u8();
   417E CD 0C 64      [17]   68 	call	_cpct_getRandom_lcg_u8
                             69 ;src/Map.c:16: if(cellType&1){
   4181 CB 45         [ 8]   70 	bit	0, l
   4183 28 03         [12]   71 	jr	Z,00108$
                             72 ;src/Map.c:17: return CELLTYPE_WALL1;
   4185 2E 01         [ 7]   73 	ld	l,#0x01
   4187 C9            [10]   74 	ret
   4188                      75 00108$:
                             76 ;src/Map.c:20: if(cellType&3){
   4188 7D            [ 4]   77 	ld	a,l
   4189 E6 03         [ 7]   78 	and	a, #0x03
   418B 28 03         [12]   79 	jr	Z,00105$
                             80 ;src/Map.c:21: return CELLTYPE_WALL2;
   418D 2E 02         [ 7]   81 	ld	l,#0x02
   418F C9            [10]   82 	ret
   4190                      83 00105$:
                             84 ;src/Map.c:24: if(cellType&5){
   4190 7D            [ 4]   85 	ld	a,l
   4191 E6 05         [ 7]   86 	and	a, #0x05
   4193 28 03         [12]   87 	jr	Z,00102$
                             88 ;src/Map.c:25: return CELLTYPE_WALL3;
   4195 2E 03         [ 7]   89 	ld	l,#0x03
   4197 C9            [10]   90 	ret
   4198                      91 00102$:
                             92 ;src/Map.c:28: return CELLTYPE_WALL4;  
   4198 2E 04         [ 7]   93 	ld	l,#0x04
   419A C9            [10]   94 	ret
                             95 ;src/Map.c:34: void generate_map(){
                             96 ;	---------------------------------
                             97 ; Function generate_map
                             98 ; ---------------------------------
   419B                      99 _generate_map::
   419B DD E5         [15]  100 	push	ix
   419D DD 21 00 00   [14]  101 	ld	ix,#0
   41A1 DD 39         [15]  102 	add	ix,sp
   41A3 21 EB FF      [10]  103 	ld	hl,#-21
   41A6 39            [11]  104 	add	hl,sp
   41A7 F9            [ 6]  105 	ld	sp,hl
                            106 ;src/Map.c:37: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
   41A8 DD 36 F1 83   [19]  107 	ld	-15 (ix),#0x83
   41AC DD 36 F2 03   [19]  108 	ld	-14 (ix),#0x03
                            109 ;src/Map.c:43: u16 wallListCount = 0;
   41B0 DD 36 EF 00   [19]  110 	ld	-17 (ix),#0x00
   41B4 DD 36 F0 00   [19]  111 	ld	-16 (ix),#0x00
                            112 ;src/Map.c:44: u16 lastStackItem = 0;
   41B8 DD 36 ED 00   [19]  113 	ld	-19 (ix),#0x00
   41BC DD 36 EE 00   [19]  114 	ld	-18 (ix),#0x00
                            115 ;src/Map.c:46: (*cellStack).x = (cpct_getRandom_lcg_u8()%(MAP_WIDTH-2))+1; //RANDOM
   41C0 CD 0C 64      [17]  116 	call	_cpct_getRandom_lcg_u8
   41C3 45            [ 4]  117 	ld	b,l
   41C4 3E 1E         [ 7]  118 	ld	a,#0x1E
   41C6 F5            [11]  119 	push	af
   41C7 33            [ 6]  120 	inc	sp
   41C8 C5            [11]  121 	push	bc
   41C9 33            [ 6]  122 	inc	sp
   41CA CD 5B 63      [17]  123 	call	__moduchar
   41CD F1            [10]  124 	pop	af
   41CE 4D            [ 4]  125 	ld	c,l
   41CF 0C            [ 4]  126 	inc	c
   41D0 21 40 2B      [10]  127 	ld	hl,#0x2B40
   41D3 71            [ 7]  128 	ld	(hl),c
                            129 ;src/Map.c:47: (*cellStack).y = (cpct_getRandom_lcg_u8()%(MAP_HEIGHT-2))+1; //RANDOM
   41D4 CD 0C 64      [17]  130 	call	_cpct_getRandom_lcg_u8
   41D7 45            [ 4]  131 	ld	b,l
   41D8 3E 1E         [ 7]  132 	ld	a,#0x1E
   41DA F5            [11]  133 	push	af
   41DB 33            [ 6]  134 	inc	sp
   41DC C5            [11]  135 	push	bc
   41DD 33            [ 6]  136 	inc	sp
   41DE CD 5B 63      [17]  137 	call	__moduchar
   41E1 F1            [10]  138 	pop	af
   41E2 4D            [ 4]  139 	ld	c,l
   41E3 0C            [ 4]  140 	inc	c
   41E4 21 41 2B      [10]  141 	ld	hl,#0x2B41
   41E7 71            [ 7]  142 	ld	(hl),c
                            143 ;src/Map.c:50: *(i8*)&(PLAYER_position.x) = (*cellStack).y;
   41E8 DD 36 FB 2D   [19]  144 	ld	-5 (ix),#<(_PLAYER_position)
   41EC DD 36 FC 48   [19]  145 	ld	-4 (ix),#>(_PLAYER_position)
   41F0 2E 41         [ 7]  146 	ld	l, #0x41
   41F2 7E            [ 7]  147 	ld	a,(hl)
   41F3 DD 77 FD      [19]  148 	ld	-3 (ix),a
   41F6 DD 6E FB      [19]  149 	ld	l,-5 (ix)
   41F9 DD 66 FC      [19]  150 	ld	h,-4 (ix)
   41FC DD 7E FD      [19]  151 	ld	a,-3 (ix)
   41FF 77            [ 7]  152 	ld	(hl),a
                            153 ;src/Map.c:51: *(i8*)&(PLAYER_position.y) = (*cellStack).x;
   4200 DD 36 FB 2E   [19]  154 	ld	-5 (ix),#<((_PLAYER_position + 0x0001))
   4204 DD 36 FC 48   [19]  155 	ld	-4 (ix),#>((_PLAYER_position + 0x0001))
   4208 21 40 2B      [10]  156 	ld	hl,#0x2B40
   420B 4E            [ 7]  157 	ld	c,(hl)
   420C DD 6E FB      [19]  158 	ld	l,-5 (ix)
   420F DD 66 FC      [19]  159 	ld	h,-4 (ix)
   4212 71            [ 7]  160 	ld	(hl),c
                            161 ;src/Map.c:53: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   4213 21 00 04      [10]  162 	ld	hl,#0x0400
   4216 E5            [11]  163 	push	hl
   4217 3E FF         [ 7]  164 	ld	a,#0xFF
   4219 F5            [11]  165 	push	af
   421A 33            [ 6]  166 	inc	sp
   421B 21 40 00      [10]  167 	ld	hl,#0x0040
   421E E5            [11]  168 	push	hl
   421F CD 2B 64      [17]  169 	call	_cpct_memset
                            170 ;src/Map.c:55: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   4222 3A 40 2B      [13]  171 	ld	a,(#0x2B40)
   4225 DD 77 FD      [19]  172 	ld	-3 (ix), a
   4228 DD 77 FB      [19]  173 	ld	-5 (ix),a
   422B DD 36 FC 00   [19]  174 	ld	-4 (ix),#0x00
   422F 3E 06         [ 7]  175 	ld	a,#0x05+1
   4231 18 08         [12]  176 	jr	00315$
   4233                     177 00314$:
   4233 DD CB FB 26   [23]  178 	sla	-5 (ix)
   4237 DD CB FC 16   [23]  179 	rl	-4 (ix)
   423B                     180 00315$:
   423B 3D            [ 4]  181 	dec	a
   423C 20 F5         [12]  182 	jr	NZ,00314$
   423E DD 7E FB      [19]  183 	ld	a,-5 (ix)
   4241 C6 40         [ 7]  184 	add	a, #0x40
   4243 DD 77 FB      [19]  185 	ld	-5 (ix),a
   4246 DD 7E FC      [19]  186 	ld	a,-4 (ix)
   4249 CE 00         [ 7]  187 	adc	a, #0x00
   424B DD 77 FC      [19]  188 	ld	-4 (ix),a
   424E 21 41 2B      [10]  189 	ld	hl,#0x2B41
   4251 4E            [ 7]  190 	ld	c,(hl)
   4252 DD 6E FB      [19]  191 	ld	l,-5 (ix)
   4255 DD 66 FC      [19]  192 	ld	h,-4 (ix)
   4258 06 00         [ 7]  193 	ld	b,#0x00
   425A 09            [11]  194 	add	hl, bc
   425B 36 FE         [10]  195 	ld	(hl),#0xFE
                            196 ;src/Map.c:58: for(i=0;i<MAP_WIDTH;++i){
   425D DD 36 F3 00   [19]  197 	ld	-13 (ix),#0x00
   4261                     198 00167$:
                            199 ;src/Map.c:59: map[0][i]=get_random_wall();
   4261 DD 7E F3      [19]  200 	ld	a,-13 (ix)
   4264 C6 40         [ 7]  201 	add	a, #0x40
   4266 DD 77 FB      [19]  202 	ld	-5 (ix),a
   4269 3E 00         [ 7]  203 	ld	a,#0x00
   426B CE 00         [ 7]  204 	adc	a, #0x00
   426D DD 77 FC      [19]  205 	ld	-4 (ix),a
   4270 CD 7E 41      [17]  206 	call	_get_random_wall
   4273 DD 75 FD      [19]  207 	ld	-3 (ix),l
   4276 DD 6E FB      [19]  208 	ld	l,-5 (ix)
   4279 DD 66 FC      [19]  209 	ld	h,-4 (ix)
   427C DD 7E FD      [19]  210 	ld	a,-3 (ix)
   427F 77            [ 7]  211 	ld	(hl),a
                            212 ;src/Map.c:60: map[MAP_HEIGHT-1][i]=get_random_wall();
   4280 DD 7E F3      [19]  213 	ld	a,-13 (ix)
   4283 C6 20         [ 7]  214 	add	a, #0x20
   4285 DD 77 FB      [19]  215 	ld	-5 (ix),a
   4288 3E 00         [ 7]  216 	ld	a,#0x00
   428A CE 04         [ 7]  217 	adc	a, #0x04
   428C DD 77 FC      [19]  218 	ld	-4 (ix),a
   428F CD 7E 41      [17]  219 	call	_get_random_wall
   4292 4D            [ 4]  220 	ld	c,l
   4293 DD 6E FB      [19]  221 	ld	l,-5 (ix)
   4296 DD 66 FC      [19]  222 	ld	h,-4 (ix)
   4299 71            [ 7]  223 	ld	(hl),c
                            224 ;src/Map.c:58: for(i=0;i<MAP_WIDTH;++i){
   429A DD 34 F3      [23]  225 	inc	-13 (ix)
   429D DD 7E F3      [19]  226 	ld	a,-13 (ix)
   42A0 D6 20         [ 7]  227 	sub	a, #0x20
   42A2 38 BD         [12]  228 	jr	C,00167$
                            229 ;src/Map.c:63: for(i=1;i<MAP_HEIGHT-1;++i){
   42A4 DD 36 F3 01   [19]  230 	ld	-13 (ix),#0x01
   42A8                     231 00169$:
                            232 ;src/Map.c:64: map[i][0]=get_random_wall();
   42A8 DD 7E F3      [19]  233 	ld	a,-13 (ix)
   42AB DD 77 FB      [19]  234 	ld	-5 (ix),a
   42AE DD 36 FC 00   [19]  235 	ld	-4 (ix),#0x00
   42B2 3E 06         [ 7]  236 	ld	a,#0x05+1
   42B4 18 08         [12]  237 	jr	00317$
   42B6                     238 00316$:
   42B6 DD CB FB 26   [23]  239 	sla	-5 (ix)
   42BA DD CB FC 16   [23]  240 	rl	-4 (ix)
   42BE                     241 00317$:
   42BE 3D            [ 4]  242 	dec	a
   42BF 20 F5         [12]  243 	jr	NZ,00316$
   42C1 DD 7E FB      [19]  244 	ld	a,-5 (ix)
   42C4 C6 40         [ 7]  245 	add	a, #0x40
   42C6 DD 77 FE      [19]  246 	ld	-2 (ix),a
   42C9 DD 7E FC      [19]  247 	ld	a,-4 (ix)
   42CC CE 00         [ 7]  248 	adc	a, #0x00
   42CE DD 77 FF      [19]  249 	ld	-1 (ix),a
   42D1 CD 7E 41      [17]  250 	call	_get_random_wall
   42D4 DD 75 FD      [19]  251 	ld	-3 (ix),l
   42D7 DD 6E FE      [19]  252 	ld	l,-2 (ix)
   42DA DD 66 FF      [19]  253 	ld	h,-1 (ix)
   42DD DD 7E FD      [19]  254 	ld	a,-3 (ix)
   42E0 77            [ 7]  255 	ld	(hl),a
                            256 ;src/Map.c:65: map[i][MAP_WIDTH-1]=get_random_wall();
   42E1 DD 7E FB      [19]  257 	ld	a,-5 (ix)
   42E4 C6 40         [ 7]  258 	add	a, #0x40
   42E6 DD 77 FE      [19]  259 	ld	-2 (ix),a
   42E9 DD 7E FC      [19]  260 	ld	a,-4 (ix)
   42EC CE 00         [ 7]  261 	adc	a, #0x00
   42EE DD 77 FF      [19]  262 	ld	-1 (ix),a
   42F1 DD 7E FE      [19]  263 	ld	a,-2 (ix)
   42F4 C6 1F         [ 7]  264 	add	a, #0x1F
   42F6 4F            [ 4]  265 	ld	c,a
   42F7 DD 7E FF      [19]  266 	ld	a,-1 (ix)
   42FA CE 00         [ 7]  267 	adc	a, #0x00
   42FC 47            [ 4]  268 	ld	b,a
   42FD C5            [11]  269 	push	bc
   42FE CD 7E 41      [17]  270 	call	_get_random_wall
   4301 7D            [ 4]  271 	ld	a,l
   4302 C1            [10]  272 	pop	bc
   4303 02            [ 7]  273 	ld	(bc),a
                            274 ;src/Map.c:63: for(i=1;i<MAP_HEIGHT-1;++i){
   4304 DD 34 F3      [23]  275 	inc	-13 (ix)
   4307 DD 7E F3      [19]  276 	ld	a,-13 (ix)
   430A D6 1F         [ 7]  277 	sub	a, #0x1F
   430C 38 9A         [12]  278 	jr	C,00169$
                            279 ;src/Map.c:68: while(remainingCells>0){
   430E 21 00 00      [10]  280 	ld	hl,#0x0000
   4311 39            [11]  281 	add	hl,sp
   4312 DD 75 FE      [19]  282 	ld	-2 (ix),l
   4315 DD 74 FF      [19]  283 	ld	-1 (ix),h
   4318                     284 00164$:
   4318 DD 7E F2      [19]  285 	ld	a,-14 (ix)
   431B DD B6 F1      [19]  286 	or	a,-15 (ix)
   431E CA FC 46      [10]  287 	jp	Z,00171$
                            288 ;src/Map.c:69: wallListPosition = wallList+wallListCount;
   4321 DD 6E EF      [19]  289 	ld	l,-17 (ix)
   4324 DD 66 F0      [19]  290 	ld	h,-16 (ix)
   4327 29            [11]  291 	add	hl, hl
   4328 7D            [ 4]  292 	ld	a,l
   4329 C6 40         [ 7]  293 	add	a, #0x40
   432B DD 77 FB      [19]  294 	ld	-5 (ix),a
   432E 7C            [ 4]  295 	ld	a,h
   432F CE 2F         [ 7]  296 	adc	a, #0x2F
   4331 DD 77 FC      [19]  297 	ld	-4 (ix),a
                            298 ;src/Map.c:70: while(wallListCount<MAP_SIZE){
   4334 DD 4E EF      [19]  299 	ld	c,-17 (ix)
   4337 DD 46 F0      [19]  300 	ld	b,-16 (ix)
   433A                     301 00134$:
                            302 ;src/Map.c:73: currentPos.y = (*wallListPosition).y;
   433A DD 7E FE      [19]  303 	ld	a,-2 (ix)
   433D C6 01         [ 7]  304 	add	a, #0x01
   433F DD 77 F6      [19]  305 	ld	-10 (ix),a
   4342 DD 7E FF      [19]  306 	ld	a,-1 (ix)
   4345 CE 00         [ 7]  307 	adc	a, #0x00
   4347 DD 77 F7      [19]  308 	ld	-9 (ix),a
                            309 ;src/Map.c:70: while(wallListCount<MAP_SIZE){
   434A 78            [ 4]  310 	ld	a,b
   434B D6 04         [ 7]  311 	sub	a, #0x04
   434D D2 EE 44      [10]  312 	jp	NC,00204$
                            313 ;src/Map.c:72: currentPos.x = (*wallListPosition).x;
   4350 21 00 00      [10]  314 	ld	hl,#0x0000
   4353 39            [11]  315 	add	hl,sp
   4354 EB            [ 4]  316 	ex	de,hl
   4355 DD 6E FB      [19]  317 	ld	l,-5 (ix)
   4358 DD 66 FC      [19]  318 	ld	h,-4 (ix)
   435B 7E            [ 7]  319 	ld	a,(hl)
   435C 12            [ 7]  320 	ld	(de),a
                            321 ;src/Map.c:73: currentPos.y = (*wallListPosition).y;
   435D DD 5E FB      [19]  322 	ld	e,-5 (ix)
   4360 DD 56 FC      [19]  323 	ld	d,-4 (ix)
   4363 13            [ 6]  324 	inc	de
   4364 1A            [ 7]  325 	ld	a,(de)
   4365 DD 6E F6      [19]  326 	ld	l,-10 (ix)
   4368 DD 66 F7      [19]  327 	ld	h,-9 (ix)
   436B 77            [ 7]  328 	ld	(hl),a
                            329 ;src/Map.c:75: convertToFloor=0;
   436C DD 36 F4 00   [19]  330 	ld	-12 (ix),#0x00
                            331 ;src/Map.c:76: surroundedByWalls=1;
   4370 DD 36 F5 01   [19]  332 	ld	-11 (ix),#0x01
                            333 ;src/Map.c:78: if(currentPos.x>0){
   4374 DD 6E FE      [19]  334 	ld	l,-2 (ix)
   4377 DD 66 FF      [19]  335 	ld	h,-1 (ix)
   437A 7E            [ 7]  336 	ld	a,(hl)
   437B DD 77 FD      [19]  337 	ld	-3 (ix),a
                            338 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   437E DD 6E F6      [19]  339 	ld	l,-10 (ix)
   4381 DD 66 F7      [19]  340 	ld	h,-9 (ix)
   4384 7E            [ 7]  341 	ld	a,(hl)
   4385 DD 77 FA      [19]  342 	ld	-6 (ix),a
   4388 DD 7E FD      [19]  343 	ld	a,-3 (ix)
   438B DD 77 F8      [19]  344 	ld	-8 (ix),a
   438E DD 36 F9 00   [19]  345 	ld	-7 (ix),#0x00
                            346 ;src/Map.c:78: if(currentPos.x>0){
   4392 DD 7E FD      [19]  347 	ld	a,-3 (ix)
   4395 B7            [ 4]  348 	or	a, a
   4396 28 2F         [12]  349 	jr	Z,00109$
                            350 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   4398 DD 6E F8      [19]  351 	ld	l,-8 (ix)
   439B DD 66 F9      [19]  352 	ld	h,-7 (ix)
   439E 2B            [ 6]  353 	dec	hl
   439F 29            [11]  354 	add	hl, hl
   43A0 29            [11]  355 	add	hl, hl
   43A1 29            [11]  356 	add	hl, hl
   43A2 29            [11]  357 	add	hl, hl
   43A3 29            [11]  358 	add	hl, hl
   43A4 D5            [11]  359 	push	de
   43A5 11 40 00      [10]  360 	ld	de,#0x0040
   43A8 19            [11]  361 	add	hl, de
   43A9 D1            [10]  362 	pop	de
   43AA 7D            [ 4]  363 	ld	a,l
   43AB DD 86 FA      [19]  364 	add	a, -6 (ix)
   43AE 6F            [ 4]  365 	ld	l,a
   43AF 7C            [ 4]  366 	ld	a,h
   43B0 CE 00         [ 7]  367 	adc	a, #0x00
   43B2 67            [ 4]  368 	ld	h,a
   43B3 6E            [ 7]  369 	ld	l,(hl)
                            370 ;src/Map.c:80: if(adjacentType == CELLTYPE_UNDEFINED){
   43B4 7D            [ 4]  371 	ld	a,l
   43B5 3C            [ 4]  372 	inc	a
   43B6 20 06         [12]  373 	jr	NZ,00106$
                            374 ;src/Map.c:81: convertToFloor  = 1;
   43B8 DD 36 F4 01   [19]  375 	ld	-12 (ix),#0x01
   43BC 18 09         [12]  376 	jr	00109$
   43BE                     377 00106$:
                            378 ;src/Map.c:83: else if(adjacentType == CELLTYPE_FLOOR){
   43BE 7D            [ 4]  379 	ld	a,l
   43BF D6 FE         [ 7]  380 	sub	a, #0xFE
   43C1 20 04         [12]  381 	jr	NZ,00109$
                            382 ;src/Map.c:84: surroundedByWalls = 0;
   43C3 DD 36 F5 00   [19]  383 	ld	-11 (ix),#0x00
   43C7                     384 00109$:
                            385 ;src/Map.c:87: if(currentPos.x < (MAP_WIDTH-1)){
   43C7 DD 7E FD      [19]  386 	ld	a,-3 (ix)
   43CA D6 1F         [ 7]  387 	sub	a, #0x1F
   43CC 30 2F         [12]  388 	jr	NC,00116$
                            389 ;src/Map.c:89: adjacentType = map[currentPos.x+1][currentPos.y];
   43CE DD 6E F8      [19]  390 	ld	l,-8 (ix)
   43D1 DD 66 F9      [19]  391 	ld	h,-7 (ix)
   43D4 23            [ 6]  392 	inc	hl
   43D5 29            [11]  393 	add	hl, hl
   43D6 29            [11]  394 	add	hl, hl
   43D7 29            [11]  395 	add	hl, hl
   43D8 29            [11]  396 	add	hl, hl
   43D9 29            [11]  397 	add	hl, hl
   43DA D5            [11]  398 	push	de
   43DB 11 40 00      [10]  399 	ld	de,#0x0040
   43DE 19            [11]  400 	add	hl, de
   43DF D1            [10]  401 	pop	de
   43E0 7D            [ 4]  402 	ld	a,l
   43E1 DD 86 FA      [19]  403 	add	a, -6 (ix)
   43E4 6F            [ 4]  404 	ld	l,a
   43E5 7C            [ 4]  405 	ld	a,h
   43E6 CE 00         [ 7]  406 	adc	a, #0x00
   43E8 67            [ 4]  407 	ld	h,a
   43E9 6E            [ 7]  408 	ld	l,(hl)
                            409 ;src/Map.c:90: if(adjacentType == CELLTYPE_UNDEFINED){
   43EA 7D            [ 4]  410 	ld	a,l
   43EB 3C            [ 4]  411 	inc	a
   43EC 20 06         [12]  412 	jr	NZ,00113$
                            413 ;src/Map.c:91: convertToFloor  = 1;
   43EE DD 36 F4 01   [19]  414 	ld	-12 (ix),#0x01
   43F2 18 09         [12]  415 	jr	00116$
   43F4                     416 00113$:
                            417 ;src/Map.c:93: else if(adjacentType == CELLTYPE_FLOOR){
   43F4 7D            [ 4]  418 	ld	a,l
   43F5 D6 FE         [ 7]  419 	sub	a, #0xFE
   43F7 20 04         [12]  420 	jr	NZ,00116$
                            421 ;src/Map.c:94: surroundedByWalls = 0;
   43F9 DD 36 F5 00   [19]  422 	ld	-11 (ix),#0x00
   43FD                     423 00116$:
                            424 ;src/Map.c:99: adjacentType = map[currentPos.x][currentPos.y-1];
   43FD DD 6E F8      [19]  425 	ld	l,-8 (ix)
   4400 DD 66 F9      [19]  426 	ld	h,-7 (ix)
   4403 29            [11]  427 	add	hl, hl
   4404 29            [11]  428 	add	hl, hl
   4405 29            [11]  429 	add	hl, hl
   4406 29            [11]  430 	add	hl, hl
   4407 29            [11]  431 	add	hl, hl
   4408 7D            [ 4]  432 	ld	a,l
   4409 C6 40         [ 7]  433 	add	a, #0x40
   440B DD 77 F8      [19]  434 	ld	-8 (ix),a
   440E 7C            [ 4]  435 	ld	a,h
   440F CE 00         [ 7]  436 	adc	a, #0x00
   4411 DD 77 F9      [19]  437 	ld	-7 (ix),a
                            438 ;src/Map.c:97: if(currentPos.y > 0){
   4414 DD 7E FA      [19]  439 	ld	a,-6 (ix)
   4417 B7            [ 4]  440 	or	a, a
   4418 28 23         [12]  441 	jr	Z,00123$
                            442 ;src/Map.c:99: adjacentType = map[currentPos.x][currentPos.y-1];
   441A DD 6E FA      [19]  443 	ld	l,-6 (ix)
   441D 2D            [ 4]  444 	dec	l
   441E DD 7E F8      [19]  445 	ld	a,-8 (ix)
   4421 85            [ 4]  446 	add	a, l
   4422 6F            [ 4]  447 	ld	l,a
   4423 DD 7E F9      [19]  448 	ld	a,-7 (ix)
   4426 CE 00         [ 7]  449 	adc	a, #0x00
   4428 67            [ 4]  450 	ld	h,a
   4429 6E            [ 7]  451 	ld	l,(hl)
                            452 ;src/Map.c:100: if(adjacentType == CELLTYPE_UNDEFINED){
   442A 7D            [ 4]  453 	ld	a,l
   442B 3C            [ 4]  454 	inc	a
   442C 20 06         [12]  455 	jr	NZ,00120$
                            456 ;src/Map.c:101: convertToFloor  = 1;
   442E DD 36 F4 01   [19]  457 	ld	-12 (ix),#0x01
   4432 18 09         [12]  458 	jr	00123$
   4434                     459 00120$:
                            460 ;src/Map.c:103: else if(adjacentType == CELLTYPE_FLOOR){
   4434 7D            [ 4]  461 	ld	a,l
   4435 D6 FE         [ 7]  462 	sub	a, #0xFE
   4437 20 04         [12]  463 	jr	NZ,00123$
                            464 ;src/Map.c:104: surroundedByWalls = 0;
   4439 DD 36 F5 00   [19]  465 	ld	-11 (ix),#0x00
   443D                     466 00123$:
                            467 ;src/Map.c:107: if(currentPos.y < (MAP_HEIGHT-1)){
   443D DD 7E FA      [19]  468 	ld	a,-6 (ix)
   4440 D6 1F         [ 7]  469 	sub	a, #0x1F
   4442 30 23         [12]  470 	jr	NC,00130$
                            471 ;src/Map.c:109: adjacentType = map[currentPos.x][currentPos.y+1];
   4444 DD 6E FA      [19]  472 	ld	l,-6 (ix)
   4447 2C            [ 4]  473 	inc	l
   4448 DD 7E F8      [19]  474 	ld	a,-8 (ix)
   444B 85            [ 4]  475 	add	a, l
   444C 6F            [ 4]  476 	ld	l,a
   444D DD 7E F9      [19]  477 	ld	a,-7 (ix)
   4450 CE 00         [ 7]  478 	adc	a, #0x00
   4452 67            [ 4]  479 	ld	h,a
   4453 6E            [ 7]  480 	ld	l,(hl)
                            481 ;src/Map.c:110: if(adjacentType == CELLTYPE_UNDEFINED){
   4454 7D            [ 4]  482 	ld	a,l
   4455 3C            [ 4]  483 	inc	a
   4456 20 06         [12]  484 	jr	NZ,00127$
                            485 ;src/Map.c:111: convertToFloor  = 1;
   4458 DD 36 F4 01   [19]  486 	ld	-12 (ix),#0x01
   445C 18 09         [12]  487 	jr	00130$
   445E                     488 00127$:
                            489 ;src/Map.c:113: else if(adjacentType == CELLTYPE_FLOOR){
   445E 7D            [ 4]  490 	ld	a,l
   445F D6 FE         [ 7]  491 	sub	a, #0xFE
   4461 20 04         [12]  492 	jr	NZ,00130$
                            493 ;src/Map.c:114: surroundedByWalls = 0;
   4463 DD 36 F5 00   [19]  494 	ld	-11 (ix),#0x00
   4467                     495 00130$:
                            496 ;src/Map.c:118: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   4467 69            [ 4]  497 	ld	l, c
   4468 60            [ 4]  498 	ld	h, b
   4469 29            [11]  499 	add	hl, hl
   446A FD 21 40 2F   [14]  500 	ld	iy,#0x2F40
   446E C5            [11]  501 	push	bc
   446F 4D            [ 4]  502 	ld	c, l
   4470 44            [ 4]  503 	ld	b, h
   4471 FD 09         [15]  504 	add	iy, bc
   4473 C1            [10]  505 	pop	bc
   4474 FD 7E 00      [19]  506 	ld	a, 0 (iy)
   4477 DD 6E FB      [19]  507 	ld	l,-5 (ix)
   447A DD 66 FC      [19]  508 	ld	h,-4 (ix)
   447D 77            [ 7]  509 	ld	(hl),a
                            510 ;src/Map.c:119: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   447E FD E5         [15]  511 	push	iy
   4480 E1            [10]  512 	pop	hl
   4481 23            [ 6]  513 	inc	hl
   4482 7E            [ 7]  514 	ld	a,(hl)
   4483 12            [ 7]  515 	ld	(de),a
                            516 ;src/Map.c:120: --wallListCount;
   4484 0B            [ 6]  517 	dec	bc
   4485 DD 71 EF      [19]  518 	ld	-17 (ix),c
   4488 DD 70 F0      [19]  519 	ld	-16 (ix),b
                            520 ;src/Map.c:123: if((convertToFloor)&&(!surroundedByWalls)){
   448B DD 7E F4      [19]  521 	ld	a,-12 (ix)
   448E B7            [ 4]  522 	or	a, a
   448F 28 4C         [12]  523 	jr	Z,00132$
   4491 DD 7E F5      [19]  524 	ld	a,-11 (ix)
   4494 B7            [ 4]  525 	or	a, a
   4495 20 46         [12]  526 	jr	NZ,00132$
                            527 ;src/Map.c:124: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   4497 DD 6E FE      [19]  528 	ld	l,-2 (ix)
   449A DD 66 FF      [19]  529 	ld	h,-1 (ix)
   449D 6E            [ 7]  530 	ld	l,(hl)
   449E 26 00         [ 7]  531 	ld	h,#0x00
   44A0 29            [11]  532 	add	hl, hl
   44A1 29            [11]  533 	add	hl, hl
   44A2 29            [11]  534 	add	hl, hl
   44A3 29            [11]  535 	add	hl, hl
   44A4 29            [11]  536 	add	hl, hl
   44A5 01 40 00      [10]  537 	ld	bc,#0x0040
   44A8 09            [11]  538 	add	hl,bc
   44A9 4D            [ 4]  539 	ld	c,l
   44AA 44            [ 4]  540 	ld	b,h
   44AB DD 6E F6      [19]  541 	ld	l,-10 (ix)
   44AE DD 66 F7      [19]  542 	ld	h,-9 (ix)
   44B1 6E            [ 7]  543 	ld	l, (hl)
   44B2 26 00         [ 7]  544 	ld	h,#0x00
   44B4 09            [11]  545 	add	hl,bc
   44B5 36 FE         [10]  546 	ld	(hl),#0xFE
                            547 ;src/Map.c:126: ++lastStackItem;
   44B7 DD 34 ED      [23]  548 	inc	-19 (ix)
   44BA 20 03         [12]  549 	jr	NZ,00334$
   44BC DD 34 EE      [23]  550 	inc	-18 (ix)
   44BF                     551 00334$:
                            552 ;src/Map.c:127: (*(cellStack+lastStackItem)).x = currentPos.x;
   44BF C1            [10]  553 	pop	bc
   44C0 E1            [10]  554 	pop	hl
   44C1 E5            [11]  555 	push	hl
   44C2 C5            [11]  556 	push	bc
   44C3 29            [11]  557 	add	hl, hl
   44C4 01 40 2B      [10]  558 	ld	bc, #0x2B40
   44C7 09            [11]  559 	add	hl,bc
   44C8 4D            [ 4]  560 	ld	c, l
   44C9 44            [ 4]  561 	ld	b, h
   44CA DD 6E FE      [19]  562 	ld	l,-2 (ix)
   44CD DD 66 FF      [19]  563 	ld	h,-1 (ix)
   44D0 7E            [ 7]  564 	ld	a,(hl)
   44D1 02            [ 7]  565 	ld	(bc),a
                            566 ;src/Map.c:128: (*(cellStack+lastStackItem)).y = currentPos.y;
   44D2 03            [ 6]  567 	inc	bc
   44D3 DD 6E F6      [19]  568 	ld	l,-10 (ix)
   44D6 DD 66 F7      [19]  569 	ld	h,-9 (ix)
   44D9 7E            [ 7]  570 	ld	a,(hl)
   44DA 02            [ 7]  571 	ld	(bc),a
                            572 ;src/Map.c:131: break;
   44DB 18 11         [12]  573 	jr	00204$
   44DD                     574 00132$:
                            575 ;src/Map.c:133: --wallListPosition;
   44DD DD 6E FB      [19]  576 	ld	l,-5 (ix)
   44E0 DD 66 FC      [19]  577 	ld	h,-4 (ix)
   44E3 2B            [ 6]  578 	dec	hl
   44E4 2B            [ 6]  579 	dec	hl
   44E5 DD 75 FB      [19]  580 	ld	-5 (ix),l
   44E8 DD 74 FC      [19]  581 	ld	-4 (ix),h
   44EB C3 3A 43      [10]  582 	jp	00134$
                            583 ;src/Map.c:135: while(lastStackItem<MAP_SIZE){
   44EE                     584 00204$:
   44EE DD 7E F1      [19]  585 	ld	a,-15 (ix)
   44F1 DD 77 F8      [19]  586 	ld	-8 (ix),a
   44F4 DD 7E F2      [19]  587 	ld	a,-14 (ix)
   44F7 DD 77 F9      [19]  588 	ld	-7 (ix),a
   44FA DD 7E EF      [19]  589 	ld	a,-17 (ix)
   44FD DD 77 FB      [19]  590 	ld	-5 (ix),a
   4500 DD 7E F0      [19]  591 	ld	a,-16 (ix)
   4503 DD 77 FC      [19]  592 	ld	-4 (ix),a
   4506                     593 00161$:
   4506 DD 7E EE      [19]  594 	ld	a,-18 (ix)
   4509 D6 04         [ 7]  595 	sub	a, #0x04
   450B D2 18 43      [10]  596 	jp	NC,00164$
                            597 ;src/Map.c:136: currentPos.x=(*(lastStackItem+cellStack)).x;
   450E 21 00 00      [10]  598 	ld	hl,#0x0000
   4511 39            [11]  599 	add	hl,sp
   4512 4D            [ 4]  600 	ld	c,l
   4513 44            [ 4]  601 	ld	b,h
   4514 D1            [10]  602 	pop	de
   4515 E1            [10]  603 	pop	hl
   4516 E5            [11]  604 	push	hl
   4517 D5            [11]  605 	push	de
   4518 29            [11]  606 	add	hl, hl
   4519 FD 21 40 2B   [14]  607 	ld	iy,#0x2B40
   451D EB            [ 4]  608 	ex	de,hl
   451E FD 19         [15]  609 	add	iy, de
   4520 FD 7E 00      [19]  610 	ld	a, 0 (iy)
   4523 02            [ 7]  611 	ld	(bc),a
                            612 ;src/Map.c:137: currentPos.y=(*(lastStackItem+cellStack)).y;
   4524 FD 4E 01      [19]  613 	ld	c,1 (iy)
   4527 DD 6E F6      [19]  614 	ld	l,-10 (ix)
   452A DD 66 F7      [19]  615 	ld	h,-9 (ix)
   452D 71            [ 7]  616 	ld	(hl),c
                            617 ;src/Map.c:138: --lastStackItem;
   452E DD 6E ED      [19]  618 	ld	l,-19 (ix)
   4531 DD 66 EE      [19]  619 	ld	h,-18 (ix)
   4534 2B            [ 6]  620 	dec	hl
   4535 DD 75 ED      [19]  621 	ld	-19 (ix),l
   4538 DD 74 EE      [19]  622 	ld	-18 (ix),h
                            623 ;src/Map.c:139: cellType = map[currentPos.x][currentPos.y];
   453B DD 6E FE      [19]  624 	ld	l,-2 (ix)
   453E DD 66 FF      [19]  625 	ld	h,-1 (ix)
   4541 6E            [ 7]  626 	ld	l,(hl)
   4542 26 00         [ 7]  627 	ld	h,#0x00
   4544 29            [11]  628 	add	hl, hl
   4545 29            [11]  629 	add	hl, hl
   4546 29            [11]  630 	add	hl, hl
   4547 29            [11]  631 	add	hl, hl
   4548 29            [11]  632 	add	hl, hl
   4549 11 40 00      [10]  633 	ld	de,#0x0040
   454C 19            [11]  634 	add	hl,de
   454D 59            [ 4]  635 	ld	e,c
   454E 16 00         [ 7]  636 	ld	d,#0x00
   4550 19            [11]  637 	add	hl,de
   4551 4E            [ 7]  638 	ld	c,(hl)
                            639 ;src/Map.c:141: if(cellType == CELLTYPE_UNDEFINED){
   4552 79            [ 4]  640 	ld	a,c
   4553 3C            [ 4]  641 	inc	a
   4554 20 47         [12]  642 	jr	NZ,00141$
                            643 ;src/Map.c:143: if(cpct_getRandom_lcg_u8()&1){//WALL
   4556 CD 0C 64      [17]  644 	call	_cpct_getRandom_lcg_u8
   4559 CB 45         [ 8]  645 	bit	0, l
   455B 28 06         [12]  646 	jr	Z,00138$
                            647 ;src/Map.c:144: cellType = get_random_wall();
   455D CD 7E 41      [17]  648 	call	_get_random_wall
   4560 4D            [ 4]  649 	ld	c,l
   4561 18 02         [12]  650 	jr	00139$
   4563                     651 00138$:
                            652 ;src/Map.c:147: cellType = CELLTYPE_FLOOR;
   4563 0E FE         [ 7]  653 	ld	c,#0xFE
   4565                     654 00139$:
                            655 ;src/Map.c:149: map[currentPos.x][currentPos.y]=cellType;
   4565 DD 6E FE      [19]  656 	ld	l,-2 (ix)
   4568 DD 66 FF      [19]  657 	ld	h,-1 (ix)
   456B 6E            [ 7]  658 	ld	l,(hl)
   456C 26 00         [ 7]  659 	ld	h,#0x00
   456E 29            [11]  660 	add	hl, hl
   456F 29            [11]  661 	add	hl, hl
   4570 29            [11]  662 	add	hl, hl
   4571 29            [11]  663 	add	hl, hl
   4572 29            [11]  664 	add	hl, hl
   4573 EB            [ 4]  665 	ex	de,hl
   4574 21 40 00      [10]  666 	ld	hl,#0x0040
   4577 19            [11]  667 	add	hl,de
   4578 EB            [ 4]  668 	ex	de,hl
   4579 DD 6E F6      [19]  669 	ld	l,-10 (ix)
   457C DD 66 F7      [19]  670 	ld	h,-9 (ix)
   457F 6E            [ 7]  671 	ld	l, (hl)
   4580 26 00         [ 7]  672 	ld	h,#0x00
   4582 19            [11]  673 	add	hl,de
   4583 71            [ 7]  674 	ld	(hl),c
                            675 ;src/Map.c:150: --remainingCells;
   4584 DD 6E F8      [19]  676 	ld	l,-8 (ix)
   4587 DD 66 F9      [19]  677 	ld	h,-7 (ix)
   458A 2B            [ 6]  678 	dec	hl
   458B DD 75 F8      [19]  679 	ld	-8 (ix),l
   458E DD 74 F9      [19]  680 	ld	-7 (ix),h
   4591 DD 7E F8      [19]  681 	ld	a,-8 (ix)
   4594 DD 77 F1      [19]  682 	ld	-15 (ix),a
   4597 DD 7E F9      [19]  683 	ld	a,-7 (ix)
   459A DD 77 F2      [19]  684 	ld	-14 (ix),a
   459D                     685 00141$:
                            686 ;src/Map.c:78: if(currentPos.x>0){
   459D DD 6E FE      [19]  687 	ld	l,-2 (ix)
   45A0 DD 66 FF      [19]  688 	ld	h,-1 (ix)
   45A3 7E            [ 7]  689 	ld	a,(hl)
   45A4 DD 77 FA      [19]  690 	ld	-6 (ix),a
                            691 ;src/Map.c:153: if((cellType == CELLTYPE_FLOOR)){
   45A7 79            [ 4]  692 	ld	a,c
   45A8 D6 FE         [ 7]  693 	sub	a, #0xFE
   45AA C2 CB 46      [10]  694 	jp	NZ,00159$
                            695 ;src/Map.c:154: if(currentPos.x>0){
   45AD DD 7E FA      [19]  696 	ld	a,-6 (ix)
   45B0 B7            [ 4]  697 	or	a, a
   45B1 28 40         [12]  698 	jr	Z,00145$
                            699 ;src/Map.c:155: adjacentType = map[currentPos.x-1][currentPos.y];
   45B3 DD 6E FA      [19]  700 	ld	l,-6 (ix)
   45B6 26 00         [ 7]  701 	ld	h,#0x00
   45B8 2B            [ 6]  702 	dec	hl
   45B9 29            [11]  703 	add	hl, hl
   45BA 29            [11]  704 	add	hl, hl
   45BB 29            [11]  705 	add	hl, hl
   45BC 29            [11]  706 	add	hl, hl
   45BD 29            [11]  707 	add	hl, hl
   45BE 01 40 00      [10]  708 	ld	bc,#0x0040
   45C1 09            [11]  709 	add	hl,bc
   45C2 4D            [ 4]  710 	ld	c,l
   45C3 44            [ 4]  711 	ld	b,h
   45C4 DD 6E F6      [19]  712 	ld	l,-10 (ix)
   45C7 DD 66 F7      [19]  713 	ld	h,-9 (ix)
   45CA 6E            [ 7]  714 	ld	l, (hl)
   45CB 26 00         [ 7]  715 	ld	h,#0x00
   45CD 09            [11]  716 	add	hl,bc
   45CE 4E            [ 7]  717 	ld	c,(hl)
                            718 ;src/Map.c:156: if(adjacentType == CELLTYPE_UNDEFINED){
   45CF 0C            [ 4]  719 	inc	c
   45D0 20 21         [12]  720 	jr	NZ,00145$
                            721 ;src/Map.c:158: ++lastStackItem;
   45D2 DD 34 ED      [23]  722 	inc	-19 (ix)
   45D5 20 03         [12]  723 	jr	NZ,00342$
   45D7 DD 34 EE      [23]  724 	inc	-18 (ix)
   45DA                     725 00342$:
                            726 ;src/Map.c:159: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   45DA C1            [10]  727 	pop	bc
   45DB E1            [10]  728 	pop	hl
   45DC E5            [11]  729 	push	hl
   45DD C5            [11]  730 	push	bc
   45DE 29            [11]  731 	add	hl, hl
   45DF 01 40 2B      [10]  732 	ld	bc,#0x2B40
   45E2 09            [11]  733 	add	hl,bc
   45E3 DD 4E FA      [19]  734 	ld	c,-6 (ix)
   45E6 0D            [ 4]  735 	dec	c
   45E7 71            [ 7]  736 	ld	(hl),c
                            737 ;src/Map.c:160: (*(cellStack+lastStackItem)).y = currentPos.y;
   45E8 23            [ 6]  738 	inc	hl
   45E9 4D            [ 4]  739 	ld	c,l
   45EA 44            [ 4]  740 	ld	b,h
   45EB DD 6E F6      [19]  741 	ld	l,-10 (ix)
   45EE DD 66 F7      [19]  742 	ld	h,-9 (ix)
   45F1 7E            [ 7]  743 	ld	a,(hl)
   45F2 02            [ 7]  744 	ld	(bc),a
   45F3                     745 00145$:
                            746 ;src/Map.c:164: if(currentPos.x < (MAP_WIDTH-1)){
   45F3 DD 6E FE      [19]  747 	ld	l,-2 (ix)
   45F6 DD 66 FF      [19]  748 	ld	h,-1 (ix)
   45F9 4E            [ 7]  749 	ld	c,(hl)
   45FA 79            [ 4]  750 	ld	a,c
   45FB D6 1F         [ 7]  751 	sub	a, #0x1F
   45FD 30 3B         [12]  752 	jr	NC,00149$
                            753 ;src/Map.c:166: adjacentType = map[currentPos.x+1][currentPos.y];
   45FF 69            [ 4]  754 	ld	l,c
   4600 26 00         [ 7]  755 	ld	h,#0x00
   4602 23            [ 6]  756 	inc	hl
   4603 29            [11]  757 	add	hl, hl
   4604 29            [11]  758 	add	hl, hl
   4605 29            [11]  759 	add	hl, hl
   4606 29            [11]  760 	add	hl, hl
   4607 29            [11]  761 	add	hl, hl
   4608 EB            [ 4]  762 	ex	de,hl
   4609 21 40 00      [10]  763 	ld	hl,#0x0040
   460C 19            [11]  764 	add	hl,de
   460D EB            [ 4]  765 	ex	de,hl
   460E DD 6E F6      [19]  766 	ld	l,-10 (ix)
   4611 DD 66 F7      [19]  767 	ld	h,-9 (ix)
   4614 6E            [ 7]  768 	ld	l, (hl)
   4615 26 00         [ 7]  769 	ld	h,#0x00
   4617 19            [11]  770 	add	hl,de
   4618 46            [ 7]  771 	ld	b,(hl)
                            772 ;src/Map.c:167: if(adjacentType == CELLTYPE_UNDEFINED){
   4619 04            [ 4]  773 	inc	b
   461A 20 1E         [12]  774 	jr	NZ,00149$
                            775 ;src/Map.c:170: ++lastStackItem;
   461C DD 34 ED      [23]  776 	inc	-19 (ix)
   461F 20 03         [12]  777 	jr	NZ,00345$
   4621 DD 34 EE      [23]  778 	inc	-18 (ix)
   4624                     779 00345$:
                            780 ;src/Map.c:171: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   4624 D1            [10]  781 	pop	de
   4625 E1            [10]  782 	pop	hl
   4626 E5            [11]  783 	push	hl
   4627 D5            [11]  784 	push	de
   4628 29            [11]  785 	add	hl, hl
   4629 11 40 2B      [10]  786 	ld	de,#0x2B40
   462C 19            [11]  787 	add	hl,de
   462D 0C            [ 4]  788 	inc	c
   462E 71            [ 7]  789 	ld	(hl),c
                            790 ;src/Map.c:172: (*(cellStack+lastStackItem)).y = currentPos.y;
   462F 23            [ 6]  791 	inc	hl
   4630 4D            [ 4]  792 	ld	c,l
   4631 44            [ 4]  793 	ld	b,h
   4632 DD 6E F6      [19]  794 	ld	l,-10 (ix)
   4635 DD 66 F7      [19]  795 	ld	h,-9 (ix)
   4638 7E            [ 7]  796 	ld	a,(hl)
   4639 02            [ 7]  797 	ld	(bc),a
   463A                     798 00149$:
                            799 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   463A DD 6E F6      [19]  800 	ld	l,-10 (ix)
   463D DD 66 F7      [19]  801 	ld	h,-9 (ix)
   4640 4E            [ 7]  802 	ld	c,(hl)
                            803 ;src/Map.c:176: if(currentPos.y > 0){
   4641 79            [ 4]  804 	ld	a,c
   4642 B7            [ 4]  805 	or	a, a
   4643 28 3B         [12]  806 	jr	Z,00153$
                            807 ;src/Map.c:178: adjacentType = map[currentPos.x][currentPos.y-1];
   4645 DD 6E FE      [19]  808 	ld	l,-2 (ix)
   4648 DD 66 FF      [19]  809 	ld	h,-1 (ix)
   464B 46            [ 7]  810 	ld	b,(hl)
   464C 68            [ 4]  811 	ld	l,b
   464D 26 00         [ 7]  812 	ld	h,#0x00
   464F 29            [11]  813 	add	hl, hl
   4650 29            [11]  814 	add	hl, hl
   4651 29            [11]  815 	add	hl, hl
   4652 29            [11]  816 	add	hl, hl
   4653 29            [11]  817 	add	hl, hl
   4654 11 40 00      [10]  818 	ld	de,#0x0040
   4657 19            [11]  819 	add	hl,de
   4658 0D            [ 4]  820 	dec	c
   4659 59            [ 4]  821 	ld	e,c
   465A 16 00         [ 7]  822 	ld	d,#0x00
   465C 19            [11]  823 	add	hl,de
   465D 4E            [ 7]  824 	ld	c,(hl)
                            825 ;src/Map.c:179: if(adjacentType == CELLTYPE_UNDEFINED){
   465E 0C            [ 4]  826 	inc	c
   465F 20 1F         [12]  827 	jr	NZ,00153$
                            828 ;src/Map.c:182: ++lastStackItem;
   4661 DD 34 ED      [23]  829 	inc	-19 (ix)
   4664 20 03         [12]  830 	jr	NZ,00348$
   4666 DD 34 EE      [23]  831 	inc	-18 (ix)
   4669                     832 00348$:
                            833 ;src/Map.c:183: (*(cellStack+lastStackItem)).x = currentPos.x;
   4669 D1            [10]  834 	pop	de
   466A E1            [10]  835 	pop	hl
   466B E5            [11]  836 	push	hl
   466C D5            [11]  837 	push	de
   466D 29            [11]  838 	add	hl, hl
   466E 11 40 2B      [10]  839 	ld	de,#0x2B40
   4671 19            [11]  840 	add	hl,de
   4672 70            [ 7]  841 	ld	(hl),b
                            842 ;src/Map.c:184: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   4673 23            [ 6]  843 	inc	hl
   4674 4D            [ 4]  844 	ld	c,l
   4675 44            [ 4]  845 	ld	b,h
   4676 DD 6E F6      [19]  846 	ld	l,-10 (ix)
   4679 DD 66 F7      [19]  847 	ld	h,-9 (ix)
   467C 5E            [ 7]  848 	ld	e,(hl)
   467D 1D            [ 4]  849 	dec	e
   467E 7B            [ 4]  850 	ld	a,e
   467F 02            [ 7]  851 	ld	(bc),a
   4680                     852 00153$:
                            853 ;src/Map.c:79: adjacentType = map[currentPos.x-1][currentPos.y];
   4680 DD 6E F6      [19]  854 	ld	l,-10 (ix)
   4683 DD 66 F7      [19]  855 	ld	h,-9 (ix)
   4686 46            [ 7]  856 	ld	b,(hl)
                            857 ;src/Map.c:188: if(currentPos.y < (MAP_HEIGHT-1)){
   4687 78            [ 4]  858 	ld	a,b
   4688 D6 1F         [ 7]  859 	sub	a, #0x1F
   468A D2 06 45      [10]  860 	jp	NC,00161$
                            861 ;src/Map.c:190: adjacentType = map[currentPos.x][currentPos.y+1];
   468D DD 6E FE      [19]  862 	ld	l,-2 (ix)
   4690 DD 66 FF      [19]  863 	ld	h,-1 (ix)
   4693 4E            [ 7]  864 	ld	c,(hl)
   4694 69            [ 4]  865 	ld	l,c
   4695 26 00         [ 7]  866 	ld	h,#0x00
   4697 29            [11]  867 	add	hl, hl
   4698 29            [11]  868 	add	hl, hl
   4699 29            [11]  869 	add	hl, hl
   469A 29            [11]  870 	add	hl, hl
   469B 29            [11]  871 	add	hl, hl
   469C 11 40 00      [10]  872 	ld	de,#0x0040
   469F 19            [11]  873 	add	hl,de
   46A0 04            [ 4]  874 	inc	b
   46A1 58            [ 4]  875 	ld	e,b
   46A2 16 00         [ 7]  876 	ld	d,#0x00
   46A4 19            [11]  877 	add	hl,de
   46A5 46            [ 7]  878 	ld	b,(hl)
                            879 ;src/Map.c:191: if(adjacentType == CELLTYPE_UNDEFINED){
   46A6 04            [ 4]  880 	inc	b
   46A7 C2 06 45      [10]  881 	jp	NZ,00161$
                            882 ;src/Map.c:194: ++lastStackItem;
   46AA DD 34 ED      [23]  883 	inc	-19 (ix)
   46AD 20 03         [12]  884 	jr	NZ,00351$
   46AF DD 34 EE      [23]  885 	inc	-18 (ix)
   46B2                     886 00351$:
                            887 ;src/Map.c:195: (*(cellStack+lastStackItem)).x = currentPos.x;
   46B2 D1            [10]  888 	pop	de
   46B3 E1            [10]  889 	pop	hl
   46B4 E5            [11]  890 	push	hl
   46B5 D5            [11]  891 	push	de
   46B6 29            [11]  892 	add	hl, hl
   46B7 11 40 2B      [10]  893 	ld	de,#0x2B40
   46BA 19            [11]  894 	add	hl,de
   46BB 71            [ 7]  895 	ld	(hl),c
                            896 ;src/Map.c:196: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   46BC 23            [ 6]  897 	inc	hl
   46BD 4D            [ 4]  898 	ld	c,l
   46BE 44            [ 4]  899 	ld	b,h
   46BF DD 6E F6      [19]  900 	ld	l,-10 (ix)
   46C2 DD 66 F7      [19]  901 	ld	h,-9 (ix)
   46C5 7E            [ 7]  902 	ld	a,(hl)
   46C6 3C            [ 4]  903 	inc	a
   46C7 02            [ 7]  904 	ld	(bc),a
   46C8 C3 06 45      [10]  905 	jp	00161$
   46CB                     906 00159$:
                            907 ;src/Map.c:202: ++wallListCount;
   46CB DD 34 FB      [23]  908 	inc	-5 (ix)
   46CE 20 03         [12]  909 	jr	NZ,00352$
   46D0 DD 34 FC      [23]  910 	inc	-4 (ix)
   46D3                     911 00352$:
   46D3 DD 7E FB      [19]  912 	ld	a,-5 (ix)
   46D6 DD 77 EF      [19]  913 	ld	-17 (ix),a
   46D9 DD 7E FC      [19]  914 	ld	a,-4 (ix)
   46DC DD 77 F0      [19]  915 	ld	-16 (ix),a
                            916 ;src/Map.c:203: (*(wallList+wallListCount)).x = currentPos.x;
   46DF DD 6E FB      [19]  917 	ld	l,-5 (ix)
   46E2 DD 66 FC      [19]  918 	ld	h,-4 (ix)
   46E5 29            [11]  919 	add	hl, hl
   46E6 01 40 2F      [10]  920 	ld	bc,#0x2F40
   46E9 09            [11]  921 	add	hl,bc
   46EA DD 7E FA      [19]  922 	ld	a,-6 (ix)
   46ED 77            [ 7]  923 	ld	(hl),a
                            924 ;src/Map.c:204: (*(wallList+wallListCount)).y = currentPos.y;
   46EE 23            [ 6]  925 	inc	hl
   46EF 4D            [ 4]  926 	ld	c,l
   46F0 44            [ 4]  927 	ld	b,h
   46F1 DD 6E F6      [19]  928 	ld	l,-10 (ix)
   46F4 DD 66 F7      [19]  929 	ld	h,-9 (ix)
   46F7 7E            [ 7]  930 	ld	a,(hl)
   46F8 02            [ 7]  931 	ld	(bc),a
   46F9 C3 06 45      [10]  932 	jp	00161$
   46FC                     933 00171$:
   46FC DD F9         [10]  934 	ld	sp, ix
   46FE DD E1         [14]  935 	pop	ix
   4700 C9            [10]  936 	ret
                            937 ;src/Map.c:210: void generate_exit_door(){
                            938 ;	---------------------------------
                            939 ; Function generate_exit_door
                            940 ; ---------------------------------
   4701                     941 _generate_exit_door::
   4701 DD E5         [15]  942 	push	ix
   4703 DD 21 00 00   [14]  943 	ld	ix,#0
   4707 DD 39         [15]  944 	add	ix,sp
   4709 21 F9 FF      [10]  945 	ld	hl,#-7
   470C 39            [11]  946 	add	hl,sp
   470D F9            [ 6]  947 	ld	sp,hl
                            948 ;src/Map.c:211: u8 x=(cpct_getRandom_lcg_u8());
   470E CD 0C 64      [17]  949 	call	_cpct_getRandom_lcg_u8
   4711 4D            [ 4]  950 	ld	c,l
                            951 ;src/Map.c:212: u8 y=(cpct_getRandom_lcg_u8());
   4712 C5            [11]  952 	push	bc
   4713 CD 0C 64      [17]  953 	call	_cpct_getRandom_lcg_u8
   4716 5D            [ 4]  954 	ld	e,l
   4717 C1            [10]  955 	pop	bc
                            956 ;src/Map.c:213: u8 door_not_positioned=1;
   4718 DD 36 F9 01   [19]  957 	ld	-7 (ix),#0x01
                            958 ;src/Map.c:220: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
   471C 06 00         [ 7]  959 	ld	b,#0x00
   471E 21 40 00      [10]  960 	ld	hl,#0x0040
   4721 09            [11]  961 	add	hl,bc
   4722 4D            [ 4]  962 	ld	c,l
   4723 44            [ 4]  963 	ld	b,h
   4724 6B            [ 4]  964 	ld	l,e
   4725 26 00         [ 7]  965 	ld	h,#0x00
   4727 29            [11]  966 	add	hl, hl
   4728 29            [11]  967 	add	hl, hl
   4729 29            [11]  968 	add	hl, hl
   472A 29            [11]  969 	add	hl, hl
   472B 29            [11]  970 	add	hl, hl
   472C 09            [11]  971 	add	hl,bc
   472D 4D            [ 4]  972 	ld	c,l
   472E 44            [ 4]  973 	ld	b,h
                            974 ;src/Map.c:225: lastVal = (position-1);
   472F 59            [ 4]  975 	ld	e,c
   4730 50            [ 4]  976 	ld	d,b
   4731 1B            [ 6]  977 	dec	de
                            978 ;src/Map.c:226: nextVal = (position+1);
   4732 C5            [11]  979 	push	bc
   4733 FD E1         [14]  980 	pop	iy
   4735 FD 23         [10]  981 	inc	iy
                            982 ;src/Map.c:227: topVal = (position-MAP_WIDTH);
   4737 79            [ 4]  983 	ld	a,c
   4738 C6 E0         [ 7]  984 	add	a,#0xE0
   473A DD 77 FC      [19]  985 	ld	-4 (ix),a
   473D 78            [ 4]  986 	ld	a,b
   473E CE FF         [ 7]  987 	adc	a,#0xFF
   4740 DD 77 FD      [19]  988 	ld	-3 (ix),a
                            989 ;src/Map.c:228: bottomVal = (position+MAP_WIDTH);
   4743 21 20 00      [10]  990 	ld	hl,#0x0020
   4746 09            [11]  991 	add	hl,bc
   4747 DD 75 FA      [19]  992 	ld	-6 (ix),l
   474A DD 74 FB      [19]  993 	ld	-5 (ix),h
                            994 ;src/Map.c:230: while(door_not_positioned){
   474D                     995 00126$:
   474D DD 7E F9      [19]  996 	ld	a,-7 (ix)
   4750 B7            [ 4]  997 	or	a, a
   4751 CA 22 48      [10]  998 	jp	Z,00129$
                            999 ;src/Map.c:231: if((*position)!=CELLTYPE_FLOOR){
   4754 0A            [ 7] 1000 	ld	a,(bc)
   4755 D6 FE         [ 7] 1001 	sub	a, #0xFE
   4757 CA FD 47      [10] 1002 	jp	Z,00123$
                           1003 ;src/Map.c:232: if(((*lastVal)!=CELLTYPE_FLOOR) && ((*nextVal)!=CELLTYPE_FLOOR)){
   475A 1A            [ 7] 1004 	ld	a,(de)
                           1005 ;src/Map.c:233: if(((*topVal)!=CELLTYPE_FLOOR) && ((*bottomVal)==CELLTYPE_FLOOR)){
   475B DD 6E FC      [19] 1006 	ld	l,-4 (ix)
   475E DD 66 FD      [19] 1007 	ld	h,-3 (ix)
   4761 6E            [ 7] 1008 	ld	l,(hl)
                           1009 ;src/Map.c:232: if(((*lastVal)!=CELLTYPE_FLOOR) && ((*nextVal)!=CELLTYPE_FLOOR)){
   4762 D6 FE         [ 7] 1010 	sub	a, #0xFE
   4764 20 04         [12] 1011 	jr	NZ,00197$
   4766 3E 01         [ 7] 1012 	ld	a,#0x01
   4768 18 01         [12] 1013 	jr	00198$
   476A                    1014 00197$:
   476A AF            [ 4] 1015 	xor	a,a
   476B                    1016 00198$:
   476B DD 77 FF      [19] 1017 	ld	-1 (ix),a
                           1018 ;src/Map.c:233: if(((*topVal)!=CELLTYPE_FLOOR) && ((*bottomVal)==CELLTYPE_FLOOR)){
   476E 7D            [ 4] 1019 	ld	a,l
   476F D6 FE         [ 7] 1020 	sub	a, #0xFE
   4771 20 04         [12] 1021 	jr	NZ,00199$
   4773 3E 01         [ 7] 1022 	ld	a,#0x01
   4775 18 01         [12] 1023 	jr	00200$
   4777                    1024 00199$:
   4777 AF            [ 4] 1025 	xor	a,a
   4778                    1026 00200$:
   4778 DD 77 FE      [19] 1027 	ld	-2 (ix),a
                           1028 ;src/Map.c:232: if(((*lastVal)!=CELLTYPE_FLOOR) && ((*nextVal)!=CELLTYPE_FLOOR)){
   477B DD CB FF 46   [20] 1029 	bit	0,-1 (ix)
   477F 20 3C         [12] 1030 	jr	NZ,00119$
   4781 FD 7E 00      [19] 1031 	ld	a, 0 (iy)
   4784 D6 FE         [ 7] 1032 	sub	a, #0xFE
   4786 28 35         [12] 1033 	jr	Z,00119$
                           1034 ;src/Map.c:233: if(((*topVal)!=CELLTYPE_FLOOR) && ((*bottomVal)==CELLTYPE_FLOOR)){
   4788 DD 6E FA      [19] 1035 	ld	l,-6 (ix)
   478B DD 66 FB      [19] 1036 	ld	h,-5 (ix)
   478E 7E            [ 7] 1037 	ld	a,(hl)
   478F D6 FE         [ 7] 1038 	sub	a, #0xFE
   4791 20 04         [12] 1039 	jr	NZ,00202$
   4793 3E 01         [ 7] 1040 	ld	a,#0x01
   4795 18 01         [12] 1041 	jr	00203$
   4797                    1042 00202$:
   4797 AF            [ 4] 1043 	xor	a,a
   4798                    1044 00203$:
   4798 6F            [ 4] 1045 	ld	l,a
   4799 DD CB FE 46   [20] 1046 	bit	0,-2 (ix)
   479D 20 0C         [12] 1047 	jr	NZ,00105$
   479F 7D            [ 4] 1048 	ld	a,l
   47A0 B7            [ 4] 1049 	or	a, a
   47A1 28 08         [12] 1050 	jr	Z,00105$
                           1051 ;src/Map.c:234: door_not_positioned=0;
   47A3 DD 36 F9 00   [19] 1052 	ld	-7 (ix),#0x00
                           1053 ;src/Map.c:235: *position=CELLTYPE_DOOR;
   47A7 AF            [ 4] 1054 	xor	a, a
   47A8 02            [ 7] 1055 	ld	(bc),a
   47A9 18 52         [12] 1056 	jr	00123$
   47AB                    1057 00105$:
                           1058 ;src/Map.c:237: else if(((*bottomVal)!=CELLTYPE_FLOOR) && ((*topVal)==CELLTYPE_FLOOR)){
   47AB 7D            [ 4] 1059 	ld	a,l
   47AC B7            [ 4] 1060 	or	a, a
   47AD 20 4E         [12] 1061 	jr	NZ,00123$
   47AF DD CB FE 46   [20] 1062 	bit	0,-2 (ix)
   47B3 28 48         [12] 1063 	jr	Z,00123$
                           1064 ;src/Map.c:238: door_not_positioned=0;
   47B5 DD 36 F9 00   [19] 1065 	ld	-7 (ix),#0x00
                           1066 ;src/Map.c:239: *position=CELLTYPE_DOOR;
   47B9 AF            [ 4] 1067 	xor	a, a
   47BA 02            [ 7] 1068 	ld	(bc),a
   47BB 18 40         [12] 1069 	jr	00123$
   47BD                    1070 00119$:
                           1071 ;src/Map.c:242: else if(((*topVal)!=CELLTYPE_FLOOR) && ((*bottomVal)!=CELLTYPE_FLOOR)){
   47BD DD CB FE 46   [20] 1072 	bit	0,-2 (ix)
   47C1 20 3A         [12] 1073 	jr	NZ,00123$
   47C3 DD 6E FA      [19] 1074 	ld	l,-6 (ix)
   47C6 DD 66 FB      [19] 1075 	ld	h,-5 (ix)
   47C9 7E            [ 7] 1076 	ld	a,(hl)
   47CA D6 FE         [ 7] 1077 	sub	a, #0xFE
   47CC 28 2F         [12] 1078 	jr	Z,00123$
                           1079 ;src/Map.c:232: if(((*lastVal)!=CELLTYPE_FLOOR) && ((*nextVal)!=CELLTYPE_FLOOR)){
   47CE FD 7E 00      [19] 1080 	ld	a, 0 (iy)
                           1081 ;src/Map.c:243: if(((*lastVal)!=CELLTYPE_FLOOR) && ((*nextVal)==CELLTYPE_FLOOR)){
   47D1 D6 FE         [ 7] 1082 	sub	a, #0xFE
   47D3 20 04         [12] 1083 	jr	NZ,00205$
   47D5 3E 01         [ 7] 1084 	ld	a,#0x01
   47D7 18 01         [12] 1085 	jr	00206$
   47D9                    1086 00205$:
   47D9 AF            [ 4] 1087 	xor	a,a
   47DA                    1088 00206$:
   47DA 6F            [ 4] 1089 	ld	l,a
   47DB DD CB FF 46   [20] 1090 	bit	0,-1 (ix)
   47DF 20 0C         [12] 1091 	jr	NZ,00112$
   47E1 7D            [ 4] 1092 	ld	a,l
   47E2 B7            [ 4] 1093 	or	a, a
   47E3 28 08         [12] 1094 	jr	Z,00112$
                           1095 ;src/Map.c:244: door_not_positioned=0;
   47E5 DD 36 F9 00   [19] 1096 	ld	-7 (ix),#0x00
                           1097 ;src/Map.c:245: *position=CELLTYPE_DOOR;
   47E9 AF            [ 4] 1098 	xor	a, a
   47EA 02            [ 7] 1099 	ld	(bc),a
   47EB 18 10         [12] 1100 	jr	00123$
   47ED                    1101 00112$:
                           1102 ;src/Map.c:247: else if(((*nextVal)!=CELLTYPE_FLOOR) && ((*lastVal)==CELLTYPE_FLOOR)){
   47ED 7D            [ 4] 1103 	ld	a,l
   47EE B7            [ 4] 1104 	or	a, a
   47EF 20 0C         [12] 1105 	jr	NZ,00123$
   47F1 DD CB FF 46   [20] 1106 	bit	0,-1 (ix)
   47F5 28 06         [12] 1107 	jr	Z,00123$
                           1108 ;src/Map.c:248: door_not_positioned=0;
   47F7 DD 36 F9 00   [19] 1109 	ld	-7 (ix),#0x00
                           1110 ;src/Map.c:249: *position=CELLTYPE_DOOR;
   47FB AF            [ 4] 1111 	xor	a, a
   47FC 02            [ 7] 1112 	ld	(bc),a
   47FD                    1113 00123$:
                           1114 ;src/Map.c:253: ++position;
   47FD 03            [ 6] 1115 	inc	bc
                           1116 ;src/Map.c:254: ++lastVal;
   47FE 13            [ 6] 1117 	inc	de
                           1118 ;src/Map.c:255: ++nextVal;
   47FF FD 23         [10] 1119 	inc	iy
                           1120 ;src/Map.c:256: ++topVal;
   4801 DD 34 FC      [23] 1121 	inc	-4 (ix)
   4804 20 03         [12] 1122 	jr	NZ,00207$
   4806 DD 34 FD      [23] 1123 	inc	-3 (ix)
   4809                    1124 00207$:
                           1125 ;src/Map.c:257: ++bottomVal;
   4809 DD 34 FA      [23] 1126 	inc	-6 (ix)
   480C 20 03         [12] 1127 	jr	NZ,00208$
   480E DD 34 FB      [23] 1128 	inc	-5 (ix)
   4811                    1129 00208$:
                           1130 ;src/Map.c:258: if(position>END_OF_MAP_MEM){
   4811 69            [ 4] 1131 	ld	l, c
   4812 60            [ 4] 1132 	ld	h, b
   4813 3E 40         [ 7] 1133 	ld	a,#0x40
   4815 BD            [ 4] 1134 	cp	a, l
   4816 3E 04         [ 7] 1135 	ld	a,#0x04
   4818 9C            [ 4] 1136 	sbc	a, h
   4819 D2 4D 47      [10] 1137 	jp	NC,00126$
                           1138 ;src/Map.c:259: position = MAP_MEM;
   481C 01 40 00      [10] 1139 	ld	bc,#0x0040
   481F C3 4D 47      [10] 1140 	jp	00126$
   4822                    1141 00129$:
   4822 DD F9         [10] 1142 	ld	sp, ix
   4824 DD E1         [14] 1143 	pop	ix
   4826 C9            [10] 1144 	ret
                           1145 ;src/Map.c:265: void generate_level(){
                           1146 ;	---------------------------------
                           1147 ; Function generate_level
                           1148 ; ---------------------------------
   4827                    1149 _generate_level::
                           1150 ;src/Map.c:266: generate_map();
   4827 CD 9B 41      [17] 1151 	call	_generate_map
                           1152 ;src/Map.c:267: generate_exit_door();
   482A C3 01 47      [10] 1153 	jp  _generate_exit_door
                           1154 	.area _CODE
                           1155 	.area _INITIALIZER
                           1156 	.area _CABS (ABS)
