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
   411D                      54 _uncompress_texture_rle::
   411D DD E5         [15]   55 	push	ix
   411F DD 21 00 00   [14]   56 	ld	ix,#0
   4123 DD 39         [15]   57 	add	ix,sp
   4125 3B            [ 6]   58 	dec	sp
                             59 ;src/Textures.c:43: while(length){
   4126 DD 4E 06      [19]   60 	ld	c,6 (ix)
   4129 DD 46 07      [19]   61 	ld	b,7 (ix)
   412C DD 5E 08      [19]   62 	ld	e,8 (ix)
   412F DD 56 09      [19]   63 	ld	d,9 (ix)
   4132                      64 00104$:
   4132 7A            [ 4]   65 	ld	a,d
   4133 B3            [ 4]   66 	or	a,e
   4134 28 47         [12]   67 	jr	Z,00107$
                             68 ;src/Textures.c:44: value = (*texture_set)&0x0F;
   4136 0A            [ 7]   69 	ld	a,(bc)
   4137 67            [ 4]   70 	ld	h,a
   4138 E6 0F         [ 7]   71 	and	a, #0x0F
   413A 6F            [ 4]   72 	ld	l,a
                             73 ;src/Textures.c:45: counter = ((*texture_set)>>4)+1;
   413B 7C            [ 4]   74 	ld	a,h
   413C 07            [ 4]   75 	rlca
   413D 07            [ 4]   76 	rlca
   413E 07            [ 4]   77 	rlca
   413F 07            [ 4]   78 	rlca
   4140 E6 0F         [ 7]   79 	and	a,#0x0F
   4142 3C            [ 4]   80 	inc	a
   4143 DD 77 FF      [19]   81 	ld	-1 (ix),a
                             82 ;src/Textures.c:46: while(counter){
   4146 3E AF         [ 7]   83 	ld	a,#<(_g_colors)
   4148 85            [ 4]   84 	add	a, l
   4149 6F            [ 4]   85 	ld	l,a
   414A 3E 1A         [ 7]   86 	ld	a,#>(_g_colors)
   414C CE 00         [ 7]   87 	adc	a, #0x00
   414E 67            [ 4]   88 	ld	h,a
   414F E5            [11]   89 	push	hl
   4150 DD 6E 04      [19]   90 	ld	l,4 (ix)
   4153 DD 66 05      [19]   91 	ld	h,5 (ix)
   4156 E5            [11]   92 	push	hl
   4157 FD E1         [14]   93 	pop	iy
   4159 E1            [10]   94 	pop	hl
   415A                      95 00101$:
   415A DD 7E FF      [19]   96 	ld	a,-1 (ix)
   415D B7            [ 4]   97 	or	a, a
   415E 28 0B         [12]   98 	jr	Z,00113$
                             99 ;src/Textures.c:47: *position=g_colors[value];
   4160 7E            [ 7]  100 	ld	a,(hl)
   4161 FD 77 00      [19]  101 	ld	0 (iy), a
                            102 ;src/Textures.c:48: ++position;
   4164 FD 23         [10]  103 	inc	iy
                            104 ;src/Textures.c:49: --counter;
   4166 DD 35 FF      [23]  105 	dec	-1 (ix)
   4169 18 EF         [12]  106 	jr	00101$
   416B                     107 00113$:
   416B FD E5         [15]  108 	push	iy
   416D F1            [10]  109 	pop	af
   416E DD 77 05      [19]  110 	ld	5 (ix),a
   4171 FD E5         [15]  111 	push	iy
   4173 3B            [ 6]  112 	dec	sp
   4174 F1            [10]  113 	pop	af
   4175 33            [ 6]  114 	inc	sp
   4176 DD 77 04      [19]  115 	ld	4 (ix),a
                            116 ;src/Textures.c:51: ++texture_set;
   4179 03            [ 6]  117 	inc	bc
                            118 ;src/Textures.c:52: --length;
   417A 1B            [ 6]  119 	dec	de
   417B 18 B5         [12]  120 	jr	00104$
   417D                     121 00107$:
   417D 33            [ 6]  122 	inc	sp
   417E DD E1         [14]  123 	pop	ix
   4180 C9            [10]  124 	ret
   4181                     125 _theme_textures:
   4181 83 5B               126 	.dw _level0_walls
   4183 40 61               127 	.dw _level1_walls
   4185 95 69               128 	.dw _level2_walls
   4187 C3 71               129 	.dw _level3_walls
   4189                     130 _theme_textures_length:
   4189 BD 05               131 	.dw #0x05BD
   418B 55 08               132 	.dw #0x0855
   418D 2E 08               133 	.dw #0x082E
   418F F7 06               134 	.dw #0x06F7
   4191                     135 _enemy_textures:
   4191 20 58               136 	.dw _level0_enemies
   4193 A4 58               137 	.dw _level1_enemies
   4195 4F 59               138 	.dw _level2_enemies
   4197 CA 59               139 	.dw _level3_enemies
   4199 68 57               140 	.dw _king_enemy
   419B                     141 _enemy_textures_length:
   419B 84 00               142 	.dw #0x0084
   419D AB 00               143 	.dw #0x00AB
   419F 7B 00               144 	.dw #0x007B
   41A1 B7 00               145 	.dw #0x00B7
   41A3 B8 00               146 	.dw #0x00B8
                            147 ;src/Textures.c:56: void uncompress_theme_textures(u8 level) {//TODO implement
                            148 ;	---------------------------------
                            149 ; Function uncompress_theme_textures
                            150 ; ---------------------------------
   41A5                     151 _uncompress_theme_textures::
   41A5 DD E5         [15]  152 	push	ix
   41A7 DD 21 00 00   [14]  153 	ld	ix,#0
   41AB DD 39         [15]  154 	add	ix,sp
                            155 ;src/Textures.c:57: uncompress_texture_rle((u8*)UNCOMPRESSED_TEXTURES, theme_textures[level], theme_textures_length[level]);    
   41AD DD 6E 04      [19]  156 	ld	l,4 (ix)
   41B0 26 00         [ 7]  157 	ld	h,#0x00
   41B2 29            [11]  158 	add	hl, hl
   41B3 4D            [ 4]  159 	ld	c, l
   41B4 44            [ 4]  160 	ld	b, h
   41B5 21 89 41      [10]  161 	ld	hl,#_theme_textures_length
   41B8 09            [11]  162 	add	hl,bc
   41B9 5E            [ 7]  163 	ld	e,(hl)
   41BA 23            [ 6]  164 	inc	hl
   41BB 56            [ 7]  165 	ld	d,(hl)
   41BC 21 81 41      [10]  166 	ld	hl,#_theme_textures+0
   41BF 09            [11]  167 	add	hl,bc
   41C0 4E            [ 7]  168 	ld	c,(hl)
   41C1 23            [ 6]  169 	inc	hl
   41C2 46            [ 7]  170 	ld	b,(hl)
   41C3 D5            [11]  171 	push	de
   41C4 C5            [11]  172 	push	bc
   41C5 21 D0 8C      [10]  173 	ld	hl,#0x8CD0
   41C8 E5            [11]  174 	push	hl
   41C9 CD 1D 41      [17]  175 	call	_uncompress_texture_rle
   41CC 21 06 00      [10]  176 	ld	hl,#6
   41CF 39            [11]  177 	add	hl,sp
   41D0 F9            [ 6]  178 	ld	sp,hl
   41D1 DD E1         [14]  179 	pop	ix
   41D3 C9            [10]  180 	ret
                            181 ;src/Textures.c:61: void uncompress_enemy_textures(u8 level) {
                            182 ;	---------------------------------
                            183 ; Function uncompress_enemy_textures
                            184 ; ---------------------------------
   41D4                     185 _uncompress_enemy_textures::
   41D4 DD E5         [15]  186 	push	ix
   41D6 DD 21 00 00   [14]  187 	ld	ix,#0
   41DA DD 39         [15]  188 	add	ix,sp
                            189 ;src/Textures.c:62: if(camelot_warriors_mode){
   41DC 3A 62 7D      [13]  190 	ld	a,(#_camelot_warriors_mode + 0)
   41DF B7            [ 4]  191 	or	a, a
   41E0 28 2A         [12]  192 	jr	Z,00102$
                            193 ;src/Textures.c:63: uncompress_texture_rle((u8*)UNCOMPRESSED_RAT_TEXTURE,camelot_enemy,camelot_enemy_LENGTH);
   41E2 21 7B 00      [10]  194 	ld	hl,#0x007B
   41E5 E5            [11]  195 	push	hl
   41E6 21 ED 56      [10]  196 	ld	hl,#_camelot_enemy
   41E9 E5            [11]  197 	push	hl
   41EA 21 D0 A0      [10]  198 	ld	hl,#0xA0D0
   41ED E5            [11]  199 	push	hl
   41EE CD 1D 41      [17]  200 	call	_uncompress_texture_rle
   41F1 21 06 00      [10]  201 	ld	hl,#6
   41F4 39            [11]  202 	add	hl,sp
   41F5 F9            [ 6]  203 	ld	sp,hl
                            204 ;src/Textures.c:64: uncompress_texture_rle((u8*)UNCOMPRESSED_ENEMY_TEXTURE,camelot_enemy,camelot_enemy_LENGTH);
   41F6 21 7B 00      [10]  205 	ld	hl,#0x007B
   41F9 E5            [11]  206 	push	hl
   41FA 21 ED 56      [10]  207 	ld	hl,#_camelot_enemy
   41FD E5            [11]  208 	push	hl
   41FE 21 10 A3      [10]  209 	ld	hl,#0xA310
   4201 E5            [11]  210 	push	hl
   4202 CD 1D 41      [17]  211 	call	_uncompress_texture_rle
   4205 21 06 00      [10]  212 	ld	hl,#6
   4208 39            [11]  213 	add	hl,sp
   4209 F9            [ 6]  214 	ld	sp,hl
   420A 18 38         [12]  215 	jr	00104$
   420C                     216 00102$:
                            217 ;src/Textures.c:67: uncompress_texture_rle((u8*)UNCOMPRESSED_RAT_TEXTURE,rat_enemy,rat_enemy_LENGTH);
   420C 21 6C 00      [10]  218 	ld	hl,#0x006C
   420F E5            [11]  219 	push	hl
   4210 21 81 5A      [10]  220 	ld	hl,#_rat_enemy
   4213 E5            [11]  221 	push	hl
   4214 21 D0 A0      [10]  222 	ld	hl,#0xA0D0
   4217 E5            [11]  223 	push	hl
   4218 CD 1D 41      [17]  224 	call	_uncompress_texture_rle
   421B 21 06 00      [10]  225 	ld	hl,#6
   421E 39            [11]  226 	add	hl,sp
   421F F9            [ 6]  227 	ld	sp,hl
                            228 ;src/Textures.c:68: uncompress_texture_rle((u8*)UNCOMPRESSED_ENEMY_TEXTURE,enemy_textures[level],enemy_textures_length[level]);
   4220 DD 6E 04      [19]  229 	ld	l,4 (ix)
   4223 26 00         [ 7]  230 	ld	h,#0x00
   4225 29            [11]  231 	add	hl, hl
   4226 4D            [ 4]  232 	ld	c, l
   4227 44            [ 4]  233 	ld	b, h
   4228 21 9B 41      [10]  234 	ld	hl,#_enemy_textures_length
   422B 09            [11]  235 	add	hl,bc
   422C 5E            [ 7]  236 	ld	e,(hl)
   422D 23            [ 6]  237 	inc	hl
   422E 56            [ 7]  238 	ld	d,(hl)
   422F 21 91 41      [10]  239 	ld	hl,#_enemy_textures+0
   4232 09            [11]  240 	add	hl,bc
   4233 4E            [ 7]  241 	ld	c,(hl)
   4234 23            [ 6]  242 	inc	hl
   4235 46            [ 7]  243 	ld	b,(hl)
   4236 D5            [11]  244 	push	de
   4237 C5            [11]  245 	push	bc
   4238 21 10 A3      [10]  246 	ld	hl,#0xA310
   423B E5            [11]  247 	push	hl
   423C CD 1D 41      [17]  248 	call	_uncompress_texture_rle
   423F 21 06 00      [10]  249 	ld	hl,#6
   4242 39            [11]  250 	add	hl,sp
   4243 F9            [ 6]  251 	ld	sp,hl
   4244                     252 00104$:
   4244 DD E1         [14]  253 	pop	ix
   4246 C9            [10]  254 	ret
                            255 ;src/Textures.c:72: void uncompress_item_textures(){
                            256 ;	---------------------------------
                            257 ; Function uncompress_item_textures
                            258 ; ---------------------------------
   4247                     259 _uncompress_item_textures::
                            260 ;src/Textures.c:73: uncompress_texture_rle((u8*)UNCOMPRESSED_OBJECT_TEXTURES, items_tileset, items_tileset_LENGTH);
   4247 21 4A 01      [10]  261 	ld	hl,#0x014A
   424A E5            [11]  262 	push	hl
   424B 21 B2 4F      [10]  263 	ld	hl,#_items_tileset
   424E E5            [11]  264 	push	hl
   424F 21 50 A5      [10]  265 	ld	hl,#0xA550
   4252 E5            [11]  266 	push	hl
   4253 CD 1D 41      [17]  267 	call	_uncompress_texture_rle
   4256 21 06 00      [10]  268 	ld	hl,#6
   4259 39            [11]  269 	add	hl,sp
   425A F9            [ 6]  270 	ld	sp,hl
   425B C9            [10]  271 	ret
                            272 	.area _CODE
                            273 	.area _INITIALIZER
                            274 	.area _CABS (ABS)
