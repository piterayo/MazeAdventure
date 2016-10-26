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
                             50 ;src/Textures.c:40: void uncompress_texture_rle(u8* position, u8* texture_set, u16 length){
                             51 ;	---------------------------------
                             52 ; Function uncompress_texture_rle
                             53 ; ---------------------------------
   426B                      54 _uncompress_texture_rle::
   426B DD E5         [15]   55 	push	ix
   426D DD 21 00 00   [14]   56 	ld	ix,#0
   4271 DD 39         [15]   57 	add	ix,sp
   4273 3B            [ 6]   58 	dec	sp
                             59 ;src/Textures.c:43: while(length){
   4274 DD 4E 06      [19]   60 	ld	c,6 (ix)
   4277 DD 46 07      [19]   61 	ld	b,7 (ix)
   427A DD 5E 08      [19]   62 	ld	e,8 (ix)
   427D DD 56 09      [19]   63 	ld	d,9 (ix)
   4280                      64 00104$:
   4280 7A            [ 4]   65 	ld	a,d
   4281 B3            [ 4]   66 	or	a,e
   4282 28 47         [12]   67 	jr	Z,00107$
                             68 ;src/Textures.c:44: value = (*texture_set)&0x0F;
   4284 0A            [ 7]   69 	ld	a,(bc)
   4285 67            [ 4]   70 	ld	h,a
   4286 E6 0F         [ 7]   71 	and	a, #0x0F
   4288 6F            [ 4]   72 	ld	l,a
                             73 ;src/Textures.c:45: counter = ((*texture_set)>>4)+1;
   4289 7C            [ 4]   74 	ld	a,h
   428A 07            [ 4]   75 	rlca
   428B 07            [ 4]   76 	rlca
   428C 07            [ 4]   77 	rlca
   428D 07            [ 4]   78 	rlca
   428E E6 0F         [ 7]   79 	and	a,#0x0F
   4290 3C            [ 4]   80 	inc	a
   4291 DD 77 FF      [19]   81 	ld	-1 (ix),a
                             82 ;src/Textures.c:46: while(counter){
   4294 3E 28         [ 7]   83 	ld	a,#<(_g_colors)
   4296 85            [ 4]   84 	add	a, l
   4297 6F            [ 4]   85 	ld	l,a
   4298 3E 1C         [ 7]   86 	ld	a,#>(_g_colors)
   429A CE 00         [ 7]   87 	adc	a, #0x00
   429C 67            [ 4]   88 	ld	h,a
   429D E5            [11]   89 	push	hl
   429E DD 6E 04      [19]   90 	ld	l,4 (ix)
   42A1 DD 66 05      [19]   91 	ld	h,5 (ix)
   42A4 E5            [11]   92 	push	hl
   42A5 FD E1         [14]   93 	pop	iy
   42A7 E1            [10]   94 	pop	hl
   42A8                      95 00101$:
   42A8 DD 7E FF      [19]   96 	ld	a,-1 (ix)
   42AB B7            [ 4]   97 	or	a, a
   42AC 28 0B         [12]   98 	jr	Z,00113$
                             99 ;src/Textures.c:47: *position=g_colors[value];
   42AE 7E            [ 7]  100 	ld	a,(hl)
   42AF FD 77 00      [19]  101 	ld	0 (iy), a
                            102 ;src/Textures.c:48: ++position;
   42B2 FD 23         [10]  103 	inc	iy
                            104 ;src/Textures.c:49: --counter;
   42B4 DD 35 FF      [23]  105 	dec	-1 (ix)
   42B7 18 EF         [12]  106 	jr	00101$
   42B9                     107 00113$:
   42B9 FD E5         [15]  108 	push	iy
   42BB F1            [10]  109 	pop	af
   42BC DD 77 05      [19]  110 	ld	5 (ix),a
   42BF FD E5         [15]  111 	push	iy
   42C1 3B            [ 6]  112 	dec	sp
   42C2 F1            [10]  113 	pop	af
   42C3 33            [ 6]  114 	inc	sp
   42C4 DD 77 04      [19]  115 	ld	4 (ix),a
                            116 ;src/Textures.c:51: ++texture_set;
   42C7 03            [ 6]  117 	inc	bc
                            118 ;src/Textures.c:52: --length;
   42C8 1B            [ 6]  119 	dec	de
   42C9 18 B5         [12]  120 	jr	00104$
   42CB                     121 00107$:
   42CB 33            [ 6]  122 	inc	sp
   42CC DD E1         [14]  123 	pop	ix
   42CE C9            [10]  124 	ret
   42CF                     125 _theme_textures:
   42CF D1 5C               126 	.dw _level0_walls
   42D1 8E 62               127 	.dw _level1_walls
   42D3 E3 6A               128 	.dw _level2_walls
   42D5 11 73               129 	.dw _level3_walls
   42D7                     130 _theme_textures_length:
   42D7 BD 05               131 	.dw #0x05BD
   42D9 55 08               132 	.dw #0x0855
   42DB 2E 08               133 	.dw #0x082E
   42DD F7 06               134 	.dw #0x06F7
   42DF                     135 _enemy_textures:
   42DF 6E 59               136 	.dw _level0_enemies
   42E1 F2 59               137 	.dw _level1_enemies
   42E3 9D 5A               138 	.dw _level2_enemies
   42E5 18 5B               139 	.dw _level3_enemies
   42E7 B6 58               140 	.dw _king_enemy
   42E9                     141 _enemy_textures_length:
   42E9 84 00               142 	.dw #0x0084
   42EB AB 00               143 	.dw #0x00AB
   42ED 7B 00               144 	.dw #0x007B
   42EF B7 00               145 	.dw #0x00B7
   42F1 B8 00               146 	.dw #0x00B8
                            147 ;src/Textures.c:56: void uncompress_theme_textures(u8 level) {//TODO implement
                            148 ;	---------------------------------
                            149 ; Function uncompress_theme_textures
                            150 ; ---------------------------------
   42F3                     151 _uncompress_theme_textures::
   42F3 DD E5         [15]  152 	push	ix
   42F5 DD 21 00 00   [14]  153 	ld	ix,#0
   42F9 DD 39         [15]  154 	add	ix,sp
                            155 ;src/Textures.c:57: uncompress_texture_rle((u8*)UNCOMPRESSED_TEXTURES, theme_textures[level], theme_textures_length[level]);    
   42FB DD 6E 04      [19]  156 	ld	l,4 (ix)
   42FE 26 00         [ 7]  157 	ld	h,#0x00
   4300 29            [11]  158 	add	hl, hl
   4301 4D            [ 4]  159 	ld	c, l
   4302 44            [ 4]  160 	ld	b, h
   4303 21 D7 42      [10]  161 	ld	hl,#_theme_textures_length
   4306 09            [11]  162 	add	hl,bc
   4307 5E            [ 7]  163 	ld	e,(hl)
   4308 23            [ 6]  164 	inc	hl
   4309 56            [ 7]  165 	ld	d,(hl)
   430A 21 CF 42      [10]  166 	ld	hl,#_theme_textures+0
   430D 09            [11]  167 	add	hl,bc
   430E 4E            [ 7]  168 	ld	c,(hl)
   430F 23            [ 6]  169 	inc	hl
   4310 46            [ 7]  170 	ld	b,(hl)
   4311 D5            [11]  171 	push	de
   4312 C5            [11]  172 	push	bc
   4313 21 D0 8C      [10]  173 	ld	hl,#0x8CD0
   4316 E5            [11]  174 	push	hl
   4317 CD 6B 42      [17]  175 	call	_uncompress_texture_rle
   431A 21 06 00      [10]  176 	ld	hl,#6
   431D 39            [11]  177 	add	hl,sp
   431E F9            [ 6]  178 	ld	sp,hl
   431F DD E1         [14]  179 	pop	ix
   4321 C9            [10]  180 	ret
                            181 ;src/Textures.c:61: void uncompress_enemy_textures(u8 level) {
                            182 ;	---------------------------------
                            183 ; Function uncompress_enemy_textures
                            184 ; ---------------------------------
   4322                     185 _uncompress_enemy_textures::
   4322 DD E5         [15]  186 	push	ix
   4324 DD 21 00 00   [14]  187 	ld	ix,#0
   4328 DD 39         [15]  188 	add	ix,sp
                            189 ;src/Textures.c:62: if(camelot_warriors_mode){
   432A 3A DC 86      [13]  190 	ld	a,(#_camelot_warriors_mode + 0)
   432D B7            [ 4]  191 	or	a, a
   432E 28 2A         [12]  192 	jr	Z,00102$
                            193 ;src/Textures.c:63: uncompress_texture_rle((u8*)UNCOMPRESSED_RAT_TEXTURE,camelot_enemy,camelot_enemy_LENGTH);
   4330 21 7B 00      [10]  194 	ld	hl,#0x007B
   4333 E5            [11]  195 	push	hl
   4334 21 3B 58      [10]  196 	ld	hl,#_camelot_enemy
   4337 E5            [11]  197 	push	hl
   4338 21 D0 A0      [10]  198 	ld	hl,#0xA0D0
   433B E5            [11]  199 	push	hl
   433C CD 6B 42      [17]  200 	call	_uncompress_texture_rle
   433F 21 06 00      [10]  201 	ld	hl,#6
   4342 39            [11]  202 	add	hl,sp
   4343 F9            [ 6]  203 	ld	sp,hl
                            204 ;src/Textures.c:64: uncompress_texture_rle((u8*)UNCOMPRESSED_ENEMY_TEXTURE,camelot_enemy,camelot_enemy_LENGTH);
   4344 21 7B 00      [10]  205 	ld	hl,#0x007B
   4347 E5            [11]  206 	push	hl
   4348 21 3B 58      [10]  207 	ld	hl,#_camelot_enemy
   434B E5            [11]  208 	push	hl
   434C 21 10 A3      [10]  209 	ld	hl,#0xA310
   434F E5            [11]  210 	push	hl
   4350 CD 6B 42      [17]  211 	call	_uncompress_texture_rle
   4353 21 06 00      [10]  212 	ld	hl,#6
   4356 39            [11]  213 	add	hl,sp
   4357 F9            [ 6]  214 	ld	sp,hl
   4358 18 38         [12]  215 	jr	00104$
   435A                     216 00102$:
                            217 ;src/Textures.c:67: uncompress_texture_rle((u8*)UNCOMPRESSED_RAT_TEXTURE,rat_enemy,rat_enemy_LENGTH);
   435A 21 6C 00      [10]  218 	ld	hl,#0x006C
   435D E5            [11]  219 	push	hl
   435E 21 CF 5B      [10]  220 	ld	hl,#_rat_enemy
   4361 E5            [11]  221 	push	hl
   4362 21 D0 A0      [10]  222 	ld	hl,#0xA0D0
   4365 E5            [11]  223 	push	hl
   4366 CD 6B 42      [17]  224 	call	_uncompress_texture_rle
   4369 21 06 00      [10]  225 	ld	hl,#6
   436C 39            [11]  226 	add	hl,sp
   436D F9            [ 6]  227 	ld	sp,hl
                            228 ;src/Textures.c:68: uncompress_texture_rle((u8*)UNCOMPRESSED_ENEMY_TEXTURE,enemy_textures[level],enemy_textures_length[level]);
   436E DD 6E 04      [19]  229 	ld	l,4 (ix)
   4371 26 00         [ 7]  230 	ld	h,#0x00
   4373 29            [11]  231 	add	hl, hl
   4374 4D            [ 4]  232 	ld	c, l
   4375 44            [ 4]  233 	ld	b, h
   4376 21 E9 42      [10]  234 	ld	hl,#_enemy_textures_length
   4379 09            [11]  235 	add	hl,bc
   437A 5E            [ 7]  236 	ld	e,(hl)
   437B 23            [ 6]  237 	inc	hl
   437C 56            [ 7]  238 	ld	d,(hl)
   437D 21 DF 42      [10]  239 	ld	hl,#_enemy_textures+0
   4380 09            [11]  240 	add	hl,bc
   4381 4E            [ 7]  241 	ld	c,(hl)
   4382 23            [ 6]  242 	inc	hl
   4383 46            [ 7]  243 	ld	b,(hl)
   4384 D5            [11]  244 	push	de
   4385 C5            [11]  245 	push	bc
   4386 21 10 A3      [10]  246 	ld	hl,#0xA310
   4389 E5            [11]  247 	push	hl
   438A CD 6B 42      [17]  248 	call	_uncompress_texture_rle
   438D 21 06 00      [10]  249 	ld	hl,#6
   4390 39            [11]  250 	add	hl,sp
   4391 F9            [ 6]  251 	ld	sp,hl
   4392                     252 00104$:
   4392 DD E1         [14]  253 	pop	ix
   4394 C9            [10]  254 	ret
                            255 ;src/Textures.c:72: void uncompress_item_textures(){
                            256 ;	---------------------------------
                            257 ; Function uncompress_item_textures
                            258 ; ---------------------------------
   4395                     259 _uncompress_item_textures::
                            260 ;src/Textures.c:73: uncompress_texture_rle((u8*)UNCOMPRESSED_OBJECT_TEXTURES, items_tileset, items_tileset_LENGTH);
   4395 21 4A 01      [10]  261 	ld	hl,#0x014A
   4398 E5            [11]  262 	push	hl
   4399 21 00 51      [10]  263 	ld	hl,#_items_tileset
   439C E5            [11]  264 	push	hl
   439D 21 50 A5      [10]  265 	ld	hl,#0xA550
   43A0 E5            [11]  266 	push	hl
   43A1 CD 6B 42      [17]  267 	call	_uncompress_texture_rle
   43A4 21 06 00      [10]  268 	ld	hl,#6
   43A7 39            [11]  269 	add	hl,sp
   43A8 F9            [ 6]  270 	ld	sp,hl
   43A9 C9            [10]  271 	ret
                            272 	.area _CODE
                            273 	.area _INITIALIZER
                            274 	.area _CABS (ABS)
