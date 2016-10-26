                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module Item
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _item_new_item
                             12 	.globl _ui_log_render
                             13 	.globl _ui_log_add_log
                             14 	.globl _level_get_level
                             15 	.globl _ui_playerstats_render_key
                             16 	.globl _ui_playerstats_render_scrolls
                             17 	.globl _ui_playerstats_render_potions
                             18 	.globl _ui_playerstats_render_defense
                             19 	.globl _ui_playerstats_render_attack
                             20 	.globl _ui_playerstats_render_hp
                             21 	.globl _cpct_getRandom_mxor_u16
                             22 	.globl _cpct_getRandom_mxor_u8
                             23 	.globl _cpct_memset
                             24 	.globl _itemArray
                             25 	.globl _item_spawnedKey
                             26 	.globl _activeItems
                             27 	.globl _item_get_at
                             28 	.globl _item_init_items
                             29 	.globl _item_try_new_spawn
                             30 	.globl _item_try_new_spawn_at
                             31 	.globl _item_pick_item
                             32 	.globl _item_destroy_item
                             33 	.globl _item_use_potion
                             34 	.globl _item_use_scroll
                             35 ;--------------------------------------------------------
                             36 ; special function registers
                             37 ;--------------------------------------------------------
                             38 ;--------------------------------------------------------
                             39 ; ram data
                             40 ;--------------------------------------------------------
                             41 	.area _DATA
   7D63                      42 _activeItems::
   7D63                      43 	.ds 1
   7D64                      44 _item_spawnedKey::
   7D64                      45 	.ds 1
   7D65                      46 _itemArray::
   7D65                      47 	.ds 35
                             48 ;--------------------------------------------------------
                             49 ; ram data
                             50 ;--------------------------------------------------------
                             51 	.area _INITIALIZED
                             52 ;--------------------------------------------------------
                             53 ; absolute external ram data
                             54 ;--------------------------------------------------------
                             55 	.area _DABS (ABS)
                             56 ;--------------------------------------------------------
                             57 ; global & static initialisations
                             58 ;--------------------------------------------------------
                             59 	.area _HOME
                             60 	.area _GSINIT
                             61 	.area _GSFINAL
                             62 	.area _GSINIT
                             63 ;--------------------------------------------------------
                             64 ; Home
                             65 ;--------------------------------------------------------
                             66 	.area _HOME
                             67 	.area _HOME
                             68 ;--------------------------------------------------------
                             69 ; code
                             70 ;--------------------------------------------------------
                             71 	.area _CODE
                             72 ;src/Item.c:25: Item* item_get_at(u8 index){
                             73 ;	---------------------------------
                             74 ; Function item_get_at
                             75 ; ---------------------------------
   0C00                      76 _item_get_at::
   0C00 DD E5         [15]   77 	push	ix
   0C02 DD 21 00 00   [14]   78 	ld	ix,#0
   0C06 DD 39         [15]   79 	add	ix,sp
                             80 ;src/Item.c:26: return (itemArray+index);
   0C08 01 65 7D      [10]   81 	ld	bc,#_itemArray+0
   0C0B DD 5E 04      [19]   82 	ld	e,4 (ix)
   0C0E 16 00         [ 7]   83 	ld	d,#0x00
   0C10 6B            [ 4]   84 	ld	l, e
   0C11 62            [ 4]   85 	ld	h, d
   0C12 29            [11]   86 	add	hl, hl
   0C13 29            [11]   87 	add	hl, hl
   0C14 19            [11]   88 	add	hl, de
   0C15 09            [11]   89 	add	hl,bc
   0C16 DD E1         [14]   90 	pop	ix
   0C18 C9            [10]   91 	ret
                             92 ;src/Item.c:29: void item_init_items(){
                             93 ;	---------------------------------
                             94 ; Function item_init_items
                             95 ; ---------------------------------
   0C19                      96 _item_init_items::
                             97 ;src/Item.c:30: cpct_memset(itemArray, 0, ITEM_MAX_ITEMS*sizeof(Item));
   0C19 21 23 00      [10]   98 	ld	hl,#0x0023
   0C1C E5            [11]   99 	push	hl
   0C1D AF            [ 4]  100 	xor	a, a
   0C1E F5            [11]  101 	push	af
   0C1F 33            [ 6]  102 	inc	sp
   0C20 21 65 7D      [10]  103 	ld	hl,#_itemArray
   0C23 E5            [11]  104 	push	hl
   0C24 CD 9A 7B      [17]  105 	call	_cpct_memset
                            106 ;src/Item.c:31: activeItems=0;
   0C27 21 63 7D      [10]  107 	ld	hl,#_activeItems + 0
   0C2A 36 00         [10]  108 	ld	(hl), #0x00
                            109 ;src/Item.c:32: item_spawnedKey=0;
   0C2C 21 64 7D      [10]  110 	ld	hl,#_item_spawnedKey + 0
   0C2F 36 00         [10]  111 	ld	(hl), #0x00
   0C31 C9            [10]  112 	ret
                            113 ;src/Item.c:41: u8 item_try_new_spawn(){
                            114 ;	---------------------------------
                            115 ; Function item_try_new_spawn
                            116 ; ---------------------------------
   0C32                     117 _item_try_new_spawn::
   0C32 DD E5         [15]  118 	push	ix
   0C34 DD 21 00 00   [14]  119 	ld	ix,#0
   0C38 DD 39         [15]  120 	add	ix,sp
   0C3A F5            [11]  121 	push	af
                            122 ;src/Item.c:44: pos.x=cpct_getRandom_mxor_u8()%MAP_WIDTH;
   0C3B 21 00 00      [10]  123 	ld	hl,#0x0000
   0C3E 39            [11]  124 	add	hl,sp
   0C3F E5            [11]  125 	push	hl
   0C40 CD 97 7A      [17]  126 	call	_cpct_getRandom_mxor_u8
   0C43 7D            [ 4]  127 	ld	a,l
   0C44 E1            [10]  128 	pop	hl
   0C45 E6 1F         [ 7]  129 	and	a, #0x1F
   0C47 77            [ 7]  130 	ld	(hl),a
                            131 ;src/Item.c:45: pos.y=cpct_getRandom_mxor_u8()%MAP_HEIGHT;
   0C48 21 00 00      [10]  132 	ld	hl,#0x0000
   0C4B 39            [11]  133 	add	hl,sp
   0C4C 4D            [ 4]  134 	ld	c,l
   0C4D 44            [ 4]  135 	ld	b,h
   0C4E 59            [ 4]  136 	ld	e, c
   0C4F 50            [ 4]  137 	ld	d, b
   0C50 13            [ 6]  138 	inc	de
   0C51 C5            [11]  139 	push	bc
   0C52 D5            [11]  140 	push	de
   0C53 CD 97 7A      [17]  141 	call	_cpct_getRandom_mxor_u8
   0C56 D1            [10]  142 	pop	de
   0C57 C1            [10]  143 	pop	bc
   0C58 7D            [ 4]  144 	ld	a,l
   0C59 E6 1F         [ 7]  145 	and	a, #0x1F
   0C5B 12            [ 7]  146 	ld	(de),a
                            147 ;src/Item.c:47: return (item_try_new_spawn_at(&pos));
   0C5C C5            [11]  148 	push	bc
   0C5D CD 1A 0E      [17]  149 	call	_item_try_new_spawn_at
   0C60 DD F9         [10]  150 	ld	sp,ix
   0C62 DD E1         [14]  151 	pop	ix
   0C64 C9            [10]  152 	ret
                            153 ;src/Item.c:50: void item_new_item(Vec2u* pos){
                            154 ;	---------------------------------
                            155 ; Function item_new_item
                            156 ; ---------------------------------
   0C65                     157 _item_new_item::
   0C65 DD E5         [15]  158 	push	ix
   0C67 DD 21 00 00   [14]  159 	ld	ix,#0
   0C6B DD 39         [15]  160 	add	ix,sp
   0C6D 21 F3 FF      [10]  161 	ld	hl,#-13
   0C70 39            [11]  162 	add	hl,sp
   0C71 F9            [ 6]  163 	ld	sp,hl
                            164 ;src/Item.c:52: Item* item=(itemArray+ITEM_MAX_ITEMS);
   0C72 DD 36 F8 88   [19]  165 	ld	-8 (ix),#<((_itemArray + 0x0023))
   0C76 DD 36 F9 7D   [19]  166 	ld	-7 (ix),#>((_itemArray + 0x0023))
                            167 ;src/Item.c:56: x=pos->x;
   0C7A DD 7E 04      [19]  168 	ld	a,4 (ix)
   0C7D DD 77 FC      [19]  169 	ld	-4 (ix),a
   0C80 DD 7E 05      [19]  170 	ld	a,5 (ix)
   0C83 DD 77 FD      [19]  171 	ld	-3 (ix),a
   0C86 DD 6E FC      [19]  172 	ld	l,-4 (ix)
   0C89 DD 66 FD      [19]  173 	ld	h,-3 (ix)
   0C8C 7E            [ 7]  174 	ld	a,(hl)
   0C8D DD 77 F5      [19]  175 	ld	-11 (ix),a
                            176 ;src/Item.c:57: y=pos->y;
   0C90 DD 6E FC      [19]  177 	ld	l,-4 (ix)
   0C93 DD 66 FD      [19]  178 	ld	h,-3 (ix)
   0C96 23            [ 6]  179 	inc	hl
   0C97 7E            [ 7]  180 	ld	a,(hl)
   0C98 DD 77 F4      [19]  181 	ld	-12 (ix),a
                            182 ;src/Item.c:59: while(i){
   0C9B DD 36 F3 07   [19]  183 	ld	-13 (ix),#0x07
   0C9F                     184 00114$:
   0C9F DD 7E F3      [19]  185 	ld	a,-13 (ix)
   0CA2 B7            [ 4]  186 	or	a, a
   0CA3 CA 15 0E      [10]  187 	jp	Z,00117$
                            188 ;src/Item.c:60: --i;
   0CA6 DD 35 F3      [23]  189 	dec	-13 (ix)
   0CA9 DD 7E F3      [19]  190 	ld	a,-13 (ix)
   0CAC DD 77 FC      [19]  191 	ld	-4 (ix),a
                            192 ;src/Item.c:61: --item;
   0CAF DD 7E F8      [19]  193 	ld	a,-8 (ix)
   0CB2 C6 FB         [ 7]  194 	add	a,#0xFB
   0CB4 DD 77 F8      [19]  195 	ld	-8 (ix),a
   0CB7 DD 7E F9      [19]  196 	ld	a,-7 (ix)
   0CBA CE FF         [ 7]  197 	adc	a,#0xFF
   0CBC DD 77 F9      [19]  198 	ld	-7 (ix),a
   0CBF DD 7E F8      [19]  199 	ld	a,-8 (ix)
   0CC2 DD 77 F6      [19]  200 	ld	-10 (ix),a
   0CC5 DD 7E F9      [19]  201 	ld	a,-7 (ix)
   0CC8 DD 77 F7      [19]  202 	ld	-9 (ix),a
                            203 ;src/Item.c:62: if(item->value==0){
   0CCB DD 7E F8      [19]  204 	ld	a,-8 (ix)
   0CCE C6 04         [ 7]  205 	add	a, #0x04
   0CD0 DD 77 FA      [19]  206 	ld	-6 (ix),a
   0CD3 DD 7E F9      [19]  207 	ld	a,-7 (ix)
   0CD6 CE 00         [ 7]  208 	adc	a, #0x00
   0CD8 DD 77 FB      [19]  209 	ld	-5 (ix),a
   0CDB DD 6E FA      [19]  210 	ld	l,-6 (ix)
   0CDE DD 66 FB      [19]  211 	ld	h,-5 (ix)
   0CE1 7E            [ 7]  212 	ld	a,(hl)
   0CE2 B7            [ 4]  213 	or	a, a
   0CE3 20 BA         [12]  214 	jr	NZ,00114$
                            215 ;src/Item.c:63: item->id=i;
   0CE5 DD 6E F8      [19]  216 	ld	l,-8 (ix)
   0CE8 DD 66 F9      [19]  217 	ld	h,-7 (ix)
   0CEB DD 7E F3      [19]  218 	ld	a,-13 (ix)
   0CEE 77            [ 7]  219 	ld	(hl),a
                            220 ;src/Item.c:66: item->type=0;
   0CEF DD 4E F6      [19]  221 	ld	c,-10 (ix)
   0CF2 DD 46 F7      [19]  222 	ld	b,-9 (ix)
   0CF5 03            [ 6]  223 	inc	bc
   0CF6 03            [ 6]  224 	inc	bc
   0CF7 03            [ 6]  225 	inc	bc
                            226 ;src/Item.c:65: if((!item_spawnedKey) && (((cpct_getRandom_mxor_u8()%16)==0)||level_get_level()==KING_LEVEL)){//1/16 is key
   0CF8 3A 64 7D      [13]  227 	ld	a,(#_item_spawnedKey + 0)
   0CFB B7            [ 4]  228 	or	a, a
   0CFC 20 1D         [12]  229 	jr	NZ,00102$
   0CFE C5            [11]  230 	push	bc
   0CFF CD 97 7A      [17]  231 	call	_cpct_getRandom_mxor_u8
   0D02 C1            [10]  232 	pop	bc
   0D03 7D            [ 4]  233 	ld	a,l
   0D04 E6 0F         [ 7]  234 	and	a, #0x0F
   0D06 28 0A         [12]  235 	jr	Z,00101$
   0D08 C5            [11]  236 	push	bc
   0D09 CD F0 0F      [17]  237 	call	_level_get_level
   0D0C C1            [10]  238 	pop	bc
   0D0D 7D            [ 4]  239 	ld	a,l
   0D0E D6 20         [ 7]  240 	sub	a, #0x20
   0D10 20 09         [12]  241 	jr	NZ,00102$
   0D12                     242 00101$:
                            243 ;src/Item.c:66: item->type=0;
   0D12 AF            [ 4]  244 	xor	a, a
   0D13 02            [ 7]  245 	ld	(bc),a
                            246 ;src/Item.c:67: item_spawnedKey=1;
   0D14 21 64 7D      [10]  247 	ld	hl,#_item_spawnedKey + 0
   0D17 36 01         [10]  248 	ld	(hl), #0x01
   0D19 18 0A         [12]  249 	jr	00103$
   0D1B                     250 00102$:
                            251 ;src/Item.c:72: item->type = (cpct_getRandom_mxor_u8()&3)+1;
   0D1B C5            [11]  252 	push	bc
   0D1C CD 97 7A      [17]  253 	call	_cpct_getRandom_mxor_u8
   0D1F C1            [10]  254 	pop	bc
   0D20 7D            [ 4]  255 	ld	a,l
   0D21 E6 03         [ 7]  256 	and	a, #0x03
   0D23 3C            [ 4]  257 	inc	a
   0D24 02            [ 7]  258 	ld	(bc),a
   0D25                     259 00103$:
                            260 ;src/Item.c:76: if(item->type == 1){
   0D25 0A            [ 7]  261 	ld	a,(bc)
   0D26 DD 77 F8      [19]  262 	ld	-8 (ix), a
   0D29 3D            [ 4]  263 	dec	a
   0D2A 20 27         [12]  264 	jr	NZ,00110$
                            265 ;src/Item.c:77: item->value = 48 +level_get_level() + (cpct_getRandom_mxor_u8()&7);
   0D2C CD F0 0F      [17]  266 	call	_level_get_level
   0D2F DD 75 FF      [19]  267 	ld	-1 (ix), l
   0D32 7D            [ 4]  268 	ld	a, l
   0D33 C6 30         [ 7]  269 	add	a, #0x30
   0D35 DD 77 FF      [19]  270 	ld	-1 (ix),a
   0D38 CD 97 7A      [17]  271 	call	_cpct_getRandom_mxor_u8
   0D3B DD 75 FE      [19]  272 	ld	-2 (ix), l
   0D3E 7D            [ 4]  273 	ld	a, l
   0D3F E6 07         [ 7]  274 	and	a, #0x07
   0D41 DD 77 FE      [19]  275 	ld	-2 (ix),a
   0D44 DD 7E FF      [19]  276 	ld	a,-1 (ix)
   0D47 DD 86 FE      [19]  277 	add	a, -2 (ix)
   0D4A DD 6E FA      [19]  278 	ld	l,-6 (ix)
   0D4D DD 66 FB      [19]  279 	ld	h,-5 (ix)
   0D50 77            [ 7]  280 	ld	(hl),a
   0D51 18 3C         [12]  281 	jr	00111$
   0D53                     282 00110$:
                            283 ;src/Item.c:79: else if(item->type == 2){
   0D53 DD 7E F8      [19]  284 	ld	a,-8 (ix)
   0D56 D6 02         [ 7]  285 	sub	a, #0x02
   0D58 20 2D         [12]  286 	jr	NZ,00107$
                            287 ;src/Item.c:80: item->value = 4 + level_get_level() + (cpct_getRandom_mxor_u8()&7);
   0D5A CD F0 0F      [17]  288 	call	_level_get_level
   0D5D DD 75 FE      [19]  289 	ld	-2 (ix),l
   0D60 DD 34 FE      [23]  290 	inc	-2 (ix)
   0D63 DD 34 FE      [23]  291 	inc	-2 (ix)
   0D66 DD 34 FE      [23]  292 	inc	-2 (ix)
   0D69 DD 34 FE      [23]  293 	inc	-2 (ix)
   0D6C CD 97 7A      [17]  294 	call	_cpct_getRandom_mxor_u8
   0D6F DD 75 FF      [19]  295 	ld	-1 (ix), l
   0D72 7D            [ 4]  296 	ld	a, l
   0D73 E6 07         [ 7]  297 	and	a, #0x07
   0D75 DD 77 FF      [19]  298 	ld	-1 (ix),a
   0D78 DD 7E FE      [19]  299 	ld	a,-2 (ix)
   0D7B DD 86 FF      [19]  300 	add	a, -1 (ix)
   0D7E DD 6E FA      [19]  301 	ld	l,-6 (ix)
   0D81 DD 66 FB      [19]  302 	ld	h,-5 (ix)
   0D84 77            [ 7]  303 	ld	(hl),a
   0D85 18 08         [12]  304 	jr	00111$
   0D87                     305 00107$:
                            306 ;src/Item.c:83: item->value=1;
   0D87 DD 6E FA      [19]  307 	ld	l,-6 (ix)
   0D8A DD 66 FB      [19]  308 	ld	h,-5 (ix)
   0D8D 36 01         [10]  309 	ld	(hl),#0x01
   0D8F                     310 00111$:
                            311 ;src/Item.c:86: item->position.x = x;
   0D8F DD 4E F6      [19]  312 	ld	c,-10 (ix)
   0D92 DD 46 F7      [19]  313 	ld	b,-9 (ix)
   0D95 03            [ 6]  314 	inc	bc
   0D96 DD 7E F5      [19]  315 	ld	a,-11 (ix)
   0D99 02            [ 7]  316 	ld	(bc),a
                            317 ;src/Item.c:87: item->position.y = y;
   0D9A 03            [ 6]  318 	inc	bc
   0D9B DD 7E F4      [19]  319 	ld	a,-12 (ix)
   0D9E 02            [ 7]  320 	ld	(bc),a
                            321 ;src/Item.c:89: map[x+(y*MAP_WIDTH)] |=((i+1)<<4);
   0D9F DD 7E F5      [19]  322 	ld	a,-11 (ix)
   0DA2 DD 77 FA      [19]  323 	ld	-6 (ix),a
   0DA5 DD 36 FB 00   [19]  324 	ld	-5 (ix),#0x00
   0DA9 DD 7E F4      [19]  325 	ld	a,-12 (ix)
   0DAC DD 77 F8      [19]  326 	ld	-8 (ix),a
   0DAF DD 36 F9 00   [19]  327 	ld	-7 (ix),#0x00
   0DB3 3E 06         [ 7]  328 	ld	a,#0x05+1
   0DB5 18 08         [12]  329 	jr	00155$
   0DB7                     330 00154$:
   0DB7 DD CB F8 26   [23]  331 	sla	-8 (ix)
   0DBB DD CB F9 16   [23]  332 	rl	-7 (ix)
   0DBF                     333 00155$:
   0DBF 3D            [ 4]  334 	dec	a
   0DC0 20 F5         [12]  335 	jr	NZ,00154$
   0DC2 DD 7E FA      [19]  336 	ld	a,-6 (ix)
   0DC5 DD 86 F8      [19]  337 	add	a, -8 (ix)
   0DC8 DD 77 FA      [19]  338 	ld	-6 (ix),a
   0DCB DD 7E FB      [19]  339 	ld	a,-5 (ix)
   0DCE DD 8E F9      [19]  340 	adc	a, -7 (ix)
   0DD1 DD 77 FB      [19]  341 	ld	-5 (ix),a
   0DD4 DD 7E FA      [19]  342 	ld	a,-6 (ix)
   0DD7 C6 D0         [ 7]  343 	add	a, #0xD0
   0DD9 DD 77 FA      [19]  344 	ld	-6 (ix),a
   0DDC DD 7E FB      [19]  345 	ld	a,-5 (ix)
   0DDF CE 88         [ 7]  346 	adc	a, #0x88
   0DE1 DD 77 FB      [19]  347 	ld	-5 (ix),a
   0DE4 DD 6E FA      [19]  348 	ld	l,-6 (ix)
   0DE7 DD 66 FB      [19]  349 	ld	h,-5 (ix)
   0DEA 7E            [ 7]  350 	ld	a,(hl)
   0DEB DD 77 FE      [19]  351 	ld	-2 (ix),a
   0DEE DD 7E FC      [19]  352 	ld	a,-4 (ix)
   0DF1 3C            [ 4]  353 	inc	a
   0DF2 DD 77 FF      [19]  354 	ld	-1 (ix), a
   0DF5 07            [ 4]  355 	rlca
   0DF6 07            [ 4]  356 	rlca
   0DF7 07            [ 4]  357 	rlca
   0DF8 07            [ 4]  358 	rlca
   0DF9 E6 F0         [ 7]  359 	and	a,#0xF0
   0DFB DD 77 FF      [19]  360 	ld	-1 (ix),a
   0DFE DD 7E FE      [19]  361 	ld	a,-2 (ix)
   0E01 DD B6 FF      [19]  362 	or	a, -1 (ix)
   0E04 DD 77 FE      [19]  363 	ld	-2 (ix),a
   0E07 DD 6E FA      [19]  364 	ld	l,-6 (ix)
   0E0A DD 66 FB      [19]  365 	ld	h,-5 (ix)
   0E0D DD 7E FE      [19]  366 	ld	a,-2 (ix)
   0E10 77            [ 7]  367 	ld	(hl),a
                            368 ;src/Item.c:91: ++activeItems;
   0E11 21 63 7D      [10]  369 	ld	hl, #_activeItems+0
   0E14 34            [11]  370 	inc	(hl)
                            371 ;src/Item.c:92: break;
   0E15                     372 00117$:
   0E15 DD F9         [10]  373 	ld	sp, ix
   0E17 DD E1         [14]  374 	pop	ix
   0E19 C9            [10]  375 	ret
                            376 ;src/Item.c:97: u8 item_try_new_spawn_at(Vec2u* pos){
                            377 ;	---------------------------------
                            378 ; Function item_try_new_spawn_at
                            379 ; ---------------------------------
   0E1A                     380 _item_try_new_spawn_at::
   0E1A DD E5         [15]  381 	push	ix
   0E1C DD 21 00 00   [14]  382 	ld	ix,#0
   0E20 DD 39         [15]  383 	add	ix,sp
   0E22 3B            [ 6]  384 	dec	sp
                            385 ;src/Item.c:100: x=pos->x;
   0E23 DD 4E 04      [19]  386 	ld	c,4 (ix)
   0E26 DD 46 05      [19]  387 	ld	b,5 (ix)
   0E29 0A            [ 7]  388 	ld	a,(bc)
   0E2A 5F            [ 4]  389 	ld	e,a
                            390 ;src/Item.c:101: y=pos->y;
   0E2B 69            [ 4]  391 	ld	l, c
   0E2C 60            [ 4]  392 	ld	h, b
   0E2D 23            [ 6]  393 	inc	hl
   0E2E 7E            [ 7]  394 	ld	a,(hl)
   0E2F DD 77 FF      [19]  395 	ld	-1 (ix),a
                            396 ;src/Item.c:103: if(activeItems<ITEM_MAX_ITEMS){
   0E32 3A 63 7D      [13]  397 	ld	a,(#_activeItems + 0)
   0E35 D6 07         [ 7]  398 	sub	a, #0x07
   0E37 30 1F         [12]  399 	jr	NC,00104$
                            400 ;src/Item.c:104: if(((map[x+(y*MAP_WIDTH)])&(CELL_WALL_MASK|CELL_ITEM_MASK))==0){
   0E39 16 00         [ 7]  401 	ld	d,#0x00
   0E3B DD 6E FF      [19]  402 	ld	l,-1 (ix)
   0E3E 26 00         [ 7]  403 	ld	h,#0x00
   0E40 29            [11]  404 	add	hl, hl
   0E41 29            [11]  405 	add	hl, hl
   0E42 29            [11]  406 	add	hl, hl
   0E43 29            [11]  407 	add	hl, hl
   0E44 29            [11]  408 	add	hl, hl
   0E45 19            [11]  409 	add	hl,de
   0E46 11 D0 88      [10]  410 	ld	de,#0x88D0
   0E49 19            [11]  411 	add	hl,de
   0E4A 7E            [ 7]  412 	ld	a,(hl)
   0E4B E6 F0         [ 7]  413 	and	a, #0xF0
   0E4D 20 09         [12]  414 	jr	NZ,00104$
                            415 ;src/Item.c:105: item_new_item(pos);
   0E4F C5            [11]  416 	push	bc
   0E50 CD 65 0C      [17]  417 	call	_item_new_item
   0E53 F1            [10]  418 	pop	af
                            419 ;src/Item.c:106: return 1;
   0E54 2E 01         [ 7]  420 	ld	l,#0x01
   0E56 18 02         [12]  421 	jr	00105$
   0E58                     422 00104$:
                            423 ;src/Item.c:109: return 0;
   0E58 2E 00         [ 7]  424 	ld	l,#0x00
   0E5A                     425 00105$:
   0E5A 33            [ 6]  426 	inc	sp
   0E5B DD E1         [14]  427 	pop	ix
   0E5D C9            [10]  428 	ret
                            429 ;src/Item.c:112: void item_pick_item(Item* i){
                            430 ;	---------------------------------
                            431 ; Function item_pick_item
                            432 ; ---------------------------------
   0E5E                     433 _item_pick_item::
   0E5E DD E5         [15]  434 	push	ix
   0E60 DD 21 00 00   [14]  435 	ld	ix,#0
   0E64 DD 39         [15]  436 	add	ix,sp
   0E66 F5            [11]  437 	push	af
   0E67 F5            [11]  438 	push	af
                            439 ;src/Item.c:114: switch(i->type){
   0E68 DD 4E 04      [19]  440 	ld	c,4 (ix)
   0E6B DD 46 05      [19]  441 	ld	b,5 (ix)
   0E6E 69            [ 4]  442 	ld	l, c
   0E6F 60            [ 4]  443 	ld	h, b
   0E70 23            [ 6]  444 	inc	hl
   0E71 23            [ 6]  445 	inc	hl
   0E72 23            [ 6]  446 	inc	hl
   0E73 5E            [ 7]  447 	ld	e,(hl)
   0E74 3E 04         [ 7]  448 	ld	a,#0x04
   0E76 93            [ 4]  449 	sub	a, e
   0E77 DA FD 0E      [10]  450 	jp	C,00106$
                            451 ;src/Item.c:122: player_attack_value=(i->value>player_attack_value)?i->value:player_attack_value;
   0E7A 21 04 00      [10]  452 	ld	hl,#0x0004
   0E7D 09            [11]  453 	add	hl,bc
   0E7E DD 75 FE      [19]  454 	ld	-2 (ix),l
   0E81 DD 74 FF      [19]  455 	ld	-1 (ix),h
                            456 ;src/Item.c:114: switch(i->type){
   0E84 16 00         [ 7]  457 	ld	d,#0x00
   0E86 21 8C 0E      [10]  458 	ld	hl,#00125$
   0E89 19            [11]  459 	add	hl,de
   0E8A 19            [11]  460 	add	hl,de
                            461 ;src/Item.c:115: case 0:{//key
   0E8B E9            [ 4]  462 	jp	(hl)
   0E8C                     463 00125$:
   0E8C 18 08         [12]  464 	jr	00101$
   0E8E 18 15         [12]  465 	jr	00102$
   0E90 18 32         [12]  466 	jr	00103$
   0E92 18 4F         [12]  467 	jr	00104$
   0E94 18 5B         [12]  468 	jr	00105$
   0E96                     469 00101$:
                            470 ;src/Item.c:116: player_has_key=1;
   0E96 21 8F 7D      [10]  471 	ld	hl,#_player_has_key + 0
   0E99 36 01         [10]  472 	ld	(hl), #0x01
                            473 ;src/Item.c:117: ui_playerstats_render_key();
   0E9B C5            [11]  474 	push	bc
   0E9C CD 5E 4D      [17]  475 	call	_ui_playerstats_render_key
   0E9F C1            [10]  476 	pop	bc
                            477 ;src/Item.c:118: object = "KEY";
   0EA0 11 22 0F      [10]  478 	ld	de,#___str_0+0
                            479 ;src/Item.c:119: break;
   0EA3 18 58         [12]  480 	jr	00106$
                            481 ;src/Item.c:121: case 1:{
   0EA5                     482 00102$:
                            483 ;src/Item.c:122: player_attack_value=(i->value>player_attack_value)?i->value:player_attack_value;
   0EA5 DD 6E FE      [19]  484 	ld	l,-2 (ix)
   0EA8 DD 66 FF      [19]  485 	ld	h,-1 (ix)
   0EAB 5E            [ 7]  486 	ld	e,(hl)
   0EAC 3A 8C 7D      [13]  487 	ld	a,(#_player_attack_value)
   0EAF 93            [ 4]  488 	sub	a, e
   0EB0 38 04         [12]  489 	jr	C,00110$
   0EB2 21 8C 7D      [10]  490 	ld	hl,#_player_attack_value + 0
   0EB5 5E            [ 7]  491 	ld	e, (hl)
   0EB6                     492 00110$:
   0EB6 21 8C 7D      [10]  493 	ld	hl,#_player_attack_value + 0
   0EB9 73            [ 7]  494 	ld	(hl), e
                            495 ;src/Item.c:123: ui_playerstats_render_attack();
   0EBA C5            [11]  496 	push	bc
   0EBB CD 86 4C      [17]  497 	call	_ui_playerstats_render_attack
   0EBE C1            [10]  498 	pop	bc
                            499 ;src/Item.c:124: object="SWORD";
   0EBF 11 26 0F      [10]  500 	ld	de,#___str_1
                            501 ;src/Item.c:125: break;
   0EC2 18 39         [12]  502 	jr	00106$
                            503 ;src/Item.c:127: case 2:{
   0EC4                     504 00103$:
                            505 ;src/Item.c:128: player_defense_value = (i->value>player_defense_value)?i->value:player_defense_value;
   0EC4 DD 6E FE      [19]  506 	ld	l,-2 (ix)
   0EC7 DD 66 FF      [19]  507 	ld	h,-1 (ix)
   0ECA 5E            [ 7]  508 	ld	e,(hl)
   0ECB 3A 8B 7D      [13]  509 	ld	a,(#_player_defense_value)
   0ECE 93            [ 4]  510 	sub	a, e
   0ECF 38 04         [12]  511 	jr	C,00112$
   0ED1 21 8B 7D      [10]  512 	ld	hl,#_player_defense_value + 0
   0ED4 5E            [ 7]  513 	ld	e, (hl)
   0ED5                     514 00112$:
   0ED5 21 8B 7D      [10]  515 	ld	hl,#_player_defense_value + 0
   0ED8 73            [ 7]  516 	ld	(hl), e
                            517 ;src/Item.c:129: ui_playerstats_render_defense();
   0ED9 C5            [11]  518 	push	bc
   0EDA CD BC 4C      [17]  519 	call	_ui_playerstats_render_defense
   0EDD C1            [10]  520 	pop	bc
                            521 ;src/Item.c:130: object="ARMOR";
   0EDE 11 2C 0F      [10]  522 	ld	de,#___str_2
                            523 ;src/Item.c:131: break;
   0EE1 18 1A         [12]  524 	jr	00106$
                            525 ;src/Item.c:133: case 3:{
   0EE3                     526 00104$:
                            527 ;src/Item.c:134: ++player_potion_count;
   0EE3 21 90 7D      [10]  528 	ld	hl, #_player_potion_count+0
   0EE6 34            [11]  529 	inc	(hl)
                            530 ;src/Item.c:135: ui_playerstats_render_potions();
   0EE7 C5            [11]  531 	push	bc
   0EE8 CD F2 4C      [17]  532 	call	_ui_playerstats_render_potions
   0EEB C1            [10]  533 	pop	bc
                            534 ;src/Item.c:136: object="POTION";
   0EEC 11 32 0F      [10]  535 	ld	de,#___str_3
                            536 ;src/Item.c:137: break;
   0EEF 18 0C         [12]  537 	jr	00106$
                            538 ;src/Item.c:139: case 4:{
   0EF1                     539 00105$:
                            540 ;src/Item.c:140: ++player_scroll_count;
   0EF1 21 91 7D      [10]  541 	ld	hl, #_player_scroll_count+0
   0EF4 34            [11]  542 	inc	(hl)
                            543 ;src/Item.c:141: ui_playerstats_render_scrolls();
   0EF5 C5            [11]  544 	push	bc
   0EF6 CD 28 4D      [17]  545 	call	_ui_playerstats_render_scrolls
   0EF9 C1            [10]  546 	pop	bc
                            547 ;src/Item.c:142: object="SCROLL";
   0EFA 11 39 0F      [10]  548 	ld	de,#___str_4
                            549 ;src/Item.c:145: }
   0EFD                     550 00106$:
                            551 ;src/Item.c:147: ui_log_add_log("PICKED",3);
   0EFD C5            [11]  552 	push	bc
   0EFE D5            [11]  553 	push	de
   0EFF 3E 03         [ 7]  554 	ld	a,#0x03
   0F01 F5            [11]  555 	push	af
   0F02 33            [ 6]  556 	inc	sp
   0F03 21 40 0F      [10]  557 	ld	hl,#___str_5
   0F06 E5            [11]  558 	push	hl
   0F07 CD 81 47      [17]  559 	call	_ui_log_add_log
   0F0A F1            [10]  560 	pop	af
   0F0B 33            [ 6]  561 	inc	sp
   0F0C D1            [10]  562 	pop	de
   0F0D 3E 06         [ 7]  563 	ld	a,#0x06
   0F0F F5            [11]  564 	push	af
   0F10 33            [ 6]  565 	inc	sp
   0F11 D5            [11]  566 	push	de
   0F12 CD 81 47      [17]  567 	call	_ui_log_add_log
   0F15 F1            [10]  568 	pop	af
   0F16 33            [ 6]  569 	inc	sp
   0F17 CD CC 47      [17]  570 	call	_ui_log_render
   0F1A CD 47 0F      [17]  571 	call	_item_destroy_item
   0F1D DD F9         [10]  572 	ld	sp,ix
   0F1F DD E1         [14]  573 	pop	ix
   0F21 C9            [10]  574 	ret
   0F22                     575 ___str_0:
   0F22 4B 45 59            576 	.ascii "KEY"
   0F25 00                  577 	.db 0x00
   0F26                     578 ___str_1:
   0F26 53 57 4F 52 44      579 	.ascii "SWORD"
   0F2B 00                  580 	.db 0x00
   0F2C                     581 ___str_2:
   0F2C 41 52 4D 4F 52      582 	.ascii "ARMOR"
   0F31 00                  583 	.db 0x00
   0F32                     584 ___str_3:
   0F32 50 4F 54 49 4F 4E   585 	.ascii "POTION"
   0F38 00                  586 	.db 0x00
   0F39                     587 ___str_4:
   0F39 53 43 52 4F 4C 4C   588 	.ascii "SCROLL"
   0F3F 00                  589 	.db 0x00
   0F40                     590 ___str_5:
   0F40 50 49 43 4B 45 44   591 	.ascii "PICKED"
   0F46 00                  592 	.db 0x00
                            593 ;src/Item.c:154: void item_destroy_item(Item* i){
                            594 ;	---------------------------------
                            595 ; Function item_destroy_item
                            596 ; ---------------------------------
   0F47                     597 _item_destroy_item::
   0F47 DD E5         [15]  598 	push	ix
   0F49 DD 21 00 00   [14]  599 	ld	ix,#0
   0F4D DD 39         [15]  600 	add	ix,sp
                            601 ;src/Item.c:155: u8* mapPos = (u8*)(MAP_MEM + i->position.x + (i->position.y*MAP_WIDTH));
   0F4F DD 5E 04      [19]  602 	ld	e,4 (ix)
   0F52 DD 56 05      [19]  603 	ld	d,5 (ix)
   0F55 6B            [ 4]  604 	ld	l, e
   0F56 62            [ 4]  605 	ld	h, d
   0F57 23            [ 6]  606 	inc	hl
   0F58 4E            [ 7]  607 	ld	c,(hl)
   0F59 06 00         [ 7]  608 	ld	b,#0x00
   0F5B 21 D0 88      [10]  609 	ld	hl,#0x88D0
   0F5E 09            [11]  610 	add	hl,bc
   0F5F 4D            [ 4]  611 	ld	c,l
   0F60 44            [ 4]  612 	ld	b,h
   0F61 6B            [ 4]  613 	ld	l, e
   0F62 62            [ 4]  614 	ld	h, d
   0F63 23            [ 6]  615 	inc	hl
   0F64 23            [ 6]  616 	inc	hl
   0F65 6E            [ 7]  617 	ld	l,(hl)
   0F66 26 00         [ 7]  618 	ld	h,#0x00
   0F68 29            [11]  619 	add	hl, hl
   0F69 29            [11]  620 	add	hl, hl
   0F6A 29            [11]  621 	add	hl, hl
   0F6B 29            [11]  622 	add	hl, hl
   0F6C 29            [11]  623 	add	hl, hl
   0F6D 09            [11]  624 	add	hl,bc
   0F6E 4D            [ 4]  625 	ld	c,l
   0F6F 44            [ 4]  626 	ld	b,h
                            627 ;src/Item.c:157: --activeItems;
   0F70 21 63 7D      [10]  628 	ld	hl, #_activeItems+0
   0F73 35            [11]  629 	dec	(hl)
                            630 ;src/Item.c:159: i->value=0;
   0F74 13            [ 6]  631 	inc	de
   0F75 13            [ 6]  632 	inc	de
   0F76 13            [ 6]  633 	inc	de
   0F77 13            [ 6]  634 	inc	de
   0F78 AF            [ 4]  635 	xor	a, a
   0F79 12            [ 7]  636 	ld	(de),a
                            637 ;src/Item.c:161: *mapPos = *mapPos&(CELL_WALL_MASK|CELL_ENEMY_MASK);
   0F7A 0A            [ 7]  638 	ld	a,(bc)
   0F7B E6 8F         [ 7]  639 	and	a, #0x8F
   0F7D 02            [ 7]  640 	ld	(bc),a
   0F7E DD E1         [14]  641 	pop	ix
   0F80 C9            [10]  642 	ret
                            643 ;src/Item.c:165: u8 item_use_potion(){
                            644 ;	---------------------------------
                            645 ; Function item_use_potion
                            646 ; ---------------------------------
   0F81                     647 _item_use_potion::
                            648 ;src/Item.c:166: if(player_potion_count){
   0F81 3A 90 7D      [13]  649 	ld	a,(#_player_potion_count + 0)
   0F84 B7            [ 4]  650 	or	a, a
   0F85 28 1F         [12]  651 	jr	Z,00105$
                            652 ;src/Item.c:167: --player_potion_count;
   0F87 21 90 7D      [10]  653 	ld	hl, #_player_potion_count+0
   0F8A 35            [11]  654 	dec	(hl)
                            655 ;src/Item.c:168: if(player_health_points<(255-ITEM_POTION_HEAL)){
   0F8B 3A 8D 7D      [13]  656 	ld	a,(#_player_health_points + 0)
   0F8E D6 80         [ 7]  657 	sub	a, #0x80
   0F90 30 09         [12]  658 	jr	NC,00102$
                            659 ;src/Item.c:169: player_health_points+=ITEM_POTION_HEAL;
   0F92 21 8D 7D      [10]  660 	ld	hl,#_player_health_points
   0F95 7E            [ 7]  661 	ld	a,(hl)
   0F96 C6 7F         [ 7]  662 	add	a, #0x7F
   0F98 77            [ 7]  663 	ld	(hl),a
   0F99 18 05         [12]  664 	jr	00103$
   0F9B                     665 00102$:
                            666 ;src/Item.c:172: player_health_points=255;
   0F9B 21 8D 7D      [10]  667 	ld	hl,#_player_health_points + 0
   0F9E 36 FF         [10]  668 	ld	(hl), #0xFF
   0FA0                     669 00103$:
                            670 ;src/Item.c:174: ui_playerstats_render_hp();
   0FA0 CD 25 4C      [17]  671 	call	_ui_playerstats_render_hp
                            672 ;src/Item.c:175: return 1;
   0FA3 2E 01         [ 7]  673 	ld	l,#0x01
   0FA5 C9            [10]  674 	ret
   0FA6                     675 00105$:
                            676 ;src/Item.c:177: return 0;
   0FA6 2E 00         [ 7]  677 	ld	l,#0x00
   0FA8 C9            [10]  678 	ret
                            679 ;src/Item.c:180: u8 item_use_scroll(){
                            680 ;	---------------------------------
                            681 ; Function item_use_scroll
                            682 ; ---------------------------------
   0FA9                     683 _item_use_scroll::
                            684 ;src/Item.c:181: u16 pos = (cpct_getRandom_mxor_u16()%1024);
   0FA9 CD E0 7A      [17]  685 	call	_cpct_getRandom_mxor_u16
   0FAC 4D            [ 4]  686 	ld	c,l
   0FAD 7C            [ 4]  687 	ld	a,h
   0FAE E6 03         [ 7]  688 	and	a, #0x03
   0FB0 47            [ 4]  689 	ld	b,a
                            690 ;src/Item.c:182: if(player_scroll_count){
   0FB1 3A 91 7D      [13]  691 	ld	a,(#_player_scroll_count + 0)
   0FB4 B7            [ 4]  692 	or	a, a
   0FB5 28 36         [12]  693 	jr	Z,00105$
                            694 ;src/Item.c:183: while(*(u8*)(MAP_MEM+pos)!=CELLTYPE_FLOOR){
   0FB7                     695 00101$:
   0FB7 21 D0 88      [10]  696 	ld	hl,#0x88D0
   0FBA 09            [11]  697 	add	hl,bc
   0FBB 7E            [ 7]  698 	ld	a,(hl)
   0FBC B7            [ 4]  699 	or	a, a
   0FBD 28 07         [12]  700 	jr	Z,00103$
                            701 ;src/Item.c:184: pos = (pos+1)%1024;
   0FBF 03            [ 6]  702 	inc	bc
   0FC0 78            [ 4]  703 	ld	a,b
   0FC1 E6 03         [ 7]  704 	and	a, #0x03
   0FC3 47            [ 4]  705 	ld	b,a
   0FC4 18 F1         [12]  706 	jr	00101$
   0FC6                     707 00103$:
                            708 ;src/Item.c:186: --player_scroll_count;
   0FC6 21 91 7D      [10]  709 	ld	hl, #_player_scroll_count+0
   0FC9 35            [11]  710 	dec	(hl)
                            711 ;src/Item.c:187: *(u8*)&(player_position.x) = (pos%MAP_WIDTH);
   0FCA 79            [ 4]  712 	ld	a,c
   0FCB E6 1F         [ 7]  713 	and	a, #0x1F
   0FCD 5F            [ 4]  714 	ld	e,a
   0FCE 21 75 18      [10]  715 	ld	hl,#_player_position
   0FD1 73            [ 7]  716 	ld	(hl),e
                            717 ;src/Item.c:188: *(u8*)&(player_position.y) = (pos/MAP_HEIGHT);
   0FD2 CB 38         [ 8]  718 	srl	b
   0FD4 CB 19         [ 8]  719 	rr	c
   0FD6 CB 38         [ 8]  720 	srl	b
   0FD8 CB 19         [ 8]  721 	rr	c
   0FDA CB 38         [ 8]  722 	srl	b
   0FDC CB 19         [ 8]  723 	rr	c
   0FDE CB 38         [ 8]  724 	srl	b
   0FE0 CB 19         [ 8]  725 	rr	c
   0FE2 CB 38         [ 8]  726 	srl	b
   0FE4 CB 19         [ 8]  727 	rr	c
   0FE6 21 76 18      [10]  728 	ld	hl,#(_player_position + 0x0001)
   0FE9 71            [ 7]  729 	ld	(hl),c
                            730 ;src/Item.c:189: return 1;
   0FEA 2E 01         [ 7]  731 	ld	l,#0x01
   0FEC C9            [10]  732 	ret
   0FED                     733 00105$:
                            734 ;src/Item.c:191: return 0;
   0FED 2E 00         [ 7]  735 	ld	l,#0x00
   0FEF C9            [10]  736 	ret
                            737 	.area _CODE
                            738 	.area _INITIALIZER
                            739 	.area _CABS (ABS)
