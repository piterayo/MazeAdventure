                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module SaveGame
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _savegame_decrypt_save
                             12 	.globl _savegame_to_string
                             13 	.globl _savegame_checksave
                             14 	.globl _savegame_string_to_save
                             15 	.globl _str_cmp
                             16 	.globl _map_get_seed
                             17 	.globl _level_get_level
                             18 	.globl _level_set_level
                             19 	.globl _player_init
                             20 	.globl _statemanager_set_state
                             21 	.globl _saveString
                             22 	.globl _save
                             23 	.globl _saveArray
                             24 	.globl _savegame_Save
                             25 	.globl _savegame_Load
                             26 	.globl _savegame_get_saveString
                             27 ;--------------------------------------------------------
                             28 ; special function registers
                             29 ;--------------------------------------------------------
                             30 ;--------------------------------------------------------
                             31 ; ram data
                             32 ;--------------------------------------------------------
                             33 	.area _DATA
   870D                      34 _save::
   870D                      35 	.ds 9
   8716                      36 _saveString::
   8716                      37 	.ds 19
                             38 ;--------------------------------------------------------
                             39 ; ram data
                             40 ;--------------------------------------------------------
                             41 	.area _INITIALIZED
                             42 ;--------------------------------------------------------
                             43 ; absolute external ram data
                             44 ;--------------------------------------------------------
                             45 	.area _DABS (ABS)
                             46 ;--------------------------------------------------------
                             47 ; global & static initialisations
                             48 ;--------------------------------------------------------
                             49 	.area _HOME
                             50 	.area _GSINIT
                             51 	.area _GSFINAL
                             52 	.area _GSINIT
                             53 ;--------------------------------------------------------
                             54 ; Home
                             55 ;--------------------------------------------------------
                             56 	.area _HOME
                             57 	.area _HOME
                             58 ;--------------------------------------------------------
                             59 ; code
                             60 ;--------------------------------------------------------
                             61 	.area _CODE
                             62 ;src/SaveGame.c:31: u8 str_cmp(char* a, char* b){
                             63 ;	---------------------------------
                             64 ; Function str_cmp
                             65 ; ---------------------------------
   2D3A                      66 _str_cmp::
                             67 ;src/SaveGame.c:32: u8 sum=0;
   2D3A 0E 00         [ 7]   68 	ld	c,#0x00
                             69 ;src/SaveGame.c:33: while(*a){
   2D3C D1            [10]   70 	pop	de
   2D3D E1            [10]   71 	pop	hl
   2D3E E5            [11]   72 	push	hl
   2D3F D5            [11]   73 	push	de
   2D40                      74 00101$:
   2D40 46            [ 7]   75 	ld	b,(hl)
   2D41 78            [ 4]   76 	ld	a,b
   2D42 B7            [ 4]   77 	or	a, a
   2D43 28 06         [12]   78 	jr	Z,00112$
                             79 ;src/SaveGame.c:34: sum+=*a;
   2D45 79            [ 4]   80 	ld	a,c
   2D46 80            [ 4]   81 	add	a, b
   2D47 4F            [ 4]   82 	ld	c,a
                             83 ;src/SaveGame.c:35: ++a;
   2D48 23            [ 6]   84 	inc	hl
   2D49 18 F5         [12]   85 	jr	00101$
                             86 ;src/SaveGame.c:38: while(*b){
   2D4B                      87 00112$:
   2D4B 21 04 00      [10]   88 	ld	hl, #4
   2D4E 39            [11]   89 	add	hl, sp
   2D4F 5E            [ 7]   90 	ld	e, (hl)
   2D50 23            [ 6]   91 	inc	hl
   2D51 56            [ 7]   92 	ld	d, (hl)
   2D52                      93 00104$:
   2D52 1A            [ 7]   94 	ld	a,(de)
   2D53 47            [ 4]   95 	ld	b,a
   2D54 B7            [ 4]   96 	or	a, a
   2D55 28 06         [12]   97 	jr	Z,00106$
                             98 ;src/SaveGame.c:39: sum-=*b;
   2D57 79            [ 4]   99 	ld	a,c
   2D58 90            [ 4]  100 	sub	a, b
   2D59 4F            [ 4]  101 	ld	c,a
                            102 ;src/SaveGame.c:40: ++b;
   2D5A 13            [ 6]  103 	inc	de
   2D5B 18 F5         [12]  104 	jr	00104$
   2D5D                     105 00106$:
                            106 ;src/SaveGame.c:43: return sum;
   2D5D 69            [ 4]  107 	ld	l,c
   2D5E C9            [10]  108 	ret
   2D5F                     109 _saveArray:
   2D5F 0D 87               110 	.dw _save
                            111 ;src/SaveGame.c:46: void savegame_string_to_save(char* in){
                            112 ;	---------------------------------
                            113 ; Function savegame_string_to_save
                            114 ; ---------------------------------
   2D61                     115 _savegame_string_to_save::
   2D61 DD E5         [15]  116 	push	ix
   2D63 DD 21 00 00   [14]  117 	ld	ix,#0
   2D67 DD 39         [15]  118 	add	ix,sp
   2D69 3B            [ 6]  119 	dec	sp
                            120 ;src/SaveGame.c:51: while(i<SAVEDATA_SIZE){
   2D6A 0E 00         [ 7]  121 	ld	c,#0x00
   2D6C                     122 00106$:
   2D6C 79            [ 4]  123 	ld	a,c
   2D6D D6 09         [ 7]  124 	sub	a, #0x09
   2D6F 30 48         [12]  125 	jr	NC,00111$
                            126 ;src/SaveGame.c:52: val=0;
   2D71 06 00         [ 7]  127 	ld	b,#0x00
                            128 ;src/SaveGame.c:53: for(j=2;j;--j){
   2D73 1E 02         [ 7]  129 	ld	e,#0x02
   2D75 DD 6E 04      [19]  130 	ld	l,4 (ix)
   2D78 DD 66 05      [19]  131 	ld	h,5 (ix)
   2D7B                     132 00109$:
                            133 ;src/SaveGame.c:54: val=val<<4;
   2D7B 78            [ 4]  134 	ld	a,b
   2D7C 07            [ 4]  135 	rlca
   2D7D 07            [ 4]  136 	rlca
   2D7E 07            [ 4]  137 	rlca
   2D7F 07            [ 4]  138 	rlca
   2D80 E6 F0         [ 7]  139 	and	a,#0xF0
   2D82 DD 77 FF      [19]  140 	ld	-1 (ix),a
                            141 ;src/SaveGame.c:55: if((*in)>47 && (*in)<=57){//Number
   2D85 46            [ 7]  142 	ld	b,(hl)
   2D86 3E 2F         [ 7]  143 	ld	a,#0x2F
   2D88 90            [ 4]  144 	sub	a, b
   2D89 30 0E         [12]  145 	jr	NC,00102$
   2D8B 3E 39         [ 7]  146 	ld	a,#0x39
   2D8D 90            [ 4]  147 	sub	a, b
   2D8E 38 09         [12]  148 	jr	C,00102$
                            149 ;src/SaveGame.c:56: val=val|(*in)-48;
   2D90 78            [ 4]  150 	ld	a,b
   2D91 C6 D0         [ 7]  151 	add	a,#0xD0
   2D93 DD B6 FF      [19]  152 	or	a, -1 (ix)
   2D96 47            [ 4]  153 	ld	b,a
   2D97 18 07         [12]  154 	jr	00103$
   2D99                     155 00102$:
                            156 ;src/SaveGame.c:59: val=val|(*in)-65+10;
   2D99 78            [ 4]  157 	ld	a,b
   2D9A C6 C9         [ 7]  158 	add	a, #0xC9
   2D9C DD B6 FF      [19]  159 	or	a, -1 (ix)
   2D9F 47            [ 4]  160 	ld	b,a
   2DA0                     161 00103$:
                            162 ;src/SaveGame.c:61: ++in;
   2DA0 23            [ 6]  163 	inc	hl
                            164 ;src/SaveGame.c:53: for(j=2;j;--j){
   2DA1 53            [ 4]  165 	ld	d,e
   2DA2 15            [ 4]  166 	dec	d
   2DA3 7A            [ 4]  167 	ld	a,d
   2DA4 5F            [ 4]  168 	ld	e,a
   2DA5 B7            [ 4]  169 	or	a, a
   2DA6 20 D3         [12]  170 	jr	NZ,00109$
                            171 ;src/SaveGame.c:64: saveArray[i]=val;
   2DA8 DD 75 04      [19]  172 	ld	4 (ix),l
   2DAB DD 74 05      [19]  173 	ld	5 (ix),h
   2DAE 2A 5F 2D      [16]  174 	ld	hl,(_saveArray)
   2DB1 59            [ 4]  175 	ld	e,c
   2DB2 16 00         [ 7]  176 	ld	d,#0x00
   2DB4 19            [11]  177 	add	hl,de
   2DB5 70            [ 7]  178 	ld	(hl),b
                            179 ;src/SaveGame.c:65: ++i;
   2DB6 0C            [ 4]  180 	inc	c
   2DB7 18 B3         [12]  181 	jr	00106$
   2DB9                     182 00111$:
   2DB9 33            [ 6]  183 	inc	sp
   2DBA DD E1         [14]  184 	pop	ix
   2DBC C9            [10]  185 	ret
                            186 ;src/SaveGame.c:71: u8 savegame_checksave(){
                            187 ;	---------------------------------
                            188 ; Function savegame_checksave
                            189 ; ---------------------------------
   2DBD                     190 _savegame_checksave::
                            191 ;src/SaveGame.c:73: u8 checksum=0;
                            192 ;src/SaveGame.c:76: while(i){
   2DBD 01 00 08      [10]  193 	ld	bc,#0x0800
   2DC0                     194 00101$:
   2DC0 78            [ 4]  195 	ld	a,b
   2DC1 B7            [ 4]  196 	or	a, a
   2DC2 28 10         [12]  197 	jr	Z,00103$
                            198 ;src/SaveGame.c:77: --i;
   2DC4 05            [ 4]  199 	dec	b
                            200 ;src/SaveGame.c:78: checksum+=(saveArray[i]^SAVE_MASK);
   2DC5 2A 5F 2D      [16]  201 	ld	hl,(_saveArray)
   2DC8 58            [ 4]  202 	ld	e,b
   2DC9 16 00         [ 7]  203 	ld	d,#0x00
   2DCB 19            [11]  204 	add	hl,de
   2DCC 7E            [ 7]  205 	ld	a,(hl)
   2DCD EE DB         [ 7]  206 	xor	a, #0xDB
   2DCF 5F            [ 4]  207 	ld	e, a
   2DD0 81            [ 4]  208 	add	a,c
   2DD1 4F            [ 4]  209 	ld	c,a
   2DD2 18 EC         [12]  210 	jr	00101$
   2DD4                     211 00103$:
                            212 ;src/SaveGame.c:80: checksum=checksum^CHECKSUM_MASK^SAVE_MASK;
   2DD4 79            [ 4]  213 	ld	a,c
   2DD5 EE 71         [ 7]  214 	xor	a, #0x71
   2DD7 4F            [ 4]  215 	ld	c,a
                            216 ;src/SaveGame.c:81: return (checksum==save.checksum);
   2DD8 21 15 87      [10]  217 	ld	hl, #(_save + 0x0008) + 0
   2DDB 46            [ 7]  218 	ld	b,(hl)
   2DDC 79            [ 4]  219 	ld	a,c
   2DDD 90            [ 4]  220 	sub	a, b
   2DDE 20 04         [12]  221 	jr	NZ,00115$
   2DE0 3E 01         [ 7]  222 	ld	a,#0x01
   2DE2 18 01         [12]  223 	jr	00116$
   2DE4                     224 00115$:
   2DE4 AF            [ 4]  225 	xor	a,a
   2DE5                     226 00116$:
   2DE5 6F            [ 4]  227 	ld	l,a
   2DE6 C9            [10]  228 	ret
                            229 ;src/SaveGame.c:86: void savegame_to_string(){
                            230 ;	---------------------------------
                            231 ; Function savegame_to_string
                            232 ; ---------------------------------
   2DE7                     233 _savegame_to_string::
                            234 ;src/SaveGame.c:89: char* string = saveString;
   2DE7 11 16 87      [10]  235 	ld	de,#_saveString
                            236 ;src/SaveGame.c:90: saveString[SAVESTRING_SIZE-1]=0;
   2DEA 21 28 87      [10]  237 	ld	hl,#(_saveString + 0x0012)
   2DED 36 00         [10]  238 	ld	(hl),#0x00
                            239 ;src/SaveGame.c:93: while(i<SAVEDATA_SIZE){
   2DEF 0E 00         [ 7]  240 	ld	c,#0x00
   2DF1                     241 00107$:
   2DF1 79            [ 4]  242 	ld	a,c
   2DF2 D6 09         [ 7]  243 	sub	a, #0x09
   2DF4 D0            [11]  244 	ret	NC
                            245 ;src/SaveGame.c:94: val = saveArray[i]>>4;
   2DF5 2A 5F 2D      [16]  246 	ld	hl,(_saveArray)
   2DF8 06 00         [ 7]  247 	ld	b,#0x00
   2DFA 09            [11]  248 	add	hl, bc
   2DFB 7E            [ 7]  249 	ld	a,(hl)
   2DFC 07            [ 4]  250 	rlca
   2DFD 07            [ 4]  251 	rlca
   2DFE 07            [ 4]  252 	rlca
   2DFF 07            [ 4]  253 	rlca
   2E00 E6 0F         [ 7]  254 	and	a,#0x0F
                            255 ;src/SaveGame.c:95: if(val<10) *string=48+val;
   2E02 47            [ 4]  256 	ld	b,a
   2E03 D6 0A         [ 7]  257 	sub	a, #0x0A
   2E05 30 06         [12]  258 	jr	NC,00102$
   2E07 78            [ 4]  259 	ld	a,b
   2E08 C6 30         [ 7]  260 	add	a, #0x30
   2E0A 12            [ 7]  261 	ld	(de),a
   2E0B 18 04         [12]  262 	jr	00103$
   2E0D                     263 00102$:
                            264 ;src/SaveGame.c:96: else *string=65+(val-10);
   2E0D 78            [ 4]  265 	ld	a,b
   2E0E C6 37         [ 7]  266 	add	a, #0x37
   2E10 12            [ 7]  267 	ld	(de),a
   2E11                     268 00103$:
                            269 ;src/SaveGame.c:98: ++string;
   2E11 13            [ 6]  270 	inc	de
                            271 ;src/SaveGame.c:99: val = saveArray[i]&0x0F;
   2E12 2A 5F 2D      [16]  272 	ld	hl,(_saveArray)
   2E15 06 00         [ 7]  273 	ld	b,#0x00
   2E17 09            [11]  274 	add	hl, bc
   2E18 7E            [ 7]  275 	ld	a,(hl)
   2E19 E6 0F         [ 7]  276 	and	a, #0x0F
                            277 ;src/SaveGame.c:100: if(val<10) *string=48+val;
   2E1B 47            [ 4]  278 	ld	b,a
   2E1C D6 0A         [ 7]  279 	sub	a, #0x0A
   2E1E 30 06         [12]  280 	jr	NC,00105$
   2E20 78            [ 4]  281 	ld	a,b
   2E21 C6 30         [ 7]  282 	add	a, #0x30
   2E23 12            [ 7]  283 	ld	(de),a
   2E24 18 04         [12]  284 	jr	00106$
   2E26                     285 00105$:
                            286 ;src/SaveGame.c:101: else *string=65+(val-10);
   2E26 78            [ 4]  287 	ld	a,b
   2E27 C6 37         [ 7]  288 	add	a, #0x37
   2E29 12            [ 7]  289 	ld	(de),a
   2E2A                     290 00106$:
                            291 ;src/SaveGame.c:103: ++string;
   2E2A 13            [ 6]  292 	inc	de
                            293 ;src/SaveGame.c:104: ++i;
   2E2B 0C            [ 4]  294 	inc	c
   2E2C 18 C3         [12]  295 	jr	00107$
                            296 ;src/SaveGame.c:108: void savegame_Save(){
                            297 ;	---------------------------------
                            298 ; Function savegame_Save
                            299 ; ---------------------------------
   2E2E                     300 _savegame_Save::
                            301 ;src/SaveGame.c:112: save.seed = map_get_seed();
   2E2E CD 57 12      [17]  302 	call	_map_get_seed
   2E31 4D            [ 4]  303 	ld	c,l
   2E32 44            [ 4]  304 	ld	b,h
   2E33 ED 43 0D 87   [20]  305 	ld	(_save), bc
                            306 ;src/SaveGame.c:114: save.potions = player_potion_count;
   2E37 21 0F 87      [10]  307 	ld	hl,#(_save + 0x0002)
   2E3A 3A 0A 87      [13]  308 	ld	a,(#_player_potion_count + 0)
   2E3D 77            [ 7]  309 	ld	(hl),a
                            310 ;src/SaveGame.c:115: save.scrolls = player_scroll_count;
   2E3E 21 10 87      [10]  311 	ld	hl,#(_save + 0x0003)
   2E41 3A 0B 87      [13]  312 	ld	a,(#_player_scroll_count + 0)
   2E44 77            [ 7]  313 	ld	(hl),a
                            314 ;src/SaveGame.c:117: save.player_hp = player_health_points;
   2E45 21 11 87      [10]  315 	ld	hl,#(_save + 0x0004)
   2E48 3A 07 87      [13]  316 	ld	a,(#_player_health_points + 0)
   2E4B 77            [ 7]  317 	ld	(hl),a
                            318 ;src/SaveGame.c:118: save.player_attack = player_attack_value;
   2E4C 21 12 87      [10]  319 	ld	hl,#(_save + 0x0005)
   2E4F 3A 06 87      [13]  320 	ld	a,(#_player_attack_value + 0)
   2E52 77            [ 7]  321 	ld	(hl),a
                            322 ;src/SaveGame.c:119: save.player_defense = player_defense_value;
   2E53 21 13 87      [10]  323 	ld	hl,#(_save + 0x0006)
   2E56 3A 05 87      [13]  324 	ld	a,(#_player_defense_value + 0)
   2E59 77            [ 7]  325 	ld	(hl),a
                            326 ;src/SaveGame.c:121: save.level = level_get_level();
   2E5A CD 59 11      [17]  327 	call	_level_get_level
   2E5D 4D            [ 4]  328 	ld	c,l
   2E5E 21 14 87      [10]  329 	ld	hl,#(_save + 0x0007)
   2E61 71            [ 7]  330 	ld	(hl),c
                            331 ;src/SaveGame.c:123: save.checksum=0;
   2E62 01 15 87      [10]  332 	ld	bc,#_save + 8
   2E65 AF            [ 4]  333 	xor	a, a
   2E66 02            [ 7]  334 	ld	(bc),a
                            335 ;src/SaveGame.c:124: while(i){
   2E67 1E 08         [ 7]  336 	ld	e,#0x08
   2E69                     337 00101$:
   2E69 7B            [ 4]  338 	ld	a,e
   2E6A B7            [ 4]  339 	or	a, a
   2E6B 28 13         [12]  340 	jr	Z,00103$
                            341 ;src/SaveGame.c:125: --i;
   2E6D 1D            [ 4]  342 	dec	e
                            343 ;src/SaveGame.c:126: save.checksum+=saveArray[i];
   2E6E 0A            [ 7]  344 	ld	a,(bc)
   2E6F 57            [ 4]  345 	ld	d,a
   2E70 2A 5F 2D      [16]  346 	ld	hl,(_saveArray)
   2E73 7B            [ 4]  347 	ld	a,e
   2E74 85            [ 4]  348 	add	a, l
   2E75 6F            [ 4]  349 	ld	l,a
   2E76 3E 00         [ 7]  350 	ld	a,#0x00
   2E78 8C            [ 4]  351 	adc	a, h
   2E79 67            [ 4]  352 	ld	h,a
   2E7A 6E            [ 7]  353 	ld	l,(hl)
   2E7B 7A            [ 4]  354 	ld	a,d
   2E7C 85            [ 4]  355 	add	a, l
   2E7D 02            [ 7]  356 	ld	(bc),a
   2E7E 18 E9         [12]  357 	jr	00101$
   2E80                     358 00103$:
                            359 ;src/SaveGame.c:131: while(i){
   2E80 1E 09         [ 7]  360 	ld	e,#0x09
   2E82                     361 00104$:
   2E82 7B            [ 4]  362 	ld	a,e
   2E83 B7            [ 4]  363 	or	a, a
   2E84 28 0D         [12]  364 	jr	Z,00106$
                            365 ;src/SaveGame.c:132: --i;
   2E86 1D            [ 4]  366 	dec	e
                            367 ;src/SaveGame.c:133: saveArray[i] = saveArray[i]^SAVE_MASK;
   2E87 2A 5F 2D      [16]  368 	ld	hl,(_saveArray)
   2E8A 16 00         [ 7]  369 	ld	d,#0x00
   2E8C 19            [11]  370 	add	hl, de
   2E8D 7E            [ 7]  371 	ld	a,(hl)
   2E8E EE DB         [ 7]  372 	xor	a, #0xDB
   2E90 77            [ 7]  373 	ld	(hl),a
   2E91 18 EF         [12]  374 	jr	00104$
   2E93                     375 00106$:
                            376 ;src/SaveGame.c:136: save.checksum = save.checksum^CHECKSUM_MASK;
   2E93 0A            [ 7]  377 	ld	a,(bc)
   2E94 EE AA         [ 7]  378 	xor	a, #0xAA
   2E96 02            [ 7]  379 	ld	(bc),a
                            380 ;src/SaveGame.c:138: savegame_to_string();
   2E97 C3 E7 2D      [10]  381 	jp  _savegame_to_string
                            382 ;src/SaveGame.c:142: void savegame_decrypt_save(){
                            383 ;	---------------------------------
                            384 ; Function savegame_decrypt_save
                            385 ; ---------------------------------
   2E9A                     386 _savegame_decrypt_save::
                            387 ;src/SaveGame.c:145: while(i){
   2E9A 0E 09         [ 7]  388 	ld	c,#0x09
   2E9C                     389 00101$:
   2E9C 79            [ 4]  390 	ld	a,c
   2E9D B7            [ 4]  391 	or	a, a
   2E9E C8            [11]  392 	ret	Z
                            393 ;src/SaveGame.c:146: --i;
   2E9F 0D            [ 4]  394 	dec	c
                            395 ;src/SaveGame.c:147: saveArray[i] = saveArray[i]^SAVE_MASK;
   2EA0 2A 5F 2D      [16]  396 	ld	hl,(_saveArray)
   2EA3 59            [ 4]  397 	ld	e,c
   2EA4 16 00         [ 7]  398 	ld	d,#0x00
   2EA6 19            [11]  399 	add	hl,de
   2EA7 7E            [ 7]  400 	ld	a,(hl)
   2EA8 EE DB         [ 7]  401 	xor	a, #0xDB
   2EAA 77            [ 7]  402 	ld	(hl),a
   2EAB 18 EF         [12]  403 	jr	00101$
                            404 ;src/SaveGame.c:151: u8 savegame_Load(char * loadstring){
                            405 ;	---------------------------------
                            406 ; Function savegame_Load
                            407 ; ---------------------------------
   2EAD                     408 _savegame_Load::
                            409 ;src/SaveGame.c:152: if(!str_cmp(loadstring,"CAMELOT WARRIORS")){
   2EAD 21 35 2F      [10]  410 	ld	hl,#___str_0
   2EB0 E5            [11]  411 	push	hl
   2EB1 21 04 00      [10]  412 	ld	hl, #4
   2EB4 39            [11]  413 	add	hl, sp
   2EB5 4E            [ 7]  414 	ld	c, (hl)
   2EB6 23            [ 6]  415 	inc	hl
   2EB7 46            [ 7]  416 	ld	b, (hl)
   2EB8 C5            [11]  417 	push	bc
   2EB9 CD 3A 2D      [17]  418 	call	_str_cmp
   2EBC F1            [10]  419 	pop	af
   2EBD F1            [10]  420 	pop	af
   2EBE 7D            [ 4]  421 	ld	a,l
   2EBF B7            [ 4]  422 	or	a, a
   2EC0 20 1A         [12]  423 	jr	NZ,00104$
                            424 ;src/SaveGame.c:153: level_set_level(0);
   2EC2 AF            [ 4]  425 	xor	a, a
   2EC3 F5            [11]  426 	push	af
   2EC4 33            [ 6]  427 	inc	sp
   2EC5 CD 8E 11      [17]  428 	call	_level_set_level
   2EC8 33            [ 6]  429 	inc	sp
                            430 ;src/SaveGame.c:154: camelot_warriors_mode=1;
   2EC9 21 DC 86      [10]  431 	ld	hl,#_camelot_warriors_mode + 0
   2ECC 36 01         [10]  432 	ld	(hl), #0x01
                            433 ;src/SaveGame.c:155: player_init();
   2ECE CD CA 19      [17]  434 	call	_player_init
                            435 ;src/SaveGame.c:156: statemanager_set_state(STATE_LOADLEVEL);
   2ED1 3E 03         [ 7]  436 	ld	a,#0x03
   2ED3 F5            [11]  437 	push	af
   2ED4 33            [ 6]  438 	inc	sp
   2ED5 CD 01 3A      [17]  439 	call	_statemanager_set_state
   2ED8 33            [ 6]  440 	inc	sp
                            441 ;src/SaveGame.c:158: return 1;
   2ED9 2E 01         [ 7]  442 	ld	l,#0x01
   2EDB C9            [10]  443 	ret
   2EDC                     444 00104$:
                            445 ;src/SaveGame.c:161: savegame_string_to_save(loadstring);
   2EDC C1            [10]  446 	pop	bc
   2EDD E1            [10]  447 	pop	hl
   2EDE E5            [11]  448 	push	hl
   2EDF C5            [11]  449 	push	bc
   2EE0 E5            [11]  450 	push	hl
   2EE1 CD 61 2D      [17]  451 	call	_savegame_string_to_save
   2EE4 F1            [10]  452 	pop	af
                            453 ;src/SaveGame.c:162: if(savegame_checksave()){
   2EE5 CD BD 2D      [17]  454 	call	_savegame_checksave
   2EE8 7D            [ 4]  455 	ld	a,l
   2EE9 B7            [ 4]  456 	or	a, a
   2EEA 28 46         [12]  457 	jr	Z,00105$
                            458 ;src/SaveGame.c:163: savegame_decrypt_save();
   2EEC CD 9A 2E      [17]  459 	call	_savegame_decrypt_save
                            460 ;src/SaveGame.c:164: level_set_level(save.level);
   2EEF 21 14 87      [10]  461 	ld	hl, #_save + 7
   2EF2 46            [ 7]  462 	ld	b,(hl)
   2EF3 C5            [11]  463 	push	bc
   2EF4 33            [ 6]  464 	inc	sp
   2EF5 CD 8E 11      [17]  465 	call	_level_set_level
   2EF8 33            [ 6]  466 	inc	sp
                            467 ;src/SaveGame.c:166: player_health_points=save.player_hp;
   2EF9 3A 11 87      [13]  468 	ld	a,(#_save + 4)
   2EFC 32 07 87      [13]  469 	ld	(#_player_health_points + 0),a
                            470 ;src/SaveGame.c:167: player_attack_value=save.player_attack;
   2EFF 3A 12 87      [13]  471 	ld	a,(#_save + 5)
   2F02 32 06 87      [13]  472 	ld	(#_player_attack_value + 0),a
                            473 ;src/SaveGame.c:168: player_defense_value=save.player_defense;
   2F05 3A 13 87      [13]  474 	ld	a,(#_save + 6)
   2F08 32 05 87      [13]  475 	ld	(#_player_defense_value + 0),a
                            476 ;src/SaveGame.c:170: player_potion_count = save.potions;
   2F0B 3A 0F 87      [13]  477 	ld	a,(#_save + 2)
   2F0E 32 0A 87      [13]  478 	ld	(#_player_potion_count + 0),a
                            479 ;src/SaveGame.c:171: player_scroll_count = save.scrolls;
   2F11 3A 10 87      [13]  480 	ld	a,(#_save + 3)
   2F14 32 0B 87      [13]  481 	ld	(#_player_scroll_count + 0),a
                            482 ;src/SaveGame.c:173: level_seed=save.seed;
   2F17 21 0D 87      [10]  483 	ld	hl, #_save + 0
   2F1A 7E            [ 7]  484 	ld	a,(hl)
   2F1B FD 21 2C 87   [14]  485 	ld	iy,#_level_seed
   2F1F FD 77 00      [19]  486 	ld	0 (iy),a
   2F22 23            [ 6]  487 	inc	hl
   2F23 7E            [ 7]  488 	ld	a,(hl)
   2F24 32 2D 87      [13]  489 	ld	(#_level_seed + 1),a
                            490 ;src/SaveGame.c:175: statemanager_set_state(STATE_LOADLEVEL);
   2F27 3E 03         [ 7]  491 	ld	a,#0x03
   2F29 F5            [11]  492 	push	af
   2F2A 33            [ 6]  493 	inc	sp
   2F2B CD 01 3A      [17]  494 	call	_statemanager_set_state
   2F2E 33            [ 6]  495 	inc	sp
                            496 ;src/SaveGame.c:177: return 1;
   2F2F 2E 01         [ 7]  497 	ld	l,#0x01
   2F31 C9            [10]  498 	ret
   2F32                     499 00105$:
                            500 ;src/SaveGame.c:180: return 0;
   2F32 2E 00         [ 7]  501 	ld	l,#0x00
   2F34 C9            [10]  502 	ret
   2F35                     503 ___str_0:
   2F35 43 41 4D 45 4C 4F   504 	.ascii "CAMELOT WARRIORS"
        54 20 57 41 52 52
        49 4F 52 53
   2F45 00                  505 	.db 0x00
                            506 ;src/SaveGame.c:183: char* savegame_get_saveString(){
                            507 ;	---------------------------------
                            508 ; Function savegame_get_saveString
                            509 ; ---------------------------------
   2F46                     510 _savegame_get_saveString::
                            511 ;src/SaveGame.c:184: return saveString;
   2F46 21 16 87      [10]  512 	ld	hl,#_saveString
   2F49 C9            [10]  513 	ret
                            514 	.area _CODE
                            515 	.area _INITIALIZER
                            516 	.area _CABS (ABS)
