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
                             14 	.globl _level_get_level
                             15 	.globl _player_turn_left
                             16 	.globl _cpct_restoreState_mxor_u8
                             17 	.globl _cpct_setSeed_mxor
                             18 	.globl _cpct_getRandom_mxor_u8
                             19 	.globl _cpct_memset
                             20 	.globl _rand_seed
                             21 	.globl _map_get_seed
                             22 	.globl _generate_level
                             23 	.globl _generate_level_with_seed
                             24 ;--------------------------------------------------------
                             25 ; special function registers
                             26 ;--------------------------------------------------------
                             27 ;--------------------------------------------------------
                             28 ; ram data
                             29 ;--------------------------------------------------------
                             30 	.area _DATA
   5B29                      31 _rand_seed::
   5B29                      32 	.ds 1
                             33 ;--------------------------------------------------------
                             34 ; ram data
                             35 ;--------------------------------------------------------
                             36 	.area _INITIALIZED
                             37 ;--------------------------------------------------------
                             38 ; absolute external ram data
                             39 ;--------------------------------------------------------
                             40 	.area _DABS (ABS)
                             41 ;--------------------------------------------------------
                             42 ; global & static initialisations
                             43 ;--------------------------------------------------------
                             44 	.area _HOME
                             45 	.area _GSINIT
                             46 	.area _GSFINAL
                             47 	.area _GSINIT
                             48 ;--------------------------------------------------------
                             49 ; Home
                             50 ;--------------------------------------------------------
                             51 	.area _HOME
                             52 	.area _HOME
                             53 ;--------------------------------------------------------
                             54 ; code
                             55 ;--------------------------------------------------------
                             56 	.area _CODE
                             57 ;src/Map.c:14: u8 map_get_seed(){
                             58 ;	---------------------------------
                             59 ; Function map_get_seed
                             60 ; ---------------------------------
   0778                      61 _map_get_seed::
                             62 ;src/Map.c:15: return rand_seed;
   0778 FD 21 29 5B   [14]   63 	ld	iy,#_rand_seed
   077C FD 6E 00      [19]   64 	ld	l,0 (iy)
   077F C9            [10]   65 	ret
                             66 ;src/Map.c:18: u8 get_random_wall(){
                             67 ;	---------------------------------
                             68 ; Function get_random_wall
                             69 ; ---------------------------------
   0780                      70 _get_random_wall::
                             71 ;src/Map.c:19: u8 cellType = cpct_getRandom_mxor_u8 ();
   0780 CD C2 58      [17]   72 	call	_cpct_getRandom_mxor_u8
                             73 ;src/Map.c:20: if(cellType&1){
   0783 CB 45         [ 8]   74 	bit	0, l
   0785 28 03         [12]   75 	jr	Z,00108$
                             76 ;src/Map.c:21: return CELLTYPE_WALL1;
   0787 2E 81         [ 7]   77 	ld	l,#0x81
   0789 C9            [10]   78 	ret
   078A                      79 00108$:
                             80 ;src/Map.c:24: if(cellType&3){
   078A 7D            [ 4]   81 	ld	a,l
   078B E6 03         [ 7]   82 	and	a, #0x03
   078D 28 03         [12]   83 	jr	Z,00105$
                             84 ;src/Map.c:25: return CELLTYPE_WALL2;
   078F 2E 82         [ 7]   85 	ld	l,#0x82
   0791 C9            [10]   86 	ret
   0792                      87 00105$:
                             88 ;src/Map.c:28: if(cellType&5){
   0792 7D            [ 4]   89 	ld	a,l
   0793 E6 05         [ 7]   90 	and	a, #0x05
   0795 28 03         [12]   91 	jr	Z,00102$
                             92 ;src/Map.c:29: return CELLTYPE_WALL3;
   0797 2E 83         [ 7]   93 	ld	l,#0x83
   0799 C9            [10]   94 	ret
   079A                      95 00102$:
                             96 ;src/Map.c:32: return CELLTYPE_WALL4;  
   079A 2E 84         [ 7]   97 	ld	l,#0x84
   079C C9            [10]   98 	ret
                             99 ;src/Map.c:38: void generate_map(){
                            100 ;	---------------------------------
                            101 ; Function generate_map
                            102 ; ---------------------------------
   079D                     103 _generate_map::
   079D DD E5         [15]  104 	push	ix
   079F DD 21 00 00   [14]  105 	ld	ix,#0
   07A3 DD 39         [15]  106 	add	ix,sp
   07A5 21 EC FF      [10]  107 	ld	hl,#-20
   07A8 39            [11]  108 	add	hl,sp
   07A9 F9            [ 6]  109 	ld	sp,hl
                            110 ;src/Map.c:41: u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
   07AA DD 36 F2 83   [19]  111 	ld	-14 (ix),#0x83
   07AE DD 36 F3 03   [19]  112 	ld	-13 (ix),#0x03
                            113 ;src/Map.c:47: u16 wallListCount = 0;
   07B2 DD 36 EE 00   [19]  114 	ld	-18 (ix),#0x00
   07B6 DD 36 EF 00   [19]  115 	ld	-17 (ix),#0x00
                            116 ;src/Map.c:48: u16 lastStackItem = 0;
   07BA 21 00 00      [10]  117 	ld	hl,#0x0000
   07BD E3            [19]  118 	ex	(sp), hl
                            119 ;src/Map.c:50: cpct_memset (GENERATOR_DATA_PTR, 0, 4096);
   07BE 21 00 10      [10]  120 	ld	hl,#0x1000
   07C1 E5            [11]  121 	push	hl
   07C2 AF            [ 4]  122 	xor	a, a
   07C3 F5            [11]  123 	push	af
   07C4 33            [ 6]  124 	inc	sp
   07C5 26 74         [ 7]  125 	ld	h, #0x74
   07C7 E5            [11]  126 	push	hl
   07C8 CD 44 59      [17]  127 	call	_cpct_memset
                            128 ;src/Map.c:52: (*cellStack).x = (cpct_getRandom_mxor_u8 ()%(MAP_WIDTH-2))+1; //RANDOM
   07CB CD C2 58      [17]  129 	call	_cpct_getRandom_mxor_u8
   07CE 45            [ 4]  130 	ld	b,l
   07CF 3E 1E         [ 7]  131 	ld	a,#0x1E
   07D1 F5            [11]  132 	push	af
   07D2 33            [ 6]  133 	inc	sp
   07D3 C5            [11]  134 	push	bc
   07D4 33            [ 6]  135 	inc	sp
   07D5 CD 23 58      [17]  136 	call	__moduchar
   07D8 F1            [10]  137 	pop	af
   07D9 4D            [ 4]  138 	ld	c,l
   07DA 0C            [ 4]  139 	inc	c
   07DB 21 00 74      [10]  140 	ld	hl,#0x7400
   07DE 71            [ 7]  141 	ld	(hl),c
                            142 ;src/Map.c:53: (*cellStack).y = (cpct_getRandom_mxor_u8 ()%(MAP_HEIGHT-2))+1; //RANDOM
   07DF CD C2 58      [17]  143 	call	_cpct_getRandom_mxor_u8
   07E2 45            [ 4]  144 	ld	b,l
   07E3 3E 1E         [ 7]  145 	ld	a,#0x1E
   07E5 F5            [11]  146 	push	af
   07E6 33            [ 6]  147 	inc	sp
   07E7 C5            [11]  148 	push	bc
   07E8 33            [ 6]  149 	inc	sp
   07E9 CD 23 58      [17]  150 	call	__moduchar
   07EC F1            [10]  151 	pop	af
   07ED 4D            [ 4]  152 	ld	c,l
   07EE 0C            [ 4]  153 	inc	c
   07EF 21 01 74      [10]  154 	ld	hl,#0x7401
   07F2 71            [ 7]  155 	ld	(hl),c
                            156 ;src/Map.c:55: rotatePlayer = cpct_getRandom_mxor_u8 ()%4;
   07F3 CD C2 58      [17]  157 	call	_cpct_getRandom_mxor_u8
   07F6 7D            [ 4]  158 	ld	a,l
   07F7 E6 03         [ 7]  159 	and	a, #0x03
   07F9 4F            [ 4]  160 	ld	c,a
                            161 ;src/Map.c:56: while(rotatePlayer){
   07FA                     162 00101$:
   07FA 79            [ 4]  163 	ld	a,c
   07FB B7            [ 4]  164 	or	a, a
   07FC 28 08         [12]  165 	jr	Z,00103$
                            166 ;src/Map.c:57: player_turn_left();
   07FE C5            [11]  167 	push	bc
   07FF CD 31 0E      [17]  168 	call	_player_turn_left
   0802 C1            [10]  169 	pop	bc
                            170 ;src/Map.c:58: --rotatePlayer;
   0803 0D            [ 4]  171 	dec	c
   0804 18 F4         [12]  172 	jr	00101$
   0806                     173 00103$:
                            174 ;src/Map.c:61: *(i8*)&(player_position.x) = (*cellStack).y;
   0806 01 5A 0E      [10]  175 	ld	bc,#_player_position+0
   0809 3A 01 74      [13]  176 	ld	a,(#0x7401)
   080C 02            [ 7]  177 	ld	(bc),a
                            178 ;src/Map.c:62: *(i8*)&(player_position.y) = (*cellStack).x;
   080D 01 5B 0E      [10]  179 	ld	bc,#_player_position+1
   0810 3A 00 74      [13]  180 	ld	a,(#0x7400)
   0813 02            [ 7]  181 	ld	(bc),a
                            182 ;src/Map.c:64: cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
   0814 21 00 04      [10]  183 	ld	hl,#0x0400
   0817 E5            [11]  184 	push	hl
   0818 3E 87         [ 7]  185 	ld	a,#0x87
   081A F5            [11]  186 	push	af
   081B 33            [ 6]  187 	inc	sp
   081C 26 70         [ 7]  188 	ld	h, #0x70
   081E E5            [11]  189 	push	hl
   081F CD 44 59      [17]  190 	call	_cpct_memset
                            191 ;src/Map.c:67: map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
   0822 21 00 74      [10]  192 	ld	hl,#0x7400
   0825 6E            [ 7]  193 	ld	l,(hl)
   0826 26 00         [ 7]  194 	ld	h,#0x00
   0828 29            [11]  195 	add	hl, hl
   0829 29            [11]  196 	add	hl, hl
   082A 29            [11]  197 	add	hl, hl
   082B 29            [11]  198 	add	hl, hl
   082C 29            [11]  199 	add	hl, hl
   082D 01 00 70      [10]  200 	ld	bc,#0x7000
   0830 09            [11]  201 	add	hl,bc
   0831 4D            [ 4]  202 	ld	c,l
   0832 44            [ 4]  203 	ld	b,h
   0833 21 01 74      [10]  204 	ld	hl,#0x7401
   0836 6E            [ 7]  205 	ld	l, (hl)
   0837 26 00         [ 7]  206 	ld	h,#0x00
   0839 09            [11]  207 	add	hl,bc
   083A 36 00         [10]  208 	ld	(hl),#0x00
                            209 ;src/Map.c:70: for(i=0;i<MAP_WIDTH;++i){
   083C 0E 00         [ 7]  210 	ld	c,#0x00
   083E                     211 00170$:
                            212 ;src/Map.c:71: map[0][i]=CELLTYPE_WALL1;//get_random_wall();
   083E 21 00 70      [10]  213 	ld	hl,#0x7000
   0841 06 00         [ 7]  214 	ld	b,#0x00
   0843 09            [11]  215 	add	hl, bc
   0844 36 81         [10]  216 	ld	(hl),#0x81
                            217 ;src/Map.c:72: map[MAP_HEIGHT-1][i]=CELLTYPE_WALL1;//get_random_wall();
   0846 21 E0 73      [10]  218 	ld	hl,#0x73E0
   0849 06 00         [ 7]  219 	ld	b,#0x00
   084B 09            [11]  220 	add	hl, bc
   084C 36 81         [10]  221 	ld	(hl),#0x81
                            222 ;src/Map.c:70: for(i=0;i<MAP_WIDTH;++i){
   084E 0C            [ 4]  223 	inc	c
   084F 79            [ 4]  224 	ld	a,c
   0850 D6 20         [ 7]  225 	sub	a, #0x20
   0852 38 EA         [12]  226 	jr	C,00170$
                            227 ;src/Map.c:75: for(i=1;i<MAP_HEIGHT-1;++i){
   0854 0E 01         [ 7]  228 	ld	c,#0x01
   0856                     229 00172$:
                            230 ;src/Map.c:76: map[i][0]=CELLTYPE_WALL1;//get_random_wall();
   0856 69            [ 4]  231 	ld	l,c
   0857 26 00         [ 7]  232 	ld	h,#0x00
   0859 29            [11]  233 	add	hl, hl
   085A 29            [11]  234 	add	hl, hl
   085B 29            [11]  235 	add	hl, hl
   085C 29            [11]  236 	add	hl, hl
   085D 29            [11]  237 	add	hl, hl
   085E EB            [ 4]  238 	ex	de,hl
   085F 21 00 70      [10]  239 	ld	hl,#0x7000
   0862 19            [11]  240 	add	hl,de
   0863 36 81         [10]  241 	ld	(hl),#0x81
                            242 ;src/Map.c:77: map[i][MAP_WIDTH-1]=CELLTYPE_WALL1;//get_random_wall();
   0865 21 00 70      [10]  243 	ld	hl,#0x7000
   0868 19            [11]  244 	add	hl,de
   0869 11 1F 00      [10]  245 	ld	de,#0x001F
   086C 19            [11]  246 	add	hl,de
   086D 36 81         [10]  247 	ld	(hl),#0x81
                            248 ;src/Map.c:75: for(i=1;i<MAP_HEIGHT-1;++i){
   086F 0C            [ 4]  249 	inc	c
   0870 79            [ 4]  250 	ld	a,c
   0871 D6 1F         [ 7]  251 	sub	a, #0x1F
   0873 38 E1         [12]  252 	jr	C,00172$
                            253 ;src/Map.c:80: while(remainingCells>0){
   0875 21 04 00      [10]  254 	ld	hl,#0x0004
   0878 39            [11]  255 	add	hl,sp
   0879 DD 75 FA      [19]  256 	ld	-6 (ix),l
   087C DD 74 FB      [19]  257 	ld	-5 (ix),h
   087F                     258 00167$:
   087F DD 7E F3      [19]  259 	ld	a,-13 (ix)
   0882 DD B6 F2      [19]  260 	or	a,-14 (ix)
   0885 CA 4D 0C      [10]  261 	jp	Z,00174$
                            262 ;src/Map.c:81: wallListPosition = wallList+wallListCount;
   0888 C1            [10]  263 	pop	bc
   0889 E1            [10]  264 	pop	hl
   088A E5            [11]  265 	push	hl
   088B C5            [11]  266 	push	bc
   088C 29            [11]  267 	add	hl, hl
   088D 7D            [ 4]  268 	ld	a,l
   088E C6 00         [ 7]  269 	add	a, #0x00
   0890 DD 77 FC      [19]  270 	ld	-4 (ix),a
   0893 7C            [ 4]  271 	ld	a,h
   0894 CE 78         [ 7]  272 	adc	a, #0x78
   0896 DD 77 FD      [19]  273 	ld	-3 (ix),a
                            274 ;src/Map.c:82: while(wallListCount<MAP_SIZE){
   0899 D1            [10]  275 	pop	de
   089A C1            [10]  276 	pop	bc
   089B C5            [11]  277 	push	bc
   089C D5            [11]  278 	push	de
   089D                     279 00137$:
                            280 ;src/Map.c:85: currentPos.y = (*wallListPosition).y;
   089D DD 7E FA      [19]  281 	ld	a,-6 (ix)
   08A0 C6 01         [ 7]  282 	add	a, #0x01
   08A2 DD 77 FE      [19]  283 	ld	-2 (ix),a
   08A5 DD 7E FB      [19]  284 	ld	a,-5 (ix)
   08A8 CE 00         [ 7]  285 	adc	a, #0x00
   08AA DD 77 FF      [19]  286 	ld	-1 (ix),a
                            287 ;src/Map.c:82: while(wallListCount<MAP_SIZE){
   08AD 78            [ 4]  288 	ld	a,b
   08AE D6 04         [ 7]  289 	sub	a, #0x04
   08B0 D2 4E 0A      [10]  290 	jp	NC,00209$
                            291 ;src/Map.c:84: currentPos.x = (*wallListPosition).x;
   08B3 21 04 00      [10]  292 	ld	hl,#0x0004
   08B6 39            [11]  293 	add	hl,sp
   08B7 EB            [ 4]  294 	ex	de,hl
   08B8 DD 6E FC      [19]  295 	ld	l,-4 (ix)
   08BB DD 66 FD      [19]  296 	ld	h,-3 (ix)
   08BE 7E            [ 7]  297 	ld	a,(hl)
   08BF 12            [ 7]  298 	ld	(de),a
                            299 ;src/Map.c:85: currentPos.y = (*wallListPosition).y;
   08C0 DD 5E FC      [19]  300 	ld	e,-4 (ix)
   08C3 DD 56 FD      [19]  301 	ld	d,-3 (ix)
   08C6 13            [ 6]  302 	inc	de
   08C7 1A            [ 7]  303 	ld	a,(de)
   08C8 DD 6E FE      [19]  304 	ld	l,-2 (ix)
   08CB DD 66 FF      [19]  305 	ld	h,-1 (ix)
   08CE 77            [ 7]  306 	ld	(hl),a
                            307 ;src/Map.c:87: convertToFloor=0;
   08CF DD 36 F5 00   [19]  308 	ld	-11 (ix),#0x00
                            309 ;src/Map.c:88: surroundedByWalls=1;
   08D3 DD 36 F4 01   [19]  310 	ld	-12 (ix),#0x01
                            311 ;src/Map.c:90: if(currentPos.x>0){
   08D7 DD 6E FA      [19]  312 	ld	l,-6 (ix)
   08DA DD 66 FB      [19]  313 	ld	h,-5 (ix)
   08DD 7E            [ 7]  314 	ld	a,(hl)
   08DE DD 77 F8      [19]  315 	ld	-8 (ix),a
                            316 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   08E1 DD 6E FE      [19]  317 	ld	l,-2 (ix)
   08E4 DD 66 FF      [19]  318 	ld	h,-1 (ix)
   08E7 7E            [ 7]  319 	ld	a,(hl)
   08E8 DD 77 F9      [19]  320 	ld	-7 (ix),a
   08EB DD 7E F8      [19]  321 	ld	a,-8 (ix)
   08EE DD 77 F6      [19]  322 	ld	-10 (ix),a
   08F1 DD 36 F7 00   [19]  323 	ld	-9 (ix),#0x00
                            324 ;src/Map.c:90: if(currentPos.x>0){
   08F5 DD 7E F8      [19]  325 	ld	a,-8 (ix)
   08F8 B7            [ 4]  326 	or	a, a
   08F9 28 2F         [12]  327 	jr	Z,00112$
                            328 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   08FB DD 6E F6      [19]  329 	ld	l,-10 (ix)
   08FE DD 66 F7      [19]  330 	ld	h,-9 (ix)
   0901 2B            [ 6]  331 	dec	hl
   0902 29            [11]  332 	add	hl, hl
   0903 29            [11]  333 	add	hl, hl
   0904 29            [11]  334 	add	hl, hl
   0905 29            [11]  335 	add	hl, hl
   0906 29            [11]  336 	add	hl, hl
   0907 D5            [11]  337 	push	de
   0908 11 00 70      [10]  338 	ld	de,#0x7000
   090B 19            [11]  339 	add	hl, de
   090C D1            [10]  340 	pop	de
   090D 7D            [ 4]  341 	ld	a,l
   090E DD 86 F9      [19]  342 	add	a, -7 (ix)
   0911 6F            [ 4]  343 	ld	l,a
   0912 7C            [ 4]  344 	ld	a,h
   0913 CE 00         [ 7]  345 	adc	a, #0x00
   0915 67            [ 4]  346 	ld	h,a
   0916 6E            [ 7]  347 	ld	l,(hl)
                            348 ;src/Map.c:92: if(adjacentType == CELLTYPE_UNDEFINED){
   0917 7D            [ 4]  349 	ld	a,l
   0918 D6 87         [ 7]  350 	sub	a, #0x87
   091A 20 06         [12]  351 	jr	NZ,00109$
                            352 ;src/Map.c:93: convertToFloor  = 1;
   091C DD 36 F5 01   [19]  353 	ld	-11 (ix),#0x01
   0920 18 08         [12]  354 	jr	00112$
   0922                     355 00109$:
                            356 ;src/Map.c:95: else if(adjacentType == CELLTYPE_FLOOR){
   0922 7D            [ 4]  357 	ld	a,l
   0923 B7            [ 4]  358 	or	a, a
   0924 20 04         [12]  359 	jr	NZ,00112$
                            360 ;src/Map.c:96: surroundedByWalls = 0;
   0926 DD 36 F4 00   [19]  361 	ld	-12 (ix),#0x00
   092A                     362 00112$:
                            363 ;src/Map.c:99: if(currentPos.x < (MAP_WIDTH-1)){
   092A DD 7E F8      [19]  364 	ld	a,-8 (ix)
   092D D6 1F         [ 7]  365 	sub	a, #0x1F
   092F 30 2F         [12]  366 	jr	NC,00119$
                            367 ;src/Map.c:101: adjacentType = map[currentPos.x+1][currentPos.y];
   0931 DD 6E F6      [19]  368 	ld	l,-10 (ix)
   0934 DD 66 F7      [19]  369 	ld	h,-9 (ix)
   0937 23            [ 6]  370 	inc	hl
   0938 29            [11]  371 	add	hl, hl
   0939 29            [11]  372 	add	hl, hl
   093A 29            [11]  373 	add	hl, hl
   093B 29            [11]  374 	add	hl, hl
   093C 29            [11]  375 	add	hl, hl
   093D D5            [11]  376 	push	de
   093E 11 00 70      [10]  377 	ld	de,#0x7000
   0941 19            [11]  378 	add	hl, de
   0942 D1            [10]  379 	pop	de
   0943 7D            [ 4]  380 	ld	a,l
   0944 DD 86 F9      [19]  381 	add	a, -7 (ix)
   0947 6F            [ 4]  382 	ld	l,a
   0948 7C            [ 4]  383 	ld	a,h
   0949 CE 00         [ 7]  384 	adc	a, #0x00
   094B 67            [ 4]  385 	ld	h,a
   094C 6E            [ 7]  386 	ld	l,(hl)
                            387 ;src/Map.c:102: if(adjacentType == CELLTYPE_UNDEFINED){
   094D 7D            [ 4]  388 	ld	a,l
   094E D6 87         [ 7]  389 	sub	a, #0x87
   0950 20 06         [12]  390 	jr	NZ,00116$
                            391 ;src/Map.c:103: convertToFloor  = 1;
   0952 DD 36 F5 01   [19]  392 	ld	-11 (ix),#0x01
   0956 18 08         [12]  393 	jr	00119$
   0958                     394 00116$:
                            395 ;src/Map.c:105: else if(adjacentType == CELLTYPE_FLOOR){
   0958 7D            [ 4]  396 	ld	a,l
   0959 B7            [ 4]  397 	or	a, a
   095A 20 04         [12]  398 	jr	NZ,00119$
                            399 ;src/Map.c:106: surroundedByWalls = 0;
   095C DD 36 F4 00   [19]  400 	ld	-12 (ix),#0x00
   0960                     401 00119$:
                            402 ;src/Map.c:111: adjacentType = map[currentPos.x][currentPos.y-1];
   0960 DD 6E F6      [19]  403 	ld	l,-10 (ix)
   0963 DD 66 F7      [19]  404 	ld	h,-9 (ix)
   0966 29            [11]  405 	add	hl, hl
   0967 29            [11]  406 	add	hl, hl
   0968 29            [11]  407 	add	hl, hl
   0969 29            [11]  408 	add	hl, hl
   096A 29            [11]  409 	add	hl, hl
   096B 7D            [ 4]  410 	ld	a,l
   096C C6 00         [ 7]  411 	add	a, #0x00
   096E DD 77 F6      [19]  412 	ld	-10 (ix),a
   0971 7C            [ 4]  413 	ld	a,h
   0972 CE 70         [ 7]  414 	adc	a, #0x70
   0974 DD 77 F7      [19]  415 	ld	-9 (ix),a
                            416 ;src/Map.c:109: if(currentPos.y > 0){
   0977 DD 7E F9      [19]  417 	ld	a,-7 (ix)
   097A B7            [ 4]  418 	or	a, a
   097B 28 23         [12]  419 	jr	Z,00126$
                            420 ;src/Map.c:111: adjacentType = map[currentPos.x][currentPos.y-1];
   097D DD 6E F9      [19]  421 	ld	l,-7 (ix)
   0980 2D            [ 4]  422 	dec	l
   0981 DD 7E F6      [19]  423 	ld	a,-10 (ix)
   0984 85            [ 4]  424 	add	a, l
   0985 6F            [ 4]  425 	ld	l,a
   0986 DD 7E F7      [19]  426 	ld	a,-9 (ix)
   0989 CE 00         [ 7]  427 	adc	a, #0x00
   098B 67            [ 4]  428 	ld	h,a
   098C 6E            [ 7]  429 	ld	l,(hl)
                            430 ;src/Map.c:112: if(adjacentType == CELLTYPE_UNDEFINED){
   098D 7D            [ 4]  431 	ld	a,l
   098E D6 87         [ 7]  432 	sub	a, #0x87
   0990 20 06         [12]  433 	jr	NZ,00123$
                            434 ;src/Map.c:113: convertToFloor  = 1;
   0992 DD 36 F5 01   [19]  435 	ld	-11 (ix),#0x01
   0996 18 08         [12]  436 	jr	00126$
   0998                     437 00123$:
                            438 ;src/Map.c:115: else if(adjacentType == CELLTYPE_FLOOR){
   0998 7D            [ 4]  439 	ld	a,l
   0999 B7            [ 4]  440 	or	a, a
   099A 20 04         [12]  441 	jr	NZ,00126$
                            442 ;src/Map.c:116: surroundedByWalls = 0;
   099C DD 36 F4 00   [19]  443 	ld	-12 (ix),#0x00
   09A0                     444 00126$:
                            445 ;src/Map.c:119: if(currentPos.y < (MAP_HEIGHT-1)){
   09A0 DD 7E F9      [19]  446 	ld	a,-7 (ix)
   09A3 D6 1F         [ 7]  447 	sub	a, #0x1F
   09A5 30 23         [12]  448 	jr	NC,00133$
                            449 ;src/Map.c:121: adjacentType = map[currentPos.x][currentPos.y+1];
   09A7 DD 6E F9      [19]  450 	ld	l,-7 (ix)
   09AA 2C            [ 4]  451 	inc	l
   09AB DD 7E F6      [19]  452 	ld	a,-10 (ix)
   09AE 85            [ 4]  453 	add	a, l
   09AF 6F            [ 4]  454 	ld	l,a
   09B0 DD 7E F7      [19]  455 	ld	a,-9 (ix)
   09B3 CE 00         [ 7]  456 	adc	a, #0x00
   09B5 67            [ 4]  457 	ld	h,a
   09B6 6E            [ 7]  458 	ld	l,(hl)
                            459 ;src/Map.c:122: if(adjacentType == CELLTYPE_UNDEFINED){
   09B7 7D            [ 4]  460 	ld	a,l
   09B8 D6 87         [ 7]  461 	sub	a, #0x87
   09BA 20 06         [12]  462 	jr	NZ,00130$
                            463 ;src/Map.c:123: convertToFloor  = 1;
   09BC DD 36 F5 01   [19]  464 	ld	-11 (ix),#0x01
   09C0 18 08         [12]  465 	jr	00133$
   09C2                     466 00130$:
                            467 ;src/Map.c:125: else if(adjacentType == CELLTYPE_FLOOR){
   09C2 7D            [ 4]  468 	ld	a,l
   09C3 B7            [ 4]  469 	or	a, a
   09C4 20 04         [12]  470 	jr	NZ,00133$
                            471 ;src/Map.c:126: surroundedByWalls = 0;
   09C6 DD 36 F4 00   [19]  472 	ld	-12 (ix),#0x00
   09CA                     473 00133$:
                            474 ;src/Map.c:130: (*wallListPosition).x = (*(wallList+wallListCount)).x;
   09CA 69            [ 4]  475 	ld	l, c
   09CB 60            [ 4]  476 	ld	h, b
   09CC 29            [11]  477 	add	hl, hl
   09CD FD 21 00 78   [14]  478 	ld	iy,#0x7800
   09D1 C5            [11]  479 	push	bc
   09D2 4D            [ 4]  480 	ld	c, l
   09D3 44            [ 4]  481 	ld	b, h
   09D4 FD 09         [15]  482 	add	iy, bc
   09D6 C1            [10]  483 	pop	bc
   09D7 FD 7E 00      [19]  484 	ld	a, 0 (iy)
   09DA DD 6E FC      [19]  485 	ld	l,-4 (ix)
   09DD DD 66 FD      [19]  486 	ld	h,-3 (ix)
   09E0 77            [ 7]  487 	ld	(hl),a
                            488 ;src/Map.c:131: (*wallListPosition).y = (*(wallList+wallListCount)).y;
   09E1 FD E5         [15]  489 	push	iy
   09E3 E1            [10]  490 	pop	hl
   09E4 23            [ 6]  491 	inc	hl
   09E5 7E            [ 7]  492 	ld	a,(hl)
   09E6 12            [ 7]  493 	ld	(de),a
                            494 ;src/Map.c:132: --wallListCount;
   09E7 0B            [ 6]  495 	dec	bc
   09E8 DD 71 EE      [19]  496 	ld	-18 (ix),c
   09EB DD 70 EF      [19]  497 	ld	-17 (ix),b
                            498 ;src/Map.c:135: if((convertToFloor)&&(!surroundedByWalls)){
   09EE DD 7E F5      [19]  499 	ld	a,-11 (ix)
   09F1 B7            [ 4]  500 	or	a, a
   09F2 28 49         [12]  501 	jr	Z,00135$
   09F4 DD 7E F4      [19]  502 	ld	a,-12 (ix)
   09F7 B7            [ 4]  503 	or	a, a
   09F8 20 43         [12]  504 	jr	NZ,00135$
                            505 ;src/Map.c:136: map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
   09FA DD 6E FA      [19]  506 	ld	l,-6 (ix)
   09FD DD 66 FB      [19]  507 	ld	h,-5 (ix)
   0A00 6E            [ 7]  508 	ld	l,(hl)
   0A01 26 00         [ 7]  509 	ld	h,#0x00
   0A03 29            [11]  510 	add	hl, hl
   0A04 29            [11]  511 	add	hl, hl
   0A05 29            [11]  512 	add	hl, hl
   0A06 29            [11]  513 	add	hl, hl
   0A07 29            [11]  514 	add	hl, hl
   0A08 01 00 70      [10]  515 	ld	bc,#0x7000
   0A0B 09            [11]  516 	add	hl,bc
   0A0C 4D            [ 4]  517 	ld	c,l
   0A0D 44            [ 4]  518 	ld	b,h
   0A0E DD 6E FE      [19]  519 	ld	l,-2 (ix)
   0A11 DD 66 FF      [19]  520 	ld	h,-1 (ix)
   0A14 6E            [ 7]  521 	ld	l, (hl)
   0A15 26 00         [ 7]  522 	ld	h,#0x00
   0A17 09            [11]  523 	add	hl,bc
   0A18 36 00         [10]  524 	ld	(hl),#0x00
                            525 ;src/Map.c:138: ++lastStackItem;
   0A1A DD 34 EC      [23]  526 	inc	-20 (ix)
   0A1D 20 03         [12]  527 	jr	NZ,00334$
   0A1F DD 34 ED      [23]  528 	inc	-19 (ix)
   0A22                     529 00334$:
                            530 ;src/Map.c:139: (*(cellStack+lastStackItem)).x = currentPos.x;
   0A22 E1            [10]  531 	pop	hl
   0A23 E5            [11]  532 	push	hl
   0A24 29            [11]  533 	add	hl, hl
   0A25 4D            [ 4]  534 	ld	c, l
   0A26 7C            [ 4]  535 	ld	a,h
   0A27 C6 74         [ 7]  536 	add	a,#0x74
   0A29 47            [ 4]  537 	ld	b,a
   0A2A DD 6E FA      [19]  538 	ld	l,-6 (ix)
   0A2D DD 66 FB      [19]  539 	ld	h,-5 (ix)
   0A30 7E            [ 7]  540 	ld	a,(hl)
   0A31 02            [ 7]  541 	ld	(bc),a
                            542 ;src/Map.c:140: (*(cellStack+lastStackItem)).y = currentPos.y;
   0A32 03            [ 6]  543 	inc	bc
   0A33 DD 6E FE      [19]  544 	ld	l,-2 (ix)
   0A36 DD 66 FF      [19]  545 	ld	h,-1 (ix)
   0A39 7E            [ 7]  546 	ld	a,(hl)
   0A3A 02            [ 7]  547 	ld	(bc),a
                            548 ;src/Map.c:143: break;
   0A3B 18 11         [12]  549 	jr	00209$
   0A3D                     550 00135$:
                            551 ;src/Map.c:145: --wallListPosition;
   0A3D DD 6E FC      [19]  552 	ld	l,-4 (ix)
   0A40 DD 66 FD      [19]  553 	ld	h,-3 (ix)
   0A43 2B            [ 6]  554 	dec	hl
   0A44 2B            [ 6]  555 	dec	hl
   0A45 DD 75 FC      [19]  556 	ld	-4 (ix),l
   0A48 DD 74 FD      [19]  557 	ld	-3 (ix),h
   0A4B C3 9D 08      [10]  558 	jp	00137$
                            559 ;src/Map.c:147: while(lastStackItem<MAP_SIZE){
   0A4E                     560 00209$:
   0A4E DD 7E F2      [19]  561 	ld	a,-14 (ix)
   0A51 DD 77 F6      [19]  562 	ld	-10 (ix),a
   0A54 DD 7E F3      [19]  563 	ld	a,-13 (ix)
   0A57 DD 77 F7      [19]  564 	ld	-9 (ix),a
   0A5A DD 7E EE      [19]  565 	ld	a,-18 (ix)
   0A5D DD 77 FC      [19]  566 	ld	-4 (ix),a
   0A60 DD 7E EF      [19]  567 	ld	a,-17 (ix)
   0A63 DD 77 FD      [19]  568 	ld	-3 (ix),a
   0A66                     569 00164$:
   0A66 DD 7E ED      [19]  570 	ld	a,-19 (ix)
   0A69 D6 04         [ 7]  571 	sub	a, #0x04
   0A6B D2 7F 08      [10]  572 	jp	NC,00167$
                            573 ;src/Map.c:148: currentPos.x=(*(lastStackItem+cellStack)).x;
   0A6E 21 04 00      [10]  574 	ld	hl,#0x0004
   0A71 39            [11]  575 	add	hl,sp
   0A72 4D            [ 4]  576 	ld	c,l
   0A73 44            [ 4]  577 	ld	b,h
   0A74 E1            [10]  578 	pop	hl
   0A75 E5            [11]  579 	push	hl
   0A76 29            [11]  580 	add	hl, hl
   0A77 FD 21 00 74   [14]  581 	ld	iy,#0x7400
   0A7B EB            [ 4]  582 	ex	de,hl
   0A7C FD 19         [15]  583 	add	iy, de
   0A7E FD 7E 00      [19]  584 	ld	a, 0 (iy)
   0A81 02            [ 7]  585 	ld	(bc),a
                            586 ;src/Map.c:149: currentPos.y=(*(lastStackItem+cellStack)).y;
   0A82 FD 4E 01      [19]  587 	ld	c,1 (iy)
   0A85 DD 6E FE      [19]  588 	ld	l,-2 (ix)
   0A88 DD 66 FF      [19]  589 	ld	h,-1 (ix)
   0A8B 71            [ 7]  590 	ld	(hl),c
                            591 ;src/Map.c:150: --lastStackItem;
   0A8C E1            [10]  592 	pop	hl
   0A8D E5            [11]  593 	push	hl
   0A8E 2B            [ 6]  594 	dec	hl
   0A8F E3            [19]  595 	ex	(sp), hl
                            596 ;src/Map.c:151: cellType = map[currentPos.x][currentPos.y];
   0A90 DD 6E FA      [19]  597 	ld	l,-6 (ix)
   0A93 DD 66 FB      [19]  598 	ld	h,-5 (ix)
   0A96 6E            [ 7]  599 	ld	l,(hl)
   0A97 26 00         [ 7]  600 	ld	h,#0x00
   0A99 29            [11]  601 	add	hl, hl
   0A9A 29            [11]  602 	add	hl, hl
   0A9B 29            [11]  603 	add	hl, hl
   0A9C 29            [11]  604 	add	hl, hl
   0A9D 29            [11]  605 	add	hl, hl
   0A9E 11 00 70      [10]  606 	ld	de,#0x7000
   0AA1 19            [11]  607 	add	hl,de
   0AA2 59            [ 4]  608 	ld	e,c
   0AA3 16 00         [ 7]  609 	ld	d,#0x00
   0AA5 19            [11]  610 	add	hl,de
   0AA6 4E            [ 7]  611 	ld	c,(hl)
                            612 ;src/Map.c:153: if(cellType == CELLTYPE_UNDEFINED){
   0AA7 79            [ 4]  613 	ld	a,c
   0AA8 D6 87         [ 7]  614 	sub	a, #0x87
   0AAA 20 47         [12]  615 	jr	NZ,00144$
                            616 ;src/Map.c:155: if(cpct_getRandom_mxor_u8 ()&1){//WALL
   0AAC CD C2 58      [17]  617 	call	_cpct_getRandom_mxor_u8
   0AAF CB 45         [ 8]  618 	bit	0, l
   0AB1 28 06         [12]  619 	jr	Z,00141$
                            620 ;src/Map.c:156: cellType = get_random_wall();
   0AB3 CD 80 07      [17]  621 	call	_get_random_wall
   0AB6 4D            [ 4]  622 	ld	c,l
   0AB7 18 02         [12]  623 	jr	00142$
   0AB9                     624 00141$:
                            625 ;src/Map.c:159: cellType = CELLTYPE_FLOOR;
   0AB9 0E 00         [ 7]  626 	ld	c,#0x00
   0ABB                     627 00142$:
                            628 ;src/Map.c:161: map[currentPos.x][currentPos.y]=cellType;
   0ABB DD 6E FA      [19]  629 	ld	l,-6 (ix)
   0ABE DD 66 FB      [19]  630 	ld	h,-5 (ix)
   0AC1 6E            [ 7]  631 	ld	l,(hl)
   0AC2 26 00         [ 7]  632 	ld	h,#0x00
   0AC4 29            [11]  633 	add	hl, hl
   0AC5 29            [11]  634 	add	hl, hl
   0AC6 29            [11]  635 	add	hl, hl
   0AC7 29            [11]  636 	add	hl, hl
   0AC8 29            [11]  637 	add	hl, hl
   0AC9 EB            [ 4]  638 	ex	de,hl
   0ACA 21 00 70      [10]  639 	ld	hl,#0x7000
   0ACD 19            [11]  640 	add	hl,de
   0ACE EB            [ 4]  641 	ex	de,hl
   0ACF DD 6E FE      [19]  642 	ld	l,-2 (ix)
   0AD2 DD 66 FF      [19]  643 	ld	h,-1 (ix)
   0AD5 6E            [ 7]  644 	ld	l, (hl)
   0AD6 26 00         [ 7]  645 	ld	h,#0x00
   0AD8 19            [11]  646 	add	hl,de
   0AD9 71            [ 7]  647 	ld	(hl),c
                            648 ;src/Map.c:162: --remainingCells;
   0ADA DD 6E F6      [19]  649 	ld	l,-10 (ix)
   0ADD DD 66 F7      [19]  650 	ld	h,-9 (ix)
   0AE0 2B            [ 6]  651 	dec	hl
   0AE1 DD 75 F6      [19]  652 	ld	-10 (ix),l
   0AE4 DD 74 F7      [19]  653 	ld	-9 (ix),h
   0AE7 DD 7E F6      [19]  654 	ld	a,-10 (ix)
   0AEA DD 77 F2      [19]  655 	ld	-14 (ix),a
   0AED DD 7E F7      [19]  656 	ld	a,-9 (ix)
   0AF0 DD 77 F3      [19]  657 	ld	-13 (ix),a
   0AF3                     658 00144$:
                            659 ;src/Map.c:90: if(currentPos.x>0){
   0AF3 DD 6E FA      [19]  660 	ld	l,-6 (ix)
   0AF6 DD 66 FB      [19]  661 	ld	h,-5 (ix)
   0AF9 7E            [ 7]  662 	ld	a,(hl)
   0AFA DD 77 F9      [19]  663 	ld	-7 (ix),a
                            664 ;src/Map.c:165: if((cellType == CELLTYPE_FLOOR)){
   0AFD 79            [ 4]  665 	ld	a,c
   0AFE B7            [ 4]  666 	or	a, a
   0AFF C2 1C 0C      [10]  667 	jp	NZ,00162$
                            668 ;src/Map.c:166: if(currentPos.x>0){
   0B02 DD 7E F9      [19]  669 	ld	a,-7 (ix)
   0B05 B7            [ 4]  670 	or	a, a
   0B06 28 3F         [12]  671 	jr	Z,00148$
                            672 ;src/Map.c:167: adjacentType = map[currentPos.x-1][currentPos.y];
   0B08 DD 6E F9      [19]  673 	ld	l,-7 (ix)
   0B0B 26 00         [ 7]  674 	ld	h,#0x00
   0B0D 2B            [ 6]  675 	dec	hl
   0B0E 29            [11]  676 	add	hl, hl
   0B0F 29            [11]  677 	add	hl, hl
   0B10 29            [11]  678 	add	hl, hl
   0B11 29            [11]  679 	add	hl, hl
   0B12 29            [11]  680 	add	hl, hl
   0B13 01 00 70      [10]  681 	ld	bc,#0x7000
   0B16 09            [11]  682 	add	hl,bc
   0B17 4D            [ 4]  683 	ld	c,l
   0B18 44            [ 4]  684 	ld	b,h
   0B19 DD 6E FE      [19]  685 	ld	l,-2 (ix)
   0B1C DD 66 FF      [19]  686 	ld	h,-1 (ix)
   0B1F 6E            [ 7]  687 	ld	l, (hl)
   0B20 26 00         [ 7]  688 	ld	h,#0x00
   0B22 09            [11]  689 	add	hl,bc
   0B23 7E            [ 7]  690 	ld	a,(hl)
                            691 ;src/Map.c:168: if(adjacentType == CELLTYPE_UNDEFINED){
   0B24 D6 87         [ 7]  692 	sub	a, #0x87
   0B26 20 1F         [12]  693 	jr	NZ,00148$
                            694 ;src/Map.c:170: ++lastStackItem;
   0B28 DD 34 EC      [23]  695 	inc	-20 (ix)
   0B2B 20 03         [12]  696 	jr	NZ,00340$
   0B2D DD 34 ED      [23]  697 	inc	-19 (ix)
   0B30                     698 00340$:
                            699 ;src/Map.c:171: (*(cellStack+lastStackItem)).x = currentPos.x-1;
   0B30 E1            [10]  700 	pop	hl
   0B31 E5            [11]  701 	push	hl
   0B32 29            [11]  702 	add	hl, hl
   0B33 01 00 74      [10]  703 	ld	bc,#0x7400
   0B36 09            [11]  704 	add	hl,bc
   0B37 DD 4E F9      [19]  705 	ld	c,-7 (ix)
   0B3A 0D            [ 4]  706 	dec	c
   0B3B 71            [ 7]  707 	ld	(hl),c
                            708 ;src/Map.c:172: (*(cellStack+lastStackItem)).y = currentPos.y;
   0B3C 23            [ 6]  709 	inc	hl
   0B3D 4D            [ 4]  710 	ld	c,l
   0B3E 44            [ 4]  711 	ld	b,h
   0B3F DD 6E FE      [19]  712 	ld	l,-2 (ix)
   0B42 DD 66 FF      [19]  713 	ld	h,-1 (ix)
   0B45 7E            [ 7]  714 	ld	a,(hl)
   0B46 02            [ 7]  715 	ld	(bc),a
   0B47                     716 00148$:
                            717 ;src/Map.c:176: if(currentPos.x < (MAP_WIDTH-1)){
   0B47 DD 6E FA      [19]  718 	ld	l,-6 (ix)
   0B4A DD 66 FB      [19]  719 	ld	h,-5 (ix)
   0B4D 4E            [ 7]  720 	ld	c,(hl)
   0B4E 79            [ 4]  721 	ld	a,c
   0B4F D6 1F         [ 7]  722 	sub	a, #0x1F
   0B51 30 3A         [12]  723 	jr	NC,00152$
                            724 ;src/Map.c:178: adjacentType = map[currentPos.x+1][currentPos.y];
   0B53 69            [ 4]  725 	ld	l,c
   0B54 26 00         [ 7]  726 	ld	h,#0x00
   0B56 23            [ 6]  727 	inc	hl
   0B57 29            [11]  728 	add	hl, hl
   0B58 29            [11]  729 	add	hl, hl
   0B59 29            [11]  730 	add	hl, hl
   0B5A 29            [11]  731 	add	hl, hl
   0B5B 29            [11]  732 	add	hl, hl
   0B5C EB            [ 4]  733 	ex	de,hl
   0B5D 21 00 70      [10]  734 	ld	hl,#0x7000
   0B60 19            [11]  735 	add	hl,de
   0B61 EB            [ 4]  736 	ex	de,hl
   0B62 DD 6E FE      [19]  737 	ld	l,-2 (ix)
   0B65 DD 66 FF      [19]  738 	ld	h,-1 (ix)
   0B68 6E            [ 7]  739 	ld	l, (hl)
   0B69 26 00         [ 7]  740 	ld	h,#0x00
   0B6B 19            [11]  741 	add	hl,de
   0B6C 7E            [ 7]  742 	ld	a,(hl)
                            743 ;src/Map.c:179: if(adjacentType == CELLTYPE_UNDEFINED){
   0B6D D6 87         [ 7]  744 	sub	a, #0x87
   0B6F 20 1C         [12]  745 	jr	NZ,00152$
                            746 ;src/Map.c:182: ++lastStackItem;
   0B71 DD 34 EC      [23]  747 	inc	-20 (ix)
   0B74 20 03         [12]  748 	jr	NZ,00343$
   0B76 DD 34 ED      [23]  749 	inc	-19 (ix)
   0B79                     750 00343$:
                            751 ;src/Map.c:183: (*(cellStack+lastStackItem)).x = currentPos.x+1;
   0B79 E1            [10]  752 	pop	hl
   0B7A E5            [11]  753 	push	hl
   0B7B 29            [11]  754 	add	hl, hl
   0B7C 11 00 74      [10]  755 	ld	de,#0x7400
   0B7F 19            [11]  756 	add	hl,de
   0B80 0C            [ 4]  757 	inc	c
   0B81 71            [ 7]  758 	ld	(hl),c
                            759 ;src/Map.c:184: (*(cellStack+lastStackItem)).y = currentPos.y;
   0B82 23            [ 6]  760 	inc	hl
   0B83 4D            [ 4]  761 	ld	c,l
   0B84 44            [ 4]  762 	ld	b,h
   0B85 DD 6E FE      [19]  763 	ld	l,-2 (ix)
   0B88 DD 66 FF      [19]  764 	ld	h,-1 (ix)
   0B8B 7E            [ 7]  765 	ld	a,(hl)
   0B8C 02            [ 7]  766 	ld	(bc),a
   0B8D                     767 00152$:
                            768 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   0B8D DD 6E FE      [19]  769 	ld	l,-2 (ix)
   0B90 DD 66 FF      [19]  770 	ld	h,-1 (ix)
   0B93 4E            [ 7]  771 	ld	c,(hl)
                            772 ;src/Map.c:188: if(currentPos.y > 0){
   0B94 79            [ 4]  773 	ld	a,c
   0B95 B7            [ 4]  774 	or	a, a
   0B96 28 3A         [12]  775 	jr	Z,00156$
                            776 ;src/Map.c:190: adjacentType = map[currentPos.x][currentPos.y-1];
   0B98 DD 6E FA      [19]  777 	ld	l,-6 (ix)
   0B9B DD 66 FB      [19]  778 	ld	h,-5 (ix)
   0B9E 46            [ 7]  779 	ld	b,(hl)
   0B9F 68            [ 4]  780 	ld	l,b
   0BA0 26 00         [ 7]  781 	ld	h,#0x00
   0BA2 29            [11]  782 	add	hl, hl
   0BA3 29            [11]  783 	add	hl, hl
   0BA4 29            [11]  784 	add	hl, hl
   0BA5 29            [11]  785 	add	hl, hl
   0BA6 29            [11]  786 	add	hl, hl
   0BA7 11 00 70      [10]  787 	ld	de,#0x7000
   0BAA 19            [11]  788 	add	hl,de
   0BAB 0D            [ 4]  789 	dec	c
   0BAC 59            [ 4]  790 	ld	e,c
   0BAD 16 00         [ 7]  791 	ld	d,#0x00
   0BAF 19            [11]  792 	add	hl,de
   0BB0 7E            [ 7]  793 	ld	a,(hl)
                            794 ;src/Map.c:191: if(adjacentType == CELLTYPE_UNDEFINED){
   0BB1 D6 87         [ 7]  795 	sub	a, #0x87
   0BB3 20 1D         [12]  796 	jr	NZ,00156$
                            797 ;src/Map.c:194: ++lastStackItem;
   0BB5 DD 34 EC      [23]  798 	inc	-20 (ix)
   0BB8 20 03         [12]  799 	jr	NZ,00346$
   0BBA DD 34 ED      [23]  800 	inc	-19 (ix)
   0BBD                     801 00346$:
                            802 ;src/Map.c:195: (*(cellStack+lastStackItem)).x = currentPos.x;
   0BBD E1            [10]  803 	pop	hl
   0BBE E5            [11]  804 	push	hl
   0BBF 29            [11]  805 	add	hl, hl
   0BC0 11 00 74      [10]  806 	ld	de,#0x7400
   0BC3 19            [11]  807 	add	hl,de
   0BC4 70            [ 7]  808 	ld	(hl),b
                            809 ;src/Map.c:196: (*(cellStack+lastStackItem)).y = currentPos.y-1;
   0BC5 23            [ 6]  810 	inc	hl
   0BC6 4D            [ 4]  811 	ld	c,l
   0BC7 44            [ 4]  812 	ld	b,h
   0BC8 DD 6E FE      [19]  813 	ld	l,-2 (ix)
   0BCB DD 66 FF      [19]  814 	ld	h,-1 (ix)
   0BCE 5E            [ 7]  815 	ld	e,(hl)
   0BCF 1D            [ 4]  816 	dec	e
   0BD0 7B            [ 4]  817 	ld	a,e
   0BD1 02            [ 7]  818 	ld	(bc),a
   0BD2                     819 00156$:
                            820 ;src/Map.c:91: adjacentType = map[currentPos.x-1][currentPos.y];
   0BD2 DD 6E FE      [19]  821 	ld	l,-2 (ix)
   0BD5 DD 66 FF      [19]  822 	ld	h,-1 (ix)
   0BD8 46            [ 7]  823 	ld	b,(hl)
                            824 ;src/Map.c:200: if(currentPos.y < (MAP_HEIGHT-1)){
   0BD9 78            [ 4]  825 	ld	a,b
   0BDA D6 1F         [ 7]  826 	sub	a, #0x1F
   0BDC D2 66 0A      [10]  827 	jp	NC,00164$
                            828 ;src/Map.c:202: adjacentType = map[currentPos.x][currentPos.y+1];
   0BDF DD 6E FA      [19]  829 	ld	l,-6 (ix)
   0BE2 DD 66 FB      [19]  830 	ld	h,-5 (ix)
   0BE5 4E            [ 7]  831 	ld	c,(hl)
   0BE6 69            [ 4]  832 	ld	l,c
   0BE7 26 00         [ 7]  833 	ld	h,#0x00
   0BE9 29            [11]  834 	add	hl, hl
   0BEA 29            [11]  835 	add	hl, hl
   0BEB 29            [11]  836 	add	hl, hl
   0BEC 29            [11]  837 	add	hl, hl
   0BED 29            [11]  838 	add	hl, hl
   0BEE 11 00 70      [10]  839 	ld	de,#0x7000
   0BF1 19            [11]  840 	add	hl,de
   0BF2 04            [ 4]  841 	inc	b
   0BF3 58            [ 4]  842 	ld	e,b
   0BF4 16 00         [ 7]  843 	ld	d,#0x00
   0BF6 19            [11]  844 	add	hl,de
   0BF7 7E            [ 7]  845 	ld	a,(hl)
                            846 ;src/Map.c:203: if(adjacentType == CELLTYPE_UNDEFINED){
   0BF8 D6 87         [ 7]  847 	sub	a, #0x87
   0BFA C2 66 0A      [10]  848 	jp	NZ,00164$
                            849 ;src/Map.c:206: ++lastStackItem;
   0BFD DD 34 EC      [23]  850 	inc	-20 (ix)
   0C00 20 03         [12]  851 	jr	NZ,00349$
   0C02 DD 34 ED      [23]  852 	inc	-19 (ix)
   0C05                     853 00349$:
                            854 ;src/Map.c:207: (*(cellStack+lastStackItem)).x = currentPos.x;
   0C05 E1            [10]  855 	pop	hl
   0C06 E5            [11]  856 	push	hl
   0C07 29            [11]  857 	add	hl, hl
   0C08 11 00 74      [10]  858 	ld	de,#0x7400
   0C0B 19            [11]  859 	add	hl,de
   0C0C 71            [ 7]  860 	ld	(hl),c
                            861 ;src/Map.c:208: (*(cellStack+lastStackItem)).y = currentPos.y+1;
   0C0D 23            [ 6]  862 	inc	hl
   0C0E 4D            [ 4]  863 	ld	c,l
   0C0F 44            [ 4]  864 	ld	b,h
   0C10 DD 6E FE      [19]  865 	ld	l,-2 (ix)
   0C13 DD 66 FF      [19]  866 	ld	h,-1 (ix)
   0C16 7E            [ 7]  867 	ld	a,(hl)
   0C17 3C            [ 4]  868 	inc	a
   0C18 02            [ 7]  869 	ld	(bc),a
   0C19 C3 66 0A      [10]  870 	jp	00164$
   0C1C                     871 00162$:
                            872 ;src/Map.c:214: ++wallListCount;
   0C1C DD 34 FC      [23]  873 	inc	-4 (ix)
   0C1F 20 03         [12]  874 	jr	NZ,00350$
   0C21 DD 34 FD      [23]  875 	inc	-3 (ix)
   0C24                     876 00350$:
   0C24 DD 7E FC      [19]  877 	ld	a,-4 (ix)
   0C27 DD 77 EE      [19]  878 	ld	-18 (ix),a
   0C2A DD 7E FD      [19]  879 	ld	a,-3 (ix)
   0C2D DD 77 EF      [19]  880 	ld	-17 (ix),a
                            881 ;src/Map.c:215: (*(wallList+wallListCount)).x = currentPos.x;
   0C30 DD 6E FC      [19]  882 	ld	l,-4 (ix)
   0C33 DD 66 FD      [19]  883 	ld	h,-3 (ix)
   0C36 29            [11]  884 	add	hl, hl
   0C37 01 00 78      [10]  885 	ld	bc,#0x7800
   0C3A 09            [11]  886 	add	hl,bc
   0C3B DD 7E F9      [19]  887 	ld	a,-7 (ix)
   0C3E 77            [ 7]  888 	ld	(hl),a
                            889 ;src/Map.c:216: (*(wallList+wallListCount)).y = currentPos.y;
   0C3F 23            [ 6]  890 	inc	hl
   0C40 4D            [ 4]  891 	ld	c,l
   0C41 44            [ 4]  892 	ld	b,h
   0C42 DD 6E FE      [19]  893 	ld	l,-2 (ix)
   0C45 DD 66 FF      [19]  894 	ld	h,-1 (ix)
   0C48 7E            [ 7]  895 	ld	a,(hl)
   0C49 02            [ 7]  896 	ld	(bc),a
   0C4A C3 66 0A      [10]  897 	jp	00164$
   0C4D                     898 00174$:
   0C4D DD F9         [10]  899 	ld	sp, ix
   0C4F DD E1         [14]  900 	pop	ix
   0C51 C9            [10]  901 	ret
                            902 ;src/Map.c:222: void generate_exit_door(){
                            903 ;	---------------------------------
                            904 ; Function generate_exit_door
                            905 ; ---------------------------------
   0C52                     906 _generate_exit_door::
   0C52 DD E5         [15]  907 	push	ix
   0C54 DD 21 00 00   [14]  908 	ld	ix,#0
   0C58 DD 39         [15]  909 	add	ix,sp
   0C5A 21 F2 FF      [10]  910 	ld	hl,#-14
   0C5D 39            [11]  911 	add	hl,sp
   0C5E F9            [ 6]  912 	ld	sp,hl
                            913 ;src/Map.c:223: u8 x=(cpct_getRandom_mxor_u8 ()%32);
   0C5F CD C2 58      [17]  914 	call	_cpct_getRandom_mxor_u8
   0C62 7D            [ 4]  915 	ld	a,l
   0C63 E6 1F         [ 7]  916 	and	a, #0x1F
   0C65 4F            [ 4]  917 	ld	c,a
                            918 ;src/Map.c:224: u8 y=(cpct_getRandom_mxor_u8 ()%32);
   0C66 C5            [11]  919 	push	bc
   0C67 CD C2 58      [17]  920 	call	_cpct_getRandom_mxor_u8
   0C6A C1            [10]  921 	pop	bc
   0C6B 7D            [ 4]  922 	ld	a,l
   0C6C E6 1F         [ 7]  923 	and	a, #0x1F
   0C6E 5F            [ 4]  924 	ld	e,a
                            925 ;src/Map.c:225: u8 door_not_positioned=1;
   0C6F DD 36 F2 01   [19]  926 	ld	-14 (ix),#0x01
                            927 ;src/Map.c:232: u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
   0C73 06 00         [ 7]  928 	ld	b,#0x00
   0C75 21 00 70      [10]  929 	ld	hl,#0x7000
   0C78 09            [11]  930 	add	hl,bc
   0C79 4D            [ 4]  931 	ld	c,l
   0C7A 44            [ 4]  932 	ld	b,h
   0C7B 6B            [ 4]  933 	ld	l,e
   0C7C 26 00         [ 7]  934 	ld	h,#0x00
   0C7E 29            [11]  935 	add	hl, hl
   0C7F 29            [11]  936 	add	hl, hl
   0C80 29            [11]  937 	add	hl, hl
   0C81 29            [11]  938 	add	hl, hl
   0C82 29            [11]  939 	add	hl, hl
   0C83 09            [11]  940 	add	hl,bc
   0C84 4D            [ 4]  941 	ld	c,l
   0C85 44            [ 4]  942 	ld	b,h
                            943 ;src/Map.c:237: lastVal = (position-1);
   0C86 59            [ 4]  944 	ld	e,c
   0C87 50            [ 4]  945 	ld	d,b
   0C88 1B            [ 6]  946 	dec	de
                            947 ;src/Map.c:238: nextVal = (position+1);
   0C89 21 01 00      [10]  948 	ld	hl,#0x0001
   0C8C 09            [11]  949 	add	hl,bc
   0C8D DD 75 F5      [19]  950 	ld	-11 (ix),l
   0C90 DD 74 F6      [19]  951 	ld	-10 (ix),h
                            952 ;src/Map.c:239: topVal = (position-MAP_WIDTH);
   0C93 79            [ 4]  953 	ld	a,c
   0C94 C6 E0         [ 7]  954 	add	a,#0xE0
   0C96 DD 77 F3      [19]  955 	ld	-13 (ix),a
   0C99 78            [ 4]  956 	ld	a,b
   0C9A CE FF         [ 7]  957 	adc	a,#0xFF
   0C9C DD 77 F4      [19]  958 	ld	-12 (ix),a
                            959 ;src/Map.c:240: bottomVal = (position+MAP_WIDTH);
   0C9F FD 21 20 00   [14]  960 	ld	iy,#0x0020
   0CA3 FD 09         [15]  961 	add	iy, bc
                            962 ;src/Map.c:242: while(door_not_positioned){
   0CA5                     963 00138$:
   0CA5 DD 7E F2      [19]  964 	ld	a,-14 (ix)
   0CA8 B7            [ 4]  965 	or	a, a
   0CA9 CA 01 0E      [10]  966 	jp	Z,00141$
                            967 ;src/Map.c:243: if((*position)!=CELLTYPE_FLOOR){
   0CAC 0A            [ 7]  968 	ld	a,(bc)
   0CAD B7            [ 4]  969 	or	a, a
   0CAE CA C3 0D      [10]  970 	jp	Z,00135$
                            971 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   0CB1 1A            [ 7]  972 	ld	a,(de)
   0CB2 DD 77 F7      [19]  973 	ld	-9 (ix),a
   0CB5 DD 73 FE      [19]  974 	ld	-2 (ix),e
   0CB8 DD 72 FF      [19]  975 	ld	-1 (ix),d
   0CBB DD 7E F5      [19]  976 	ld	a,-11 (ix)
   0CBE DD 77 FA      [19]  977 	ld	-6 (ix),a
   0CC1 DD 7E F6      [19]  978 	ld	a,-10 (ix)
   0CC4 DD 77 FB      [19]  979 	ld	-5 (ix),a
                            980 ;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   0CC7 DD 6E F3      [19]  981 	ld	l,-13 (ix)
   0CCA DD 66 F4      [19]  982 	ld	h,-12 (ix)
   0CCD 7E            [ 7]  983 	ld	a,(hl)
   0CCE DD 77 F8      [19]  984 	ld	-8 (ix),a
   0CD1 DD 7E F3      [19]  985 	ld	a,-13 (ix)
   0CD4 DD 77 FC      [19]  986 	ld	-4 (ix),a
   0CD7 DD 7E F4      [19]  987 	ld	a,-12 (ix)
   0CDA DD 77 FD      [19]  988 	ld	-3 (ix),a
   0CDD FD E5         [15]  989 	push	iy
   0CDF E1            [10]  990 	pop	hl
                            991 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   0CE0 DD 7E FF      [19]  992 	ld	a,-1 (ix)
   0CE3 D6 70         [ 7]  993 	sub	a, #0x70
   0CE5 3E 00         [ 7]  994 	ld	a,#0x00
   0CE7 17            [ 4]  995 	rla
   0CE8 DD 77 FE      [19]  996 	ld	-2 (ix),a
   0CEB DD 7E FB      [19]  997 	ld	a,-5 (ix)
   0CEE D6 74         [ 7]  998 	sub	a, #0x74
   0CF0 3E 00         [ 7]  999 	ld	a,#0x00
   0CF2 17            [ 4] 1000 	rla
   0CF3 DD 77 FA      [19] 1001 	ld	-6 (ix),a
                           1002 ;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   0CF6 DD 7E FD      [19] 1003 	ld	a,-3 (ix)
   0CF9 D6 70         [ 7] 1004 	sub	a, #0x70
   0CFB 3E 00         [ 7] 1005 	ld	a,#0x00
   0CFD 17            [ 4] 1006 	rla
   0CFE DD 77 FC      [19] 1007 	ld	-4 (ix),a
   0D01 7C            [ 4] 1008 	ld	a,h
   0D02 D6 74         [ 7] 1009 	sub	a, #0x74
   0D04 3E 00         [ 7] 1010 	ld	a,#0x00
   0D06 17            [ 4] 1011 	rla
   0D07 DD 77 F9      [19] 1012 	ld	-7 (ix),a
                           1013 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   0D0A DD 7E F7      [19] 1014 	ld	a,-9 (ix)
   0D0D B7            [ 4] 1015 	or	a, a
   0D0E 20 06         [12] 1016 	jr	NZ,00133$
   0D10 DD 7E FE      [19] 1017 	ld	a,-2 (ix)
   0D13 B7            [ 4] 1018 	or	a, a
   0D14 28 52         [12] 1019 	jr	Z,00129$
   0D16                    1020 00133$:
   0D16 DD 6E F5      [19] 1021 	ld	l,-11 (ix)
   0D19 DD 66 F6      [19] 1022 	ld	h,-10 (ix)
   0D1C 7E            [ 7] 1023 	ld	a,(hl)
   0D1D B7            [ 4] 1024 	or	a, a
   0D1E 20 06         [12] 1025 	jr	NZ,00128$
   0D20 DD CB FA 46   [20] 1026 	bit	0,-6 (ix)
   0D24 20 42         [12] 1027 	jr	NZ,00129$
   0D26                    1028 00128$:
                           1029 ;src/Map.c:245: if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
   0D26 FD 6E 00      [19] 1030 	ld	l, 0 (iy)
   0D29 DD 7E F8      [19] 1031 	ld	a,-8 (ix)
   0D2C B7            [ 4] 1032 	or	a, a
   0D2D 20 06         [12] 1033 	jr	NZ,00111$
   0D2F DD 7E FC      [19] 1034 	ld	a,-4 (ix)
   0D32 B7            [ 4] 1035 	or	a, a
   0D33 28 14         [12] 1036 	jr	Z,00107$
   0D35                    1037 00111$:
   0D35 7D            [ 4] 1038 	ld	a,l
   0D36 B7            [ 4] 1039 	or	a, a
   0D37 20 10         [12] 1040 	jr	NZ,00107$
   0D39 DD 7E F9      [19] 1041 	ld	a,-7 (ix)
   0D3C B7            [ 4] 1042 	or	a, a
   0D3D 28 0A         [12] 1043 	jr	Z,00107$
                           1044 ;src/Map.c:246: door_not_positioned=0;
   0D3F DD 36 F2 00   [19] 1045 	ld	-14 (ix),#0x00
                           1046 ;src/Map.c:247: *position=CELLTYPE_DOOR;
   0D43 3E 80         [ 7] 1047 	ld	a,#0x80
   0D45 02            [ 7] 1048 	ld	(bc),a
   0D46 C3 C3 0D      [10] 1049 	jp	00135$
   0D49                    1050 00107$:
                           1051 ;src/Map.c:249: else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
   0D49 7D            [ 4] 1052 	ld	a,l
   0D4A B7            [ 4] 1053 	or	a, a
   0D4B 20 06         [12] 1054 	jr	NZ,00105$
   0D4D DD 7E F9      [19] 1055 	ld	a,-7 (ix)
   0D50 B7            [ 4] 1056 	or	a, a
   0D51 20 70         [12] 1057 	jr	NZ,00135$
   0D53                    1058 00105$:
   0D53 DD 7E F8      [19] 1059 	ld	a,-8 (ix)
   0D56 B7            [ 4] 1060 	or	a, a
   0D57 20 6A         [12] 1061 	jr	NZ,00135$
   0D59 DD 7E FC      [19] 1062 	ld	a,-4 (ix)
   0D5C B7            [ 4] 1063 	or	a, a
   0D5D 20 64         [12] 1064 	jr	NZ,00135$
                           1065 ;src/Map.c:250: door_not_positioned=0;
   0D5F DD 36 F2 00   [19] 1066 	ld	-14 (ix),#0x00
                           1067 ;src/Map.c:251: *position=CELLTYPE_DOOR;
   0D63 3E 80         [ 7] 1068 	ld	a,#0x80
   0D65 02            [ 7] 1069 	ld	(bc),a
   0D66 18 5B         [12] 1070 	jr	00135$
   0D68                    1071 00129$:
                           1072 ;src/Map.c:254: else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
   0D68 DD 7E F8      [19] 1073 	ld	a,-8 (ix)
   0D6B B7            [ 4] 1074 	or	a, a
   0D6C 20 06         [12] 1075 	jr	NZ,00127$
   0D6E DD 7E FC      [19] 1076 	ld	a,-4 (ix)
   0D71 B7            [ 4] 1077 	or	a, a
   0D72 28 4F         [12] 1078 	jr	Z,00135$
   0D74                    1079 00127$:
   0D74 FD 7E 00      [19] 1080 	ld	a, 0 (iy)
   0D77 B7            [ 4] 1081 	or	a, a
   0D78 20 06         [12] 1082 	jr	NZ,00123$
   0D7A DD 7E F9      [19] 1083 	ld	a,-7 (ix)
   0D7D B7            [ 4] 1084 	or	a, a
   0D7E 20 43         [12] 1085 	jr	NZ,00135$
   0D80                    1086 00123$:
                           1087 ;src/Map.c:244: if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
   0D80 DD 6E F5      [19] 1088 	ld	l,-11 (ix)
   0D83 DD 66 F6      [19] 1089 	ld	h,-10 (ix)
   0D86 6E            [ 7] 1090 	ld	l,(hl)
                           1091 ;src/Map.c:255: if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
   0D87 DD 7E F7      [19] 1092 	ld	a,-9 (ix)
   0D8A B7            [ 4] 1093 	or	a, a
   0D8B 20 06         [12] 1094 	jr	NZ,00122$
   0D8D DD 7E FE      [19] 1095 	ld	a,-2 (ix)
   0D90 B7            [ 4] 1096 	or	a, a
   0D91 28 13         [12] 1097 	jr	Z,00118$
   0D93                    1098 00122$:
   0D93 7D            [ 4] 1099 	ld	a,l
   0D94 B7            [ 4] 1100 	or	a, a
   0D95 20 0F         [12] 1101 	jr	NZ,00118$
   0D97 DD CB FA 46   [20] 1102 	bit	0,-6 (ix)
   0D9B 28 09         [12] 1103 	jr	Z,00118$
                           1104 ;src/Map.c:256: door_not_positioned=0;
   0D9D DD 36 F2 00   [19] 1105 	ld	-14 (ix),#0x00
                           1106 ;src/Map.c:257: *position=CELLTYPE_DOOR;
   0DA1 3E 80         [ 7] 1107 	ld	a,#0x80
   0DA3 02            [ 7] 1108 	ld	(bc),a
   0DA4 18 1D         [12] 1109 	jr	00135$
   0DA6                    1110 00118$:
                           1111 ;src/Map.c:259: else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
   0DA6 7D            [ 4] 1112 	ld	a,l
   0DA7 B7            [ 4] 1113 	or	a, a
   0DA8 20 06         [12] 1114 	jr	NZ,00116$
   0DAA DD CB FA 46   [20] 1115 	bit	0,-6 (ix)
   0DAE 20 13         [12] 1116 	jr	NZ,00135$
   0DB0                    1117 00116$:
   0DB0 DD 7E F7      [19] 1118 	ld	a,-9 (ix)
   0DB3 B7            [ 4] 1119 	or	a, a
   0DB4 20 0D         [12] 1120 	jr	NZ,00135$
   0DB6 DD 7E FE      [19] 1121 	ld	a,-2 (ix)
   0DB9 B7            [ 4] 1122 	or	a, a
   0DBA 20 07         [12] 1123 	jr	NZ,00135$
                           1124 ;src/Map.c:260: door_not_positioned=0;
   0DBC DD 36 F2 00   [19] 1125 	ld	-14 (ix),#0x00
                           1126 ;src/Map.c:261: *position=CELLTYPE_DOOR;
   0DC0 3E 80         [ 7] 1127 	ld	a,#0x80
   0DC2 02            [ 7] 1128 	ld	(bc),a
   0DC3                    1129 00135$:
                           1130 ;src/Map.c:265: ++position;
   0DC3 03            [ 6] 1131 	inc	bc
                           1132 ;src/Map.c:266: ++lastVal;
   0DC4 13            [ 6] 1133 	inc	de
                           1134 ;src/Map.c:267: ++nextVal;
   0DC5 DD 34 F5      [23] 1135 	inc	-11 (ix)
   0DC8 20 03         [12] 1136 	jr	NZ,00223$
   0DCA DD 34 F6      [23] 1137 	inc	-10 (ix)
   0DCD                    1138 00223$:
                           1139 ;src/Map.c:268: ++topVal;
   0DCD DD 34 F3      [23] 1140 	inc	-13 (ix)
   0DD0 20 03         [12] 1141 	jr	NZ,00224$
   0DD2 DD 34 F4      [23] 1142 	inc	-12 (ix)
   0DD5                    1143 00224$:
                           1144 ;src/Map.c:269: ++bottomVal;
   0DD5 FD 23         [10] 1145 	inc	iy
                           1146 ;src/Map.c:270: if(position==END_OF_MAP_MEM){
   0DD7 69            [ 4] 1147 	ld	l, c
   0DD8 60            [ 4] 1148 	ld	h, b
   0DD9 7D            [ 4] 1149 	ld	a,l
   0DDA B7            [ 4] 1150 	or	a, a
   0DDB C2 A5 0C      [10] 1151 	jp	NZ,00138$
   0DDE 7C            [ 4] 1152 	ld	a,h
   0DDF D6 74         [ 7] 1153 	sub	a, #0x74
   0DE1 C2 A5 0C      [10] 1154 	jp	NZ,00138$
                           1155 ;src/Map.c:271: position = MAP_MEM;
   0DE4 01 00 70      [10] 1156 	ld	bc,#0x7000
                           1157 ;src/Map.c:272: lastVal = (position-1);
   0DE7 11 FF 6F      [10] 1158 	ld	de,#0x6FFF
                           1159 ;src/Map.c:273: nextVal = (position+1);
   0DEA DD 36 F5 01   [19] 1160 	ld	-11 (ix),#0x01
   0DEE DD 36 F6 70   [19] 1161 	ld	-10 (ix),#0x70
                           1162 ;src/Map.c:274: topVal = (position-MAP_WIDTH);
   0DF2 DD 36 F3 E0   [19] 1163 	ld	-13 (ix),#0xE0
   0DF6 DD 36 F4 6F   [19] 1164 	ld	-12 (ix),#0x6F
                           1165 ;src/Map.c:275: bottomVal = (position+MAP_WIDTH);
   0DFA FD 21 20 70   [14] 1166 	ld	iy,#0x7020
   0DFE C3 A5 0C      [10] 1167 	jp	00138$
   0E01                    1168 00141$:
   0E01 DD F9         [10] 1169 	ld	sp, ix
   0E03 DD E1         [14] 1170 	pop	ix
   0E05 C9            [10] 1171 	ret
                           1172 ;src/Map.c:281: void generate_level(){
                           1173 ;	---------------------------------
                           1174 ; Function generate_level
                           1175 ; ---------------------------------
   0E06                    1176 _generate_level::
                           1177 ;src/Map.c:282: generate_level_with_seed(r_counter);
   0E06 FD 21 26 5B   [14] 1178 	ld	iy,#_r_counter
   0E0A FD 6E 00      [19] 1179 	ld	l,0 (iy)
   0E0D C3 10 0E      [10] 1180 	jp  _generate_level_with_seed
                           1181 ;src/Map.c:285: void generate_level_with_seed(u8 seed) __z88dk_fastcall{
                           1182 ;	---------------------------------
                           1183 ; Function generate_level_with_seed
                           1184 ; ---------------------------------
   0E10                    1185 _generate_level_with_seed::
   0E10 4D            [ 4] 1186 	ld	c,l
                           1187 ;src/Map.c:287: rand_seed=seed;
   0E11 21 29 5B      [10] 1188 	ld	hl,#_rand_seed + 0
   0E14 71            [ 7] 1189 	ld	(hl), c
                           1190 ;src/Map.c:290: cpct_setSeed_mxor(((seed+level_get_level())&0xFFFE) + 1);
   0E15 06 00         [ 7] 1191 	ld	b,#0x00
   0E17 C5            [11] 1192 	push	bc
   0E18 CD BE 06      [17] 1193 	call	_level_get_level
   0E1B C1            [10] 1194 	pop	bc
   0E1C 26 00         [ 7] 1195 	ld	h,#0x00
   0E1E 09            [11] 1196 	add	hl,bc
   0E1F CB 85         [ 8] 1197 	res	0, l
   0E21 23            [ 6] 1198 	inc	hl
   0E22 11 00 00      [10] 1199 	ld	de,#0x0000
   0E25 CD B4 58      [17] 1200 	call	_cpct_setSeed_mxor
                           1201 ;src/Map.c:291: cpct_restoreState_mxor_u8();
   0E28 CD BC 58      [17] 1202 	call	_cpct_restoreState_mxor_u8
                           1203 ;src/Map.c:294: generate_map();
   0E2B CD 9D 07      [17] 1204 	call	_generate_map
                           1205 ;src/Map.c:295: generate_exit_door();
   0E2E C3 52 0C      [10] 1206 	jp  _generate_exit_door
                           1207 	.area _CODE
                           1208 	.area _INITIALIZER
                           1209 	.area _CABS (ABS)
