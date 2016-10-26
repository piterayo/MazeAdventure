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
                             13 	.globl _generate_final_map
                             14 	.globl _get_random_wall
                             15 	.globl _level_get_level
                             16 	.globl _player_get_direction_index
                             17 	.globl _player_turn_left
                             18 	.globl _cpct_restoreState_mxor_u8
                             19 	.globl _cpct_setSeed_mxor
                             20 	.globl _cpct_getRandom_mxor_u8
                             21 	.globl _cpct_memset
                             22 	.globl _rand_seed
                             23 	.globl _map_get_seed
                             24 	.globl _generate_level
                             25 	.globl _generate_level_with_seed
                             26 ;--------------------------------------------------------
                             27 ; special function registers
                             28 ;--------------------------------------------------------
                             29 ;--------------------------------------------------------
                             30 ; ram data
                             31 ;--------------------------------------------------------
                             32 	.area _DATA
   8703                      33 _rand_seed::
   8703                      34 	.ds 2
                             35 ;--------------------------------------------------------
                             36 ; ram data
                             37 ;--------------------------------------------------------
                             38 	.area _INITIALIZED
                             39 ;--------------------------------------------------------
                             40 ; absolute external ram data
                             41 ;--------------------------------------------------------
                             42 	.area _DABS (ABS)
                             43 ;--------------------------------------------------------
                             44 ; global & static initialisations
                             45 ;--------------------------------------------------------
                             46 	.area _HOME
                             47 	.area _GSINIT
                             48 	.area _GSFINAL
                             49 	.area _GSINIT
                             50 ;--------------------------------------------------------
                             51 ; Home
                             52 ;--------------------------------------------------------
                             53 	.area _HOME
                             54 	.area _HOME
                             55 ;--------------------------------------------------------
                             56 ; code
                             57 ;--------------------------------------------------------
                             58 	.area _CODE
                             59 ;src/Map.c:14: u16 map_get_seed(){
                             60 ;	---------------------------------
                             61 ; Function map_get_seed
                             62 ; ---------------------------------
   1257                      63 _map_get_seed::
                             64 ;src/Map.c:15: return rand_seed;
   1257 2A 03 87      [16]   65 	ld	hl,(_rand_seed)
   125A C9            [10]   66 	ret
                             67 ;src/Map.c:18: u8 get_random_wall(){
                             68 ;	---------------------------------
                             69 ; Function get_random_wall
                             70 ; ---------------------------------
   125B                      71 _get_random_wall::
                             72 ;src/Map.c:19: u8 cellType = cpct_getRandom_mxor_u8 ();
   125B CD 0E 84      [17]   73 	call	_cpct_getRandom_mxor_u8
                             74 ;src/Map.c:20: if(cellType&1){ //1,3,5,7
   125E CB 45         [ 8]   75 	bit	0, l
   1260 28 03         [12]   76 	jr	Z,00108$
                             77 ;src/Map.c:21: return CELLTYPE_WALL1;
   1262 2E 81         [ 7]   78 	ld	l,#0x81
   1264 C9            [10]   79 	ret
   1265                      80 00108$:
                             81 ;src/Map.c:24: if(cellType&3){//2,6
   1265 7D            [ 4]   82 	ld	a,l
   1266 E6 03         [ 7]   83 	and	a, #0x03
   1268 28 03         [12]   84 	jr	Z,00105$
                             85 ;src/Map.c:25: return CELLTYPE_WALL2;
   126A 2E 82         [ 7]   86 	ld	l,#0x82
   126C C9            [10]   87 	ret
   126D                      88 00105$:
                             89 ;src/Map.c:28: if(cellType&7){//4
   126D 7D            [ 4]   90 	ld	a,l
   126E E6 07         [ 7]   91 	and	a, #0x07
   1270 28 03         [12]   92 	jr	Z,00102$
                             93 ;src/Map.c:29: return CELLTYPE_WALL3;
   1272 2E 83         [ 7]   94 	ld	l,#0x83
   1274 C9            [10]   95 	ret
   1275                      96 00102$:
                             97 ;src/Map.c:32: return CELLTYPE_WALL4;  
   1275 2E 84         [ 7]   98 	ld	l,#0x84
   1277 C9            [10]   99 	ret
                            100 ;src/Map.c:38: void generate_final_map(){
                            101 ;	---------------------------------
                            102 ; Function generate_final_map
                            103 ; ---------------------------------
   1278                     104 _generate_final_map::
                            105 ;src/Map.c:43: while(m>=MAP_MEM){
   1278 21 D0 8C      [10]  106 	ld	hl,#0x8CD0
   127B                     107 00101$:
   127B 7D            [ 4]  108 	ld	a,l
   127C D6 D0         [ 7]  109 	sub	a, #0xD0
   127E 7C            [ 4]  110 	ld	a,h
   127F DE 88         [ 7]  111 	sbc	a, #0x88
   1281 38 05         [12]  112 	jr	C,00103$
                            113 ;src/Map.c:44: *m=CELLTYPE_WALL1;
   1283 36 81         [10]  114 	ld	(hl),#0x81
                            115 ;src/Map.c:45: --m;
   1285 2B            [ 6]  116 	dec	hl
   1286 18 F3         [12]  117 	jr	00101$
   1288                     118 00103$:
                            119 ;src/Map.c:48: for(i=1;i<KING_LEVEL_WIDTH-1;++i){
   1288 0E 01         [ 7]  120 	ld	c,#0x01
                            121 ;src/Map.c:49: for(j=1;j<KING_LEVEL_HEIGHT-1;++j){
   128A                     122 00124$:
   128A 06 01         [ 7]  123 	ld	b,#0x01
   128C                     124 00110$:
                            125 ;src/Map.c:50: map[j][i]=CELLTYPE_FLOOR;//get_random_wall();
   128C 68            [ 4]  126 	ld	l,b
   128D 26 00         [ 7]  127 	ld	h,#0x00
   128F 29            [11]  128 	add	hl, hl
   1290 29            [11]  129 	add	hl, hl
   1291 29            [11]  130 	add	hl, hl
   1292 29            [11]  131 	add	hl, hl
   1293 29            [11]  132 	add	hl, hl
   1294 11 D0 88      [10]  133 	ld	de,#0x88D0
   1297 19            [11]  134 	add	hl,de
   1298 59            [ 4]  135 	ld	e,c
   1299 16 00         [ 7]  136 	ld	d,#0x00
   129B 19            [11]  137 	add	hl,de
   129C 36 00         [10]  138 	ld	(hl),#0x00
                            139 ;src/Map.c:49: for(j=1;j<KING_LEVEL_HEIGHT-1;++j){
   129E 04            [ 4]  140 	inc	b
   129F 78            [ 4]  141 	ld	a,b
   12A0 D6 08         [ 7]  142 	sub	a, #0x08
   12A2 38 E8         [12]  143 	jr	C,00110$
                            144 ;src/Map.c:48: for(i=1;i<KING_LEVEL_WIDTH-1;++i){
   12A4 0C            [ 4]  145 	inc	c
   12A5 79            [ 4]  146 	ld	a,c
   12A6 D6 08         [ 7]  147 	sub	a, #0x08
   12A8 38 E0         [12]  148 	jr	C,00124$
                            149 ;src/Map.c:54: for(i=2;i<7;i+=2){
   12AA 0E 02         [ 7]  150 	ld	c,#0x02
   12AC                     151 00114$:
                            152 ;src/Map.c:55: map[i][2]=(cpct_getRandom_mxor_u8 ()%2)?CELLTYPE_WALL2:CELLTYPE_WALL3;//get_random_wall();
   12AC 69            [ 4]  153 	ld	l,c
   12AD 26 00         [ 7]  154 	ld	h,#0x00
   12AF 29            [11]  155 	add	hl, hl
   12B0 29            [11]  156 	add	hl, hl
   12B1 29            [11]  157 	add	hl, hl
   12B2 29            [11]  158 	add	hl, hl
   12B3 29            [11]  159 	add	hl, hl
   12B4 11 D0 88      [10]  160 	ld	de, #0x88D0
   12B7 19            [11]  161 	add	hl, de
   12B8 5D            [ 4]  162 	ld	e,l
   12B9 54            [ 4]  163 	ld	d,h
   12BA 23            [ 6]  164 	inc	hl
   12BB 23            [ 6]  165 	inc	hl
   12BC E5            [11]  166 	push	hl
   12BD C5            [11]  167 	push	bc
   12BE D5            [11]  168 	push	de
   12BF CD 0E 84      [17]  169 	call	_cpct_getRandom_mxor_u8
   12C2 7D            [ 4]  170 	ld	a,l
   12C3 D1            [10]  171 	pop	de
   12C4 C1            [10]  172 	pop	bc
   12C5 E1            [10]  173 	pop	hl
   12C6 0F            [ 4]  174 	rrca
   12C7 30 04         [12]  175 	jr	NC,00118$
   12C9 06 82         [ 7]  176 	ld	b,#0x82
   12CB 18 02         [12]  177 	jr	00119$
   12CD                     178 00118$:
   12CD 06 83         [ 7]  179 	ld	b,#0x83
   12CF                     180 00119$:
   12CF 70            [ 7]  181 	ld	(hl),b
                            182 ;src/Map.c:56: map[i][6]=(cpct_getRandom_mxor_u8 ()%2)?CELLTYPE_WALL2:CELLTYPE_WALL3;//get_random_wall();
   12D0 21 06 00      [10]  183 	ld	hl,#0x0006
   12D3 19            [11]  184 	add	hl,de
   12D4 E5            [11]  185 	push	hl
   12D5 C5            [11]  186 	push	bc
   12D6 CD 0E 84      [17]  187 	call	_cpct_getRandom_mxor_u8
   12D9 7D            [ 4]  188 	ld	a,l
   12DA C1            [10]  189 	pop	bc
   12DB E1            [10]  190 	pop	hl
   12DC 0F            [ 4]  191 	rrca
   12DD 30 04         [12]  192 	jr	NC,00120$
   12DF 06 82         [ 7]  193 	ld	b,#0x82
   12E1 18 02         [12]  194 	jr	00121$
   12E3                     195 00120$:
   12E3 06 83         [ 7]  196 	ld	b,#0x83
   12E5                     197 00121$:
   12E5 70            [ 7]  198 	ld	(hl),b
                            199 ;src/Map.c:54: for(i=2;i<7;i+=2){
   12E6 0C            [ 4]  200 	inc	c
   12E7 0C            [ 4]  201 	inc	c
   12E8 79            [ 4]  202 	ld	a,c
   12E9 D6 07         [ 7]  203 	sub	a, #0x07
   12EB 38 BF         [12]  204 	jr	C,00114$
                            205 ;src/Map.c:59: map[KING_LEVEL_EXIT_Y][KING_LEVEL_EXIT_X] = CELLTYPE_DOOR;
   12ED 21 D4 88      [10]  206 	ld	hl,#0x88D4
   12F0 36 80         [10]  207 	ld	(hl),#0x80
                            208 ;src/Map.c:62: while(player_get_direction_index()!=MOVEMENT_NORTH){
   12F2                     209 00107$:
   12F2 CD 5F 1A      [17]  210 	call	_player_get_direction_index
   12F5 7D            [ 4]  211 	ld	a,l
   12F6 D6 02         [ 7]  212 	sub	a, #0x02
   12F8 28 05         [12]  213 	jr	Z,00109$
                            214 ;src/Map.c:63: player_turn_left();
   12FA CD F2 19      [17]  215 	call	_player_turn_left
   12FD 18 F3         [12]  216 	jr	00107$
   12FF                     217 00109$:
                            218 ;src/Map.c:66: *(i8*)&(player_position.x) = KING_LEVEL_PLAYER_X;
   12FF 21 EE 19      [10]  219 	ld	hl,#_player_position
   1302 36 04         [10]  220 	ld	(hl),#0x04
                            221 ;src/Map.c:67: *(i8*)&(player_position.y) = KING_LEVEL_PLAYER_Y;
   1304 21 EF 19      [10]  222 	ld	hl,#(_player_position + 0x0001)
   1307 36 07         [10]  223 	ld	(hl),#0x07
   1309 C9            [10]  224 	ret
                            225 ;src/Map.c:71: void generate_map(){
                            226 ;	---------------------------------
                            227 ; Function generate_map
                            228 ; ---------------------------------
   130A                     229 _generate_map::
   130A DD E5         [15]  230 	push	ix
   130C DD 21 00 00   [14]  231 	ld	ix,#0
   1310 DD 39         [15]  232 	add	ix,sp
   1312 21 EC FF      [10]  233 	ld	hl,#-20
   1315 39            [11]  234 	add	hl,sp
   1316 F9            [ 6]  235 	ld	sp,hl
                            236 ;src/Map.c:74: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
   1317 DD 36 F1 83   [19]  237 	ld	-15 (ix),#0x83
   131B DD 36 F2 03   [19]  238 	ld	-14 (ix),#0x03
                            239 ;src/Map.c:80: u16 wallListCount = 0;
   131F 21 00 00      [10]  240 	ld	hl,#0x0000
   1322 E3            [19]  241 	ex	(sp), hl
                            242 ;src/Map.c:81: u16 lastStackItem = 0;
   1323 DD 36 F3 00   [19]  243 	ld	-13 (ix),#0x00
   1327 DD 36 F4 00   [19]  244 	ld	-12 (ix),#0x00
                            245 ;src/Map.c:83: cpct_memset (GENERATOR_DATA_PTR, 0, 4096);
   132B 21 00 10      [10]  246 	ld	hl,#0x1000
   132E E5            [11]  247 	push	hl
   132F AF            [ 4]  248 	xor	a, a
   1330 F5            [11]  249 	push	af
   1331 33            [ 6]  250 	inc	sp
   1332 21 D0 8C      [10]  251 	ld	hl,#0x8CD0
   1335 E5            [11]  252 	push	hl
   1336 CD 11 85      [17]  253 	call	_cpct_memset
                            254 ;src/Map.c:85: (*cellStack).x = (cpct_getRandom_mxor_u8 ()%(MAP_WIDTH-2))+1; //RANDOM
   1339 CD 0E 84      [17]  255 	call	_cpct_getRandom_mxor_u8
   133C 45            [ 4]  256 	ld	b,l
   133D 3E 1E         [ 7]  257 	ld	a,#0x1E
   133F F5            [11]  258 	push	af
   1340 33            [ 6]  259 	inc	sp
   1341 C5            [11]  260 	push	bc
   1342 33            [ 6]  261 	inc	sp
   1343 CD B0 83      [17]  262 	call	__moduchar
   1346 F1            [10]  263 	pop	af
   1347 4D            [ 4]  264 	ld	c,l
   1348 0C            [ 4]  265 	inc	c
   1349 21 D0 8C      [10]  266 	ld	hl,#0x8CD0
   134C 71            [ 7]  267 	ld	(hl),c
                            268 ;src/Map.c:86: (*cellStack).y = (cpct_getRandom_mxor_u8 ()%(MAP_HEIGHT-2))+1; //RANDOM
   134D CD 0E 84      [17]  269 	call	_cpct_getRandom_mxor_u8
   1350 45            [ 4]  270 	ld	b,l
   1351 3E 1E         [ 7]  271 	ld	a,#0x1E
   1353 F5            [11]  272 	push	af
   1354 33            [ 6]  273 	inc	sp
   1355 C5            [11]  274 	push	bc
   1356 33            [ 6]  275 	inc	sp
   1357 CD B0 83      [17]  276 	call	__moduchar
   135A F1            [10]  277 	pop	af
   135B 4D            [ 4]  278 	ld	c,l
   135C 0C            [ 4]  279 	inc	c
   135D 21 D1 8C      [10]  280 	ld	hl,#0x8CD1
   1360 71            [ 7]  281 	ld	(hl),c
                            282 ;src/Map.c:88: rotatePlayer = cpct_getRandom_mxor_u8 ()%4;
   1361 CD 0E 84      [17]  283 	call	_cpct_getRandom_mxor_u8
   1364 7D            [ 4]  284 	ld	a,l
   1365 E6 03         [ 7]  285 	and	a, #0x03
   1367 4F            [ 4]  286 	ld	c,a
                            287 ;src/Map.c:89: while(rotatePlayer){
   1368                     288 00101$:
   1368 79            [ 4]  289 	ld	a,c
   1369 B7            [ 4]  290 	or	a, a
   136A 28 08         [12]  291 	jr	Z,00103$
                            292 ;src/Map.c:90: player_turn_left();
   136C C5            [11]  293 	push	bc
   136D CD F2 19      [17]  294 	call	_player_turn_left
   1370 C1            [10]  295 	pop	bc
                            296 ;src/Map.c:91: --rotatePlayer;
   1371 0D            [ 4]  297 	dec	c
   1372 18 F4         [12]  298 	jr	00101$
   1374                     299 00103$:
                            300 ;src/Map.c:94: *(i8*)&(player_position.x) = (*cellStack).y;
   1374 01 EE 19      [10]  301 	ld	bc,#_player_position+0
   1377 3A D1 8C      [13]  302 	ld	a,(#0x8CD1)
   137A 02            [ 7]  303 	ld	(bc),a
                            304 ;src/Map.c:95: *(i8*)&(player_position.y) = (*cellStack).x;
   137B 01 EF 19      [10]  305 	ld	bc,#_player_position+1
   137E 3A D0 8C      [13]  306 	ld	a,(#0x8CD0)
   1381 02            [ 7]  307 	ld	(bc),a
                            308 ;src/Map.c:97: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   1382 21 00 04      [10]  309 	ld	hl,#0x0400
   1385 E5            [11]  310 	push	hl
   1386 3E 87         [ 7]  311 	ld	a,#0x87
   1388 F5            [11]  312 	push	af
   1389 33            [ 6]  313 	inc	sp
   138A 21 D0 88      [10]  314 	ld	hl,#0x88D0
   138D E5            [11]  315 	push	hl
   138E CD 11 85      [17]  316 	call	_cpct_memset
                            317 ;src/Map.c:100: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   1391 21 D0 8C      [10]  318 	ld	hl,#0x8CD0
   1394 6E            [ 7]  319 	ld	l,(hl)
   1395 26 00         [ 7]  320 	ld	h,#0x00
   1397 29            [11]  321 	add	hl, hl
   1398 29            [11]  322 	add	hl, hl
   1399 29            [11]  323 	add	hl, hl
   139A 29            [11]  324 	add	hl, hl
   139B 29            [11]  325 	add	hl, hl
   139C 01 D0 88      [10]  326 	ld	bc,#0x88D0
   139F 09            [11]  327 	add	hl,bc
   13A0 4D            [ 4]  328 	ld	c,l
   13A1 44            [ 4]  329 	ld	b,h
   13A2 21 D1 8C      [10]  330 	ld	hl,#0x8CD1
   13A5 6E            [ 7]  331 	ld	l, (hl)
   13A6 26 00         [ 7]  332 	ld	h,#0x00
   13A8 09            [11]  333 	add	hl,bc
   13A9 36 00         [10]  334 	ld	(hl),#0x00
                            335 ;src/Map.c:103: for(i=0;i<MAP_WIDTH;++i){
   13AB 0E 00         [ 7]  336 	ld	c,#0x00
   13AD                     337 00170$:
                            338 ;src/Map.c:104: map[0][i]=CELLTYPE_WALL1;//get_random_wall();
   13AD 21 D0 88      [10]  339 	ld	hl,#0x88D0
   13B0 06 00         [ 7]  340 	ld	b,#0x00
   13B2 09            [11]  341 	add	hl, bc
   13B3 36 81         [10]  342 	ld	(hl),#0x81
                            343 ;src/Map.c:105: map[MAP_HEIGHT-1][i]=CELLTYPE_WALL1;//get_random_wall();
   13B5 21 B0 8C      [10]  344 	ld	hl,#0x8CB0
   13B8 06 00         [ 7]  345 	ld	b,#0x00
   13BA 09            [11]  346 	add	hl, bc
   13BB 36 81         [10]  347 	ld	(hl),#0x81
                            348 ;src/Map.c:103: for(i=0;i<MAP_WIDTH;++i){
   13BD 0C            [ 4]  349 	inc	c
   13BE 79            [ 4]  350 	ld	a,c
   13BF D6 20         [ 7]  351 	sub	a, #0x20
   13C1 38 EA         [12]  352 	jr	C,00170$
                            353 ;src/Map.c:108: for(i=0;i<MAP_HEIGHT-1;++i){
   13C3 0E 00         [ 7]  354 	ld	c,#0x00
   13C5                     355 00172$:
                            356 ;src/Map.c:109: map[i][0]=CELLTYPE_WALL1;//get_random_wall();
   13C5 69            [ 4]  357 	ld	l,c
   13C6 26 00         [ 7]  358 	ld	h,#0x00
   13C8 29            [11]  359 	add	hl, hl
   13C9 29            [11]  360 	add	hl, hl
   13CA 29            [11]  361 	add	hl, hl
   13CB 29            [11]  362 	add	hl, hl
   13CC 29            [11]  363 	add	hl, hl
   13CD EB            [ 4]  364 	ex	de,hl
   13CE 21 D0 88      [10]  365 	ld	hl,#0x88D0
   13D1 19            [11]  366 	add	hl,de
   13D2 36 81         [10]  367 	ld	(hl),#0x81
                            368 ;src/Map.c:110: map[i][MAP_WIDTH-1]=CELLTYPE_WALL1;//get_random_wall();
   13D4 21 D0 88      [10]  369 	ld	hl,#0x88D0
   13D7 19            [11]  370 	add	hl,de
   13D8 11 1F 00      [10]  371 	ld	de,#0x001F
   13DB 19            [11]  372 	add	hl,de
   13DC 36 81         [10]  373 	ld	(hl),#0x81
                            374 ;src/Map.c:108: for(i=0;i<MAP_HEIGHT-1;++i){
   13DE 0C            [ 4]  375 	inc	c
   13DF 79            [ 4]  376 	ld	a,c
   13E0 D6 1F         [ 7]  377 	sub	a, #0x1F
   13E2 38 E1         [12]  378 	jr	C,00172$
                            379 ;src/Map.c:113: while(remainingCells>0){
   13E4 21 02 00      [10]  380 	ld	hl,#0x0002
   13E7 39            [11]  381 	add	hl,sp
   13E8 DD 75 FA      [19]  382 	ld	-6 (ix),l
   13EB DD 74 FB      [19]  383 	ld	-5 (ix),h
   13EE                     384 00167$:
   13EE DD 7E F2      [19]  385 	ld	a,-14 (ix)
   13F1 DD B6 F1      [19]  386 	or	a,-15 (ix)
   13F4 CA D7 17      [10]  387 	jp	Z,00174$
                            388 ;src/Map.c:114: wallListPosition = wallList+wallListCount;
   13F7 E1            [10]  389 	pop	hl
   13F8 E5            [11]  390 	push	hl
   13F9 29            [11]  391 	add	hl, hl
   13FA 7D            [ 4]  392 	ld	a,l
   13FB C6 D0         [ 7]  393 	add	a, #0xD0
   13FD DD 77 FC      [19]  394 	ld	-4 (ix),a
   1400 7C            [ 4]  395 	ld	a,h
   1401 CE 90         [ 7]  396 	adc	a, #0x90
   1403 DD 77 FD      [19]  397 	ld	-3 (ix),a
                            398 ;src/Map.c:115: while(wallListCount<MAP_SIZE){
   1406 C1            [10]  399 	pop	bc
   1407 C5            [11]  400 	push	bc
   1408                     401 00137$:
                            402 ;src/Map.c:118: currentPos.y = (*wallListPosition).y;
   1408 DD 7E FA      [19]  403 	ld	a,-6 (ix)
   140B C6 01         [ 7]  404 	add	a, #0x01
   140D DD 77 FE      [19]  405 	ld	-2 (ix),a
   1410 DD 7E FB      [19]  406 	ld	a,-5 (ix)
   1413 CE 00         [ 7]  407 	adc	a, #0x00
   1415 DD 77 FF      [19]  408 	ld	-1 (ix),a
                            409 ;src/Map.c:115: while(wallListCount<MAP_SIZE){
   1418 78            [ 4]  410 	ld	a,b
   1419 D6 04         [ 7]  411 	sub	a, #0x04
   141B D2 BB 15      [10]  412 	jp	NC,00209$
                            413 ;src/Map.c:117: currentPos.x = (*wallListPosition).x;
   141E 21 02 00      [10]  414 	ld	hl,#0x0002
   1421 39            [11]  415 	add	hl,sp
   1422 EB            [ 4]  416 	ex	de,hl
   1423 DD 6E FC      [19]  417 	ld	l,-4 (ix)
   1426 DD 66 FD      [19]  418 	ld	h,-3 (ix)
   1429 7E            [ 7]  419 	ld	a,(hl)
   142A 12            [ 7]  420 	ld	(de),a
                            421 ;src/Map.c:118: currentPos.y = (*wallListPosition).y;
   142B DD 5E FC      [19]  422 	ld	e,-4 (ix)
   142E DD 56 FD      [19]  423 	ld	d,-3 (ix)
   1431 13            [ 6]  424 	inc	de
   1432 1A            [ 7]  425 	ld	a,(de)
   1433 DD 6E FE      [19]  426 	ld	l,-2 (ix)
   1436 DD 66 FF      [19]  427 	ld	h,-1 (ix)
   1439 77            [ 7]  428 	ld	(hl),a
                            429 ;src/Map.c:120: convertToFloor=0;
   143A DD 36 F5 00   [19]  430 	ld	-11 (ix),#0x00
                            431 ;src/Map.c:121: surroundedByWalls=1;
   143E DD 36 F0 01   [19]  432 	ld	-16 (ix),#0x01
                            433 ;src/Map.c:123: if(currentPos.x>0){
   1442 DD 6E FA      [19]  434 	ld	l,-6 (ix)
   1445 DD 66 FB      [19]  435 	ld	h,-5 (ix)
   1448 7E            [ 7]  436 	ld	a,(hl)
   1449 DD 77 F8      [19]  437 	ld	-8 (ix),a
                            438 ;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
   144C DD 6E FE      [19]  439 	ld	l,-2 (ix)
   144F DD 66 FF      [19]  440 	ld	h,-1 (ix)
   1452 7E            [ 7]  441 	ld	a,(hl)
   1453 DD 77 F9      [19]  442 	ld	-7 (ix),a
   1456 DD 7E F8      [19]  443 	ld	a,-8 (ix)
   1459 DD 77 F6      [19]  444 	ld	-10 (ix),a
   145C DD 36 F7 00   [19]  445 	ld	-9 (ix),#0x00
                            446 ;src/Map.c:123: if(currentPos.x>0){
   1460 DD 7E F8      [19]  447 	ld	a,-8 (ix)
   1463 B7            [ 4]  448 	or	a, a
   1464 28 2F         [12]  449 	jr	Z,00112$
                            450 ;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
   1466 DD 6E F6      [19]  451 	ld	l,-10 (ix)
   1469 DD 66 F7      [19]  452 	ld	h,-9 (ix)
   146C 2B            [ 6]  453 	dec	hl
   146D 29            [11]  454 	add	hl, hl
   146E 29            [11]  455 	add	hl, hl
   146F 29            [11]  456 	add	hl, hl
   1470 29            [11]  457 	add	hl, hl
   1471 29            [11]  458 	add	hl, hl
   1472 D5            [11]  459 	push	de
   1473 11 D0 88      [10]  460 	ld	de,#0x88D0
   1476 19            [11]  461 	add	hl, de
   1477 D1            [10]  462 	pop	de
   1478 7D            [ 4]  463 	ld	a,l
   1479 DD 86 F9      [19]  464 	add	a, -7 (ix)
   147C 6F            [ 4]  465 	ld	l,a
   147D 7C            [ 4]  466 	ld	a,h
   147E CE 00         [ 7]  467 	adc	a, #0x00
   1480 67            [ 4]  468 	ld	h,a
   1481 6E            [ 7]  469 	ld	l,(hl)
                            470 ;src/Map.c:125: if(adjacentType == CELLTYPE_UNDEFINED){
   1482 7D            [ 4]  471 	ld	a,l
   1483 D6 87         [ 7]  472 	sub	a, #0x87
   1485 20 06         [12]  473 	jr	NZ,00109$
                            474 ;src/Map.c:126: convertToFloor  = 1;
   1487 DD 36 F5 01   [19]  475 	ld	-11 (ix),#0x01
   148B 18 08         [12]  476 	jr	00112$
   148D                     477 00109$:
                            478 ;src/Map.c:128: else if(adjacentType == CELLTYPE_FLOOR){
   148D 7D            [ 4]  479 	ld	a,l
   148E B7            [ 4]  480 	or	a, a
   148F 20 04         [12]  481 	jr	NZ,00112$
                            482 ;src/Map.c:129: surroundedByWalls = 0;
   1491 DD 36 F0 00   [19]  483 	ld	-16 (ix),#0x00
   1495                     484 00112$:
                            485 ;src/Map.c:132: if(currentPos.x < (MAP_WIDTH-1)){
   1495 DD 7E F8      [19]  486 	ld	a,-8 (ix)
   1498 D6 1F         [ 7]  487 	sub	a, #0x1F
   149A 30 2F         [12]  488 	jr	NC,00119$
                            489 ;src/Map.c:134: adjacentType = map[currentPos.x+1][currentPos.y];
   149C DD 6E F6      [19]  490 	ld	l,-10 (ix)
   149F DD 66 F7      [19]  491 	ld	h,-9 (ix)
   14A2 23            [ 6]  492 	inc	hl
   14A3 29            [11]  493 	add	hl, hl
   14A4 29            [11]  494 	add	hl, hl
   14A5 29            [11]  495 	add	hl, hl
   14A6 29            [11]  496 	add	hl, hl
   14A7 29            [11]  497 	add	hl, hl
   14A8 D5            [11]  498 	push	de
   14A9 11 D0 88      [10]  499 	ld	de,#0x88D0
   14AC 19            [11]  500 	add	hl, de
   14AD D1            [10]  501 	pop	de
   14AE 7D            [ 4]  502 	ld	a,l
   14AF DD 86 F9      [19]  503 	add	a, -7 (ix)
   14B2 6F            [ 4]  504 	ld	l,a
   14B3 7C            [ 4]  505 	ld	a,h
   14B4 CE 00         [ 7]  506 	adc	a, #0x00
   14B6 67            [ 4]  507 	ld	h,a
   14B7 6E            [ 7]  508 	ld	l,(hl)
                            509 ;src/Map.c:135: if(adjacentType == CELLTYPE_UNDEFINED){
   14B8 7D            [ 4]  510 	ld	a,l
   14B9 D6 87         [ 7]  511 	sub	a, #0x87
   14BB 20 06         [12]  512 	jr	NZ,00116$
                            513 ;src/Map.c:136: convertToFloor  = 1;
   14BD DD 36 F5 01   [19]  514 	ld	-11 (ix),#0x01
   14C1 18 08         [12]  515 	jr	00119$
   14C3                     516 00116$:
                            517 ;src/Map.c:138: else if(adjacentType == CELLTYPE_FLOOR){
   14C3 7D            [ 4]  518 	ld	a,l
   14C4 B7            [ 4]  519 	or	a, a
   14C5 20 04         [12]  520 	jr	NZ,00119$
                            521 ;src/Map.c:139: surroundedByWalls = 0;
   14C7 DD 36 F0 00   [19]  522 	ld	-16 (ix),#0x00
   14CB                     523 00119$:
                            524 ;src/Map.c:144: adjacentType = map[currentPos.x][currentPos.y-1];
   14CB DD 6E F6      [19]  525 	ld	l,-10 (ix)
   14CE DD 66 F7      [19]  526 	ld	h,-9 (ix)
   14D1 29            [11]  527 	add	hl, hl
   14D2 29            [11]  528 	add	hl, hl
   14D3 29            [11]  529 	add	hl, hl
   14D4 29            [11]  530 	add	hl, hl
   14D5 29            [11]  531 	add	hl, hl
   14D6 7D            [ 4]  532 	ld	a,l
   14D7 C6 D0         [ 7]  533 	add	a, #0xD0
   14D9 DD 77 F6      [19]  534 	ld	-10 (ix),a
   14DC 7C            [ 4]  535 	ld	a,h
   14DD CE 88         [ 7]  536 	adc	a, #0x88
   14DF DD 77 F7      [19]  537 	ld	-9 (ix),a
                            538 ;src/Map.c:142: if(currentPos.y > 0){
   14E2 DD 7E F9      [19]  539 	ld	a,-7 (ix)
   14E5 B7            [ 4]  540 	or	a, a
   14E6 28 23         [12]  541 	jr	Z,00126$
                            542 ;src/Map.c:144: adjacentType = map[currentPos.x][currentPos.y-1];
   14E8 DD 6E F9      [19]  543 	ld	l,-7 (ix)
   14EB 2D            [ 4]  544 	dec	l
   14EC DD 7E F6      [19]  545 	ld	a,-10 (ix)
   14EF 85            [ 4]  546 	add	a, l
   14F0 6F            [ 4]  547 	ld	l,a
   14F1 DD 7E F7      [19]  548 	ld	a,-9 (ix)
   14F4 CE 00         [ 7]  549 	adc	a, #0x00
   14F6 67            [ 4]  550 	ld	h,a
   14F7 6E            [ 7]  551 	ld	l,(hl)
                            552 ;src/Map.c:145: if(adjacentType == CELLTYPE_UNDEFINED){
   14F8 7D            [ 4]  553 	ld	a,l
   14F9 D6 87         [ 7]  554 	sub	a, #0x87
   14FB 20 06         [12]  555 	jr	NZ,00123$
                            556 ;src/Map.c:146: convertToFloor  = 1;
   14FD DD 36 F5 01   [19]  557 	ld	-11 (ix),#0x01
   1501 18 08         [12]  558 	jr	00126$
   1503                     559 00123$:
                            560 ;src/Map.c:148: else if(adjacentType == CELLTYPE_FLOOR){
   1503 7D            [ 4]  561 	ld	a,l
   1504 B7            [ 4]  562 	or	a, a
   1505 20 04         [12]  563 	jr	NZ,00126$
                            564 ;src/Map.c:149: surroundedByWalls = 0;
   1507 DD 36 F0 00   [19]  565 	ld	-16 (ix),#0x00
   150B                     566 00126$:
                            567 ;src/Map.c:152: if(currentPos.y < (MAP_HEIGHT-1)){
   150B DD 7E F9      [19]  568 	ld	a,-7 (ix)
   150E D6 1F         [ 7]  569 	sub	a, #0x1F
   1510 30 23         [12]  570 	jr	NC,00133$
                            571 ;src/Map.c:154: adjacentType = map[currentPos.x][currentPos.y+1];
   1512 DD 6E F9      [19]  572 	ld	l,-7 (ix)
   1515 2C            [ 4]  573 	inc	l
   1516 DD 7E F6      [19]  574 	ld	a,-10 (ix)
   1519 85            [ 4]  575 	add	a, l
   151A 6F            [ 4]  576 	ld	l,a
   151B DD 7E F7      [19]  577 	ld	a,-9 (ix)
   151E CE 00         [ 7]  578 	adc	a, #0x00
   1520 67            [ 4]  579 	ld	h,a
   1521 6E            [ 7]  580 	ld	l,(hl)
                            581 ;src/Map.c:155: if(adjacentType == CELLTYPE_UNDEFINED){
   1522 7D            [ 4]  582 	ld	a,l
   1523 D6 87         [ 7]  583 	sub	a, #0x87
   1525 20 06         [12]  584 	jr	NZ,00130$
                            585 ;src/Map.c:156: convertToFloor  = 1;
   1527 DD 36 F5 01   [19]  586 	ld	-11 (ix),#0x01
   152B 18 08         [12]  587 	jr	00133$
   152D                     588 00130$:
                            589 ;src/Map.c:158: else if(adjacentType == CELLTYPE_FLOOR){
   152D 7D            [ 4]  590 	ld	a,l
   152E B7            [ 4]  591 	or	a, a
   152F 20 04         [12]  592 	jr	NZ,00133$
                            593 ;src/Map.c:159: surroundedByWalls = 0;
   1531 DD 36 F0 00   [19]  594 	ld	-16 (ix),#0x00
   1535                     595 00133$:
                            596 ;src/Map.c:163: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   1535 69            [ 4]  597 	ld	l, c
   1536 60            [ 4]  598 	ld	h, b
   1537 29            [11]  599 	add	hl, hl
   1538 FD 21 D0 90   [14]  600 	ld	iy,#0x90D0
   153C C5            [11]  601 	push	bc
   153D 4D            [ 4]  602 	ld	c, l
   153E 44            [ 4]  603 	ld	b, h
   153F FD 09         [15]  604 	add	iy, bc
   1541 C1            [10]  605 	pop	bc
   1542 FD 7E 00      [19]  606 	ld	a, 0 (iy)
   1545 DD 6E FC      [19]  607 	ld	l,-4 (ix)
   1548 DD 66 FD      [19]  608 	ld	h,-3 (ix)
   154B 77            [ 7]  609 	ld	(hl),a
                            610 ;src/Map.c:164: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   154C FD E5         [15]  611 	push	iy
   154E E1            [10]  612 	pop	hl
   154F 23            [ 6]  613 	inc	hl
   1550 7E            [ 7]  614 	ld	a,(hl)
   1551 12            [ 7]  615 	ld	(de),a
                            616 ;src/Map.c:165: --wallListCount;
   1552 0B            [ 6]  617 	dec	bc
   1553 33            [ 6]  618 	inc	sp
   1554 33            [ 6]  619 	inc	sp
   1555 C5            [11]  620 	push	bc
                            621 ;src/Map.c:168: if((convertToFloor)&&(!surroundedByWalls)){
   1556 DD 7E F5      [19]  622 	ld	a,-11 (ix)
   1559 B7            [ 4]  623 	or	a, a
   155A 28 4E         [12]  624 	jr	Z,00135$
   155C DD 7E F0      [19]  625 	ld	a,-16 (ix)
   155F B7            [ 4]  626 	or	a, a
   1560 20 48         [12]  627 	jr	NZ,00135$
                            628 ;src/Map.c:169: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   1562 DD 6E FA      [19]  629 	ld	l,-6 (ix)
   1565 DD 66 FB      [19]  630 	ld	h,-5 (ix)
   1568 6E            [ 7]  631 	ld	l,(hl)
   1569 26 00         [ 7]  632 	ld	h,#0x00
   156B 29            [11]  633 	add	hl, hl
   156C 29            [11]  634 	add	hl, hl
   156D 29            [11]  635 	add	hl, hl
   156E 29            [11]  636 	add	hl, hl
   156F 29            [11]  637 	add	hl, hl
   1570 01 D0 88      [10]  638 	ld	bc,#0x88D0
   1573 09            [11]  639 	add	hl,bc
   1574 4D            [ 4]  640 	ld	c,l
   1575 44            [ 4]  641 	ld	b,h
   1576 DD 6E FE      [19]  642 	ld	l,-2 (ix)
   1579 DD 66 FF      [19]  643 	ld	h,-1 (ix)
   157C 6E            [ 7]  644 	ld	l, (hl)
   157D 26 00         [ 7]  645 	ld	h,#0x00
   157F 09            [11]  646 	add	hl,bc
   1580 36 00         [10]  647 	ld	(hl),#0x00
                            648 ;src/Map.c:171: ++lastStackItem;
   1582 DD 34 F3      [23]  649 	inc	-13 (ix)
   1585 20 03         [12]  650 	jr	NZ,00334$
   1587 DD 34 F4      [23]  651 	inc	-12 (ix)
   158A                     652 00334$:
                            653 ;src/Map.c:172: (*(cellStack+lastStackItem)).x = currentPos.x;
   158A DD 6E F3      [19]  654 	ld	l,-13 (ix)
   158D DD 66 F4      [19]  655 	ld	h,-12 (ix)
   1590 29            [11]  656 	add	hl, hl
   1591 01 D0 8C      [10]  657 	ld	bc, #0x8CD0
   1594 09            [11]  658 	add	hl,bc
   1595 4D            [ 4]  659 	ld	c, l
   1596 44            [ 4]  660 	ld	b, h
   1597 DD 6E FA      [19]  661 	ld	l,-6 (ix)
   159A DD 66 FB      [19]  662 	ld	h,-5 (ix)
   159D 7E            [ 7]  663 	ld	a,(hl)
   159E 02            [ 7]  664 	ld	(bc),a
                            665 ;src/Map.c:173: (*(cellStack+lastStackItem)).y = currentPos.y;
   159F 03            [ 6]  666 	inc	bc
   15A0 DD 6E FE      [19]  667 	ld	l,-2 (ix)
   15A3 DD 66 FF      [19]  668 	ld	h,-1 (ix)
   15A6 7E            [ 7]  669 	ld	a,(hl)
   15A7 02            [ 7]  670 	ld	(bc),a
                            671 ;src/Map.c:176: break;
   15A8 18 11         [12]  672 	jr	00209$
   15AA                     673 00135$:
                            674 ;src/Map.c:178: --wallListPosition;
   15AA DD 6E FC      [19]  675 	ld	l,-4 (ix)
   15AD DD 66 FD      [19]  676 	ld	h,-3 (ix)
   15B0 2B            [ 6]  677 	dec	hl
   15B1 2B            [ 6]  678 	dec	hl
   15B2 DD 75 FC      [19]  679 	ld	-4 (ix),l
   15B5 DD 74 FD      [19]  680 	ld	-3 (ix),h
   15B8 C3 08 14      [10]  681 	jp	00137$
                            682 ;src/Map.c:180: while(lastStackItem<MAP_SIZE){
   15BB                     683 00209$:
   15BB DD 7E F1      [19]  684 	ld	a,-15 (ix)
   15BE DD 77 F6      [19]  685 	ld	-10 (ix),a
   15C1 DD 7E F2      [19]  686 	ld	a,-14 (ix)
   15C4 DD 77 F7      [19]  687 	ld	-9 (ix),a
   15C7 DD 7E EC      [19]  688 	ld	a,-20 (ix)
   15CA DD 77 FC      [19]  689 	ld	-4 (ix),a
   15CD DD 7E ED      [19]  690 	ld	a,-19 (ix)
   15D0 DD 77 FD      [19]  691 	ld	-3 (ix),a
   15D3                     692 00164$:
   15D3 DD 7E F4      [19]  693 	ld	a,-12 (ix)
   15D6 D6 04         [ 7]  694 	sub	a, #0x04
   15D8 D2 EE 13      [10]  695 	jp	NC,00167$
                            696 ;src/Map.c:181: currentPos.x=(*(lastStackItem+cellStack)).x;
   15DB 21 02 00      [10]  697 	ld	hl,#0x0002
   15DE 39            [11]  698 	add	hl,sp
   15DF 4D            [ 4]  699 	ld	c,l
   15E0 44            [ 4]  700 	ld	b,h
   15E1 DD 6E F3      [19]  701 	ld	l,-13 (ix)
   15E4 DD 66 F4      [19]  702 	ld	h,-12 (ix)
   15E7 29            [11]  703 	add	hl, hl
   15E8 FD 21 D0 8C   [14]  704 	ld	iy,#0x8CD0
   15EC EB            [ 4]  705 	ex	de,hl
   15ED FD 19         [15]  706 	add	iy, de
   15EF FD 7E 00      [19]  707 	ld	a, 0 (iy)
   15F2 02            [ 7]  708 	ld	(bc),a
                            709 ;src/Map.c:182: currentPos.y=(*(lastStackItem+cellStack)).y;
   15F3 FD 4E 01      [19]  710 	ld	c,1 (iy)
   15F6 DD 6E FE      [19]  711 	ld	l,-2 (ix)
   15F9 DD 66 FF      [19]  712 	ld	h,-1 (ix)
   15FC 71            [ 7]  713 	ld	(hl),c
                            714 ;src/Map.c:183: --lastStackItem;
   15FD DD 6E F3      [19]  715 	ld	l,-13 (ix)
   1600 DD 66 F4      [19]  716 	ld	h,-12 (ix)
   1603 2B            [ 6]  717 	dec	hl
   1604 DD 75 F3      [19]  718 	ld	-13 (ix),l
   1607 DD 74 F4      [19]  719 	ld	-12 (ix),h
                            720 ;src/Map.c:184: cellType = map[currentPos.x][currentPos.y];
   160A DD 6E FA      [19]  721 	ld	l,-6 (ix)
   160D DD 66 FB      [19]  722 	ld	h,-5 (ix)
   1610 6E            [ 7]  723 	ld	l,(hl)
   1611 26 00         [ 7]  724 	ld	h,#0x00
   1613 29            [11]  725 	add	hl, hl
   1614 29            [11]  726 	add	hl, hl
   1615 29            [11]  727 	add	hl, hl
   1616 29            [11]  728 	add	hl, hl
   1617 29            [11]  729 	add	hl, hl
   1618 11 D0 88      [10]  730 	ld	de,#0x88D0
   161B 19            [11]  731 	add	hl,de
   161C 59            [ 4]  732 	ld	e,c
   161D 16 00         [ 7]  733 	ld	d,#0x00
   161F 19            [11]  734 	add	hl,de
   1620 4E            [ 7]  735 	ld	c,(hl)
                            736 ;src/Map.c:186: if(cellType == CELLTYPE_UNDEFINED){
   1621 79            [ 4]  737 	ld	a,c
   1622 D6 87         [ 7]  738 	sub	a, #0x87
   1624 20 47         [12]  739 	jr	NZ,00144$
                            740 ;src/Map.c:188: if(cpct_getRandom_mxor_u8 ()&1){//WALL
   1626 CD 0E 84      [17]  741 	call	_cpct_getRandom_mxor_u8
   1629 CB 45         [ 8]  742 	bit	0, l
   162B 28 06         [12]  743 	jr	Z,00141$
                            744 ;src/Map.c:189: cellType = get_random_wall();
   162D CD 5B 12      [17]  745 	call	_get_random_wall
   1630 4D            [ 4]  746 	ld	c,l
   1631 18 02         [12]  747 	jr	00142$
   1633                     748 00141$:
                            749 ;src/Map.c:192: cellType = CELLTYPE_FLOOR;
   1633 0E 00         [ 7]  750 	ld	c,#0x00
   1635                     751 00142$:
                            752 ;src/Map.c:194: map[currentPos.x][currentPos.y]=cellType;
   1635 DD 6E FA      [19]  753 	ld	l,-6 (ix)
   1638 DD 66 FB      [19]  754 	ld	h,-5 (ix)
   163B 6E            [ 7]  755 	ld	l,(hl)
   163C 26 00         [ 7]  756 	ld	h,#0x00
   163E 29            [11]  757 	add	hl, hl
   163F 29            [11]  758 	add	hl, hl
   1640 29            [11]  759 	add	hl, hl
   1641 29            [11]  760 	add	hl, hl
   1642 29            [11]  761 	add	hl, hl
   1643 EB            [ 4]  762 	ex	de,hl
   1644 21 D0 88      [10]  763 	ld	hl,#0x88D0
   1647 19            [11]  764 	add	hl,de
   1648 EB            [ 4]  765 	ex	de,hl
   1649 DD 6E FE      [19]  766 	ld	l,-2 (ix)
   164C DD 66 FF      [19]  767 	ld	h,-1 (ix)
   164F 6E            [ 7]  768 	ld	l, (hl)
   1650 26 00         [ 7]  769 	ld	h,#0x00
   1652 19            [11]  770 	add	hl,de
   1653 71            [ 7]  771 	ld	(hl),c
                            772 ;src/Map.c:195: --remainingCells;
   1654 DD 6E F6      [19]  773 	ld	l,-10 (ix)
   1657 DD 66 F7      [19]  774 	ld	h,-9 (ix)
   165A 2B            [ 6]  775 	dec	hl
   165B DD 75 F6      [19]  776 	ld	-10 (ix),l
   165E DD 74 F7      [19]  777 	ld	-9 (ix),h
   1661 DD 7E F6      [19]  778 	ld	a,-10 (ix)
   1664 DD 77 F1      [19]  779 	ld	-15 (ix),a
   1667 DD 7E F7      [19]  780 	ld	a,-9 (ix)
   166A DD 77 F2      [19]  781 	ld	-14 (ix),a
   166D                     782 00144$:
                            783 ;src/Map.c:123: if(currentPos.x>0){
   166D DD 6E FA      [19]  784 	ld	l,-6 (ix)
   1670 DD 66 FB      [19]  785 	ld	h,-5 (ix)
   1673 7E            [ 7]  786 	ld	a,(hl)
   1674 DD 77 F9      [19]  787 	ld	-7 (ix),a
                            788 ;src/Map.c:198: if((cellType == CELLTYPE_FLOOR)){
   1677 79            [ 4]  789 	ld	a,c
   1678 B7            [ 4]  790 	or	a, a
   1679 C2 A6 17      [10]  791 	jp	NZ,00162$
                            792 ;src/Map.c:199: if(currentPos.x>0){
   167C DD 7E F9      [19]  793 	ld	a,-7 (ix)
   167F B7            [ 4]  794 	or	a, a
   1680 28 43         [12]  795 	jr	Z,00148$
                            796 ;src/Map.c:200: adjacentType = map[currentPos.x-1][currentPos.y];
   1682 DD 6E F9      [19]  797 	ld	l,-7 (ix)
   1685 26 00         [ 7]  798 	ld	h,#0x00
   1687 2B            [ 6]  799 	dec	hl
   1688 29            [11]  800 	add	hl, hl
   1689 29            [11]  801 	add	hl, hl
   168A 29            [11]  802 	add	hl, hl
   168B 29            [11]  803 	add	hl, hl
   168C 29            [11]  804 	add	hl, hl
   168D 01 D0 88      [10]  805 	ld	bc,#0x88D0
   1690 09            [11]  806 	add	hl,bc
   1691 4D            [ 4]  807 	ld	c,l
   1692 44            [ 4]  808 	ld	b,h
   1693 DD 6E FE      [19]  809 	ld	l,-2 (ix)
   1696 DD 66 FF      [19]  810 	ld	h,-1 (ix)
   1699 6E            [ 7]  811 	ld	l, (hl)
   169A 26 00         [ 7]  812 	ld	h,#0x00
   169C 09            [11]  813 	add	hl,bc
   169D 7E            [ 7]  814 	ld	a,(hl)
                            815 ;src/Map.c:201: if(adjacentType == CELLTYPE_UNDEFINED){
   169E D6 87         [ 7]  816 	sub	a, #0x87
   16A0 20 23         [12]  817 	jr	NZ,00148$
                            818 ;src/Map.c:203: ++lastStackItem;
   16A2 DD 34 F3      [23]  819 	inc	-13 (ix)
   16A5 20 03         [12]  820 	jr	NZ,00340$
   16A7 DD 34 F4      [23]  821 	inc	-12 (ix)
   16AA                     822 00340$:
                            823 ;src/Map.c:204: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   16AA DD 6E F3      [19]  824 	ld	l,-13 (ix)
   16AD DD 66 F4      [19]  825 	ld	h,-12 (ix)
   16B0 29            [11]  826 	add	hl, hl
   16B1 01 D0 8C      [10]  827 	ld	bc,#0x8CD0
   16B4 09            [11]  828 	add	hl,bc
   16B5 DD 4E F9      [19]  829 	ld	c,-7 (ix)
   16B8 0D            [ 4]  830 	dec	c
   16B9 71            [ 7]  831 	ld	(hl),c
                            832 ;src/Map.c:205: (*(cellStack+lastStackItem)).y = currentPos.y;
   16BA 23            [ 6]  833 	inc	hl
   16BB 4D            [ 4]  834 	ld	c,l
   16BC 44            [ 4]  835 	ld	b,h
   16BD DD 6E FE      [19]  836 	ld	l,-2 (ix)
   16C0 DD 66 FF      [19]  837 	ld	h,-1 (ix)
   16C3 7E            [ 7]  838 	ld	a,(hl)
   16C4 02            [ 7]  839 	ld	(bc),a
   16C5                     840 00148$:
                            841 ;src/Map.c:209: if(currentPos.x < (MAP_WIDTH-1)){
   16C5 DD 6E FA      [19]  842 	ld	l,-6 (ix)
   16C8 DD 66 FB      [19]  843 	ld	h,-5 (ix)
   16CB 4E            [ 7]  844 	ld	c,(hl)
   16CC 79            [ 4]  845 	ld	a,c
   16CD D6 1F         [ 7]  846 	sub	a, #0x1F
   16CF 30 3E         [12]  847 	jr	NC,00152$
                            848 ;src/Map.c:211: adjacentType = map[currentPos.x+1][currentPos.y];
   16D1 69            [ 4]  849 	ld	l,c
   16D2 26 00         [ 7]  850 	ld	h,#0x00
   16D4 23            [ 6]  851 	inc	hl
   16D5 29            [11]  852 	add	hl, hl
   16D6 29            [11]  853 	add	hl, hl
   16D7 29            [11]  854 	add	hl, hl
   16D8 29            [11]  855 	add	hl, hl
   16D9 29            [11]  856 	add	hl, hl
   16DA EB            [ 4]  857 	ex	de,hl
   16DB 21 D0 88      [10]  858 	ld	hl,#0x88D0
   16DE 19            [11]  859 	add	hl,de
   16DF EB            [ 4]  860 	ex	de,hl
   16E0 DD 6E FE      [19]  861 	ld	l,-2 (ix)
   16E3 DD 66 FF      [19]  862 	ld	h,-1 (ix)
   16E6 6E            [ 7]  863 	ld	l, (hl)
   16E7 26 00         [ 7]  864 	ld	h,#0x00
   16E9 19            [11]  865 	add	hl,de
   16EA 7E            [ 7]  866 	ld	a,(hl)
                            867 ;src/Map.c:212: if(adjacentType == CELLTYPE_UNDEFINED){
   16EB D6 87         [ 7]  868 	sub	a, #0x87
   16ED 20 20         [12]  869 	jr	NZ,00152$
                            870 ;src/Map.c:215: ++lastStackItem;
   16EF DD 34 F3      [23]  871 	inc	-13 (ix)
   16F2 20 03         [12]  872 	jr	NZ,00343$
   16F4 DD 34 F4      [23]  873 	inc	-12 (ix)
   16F7                     874 00343$:
                            875 ;src/Map.c:216: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   16F7 DD 6E F3      [19]  876 	ld	l,-13 (ix)
   16FA DD 66 F4      [19]  877 	ld	h,-12 (ix)
   16FD 29            [11]  878 	add	hl, hl
   16FE 11 D0 8C      [10]  879 	ld	de,#0x8CD0
   1701 19            [11]  880 	add	hl,de
   1702 0C            [ 4]  881 	inc	c
   1703 71            [ 7]  882 	ld	(hl),c
                            883 ;src/Map.c:217: (*(cellStack+lastStackItem)).y = currentPos.y;
   1704 23            [ 6]  884 	inc	hl
   1705 4D            [ 4]  885 	ld	c,l
   1706 44            [ 4]  886 	ld	b,h
   1707 DD 6E FE      [19]  887 	ld	l,-2 (ix)
   170A DD 66 FF      [19]  888 	ld	h,-1 (ix)
   170D 7E            [ 7]  889 	ld	a,(hl)
   170E 02            [ 7]  890 	ld	(bc),a
   170F                     891 00152$:
                            892 ;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
   170F DD 6E FE      [19]  893 	ld	l,-2 (ix)
   1712 DD 66 FF      [19]  894 	ld	h,-1 (ix)
   1715 4E            [ 7]  895 	ld	c,(hl)
                            896 ;src/Map.c:221: if(currentPos.y > 0){
   1716 79            [ 4]  897 	ld	a,c
   1717 B7            [ 4]  898 	or	a, a
   1718 28 3E         [12]  899 	jr	Z,00156$
                            900 ;src/Map.c:223: adjacentType = map[currentPos.x][currentPos.y-1];
   171A DD 6E FA      [19]  901 	ld	l,-6 (ix)
   171D DD 66 FB      [19]  902 	ld	h,-5 (ix)
   1720 46            [ 7]  903 	ld	b,(hl)
   1721 68            [ 4]  904 	ld	l,b
   1722 26 00         [ 7]  905 	ld	h,#0x00
   1724 29            [11]  906 	add	hl, hl
   1725 29            [11]  907 	add	hl, hl
   1726 29            [11]  908 	add	hl, hl
   1727 29            [11]  909 	add	hl, hl
   1728 29            [11]  910 	add	hl, hl
   1729 11 D0 88      [10]  911 	ld	de,#0x88D0
   172C 19            [11]  912 	add	hl,de
   172D 0D            [ 4]  913 	dec	c
   172E 59            [ 4]  914 	ld	e,c
   172F 16 00         [ 7]  915 	ld	d,#0x00
   1731 19            [11]  916 	add	hl,de
   1732 7E            [ 7]  917 	ld	a,(hl)
                            918 ;src/Map.c:224: if(adjacentType == CELLTYPE_UNDEFINED){
   1733 D6 87         [ 7]  919 	sub	a, #0x87
   1735 20 21         [12]  920 	jr	NZ,00156$
                            921 ;src/Map.c:227: ++lastStackItem;
   1737 DD 34 F3      [23]  922 	inc	-13 (ix)
   173A 20 03         [12]  923 	jr	NZ,00346$
   173C DD 34 F4      [23]  924 	inc	-12 (ix)
   173F                     925 00346$:
                            926 ;src/Map.c:228: (*(cellStack+lastStackItem)).x = currentPos.x;
   173F DD 6E F3      [19]  927 	ld	l,-13 (ix)
   1742 DD 66 F4      [19]  928 	ld	h,-12 (ix)
   1745 29            [11]  929 	add	hl, hl
   1746 11 D0 8C      [10]  930 	ld	de,#0x8CD0
   1749 19            [11]  931 	add	hl,de
   174A 70            [ 7]  932 	ld	(hl),b
                            933 ;src/Map.c:229: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   174B 23            [ 6]  934 	inc	hl
   174C 4D            [ 4]  935 	ld	c,l
   174D 44            [ 4]  936 	ld	b,h
   174E DD 6E FE      [19]  937 	ld	l,-2 (ix)
   1751 DD 66 FF      [19]  938 	ld	h,-1 (ix)
   1754 5E            [ 7]  939 	ld	e,(hl)
   1755 1D            [ 4]  940 	dec	e
   1756 7B            [ 4]  941 	ld	a,e
   1757 02            [ 7]  942 	ld	(bc),a
   1758                     943 00156$:
                            944 ;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
   1758 DD 6E FE      [19]  945 	ld	l,-2 (ix)
   175B DD 66 FF      [19]  946 	ld	h,-1 (ix)
   175E 46            [ 7]  947 	ld	b,(hl)
                            948 ;src/Map.c:233: if(currentPos.y < (MAP_HEIGHT-1)){
   175F 78            [ 4]  949 	ld	a,b
   1760 D6 1F         [ 7]  950 	sub	a, #0x1F
   1762 D2 D3 15      [10]  951 	jp	NC,00164$
                            952 ;src/Map.c:235: adjacentType = map[currentPos.x][currentPos.y+1];
   1765 DD 6E FA      [19]  953 	ld	l,-6 (ix)
   1768 DD 66 FB      [19]  954 	ld	h,-5 (ix)
   176B 4E            [ 7]  955 	ld	c,(hl)
   176C 69            [ 4]  956 	ld	l,c
   176D 26 00         [ 7]  957 	ld	h,#0x00
   176F 29            [11]  958 	add	hl, hl
   1770 29            [11]  959 	add	hl, hl
   1771 29            [11]  960 	add	hl, hl
   1772 29            [11]  961 	add	hl, hl
   1773 29            [11]  962 	add	hl, hl
   1774 11 D0 88      [10]  963 	ld	de,#0x88D0
   1777 19            [11]  964 	add	hl,de
   1778 04            [ 4]  965 	inc	b
   1779 58            [ 4]  966 	ld	e,b
   177A 16 00         [ 7]  967 	ld	d,#0x00
   177C 19            [11]  968 	add	hl,de
   177D 7E            [ 7]  969 	ld	a,(hl)
                            970 ;src/Map.c:236: if(adjacentType == CELLTYPE_UNDEFINED){
   177E D6 87         [ 7]  971 	sub	a, #0x87
   1780 C2 D3 15      [10]  972 	jp	NZ,00164$
                            973 ;src/Map.c:239: ++lastStackItem;
   1783 DD 34 F3      [23]  974 	inc	-13 (ix)
   1786 20 03         [12]  975 	jr	NZ,00349$
   1788 DD 34 F4      [23]  976 	inc	-12 (ix)
   178B                     977 00349$:
                            978 ;src/Map.c:240: (*(cellStack+lastStackItem)).x = currentPos.x;
   178B DD 6E F3      [19]  979 	ld	l,-13 (ix)
   178E DD 66 F4      [19]  980 	ld	h,-12 (ix)
   1791 29            [11]  981 	add	hl, hl
   1792 11 D0 8C      [10]  982 	ld	de,#0x8CD0
   1795 19            [11]  983 	add	hl,de
   1796 71            [ 7]  984 	ld	(hl),c
                            985 ;src/Map.c:241: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   1797 23            [ 6]  986 	inc	hl
   1798 4D            [ 4]  987 	ld	c,l
   1799 44            [ 4]  988 	ld	b,h
   179A DD 6E FE      [19]  989 	ld	l,-2 (ix)
   179D DD 66 FF      [19]  990 	ld	h,-1 (ix)
   17A0 7E            [ 7]  991 	ld	a,(hl)
   17A1 3C            [ 4]  992 	inc	a
   17A2 02            [ 7]  993 	ld	(bc),a
   17A3 C3 D3 15      [10]  994 	jp	00164$
   17A6                     995 00162$:
                            996 ;src/Map.c:247: ++wallListCount;
   17A6 DD 34 FC      [23]  997 	inc	-4 (ix)
   17A9 20 03         [12]  998 	jr	NZ,00350$
   17AB DD 34 FD      [23]  999 	inc	-3 (ix)
   17AE                    1000 00350$:
   17AE DD 7E FC      [19] 1001 	ld	a,-4 (ix)
   17B1 DD 77 EC      [19] 1002 	ld	-20 (ix),a
   17B4 DD 7E FD      [19] 1003 	ld	a,-3 (ix)
   17B7 DD 77 ED      [19] 1004 	ld	-19 (ix),a
                           1005 ;src/Map.c:248: (*(wallList+wallListCount)).x = currentPos.x;
   17BA DD 6E FC      [19] 1006 	ld	l,-4 (ix)
   17BD DD 66 FD      [19] 1007 	ld	h,-3 (ix)
   17C0 29            [11] 1008 	add	hl, hl
   17C1 01 D0 90      [10] 1009 	ld	bc,#0x90D0
   17C4 09            [11] 1010 	add	hl,bc
   17C5 DD 7E F9      [19] 1011 	ld	a,-7 (ix)
   17C8 77            [ 7] 1012 	ld	(hl),a
                           1013 ;src/Map.c:249: (*(wallList+wallListCount)).y = currentPos.y;
   17C9 23            [ 6] 1014 	inc	hl
   17CA 4D            [ 4] 1015 	ld	c,l
   17CB 44            [ 4] 1016 	ld	b,h
   17CC DD 6E FE      [19] 1017 	ld	l,-2 (ix)
   17CF DD 66 FF      [19] 1018 	ld	h,-1 (ix)
   17D2 7E            [ 7] 1019 	ld	a,(hl)
   17D3 02            [ 7] 1020 	ld	(bc),a
   17D4 C3 D3 15      [10] 1021 	jp	00164$
   17D7                    1022 00174$:
   17D7 DD F9         [10] 1023 	ld	sp, ix
   17D9 DD E1         [14] 1024 	pop	ix
   17DB C9            [10] 1025 	ret
                           1026 ;src/Map.c:255: void generate_exit_door(){
                           1027 ;	---------------------------------
                           1028 ; Function generate_exit_door
                           1029 ; ---------------------------------
   17DC                    1030 _generate_exit_door::
   17DC DD E5         [15] 1031 	push	ix
   17DE DD 21 00 00   [14] 1032 	ld	ix,#0
   17E2 DD 39         [15] 1033 	add	ix,sp
   17E4 21 F3 FF      [10] 1034 	ld	hl,#-13
   17E7 39            [11] 1035 	add	hl,sp
   17E8 F9            [ 6] 1036 	ld	sp,hl
                           1037 ;src/Map.c:256: u8 x=(cpct_getRandom_mxor_u8 ()%32);
   17E9 CD 0E 84      [17] 1038 	call	_cpct_getRandom_mxor_u8
   17EC 7D            [ 4] 1039 	ld	a,l
   17ED E6 1F         [ 7] 1040 	and	a, #0x1F
   17EF 4F            [ 4] 1041 	ld	c,a
                           1042 ;src/Map.c:257: u8 y=(cpct_getRandom_mxor_u8 ()%32);
   17F0 C5            [11] 1043 	push	bc
   17F1 CD 0E 84      [17] 1044 	call	_cpct_getRandom_mxor_u8
   17F4 C1            [10] 1045 	pop	bc
   17F5 7D            [ 4] 1046 	ld	a,l
   17F6 E6 1F         [ 7] 1047 	and	a, #0x1F
   17F8 5F            [ 4] 1048 	ld	e,a
                           1049 ;src/Map.c:258: u8 door_not_positioned=1;
   17F9 DD 36 F9 01   [19] 1050 	ld	-7 (ix),#0x01
                           1051 ;src/Map.c:265: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
   17FD 06 00         [ 7] 1052 	ld	b,#0x00
   17FF 21 D0 88      [10] 1053 	ld	hl,#0x88D0
   1802 09            [11] 1054 	add	hl,bc
   1803 4D            [ 4] 1055 	ld	c,l
   1804 44            [ 4] 1056 	ld	b,h
   1805 6B            [ 4] 1057 	ld	l,e
   1806 26 00         [ 7] 1058 	ld	h,#0x00
   1808 29            [11] 1059 	add	hl, hl
   1809 29            [11] 1060 	add	hl, hl
   180A 29            [11] 1061 	add	hl, hl
   180B 29            [11] 1062 	add	hl, hl
   180C 29            [11] 1063 	add	hl, hl
   180D 09            [11] 1064 	add	hl,bc
   180E 4D            [ 4] 1065 	ld	c,l
   180F 44            [ 4] 1066 	ld	b,h
                           1067 ;src/Map.c:270: lastVal = (position-1);
   1810 59            [ 4] 1068 	ld	e,c
   1811 50            [ 4] 1069 	ld	d,b
   1812 1B            [ 6] 1070 	dec	de
                           1071 ;src/Map.c:271: nextVal = (position+1);
   1813 21 01 00      [10] 1072 	ld	hl,#0x0001
   1816 09            [11] 1073 	add	hl,bc
   1817 DD 75 F7      [19] 1074 	ld	-9 (ix),l
   181A DD 74 F8      [19] 1075 	ld	-8 (ix),h
                           1076 ;src/Map.c:272: topVal = (position-MAP_WIDTH);
   181D 79            [ 4] 1077 	ld	a,c
   181E C6 E0         [ 7] 1078 	add	a,#0xE0
   1820 DD 77 F5      [19] 1079 	ld	-11 (ix),a
   1823 78            [ 4] 1080 	ld	a,b
   1824 CE FF         [ 7] 1081 	adc	a,#0xFF
   1826 DD 77 F6      [19] 1082 	ld	-10 (ix),a
                           1083 ;src/Map.c:273: bottomVal = (position+MAP_WIDTH);
   1829 21 20 00      [10] 1084 	ld	hl,#0x0020
   182C 09            [11] 1085 	add	hl,bc
   182D E3            [19] 1086 	ex	(sp), hl
                           1087 ;src/Map.c:275: while(door_not_positioned){
   182E                    1088 00138$:
   182E DD 7E F9      [19] 1089 	ld	a,-7 (ix)
   1831 B7            [ 4] 1090 	or	a, a
   1832 CA 80 19      [10] 1091 	jp	Z,00141$
                           1092 ;src/Map.c:276: if((*position)!=CELLTYPE_FLOOR){
   1835 0A            [ 7] 1093 	ld	a,(bc)
   1836 B7            [ 4] 1094 	or	a, a
   1837 CA 3D 19      [10] 1095 	jp	Z,00135$
                           1096 ;src/Map.c:277: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   183A 1A            [ 7] 1097 	ld	a,(de)
   183B DD 77 FC      [19] 1098 	ld	-4 (ix),a
   183E 7B            [ 4] 1099 	ld	a,e
   183F D6 D0         [ 7] 1100 	sub	a, #0xD0
   1841 7A            [ 4] 1101 	ld	a,d
   1842 DE 88         [ 7] 1102 	sbc	a, #0x88
   1844 3E 00         [ 7] 1103 	ld	a,#0x00
   1846 17            [ 4] 1104 	rla
   1847 DD 77 FB      [19] 1105 	ld	-5 (ix),a
   184A DD 7E F7      [19] 1106 	ld	a,-9 (ix)
   184D D6 D0         [ 7] 1107 	sub	a, #0xD0
   184F DD 7E F8      [19] 1108 	ld	a,-8 (ix)
   1852 DE 8C         [ 7] 1109 	sbc	a, #0x8C
   1854 3E 00         [ 7] 1110 	ld	a,#0x00
   1856 17            [ 4] 1111 	rla
   1857 DD 77 FA      [19] 1112 	ld	-6 (ix),a
                           1113 ;src/Map.c:278: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   185A DD 6E F5      [19] 1114 	ld	l,-11 (ix)
   185D DD 66 F6      [19] 1115 	ld	h,-10 (ix)
   1860 7E            [ 7] 1116 	ld	a,(hl)
   1861 DD 77 FF      [19] 1117 	ld	-1 (ix),a
   1864 DD 7E F5      [19] 1118 	ld	a,-11 (ix)
   1867 D6 D0         [ 7] 1119 	sub	a, #0xD0
   1869 DD 7E F6      [19] 1120 	ld	a,-10 (ix)
   186C DE 88         [ 7] 1121 	sbc	a, #0x88
   186E 3E 00         [ 7] 1122 	ld	a,#0x00
   1870 17            [ 4] 1123 	rla
   1871 DD 77 FE      [19] 1124 	ld	-2 (ix),a
   1874 DD 7E F3      [19] 1125 	ld	a,-13 (ix)
   1877 D6 D0         [ 7] 1126 	sub	a, #0xD0
   1879 DD 7E F4      [19] 1127 	ld	a,-12 (ix)
   187C DE 8C         [ 7] 1128 	sbc	a, #0x8C
   187E 3E 00         [ 7] 1129 	ld	a,#0x00
   1880 17            [ 4] 1130 	rla
   1881 DD 77 FD      [19] 1131 	ld	-3 (ix),a
                           1132 ;src/Map.c:277: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   1884 DD 7E FC      [19] 1133 	ld	a,-4 (ix)
   1887 B7            [ 4] 1134 	or	a, a
   1888 20 06         [12] 1135 	jr	NZ,00133$
   188A DD 7E FB      [19] 1136 	ld	a,-5 (ix)
   188D B7            [ 4] 1137 	or	a, a
   188E 28 52         [12] 1138 	jr	Z,00129$
   1890                    1139 00133$:
   1890 DD 6E F7      [19] 1140 	ld	l,-9 (ix)
   1893 DD 66 F8      [19] 1141 	ld	h,-8 (ix)
   1896 7E            [ 7] 1142 	ld	a,(hl)
   1897 B7            [ 4] 1143 	or	a, a
   1898 20 06         [12] 1144 	jr	NZ,00128$
   189A DD CB FA 46   [20] 1145 	bit	0,-6 (ix)
   189E 20 42         [12] 1146 	jr	NZ,00129$
   18A0                    1147 00128$:
                           1148 ;src/Map.c:278: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   18A0 E1            [10] 1149 	pop	hl
   18A1 E5            [11] 1150 	push	hl
   18A2 6E            [ 7] 1151 	ld	l,(hl)
   18A3 DD 7E FF      [19] 1152 	ld	a,-1 (ix)
   18A6 B7            [ 4] 1153 	or	a, a
   18A7 20 06         [12] 1154 	jr	NZ,00111$
   18A9 DD 7E FE      [19] 1155 	ld	a,-2 (ix)
   18AC B7            [ 4] 1156 	or	a, a
   18AD 28 14         [12] 1157 	jr	Z,00107$
   18AF                    1158 00111$:
   18AF 7D            [ 4] 1159 	ld	a,l
   18B0 B7            [ 4] 1160 	or	a, a
   18B1 20 10         [12] 1161 	jr	NZ,00107$
   18B3 DD 7E FD      [19] 1162 	ld	a,-3 (ix)
   18B6 B7            [ 4] 1163 	or	a, a
   18B7 28 0A         [12] 1164 	jr	Z,00107$
                           1165 ;src/Map.c:279: door_not_positioned=0;
   18B9 DD 36 F9 00   [19] 1166 	ld	-7 (ix),#0x00
                           1167 ;src/Map.c:280: *position=CELLTYPE_DOOR;
   18BD 3E 80         [ 7] 1168 	ld	a,#0x80
   18BF 02            [ 7] 1169 	ld	(bc),a
   18C0 C3 3D 19      [10] 1170 	jp	00135$
   18C3                    1171 00107$:
                           1172 ;src/Map.c:282: else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
   18C3 7D            [ 4] 1173 	ld	a,l
   18C4 B7            [ 4] 1174 	or	a, a
   18C5 20 06         [12] 1175 	jr	NZ,00105$
   18C7 DD 7E FD      [19] 1176 	ld	a,-3 (ix)
   18CA B7            [ 4] 1177 	or	a, a
   18CB 20 70         [12] 1178 	jr	NZ,00135$
   18CD                    1179 00105$:
   18CD DD 7E FF      [19] 1180 	ld	a,-1 (ix)
   18D0 B7            [ 4] 1181 	or	a, a
   18D1 20 6A         [12] 1182 	jr	NZ,00135$
   18D3 DD 7E FE      [19] 1183 	ld	a,-2 (ix)
   18D6 B7            [ 4] 1184 	or	a, a
   18D7 20 64         [12] 1185 	jr	NZ,00135$
                           1186 ;src/Map.c:283: door_not_positioned=0;
   18D9 DD 36 F9 00   [19] 1187 	ld	-7 (ix),#0x00
                           1188 ;src/Map.c:284: *position=CELLTYPE_DOOR;
   18DD 3E 80         [ 7] 1189 	ld	a,#0x80
   18DF 02            [ 7] 1190 	ld	(bc),a
   18E0 18 5B         [12] 1191 	jr	00135$
   18E2                    1192 00129$:
                           1193 ;src/Map.c:287: else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
   18E2 DD 7E FF      [19] 1194 	ld	a,-1 (ix)
   18E5 B7            [ 4] 1195 	or	a, a
   18E6 20 06         [12] 1196 	jr	NZ,00127$
   18E8 DD 7E FE      [19] 1197 	ld	a,-2 (ix)
   18EB B7            [ 4] 1198 	or	a, a
   18EC 28 4F         [12] 1199 	jr	Z,00135$
   18EE                    1200 00127$:
   18EE E1            [10] 1201 	pop	hl
   18EF E5            [11] 1202 	push	hl
   18F0 7E            [ 7] 1203 	ld	a,(hl)
   18F1 B7            [ 4] 1204 	or	a, a
   18F2 20 06         [12] 1205 	jr	NZ,00123$
   18F4 DD 7E FD      [19] 1206 	ld	a,-3 (ix)
   18F7 B7            [ 4] 1207 	or	a, a
   18F8 20 43         [12] 1208 	jr	NZ,00135$
   18FA                    1209 00123$:
                           1210 ;src/Map.c:277: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   18FA DD 6E F7      [19] 1211 	ld	l,-9 (ix)
   18FD DD 66 F8      [19] 1212 	ld	h,-8 (ix)
   1900 6E            [ 7] 1213 	ld	l,(hl)
                           1214 ;src/Map.c:288: if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
   1901 DD 7E FC      [19] 1215 	ld	a,-4 (ix)
   1904 B7            [ 4] 1216 	or	a, a
   1905 20 06         [12] 1217 	jr	NZ,00122$
   1907 DD 7E FB      [19] 1218 	ld	a,-5 (ix)
   190A B7            [ 4] 1219 	or	a, a
   190B 28 13         [12] 1220 	jr	Z,00118$
   190D                    1221 00122$:
   190D 7D            [ 4] 1222 	ld	a,l
   190E B7            [ 4] 1223 	or	a, a
   190F 20 0F         [12] 1224 	jr	NZ,00118$
   1911 DD CB FA 46   [20] 1225 	bit	0,-6 (ix)
   1915 28 09         [12] 1226 	jr	Z,00118$
                           1227 ;src/Map.c:289: door_not_positioned=0;
   1917 DD 36 F9 00   [19] 1228 	ld	-7 (ix),#0x00
                           1229 ;src/Map.c:290: *position=CELLTYPE_DOOR;
   191B 3E 80         [ 7] 1230 	ld	a,#0x80
   191D 02            [ 7] 1231 	ld	(bc),a
   191E 18 1D         [12] 1232 	jr	00135$
   1920                    1233 00118$:
                           1234 ;src/Map.c:292: else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
   1920 7D            [ 4] 1235 	ld	a,l
   1921 B7            [ 4] 1236 	or	a, a
   1922 20 06         [12] 1237 	jr	NZ,00116$
   1924 DD CB FA 46   [20] 1238 	bit	0,-6 (ix)
   1928 20 13         [12] 1239 	jr	NZ,00135$
   192A                    1240 00116$:
   192A DD 7E FC      [19] 1241 	ld	a,-4 (ix)
   192D B7            [ 4] 1242 	or	a, a
   192E 20 0D         [12] 1243 	jr	NZ,00135$
   1930 DD 7E FB      [19] 1244 	ld	a,-5 (ix)
   1933 B7            [ 4] 1245 	or	a, a
   1934 20 07         [12] 1246 	jr	NZ,00135$
                           1247 ;src/Map.c:293: door_not_positioned=0;
   1936 DD 36 F9 00   [19] 1248 	ld	-7 (ix),#0x00
                           1249 ;src/Map.c:294: *position=CELLTYPE_DOOR;
   193A 3E 80         [ 7] 1250 	ld	a,#0x80
   193C 02            [ 7] 1251 	ld	(bc),a
   193D                    1252 00135$:
                           1253 ;src/Map.c:298: ++position;
   193D 03            [ 6] 1254 	inc	bc
                           1255 ;src/Map.c:299: ++lastVal;
   193E 13            [ 6] 1256 	inc	de
                           1257 ;src/Map.c:300: ++nextVal;
   193F DD 34 F7      [23] 1258 	inc	-9 (ix)
   1942 20 03         [12] 1259 	jr	NZ,00223$
   1944 DD 34 F8      [23] 1260 	inc	-8 (ix)
   1947                    1261 00223$:
                           1262 ;src/Map.c:301: ++topVal;
   1947 DD 34 F5      [23] 1263 	inc	-11 (ix)
   194A 20 03         [12] 1264 	jr	NZ,00224$
   194C DD 34 F6      [23] 1265 	inc	-10 (ix)
   194F                    1266 00224$:
                           1267 ;src/Map.c:302: ++bottomVal;
   194F DD 34 F3      [23] 1268 	inc	-13 (ix)
   1952 20 03         [12] 1269 	jr	NZ,00225$
   1954 DD 34 F4      [23] 1270 	inc	-12 (ix)
   1957                    1271 00225$:
                           1272 ;src/Map.c:303: if(position==END_OF_MAP_MEM){
   1957 79            [ 4] 1273 	ld	a,c
   1958 D6 D0         [ 7] 1274 	sub	a, #0xD0
   195A C2 2E 18      [10] 1275 	jp	NZ,00138$
   195D 78            [ 4] 1276 	ld	a,b
   195E D6 8C         [ 7] 1277 	sub	a, #0x8C
   1960 C2 2E 18      [10] 1278 	jp	NZ,00138$
                           1279 ;src/Map.c:304: position = MAP_MEM;
   1963 01 D0 88      [10] 1280 	ld	bc,#0x88D0
                           1281 ;src/Map.c:305: lastVal = (position-1);
   1966 11 CF 88      [10] 1282 	ld	de,#0x88CF
                           1283 ;src/Map.c:306: nextVal = (position+1);
   1969 DD 36 F7 D1   [19] 1284 	ld	-9 (ix),#0xD1
   196D DD 36 F8 88   [19] 1285 	ld	-8 (ix),#0x88
                           1286 ;src/Map.c:307: topVal = (position-MAP_WIDTH);
   1971 DD 36 F5 B0   [19] 1287 	ld	-11 (ix),#0xB0
   1975 DD 36 F6 88   [19] 1288 	ld	-10 (ix),#0x88
                           1289 ;src/Map.c:308: bottomVal = (position+MAP_WIDTH);
   1979 21 F0 88      [10] 1290 	ld	hl,#0x88F0
   197C E3            [19] 1291 	ex	(sp), hl
   197D C3 2E 18      [10] 1292 	jp	00138$
   1980                    1293 00141$:
   1980 DD F9         [10] 1294 	ld	sp, ix
   1982 DD E1         [14] 1295 	pop	ix
   1984 C9            [10] 1296 	ret
                           1297 ;src/Map.c:314: void generate_level(){
                           1298 ;	---------------------------------
                           1299 ; Function generate_level
                           1300 ; ---------------------------------
   1985                    1301 _generate_level::
                           1302 ;src/Map.c:315: generate_level_with_seed(r_counter);
   1985 2A D5 86      [16] 1303 	ld	hl,(_r_counter)
   1988 E5            [11] 1304 	push	hl
   1989 CD 8E 19      [17] 1305 	call	_generate_level_with_seed
   198C F1            [10] 1306 	pop	af
   198D C9            [10] 1307 	ret
                           1308 ;src/Map.c:318: void generate_level_with_seed(u16 seed) {
                           1309 ;	---------------------------------
                           1310 ; Function generate_level_with_seed
                           1311 ; ---------------------------------
   198E                    1312 _generate_level_with_seed::
   198E DD E5         [15] 1313 	push	ix
   1990 DD 21 00 00   [14] 1314 	ld	ix,#0
   1994 DD 39         [15] 1315 	add	ix,sp
                           1316 ;src/Map.c:320: rand_seed=seed;
   1996 DD 4E 04      [19] 1317 	ld	c,4 (ix)
   1999 DD 46 05      [19] 1318 	ld	b,5 (ix)
   199C ED 43 03 87   [20] 1319 	ld	(_rand_seed),bc
                           1320 ;src/Map.c:323: cpct_setSeed_mxor(((seed+level_get_level())&0xFFFE) + 1);
   19A0 C5            [11] 1321 	push	bc
   19A1 CD 59 11      [17] 1322 	call	_level_get_level
   19A4 C1            [10] 1323 	pop	bc
   19A5 26 00         [ 7] 1324 	ld	h,#0x00
   19A7 09            [11] 1325 	add	hl,bc
   19A8 CB 85         [ 8] 1326 	res	0, l
   19AA 23            [ 6] 1327 	inc	hl
   19AB 11 00 00      [10] 1328 	ld	de,#0x0000
   19AE CD 00 84      [17] 1329 	call	_cpct_setSeed_mxor
                           1330 ;src/Map.c:324: cpct_restoreState_mxor_u8();
   19B1 CD 08 84      [17] 1331 	call	_cpct_restoreState_mxor_u8
                           1332 ;src/Map.c:326: if(level_get_level()<KING_LEVEL){
   19B4 CD 59 11      [17] 1333 	call	_level_get_level
   19B7 7D            [ 4] 1334 	ld	a,l
   19B8 D6 20         [ 7] 1335 	sub	a, #0x20
   19BA 30 08         [12] 1336 	jr	NC,00102$
                           1337 ;src/Map.c:327: generate_map();
   19BC CD 0A 13      [17] 1338 	call	_generate_map
                           1339 ;src/Map.c:328: generate_exit_door();
   19BF CD DC 17      [17] 1340 	call	_generate_exit_door
   19C2 18 03         [12] 1341 	jr	00104$
   19C4                    1342 00102$:
                           1343 ;src/Map.c:331: generate_final_map();
   19C4 CD 78 12      [17] 1344 	call	_generate_final_map
   19C7                    1345 00104$:
   19C7 DD E1         [14] 1346 	pop	ix
   19C9 C9            [10] 1347 	ret
                           1348 	.area _CODE
                           1349 	.area _INITIALIZER
                           1350 	.area _CABS (ABS)
