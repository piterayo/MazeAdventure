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
   50E0                      49 _uncompress_texture::
   50E0 DD E5         [15]   50 	push	ix
   50E2 DD 21 00 00   [14]   51 	ld	ix,#0
   50E6 DD 39         [15]   52 	add	ix,sp
   50E8 21 FA FF      [10]   53 	ld	hl,#-6
   50EB 39            [11]   54 	add	hl,sp
   50EC F9            [ 6]   55 	ld	sp,hl
                             56 ;src/Textures.c:19: while(sizeX){
   50ED DD 7E 08      [19]   57 	ld	a,8 (ix)
   50F0 DD 77 FE      [19]   58 	ld	-2 (ix),a
   50F3 DD 5E 06      [19]   59 	ld	e,6 (ix)
   50F6 DD 56 07      [19]   60 	ld	d,7 (ix)
   50F9                      61 00104$:
   50F9 DD 7E FE      [19]   62 	ld	a,-2 (ix)
   50FC B7            [ 4]   63 	or	a, a
   50FD 28 65         [12]   64 	jr	Z,00107$
                             65 ;src/Textures.c:22: currPos = position;
   50FF DD 73 FC      [19]   66 	ld	-4 (ix),e
   5102 DD 72 FD      [19]   67 	ld	-3 (ix),d
                             68 ;src/Textures.c:23: while(sizeY){
   5105 DD 36 FF 10   [19]   69 	ld	-1 (ix),#0x10
   5109 DD 4E 04      [19]   70 	ld	c,4 (ix)
   510C DD 46 05      [19]   71 	ld	b,5 (ix)
   510F                      72 00101$:
   510F DD 7E FF      [19]   73 	ld	a,-1 (ix)
   5112 B7            [ 4]   74 	or	a, a
   5113 28 43         [12]   75 	jr	Z,00113$
                             76 ;src/Textures.c:24: p1 = (*texture) & pixelMask[0];
   5115 0A            [ 7]   77 	ld	a,(bc)
   5116 21 B0 48      [10]   78 	ld	hl, #_pixelMask + 0
   5119 6E            [ 7]   79 	ld	l,(hl)
   511A A5            [ 4]   80 	and	a, l
                             81 ;src/Textures.c:25: p1= p1 | (p1>>1);
   511B 6F            [ 4]   82 	ld	l,a
   511C CB 3F         [ 8]   83 	srl	a
   511E B5            [ 4]   84 	or	a, l
                             85 ;src/Textures.c:26: *currPos = p1;
   511F DD 6E FC      [19]   86 	ld	l,-4 (ix)
   5122 DD 66 FD      [19]   87 	ld	h,-3 (ix)
   5125 77            [ 7]   88 	ld	(hl),a
                             89 ;src/Textures.c:27: currPos+=TEXTURE_WIDTH;
   5126 DD 7E FC      [19]   90 	ld	a,-4 (ix)
   5129 C6 20         [ 7]   91 	add	a, #0x20
   512B DD 77 FA      [19]   92 	ld	-6 (ix),a
   512E DD 7E FD      [19]   93 	ld	a,-3 (ix)
   5131 CE 00         [ 7]   94 	adc	a, #0x00
   5133 DD 77 FB      [19]   95 	ld	-5 (ix),a
                             96 ;src/Textures.c:29: p2 = (*texture) & pixelMask[1];
   5136 0A            [ 7]   97 	ld	a,(bc)
   5137 21 B1 48      [10]   98 	ld	hl, #_pixelMask + 1
   513A 6E            [ 7]   99 	ld	l,(hl)
   513B A5            [ 4]  100 	and	a, l
                            101 ;src/Textures.c:30: p2 = p2 | (p2<<1);
   513C 6F            [ 4]  102 	ld	l,a
   513D 87            [ 4]  103 	add	a, a
   513E B5            [ 4]  104 	or	a, l
                            105 ;src/Textures.c:31: *currPos = p2;
   513F E1            [10]  106 	pop	hl
   5140 E5            [11]  107 	push	hl
   5141 77            [ 7]  108 	ld	(hl),a
                            109 ;src/Textures.c:32: currPos+=TEXTURE_WIDTH;
   5142 DD 7E FA      [19]  110 	ld	a,-6 (ix)
   5145 C6 20         [ 7]  111 	add	a, #0x20
   5147 DD 77 FC      [19]  112 	ld	-4 (ix),a
   514A DD 7E FB      [19]  113 	ld	a,-5 (ix)
   514D CE 00         [ 7]  114 	adc	a, #0x00
   514F DD 77 FD      [19]  115 	ld	-3 (ix),a
                            116 ;src/Textures.c:33: --sizeY;
   5152 DD 35 FF      [23]  117 	dec	-1 (ix)
                            118 ;src/Textures.c:34: ++texture;
   5155 03            [ 6]  119 	inc	bc
   5156 18 B7         [12]  120 	jr	00101$
   5158                     121 00113$:
   5158 DD 71 04      [19]  122 	ld	4 (ix),c
   515B DD 70 05      [19]  123 	ld	5 (ix),b
                            124 ;src/Textures.c:36: --sizeX;
   515E DD 35 FE      [23]  125 	dec	-2 (ix)
                            126 ;src/Textures.c:37: ++position;
   5161 13            [ 6]  127 	inc	de
   5162 18 95         [12]  128 	jr	00104$
   5164                     129 00107$:
   5164 DD F9         [10]  130 	ld	sp, ix
   5166 DD E1         [14]  131 	pop	ix
   5168 C9            [10]  132 	ret
   5169                     133 _theme_textures:
   5169 43 55               134 	.dw _g_tile_walls_0
   516B 43 55               135 	.dw _g_tile_walls_0
   516D 43 55               136 	.dw _g_tile_walls_0
   516F 43 55               137 	.dw _g_tile_walls_0
                            138 ;src/Textures.c:42: void uncompress_theme_textures(u8 level){//TODO implement
                            139 ;	---------------------------------
                            140 ; Function uncompress_theme_textures
                            141 ; ---------------------------------
   5171                     142 _uncompress_theme_textures::
   5171 DD E5         [15]  143 	push	ix
   5173 DD 21 00 00   [14]  144 	ld	ix,#0
   5177 DD 39         [15]  145 	add	ix,sp
                            146 ;src/Textures.c:43: uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_LEVEL_TEXTURES,TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   5179 01 69 51      [10]  147 	ld	bc,#_theme_textures+0
   517C DD 6E 04      [19]  148 	ld	l,4 (ix)
   517F 26 00         [ 7]  149 	ld	h,#0x00
   5181 29            [11]  150 	add	hl, hl
   5182 09            [11]  151 	add	hl,bc
   5183 4D            [ 4]  152 	ld	c,l
   5184 44            [ 4]  153 	ld	b,h
   5185 5E            [ 7]  154 	ld	e,(hl)
   5186 23            [ 6]  155 	inc	hl
   5187 66            [ 7]  156 	ld	h,(hl)
   5188 6B            [ 4]  157 	ld	l, e
   5189 5E            [ 7]  158 	ld	e,(hl)
   518A 23            [ 6]  159 	inc	hl
   518B 56            [ 7]  160 	ld	d,(hl)
   518C C5            [11]  161 	push	bc
   518D 21 20 10      [10]  162 	ld	hl,#0x1020
   5190 E5            [11]  163 	push	hl
   5191 21 40 08      [10]  164 	ld	hl,#0x0840
   5194 E5            [11]  165 	push	hl
   5195 D5            [11]  166 	push	de
   5196 CD E0 50      [17]  167 	call	_uncompress_texture
   5199 21 06 00      [10]  168 	ld	hl,#6
   519C 39            [11]  169 	add	hl,sp
   519D F9            [ 6]  170 	ld	sp,hl
   519E C1            [10]  171 	pop	bc
                            172 ;src/Textures.c:44: uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+1024),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   519F 69            [ 4]  173 	ld	l, c
   51A0 60            [ 4]  174 	ld	h, b
   51A1 5E            [ 7]  175 	ld	e,(hl)
   51A2 23            [ 6]  176 	inc	hl
   51A3 66            [ 7]  177 	ld	h,(hl)
   51A4 6B            [ 4]  178 	ld	l, e
   51A5 23            [ 6]  179 	inc	hl
   51A6 23            [ 6]  180 	inc	hl
   51A7 5E            [ 7]  181 	ld	e,(hl)
   51A8 23            [ 6]  182 	inc	hl
   51A9 56            [ 7]  183 	ld	d,(hl)
   51AA C5            [11]  184 	push	bc
   51AB 21 20 10      [10]  185 	ld	hl,#0x1020
   51AE E5            [11]  186 	push	hl
   51AF 21 40 0C      [10]  187 	ld	hl,#0x0C40
   51B2 E5            [11]  188 	push	hl
   51B3 D5            [11]  189 	push	de
   51B4 CD E0 50      [17]  190 	call	_uncompress_texture
   51B7 21 06 00      [10]  191 	ld	hl,#6
   51BA 39            [11]  192 	add	hl,sp
   51BB F9            [ 6]  193 	ld	sp,hl
   51BC C1            [10]  194 	pop	bc
                            195 ;src/Textures.c:45: uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+2048),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   51BD 69            [ 4]  196 	ld	l, c
   51BE 60            [ 4]  197 	ld	h, b
   51BF 5E            [ 7]  198 	ld	e,(hl)
   51C0 23            [ 6]  199 	inc	hl
   51C1 66            [ 7]  200 	ld	h,(hl)
   51C2 6B            [ 4]  201 	ld	l, e
   51C3 11 04 00      [10]  202 	ld	de, #0x0004
   51C6 19            [11]  203 	add	hl, de
   51C7 5E            [ 7]  204 	ld	e,(hl)
   51C8 23            [ 6]  205 	inc	hl
   51C9 56            [ 7]  206 	ld	d,(hl)
   51CA C5            [11]  207 	push	bc
   51CB 21 20 10      [10]  208 	ld	hl,#0x1020
   51CE E5            [11]  209 	push	hl
   51CF 2E 40         [ 7]  210 	ld	l, #0x40
   51D1 E5            [11]  211 	push	hl
   51D2 D5            [11]  212 	push	de
   51D3 CD E0 50      [17]  213 	call	_uncompress_texture
   51D6 21 06 00      [10]  214 	ld	hl,#6
   51D9 39            [11]  215 	add	hl,sp
   51DA F9            [ 6]  216 	ld	sp,hl
                            217 ;src/Textures.c:46: uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+3072),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
   51DB E1            [10]  218 	pop	hl
   51DC 4E            [ 7]  219 	ld	c,(hl)
   51DD 23            [ 6]  220 	inc	hl
   51DE 66            [ 7]  221 	ld	h,(hl)
   51DF 69            [ 4]  222 	ld	l, c
   51E0 11 06 00      [10]  223 	ld	de, #0x0006
   51E3 19            [11]  224 	add	hl, de
   51E4 4E            [ 7]  225 	ld	c,(hl)
   51E5 23            [ 6]  226 	inc	hl
   51E6 46            [ 7]  227 	ld	b,(hl)
   51E7 21 20 10      [10]  228 	ld	hl,#0x1020
   51EA E5            [11]  229 	push	hl
   51EB 21 40 14      [10]  230 	ld	hl,#0x1440
   51EE E5            [11]  231 	push	hl
   51EF C5            [11]  232 	push	bc
   51F0 CD E0 50      [17]  233 	call	_uncompress_texture
   51F3 21 06 00      [10]  234 	ld	hl,#6
   51F6 39            [11]  235 	add	hl,sp
   51F7 F9            [ 6]  236 	ld	sp,hl
   51F8 DD E1         [14]  237 	pop	ix
   51FA C9            [10]  238 	ret
                            239 	.area _CODE
                            240 	.area _INITIALIZER
                            241 	.area _CABS (ABS)
