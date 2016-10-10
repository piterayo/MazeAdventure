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
   5B1F                      52 _uncompress_texture::
   5B1F DD E5         [15]   53 	push	ix
   5B21 DD 21 00 00   [14]   54 	ld	ix,#0
   5B25 DD 39         [15]   55 	add	ix,sp
   5B27 21 F8 FF      [10]   56 	ld	hl,#-8
   5B2A 39            [11]   57 	add	hl,sp
   5B2B F9            [ 6]   58 	ld	sp,hl
                             59 ;src/Textures.c:20: u8 p1, p2, tex_height=sizeY, tex_width = sizeX;
   5B2C DD 7E 09      [19]   60 	ld	a,9 (ix)
   5B2F DD 77 FA      [19]   61 	ld	-6 (ix),a
   5B32 DD 4E 08      [19]   62 	ld	c,8 (ix)
                             63 ;src/Textures.c:26: while(sizeX){
   5B35 DD 71 FB      [19]   64 	ld	-5 (ix),c
   5B38 DD 5E 06      [19]   65 	ld	e,6 (ix)
   5B3B DD 56 07      [19]   66 	ld	d,7 (ix)
   5B3E                      67 00104$:
   5B3E DD 7E FB      [19]   68 	ld	a,-5 (ix)
   5B41 B7            [ 4]   69 	or	a, a
   5B42 CA C8 5B      [10]   70 	jp	Z,00107$
                             71 ;src/Textures.c:28: currPos = position;
   5B45 DD 73 FE      [19]   72 	ld	-2 (ix),e
   5B48 DD 72 FF      [19]   73 	ld	-1 (ix),d
                             74 ;src/Textures.c:29: while(sizeY){
   5B4B DD 46 09      [19]   75 	ld	b,9 (ix)
   5B4E DD 7E 04      [19]   76 	ld	a,4 (ix)
   5B51 DD 77 FC      [19]   77 	ld	-4 (ix),a
   5B54 DD 7E 05      [19]   78 	ld	a,5 (ix)
   5B57 DD 77 FD      [19]   79 	ld	-3 (ix),a
   5B5A                      80 00101$:
   5B5A 78            [ 4]   81 	ld	a,b
   5B5B B7            [ 4]   82 	or	a, a
   5B5C 28 51         [12]   83 	jr	Z,00113$
                             84 ;src/Textures.c:30: p1 = (*texture) & g_pixelMask[0];
   5B5E DD 6E FC      [19]   85 	ld	l,-4 (ix)
   5B61 DD 66 FD      [19]   86 	ld	h,-3 (ix)
   5B64 7E            [ 7]   87 	ld	a,(hl)
   5B65 21 96 4B      [10]   88 	ld	hl, #_g_pixelMask + 0
   5B68 6E            [ 7]   89 	ld	l,(hl)
   5B69 A5            [ 4]   90 	and	a, l
                             91 ;src/Textures.c:31: p1= p1 | (p1>>1);
   5B6A 6F            [ 4]   92 	ld	l,a
   5B6B CB 3F         [ 8]   93 	srl	a
   5B6D B5            [ 4]   94 	or	a, l
                             95 ;src/Textures.c:32: *currPos = p1;
   5B6E DD 6E FE      [19]   96 	ld	l,-2 (ix)
   5B71 DD 66 FF      [19]   97 	ld	h,-1 (ix)
   5B74 77            [ 7]   98 	ld	(hl),a
                             99 ;src/Textures.c:33: currPos+=tex_width;
   5B75 DD 7E FE      [19]  100 	ld	a,-2 (ix)
   5B78 81            [ 4]  101 	add	a, c
   5B79 6F            [ 4]  102 	ld	l,a
   5B7A DD 7E FF      [19]  103 	ld	a,-1 (ix)
   5B7D CE 00         [ 7]  104 	adc	a, #0x00
   5B7F 67            [ 4]  105 	ld	h,a
   5B80 33            [ 6]  106 	inc	sp
   5B81 33            [ 6]  107 	inc	sp
   5B82 E5            [11]  108 	push	hl
                            109 ;src/Textures.c:35: p2 = (*texture) & g_pixelMask[1];
   5B83 DD 6E FC      [19]  110 	ld	l,-4 (ix)
   5B86 DD 66 FD      [19]  111 	ld	h,-3 (ix)
   5B89 7E            [ 7]  112 	ld	a,(hl)
   5B8A 21 97 4B      [10]  113 	ld	hl, #_g_pixelMask + 1
   5B8D 6E            [ 7]  114 	ld	l,(hl)
   5B8E A5            [ 4]  115 	and	a, l
                            116 ;src/Textures.c:36: p2 = p2 | (p2<<1);
   5B8F 6F            [ 4]  117 	ld	l,a
   5B90 87            [ 4]  118 	add	a, a
   5B91 B5            [ 4]  119 	or	a, l
                            120 ;src/Textures.c:37: *currPos = p2;
   5B92 E1            [10]  121 	pop	hl
   5B93 E5            [11]  122 	push	hl
   5B94 77            [ 7]  123 	ld	(hl),a
                            124 ;src/Textures.c:38: currPos+=tex_width;
   5B95 DD 7E F8      [19]  125 	ld	a,-8 (ix)
   5B98 81            [ 4]  126 	add	a, c
   5B99 DD 77 FE      [19]  127 	ld	-2 (ix),a
   5B9C DD 7E F9      [19]  128 	ld	a,-7 (ix)
   5B9F CE 00         [ 7]  129 	adc	a, #0x00
   5BA1 DD 77 FF      [19]  130 	ld	-1 (ix),a
                            131 ;src/Textures.c:39: --sizeY;
   5BA4 05            [ 4]  132 	dec	b
                            133 ;src/Textures.c:40: ++texture;
   5BA5 DD 34 FC      [23]  134 	inc	-4 (ix)
   5BA8 20 B0         [12]  135 	jr	NZ,00101$
   5BAA DD 34 FD      [23]  136 	inc	-3 (ix)
   5BAD 18 AB         [12]  137 	jr	00101$
   5BAF                     138 00113$:
   5BAF DD 7E FC      [19]  139 	ld	a,-4 (ix)
   5BB2 DD 77 04      [19]  140 	ld	4 (ix),a
   5BB5 DD 7E FD      [19]  141 	ld	a,-3 (ix)
   5BB8 DD 77 05      [19]  142 	ld	5 (ix),a
                            143 ;src/Textures.c:42: --sizeX;
   5BBB DD 35 FB      [23]  144 	dec	-5 (ix)
                            145 ;src/Textures.c:43: sizeY=tex_height;
   5BBE DD 7E FA      [19]  146 	ld	a,-6 (ix)
   5BC1 DD 77 09      [19]  147 	ld	9 (ix),a
                            148 ;src/Textures.c:44: ++position;
   5BC4 13            [ 6]  149 	inc	de
   5BC5 C3 3E 5B      [10]  150 	jp	00104$
   5BC8                     151 00107$:
   5BC8 DD F9         [10]  152 	ld	sp, ix
   5BCA DD E1         [14]  153 	pop	ix
   5BCC C9            [10]  154 	ret
   5BCD                     155 _theme_textures:
   5BCD A3 63               156 	.dw _level0_walls_tileset
   5BCF AB 6B               157 	.dw _level1_walls_tileset
   5BD1 AB 6B               158 	.dw _level1_walls_tileset
   5BD3 AB 6B               159 	.dw _level1_walls_tileset
   5BD5                     160 _enemy_textures:
   5BD5 1B 5F               161 	.dw _level0_enemies_tileset
   5BD7 1B 5F               162 	.dw _level0_enemies_tileset
   5BD9 1B 5F               163 	.dw _level0_enemies_tileset
   5BDB 1B 5F               164 	.dw _level0_enemies_tileset
                            165 ;src/Textures.c:49: void uncompress_theme_textures(u8 level){//TODO implement
                            166 ;	---------------------------------
                            167 ; Function uncompress_theme_textures
                            168 ; ---------------------------------
   5BDD                     169 _uncompress_theme_textures::
   5BDD DD E5         [15]  170 	push	ix
   5BDF DD 21 00 00   [14]  171 	ld	ix,#0
   5BE3 DD 39         [15]  172 	add	ix,sp
                            173 ;src/Textures.c:50: uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_LEVEL_TEXTURES,TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   5BE5 01 CD 5B      [10]  174 	ld	bc,#_theme_textures+0
   5BE8 DD 6E 04      [19]  175 	ld	l,4 (ix)
   5BEB 26 00         [ 7]  176 	ld	h,#0x00
   5BED 29            [11]  177 	add	hl, hl
   5BEE 09            [11]  178 	add	hl,bc
   5BEF 4D            [ 4]  179 	ld	c,l
   5BF0 44            [ 4]  180 	ld	b,h
   5BF1 5E            [ 7]  181 	ld	e,(hl)
   5BF2 23            [ 6]  182 	inc	hl
   5BF3 66            [ 7]  183 	ld	h,(hl)
   5BF4 6B            [ 4]  184 	ld	l, e
   5BF5 5E            [ 7]  185 	ld	e,(hl)
   5BF6 23            [ 6]  186 	inc	hl
   5BF7 56            [ 7]  187 	ld	d,(hl)
   5BF8 C5            [11]  188 	push	bc
   5BF9 21 20 10      [10]  189 	ld	hl,#0x1020
   5BFC E5            [11]  190 	push	hl
   5BFD 21 40 08      [10]  191 	ld	hl,#0x0840
   5C00 E5            [11]  192 	push	hl
   5C01 D5            [11]  193 	push	de
   5C02 CD 1F 5B      [17]  194 	call	_uncompress_texture
   5C05 21 06 00      [10]  195 	ld	hl,#6
   5C08 39            [11]  196 	add	hl,sp
   5C09 F9            [ 6]  197 	ld	sp,hl
   5C0A C1            [10]  198 	pop	bc
                            199 ;src/Textures.c:51: uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+1024),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   5C0B 69            [ 4]  200 	ld	l, c
   5C0C 60            [ 4]  201 	ld	h, b
   5C0D 5E            [ 7]  202 	ld	e,(hl)
   5C0E 23            [ 6]  203 	inc	hl
   5C0F 66            [ 7]  204 	ld	h,(hl)
   5C10 6B            [ 4]  205 	ld	l, e
   5C11 23            [ 6]  206 	inc	hl
   5C12 23            [ 6]  207 	inc	hl
   5C13 5E            [ 7]  208 	ld	e,(hl)
   5C14 23            [ 6]  209 	inc	hl
   5C15 56            [ 7]  210 	ld	d,(hl)
   5C16 C5            [11]  211 	push	bc
   5C17 21 20 10      [10]  212 	ld	hl,#0x1020
   5C1A E5            [11]  213 	push	hl
   5C1B 21 40 0C      [10]  214 	ld	hl,#0x0C40
   5C1E E5            [11]  215 	push	hl
   5C1F D5            [11]  216 	push	de
   5C20 CD 1F 5B      [17]  217 	call	_uncompress_texture
   5C23 21 06 00      [10]  218 	ld	hl,#6
   5C26 39            [11]  219 	add	hl,sp
   5C27 F9            [ 6]  220 	ld	sp,hl
   5C28 C1            [10]  221 	pop	bc
                            222 ;src/Textures.c:52: uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+2048),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   5C29 69            [ 4]  223 	ld	l, c
   5C2A 60            [ 4]  224 	ld	h, b
   5C2B 5E            [ 7]  225 	ld	e,(hl)
   5C2C 23            [ 6]  226 	inc	hl
   5C2D 66            [ 7]  227 	ld	h,(hl)
   5C2E 6B            [ 4]  228 	ld	l, e
   5C2F 11 04 00      [10]  229 	ld	de, #0x0004
   5C32 19            [11]  230 	add	hl, de
   5C33 5E            [ 7]  231 	ld	e,(hl)
   5C34 23            [ 6]  232 	inc	hl
   5C35 56            [ 7]  233 	ld	d,(hl)
   5C36 C5            [11]  234 	push	bc
   5C37 21 20 10      [10]  235 	ld	hl,#0x1020
   5C3A E5            [11]  236 	push	hl
   5C3B 2E 40         [ 7]  237 	ld	l, #0x40
   5C3D E5            [11]  238 	push	hl
   5C3E D5            [11]  239 	push	de
   5C3F CD 1F 5B      [17]  240 	call	_uncompress_texture
   5C42 21 06 00      [10]  241 	ld	hl,#6
   5C45 39            [11]  242 	add	hl,sp
   5C46 F9            [ 6]  243 	ld	sp,hl
                            244 ;src/Textures.c:53: uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+3072),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   5C47 E1            [10]  245 	pop	hl
   5C48 4E            [ 7]  246 	ld	c,(hl)
   5C49 23            [ 6]  247 	inc	hl
   5C4A 66            [ 7]  248 	ld	h,(hl)
   5C4B 69            [ 4]  249 	ld	l, c
   5C4C 11 06 00      [10]  250 	ld	de, #0x0006
   5C4F 19            [11]  251 	add	hl, de
   5C50 4E            [ 7]  252 	ld	c,(hl)
   5C51 23            [ 6]  253 	inc	hl
   5C52 46            [ 7]  254 	ld	b,(hl)
   5C53 21 20 10      [10]  255 	ld	hl,#0x1020
   5C56 E5            [11]  256 	push	hl
   5C57 21 40 14      [10]  257 	ld	hl,#0x1440
   5C5A E5            [11]  258 	push	hl
   5C5B C5            [11]  259 	push	bc
   5C5C CD 1F 5B      [17]  260 	call	_uncompress_texture
   5C5F 21 06 00      [10]  261 	ld	hl,#6
   5C62 39            [11]  262 	add	hl,sp
   5C63 F9            [ 6]  263 	ld	sp,hl
   5C64 DD E1         [14]  264 	pop	ix
   5C66 C9            [10]  265 	ret
                            266 ;src/Textures.c:56: void uncompress_enemy_textures(u8 level){
                            267 ;	---------------------------------
                            268 ; Function uncompress_enemy_textures
                            269 ; ---------------------------------
   5C67                     270 _uncompress_enemy_textures::
   5C67 DD E5         [15]  271 	push	ix
   5C69 DD 21 00 00   [14]  272 	ld	ix,#0
   5C6D DD 39         [15]  273 	add	ix,sp
                            274 ;src/Textures.c:57: uncompress_texture(enemy_textures[level][0],(u8*)UNCOMPRESSED_ENEMY_TEXTURES,ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   5C6F 01 D5 5B      [10]  275 	ld	bc,#_enemy_textures+0
   5C72 DD 6E 04      [19]  276 	ld	l,4 (ix)
   5C75 26 00         [ 7]  277 	ld	h,#0x00
   5C77 29            [11]  278 	add	hl, hl
   5C78 09            [11]  279 	add	hl,bc
   5C79 4D            [ 4]  280 	ld	c,l
   5C7A 44            [ 4]  281 	ld	b,h
   5C7B 5E            [ 7]  282 	ld	e,(hl)
   5C7C 23            [ 6]  283 	inc	hl
   5C7D 66            [ 7]  284 	ld	h,(hl)
   5C7E 6B            [ 4]  285 	ld	l, e
   5C7F 5E            [ 7]  286 	ld	e,(hl)
   5C80 23            [ 6]  287 	inc	hl
   5C81 56            [ 7]  288 	ld	d,(hl)
   5C82 C5            [11]  289 	push	bc
   5C83 21 18 0C      [10]  290 	ld	hl,#0x0C18
   5C86 E5            [11]  291 	push	hl
   5C87 21 40 18      [10]  292 	ld	hl,#0x1840
   5C8A E5            [11]  293 	push	hl
   5C8B D5            [11]  294 	push	de
   5C8C CD 1F 5B      [17]  295 	call	_uncompress_texture
   5C8F 21 06 00      [10]  296 	ld	hl,#6
   5C92 39            [11]  297 	add	hl,sp
   5C93 F9            [ 6]  298 	ld	sp,hl
   5C94 C1            [10]  299 	pop	bc
                            300 ;src/Textures.c:58: uncompress_texture(enemy_textures[level][1],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+576),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   5C95 69            [ 4]  301 	ld	l, c
   5C96 60            [ 4]  302 	ld	h, b
   5C97 5E            [ 7]  303 	ld	e,(hl)
   5C98 23            [ 6]  304 	inc	hl
   5C99 66            [ 7]  305 	ld	h,(hl)
   5C9A 6B            [ 4]  306 	ld	l, e
   5C9B 23            [ 6]  307 	inc	hl
   5C9C 23            [ 6]  308 	inc	hl
   5C9D 5E            [ 7]  309 	ld	e,(hl)
   5C9E 23            [ 6]  310 	inc	hl
   5C9F 56            [ 7]  311 	ld	d,(hl)
   5CA0 C5            [11]  312 	push	bc
   5CA1 21 18 0C      [10]  313 	ld	hl,#0x0C18
   5CA4 E5            [11]  314 	push	hl
   5CA5 21 80 1A      [10]  315 	ld	hl,#0x1A80
   5CA8 E5            [11]  316 	push	hl
   5CA9 D5            [11]  317 	push	de
   5CAA CD 1F 5B      [17]  318 	call	_uncompress_texture
   5CAD 21 06 00      [10]  319 	ld	hl,#6
   5CB0 39            [11]  320 	add	hl,sp
   5CB1 F9            [ 6]  321 	ld	sp,hl
   5CB2 C1            [10]  322 	pop	bc
                            323 ;src/Textures.c:59: uncompress_texture(enemy_textures[level][2],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1152),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   5CB3 69            [ 4]  324 	ld	l, c
   5CB4 60            [ 4]  325 	ld	h, b
   5CB5 5E            [ 7]  326 	ld	e,(hl)
   5CB6 23            [ 6]  327 	inc	hl
   5CB7 66            [ 7]  328 	ld	h,(hl)
   5CB8 6B            [ 4]  329 	ld	l, e
   5CB9 11 04 00      [10]  330 	ld	de, #0x0004
   5CBC 19            [11]  331 	add	hl, de
   5CBD 5E            [ 7]  332 	ld	e,(hl)
   5CBE 23            [ 6]  333 	inc	hl
   5CBF 56            [ 7]  334 	ld	d,(hl)
   5CC0 C5            [11]  335 	push	bc
   5CC1 21 18 0C      [10]  336 	ld	hl,#0x0C18
   5CC4 E5            [11]  337 	push	hl
   5CC5 21 C0 1C      [10]  338 	ld	hl,#0x1CC0
   5CC8 E5            [11]  339 	push	hl
   5CC9 D5            [11]  340 	push	de
   5CCA CD 1F 5B      [17]  341 	call	_uncompress_texture
   5CCD 21 06 00      [10]  342 	ld	hl,#6
   5CD0 39            [11]  343 	add	hl,sp
   5CD1 F9            [ 6]  344 	ld	sp,hl
                            345 ;src/Textures.c:60: uncompress_texture(enemy_textures[level][3],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1728),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   5CD2 E1            [10]  346 	pop	hl
   5CD3 4E            [ 7]  347 	ld	c,(hl)
   5CD4 23            [ 6]  348 	inc	hl
   5CD5 66            [ 7]  349 	ld	h,(hl)
   5CD6 69            [ 4]  350 	ld	l, c
   5CD7 11 06 00      [10]  351 	ld	de, #0x0006
   5CDA 19            [11]  352 	add	hl, de
   5CDB 4E            [ 7]  353 	ld	c,(hl)
   5CDC 23            [ 6]  354 	inc	hl
   5CDD 46            [ 7]  355 	ld	b,(hl)
   5CDE 21 18 0C      [10]  356 	ld	hl,#0x0C18
   5CE1 E5            [11]  357 	push	hl
   5CE2 21 00 1F      [10]  358 	ld	hl,#0x1F00
   5CE5 E5            [11]  359 	push	hl
   5CE6 C5            [11]  360 	push	bc
   5CE7 CD 1F 5B      [17]  361 	call	_uncompress_texture
   5CEA 21 06 00      [10]  362 	ld	hl,#6
   5CED 39            [11]  363 	add	hl,sp
   5CEE F9            [ 6]  364 	ld	sp,hl
   5CEF DD E1         [14]  365 	pop	ix
   5CF1 C9            [10]  366 	ret
                            367 ;src/Textures.c:63: void uncompress_item_textures(){
                            368 ;	---------------------------------
                            369 ; Function uncompress_item_textures
                            370 ; ---------------------------------
   5CF2                     371 _uncompress_item_textures::
                            372 ;src/Textures.c:65: }
   5CF2 C9            [10]  373 	ret
                            374 	.area _CODE
                            375 	.area _INITIALIZER
                            376 	.area _CABS (ABS)
