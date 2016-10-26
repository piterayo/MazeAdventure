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
   7D93                      34 _save::
   7D93                      35 	.ds 9
   7D9C                      36 _saveString::
   7D9C                      37 	.ds 19
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
   2BC1                      66 _str_cmp::
                             67 ;src/SaveGame.c:32: u8 sum=0;
   2BC1 0E 00         [ 7]   68 	ld	c,#0x00
                             69 ;src/SaveGame.c:33: while(*a){
   2BC3 D1            [10]   70 	pop	de
   2BC4 E1            [10]   71 	pop	hl
   2BC5 E5            [11]   72 	push	hl
   2BC6 D5            [11]   73 	push	de
   2BC7                      74 00101$:
   2BC7 46            [ 7]   75 	ld	b,(hl)
   2BC8 78            [ 4]   76 	ld	a,b
   2BC9 B7            [ 4]   77 	or	a, a
   2BCA 28 06         [12]   78 	jr	Z,00112$
                             79 ;src/SaveGame.c:34: sum+=*a;
   2BCC 79            [ 4]   80 	ld	a,c
   2BCD 80            [ 4]   81 	add	a, b
   2BCE 4F            [ 4]   82 	ld	c,a
                             83 ;src/SaveGame.c:35: ++a;
   2BCF 23            [ 6]   84 	inc	hl
   2BD0 18 F5         [12]   85 	jr	00101$
                             86 ;src/SaveGame.c:38: while(*b){
   2BD2                      87 00112$:
   2BD2 21 04 00      [10]   88 	ld	hl, #4
   2BD5 39            [11]   89 	add	hl, sp
   2BD6 5E            [ 7]   90 	ld	e, (hl)
   2BD7 23            [ 6]   91 	inc	hl
   2BD8 56            [ 7]   92 	ld	d, (hl)
   2BD9                      93 00104$:
   2BD9 1A            [ 7]   94 	ld	a,(de)
   2BDA 47            [ 4]   95 	ld	b,a
   2BDB B7            [ 4]   96 	or	a, a
   2BDC 28 06         [12]   97 	jr	Z,00106$
                             98 ;src/SaveGame.c:39: sum-=*b;
   2BDE 79            [ 4]   99 	ld	a,c
   2BDF 90            [ 4]  100 	sub	a, b
   2BE0 4F            [ 4]  101 	ld	c,a
                            102 ;src/SaveGame.c:40: ++b;
   2BE1 13            [ 6]  103 	inc	de
   2BE2 18 F5         [12]  104 	jr	00104$
   2BE4                     105 00106$:
                            106 ;src/SaveGame.c:43: return sum;
   2BE4 69            [ 4]  107 	ld	l,c
   2BE5 C9            [10]  108 	ret
   2BE6                     109 _saveArray:
   2BE6 93 7D               110 	.dw _save
                            111 ;src/SaveGame.c:46: void savegame_string_to_save(char* in){
                            112 ;	---------------------------------
                            113 ; Function savegame_string_to_save
                            114 ; ---------------------------------
   2BE8                     115 _savegame_string_to_save::
   2BE8 DD E5         [15]  116 	push	ix
   2BEA DD 21 00 00   [14]  117 	ld	ix,#0
   2BEE DD 39         [15]  118 	add	ix,sp
   2BF0 3B            [ 6]  119 	dec	sp
                            120 ;src/SaveGame.c:51: while(i<SAVEDATA_SIZE){
   2BF1 0E 00         [ 7]  121 	ld	c,#0x00
   2BF3                     122 00106$:
   2BF3 79            [ 4]  123 	ld	a,c
   2BF4 D6 09         [ 7]  124 	sub	a, #0x09
   2BF6 30 48         [12]  125 	jr	NC,00111$
                            126 ;src/SaveGame.c:52: val=0;
   2BF8 06 00         [ 7]  127 	ld	b,#0x00
                            128 ;src/SaveGame.c:53: for(j=2;j;--j){
   2BFA 1E 02         [ 7]  129 	ld	e,#0x02
   2BFC DD 6E 04      [19]  130 	ld	l,4 (ix)
   2BFF DD 66 05      [19]  131 	ld	h,5 (ix)
   2C02                     132 00109$:
                            133 ;src/SaveGame.c:54: val=val<<4;
   2C02 78            [ 4]  134 	ld	a,b
   2C03 07            [ 4]  135 	rlca
   2C04 07            [ 4]  136 	rlca
   2C05 07            [ 4]  137 	rlca
   2C06 07            [ 4]  138 	rlca
   2C07 E6 F0         [ 7]  139 	and	a,#0xF0
   2C09 DD 77 FF      [19]  140 	ld	-1 (ix),a
                            141 ;src/SaveGame.c:55: if((*in)>47 && (*in)<=57){//Number
   2C0C 46            [ 7]  142 	ld	b,(hl)
   2C0D 3E 2F         [ 7]  143 	ld	a,#0x2F
   2C0F 90            [ 4]  144 	sub	a, b
   2C10 30 0E         [12]  145 	jr	NC,00102$
   2C12 3E 39         [ 7]  146 	ld	a,#0x39
   2C14 90            [ 4]  147 	sub	a, b
   2C15 38 09         [12]  148 	jr	C,00102$
                            149 ;src/SaveGame.c:56: val=val|(*in)-48;
   2C17 78            [ 4]  150 	ld	a,b
   2C18 C6 D0         [ 7]  151 	add	a,#0xD0
   2C1A DD B6 FF      [19]  152 	or	a, -1 (ix)
   2C1D 47            [ 4]  153 	ld	b,a
   2C1E 18 07         [12]  154 	jr	00103$
   2C20                     155 00102$:
                            156 ;src/SaveGame.c:59: val=val|(*in)-65+10;
   2C20 78            [ 4]  157 	ld	a,b
   2C21 C6 C9         [ 7]  158 	add	a, #0xC9
   2C23 DD B6 FF      [19]  159 	or	a, -1 (ix)
   2C26 47            [ 4]  160 	ld	b,a
   2C27                     161 00103$:
                            162 ;src/SaveGame.c:61: ++in;
   2C27 23            [ 6]  163 	inc	hl
                            164 ;src/SaveGame.c:53: for(j=2;j;--j){
   2C28 53            [ 4]  165 	ld	d,e
   2C29 15            [ 4]  166 	dec	d
   2C2A 7A            [ 4]  167 	ld	a,d
   2C2B 5F            [ 4]  168 	ld	e,a
   2C2C B7            [ 4]  169 	or	a, a
   2C2D 20 D3         [12]  170 	jr	NZ,00109$
                            171 ;src/SaveGame.c:64: saveArray[i]=val;
   2C2F DD 75 04      [19]  172 	ld	4 (ix),l
   2C32 DD 74 05      [19]  173 	ld	5 (ix),h
   2C35 2A E6 2B      [16]  174 	ld	hl,(_saveArray)
   2C38 59            [ 4]  175 	ld	e,c
   2C39 16 00         [ 7]  176 	ld	d,#0x00
   2C3B 19            [11]  177 	add	hl,de
   2C3C 70            [ 7]  178 	ld	(hl),b
                            179 ;src/SaveGame.c:65: ++i;
   2C3D 0C            [ 4]  180 	inc	c
   2C3E 18 B3         [12]  181 	jr	00106$
   2C40                     182 00111$:
   2C40 33            [ 6]  183 	inc	sp
   2C41 DD E1         [14]  184 	pop	ix
   2C43 C9            [10]  185 	ret
                            186 ;src/SaveGame.c:71: u8 savegame_checksave(){
                            187 ;	---------------------------------
                            188 ; Function savegame_checksave
                            189 ; ---------------------------------
   2C44                     190 _savegame_checksave::
                            191 ;src/SaveGame.c:73: u8 checksum=0;
                            192 ;src/SaveGame.c:76: while(i){
   2C44 01 00 08      [10]  193 	ld	bc,#0x0800
   2C47                     194 00101$:
   2C47 78            [ 4]  195 	ld	a,b
   2C48 B7            [ 4]  196 	or	a, a
   2C49 28 10         [12]  197 	jr	Z,00103$
                            198 ;src/SaveGame.c:77: --i;
   2C4B 05            [ 4]  199 	dec	b
                            200 ;src/SaveGame.c:78: checksum+=(saveArray[i]^SAVE_MASK);
   2C4C 2A E6 2B      [16]  201 	ld	hl,(_saveArray)
   2C4F 58            [ 4]  202 	ld	e,b
   2C50 16 00         [ 7]  203 	ld	d,#0x00
   2C52 19            [11]  204 	add	hl,de
   2C53 7E            [ 7]  205 	ld	a,(hl)
   2C54 EE DB         [ 7]  206 	xor	a, #0xDB
   2C56 5F            [ 4]  207 	ld	e, a
   2C57 81            [ 4]  208 	add	a,c
   2C58 4F            [ 4]  209 	ld	c,a
   2C59 18 EC         [12]  210 	jr	00101$
   2C5B                     211 00103$:
                            212 ;src/SaveGame.c:80: checksum=checksum^CHECKSUM_MASK^SAVE_MASK;
   2C5B 79            [ 4]  213 	ld	a,c
   2C5C EE 71         [ 7]  214 	xor	a, #0x71
   2C5E 4F            [ 4]  215 	ld	c,a
                            216 ;src/SaveGame.c:81: return (checksum==save.checksum);
   2C5F 21 9B 7D      [10]  217 	ld	hl, #(_save + 0x0008) + 0
   2C62 46            [ 7]  218 	ld	b,(hl)
   2C63 79            [ 4]  219 	ld	a,c
   2C64 90            [ 4]  220 	sub	a, b
   2C65 20 04         [12]  221 	jr	NZ,00115$
   2C67 3E 01         [ 7]  222 	ld	a,#0x01
   2C69 18 01         [12]  223 	jr	00116$
   2C6B                     224 00115$:
   2C6B AF            [ 4]  225 	xor	a,a
   2C6C                     226 00116$:
   2C6C 6F            [ 4]  227 	ld	l,a
   2C6D C9            [10]  228 	ret
                            229 ;src/SaveGame.c:86: void savegame_to_string(){
                            230 ;	---------------------------------
                            231 ; Function savegame_to_string
                            232 ; ---------------------------------
   2C6E                     233 _savegame_to_string::
                            234 ;src/SaveGame.c:89: char* string = saveString;
   2C6E 11 9C 7D      [10]  235 	ld	de,#_saveString
                            236 ;src/SaveGame.c:90: saveString[SAVESTRING_SIZE-1]=0;
   2C71 21 AE 7D      [10]  237 	ld	hl,#(_saveString + 0x0012)
   2C74 36 00         [10]  238 	ld	(hl),#0x00
                            239 ;src/SaveGame.c:93: while(i<SAVEDATA_SIZE){
   2C76 0E 00         [ 7]  240 	ld	c,#0x00
   2C78                     241 00107$:
   2C78 79            [ 4]  242 	ld	a,c
   2C79 D6 09         [ 7]  243 	sub	a, #0x09
   2C7B D0            [11]  244 	ret	NC
                            245 ;src/SaveGame.c:94: val = saveArray[i]>>4;
   2C7C 2A E6 2B      [16]  246 	ld	hl,(_saveArray)
   2C7F 06 00         [ 7]  247 	ld	b,#0x00
   2C81 09            [11]  248 	add	hl, bc
   2C82 7E            [ 7]  249 	ld	a,(hl)
   2C83 07            [ 4]  250 	rlca
   2C84 07            [ 4]  251 	rlca
   2C85 07            [ 4]  252 	rlca
   2C86 07            [ 4]  253 	rlca
   2C87 E6 0F         [ 7]  254 	and	a,#0x0F
                            255 ;src/SaveGame.c:95: if(val<10) *string=48+val;
   2C89 47            [ 4]  256 	ld	b,a
   2C8A D6 0A         [ 7]  257 	sub	a, #0x0A
   2C8C 30 06         [12]  258 	jr	NC,00102$
   2C8E 78            [ 4]  259 	ld	a,b
   2C8F C6 30         [ 7]  260 	add	a, #0x30
   2C91 12            [ 7]  261 	ld	(de),a
   2C92 18 04         [12]  262 	jr	00103$
   2C94                     263 00102$:
                            264 ;src/SaveGame.c:96: else *string=65+(val-10);
   2C94 78            [ 4]  265 	ld	a,b
   2C95 C6 37         [ 7]  266 	add	a, #0x37
   2C97 12            [ 7]  267 	ld	(de),a
   2C98                     268 00103$:
                            269 ;src/SaveGame.c:98: ++string;
   2C98 13            [ 6]  270 	inc	de
                            271 ;src/SaveGame.c:99: val = saveArray[i]&0x0F;
   2C99 2A E6 2B      [16]  272 	ld	hl,(_saveArray)
   2C9C 06 00         [ 7]  273 	ld	b,#0x00
   2C9E 09            [11]  274 	add	hl, bc
   2C9F 7E            [ 7]  275 	ld	a,(hl)
   2CA0 E6 0F         [ 7]  276 	and	a, #0x0F
                            277 ;src/SaveGame.c:100: if(val<10) *string=48+val;
   2CA2 47            [ 4]  278 	ld	b,a
   2CA3 D6 0A         [ 7]  279 	sub	a, #0x0A
   2CA5 30 06         [12]  280 	jr	NC,00105$
   2CA7 78            [ 4]  281 	ld	a,b
   2CA8 C6 30         [ 7]  282 	add	a, #0x30
   2CAA 12            [ 7]  283 	ld	(de),a
   2CAB 18 04         [12]  284 	jr	00106$
   2CAD                     285 00105$:
                            286 ;src/SaveGame.c:101: else *string=65+(val-10);
   2CAD 78            [ 4]  287 	ld	a,b
   2CAE C6 37         [ 7]  288 	add	a, #0x37
   2CB0 12            [ 7]  289 	ld	(de),a
   2CB1                     290 00106$:
                            291 ;src/SaveGame.c:103: ++string;
   2CB1 13            [ 6]  292 	inc	de
                            293 ;src/SaveGame.c:104: ++i;
   2CB2 0C            [ 4]  294 	inc	c
   2CB3 18 C3         [12]  295 	jr	00107$
                            296 ;src/SaveGame.c:108: void savegame_Save(){
                            297 ;	---------------------------------
                            298 ; Function savegame_Save
                            299 ; ---------------------------------
   2CB5                     300 _savegame_Save::
                            301 ;src/SaveGame.c:112: save.seed = map_get_seed();
   2CB5 CD EE 10      [17]  302 	call	_map_get_seed
   2CB8 4D            [ 4]  303 	ld	c,l
   2CB9 44            [ 4]  304 	ld	b,h
   2CBA ED 43 93 7D   [20]  305 	ld	(_save), bc
                            306 ;src/SaveGame.c:114: save.potions = player_potion_count;
   2CBE 21 95 7D      [10]  307 	ld	hl,#(_save + 0x0002)
   2CC1 3A 90 7D      [13]  308 	ld	a,(#_player_potion_count + 0)
   2CC4 77            [ 7]  309 	ld	(hl),a
                            310 ;src/SaveGame.c:115: save.scrolls = player_scroll_count;
   2CC5 21 96 7D      [10]  311 	ld	hl,#(_save + 0x0003)
   2CC8 3A 91 7D      [13]  312 	ld	a,(#_player_scroll_count + 0)
   2CCB 77            [ 7]  313 	ld	(hl),a
                            314 ;src/SaveGame.c:117: save.player_hp = player_health_points;
   2CCC 21 97 7D      [10]  315 	ld	hl,#(_save + 0x0004)
   2CCF 3A 8D 7D      [13]  316 	ld	a,(#_player_health_points + 0)
   2CD2 77            [ 7]  317 	ld	(hl),a
                            318 ;src/SaveGame.c:118: save.player_attack = player_attack_value;
   2CD3 21 98 7D      [10]  319 	ld	hl,#(_save + 0x0005)
   2CD6 3A 8C 7D      [13]  320 	ld	a,(#_player_attack_value + 0)
   2CD9 77            [ 7]  321 	ld	(hl),a
                            322 ;src/SaveGame.c:119: save.player_defense = player_defense_value;
   2CDA 21 99 7D      [10]  323 	ld	hl,#(_save + 0x0006)
   2CDD 3A 8B 7D      [13]  324 	ld	a,(#_player_defense_value + 0)
   2CE0 77            [ 7]  325 	ld	(hl),a
                            326 ;src/SaveGame.c:121: save.level = level_get_level();
   2CE1 CD F0 0F      [17]  327 	call	_level_get_level
   2CE4 4D            [ 4]  328 	ld	c,l
   2CE5 21 9A 7D      [10]  329 	ld	hl,#(_save + 0x0007)
   2CE8 71            [ 7]  330 	ld	(hl),c
                            331 ;src/SaveGame.c:123: save.checksum=0;
   2CE9 01 9B 7D      [10]  332 	ld	bc,#_save + 8
   2CEC AF            [ 4]  333 	xor	a, a
   2CED 02            [ 7]  334 	ld	(bc),a
                            335 ;src/SaveGame.c:124: while(i){
   2CEE 1E 08         [ 7]  336 	ld	e,#0x08
   2CF0                     337 00101$:
   2CF0 7B            [ 4]  338 	ld	a,e
   2CF1 B7            [ 4]  339 	or	a, a
   2CF2 28 13         [12]  340 	jr	Z,00103$
                            341 ;src/SaveGame.c:125: --i;
   2CF4 1D            [ 4]  342 	dec	e
                            343 ;src/SaveGame.c:126: save.checksum+=saveArray[i];
   2CF5 0A            [ 7]  344 	ld	a,(bc)
   2CF6 57            [ 4]  345 	ld	d,a
   2CF7 2A E6 2B      [16]  346 	ld	hl,(_saveArray)
   2CFA 7B            [ 4]  347 	ld	a,e
   2CFB 85            [ 4]  348 	add	a, l
   2CFC 6F            [ 4]  349 	ld	l,a
   2CFD 3E 00         [ 7]  350 	ld	a,#0x00
   2CFF 8C            [ 4]  351 	adc	a, h
   2D00 67            [ 4]  352 	ld	h,a
   2D01 6E            [ 7]  353 	ld	l,(hl)
   2D02 7A            [ 4]  354 	ld	a,d
   2D03 85            [ 4]  355 	add	a, l
   2D04 02            [ 7]  356 	ld	(bc),a
   2D05 18 E9         [12]  357 	jr	00101$
   2D07                     358 00103$:
                            359 ;src/SaveGame.c:131: while(i){
   2D07 1E 09         [ 7]  360 	ld	e,#0x09
   2D09                     361 00104$:
   2D09 7B            [ 4]  362 	ld	a,e
   2D0A B7            [ 4]  363 	or	a, a
   2D0B 28 0D         [12]  364 	jr	Z,00106$
                            365 ;src/SaveGame.c:132: --i;
   2D0D 1D            [ 4]  366 	dec	e
                            367 ;src/SaveGame.c:133: saveArray[i] = saveArray[i]^SAVE_MASK;
   2D0E 2A E6 2B      [16]  368 	ld	hl,(_saveArray)
   2D11 16 00         [ 7]  369 	ld	d,#0x00
   2D13 19            [11]  370 	add	hl, de
   2D14 7E            [ 7]  371 	ld	a,(hl)
   2D15 EE DB         [ 7]  372 	xor	a, #0xDB
   2D17 77            [ 7]  373 	ld	(hl),a
   2D18 18 EF         [12]  374 	jr	00104$
   2D1A                     375 00106$:
                            376 ;src/SaveGame.c:136: save.checksum = save.checksum^CHECKSUM_MASK;
   2D1A 0A            [ 7]  377 	ld	a,(bc)
   2D1B EE AA         [ 7]  378 	xor	a, #0xAA
   2D1D 02            [ 7]  379 	ld	(bc),a
                            380 ;src/SaveGame.c:138: savegame_to_string();
   2D1E C3 6E 2C      [10]  381 	jp  _savegame_to_string
                            382 ;src/SaveGame.c:142: void savegame_decrypt_save(){
                            383 ;	---------------------------------
                            384 ; Function savegame_decrypt_save
                            385 ; ---------------------------------
   2D21                     386 _savegame_decrypt_save::
                            387 ;src/SaveGame.c:145: while(i){
   2D21 0E 09         [ 7]  388 	ld	c,#0x09
   2D23                     389 00101$:
   2D23 79            [ 4]  390 	ld	a,c
   2D24 B7            [ 4]  391 	or	a, a
   2D25 C8            [11]  392 	ret	Z
                            393 ;src/SaveGame.c:146: --i;
   2D26 0D            [ 4]  394 	dec	c
                            395 ;src/SaveGame.c:147: saveArray[i] = saveArray[i]^SAVE_MASK;
   2D27 2A E6 2B      [16]  396 	ld	hl,(_saveArray)
   2D2A 59            [ 4]  397 	ld	e,c
   2D2B 16 00         [ 7]  398 	ld	d,#0x00
   2D2D 19            [11]  399 	add	hl,de
   2D2E 7E            [ 7]  400 	ld	a,(hl)
   2D2F EE DB         [ 7]  401 	xor	a, #0xDB
   2D31 77            [ 7]  402 	ld	(hl),a
   2D32 18 EF         [12]  403 	jr	00101$
                            404 ;src/SaveGame.c:151: u8 savegame_Load(char * loadstring){
                            405 ;	---------------------------------
                            406 ; Function savegame_Load
                            407 ; ---------------------------------
   2D34                     408 _savegame_Load::
                            409 ;src/SaveGame.c:152: if(!str_cmp(loadstring,"CAMELOT WARRIORS")){
   2D34 21 BC 2D      [10]  410 	ld	hl,#___str_0
   2D37 E5            [11]  411 	push	hl
   2D38 21 04 00      [10]  412 	ld	hl, #4
   2D3B 39            [11]  413 	add	hl, sp
   2D3C 4E            [ 7]  414 	ld	c, (hl)
   2D3D 23            [ 6]  415 	inc	hl
   2D3E 46            [ 7]  416 	ld	b, (hl)
   2D3F C5            [11]  417 	push	bc
   2D40 CD C1 2B      [17]  418 	call	_str_cmp
   2D43 F1            [10]  419 	pop	af
   2D44 F1            [10]  420 	pop	af
   2D45 7D            [ 4]  421 	ld	a,l
   2D46 B7            [ 4]  422 	or	a, a
   2D47 20 1A         [12]  423 	jr	NZ,00104$
                            424 ;src/SaveGame.c:153: level_set_level(0);
   2D49 AF            [ 4]  425 	xor	a, a
   2D4A F5            [11]  426 	push	af
   2D4B 33            [ 6]  427 	inc	sp
   2D4C CD 25 10      [17]  428 	call	_level_set_level
   2D4F 33            [ 6]  429 	inc	sp
                            430 ;src/SaveGame.c:154: camelot_warriors_mode=1;
   2D50 21 62 7D      [10]  431 	ld	hl,#_camelot_warriors_mode + 0
   2D53 36 01         [10]  432 	ld	(hl), #0x01
                            433 ;src/SaveGame.c:155: player_init();
   2D55 CD 51 18      [17]  434 	call	_player_init
                            435 ;src/SaveGame.c:156: statemanager_set_state(STATE_LOADLEVEL);
   2D58 3E 03         [ 7]  436 	ld	a,#0x03
   2D5A F5            [11]  437 	push	af
   2D5B 33            [ 6]  438 	inc	sp
   2D5C CD BC 38      [17]  439 	call	_statemanager_set_state
   2D5F 33            [ 6]  440 	inc	sp
                            441 ;src/SaveGame.c:158: return 1;
   2D60 2E 01         [ 7]  442 	ld	l,#0x01
   2D62 C9            [10]  443 	ret
   2D63                     444 00104$:
                            445 ;src/SaveGame.c:161: savegame_string_to_save(loadstring);
   2D63 C1            [10]  446 	pop	bc
   2D64 E1            [10]  447 	pop	hl
   2D65 E5            [11]  448 	push	hl
   2D66 C5            [11]  449 	push	bc
   2D67 E5            [11]  450 	push	hl
   2D68 CD E8 2B      [17]  451 	call	_savegame_string_to_save
   2D6B F1            [10]  452 	pop	af
                            453 ;src/SaveGame.c:162: if(savegame_checksave()){
   2D6C CD 44 2C      [17]  454 	call	_savegame_checksave
   2D6F 7D            [ 4]  455 	ld	a,l
   2D70 B7            [ 4]  456 	or	a, a
   2D71 28 46         [12]  457 	jr	Z,00105$
                            458 ;src/SaveGame.c:163: savegame_decrypt_save();
   2D73 CD 21 2D      [17]  459 	call	_savegame_decrypt_save
                            460 ;src/SaveGame.c:164: level_set_level(save.level);
   2D76 21 9A 7D      [10]  461 	ld	hl, #_save + 7
   2D79 46            [ 7]  462 	ld	b,(hl)
   2D7A C5            [11]  463 	push	bc
   2D7B 33            [ 6]  464 	inc	sp
   2D7C CD 25 10      [17]  465 	call	_level_set_level
   2D7F 33            [ 6]  466 	inc	sp
                            467 ;src/SaveGame.c:166: player_health_points=save.player_hp;
   2D80 3A 97 7D      [13]  468 	ld	a,(#_save + 4)
   2D83 32 8D 7D      [13]  469 	ld	(#_player_health_points + 0),a
                            470 ;src/SaveGame.c:167: player_attack_value=save.player_attack;
   2D86 3A 98 7D      [13]  471 	ld	a,(#_save + 5)
   2D89 32 8C 7D      [13]  472 	ld	(#_player_attack_value + 0),a
                            473 ;src/SaveGame.c:168: player_defense_value=save.player_defense;
   2D8C 3A 99 7D      [13]  474 	ld	a,(#_save + 6)
   2D8F 32 8B 7D      [13]  475 	ld	(#_player_defense_value + 0),a
                            476 ;src/SaveGame.c:170: player_potion_count = save.potions;
   2D92 3A 95 7D      [13]  477 	ld	a,(#_save + 2)
   2D95 32 90 7D      [13]  478 	ld	(#_player_potion_count + 0),a
                            479 ;src/SaveGame.c:171: player_scroll_count = save.scrolls;
   2D98 3A 96 7D      [13]  480 	ld	a,(#_save + 3)
   2D9B 32 91 7D      [13]  481 	ld	(#_player_scroll_count + 0),a
                            482 ;src/SaveGame.c:173: level_seed=save.seed;
   2D9E 21 93 7D      [10]  483 	ld	hl, #_save + 0
   2DA1 7E            [ 7]  484 	ld	a,(hl)
   2DA2 FD 21 B2 7D   [14]  485 	ld	iy,#_level_seed
   2DA6 FD 77 00      [19]  486 	ld	0 (iy),a
   2DA9 23            [ 6]  487 	inc	hl
   2DAA 7E            [ 7]  488 	ld	a,(hl)
   2DAB 32 B3 7D      [13]  489 	ld	(#_level_seed + 1),a
                            490 ;src/SaveGame.c:175: statemanager_set_state(STATE_LOADLEVEL);
   2DAE 3E 03         [ 7]  491 	ld	a,#0x03
   2DB0 F5            [11]  492 	push	af
   2DB1 33            [ 6]  493 	inc	sp
   2DB2 CD BC 38      [17]  494 	call	_statemanager_set_state
   2DB5 33            [ 6]  495 	inc	sp
                            496 ;src/SaveGame.c:177: return 1;
   2DB6 2E 01         [ 7]  497 	ld	l,#0x01
   2DB8 C9            [10]  498 	ret
   2DB9                     499 00105$:
                            500 ;src/SaveGame.c:180: return 0;
   2DB9 2E 00         [ 7]  501 	ld	l,#0x00
   2DBB C9            [10]  502 	ret
   2DBC                     503 ___str_0:
   2DBC 43 41 4D 45 4C 4F   504 	.ascii "CAMELOT WARRIORS"
        54 20 57 41 52 52
        49 4F 52 53
   2DCC 00                  505 	.db 0x00
                            506 ;src/SaveGame.c:183: char* savegame_get_saveString(){
                            507 ;	---------------------------------
                            508 ; Function savegame_get_saveString
                            509 ; ---------------------------------
   2DCD                     510 _savegame_get_saveString::
                            511 ;src/SaveGame.c:184: return saveString;
   2DCD 21 9C 7D      [10]  512 	ld	hl,#_saveString
   2DD0 C9            [10]  513 	ret
                            514 	.area _CODE
                            515 	.area _INITIALIZER
                            516 	.area _CABS (ABS)
