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
   7D89                      33 _rand_seed::
   7D89                      34 	.ds 2
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
   10EE                      63 _map_get_seed::
                             64 ;src/Map.c:15: return rand_seed;
   10EE 2A 89 7D      [16]   65 	ld	hl,(_rand_seed)
   10F1 C9            [10]   66 	ret
                             67 ;src/Map.c:18: u8 get_random_wall(){
                             68 ;	---------------------------------
                             69 ; Function get_random_wall
                             70 ; ---------------------------------
   10F2                      71 _get_random_wall::
                             72 ;src/Map.c:19: u8 cellType = cpct_getRandom_mxor_u8 ();
   10F2 CD 97 7A      [17]   73 	call	_cpct_getRandom_mxor_u8
                             74 ;src/Map.c:20: if(cellType&1){ //1,3,5,7
   10F5 CB 45         [ 8]   75 	bit	0, l
   10F7 28 03         [12]   76 	jr	Z,00108$
                             77 ;src/Map.c:21: return CELLTYPE_WALL1;
   10F9 2E 81         [ 7]   78 	ld	l,#0x81
   10FB C9            [10]   79 	ret
   10FC                      80 00108$:
                             81 ;src/Map.c:24: if(cellType&3){//2,6
   10FC 7D            [ 4]   82 	ld	a,l
   10FD E6 03         [ 7]   83 	and	a, #0x03
   10FF 28 03         [12]   84 	jr	Z,00105$
                             85 ;src/Map.c:25: return CELLTYPE_WALL2;
   1101 2E 82         [ 7]   86 	ld	l,#0x82
   1103 C9            [10]   87 	ret
   1104                      88 00105$:
                             89 ;src/Map.c:28: if(cellType&7){//4
   1104 7D            [ 4]   90 	ld	a,l
   1105 E6 07         [ 7]   91 	and	a, #0x07
   1107 28 03         [12]   92 	jr	Z,00102$
                             93 ;src/Map.c:29: return CELLTYPE_WALL3;
   1109 2E 83         [ 7]   94 	ld	l,#0x83
   110B C9            [10]   95 	ret
   110C                      96 00102$:
                             97 ;src/Map.c:32: return CELLTYPE_WALL4;  
   110C 2E 84         [ 7]   98 	ld	l,#0x84
   110E C9            [10]   99 	ret
                            100 ;src/Map.c:38: void generate_final_map(){
                            101 ;	---------------------------------
                            102 ; Function generate_final_map
                            103 ; ---------------------------------
   110F                     104 _generate_final_map::
                            105 ;src/Map.c:43: while(m>=MAP_MEM){
   110F 21 D0 8C      [10]  106 	ld	hl,#0x8CD0
   1112                     107 00101$:
   1112 7D            [ 4]  108 	ld	a,l
   1113 D6 D0         [ 7]  109 	sub	a, #0xD0
   1115 7C            [ 4]  110 	ld	a,h
   1116 DE 88         [ 7]  111 	sbc	a, #0x88
   1118 38 05         [12]  112 	jr	C,00103$
                            113 ;src/Map.c:44: *m=CELLTYPE_WALL1;
   111A 36 81         [10]  114 	ld	(hl),#0x81
                            115 ;src/Map.c:45: --m;
   111C 2B            [ 6]  116 	dec	hl
   111D 18 F3         [12]  117 	jr	00101$
   111F                     118 00103$:
                            119 ;src/Map.c:48: for(i=1;i<KING_LEVEL_WIDTH-1;++i){
   111F 0E 01         [ 7]  120 	ld	c,#0x01
                            121 ;src/Map.c:49: for(j=1;j<KING_LEVEL_HEIGHT-1;++j){
   1121                     122 00124$:
   1121 06 01         [ 7]  123 	ld	b,#0x01
   1123                     124 00110$:
                            125 ;src/Map.c:50: map[j][i]=CELLTYPE_FLOOR;//get_random_wall();
   1123 68            [ 4]  126 	ld	l,b
   1124 26 00         [ 7]  127 	ld	h,#0x00
   1126 29            [11]  128 	add	hl, hl
   1127 29            [11]  129 	add	hl, hl
   1128 29            [11]  130 	add	hl, hl
   1129 29            [11]  131 	add	hl, hl
   112A 29            [11]  132 	add	hl, hl
   112B 11 D0 88      [10]  133 	ld	de,#0x88D0
   112E 19            [11]  134 	add	hl,de
   112F 59            [ 4]  135 	ld	e,c
   1130 16 00         [ 7]  136 	ld	d,#0x00
   1132 19            [11]  137 	add	hl,de
   1133 36 00         [10]  138 	ld	(hl),#0x00
                            139 ;src/Map.c:49: for(j=1;j<KING_LEVEL_HEIGHT-1;++j){
   1135 04            [ 4]  140 	inc	b
   1136 78            [ 4]  141 	ld	a,b
   1137 D6 08         [ 7]  142 	sub	a, #0x08
   1139 38 E8         [12]  143 	jr	C,00110$
                            144 ;src/Map.c:48: for(i=1;i<KING_LEVEL_WIDTH-1;++i){
   113B 0C            [ 4]  145 	inc	c
   113C 79            [ 4]  146 	ld	a,c
   113D D6 08         [ 7]  147 	sub	a, #0x08
   113F 38 E0         [12]  148 	jr	C,00124$
                            149 ;src/Map.c:54: for(i=2;i<7;i+=2){
   1141 0E 02         [ 7]  150 	ld	c,#0x02
   1143                     151 00114$:
                            152 ;src/Map.c:55: map[i][2]=(cpct_getRandom_mxor_u8 ()%2)?CELLTYPE_WALL2:CELLTYPE_WALL3;//get_random_wall();
   1143 69            [ 4]  153 	ld	l,c
   1144 26 00         [ 7]  154 	ld	h,#0x00
   1146 29            [11]  155 	add	hl, hl
   1147 29            [11]  156 	add	hl, hl
   1148 29            [11]  157 	add	hl, hl
   1149 29            [11]  158 	add	hl, hl
   114A 29            [11]  159 	add	hl, hl
   114B 11 D0 88      [10]  160 	ld	de, #0x88D0
   114E 19            [11]  161 	add	hl, de
   114F 5D            [ 4]  162 	ld	e,l
   1150 54            [ 4]  163 	ld	d,h
   1151 23            [ 6]  164 	inc	hl
   1152 23            [ 6]  165 	inc	hl
   1153 E5            [11]  166 	push	hl
   1154 C5            [11]  167 	push	bc
   1155 D5            [11]  168 	push	de
   1156 CD 97 7A      [17]  169 	call	_cpct_getRandom_mxor_u8
   1159 7D            [ 4]  170 	ld	a,l
   115A D1            [10]  171 	pop	de
   115B C1            [10]  172 	pop	bc
   115C E1            [10]  173 	pop	hl
   115D 0F            [ 4]  174 	rrca
   115E 30 04         [12]  175 	jr	NC,00118$
   1160 06 82         [ 7]  176 	ld	b,#0x82
   1162 18 02         [12]  177 	jr	00119$
   1164                     178 00118$:
   1164 06 83         [ 7]  179 	ld	b,#0x83
   1166                     180 00119$:
   1166 70            [ 7]  181 	ld	(hl),b
                            182 ;src/Map.c:56: map[i][6]=(cpct_getRandom_mxor_u8 ()%2)?CELLTYPE_WALL2:CELLTYPE_WALL3;//get_random_wall();
   1167 21 06 00      [10]  183 	ld	hl,#0x0006
   116A 19            [11]  184 	add	hl,de
   116B E5            [11]  185 	push	hl
   116C C5            [11]  186 	push	bc
   116D CD 97 7A      [17]  187 	call	_cpct_getRandom_mxor_u8
   1170 7D            [ 4]  188 	ld	a,l
   1171 C1            [10]  189 	pop	bc
   1172 E1            [10]  190 	pop	hl
   1173 0F            [ 4]  191 	rrca
   1174 30 04         [12]  192 	jr	NC,00120$
   1176 06 82         [ 7]  193 	ld	b,#0x82
   1178 18 02         [12]  194 	jr	00121$
   117A                     195 00120$:
   117A 06 83         [ 7]  196 	ld	b,#0x83
   117C                     197 00121$:
   117C 70            [ 7]  198 	ld	(hl),b
                            199 ;src/Map.c:54: for(i=2;i<7;i+=2){
   117D 0C            [ 4]  200 	inc	c
   117E 0C            [ 4]  201 	inc	c
   117F 79            [ 4]  202 	ld	a,c
   1180 D6 07         [ 7]  203 	sub	a, #0x07
   1182 38 BF         [12]  204 	jr	C,00114$
                            205 ;src/Map.c:59: map[KING_LEVEL_EXIT_Y][KING_LEVEL_EXIT_X] = CELLTYPE_DOOR;
   1184 21 D4 88      [10]  206 	ld	hl,#0x88D4
   1187 36 80         [10]  207 	ld	(hl),#0x80
                            208 ;src/Map.c:62: while(player_get_direction_index()!=MOVEMENT_NORTH){
   1189                     209 00107$:
   1189 CD E6 18      [17]  210 	call	_player_get_direction_index
   118C 7D            [ 4]  211 	ld	a,l
   118D D6 02         [ 7]  212 	sub	a, #0x02
   118F 28 05         [12]  213 	jr	Z,00109$
                            214 ;src/Map.c:63: player_turn_left();
   1191 CD 79 18      [17]  215 	call	_player_turn_left
   1194 18 F3         [12]  216 	jr	00107$
   1196                     217 00109$:
                            218 ;src/Map.c:66: *(i8*)&(player_position.x) = KING_LEVEL_PLAYER_X;
   1196 21 75 18      [10]  219 	ld	hl,#_player_position
   1199 36 04         [10]  220 	ld	(hl),#0x04
                            221 ;src/Map.c:67: *(i8*)&(player_position.y) = KING_LEVEL_PLAYER_Y;
   119B 21 76 18      [10]  222 	ld	hl,#(_player_position + 0x0001)
   119E 36 07         [10]  223 	ld	(hl),#0x07
   11A0 C9            [10]  224 	ret
                            225 ;src/Map.c:71: void generate_map(){
                            226 ;	---------------------------------
                            227 ; Function generate_map
                            228 ; ---------------------------------
   11A1                     229 _generate_map::
   11A1 DD E5         [15]  230 	push	ix
   11A3 DD 21 00 00   [14]  231 	ld	ix,#0
   11A7 DD 39         [15]  232 	add	ix,sp
   11A9 21 EC FF      [10]  233 	ld	hl,#-20
   11AC 39            [11]  234 	add	hl,sp
   11AD F9            [ 6]  235 	ld	sp,hl
                            236 ;src/Map.c:74: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
   11AE DD 36 F2 83   [19]  237 	ld	-14 (ix),#0x83
   11B2 DD 36 F3 03   [19]  238 	ld	-13 (ix),#0x03
                            239 ;src/Map.c:80: u16 wallListCount = 0;
   11B6 DD 36 EE 00   [19]  240 	ld	-18 (ix),#0x00
   11BA DD 36 EF 00   [19]  241 	ld	-17 (ix),#0x00
                            242 ;src/Map.c:81: u16 lastStackItem = 0;
   11BE 21 00 00      [10]  243 	ld	hl,#0x0000
   11C1 E3            [19]  244 	ex	(sp), hl
                            245 ;src/Map.c:83: cpct_memset (GENERATOR_DATA_PTR, 0, 4096);
   11C2 21 00 10      [10]  246 	ld	hl,#0x1000
   11C5 E5            [11]  247 	push	hl
   11C6 AF            [ 4]  248 	xor	a, a
   11C7 F5            [11]  249 	push	af
   11C8 33            [ 6]  250 	inc	sp
   11C9 21 D0 8C      [10]  251 	ld	hl,#0x8CD0
   11CC E5            [11]  252 	push	hl
   11CD CD 9A 7B      [17]  253 	call	_cpct_memset
                            254 ;src/Map.c:85: (*cellStack).x = (cpct_getRandom_mxor_u8 ()%(MAP_WIDTH-2))+1; //RANDOM
   11D0 CD 97 7A      [17]  255 	call	_cpct_getRandom_mxor_u8
   11D3 45            [ 4]  256 	ld	b,l
   11D4 3E 1E         [ 7]  257 	ld	a,#0x1E
   11D6 F5            [11]  258 	push	af
   11D7 33            [ 6]  259 	inc	sp
   11D8 C5            [11]  260 	push	bc
   11D9 33            [ 6]  261 	inc	sp
   11DA CD 39 7A      [17]  262 	call	__moduchar
   11DD F1            [10]  263 	pop	af
   11DE 4D            [ 4]  264 	ld	c,l
   11DF 0C            [ 4]  265 	inc	c
   11E0 21 D0 8C      [10]  266 	ld	hl,#0x8CD0
   11E3 71            [ 7]  267 	ld	(hl),c
                            268 ;src/Map.c:86: (*cellStack).y = (cpct_getRandom_mxor_u8 ()%(MAP_HEIGHT-2))+1; //RANDOM
   11E4 CD 97 7A      [17]  269 	call	_cpct_getRandom_mxor_u8
   11E7 45            [ 4]  270 	ld	b,l
   11E8 3E 1E         [ 7]  271 	ld	a,#0x1E
   11EA F5            [11]  272 	push	af
   11EB 33            [ 6]  273 	inc	sp
   11EC C5            [11]  274 	push	bc
   11ED 33            [ 6]  275 	inc	sp
   11EE CD 39 7A      [17]  276 	call	__moduchar
   11F1 F1            [10]  277 	pop	af
   11F2 4D            [ 4]  278 	ld	c,l
   11F3 0C            [ 4]  279 	inc	c
   11F4 21 D1 8C      [10]  280 	ld	hl,#0x8CD1
   11F7 71            [ 7]  281 	ld	(hl),c
                            282 ;src/Map.c:88: rotatePlayer = cpct_getRandom_mxor_u8 ()%4;
   11F8 CD 97 7A      [17]  283 	call	_cpct_getRandom_mxor_u8
   11FB 7D            [ 4]  284 	ld	a,l
   11FC E6 03         [ 7]  285 	and	a, #0x03
   11FE 4F            [ 4]  286 	ld	c,a
                            287 ;src/Map.c:89: while(rotatePlayer){
   11FF                     288 00101$:
   11FF 79            [ 4]  289 	ld	a,c
   1200 B7            [ 4]  290 	or	a, a
   1201 28 08         [12]  291 	jr	Z,00103$
                            292 ;src/Map.c:90: player_turn_left();
   1203 C5            [11]  293 	push	bc
   1204 CD 79 18      [17]  294 	call	_player_turn_left
   1207 C1            [10]  295 	pop	bc
                            296 ;src/Map.c:91: --rotatePlayer;
   1208 0D            [ 4]  297 	dec	c
   1209 18 F4         [12]  298 	jr	00101$
   120B                     299 00103$:
                            300 ;src/Map.c:94: *(i8*)&(player_position.x) = (*cellStack).y;
   120B 01 75 18      [10]  301 	ld	bc,#_player_position+0
   120E 3A D1 8C      [13]  302 	ld	a,(#0x8CD1)
   1211 02            [ 7]  303 	ld	(bc),a
                            304 ;src/Map.c:95: *(i8*)&(player_position.y) = (*cellStack).x;
   1212 01 76 18      [10]  305 	ld	bc,#_player_position+1
   1215 3A D0 8C      [13]  306 	ld	a,(#0x8CD0)
   1218 02            [ 7]  307 	ld	(bc),a
                            308 ;src/Map.c:97: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   1219 21 00 04      [10]  309 	ld	hl,#0x0400
   121C E5            [11]  310 	push	hl
   121D 3E 87         [ 7]  311 	ld	a,#0x87
   121F F5            [11]  312 	push	af
   1220 33            [ 6]  313 	inc	sp
   1221 21 D0 88      [10]  314 	ld	hl,#0x88D0
   1224 E5            [11]  315 	push	hl
   1225 CD 9A 7B      [17]  316 	call	_cpct_memset
                            317 ;src/Map.c:100: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   1228 21 D0 8C      [10]  318 	ld	hl,#0x8CD0
   122B 6E            [ 7]  319 	ld	l,(hl)
   122C 26 00         [ 7]  320 	ld	h,#0x00
   122E 29            [11]  321 	add	hl, hl
   122F 29            [11]  322 	add	hl, hl
   1230 29            [11]  323 	add	hl, hl
   1231 29            [11]  324 	add	hl, hl
   1232 29            [11]  325 	add	hl, hl
   1233 01 D0 88      [10]  326 	ld	bc,#0x88D0
   1236 09            [11]  327 	add	hl,bc
   1237 4D            [ 4]  328 	ld	c,l
   1238 44            [ 4]  329 	ld	b,h
   1239 21 D1 8C      [10]  330 	ld	hl,#0x8CD1
   123C 6E            [ 7]  331 	ld	l, (hl)
   123D 26 00         [ 7]  332 	ld	h,#0x00
   123F 09            [11]  333 	add	hl,bc
   1240 36 00         [10]  334 	ld	(hl),#0x00
                            335 ;src/Map.c:103: for(i=0;i<MAP_WIDTH;++i){
   1242 0E 00         [ 7]  336 	ld	c,#0x00
   1244                     337 00170$:
                            338 ;src/Map.c:104: map[0][i]=CELLTYPE_WALL1;//get_random_wall();
   1244 21 D0 88      [10]  339 	ld	hl,#0x88D0
   1247 06 00         [ 7]  340 	ld	b,#0x00
   1249 09            [11]  341 	add	hl, bc
   124A 36 81         [10]  342 	ld	(hl),#0x81
                            343 ;src/Map.c:105: map[MAP_HEIGHT-1][i]=CELLTYPE_WALL1;//get_random_wall();
   124C 21 B0 8C      [10]  344 	ld	hl,#0x8CB0
   124F 06 00         [ 7]  345 	ld	b,#0x00
   1251 09            [11]  346 	add	hl, bc
   1252 36 81         [10]  347 	ld	(hl),#0x81
                            348 ;src/Map.c:103: for(i=0;i<MAP_WIDTH;++i){
   1254 0C            [ 4]  349 	inc	c
   1255 79            [ 4]  350 	ld	a,c
   1256 D6 20         [ 7]  351 	sub	a, #0x20
   1258 38 EA         [12]  352 	jr	C,00170$
                            353 ;src/Map.c:108: for(i=0;i<MAP_HEIGHT-1;++i){
   125A 0E 00         [ 7]  354 	ld	c,#0x00
   125C                     355 00172$:
                            356 ;src/Map.c:109: map[i][0]=CELLTYPE_WALL1;//get_random_wall();
   125C 69            [ 4]  357 	ld	l,c
   125D 26 00         [ 7]  358 	ld	h,#0x00
   125F 29            [11]  359 	add	hl, hl
   1260 29            [11]  360 	add	hl, hl
   1261 29            [11]  361 	add	hl, hl
   1262 29            [11]  362 	add	hl, hl
   1263 29            [11]  363 	add	hl, hl
   1264 EB            [ 4]  364 	ex	de,hl
   1265 21 D0 88      [10]  365 	ld	hl,#0x88D0
   1268 19            [11]  366 	add	hl,de
   1269 36 81         [10]  367 	ld	(hl),#0x81
                            368 ;src/Map.c:110: map[i][MAP_WIDTH-1]=CELLTYPE_WALL1;//get_random_wall();
   126B 21 D0 88      [10]  369 	ld	hl,#0x88D0
   126E 19            [11]  370 	add	hl,de
   126F 11 1F 00      [10]  371 	ld	de,#0x001F
   1272 19            [11]  372 	add	hl,de
   1273 36 81         [10]  373 	ld	(hl),#0x81
                            374 ;src/Map.c:108: for(i=0;i<MAP_HEIGHT-1;++i){
   1275 0C            [ 4]  375 	inc	c
   1276 79            [ 4]  376 	ld	a,c
   1277 D6 1F         [ 7]  377 	sub	a, #0x1F
   1279 38 E1         [12]  378 	jr	C,00172$
                            379 ;src/Map.c:113: while(remainingCells>0){
   127B 21 04 00      [10]  380 	ld	hl,#0x0004
   127E 39            [11]  381 	add	hl,sp
   127F DD 75 FA      [19]  382 	ld	-6 (ix),l
   1282 DD 74 FB      [19]  383 	ld	-5 (ix),h
   1285                     384 00167$:
   1285 DD 7E F3      [19]  385 	ld	a,-13 (ix)
   1288 DD B6 F2      [19]  386 	or	a,-14 (ix)
   128B CA 54 16      [10]  387 	jp	Z,00174$
                            388 ;src/Map.c:114: wallListPosition = wallList+wallListCount;
   128E C1            [10]  389 	pop	bc
   128F E1            [10]  390 	pop	hl
   1290 E5            [11]  391 	push	hl
   1291 C5            [11]  392 	push	bc
   1292 29            [11]  393 	add	hl, hl
   1293 7D            [ 4]  394 	ld	a,l
   1294 C6 D0         [ 7]  395 	add	a, #0xD0
   1296 DD 77 FC      [19]  396 	ld	-4 (ix),a
   1299 7C            [ 4]  397 	ld	a,h
   129A CE 90         [ 7]  398 	adc	a, #0x90
   129C DD 77 FD      [19]  399 	ld	-3 (ix),a
                            400 ;src/Map.c:115: while(wallListCount<MAP_SIZE){
   129F D1            [10]  401 	pop	de
   12A0 C1            [10]  402 	pop	bc
   12A1 C5            [11]  403 	push	bc
   12A2 D5            [11]  404 	push	de
   12A3                     405 00137$:
                            406 ;src/Map.c:118: currentPos.y = (*wallListPosition).y;
   12A3 DD 7E FA      [19]  407 	ld	a,-6 (ix)
   12A6 C6 01         [ 7]  408 	add	a, #0x01
   12A8 DD 77 FE      [19]  409 	ld	-2 (ix),a
   12AB DD 7E FB      [19]  410 	ld	a,-5 (ix)
   12AE CE 00         [ 7]  411 	adc	a, #0x00
   12B0 DD 77 FF      [19]  412 	ld	-1 (ix),a
                            413 ;src/Map.c:115: while(wallListCount<MAP_SIZE){
   12B3 78            [ 4]  414 	ld	a,b
   12B4 D6 04         [ 7]  415 	sub	a, #0x04
   12B6 D2 55 14      [10]  416 	jp	NC,00209$
                            417 ;src/Map.c:117: currentPos.x = (*wallListPosition).x;
   12B9 21 04 00      [10]  418 	ld	hl,#0x0004
   12BC 39            [11]  419 	add	hl,sp
   12BD EB            [ 4]  420 	ex	de,hl
   12BE DD 6E FC      [19]  421 	ld	l,-4 (ix)
   12C1 DD 66 FD      [19]  422 	ld	h,-3 (ix)
   12C4 7E            [ 7]  423 	ld	a,(hl)
   12C5 12            [ 7]  424 	ld	(de),a
                            425 ;src/Map.c:118: currentPos.y = (*wallListPosition).y;
   12C6 DD 5E FC      [19]  426 	ld	e,-4 (ix)
   12C9 DD 56 FD      [19]  427 	ld	d,-3 (ix)
   12CC 13            [ 6]  428 	inc	de
   12CD 1A            [ 7]  429 	ld	a,(de)
   12CE DD 6E FE      [19]  430 	ld	l,-2 (ix)
   12D1 DD 66 FF      [19]  431 	ld	h,-1 (ix)
   12D4 77            [ 7]  432 	ld	(hl),a
                            433 ;src/Map.c:120: convertToFloor=0;
   12D5 DD 36 F4 00   [19]  434 	ld	-12 (ix),#0x00
                            435 ;src/Map.c:121: surroundedByWalls=1;
   12D9 DD 36 F5 01   [19]  436 	ld	-11 (ix),#0x01
                            437 ;src/Map.c:123: if(currentPos.x>0){
   12DD DD 6E FA      [19]  438 	ld	l,-6 (ix)
   12E0 DD 66 FB      [19]  439 	ld	h,-5 (ix)
   12E3 7E            [ 7]  440 	ld	a,(hl)
   12E4 DD 77 F8      [19]  441 	ld	-8 (ix),a
                            442 ;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
   12E7 DD 6E FE      [19]  443 	ld	l,-2 (ix)
   12EA DD 66 FF      [19]  444 	ld	h,-1 (ix)
   12ED 7E            [ 7]  445 	ld	a,(hl)
   12EE DD 77 F9      [19]  446 	ld	-7 (ix),a
   12F1 DD 7E F8      [19]  447 	ld	a,-8 (ix)
   12F4 DD 77 F6      [19]  448 	ld	-10 (ix),a
   12F7 DD 36 F7 00   [19]  449 	ld	-9 (ix),#0x00
                            450 ;src/Map.c:123: if(currentPos.x>0){
   12FB DD 7E F8      [19]  451 	ld	a,-8 (ix)
   12FE B7            [ 4]  452 	or	a, a
   12FF 28 2F         [12]  453 	jr	Z,00112$
                            454 ;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
   1301 DD 6E F6      [19]  455 	ld	l,-10 (ix)
   1304 DD 66 F7      [19]  456 	ld	h,-9 (ix)
   1307 2B            [ 6]  457 	dec	hl
   1308 29            [11]  458 	add	hl, hl
   1309 29            [11]  459 	add	hl, hl
   130A 29            [11]  460 	add	hl, hl
   130B 29            [11]  461 	add	hl, hl
   130C 29            [11]  462 	add	hl, hl
   130D D5            [11]  463 	push	de
   130E 11 D0 88      [10]  464 	ld	de,#0x88D0
   1311 19            [11]  465 	add	hl, de
   1312 D1            [10]  466 	pop	de
   1313 7D            [ 4]  467 	ld	a,l
   1314 DD 86 F9      [19]  468 	add	a, -7 (ix)
   1317 6F            [ 4]  469 	ld	l,a
   1318 7C            [ 4]  470 	ld	a,h
   1319 CE 00         [ 7]  471 	adc	a, #0x00
   131B 67            [ 4]  472 	ld	h,a
   131C 6E            [ 7]  473 	ld	l,(hl)
                            474 ;src/Map.c:125: if(adjacentType == CELLTYPE_UNDEFINED){
   131D 7D            [ 4]  475 	ld	a,l
   131E D6 87         [ 7]  476 	sub	a, #0x87
   1320 20 06         [12]  477 	jr	NZ,00109$
                            478 ;src/Map.c:126: convertToFloor  = 1;
   1322 DD 36 F4 01   [19]  479 	ld	-12 (ix),#0x01
   1326 18 08         [12]  480 	jr	00112$
   1328                     481 00109$:
                            482 ;src/Map.c:128: else if(adjacentType == CELLTYPE_FLOOR){
   1328 7D            [ 4]  483 	ld	a,l
   1329 B7            [ 4]  484 	or	a, a
   132A 20 04         [12]  485 	jr	NZ,00112$
                            486 ;src/Map.c:129: surroundedByWalls = 0;
   132C DD 36 F5 00   [19]  487 	ld	-11 (ix),#0x00
   1330                     488 00112$:
                            489 ;src/Map.c:132: if(currentPos.x < (MAP_WIDTH-1)){
   1330 DD 7E F8      [19]  490 	ld	a,-8 (ix)
   1333 D6 1F         [ 7]  491 	sub	a, #0x1F
   1335 30 2F         [12]  492 	jr	NC,00119$
                            493 ;src/Map.c:134: adjacentType = map[currentPos.x+1][currentPos.y];
   1337 DD 6E F6      [19]  494 	ld	l,-10 (ix)
   133A DD 66 F7      [19]  495 	ld	h,-9 (ix)
   133D 23            [ 6]  496 	inc	hl
   133E 29            [11]  497 	add	hl, hl
   133F 29            [11]  498 	add	hl, hl
   1340 29            [11]  499 	add	hl, hl
   1341 29            [11]  500 	add	hl, hl
   1342 29            [11]  501 	add	hl, hl
   1343 D5            [11]  502 	push	de
   1344 11 D0 88      [10]  503 	ld	de,#0x88D0
   1347 19            [11]  504 	add	hl, de
   1348 D1            [10]  505 	pop	de
   1349 7D            [ 4]  506 	ld	a,l
   134A DD 86 F9      [19]  507 	add	a, -7 (ix)
   134D 6F            [ 4]  508 	ld	l,a
   134E 7C            [ 4]  509 	ld	a,h
   134F CE 00         [ 7]  510 	adc	a, #0x00
   1351 67            [ 4]  511 	ld	h,a
   1352 6E            [ 7]  512 	ld	l,(hl)
                            513 ;src/Map.c:135: if(adjacentType == CELLTYPE_UNDEFINED){
   1353 7D            [ 4]  514 	ld	a,l
   1354 D6 87         [ 7]  515 	sub	a, #0x87
   1356 20 06         [12]  516 	jr	NZ,00116$
                            517 ;src/Map.c:136: convertToFloor  = 1;
   1358 DD 36 F4 01   [19]  518 	ld	-12 (ix),#0x01
   135C 18 08         [12]  519 	jr	00119$
   135E                     520 00116$:
                            521 ;src/Map.c:138: else if(adjacentType == CELLTYPE_FLOOR){
   135E 7D            [ 4]  522 	ld	a,l
   135F B7            [ 4]  523 	or	a, a
   1360 20 04         [12]  524 	jr	NZ,00119$
                            525 ;src/Map.c:139: surroundedByWalls = 0;
   1362 DD 36 F5 00   [19]  526 	ld	-11 (ix),#0x00
   1366                     527 00119$:
                            528 ;src/Map.c:144: adjacentType = map[currentPos.x][currentPos.y-1];
   1366 DD 6E F6      [19]  529 	ld	l,-10 (ix)
   1369 DD 66 F7      [19]  530 	ld	h,-9 (ix)
   136C 29            [11]  531 	add	hl, hl
   136D 29            [11]  532 	add	hl, hl
   136E 29            [11]  533 	add	hl, hl
   136F 29            [11]  534 	add	hl, hl
   1370 29            [11]  535 	add	hl, hl
   1371 7D            [ 4]  536 	ld	a,l
   1372 C6 D0         [ 7]  537 	add	a, #0xD0
   1374 DD 77 F6      [19]  538 	ld	-10 (ix),a
   1377 7C            [ 4]  539 	ld	a,h
   1378 CE 88         [ 7]  540 	adc	a, #0x88
   137A DD 77 F7      [19]  541 	ld	-9 (ix),a
                            542 ;src/Map.c:142: if(currentPos.y > 0){
   137D DD 7E F9      [19]  543 	ld	a,-7 (ix)
   1380 B7            [ 4]  544 	or	a, a
   1381 28 23         [12]  545 	jr	Z,00126$
                            546 ;src/Map.c:144: adjacentType = map[currentPos.x][currentPos.y-1];
   1383 DD 6E F9      [19]  547 	ld	l,-7 (ix)
   1386 2D            [ 4]  548 	dec	l
   1387 DD 7E F6      [19]  549 	ld	a,-10 (ix)
   138A 85            [ 4]  550 	add	a, l
   138B 6F            [ 4]  551 	ld	l,a
   138C DD 7E F7      [19]  552 	ld	a,-9 (ix)
   138F CE 00         [ 7]  553 	adc	a, #0x00
   1391 67            [ 4]  554 	ld	h,a
   1392 6E            [ 7]  555 	ld	l,(hl)
                            556 ;src/Map.c:145: if(adjacentType == CELLTYPE_UNDEFINED){
   1393 7D            [ 4]  557 	ld	a,l
   1394 D6 87         [ 7]  558 	sub	a, #0x87
   1396 20 06         [12]  559 	jr	NZ,00123$
                            560 ;src/Map.c:146: convertToFloor  = 1;
   1398 DD 36 F4 01   [19]  561 	ld	-12 (ix),#0x01
   139C 18 08         [12]  562 	jr	00126$
   139E                     563 00123$:
                            564 ;src/Map.c:148: else if(adjacentType == CELLTYPE_FLOOR){
   139E 7D            [ 4]  565 	ld	a,l
   139F B7            [ 4]  566 	or	a, a
   13A0 20 04         [12]  567 	jr	NZ,00126$
                            568 ;src/Map.c:149: surroundedByWalls = 0;
   13A2 DD 36 F5 00   [19]  569 	ld	-11 (ix),#0x00
   13A6                     570 00126$:
                            571 ;src/Map.c:152: if(currentPos.y < (MAP_HEIGHT-1)){
   13A6 DD 7E F9      [19]  572 	ld	a,-7 (ix)
   13A9 D6 1F         [ 7]  573 	sub	a, #0x1F
   13AB 30 23         [12]  574 	jr	NC,00133$
                            575 ;src/Map.c:154: adjacentType = map[currentPos.x][currentPos.y+1];
   13AD DD 6E F9      [19]  576 	ld	l,-7 (ix)
   13B0 2C            [ 4]  577 	inc	l
   13B1 DD 7E F6      [19]  578 	ld	a,-10 (ix)
   13B4 85            [ 4]  579 	add	a, l
   13B5 6F            [ 4]  580 	ld	l,a
   13B6 DD 7E F7      [19]  581 	ld	a,-9 (ix)
   13B9 CE 00         [ 7]  582 	adc	a, #0x00
   13BB 67            [ 4]  583 	ld	h,a
   13BC 6E            [ 7]  584 	ld	l,(hl)
                            585 ;src/Map.c:155: if(adjacentType == CELLTYPE_UNDEFINED){
   13BD 7D            [ 4]  586 	ld	a,l
   13BE D6 87         [ 7]  587 	sub	a, #0x87
   13C0 20 06         [12]  588 	jr	NZ,00130$
                            589 ;src/Map.c:156: convertToFloor  = 1;
   13C2 DD 36 F4 01   [19]  590 	ld	-12 (ix),#0x01
   13C6 18 08         [12]  591 	jr	00133$
   13C8                     592 00130$:
                            593 ;src/Map.c:158: else if(adjacentType == CELLTYPE_FLOOR){
   13C8 7D            [ 4]  594 	ld	a,l
   13C9 B7            [ 4]  595 	or	a, a
   13CA 20 04         [12]  596 	jr	NZ,00133$
                            597 ;src/Map.c:159: surroundedByWalls = 0;
   13CC DD 36 F5 00   [19]  598 	ld	-11 (ix),#0x00
   13D0                     599 00133$:
                            600 ;src/Map.c:163: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   13D0 69            [ 4]  601 	ld	l, c
   13D1 60            [ 4]  602 	ld	h, b
   13D2 29            [11]  603 	add	hl, hl
   13D3 FD 21 D0 90   [14]  604 	ld	iy,#0x90D0
   13D7 C5            [11]  605 	push	bc
   13D8 4D            [ 4]  606 	ld	c, l
   13D9 44            [ 4]  607 	ld	b, h
   13DA FD 09         [15]  608 	add	iy, bc
   13DC C1            [10]  609 	pop	bc
   13DD FD 7E 00      [19]  610 	ld	a, 0 (iy)
   13E0 DD 6E FC      [19]  611 	ld	l,-4 (ix)
   13E3 DD 66 FD      [19]  612 	ld	h,-3 (ix)
   13E6 77            [ 7]  613 	ld	(hl),a
                            614 ;src/Map.c:164: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   13E7 FD E5         [15]  615 	push	iy
   13E9 E1            [10]  616 	pop	hl
   13EA 23            [ 6]  617 	inc	hl
   13EB 7E            [ 7]  618 	ld	a,(hl)
   13EC 12            [ 7]  619 	ld	(de),a
                            620 ;src/Map.c:165: --wallListCount;
   13ED 0B            [ 6]  621 	dec	bc
   13EE DD 71 EE      [19]  622 	ld	-18 (ix),c
   13F1 DD 70 EF      [19]  623 	ld	-17 (ix),b
                            624 ;src/Map.c:168: if((convertToFloor)&&(!surroundedByWalls)){
   13F4 DD 7E F4      [19]  625 	ld	a,-12 (ix)
   13F7 B7            [ 4]  626 	or	a, a
   13F8 28 4A         [12]  627 	jr	Z,00135$
   13FA DD 7E F5      [19]  628 	ld	a,-11 (ix)
   13FD B7            [ 4]  629 	or	a, a
   13FE 20 44         [12]  630 	jr	NZ,00135$
                            631 ;src/Map.c:169: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   1400 DD 6E FA      [19]  632 	ld	l,-6 (ix)
   1403 DD 66 FB      [19]  633 	ld	h,-5 (ix)
   1406 6E            [ 7]  634 	ld	l,(hl)
   1407 26 00         [ 7]  635 	ld	h,#0x00
   1409 29            [11]  636 	add	hl, hl
   140A 29            [11]  637 	add	hl, hl
   140B 29            [11]  638 	add	hl, hl
   140C 29            [11]  639 	add	hl, hl
   140D 29            [11]  640 	add	hl, hl
   140E 01 D0 88      [10]  641 	ld	bc,#0x88D0
   1411 09            [11]  642 	add	hl,bc
   1412 4D            [ 4]  643 	ld	c,l
   1413 44            [ 4]  644 	ld	b,h
   1414 DD 6E FE      [19]  645 	ld	l,-2 (ix)
   1417 DD 66 FF      [19]  646 	ld	h,-1 (ix)
   141A 6E            [ 7]  647 	ld	l, (hl)
   141B 26 00         [ 7]  648 	ld	h,#0x00
   141D 09            [11]  649 	add	hl,bc
   141E 36 00         [10]  650 	ld	(hl),#0x00
                            651 ;src/Map.c:171: ++lastStackItem;
   1420 DD 34 EC      [23]  652 	inc	-20 (ix)
   1423 20 03         [12]  653 	jr	NZ,00334$
   1425 DD 34 ED      [23]  654 	inc	-19 (ix)
   1428                     655 00334$:
                            656 ;src/Map.c:172: (*(cellStack+lastStackItem)).x = currentPos.x;
   1428 E1            [10]  657 	pop	hl
   1429 E5            [11]  658 	push	hl
   142A 29            [11]  659 	add	hl, hl
   142B 01 D0 8C      [10]  660 	ld	bc, #0x8CD0
   142E 09            [11]  661 	add	hl,bc
   142F 4D            [ 4]  662 	ld	c, l
   1430 44            [ 4]  663 	ld	b, h
   1431 DD 6E FA      [19]  664 	ld	l,-6 (ix)
   1434 DD 66 FB      [19]  665 	ld	h,-5 (ix)
   1437 7E            [ 7]  666 	ld	a,(hl)
   1438 02            [ 7]  667 	ld	(bc),a
                            668 ;src/Map.c:173: (*(cellStack+lastStackItem)).y = currentPos.y;
   1439 03            [ 6]  669 	inc	bc
   143A DD 6E FE      [19]  670 	ld	l,-2 (ix)
   143D DD 66 FF      [19]  671 	ld	h,-1 (ix)
   1440 7E            [ 7]  672 	ld	a,(hl)
   1441 02            [ 7]  673 	ld	(bc),a
                            674 ;src/Map.c:176: break;
   1442 18 11         [12]  675 	jr	00209$
   1444                     676 00135$:
                            677 ;src/Map.c:178: --wallListPosition;
   1444 DD 6E FC      [19]  678 	ld	l,-4 (ix)
   1447 DD 66 FD      [19]  679 	ld	h,-3 (ix)
   144A 2B            [ 6]  680 	dec	hl
   144B 2B            [ 6]  681 	dec	hl
   144C DD 75 FC      [19]  682 	ld	-4 (ix),l
   144F DD 74 FD      [19]  683 	ld	-3 (ix),h
   1452 C3 A3 12      [10]  684 	jp	00137$
                            685 ;src/Map.c:180: while(lastStackItem<MAP_SIZE){
   1455                     686 00209$:
   1455 DD 7E F2      [19]  687 	ld	a,-14 (ix)
   1458 DD 77 F6      [19]  688 	ld	-10 (ix),a
   145B DD 7E F3      [19]  689 	ld	a,-13 (ix)
   145E DD 77 F7      [19]  690 	ld	-9 (ix),a
   1461 DD 7E EE      [19]  691 	ld	a,-18 (ix)
   1464 DD 77 FC      [19]  692 	ld	-4 (ix),a
   1467 DD 7E EF      [19]  693 	ld	a,-17 (ix)
   146A DD 77 FD      [19]  694 	ld	-3 (ix),a
   146D                     695 00164$:
   146D DD 7E ED      [19]  696 	ld	a,-19 (ix)
   1470 D6 04         [ 7]  697 	sub	a, #0x04
   1472 D2 85 12      [10]  698 	jp	NC,00167$
                            699 ;src/Map.c:181: currentPos.x=(*(lastStackItem+cellStack)).x;
   1475 21 04 00      [10]  700 	ld	hl,#0x0004
   1478 39            [11]  701 	add	hl,sp
   1479 4D            [ 4]  702 	ld	c,l
   147A 44            [ 4]  703 	ld	b,h
   147B E1            [10]  704 	pop	hl
   147C E5            [11]  705 	push	hl
   147D 29            [11]  706 	add	hl, hl
   147E FD 21 D0 8C   [14]  707 	ld	iy,#0x8CD0
   1482 EB            [ 4]  708 	ex	de,hl
   1483 FD 19         [15]  709 	add	iy, de
   1485 FD 7E 00      [19]  710 	ld	a, 0 (iy)
   1488 02            [ 7]  711 	ld	(bc),a
                            712 ;src/Map.c:182: currentPos.y=(*(lastStackItem+cellStack)).y;
   1489 FD 4E 01      [19]  713 	ld	c,1 (iy)
   148C DD 6E FE      [19]  714 	ld	l,-2 (ix)
   148F DD 66 FF      [19]  715 	ld	h,-1 (ix)
   1492 71            [ 7]  716 	ld	(hl),c
                            717 ;src/Map.c:183: --lastStackItem;
   1493 E1            [10]  718 	pop	hl
   1494 E5            [11]  719 	push	hl
   1495 2B            [ 6]  720 	dec	hl
   1496 E3            [19]  721 	ex	(sp), hl
                            722 ;src/Map.c:184: cellType = map[currentPos.x][currentPos.y];
   1497 DD 6E FA      [19]  723 	ld	l,-6 (ix)
   149A DD 66 FB      [19]  724 	ld	h,-5 (ix)
   149D 6E            [ 7]  725 	ld	l,(hl)
   149E 26 00         [ 7]  726 	ld	h,#0x00
   14A0 29            [11]  727 	add	hl, hl
   14A1 29            [11]  728 	add	hl, hl
   14A2 29            [11]  729 	add	hl, hl
   14A3 29            [11]  730 	add	hl, hl
   14A4 29            [11]  731 	add	hl, hl
   14A5 11 D0 88      [10]  732 	ld	de,#0x88D0
   14A8 19            [11]  733 	add	hl,de
   14A9 59            [ 4]  734 	ld	e,c
   14AA 16 00         [ 7]  735 	ld	d,#0x00
   14AC 19            [11]  736 	add	hl,de
   14AD 4E            [ 7]  737 	ld	c,(hl)
                            738 ;src/Map.c:186: if(cellType == CELLTYPE_UNDEFINED){
   14AE 79            [ 4]  739 	ld	a,c
   14AF D6 87         [ 7]  740 	sub	a, #0x87
   14B1 20 47         [12]  741 	jr	NZ,00144$
                            742 ;src/Map.c:188: if(cpct_getRandom_mxor_u8 ()&1){//WALL
   14B3 CD 97 7A      [17]  743 	call	_cpct_getRandom_mxor_u8
   14B6 CB 45         [ 8]  744 	bit	0, l
   14B8 28 06         [12]  745 	jr	Z,00141$
                            746 ;src/Map.c:189: cellType = get_random_wall();
   14BA CD F2 10      [17]  747 	call	_get_random_wall
   14BD 4D            [ 4]  748 	ld	c,l
   14BE 18 02         [12]  749 	jr	00142$
   14C0                     750 00141$:
                            751 ;src/Map.c:192: cellType = CELLTYPE_FLOOR;
   14C0 0E 00         [ 7]  752 	ld	c,#0x00
   14C2                     753 00142$:
                            754 ;src/Map.c:194: map[currentPos.x][currentPos.y]=cellType;
   14C2 DD 6E FA      [19]  755 	ld	l,-6 (ix)
   14C5 DD 66 FB      [19]  756 	ld	h,-5 (ix)
   14C8 6E            [ 7]  757 	ld	l,(hl)
   14C9 26 00         [ 7]  758 	ld	h,#0x00
   14CB 29            [11]  759 	add	hl, hl
   14CC 29            [11]  760 	add	hl, hl
   14CD 29            [11]  761 	add	hl, hl
   14CE 29            [11]  762 	add	hl, hl
   14CF 29            [11]  763 	add	hl, hl
   14D0 EB            [ 4]  764 	ex	de,hl
   14D1 21 D0 88      [10]  765 	ld	hl,#0x88D0
   14D4 19            [11]  766 	add	hl,de
   14D5 EB            [ 4]  767 	ex	de,hl
   14D6 DD 6E FE      [19]  768 	ld	l,-2 (ix)
   14D9 DD 66 FF      [19]  769 	ld	h,-1 (ix)
   14DC 6E            [ 7]  770 	ld	l, (hl)
   14DD 26 00         [ 7]  771 	ld	h,#0x00
   14DF 19            [11]  772 	add	hl,de
   14E0 71            [ 7]  773 	ld	(hl),c
                            774 ;src/Map.c:195: --remainingCells;
   14E1 DD 6E F6      [19]  775 	ld	l,-10 (ix)
   14E4 DD 66 F7      [19]  776 	ld	h,-9 (ix)
   14E7 2B            [ 6]  777 	dec	hl
   14E8 DD 75 F6      [19]  778 	ld	-10 (ix),l
   14EB DD 74 F7      [19]  779 	ld	-9 (ix),h
   14EE DD 7E F6      [19]  780 	ld	a,-10 (ix)
   14F1 DD 77 F2      [19]  781 	ld	-14 (ix),a
   14F4 DD 7E F7      [19]  782 	ld	a,-9 (ix)
   14F7 DD 77 F3      [19]  783 	ld	-13 (ix),a
   14FA                     784 00144$:
                            785 ;src/Map.c:123: if(currentPos.x>0){
   14FA DD 6E FA      [19]  786 	ld	l,-6 (ix)
   14FD DD 66 FB      [19]  787 	ld	h,-5 (ix)
   1500 7E            [ 7]  788 	ld	a,(hl)
   1501 DD 77 F9      [19]  789 	ld	-7 (ix),a
                            790 ;src/Map.c:198: if((cellType == CELLTYPE_FLOOR)){
   1504 79            [ 4]  791 	ld	a,c
   1505 B7            [ 4]  792 	or	a, a
   1506 C2 23 16      [10]  793 	jp	NZ,00162$
                            794 ;src/Map.c:199: if(currentPos.x>0){
   1509 DD 7E F9      [19]  795 	ld	a,-7 (ix)
   150C B7            [ 4]  796 	or	a, a
   150D 28 3F         [12]  797 	jr	Z,00148$
                            798 ;src/Map.c:200: adjacentType = map[currentPos.x-1][currentPos.y];
   150F DD 6E F9      [19]  799 	ld	l,-7 (ix)
   1512 26 00         [ 7]  800 	ld	h,#0x00
   1514 2B            [ 6]  801 	dec	hl
   1515 29            [11]  802 	add	hl, hl
   1516 29            [11]  803 	add	hl, hl
   1517 29            [11]  804 	add	hl, hl
   1518 29            [11]  805 	add	hl, hl
   1519 29            [11]  806 	add	hl, hl
   151A 01 D0 88      [10]  807 	ld	bc,#0x88D0
   151D 09            [11]  808 	add	hl,bc
   151E 4D            [ 4]  809 	ld	c,l
   151F 44            [ 4]  810 	ld	b,h
   1520 DD 6E FE      [19]  811 	ld	l,-2 (ix)
   1523 DD 66 FF      [19]  812 	ld	h,-1 (ix)
   1526 6E            [ 7]  813 	ld	l, (hl)
   1527 26 00         [ 7]  814 	ld	h,#0x00
   1529 09            [11]  815 	add	hl,bc
   152A 7E            [ 7]  816 	ld	a,(hl)
                            817 ;src/Map.c:201: if(adjacentType == CELLTYPE_UNDEFINED){
   152B D6 87         [ 7]  818 	sub	a, #0x87
   152D 20 1F         [12]  819 	jr	NZ,00148$
                            820 ;src/Map.c:203: ++lastStackItem;
   152F DD 34 EC      [23]  821 	inc	-20 (ix)
   1532 20 03         [12]  822 	jr	NZ,00340$
   1534 DD 34 ED      [23]  823 	inc	-19 (ix)
   1537                     824 00340$:
                            825 ;src/Map.c:204: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   1537 E1            [10]  826 	pop	hl
   1538 E5            [11]  827 	push	hl
   1539 29            [11]  828 	add	hl, hl
   153A 01 D0 8C      [10]  829 	ld	bc,#0x8CD0
   153D 09            [11]  830 	add	hl,bc
   153E DD 4E F9      [19]  831 	ld	c,-7 (ix)
   1541 0D            [ 4]  832 	dec	c
   1542 71            [ 7]  833 	ld	(hl),c
                            834 ;src/Map.c:205: (*(cellStack+lastStackItem)).y = currentPos.y;
   1543 23            [ 6]  835 	inc	hl
   1544 4D            [ 4]  836 	ld	c,l
   1545 44            [ 4]  837 	ld	b,h
   1546 DD 6E FE      [19]  838 	ld	l,-2 (ix)
   1549 DD 66 FF      [19]  839 	ld	h,-1 (ix)
   154C 7E            [ 7]  840 	ld	a,(hl)
   154D 02            [ 7]  841 	ld	(bc),a
   154E                     842 00148$:
                            843 ;src/Map.c:209: if(currentPos.x < (MAP_WIDTH-1)){
   154E DD 6E FA      [19]  844 	ld	l,-6 (ix)
   1551 DD 66 FB      [19]  845 	ld	h,-5 (ix)
   1554 4E            [ 7]  846 	ld	c,(hl)
   1555 79            [ 4]  847 	ld	a,c
   1556 D6 1F         [ 7]  848 	sub	a, #0x1F
   1558 30 3A         [12]  849 	jr	NC,00152$
                            850 ;src/Map.c:211: adjacentType = map[currentPos.x+1][currentPos.y];
   155A 69            [ 4]  851 	ld	l,c
   155B 26 00         [ 7]  852 	ld	h,#0x00
   155D 23            [ 6]  853 	inc	hl
   155E 29            [11]  854 	add	hl, hl
   155F 29            [11]  855 	add	hl, hl
   1560 29            [11]  856 	add	hl, hl
   1561 29            [11]  857 	add	hl, hl
   1562 29            [11]  858 	add	hl, hl
   1563 EB            [ 4]  859 	ex	de,hl
   1564 21 D0 88      [10]  860 	ld	hl,#0x88D0
   1567 19            [11]  861 	add	hl,de
   1568 EB            [ 4]  862 	ex	de,hl
   1569 DD 6E FE      [19]  863 	ld	l,-2 (ix)
   156C DD 66 FF      [19]  864 	ld	h,-1 (ix)
   156F 6E            [ 7]  865 	ld	l, (hl)
   1570 26 00         [ 7]  866 	ld	h,#0x00
   1572 19            [11]  867 	add	hl,de
   1573 7E            [ 7]  868 	ld	a,(hl)
                            869 ;src/Map.c:212: if(adjacentType == CELLTYPE_UNDEFINED){
   1574 D6 87         [ 7]  870 	sub	a, #0x87
   1576 20 1C         [12]  871 	jr	NZ,00152$
                            872 ;src/Map.c:215: ++lastStackItem;
   1578 DD 34 EC      [23]  873 	inc	-20 (ix)
   157B 20 03         [12]  874 	jr	NZ,00343$
   157D DD 34 ED      [23]  875 	inc	-19 (ix)
   1580                     876 00343$:
                            877 ;src/Map.c:216: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   1580 E1            [10]  878 	pop	hl
   1581 E5            [11]  879 	push	hl
   1582 29            [11]  880 	add	hl, hl
   1583 11 D0 8C      [10]  881 	ld	de,#0x8CD0
   1586 19            [11]  882 	add	hl,de
   1587 0C            [ 4]  883 	inc	c
   1588 71            [ 7]  884 	ld	(hl),c
                            885 ;src/Map.c:217: (*(cellStack+lastStackItem)).y = currentPos.y;
   1589 23            [ 6]  886 	inc	hl
   158A 4D            [ 4]  887 	ld	c,l
   158B 44            [ 4]  888 	ld	b,h
   158C DD 6E FE      [19]  889 	ld	l,-2 (ix)
   158F DD 66 FF      [19]  890 	ld	h,-1 (ix)
   1592 7E            [ 7]  891 	ld	a,(hl)
   1593 02            [ 7]  892 	ld	(bc),a
   1594                     893 00152$:
                            894 ;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
   1594 DD 6E FE      [19]  895 	ld	l,-2 (ix)
   1597 DD 66 FF      [19]  896 	ld	h,-1 (ix)
   159A 4E            [ 7]  897 	ld	c,(hl)
                            898 ;src/Map.c:221: if(currentPos.y > 0){
   159B 79            [ 4]  899 	ld	a,c
   159C B7            [ 4]  900 	or	a, a
   159D 28 3A         [12]  901 	jr	Z,00156$
                            902 ;src/Map.c:223: adjacentType = map[currentPos.x][currentPos.y-1];
   159F DD 6E FA      [19]  903 	ld	l,-6 (ix)
   15A2 DD 66 FB      [19]  904 	ld	h,-5 (ix)
   15A5 46            [ 7]  905 	ld	b,(hl)
   15A6 68            [ 4]  906 	ld	l,b
   15A7 26 00         [ 7]  907 	ld	h,#0x00
   15A9 29            [11]  908 	add	hl, hl
   15AA 29            [11]  909 	add	hl, hl
   15AB 29            [11]  910 	add	hl, hl
   15AC 29            [11]  911 	add	hl, hl
   15AD 29            [11]  912 	add	hl, hl
   15AE 11 D0 88      [10]  913 	ld	de,#0x88D0
   15B1 19            [11]  914 	add	hl,de
   15B2 0D            [ 4]  915 	dec	c
   15B3 59            [ 4]  916 	ld	e,c
   15B4 16 00         [ 7]  917 	ld	d,#0x00
   15B6 19            [11]  918 	add	hl,de
   15B7 7E            [ 7]  919 	ld	a,(hl)
                            920 ;src/Map.c:224: if(adjacentType == CELLTYPE_UNDEFINED){
   15B8 D6 87         [ 7]  921 	sub	a, #0x87
   15BA 20 1D         [12]  922 	jr	NZ,00156$
                            923 ;src/Map.c:227: ++lastStackItem;
   15BC DD 34 EC      [23]  924 	inc	-20 (ix)
   15BF 20 03         [12]  925 	jr	NZ,00346$
   15C1 DD 34 ED      [23]  926 	inc	-19 (ix)
   15C4                     927 00346$:
                            928 ;src/Map.c:228: (*(cellStack+lastStackItem)).x = currentPos.x;
   15C4 E1            [10]  929 	pop	hl
   15C5 E5            [11]  930 	push	hl
   15C6 29            [11]  931 	add	hl, hl
   15C7 11 D0 8C      [10]  932 	ld	de,#0x8CD0
   15CA 19            [11]  933 	add	hl,de
   15CB 70            [ 7]  934 	ld	(hl),b
                            935 ;src/Map.c:229: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   15CC 23            [ 6]  936 	inc	hl
   15CD 4D            [ 4]  937 	ld	c,l
   15CE 44            [ 4]  938 	ld	b,h
   15CF DD 6E FE      [19]  939 	ld	l,-2 (ix)
   15D2 DD 66 FF      [19]  940 	ld	h,-1 (ix)
   15D5 5E            [ 7]  941 	ld	e,(hl)
   15D6 1D            [ 4]  942 	dec	e
   15D7 7B            [ 4]  943 	ld	a,e
   15D8 02            [ 7]  944 	ld	(bc),a
   15D9                     945 00156$:
                            946 ;src/Map.c:124: adjacentType = map[currentPos.x-1][currentPos.y];
   15D9 DD 6E FE      [19]  947 	ld	l,-2 (ix)
   15DC DD 66 FF      [19]  948 	ld	h,-1 (ix)
   15DF 46            [ 7]  949 	ld	b,(hl)
                            950 ;src/Map.c:233: if(currentPos.y < (MAP_HEIGHT-1)){
   15E0 78            [ 4]  951 	ld	a,b
   15E1 D6 1F         [ 7]  952 	sub	a, #0x1F
   15E3 D2 6D 14      [10]  953 	jp	NC,00164$
                            954 ;src/Map.c:235: adjacentType = map[currentPos.x][currentPos.y+1];
   15E6 DD 6E FA      [19]  955 	ld	l,-6 (ix)
   15E9 DD 66 FB      [19]  956 	ld	h,-5 (ix)
   15EC 4E            [ 7]  957 	ld	c,(hl)
   15ED 69            [ 4]  958 	ld	l,c
   15EE 26 00         [ 7]  959 	ld	h,#0x00
   15F0 29            [11]  960 	add	hl, hl
   15F1 29            [11]  961 	add	hl, hl
   15F2 29            [11]  962 	add	hl, hl
   15F3 29            [11]  963 	add	hl, hl
   15F4 29            [11]  964 	add	hl, hl
   15F5 11 D0 88      [10]  965 	ld	de,#0x88D0
   15F8 19            [11]  966 	add	hl,de
   15F9 04            [ 4]  967 	inc	b
   15FA 58            [ 4]  968 	ld	e,b
   15FB 16 00         [ 7]  969 	ld	d,#0x00
   15FD 19            [11]  970 	add	hl,de
   15FE 7E            [ 7]  971 	ld	a,(hl)
                            972 ;src/Map.c:236: if(adjacentType == CELLTYPE_UNDEFINED){
   15FF D6 87         [ 7]  973 	sub	a, #0x87
   1601 C2 6D 14      [10]  974 	jp	NZ,00164$
                            975 ;src/Map.c:239: ++lastStackItem;
   1604 DD 34 EC      [23]  976 	inc	-20 (ix)
   1607 20 03         [12]  977 	jr	NZ,00349$
   1609 DD 34 ED      [23]  978 	inc	-19 (ix)
   160C                     979 00349$:
                            980 ;src/Map.c:240: (*(cellStack+lastStackItem)).x = currentPos.x;
   160C E1            [10]  981 	pop	hl
   160D E5            [11]  982 	push	hl
   160E 29            [11]  983 	add	hl, hl
   160F 11 D0 8C      [10]  984 	ld	de,#0x8CD0
   1612 19            [11]  985 	add	hl,de
   1613 71            [ 7]  986 	ld	(hl),c
                            987 ;src/Map.c:241: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   1614 23            [ 6]  988 	inc	hl
   1615 4D            [ 4]  989 	ld	c,l
   1616 44            [ 4]  990 	ld	b,h
   1617 DD 6E FE      [19]  991 	ld	l,-2 (ix)
   161A DD 66 FF      [19]  992 	ld	h,-1 (ix)
   161D 7E            [ 7]  993 	ld	a,(hl)
   161E 3C            [ 4]  994 	inc	a
   161F 02            [ 7]  995 	ld	(bc),a
   1620 C3 6D 14      [10]  996 	jp	00164$
   1623                     997 00162$:
                            998 ;src/Map.c:247: ++wallListCount;
   1623 DD 34 FC      [23]  999 	inc	-4 (ix)
   1626 20 03         [12] 1000 	jr	NZ,00350$
   1628 DD 34 FD      [23] 1001 	inc	-3 (ix)
   162B                    1002 00350$:
   162B DD 7E FC      [19] 1003 	ld	a,-4 (ix)
   162E DD 77 EE      [19] 1004 	ld	-18 (ix),a
   1631 DD 7E FD      [19] 1005 	ld	a,-3 (ix)
   1634 DD 77 EF      [19] 1006 	ld	-17 (ix),a
                           1007 ;src/Map.c:248: (*(wallList+wallListCount)).x = currentPos.x;
   1637 DD 6E FC      [19] 1008 	ld	l,-4 (ix)
   163A DD 66 FD      [19] 1009 	ld	h,-3 (ix)
   163D 29            [11] 1010 	add	hl, hl
   163E 01 D0 90      [10] 1011 	ld	bc,#0x90D0
   1641 09            [11] 1012 	add	hl,bc
   1642 DD 7E F9      [19] 1013 	ld	a,-7 (ix)
   1645 77            [ 7] 1014 	ld	(hl),a
                           1015 ;src/Map.c:249: (*(wallList+wallListCount)).y = currentPos.y;
   1646 23            [ 6] 1016 	inc	hl
   1647 4D            [ 4] 1017 	ld	c,l
   1648 44            [ 4] 1018 	ld	b,h
   1649 DD 6E FE      [19] 1019 	ld	l,-2 (ix)
   164C DD 66 FF      [19] 1020 	ld	h,-1 (ix)
   164F 7E            [ 7] 1021 	ld	a,(hl)
   1650 02            [ 7] 1022 	ld	(bc),a
   1651 C3 6D 14      [10] 1023 	jp	00164$
   1654                    1024 00174$:
   1654 DD F9         [10] 1025 	ld	sp, ix
   1656 DD E1         [14] 1026 	pop	ix
   1658 C9            [10] 1027 	ret
                           1028 ;src/Map.c:255: void generate_exit_door(){
                           1029 ;	---------------------------------
                           1030 ; Function generate_exit_door
                           1031 ; ---------------------------------
   1659                    1032 _generate_exit_door::
   1659 DD E5         [15] 1033 	push	ix
   165B DD 21 00 00   [14] 1034 	ld	ix,#0
   165F DD 39         [15] 1035 	add	ix,sp
   1661 21 F3 FF      [10] 1036 	ld	hl,#-13
   1664 39            [11] 1037 	add	hl,sp
   1665 F9            [ 6] 1038 	ld	sp,hl
                           1039 ;src/Map.c:256: u8 x=(cpct_getRandom_mxor_u8 ()%32);
   1666 CD 97 7A      [17] 1040 	call	_cpct_getRandom_mxor_u8
   1669 7D            [ 4] 1041 	ld	a,l
   166A E6 1F         [ 7] 1042 	and	a, #0x1F
   166C 4F            [ 4] 1043 	ld	c,a
                           1044 ;src/Map.c:257: u8 y=(cpct_getRandom_mxor_u8 ()%32);
   166D C5            [11] 1045 	push	bc
   166E CD 97 7A      [17] 1046 	call	_cpct_getRandom_mxor_u8
   1671 C1            [10] 1047 	pop	bc
   1672 7D            [ 4] 1048 	ld	a,l
   1673 E6 1F         [ 7] 1049 	and	a, #0x1F
   1675 5F            [ 4] 1050 	ld	e,a
                           1051 ;src/Map.c:258: u8 door_not_positioned=1;
   1676 DD 36 F7 01   [19] 1052 	ld	-9 (ix),#0x01
                           1053 ;src/Map.c:265: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
   167A 06 00         [ 7] 1054 	ld	b,#0x00
   167C 21 D0 88      [10] 1055 	ld	hl,#0x88D0
   167F 09            [11] 1056 	add	hl,bc
   1680 4D            [ 4] 1057 	ld	c,l
   1681 44            [ 4] 1058 	ld	b,h
   1682 6B            [ 4] 1059 	ld	l,e
   1683 26 00         [ 7] 1060 	ld	h,#0x00
   1685 29            [11] 1061 	add	hl, hl
   1686 29            [11] 1062 	add	hl, hl
   1687 29            [11] 1063 	add	hl, hl
   1688 29            [11] 1064 	add	hl, hl
   1689 29            [11] 1065 	add	hl, hl
   168A 09            [11] 1066 	add	hl,bc
   168B 4D            [ 4] 1067 	ld	c,l
   168C 44            [ 4] 1068 	ld	b,h
                           1069 ;src/Map.c:270: lastVal = (position-1);
   168D 59            [ 4] 1070 	ld	e,c
   168E 50            [ 4] 1071 	ld	d,b
   168F 1B            [ 6] 1072 	dec	de
                           1073 ;src/Map.c:271: nextVal = (position+1);
   1690 21 01 00      [10] 1074 	ld	hl,#0x0001
   1693 09            [11] 1075 	add	hl,bc
   1694 DD 75 F5      [19] 1076 	ld	-11 (ix),l
   1697 DD 74 F6      [19] 1077 	ld	-10 (ix),h
                           1078 ;src/Map.c:272: topVal = (position-MAP_WIDTH);
   169A 79            [ 4] 1079 	ld	a,c
   169B C6 E0         [ 7] 1080 	add	a,#0xE0
   169D DD 77 F3      [19] 1081 	ld	-13 (ix),a
   16A0 78            [ 4] 1082 	ld	a,b
   16A1 CE FF         [ 7] 1083 	adc	a,#0xFF
   16A3 DD 77 F4      [19] 1084 	ld	-12 (ix),a
                           1085 ;src/Map.c:273: bottomVal = (position+MAP_WIDTH);
   16A6 21 20 00      [10] 1086 	ld	hl,#0x0020
   16A9 09            [11] 1087 	add	hl,bc
   16AA DD 75 F8      [19] 1088 	ld	-8 (ix),l
   16AD DD 74 F9      [19] 1089 	ld	-7 (ix),h
                           1090 ;src/Map.c:275: while(door_not_positioned){
   16B0                    1091 00138$:
   16B0 DD 7E F7      [19] 1092 	ld	a,-9 (ix)
   16B3 B7            [ 4] 1093 	or	a, a
   16B4 CA 07 18      [10] 1094 	jp	Z,00141$
                           1095 ;src/Map.c:276: if((*position)!=CELLTYPE_FLOOR){
   16B7 0A            [ 7] 1096 	ld	a,(bc)
   16B8 B7            [ 4] 1097 	or	a, a
   16B9 CA C4 17      [10] 1098 	jp	Z,00135$
                           1099 ;src/Map.c:277: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   16BC 1A            [ 7] 1100 	ld	a,(de)
   16BD DD 77 FC      [19] 1101 	ld	-4 (ix),a
   16C0 7B            [ 4] 1102 	ld	a,e
   16C1 D6 D0         [ 7] 1103 	sub	a, #0xD0
   16C3 7A            [ 4] 1104 	ld	a,d
   16C4 DE 88         [ 7] 1105 	sbc	a, #0x88
   16C6 3E 00         [ 7] 1106 	ld	a,#0x00
   16C8 17            [ 4] 1107 	rla
   16C9 DD 77 FB      [19] 1108 	ld	-5 (ix),a
   16CC DD 7E F5      [19] 1109 	ld	a,-11 (ix)
   16CF D6 D0         [ 7] 1110 	sub	a, #0xD0
   16D1 DD 7E F6      [19] 1111 	ld	a,-10 (ix)
   16D4 DE 8C         [ 7] 1112 	sbc	a, #0x8C
   16D6 3E 00         [ 7] 1113 	ld	a,#0x00
   16D8 17            [ 4] 1114 	rla
   16D9 DD 77 FA      [19] 1115 	ld	-6 (ix),a
                           1116 ;src/Map.c:278: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   16DC E1            [10] 1117 	pop	hl
   16DD E5            [11] 1118 	push	hl
   16DE 7E            [ 7] 1119 	ld	a,(hl)
   16DF DD 77 FF      [19] 1120 	ld	-1 (ix),a
   16E2 DD 7E F3      [19] 1121 	ld	a,-13 (ix)
   16E5 D6 D0         [ 7] 1122 	sub	a, #0xD0
   16E7 DD 7E F4      [19] 1123 	ld	a,-12 (ix)
   16EA DE 88         [ 7] 1124 	sbc	a, #0x88
   16EC 3E 00         [ 7] 1125 	ld	a,#0x00
   16EE 17            [ 4] 1126 	rla
   16EF DD 77 FE      [19] 1127 	ld	-2 (ix),a
   16F2 DD 7E F8      [19] 1128 	ld	a,-8 (ix)
   16F5 D6 D0         [ 7] 1129 	sub	a, #0xD0
   16F7 DD 7E F9      [19] 1130 	ld	a,-7 (ix)
   16FA DE 8C         [ 7] 1131 	sbc	a, #0x8C
   16FC 3E 00         [ 7] 1132 	ld	a,#0x00
   16FE 17            [ 4] 1133 	rla
   16FF DD 77 FD      [19] 1134 	ld	-3 (ix),a
                           1135 ;src/Map.c:277: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   1702 DD 7E FC      [19] 1136 	ld	a,-4 (ix)
   1705 B7            [ 4] 1137 	or	a, a
   1706 20 06         [12] 1138 	jr	NZ,00133$
   1708 DD 7E FB      [19] 1139 	ld	a,-5 (ix)
   170B B7            [ 4] 1140 	or	a, a
   170C 28 57         [12] 1141 	jr	Z,00129$
   170E                    1142 00133$:
   170E DD 6E F5      [19] 1143 	ld	l,-11 (ix)
   1711 DD 66 F6      [19] 1144 	ld	h,-10 (ix)
   1714 7E            [ 7] 1145 	ld	a,(hl)
   1715 B7            [ 4] 1146 	or	a, a
   1716 20 06         [12] 1147 	jr	NZ,00128$
   1718 DD CB FA 46   [20] 1148 	bit	0,-6 (ix)
   171C 20 47         [12] 1149 	jr	NZ,00129$
   171E                    1150 00128$:
                           1151 ;src/Map.c:278: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   171E DD 6E F8      [19] 1152 	ld	l,-8 (ix)
   1721 DD 66 F9      [19] 1153 	ld	h,-7 (ix)
   1724 6E            [ 7] 1154 	ld	l,(hl)
   1725 DD 7E FF      [19] 1155 	ld	a,-1 (ix)
   1728 B7            [ 4] 1156 	or	a, a
   1729 20 06         [12] 1157 	jr	NZ,00111$
   172B DD 7E FE      [19] 1158 	ld	a,-2 (ix)
   172E B7            [ 4] 1159 	or	a, a
   172F 28 14         [12] 1160 	jr	Z,00107$
   1731                    1161 00111$:
   1731 7D            [ 4] 1162 	ld	a,l
   1732 B7            [ 4] 1163 	or	a, a
   1733 20 10         [12] 1164 	jr	NZ,00107$
   1735 DD 7E FD      [19] 1165 	ld	a,-3 (ix)
   1738 B7            [ 4] 1166 	or	a, a
   1739 28 0A         [12] 1167 	jr	Z,00107$
                           1168 ;src/Map.c:279: door_not_positioned=0;
   173B DD 36 F7 00   [19] 1169 	ld	-9 (ix),#0x00
                           1170 ;src/Map.c:280: *position=CELLTYPE_DOOR;
   173F 3E 80         [ 7] 1171 	ld	a,#0x80
   1741 02            [ 7] 1172 	ld	(bc),a
   1742 C3 C4 17      [10] 1173 	jp	00135$
   1745                    1174 00107$:
                           1175 ;src/Map.c:282: else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
   1745 7D            [ 4] 1176 	ld	a,l
   1746 B7            [ 4] 1177 	or	a, a
   1747 20 07         [12] 1178 	jr	NZ,00105$
   1749 DD 7E FD      [19] 1179 	ld	a,-3 (ix)
   174C B7            [ 4] 1180 	or	a, a
   174D C2 C4 17      [10] 1181 	jp	NZ,00135$
   1750                    1182 00105$:
   1750 DD 7E FF      [19] 1183 	ld	a,-1 (ix)
   1753 B7            [ 4] 1184 	or	a, a
   1754 20 6E         [12] 1185 	jr	NZ,00135$
   1756 DD 7E FE      [19] 1186 	ld	a,-2 (ix)
   1759 B7            [ 4] 1187 	or	a, a
   175A 20 68         [12] 1188 	jr	NZ,00135$
                           1189 ;src/Map.c:283: door_not_positioned=0;
   175C DD 36 F7 00   [19] 1190 	ld	-9 (ix),#0x00
                           1191 ;src/Map.c:284: *position=CELLTYPE_DOOR;
   1760 3E 80         [ 7] 1192 	ld	a,#0x80
   1762 02            [ 7] 1193 	ld	(bc),a
   1763 18 5F         [12] 1194 	jr	00135$
   1765                    1195 00129$:
                           1196 ;src/Map.c:287: else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
   1765 DD 7E FF      [19] 1197 	ld	a,-1 (ix)
   1768 B7            [ 4] 1198 	or	a, a
   1769 20 06         [12] 1199 	jr	NZ,00127$
   176B DD 7E FE      [19] 1200 	ld	a,-2 (ix)
   176E B7            [ 4] 1201 	or	a, a
   176F 28 53         [12] 1202 	jr	Z,00135$
   1771                    1203 00127$:
   1771 DD 6E F8      [19] 1204 	ld	l,-8 (ix)
   1774 DD 66 F9      [19] 1205 	ld	h,-7 (ix)
   1777 7E            [ 7] 1206 	ld	a,(hl)
   1778 B7            [ 4] 1207 	or	a, a
   1779 20 06         [12] 1208 	jr	NZ,00123$
   177B DD 7E FD      [19] 1209 	ld	a,-3 (ix)
   177E B7            [ 4] 1210 	or	a, a
   177F 20 43         [12] 1211 	jr	NZ,00135$
   1781                    1212 00123$:
                           1213 ;src/Map.c:277: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   1781 DD 6E F5      [19] 1214 	ld	l,-11 (ix)
   1784 DD 66 F6      [19] 1215 	ld	h,-10 (ix)
   1787 6E            [ 7] 1216 	ld	l,(hl)
                           1217 ;src/Map.c:288: if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
   1788 DD 7E FC      [19] 1218 	ld	a,-4 (ix)
   178B B7            [ 4] 1219 	or	a, a
   178C 20 06         [12] 1220 	jr	NZ,00122$
   178E DD 7E FB      [19] 1221 	ld	a,-5 (ix)
   1791 B7            [ 4] 1222 	or	a, a
   1792 28 13         [12] 1223 	jr	Z,00118$
   1794                    1224 00122$:
   1794 7D            [ 4] 1225 	ld	a,l
   1795 B7            [ 4] 1226 	or	a, a
   1796 20 0F         [12] 1227 	jr	NZ,00118$
   1798 DD CB FA 46   [20] 1228 	bit	0,-6 (ix)
   179C 28 09         [12] 1229 	jr	Z,00118$
                           1230 ;src/Map.c:289: door_not_positioned=0;
   179E DD 36 F7 00   [19] 1231 	ld	-9 (ix),#0x00
                           1232 ;src/Map.c:290: *position=CELLTYPE_DOOR;
   17A2 3E 80         [ 7] 1233 	ld	a,#0x80
   17A4 02            [ 7] 1234 	ld	(bc),a
   17A5 18 1D         [12] 1235 	jr	00135$
   17A7                    1236 00118$:
                           1237 ;src/Map.c:292: else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
   17A7 7D            [ 4] 1238 	ld	a,l
   17A8 B7            [ 4] 1239 	or	a, a
   17A9 20 06         [12] 1240 	jr	NZ,00116$
   17AB DD CB FA 46   [20] 1241 	bit	0,-6 (ix)
   17AF 20 13         [12] 1242 	jr	NZ,00135$
   17B1                    1243 00116$:
   17B1 DD 7E FC      [19] 1244 	ld	a,-4 (ix)
   17B4 B7            [ 4] 1245 	or	a, a
   17B5 20 0D         [12] 1246 	jr	NZ,00135$
   17B7 DD 7E FB      [19] 1247 	ld	a,-5 (ix)
   17BA B7            [ 4] 1248 	or	a, a
   17BB 20 07         [12] 1249 	jr	NZ,00135$
                           1250 ;src/Map.c:293: door_not_positioned=0;
   17BD DD 36 F7 00   [19] 1251 	ld	-9 (ix),#0x00
                           1252 ;src/Map.c:294: *position=CELLTYPE_DOOR;
   17C1 3E 80         [ 7] 1253 	ld	a,#0x80
   17C3 02            [ 7] 1254 	ld	(bc),a
   17C4                    1255 00135$:
                           1256 ;src/Map.c:298: ++position;
   17C4 03            [ 6] 1257 	inc	bc
                           1258 ;src/Map.c:299: ++lastVal;
   17C5 13            [ 6] 1259 	inc	de
                           1260 ;src/Map.c:300: ++nextVal;
   17C6 DD 34 F5      [23] 1261 	inc	-11 (ix)
   17C9 20 03         [12] 1262 	jr	NZ,00223$
   17CB DD 34 F6      [23] 1263 	inc	-10 (ix)
   17CE                    1264 00223$:
                           1265 ;src/Map.c:301: ++topVal;
   17CE DD 34 F3      [23] 1266 	inc	-13 (ix)
   17D1 20 03         [12] 1267 	jr	NZ,00224$
   17D3 DD 34 F4      [23] 1268 	inc	-12 (ix)
   17D6                    1269 00224$:
                           1270 ;src/Map.c:302: ++bottomVal;
   17D6 DD 34 F8      [23] 1271 	inc	-8 (ix)
   17D9 20 03         [12] 1272 	jr	NZ,00225$
   17DB DD 34 F9      [23] 1273 	inc	-7 (ix)
   17DE                    1274 00225$:
                           1275 ;src/Map.c:303: if(position==END_OF_MAP_MEM){
   17DE 79            [ 4] 1276 	ld	a,c
   17DF D6 D0         [ 7] 1277 	sub	a, #0xD0
   17E1 C2 B0 16      [10] 1278 	jp	NZ,00138$
   17E4 78            [ 4] 1279 	ld	a,b
   17E5 D6 8C         [ 7] 1280 	sub	a, #0x8C
   17E7 C2 B0 16      [10] 1281 	jp	NZ,00138$
                           1282 ;src/Map.c:304: position = MAP_MEM;
   17EA 01 D0 88      [10] 1283 	ld	bc,#0x88D0
                           1284 ;src/Map.c:305: lastVal = (position-1);
   17ED 11 CF 88      [10] 1285 	ld	de,#0x88CF
                           1286 ;src/Map.c:306: nextVal = (position+1);
   17F0 DD 36 F5 D1   [19] 1287 	ld	-11 (ix),#0xD1
   17F4 DD 36 F6 88   [19] 1288 	ld	-10 (ix),#0x88
                           1289 ;src/Map.c:307: topVal = (position-MAP_WIDTH);
   17F8 21 B0 88      [10] 1290 	ld	hl,#0x88B0
   17FB E3            [19] 1291 	ex	(sp), hl
                           1292 ;src/Map.c:308: bottomVal = (position+MAP_WIDTH);
   17FC DD 36 F8 F0   [19] 1293 	ld	-8 (ix),#0xF0
   1800 DD 36 F9 88   [19] 1294 	ld	-7 (ix),#0x88
   1804 C3 B0 16      [10] 1295 	jp	00138$
   1807                    1296 00141$:
   1807 DD F9         [10] 1297 	ld	sp, ix
   1809 DD E1         [14] 1298 	pop	ix
   180B C9            [10] 1299 	ret
                           1300 ;src/Map.c:314: void generate_level(){
                           1301 ;	---------------------------------
                           1302 ; Function generate_level
                           1303 ; ---------------------------------
   180C                    1304 _generate_level::
                           1305 ;src/Map.c:315: generate_level_with_seed(r_counter);
   180C 2A 5E 7D      [16] 1306 	ld	hl,(_r_counter)
   180F E5            [11] 1307 	push	hl
   1810 CD 15 18      [17] 1308 	call	_generate_level_with_seed
   1813 F1            [10] 1309 	pop	af
   1814 C9            [10] 1310 	ret
                           1311 ;src/Map.c:318: void generate_level_with_seed(u16 seed) {
                           1312 ;	---------------------------------
                           1313 ; Function generate_level_with_seed
                           1314 ; ---------------------------------
   1815                    1315 _generate_level_with_seed::
   1815 DD E5         [15] 1316 	push	ix
   1817 DD 21 00 00   [14] 1317 	ld	ix,#0
   181B DD 39         [15] 1318 	add	ix,sp
                           1319 ;src/Map.c:320: rand_seed=seed;
   181D DD 4E 04      [19] 1320 	ld	c,4 (ix)
   1820 DD 46 05      [19] 1321 	ld	b,5 (ix)
   1823 ED 43 89 7D   [20] 1322 	ld	(_rand_seed),bc
                           1323 ;src/Map.c:323: cpct_setSeed_mxor(((seed+level_get_level())&0xFFFE) + 1);
   1827 C5            [11] 1324 	push	bc
   1828 CD F0 0F      [17] 1325 	call	_level_get_level
   182B C1            [10] 1326 	pop	bc
   182C 26 00         [ 7] 1327 	ld	h,#0x00
   182E 09            [11] 1328 	add	hl,bc
   182F CB 85         [ 8] 1329 	res	0, l
   1831 23            [ 6] 1330 	inc	hl
   1832 11 00 00      [10] 1331 	ld	de,#0x0000
   1835 CD 89 7A      [17] 1332 	call	_cpct_setSeed_mxor
                           1333 ;src/Map.c:324: cpct_restoreState_mxor_u8();
   1838 CD 91 7A      [17] 1334 	call	_cpct_restoreState_mxor_u8
                           1335 ;src/Map.c:326: if(level_get_level()<KING_LEVEL){
   183B CD F0 0F      [17] 1336 	call	_level_get_level
   183E 7D            [ 4] 1337 	ld	a,l
   183F D6 20         [ 7] 1338 	sub	a, #0x20
   1841 30 08         [12] 1339 	jr	NC,00102$
                           1340 ;src/Map.c:327: generate_map();
   1843 CD A1 11      [17] 1341 	call	_generate_map
                           1342 ;src/Map.c:328: generate_exit_door();
   1846 CD 59 16      [17] 1343 	call	_generate_exit_door
   1849 18 03         [12] 1344 	jr	00104$
   184B                    1345 00102$:
                           1346 ;src/Map.c:331: generate_final_map();
   184B CD 0F 11      [17] 1347 	call	_generate_final_map
   184E                    1348 00104$:
   184E DD E1         [14] 1349 	pop	ix
   1850 C9            [10] 1350 	ret
                           1351 	.area _CODE
                           1352 	.area _INITIALIZER
                           1353 	.area _CABS (ABS)
