                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module Renderer
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _draw_column_to_buffer
                             12 	.globl _draw_column_to_buffer_enemy
                             13 	.globl _draw_column_to_buffer_object
                             14 	.globl _draw_column_to_buffer_untextured
                             15 	.globl _calculate_cells_in_view
                             16 	.globl _cpct_memset
                             17 	.globl _offsets_cells_in_view
                             18 	.globl _cells_in_view_array
                             19 	.globl _g_texturedWalls
                             20 	.globl _g_pixelMask
                             21 	.globl _g_colors
                             22 	.globl _g_palette
                             23 	.globl _render_draw_to_buffer
                             24 	.globl _draw_minimap_to_buffer
                             25 ;--------------------------------------------------------
                             26 ; special function registers
                             27 ;--------------------------------------------------------
                             28 ;--------------------------------------------------------
                             29 ; ram data
                             30 ;--------------------------------------------------------
                             31 	.area _DATA
                             32 ;--------------------------------------------------------
                             33 ; ram data
                             34 ;--------------------------------------------------------
                             35 	.area _INITIALIZED
                             36 ;--------------------------------------------------------
                             37 ; absolute external ram data
                             38 ;--------------------------------------------------------
                             39 	.area _DABS (ABS)
                             40 ;--------------------------------------------------------
                             41 ; global & static initialisations
                             42 ;--------------------------------------------------------
                             43 	.area _HOME
                             44 	.area _GSINIT
                             45 	.area _GSFINAL
                             46 	.area _GSINIT
                             47 ;--------------------------------------------------------
                             48 ; Home
                             49 ;--------------------------------------------------------
                             50 	.area _HOME
                             51 	.area _HOME
                             52 ;--------------------------------------------------------
                             53 ; code
                             54 ;--------------------------------------------------------
                             55 	.area _CODE
                             56 ;src/Renderer.c:53: void calculate_cells_in_view(){
                             57 ;	---------------------------------
                             58 ; Function calculate_cells_in_view
                             59 ; ---------------------------------
   08EB                      60 _calculate_cells_in_view::
   08EB DD E5         [15]   61 	push	ix
   08ED DD 21 00 00   [14]   62 	ld	ix,#0
   08F1 DD 39         [15]   63 	add	ix,sp
   08F3 21 F2 FF      [10]   64 	ld	hl,#-14
   08F6 39            [11]   65 	add	hl,sp
   08F7 F9            [ 6]   66 	ld	sp,hl
                             67 ;src/Renderer.c:55: u8 offset=0, n=0, j, i;
   08F8 DD 36 FA 00   [19]   68 	ld	-6 (ix),#0x00
   08FC DD 36 F9 00   [19]   69 	ld	-7 (ix),#0x00
                             70 ;src/Renderer.c:58: if(PLAYER_direction.y!=0){
   0900 3A E1 08      [13]   71 	ld	a,(#_PLAYER_direction + 1)
   0903 DD 77 FD      [19]   72 	ld	-3 (ix), a
   0906 B7            [ 4]   73 	or	a, a
   0907 28 32         [12]   74 	jr	Z,00102$
                             75 ;src/Renderer.c:59: vert=1;
   0909 DD 36 F2 01   [19]   76 	ld	-14 (ix),#0x01
                             77 ;src/Renderer.c:60: dy=PLAYER_direction.y;
   090D DD 4E FD      [19]   78 	ld	c,-3 (ix)
   0910 DD 71 F4      [19]   79 	ld	-12 (ix),c
                             80 ;src/Renderer.c:61: dx=-PLAYER_direction.y;
   0913 AF            [ 4]   81 	xor	a, a
   0914 DD 96 FD      [19]   82 	sub	a, -3 (ix)
   0917 DD 77 F5      [19]   83 	ld	-11 (ix), a
                             84 ;src/Renderer.c:63: x0 = PLAYER_position.x-(17*dx);
   091A 21 DE 08      [10]   85 	ld	hl,#_PLAYER_position+0
   091D 4E            [ 7]   86 	ld	c,(hl)
   091E DD 6E F5      [19]   87 	ld	l,-11 (ix)
   0921 5D            [ 4]   88 	ld	e,l
   0922 29            [11]   89 	add	hl, hl
   0923 29            [11]   90 	add	hl, hl
   0924 29            [11]   91 	add	hl, hl
   0925 29            [11]   92 	add	hl, hl
   0926 19            [11]   93 	add	hl, de
   0927 79            [ 4]   94 	ld	a,c
   0928 95            [ 4]   95 	sub	a, l
   0929 DD 77 F6      [19]   96 	ld	-10 (ix),a
                             97 ;src/Renderer.c:64: y0 = PLAYER_position.y+(6*dy);
   092C 21 DF 08      [10]   98 	ld	hl,#_PLAYER_position+1
   092F 4E            [ 7]   99 	ld	c,(hl)
   0930 DD 6E F4      [19]  100 	ld	l,-12 (ix)
   0933 5D            [ 4]  101 	ld	e,l
   0934 29            [11]  102 	add	hl, hl
   0935 19            [11]  103 	add	hl, de
   0936 29            [11]  104 	add	hl, hl
   0937 09            [11]  105 	add	hl, bc
   0938 4D            [ 4]  106 	ld	c,l
   0939 18 34         [12]  107 	jr	00103$
   093B                     108 00102$:
                            109 ;src/Renderer.c:67: vert=0;
   093B DD 36 F2 00   [19]  110 	ld	-14 (ix),#0x00
                            111 ;src/Renderer.c:68: dy=PLAYER_direction.x;
   093F 3A E0 08      [13]  112 	ld	a,(#_PLAYER_direction + 0)
   0942 DD 77 FD      [19]  113 	ld	-3 (ix), a
   0945 DD 77 F4      [19]  114 	ld	-12 (ix),a
                            115 ;src/Renderer.c:69: dx=PLAYER_direction.x;
   0948 DD 7E FD      [19]  116 	ld	a,-3 (ix)
   094B DD 77 F5      [19]  117 	ld	-11 (ix),a
                            118 ;src/Renderer.c:71: y0 = PLAYER_position.y-(17*dy);
   094E 21 DF 08      [10]  119 	ld	hl, #_PLAYER_position + 1
   0951 4E            [ 7]  120 	ld	c,(hl)
   0952 DD 6E F4      [19]  121 	ld	l,-12 (ix)
   0955 5D            [ 4]  122 	ld	e,l
   0956 29            [11]  123 	add	hl, hl
   0957 29            [11]  124 	add	hl, hl
   0958 29            [11]  125 	add	hl, hl
   0959 29            [11]  126 	add	hl, hl
   095A 19            [11]  127 	add	hl, de
   095B 79            [ 4]  128 	ld	a,c
   095C 95            [ 4]  129 	sub	a, l
   095D 4F            [ 4]  130 	ld	c,a
                            131 ;src/Renderer.c:72: x0 = PLAYER_position.x+(6*dx);
   095E 21 DE 08      [10]  132 	ld	hl, #_PLAYER_position + 0
   0961 46            [ 7]  133 	ld	b,(hl)
   0962 DD 7E FD      [19]  134 	ld	a,-3 (ix)
   0965 5F            [ 4]  135 	ld	e,a
   0966 87            [ 4]  136 	add	a, a
   0967 83            [ 4]  137 	add	a, e
   0968 87            [ 4]  138 	add	a, a
   0969 5F            [ 4]  139 	ld	e,a
   096A 68            [ 4]  140 	ld	l,b
   096B 19            [11]  141 	add	hl, de
   096C DD 75 F6      [19]  142 	ld	-10 (ix),l
   096F                     143 00103$:
                            144 ;src/Renderer.c:76: x=x0;
   096F DD 5E F6      [19]  145 	ld	e,-10 (ix)
                            146 ;src/Renderer.c:77: y=y0;
   0972 DD 71 F3      [19]  147 	ld	-13 (ix),c
                            148 ;src/Renderer.c:79: for(j=0;j<6;++j){
   0975 DD 7E F5      [19]  149 	ld	a,-11 (ix)
   0978 07            [ 4]  150 	rlca
   0979 E6 01         [ 7]  151 	and	a,#0x01
   097B DD 77 FD      [19]  152 	ld	-3 (ix),a
   097E DD 7E F4      [19]  153 	ld	a,-12 (ix)
   0981 07            [ 4]  154 	rlca
   0982 E6 01         [ 7]  155 	and	a,#0x01
   0984 DD 77 FB      [19]  156 	ld	-5 (ix),a
   0987 DD 36 F8 00   [19]  157 	ld	-8 (ix),#0x00
                            158 ;src/Renderer.c:81: for(i=offset;i<35-offset;++i){
   098B                     159 00138$:
   098B DD 7E F9      [19]  160 	ld	a,-7 (ix)
   098E DD 77 FC      [19]  161 	ld	-4 (ix),a
   0991 DD 7E FA      [19]  162 	ld	a,-6 (ix)
   0994 DD 77 F7      [19]  163 	ld	-9 (ix),a
   0997                     164 00125$:
   0997 DD 6E FA      [19]  165 	ld	l,-6 (ix)
   099A 26 00         [ 7]  166 	ld	h,#0x00
   099C 3E 23         [ 7]  167 	ld	a,#0x23
   099E 95            [ 4]  168 	sub	a, l
   099F 6F            [ 4]  169 	ld	l,a
   09A0 3E 00         [ 7]  170 	ld	a,#0x00
   09A2 9C            [ 4]  171 	sbc	a, h
   09A3 67            [ 4]  172 	ld	h,a
   09A4 DD 7E F7      [19]  173 	ld	a, -9 (ix)
   09A7 16 00         [ 7]  174 	ld	d, #0x00
   09A9 95            [ 4]  175 	sub	a, l
   09AA 7A            [ 4]  176 	ld	a,d
   09AB 9C            [ 4]  177 	sbc	a, h
   09AC E2 B1 09      [10]  178 	jp	PO, 00181$
   09AF EE 80         [ 7]  179 	xor	a, #0x80
   09B1                     180 00181$:
   09B1 F2 2B 0A      [10]  181 	jp	P,00143$
                            182 ;src/Renderer.c:84: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   09B4 2A B8 0A      [16]  183 	ld	hl,(_cells_in_view_array)
   09B7 7D            [ 4]  184 	ld	a,l
   09B8 DD 86 FC      [19]  185 	add	a, -4 (ix)
   09BB DD 77 FE      [19]  186 	ld	-2 (ix),a
   09BE 7C            [ 4]  187 	ld	a,h
   09BF CE 00         [ 7]  188 	adc	a, #0x00
   09C1 DD 77 FF      [19]  189 	ld	-1 (ix),a
                            190 ;src/Renderer.c:83: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
   09C4 CB 7B         [ 8]  191 	bit	7, e
   09C6 20 3C         [12]  192 	jr	NZ,00105$
   09C8 7B            [ 4]  193 	ld	a,e
   09C9 EE 80         [ 7]  194 	xor	a, #0x80
   09CB D6 A0         [ 7]  195 	sub	a, #0xA0
   09CD 30 35         [12]  196 	jr	NC,00105$
   09CF DD CB F3 7E   [20]  197 	bit	7, -13 (ix)
   09D3 20 2F         [12]  198 	jr	NZ,00105$
   09D5 DD 7E F3      [19]  199 	ld	a,-13 (ix)
   09D8 EE 80         [ 7]  200 	xor	a, #0x80
   09DA D6 A0         [ 7]  201 	sub	a, #0xA0
   09DC 30 26         [12]  202 	jr	NC,00105$
                            203 ;src/Renderer.c:84: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   09DE 7B            [ 4]  204 	ld	a,e
   09DF 57            [ 4]  205 	ld	d,a
   09E0 17            [ 4]  206 	rla
   09E1 9F            [ 4]  207 	sbc	a, a
   09E2 42            [ 4]  208 	ld	b, d
   09E3 C6 60         [ 7]  209 	add	a,#0x60
   09E5 57            [ 4]  210 	ld	d,a
   09E6 DD 6E F3      [19]  211 	ld	l,-13 (ix)
   09E9 DD 7E F3      [19]  212 	ld	a,-13 (ix)
   09EC 17            [ 4]  213 	rla
   09ED 9F            [ 4]  214 	sbc	a, a
   09EE 67            [ 4]  215 	ld	h,a
   09EF 29            [11]  216 	add	hl, hl
   09F0 29            [11]  217 	add	hl, hl
   09F1 29            [11]  218 	add	hl, hl
   09F2 29            [11]  219 	add	hl, hl
   09F3 29            [11]  220 	add	hl, hl
   09F4 78            [ 4]  221 	ld	a,b
   09F5 85            [ 4]  222 	add	a, l
   09F6 6F            [ 4]  223 	ld	l,a
   09F7 7A            [ 4]  224 	ld	a,d
   09F8 8C            [ 4]  225 	adc	a, h
   09F9 67            [ 4]  226 	ld	h,a
   09FA 46            [ 7]  227 	ld	b,(hl)
   09FB DD 6E FE      [19]  228 	ld	l,-2 (ix)
   09FE DD 66 FF      [19]  229 	ld	h,-1 (ix)
   0A01 70            [ 7]  230 	ld	(hl),b
   0A02 18 08         [12]  231 	jr	00106$
   0A04                     232 00105$:
                            233 ;src/Renderer.c:87: cells_in_view_array[n]=CELLTYPE_WALL1;
   0A04 DD 6E FE      [19]  234 	ld	l,-2 (ix)
   0A07 DD 66 FF      [19]  235 	ld	h,-1 (ix)
   0A0A 36 81         [10]  236 	ld	(hl),#0x81
   0A0C                     237 00106$:
                            238 ;src/Renderer.c:91: if(vert){
   0A0C DD 7E F2      [19]  239 	ld	a,-14 (ix)
   0A0F B7            [ 4]  240 	or	a, a
   0A10 28 07         [12]  241 	jr	Z,00111$
                            242 ;src/Renderer.c:92: x+=dx;
   0A12 7B            [ 4]  243 	ld	a,e
   0A13 DD 86 F5      [19]  244 	add	a, -11 (ix)
   0A16 5F            [ 4]  245 	ld	e,a
   0A17 18 09         [12]  246 	jr	00112$
   0A19                     247 00111$:
                            248 ;src/Renderer.c:95: y+=dy;
   0A19 DD 7E F3      [19]  249 	ld	a,-13 (ix)
   0A1C DD 86 F4      [19]  250 	add	a, -12 (ix)
   0A1F DD 77 F3      [19]  251 	ld	-13 (ix),a
   0A22                     252 00112$:
                            253 ;src/Renderer.c:97: ++n;
   0A22 DD 34 FC      [23]  254 	inc	-4 (ix)
                            255 ;src/Renderer.c:81: for(i=offset;i<35-offset;++i){
   0A25 DD 34 F7      [23]  256 	inc	-9 (ix)
   0A28 C3 97 09      [10]  257 	jp	00125$
   0A2B                     258 00143$:
   0A2B DD 7E FC      [19]  259 	ld	a,-4 (ix)
   0A2E DD 77 F9      [19]  260 	ld	-7 (ix),a
                            261 ;src/Renderer.c:99: offset=offsets_cells_in_view[j];
   0A31 3E BA         [ 7]  262 	ld	a,#<(_offsets_cells_in_view)
   0A33 DD 86 F8      [19]  263 	add	a, -8 (ix)
   0A36 6F            [ 4]  264 	ld	l,a
   0A37 3E 0A         [ 7]  265 	ld	a,#>(_offsets_cells_in_view)
   0A39 CE 00         [ 7]  266 	adc	a, #0x00
   0A3B 67            [ 4]  267 	ld	h,a
   0A3C 7E            [ 7]  268 	ld	a,(hl)
                            269 ;src/Renderer.c:103: if(dx<0) x=x0-offset;
   0A3D DD 77 FA      [19]  270 	ld	-6 (ix), a
   0A40 DD 77 FE      [19]  271 	ld	-2 (ix),a
                            272 ;src/Renderer.c:101: if(vert){
   0A43 DD 7E F2      [19]  273 	ld	a,-14 (ix)
   0A46 B7            [ 4]  274 	or	a, a
   0A47 28 21         [12]  275 	jr	Z,00121$
                            276 ;src/Renderer.c:102: y-=dy;
   0A49 DD 7E F3      [19]  277 	ld	a,-13 (ix)
   0A4C DD 96 F4      [19]  278 	sub	a, -12 (ix)
   0A4F DD 77 F3      [19]  279 	ld	-13 (ix),a
                            280 ;src/Renderer.c:103: if(dx<0) x=x0-offset;
   0A52 DD 7E FD      [19]  281 	ld	a,-3 (ix)
   0A55 B7            [ 4]  282 	or	a, a
   0A56 28 09         [12]  283 	jr	Z,00115$
   0A58 DD 7E F6      [19]  284 	ld	a,-10 (ix)
   0A5B DD 96 FE      [19]  285 	sub	a, -2 (ix)
   0A5E 5F            [ 4]  286 	ld	e,a
   0A5F 18 24         [12]  287 	jr	00128$
   0A61                     288 00115$:
                            289 ;src/Renderer.c:104: else x=x0+offset;
   0A61 DD 7E F6      [19]  290 	ld	a,-10 (ix)
   0A64 DD 86 FE      [19]  291 	add	a, -2 (ix)
   0A67 5F            [ 4]  292 	ld	e,a
   0A68 18 1B         [12]  293 	jr	00128$
   0A6A                     294 00121$:
                            295 ;src/Renderer.c:108: x-=dx;
   0A6A 7B            [ 4]  296 	ld	a,e
   0A6B DD 96 F5      [19]  297 	sub	a, -11 (ix)
   0A6E 5F            [ 4]  298 	ld	e,a
                            299 ;src/Renderer.c:109: if(dy<0) y=y0-offset;
   0A6F DD 7E FB      [19]  300 	ld	a,-5 (ix)
   0A72 B7            [ 4]  301 	or	a, a
   0A73 28 09         [12]  302 	jr	Z,00118$
   0A75 79            [ 4]  303 	ld	a,c
   0A76 DD 96 FE      [19]  304 	sub	a, -2 (ix)
   0A79 DD 77 F3      [19]  305 	ld	-13 (ix),a
   0A7C 18 07         [12]  306 	jr	00128$
   0A7E                     307 00118$:
                            308 ;src/Renderer.c:110: else y=y0+offset;
   0A7E 79            [ 4]  309 	ld	a,c
   0A7F DD 86 FE      [19]  310 	add	a, -2 (ix)
   0A82 DD 77 F3      [19]  311 	ld	-13 (ix),a
   0A85                     312 00128$:
                            313 ;src/Renderer.c:79: for(j=0;j<6;++j){
   0A85 DD 34 F8      [23]  314 	inc	-8 (ix)
   0A88 DD 7E F8      [19]  315 	ld	a,-8 (ix)
   0A8B D6 06         [ 7]  316 	sub	a, #0x06
   0A8D DA 8B 09      [10]  317 	jp	C,00138$
   0A90 DD F9         [10]  318 	ld	sp, ix
   0A92 DD E1         [14]  319 	pop	ix
   0A94 C9            [10]  320 	ret
   0A95                     321 _g_palette:
   0A95 08                  322 	.db #0x08	; 8
   0A96 00                  323 	.db #0x00	; 0
   0A97 0D                  324 	.db #0x0D	; 13
   0A98 1A                  325 	.db #0x1A	; 26
   0A99 06                  326 	.db #0x06	; 6
   0A9A 18                  327 	.db #0x18	; 24
   0A9B 01                  328 	.db #0x01	; 1
   0A9C 09                  329 	.db #0x09	; 9
   0A9D 19                  330 	.db #0x19	; 25
   0A9E 03                  331 	.db #0x03	; 3
   0A9F 12                  332 	.db #0x12	; 18
   0AA0 05                  333 	.db #0x05	; 5
   0AA1 0E                  334 	.db #0x0E	; 14
   0AA2 0F                  335 	.db #0x0F	; 15
   0AA3 11                  336 	.db #0x11	; 17
   0AA4 13                  337 	.db #0x13	; 19
   0AA5                     338 _g_colors:
   0AA5 00                  339 	.db #0x00	; 0
   0AA6 C0                  340 	.db #0xC0	; 192
   0AA7 0C                  341 	.db #0x0C	; 12
   0AA8 CC                  342 	.db #0xCC	; 204
   0AA9 30                  343 	.db #0x30	; 48	'0'
   0AAA F0                  344 	.db #0xF0	; 240
   0AAB 3C                  345 	.db #0x3C	; 60
   0AAC FC                  346 	.db #0xFC	; 252
   0AAD 03                  347 	.db #0x03	; 3
   0AAE C3                  348 	.db #0xC3	; 195
   0AAF 0F                  349 	.db #0x0F	; 15
   0AB0 CF                  350 	.db #0xCF	; 207
   0AB1 33                  351 	.db #0x33	; 51	'3'
   0AB2 F3                  352 	.db #0xF3	; 243
   0AB3 3F                  353 	.db #0x3F	; 63
   0AB4 FF                  354 	.db #0xFF	; 255
   0AB5                     355 _g_pixelMask:
   0AB5 AA                  356 	.db #0xAA	; 170
   0AB6 55                  357 	.db #0x55	; 85	'U'
   0AB7                     358 _g_texturedWalls:
   0AB7 01                  359 	.db #0x01	; 1
   0AB8                     360 _cells_in_view_array:
   0AB8 A0 9E               361 	.dw #0x9EA0
   0ABA                     362 _offsets_cells_in_view:
   0ABA 08                  363 	.db #0x08	; 8
   0ABB 0C                  364 	.db #0x0C	; 12
   0ABC 0E                  365 	.db #0x0E	; 14
   0ABD 0F                  366 	.db #0x0F	; 15
   0ABE 10                  367 	.db #0x10	; 16
                            368 ;src/Renderer.c:118: void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
                            369 ;	---------------------------------
                            370 ; Function draw_column_to_buffer_untextured
                            371 ; ---------------------------------
   0ABF                     372 _draw_column_to_buffer_untextured::
   0ABF DD E5         [15]  373 	push	ix
   0AC1 DD 21 00 00   [14]  374 	ld	ix,#0
   0AC5 DD 39         [15]  375 	add	ix,sp
   0AC7 F5            [11]  376 	push	af
                            377 ;src/Renderer.c:119: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   0AC8 DD 7E 04      [19]  378 	ld	a, 4 (ix)
   0ACB CB 3F         [ 8]  379 	srl	a
   0ACD 4F            [ 4]  380 	ld	c,a
   0ACE 3E 00         [ 7]  381 	ld	a,#0x00
   0AD0 C6 8B         [ 7]  382 	add	a,#0x8B
   0AD2 47            [ 4]  383 	ld	b,a
                            384 ;src/Renderer.c:121: u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
   0AD3 11 A5 0A      [10]  385 	ld	de,#_g_colors+0
   0AD6 DD 6E 06      [19]  386 	ld	l,6 (ix)
   0AD9 26 00         [ 7]  387 	ld	h,#0x00
   0ADB 19            [11]  388 	add	hl,de
   0ADC 7E            [ 7]  389 	ld	a,(hl)
   0ADD DD 77 FE      [19]  390 	ld	-2 (ix),a
                            391 ;src/Renderer.c:122: u8 pixMask = g_pixelMask[column&1];
   0AE0 11 B5 0A      [10]  392 	ld	de,#_g_pixelMask+0
   0AE3 DD 7E 04      [19]  393 	ld	a,4 (ix)
   0AE6 E6 01         [ 7]  394 	and	a, #0x01
   0AE8 6F            [ 4]  395 	ld	l,a
   0AE9 26 00         [ 7]  396 	ld	h,#0x00
   0AEB 19            [11]  397 	add	hl,de
   0AEC 5E            [ 7]  398 	ld	e,(hl)
                            399 ;src/Renderer.c:131: if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
   0AED 3E 64         [ 7]  400 	ld	a,#0x64
   0AEF DD 96 05      [19]  401 	sub	a, 5 (ix)
   0AF2 30 04         [12]  402 	jr	NC,00102$
   0AF4 DD 36 05 64   [19]  403 	ld	5 (ix),#0x64
   0AF8                     404 00102$:
                            405 ;src/Renderer.c:133: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   0AF8 DD 6E 05      [19]  406 	ld	l,5 (ix)
   0AFB CB 3D         [ 8]  407 	srl	l
   0AFD 3E 32         [ 7]  408 	ld	a,#0x32
   0AFF 95            [ 4]  409 	sub	a, l
                            410 ;src/Renderer.c:136: pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
   0B00 D5            [11]  411 	push	de
   0B01 5F            [ 4]  412 	ld	e,a
   0B02 16 00         [ 7]  413 	ld	d,#0x00
   0B04 6B            [ 4]  414 	ld	l, e
   0B05 62            [ 4]  415 	ld	h, d
   0B06 29            [11]  416 	add	hl, hl
   0B07 29            [11]  417 	add	hl, hl
   0B08 19            [11]  418 	add	hl, de
   0B09 29            [11]  419 	add	hl, hl
   0B0A 29            [11]  420 	add	hl, hl
   0B0B 29            [11]  421 	add	hl, hl
   0B0C D1            [10]  422 	pop	de
   0B0D 09            [11]  423 	add	hl,bc
   0B0E 4D            [ 4]  424 	ld	c,l
   0B0F 44            [ 4]  425 	ld	b,h
                            426 ;src/Renderer.c:138: j=lineHeight;
   0B10 DD 56 05      [19]  427 	ld	d,5 (ix)
                            428 ;src/Renderer.c:140: for(j;j;--j){
   0B13 7B            [ 4]  429 	ld	a,e
   0B14 2F            [ 4]  430 	cpl
   0B15 DD 77 FF      [19]  431 	ld	-1 (ix),a
   0B18 7B            [ 4]  432 	ld	a,e
   0B19 DD A6 FE      [19]  433 	and	a, -2 (ix)
   0B1C 5F            [ 4]  434 	ld	e,a
   0B1D                     435 00105$:
   0B1D 7A            [ 4]  436 	ld	a,d
   0B1E B7            [ 4]  437 	or	a, a
   0B1F 28 0F         [12]  438 	jr	Z,00107$
                            439 ;src/Renderer.c:141: val =  ((*pvmem)&(~pixMask));
   0B21 0A            [ 7]  440 	ld	a,(bc)
   0B22 DD A6 FF      [19]  441 	and	a, -1 (ix)
                            442 ;src/Renderer.c:143: *pvmem = val|(w_color&pixMask);
   0B25 B3            [ 4]  443 	or	a, e
   0B26 02            [ 7]  444 	ld	(bc),a
                            445 ;src/Renderer.c:145: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   0B27 21 28 00      [10]  446 	ld	hl,#0x0028
   0B2A 09            [11]  447 	add	hl,bc
   0B2B 4D            [ 4]  448 	ld	c,l
   0B2C 44            [ 4]  449 	ld	b,h
                            450 ;src/Renderer.c:140: for(j;j;--j){
   0B2D 15            [ 4]  451 	dec	d
   0B2E 18 ED         [12]  452 	jr	00105$
   0B30                     453 00107$:
   0B30 DD F9         [10]  454 	ld	sp, ix
   0B32 DD E1         [14]  455 	pop	ix
   0B34 C9            [10]  456 	ret
                            457 ;src/Renderer.c:149: void draw_column_to_buffer_object(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            458 ;	---------------------------------
                            459 ; Function draw_column_to_buffer_object
                            460 ; ---------------------------------
   0B35                     461 _draw_column_to_buffer_object::
                            462 ;src/Renderer.c:151: }
   0B35 C9            [10]  463 	ret
                            464 ;src/Renderer.c:153: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            465 ;	---------------------------------
                            466 ; Function draw_column_to_buffer_enemy
                            467 ; ---------------------------------
   0B36                     468 _draw_column_to_buffer_enemy::
   0B36 DD E5         [15]  469 	push	ix
   0B38 DD 21 00 00   [14]  470 	ld	ix,#0
   0B3C DD 39         [15]  471 	add	ix,sp
   0B3E 21 F2 FF      [10]  472 	ld	hl,#-14
   0B41 39            [11]  473 	add	hl,sp
   0B42 F9            [ 6]  474 	ld	sp,hl
                            475 ;src/Renderer.c:170: u16 texture_line=0;
   0B43 21 00 00      [10]  476 	ld	hl,#0x0000
   0B46 E3            [19]  477 	ex	(sp), hl
                            478 ;src/Renderer.c:172: if(texture_column>=4 && texture_column<28){
   0B47 DD 7E 07      [19]  479 	ld	a,7 (ix)
   0B4A D6 04         [ 7]  480 	sub	a, #0x04
   0B4C DA 6E 0C      [10]  481 	jp	C,00112$
   0B4F DD 7E 07      [19]  482 	ld	a,7 (ix)
   0B52 D6 1C         [ 7]  483 	sub	a, #0x1C
   0B54 D2 6E 0C      [10]  484 	jp	NC,00112$
                            485 ;src/Renderer.c:175: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(index-1)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
   0B57 DD 4E 06      [19]  486 	ld	c,6 (ix)
   0B5A 06 00         [ 7]  487 	ld	b,#0x00
   0B5C 0B            [ 6]  488 	dec	bc
   0B5D 69            [ 4]  489 	ld	l, c
   0B5E 60            [ 4]  490 	ld	h, b
   0B5F 29            [11]  491 	add	hl, hl
   0B60 29            [11]  492 	add	hl, hl
   0B61 29            [11]  493 	add	hl, hl
   0B62 09            [11]  494 	add	hl, bc
   0B63 29            [11]  495 	add	hl, hl
   0B64 29            [11]  496 	add	hl, hl
   0B65 29            [11]  497 	add	hl, hl
   0B66 29            [11]  498 	add	hl, hl
   0B67 29            [11]  499 	add	hl, hl
   0B68 29            [11]  500 	add	hl, hl
   0B69 01 00 78      [10]  501 	ld	bc,#0x7800
   0B6C 09            [11]  502 	add	hl,bc
   0B6D 4D            [ 4]  503 	ld	c,l
   0B6E 44            [ 4]  504 	ld	b,h
   0B6F DD 7E 07      [19]  505 	ld	a, 7 (ix)
   0B72 16 00         [ 7]  506 	ld	d, #0x00
   0B74 C6 FC         [ 7]  507 	add	a,#0xFC
   0B76 5F            [ 4]  508 	ld	e,a
   0B77 7A            [ 4]  509 	ld	a,d
   0B78 CE FF         [ 7]  510 	adc	a,#0xFF
   0B7A 57            [ 4]  511 	ld	d,a
   0B7B 6B            [ 4]  512 	ld	l, e
   0B7C 62            [ 4]  513 	ld	h, d
   0B7D 29            [11]  514 	add	hl, hl
   0B7E 19            [11]  515 	add	hl, de
   0B7F 29            [11]  516 	add	hl, hl
   0B80 29            [11]  517 	add	hl, hl
   0B81 29            [11]  518 	add	hl, hl
   0B82 09            [11]  519 	add	hl,bc
   0B83 DD 75 F7      [19]  520 	ld	-9 (ix),l
   0B86 DD 74 F8      [19]  521 	ld	-8 (ix),h
                            522 ;src/Renderer.c:177: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   0B89 DD 7E 04      [19]  523 	ld	a,4 (ix)
   0B8C CB 3F         [ 8]  524 	srl	a
   0B8E C6 00         [ 7]  525 	add	a, #0x00
   0B90 DD 77 FA      [19]  526 	ld	-6 (ix),a
   0B93 3E 00         [ 7]  527 	ld	a,#0x00
   0B95 CE 8B         [ 7]  528 	adc	a, #0x8B
   0B97 DD 77 FB      [19]  529 	ld	-5 (ix),a
                            530 ;src/Renderer.c:179: pixMask = g_pixelMask[column&1];
   0B9A 01 B5 0A      [10]  531 	ld	bc,#_g_pixelMask+0
   0B9D DD 7E 04      [19]  532 	ld	a,4 (ix)
   0BA0 E6 01         [ 7]  533 	and	a, #0x01
   0BA2 6F            [ 4]  534 	ld	l, a
   0BA3 26 00         [ 7]  535 	ld	h,#0x00
   0BA5 09            [11]  536 	add	hl,bc
   0BA6 7E            [ 7]  537 	ld	a,(hl)
   0BA7 DD 77 F9      [19]  538 	ld	-7 (ix),a
                            539 ;src/Renderer.c:181: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
   0BAA DD 7E 05      [19]  540 	ld	a,5 (ix)
   0BAD CB 3F         [ 8]  541 	srl	a
   0BAF C6 32         [ 7]  542 	add	a, #0x32
   0BB1 DD 77 F6      [19]  543 	ld	-10 (ix),a
                            544 ;src/Renderer.c:182: lineHeight = (lineHeight*3)/4;
   0BB4 DD 4E 05      [19]  545 	ld	c,5 (ix)
   0BB7 06 00         [ 7]  546 	ld	b,#0x00
   0BB9 69            [ 4]  547 	ld	l, c
   0BBA 60            [ 4]  548 	ld	h, b
   0BBB 29            [11]  549 	add	hl, hl
   0BBC 09            [11]  550 	add	hl, bc
   0BBD DD 75 FE      [19]  551 	ld	-2 (ix),l
   0BC0 DD 74 FF      [19]  552 	ld	-1 (ix),h
   0BC3 DD 7E FE      [19]  553 	ld	a,-2 (ix)
   0BC6 DD 77 FC      [19]  554 	ld	-4 (ix),a
   0BC9 DD 7E FF      [19]  555 	ld	a,-1 (ix)
   0BCC DD 77 FD      [19]  556 	ld	-3 (ix),a
   0BCF DD CB FF 7E   [20]  557 	bit	7, -1 (ix)
   0BD3 28 10         [12]  558 	jr	Z,00114$
   0BD5 DD 7E FE      [19]  559 	ld	a,-2 (ix)
   0BD8 C6 03         [ 7]  560 	add	a, #0x03
   0BDA DD 77 FC      [19]  561 	ld	-4 (ix),a
   0BDD DD 7E FF      [19]  562 	ld	a,-1 (ix)
   0BE0 CE 00         [ 7]  563 	adc	a, #0x00
   0BE2 DD 77 FD      [19]  564 	ld	-3 (ix),a
   0BE5                     565 00114$:
   0BE5 DD 46 FC      [19]  566 	ld	b,-4 (ix)
   0BE8 DD 4E FD      [19]  567 	ld	c,-3 (ix)
   0BEB CB 29         [ 8]  568 	sra	c
   0BED CB 18         [ 8]  569 	rr	b
   0BEF CB 29         [ 8]  570 	sra	c
   0BF1 CB 18         [ 8]  571 	rr	b
                            572 ;src/Renderer.c:183: enemy_top_height = ground_height - lineHeight;
   0BF3 DD 7E F6      [19]  573 	ld	a,-10 (ix)
   0BF6 90            [ 4]  574 	sub	a, b
   0BF7 4F            [ 4]  575 	ld	c,a
                            576 ;src/Renderer.c:185: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
   0BF8 58            [ 4]  577 	ld	e,b
   0BF9 16 00         [ 7]  578 	ld	d,#0x00
   0BFB C5            [11]  579 	push	bc
   0BFC D5            [11]  580 	push	de
   0BFD 21 00 18      [10]  581 	ld	hl,#0x1800
   0C00 E5            [11]  582 	push	hl
   0C01 CD 1D 44      [17]  583 	call	__divsint
   0C04 F1            [10]  584 	pop	af
   0C05 F1            [10]  585 	pop	af
   0C06 C1            [10]  586 	pop	bc
   0C07 DD 75 F4      [19]  587 	ld	-12 (ix),l
   0C0A DD 74 F5      [19]  588 	ld	-11 (ix),h
                            589 ;src/Renderer.c:186: j=lineHeight;
   0C0D 50            [ 4]  590 	ld	d,b
                            591 ;src/Renderer.c:188: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   0C0E 3E 64         [ 7]  592 	ld	a,#0x64
   0C10 90            [ 4]  593 	sub	a, b
   0C11 30 02         [12]  594 	jr	NC,00102$
                            595 ;src/Renderer.c:189: j=90;
   0C13 16 5A         [ 7]  596 	ld	d,#0x5A
   0C15                     597 00102$:
                            598 ;src/Renderer.c:192: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
   0C15 06 00         [ 7]  599 	ld	b,#0x00
   0C17 69            [ 4]  600 	ld	l, c
   0C18 60            [ 4]  601 	ld	h, b
   0C19 29            [11]  602 	add	hl, hl
   0C1A 29            [11]  603 	add	hl, hl
   0C1B 09            [11]  604 	add	hl, bc
   0C1C 29            [11]  605 	add	hl, hl
   0C1D 29            [11]  606 	add	hl, hl
   0C1E 29            [11]  607 	add	hl, hl
   0C1F DD 7E FA      [19]  608 	ld	a,-6 (ix)
   0C22 85            [ 4]  609 	add	a, l
   0C23 4F            [ 4]  610 	ld	c,a
   0C24 DD 7E FB      [19]  611 	ld	a,-5 (ix)
   0C27 8C            [ 4]  612 	adc	a, h
   0C28 47            [ 4]  613 	ld	b,a
                            614 ;src/Renderer.c:194: for(j;j;--j){
   0C29 DD 7E F9      [19]  615 	ld	a,-7 (ix)
   0C2C 2F            [ 4]  616 	cpl
   0C2D 5F            [ 4]  617 	ld	e,a
   0C2E                     618 00110$:
   0C2E 7A            [ 4]  619 	ld	a,d
   0C2F B7            [ 4]  620 	or	a, a
   0C30 28 3C         [12]  621 	jr	Z,00112$
                            622 ;src/Renderer.c:196: color= *(texture+(texture_line/256));
   0C32 DD 6E F3      [19]  623 	ld	l,-13 (ix)
   0C35 26 00         [ 7]  624 	ld	h,#0x00
   0C37 DD 7E F7      [19]  625 	ld	a,-9 (ix)
   0C3A 85            [ 4]  626 	add	a, l
   0C3B 6F            [ 4]  627 	ld	l,a
   0C3C DD 7E F8      [19]  628 	ld	a,-8 (ix)
   0C3F 8C            [ 4]  629 	adc	a, h
   0C40 67            [ 4]  630 	ld	h,a
   0C41 7E            [ 7]  631 	ld	a,(hl)
                            632 ;src/Renderer.c:198: if(color){
   0C42 DD 77 FC      [19]  633 	ld	-4 (ix), a
   0C45 B7            [ 4]  634 	or	a, a
   0C46 28 0B         [12]  635 	jr	Z,00104$
                            636 ;src/Renderer.c:199: val =  ((*pvmem)&(~pixMask));
   0C48 0A            [ 7]  637 	ld	a,(bc)
   0C49 A3            [ 4]  638 	and	a, e
   0C4A 6F            [ 4]  639 	ld	l,a
                            640 ;src/Renderer.c:201: color = (color&pixMask);
   0C4B DD 7E FC      [19]  641 	ld	a,-4 (ix)
   0C4E DD A6 F9      [19]  642 	and	a, -7 (ix)
                            643 ;src/Renderer.c:203: *pvmem = val|color;
   0C51 B5            [ 4]  644 	or	a, l
   0C52 02            [ 7]  645 	ld	(bc),a
   0C53                     646 00104$:
                            647 ;src/Renderer.c:206: texture_line += texture_line_add;
   0C53 DD 7E F2      [19]  648 	ld	a,-14 (ix)
   0C56 DD 86 F4      [19]  649 	add	a, -12 (ix)
   0C59 DD 77 F2      [19]  650 	ld	-14 (ix),a
   0C5C DD 7E F3      [19]  651 	ld	a,-13 (ix)
   0C5F DD 8E F5      [19]  652 	adc	a, -11 (ix)
   0C62 DD 77 F3      [19]  653 	ld	-13 (ix),a
                            654 ;src/Renderer.c:208: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   0C65 21 28 00      [10]  655 	ld	hl,#0x0028
   0C68 09            [11]  656 	add	hl,bc
   0C69 4D            [ 4]  657 	ld	c,l
   0C6A 44            [ 4]  658 	ld	b,h
                            659 ;src/Renderer.c:194: for(j;j;--j){
   0C6B 15            [ 4]  660 	dec	d
   0C6C 18 C0         [12]  661 	jr	00110$
   0C6E                     662 00112$:
   0C6E DD F9         [10]  663 	ld	sp, ix
   0C70 DD E1         [14]  664 	pop	ix
   0C72 C9            [10]  665 	ret
                            666 ;src/Renderer.c:214: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
                            667 ;	---------------------------------
                            668 ; Function draw_column_to_buffer
                            669 ; ---------------------------------
   0C73                     670 _draw_column_to_buffer::
   0C73 DD E5         [15]  671 	push	ix
   0C75 DD 21 00 00   [14]  672 	ld	ix,#0
   0C79 DD 39         [15]  673 	add	ix,sp
   0C7B 21 F1 FF      [10]  674 	ld	hl,#-15
   0C7E 39            [11]  675 	add	hl,sp
   0C7F F9            [ 6]  676 	ld	sp,hl
                            677 ;src/Renderer.c:215: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   0C80 DD 7E 04      [19]  678 	ld	a,4 (ix)
   0C83 CB 3F         [ 8]  679 	srl	a
   0C85 C6 00         [ 7]  680 	add	a, #0x00
   0C87 DD 77 FC      [19]  681 	ld	-4 (ix),a
   0C8A 3E 00         [ 7]  682 	ld	a,#0x00
   0C8C CE 8B         [ 7]  683 	adc	a, #0x8B
   0C8E DD 77 FD      [19]  684 	ld	-3 (ix),a
                            685 ;src/Renderer.c:218: u8 pixMask = g_pixelMask[column&1];
   0C91 01 B5 0A      [10]  686 	ld	bc,#_g_pixelMask+0
   0C94 DD 7E 04      [19]  687 	ld	a,4 (ix)
   0C97 E6 01         [ 7]  688 	and	a, #0x01
   0C99 6F            [ 4]  689 	ld	l, a
   0C9A 26 00         [ 7]  690 	ld	h,#0x00
   0C9C 09            [11]  691 	add	hl,bc
   0C9D 7E            [ 7]  692 	ld	a,(hl)
   0C9E DD 77 F7      [19]  693 	ld	-9 (ix),a
                            694 ;src/Renderer.c:223: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
   0CA1 DD 7E 06      [19]  695 	ld	a, 6 (ix)
   0CA4 87            [ 4]  696 	add	a, a
   0CA5 87            [ 4]  697 	add	a, a
   0CA6 47            [ 4]  698 	ld	b,a
   0CA7 0E 00         [ 7]  699 	ld	c,#0x00
   0CA9 21 00 64      [10]  700 	ld	hl,#0x6400
   0CAC 09            [11]  701 	add	hl,bc
   0CAD 4D            [ 4]  702 	ld	c,l
   0CAE 44            [ 4]  703 	ld	b,h
   0CAF DD 6E 07      [19]  704 	ld	l,7 (ix)
   0CB2 26 00         [ 7]  705 	ld	h,#0x00
   0CB4 29            [11]  706 	add	hl, hl
   0CB5 29            [11]  707 	add	hl, hl
   0CB6 29            [11]  708 	add	hl, hl
   0CB7 29            [11]  709 	add	hl, hl
   0CB8 29            [11]  710 	add	hl, hl
   0CB9 09            [11]  711 	add	hl,bc
   0CBA DD 75 F2      [19]  712 	ld	-14 (ix),l
   0CBD DD 74 F3      [19]  713 	ld	-13 (ix),h
                            714 ;src/Renderer.c:225: u8 j=lineHeight;
   0CC0 DD 7E 05      [19]  715 	ld	a,5 (ix)
                            716 ;src/Renderer.c:231: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
   0CC3 DD 77 F1      [19]  717 	ld	-15 (ix), a
   0CC6 DD 77 FA      [19]  718 	ld	-6 (ix),a
   0CC9 DD 36 FB 00   [19]  719 	ld	-5 (ix),#0x00
   0CCD DD 6E FA      [19]  720 	ld	l,-6 (ix)
   0CD0 DD 66 FB      [19]  721 	ld	h,-5 (ix)
   0CD3 E5            [11]  722 	push	hl
   0CD4 21 00 20      [10]  723 	ld	hl,#0x2000
   0CD7 E5            [11]  724 	push	hl
   0CD8 CD 1D 44      [17]  725 	call	__divsint
   0CDB F1            [10]  726 	pop	af
   0CDC F1            [10]  727 	pop	af
   0CDD DD 75 F8      [19]  728 	ld	-8 (ix),l
   0CE0 DD 74 F9      [19]  729 	ld	-7 (ix),h
                            730 ;src/Renderer.c:232: u16 wall_texture_line=0;
   0CE3 DD 36 F4 00   [19]  731 	ld	-12 (ix),#0x00
   0CE7 DD 36 F5 00   [19]  732 	ld	-11 (ix),#0x00
                            733 ;src/Renderer.c:234: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   0CEB DD 4E F1      [19]  734 	ld	c,-15 (ix)
   0CEE CB 39         [ 8]  735 	srl	c
   0CF0 3E 32         [ 7]  736 	ld	a,#0x32
   0CF2 91            [ 4]  737 	sub	a, c
   0CF3 DD 77 F6      [19]  738 	ld	-10 (ix),a
                            739 ;src/Renderer.c:238: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   0CF6 3E 64         [ 7]  740 	ld	a,#0x64
   0CF8 DD 96 F1      [19]  741 	sub	a, -15 (ix)
   0CFB 30 4B         [12]  742 	jr	NC,00102$
                            743 ;src/Renderer.c:239: ceiling_height=0;
   0CFD DD 36 F6 00   [19]  744 	ld	-10 (ix),#0x00
                            745 ;src/Renderer.c:240: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
   0D01 DD 7E FA      [19]  746 	ld	a,-6 (ix)
   0D04 C6 9C         [ 7]  747 	add	a,#0x9C
   0D06 4F            [ 4]  748 	ld	c,a
   0D07 DD 7E FB      [19]  749 	ld	a,-5 (ix)
   0D0A CE FF         [ 7]  750 	adc	a,#0xFF
   0D0C 47            [ 4]  751 	ld	b,a
   0D0D DD 71 FE      [19]  752 	ld	-2 (ix),c
   0D10 DD 70 FF      [19]  753 	ld	-1 (ix),b
   0D13 CB 78         [ 8]  754 	bit	7, b
   0D15 28 10         [12]  755 	jr	Z,00111$
   0D17 DD 7E FA      [19]  756 	ld	a,-6 (ix)
   0D1A C6 9D         [ 7]  757 	add	a, #0x9D
   0D1C DD 77 FE      [19]  758 	ld	-2 (ix),a
   0D1F DD 7E FB      [19]  759 	ld	a,-5 (ix)
   0D22 CE FF         [ 7]  760 	adc	a, #0xFF
   0D24 DD 77 FF      [19]  761 	ld	-1 (ix),a
   0D27                     762 00111$:
   0D27 DD 4E FE      [19]  763 	ld	c,-2 (ix)
   0D2A DD 46 FF      [19]  764 	ld	b,-1 (ix)
   0D2D CB 28         [ 8]  765 	sra	b
   0D2F CB 19         [ 8]  766 	rr	c
   0D31 DD 6E F8      [19]  767 	ld	l,-8 (ix)
   0D34 DD 66 F9      [19]  768 	ld	h,-7 (ix)
   0D37 E5            [11]  769 	push	hl
   0D38 C5            [11]  770 	push	bc
   0D39 CD BF 42      [17]  771 	call	__mulint
   0D3C F1            [10]  772 	pop	af
   0D3D F1            [10]  773 	pop	af
   0D3E DD 75 F4      [19]  774 	ld	-12 (ix),l
   0D41 DD 74 F5      [19]  775 	ld	-11 (ix),h
                            776 ;src/Renderer.c:241: j=SCREEN_TEXTURE_HEIGHT;
   0D44 DD 36 F1 64   [19]  777 	ld	-15 (ix),#0x64
   0D48                     778 00102$:
                            779 ;src/Renderer.c:244: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
   0D48 DD 4E F6      [19]  780 	ld	c,-10 (ix)
   0D4B 06 00         [ 7]  781 	ld	b,#0x00
   0D4D 69            [ 4]  782 	ld	l, c
   0D4E 60            [ 4]  783 	ld	h, b
   0D4F 29            [11]  784 	add	hl, hl
   0D50 29            [11]  785 	add	hl, hl
   0D51 09            [11]  786 	add	hl, bc
   0D52 29            [11]  787 	add	hl, hl
   0D53 29            [11]  788 	add	hl, hl
   0D54 29            [11]  789 	add	hl, hl
   0D55 DD 7E FC      [19]  790 	ld	a,-4 (ix)
   0D58 85            [ 4]  791 	add	a, l
   0D59 4F            [ 4]  792 	ld	c,a
   0D5A DD 7E FD      [19]  793 	ld	a,-3 (ix)
   0D5D 8C            [ 4]  794 	adc	a, h
   0D5E 47            [ 4]  795 	ld	b,a
                            796 ;src/Renderer.c:246: for(j;j;--j){
   0D5F DD 7E F7      [19]  797 	ld	a,-9 (ix)
   0D62 2F            [ 4]  798 	cpl
   0D63 DD 77 FE      [19]  799 	ld	-2 (ix),a
   0D66 DD 56 F1      [19]  800 	ld	d,-15 (ix)
   0D69                     801 00107$:
   0D69 7A            [ 4]  802 	ld	a,d
   0D6A B7            [ 4]  803 	or	a, a
   0D6B 28 39         [12]  804 	jr	Z,00109$
                            805 ;src/Renderer.c:248: w_color = *(texture+(wall_texture_line/256));
   0D6D DD 7E F5      [19]  806 	ld	a, -11 (ix)
   0D70 26 00         [ 7]  807 	ld	h, #0x00
   0D72 DD 86 F2      [19]  808 	add	a, -14 (ix)
   0D75 6F            [ 4]  809 	ld	l,a
   0D76 7C            [ 4]  810 	ld	a,h
   0D77 DD 8E F3      [19]  811 	adc	a, -13 (ix)
   0D7A 67            [ 4]  812 	ld	h,a
   0D7B 5E            [ 7]  813 	ld	e,(hl)
                            814 ;src/Renderer.c:250: if(w_color){
   0D7C 7B            [ 4]  815 	ld	a,e
   0D7D B7            [ 4]  816 	or	a, a
   0D7E 28 0B         [12]  817 	jr	Z,00104$
                            818 ;src/Renderer.c:252: val =  ((*pvmem)&(~pixMask));
   0D80 0A            [ 7]  819 	ld	a,(bc)
   0D81 DD A6 FE      [19]  820 	and	a, -2 (ix)
   0D84 6F            [ 4]  821 	ld	l,a
                            822 ;src/Renderer.c:254: w_color = (w_color&pixMask);
   0D85 7B            [ 4]  823 	ld	a,e
   0D86 DD A6 F7      [19]  824 	and	a, -9 (ix)
                            825 ;src/Renderer.c:256: *pvmem = val|w_color;
   0D89 B5            [ 4]  826 	or	a, l
   0D8A 02            [ 7]  827 	ld	(bc),a
   0D8B                     828 00104$:
                            829 ;src/Renderer.c:260: wall_texture_line += wall_texture_line_add;
   0D8B DD 7E F4      [19]  830 	ld	a,-12 (ix)
   0D8E DD 86 F8      [19]  831 	add	a, -8 (ix)
   0D91 DD 77 F4      [19]  832 	ld	-12 (ix),a
   0D94 DD 7E F5      [19]  833 	ld	a,-11 (ix)
   0D97 DD 8E F9      [19]  834 	adc	a, -7 (ix)
   0D9A DD 77 F5      [19]  835 	ld	-11 (ix),a
                            836 ;src/Renderer.c:262: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   0D9D 21 28 00      [10]  837 	ld	hl,#0x0028
   0DA0 09            [11]  838 	add	hl,bc
   0DA1 4D            [ 4]  839 	ld	c,l
   0DA2 44            [ 4]  840 	ld	b,h
                            841 ;src/Renderer.c:246: for(j;j;--j){
   0DA3 15            [ 4]  842 	dec	d
   0DA4 18 C3         [12]  843 	jr	00107$
   0DA6                     844 00109$:
   0DA6 DD F9         [10]  845 	ld	sp, ix
   0DA8 DD E1         [14]  846 	pop	ix
   0DAA C9            [10]  847 	ret
                            848 ;src/Renderer.c:266: void render_draw_to_buffer(){//TODO Optimize
                            849 ;	---------------------------------
                            850 ; Function render_draw_to_buffer
                            851 ; ---------------------------------
   0DAB                     852 _render_draw_to_buffer::
   0DAB DD E5         [15]  853 	push	ix
   0DAD DD 21 00 00   [14]  854 	ld	ix,#0
   0DB1 DD 39         [15]  855 	add	ix,sp
   0DB3 21 C6 FF      [10]  856 	ld	hl,#-58
   0DB6 39            [11]  857 	add	hl,sp
   0DB7 F9            [ 6]  858 	ld	sp,hl
                            859 ;src/Renderer.c:276: u8 zHeight = 5;
   0DB8 DD 36 CF 05   [19]  860 	ld	-49 (ix),#0x05
                            861 ;src/Renderer.c:282: u8 offsetDiff = 16;
   0DBC DD 36 C9 10   [19]  862 	ld	-55 (ix),#0x10
                            863 ;src/Renderer.c:287: u8 lineStart = 0;
   0DC0 DD 36 C7 00   [19]  864 	ld	-57 (ix),#0x00
                            865 ;src/Renderer.c:289: u8 lateralWallWidth=0;
   0DC4 DD 36 CA 00   [19]  866 	ld	-54 (ix),#0x00
                            867 ;src/Renderer.c:301: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   0DC8 21 AB 0A      [10]  868 	ld	hl, #_g_colors + 6
   0DCB 46            [ 7]  869 	ld	b,(hl)
   0DCC 21 A8 07      [10]  870 	ld	hl,#0x07A8
   0DCF E5            [11]  871 	push	hl
   0DD0 C5            [11]  872 	push	bc
   0DD1 33            [ 6]  873 	inc	sp
   0DD2 21 00 8B      [10]  874 	ld	hl,#0x8B00
   0DD5 E5            [11]  875 	push	hl
   0DD6 CD 26 43      [17]  876 	call	_cpct_memset
                            877 ;src/Renderer.c:302: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
   0DD9 21 A6 0A      [10]  878 	ld	hl, #_g_colors + 1
   0DDC 46            [ 7]  879 	ld	b,(hl)
   0DDD 21 50 00      [10]  880 	ld	hl,#0x0050
   0DE0 E5            [11]  881 	push	hl
   0DE1 C5            [11]  882 	push	bc
   0DE2 33            [ 6]  883 	inc	sp
   0DE3 21 A8 92      [10]  884 	ld	hl,#0x92A8
   0DE6 E5            [11]  885 	push	hl
   0DE7 CD 26 43      [17]  886 	call	_cpct_memset
                            887 ;src/Renderer.c:303: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   0DEA 21 AC 0A      [10]  888 	ld	hl, #_g_colors + 7
   0DED 46            [ 7]  889 	ld	b,(hl)
   0DEE 21 A8 07      [10]  890 	ld	hl,#0x07A8
   0DF1 E5            [11]  891 	push	hl
   0DF2 C5            [11]  892 	push	bc
   0DF3 33            [ 6]  893 	inc	sp
   0DF4 21 F8 92      [10]  894 	ld	hl,#0x92F8
   0DF7 E5            [11]  895 	push	hl
   0DF8 CD 26 43      [17]  896 	call	_cpct_memset
                            897 ;src/Renderer.c:305: calculate_cells_in_view();
   0DFB CD EB 08      [17]  898 	call	_calculate_cells_in_view
                            899 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   0DFE 2A B8 0A      [16]  900 	ld	hl,(_cells_in_view_array)
   0E01 DD 75 E4      [19]  901 	ld	-28 (ix),l
   0E04 DD 74 E5      [19]  902 	ld	-27 (ix),h
                            903 ;src/Renderer.c:307: if(g_texturedWalls){
   0E07 3A B7 0A      [13]  904 	ld	a,(#_g_texturedWalls + 0)
   0E0A B7            [ 4]  905 	or	a, a
   0E0B CA 53 13      [10]  906 	jp	Z,00358$
                            907 ;src/Renderer.c:309: do{
   0E0E DD 36 D2 06   [19]  908 	ld	-46 (ix),#0x06
   0E12                     909 00175$:
                            910 ;src/Renderer.c:311: --z;
   0E12 DD 35 D2      [23]  911 	dec	-46 (ix)
                            912 ;src/Renderer.c:315: xCellCount = (z) ? (zHeight >> 1) : 0;
   0E15 DD 7E CF      [19]  913 	ld	a,-49 (ix)
   0E18 CB 3F         [ 8]  914 	srl	a
   0E1A DD 77 E9      [19]  915 	ld	-23 (ix),a
   0E1D DD 7E D2      [19]  916 	ld	a,-46 (ix)
   0E20 B7            [ 4]  917 	or	a, a
   0E21 28 05         [12]  918 	jr	Z,00262$
   0E23 DD 4E E9      [19]  919 	ld	c,-23 (ix)
   0E26 18 02         [12]  920 	jr	00263$
   0E28                     921 00262$:
   0E28 0E 00         [ 7]  922 	ld	c,#0x00
   0E2A                     923 00263$:
   0E2A DD 71 EC      [19]  924 	ld	-20 (ix),c
                            925 ;src/Renderer.c:316: lateralWallSlope=0;
   0E2D DD 36 EF 00   [19]  926 	ld	-17 (ix),#0x00
                            927 ;src/Renderer.c:317: lateralWallSlopeCounter=0;
   0E31 DD 36 F7 00   [19]  928 	ld	-9 (ix),#0x00
                            929 ;src/Renderer.c:318: xHeight=0;
   0E35 DD 36 E3 00   [19]  930 	ld	-29 (ix),#0x00
                            931 ;src/Renderer.c:320: lateralWallCounter = 0;
   0E39 DD 36 D9 00   [19]  932 	ld	-39 (ix),#0x00
                            933 ;src/Renderer.c:322: newCell=1;
   0E3D DD 36 DA 01   [19]  934 	ld	-38 (ix),#0x01
                            935 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   0E41 DD 7E C7      [19]  936 	ld	a,-57 (ix)
   0E44 DD 77 DB      [19]  937 	ld	-37 (ix),a
   0E47 DD 36 DC 00   [19]  938 	ld	-36 (ix),#0x00
   0E4B DD 4E DB      [19]  939 	ld	c,-37 (ix)
   0E4E DD 46 DC      [19]  940 	ld	b,-36 (ix)
   0E51 03            [ 6]  941 	inc	bc
   0E52 DD 6E E4      [19]  942 	ld	l,-28 (ix)
   0E55 DD 66 E5      [19]  943 	ld	h,-27 (ix)
   0E58 09            [11]  944 	add	hl,bc
   0E59 7E            [ 7]  945 	ld	a,(hl)
   0E5A DD 77 D8      [19]  946 	ld	-40 (ix),a
                            947 ;src/Renderer.c:325: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   0E5D DD 7E E4      [19]  948 	ld	a,-28 (ix)
   0E60 DD 86 C7      [19]  949 	add	a, -57 (ix)
   0E63 6F            [ 4]  950 	ld	l,a
   0E64 DD 7E E5      [19]  951 	ld	a,-27 (ix)
   0E67 CE 00         [ 7]  952 	adc	a, #0x00
   0E69 67            [ 4]  953 	ld	h,a
   0E6A 4E            [ 7]  954 	ld	c,(hl)
                            955 ;src/Renderer.c:326: if(lastCellWasWall&CELL_WALL_MASK){
   0E6B CB 79         [ 8]  956 	bit	7, c
   0E6D 28 09         [12]  957 	jr	Z,00102$
                            958 ;src/Renderer.c:327: lastWallId=lastCellWasWall;
   0E6F DD 71 DE      [19]  959 	ld	-34 (ix),c
                            960 ;src/Renderer.c:328: lastCellWasWall=1;
   0E72 DD 36 D7 01   [19]  961 	ld	-41 (ix),#0x01
   0E76 18 08         [12]  962 	jr	00296$
   0E78                     963 00102$:
                            964 ;src/Renderer.c:331: lastCellWasWall=0;
   0E78 DD 36 D7 00   [19]  965 	ld	-41 (ix),#0x00
                            966 ;src/Renderer.c:332: lastWallId=CELLTYPE_FLOOR;
   0E7C DD 36 DE 00   [19]  967 	ld	-34 (ix),#0x00
                            968 ;src/Renderer.c:335: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   0E80                     969 00296$:
   0E80 DD 36 C6 00   [19]  970 	ld	-58 (ix),#0x00
   0E84 DD 36 D5 00   [19]  971 	ld	-43 (ix),#0x00
   0E88                     972 00252$:
                            973 ;src/Renderer.c:337: if (xCellCount == zHeight)
   0E88 DD 7E CF      [19]  974 	ld	a,-49 (ix)
   0E8B DD 96 EC      [19]  975 	sub	a, -20 (ix)
   0E8E 20 4B         [12]  976 	jr	NZ,00105$
                            977 ;src/Renderer.c:339: ++xCell;
   0E90 DD 34 C6      [23]  978 	inc	-58 (ix)
                            979 ;src/Renderer.c:340: xCellCount = 0;
   0E93 DD 36 EC 00   [19]  980 	ld	-20 (ix),#0x00
                            981 ;src/Renderer.c:341: newCell=1;
   0E97 DD 36 DA 01   [19]  982 	ld	-38 (ix),#0x01
                            983 ;src/Renderer.c:342: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   0E9B DD 7E C6      [19]  984 	ld	a,-58 (ix)
   0E9E DD 77 ED      [19]  985 	ld	-19 (ix),a
   0EA1 DD 36 EE 00   [19]  986 	ld	-18 (ix),#0x00
   0EA5 DD 7E DB      [19]  987 	ld	a,-37 (ix)
   0EA8 DD 86 ED      [19]  988 	add	a, -19 (ix)
   0EAB DD 77 ED      [19]  989 	ld	-19 (ix),a
   0EAE DD 7E DC      [19]  990 	ld	a,-36 (ix)
   0EB1 DD 8E EE      [19]  991 	adc	a, -18 (ix)
   0EB4 DD 77 EE      [19]  992 	ld	-18 (ix),a
   0EB7 DD 34 ED      [23]  993 	inc	-19 (ix)
   0EBA 20 03         [12]  994 	jr	NZ,00608$
   0EBC DD 34 EE      [23]  995 	inc	-18 (ix)
   0EBF                     996 00608$:
   0EBF DD 7E E4      [19]  997 	ld	a,-28 (ix)
   0EC2 DD 86 ED      [19]  998 	add	a, -19 (ix)
   0EC5 DD 77 ED      [19]  999 	ld	-19 (ix),a
   0EC8 DD 7E E5      [19] 1000 	ld	a,-27 (ix)
   0ECB DD 8E EE      [19] 1001 	adc	a, -18 (ix)
   0ECE DD 77 EE      [19] 1002 	ld	-18 (ix),a
   0ED1 DD 6E ED      [19] 1003 	ld	l,-19 (ix)
   0ED4 DD 66 EE      [19] 1004 	ld	h,-18 (ix)
   0ED7 7E            [ 7] 1005 	ld	a,(hl)
   0ED8 DD 77 D8      [19] 1006 	ld	-40 (ix),a
   0EDB                    1007 00105$:
                           1008 ;src/Renderer.c:344: if(!(x%2)){
   0EDB DD 7E D5      [19] 1009 	ld	a,-43 (ix)
   0EDE E6 01         [ 7] 1010 	and	a, #0x01
   0EE0 DD 77 ED      [19] 1011 	ld	-19 (ix),a
                           1012 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   0EE3 DD 7E D8      [19] 1013 	ld	a,-40 (ix)
   0EE6 E6 80         [ 7] 1014 	and	a, #0x80
   0EE8 DD 77 F4      [19] 1015 	ld	-12 (ix),a
                           1016 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   0EEB DD 7E EC      [19] 1017 	ld	a,-20 (ix)
   0EEE DD 77 FE      [19] 1018 	ld	-2 (ix),a
   0EF1 DD 36 FF 00   [19] 1019 	ld	-1 (ix),#0x00
   0EF5 DD 7E CF      [19] 1020 	ld	a,-49 (ix)
   0EF8 DD 77 DD      [19] 1021 	ld	-35 (ix),a
                           1022 ;src/Renderer.c:344: if(!(x%2)){
   0EFB DD 7E ED      [19] 1023 	ld	a,-19 (ix)
   0EFE B7            [ 4] 1024 	or	a, a
   0EFF C2 B2 0F      [10] 1025 	jp	NZ,00118$
                           1026 ;src/Renderer.c:345: if ((lateralWallCounter == 0)||newCell)
   0F02 DD 7E D9      [19] 1027 	ld	a,-39 (ix)
   0F05 B7            [ 4] 1028 	or	a, a
   0F06 28 07         [12] 1029 	jr	Z,00114$
   0F08 DD 7E DA      [19] 1030 	ld	a,-38 (ix)
   0F0B B7            [ 4] 1031 	or	a, a
   0F0C CA B2 0F      [10] 1032 	jp	Z,00118$
   0F0F                    1033 00114$:
                           1034 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   0F0F DD 7E F4      [19] 1035 	ld	a,-12 (ix)
   0F12 B7            [ 4] 1036 	or	a, a
   0F13 28 22         [12] 1037 	jr	Z,00112$
                           1038 ;src/Renderer.c:349: lateralWallCounter = 0;//(zHeight - xCellCount);
   0F15 DD 36 D9 00   [19] 1039 	ld	-39 (ix),#0x00
                           1040 ;src/Renderer.c:350: lateralWallSlope = 0;
   0F19 DD 36 EF 00   [19] 1041 	ld	-17 (ix),#0x00
                           1042 ;src/Renderer.c:351: xHeight = zHeight;
   0F1D DD 7E CF      [19] 1043 	ld	a,-49 (ix)
   0F20 DD 77 E3      [19] 1044 	ld	-29 (ix),a
                           1045 ;src/Renderer.c:352: color = currentCellID&0b01111111;
   0F23 DD 7E D8      [19] 1046 	ld	a,-40 (ix)
   0F26 E6 7F         [ 7] 1047 	and	a, #0x7F
   0F28 DD 77 E6      [19] 1048 	ld	-26 (ix),a
                           1049 ;src/Renderer.c:353: lastCellWasWall = 1;
   0F2B DD 36 D7 01   [19] 1050 	ld	-41 (ix),#0x01
                           1051 ;src/Renderer.c:354: lastWallId=currentCellID;
   0F2F DD 7E D8      [19] 1052 	ld	a,-40 (ix)
   0F32 DD 77 DE      [19] 1053 	ld	-34 (ix),a
   0F35 18 77         [12] 1054 	jr	00113$
   0F37                    1055 00112$:
                           1056 ;src/Renderer.c:357: if(lateralWallCounter==0){//Lateral wall not finished
   0F37 DD 7E D9      [19] 1057 	ld	a,-39 (ix)
   0F3A B7            [ 4] 1058 	or	a, a
   0F3B 20 71         [12] 1059 	jr	NZ,00113$
                           1060 ;src/Renderer.c:358: if (lastCellWasWall)
   0F3D DD 7E D7      [19] 1061 	ld	a,-41 (ix)
   0F40 B7            [ 4] 1062 	or	a, a
   0F41 28 5B         [12] 1063 	jr	Z,00107$
                           1064 ;src/Renderer.c:361: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   0F43 DD 7E C9      [19] 1065 	ld	a,-55 (ix)
   0F46 DD 96 C6      [19] 1066 	sub	a, -58 (ix)
   0F49 87            [ 4] 1067 	add	a, a
   0F4A 3C            [ 4] 1068 	inc	a
                           1069 ;src/Renderer.c:362: lateralWallSlopeCounter = lateralWallSlope / 2;
   0F4B DD 77 EF      [19] 1070 	ld	-17 (ix), a
   0F4E CB 3F         [ 8] 1071 	srl	a
   0F50 DD 77 F7      [19] 1072 	ld	-9 (ix),a
                           1073 ;src/Renderer.c:363: lateralWallCounter = lateralWallSlope * zHeight;
   0F53 DD 5E CF      [19] 1074 	ld	e,-49 (ix)
   0F56 DD 66 EF      [19] 1075 	ld	h,-17 (ix)
   0F59 2E 00         [ 7] 1076 	ld	l, #0x00
   0F5B 55            [ 4] 1077 	ld	d, l
   0F5C 06 08         [ 7] 1078 	ld	b, #0x08
   0F5E                    1079 00609$:
   0F5E 29            [11] 1080 	add	hl,hl
   0F5F 30 01         [12] 1081 	jr	NC,00610$
   0F61 19            [11] 1082 	add	hl,de
   0F62                    1083 00610$:
   0F62 10 FA         [13] 1084 	djnz	00609$
                           1085 ;src/Renderer.c:364: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   0F64 7D            [ 4] 1086 	ld	a,l
   0F65 E6 FC         [ 7] 1087 	and	a, #0xFC
   0F67 CB C7         [ 8] 1088 	set	0, a
   0F69 CB 3F         [ 8] 1089 	srl	a
   0F6B CB 3F         [ 8] 1090 	srl	a
   0F6D DD 96 EC      [19] 1091 	sub	a, -20 (ix)
                           1092 ;src/Renderer.c:365: lateralWallWidth=lateralWallCounter;
   0F70 DD 77 D9      [19] 1093 	ld	-39 (ix), a
   0F73 DD 77 CA      [19] 1094 	ld	-54 (ix),a
                           1095 ;src/Renderer.c:366: lastCellWasWall = 0;
   0F76 DD 36 D7 00   [19] 1096 	ld	-41 (ix),#0x00
                           1097 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   0F7A DD 6E FE      [19] 1098 	ld	l,-2 (ix)
   0F7D DD 66 FF      [19] 1099 	ld	h,-1 (ix)
   0F80 29            [11] 1100 	add	hl, hl
   0F81 DD 4E EF      [19] 1101 	ld	c,-17 (ix)
   0F84 06 00         [ 7] 1102 	ld	b,#0x00
   0F86 C5            [11] 1103 	push	bc
   0F87 E5            [11] 1104 	push	hl
   0F88 CD 1D 44      [17] 1105 	call	__divsint
   0F8B F1            [10] 1106 	pop	af
   0F8C F1            [10] 1107 	pop	af
   0F8D DD 7E DD      [19] 1108 	ld	a,-35 (ix)
   0F90 95            [ 4] 1109 	sub	a, l
   0F91 DD 77 E3      [19] 1110 	ld	-29 (ix),a
                           1111 ;src/Renderer.c:368: color = lastWallId&0b01111111;
   0F94 DD 7E DE      [19] 1112 	ld	a,-34 (ix)
   0F97 E6 7F         [ 7] 1113 	and	a, #0x7F
   0F99 DD 77 E6      [19] 1114 	ld	-26 (ix),a
   0F9C 18 10         [12] 1115 	jr	00113$
   0F9E                    1116 00107$:
                           1117 ;src/Renderer.c:372: xHeight = 0;
   0F9E DD 36 E3 00   [19] 1118 	ld	-29 (ix),#0x00
                           1119 ;src/Renderer.c:373: lastCellWasWall = 0;
   0FA2 DD 36 D7 00   [19] 1120 	ld	-41 (ix),#0x00
                           1121 ;src/Renderer.c:374: lateralWallSlope=0;
   0FA6 DD 36 EF 00   [19] 1122 	ld	-17 (ix),#0x00
                           1123 ;src/Renderer.c:375: lastWallId=0;
   0FAA DD 36 DE 00   [19] 1124 	ld	-34 (ix),#0x00
   0FAE                    1125 00113$:
                           1126 ;src/Renderer.c:379: newCell=0;
   0FAE DD 36 DA 00   [19] 1127 	ld	-38 (ix),#0x00
   0FB2                    1128 00118$:
                           1129 ;src/Renderer.c:382: if (lateralWallCounter > 0)
   0FB2 DD 7E D9      [19] 1130 	ld	a,-39 (ix)
   0FB5 B7            [ 4] 1131 	or	a, a
   0FB6 28 1E         [12] 1132 	jr	Z,00124$
                           1133 ;src/Renderer.c:385: if (lateralWallSlope != 0)
   0FB8 DD 7E EF      [19] 1134 	ld	a,-17 (ix)
   0FBB B7            [ 4] 1135 	or	a, a
   0FBC 28 15         [12] 1136 	jr	Z,00122$
                           1137 ;src/Renderer.c:387: if (lateralWallSlopeCounter == lateralWallSlope)
   0FBE DD 7E F7      [19] 1138 	ld	a,-9 (ix)
   0FC1 DD 96 EF      [19] 1139 	sub	a, -17 (ix)
   0FC4 20 0A         [12] 1140 	jr	NZ,00120$
                           1141 ;src/Renderer.c:389: lateralWallSlopeCounter = 0;
   0FC6 DD 36 F7 00   [19] 1142 	ld	-9 (ix),#0x00
                           1143 ;src/Renderer.c:390: xHeight -= 2;
   0FCA DD 35 E3      [23] 1144 	dec	-29 (ix)
   0FCD DD 35 E3      [23] 1145 	dec	-29 (ix)
   0FD0                    1146 00120$:
                           1147 ;src/Renderer.c:392: ++lateralWallSlopeCounter;
   0FD0 DD 34 F7      [23] 1148 	inc	-9 (ix)
   0FD3                    1149 00122$:
                           1150 ;src/Renderer.c:395: --lateralWallCounter;
   0FD3 DD 35 D9      [23] 1151 	dec	-39 (ix)
   0FD6                    1152 00124$:
                           1153 ;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   0FD6 DD 7E CF      [19] 1154 	ld	a,-49 (ix)
   0FD9 DD 77 E7      [19] 1155 	ld	-25 (ix),a
   0FDC DD 36 E8 00   [19] 1156 	ld	-24 (ix),#0x00
                           1157 ;src/Renderer.c:398: if (!(x%2))
   0FE0 DD 7E ED      [19] 1158 	ld	a,-19 (ix)
   0FE3 B7            [ 4] 1159 	or	a, a
   0FE4 C2 65 10      [10] 1160 	jp	NZ,00136$
                           1161 ;src/Renderer.c:408: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   0FE7 DD 46 D5      [19] 1162 	ld	b,-43 (ix)
   0FEA CB 38         [ 8] 1163 	srl	b
                           1164 ;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   0FEC DD 6E FE      [19] 1165 	ld	l,-2 (ix)
   0FEF DD 66 FF      [19] 1166 	ld	h,-1 (ix)
   0FF2 29            [11] 1167 	add	hl, hl
   0FF3 29            [11] 1168 	add	hl, hl
   0FF4 29            [11] 1169 	add	hl, hl
   0FF5 29            [11] 1170 	add	hl, hl
   0FF6 29            [11] 1171 	add	hl, hl
   0FF7 C5            [11] 1172 	push	bc
   0FF8 DD 5E E7      [19] 1173 	ld	e,-25 (ix)
   0FFB DD 56 E8      [19] 1174 	ld	d,-24 (ix)
   0FFE D5            [11] 1175 	push	de
   0FFF E5            [11] 1176 	push	hl
   1000 CD 1D 44      [17] 1177 	call	__divsint
   1003 F1            [10] 1178 	pop	af
   1004 F1            [10] 1179 	pop	af
   1005 C1            [10] 1180 	pop	bc
   1006 4D            [ 4] 1181 	ld	c,l
                           1182 ;src/Renderer.c:400: if(xHeight > 0){
   1007 DD 7E E3      [19] 1183 	ld	a,-29 (ix)
   100A B7            [ 4] 1184 	or	a, a
   100B 28 3A         [12] 1185 	jr	Z,00129$
                           1186 ;src/Renderer.c:401: if (lateralWallCounter > 0)
   100D DD 7E D9      [19] 1187 	ld	a,-39 (ix)
   1010 B7            [ 4] 1188 	or	a, a
   1011 28 21         [12] 1189 	jr	Z,00126$
                           1190 ;src/Renderer.c:403: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   1013 DD 5E CA      [19] 1191 	ld	e,-54 (ix)
   1016 16 00         [ 7] 1192 	ld	d,#0x00
   1018 DD 6E D9      [19] 1193 	ld	l,-39 (ix)
   101B 26 00         [ 7] 1194 	ld	h,#0x00
   101D 7B            [ 4] 1195 	ld	a,e
   101E 95            [ 4] 1196 	sub	a, l
   101F 6F            [ 4] 1197 	ld	l,a
   1020 7A            [ 4] 1198 	ld	a,d
   1021 9C            [ 4] 1199 	sbc	a, h
   1022 67            [ 4] 1200 	ld	h,a
   1023 29            [11] 1201 	add	hl, hl
   1024 29            [11] 1202 	add	hl, hl
   1025 29            [11] 1203 	add	hl, hl
   1026 29            [11] 1204 	add	hl, hl
   1027 29            [11] 1205 	add	hl, hl
   1028 C5            [11] 1206 	push	bc
   1029 D5            [11] 1207 	push	de
   102A E5            [11] 1208 	push	hl
   102B CD 1D 44      [17] 1209 	call	__divsint
   102E F1            [10] 1210 	pop	af
   102F F1            [10] 1211 	pop	af
   1030 C1            [10] 1212 	pop	bc
   1031 55            [ 4] 1213 	ld	d,l
   1032 18 01         [12] 1214 	jr	00127$
   1034                    1215 00126$:
                           1216 ;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   1034 51            [ 4] 1217 	ld	d,c
   1035                    1218 00127$:
                           1219 ;src/Renderer.c:408: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   1035 C5            [11] 1220 	push	bc
   1036 D5            [11] 1221 	push	de
   1037 33            [ 6] 1222 	inc	sp
   1038 DD 66 E6      [19] 1223 	ld	h,-26 (ix)
   103B DD 6E E3      [19] 1224 	ld	l,-29 (ix)
   103E E5            [11] 1225 	push	hl
   103F C5            [11] 1226 	push	bc
   1040 33            [ 6] 1227 	inc	sp
   1041 CD 73 0C      [17] 1228 	call	_draw_column_to_buffer
   1044 F1            [10] 1229 	pop	af
   1045 F1            [10] 1230 	pop	af
   1046 C1            [10] 1231 	pop	bc
   1047                    1232 00129$:
                           1233 ;src/Renderer.c:410: if(!(currentCellID&CELL_WALL_MASK)){
   1047 DD 7E F4      [19] 1234 	ld	a,-12 (ix)
   104A B7            [ 4] 1235 	or	a, a
   104B 20 18         [12] 1236 	jr	NZ,00136$
                           1237 ;src/Renderer.c:411: if(currentCellID&CELL_ENEMY_MASK){
   104D DD 7E D8      [19] 1238 	ld	a,-40 (ix)
   1050 E6 0F         [ 7] 1239 	and	a, #0x0F
   1052 28 11         [12] 1240 	jr	Z,00136$
                           1241 ;src/Renderer.c:412: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   1054 79            [ 4] 1242 	ld	a,c
   1055 F5            [11] 1243 	push	af
   1056 33            [ 6] 1244 	inc	sp
   1057 DD 66 D8      [19] 1245 	ld	h,-40 (ix)
   105A DD 6E CF      [19] 1246 	ld	l,-49 (ix)
   105D E5            [11] 1247 	push	hl
   105E C5            [11] 1248 	push	bc
   105F 33            [ 6] 1249 	inc	sp
   1060 CD 36 0B      [17] 1250 	call	_draw_column_to_buffer_enemy
   1063 F1            [10] 1251 	pop	af
   1064 F1            [10] 1252 	pop	af
                           1253 ;src/Renderer.c:414: else if(currentCellID&CELL_ITEM_MASK){
   1065                    1254 00136$:
                           1255 ;src/Renderer.c:420: ++xCellCount;
   1065 DD 34 EC      [23] 1256 	inc	-20 (ix)
                           1257 ;src/Renderer.c:335: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   1068 DD 34 D5      [23] 1258 	inc	-43 (ix)
                           1259 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   106B 2A B8 0A      [16] 1260 	ld	hl,(_cells_in_view_array)
   106E DD 75 E4      [19] 1261 	ld	-28 (ix),l
   1071 DD 74 E5      [19] 1262 	ld	-27 (ix),h
                           1263 ;src/Renderer.c:335: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   1074 DD 7E D5      [19] 1264 	ld	a,-43 (ix)
   1077 D6 50         [ 7] 1265 	sub	a, #0x50
   1079 DA 88 0E      [10] 1266 	jp	C,00252$
                           1267 ;src/Renderer.c:427: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   107C DD 7E D2      [19] 1268 	ld	a,-46 (ix)
   107F B7            [ 4] 1269 	or	a, a
   1080 28 05         [12] 1270 	jr	Z,00264$
   1082 DD 4E E9      [19] 1271 	ld	c,-23 (ix)
   1085 18 02         [12] 1272 	jr	00265$
   1087                    1273 00264$:
   1087 0E 00         [ 7] 1274 	ld	c,#0x00
   1089                    1275 00265$:
   1089 DD 71 FE      [19] 1276 	ld	-2 (ix),c
                           1277 ;src/Renderer.c:428: lateralWallSlope=0;
   108C DD 36 F4 00   [19] 1278 	ld	-12 (ix),#0x00
                           1279 ;src/Renderer.c:429: lateralWallSlopeCounter=0;
   1090 DD 36 ED 00   [19] 1280 	ld	-19 (ix),#0x00
                           1281 ;src/Renderer.c:430: xHeight=0;
   1094 DD 36 D7 00   [19] 1282 	ld	-41 (ix),#0x00
                           1283 ;src/Renderer.c:432: lateralWallCounter = 0;
   1098 DD 36 DE 00   [19] 1284 	ld	-34 (ix),#0x00
                           1285 ;src/Renderer.c:433: lineEnd = lineStart + offsetDiff * 2 + 2;
   109C DD 7E C9      [19] 1286 	ld	a,-55 (ix)
   109F 87            [ 4] 1287 	add	a, a
   10A0 4F            [ 4] 1288 	ld	c,a
   10A1 DD 7E C7      [19] 1289 	ld	a,-57 (ix)
   10A4 81            [ 4] 1290 	add	a, c
   10A5 DD 77 D8      [19] 1291 	ld	-40 (ix), a
   10A8 4F            [ 4] 1292 	ld	c, a
   10A9 0C            [ 4] 1293 	inc	c
   10AA 0C            [ 4] 1294 	inc	c
                           1295 ;src/Renderer.c:435: newCell=1;
   10AB DD 36 DB 01   [19] 1296 	ld	-37 (ix),#0x01
                           1297 ;src/Renderer.c:436: currentCellID = cells_in_view_array[lineEnd - 1];
   10AF DD 71 EA      [19] 1298 	ld	-22 (ix),c
   10B2 DD 36 EB 00   [19] 1299 	ld	-21 (ix),#0x00
   10B6 DD 5E EA      [19] 1300 	ld	e,-22 (ix)
   10B9 DD 56 EB      [19] 1301 	ld	d,-21 (ix)
   10BC 1B            [ 6] 1302 	dec	de
   10BD DD 6E E4      [19] 1303 	ld	l,-28 (ix)
   10C0 DD 66 E5      [19] 1304 	ld	h,-27 (ix)
   10C3 19            [11] 1305 	add	hl,de
   10C4 7E            [ 7] 1306 	ld	a,(hl)
   10C5 DD 77 DA      [19] 1307 	ld	-38 (ix),a
                           1308 ;src/Renderer.c:438: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   10C8 DD 6E E4      [19] 1309 	ld	l,-28 (ix)
   10CB DD 66 E5      [19] 1310 	ld	h,-27 (ix)
   10CE 06 00         [ 7] 1311 	ld	b,#0x00
   10D0 09            [11] 1312 	add	hl, bc
   10D1 4E            [ 7] 1313 	ld	c,(hl)
                           1314 ;src/Renderer.c:439: if(lastCellWasWall&CELL_WALL_MASK){
   10D2 CB 79         [ 8] 1315 	bit	7, c
   10D4 28 09         [12] 1316 	jr	Z,00139$
                           1317 ;src/Renderer.c:440: lastWallId=lastCellWasWall;
   10D6 DD 71 D9      [19] 1318 	ld	-39 (ix),c
                           1319 ;src/Renderer.c:441: lastCellWasWall=1;
   10D9 DD 36 E3 01   [19] 1320 	ld	-29 (ix),#0x01
   10DD 18 08         [12] 1321 	jr	00315$
   10DF                    1322 00139$:
                           1323 ;src/Renderer.c:444: lastCellWasWall=0;
   10DF DD 36 E3 00   [19] 1324 	ld	-29 (ix),#0x00
                           1325 ;src/Renderer.c:445: lastWallId=CELLTYPE_FLOOR;
   10E3 DD 36 D9 00   [19] 1326 	ld	-39 (ix),#0x00
                           1327 ;src/Renderer.c:448: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   10E7                    1328 00315$:
   10E7 DD 36 C6 00   [19] 1329 	ld	-58 (ix),#0x00
   10EB DD 36 D5 9F   [19] 1330 	ld	-43 (ix),#0x9F
   10EF                    1331 00254$:
                           1332 ;src/Renderer.c:451: if (xCellCount == zHeight)
   10EF DD 7E CF      [19] 1333 	ld	a,-49 (ix)
   10F2 DD 96 FE      [19] 1334 	sub	a, -2 (ix)
   10F5 20 50         [12] 1335 	jr	NZ,00142$
                           1336 ;src/Renderer.c:453: ++xCell;
   10F7 DD 34 C6      [23] 1337 	inc	-58 (ix)
                           1338 ;src/Renderer.c:454: xCellCount = 0;
   10FA DD 36 FE 00   [19] 1339 	ld	-2 (ix),#0x00
                           1340 ;src/Renderer.c:455: newCell=1;
   10FE DD 36 DB 01   [19] 1341 	ld	-37 (ix),#0x01
                           1342 ;src/Renderer.c:456: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   1102 DD 7E C6      [19] 1343 	ld	a,-58 (ix)
   1105 DD 77 F0      [19] 1344 	ld	-16 (ix),a
   1108 DD 36 F1 00   [19] 1345 	ld	-15 (ix),#0x00
   110C DD 7E EA      [19] 1346 	ld	a,-22 (ix)
   110F DD 96 F0      [19] 1347 	sub	a, -16 (ix)
   1112 DD 77 F0      [19] 1348 	ld	-16 (ix),a
   1115 DD 7E EB      [19] 1349 	ld	a,-21 (ix)
   1118 DD 9E F1      [19] 1350 	sbc	a, -15 (ix)
   111B DD 77 F1      [19] 1351 	ld	-15 (ix),a
   111E DD 6E F0      [19] 1352 	ld	l,-16 (ix)
   1121 DD 66 F1      [19] 1353 	ld	h,-15 (ix)
   1124 2B            [ 6] 1354 	dec	hl
   1125 DD 75 F0      [19] 1355 	ld	-16 (ix),l
   1128 DD 74 F1      [19] 1356 	ld	-15 (ix),h
   112B DD 7E E4      [19] 1357 	ld	a,-28 (ix)
   112E DD 86 F0      [19] 1358 	add	a, -16 (ix)
   1131 DD 77 F0      [19] 1359 	ld	-16 (ix),a
   1134 DD 7E E5      [19] 1360 	ld	a,-27 (ix)
   1137 DD 8E F1      [19] 1361 	adc	a, -15 (ix)
   113A DD 77 F1      [19] 1362 	ld	-15 (ix),a
   113D DD 6E F0      [19] 1363 	ld	l,-16 (ix)
   1140 DD 66 F1      [19] 1364 	ld	h,-15 (ix)
   1143 7E            [ 7] 1365 	ld	a,(hl)
   1144 DD 77 DA      [19] 1366 	ld	-38 (ix),a
   1147                    1367 00142$:
                           1368 ;src/Renderer.c:458: if(!(x%2)){
   1147 DD 7E D5      [19] 1369 	ld	a,-43 (ix)
   114A E6 01         [ 7] 1370 	and	a, #0x01
   114C DD 77 F0      [19] 1371 	ld	-16 (ix),a
                           1372 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   114F DD 7E DA      [19] 1373 	ld	a,-38 (ix)
   1152 E6 80         [ 7] 1374 	and	a, #0x80
   1154 DD 77 F7      [19] 1375 	ld	-9 (ix),a
                           1376 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   1157 DD 7E FE      [19] 1377 	ld	a,-2 (ix)
   115A DD 77 F2      [19] 1378 	ld	-14 (ix),a
   115D DD 36 F3 00   [19] 1379 	ld	-13 (ix),#0x00
                           1380 ;src/Renderer.c:458: if(!(x%2)){
   1161 DD 7E F0      [19] 1381 	ld	a,-16 (ix)
   1164 B7            [ 4] 1382 	or	a, a
   1165 C2 37 12      [10] 1383 	jp	NZ,00155$
                           1384 ;src/Renderer.c:459: if (lateralWallCounter == 0 || newCell)
   1168 DD 7E DE      [19] 1385 	ld	a,-34 (ix)
   116B B7            [ 4] 1386 	or	a, a
   116C 28 07         [12] 1387 	jr	Z,00151$
   116E DD 7E DB      [19] 1388 	ld	a,-37 (ix)
   1171 B7            [ 4] 1389 	or	a, a
   1172 CA 37 12      [10] 1390 	jp	Z,00155$
   1175                    1391 00151$:
                           1392 ;src/Renderer.c:461: if ( currentCellID & CELL_WALL_MASK)//Wall
   1175 DD 7E F7      [19] 1393 	ld	a,-9 (ix)
   1178 B7            [ 4] 1394 	or	a, a
   1179 28 23         [12] 1395 	jr	Z,00149$
                           1396 ;src/Renderer.c:463: lateralWallCounter = 0;
   117B DD 36 DE 00   [19] 1397 	ld	-34 (ix),#0x00
                           1398 ;src/Renderer.c:464: lateralWallSlope = 0;
   117F DD 36 F4 00   [19] 1399 	ld	-12 (ix),#0x00
                           1400 ;src/Renderer.c:465: xHeight = zHeight;
   1183 DD 7E CF      [19] 1401 	ld	a,-49 (ix)
   1186 DD 77 D7      [19] 1402 	ld	-41 (ix),a
                           1403 ;src/Renderer.c:466: color = currentCellID&0b01111111;
   1189 DD 7E DA      [19] 1404 	ld	a,-38 (ix)
   118C E6 7F         [ 7] 1405 	and	a, #0x7F
   118E DD 77 E6      [19] 1406 	ld	-26 (ix),a
                           1407 ;src/Renderer.c:467: lastCellWasWall = 1;
   1191 DD 36 E3 01   [19] 1408 	ld	-29 (ix),#0x01
                           1409 ;src/Renderer.c:468: lastWallId=currentCellID;
   1195 DD 7E DA      [19] 1410 	ld	a,-38 (ix)
   1198 DD 77 D9      [19] 1411 	ld	-39 (ix),a
   119B C3 33 12      [10] 1412 	jp	00150$
   119E                    1413 00149$:
                           1414 ;src/Renderer.c:470: else if(lateralWallCounter==0){
   119E DD 7E DE      [19] 1415 	ld	a,-34 (ix)
   11A1 B7            [ 4] 1416 	or	a, a
   11A2 C2 33 12      [10] 1417 	jp	NZ,00150$
                           1418 ;src/Renderer.c:471: if (lastCellWasWall)
   11A5 DD 7E E3      [19] 1419 	ld	a,-29 (ix)
   11A8 B7            [ 4] 1420 	or	a, a
   11A9 28 78         [12] 1421 	jr	Z,00144$
                           1422 ;src/Renderer.c:474: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   11AB DD 7E C9      [19] 1423 	ld	a,-55 (ix)
   11AE DD 96 C6      [19] 1424 	sub	a, -58 (ix)
   11B1 87            [ 4] 1425 	add	a, a
   11B2 3C            [ 4] 1426 	inc	a
                           1427 ;src/Renderer.c:475: lateralWallSlopeCounter = lateralWallSlope / 2;
   11B3 DD 77 F4      [19] 1428 	ld	-12 (ix), a
   11B6 CB 3F         [ 8] 1429 	srl	a
   11B8 DD 77 ED      [19] 1430 	ld	-19 (ix),a
                           1431 ;src/Renderer.c:476: lateralWallCounter = lateralWallSlope * zHeight;
   11BB DD 5E CF      [19] 1432 	ld	e,-49 (ix)
   11BE DD 66 F4      [19] 1433 	ld	h,-12 (ix)
   11C1 2E 00         [ 7] 1434 	ld	l, #0x00
   11C3 55            [ 4] 1435 	ld	d, l
   11C4 06 08         [ 7] 1436 	ld	b, #0x08
   11C6                    1437 00617$:
   11C6 29            [11] 1438 	add	hl,hl
   11C7 30 01         [12] 1439 	jr	NC,00618$
   11C9 19            [11] 1440 	add	hl,de
   11CA                    1441 00618$:
   11CA 10 FA         [13] 1442 	djnz	00617$
                           1443 ;src/Renderer.c:477: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   11CC 4D            [ 4] 1444 	ld	c,l
   11CD 06 00         [ 7] 1445 	ld	b,#0x00
   11CF 7D            [ 4] 1446 	ld	a,l
   11D0 E6 03         [ 7] 1447 	and	a, #0x03
   11D2 5F            [ 4] 1448 	ld	e,a
   11D3 16 00         [ 7] 1449 	ld	d,#0x00
   11D5 79            [ 4] 1450 	ld	a,c
   11D6 93            [ 4] 1451 	sub	a, e
   11D7 4F            [ 4] 1452 	ld	c,a
   11D8 78            [ 4] 1453 	ld	a,b
   11D9 9A            [ 4] 1454 	sbc	a, d
   11DA 47            [ 4] 1455 	ld	b,a
   11DB 59            [ 4] 1456 	ld	e, c
   11DC 50            [ 4] 1457 	ld	d, b
   11DD 13            [ 6] 1458 	inc	de
   11DE 6B            [ 4] 1459 	ld	l, e
   11DF 62            [ 4] 1460 	ld	h, d
   11E0 CB 7A         [ 8] 1461 	bit	7, d
   11E2 28 04         [12] 1462 	jr	Z,00266$
   11E4 21 04 00      [10] 1463 	ld	hl,#0x0004
   11E7 09            [11] 1464 	add	hl,bc
   11E8                    1465 00266$:
   11E8 CB 2C         [ 8] 1466 	sra	h
   11EA CB 1D         [ 8] 1467 	rr	l
   11EC CB 2C         [ 8] 1468 	sra	h
   11EE CB 1D         [ 8] 1469 	rr	l
   11F0 DD 4E FE      [19] 1470 	ld	c,-2 (ix)
   11F3 7D            [ 4] 1471 	ld	a,l
   11F4 91            [ 4] 1472 	sub	a, c
                           1473 ;src/Renderer.c:478: lateralWallWidth=lateralWallCounter;
   11F5 DD 77 DE      [19] 1474 	ld	-34 (ix), a
   11F8 DD 77 CA      [19] 1475 	ld	-54 (ix),a
                           1476 ;src/Renderer.c:479: lastCellWasWall = 0;
   11FB DD 36 E3 00   [19] 1477 	ld	-29 (ix),#0x00
                           1478 ;src/Renderer.c:480: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   11FF DD 6E F2      [19] 1479 	ld	l,-14 (ix)
   1202 DD 66 F3      [19] 1480 	ld	h,-13 (ix)
   1205 29            [11] 1481 	add	hl, hl
   1206 DD 4E F4      [19] 1482 	ld	c,-12 (ix)
   1209 06 00         [ 7] 1483 	ld	b,#0x00
   120B C5            [11] 1484 	push	bc
   120C E5            [11] 1485 	push	hl
   120D CD 1D 44      [17] 1486 	call	__divsint
   1210 F1            [10] 1487 	pop	af
   1211 F1            [10] 1488 	pop	af
   1212 DD 7E DD      [19] 1489 	ld	a,-35 (ix)
   1215 95            [ 4] 1490 	sub	a, l
   1216 DD 77 D7      [19] 1491 	ld	-41 (ix),a
                           1492 ;src/Renderer.c:481: color = lastWallId&0b01111111;
   1219 DD 7E D9      [19] 1493 	ld	a,-39 (ix)
   121C E6 7F         [ 7] 1494 	and	a, #0x7F
   121E DD 77 E6      [19] 1495 	ld	-26 (ix),a
   1221 18 10         [12] 1496 	jr	00150$
   1223                    1497 00144$:
                           1498 ;src/Renderer.c:485: xHeight = 0;
   1223 DD 36 D7 00   [19] 1499 	ld	-41 (ix),#0x00
                           1500 ;src/Renderer.c:486: lastCellWasWall = 0;
   1227 DD 36 E3 00   [19] 1501 	ld	-29 (ix),#0x00
                           1502 ;src/Renderer.c:487: lateralWallSlope=0;
   122B DD 36 F4 00   [19] 1503 	ld	-12 (ix),#0x00
                           1504 ;src/Renderer.c:488: lastWallId=0;
   122F DD 36 D9 00   [19] 1505 	ld	-39 (ix),#0x00
   1233                    1506 00150$:
                           1507 ;src/Renderer.c:491: newCell=0;
   1233 DD 36 DB 00   [19] 1508 	ld	-37 (ix),#0x00
   1237                    1509 00155$:
                           1510 ;src/Renderer.c:496: if (lateralWallCounter > 0)
   1237 DD 7E DE      [19] 1511 	ld	a,-34 (ix)
   123A B7            [ 4] 1512 	or	a, a
   123B 28 1E         [12] 1513 	jr	Z,00161$
                           1514 ;src/Renderer.c:499: if (lateralWallSlope != 0)
   123D DD 7E F4      [19] 1515 	ld	a,-12 (ix)
   1240 B7            [ 4] 1516 	or	a, a
   1241 28 15         [12] 1517 	jr	Z,00159$
                           1518 ;src/Renderer.c:501: if (lateralWallSlopeCounter == lateralWallSlope)
   1243 DD 7E F4      [19] 1519 	ld	a,-12 (ix)
   1246 DD 96 ED      [19] 1520 	sub	a, -19 (ix)
   1249 20 0A         [12] 1521 	jr	NZ,00157$
                           1522 ;src/Renderer.c:503: lateralWallSlopeCounter = 0;
   124B DD 36 ED 00   [19] 1523 	ld	-19 (ix),#0x00
                           1524 ;src/Renderer.c:504: xHeight -= 2;
   124F DD 35 D7      [23] 1525 	dec	-41 (ix)
   1252 DD 35 D7      [23] 1526 	dec	-41 (ix)
   1255                    1527 00157$:
                           1528 ;src/Renderer.c:506: ++lateralWallSlopeCounter;
   1255 DD 34 ED      [23] 1529 	inc	-19 (ix)
   1258                    1530 00159$:
                           1531 ;src/Renderer.c:508: --lateralWallCounter;
   1258 DD 35 DE      [23] 1532 	dec	-34 (ix)
   125B                    1533 00161$:
                           1534 ;src/Renderer.c:512: if (!(x%2))
   125B DD 7E F0      [19] 1535 	ld	a,-16 (ix)
   125E B7            [ 4] 1536 	or	a, a
   125F C2 22 13      [10] 1537 	jp	NZ,00173$
                           1538 ;src/Renderer.c:525: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   1262 DD 7E D5      [19] 1539 	ld	a,-43 (ix)
   1265 CB 3F         [ 8] 1540 	srl	a
   1267 DD 77 F0      [19] 1541 	ld	-16 (ix),a
                           1542 ;src/Renderer.c:522: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   126A DD 7E E7      [19] 1543 	ld	a,-25 (ix)
   126D DD 96 F2      [19] 1544 	sub	a, -14 (ix)
   1270 DD 77 F2      [19] 1545 	ld	-14 (ix),a
   1273 DD 7E E8      [19] 1546 	ld	a,-24 (ix)
   1276 DD 9E F3      [19] 1547 	sbc	a, -13 (ix)
   1279 DD 77 F3      [19] 1548 	ld	-13 (ix),a
   127C 3E 06         [ 7] 1549 	ld	a,#0x05+1
   127E 18 08         [12] 1550 	jr	00622$
   1280                    1551 00621$:
   1280 DD CB F2 26   [23] 1552 	sla	-14 (ix)
   1284 DD CB F3 16   [23] 1553 	rl	-13 (ix)
   1288                    1554 00622$:
   1288 3D            [ 4] 1555 	dec	a
   1289 20 F5         [12] 1556 	jr	NZ,00621$
   128B DD 6E E7      [19] 1557 	ld	l,-25 (ix)
   128E DD 66 E8      [19] 1558 	ld	h,-24 (ix)
   1291 E5            [11] 1559 	push	hl
   1292 DD 6E F2      [19] 1560 	ld	l,-14 (ix)
   1295 DD 66 F3      [19] 1561 	ld	h,-13 (ix)
   1298 E5            [11] 1562 	push	hl
   1299 CD 1D 44      [17] 1563 	call	__divsint
   129C F1            [10] 1564 	pop	af
   129D F1            [10] 1565 	pop	af
   129E DD 74 F3      [19] 1566 	ld	-13 (ix),h
   12A1 DD 75 F2      [19] 1567 	ld	-14 (ix), l
   12A4 DD 75 F2      [19] 1568 	ld	-14 (ix), l
                           1569 ;src/Renderer.c:515: if(xHeight > 0){
   12A7 DD 7E D7      [19] 1570 	ld	a,-41 (ix)
   12AA B7            [ 4] 1571 	or	a, a
   12AB 28 55         [12] 1572 	jr	Z,00166$
                           1573 ;src/Renderer.c:517: if (lateralWallCounter > 0)
   12AD DD 7E DE      [19] 1574 	ld	a,-34 (ix)
   12B0 B7            [ 4] 1575 	or	a, a
   12B1 28 39         [12] 1576 	jr	Z,00163$
                           1577 ;src/Renderer.c:519: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   12B3 DD 7E DE      [19] 1578 	ld	a,-34 (ix)
   12B6 DD 77 F5      [19] 1579 	ld	-11 (ix),a
   12B9 DD 36 F6 00   [19] 1580 	ld	-10 (ix),#0x00
   12BD 3E 06         [ 7] 1581 	ld	a,#0x05+1
   12BF 18 08         [12] 1582 	jr	00624$
   12C1                    1583 00623$:
   12C1 DD CB F5 26   [23] 1584 	sla	-11 (ix)
   12C5 DD CB F6 16   [23] 1585 	rl	-10 (ix)
   12C9                    1586 00624$:
   12C9 3D            [ 4] 1587 	dec	a
   12CA 20 F5         [12] 1588 	jr	NZ,00623$
   12CC DD 7E CA      [19] 1589 	ld	a,-54 (ix)
   12CF DD 77 F8      [19] 1590 	ld	-8 (ix),a
   12D2 DD 36 F9 00   [19] 1591 	ld	-7 (ix),#0x00
   12D6 DD 6E F8      [19] 1592 	ld	l,-8 (ix)
   12D9 DD 66 F9      [19] 1593 	ld	h,-7 (ix)
   12DC E5            [11] 1594 	push	hl
   12DD DD 6E F5      [19] 1595 	ld	l,-11 (ix)
   12E0 DD 66 F6      [19] 1596 	ld	h,-10 (ix)
   12E3 E5            [11] 1597 	push	hl
   12E4 CD 1D 44      [17] 1598 	call	__divsint
   12E7 F1            [10] 1599 	pop	af
   12E8 F1            [10] 1600 	pop	af
   12E9 45            [ 4] 1601 	ld	b,l
   12EA 18 03         [12] 1602 	jr	00164$
   12EC                    1603 00163$:
                           1604 ;src/Renderer.c:522: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   12EC DD 46 F2      [19] 1605 	ld	b,-14 (ix)
   12EF                    1606 00164$:
                           1607 ;src/Renderer.c:525: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   12EF C5            [11] 1608 	push	bc
   12F0 33            [ 6] 1609 	inc	sp
   12F1 DD 66 E6      [19] 1610 	ld	h,-26 (ix)
   12F4 DD 6E D7      [19] 1611 	ld	l,-41 (ix)
   12F7 E5            [11] 1612 	push	hl
   12F8 DD 7E F0      [19] 1613 	ld	a,-16 (ix)
   12FB F5            [11] 1614 	push	af
   12FC 33            [ 6] 1615 	inc	sp
   12FD CD 73 0C      [17] 1616 	call	_draw_column_to_buffer
   1300 F1            [10] 1617 	pop	af
   1301 F1            [10] 1618 	pop	af
   1302                    1619 00166$:
                           1620 ;src/Renderer.c:528: if(!(currentCellID&CELL_WALL_MASK)){
   1302 DD 7E F7      [19] 1621 	ld	a,-9 (ix)
   1305 B7            [ 4] 1622 	or	a, a
   1306 20 1A         [12] 1623 	jr	NZ,00173$
                           1624 ;src/Renderer.c:529: if(currentCellID&CELL_ENEMY_MASK){
   1308 DD 7E DA      [19] 1625 	ld	a,-38 (ix)
   130B E6 0F         [ 7] 1626 	and	a, #0x0F
   130D 28 13         [12] 1627 	jr	Z,00173$
                           1628 ;src/Renderer.c:530: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   130F DD 66 F2      [19] 1629 	ld	h,-14 (ix)
   1312 DD 6E DA      [19] 1630 	ld	l,-38 (ix)
   1315 E5            [11] 1631 	push	hl
   1316 DD 66 CF      [19] 1632 	ld	h,-49 (ix)
   1319 DD 6E F0      [19] 1633 	ld	l,-16 (ix)
   131C E5            [11] 1634 	push	hl
   131D CD 36 0B      [17] 1635 	call	_draw_column_to_buffer_enemy
   1320 F1            [10] 1636 	pop	af
   1321 F1            [10] 1637 	pop	af
                           1638 ;src/Renderer.c:532: else if(currentCellID&CELL_ITEM_MASK){
   1322                    1639 00173$:
                           1640 ;src/Renderer.c:537: ++xCellCount;
   1322 DD 34 FE      [23] 1641 	inc	-2 (ix)
                           1642 ;src/Renderer.c:448: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   1325 DD 35 D5      [23] 1643 	dec	-43 (ix)
                           1644 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   1328 2A B8 0A      [16] 1645 	ld	hl,(_cells_in_view_array)
   132B DD 75 E4      [19] 1646 	ld	-28 (ix),l
   132E DD 74 E5      [19] 1647 	ld	-27 (ix),h
                           1648 ;src/Renderer.c:448: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   1331 DD 7E D5      [19] 1649 	ld	a,-43 (ix)
   1334 D6 50         [ 7] 1650 	sub	a, #0x50
   1336 D2 EF 10      [10] 1651 	jp	NC,00254$
                           1652 ;src/Renderer.c:544: lineStart = lineStart + (offsetDiff * 2) + 3;
   1339 DD 7E D8      [19] 1653 	ld	a,-40 (ix)
   133C C6 03         [ 7] 1654 	add	a, #0x03
   133E DD 77 C7      [19] 1655 	ld	-57 (ix),a
                           1656 ;src/Renderer.c:545: zHeight += zHeight;
   1341 DD CB CF 26   [23] 1657 	sla	-49 (ix)
                           1658 ;src/Renderer.c:546: offsetDiff = offsetDiff >> 1;
   1345 DD CB C9 3E   [23] 1659 	srl	-55 (ix)
                           1660 ;src/Renderer.c:548: }while(z);
   1349 DD 7E D2      [19] 1661 	ld	a,-46 (ix)
   134C B7            [ 4] 1662 	or	a, a
   134D C2 12 0E      [10] 1663 	jp	NZ,00175$
   1350 C3 00 19      [10] 1664 	jp	00260$
                           1665 ;src/Renderer.c:553: do{
   1353                    1666 00358$:
   1353 DD 36 D2 06   [19] 1667 	ld	-46 (ix),#0x06
   1357                    1668 00246$:
                           1669 ;src/Renderer.c:555: --z;
   1357 DD 35 D2      [23] 1670 	dec	-46 (ix)
                           1671 ;src/Renderer.c:315: xCellCount = (z) ? (zHeight >> 1) : 0;
   135A DD 7E CF      [19] 1672 	ld	a,-49 (ix)
   135D CB 3F         [ 8] 1673 	srl	a
   135F DD 77 F8      [19] 1674 	ld	-8 (ix),a
                           1675 ;src/Renderer.c:559: xCellCount = (z) ? (zHeight >> 1) : 0;
   1362 DD 7E D2      [19] 1676 	ld	a,-46 (ix)
   1365 B7            [ 4] 1677 	or	a, a
   1366 28 05         [12] 1678 	jr	Z,00267$
   1368 DD 4E F8      [19] 1679 	ld	c,-8 (ix)
   136B 18 02         [12] 1680 	jr	00268$
   136D                    1681 00267$:
   136D 0E 00         [ 7] 1682 	ld	c,#0x00
   136F                    1683 00268$:
   136F DD 71 CD      [19] 1684 	ld	-51 (ix),c
                           1685 ;src/Renderer.c:560: lateralWallSlope=0;
   1372 DD 36 CB 00   [19] 1686 	ld	-53 (ix),#0x00
                           1687 ;src/Renderer.c:561: lateralWallSlopeCounter=0;
   1376 DD 36 C8 00   [19] 1688 	ld	-56 (ix),#0x00
                           1689 ;src/Renderer.c:562: xHeight=0;
   137A DD 36 CE 00   [19] 1690 	ld	-50 (ix),#0x00
                           1691 ;src/Renderer.c:564: lateralWallCounter = 0;
   137E DD 36 F5 00   [19] 1692 	ld	-11 (ix),#0x00
                           1693 ;src/Renderer.c:566: newCell=1;
   1382 DD 36 D3 01   [19] 1694 	ld	-45 (ix),#0x01
                           1695 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   1386 DD 7E C7      [19] 1696 	ld	a,-57 (ix)
   1389 DD 77 F2      [19] 1697 	ld	-14 (ix),a
   138C DD 36 F3 00   [19] 1698 	ld	-13 (ix),#0x00
                           1699 ;src/Renderer.c:567: currentCellID = cells_in_view_array[lineStart + 1];
   1390 DD 4E F2      [19] 1700 	ld	c,-14 (ix)
   1393 DD 46 F3      [19] 1701 	ld	b,-13 (ix)
   1396 03            [ 6] 1702 	inc	bc
   1397 DD 6E E4      [19] 1703 	ld	l,-28 (ix)
   139A DD 66 E5      [19] 1704 	ld	h,-27 (ix)
   139D 09            [11] 1705 	add	hl,bc
   139E 7E            [ 7] 1706 	ld	a,(hl)
   139F DD 77 D1      [19] 1707 	ld	-47 (ix),a
                           1708 ;src/Renderer.c:569: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   13A2 DD 7E E4      [19] 1709 	ld	a,-28 (ix)
   13A5 DD 86 C7      [19] 1710 	add	a, -57 (ix)
   13A8 6F            [ 4] 1711 	ld	l,a
   13A9 DD 7E E5      [19] 1712 	ld	a,-27 (ix)
   13AC CE 00         [ 7] 1713 	adc	a, #0x00
   13AE 67            [ 4] 1714 	ld	h,a
   13AF 4E            [ 7] 1715 	ld	c,(hl)
                           1716 ;src/Renderer.c:570: if(lastCellWasWall&CELL_WALL_MASK){
   13B0 CB 79         [ 8] 1717 	bit	7, c
   13B2 28 09         [12] 1718 	jr	Z,00179$
                           1719 ;src/Renderer.c:571: lastWallId=lastCellWasWall;
   13B4 DD 71 CC      [19] 1720 	ld	-52 (ix),c
                           1721 ;src/Renderer.c:572: lastCellWasWall=1;
   13B7 DD 36 F0 01   [19] 1722 	ld	-16 (ix),#0x01
   13BB 18 08         [12] 1723 	jr	00336$
   13BD                    1724 00179$:
                           1725 ;src/Renderer.c:575: lastCellWasWall=0;
   13BD DD 36 F0 00   [19] 1726 	ld	-16 (ix),#0x00
                           1727 ;src/Renderer.c:576: lastWallId=CELLTYPE_FLOOR;
   13C1 DD 36 CC 00   [19] 1728 	ld	-52 (ix),#0x00
                           1729 ;src/Renderer.c:579: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   13C5                    1730 00336$:
   13C5 DD 36 C6 00   [19] 1731 	ld	-58 (ix),#0x00
   13C9 DD 36 D5 00   [19] 1732 	ld	-43 (ix),#0x00
   13CD                    1733 00256$:
                           1734 ;src/Renderer.c:581: if (xCellCount == zHeight)
   13CD DD 7E CD      [19] 1735 	ld	a,-51 (ix)
   13D0 DD 96 CF      [19] 1736 	sub	a, -49 (ix)
   13D3 20 4B         [12] 1737 	jr	NZ,00182$
                           1738 ;src/Renderer.c:583: ++xCell;
   13D5 DD 34 C6      [23] 1739 	inc	-58 (ix)
                           1740 ;src/Renderer.c:584: xCellCount = 0;
   13D8 DD 36 CD 00   [19] 1741 	ld	-51 (ix),#0x00
                           1742 ;src/Renderer.c:585: newCell=1;
   13DC DD 36 D3 01   [19] 1743 	ld	-45 (ix),#0x01
                           1744 ;src/Renderer.c:586: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   13E0 DD 7E C6      [19] 1745 	ld	a,-58 (ix)
   13E3 DD 77 EA      [19] 1746 	ld	-22 (ix),a
   13E6 DD 36 EB 00   [19] 1747 	ld	-21 (ix),#0x00
   13EA DD 7E F2      [19] 1748 	ld	a,-14 (ix)
   13ED DD 86 EA      [19] 1749 	add	a, -22 (ix)
   13F0 DD 77 EA      [19] 1750 	ld	-22 (ix),a
   13F3 DD 7E F3      [19] 1751 	ld	a,-13 (ix)
   13F6 DD 8E EB      [19] 1752 	adc	a, -21 (ix)
   13F9 DD 77 EB      [19] 1753 	ld	-21 (ix),a
   13FC DD 34 EA      [23] 1754 	inc	-22 (ix)
   13FF 20 03         [12] 1755 	jr	NZ,00629$
   1401 DD 34 EB      [23] 1756 	inc	-21 (ix)
   1404                    1757 00629$:
   1404 DD 7E EA      [19] 1758 	ld	a,-22 (ix)
   1407 DD 86 E4      [19] 1759 	add	a, -28 (ix)
   140A DD 77 EA      [19] 1760 	ld	-22 (ix),a
   140D DD 7E EB      [19] 1761 	ld	a,-21 (ix)
   1410 DD 8E E5      [19] 1762 	adc	a, -27 (ix)
   1413 DD 77 EB      [19] 1763 	ld	-21 (ix),a
   1416 DD 6E EA      [19] 1764 	ld	l,-22 (ix)
   1419 DD 66 EB      [19] 1765 	ld	h,-21 (ix)
   141C 7E            [ 7] 1766 	ld	a,(hl)
   141D DD 77 D1      [19] 1767 	ld	-47 (ix),a
   1420                    1768 00182$:
                           1769 ;src/Renderer.c:588: if(!(x%2)){
   1420 DD 7E D5      [19] 1770 	ld	a,-43 (ix)
   1423 E6 01         [ 7] 1771 	and	a, #0x01
   1425 DD 77 EA      [19] 1772 	ld	-22 (ix),a
                           1773 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   1428 DD 7E D1      [19] 1774 	ld	a,-47 (ix)
   142B E6 80         [ 7] 1775 	and	a, #0x80
   142D DD 77 E7      [19] 1776 	ld	-25 (ix),a
                           1777 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   1430 DD 7E CD      [19] 1778 	ld	a,-51 (ix)
   1433 DD 77 FE      [19] 1779 	ld	-2 (ix),a
   1436 DD 36 FF 00   [19] 1780 	ld	-1 (ix),#0x00
   143A DD 7E CF      [19] 1781 	ld	a,-49 (ix)
   143D DD 77 E6      [19] 1782 	ld	-26 (ix),a
                           1783 ;src/Renderer.c:588: if(!(x%2)){
   1440 DD 7E EA      [19] 1784 	ld	a,-22 (ix)
   1443 B7            [ 4] 1785 	or	a, a
   1444 C2 3C 15      [10] 1786 	jp	NZ,00195$
                           1787 ;src/Renderer.c:589: if ((lateralWallCounter == 0)||newCell)
   1447 DD 7E F5      [19] 1788 	ld	a,-11 (ix)
   144A B7            [ 4] 1789 	or	a, a
   144B 28 07         [12] 1790 	jr	Z,00191$
   144D DD 7E D3      [19] 1791 	ld	a,-45 (ix)
   1450 B7            [ 4] 1792 	or	a, a
   1451 CA 3C 15      [10] 1793 	jp	Z,00195$
   1454                    1794 00191$:
                           1795 ;src/Renderer.c:591: if (currentCellID & CELL_WALL_MASK)//Wall
   1454 DD 7E E7      [19] 1796 	ld	a,-25 (ix)
   1457 B7            [ 4] 1797 	or	a, a
   1458 28 2B         [12] 1798 	jr	Z,00189$
                           1799 ;src/Renderer.c:593: lateralWallCounter = 0;//(zHeight - xCellCount);
   145A DD 36 F5 00   [19] 1800 	ld	-11 (ix),#0x00
                           1801 ;src/Renderer.c:594: lateralWallSlope = 0;
   145E DD 36 CB 00   [19] 1802 	ld	-53 (ix),#0x00
                           1803 ;src/Renderer.c:595: xHeight = zHeight;
   1462 DD 7E CF      [19] 1804 	ld	a,-49 (ix)
   1465 DD 77 CE      [19] 1805 	ld	-50 (ix),a
                           1806 ;src/Renderer.c:596: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   1468 DD 7E D1      [19] 1807 	ld	a,-47 (ix)
   146B D6 80         [ 7] 1808 	sub	a, #0x80
   146D 20 04         [12] 1809 	jr	NZ,00269$
   146F 0E 0C         [ 7] 1810 	ld	c,#0x0C
   1471 18 02         [12] 1811 	jr	00270$
   1473                    1812 00269$:
   1473 0E 0E         [ 7] 1813 	ld	c,#0x0E
   1475                    1814 00270$:
   1475 DD 71 D6      [19] 1815 	ld	-42 (ix),c
                           1816 ;src/Renderer.c:597: lastCellWasWall = 1;
   1478 DD 36 F0 01   [19] 1817 	ld	-16 (ix),#0x01
                           1818 ;src/Renderer.c:598: lastWallId=currentCellID;
   147C DD 7E D1      [19] 1819 	ld	a,-47 (ix)
   147F DD 77 CC      [19] 1820 	ld	-52 (ix),a
   1482 C3 38 15      [10] 1821 	jp	00190$
   1485                    1822 00189$:
                           1823 ;src/Renderer.c:601: if(lateralWallCounter==0){//Lateral wall not finished
   1485 DD 7E F5      [19] 1824 	ld	a,-11 (ix)
   1488 B7            [ 4] 1825 	or	a, a
   1489 C2 38 15      [10] 1826 	jp	NZ,00190$
                           1827 ;src/Renderer.c:602: if (lastCellWasWall)
   148C DD 7E F0      [19] 1828 	ld	a,-16 (ix)
   148F B7            [ 4] 1829 	or	a, a
   1490 CA 28 15      [10] 1830 	jp	Z,00184$
                           1831 ;src/Renderer.c:605: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   1493 DD 7E C9      [19] 1832 	ld	a,-55 (ix)
   1496 DD 96 C6      [19] 1833 	sub	a, -58 (ix)
   1499 87            [ 4] 1834 	add	a, a
   149A 3C            [ 4] 1835 	inc	a
                           1836 ;src/Renderer.c:606: lateralWallSlopeCounter = lateralWallSlope / 2;
   149B DD 77 CB      [19] 1837 	ld	-53 (ix), a
   149E CB 3F         [ 8] 1838 	srl	a
   14A0 DD 77 C8      [19] 1839 	ld	-56 (ix),a
                           1840 ;src/Renderer.c:607: lateralWallCounter = lateralWallSlope * zHeight;
   14A3 DD 5E CF      [19] 1841 	ld	e,-49 (ix)
   14A6 DD 66 CB      [19] 1842 	ld	h,-53 (ix)
   14A9 2E 00         [ 7] 1843 	ld	l, #0x00
   14AB 55            [ 4] 1844 	ld	d, l
   14AC 06 08         [ 7] 1845 	ld	b, #0x08
   14AE                    1846 00632$:
   14AE 29            [11] 1847 	add	hl,hl
   14AF 30 01         [12] 1848 	jr	NC,00633$
   14B1 19            [11] 1849 	add	hl,de
   14B2                    1850 00633$:
   14B2 10 FA         [13] 1851 	djnz	00632$
   14B4 DD 75 DD      [19] 1852 	ld	-35 (ix), l
   14B7 7D            [ 4] 1853 	ld	a, l
                           1854 ;src/Renderer.c:608: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   14B8 DD 77 D0      [19] 1855 	ld	-48 (ix), a
   14BB E6 FC         [ 7] 1856 	and	a, #0xFC
   14BD DD 77 DD      [19] 1857 	ld	-35 (ix), a
   14C0 CB C7         [ 8] 1858 	set	0, a
   14C2 DD 77 DD      [19] 1859 	ld	-35 (ix), a
   14C5 CB 3F         [ 8] 1860 	srl	a
   14C7 CB 3F         [ 8] 1861 	srl	a
   14C9 DD 96 CD      [19] 1862 	sub	a, -51 (ix)
   14CC DD 77 F5      [19] 1863 	ld	-11 (ix),a
                           1864 ;src/Renderer.c:610: lastCellWasWall = 0;
   14CF DD 36 F0 00   [19] 1865 	ld	-16 (ix),#0x00
                           1866 ;src/Renderer.c:611: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   14D3 DD 7E FE      [19] 1867 	ld	a,-2 (ix)
   14D6 DD 77 ED      [19] 1868 	ld	-19 (ix),a
   14D9 DD 7E FF      [19] 1869 	ld	a,-1 (ix)
   14DC DD 77 EE      [19] 1870 	ld	-18 (ix),a
   14DF DD CB ED 26   [23] 1871 	sla	-19 (ix)
   14E3 DD CB EE 16   [23] 1872 	rl	-18 (ix)
   14E7 DD 7E CB      [19] 1873 	ld	a,-53 (ix)
   14EA DD 77 DB      [19] 1874 	ld	-37 (ix),a
   14ED DD 36 DC 00   [19] 1875 	ld	-36 (ix),#0x00
   14F1 DD 6E DB      [19] 1876 	ld	l,-37 (ix)
   14F4 DD 66 DC      [19] 1877 	ld	h,-36 (ix)
   14F7 E5            [11] 1878 	push	hl
   14F8 DD 6E ED      [19] 1879 	ld	l,-19 (ix)
   14FB DD 66 EE      [19] 1880 	ld	h,-18 (ix)
   14FE E5            [11] 1881 	push	hl
   14FF CD 1D 44      [17] 1882 	call	__divsint
   1502 F1            [10] 1883 	pop	af
   1503 F1            [10] 1884 	pop	af
   1504 DD 74 EE      [19] 1885 	ld	-18 (ix),h
   1507 DD 75 ED      [19] 1886 	ld	-19 (ix), l
   150A DD 75 DD      [19] 1887 	ld	-35 (ix), l
   150D DD 7E E6      [19] 1888 	ld	a,-26 (ix)
   1510 DD 96 DD      [19] 1889 	sub	a, -35 (ix)
   1513 DD 77 CE      [19] 1890 	ld	-50 (ix),a
                           1891 ;src/Renderer.c:612: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   1516 DD 7E CC      [19] 1892 	ld	a,-52 (ix)
   1519 D6 80         [ 7] 1893 	sub	a, #0x80
   151B 20 04         [12] 1894 	jr	NZ,00271$
   151D 0E 0F         [ 7] 1895 	ld	c,#0x0F
   151F 18 02         [12] 1896 	jr	00272$
   1521                    1897 00271$:
   1521 0E 0D         [ 7] 1898 	ld	c,#0x0D
   1523                    1899 00272$:
   1523 DD 71 D6      [19] 1900 	ld	-42 (ix),c
   1526 18 10         [12] 1901 	jr	00190$
   1528                    1902 00184$:
                           1903 ;src/Renderer.c:616: xHeight = 0;
   1528 DD 36 CE 00   [19] 1904 	ld	-50 (ix),#0x00
                           1905 ;src/Renderer.c:617: lastCellWasWall = 0;
   152C DD 36 F0 00   [19] 1906 	ld	-16 (ix),#0x00
                           1907 ;src/Renderer.c:618: lateralWallSlope=0;
   1530 DD 36 CB 00   [19] 1908 	ld	-53 (ix),#0x00
                           1909 ;src/Renderer.c:619: lastWallId=0;
   1534 DD 36 CC 00   [19] 1910 	ld	-52 (ix),#0x00
   1538                    1911 00190$:
                           1912 ;src/Renderer.c:623: newCell=0;
   1538 DD 36 D3 00   [19] 1913 	ld	-45 (ix),#0x00
   153C                    1914 00195$:
                           1915 ;src/Renderer.c:626: if (lateralWallCounter > 0)
   153C DD 7E F5      [19] 1916 	ld	a,-11 (ix)
   153F B7            [ 4] 1917 	or	a, a
   1540 28 1E         [12] 1918 	jr	Z,00201$
                           1919 ;src/Renderer.c:629: if (lateralWallSlope != 0)
   1542 DD 7E CB      [19] 1920 	ld	a,-53 (ix)
   1545 B7            [ 4] 1921 	or	a, a
   1546 28 15         [12] 1922 	jr	Z,00199$
                           1923 ;src/Renderer.c:631: if (lateralWallSlopeCounter == lateralWallSlope)
   1548 DD 7E CB      [19] 1924 	ld	a,-53 (ix)
   154B DD 96 C8      [19] 1925 	sub	a, -56 (ix)
   154E 20 0A         [12] 1926 	jr	NZ,00197$
                           1927 ;src/Renderer.c:633: lateralWallSlopeCounter = 0;
   1550 DD 36 C8 00   [19] 1928 	ld	-56 (ix),#0x00
                           1929 ;src/Renderer.c:634: xHeight -= 2;
   1554 DD 35 CE      [23] 1930 	dec	-50 (ix)
   1557 DD 35 CE      [23] 1931 	dec	-50 (ix)
   155A                    1932 00197$:
                           1933 ;src/Renderer.c:636: ++lateralWallSlopeCounter;
   155A DD 34 C8      [23] 1934 	inc	-56 (ix)
   155D                    1935 00199$:
                           1936 ;src/Renderer.c:639: --lateralWallCounter;
   155D DD 35 F5      [23] 1937 	dec	-11 (ix)
   1560                    1938 00201$:
                           1939 ;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   1560 DD 7E CF      [19] 1940 	ld	a,-49 (ix)
   1563 DD 77 ED      [19] 1941 	ld	-19 (ix),a
   1566 DD 36 EE 00   [19] 1942 	ld	-18 (ix),#0x00
                           1943 ;src/Renderer.c:642: if (!(x%2))
   156A DD 7E EA      [19] 1944 	ld	a,-22 (ix)
   156D B7            [ 4] 1945 	or	a, a
   156E 20 74         [12] 1946 	jr	NZ,00210$
                           1947 ;src/Renderer.c:645: draw_column_to_buffer_untextured(x/2, xHeight, color);
   1570 DD 7E D5      [19] 1948 	ld	a,-43 (ix)
   1573 CB 3F         [ 8] 1949 	srl	a
   1575 DD 77 EA      [19] 1950 	ld	-22 (ix),a
                           1951 ;src/Renderer.c:644: if(xHeight > 0){
   1578 DD 7E CE      [19] 1952 	ld	a,-50 (ix)
   157B B7            [ 4] 1953 	or	a, a
   157C 28 11         [12] 1954 	jr	Z,00203$
                           1955 ;src/Renderer.c:645: draw_column_to_buffer_untextured(x/2, xHeight, color);
   157E DD 66 D6      [19] 1956 	ld	h,-42 (ix)
   1581 DD 6E CE      [19] 1957 	ld	l,-50 (ix)
   1584 E5            [11] 1958 	push	hl
   1585 DD 7E EA      [19] 1959 	ld	a,-22 (ix)
   1588 F5            [11] 1960 	push	af
   1589 33            [ 6] 1961 	inc	sp
   158A CD BF 0A      [17] 1962 	call	_draw_column_to_buffer_untextured
   158D F1            [10] 1963 	pop	af
   158E 33            [ 6] 1964 	inc	sp
   158F                    1965 00203$:
                           1966 ;src/Renderer.c:648: if(!(currentCellID&CELL_WALL_MASK)){
   158F DD 7E E7      [19] 1967 	ld	a,-25 (ix)
   1592 B7            [ 4] 1968 	or	a, a
   1593 20 4F         [12] 1969 	jr	NZ,00210$
                           1970 ;src/Renderer.c:649: if(currentCellID&CELL_ENEMY_MASK){
   1595 DD 7E D1      [19] 1971 	ld	a,-47 (ix)
   1598 E6 0F         [ 7] 1972 	and	a, #0x0F
   159A 28 48         [12] 1973 	jr	Z,00210$
                           1974 ;src/Renderer.c:650: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   159C DD 7E FE      [19] 1975 	ld	a,-2 (ix)
   159F DD 77 E7      [19] 1976 	ld	-25 (ix),a
   15A2 DD 7E FF      [19] 1977 	ld	a,-1 (ix)
   15A5 DD 77 E8      [19] 1978 	ld	-24 (ix),a
   15A8 3E 06         [ 7] 1979 	ld	a,#0x05+1
   15AA 18 08         [12] 1980 	jr	00642$
   15AC                    1981 00641$:
   15AC DD CB E7 26   [23] 1982 	sla	-25 (ix)
   15B0 DD CB E8 16   [23] 1983 	rl	-24 (ix)
   15B4                    1984 00642$:
   15B4 3D            [ 4] 1985 	dec	a
   15B5 20 F5         [12] 1986 	jr	NZ,00641$
   15B7 DD 6E ED      [19] 1987 	ld	l,-19 (ix)
   15BA DD 66 EE      [19] 1988 	ld	h,-18 (ix)
   15BD E5            [11] 1989 	push	hl
   15BE DD 6E E7      [19] 1990 	ld	l,-25 (ix)
   15C1 DD 66 E8      [19] 1991 	ld	h,-24 (ix)
   15C4 E5            [11] 1992 	push	hl
   15C5 CD 1D 44      [17] 1993 	call	__divsint
   15C8 F1            [10] 1994 	pop	af
   15C9 F1            [10] 1995 	pop	af
   15CA DD 74 E8      [19] 1996 	ld	-24 (ix),h
   15CD DD 75 E7      [19] 1997 	ld	-25 (ix), l
   15D0 45            [ 4] 1998 	ld	b, l
   15D1 C5            [11] 1999 	push	bc
   15D2 33            [ 6] 2000 	inc	sp
   15D3 DD 66 D1      [19] 2001 	ld	h,-47 (ix)
   15D6 DD 6E CF      [19] 2002 	ld	l,-49 (ix)
   15D9 E5            [11] 2003 	push	hl
   15DA DD 7E EA      [19] 2004 	ld	a,-22 (ix)
   15DD F5            [11] 2005 	push	af
   15DE 33            [ 6] 2006 	inc	sp
   15DF CD 36 0B      [17] 2007 	call	_draw_column_to_buffer_enemy
   15E2 F1            [10] 2008 	pop	af
   15E3 F1            [10] 2009 	pop	af
                           2010 ;src/Renderer.c:652: else if(currentCellID&CELL_ITEM_MASK){
   15E4                    2011 00210$:
                           2012 ;src/Renderer.c:658: ++xCellCount;
   15E4 DD 34 CD      [23] 2013 	inc	-51 (ix)
                           2014 ;src/Renderer.c:579: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   15E7 DD 34 D5      [23] 2015 	inc	-43 (ix)
                           2016 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   15EA 2A B8 0A      [16] 2017 	ld	hl,(_cells_in_view_array)
   15ED DD 75 E4      [19] 2018 	ld	-28 (ix),l
   15F0 DD 74 E5      [19] 2019 	ld	-27 (ix),h
                           2020 ;src/Renderer.c:579: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   15F3 DD 7E D5      [19] 2021 	ld	a,-43 (ix)
   15F6 D6 50         [ 7] 2022 	sub	a, #0x50
   15F8 DA CD 13      [10] 2023 	jp	C,00256$
                           2024 ;src/Renderer.c:665: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   15FB DD 7E D2      [19] 2025 	ld	a,-46 (ix)
   15FE B7            [ 4] 2026 	or	a, a
   15FF 28 08         [12] 2027 	jr	Z,00273$
   1601 DD 7E F8      [19] 2028 	ld	a,-8 (ix)
   1604 DD 77 F8      [19] 2029 	ld	-8 (ix),a
   1607 18 04         [12] 2030 	jr	00274$
   1609                    2031 00273$:
   1609 DD 36 F8 00   [19] 2032 	ld	-8 (ix),#0x00
   160D                    2033 00274$:
   160D DD 7E F8      [19] 2034 	ld	a,-8 (ix)
   1610 DD 77 F8      [19] 2035 	ld	-8 (ix),a
                           2036 ;src/Renderer.c:666: lateralWallSlope=0;
   1613 DD 36 F5 00   [19] 2037 	ld	-11 (ix),#0x00
                           2038 ;src/Renderer.c:667: lateralWallSlopeCounter=0;
   1617 DD 36 F2 00   [19] 2039 	ld	-14 (ix),#0x00
                           2040 ;src/Renderer.c:668: xHeight=0;
   161B DD 36 F0 00   [19] 2041 	ld	-16 (ix),#0x00
                           2042 ;src/Renderer.c:670: lateralWallCounter = 0;
   161F DD 36 EA 00   [19] 2043 	ld	-22 (ix),#0x00
                           2044 ;src/Renderer.c:433: lineEnd = lineStart + offsetDiff * 2 + 2;
   1623 DD 7E C9      [19] 2045 	ld	a,-55 (ix)
   1626 87            [ 4] 2046 	add	a, a
   1627 DD 77 E7      [19] 2047 	ld	-25 (ix),a
   162A DD 7E C7      [19] 2048 	ld	a,-57 (ix)
   162D DD 86 E7      [19] 2049 	add	a, -25 (ix)
                           2050 ;src/Renderer.c:671: lineEnd = lineStart + offsetDiff * 2 + 2;
   1630 DD 77 E7      [19] 2051 	ld	-25 (ix), a
   1633 C6 02         [ 7] 2052 	add	a, #0x02
   1635 DD 77 D4      [19] 2053 	ld	-44 (ix),a
                           2054 ;src/Renderer.c:673: newCell=1;
   1638 DD 36 DD 01   [19] 2055 	ld	-35 (ix),#0x01
                           2056 ;src/Renderer.c:436: currentCellID = cells_in_view_array[lineEnd - 1];
   163C DD 7E D4      [19] 2057 	ld	a,-44 (ix)
   163F DD 77 FE      [19] 2058 	ld	-2 (ix),a
   1642 DD 36 FF 00   [19] 2059 	ld	-1 (ix),#0x00
                           2060 ;src/Renderer.c:674: currentCellID = cells_in_view_array[lineEnd - 1];
   1646 DD 7E FE      [19] 2061 	ld	a,-2 (ix)
   1649 C6 FF         [ 7] 2062 	add	a,#0xFF
   164B DD 77 DB      [19] 2063 	ld	-37 (ix),a
   164E DD 7E FF      [19] 2064 	ld	a,-1 (ix)
   1651 CE FF         [ 7] 2065 	adc	a,#0xFF
   1653 DD 77 DC      [19] 2066 	ld	-36 (ix),a
   1656 DD 7E E4      [19] 2067 	ld	a,-28 (ix)
   1659 DD 86 DB      [19] 2068 	add	a, -37 (ix)
   165C DD 77 DB      [19] 2069 	ld	-37 (ix),a
   165F DD 7E E5      [19] 2070 	ld	a,-27 (ix)
   1662 DD 8E DC      [19] 2071 	adc	a, -36 (ix)
   1665 DD 77 DC      [19] 2072 	ld	-36 (ix),a
   1668 DD 6E DB      [19] 2073 	ld	l,-37 (ix)
   166B DD 66 DC      [19] 2074 	ld	h,-36 (ix)
   166E 7E            [ 7] 2075 	ld	a,(hl)
   166F DD 77 F4      [19] 2076 	ld	-12 (ix),a
                           2077 ;src/Renderer.c:676: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   1672 DD 7E E4      [19] 2078 	ld	a,-28 (ix)
   1675 DD 86 D4      [19] 2079 	add	a, -44 (ix)
   1678 DD 77 DB      [19] 2080 	ld	-37 (ix),a
   167B DD 7E E5      [19] 2081 	ld	a,-27 (ix)
   167E CE 00         [ 7] 2082 	adc	a, #0x00
   1680 DD 77 DC      [19] 2083 	ld	-36 (ix),a
   1683 DD 6E DB      [19] 2084 	ld	l,-37 (ix)
   1686 DD 66 DC      [19] 2085 	ld	h,-36 (ix)
   1689 7E            [ 7] 2086 	ld	a,(hl)
   168A DD 77 D7      [19] 2087 	ld	-41 (ix),a
                           2088 ;src/Renderer.c:677: if(lastCellWasWall&CELL_WALL_MASK){
   168D DD CB D7 7E   [20] 2089 	bit	7, -41 (ix)
   1691 28 06         [12] 2090 	jr	Z,00213$
                           2091 ;src/Renderer.c:678: lastWallId=lastCellWasWall;
                           2092 ;src/Renderer.c:679: lastCellWasWall=1;
   1693 DD 36 DE 01   [19] 2093 	ld	-34 (ix),#0x01
   1697 18 08         [12] 2094 	jr	00356$
   1699                    2095 00213$:
                           2096 ;src/Renderer.c:682: lastCellWasWall=0;
   1699 DD 36 DE 00   [19] 2097 	ld	-34 (ix),#0x00
                           2098 ;src/Renderer.c:683: lastWallId=CELLTYPE_FLOOR;
   169D DD 36 D7 00   [19] 2099 	ld	-41 (ix),#0x00
                           2100 ;src/Renderer.c:686: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   16A1                    2101 00356$:
   16A1 DD 36 C6 00   [19] 2102 	ld	-58 (ix),#0x00
   16A5 DD 36 D5 9F   [19] 2103 	ld	-43 (ix),#0x9F
   16A9                    2104 00258$:
                           2105 ;src/Renderer.c:689: if (xCellCount == zHeight)
   16A9 DD 7E CF      [19] 2106 	ld	a,-49 (ix)
   16AC DD 96 F8      [19] 2107 	sub	a, -8 (ix)
   16AF 20 50         [12] 2108 	jr	NZ,00216$
                           2109 ;src/Renderer.c:691: ++xCell;
   16B1 DD 34 C6      [23] 2110 	inc	-58 (ix)
                           2111 ;src/Renderer.c:692: xCellCount = 0;
   16B4 DD 36 F8 00   [19] 2112 	ld	-8 (ix),#0x00
                           2113 ;src/Renderer.c:693: newCell=1;
   16B8 DD 36 DD 01   [19] 2114 	ld	-35 (ix),#0x01
                           2115 ;src/Renderer.c:694: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   16BC DD 7E C6      [19] 2116 	ld	a,-58 (ix)
   16BF DD 77 DB      [19] 2117 	ld	-37 (ix),a
   16C2 DD 36 DC 00   [19] 2118 	ld	-36 (ix),#0x00
   16C6 DD 7E FE      [19] 2119 	ld	a,-2 (ix)
   16C9 DD 96 DB      [19] 2120 	sub	a, -37 (ix)
   16CC DD 77 DB      [19] 2121 	ld	-37 (ix),a
   16CF DD 7E FF      [19] 2122 	ld	a,-1 (ix)
   16D2 DD 9E DC      [19] 2123 	sbc	a, -36 (ix)
   16D5 DD 77 DC      [19] 2124 	ld	-36 (ix),a
   16D8 DD 6E DB      [19] 2125 	ld	l,-37 (ix)
   16DB DD 66 DC      [19] 2126 	ld	h,-36 (ix)
   16DE 2B            [ 6] 2127 	dec	hl
   16DF DD 75 DB      [19] 2128 	ld	-37 (ix),l
   16E2 DD 74 DC      [19] 2129 	ld	-36 (ix),h
   16E5 DD 7E E4      [19] 2130 	ld	a,-28 (ix)
   16E8 DD 86 DB      [19] 2131 	add	a, -37 (ix)
   16EB DD 77 DB      [19] 2132 	ld	-37 (ix),a
   16EE DD 7E E5      [19] 2133 	ld	a,-27 (ix)
   16F1 DD 8E DC      [19] 2134 	adc	a, -36 (ix)
   16F4 DD 77 DC      [19] 2135 	ld	-36 (ix),a
   16F7 DD 6E DB      [19] 2136 	ld	l,-37 (ix)
   16FA DD 66 DC      [19] 2137 	ld	h,-36 (ix)
   16FD 7E            [ 7] 2138 	ld	a,(hl)
   16FE DD 77 F4      [19] 2139 	ld	-12 (ix),a
   1701                    2140 00216$:
                           2141 ;src/Renderer.c:696: if(!(x%2)){
   1701 DD 7E D5      [19] 2142 	ld	a,-43 (ix)
   1704 E6 01         [ 7] 2143 	and	a, #0x01
   1706 DD 77 D8      [19] 2144 	ld	-40 (ix),a
                           2145 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   1709 DD 7E F4      [19] 2146 	ld	a,-12 (ix)
   170C E6 80         [ 7] 2147 	and	a, #0x80
   170E DD 77 DB      [19] 2148 	ld	-37 (ix),a
                           2149 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   1711 DD 7E F8      [19] 2150 	ld	a,-8 (ix)
   1714 DD 77 FA      [19] 2151 	ld	-6 (ix),a
   1717 DD 36 FB 00   [19] 2152 	ld	-5 (ix),#0x00
                           2153 ;src/Renderer.c:696: if(!(x%2)){
   171B DD 7E D8      [19] 2154 	ld	a,-40 (ix)
   171E B7            [ 4] 2155 	or	a, a
   171F C2 4D 18      [10] 2156 	jp	NZ,00229$
                           2157 ;src/Renderer.c:697: if (lateralWallCounter == 0 || newCell)
   1722 DD 7E EA      [19] 2158 	ld	a,-22 (ix)
   1725 B7            [ 4] 2159 	or	a, a
   1726 28 07         [12] 2160 	jr	Z,00225$
   1728 DD 7E DD      [19] 2161 	ld	a,-35 (ix)
   172B B7            [ 4] 2162 	or	a, a
   172C CA 4D 18      [10] 2163 	jp	Z,00229$
   172F                    2164 00225$:
                           2165 ;src/Renderer.c:699: if ( currentCellID & CELL_WALL_MASK)//Wall
   172F DD 7E DB      [19] 2166 	ld	a,-37 (ix)
   1732 B7            [ 4] 2167 	or	a, a
   1733 28 32         [12] 2168 	jr	Z,00223$
                           2169 ;src/Renderer.c:701: lateralWallCounter = 0;
   1735 DD 36 EA 00   [19] 2170 	ld	-22 (ix),#0x00
                           2171 ;src/Renderer.c:702: lateralWallSlope = 0;
   1739 DD 36 F5 00   [19] 2172 	ld	-11 (ix),#0x00
                           2173 ;src/Renderer.c:703: xHeight = zHeight;
   173D DD 7E CF      [19] 2174 	ld	a,-49 (ix)
   1740 DD 77 F0      [19] 2175 	ld	-16 (ix),a
                           2176 ;src/Renderer.c:704: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   1743 DD 7E F4      [19] 2177 	ld	a,-12 (ix)
   1746 D6 80         [ 7] 2178 	sub	a, #0x80
   1748 20 06         [12] 2179 	jr	NZ,00275$
   174A DD 36 DA 0C   [19] 2180 	ld	-38 (ix),#0x0C
   174E 18 04         [12] 2181 	jr	00276$
   1750                    2182 00275$:
   1750 DD 36 DA 0E   [19] 2183 	ld	-38 (ix),#0x0E
   1754                    2184 00276$:
   1754 DD 7E DA      [19] 2185 	ld	a,-38 (ix)
   1757 DD 77 D6      [19] 2186 	ld	-42 (ix),a
                           2187 ;src/Renderer.c:705: lastCellWasWall = 1;
   175A DD 36 DE 01   [19] 2188 	ld	-34 (ix),#0x01
                           2189 ;src/Renderer.c:706: lastWallId=currentCellID;
   175E DD 7E F4      [19] 2190 	ld	a,-12 (ix)
   1761 DD 77 D7      [19] 2191 	ld	-41 (ix),a
   1764 C3 49 18      [10] 2192 	jp	00224$
   1767                    2193 00223$:
                           2194 ;src/Renderer.c:708: else if(lateralWallCounter==0){
   1767 DD 7E EA      [19] 2195 	ld	a,-22 (ix)
   176A B7            [ 4] 2196 	or	a, a
   176B C2 49 18      [10] 2197 	jp	NZ,00224$
                           2198 ;src/Renderer.c:709: if (lastCellWasWall)
   176E DD 7E DE      [19] 2199 	ld	a,-34 (ix)
   1771 B7            [ 4] 2200 	or	a, a
   1772 CA 39 18      [10] 2201 	jp	Z,00218$
                           2202 ;src/Renderer.c:712: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   1775 DD 7E C9      [19] 2203 	ld	a,-55 (ix)
   1778 DD 96 C6      [19] 2204 	sub	a, -58 (ix)
   177B 87            [ 4] 2205 	add	a, a
   177C 3C            [ 4] 2206 	inc	a
                           2207 ;src/Renderer.c:713: lateralWallSlopeCounter = lateralWallSlope / 2;
   177D DD 77 F5      [19] 2208 	ld	-11 (ix), a
   1780 CB 3F         [ 8] 2209 	srl	a
   1782 DD 77 F2      [19] 2210 	ld	-14 (ix),a
                           2211 ;src/Renderer.c:714: lateralWallCounter = lateralWallSlope * zHeight;
   1785 DD 5E CF      [19] 2212 	ld	e,-49 (ix)
   1788 DD 66 F5      [19] 2213 	ld	h,-11 (ix)
   178B 2E 00         [ 7] 2214 	ld	l, #0x00
   178D 55            [ 4] 2215 	ld	d, l
   178E 06 08         [ 7] 2216 	ld	b, #0x08
   1790                    2217 00648$:
   1790 29            [11] 2218 	add	hl,hl
   1791 30 01         [12] 2219 	jr	NC,00649$
   1793 19            [11] 2220 	add	hl,de
   1794                    2221 00649$:
   1794 10 FA         [13] 2222 	djnz	00648$
                           2223 ;src/Renderer.c:715: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   1796 DD 75 DA      [19] 2224 	ld	-38 (ix), l
   1799 DD 75 FC      [19] 2225 	ld	-4 (ix), l
   179C DD 36 FD 00   [19] 2226 	ld	-3 (ix),#0x00
   17A0 DD 7E DA      [19] 2227 	ld	a,-38 (ix)
   17A3 E6 03         [ 7] 2228 	and	a, #0x03
   17A5 DD 77 DA      [19] 2229 	ld	-38 (ix), a
   17A8 DD 77 DF      [19] 2230 	ld	-33 (ix),a
   17AB DD 36 E0 00   [19] 2231 	ld	-32 (ix),#0x00
   17AF DD 7E FC      [19] 2232 	ld	a,-4 (ix)
   17B2 DD 96 DF      [19] 2233 	sub	a, -33 (ix)
   17B5 DD 77 DF      [19] 2234 	ld	-33 (ix),a
   17B8 DD 7E FD      [19] 2235 	ld	a,-3 (ix)
   17BB DD 9E E0      [19] 2236 	sbc	a, -32 (ix)
   17BE DD 77 E0      [19] 2237 	ld	-32 (ix),a
   17C1 DD 7E DF      [19] 2238 	ld	a,-33 (ix)
   17C4 C6 01         [ 7] 2239 	add	a, #0x01
   17C6 DD 77 FC      [19] 2240 	ld	-4 (ix),a
   17C9 DD 7E E0      [19] 2241 	ld	a,-32 (ix)
   17CC CE 00         [ 7] 2242 	adc	a, #0x00
   17CE DD 77 FD      [19] 2243 	ld	-3 (ix),a
   17D1 DD 7E FC      [19] 2244 	ld	a,-4 (ix)
   17D4 DD 77 E1      [19] 2245 	ld	-31 (ix),a
   17D7 DD 7E FD      [19] 2246 	ld	a,-3 (ix)
   17DA DD 77 E2      [19] 2247 	ld	-30 (ix),a
   17DD DD CB FD 7E   [20] 2248 	bit	7, -3 (ix)
   17E1 28 10         [12] 2249 	jr	Z,00277$
   17E3 DD 7E DF      [19] 2250 	ld	a,-33 (ix)
   17E6 C6 04         [ 7] 2251 	add	a, #0x04
   17E8 DD 77 E1      [19] 2252 	ld	-31 (ix),a
   17EB DD 7E E0      [19] 2253 	ld	a,-32 (ix)
   17EE CE 00         [ 7] 2254 	adc	a, #0x00
   17F0 DD 77 E2      [19] 2255 	ld	-30 (ix),a
   17F3                    2256 00277$:
   17F3 DD 4E E1      [19] 2257 	ld	c,-31 (ix)
   17F6 DD 46 E2      [19] 2258 	ld	b,-30 (ix)
   17F9 CB 28         [ 8] 2259 	sra	b
   17FB CB 19         [ 8] 2260 	rr	c
   17FD CB 28         [ 8] 2261 	sra	b
   17FF CB 19         [ 8] 2262 	rr	c
   1801 DD 46 F8      [19] 2263 	ld	b,-8 (ix)
   1804 79            [ 4] 2264 	ld	a,c
   1805 90            [ 4] 2265 	sub	a, b
   1806 DD 77 EA      [19] 2266 	ld	-22 (ix),a
                           2267 ;src/Renderer.c:717: lastCellWasWall = 0;
   1809 DD 36 DE 00   [19] 2268 	ld	-34 (ix),#0x00
                           2269 ;src/Renderer.c:718: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   180D DD 6E FA      [19] 2270 	ld	l,-6 (ix)
   1810 DD 66 FB      [19] 2271 	ld	h,-5 (ix)
   1813 29            [11] 2272 	add	hl, hl
   1814 DD 4E F5      [19] 2273 	ld	c,-11 (ix)
   1817 06 00         [ 7] 2274 	ld	b,#0x00
   1819 C5            [11] 2275 	push	bc
   181A E5            [11] 2276 	push	hl
   181B CD 1D 44      [17] 2277 	call	__divsint
   181E F1            [10] 2278 	pop	af
   181F F1            [10] 2279 	pop	af
   1820 DD 7E E6      [19] 2280 	ld	a,-26 (ix)
   1823 95            [ 4] 2281 	sub	a, l
   1824 DD 77 F0      [19] 2282 	ld	-16 (ix),a
                           2283 ;src/Renderer.c:719: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   1827 DD 7E D7      [19] 2284 	ld	a,-41 (ix)
   182A D6 80         [ 7] 2285 	sub	a, #0x80
   182C 20 04         [12] 2286 	jr	NZ,00278$
   182E 0E 0F         [ 7] 2287 	ld	c,#0x0F
   1830 18 02         [12] 2288 	jr	00279$
   1832                    2289 00278$:
   1832 0E 0D         [ 7] 2290 	ld	c,#0x0D
   1834                    2291 00279$:
   1834 DD 71 D6      [19] 2292 	ld	-42 (ix),c
   1837 18 10         [12] 2293 	jr	00224$
   1839                    2294 00218$:
                           2295 ;src/Renderer.c:723: xHeight = 0;
   1839 DD 36 F0 00   [19] 2296 	ld	-16 (ix),#0x00
                           2297 ;src/Renderer.c:724: lastCellWasWall = 0;
   183D DD 36 DE 00   [19] 2298 	ld	-34 (ix),#0x00
                           2299 ;src/Renderer.c:725: lateralWallSlope=0;
   1841 DD 36 F5 00   [19] 2300 	ld	-11 (ix),#0x00
                           2301 ;src/Renderer.c:726: lastWallId=0;
   1845 DD 36 D7 00   [19] 2302 	ld	-41 (ix),#0x00
   1849                    2303 00224$:
                           2304 ;src/Renderer.c:729: newCell=0;
   1849 DD 36 DD 00   [19] 2305 	ld	-35 (ix),#0x00
   184D                    2306 00229$:
                           2307 ;src/Renderer.c:734: if (lateralWallCounter > 0)
   184D DD 7E EA      [19] 2308 	ld	a,-22 (ix)
   1850 B7            [ 4] 2309 	or	a, a
   1851 28 1E         [12] 2310 	jr	Z,00235$
                           2311 ;src/Renderer.c:737: if (lateralWallSlope != 0)
   1853 DD 7E F5      [19] 2312 	ld	a,-11 (ix)
   1856 B7            [ 4] 2313 	or	a, a
   1857 28 15         [12] 2314 	jr	Z,00233$
                           2315 ;src/Renderer.c:739: if (lateralWallSlopeCounter == lateralWallSlope)
   1859 DD 7E F5      [19] 2316 	ld	a,-11 (ix)
   185C DD 96 F2      [19] 2317 	sub	a, -14 (ix)
   185F 20 0A         [12] 2318 	jr	NZ,00231$
                           2319 ;src/Renderer.c:741: lateralWallSlopeCounter = 0;
   1861 DD 36 F2 00   [19] 2320 	ld	-14 (ix),#0x00
                           2321 ;src/Renderer.c:742: xHeight -= 2;
   1865 DD 35 F0      [23] 2322 	dec	-16 (ix)
   1868 DD 35 F0      [23] 2323 	dec	-16 (ix)
   186B                    2324 00231$:
                           2325 ;src/Renderer.c:744: ++lateralWallSlopeCounter;
   186B DD 34 F2      [23] 2326 	inc	-14 (ix)
   186E                    2327 00233$:
                           2328 ;src/Renderer.c:746: --lateralWallCounter;
   186E DD 35 EA      [23] 2329 	dec	-22 (ix)
   1871                    2330 00235$:
                           2331 ;src/Renderer.c:750: if (!(x%2))
   1871 DD 7E D8      [19] 2332 	ld	a,-40 (ix)
   1874 B7            [ 4] 2333 	or	a, a
   1875 20 5B         [12] 2334 	jr	NZ,00244$
                           2335 ;src/Renderer.c:755: draw_column_to_buffer_untextured(x/2, xHeight, color);
   1877 DD 46 D5      [19] 2336 	ld	b,-43 (ix)
   187A CB 38         [ 8] 2337 	srl	b
                           2338 ;src/Renderer.c:753: if(xHeight > 0){
   187C DD 7E F0      [19] 2339 	ld	a,-16 (ix)
   187F B7            [ 4] 2340 	or	a, a
   1880 28 10         [12] 2341 	jr	Z,00237$
                           2342 ;src/Renderer.c:755: draw_column_to_buffer_untextured(x/2, xHeight, color);
   1882 C5            [11] 2343 	push	bc
   1883 DD 66 D6      [19] 2344 	ld	h,-42 (ix)
   1886 DD 6E F0      [19] 2345 	ld	l,-16 (ix)
   1889 E5            [11] 2346 	push	hl
   188A C5            [11] 2347 	push	bc
   188B 33            [ 6] 2348 	inc	sp
   188C CD BF 0A      [17] 2349 	call	_draw_column_to_buffer_untextured
   188F F1            [10] 2350 	pop	af
   1890 33            [ 6] 2351 	inc	sp
   1891 C1            [10] 2352 	pop	bc
   1892                    2353 00237$:
                           2354 ;src/Renderer.c:758: if(!(currentCellID&CELL_WALL_MASK)){
   1892 DD 7E DB      [19] 2355 	ld	a,-37 (ix)
   1895 B7            [ 4] 2356 	or	a, a
   1896 20 3A         [12] 2357 	jr	NZ,00244$
                           2358 ;src/Renderer.c:759: if(currentCellID&CELL_ENEMY_MASK){
   1898 DD 7E F4      [19] 2359 	ld	a,-12 (ix)
   189B E6 0F         [ 7] 2360 	and	a, #0x0F
   189D 28 33         [12] 2361 	jr	Z,00244$
                           2362 ;src/Renderer.c:760: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   189F DD 7E ED      [19] 2363 	ld	a,-19 (ix)
   18A2 DD 96 FA      [19] 2364 	sub	a, -6 (ix)
   18A5 6F            [ 4] 2365 	ld	l,a
   18A6 DD 7E EE      [19] 2366 	ld	a,-18 (ix)
   18A9 DD 9E FB      [19] 2367 	sbc	a, -5 (ix)
   18AC 67            [ 4] 2368 	ld	h,a
   18AD 29            [11] 2369 	add	hl, hl
   18AE 29            [11] 2370 	add	hl, hl
   18AF 29            [11] 2371 	add	hl, hl
   18B0 29            [11] 2372 	add	hl, hl
   18B1 29            [11] 2373 	add	hl, hl
   18B2 C5            [11] 2374 	push	bc
   18B3 DD 5E ED      [19] 2375 	ld	e,-19 (ix)
   18B6 DD 56 EE      [19] 2376 	ld	d,-18 (ix)
   18B9 D5            [11] 2377 	push	de
   18BA E5            [11] 2378 	push	hl
   18BB CD 1D 44      [17] 2379 	call	__divsint
   18BE F1            [10] 2380 	pop	af
   18BF F1            [10] 2381 	pop	af
   18C0 55            [ 4] 2382 	ld	d,l
   18C1 C1            [10] 2383 	pop	bc
   18C2 D5            [11] 2384 	push	de
   18C3 33            [ 6] 2385 	inc	sp
   18C4 DD 66 F4      [19] 2386 	ld	h,-12 (ix)
   18C7 DD 6E CF      [19] 2387 	ld	l,-49 (ix)
   18CA E5            [11] 2388 	push	hl
   18CB C5            [11] 2389 	push	bc
   18CC 33            [ 6] 2390 	inc	sp
   18CD CD 36 0B      [17] 2391 	call	_draw_column_to_buffer_enemy
   18D0 F1            [10] 2392 	pop	af
   18D1 F1            [10] 2393 	pop	af
                           2394 ;src/Renderer.c:762: else if(currentCellID&CELL_ITEM_MASK){
   18D2                    2395 00244$:
                           2396 ;src/Renderer.c:767: ++xCellCount;
   18D2 DD 34 F8      [23] 2397 	inc	-8 (ix)
                           2398 ;src/Renderer.c:686: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   18D5 DD 35 D5      [23] 2399 	dec	-43 (ix)
                           2400 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   18D8 2A B8 0A      [16] 2401 	ld	hl,(_cells_in_view_array)
   18DB DD 75 E4      [19] 2402 	ld	-28 (ix),l
   18DE DD 74 E5      [19] 2403 	ld	-27 (ix),h
                           2404 ;src/Renderer.c:686: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   18E1 DD 7E D5      [19] 2405 	ld	a,-43 (ix)
   18E4 D6 50         [ 7] 2406 	sub	a, #0x50
   18E6 D2 A9 16      [10] 2407 	jp	NC,00258$
                           2408 ;src/Renderer.c:774: lineStart = lineStart + (offsetDiff * 2) + 3;
   18E9 DD 7E E7      [19] 2409 	ld	a,-25 (ix)
   18EC C6 03         [ 7] 2410 	add	a, #0x03
   18EE DD 77 C7      [19] 2411 	ld	-57 (ix),a
                           2412 ;src/Renderer.c:775: zHeight += zHeight;
   18F1 DD CB CF 26   [23] 2413 	sla	-49 (ix)
                           2414 ;src/Renderer.c:776: offsetDiff = offsetDiff >> 1;
   18F5 DD CB C9 3E   [23] 2415 	srl	-55 (ix)
                           2416 ;src/Renderer.c:778: }while(z);
   18F9 DD 7E D2      [19] 2417 	ld	a,-46 (ix)
   18FC B7            [ 4] 2418 	or	a, a
   18FD C2 57 13      [10] 2419 	jp	NZ,00246$
   1900                    2420 00260$:
   1900 DD F9         [10] 2421 	ld	sp, ix
   1902 DD E1         [14] 2422 	pop	ix
   1904 C9            [10] 2423 	ret
                           2424 ;src/Renderer.c:784: void draw_minimap_to_buffer(){
                           2425 ;	---------------------------------
                           2426 ; Function draw_minimap_to_buffer
                           2427 ; ---------------------------------
   1905                    2428 _draw_minimap_to_buffer::
   1905 DD E5         [15] 2429 	push	ix
   1907 DD 21 00 00   [14] 2430 	ld	ix,#0
   190B DD 39         [15] 2431 	add	ix,sp
   190D 21 F5 FF      [10] 2432 	ld	hl,#-11
   1910 39            [11] 2433 	add	hl,sp
   1911 F9            [ 6] 2434 	ld	sp,hl
                           2435 ;src/Renderer.c:787: u8* ptr = MINIMAP_BUFFER;
   1912 01 A0 9A      [10] 2436 	ld	bc,#0x9AA0
                           2437 ;src/Renderer.c:792: y=(PLAYER_position.y-MINIMAP_HEIGHT_HALF);
   1915 3A DF 08      [13] 2438 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   1918 C6 F8         [ 7] 2439 	add	a,#0xF8
   191A 5F            [ 4] 2440 	ld	e,a
                           2441 ;src/Renderer.c:794: for(j=0;j<MINIMAP_HEIGHT;++j){
   191B 16 00         [ 7] 2442 	ld	d,#0x00
                           2443 ;src/Renderer.c:795: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   191D                    2444 00137$:
   191D 7B            [ 4] 2445 	ld	a,e
   191E 07            [ 4] 2446 	rlca
   191F E6 01         [ 7] 2447 	and	a,#0x01
   1921 DD 77 FF      [19] 2448 	ld	-1 (ix),a
   1924 7B            [ 4] 2449 	ld	a,e
   1925 EE 80         [ 7] 2450 	xor	a, #0x80
   1927 D6 A0         [ 7] 2451 	sub	a, #0xA0
   1929 3E 00         [ 7] 2452 	ld	a,#0x00
   192B 17            [ 4] 2453 	rla
   192C DD 77 FE      [19] 2454 	ld	-2 (ix),a
   192F DD 36 F6 00   [19] 2455 	ld	-10 (ix),#0x00
   1933                    2456 00122$:
                           2457 ;src/Renderer.c:796: x=(PLAYER_position.x-MINIMAP_WIDTH_HALF);
   1933 3A DE 08      [13] 2458 	ld	a, (#_PLAYER_position + 0)
   1936 C6 F8         [ 7] 2459 	add	a,#0xF8
   1938 DD 77 FD      [19] 2460 	ld	-3 (ix),a
                           2461 ;src/Renderer.c:797: for(i=0;i<MINIMAP_WIDTH;++i){
   193B DD 36 F5 00   [19] 2462 	ld	-11 (ix),#0x00
   193F                    2463 00120$:
                           2464 ;src/Renderer.c:800: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   193F FD 21 10 00   [14] 2465 	ld	iy,#0x0010
   1943 FD 09         [15] 2466 	add	iy, bc
                           2467 ;src/Renderer.c:798: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
   1945 DD CB FD 7E   [20] 2468 	bit	7, -3 (ix)
   1949 20 15         [12] 2469 	jr	NZ,00111$
   194B DD 7E FD      [19] 2470 	ld	a,-3 (ix)
   194E EE 80         [ 7] 2471 	xor	a, #0x80
   1950 D6 A0         [ 7] 2472 	sub	a, #0xA0
   1952 30 0C         [12] 2473 	jr	NC,00111$
   1954 DD 7E FF      [19] 2474 	ld	a,-1 (ix)
   1957 B7            [ 4] 2475 	or	a, a
   1958 20 06         [12] 2476 	jr	NZ,00111$
   195A DD CB FE 46   [20] 2477 	bit	0,-2 (ix)
   195E 20 0D         [12] 2478 	jr	NZ,00112$
   1960                    2479 00111$:
                           2480 ;src/Renderer.c:799: *ptr=g_colors[MINIMAP_WALL_COLOR];
   1960 3A A6 0A      [13] 2481 	ld	a, (#(_g_colors + 0x0001) + 0)
   1963 02            [ 7] 2482 	ld	(bc),a
                           2483 ;src/Renderer.c:800: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   1964 3A A6 0A      [13] 2484 	ld	a, (#(_g_colors + 0x0001) + 0)
   1967 FD 77 00      [19] 2485 	ld	0 (iy), a
   196A C3 14 1A      [10] 2486 	jp	00113$
   196D                    2487 00112$:
                           2488 ;src/Renderer.c:802: else if((x==PLAYER_position.x)&&(y==PLAYER_position.y)){
   196D DD 7E FD      [19] 2489 	ld	a,-3 (ix)
   1970 DD 77 FB      [19] 2490 	ld	-5 (ix),a
   1973 DD 7E FD      [19] 2491 	ld	a,-3 (ix)
   1976 17            [ 4] 2492 	rla
   1977 9F            [ 4] 2493 	sbc	a, a
   1978 DD 77 FC      [19] 2494 	ld	-4 (ix),a
   197B 3A DE 08      [13] 2495 	ld	a, (#_PLAYER_position + 0)
   197E DD 77 F9      [19] 2496 	ld	-7 (ix),a
   1981 DD 36 FA 00   [19] 2497 	ld	-6 (ix),#0x00
   1985 DD 73 F7      [19] 2498 	ld	-9 (ix),e
   1988 7B            [ 4] 2499 	ld	a,e
   1989 17            [ 4] 2500 	rla
   198A 9F            [ 4] 2501 	sbc	a, a
   198B DD 77 F8      [19] 2502 	ld	-8 (ix),a
   198E DD 7E FB      [19] 2503 	ld	a,-5 (ix)
   1991 DD 96 F9      [19] 2504 	sub	a, -7 (ix)
   1994 20 2E         [12] 2505 	jr	NZ,00108$
   1996 DD 7E FC      [19] 2506 	ld	a,-4 (ix)
   1999 DD 96 FA      [19] 2507 	sub	a, -6 (ix)
   199C 20 26         [12] 2508 	jr	NZ,00108$
   199E 3A DF 08      [13] 2509 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   19A1 DD 77 F9      [19] 2510 	ld	-7 (ix),a
   19A4 DD 36 FA 00   [19] 2511 	ld	-6 (ix),#0x00
   19A8 DD 7E F7      [19] 2512 	ld	a,-9 (ix)
   19AB DD 96 F9      [19] 2513 	sub	a, -7 (ix)
   19AE 20 14         [12] 2514 	jr	NZ,00108$
   19B0 DD 7E F8      [19] 2515 	ld	a,-8 (ix)
   19B3 DD 96 FA      [19] 2516 	sub	a, -6 (ix)
   19B6 20 0C         [12] 2517 	jr	NZ,00108$
                           2518 ;src/Renderer.c:803: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
   19B8 3A A9 0A      [13] 2519 	ld	a, (#(_g_colors + 0x0004) + 0)
   19BB 02            [ 7] 2520 	ld	(bc),a
                           2521 ;src/Renderer.c:804: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
   19BC 3A A9 0A      [13] 2522 	ld	a, (#(_g_colors + 0x0004) + 0)
   19BF FD 77 00      [19] 2523 	ld	0 (iy), a
   19C2 18 50         [12] 2524 	jr	00113$
   19C4                    2525 00108$:
                           2526 ;src/Renderer.c:807: val = (*(u8*)(MAP_MEM+x+y*MAP_WIDTH));
   19C4 DD 7E FB      [19] 2527 	ld	a,-5 (ix)
   19C7 C6 00         [ 7] 2528 	add	a, #0x00
   19C9 DD 77 F9      [19] 2529 	ld	-7 (ix),a
   19CC DD 7E FC      [19] 2530 	ld	a,-4 (ix)
   19CF CE 60         [ 7] 2531 	adc	a, #0x60
   19D1 DD 77 FA      [19] 2532 	ld	-6 (ix),a
   19D4 DD 6E F7      [19] 2533 	ld	l,-9 (ix)
   19D7 DD 66 F8      [19] 2534 	ld	h,-8 (ix)
   19DA 29            [11] 2535 	add	hl, hl
   19DB 29            [11] 2536 	add	hl, hl
   19DC 29            [11] 2537 	add	hl, hl
   19DD 29            [11] 2538 	add	hl, hl
   19DE 29            [11] 2539 	add	hl, hl
   19DF DD 7E F9      [19] 2540 	ld	a,-7 (ix)
   19E2 85            [ 4] 2541 	add	a, l
   19E3 6F            [ 4] 2542 	ld	l,a
   19E4 DD 7E FA      [19] 2543 	ld	a,-6 (ix)
   19E7 8C            [ 4] 2544 	adc	a, h
   19E8 67            [ 4] 2545 	ld	h,a
   19E9 66            [ 7] 2546 	ld	h,(hl)
                           2547 ;src/Renderer.c:809: if(val==CELLTYPE_DOOR){
   19EA 7C            [ 4] 2548 	ld	a,h
   19EB D6 80         [ 7] 2549 	sub	a, #0x80
   19ED 20 0C         [12] 2550 	jr	NZ,00105$
                           2551 ;src/Renderer.c:810: *ptr=g_colors[MINIMAP_EXIT_COLOR];
   19EF 3A AA 0A      [13] 2552 	ld	a, (#(_g_colors + 0x0005) + 0)
   19F2 02            [ 7] 2553 	ld	(bc),a
                           2554 ;src/Renderer.c:811: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
   19F3 3A AA 0A      [13] 2555 	ld	a, (#(_g_colors + 0x0005) + 0)
   19F6 FD 77 00      [19] 2556 	ld	0 (iy), a
   19F9 18 19         [12] 2557 	jr	00113$
   19FB                    2558 00105$:
                           2559 ;src/Renderer.c:813: else if(val&CELL_WALL_MASK){
   19FB 29            [11] 2560 	add	hl, hl
   19FC 30 0C         [12] 2561 	jr	NC,00102$
                           2562 ;src/Renderer.c:814: *ptr=g_colors[MINIMAP_WALL_COLOR];
   19FE 3A A6 0A      [13] 2563 	ld	a, (#(_g_colors + 0x0001) + 0)
   1A01 02            [ 7] 2564 	ld	(bc),a
                           2565 ;src/Renderer.c:815: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   1A02 3A A6 0A      [13] 2566 	ld	a, (#(_g_colors + 0x0001) + 0)
   1A05 FD 77 00      [19] 2567 	ld	0 (iy), a
   1A08 18 0A         [12] 2568 	jr	00113$
   1A0A                    2569 00102$:
                           2570 ;src/Renderer.c:818: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
   1A0A 3A A8 0A      [13] 2571 	ld	a, (#(_g_colors + 0x0003) + 0)
   1A0D 02            [ 7] 2572 	ld	(bc),a
                           2573 ;src/Renderer.c:819: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
   1A0E 3A A8 0A      [13] 2574 	ld	a, (#(_g_colors + 0x0003) + 0)
   1A11 FD 77 00      [19] 2575 	ld	0 (iy), a
   1A14                    2576 00113$:
                           2577 ;src/Renderer.c:822: ++x;
   1A14 DD 34 FD      [23] 2578 	inc	-3 (ix)
                           2579 ;src/Renderer.c:823: ++ptr;
   1A17 03            [ 6] 2580 	inc	bc
                           2581 ;src/Renderer.c:797: for(i=0;i<MINIMAP_WIDTH;++i){
   1A18 DD 34 F5      [23] 2582 	inc	-11 (ix)
   1A1B DD 7E F5      [19] 2583 	ld	a,-11 (ix)
   1A1E D6 10         [ 7] 2584 	sub	a, #0x10
   1A20 DA 3F 19      [10] 2585 	jp	C,00120$
                           2586 ;src/Renderer.c:795: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   1A23 DD 34 F6      [23] 2587 	inc	-10 (ix)
   1A26 DD 7E F6      [19] 2588 	ld	a,-10 (ix)
   1A29 D6 04         [ 7] 2589 	sub	a, #0x04
   1A2B DA 33 19      [10] 2590 	jp	C,00122$
                           2591 ;src/Renderer.c:826: ++y;
   1A2E 1C            [ 4] 2592 	inc	e
                           2593 ;src/Renderer.c:794: for(j=0;j<MINIMAP_HEIGHT;++j){
   1A2F 14            [ 4] 2594 	inc	d
   1A30 7A            [ 4] 2595 	ld	a,d
   1A31 D6 10         [ 7] 2596 	sub	a, #0x10
   1A33 DA 1D 19      [10] 2597 	jp	C,00137$
   1A36 DD F9         [10] 2598 	ld	sp, ix
   1A38 DD E1         [14] 2599 	pop	ix
   1A3A C9            [10] 2600 	ret
                           2601 	.area _CODE
                           2602 	.area _INITIALIZER
                           2603 	.area _CABS (ABS)
