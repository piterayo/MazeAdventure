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
                             11 	.globl _uncompress_texture
                             12 	.globl _theme_textures
                             13 	.globl _uncompress_theme_textures
                             14 ;--------------------------------------------------------
                             15 ; special function registers
                             16 ;--------------------------------------------------------
                             17 ;--------------------------------------------------------
                             18 ; ram data
                             19 ;--------------------------------------------------------
                             20 	.area _DATA
                             21 ;--------------------------------------------------------
                             22 ; ram data
                             23 ;--------------------------------------------------------
                             24 	.area _INITIALIZED
                             25 ;--------------------------------------------------------
                             26 ; absolute external ram data
                             27 ;--------------------------------------------------------
                             28 	.area _DABS (ABS)
                             29 ;--------------------------------------------------------
                             30 ; global & static initialisations
                             31 ;--------------------------------------------------------
                             32 	.area _HOME
                             33 	.area _GSINIT
                             34 	.area _GSFINAL
                             35 	.area _GSINIT
                             36 ;--------------------------------------------------------
                             37 ; Home
                             38 ;--------------------------------------------------------
                             39 	.area _HOME
                             40 	.area _HOME
                             41 ;--------------------------------------------------------
                             42 ; code
                             43 ;--------------------------------------------------------
                             44 	.area _CODE
                             45 ;src/Textures.c:12: void uncompress_texture(u8* texture, u8* position, u8 sizeX, u8 sizeY){
                             46 ;	---------------------------------
                             47 ; Function uncompress_texture
                             48 ; ---------------------------------
   524A                      49 _uncompress_texture::
   524A DD E5         [15]   50 	push	ix
   524C DD 21 00 00   [14]   51 	ld	ix,#0
   5250 DD 39         [15]   52 	add	ix,sp
   5252 21 FA FF      [10]   53 	ld	hl,#-6
   5255 39            [11]   54 	add	hl,sp
   5256 F9            [ 6]   55 	ld	sp,hl
                             56 ;src/Textures.c:19: while(sizeX){
   5257 DD 7E 08      [19]   57 	ld	a,8 (ix)
   525A DD 77 FE      [19]   58 	ld	-2 (ix),a
   525D DD 5E 06      [19]   59 	ld	e,6 (ix)
   5260 DD 56 07      [19]   60 	ld	d,7 (ix)
   5263                      61 00104$:
   5263 DD 7E FE      [19]   62 	ld	a,-2 (ix)
   5266 B7            [ 4]   63 	or	a, a
   5267 28 65         [12]   64 	jr	Z,00107$
                             65 ;src/Textures.c:22: currPos = position;
   5269 DD 73 FC      [19]   66 	ld	-4 (ix),e
   526C DD 72 FD      [19]   67 	ld	-3 (ix),d
                             68 ;src/Textures.c:23: while(sizeY){
   526F DD 36 FF 10   [19]   69 	ld	-1 (ix),#0x10
   5273 DD 4E 04      [19]   70 	ld	c,4 (ix)
   5276 DD 46 05      [19]   71 	ld	b,5 (ix)
   5279                      72 00101$:
   5279 DD 7E FF      [19]   73 	ld	a,-1 (ix)
   527C B7            [ 4]   74 	or	a, a
   527D 28 43         [12]   75 	jr	Z,00113$
                             76 ;src/Textures.c:24: p1 = (*texture) & pixelMask[0];
   527F 0A            [ 7]   77 	ld	a,(bc)
   5280 21 09 4A      [10]   78 	ld	hl, #_pixelMask + 0
   5283 6E            [ 7]   79 	ld	l,(hl)
   5284 A5            [ 4]   80 	and	a, l
                             81 ;src/Textures.c:25: p1= p1 | (p1>>1);
   5285 6F            [ 4]   82 	ld	l,a
   5286 CB 3F         [ 8]   83 	srl	a
   5288 B5            [ 4]   84 	or	a, l
                             85 ;src/Textures.c:26: *currPos = p1;
   5289 DD 6E FC      [19]   86 	ld	l,-4 (ix)
   528C DD 66 FD      [19]   87 	ld	h,-3 (ix)
   528F 77            [ 7]   88 	ld	(hl),a
                             89 ;src/Textures.c:27: currPos+=TEXTURE_WIDTH;
   5290 DD 7E FC      [19]   90 	ld	a,-4 (ix)
   5293 C6 20         [ 7]   91 	add	a, #0x20
   5295 DD 77 FA      [19]   92 	ld	-6 (ix),a
   5298 DD 7E FD      [19]   93 	ld	a,-3 (ix)
   529B CE 00         [ 7]   94 	adc	a, #0x00
   529D DD 77 FB      [19]   95 	ld	-5 (ix),a
                             96 ;src/Textures.c:29: p2 = (*texture) & pixelMask[1];
   52A0 0A            [ 7]   97 	ld	a,(bc)
   52A1 21 0A 4A      [10]   98 	ld	hl, #_pixelMask + 1
   52A4 6E            [ 7]   99 	ld	l,(hl)
   52A5 A5            [ 4]  100 	and	a, l
                            101 ;src/Textures.c:30: p2 = p2 | (p2<<1);
   52A6 6F            [ 4]  102 	ld	l,a
   52A7 87            [ 4]  103 	add	a, a
   52A8 B5            [ 4]  104 	or	a, l
                            105 ;src/Textures.c:31: *currPos = p2;
   52A9 E1            [10]  106 	pop	hl
   52AA E5            [11]  107 	push	hl
   52AB 77            [ 7]  108 	ld	(hl),a
                            109 ;src/Textures.c:32: currPos+=TEXTURE_WIDTH;
   52AC DD 7E FA      [19]  110 	ld	a,-6 (ix)
   52AF C6 20         [ 7]  111 	add	a, #0x20
   52B1 DD 77 FC      [19]  112 	ld	-4 (ix),a
   52B4 DD 7E FB      [19]  113 	ld	a,-5 (ix)
   52B7 CE 00         [ 7]  114 	adc	a, #0x00
   52B9 DD 77 FD      [19]  115 	ld	-3 (ix),a
                            116 ;src/Textures.c:33: --sizeY;
   52BC DD 35 FF      [23]  117 	dec	-1 (ix)
                            118 ;src/Textures.c:34: ++texture;
   52BF 03            [ 6]  119 	inc	bc
   52C0 18 B7         [12]  120 	jr	00101$
   52C2                     121 00113$:
   52C2 DD 71 04      [19]  122 	ld	4 (ix),c
   52C5 DD 70 05      [19]  123 	ld	5 (ix),b
                            124 ;src/Textures.c:36: --sizeX;
   52C8 DD 35 FE      [23]  125 	dec	-2 (ix)
                            126 ;src/Textures.c:37: ++position;
   52CB 13            [ 6]  127 	inc	de
   52CC 18 95         [12]  128 	jr	00104$
   52CE                     129 00107$:
   52CE DD F9         [10]  130 	ld	sp, ix
   52D0 DD E1         [14]  131 	pop	ix
   52D2 C9            [10]  132 	ret
   52D3                     133 _theme_textures:
   52D3 15 5A               134 	.dw _g_tile_walls_0
   52D5 15 5A               135 	.dw _g_tile_walls_0
   52D7 15 5A               136 	.dw _g_tile_walls_0
   52D9 15 5A               137 	.dw _g_tile_walls_0
                            138 ;src/Textures.c:42: void uncompress_theme_textures(u8 level){//TODO implement
                            139 ;	---------------------------------
                            140 ; Function uncompress_theme_textures
                            141 ; ---------------------------------
   52DB                     142 _uncompress_theme_textures::
   52DB DD E5         [15]  143 	push	ix
   52DD DD 21 00 00   [14]  144 	ld	ix,#0
   52E1 DD 39         [15]  145 	add	ix,sp
                            146 ;src/Textures.c:43: uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_LEVEL_TEXTURES,TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   52E3 01 D3 52      [10]  147 	ld	bc,#_theme_textures+0
   52E6 DD 6E 04      [19]  148 	ld	l,4 (ix)
   52E9 26 00         [ 7]  149 	ld	h,#0x00
   52EB 29            [11]  150 	add	hl, hl
   52EC 09            [11]  151 	add	hl,bc
   52ED 4D            [ 4]  152 	ld	c,l
   52EE 44            [ 4]  153 	ld	b,h
   52EF 5E            [ 7]  154 	ld	e,(hl)
   52F0 23            [ 6]  155 	inc	hl
   52F1 66            [ 7]  156 	ld	h,(hl)
   52F2 6B            [ 4]  157 	ld	l, e
   52F3 5E            [ 7]  158 	ld	e,(hl)
   52F4 23            [ 6]  159 	inc	hl
   52F5 56            [ 7]  160 	ld	d,(hl)
   52F6 C5            [11]  161 	push	bc
   52F7 21 20 10      [10]  162 	ld	hl,#0x1020
   52FA E5            [11]  163 	push	hl
   52FB 21 40 08      [10]  164 	ld	hl,#0x0840
   52FE E5            [11]  165 	push	hl
   52FF D5            [11]  166 	push	de
   5300 CD 4A 52      [17]  167 	call	_uncompress_texture
   5303 21 06 00      [10]  168 	ld	hl,#6
   5306 39            [11]  169 	add	hl,sp
   5307 F9            [ 6]  170 	ld	sp,hl
   5308 C1            [10]  171 	pop	bc
                            172 ;src/Textures.c:44: uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+1024),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   5309 69            [ 4]  173 	ld	l, c
   530A 60            [ 4]  174 	ld	h, b
   530B 5E            [ 7]  175 	ld	e,(hl)
   530C 23            [ 6]  176 	inc	hl
   530D 66            [ 7]  177 	ld	h,(hl)
   530E 6B            [ 4]  178 	ld	l, e
   530F 23            [ 6]  179 	inc	hl
   5310 23            [ 6]  180 	inc	hl
   5311 5E            [ 7]  181 	ld	e,(hl)
   5312 23            [ 6]  182 	inc	hl
   5313 56            [ 7]  183 	ld	d,(hl)
   5314 C5            [11]  184 	push	bc
   5315 21 20 10      [10]  185 	ld	hl,#0x1020
   5318 E5            [11]  186 	push	hl
   5319 21 40 0C      [10]  187 	ld	hl,#0x0C40
   531C E5            [11]  188 	push	hl
   531D D5            [11]  189 	push	de
   531E CD 4A 52      [17]  190 	call	_uncompress_texture
   5321 21 06 00      [10]  191 	ld	hl,#6
   5324 39            [11]  192 	add	hl,sp
   5325 F9            [ 6]  193 	ld	sp,hl
   5326 C1            [10]  194 	pop	bc
                            195 ;src/Textures.c:45: uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+2048),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   5327 69            [ 4]  196 	ld	l, c
   5328 60            [ 4]  197 	ld	h, b
   5329 5E            [ 7]  198 	ld	e,(hl)
   532A 23            [ 6]  199 	inc	hl
   532B 66            [ 7]  200 	ld	h,(hl)
   532C 6B            [ 4]  201 	ld	l, e
   532D 11 04 00      [10]  202 	ld	de, #0x0004
   5330 19            [11]  203 	add	hl, de
   5331 5E            [ 7]  204 	ld	e,(hl)
   5332 23            [ 6]  205 	inc	hl
   5333 56            [ 7]  206 	ld	d,(hl)
   5334 C5            [11]  207 	push	bc
   5335 21 20 10      [10]  208 	ld	hl,#0x1020
   5338 E5            [11]  209 	push	hl
   5339 2E 40         [ 7]  210 	ld	l, #0x40
   533B E5            [11]  211 	push	hl
   533C D5            [11]  212 	push	de
   533D CD 4A 52      [17]  213 	call	_uncompress_texture
   5340 21 06 00      [10]  214 	ld	hl,#6
   5343 39            [11]  215 	add	hl,sp
   5344 F9            [ 6]  216 	ld	sp,hl
                            217 ;src/Textures.c:46: uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+3072),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   5345 E1            [10]  218 	pop	hl
   5346 4E            [ 7]  219 	ld	c,(hl)
   5347 23            [ 6]  220 	inc	hl
   5348 66            [ 7]  221 	ld	h,(hl)
   5349 69            [ 4]  222 	ld	l, c
   534A 11 06 00      [10]  223 	ld	de, #0x0006
   534D 19            [11]  224 	add	hl, de
   534E 4E            [ 7]  225 	ld	c,(hl)
   534F 23            [ 6]  226 	inc	hl
   5350 46            [ 7]  227 	ld	b,(hl)
   5351 21 20 10      [10]  228 	ld	hl,#0x1020
   5354 E5            [11]  229 	push	hl
   5355 21 40 14      [10]  230 	ld	hl,#0x1440
   5358 E5            [11]  231 	push	hl
   5359 C5            [11]  232 	push	bc
   535A CD 4A 52      [17]  233 	call	_uncompress_texture
   535D 21 06 00      [10]  234 	ld	hl,#6
   5360 39            [11]  235 	add	hl,sp
   5361 F9            [ 6]  236 	ld	sp,hl
   5362 DD E1         [14]  237 	pop	ix
   5364 C9            [10]  238 	ret
                            239 	.area _CODE
                            240 	.area _INITIALIZER
                            241 	.area _CABS (ABS)
