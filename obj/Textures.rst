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
                             12 	.globl _uncompress_texture_rle
                             13 	.globl _enemy_textures_length
                             14 	.globl _enemy_textures
                             15 	.globl _theme_textures_length
                             16 	.globl _theme_textures
                             17 	.globl _uncompress_theme_textures
                             18 	.globl _uncompress_enemy_textures
                             19 ;--------------------------------------------------------
                             20 ; special function registers
                             21 ;--------------------------------------------------------
                             22 ;--------------------------------------------------------
                             23 ; ram data
                             24 ;--------------------------------------------------------
                             25 	.area _DATA
                             26 ;--------------------------------------------------------
                             27 ; ram data
                             28 ;--------------------------------------------------------
                             29 	.area _INITIALIZED
                             30 ;--------------------------------------------------------
                             31 ; absolute external ram data
                             32 ;--------------------------------------------------------
                             33 	.area _DABS (ABS)
                             34 ;--------------------------------------------------------
                             35 ; global & static initialisations
                             36 ;--------------------------------------------------------
                             37 	.area _HOME
                             38 	.area _GSINIT
                             39 	.area _GSFINAL
                             40 	.area _GSINIT
                             41 ;--------------------------------------------------------
                             42 ; Home
                             43 ;--------------------------------------------------------
                             44 	.area _HOME
                             45 	.area _HOME
                             46 ;--------------------------------------------------------
                             47 ; code
                             48 ;--------------------------------------------------------
                             49 	.area _CODE
                             50 ;src/Textures.c:33: void uncompress_texture_rle(u8* position, u8* texture_set, u16 length){
                             51 ;	---------------------------------
                             52 ; Function uncompress_texture_rle
                             53 ; ---------------------------------
   23C7                      54 _uncompress_texture_rle::
   23C7 DD E5         [15]   55 	push	ix
   23C9 DD 21 00 00   [14]   56 	ld	ix,#0
   23CD DD 39         [15]   57 	add	ix,sp
   23CF 3B            [ 6]   58 	dec	sp
                             59 ;src/Textures.c:36: while(length){
   23D0 DD 4E 06      [19]   60 	ld	c,6 (ix)
   23D3 DD 46 07      [19]   61 	ld	b,7 (ix)
   23D6 DD 5E 08      [19]   62 	ld	e,8 (ix)
   23D9 DD 56 09      [19]   63 	ld	d,9 (ix)
   23DC                      64 00104$:
   23DC 7A            [ 4]   65 	ld	a,d
   23DD B3            [ 4]   66 	or	a,e
   23DE 28 47         [12]   67 	jr	Z,00107$
                             68 ;src/Textures.c:37: value = (*texture_set)&0x0F;
   23E0 0A            [ 7]   69 	ld	a,(bc)
   23E1 67            [ 4]   70 	ld	h,a
   23E2 E6 0F         [ 7]   71 	and	a, #0x0F
   23E4 6F            [ 4]   72 	ld	l,a
                             73 ;src/Textures.c:38: counter = ((*texture_set)>>4)+1;
   23E5 7C            [ 4]   74 	ld	a,h
   23E6 07            [ 4]   75 	rlca
   23E7 07            [ 4]   76 	rlca
   23E8 07            [ 4]   77 	rlca
   23E9 07            [ 4]   78 	rlca
   23EA E6 0F         [ 7]   79 	and	a,#0x0F
   23EC 3C            [ 4]   80 	inc	a
   23ED DD 77 FF      [19]   81 	ld	-1 (ix),a
                             82 ;src/Textures.c:39: while(counter){
   23F0 3E A3         [ 7]   83 	ld	a,#<(_g_colors)
   23F2 85            [ 4]   84 	add	a, l
   23F3 6F            [ 4]   85 	ld	l,a
   23F4 3E 0A         [ 7]   86 	ld	a,#>(_g_colors)
   23F6 CE 00         [ 7]   87 	adc	a, #0x00
   23F8 67            [ 4]   88 	ld	h,a
   23F9 E5            [11]   89 	push	hl
   23FA DD 6E 04      [19]   90 	ld	l,4 (ix)
   23FD DD 66 05      [19]   91 	ld	h,5 (ix)
   2400 E5            [11]   92 	push	hl
   2401 FD E1         [14]   93 	pop	iy
   2403 E1            [10]   94 	pop	hl
   2404                      95 00101$:
   2404 DD 7E FF      [19]   96 	ld	a,-1 (ix)
   2407 B7            [ 4]   97 	or	a, a
   2408 28 0B         [12]   98 	jr	Z,00113$
                             99 ;src/Textures.c:40: *position=g_colors[value];
   240A 7E            [ 7]  100 	ld	a,(hl)
   240B FD 77 00      [19]  101 	ld	0 (iy), a
                            102 ;src/Textures.c:41: ++position;
   240E FD 23         [10]  103 	inc	iy
                            104 ;src/Textures.c:42: --counter;
   2410 DD 35 FF      [23]  105 	dec	-1 (ix)
   2413 18 EF         [12]  106 	jr	00101$
   2415                     107 00113$:
   2415 FD E5         [15]  108 	push	iy
   2417 F1            [10]  109 	pop	af
   2418 DD 77 05      [19]  110 	ld	5 (ix),a
   241B FD E5         [15]  111 	push	iy
   241D 3B            [ 6]  112 	dec	sp
   241E F1            [10]  113 	pop	af
   241F 33            [ 6]  114 	inc	sp
   2420 DD 77 04      [19]  115 	ld	4 (ix),a
                            116 ;src/Textures.c:44: ++texture_set;
   2423 03            [ 6]  117 	inc	bc
                            118 ;src/Textures.c:45: --length;
   2424 1B            [ 6]  119 	dec	de
   2425 18 B5         [12]  120 	jr	00104$
   2427                     121 00107$:
   2427 33            [ 6]  122 	inc	sp
   2428 DD E1         [14]  123 	pop	ix
   242A C9            [10]  124 	ret
   242B                     125 _theme_textures:
   242B 1A 33               126 	.dw _level0_walls
   242D D7 38               127 	.dw _level1_walls
   242F 13 41               128 	.dw _level2_walls
   2431 41 49               129 	.dw _level3_walls
   2433                     130 _theme_textures_length:
   2433 BD 05               131 	.dw #0x05BD
   2435 3C 08               132 	.dw #0x083C
   2437 2E 08               133 	.dw #0x082E
   2439 02 02               134 	.dw #0x0202
   243B                     135 _enemy_textures:
   243B 1B 2C               136 	.dw _level0_enemies
   243D A3 2E               137 	.dw _level1_enemies
   243F EE 2F               138 	.dw _level2_enemies
   2441 39 31               139 	.dw _level3_enemies
   2443                     140 _enemy_textures_length:
   2443 88 02               141 	.dw #0x0288
   2445 4B 01               142 	.dw #0x014B
   2447 4B 01               143 	.dw #0x014B
   2449 4B 01               144 	.dw #0x014B
                            145 ;src/Textures.c:49: void uncompress_theme_textures(u8 level) __z88dk_fastcall{//TODO implement
                            146 ;	---------------------------------
                            147 ; Function uncompress_theme_textures
                            148 ; ---------------------------------
   244B                     149 _uncompress_theme_textures::
                            150 ;src/Textures.c:50: uncompress_texture_rle((u8*)UNCOMPRESSED_TEXTURES, theme_textures[level], theme_textures_length[level]);    
   244B 11 33 24      [10]  151 	ld	de,#_theme_textures_length+0
   244E 26 00         [ 7]  152 	ld	h,#0x00
   2450 29            [11]  153 	add	hl, hl
   2451 4D            [ 4]  154 	ld	c, l
   2452 44            [ 4]  155 	ld	b, h
   2453 EB            [ 4]  156 	ex	de,hl
   2454 09            [11]  157 	add	hl,bc
   2455 5E            [ 7]  158 	ld	e,(hl)
   2456 23            [ 6]  159 	inc	hl
   2457 56            [ 7]  160 	ld	d,(hl)
   2458 21 2B 24      [10]  161 	ld	hl,#_theme_textures+0
   245B 09            [11]  162 	add	hl,bc
   245C 4E            [ 7]  163 	ld	c,(hl)
   245D 23            [ 6]  164 	inc	hl
   245E 46            [ 7]  165 	ld	b,(hl)
   245F D5            [11]  166 	push	de
   2460 C5            [11]  167 	push	bc
   2461 21 00 74      [10]  168 	ld	hl,#0x7400
   2464 E5            [11]  169 	push	hl
   2465 CD C7 23      [17]  170 	call	_uncompress_texture_rle
   2468 21 06 00      [10]  171 	ld	hl,#6
   246B 39            [11]  172 	add	hl,sp
   246C F9            [ 6]  173 	ld	sp,hl
   246D C9            [10]  174 	ret
                            175 ;src/Textures.c:54: void uncompress_enemy_textures(u8 level) __z88dk_fastcall{
                            176 ;	---------------------------------
                            177 ; Function uncompress_enemy_textures
                            178 ; ---------------------------------
   246E                     179 _uncompress_enemy_textures::
                            180 ;src/Textures.c:55: uncompress_texture_rle((u8*)UNCOMPRESSED_ENEMY_TEXTURES,enemy_textures[level],enemy_textures_length[level]);
   246E 11 43 24      [10]  181 	ld	de,#_enemy_textures_length+0
   2471 26 00         [ 7]  182 	ld	h,#0x00
   2473 29            [11]  183 	add	hl, hl
   2474 4D            [ 4]  184 	ld	c, l
   2475 44            [ 4]  185 	ld	b, h
   2476 EB            [ 4]  186 	ex	de,hl
   2477 09            [11]  187 	add	hl,bc
   2478 5E            [ 7]  188 	ld	e,(hl)
   2479 23            [ 6]  189 	inc	hl
   247A 56            [ 7]  190 	ld	d,(hl)
   247B 21 3B 24      [10]  191 	ld	hl,#_enemy_textures+0
   247E 09            [11]  192 	add	hl,bc
   247F 4E            [ 7]  193 	ld	c,(hl)
   2480 23            [ 6]  194 	inc	hl
   2481 46            [ 7]  195 	ld	b,(hl)
   2482 D5            [11]  196 	push	de
   2483 C5            [11]  197 	push	bc
   2484 21 00 88      [10]  198 	ld	hl,#0x8800
   2487 E5            [11]  199 	push	hl
   2488 CD C7 23      [17]  200 	call	_uncompress_texture_rle
   248B 21 06 00      [10]  201 	ld	hl,#6
   248E 39            [11]  202 	add	hl,sp
   248F F9            [ 6]  203 	ld	sp,hl
   2490 C9            [10]  204 	ret
                            205 ;src/Textures.c:58: void uncompress_item_textures(){
                            206 ;	---------------------------------
                            207 ; Function uncompress_item_textures
                            208 ; ---------------------------------
   2491                     209 _uncompress_item_textures::
                            210 ;src/Textures.c:60: }
   2491 C9            [10]  211 	ret
                            212 	.area _CODE
                            213 	.area _INITIALIZER
                            214 	.area _CABS (ABS)
