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
                             11 	.globl _cpct_setSeed_lcg_u8
                             12 	.globl _cpct_getRandom_lcg_u8
                             13 	.globl _cpct_memset
                             14 	.globl _rand_seed
                             15 	.globl _init_generator
                             16 	.globl _generate_map
                             17 ;--------------------------------------------------------
                             18 ; special function registers
                             19 ;--------------------------------------------------------
                             20 ;--------------------------------------------------------
                             21 ; ram data
                             22 ;--------------------------------------------------------
                             23 	.area _DATA
                             24 ;--------------------------------------------------------
                             25 ; ram data
                             26 ;--------------------------------------------------------
                             27 	.area _INITIALIZED
                             28 ;--------------------------------------------------------
                             29 ; absolute external ram data
                             30 ;--------------------------------------------------------
                             31 	.area _DABS (ABS)
                             32 ;--------------------------------------------------------
                             33 ; global & static initialisations
                             34 ;--------------------------------------------------------
                             35 	.area _HOME
                             36 	.area _GSINIT
                             37 	.area _GSFINAL
                             38 	.area _GSINIT
                             39 ;--------------------------------------------------------
                             40 ; Home
                             41 ;--------------------------------------------------------
                             42 	.area _HOME
                             43 	.area _HOME
                             44 ;--------------------------------------------------------
                             45 ; code
                             46 ;--------------------------------------------------------
                             47 	.area _CODE
                             48 ;src/Map.c:10: void init_generator(){
                             49 ;	---------------------------------
                             50 ; Function init_generator
                             51 ; ---------------------------------
   4173                      52 _init_generator::
                             53 ;src/Map.c:11: cpct_setSeed_lcg_u8(rand_seed);
   4173 FD 21 7D 41   [14]   54 	ld	iy,#_rand_seed
   4177 FD 6E 00      [19]   55 	ld	l,0 (iy)
   417A C3 A0 5E      [10]   56 	jp  _cpct_setSeed_lcg_u8
   417D                      57 _rand_seed:
   417D 00                   58 	.db #0x00	; 0
                             59 ;src/Map.c:14: void generate_map(){
                             60 ;	---------------------------------
                             61 ; Function generate_map
                             62 ; ---------------------------------
   417E                      63 _generate_map::
   417E DD E5         [15]   64 	push	ix
   4180 DD 21 00 00   [14]   65 	ld	ix,#0
   4184 DD 39         [15]   66 	add	ix,sp
   4186 21 EB FF      [10]   67 	ld	hl,#-21
   4189 39            [11]   68 	add	hl,sp
   418A F9            [ 6]   69 	ld	sp,hl
                             70 ;src/Map.c:17: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
   418B DD 36 F2 83   [19]   71 	ld	-14 (ix),#0x83
   418F DD 36 F3 03   [19]   72 	ld	-13 (ix),#0x03
                             73 ;src/Map.c:23: u16 wallListCount = 0;
   4193 DD 36 ED 00   [19]   74 	ld	-19 (ix),#0x00
   4197 DD 36 EE 00   [19]   75 	ld	-18 (ix),#0x00
                             76 ;src/Map.c:24: u16 lastStackItem = 0;
   419B 21 00 00      [10]   77 	ld	hl,#0x0000
   419E E3            [19]   78 	ex	(sp), hl
                             79 ;src/Map.c:26: (*cellStack).x = (cpct_getRandom_lcg_u8()%(MAP_WIDTH-2))+1; //RANDOM
   419F CD 3A 5F      [17]   80 	call	_cpct_getRandom_lcg_u8
   41A2 45            [ 4]   81 	ld	b,l
   41A3 3E 1E         [ 7]   82 	ld	a,#0x1E
   41A5 F5            [11]   83 	push	af
   41A6 33            [ 6]   84 	inc	sp
   41A7 C5            [11]   85 	push	bc
   41A8 33            [ 6]   86 	inc	sp
   41A9 CD 89 5E      [17]   87 	call	__moduchar
   41AC F1            [10]   88 	pop	af
   41AD 4D            [ 4]   89 	ld	c,l
   41AE 0C            [ 4]   90 	inc	c
   41AF 21 40 2B      [10]   91 	ld	hl,#0x2B40
   41B2 71            [ 7]   92 	ld	(hl),c
                             93 ;src/Map.c:27: (*cellStack).y = (cpct_getRandom_lcg_u8()%(MAP_HEIGHT-2))+1; //RANDOM
   41B3 CD 3A 5F      [17]   94 	call	_cpct_getRandom_lcg_u8
   41B6 45            [ 4]   95 	ld	b,l
   41B7 3E 1E         [ 7]   96 	ld	a,#0x1E
   41B9 F5            [11]   97 	push	af
   41BA 33            [ 6]   98 	inc	sp
   41BB C5            [11]   99 	push	bc
   41BC 33            [ 6]  100 	inc	sp
   41BD CD 89 5E      [17]  101 	call	__moduchar
   41C0 F1            [10]  102 	pop	af
   41C1 4D            [ 4]  103 	ld	c,l
   41C2 0C            [ 4]  104 	inc	c
   41C3 21 41 2B      [10]  105 	ld	hl,#0x2B41
   41C6 71            [ 7]  106 	ld	(hl),c
                            107 ;src/Map.c:30: *(i8*)&(PLAYER_position.x) = (*cellStack).y;
   41C7 DD 36 FA D4   [19]  108 	ld	-6 (ix),#<(_PLAYER_position)
   41CB DD 36 FB 46   [19]  109 	ld	-5 (ix),#>(_PLAYER_position)
   41CF 2E 41         [ 7]  110 	ld	l, #0x41
   41D1 7E            [ 7]  111 	ld	a,(hl)
   41D2 DD 77 FC      [19]  112 	ld	-4 (ix),a
   41D5 DD 6E FA      [19]  113 	ld	l,-6 (ix)
   41D8 DD 66 FB      [19]  114 	ld	h,-5 (ix)
   41DB DD 7E FC      [19]  115 	ld	a,-4 (ix)
   41DE 77            [ 7]  116 	ld	(hl),a
                            117 ;src/Map.c:31: *(i8*)&(PLAYER_position.y) = (*cellStack).x;
   41DF DD 36 FA D5   [19]  118 	ld	-6 (ix),#<((_PLAYER_position + 0x0001))
   41E3 DD 36 FB 46   [19]  119 	ld	-5 (ix),#>((_PLAYER_position + 0x0001))
   41E7 21 40 2B      [10]  120 	ld	hl,#0x2B40
   41EA 4E            [ 7]  121 	ld	c,(hl)
   41EB DD 6E FA      [19]  122 	ld	l,-6 (ix)
   41EE DD 66 FB      [19]  123 	ld	h,-5 (ix)
   41F1 71            [ 7]  124 	ld	(hl),c
                            125 ;src/Map.c:33: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   41F2 21 00 04      [10]  126 	ld	hl,#0x0400
   41F5 E5            [11]  127 	push	hl
   41F6 3E FF         [ 7]  128 	ld	a,#0xFF
   41F8 F5            [11]  129 	push	af
   41F9 33            [ 6]  130 	inc	sp
   41FA 21 40 00      [10]  131 	ld	hl,#0x0040
   41FD E5            [11]  132 	push	hl
   41FE CD 59 5F      [17]  133 	call	_cpct_memset
                            134 ;src/Map.c:35: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   4201 3A 40 2B      [13]  135 	ld	a,(#0x2B40)
   4204 DD 77 FC      [19]  136 	ld	-4 (ix), a
   4207 DD 77 FA      [19]  137 	ld	-6 (ix),a
   420A DD 36 FB 00   [19]  138 	ld	-5 (ix),#0x00
   420E 3E 06         [ 7]  139 	ld	a,#0x05+1
   4210 18 08         [12]  140 	jr	00315$
   4212                     141 00314$:
   4212 DD CB FA 26   [23]  142 	sla	-6 (ix)
   4216 DD CB FB 16   [23]  143 	rl	-5 (ix)
   421A                     144 00315$:
   421A 3D            [ 4]  145 	dec	a
   421B 20 F5         [12]  146 	jr	NZ,00314$
   421D DD 7E FA      [19]  147 	ld	a,-6 (ix)
   4220 C6 40         [ 7]  148 	add	a, #0x40
   4222 DD 77 FA      [19]  149 	ld	-6 (ix),a
   4225 DD 7E FB      [19]  150 	ld	a,-5 (ix)
   4228 CE 00         [ 7]  151 	adc	a, #0x00
   422A DD 77 FB      [19]  152 	ld	-5 (ix),a
   422D 21 41 2B      [10]  153 	ld	hl,#0x2B41
   4230 4E            [ 7]  154 	ld	c,(hl)
   4231 DD 6E FA      [19]  155 	ld	l,-6 (ix)
   4234 DD 66 FB      [19]  156 	ld	h,-5 (ix)
   4237 06 00         [ 7]  157 	ld	b,#0x00
   4239 09            [11]  158 	add	hl, bc
   423A 36 FE         [10]  159 	ld	(hl),#0xFE
                            160 ;src/Map.c:38: for(i=0;i<MAP_WIDTH;++i){
   423C DD 36 F1 00   [19]  161 	ld	-15 (ix),#0x00
   4240                     162 00167$:
                            163 ;src/Map.c:39: map[0][i]=cpct_getRandom_lcg_u8()&3;
   4240 DD 7E F1      [19]  164 	ld	a,-15 (ix)
   4243 C6 40         [ 7]  165 	add	a, #0x40
   4245 DD 77 FA      [19]  166 	ld	-6 (ix),a
   4248 3E 00         [ 7]  167 	ld	a,#0x00
   424A CE 00         [ 7]  168 	adc	a, #0x00
   424C DD 77 FB      [19]  169 	ld	-5 (ix),a
   424F CD 3A 5F      [17]  170 	call	_cpct_getRandom_lcg_u8
   4252 7D            [ 4]  171 	ld	a,l
   4253 E6 03         [ 7]  172 	and	a, #0x03
   4255 DD 77 FC      [19]  173 	ld	-4 (ix),a
   4258 DD 6E FA      [19]  174 	ld	l,-6 (ix)
   425B DD 66 FB      [19]  175 	ld	h,-5 (ix)
   425E DD 7E FC      [19]  176 	ld	a,-4 (ix)
   4261 77            [ 7]  177 	ld	(hl),a
                            178 ;src/Map.c:40: map[MAP_HEIGHT-1][i]=cpct_getRandom_lcg_u8()&3;
   4262 DD 7E F1      [19]  179 	ld	a,-15 (ix)
   4265 C6 20         [ 7]  180 	add	a, #0x20
   4267 DD 77 FA      [19]  181 	ld	-6 (ix),a
   426A 3E 00         [ 7]  182 	ld	a,#0x00
   426C CE 04         [ 7]  183 	adc	a, #0x04
   426E DD 77 FB      [19]  184 	ld	-5 (ix),a
   4271 CD 3A 5F      [17]  185 	call	_cpct_getRandom_lcg_u8
   4274 7D            [ 4]  186 	ld	a,l
   4275 E6 03         [ 7]  187 	and	a, #0x03
   4277 DD 6E FA      [19]  188 	ld	l,-6 (ix)
   427A DD 66 FB      [19]  189 	ld	h,-5 (ix)
   427D 77            [ 7]  190 	ld	(hl),a
                            191 ;src/Map.c:38: for(i=0;i<MAP_WIDTH;++i){
   427E DD 34 F1      [23]  192 	inc	-15 (ix)
   4281 DD 7E F1      [19]  193 	ld	a,-15 (ix)
   4284 D6 20         [ 7]  194 	sub	a, #0x20
   4286 38 B8         [12]  195 	jr	C,00167$
                            196 ;src/Map.c:43: for(i=1;i<MAP_HEIGHT-1;++i){
   4288 DD 36 F1 01   [19]  197 	ld	-15 (ix),#0x01
   428C                     198 00169$:
                            199 ;src/Map.c:44: map[i][0]=cpct_getRandom_lcg_u8()&3;
   428C DD 7E F1      [19]  200 	ld	a,-15 (ix)
   428F DD 77 FA      [19]  201 	ld	-6 (ix),a
   4292 DD 36 FB 00   [19]  202 	ld	-5 (ix),#0x00
   4296 3E 06         [ 7]  203 	ld	a,#0x05+1
   4298 18 08         [12]  204 	jr	00317$
   429A                     205 00316$:
   429A DD CB FA 26   [23]  206 	sla	-6 (ix)
   429E DD CB FB 16   [23]  207 	rl	-5 (ix)
   42A2                     208 00317$:
   42A2 3D            [ 4]  209 	dec	a
   42A3 20 F5         [12]  210 	jr	NZ,00316$
   42A5 DD 7E FA      [19]  211 	ld	a,-6 (ix)
   42A8 C6 40         [ 7]  212 	add	a, #0x40
   42AA DD 77 FD      [19]  213 	ld	-3 (ix),a
   42AD DD 7E FB      [19]  214 	ld	a,-5 (ix)
   42B0 CE 00         [ 7]  215 	adc	a, #0x00
   42B2 DD 77 FE      [19]  216 	ld	-2 (ix),a
   42B5 CD 3A 5F      [17]  217 	call	_cpct_getRandom_lcg_u8
   42B8 7D            [ 4]  218 	ld	a,l
   42B9 E6 03         [ 7]  219 	and	a, #0x03
   42BB DD 77 FC      [19]  220 	ld	-4 (ix),a
   42BE DD 6E FD      [19]  221 	ld	l,-3 (ix)
   42C1 DD 66 FE      [19]  222 	ld	h,-2 (ix)
   42C4 DD 7E FC      [19]  223 	ld	a,-4 (ix)
   42C7 77            [ 7]  224 	ld	(hl),a
                            225 ;src/Map.c:45: map[i][MAP_WIDTH-1]=cpct_getRandom_lcg_u8()&3;
   42C8 DD 7E FA      [19]  226 	ld	a,-6 (ix)
   42CB C6 40         [ 7]  227 	add	a, #0x40
   42CD DD 77 FD      [19]  228 	ld	-3 (ix),a
   42D0 DD 7E FB      [19]  229 	ld	a,-5 (ix)
   42D3 CE 00         [ 7]  230 	adc	a, #0x00
   42D5 DD 77 FE      [19]  231 	ld	-2 (ix),a
   42D8 DD 7E FD      [19]  232 	ld	a,-3 (ix)
   42DB C6 1F         [ 7]  233 	add	a, #0x1F
   42DD 4F            [ 4]  234 	ld	c,a
   42DE DD 7E FE      [19]  235 	ld	a,-2 (ix)
   42E1 CE 00         [ 7]  236 	adc	a, #0x00
   42E3 47            [ 4]  237 	ld	b,a
   42E4 C5            [11]  238 	push	bc
   42E5 CD 3A 5F      [17]  239 	call	_cpct_getRandom_lcg_u8
   42E8 C1            [10]  240 	pop	bc
   42E9 7D            [ 4]  241 	ld	a,l
   42EA E6 03         [ 7]  242 	and	a, #0x03
   42EC 02            [ 7]  243 	ld	(bc),a
                            244 ;src/Map.c:43: for(i=1;i<MAP_HEIGHT-1;++i){
   42ED DD 34 F1      [23]  245 	inc	-15 (ix)
   42F0 DD 7E F1      [19]  246 	ld	a,-15 (ix)
   42F3 D6 1F         [ 7]  247 	sub	a, #0x1F
   42F5 38 95         [12]  248 	jr	C,00169$
                            249 ;src/Map.c:48: while(remainingCells>0){
   42F7 21 04 00      [10]  250 	ld	hl,#0x0004
   42FA 39            [11]  251 	add	hl,sp
   42FB DD 75 FD      [19]  252 	ld	-3 (ix),l
   42FE DD 74 FE      [19]  253 	ld	-2 (ix),h
   4301                     254 00164$:
   4301 DD 7E F3      [19]  255 	ld	a,-13 (ix)
   4304 DD B6 F2      [19]  256 	or	a,-14 (ix)
   4307 CA CF 46      [10]  257 	jp	Z,00171$
                            258 ;src/Map.c:49: wallListPosition = wallList+wallListCount;
   430A C1            [10]  259 	pop	bc
   430B E1            [10]  260 	pop	hl
   430C E5            [11]  261 	push	hl
   430D C5            [11]  262 	push	bc
   430E 29            [11]  263 	add	hl, hl
   430F 7D            [ 4]  264 	ld	a,l
   4310 C6 40         [ 7]  265 	add	a, #0x40
   4312 DD 77 FA      [19]  266 	ld	-6 (ix),a
   4315 7C            [ 4]  267 	ld	a,h
   4316 CE 2F         [ 7]  268 	adc	a, #0x2F
   4318 DD 77 FB      [19]  269 	ld	-5 (ix),a
                            270 ;src/Map.c:50: while(wallListCount<MAP_SIZE){
   431B D1            [10]  271 	pop	de
   431C C1            [10]  272 	pop	bc
   431D C5            [11]  273 	push	bc
   431E D5            [11]  274 	push	de
   431F                     275 00134$:
                            276 ;src/Map.c:53: currentPos.y = (*wallListPosition).y;
   431F DD 7E FD      [19]  277 	ld	a,-3 (ix)
   4322 C6 01         [ 7]  278 	add	a, #0x01
   4324 DD 77 F8      [19]  279 	ld	-8 (ix),a
   4327 DD 7E FE      [19]  280 	ld	a,-2 (ix)
   432A CE 00         [ 7]  281 	adc	a, #0x00
   432C DD 77 F9      [19]  282 	ld	-7 (ix),a
                            283 ;src/Map.c:50: while(wallListCount<MAP_SIZE){
   432F 78            [ 4]  284 	ld	a,b
   4330 D6 04         [ 7]  285 	sub	a, #0x04
   4332 D2 D1 44      [10]  286 	jp	NC,00204$
                            287 ;src/Map.c:52: currentPos.x = (*wallListPosition).x;
   4335 21 04 00      [10]  288 	ld	hl,#0x0004
   4338 39            [11]  289 	add	hl,sp
   4339 EB            [ 4]  290 	ex	de,hl
   433A DD 6E FA      [19]  291 	ld	l,-6 (ix)
   433D DD 66 FB      [19]  292 	ld	h,-5 (ix)
   4340 7E            [ 7]  293 	ld	a,(hl)
   4341 12            [ 7]  294 	ld	(de),a
                            295 ;src/Map.c:53: currentPos.y = (*wallListPosition).y;
   4342 DD 5E FA      [19]  296 	ld	e,-6 (ix)
   4345 DD 56 FB      [19]  297 	ld	d,-5 (ix)
   4348 13            [ 6]  298 	inc	de
   4349 1A            [ 7]  299 	ld	a,(de)
   434A DD 6E F8      [19]  300 	ld	l,-8 (ix)
   434D DD 66 F9      [19]  301 	ld	h,-7 (ix)
   4350 77            [ 7]  302 	ld	(hl),a
                            303 ;src/Map.c:55: convertToFloor=0;
   4351 DD 36 F5 00   [19]  304 	ld	-11 (ix),#0x00
                            305 ;src/Map.c:56: surroundedByWalls=1;
   4355 DD 36 F4 01   [19]  306 	ld	-12 (ix),#0x01
                            307 ;src/Map.c:58: if(currentPos.x>0){
   4359 DD 6E FD      [19]  308 	ld	l,-3 (ix)
   435C DD 66 FE      [19]  309 	ld	h,-2 (ix)
   435F 7E            [ 7]  310 	ld	a,(hl)
   4360 DD 77 FC      [19]  311 	ld	-4 (ix),a
                            312 ;src/Map.c:59: adjacentType = map[currentPos.x-1][currentPos.y];
   4363 DD 6E F8      [19]  313 	ld	l,-8 (ix)
   4366 DD 66 F9      [19]  314 	ld	h,-7 (ix)
   4369 7E            [ 7]  315 	ld	a,(hl)
   436A DD 77 FF      [19]  316 	ld	-1 (ix),a
   436D DD 7E FC      [19]  317 	ld	a,-4 (ix)
   4370 DD 77 F6      [19]  318 	ld	-10 (ix),a
   4373 DD 36 F7 00   [19]  319 	ld	-9 (ix),#0x00
                            320 ;src/Map.c:58: if(currentPos.x>0){
   4377 DD 7E FC      [19]  321 	ld	a,-4 (ix)
   437A B7            [ 4]  322 	or	a, a
   437B 28 2F         [12]  323 	jr	Z,00109$
                            324 ;src/Map.c:59: adjacentType = map[currentPos.x-1][currentPos.y];
   437D DD 6E F6      [19]  325 	ld	l,-10 (ix)
   4380 DD 66 F7      [19]  326 	ld	h,-9 (ix)
   4383 2B            [ 6]  327 	dec	hl
   4384 29            [11]  328 	add	hl, hl
   4385 29            [11]  329 	add	hl, hl
   4386 29            [11]  330 	add	hl, hl
   4387 29            [11]  331 	add	hl, hl
   4388 29            [11]  332 	add	hl, hl
   4389 D5            [11]  333 	push	de
   438A 11 40 00      [10]  334 	ld	de,#0x0040
   438D 19            [11]  335 	add	hl, de
   438E D1            [10]  336 	pop	de
   438F 7D            [ 4]  337 	ld	a,l
   4390 DD 86 FF      [19]  338 	add	a, -1 (ix)
   4393 6F            [ 4]  339 	ld	l,a
   4394 7C            [ 4]  340 	ld	a,h
   4395 CE 00         [ 7]  341 	adc	a, #0x00
   4397 67            [ 4]  342 	ld	h,a
   4398 6E            [ 7]  343 	ld	l,(hl)
                            344 ;src/Map.c:60: if(adjacentType == CELLTYPE_UNDEFINED){
   4399 7D            [ 4]  345 	ld	a,l
   439A 3C            [ 4]  346 	inc	a
   439B 20 06         [12]  347 	jr	NZ,00106$
                            348 ;src/Map.c:61: convertToFloor  = 1;
   439D DD 36 F5 01   [19]  349 	ld	-11 (ix),#0x01
   43A1 18 09         [12]  350 	jr	00109$
   43A3                     351 00106$:
                            352 ;src/Map.c:63: else if(adjacentType == CELLTYPE_FLOOR){
   43A3 7D            [ 4]  353 	ld	a,l
   43A4 D6 FE         [ 7]  354 	sub	a, #0xFE
   43A6 20 04         [12]  355 	jr	NZ,00109$
                            356 ;src/Map.c:64: surroundedByWalls = 0;
   43A8 DD 36 F4 00   [19]  357 	ld	-12 (ix),#0x00
   43AC                     358 00109$:
                            359 ;src/Map.c:67: if(currentPos.x < (MAP_WIDTH-1)){
   43AC DD 7E FC      [19]  360 	ld	a,-4 (ix)
   43AF D6 1F         [ 7]  361 	sub	a, #0x1F
   43B1 30 2F         [12]  362 	jr	NC,00116$
                            363 ;src/Map.c:69: adjacentType = map[currentPos.x+1][currentPos.y];
   43B3 DD 6E F6      [19]  364 	ld	l,-10 (ix)
   43B6 DD 66 F7      [19]  365 	ld	h,-9 (ix)
   43B9 23            [ 6]  366 	inc	hl
   43BA 29            [11]  367 	add	hl, hl
   43BB 29            [11]  368 	add	hl, hl
   43BC 29            [11]  369 	add	hl, hl
   43BD 29            [11]  370 	add	hl, hl
   43BE 29            [11]  371 	add	hl, hl
   43BF D5            [11]  372 	push	de
   43C0 11 40 00      [10]  373 	ld	de,#0x0040
   43C3 19            [11]  374 	add	hl, de
   43C4 D1            [10]  375 	pop	de
   43C5 7D            [ 4]  376 	ld	a,l
   43C6 DD 86 FF      [19]  377 	add	a, -1 (ix)
   43C9 6F            [ 4]  378 	ld	l,a
   43CA 7C            [ 4]  379 	ld	a,h
   43CB CE 00         [ 7]  380 	adc	a, #0x00
   43CD 67            [ 4]  381 	ld	h,a
   43CE 6E            [ 7]  382 	ld	l,(hl)
                            383 ;src/Map.c:70: if(adjacentType == CELLTYPE_UNDEFINED){
   43CF 7D            [ 4]  384 	ld	a,l
   43D0 3C            [ 4]  385 	inc	a
   43D1 20 06         [12]  386 	jr	NZ,00113$
                            387 ;src/Map.c:71: convertToFloor  = 1;
   43D3 DD 36 F5 01   [19]  388 	ld	-11 (ix),#0x01
   43D7 18 09         [12]  389 	jr	00116$
   43D9                     390 00113$:
                            391 ;src/Map.c:73: else if(adjacentType == CELLTYPE_FLOOR){
   43D9 7D            [ 4]  392 	ld	a,l
   43DA D6 FE         [ 7]  393 	sub	a, #0xFE
   43DC 20 04         [12]  394 	jr	NZ,00116$
                            395 ;src/Map.c:74: surroundedByWalls = 0;
   43DE DD 36 F4 00   [19]  396 	ld	-12 (ix),#0x00
   43E2                     397 00116$:
                            398 ;src/Map.c:79: adjacentType = map[currentPos.x][currentPos.y-1];
   43E2 DD 6E F6      [19]  399 	ld	l,-10 (ix)
   43E5 DD 66 F7      [19]  400 	ld	h,-9 (ix)
   43E8 29            [11]  401 	add	hl, hl
   43E9 29            [11]  402 	add	hl, hl
   43EA 29            [11]  403 	add	hl, hl
   43EB 29            [11]  404 	add	hl, hl
   43EC 29            [11]  405 	add	hl, hl
   43ED 7D            [ 4]  406 	ld	a,l
   43EE C6 40         [ 7]  407 	add	a, #0x40
   43F0 DD 77 F6      [19]  408 	ld	-10 (ix),a
   43F3 7C            [ 4]  409 	ld	a,h
   43F4 CE 00         [ 7]  410 	adc	a, #0x00
   43F6 DD 77 F7      [19]  411 	ld	-9 (ix),a
                            412 ;src/Map.c:77: if(currentPos.y > 0){
   43F9 DD 7E FF      [19]  413 	ld	a,-1 (ix)
   43FC B7            [ 4]  414 	or	a, a
   43FD 28 23         [12]  415 	jr	Z,00123$
                            416 ;src/Map.c:79: adjacentType = map[currentPos.x][currentPos.y-1];
   43FF DD 6E FF      [19]  417 	ld	l,-1 (ix)
   4402 2D            [ 4]  418 	dec	l
   4403 DD 7E F6      [19]  419 	ld	a,-10 (ix)
   4406 85            [ 4]  420 	add	a, l
   4407 6F            [ 4]  421 	ld	l,a
   4408 DD 7E F7      [19]  422 	ld	a,-9 (ix)
   440B CE 00         [ 7]  423 	adc	a, #0x00
   440D 67            [ 4]  424 	ld	h,a
   440E 6E            [ 7]  425 	ld	l,(hl)
                            426 ;src/Map.c:80: if(adjacentType == CELLTYPE_UNDEFINED){
   440F 7D            [ 4]  427 	ld	a,l
   4410 3C            [ 4]  428 	inc	a
   4411 20 06         [12]  429 	jr	NZ,00120$
                            430 ;src/Map.c:81: convertToFloor  = 1;
   4413 DD 36 F5 01   [19]  431 	ld	-11 (ix),#0x01
   4417 18 09         [12]  432 	jr	00123$
   4419                     433 00120$:
                            434 ;src/Map.c:83: else if(adjacentType == CELLTYPE_FLOOR){
   4419 7D            [ 4]  435 	ld	a,l
   441A D6 FE         [ 7]  436 	sub	a, #0xFE
   441C 20 04         [12]  437 	jr	NZ,00123$
                            438 ;src/Map.c:84: surroundedByWalls = 0;
   441E DD 36 F4 00   [19]  439 	ld	-12 (ix),#0x00
   4422                     440 00123$:
                            441 ;src/Map.c:87: if(currentPos.y < (MAP_HEIGHT-1)){
   4422 DD 7E FF      [19]  442 	ld	a,-1 (ix)
   4425 D6 1F         [ 7]  443 	sub	a, #0x1F
   4427 30 23         [12]  444 	jr	NC,00130$
                            445 ;src/Map.c:89: adjacentType = map[currentPos.x][currentPos.y+1];
   4429 DD 6E FF      [19]  446 	ld	l,-1 (ix)
   442C 2C            [ 4]  447 	inc	l
   442D DD 7E F6      [19]  448 	ld	a,-10 (ix)
   4430 85            [ 4]  449 	add	a, l
   4431 6F            [ 4]  450 	ld	l,a
   4432 DD 7E F7      [19]  451 	ld	a,-9 (ix)
   4435 CE 00         [ 7]  452 	adc	a, #0x00
   4437 67            [ 4]  453 	ld	h,a
   4438 6E            [ 7]  454 	ld	l,(hl)
                            455 ;src/Map.c:90: if(adjacentType == CELLTYPE_UNDEFINED){
   4439 7D            [ 4]  456 	ld	a,l
   443A 3C            [ 4]  457 	inc	a
   443B 20 06         [12]  458 	jr	NZ,00127$
                            459 ;src/Map.c:91: convertToFloor  = 1;
   443D DD 36 F5 01   [19]  460 	ld	-11 (ix),#0x01
   4441 18 09         [12]  461 	jr	00130$
   4443                     462 00127$:
                            463 ;src/Map.c:93: else if(adjacentType == CELLTYPE_FLOOR){
   4443 7D            [ 4]  464 	ld	a,l
   4444 D6 FE         [ 7]  465 	sub	a, #0xFE
   4446 20 04         [12]  466 	jr	NZ,00130$
                            467 ;src/Map.c:94: surroundedByWalls = 0;
   4448 DD 36 F4 00   [19]  468 	ld	-12 (ix),#0x00
   444C                     469 00130$:
                            470 ;src/Map.c:98: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   444C 69            [ 4]  471 	ld	l, c
   444D 60            [ 4]  472 	ld	h, b
   444E 29            [11]  473 	add	hl, hl
   444F FD 21 40 2F   [14]  474 	ld	iy,#0x2F40
   4453 C5            [11]  475 	push	bc
   4454 4D            [ 4]  476 	ld	c, l
   4455 44            [ 4]  477 	ld	b, h
   4456 FD 09         [15]  478 	add	iy, bc
   4458 C1            [10]  479 	pop	bc
   4459 FD 7E 00      [19]  480 	ld	a, 0 (iy)
   445C DD 6E FA      [19]  481 	ld	l,-6 (ix)
   445F DD 66 FB      [19]  482 	ld	h,-5 (ix)
   4462 77            [ 7]  483 	ld	(hl),a
                            484 ;src/Map.c:99: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   4463 FD E5         [15]  485 	push	iy
   4465 E1            [10]  486 	pop	hl
   4466 23            [ 6]  487 	inc	hl
   4467 7E            [ 7]  488 	ld	a,(hl)
   4468 12            [ 7]  489 	ld	(de),a
                            490 ;src/Map.c:100: --wallListCount;
   4469 0B            [ 6]  491 	dec	bc
   446A DD 71 ED      [19]  492 	ld	-19 (ix),c
   446D DD 70 EE      [19]  493 	ld	-18 (ix),b
                            494 ;src/Map.c:103: if((convertToFloor)&&(!surroundedByWalls)){
   4470 DD 7E F5      [19]  495 	ld	a,-11 (ix)
   4473 B7            [ 4]  496 	or	a, a
   4474 28 4A         [12]  497 	jr	Z,00132$
   4476 DD 7E F4      [19]  498 	ld	a,-12 (ix)
   4479 B7            [ 4]  499 	or	a, a
   447A 20 44         [12]  500 	jr	NZ,00132$
                            501 ;src/Map.c:104: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   447C DD 6E FD      [19]  502 	ld	l,-3 (ix)
   447F DD 66 FE      [19]  503 	ld	h,-2 (ix)
   4482 6E            [ 7]  504 	ld	l,(hl)
   4483 26 00         [ 7]  505 	ld	h,#0x00
   4485 29            [11]  506 	add	hl, hl
   4486 29            [11]  507 	add	hl, hl
   4487 29            [11]  508 	add	hl, hl
   4488 29            [11]  509 	add	hl, hl
   4489 29            [11]  510 	add	hl, hl
   448A 01 40 00      [10]  511 	ld	bc,#0x0040
   448D 09            [11]  512 	add	hl,bc
   448E 4D            [ 4]  513 	ld	c,l
   448F 44            [ 4]  514 	ld	b,h
   4490 DD 6E F8      [19]  515 	ld	l,-8 (ix)
   4493 DD 66 F9      [19]  516 	ld	h,-7 (ix)
   4496 6E            [ 7]  517 	ld	l, (hl)
   4497 26 00         [ 7]  518 	ld	h,#0x00
   4499 09            [11]  519 	add	hl,bc
   449A 36 FE         [10]  520 	ld	(hl),#0xFE
                            521 ;src/Map.c:106: ++lastStackItem;
   449C DD 34 EB      [23]  522 	inc	-21 (ix)
   449F 20 03         [12]  523 	jr	NZ,00334$
   44A1 DD 34 EC      [23]  524 	inc	-20 (ix)
   44A4                     525 00334$:
                            526 ;src/Map.c:107: (*(cellStack+lastStackItem)).x = currentPos.x;
   44A4 E1            [10]  527 	pop	hl
   44A5 E5            [11]  528 	push	hl
   44A6 29            [11]  529 	add	hl, hl
   44A7 01 40 2B      [10]  530 	ld	bc, #0x2B40
   44AA 09            [11]  531 	add	hl,bc
   44AB 4D            [ 4]  532 	ld	c, l
   44AC 44            [ 4]  533 	ld	b, h
   44AD DD 6E FD      [19]  534 	ld	l,-3 (ix)
   44B0 DD 66 FE      [19]  535 	ld	h,-2 (ix)
   44B3 7E            [ 7]  536 	ld	a,(hl)
   44B4 02            [ 7]  537 	ld	(bc),a
                            538 ;src/Map.c:108: (*(cellStack+lastStackItem)).y = currentPos.y;
   44B5 03            [ 6]  539 	inc	bc
   44B6 DD 6E F8      [19]  540 	ld	l,-8 (ix)
   44B9 DD 66 F9      [19]  541 	ld	h,-7 (ix)
   44BC 7E            [ 7]  542 	ld	a,(hl)
   44BD 02            [ 7]  543 	ld	(bc),a
                            544 ;src/Map.c:111: break;
   44BE 18 11         [12]  545 	jr	00204$
   44C0                     546 00132$:
                            547 ;src/Map.c:113: --wallListPosition;
   44C0 DD 6E FA      [19]  548 	ld	l,-6 (ix)
   44C3 DD 66 FB      [19]  549 	ld	h,-5 (ix)
   44C6 2B            [ 6]  550 	dec	hl
   44C7 2B            [ 6]  551 	dec	hl
   44C8 DD 75 FA      [19]  552 	ld	-6 (ix),l
   44CB DD 74 FB      [19]  553 	ld	-5 (ix),h
   44CE C3 1F 43      [10]  554 	jp	00134$
                            555 ;src/Map.c:115: while(lastStackItem<MAP_SIZE){
   44D1                     556 00204$:
   44D1 DD 7E F2      [19]  557 	ld	a,-14 (ix)
   44D4 DD 77 F6      [19]  558 	ld	-10 (ix),a
   44D7 DD 7E F3      [19]  559 	ld	a,-13 (ix)
   44DA DD 77 F7      [19]  560 	ld	-9 (ix),a
   44DD DD 7E ED      [19]  561 	ld	a,-19 (ix)
   44E0 DD 77 FA      [19]  562 	ld	-6 (ix),a
   44E3 DD 7E EE      [19]  563 	ld	a,-18 (ix)
   44E6 DD 77 FB      [19]  564 	ld	-5 (ix),a
   44E9                     565 00161$:
   44E9 DD 7E EC      [19]  566 	ld	a,-20 (ix)
   44EC D6 04         [ 7]  567 	sub	a, #0x04
   44EE D2 01 43      [10]  568 	jp	NC,00164$
                            569 ;src/Map.c:116: currentPos.x=(*(lastStackItem+cellStack)).x;
   44F1 21 04 00      [10]  570 	ld	hl,#0x0004
   44F4 39            [11]  571 	add	hl,sp
   44F5 4D            [ 4]  572 	ld	c,l
   44F6 44            [ 4]  573 	ld	b,h
   44F7 E1            [10]  574 	pop	hl
   44F8 E5            [11]  575 	push	hl
   44F9 29            [11]  576 	add	hl, hl
   44FA FD 21 40 2B   [14]  577 	ld	iy,#0x2B40
   44FE EB            [ 4]  578 	ex	de,hl
   44FF FD 19         [15]  579 	add	iy, de
   4501 FD 7E 00      [19]  580 	ld	a, 0 (iy)
   4504 02            [ 7]  581 	ld	(bc),a
                            582 ;src/Map.c:117: currentPos.y=(*(lastStackItem+cellStack)).y;
   4505 FD 4E 01      [19]  583 	ld	c,1 (iy)
   4508 DD 6E F8      [19]  584 	ld	l,-8 (ix)
   450B DD 66 F9      [19]  585 	ld	h,-7 (ix)
   450E 71            [ 7]  586 	ld	(hl),c
                            587 ;src/Map.c:118: --lastStackItem;
   450F E1            [10]  588 	pop	hl
   4510 E5            [11]  589 	push	hl
   4511 2B            [ 6]  590 	dec	hl
   4512 E3            [19]  591 	ex	(sp), hl
                            592 ;src/Map.c:119: cellType = map[currentPos.x][currentPos.y];
   4513 DD 6E FD      [19]  593 	ld	l,-3 (ix)
   4516 DD 66 FE      [19]  594 	ld	h,-2 (ix)
   4519 6E            [ 7]  595 	ld	l,(hl)
   451A 26 00         [ 7]  596 	ld	h,#0x00
   451C 29            [11]  597 	add	hl, hl
   451D 29            [11]  598 	add	hl, hl
   451E 29            [11]  599 	add	hl, hl
   451F 29            [11]  600 	add	hl, hl
   4520 29            [11]  601 	add	hl, hl
   4521 11 40 00      [10]  602 	ld	de,#0x0040
   4524 19            [11]  603 	add	hl,de
   4525 59            [ 4]  604 	ld	e,c
   4526 16 00         [ 7]  605 	ld	d,#0x00
   4528 19            [11]  606 	add	hl,de
   4529 4E            [ 7]  607 	ld	c,(hl)
                            608 ;src/Map.c:121: if(cellType == CELLTYPE_UNDEFINED){
   452A 79            [ 4]  609 	ld	a,c
   452B 3C            [ 4]  610 	inc	a
   452C 20 4A         [12]  611 	jr	NZ,00141$
                            612 ;src/Map.c:123: if(cpct_getRandom_lcg_u8()&1){//WALL
   452E CD 3A 5F      [17]  613 	call	_cpct_getRandom_lcg_u8
   4531 CB 45         [ 8]  614 	bit	0, l
   4533 28 09         [12]  615 	jr	Z,00138$
                            616 ;src/Map.c:124: cellType = cpct_getRandom_lcg_u8()&3;
   4535 CD 3A 5F      [17]  617 	call	_cpct_getRandom_lcg_u8
   4538 7D            [ 4]  618 	ld	a,l
   4539 E6 03         [ 7]  619 	and	a, #0x03
   453B 4F            [ 4]  620 	ld	c,a
   453C 18 02         [12]  621 	jr	00139$
   453E                     622 00138$:
                            623 ;src/Map.c:127: cellType = CELLTYPE_FLOOR;
   453E 0E FE         [ 7]  624 	ld	c,#0xFE
   4540                     625 00139$:
                            626 ;src/Map.c:130: map[currentPos.x][currentPos.y]=cellType;
   4540 DD 6E FD      [19]  627 	ld	l,-3 (ix)
   4543 DD 66 FE      [19]  628 	ld	h,-2 (ix)
   4546 6E            [ 7]  629 	ld	l,(hl)
   4547 26 00         [ 7]  630 	ld	h,#0x00
   4549 29            [11]  631 	add	hl, hl
   454A 29            [11]  632 	add	hl, hl
   454B 29            [11]  633 	add	hl, hl
   454C 29            [11]  634 	add	hl, hl
   454D 29            [11]  635 	add	hl, hl
   454E EB            [ 4]  636 	ex	de,hl
   454F 21 40 00      [10]  637 	ld	hl,#0x0040
   4552 19            [11]  638 	add	hl,de
   4553 EB            [ 4]  639 	ex	de,hl
   4554 DD 6E F8      [19]  640 	ld	l,-8 (ix)
   4557 DD 66 F9      [19]  641 	ld	h,-7 (ix)
   455A 6E            [ 7]  642 	ld	l, (hl)
   455B 26 00         [ 7]  643 	ld	h,#0x00
   455D 19            [11]  644 	add	hl,de
   455E 71            [ 7]  645 	ld	(hl),c
                            646 ;src/Map.c:131: --remainingCells;
   455F DD 6E F6      [19]  647 	ld	l,-10 (ix)
   4562 DD 66 F7      [19]  648 	ld	h,-9 (ix)
   4565 2B            [ 6]  649 	dec	hl
   4566 DD 75 F6      [19]  650 	ld	-10 (ix),l
   4569 DD 74 F7      [19]  651 	ld	-9 (ix),h
   456C DD 7E F6      [19]  652 	ld	a,-10 (ix)
   456F DD 77 F2      [19]  653 	ld	-14 (ix),a
   4572 DD 7E F7      [19]  654 	ld	a,-9 (ix)
   4575 DD 77 F3      [19]  655 	ld	-13 (ix),a
   4578                     656 00141$:
                            657 ;src/Map.c:58: if(currentPos.x>0){
   4578 DD 6E FD      [19]  658 	ld	l,-3 (ix)
   457B DD 66 FE      [19]  659 	ld	h,-2 (ix)
   457E 7E            [ 7]  660 	ld	a,(hl)
   457F DD 77 FF      [19]  661 	ld	-1 (ix),a
                            662 ;src/Map.c:134: if((cellType == CELLTYPE_FLOOR)){
   4582 79            [ 4]  663 	ld	a,c
   4583 D6 FE         [ 7]  664 	sub	a, #0xFE
   4585 C2 9E 46      [10]  665 	jp	NZ,00159$
                            666 ;src/Map.c:135: if(currentPos.x>0){
   4588 DD 7E FF      [19]  667 	ld	a,-1 (ix)
   458B B7            [ 4]  668 	or	a, a
   458C 28 3E         [12]  669 	jr	Z,00145$
                            670 ;src/Map.c:136: adjacentType = map[currentPos.x-1][currentPos.y];
   458E DD 6E FF      [19]  671 	ld	l,-1 (ix)
   4591 26 00         [ 7]  672 	ld	h,#0x00
   4593 2B            [ 6]  673 	dec	hl
   4594 29            [11]  674 	add	hl, hl
   4595 29            [11]  675 	add	hl, hl
   4596 29            [11]  676 	add	hl, hl
   4597 29            [11]  677 	add	hl, hl
   4598 29            [11]  678 	add	hl, hl
   4599 01 40 00      [10]  679 	ld	bc,#0x0040
   459C 09            [11]  680 	add	hl,bc
   459D 4D            [ 4]  681 	ld	c,l
   459E 44            [ 4]  682 	ld	b,h
   459F DD 6E F8      [19]  683 	ld	l,-8 (ix)
   45A2 DD 66 F9      [19]  684 	ld	h,-7 (ix)
   45A5 6E            [ 7]  685 	ld	l, (hl)
   45A6 26 00         [ 7]  686 	ld	h,#0x00
   45A8 09            [11]  687 	add	hl,bc
   45A9 4E            [ 7]  688 	ld	c,(hl)
                            689 ;src/Map.c:137: if(adjacentType == CELLTYPE_UNDEFINED){
   45AA 0C            [ 4]  690 	inc	c
   45AB 20 1F         [12]  691 	jr	NZ,00145$
                            692 ;src/Map.c:139: ++lastStackItem;
   45AD DD 34 EB      [23]  693 	inc	-21 (ix)
   45B0 20 03         [12]  694 	jr	NZ,00342$
   45B2 DD 34 EC      [23]  695 	inc	-20 (ix)
   45B5                     696 00342$:
                            697 ;src/Map.c:140: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   45B5 E1            [10]  698 	pop	hl
   45B6 E5            [11]  699 	push	hl
   45B7 29            [11]  700 	add	hl, hl
   45B8 01 40 2B      [10]  701 	ld	bc,#0x2B40
   45BB 09            [11]  702 	add	hl,bc
   45BC DD 4E FF      [19]  703 	ld	c,-1 (ix)
   45BF 0D            [ 4]  704 	dec	c
   45C0 71            [ 7]  705 	ld	(hl),c
                            706 ;src/Map.c:141: (*(cellStack+lastStackItem)).y = currentPos.y;
   45C1 23            [ 6]  707 	inc	hl
   45C2 4D            [ 4]  708 	ld	c,l
   45C3 44            [ 4]  709 	ld	b,h
   45C4 DD 6E F8      [19]  710 	ld	l,-8 (ix)
   45C7 DD 66 F9      [19]  711 	ld	h,-7 (ix)
   45CA 7E            [ 7]  712 	ld	a,(hl)
   45CB 02            [ 7]  713 	ld	(bc),a
   45CC                     714 00145$:
                            715 ;src/Map.c:145: if(currentPos.x < (MAP_WIDTH-1)){
   45CC DD 6E FD      [19]  716 	ld	l,-3 (ix)
   45CF DD 66 FE      [19]  717 	ld	h,-2 (ix)
   45D2 4E            [ 7]  718 	ld	c,(hl)
   45D3 79            [ 4]  719 	ld	a,c
   45D4 D6 1F         [ 7]  720 	sub	a, #0x1F
   45D6 30 39         [12]  721 	jr	NC,00149$
                            722 ;src/Map.c:147: adjacentType = map[currentPos.x+1][currentPos.y];
   45D8 69            [ 4]  723 	ld	l,c
   45D9 26 00         [ 7]  724 	ld	h,#0x00
   45DB 23            [ 6]  725 	inc	hl
   45DC 29            [11]  726 	add	hl, hl
   45DD 29            [11]  727 	add	hl, hl
   45DE 29            [11]  728 	add	hl, hl
   45DF 29            [11]  729 	add	hl, hl
   45E0 29            [11]  730 	add	hl, hl
   45E1 EB            [ 4]  731 	ex	de,hl
   45E2 21 40 00      [10]  732 	ld	hl,#0x0040
   45E5 19            [11]  733 	add	hl,de
   45E6 EB            [ 4]  734 	ex	de,hl
   45E7 DD 6E F8      [19]  735 	ld	l,-8 (ix)
   45EA DD 66 F9      [19]  736 	ld	h,-7 (ix)
   45ED 6E            [ 7]  737 	ld	l, (hl)
   45EE 26 00         [ 7]  738 	ld	h,#0x00
   45F0 19            [11]  739 	add	hl,de
   45F1 46            [ 7]  740 	ld	b,(hl)
                            741 ;src/Map.c:148: if(adjacentType == CELLTYPE_UNDEFINED){
   45F2 04            [ 4]  742 	inc	b
   45F3 20 1C         [12]  743 	jr	NZ,00149$
                            744 ;src/Map.c:151: ++lastStackItem;
   45F5 DD 34 EB      [23]  745 	inc	-21 (ix)
   45F8 20 03         [12]  746 	jr	NZ,00345$
   45FA DD 34 EC      [23]  747 	inc	-20 (ix)
   45FD                     748 00345$:
                            749 ;src/Map.c:152: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   45FD E1            [10]  750 	pop	hl
   45FE E5            [11]  751 	push	hl
   45FF 29            [11]  752 	add	hl, hl
   4600 11 40 2B      [10]  753 	ld	de,#0x2B40
   4603 19            [11]  754 	add	hl,de
   4604 0C            [ 4]  755 	inc	c
   4605 71            [ 7]  756 	ld	(hl),c
                            757 ;src/Map.c:153: (*(cellStack+lastStackItem)).y = currentPos.y;
   4606 23            [ 6]  758 	inc	hl
   4607 4D            [ 4]  759 	ld	c,l
   4608 44            [ 4]  760 	ld	b,h
   4609 DD 6E F8      [19]  761 	ld	l,-8 (ix)
   460C DD 66 F9      [19]  762 	ld	h,-7 (ix)
   460F 7E            [ 7]  763 	ld	a,(hl)
   4610 02            [ 7]  764 	ld	(bc),a
   4611                     765 00149$:
                            766 ;src/Map.c:59: adjacentType = map[currentPos.x-1][currentPos.y];
   4611 DD 6E F8      [19]  767 	ld	l,-8 (ix)
   4614 DD 66 F9      [19]  768 	ld	h,-7 (ix)
   4617 4E            [ 7]  769 	ld	c,(hl)
                            770 ;src/Map.c:157: if(currentPos.y > 0){
   4618 79            [ 4]  771 	ld	a,c
   4619 B7            [ 4]  772 	or	a, a
   461A 28 39         [12]  773 	jr	Z,00153$
                            774 ;src/Map.c:159: adjacentType = map[currentPos.x][currentPos.y-1];
   461C DD 6E FD      [19]  775 	ld	l,-3 (ix)
   461F DD 66 FE      [19]  776 	ld	h,-2 (ix)
   4622 46            [ 7]  777 	ld	b,(hl)
   4623 68            [ 4]  778 	ld	l,b
   4624 26 00         [ 7]  779 	ld	h,#0x00
   4626 29            [11]  780 	add	hl, hl
   4627 29            [11]  781 	add	hl, hl
   4628 29            [11]  782 	add	hl, hl
   4629 29            [11]  783 	add	hl, hl
   462A 29            [11]  784 	add	hl, hl
   462B 11 40 00      [10]  785 	ld	de,#0x0040
   462E 19            [11]  786 	add	hl,de
   462F 0D            [ 4]  787 	dec	c
   4630 59            [ 4]  788 	ld	e,c
   4631 16 00         [ 7]  789 	ld	d,#0x00
   4633 19            [11]  790 	add	hl,de
   4634 4E            [ 7]  791 	ld	c,(hl)
                            792 ;src/Map.c:160: if(adjacentType == CELLTYPE_UNDEFINED){
   4635 0C            [ 4]  793 	inc	c
   4636 20 1D         [12]  794 	jr	NZ,00153$
                            795 ;src/Map.c:163: ++lastStackItem;
   4638 DD 34 EB      [23]  796 	inc	-21 (ix)
   463B 20 03         [12]  797 	jr	NZ,00348$
   463D DD 34 EC      [23]  798 	inc	-20 (ix)
   4640                     799 00348$:
                            800 ;src/Map.c:164: (*(cellStack+lastStackItem)).x = currentPos.x;
   4640 E1            [10]  801 	pop	hl
   4641 E5            [11]  802 	push	hl
   4642 29            [11]  803 	add	hl, hl
   4643 11 40 2B      [10]  804 	ld	de,#0x2B40
   4646 19            [11]  805 	add	hl,de
   4647 70            [ 7]  806 	ld	(hl),b
                            807 ;src/Map.c:165: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   4648 23            [ 6]  808 	inc	hl
   4649 4D            [ 4]  809 	ld	c,l
   464A 44            [ 4]  810 	ld	b,h
   464B DD 6E F8      [19]  811 	ld	l,-8 (ix)
   464E DD 66 F9      [19]  812 	ld	h,-7 (ix)
   4651 5E            [ 7]  813 	ld	e,(hl)
   4652 1D            [ 4]  814 	dec	e
   4653 7B            [ 4]  815 	ld	a,e
   4654 02            [ 7]  816 	ld	(bc),a
   4655                     817 00153$:
                            818 ;src/Map.c:59: adjacentType = map[currentPos.x-1][currentPos.y];
   4655 DD 6E F8      [19]  819 	ld	l,-8 (ix)
   4658 DD 66 F9      [19]  820 	ld	h,-7 (ix)
   465B 46            [ 7]  821 	ld	b,(hl)
                            822 ;src/Map.c:169: if(currentPos.y < (MAP_HEIGHT-1)){
   465C 78            [ 4]  823 	ld	a,b
   465D D6 1F         [ 7]  824 	sub	a, #0x1F
   465F D2 E9 44      [10]  825 	jp	NC,00161$
                            826 ;src/Map.c:171: adjacentType = map[currentPos.x][currentPos.y+1];
   4662 DD 6E FD      [19]  827 	ld	l,-3 (ix)
   4665 DD 66 FE      [19]  828 	ld	h,-2 (ix)
   4668 4E            [ 7]  829 	ld	c,(hl)
   4669 69            [ 4]  830 	ld	l,c
   466A 26 00         [ 7]  831 	ld	h,#0x00
   466C 29            [11]  832 	add	hl, hl
   466D 29            [11]  833 	add	hl, hl
   466E 29            [11]  834 	add	hl, hl
   466F 29            [11]  835 	add	hl, hl
   4670 29            [11]  836 	add	hl, hl
   4671 11 40 00      [10]  837 	ld	de,#0x0040
   4674 19            [11]  838 	add	hl,de
   4675 04            [ 4]  839 	inc	b
   4676 58            [ 4]  840 	ld	e,b
   4677 16 00         [ 7]  841 	ld	d,#0x00
   4679 19            [11]  842 	add	hl,de
   467A 46            [ 7]  843 	ld	b,(hl)
                            844 ;src/Map.c:172: if(adjacentType == CELLTYPE_UNDEFINED){
   467B 04            [ 4]  845 	inc	b
   467C C2 E9 44      [10]  846 	jp	NZ,00161$
                            847 ;src/Map.c:175: ++lastStackItem;
   467F DD 34 EB      [23]  848 	inc	-21 (ix)
   4682 20 03         [12]  849 	jr	NZ,00351$
   4684 DD 34 EC      [23]  850 	inc	-20 (ix)
   4687                     851 00351$:
                            852 ;src/Map.c:176: (*(cellStack+lastStackItem)).x = currentPos.x;
   4687 E1            [10]  853 	pop	hl
   4688 E5            [11]  854 	push	hl
   4689 29            [11]  855 	add	hl, hl
   468A 11 40 2B      [10]  856 	ld	de,#0x2B40
   468D 19            [11]  857 	add	hl,de
   468E 71            [ 7]  858 	ld	(hl),c
                            859 ;src/Map.c:177: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   468F 23            [ 6]  860 	inc	hl
   4690 4D            [ 4]  861 	ld	c,l
   4691 44            [ 4]  862 	ld	b,h
   4692 DD 6E F8      [19]  863 	ld	l,-8 (ix)
   4695 DD 66 F9      [19]  864 	ld	h,-7 (ix)
   4698 7E            [ 7]  865 	ld	a,(hl)
   4699 3C            [ 4]  866 	inc	a
   469A 02            [ 7]  867 	ld	(bc),a
   469B C3 E9 44      [10]  868 	jp	00161$
   469E                     869 00159$:
                            870 ;src/Map.c:183: ++wallListCount;
   469E DD 34 FA      [23]  871 	inc	-6 (ix)
   46A1 20 03         [12]  872 	jr	NZ,00352$
   46A3 DD 34 FB      [23]  873 	inc	-5 (ix)
   46A6                     874 00352$:
   46A6 DD 7E FA      [19]  875 	ld	a,-6 (ix)
   46A9 DD 77 ED      [19]  876 	ld	-19 (ix),a
   46AC DD 7E FB      [19]  877 	ld	a,-5 (ix)
   46AF DD 77 EE      [19]  878 	ld	-18 (ix),a
                            879 ;src/Map.c:184: (*(wallList+wallListCount)).x = currentPos.x;
   46B2 DD 6E FA      [19]  880 	ld	l,-6 (ix)
   46B5 DD 66 FB      [19]  881 	ld	h,-5 (ix)
   46B8 29            [11]  882 	add	hl, hl
   46B9 01 40 2F      [10]  883 	ld	bc,#0x2F40
   46BC 09            [11]  884 	add	hl,bc
   46BD DD 7E FF      [19]  885 	ld	a,-1 (ix)
   46C0 77            [ 7]  886 	ld	(hl),a
                            887 ;src/Map.c:185: (*(wallList+wallListCount)).y = currentPos.y;
   46C1 23            [ 6]  888 	inc	hl
   46C2 4D            [ 4]  889 	ld	c,l
   46C3 44            [ 4]  890 	ld	b,h
   46C4 DD 6E F8      [19]  891 	ld	l,-8 (ix)
   46C7 DD 66 F9      [19]  892 	ld	h,-7 (ix)
   46CA 7E            [ 7]  893 	ld	a,(hl)
   46CB 02            [ 7]  894 	ld	(bc),a
   46CC C3 E9 44      [10]  895 	jp	00161$
   46CF                     896 00171$:
   46CF DD F9         [10]  897 	ld	sp, ix
   46D1 DD E1         [14]  898 	pop	ix
   46D3 C9            [10]  899 	ret
                            900 	.area _CODE
                            901 	.area _INITIALIZER
                            902 	.area _CABS (ABS)
