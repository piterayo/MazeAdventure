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
   418D                      52 _init_generator::
                             53 ;src/Map.c:11: cpct_setSeed_lcg_u8(rand_seed);
   418D FD 21 97 41   [14]   54 	ld	iy,#_rand_seed
   4191 FD 6E 00      [19]   55 	ld	l,0 (iy)
   4194 C3 76 5D      [10]   56 	jp  _cpct_setSeed_lcg_u8
   4197                      57 _rand_seed:
   4197 00                   58 	.db #0x00	; 0
                             59 ;src/Map.c:14: void generate_map(){
                             60 ;	---------------------------------
                             61 ; Function generate_map
                             62 ; ---------------------------------
   4198                      63 _generate_map::
   4198 DD E5         [15]   64 	push	ix
   419A DD 21 00 00   [14]   65 	ld	ix,#0
   419E DD 39         [15]   66 	add	ix,sp
   41A0 21 EB FF      [10]   67 	ld	hl,#-21
   41A3 39            [11]   68 	add	hl,sp
   41A4 F9            [ 6]   69 	ld	sp,hl
                             70 ;src/Map.c:17: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
   41A5 DD 36 F2 83   [19]   71 	ld	-14 (ix),#0x83
   41A9 DD 36 F3 03   [19]   72 	ld	-13 (ix),#0x03
                             73 ;src/Map.c:23: u16 wallListCount = 0;
   41AD DD 36 ED 00   [19]   74 	ld	-19 (ix),#0x00
   41B1 DD 36 EE 00   [19]   75 	ld	-18 (ix),#0x00
                             76 ;src/Map.c:24: u16 lastStackItem = 0;
   41B5 21 00 00      [10]   77 	ld	hl,#0x0000
   41B8 E3            [19]   78 	ex	(sp), hl
                             79 ;src/Map.c:26: (*cellStack).x = (cpct_getRandom_lcg_u8()%(MAP_WIDTH-2))+1; //RANDOM
   41B9 CD 10 5E      [17]   80 	call	_cpct_getRandom_lcg_u8
   41BC 45            [ 4]   81 	ld	b,l
   41BD 3E 1E         [ 7]   82 	ld	a,#0x1E
   41BF F5            [11]   83 	push	af
   41C0 33            [ 6]   84 	inc	sp
   41C1 C5            [11]   85 	push	bc
   41C2 33            [ 6]   86 	inc	sp
   41C3 CD 5F 5D      [17]   87 	call	__moduchar
   41C6 F1            [10]   88 	pop	af
   41C7 4D            [ 4]   89 	ld	c,l
   41C8 0C            [ 4]   90 	inc	c
   41C9 21 40 1C      [10]   91 	ld	hl,#0x1C40
   41CC 71            [ 7]   92 	ld	(hl),c
                             93 ;src/Map.c:27: (*cellStack).y = (cpct_getRandom_lcg_u8()%(MAP_HEIGHT-2))+1; //RANDOM
   41CD CD 10 5E      [17]   94 	call	_cpct_getRandom_lcg_u8
   41D0 45            [ 4]   95 	ld	b,l
   41D1 3E 1E         [ 7]   96 	ld	a,#0x1E
   41D3 F5            [11]   97 	push	af
   41D4 33            [ 6]   98 	inc	sp
   41D5 C5            [11]   99 	push	bc
   41D6 33            [ 6]  100 	inc	sp
   41D7 CD 5F 5D      [17]  101 	call	__moduchar
   41DA F1            [10]  102 	pop	af
   41DB 4D            [ 4]  103 	ld	c,l
   41DC 0C            [ 4]  104 	inc	c
   41DD 21 41 1C      [10]  105 	ld	hl,#0x1C41
   41E0 71            [ 7]  106 	ld	(hl),c
                            107 ;src/Map.c:30: *(i8*)&(PLAYER_position.x) = (*cellStack).y;
   41E1 DD 36 FA EE   [19]  108 	ld	-6 (ix),#<(_PLAYER_position)
   41E5 DD 36 FB 46   [19]  109 	ld	-5 (ix),#>(_PLAYER_position)
   41E9 2E 41         [ 7]  110 	ld	l, #0x41
   41EB 7E            [ 7]  111 	ld	a,(hl)
   41EC DD 77 FC      [19]  112 	ld	-4 (ix),a
   41EF DD 6E FA      [19]  113 	ld	l,-6 (ix)
   41F2 DD 66 FB      [19]  114 	ld	h,-5 (ix)
   41F5 DD 7E FC      [19]  115 	ld	a,-4 (ix)
   41F8 77            [ 7]  116 	ld	(hl),a
                            117 ;src/Map.c:31: *(i8*)&(PLAYER_position.y) = (*cellStack).x;
   41F9 DD 36 FA EF   [19]  118 	ld	-6 (ix),#<((_PLAYER_position + 0x0001))
   41FD DD 36 FB 46   [19]  119 	ld	-5 (ix),#>((_PLAYER_position + 0x0001))
   4201 21 40 1C      [10]  120 	ld	hl,#0x1C40
   4204 4E            [ 7]  121 	ld	c,(hl)
   4205 DD 6E FA      [19]  122 	ld	l,-6 (ix)
   4208 DD 66 FB      [19]  123 	ld	h,-5 (ix)
   420B 71            [ 7]  124 	ld	(hl),c
                            125 ;src/Map.c:33: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   420C 21 00 04      [10]  126 	ld	hl,#0x0400
   420F E5            [11]  127 	push	hl
   4210 3E FF         [ 7]  128 	ld	a,#0xFF
   4212 F5            [11]  129 	push	af
   4213 33            [ 6]  130 	inc	sp
   4214 21 40 00      [10]  131 	ld	hl,#0x0040
   4217 E5            [11]  132 	push	hl
   4218 CD 2F 5E      [17]  133 	call	_cpct_memset
                            134 ;src/Map.c:35: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   421B 3A 40 1C      [13]  135 	ld	a,(#0x1C40)
   421E DD 77 FC      [19]  136 	ld	-4 (ix), a
   4221 DD 77 FA      [19]  137 	ld	-6 (ix),a
   4224 DD 36 FB 00   [19]  138 	ld	-5 (ix),#0x00
   4228 3E 06         [ 7]  139 	ld	a,#0x05+1
   422A 18 08         [12]  140 	jr	00315$
   422C                     141 00314$:
   422C DD CB FA 26   [23]  142 	sla	-6 (ix)
   4230 DD CB FB 16   [23]  143 	rl	-5 (ix)
   4234                     144 00315$:
   4234 3D            [ 4]  145 	dec	a
   4235 20 F5         [12]  146 	jr	NZ,00314$
   4237 DD 7E FA      [19]  147 	ld	a,-6 (ix)
   423A C6 40         [ 7]  148 	add	a, #0x40
   423C DD 77 FA      [19]  149 	ld	-6 (ix),a
   423F DD 7E FB      [19]  150 	ld	a,-5 (ix)
   4242 CE 00         [ 7]  151 	adc	a, #0x00
   4244 DD 77 FB      [19]  152 	ld	-5 (ix),a
   4247 21 41 1C      [10]  153 	ld	hl,#0x1C41
   424A 4E            [ 7]  154 	ld	c,(hl)
   424B DD 6E FA      [19]  155 	ld	l,-6 (ix)
   424E DD 66 FB      [19]  156 	ld	h,-5 (ix)
   4251 06 00         [ 7]  157 	ld	b,#0x00
   4253 09            [11]  158 	add	hl, bc
   4254 36 FE         [10]  159 	ld	(hl),#0xFE
                            160 ;src/Map.c:38: for(i=0;i<MAP_WIDTH;++i){
   4256 DD 36 F1 00   [19]  161 	ld	-15 (ix),#0x00
   425A                     162 00167$:
                            163 ;src/Map.c:39: map[0][i]=cpct_getRandom_lcg_u8()&3;
   425A DD 7E F1      [19]  164 	ld	a,-15 (ix)
   425D C6 40         [ 7]  165 	add	a, #0x40
   425F DD 77 FA      [19]  166 	ld	-6 (ix),a
   4262 3E 00         [ 7]  167 	ld	a,#0x00
   4264 CE 00         [ 7]  168 	adc	a, #0x00
   4266 DD 77 FB      [19]  169 	ld	-5 (ix),a
   4269 CD 10 5E      [17]  170 	call	_cpct_getRandom_lcg_u8
   426C 7D            [ 4]  171 	ld	a,l
   426D E6 03         [ 7]  172 	and	a, #0x03
   426F DD 77 FC      [19]  173 	ld	-4 (ix),a
   4272 DD 6E FA      [19]  174 	ld	l,-6 (ix)
   4275 DD 66 FB      [19]  175 	ld	h,-5 (ix)
   4278 DD 7E FC      [19]  176 	ld	a,-4 (ix)
   427B 77            [ 7]  177 	ld	(hl),a
                            178 ;src/Map.c:40: map[MAP_HEIGHT-1][i]=cpct_getRandom_lcg_u8()&3;
   427C DD 7E F1      [19]  179 	ld	a,-15 (ix)
   427F C6 20         [ 7]  180 	add	a, #0x20
   4281 DD 77 FA      [19]  181 	ld	-6 (ix),a
   4284 3E 00         [ 7]  182 	ld	a,#0x00
   4286 CE 04         [ 7]  183 	adc	a, #0x04
   4288 DD 77 FB      [19]  184 	ld	-5 (ix),a
   428B CD 10 5E      [17]  185 	call	_cpct_getRandom_lcg_u8
   428E 7D            [ 4]  186 	ld	a,l
   428F E6 03         [ 7]  187 	and	a, #0x03
   4291 DD 6E FA      [19]  188 	ld	l,-6 (ix)
   4294 DD 66 FB      [19]  189 	ld	h,-5 (ix)
   4297 77            [ 7]  190 	ld	(hl),a
                            191 ;src/Map.c:38: for(i=0;i<MAP_WIDTH;++i){
   4298 DD 34 F1      [23]  192 	inc	-15 (ix)
   429B DD 7E F1      [19]  193 	ld	a,-15 (ix)
   429E D6 20         [ 7]  194 	sub	a, #0x20
   42A0 38 B8         [12]  195 	jr	C,00167$
                            196 ;src/Map.c:43: for(i=1;i<MAP_HEIGHT-1;++i){
   42A2 DD 36 F1 01   [19]  197 	ld	-15 (ix),#0x01
   42A6                     198 00169$:
                            199 ;src/Map.c:44: map[i][0]=cpct_getRandom_lcg_u8()&3;
   42A6 DD 7E F1      [19]  200 	ld	a,-15 (ix)
   42A9 DD 77 FA      [19]  201 	ld	-6 (ix),a
   42AC DD 36 FB 00   [19]  202 	ld	-5 (ix),#0x00
   42B0 3E 06         [ 7]  203 	ld	a,#0x05+1
   42B2 18 08         [12]  204 	jr	00317$
   42B4                     205 00316$:
   42B4 DD CB FA 26   [23]  206 	sla	-6 (ix)
   42B8 DD CB FB 16   [23]  207 	rl	-5 (ix)
   42BC                     208 00317$:
   42BC 3D            [ 4]  209 	dec	a
   42BD 20 F5         [12]  210 	jr	NZ,00316$
   42BF DD 7E FA      [19]  211 	ld	a,-6 (ix)
   42C2 C6 40         [ 7]  212 	add	a, #0x40
   42C4 DD 77 FD      [19]  213 	ld	-3 (ix),a
   42C7 DD 7E FB      [19]  214 	ld	a,-5 (ix)
   42CA CE 00         [ 7]  215 	adc	a, #0x00
   42CC DD 77 FE      [19]  216 	ld	-2 (ix),a
   42CF CD 10 5E      [17]  217 	call	_cpct_getRandom_lcg_u8
   42D2 7D            [ 4]  218 	ld	a,l
   42D3 E6 03         [ 7]  219 	and	a, #0x03
   42D5 DD 77 FC      [19]  220 	ld	-4 (ix),a
   42D8 DD 6E FD      [19]  221 	ld	l,-3 (ix)
   42DB DD 66 FE      [19]  222 	ld	h,-2 (ix)
   42DE DD 7E FC      [19]  223 	ld	a,-4 (ix)
   42E1 77            [ 7]  224 	ld	(hl),a
                            225 ;src/Map.c:45: map[i][MAP_WIDTH-1]=cpct_getRandom_lcg_u8()&3;
   42E2 DD 7E FA      [19]  226 	ld	a,-6 (ix)
   42E5 C6 40         [ 7]  227 	add	a, #0x40
   42E7 DD 77 FD      [19]  228 	ld	-3 (ix),a
   42EA DD 7E FB      [19]  229 	ld	a,-5 (ix)
   42ED CE 00         [ 7]  230 	adc	a, #0x00
   42EF DD 77 FE      [19]  231 	ld	-2 (ix),a
   42F2 DD 7E FD      [19]  232 	ld	a,-3 (ix)
   42F5 C6 1F         [ 7]  233 	add	a, #0x1F
   42F7 4F            [ 4]  234 	ld	c,a
   42F8 DD 7E FE      [19]  235 	ld	a,-2 (ix)
   42FB CE 00         [ 7]  236 	adc	a, #0x00
   42FD 47            [ 4]  237 	ld	b,a
   42FE C5            [11]  238 	push	bc
   42FF CD 10 5E      [17]  239 	call	_cpct_getRandom_lcg_u8
   4302 C1            [10]  240 	pop	bc
   4303 7D            [ 4]  241 	ld	a,l
   4304 E6 03         [ 7]  242 	and	a, #0x03
   4306 02            [ 7]  243 	ld	(bc),a
                            244 ;src/Map.c:43: for(i=1;i<MAP_HEIGHT-1;++i){
   4307 DD 34 F1      [23]  245 	inc	-15 (ix)
   430A DD 7E F1      [19]  246 	ld	a,-15 (ix)
   430D D6 1F         [ 7]  247 	sub	a, #0x1F
   430F 38 95         [12]  248 	jr	C,00169$
                            249 ;src/Map.c:48: while(remainingCells>0){
   4311 21 04 00      [10]  250 	ld	hl,#0x0004
   4314 39            [11]  251 	add	hl,sp
   4315 DD 75 FD      [19]  252 	ld	-3 (ix),l
   4318 DD 74 FE      [19]  253 	ld	-2 (ix),h
   431B                     254 00164$:
   431B DD 7E F3      [19]  255 	ld	a,-13 (ix)
   431E DD B6 F2      [19]  256 	or	a,-14 (ix)
   4321 CA E9 46      [10]  257 	jp	Z,00171$
                            258 ;src/Map.c:49: wallListPosition = wallList+wallListCount;
   4324 C1            [10]  259 	pop	bc
   4325 E1            [10]  260 	pop	hl
   4326 E5            [11]  261 	push	hl
   4327 C5            [11]  262 	push	bc
   4328 29            [11]  263 	add	hl, hl
   4329 7D            [ 4]  264 	ld	a,l
   432A C6 40         [ 7]  265 	add	a, #0x40
   432C DD 77 FA      [19]  266 	ld	-6 (ix),a
   432F 7C            [ 4]  267 	ld	a,h
   4330 CE 20         [ 7]  268 	adc	a, #0x20
   4332 DD 77 FB      [19]  269 	ld	-5 (ix),a
                            270 ;src/Map.c:50: while(wallListCount<MAP_SIZE){
   4335 D1            [10]  271 	pop	de
   4336 C1            [10]  272 	pop	bc
   4337 C5            [11]  273 	push	bc
   4338 D5            [11]  274 	push	de
   4339                     275 00134$:
                            276 ;src/Map.c:53: currentPos.y = (*wallListPosition).y;
   4339 DD 7E FD      [19]  277 	ld	a,-3 (ix)
   433C C6 01         [ 7]  278 	add	a, #0x01
   433E DD 77 F8      [19]  279 	ld	-8 (ix),a
   4341 DD 7E FE      [19]  280 	ld	a,-2 (ix)
   4344 CE 00         [ 7]  281 	adc	a, #0x00
   4346 DD 77 F9      [19]  282 	ld	-7 (ix),a
                            283 ;src/Map.c:50: while(wallListCount<MAP_SIZE){
   4349 78            [ 4]  284 	ld	a,b
   434A D6 04         [ 7]  285 	sub	a, #0x04
   434C D2 EB 44      [10]  286 	jp	NC,00204$
                            287 ;src/Map.c:52: currentPos.x = (*wallListPosition).x;
   434F 21 04 00      [10]  288 	ld	hl,#0x0004
   4352 39            [11]  289 	add	hl,sp
   4353 EB            [ 4]  290 	ex	de,hl
   4354 DD 6E FA      [19]  291 	ld	l,-6 (ix)
   4357 DD 66 FB      [19]  292 	ld	h,-5 (ix)
   435A 7E            [ 7]  293 	ld	a,(hl)
   435B 12            [ 7]  294 	ld	(de),a
                            295 ;src/Map.c:53: currentPos.y = (*wallListPosition).y;
   435C DD 5E FA      [19]  296 	ld	e,-6 (ix)
   435F DD 56 FB      [19]  297 	ld	d,-5 (ix)
   4362 13            [ 6]  298 	inc	de
   4363 1A            [ 7]  299 	ld	a,(de)
   4364 DD 6E F8      [19]  300 	ld	l,-8 (ix)
   4367 DD 66 F9      [19]  301 	ld	h,-7 (ix)
   436A 77            [ 7]  302 	ld	(hl),a
                            303 ;src/Map.c:55: convertToFloor=0;
   436B DD 36 F5 00   [19]  304 	ld	-11 (ix),#0x00
                            305 ;src/Map.c:56: surroundedByWalls=1;
   436F DD 36 F4 01   [19]  306 	ld	-12 (ix),#0x01
                            307 ;src/Map.c:58: if(currentPos.x>0){
   4373 DD 6E FD      [19]  308 	ld	l,-3 (ix)
   4376 DD 66 FE      [19]  309 	ld	h,-2 (ix)
   4379 7E            [ 7]  310 	ld	a,(hl)
   437A DD 77 FC      [19]  311 	ld	-4 (ix),a
                            312 ;src/Map.c:59: adjacentType = map[currentPos.x-1][currentPos.y];
   437D DD 6E F8      [19]  313 	ld	l,-8 (ix)
   4380 DD 66 F9      [19]  314 	ld	h,-7 (ix)
   4383 7E            [ 7]  315 	ld	a,(hl)
   4384 DD 77 FF      [19]  316 	ld	-1 (ix),a
   4387 DD 7E FC      [19]  317 	ld	a,-4 (ix)
   438A DD 77 F6      [19]  318 	ld	-10 (ix),a
   438D DD 36 F7 00   [19]  319 	ld	-9 (ix),#0x00
                            320 ;src/Map.c:58: if(currentPos.x>0){
   4391 DD 7E FC      [19]  321 	ld	a,-4 (ix)
   4394 B7            [ 4]  322 	or	a, a
   4395 28 2F         [12]  323 	jr	Z,00109$
                            324 ;src/Map.c:59: adjacentType = map[currentPos.x-1][currentPos.y];
   4397 DD 6E F6      [19]  325 	ld	l,-10 (ix)
   439A DD 66 F7      [19]  326 	ld	h,-9 (ix)
   439D 2B            [ 6]  327 	dec	hl
   439E 29            [11]  328 	add	hl, hl
   439F 29            [11]  329 	add	hl, hl
   43A0 29            [11]  330 	add	hl, hl
   43A1 29            [11]  331 	add	hl, hl
   43A2 29            [11]  332 	add	hl, hl
   43A3 D5            [11]  333 	push	de
   43A4 11 40 00      [10]  334 	ld	de,#0x0040
   43A7 19            [11]  335 	add	hl, de
   43A8 D1            [10]  336 	pop	de
   43A9 7D            [ 4]  337 	ld	a,l
   43AA DD 86 FF      [19]  338 	add	a, -1 (ix)
   43AD 6F            [ 4]  339 	ld	l,a
   43AE 7C            [ 4]  340 	ld	a,h
   43AF CE 00         [ 7]  341 	adc	a, #0x00
   43B1 67            [ 4]  342 	ld	h,a
   43B2 6E            [ 7]  343 	ld	l,(hl)
                            344 ;src/Map.c:60: if(adjacentType == CELLTYPE_UNDEFINED){
   43B3 7D            [ 4]  345 	ld	a,l
   43B4 3C            [ 4]  346 	inc	a
   43B5 20 06         [12]  347 	jr	NZ,00106$
                            348 ;src/Map.c:61: convertToFloor  = 1;
   43B7 DD 36 F5 01   [19]  349 	ld	-11 (ix),#0x01
   43BB 18 09         [12]  350 	jr	00109$
   43BD                     351 00106$:
                            352 ;src/Map.c:63: else if(adjacentType == CELLTYPE_FLOOR){
   43BD 7D            [ 4]  353 	ld	a,l
   43BE D6 FE         [ 7]  354 	sub	a, #0xFE
   43C0 20 04         [12]  355 	jr	NZ,00109$
                            356 ;src/Map.c:64: surroundedByWalls = 0;
   43C2 DD 36 F4 00   [19]  357 	ld	-12 (ix),#0x00
   43C6                     358 00109$:
                            359 ;src/Map.c:67: if(currentPos.x < (MAP_WIDTH-1)){
   43C6 DD 7E FC      [19]  360 	ld	a,-4 (ix)
   43C9 D6 1F         [ 7]  361 	sub	a, #0x1F
   43CB 30 2F         [12]  362 	jr	NC,00116$
                            363 ;src/Map.c:69: adjacentType = map[currentPos.x+1][currentPos.y];
   43CD DD 6E F6      [19]  364 	ld	l,-10 (ix)
   43D0 DD 66 F7      [19]  365 	ld	h,-9 (ix)
   43D3 23            [ 6]  366 	inc	hl
   43D4 29            [11]  367 	add	hl, hl
   43D5 29            [11]  368 	add	hl, hl
   43D6 29            [11]  369 	add	hl, hl
   43D7 29            [11]  370 	add	hl, hl
   43D8 29            [11]  371 	add	hl, hl
   43D9 D5            [11]  372 	push	de
   43DA 11 40 00      [10]  373 	ld	de,#0x0040
   43DD 19            [11]  374 	add	hl, de
   43DE D1            [10]  375 	pop	de
   43DF 7D            [ 4]  376 	ld	a,l
   43E0 DD 86 FF      [19]  377 	add	a, -1 (ix)
   43E3 6F            [ 4]  378 	ld	l,a
   43E4 7C            [ 4]  379 	ld	a,h
   43E5 CE 00         [ 7]  380 	adc	a, #0x00
   43E7 67            [ 4]  381 	ld	h,a
   43E8 6E            [ 7]  382 	ld	l,(hl)
                            383 ;src/Map.c:70: if(adjacentType == CELLTYPE_UNDEFINED){
   43E9 7D            [ 4]  384 	ld	a,l
   43EA 3C            [ 4]  385 	inc	a
   43EB 20 06         [12]  386 	jr	NZ,00113$
                            387 ;src/Map.c:71: convertToFloor  = 1;
   43ED DD 36 F5 01   [19]  388 	ld	-11 (ix),#0x01
   43F1 18 09         [12]  389 	jr	00116$
   43F3                     390 00113$:
                            391 ;src/Map.c:73: else if(adjacentType == CELLTYPE_FLOOR){
   43F3 7D            [ 4]  392 	ld	a,l
   43F4 D6 FE         [ 7]  393 	sub	a, #0xFE
   43F6 20 04         [12]  394 	jr	NZ,00116$
                            395 ;src/Map.c:74: surroundedByWalls = 0;
   43F8 DD 36 F4 00   [19]  396 	ld	-12 (ix),#0x00
   43FC                     397 00116$:
                            398 ;src/Map.c:79: adjacentType = map[currentPos.x][currentPos.y-1];
   43FC DD 6E F6      [19]  399 	ld	l,-10 (ix)
   43FF DD 66 F7      [19]  400 	ld	h,-9 (ix)
   4402 29            [11]  401 	add	hl, hl
   4403 29            [11]  402 	add	hl, hl
   4404 29            [11]  403 	add	hl, hl
   4405 29            [11]  404 	add	hl, hl
   4406 29            [11]  405 	add	hl, hl
   4407 7D            [ 4]  406 	ld	a,l
   4408 C6 40         [ 7]  407 	add	a, #0x40
   440A DD 77 F6      [19]  408 	ld	-10 (ix),a
   440D 7C            [ 4]  409 	ld	a,h
   440E CE 00         [ 7]  410 	adc	a, #0x00
   4410 DD 77 F7      [19]  411 	ld	-9 (ix),a
                            412 ;src/Map.c:77: if(currentPos.y > 0){
   4413 DD 7E FF      [19]  413 	ld	a,-1 (ix)
   4416 B7            [ 4]  414 	or	a, a
   4417 28 23         [12]  415 	jr	Z,00123$
                            416 ;src/Map.c:79: adjacentType = map[currentPos.x][currentPos.y-1];
   4419 DD 6E FF      [19]  417 	ld	l,-1 (ix)
   441C 2D            [ 4]  418 	dec	l
   441D DD 7E F6      [19]  419 	ld	a,-10 (ix)
   4420 85            [ 4]  420 	add	a, l
   4421 6F            [ 4]  421 	ld	l,a
   4422 DD 7E F7      [19]  422 	ld	a,-9 (ix)
   4425 CE 00         [ 7]  423 	adc	a, #0x00
   4427 67            [ 4]  424 	ld	h,a
   4428 6E            [ 7]  425 	ld	l,(hl)
                            426 ;src/Map.c:80: if(adjacentType == CELLTYPE_UNDEFINED){
   4429 7D            [ 4]  427 	ld	a,l
   442A 3C            [ 4]  428 	inc	a
   442B 20 06         [12]  429 	jr	NZ,00120$
                            430 ;src/Map.c:81: convertToFloor  = 1;
   442D DD 36 F5 01   [19]  431 	ld	-11 (ix),#0x01
   4431 18 09         [12]  432 	jr	00123$
   4433                     433 00120$:
                            434 ;src/Map.c:83: else if(adjacentType == CELLTYPE_FLOOR){
   4433 7D            [ 4]  435 	ld	a,l
   4434 D6 FE         [ 7]  436 	sub	a, #0xFE
   4436 20 04         [12]  437 	jr	NZ,00123$
                            438 ;src/Map.c:84: surroundedByWalls = 0;
   4438 DD 36 F4 00   [19]  439 	ld	-12 (ix),#0x00
   443C                     440 00123$:
                            441 ;src/Map.c:87: if(currentPos.y < (MAP_HEIGHT-1)){
   443C DD 7E FF      [19]  442 	ld	a,-1 (ix)
   443F D6 1F         [ 7]  443 	sub	a, #0x1F
   4441 30 23         [12]  444 	jr	NC,00130$
                            445 ;src/Map.c:89: adjacentType = map[currentPos.x][currentPos.y+1];
   4443 DD 6E FF      [19]  446 	ld	l,-1 (ix)
   4446 2C            [ 4]  447 	inc	l
   4447 DD 7E F6      [19]  448 	ld	a,-10 (ix)
   444A 85            [ 4]  449 	add	a, l
   444B 6F            [ 4]  450 	ld	l,a
   444C DD 7E F7      [19]  451 	ld	a,-9 (ix)
   444F CE 00         [ 7]  452 	adc	a, #0x00
   4451 67            [ 4]  453 	ld	h,a
   4452 6E            [ 7]  454 	ld	l,(hl)
                            455 ;src/Map.c:90: if(adjacentType == CELLTYPE_UNDEFINED){
   4453 7D            [ 4]  456 	ld	a,l
   4454 3C            [ 4]  457 	inc	a
   4455 20 06         [12]  458 	jr	NZ,00127$
                            459 ;src/Map.c:91: convertToFloor  = 1;
   4457 DD 36 F5 01   [19]  460 	ld	-11 (ix),#0x01
   445B 18 09         [12]  461 	jr	00130$
   445D                     462 00127$:
                            463 ;src/Map.c:93: else if(adjacentType == CELLTYPE_FLOOR){
   445D 7D            [ 4]  464 	ld	a,l
   445E D6 FE         [ 7]  465 	sub	a, #0xFE
   4460 20 04         [12]  466 	jr	NZ,00130$
                            467 ;src/Map.c:94: surroundedByWalls = 0;
   4462 DD 36 F4 00   [19]  468 	ld	-12 (ix),#0x00
   4466                     469 00130$:
                            470 ;src/Map.c:98: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   4466 69            [ 4]  471 	ld	l, c
   4467 60            [ 4]  472 	ld	h, b
   4468 29            [11]  473 	add	hl, hl
   4469 FD 21 40 20   [14]  474 	ld	iy,#0x2040
   446D C5            [11]  475 	push	bc
   446E 4D            [ 4]  476 	ld	c, l
   446F 44            [ 4]  477 	ld	b, h
   4470 FD 09         [15]  478 	add	iy, bc
   4472 C1            [10]  479 	pop	bc
   4473 FD 7E 00      [19]  480 	ld	a, 0 (iy)
   4476 DD 6E FA      [19]  481 	ld	l,-6 (ix)
   4479 DD 66 FB      [19]  482 	ld	h,-5 (ix)
   447C 77            [ 7]  483 	ld	(hl),a
                            484 ;src/Map.c:99: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   447D FD E5         [15]  485 	push	iy
   447F E1            [10]  486 	pop	hl
   4480 23            [ 6]  487 	inc	hl
   4481 7E            [ 7]  488 	ld	a,(hl)
   4482 12            [ 7]  489 	ld	(de),a
                            490 ;src/Map.c:100: --wallListCount;
   4483 0B            [ 6]  491 	dec	bc
   4484 DD 71 ED      [19]  492 	ld	-19 (ix),c
   4487 DD 70 EE      [19]  493 	ld	-18 (ix),b
                            494 ;src/Map.c:103: if((convertToFloor)&&(!surroundedByWalls)){
   448A DD 7E F5      [19]  495 	ld	a,-11 (ix)
   448D B7            [ 4]  496 	or	a, a
   448E 28 4A         [12]  497 	jr	Z,00132$
   4490 DD 7E F4      [19]  498 	ld	a,-12 (ix)
   4493 B7            [ 4]  499 	or	a, a
   4494 20 44         [12]  500 	jr	NZ,00132$
                            501 ;src/Map.c:104: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   4496 DD 6E FD      [19]  502 	ld	l,-3 (ix)
   4499 DD 66 FE      [19]  503 	ld	h,-2 (ix)
   449C 6E            [ 7]  504 	ld	l,(hl)
   449D 26 00         [ 7]  505 	ld	h,#0x00
   449F 29            [11]  506 	add	hl, hl
   44A0 29            [11]  507 	add	hl, hl
   44A1 29            [11]  508 	add	hl, hl
   44A2 29            [11]  509 	add	hl, hl
   44A3 29            [11]  510 	add	hl, hl
   44A4 01 40 00      [10]  511 	ld	bc,#0x0040
   44A7 09            [11]  512 	add	hl,bc
   44A8 4D            [ 4]  513 	ld	c,l
   44A9 44            [ 4]  514 	ld	b,h
   44AA DD 6E F8      [19]  515 	ld	l,-8 (ix)
   44AD DD 66 F9      [19]  516 	ld	h,-7 (ix)
   44B0 6E            [ 7]  517 	ld	l, (hl)
   44B1 26 00         [ 7]  518 	ld	h,#0x00
   44B3 09            [11]  519 	add	hl,bc
   44B4 36 FE         [10]  520 	ld	(hl),#0xFE
                            521 ;src/Map.c:106: ++lastStackItem;
   44B6 DD 34 EB      [23]  522 	inc	-21 (ix)
   44B9 20 03         [12]  523 	jr	NZ,00334$
   44BB DD 34 EC      [23]  524 	inc	-20 (ix)
   44BE                     525 00334$:
                            526 ;src/Map.c:107: (*(cellStack+lastStackItem)).x = currentPos.x;
   44BE E1            [10]  527 	pop	hl
   44BF E5            [11]  528 	push	hl
   44C0 29            [11]  529 	add	hl, hl
   44C1 01 40 1C      [10]  530 	ld	bc, #0x1C40
   44C4 09            [11]  531 	add	hl,bc
   44C5 4D            [ 4]  532 	ld	c, l
   44C6 44            [ 4]  533 	ld	b, h
   44C7 DD 6E FD      [19]  534 	ld	l,-3 (ix)
   44CA DD 66 FE      [19]  535 	ld	h,-2 (ix)
   44CD 7E            [ 7]  536 	ld	a,(hl)
   44CE 02            [ 7]  537 	ld	(bc),a
                            538 ;src/Map.c:108: (*(cellStack+lastStackItem)).y = currentPos.y;
   44CF 03            [ 6]  539 	inc	bc
   44D0 DD 6E F8      [19]  540 	ld	l,-8 (ix)
   44D3 DD 66 F9      [19]  541 	ld	h,-7 (ix)
   44D6 7E            [ 7]  542 	ld	a,(hl)
   44D7 02            [ 7]  543 	ld	(bc),a
                            544 ;src/Map.c:111: break;
   44D8 18 11         [12]  545 	jr	00204$
   44DA                     546 00132$:
                            547 ;src/Map.c:113: --wallListPosition;
   44DA DD 6E FA      [19]  548 	ld	l,-6 (ix)
   44DD DD 66 FB      [19]  549 	ld	h,-5 (ix)
   44E0 2B            [ 6]  550 	dec	hl
   44E1 2B            [ 6]  551 	dec	hl
   44E2 DD 75 FA      [19]  552 	ld	-6 (ix),l
   44E5 DD 74 FB      [19]  553 	ld	-5 (ix),h
   44E8 C3 39 43      [10]  554 	jp	00134$
                            555 ;src/Map.c:115: while(lastStackItem<MAP_SIZE){
   44EB                     556 00204$:
   44EB DD 7E F2      [19]  557 	ld	a,-14 (ix)
   44EE DD 77 F6      [19]  558 	ld	-10 (ix),a
   44F1 DD 7E F3      [19]  559 	ld	a,-13 (ix)
   44F4 DD 77 F7      [19]  560 	ld	-9 (ix),a
   44F7 DD 7E ED      [19]  561 	ld	a,-19 (ix)
   44FA DD 77 FA      [19]  562 	ld	-6 (ix),a
   44FD DD 7E EE      [19]  563 	ld	a,-18 (ix)
   4500 DD 77 FB      [19]  564 	ld	-5 (ix),a
   4503                     565 00161$:
   4503 DD 7E EC      [19]  566 	ld	a,-20 (ix)
   4506 D6 04         [ 7]  567 	sub	a, #0x04
   4508 D2 1B 43      [10]  568 	jp	NC,00164$
                            569 ;src/Map.c:116: currentPos.x=(*(lastStackItem+cellStack)).x;
   450B 21 04 00      [10]  570 	ld	hl,#0x0004
   450E 39            [11]  571 	add	hl,sp
   450F 4D            [ 4]  572 	ld	c,l
   4510 44            [ 4]  573 	ld	b,h
   4511 E1            [10]  574 	pop	hl
   4512 E5            [11]  575 	push	hl
   4513 29            [11]  576 	add	hl, hl
   4514 FD 21 40 1C   [14]  577 	ld	iy,#0x1C40
   4518 EB            [ 4]  578 	ex	de,hl
   4519 FD 19         [15]  579 	add	iy, de
   451B FD 7E 00      [19]  580 	ld	a, 0 (iy)
   451E 02            [ 7]  581 	ld	(bc),a
                            582 ;src/Map.c:117: currentPos.y=(*(lastStackItem+cellStack)).y;
   451F FD 4E 01      [19]  583 	ld	c,1 (iy)
   4522 DD 6E F8      [19]  584 	ld	l,-8 (ix)
   4525 DD 66 F9      [19]  585 	ld	h,-7 (ix)
   4528 71            [ 7]  586 	ld	(hl),c
                            587 ;src/Map.c:118: --lastStackItem;
   4529 E1            [10]  588 	pop	hl
   452A E5            [11]  589 	push	hl
   452B 2B            [ 6]  590 	dec	hl
   452C E3            [19]  591 	ex	(sp), hl
                            592 ;src/Map.c:119: cellType = map[currentPos.x][currentPos.y];
   452D DD 6E FD      [19]  593 	ld	l,-3 (ix)
   4530 DD 66 FE      [19]  594 	ld	h,-2 (ix)
   4533 6E            [ 7]  595 	ld	l,(hl)
   4534 26 00         [ 7]  596 	ld	h,#0x00
   4536 29            [11]  597 	add	hl, hl
   4537 29            [11]  598 	add	hl, hl
   4538 29            [11]  599 	add	hl, hl
   4539 29            [11]  600 	add	hl, hl
   453A 29            [11]  601 	add	hl, hl
   453B 11 40 00      [10]  602 	ld	de,#0x0040
   453E 19            [11]  603 	add	hl,de
   453F 59            [ 4]  604 	ld	e,c
   4540 16 00         [ 7]  605 	ld	d,#0x00
   4542 19            [11]  606 	add	hl,de
   4543 4E            [ 7]  607 	ld	c,(hl)
                            608 ;src/Map.c:121: if(cellType == CELLTYPE_UNDEFINED){
   4544 79            [ 4]  609 	ld	a,c
   4545 3C            [ 4]  610 	inc	a
   4546 20 4A         [12]  611 	jr	NZ,00141$
                            612 ;src/Map.c:123: if(cpct_getRandom_lcg_u8()&1){//WALL
   4548 CD 10 5E      [17]  613 	call	_cpct_getRandom_lcg_u8
   454B CB 45         [ 8]  614 	bit	0, l
   454D 28 09         [12]  615 	jr	Z,00138$
                            616 ;src/Map.c:124: cellType = cpct_getRandom_lcg_u8()&3;
   454F CD 10 5E      [17]  617 	call	_cpct_getRandom_lcg_u8
   4552 7D            [ 4]  618 	ld	a,l
   4553 E6 03         [ 7]  619 	and	a, #0x03
   4555 4F            [ 4]  620 	ld	c,a
   4556 18 02         [12]  621 	jr	00139$
   4558                     622 00138$:
                            623 ;src/Map.c:127: cellType = CELLTYPE_FLOOR;
   4558 0E FE         [ 7]  624 	ld	c,#0xFE
   455A                     625 00139$:
                            626 ;src/Map.c:130: map[currentPos.x][currentPos.y]=cellType;
   455A DD 6E FD      [19]  627 	ld	l,-3 (ix)
   455D DD 66 FE      [19]  628 	ld	h,-2 (ix)
   4560 6E            [ 7]  629 	ld	l,(hl)
   4561 26 00         [ 7]  630 	ld	h,#0x00
   4563 29            [11]  631 	add	hl, hl
   4564 29            [11]  632 	add	hl, hl
   4565 29            [11]  633 	add	hl, hl
   4566 29            [11]  634 	add	hl, hl
   4567 29            [11]  635 	add	hl, hl
   4568 EB            [ 4]  636 	ex	de,hl
   4569 21 40 00      [10]  637 	ld	hl,#0x0040
   456C 19            [11]  638 	add	hl,de
   456D EB            [ 4]  639 	ex	de,hl
   456E DD 6E F8      [19]  640 	ld	l,-8 (ix)
   4571 DD 66 F9      [19]  641 	ld	h,-7 (ix)
   4574 6E            [ 7]  642 	ld	l, (hl)
   4575 26 00         [ 7]  643 	ld	h,#0x00
   4577 19            [11]  644 	add	hl,de
   4578 71            [ 7]  645 	ld	(hl),c
                            646 ;src/Map.c:131: --remainingCells;
   4579 DD 6E F6      [19]  647 	ld	l,-10 (ix)
   457C DD 66 F7      [19]  648 	ld	h,-9 (ix)
   457F 2B            [ 6]  649 	dec	hl
   4580 DD 75 F6      [19]  650 	ld	-10 (ix),l
   4583 DD 74 F7      [19]  651 	ld	-9 (ix),h
   4586 DD 7E F6      [19]  652 	ld	a,-10 (ix)
   4589 DD 77 F2      [19]  653 	ld	-14 (ix),a
   458C DD 7E F7      [19]  654 	ld	a,-9 (ix)
   458F DD 77 F3      [19]  655 	ld	-13 (ix),a
   4592                     656 00141$:
                            657 ;src/Map.c:58: if(currentPos.x>0){
   4592 DD 6E FD      [19]  658 	ld	l,-3 (ix)
   4595 DD 66 FE      [19]  659 	ld	h,-2 (ix)
   4598 7E            [ 7]  660 	ld	a,(hl)
   4599 DD 77 FF      [19]  661 	ld	-1 (ix),a
                            662 ;src/Map.c:134: if((cellType == CELLTYPE_FLOOR)){
   459C 79            [ 4]  663 	ld	a,c
   459D D6 FE         [ 7]  664 	sub	a, #0xFE
   459F C2 B8 46      [10]  665 	jp	NZ,00159$
                            666 ;src/Map.c:135: if(currentPos.x>0){
   45A2 DD 7E FF      [19]  667 	ld	a,-1 (ix)
   45A5 B7            [ 4]  668 	or	a, a
   45A6 28 3E         [12]  669 	jr	Z,00145$
                            670 ;src/Map.c:136: adjacentType = map[currentPos.x-1][currentPos.y];
   45A8 DD 6E FF      [19]  671 	ld	l,-1 (ix)
   45AB 26 00         [ 7]  672 	ld	h,#0x00
   45AD 2B            [ 6]  673 	dec	hl
   45AE 29            [11]  674 	add	hl, hl
   45AF 29            [11]  675 	add	hl, hl
   45B0 29            [11]  676 	add	hl, hl
   45B1 29            [11]  677 	add	hl, hl
   45B2 29            [11]  678 	add	hl, hl
   45B3 01 40 00      [10]  679 	ld	bc,#0x0040
   45B6 09            [11]  680 	add	hl,bc
   45B7 4D            [ 4]  681 	ld	c,l
   45B8 44            [ 4]  682 	ld	b,h
   45B9 DD 6E F8      [19]  683 	ld	l,-8 (ix)
   45BC DD 66 F9      [19]  684 	ld	h,-7 (ix)
   45BF 6E            [ 7]  685 	ld	l, (hl)
   45C0 26 00         [ 7]  686 	ld	h,#0x00
   45C2 09            [11]  687 	add	hl,bc
   45C3 4E            [ 7]  688 	ld	c,(hl)
                            689 ;src/Map.c:137: if(adjacentType == CELLTYPE_UNDEFINED){
   45C4 0C            [ 4]  690 	inc	c
   45C5 20 1F         [12]  691 	jr	NZ,00145$
                            692 ;src/Map.c:139: ++lastStackItem;
   45C7 DD 34 EB      [23]  693 	inc	-21 (ix)
   45CA 20 03         [12]  694 	jr	NZ,00342$
   45CC DD 34 EC      [23]  695 	inc	-20 (ix)
   45CF                     696 00342$:
                            697 ;src/Map.c:140: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   45CF E1            [10]  698 	pop	hl
   45D0 E5            [11]  699 	push	hl
   45D1 29            [11]  700 	add	hl, hl
   45D2 01 40 1C      [10]  701 	ld	bc,#0x1C40
   45D5 09            [11]  702 	add	hl,bc
   45D6 DD 4E FF      [19]  703 	ld	c,-1 (ix)
   45D9 0D            [ 4]  704 	dec	c
   45DA 71            [ 7]  705 	ld	(hl),c
                            706 ;src/Map.c:141: (*(cellStack+lastStackItem)).y = currentPos.y;
   45DB 23            [ 6]  707 	inc	hl
   45DC 4D            [ 4]  708 	ld	c,l
   45DD 44            [ 4]  709 	ld	b,h
   45DE DD 6E F8      [19]  710 	ld	l,-8 (ix)
   45E1 DD 66 F9      [19]  711 	ld	h,-7 (ix)
   45E4 7E            [ 7]  712 	ld	a,(hl)
   45E5 02            [ 7]  713 	ld	(bc),a
   45E6                     714 00145$:
                            715 ;src/Map.c:145: if(currentPos.x < (MAP_WIDTH-1)){
   45E6 DD 6E FD      [19]  716 	ld	l,-3 (ix)
   45E9 DD 66 FE      [19]  717 	ld	h,-2 (ix)
   45EC 4E            [ 7]  718 	ld	c,(hl)
   45ED 79            [ 4]  719 	ld	a,c
   45EE D6 1F         [ 7]  720 	sub	a, #0x1F
   45F0 30 39         [12]  721 	jr	NC,00149$
                            722 ;src/Map.c:147: adjacentType = map[currentPos.x+1][currentPos.y];
   45F2 69            [ 4]  723 	ld	l,c
   45F3 26 00         [ 7]  724 	ld	h,#0x00
   45F5 23            [ 6]  725 	inc	hl
   45F6 29            [11]  726 	add	hl, hl
   45F7 29            [11]  727 	add	hl, hl
   45F8 29            [11]  728 	add	hl, hl
   45F9 29            [11]  729 	add	hl, hl
   45FA 29            [11]  730 	add	hl, hl
   45FB EB            [ 4]  731 	ex	de,hl
   45FC 21 40 00      [10]  732 	ld	hl,#0x0040
   45FF 19            [11]  733 	add	hl,de
   4600 EB            [ 4]  734 	ex	de,hl
   4601 DD 6E F8      [19]  735 	ld	l,-8 (ix)
   4604 DD 66 F9      [19]  736 	ld	h,-7 (ix)
   4607 6E            [ 7]  737 	ld	l, (hl)
   4608 26 00         [ 7]  738 	ld	h,#0x00
   460A 19            [11]  739 	add	hl,de
   460B 46            [ 7]  740 	ld	b,(hl)
                            741 ;src/Map.c:148: if(adjacentType == CELLTYPE_UNDEFINED){
   460C 04            [ 4]  742 	inc	b
   460D 20 1C         [12]  743 	jr	NZ,00149$
                            744 ;src/Map.c:151: ++lastStackItem;
   460F DD 34 EB      [23]  745 	inc	-21 (ix)
   4612 20 03         [12]  746 	jr	NZ,00345$
   4614 DD 34 EC      [23]  747 	inc	-20 (ix)
   4617                     748 00345$:
                            749 ;src/Map.c:152: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   4617 E1            [10]  750 	pop	hl
   4618 E5            [11]  751 	push	hl
   4619 29            [11]  752 	add	hl, hl
   461A 11 40 1C      [10]  753 	ld	de,#0x1C40
   461D 19            [11]  754 	add	hl,de
   461E 0C            [ 4]  755 	inc	c
   461F 71            [ 7]  756 	ld	(hl),c
                            757 ;src/Map.c:153: (*(cellStack+lastStackItem)).y = currentPos.y;
   4620 23            [ 6]  758 	inc	hl
   4621 4D            [ 4]  759 	ld	c,l
   4622 44            [ 4]  760 	ld	b,h
   4623 DD 6E F8      [19]  761 	ld	l,-8 (ix)
   4626 DD 66 F9      [19]  762 	ld	h,-7 (ix)
   4629 7E            [ 7]  763 	ld	a,(hl)
   462A 02            [ 7]  764 	ld	(bc),a
   462B                     765 00149$:
                            766 ;src/Map.c:59: adjacentType = map[currentPos.x-1][currentPos.y];
   462B DD 6E F8      [19]  767 	ld	l,-8 (ix)
   462E DD 66 F9      [19]  768 	ld	h,-7 (ix)
   4631 4E            [ 7]  769 	ld	c,(hl)
                            770 ;src/Map.c:157: if(currentPos.y > 0){
   4632 79            [ 4]  771 	ld	a,c
   4633 B7            [ 4]  772 	or	a, a
   4634 28 39         [12]  773 	jr	Z,00153$
                            774 ;src/Map.c:159: adjacentType = map[currentPos.x][currentPos.y-1];
   4636 DD 6E FD      [19]  775 	ld	l,-3 (ix)
   4639 DD 66 FE      [19]  776 	ld	h,-2 (ix)
   463C 46            [ 7]  777 	ld	b,(hl)
   463D 68            [ 4]  778 	ld	l,b
   463E 26 00         [ 7]  779 	ld	h,#0x00
   4640 29            [11]  780 	add	hl, hl
   4641 29            [11]  781 	add	hl, hl
   4642 29            [11]  782 	add	hl, hl
   4643 29            [11]  783 	add	hl, hl
   4644 29            [11]  784 	add	hl, hl
   4645 11 40 00      [10]  785 	ld	de,#0x0040
   4648 19            [11]  786 	add	hl,de
   4649 0D            [ 4]  787 	dec	c
   464A 59            [ 4]  788 	ld	e,c
   464B 16 00         [ 7]  789 	ld	d,#0x00
   464D 19            [11]  790 	add	hl,de
   464E 4E            [ 7]  791 	ld	c,(hl)
                            792 ;src/Map.c:160: if(adjacentType == CELLTYPE_UNDEFINED){
   464F 0C            [ 4]  793 	inc	c
   4650 20 1D         [12]  794 	jr	NZ,00153$
                            795 ;src/Map.c:163: ++lastStackItem;
   4652 DD 34 EB      [23]  796 	inc	-21 (ix)
   4655 20 03         [12]  797 	jr	NZ,00348$
   4657 DD 34 EC      [23]  798 	inc	-20 (ix)
   465A                     799 00348$:
                            800 ;src/Map.c:164: (*(cellStack+lastStackItem)).x = currentPos.x;
   465A E1            [10]  801 	pop	hl
   465B E5            [11]  802 	push	hl
   465C 29            [11]  803 	add	hl, hl
   465D 11 40 1C      [10]  804 	ld	de,#0x1C40
   4660 19            [11]  805 	add	hl,de
   4661 70            [ 7]  806 	ld	(hl),b
                            807 ;src/Map.c:165: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   4662 23            [ 6]  808 	inc	hl
   4663 4D            [ 4]  809 	ld	c,l
   4664 44            [ 4]  810 	ld	b,h
   4665 DD 6E F8      [19]  811 	ld	l,-8 (ix)
   4668 DD 66 F9      [19]  812 	ld	h,-7 (ix)
   466B 5E            [ 7]  813 	ld	e,(hl)
   466C 1D            [ 4]  814 	dec	e
   466D 7B            [ 4]  815 	ld	a,e
   466E 02            [ 7]  816 	ld	(bc),a
   466F                     817 00153$:
                            818 ;src/Map.c:59: adjacentType = map[currentPos.x-1][currentPos.y];
   466F DD 6E F8      [19]  819 	ld	l,-8 (ix)
   4672 DD 66 F9      [19]  820 	ld	h,-7 (ix)
   4675 46            [ 7]  821 	ld	b,(hl)
                            822 ;src/Map.c:169: if(currentPos.y < (MAP_HEIGHT-1)){
   4676 78            [ 4]  823 	ld	a,b
   4677 D6 1F         [ 7]  824 	sub	a, #0x1F
   4679 D2 03 45      [10]  825 	jp	NC,00161$
                            826 ;src/Map.c:171: adjacentType = map[currentPos.x][currentPos.y+1];
   467C DD 6E FD      [19]  827 	ld	l,-3 (ix)
   467F DD 66 FE      [19]  828 	ld	h,-2 (ix)
   4682 4E            [ 7]  829 	ld	c,(hl)
   4683 69            [ 4]  830 	ld	l,c
   4684 26 00         [ 7]  831 	ld	h,#0x00
   4686 29            [11]  832 	add	hl, hl
   4687 29            [11]  833 	add	hl, hl
   4688 29            [11]  834 	add	hl, hl
   4689 29            [11]  835 	add	hl, hl
   468A 29            [11]  836 	add	hl, hl
   468B 11 40 00      [10]  837 	ld	de,#0x0040
   468E 19            [11]  838 	add	hl,de
   468F 04            [ 4]  839 	inc	b
   4690 58            [ 4]  840 	ld	e,b
   4691 16 00         [ 7]  841 	ld	d,#0x00
   4693 19            [11]  842 	add	hl,de
   4694 46            [ 7]  843 	ld	b,(hl)
                            844 ;src/Map.c:172: if(adjacentType == CELLTYPE_UNDEFINED){
   4695 04            [ 4]  845 	inc	b
   4696 C2 03 45      [10]  846 	jp	NZ,00161$
                            847 ;src/Map.c:175: ++lastStackItem;
   4699 DD 34 EB      [23]  848 	inc	-21 (ix)
   469C 20 03         [12]  849 	jr	NZ,00351$
   469E DD 34 EC      [23]  850 	inc	-20 (ix)
   46A1                     851 00351$:
                            852 ;src/Map.c:176: (*(cellStack+lastStackItem)).x = currentPos.x;
   46A1 E1            [10]  853 	pop	hl
   46A2 E5            [11]  854 	push	hl
   46A3 29            [11]  855 	add	hl, hl
   46A4 11 40 1C      [10]  856 	ld	de,#0x1C40
   46A7 19            [11]  857 	add	hl,de
   46A8 71            [ 7]  858 	ld	(hl),c
                            859 ;src/Map.c:177: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   46A9 23            [ 6]  860 	inc	hl
   46AA 4D            [ 4]  861 	ld	c,l
   46AB 44            [ 4]  862 	ld	b,h
   46AC DD 6E F8      [19]  863 	ld	l,-8 (ix)
   46AF DD 66 F9      [19]  864 	ld	h,-7 (ix)
   46B2 7E            [ 7]  865 	ld	a,(hl)
   46B3 3C            [ 4]  866 	inc	a
   46B4 02            [ 7]  867 	ld	(bc),a
   46B5 C3 03 45      [10]  868 	jp	00161$
   46B8                     869 00159$:
                            870 ;src/Map.c:183: ++wallListCount;
   46B8 DD 34 FA      [23]  871 	inc	-6 (ix)
   46BB 20 03         [12]  872 	jr	NZ,00352$
   46BD DD 34 FB      [23]  873 	inc	-5 (ix)
   46C0                     874 00352$:
   46C0 DD 7E FA      [19]  875 	ld	a,-6 (ix)
   46C3 DD 77 ED      [19]  876 	ld	-19 (ix),a
   46C6 DD 7E FB      [19]  877 	ld	a,-5 (ix)
   46C9 DD 77 EE      [19]  878 	ld	-18 (ix),a
                            879 ;src/Map.c:184: (*(wallList+wallListCount)).x = currentPos.x;
   46CC DD 6E FA      [19]  880 	ld	l,-6 (ix)
   46CF DD 66 FB      [19]  881 	ld	h,-5 (ix)
   46D2 29            [11]  882 	add	hl, hl
   46D3 01 40 20      [10]  883 	ld	bc,#0x2040
   46D6 09            [11]  884 	add	hl,bc
   46D7 DD 7E FF      [19]  885 	ld	a,-1 (ix)
   46DA 77            [ 7]  886 	ld	(hl),a
                            887 ;src/Map.c:185: (*(wallList+wallListCount)).y = currentPos.y;
   46DB 23            [ 6]  888 	inc	hl
   46DC 4D            [ 4]  889 	ld	c,l
   46DD 44            [ 4]  890 	ld	b,h
   46DE DD 6E F8      [19]  891 	ld	l,-8 (ix)
   46E1 DD 66 F9      [19]  892 	ld	h,-7 (ix)
   46E4 7E            [ 7]  893 	ld	a,(hl)
   46E5 02            [ 7]  894 	ld	(bc),a
   46E6 C3 03 45      [10]  895 	jp	00161$
   46E9                     896 00171$:
   46E9 DD F9         [10]  897 	ld	sp, ix
   46EB DD E1         [14]  898 	pop	ix
   46ED C9            [10]  899 	ret
                            900 	.area _CODE
                            901 	.area _INITIALIZER
                            902 	.area _CABS (ABS)
