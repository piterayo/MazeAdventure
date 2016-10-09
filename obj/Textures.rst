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
   5A03                      52 _uncompress_texture::
   5A03 DD E5         [15]   53 	push	ix
   5A05 DD 21 00 00   [14]   54 	ld	ix,#0
   5A09 DD 39         [15]   55 	add	ix,sp
   5A0B 21 F8 FF      [10]   56 	ld	hl,#-8
   5A0E 39            [11]   57 	add	hl,sp
   5A0F F9            [ 6]   58 	ld	sp,hl
                             59 ;src/Textures.c:18: u8 p1, p2, tex_height=sizeY, tex_width = sizeX;
   5A10 DD 7E 09      [19]   60 	ld	a,9 (ix)
   5A13 DD 77 FA      [19]   61 	ld	-6 (ix),a
   5A16 DD 4E 08      [19]   62 	ld	c,8 (ix)
                             63 ;src/Textures.c:24: while(sizeX){
   5A19 DD 71 FB      [19]   64 	ld	-5 (ix),c
   5A1C DD 5E 06      [19]   65 	ld	e,6 (ix)
   5A1F DD 56 07      [19]   66 	ld	d,7 (ix)
   5A22                      67 00104$:
   5A22 DD 7E FB      [19]   68 	ld	a,-5 (ix)
   5A25 B7            [ 4]   69 	or	a, a
   5A26 CA AC 5A      [10]   70 	jp	Z,00107$
                             71 ;src/Textures.c:26: currPos = position;
   5A29 DD 73 FE      [19]   72 	ld	-2 (ix),e
   5A2C DD 72 FF      [19]   73 	ld	-1 (ix),d
                             74 ;src/Textures.c:27: while(sizeY){
   5A2F DD 46 09      [19]   75 	ld	b,9 (ix)
   5A32 DD 7E 04      [19]   76 	ld	a,4 (ix)
   5A35 DD 77 FC      [19]   77 	ld	-4 (ix),a
   5A38 DD 7E 05      [19]   78 	ld	a,5 (ix)
   5A3B DD 77 FD      [19]   79 	ld	-3 (ix),a
   5A3E                      80 00101$:
   5A3E 78            [ 4]   81 	ld	a,b
   5A3F B7            [ 4]   82 	or	a, a
   5A40 28 51         [12]   83 	jr	Z,00113$
                             84 ;src/Textures.c:28: p1 = (*texture) & g_pixelMask[0];
   5A42 DD 6E FC      [19]   85 	ld	l,-4 (ix)
   5A45 DD 66 FD      [19]   86 	ld	h,-3 (ix)
   5A48 7E            [ 7]   87 	ld	a,(hl)
   5A49 21 88 4A      [10]   88 	ld	hl, #_g_pixelMask + 0
   5A4C 6E            [ 7]   89 	ld	l,(hl)
   5A4D A5            [ 4]   90 	and	a, l
                             91 ;src/Textures.c:29: p1= p1 | (p1>>1);
   5A4E 6F            [ 4]   92 	ld	l,a
   5A4F CB 3F         [ 8]   93 	srl	a
   5A51 B5            [ 4]   94 	or	a, l
                             95 ;src/Textures.c:30: *currPos = p1;
   5A52 DD 6E FE      [19]   96 	ld	l,-2 (ix)
   5A55 DD 66 FF      [19]   97 	ld	h,-1 (ix)
   5A58 77            [ 7]   98 	ld	(hl),a
                             99 ;src/Textures.c:31: currPos+=tex_width;
   5A59 DD 7E FE      [19]  100 	ld	a,-2 (ix)
   5A5C 81            [ 4]  101 	add	a, c
   5A5D 6F            [ 4]  102 	ld	l,a
   5A5E DD 7E FF      [19]  103 	ld	a,-1 (ix)
   5A61 CE 00         [ 7]  104 	adc	a, #0x00
   5A63 67            [ 4]  105 	ld	h,a
   5A64 33            [ 6]  106 	inc	sp
   5A65 33            [ 6]  107 	inc	sp
   5A66 E5            [11]  108 	push	hl
                            109 ;src/Textures.c:33: p2 = (*texture) & g_pixelMask[1];
   5A67 DD 6E FC      [19]  110 	ld	l,-4 (ix)
   5A6A DD 66 FD      [19]  111 	ld	h,-3 (ix)
   5A6D 7E            [ 7]  112 	ld	a,(hl)
   5A6E 21 89 4A      [10]  113 	ld	hl, #_g_pixelMask + 1
   5A71 6E            [ 7]  114 	ld	l,(hl)
   5A72 A5            [ 4]  115 	and	a, l
                            116 ;src/Textures.c:34: p2 = p2 | (p2<<1);
   5A73 6F            [ 4]  117 	ld	l,a
   5A74 87            [ 4]  118 	add	a, a
   5A75 B5            [ 4]  119 	or	a, l
                            120 ;src/Textures.c:35: *currPos = p2;
   5A76 E1            [10]  121 	pop	hl
   5A77 E5            [11]  122 	push	hl
   5A78 77            [ 7]  123 	ld	(hl),a
                            124 ;src/Textures.c:36: currPos+=tex_width;
   5A79 DD 7E F8      [19]  125 	ld	a,-8 (ix)
   5A7C 81            [ 4]  126 	add	a, c
   5A7D DD 77 FE      [19]  127 	ld	-2 (ix),a
   5A80 DD 7E F9      [19]  128 	ld	a,-7 (ix)
   5A83 CE 00         [ 7]  129 	adc	a, #0x00
   5A85 DD 77 FF      [19]  130 	ld	-1 (ix),a
                            131 ;src/Textures.c:37: --sizeY;
   5A88 05            [ 4]  132 	dec	b
                            133 ;src/Textures.c:38: ++texture;
   5A89 DD 34 FC      [23]  134 	inc	-4 (ix)
   5A8C 20 B0         [12]  135 	jr	NZ,00101$
   5A8E DD 34 FD      [23]  136 	inc	-3 (ix)
   5A91 18 AB         [12]  137 	jr	00101$
   5A93                     138 00113$:
   5A93 DD 7E FC      [19]  139 	ld	a,-4 (ix)
   5A96 DD 77 04      [19]  140 	ld	4 (ix),a
   5A99 DD 7E FD      [19]  141 	ld	a,-3 (ix)
   5A9C DD 77 05      [19]  142 	ld	5 (ix),a
                            143 ;src/Textures.c:40: --sizeX;
   5A9F DD 35 FB      [23]  144 	dec	-5 (ix)
                            145 ;src/Textures.c:41: sizeY=tex_height;
   5AA2 DD 7E FA      [19]  146 	ld	a,-6 (ix)
   5AA5 DD 77 09      [19]  147 	ld	9 (ix),a
                            148 ;src/Textures.c:42: ++position;
   5AA8 13            [ 6]  149 	inc	de
   5AA9 C3 22 5A      [10]  150 	jp	00104$
   5AAC                     151 00107$:
   5AAC DD F9         [10]  152 	ld	sp, ix
   5AAE DD E1         [14]  153 	pop	ix
   5AB0 C9            [10]  154 	ret
   5AB1                     155 _theme_textures:
   5AB1 87 62               156 	.dw _g_tile_walls_0
   5AB3 87 62               157 	.dw _g_tile_walls_0
   5AB5 87 62               158 	.dw _g_tile_walls_0
   5AB7 87 62               159 	.dw _g_tile_walls_0
   5AB9                     160 _enemy_textures:
   5AB9 F7 5B               161 	.dw _level0_enemies_tileset
   5ABB F7 5B               162 	.dw _level0_enemies_tileset
   5ABD F7 5B               163 	.dw _level0_enemies_tileset
   5ABF F7 5B               164 	.dw _level0_enemies_tileset
                            165 ;src/Textures.c:47: void uncompress_theme_textures(u8 level){//TODO implement
                            166 ;	---------------------------------
                            167 ; Function uncompress_theme_textures
                            168 ; ---------------------------------
   5AC1                     169 _uncompress_theme_textures::
   5AC1 DD E5         [15]  170 	push	ix
   5AC3 DD 21 00 00   [14]  171 	ld	ix,#0
   5AC7 DD 39         [15]  172 	add	ix,sp
                            173 ;src/Textures.c:48: uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_LEVEL_TEXTURES,TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   5AC9 01 B1 5A      [10]  174 	ld	bc,#_theme_textures+0
   5ACC DD 6E 04      [19]  175 	ld	l,4 (ix)
   5ACF 26 00         [ 7]  176 	ld	h,#0x00
   5AD1 29            [11]  177 	add	hl, hl
   5AD2 09            [11]  178 	add	hl,bc
   5AD3 4D            [ 4]  179 	ld	c,l
   5AD4 44            [ 4]  180 	ld	b,h
   5AD5 5E            [ 7]  181 	ld	e,(hl)
   5AD6 23            [ 6]  182 	inc	hl
   5AD7 66            [ 7]  183 	ld	h,(hl)
   5AD8 6B            [ 4]  184 	ld	l, e
   5AD9 5E            [ 7]  185 	ld	e,(hl)
   5ADA 23            [ 6]  186 	inc	hl
   5ADB 56            [ 7]  187 	ld	d,(hl)
   5ADC C5            [11]  188 	push	bc
   5ADD 21 20 10      [10]  189 	ld	hl,#0x1020
   5AE0 E5            [11]  190 	push	hl
   5AE1 21 40 08      [10]  191 	ld	hl,#0x0840
   5AE4 E5            [11]  192 	push	hl
   5AE5 D5            [11]  193 	push	de
   5AE6 CD 03 5A      [17]  194 	call	_uncompress_texture
   5AE9 21 06 00      [10]  195 	ld	hl,#6
   5AEC 39            [11]  196 	add	hl,sp
   5AED F9            [ 6]  197 	ld	sp,hl
   5AEE C1            [10]  198 	pop	bc
                            199 ;src/Textures.c:49: uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+1024),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   5AEF 69            [ 4]  200 	ld	l, c
   5AF0 60            [ 4]  201 	ld	h, b
   5AF1 5E            [ 7]  202 	ld	e,(hl)
   5AF2 23            [ 6]  203 	inc	hl
   5AF3 66            [ 7]  204 	ld	h,(hl)
   5AF4 6B            [ 4]  205 	ld	l, e
   5AF5 23            [ 6]  206 	inc	hl
   5AF6 23            [ 6]  207 	inc	hl
   5AF7 5E            [ 7]  208 	ld	e,(hl)
   5AF8 23            [ 6]  209 	inc	hl
   5AF9 56            [ 7]  210 	ld	d,(hl)
   5AFA C5            [11]  211 	push	bc
   5AFB 21 20 10      [10]  212 	ld	hl,#0x1020
   5AFE E5            [11]  213 	push	hl
   5AFF 21 40 0C      [10]  214 	ld	hl,#0x0C40
   5B02 E5            [11]  215 	push	hl
   5B03 D5            [11]  216 	push	de
   5B04 CD 03 5A      [17]  217 	call	_uncompress_texture
   5B07 21 06 00      [10]  218 	ld	hl,#6
   5B0A 39            [11]  219 	add	hl,sp
   5B0B F9            [ 6]  220 	ld	sp,hl
   5B0C C1            [10]  221 	pop	bc
                            222 ;src/Textures.c:50: uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+2048),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   5B0D 69            [ 4]  223 	ld	l, c
   5B0E 60            [ 4]  224 	ld	h, b
   5B0F 5E            [ 7]  225 	ld	e,(hl)
   5B10 23            [ 6]  226 	inc	hl
   5B11 66            [ 7]  227 	ld	h,(hl)
   5B12 6B            [ 4]  228 	ld	l, e
   5B13 11 04 00      [10]  229 	ld	de, #0x0004
   5B16 19            [11]  230 	add	hl, de
   5B17 5E            [ 7]  231 	ld	e,(hl)
   5B18 23            [ 6]  232 	inc	hl
   5B19 56            [ 7]  233 	ld	d,(hl)
   5B1A C5            [11]  234 	push	bc
   5B1B 21 20 10      [10]  235 	ld	hl,#0x1020
   5B1E E5            [11]  236 	push	hl
   5B1F 2E 40         [ 7]  237 	ld	l, #0x40
   5B21 E5            [11]  238 	push	hl
   5B22 D5            [11]  239 	push	de
   5B23 CD 03 5A      [17]  240 	call	_uncompress_texture
   5B26 21 06 00      [10]  241 	ld	hl,#6
   5B29 39            [11]  242 	add	hl,sp
   5B2A F9            [ 6]  243 	ld	sp,hl
                            244 ;src/Textures.c:51: uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+3072),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   5B2B E1            [10]  245 	pop	hl
   5B2C 4E            [ 7]  246 	ld	c,(hl)
   5B2D 23            [ 6]  247 	inc	hl
   5B2E 66            [ 7]  248 	ld	h,(hl)
   5B2F 69            [ 4]  249 	ld	l, c
   5B30 11 06 00      [10]  250 	ld	de, #0x0006
   5B33 19            [11]  251 	add	hl, de
   5B34 4E            [ 7]  252 	ld	c,(hl)
   5B35 23            [ 6]  253 	inc	hl
   5B36 46            [ 7]  254 	ld	b,(hl)
   5B37 21 20 10      [10]  255 	ld	hl,#0x1020
   5B3A E5            [11]  256 	push	hl
   5B3B 21 40 14      [10]  257 	ld	hl,#0x1440
   5B3E E5            [11]  258 	push	hl
   5B3F C5            [11]  259 	push	bc
   5B40 CD 03 5A      [17]  260 	call	_uncompress_texture
   5B43 21 06 00      [10]  261 	ld	hl,#6
   5B46 39            [11]  262 	add	hl,sp
   5B47 F9            [ 6]  263 	ld	sp,hl
   5B48 DD E1         [14]  264 	pop	ix
   5B4A C9            [10]  265 	ret
                            266 ;src/Textures.c:54: void uncompress_enemy_textures(u8 level){
                            267 ;	---------------------------------
                            268 ; Function uncompress_enemy_textures
                            269 ; ---------------------------------
   5B4B                     270 _uncompress_enemy_textures::
   5B4B DD E5         [15]  271 	push	ix
   5B4D DD 21 00 00   [14]  272 	ld	ix,#0
   5B51 DD 39         [15]  273 	add	ix,sp
                            274 ;src/Textures.c:55: uncompress_texture(enemy_textures[level][0],(u8*)UNCOMPRESSED_ENEMY_TEXTURES,ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   5B53 01 B9 5A      [10]  275 	ld	bc,#_enemy_textures+0
   5B56 DD 6E 04      [19]  276 	ld	l,4 (ix)
   5B59 26 00         [ 7]  277 	ld	h,#0x00
   5B5B 29            [11]  278 	add	hl, hl
   5B5C 09            [11]  279 	add	hl,bc
   5B5D 4D            [ 4]  280 	ld	c,l
   5B5E 44            [ 4]  281 	ld	b,h
   5B5F 5E            [ 7]  282 	ld	e,(hl)
   5B60 23            [ 6]  283 	inc	hl
   5B61 66            [ 7]  284 	ld	h,(hl)
   5B62 6B            [ 4]  285 	ld	l, e
   5B63 5E            [ 7]  286 	ld	e,(hl)
   5B64 23            [ 6]  287 	inc	hl
   5B65 56            [ 7]  288 	ld	d,(hl)
   5B66 C5            [11]  289 	push	bc
   5B67 21 18 0C      [10]  290 	ld	hl,#0x0C18
   5B6A E5            [11]  291 	push	hl
   5B6B 21 40 18      [10]  292 	ld	hl,#0x1840
   5B6E E5            [11]  293 	push	hl
   5B6F D5            [11]  294 	push	de
   5B70 CD 03 5A      [17]  295 	call	_uncompress_texture
   5B73 21 06 00      [10]  296 	ld	hl,#6
   5B76 39            [11]  297 	add	hl,sp
   5B77 F9            [ 6]  298 	ld	sp,hl
   5B78 C1            [10]  299 	pop	bc
                            300 ;src/Textures.c:56: uncompress_texture(enemy_textures[level][1],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+576),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   5B79 69            [ 4]  301 	ld	l, c
   5B7A 60            [ 4]  302 	ld	h, b
   5B7B 5E            [ 7]  303 	ld	e,(hl)
   5B7C 23            [ 6]  304 	inc	hl
   5B7D 66            [ 7]  305 	ld	h,(hl)
   5B7E 6B            [ 4]  306 	ld	l, e
   5B7F 23            [ 6]  307 	inc	hl
   5B80 23            [ 6]  308 	inc	hl
   5B81 5E            [ 7]  309 	ld	e,(hl)
   5B82 23            [ 6]  310 	inc	hl
   5B83 56            [ 7]  311 	ld	d,(hl)
   5B84 C5            [11]  312 	push	bc
   5B85 21 18 0C      [10]  313 	ld	hl,#0x0C18
   5B88 E5            [11]  314 	push	hl
   5B89 21 80 1A      [10]  315 	ld	hl,#0x1A80
   5B8C E5            [11]  316 	push	hl
   5B8D D5            [11]  317 	push	de
   5B8E CD 03 5A      [17]  318 	call	_uncompress_texture
   5B91 21 06 00      [10]  319 	ld	hl,#6
   5B94 39            [11]  320 	add	hl,sp
   5B95 F9            [ 6]  321 	ld	sp,hl
   5B96 C1            [10]  322 	pop	bc
                            323 ;src/Textures.c:57: uncompress_texture(enemy_textures[level][2],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1152),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   5B97 69            [ 4]  324 	ld	l, c
   5B98 60            [ 4]  325 	ld	h, b
   5B99 5E            [ 7]  326 	ld	e,(hl)
   5B9A 23            [ 6]  327 	inc	hl
   5B9B 66            [ 7]  328 	ld	h,(hl)
   5B9C 6B            [ 4]  329 	ld	l, e
   5B9D 11 04 00      [10]  330 	ld	de, #0x0004
   5BA0 19            [11]  331 	add	hl, de
   5BA1 5E            [ 7]  332 	ld	e,(hl)
   5BA2 23            [ 6]  333 	inc	hl
   5BA3 56            [ 7]  334 	ld	d,(hl)
   5BA4 C5            [11]  335 	push	bc
   5BA5 21 18 0C      [10]  336 	ld	hl,#0x0C18
   5BA8 E5            [11]  337 	push	hl
   5BA9 21 C0 1C      [10]  338 	ld	hl,#0x1CC0
   5BAC E5            [11]  339 	push	hl
   5BAD D5            [11]  340 	push	de
   5BAE CD 03 5A      [17]  341 	call	_uncompress_texture
   5BB1 21 06 00      [10]  342 	ld	hl,#6
   5BB4 39            [11]  343 	add	hl,sp
   5BB5 F9            [ 6]  344 	ld	sp,hl
                            345 ;src/Textures.c:58: uncompress_texture(enemy_textures[level][3],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1728),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   5BB6 E1            [10]  346 	pop	hl
   5BB7 4E            [ 7]  347 	ld	c,(hl)
   5BB8 23            [ 6]  348 	inc	hl
   5BB9 66            [ 7]  349 	ld	h,(hl)
   5BBA 69            [ 4]  350 	ld	l, c
   5BBB 11 06 00      [10]  351 	ld	de, #0x0006
   5BBE 19            [11]  352 	add	hl, de
   5BBF 4E            [ 7]  353 	ld	c,(hl)
   5BC0 23            [ 6]  354 	inc	hl
   5BC1 46            [ 7]  355 	ld	b,(hl)
   5BC2 21 18 0C      [10]  356 	ld	hl,#0x0C18
   5BC5 E5            [11]  357 	push	hl
   5BC6 21 00 1F      [10]  358 	ld	hl,#0x1F00
   5BC9 E5            [11]  359 	push	hl
   5BCA C5            [11]  360 	push	bc
   5BCB CD 03 5A      [17]  361 	call	_uncompress_texture
   5BCE 21 06 00      [10]  362 	ld	hl,#6
   5BD1 39            [11]  363 	add	hl,sp
   5BD2 F9            [ 6]  364 	ld	sp,hl
   5BD3 DD E1         [14]  365 	pop	ix
   5BD5 C9            [10]  366 	ret
                            367 ;src/Textures.c:61: void uncompress_item_textures(){
                            368 ;	---------------------------------
                            369 ; Function uncompress_item_textures
                            370 ; ---------------------------------
   5BD6                     371 _uncompress_item_textures::
                            372 ;src/Textures.c:63: }
   5BD6 C9            [10]  373 	ret
                            374 	.area _CODE
                            375 	.area _INITIALIZER
                            376 	.area _CABS (ABS)
