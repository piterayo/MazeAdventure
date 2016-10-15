                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module Textures
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _uncompress_item_textures
                             12 	.globl _uncompress_texture
                             13 	.globl _enemy_textures
                             14 	.globl _theme_textures
                             15 	.globl _uncompress_theme_textures
                             16 	.globl _uncompress_enemy_textures
                             17 ;--------------------------------------------------------
                             18 ; special function registers
                             19 ;--------------------------------------------------------
                             20 ;--------------------------------------------------------
                             21 ; ram data
                             22 ;--------------------------------------------------------
                             23 	.area _DATA
                             24 ;--------------------------------------------------------
                             25 ; ram data
                             26 ;--------------------------------------------------------
                             27 	.area _INITIALIZED
                             28 ;--------------------------------------------------------
                             29 ; absolute external ram data
                             30 ;--------------------------------------------------------
                             31 	.area _DABS (ABS)
                             32 ;--------------------------------------------------------
                             33 ; global & static initialisations
                             34 ;--------------------------------------------------------
                             35 	.area _HOME
                             36 	.area _GSINIT
                             37 	.area _GSFINAL
                             38 	.area _GSINIT
                             39 ;--------------------------------------------------------
                             40 ; Home
                             41 ;--------------------------------------------------------
                             42 	.area _HOME
                             43 	.area _HOME
                             44 ;--------------------------------------------------------
                             45 ; code
                             46 ;--------------------------------------------------------
                             47 	.area _CODE
                             48 ;src/Textures.c:19: void uncompress_texture(u8* texture, u8* position, u8 sizeX, u8 sizeY){
                             49 ;	---------------------------------
                             50 ; Function uncompress_texture
                             51 ; ---------------------------------
   23BE                      52 _uncompress_texture::
   23BE DD E5         [15]   53 	push	ix
   23C0 DD 21 00 00   [14]   54 	ld	ix,#0
   23C4 DD 39         [15]   55 	add	ix,sp
   23C6 21 F8 FF      [10]   56 	ld	hl,#-8
   23C9 39            [11]   57 	add	hl,sp
   23CA F9            [ 6]   58 	ld	sp,hl
                             59 ;src/Textures.c:20: u8 p1, p2, tex_height=sizeY, tex_width = sizeX;
   23CB DD 7E 09      [19]   60 	ld	a,9 (ix)
   23CE DD 77 FA      [19]   61 	ld	-6 (ix),a
   23D1 DD 4E 08      [19]   62 	ld	c,8 (ix)
                             63 ;src/Textures.c:26: while(sizeX){
   23D4 DD 71 FF      [19]   64 	ld	-1 (ix),c
   23D7 DD 5E 06      [19]   65 	ld	e,6 (ix)
   23DA DD 56 07      [19]   66 	ld	d,7 (ix)
   23DD                      67 00104$:
   23DD DD 7E FF      [19]   68 	ld	a,-1 (ix)
   23E0 B7            [ 4]   69 	or	a, a
   23E1 CA 67 24      [10]   70 	jp	Z,00107$
                             71 ;src/Textures.c:28: currPos = position;
   23E4 DD 73 FB      [19]   72 	ld	-5 (ix),e
   23E7 DD 72 FC      [19]   73 	ld	-4 (ix),d
                             74 ;src/Textures.c:29: while(sizeY){
   23EA DD 46 09      [19]   75 	ld	b,9 (ix)
   23ED DD 7E 04      [19]   76 	ld	a,4 (ix)
   23F0 DD 77 FD      [19]   77 	ld	-3 (ix),a
   23F3 DD 7E 05      [19]   78 	ld	a,5 (ix)
   23F6 DD 77 FE      [19]   79 	ld	-2 (ix),a
   23F9                      80 00101$:
   23F9 78            [ 4]   81 	ld	a,b
   23FA B7            [ 4]   82 	or	a, a
   23FB 28 51         [12]   83 	jr	Z,00113$
                             84 ;src/Textures.c:30: p1 = (*texture) & g_pixelMask[0];
   23FD DD 6E FD      [19]   85 	ld	l,-3 (ix)
   2400 DD 66 FE      [19]   86 	ld	h,-2 (ix)
   2403 7E            [ 7]   87 	ld	a,(hl)
   2404 21 B3 0A      [10]   88 	ld	hl, #_g_pixelMask + 0
   2407 6E            [ 7]   89 	ld	l,(hl)
   2408 A5            [ 4]   90 	and	a, l
                             91 ;src/Textures.c:31: p1= p1 | (p1>>1);
   2409 6F            [ 4]   92 	ld	l,a
   240A CB 3F         [ 8]   93 	srl	a
   240C B5            [ 4]   94 	or	a, l
                             95 ;src/Textures.c:32: *currPos = p1;
   240D DD 6E FB      [19]   96 	ld	l,-5 (ix)
   2410 DD 66 FC      [19]   97 	ld	h,-4 (ix)
   2413 77            [ 7]   98 	ld	(hl),a
                             99 ;src/Textures.c:33: currPos+=tex_width;
   2414 DD 7E FB      [19]  100 	ld	a,-5 (ix)
   2417 81            [ 4]  101 	add	a, c
   2418 6F            [ 4]  102 	ld	l,a
   2419 DD 7E FC      [19]  103 	ld	a,-4 (ix)
   241C CE 00         [ 7]  104 	adc	a, #0x00
   241E 67            [ 4]  105 	ld	h,a
   241F 33            [ 6]  106 	inc	sp
   2420 33            [ 6]  107 	inc	sp
   2421 E5            [11]  108 	push	hl
                            109 ;src/Textures.c:35: p2 = (*texture) & g_pixelMask[1];
   2422 DD 6E FD      [19]  110 	ld	l,-3 (ix)
   2425 DD 66 FE      [19]  111 	ld	h,-2 (ix)
   2428 7E            [ 7]  112 	ld	a,(hl)
   2429 21 B4 0A      [10]  113 	ld	hl, #_g_pixelMask + 1
   242C 6E            [ 7]  114 	ld	l,(hl)
   242D A5            [ 4]  115 	and	a, l
                            116 ;src/Textures.c:36: p2 = p2 | (p2<<1);
   242E 6F            [ 4]  117 	ld	l,a
   242F 87            [ 4]  118 	add	a, a
   2430 B5            [ 4]  119 	or	a, l
                            120 ;src/Textures.c:37: *currPos = p2;
   2431 E1            [10]  121 	pop	hl
   2432 E5            [11]  122 	push	hl
   2433 77            [ 7]  123 	ld	(hl),a
                            124 ;src/Textures.c:38: currPos+=tex_width;
   2434 DD 7E F8      [19]  125 	ld	a,-8 (ix)
   2437 81            [ 4]  126 	add	a, c
   2438 DD 77 FB      [19]  127 	ld	-5 (ix),a
   243B DD 7E F9      [19]  128 	ld	a,-7 (ix)
   243E CE 00         [ 7]  129 	adc	a, #0x00
   2440 DD 77 FC      [19]  130 	ld	-4 (ix),a
                            131 ;src/Textures.c:39: --sizeY;
   2443 05            [ 4]  132 	dec	b
                            133 ;src/Textures.c:40: ++texture;
   2444 DD 34 FD      [23]  134 	inc	-3 (ix)
   2447 20 B0         [12]  135 	jr	NZ,00101$
   2449 DD 34 FE      [23]  136 	inc	-2 (ix)
   244C 18 AB         [12]  137 	jr	00101$
   244E                     138 00113$:
   244E DD 7E FD      [19]  139 	ld	a,-3 (ix)
   2451 DD 77 04      [19]  140 	ld	4 (ix),a
   2454 DD 7E FE      [19]  141 	ld	a,-2 (ix)
   2457 DD 77 05      [19]  142 	ld	5 (ix),a
                            143 ;src/Textures.c:42: --sizeX;
   245A DD 35 FF      [23]  144 	dec	-1 (ix)
                            145 ;src/Textures.c:43: sizeY=tex_height;
   245D DD 7E FA      [19]  146 	ld	a,-6 (ix)
   2460 DD 77 09      [19]  147 	ld	9 (ix),a
                            148 ;src/Textures.c:44: ++position;
   2463 13            [ 6]  149 	inc	de
   2464 C3 DD 23      [10]  150 	jp	00104$
   2467                     151 00107$:
   2467 DD F9         [10]  152 	ld	sp, ix
   2469 DD E1         [14]  153 	pop	ix
   246B C9            [10]  154 	ret
   246C                     155 _theme_textures:
   246C 7A 32               156 	.dw _level0_walls_tileset
   246E 84 3C               157 	.dw _level1_walls_tileset
   2470 84 3C               158 	.dw _level1_walls_tileset
   2472 84 3C               159 	.dw _level1_walls_tileset
   2474                     160 _enemy_textures:
   2474 5C 2D               161 	.dw _level0_enemies_tileset
   2476 5C 2D               162 	.dw _level0_enemies_tileset
   2478 5C 2D               163 	.dw _level0_enemies_tileset
   247A 5C 2D               164 	.dw _level0_enemies_tileset
                            165 ;src/Textures.c:49: void uncompress_theme_textures(u8 level){//TODO implement
                            166 ;	---------------------------------
                            167 ; Function uncompress_theme_textures
                            168 ; ---------------------------------
   247C                     169 _uncompress_theme_textures::
   247C DD E5         [15]  170 	push	ix
   247E DD 21 00 00   [14]  171 	ld	ix,#0
   2482 DD 39         [15]  172 	add	ix,sp
                            173 ;src/Textures.c:50: uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_TEXTURES,TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   2484 01 6C 24      [10]  174 	ld	bc,#_theme_textures+0
   2487 DD 6E 04      [19]  175 	ld	l,4 (ix)
   248A 26 00         [ 7]  176 	ld	h,#0x00
   248C 29            [11]  177 	add	hl, hl
   248D 09            [11]  178 	add	hl,bc
   248E 4D            [ 4]  179 	ld	c,l
   248F 44            [ 4]  180 	ld	b,h
   2490 5E            [ 7]  181 	ld	e,(hl)
   2491 23            [ 6]  182 	inc	hl
   2492 66            [ 7]  183 	ld	h,(hl)
   2493 6B            [ 4]  184 	ld	l, e
   2494 5E            [ 7]  185 	ld	e,(hl)
   2495 23            [ 6]  186 	inc	hl
   2496 56            [ 7]  187 	ld	d,(hl)
   2497 C5            [11]  188 	push	bc
   2498 21 20 10      [10]  189 	ld	hl,#0x1020
   249B E5            [11]  190 	push	hl
   249C 21 00 64      [10]  191 	ld	hl,#0x6400
   249F E5            [11]  192 	push	hl
   24A0 D5            [11]  193 	push	de
   24A1 CD BE 23      [17]  194 	call	_uncompress_texture
   24A4 21 06 00      [10]  195 	ld	hl,#6
   24A7 39            [11]  196 	add	hl,sp
   24A8 F9            [ 6]  197 	ld	sp,hl
   24A9 C1            [10]  198 	pop	bc
                            199 ;src/Textures.c:51: uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_TEXTURES+1024),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   24AA 69            [ 4]  200 	ld	l, c
   24AB 60            [ 4]  201 	ld	h, b
   24AC 5E            [ 7]  202 	ld	e,(hl)
   24AD 23            [ 6]  203 	inc	hl
   24AE 66            [ 7]  204 	ld	h,(hl)
   24AF 6B            [ 4]  205 	ld	l, e
   24B0 23            [ 6]  206 	inc	hl
   24B1 23            [ 6]  207 	inc	hl
   24B2 5E            [ 7]  208 	ld	e,(hl)
   24B3 23            [ 6]  209 	inc	hl
   24B4 56            [ 7]  210 	ld	d,(hl)
   24B5 C5            [11]  211 	push	bc
   24B6 21 20 10      [10]  212 	ld	hl,#0x1020
   24B9 E5            [11]  213 	push	hl
   24BA 21 00 68      [10]  214 	ld	hl,#0x6800
   24BD E5            [11]  215 	push	hl
   24BE D5            [11]  216 	push	de
   24BF CD BE 23      [17]  217 	call	_uncompress_texture
   24C2 21 06 00      [10]  218 	ld	hl,#6
   24C5 39            [11]  219 	add	hl,sp
   24C6 F9            [ 6]  220 	ld	sp,hl
   24C7 C1            [10]  221 	pop	bc
                            222 ;src/Textures.c:52: uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_TEXTURES+2048),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   24C8 69            [ 4]  223 	ld	l, c
   24C9 60            [ 4]  224 	ld	h, b
   24CA 5E            [ 7]  225 	ld	e,(hl)
   24CB 23            [ 6]  226 	inc	hl
   24CC 66            [ 7]  227 	ld	h,(hl)
   24CD 6B            [ 4]  228 	ld	l, e
   24CE 11 04 00      [10]  229 	ld	de, #0x0004
   24D1 19            [11]  230 	add	hl, de
   24D2 5E            [ 7]  231 	ld	e,(hl)
   24D3 23            [ 6]  232 	inc	hl
   24D4 56            [ 7]  233 	ld	d,(hl)
   24D5 C5            [11]  234 	push	bc
   24D6 21 20 10      [10]  235 	ld	hl,#0x1020
   24D9 E5            [11]  236 	push	hl
   24DA 21 00 6C      [10]  237 	ld	hl,#0x6C00
   24DD E5            [11]  238 	push	hl
   24DE D5            [11]  239 	push	de
   24DF CD BE 23      [17]  240 	call	_uncompress_texture
   24E2 21 06 00      [10]  241 	ld	hl,#6
   24E5 39            [11]  242 	add	hl,sp
   24E6 F9            [ 6]  243 	ld	sp,hl
   24E7 C1            [10]  244 	pop	bc
                            245 ;src/Textures.c:53: uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_TEXTURES+3072),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   24E8 69            [ 4]  246 	ld	l, c
   24E9 60            [ 4]  247 	ld	h, b
   24EA 5E            [ 7]  248 	ld	e,(hl)
   24EB 23            [ 6]  249 	inc	hl
   24EC 66            [ 7]  250 	ld	h,(hl)
   24ED 6B            [ 4]  251 	ld	l, e
   24EE 11 06 00      [10]  252 	ld	de, #0x0006
   24F1 19            [11]  253 	add	hl, de
   24F2 5E            [ 7]  254 	ld	e,(hl)
   24F3 23            [ 6]  255 	inc	hl
   24F4 56            [ 7]  256 	ld	d,(hl)
   24F5 C5            [11]  257 	push	bc
   24F6 21 20 10      [10]  258 	ld	hl,#0x1020
   24F9 E5            [11]  259 	push	hl
   24FA 21 00 70      [10]  260 	ld	hl,#0x7000
   24FD E5            [11]  261 	push	hl
   24FE D5            [11]  262 	push	de
   24FF CD BE 23      [17]  263 	call	_uncompress_texture
   2502 21 06 00      [10]  264 	ld	hl,#6
   2505 39            [11]  265 	add	hl,sp
   2506 F9            [ 6]  266 	ld	sp,hl
                            267 ;src/Textures.c:54: uncompress_texture(theme_textures[level][4],(u8*)(UNCOMPRESSED_TEXTURES+4096),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   2507 E1            [10]  268 	pop	hl
   2508 4E            [ 7]  269 	ld	c,(hl)
   2509 23            [ 6]  270 	inc	hl
   250A 66            [ 7]  271 	ld	h,(hl)
   250B 69            [ 4]  272 	ld	l, c
   250C 11 08 00      [10]  273 	ld	de, #0x0008
   250F 19            [11]  274 	add	hl, de
   2510 4E            [ 7]  275 	ld	c,(hl)
   2511 23            [ 6]  276 	inc	hl
   2512 46            [ 7]  277 	ld	b,(hl)
   2513 21 20 10      [10]  278 	ld	hl,#0x1020
   2516 E5            [11]  279 	push	hl
   2517 21 00 74      [10]  280 	ld	hl,#0x7400
   251A E5            [11]  281 	push	hl
   251B C5            [11]  282 	push	bc
   251C CD BE 23      [17]  283 	call	_uncompress_texture
   251F 21 06 00      [10]  284 	ld	hl,#6
   2522 39            [11]  285 	add	hl,sp
   2523 F9            [ 6]  286 	ld	sp,hl
   2524 DD E1         [14]  287 	pop	ix
   2526 C9            [10]  288 	ret
                            289 ;src/Textures.c:57: void uncompress_enemy_textures(u8 level){
                            290 ;	---------------------------------
                            291 ; Function uncompress_enemy_textures
                            292 ; ---------------------------------
   2527                     293 _uncompress_enemy_textures::
   2527 DD E5         [15]  294 	push	ix
   2529 DD 21 00 00   [14]  295 	ld	ix,#0
   252D DD 39         [15]  296 	add	ix,sp
                            297 ;src/Textures.c:58: uncompress_texture(enemy_textures[level][0],(u8*)UNCOMPRESSED_ENEMY_TEXTURES,ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   252F 01 74 24      [10]  298 	ld	bc,#_enemy_textures+0
   2532 DD 6E 04      [19]  299 	ld	l,4 (ix)
   2535 26 00         [ 7]  300 	ld	h,#0x00
   2537 29            [11]  301 	add	hl, hl
   2538 09            [11]  302 	add	hl,bc
   2539 4D            [ 4]  303 	ld	c,l
   253A 44            [ 4]  304 	ld	b,h
   253B 5E            [ 7]  305 	ld	e,(hl)
   253C 23            [ 6]  306 	inc	hl
   253D 66            [ 7]  307 	ld	h,(hl)
   253E 6B            [ 4]  308 	ld	l, e
   253F 5E            [ 7]  309 	ld	e,(hl)
   2540 23            [ 6]  310 	inc	hl
   2541 56            [ 7]  311 	ld	d,(hl)
   2542 C5            [11]  312 	push	bc
   2543 21 18 0C      [10]  313 	ld	hl,#0x0C18
   2546 E5            [11]  314 	push	hl
   2547 21 00 78      [10]  315 	ld	hl,#0x7800
   254A E5            [11]  316 	push	hl
   254B D5            [11]  317 	push	de
   254C CD BE 23      [17]  318 	call	_uncompress_texture
   254F 21 06 00      [10]  319 	ld	hl,#6
   2552 39            [11]  320 	add	hl,sp
   2553 F9            [ 6]  321 	ld	sp,hl
   2554 C1            [10]  322 	pop	bc
                            323 ;src/Textures.c:59: uncompress_texture(enemy_textures[level][1],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+576),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   2555 69            [ 4]  324 	ld	l, c
   2556 60            [ 4]  325 	ld	h, b
   2557 5E            [ 7]  326 	ld	e,(hl)
   2558 23            [ 6]  327 	inc	hl
   2559 66            [ 7]  328 	ld	h,(hl)
   255A 6B            [ 4]  329 	ld	l, e
   255B 23            [ 6]  330 	inc	hl
   255C 23            [ 6]  331 	inc	hl
   255D 5E            [ 7]  332 	ld	e,(hl)
   255E 23            [ 6]  333 	inc	hl
   255F 56            [ 7]  334 	ld	d,(hl)
   2560 C5            [11]  335 	push	bc
   2561 21 18 0C      [10]  336 	ld	hl,#0x0C18
   2564 E5            [11]  337 	push	hl
   2565 21 40 7A      [10]  338 	ld	hl,#0x7A40
   2568 E5            [11]  339 	push	hl
   2569 D5            [11]  340 	push	de
   256A CD BE 23      [17]  341 	call	_uncompress_texture
   256D 21 06 00      [10]  342 	ld	hl,#6
   2570 39            [11]  343 	add	hl,sp
   2571 F9            [ 6]  344 	ld	sp,hl
   2572 C1            [10]  345 	pop	bc
                            346 ;src/Textures.c:60: uncompress_texture(enemy_textures[level][2],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1152),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   2573 69            [ 4]  347 	ld	l, c
   2574 60            [ 4]  348 	ld	h, b
   2575 5E            [ 7]  349 	ld	e,(hl)
   2576 23            [ 6]  350 	inc	hl
   2577 66            [ 7]  351 	ld	h,(hl)
   2578 6B            [ 4]  352 	ld	l, e
   2579 11 04 00      [10]  353 	ld	de, #0x0004
   257C 19            [11]  354 	add	hl, de
   257D 5E            [ 7]  355 	ld	e,(hl)
   257E 23            [ 6]  356 	inc	hl
   257F 56            [ 7]  357 	ld	d,(hl)
   2580 C5            [11]  358 	push	bc
   2581 21 18 0C      [10]  359 	ld	hl,#0x0C18
   2584 E5            [11]  360 	push	hl
   2585 21 80 7C      [10]  361 	ld	hl,#0x7C80
   2588 E5            [11]  362 	push	hl
   2589 D5            [11]  363 	push	de
   258A CD BE 23      [17]  364 	call	_uncompress_texture
   258D 21 06 00      [10]  365 	ld	hl,#6
   2590 39            [11]  366 	add	hl,sp
   2591 F9            [ 6]  367 	ld	sp,hl
                            368 ;src/Textures.c:61: uncompress_texture(enemy_textures[level][3],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1728),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   2592 E1            [10]  369 	pop	hl
   2593 4E            [ 7]  370 	ld	c,(hl)
   2594 23            [ 6]  371 	inc	hl
   2595 66            [ 7]  372 	ld	h,(hl)
   2596 69            [ 4]  373 	ld	l, c
   2597 11 06 00      [10]  374 	ld	de, #0x0006
   259A 19            [11]  375 	add	hl, de
   259B 4E            [ 7]  376 	ld	c,(hl)
   259C 23            [ 6]  377 	inc	hl
   259D 46            [ 7]  378 	ld	b,(hl)
   259E 21 18 0C      [10]  379 	ld	hl,#0x0C18
   25A1 E5            [11]  380 	push	hl
   25A2 21 C0 7E      [10]  381 	ld	hl,#0x7EC0
   25A5 E5            [11]  382 	push	hl
   25A6 C5            [11]  383 	push	bc
   25A7 CD BE 23      [17]  384 	call	_uncompress_texture
   25AA 21 06 00      [10]  385 	ld	hl,#6
   25AD 39            [11]  386 	add	hl,sp
   25AE F9            [ 6]  387 	ld	sp,hl
   25AF DD E1         [14]  388 	pop	ix
   25B1 C9            [10]  389 	ret
                            390 ;src/Textures.c:64: void uncompress_item_textures(){
                            391 ;	---------------------------------
                            392 ; Function uncompress_item_textures
                            393 ; ---------------------------------
   25B2                     394 _uncompress_item_textures::
                            395 ;src/Textures.c:66: }
   25B2 C9            [10]  396 	ret
                            397 	.area _CODE
                            398 	.area _INITIALIZER
                            399 	.area _CABS (ABS)
