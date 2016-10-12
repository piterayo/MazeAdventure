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
   1DB8                      52 _uncompress_texture::
   1DB8 DD E5         [15]   53 	push	ix
   1DBA DD 21 00 00   [14]   54 	ld	ix,#0
   1DBE DD 39         [15]   55 	add	ix,sp
   1DC0 21 F8 FF      [10]   56 	ld	hl,#-8
   1DC3 39            [11]   57 	add	hl,sp
   1DC4 F9            [ 6]   58 	ld	sp,hl
                             59 ;src/Textures.c:20: u8 p1, p2, tex_height=sizeY, tex_width = sizeX;
   1DC5 DD 7E 09      [19]   60 	ld	a,9 (ix)
   1DC8 DD 77 FA      [19]   61 	ld	-6 (ix),a
   1DCB DD 4E 08      [19]   62 	ld	c,8 (ix)
                             63 ;src/Textures.c:26: while(sizeX){
   1DCE DD 71 FF      [19]   64 	ld	-1 (ix),c
   1DD1 DD 5E 06      [19]   65 	ld	e,6 (ix)
   1DD4 DD 56 07      [19]   66 	ld	d,7 (ix)
   1DD7                      67 00104$:
   1DD7 DD 7E FF      [19]   68 	ld	a,-1 (ix)
   1DDA B7            [ 4]   69 	or	a, a
   1DDB CA 61 1E      [10]   70 	jp	Z,00107$
                             71 ;src/Textures.c:28: currPos = position;
   1DDE DD 73 FB      [19]   72 	ld	-5 (ix),e
   1DE1 DD 72 FC      [19]   73 	ld	-4 (ix),d
                             74 ;src/Textures.c:29: while(sizeY){
   1DE4 DD 46 09      [19]   75 	ld	b,9 (ix)
   1DE7 DD 7E 04      [19]   76 	ld	a,4 (ix)
   1DEA DD 77 FD      [19]   77 	ld	-3 (ix),a
   1DED DD 7E 05      [19]   78 	ld	a,5 (ix)
   1DF0 DD 77 FE      [19]   79 	ld	-2 (ix),a
   1DF3                      80 00101$:
   1DF3 78            [ 4]   81 	ld	a,b
   1DF4 B7            [ 4]   82 	or	a, a
   1DF5 28 51         [12]   83 	jr	Z,00113$
                             84 ;src/Textures.c:30: p1 = (*texture) & g_pixelMask[0];
   1DF7 DD 6E FD      [19]   85 	ld	l,-3 (ix)
   1DFA DD 66 FE      [19]   86 	ld	h,-2 (ix)
   1DFD 7E            [ 7]   87 	ld	a,(hl)
   1DFE 21 B5 0A      [10]   88 	ld	hl, #_g_pixelMask + 0
   1E01 6E            [ 7]   89 	ld	l,(hl)
   1E02 A5            [ 4]   90 	and	a, l
                             91 ;src/Textures.c:31: p1= p1 | (p1>>1);
   1E03 6F            [ 4]   92 	ld	l,a
   1E04 CB 3F         [ 8]   93 	srl	a
   1E06 B5            [ 4]   94 	or	a, l
                             95 ;src/Textures.c:32: *currPos = p1;
   1E07 DD 6E FB      [19]   96 	ld	l,-5 (ix)
   1E0A DD 66 FC      [19]   97 	ld	h,-4 (ix)
   1E0D 77            [ 7]   98 	ld	(hl),a
                             99 ;src/Textures.c:33: currPos+=tex_width;
   1E0E DD 7E FB      [19]  100 	ld	a,-5 (ix)
   1E11 81            [ 4]  101 	add	a, c
   1E12 6F            [ 4]  102 	ld	l,a
   1E13 DD 7E FC      [19]  103 	ld	a,-4 (ix)
   1E16 CE 00         [ 7]  104 	adc	a, #0x00
   1E18 67            [ 4]  105 	ld	h,a
   1E19 33            [ 6]  106 	inc	sp
   1E1A 33            [ 6]  107 	inc	sp
   1E1B E5            [11]  108 	push	hl
                            109 ;src/Textures.c:35: p2 = (*texture) & g_pixelMask[1];
   1E1C DD 6E FD      [19]  110 	ld	l,-3 (ix)
   1E1F DD 66 FE      [19]  111 	ld	h,-2 (ix)
   1E22 7E            [ 7]  112 	ld	a,(hl)
   1E23 21 B6 0A      [10]  113 	ld	hl, #_g_pixelMask + 1
   1E26 6E            [ 7]  114 	ld	l,(hl)
   1E27 A5            [ 4]  115 	and	a, l
                            116 ;src/Textures.c:36: p2 = p2 | (p2<<1);
   1E28 6F            [ 4]  117 	ld	l,a
   1E29 87            [ 4]  118 	add	a, a
   1E2A B5            [ 4]  119 	or	a, l
                            120 ;src/Textures.c:37: *currPos = p2;
   1E2B E1            [10]  121 	pop	hl
   1E2C E5            [11]  122 	push	hl
   1E2D 77            [ 7]  123 	ld	(hl),a
                            124 ;src/Textures.c:38: currPos+=tex_width;
   1E2E DD 7E F8      [19]  125 	ld	a,-8 (ix)
   1E31 81            [ 4]  126 	add	a, c
   1E32 DD 77 FB      [19]  127 	ld	-5 (ix),a
   1E35 DD 7E F9      [19]  128 	ld	a,-7 (ix)
   1E38 CE 00         [ 7]  129 	adc	a, #0x00
   1E3A DD 77 FC      [19]  130 	ld	-4 (ix),a
                            131 ;src/Textures.c:39: --sizeY;
   1E3D 05            [ 4]  132 	dec	b
                            133 ;src/Textures.c:40: ++texture;
   1E3E DD 34 FD      [23]  134 	inc	-3 (ix)
   1E41 20 B0         [12]  135 	jr	NZ,00101$
   1E43 DD 34 FE      [23]  136 	inc	-2 (ix)
   1E46 18 AB         [12]  137 	jr	00101$
   1E48                     138 00113$:
   1E48 DD 7E FD      [19]  139 	ld	a,-3 (ix)
   1E4B DD 77 04      [19]  140 	ld	4 (ix),a
   1E4E DD 7E FE      [19]  141 	ld	a,-2 (ix)
   1E51 DD 77 05      [19]  142 	ld	5 (ix),a
                            143 ;src/Textures.c:42: --sizeX;
   1E54 DD 35 FF      [23]  144 	dec	-1 (ix)
                            145 ;src/Textures.c:43: sizeY=tex_height;
   1E57 DD 7E FA      [19]  146 	ld	a,-6 (ix)
   1E5A DD 77 09      [19]  147 	ld	9 (ix),a
                            148 ;src/Textures.c:44: ++position;
   1E5D 13            [ 6]  149 	inc	de
   1E5E C3 D7 1D      [10]  150 	jp	00104$
   1E61                     151 00107$:
   1E61 DD F9         [10]  152 	ld	sp, ix
   1E63 DD E1         [14]  153 	pop	ix
   1E65 C9            [10]  154 	ret
   1E66                     155 _theme_textures:
   1E66 32 29               156 	.dw _level0_walls_tileset
   1E68 3C 33               157 	.dw _level1_walls_tileset
   1E6A 3C 33               158 	.dw _level1_walls_tileset
   1E6C 3C 33               159 	.dw _level1_walls_tileset
   1E6E                     160 _enemy_textures:
   1E6E AA 24               161 	.dw _level0_enemies_tileset
   1E70 AA 24               162 	.dw _level0_enemies_tileset
   1E72 AA 24               163 	.dw _level0_enemies_tileset
   1E74 AA 24               164 	.dw _level0_enemies_tileset
                            165 ;src/Textures.c:49: void uncompress_theme_textures(u8 level){//TODO implement
                            166 ;	---------------------------------
                            167 ; Function uncompress_theme_textures
                            168 ; ---------------------------------
   1E76                     169 _uncompress_theme_textures::
   1E76 DD E5         [15]  170 	push	ix
   1E78 DD 21 00 00   [14]  171 	ld	ix,#0
   1E7C DD 39         [15]  172 	add	ix,sp
                            173 ;src/Textures.c:50: uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_TEXTURES,TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   1E7E 01 66 1E      [10]  174 	ld	bc,#_theme_textures+0
   1E81 DD 6E 04      [19]  175 	ld	l,4 (ix)
   1E84 26 00         [ 7]  176 	ld	h,#0x00
   1E86 29            [11]  177 	add	hl, hl
   1E87 09            [11]  178 	add	hl,bc
   1E88 4D            [ 4]  179 	ld	c,l
   1E89 44            [ 4]  180 	ld	b,h
   1E8A 5E            [ 7]  181 	ld	e,(hl)
   1E8B 23            [ 6]  182 	inc	hl
   1E8C 66            [ 7]  183 	ld	h,(hl)
   1E8D 6B            [ 4]  184 	ld	l, e
   1E8E 5E            [ 7]  185 	ld	e,(hl)
   1E8F 23            [ 6]  186 	inc	hl
   1E90 56            [ 7]  187 	ld	d,(hl)
   1E91 C5            [11]  188 	push	bc
   1E92 21 20 10      [10]  189 	ld	hl,#0x1020
   1E95 E5            [11]  190 	push	hl
   1E96 21 00 64      [10]  191 	ld	hl,#0x6400
   1E99 E5            [11]  192 	push	hl
   1E9A D5            [11]  193 	push	de
   1E9B CD B8 1D      [17]  194 	call	_uncompress_texture
   1E9E 21 06 00      [10]  195 	ld	hl,#6
   1EA1 39            [11]  196 	add	hl,sp
   1EA2 F9            [ 6]  197 	ld	sp,hl
   1EA3 C1            [10]  198 	pop	bc
                            199 ;src/Textures.c:51: uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_TEXTURES+1024),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   1EA4 69            [ 4]  200 	ld	l, c
   1EA5 60            [ 4]  201 	ld	h, b
   1EA6 5E            [ 7]  202 	ld	e,(hl)
   1EA7 23            [ 6]  203 	inc	hl
   1EA8 66            [ 7]  204 	ld	h,(hl)
   1EA9 6B            [ 4]  205 	ld	l, e
   1EAA 23            [ 6]  206 	inc	hl
   1EAB 23            [ 6]  207 	inc	hl
   1EAC 5E            [ 7]  208 	ld	e,(hl)
   1EAD 23            [ 6]  209 	inc	hl
   1EAE 56            [ 7]  210 	ld	d,(hl)
   1EAF C5            [11]  211 	push	bc
   1EB0 21 20 10      [10]  212 	ld	hl,#0x1020
   1EB3 E5            [11]  213 	push	hl
   1EB4 21 00 68      [10]  214 	ld	hl,#0x6800
   1EB7 E5            [11]  215 	push	hl
   1EB8 D5            [11]  216 	push	de
   1EB9 CD B8 1D      [17]  217 	call	_uncompress_texture
   1EBC 21 06 00      [10]  218 	ld	hl,#6
   1EBF 39            [11]  219 	add	hl,sp
   1EC0 F9            [ 6]  220 	ld	sp,hl
   1EC1 C1            [10]  221 	pop	bc
                            222 ;src/Textures.c:52: uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_TEXTURES+2048),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   1EC2 69            [ 4]  223 	ld	l, c
   1EC3 60            [ 4]  224 	ld	h, b
   1EC4 5E            [ 7]  225 	ld	e,(hl)
   1EC5 23            [ 6]  226 	inc	hl
   1EC6 66            [ 7]  227 	ld	h,(hl)
   1EC7 6B            [ 4]  228 	ld	l, e
   1EC8 11 04 00      [10]  229 	ld	de, #0x0004
   1ECB 19            [11]  230 	add	hl, de
   1ECC 5E            [ 7]  231 	ld	e,(hl)
   1ECD 23            [ 6]  232 	inc	hl
   1ECE 56            [ 7]  233 	ld	d,(hl)
   1ECF C5            [11]  234 	push	bc
   1ED0 21 20 10      [10]  235 	ld	hl,#0x1020
   1ED3 E5            [11]  236 	push	hl
   1ED4 21 00 6C      [10]  237 	ld	hl,#0x6C00
   1ED7 E5            [11]  238 	push	hl
   1ED8 D5            [11]  239 	push	de
   1ED9 CD B8 1D      [17]  240 	call	_uncompress_texture
   1EDC 21 06 00      [10]  241 	ld	hl,#6
   1EDF 39            [11]  242 	add	hl,sp
   1EE0 F9            [ 6]  243 	ld	sp,hl
   1EE1 C1            [10]  244 	pop	bc
                            245 ;src/Textures.c:53: uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_TEXTURES+3072),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   1EE2 69            [ 4]  246 	ld	l, c
   1EE3 60            [ 4]  247 	ld	h, b
   1EE4 5E            [ 7]  248 	ld	e,(hl)
   1EE5 23            [ 6]  249 	inc	hl
   1EE6 66            [ 7]  250 	ld	h,(hl)
   1EE7 6B            [ 4]  251 	ld	l, e
   1EE8 11 06 00      [10]  252 	ld	de, #0x0006
   1EEB 19            [11]  253 	add	hl, de
   1EEC 5E            [ 7]  254 	ld	e,(hl)
   1EED 23            [ 6]  255 	inc	hl
   1EEE 56            [ 7]  256 	ld	d,(hl)
   1EEF C5            [11]  257 	push	bc
   1EF0 21 20 10      [10]  258 	ld	hl,#0x1020
   1EF3 E5            [11]  259 	push	hl
   1EF4 21 00 70      [10]  260 	ld	hl,#0x7000
   1EF7 E5            [11]  261 	push	hl
   1EF8 D5            [11]  262 	push	de
   1EF9 CD B8 1D      [17]  263 	call	_uncompress_texture
   1EFC 21 06 00      [10]  264 	ld	hl,#6
   1EFF 39            [11]  265 	add	hl,sp
   1F00 F9            [ 6]  266 	ld	sp,hl
                            267 ;src/Textures.c:54: uncompress_texture(theme_textures[level][4],(u8*)(UNCOMPRESSED_TEXTURES+4096),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   1F01 E1            [10]  268 	pop	hl
   1F02 4E            [ 7]  269 	ld	c,(hl)
   1F03 23            [ 6]  270 	inc	hl
   1F04 66            [ 7]  271 	ld	h,(hl)
   1F05 69            [ 4]  272 	ld	l, c
   1F06 11 08 00      [10]  273 	ld	de, #0x0008
   1F09 19            [11]  274 	add	hl, de
   1F0A 4E            [ 7]  275 	ld	c,(hl)
   1F0B 23            [ 6]  276 	inc	hl
   1F0C 46            [ 7]  277 	ld	b,(hl)
   1F0D 21 20 10      [10]  278 	ld	hl,#0x1020
   1F10 E5            [11]  279 	push	hl
   1F11 21 00 74      [10]  280 	ld	hl,#0x7400
   1F14 E5            [11]  281 	push	hl
   1F15 C5            [11]  282 	push	bc
   1F16 CD B8 1D      [17]  283 	call	_uncompress_texture
   1F19 21 06 00      [10]  284 	ld	hl,#6
   1F1C 39            [11]  285 	add	hl,sp
   1F1D F9            [ 6]  286 	ld	sp,hl
   1F1E DD E1         [14]  287 	pop	ix
   1F20 C9            [10]  288 	ret
                            289 ;src/Textures.c:57: void uncompress_enemy_textures(u8 level){
                            290 ;	---------------------------------
                            291 ; Function uncompress_enemy_textures
                            292 ; ---------------------------------
   1F21                     293 _uncompress_enemy_textures::
   1F21 DD E5         [15]  294 	push	ix
   1F23 DD 21 00 00   [14]  295 	ld	ix,#0
   1F27 DD 39         [15]  296 	add	ix,sp
                            297 ;src/Textures.c:58: uncompress_texture(enemy_textures[level][0],(u8*)UNCOMPRESSED_ENEMY_TEXTURES,ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   1F29 01 6E 1E      [10]  298 	ld	bc,#_enemy_textures+0
   1F2C DD 6E 04      [19]  299 	ld	l,4 (ix)
   1F2F 26 00         [ 7]  300 	ld	h,#0x00
   1F31 29            [11]  301 	add	hl, hl
   1F32 09            [11]  302 	add	hl,bc
   1F33 4D            [ 4]  303 	ld	c,l
   1F34 44            [ 4]  304 	ld	b,h
   1F35 5E            [ 7]  305 	ld	e,(hl)
   1F36 23            [ 6]  306 	inc	hl
   1F37 66            [ 7]  307 	ld	h,(hl)
   1F38 6B            [ 4]  308 	ld	l, e
   1F39 5E            [ 7]  309 	ld	e,(hl)
   1F3A 23            [ 6]  310 	inc	hl
   1F3B 56            [ 7]  311 	ld	d,(hl)
   1F3C C5            [11]  312 	push	bc
   1F3D 21 18 0C      [10]  313 	ld	hl,#0x0C18
   1F40 E5            [11]  314 	push	hl
   1F41 21 00 78      [10]  315 	ld	hl,#0x7800
   1F44 E5            [11]  316 	push	hl
   1F45 D5            [11]  317 	push	de
   1F46 CD B8 1D      [17]  318 	call	_uncompress_texture
   1F49 21 06 00      [10]  319 	ld	hl,#6
   1F4C 39            [11]  320 	add	hl,sp
   1F4D F9            [ 6]  321 	ld	sp,hl
   1F4E C1            [10]  322 	pop	bc
                            323 ;src/Textures.c:59: uncompress_texture(enemy_textures[level][1],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+576),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   1F4F 69            [ 4]  324 	ld	l, c
   1F50 60            [ 4]  325 	ld	h, b
   1F51 5E            [ 7]  326 	ld	e,(hl)
   1F52 23            [ 6]  327 	inc	hl
   1F53 66            [ 7]  328 	ld	h,(hl)
   1F54 6B            [ 4]  329 	ld	l, e
   1F55 23            [ 6]  330 	inc	hl
   1F56 23            [ 6]  331 	inc	hl
   1F57 5E            [ 7]  332 	ld	e,(hl)
   1F58 23            [ 6]  333 	inc	hl
   1F59 56            [ 7]  334 	ld	d,(hl)
   1F5A C5            [11]  335 	push	bc
   1F5B 21 18 0C      [10]  336 	ld	hl,#0x0C18
   1F5E E5            [11]  337 	push	hl
   1F5F 21 40 7A      [10]  338 	ld	hl,#0x7A40
   1F62 E5            [11]  339 	push	hl
   1F63 D5            [11]  340 	push	de
   1F64 CD B8 1D      [17]  341 	call	_uncompress_texture
   1F67 21 06 00      [10]  342 	ld	hl,#6
   1F6A 39            [11]  343 	add	hl,sp
   1F6B F9            [ 6]  344 	ld	sp,hl
   1F6C C1            [10]  345 	pop	bc
                            346 ;src/Textures.c:60: uncompress_texture(enemy_textures[level][2],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1152),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   1F6D 69            [ 4]  347 	ld	l, c
   1F6E 60            [ 4]  348 	ld	h, b
   1F6F 5E            [ 7]  349 	ld	e,(hl)
   1F70 23            [ 6]  350 	inc	hl
   1F71 66            [ 7]  351 	ld	h,(hl)
   1F72 6B            [ 4]  352 	ld	l, e
   1F73 11 04 00      [10]  353 	ld	de, #0x0004
   1F76 19            [11]  354 	add	hl, de
   1F77 5E            [ 7]  355 	ld	e,(hl)
   1F78 23            [ 6]  356 	inc	hl
   1F79 56            [ 7]  357 	ld	d,(hl)
   1F7A C5            [11]  358 	push	bc
   1F7B 21 18 0C      [10]  359 	ld	hl,#0x0C18
   1F7E E5            [11]  360 	push	hl
   1F7F 21 80 7C      [10]  361 	ld	hl,#0x7C80
   1F82 E5            [11]  362 	push	hl
   1F83 D5            [11]  363 	push	de
   1F84 CD B8 1D      [17]  364 	call	_uncompress_texture
   1F87 21 06 00      [10]  365 	ld	hl,#6
   1F8A 39            [11]  366 	add	hl,sp
   1F8B F9            [ 6]  367 	ld	sp,hl
                            368 ;src/Textures.c:61: uncompress_texture(enemy_textures[level][3],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1728),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
   1F8C E1            [10]  369 	pop	hl
   1F8D 4E            [ 7]  370 	ld	c,(hl)
   1F8E 23            [ 6]  371 	inc	hl
   1F8F 66            [ 7]  372 	ld	h,(hl)
   1F90 69            [ 4]  373 	ld	l, c
   1F91 11 06 00      [10]  374 	ld	de, #0x0006
   1F94 19            [11]  375 	add	hl, de
   1F95 4E            [ 7]  376 	ld	c,(hl)
   1F96 23            [ 6]  377 	inc	hl
   1F97 46            [ 7]  378 	ld	b,(hl)
   1F98 21 18 0C      [10]  379 	ld	hl,#0x0C18
   1F9B E5            [11]  380 	push	hl
   1F9C 21 C0 7E      [10]  381 	ld	hl,#0x7EC0
   1F9F E5            [11]  382 	push	hl
   1FA0 C5            [11]  383 	push	bc
   1FA1 CD B8 1D      [17]  384 	call	_uncompress_texture
   1FA4 21 06 00      [10]  385 	ld	hl,#6
   1FA7 39            [11]  386 	add	hl,sp
   1FA8 F9            [ 6]  387 	ld	sp,hl
   1FA9 DD E1         [14]  388 	pop	ix
   1FAB C9            [10]  389 	ret
                            390 ;src/Textures.c:64: void uncompress_item_textures(){
                            391 ;	---------------------------------
                            392 ; Function uncompress_item_textures
                            393 ; ---------------------------------
   1FAC                     394 _uncompress_item_textures::
                            395 ;src/Textures.c:66: }
   1FAC C9            [10]  396 	ret
                            397 	.area _CODE
                            398 	.area _INITIALIZER
                            399 	.area _CABS (ABS)
