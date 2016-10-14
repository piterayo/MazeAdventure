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
   2302                      52 _uncompress_texture::
   2302 DD E5         [15]   53 	push	ix
   2304 DD 21 00 00   [14]   54 	ld	ix,#0
   2308 DD 39         [15]   55 	add	ix,sp
   230A 21 F8 FF      [10]   56 	ld	hl,#-8
   230D 39            [11]   57 	add	hl,sp
   230E F9            [ 6]   58 	ld	sp,hl
                             59 ;src/Textures.c:20: u8 p1, p2, tex_height=sizeY, tex_width = sizeX;
   230F DD 7E 09      [19]   60 	ld	a,9 (ix)
   2312 DD 77 FA      [19]   61 	ld	-6 (ix),a
   2315 DD 4E 08      [19]   62 	ld	c,8 (ix)
                             63 ;src/Textures.c:26: while(sizeX){
   2318 DD 71 FF      [19]   64 	ld	-1 (ix),c
   231B DD 5E 06      [19]   65 	ld	e,6 (ix)
   231E DD 56 07      [19]   66 	ld	d,7 (ix)
   2321                      67 00104$:
   2321 DD 7E FF      [19]   68 	ld	a,-1 (ix)
   2324 B7            [ 4]   69 	or	a, a
   2325 CA AB 23      [10]   70 	jp	Z,00107$
                             71 ;src/Textures.c:28: currPos = position;
   2328 DD 73 FB      [19]   72 	ld	-5 (ix),e
   232B DD 72 FC      [19]   73 	ld	-4 (ix),d
                             74 ;src/Textures.c:29: while(sizeY){
   232E DD 46 09      [19]   75 	ld	b,9 (ix)
   2331 DD 7E 04      [19]   76 	ld	a,4 (ix)
   2334 DD 77 FD      [19]   77 	ld	-3 (ix),a
   2337 DD 7E 05      [19]   78 	ld	a,5 (ix)
   233A DD 77 FE      [19]   79 	ld	-2 (ix),a
   233D                      80 00101$:
   233D 78            [ 4]   81 	ld	a,b
   233E B7            [ 4]   82 	or	a, a
   233F 28 51         [12]   83 	jr	Z,00113$
                             84 ;src/Textures.c:30: p1 = (*texture) & g_pixelMask[0];
   2341 DD 6E FD      [19]   85 	ld	l,-3 (ix)
   2344 DD 66 FE      [19]   86 	ld	h,-2 (ix)
   2347 7E            [ 7]   87 	ld	a,(hl)
   2348 21 C2 0A      [10]   88 	ld	hl, #_g_pixelMask + 0
   234B 6E            [ 7]   89 	ld	l,(hl)
   234C A5            [ 4]   90 	and	a, l
                             91 ;src/Textures.c:31: p1= p1 | (p1>>1);
   234D 6F            [ 4]   92 	ld	l,a
   234E CB 3F         [ 8]   93 	srl	a
   2350 B5            [ 4]   94 	or	a, l
                             95 ;src/Textures.c:32: *currPos = p1;
   2351 DD 6E FB      [19]   96 	ld	l,-5 (ix)
   2354 DD 66 FC      [19]   97 	ld	h,-4 (ix)
   2357 77            [ 7]   98 	ld	(hl),a
                             99 ;src/Textures.c:33: currPos+=tex_width;
   2358 DD 7E FB      [19]  100 	ld	a,-5 (ix)
   235B 81            [ 4]  101 	add	a, c
   235C 6F            [ 4]  102 	ld	l,a
   235D DD 7E FC      [19]  103 	ld	a,-4 (ix)
   2360 CE 00         [ 7]  104 	adc	a, #0x00
   2362 67            [ 4]  105 	ld	h,a
   2363 33            [ 6]  106 	inc	sp
   2364 33            [ 6]  107 	inc	sp
   2365 E5            [11]  108 	push	hl
                            109 ;src/Textures.c:35: p2 = (*texture) & g_pixelMask[1];
   2366 DD 6E FD      [19]  110 	ld	l,-3 (ix)
   2369 DD 66 FE      [19]  111 	ld	h,-2 (ix)
   236C 7E            [ 7]  112 	ld	a,(hl)
   236D 21 C3 0A      [10]  113 	ld	hl, #_g_pixelMask + 1
   2370 6E            [ 7]  114 	ld	l,(hl)
   2371 A5            [ 4]  115 	and	a, l
                            116 ;src/Textures.c:36: p2 = p2 | (p2<<1);
   2372 6F            [ 4]  117 	ld	l,a
   2373 87            [ 4]  118 	add	a, a
   2374 B5            [ 4]  119 	or	a, l
                            120 ;src/Textures.c:37: *currPos = p2;
   2375 E1            [10]  121 	pop	hl
   2376 E5            [11]  122 	push	hl
   2377 77            [ 7]  123 	ld	(hl),a
                            124 ;src/Textures.c:38: currPos+=tex_width;
   2378 DD 7E F8      [19]  125 	ld	a,-8 (ix)
   237B 81            [ 4]  126 	add	a, c
   237C DD 77 FB      [19]  127 	ld	-5 (ix),a
   237F DD 7E F9      [19]  128 	ld	a,-7 (ix)
   2382 CE 00         [ 7]  129 	adc	a, #0x00
   2384 DD 77 FC      [19]  130 	ld	-4 (ix),a
                            131 ;src/Textures.c:39: --sizeY;
   2387 05            [ 4]  132 	dec	b
                            133 ;src/Textures.c:40: ++texture;
   2388 DD 34 FD      [23]  134 	inc	-3 (ix)
   238B 20 B0         [12]  135 	jr	NZ,00101$
   238D DD 34 FE      [23]  136 	inc	-2 (ix)
   2390 18 AB         [12]  137 	jr	00101$
   2392                     138 00113$:
   2392 DD 7E FD      [19]  139 	ld	a,-3 (ix)
   2395 DD 77 04      [19]  140 	ld	4 (ix),a
   2398 DD 7E FE      [19]  141 	ld	a,-2 (ix)
   239B DD 77 05      [19]  142 	ld	5 (ix),a
                            143 ;src/Textures.c:42: --sizeX;
   239E DD 35 FF      [23]  144 	dec	-1 (ix)
                            145 ;src/Textures.c:43: sizeY=tex_height;
   23A1 DD 7E FA      [19]  146 	ld	a,-6 (ix)
   23A4 DD 77 09      [19]  147 	ld	9 (ix),a
                            148 ;src/Textures.c:44: ++position;
   23A7 13            [ 6]  149 	inc	de
   23A8 C3 21 23      [10]  150 	jp	00104$
   23AB                     151 00107$:
   23AB DD F9         [10]  152 	ld	sp, ix
   23AD DD E1         [14]  153 	pop	ix
   23AF C9            [10]  154 	ret
   23B0                     155 _theme_textures:
   23B0 C6 30               156 	.dw _level0_walls_tileset
   23B2 D0 3A               157 	.dw _level1_walls_tileset
   23B4 D0 3A               158 	.dw _level1_walls_tileset
   23B6 D0 3A               159 	.dw _level1_walls_tileset
   23B8                     160 _enemy_textures:
   23B8 A8 2B               161 	.dw _level0_enemies_tileset
   23BA A8 2B               162 	.dw _level0_enemies_tileset
   23BC A8 2B               163 	.dw _level0_enemies_tileset
   23BE A8 2B               164 	.dw _level0_enemies_tileset
                            165 ;src/Textures.c:49: void uncompress_theme_textures(u8 level){//TODO implement
                            166 ;	---------------------------------
                            167 ; Function uncompress_theme_textures
                            168 ; ---------------------------------
   23C0                     169 _uncompress_theme_textures::
   23C0 DD E5         [15]  170 	push	ix
   23C2 DD 21 00 00   [14]  171 	ld	ix,#0
   23C6 DD 39         [15]  172 	add	ix,sp
                            173 ;src/Textures.c:50: uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_TEXTURES,TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   23C8 01 B0 23      [10]  174 	ld	bc,#_theme_textures+0
   23CB DD 6E 04      [19]  175 	ld	l,4 (ix)
   23CE 26 00         [ 7]  176 	ld	h,#0x00
   23D0 29            [11]  177 	add	hl, hl
   23D1 09            [11]  178 	add	hl,bc
   23D2 4D            [ 4]  179 	ld	c,l
   23D3 44            [ 4]  180 	ld	b,h
   23D4 5E            [ 7]  181 	ld	e,(hl)
   23D5 23            [ 6]  182 	inc	hl
   23D6 66            [ 7]  183 	ld	h,(hl)
   23D7 6B            [ 4]  184 	ld	l, e
   23D8 5E            [ 7]  185 	ld	e,(hl)
   23D9 23            [ 6]  186 	inc	hl
   23DA 56            [ 7]  187 	ld	d,(hl)
   23DB C5            [11]  188 	push	bc
   23DC 21 20 10      [10]  189 	ld	hl,#0x1020
   23DF E5            [11]  190 	push	hl
   23E0 21 00 64      [10]  191 	ld	hl,#0x6400
   23E3 E5            [11]  192 	push	hl
   23E4 D5            [11]  193 	push	de
   23E5 CD 02 23      [17]  194 	call	_uncompress_texture
   23E8 21 06 00      [10]  195 	ld	hl,#6
   23EB 39            [11]  196 	add	hl,sp
   23EC F9            [ 6]  197 	ld	sp,hl
   23ED C1            [10]  198 	pop	bc
                            199 ;src/Textures.c:51: uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_TEXTURES+1024),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   23EE 69            [ 4]  200 	ld	l, c
   23EF 60            [ 4]  201 	ld	h, b
   23F0 5E            [ 7]  202 	ld	e,(hl)
   23F1 23            [ 6]  203 	inc	hl
   23F2 66            [ 7]  204 	ld	h,(hl)
   23F3 6B            [ 4]  205 	ld	l, e
   23F4 23            [ 6]  206 	inc	hl
   23F5 23            [ 6]  207 	inc	hl
   23F6 5E            [ 7]  208 	ld	e,(hl)
   23F7 23            [ 6]  209 	inc	hl
   23F8 56            [ 7]  210 	ld	d,(hl)
   23F9 C5            [11]  211 	push	bc
   23FA 21 20 10      [10]  212 	ld	hl,#0x1020
   23FD E5            [11]  213 	push	hl
   23FE 21 00 68      [10]  214 	ld	hl,#0x6800
   2401 E5            [11]  215 	push	hl
   2402 D5            [11]  216 	push	de
   2403 CD 02 23      [17]  217 	call	_uncompress_texture
   2406 21 06 00      [10]  218 	ld	hl,#6
   2409 39            [11]  219 	add	hl,sp
   240A F9            [ 6]  220 	ld	sp,hl
   240B C1            [10]  221 	pop	bc
                            222 ;src/Textures.c:52: uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_TEXTURES+2048),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   240C 69            [ 4]  223 	ld	l, c
   240D 60            [ 4]  224 	ld	h, b
   240E 5E            [ 7]  225 	ld	e,(hl)
   240F 23            [ 6]  226 	inc	hl
   2410 66            [ 7]  227 	ld	h,(hl)
   2411 6B            [ 4]  228 	ld	l, e
   2412 11 04 00      [10]  229 	ld	de, #0x0004
   2415 19            [11]  230 	add	hl, de
   2416 5E            [ 7]  231 	ld	e,(hl)
   2417 23            [ 6]  232 	inc	hl
   2418 56            [ 7]  233 	ld	d,(hl)
   2419 C5            [11]  234 	push	bc
   241A 21 20 10      [10]  235 	ld	hl,#0x1020
   241D E5            [11]  236 	push	hl
   241E 21 00 6C      [10]  237 	ld	hl,#0x6C00
   2421 E5            [11]  238 	push	hl
   2422 D5            [11]  239 	push	de
   2423 CD 02 23      [17]  240 	call	_uncompress_texture
   2426 21 06 00      [10]  241 	ld	hl,#6
   2429 39            [11]  242 	add	hl,sp
   242A F9            [ 6]  243 	ld	sp,hl
   242B C1            [10]  244 	pop	bc
                            245 ;src/Textures.c:53: uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_TEXTURES+3072),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   242C 69            [ 4]  246 	ld	l, c
   242D 60            [ 4]  247 	ld	h, b
   242E 5E            [ 7]  248 	ld	e,(hl)
   242F 23            [ 6]  249 	inc	hl
   2430 66            [ 7]  250 	ld	h,(hl)
   2431 6B            [ 4]  251 	ld	l, e
   2432 11 06 00      [10]  252 	ld	de, #0x0006
   2435 19            [11]  253 	add	hl, de
   2436 5E            [ 7]  254 	ld	e,(hl)
   2437 23            [ 6]  255 	inc	hl
   2438 56            [ 7]  256 	ld	d,(hl)
   2439 C5            [11]  257 	push	bc
   243A 21 20 10      [10]  258 	ld	hl,#0x1020
   243D E5            [11]  259 	push	hl
   243E 21 00 70      [10]  260 	ld	hl,#0x7000
   2441 E5            [11]  261 	push	hl
   2442 D5            [11]  262 	push	de
   2443 CD 02 23      [17]  263 	call	_uncompress_texture
   2446 21 06 00      [10]  264 	ld	hl,#6
   2449 39            [11]  265 	add	hl,sp
   244A F9            [ 6]  266 	ld	sp,hl
                            267 ;src/Textures.c:54: uncompress_texture(theme_textures[level][4],(u8*)(UNCOMPRESSED_TEXTURES+4096),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   244B E1            [10]  268 	pop	hl
   244C 4E            [ 7]  269 	ld	c,(hl)
   244D 23            [ 6]  270 	inc	hl
   244E 66            [ 7]  271 	ld	h,(hl)
   244F 69            [ 4]  272 	ld	l, c
   2450 11 08 00      [10]  273 	ld	de, #0x0008
   2453 19            [11]  274 	add	hl, de
   2454 4E            [ 7]  275 	ld	c,(hl)
   2455 23            [ 6]  276 	inc	hl
   2456 46            [ 7]  277 	ld	b,(hl)
   2457 21 20 10      [10]  278 	ld	hl,#0x1020
   245A E5            [11]  279 	push	hl
   245B 21 00 74      [10]  280 	ld	hl,#0x7400
   245E E5            [11]  281 	push	hl
   245F C5            [11]  282 	push	bc
   2460 CD 02 23      [17]  283 	call	_uncompress_texture
   2463 21 06 00      [10]  284 	ld	hl,#6
   2466 39            [11]  285 	add	hl,sp
   2467 F9            [ 6]  286 	ld	sp,hl
   2468 DD E1         [14]  287 	pop	ix
   246A C9            [10]  288 	ret
                            289 ;src/Textures.c:57: void uncompress_enemy_textures(u8 level){
                            290 ;	---------------------------------
                            291 ; Function uncompress_enemy_textures
                            292 ; ---------------------------------
   246B                     293 _uncompress_enemy_textures::
   246B DD E5         [15]  294 	push	ix
   246D DD 21 00 00   [14]  295 	ld	ix,#0
   2471 DD 39         [15]  296 	add	ix,sp
                            297 ;src/Textures.c:58: uncompress_texture(enemy_textures[level][0],(u8*)UNCOMPRESSED_ENEMY_TEXTURES,ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   2473 01 B8 23      [10]  298 	ld	bc,#_enemy_textures+0
   2476 DD 6E 04      [19]  299 	ld	l,4 (ix)
   2479 26 00         [ 7]  300 	ld	h,#0x00
   247B 29            [11]  301 	add	hl, hl
   247C 09            [11]  302 	add	hl,bc
   247D 4D            [ 4]  303 	ld	c,l
   247E 44            [ 4]  304 	ld	b,h
   247F 5E            [ 7]  305 	ld	e,(hl)
   2480 23            [ 6]  306 	inc	hl
   2481 66            [ 7]  307 	ld	h,(hl)
   2482 6B            [ 4]  308 	ld	l, e
   2483 5E            [ 7]  309 	ld	e,(hl)
   2484 23            [ 6]  310 	inc	hl
   2485 56            [ 7]  311 	ld	d,(hl)
   2486 C5            [11]  312 	push	bc
   2487 21 18 0C      [10]  313 	ld	hl,#0x0C18
   248A E5            [11]  314 	push	hl
   248B 21 00 78      [10]  315 	ld	hl,#0x7800
   248E E5            [11]  316 	push	hl
   248F D5            [11]  317 	push	de
   2490 CD 02 23      [17]  318 	call	_uncompress_texture
   2493 21 06 00      [10]  319 	ld	hl,#6
   2496 39            [11]  320 	add	hl,sp
   2497 F9            [ 6]  321 	ld	sp,hl
   2498 C1            [10]  322 	pop	bc
                            323 ;src/Textures.c:59: uncompress_texture(enemy_textures[level][1],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+576),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   2499 69            [ 4]  324 	ld	l, c
   249A 60            [ 4]  325 	ld	h, b
   249B 5E            [ 7]  326 	ld	e,(hl)
   249C 23            [ 6]  327 	inc	hl
   249D 66            [ 7]  328 	ld	h,(hl)
   249E 6B            [ 4]  329 	ld	l, e
   249F 23            [ 6]  330 	inc	hl
   24A0 23            [ 6]  331 	inc	hl
   24A1 5E            [ 7]  332 	ld	e,(hl)
   24A2 23            [ 6]  333 	inc	hl
   24A3 56            [ 7]  334 	ld	d,(hl)
   24A4 C5            [11]  335 	push	bc
   24A5 21 18 0C      [10]  336 	ld	hl,#0x0C18
   24A8 E5            [11]  337 	push	hl
   24A9 21 40 7A      [10]  338 	ld	hl,#0x7A40
   24AC E5            [11]  339 	push	hl
   24AD D5            [11]  340 	push	de
   24AE CD 02 23      [17]  341 	call	_uncompress_texture
   24B1 21 06 00      [10]  342 	ld	hl,#6
   24B4 39            [11]  343 	add	hl,sp
   24B5 F9            [ 6]  344 	ld	sp,hl
   24B6 C1            [10]  345 	pop	bc
                            346 ;src/Textures.c:60: uncompress_texture(enemy_textures[level][2],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1152),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   24B7 69            [ 4]  347 	ld	l, c
   24B8 60            [ 4]  348 	ld	h, b
   24B9 5E            [ 7]  349 	ld	e,(hl)
   24BA 23            [ 6]  350 	inc	hl
   24BB 66            [ 7]  351 	ld	h,(hl)
   24BC 6B            [ 4]  352 	ld	l, e
   24BD 11 04 00      [10]  353 	ld	de, #0x0004
   24C0 19            [11]  354 	add	hl, de
   24C1 5E            [ 7]  355 	ld	e,(hl)
   24C2 23            [ 6]  356 	inc	hl
   24C3 56            [ 7]  357 	ld	d,(hl)
   24C4 C5            [11]  358 	push	bc
   24C5 21 18 0C      [10]  359 	ld	hl,#0x0C18
   24C8 E5            [11]  360 	push	hl
   24C9 21 80 7C      [10]  361 	ld	hl,#0x7C80
   24CC E5            [11]  362 	push	hl
   24CD D5            [11]  363 	push	de
   24CE CD 02 23      [17]  364 	call	_uncompress_texture
   24D1 21 06 00      [10]  365 	ld	hl,#6
   24D4 39            [11]  366 	add	hl,sp
   24D5 F9            [ 6]  367 	ld	sp,hl
                            368 ;src/Textures.c:61: uncompress_texture(enemy_textures[level][3],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1728),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   24D6 E1            [10]  369 	pop	hl
   24D7 4E            [ 7]  370 	ld	c,(hl)
   24D8 23            [ 6]  371 	inc	hl
   24D9 66            [ 7]  372 	ld	h,(hl)
   24DA 69            [ 4]  373 	ld	l, c
   24DB 11 06 00      [10]  374 	ld	de, #0x0006
   24DE 19            [11]  375 	add	hl, de
   24DF 4E            [ 7]  376 	ld	c,(hl)
   24E0 23            [ 6]  377 	inc	hl
   24E1 46            [ 7]  378 	ld	b,(hl)
   24E2 21 18 0C      [10]  379 	ld	hl,#0x0C18
   24E5 E5            [11]  380 	push	hl
   24E6 21 C0 7E      [10]  381 	ld	hl,#0x7EC0
   24E9 E5            [11]  382 	push	hl
   24EA C5            [11]  383 	push	bc
   24EB CD 02 23      [17]  384 	call	_uncompress_texture
   24EE 21 06 00      [10]  385 	ld	hl,#6
   24F1 39            [11]  386 	add	hl,sp
   24F2 F9            [ 6]  387 	ld	sp,hl
   24F3 DD E1         [14]  388 	pop	ix
   24F5 C9            [10]  389 	ret
                            390 ;src/Textures.c:64: void uncompress_item_textures(){
                            391 ;	---------------------------------
                            392 ; Function uncompress_item_textures
                            393 ; ---------------------------------
   24F6                     394 _uncompress_item_textures::
                            395 ;src/Textures.c:66: }
   24F6 C9            [10]  396 	ret
                            397 	.area _CODE
                            398 	.area _INITIALIZER
                            399 	.area _CABS (ABS)
