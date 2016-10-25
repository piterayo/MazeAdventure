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
   7D6D                      34 _save::
   7D6D                      35 	.ds 9
   7D76                      36 _saveString::
   7D76                      37 	.ds 19
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
   2B78                      66 _str_cmp::
                             67 ;src/SaveGame.c:32: u8 sum=0;
   2B78 0E 00         [ 7]   68 	ld	c,#0x00
                             69 ;src/SaveGame.c:33: while(*a){
   2B7A D1            [10]   70 	pop	de
   2B7B E1            [10]   71 	pop	hl
   2B7C E5            [11]   72 	push	hl
   2B7D D5            [11]   73 	push	de
   2B7E                      74 00101$:
   2B7E 46            [ 7]   75 	ld	b,(hl)
   2B7F 78            [ 4]   76 	ld	a,b
   2B80 B7            [ 4]   77 	or	a, a
   2B81 28 06         [12]   78 	jr	Z,00112$
                             79 ;src/SaveGame.c:34: sum+=*a;
   2B83 79            [ 4]   80 	ld	a,c
   2B84 80            [ 4]   81 	add	a, b
   2B85 4F            [ 4]   82 	ld	c,a
                             83 ;src/SaveGame.c:35: ++a;
   2B86 23            [ 6]   84 	inc	hl
   2B87 18 F5         [12]   85 	jr	00101$
                             86 ;src/SaveGame.c:38: while(*b){
   2B89                      87 00112$:
   2B89 21 04 00      [10]   88 	ld	hl, #4
   2B8C 39            [11]   89 	add	hl, sp
   2B8D 5E            [ 7]   90 	ld	e, (hl)
   2B8E 23            [ 6]   91 	inc	hl
   2B8F 56            [ 7]   92 	ld	d, (hl)
   2B90                      93 00104$:
   2B90 1A            [ 7]   94 	ld	a,(de)
   2B91 47            [ 4]   95 	ld	b,a
   2B92 B7            [ 4]   96 	or	a, a
   2B93 28 06         [12]   97 	jr	Z,00106$
                             98 ;src/SaveGame.c:39: sum-=*b;
   2B95 79            [ 4]   99 	ld	a,c
   2B96 90            [ 4]  100 	sub	a, b
   2B97 4F            [ 4]  101 	ld	c,a
                            102 ;src/SaveGame.c:40: ++b;
   2B98 13            [ 6]  103 	inc	de
   2B99 18 F5         [12]  104 	jr	00104$
   2B9B                     105 00106$:
                            106 ;src/SaveGame.c:43: return sum;
   2B9B 69            [ 4]  107 	ld	l,c
   2B9C C9            [10]  108 	ret
   2B9D                     109 _saveArray:
   2B9D 6D 7D               110 	.dw _save
                            111 ;src/SaveGame.c:46: void savegame_string_to_save(char* in){
                            112 ;	---------------------------------
                            113 ; Function savegame_string_to_save
                            114 ; ---------------------------------
   2B9F                     115 _savegame_string_to_save::
   2B9F DD E5         [15]  116 	push	ix
   2BA1 DD 21 00 00   [14]  117 	ld	ix,#0
   2BA5 DD 39         [15]  118 	add	ix,sp
   2BA7 3B            [ 6]  119 	dec	sp
                            120 ;src/SaveGame.c:51: while(i<SAVEDATA_SIZE){
   2BA8 0E 00         [ 7]  121 	ld	c,#0x00
   2BAA                     122 00106$:
   2BAA 79            [ 4]  123 	ld	a,c
   2BAB D6 09         [ 7]  124 	sub	a, #0x09
   2BAD 30 48         [12]  125 	jr	NC,00111$
                            126 ;src/SaveGame.c:52: val=0;
   2BAF 06 00         [ 7]  127 	ld	b,#0x00
                            128 ;src/SaveGame.c:53: for(j=2;j;--j){
   2BB1 1E 02         [ 7]  129 	ld	e,#0x02
   2BB3 DD 6E 04      [19]  130 	ld	l,4 (ix)
   2BB6 DD 66 05      [19]  131 	ld	h,5 (ix)
   2BB9                     132 00109$:
                            133 ;src/SaveGame.c:54: val=val<<4;
   2BB9 78            [ 4]  134 	ld	a,b
   2BBA 07            [ 4]  135 	rlca
   2BBB 07            [ 4]  136 	rlca
   2BBC 07            [ 4]  137 	rlca
   2BBD 07            [ 4]  138 	rlca
   2BBE E6 F0         [ 7]  139 	and	a,#0xF0
   2BC0 DD 77 FF      [19]  140 	ld	-1 (ix),a
                            141 ;src/SaveGame.c:55: if((*in)>47 && (*in)<=57){//Number
   2BC3 46            [ 7]  142 	ld	b,(hl)
   2BC4 3E 2F         [ 7]  143 	ld	a,#0x2F
   2BC6 90            [ 4]  144 	sub	a, b
   2BC7 30 0E         [12]  145 	jr	NC,00102$
   2BC9 3E 39         [ 7]  146 	ld	a,#0x39
   2BCB 90            [ 4]  147 	sub	a, b
   2BCC 38 09         [12]  148 	jr	C,00102$
                            149 ;src/SaveGame.c:56: val=val|(*in)-48;
   2BCE 78            [ 4]  150 	ld	a,b
   2BCF C6 D0         [ 7]  151 	add	a,#0xD0
   2BD1 DD B6 FF      [19]  152 	or	a, -1 (ix)
   2BD4 47            [ 4]  153 	ld	b,a
   2BD5 18 07         [12]  154 	jr	00103$
   2BD7                     155 00102$:
                            156 ;src/SaveGame.c:59: val=val|(*in)-65+10;
   2BD7 78            [ 4]  157 	ld	a,b
   2BD8 C6 C9         [ 7]  158 	add	a, #0xC9
   2BDA DD B6 FF      [19]  159 	or	a, -1 (ix)
   2BDD 47            [ 4]  160 	ld	b,a
   2BDE                     161 00103$:
                            162 ;src/SaveGame.c:61: ++in;
   2BDE 23            [ 6]  163 	inc	hl
                            164 ;src/SaveGame.c:53: for(j=2;j;--j){
   2BDF 53            [ 4]  165 	ld	d,e
   2BE0 15            [ 4]  166 	dec	d
   2BE1 7A            [ 4]  167 	ld	a,d
   2BE2 5F            [ 4]  168 	ld	e,a
   2BE3 B7            [ 4]  169 	or	a, a
   2BE4 20 D3         [12]  170 	jr	NZ,00109$
                            171 ;src/SaveGame.c:64: saveArray[i]=val;
   2BE6 DD 75 04      [19]  172 	ld	4 (ix),l
   2BE9 DD 74 05      [19]  173 	ld	5 (ix),h
   2BEC 2A 9D 2B      [16]  174 	ld	hl,(_saveArray)
   2BEF 59            [ 4]  175 	ld	e,c
   2BF0 16 00         [ 7]  176 	ld	d,#0x00
   2BF2 19            [11]  177 	add	hl,de
   2BF3 70            [ 7]  178 	ld	(hl),b
                            179 ;src/SaveGame.c:65: ++i;
   2BF4 0C            [ 4]  180 	inc	c
   2BF5 18 B3         [12]  181 	jr	00106$
   2BF7                     182 00111$:
   2BF7 33            [ 6]  183 	inc	sp
   2BF8 DD E1         [14]  184 	pop	ix
   2BFA C9            [10]  185 	ret
                            186 ;src/SaveGame.c:71: u8 savegame_checksave(){
                            187 ;	---------------------------------
                            188 ; Function savegame_checksave
                            189 ; ---------------------------------
   2BFB                     190 _savegame_checksave::
                            191 ;src/SaveGame.c:73: u8 checksum=0;
                            192 ;src/SaveGame.c:76: while(i){
   2BFB 01 00 08      [10]  193 	ld	bc,#0x0800
   2BFE                     194 00101$:
   2BFE 78            [ 4]  195 	ld	a,b
   2BFF B7            [ 4]  196 	or	a, a
   2C00 28 10         [12]  197 	jr	Z,00103$
                            198 ;src/SaveGame.c:77: --i;
   2C02 05            [ 4]  199 	dec	b
                            200 ;src/SaveGame.c:78: checksum+=(saveArray[i]^SAVE_MASK);
   2C03 2A 9D 2B      [16]  201 	ld	hl,(_saveArray)
   2C06 58            [ 4]  202 	ld	e,b
   2C07 16 00         [ 7]  203 	ld	d,#0x00
   2C09 19            [11]  204 	add	hl,de
   2C0A 7E            [ 7]  205 	ld	a,(hl)
   2C0B EE DB         [ 7]  206 	xor	a, #0xDB
   2C0D 5F            [ 4]  207 	ld	e, a
   2C0E 81            [ 4]  208 	add	a,c
   2C0F 4F            [ 4]  209 	ld	c,a
   2C10 18 EC         [12]  210 	jr	00101$
   2C12                     211 00103$:
                            212 ;src/SaveGame.c:80: checksum=checksum^CHECKSUM_MASK^SAVE_MASK;
   2C12 79            [ 4]  213 	ld	a,c
   2C13 EE 71         [ 7]  214 	xor	a, #0x71
   2C15 4F            [ 4]  215 	ld	c,a
                            216 ;src/SaveGame.c:81: return (checksum==save.checksum);
   2C16 21 75 7D      [10]  217 	ld	hl, #(_save + 0x0008) + 0
   2C19 46            [ 7]  218 	ld	b,(hl)
   2C1A 79            [ 4]  219 	ld	a,c
   2C1B 90            [ 4]  220 	sub	a, b
   2C1C 20 04         [12]  221 	jr	NZ,00115$
   2C1E 3E 01         [ 7]  222 	ld	a,#0x01
   2C20 18 01         [12]  223 	jr	00116$
   2C22                     224 00115$:
   2C22 AF            [ 4]  225 	xor	a,a
   2C23                     226 00116$:
   2C23 6F            [ 4]  227 	ld	l,a
   2C24 C9            [10]  228 	ret
                            229 ;src/SaveGame.c:86: void savegame_to_string(){
                            230 ;	---------------------------------
                            231 ; Function savegame_to_string
                            232 ; ---------------------------------
   2C25                     233 _savegame_to_string::
                            234 ;src/SaveGame.c:89: char* string = saveString;
   2C25 11 76 7D      [10]  235 	ld	de,#_saveString
                            236 ;src/SaveGame.c:90: saveString[SAVESTRING_SIZE-1]=0;
   2C28 21 88 7D      [10]  237 	ld	hl,#(_saveString + 0x0012)
   2C2B 36 00         [10]  238 	ld	(hl),#0x00
                            239 ;src/SaveGame.c:93: while(i<SAVEDATA_SIZE){
   2C2D 0E 00         [ 7]  240 	ld	c,#0x00
   2C2F                     241 00107$:
   2C2F 79            [ 4]  242 	ld	a,c
   2C30 D6 09         [ 7]  243 	sub	a, #0x09
   2C32 D0            [11]  244 	ret	NC
                            245 ;src/SaveGame.c:94: val = saveArray[i]>>4;
   2C33 2A 9D 2B      [16]  246 	ld	hl,(_saveArray)
   2C36 06 00         [ 7]  247 	ld	b,#0x00
   2C38 09            [11]  248 	add	hl, bc
   2C39 7E            [ 7]  249 	ld	a,(hl)
   2C3A 07            [ 4]  250 	rlca
   2C3B 07            [ 4]  251 	rlca
   2C3C 07            [ 4]  252 	rlca
   2C3D 07            [ 4]  253 	rlca
   2C3E E6 0F         [ 7]  254 	and	a,#0x0F
                            255 ;src/SaveGame.c:95: if(val<10) *string=48+val;
   2C40 47            [ 4]  256 	ld	b,a
   2C41 D6 0A         [ 7]  257 	sub	a, #0x0A
   2C43 30 06         [12]  258 	jr	NC,00102$
   2C45 78            [ 4]  259 	ld	a,b
   2C46 C6 30         [ 7]  260 	add	a, #0x30
   2C48 12            [ 7]  261 	ld	(de),a
   2C49 18 04         [12]  262 	jr	00103$
   2C4B                     263 00102$:
                            264 ;src/SaveGame.c:96: else *string=65+(val-10);
   2C4B 78            [ 4]  265 	ld	a,b
   2C4C C6 37         [ 7]  266 	add	a, #0x37
   2C4E 12            [ 7]  267 	ld	(de),a
   2C4F                     268 00103$:
                            269 ;src/SaveGame.c:98: ++string;
   2C4F 13            [ 6]  270 	inc	de
                            271 ;src/SaveGame.c:99: val = saveArray[i]&0x0F;
   2C50 2A 9D 2B      [16]  272 	ld	hl,(_saveArray)
   2C53 06 00         [ 7]  273 	ld	b,#0x00
   2C55 09            [11]  274 	add	hl, bc
   2C56 7E            [ 7]  275 	ld	a,(hl)
   2C57 E6 0F         [ 7]  276 	and	a, #0x0F
                            277 ;src/SaveGame.c:100: if(val<10) *string=48+val;
   2C59 47            [ 4]  278 	ld	b,a
   2C5A D6 0A         [ 7]  279 	sub	a, #0x0A
   2C5C 30 06         [12]  280 	jr	NC,00105$
   2C5E 78            [ 4]  281 	ld	a,b
   2C5F C6 30         [ 7]  282 	add	a, #0x30
   2C61 12            [ 7]  283 	ld	(de),a
   2C62 18 04         [12]  284 	jr	00106$
   2C64                     285 00105$:
                            286 ;src/SaveGame.c:101: else *string=65+(val-10);
   2C64 78            [ 4]  287 	ld	a,b
   2C65 C6 37         [ 7]  288 	add	a, #0x37
   2C67 12            [ 7]  289 	ld	(de),a
   2C68                     290 00106$:
                            291 ;src/SaveGame.c:103: ++string;
   2C68 13            [ 6]  292 	inc	de
                            293 ;src/SaveGame.c:104: ++i;
   2C69 0C            [ 4]  294 	inc	c
   2C6A 18 C3         [12]  295 	jr	00107$
                            296 ;src/SaveGame.c:108: void savegame_Save(){
                            297 ;	---------------------------------
                            298 ; Function savegame_Save
                            299 ; ---------------------------------
   2C6C                     300 _savegame_Save::
                            301 ;src/SaveGame.c:112: save.seed = map_get_seed();
   2C6C CD A5 10      [17]  302 	call	_map_get_seed
   2C6F 4D            [ 4]  303 	ld	c,l
   2C70 44            [ 4]  304 	ld	b,h
   2C71 ED 43 6D 7D   [20]  305 	ld	(_save), bc
                            306 ;src/SaveGame.c:114: save.potions = player_potion_count;
   2C75 21 6F 7D      [10]  307 	ld	hl,#(_save + 0x0002)
   2C78 3A 6A 7D      [13]  308 	ld	a,(#_player_potion_count + 0)
   2C7B 77            [ 7]  309 	ld	(hl),a
                            310 ;src/SaveGame.c:115: save.scrolls = player_scroll_count;
   2C7C 21 70 7D      [10]  311 	ld	hl,#(_save + 0x0003)
   2C7F 3A 6B 7D      [13]  312 	ld	a,(#_player_scroll_count + 0)
   2C82 77            [ 7]  313 	ld	(hl),a
                            314 ;src/SaveGame.c:117: save.player_hp = player_health_points;
   2C83 21 71 7D      [10]  315 	ld	hl,#(_save + 0x0004)
   2C86 3A 67 7D      [13]  316 	ld	a,(#_player_health_points + 0)
   2C89 77            [ 7]  317 	ld	(hl),a
                            318 ;src/SaveGame.c:118: save.player_attack = player_attack_value;
   2C8A 21 72 7D      [10]  319 	ld	hl,#(_save + 0x0005)
   2C8D 3A 66 7D      [13]  320 	ld	a,(#_player_attack_value + 0)
   2C90 77            [ 7]  321 	ld	(hl),a
                            322 ;src/SaveGame.c:119: save.player_defense = player_defense_value;
   2C91 21 73 7D      [10]  323 	ld	hl,#(_save + 0x0006)
   2C94 3A 65 7D      [13]  324 	ld	a,(#_player_defense_value + 0)
   2C97 77            [ 7]  325 	ld	(hl),a
                            326 ;src/SaveGame.c:121: save.level = level_get_level();
   2C98 CD A7 0F      [17]  327 	call	_level_get_level
   2C9B 4D            [ 4]  328 	ld	c,l
   2C9C 21 74 7D      [10]  329 	ld	hl,#(_save + 0x0007)
   2C9F 71            [ 7]  330 	ld	(hl),c
                            331 ;src/SaveGame.c:123: save.checksum=0;
   2CA0 01 75 7D      [10]  332 	ld	bc,#_save + 8
   2CA3 AF            [ 4]  333 	xor	a, a
   2CA4 02            [ 7]  334 	ld	(bc),a
                            335 ;src/SaveGame.c:124: while(i){
   2CA5 1E 08         [ 7]  336 	ld	e,#0x08
   2CA7                     337 00101$:
   2CA7 7B            [ 4]  338 	ld	a,e
   2CA8 B7            [ 4]  339 	or	a, a
   2CA9 28 13         [12]  340 	jr	Z,00103$
                            341 ;src/SaveGame.c:125: --i;
   2CAB 1D            [ 4]  342 	dec	e
                            343 ;src/SaveGame.c:126: save.checksum+=saveArray[i];
   2CAC 0A            [ 7]  344 	ld	a,(bc)
   2CAD 57            [ 4]  345 	ld	d,a
   2CAE 2A 9D 2B      [16]  346 	ld	hl,(_saveArray)
   2CB1 7B            [ 4]  347 	ld	a,e
   2CB2 85            [ 4]  348 	add	a, l
   2CB3 6F            [ 4]  349 	ld	l,a
   2CB4 3E 00         [ 7]  350 	ld	a,#0x00
   2CB6 8C            [ 4]  351 	adc	a, h
   2CB7 67            [ 4]  352 	ld	h,a
   2CB8 6E            [ 7]  353 	ld	l,(hl)
   2CB9 7A            [ 4]  354 	ld	a,d
   2CBA 85            [ 4]  355 	add	a, l
   2CBB 02            [ 7]  356 	ld	(bc),a
   2CBC 18 E9         [12]  357 	jr	00101$
   2CBE                     358 00103$:
                            359 ;src/SaveGame.c:131: while(i){
   2CBE 1E 09         [ 7]  360 	ld	e,#0x09
   2CC0                     361 00104$:
   2CC0 7B            [ 4]  362 	ld	a,e
   2CC1 B7            [ 4]  363 	or	a, a
   2CC2 28 0D         [12]  364 	jr	Z,00106$
                            365 ;src/SaveGame.c:132: --i;
   2CC4 1D            [ 4]  366 	dec	e
                            367 ;src/SaveGame.c:133: saveArray[i] = saveArray[i]^SAVE_MASK;
   2CC5 2A 9D 2B      [16]  368 	ld	hl,(_saveArray)
   2CC8 16 00         [ 7]  369 	ld	d,#0x00
   2CCA 19            [11]  370 	add	hl, de
   2CCB 7E            [ 7]  371 	ld	a,(hl)
   2CCC EE DB         [ 7]  372 	xor	a, #0xDB
   2CCE 77            [ 7]  373 	ld	(hl),a
   2CCF 18 EF         [12]  374 	jr	00104$
   2CD1                     375 00106$:
                            376 ;src/SaveGame.c:136: save.checksum = save.checksum^CHECKSUM_MASK;
   2CD1 0A            [ 7]  377 	ld	a,(bc)
   2CD2 EE AA         [ 7]  378 	xor	a, #0xAA
   2CD4 02            [ 7]  379 	ld	(bc),a
                            380 ;src/SaveGame.c:138: savegame_to_string();
   2CD5 C3 25 2C      [10]  381 	jp  _savegame_to_string
                            382 ;src/SaveGame.c:142: void savegame_decrypt_save(){
                            383 ;	---------------------------------
                            384 ; Function savegame_decrypt_save
                            385 ; ---------------------------------
   2CD8                     386 _savegame_decrypt_save::
                            387 ;src/SaveGame.c:145: while(i){
   2CD8 0E 09         [ 7]  388 	ld	c,#0x09
   2CDA                     389 00101$:
   2CDA 79            [ 4]  390 	ld	a,c
   2CDB B7            [ 4]  391 	or	a, a
   2CDC C8            [11]  392 	ret	Z
                            393 ;src/SaveGame.c:146: --i;
   2CDD 0D            [ 4]  394 	dec	c
                            395 ;src/SaveGame.c:147: saveArray[i] = saveArray[i]^SAVE_MASK;
   2CDE 2A 9D 2B      [16]  396 	ld	hl,(_saveArray)
   2CE1 59            [ 4]  397 	ld	e,c
   2CE2 16 00         [ 7]  398 	ld	d,#0x00
   2CE4 19            [11]  399 	add	hl,de
   2CE5 7E            [ 7]  400 	ld	a,(hl)
   2CE6 EE DB         [ 7]  401 	xor	a, #0xDB
   2CE8 77            [ 7]  402 	ld	(hl),a
   2CE9 18 EF         [12]  403 	jr	00101$
                            404 ;src/SaveGame.c:151: u8 savegame_Load(char * loadstring){
                            405 ;	---------------------------------
                            406 ; Function savegame_Load
                            407 ; ---------------------------------
   2CEB                     408 _savegame_Load::
                            409 ;src/SaveGame.c:152: if(!str_cmp(loadstring,"CAMELOT WARRIORS")){
   2CEB 21 73 2D      [10]  410 	ld	hl,#___str_0
   2CEE E5            [11]  411 	push	hl
   2CEF 21 04 00      [10]  412 	ld	hl, #4
   2CF2 39            [11]  413 	add	hl, sp
   2CF3 4E            [ 7]  414 	ld	c, (hl)
   2CF4 23            [ 6]  415 	inc	hl
   2CF5 46            [ 7]  416 	ld	b, (hl)
   2CF6 C5            [11]  417 	push	bc
   2CF7 CD 78 2B      [17]  418 	call	_str_cmp
   2CFA F1            [10]  419 	pop	af
   2CFB F1            [10]  420 	pop	af
   2CFC 7D            [ 4]  421 	ld	a,l
   2CFD B7            [ 4]  422 	or	a, a
   2CFE 20 1A         [12]  423 	jr	NZ,00104$
                            424 ;src/SaveGame.c:153: level_set_level(0);
   2D00 AF            [ 4]  425 	xor	a, a
   2D01 F5            [11]  426 	push	af
   2D02 33            [ 6]  427 	inc	sp
   2D03 CD DC 0F      [17]  428 	call	_level_set_level
   2D06 33            [ 6]  429 	inc	sp
                            430 ;src/SaveGame.c:154: camelot_warriors_mode=1;
   2D07 21 3C 7D      [10]  431 	ld	hl,#_camelot_warriors_mode + 0
   2D0A 36 01         [10]  432 	ld	(hl), #0x01
                            433 ;src/SaveGame.c:155: player_init();
   2D0C CD 08 18      [17]  434 	call	_player_init
                            435 ;src/SaveGame.c:156: statemanager_set_state(STATE_LOADLEVEL);
   2D0F 3E 03         [ 7]  436 	ld	a,#0x03
   2D11 F5            [11]  437 	push	af
   2D12 33            [ 6]  438 	inc	sp
   2D13 CD 96 38      [17]  439 	call	_statemanager_set_state
   2D16 33            [ 6]  440 	inc	sp
                            441 ;src/SaveGame.c:158: return 1;
   2D17 2E 01         [ 7]  442 	ld	l,#0x01
   2D19 C9            [10]  443 	ret
   2D1A                     444 00104$:
                            445 ;src/SaveGame.c:161: savegame_string_to_save(loadstring);
   2D1A C1            [10]  446 	pop	bc
   2D1B E1            [10]  447 	pop	hl
   2D1C E5            [11]  448 	push	hl
   2D1D C5            [11]  449 	push	bc
   2D1E E5            [11]  450 	push	hl
   2D1F CD 9F 2B      [17]  451 	call	_savegame_string_to_save
   2D22 F1            [10]  452 	pop	af
                            453 ;src/SaveGame.c:162: if(savegame_checksave()){
   2D23 CD FB 2B      [17]  454 	call	_savegame_checksave
   2D26 7D            [ 4]  455 	ld	a,l
   2D27 B7            [ 4]  456 	or	a, a
   2D28 28 46         [12]  457 	jr	Z,00105$
                            458 ;src/SaveGame.c:163: savegame_decrypt_save();
   2D2A CD D8 2C      [17]  459 	call	_savegame_decrypt_save
                            460 ;src/SaveGame.c:164: level_set_level(save.level);
   2D2D 21 74 7D      [10]  461 	ld	hl, #_save + 7
   2D30 46            [ 7]  462 	ld	b,(hl)
   2D31 C5            [11]  463 	push	bc
   2D32 33            [ 6]  464 	inc	sp
   2D33 CD DC 0F      [17]  465 	call	_level_set_level
   2D36 33            [ 6]  466 	inc	sp
                            467 ;src/SaveGame.c:166: player_health_points=save.player_hp;
   2D37 3A 71 7D      [13]  468 	ld	a,(#_save + 4)
   2D3A 32 67 7D      [13]  469 	ld	(#_player_health_points + 0),a
                            470 ;src/SaveGame.c:167: player_attack_value=save.player_attack;
   2D3D 3A 72 7D      [13]  471 	ld	a,(#_save + 5)
   2D40 32 66 7D      [13]  472 	ld	(#_player_attack_value + 0),a
                            473 ;src/SaveGame.c:168: player_defense_value=save.player_defense;
   2D43 3A 73 7D      [13]  474 	ld	a,(#_save + 6)
   2D46 32 65 7D      [13]  475 	ld	(#_player_defense_value + 0),a
                            476 ;src/SaveGame.c:170: player_potion_count = save.potions;
   2D49 3A 6F 7D      [13]  477 	ld	a,(#_save + 2)
   2D4C 32 6A 7D      [13]  478 	ld	(#_player_potion_count + 0),a
                            479 ;src/SaveGame.c:171: player_scroll_count = save.scrolls;
   2D4F 3A 70 7D      [13]  480 	ld	a,(#_save + 3)
   2D52 32 6B 7D      [13]  481 	ld	(#_player_scroll_count + 0),a
                            482 ;src/SaveGame.c:173: level_seed=save.seed;
   2D55 21 6D 7D      [10]  483 	ld	hl, #_save + 0
   2D58 7E            [ 7]  484 	ld	a,(hl)
   2D59 FD 21 8C 7D   [14]  485 	ld	iy,#_level_seed
   2D5D FD 77 00      [19]  486 	ld	0 (iy),a
   2D60 23            [ 6]  487 	inc	hl
   2D61 7E            [ 7]  488 	ld	a,(hl)
   2D62 32 8D 7D      [13]  489 	ld	(#_level_seed + 1),a
                            490 ;src/SaveGame.c:175: statemanager_set_state(STATE_LOADLEVEL);
   2D65 3E 03         [ 7]  491 	ld	a,#0x03
   2D67 F5            [11]  492 	push	af
   2D68 33            [ 6]  493 	inc	sp
   2D69 CD 96 38      [17]  494 	call	_statemanager_set_state
   2D6C 33            [ 6]  495 	inc	sp
                            496 ;src/SaveGame.c:177: return 1;
   2D6D 2E 01         [ 7]  497 	ld	l,#0x01
   2D6F C9            [10]  498 	ret
   2D70                     499 00105$:
                            500 ;src/SaveGame.c:180: return 0;
   2D70 2E 00         [ 7]  501 	ld	l,#0x00
   2D72 C9            [10]  502 	ret
   2D73                     503 ___str_0:
   2D73 43 41 4D 45 4C 4F   504 	.ascii "CAMELOT WARRIORS"
        54 20 57 41 52 52
        49 4F 52 53
   2D83 00                  505 	.db 0x00
                            506 ;src/SaveGame.c:183: char* savegame_get_saveString(){
                            507 ;	---------------------------------
                            508 ; Function savegame_get_saveString
                            509 ; ---------------------------------
   2D84                     510 _savegame_get_saveString::
                            511 ;src/SaveGame.c:184: return saveString;
   2D84 21 76 7D      [10]  512 	ld	hl,#_saveString
   2D87 C9            [10]  513 	ret
                            514 	.area _CODE
                            515 	.area _INITIALIZER
                            516 	.area _CABS (ABS)
