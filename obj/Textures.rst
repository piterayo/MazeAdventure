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
   21E6                      52 _uncompress_texture::
   21E6 DD E5         [15]   53 	push	ix
   21E8 DD 21 00 00   [14]   54 	ld	ix,#0
   21EC DD 39         [15]   55 	add	ix,sp
   21EE 21 F8 FF      [10]   56 	ld	hl,#-8
   21F1 39            [11]   57 	add	hl,sp
   21F2 F9            [ 6]   58 	ld	sp,hl
                             59 ;src/Textures.c:20: u8 p1, p2, tex_height=sizeY, tex_width = sizeX;
   21F3 DD 7E 09      [19]   60 	ld	a,9 (ix)
   21F6 DD 77 FA      [19]   61 	ld	-6 (ix),a
   21F9 DD 4E 08      [19]   62 	ld	c,8 (ix)
                             63 ;src/Textures.c:26: while(sizeX){
   21FC DD 71 FF      [19]   64 	ld	-1 (ix),c
   21FF DD 5E 06      [19]   65 	ld	e,6 (ix)
   2202 DD 56 07      [19]   66 	ld	d,7 (ix)
   2205                      67 00104$:
   2205 DD 7E FF      [19]   68 	ld	a,-1 (ix)
   2208 B7            [ 4]   69 	or	a, a
   2209 CA 8F 22      [10]   70 	jp	Z,00107$
                             71 ;src/Textures.c:28: currPos = position;
   220C DD 73 FB      [19]   72 	ld	-5 (ix),e
   220F DD 72 FC      [19]   73 	ld	-4 (ix),d
                             74 ;src/Textures.c:29: while(sizeY){
   2212 DD 46 09      [19]   75 	ld	b,9 (ix)
   2215 DD 7E 04      [19]   76 	ld	a,4 (ix)
   2218 DD 77 FD      [19]   77 	ld	-3 (ix),a
   221B DD 7E 05      [19]   78 	ld	a,5 (ix)
   221E DD 77 FE      [19]   79 	ld	-2 (ix),a
   2221                      80 00101$:
   2221 78            [ 4]   81 	ld	a,b
   2222 B7            [ 4]   82 	or	a, a
   2223 28 51         [12]   83 	jr	Z,00113$
                             84 ;src/Textures.c:30: p1 = (*texture) & g_pixelMask[0];
   2225 DD 6E FD      [19]   85 	ld	l,-3 (ix)
   2228 DD 66 FE      [19]   86 	ld	h,-2 (ix)
   222B 7E            [ 7]   87 	ld	a,(hl)
   222C 21 B5 0A      [10]   88 	ld	hl, #_g_pixelMask + 0
   222F 6E            [ 7]   89 	ld	l,(hl)
   2230 A5            [ 4]   90 	and	a, l
                             91 ;src/Textures.c:31: p1= p1 | (p1>>1);
   2231 6F            [ 4]   92 	ld	l,a
   2232 CB 3F         [ 8]   93 	srl	a
   2234 B5            [ 4]   94 	or	a, l
                             95 ;src/Textures.c:32: *currPos = p1;
   2235 DD 6E FB      [19]   96 	ld	l,-5 (ix)
   2238 DD 66 FC      [19]   97 	ld	h,-4 (ix)
   223B 77            [ 7]   98 	ld	(hl),a
                             99 ;src/Textures.c:33: currPos+=tex_width;
   223C DD 7E FB      [19]  100 	ld	a,-5 (ix)
   223F 81            [ 4]  101 	add	a, c
   2240 6F            [ 4]  102 	ld	l,a
   2241 DD 7E FC      [19]  103 	ld	a,-4 (ix)
   2244 CE 00         [ 7]  104 	adc	a, #0x00
   2246 67            [ 4]  105 	ld	h,a
   2247 33            [ 6]  106 	inc	sp
   2248 33            [ 6]  107 	inc	sp
   2249 E5            [11]  108 	push	hl
                            109 ;src/Textures.c:35: p2 = (*texture) & g_pixelMask[1];
   224A DD 6E FD      [19]  110 	ld	l,-3 (ix)
   224D DD 66 FE      [19]  111 	ld	h,-2 (ix)
   2250 7E            [ 7]  112 	ld	a,(hl)
   2251 21 B6 0A      [10]  113 	ld	hl, #_g_pixelMask + 1
   2254 6E            [ 7]  114 	ld	l,(hl)
   2255 A5            [ 4]  115 	and	a, l
                            116 ;src/Textures.c:36: p2 = p2 | (p2<<1);
   2256 6F            [ 4]  117 	ld	l,a
   2257 87            [ 4]  118 	add	a, a
   2258 B5            [ 4]  119 	or	a, l
                            120 ;src/Textures.c:37: *currPos = p2;
   2259 E1            [10]  121 	pop	hl
   225A E5            [11]  122 	push	hl
   225B 77            [ 7]  123 	ld	(hl),a
                            124 ;src/Textures.c:38: currPos+=tex_width;
   225C DD 7E F8      [19]  125 	ld	a,-8 (ix)
   225F 81            [ 4]  126 	add	a, c
   2260 DD 77 FB      [19]  127 	ld	-5 (ix),a
   2263 DD 7E F9      [19]  128 	ld	a,-7 (ix)
   2266 CE 00         [ 7]  129 	adc	a, #0x00
   2268 DD 77 FC      [19]  130 	ld	-4 (ix),a
                            131 ;src/Textures.c:39: --sizeY;
   226B 05            [ 4]  132 	dec	b
                            133 ;src/Textures.c:40: ++texture;
   226C DD 34 FD      [23]  134 	inc	-3 (ix)
   226F 20 B0         [12]  135 	jr	NZ,00101$
   2271 DD 34 FE      [23]  136 	inc	-2 (ix)
   2274 18 AB         [12]  137 	jr	00101$
   2276                     138 00113$:
   2276 DD 7E FD      [19]  139 	ld	a,-3 (ix)
   2279 DD 77 04      [19]  140 	ld	4 (ix),a
   227C DD 7E FE      [19]  141 	ld	a,-2 (ix)
   227F DD 77 05      [19]  142 	ld	5 (ix),a
                            143 ;src/Textures.c:42: --sizeX;
   2282 DD 35 FF      [23]  144 	dec	-1 (ix)
                            145 ;src/Textures.c:43: sizeY=tex_height;
   2285 DD 7E FA      [19]  146 	ld	a,-6 (ix)
   2288 DD 77 09      [19]  147 	ld	9 (ix),a
                            148 ;src/Textures.c:44: ++position;
   228B 13            [ 6]  149 	inc	de
   228C C3 05 22      [10]  150 	jp	00104$
   228F                     151 00107$:
   228F DD F9         [10]  152 	ld	sp, ix
   2291 DD E1         [14]  153 	pop	ix
   2293 C9            [10]  154 	ret
   2294                     155 _theme_textures:
   2294 F3 2C               156 	.dw _level0_walls_tileset
   2296 FD 36               157 	.dw _level1_walls_tileset
   2298 FD 36               158 	.dw _level1_walls_tileset
   229A FD 36               159 	.dw _level1_walls_tileset
   229C                     160 _enemy_textures:
   229C D5 27               161 	.dw _level0_enemies_tileset
   229E D5 27               162 	.dw _level0_enemies_tileset
   22A0 D5 27               163 	.dw _level0_enemies_tileset
   22A2 D5 27               164 	.dw _level0_enemies_tileset
                            165 ;src/Textures.c:49: void uncompress_theme_textures(u8 level){//TODO implement
                            166 ;	---------------------------------
                            167 ; Function uncompress_theme_textures
                            168 ; ---------------------------------
   22A4                     169 _uncompress_theme_textures::
   22A4 DD E5         [15]  170 	push	ix
   22A6 DD 21 00 00   [14]  171 	ld	ix,#0
   22AA DD 39         [15]  172 	add	ix,sp
                            173 ;src/Textures.c:50: uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_TEXTURES,TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   22AC 01 94 22      [10]  174 	ld	bc,#_theme_textures+0
   22AF DD 6E 04      [19]  175 	ld	l,4 (ix)
   22B2 26 00         [ 7]  176 	ld	h,#0x00
   22B4 29            [11]  177 	add	hl, hl
   22B5 09            [11]  178 	add	hl,bc
   22B6 4D            [ 4]  179 	ld	c,l
   22B7 44            [ 4]  180 	ld	b,h
   22B8 5E            [ 7]  181 	ld	e,(hl)
   22B9 23            [ 6]  182 	inc	hl
   22BA 66            [ 7]  183 	ld	h,(hl)
   22BB 6B            [ 4]  184 	ld	l, e
   22BC 5E            [ 7]  185 	ld	e,(hl)
   22BD 23            [ 6]  186 	inc	hl
   22BE 56            [ 7]  187 	ld	d,(hl)
   22BF C5            [11]  188 	push	bc
   22C0 21 20 10      [10]  189 	ld	hl,#0x1020
   22C3 E5            [11]  190 	push	hl
   22C4 21 00 64      [10]  191 	ld	hl,#0x6400
   22C7 E5            [11]  192 	push	hl
   22C8 D5            [11]  193 	push	de
   22C9 CD E6 21      [17]  194 	call	_uncompress_texture
   22CC 21 06 00      [10]  195 	ld	hl,#6
   22CF 39            [11]  196 	add	hl,sp
   22D0 F9            [ 6]  197 	ld	sp,hl
   22D1 C1            [10]  198 	pop	bc
                            199 ;src/Textures.c:51: uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_TEXTURES+1024),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   22D2 69            [ 4]  200 	ld	l, c
   22D3 60            [ 4]  201 	ld	h, b
   22D4 5E            [ 7]  202 	ld	e,(hl)
   22D5 23            [ 6]  203 	inc	hl
   22D6 66            [ 7]  204 	ld	h,(hl)
   22D7 6B            [ 4]  205 	ld	l, e
   22D8 23            [ 6]  206 	inc	hl
   22D9 23            [ 6]  207 	inc	hl
   22DA 5E            [ 7]  208 	ld	e,(hl)
   22DB 23            [ 6]  209 	inc	hl
   22DC 56            [ 7]  210 	ld	d,(hl)
   22DD C5            [11]  211 	push	bc
   22DE 21 20 10      [10]  212 	ld	hl,#0x1020
   22E1 E5            [11]  213 	push	hl
   22E2 21 00 68      [10]  214 	ld	hl,#0x6800
   22E5 E5            [11]  215 	push	hl
   22E6 D5            [11]  216 	push	de
   22E7 CD E6 21      [17]  217 	call	_uncompress_texture
   22EA 21 06 00      [10]  218 	ld	hl,#6
   22ED 39            [11]  219 	add	hl,sp
   22EE F9            [ 6]  220 	ld	sp,hl
   22EF C1            [10]  221 	pop	bc
                            222 ;src/Textures.c:52: uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_TEXTURES+2048),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   22F0 69            [ 4]  223 	ld	l, c
   22F1 60            [ 4]  224 	ld	h, b
   22F2 5E            [ 7]  225 	ld	e,(hl)
   22F3 23            [ 6]  226 	inc	hl
   22F4 66            [ 7]  227 	ld	h,(hl)
   22F5 6B            [ 4]  228 	ld	l, e
   22F6 11 04 00      [10]  229 	ld	de, #0x0004
   22F9 19            [11]  230 	add	hl, de
   22FA 5E            [ 7]  231 	ld	e,(hl)
   22FB 23            [ 6]  232 	inc	hl
   22FC 56            [ 7]  233 	ld	d,(hl)
   22FD C5            [11]  234 	push	bc
   22FE 21 20 10      [10]  235 	ld	hl,#0x1020
   2301 E5            [11]  236 	push	hl
   2302 21 00 6C      [10]  237 	ld	hl,#0x6C00
   2305 E5            [11]  238 	push	hl
   2306 D5            [11]  239 	push	de
   2307 CD E6 21      [17]  240 	call	_uncompress_texture
   230A 21 06 00      [10]  241 	ld	hl,#6
   230D 39            [11]  242 	add	hl,sp
   230E F9            [ 6]  243 	ld	sp,hl
   230F C1            [10]  244 	pop	bc
                            245 ;src/Textures.c:53: uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_TEXTURES+3072),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   2310 69            [ 4]  246 	ld	l, c
   2311 60            [ 4]  247 	ld	h, b
   2312 5E            [ 7]  248 	ld	e,(hl)
   2313 23            [ 6]  249 	inc	hl
   2314 66            [ 7]  250 	ld	h,(hl)
   2315 6B            [ 4]  251 	ld	l, e
   2316 11 06 00      [10]  252 	ld	de, #0x0006
   2319 19            [11]  253 	add	hl, de
   231A 5E            [ 7]  254 	ld	e,(hl)
   231B 23            [ 6]  255 	inc	hl
   231C 56            [ 7]  256 	ld	d,(hl)
   231D C5            [11]  257 	push	bc
   231E 21 20 10      [10]  258 	ld	hl,#0x1020
   2321 E5            [11]  259 	push	hl
   2322 21 00 70      [10]  260 	ld	hl,#0x7000
   2325 E5            [11]  261 	push	hl
   2326 D5            [11]  262 	push	de
   2327 CD E6 21      [17]  263 	call	_uncompress_texture
   232A 21 06 00      [10]  264 	ld	hl,#6
   232D 39            [11]  265 	add	hl,sp
   232E F9            [ 6]  266 	ld	sp,hl
                            267 ;src/Textures.c:54: uncompress_texture(theme_textures[level][4],(u8*)(UNCOMPRESSED_TEXTURES+4096),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   232F E1            [10]  268 	pop	hl
   2330 4E            [ 7]  269 	ld	c,(hl)
   2331 23            [ 6]  270 	inc	hl
   2332 66            [ 7]  271 	ld	h,(hl)
   2333 69            [ 4]  272 	ld	l, c
   2334 11 08 00      [10]  273 	ld	de, #0x0008
   2337 19            [11]  274 	add	hl, de
   2338 4E            [ 7]  275 	ld	c,(hl)
   2339 23            [ 6]  276 	inc	hl
   233A 46            [ 7]  277 	ld	b,(hl)
   233B 21 20 10      [10]  278 	ld	hl,#0x1020
   233E E5            [11]  279 	push	hl
   233F 21 00 74      [10]  280 	ld	hl,#0x7400
   2342 E5            [11]  281 	push	hl
   2343 C5            [11]  282 	push	bc
   2344 CD E6 21      [17]  283 	call	_uncompress_texture
   2347 21 06 00      [10]  284 	ld	hl,#6
   234A 39            [11]  285 	add	hl,sp
   234B F9            [ 6]  286 	ld	sp,hl
   234C DD E1         [14]  287 	pop	ix
   234E C9            [10]  288 	ret
                            289 ;src/Textures.c:57: void uncompress_enemy_textures(u8 level){
                            290 ;	---------------------------------
                            291 ; Function uncompress_enemy_textures
                            292 ; ---------------------------------
   234F                     293 _uncompress_enemy_textures::
   234F DD E5         [15]  294 	push	ix
   2351 DD 21 00 00   [14]  295 	ld	ix,#0
   2355 DD 39         [15]  296 	add	ix,sp
                            297 ;src/Textures.c:58: uncompress_texture(enemy_textures[level][0],(u8*)UNCOMPRESSED_ENEMY_TEXTURES,ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   2357 01 9C 22      [10]  298 	ld	bc,#_enemy_textures+0
   235A DD 6E 04      [19]  299 	ld	l,4 (ix)
   235D 26 00         [ 7]  300 	ld	h,#0x00
   235F 29            [11]  301 	add	hl, hl
   2360 09            [11]  302 	add	hl,bc
   2361 4D            [ 4]  303 	ld	c,l
   2362 44            [ 4]  304 	ld	b,h
   2363 5E            [ 7]  305 	ld	e,(hl)
   2364 23            [ 6]  306 	inc	hl
   2365 66            [ 7]  307 	ld	h,(hl)
   2366 6B            [ 4]  308 	ld	l, e
   2367 5E            [ 7]  309 	ld	e,(hl)
   2368 23            [ 6]  310 	inc	hl
   2369 56            [ 7]  311 	ld	d,(hl)
   236A C5            [11]  312 	push	bc
   236B 21 18 0C      [10]  313 	ld	hl,#0x0C18
   236E E5            [11]  314 	push	hl
   236F 21 00 78      [10]  315 	ld	hl,#0x7800
   2372 E5            [11]  316 	push	hl
   2373 D5            [11]  317 	push	de
   2374 CD E6 21      [17]  318 	call	_uncompress_texture
   2377 21 06 00      [10]  319 	ld	hl,#6
   237A 39            [11]  320 	add	hl,sp
   237B F9            [ 6]  321 	ld	sp,hl
   237C C1            [10]  322 	pop	bc
                            323 ;src/Textures.c:59: uncompress_texture(enemy_textures[level][1],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+576),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   237D 69            [ 4]  324 	ld	l, c
   237E 60            [ 4]  325 	ld	h, b
   237F 5E            [ 7]  326 	ld	e,(hl)
   2380 23            [ 6]  327 	inc	hl
   2381 66            [ 7]  328 	ld	h,(hl)
   2382 6B            [ 4]  329 	ld	l, e
   2383 23            [ 6]  330 	inc	hl
   2384 23            [ 6]  331 	inc	hl
   2385 5E            [ 7]  332 	ld	e,(hl)
   2386 23            [ 6]  333 	inc	hl
   2387 56            [ 7]  334 	ld	d,(hl)
   2388 C5            [11]  335 	push	bc
   2389 21 18 0C      [10]  336 	ld	hl,#0x0C18
   238C E5            [11]  337 	push	hl
   238D 21 40 7A      [10]  338 	ld	hl,#0x7A40
   2390 E5            [11]  339 	push	hl
   2391 D5            [11]  340 	push	de
   2392 CD E6 21      [17]  341 	call	_uncompress_texture
   2395 21 06 00      [10]  342 	ld	hl,#6
   2398 39            [11]  343 	add	hl,sp
   2399 F9            [ 6]  344 	ld	sp,hl
   239A C1            [10]  345 	pop	bc
                            346 ;src/Textures.c:60: uncompress_texture(enemy_textures[level][2],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1152),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   239B 69            [ 4]  347 	ld	l, c
   239C 60            [ 4]  348 	ld	h, b
   239D 5E            [ 7]  349 	ld	e,(hl)
   239E 23            [ 6]  350 	inc	hl
   239F 66            [ 7]  351 	ld	h,(hl)
   23A0 6B            [ 4]  352 	ld	l, e
   23A1 11 04 00      [10]  353 	ld	de, #0x0004
   23A4 19            [11]  354 	add	hl, de
   23A5 5E            [ 7]  355 	ld	e,(hl)
   23A6 23            [ 6]  356 	inc	hl
   23A7 56            [ 7]  357 	ld	d,(hl)
   23A8 C5            [11]  358 	push	bc
   23A9 21 18 0C      [10]  359 	ld	hl,#0x0C18
   23AC E5            [11]  360 	push	hl
   23AD 21 80 7C      [10]  361 	ld	hl,#0x7C80
   23B0 E5            [11]  362 	push	hl
   23B1 D5            [11]  363 	push	de
   23B2 CD E6 21      [17]  364 	call	_uncompress_texture
   23B5 21 06 00      [10]  365 	ld	hl,#6
   23B8 39            [11]  366 	add	hl,sp
   23B9 F9            [ 6]  367 	ld	sp,hl
                            368 ;src/Textures.c:61: uncompress_texture(enemy_textures[level][3],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1728),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   23BA E1            [10]  369 	pop	hl
   23BB 4E            [ 7]  370 	ld	c,(hl)
   23BC 23            [ 6]  371 	inc	hl
   23BD 66            [ 7]  372 	ld	h,(hl)
   23BE 69            [ 4]  373 	ld	l, c
   23BF 11 06 00      [10]  374 	ld	de, #0x0006
   23C2 19            [11]  375 	add	hl, de
   23C3 4E            [ 7]  376 	ld	c,(hl)
   23C4 23            [ 6]  377 	inc	hl
   23C5 46            [ 7]  378 	ld	b,(hl)
   23C6 21 18 0C      [10]  379 	ld	hl,#0x0C18
   23C9 E5            [11]  380 	push	hl
   23CA 21 C0 7E      [10]  381 	ld	hl,#0x7EC0
   23CD E5            [11]  382 	push	hl
   23CE C5            [11]  383 	push	bc
   23CF CD E6 21      [17]  384 	call	_uncompress_texture
   23D2 21 06 00      [10]  385 	ld	hl,#6
   23D5 39            [11]  386 	add	hl,sp
   23D6 F9            [ 6]  387 	ld	sp,hl
   23D7 DD E1         [14]  388 	pop	ix
   23D9 C9            [10]  389 	ret
                            390 ;src/Textures.c:64: void uncompress_item_textures(){
                            391 ;	---------------------------------
                            392 ; Function uncompress_item_textures
                            393 ; ---------------------------------
   23DA                     394 _uncompress_item_textures::
                            395 ;src/Textures.c:66: }
   23DA C9            [10]  396 	ret
                            397 	.area _CODE
                            398 	.area _INITIALIZER
                            399 	.area _CABS (ABS)
