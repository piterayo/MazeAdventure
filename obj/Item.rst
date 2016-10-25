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
   7D3D                      42 _activeItems::
   7D3D                      43 	.ds 1
   7D3E                      44 _item_spawnedKey::
   7D3E                      45 	.ds 1
   7D3F                      46 _itemArray::
   7D3F                      47 	.ds 35
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
                             72 ;src/Item.c:23: Item* item_get_at(u8 index){
                             73 ;	---------------------------------
                             74 ; Function item_get_at
                             75 ; ---------------------------------
   0C00                      76 _item_get_at::
   0C00 DD E5         [15]   77 	push	ix
   0C02 DD 21 00 00   [14]   78 	ld	ix,#0
   0C06 DD 39         [15]   79 	add	ix,sp
                             80 ;src/Item.c:24: return (itemArray+index);
   0C08 01 3F 7D      [10]   81 	ld	bc,#_itemArray+0
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
                             92 ;src/Item.c:27: void item_init_items(){
                             93 ;	---------------------------------
                             94 ; Function item_init_items
                             95 ; ---------------------------------
   0C19                      96 _item_init_items::
                             97 ;src/Item.c:28: cpct_memset(itemArray, 0, ITEM_MAX_ITEMS*sizeof(Item));
   0C19 21 23 00      [10]   98 	ld	hl,#0x0023
   0C1C E5            [11]   99 	push	hl
   0C1D AF            [ 4]  100 	xor	a, a
   0C1E F5            [11]  101 	push	af
   0C1F 33            [ 6]  102 	inc	sp
   0C20 21 3F 7D      [10]  103 	ld	hl,#_itemArray
   0C23 E5            [11]  104 	push	hl
   0C24 CD 74 7B      [17]  105 	call	_cpct_memset
                            106 ;src/Item.c:29: activeItems=0;
   0C27 21 3D 7D      [10]  107 	ld	hl,#_activeItems + 0
   0C2A 36 00         [10]  108 	ld	(hl), #0x00
                            109 ;src/Item.c:30: item_spawnedKey=0;
   0C2C 21 3E 7D      [10]  110 	ld	hl,#_item_spawnedKey + 0
   0C2F 36 00         [10]  111 	ld	(hl), #0x00
   0C31 C9            [10]  112 	ret
                            113 ;src/Item.c:39: u8 item_try_new_spawn(){
                            114 ;	---------------------------------
                            115 ; Function item_try_new_spawn
                            116 ; ---------------------------------
   0C32                     117 _item_try_new_spawn::
   0C32 DD E5         [15]  118 	push	ix
   0C34 DD 21 00 00   [14]  119 	ld	ix,#0
   0C38 DD 39         [15]  120 	add	ix,sp
   0C3A F5            [11]  121 	push	af
                            122 ;src/Item.c:42: pos.x=cpct_getRandom_mxor_u8()%MAP_WIDTH;
   0C3B 21 00 00      [10]  123 	ld	hl,#0x0000
   0C3E 39            [11]  124 	add	hl,sp
   0C3F E5            [11]  125 	push	hl
   0C40 CD 71 7A      [17]  126 	call	_cpct_getRandom_mxor_u8
   0C43 7D            [ 4]  127 	ld	a,l
   0C44 E1            [10]  128 	pop	hl
   0C45 E6 1F         [ 7]  129 	and	a, #0x1F
   0C47 77            [ 7]  130 	ld	(hl),a
                            131 ;src/Item.c:43: pos.y=cpct_getRandom_mxor_u8()%MAP_HEIGHT;
   0C48 21 00 00      [10]  132 	ld	hl,#0x0000
   0C4B 39            [11]  133 	add	hl,sp
   0C4C 4D            [ 4]  134 	ld	c,l
   0C4D 44            [ 4]  135 	ld	b,h
   0C4E 59            [ 4]  136 	ld	e, c
   0C4F 50            [ 4]  137 	ld	d, b
   0C50 13            [ 6]  138 	inc	de
   0C51 C5            [11]  139 	push	bc
   0C52 D5            [11]  140 	push	de
   0C53 CD 71 7A      [17]  141 	call	_cpct_getRandom_mxor_u8
   0C56 D1            [10]  142 	pop	de
   0C57 C1            [10]  143 	pop	bc
   0C58 7D            [ 4]  144 	ld	a,l
   0C59 E6 1F         [ 7]  145 	and	a, #0x1F
   0C5B 12            [ 7]  146 	ld	(de),a
                            147 ;src/Item.c:45: return (item_try_new_spawn_at(&pos));
   0C5C C5            [11]  148 	push	bc
   0C5D CD 12 0E      [17]  149 	call	_item_try_new_spawn_at
   0C60 DD F9         [10]  150 	ld	sp,ix
   0C62 DD E1         [14]  151 	pop	ix
   0C64 C9            [10]  152 	ret
                            153 ;src/Item.c:48: void item_new_item(Vec2u* pos){
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
                            164 ;src/Item.c:50: Item* item=(itemArray+ITEM_MAX_ITEMS);
   0C72 DD 36 FA 62   [19]  165 	ld	-6 (ix),#<((_itemArray + 0x0023))
   0C76 DD 36 FB 7D   [19]  166 	ld	-5 (ix),#>((_itemArray + 0x0023))
                            167 ;src/Item.c:54: x=pos->x;
   0C7A DD 7E 04      [19]  168 	ld	a,4 (ix)
   0C7D DD 77 F8      [19]  169 	ld	-8 (ix),a
   0C80 DD 7E 05      [19]  170 	ld	a,5 (ix)
   0C83 DD 77 F9      [19]  171 	ld	-7 (ix),a
   0C86 DD 6E F8      [19]  172 	ld	l,-8 (ix)
   0C89 DD 66 F9      [19]  173 	ld	h,-7 (ix)
   0C8C 7E            [ 7]  174 	ld	a,(hl)
   0C8D DD 77 F5      [19]  175 	ld	-11 (ix),a
                            176 ;src/Item.c:55: y=pos->y;
   0C90 DD 6E F8      [19]  177 	ld	l,-8 (ix)
   0C93 DD 66 F9      [19]  178 	ld	h,-7 (ix)
   0C96 23            [ 6]  179 	inc	hl
   0C97 7E            [ 7]  180 	ld	a,(hl)
   0C98 DD 77 F6      [19]  181 	ld	-10 (ix),a
                            182 ;src/Item.c:57: while(i){
   0C9B DD 36 F7 07   [19]  183 	ld	-9 (ix),#0x07
   0C9F                     184 00114$:
   0C9F DD 7E F7      [19]  185 	ld	a,-9 (ix)
   0CA2 B7            [ 4]  186 	or	a, a
   0CA3 CA 0D 0E      [10]  187 	jp	Z,00117$
                            188 ;src/Item.c:58: --i;
   0CA6 DD 35 F7      [23]  189 	dec	-9 (ix)
   0CA9 DD 7E F7      [19]  190 	ld	a,-9 (ix)
   0CAC DD 77 F8      [19]  191 	ld	-8 (ix),a
                            192 ;src/Item.c:59: --item;
   0CAF DD 7E FA      [19]  193 	ld	a,-6 (ix)
   0CB2 C6 FB         [ 7]  194 	add	a,#0xFB
   0CB4 DD 77 FA      [19]  195 	ld	-6 (ix),a
   0CB7 DD 7E FB      [19]  196 	ld	a,-5 (ix)
   0CBA CE FF         [ 7]  197 	adc	a,#0xFF
   0CBC DD 77 FB      [19]  198 	ld	-5 (ix),a
   0CBF DD 7E FA      [19]  199 	ld	a,-6 (ix)
   0CC2 DD 77 F3      [19]  200 	ld	-13 (ix),a
   0CC5 DD 7E FB      [19]  201 	ld	a,-5 (ix)
   0CC8 DD 77 F4      [19]  202 	ld	-12 (ix),a
                            203 ;src/Item.c:60: if(item->value==0){
   0CCB DD 7E FA      [19]  204 	ld	a,-6 (ix)
   0CCE C6 04         [ 7]  205 	add	a, #0x04
   0CD0 DD 77 FE      [19]  206 	ld	-2 (ix),a
   0CD3 DD 7E FB      [19]  207 	ld	a,-5 (ix)
   0CD6 CE 00         [ 7]  208 	adc	a, #0x00
   0CD8 DD 77 FF      [19]  209 	ld	-1 (ix),a
   0CDB DD 6E FE      [19]  210 	ld	l,-2 (ix)
   0CDE DD 66 FF      [19]  211 	ld	h,-1 (ix)
   0CE1 7E            [ 7]  212 	ld	a,(hl)
   0CE2 B7            [ 4]  213 	or	a, a
   0CE3 20 BA         [12]  214 	jr	NZ,00114$
                            215 ;src/Item.c:61: item->id=i;
   0CE5 DD 6E FA      [19]  216 	ld	l,-6 (ix)
   0CE8 DD 66 FB      [19]  217 	ld	h,-5 (ix)
   0CEB DD 7E F7      [19]  218 	ld	a,-9 (ix)
   0CEE 77            [ 7]  219 	ld	(hl),a
                            220 ;src/Item.c:64: item->type=0;
   0CEF C1            [10]  221 	pop	bc
   0CF0 C5            [11]  222 	push	bc
   0CF1 03            [ 6]  223 	inc	bc
   0CF2 03            [ 6]  224 	inc	bc
   0CF3 03            [ 6]  225 	inc	bc
                            226 ;src/Item.c:63: if((!item_spawnedKey) && (((cpct_getRandom_mxor_u8()%16)==0)||level_get_level()==KING_LEVEL)){//1/16 is key
   0CF4 3A 3E 7D      [13]  227 	ld	a,(#_item_spawnedKey + 0)
   0CF7 B7            [ 4]  228 	or	a, a
   0CF8 20 1D         [12]  229 	jr	NZ,00102$
   0CFA C5            [11]  230 	push	bc
   0CFB CD 71 7A      [17]  231 	call	_cpct_getRandom_mxor_u8
   0CFE C1            [10]  232 	pop	bc
   0CFF 7D            [ 4]  233 	ld	a,l
   0D00 E6 0F         [ 7]  234 	and	a, #0x0F
   0D02 28 0A         [12]  235 	jr	Z,00101$
   0D04 C5            [11]  236 	push	bc
   0D05 CD A7 0F      [17]  237 	call	_level_get_level
   0D08 C1            [10]  238 	pop	bc
   0D09 7D            [ 4]  239 	ld	a,l
   0D0A D6 20         [ 7]  240 	sub	a, #0x20
   0D0C 20 09         [12]  241 	jr	NZ,00102$
   0D0E                     242 00101$:
                            243 ;src/Item.c:64: item->type=0;
   0D0E AF            [ 4]  244 	xor	a, a
   0D0F 02            [ 7]  245 	ld	(bc),a
                            246 ;src/Item.c:65: item_spawnedKey=1;
   0D10 21 3E 7D      [10]  247 	ld	hl,#_item_spawnedKey + 0
   0D13 36 01         [10]  248 	ld	(hl), #0x01
   0D15 18 0A         [12]  249 	jr	00103$
   0D17                     250 00102$:
                            251 ;src/Item.c:70: item->type = (cpct_getRandom_mxor_u8()&3)+1;
   0D17 C5            [11]  252 	push	bc
   0D18 CD 71 7A      [17]  253 	call	_cpct_getRandom_mxor_u8
   0D1B C1            [10]  254 	pop	bc
   0D1C 7D            [ 4]  255 	ld	a,l
   0D1D E6 03         [ 7]  256 	and	a, #0x03
   0D1F 3C            [ 4]  257 	inc	a
   0D20 02            [ 7]  258 	ld	(bc),a
   0D21                     259 00103$:
                            260 ;src/Item.c:74: if(item->type == 1){
   0D21 0A            [ 7]  261 	ld	a,(bc)
   0D22 DD 77 FA      [19]  262 	ld	-6 (ix), a
   0D25 3D            [ 4]  263 	dec	a
   0D26 20 27         [12]  264 	jr	NZ,00110$
                            265 ;src/Item.c:75: item->value = 48 +level_get_level() + (cpct_getRandom_mxor_u8()&7);
   0D28 CD A7 0F      [17]  266 	call	_level_get_level
   0D2B DD 75 FD      [19]  267 	ld	-3 (ix), l
   0D2E 7D            [ 4]  268 	ld	a, l
   0D2F C6 30         [ 7]  269 	add	a, #0x30
   0D31 DD 77 FD      [19]  270 	ld	-3 (ix),a
   0D34 CD 71 7A      [17]  271 	call	_cpct_getRandom_mxor_u8
   0D37 DD 75 FC      [19]  272 	ld	-4 (ix), l
   0D3A 7D            [ 4]  273 	ld	a, l
   0D3B E6 07         [ 7]  274 	and	a, #0x07
   0D3D DD 77 FC      [19]  275 	ld	-4 (ix),a
   0D40 DD 7E FD      [19]  276 	ld	a,-3 (ix)
   0D43 DD 86 FC      [19]  277 	add	a, -4 (ix)
   0D46 DD 6E FE      [19]  278 	ld	l,-2 (ix)
   0D49 DD 66 FF      [19]  279 	ld	h,-1 (ix)
   0D4C 77            [ 7]  280 	ld	(hl),a
   0D4D 18 3C         [12]  281 	jr	00111$
   0D4F                     282 00110$:
                            283 ;src/Item.c:77: else if(item->type == 2){
   0D4F DD 7E FA      [19]  284 	ld	a,-6 (ix)
   0D52 D6 02         [ 7]  285 	sub	a, #0x02
   0D54 20 2D         [12]  286 	jr	NZ,00107$
                            287 ;src/Item.c:78: item->value = 4 + level_get_level() + (cpct_getRandom_mxor_u8()&7);
   0D56 CD A7 0F      [17]  288 	call	_level_get_level
   0D59 DD 75 FC      [19]  289 	ld	-4 (ix),l
   0D5C DD 34 FC      [23]  290 	inc	-4 (ix)
   0D5F DD 34 FC      [23]  291 	inc	-4 (ix)
   0D62 DD 34 FC      [23]  292 	inc	-4 (ix)
   0D65 DD 34 FC      [23]  293 	inc	-4 (ix)
   0D68 CD 71 7A      [17]  294 	call	_cpct_getRandom_mxor_u8
   0D6B DD 75 FD      [19]  295 	ld	-3 (ix), l
   0D6E 7D            [ 4]  296 	ld	a, l
   0D6F E6 07         [ 7]  297 	and	a, #0x07
   0D71 DD 77 FD      [19]  298 	ld	-3 (ix),a
   0D74 DD 7E FC      [19]  299 	ld	a,-4 (ix)
   0D77 DD 86 FD      [19]  300 	add	a, -3 (ix)
   0D7A DD 6E FE      [19]  301 	ld	l,-2 (ix)
   0D7D DD 66 FF      [19]  302 	ld	h,-1 (ix)
   0D80 77            [ 7]  303 	ld	(hl),a
   0D81 18 08         [12]  304 	jr	00111$
   0D83                     305 00107$:
                            306 ;src/Item.c:81: item->value=1;
   0D83 DD 6E FE      [19]  307 	ld	l,-2 (ix)
   0D86 DD 66 FF      [19]  308 	ld	h,-1 (ix)
   0D89 36 01         [10]  309 	ld	(hl),#0x01
   0D8B                     310 00111$:
                            311 ;src/Item.c:84: item->position.x = x;
   0D8B C1            [10]  312 	pop	bc
   0D8C C5            [11]  313 	push	bc
   0D8D 03            [ 6]  314 	inc	bc
   0D8E DD 7E F5      [19]  315 	ld	a,-11 (ix)
   0D91 02            [ 7]  316 	ld	(bc),a
                            317 ;src/Item.c:85: item->position.y = y;
   0D92 03            [ 6]  318 	inc	bc
   0D93 DD 7E F6      [19]  319 	ld	a,-10 (ix)
   0D96 02            [ 7]  320 	ld	(bc),a
                            321 ;src/Item.c:87: map[x+(y*MAP_WIDTH)] |=((i+1)<<4);
   0D97 DD 7E F5      [19]  322 	ld	a,-11 (ix)
   0D9A DD 77 FE      [19]  323 	ld	-2 (ix),a
   0D9D DD 36 FF 00   [19]  324 	ld	-1 (ix),#0x00
   0DA1 DD 7E F6      [19]  325 	ld	a,-10 (ix)
   0DA4 DD 77 FA      [19]  326 	ld	-6 (ix),a
   0DA7 DD 36 FB 00   [19]  327 	ld	-5 (ix),#0x00
   0DAB 3E 06         [ 7]  328 	ld	a,#0x05+1
   0DAD 18 08         [12]  329 	jr	00155$
   0DAF                     330 00154$:
   0DAF DD CB FA 26   [23]  331 	sla	-6 (ix)
   0DB3 DD CB FB 16   [23]  332 	rl	-5 (ix)
   0DB7                     333 00155$:
   0DB7 3D            [ 4]  334 	dec	a
   0DB8 20 F5         [12]  335 	jr	NZ,00154$
   0DBA DD 7E FE      [19]  336 	ld	a,-2 (ix)
   0DBD DD 86 FA      [19]  337 	add	a, -6 (ix)
   0DC0 DD 77 FE      [19]  338 	ld	-2 (ix),a
   0DC3 DD 7E FF      [19]  339 	ld	a,-1 (ix)
   0DC6 DD 8E FB      [19]  340 	adc	a, -5 (ix)
   0DC9 DD 77 FF      [19]  341 	ld	-1 (ix),a
   0DCC DD 7E FE      [19]  342 	ld	a,-2 (ix)
   0DCF C6 D0         [ 7]  343 	add	a, #0xD0
   0DD1 DD 77 FE      [19]  344 	ld	-2 (ix),a
   0DD4 DD 7E FF      [19]  345 	ld	a,-1 (ix)
   0DD7 CE 88         [ 7]  346 	adc	a, #0x88
   0DD9 DD 77 FF      [19]  347 	ld	-1 (ix),a
   0DDC DD 6E FE      [19]  348 	ld	l,-2 (ix)
   0DDF DD 66 FF      [19]  349 	ld	h,-1 (ix)
   0DE2 7E            [ 7]  350 	ld	a,(hl)
   0DE3 DD 77 FC      [19]  351 	ld	-4 (ix),a
   0DE6 DD 7E F8      [19]  352 	ld	a,-8 (ix)
   0DE9 3C            [ 4]  353 	inc	a
   0DEA DD 77 FD      [19]  354 	ld	-3 (ix), a
   0DED 07            [ 4]  355 	rlca
   0DEE 07            [ 4]  356 	rlca
   0DEF 07            [ 4]  357 	rlca
   0DF0 07            [ 4]  358 	rlca
   0DF1 E6 F0         [ 7]  359 	and	a,#0xF0
   0DF3 DD 77 FD      [19]  360 	ld	-3 (ix),a
   0DF6 DD 7E FC      [19]  361 	ld	a,-4 (ix)
   0DF9 DD B6 FD      [19]  362 	or	a, -3 (ix)
   0DFC DD 77 FC      [19]  363 	ld	-4 (ix),a
   0DFF DD 6E FE      [19]  364 	ld	l,-2 (ix)
   0E02 DD 66 FF      [19]  365 	ld	h,-1 (ix)
   0E05 DD 7E FC      [19]  366 	ld	a,-4 (ix)
   0E08 77            [ 7]  367 	ld	(hl),a
                            368 ;src/Item.c:89: ++activeItems;
   0E09 21 3D 7D      [10]  369 	ld	hl, #_activeItems+0
   0E0C 34            [11]  370 	inc	(hl)
                            371 ;src/Item.c:90: break;
   0E0D                     372 00117$:
   0E0D DD F9         [10]  373 	ld	sp, ix
   0E0F DD E1         [14]  374 	pop	ix
   0E11 C9            [10]  375 	ret
                            376 ;src/Item.c:95: u8 item_try_new_spawn_at(Vec2u* pos){
                            377 ;	---------------------------------
                            378 ; Function item_try_new_spawn_at
                            379 ; ---------------------------------
   0E12                     380 _item_try_new_spawn_at::
                            381 ;src/Item.c:107: return 0;
   0E12 2E 00         [ 7]  382 	ld	l,#0x00
   0E14 C9            [10]  383 	ret
                            384 ;src/Item.c:110: void item_pick_item(Item* i){
                            385 ;	---------------------------------
                            386 ; Function item_pick_item
                            387 ; ---------------------------------
   0E15                     388 _item_pick_item::
   0E15 DD E5         [15]  389 	push	ix
   0E17 DD 21 00 00   [14]  390 	ld	ix,#0
   0E1B DD 39         [15]  391 	add	ix,sp
   0E1D F5            [11]  392 	push	af
   0E1E F5            [11]  393 	push	af
                            394 ;src/Item.c:112: switch(i->type){
   0E1F DD 4E 04      [19]  395 	ld	c,4 (ix)
   0E22 DD 46 05      [19]  396 	ld	b,5 (ix)
   0E25 69            [ 4]  397 	ld	l, c
   0E26 60            [ 4]  398 	ld	h, b
   0E27 23            [ 6]  399 	inc	hl
   0E28 23            [ 6]  400 	inc	hl
   0E29 23            [ 6]  401 	inc	hl
   0E2A 5E            [ 7]  402 	ld	e,(hl)
   0E2B 3E 04         [ 7]  403 	ld	a,#0x04
   0E2D 93            [ 4]  404 	sub	a, e
   0E2E DA B4 0E      [10]  405 	jp	C,00106$
                            406 ;src/Item.c:120: player_attack_value=(i->value>player_attack_value)?i->value:player_attack_value;
   0E31 21 04 00      [10]  407 	ld	hl,#0x0004
   0E34 09            [11]  408 	add	hl,bc
   0E35 DD 75 FE      [19]  409 	ld	-2 (ix),l
   0E38 DD 74 FF      [19]  410 	ld	-1 (ix),h
                            411 ;src/Item.c:112: switch(i->type){
   0E3B 16 00         [ 7]  412 	ld	d,#0x00
   0E3D 21 43 0E      [10]  413 	ld	hl,#00125$
   0E40 19            [11]  414 	add	hl,de
   0E41 19            [11]  415 	add	hl,de
                            416 ;src/Item.c:113: case 0:{//key
   0E42 E9            [ 4]  417 	jp	(hl)
   0E43                     418 00125$:
   0E43 18 08         [12]  419 	jr	00101$
   0E45 18 15         [12]  420 	jr	00102$
   0E47 18 32         [12]  421 	jr	00103$
   0E49 18 4F         [12]  422 	jr	00104$
   0E4B 18 5B         [12]  423 	jr	00105$
   0E4D                     424 00101$:
                            425 ;src/Item.c:114: player_has_key=1;
   0E4D 21 69 7D      [10]  426 	ld	hl,#_player_has_key + 0
   0E50 36 01         [10]  427 	ld	(hl), #0x01
                            428 ;src/Item.c:115: ui_playerstats_render_key();
   0E52 C5            [11]  429 	push	bc
   0E53 CD 38 4D      [17]  430 	call	_ui_playerstats_render_key
   0E56 C1            [10]  431 	pop	bc
                            432 ;src/Item.c:116: object = "KEY";
   0E57 11 D9 0E      [10]  433 	ld	de,#___str_0+0
                            434 ;src/Item.c:117: break;
   0E5A 18 58         [12]  435 	jr	00106$
                            436 ;src/Item.c:119: case 1:{
   0E5C                     437 00102$:
                            438 ;src/Item.c:120: player_attack_value=(i->value>player_attack_value)?i->value:player_attack_value;
   0E5C DD 6E FE      [19]  439 	ld	l,-2 (ix)
   0E5F DD 66 FF      [19]  440 	ld	h,-1 (ix)
   0E62 5E            [ 7]  441 	ld	e,(hl)
   0E63 3A 66 7D      [13]  442 	ld	a,(#_player_attack_value)
   0E66 93            [ 4]  443 	sub	a, e
   0E67 38 04         [12]  444 	jr	C,00110$
   0E69 21 66 7D      [10]  445 	ld	hl,#_player_attack_value + 0
   0E6C 5E            [ 7]  446 	ld	e, (hl)
   0E6D                     447 00110$:
   0E6D 21 66 7D      [10]  448 	ld	hl,#_player_attack_value + 0
   0E70 73            [ 7]  449 	ld	(hl), e
                            450 ;src/Item.c:121: ui_playerstats_render_attack();
   0E71 C5            [11]  451 	push	bc
   0E72 CD 60 4C      [17]  452 	call	_ui_playerstats_render_attack
   0E75 C1            [10]  453 	pop	bc
                            454 ;src/Item.c:122: object="SWORD";
   0E76 11 DD 0E      [10]  455 	ld	de,#___str_1
                            456 ;src/Item.c:123: break;
   0E79 18 39         [12]  457 	jr	00106$
                            458 ;src/Item.c:125: case 2:{
   0E7B                     459 00103$:
                            460 ;src/Item.c:126: player_defense_value = (i->value>player_defense_value)?i->value:player_defense_value;
   0E7B DD 6E FE      [19]  461 	ld	l,-2 (ix)
   0E7E DD 66 FF      [19]  462 	ld	h,-1 (ix)
   0E81 5E            [ 7]  463 	ld	e,(hl)
   0E82 3A 65 7D      [13]  464 	ld	a,(#_player_defense_value)
   0E85 93            [ 4]  465 	sub	a, e
   0E86 38 04         [12]  466 	jr	C,00112$
   0E88 21 65 7D      [10]  467 	ld	hl,#_player_defense_value + 0
   0E8B 5E            [ 7]  468 	ld	e, (hl)
   0E8C                     469 00112$:
   0E8C 21 65 7D      [10]  470 	ld	hl,#_player_defense_value + 0
   0E8F 73            [ 7]  471 	ld	(hl), e
                            472 ;src/Item.c:127: ui_playerstats_render_defense();
   0E90 C5            [11]  473 	push	bc
   0E91 CD 96 4C      [17]  474 	call	_ui_playerstats_render_defense
   0E94 C1            [10]  475 	pop	bc
                            476 ;src/Item.c:128: object="ARMOR";
   0E95 11 E3 0E      [10]  477 	ld	de,#___str_2
                            478 ;src/Item.c:129: break;
   0E98 18 1A         [12]  479 	jr	00106$
                            480 ;src/Item.c:131: case 3:{
   0E9A                     481 00104$:
                            482 ;src/Item.c:132: ++player_potion_count;
   0E9A 21 6A 7D      [10]  483 	ld	hl, #_player_potion_count+0
   0E9D 34            [11]  484 	inc	(hl)
                            485 ;src/Item.c:133: ui_playerstats_render_potions();
   0E9E C5            [11]  486 	push	bc
   0E9F CD CC 4C      [17]  487 	call	_ui_playerstats_render_potions
   0EA2 C1            [10]  488 	pop	bc
                            489 ;src/Item.c:134: object="POTION";
   0EA3 11 E9 0E      [10]  490 	ld	de,#___str_3
                            491 ;src/Item.c:135: break;
   0EA6 18 0C         [12]  492 	jr	00106$
                            493 ;src/Item.c:137: case 4:{
   0EA8                     494 00105$:
                            495 ;src/Item.c:138: ++player_scroll_count;
   0EA8 21 6B 7D      [10]  496 	ld	hl, #_player_scroll_count+0
   0EAB 34            [11]  497 	inc	(hl)
                            498 ;src/Item.c:139: ui_playerstats_render_scrolls();
   0EAC C5            [11]  499 	push	bc
   0EAD CD 02 4D      [17]  500 	call	_ui_playerstats_render_scrolls
   0EB0 C1            [10]  501 	pop	bc
                            502 ;src/Item.c:140: object="SCROLL";
   0EB1 11 F0 0E      [10]  503 	ld	de,#___str_4
                            504 ;src/Item.c:143: }
   0EB4                     505 00106$:
                            506 ;src/Item.c:145: ui_log_add_log("PICKED",3);
   0EB4 C5            [11]  507 	push	bc
   0EB5 D5            [11]  508 	push	de
   0EB6 3E 03         [ 7]  509 	ld	a,#0x03
   0EB8 F5            [11]  510 	push	af
   0EB9 33            [ 6]  511 	inc	sp
   0EBA 21 F7 0E      [10]  512 	ld	hl,#___str_5
   0EBD E5            [11]  513 	push	hl
   0EBE CD 5B 47      [17]  514 	call	_ui_log_add_log
   0EC1 F1            [10]  515 	pop	af
   0EC2 33            [ 6]  516 	inc	sp
   0EC3 D1            [10]  517 	pop	de
   0EC4 3E 06         [ 7]  518 	ld	a,#0x06
   0EC6 F5            [11]  519 	push	af
   0EC7 33            [ 6]  520 	inc	sp
   0EC8 D5            [11]  521 	push	de
   0EC9 CD 5B 47      [17]  522 	call	_ui_log_add_log
   0ECC F1            [10]  523 	pop	af
   0ECD 33            [ 6]  524 	inc	sp
   0ECE CD A6 47      [17]  525 	call	_ui_log_render
   0ED1 CD FE 0E      [17]  526 	call	_item_destroy_item
   0ED4 DD F9         [10]  527 	ld	sp,ix
   0ED6 DD E1         [14]  528 	pop	ix
   0ED8 C9            [10]  529 	ret
   0ED9                     530 ___str_0:
   0ED9 4B 45 59            531 	.ascii "KEY"
   0EDC 00                  532 	.db 0x00
   0EDD                     533 ___str_1:
   0EDD 53 57 4F 52 44      534 	.ascii "SWORD"
   0EE2 00                  535 	.db 0x00
   0EE3                     536 ___str_2:
   0EE3 41 52 4D 4F 52      537 	.ascii "ARMOR"
   0EE8 00                  538 	.db 0x00
   0EE9                     539 ___str_3:
   0EE9 50 4F 54 49 4F 4E   540 	.ascii "POTION"
   0EEF 00                  541 	.db 0x00
   0EF0                     542 ___str_4:
   0EF0 53 43 52 4F 4C 4C   543 	.ascii "SCROLL"
   0EF6 00                  544 	.db 0x00
   0EF7                     545 ___str_5:
   0EF7 50 49 43 4B 45 44   546 	.ascii "PICKED"
   0EFD 00                  547 	.db 0x00
                            548 ;src/Item.c:152: void item_destroy_item(Item* i){
                            549 ;	---------------------------------
                            550 ; Function item_destroy_item
                            551 ; ---------------------------------
   0EFE                     552 _item_destroy_item::
   0EFE DD E5         [15]  553 	push	ix
   0F00 DD 21 00 00   [14]  554 	ld	ix,#0
   0F04 DD 39         [15]  555 	add	ix,sp
                            556 ;src/Item.c:153: u8* mapPos = (u8*)(MAP_MEM + i->position.x + (i->position.y*MAP_WIDTH));
   0F06 DD 5E 04      [19]  557 	ld	e,4 (ix)
   0F09 DD 56 05      [19]  558 	ld	d,5 (ix)
   0F0C 6B            [ 4]  559 	ld	l, e
   0F0D 62            [ 4]  560 	ld	h, d
   0F0E 23            [ 6]  561 	inc	hl
   0F0F 4E            [ 7]  562 	ld	c,(hl)
   0F10 06 00         [ 7]  563 	ld	b,#0x00
   0F12 21 D0 88      [10]  564 	ld	hl,#0x88D0
   0F15 09            [11]  565 	add	hl,bc
   0F16 4D            [ 4]  566 	ld	c,l
   0F17 44            [ 4]  567 	ld	b,h
   0F18 6B            [ 4]  568 	ld	l, e
   0F19 62            [ 4]  569 	ld	h, d
   0F1A 23            [ 6]  570 	inc	hl
   0F1B 23            [ 6]  571 	inc	hl
   0F1C 6E            [ 7]  572 	ld	l,(hl)
   0F1D 26 00         [ 7]  573 	ld	h,#0x00
   0F1F 29            [11]  574 	add	hl, hl
   0F20 29            [11]  575 	add	hl, hl
   0F21 29            [11]  576 	add	hl, hl
   0F22 29            [11]  577 	add	hl, hl
   0F23 29            [11]  578 	add	hl, hl
   0F24 09            [11]  579 	add	hl,bc
   0F25 4D            [ 4]  580 	ld	c,l
   0F26 44            [ 4]  581 	ld	b,h
                            582 ;src/Item.c:155: --activeItems;
   0F27 21 3D 7D      [10]  583 	ld	hl, #_activeItems+0
   0F2A 35            [11]  584 	dec	(hl)
                            585 ;src/Item.c:157: i->value=0;
   0F2B 13            [ 6]  586 	inc	de
   0F2C 13            [ 6]  587 	inc	de
   0F2D 13            [ 6]  588 	inc	de
   0F2E 13            [ 6]  589 	inc	de
   0F2F AF            [ 4]  590 	xor	a, a
   0F30 12            [ 7]  591 	ld	(de),a
                            592 ;src/Item.c:159: *mapPos = *mapPos&(CELL_WALL_MASK|CELL_ENEMY_MASK);
   0F31 0A            [ 7]  593 	ld	a,(bc)
   0F32 E6 8F         [ 7]  594 	and	a, #0x8F
   0F34 02            [ 7]  595 	ld	(bc),a
   0F35 DD E1         [14]  596 	pop	ix
   0F37 C9            [10]  597 	ret
                            598 ;src/Item.c:163: u8 item_use_potion(){
                            599 ;	---------------------------------
                            600 ; Function item_use_potion
                            601 ; ---------------------------------
   0F38                     602 _item_use_potion::
                            603 ;src/Item.c:164: if(player_potion_count){
   0F38 3A 6A 7D      [13]  604 	ld	a,(#_player_potion_count + 0)
   0F3B B7            [ 4]  605 	or	a, a
   0F3C 28 1F         [12]  606 	jr	Z,00105$
                            607 ;src/Item.c:165: --player_potion_count;
   0F3E 21 6A 7D      [10]  608 	ld	hl, #_player_potion_count+0
   0F41 35            [11]  609 	dec	(hl)
                            610 ;src/Item.c:166: if(player_health_points<(255-ITEM_POTION_HEAL)){
   0F42 3A 67 7D      [13]  611 	ld	a,(#_player_health_points + 0)
   0F45 D6 80         [ 7]  612 	sub	a, #0x80
   0F47 30 09         [12]  613 	jr	NC,00102$
                            614 ;src/Item.c:167: player_health_points+=ITEM_POTION_HEAL;
   0F49 21 67 7D      [10]  615 	ld	hl,#_player_health_points
   0F4C 7E            [ 7]  616 	ld	a,(hl)
   0F4D C6 7F         [ 7]  617 	add	a, #0x7F
   0F4F 77            [ 7]  618 	ld	(hl),a
   0F50 18 05         [12]  619 	jr	00103$
   0F52                     620 00102$:
                            621 ;src/Item.c:170: player_health_points=255;
   0F52 21 67 7D      [10]  622 	ld	hl,#_player_health_points + 0
   0F55 36 FF         [10]  623 	ld	(hl), #0xFF
   0F57                     624 00103$:
                            625 ;src/Item.c:172: ui_playerstats_render_hp();
   0F57 CD FF 4B      [17]  626 	call	_ui_playerstats_render_hp
                            627 ;src/Item.c:173: return 1;
   0F5A 2E 01         [ 7]  628 	ld	l,#0x01
   0F5C C9            [10]  629 	ret
   0F5D                     630 00105$:
                            631 ;src/Item.c:175: return 0;
   0F5D 2E 00         [ 7]  632 	ld	l,#0x00
   0F5F C9            [10]  633 	ret
                            634 ;src/Item.c:178: u8 item_use_scroll(){
                            635 ;	---------------------------------
                            636 ; Function item_use_scroll
                            637 ; ---------------------------------
   0F60                     638 _item_use_scroll::
                            639 ;src/Item.c:179: u16 pos = (cpct_getRandom_mxor_u16()%1024);
   0F60 CD BA 7A      [17]  640 	call	_cpct_getRandom_mxor_u16
   0F63 4D            [ 4]  641 	ld	c,l
   0F64 7C            [ 4]  642 	ld	a,h
   0F65 E6 03         [ 7]  643 	and	a, #0x03
   0F67 47            [ 4]  644 	ld	b,a
                            645 ;src/Item.c:180: if(player_scroll_count){
   0F68 3A 6B 7D      [13]  646 	ld	a,(#_player_scroll_count + 0)
   0F6B B7            [ 4]  647 	or	a, a
   0F6C 28 36         [12]  648 	jr	Z,00105$
                            649 ;src/Item.c:181: while(*(u8*)(MAP_MEM+pos)!=CELLTYPE_FLOOR){
   0F6E                     650 00101$:
   0F6E 21 D0 88      [10]  651 	ld	hl,#0x88D0
   0F71 09            [11]  652 	add	hl,bc
   0F72 7E            [ 7]  653 	ld	a,(hl)
   0F73 B7            [ 4]  654 	or	a, a
   0F74 28 07         [12]  655 	jr	Z,00103$
                            656 ;src/Item.c:182: pos = (pos+1)%1024;
   0F76 03            [ 6]  657 	inc	bc
   0F77 78            [ 4]  658 	ld	a,b
   0F78 E6 03         [ 7]  659 	and	a, #0x03
   0F7A 47            [ 4]  660 	ld	b,a
   0F7B 18 F1         [12]  661 	jr	00101$
   0F7D                     662 00103$:
                            663 ;src/Item.c:184: --player_scroll_count;
   0F7D 21 6B 7D      [10]  664 	ld	hl, #_player_scroll_count+0
   0F80 35            [11]  665 	dec	(hl)
                            666 ;src/Item.c:185: *(u8*)&(player_position.x) = (pos%MAP_WIDTH);
   0F81 79            [ 4]  667 	ld	a,c
   0F82 E6 1F         [ 7]  668 	and	a, #0x1F
   0F84 5F            [ 4]  669 	ld	e,a
   0F85 21 2C 18      [10]  670 	ld	hl,#_player_position
   0F88 73            [ 7]  671 	ld	(hl),e
                            672 ;src/Item.c:186: *(u8*)&(player_position.y) = (pos/MAP_HEIGHT);
   0F89 CB 38         [ 8]  673 	srl	b
   0F8B CB 19         [ 8]  674 	rr	c
   0F8D CB 38         [ 8]  675 	srl	b
   0F8F CB 19         [ 8]  676 	rr	c
   0F91 CB 38         [ 8]  677 	srl	b
   0F93 CB 19         [ 8]  678 	rr	c
   0F95 CB 38         [ 8]  679 	srl	b
   0F97 CB 19         [ 8]  680 	rr	c
   0F99 CB 38         [ 8]  681 	srl	b
   0F9B CB 19         [ 8]  682 	rr	c
   0F9D 21 2D 18      [10]  683 	ld	hl,#(_player_position + 0x0001)
   0FA0 71            [ 7]  684 	ld	(hl),c
                            685 ;src/Item.c:187: return 1;
   0FA1 2E 01         [ 7]  686 	ld	l,#0x01
   0FA3 C9            [10]  687 	ret
   0FA4                     688 00105$:
                            689 ;src/Item.c:189: return 0;
   0FA4 2E 00         [ 7]  690 	ld	l,#0x00
   0FA6 C9            [10]  691 	ret
                            692 	.area _CODE
                            693 	.area _INITIALIZER
                            694 	.area _CABS (ABS)
