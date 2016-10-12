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
   6D71                      52 _uncompress_texture::
   6D71 DD E5         [15]   53 	push	ix
   6D73 DD 21 00 00   [14]   54 	ld	ix,#0
   6D77 DD 39         [15]   55 	add	ix,sp
   6D79 21 F8 FF      [10]   56 	ld	hl,#-8
   6D7C 39            [11]   57 	add	hl,sp
   6D7D F9            [ 6]   58 	ld	sp,hl
                             59 ;src/Textures.c:20: u8 p1, p2, tex_height=sizeY, tex_width = sizeX;
   6D7E DD 7E 09      [19]   60 	ld	a,9 (ix)
   6D81 DD 77 FA      [19]   61 	ld	-6 (ix),a
   6D84 DD 4E 08      [19]   62 	ld	c,8 (ix)
                             63 ;src/Textures.c:26: while(sizeX){
   6D87 DD 71 FF      [19]   64 	ld	-1 (ix),c
   6D8A DD 5E 06      [19]   65 	ld	e,6 (ix)
   6D8D DD 56 07      [19]   66 	ld	d,7 (ix)
   6D90                      67 00104$:
   6D90 DD 7E FF      [19]   68 	ld	a,-1 (ix)
   6D93 B7            [ 4]   69 	or	a, a
   6D94 CA 1A 6E      [10]   70 	jp	Z,00107$
                             71 ;src/Textures.c:28: currPos = position;
   6D97 DD 73 FB      [19]   72 	ld	-5 (ix),e
   6D9A DD 72 FC      [19]   73 	ld	-4 (ix),d
                             74 ;src/Textures.c:29: while(sizeY){
   6D9D DD 46 09      [19]   75 	ld	b,9 (ix)
   6DA0 DD 7E 04      [19]   76 	ld	a,4 (ix)
   6DA3 DD 77 FD      [19]   77 	ld	-3 (ix),a
   6DA6 DD 7E 05      [19]   78 	ld	a,5 (ix)
   6DA9 DD 77 FE      [19]   79 	ld	-2 (ix),a
   6DAC                      80 00101$:
   6DAC 78            [ 4]   81 	ld	a,b
   6DAD B7            [ 4]   82 	or	a, a
   6DAE 28 51         [12]   83 	jr	Z,00113$
                             84 ;src/Textures.c:30: p1 = (*texture) & g_pixelMask[0];
   6DB0 DD 6E FD      [19]   85 	ld	l,-3 (ix)
   6DB3 DD 66 FE      [19]   86 	ld	h,-2 (ix)
   6DB6 7E            [ 7]   87 	ld	a,(hl)
   6DB7 21 5B 5A      [10]   88 	ld	hl, #_g_pixelMask + 0
   6DBA 6E            [ 7]   89 	ld	l,(hl)
   6DBB A5            [ 4]   90 	and	a, l
                             91 ;src/Textures.c:31: p1= p1 | (p1>>1);
   6DBC 6F            [ 4]   92 	ld	l,a
   6DBD CB 3F         [ 8]   93 	srl	a
   6DBF B5            [ 4]   94 	or	a, l
                             95 ;src/Textures.c:32: *currPos = p1;
   6DC0 DD 6E FB      [19]   96 	ld	l,-5 (ix)
   6DC3 DD 66 FC      [19]   97 	ld	h,-4 (ix)
   6DC6 77            [ 7]   98 	ld	(hl),a
                             99 ;src/Textures.c:33: currPos+=tex_width;
   6DC7 DD 7E FB      [19]  100 	ld	a,-5 (ix)
   6DCA 81            [ 4]  101 	add	a, c
   6DCB 6F            [ 4]  102 	ld	l,a
   6DCC DD 7E FC      [19]  103 	ld	a,-4 (ix)
   6DCF CE 00         [ 7]  104 	adc	a, #0x00
   6DD1 67            [ 4]  105 	ld	h,a
   6DD2 33            [ 6]  106 	inc	sp
   6DD3 33            [ 6]  107 	inc	sp
   6DD4 E5            [11]  108 	push	hl
                            109 ;src/Textures.c:35: p2 = (*texture) & g_pixelMask[1];
   6DD5 DD 6E FD      [19]  110 	ld	l,-3 (ix)
   6DD8 DD 66 FE      [19]  111 	ld	h,-2 (ix)
   6DDB 7E            [ 7]  112 	ld	a,(hl)
   6DDC 21 5C 5A      [10]  113 	ld	hl, #_g_pixelMask + 1
   6DDF 6E            [ 7]  114 	ld	l,(hl)
   6DE0 A5            [ 4]  115 	and	a, l
                            116 ;src/Textures.c:36: p2 = p2 | (p2<<1);
   6DE1 6F            [ 4]  117 	ld	l,a
   6DE2 87            [ 4]  118 	add	a, a
   6DE3 B5            [ 4]  119 	or	a, l
                            120 ;src/Textures.c:37: *currPos = p2;
   6DE4 E1            [10]  121 	pop	hl
   6DE5 E5            [11]  122 	push	hl
   6DE6 77            [ 7]  123 	ld	(hl),a
                            124 ;src/Textures.c:38: currPos+=tex_width;
   6DE7 DD 7E F8      [19]  125 	ld	a,-8 (ix)
   6DEA 81            [ 4]  126 	add	a, c
   6DEB DD 77 FB      [19]  127 	ld	-5 (ix),a
   6DEE DD 7E F9      [19]  128 	ld	a,-7 (ix)
   6DF1 CE 00         [ 7]  129 	adc	a, #0x00
   6DF3 DD 77 FC      [19]  130 	ld	-4 (ix),a
                            131 ;src/Textures.c:39: --sizeY;
   6DF6 05            [ 4]  132 	dec	b
                            133 ;src/Textures.c:40: ++texture;
   6DF7 DD 34 FD      [23]  134 	inc	-3 (ix)
   6DFA 20 B0         [12]  135 	jr	NZ,00101$
   6DFC DD 34 FE      [23]  136 	inc	-2 (ix)
   6DFF 18 AB         [12]  137 	jr	00101$
   6E01                     138 00113$:
   6E01 DD 7E FD      [19]  139 	ld	a,-3 (ix)
   6E04 DD 77 04      [19]  140 	ld	4 (ix),a
   6E07 DD 7E FE      [19]  141 	ld	a,-2 (ix)
   6E0A DD 77 05      [19]  142 	ld	5 (ix),a
                            143 ;src/Textures.c:42: --sizeX;
   6E0D DD 35 FF      [23]  144 	dec	-1 (ix)
                            145 ;src/Textures.c:43: sizeY=tex_height;
   6E10 DD 7E FA      [19]  146 	ld	a,-6 (ix)
   6E13 DD 77 09      [19]  147 	ld	9 (ix),a
                            148 ;src/Textures.c:44: ++position;
   6E16 13            [ 6]  149 	inc	de
   6E17 C3 90 6D      [10]  150 	jp	00104$
   6E1A                     151 00107$:
   6E1A DD F9         [10]  152 	ld	sp, ix
   6E1C DD E1         [14]  153 	pop	ix
   6E1E C9            [10]  154 	ret
   6E1F                     155 _theme_textures:
   6E1F 0D 78               156 	.dw _level0_walls_tileset
   6E21 17 82               157 	.dw _level1_walls_tileset
   6E23 17 82               158 	.dw _level1_walls_tileset
   6E25 17 82               159 	.dw _level1_walls_tileset
   6E27                     160 _enemy_textures:
   6E27 85 73               161 	.dw _level0_enemies_tileset
   6E29 85 73               162 	.dw _level0_enemies_tileset
   6E2B 85 73               163 	.dw _level0_enemies_tileset
   6E2D 85 73               164 	.dw _level0_enemies_tileset
                            165 ;src/Textures.c:49: void uncompress_theme_textures(u8 level){//TODO implement
                            166 ;	---------------------------------
                            167 ; Function uncompress_theme_textures
                            168 ; ---------------------------------
   6E2F                     169 _uncompress_theme_textures::
   6E2F DD E5         [15]  170 	push	ix
   6E31 DD 21 00 00   [14]  171 	ld	ix,#0
   6E35 DD 39         [15]  172 	add	ix,sp
                            173 ;src/Textures.c:50: uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_TEXTURES,TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   6E37 01 1F 6E      [10]  174 	ld	bc,#_theme_textures+0
   6E3A DD 6E 04      [19]  175 	ld	l,4 (ix)
   6E3D 26 00         [ 7]  176 	ld	h,#0x00
   6E3F 29            [11]  177 	add	hl, hl
   6E40 09            [11]  178 	add	hl,bc
   6E41 4D            [ 4]  179 	ld	c,l
   6E42 44            [ 4]  180 	ld	b,h
   6E43 5E            [ 7]  181 	ld	e,(hl)
   6E44 23            [ 6]  182 	inc	hl
   6E45 66            [ 7]  183 	ld	h,(hl)
   6E46 6B            [ 4]  184 	ld	l, e
   6E47 5E            [ 7]  185 	ld	e,(hl)
   6E48 23            [ 6]  186 	inc	hl
   6E49 56            [ 7]  187 	ld	d,(hl)
   6E4A C5            [11]  188 	push	bc
   6E4B 21 20 10      [10]  189 	ld	hl,#0x1020
   6E4E E5            [11]  190 	push	hl
   6E4F 21 40 04      [10]  191 	ld	hl,#0x0440
   6E52 E5            [11]  192 	push	hl
   6E53 D5            [11]  193 	push	de
   6E54 CD 71 6D      [17]  194 	call	_uncompress_texture
   6E57 21 06 00      [10]  195 	ld	hl,#6
   6E5A 39            [11]  196 	add	hl,sp
   6E5B F9            [ 6]  197 	ld	sp,hl
   6E5C C1            [10]  198 	pop	bc
                            199 ;src/Textures.c:51: uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_TEXTURES+1024),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   6E5D 69            [ 4]  200 	ld	l, c
   6E5E 60            [ 4]  201 	ld	h, b
   6E5F 5E            [ 7]  202 	ld	e,(hl)
   6E60 23            [ 6]  203 	inc	hl
   6E61 66            [ 7]  204 	ld	h,(hl)
   6E62 6B            [ 4]  205 	ld	l, e
   6E63 23            [ 6]  206 	inc	hl
   6E64 23            [ 6]  207 	inc	hl
   6E65 5E            [ 7]  208 	ld	e,(hl)
   6E66 23            [ 6]  209 	inc	hl
   6E67 56            [ 7]  210 	ld	d,(hl)
   6E68 C5            [11]  211 	push	bc
   6E69 21 20 10      [10]  212 	ld	hl,#0x1020
   6E6C E5            [11]  213 	push	hl
   6E6D 21 40 08      [10]  214 	ld	hl,#0x0840
   6E70 E5            [11]  215 	push	hl
   6E71 D5            [11]  216 	push	de
   6E72 CD 71 6D      [17]  217 	call	_uncompress_texture
   6E75 21 06 00      [10]  218 	ld	hl,#6
   6E78 39            [11]  219 	add	hl,sp
   6E79 F9            [ 6]  220 	ld	sp,hl
   6E7A C1            [10]  221 	pop	bc
                            222 ;src/Textures.c:52: uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_TEXTURES+2048),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   6E7B 69            [ 4]  223 	ld	l, c
   6E7C 60            [ 4]  224 	ld	h, b
   6E7D 5E            [ 7]  225 	ld	e,(hl)
   6E7E 23            [ 6]  226 	inc	hl
   6E7F 66            [ 7]  227 	ld	h,(hl)
   6E80 6B            [ 4]  228 	ld	l, e
   6E81 11 04 00      [10]  229 	ld	de, #0x0004
   6E84 19            [11]  230 	add	hl, de
   6E85 5E            [ 7]  231 	ld	e,(hl)
   6E86 23            [ 6]  232 	inc	hl
   6E87 56            [ 7]  233 	ld	d,(hl)
   6E88 C5            [11]  234 	push	bc
   6E89 21 20 10      [10]  235 	ld	hl,#0x1020
   6E8C E5            [11]  236 	push	hl
   6E8D 21 40 0C      [10]  237 	ld	hl,#0x0C40
   6E90 E5            [11]  238 	push	hl
   6E91 D5            [11]  239 	push	de
   6E92 CD 71 6D      [17]  240 	call	_uncompress_texture
   6E95 21 06 00      [10]  241 	ld	hl,#6
   6E98 39            [11]  242 	add	hl,sp
   6E99 F9            [ 6]  243 	ld	sp,hl
   6E9A C1            [10]  244 	pop	bc
                            245 ;src/Textures.c:53: uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_TEXTURES+3072),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   6E9B 69            [ 4]  246 	ld	l, c
   6E9C 60            [ 4]  247 	ld	h, b
   6E9D 5E            [ 7]  248 	ld	e,(hl)
   6E9E 23            [ 6]  249 	inc	hl
   6E9F 66            [ 7]  250 	ld	h,(hl)
   6EA0 6B            [ 4]  251 	ld	l, e
   6EA1 11 06 00      [10]  252 	ld	de, #0x0006
   6EA4 19            [11]  253 	add	hl, de
   6EA5 5E            [ 7]  254 	ld	e,(hl)
   6EA6 23            [ 6]  255 	inc	hl
   6EA7 56            [ 7]  256 	ld	d,(hl)
   6EA8 C5            [11]  257 	push	bc
   6EA9 21 20 10      [10]  258 	ld	hl,#0x1020
   6EAC E5            [11]  259 	push	hl
   6EAD 2E 40         [ 7]  260 	ld	l, #0x40
   6EAF E5            [11]  261 	push	hl
   6EB0 D5            [11]  262 	push	de
   6EB1 CD 71 6D      [17]  263 	call	_uncompress_texture
   6EB4 21 06 00      [10]  264 	ld	hl,#6
   6EB7 39            [11]  265 	add	hl,sp
   6EB8 F9            [ 6]  266 	ld	sp,hl
                            267 ;src/Textures.c:54: uncompress_texture(theme_textures[level][4],(u8*)(UNCOMPRESSED_TEXTURES+4096),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   6EB9 E1            [10]  268 	pop	hl
   6EBA 4E            [ 7]  269 	ld	c,(hl)
   6EBB 23            [ 6]  270 	inc	hl
   6EBC 66            [ 7]  271 	ld	h,(hl)
   6EBD 69            [ 4]  272 	ld	l, c
   6EBE 11 08 00      [10]  273 	ld	de, #0x0008
   6EC1 19            [11]  274 	add	hl, de
   6EC2 4E            [ 7]  275 	ld	c,(hl)
   6EC3 23            [ 6]  276 	inc	hl
   6EC4 46            [ 7]  277 	ld	b,(hl)
   6EC5 21 20 10      [10]  278 	ld	hl,#0x1020
   6EC8 E5            [11]  279 	push	hl
   6EC9 21 40 14      [10]  280 	ld	hl,#0x1440
   6ECC E5            [11]  281 	push	hl
   6ECD C5            [11]  282 	push	bc
   6ECE CD 71 6D      [17]  283 	call	_uncompress_texture
   6ED1 21 06 00      [10]  284 	ld	hl,#6
   6ED4 39            [11]  285 	add	hl,sp
   6ED5 F9            [ 6]  286 	ld	sp,hl
   6ED6 DD E1         [14]  287 	pop	ix
   6ED8 C9            [10]  288 	ret
                            289 ;src/Textures.c:57: void uncompress_enemy_textures(u8 level){
                            290 ;	---------------------------------
                            291 ; Function uncompress_enemy_textures
                            292 ; ---------------------------------
   6ED9                     293 _uncompress_enemy_textures::
   6ED9 DD E5         [15]  294 	push	ix
   6EDB DD 21 00 00   [14]  295 	ld	ix,#0
   6EDF DD 39         [15]  296 	add	ix,sp
                            297 ;src/Textures.c:58: uncompress_texture(enemy_textures[level][0],(u8*)UNCOMPRESSED_ENEMY_TEXTURES,ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   6EE1 01 27 6E      [10]  298 	ld	bc,#_enemy_textures+0
   6EE4 DD 6E 04      [19]  299 	ld	l,4 (ix)
   6EE7 26 00         [ 7]  300 	ld	h,#0x00
   6EE9 29            [11]  301 	add	hl, hl
   6EEA 09            [11]  302 	add	hl,bc
   6EEB 4D            [ 4]  303 	ld	c,l
   6EEC 44            [ 4]  304 	ld	b,h
   6EED 5E            [ 7]  305 	ld	e,(hl)
   6EEE 23            [ 6]  306 	inc	hl
   6EEF 66            [ 7]  307 	ld	h,(hl)
   6EF0 6B            [ 4]  308 	ld	l, e
   6EF1 5E            [ 7]  309 	ld	e,(hl)
   6EF2 23            [ 6]  310 	inc	hl
   6EF3 56            [ 7]  311 	ld	d,(hl)
   6EF4 C5            [11]  312 	push	bc
   6EF5 21 18 0C      [10]  313 	ld	hl,#0x0C18
   6EF8 E5            [11]  314 	push	hl
   6EF9 21 40 18      [10]  315 	ld	hl,#0x1840
   6EFC E5            [11]  316 	push	hl
   6EFD D5            [11]  317 	push	de
   6EFE CD 71 6D      [17]  318 	call	_uncompress_texture
   6F01 21 06 00      [10]  319 	ld	hl,#6
   6F04 39            [11]  320 	add	hl,sp
   6F05 F9            [ 6]  321 	ld	sp,hl
   6F06 C1            [10]  322 	pop	bc
                            323 ;src/Textures.c:59: uncompress_texture(enemy_textures[level][1],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+576),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   6F07 69            [ 4]  324 	ld	l, c
   6F08 60            [ 4]  325 	ld	h, b
   6F09 5E            [ 7]  326 	ld	e,(hl)
   6F0A 23            [ 6]  327 	inc	hl
   6F0B 66            [ 7]  328 	ld	h,(hl)
   6F0C 6B            [ 4]  329 	ld	l, e
   6F0D 23            [ 6]  330 	inc	hl
   6F0E 23            [ 6]  331 	inc	hl
   6F0F 5E            [ 7]  332 	ld	e,(hl)
   6F10 23            [ 6]  333 	inc	hl
   6F11 56            [ 7]  334 	ld	d,(hl)
   6F12 C5            [11]  335 	push	bc
   6F13 21 18 0C      [10]  336 	ld	hl,#0x0C18
   6F16 E5            [11]  337 	push	hl
   6F17 21 80 1A      [10]  338 	ld	hl,#0x1A80
   6F1A E5            [11]  339 	push	hl
   6F1B D5            [11]  340 	push	de
   6F1C CD 71 6D      [17]  341 	call	_uncompress_texture
   6F1F 21 06 00      [10]  342 	ld	hl,#6
   6F22 39            [11]  343 	add	hl,sp
   6F23 F9            [ 6]  344 	ld	sp,hl
   6F24 C1            [10]  345 	pop	bc
                            346 ;src/Textures.c:60: uncompress_texture(enemy_textures[level][2],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1152),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   6F25 69            [ 4]  347 	ld	l, c
   6F26 60            [ 4]  348 	ld	h, b
   6F27 5E            [ 7]  349 	ld	e,(hl)
   6F28 23            [ 6]  350 	inc	hl
   6F29 66            [ 7]  351 	ld	h,(hl)
   6F2A 6B            [ 4]  352 	ld	l, e
   6F2B 11 04 00      [10]  353 	ld	de, #0x0004
   6F2E 19            [11]  354 	add	hl, de
   6F2F 5E            [ 7]  355 	ld	e,(hl)
   6F30 23            [ 6]  356 	inc	hl
   6F31 56            [ 7]  357 	ld	d,(hl)
   6F32 C5            [11]  358 	push	bc
   6F33 21 18 0C      [10]  359 	ld	hl,#0x0C18
   6F36 E5            [11]  360 	push	hl
   6F37 21 C0 1C      [10]  361 	ld	hl,#0x1CC0
   6F3A E5            [11]  362 	push	hl
   6F3B D5            [11]  363 	push	de
   6F3C CD 71 6D      [17]  364 	call	_uncompress_texture
   6F3F 21 06 00      [10]  365 	ld	hl,#6
   6F42 39            [11]  366 	add	hl,sp
   6F43 F9            [ 6]  367 	ld	sp,hl
                            368 ;src/Textures.c:61: uncompress_texture(enemy_textures[level][3],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1728),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   6F44 E1            [10]  369 	pop	hl
   6F45 4E            [ 7]  370 	ld	c,(hl)
   6F46 23            [ 6]  371 	inc	hl
   6F47 66            [ 7]  372 	ld	h,(hl)
   6F48 69            [ 4]  373 	ld	l, c
   6F49 11 06 00      [10]  374 	ld	de, #0x0006
   6F4C 19            [11]  375 	add	hl, de
   6F4D 4E            [ 7]  376 	ld	c,(hl)
   6F4E 23            [ 6]  377 	inc	hl
   6F4F 46            [ 7]  378 	ld	b,(hl)
   6F50 21 18 0C      [10]  379 	ld	hl,#0x0C18
   6F53 E5            [11]  380 	push	hl
   6F54 21 00 1F      [10]  381 	ld	hl,#0x1F00
   6F57 E5            [11]  382 	push	hl
   6F58 C5            [11]  383 	push	bc
   6F59 CD 71 6D      [17]  384 	call	_uncompress_texture
   6F5C 21 06 00      [10]  385 	ld	hl,#6
   6F5F 39            [11]  386 	add	hl,sp
   6F60 F9            [ 6]  387 	ld	sp,hl
   6F61 DD E1         [14]  388 	pop	ix
   6F63 C9            [10]  389 	ret
                            390 ;src/Textures.c:64: void uncompress_item_textures(){
                            391 ;	---------------------------------
                            392 ; Function uncompress_item_textures
                            393 ; ---------------------------------
   6F64                     394 _uncompress_item_textures::
                            395 ;src/Textures.c:66: }
   6F64 C9            [10]  396 	ret
                            397 	.area _CODE
                            398 	.area _INITIALIZER
                            399 	.area _CABS (ABS)
