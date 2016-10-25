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
   40F7                      54 _uncompress_texture_rle::
   40F7 DD E5         [15]   55 	push	ix
   40F9 DD 21 00 00   [14]   56 	ld	ix,#0
   40FD DD 39         [15]   57 	add	ix,sp
   40FF 3B            [ 6]   58 	dec	sp
                             59 ;src/Textures.c:43: while(length){
   4100 DD 4E 06      [19]   60 	ld	c,6 (ix)
   4103 DD 46 07      [19]   61 	ld	b,7 (ix)
   4106 DD 5E 08      [19]   62 	ld	e,8 (ix)
   4109 DD 56 09      [19]   63 	ld	d,9 (ix)
   410C                      64 00104$:
   410C 7A            [ 4]   65 	ld	a,d
   410D B3            [ 4]   66 	or	a,e
   410E 28 47         [12]   67 	jr	Z,00107$
                             68 ;src/Textures.c:44: value = (*texture_set)&0x0F;
   4110 0A            [ 7]   69 	ld	a,(bc)
   4111 67            [ 4]   70 	ld	h,a
   4112 E6 0F         [ 7]   71 	and	a, #0x0F
   4114 6F            [ 4]   72 	ld	l,a
                             73 ;src/Textures.c:45: counter = ((*texture_set)>>4)+1;
   4115 7C            [ 4]   74 	ld	a,h
   4116 07            [ 4]   75 	rlca
   4117 07            [ 4]   76 	rlca
   4118 07            [ 4]   77 	rlca
   4119 07            [ 4]   78 	rlca
   411A E6 0F         [ 7]   79 	and	a,#0x0F
   411C 3C            [ 4]   80 	inc	a
   411D DD 77 FF      [19]   81 	ld	-1 (ix),a
                             82 ;src/Textures.c:46: while(counter){
   4120 3E 66         [ 7]   83 	ld	a,#<(_g_colors)
   4122 85            [ 4]   84 	add	a, l
   4123 6F            [ 4]   85 	ld	l,a
   4124 3E 1A         [ 7]   86 	ld	a,#>(_g_colors)
   4126 CE 00         [ 7]   87 	adc	a, #0x00
   4128 67            [ 4]   88 	ld	h,a
   4129 E5            [11]   89 	push	hl
   412A DD 6E 04      [19]   90 	ld	l,4 (ix)
   412D DD 66 05      [19]   91 	ld	h,5 (ix)
   4130 E5            [11]   92 	push	hl
   4131 FD E1         [14]   93 	pop	iy
   4133 E1            [10]   94 	pop	hl
   4134                      95 00101$:
   4134 DD 7E FF      [19]   96 	ld	a,-1 (ix)
   4137 B7            [ 4]   97 	or	a, a
   4138 28 0B         [12]   98 	jr	Z,00113$
                             99 ;src/Textures.c:47: *position=g_colors[value];
   413A 7E            [ 7]  100 	ld	a,(hl)
   413B FD 77 00      [19]  101 	ld	0 (iy), a
                            102 ;src/Textures.c:48: ++position;
   413E FD 23         [10]  103 	inc	iy
                            104 ;src/Textures.c:49: --counter;
   4140 DD 35 FF      [23]  105 	dec	-1 (ix)
   4143 18 EF         [12]  106 	jr	00101$
   4145                     107 00113$:
   4145 FD E5         [15]  108 	push	iy
   4147 F1            [10]  109 	pop	af
   4148 DD 77 05      [19]  110 	ld	5 (ix),a
   414B FD E5         [15]  111 	push	iy
   414D 3B            [ 6]  112 	dec	sp
   414E F1            [10]  113 	pop	af
   414F 33            [ 6]  114 	inc	sp
   4150 DD 77 04      [19]  115 	ld	4 (ix),a
                            116 ;src/Textures.c:51: ++texture_set;
   4153 03            [ 6]  117 	inc	bc
                            118 ;src/Textures.c:52: --length;
   4154 1B            [ 6]  119 	dec	de
   4155 18 B5         [12]  120 	jr	00104$
   4157                     121 00107$:
   4157 33            [ 6]  122 	inc	sp
   4158 DD E1         [14]  123 	pop	ix
   415A C9            [10]  124 	ret
   415B                     125 _theme_textures:
   415B 3B 5C               126 	.dw _level0_walls
   415D F8 61               127 	.dw _level1_walls
   415F 4D 6A               128 	.dw _level2_walls
   4161 7B 72               129 	.dw _level3_walls
   4163                     130 _theme_textures_length:
   4163 BD 05               131 	.dw #0x05BD
   4165 55 08               132 	.dw #0x0855
   4167 2E 08               133 	.dw #0x082E
   4169 F7 06               134 	.dw #0x06F7
   416B                     135 _enemy_textures:
   416B D8 58               136 	.dw _level0_enemies
   416D 5C 59               137 	.dw _level1_enemies
   416F 07 5A               138 	.dw _level2_enemies
   4171 82 5A               139 	.dw _level3_enemies
   4173 20 58               140 	.dw _king_enemy
   4175                     141 _enemy_textures_length:
   4175 84 00               142 	.dw #0x0084
   4177 AB 00               143 	.dw #0x00AB
   4179 7B 00               144 	.dw #0x007B
   417B B7 00               145 	.dw #0x00B7
   417D B8 00               146 	.dw #0x00B8
                            147 ;src/Textures.c:56: void uncompress_theme_textures(u8 level) {//TODO implement
                            148 ;	---------------------------------
                            149 ; Function uncompress_theme_textures
                            150 ; ---------------------------------
   417F                     151 _uncompress_theme_textures::
   417F DD E5         [15]  152 	push	ix
   4181 DD 21 00 00   [14]  153 	ld	ix,#0
   4185 DD 39         [15]  154 	add	ix,sp
                            155 ;src/Textures.c:57: uncompress_texture_rle((u8*)UNCOMPRESSED_TEXTURES, theme_textures[level], theme_textures_length[level]);    
   4187 DD 6E 04      [19]  156 	ld	l,4 (ix)
   418A 26 00         [ 7]  157 	ld	h,#0x00
   418C 29            [11]  158 	add	hl, hl
   418D 4D            [ 4]  159 	ld	c, l
   418E 44            [ 4]  160 	ld	b, h
   418F 21 63 41      [10]  161 	ld	hl,#_theme_textures_length
   4192 09            [11]  162 	add	hl,bc
   4193 5E            [ 7]  163 	ld	e,(hl)
   4194 23            [ 6]  164 	inc	hl
   4195 56            [ 7]  165 	ld	d,(hl)
   4196 21 5B 41      [10]  166 	ld	hl,#_theme_textures+0
   4199 09            [11]  167 	add	hl,bc
   419A 4E            [ 7]  168 	ld	c,(hl)
   419B 23            [ 6]  169 	inc	hl
   419C 46            [ 7]  170 	ld	b,(hl)
   419D D5            [11]  171 	push	de
   419E C5            [11]  172 	push	bc
   419F 21 D0 8C      [10]  173 	ld	hl,#0x8CD0
   41A2 E5            [11]  174 	push	hl
   41A3 CD F7 40      [17]  175 	call	_uncompress_texture_rle
   41A6 21 06 00      [10]  176 	ld	hl,#6
   41A9 39            [11]  177 	add	hl,sp
   41AA F9            [ 6]  178 	ld	sp,hl
   41AB DD E1         [14]  179 	pop	ix
   41AD C9            [10]  180 	ret
                            181 ;src/Textures.c:61: void uncompress_enemy_textures(u8 level) {
                            182 ;	---------------------------------
                            183 ; Function uncompress_enemy_textures
                            184 ; ---------------------------------
   41AE                     185 _uncompress_enemy_textures::
   41AE DD E5         [15]  186 	push	ix
   41B0 DD 21 00 00   [14]  187 	ld	ix,#0
   41B4 DD 39         [15]  188 	add	ix,sp
                            189 ;src/Textures.c:62: if(camelot_warriors_mode){
   41B6 3A 1A 7E      [13]  190 	ld	a,(#_camelot_warriors_mode + 0)
   41B9 B7            [ 4]  191 	or	a, a
   41BA 28 2A         [12]  192 	jr	Z,00102$
                            193 ;src/Textures.c:63: uncompress_texture_rle((u8*)UNCOMPRESSED_RAT_TEXTURE,camelot_enemy,camelot_enemy_LENGTH);
   41BC 21 7B 00      [10]  194 	ld	hl,#0x007B
   41BF E5            [11]  195 	push	hl
   41C0 21 A5 57      [10]  196 	ld	hl,#_camelot_enemy
   41C3 E5            [11]  197 	push	hl
   41C4 21 D0 A0      [10]  198 	ld	hl,#0xA0D0
   41C7 E5            [11]  199 	push	hl
   41C8 CD F7 40      [17]  200 	call	_uncompress_texture_rle
   41CB 21 06 00      [10]  201 	ld	hl,#6
   41CE 39            [11]  202 	add	hl,sp
   41CF F9            [ 6]  203 	ld	sp,hl
                            204 ;src/Textures.c:64: uncompress_texture_rle((u8*)UNCOMPRESSED_ENEMY_TEXTURE,camelot_enemy,camelot_enemy_LENGTH);
   41D0 21 7B 00      [10]  205 	ld	hl,#0x007B
   41D3 E5            [11]  206 	push	hl
   41D4 21 A5 57      [10]  207 	ld	hl,#_camelot_enemy
   41D7 E5            [11]  208 	push	hl
   41D8 21 10 A3      [10]  209 	ld	hl,#0xA310
   41DB E5            [11]  210 	push	hl
   41DC CD F7 40      [17]  211 	call	_uncompress_texture_rle
   41DF 21 06 00      [10]  212 	ld	hl,#6
   41E2 39            [11]  213 	add	hl,sp
   41E3 F9            [ 6]  214 	ld	sp,hl
   41E4 18 38         [12]  215 	jr	00104$
   41E6                     216 00102$:
                            217 ;src/Textures.c:67: uncompress_texture_rle((u8*)UNCOMPRESSED_RAT_TEXTURE,rat_enemy,rat_enemy_LENGTH);
   41E6 21 6C 00      [10]  218 	ld	hl,#0x006C
   41E9 E5            [11]  219 	push	hl
   41EA 21 39 5B      [10]  220 	ld	hl,#_rat_enemy
   41ED E5            [11]  221 	push	hl
   41EE 21 D0 A0      [10]  222 	ld	hl,#0xA0D0
   41F1 E5            [11]  223 	push	hl
   41F2 CD F7 40      [17]  224 	call	_uncompress_texture_rle
   41F5 21 06 00      [10]  225 	ld	hl,#6
   41F8 39            [11]  226 	add	hl,sp
   41F9 F9            [ 6]  227 	ld	sp,hl
                            228 ;src/Textures.c:68: uncompress_texture_rle((u8*)UNCOMPRESSED_ENEMY_TEXTURE,enemy_textures[level],enemy_textures_length[level]);
   41FA DD 6E 04      [19]  229 	ld	l,4 (ix)
   41FD 26 00         [ 7]  230 	ld	h,#0x00
   41FF 29            [11]  231 	add	hl, hl
   4200 4D            [ 4]  232 	ld	c, l
   4201 44            [ 4]  233 	ld	b, h
   4202 21 75 41      [10]  234 	ld	hl,#_enemy_textures_length
   4205 09            [11]  235 	add	hl,bc
   4206 5E            [ 7]  236 	ld	e,(hl)
   4207 23            [ 6]  237 	inc	hl
   4208 56            [ 7]  238 	ld	d,(hl)
   4209 21 6B 41      [10]  239 	ld	hl,#_enemy_textures+0
   420C 09            [11]  240 	add	hl,bc
   420D 4E            [ 7]  241 	ld	c,(hl)
   420E 23            [ 6]  242 	inc	hl
   420F 46            [ 7]  243 	ld	b,(hl)
   4210 D5            [11]  244 	push	de
   4211 C5            [11]  245 	push	bc
   4212 21 10 A3      [10]  246 	ld	hl,#0xA310
   4215 E5            [11]  247 	push	hl
   4216 CD F7 40      [17]  248 	call	_uncompress_texture_rle
   4219 21 06 00      [10]  249 	ld	hl,#6
   421C 39            [11]  250 	add	hl,sp
   421D F9            [ 6]  251 	ld	sp,hl
   421E                     252 00104$:
   421E DD E1         [14]  253 	pop	ix
   4220 C9            [10]  254 	ret
                            255 ;src/Textures.c:72: void uncompress_item_textures(){
                            256 ;	---------------------------------
                            257 ; Function uncompress_item_textures
                            258 ; ---------------------------------
   4221                     259 _uncompress_item_textures::
                            260 ;src/Textures.c:73: uncompress_texture_rle((u8*)UNCOMPRESSED_OBJECT_TEXTURES, items_tileset, items_tileset_LENGTH);
   4221 21 4A 01      [10]  261 	ld	hl,#0x014A
   4224 E5            [11]  262 	push	hl
   4225 21 8C 4F      [10]  263 	ld	hl,#_items_tileset
   4228 E5            [11]  264 	push	hl
   4229 21 50 A5      [10]  265 	ld	hl,#0xA550
   422C E5            [11]  266 	push	hl
   422D CD F7 40      [17]  267 	call	_uncompress_texture_rle
   4230 21 06 00      [10]  268 	ld	hl,#6
   4233 39            [11]  269 	add	hl,sp
   4234 F9            [ 6]  270 	ld	sp,hl
   4235 C9            [10]  271 	ret
                            272 	.area _CODE
                            273 	.area _INITIALIZER
                            274 	.area _CABS (ABS)
