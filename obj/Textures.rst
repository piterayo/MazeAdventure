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
                             45 ;src/Textures.c:12: void uncompress_texture(u8* texture, u8* position){
                             46 ;	---------------------------------
                             47 ; Function uncompress_texture
                             48 ; ---------------------------------
   50F3                      49 _uncompress_texture::
   50F3 DD E5         [15]   50 	push	ix
   50F5 DD 21 00 00   [14]   51 	ld	ix,#0
   50F9 DD 39         [15]   52 	add	ix,sp
   50FB 21 FA FF      [10]   53 	ld	hl,#-6
   50FE 39            [11]   54 	add	hl,sp
   50FF F9            [ 6]   55 	ld	sp,hl
                             56 ;src/Textures.c:19: while(i){
   5100 DD 36 FD 20   [19]   57 	ld	-3 (ix),#0x20
   5104 DD 5E 06      [19]   58 	ld	e,6 (ix)
   5107 DD 56 07      [19]   59 	ld	d,7 (ix)
   510A                      60 00104$:
   510A DD 7E FD      [19]   61 	ld	a,-3 (ix)
   510D B7            [ 4]   62 	or	a, a
   510E 28 65         [12]   63 	jr	Z,00107$
                             64 ;src/Textures.c:22: currPos = position;
   5110 DD 73 FE      [19]   65 	ld	-2 (ix),e
   5113 DD 72 FF      [19]   66 	ld	-1 (ix),d
                             67 ;src/Textures.c:23: while(j){//TEXTURE_HEIGHT_HALF -> 2 pixels per byte of compressed texture
   5116 DD 36 FC 10   [19]   68 	ld	-4 (ix),#0x10
   511A DD 4E 04      [19]   69 	ld	c,4 (ix)
   511D DD 46 05      [19]   70 	ld	b,5 (ix)
   5120                      71 00101$:
   5120 DD 7E FC      [19]   72 	ld	a,-4 (ix)
   5123 B7            [ 4]   73 	or	a, a
   5124 28 43         [12]   74 	jr	Z,00113$
                             75 ;src/Textures.c:24: p1 = (*texture) & pixelMask[0];
   5126 0A            [ 7]   76 	ld	a,(bc)
   5127 21 CA 48      [10]   77 	ld	hl, #_pixelMask + 0
   512A 6E            [ 7]   78 	ld	l,(hl)
   512B A5            [ 4]   79 	and	a, l
                             80 ;src/Textures.c:25: p1= p1 | (p1>>1);
   512C 6F            [ 4]   81 	ld	l,a
   512D CB 3F         [ 8]   82 	srl	a
   512F B5            [ 4]   83 	or	a, l
                             84 ;src/Textures.c:26: *currPos = p1;
   5130 DD 6E FE      [19]   85 	ld	l,-2 (ix)
   5133 DD 66 FF      [19]   86 	ld	h,-1 (ix)
   5136 77            [ 7]   87 	ld	(hl),a
                             88 ;src/Textures.c:27: currPos+=TEXTURE_WIDTH;
   5137 DD 7E FE      [19]   89 	ld	a,-2 (ix)
   513A C6 20         [ 7]   90 	add	a, #0x20
   513C DD 77 FA      [19]   91 	ld	-6 (ix),a
   513F DD 7E FF      [19]   92 	ld	a,-1 (ix)
   5142 CE 00         [ 7]   93 	adc	a, #0x00
   5144 DD 77 FB      [19]   94 	ld	-5 (ix),a
                             95 ;src/Textures.c:29: p2 = (*texture) & pixelMask[1];
   5147 0A            [ 7]   96 	ld	a,(bc)
   5148 21 CB 48      [10]   97 	ld	hl, #_pixelMask + 1
   514B 6E            [ 7]   98 	ld	l,(hl)
   514C A5            [ 4]   99 	and	a, l
                            100 ;src/Textures.c:30: p2 = p2 | (p2<<1);
   514D 6F            [ 4]  101 	ld	l,a
   514E 87            [ 4]  102 	add	a, a
   514F B5            [ 4]  103 	or	a, l
                            104 ;src/Textures.c:31: *currPos = p2;
   5150 E1            [10]  105 	pop	hl
   5151 E5            [11]  106 	push	hl
   5152 77            [ 7]  107 	ld	(hl),a
                            108 ;src/Textures.c:32: currPos+=TEXTURE_WIDTH;
   5153 DD 7E FA      [19]  109 	ld	a,-6 (ix)
   5156 C6 20         [ 7]  110 	add	a, #0x20
   5158 DD 77 FE      [19]  111 	ld	-2 (ix),a
   515B DD 7E FB      [19]  112 	ld	a,-5 (ix)
   515E CE 00         [ 7]  113 	adc	a, #0x00
   5160 DD 77 FF      [19]  114 	ld	-1 (ix),a
                            115 ;src/Textures.c:33: --j;
   5163 DD 35 FC      [23]  116 	dec	-4 (ix)
                            117 ;src/Textures.c:34: ++texture;
   5166 03            [ 6]  118 	inc	bc
   5167 18 B7         [12]  119 	jr	00101$
   5169                     120 00113$:
   5169 DD 71 04      [19]  121 	ld	4 (ix),c
   516C DD 70 05      [19]  122 	ld	5 (ix),b
                            123 ;src/Textures.c:36: --i;
   516F DD 35 FD      [23]  124 	dec	-3 (ix)
                            125 ;src/Textures.c:37: ++position;
   5172 13            [ 6]  126 	inc	de
   5173 18 95         [12]  127 	jr	00104$
   5175                     128 00107$:
   5175 DD F9         [10]  129 	ld	sp, ix
   5177 DD E1         [14]  130 	pop	ix
   5179 C9            [10]  131 	ret
   517A                     132 _theme_textures:
   517A 19 54               133 	.dw _g_tile_walls_0
   517C 19 54               134 	.dw _g_tile_walls_0
   517E 19 54               135 	.dw _g_tile_walls_0
   5180 19 54               136 	.dw _g_tile_walls_0
                            137 ;src/Textures.c:42: void uncompress_theme_textures(u8 level){//TODO implement
                            138 ;	---------------------------------
                            139 ; Function uncompress_theme_textures
                            140 ; ---------------------------------
   5182                     141 _uncompress_theme_textures::
   5182 DD E5         [15]  142 	push	ix
   5184 DD 21 00 00   [14]  143 	ld	ix,#0
   5188 DD 39         [15]  144 	add	ix,sp
                            145 ;src/Textures.c:43: uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_LEVEL_TEXTURES);
   518A 01 7A 51      [10]  146 	ld	bc,#_theme_textures+0
   518D DD 6E 04      [19]  147 	ld	l,4 (ix)
   5190 26 00         [ 7]  148 	ld	h,#0x00
   5192 29            [11]  149 	add	hl, hl
   5193 09            [11]  150 	add	hl,bc
   5194 4D            [ 4]  151 	ld	c,l
   5195 44            [ 4]  152 	ld	b,h
   5196 5E            [ 7]  153 	ld	e,(hl)
   5197 23            [ 6]  154 	inc	hl
   5198 66            [ 7]  155 	ld	h,(hl)
   5199 6B            [ 4]  156 	ld	l, e
   519A 5E            [ 7]  157 	ld	e,(hl)
   519B 23            [ 6]  158 	inc	hl
   519C 56            [ 7]  159 	ld	d,(hl)
   519D C5            [11]  160 	push	bc
   519E 21 40 08      [10]  161 	ld	hl,#0x0840
   51A1 E5            [11]  162 	push	hl
   51A2 D5            [11]  163 	push	de
   51A3 CD F3 50      [17]  164 	call	_uncompress_texture
   51A6 F1            [10]  165 	pop	af
   51A7 F1            [10]  166 	pop	af
   51A8 C1            [10]  167 	pop	bc
                            168 ;src/Textures.c:44: uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+1024));
   51A9 69            [ 4]  169 	ld	l, c
   51AA 60            [ 4]  170 	ld	h, b
   51AB 5E            [ 7]  171 	ld	e,(hl)
   51AC 23            [ 6]  172 	inc	hl
   51AD 66            [ 7]  173 	ld	h,(hl)
   51AE 6B            [ 4]  174 	ld	l, e
   51AF 23            [ 6]  175 	inc	hl
   51B0 23            [ 6]  176 	inc	hl
   51B1 5E            [ 7]  177 	ld	e,(hl)
   51B2 23            [ 6]  178 	inc	hl
   51B3 56            [ 7]  179 	ld	d,(hl)
   51B4 C5            [11]  180 	push	bc
   51B5 21 40 0C      [10]  181 	ld	hl,#0x0C40
   51B8 E5            [11]  182 	push	hl
   51B9 D5            [11]  183 	push	de
   51BA CD F3 50      [17]  184 	call	_uncompress_texture
   51BD F1            [10]  185 	pop	af
   51BE F1            [10]  186 	pop	af
   51BF C1            [10]  187 	pop	bc
                            188 ;src/Textures.c:45: uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+2048));
   51C0 69            [ 4]  189 	ld	l, c
   51C1 60            [ 4]  190 	ld	h, b
   51C2 5E            [ 7]  191 	ld	e,(hl)
   51C3 23            [ 6]  192 	inc	hl
   51C4 66            [ 7]  193 	ld	h,(hl)
   51C5 6B            [ 4]  194 	ld	l, e
   51C6 11 04 00      [10]  195 	ld	de, #0x0004
   51C9 19            [11]  196 	add	hl, de
   51CA 5E            [ 7]  197 	ld	e,(hl)
   51CB 23            [ 6]  198 	inc	hl
   51CC 56            [ 7]  199 	ld	d,(hl)
   51CD C5            [11]  200 	push	bc
   51CE 21 40 10      [10]  201 	ld	hl,#0x1040
   51D1 E5            [11]  202 	push	hl
   51D2 D5            [11]  203 	push	de
   51D3 CD F3 50      [17]  204 	call	_uncompress_texture
   51D6 F1            [10]  205 	pop	af
   51D7 F1            [10]  206 	pop	af
                            207 ;src/Textures.c:46: uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+3072));
   51D8 E1            [10]  208 	pop	hl
   51D9 4E            [ 7]  209 	ld	c,(hl)
   51DA 23            [ 6]  210 	inc	hl
   51DB 66            [ 7]  211 	ld	h,(hl)
   51DC 69            [ 4]  212 	ld	l, c
   51DD 11 06 00      [10]  213 	ld	de, #0x0006
   51E0 19            [11]  214 	add	hl, de
   51E1 4E            [ 7]  215 	ld	c,(hl)
   51E2 23            [ 6]  216 	inc	hl
   51E3 46            [ 7]  217 	ld	b,(hl)
   51E4 21 40 14      [10]  218 	ld	hl,#0x1440
   51E7 E5            [11]  219 	push	hl
   51E8 C5            [11]  220 	push	bc
   51E9 CD F3 50      [17]  221 	call	_uncompress_texture
   51EC F1            [10]  222 	pop	af
   51ED F1            [10]  223 	pop	af
   51EE DD E1         [14]  224 	pop	ix
   51F0 C9            [10]  225 	ret
                            226 	.area _CODE
                            227 	.area _INITIALIZER
                            228 	.area _CABS (ABS)
