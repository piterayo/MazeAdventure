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
                             48 ;src/Textures.c:17: void uncompress_texture(u8* texture, u8* position, u8 sizeX, u8 sizeY){
                             49 ;	---------------------------------
                             50 ; Function uncompress_texture
                             51 ; ---------------------------------
   524D                      52 _uncompress_texture::
   524D DD E5         [15]   53 	push	ix
   524F DD 21 00 00   [14]   54 	ld	ix,#0
   5253 DD 39         [15]   55 	add	ix,sp
   5255 21 F9 FF      [10]   56 	ld	hl,#-7
   5258 39            [11]   57 	add	hl,sp
   5259 F9            [ 6]   58 	ld	sp,hl
                             59 ;src/Textures.c:18: u8 p1, p2, tex_height=sizeY;
   525A DD 7E 09      [19]   60 	ld	a,9 (ix)
   525D DD 77 FB      [19]   61 	ld	-5 (ix),a
                             62 ;src/Textures.c:24: while(sizeX){
   5260 DD 7E 08      [19]   63 	ld	a,8 (ix)
   5263 DD 77 FC      [19]   64 	ld	-4 (ix),a
   5266 DD 5E 06      [19]   65 	ld	e,6 (ix)
   5269 DD 56 07      [19]   66 	ld	d,7 (ix)
   526C                      67 00104$:
   526C DD 7E FC      [19]   68 	ld	a,-4 (ix)
   526F B7            [ 4]   69 	or	a, a
   5270 28 6D         [12]   70 	jr	Z,00107$
                             71 ;src/Textures.c:26: currPos = position;
   5272 DD 73 FD      [19]   72 	ld	-3 (ix),e
   5275 DD 72 FE      [19]   73 	ld	-2 (ix),d
                             74 ;src/Textures.c:27: while(sizeY){
   5278 DD 7E 09      [19]   75 	ld	a,9 (ix)
   527B DD 77 FF      [19]   76 	ld	-1 (ix),a
   527E DD 4E 04      [19]   77 	ld	c,4 (ix)
   5281 DD 46 05      [19]   78 	ld	b,5 (ix)
   5284                      79 00101$:
   5284 DD 7E FF      [19]   80 	ld	a,-1 (ix)
   5287 B7            [ 4]   81 	or	a, a
   5288 28 43         [12]   82 	jr	Z,00113$
                             83 ;src/Textures.c:28: p1 = (*texture) & pixelMask[0];
   528A 0A            [ 7]   84 	ld	a,(bc)
   528B 21 03 4A      [10]   85 	ld	hl, #_pixelMask + 0
   528E 6E            [ 7]   86 	ld	l,(hl)
   528F A5            [ 4]   87 	and	a, l
                             88 ;src/Textures.c:29: p1= p1 | (p1>>1);
   5290 6F            [ 4]   89 	ld	l,a
   5291 CB 3F         [ 8]   90 	srl	a
   5293 B5            [ 4]   91 	or	a, l
                             92 ;src/Textures.c:30: *currPos = p1;
   5294 DD 6E FD      [19]   93 	ld	l,-3 (ix)
   5297 DD 66 FE      [19]   94 	ld	h,-2 (ix)
   529A 77            [ 7]   95 	ld	(hl),a
                             96 ;src/Textures.c:31: currPos+=TEXTURE_WIDTH;
   529B DD 7E FD      [19]   97 	ld	a,-3 (ix)
   529E C6 20         [ 7]   98 	add	a, #0x20
   52A0 DD 77 F9      [19]   99 	ld	-7 (ix),a
   52A3 DD 7E FE      [19]  100 	ld	a,-2 (ix)
   52A6 CE 00         [ 7]  101 	adc	a, #0x00
   52A8 DD 77 FA      [19]  102 	ld	-6 (ix),a
                            103 ;src/Textures.c:33: p2 = (*texture) & pixelMask[1];
   52AB 0A            [ 7]  104 	ld	a,(bc)
   52AC 21 04 4A      [10]  105 	ld	hl, #_pixelMask + 1
   52AF 6E            [ 7]  106 	ld	l,(hl)
   52B0 A5            [ 4]  107 	and	a, l
                            108 ;src/Textures.c:34: p2 = p2 | (p2<<1);
   52B1 6F            [ 4]  109 	ld	l,a
   52B2 87            [ 4]  110 	add	a, a
   52B3 B5            [ 4]  111 	or	a, l
                            112 ;src/Textures.c:35: *currPos = p2;
   52B4 E1            [10]  113 	pop	hl
   52B5 E5            [11]  114 	push	hl
   52B6 77            [ 7]  115 	ld	(hl),a
                            116 ;src/Textures.c:36: currPos+=TEXTURE_WIDTH;
   52B7 DD 7E F9      [19]  117 	ld	a,-7 (ix)
   52BA C6 20         [ 7]  118 	add	a, #0x20
   52BC DD 77 FD      [19]  119 	ld	-3 (ix),a
   52BF DD 7E FA      [19]  120 	ld	a,-6 (ix)
   52C2 CE 00         [ 7]  121 	adc	a, #0x00
   52C4 DD 77 FE      [19]  122 	ld	-2 (ix),a
                            123 ;src/Textures.c:37: --sizeY;
   52C7 DD 35 FF      [23]  124 	dec	-1 (ix)
                            125 ;src/Textures.c:38: ++texture;
   52CA 03            [ 6]  126 	inc	bc
   52CB 18 B7         [12]  127 	jr	00101$
   52CD                     128 00113$:
   52CD DD 71 04      [19]  129 	ld	4 (ix),c
   52D0 DD 70 05      [19]  130 	ld	5 (ix),b
                            131 ;src/Textures.c:40: --sizeX;
   52D3 DD 35 FC      [23]  132 	dec	-4 (ix)
                            133 ;src/Textures.c:41: sizeY=tex_height;
   52D6 DD 7E FB      [19]  134 	ld	a,-5 (ix)
   52D9 DD 77 09      [19]  135 	ld	9 (ix),a
                            136 ;src/Textures.c:42: ++position;
   52DC 13            [ 6]  137 	inc	de
   52DD 18 8D         [12]  138 	jr	00104$
   52DF                     139 00107$:
   52DF DD F9         [10]  140 	ld	sp, ix
   52E1 DD E1         [14]  141 	pop	ix
   52E3 C9            [10]  142 	ret
   52E4                     143 _theme_textures:
   52E4 BA 5A               144 	.dw _g_tile_walls_0
   52E6 BA 5A               145 	.dw _g_tile_walls_0
   52E8 BA 5A               146 	.dw _g_tile_walls_0
   52EA BA 5A               147 	.dw _g_tile_walls_0
   52EC                     148 _enemy_textures:
   52EC 2A 54               149 	.dw _level0_enemies_tileset
   52EE 2A 54               150 	.dw _level0_enemies_tileset
   52F0 2A 54               151 	.dw _level0_enemies_tileset
   52F2 2A 54               152 	.dw _level0_enemies_tileset
                            153 ;src/Textures.c:47: void uncompress_theme_textures(u8 level){//TODO implement
                            154 ;	---------------------------------
                            155 ; Function uncompress_theme_textures
                            156 ; ---------------------------------
   52F4                     157 _uncompress_theme_textures::
   52F4 DD E5         [15]  158 	push	ix
   52F6 DD 21 00 00   [14]  159 	ld	ix,#0
   52FA DD 39         [15]  160 	add	ix,sp
                            161 ;src/Textures.c:48: uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_LEVEL_TEXTURES,TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   52FC 01 E4 52      [10]  162 	ld	bc,#_theme_textures+0
   52FF DD 6E 04      [19]  163 	ld	l,4 (ix)
   5302 26 00         [ 7]  164 	ld	h,#0x00
   5304 29            [11]  165 	add	hl, hl
   5305 09            [11]  166 	add	hl,bc
   5306 4D            [ 4]  167 	ld	c,l
   5307 44            [ 4]  168 	ld	b,h
   5308 5E            [ 7]  169 	ld	e,(hl)
   5309 23            [ 6]  170 	inc	hl
   530A 66            [ 7]  171 	ld	h,(hl)
   530B 6B            [ 4]  172 	ld	l, e
   530C 5E            [ 7]  173 	ld	e,(hl)
   530D 23            [ 6]  174 	inc	hl
   530E 56            [ 7]  175 	ld	d,(hl)
   530F C5            [11]  176 	push	bc
   5310 21 20 10      [10]  177 	ld	hl,#0x1020
   5313 E5            [11]  178 	push	hl
   5314 21 40 08      [10]  179 	ld	hl,#0x0840
   5317 E5            [11]  180 	push	hl
   5318 D5            [11]  181 	push	de
   5319 CD 4D 52      [17]  182 	call	_uncompress_texture
   531C 21 06 00      [10]  183 	ld	hl,#6
   531F 39            [11]  184 	add	hl,sp
   5320 F9            [ 6]  185 	ld	sp,hl
   5321 C1            [10]  186 	pop	bc
                            187 ;src/Textures.c:49: uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+1024),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   5322 69            [ 4]  188 	ld	l, c
   5323 60            [ 4]  189 	ld	h, b
   5324 5E            [ 7]  190 	ld	e,(hl)
   5325 23            [ 6]  191 	inc	hl
   5326 66            [ 7]  192 	ld	h,(hl)
   5327 6B            [ 4]  193 	ld	l, e
   5328 23            [ 6]  194 	inc	hl
   5329 23            [ 6]  195 	inc	hl
   532A 5E            [ 7]  196 	ld	e,(hl)
   532B 23            [ 6]  197 	inc	hl
   532C 56            [ 7]  198 	ld	d,(hl)
   532D C5            [11]  199 	push	bc
   532E 21 20 10      [10]  200 	ld	hl,#0x1020
   5331 E5            [11]  201 	push	hl
   5332 21 40 0C      [10]  202 	ld	hl,#0x0C40
   5335 E5            [11]  203 	push	hl
   5336 D5            [11]  204 	push	de
   5337 CD 4D 52      [17]  205 	call	_uncompress_texture
   533A 21 06 00      [10]  206 	ld	hl,#6
   533D 39            [11]  207 	add	hl,sp
   533E F9            [ 6]  208 	ld	sp,hl
   533F C1            [10]  209 	pop	bc
                            210 ;src/Textures.c:50: uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+2048),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   5340 69            [ 4]  211 	ld	l, c
   5341 60            [ 4]  212 	ld	h, b
   5342 5E            [ 7]  213 	ld	e,(hl)
   5343 23            [ 6]  214 	inc	hl
   5344 66            [ 7]  215 	ld	h,(hl)
   5345 6B            [ 4]  216 	ld	l, e
   5346 11 04 00      [10]  217 	ld	de, #0x0004
   5349 19            [11]  218 	add	hl, de
   534A 5E            [ 7]  219 	ld	e,(hl)
   534B 23            [ 6]  220 	inc	hl
   534C 56            [ 7]  221 	ld	d,(hl)
   534D C5            [11]  222 	push	bc
   534E 21 20 10      [10]  223 	ld	hl,#0x1020
   5351 E5            [11]  224 	push	hl
   5352 2E 40         [ 7]  225 	ld	l, #0x40
   5354 E5            [11]  226 	push	hl
   5355 D5            [11]  227 	push	de
   5356 CD 4D 52      [17]  228 	call	_uncompress_texture
   5359 21 06 00      [10]  229 	ld	hl,#6
   535C 39            [11]  230 	add	hl,sp
   535D F9            [ 6]  231 	ld	sp,hl
                            232 ;src/Textures.c:51: uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+3072),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   535E E1            [10]  233 	pop	hl
   535F 4E            [ 7]  234 	ld	c,(hl)
   5360 23            [ 6]  235 	inc	hl
   5361 66            [ 7]  236 	ld	h,(hl)
   5362 69            [ 4]  237 	ld	l, c
   5363 11 06 00      [10]  238 	ld	de, #0x0006
   5366 19            [11]  239 	add	hl, de
   5367 4E            [ 7]  240 	ld	c,(hl)
   5368 23            [ 6]  241 	inc	hl
   5369 46            [ 7]  242 	ld	b,(hl)
   536A 21 20 10      [10]  243 	ld	hl,#0x1020
   536D E5            [11]  244 	push	hl
   536E 21 40 14      [10]  245 	ld	hl,#0x1440
   5371 E5            [11]  246 	push	hl
   5372 C5            [11]  247 	push	bc
   5373 CD 4D 52      [17]  248 	call	_uncompress_texture
   5376 21 06 00      [10]  249 	ld	hl,#6
   5379 39            [11]  250 	add	hl,sp
   537A F9            [ 6]  251 	ld	sp,hl
   537B DD E1         [14]  252 	pop	ix
   537D C9            [10]  253 	ret
                            254 ;src/Textures.c:54: void uncompress_enemy_textures(u8 level){
                            255 ;	---------------------------------
                            256 ; Function uncompress_enemy_textures
                            257 ; ---------------------------------
   537E                     258 _uncompress_enemy_textures::
   537E DD E5         [15]  259 	push	ix
   5380 DD 21 00 00   [14]  260 	ld	ix,#0
   5384 DD 39         [15]  261 	add	ix,sp
                            262 ;src/Textures.c:55: uncompress_texture(enemy_textures[level][0],(u8*)UNCOMPRESSED_ENEMY_TEXTURES,ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   5386 01 EC 52      [10]  263 	ld	bc,#_enemy_textures+0
   5389 DD 6E 04      [19]  264 	ld	l,4 (ix)
   538C 26 00         [ 7]  265 	ld	h,#0x00
   538E 29            [11]  266 	add	hl, hl
   538F 09            [11]  267 	add	hl,bc
   5390 4D            [ 4]  268 	ld	c,l
   5391 44            [ 4]  269 	ld	b,h
   5392 5E            [ 7]  270 	ld	e,(hl)
   5393 23            [ 6]  271 	inc	hl
   5394 66            [ 7]  272 	ld	h,(hl)
   5395 6B            [ 4]  273 	ld	l, e
   5396 5E            [ 7]  274 	ld	e,(hl)
   5397 23            [ 6]  275 	inc	hl
   5398 56            [ 7]  276 	ld	d,(hl)
   5399 C5            [11]  277 	push	bc
   539A 21 18 0C      [10]  278 	ld	hl,#0x0C18
   539D E5            [11]  279 	push	hl
   539E 21 40 18      [10]  280 	ld	hl,#0x1840
   53A1 E5            [11]  281 	push	hl
   53A2 D5            [11]  282 	push	de
   53A3 CD 4D 52      [17]  283 	call	_uncompress_texture
   53A6 21 06 00      [10]  284 	ld	hl,#6
   53A9 39            [11]  285 	add	hl,sp
   53AA F9            [ 6]  286 	ld	sp,hl
   53AB C1            [10]  287 	pop	bc
                            288 ;src/Textures.c:56: uncompress_texture(enemy_textures[level][1],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+576),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   53AC 69            [ 4]  289 	ld	l, c
   53AD 60            [ 4]  290 	ld	h, b
   53AE 5E            [ 7]  291 	ld	e,(hl)
   53AF 23            [ 6]  292 	inc	hl
   53B0 66            [ 7]  293 	ld	h,(hl)
   53B1 6B            [ 4]  294 	ld	l, e
   53B2 23            [ 6]  295 	inc	hl
   53B3 23            [ 6]  296 	inc	hl
   53B4 5E            [ 7]  297 	ld	e,(hl)
   53B5 23            [ 6]  298 	inc	hl
   53B6 56            [ 7]  299 	ld	d,(hl)
   53B7 C5            [11]  300 	push	bc
   53B8 21 18 0C      [10]  301 	ld	hl,#0x0C18
   53BB E5            [11]  302 	push	hl
   53BC 21 80 1A      [10]  303 	ld	hl,#0x1A80
   53BF E5            [11]  304 	push	hl
   53C0 D5            [11]  305 	push	de
   53C1 CD 4D 52      [17]  306 	call	_uncompress_texture
   53C4 21 06 00      [10]  307 	ld	hl,#6
   53C7 39            [11]  308 	add	hl,sp
   53C8 F9            [ 6]  309 	ld	sp,hl
   53C9 C1            [10]  310 	pop	bc
                            311 ;src/Textures.c:57: uncompress_texture(enemy_textures[level][2],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1152),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   53CA 69            [ 4]  312 	ld	l, c
   53CB 60            [ 4]  313 	ld	h, b
   53CC 5E            [ 7]  314 	ld	e,(hl)
   53CD 23            [ 6]  315 	inc	hl
   53CE 66            [ 7]  316 	ld	h,(hl)
   53CF 6B            [ 4]  317 	ld	l, e
   53D0 11 04 00      [10]  318 	ld	de, #0x0004
   53D3 19            [11]  319 	add	hl, de
   53D4 5E            [ 7]  320 	ld	e,(hl)
   53D5 23            [ 6]  321 	inc	hl
   53D6 56            [ 7]  322 	ld	d,(hl)
   53D7 C5            [11]  323 	push	bc
   53D8 21 18 0C      [10]  324 	ld	hl,#0x0C18
   53DB E5            [11]  325 	push	hl
   53DC 21 C0 1C      [10]  326 	ld	hl,#0x1CC0
   53DF E5            [11]  327 	push	hl
   53E0 D5            [11]  328 	push	de
   53E1 CD 4D 52      [17]  329 	call	_uncompress_texture
   53E4 21 06 00      [10]  330 	ld	hl,#6
   53E7 39            [11]  331 	add	hl,sp
   53E8 F9            [ 6]  332 	ld	sp,hl
                            333 ;src/Textures.c:58: uncompress_texture(enemy_textures[level][3],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1728),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   53E9 E1            [10]  334 	pop	hl
   53EA 4E            [ 7]  335 	ld	c,(hl)
   53EB 23            [ 6]  336 	inc	hl
   53EC 66            [ 7]  337 	ld	h,(hl)
   53ED 69            [ 4]  338 	ld	l, c
   53EE 11 06 00      [10]  339 	ld	de, #0x0006
   53F1 19            [11]  340 	add	hl, de
   53F2 4E            [ 7]  341 	ld	c,(hl)
   53F3 23            [ 6]  342 	inc	hl
   53F4 46            [ 7]  343 	ld	b,(hl)
   53F5 21 18 0C      [10]  344 	ld	hl,#0x0C18
   53F8 E5            [11]  345 	push	hl
   53F9 21 00 1F      [10]  346 	ld	hl,#0x1F00
   53FC E5            [11]  347 	push	hl
   53FD C5            [11]  348 	push	bc
   53FE CD 4D 52      [17]  349 	call	_uncompress_texture
   5401 21 06 00      [10]  350 	ld	hl,#6
   5404 39            [11]  351 	add	hl,sp
   5405 F9            [ 6]  352 	ld	sp,hl
   5406 DD E1         [14]  353 	pop	ix
   5408 C9            [10]  354 	ret
                            355 ;src/Textures.c:61: void uncompress_item_textures(){
                            356 ;	---------------------------------
                            357 ; Function uncompress_item_textures
                            358 ; ---------------------------------
   5409                     359 _uncompress_item_textures::
                            360 ;src/Textures.c:63: }
   5409 C9            [10]  361 	ret
                            362 	.area _CODE
                            363 	.area _INITIALIZER
                            364 	.area _CABS (ABS)
