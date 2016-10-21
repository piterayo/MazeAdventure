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
   29B0                      54 _uncompress_texture_rle::
   29B0 DD E5         [15]   55 	push	ix
   29B2 DD 21 00 00   [14]   56 	ld	ix,#0
   29B6 DD 39         [15]   57 	add	ix,sp
   29B8 3B            [ 6]   58 	dec	sp
                             59 ;src/Textures.c:36: while(length){
   29B9 DD 4E 06      [19]   60 	ld	c,6 (ix)
   29BC DD 46 07      [19]   61 	ld	b,7 (ix)
   29BF DD 5E 08      [19]   62 	ld	e,8 (ix)
   29C2 DD 56 09      [19]   63 	ld	d,9 (ix)
   29C5                      64 00104$:
   29C5 7A            [ 4]   65 	ld	a,d
   29C6 B3            [ 4]   66 	or	a,e
   29C7 28 47         [12]   67 	jr	Z,00107$
                             68 ;src/Textures.c:37: value = (*texture_set)&0x0F;
   29C9 0A            [ 7]   69 	ld	a,(bc)
   29CA 67            [ 4]   70 	ld	h,a
   29CB E6 0F         [ 7]   71 	and	a, #0x0F
   29CD 6F            [ 4]   72 	ld	l,a
                             73 ;src/Textures.c:38: counter = ((*texture_set)>>4)+1;
   29CE 7C            [ 4]   74 	ld	a,h
   29CF 07            [ 4]   75 	rlca
   29D0 07            [ 4]   76 	rlca
   29D1 07            [ 4]   77 	rlca
   29D2 07            [ 4]   78 	rlca
   29D3 E6 0F         [ 7]   79 	and	a,#0x0F
   29D5 3C            [ 4]   80 	inc	a
   29D6 DD 77 FF      [19]   81 	ld	-1 (ix),a
                             82 ;src/Textures.c:39: while(counter){
   29D9 3E 66         [ 7]   83 	ld	a,#<(_g_colors)
   29DB 85            [ 4]   84 	add	a, l
   29DC 6F            [ 4]   85 	ld	l,a
   29DD 3E 10         [ 7]   86 	ld	a,#>(_g_colors)
   29DF CE 00         [ 7]   87 	adc	a, #0x00
   29E1 67            [ 4]   88 	ld	h,a
   29E2 E5            [11]   89 	push	hl
   29E3 DD 6E 04      [19]   90 	ld	l,4 (ix)
   29E6 DD 66 05      [19]   91 	ld	h,5 (ix)
   29E9 E5            [11]   92 	push	hl
   29EA FD E1         [14]   93 	pop	iy
   29EC E1            [10]   94 	pop	hl
   29ED                      95 00101$:
   29ED DD 7E FF      [19]   96 	ld	a,-1 (ix)
   29F0 B7            [ 4]   97 	or	a, a
   29F1 28 0B         [12]   98 	jr	Z,00113$
                             99 ;src/Textures.c:40: *position=g_colors[value];
   29F3 7E            [ 7]  100 	ld	a,(hl)
   29F4 FD 77 00      [19]  101 	ld	0 (iy), a
                            102 ;src/Textures.c:41: ++position;
   29F7 FD 23         [10]  103 	inc	iy
                            104 ;src/Textures.c:42: --counter;
   29F9 DD 35 FF      [23]  105 	dec	-1 (ix)
   29FC 18 EF         [12]  106 	jr	00101$
   29FE                     107 00113$:
   29FE FD E5         [15]  108 	push	iy
   2A00 F1            [10]  109 	pop	af
   2A01 DD 77 05      [19]  110 	ld	5 (ix),a
   2A04 FD E5         [15]  111 	push	iy
   2A06 3B            [ 6]  112 	dec	sp
   2A07 F1            [10]  113 	pop	af
   2A08 33            [ 6]  114 	inc	sp
   2A09 DD 77 04      [19]  115 	ld	4 (ix),a
                            116 ;src/Textures.c:44: ++texture_set;
   2A0C 03            [ 6]  117 	inc	bc
                            118 ;src/Textures.c:45: --length;
   2A0D 1B            [ 6]  119 	dec	de
   2A0E 18 B5         [12]  120 	jr	00104$
   2A10                     121 00107$:
   2A10 33            [ 6]  122 	inc	sp
   2A11 DD E1         [14]  123 	pop	ix
   2A13 C9            [10]  124 	ret
   2A14                     125 _theme_textures:
   2A14 C7 39               126 	.dw _level0_walls
   2A16 84 3F               127 	.dw _level1_walls
   2A18 C0 47               128 	.dw _level2_walls
   2A1A EE 4F               129 	.dw _level3_walls
   2A1C                     130 _theme_textures_length:
   2A1C BD 05               131 	.dw #0x05BD
   2A1E 3C 08               132 	.dw #0x083C
   2A20 2E 08               133 	.dw #0x082E
   2A22 F7 06               134 	.dw #0x06F7
   2A24                     135 _enemy_textures:
   2A24 C8 32               136 	.dw _level0_enemies
   2A26 50 35               137 	.dw _level1_enemies
   2A28 9B 36               138 	.dw _level2_enemies
   2A2A E6 37               139 	.dw _level3_enemies
   2A2C                     140 _enemy_textures_length:
   2A2C 88 02               141 	.dw #0x0288
   2A2E 4B 01               142 	.dw #0x014B
   2A30 4B 01               143 	.dw #0x014B
   2A32 4B 01               144 	.dw #0x014B
                            145 ;src/Textures.c:49: void uncompress_theme_textures(u8 level) __z88dk_fastcall{//TODO implement
                            146 ;	---------------------------------
                            147 ; Function uncompress_theme_textures
                            148 ; ---------------------------------
   2A34                     149 _uncompress_theme_textures::
                            150 ;src/Textures.c:50: uncompress_texture_rle((u8*)UNCOMPRESSED_TEXTURES, theme_textures[level], theme_textures_length[level]);    
   2A34 11 1C 2A      [10]  151 	ld	de,#_theme_textures_length+0
   2A37 26 00         [ 7]  152 	ld	h,#0x00
   2A39 29            [11]  153 	add	hl, hl
   2A3A 4D            [ 4]  154 	ld	c, l
   2A3B 44            [ 4]  155 	ld	b, h
   2A3C EB            [ 4]  156 	ex	de,hl
   2A3D 09            [11]  157 	add	hl,bc
   2A3E 5E            [ 7]  158 	ld	e,(hl)
   2A3F 23            [ 6]  159 	inc	hl
   2A40 56            [ 7]  160 	ld	d,(hl)
   2A41 21 14 2A      [10]  161 	ld	hl,#_theme_textures+0
   2A44 09            [11]  162 	add	hl,bc
   2A45 4E            [ 7]  163 	ld	c,(hl)
   2A46 23            [ 6]  164 	inc	hl
   2A47 46            [ 7]  165 	ld	b,(hl)
   2A48 D5            [11]  166 	push	de
   2A49 C5            [11]  167 	push	bc
   2A4A 21 00 74      [10]  168 	ld	hl,#0x7400
   2A4D E5            [11]  169 	push	hl
   2A4E CD B0 29      [17]  170 	call	_uncompress_texture_rle
   2A51 21 06 00      [10]  171 	ld	hl,#6
   2A54 39            [11]  172 	add	hl,sp
   2A55 F9            [ 6]  173 	ld	sp,hl
   2A56 C9            [10]  174 	ret
                            175 ;src/Textures.c:54: void uncompress_enemy_textures(u8 level) __z88dk_fastcall{
                            176 ;	---------------------------------
                            177 ; Function uncompress_enemy_textures
                            178 ; ---------------------------------
   2A57                     179 _uncompress_enemy_textures::
                            180 ;src/Textures.c:55: uncompress_texture_rle((u8*)UNCOMPRESSED_ENEMY_TEXTURES,enemy_textures[level],enemy_textures_length[level]);
   2A57 11 2C 2A      [10]  181 	ld	de,#_enemy_textures_length+0
   2A5A 26 00         [ 7]  182 	ld	h,#0x00
   2A5C 29            [11]  183 	add	hl, hl
   2A5D 4D            [ 4]  184 	ld	c, l
   2A5E 44            [ 4]  185 	ld	b, h
   2A5F EB            [ 4]  186 	ex	de,hl
   2A60 09            [11]  187 	add	hl,bc
   2A61 5E            [ 7]  188 	ld	e,(hl)
   2A62 23            [ 6]  189 	inc	hl
   2A63 56            [ 7]  190 	ld	d,(hl)
   2A64 21 24 2A      [10]  191 	ld	hl,#_enemy_textures+0
   2A67 09            [11]  192 	add	hl,bc
   2A68 4E            [ 7]  193 	ld	c,(hl)
   2A69 23            [ 6]  194 	inc	hl
   2A6A 46            [ 7]  195 	ld	b,(hl)
   2A6B D5            [11]  196 	push	de
   2A6C C5            [11]  197 	push	bc
   2A6D 21 00 88      [10]  198 	ld	hl,#0x8800
   2A70 E5            [11]  199 	push	hl
   2A71 CD B0 29      [17]  200 	call	_uncompress_texture_rle
   2A74 21 06 00      [10]  201 	ld	hl,#6
   2A77 39            [11]  202 	add	hl,sp
   2A78 F9            [ 6]  203 	ld	sp,hl
   2A79 C9            [10]  204 	ret
                            205 ;src/Textures.c:58: void uncompress_item_textures(){
                            206 ;	---------------------------------
                            207 ; Function uncompress_item_textures
                            208 ; ---------------------------------
   2A7A                     209 _uncompress_item_textures::
                            210 ;src/Textures.c:60: }
   2A7A C9            [10]  211 	ret
                            212 	.area _CODE
                            213 	.area _INITIALIZER
                            214 	.area _CABS (ABS)
