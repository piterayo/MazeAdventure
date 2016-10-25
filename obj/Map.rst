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
   7D63                      33 _rand_seed::
   7D63                      34 	.ds 2
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
   10A5                      63 _map_get_seed::
                             64 ;src/Map.c:15: return rand_seed;
   10A5 2A 63 7D      [16]   65 	ld	hl,(_rand_seed)
   10A8 C9            [10]   66 	ret
                             67 ;src/Map.c:18: u8 get_random_wall(){
                             68 ;	---------------------------------
                             69 ; Function get_random_wall
                             70 ; ---------------------------------
   10A9                      71 _get_random_wall::
                             72 ;src/Map.c:19: u8 cellType = cpct_getRandom_mxor_u8 ();
   10A9 CD 71 7A      [17]   73 	call	_cpct_getRandom_mxor_u8
                             74 ;src/Map.c:20: if(cellType&1){ //1,3,5,7
   10AC CB 45         [ 8]   75 	bit	0, l
   10AE 28 03         [12]   76 	jr	Z,00108$
                             77 ;src/Map.c:21: return CELLTYPE_WALL1;
   10B0 2E 81         [ 7]   78 	ld	l,#0x81
   10B2 C9            [10]   79 	ret
   10B3                      80 00108$:
                             81 ;src/Map.c:24: if(cellType&3){//2,6
   10B3 7D            [ 4]   82 	ld	a,l
   10B4 E6 03         [ 7]   83 	and	a, #0x03
   10B6 28 03         [12]   84 	jr	Z,00105$
                             85 ;src/Map.c:25: return CELLTYPE_WALL2;
   10B8 2E 82         [ 7]   86 	ld	l,#0x82
   10BA C9            [10]   87 	ret
   10BB                      88 00105$:
                             89 ;src/Map.c:28: if(cellType&7){//4
   10BB 7D            [ 4]   90 	ld	a,l
   10BC E6 07         [ 7]   91 	and	a, #0x07
   10BE 28 03         [12]   92 	jr	Z,00102$
                             93 ;src/Map.c:29: return CELLTYPE_WALL3;
   10C0 2E 83         [ 7]   94 	ld	l,#0x83
   10C2 C9            [10]   95 	ret
   10C3                      96 00102$:
                             97 ;src/Map.c:32: return CELLTYPE_WALL4;  
   10C3 2E 84         [ 7]   98 	ld	l,#0x84
   10C5 C9            [10]   99 	ret
                            100 ;src/Map.c:38: void generate_final_map(){
                            101 ;	---------------------------------
                            102 ; Function generate_final_map
                            103 ; ---------------------------------
   10C6                     104 _generate_final_map::
                            105 ;src/Map.c:43: while(m>=MAP_MEM){
   10C6 21 D0 8C      [10]  106 	ld	hl,#0x8CD0
   10C9                     107 00101$:
   10C9 7D            [ 4]  108 	ld	a,l
   10CA D6 D0         [ 7]  109 	sub	a, #0xD0
   10CC 7C            [ 4]  110 	ld	a,h
   10CD DE 88         [ 7]  111 	sbc	a, #0x88
   10CF 38 05         [12]  112 	jr	C,00103$
                            113 ;src/Map.c:44: *m=CELLTYPE_WALL1;
   10D1 36 81         [10]  114 	ld	(hl),#0x81
                            115 ;src/Map.c:45: --m;
   10D3 2B            [ 6]  116 	dec	hl
   10D4 18 F3         [12]  117 	jr	00101$
   10D6                     118 00103$:
                            119 ;src/Map.c:48: for(i=1;i<KING_LEVEL_WIDTH-1;++i){
   10D6 0E 01         [ 7]  120 	ld	c,#0x01
                            121 ;src/Map.c:49: for(j=1;j<KING_LEVEL_HEIGHT-1;++j){
   10D8                     122 00124$:
   10D8 06 01         [ 7]  123 	ld	b,#0x01
   10DA                     124 00110$:
                            125 ;src/Map.c:50: map[j][i]=CELLTYPE_FLOOR;//get_random_wall();
   10DA 68            [ 4]  126 	ld	l,b
   10DB 26 00         [ 7]  127 	ld	h,#0x00
   10DD 29            [11]  128 	add	hl, hl
   10DE 29            [11]  129 	add	hl, hl
   10DF 29            [11]  130 	add	hl, hl
   10E0 29            [11]  131 	add	hl, hl
   10E1 29            [11]  132 	add	hl, hl
   10E2 11 D0 88      [10]  133 	ld	de,#0x88D0
   10E5 19            [11]  134 	add	hl,de
   10E6 59            [ 4]  135 	ld	e,c
   10E7 16 00         [ 7]  136 	ld	d,#0x00
   10E9 19            [11]  137 	add	hl,de
   10EA 36 00         [10]  138 	ld	(hl),#0x00
                            139 ;src/Map.c:49: for(j=1;j<KING_LEVEL_HEIGHT-1;++j){
   10EC 04            [ 4]  140 	inc	b
   10ED 78            [ 4]  141 	ld	a,b
   10EE D6 08         [ 7]  142 	sub	a, #0x08
   10F0 38 E8         [12]  143 	jr	C,00110$
                            144 ;src/Map.c:48: for(i=1;i<KING_LEVEL_WIDTH-1;++i){
   10F2 0C            [ 4]  145 	inc	c
   10F3 79            [ 4]  146 	ld	a,c
   10F4 D6 08         [ 7]  147 	sub	a, #0x08
   10F6 38 E0         [12]  148 	jr	C,00124$
                            149 ;src/Map.c:54: for(i=2;i<7;i+=2){
   10F8 0E 02         [ 7]  150 	ld	c,#0x02
   10FA                     151 00114$:
                            152 ;src/Map.c:55: map[i][2]=(cpct_getRandom_mxor_u8 ()%2)?CELLTYPE_WALL2:CELLTYPE_WALL3;//get_random_wall();
   10FA 69            [ 4]  153 	ld	l,c
   10FB 26 00         [ 7]  154 	ld	h,#0x00
   10FD 29            [11]  155 	add	hl, hl
   10FE 29            [11]  156 	add	hl, hl
   10FF 29            [11]  157 	add	hl, hl
   1100 29            [11]  158 	add	hl, hl
   1101 29            [11]  159 	add	hl, hl
   1102 11 D0 88      [10]  160 	ld	de, #0x88D0
   1105 19            [11]  161 	add	hl, de
   1106 5D            [ 4]  162 	ld	e,l
   1107 54            [ 4]  163 	ld	d,h
   1108 23            [ 6]  164 	inc	hl
   1109 23            [ 6]  165 	inc	hl
   110A E5            [11]  166 	push	hl
   110B C5            [11]  167 	push	bc
   110C D5            [11]  168 	push	de
   110D CD 71 7A      [17]  169 	call	_cpct_getRandom_mxor_u8
   1110 7D            [ 4]  170 	ld	a,l
   1111 D1            [10]  171 	pop	de
   1112 C1            [10]  172 	pop	bc
   1113 E1            [10]  173 	pop	hl
   1114 0F            [ 4]  174 	rrca
   1115 30 04         [12]  175 	jr	NC,00118$
   1117 06 82         [ 7]  176 	ld	b,#0x82
   1119 18 02         [12]  177 	jr	00119$
   111B                     178 00118$:
   111B 06 83         [ 7]  179 	ld	b,#0x83
   111D                     180 00119$:
   111D 70            [ 7]  181 	ld	(hl),b
                            182 ;src/Map.c:56: map[i][6]=(cpct_getRandom_mxor_u8 ()%2)?CELLTYPE_WALL2:CELLTYPE_WALL3;//get_random_wall();
   111E 21 06 00      [10]  183 	ld	hl,#0x0006
   1121 19            [11]  184 	add	hl,de
   1122 E5            [11]  185 	push	hl
   1123 C5            [11]  186 	push	bc
   1124 CD 71 7A      [17]  187 	call	_cpct_getRandom_mxor_u8
   1127 7D            [ 4]  188 	ld	a,l
   1128 C1            [10]  189 	pop	bc
   1129 E1            [10]  190 	pop	hl
   112A 0F            [ 4]  191 	rrca
   112B 30 04         [12]  192 	jr	NC,00120$
   112D 06 82         [ 7]  193 	ld	b,#0x82
   112F 18 02         [12]  194 	jr	00121$
   1131                     195 00120$:
   1131 06 83         [ 7]  196 	ld	b,#0x83
   1133                     197 00121$:
   1133 70            [ 7]  198 	ld	(hl),b
                            199 ;src/Map.c:54: for(i=2;i<7;i+=2){
   1134 0C            [ 4]  200 	inc	c
   1135 0C            [ 4]  201 	inc	c
   1136 79            [ 4]  202 	ld	a,c
   1137 D6 07         [ 7]  203 	sub	a, #0x07
   1139 38 BF         [12]  204 	jr	C,00114$
                            205 ;src/Map.c:59: map[KING_LEVEL_EXIT_Y][KING_LEVEL_EXIT_X] = CELLTYPE_DOOR;
   113B 21 D4 88      [10]  206 	ld	hl,#0x88D4
   113E 36 80         [10]  207 	ld	(hl),#0x80
                            208 ;src/Map.c:62: while(player_get_direction_index()!=MOVEMENT_NORTH){
   1140                     209 00107$:
   1140 CD 9D 18      [17]  210 	call	_player_get_direction_index
   1143 7D            [ 4]  211 	ld	a,l
   1144 D6 02         [ 7]  212 	sub	a, #0x02
   1146 28 05         [12]  213 	jr	Z,00109$
                            214 ;src/Map.c:63: player_turn_left();
   1148 CD 30 18      [17]  215 	call	_player_turn_left
   114B 18 F3         [12]  216 	jr	00107$
   114D                     217 00109$:
                            218 ;src/Map.c:66: *(i8*)&(player_position.x) = KING_LEVEL_PLAYER_X;
   114D 21 2C 18      [10]  219 	ld	hl,#_player_position
   1150 36 04         [10]  220 	ld	(hl),#0x04
                            221 ;src/Map.c:67: *(i8*)&(player_position.y) = KING_LEVEL_PLAYER_Y;
   1152 21 2D 18      [10]  222 	ld	hl,#(_player_position + 0x0001)
   1155 36 07         [10]  223 	ld	(hl),#0x07
   1157 C9            [10]  224 	ret
                            225 ;src/Map.c:71: void generate_map(){
                            226 ;	---------------------------------
                            227 ; Function generate_map
                            228 ; ---------------------------------
   1158                     229 _generate_map::
   1158 DD E5         [15]  230 	push	ix
   115A DD 21 00 00   [14]  231 	ld	ix,#0
   115E DD 39         [15]  232 	add	ix,sp
   1160 21 EC FF      [10]  233 	ld	hl,#-20
   1163 39            [11]  234 	add	hl,sp
   1164 F9            [ 6]  235 	ld	sp,hl
                            236 ;src/Map.c:74: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
   1165 DD 36 F2 83   [19]  237 	ld	-14 (ix),#0x83
   1169 DD 36 F3 03   [19]  238 	ld	-13 (ix),#0x03
                            239 ;src/Map.c:80: u16 wallListCount = 0;
   116D DD 36 EE 00   [19]  240 	ld	-18 (ix),#0x00
   1171 DD 36 EF 00   [19]  241 	ld	-17 (ix),#0x00
                            242 ;src/Map.c:81: u16 lastStackItem = 0;
   1175 21 00 00      [10]  243 	ld	hl,#0x0000
   1178 E3            [19]  244 	ex	(sp), hl
                            245 ;src/Map.c:83: cpct_memset (GENERATOR_DATA_PTR, 0, 4096);
   1179 21 00 10      [10]  246 	ld	hl,#0x1000
   117C E5            [11]  247 	push	hl
   117D AF            [ 4]  248 	xor	a, a
   117E F5            [11]  249 	push	af
   117F 33            [ 6]  250 	inc	sp
   1180 21 D0 8C      [10]  251 	ld	hl,#0x8CD0
   1183 E5            [11]  252 	push	hl
   1184 CD 74 7B      [17]  253 	call	_cpct_memset
                            254 ;src/Map.c:85: (*cellStack).x = (cpct_getRandom_mxor_u8 ()%(MAP_WIDTH-2))+1; //RANDOM
   1187 CD 71 7A      [17]  255 	call	_cpct_getRandom_mxor_u8
   118A 45            [ 4]  256 	ld	b,l
   118B 3E 1E         [ 7]  257 	ld	a,#0x1E
   118D F5            [11]  258 	push	af
   118E 33            [ 6]  259 	inc	sp
   118F C5            [11]  260 	push	bc
   1190 33            [ 6]  261 	inc	sp
   1191 CD 13 7A      [17]  262 	call	__moduchar
   1194 F1            [10]  263 	pop	af
   1195 4D            [ 4]  264 	ld	c,l
   1196 0C            [ 4]  265 	inc	c
   1197 21 D0 8C      [10]  266 	ld	hl,#0x8CD0
   119A 71            [ 7]  267 	ld	(hl),c
                            268 ;src/Map.c:86: (*cellStack).y = (cpct_getRandom_mxor_u8 ()%(MAP_HEIGHT-2))+1; //RANDOM
   119B CD 71 7A      [17]  269 	call	_cpct_getRandom_mxor_u8
   119E 45            [ 4]  270 	ld	b,l
   119F 3E 1E         [ 7]  271 	ld	a,#0x1E
   11A1 F5            [11]  272 	push	af
   11A2 33            [ 6]  273 	inc	sp
   11A3 C5            [11]  274 	push	bc
   11A4 33            [ 6]  275 	inc	sp
   11A5 CD 13 7A      [17]  276 	call	__moduchar
   11A8 F1            [10]  277 	pop	af
   11A9 4D            [ 4]  278 	ld	c,l
   11AA 0C            [ 4]  279 	inc	c
   11AB 21 D1 8C      [10]  280 	ld	hl,#0x8CD1
   11AE 71            [ 7]  281 	ld	(hl),c
                            282 ;src/Map.c:88: rotatePlayer = cpct_getRandom_mxor_u8 ()%4;
   11AF CD 71 7A      [17]  283 	call	_cpct_getRandom_mxor_u8
   11B2 7D            [ 4]  284 	ld	a,l
   11B3 E6 03         [ 7]  285 	and	a, #0x03
   11B5 4F            [ 4]  286 	ld	c,a
                            287 ;src/Map.c:89: while(rotatePlayer){
   11B6                     288 00101$:
   11B6 79            [ 4]  289 	ld	a,c
   11B7 B7            [ 4]  290 	or	a, a
   11B8 28 08         [12]  291 	jr	Z,00103$
                            292 ;src/Map.c:90: player_turn_left();
   11BA C5            [11]  293 	push	bc
   11BB CD 30 18      [17]  294 	call	_player_turn_left
   11BE C1            [10]  295 	pop	bc
                            296 ;src/Map.c:91: --rotatePlayer;
   11BF 0D            [ 4]  297 	dec	c
   11C0 18 F4         [12]  298 	jr	00101$
   11C2                     299 00103$:
                            300 ;src/Map.c:94: *(i8*)&(player_position.x) = (*cellStack).y;
   11C2 01 2C 18      [10]  301 	ld	bc,#_player_position+0
   11C5 3A D1 8C      [13]  302 	ld	a,(#0x8CD1)
   11C8 02            [ 7]  303 	ld	(bc),a
                            304 ;src/Map.c:95: *(i8*)&(player_position.y) = (*cellStack).x;
   11C9 01 2D 18      [10]  305 	ld	bc,#_player_position+1
   11CC 3A D0 8C      [13]  306 	ld	a,(#0x8CD0)
   11CF 02            [ 7]  307 	ld	(bc),a
                            308 ;src/Map.c:97: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   11D0 21 00 04      [10]  309 	ld	hl,#0x0400
   11D3 E5            [11]  310 	push	hl
   11D4 3E 87         [ 7]  311 	ld	a,#0x87
   11D6 F5            [11]  312 	push	af
   11D7 33            [ 6]  313 	inc	sp
   11D8 21 D0 88      [10]  314 	ld	hl,#0x88D0
   11DB E5            [11]  315 	push	hl
   11DC CD 74 7B      [17]  316 	call	_cpct_memset
                            317 ;src/Map.c:100: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   11DF 21 D0 8C      [10]  318 	ld	hl,#0x8CD0
   11E2 6E            [ 7]  319 	ld	l,(hl)
   11E3 26 00         [ 7]  320 	ld	h,#0x00
   11E5 29            [11]  321 	add	hl, hl
   11E6 29            [11]  322 	add	hl, hl
   11E7 29            [11]  323 	add	hl, hl
   11E8 29            [11]  324 	add	hl, hl
   11E9 29            [11]  325 	add	hl, hl
   11EA 01 D0 88      [10]  326 	ld	bc,#0x88D0
   11ED 09            [11]  327 	add	hl,bc
   11EE 4D            [ 4]  328 	ld	c,l
   11EF 44            [ 4]  329 	ld	b,h
   11F0 21 D1 8C      [10]  330 	ld	hl,#0x8CD1
   11F3 6E            [ 7]  331 	ld	l, (hl)
   11F4 26 00         [ 7]  332 	ld	h,#0x00
   11F6 09            [11]  333 	add	hl,bc
   11F7 36 00         [10]  334 	ld	(hl),#0x00
                            335 ;src/Map.c:103: for(i=0;i<MAP_WIDTH;++i){
   11F9 0E 00         [ 7]  336 	ld	c,#0x00
   11FB                     337 00170$:
                            338 ;src/Map.c:104: map[0][i]=CELLTYPE_WALL1;//get_random_wall();
   11FB 21 D0 88      [10]  339 	ld	hl,#0x88D0
   11FE 06 00         [ 7]  340 	ld	b,#0x00
   1200 09            [11]  341 	add	hl, bc
   1201 36 81         [10]  342 	ld	(hl),#0x81
                            343 ;src/Map.c:105: map[MAP_HEIGHT-1][i]=CELLTYPE_WALL1;//get_random_wall();
   1203 21 B0 8C      [10]  344 	ld	hl,#0x8CB0
   1206 06 00         [ 7]  345 	ld	b,#0x00
   1208 09            [11]  346 	add	hl, bc
   1209 36 81         [10]  347 	ld	(hl),#0x81
                            348 ;src/Map.c:103: for(i=0;i<MAP_WIDTH;++i){
   120B 0C            [ 4]  349 	inc	c
   120C 79            [ 4]  350 	ld	a,c
   120D D6 20         [ 7]  351 	sub	a, #0x20
   120F 38 EA         [12]  352 	jr	C,00170$
                            353 ;src/Map.c:108: for(i=0;i<MAP_HEIGHT-1;++i){
   1211 0E 00         [ 7]  354 	ld	c,#0x00
   1213                     355 00172$:
                            356 ;src/Map.c:109: map[i][0]=CELLTYPE_WALL1;//get_random_wall();
   1213 69            [ 4]  357 	ld	l,c
   1214 26 00         [ 7]  358 	ld	h,#0x00
   1216 29            [11]  359 	add	hl, hl
   1217 29            [11]  360 	add	hl, hl
   1218 29            [11]  361 	add	hl, hl
   1219 29            [11]  362 	add	hl, hl
   121A 29            [11]  363 	add	hl, hl
   121B EB            [ 4]  364 	ex	de,hl
   121C 21 D0 88      [10]  365 	ld	hl,#0x88D0
   121F 19            [11]  366 	add	hl,de
   1220 36 81         [10]  367 	ld	(hl),#0x81
                            368 ;src/Map.c:110: map[i][MAP_WIDTH-1]=CELLTYPE_WALL1;//get_random_wall();
   1222 21 D0 88      [10]  369 	ld	hl,#0x88D0
   1225 19            [11]  370 	add	hl,de
   1226 11 1F 00      [10]  371 	ld	de,#0x001F
   1229 19            [11]  372 	add	hl,de
   122A 36 81         [10]  373 	ld	(hl),#0x81
                            374 ;src/Map.c:108: for(i=0;i<MAP_HEIGHT-1;++i){
   122C 0C            [ 4]  375 	inc	c
   122D 79            [ 4]  376 	ld	a,c
   122E D6 1F         [ 7]  377 	sub	a, #0x1F
   1230 38 E1         [12]  378 	jr	C,00172$
                            379 ;src/Map.c:113: while(remainingCells>0){
   1232 21 04 00      [10]  380 	ld	hl,#0x0004
   1235 39            [11]  381 	add	hl,sp
   1236 DD 75 FA      [19]  382 	ld	-6 (ix),l
   1239 DD 74 FB      [19]  383 	ld	-5 (ix),h
   123C                     384 00167$:
   123C DD 7E F3      [19]  385 	ld	a,-13 (ix)
   123F DD B6 F2      [19]  386 	or	a,-14 (ix)
   1242 CA 0B 16      [10]  387 	jp	Z,00174$
                            388 ;src/Map.c:114: wallListPosition = wallList+wallListCount;
   1245 C1            [10]  389 	pop	bc
   1246 E1            [10]  390 	pop	hl
   1247 E5            [11]  391 	push	hl
   1248 C5            [11]  392 	push	bc
   1249 29            [11]  393 	add	hl, hl
   124A 7D            [ 4]  394 	ld	a,l
   124B C6 D0         [ 7]  395 	add	a, #0xD0
   124D DD 77 FC      [19]  396 	ld	-4 (ix),a
   1250 7C            [ 4]  397 	ld	a,h
   1251 CE 90         [ 7]  398 	adc	a, #0x90
   1253 DD 77 FD      [19]  399 	ld	-3 (ix),a
                            400 ;src/Map.c:115: while(wallListCount<MAP_SIZE){
   1256 D1            [10]  401 	pop	de
   1257 C1            [10]  402 	pop	bc
   1258 C5            [11]  403 	push	bc
   1259 D5            [11]  404 	push	de
   125A                     405 00137$:
                            406 ;src/Map.c:118: currentPos.y = (*wallListPosition).y;
   125A DD 7E FA      [19]  407 	ld	a,-6 (ix)
   125D C6 01         [ 7]  408 	add	a, #0x01
   125F DD 77 FE      [19]  409 	ld	-2 (ix),a
   1262 DD 7E FB      [19]  410 	ld	a,-5 (ix)
   1265 CE 00         [ 7]  411 	adc	a, #0x00
   1267 DD 77 FF      [19]  412 	ld	-1 (ix),a
                            413 ;src/Map.c:115: while(wallListCount<MAP_SIZE){
   126A 78            [ 4]  414 	ld	a,b
   126B D6 04         [ 7]  415 	sub	a, #0x04
   126D D2 0C 14      [10]  416 	jp	NC,00209$
                            417 ;src/Map.c:117: currentPos.x = (*wallListPosition).x;
   1270 21 04 00      [10]  418 	ld	hl,#0x0004
   1273 39            [11]  419 	add	hl,sp
   1274 EB            [ 4]  420 	ex	de,hl
   1275 DD 6E FC      [19]  421 	ld	l,-4 (ix)
   1278 DD 66 FD      [19]  422 	ld	h,-3 (ix)
   127B 7E            [ 7]  423 	ld	a,(hl)
   127C 12            [ 7]  424 	ld	(de),a
                            425 ;src/Map.c:118: currentPos.y = (*wallListPosition).y;
   127D DD 5E FC      [19]  426 	ld	e,-4 (ix)
   1280 DD 56 FD      [19]  427 	ld	d,-3 (ix)
   1283 13            [ 6]  428 	inc	de
   1284 1A            [ 7]  429 	ld	a,(de)
   1285 DD 6E FE      [19]  430 	ld	l,-2 (ix)
   1288 DD 66 FF      [19]  431 	ld	h,-1 (ix)
   128B 77            [ 7]  432 	ld	(hl),a
                            433 ;src/Map.c:120: convertToFloor=0;
   128C DD 36 F4 00   [19]  434 	ld	-12 (ix),#0x00
                            435 ;src/Map.c:121: surroundedByWalls=1;
   1290 DD 36 F5 01   [19]  436 	ld	-11 (ix),#0x01
                            437 ;src/Map.c:123: if(currentPos.x>0){
   1294 DD 6E FA      [19]  438 	ld	l,-6 (ix)
   1297 DD 66 FB      [19]  439 	ld	h,-5 (ix)
   129A 7E            [ 7]  440 	ld	a,(hl)
   129B DD 77 F8      [19]  441 	ld	-8 (ix),a
                            442 ;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
   129E DD 6E FE      [19]  443 	ld	l,-2 (ix)
   12A1 DD 66 FF      [19]  444 	ld	h,-1 (ix)
   12A4 7E            [ 7]  445 	ld	a,(hl)
   12A5 DD 77 F9      [19]  446 	ld	-7 (ix),a
   12A8 DD 7E F8      [19]  447 	ld	a,-8 (ix)
   12AB DD 77 F6      [19]  448 	ld	-10 (ix),a
   12AE DD 36 F7 00   [19]  449 	ld	-9 (ix),#0x00
                            450 ;src/Map.c:123: if(currentPos.x>0){
   12B2 DD 7E F8      [19]  451 	ld	a,-8 (ix)
   12B5 B7            [ 4]  452 	or	a, a
   12B6 28 2F         [12]  453 	jr	Z,00112$
                            454 ;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
   12B8 DD 6E F6      [19]  455 	ld	l,-10 (ix)
   12BB DD 66 F7      [19]  456 	ld	h,-9 (ix)
   12BE 2B            [ 6]  457 	dec	hl
   12BF 29            [11]  458 	add	hl, hl
   12C0 29            [11]  459 	add	hl, hl
   12C1 29            [11]  460 	add	hl, hl
   12C2 29            [11]  461 	add	hl, hl
   12C3 29            [11]  462 	add	hl, hl
   12C4 D5            [11]  463 	push	de
   12C5 11 D0 88      [10]  464 	ld	de,#0x88D0
   12C8 19            [11]  465 	add	hl, de
   12C9 D1            [10]  466 	pop	de
   12CA 7D            [ 4]  467 	ld	a,l
   12CB DD 86 F9      [19]  468 	add	a, -7 (ix)
   12CE 6F            [ 4]  469 	ld	l,a
   12CF 7C            [ 4]  470 	ld	a,h
   12D0 CE 00         [ 7]  471 	adc	a, #0x00
   12D2 67            [ 4]  472 	ld	h,a
   12D3 6E            [ 7]  473 	ld	l,(hl)
                            474 ;src/Map.c:125: if(adjacentType == CELLTYPE_UNDEFINED){
   12D4 7D            [ 4]  475 	ld	a,l
   12D5 D6 87         [ 7]  476 	sub	a, #0x87
   12D7 20 06         [12]  477 	jr	NZ,00109$
                            478 ;src/Map.c:126: convertToFloor  = 1;
   12D9 DD 36 F4 01   [19]  479 	ld	-12 (ix),#0x01
   12DD 18 08         [12]  480 	jr	00112$
   12DF                     481 00109$:
                            482 ;src/Map.c:128: else if(adjacentType == CELLTYPE_FLOOR){
   12DF 7D            [ 4]  483 	ld	a,l
   12E0 B7            [ 4]  484 	or	a, a
   12E1 20 04         [12]  485 	jr	NZ,00112$
                            486 ;src/Map.c:129: surroundedByWalls = 0;
   12E3 DD 36 F5 00   [19]  487 	ld	-11 (ix),#0x00
   12E7                     488 00112$:
                            489 ;src/Map.c:132: if(currentPos.x < (MAP_WIDTH-1)){
   12E7 DD 7E F8      [19]  490 	ld	a,-8 (ix)
   12EA D6 1F         [ 7]  491 	sub	a, #0x1F
   12EC 30 2F         [12]  492 	jr	NC,00119$
                            493 ;src/Map.c:134: adjacentType = map[currentPos.x+1][currentPos.y];
   12EE DD 6E F6      [19]  494 	ld	l,-10 (ix)
   12F1 DD 66 F7      [19]  495 	ld	h,-9 (ix)
   12F4 23            [ 6]  496 	inc	hl
   12F5 29            [11]  497 	add	hl, hl
   12F6 29            [11]  498 	add	hl, hl
   12F7 29            [11]  499 	add	hl, hl
   12F8 29            [11]  500 	add	hl, hl
   12F9 29            [11]  501 	add	hl, hl
   12FA D5            [11]  502 	push	de
   12FB 11 D0 88      [10]  503 	ld	de,#0x88D0
   12FE 19            [11]  504 	add	hl, de
   12FF D1            [10]  505 	pop	de
   1300 7D            [ 4]  506 	ld	a,l
   1301 DD 86 F9      [19]  507 	add	a, -7 (ix)
   1304 6F            [ 4]  508 	ld	l,a
   1305 7C            [ 4]  509 	ld	a,h
   1306 CE 00         [ 7]  510 	adc	a, #0x00
   1308 67            [ 4]  511 	ld	h,a
   1309 6E            [ 7]  512 	ld	l,(hl)
                            513 ;src/Map.c:135: if(adjacentType == CELLTYPE_UNDEFINED){
   130A 7D            [ 4]  514 	ld	a,l
   130B D6 87         [ 7]  515 	sub	a, #0x87
   130D 20 06         [12]  516 	jr	NZ,00116$
                            517 ;src/Map.c:136: convertToFloor  = 1;
   130F DD 36 F4 01   [19]  518 	ld	-12 (ix),#0x01
   1313 18 08         [12]  519 	jr	00119$
   1315                     520 00116$:
                            521 ;src/Map.c:138: else if(adjacentType == CELLTYPE_FLOOR){
   1315 7D            [ 4]  522 	ld	a,l
   1316 B7            [ 4]  523 	or	a, a
   1317 20 04         [12]  524 	jr	NZ,00119$
                            525 ;src/Map.c:139: surroundedByWalls = 0;
   1319 DD 36 F5 00   [19]  526 	ld	-11 (ix),#0x00
   131D                     527 00119$:
                            528 ;src/Map.c:144: adjacentType = map[currentPos.x][currentPos.y-1];
   131D DD 6E F6      [19]  529 	ld	l,-10 (ix)
   1320 DD 66 F7      [19]  530 	ld	h,-9 (ix)
   1323 29            [11]  531 	add	hl, hl
   1324 29            [11]  532 	add	hl, hl
   1325 29            [11]  533 	add	hl, hl
   1326 29            [11]  534 	add	hl, hl
   1327 29            [11]  535 	add	hl, hl
   1328 7D            [ 4]  536 	ld	a,l
   1329 C6 D0         [ 7]  537 	add	a, #0xD0
   132B DD 77 F6      [19]  538 	ld	-10 (ix),a
   132E 7C            [ 4]  539 	ld	a,h
   132F CE 88         [ 7]  540 	adc	a, #0x88
   1331 DD 77 F7      [19]  541 	ld	-9 (ix),a
                            542 ;src/Map.c:142: if(currentPos.y > 0){
   1334 DD 7E F9      [19]  543 	ld	a,-7 (ix)
   1337 B7            [ 4]  544 	or	a, a
   1338 28 23         [12]  545 	jr	Z,00126$
                            546 ;src/Map.c:144: adjacentType = map[currentPos.x][currentPos.y-1];
   133A DD 6E F9      [19]  547 	ld	l,-7 (ix)
   133D 2D            [ 4]  548 	dec	l
   133E DD 7E F6      [19]  549 	ld	a,-10 (ix)
   1341 85            [ 4]  550 	add	a, l
   1342 6F            [ 4]  551 	ld	l,a
   1343 DD 7E F7      [19]  552 	ld	a,-9 (ix)
   1346 CE 00         [ 7]  553 	adc	a, #0x00
   1348 67            [ 4]  554 	ld	h,a
   1349 6E            [ 7]  555 	ld	l,(hl)
                            556 ;src/Map.c:145: if(adjacentType == CELLTYPE_UNDEFINED){
   134A 7D            [ 4]  557 	ld	a,l
   134B D6 87         [ 7]  558 	sub	a, #0x87
   134D 20 06         [12]  559 	jr	NZ,00123$
                            560 ;src/Map.c:146: convertToFloor  = 1;
   134F DD 36 F4 01   [19]  561 	ld	-12 (ix),#0x01
   1353 18 08         [12]  562 	jr	00126$
   1355                     563 00123$:
                            564 ;src/Map.c:148: else if(adjacentType == CELLTYPE_FLOOR){
   1355 7D            [ 4]  565 	ld	a,l
   1356 B7            [ 4]  566 	or	a, a
   1357 20 04         [12]  567 	jr	NZ,00126$
                            568 ;src/Map.c:149: surroundedByWalls = 0;
   1359 DD 36 F5 00   [19]  569 	ld	-11 (ix),#0x00
   135D                     570 00126$:
                            571 ;src/Map.c:152: if(currentPos.y < (MAP_HEIGHT-1)){
   135D DD 7E F9      [19]  572 	ld	a,-7 (ix)
   1360 D6 1F         [ 7]  573 	sub	a, #0x1F
   1362 30 23         [12]  574 	jr	NC,00133$
                            575 ;src/Map.c:154: adjacentType = map[currentPos.x][currentPos.y+1];
   1364 DD 6E F9      [19]  576 	ld	l,-7 (ix)
   1367 2C            [ 4]  577 	inc	l
   1368 DD 7E F6      [19]  578 	ld	a,-10 (ix)
   136B 85            [ 4]  579 	add	a, l
   136C 6F            [ 4]  580 	ld	l,a
   136D DD 7E F7      [19]  581 	ld	a,-9 (ix)
   1370 CE 00         [ 7]  582 	adc	a, #0x00
   1372 67            [ 4]  583 	ld	h,a
   1373 6E            [ 7]  584 	ld	l,(hl)
                            585 ;src/Map.c:155: if(adjacentType == CELLTYPE_UNDEFINED){
   1374 7D            [ 4]  586 	ld	a,l
   1375 D6 87         [ 7]  587 	sub	a, #0x87
   1377 20 06         [12]  588 	jr	NZ,00130$
                            589 ;src/Map.c:156: convertToFloor  = 1;
   1379 DD 36 F4 01   [19]  590 	ld	-12 (ix),#0x01
   137D 18 08         [12]  591 	jr	00133$
   137F                     592 00130$:
                            593 ;src/Map.c:158: else if(adjacentType == CELLTYPE_FLOOR){
   137F 7D            [ 4]  594 	ld	a,l
   1380 B7            [ 4]  595 	or	a, a
   1381 20 04         [12]  596 	jr	NZ,00133$
                            597 ;src/Map.c:159: surroundedByWalls = 0;
   1383 DD 36 F5 00   [19]  598 	ld	-11 (ix),#0x00
   1387                     599 00133$:
                            600 ;src/Map.c:163: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   1387 69            [ 4]  601 	ld	l, c
   1388 60            [ 4]  602 	ld	h, b
   1389 29            [11]  603 	add	hl, hl
   138A FD 21 D0 90   [14]  604 	ld	iy,#0x90D0
   138E C5            [11]  605 	push	bc
   138F 4D            [ 4]  606 	ld	c, l
   1390 44            [ 4]  607 	ld	b, h
   1391 FD 09         [15]  608 	add	iy, bc
   1393 C1            [10]  609 	pop	bc
   1394 FD 7E 00      [19]  610 	ld	a, 0 (iy)
   1397 DD 6E FC      [19]  611 	ld	l,-4 (ix)
   139A DD 66 FD      [19]  612 	ld	h,-3 (ix)
   139D 77            [ 7]  613 	ld	(hl),a
                            614 ;src/Map.c:164: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   139E FD E5         [15]  615 	push	iy
   13A0 E1            [10]  616 	pop	hl
   13A1 23            [ 6]  617 	inc	hl
   13A2 7E            [ 7]  618 	ld	a,(hl)
   13A3 12            [ 7]  619 	ld	(de),a
                            620 ;src/Map.c:165: --wallListCount;
   13A4 0B            [ 6]  621 	dec	bc
   13A5 DD 71 EE      [19]  622 	ld	-18 (ix),c
   13A8 DD 70 EF      [19]  623 	ld	-17 (ix),b
                            624 ;src/Map.c:168: if((convertToFloor)&&(!surroundedByWalls)){
   13AB DD 7E F4      [19]  625 	ld	a,-12 (ix)
   13AE B7            [ 4]  626 	or	a, a
   13AF 28 4A         [12]  627 	jr	Z,00135$
   13B1 DD 7E F5      [19]  628 	ld	a,-11 (ix)
   13B4 B7            [ 4]  629 	or	a, a
   13B5 20 44         [12]  630 	jr	NZ,00135$
                            631 ;src/Map.c:169: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   13B7 DD 6E FA      [19]  632 	ld	l,-6 (ix)
   13BA DD 66 FB      [19]  633 	ld	h,-5 (ix)
   13BD 6E            [ 7]  634 	ld	l,(hl)
   13BE 26 00         [ 7]  635 	ld	h,#0x00
   13C0 29            [11]  636 	add	hl, hl
   13C1 29            [11]  637 	add	hl, hl
   13C2 29            [11]  638 	add	hl, hl
   13C3 29            [11]  639 	add	hl, hl
   13C4 29            [11]  640 	add	hl, hl
   13C5 01 D0 88      [10]  641 	ld	bc,#0x88D0
   13C8 09            [11]  642 	add	hl,bc
   13C9 4D            [ 4]  643 	ld	c,l
   13CA 44            [ 4]  644 	ld	b,h
   13CB DD 6E FE      [19]  645 	ld	l,-2 (ix)
   13CE DD 66 FF      [19]  646 	ld	h,-1 (ix)
   13D1 6E            [ 7]  647 	ld	l, (hl)
   13D2 26 00         [ 7]  648 	ld	h,#0x00
   13D4 09            [11]  649 	add	hl,bc
   13D5 36 00         [10]  650 	ld	(hl),#0x00
                            651 ;src/Map.c:171: ++lastStackItem;
   13D7 DD 34 EC      [23]  652 	inc	-20 (ix)
   13DA 20 03         [12]  653 	jr	NZ,00334$
   13DC DD 34 ED      [23]  654 	inc	-19 (ix)
   13DF                     655 00334$:
                            656 ;src/Map.c:172: (*(cellStack+lastStackItem)).x = currentPos.x;
   13DF E1            [10]  657 	pop	hl
   13E0 E5            [11]  658 	push	hl
   13E1 29            [11]  659 	add	hl, hl
   13E2 01 D0 8C      [10]  660 	ld	bc, #0x8CD0
   13E5 09            [11]  661 	add	hl,bc
   13E6 4D            [ 4]  662 	ld	c, l
   13E7 44            [ 4]  663 	ld	b, h
   13E8 DD 6E FA      [19]  664 	ld	l,-6 (ix)
   13EB DD 66 FB      [19]  665 	ld	h,-5 (ix)
   13EE 7E            [ 7]  666 	ld	a,(hl)
   13EF 02            [ 7]  667 	ld	(bc),a
                            668 ;src/Map.c:173: (*(cellStack+lastStackItem)).y = currentPos.y;
   13F0 03            [ 6]  669 	inc	bc
   13F1 DD 6E FE      [19]  670 	ld	l,-2 (ix)
   13F4 DD 66 FF      [19]  671 	ld	h,-1 (ix)
   13F7 7E            [ 7]  672 	ld	a,(hl)
   13F8 02            [ 7]  673 	ld	(bc),a
                            674 ;src/Map.c:176: break;
   13F9 18 11         [12]  675 	jr	00209$
   13FB                     676 00135$:
                            677 ;src/Map.c:178: --wallListPosition;
   13FB DD 6E FC      [19]  678 	ld	l,-4 (ix)
   13FE DD 66 FD      [19]  679 	ld	h,-3 (ix)
   1401 2B            [ 6]  680 	dec	hl
   1402 2B            [ 6]  681 	dec	hl
   1403 DD 75 FC      [19]  682 	ld	-4 (ix),l
   1406 DD 74 FD      [19]  683 	ld	-3 (ix),h
   1409 C3 5A 12      [10]  684 	jp	00137$
                            685 ;src/Map.c:180: while(lastStackItem<MAP_SIZE){
   140C                     686 00209$:
   140C DD 7E F2      [19]  687 	ld	a,-14 (ix)
   140F DD 77 F6      [19]  688 	ld	-10 (ix),a
   1412 DD 7E F3      [19]  689 	ld	a,-13 (ix)
   1415 DD 77 F7      [19]  690 	ld	-9 (ix),a
   1418 DD 7E EE      [19]  691 	ld	a,-18 (ix)
   141B DD 77 FC      [19]  692 	ld	-4 (ix),a
   141E DD 7E EF      [19]  693 	ld	a,-17 (ix)
   1421 DD 77 FD      [19]  694 	ld	-3 (ix),a
   1424                     695 00164$:
   1424 DD 7E ED      [19]  696 	ld	a,-19 (ix)
   1427 D6 04         [ 7]  697 	sub	a, #0x04
   1429 D2 3C 12      [10]  698 	jp	NC,00167$
                            699 ;src/Map.c:181: currentPos.x=(*(lastStackItem+cellStack)).x;
   142C 21 04 00      [10]  700 	ld	hl,#0x0004
   142F 39            [11]  701 	add	hl,sp
   1430 4D            [ 4]  702 	ld	c,l
   1431 44            [ 4]  703 	ld	b,h
   1432 E1            [10]  704 	pop	hl
   1433 E5            [11]  705 	push	hl
   1434 29            [11]  706 	add	hl, hl
   1435 FD 21 D0 8C   [14]  707 	ld	iy,#0x8CD0
   1439 EB            [ 4]  708 	ex	de,hl
   143A FD 19         [15]  709 	add	iy, de
   143C FD 7E 00      [19]  710 	ld	a, 0 (iy)
   143F 02            [ 7]  711 	ld	(bc),a
                            712 ;src/Map.c:182: currentPos.y=(*(lastStackItem+cellStack)).y;
   1440 FD 4E 01      [19]  713 	ld	c,1 (iy)
   1443 DD 6E FE      [19]  714 	ld	l,-2 (ix)
   1446 DD 66 FF      [19]  715 	ld	h,-1 (ix)
   1449 71            [ 7]  716 	ld	(hl),c
                            717 ;src/Map.c:183: --lastStackItem;
   144A E1            [10]  718 	pop	hl
   144B E5            [11]  719 	push	hl
   144C 2B            [ 6]  720 	dec	hl
   144D E3            [19]  721 	ex	(sp), hl
                            722 ;src/Map.c:184: cellType = map[currentPos.x][currentPos.y];
   144E DD 6E FA      [19]  723 	ld	l,-6 (ix)
   1451 DD 66 FB      [19]  724 	ld	h,-5 (ix)
   1454 6E            [ 7]  725 	ld	l,(hl)
   1455 26 00         [ 7]  726 	ld	h,#0x00
   1457 29            [11]  727 	add	hl, hl
   1458 29            [11]  728 	add	hl, hl
   1459 29            [11]  729 	add	hl, hl
   145A 29            [11]  730 	add	hl, hl
   145B 29            [11]  731 	add	hl, hl
   145C 11 D0 88      [10]  732 	ld	de,#0x88D0
   145F 19            [11]  733 	add	hl,de
   1460 59            [ 4]  734 	ld	e,c
   1461 16 00         [ 7]  735 	ld	d,#0x00
   1463 19            [11]  736 	add	hl,de
   1464 4E            [ 7]  737 	ld	c,(hl)
                            738 ;src/Map.c:186: if(cellType == CELLTYPE_UNDEFINED){
   1465 79            [ 4]  739 	ld	a,c
   1466 D6 87         [ 7]  740 	sub	a, #0x87
   1468 20 47         [12]  741 	jr	NZ,00144$
                            742 ;src/Map.c:188: if(cpct_getRandom_mxor_u8 ()&1){//WALL
   146A CD 71 7A      [17]  743 	call	_cpct_getRandom_mxor_u8
   146D CB 45         [ 8]  744 	bit	0, l
   146F 28 06         [12]  745 	jr	Z,00141$
                            746 ;src/Map.c:189: cellType = get_random_wall();
   1471 CD A9 10      [17]  747 	call	_get_random_wall
   1474 4D            [ 4]  748 	ld	c,l
   1475 18 02         [12]  749 	jr	00142$
   1477                     750 00141$:
                            751 ;src/Map.c:192: cellType = CELLTYPE_FLOOR;
   1477 0E 00         [ 7]  752 	ld	c,#0x00
   1479                     753 00142$:
                            754 ;src/Map.c:194: map[currentPos.x][currentPos.y]=cellType;
   1479 DD 6E FA      [19]  755 	ld	l,-6 (ix)
   147C DD 66 FB      [19]  756 	ld	h,-5 (ix)
   147F 6E            [ 7]  757 	ld	l,(hl)
   1480 26 00         [ 7]  758 	ld	h,#0x00
   1482 29            [11]  759 	add	hl, hl
   1483 29            [11]  760 	add	hl, hl
   1484 29            [11]  761 	add	hl, hl
   1485 29            [11]  762 	add	hl, hl
   1486 29            [11]  763 	add	hl, hl
   1487 EB            [ 4]  764 	ex	de,hl
   1488 21 D0 88      [10]  765 	ld	hl,#0x88D0
   148B 19            [11]  766 	add	hl,de
   148C EB            [ 4]  767 	ex	de,hl
   148D DD 6E FE      [19]  768 	ld	l,-2 (ix)
   1490 DD 66 FF      [19]  769 	ld	h,-1 (ix)
   1493 6E            [ 7]  770 	ld	l, (hl)
   1494 26 00         [ 7]  771 	ld	h,#0x00
   1496 19            [11]  772 	add	hl,de
   1497 71            [ 7]  773 	ld	(hl),c
                            774 ;src/Map.c:195: --remainingCells;
   1498 DD 6E F6      [19]  775 	ld	l,-10 (ix)
   149B DD 66 F7      [19]  776 	ld	h,-9 (ix)
   149E 2B            [ 6]  777 	dec	hl
   149F DD 75 F6      [19]  778 	ld	-10 (ix),l
   14A2 DD 74 F7      [19]  779 	ld	-9 (ix),h
   14A5 DD 7E F6      [19]  780 	ld	a,-10 (ix)
   14A8 DD 77 F2      [19]  781 	ld	-14 (ix),a
   14AB DD 7E F7      [19]  782 	ld	a,-9 (ix)
   14AE DD 77 F3      [19]  783 	ld	-13 (ix),a
   14B1                     784 00144$:
                            785 ;src/Map.c:123: if(currentPos.x>0){
   14B1 DD 6E FA      [19]  786 	ld	l,-6 (ix)
   14B4 DD 66 FB      [19]  787 	ld	h,-5 (ix)
   14B7 7E            [ 7]  788 	ld	a,(hl)
   14B8 DD 77 F9      [19]  789 	ld	-7 (ix),a
                            790 ;src/Map.c:198: if((cellType == CELLTYPE_FLOOR)){
   14BB 79            [ 4]  791 	ld	a,c
   14BC B7            [ 4]  792 	or	a, a
   14BD C2 DA 15      [10]  793 	jp	NZ,00162$
                            794 ;src/Map.c:199: if(currentPos.x>0){
   14C0 DD 7E F9      [19]  795 	ld	a,-7 (ix)
   14C3 B7            [ 4]  796 	or	a, a
   14C4 28 3F         [12]  797 	jr	Z,00148$
                            798 ;src/Map.c:200: adjacentType = map[currentPos.x-1][currentPos.y];
   14C6 DD 6E F9      [19]  799 	ld	l,-7 (ix)
   14C9 26 00         [ 7]  800 	ld	h,#0x00
   14CB 2B            [ 6]  801 	dec	hl
   14CC 29            [11]  802 	add	hl, hl
   14CD 29            [11]  803 	add	hl, hl
   14CE 29            [11]  804 	add	hl, hl
   14CF 29            [11]  805 	add	hl, hl
   14D0 29            [11]  806 	add	hl, hl
   14D1 01 D0 88      [10]  807 	ld	bc,#0x88D0
   14D4 09            [11]  808 	add	hl,bc
   14D5 4D            [ 4]  809 	ld	c,l
   14D6 44            [ 4]  810 	ld	b,h
   14D7 DD 6E FE      [19]  811 	ld	l,-2 (ix)
   14DA DD 66 FF      [19]  812 	ld	h,-1 (ix)
   14DD 6E            [ 7]  813 	ld	l, (hl)
   14DE 26 00         [ 7]  814 	ld	h,#0x00
   14E0 09            [11]  815 	add	hl,bc
   14E1 7E            [ 7]  816 	ld	a,(hl)
                            817 ;src/Map.c:201: if(adjacentType == CELLTYPE_UNDEFINED){
   14E2 D6 87         [ 7]  818 	sub	a, #0x87
   14E4 20 1F         [12]  819 	jr	NZ,00148$
                            820 ;src/Map.c:203: ++lastStackItem;
   14E6 DD 34 EC      [23]  821 	inc	-20 (ix)
   14E9 20 03         [12]  822 	jr	NZ,00340$
   14EB DD 34 ED      [23]  823 	inc	-19 (ix)
   14EE                     824 00340$:
                            825 ;src/Map.c:204: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   14EE E1            [10]  826 	pop	hl
   14EF E5            [11]  827 	push	hl
   14F0 29            [11]  828 	add	hl, hl
   14F1 01 D0 8C      [10]  829 	ld	bc,#0x8CD0
   14F4 09            [11]  830 	add	hl,bc
   14F5 DD 4E F9      [19]  831 	ld	c,-7 (ix)
   14F8 0D            [ 4]  832 	dec	c
   14F9 71            [ 7]  833 	ld	(hl),c
                            834 ;src/Map.c:205: (*(cellStack+lastStackItem)).y = currentPos.y;
   14FA 23            [ 6]  835 	inc	hl
   14FB 4D            [ 4]  836 	ld	c,l
   14FC 44            [ 4]  837 	ld	b,h
   14FD DD 6E FE      [19]  838 	ld	l,-2 (ix)
   1500 DD 66 FF      [19]  839 	ld	h,-1 (ix)
   1503 7E            [ 7]  840 	ld	a,(hl)
   1504 02            [ 7]  841 	ld	(bc),a
   1505                     842 00148$:
                            843 ;src/Map.c:209: if(currentPos.x < (MAP_WIDTH-1)){
   1505 DD 6E FA      [19]  844 	ld	l,-6 (ix)
   1508 DD 66 FB      [19]  845 	ld	h,-5 (ix)
   150B 4E            [ 7]  846 	ld	c,(hl)
   150C 79            [ 4]  847 	ld	a,c
   150D D6 1F         [ 7]  848 	sub	a, #0x1F
   150F 30 3A         [12]  849 	jr	NC,00152$
                            850 ;src/Map.c:211: adjacentType = map[currentPos.x+1][currentPos.y];
   1511 69            [ 4]  851 	ld	l,c
   1512 26 00         [ 7]  852 	ld	h,#0x00
   1514 23            [ 6]  853 	inc	hl
   1515 29            [11]  854 	add	hl, hl
   1516 29            [11]  855 	add	hl, hl
   1517 29            [11]  856 	add	hl, hl
   1518 29            [11]  857 	add	hl, hl
   1519 29            [11]  858 	add	hl, hl
   151A EB            [ 4]  859 	ex	de,hl
   151B 21 D0 88      [10]  860 	ld	hl,#0x88D0
   151E 19            [11]  861 	add	hl,de
   151F EB            [ 4]  862 	ex	de,hl
   1520 DD 6E FE      [19]  863 	ld	l,-2 (ix)
   1523 DD 66 FF      [19]  864 	ld	h,-1 (ix)
   1526 6E            [ 7]  865 	ld	l, (hl)
   1527 26 00         [ 7]  866 	ld	h,#0x00
   1529 19            [11]  867 	add	hl,de
   152A 7E            [ 7]  868 	ld	a,(hl)
                            869 ;src/Map.c:212: if(adjacentType == CELLTYPE_UNDEFINED){
   152B D6 87         [ 7]  870 	sub	a, #0x87
   152D 20 1C         [12]  871 	jr	NZ,00152$
                            872 ;src/Map.c:215: ++lastStackItem;
   152F DD 34 EC      [23]  873 	inc	-20 (ix)
   1532 20 03         [12]  874 	jr	NZ,00343$
   1534 DD 34 ED      [23]  875 	inc	-19 (ix)
   1537                     876 00343$:
                            877 ;src/Map.c:216: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   1537 E1            [10]  878 	pop	hl
   1538 E5            [11]  879 	push	hl
   1539 29            [11]  880 	add	hl, hl
   153A 11 D0 8C      [10]  881 	ld	de,#0x8CD0
   153D 19            [11]  882 	add	hl,de
   153E 0C            [ 4]  883 	inc	c
   153F 71            [ 7]  884 	ld	(hl),c
                            885 ;src/Map.c:217: (*(cellStack+lastStackItem)).y = currentPos.y;
   1540 23            [ 6]  886 	inc	hl
   1541 4D            [ 4]  887 	ld	c,l
   1542 44            [ 4]  888 	ld	b,h
   1543 DD 6E FE      [19]  889 	ld	l,-2 (ix)
   1546 DD 66 FF      [19]  890 	ld	h,-1 (ix)
   1549 7E            [ 7]  891 	ld	a,(hl)
   154A 02            [ 7]  892 	ld	(bc),a
   154B                     893 00152$:
                            894 ;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
   154B DD 6E FE      [19]  895 	ld	l,-2 (ix)
   154E DD 66 FF      [19]  896 	ld	h,-1 (ix)
   1551 4E            [ 7]  897 	ld	c,(hl)
                            898 ;src/Map.c:221: if(currentPos.y > 0){
   1552 79            [ 4]  899 	ld	a,c
   1553 B7            [ 4]  900 	or	a, a
   1554 28 3A         [12]  901 	jr	Z,00156$
                            902 ;src/Map.c:223: adjacentType = map[currentPos.x][currentPos.y-1];
   1556 DD 6E FA      [19]  903 	ld	l,-6 (ix)
   1559 DD 66 FB      [19]  904 	ld	h,-5 (ix)
   155C 46            [ 7]  905 	ld	b,(hl)
   155D 68            [ 4]  906 	ld	l,b
   155E 26 00         [ 7]  907 	ld	h,#0x00
   1560 29            [11]  908 	add	hl, hl
   1561 29            [11]  909 	add	hl, hl
   1562 29            [11]  910 	add	hl, hl
   1563 29            [11]  911 	add	hl, hl
   1564 29            [11]  912 	add	hl, hl
   1565 11 D0 88      [10]  913 	ld	de,#0x88D0
   1568 19            [11]  914 	add	hl,de
   1569 0D            [ 4]  915 	dec	c
   156A 59            [ 4]  916 	ld	e,c
   156B 16 00         [ 7]  917 	ld	d,#0x00
   156D 19            [11]  918 	add	hl,de
   156E 7E            [ 7]  919 	ld	a,(hl)
                            920 ;src/Map.c:224: if(adjacentType == CELLTYPE_UNDEFINED){
   156F D6 87         [ 7]  921 	sub	a, #0x87
   1571 20 1D         [12]  922 	jr	NZ,00156$
                            923 ;src/Map.c:227: ++lastStackItem;
   1573 DD 34 EC      [23]  924 	inc	-20 (ix)
   1576 20 03         [12]  925 	jr	NZ,00346$
   1578 DD 34 ED      [23]  926 	inc	-19 (ix)
   157B                     927 00346$:
                            928 ;src/Map.c:228: (*(cellStack+lastStackItem)).x = currentPos.x;
   157B E1            [10]  929 	pop	hl
   157C E5            [11]  930 	push	hl
   157D 29            [11]  931 	add	hl, hl
   157E 11 D0 8C      [10]  932 	ld	de,#0x8CD0
   1581 19            [11]  933 	add	hl,de
   1582 70            [ 7]  934 	ld	(hl),b
                            935 ;src/Map.c:229: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   1583 23            [ 6]  936 	inc	hl
   1584 4D            [ 4]  937 	ld	c,l
   1585 44            [ 4]  938 	ld	b,h
   1586 DD 6E FE      [19]  939 	ld	l,-2 (ix)
   1589 DD 66 FF      [19]  940 	ld	h,-1 (ix)
   158C 5E            [ 7]  941 	ld	e,(hl)
   158D 1D            [ 4]  942 	dec	e
   158E 7B            [ 4]  943 	ld	a,e
   158F 02            [ 7]  944 	ld	(bc),a
   1590                     945 00156$:
                            946 ;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
   1590 DD 6E FE      [19]  947 	ld	l,-2 (ix)
   1593 DD 66 FF      [19]  948 	ld	h,-1 (ix)
   1596 46            [ 7]  949 	ld	b,(hl)
                            950 ;src/Map.c:233: if(currentPos.y < (MAP_HEIGHT-1)){
   1597 78            [ 4]  951 	ld	a,b
   1598 D6 1F         [ 7]  952 	sub	a, #0x1F
   159A D2 24 14      [10]  953 	jp	NC,00164$
                            954 ;src/Map.c:235: adjacentType = map[currentPos.x][currentPos.y+1];
   159D DD 6E FA      [19]  955 	ld	l,-6 (ix)
   15A0 DD 66 FB      [19]  956 	ld	h,-5 (ix)
   15A3 4E            [ 7]  957 	ld	c,(hl)
   15A4 69            [ 4]  958 	ld	l,c
   15A5 26 00         [ 7]  959 	ld	h,#0x00
   15A7 29            [11]  960 	add	hl, hl
   15A8 29            [11]  961 	add	hl, hl
   15A9 29            [11]  962 	add	hl, hl
   15AA 29            [11]  963 	add	hl, hl
   15AB 29            [11]  964 	add	hl, hl
   15AC 11 D0 88      [10]  965 	ld	de,#0x88D0
   15AF 19            [11]  966 	add	hl,de
   15B0 04            [ 4]  967 	inc	b
   15B1 58            [ 4]  968 	ld	e,b
   15B2 16 00         [ 7]  969 	ld	d,#0x00
   15B4 19            [11]  970 	add	hl,de
   15B5 7E            [ 7]  971 	ld	a,(hl)
                            972 ;src/Map.c:236: if(adjacentType == CELLTYPE_UNDEFINED){
   15B6 D6 87         [ 7]  973 	sub	a, #0x87
   15B8 C2 24 14      [10]  974 	jp	NZ,00164$
                            975 ;src/Map.c:239: ++lastStackItem;
   15BB DD 34 EC      [23]  976 	inc	-20 (ix)
   15BE 20 03         [12]  977 	jr	NZ,00349$
   15C0 DD 34 ED      [23]  978 	inc	-19 (ix)
   15C3                     979 00349$:
                            980 ;src/Map.c:240: (*(cellStack+lastStackItem)).x = currentPos.x;
   15C3 E1            [10]  981 	pop	hl
   15C4 E5            [11]  982 	push	hl
   15C5 29            [11]  983 	add	hl, hl
   15C6 11 D0 8C      [10]  984 	ld	de,#0x8CD0
   15C9 19            [11]  985 	add	hl,de
   15CA 71            [ 7]  986 	ld	(hl),c
                            987 ;src/Map.c:241: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   15CB 23            [ 6]  988 	inc	hl
   15CC 4D            [ 4]  989 	ld	c,l
   15CD 44            [ 4]  990 	ld	b,h
   15CE DD 6E FE      [19]  991 	ld	l,-2 (ix)
   15D1 DD 66 FF      [19]  992 	ld	h,-1 (ix)
   15D4 7E            [ 7]  993 	ld	a,(hl)
   15D5 3C            [ 4]  994 	inc	a
   15D6 02            [ 7]  995 	ld	(bc),a
   15D7 C3 24 14      [10]  996 	jp	00164$
   15DA                     997 00162$:
                            998 ;src/Map.c:247: ++wallListCount;
   15DA DD 34 FC      [23]  999 	inc	-4 (ix)
   15DD 20 03         [12] 1000 	jr	NZ,00350$
   15DF DD 34 FD      [23] 1001 	inc	-3 (ix)
   15E2                    1002 00350$:
   15E2 DD 7E FC      [19] 1003 	ld	a,-4 (ix)
   15E5 DD 77 EE      [19] 1004 	ld	-18 (ix),a
   15E8 DD 7E FD      [19] 1005 	ld	a,-3 (ix)
   15EB DD 77 EF      [19] 1006 	ld	-17 (ix),a
                           1007 ;src/Map.c:248: (*(wallList+wallListCount)).x = currentPos.x;
   15EE DD 6E FC      [19] 1008 	ld	l,-4 (ix)
   15F1 DD 66 FD      [19] 1009 	ld	h,-3 (ix)
   15F4 29            [11] 1010 	add	hl, hl
   15F5 01 D0 90      [10] 1011 	ld	bc,#0x90D0
   15F8 09            [11] 1012 	add	hl,bc
   15F9 DD 7E F9      [19] 1013 	ld	a,-7 (ix)
   15FC 77            [ 7] 1014 	ld	(hl),a
                           1015 ;src/Map.c:249: (*(wallList+wallListCount)).y = currentPos.y;
   15FD 23            [ 6] 1016 	inc	hl
   15FE 4D            [ 4] 1017 	ld	c,l
   15FF 44            [ 4] 1018 	ld	b,h
   1600 DD 6E FE      [19] 1019 	ld	l,-2 (ix)
   1603 DD 66 FF      [19] 1020 	ld	h,-1 (ix)
   1606 7E            [ 7] 1021 	ld	a,(hl)
   1607 02            [ 7] 1022 	ld	(bc),a
   1608 C3 24 14      [10] 1023 	jp	00164$
   160B                    1024 00174$:
   160B DD F9         [10] 1025 	ld	sp, ix
   160D DD E1         [14] 1026 	pop	ix
   160F C9            [10] 1027 	ret
                           1028 ;src/Map.c:255: void generate_exit_door(){
                           1029 ;	---------------------------------
                           1030 ; Function generate_exit_door
                           1031 ; ---------------------------------
   1610                    1032 _generate_exit_door::
   1610 DD E5         [15] 1033 	push	ix
   1612 DD 21 00 00   [14] 1034 	ld	ix,#0
   1616 DD 39         [15] 1035 	add	ix,sp
   1618 21 F3 FF      [10] 1036 	ld	hl,#-13
   161B 39            [11] 1037 	add	hl,sp
   161C F9            [ 6] 1038 	ld	sp,hl
                           1039 ;src/Map.c:256: u8 x=(cpct_getRandom_mxor_u8 ()%32);
   161D CD 71 7A      [17] 1040 	call	_cpct_getRandom_mxor_u8
   1620 7D            [ 4] 1041 	ld	a,l
   1621 E6 1F         [ 7] 1042 	and	a, #0x1F
   1623 4F            [ 4] 1043 	ld	c,a
                           1044 ;src/Map.c:257: u8 y=(cpct_getRandom_mxor_u8 ()%32);
   1624 C5            [11] 1045 	push	bc
   1625 CD 71 7A      [17] 1046 	call	_cpct_getRandom_mxor_u8
   1628 C1            [10] 1047 	pop	bc
   1629 7D            [ 4] 1048 	ld	a,l
   162A E6 1F         [ 7] 1049 	and	a, #0x1F
   162C 5F            [ 4] 1050 	ld	e,a
                           1051 ;src/Map.c:258: u8 door_not_positioned=1;
   162D DD 36 F7 01   [19] 1052 	ld	-9 (ix),#0x01
                           1053 ;src/Map.c:265: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
   1631 06 00         [ 7] 1054 	ld	b,#0x00
   1633 21 D0 88      [10] 1055 	ld	hl,#0x88D0
   1636 09            [11] 1056 	add	hl,bc
   1637 4D            [ 4] 1057 	ld	c,l
   1638 44            [ 4] 1058 	ld	b,h
   1639 6B            [ 4] 1059 	ld	l,e
   163A 26 00         [ 7] 1060 	ld	h,#0x00
   163C 29            [11] 1061 	add	hl, hl
   163D 29            [11] 1062 	add	hl, hl
   163E 29            [11] 1063 	add	hl, hl
   163F 29            [11] 1064 	add	hl, hl
   1640 29            [11] 1065 	add	hl, hl
   1641 09            [11] 1066 	add	hl,bc
   1642 4D            [ 4] 1067 	ld	c,l
   1643 44            [ 4] 1068 	ld	b,h
                           1069 ;src/Map.c:270: lastVal = (position-1);
   1644 59            [ 4] 1070 	ld	e,c
   1645 50            [ 4] 1071 	ld	d,b
   1646 1B            [ 6] 1072 	dec	de
                           1073 ;src/Map.c:271: nextVal = (position+1);
   1647 21 01 00      [10] 1074 	ld	hl,#0x0001
   164A 09            [11] 1075 	add	hl,bc
   164B DD 75 F5      [19] 1076 	ld	-11 (ix),l
   164E DD 74 F6      [19] 1077 	ld	-10 (ix),h
                           1078 ;src/Map.c:272: topVal = (position-MAP_WIDTH);
   1651 79            [ 4] 1079 	ld	a,c
   1652 C6 E0         [ 7] 1080 	add	a,#0xE0
   1654 DD 77 F3      [19] 1081 	ld	-13 (ix),a
   1657 78            [ 4] 1082 	ld	a,b
   1658 CE FF         [ 7] 1083 	adc	a,#0xFF
   165A DD 77 F4      [19] 1084 	ld	-12 (ix),a
                           1085 ;src/Map.c:273: bottomVal = (position+MAP_WIDTH);
   165D 21 20 00      [10] 1086 	ld	hl,#0x0020
   1660 09            [11] 1087 	add	hl,bc
   1661 DD 75 F8      [19] 1088 	ld	-8 (ix),l
   1664 DD 74 F9      [19] 1089 	ld	-7 (ix),h
                           1090 ;src/Map.c:275: while(door_not_positioned){
   1667                    1091 00138$:
   1667 DD 7E F7      [19] 1092 	ld	a,-9 (ix)
   166A B7            [ 4] 1093 	or	a, a
   166B CA BE 17      [10] 1094 	jp	Z,00141$
                           1095 ;src/Map.c:276: if((*position)!=CELLTYPE_FLOOR){
   166E 0A            [ 7] 1096 	ld	a,(bc)
   166F B7            [ 4] 1097 	or	a, a
   1670 CA 7B 17      [10] 1098 	jp	Z,00135$
                           1099 ;src/Map.c:277: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   1673 1A            [ 7] 1100 	ld	a,(de)
   1674 DD 77 FC      [19] 1101 	ld	-4 (ix),a
   1677 7B            [ 4] 1102 	ld	a,e
   1678 D6 D0         [ 7] 1103 	sub	a, #0xD0
   167A 7A            [ 4] 1104 	ld	a,d
   167B DE 88         [ 7] 1105 	sbc	a, #0x88
   167D 3E 00         [ 7] 1106 	ld	a,#0x00
   167F 17            [ 4] 1107 	rla
   1680 DD 77 FB      [19] 1108 	ld	-5 (ix),a
   1683 DD 7E F5      [19] 1109 	ld	a,-11 (ix)
   1686 D6 D0         [ 7] 1110 	sub	a, #0xD0
   1688 DD 7E F6      [19] 1111 	ld	a,-10 (ix)
   168B DE 8C         [ 7] 1112 	sbc	a, #0x8C
   168D 3E 00         [ 7] 1113 	ld	a,#0x00
   168F 17            [ 4] 1114 	rla
   1690 DD 77 FA      [19] 1115 	ld	-6 (ix),a
                           1116 ;src/Map.c:278: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   1693 E1            [10] 1117 	pop	hl
   1694 E5            [11] 1118 	push	hl
   1695 7E            [ 7] 1119 	ld	a,(hl)
   1696 DD 77 FF      [19] 1120 	ld	-1 (ix),a
   1699 DD 7E F3      [19] 1121 	ld	a,-13 (ix)
   169C D6 D0         [ 7] 1122 	sub	a, #0xD0
   169E DD 7E F4      [19] 1123 	ld	a,-12 (ix)
   16A1 DE 88         [ 7] 1124 	sbc	a, #0x88
   16A3 3E 00         [ 7] 1125 	ld	a,#0x00
   16A5 17            [ 4] 1126 	rla
   16A6 DD 77 FE      [19] 1127 	ld	-2 (ix),a
   16A9 DD 7E F8      [19] 1128 	ld	a,-8 (ix)
   16AC D6 D0         [ 7] 1129 	sub	a, #0xD0
   16AE DD 7E F9      [19] 1130 	ld	a,-7 (ix)
   16B1 DE 8C         [ 7] 1131 	sbc	a, #0x8C
   16B3 3E 00         [ 7] 1132 	ld	a,#0x00
   16B5 17            [ 4] 1133 	rla
   16B6 DD 77 FD      [19] 1134 	ld	-3 (ix),a
                           1135 ;src/Map.c:277: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   16B9 DD 7E FC      [19] 1136 	ld	a,-4 (ix)
   16BC B7            [ 4] 1137 	or	a, a
   16BD 20 06         [12] 1138 	jr	NZ,00133$
   16BF DD 7E FB      [19] 1139 	ld	a,-5 (ix)
   16C2 B7            [ 4] 1140 	or	a, a
   16C3 28 57         [12] 1141 	jr	Z,00129$
   16C5                    1142 00133$:
   16C5 DD 6E F5      [19] 1143 	ld	l,-11 (ix)
   16C8 DD 66 F6      [19] 1144 	ld	h,-10 (ix)
   16CB 7E            [ 7] 1145 	ld	a,(hl)
   16CC B7            [ 4] 1146 	or	a, a
   16CD 20 06         [12] 1147 	jr	NZ,00128$
   16CF DD CB FA 46   [20] 1148 	bit	0,-6 (ix)
   16D3 20 47         [12] 1149 	jr	NZ,00129$
   16D5                    1150 00128$:
                           1151 ;src/Map.c:278: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   16D5 DD 6E F8      [19] 1152 	ld	l,-8 (ix)
   16D8 DD 66 F9      [19] 1153 	ld	h,-7 (ix)
   16DB 6E            [ 7] 1154 	ld	l,(hl)
   16DC DD 7E FF      [19] 1155 	ld	a,-1 (ix)
   16DF B7            [ 4] 1156 	or	a, a
   16E0 20 06         [12] 1157 	jr	NZ,00111$
   16E2 DD 7E FE      [19] 1158 	ld	a,-2 (ix)
   16E5 B7            [ 4] 1159 	or	a, a
   16E6 28 14         [12] 1160 	jr	Z,00107$
   16E8                    1161 00111$:
   16E8 7D            [ 4] 1162 	ld	a,l
   16E9 B7            [ 4] 1163 	or	a, a
   16EA 20 10         [12] 1164 	jr	NZ,00107$
   16EC DD 7E FD      [19] 1165 	ld	a,-3 (ix)
   16EF B7            [ 4] 1166 	or	a, a
   16F0 28 0A         [12] 1167 	jr	Z,00107$
                           1168 ;src/Map.c:279: door_not_positioned=0;
   16F2 DD 36 F7 00   [19] 1169 	ld	-9 (ix),#0x00
                           1170 ;src/Map.c:280: *position=CELLTYPE_DOOR;
   16F6 3E 80         [ 7] 1171 	ld	a,#0x80
   16F8 02            [ 7] 1172 	ld	(bc),a
   16F9 C3 7B 17      [10] 1173 	jp	00135$
   16FC                    1174 00107$:
                           1175 ;src/Map.c:282: else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
   16FC 7D            [ 4] 1176 	ld	a,l
   16FD B7            [ 4] 1177 	or	a, a
   16FE 20 07         [12] 1178 	jr	NZ,00105$
   1700 DD 7E FD      [19] 1179 	ld	a,-3 (ix)
   1703 B7            [ 4] 1180 	or	a, a
   1704 C2 7B 17      [10] 1181 	jp	NZ,00135$
   1707                    1182 00105$:
   1707 DD 7E FF      [19] 1183 	ld	a,-1 (ix)
   170A B7            [ 4] 1184 	or	a, a
   170B 20 6E         [12] 1185 	jr	NZ,00135$
   170D DD 7E FE      [19] 1186 	ld	a,-2 (ix)
   1710 B7            [ 4] 1187 	or	a, a
   1711 20 68         [12] 1188 	jr	NZ,00135$
                           1189 ;src/Map.c:283: door_not_positioned=0;
   1713 DD 36 F7 00   [19] 1190 	ld	-9 (ix),#0x00
                           1191 ;src/Map.c:284: *position=CELLTYPE_DOOR;
   1717 3E 80         [ 7] 1192 	ld	a,#0x80
   1719 02            [ 7] 1193 	ld	(bc),a
   171A 18 5F         [12] 1194 	jr	00135$
   171C                    1195 00129$:
                           1196 ;src/Map.c:287: else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
   171C DD 7E FF      [19] 1197 	ld	a,-1 (ix)
   171F B7            [ 4] 1198 	or	a, a
   1720 20 06         [12] 1199 	jr	NZ,00127$
   1722 DD 7E FE      [19] 1200 	ld	a,-2 (ix)
   1725 B7            [ 4] 1201 	or	a, a
   1726 28 53         [12] 1202 	jr	Z,00135$
   1728                    1203 00127$:
   1728 DD 6E F8      [19] 1204 	ld	l,-8 (ix)
   172B DD 66 F9      [19] 1205 	ld	h,-7 (ix)
   172E 7E            [ 7] 1206 	ld	a,(hl)
   172F B7            [ 4] 1207 	or	a, a
   1730 20 06         [12] 1208 	jr	NZ,00123$
   1732 DD 7E FD      [19] 1209 	ld	a,-3 (ix)
   1735 B7            [ 4] 1210 	or	a, a
   1736 20 43         [12] 1211 	jr	NZ,00135$
   1738                    1212 00123$:
                           1213 ;src/Map.c:277: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   1738 DD 6E F5      [19] 1214 	ld	l,-11 (ix)
   173B DD 66 F6      [19] 1215 	ld	h,-10 (ix)
   173E 6E            [ 7] 1216 	ld	l,(hl)
                           1217 ;src/Map.c:288: if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
   173F DD 7E FC      [19] 1218 	ld	a,-4 (ix)
   1742 B7            [ 4] 1219 	or	a, a
   1743 20 06         [12] 1220 	jr	NZ,00122$
   1745 DD 7E FB      [19] 1221 	ld	a,-5 (ix)
   1748 B7            [ 4] 1222 	or	a, a
   1749 28 13         [12] 1223 	jr	Z,00118$
   174B                    1224 00122$:
   174B 7D            [ 4] 1225 	ld	a,l
   174C B7            [ 4] 1226 	or	a, a
   174D 20 0F         [12] 1227 	jr	NZ,00118$
   174F DD CB FA 46   [20] 1228 	bit	0,-6 (ix)
   1753 28 09         [12] 1229 	jr	Z,00118$
                           1230 ;src/Map.c:289: door_not_positioned=0;
   1755 DD 36 F7 00   [19] 1231 	ld	-9 (ix),#0x00
                           1232 ;src/Map.c:290: *position=CELLTYPE_DOOR;
   1759 3E 80         [ 7] 1233 	ld	a,#0x80
   175B 02            [ 7] 1234 	ld	(bc),a
   175C 18 1D         [12] 1235 	jr	00135$
   175E                    1236 00118$:
                           1237 ;src/Map.c:292: else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
   175E 7D            [ 4] 1238 	ld	a,l
   175F B7            [ 4] 1239 	or	a, a
   1760 20 06         [12] 1240 	jr	NZ,00116$
   1762 DD CB FA 46   [20] 1241 	bit	0,-6 (ix)
   1766 20 13         [12] 1242 	jr	NZ,00135$
   1768                    1243 00116$:
   1768 DD 7E FC      [19] 1244 	ld	a,-4 (ix)
   176B B7            [ 4] 1245 	or	a, a
   176C 20 0D         [12] 1246 	jr	NZ,00135$
   176E DD 7E FB      [19] 1247 	ld	a,-5 (ix)
   1771 B7            [ 4] 1248 	or	a, a
   1772 20 07         [12] 1249 	jr	NZ,00135$
                           1250 ;src/Map.c:293: door_not_positioned=0;
   1774 DD 36 F7 00   [19] 1251 	ld	-9 (ix),#0x00
                           1252 ;src/Map.c:294: *position=CELLTYPE_DOOR;
   1778 3E 80         [ 7] 1253 	ld	a,#0x80
   177A 02            [ 7] 1254 	ld	(bc),a
   177B                    1255 00135$:
                           1256 ;src/Map.c:298: ++position;
   177B 03            [ 6] 1257 	inc	bc
                           1258 ;src/Map.c:299: ++lastVal;
   177C 13            [ 6] 1259 	inc	de
                           1260 ;src/Map.c:300: ++nextVal;
   177D DD 34 F5      [23] 1261 	inc	-11 (ix)
   1780 20 03         [12] 1262 	jr	NZ,00223$
   1782 DD 34 F6      [23] 1263 	inc	-10 (ix)
   1785                    1264 00223$:
                           1265 ;src/Map.c:301: ++topVal;
   1785 DD 34 F3      [23] 1266 	inc	-13 (ix)
   1788 20 03         [12] 1267 	jr	NZ,00224$
   178A DD 34 F4      [23] 1268 	inc	-12 (ix)
   178D                    1269 00224$:
                           1270 ;src/Map.c:302: ++bottomVal;
   178D DD 34 F8      [23] 1271 	inc	-8 (ix)
   1790 20 03         [12] 1272 	jr	NZ,00225$
   1792 DD 34 F9      [23] 1273 	inc	-7 (ix)
   1795                    1274 00225$:
                           1275 ;src/Map.c:303: if(position==END_OF_MAP_MEM){
   1795 79            [ 4] 1276 	ld	a,c
   1796 D6 D0         [ 7] 1277 	sub	a, #0xD0
   1798 C2 67 16      [10] 1278 	jp	NZ,00138$
   179B 78            [ 4] 1279 	ld	a,b
   179C D6 8C         [ 7] 1280 	sub	a, #0x8C
   179E C2 67 16      [10] 1281 	jp	NZ,00138$
                           1282 ;src/Map.c:304: position = MAP_MEM;
   17A1 01 D0 88      [10] 1283 	ld	bc,#0x88D0
                           1284 ;src/Map.c:305: lastVal = (position-1);
   17A4 11 CF 88      [10] 1285 	ld	de,#0x88CF
                           1286 ;src/Map.c:306: nextVal = (position+1);
   17A7 DD 36 F5 D1   [19] 1287 	ld	-11 (ix),#0xD1
   17AB DD 36 F6 88   [19] 1288 	ld	-10 (ix),#0x88
                           1289 ;src/Map.c:307: topVal = (position-MAP_WIDTH);
   17AF 21 B0 88      [10] 1290 	ld	hl,#0x88B0
   17B2 E3            [19] 1291 	ex	(sp), hl
                           1292 ;src/Map.c:308: bottomVal = (position+MAP_WIDTH);
   17B3 DD 36 F8 F0   [19] 1293 	ld	-8 (ix),#0xF0
   17B7 DD 36 F9 88   [19] 1294 	ld	-7 (ix),#0x88
   17BB C3 67 16      [10] 1295 	jp	00138$
   17BE                    1296 00141$:
   17BE DD F9         [10] 1297 	ld	sp, ix
   17C0 DD E1         [14] 1298 	pop	ix
   17C2 C9            [10] 1299 	ret
                           1300 ;src/Map.c:314: void generate_level(){
                           1301 ;	---------------------------------
                           1302 ; Function generate_level
                           1303 ; ---------------------------------
   17C3                    1304 _generate_level::
                           1305 ;src/Map.c:315: generate_level_with_seed(r_counter);
   17C3 2A 38 7D      [16] 1306 	ld	hl,(_r_counter)
   17C6 E5            [11] 1307 	push	hl
   17C7 CD CC 17      [17] 1308 	call	_generate_level_with_seed
   17CA F1            [10] 1309 	pop	af
   17CB C9            [10] 1310 	ret
                           1311 ;src/Map.c:318: void generate_level_with_seed(u16 seed) {
                           1312 ;	---------------------------------
                           1313 ; Function generate_level_with_seed
                           1314 ; ---------------------------------
   17CC                    1315 _generate_level_with_seed::
   17CC DD E5         [15] 1316 	push	ix
   17CE DD 21 00 00   [14] 1317 	ld	ix,#0
   17D2 DD 39         [15] 1318 	add	ix,sp
                           1319 ;src/Map.c:320: rand_seed=seed;
   17D4 DD 4E 04      [19] 1320 	ld	c,4 (ix)
   17D7 DD 46 05      [19] 1321 	ld	b,5 (ix)
   17DA ED 43 63 7D   [20] 1322 	ld	(_rand_seed),bc
                           1323 ;src/Map.c:323: cpct_setSeed_mxor(((seed+level_get_level())&0xFFFE) + 1);
   17DE C5            [11] 1324 	push	bc
   17DF CD A7 0F      [17] 1325 	call	_level_get_level
   17E2 C1            [10] 1326 	pop	bc
   17E3 26 00         [ 7] 1327 	ld	h,#0x00
   17E5 09            [11] 1328 	add	hl,bc
   17E6 CB 85         [ 8] 1329 	res	0, l
   17E8 23            [ 6] 1330 	inc	hl
   17E9 11 00 00      [10] 1331 	ld	de,#0x0000
   17EC CD 63 7A      [17] 1332 	call	_cpct_setSeed_mxor
                           1333 ;src/Map.c:324: cpct_restoreState_mxor_u8();
   17EF CD 6B 7A      [17] 1334 	call	_cpct_restoreState_mxor_u8
                           1335 ;src/Map.c:326: if(level_get_level()<KING_LEVEL){
   17F2 CD A7 0F      [17] 1336 	call	_level_get_level
   17F5 7D            [ 4] 1337 	ld	a,l
   17F6 D6 20         [ 7] 1338 	sub	a, #0x20
   17F8 30 08         [12] 1339 	jr	NC,00102$
                           1340 ;src/Map.c:327: generate_map();
   17FA CD 58 11      [17] 1341 	call	_generate_map
                           1342 ;src/Map.c:328: generate_exit_door();
   17FD CD 10 16      [17] 1343 	call	_generate_exit_door
   1800 18 03         [12] 1344 	jr	00104$
   1802                    1345 00102$:
                           1346 ;src/Map.c:331: generate_final_map();
   1802 CD C6 10      [17] 1347 	call	_generate_final_map
   1805                    1348 00104$:
   1805 DD E1         [14] 1349 	pop	ix
   1807 C9            [10] 1350 	ret
                           1351 	.area _CODE
                           1352 	.area _INITIALIZER
                           1353 	.area _CABS (ABS)
