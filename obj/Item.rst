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
   86DD                      42 _activeItems::
   86DD                      43 	.ds 1
   86DE                      44 _item_spawnedKey::
   86DE                      45 	.ds 1
   86DF                      46 _itemArray::
   86DF                      47 	.ds 35
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
   0D69                      76 _item_get_at::
   0D69 DD E5         [15]   77 	push	ix
   0D6B DD 21 00 00   [14]   78 	ld	ix,#0
   0D6F DD 39         [15]   79 	add	ix,sp
                             80 ;src/Item.c:26: return (itemArray+index);
   0D71 01 DF 86      [10]   81 	ld	bc,#_itemArray+0
   0D74 DD 5E 04      [19]   82 	ld	e,4 (ix)
   0D77 16 00         [ 7]   83 	ld	d,#0x00
   0D79 6B            [ 4]   84 	ld	l, e
   0D7A 62            [ 4]   85 	ld	h, d
   0D7B 29            [11]   86 	add	hl, hl
   0D7C 29            [11]   87 	add	hl, hl
   0D7D 19            [11]   88 	add	hl, de
   0D7E 09            [11]   89 	add	hl,bc
   0D7F DD E1         [14]   90 	pop	ix
   0D81 C9            [10]   91 	ret
                             92 ;src/Item.c:29: void item_init_items(){
                             93 ;	---------------------------------
                             94 ; Function item_init_items
                             95 ; ---------------------------------
   0D82                      96 _item_init_items::
                             97 ;src/Item.c:30: cpct_memset(itemArray, 0, ITEM_MAX_ITEMS*sizeof(Item));
   0D82 21 23 00      [10]   98 	ld	hl,#0x0023
   0D85 E5            [11]   99 	push	hl
   0D86 AF            [ 4]  100 	xor	a, a
   0D87 F5            [11]  101 	push	af
   0D88 33            [ 6]  102 	inc	sp
   0D89 21 DF 86      [10]  103 	ld	hl,#_itemArray
   0D8C E5            [11]  104 	push	hl
   0D8D CD 11 85      [17]  105 	call	_cpct_memset
                            106 ;src/Item.c:31: activeItems=0;
   0D90 21 DD 86      [10]  107 	ld	hl,#_activeItems + 0
   0D93 36 00         [10]  108 	ld	(hl), #0x00
                            109 ;src/Item.c:32: item_spawnedKey=0;
   0D95 21 DE 86      [10]  110 	ld	hl,#_item_spawnedKey + 0
   0D98 36 00         [10]  111 	ld	(hl), #0x00
   0D9A C9            [10]  112 	ret
                            113 ;src/Item.c:41: u8 item_try_new_spawn(){
                            114 ;	---------------------------------
                            115 ; Function item_try_new_spawn
                            116 ; ---------------------------------
   0D9B                     117 _item_try_new_spawn::
   0D9B DD E5         [15]  118 	push	ix
   0D9D DD 21 00 00   [14]  119 	ld	ix,#0
   0DA1 DD 39         [15]  120 	add	ix,sp
   0DA3 F5            [11]  121 	push	af
                            122 ;src/Item.c:44: pos.x=cpct_getRandom_mxor_u8()%MAP_WIDTH;
   0DA4 21 00 00      [10]  123 	ld	hl,#0x0000
   0DA7 39            [11]  124 	add	hl,sp
   0DA8 E5            [11]  125 	push	hl
   0DA9 CD 0E 84      [17]  126 	call	_cpct_getRandom_mxor_u8
   0DAC 7D            [ 4]  127 	ld	a,l
   0DAD E1            [10]  128 	pop	hl
   0DAE E6 1F         [ 7]  129 	and	a, #0x1F
   0DB0 77            [ 7]  130 	ld	(hl),a
                            131 ;src/Item.c:45: pos.y=cpct_getRandom_mxor_u8()%MAP_HEIGHT;
   0DB1 21 00 00      [10]  132 	ld	hl,#0x0000
   0DB4 39            [11]  133 	add	hl,sp
   0DB5 4D            [ 4]  134 	ld	c,l
   0DB6 44            [ 4]  135 	ld	b,h
   0DB7 59            [ 4]  136 	ld	e, c
   0DB8 50            [ 4]  137 	ld	d, b
   0DB9 13            [ 6]  138 	inc	de
   0DBA C5            [11]  139 	push	bc
   0DBB D5            [11]  140 	push	de
   0DBC CD 0E 84      [17]  141 	call	_cpct_getRandom_mxor_u8
   0DBF D1            [10]  142 	pop	de
   0DC0 C1            [10]  143 	pop	bc
   0DC1 7D            [ 4]  144 	ld	a,l
   0DC2 E6 1F         [ 7]  145 	and	a, #0x1F
   0DC4 12            [ 7]  146 	ld	(de),a
                            147 ;src/Item.c:47: return (item_try_new_spawn_at(&pos));
   0DC5 C5            [11]  148 	push	bc
   0DC6 CD 83 0F      [17]  149 	call	_item_try_new_spawn_at
   0DC9 DD F9         [10]  150 	ld	sp,ix
   0DCB DD E1         [14]  151 	pop	ix
   0DCD C9            [10]  152 	ret
                            153 ;src/Item.c:50: void item_new_item(Vec2u* pos){
                            154 ;	---------------------------------
                            155 ; Function item_new_item
                            156 ; ---------------------------------
   0DCE                     157 _item_new_item::
   0DCE DD E5         [15]  158 	push	ix
   0DD0 DD 21 00 00   [14]  159 	ld	ix,#0
   0DD4 DD 39         [15]  160 	add	ix,sp
   0DD6 21 F3 FF      [10]  161 	ld	hl,#-13
   0DD9 39            [11]  162 	add	hl,sp
   0DDA F9            [ 6]  163 	ld	sp,hl
                            164 ;src/Item.c:52: Item* item=(itemArray+ITEM_MAX_ITEMS);
   0DDB DD 36 F8 02   [19]  165 	ld	-8 (ix),#<((_itemArray + 0x0023))
   0DDF DD 36 F9 87   [19]  166 	ld	-7 (ix),#>((_itemArray + 0x0023))
                            167 ;src/Item.c:56: x=pos->x;
   0DE3 DD 7E 04      [19]  168 	ld	a,4 (ix)
   0DE6 DD 77 FC      [19]  169 	ld	-4 (ix),a
   0DE9 DD 7E 05      [19]  170 	ld	a,5 (ix)
   0DEC DD 77 FD      [19]  171 	ld	-3 (ix),a
   0DEF DD 6E FC      [19]  172 	ld	l,-4 (ix)
   0DF2 DD 66 FD      [19]  173 	ld	h,-3 (ix)
   0DF5 7E            [ 7]  174 	ld	a,(hl)
   0DF6 DD 77 F5      [19]  175 	ld	-11 (ix),a
                            176 ;src/Item.c:57: y=pos->y;
   0DF9 DD 6E FC      [19]  177 	ld	l,-4 (ix)
   0DFC DD 66 FD      [19]  178 	ld	h,-3 (ix)
   0DFF 23            [ 6]  179 	inc	hl
   0E00 7E            [ 7]  180 	ld	a,(hl)
   0E01 DD 77 F4      [19]  181 	ld	-12 (ix),a
                            182 ;src/Item.c:59: while(i){
   0E04 DD 36 F3 07   [19]  183 	ld	-13 (ix),#0x07
   0E08                     184 00114$:
   0E08 DD 7E F3      [19]  185 	ld	a,-13 (ix)
   0E0B B7            [ 4]  186 	or	a, a
   0E0C CA 7E 0F      [10]  187 	jp	Z,00117$
                            188 ;src/Item.c:60: --i;
   0E0F DD 35 F3      [23]  189 	dec	-13 (ix)
   0E12 DD 7E F3      [19]  190 	ld	a,-13 (ix)
   0E15 DD 77 FC      [19]  191 	ld	-4 (ix),a
                            192 ;src/Item.c:61: --item;
   0E18 DD 7E F8      [19]  193 	ld	a,-8 (ix)
   0E1B C6 FB         [ 7]  194 	add	a,#0xFB
   0E1D DD 77 F8      [19]  195 	ld	-8 (ix),a
   0E20 DD 7E F9      [19]  196 	ld	a,-7 (ix)
   0E23 CE FF         [ 7]  197 	adc	a,#0xFF
   0E25 DD 77 F9      [19]  198 	ld	-7 (ix),a
   0E28 DD 7E F8      [19]  199 	ld	a,-8 (ix)
   0E2B DD 77 F6      [19]  200 	ld	-10 (ix),a
   0E2E DD 7E F9      [19]  201 	ld	a,-7 (ix)
   0E31 DD 77 F7      [19]  202 	ld	-9 (ix),a
                            203 ;src/Item.c:62: if(item->value==0){
   0E34 DD 7E F8      [19]  204 	ld	a,-8 (ix)
   0E37 C6 04         [ 7]  205 	add	a, #0x04
   0E39 DD 77 FA      [19]  206 	ld	-6 (ix),a
   0E3C DD 7E F9      [19]  207 	ld	a,-7 (ix)
   0E3F CE 00         [ 7]  208 	adc	a, #0x00
   0E41 DD 77 FB      [19]  209 	ld	-5 (ix),a
   0E44 DD 6E FA      [19]  210 	ld	l,-6 (ix)
   0E47 DD 66 FB      [19]  211 	ld	h,-5 (ix)
   0E4A 7E            [ 7]  212 	ld	a,(hl)
   0E4B B7            [ 4]  213 	or	a, a
   0E4C 20 BA         [12]  214 	jr	NZ,00114$
                            215 ;src/Item.c:63: item->id=i;
   0E4E DD 6E F8      [19]  216 	ld	l,-8 (ix)
   0E51 DD 66 F9      [19]  217 	ld	h,-7 (ix)
   0E54 DD 7E F3      [19]  218 	ld	a,-13 (ix)
   0E57 77            [ 7]  219 	ld	(hl),a
                            220 ;src/Item.c:66: item->type=0;
   0E58 DD 4E F6      [19]  221 	ld	c,-10 (ix)
   0E5B DD 46 F7      [19]  222 	ld	b,-9 (ix)
   0E5E 03            [ 6]  223 	inc	bc
   0E5F 03            [ 6]  224 	inc	bc
   0E60 03            [ 6]  225 	inc	bc
                            226 ;src/Item.c:65: if((!item_spawnedKey) && (((cpct_getRandom_mxor_u8()%16)==0)||level_get_level()==KING_LEVEL)){//1/16 is key
   0E61 3A DE 86      [13]  227 	ld	a,(#_item_spawnedKey + 0)
   0E64 B7            [ 4]  228 	or	a, a
   0E65 20 1D         [12]  229 	jr	NZ,00102$
   0E67 C5            [11]  230 	push	bc
   0E68 CD 0E 84      [17]  231 	call	_cpct_getRandom_mxor_u8
   0E6B C1            [10]  232 	pop	bc
   0E6C 7D            [ 4]  233 	ld	a,l
   0E6D E6 0F         [ 7]  234 	and	a, #0x0F
   0E6F 28 0A         [12]  235 	jr	Z,00101$
   0E71 C5            [11]  236 	push	bc
   0E72 CD 59 11      [17]  237 	call	_level_get_level
   0E75 C1            [10]  238 	pop	bc
   0E76 7D            [ 4]  239 	ld	a,l
   0E77 D6 20         [ 7]  240 	sub	a, #0x20
   0E79 20 09         [12]  241 	jr	NZ,00102$
   0E7B                     242 00101$:
                            243 ;src/Item.c:66: item->type=0;
   0E7B AF            [ 4]  244 	xor	a, a
   0E7C 02            [ 7]  245 	ld	(bc),a
                            246 ;src/Item.c:67: item_spawnedKey=1;
   0E7D 21 DE 86      [10]  247 	ld	hl,#_item_spawnedKey + 0
   0E80 36 01         [10]  248 	ld	(hl), #0x01
   0E82 18 0A         [12]  249 	jr	00103$
   0E84                     250 00102$:
                            251 ;src/Item.c:72: item->type = (cpct_getRandom_mxor_u8()&3)+1;
   0E84 C5            [11]  252 	push	bc
   0E85 CD 0E 84      [17]  253 	call	_cpct_getRandom_mxor_u8
   0E88 C1            [10]  254 	pop	bc
   0E89 7D            [ 4]  255 	ld	a,l
   0E8A E6 03         [ 7]  256 	and	a, #0x03
   0E8C 3C            [ 4]  257 	inc	a
   0E8D 02            [ 7]  258 	ld	(bc),a
   0E8E                     259 00103$:
                            260 ;src/Item.c:76: if(item->type == 1){
   0E8E 0A            [ 7]  261 	ld	a,(bc)
   0E8F DD 77 F8      [19]  262 	ld	-8 (ix), a
   0E92 3D            [ 4]  263 	dec	a
   0E93 20 27         [12]  264 	jr	NZ,00110$
                            265 ;src/Item.c:77: item->value = 48 +level_get_level() + (cpct_getRandom_mxor_u8()&7);
   0E95 CD 59 11      [17]  266 	call	_level_get_level
   0E98 DD 75 FF      [19]  267 	ld	-1 (ix), l
   0E9B 7D            [ 4]  268 	ld	a, l
   0E9C C6 30         [ 7]  269 	add	a, #0x30
   0E9E DD 77 FF      [19]  270 	ld	-1 (ix),a
   0EA1 CD 0E 84      [17]  271 	call	_cpct_getRandom_mxor_u8
   0EA4 DD 75 FE      [19]  272 	ld	-2 (ix), l
   0EA7 7D            [ 4]  273 	ld	a, l
   0EA8 E6 07         [ 7]  274 	and	a, #0x07
   0EAA DD 77 FE      [19]  275 	ld	-2 (ix),a
   0EAD DD 7E FF      [19]  276 	ld	a,-1 (ix)
   0EB0 DD 86 FE      [19]  277 	add	a, -2 (ix)
   0EB3 DD 6E FA      [19]  278 	ld	l,-6 (ix)
   0EB6 DD 66 FB      [19]  279 	ld	h,-5 (ix)
   0EB9 77            [ 7]  280 	ld	(hl),a
   0EBA 18 3C         [12]  281 	jr	00111$
   0EBC                     282 00110$:
                            283 ;src/Item.c:79: else if(item->type == 2){
   0EBC DD 7E F8      [19]  284 	ld	a,-8 (ix)
   0EBF D6 02         [ 7]  285 	sub	a, #0x02
   0EC1 20 2D         [12]  286 	jr	NZ,00107$
                            287 ;src/Item.c:80: item->value = 4 + level_get_level() + (cpct_getRandom_mxor_u8()&7);
   0EC3 CD 59 11      [17]  288 	call	_level_get_level
   0EC6 DD 75 FE      [19]  289 	ld	-2 (ix),l
   0EC9 DD 34 FE      [23]  290 	inc	-2 (ix)
   0ECC DD 34 FE      [23]  291 	inc	-2 (ix)
   0ECF DD 34 FE      [23]  292 	inc	-2 (ix)
   0ED2 DD 34 FE      [23]  293 	inc	-2 (ix)
   0ED5 CD 0E 84      [17]  294 	call	_cpct_getRandom_mxor_u8
   0ED8 DD 75 FF      [19]  295 	ld	-1 (ix), l
   0EDB 7D            [ 4]  296 	ld	a, l
   0EDC E6 07         [ 7]  297 	and	a, #0x07
   0EDE DD 77 FF      [19]  298 	ld	-1 (ix),a
   0EE1 DD 7E FE      [19]  299 	ld	a,-2 (ix)
   0EE4 DD 86 FF      [19]  300 	add	a, -1 (ix)
   0EE7 DD 6E FA      [19]  301 	ld	l,-6 (ix)
   0EEA DD 66 FB      [19]  302 	ld	h,-5 (ix)
   0EED 77            [ 7]  303 	ld	(hl),a
   0EEE 18 08         [12]  304 	jr	00111$
   0EF0                     305 00107$:
                            306 ;src/Item.c:83: item->value=1;
   0EF0 DD 6E FA      [19]  307 	ld	l,-6 (ix)
   0EF3 DD 66 FB      [19]  308 	ld	h,-5 (ix)
   0EF6 36 01         [10]  309 	ld	(hl),#0x01
   0EF8                     310 00111$:
                            311 ;src/Item.c:86: item->position.x = x;
   0EF8 DD 4E F6      [19]  312 	ld	c,-10 (ix)
   0EFB DD 46 F7      [19]  313 	ld	b,-9 (ix)
   0EFE 03            [ 6]  314 	inc	bc
   0EFF DD 7E F5      [19]  315 	ld	a,-11 (ix)
   0F02 02            [ 7]  316 	ld	(bc),a
                            317 ;src/Item.c:87: item->position.y = y;
   0F03 03            [ 6]  318 	inc	bc
   0F04 DD 7E F4      [19]  319 	ld	a,-12 (ix)
   0F07 02            [ 7]  320 	ld	(bc),a
                            321 ;src/Item.c:89: map[x+(y*MAP_WIDTH)] |=((i+1)<<4);
   0F08 DD 7E F5      [19]  322 	ld	a,-11 (ix)
   0F0B DD 77 FA      [19]  323 	ld	-6 (ix),a
   0F0E DD 36 FB 00   [19]  324 	ld	-5 (ix),#0x00
   0F12 DD 7E F4      [19]  325 	ld	a,-12 (ix)
   0F15 DD 77 F8      [19]  326 	ld	-8 (ix),a
   0F18 DD 36 F9 00   [19]  327 	ld	-7 (ix),#0x00
   0F1C 3E 06         [ 7]  328 	ld	a,#0x05+1
   0F1E 18 08         [12]  329 	jr	00155$
   0F20                     330 00154$:
   0F20 DD CB F8 26   [23]  331 	sla	-8 (ix)
   0F24 DD CB F9 16   [23]  332 	rl	-7 (ix)
   0F28                     333 00155$:
   0F28 3D            [ 4]  334 	dec	a
   0F29 20 F5         [12]  335 	jr	NZ,00154$
   0F2B DD 7E FA      [19]  336 	ld	a,-6 (ix)
   0F2E DD 86 F8      [19]  337 	add	a, -8 (ix)
   0F31 DD 77 FA      [19]  338 	ld	-6 (ix),a
   0F34 DD 7E FB      [19]  339 	ld	a,-5 (ix)
   0F37 DD 8E F9      [19]  340 	adc	a, -7 (ix)
   0F3A DD 77 FB      [19]  341 	ld	-5 (ix),a
   0F3D DD 7E FA      [19]  342 	ld	a,-6 (ix)
   0F40 C6 D0         [ 7]  343 	add	a, #0xD0
   0F42 DD 77 FA      [19]  344 	ld	-6 (ix),a
   0F45 DD 7E FB      [19]  345 	ld	a,-5 (ix)
   0F48 CE 88         [ 7]  346 	adc	a, #0x88
   0F4A DD 77 FB      [19]  347 	ld	-5 (ix),a
   0F4D DD 6E FA      [19]  348 	ld	l,-6 (ix)
   0F50 DD 66 FB      [19]  349 	ld	h,-5 (ix)
   0F53 7E            [ 7]  350 	ld	a,(hl)
   0F54 DD 77 FE      [19]  351 	ld	-2 (ix),a
   0F57 DD 7E FC      [19]  352 	ld	a,-4 (ix)
   0F5A 3C            [ 4]  353 	inc	a
   0F5B DD 77 FF      [19]  354 	ld	-1 (ix), a
   0F5E 07            [ 4]  355 	rlca
   0F5F 07            [ 4]  356 	rlca
   0F60 07            [ 4]  357 	rlca
   0F61 07            [ 4]  358 	rlca
   0F62 E6 F0         [ 7]  359 	and	a,#0xF0
   0F64 DD 77 FF      [19]  360 	ld	-1 (ix),a
   0F67 DD 7E FE      [19]  361 	ld	a,-2 (ix)
   0F6A DD B6 FF      [19]  362 	or	a, -1 (ix)
   0F6D DD 77 FE      [19]  363 	ld	-2 (ix),a
   0F70 DD 6E FA      [19]  364 	ld	l,-6 (ix)
   0F73 DD 66 FB      [19]  365 	ld	h,-5 (ix)
   0F76 DD 7E FE      [19]  366 	ld	a,-2 (ix)
   0F79 77            [ 7]  367 	ld	(hl),a
                            368 ;src/Item.c:91: ++activeItems;
   0F7A 21 DD 86      [10]  369 	ld	hl, #_activeItems+0
   0F7D 34            [11]  370 	inc	(hl)
                            371 ;src/Item.c:92: break;
   0F7E                     372 00117$:
   0F7E DD F9         [10]  373 	ld	sp, ix
   0F80 DD E1         [14]  374 	pop	ix
   0F82 C9            [10]  375 	ret
                            376 ;src/Item.c:97: u8 item_try_new_spawn_at(Vec2u* pos){
                            377 ;	---------------------------------
                            378 ; Function item_try_new_spawn_at
                            379 ; ---------------------------------
   0F83                     380 _item_try_new_spawn_at::
   0F83 DD E5         [15]  381 	push	ix
   0F85 DD 21 00 00   [14]  382 	ld	ix,#0
   0F89 DD 39         [15]  383 	add	ix,sp
   0F8B 3B            [ 6]  384 	dec	sp
                            385 ;src/Item.c:100: x=pos->x;
   0F8C DD 4E 04      [19]  386 	ld	c,4 (ix)
   0F8F DD 46 05      [19]  387 	ld	b,5 (ix)
   0F92 0A            [ 7]  388 	ld	a,(bc)
   0F93 5F            [ 4]  389 	ld	e,a
                            390 ;src/Item.c:101: y=pos->y;
   0F94 69            [ 4]  391 	ld	l, c
   0F95 60            [ 4]  392 	ld	h, b
   0F96 23            [ 6]  393 	inc	hl
   0F97 7E            [ 7]  394 	ld	a,(hl)
   0F98 DD 77 FF      [19]  395 	ld	-1 (ix),a
                            396 ;src/Item.c:103: if(activeItems<ITEM_MAX_ITEMS){
   0F9B 3A DD 86      [13]  397 	ld	a,(#_activeItems + 0)
   0F9E D6 07         [ 7]  398 	sub	a, #0x07
   0FA0 30 1F         [12]  399 	jr	NC,00104$
                            400 ;src/Item.c:104: if(((map[x+(y*MAP_WIDTH)])&(CELL_WALL_MASK|CELL_ITEM_MASK))==0){
   0FA2 16 00         [ 7]  401 	ld	d,#0x00
   0FA4 DD 6E FF      [19]  402 	ld	l,-1 (ix)
   0FA7 26 00         [ 7]  403 	ld	h,#0x00
   0FA9 29            [11]  404 	add	hl, hl
   0FAA 29            [11]  405 	add	hl, hl
   0FAB 29            [11]  406 	add	hl, hl
   0FAC 29            [11]  407 	add	hl, hl
   0FAD 29            [11]  408 	add	hl, hl
   0FAE 19            [11]  409 	add	hl,de
   0FAF 11 D0 88      [10]  410 	ld	de,#0x88D0
   0FB2 19            [11]  411 	add	hl,de
   0FB3 7E            [ 7]  412 	ld	a,(hl)
   0FB4 E6 F0         [ 7]  413 	and	a, #0xF0
   0FB6 20 09         [12]  414 	jr	NZ,00104$
                            415 ;src/Item.c:105: item_new_item(pos);
   0FB8 C5            [11]  416 	push	bc
   0FB9 CD CE 0D      [17]  417 	call	_item_new_item
   0FBC F1            [10]  418 	pop	af
                            419 ;src/Item.c:106: return 1;
   0FBD 2E 01         [ 7]  420 	ld	l,#0x01
   0FBF 18 02         [12]  421 	jr	00105$
   0FC1                     422 00104$:
                            423 ;src/Item.c:109: return 0;
   0FC1 2E 00         [ 7]  424 	ld	l,#0x00
   0FC3                     425 00105$:
   0FC3 33            [ 6]  426 	inc	sp
   0FC4 DD E1         [14]  427 	pop	ix
   0FC6 C9            [10]  428 	ret
                            429 ;src/Item.c:112: void item_pick_item(Item* i){
                            430 ;	---------------------------------
                            431 ; Function item_pick_item
                            432 ; ---------------------------------
   0FC7                     433 _item_pick_item::
   0FC7 DD E5         [15]  434 	push	ix
   0FC9 DD 21 00 00   [14]  435 	ld	ix,#0
   0FCD DD 39         [15]  436 	add	ix,sp
   0FCF F5            [11]  437 	push	af
   0FD0 F5            [11]  438 	push	af
                            439 ;src/Item.c:114: switch(i->type){
   0FD1 DD 4E 04      [19]  440 	ld	c,4 (ix)
   0FD4 DD 46 05      [19]  441 	ld	b,5 (ix)
   0FD7 69            [ 4]  442 	ld	l, c
   0FD8 60            [ 4]  443 	ld	h, b
   0FD9 23            [ 6]  444 	inc	hl
   0FDA 23            [ 6]  445 	inc	hl
   0FDB 23            [ 6]  446 	inc	hl
   0FDC 5E            [ 7]  447 	ld	e,(hl)
   0FDD 3E 04         [ 7]  448 	ld	a,#0x04
   0FDF 93            [ 4]  449 	sub	a, e
   0FE0 DA 66 10      [10]  450 	jp	C,00106$
                            451 ;src/Item.c:122: player_attack_value=(i->value>player_attack_value)?i->value:player_attack_value;
   0FE3 21 04 00      [10]  452 	ld	hl,#0x0004
   0FE6 09            [11]  453 	add	hl,bc
   0FE7 DD 75 FE      [19]  454 	ld	-2 (ix),l
   0FEA DD 74 FF      [19]  455 	ld	-1 (ix),h
                            456 ;src/Item.c:114: switch(i->type){
   0FED 16 00         [ 7]  457 	ld	d,#0x00
   0FEF 21 F5 0F      [10]  458 	ld	hl,#00125$
   0FF2 19            [11]  459 	add	hl,de
   0FF3 19            [11]  460 	add	hl,de
                            461 ;src/Item.c:115: case 0:{//key
   0FF4 E9            [ 4]  462 	jp	(hl)
   0FF5                     463 00125$:
   0FF5 18 08         [12]  464 	jr	00101$
   0FF7 18 15         [12]  465 	jr	00102$
   0FF9 18 32         [12]  466 	jr	00103$
   0FFB 18 4F         [12]  467 	jr	00104$
   0FFD 18 5B         [12]  468 	jr	00105$
   0FFF                     469 00101$:
                            470 ;src/Item.c:116: player_has_key=1;
   0FFF 21 09 87      [10]  471 	ld	hl,#_player_has_key + 0
   1002 36 01         [10]  472 	ld	(hl), #0x01
                            473 ;src/Item.c:117: ui_playerstats_render_key();
   1004 C5            [11]  474 	push	bc
   1005 CD AC 4E      [17]  475 	call	_ui_playerstats_render_key
   1008 C1            [10]  476 	pop	bc
                            477 ;src/Item.c:118: object = "KEY";
   1009 11 8B 10      [10]  478 	ld	de,#___str_0+0
                            479 ;src/Item.c:119: break;
   100C 18 58         [12]  480 	jr	00106$
                            481 ;src/Item.c:121: case 1:{
   100E                     482 00102$:
                            483 ;src/Item.c:122: player_attack_value=(i->value>player_attack_value)?i->value:player_attack_value;
   100E DD 6E FE      [19]  484 	ld	l,-2 (ix)
   1011 DD 66 FF      [19]  485 	ld	h,-1 (ix)
   1014 5E            [ 7]  486 	ld	e,(hl)
   1015 3A 06 87      [13]  487 	ld	a,(#_player_attack_value)
   1018 93            [ 4]  488 	sub	a, e
   1019 38 04         [12]  489 	jr	C,00110$
   101B 21 06 87      [10]  490 	ld	hl,#_player_attack_value + 0
   101E 5E            [ 7]  491 	ld	e, (hl)
   101F                     492 00110$:
   101F 21 06 87      [10]  493 	ld	hl,#_player_attack_value + 0
   1022 73            [ 7]  494 	ld	(hl), e
                            495 ;src/Item.c:123: ui_playerstats_render_attack();
   1023 C5            [11]  496 	push	bc
   1024 CD D4 4D      [17]  497 	call	_ui_playerstats_render_attack
   1027 C1            [10]  498 	pop	bc
                            499 ;src/Item.c:124: object="SWORD";
   1028 11 8F 10      [10]  500 	ld	de,#___str_1
                            501 ;src/Item.c:125: break;
   102B 18 39         [12]  502 	jr	00106$
                            503 ;src/Item.c:127: case 2:{
   102D                     504 00103$:
                            505 ;src/Item.c:128: player_defense_value = (i->value>player_defense_value)?i->value:player_defense_value;
   102D DD 6E FE      [19]  506 	ld	l,-2 (ix)
   1030 DD 66 FF      [19]  507 	ld	h,-1 (ix)
   1033 5E            [ 7]  508 	ld	e,(hl)
   1034 3A 05 87      [13]  509 	ld	a,(#_player_defense_value)
   1037 93            [ 4]  510 	sub	a, e
   1038 38 04         [12]  511 	jr	C,00112$
   103A 21 05 87      [10]  512 	ld	hl,#_player_defense_value + 0
   103D 5E            [ 7]  513 	ld	e, (hl)
   103E                     514 00112$:
   103E 21 05 87      [10]  515 	ld	hl,#_player_defense_value + 0
   1041 73            [ 7]  516 	ld	(hl), e
                            517 ;src/Item.c:129: ui_playerstats_render_defense();
   1042 C5            [11]  518 	push	bc
   1043 CD 0A 4E      [17]  519 	call	_ui_playerstats_render_defense
   1046 C1            [10]  520 	pop	bc
                            521 ;src/Item.c:130: object="ARMOR";
   1047 11 95 10      [10]  522 	ld	de,#___str_2
                            523 ;src/Item.c:131: break;
   104A 18 1A         [12]  524 	jr	00106$
                            525 ;src/Item.c:133: case 3:{
   104C                     526 00104$:
                            527 ;src/Item.c:134: ++player_potion_count;
   104C 21 0A 87      [10]  528 	ld	hl, #_player_potion_count+0
   104F 34            [11]  529 	inc	(hl)
                            530 ;src/Item.c:135: ui_playerstats_render_potions();
   1050 C5            [11]  531 	push	bc
   1051 CD 40 4E      [17]  532 	call	_ui_playerstats_render_potions
   1054 C1            [10]  533 	pop	bc
                            534 ;src/Item.c:136: object="POTION";
   1055 11 9B 10      [10]  535 	ld	de,#___str_3
                            536 ;src/Item.c:137: break;
   1058 18 0C         [12]  537 	jr	00106$
                            538 ;src/Item.c:139: case 4:{
   105A                     539 00105$:
                            540 ;src/Item.c:140: ++player_scroll_count;
   105A 21 0B 87      [10]  541 	ld	hl, #_player_scroll_count+0
   105D 34            [11]  542 	inc	(hl)
                            543 ;src/Item.c:141: ui_playerstats_render_scrolls();
   105E C5            [11]  544 	push	bc
   105F CD 76 4E      [17]  545 	call	_ui_playerstats_render_scrolls
   1062 C1            [10]  546 	pop	bc
                            547 ;src/Item.c:142: object="SCROLL";
   1063 11 A2 10      [10]  548 	ld	de,#___str_4
                            549 ;src/Item.c:145: }
   1066                     550 00106$:
                            551 ;src/Item.c:147: ui_log_add_log("PICKED",3);
   1066 C5            [11]  552 	push	bc
   1067 D5            [11]  553 	push	de
   1068 3E 03         [ 7]  554 	ld	a,#0x03
   106A F5            [11]  555 	push	af
   106B 33            [ 6]  556 	inc	sp
   106C 21 A9 10      [10]  557 	ld	hl,#___str_5
   106F E5            [11]  558 	push	hl
   1070 CD CF 48      [17]  559 	call	_ui_log_add_log
   1073 F1            [10]  560 	pop	af
   1074 33            [ 6]  561 	inc	sp
   1075 D1            [10]  562 	pop	de
   1076 3E 06         [ 7]  563 	ld	a,#0x06
   1078 F5            [11]  564 	push	af
   1079 33            [ 6]  565 	inc	sp
   107A D5            [11]  566 	push	de
   107B CD CF 48      [17]  567 	call	_ui_log_add_log
   107E F1            [10]  568 	pop	af
   107F 33            [ 6]  569 	inc	sp
   1080 CD 1A 49      [17]  570 	call	_ui_log_render
   1083 CD B0 10      [17]  571 	call	_item_destroy_item
   1086 DD F9         [10]  572 	ld	sp,ix
   1088 DD E1         [14]  573 	pop	ix
   108A C9            [10]  574 	ret
   108B                     575 ___str_0:
   108B 4B 45 59            576 	.ascii "KEY"
   108E 00                  577 	.db 0x00
   108F                     578 ___str_1:
   108F 53 57 4F 52 44      579 	.ascii "SWORD"
   1094 00                  580 	.db 0x00
   1095                     581 ___str_2:
   1095 41 52 4D 4F 52      582 	.ascii "ARMOR"
   109A 00                  583 	.db 0x00
   109B                     584 ___str_3:
   109B 50 4F 54 49 4F 4E   585 	.ascii "POTION"
   10A1 00                  586 	.db 0x00
   10A2                     587 ___str_4:
   10A2 53 43 52 4F 4C 4C   588 	.ascii "SCROLL"
   10A8 00                  589 	.db 0x00
   10A9                     590 ___str_5:
   10A9 50 49 43 4B 45 44   591 	.ascii "PICKED"
   10AF 00                  592 	.db 0x00
                            593 ;src/Item.c:154: void item_destroy_item(Item* i){
                            594 ;	---------------------------------
                            595 ; Function item_destroy_item
                            596 ; ---------------------------------
   10B0                     597 _item_destroy_item::
   10B0 DD E5         [15]  598 	push	ix
   10B2 DD 21 00 00   [14]  599 	ld	ix,#0
   10B6 DD 39         [15]  600 	add	ix,sp
                            601 ;src/Item.c:155: u8* mapPos = (u8*)(MAP_MEM + i->position.x + (i->position.y*MAP_WIDTH));
   10B8 DD 5E 04      [19]  602 	ld	e,4 (ix)
   10BB DD 56 05      [19]  603 	ld	d,5 (ix)
   10BE 6B            [ 4]  604 	ld	l, e
   10BF 62            [ 4]  605 	ld	h, d
   10C0 23            [ 6]  606 	inc	hl
   10C1 4E            [ 7]  607 	ld	c,(hl)
   10C2 06 00         [ 7]  608 	ld	b,#0x00
   10C4 21 D0 88      [10]  609 	ld	hl,#0x88D0
   10C7 09            [11]  610 	add	hl,bc
   10C8 4D            [ 4]  611 	ld	c,l
   10C9 44            [ 4]  612 	ld	b,h
   10CA 6B            [ 4]  613 	ld	l, e
   10CB 62            [ 4]  614 	ld	h, d
   10CC 23            [ 6]  615 	inc	hl
   10CD 23            [ 6]  616 	inc	hl
   10CE 6E            [ 7]  617 	ld	l,(hl)
   10CF 26 00         [ 7]  618 	ld	h,#0x00
   10D1 29            [11]  619 	add	hl, hl
   10D2 29            [11]  620 	add	hl, hl
   10D3 29            [11]  621 	add	hl, hl
   10D4 29            [11]  622 	add	hl, hl
   10D5 29            [11]  623 	add	hl, hl
   10D6 09            [11]  624 	add	hl,bc
   10D7 4D            [ 4]  625 	ld	c,l
   10D8 44            [ 4]  626 	ld	b,h
                            627 ;src/Item.c:157: --activeItems;
   10D9 21 DD 86      [10]  628 	ld	hl, #_activeItems+0
   10DC 35            [11]  629 	dec	(hl)
                            630 ;src/Item.c:159: i->value=0;
   10DD 13            [ 6]  631 	inc	de
   10DE 13            [ 6]  632 	inc	de
   10DF 13            [ 6]  633 	inc	de
   10E0 13            [ 6]  634 	inc	de
   10E1 AF            [ 4]  635 	xor	a, a
   10E2 12            [ 7]  636 	ld	(de),a
                            637 ;src/Item.c:161: *mapPos = *mapPos&(CELL_WALL_MASK|CELL_ENEMY_MASK);
   10E3 0A            [ 7]  638 	ld	a,(bc)
   10E4 E6 8F         [ 7]  639 	and	a, #0x8F
   10E6 02            [ 7]  640 	ld	(bc),a
   10E7 DD E1         [14]  641 	pop	ix
   10E9 C9            [10]  642 	ret
                            643 ;src/Item.c:165: u8 item_use_potion(){
                            644 ;	---------------------------------
                            645 ; Function item_use_potion
                            646 ; ---------------------------------
   10EA                     647 _item_use_potion::
                            648 ;src/Item.c:166: if(player_potion_count){
   10EA 3A 0A 87      [13]  649 	ld	a,(#_player_potion_count + 0)
   10ED B7            [ 4]  650 	or	a, a
   10EE 28 1F         [12]  651 	jr	Z,00105$
                            652 ;src/Item.c:167: --player_potion_count;
   10F0 21 0A 87      [10]  653 	ld	hl, #_player_potion_count+0
   10F3 35            [11]  654 	dec	(hl)
                            655 ;src/Item.c:168: if(player_health_points<(255-ITEM_POTION_HEAL)){
   10F4 3A 07 87      [13]  656 	ld	a,(#_player_health_points + 0)
   10F7 D6 80         [ 7]  657 	sub	a, #0x80
   10F9 30 09         [12]  658 	jr	NC,00102$
                            659 ;src/Item.c:169: player_health_points+=ITEM_POTION_HEAL;
   10FB 21 07 87      [10]  660 	ld	hl,#_player_health_points
   10FE 7E            [ 7]  661 	ld	a,(hl)
   10FF C6 7F         [ 7]  662 	add	a, #0x7F
   1101 77            [ 7]  663 	ld	(hl),a
   1102 18 05         [12]  664 	jr	00103$
   1104                     665 00102$:
                            666 ;src/Item.c:172: player_health_points=255;
   1104 21 07 87      [10]  667 	ld	hl,#_player_health_points + 0
   1107 36 FF         [10]  668 	ld	(hl), #0xFF
   1109                     669 00103$:
                            670 ;src/Item.c:174: ui_playerstats_render_hp();
   1109 CD 73 4D      [17]  671 	call	_ui_playerstats_render_hp
                            672 ;src/Item.c:175: return 1;
   110C 2E 01         [ 7]  673 	ld	l,#0x01
   110E C9            [10]  674 	ret
   110F                     675 00105$:
                            676 ;src/Item.c:177: return 0;
   110F 2E 00         [ 7]  677 	ld	l,#0x00
   1111 C9            [10]  678 	ret
                            679 ;src/Item.c:180: u8 item_use_scroll(){
                            680 ;	---------------------------------
                            681 ; Function item_use_scroll
                            682 ; ---------------------------------
   1112                     683 _item_use_scroll::
                            684 ;src/Item.c:181: u16 pos = (cpct_getRandom_mxor_u16()%1024);
   1112 CD 57 84      [17]  685 	call	_cpct_getRandom_mxor_u16
   1115 4D            [ 4]  686 	ld	c,l
   1116 7C            [ 4]  687 	ld	a,h
   1117 E6 03         [ 7]  688 	and	a, #0x03
   1119 47            [ 4]  689 	ld	b,a
                            690 ;src/Item.c:182: if(player_scroll_count){
   111A 3A 0B 87      [13]  691 	ld	a,(#_player_scroll_count + 0)
   111D B7            [ 4]  692 	or	a, a
   111E 28 36         [12]  693 	jr	Z,00105$
                            694 ;src/Item.c:183: while(*(u8*)(MAP_MEM+pos)!=CELLTYPE_FLOOR){
   1120                     695 00101$:
   1120 21 D0 88      [10]  696 	ld	hl,#0x88D0
   1123 09            [11]  697 	add	hl,bc
   1124 7E            [ 7]  698 	ld	a,(hl)
   1125 B7            [ 4]  699 	or	a, a
   1126 28 07         [12]  700 	jr	Z,00103$
                            701 ;src/Item.c:184: pos = (pos+1)%1024;
   1128 03            [ 6]  702 	inc	bc
   1129 78            [ 4]  703 	ld	a,b
   112A E6 03         [ 7]  704 	and	a, #0x03
   112C 47            [ 4]  705 	ld	b,a
   112D 18 F1         [12]  706 	jr	00101$
   112F                     707 00103$:
                            708 ;src/Item.c:186: --player_scroll_count;
   112F 21 0B 87      [10]  709 	ld	hl, #_player_scroll_count+0
   1132 35            [11]  710 	dec	(hl)
                            711 ;src/Item.c:187: *(u8*)&(player_position.x) = (pos%MAP_WIDTH);
   1133 79            [ 4]  712 	ld	a,c
   1134 E6 1F         [ 7]  713 	and	a, #0x1F
   1136 5F            [ 4]  714 	ld	e,a
   1137 21 EE 19      [10]  715 	ld	hl,#_player_position
   113A 73            [ 7]  716 	ld	(hl),e
                            717 ;src/Item.c:188: *(u8*)&(player_position.y) = (pos/MAP_HEIGHT);
   113B CB 38         [ 8]  718 	srl	b
   113D CB 19         [ 8]  719 	rr	c
   113F CB 38         [ 8]  720 	srl	b
   1141 CB 19         [ 8]  721 	rr	c
   1143 CB 38         [ 8]  722 	srl	b
   1145 CB 19         [ 8]  723 	rr	c
   1147 CB 38         [ 8]  724 	srl	b
   1149 CB 19         [ 8]  725 	rr	c
   114B CB 38         [ 8]  726 	srl	b
   114D CB 19         [ 8]  727 	rr	c
   114F 21 EF 19      [10]  728 	ld	hl,#(_player_position + 0x0001)
   1152 71            [ 7]  729 	ld	(hl),c
                            730 ;src/Item.c:189: return 1;
   1153 2E 01         [ 7]  731 	ld	l,#0x01
   1155 C9            [10]  732 	ret
   1156                     733 00105$:
                            734 ;src/Item.c:191: return 0;
   1156 2E 00         [ 7]  735 	ld	l,#0x00
   1158 C9            [10]  736 	ret
                            737 	.area _CODE
                            738 	.area _INITIALIZER
                            739 	.area _CABS (ABS)
