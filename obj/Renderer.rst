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
                             16 	.globl _item_get_at
                             17 	.globl _enemy_get_at
                             18 	.globl _cpct_memset
                             19 	.globl _offsets_cells_in_view
                             20 	.globl _cells_in_view_array
                             21 	.globl _g_pixelMask
                             22 	.globl _g_colors
                             23 	.globl _g_palette
                             24 	.globl _render_draw_to_buffer
                             25 	.globl _draw_minimap_to_buffer
                             26 ;--------------------------------------------------------
                             27 ; special function registers
                             28 ;--------------------------------------------------------
                             29 ;--------------------------------------------------------
                             30 ; ram data
                             31 ;--------------------------------------------------------
                             32 	.area _DATA
                             33 ;--------------------------------------------------------
                             34 ; ram data
                             35 ;--------------------------------------------------------
                             36 	.area _INITIALIZED
                             37 ;--------------------------------------------------------
                             38 ; absolute external ram data
                             39 ;--------------------------------------------------------
                             40 	.area _DABS (ABS)
                             41 ;--------------------------------------------------------
                             42 ; global & static initialisations
                             43 ;--------------------------------------------------------
                             44 	.area _HOME
                             45 	.area _GSINIT
                             46 	.area _GSFINAL
                             47 	.area _GSINIT
                             48 ;--------------------------------------------------------
                             49 ; Home
                             50 ;--------------------------------------------------------
                             51 	.area _HOME
                             52 	.area _HOME
                             53 ;--------------------------------------------------------
                             54 ; code
                             55 ;--------------------------------------------------------
                             56 	.area _CODE
                             57 ;src/Renderer.c:51: void calculate_cells_in_view(){
                             58 ;	---------------------------------
                             59 ; Function calculate_cells_in_view
                             60 ; ---------------------------------
   18EE                      61 _calculate_cells_in_view::
   18EE DD E5         [15]   62 	push	ix
   18F0 DD 21 00 00   [14]   63 	ld	ix,#0
   18F4 DD 39         [15]   64 	add	ix,sp
   18F6 21 F2 FF      [10]   65 	ld	hl,#-14
   18F9 39            [11]   66 	add	hl,sp
   18FA F9            [ 6]   67 	ld	sp,hl
                             68 ;src/Renderer.c:53: u8 offset=0, n=0, j, i;
   18FB DD 36 FA 00   [19]   69 	ld	-6 (ix),#0x00
   18FF DD 36 F9 00   [19]   70 	ld	-7 (ix),#0x00
                             71 ;src/Renderer.c:56: if(player_direction.y!=0){
   1903 21 78 18      [10]   72 	ld	hl, #_player_direction + 1
   1906 7E            [ 7]   73 	ld	a,(hl)
   1907 DD 77 FD      [19]   74 	ld	-3 (ix), a
   190A B7            [ 4]   75 	or	a, a
   190B 28 32         [12]   76 	jr	Z,00102$
                             77 ;src/Renderer.c:57: vert=1;
   190D DD 36 F2 01   [19]   78 	ld	-14 (ix),#0x01
                             79 ;src/Renderer.c:58: dy=player_direction.y;
   1911 DD 4E FD      [19]   80 	ld	c,-3 (ix)
   1914 DD 71 F4      [19]   81 	ld	-12 (ix),c
                             82 ;src/Renderer.c:59: dx=-player_direction.y;
   1917 AF            [ 4]   83 	xor	a, a
   1918 DD 96 FD      [19]   84 	sub	a, -3 (ix)
   191B DD 77 F5      [19]   85 	ld	-11 (ix), a
                             86 ;src/Renderer.c:61: x0 = player_position.x-(17*dx);
   191E 21 75 18      [10]   87 	ld	hl,#_player_position+0
   1921 4E            [ 7]   88 	ld	c,(hl)
   1922 DD 6E F5      [19]   89 	ld	l,-11 (ix)
   1925 5D            [ 4]   90 	ld	e,l
   1926 29            [11]   91 	add	hl, hl
   1927 29            [11]   92 	add	hl, hl
   1928 29            [11]   93 	add	hl, hl
   1929 29            [11]   94 	add	hl, hl
   192A 19            [11]   95 	add	hl, de
   192B 79            [ 4]   96 	ld	a,c
   192C 95            [ 4]   97 	sub	a, l
   192D DD 77 F6      [19]   98 	ld	-10 (ix),a
                             99 ;src/Renderer.c:62: y0 = player_position.y+(6*dy);
   1930 21 76 18      [10]  100 	ld	hl,#_player_position+1
   1933 4E            [ 7]  101 	ld	c,(hl)
   1934 DD 6E F4      [19]  102 	ld	l,-12 (ix)
   1937 5D            [ 4]  103 	ld	e,l
   1938 29            [11]  104 	add	hl, hl
   1939 19            [11]  105 	add	hl, de
   193A 29            [11]  106 	add	hl, hl
   193B 09            [11]  107 	add	hl, bc
   193C 4D            [ 4]  108 	ld	c,l
   193D 18 35         [12]  109 	jr	00103$
   193F                     110 00102$:
                            111 ;src/Renderer.c:65: vert=0;
   193F DD 36 F2 00   [19]  112 	ld	-14 (ix),#0x00
                            113 ;src/Renderer.c:66: dy=player_direction.x;
   1943 21 77 18      [10]  114 	ld	hl, #_player_direction + 0
   1946 7E            [ 7]  115 	ld	a,(hl)
   1947 DD 77 FD      [19]  116 	ld	-3 (ix), a
   194A DD 77 F4      [19]  117 	ld	-12 (ix),a
                            118 ;src/Renderer.c:67: dx=player_direction.x;
   194D DD 7E FD      [19]  119 	ld	a,-3 (ix)
   1950 DD 77 F5      [19]  120 	ld	-11 (ix),a
                            121 ;src/Renderer.c:69: y0 = player_position.y-(17*dy);
   1953 21 76 18      [10]  122 	ld	hl, #_player_position + 1
   1956 4E            [ 7]  123 	ld	c,(hl)
   1957 DD 6E F4      [19]  124 	ld	l,-12 (ix)
   195A 5D            [ 4]  125 	ld	e,l
   195B 29            [11]  126 	add	hl, hl
   195C 29            [11]  127 	add	hl, hl
   195D 29            [11]  128 	add	hl, hl
   195E 29            [11]  129 	add	hl, hl
   195F 19            [11]  130 	add	hl, de
   1960 79            [ 4]  131 	ld	a,c
   1961 95            [ 4]  132 	sub	a, l
   1962 4F            [ 4]  133 	ld	c,a
                            134 ;src/Renderer.c:70: x0 = player_position.x+(6*dx);
   1963 21 75 18      [10]  135 	ld	hl, #_player_position + 0
   1966 46            [ 7]  136 	ld	b,(hl)
   1967 DD 7E FD      [19]  137 	ld	a,-3 (ix)
   196A 5F            [ 4]  138 	ld	e,a
   196B 87            [ 4]  139 	add	a, a
   196C 83            [ 4]  140 	add	a, e
   196D 87            [ 4]  141 	add	a, a
   196E 5F            [ 4]  142 	ld	e,a
   196F 68            [ 4]  143 	ld	l,b
   1970 19            [11]  144 	add	hl, de
   1971 DD 75 F6      [19]  145 	ld	-10 (ix),l
   1974                     146 00103$:
                            147 ;src/Renderer.c:74: x=x0;
   1974 DD 5E F6      [19]  148 	ld	e,-10 (ix)
                            149 ;src/Renderer.c:75: y=y0;
   1977 DD 71 F3      [19]  150 	ld	-13 (ix),c
                            151 ;src/Renderer.c:77: for(j=0;j<6;++j){
   197A DD 7E F5      [19]  152 	ld	a,-11 (ix)
   197D 07            [ 4]  153 	rlca
   197E E6 01         [ 7]  154 	and	a,#0x01
   1980 DD 77 FD      [19]  155 	ld	-3 (ix),a
   1983 DD 7E F4      [19]  156 	ld	a,-12 (ix)
   1986 07            [ 4]  157 	rlca
   1987 E6 01         [ 7]  158 	and	a,#0x01
   1989 DD 77 FF      [19]  159 	ld	-1 (ix),a
   198C DD 36 F8 00   [19]  160 	ld	-8 (ix),#0x00
                            161 ;src/Renderer.c:79: for(i=offset;i<35-offset;++i){
   1990                     162 00138$:
   1990 DD 7E F9      [19]  163 	ld	a,-7 (ix)
   1993 DD 77 FE      [19]  164 	ld	-2 (ix),a
   1996 DD 7E FA      [19]  165 	ld	a,-6 (ix)
   1999 DD 77 F7      [19]  166 	ld	-9 (ix),a
   199C                     167 00125$:
   199C DD 6E FA      [19]  168 	ld	l,-6 (ix)
   199F 26 00         [ 7]  169 	ld	h,#0x00
   19A1 3E 23         [ 7]  170 	ld	a,#0x23
   19A3 95            [ 4]  171 	sub	a, l
   19A4 6F            [ 4]  172 	ld	l,a
   19A5 3E 00         [ 7]  173 	ld	a,#0x00
   19A7 9C            [ 4]  174 	sbc	a, h
   19A8 67            [ 4]  175 	ld	h,a
   19A9 DD 7E F7      [19]  176 	ld	a, -9 (ix)
   19AC 16 00         [ 7]  177 	ld	d, #0x00
   19AE 95            [ 4]  178 	sub	a, l
   19AF 7A            [ 4]  179 	ld	a,d
   19B0 9C            [ 4]  180 	sbc	a, h
   19B1 E2 B6 19      [10]  181 	jp	PO, 00181$
   19B4 EE 80         [ 7]  182 	xor	a, #0x80
   19B6                     183 00181$:
   19B6 F2 35 1A      [10]  184 	jp	P,00143$
                            185 ;src/Renderer.c:82: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   19B9 2A C1 1A      [16]  186 	ld	hl,(_cells_in_view_array)
   19BC 7D            [ 4]  187 	ld	a,l
   19BD DD 86 FE      [19]  188 	add	a, -2 (ix)
   19C0 DD 77 FB      [19]  189 	ld	-5 (ix),a
   19C3 7C            [ 4]  190 	ld	a,h
   19C4 CE 00         [ 7]  191 	adc	a, #0x00
   19C6 DD 77 FC      [19]  192 	ld	-4 (ix),a
                            193 ;src/Renderer.c:81: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
   19C9 CB 7B         [ 8]  194 	bit	7, e
   19CB 20 41         [12]  195 	jr	NZ,00105$
   19CD 7B            [ 4]  196 	ld	a,e
   19CE EE 80         [ 7]  197 	xor	a, #0x80
   19D0 D6 A0         [ 7]  198 	sub	a, #0xA0
   19D2 30 3A         [12]  199 	jr	NC,00105$
   19D4 DD CB F3 7E   [20]  200 	bit	7, -13 (ix)
   19D8 20 34         [12]  201 	jr	NZ,00105$
   19DA DD 7E F3      [19]  202 	ld	a,-13 (ix)
   19DD EE 80         [ 7]  203 	xor	a, #0x80
   19DF D6 A0         [ 7]  204 	sub	a, #0xA0
   19E1 30 2B         [12]  205 	jr	NC,00105$
                            206 ;src/Renderer.c:82: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   19E3 7B            [ 4]  207 	ld	a,e
   19E4 6F            [ 4]  208 	ld	l,a
   19E5 17            [ 4]  209 	rla
   19E6 9F            [ 4]  210 	sbc	a, a
   19E7 67            [ 4]  211 	ld	h,a
   19E8 7D            [ 4]  212 	ld	a,l
   19E9 C6 D0         [ 7]  213 	add	a, #0xD0
   19EB 47            [ 4]  214 	ld	b,a
   19EC 7C            [ 4]  215 	ld	a,h
   19ED CE 88         [ 7]  216 	adc	a, #0x88
   19EF 57            [ 4]  217 	ld	d,a
   19F0 DD 6E F3      [19]  218 	ld	l,-13 (ix)
   19F3 DD 7E F3      [19]  219 	ld	a,-13 (ix)
   19F6 17            [ 4]  220 	rla
   19F7 9F            [ 4]  221 	sbc	a, a
   19F8 67            [ 4]  222 	ld	h,a
   19F9 29            [11]  223 	add	hl, hl
   19FA 29            [11]  224 	add	hl, hl
   19FB 29            [11]  225 	add	hl, hl
   19FC 29            [11]  226 	add	hl, hl
   19FD 29            [11]  227 	add	hl, hl
   19FE 7D            [ 4]  228 	ld	a,l
   19FF 80            [ 4]  229 	add	a, b
   1A00 6F            [ 4]  230 	ld	l,a
   1A01 7C            [ 4]  231 	ld	a,h
   1A02 8A            [ 4]  232 	adc	a, d
   1A03 67            [ 4]  233 	ld	h,a
   1A04 46            [ 7]  234 	ld	b,(hl)
   1A05 DD 6E FB      [19]  235 	ld	l,-5 (ix)
   1A08 DD 66 FC      [19]  236 	ld	h,-4 (ix)
   1A0B 70            [ 7]  237 	ld	(hl),b
   1A0C 18 08         [12]  238 	jr	00106$
   1A0E                     239 00105$:
                            240 ;src/Renderer.c:85: cells_in_view_array[n]=CELLTYPE_WALL1;
   1A0E DD 6E FB      [19]  241 	ld	l,-5 (ix)
   1A11 DD 66 FC      [19]  242 	ld	h,-4 (ix)
   1A14 36 81         [10]  243 	ld	(hl),#0x81
   1A16                     244 00106$:
                            245 ;src/Renderer.c:89: if(vert){
   1A16 DD 7E F2      [19]  246 	ld	a,-14 (ix)
   1A19 B7            [ 4]  247 	or	a, a
   1A1A 28 07         [12]  248 	jr	Z,00111$
                            249 ;src/Renderer.c:90: x+=dx;
   1A1C 7B            [ 4]  250 	ld	a,e
   1A1D DD 86 F5      [19]  251 	add	a, -11 (ix)
   1A20 5F            [ 4]  252 	ld	e,a
   1A21 18 09         [12]  253 	jr	00112$
   1A23                     254 00111$:
                            255 ;src/Renderer.c:93: y+=dy;
   1A23 DD 7E F3      [19]  256 	ld	a,-13 (ix)
   1A26 DD 86 F4      [19]  257 	add	a, -12 (ix)
   1A29 DD 77 F3      [19]  258 	ld	-13 (ix),a
   1A2C                     259 00112$:
                            260 ;src/Renderer.c:95: ++n;
   1A2C DD 34 FE      [23]  261 	inc	-2 (ix)
                            262 ;src/Renderer.c:79: for(i=offset;i<35-offset;++i){
   1A2F DD 34 F7      [23]  263 	inc	-9 (ix)
   1A32 C3 9C 19      [10]  264 	jp	00125$
   1A35                     265 00143$:
   1A35 DD 7E FE      [19]  266 	ld	a,-2 (ix)
   1A38 DD 77 F9      [19]  267 	ld	-7 (ix),a
                            268 ;src/Renderer.c:97: offset=offsets_cells_in_view[j];
   1A3B 3E C3         [ 7]  269 	ld	a,#<(_offsets_cells_in_view)
   1A3D DD 86 F8      [19]  270 	add	a, -8 (ix)
   1A40 6F            [ 4]  271 	ld	l,a
   1A41 3E 1A         [ 7]  272 	ld	a,#>(_offsets_cells_in_view)
   1A43 CE 00         [ 7]  273 	adc	a, #0x00
   1A45 67            [ 4]  274 	ld	h,a
   1A46 7E            [ 7]  275 	ld	a,(hl)
                            276 ;src/Renderer.c:101: if(dx<0) x=x0-offset;
   1A47 DD 77 FA      [19]  277 	ld	-6 (ix), a
   1A4A DD 77 FB      [19]  278 	ld	-5 (ix),a
                            279 ;src/Renderer.c:99: if(vert){
   1A4D DD 7E F2      [19]  280 	ld	a,-14 (ix)
   1A50 B7            [ 4]  281 	or	a, a
   1A51 28 21         [12]  282 	jr	Z,00121$
                            283 ;src/Renderer.c:100: y-=dy;
   1A53 DD 7E F3      [19]  284 	ld	a,-13 (ix)
   1A56 DD 96 F4      [19]  285 	sub	a, -12 (ix)
   1A59 DD 77 F3      [19]  286 	ld	-13 (ix),a
                            287 ;src/Renderer.c:101: if(dx<0) x=x0-offset;
   1A5C DD 7E FD      [19]  288 	ld	a,-3 (ix)
   1A5F B7            [ 4]  289 	or	a, a
   1A60 28 09         [12]  290 	jr	Z,00115$
   1A62 DD 7E F6      [19]  291 	ld	a,-10 (ix)
   1A65 DD 96 FB      [19]  292 	sub	a, -5 (ix)
   1A68 5F            [ 4]  293 	ld	e,a
   1A69 18 24         [12]  294 	jr	00128$
   1A6B                     295 00115$:
                            296 ;src/Renderer.c:102: else x=x0+offset;
   1A6B DD 7E F6      [19]  297 	ld	a,-10 (ix)
   1A6E DD 86 FB      [19]  298 	add	a, -5 (ix)
   1A71 5F            [ 4]  299 	ld	e,a
   1A72 18 1B         [12]  300 	jr	00128$
   1A74                     301 00121$:
                            302 ;src/Renderer.c:106: x-=dx;
   1A74 7B            [ 4]  303 	ld	a,e
   1A75 DD 96 F5      [19]  304 	sub	a, -11 (ix)
   1A78 5F            [ 4]  305 	ld	e,a
                            306 ;src/Renderer.c:107: if(dy<0) y=y0-offset;
   1A79 DD 7E FF      [19]  307 	ld	a,-1 (ix)
   1A7C B7            [ 4]  308 	or	a, a
   1A7D 28 09         [12]  309 	jr	Z,00118$
   1A7F 79            [ 4]  310 	ld	a,c
   1A80 DD 96 FB      [19]  311 	sub	a, -5 (ix)
   1A83 DD 77 F3      [19]  312 	ld	-13 (ix),a
   1A86 18 07         [12]  313 	jr	00128$
   1A88                     314 00118$:
                            315 ;src/Renderer.c:108: else y=y0+offset;
   1A88 79            [ 4]  316 	ld	a,c
   1A89 DD 86 FB      [19]  317 	add	a, -5 (ix)
   1A8C DD 77 F3      [19]  318 	ld	-13 (ix),a
   1A8F                     319 00128$:
                            320 ;src/Renderer.c:77: for(j=0;j<6;++j){
   1A8F DD 34 F8      [23]  321 	inc	-8 (ix)
   1A92 DD 7E F8      [19]  322 	ld	a,-8 (ix)
   1A95 D6 06         [ 7]  323 	sub	a, #0x06
   1A97 DA 90 19      [10]  324 	jp	C,00138$
   1A9A DD F9         [10]  325 	ld	sp, ix
   1A9C DD E1         [14]  326 	pop	ix
   1A9E C9            [10]  327 	ret
   1A9F                     328 _g_palette:
   1A9F 08                  329 	.db #0x08	; 8
   1AA0 00                  330 	.db #0x00	; 0
   1AA1 0D                  331 	.db #0x0D	; 13
   1AA2 1A                  332 	.db #0x1A	; 26
   1AA3 06                  333 	.db #0x06	; 6
   1AA4 09                  334 	.db #0x09	; 9
   1AA5 0F                  335 	.db #0x0F	; 15
   1AA6 00                  336 	.db #0x00	; 0
   1AA7 00                  337 	.db #0x00	; 0
   1AA8 00                  338 	.db #0x00	; 0
   1AA9 00                  339 	.db #0x00	; 0
   1AAA 00                  340 	.db #0x00	; 0
   1AAB 00                  341 	.db #0x00	; 0
   1AAC 00                  342 	.db #0x00	; 0
   1AAD 00                  343 	.db #0x00	; 0
   1AAE 00                  344 	.db #0x00	; 0
   1AAF                     345 _g_colors:
   1AAF 00                  346 	.db #0x00	; 0
   1AB0 C0                  347 	.db #0xC0	; 192
   1AB1 0C                  348 	.db #0x0C	; 12
   1AB2 CC                  349 	.db #0xCC	; 204
   1AB3 30                  350 	.db #0x30	; 48	'0'
   1AB4 F0                  351 	.db #0xF0	; 240
   1AB5 3C                  352 	.db #0x3C	; 60
   1AB6 FC                  353 	.db #0xFC	; 252
   1AB7 03                  354 	.db #0x03	; 3
   1AB8 C3                  355 	.db #0xC3	; 195
   1AB9 0F                  356 	.db #0x0F	; 15
   1ABA CF                  357 	.db #0xCF	; 207
   1ABB 33                  358 	.db #0x33	; 51	'3'
   1ABC F3                  359 	.db #0xF3	; 243
   1ABD 3F                  360 	.db #0x3F	; 63
   1ABE FF                  361 	.db #0xFF	; 255
   1ABF                     362 _g_pixelMask:
   1ABF AA                  363 	.db #0xAA	; 170
   1AC0 55                  364 	.db #0x55	; 85	'U'
   1AC1                     365 _cells_in_view_array:
   1AC1 F0 BD               366 	.dw #0xBDF0
   1AC3                     367 _offsets_cells_in_view:
   1AC3 08                  368 	.db #0x08	; 8
   1AC4 0C                  369 	.db #0x0C	; 12
   1AC5 0E                  370 	.db #0x0E	; 14
   1AC6 0F                  371 	.db #0x0F	; 15
   1AC7 10                  372 	.db #0x10	; 16
                            373 ;src/Renderer.c:116: void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
                            374 ;	---------------------------------
                            375 ; Function draw_column_to_buffer_untextured
                            376 ; ---------------------------------
   1AC8                     377 _draw_column_to_buffer_untextured::
   1AC8 DD E5         [15]  378 	push	ix
   1ACA DD 21 00 00   [14]  379 	ld	ix,#0
   1ACE DD 39         [15]  380 	add	ix,sp
   1AD0 F5            [11]  381 	push	af
                            382 ;src/Renderer.c:117: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1AD1 DD 7E 04      [19]  383 	ld	a, 4 (ix)
   1AD4 CB 3F         [ 8]  384 	srl	a
   1AD6 C6 50         [ 7]  385 	add	a, #0x50
   1AD8 4F            [ 4]  386 	ld	c,a
   1AD9 3E 00         [ 7]  387 	ld	a,#0x00
   1ADB CE AA         [ 7]  388 	adc	a, #0xAA
   1ADD 47            [ 4]  389 	ld	b,a
                            390 ;src/Renderer.c:119: u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
   1ADE 11 AF 1A      [10]  391 	ld	de,#_g_colors+0
   1AE1 DD 6E 06      [19]  392 	ld	l,6 (ix)
   1AE4 26 00         [ 7]  393 	ld	h,#0x00
   1AE6 19            [11]  394 	add	hl,de
   1AE7 7E            [ 7]  395 	ld	a,(hl)
   1AE8 DD 77 FE      [19]  396 	ld	-2 (ix),a
                            397 ;src/Renderer.c:120: u8 pixMask = g_pixelMask[column&1];
   1AEB 11 BF 1A      [10]  398 	ld	de,#_g_pixelMask+0
   1AEE DD 7E 04      [19]  399 	ld	a,4 (ix)
   1AF1 E6 01         [ 7]  400 	and	a, #0x01
   1AF3 6F            [ 4]  401 	ld	l,a
   1AF4 26 00         [ 7]  402 	ld	h,#0x00
   1AF6 19            [11]  403 	add	hl,de
   1AF7 5E            [ 7]  404 	ld	e,(hl)
                            405 ;src/Renderer.c:129: if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
   1AF8 3E 64         [ 7]  406 	ld	a,#0x64
   1AFA DD 96 05      [19]  407 	sub	a, 5 (ix)
   1AFD 30 04         [12]  408 	jr	NC,00102$
   1AFF DD 36 05 64   [19]  409 	ld	5 (ix),#0x64
   1B03                     410 00102$:
                            411 ;src/Renderer.c:131: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   1B03 DD 6E 05      [19]  412 	ld	l,5 (ix)
   1B06 CB 3D         [ 8]  413 	srl	l
   1B08 3E 32         [ 7]  414 	ld	a,#0x32
   1B0A 95            [ 4]  415 	sub	a, l
                            416 ;src/Renderer.c:134: pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
   1B0B D5            [11]  417 	push	de
   1B0C 5F            [ 4]  418 	ld	e,a
   1B0D 16 00         [ 7]  419 	ld	d,#0x00
   1B0F 6B            [ 4]  420 	ld	l, e
   1B10 62            [ 4]  421 	ld	h, d
   1B11 29            [11]  422 	add	hl, hl
   1B12 29            [11]  423 	add	hl, hl
   1B13 19            [11]  424 	add	hl, de
   1B14 29            [11]  425 	add	hl, hl
   1B15 29            [11]  426 	add	hl, hl
   1B16 29            [11]  427 	add	hl, hl
   1B17 D1            [10]  428 	pop	de
   1B18 09            [11]  429 	add	hl,bc
   1B19 4D            [ 4]  430 	ld	c,l
   1B1A 44            [ 4]  431 	ld	b,h
                            432 ;src/Renderer.c:136: j=lineHeight;
   1B1B DD 56 05      [19]  433 	ld	d,5 (ix)
                            434 ;src/Renderer.c:138: for(j;j;--j){
   1B1E 7B            [ 4]  435 	ld	a,e
   1B1F 2F            [ 4]  436 	cpl
   1B20 DD 77 FF      [19]  437 	ld	-1 (ix),a
   1B23 7B            [ 4]  438 	ld	a,e
   1B24 DD A6 FE      [19]  439 	and	a, -2 (ix)
   1B27 5F            [ 4]  440 	ld	e,a
   1B28                     441 00105$:
   1B28 7A            [ 4]  442 	ld	a,d
   1B29 B7            [ 4]  443 	or	a, a
   1B2A 28 0F         [12]  444 	jr	Z,00107$
                            445 ;src/Renderer.c:139: val =  ((*pvmem)&(~pixMask));
   1B2C 0A            [ 7]  446 	ld	a,(bc)
   1B2D DD A6 FF      [19]  447 	and	a, -1 (ix)
                            448 ;src/Renderer.c:141: *pvmem = val|(w_color&pixMask);
   1B30 B3            [ 4]  449 	or	a, e
   1B31 02            [ 7]  450 	ld	(bc),a
                            451 ;src/Renderer.c:143: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   1B32 21 28 00      [10]  452 	ld	hl,#0x0028
   1B35 09            [11]  453 	add	hl,bc
   1B36 4D            [ 4]  454 	ld	c,l
   1B37 44            [ 4]  455 	ld	b,h
                            456 ;src/Renderer.c:138: for(j;j;--j){
   1B38 15            [ 4]  457 	dec	d
   1B39 18 ED         [12]  458 	jr	00105$
   1B3B                     459 00107$:
   1B3B DD F9         [10]  460 	ld	sp, ix
   1B3D DD E1         [14]  461 	pop	ix
   1B3F C9            [10]  462 	ret
                            463 ;src/Renderer.c:147: void draw_column_to_buffer_object(u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            464 ;	---------------------------------
                            465 ; Function draw_column_to_buffer_object
                            466 ; ---------------------------------
   1B40                     467 _draw_column_to_buffer_object::
   1B40 DD E5         [15]  468 	push	ix
   1B42 DD 21 00 00   [14]  469 	ld	ix,#0
   1B46 DD 39         [15]  470 	add	ix,sp
   1B48 21 F7 FF      [10]  471 	ld	hl,#-9
   1B4B 39            [11]  472 	add	hl,sp
   1B4C F9            [ 6]  473 	ld	sp,hl
                            474 ;src/Renderer.c:164: u16 texture_line=0;
   1B4D 21 00 00      [10]  475 	ld	hl,#0x0000
   1B50 E3            [19]  476 	ex	(sp), hl
                            477 ;src/Renderer.c:167: if(texture_column>=8 && texture_column<24){
   1B51 DD 7E 07      [19]  478 	ld	a,7 (ix)
   1B54 D6 08         [ 7]  479 	sub	a, #0x08
   1B56 DA 36 1C      [10]  480 	jp	C,00110$
   1B59 DD 7E 07      [19]  481 	ld	a,7 (ix)
   1B5C D6 18         [ 7]  482 	sub	a, #0x18
   1B5E D2 36 1C      [10]  483 	jp	NC,00110$
                            484 ;src/Renderer.c:169: index = index>>4;
   1B61 DD 7E 06      [19]  485 	ld	a,6 (ix)
   1B64 07            [ 4]  486 	rlca
   1B65 07            [ 4]  487 	rlca
   1B66 07            [ 4]  488 	rlca
   1B67 07            [ 4]  489 	rlca
   1B68 E6 0F         [ 7]  490 	and	a,#0x0F
                            491 ;src/Renderer.c:172: texture = (u8*)(UNCOMPRESSED_OBJECT_TEXTURES + ((ITEM_SPRITE_WIDTH*ITEM_SPRITE_HEIGHT)*(item_get_at(index-1)->type)) + ((texture_column-8)*ITEM_SPRITE_WIDTH));
   1B6A DD 77 06      [19]  492 	ld	6 (ix), a
   1B6D 47            [ 4]  493 	ld	b, a
   1B6E 05            [ 4]  494 	dec	b
   1B6F C5            [11]  495 	push	bc
   1B70 33            [ 6]  496 	inc	sp
   1B71 CD 00 0C      [17]  497 	call	_item_get_at
   1B74 33            [ 6]  498 	inc	sp
   1B75 23            [ 6]  499 	inc	hl
   1B76 23            [ 6]  500 	inc	hl
   1B77 23            [ 6]  501 	inc	hl
   1B78 46            [ 7]  502 	ld	b, (hl)
   1B79 0E 00         [ 7]  503 	ld	c,#0x00
   1B7B 21 50 A5      [10]  504 	ld	hl,#0xA550
   1B7E 09            [11]  505 	add	hl,bc
   1B7F 4D            [ 4]  506 	ld	c,l
   1B80 44            [ 4]  507 	ld	b,h
   1B81 DD 7E 07      [19]  508 	ld	a, 7 (ix)
   1B84 16 00         [ 7]  509 	ld	d, #0x00
   1B86 C6 F8         [ 7]  510 	add	a,#0xF8
   1B88 6F            [ 4]  511 	ld	l,a
   1B89 7A            [ 4]  512 	ld	a,d
   1B8A CE FF         [ 7]  513 	adc	a,#0xFF
   1B8C 67            [ 4]  514 	ld	h,a
   1B8D 29            [11]  515 	add	hl, hl
   1B8E 29            [11]  516 	add	hl, hl
   1B8F 29            [11]  517 	add	hl, hl
   1B90 29            [11]  518 	add	hl, hl
   1B91 09            [11]  519 	add	hl,bc
   1B92 DD 75 FB      [19]  520 	ld	-5 (ix),l
   1B95 DD 74 FC      [19]  521 	ld	-4 (ix),h
                            522 ;src/Renderer.c:174: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1B98 DD 7E 04      [19]  523 	ld	a, 4 (ix)
   1B9B CB 3F         [ 8]  524 	srl	a
   1B9D C6 50         [ 7]  525 	add	a, #0x50
   1B9F 4F            [ 4]  526 	ld	c,a
   1BA0 3E 00         [ 7]  527 	ld	a,#0x00
   1BA2 CE AA         [ 7]  528 	adc	a, #0xAA
   1BA4 47            [ 4]  529 	ld	b,a
                            530 ;src/Renderer.c:176: pixMask = g_pixelMask[column&1];
   1BA5 11 BF 1A      [10]  531 	ld	de,#_g_pixelMask+0
   1BA8 DD 7E 04      [19]  532 	ld	a,4 (ix)
   1BAB E6 01         [ 7]  533 	and	a, #0x01
   1BAD 6F            [ 4]  534 	ld	l,a
   1BAE 26 00         [ 7]  535 	ld	h,#0x00
   1BB0 19            [11]  536 	add	hl,de
   1BB1 7E            [ 7]  537 	ld	a,(hl)
   1BB2 DD 77 FD      [19]  538 	ld	-3 (ix),a
                            539 ;src/Renderer.c:178: lineHeight = (lineHeight)/2;
   1BB5 DD CB 05 3E   [23]  540 	srl	5 (ix)
                            541 ;src/Renderer.c:179: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight/2);
   1BB9 DD 7E 05      [19]  542 	ld	a,5 (ix)
   1BBC CB 3F         [ 8]  543 	srl	a
   1BBE C6 32         [ 7]  544 	add	a, #0x32
                            545 ;src/Renderer.c:180: item_top_height = ground_height - lineHeight;
   1BC0 DD 96 05      [19]  546 	sub	a, 5 (ix)
   1BC3 5F            [ 4]  547 	ld	e,a
                            548 ;src/Renderer.c:182: texture_line_add = (256*ITEM_SPRITE_HEIGHT)/lineHeight;
   1BC4 DD 6E 05      [19]  549 	ld	l,5 (ix)
   1BC7 26 00         [ 7]  550 	ld	h,#0x00
   1BC9 C5            [11]  551 	push	bc
   1BCA D5            [11]  552 	push	de
   1BCB E5            [11]  553 	push	hl
   1BCC 21 00 10      [10]  554 	ld	hl,#0x1000
   1BCF E5            [11]  555 	push	hl
   1BD0 CD 71 7C      [17]  556 	call	__divsint
   1BD3 F1            [10]  557 	pop	af
   1BD4 F1            [10]  558 	pop	af
   1BD5 D1            [10]  559 	pop	de
   1BD6 C1            [10]  560 	pop	bc
   1BD7 DD 75 F9      [19]  561 	ld	-7 (ix),l
   1BDA DD 74 FA      [19]  562 	ld	-6 (ix),h
                            563 ;src/Renderer.c:183: j=lineHeight;
   1BDD DD 7E 05      [19]  564 	ld	a,5 (ix)
   1BE0 DD 77 FE      [19]  565 	ld	-2 (ix),a
                            566 ;src/Renderer.c:189: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * item_top_height;
   1BE3 16 00         [ 7]  567 	ld	d,#0x00
   1BE5 6B            [ 4]  568 	ld	l, e
   1BE6 62            [ 4]  569 	ld	h, d
   1BE7 29            [11]  570 	add	hl, hl
   1BE8 29            [11]  571 	add	hl, hl
   1BE9 19            [11]  572 	add	hl, de
   1BEA 29            [11]  573 	add	hl, hl
   1BEB 29            [11]  574 	add	hl, hl
   1BEC 29            [11]  575 	add	hl, hl
   1BED 09            [11]  576 	add	hl,bc
   1BEE 4D            [ 4]  577 	ld	c,l
   1BEF 44            [ 4]  578 	ld	b,h
                            579 ;src/Renderer.c:191: for(j;j;--j){
   1BF0 DD 7E FD      [19]  580 	ld	a,-3 (ix)
   1BF3 2F            [ 4]  581 	cpl
   1BF4 DD 77 FF      [19]  582 	ld	-1 (ix),a
   1BF7                     583 00108$:
   1BF7 DD 7E FE      [19]  584 	ld	a,-2 (ix)
   1BFA B7            [ 4]  585 	or	a, a
   1BFB 28 39         [12]  586 	jr	Z,00110$
                            587 ;src/Renderer.c:193: color= *(texture+(texture_line/256));
   1BFD DD 5E F8      [19]  588 	ld	e,-8 (ix)
   1C00 16 00         [ 7]  589 	ld	d,#0x00
   1C02 DD 6E FB      [19]  590 	ld	l,-5 (ix)
   1C05 DD 66 FC      [19]  591 	ld	h,-4 (ix)
   1C08 19            [11]  592 	add	hl,de
   1C09 5E            [ 7]  593 	ld	e,(hl)
                            594 ;src/Renderer.c:195: if(color){
   1C0A 7B            [ 4]  595 	ld	a,e
   1C0B B7            [ 4]  596 	or	a, a
   1C0C 28 0B         [12]  597 	jr	Z,00102$
                            598 ;src/Renderer.c:196: val =  ((*pvmem)&(~pixMask));
   1C0E 0A            [ 7]  599 	ld	a,(bc)
   1C0F DD A6 FF      [19]  600 	and	a, -1 (ix)
   1C12 6F            [ 4]  601 	ld	l,a
                            602 ;src/Renderer.c:198: color = (color&pixMask);
   1C13 7B            [ 4]  603 	ld	a,e
   1C14 DD A6 FD      [19]  604 	and	a, -3 (ix)
                            605 ;src/Renderer.c:200: *pvmem = val|color;
   1C17 B5            [ 4]  606 	or	a, l
   1C18 02            [ 7]  607 	ld	(bc),a
   1C19                     608 00102$:
                            609 ;src/Renderer.c:203: texture_line += texture_line_add;
   1C19 DD 7E F7      [19]  610 	ld	a,-9 (ix)
   1C1C DD 86 F9      [19]  611 	add	a, -7 (ix)
   1C1F DD 77 F7      [19]  612 	ld	-9 (ix),a
   1C22 DD 7E F8      [19]  613 	ld	a,-8 (ix)
   1C25 DD 8E FA      [19]  614 	adc	a, -6 (ix)
   1C28 DD 77 F8      [19]  615 	ld	-8 (ix),a
                            616 ;src/Renderer.c:205: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   1C2B 21 28 00      [10]  617 	ld	hl,#0x0028
   1C2E 09            [11]  618 	add	hl,bc
   1C2F 4D            [ 4]  619 	ld	c,l
   1C30 44            [ 4]  620 	ld	b,h
                            621 ;src/Renderer.c:191: for(j;j;--j){
   1C31 DD 35 FE      [23]  622 	dec	-2 (ix)
   1C34 18 C1         [12]  623 	jr	00108$
   1C36                     624 00110$:
   1C36 DD F9         [10]  625 	ld	sp, ix
   1C38 DD E1         [14]  626 	pop	ix
   1C3A C9            [10]  627 	ret
                            628 ;src/Renderer.c:212: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            629 ;	---------------------------------
                            630 ; Function draw_column_to_buffer_enemy
                            631 ; ---------------------------------
   1C3B                     632 _draw_column_to_buffer_enemy::
   1C3B DD E5         [15]  633 	push	ix
   1C3D DD 21 00 00   [14]  634 	ld	ix,#0
   1C41 DD 39         [15]  635 	add	ix,sp
   1C43 21 F2 FF      [10]  636 	ld	hl,#-14
   1C46 39            [11]  637 	add	hl,sp
   1C47 F9            [ 6]  638 	ld	sp,hl
                            639 ;src/Renderer.c:229: u16 texture_line=0;
   1C48 DD 36 F7 00   [19]  640 	ld	-9 (ix),#0x00
   1C4C DD 36 F8 00   [19]  641 	ld	-8 (ix),#0x00
                            642 ;src/Renderer.c:231: if(texture_column>=4 && texture_column<28){
   1C50 DD 7E 07      [19]  643 	ld	a,7 (ix)
   1C53 D6 04         [ 7]  644 	sub	a, #0x04
   1C55 DA 7C 1D      [10]  645 	jp	C,00112$
   1C58 DD 7E 07      [19]  646 	ld	a,7 (ix)
   1C5B D6 1C         [ 7]  647 	sub	a, #0x1C
   1C5D D2 7C 1D      [10]  648 	jp	NC,00112$
                            649 ;src/Renderer.c:234: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(enemy_get_at(index-1)->type)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
   1C60 DD 46 06      [19]  650 	ld	b,6 (ix)
   1C63 05            [ 4]  651 	dec	b
   1C64 C5            [11]  652 	push	bc
   1C65 33            [ 6]  653 	inc	sp
   1C66 CD 40 00      [17]  654 	call	_enemy_get_at
   1C69 33            [ 6]  655 	inc	sp
   1C6A 23            [ 6]  656 	inc	hl
   1C6B 4E            [ 7]  657 	ld	c,(hl)
   1C6C 06 00         [ 7]  658 	ld	b,#0x00
   1C6E 69            [ 4]  659 	ld	l, c
   1C6F 60            [ 4]  660 	ld	h, b
   1C70 29            [11]  661 	add	hl, hl
   1C71 29            [11]  662 	add	hl, hl
   1C72 29            [11]  663 	add	hl, hl
   1C73 09            [11]  664 	add	hl, bc
   1C74 29            [11]  665 	add	hl, hl
   1C75 29            [11]  666 	add	hl, hl
   1C76 29            [11]  667 	add	hl, hl
   1C77 29            [11]  668 	add	hl, hl
   1C78 29            [11]  669 	add	hl, hl
   1C79 29            [11]  670 	add	hl, hl
   1C7A 01 D0 A0      [10]  671 	ld	bc,#0xA0D0
   1C7D 09            [11]  672 	add	hl,bc
   1C7E 4D            [ 4]  673 	ld	c,l
   1C7F 44            [ 4]  674 	ld	b,h
   1C80 DD 7E 07      [19]  675 	ld	a, 7 (ix)
   1C83 16 00         [ 7]  676 	ld	d, #0x00
   1C85 C6 FC         [ 7]  677 	add	a,#0xFC
   1C87 5F            [ 4]  678 	ld	e,a
   1C88 7A            [ 4]  679 	ld	a,d
   1C89 CE FF         [ 7]  680 	adc	a,#0xFF
   1C8B 57            [ 4]  681 	ld	d,a
   1C8C 6B            [ 4]  682 	ld	l, e
   1C8D 62            [ 4]  683 	ld	h, d
   1C8E 29            [11]  684 	add	hl, hl
   1C8F 19            [11]  685 	add	hl, de
   1C90 29            [11]  686 	add	hl, hl
   1C91 29            [11]  687 	add	hl, hl
   1C92 29            [11]  688 	add	hl, hl
   1C93 09            [11]  689 	add	hl,bc
   1C94 33            [ 6]  690 	inc	sp
   1C95 33            [ 6]  691 	inc	sp
   1C96 E5            [11]  692 	push	hl
                            693 ;src/Renderer.c:236: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1C97 DD 7E 04      [19]  694 	ld	a,4 (ix)
   1C9A CB 3F         [ 8]  695 	srl	a
   1C9C C6 50         [ 7]  696 	add	a, #0x50
   1C9E DD 77 FA      [19]  697 	ld	-6 (ix),a
   1CA1 3E 00         [ 7]  698 	ld	a,#0x00
   1CA3 CE AA         [ 7]  699 	adc	a, #0xAA
   1CA5 DD 77 FB      [19]  700 	ld	-5 (ix),a
                            701 ;src/Renderer.c:238: pixMask = g_pixelMask[column&1];
   1CA8 01 BF 1A      [10]  702 	ld	bc,#_g_pixelMask+0
   1CAB DD 7E 04      [19]  703 	ld	a,4 (ix)
   1CAE E6 01         [ 7]  704 	and	a, #0x01
   1CB0 6F            [ 4]  705 	ld	l, a
   1CB1 26 00         [ 7]  706 	ld	h,#0x00
   1CB3 09            [11]  707 	add	hl,bc
   1CB4 7E            [ 7]  708 	ld	a,(hl)
   1CB5 DD 77 F9      [19]  709 	ld	-7 (ix),a
                            710 ;src/Renderer.c:240: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
   1CB8 DD 7E 05      [19]  711 	ld	a,5 (ix)
   1CBB CB 3F         [ 8]  712 	srl	a
   1CBD C6 32         [ 7]  713 	add	a, #0x32
   1CBF DD 77 F4      [19]  714 	ld	-12 (ix),a
                            715 ;src/Renderer.c:241: lineHeight = (lineHeight*3)/4;
   1CC2 DD 4E 05      [19]  716 	ld	c,5 (ix)
   1CC5 06 00         [ 7]  717 	ld	b,#0x00
   1CC7 69            [ 4]  718 	ld	l, c
   1CC8 60            [ 4]  719 	ld	h, b
   1CC9 29            [11]  720 	add	hl, hl
   1CCA 09            [11]  721 	add	hl, bc
   1CCB DD 75 FE      [19]  722 	ld	-2 (ix),l
   1CCE DD 74 FF      [19]  723 	ld	-1 (ix),h
   1CD1 DD 7E FE      [19]  724 	ld	a,-2 (ix)
   1CD4 DD 77 FC      [19]  725 	ld	-4 (ix),a
   1CD7 DD 7E FF      [19]  726 	ld	a,-1 (ix)
   1CDA DD 77 FD      [19]  727 	ld	-3 (ix),a
   1CDD DD CB FF 7E   [20]  728 	bit	7, -1 (ix)
   1CE1 28 10         [12]  729 	jr	Z,00114$
   1CE3 DD 7E FE      [19]  730 	ld	a,-2 (ix)
   1CE6 C6 03         [ 7]  731 	add	a, #0x03
   1CE8 DD 77 FC      [19]  732 	ld	-4 (ix),a
   1CEB DD 7E FF      [19]  733 	ld	a,-1 (ix)
   1CEE CE 00         [ 7]  734 	adc	a, #0x00
   1CF0 DD 77 FD      [19]  735 	ld	-3 (ix),a
   1CF3                     736 00114$:
   1CF3 DD 46 FC      [19]  737 	ld	b,-4 (ix)
   1CF6 DD 4E FD      [19]  738 	ld	c,-3 (ix)
   1CF9 CB 29         [ 8]  739 	sra	c
   1CFB CB 18         [ 8]  740 	rr	b
   1CFD CB 29         [ 8]  741 	sra	c
   1CFF CB 18         [ 8]  742 	rr	b
                            743 ;src/Renderer.c:242: enemy_top_height = ground_height - lineHeight;
   1D01 DD 7E F4      [19]  744 	ld	a,-12 (ix)
   1D04 90            [ 4]  745 	sub	a, b
   1D05 4F            [ 4]  746 	ld	c,a
                            747 ;src/Renderer.c:244: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
   1D06 58            [ 4]  748 	ld	e,b
   1D07 16 00         [ 7]  749 	ld	d,#0x00
   1D09 C5            [11]  750 	push	bc
   1D0A D5            [11]  751 	push	de
   1D0B 21 00 18      [10]  752 	ld	hl,#0x1800
   1D0E E5            [11]  753 	push	hl
   1D0F CD 71 7C      [17]  754 	call	__divsint
   1D12 F1            [10]  755 	pop	af
   1D13 F1            [10]  756 	pop	af
   1D14 C1            [10]  757 	pop	bc
   1D15 DD 75 F5      [19]  758 	ld	-11 (ix),l
   1D18 DD 74 F6      [19]  759 	ld	-10 (ix),h
                            760 ;src/Renderer.c:245: j=lineHeight;
   1D1B 50            [ 4]  761 	ld	d,b
                            762 ;src/Renderer.c:247: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   1D1C 3E 64         [ 7]  763 	ld	a,#0x64
   1D1E 90            [ 4]  764 	sub	a, b
   1D1F 30 02         [12]  765 	jr	NC,00102$
                            766 ;src/Renderer.c:248: j=90;
   1D21 16 5A         [ 7]  767 	ld	d,#0x5A
   1D23                     768 00102$:
                            769 ;src/Renderer.c:251: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
   1D23 06 00         [ 7]  770 	ld	b,#0x00
   1D25 69            [ 4]  771 	ld	l, c
   1D26 60            [ 4]  772 	ld	h, b
   1D27 29            [11]  773 	add	hl, hl
   1D28 29            [11]  774 	add	hl, hl
   1D29 09            [11]  775 	add	hl, bc
   1D2A 29            [11]  776 	add	hl, hl
   1D2B 29            [11]  777 	add	hl, hl
   1D2C 29            [11]  778 	add	hl, hl
   1D2D DD 7E FA      [19]  779 	ld	a,-6 (ix)
   1D30 85            [ 4]  780 	add	a, l
   1D31 4F            [ 4]  781 	ld	c,a
   1D32 DD 7E FB      [19]  782 	ld	a,-5 (ix)
   1D35 8C            [ 4]  783 	adc	a, h
   1D36 47            [ 4]  784 	ld	b,a
                            785 ;src/Renderer.c:253: for(j;j;--j){
   1D37 DD 7E F9      [19]  786 	ld	a,-7 (ix)
   1D3A 2F            [ 4]  787 	cpl
   1D3B 5F            [ 4]  788 	ld	e,a
   1D3C                     789 00110$:
   1D3C 7A            [ 4]  790 	ld	a,d
   1D3D B7            [ 4]  791 	or	a, a
   1D3E 28 3C         [12]  792 	jr	Z,00112$
                            793 ;src/Renderer.c:255: color= *(texture+(texture_line/256));
   1D40 DD 6E F8      [19]  794 	ld	l,-8 (ix)
   1D43 26 00         [ 7]  795 	ld	h,#0x00
   1D45 DD 7E F2      [19]  796 	ld	a,-14 (ix)
   1D48 85            [ 4]  797 	add	a, l
   1D49 6F            [ 4]  798 	ld	l,a
   1D4A DD 7E F3      [19]  799 	ld	a,-13 (ix)
   1D4D 8C            [ 4]  800 	adc	a, h
   1D4E 67            [ 4]  801 	ld	h,a
   1D4F 7E            [ 7]  802 	ld	a,(hl)
                            803 ;src/Renderer.c:257: if(color){
   1D50 DD 77 FC      [19]  804 	ld	-4 (ix), a
   1D53 B7            [ 4]  805 	or	a, a
   1D54 28 0B         [12]  806 	jr	Z,00104$
                            807 ;src/Renderer.c:258: val =  ((*pvmem)&(~pixMask));
   1D56 0A            [ 7]  808 	ld	a,(bc)
   1D57 A3            [ 4]  809 	and	a, e
   1D58 6F            [ 4]  810 	ld	l,a
                            811 ;src/Renderer.c:260: color = (color&pixMask);
   1D59 DD 7E FC      [19]  812 	ld	a,-4 (ix)
   1D5C DD A6 F9      [19]  813 	and	a, -7 (ix)
                            814 ;src/Renderer.c:262: *pvmem = val|color;
   1D5F B5            [ 4]  815 	or	a, l
   1D60 02            [ 7]  816 	ld	(bc),a
   1D61                     817 00104$:
                            818 ;src/Renderer.c:265: texture_line += texture_line_add;
   1D61 DD 7E F7      [19]  819 	ld	a,-9 (ix)
   1D64 DD 86 F5      [19]  820 	add	a, -11 (ix)
   1D67 DD 77 F7      [19]  821 	ld	-9 (ix),a
   1D6A DD 7E F8      [19]  822 	ld	a,-8 (ix)
   1D6D DD 8E F6      [19]  823 	adc	a, -10 (ix)
   1D70 DD 77 F8      [19]  824 	ld	-8 (ix),a
                            825 ;src/Renderer.c:267: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   1D73 21 28 00      [10]  826 	ld	hl,#0x0028
   1D76 09            [11]  827 	add	hl,bc
   1D77 4D            [ 4]  828 	ld	c,l
   1D78 44            [ 4]  829 	ld	b,h
                            830 ;src/Renderer.c:253: for(j;j;--j){
   1D79 15            [ 4]  831 	dec	d
   1D7A 18 C0         [12]  832 	jr	00110$
   1D7C                     833 00112$:
   1D7C DD F9         [10]  834 	ld	sp, ix
   1D7E DD E1         [14]  835 	pop	ix
   1D80 C9            [10]  836 	ret
                            837 ;src/Renderer.c:359: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
                            838 ;	---------------------------------
                            839 ; Function draw_column_to_buffer
                            840 ; ---------------------------------
   1D81                     841 _draw_column_to_buffer::
   1D81 DD E5         [15]  842 	push	ix
   1D83 DD 21 00 00   [14]  843 	ld	ix,#0
   1D87 DD 39         [15]  844 	add	ix,sp
   1D89 21 F1 FF      [10]  845 	ld	hl,#-15
   1D8C 39            [11]  846 	add	hl,sp
   1D8D F9            [ 6]  847 	ld	sp,hl
                            848 ;src/Renderer.c:360: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1D8E DD 7E 04      [19]  849 	ld	a,4 (ix)
   1D91 CB 3F         [ 8]  850 	srl	a
   1D93 C6 50         [ 7]  851 	add	a, #0x50
   1D95 DD 77 FA      [19]  852 	ld	-6 (ix),a
   1D98 3E 00         [ 7]  853 	ld	a,#0x00
   1D9A CE AA         [ 7]  854 	adc	a, #0xAA
   1D9C DD 77 FB      [19]  855 	ld	-5 (ix),a
                            856 ;src/Renderer.c:363: u8 pixMask = g_pixelMask[column&1];
   1D9F 01 BF 1A      [10]  857 	ld	bc,#_g_pixelMask+0
   1DA2 DD 7E 04      [19]  858 	ld	a,4 (ix)
   1DA5 E6 01         [ 7]  859 	and	a, #0x01
   1DA7 6F            [ 4]  860 	ld	l, a
   1DA8 26 00         [ 7]  861 	ld	h,#0x00
   1DAA 09            [11]  862 	add	hl,bc
   1DAB 7E            [ 7]  863 	ld	a,(hl)
   1DAC DD 77 F3      [19]  864 	ld	-13 (ix),a
                            865 ;src/Renderer.c:368: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
   1DAF DD 7E 06      [19]  866 	ld	a, 6 (ix)
   1DB2 87            [ 4]  867 	add	a, a
   1DB3 87            [ 4]  868 	add	a, a
   1DB4 47            [ 4]  869 	ld	b,a
   1DB5 0E 00         [ 7]  870 	ld	c,#0x00
   1DB7 21 D0 8C      [10]  871 	ld	hl,#0x8CD0
   1DBA 09            [11]  872 	add	hl,bc
   1DBB 4D            [ 4]  873 	ld	c,l
   1DBC 44            [ 4]  874 	ld	b,h
   1DBD DD 6E 07      [19]  875 	ld	l,7 (ix)
   1DC0 26 00         [ 7]  876 	ld	h,#0x00
   1DC2 29            [11]  877 	add	hl, hl
   1DC3 29            [11]  878 	add	hl, hl
   1DC4 29            [11]  879 	add	hl, hl
   1DC5 29            [11]  880 	add	hl, hl
   1DC6 29            [11]  881 	add	hl, hl
   1DC7 09            [11]  882 	add	hl,bc
   1DC8 DD 75 F6      [19]  883 	ld	-10 (ix),l
   1DCB DD 74 F7      [19]  884 	ld	-9 (ix),h
                            885 ;src/Renderer.c:370: u8 j=lineHeight;
   1DCE DD 7E 05      [19]  886 	ld	a,5 (ix)
                            887 ;src/Renderer.c:376: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
   1DD1 DD 77 F5      [19]  888 	ld	-11 (ix), a
   1DD4 DD 77 FE      [19]  889 	ld	-2 (ix),a
   1DD7 DD 36 FF 00   [19]  890 	ld	-1 (ix),#0x00
   1DDB DD 6E FE      [19]  891 	ld	l,-2 (ix)
   1DDE DD 66 FF      [19]  892 	ld	h,-1 (ix)
   1DE1 E5            [11]  893 	push	hl
   1DE2 21 00 20      [10]  894 	ld	hl,#0x2000
   1DE5 E5            [11]  895 	push	hl
   1DE6 CD 71 7C      [17]  896 	call	__divsint
   1DE9 F1            [10]  897 	pop	af
   1DEA F1            [10]  898 	pop	af
   1DEB DD 75 F8      [19]  899 	ld	-8 (ix),l
   1DEE DD 74 F9      [19]  900 	ld	-7 (ix),h
                            901 ;src/Renderer.c:377: u16 wall_texture_line=0;
   1DF1 21 00 00      [10]  902 	ld	hl,#0x0000
   1DF4 E3            [19]  903 	ex	(sp), hl
                            904 ;src/Renderer.c:379: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   1DF5 DD 4E F5      [19]  905 	ld	c,-11 (ix)
   1DF8 CB 39         [ 8]  906 	srl	c
   1DFA 3E 32         [ 7]  907 	ld	a,#0x32
   1DFC 91            [ 4]  908 	sub	a, c
   1DFD DD 77 F4      [19]  909 	ld	-12 (ix),a
                            910 ;src/Renderer.c:383: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   1E00 3E 64         [ 7]  911 	ld	a,#0x64
   1E02 DD 96 F5      [19]  912 	sub	a, -11 (ix)
   1E05 30 48         [12]  913 	jr	NC,00102$
                            914 ;src/Renderer.c:384: ceiling_height=0;
   1E07 DD 36 F4 00   [19]  915 	ld	-12 (ix),#0x00
                            916 ;src/Renderer.c:385: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
   1E0B DD 7E FE      [19]  917 	ld	a,-2 (ix)
   1E0E C6 9C         [ 7]  918 	add	a,#0x9C
   1E10 4F            [ 4]  919 	ld	c,a
   1E11 DD 7E FF      [19]  920 	ld	a,-1 (ix)
   1E14 CE FF         [ 7]  921 	adc	a,#0xFF
   1E16 47            [ 4]  922 	ld	b,a
   1E17 DD 71 FC      [19]  923 	ld	-4 (ix),c
   1E1A DD 70 FD      [19]  924 	ld	-3 (ix),b
   1E1D CB 78         [ 8]  925 	bit	7, b
   1E1F 28 10         [12]  926 	jr	Z,00111$
   1E21 DD 7E FE      [19]  927 	ld	a,-2 (ix)
   1E24 C6 9D         [ 7]  928 	add	a, #0x9D
   1E26 DD 77 FC      [19]  929 	ld	-4 (ix),a
   1E29 DD 7E FF      [19]  930 	ld	a,-1 (ix)
   1E2C CE FF         [ 7]  931 	adc	a, #0xFF
   1E2E DD 77 FD      [19]  932 	ld	-3 (ix),a
   1E31                     933 00111$:
   1E31 DD 4E FC      [19]  934 	ld	c,-4 (ix)
   1E34 DD 46 FD      [19]  935 	ld	b,-3 (ix)
   1E37 CB 28         [ 8]  936 	sra	b
   1E39 CB 19         [ 8]  937 	rr	c
   1E3B DD 6E F8      [19]  938 	ld	l,-8 (ix)
   1E3E DD 66 F9      [19]  939 	ld	h,-7 (ix)
   1E41 E5            [11]  940 	push	hl
   1E42 C5            [11]  941 	push	bc
   1E43 CD 6D 7A      [17]  942 	call	__mulint
   1E46 F1            [10]  943 	pop	af
   1E47 F1            [10]  944 	pop	af
   1E48 33            [ 6]  945 	inc	sp
   1E49 33            [ 6]  946 	inc	sp
   1E4A E5            [11]  947 	push	hl
                            948 ;src/Renderer.c:386: j=SCREEN_TEXTURE_HEIGHT;
   1E4B DD 36 F5 64   [19]  949 	ld	-11 (ix),#0x64
   1E4F                     950 00102$:
                            951 ;src/Renderer.c:389: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
   1E4F DD 4E F4      [19]  952 	ld	c,-12 (ix)
   1E52 06 00         [ 7]  953 	ld	b,#0x00
   1E54 69            [ 4]  954 	ld	l, c
   1E55 60            [ 4]  955 	ld	h, b
   1E56 29            [11]  956 	add	hl, hl
   1E57 29            [11]  957 	add	hl, hl
   1E58 09            [11]  958 	add	hl, bc
   1E59 29            [11]  959 	add	hl, hl
   1E5A 29            [11]  960 	add	hl, hl
   1E5B 29            [11]  961 	add	hl, hl
   1E5C DD 7E FA      [19]  962 	ld	a,-6 (ix)
   1E5F 85            [ 4]  963 	add	a, l
   1E60 4F            [ 4]  964 	ld	c,a
   1E61 DD 7E FB      [19]  965 	ld	a,-5 (ix)
   1E64 8C            [ 4]  966 	adc	a, h
   1E65 47            [ 4]  967 	ld	b,a
                            968 ;src/Renderer.c:391: for(j;j;--j){
   1E66 DD 7E F3      [19]  969 	ld	a,-13 (ix)
   1E69 2F            [ 4]  970 	cpl
   1E6A DD 77 FC      [19]  971 	ld	-4 (ix),a
   1E6D DD 56 F5      [19]  972 	ld	d,-11 (ix)
   1E70                     973 00107$:
   1E70 7A            [ 4]  974 	ld	a,d
   1E71 B7            [ 4]  975 	or	a, a
   1E72 28 39         [12]  976 	jr	Z,00109$
                            977 ;src/Renderer.c:393: w_color = *(texture+(wall_texture_line/256));
   1E74 DD 7E F2      [19]  978 	ld	a, -14 (ix)
   1E77 26 00         [ 7]  979 	ld	h, #0x00
   1E79 DD 86 F6      [19]  980 	add	a, -10 (ix)
   1E7C 6F            [ 4]  981 	ld	l,a
   1E7D 7C            [ 4]  982 	ld	a,h
   1E7E DD 8E F7      [19]  983 	adc	a, -9 (ix)
   1E81 67            [ 4]  984 	ld	h,a
   1E82 5E            [ 7]  985 	ld	e,(hl)
                            986 ;src/Renderer.c:395: if(w_color){
   1E83 7B            [ 4]  987 	ld	a,e
   1E84 B7            [ 4]  988 	or	a, a
   1E85 28 0B         [12]  989 	jr	Z,00104$
                            990 ;src/Renderer.c:397: val =  ((*pvmem)&(~pixMask));
   1E87 0A            [ 7]  991 	ld	a,(bc)
   1E88 DD A6 FC      [19]  992 	and	a, -4 (ix)
   1E8B 6F            [ 4]  993 	ld	l,a
                            994 ;src/Renderer.c:399: w_color = (w_color&pixMask);
   1E8C 7B            [ 4]  995 	ld	a,e
   1E8D DD A6 F3      [19]  996 	and	a, -13 (ix)
                            997 ;src/Renderer.c:401: *pvmem = val|w_color;
   1E90 B5            [ 4]  998 	or	a, l
   1E91 02            [ 7]  999 	ld	(bc),a
   1E92                    1000 00104$:
                           1001 ;src/Renderer.c:405: wall_texture_line += wall_texture_line_add;
   1E92 DD 7E F1      [19] 1002 	ld	a,-15 (ix)
   1E95 DD 86 F8      [19] 1003 	add	a, -8 (ix)
   1E98 DD 77 F1      [19] 1004 	ld	-15 (ix),a
   1E9B DD 7E F2      [19] 1005 	ld	a,-14 (ix)
   1E9E DD 8E F9      [19] 1006 	adc	a, -7 (ix)
   1EA1 DD 77 F2      [19] 1007 	ld	-14 (ix),a
                           1008 ;src/Renderer.c:407: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   1EA4 21 28 00      [10] 1009 	ld	hl,#0x0028
   1EA7 09            [11] 1010 	add	hl,bc
   1EA8 4D            [ 4] 1011 	ld	c,l
   1EA9 44            [ 4] 1012 	ld	b,h
                           1013 ;src/Renderer.c:391: for(j;j;--j){
   1EAA 15            [ 4] 1014 	dec	d
   1EAB 18 C3         [12] 1015 	jr	00107$
   1EAD                    1016 00109$:
   1EAD DD F9         [10] 1017 	ld	sp, ix
   1EAF DD E1         [14] 1018 	pop	ix
   1EB1 C9            [10] 1019 	ret
                           1020 ;src/Renderer.c:411: void render_draw_to_buffer(){//TODO Optimize
                           1021 ;	---------------------------------
                           1022 ; Function render_draw_to_buffer
                           1023 ; ---------------------------------
   1EB2                    1024 _render_draw_to_buffer::
   1EB2 DD E5         [15] 1025 	push	ix
   1EB4 DD 21 00 00   [14] 1026 	ld	ix,#0
   1EB8 DD 39         [15] 1027 	add	ix,sp
   1EBA 21 C6 FF      [10] 1028 	ld	hl,#-58
   1EBD 39            [11] 1029 	add	hl,sp
   1EBE F9            [ 6] 1030 	ld	sp,hl
                           1031 ;src/Renderer.c:423: u8 zHeight = 5;
   1EBF DD 36 D2 05   [19] 1032 	ld	-46 (ix),#0x05
                           1033 ;src/Renderer.c:433: u8 offsetDiff = 16;
   1EC3 DD 36 CF 10   [19] 1034 	ld	-49 (ix),#0x10
                           1035 ;src/Renderer.c:438: u8 lineStart = 0;
   1EC7 DD 36 C7 00   [19] 1036 	ld	-57 (ix),#0x00
                           1037 ;src/Renderer.c:440: u8 lateralWallWidth=0;
   1ECB DD 36 CE 00   [19] 1038 	ld	-50 (ix),#0x00
                           1039 ;src/Renderer.c:452: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   1ECF 21 B6 1A      [10] 1040 	ld	hl, #_g_colors + 7
   1ED2 46            [ 7] 1041 	ld	b,(hl)
   1ED3 21 A8 07      [10] 1042 	ld	hl,#0x07A8
   1ED6 E5            [11] 1043 	push	hl
   1ED7 C5            [11] 1044 	push	bc
   1ED8 33            [ 6] 1045 	inc	sp
   1ED9 21 50 AA      [10] 1046 	ld	hl,#0xAA50
   1EDC E5            [11] 1047 	push	hl
   1EDD CD 9A 7B      [17] 1048 	call	_cpct_memset
                           1049 ;src/Renderer.c:453: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
   1EE0 21 B0 1A      [10] 1050 	ld	hl, #_g_colors + 1
   1EE3 46            [ 7] 1051 	ld	b,(hl)
   1EE4 21 50 00      [10] 1052 	ld	hl,#0x0050
   1EE7 E5            [11] 1053 	push	hl
   1EE8 C5            [11] 1054 	push	bc
   1EE9 33            [ 6] 1055 	inc	sp
   1EEA 21 F8 B1      [10] 1056 	ld	hl,#0xB1F8
   1EED E5            [11] 1057 	push	hl
   1EEE CD 9A 7B      [17] 1058 	call	_cpct_memset
                           1059 ;src/Renderer.c:454: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   1EF1 21 B7 1A      [10] 1060 	ld	hl, #_g_colors + 8
   1EF4 46            [ 7] 1061 	ld	b,(hl)
   1EF5 21 A8 07      [10] 1062 	ld	hl,#0x07A8
   1EF8 E5            [11] 1063 	push	hl
   1EF9 C5            [11] 1064 	push	bc
   1EFA 33            [ 6] 1065 	inc	sp
   1EFB 21 48 B2      [10] 1066 	ld	hl,#0xB248
   1EFE E5            [11] 1067 	push	hl
   1EFF CD 9A 7B      [17] 1068 	call	_cpct_memset
                           1069 ;src/Renderer.c:456: calculate_cells_in_view();
   1F02 CD EE 18      [17] 1070 	call	_calculate_cells_in_view
                           1071 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   1F05 2A C1 1A      [16] 1072 	ld	hl,(_cells_in_view_array)
   1F08 DD 75 E7      [19] 1073 	ld	-25 (ix),l
   1F0B DD 74 E8      [19] 1074 	ld	-24 (ix),h
                           1075 ;src/Renderer.c:458: if(textures_on){
   1F0E 3A 61 7D      [13] 1076 	ld	a,(#_textures_on + 0)
   1F11 B7            [ 4] 1077 	or	a, a
   1F12 CA 90 24      [10] 1078 	jp	Z,00370$
                           1079 ;src/Renderer.c:460: do{
   1F15 DD 36 CA 06   [19] 1080 	ld	-54 (ix),#0x06
   1F19                    1081 00179$:
                           1082 ;src/Renderer.c:462: --z;
   1F19 DD 35 CA      [23] 1083 	dec	-54 (ix)
                           1084 ;src/Renderer.c:466: xCellCount = (z) ? (zHeight >> 1) : 0;
   1F1C DD 7E D2      [19] 1085 	ld	a,-46 (ix)
   1F1F CB 3F         [ 8] 1086 	srl	a
   1F21 DD 77 EB      [19] 1087 	ld	-21 (ix),a
   1F24 DD 7E CA      [19] 1088 	ld	a,-54 (ix)
   1F27 B7            [ 4] 1089 	or	a, a
   1F28 28 05         [12] 1090 	jr	Z,00270$
   1F2A DD 4E EB      [19] 1091 	ld	c,-21 (ix)
   1F2D 18 02         [12] 1092 	jr	00271$
   1F2F                    1093 00270$:
   1F2F 0E 00         [ 7] 1094 	ld	c,#0x00
   1F31                    1095 00271$:
   1F31 DD 71 EE      [19] 1096 	ld	-18 (ix),c
                           1097 ;src/Renderer.c:467: lateralWallSlope=0;
   1F34 DD 36 F0 00   [19] 1098 	ld	-16 (ix),#0x00
                           1099 ;src/Renderer.c:468: lateralWallSlopeCounter=0;
   1F38 DD 36 F9 00   [19] 1100 	ld	-7 (ix),#0x00
                           1101 ;src/Renderer.c:469: xHeight=0;
   1F3C DD 36 DA 00   [19] 1102 	ld	-38 (ix),#0x00
                           1103 ;src/Renderer.c:472: lateralWallCounter = 0;
   1F40 DD 36 D9 00   [19] 1104 	ld	-39 (ix),#0x00
                           1105 ;src/Renderer.c:474: newCell=1;
   1F44 DD 36 DC 01   [19] 1106 	ld	-36 (ix),#0x01
                           1107 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   1F48 DD 7E C7      [19] 1108 	ld	a,-57 (ix)
   1F4B DD 77 E3      [19] 1109 	ld	-29 (ix),a
   1F4E DD 36 E4 00   [19] 1110 	ld	-28 (ix),#0x00
   1F52 DD 4E E3      [19] 1111 	ld	c,-29 (ix)
   1F55 DD 46 E4      [19] 1112 	ld	b,-28 (ix)
   1F58 03            [ 6] 1113 	inc	bc
   1F59 DD 6E E7      [19] 1114 	ld	l,-25 (ix)
   1F5C DD 66 E8      [19] 1115 	ld	h,-24 (ix)
   1F5F 09            [11] 1116 	add	hl,bc
   1F60 7E            [ 7] 1117 	ld	a,(hl)
   1F61 DD 77 DB      [19] 1118 	ld	-37 (ix),a
                           1119 ;src/Renderer.c:477: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   1F64 DD 7E E7      [19] 1120 	ld	a,-25 (ix)
   1F67 DD 86 C7      [19] 1121 	add	a, -57 (ix)
   1F6A 6F            [ 4] 1122 	ld	l,a
   1F6B DD 7E E8      [19] 1123 	ld	a,-24 (ix)
   1F6E CE 00         [ 7] 1124 	adc	a, #0x00
   1F70 67            [ 4] 1125 	ld	h,a
   1F71 4E            [ 7] 1126 	ld	c,(hl)
                           1127 ;src/Renderer.c:478: if(lastCellWasWall&CELL_WALL_MASK){
   1F72 CB 79         [ 8] 1128 	bit	7, c
   1F74 28 09         [12] 1129 	jr	Z,00102$
                           1130 ;src/Renderer.c:479: lastWallId=lastCellWasWall;
   1F76 DD 71 D7      [19] 1131 	ld	-41 (ix),c
                           1132 ;src/Renderer.c:480: lastCellWasWall=1;
   1F79 DD 36 EF 01   [19] 1133 	ld	-17 (ix),#0x01
   1F7D 18 08         [12] 1134 	jr	00305$
   1F7F                    1135 00102$:
                           1136 ;src/Renderer.c:483: lastCellWasWall=0;
   1F7F DD 36 EF 00   [19] 1137 	ld	-17 (ix),#0x00
                           1138 ;src/Renderer.c:484: lastWallId=CELLTYPE_FLOOR;
   1F83 DD 36 D7 00   [19] 1139 	ld	-41 (ix),#0x00
                           1140 ;src/Renderer.c:487: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   1F87                    1141 00305$:
   1F87 DD 36 D1 00   [19] 1142 	ld	-47 (ix),#0x00
   1F8B DD 36 D3 00   [19] 1143 	ld	-45 (ix),#0x00
   1F8F                    1144 00260$:
                           1145 ;src/Renderer.c:489: if (xCellCount == zHeight)
   1F8F DD 7E D2      [19] 1146 	ld	a,-46 (ix)
   1F92 DD 96 EE      [19] 1147 	sub	a, -18 (ix)
   1F95 20 4B         [12] 1148 	jr	NZ,00105$
                           1149 ;src/Renderer.c:491: ++xCell;
   1F97 DD 34 D1      [23] 1150 	inc	-47 (ix)
                           1151 ;src/Renderer.c:492: xCellCount = 0;
   1F9A DD 36 EE 00   [19] 1152 	ld	-18 (ix),#0x00
                           1153 ;src/Renderer.c:493: newCell=1;
   1F9E DD 36 DC 01   [19] 1154 	ld	-36 (ix),#0x01
                           1155 ;src/Renderer.c:494: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   1FA2 DD 7E D1      [19] 1156 	ld	a,-47 (ix)
   1FA5 DD 77 F5      [19] 1157 	ld	-11 (ix),a
   1FA8 DD 36 F6 00   [19] 1158 	ld	-10 (ix),#0x00
   1FAC DD 7E E3      [19] 1159 	ld	a,-29 (ix)
   1FAF DD 86 F5      [19] 1160 	add	a, -11 (ix)
   1FB2 DD 77 F5      [19] 1161 	ld	-11 (ix),a
   1FB5 DD 7E E4      [19] 1162 	ld	a,-28 (ix)
   1FB8 DD 8E F6      [19] 1163 	adc	a, -10 (ix)
   1FBB DD 77 F6      [19] 1164 	ld	-10 (ix),a
   1FBE DD 34 F5      [23] 1165 	inc	-11 (ix)
   1FC1 20 03         [12] 1166 	jr	NZ,00632$
   1FC3 DD 34 F6      [23] 1167 	inc	-10 (ix)
   1FC6                    1168 00632$:
   1FC6 DD 7E E7      [19] 1169 	ld	a,-25 (ix)
   1FC9 DD 86 F5      [19] 1170 	add	a, -11 (ix)
   1FCC DD 77 F5      [19] 1171 	ld	-11 (ix),a
   1FCF DD 7E E8      [19] 1172 	ld	a,-24 (ix)
   1FD2 DD 8E F6      [19] 1173 	adc	a, -10 (ix)
   1FD5 DD 77 F6      [19] 1174 	ld	-10 (ix),a
   1FD8 DD 6E F5      [19] 1175 	ld	l,-11 (ix)
   1FDB DD 66 F6      [19] 1176 	ld	h,-10 (ix)
   1FDE 7E            [ 7] 1177 	ld	a,(hl)
   1FDF DD 77 DB      [19] 1178 	ld	-37 (ix),a
   1FE2                    1179 00105$:
                           1180 ;src/Renderer.c:496: if(!(x%2)){
   1FE2 DD 7E D3      [19] 1181 	ld	a,-45 (ix)
   1FE5 E6 01         [ 7] 1182 	and	a, #0x01
   1FE7 DD 77 F5      [19] 1183 	ld	-11 (ix),a
                           1184 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   1FEA DD 7E DB      [19] 1185 	ld	a,-37 (ix)
   1FED E6 80         [ 7] 1186 	and	a, #0x80
   1FEF DD 77 D8      [19] 1187 	ld	-40 (ix),a
                           1188 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   1FF2 DD 7E EE      [19] 1189 	ld	a,-18 (ix)
   1FF5 DD 77 E5      [19] 1190 	ld	-27 (ix),a
   1FF8 DD 36 E6 00   [19] 1191 	ld	-26 (ix),#0x00
   1FFC DD 7E D2      [19] 1192 	ld	a,-46 (ix)
   1FFF DD 77 E9      [19] 1193 	ld	-23 (ix),a
                           1194 ;src/Renderer.c:496: if(!(x%2)){
   2002 DD 7E F5      [19] 1195 	ld	a,-11 (ix)
   2005 B7            [ 4] 1196 	or	a, a
   2006 C2 B9 20      [10] 1197 	jp	NZ,00118$
                           1198 ;src/Renderer.c:497: if ((lateralWallCounter == 0)||newCell)
   2009 DD 7E D9      [19] 1199 	ld	a,-39 (ix)
   200C B7            [ 4] 1200 	or	a, a
   200D 28 07         [12] 1201 	jr	Z,00114$
   200F DD 7E DC      [19] 1202 	ld	a,-36 (ix)
   2012 B7            [ 4] 1203 	or	a, a
   2013 CA B9 20      [10] 1204 	jp	Z,00118$
   2016                    1205 00114$:
                           1206 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   2016 DD 7E D8      [19] 1207 	ld	a,-40 (ix)
   2019 B7            [ 4] 1208 	or	a, a
   201A 28 22         [12] 1209 	jr	Z,00112$
                           1210 ;src/Renderer.c:501: lateralWallCounter = 0;//(zHeight - xCellCount);
   201C DD 36 D9 00   [19] 1211 	ld	-39 (ix),#0x00
                           1212 ;src/Renderer.c:502: lateralWallSlope = 0;
   2020 DD 36 F0 00   [19] 1213 	ld	-16 (ix),#0x00
                           1214 ;src/Renderer.c:503: xHeight = zHeight;
   2024 DD 7E D2      [19] 1215 	ld	a,-46 (ix)
   2027 DD 77 DA      [19] 1216 	ld	-38 (ix),a
                           1217 ;src/Renderer.c:504: color = currentCellID&0b01111111;
   202A DD 7E DB      [19] 1218 	ld	a,-37 (ix)
   202D E6 7F         [ 7] 1219 	and	a, #0x7F
   202F DD 77 EA      [19] 1220 	ld	-22 (ix),a
                           1221 ;src/Renderer.c:505: lastCellWasWall = 1;
   2032 DD 36 EF 01   [19] 1222 	ld	-17 (ix),#0x01
                           1223 ;src/Renderer.c:506: lastWallId=currentCellID;
   2036 DD 7E DB      [19] 1224 	ld	a,-37 (ix)
   2039 DD 77 D7      [19] 1225 	ld	-41 (ix),a
   203C 18 77         [12] 1226 	jr	00113$
   203E                    1227 00112$:
                           1228 ;src/Renderer.c:509: if(lateralWallCounter==0){//Lateral wall not finished
   203E DD 7E D9      [19] 1229 	ld	a,-39 (ix)
   2041 B7            [ 4] 1230 	or	a, a
   2042 20 71         [12] 1231 	jr	NZ,00113$
                           1232 ;src/Renderer.c:510: if (lastCellWasWall)
   2044 DD 7E EF      [19] 1233 	ld	a,-17 (ix)
   2047 B7            [ 4] 1234 	or	a, a
   2048 28 5B         [12] 1235 	jr	Z,00107$
                           1236 ;src/Renderer.c:513: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   204A DD 7E CF      [19] 1237 	ld	a,-49 (ix)
   204D DD 96 D1      [19] 1238 	sub	a, -47 (ix)
   2050 87            [ 4] 1239 	add	a, a
   2051 3C            [ 4] 1240 	inc	a
                           1241 ;src/Renderer.c:514: lateralWallSlopeCounter = lateralWallSlope / 2;
   2052 DD 77 F0      [19] 1242 	ld	-16 (ix), a
   2055 CB 3F         [ 8] 1243 	srl	a
   2057 DD 77 F9      [19] 1244 	ld	-7 (ix),a
                           1245 ;src/Renderer.c:515: lateralWallCounter = lateralWallSlope * zHeight;
   205A DD 5E D2      [19] 1246 	ld	e,-46 (ix)
   205D DD 66 F0      [19] 1247 	ld	h,-16 (ix)
   2060 2E 00         [ 7] 1248 	ld	l, #0x00
   2062 55            [ 4] 1249 	ld	d, l
   2063 06 08         [ 7] 1250 	ld	b, #0x08
   2065                    1251 00633$:
   2065 29            [11] 1252 	add	hl,hl
   2066 30 01         [12] 1253 	jr	NC,00634$
   2068 19            [11] 1254 	add	hl,de
   2069                    1255 00634$:
   2069 10 FA         [13] 1256 	djnz	00633$
                           1257 ;src/Renderer.c:516: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   206B 7D            [ 4] 1258 	ld	a,l
   206C E6 FC         [ 7] 1259 	and	a, #0xFC
   206E CB C7         [ 8] 1260 	set	0, a
   2070 CB 3F         [ 8] 1261 	srl	a
   2072 CB 3F         [ 8] 1262 	srl	a
   2074 DD 96 EE      [19] 1263 	sub	a, -18 (ix)
                           1264 ;src/Renderer.c:517: lateralWallWidth=lateralWallCounter;
   2077 DD 77 D9      [19] 1265 	ld	-39 (ix), a
   207A DD 77 CE      [19] 1266 	ld	-50 (ix),a
                           1267 ;src/Renderer.c:518: lastCellWasWall = 0;
   207D DD 36 EF 00   [19] 1268 	ld	-17 (ix),#0x00
                           1269 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   2081 DD 6E E5      [19] 1270 	ld	l,-27 (ix)
   2084 DD 66 E6      [19] 1271 	ld	h,-26 (ix)
   2087 29            [11] 1272 	add	hl, hl
   2088 DD 4E F0      [19] 1273 	ld	c,-16 (ix)
   208B 06 00         [ 7] 1274 	ld	b,#0x00
   208D C5            [11] 1275 	push	bc
   208E E5            [11] 1276 	push	hl
   208F CD 71 7C      [17] 1277 	call	__divsint
   2092 F1            [10] 1278 	pop	af
   2093 F1            [10] 1279 	pop	af
   2094 DD 7E E9      [19] 1280 	ld	a,-23 (ix)
   2097 95            [ 4] 1281 	sub	a, l
   2098 DD 77 DA      [19] 1282 	ld	-38 (ix),a
                           1283 ;src/Renderer.c:520: color = lastWallId&0b01111111;
   209B DD 7E D7      [19] 1284 	ld	a,-41 (ix)
   209E E6 7F         [ 7] 1285 	and	a, #0x7F
   20A0 DD 77 EA      [19] 1286 	ld	-22 (ix),a
   20A3 18 10         [12] 1287 	jr	00113$
   20A5                    1288 00107$:
                           1289 ;src/Renderer.c:524: xHeight = 0;
   20A5 DD 36 DA 00   [19] 1290 	ld	-38 (ix),#0x00
                           1291 ;src/Renderer.c:525: lastCellWasWall = 0;
   20A9 DD 36 EF 00   [19] 1292 	ld	-17 (ix),#0x00
                           1293 ;src/Renderer.c:526: lateralWallSlope=0;
   20AD DD 36 F0 00   [19] 1294 	ld	-16 (ix),#0x00
                           1295 ;src/Renderer.c:527: lastWallId=0;
   20B1 DD 36 D7 00   [19] 1296 	ld	-41 (ix),#0x00
   20B5                    1297 00113$:
                           1298 ;src/Renderer.c:531: newCell=0;
   20B5 DD 36 DC 00   [19] 1299 	ld	-36 (ix),#0x00
   20B9                    1300 00118$:
                           1301 ;src/Renderer.c:534: if (lateralWallCounter > 0)
   20B9 DD 7E D9      [19] 1302 	ld	a,-39 (ix)
   20BC B7            [ 4] 1303 	or	a, a
   20BD 28 1E         [12] 1304 	jr	Z,00124$
                           1305 ;src/Renderer.c:537: if (lateralWallSlope != 0)
   20BF DD 7E F0      [19] 1306 	ld	a,-16 (ix)
   20C2 B7            [ 4] 1307 	or	a, a
   20C3 28 15         [12] 1308 	jr	Z,00122$
                           1309 ;src/Renderer.c:539: if (lateralWallSlopeCounter == lateralWallSlope)
   20C5 DD 7E F9      [19] 1310 	ld	a,-7 (ix)
   20C8 DD 96 F0      [19] 1311 	sub	a, -16 (ix)
   20CB 20 0A         [12] 1312 	jr	NZ,00120$
                           1313 ;src/Renderer.c:541: lateralWallSlopeCounter = 0;
   20CD DD 36 F9 00   [19] 1314 	ld	-7 (ix),#0x00
                           1315 ;src/Renderer.c:542: xHeight -= 2;
   20D1 DD 35 DA      [23] 1316 	dec	-38 (ix)
   20D4 DD 35 DA      [23] 1317 	dec	-38 (ix)
   20D7                    1318 00120$:
                           1319 ;src/Renderer.c:544: ++lateralWallSlopeCounter;
   20D7 DD 34 F9      [23] 1320 	inc	-7 (ix)
   20DA                    1321 00122$:
                           1322 ;src/Renderer.c:547: --lateralWallCounter;
   20DA DD 35 D9      [23] 1323 	dec	-39 (ix)
   20DD                    1324 00124$:
                           1325 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   20DD DD 7E D2      [19] 1326 	ld	a,-46 (ix)
   20E0 DD 77 EC      [19] 1327 	ld	-20 (ix),a
   20E3 DD 36 ED 00   [19] 1328 	ld	-19 (ix),#0x00
                           1329 ;src/Renderer.c:550: if (!(x%2))
   20E7 DD 7E F5      [19] 1330 	ld	a,-11 (ix)
   20EA B7            [ 4] 1331 	or	a, a
   20EB C2 86 21      [10] 1332 	jp	NZ,00138$
                           1333 ;src/Renderer.c:560: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   20EE DD 46 D3      [19] 1334 	ld	b,-45 (ix)
   20F1 CB 38         [ 8] 1335 	srl	b
                           1336 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   20F3 DD 6E E5      [19] 1337 	ld	l,-27 (ix)
   20F6 DD 66 E6      [19] 1338 	ld	h,-26 (ix)
   20F9 29            [11] 1339 	add	hl, hl
   20FA 29            [11] 1340 	add	hl, hl
   20FB 29            [11] 1341 	add	hl, hl
   20FC 29            [11] 1342 	add	hl, hl
   20FD 29            [11] 1343 	add	hl, hl
   20FE C5            [11] 1344 	push	bc
   20FF DD 5E EC      [19] 1345 	ld	e,-20 (ix)
   2102 DD 56 ED      [19] 1346 	ld	d,-19 (ix)
   2105 D5            [11] 1347 	push	de
   2106 E5            [11] 1348 	push	hl
   2107 CD 71 7C      [17] 1349 	call	__divsint
   210A F1            [10] 1350 	pop	af
   210B F1            [10] 1351 	pop	af
   210C C1            [10] 1352 	pop	bc
   210D 4D            [ 4] 1353 	ld	c,l
                           1354 ;src/Renderer.c:552: if(xHeight > 0){
   210E DD 7E DA      [19] 1355 	ld	a,-38 (ix)
   2111 B7            [ 4] 1356 	or	a, a
   2112 28 3A         [12] 1357 	jr	Z,00129$
                           1358 ;src/Renderer.c:553: if (lateralWallCounter > 0)
   2114 DD 7E D9      [19] 1359 	ld	a,-39 (ix)
   2117 B7            [ 4] 1360 	or	a, a
   2118 28 21         [12] 1361 	jr	Z,00126$
                           1362 ;src/Renderer.c:555: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   211A DD 5E CE      [19] 1363 	ld	e,-50 (ix)
   211D 16 00         [ 7] 1364 	ld	d,#0x00
   211F DD 6E D9      [19] 1365 	ld	l,-39 (ix)
   2122 26 00         [ 7] 1366 	ld	h,#0x00
   2124 7B            [ 4] 1367 	ld	a,e
   2125 95            [ 4] 1368 	sub	a, l
   2126 6F            [ 4] 1369 	ld	l,a
   2127 7A            [ 4] 1370 	ld	a,d
   2128 9C            [ 4] 1371 	sbc	a, h
   2129 67            [ 4] 1372 	ld	h,a
   212A 29            [11] 1373 	add	hl, hl
   212B 29            [11] 1374 	add	hl, hl
   212C 29            [11] 1375 	add	hl, hl
   212D 29            [11] 1376 	add	hl, hl
   212E 29            [11] 1377 	add	hl, hl
   212F C5            [11] 1378 	push	bc
   2130 D5            [11] 1379 	push	de
   2131 E5            [11] 1380 	push	hl
   2132 CD 71 7C      [17] 1381 	call	__divsint
   2135 F1            [10] 1382 	pop	af
   2136 F1            [10] 1383 	pop	af
   2137 55            [ 4] 1384 	ld	d,l
   2138 C1            [10] 1385 	pop	bc
   2139 18 01         [12] 1386 	jr	00127$
   213B                    1387 00126$:
                           1388 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   213B 51            [ 4] 1389 	ld	d,c
   213C                    1390 00127$:
                           1391 ;src/Renderer.c:560: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   213C C5            [11] 1392 	push	bc
   213D D5            [11] 1393 	push	de
   213E 33            [ 6] 1394 	inc	sp
   213F DD 66 EA      [19] 1395 	ld	h,-22 (ix)
   2142 DD 6E DA      [19] 1396 	ld	l,-38 (ix)
   2145 E5            [11] 1397 	push	hl
   2146 C5            [11] 1398 	push	bc
   2147 33            [ 6] 1399 	inc	sp
   2148 CD 81 1D      [17] 1400 	call	_draw_column_to_buffer
   214B F1            [10] 1401 	pop	af
   214C F1            [10] 1402 	pop	af
   214D C1            [10] 1403 	pop	bc
   214E                    1404 00129$:
                           1405 ;src/Renderer.c:562: if(!(currentCellID&CELL_WALL_MASK)){
   214E DD 7E D8      [19] 1406 	ld	a,-40 (ix)
   2151 B7            [ 4] 1407 	or	a, a
   2152 20 32         [12] 1408 	jr	NZ,00138$
                           1409 ;src/Renderer.c:563: if(currentCellID&CELL_ENEMY_MASK){
   2154 DD 7E DB      [19] 1410 	ld	a,-37 (ix)
   2157 E6 0F         [ 7] 1411 	and	a, #0x0F
   2159 28 13         [12] 1412 	jr	Z,00133$
                           1413 ;src/Renderer.c:564: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   215B 79            [ 4] 1414 	ld	a,c
   215C F5            [11] 1415 	push	af
   215D 33            [ 6] 1416 	inc	sp
   215E DD 66 DB      [19] 1417 	ld	h,-37 (ix)
   2161 DD 6E D2      [19] 1418 	ld	l,-46 (ix)
   2164 E5            [11] 1419 	push	hl
   2165 C5            [11] 1420 	push	bc
   2166 33            [ 6] 1421 	inc	sp
   2167 CD 3B 1C      [17] 1422 	call	_draw_column_to_buffer_enemy
   216A F1            [10] 1423 	pop	af
   216B F1            [10] 1424 	pop	af
   216C 18 18         [12] 1425 	jr	00138$
   216E                    1426 00133$:
                           1427 ;src/Renderer.c:566: else if(currentCellID&CELL_ITEM_MASK){
   216E DD 7E DB      [19] 1428 	ld	a,-37 (ix)
   2171 E6 70         [ 7] 1429 	and	a, #0x70
   2173 28 11         [12] 1430 	jr	Z,00138$
                           1431 ;src/Renderer.c:567: draw_column_to_buffer_object(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   2175 79            [ 4] 1432 	ld	a,c
   2176 F5            [11] 1433 	push	af
   2177 33            [ 6] 1434 	inc	sp
   2178 DD 66 DB      [19] 1435 	ld	h,-37 (ix)
   217B DD 6E D2      [19] 1436 	ld	l,-46 (ix)
   217E E5            [11] 1437 	push	hl
   217F C5            [11] 1438 	push	bc
   2180 33            [ 6] 1439 	inc	sp
   2181 CD 40 1B      [17] 1440 	call	_draw_column_to_buffer_object
   2184 F1            [10] 1441 	pop	af
   2185 F1            [10] 1442 	pop	af
   2186                    1443 00138$:
                           1444 ;src/Renderer.c:572: ++xCellCount;
   2186 DD 34 EE      [23] 1445 	inc	-18 (ix)
                           1446 ;src/Renderer.c:487: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   2189 DD 34 D3      [23] 1447 	inc	-45 (ix)
                           1448 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   218C 2A C1 1A      [16] 1449 	ld	hl,(_cells_in_view_array)
   218F DD 75 E7      [19] 1450 	ld	-25 (ix),l
   2192 DD 74 E8      [19] 1451 	ld	-24 (ix),h
                           1452 ;src/Renderer.c:487: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   2195 DD 7E D3      [19] 1453 	ld	a,-45 (ix)
   2198 D6 50         [ 7] 1454 	sub	a, #0x50
   219A DA 8F 1F      [10] 1455 	jp	C,00260$
                           1456 ;src/Renderer.c:579: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   219D DD 7E CA      [19] 1457 	ld	a,-54 (ix)
   21A0 B7            [ 4] 1458 	or	a, a
   21A1 28 05         [12] 1459 	jr	Z,00272$
   21A3 DD 4E EB      [19] 1460 	ld	c,-21 (ix)
   21A6 18 02         [12] 1461 	jr	00273$
   21A8                    1462 00272$:
   21A8 0E 00         [ 7] 1463 	ld	c,#0x00
   21AA                    1464 00273$:
   21AA DD 71 E5      [19] 1465 	ld	-27 (ix),c
                           1466 ;src/Renderer.c:580: lateralWallSlope=0;
   21AD DD 36 D8 00   [19] 1467 	ld	-40 (ix),#0x00
                           1468 ;src/Renderer.c:581: lateralWallSlopeCounter=0;
   21B1 DD 36 F5 00   [19] 1469 	ld	-11 (ix),#0x00
                           1470 ;src/Renderer.c:582: xHeight=0;
   21B5 DD 36 EF 00   [19] 1471 	ld	-17 (ix),#0x00
                           1472 ;src/Renderer.c:584: lateralWallCounter = 0;
   21B9 DD 36 D7 00   [19] 1473 	ld	-41 (ix),#0x00
                           1474 ;src/Renderer.c:585: lineEnd = lineStart + offsetDiff * 2 + 2;
   21BD DD 7E CF      [19] 1475 	ld	a,-49 (ix)
   21C0 87            [ 4] 1476 	add	a, a
   21C1 4F            [ 4] 1477 	ld	c,a
   21C2 DD 7E C7      [19] 1478 	ld	a,-57 (ix)
   21C5 81            [ 4] 1479 	add	a, c
   21C6 DD 77 DB      [19] 1480 	ld	-37 (ix), a
   21C9 4F            [ 4] 1481 	ld	c, a
   21CA 0C            [ 4] 1482 	inc	c
   21CB 0C            [ 4] 1483 	inc	c
                           1484 ;src/Renderer.c:587: newCell=1;
   21CC DD 36 E3 01   [19] 1485 	ld	-29 (ix),#0x01
                           1486 ;src/Renderer.c:588: currentCellID = cells_in_view_array[lineEnd - 1];
   21D0 DD 71 F1      [19] 1487 	ld	-15 (ix),c
   21D3 DD 36 F2 00   [19] 1488 	ld	-14 (ix),#0x00
   21D7 DD 5E F1      [19] 1489 	ld	e,-15 (ix)
   21DA DD 56 F2      [19] 1490 	ld	d,-14 (ix)
   21DD 1B            [ 6] 1491 	dec	de
   21DE DD 6E E7      [19] 1492 	ld	l,-25 (ix)
   21E1 DD 66 E8      [19] 1493 	ld	h,-24 (ix)
   21E4 19            [11] 1494 	add	hl,de
   21E5 7E            [ 7] 1495 	ld	a,(hl)
   21E6 DD 77 DC      [19] 1496 	ld	-36 (ix),a
                           1497 ;src/Renderer.c:590: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   21E9 DD 6E E7      [19] 1498 	ld	l,-25 (ix)
   21EC DD 66 E8      [19] 1499 	ld	h,-24 (ix)
   21EF 06 00         [ 7] 1500 	ld	b,#0x00
   21F1 09            [11] 1501 	add	hl, bc
   21F2 4E            [ 7] 1502 	ld	c,(hl)
                           1503 ;src/Renderer.c:591: if(lastCellWasWall&CELL_WALL_MASK){
   21F3 CB 79         [ 8] 1504 	bit	7, c
   21F5 28 09         [12] 1505 	jr	Z,00141$
                           1506 ;src/Renderer.c:592: lastWallId=lastCellWasWall;
   21F7 DD 71 D9      [19] 1507 	ld	-39 (ix),c
                           1508 ;src/Renderer.c:593: lastCellWasWall=1;
   21FA DD 36 DA 01   [19] 1509 	ld	-38 (ix),#0x01
   21FE 18 08         [12] 1510 	jr	00325$
   2200                    1511 00141$:
                           1512 ;src/Renderer.c:596: lastCellWasWall=0;
   2200 DD 36 DA 00   [19] 1513 	ld	-38 (ix),#0x00
                           1514 ;src/Renderer.c:597: lastWallId=CELLTYPE_FLOOR;
   2204 DD 36 D9 00   [19] 1515 	ld	-39 (ix),#0x00
                           1516 ;src/Renderer.c:600: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   2208                    1517 00325$:
   2208 DD 36 D1 00   [19] 1518 	ld	-47 (ix),#0x00
   220C DD 36 D3 9F   [19] 1519 	ld	-45 (ix),#0x9F
   2210                    1520 00262$:
                           1521 ;src/Renderer.c:603: if (xCellCount == zHeight)
   2210 DD 7E D2      [19] 1522 	ld	a,-46 (ix)
   2213 DD 96 E5      [19] 1523 	sub	a, -27 (ix)
   2216 20 50         [12] 1524 	jr	NZ,00144$
                           1525 ;src/Renderer.c:605: ++xCell;
   2218 DD 34 D1      [23] 1526 	inc	-47 (ix)
                           1527 ;src/Renderer.c:606: xCellCount = 0;
   221B DD 36 E5 00   [19] 1528 	ld	-27 (ix),#0x00
                           1529 ;src/Renderer.c:607: newCell=1;
   221F DD 36 E3 01   [19] 1530 	ld	-29 (ix),#0x01
                           1531 ;src/Renderer.c:608: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   2223 DD 7E D1      [19] 1532 	ld	a,-47 (ix)
   2226 DD 77 F3      [19] 1533 	ld	-13 (ix),a
   2229 DD 36 F4 00   [19] 1534 	ld	-12 (ix),#0x00
   222D DD 7E F1      [19] 1535 	ld	a,-15 (ix)
   2230 DD 96 F3      [19] 1536 	sub	a, -13 (ix)
   2233 DD 77 F3      [19] 1537 	ld	-13 (ix),a
   2236 DD 7E F2      [19] 1538 	ld	a,-14 (ix)
   2239 DD 9E F4      [19] 1539 	sbc	a, -12 (ix)
   223C DD 77 F4      [19] 1540 	ld	-12 (ix),a
   223F DD 6E F3      [19] 1541 	ld	l,-13 (ix)
   2242 DD 66 F4      [19] 1542 	ld	h,-12 (ix)
   2245 2B            [ 6] 1543 	dec	hl
   2246 DD 75 F3      [19] 1544 	ld	-13 (ix),l
   2249 DD 74 F4      [19] 1545 	ld	-12 (ix),h
   224C DD 7E E7      [19] 1546 	ld	a,-25 (ix)
   224F DD 86 F3      [19] 1547 	add	a, -13 (ix)
   2252 DD 77 F3      [19] 1548 	ld	-13 (ix),a
   2255 DD 7E E8      [19] 1549 	ld	a,-24 (ix)
   2258 DD 8E F4      [19] 1550 	adc	a, -12 (ix)
   225B DD 77 F4      [19] 1551 	ld	-12 (ix),a
   225E DD 6E F3      [19] 1552 	ld	l,-13 (ix)
   2261 DD 66 F4      [19] 1553 	ld	h,-12 (ix)
   2264 7E            [ 7] 1554 	ld	a,(hl)
   2265 DD 77 DC      [19] 1555 	ld	-36 (ix),a
   2268                    1556 00144$:
                           1557 ;src/Renderer.c:610: if(!(x%2)){
   2268 DD 7E D3      [19] 1558 	ld	a,-45 (ix)
   226B E6 01         [ 7] 1559 	and	a, #0x01
   226D DD 77 F3      [19] 1560 	ld	-13 (ix),a
                           1561 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   2270 DD 7E DC      [19] 1562 	ld	a,-36 (ix)
   2273 E6 80         [ 7] 1563 	and	a, #0x80
   2275 DD 77 F9      [19] 1564 	ld	-7 (ix),a
                           1565 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   2278 DD 7E E5      [19] 1566 	ld	a,-27 (ix)
   227B DD 77 F7      [19] 1567 	ld	-9 (ix),a
   227E DD 36 F8 00   [19] 1568 	ld	-8 (ix),#0x00
                           1569 ;src/Renderer.c:610: if(!(x%2)){
   2282 DD 7E F3      [19] 1570 	ld	a,-13 (ix)
   2285 B7            [ 4] 1571 	or	a, a
   2286 C2 58 23      [10] 1572 	jp	NZ,00157$
                           1573 ;src/Renderer.c:611: if (lateralWallCounter == 0 || newCell)
   2289 DD 7E D7      [19] 1574 	ld	a,-41 (ix)
   228C B7            [ 4] 1575 	or	a, a
   228D 28 07         [12] 1576 	jr	Z,00153$
   228F DD 7E E3      [19] 1577 	ld	a,-29 (ix)
   2292 B7            [ 4] 1578 	or	a, a
   2293 CA 58 23      [10] 1579 	jp	Z,00157$
   2296                    1580 00153$:
                           1581 ;src/Renderer.c:613: if ( currentCellID & CELL_WALL_MASK)//Wall
   2296 DD 7E F9      [19] 1582 	ld	a,-7 (ix)
   2299 B7            [ 4] 1583 	or	a, a
   229A 28 23         [12] 1584 	jr	Z,00151$
                           1585 ;src/Renderer.c:615: lateralWallCounter = 0;
   229C DD 36 D7 00   [19] 1586 	ld	-41 (ix),#0x00
                           1587 ;src/Renderer.c:616: lateralWallSlope = 0;
   22A0 DD 36 D8 00   [19] 1588 	ld	-40 (ix),#0x00
                           1589 ;src/Renderer.c:617: xHeight = zHeight;
   22A4 DD 7E D2      [19] 1590 	ld	a,-46 (ix)
   22A7 DD 77 EF      [19] 1591 	ld	-17 (ix),a
                           1592 ;src/Renderer.c:618: color = currentCellID&0b01111111;
   22AA DD 7E DC      [19] 1593 	ld	a,-36 (ix)
   22AD E6 7F         [ 7] 1594 	and	a, #0x7F
   22AF DD 77 EA      [19] 1595 	ld	-22 (ix),a
                           1596 ;src/Renderer.c:619: lastCellWasWall = 1;
   22B2 DD 36 DA 01   [19] 1597 	ld	-38 (ix),#0x01
                           1598 ;src/Renderer.c:620: lastWallId=currentCellID;
   22B6 DD 7E DC      [19] 1599 	ld	a,-36 (ix)
   22B9 DD 77 D9      [19] 1600 	ld	-39 (ix),a
   22BC C3 54 23      [10] 1601 	jp	00152$
   22BF                    1602 00151$:
                           1603 ;src/Renderer.c:622: else if(lateralWallCounter==0){
   22BF DD 7E D7      [19] 1604 	ld	a,-41 (ix)
   22C2 B7            [ 4] 1605 	or	a, a
   22C3 C2 54 23      [10] 1606 	jp	NZ,00152$
                           1607 ;src/Renderer.c:623: if (lastCellWasWall)
   22C6 DD 7E DA      [19] 1608 	ld	a,-38 (ix)
   22C9 B7            [ 4] 1609 	or	a, a
   22CA 28 78         [12] 1610 	jr	Z,00146$
                           1611 ;src/Renderer.c:626: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   22CC DD 7E CF      [19] 1612 	ld	a,-49 (ix)
   22CF DD 96 D1      [19] 1613 	sub	a, -47 (ix)
   22D2 87            [ 4] 1614 	add	a, a
   22D3 3C            [ 4] 1615 	inc	a
                           1616 ;src/Renderer.c:627: lateralWallSlopeCounter = lateralWallSlope / 2;
   22D4 DD 77 D8      [19] 1617 	ld	-40 (ix), a
   22D7 CB 3F         [ 8] 1618 	srl	a
   22D9 DD 77 F5      [19] 1619 	ld	-11 (ix),a
                           1620 ;src/Renderer.c:628: lateralWallCounter = lateralWallSlope * zHeight;
   22DC DD 5E D2      [19] 1621 	ld	e,-46 (ix)
   22DF DD 66 D8      [19] 1622 	ld	h,-40 (ix)
   22E2 2E 00         [ 7] 1623 	ld	l, #0x00
   22E4 55            [ 4] 1624 	ld	d, l
   22E5 06 08         [ 7] 1625 	ld	b, #0x08
   22E7                    1626 00642$:
   22E7 29            [11] 1627 	add	hl,hl
   22E8 30 01         [12] 1628 	jr	NC,00643$
   22EA 19            [11] 1629 	add	hl,de
   22EB                    1630 00643$:
   22EB 10 FA         [13] 1631 	djnz	00642$
                           1632 ;src/Renderer.c:629: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   22ED 4D            [ 4] 1633 	ld	c,l
   22EE 06 00         [ 7] 1634 	ld	b,#0x00
   22F0 7D            [ 4] 1635 	ld	a,l
   22F1 E6 03         [ 7] 1636 	and	a, #0x03
   22F3 5F            [ 4] 1637 	ld	e,a
   22F4 16 00         [ 7] 1638 	ld	d,#0x00
   22F6 79            [ 4] 1639 	ld	a,c
   22F7 93            [ 4] 1640 	sub	a, e
   22F8 4F            [ 4] 1641 	ld	c,a
   22F9 78            [ 4] 1642 	ld	a,b
   22FA 9A            [ 4] 1643 	sbc	a, d
   22FB 47            [ 4] 1644 	ld	b,a
   22FC 59            [ 4] 1645 	ld	e, c
   22FD 50            [ 4] 1646 	ld	d, b
   22FE 13            [ 6] 1647 	inc	de
   22FF 6B            [ 4] 1648 	ld	l, e
   2300 62            [ 4] 1649 	ld	h, d
   2301 CB 7A         [ 8] 1650 	bit	7, d
   2303 28 04         [12] 1651 	jr	Z,00274$
   2305 21 04 00      [10] 1652 	ld	hl,#0x0004
   2308 09            [11] 1653 	add	hl,bc
   2309                    1654 00274$:
   2309 CB 2C         [ 8] 1655 	sra	h
   230B CB 1D         [ 8] 1656 	rr	l
   230D CB 2C         [ 8] 1657 	sra	h
   230F CB 1D         [ 8] 1658 	rr	l
   2311 DD 4E E5      [19] 1659 	ld	c,-27 (ix)
   2314 7D            [ 4] 1660 	ld	a,l
   2315 91            [ 4] 1661 	sub	a, c
                           1662 ;src/Renderer.c:630: lateralWallWidth=lateralWallCounter;
   2316 DD 77 D7      [19] 1663 	ld	-41 (ix), a
   2319 DD 77 CE      [19] 1664 	ld	-50 (ix),a
                           1665 ;src/Renderer.c:631: lastCellWasWall = 0;
   231C DD 36 DA 00   [19] 1666 	ld	-38 (ix),#0x00
                           1667 ;src/Renderer.c:632: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   2320 DD 6E F7      [19] 1668 	ld	l,-9 (ix)
   2323 DD 66 F8      [19] 1669 	ld	h,-8 (ix)
   2326 29            [11] 1670 	add	hl, hl
   2327 DD 4E D8      [19] 1671 	ld	c,-40 (ix)
   232A 06 00         [ 7] 1672 	ld	b,#0x00
   232C C5            [11] 1673 	push	bc
   232D E5            [11] 1674 	push	hl
   232E CD 71 7C      [17] 1675 	call	__divsint
   2331 F1            [10] 1676 	pop	af
   2332 F1            [10] 1677 	pop	af
   2333 DD 7E E9      [19] 1678 	ld	a,-23 (ix)
   2336 95            [ 4] 1679 	sub	a, l
   2337 DD 77 EF      [19] 1680 	ld	-17 (ix),a
                           1681 ;src/Renderer.c:633: color = lastWallId&0b01111111;
   233A DD 7E D9      [19] 1682 	ld	a,-39 (ix)
   233D E6 7F         [ 7] 1683 	and	a, #0x7F
   233F DD 77 EA      [19] 1684 	ld	-22 (ix),a
   2342 18 10         [12] 1685 	jr	00152$
   2344                    1686 00146$:
                           1687 ;src/Renderer.c:637: xHeight = 0;
   2344 DD 36 EF 00   [19] 1688 	ld	-17 (ix),#0x00
                           1689 ;src/Renderer.c:638: lastCellWasWall = 0;
   2348 DD 36 DA 00   [19] 1690 	ld	-38 (ix),#0x00
                           1691 ;src/Renderer.c:639: lateralWallSlope=0;
   234C DD 36 D8 00   [19] 1692 	ld	-40 (ix),#0x00
                           1693 ;src/Renderer.c:640: lastWallId=0;
   2350 DD 36 D9 00   [19] 1694 	ld	-39 (ix),#0x00
   2354                    1695 00152$:
                           1696 ;src/Renderer.c:643: newCell=0;
   2354 DD 36 E3 00   [19] 1697 	ld	-29 (ix),#0x00
   2358                    1698 00157$:
                           1699 ;src/Renderer.c:648: if (lateralWallCounter > 0)
   2358 DD 7E D7      [19] 1700 	ld	a,-41 (ix)
   235B B7            [ 4] 1701 	or	a, a
   235C 28 1E         [12] 1702 	jr	Z,00163$
                           1703 ;src/Renderer.c:651: if (lateralWallSlope != 0)
   235E DD 7E D8      [19] 1704 	ld	a,-40 (ix)
   2361 B7            [ 4] 1705 	or	a, a
   2362 28 15         [12] 1706 	jr	Z,00161$
                           1707 ;src/Renderer.c:653: if (lateralWallSlopeCounter == lateralWallSlope)
   2364 DD 7E D8      [19] 1708 	ld	a,-40 (ix)
   2367 DD 96 F5      [19] 1709 	sub	a, -11 (ix)
   236A 20 0A         [12] 1710 	jr	NZ,00159$
                           1711 ;src/Renderer.c:655: lateralWallSlopeCounter = 0;
   236C DD 36 F5 00   [19] 1712 	ld	-11 (ix),#0x00
                           1713 ;src/Renderer.c:656: xHeight -= 2;
   2370 DD 35 EF      [23] 1714 	dec	-17 (ix)
   2373 DD 35 EF      [23] 1715 	dec	-17 (ix)
   2376                    1716 00159$:
                           1717 ;src/Renderer.c:658: ++lateralWallSlopeCounter;
   2376 DD 34 F5      [23] 1718 	inc	-11 (ix)
   2379                    1719 00161$:
                           1720 ;src/Renderer.c:660: --lateralWallCounter;
   2379 DD 35 D7      [23] 1721 	dec	-41 (ix)
   237C                    1722 00163$:
                           1723 ;src/Renderer.c:664: if (!(x%2))
   237C DD 7E F3      [19] 1724 	ld	a,-13 (ix)
   237F B7            [ 4] 1725 	or	a, a
   2380 C2 5F 24      [10] 1726 	jp	NZ,00177$
                           1727 ;src/Renderer.c:677: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   2383 DD 7E D3      [19] 1728 	ld	a,-45 (ix)
   2386 CB 3F         [ 8] 1729 	srl	a
   2388 DD 77 F3      [19] 1730 	ld	-13 (ix),a
                           1731 ;src/Renderer.c:674: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   238B DD 7E EC      [19] 1732 	ld	a,-20 (ix)
   238E DD 96 F7      [19] 1733 	sub	a, -9 (ix)
   2391 DD 77 F7      [19] 1734 	ld	-9 (ix),a
   2394 DD 7E ED      [19] 1735 	ld	a,-19 (ix)
   2397 DD 9E F8      [19] 1736 	sbc	a, -8 (ix)
   239A DD 77 F8      [19] 1737 	ld	-8 (ix),a
   239D 3E 06         [ 7] 1738 	ld	a,#0x05+1
   239F 18 08         [12] 1739 	jr	00647$
   23A1                    1740 00646$:
   23A1 DD CB F7 26   [23] 1741 	sla	-9 (ix)
   23A5 DD CB F8 16   [23] 1742 	rl	-8 (ix)
   23A9                    1743 00647$:
   23A9 3D            [ 4] 1744 	dec	a
   23AA 20 F5         [12] 1745 	jr	NZ,00646$
   23AC DD 6E EC      [19] 1746 	ld	l,-20 (ix)
   23AF DD 66 ED      [19] 1747 	ld	h,-19 (ix)
   23B2 E5            [11] 1748 	push	hl
   23B3 DD 6E F7      [19] 1749 	ld	l,-9 (ix)
   23B6 DD 66 F8      [19] 1750 	ld	h,-8 (ix)
   23B9 E5            [11] 1751 	push	hl
   23BA CD 71 7C      [17] 1752 	call	__divsint
   23BD F1            [10] 1753 	pop	af
   23BE F1            [10] 1754 	pop	af
   23BF DD 74 F8      [19] 1755 	ld	-8 (ix),h
   23C2 DD 75 F7      [19] 1756 	ld	-9 (ix), l
   23C5 DD 75 F7      [19] 1757 	ld	-9 (ix), l
                           1758 ;src/Renderer.c:667: if(xHeight > 0){
   23C8 DD 7E EF      [19] 1759 	ld	a,-17 (ix)
   23CB B7            [ 4] 1760 	or	a, a
   23CC 28 55         [12] 1761 	jr	Z,00168$
                           1762 ;src/Renderer.c:669: if (lateralWallCounter > 0)
   23CE DD 7E D7      [19] 1763 	ld	a,-41 (ix)
   23D1 B7            [ 4] 1764 	or	a, a
   23D2 28 39         [12] 1765 	jr	Z,00165$
                           1766 ;src/Renderer.c:671: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   23D4 DD 7E D7      [19] 1767 	ld	a,-41 (ix)
   23D7 DD 77 FA      [19] 1768 	ld	-6 (ix),a
   23DA DD 36 FB 00   [19] 1769 	ld	-5 (ix),#0x00
   23DE 3E 06         [ 7] 1770 	ld	a,#0x05+1
   23E0 18 08         [12] 1771 	jr	00649$
   23E2                    1772 00648$:
   23E2 DD CB FA 26   [23] 1773 	sla	-6 (ix)
   23E6 DD CB FB 16   [23] 1774 	rl	-5 (ix)
   23EA                    1775 00649$:
   23EA 3D            [ 4] 1776 	dec	a
   23EB 20 F5         [12] 1777 	jr	NZ,00648$
   23ED DD 7E CE      [19] 1778 	ld	a,-50 (ix)
   23F0 DD 77 FC      [19] 1779 	ld	-4 (ix),a
   23F3 DD 36 FD 00   [19] 1780 	ld	-3 (ix),#0x00
   23F7 DD 6E FC      [19] 1781 	ld	l,-4 (ix)
   23FA DD 66 FD      [19] 1782 	ld	h,-3 (ix)
   23FD E5            [11] 1783 	push	hl
   23FE DD 6E FA      [19] 1784 	ld	l,-6 (ix)
   2401 DD 66 FB      [19] 1785 	ld	h,-5 (ix)
   2404 E5            [11] 1786 	push	hl
   2405 CD 71 7C      [17] 1787 	call	__divsint
   2408 F1            [10] 1788 	pop	af
   2409 F1            [10] 1789 	pop	af
   240A 45            [ 4] 1790 	ld	b,l
   240B 18 03         [12] 1791 	jr	00166$
   240D                    1792 00165$:
                           1793 ;src/Renderer.c:674: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   240D DD 46 F7      [19] 1794 	ld	b,-9 (ix)
   2410                    1795 00166$:
                           1796 ;src/Renderer.c:677: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   2410 C5            [11] 1797 	push	bc
   2411 33            [ 6] 1798 	inc	sp
   2412 DD 66 EA      [19] 1799 	ld	h,-22 (ix)
   2415 DD 6E EF      [19] 1800 	ld	l,-17 (ix)
   2418 E5            [11] 1801 	push	hl
   2419 DD 7E F3      [19] 1802 	ld	a,-13 (ix)
   241C F5            [11] 1803 	push	af
   241D 33            [ 6] 1804 	inc	sp
   241E CD 81 1D      [17] 1805 	call	_draw_column_to_buffer
   2421 F1            [10] 1806 	pop	af
   2422 F1            [10] 1807 	pop	af
   2423                    1808 00168$:
                           1809 ;src/Renderer.c:680: if(!(currentCellID&CELL_WALL_MASK)){
   2423 DD 7E F9      [19] 1810 	ld	a,-7 (ix)
   2426 B7            [ 4] 1811 	or	a, a
   2427 20 36         [12] 1812 	jr	NZ,00177$
                           1813 ;src/Renderer.c:681: if(currentCellID&CELL_ENEMY_MASK){
   2429 DD 7E DC      [19] 1814 	ld	a,-36 (ix)
   242C E6 0F         [ 7] 1815 	and	a, #0x0F
   242E 28 15         [12] 1816 	jr	Z,00172$
                           1817 ;src/Renderer.c:682: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   2430 DD 66 F7      [19] 1818 	ld	h,-9 (ix)
   2433 DD 6E DC      [19] 1819 	ld	l,-36 (ix)
   2436 E5            [11] 1820 	push	hl
   2437 DD 66 D2      [19] 1821 	ld	h,-46 (ix)
   243A DD 6E F3      [19] 1822 	ld	l,-13 (ix)
   243D E5            [11] 1823 	push	hl
   243E CD 3B 1C      [17] 1824 	call	_draw_column_to_buffer_enemy
   2441 F1            [10] 1825 	pop	af
   2442 F1            [10] 1826 	pop	af
   2443 18 1A         [12] 1827 	jr	00177$
   2445                    1828 00172$:
                           1829 ;src/Renderer.c:684: else if(currentCellID&CELL_ITEM_MASK){
   2445 DD 7E DC      [19] 1830 	ld	a,-36 (ix)
   2448 E6 70         [ 7] 1831 	and	a, #0x70
   244A 28 13         [12] 1832 	jr	Z,00177$
                           1833 ;src/Renderer.c:685: draw_column_to_buffer_object(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   244C DD 66 F7      [19] 1834 	ld	h,-9 (ix)
   244F DD 6E DC      [19] 1835 	ld	l,-36 (ix)
   2452 E5            [11] 1836 	push	hl
   2453 DD 66 D2      [19] 1837 	ld	h,-46 (ix)
   2456 DD 6E F3      [19] 1838 	ld	l,-13 (ix)
   2459 E5            [11] 1839 	push	hl
   245A CD 40 1B      [17] 1840 	call	_draw_column_to_buffer_object
   245D F1            [10] 1841 	pop	af
   245E F1            [10] 1842 	pop	af
   245F                    1843 00177$:
                           1844 ;src/Renderer.c:689: ++xCellCount;
   245F DD 34 E5      [23] 1845 	inc	-27 (ix)
                           1846 ;src/Renderer.c:600: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   2462 DD 35 D3      [23] 1847 	dec	-45 (ix)
                           1848 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   2465 2A C1 1A      [16] 1849 	ld	hl,(_cells_in_view_array)
   2468 DD 75 E7      [19] 1850 	ld	-25 (ix),l
   246B DD 74 E8      [19] 1851 	ld	-24 (ix),h
                           1852 ;src/Renderer.c:600: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   246E DD 7E D3      [19] 1853 	ld	a,-45 (ix)
   2471 D6 50         [ 7] 1854 	sub	a, #0x50
   2473 D2 10 22      [10] 1855 	jp	NC,00262$
                           1856 ;src/Renderer.c:720: lineStart = lineStart + (offsetDiff * 2) + 3;
   2476 DD 7E DB      [19] 1857 	ld	a,-37 (ix)
   2479 C6 03         [ 7] 1858 	add	a, #0x03
   247B DD 77 C7      [19] 1859 	ld	-57 (ix),a
                           1860 ;src/Renderer.c:721: zHeight += zHeight;
   247E DD CB D2 26   [23] 1861 	sla	-46 (ix)
                           1862 ;src/Renderer.c:722: offsetDiff = offsetDiff >> 1;
   2482 DD CB CF 3E   [23] 1863 	srl	-49 (ix)
                           1864 ;src/Renderer.c:724: }while(z);
   2486 DD 7E CA      [19] 1865 	ld	a,-54 (ix)
   2489 B7            [ 4] 1866 	or	a, a
   248A C2 19 1F      [10] 1867 	jp	NZ,00179$
   248D C3 73 2A      [10] 1868 	jp	00268$
                           1869 ;src/Renderer.c:729: do{
   2490                    1870 00370$:
   2490 DD 36 CA 06   [19] 1871 	ld	-54 (ix),#0x06
   2494                    1872 00254$:
                           1873 ;src/Renderer.c:731: --z;
   2494 DD 35 CA      [23] 1874 	dec	-54 (ix)
                           1875 ;src/Renderer.c:466: xCellCount = (z) ? (zHeight >> 1) : 0;
   2497 DD 7E D2      [19] 1876 	ld	a,-46 (ix)
   249A CB 3F         [ 8] 1877 	srl	a
   249C DD 77 FC      [19] 1878 	ld	-4 (ix),a
                           1879 ;src/Renderer.c:735: xCellCount = (z) ? (zHeight >> 1) : 0;
   249F DD 7E CA      [19] 1880 	ld	a,-54 (ix)
   24A2 B7            [ 4] 1881 	or	a, a
   24A3 28 05         [12] 1882 	jr	Z,00275$
   24A5 DD 4E FC      [19] 1883 	ld	c,-4 (ix)
   24A8 18 02         [12] 1884 	jr	00276$
   24AA                    1885 00275$:
   24AA 0E 00         [ 7] 1886 	ld	c,#0x00
   24AC                    1887 00276$:
   24AC DD 71 CB      [19] 1888 	ld	-53 (ix),c
                           1889 ;src/Renderer.c:736: lateralWallSlope=0;
   24AF DD 36 CC 00   [19] 1890 	ld	-52 (ix),#0x00
                           1891 ;src/Renderer.c:737: lateralWallSlopeCounter=0;
   24B3 DD 36 D0 00   [19] 1892 	ld	-48 (ix),#0x00
                           1893 ;src/Renderer.c:738: xHeight=0;
   24B7 DD 36 C9 00   [19] 1894 	ld	-55 (ix),#0x00
                           1895 ;src/Renderer.c:740: lateralWallCounter = 0;
   24BB DD 36 FA 00   [19] 1896 	ld	-6 (ix),#0x00
                           1897 ;src/Renderer.c:742: newCell=1;
   24BF DD 36 D5 01   [19] 1898 	ld	-43 (ix),#0x01
                           1899 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   24C3 DD 7E C7      [19] 1900 	ld	a,-57 (ix)
   24C6 DD 77 F7      [19] 1901 	ld	-9 (ix),a
   24C9 DD 36 F8 00   [19] 1902 	ld	-8 (ix),#0x00
                           1903 ;src/Renderer.c:743: currentCellID = cells_in_view_array[lineStart + 1];
   24CD DD 4E F7      [19] 1904 	ld	c,-9 (ix)
   24D0 DD 46 F8      [19] 1905 	ld	b,-8 (ix)
   24D3 03            [ 6] 1906 	inc	bc
   24D4 DD 6E E7      [19] 1907 	ld	l,-25 (ix)
   24D7 DD 66 E8      [19] 1908 	ld	h,-24 (ix)
   24DA 09            [11] 1909 	add	hl,bc
   24DB 7E            [ 7] 1910 	ld	a,(hl)
   24DC DD 77 D4      [19] 1911 	ld	-44 (ix),a
                           1912 ;src/Renderer.c:745: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   24DF DD 7E E7      [19] 1913 	ld	a,-25 (ix)
   24E2 DD 86 C7      [19] 1914 	add	a, -57 (ix)
   24E5 6F            [ 4] 1915 	ld	l,a
   24E6 DD 7E E8      [19] 1916 	ld	a,-24 (ix)
   24E9 CE 00         [ 7] 1917 	adc	a, #0x00
   24EB 67            [ 4] 1918 	ld	h,a
   24EC 4E            [ 7] 1919 	ld	c,(hl)
                           1920 ;src/Renderer.c:746: if(lastCellWasWall&CELL_WALL_MASK){
   24ED CB 79         [ 8] 1921 	bit	7, c
   24EF 28 09         [12] 1922 	jr	Z,00183$
                           1923 ;src/Renderer.c:747: lastWallId=lastCellWasWall;
   24F1 DD 71 D6      [19] 1924 	ld	-42 (ix),c
                           1925 ;src/Renderer.c:748: lastCellWasWall=1;
   24F4 DD 36 F3 01   [19] 1926 	ld	-13 (ix),#0x01
   24F8 18 08         [12] 1927 	jr	00347$
   24FA                    1928 00183$:
                           1929 ;src/Renderer.c:751: lastCellWasWall=0;
   24FA DD 36 F3 00   [19] 1930 	ld	-13 (ix),#0x00
                           1931 ;src/Renderer.c:752: lastWallId=CELLTYPE_FLOOR;
   24FE DD 36 D6 00   [19] 1932 	ld	-42 (ix),#0x00
                           1933 ;src/Renderer.c:755: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   2502                    1934 00347$:
   2502 DD 36 D1 00   [19] 1935 	ld	-47 (ix),#0x00
   2506 DD 36 D3 00   [19] 1936 	ld	-45 (ix),#0x00
   250A                    1937 00264$:
                           1938 ;src/Renderer.c:757: if (xCellCount == zHeight)
   250A DD 7E CB      [19] 1939 	ld	a,-53 (ix)
   250D DD 96 D2      [19] 1940 	sub	a, -46 (ix)
   2510 20 4B         [12] 1941 	jr	NZ,00186$
                           1942 ;src/Renderer.c:759: ++xCell;
   2512 DD 34 D1      [23] 1943 	inc	-47 (ix)
                           1944 ;src/Renderer.c:760: xCellCount = 0;
   2515 DD 36 CB 00   [19] 1945 	ld	-53 (ix),#0x00
                           1946 ;src/Renderer.c:761: newCell=1;
   2519 DD 36 D5 01   [19] 1947 	ld	-43 (ix),#0x01
                           1948 ;src/Renderer.c:762: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   251D DD 7E D1      [19] 1949 	ld	a,-47 (ix)
   2520 DD 77 F1      [19] 1950 	ld	-15 (ix),a
   2523 DD 36 F2 00   [19] 1951 	ld	-14 (ix),#0x00
   2527 DD 7E F7      [19] 1952 	ld	a,-9 (ix)
   252A DD 86 F1      [19] 1953 	add	a, -15 (ix)
   252D DD 77 F1      [19] 1954 	ld	-15 (ix),a
   2530 DD 7E F8      [19] 1955 	ld	a,-8 (ix)
   2533 DD 8E F2      [19] 1956 	adc	a, -14 (ix)
   2536 DD 77 F2      [19] 1957 	ld	-14 (ix),a
   2539 DD 34 F1      [23] 1958 	inc	-15 (ix)
   253C 20 03         [12] 1959 	jr	NZ,00655$
   253E DD 34 F2      [23] 1960 	inc	-14 (ix)
   2541                    1961 00655$:
   2541 DD 7E F1      [19] 1962 	ld	a,-15 (ix)
   2544 DD 86 E7      [19] 1963 	add	a, -25 (ix)
   2547 DD 77 F1      [19] 1964 	ld	-15 (ix),a
   254A DD 7E F2      [19] 1965 	ld	a,-14 (ix)
   254D DD 8E E8      [19] 1966 	adc	a, -24 (ix)
   2550 DD 77 F2      [19] 1967 	ld	-14 (ix),a
   2553 DD 6E F1      [19] 1968 	ld	l,-15 (ix)
   2556 DD 66 F2      [19] 1969 	ld	h,-14 (ix)
   2559 7E            [ 7] 1970 	ld	a,(hl)
   255A DD 77 D4      [19] 1971 	ld	-44 (ix),a
   255D                    1972 00186$:
                           1973 ;src/Renderer.c:764: if(!(x%2)){
   255D DD 7E D3      [19] 1974 	ld	a,-45 (ix)
   2560 E6 01         [ 7] 1975 	and	a, #0x01
   2562 DD 77 F1      [19] 1976 	ld	-15 (ix),a
                           1977 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   2565 DD 7E D4      [19] 1978 	ld	a,-44 (ix)
   2568 E6 80         [ 7] 1979 	and	a, #0x80
   256A DD 77 EC      [19] 1980 	ld	-20 (ix),a
                           1981 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   256D DD 7E CB      [19] 1982 	ld	a,-53 (ix)
   2570 DD 77 E5      [19] 1983 	ld	-27 (ix),a
   2573 DD 36 E6 00   [19] 1984 	ld	-26 (ix),#0x00
   2577 DD 7E D2      [19] 1985 	ld	a,-46 (ix)
   257A DD 77 EA      [19] 1986 	ld	-22 (ix),a
                           1987 ;src/Renderer.c:764: if(!(x%2)){
   257D DD 7E F1      [19] 1988 	ld	a,-15 (ix)
   2580 B7            [ 4] 1989 	or	a, a
   2581 C2 79 26      [10] 1990 	jp	NZ,00199$
                           1991 ;src/Renderer.c:765: if ((lateralWallCounter == 0)||newCell)
   2584 DD 7E FA      [19] 1992 	ld	a,-6 (ix)
   2587 B7            [ 4] 1993 	or	a, a
   2588 28 07         [12] 1994 	jr	Z,00195$
   258A DD 7E D5      [19] 1995 	ld	a,-43 (ix)
   258D B7            [ 4] 1996 	or	a, a
   258E CA 79 26      [10] 1997 	jp	Z,00199$
   2591                    1998 00195$:
                           1999 ;src/Renderer.c:767: if (currentCellID & CELL_WALL_MASK)//Wall
   2591 DD 7E EC      [19] 2000 	ld	a,-20 (ix)
   2594 B7            [ 4] 2001 	or	a, a
   2595 28 2B         [12] 2002 	jr	Z,00193$
                           2003 ;src/Renderer.c:769: lateralWallCounter = 0;//(zHeight - xCellCount);
   2597 DD 36 FA 00   [19] 2004 	ld	-6 (ix),#0x00
                           2005 ;src/Renderer.c:770: lateralWallSlope = 0;
   259B DD 36 CC 00   [19] 2006 	ld	-52 (ix),#0x00
                           2007 ;src/Renderer.c:771: xHeight = zHeight;
   259F DD 7E D2      [19] 2008 	ld	a,-46 (ix)
   25A2 DD 77 C9      [19] 2009 	ld	-55 (ix),a
                           2010 ;src/Renderer.c:772: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   25A5 DD 7E D4      [19] 2011 	ld	a,-44 (ix)
   25A8 D6 80         [ 7] 2012 	sub	a, #0x80
   25AA 20 04         [12] 2013 	jr	NZ,00277$
   25AC 0E 09         [ 7] 2014 	ld	c,#0x09
   25AE 18 02         [12] 2015 	jr	00278$
   25B0                    2016 00277$:
   25B0 0E 0B         [ 7] 2017 	ld	c,#0x0B
   25B2                    2018 00278$:
   25B2 DD 71 C6      [19] 2019 	ld	-58 (ix),c
                           2020 ;src/Renderer.c:773: lastCellWasWall = 1;
   25B5 DD 36 F3 01   [19] 2021 	ld	-13 (ix),#0x01
                           2022 ;src/Renderer.c:774: lastWallId=currentCellID;
   25B9 DD 7E D4      [19] 2023 	ld	a,-44 (ix)
   25BC DD 77 D6      [19] 2024 	ld	-42 (ix),a
   25BF C3 75 26      [10] 2025 	jp	00194$
   25C2                    2026 00193$:
                           2027 ;src/Renderer.c:777: if(lateralWallCounter==0){//Lateral wall not finished
   25C2 DD 7E FA      [19] 2028 	ld	a,-6 (ix)
   25C5 B7            [ 4] 2029 	or	a, a
   25C6 C2 75 26      [10] 2030 	jp	NZ,00194$
                           2031 ;src/Renderer.c:778: if (lastCellWasWall)
   25C9 DD 7E F3      [19] 2032 	ld	a,-13 (ix)
   25CC B7            [ 4] 2033 	or	a, a
   25CD CA 65 26      [10] 2034 	jp	Z,00188$
                           2035 ;src/Renderer.c:781: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   25D0 DD 7E CF      [19] 2036 	ld	a,-49 (ix)
   25D3 DD 96 D1      [19] 2037 	sub	a, -47 (ix)
   25D6 87            [ 4] 2038 	add	a, a
   25D7 3C            [ 4] 2039 	inc	a
                           2040 ;src/Renderer.c:782: lateralWallSlopeCounter = lateralWallSlope / 2;
   25D8 DD 77 CC      [19] 2041 	ld	-52 (ix), a
   25DB CB 3F         [ 8] 2042 	srl	a
   25DD DD 77 D0      [19] 2043 	ld	-48 (ix),a
                           2044 ;src/Renderer.c:783: lateralWallCounter = lateralWallSlope * zHeight;
   25E0 DD 5E D2      [19] 2045 	ld	e,-46 (ix)
   25E3 DD 66 CC      [19] 2046 	ld	h,-52 (ix)
   25E6 2E 00         [ 7] 2047 	ld	l, #0x00
   25E8 55            [ 4] 2048 	ld	d, l
   25E9 06 08         [ 7] 2049 	ld	b, #0x08
   25EB                    2050 00658$:
   25EB 29            [11] 2051 	add	hl,hl
   25EC 30 01         [12] 2052 	jr	NC,00659$
   25EE 19            [11] 2053 	add	hl,de
   25EF                    2054 00659$:
   25EF 10 FA         [13] 2055 	djnz	00658$
   25F1 DD 75 E9      [19] 2056 	ld	-23 (ix), l
   25F4 7D            [ 4] 2057 	ld	a, l
                           2058 ;src/Renderer.c:784: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   25F5 DD 77 CD      [19] 2059 	ld	-51 (ix), a
   25F8 E6 FC         [ 7] 2060 	and	a, #0xFC
   25FA DD 77 E9      [19] 2061 	ld	-23 (ix), a
   25FD CB C7         [ 8] 2062 	set	0, a
   25FF DD 77 E9      [19] 2063 	ld	-23 (ix), a
   2602 CB 3F         [ 8] 2064 	srl	a
   2604 CB 3F         [ 8] 2065 	srl	a
   2606 DD 96 CB      [19] 2066 	sub	a, -53 (ix)
   2609 DD 77 FA      [19] 2067 	ld	-6 (ix),a
                           2068 ;src/Renderer.c:786: lastCellWasWall = 0;
   260C DD 36 F3 00   [19] 2069 	ld	-13 (ix),#0x00
                           2070 ;src/Renderer.c:787: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   2610 DD 7E E5      [19] 2071 	ld	a,-27 (ix)
   2613 DD 77 F5      [19] 2072 	ld	-11 (ix),a
   2616 DD 7E E6      [19] 2073 	ld	a,-26 (ix)
   2619 DD 77 F6      [19] 2074 	ld	-10 (ix),a
   261C DD CB F5 26   [23] 2075 	sla	-11 (ix)
   2620 DD CB F6 16   [23] 2076 	rl	-10 (ix)
   2624 DD 7E CC      [19] 2077 	ld	a,-52 (ix)
   2627 DD 77 E3      [19] 2078 	ld	-29 (ix),a
   262A DD 36 E4 00   [19] 2079 	ld	-28 (ix),#0x00
   262E DD 6E E3      [19] 2080 	ld	l,-29 (ix)
   2631 DD 66 E4      [19] 2081 	ld	h,-28 (ix)
   2634 E5            [11] 2082 	push	hl
   2635 DD 6E F5      [19] 2083 	ld	l,-11 (ix)
   2638 DD 66 F6      [19] 2084 	ld	h,-10 (ix)
   263B E5            [11] 2085 	push	hl
   263C CD 71 7C      [17] 2086 	call	__divsint
   263F F1            [10] 2087 	pop	af
   2640 F1            [10] 2088 	pop	af
   2641 DD 74 F6      [19] 2089 	ld	-10 (ix),h
   2644 DD 75 F5      [19] 2090 	ld	-11 (ix), l
   2647 DD 75 E9      [19] 2091 	ld	-23 (ix), l
   264A DD 7E EA      [19] 2092 	ld	a,-22 (ix)
   264D DD 96 E9      [19] 2093 	sub	a, -23 (ix)
   2650 DD 77 C9      [19] 2094 	ld	-55 (ix),a
                           2095 ;src/Renderer.c:788: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   2653 DD 7E D6      [19] 2096 	ld	a,-42 (ix)
   2656 D6 80         [ 7] 2097 	sub	a, #0x80
   2658 20 04         [12] 2098 	jr	NZ,00279$
   265A 0E 0A         [ 7] 2099 	ld	c,#0x0A
   265C 18 02         [12] 2100 	jr	00280$
   265E                    2101 00279$:
   265E 0E 0C         [ 7] 2102 	ld	c,#0x0C
   2660                    2103 00280$:
   2660 DD 71 C6      [19] 2104 	ld	-58 (ix),c
   2663 18 10         [12] 2105 	jr	00194$
   2665                    2106 00188$:
                           2107 ;src/Renderer.c:792: xHeight = 0;
   2665 DD 36 C9 00   [19] 2108 	ld	-55 (ix),#0x00
                           2109 ;src/Renderer.c:793: lastCellWasWall = 0;
   2669 DD 36 F3 00   [19] 2110 	ld	-13 (ix),#0x00
                           2111 ;src/Renderer.c:794: lateralWallSlope=0;
   266D DD 36 CC 00   [19] 2112 	ld	-52 (ix),#0x00
                           2113 ;src/Renderer.c:795: lastWallId=0;
   2671 DD 36 D6 00   [19] 2114 	ld	-42 (ix),#0x00
   2675                    2115 00194$:
                           2116 ;src/Renderer.c:799: newCell=0;
   2675 DD 36 D5 00   [19] 2117 	ld	-43 (ix),#0x00
   2679                    2118 00199$:
                           2119 ;src/Renderer.c:802: if (lateralWallCounter > 0)
   2679 DD 7E FA      [19] 2120 	ld	a,-6 (ix)
   267C B7            [ 4] 2121 	or	a, a
   267D 28 1E         [12] 2122 	jr	Z,00205$
                           2123 ;src/Renderer.c:805: if (lateralWallSlope != 0)
   267F DD 7E CC      [19] 2124 	ld	a,-52 (ix)
   2682 B7            [ 4] 2125 	or	a, a
   2683 28 15         [12] 2126 	jr	Z,00203$
                           2127 ;src/Renderer.c:807: if (lateralWallSlopeCounter == lateralWallSlope)
   2685 DD 7E CC      [19] 2128 	ld	a,-52 (ix)
   2688 DD 96 D0      [19] 2129 	sub	a, -48 (ix)
   268B 20 0A         [12] 2130 	jr	NZ,00201$
                           2131 ;src/Renderer.c:809: lateralWallSlopeCounter = 0;
   268D DD 36 D0 00   [19] 2132 	ld	-48 (ix),#0x00
                           2133 ;src/Renderer.c:810: xHeight -= 2;
   2691 DD 35 C9      [23] 2134 	dec	-55 (ix)
   2694 DD 35 C9      [23] 2135 	dec	-55 (ix)
   2697                    2136 00201$:
                           2137 ;src/Renderer.c:812: ++lateralWallSlopeCounter;
   2697 DD 34 D0      [23] 2138 	inc	-48 (ix)
   269A                    2139 00203$:
                           2140 ;src/Renderer.c:815: --lateralWallCounter;
   269A DD 35 FA      [23] 2141 	dec	-6 (ix)
   269D                    2142 00205$:
                           2143 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   269D DD 7E D2      [19] 2144 	ld	a,-46 (ix)
   26A0 DD 77 F5      [19] 2145 	ld	-11 (ix),a
   26A3 DD 36 F6 00   [19] 2146 	ld	-10 (ix),#0x00
                           2147 ;src/Renderer.c:818: if (!(x%2))
   26A7 DD 7E F1      [19] 2148 	ld	a,-15 (ix)
   26AA B7            [ 4] 2149 	or	a, a
   26AB C2 3E 27      [10] 2150 	jp	NZ,00216$
                           2151 ;src/Renderer.c:821: draw_column_to_buffer_untextured(x/2, xHeight, color);
   26AE DD 7E D3      [19] 2152 	ld	a,-45 (ix)
   26B1 CB 3F         [ 8] 2153 	srl	a
   26B3 DD 77 F1      [19] 2154 	ld	-15 (ix),a
                           2155 ;src/Renderer.c:820: if(xHeight > 0){
   26B6 DD 7E C9      [19] 2156 	ld	a,-55 (ix)
   26B9 B7            [ 4] 2157 	or	a, a
   26BA 28 11         [12] 2158 	jr	Z,00207$
                           2159 ;src/Renderer.c:821: draw_column_to_buffer_untextured(x/2, xHeight, color);
   26BC DD 66 C6      [19] 2160 	ld	h,-58 (ix)
   26BF DD 6E C9      [19] 2161 	ld	l,-55 (ix)
   26C2 E5            [11] 2162 	push	hl
   26C3 DD 7E F1      [19] 2163 	ld	a,-15 (ix)
   26C6 F5            [11] 2164 	push	af
   26C7 33            [ 6] 2165 	inc	sp
   26C8 CD C8 1A      [17] 2166 	call	_draw_column_to_buffer_untextured
   26CB F1            [10] 2167 	pop	af
   26CC 33            [ 6] 2168 	inc	sp
   26CD                    2169 00207$:
                           2170 ;src/Renderer.c:824: if(!(currentCellID&CELL_WALL_MASK)){
   26CD DD 7E EC      [19] 2171 	ld	a,-20 (ix)
   26D0 B7            [ 4] 2172 	or	a, a
   26D1 20 6B         [12] 2173 	jr	NZ,00216$
                           2174 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   26D3 DD 7E E5      [19] 2175 	ld	a,-27 (ix)
   26D6 DD 77 EC      [19] 2176 	ld	-20 (ix),a
   26D9 DD 7E E6      [19] 2177 	ld	a,-26 (ix)
   26DC DD 77 ED      [19] 2178 	ld	-19 (ix),a
   26DF 3E 06         [ 7] 2179 	ld	a,#0x05+1
   26E1 18 08         [12] 2180 	jr	00667$
   26E3                    2181 00666$:
   26E3 DD CB EC 26   [23] 2182 	sla	-20 (ix)
   26E7 DD CB ED 16   [23] 2183 	rl	-19 (ix)
   26EB                    2184 00667$:
   26EB 3D            [ 4] 2185 	dec	a
   26EC 20 F5         [12] 2186 	jr	NZ,00666$
   26EE DD 6E F5      [19] 2187 	ld	l,-11 (ix)
   26F1 DD 66 F6      [19] 2188 	ld	h,-10 (ix)
   26F4 E5            [11] 2189 	push	hl
   26F5 DD 6E EC      [19] 2190 	ld	l,-20 (ix)
   26F8 DD 66 ED      [19] 2191 	ld	h,-19 (ix)
   26FB E5            [11] 2192 	push	hl
   26FC CD 71 7C      [17] 2193 	call	__divsint
   26FF F1            [10] 2194 	pop	af
   2700 F1            [10] 2195 	pop	af
   2701 DD 74 ED      [19] 2196 	ld	-19 (ix),h
   2704 DD 75 EC      [19] 2197 	ld	-20 (ix), l
   2707 45            [ 4] 2198 	ld	b, l
                           2199 ;src/Renderer.c:825: if(currentCellID&CELL_ENEMY_MASK){
   2708 DD 7E D4      [19] 2200 	ld	a,-44 (ix)
   270B E6 0F         [ 7] 2201 	and	a, #0x0F
   270D 28 15         [12] 2202 	jr	Z,00211$
                           2203 ;src/Renderer.c:826: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   270F C5            [11] 2204 	push	bc
   2710 33            [ 6] 2205 	inc	sp
   2711 DD 66 D4      [19] 2206 	ld	h,-44 (ix)
   2714 DD 6E D2      [19] 2207 	ld	l,-46 (ix)
   2717 E5            [11] 2208 	push	hl
   2718 DD 7E F1      [19] 2209 	ld	a,-15 (ix)
   271B F5            [11] 2210 	push	af
   271C 33            [ 6] 2211 	inc	sp
   271D CD 3B 1C      [17] 2212 	call	_draw_column_to_buffer_enemy
   2720 F1            [10] 2213 	pop	af
   2721 F1            [10] 2214 	pop	af
   2722 18 1A         [12] 2215 	jr	00216$
   2724                    2216 00211$:
                           2217 ;src/Renderer.c:828: else if(currentCellID&CELL_ITEM_MASK){
   2724 DD 7E D4      [19] 2218 	ld	a,-44 (ix)
   2727 E6 70         [ 7] 2219 	and	a, #0x70
   2729 28 13         [12] 2220 	jr	Z,00216$
                           2221 ;src/Renderer.c:829: draw_column_to_buffer_object(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   272B C5            [11] 2222 	push	bc
   272C 33            [ 6] 2223 	inc	sp
   272D DD 66 D4      [19] 2224 	ld	h,-44 (ix)
   2730 DD 6E D2      [19] 2225 	ld	l,-46 (ix)
   2733 E5            [11] 2226 	push	hl
   2734 DD 7E F1      [19] 2227 	ld	a,-15 (ix)
   2737 F5            [11] 2228 	push	af
   2738 33            [ 6] 2229 	inc	sp
   2739 CD 40 1B      [17] 2230 	call	_draw_column_to_buffer_object
   273C F1            [10] 2231 	pop	af
   273D F1            [10] 2232 	pop	af
   273E                    2233 00216$:
                           2234 ;src/Renderer.c:834: ++xCellCount;
   273E DD 34 CB      [23] 2235 	inc	-53 (ix)
                           2236 ;src/Renderer.c:755: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   2741 DD 34 D3      [23] 2237 	inc	-45 (ix)
                           2238 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   2744 2A C1 1A      [16] 2239 	ld	hl,(_cells_in_view_array)
   2747 DD 75 E7      [19] 2240 	ld	-25 (ix),l
   274A DD 74 E8      [19] 2241 	ld	-24 (ix),h
                           2242 ;src/Renderer.c:755: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   274D DD 7E D3      [19] 2243 	ld	a,-45 (ix)
   2750 D6 50         [ 7] 2244 	sub	a, #0x50
   2752 DA 0A 25      [10] 2245 	jp	C,00264$
                           2246 ;src/Renderer.c:841: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   2755 DD 7E CA      [19] 2247 	ld	a,-54 (ix)
   2758 B7            [ 4] 2248 	or	a, a
   2759 28 08         [12] 2249 	jr	Z,00281$
   275B DD 7E FC      [19] 2250 	ld	a,-4 (ix)
   275E DD 77 FC      [19] 2251 	ld	-4 (ix),a
   2761 18 04         [12] 2252 	jr	00282$
   2763                    2253 00281$:
   2763 DD 36 FC 00   [19] 2254 	ld	-4 (ix),#0x00
   2767                    2255 00282$:
   2767 DD 7E FC      [19] 2256 	ld	a,-4 (ix)
   276A DD 77 FC      [19] 2257 	ld	-4 (ix),a
                           2258 ;src/Renderer.c:842: lateralWallSlope=0;
   276D DD 36 FA 00   [19] 2259 	ld	-6 (ix),#0x00
                           2260 ;src/Renderer.c:843: lateralWallSlopeCounter=0;
   2771 DD 36 F7 00   [19] 2261 	ld	-9 (ix),#0x00
                           2262 ;src/Renderer.c:844: xHeight=0;
   2775 DD 36 F3 00   [19] 2263 	ld	-13 (ix),#0x00
                           2264 ;src/Renderer.c:846: lateralWallCounter = 0;
   2779 DD 36 F1 00   [19] 2265 	ld	-15 (ix),#0x00
                           2266 ;src/Renderer.c:585: lineEnd = lineStart + offsetDiff * 2 + 2;
   277D DD 7E CF      [19] 2267 	ld	a,-49 (ix)
   2780 87            [ 4] 2268 	add	a, a
   2781 DD 77 EC      [19] 2269 	ld	-20 (ix),a
   2784 DD 7E C7      [19] 2270 	ld	a,-57 (ix)
   2787 DD 86 EC      [19] 2271 	add	a, -20 (ix)
                           2272 ;src/Renderer.c:847: lineEnd = lineStart + offsetDiff * 2 + 2;
   278A DD 77 EC      [19] 2273 	ld	-20 (ix), a
   278D C6 02         [ 7] 2274 	add	a, #0x02
   278F DD 77 C8      [19] 2275 	ld	-56 (ix),a
                           2276 ;src/Renderer.c:849: newCell=1;
   2792 DD 36 E9 01   [19] 2277 	ld	-23 (ix),#0x01
                           2278 ;src/Renderer.c:588: currentCellID = cells_in_view_array[lineEnd - 1];
   2796 DD 7E C8      [19] 2279 	ld	a,-56 (ix)
   2799 DD 77 E5      [19] 2280 	ld	-27 (ix),a
   279C DD 36 E6 00   [19] 2281 	ld	-26 (ix),#0x00
                           2282 ;src/Renderer.c:850: currentCellID = cells_in_view_array[lineEnd - 1];
   27A0 DD 7E E5      [19] 2283 	ld	a,-27 (ix)
   27A3 C6 FF         [ 7] 2284 	add	a,#0xFF
   27A5 DD 77 E3      [19] 2285 	ld	-29 (ix),a
   27A8 DD 7E E6      [19] 2286 	ld	a,-26 (ix)
   27AB CE FF         [ 7] 2287 	adc	a,#0xFF
   27AD DD 77 E4      [19] 2288 	ld	-28 (ix),a
   27B0 DD 7E E7      [19] 2289 	ld	a,-25 (ix)
   27B3 DD 86 E3      [19] 2290 	add	a, -29 (ix)
   27B6 DD 77 E3      [19] 2291 	ld	-29 (ix),a
   27B9 DD 7E E8      [19] 2292 	ld	a,-24 (ix)
   27BC DD 8E E4      [19] 2293 	adc	a, -28 (ix)
   27BF DD 77 E4      [19] 2294 	ld	-28 (ix),a
   27C2 DD 6E E3      [19] 2295 	ld	l,-29 (ix)
   27C5 DD 66 E4      [19] 2296 	ld	h,-28 (ix)
   27C8 7E            [ 7] 2297 	ld	a,(hl)
   27C9 DD 77 D8      [19] 2298 	ld	-40 (ix),a
                           2299 ;src/Renderer.c:852: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   27CC DD 7E E7      [19] 2300 	ld	a,-25 (ix)
   27CF DD 86 C8      [19] 2301 	add	a, -56 (ix)
   27D2 DD 77 E3      [19] 2302 	ld	-29 (ix),a
   27D5 DD 7E E8      [19] 2303 	ld	a,-24 (ix)
   27D8 CE 00         [ 7] 2304 	adc	a, #0x00
   27DA DD 77 E4      [19] 2305 	ld	-28 (ix),a
   27DD DD 6E E3      [19] 2306 	ld	l,-29 (ix)
   27E0 DD 66 E4      [19] 2307 	ld	h,-28 (ix)
   27E3 7E            [ 7] 2308 	ld	a,(hl)
   27E4 DD 77 EF      [19] 2309 	ld	-17 (ix),a
                           2310 ;src/Renderer.c:853: if(lastCellWasWall&CELL_WALL_MASK){
   27E7 DD CB EF 7E   [20] 2311 	bit	7, -17 (ix)
   27EB 28 06         [12] 2312 	jr	Z,00219$
                           2313 ;src/Renderer.c:854: lastWallId=lastCellWasWall;
                           2314 ;src/Renderer.c:855: lastCellWasWall=1;
   27ED DD 36 D7 01   [19] 2315 	ld	-41 (ix),#0x01
   27F1 18 08         [12] 2316 	jr	00368$
   27F3                    2317 00219$:
                           2318 ;src/Renderer.c:858: lastCellWasWall=0;
   27F3 DD 36 D7 00   [19] 2319 	ld	-41 (ix),#0x00
                           2320 ;src/Renderer.c:859: lastWallId=CELLTYPE_FLOOR;
   27F7 DD 36 EF 00   [19] 2321 	ld	-17 (ix),#0x00
                           2322 ;src/Renderer.c:862: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   27FB                    2323 00368$:
   27FB DD 36 D1 00   [19] 2324 	ld	-47 (ix),#0x00
   27FF DD 36 D3 9F   [19] 2325 	ld	-45 (ix),#0x9F
   2803                    2326 00266$:
                           2327 ;src/Renderer.c:865: if (xCellCount == zHeight)
   2803 DD 7E D2      [19] 2328 	ld	a,-46 (ix)
   2806 DD 96 FC      [19] 2329 	sub	a, -4 (ix)
   2809 20 50         [12] 2330 	jr	NZ,00222$
                           2331 ;src/Renderer.c:867: ++xCell;
   280B DD 34 D1      [23] 2332 	inc	-47 (ix)
                           2333 ;src/Renderer.c:868: xCellCount = 0;
   280E DD 36 FC 00   [19] 2334 	ld	-4 (ix),#0x00
                           2335 ;src/Renderer.c:869: newCell=1;
   2812 DD 36 E9 01   [19] 2336 	ld	-23 (ix),#0x01
                           2337 ;src/Renderer.c:870: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   2816 DD 7E D1      [19] 2338 	ld	a,-47 (ix)
   2819 DD 77 E3      [19] 2339 	ld	-29 (ix),a
   281C DD 36 E4 00   [19] 2340 	ld	-28 (ix),#0x00
   2820 DD 7E E5      [19] 2341 	ld	a,-27 (ix)
   2823 DD 96 E3      [19] 2342 	sub	a, -29 (ix)
   2826 DD 77 E3      [19] 2343 	ld	-29 (ix),a
   2829 DD 7E E6      [19] 2344 	ld	a,-26 (ix)
   282C DD 9E E4      [19] 2345 	sbc	a, -28 (ix)
   282F DD 77 E4      [19] 2346 	ld	-28 (ix),a
   2832 DD 6E E3      [19] 2347 	ld	l,-29 (ix)
   2835 DD 66 E4      [19] 2348 	ld	h,-28 (ix)
   2838 2B            [ 6] 2349 	dec	hl
   2839 DD 75 E3      [19] 2350 	ld	-29 (ix),l
   283C DD 74 E4      [19] 2351 	ld	-28 (ix),h
   283F DD 7E E7      [19] 2352 	ld	a,-25 (ix)
   2842 DD 86 E3      [19] 2353 	add	a, -29 (ix)
   2845 DD 77 E3      [19] 2354 	ld	-29 (ix),a
   2848 DD 7E E8      [19] 2355 	ld	a,-24 (ix)
   284B DD 8E E4      [19] 2356 	adc	a, -28 (ix)
   284E DD 77 E4      [19] 2357 	ld	-28 (ix),a
   2851 DD 6E E3      [19] 2358 	ld	l,-29 (ix)
   2854 DD 66 E4      [19] 2359 	ld	h,-28 (ix)
   2857 7E            [ 7] 2360 	ld	a,(hl)
   2858 DD 77 D8      [19] 2361 	ld	-40 (ix),a
   285B                    2362 00222$:
                           2363 ;src/Renderer.c:872: if(!(x%2)){
   285B DD 7E D3      [19] 2364 	ld	a,-45 (ix)
   285E E6 01         [ 7] 2365 	and	a, #0x01
   2860 DD 77 DB      [19] 2366 	ld	-37 (ix),a
                           2367 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   2863 DD 7E D8      [19] 2368 	ld	a,-40 (ix)
   2866 E6 80         [ 7] 2369 	and	a, #0x80
   2868 DD 77 E3      [19] 2370 	ld	-29 (ix),a
                           2371 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   286B DD 7E FC      [19] 2372 	ld	a,-4 (ix)
   286E DD 77 FE      [19] 2373 	ld	-2 (ix),a
   2871 DD 36 FF 00   [19] 2374 	ld	-1 (ix),#0x00
                           2375 ;src/Renderer.c:872: if(!(x%2)){
   2875 DD 7E DB      [19] 2376 	ld	a,-37 (ix)
   2878 B7            [ 4] 2377 	or	a, a
   2879 C2 A7 29      [10] 2378 	jp	NZ,00235$
                           2379 ;src/Renderer.c:873: if (lateralWallCounter == 0 || newCell)
   287C DD 7E F1      [19] 2380 	ld	a,-15 (ix)
   287F B7            [ 4] 2381 	or	a, a
   2880 28 07         [12] 2382 	jr	Z,00231$
   2882 DD 7E E9      [19] 2383 	ld	a,-23 (ix)
   2885 B7            [ 4] 2384 	or	a, a
   2886 CA A7 29      [10] 2385 	jp	Z,00235$
   2889                    2386 00231$:
                           2387 ;src/Renderer.c:875: if ( currentCellID & CELL_WALL_MASK)//Wall
   2889 DD 7E E3      [19] 2388 	ld	a,-29 (ix)
   288C B7            [ 4] 2389 	or	a, a
   288D 28 32         [12] 2390 	jr	Z,00229$
                           2391 ;src/Renderer.c:877: lateralWallCounter = 0;
   288F DD 36 F1 00   [19] 2392 	ld	-15 (ix),#0x00
                           2393 ;src/Renderer.c:878: lateralWallSlope = 0;
   2893 DD 36 FA 00   [19] 2394 	ld	-6 (ix),#0x00
                           2395 ;src/Renderer.c:879: xHeight = zHeight;
   2897 DD 7E D2      [19] 2396 	ld	a,-46 (ix)
   289A DD 77 F3      [19] 2397 	ld	-13 (ix),a
                           2398 ;src/Renderer.c:880: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   289D DD 7E D8      [19] 2399 	ld	a,-40 (ix)
   28A0 D6 80         [ 7] 2400 	sub	a, #0x80
   28A2 20 06         [12] 2401 	jr	NZ,00283$
   28A4 DD 36 DC 09   [19] 2402 	ld	-36 (ix),#0x09
   28A8 18 04         [12] 2403 	jr	00284$
   28AA                    2404 00283$:
   28AA DD 36 DC 0B   [19] 2405 	ld	-36 (ix),#0x0B
   28AE                    2406 00284$:
   28AE DD 7E DC      [19] 2407 	ld	a,-36 (ix)
   28B1 DD 77 C6      [19] 2408 	ld	-58 (ix),a
                           2409 ;src/Renderer.c:881: lastCellWasWall = 1;
   28B4 DD 36 D7 01   [19] 2410 	ld	-41 (ix),#0x01
                           2411 ;src/Renderer.c:882: lastWallId=currentCellID;
   28B8 DD 7E D8      [19] 2412 	ld	a,-40 (ix)
   28BB DD 77 EF      [19] 2413 	ld	-17 (ix),a
   28BE C3 A3 29      [10] 2414 	jp	00230$
   28C1                    2415 00229$:
                           2416 ;src/Renderer.c:884: else if(lateralWallCounter==0){
   28C1 DD 7E F1      [19] 2417 	ld	a,-15 (ix)
   28C4 B7            [ 4] 2418 	or	a, a
   28C5 C2 A3 29      [10] 2419 	jp	NZ,00230$
                           2420 ;src/Renderer.c:885: if (lastCellWasWall)
   28C8 DD 7E D7      [19] 2421 	ld	a,-41 (ix)
   28CB B7            [ 4] 2422 	or	a, a
   28CC CA 93 29      [10] 2423 	jp	Z,00224$
                           2424 ;src/Renderer.c:888: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   28CF DD 7E CF      [19] 2425 	ld	a,-49 (ix)
   28D2 DD 96 D1      [19] 2426 	sub	a, -47 (ix)
   28D5 87            [ 4] 2427 	add	a, a
   28D6 3C            [ 4] 2428 	inc	a
                           2429 ;src/Renderer.c:889: lateralWallSlopeCounter = lateralWallSlope / 2;
   28D7 DD 77 FA      [19] 2430 	ld	-6 (ix), a
   28DA CB 3F         [ 8] 2431 	srl	a
   28DC DD 77 F7      [19] 2432 	ld	-9 (ix),a
                           2433 ;src/Renderer.c:890: lateralWallCounter = lateralWallSlope * zHeight;
   28DF DD 5E D2      [19] 2434 	ld	e,-46 (ix)
   28E2 DD 66 FA      [19] 2435 	ld	h,-6 (ix)
   28E5 2E 00         [ 7] 2436 	ld	l, #0x00
   28E7 55            [ 4] 2437 	ld	d, l
   28E8 06 08         [ 7] 2438 	ld	b, #0x08
   28EA                    2439 00675$:
   28EA 29            [11] 2440 	add	hl,hl
   28EB 30 01         [12] 2441 	jr	NC,00676$
   28ED 19            [11] 2442 	add	hl,de
   28EE                    2443 00676$:
   28EE 10 FA         [13] 2444 	djnz	00675$
                           2445 ;src/Renderer.c:891: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   28F0 DD 75 DC      [19] 2446 	ld	-36 (ix), l
   28F3 DD 75 E1      [19] 2447 	ld	-31 (ix), l
   28F6 DD 36 E2 00   [19] 2448 	ld	-30 (ix),#0x00
   28FA DD 7E DC      [19] 2449 	ld	a,-36 (ix)
   28FD E6 03         [ 7] 2450 	and	a, #0x03
   28FF DD 77 DC      [19] 2451 	ld	-36 (ix), a
   2902 DD 77 DF      [19] 2452 	ld	-33 (ix),a
   2905 DD 36 E0 00   [19] 2453 	ld	-32 (ix),#0x00
   2909 DD 7E E1      [19] 2454 	ld	a,-31 (ix)
   290C DD 96 DF      [19] 2455 	sub	a, -33 (ix)
   290F DD 77 DF      [19] 2456 	ld	-33 (ix),a
   2912 DD 7E E2      [19] 2457 	ld	a,-30 (ix)
   2915 DD 9E E0      [19] 2458 	sbc	a, -32 (ix)
   2918 DD 77 E0      [19] 2459 	ld	-32 (ix),a
   291B DD 7E DF      [19] 2460 	ld	a,-33 (ix)
   291E C6 01         [ 7] 2461 	add	a, #0x01
   2920 DD 77 E1      [19] 2462 	ld	-31 (ix),a
   2923 DD 7E E0      [19] 2463 	ld	a,-32 (ix)
   2926 CE 00         [ 7] 2464 	adc	a, #0x00
   2928 DD 77 E2      [19] 2465 	ld	-30 (ix),a
   292B DD 7E E1      [19] 2466 	ld	a,-31 (ix)
   292E DD 77 DD      [19] 2467 	ld	-35 (ix),a
   2931 DD 7E E2      [19] 2468 	ld	a,-30 (ix)
   2934 DD 77 DE      [19] 2469 	ld	-34 (ix),a
   2937 DD CB E2 7E   [20] 2470 	bit	7, -30 (ix)
   293B 28 10         [12] 2471 	jr	Z,00285$
   293D DD 7E DF      [19] 2472 	ld	a,-33 (ix)
   2940 C6 04         [ 7] 2473 	add	a, #0x04
   2942 DD 77 DD      [19] 2474 	ld	-35 (ix),a
   2945 DD 7E E0      [19] 2475 	ld	a,-32 (ix)
   2948 CE 00         [ 7] 2476 	adc	a, #0x00
   294A DD 77 DE      [19] 2477 	ld	-34 (ix),a
   294D                    2478 00285$:
   294D DD 4E DD      [19] 2479 	ld	c,-35 (ix)
   2950 DD 46 DE      [19] 2480 	ld	b,-34 (ix)
   2953 CB 28         [ 8] 2481 	sra	b
   2955 CB 19         [ 8] 2482 	rr	c
   2957 CB 28         [ 8] 2483 	sra	b
   2959 CB 19         [ 8] 2484 	rr	c
   295B DD 46 FC      [19] 2485 	ld	b,-4 (ix)
   295E 79            [ 4] 2486 	ld	a,c
   295F 90            [ 4] 2487 	sub	a, b
   2960 DD 77 F1      [19] 2488 	ld	-15 (ix),a
                           2489 ;src/Renderer.c:893: lastCellWasWall = 0;
   2963 DD 36 D7 00   [19] 2490 	ld	-41 (ix),#0x00
                           2491 ;src/Renderer.c:894: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   2967 DD 6E FE      [19] 2492 	ld	l,-2 (ix)
   296A DD 66 FF      [19] 2493 	ld	h,-1 (ix)
   296D 29            [11] 2494 	add	hl, hl
   296E DD 4E FA      [19] 2495 	ld	c,-6 (ix)
   2971 06 00         [ 7] 2496 	ld	b,#0x00
   2973 C5            [11] 2497 	push	bc
   2974 E5            [11] 2498 	push	hl
   2975 CD 71 7C      [17] 2499 	call	__divsint
   2978 F1            [10] 2500 	pop	af
   2979 F1            [10] 2501 	pop	af
   297A DD 7E EA      [19] 2502 	ld	a,-22 (ix)
   297D 95            [ 4] 2503 	sub	a, l
   297E DD 77 F3      [19] 2504 	ld	-13 (ix),a
                           2505 ;src/Renderer.c:895: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   2981 DD 7E EF      [19] 2506 	ld	a,-17 (ix)
   2984 D6 80         [ 7] 2507 	sub	a, #0x80
   2986 20 04         [12] 2508 	jr	NZ,00286$
   2988 0E 0A         [ 7] 2509 	ld	c,#0x0A
   298A 18 02         [12] 2510 	jr	00287$
   298C                    2511 00286$:
   298C 0E 0C         [ 7] 2512 	ld	c,#0x0C
   298E                    2513 00287$:
   298E DD 71 C6      [19] 2514 	ld	-58 (ix),c
   2991 18 10         [12] 2515 	jr	00230$
   2993                    2516 00224$:
                           2517 ;src/Renderer.c:899: xHeight = 0;
   2993 DD 36 F3 00   [19] 2518 	ld	-13 (ix),#0x00
                           2519 ;src/Renderer.c:900: lastCellWasWall = 0;
   2997 DD 36 D7 00   [19] 2520 	ld	-41 (ix),#0x00
                           2521 ;src/Renderer.c:901: lateralWallSlope=0;
   299B DD 36 FA 00   [19] 2522 	ld	-6 (ix),#0x00
                           2523 ;src/Renderer.c:902: lastWallId=0;
   299F DD 36 EF 00   [19] 2524 	ld	-17 (ix),#0x00
   29A3                    2525 00230$:
                           2526 ;src/Renderer.c:905: newCell=0;
   29A3 DD 36 E9 00   [19] 2527 	ld	-23 (ix),#0x00
   29A7                    2528 00235$:
                           2529 ;src/Renderer.c:910: if (lateralWallCounter > 0)
   29A7 DD 7E F1      [19] 2530 	ld	a,-15 (ix)
   29AA B7            [ 4] 2531 	or	a, a
   29AB 28 1E         [12] 2532 	jr	Z,00241$
                           2533 ;src/Renderer.c:913: if (lateralWallSlope != 0)
   29AD DD 7E FA      [19] 2534 	ld	a,-6 (ix)
   29B0 B7            [ 4] 2535 	or	a, a
   29B1 28 15         [12] 2536 	jr	Z,00239$
                           2537 ;src/Renderer.c:915: if (lateralWallSlopeCounter == lateralWallSlope)
   29B3 DD 7E FA      [19] 2538 	ld	a,-6 (ix)
   29B6 DD 96 F7      [19] 2539 	sub	a, -9 (ix)
   29B9 20 0A         [12] 2540 	jr	NZ,00237$
                           2541 ;src/Renderer.c:917: lateralWallSlopeCounter = 0;
   29BB DD 36 F7 00   [19] 2542 	ld	-9 (ix),#0x00
                           2543 ;src/Renderer.c:918: xHeight -= 2;
   29BF DD 35 F3      [23] 2544 	dec	-13 (ix)
   29C2 DD 35 F3      [23] 2545 	dec	-13 (ix)
   29C5                    2546 00237$:
                           2547 ;src/Renderer.c:920: ++lateralWallSlopeCounter;
   29C5 DD 34 F7      [23] 2548 	inc	-9 (ix)
   29C8                    2549 00239$:
                           2550 ;src/Renderer.c:922: --lateralWallCounter;
   29C8 DD 35 F1      [23] 2551 	dec	-15 (ix)
   29CB                    2552 00241$:
                           2553 ;src/Renderer.c:926: if (!(x%2))
   29CB DD 7E DB      [19] 2554 	ld	a,-37 (ix)
   29CE B7            [ 4] 2555 	or	a, a
   29CF 20 74         [12] 2556 	jr	NZ,00252$
                           2557 ;src/Renderer.c:931: draw_column_to_buffer_untextured(x/2, xHeight, color);
   29D1 DD 46 D3      [19] 2558 	ld	b,-45 (ix)
   29D4 CB 38         [ 8] 2559 	srl	b
                           2560 ;src/Renderer.c:929: if(xHeight > 0){
   29D6 DD 7E F3      [19] 2561 	ld	a,-13 (ix)
   29D9 B7            [ 4] 2562 	or	a, a
   29DA 28 10         [12] 2563 	jr	Z,00243$
                           2564 ;src/Renderer.c:931: draw_column_to_buffer_untextured(x/2, xHeight, color);
   29DC C5            [11] 2565 	push	bc
   29DD DD 66 C6      [19] 2566 	ld	h,-58 (ix)
   29E0 DD 6E F3      [19] 2567 	ld	l,-13 (ix)
   29E3 E5            [11] 2568 	push	hl
   29E4 C5            [11] 2569 	push	bc
   29E5 33            [ 6] 2570 	inc	sp
   29E6 CD C8 1A      [17] 2571 	call	_draw_column_to_buffer_untextured
   29E9 F1            [10] 2572 	pop	af
   29EA 33            [ 6] 2573 	inc	sp
   29EB C1            [10] 2574 	pop	bc
   29EC                    2575 00243$:
                           2576 ;src/Renderer.c:934: if(!(currentCellID&CELL_WALL_MASK)){
   29EC DD 7E E3      [19] 2577 	ld	a,-29 (ix)
   29EF B7            [ 4] 2578 	or	a, a
   29F0 20 53         [12] 2579 	jr	NZ,00252$
                           2580 ;src/Renderer.c:674: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   29F2 DD 7E F5      [19] 2581 	ld	a,-11 (ix)
   29F5 DD 96 FE      [19] 2582 	sub	a, -2 (ix)
   29F8 6F            [ 4] 2583 	ld	l,a
   29F9 DD 7E F6      [19] 2584 	ld	a,-10 (ix)
   29FC DD 9E FF      [19] 2585 	sbc	a, -1 (ix)
   29FF 67            [ 4] 2586 	ld	h,a
   2A00 29            [11] 2587 	add	hl, hl
   2A01 29            [11] 2588 	add	hl, hl
   2A02 29            [11] 2589 	add	hl, hl
   2A03 29            [11] 2590 	add	hl, hl
   2A04 29            [11] 2591 	add	hl, hl
   2A05 C5            [11] 2592 	push	bc
   2A06 DD 5E F5      [19] 2593 	ld	e,-11 (ix)
   2A09 DD 56 F6      [19] 2594 	ld	d,-10 (ix)
   2A0C D5            [11] 2595 	push	de
   2A0D E5            [11] 2596 	push	hl
   2A0E CD 71 7C      [17] 2597 	call	__divsint
   2A11 F1            [10] 2598 	pop	af
   2A12 F1            [10] 2599 	pop	af
   2A13 55            [ 4] 2600 	ld	d,l
   2A14 C1            [10] 2601 	pop	bc
                           2602 ;src/Renderer.c:935: if(currentCellID&CELL_ENEMY_MASK){
   2A15 DD 7E D8      [19] 2603 	ld	a,-40 (ix)
   2A18 E6 0F         [ 7] 2604 	and	a, #0x0F
   2A1A 28 12         [12] 2605 	jr	Z,00247$
                           2606 ;src/Renderer.c:936: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   2A1C D5            [11] 2607 	push	de
   2A1D 33            [ 6] 2608 	inc	sp
   2A1E DD 66 D8      [19] 2609 	ld	h,-40 (ix)
   2A21 DD 6E D2      [19] 2610 	ld	l,-46 (ix)
   2A24 E5            [11] 2611 	push	hl
   2A25 C5            [11] 2612 	push	bc
   2A26 33            [ 6] 2613 	inc	sp
   2A27 CD 3B 1C      [17] 2614 	call	_draw_column_to_buffer_enemy
   2A2A F1            [10] 2615 	pop	af
   2A2B F1            [10] 2616 	pop	af
   2A2C 18 17         [12] 2617 	jr	00252$
   2A2E                    2618 00247$:
                           2619 ;src/Renderer.c:938: else if(currentCellID&CELL_ITEM_MASK){
   2A2E DD 7E D8      [19] 2620 	ld	a,-40 (ix)
   2A31 E6 70         [ 7] 2621 	and	a, #0x70
   2A33 28 10         [12] 2622 	jr	Z,00252$
                           2623 ;src/Renderer.c:939: draw_column_to_buffer_object(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   2A35 D5            [11] 2624 	push	de
   2A36 33            [ 6] 2625 	inc	sp
   2A37 DD 66 D8      [19] 2626 	ld	h,-40 (ix)
   2A3A DD 6E D2      [19] 2627 	ld	l,-46 (ix)
   2A3D E5            [11] 2628 	push	hl
   2A3E C5            [11] 2629 	push	bc
   2A3F 33            [ 6] 2630 	inc	sp
   2A40 CD 40 1B      [17] 2631 	call	_draw_column_to_buffer_object
   2A43 F1            [10] 2632 	pop	af
   2A44 F1            [10] 2633 	pop	af
   2A45                    2634 00252$:
                           2635 ;src/Renderer.c:943: ++xCellCount;
   2A45 DD 34 FC      [23] 2636 	inc	-4 (ix)
                           2637 ;src/Renderer.c:862: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   2A48 DD 35 D3      [23] 2638 	dec	-45 (ix)
                           2639 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   2A4B 2A C1 1A      [16] 2640 	ld	hl,(_cells_in_view_array)
   2A4E DD 75 E7      [19] 2641 	ld	-25 (ix),l
   2A51 DD 74 E8      [19] 2642 	ld	-24 (ix),h
                           2643 ;src/Renderer.c:862: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   2A54 DD 7E D3      [19] 2644 	ld	a,-45 (ix)
   2A57 D6 50         [ 7] 2645 	sub	a, #0x50
   2A59 D2 03 28      [10] 2646 	jp	NC,00266$
                           2647 ;src/Renderer.c:972: lineStart = lineStart + (offsetDiff * 2) + 3;
   2A5C DD 7E EC      [19] 2648 	ld	a,-20 (ix)
   2A5F C6 03         [ 7] 2649 	add	a, #0x03
   2A61 DD 77 C7      [19] 2650 	ld	-57 (ix),a
                           2651 ;src/Renderer.c:973: zHeight += zHeight;
   2A64 DD CB D2 26   [23] 2652 	sla	-46 (ix)
                           2653 ;src/Renderer.c:974: offsetDiff = offsetDiff >> 1;
   2A68 DD CB CF 3E   [23] 2654 	srl	-49 (ix)
                           2655 ;src/Renderer.c:976: }while(z);
   2A6C DD 7E CA      [19] 2656 	ld	a,-54 (ix)
   2A6F B7            [ 4] 2657 	or	a, a
   2A70 C2 94 24      [10] 2658 	jp	NZ,00254$
   2A73                    2659 00268$:
   2A73 DD F9         [10] 2660 	ld	sp, ix
   2A75 DD E1         [14] 2661 	pop	ix
   2A77 C9            [10] 2662 	ret
                           2663 ;src/Renderer.c:982: void draw_minimap_to_buffer(){
                           2664 ;	---------------------------------
                           2665 ; Function draw_minimap_to_buffer
                           2666 ; ---------------------------------
   2A78                    2667 _draw_minimap_to_buffer::
   2A78 DD E5         [15] 2668 	push	ix
   2A7A DD 21 00 00   [14] 2669 	ld	ix,#0
   2A7E DD 39         [15] 2670 	add	ix,sp
   2A80 21 F5 FF      [10] 2671 	ld	hl,#-11
   2A83 39            [11] 2672 	add	hl,sp
   2A84 F9            [ 6] 2673 	ld	sp,hl
                           2674 ;src/Renderer.c:985: u8* ptr = MINIMAP_BUFFER;
   2A85 01 F0 B9      [10] 2675 	ld	bc,#0xB9F0
                           2676 ;src/Renderer.c:990: y=(player_position.y-MINIMAP_HEIGHT_HALF);
   2A88 3A 76 18      [13] 2677 	ld	a, (#(_player_position + 0x0001) + 0)
   2A8B C6 F8         [ 7] 2678 	add	a,#0xF8
   2A8D 5F            [ 4] 2679 	ld	e,a
                           2680 ;src/Renderer.c:992: for(j=0;j<MINIMAP_HEIGHT;++j){
   2A8E 16 00         [ 7] 2681 	ld	d,#0x00
                           2682 ;src/Renderer.c:993: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   2A90                    2683 00141$:
   2A90 7B            [ 4] 2684 	ld	a,e
   2A91 07            [ 4] 2685 	rlca
   2A92 E6 01         [ 7] 2686 	and	a,#0x01
   2A94 DD 77 F8      [19] 2687 	ld	-8 (ix),a
   2A97 7B            [ 4] 2688 	ld	a,e
   2A98 EE 80         [ 7] 2689 	xor	a, #0x80
   2A9A D6 A0         [ 7] 2690 	sub	a, #0xA0
   2A9C 3E 00         [ 7] 2691 	ld	a,#0x00
   2A9E 17            [ 4] 2692 	rla
   2A9F DD 77 FF      [19] 2693 	ld	-1 (ix),a
   2AA2 DD 36 F6 00   [19] 2694 	ld	-10 (ix),#0x00
   2AA6                    2695 00125$:
                           2696 ;src/Renderer.c:994: x=(player_position.x-MINIMAP_WIDTH_HALF);
   2AA6 3A 75 18      [13] 2697 	ld	a, (#_player_position + 0)
   2AA9 C6 F8         [ 7] 2698 	add	a,#0xF8
   2AAB DD 77 F7      [19] 2699 	ld	-9 (ix),a
                           2700 ;src/Renderer.c:995: for(i=0;i<MINIMAP_WIDTH;++i){
   2AAE DD 36 F5 00   [19] 2701 	ld	-11 (ix),#0x00
   2AB2                    2702 00123$:
                           2703 ;src/Renderer.c:998: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   2AB2 FD 21 10 00   [14] 2704 	ld	iy,#0x0010
   2AB6 FD 09         [15] 2705 	add	iy, bc
                           2706 ;src/Renderer.c:996: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
   2AB8 DD CB F7 7E   [20] 2707 	bit	7, -9 (ix)
   2ABC 20 15         [12] 2708 	jr	NZ,00114$
   2ABE DD 7E F7      [19] 2709 	ld	a,-9 (ix)
   2AC1 EE 80         [ 7] 2710 	xor	a, #0x80
   2AC3 D6 A0         [ 7] 2711 	sub	a, #0xA0
   2AC5 30 0C         [12] 2712 	jr	NC,00114$
   2AC7 DD 7E F8      [19] 2713 	ld	a,-8 (ix)
   2ACA B7            [ 4] 2714 	or	a, a
   2ACB 20 06         [12] 2715 	jr	NZ,00114$
   2ACD DD CB FF 46   [20] 2716 	bit	0,-1 (ix)
   2AD1 20 0D         [12] 2717 	jr	NZ,00115$
   2AD3                    2718 00114$:
                           2719 ;src/Renderer.c:997: *ptr=g_colors[MINIMAP_WALL_COLOR];
   2AD3 3A B0 1A      [13] 2720 	ld	a, (#(_g_colors + 0x0001) + 0)
   2AD6 02            [ 7] 2721 	ld	(bc),a
                           2722 ;src/Renderer.c:998: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   2AD7 3A B0 1A      [13] 2723 	ld	a, (#(_g_colors + 0x0001) + 0)
   2ADA FD 77 00      [19] 2724 	ld	0 (iy), a
   2ADD C3 9A 2B      [10] 2725 	jp	00116$
   2AE0                    2726 00115$:
                           2727 ;src/Renderer.c:1000: else if((x==player_position.x)&&(y==player_position.y)){
   2AE0 DD 7E F7      [19] 2728 	ld	a,-9 (ix)
   2AE3 DD 77 FD      [19] 2729 	ld	-3 (ix),a
   2AE6 DD 7E F7      [19] 2730 	ld	a,-9 (ix)
   2AE9 17            [ 4] 2731 	rla
   2AEA 9F            [ 4] 2732 	sbc	a, a
   2AEB DD 77 FE      [19] 2733 	ld	-2 (ix),a
   2AEE 3A 75 18      [13] 2734 	ld	a, (#_player_position + 0)
   2AF1 DD 77 F9      [19] 2735 	ld	-7 (ix),a
   2AF4 DD 36 FA 00   [19] 2736 	ld	-6 (ix),#0x00
   2AF8 DD 73 FB      [19] 2737 	ld	-5 (ix),e
   2AFB 7B            [ 4] 2738 	ld	a,e
   2AFC 17            [ 4] 2739 	rla
   2AFD 9F            [ 4] 2740 	sbc	a, a
   2AFE DD 77 FC      [19] 2741 	ld	-4 (ix),a
   2B01 DD 7E FD      [19] 2742 	ld	a,-3 (ix)
   2B04 DD 96 F9      [19] 2743 	sub	a, -7 (ix)
   2B07 20 2E         [12] 2744 	jr	NZ,00111$
   2B09 DD 7E FE      [19] 2745 	ld	a,-2 (ix)
   2B0C DD 96 FA      [19] 2746 	sub	a, -6 (ix)
   2B0F 20 26         [12] 2747 	jr	NZ,00111$
   2B11 3A 76 18      [13] 2748 	ld	a, (#(_player_position + 0x0001) + 0)
   2B14 DD 77 F9      [19] 2749 	ld	-7 (ix),a
   2B17 DD 36 FA 00   [19] 2750 	ld	-6 (ix),#0x00
   2B1B DD 7E FB      [19] 2751 	ld	a,-5 (ix)
   2B1E DD 96 F9      [19] 2752 	sub	a, -7 (ix)
   2B21 20 14         [12] 2753 	jr	NZ,00111$
   2B23 DD 7E FC      [19] 2754 	ld	a,-4 (ix)
   2B26 DD 96 FA      [19] 2755 	sub	a, -6 (ix)
   2B29 20 0C         [12] 2756 	jr	NZ,00111$
                           2757 ;src/Renderer.c:1001: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
   2B2B 3A B3 1A      [13] 2758 	ld	a, (#(_g_colors + 0x0004) + 0)
   2B2E 02            [ 7] 2759 	ld	(bc),a
                           2760 ;src/Renderer.c:1002: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
   2B2F 3A B3 1A      [13] 2761 	ld	a, (#(_g_colors + 0x0004) + 0)
   2B32 FD 77 00      [19] 2762 	ld	0 (iy), a
   2B35 18 63         [12] 2763 	jr	00116$
   2B37                    2764 00111$:
                           2765 ;src/Renderer.c:1005: val = (*(u8*)(MAP_MEM+x+y*MAP_WIDTH));
   2B37 DD 7E FD      [19] 2766 	ld	a, -3 (ix)
   2B3A DD 66 FE      [19] 2767 	ld	h, -2 (ix)
   2B3D C6 D0         [ 7] 2768 	add	a, #0xD0
   2B3F DD 77 F9      [19] 2769 	ld	-7 (ix),a
   2B42 7C            [ 4] 2770 	ld	a,h
   2B43 CE 88         [ 7] 2771 	adc	a, #0x88
   2B45 DD 77 FA      [19] 2772 	ld	-6 (ix),a
   2B48 DD 6E FB      [19] 2773 	ld	l,-5 (ix)
   2B4B DD 66 FC      [19] 2774 	ld	h,-4 (ix)
   2B4E 29            [11] 2775 	add	hl, hl
   2B4F 29            [11] 2776 	add	hl, hl
   2B50 29            [11] 2777 	add	hl, hl
   2B51 29            [11] 2778 	add	hl, hl
   2B52 29            [11] 2779 	add	hl, hl
   2B53 DD 7E F9      [19] 2780 	ld	a,-7 (ix)
   2B56 85            [ 4] 2781 	add	a, l
   2B57 6F            [ 4] 2782 	ld	l,a
   2B58 DD 7E FA      [19] 2783 	ld	a,-6 (ix)
   2B5B 8C            [ 4] 2784 	adc	a, h
   2B5C 67            [ 4] 2785 	ld	h,a
   2B5D 6E            [ 7] 2786 	ld	l,(hl)
                           2787 ;src/Renderer.c:1007: if(val==CELLTYPE_DOOR){
   2B5E 7D            [ 4] 2788 	ld	a,l
   2B5F D6 80         [ 7] 2789 	sub	a, #0x80
   2B61 20 0C         [12] 2790 	jr	NZ,00108$
                           2791 ;src/Renderer.c:1008: *ptr=g_colors[MINIMAP_EXIT_COLOR];
   2B63 3A B4 1A      [13] 2792 	ld	a, (#(_g_colors + 0x0005) + 0)
   2B66 02            [ 7] 2793 	ld	(bc),a
                           2794 ;src/Renderer.c:1009: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
   2B67 3A B4 1A      [13] 2795 	ld	a, (#(_g_colors + 0x0005) + 0)
   2B6A FD 77 00      [19] 2796 	ld	0 (iy), a
   2B6D 18 2B         [12] 2797 	jr	00116$
   2B6F                    2798 00108$:
                           2799 ;src/Renderer.c:1011: else if(val&CELL_WALL_MASK){
   2B6F CB 7D         [ 8] 2800 	bit	7, l
   2B71 28 0C         [12] 2801 	jr	Z,00105$
                           2802 ;src/Renderer.c:1012: *ptr=g_colors[MINIMAP_WALL_COLOR];
   2B73 3A B0 1A      [13] 2803 	ld	a, (#(_g_colors + 0x0001) + 0)
   2B76 02            [ 7] 2804 	ld	(bc),a
                           2805 ;src/Renderer.c:1013: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   2B77 3A B0 1A      [13] 2806 	ld	a, (#(_g_colors + 0x0001) + 0)
   2B7A FD 77 00      [19] 2807 	ld	0 (iy), a
   2B7D 18 1B         [12] 2808 	jr	00116$
   2B7F                    2809 00105$:
                           2810 ;src/Renderer.c:1015: else if(val&CELL_ENEMY_MASK){
   2B7F 7D            [ 4] 2811 	ld	a,l
   2B80 E6 0F         [ 7] 2812 	and	a, #0x0F
   2B82 28 0C         [12] 2813 	jr	Z,00102$
                           2814 ;src/Renderer.c:1016: *ptr=g_colors[MINIMAP_ENEMY_COLOR];
   2B84 3A B5 1A      [13] 2815 	ld	a, (#(_g_colors + 0x0006) + 0)
   2B87 02            [ 7] 2816 	ld	(bc),a
                           2817 ;src/Renderer.c:1017: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_ENEMY_COLOR];
   2B88 3A B5 1A      [13] 2818 	ld	a, (#(_g_colors + 0x0006) + 0)
   2B8B FD 77 00      [19] 2819 	ld	0 (iy), a
   2B8E 18 0A         [12] 2820 	jr	00116$
   2B90                    2821 00102$:
                           2822 ;src/Renderer.c:1024: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
   2B90 3A B2 1A      [13] 2823 	ld	a, (#(_g_colors + 0x0003) + 0)
   2B93 02            [ 7] 2824 	ld	(bc),a
                           2825 ;src/Renderer.c:1025: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
   2B94 3A B2 1A      [13] 2826 	ld	a, (#(_g_colors + 0x0003) + 0)
   2B97 FD 77 00      [19] 2827 	ld	0 (iy), a
   2B9A                    2828 00116$:
                           2829 ;src/Renderer.c:1028: ++x;
   2B9A DD 34 F7      [23] 2830 	inc	-9 (ix)
                           2831 ;src/Renderer.c:1029: ++ptr;
   2B9D 03            [ 6] 2832 	inc	bc
                           2833 ;src/Renderer.c:995: for(i=0;i<MINIMAP_WIDTH;++i){
   2B9E DD 34 F5      [23] 2834 	inc	-11 (ix)
   2BA1 DD 7E F5      [19] 2835 	ld	a,-11 (ix)
   2BA4 D6 10         [ 7] 2836 	sub	a, #0x10
   2BA6 DA B2 2A      [10] 2837 	jp	C,00123$
                           2838 ;src/Renderer.c:993: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   2BA9 DD 34 F6      [23] 2839 	inc	-10 (ix)
   2BAC DD 7E F6      [19] 2840 	ld	a,-10 (ix)
   2BAF D6 04         [ 7] 2841 	sub	a, #0x04
   2BB1 DA A6 2A      [10] 2842 	jp	C,00125$
                           2843 ;src/Renderer.c:1032: ++y;
   2BB4 1C            [ 4] 2844 	inc	e
                           2845 ;src/Renderer.c:992: for(j=0;j<MINIMAP_HEIGHT;++j){
   2BB5 14            [ 4] 2846 	inc	d
   2BB6 7A            [ 4] 2847 	ld	a,d
   2BB7 D6 10         [ 7] 2848 	sub	a, #0x10
   2BB9 DA 90 2A      [10] 2849 	jp	C,00141$
   2BBC DD F9         [10] 2850 	ld	sp, ix
   2BBE DD E1         [14] 2851 	pop	ix
   2BC0 C9            [10] 2852 	ret
                           2853 	.area _CODE
                           2854 	.area _INITIALIZER
                           2855 	.area _CABS (ABS)
