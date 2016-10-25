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
   18A5                      61 _calculate_cells_in_view::
   18A5 DD E5         [15]   62 	push	ix
   18A7 DD 21 00 00   [14]   63 	ld	ix,#0
   18AB DD 39         [15]   64 	add	ix,sp
   18AD 21 F2 FF      [10]   65 	ld	hl,#-14
   18B0 39            [11]   66 	add	hl,sp
   18B1 F9            [ 6]   67 	ld	sp,hl
                             68 ;src/Renderer.c:53: u8 offset=0, n=0, j, i;
   18B2 DD 36 FA 00   [19]   69 	ld	-6 (ix),#0x00
   18B6 DD 36 F9 00   [19]   70 	ld	-7 (ix),#0x00
                             71 ;src/Renderer.c:56: if(player_direction.y!=0){
   18BA 21 2F 18      [10]   72 	ld	hl, #_player_direction + 1
   18BD 7E            [ 7]   73 	ld	a,(hl)
   18BE DD 77 FD      [19]   74 	ld	-3 (ix), a
   18C1 B7            [ 4]   75 	or	a, a
   18C2 28 32         [12]   76 	jr	Z,00102$
                             77 ;src/Renderer.c:57: vert=1;
   18C4 DD 36 F2 01   [19]   78 	ld	-14 (ix),#0x01
                             79 ;src/Renderer.c:58: dy=player_direction.y;
   18C8 DD 4E FD      [19]   80 	ld	c,-3 (ix)
   18CB DD 71 F4      [19]   81 	ld	-12 (ix),c
                             82 ;src/Renderer.c:59: dx=-player_direction.y;
   18CE AF            [ 4]   83 	xor	a, a
   18CF DD 96 FD      [19]   84 	sub	a, -3 (ix)
   18D2 DD 77 F5      [19]   85 	ld	-11 (ix), a
                             86 ;src/Renderer.c:61: x0 = player_position.x-(17*dx);
   18D5 21 2C 18      [10]   87 	ld	hl,#_player_position+0
   18D8 4E            [ 7]   88 	ld	c,(hl)
   18D9 DD 6E F5      [19]   89 	ld	l,-11 (ix)
   18DC 5D            [ 4]   90 	ld	e,l
   18DD 29            [11]   91 	add	hl, hl
   18DE 29            [11]   92 	add	hl, hl
   18DF 29            [11]   93 	add	hl, hl
   18E0 29            [11]   94 	add	hl, hl
   18E1 19            [11]   95 	add	hl, de
   18E2 79            [ 4]   96 	ld	a,c
   18E3 95            [ 4]   97 	sub	a, l
   18E4 DD 77 F6      [19]   98 	ld	-10 (ix),a
                             99 ;src/Renderer.c:62: y0 = player_position.y+(6*dy);
   18E7 21 2D 18      [10]  100 	ld	hl,#_player_position+1
   18EA 4E            [ 7]  101 	ld	c,(hl)
   18EB DD 6E F4      [19]  102 	ld	l,-12 (ix)
   18EE 5D            [ 4]  103 	ld	e,l
   18EF 29            [11]  104 	add	hl, hl
   18F0 19            [11]  105 	add	hl, de
   18F1 29            [11]  106 	add	hl, hl
   18F2 09            [11]  107 	add	hl, bc
   18F3 4D            [ 4]  108 	ld	c,l
   18F4 18 35         [12]  109 	jr	00103$
   18F6                     110 00102$:
                            111 ;src/Renderer.c:65: vert=0;
   18F6 DD 36 F2 00   [19]  112 	ld	-14 (ix),#0x00
                            113 ;src/Renderer.c:66: dy=player_direction.x;
   18FA 21 2E 18      [10]  114 	ld	hl, #_player_direction + 0
   18FD 7E            [ 7]  115 	ld	a,(hl)
   18FE DD 77 FD      [19]  116 	ld	-3 (ix), a
   1901 DD 77 F4      [19]  117 	ld	-12 (ix),a
                            118 ;src/Renderer.c:67: dx=player_direction.x;
   1904 DD 7E FD      [19]  119 	ld	a,-3 (ix)
   1907 DD 77 F5      [19]  120 	ld	-11 (ix),a
                            121 ;src/Renderer.c:69: y0 = player_position.y-(17*dy);
   190A 21 2D 18      [10]  122 	ld	hl, #_player_position + 1
   190D 4E            [ 7]  123 	ld	c,(hl)
   190E DD 6E F4      [19]  124 	ld	l,-12 (ix)
   1911 5D            [ 4]  125 	ld	e,l
   1912 29            [11]  126 	add	hl, hl
   1913 29            [11]  127 	add	hl, hl
   1914 29            [11]  128 	add	hl, hl
   1915 29            [11]  129 	add	hl, hl
   1916 19            [11]  130 	add	hl, de
   1917 79            [ 4]  131 	ld	a,c
   1918 95            [ 4]  132 	sub	a, l
   1919 4F            [ 4]  133 	ld	c,a
                            134 ;src/Renderer.c:70: x0 = player_position.x+(6*dx);
   191A 21 2C 18      [10]  135 	ld	hl, #_player_position + 0
   191D 46            [ 7]  136 	ld	b,(hl)
   191E DD 7E FD      [19]  137 	ld	a,-3 (ix)
   1921 5F            [ 4]  138 	ld	e,a
   1922 87            [ 4]  139 	add	a, a
   1923 83            [ 4]  140 	add	a, e
   1924 87            [ 4]  141 	add	a, a
   1925 5F            [ 4]  142 	ld	e,a
   1926 68            [ 4]  143 	ld	l,b
   1927 19            [11]  144 	add	hl, de
   1928 DD 75 F6      [19]  145 	ld	-10 (ix),l
   192B                     146 00103$:
                            147 ;src/Renderer.c:74: x=x0;
   192B DD 5E F6      [19]  148 	ld	e,-10 (ix)
                            149 ;src/Renderer.c:75: y=y0;
   192E DD 71 F3      [19]  150 	ld	-13 (ix),c
                            151 ;src/Renderer.c:77: for(j=0;j<6;++j){
   1931 DD 7E F5      [19]  152 	ld	a,-11 (ix)
   1934 07            [ 4]  153 	rlca
   1935 E6 01         [ 7]  154 	and	a,#0x01
   1937 DD 77 FD      [19]  155 	ld	-3 (ix),a
   193A DD 7E F4      [19]  156 	ld	a,-12 (ix)
   193D 07            [ 4]  157 	rlca
   193E E6 01         [ 7]  158 	and	a,#0x01
   1940 DD 77 FF      [19]  159 	ld	-1 (ix),a
   1943 DD 36 F8 00   [19]  160 	ld	-8 (ix),#0x00
                            161 ;src/Renderer.c:79: for(i=offset;i<35-offset;++i){
   1947                     162 00138$:
   1947 DD 7E F9      [19]  163 	ld	a,-7 (ix)
   194A DD 77 FE      [19]  164 	ld	-2 (ix),a
   194D DD 7E FA      [19]  165 	ld	a,-6 (ix)
   1950 DD 77 F7      [19]  166 	ld	-9 (ix),a
   1953                     167 00125$:
   1953 DD 6E FA      [19]  168 	ld	l,-6 (ix)
   1956 26 00         [ 7]  169 	ld	h,#0x00
   1958 3E 23         [ 7]  170 	ld	a,#0x23
   195A 95            [ 4]  171 	sub	a, l
   195B 6F            [ 4]  172 	ld	l,a
   195C 3E 00         [ 7]  173 	ld	a,#0x00
   195E 9C            [ 4]  174 	sbc	a, h
   195F 67            [ 4]  175 	ld	h,a
   1960 DD 7E F7      [19]  176 	ld	a, -9 (ix)
   1963 16 00         [ 7]  177 	ld	d, #0x00
   1965 95            [ 4]  178 	sub	a, l
   1966 7A            [ 4]  179 	ld	a,d
   1967 9C            [ 4]  180 	sbc	a, h
   1968 E2 6D 19      [10]  181 	jp	PO, 00181$
   196B EE 80         [ 7]  182 	xor	a, #0x80
   196D                     183 00181$:
   196D F2 EC 19      [10]  184 	jp	P,00143$
                            185 ;src/Renderer.c:82: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   1970 2A 78 1A      [16]  186 	ld	hl,(_cells_in_view_array)
   1973 7D            [ 4]  187 	ld	a,l
   1974 DD 86 FE      [19]  188 	add	a, -2 (ix)
   1977 DD 77 FB      [19]  189 	ld	-5 (ix),a
   197A 7C            [ 4]  190 	ld	a,h
   197B CE 00         [ 7]  191 	adc	a, #0x00
   197D DD 77 FC      [19]  192 	ld	-4 (ix),a
                            193 ;src/Renderer.c:81: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
   1980 CB 7B         [ 8]  194 	bit	7, e
   1982 20 41         [12]  195 	jr	NZ,00105$
   1984 7B            [ 4]  196 	ld	a,e
   1985 EE 80         [ 7]  197 	xor	a, #0x80
   1987 D6 A0         [ 7]  198 	sub	a, #0xA0
   1989 30 3A         [12]  199 	jr	NC,00105$
   198B DD CB F3 7E   [20]  200 	bit	7, -13 (ix)
   198F 20 34         [12]  201 	jr	NZ,00105$
   1991 DD 7E F3      [19]  202 	ld	a,-13 (ix)
   1994 EE 80         [ 7]  203 	xor	a, #0x80
   1996 D6 A0         [ 7]  204 	sub	a, #0xA0
   1998 30 2B         [12]  205 	jr	NC,00105$
                            206 ;src/Renderer.c:82: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   199A 7B            [ 4]  207 	ld	a,e
   199B 6F            [ 4]  208 	ld	l,a
   199C 17            [ 4]  209 	rla
   199D 9F            [ 4]  210 	sbc	a, a
   199E 67            [ 4]  211 	ld	h,a
   199F 7D            [ 4]  212 	ld	a,l
   19A0 C6 D0         [ 7]  213 	add	a, #0xD0
   19A2 47            [ 4]  214 	ld	b,a
   19A3 7C            [ 4]  215 	ld	a,h
   19A4 CE 88         [ 7]  216 	adc	a, #0x88
   19A6 57            [ 4]  217 	ld	d,a
   19A7 DD 6E F3      [19]  218 	ld	l,-13 (ix)
   19AA DD 7E F3      [19]  219 	ld	a,-13 (ix)
   19AD 17            [ 4]  220 	rla
   19AE 9F            [ 4]  221 	sbc	a, a
   19AF 67            [ 4]  222 	ld	h,a
   19B0 29            [11]  223 	add	hl, hl
   19B1 29            [11]  224 	add	hl, hl
   19B2 29            [11]  225 	add	hl, hl
   19B3 29            [11]  226 	add	hl, hl
   19B4 29            [11]  227 	add	hl, hl
   19B5 7D            [ 4]  228 	ld	a,l
   19B6 80            [ 4]  229 	add	a, b
   19B7 6F            [ 4]  230 	ld	l,a
   19B8 7C            [ 4]  231 	ld	a,h
   19B9 8A            [ 4]  232 	adc	a, d
   19BA 67            [ 4]  233 	ld	h,a
   19BB 46            [ 7]  234 	ld	b,(hl)
   19BC DD 6E FB      [19]  235 	ld	l,-5 (ix)
   19BF DD 66 FC      [19]  236 	ld	h,-4 (ix)
   19C2 70            [ 7]  237 	ld	(hl),b
   19C3 18 08         [12]  238 	jr	00106$
   19C5                     239 00105$:
                            240 ;src/Renderer.c:85: cells_in_view_array[n]=CELLTYPE_WALL1;
   19C5 DD 6E FB      [19]  241 	ld	l,-5 (ix)
   19C8 DD 66 FC      [19]  242 	ld	h,-4 (ix)
   19CB 36 81         [10]  243 	ld	(hl),#0x81
   19CD                     244 00106$:
                            245 ;src/Renderer.c:89: if(vert){
   19CD DD 7E F2      [19]  246 	ld	a,-14 (ix)
   19D0 B7            [ 4]  247 	or	a, a
   19D1 28 07         [12]  248 	jr	Z,00111$
                            249 ;src/Renderer.c:90: x+=dx;
   19D3 7B            [ 4]  250 	ld	a,e
   19D4 DD 86 F5      [19]  251 	add	a, -11 (ix)
   19D7 5F            [ 4]  252 	ld	e,a
   19D8 18 09         [12]  253 	jr	00112$
   19DA                     254 00111$:
                            255 ;src/Renderer.c:93: y+=dy;
   19DA DD 7E F3      [19]  256 	ld	a,-13 (ix)
   19DD DD 86 F4      [19]  257 	add	a, -12 (ix)
   19E0 DD 77 F3      [19]  258 	ld	-13 (ix),a
   19E3                     259 00112$:
                            260 ;src/Renderer.c:95: ++n;
   19E3 DD 34 FE      [23]  261 	inc	-2 (ix)
                            262 ;src/Renderer.c:79: for(i=offset;i<35-offset;++i){
   19E6 DD 34 F7      [23]  263 	inc	-9 (ix)
   19E9 C3 53 19      [10]  264 	jp	00125$
   19EC                     265 00143$:
   19EC DD 7E FE      [19]  266 	ld	a,-2 (ix)
   19EF DD 77 F9      [19]  267 	ld	-7 (ix),a
                            268 ;src/Renderer.c:97: offset=offsets_cells_in_view[j];
   19F2 3E 7A         [ 7]  269 	ld	a,#<(_offsets_cells_in_view)
   19F4 DD 86 F8      [19]  270 	add	a, -8 (ix)
   19F7 6F            [ 4]  271 	ld	l,a
   19F8 3E 1A         [ 7]  272 	ld	a,#>(_offsets_cells_in_view)
   19FA CE 00         [ 7]  273 	adc	a, #0x00
   19FC 67            [ 4]  274 	ld	h,a
   19FD 7E            [ 7]  275 	ld	a,(hl)
                            276 ;src/Renderer.c:101: if(dx<0) x=x0-offset;
   19FE DD 77 FA      [19]  277 	ld	-6 (ix), a
   1A01 DD 77 FB      [19]  278 	ld	-5 (ix),a
                            279 ;src/Renderer.c:99: if(vert){
   1A04 DD 7E F2      [19]  280 	ld	a,-14 (ix)
   1A07 B7            [ 4]  281 	or	a, a
   1A08 28 21         [12]  282 	jr	Z,00121$
                            283 ;src/Renderer.c:100: y-=dy;
   1A0A DD 7E F3      [19]  284 	ld	a,-13 (ix)
   1A0D DD 96 F4      [19]  285 	sub	a, -12 (ix)
   1A10 DD 77 F3      [19]  286 	ld	-13 (ix),a
                            287 ;src/Renderer.c:101: if(dx<0) x=x0-offset;
   1A13 DD 7E FD      [19]  288 	ld	a,-3 (ix)
   1A16 B7            [ 4]  289 	or	a, a
   1A17 28 09         [12]  290 	jr	Z,00115$
   1A19 DD 7E F6      [19]  291 	ld	a,-10 (ix)
   1A1C DD 96 FB      [19]  292 	sub	a, -5 (ix)
   1A1F 5F            [ 4]  293 	ld	e,a
   1A20 18 24         [12]  294 	jr	00128$
   1A22                     295 00115$:
                            296 ;src/Renderer.c:102: else x=x0+offset;
   1A22 DD 7E F6      [19]  297 	ld	a,-10 (ix)
   1A25 DD 86 FB      [19]  298 	add	a, -5 (ix)
   1A28 5F            [ 4]  299 	ld	e,a
   1A29 18 1B         [12]  300 	jr	00128$
   1A2B                     301 00121$:
                            302 ;src/Renderer.c:106: x-=dx;
   1A2B 7B            [ 4]  303 	ld	a,e
   1A2C DD 96 F5      [19]  304 	sub	a, -11 (ix)
   1A2F 5F            [ 4]  305 	ld	e,a
                            306 ;src/Renderer.c:107: if(dy<0) y=y0-offset;
   1A30 DD 7E FF      [19]  307 	ld	a,-1 (ix)
   1A33 B7            [ 4]  308 	or	a, a
   1A34 28 09         [12]  309 	jr	Z,00118$
   1A36 79            [ 4]  310 	ld	a,c
   1A37 DD 96 FB      [19]  311 	sub	a, -5 (ix)
   1A3A DD 77 F3      [19]  312 	ld	-13 (ix),a
   1A3D 18 07         [12]  313 	jr	00128$
   1A3F                     314 00118$:
                            315 ;src/Renderer.c:108: else y=y0+offset;
   1A3F 79            [ 4]  316 	ld	a,c
   1A40 DD 86 FB      [19]  317 	add	a, -5 (ix)
   1A43 DD 77 F3      [19]  318 	ld	-13 (ix),a
   1A46                     319 00128$:
                            320 ;src/Renderer.c:77: for(j=0;j<6;++j){
   1A46 DD 34 F8      [23]  321 	inc	-8 (ix)
   1A49 DD 7E F8      [19]  322 	ld	a,-8 (ix)
   1A4C D6 06         [ 7]  323 	sub	a, #0x06
   1A4E DA 47 19      [10]  324 	jp	C,00138$
   1A51 DD F9         [10]  325 	ld	sp, ix
   1A53 DD E1         [14]  326 	pop	ix
   1A55 C9            [10]  327 	ret
   1A56                     328 _g_palette:
   1A56 08                  329 	.db #0x08	; 8
   1A57 00                  330 	.db #0x00	; 0
   1A58 0D                  331 	.db #0x0D	; 13
   1A59 1A                  332 	.db #0x1A	; 26
   1A5A 06                  333 	.db #0x06	; 6
   1A5B 09                  334 	.db #0x09	; 9
   1A5C 0F                  335 	.db #0x0F	; 15
   1A5D 00                  336 	.db #0x00	; 0
   1A5E 00                  337 	.db #0x00	; 0
   1A5F 00                  338 	.db #0x00	; 0
   1A60 00                  339 	.db #0x00	; 0
   1A61 00                  340 	.db #0x00	; 0
   1A62 00                  341 	.db #0x00	; 0
   1A63 00                  342 	.db #0x00	; 0
   1A64 00                  343 	.db #0x00	; 0
   1A65 00                  344 	.db #0x00	; 0
   1A66                     345 _g_colors:
   1A66 00                  346 	.db #0x00	; 0
   1A67 C0                  347 	.db #0xC0	; 192
   1A68 0C                  348 	.db #0x0C	; 12
   1A69 CC                  349 	.db #0xCC	; 204
   1A6A 30                  350 	.db #0x30	; 48	'0'
   1A6B F0                  351 	.db #0xF0	; 240
   1A6C 3C                  352 	.db #0x3C	; 60
   1A6D FC                  353 	.db #0xFC	; 252
   1A6E 03                  354 	.db #0x03	; 3
   1A6F C3                  355 	.db #0xC3	; 195
   1A70 0F                  356 	.db #0x0F	; 15
   1A71 CF                  357 	.db #0xCF	; 207
   1A72 33                  358 	.db #0x33	; 51	'3'
   1A73 F3                  359 	.db #0xF3	; 243
   1A74 3F                  360 	.db #0x3F	; 63
   1A75 FF                  361 	.db #0xFF	; 255
   1A76                     362 _g_pixelMask:
   1A76 AA                  363 	.db #0xAA	; 170
   1A77 55                  364 	.db #0x55	; 85	'U'
   1A78                     365 _cells_in_view_array:
   1A78 F0 BD               366 	.dw #0xBDF0
   1A7A                     367 _offsets_cells_in_view:
   1A7A 08                  368 	.db #0x08	; 8
   1A7B 0C                  369 	.db #0x0C	; 12
   1A7C 0E                  370 	.db #0x0E	; 14
   1A7D 0F                  371 	.db #0x0F	; 15
   1A7E 10                  372 	.db #0x10	; 16
                            373 ;src/Renderer.c:116: void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
                            374 ;	---------------------------------
                            375 ; Function draw_column_to_buffer_untextured
                            376 ; ---------------------------------
   1A7F                     377 _draw_column_to_buffer_untextured::
   1A7F DD E5         [15]  378 	push	ix
   1A81 DD 21 00 00   [14]  379 	ld	ix,#0
   1A85 DD 39         [15]  380 	add	ix,sp
   1A87 F5            [11]  381 	push	af
                            382 ;src/Renderer.c:117: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1A88 DD 7E 04      [19]  383 	ld	a, 4 (ix)
   1A8B CB 3F         [ 8]  384 	srl	a
   1A8D C6 50         [ 7]  385 	add	a, #0x50
   1A8F 4F            [ 4]  386 	ld	c,a
   1A90 3E 00         [ 7]  387 	ld	a,#0x00
   1A92 CE AA         [ 7]  388 	adc	a, #0xAA
   1A94 47            [ 4]  389 	ld	b,a
                            390 ;src/Renderer.c:119: u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
   1A95 11 66 1A      [10]  391 	ld	de,#_g_colors+0
   1A98 DD 6E 06      [19]  392 	ld	l,6 (ix)
   1A9B 26 00         [ 7]  393 	ld	h,#0x00
   1A9D 19            [11]  394 	add	hl,de
   1A9E 7E            [ 7]  395 	ld	a,(hl)
   1A9F DD 77 FE      [19]  396 	ld	-2 (ix),a
                            397 ;src/Renderer.c:120: u8 pixMask = g_pixelMask[column&1];
   1AA2 11 76 1A      [10]  398 	ld	de,#_g_pixelMask+0
   1AA5 DD 7E 04      [19]  399 	ld	a,4 (ix)
   1AA8 E6 01         [ 7]  400 	and	a, #0x01
   1AAA 6F            [ 4]  401 	ld	l,a
   1AAB 26 00         [ 7]  402 	ld	h,#0x00
   1AAD 19            [11]  403 	add	hl,de
   1AAE 5E            [ 7]  404 	ld	e,(hl)
                            405 ;src/Renderer.c:129: if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
   1AAF 3E 64         [ 7]  406 	ld	a,#0x64
   1AB1 DD 96 05      [19]  407 	sub	a, 5 (ix)
   1AB4 30 04         [12]  408 	jr	NC,00102$
   1AB6 DD 36 05 64   [19]  409 	ld	5 (ix),#0x64
   1ABA                     410 00102$:
                            411 ;src/Renderer.c:131: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   1ABA DD 6E 05      [19]  412 	ld	l,5 (ix)
   1ABD CB 3D         [ 8]  413 	srl	l
   1ABF 3E 32         [ 7]  414 	ld	a,#0x32
   1AC1 95            [ 4]  415 	sub	a, l
                            416 ;src/Renderer.c:134: pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
   1AC2 D5            [11]  417 	push	de
   1AC3 5F            [ 4]  418 	ld	e,a
   1AC4 16 00         [ 7]  419 	ld	d,#0x00
   1AC6 6B            [ 4]  420 	ld	l, e
   1AC7 62            [ 4]  421 	ld	h, d
   1AC8 29            [11]  422 	add	hl, hl
   1AC9 29            [11]  423 	add	hl, hl
   1ACA 19            [11]  424 	add	hl, de
   1ACB 29            [11]  425 	add	hl, hl
   1ACC 29            [11]  426 	add	hl, hl
   1ACD 29            [11]  427 	add	hl, hl
   1ACE D1            [10]  428 	pop	de
   1ACF 09            [11]  429 	add	hl,bc
   1AD0 4D            [ 4]  430 	ld	c,l
   1AD1 44            [ 4]  431 	ld	b,h
                            432 ;src/Renderer.c:136: j=lineHeight;
   1AD2 DD 56 05      [19]  433 	ld	d,5 (ix)
                            434 ;src/Renderer.c:138: for(j;j;--j){
   1AD5 7B            [ 4]  435 	ld	a,e
   1AD6 2F            [ 4]  436 	cpl
   1AD7 DD 77 FF      [19]  437 	ld	-1 (ix),a
   1ADA 7B            [ 4]  438 	ld	a,e
   1ADB DD A6 FE      [19]  439 	and	a, -2 (ix)
   1ADE 5F            [ 4]  440 	ld	e,a
   1ADF                     441 00105$:
   1ADF 7A            [ 4]  442 	ld	a,d
   1AE0 B7            [ 4]  443 	or	a, a
   1AE1 28 0F         [12]  444 	jr	Z,00107$
                            445 ;src/Renderer.c:139: val =  ((*pvmem)&(~pixMask));
   1AE3 0A            [ 7]  446 	ld	a,(bc)
   1AE4 DD A6 FF      [19]  447 	and	a, -1 (ix)
                            448 ;src/Renderer.c:141: *pvmem = val|(w_color&pixMask);
   1AE7 B3            [ 4]  449 	or	a, e
   1AE8 02            [ 7]  450 	ld	(bc),a
                            451 ;src/Renderer.c:143: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   1AE9 21 28 00      [10]  452 	ld	hl,#0x0028
   1AEC 09            [11]  453 	add	hl,bc
   1AED 4D            [ 4]  454 	ld	c,l
   1AEE 44            [ 4]  455 	ld	b,h
                            456 ;src/Renderer.c:138: for(j;j;--j){
   1AEF 15            [ 4]  457 	dec	d
   1AF0 18 ED         [12]  458 	jr	00105$
   1AF2                     459 00107$:
   1AF2 DD F9         [10]  460 	ld	sp, ix
   1AF4 DD E1         [14]  461 	pop	ix
   1AF6 C9            [10]  462 	ret
                            463 ;src/Renderer.c:147: void draw_column_to_buffer_object(u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            464 ;	---------------------------------
                            465 ; Function draw_column_to_buffer_object
                            466 ; ---------------------------------
   1AF7                     467 _draw_column_to_buffer_object::
   1AF7 DD E5         [15]  468 	push	ix
   1AF9 DD 21 00 00   [14]  469 	ld	ix,#0
   1AFD DD 39         [15]  470 	add	ix,sp
   1AFF 21 F7 FF      [10]  471 	ld	hl,#-9
   1B02 39            [11]  472 	add	hl,sp
   1B03 F9            [ 6]  473 	ld	sp,hl
                            474 ;src/Renderer.c:164: u16 texture_line=0;
   1B04 21 00 00      [10]  475 	ld	hl,#0x0000
   1B07 E3            [19]  476 	ex	(sp), hl
                            477 ;src/Renderer.c:167: if(texture_column>=8 && texture_column<24){
   1B08 DD 7E 07      [19]  478 	ld	a,7 (ix)
   1B0B D6 08         [ 7]  479 	sub	a, #0x08
   1B0D DA ED 1B      [10]  480 	jp	C,00110$
   1B10 DD 7E 07      [19]  481 	ld	a,7 (ix)
   1B13 D6 18         [ 7]  482 	sub	a, #0x18
   1B15 D2 ED 1B      [10]  483 	jp	NC,00110$
                            484 ;src/Renderer.c:169: index = index>>4;
   1B18 DD 7E 06      [19]  485 	ld	a,6 (ix)
   1B1B 07            [ 4]  486 	rlca
   1B1C 07            [ 4]  487 	rlca
   1B1D 07            [ 4]  488 	rlca
   1B1E 07            [ 4]  489 	rlca
   1B1F E6 0F         [ 7]  490 	and	a,#0x0F
                            491 ;src/Renderer.c:172: texture = (u8*)(UNCOMPRESSED_OBJECT_TEXTURES + ((ITEM_SPRITE_WIDTH*ITEM_SPRITE_HEIGHT)*(item_get_at(index-1)->type)) + ((texture_column-8)*ITEM_SPRITE_WIDTH));
   1B21 DD 77 06      [19]  492 	ld	6 (ix), a
   1B24 47            [ 4]  493 	ld	b, a
   1B25 05            [ 4]  494 	dec	b
   1B26 C5            [11]  495 	push	bc
   1B27 33            [ 6]  496 	inc	sp
   1B28 CD 00 0C      [17]  497 	call	_item_get_at
   1B2B 33            [ 6]  498 	inc	sp
   1B2C 23            [ 6]  499 	inc	hl
   1B2D 23            [ 6]  500 	inc	hl
   1B2E 23            [ 6]  501 	inc	hl
   1B2F 46            [ 7]  502 	ld	b, (hl)
   1B30 0E 00         [ 7]  503 	ld	c,#0x00
   1B32 21 50 A5      [10]  504 	ld	hl,#0xA550
   1B35 09            [11]  505 	add	hl,bc
   1B36 4D            [ 4]  506 	ld	c,l
   1B37 44            [ 4]  507 	ld	b,h
   1B38 DD 7E 07      [19]  508 	ld	a, 7 (ix)
   1B3B 16 00         [ 7]  509 	ld	d, #0x00
   1B3D C6 F8         [ 7]  510 	add	a,#0xF8
   1B3F 6F            [ 4]  511 	ld	l,a
   1B40 7A            [ 4]  512 	ld	a,d
   1B41 CE FF         [ 7]  513 	adc	a,#0xFF
   1B43 67            [ 4]  514 	ld	h,a
   1B44 29            [11]  515 	add	hl, hl
   1B45 29            [11]  516 	add	hl, hl
   1B46 29            [11]  517 	add	hl, hl
   1B47 29            [11]  518 	add	hl, hl
   1B48 09            [11]  519 	add	hl,bc
   1B49 DD 75 FB      [19]  520 	ld	-5 (ix),l
   1B4C DD 74 FC      [19]  521 	ld	-4 (ix),h
                            522 ;src/Renderer.c:174: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1B4F DD 7E 04      [19]  523 	ld	a, 4 (ix)
   1B52 CB 3F         [ 8]  524 	srl	a
   1B54 C6 50         [ 7]  525 	add	a, #0x50
   1B56 4F            [ 4]  526 	ld	c,a
   1B57 3E 00         [ 7]  527 	ld	a,#0x00
   1B59 CE AA         [ 7]  528 	adc	a, #0xAA
   1B5B 47            [ 4]  529 	ld	b,a
                            530 ;src/Renderer.c:176: pixMask = g_pixelMask[column&1];
   1B5C 11 76 1A      [10]  531 	ld	de,#_g_pixelMask+0
   1B5F DD 7E 04      [19]  532 	ld	a,4 (ix)
   1B62 E6 01         [ 7]  533 	and	a, #0x01
   1B64 6F            [ 4]  534 	ld	l,a
   1B65 26 00         [ 7]  535 	ld	h,#0x00
   1B67 19            [11]  536 	add	hl,de
   1B68 7E            [ 7]  537 	ld	a,(hl)
   1B69 DD 77 FD      [19]  538 	ld	-3 (ix),a
                            539 ;src/Renderer.c:178: lineHeight = (lineHeight)/2;
   1B6C DD CB 05 3E   [23]  540 	srl	5 (ix)
                            541 ;src/Renderer.c:179: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight/2);
   1B70 DD 7E 05      [19]  542 	ld	a,5 (ix)
   1B73 CB 3F         [ 8]  543 	srl	a
   1B75 C6 32         [ 7]  544 	add	a, #0x32
                            545 ;src/Renderer.c:180: item_top_height = ground_height - lineHeight;
   1B77 DD 96 05      [19]  546 	sub	a, 5 (ix)
   1B7A 5F            [ 4]  547 	ld	e,a
                            548 ;src/Renderer.c:182: texture_line_add = (256*ITEM_SPRITE_HEIGHT)/lineHeight;
   1B7B DD 6E 05      [19]  549 	ld	l,5 (ix)
   1B7E 26 00         [ 7]  550 	ld	h,#0x00
   1B80 C5            [11]  551 	push	bc
   1B81 D5            [11]  552 	push	de
   1B82 E5            [11]  553 	push	hl
   1B83 21 00 10      [10]  554 	ld	hl,#0x1000
   1B86 E5            [11]  555 	push	hl
   1B87 CD 29 7D      [17]  556 	call	__divsint
   1B8A F1            [10]  557 	pop	af
   1B8B F1            [10]  558 	pop	af
   1B8C D1            [10]  559 	pop	de
   1B8D C1            [10]  560 	pop	bc
   1B8E DD 75 F9      [19]  561 	ld	-7 (ix),l
   1B91 DD 74 FA      [19]  562 	ld	-6 (ix),h
                            563 ;src/Renderer.c:183: j=lineHeight;
   1B94 DD 7E 05      [19]  564 	ld	a,5 (ix)
   1B97 DD 77 FE      [19]  565 	ld	-2 (ix),a
                            566 ;src/Renderer.c:189: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * item_top_height;
   1B9A 16 00         [ 7]  567 	ld	d,#0x00
   1B9C 6B            [ 4]  568 	ld	l, e
   1B9D 62            [ 4]  569 	ld	h, d
   1B9E 29            [11]  570 	add	hl, hl
   1B9F 29            [11]  571 	add	hl, hl
   1BA0 19            [11]  572 	add	hl, de
   1BA1 29            [11]  573 	add	hl, hl
   1BA2 29            [11]  574 	add	hl, hl
   1BA3 29            [11]  575 	add	hl, hl
   1BA4 09            [11]  576 	add	hl,bc
   1BA5 4D            [ 4]  577 	ld	c,l
   1BA6 44            [ 4]  578 	ld	b,h
                            579 ;src/Renderer.c:191: for(j;j;--j){
   1BA7 DD 7E FD      [19]  580 	ld	a,-3 (ix)
   1BAA 2F            [ 4]  581 	cpl
   1BAB DD 77 FF      [19]  582 	ld	-1 (ix),a
   1BAE                     583 00108$:
   1BAE DD 7E FE      [19]  584 	ld	a,-2 (ix)
   1BB1 B7            [ 4]  585 	or	a, a
   1BB2 28 39         [12]  586 	jr	Z,00110$
                            587 ;src/Renderer.c:193: color= *(texture+(texture_line/256));
   1BB4 DD 5E F8      [19]  588 	ld	e,-8 (ix)
   1BB7 16 00         [ 7]  589 	ld	d,#0x00
   1BB9 DD 6E FB      [19]  590 	ld	l,-5 (ix)
   1BBC DD 66 FC      [19]  591 	ld	h,-4 (ix)
   1BBF 19            [11]  592 	add	hl,de
   1BC0 5E            [ 7]  593 	ld	e,(hl)
                            594 ;src/Renderer.c:195: if(color){
   1BC1 7B            [ 4]  595 	ld	a,e
   1BC2 B7            [ 4]  596 	or	a, a
   1BC3 28 0B         [12]  597 	jr	Z,00102$
                            598 ;src/Renderer.c:196: val =  ((*pvmem)&(~pixMask));
   1BC5 0A            [ 7]  599 	ld	a,(bc)
   1BC6 DD A6 FF      [19]  600 	and	a, -1 (ix)
   1BC9 6F            [ 4]  601 	ld	l,a
                            602 ;src/Renderer.c:198: color = (color&pixMask);
   1BCA 7B            [ 4]  603 	ld	a,e
   1BCB DD A6 FD      [19]  604 	and	a, -3 (ix)
                            605 ;src/Renderer.c:200: *pvmem = val|color;
   1BCE B5            [ 4]  606 	or	a, l
   1BCF 02            [ 7]  607 	ld	(bc),a
   1BD0                     608 00102$:
                            609 ;src/Renderer.c:203: texture_line += texture_line_add;
   1BD0 DD 7E F7      [19]  610 	ld	a,-9 (ix)
   1BD3 DD 86 F9      [19]  611 	add	a, -7 (ix)
   1BD6 DD 77 F7      [19]  612 	ld	-9 (ix),a
   1BD9 DD 7E F8      [19]  613 	ld	a,-8 (ix)
   1BDC DD 8E FA      [19]  614 	adc	a, -6 (ix)
   1BDF DD 77 F8      [19]  615 	ld	-8 (ix),a
                            616 ;src/Renderer.c:205: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   1BE2 21 28 00      [10]  617 	ld	hl,#0x0028
   1BE5 09            [11]  618 	add	hl,bc
   1BE6 4D            [ 4]  619 	ld	c,l
   1BE7 44            [ 4]  620 	ld	b,h
                            621 ;src/Renderer.c:191: for(j;j;--j){
   1BE8 DD 35 FE      [23]  622 	dec	-2 (ix)
   1BEB 18 C1         [12]  623 	jr	00108$
   1BED                     624 00110$:
   1BED DD F9         [10]  625 	ld	sp, ix
   1BEF DD E1         [14]  626 	pop	ix
   1BF1 C9            [10]  627 	ret
                            628 ;src/Renderer.c:212: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            629 ;	---------------------------------
                            630 ; Function draw_column_to_buffer_enemy
                            631 ; ---------------------------------
   1BF2                     632 _draw_column_to_buffer_enemy::
   1BF2 DD E5         [15]  633 	push	ix
   1BF4 DD 21 00 00   [14]  634 	ld	ix,#0
   1BF8 DD 39         [15]  635 	add	ix,sp
   1BFA 21 F2 FF      [10]  636 	ld	hl,#-14
   1BFD 39            [11]  637 	add	hl,sp
   1BFE F9            [ 6]  638 	ld	sp,hl
                            639 ;src/Renderer.c:229: u16 texture_line=0;
   1BFF DD 36 F7 00   [19]  640 	ld	-9 (ix),#0x00
   1C03 DD 36 F8 00   [19]  641 	ld	-8 (ix),#0x00
                            642 ;src/Renderer.c:231: if(texture_column>=4 && texture_column<28){
   1C07 DD 7E 07      [19]  643 	ld	a,7 (ix)
   1C0A D6 04         [ 7]  644 	sub	a, #0x04
   1C0C DA 33 1D      [10]  645 	jp	C,00112$
   1C0F DD 7E 07      [19]  646 	ld	a,7 (ix)
   1C12 D6 1C         [ 7]  647 	sub	a, #0x1C
   1C14 D2 33 1D      [10]  648 	jp	NC,00112$
                            649 ;src/Renderer.c:234: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(enemy_get_at(index-1)->type)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
   1C17 DD 46 06      [19]  650 	ld	b,6 (ix)
   1C1A 05            [ 4]  651 	dec	b
   1C1B C5            [11]  652 	push	bc
   1C1C 33            [ 6]  653 	inc	sp
   1C1D CD 40 00      [17]  654 	call	_enemy_get_at
   1C20 33            [ 6]  655 	inc	sp
   1C21 23            [ 6]  656 	inc	hl
   1C22 4E            [ 7]  657 	ld	c,(hl)
   1C23 06 00         [ 7]  658 	ld	b,#0x00
   1C25 69            [ 4]  659 	ld	l, c
   1C26 60            [ 4]  660 	ld	h, b
   1C27 29            [11]  661 	add	hl, hl
   1C28 29            [11]  662 	add	hl, hl
   1C29 29            [11]  663 	add	hl, hl
   1C2A 09            [11]  664 	add	hl, bc
   1C2B 29            [11]  665 	add	hl, hl
   1C2C 29            [11]  666 	add	hl, hl
   1C2D 29            [11]  667 	add	hl, hl
   1C2E 29            [11]  668 	add	hl, hl
   1C2F 29            [11]  669 	add	hl, hl
   1C30 29            [11]  670 	add	hl, hl
   1C31 01 D0 A0      [10]  671 	ld	bc,#0xA0D0
   1C34 09            [11]  672 	add	hl,bc
   1C35 4D            [ 4]  673 	ld	c,l
   1C36 44            [ 4]  674 	ld	b,h
   1C37 DD 7E 07      [19]  675 	ld	a, 7 (ix)
   1C3A 16 00         [ 7]  676 	ld	d, #0x00
   1C3C C6 FC         [ 7]  677 	add	a,#0xFC
   1C3E 5F            [ 4]  678 	ld	e,a
   1C3F 7A            [ 4]  679 	ld	a,d
   1C40 CE FF         [ 7]  680 	adc	a,#0xFF
   1C42 57            [ 4]  681 	ld	d,a
   1C43 6B            [ 4]  682 	ld	l, e
   1C44 62            [ 4]  683 	ld	h, d
   1C45 29            [11]  684 	add	hl, hl
   1C46 19            [11]  685 	add	hl, de
   1C47 29            [11]  686 	add	hl, hl
   1C48 29            [11]  687 	add	hl, hl
   1C49 29            [11]  688 	add	hl, hl
   1C4A 09            [11]  689 	add	hl,bc
   1C4B 33            [ 6]  690 	inc	sp
   1C4C 33            [ 6]  691 	inc	sp
   1C4D E5            [11]  692 	push	hl
                            693 ;src/Renderer.c:236: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1C4E DD 7E 04      [19]  694 	ld	a,4 (ix)
   1C51 CB 3F         [ 8]  695 	srl	a
   1C53 C6 50         [ 7]  696 	add	a, #0x50
   1C55 DD 77 FA      [19]  697 	ld	-6 (ix),a
   1C58 3E 00         [ 7]  698 	ld	a,#0x00
   1C5A CE AA         [ 7]  699 	adc	a, #0xAA
   1C5C DD 77 FB      [19]  700 	ld	-5 (ix),a
                            701 ;src/Renderer.c:238: pixMask = g_pixelMask[column&1];
   1C5F 01 76 1A      [10]  702 	ld	bc,#_g_pixelMask+0
   1C62 DD 7E 04      [19]  703 	ld	a,4 (ix)
   1C65 E6 01         [ 7]  704 	and	a, #0x01
   1C67 6F            [ 4]  705 	ld	l, a
   1C68 26 00         [ 7]  706 	ld	h,#0x00
   1C6A 09            [11]  707 	add	hl,bc
   1C6B 7E            [ 7]  708 	ld	a,(hl)
   1C6C DD 77 F9      [19]  709 	ld	-7 (ix),a
                            710 ;src/Renderer.c:240: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
   1C6F DD 7E 05      [19]  711 	ld	a,5 (ix)
   1C72 CB 3F         [ 8]  712 	srl	a
   1C74 C6 32         [ 7]  713 	add	a, #0x32
   1C76 DD 77 F4      [19]  714 	ld	-12 (ix),a
                            715 ;src/Renderer.c:241: lineHeight = (lineHeight*3)/4;
   1C79 DD 4E 05      [19]  716 	ld	c,5 (ix)
   1C7C 06 00         [ 7]  717 	ld	b,#0x00
   1C7E 69            [ 4]  718 	ld	l, c
   1C7F 60            [ 4]  719 	ld	h, b
   1C80 29            [11]  720 	add	hl, hl
   1C81 09            [11]  721 	add	hl, bc
   1C82 DD 75 FE      [19]  722 	ld	-2 (ix),l
   1C85 DD 74 FF      [19]  723 	ld	-1 (ix),h
   1C88 DD 7E FE      [19]  724 	ld	a,-2 (ix)
   1C8B DD 77 FC      [19]  725 	ld	-4 (ix),a
   1C8E DD 7E FF      [19]  726 	ld	a,-1 (ix)
   1C91 DD 77 FD      [19]  727 	ld	-3 (ix),a
   1C94 DD CB FF 7E   [20]  728 	bit	7, -1 (ix)
   1C98 28 10         [12]  729 	jr	Z,00114$
   1C9A DD 7E FE      [19]  730 	ld	a,-2 (ix)
   1C9D C6 03         [ 7]  731 	add	a, #0x03
   1C9F DD 77 FC      [19]  732 	ld	-4 (ix),a
   1CA2 DD 7E FF      [19]  733 	ld	a,-1 (ix)
   1CA5 CE 00         [ 7]  734 	adc	a, #0x00
   1CA7 DD 77 FD      [19]  735 	ld	-3 (ix),a
   1CAA                     736 00114$:
   1CAA DD 46 FC      [19]  737 	ld	b,-4 (ix)
   1CAD DD 4E FD      [19]  738 	ld	c,-3 (ix)
   1CB0 CB 29         [ 8]  739 	sra	c
   1CB2 CB 18         [ 8]  740 	rr	b
   1CB4 CB 29         [ 8]  741 	sra	c
   1CB6 CB 18         [ 8]  742 	rr	b
                            743 ;src/Renderer.c:242: enemy_top_height = ground_height - lineHeight;
   1CB8 DD 7E F4      [19]  744 	ld	a,-12 (ix)
   1CBB 90            [ 4]  745 	sub	a, b
   1CBC 4F            [ 4]  746 	ld	c,a
                            747 ;src/Renderer.c:244: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
   1CBD 58            [ 4]  748 	ld	e,b
   1CBE 16 00         [ 7]  749 	ld	d,#0x00
   1CC0 C5            [11]  750 	push	bc
   1CC1 D5            [11]  751 	push	de
   1CC2 21 00 18      [10]  752 	ld	hl,#0x1800
   1CC5 E5            [11]  753 	push	hl
   1CC6 CD 29 7D      [17]  754 	call	__divsint
   1CC9 F1            [10]  755 	pop	af
   1CCA F1            [10]  756 	pop	af
   1CCB C1            [10]  757 	pop	bc
   1CCC DD 75 F5      [19]  758 	ld	-11 (ix),l
   1CCF DD 74 F6      [19]  759 	ld	-10 (ix),h
                            760 ;src/Renderer.c:245: j=lineHeight;
   1CD2 50            [ 4]  761 	ld	d,b
                            762 ;src/Renderer.c:247: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   1CD3 3E 64         [ 7]  763 	ld	a,#0x64
   1CD5 90            [ 4]  764 	sub	a, b
   1CD6 30 02         [12]  765 	jr	NC,00102$
                            766 ;src/Renderer.c:248: j=90;
   1CD8 16 5A         [ 7]  767 	ld	d,#0x5A
   1CDA                     768 00102$:
                            769 ;src/Renderer.c:251: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
   1CDA 06 00         [ 7]  770 	ld	b,#0x00
   1CDC 69            [ 4]  771 	ld	l, c
   1CDD 60            [ 4]  772 	ld	h, b
   1CDE 29            [11]  773 	add	hl, hl
   1CDF 29            [11]  774 	add	hl, hl
   1CE0 09            [11]  775 	add	hl, bc
   1CE1 29            [11]  776 	add	hl, hl
   1CE2 29            [11]  777 	add	hl, hl
   1CE3 29            [11]  778 	add	hl, hl
   1CE4 DD 7E FA      [19]  779 	ld	a,-6 (ix)
   1CE7 85            [ 4]  780 	add	a, l
   1CE8 4F            [ 4]  781 	ld	c,a
   1CE9 DD 7E FB      [19]  782 	ld	a,-5 (ix)
   1CEC 8C            [ 4]  783 	adc	a, h
   1CED 47            [ 4]  784 	ld	b,a
                            785 ;src/Renderer.c:253: for(j;j;--j){
   1CEE DD 7E F9      [19]  786 	ld	a,-7 (ix)
   1CF1 2F            [ 4]  787 	cpl
   1CF2 5F            [ 4]  788 	ld	e,a
   1CF3                     789 00110$:
   1CF3 7A            [ 4]  790 	ld	a,d
   1CF4 B7            [ 4]  791 	or	a, a
   1CF5 28 3C         [12]  792 	jr	Z,00112$
                            793 ;src/Renderer.c:255: color= *(texture+(texture_line/256));
   1CF7 DD 6E F8      [19]  794 	ld	l,-8 (ix)
   1CFA 26 00         [ 7]  795 	ld	h,#0x00
   1CFC DD 7E F2      [19]  796 	ld	a,-14 (ix)
   1CFF 85            [ 4]  797 	add	a, l
   1D00 6F            [ 4]  798 	ld	l,a
   1D01 DD 7E F3      [19]  799 	ld	a,-13 (ix)
   1D04 8C            [ 4]  800 	adc	a, h
   1D05 67            [ 4]  801 	ld	h,a
   1D06 7E            [ 7]  802 	ld	a,(hl)
                            803 ;src/Renderer.c:257: if(color){
   1D07 DD 77 FC      [19]  804 	ld	-4 (ix), a
   1D0A B7            [ 4]  805 	or	a, a
   1D0B 28 0B         [12]  806 	jr	Z,00104$
                            807 ;src/Renderer.c:258: val =  ((*pvmem)&(~pixMask));
   1D0D 0A            [ 7]  808 	ld	a,(bc)
   1D0E A3            [ 4]  809 	and	a, e
   1D0F 6F            [ 4]  810 	ld	l,a
                            811 ;src/Renderer.c:260: color = (color&pixMask);
   1D10 DD 7E FC      [19]  812 	ld	a,-4 (ix)
   1D13 DD A6 F9      [19]  813 	and	a, -7 (ix)
                            814 ;src/Renderer.c:262: *pvmem = val|color;
   1D16 B5            [ 4]  815 	or	a, l
   1D17 02            [ 7]  816 	ld	(bc),a
   1D18                     817 00104$:
                            818 ;src/Renderer.c:265: texture_line += texture_line_add;
   1D18 DD 7E F7      [19]  819 	ld	a,-9 (ix)
   1D1B DD 86 F5      [19]  820 	add	a, -11 (ix)
   1D1E DD 77 F7      [19]  821 	ld	-9 (ix),a
   1D21 DD 7E F8      [19]  822 	ld	a,-8 (ix)
   1D24 DD 8E F6      [19]  823 	adc	a, -10 (ix)
   1D27 DD 77 F8      [19]  824 	ld	-8 (ix),a
                            825 ;src/Renderer.c:267: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   1D2A 21 28 00      [10]  826 	ld	hl,#0x0028
   1D2D 09            [11]  827 	add	hl,bc
   1D2E 4D            [ 4]  828 	ld	c,l
   1D2F 44            [ 4]  829 	ld	b,h
                            830 ;src/Renderer.c:253: for(j;j;--j){
   1D30 15            [ 4]  831 	dec	d
   1D31 18 C0         [12]  832 	jr	00110$
   1D33                     833 00112$:
   1D33 DD F9         [10]  834 	ld	sp, ix
   1D35 DD E1         [14]  835 	pop	ix
   1D37 C9            [10]  836 	ret
                            837 ;src/Renderer.c:359: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
                            838 ;	---------------------------------
                            839 ; Function draw_column_to_buffer
                            840 ; ---------------------------------
   1D38                     841 _draw_column_to_buffer::
   1D38 DD E5         [15]  842 	push	ix
   1D3A DD 21 00 00   [14]  843 	ld	ix,#0
   1D3E DD 39         [15]  844 	add	ix,sp
   1D40 21 F1 FF      [10]  845 	ld	hl,#-15
   1D43 39            [11]  846 	add	hl,sp
   1D44 F9            [ 6]  847 	ld	sp,hl
                            848 ;src/Renderer.c:360: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1D45 DD 7E 04      [19]  849 	ld	a,4 (ix)
   1D48 CB 3F         [ 8]  850 	srl	a
   1D4A C6 50         [ 7]  851 	add	a, #0x50
   1D4C DD 77 FA      [19]  852 	ld	-6 (ix),a
   1D4F 3E 00         [ 7]  853 	ld	a,#0x00
   1D51 CE AA         [ 7]  854 	adc	a, #0xAA
   1D53 DD 77 FB      [19]  855 	ld	-5 (ix),a
                            856 ;src/Renderer.c:363: u8 pixMask = g_pixelMask[column&1];
   1D56 01 76 1A      [10]  857 	ld	bc,#_g_pixelMask+0
   1D59 DD 7E 04      [19]  858 	ld	a,4 (ix)
   1D5C E6 01         [ 7]  859 	and	a, #0x01
   1D5E 6F            [ 4]  860 	ld	l, a
   1D5F 26 00         [ 7]  861 	ld	h,#0x00
   1D61 09            [11]  862 	add	hl,bc
   1D62 7E            [ 7]  863 	ld	a,(hl)
   1D63 DD 77 F3      [19]  864 	ld	-13 (ix),a
                            865 ;src/Renderer.c:368: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
   1D66 DD 7E 06      [19]  866 	ld	a, 6 (ix)
   1D69 87            [ 4]  867 	add	a, a
   1D6A 87            [ 4]  868 	add	a, a
   1D6B 47            [ 4]  869 	ld	b,a
   1D6C 0E 00         [ 7]  870 	ld	c,#0x00
   1D6E 21 D0 8C      [10]  871 	ld	hl,#0x8CD0
   1D71 09            [11]  872 	add	hl,bc
   1D72 4D            [ 4]  873 	ld	c,l
   1D73 44            [ 4]  874 	ld	b,h
   1D74 DD 6E 07      [19]  875 	ld	l,7 (ix)
   1D77 26 00         [ 7]  876 	ld	h,#0x00
   1D79 29            [11]  877 	add	hl, hl
   1D7A 29            [11]  878 	add	hl, hl
   1D7B 29            [11]  879 	add	hl, hl
   1D7C 29            [11]  880 	add	hl, hl
   1D7D 29            [11]  881 	add	hl, hl
   1D7E 09            [11]  882 	add	hl,bc
   1D7F DD 75 F6      [19]  883 	ld	-10 (ix),l
   1D82 DD 74 F7      [19]  884 	ld	-9 (ix),h
                            885 ;src/Renderer.c:370: u8 j=lineHeight;
   1D85 DD 7E 05      [19]  886 	ld	a,5 (ix)
                            887 ;src/Renderer.c:376: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
   1D88 DD 77 F5      [19]  888 	ld	-11 (ix), a
   1D8B DD 77 FE      [19]  889 	ld	-2 (ix),a
   1D8E DD 36 FF 00   [19]  890 	ld	-1 (ix),#0x00
   1D92 DD 6E FE      [19]  891 	ld	l,-2 (ix)
   1D95 DD 66 FF      [19]  892 	ld	h,-1 (ix)
   1D98 E5            [11]  893 	push	hl
   1D99 21 00 20      [10]  894 	ld	hl,#0x2000
   1D9C E5            [11]  895 	push	hl
   1D9D CD 29 7D      [17]  896 	call	__divsint
   1DA0 F1            [10]  897 	pop	af
   1DA1 F1            [10]  898 	pop	af
   1DA2 DD 75 F8      [19]  899 	ld	-8 (ix),l
   1DA5 DD 74 F9      [19]  900 	ld	-7 (ix),h
                            901 ;src/Renderer.c:377: u16 wall_texture_line=0;
   1DA8 21 00 00      [10]  902 	ld	hl,#0x0000
   1DAB E3            [19]  903 	ex	(sp), hl
                            904 ;src/Renderer.c:379: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   1DAC DD 4E F5      [19]  905 	ld	c,-11 (ix)
   1DAF CB 39         [ 8]  906 	srl	c
   1DB1 3E 32         [ 7]  907 	ld	a,#0x32
   1DB3 91            [ 4]  908 	sub	a, c
   1DB4 DD 77 F4      [19]  909 	ld	-12 (ix),a
                            910 ;src/Renderer.c:383: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   1DB7 3E 64         [ 7]  911 	ld	a,#0x64
   1DB9 DD 96 F5      [19]  912 	sub	a, -11 (ix)
   1DBC 30 48         [12]  913 	jr	NC,00102$
                            914 ;src/Renderer.c:384: ceiling_height=0;
   1DBE DD 36 F4 00   [19]  915 	ld	-12 (ix),#0x00
                            916 ;src/Renderer.c:385: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
   1DC2 DD 7E FE      [19]  917 	ld	a,-2 (ix)
   1DC5 C6 9C         [ 7]  918 	add	a,#0x9C
   1DC7 4F            [ 4]  919 	ld	c,a
   1DC8 DD 7E FF      [19]  920 	ld	a,-1 (ix)
   1DCB CE FF         [ 7]  921 	adc	a,#0xFF
   1DCD 47            [ 4]  922 	ld	b,a
   1DCE DD 71 FC      [19]  923 	ld	-4 (ix),c
   1DD1 DD 70 FD      [19]  924 	ld	-3 (ix),b
   1DD4 CB 78         [ 8]  925 	bit	7, b
   1DD6 28 10         [12]  926 	jr	Z,00111$
   1DD8 DD 7E FE      [19]  927 	ld	a,-2 (ix)
   1DDB C6 9D         [ 7]  928 	add	a, #0x9D
   1DDD DD 77 FC      [19]  929 	ld	-4 (ix),a
   1DE0 DD 7E FF      [19]  930 	ld	a,-1 (ix)
   1DE3 CE FF         [ 7]  931 	adc	a, #0xFF
   1DE5 DD 77 FD      [19]  932 	ld	-3 (ix),a
   1DE8                     933 00111$:
   1DE8 DD 4E FC      [19]  934 	ld	c,-4 (ix)
   1DEB DD 46 FD      [19]  935 	ld	b,-3 (ix)
   1DEE CB 28         [ 8]  936 	sra	b
   1DF0 CB 19         [ 8]  937 	rr	c
   1DF2 DD 6E F8      [19]  938 	ld	l,-8 (ix)
   1DF5 DD 66 F9      [19]  939 	ld	h,-7 (ix)
   1DF8 E5            [11]  940 	push	hl
   1DF9 C5            [11]  941 	push	bc
   1DFA CD 25 7B      [17]  942 	call	__mulint
   1DFD F1            [10]  943 	pop	af
   1DFE F1            [10]  944 	pop	af
   1DFF 33            [ 6]  945 	inc	sp
   1E00 33            [ 6]  946 	inc	sp
   1E01 E5            [11]  947 	push	hl
                            948 ;src/Renderer.c:386: j=SCREEN_TEXTURE_HEIGHT;
   1E02 DD 36 F5 64   [19]  949 	ld	-11 (ix),#0x64
   1E06                     950 00102$:
                            951 ;src/Renderer.c:389: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
   1E06 DD 4E F4      [19]  952 	ld	c,-12 (ix)
   1E09 06 00         [ 7]  953 	ld	b,#0x00
   1E0B 69            [ 4]  954 	ld	l, c
   1E0C 60            [ 4]  955 	ld	h, b
   1E0D 29            [11]  956 	add	hl, hl
   1E0E 29            [11]  957 	add	hl, hl
   1E0F 09            [11]  958 	add	hl, bc
   1E10 29            [11]  959 	add	hl, hl
   1E11 29            [11]  960 	add	hl, hl
   1E12 29            [11]  961 	add	hl, hl
   1E13 DD 7E FA      [19]  962 	ld	a,-6 (ix)
   1E16 85            [ 4]  963 	add	a, l
   1E17 4F            [ 4]  964 	ld	c,a
   1E18 DD 7E FB      [19]  965 	ld	a,-5 (ix)
   1E1B 8C            [ 4]  966 	adc	a, h
   1E1C 47            [ 4]  967 	ld	b,a
                            968 ;src/Renderer.c:391: for(j;j;--j){
   1E1D DD 7E F3      [19]  969 	ld	a,-13 (ix)
   1E20 2F            [ 4]  970 	cpl
   1E21 DD 77 FC      [19]  971 	ld	-4 (ix),a
   1E24 DD 56 F5      [19]  972 	ld	d,-11 (ix)
   1E27                     973 00107$:
   1E27 7A            [ 4]  974 	ld	a,d
   1E28 B7            [ 4]  975 	or	a, a
   1E29 28 39         [12]  976 	jr	Z,00109$
                            977 ;src/Renderer.c:393: w_color = *(texture+(wall_texture_line/256));
   1E2B DD 7E F2      [19]  978 	ld	a, -14 (ix)
   1E2E 26 00         [ 7]  979 	ld	h, #0x00
   1E30 DD 86 F6      [19]  980 	add	a, -10 (ix)
   1E33 6F            [ 4]  981 	ld	l,a
   1E34 7C            [ 4]  982 	ld	a,h
   1E35 DD 8E F7      [19]  983 	adc	a, -9 (ix)
   1E38 67            [ 4]  984 	ld	h,a
   1E39 5E            [ 7]  985 	ld	e,(hl)
                            986 ;src/Renderer.c:395: if(w_color){
   1E3A 7B            [ 4]  987 	ld	a,e
   1E3B B7            [ 4]  988 	or	a, a
   1E3C 28 0B         [12]  989 	jr	Z,00104$
                            990 ;src/Renderer.c:397: val =  ((*pvmem)&(~pixMask));
   1E3E 0A            [ 7]  991 	ld	a,(bc)
   1E3F DD A6 FC      [19]  992 	and	a, -4 (ix)
   1E42 6F            [ 4]  993 	ld	l,a
                            994 ;src/Renderer.c:399: w_color = (w_color&pixMask);
   1E43 7B            [ 4]  995 	ld	a,e
   1E44 DD A6 F3      [19]  996 	and	a, -13 (ix)
                            997 ;src/Renderer.c:401: *pvmem = val|w_color;
   1E47 B5            [ 4]  998 	or	a, l
   1E48 02            [ 7]  999 	ld	(bc),a
   1E49                    1000 00104$:
                           1001 ;src/Renderer.c:405: wall_texture_line += wall_texture_line_add;
   1E49 DD 7E F1      [19] 1002 	ld	a,-15 (ix)
   1E4C DD 86 F8      [19] 1003 	add	a, -8 (ix)
   1E4F DD 77 F1      [19] 1004 	ld	-15 (ix),a
   1E52 DD 7E F2      [19] 1005 	ld	a,-14 (ix)
   1E55 DD 8E F9      [19] 1006 	adc	a, -7 (ix)
   1E58 DD 77 F2      [19] 1007 	ld	-14 (ix),a
                           1008 ;src/Renderer.c:407: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   1E5B 21 28 00      [10] 1009 	ld	hl,#0x0028
   1E5E 09            [11] 1010 	add	hl,bc
   1E5F 4D            [ 4] 1011 	ld	c,l
   1E60 44            [ 4] 1012 	ld	b,h
                           1013 ;src/Renderer.c:391: for(j;j;--j){
   1E61 15            [ 4] 1014 	dec	d
   1E62 18 C3         [12] 1015 	jr	00107$
   1E64                    1016 00109$:
   1E64 DD F9         [10] 1017 	ld	sp, ix
   1E66 DD E1         [14] 1018 	pop	ix
   1E68 C9            [10] 1019 	ret
                           1020 ;src/Renderer.c:411: void render_draw_to_buffer(){//TODO Optimize
                           1021 ;	---------------------------------
                           1022 ; Function render_draw_to_buffer
                           1023 ; ---------------------------------
   1E69                    1024 _render_draw_to_buffer::
   1E69 DD E5         [15] 1025 	push	ix
   1E6B DD 21 00 00   [14] 1026 	ld	ix,#0
   1E6F DD 39         [15] 1027 	add	ix,sp
   1E71 21 C6 FF      [10] 1028 	ld	hl,#-58
   1E74 39            [11] 1029 	add	hl,sp
   1E75 F9            [ 6] 1030 	ld	sp,hl
                           1031 ;src/Renderer.c:423: u8 zHeight = 5;
   1E76 DD 36 D2 05   [19] 1032 	ld	-46 (ix),#0x05
                           1033 ;src/Renderer.c:433: u8 offsetDiff = 16;
   1E7A DD 36 CF 10   [19] 1034 	ld	-49 (ix),#0x10
                           1035 ;src/Renderer.c:438: u8 lineStart = 0;
   1E7E DD 36 C7 00   [19] 1036 	ld	-57 (ix),#0x00
                           1037 ;src/Renderer.c:440: u8 lateralWallWidth=0;
   1E82 DD 36 CE 00   [19] 1038 	ld	-50 (ix),#0x00
                           1039 ;src/Renderer.c:452: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   1E86 21 6D 1A      [10] 1040 	ld	hl, #_g_colors + 7
   1E89 46            [ 7] 1041 	ld	b,(hl)
   1E8A 21 A8 07      [10] 1042 	ld	hl,#0x07A8
   1E8D E5            [11] 1043 	push	hl
   1E8E C5            [11] 1044 	push	bc
   1E8F 33            [ 6] 1045 	inc	sp
   1E90 21 50 AA      [10] 1046 	ld	hl,#0xAA50
   1E93 E5            [11] 1047 	push	hl
   1E94 CD 52 7C      [17] 1048 	call	_cpct_memset
                           1049 ;src/Renderer.c:453: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
   1E97 21 67 1A      [10] 1050 	ld	hl, #_g_colors + 1
   1E9A 46            [ 7] 1051 	ld	b,(hl)
   1E9B 21 50 00      [10] 1052 	ld	hl,#0x0050
   1E9E E5            [11] 1053 	push	hl
   1E9F C5            [11] 1054 	push	bc
   1EA0 33            [ 6] 1055 	inc	sp
   1EA1 21 F8 B1      [10] 1056 	ld	hl,#0xB1F8
   1EA4 E5            [11] 1057 	push	hl
   1EA5 CD 52 7C      [17] 1058 	call	_cpct_memset
                           1059 ;src/Renderer.c:454: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   1EA8 21 6E 1A      [10] 1060 	ld	hl, #_g_colors + 8
   1EAB 46            [ 7] 1061 	ld	b,(hl)
   1EAC 21 A8 07      [10] 1062 	ld	hl,#0x07A8
   1EAF E5            [11] 1063 	push	hl
   1EB0 C5            [11] 1064 	push	bc
   1EB1 33            [ 6] 1065 	inc	sp
   1EB2 21 48 B2      [10] 1066 	ld	hl,#0xB248
   1EB5 E5            [11] 1067 	push	hl
   1EB6 CD 52 7C      [17] 1068 	call	_cpct_memset
                           1069 ;src/Renderer.c:456: calculate_cells_in_view();
   1EB9 CD A5 18      [17] 1070 	call	_calculate_cells_in_view
                           1071 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   1EBC 2A 78 1A      [16] 1072 	ld	hl,(_cells_in_view_array)
   1EBF DD 75 E7      [19] 1073 	ld	-25 (ix),l
   1EC2 DD 74 E8      [19] 1074 	ld	-24 (ix),h
                           1075 ;src/Renderer.c:458: if(textures_on){
   1EC5 3A 19 7E      [13] 1076 	ld	a,(#_textures_on + 0)
   1EC8 B7            [ 4] 1077 	or	a, a
   1EC9 CA 47 24      [10] 1078 	jp	Z,00370$
                           1079 ;src/Renderer.c:460: do{
   1ECC DD 36 CA 06   [19] 1080 	ld	-54 (ix),#0x06
   1ED0                    1081 00179$:
                           1082 ;src/Renderer.c:462: --z;
   1ED0 DD 35 CA      [23] 1083 	dec	-54 (ix)
                           1084 ;src/Renderer.c:466: xCellCount = (z) ? (zHeight >> 1) : 0;
   1ED3 DD 7E D2      [19] 1085 	ld	a,-46 (ix)
   1ED6 CB 3F         [ 8] 1086 	srl	a
   1ED8 DD 77 EB      [19] 1087 	ld	-21 (ix),a
   1EDB DD 7E CA      [19] 1088 	ld	a,-54 (ix)
   1EDE B7            [ 4] 1089 	or	a, a
   1EDF 28 05         [12] 1090 	jr	Z,00270$
   1EE1 DD 4E EB      [19] 1091 	ld	c,-21 (ix)
   1EE4 18 02         [12] 1092 	jr	00271$
   1EE6                    1093 00270$:
   1EE6 0E 00         [ 7] 1094 	ld	c,#0x00
   1EE8                    1095 00271$:
   1EE8 DD 71 EE      [19] 1096 	ld	-18 (ix),c
                           1097 ;src/Renderer.c:467: lateralWallSlope=0;
   1EEB DD 36 F0 00   [19] 1098 	ld	-16 (ix),#0x00
                           1099 ;src/Renderer.c:468: lateralWallSlopeCounter=0;
   1EEF DD 36 F9 00   [19] 1100 	ld	-7 (ix),#0x00
                           1101 ;src/Renderer.c:469: xHeight=0;
   1EF3 DD 36 DA 00   [19] 1102 	ld	-38 (ix),#0x00
                           1103 ;src/Renderer.c:472: lateralWallCounter = 0;
   1EF7 DD 36 D9 00   [19] 1104 	ld	-39 (ix),#0x00
                           1105 ;src/Renderer.c:474: newCell=1;
   1EFB DD 36 DC 01   [19] 1106 	ld	-36 (ix),#0x01
                           1107 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   1EFF DD 7E C7      [19] 1108 	ld	a,-57 (ix)
   1F02 DD 77 E3      [19] 1109 	ld	-29 (ix),a
   1F05 DD 36 E4 00   [19] 1110 	ld	-28 (ix),#0x00
   1F09 DD 4E E3      [19] 1111 	ld	c,-29 (ix)
   1F0C DD 46 E4      [19] 1112 	ld	b,-28 (ix)
   1F0F 03            [ 6] 1113 	inc	bc
   1F10 DD 6E E7      [19] 1114 	ld	l,-25 (ix)
   1F13 DD 66 E8      [19] 1115 	ld	h,-24 (ix)
   1F16 09            [11] 1116 	add	hl,bc
   1F17 7E            [ 7] 1117 	ld	a,(hl)
   1F18 DD 77 DB      [19] 1118 	ld	-37 (ix),a
                           1119 ;src/Renderer.c:477: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   1F1B DD 7E E7      [19] 1120 	ld	a,-25 (ix)
   1F1E DD 86 C7      [19] 1121 	add	a, -57 (ix)
   1F21 6F            [ 4] 1122 	ld	l,a
   1F22 DD 7E E8      [19] 1123 	ld	a,-24 (ix)
   1F25 CE 00         [ 7] 1124 	adc	a, #0x00
   1F27 67            [ 4] 1125 	ld	h,a
   1F28 4E            [ 7] 1126 	ld	c,(hl)
                           1127 ;src/Renderer.c:478: if(lastCellWasWall&CELL_WALL_MASK){
   1F29 CB 79         [ 8] 1128 	bit	7, c
   1F2B 28 09         [12] 1129 	jr	Z,00102$
                           1130 ;src/Renderer.c:479: lastWallId=lastCellWasWall;
   1F2D DD 71 D7      [19] 1131 	ld	-41 (ix),c
                           1132 ;src/Renderer.c:480: lastCellWasWall=1;
   1F30 DD 36 EF 01   [19] 1133 	ld	-17 (ix),#0x01
   1F34 18 08         [12] 1134 	jr	00305$
   1F36                    1135 00102$:
                           1136 ;src/Renderer.c:483: lastCellWasWall=0;
   1F36 DD 36 EF 00   [19] 1137 	ld	-17 (ix),#0x00
                           1138 ;src/Renderer.c:484: lastWallId=CELLTYPE_FLOOR;
   1F3A DD 36 D7 00   [19] 1139 	ld	-41 (ix),#0x00
                           1140 ;src/Renderer.c:487: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   1F3E                    1141 00305$:
   1F3E DD 36 D1 00   [19] 1142 	ld	-47 (ix),#0x00
   1F42 DD 36 D3 00   [19] 1143 	ld	-45 (ix),#0x00
   1F46                    1144 00260$:
                           1145 ;src/Renderer.c:489: if (xCellCount == zHeight)
   1F46 DD 7E D2      [19] 1146 	ld	a,-46 (ix)
   1F49 DD 96 EE      [19] 1147 	sub	a, -18 (ix)
   1F4C 20 4B         [12] 1148 	jr	NZ,00105$
                           1149 ;src/Renderer.c:491: ++xCell;
   1F4E DD 34 D1      [23] 1150 	inc	-47 (ix)
                           1151 ;src/Renderer.c:492: xCellCount = 0;
   1F51 DD 36 EE 00   [19] 1152 	ld	-18 (ix),#0x00
                           1153 ;src/Renderer.c:493: newCell=1;
   1F55 DD 36 DC 01   [19] 1154 	ld	-36 (ix),#0x01
                           1155 ;src/Renderer.c:494: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   1F59 DD 7E D1      [19] 1156 	ld	a,-47 (ix)
   1F5C DD 77 F5      [19] 1157 	ld	-11 (ix),a
   1F5F DD 36 F6 00   [19] 1158 	ld	-10 (ix),#0x00
   1F63 DD 7E E3      [19] 1159 	ld	a,-29 (ix)
   1F66 DD 86 F5      [19] 1160 	add	a, -11 (ix)
   1F69 DD 77 F5      [19] 1161 	ld	-11 (ix),a
   1F6C DD 7E E4      [19] 1162 	ld	a,-28 (ix)
   1F6F DD 8E F6      [19] 1163 	adc	a, -10 (ix)
   1F72 DD 77 F6      [19] 1164 	ld	-10 (ix),a
   1F75 DD 34 F5      [23] 1165 	inc	-11 (ix)
   1F78 20 03         [12] 1166 	jr	NZ,00632$
   1F7A DD 34 F6      [23] 1167 	inc	-10 (ix)
   1F7D                    1168 00632$:
   1F7D DD 7E E7      [19] 1169 	ld	a,-25 (ix)
   1F80 DD 86 F5      [19] 1170 	add	a, -11 (ix)
   1F83 DD 77 F5      [19] 1171 	ld	-11 (ix),a
   1F86 DD 7E E8      [19] 1172 	ld	a,-24 (ix)
   1F89 DD 8E F6      [19] 1173 	adc	a, -10 (ix)
   1F8C DD 77 F6      [19] 1174 	ld	-10 (ix),a
   1F8F DD 6E F5      [19] 1175 	ld	l,-11 (ix)
   1F92 DD 66 F6      [19] 1176 	ld	h,-10 (ix)
   1F95 7E            [ 7] 1177 	ld	a,(hl)
   1F96 DD 77 DB      [19] 1178 	ld	-37 (ix),a
   1F99                    1179 00105$:
                           1180 ;src/Renderer.c:496: if(!(x%2)){
   1F99 DD 7E D3      [19] 1181 	ld	a,-45 (ix)
   1F9C E6 01         [ 7] 1182 	and	a, #0x01
   1F9E DD 77 F5      [19] 1183 	ld	-11 (ix),a
                           1184 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   1FA1 DD 7E DB      [19] 1185 	ld	a,-37 (ix)
   1FA4 E6 80         [ 7] 1186 	and	a, #0x80
   1FA6 DD 77 D8      [19] 1187 	ld	-40 (ix),a
                           1188 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   1FA9 DD 7E EE      [19] 1189 	ld	a,-18 (ix)
   1FAC DD 77 E5      [19] 1190 	ld	-27 (ix),a
   1FAF DD 36 E6 00   [19] 1191 	ld	-26 (ix),#0x00
   1FB3 DD 7E D2      [19] 1192 	ld	a,-46 (ix)
   1FB6 DD 77 E9      [19] 1193 	ld	-23 (ix),a
                           1194 ;src/Renderer.c:496: if(!(x%2)){
   1FB9 DD 7E F5      [19] 1195 	ld	a,-11 (ix)
   1FBC B7            [ 4] 1196 	or	a, a
   1FBD C2 70 20      [10] 1197 	jp	NZ,00118$
                           1198 ;src/Renderer.c:497: if ((lateralWallCounter == 0)||newCell)
   1FC0 DD 7E D9      [19] 1199 	ld	a,-39 (ix)
   1FC3 B7            [ 4] 1200 	or	a, a
   1FC4 28 07         [12] 1201 	jr	Z,00114$
   1FC6 DD 7E DC      [19] 1202 	ld	a,-36 (ix)
   1FC9 B7            [ 4] 1203 	or	a, a
   1FCA CA 70 20      [10] 1204 	jp	Z,00118$
   1FCD                    1205 00114$:
                           1206 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   1FCD DD 7E D8      [19] 1207 	ld	a,-40 (ix)
   1FD0 B7            [ 4] 1208 	or	a, a
   1FD1 28 22         [12] 1209 	jr	Z,00112$
                           1210 ;src/Renderer.c:501: lateralWallCounter = 0;//(zHeight - xCellCount);
   1FD3 DD 36 D9 00   [19] 1211 	ld	-39 (ix),#0x00
                           1212 ;src/Renderer.c:502: lateralWallSlope = 0;
   1FD7 DD 36 F0 00   [19] 1213 	ld	-16 (ix),#0x00
                           1214 ;src/Renderer.c:503: xHeight = zHeight;
   1FDB DD 7E D2      [19] 1215 	ld	a,-46 (ix)
   1FDE DD 77 DA      [19] 1216 	ld	-38 (ix),a
                           1217 ;src/Renderer.c:504: color = currentCellID&0b01111111;
   1FE1 DD 7E DB      [19] 1218 	ld	a,-37 (ix)
   1FE4 E6 7F         [ 7] 1219 	and	a, #0x7F
   1FE6 DD 77 EA      [19] 1220 	ld	-22 (ix),a
                           1221 ;src/Renderer.c:505: lastCellWasWall = 1;
   1FE9 DD 36 EF 01   [19] 1222 	ld	-17 (ix),#0x01
                           1223 ;src/Renderer.c:506: lastWallId=currentCellID;
   1FED DD 7E DB      [19] 1224 	ld	a,-37 (ix)
   1FF0 DD 77 D7      [19] 1225 	ld	-41 (ix),a
   1FF3 18 77         [12] 1226 	jr	00113$
   1FF5                    1227 00112$:
                           1228 ;src/Renderer.c:509: if(lateralWallCounter==0){//Lateral wall not finished
   1FF5 DD 7E D9      [19] 1229 	ld	a,-39 (ix)
   1FF8 B7            [ 4] 1230 	or	a, a
   1FF9 20 71         [12] 1231 	jr	NZ,00113$
                           1232 ;src/Renderer.c:510: if (lastCellWasWall)
   1FFB DD 7E EF      [19] 1233 	ld	a,-17 (ix)
   1FFE B7            [ 4] 1234 	or	a, a
   1FFF 28 5B         [12] 1235 	jr	Z,00107$
                           1236 ;src/Renderer.c:513: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   2001 DD 7E CF      [19] 1237 	ld	a,-49 (ix)
   2004 DD 96 D1      [19] 1238 	sub	a, -47 (ix)
   2007 87            [ 4] 1239 	add	a, a
   2008 3C            [ 4] 1240 	inc	a
                           1241 ;src/Renderer.c:514: lateralWallSlopeCounter = lateralWallSlope / 2;
   2009 DD 77 F0      [19] 1242 	ld	-16 (ix), a
   200C CB 3F         [ 8] 1243 	srl	a
   200E DD 77 F9      [19] 1244 	ld	-7 (ix),a
                           1245 ;src/Renderer.c:515: lateralWallCounter = lateralWallSlope * zHeight;
   2011 DD 5E D2      [19] 1246 	ld	e,-46 (ix)
   2014 DD 66 F0      [19] 1247 	ld	h,-16 (ix)
   2017 2E 00         [ 7] 1248 	ld	l, #0x00
   2019 55            [ 4] 1249 	ld	d, l
   201A 06 08         [ 7] 1250 	ld	b, #0x08
   201C                    1251 00633$:
   201C 29            [11] 1252 	add	hl,hl
   201D 30 01         [12] 1253 	jr	NC,00634$
   201F 19            [11] 1254 	add	hl,de
   2020                    1255 00634$:
   2020 10 FA         [13] 1256 	djnz	00633$
                           1257 ;src/Renderer.c:516: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   2022 7D            [ 4] 1258 	ld	a,l
   2023 E6 FC         [ 7] 1259 	and	a, #0xFC
   2025 CB C7         [ 8] 1260 	set	0, a
   2027 CB 3F         [ 8] 1261 	srl	a
   2029 CB 3F         [ 8] 1262 	srl	a
   202B DD 96 EE      [19] 1263 	sub	a, -18 (ix)
                           1264 ;src/Renderer.c:517: lateralWallWidth=lateralWallCounter;
   202E DD 77 D9      [19] 1265 	ld	-39 (ix), a
   2031 DD 77 CE      [19] 1266 	ld	-50 (ix),a
                           1267 ;src/Renderer.c:518: lastCellWasWall = 0;
   2034 DD 36 EF 00   [19] 1268 	ld	-17 (ix),#0x00
                           1269 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   2038 DD 6E E5      [19] 1270 	ld	l,-27 (ix)
   203B DD 66 E6      [19] 1271 	ld	h,-26 (ix)
   203E 29            [11] 1272 	add	hl, hl
   203F DD 4E F0      [19] 1273 	ld	c,-16 (ix)
   2042 06 00         [ 7] 1274 	ld	b,#0x00
   2044 C5            [11] 1275 	push	bc
   2045 E5            [11] 1276 	push	hl
   2046 CD 29 7D      [17] 1277 	call	__divsint
   2049 F1            [10] 1278 	pop	af
   204A F1            [10] 1279 	pop	af
   204B DD 7E E9      [19] 1280 	ld	a,-23 (ix)
   204E 95            [ 4] 1281 	sub	a, l
   204F DD 77 DA      [19] 1282 	ld	-38 (ix),a
                           1283 ;src/Renderer.c:520: color = lastWallId&0b01111111;
   2052 DD 7E D7      [19] 1284 	ld	a,-41 (ix)
   2055 E6 7F         [ 7] 1285 	and	a, #0x7F
   2057 DD 77 EA      [19] 1286 	ld	-22 (ix),a
   205A 18 10         [12] 1287 	jr	00113$
   205C                    1288 00107$:
                           1289 ;src/Renderer.c:524: xHeight = 0;
   205C DD 36 DA 00   [19] 1290 	ld	-38 (ix),#0x00
                           1291 ;src/Renderer.c:525: lastCellWasWall = 0;
   2060 DD 36 EF 00   [19] 1292 	ld	-17 (ix),#0x00
                           1293 ;src/Renderer.c:526: lateralWallSlope=0;
   2064 DD 36 F0 00   [19] 1294 	ld	-16 (ix),#0x00
                           1295 ;src/Renderer.c:527: lastWallId=0;
   2068 DD 36 D7 00   [19] 1296 	ld	-41 (ix),#0x00
   206C                    1297 00113$:
                           1298 ;src/Renderer.c:531: newCell=0;
   206C DD 36 DC 00   [19] 1299 	ld	-36 (ix),#0x00
   2070                    1300 00118$:
                           1301 ;src/Renderer.c:534: if (lateralWallCounter > 0)
   2070 DD 7E D9      [19] 1302 	ld	a,-39 (ix)
   2073 B7            [ 4] 1303 	or	a, a
   2074 28 1E         [12] 1304 	jr	Z,00124$
                           1305 ;src/Renderer.c:537: if (lateralWallSlope != 0)
   2076 DD 7E F0      [19] 1306 	ld	a,-16 (ix)
   2079 B7            [ 4] 1307 	or	a, a
   207A 28 15         [12] 1308 	jr	Z,00122$
                           1309 ;src/Renderer.c:539: if (lateralWallSlopeCounter == lateralWallSlope)
   207C DD 7E F9      [19] 1310 	ld	a,-7 (ix)
   207F DD 96 F0      [19] 1311 	sub	a, -16 (ix)
   2082 20 0A         [12] 1312 	jr	NZ,00120$
                           1313 ;src/Renderer.c:541: lateralWallSlopeCounter = 0;
   2084 DD 36 F9 00   [19] 1314 	ld	-7 (ix),#0x00
                           1315 ;src/Renderer.c:542: xHeight -= 2;
   2088 DD 35 DA      [23] 1316 	dec	-38 (ix)
   208B DD 35 DA      [23] 1317 	dec	-38 (ix)
   208E                    1318 00120$:
                           1319 ;src/Renderer.c:544: ++lateralWallSlopeCounter;
   208E DD 34 F9      [23] 1320 	inc	-7 (ix)
   2091                    1321 00122$:
                           1322 ;src/Renderer.c:547: --lateralWallCounter;
   2091 DD 35 D9      [23] 1323 	dec	-39 (ix)
   2094                    1324 00124$:
                           1325 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   2094 DD 7E D2      [19] 1326 	ld	a,-46 (ix)
   2097 DD 77 EC      [19] 1327 	ld	-20 (ix),a
   209A DD 36 ED 00   [19] 1328 	ld	-19 (ix),#0x00
                           1329 ;src/Renderer.c:550: if (!(x%2))
   209E DD 7E F5      [19] 1330 	ld	a,-11 (ix)
   20A1 B7            [ 4] 1331 	or	a, a
   20A2 C2 3D 21      [10] 1332 	jp	NZ,00138$
                           1333 ;src/Renderer.c:560: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   20A5 DD 46 D3      [19] 1334 	ld	b,-45 (ix)
   20A8 CB 38         [ 8] 1335 	srl	b
                           1336 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   20AA DD 6E E5      [19] 1337 	ld	l,-27 (ix)
   20AD DD 66 E6      [19] 1338 	ld	h,-26 (ix)
   20B0 29            [11] 1339 	add	hl, hl
   20B1 29            [11] 1340 	add	hl, hl
   20B2 29            [11] 1341 	add	hl, hl
   20B3 29            [11] 1342 	add	hl, hl
   20B4 29            [11] 1343 	add	hl, hl
   20B5 C5            [11] 1344 	push	bc
   20B6 DD 5E EC      [19] 1345 	ld	e,-20 (ix)
   20B9 DD 56 ED      [19] 1346 	ld	d,-19 (ix)
   20BC D5            [11] 1347 	push	de
   20BD E5            [11] 1348 	push	hl
   20BE CD 29 7D      [17] 1349 	call	__divsint
   20C1 F1            [10] 1350 	pop	af
   20C2 F1            [10] 1351 	pop	af
   20C3 C1            [10] 1352 	pop	bc
   20C4 4D            [ 4] 1353 	ld	c,l
                           1354 ;src/Renderer.c:552: if(xHeight > 0){
   20C5 DD 7E DA      [19] 1355 	ld	a,-38 (ix)
   20C8 B7            [ 4] 1356 	or	a, a
   20C9 28 3A         [12] 1357 	jr	Z,00129$
                           1358 ;src/Renderer.c:553: if (lateralWallCounter > 0)
   20CB DD 7E D9      [19] 1359 	ld	a,-39 (ix)
   20CE B7            [ 4] 1360 	or	a, a
   20CF 28 21         [12] 1361 	jr	Z,00126$
                           1362 ;src/Renderer.c:555: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   20D1 DD 5E CE      [19] 1363 	ld	e,-50 (ix)
   20D4 16 00         [ 7] 1364 	ld	d,#0x00
   20D6 DD 6E D9      [19] 1365 	ld	l,-39 (ix)
   20D9 26 00         [ 7] 1366 	ld	h,#0x00
   20DB 7B            [ 4] 1367 	ld	a,e
   20DC 95            [ 4] 1368 	sub	a, l
   20DD 6F            [ 4] 1369 	ld	l,a
   20DE 7A            [ 4] 1370 	ld	a,d
   20DF 9C            [ 4] 1371 	sbc	a, h
   20E0 67            [ 4] 1372 	ld	h,a
   20E1 29            [11] 1373 	add	hl, hl
   20E2 29            [11] 1374 	add	hl, hl
   20E3 29            [11] 1375 	add	hl, hl
   20E4 29            [11] 1376 	add	hl, hl
   20E5 29            [11] 1377 	add	hl, hl
   20E6 C5            [11] 1378 	push	bc
   20E7 D5            [11] 1379 	push	de
   20E8 E5            [11] 1380 	push	hl
   20E9 CD 29 7D      [17] 1381 	call	__divsint
   20EC F1            [10] 1382 	pop	af
   20ED F1            [10] 1383 	pop	af
   20EE 55            [ 4] 1384 	ld	d,l
   20EF C1            [10] 1385 	pop	bc
   20F0 18 01         [12] 1386 	jr	00127$
   20F2                    1387 00126$:
                           1388 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   20F2 51            [ 4] 1389 	ld	d,c
   20F3                    1390 00127$:
                           1391 ;src/Renderer.c:560: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   20F3 C5            [11] 1392 	push	bc
   20F4 D5            [11] 1393 	push	de
   20F5 33            [ 6] 1394 	inc	sp
   20F6 DD 66 EA      [19] 1395 	ld	h,-22 (ix)
   20F9 DD 6E DA      [19] 1396 	ld	l,-38 (ix)
   20FC E5            [11] 1397 	push	hl
   20FD C5            [11] 1398 	push	bc
   20FE 33            [ 6] 1399 	inc	sp
   20FF CD 38 1D      [17] 1400 	call	_draw_column_to_buffer
   2102 F1            [10] 1401 	pop	af
   2103 F1            [10] 1402 	pop	af
   2104 C1            [10] 1403 	pop	bc
   2105                    1404 00129$:
                           1405 ;src/Renderer.c:562: if(!(currentCellID&CELL_WALL_MASK)){
   2105 DD 7E D8      [19] 1406 	ld	a,-40 (ix)
   2108 B7            [ 4] 1407 	or	a, a
   2109 20 32         [12] 1408 	jr	NZ,00138$
                           1409 ;src/Renderer.c:563: if(currentCellID&CELL_ENEMY_MASK){
   210B DD 7E DB      [19] 1410 	ld	a,-37 (ix)
   210E E6 0F         [ 7] 1411 	and	a, #0x0F
   2110 28 13         [12] 1412 	jr	Z,00133$
                           1413 ;src/Renderer.c:564: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   2112 79            [ 4] 1414 	ld	a,c
   2113 F5            [11] 1415 	push	af
   2114 33            [ 6] 1416 	inc	sp
   2115 DD 66 DB      [19] 1417 	ld	h,-37 (ix)
   2118 DD 6E D2      [19] 1418 	ld	l,-46 (ix)
   211B E5            [11] 1419 	push	hl
   211C C5            [11] 1420 	push	bc
   211D 33            [ 6] 1421 	inc	sp
   211E CD F2 1B      [17] 1422 	call	_draw_column_to_buffer_enemy
   2121 F1            [10] 1423 	pop	af
   2122 F1            [10] 1424 	pop	af
   2123 18 18         [12] 1425 	jr	00138$
   2125                    1426 00133$:
                           1427 ;src/Renderer.c:566: else if(currentCellID&CELL_ITEM_MASK){
   2125 DD 7E DB      [19] 1428 	ld	a,-37 (ix)
   2128 E6 70         [ 7] 1429 	and	a, #0x70
   212A 28 11         [12] 1430 	jr	Z,00138$
                           1431 ;src/Renderer.c:567: draw_column_to_buffer_object(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   212C 79            [ 4] 1432 	ld	a,c
   212D F5            [11] 1433 	push	af
   212E 33            [ 6] 1434 	inc	sp
   212F DD 66 DB      [19] 1435 	ld	h,-37 (ix)
   2132 DD 6E D2      [19] 1436 	ld	l,-46 (ix)
   2135 E5            [11] 1437 	push	hl
   2136 C5            [11] 1438 	push	bc
   2137 33            [ 6] 1439 	inc	sp
   2138 CD F7 1A      [17] 1440 	call	_draw_column_to_buffer_object
   213B F1            [10] 1441 	pop	af
   213C F1            [10] 1442 	pop	af
   213D                    1443 00138$:
                           1444 ;src/Renderer.c:572: ++xCellCount;
   213D DD 34 EE      [23] 1445 	inc	-18 (ix)
                           1446 ;src/Renderer.c:487: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   2140 DD 34 D3      [23] 1447 	inc	-45 (ix)
                           1448 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   2143 2A 78 1A      [16] 1449 	ld	hl,(_cells_in_view_array)
   2146 DD 75 E7      [19] 1450 	ld	-25 (ix),l
   2149 DD 74 E8      [19] 1451 	ld	-24 (ix),h
                           1452 ;src/Renderer.c:487: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   214C DD 7E D3      [19] 1453 	ld	a,-45 (ix)
   214F D6 50         [ 7] 1454 	sub	a, #0x50
   2151 DA 46 1F      [10] 1455 	jp	C,00260$
                           1456 ;src/Renderer.c:579: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   2154 DD 7E CA      [19] 1457 	ld	a,-54 (ix)
   2157 B7            [ 4] 1458 	or	a, a
   2158 28 05         [12] 1459 	jr	Z,00272$
   215A DD 4E EB      [19] 1460 	ld	c,-21 (ix)
   215D 18 02         [12] 1461 	jr	00273$
   215F                    1462 00272$:
   215F 0E 00         [ 7] 1463 	ld	c,#0x00
   2161                    1464 00273$:
   2161 DD 71 E5      [19] 1465 	ld	-27 (ix),c
                           1466 ;src/Renderer.c:580: lateralWallSlope=0;
   2164 DD 36 D8 00   [19] 1467 	ld	-40 (ix),#0x00
                           1468 ;src/Renderer.c:581: lateralWallSlopeCounter=0;
   2168 DD 36 F5 00   [19] 1469 	ld	-11 (ix),#0x00
                           1470 ;src/Renderer.c:582: xHeight=0;
   216C DD 36 EF 00   [19] 1471 	ld	-17 (ix),#0x00
                           1472 ;src/Renderer.c:584: lateralWallCounter = 0;
   2170 DD 36 D7 00   [19] 1473 	ld	-41 (ix),#0x00
                           1474 ;src/Renderer.c:585: lineEnd = lineStart + offsetDiff * 2 + 2;
   2174 DD 7E CF      [19] 1475 	ld	a,-49 (ix)
   2177 87            [ 4] 1476 	add	a, a
   2178 4F            [ 4] 1477 	ld	c,a
   2179 DD 7E C7      [19] 1478 	ld	a,-57 (ix)
   217C 81            [ 4] 1479 	add	a, c
   217D DD 77 DB      [19] 1480 	ld	-37 (ix), a
   2180 4F            [ 4] 1481 	ld	c, a
   2181 0C            [ 4] 1482 	inc	c
   2182 0C            [ 4] 1483 	inc	c
                           1484 ;src/Renderer.c:587: newCell=1;
   2183 DD 36 E3 01   [19] 1485 	ld	-29 (ix),#0x01
                           1486 ;src/Renderer.c:588: currentCellID = cells_in_view_array[lineEnd - 1];
   2187 DD 71 F1      [19] 1487 	ld	-15 (ix),c
   218A DD 36 F2 00   [19] 1488 	ld	-14 (ix),#0x00
   218E DD 5E F1      [19] 1489 	ld	e,-15 (ix)
   2191 DD 56 F2      [19] 1490 	ld	d,-14 (ix)
   2194 1B            [ 6] 1491 	dec	de
   2195 DD 6E E7      [19] 1492 	ld	l,-25 (ix)
   2198 DD 66 E8      [19] 1493 	ld	h,-24 (ix)
   219B 19            [11] 1494 	add	hl,de
   219C 7E            [ 7] 1495 	ld	a,(hl)
   219D DD 77 DC      [19] 1496 	ld	-36 (ix),a
                           1497 ;src/Renderer.c:590: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   21A0 DD 6E E7      [19] 1498 	ld	l,-25 (ix)
   21A3 DD 66 E8      [19] 1499 	ld	h,-24 (ix)
   21A6 06 00         [ 7] 1500 	ld	b,#0x00
   21A8 09            [11] 1501 	add	hl, bc
   21A9 4E            [ 7] 1502 	ld	c,(hl)
                           1503 ;src/Renderer.c:591: if(lastCellWasWall&CELL_WALL_MASK){
   21AA CB 79         [ 8] 1504 	bit	7, c
   21AC 28 09         [12] 1505 	jr	Z,00141$
                           1506 ;src/Renderer.c:592: lastWallId=lastCellWasWall;
   21AE DD 71 D9      [19] 1507 	ld	-39 (ix),c
                           1508 ;src/Renderer.c:593: lastCellWasWall=1;
   21B1 DD 36 DA 01   [19] 1509 	ld	-38 (ix),#0x01
   21B5 18 08         [12] 1510 	jr	00325$
   21B7                    1511 00141$:
                           1512 ;src/Renderer.c:596: lastCellWasWall=0;
   21B7 DD 36 DA 00   [19] 1513 	ld	-38 (ix),#0x00
                           1514 ;src/Renderer.c:597: lastWallId=CELLTYPE_FLOOR;
   21BB DD 36 D9 00   [19] 1515 	ld	-39 (ix),#0x00
                           1516 ;src/Renderer.c:600: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   21BF                    1517 00325$:
   21BF DD 36 D1 00   [19] 1518 	ld	-47 (ix),#0x00
   21C3 DD 36 D3 9F   [19] 1519 	ld	-45 (ix),#0x9F
   21C7                    1520 00262$:
                           1521 ;src/Renderer.c:603: if (xCellCount == zHeight)
   21C7 DD 7E D2      [19] 1522 	ld	a,-46 (ix)
   21CA DD 96 E5      [19] 1523 	sub	a, -27 (ix)
   21CD 20 50         [12] 1524 	jr	NZ,00144$
                           1525 ;src/Renderer.c:605: ++xCell;
   21CF DD 34 D1      [23] 1526 	inc	-47 (ix)
                           1527 ;src/Renderer.c:606: xCellCount = 0;
   21D2 DD 36 E5 00   [19] 1528 	ld	-27 (ix),#0x00
                           1529 ;src/Renderer.c:607: newCell=1;
   21D6 DD 36 E3 01   [19] 1530 	ld	-29 (ix),#0x01
                           1531 ;src/Renderer.c:608: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   21DA DD 7E D1      [19] 1532 	ld	a,-47 (ix)
   21DD DD 77 F3      [19] 1533 	ld	-13 (ix),a
   21E0 DD 36 F4 00   [19] 1534 	ld	-12 (ix),#0x00
   21E4 DD 7E F1      [19] 1535 	ld	a,-15 (ix)
   21E7 DD 96 F3      [19] 1536 	sub	a, -13 (ix)
   21EA DD 77 F3      [19] 1537 	ld	-13 (ix),a
   21ED DD 7E F2      [19] 1538 	ld	a,-14 (ix)
   21F0 DD 9E F4      [19] 1539 	sbc	a, -12 (ix)
   21F3 DD 77 F4      [19] 1540 	ld	-12 (ix),a
   21F6 DD 6E F3      [19] 1541 	ld	l,-13 (ix)
   21F9 DD 66 F4      [19] 1542 	ld	h,-12 (ix)
   21FC 2B            [ 6] 1543 	dec	hl
   21FD DD 75 F3      [19] 1544 	ld	-13 (ix),l
   2200 DD 74 F4      [19] 1545 	ld	-12 (ix),h
   2203 DD 7E E7      [19] 1546 	ld	a,-25 (ix)
   2206 DD 86 F3      [19] 1547 	add	a, -13 (ix)
   2209 DD 77 F3      [19] 1548 	ld	-13 (ix),a
   220C DD 7E E8      [19] 1549 	ld	a,-24 (ix)
   220F DD 8E F4      [19] 1550 	adc	a, -12 (ix)
   2212 DD 77 F4      [19] 1551 	ld	-12 (ix),a
   2215 DD 6E F3      [19] 1552 	ld	l,-13 (ix)
   2218 DD 66 F4      [19] 1553 	ld	h,-12 (ix)
   221B 7E            [ 7] 1554 	ld	a,(hl)
   221C DD 77 DC      [19] 1555 	ld	-36 (ix),a
   221F                    1556 00144$:
                           1557 ;src/Renderer.c:610: if(!(x%2)){
   221F DD 7E D3      [19] 1558 	ld	a,-45 (ix)
   2222 E6 01         [ 7] 1559 	and	a, #0x01
   2224 DD 77 F3      [19] 1560 	ld	-13 (ix),a
                           1561 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   2227 DD 7E DC      [19] 1562 	ld	a,-36 (ix)
   222A E6 80         [ 7] 1563 	and	a, #0x80
   222C DD 77 F9      [19] 1564 	ld	-7 (ix),a
                           1565 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   222F DD 7E E5      [19] 1566 	ld	a,-27 (ix)
   2232 DD 77 F7      [19] 1567 	ld	-9 (ix),a
   2235 DD 36 F8 00   [19] 1568 	ld	-8 (ix),#0x00
                           1569 ;src/Renderer.c:610: if(!(x%2)){
   2239 DD 7E F3      [19] 1570 	ld	a,-13 (ix)
   223C B7            [ 4] 1571 	or	a, a
   223D C2 0F 23      [10] 1572 	jp	NZ,00157$
                           1573 ;src/Renderer.c:611: if (lateralWallCounter == 0 || newCell)
   2240 DD 7E D7      [19] 1574 	ld	a,-41 (ix)
   2243 B7            [ 4] 1575 	or	a, a
   2244 28 07         [12] 1576 	jr	Z,00153$
   2246 DD 7E E3      [19] 1577 	ld	a,-29 (ix)
   2249 B7            [ 4] 1578 	or	a, a
   224A CA 0F 23      [10] 1579 	jp	Z,00157$
   224D                    1580 00153$:
                           1581 ;src/Renderer.c:613: if ( currentCellID & CELL_WALL_MASK)//Wall
   224D DD 7E F9      [19] 1582 	ld	a,-7 (ix)
   2250 B7            [ 4] 1583 	or	a, a
   2251 28 23         [12] 1584 	jr	Z,00151$
                           1585 ;src/Renderer.c:615: lateralWallCounter = 0;
   2253 DD 36 D7 00   [19] 1586 	ld	-41 (ix),#0x00
                           1587 ;src/Renderer.c:616: lateralWallSlope = 0;
   2257 DD 36 D8 00   [19] 1588 	ld	-40 (ix),#0x00
                           1589 ;src/Renderer.c:617: xHeight = zHeight;
   225B DD 7E D2      [19] 1590 	ld	a,-46 (ix)
   225E DD 77 EF      [19] 1591 	ld	-17 (ix),a
                           1592 ;src/Renderer.c:618: color = currentCellID&0b01111111;
   2261 DD 7E DC      [19] 1593 	ld	a,-36 (ix)
   2264 E6 7F         [ 7] 1594 	and	a, #0x7F
   2266 DD 77 EA      [19] 1595 	ld	-22 (ix),a
                           1596 ;src/Renderer.c:619: lastCellWasWall = 1;
   2269 DD 36 DA 01   [19] 1597 	ld	-38 (ix),#0x01
                           1598 ;src/Renderer.c:620: lastWallId=currentCellID;
   226D DD 7E DC      [19] 1599 	ld	a,-36 (ix)
   2270 DD 77 D9      [19] 1600 	ld	-39 (ix),a
   2273 C3 0B 23      [10] 1601 	jp	00152$
   2276                    1602 00151$:
                           1603 ;src/Renderer.c:622: else if(lateralWallCounter==0){
   2276 DD 7E D7      [19] 1604 	ld	a,-41 (ix)
   2279 B7            [ 4] 1605 	or	a, a
   227A C2 0B 23      [10] 1606 	jp	NZ,00152$
                           1607 ;src/Renderer.c:623: if (lastCellWasWall)
   227D DD 7E DA      [19] 1608 	ld	a,-38 (ix)
   2280 B7            [ 4] 1609 	or	a, a
   2281 28 78         [12] 1610 	jr	Z,00146$
                           1611 ;src/Renderer.c:626: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   2283 DD 7E CF      [19] 1612 	ld	a,-49 (ix)
   2286 DD 96 D1      [19] 1613 	sub	a, -47 (ix)
   2289 87            [ 4] 1614 	add	a, a
   228A 3C            [ 4] 1615 	inc	a
                           1616 ;src/Renderer.c:627: lateralWallSlopeCounter = lateralWallSlope / 2;
   228B DD 77 D8      [19] 1617 	ld	-40 (ix), a
   228E CB 3F         [ 8] 1618 	srl	a
   2290 DD 77 F5      [19] 1619 	ld	-11 (ix),a
                           1620 ;src/Renderer.c:628: lateralWallCounter = lateralWallSlope * zHeight;
   2293 DD 5E D2      [19] 1621 	ld	e,-46 (ix)
   2296 DD 66 D8      [19] 1622 	ld	h,-40 (ix)
   2299 2E 00         [ 7] 1623 	ld	l, #0x00
   229B 55            [ 4] 1624 	ld	d, l
   229C 06 08         [ 7] 1625 	ld	b, #0x08
   229E                    1626 00642$:
   229E 29            [11] 1627 	add	hl,hl
   229F 30 01         [12] 1628 	jr	NC,00643$
   22A1 19            [11] 1629 	add	hl,de
   22A2                    1630 00643$:
   22A2 10 FA         [13] 1631 	djnz	00642$
                           1632 ;src/Renderer.c:629: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   22A4 4D            [ 4] 1633 	ld	c,l
   22A5 06 00         [ 7] 1634 	ld	b,#0x00
   22A7 7D            [ 4] 1635 	ld	a,l
   22A8 E6 03         [ 7] 1636 	and	a, #0x03
   22AA 5F            [ 4] 1637 	ld	e,a
   22AB 16 00         [ 7] 1638 	ld	d,#0x00
   22AD 79            [ 4] 1639 	ld	a,c
   22AE 93            [ 4] 1640 	sub	a, e
   22AF 4F            [ 4] 1641 	ld	c,a
   22B0 78            [ 4] 1642 	ld	a,b
   22B1 9A            [ 4] 1643 	sbc	a, d
   22B2 47            [ 4] 1644 	ld	b,a
   22B3 59            [ 4] 1645 	ld	e, c
   22B4 50            [ 4] 1646 	ld	d, b
   22B5 13            [ 6] 1647 	inc	de
   22B6 6B            [ 4] 1648 	ld	l, e
   22B7 62            [ 4] 1649 	ld	h, d
   22B8 CB 7A         [ 8] 1650 	bit	7, d
   22BA 28 04         [12] 1651 	jr	Z,00274$
   22BC 21 04 00      [10] 1652 	ld	hl,#0x0004
   22BF 09            [11] 1653 	add	hl,bc
   22C0                    1654 00274$:
   22C0 CB 2C         [ 8] 1655 	sra	h
   22C2 CB 1D         [ 8] 1656 	rr	l
   22C4 CB 2C         [ 8] 1657 	sra	h
   22C6 CB 1D         [ 8] 1658 	rr	l
   22C8 DD 4E E5      [19] 1659 	ld	c,-27 (ix)
   22CB 7D            [ 4] 1660 	ld	a,l
   22CC 91            [ 4] 1661 	sub	a, c
                           1662 ;src/Renderer.c:630: lateralWallWidth=lateralWallCounter;
   22CD DD 77 D7      [19] 1663 	ld	-41 (ix), a
   22D0 DD 77 CE      [19] 1664 	ld	-50 (ix),a
                           1665 ;src/Renderer.c:631: lastCellWasWall = 0;
   22D3 DD 36 DA 00   [19] 1666 	ld	-38 (ix),#0x00
                           1667 ;src/Renderer.c:632: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   22D7 DD 6E F7      [19] 1668 	ld	l,-9 (ix)
   22DA DD 66 F8      [19] 1669 	ld	h,-8 (ix)
   22DD 29            [11] 1670 	add	hl, hl
   22DE DD 4E D8      [19] 1671 	ld	c,-40 (ix)
   22E1 06 00         [ 7] 1672 	ld	b,#0x00
   22E3 C5            [11] 1673 	push	bc
   22E4 E5            [11] 1674 	push	hl
   22E5 CD 29 7D      [17] 1675 	call	__divsint
   22E8 F1            [10] 1676 	pop	af
   22E9 F1            [10] 1677 	pop	af
   22EA DD 7E E9      [19] 1678 	ld	a,-23 (ix)
   22ED 95            [ 4] 1679 	sub	a, l
   22EE DD 77 EF      [19] 1680 	ld	-17 (ix),a
                           1681 ;src/Renderer.c:633: color = lastWallId&0b01111111;
   22F1 DD 7E D9      [19] 1682 	ld	a,-39 (ix)
   22F4 E6 7F         [ 7] 1683 	and	a, #0x7F
   22F6 DD 77 EA      [19] 1684 	ld	-22 (ix),a
   22F9 18 10         [12] 1685 	jr	00152$
   22FB                    1686 00146$:
                           1687 ;src/Renderer.c:637: xHeight = 0;
   22FB DD 36 EF 00   [19] 1688 	ld	-17 (ix),#0x00
                           1689 ;src/Renderer.c:638: lastCellWasWall = 0;
   22FF DD 36 DA 00   [19] 1690 	ld	-38 (ix),#0x00
                           1691 ;src/Renderer.c:639: lateralWallSlope=0;
   2303 DD 36 D8 00   [19] 1692 	ld	-40 (ix),#0x00
                           1693 ;src/Renderer.c:640: lastWallId=0;
   2307 DD 36 D9 00   [19] 1694 	ld	-39 (ix),#0x00
   230B                    1695 00152$:
                           1696 ;src/Renderer.c:643: newCell=0;
   230B DD 36 E3 00   [19] 1697 	ld	-29 (ix),#0x00
   230F                    1698 00157$:
                           1699 ;src/Renderer.c:648: if (lateralWallCounter > 0)
   230F DD 7E D7      [19] 1700 	ld	a,-41 (ix)
   2312 B7            [ 4] 1701 	or	a, a
   2313 28 1E         [12] 1702 	jr	Z,00163$
                           1703 ;src/Renderer.c:651: if (lateralWallSlope != 0)
   2315 DD 7E D8      [19] 1704 	ld	a,-40 (ix)
   2318 B7            [ 4] 1705 	or	a, a
   2319 28 15         [12] 1706 	jr	Z,00161$
                           1707 ;src/Renderer.c:653: if (lateralWallSlopeCounter == lateralWallSlope)
   231B DD 7E D8      [19] 1708 	ld	a,-40 (ix)
   231E DD 96 F5      [19] 1709 	sub	a, -11 (ix)
   2321 20 0A         [12] 1710 	jr	NZ,00159$
                           1711 ;src/Renderer.c:655: lateralWallSlopeCounter = 0;
   2323 DD 36 F5 00   [19] 1712 	ld	-11 (ix),#0x00
                           1713 ;src/Renderer.c:656: xHeight -= 2;
   2327 DD 35 EF      [23] 1714 	dec	-17 (ix)
   232A DD 35 EF      [23] 1715 	dec	-17 (ix)
   232D                    1716 00159$:
                           1717 ;src/Renderer.c:658: ++lateralWallSlopeCounter;
   232D DD 34 F5      [23] 1718 	inc	-11 (ix)
   2330                    1719 00161$:
                           1720 ;src/Renderer.c:660: --lateralWallCounter;
   2330 DD 35 D7      [23] 1721 	dec	-41 (ix)
   2333                    1722 00163$:
                           1723 ;src/Renderer.c:664: if (!(x%2))
   2333 DD 7E F3      [19] 1724 	ld	a,-13 (ix)
   2336 B7            [ 4] 1725 	or	a, a
   2337 C2 16 24      [10] 1726 	jp	NZ,00177$
                           1727 ;src/Renderer.c:677: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   233A DD 7E D3      [19] 1728 	ld	a,-45 (ix)
   233D CB 3F         [ 8] 1729 	srl	a
   233F DD 77 F3      [19] 1730 	ld	-13 (ix),a
                           1731 ;src/Renderer.c:674: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   2342 DD 7E EC      [19] 1732 	ld	a,-20 (ix)
   2345 DD 96 F7      [19] 1733 	sub	a, -9 (ix)
   2348 DD 77 F7      [19] 1734 	ld	-9 (ix),a
   234B DD 7E ED      [19] 1735 	ld	a,-19 (ix)
   234E DD 9E F8      [19] 1736 	sbc	a, -8 (ix)
   2351 DD 77 F8      [19] 1737 	ld	-8 (ix),a
   2354 3E 06         [ 7] 1738 	ld	a,#0x05+1
   2356 18 08         [12] 1739 	jr	00647$
   2358                    1740 00646$:
   2358 DD CB F7 26   [23] 1741 	sla	-9 (ix)
   235C DD CB F8 16   [23] 1742 	rl	-8 (ix)
   2360                    1743 00647$:
   2360 3D            [ 4] 1744 	dec	a
   2361 20 F5         [12] 1745 	jr	NZ,00646$
   2363 DD 6E EC      [19] 1746 	ld	l,-20 (ix)
   2366 DD 66 ED      [19] 1747 	ld	h,-19 (ix)
   2369 E5            [11] 1748 	push	hl
   236A DD 6E F7      [19] 1749 	ld	l,-9 (ix)
   236D DD 66 F8      [19] 1750 	ld	h,-8 (ix)
   2370 E5            [11] 1751 	push	hl
   2371 CD 29 7D      [17] 1752 	call	__divsint
   2374 F1            [10] 1753 	pop	af
   2375 F1            [10] 1754 	pop	af
   2376 DD 74 F8      [19] 1755 	ld	-8 (ix),h
   2379 DD 75 F7      [19] 1756 	ld	-9 (ix), l
   237C DD 75 F7      [19] 1757 	ld	-9 (ix), l
                           1758 ;src/Renderer.c:667: if(xHeight > 0){
   237F DD 7E EF      [19] 1759 	ld	a,-17 (ix)
   2382 B7            [ 4] 1760 	or	a, a
   2383 28 55         [12] 1761 	jr	Z,00168$
                           1762 ;src/Renderer.c:669: if (lateralWallCounter > 0)
   2385 DD 7E D7      [19] 1763 	ld	a,-41 (ix)
   2388 B7            [ 4] 1764 	or	a, a
   2389 28 39         [12] 1765 	jr	Z,00165$
                           1766 ;src/Renderer.c:671: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   238B DD 7E D7      [19] 1767 	ld	a,-41 (ix)
   238E DD 77 FA      [19] 1768 	ld	-6 (ix),a
   2391 DD 36 FB 00   [19] 1769 	ld	-5 (ix),#0x00
   2395 3E 06         [ 7] 1770 	ld	a,#0x05+1
   2397 18 08         [12] 1771 	jr	00649$
   2399                    1772 00648$:
   2399 DD CB FA 26   [23] 1773 	sla	-6 (ix)
   239D DD CB FB 16   [23] 1774 	rl	-5 (ix)
   23A1                    1775 00649$:
   23A1 3D            [ 4] 1776 	dec	a
   23A2 20 F5         [12] 1777 	jr	NZ,00648$
   23A4 DD 7E CE      [19] 1778 	ld	a,-50 (ix)
   23A7 DD 77 FC      [19] 1779 	ld	-4 (ix),a
   23AA DD 36 FD 00   [19] 1780 	ld	-3 (ix),#0x00
   23AE DD 6E FC      [19] 1781 	ld	l,-4 (ix)
   23B1 DD 66 FD      [19] 1782 	ld	h,-3 (ix)
   23B4 E5            [11] 1783 	push	hl
   23B5 DD 6E FA      [19] 1784 	ld	l,-6 (ix)
   23B8 DD 66 FB      [19] 1785 	ld	h,-5 (ix)
   23BB E5            [11] 1786 	push	hl
   23BC CD 29 7D      [17] 1787 	call	__divsint
   23BF F1            [10] 1788 	pop	af
   23C0 F1            [10] 1789 	pop	af
   23C1 45            [ 4] 1790 	ld	b,l
   23C2 18 03         [12] 1791 	jr	00166$
   23C4                    1792 00165$:
                           1793 ;src/Renderer.c:674: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   23C4 DD 46 F7      [19] 1794 	ld	b,-9 (ix)
   23C7                    1795 00166$:
                           1796 ;src/Renderer.c:677: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   23C7 C5            [11] 1797 	push	bc
   23C8 33            [ 6] 1798 	inc	sp
   23C9 DD 66 EA      [19] 1799 	ld	h,-22 (ix)
   23CC DD 6E EF      [19] 1800 	ld	l,-17 (ix)
   23CF E5            [11] 1801 	push	hl
   23D0 DD 7E F3      [19] 1802 	ld	a,-13 (ix)
   23D3 F5            [11] 1803 	push	af
   23D4 33            [ 6] 1804 	inc	sp
   23D5 CD 38 1D      [17] 1805 	call	_draw_column_to_buffer
   23D8 F1            [10] 1806 	pop	af
   23D9 F1            [10] 1807 	pop	af
   23DA                    1808 00168$:
                           1809 ;src/Renderer.c:680: if(!(currentCellID&CELL_WALL_MASK)){
   23DA DD 7E F9      [19] 1810 	ld	a,-7 (ix)
   23DD B7            [ 4] 1811 	or	a, a
   23DE 20 36         [12] 1812 	jr	NZ,00177$
                           1813 ;src/Renderer.c:681: if(currentCellID&CELL_ENEMY_MASK){
   23E0 DD 7E DC      [19] 1814 	ld	a,-36 (ix)
   23E3 E6 0F         [ 7] 1815 	and	a, #0x0F
   23E5 28 15         [12] 1816 	jr	Z,00172$
                           1817 ;src/Renderer.c:682: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   23E7 DD 66 F7      [19] 1818 	ld	h,-9 (ix)
   23EA DD 6E DC      [19] 1819 	ld	l,-36 (ix)
   23ED E5            [11] 1820 	push	hl
   23EE DD 66 D2      [19] 1821 	ld	h,-46 (ix)
   23F1 DD 6E F3      [19] 1822 	ld	l,-13 (ix)
   23F4 E5            [11] 1823 	push	hl
   23F5 CD F2 1B      [17] 1824 	call	_draw_column_to_buffer_enemy
   23F8 F1            [10] 1825 	pop	af
   23F9 F1            [10] 1826 	pop	af
   23FA 18 1A         [12] 1827 	jr	00177$
   23FC                    1828 00172$:
                           1829 ;src/Renderer.c:684: else if(currentCellID&CELL_ITEM_MASK){
   23FC DD 7E DC      [19] 1830 	ld	a,-36 (ix)
   23FF E6 70         [ 7] 1831 	and	a, #0x70
   2401 28 13         [12] 1832 	jr	Z,00177$
                           1833 ;src/Renderer.c:685: draw_column_to_buffer_object(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   2403 DD 66 F7      [19] 1834 	ld	h,-9 (ix)
   2406 DD 6E DC      [19] 1835 	ld	l,-36 (ix)
   2409 E5            [11] 1836 	push	hl
   240A DD 66 D2      [19] 1837 	ld	h,-46 (ix)
   240D DD 6E F3      [19] 1838 	ld	l,-13 (ix)
   2410 E5            [11] 1839 	push	hl
   2411 CD F7 1A      [17] 1840 	call	_draw_column_to_buffer_object
   2414 F1            [10] 1841 	pop	af
   2415 F1            [10] 1842 	pop	af
   2416                    1843 00177$:
                           1844 ;src/Renderer.c:689: ++xCellCount;
   2416 DD 34 E5      [23] 1845 	inc	-27 (ix)
                           1846 ;src/Renderer.c:600: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   2419 DD 35 D3      [23] 1847 	dec	-45 (ix)
                           1848 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   241C 2A 78 1A      [16] 1849 	ld	hl,(_cells_in_view_array)
   241F DD 75 E7      [19] 1850 	ld	-25 (ix),l
   2422 DD 74 E8      [19] 1851 	ld	-24 (ix),h
                           1852 ;src/Renderer.c:600: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   2425 DD 7E D3      [19] 1853 	ld	a,-45 (ix)
   2428 D6 50         [ 7] 1854 	sub	a, #0x50
   242A D2 C7 21      [10] 1855 	jp	NC,00262$
                           1856 ;src/Renderer.c:720: lineStart = lineStart + (offsetDiff * 2) + 3;
   242D DD 7E DB      [19] 1857 	ld	a,-37 (ix)
   2430 C6 03         [ 7] 1858 	add	a, #0x03
   2432 DD 77 C7      [19] 1859 	ld	-57 (ix),a
                           1860 ;src/Renderer.c:721: zHeight += zHeight;
   2435 DD CB D2 26   [23] 1861 	sla	-46 (ix)
                           1862 ;src/Renderer.c:722: offsetDiff = offsetDiff >> 1;
   2439 DD CB CF 3E   [23] 1863 	srl	-49 (ix)
                           1864 ;src/Renderer.c:724: }while(z);
   243D DD 7E CA      [19] 1865 	ld	a,-54 (ix)
   2440 B7            [ 4] 1866 	or	a, a
   2441 C2 D0 1E      [10] 1867 	jp	NZ,00179$
   2444 C3 2A 2A      [10] 1868 	jp	00268$
                           1869 ;src/Renderer.c:729: do{
   2447                    1870 00370$:
   2447 DD 36 CA 06   [19] 1871 	ld	-54 (ix),#0x06
   244B                    1872 00254$:
                           1873 ;src/Renderer.c:731: --z;
   244B DD 35 CA      [23] 1874 	dec	-54 (ix)
                           1875 ;src/Renderer.c:466: xCellCount = (z) ? (zHeight >> 1) : 0;
   244E DD 7E D2      [19] 1876 	ld	a,-46 (ix)
   2451 CB 3F         [ 8] 1877 	srl	a
   2453 DD 77 FC      [19] 1878 	ld	-4 (ix),a
                           1879 ;src/Renderer.c:735: xCellCount = (z) ? (zHeight >> 1) : 0;
   2456 DD 7E CA      [19] 1880 	ld	a,-54 (ix)
   2459 B7            [ 4] 1881 	or	a, a
   245A 28 05         [12] 1882 	jr	Z,00275$
   245C DD 4E FC      [19] 1883 	ld	c,-4 (ix)
   245F 18 02         [12] 1884 	jr	00276$
   2461                    1885 00275$:
   2461 0E 00         [ 7] 1886 	ld	c,#0x00
   2463                    1887 00276$:
   2463 DD 71 CB      [19] 1888 	ld	-53 (ix),c
                           1889 ;src/Renderer.c:736: lateralWallSlope=0;
   2466 DD 36 CC 00   [19] 1890 	ld	-52 (ix),#0x00
                           1891 ;src/Renderer.c:737: lateralWallSlopeCounter=0;
   246A DD 36 D0 00   [19] 1892 	ld	-48 (ix),#0x00
                           1893 ;src/Renderer.c:738: xHeight=0;
   246E DD 36 C9 00   [19] 1894 	ld	-55 (ix),#0x00
                           1895 ;src/Renderer.c:740: lateralWallCounter = 0;
   2472 DD 36 FA 00   [19] 1896 	ld	-6 (ix),#0x00
                           1897 ;src/Renderer.c:742: newCell=1;
   2476 DD 36 D5 01   [19] 1898 	ld	-43 (ix),#0x01
                           1899 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   247A DD 7E C7      [19] 1900 	ld	a,-57 (ix)
   247D DD 77 F7      [19] 1901 	ld	-9 (ix),a
   2480 DD 36 F8 00   [19] 1902 	ld	-8 (ix),#0x00
                           1903 ;src/Renderer.c:743: currentCellID = cells_in_view_array[lineStart + 1];
   2484 DD 4E F7      [19] 1904 	ld	c,-9 (ix)
   2487 DD 46 F8      [19] 1905 	ld	b,-8 (ix)
   248A 03            [ 6] 1906 	inc	bc
   248B DD 6E E7      [19] 1907 	ld	l,-25 (ix)
   248E DD 66 E8      [19] 1908 	ld	h,-24 (ix)
   2491 09            [11] 1909 	add	hl,bc
   2492 7E            [ 7] 1910 	ld	a,(hl)
   2493 DD 77 D4      [19] 1911 	ld	-44 (ix),a
                           1912 ;src/Renderer.c:745: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   2496 DD 7E E7      [19] 1913 	ld	a,-25 (ix)
   2499 DD 86 C7      [19] 1914 	add	a, -57 (ix)
   249C 6F            [ 4] 1915 	ld	l,a
   249D DD 7E E8      [19] 1916 	ld	a,-24 (ix)
   24A0 CE 00         [ 7] 1917 	adc	a, #0x00
   24A2 67            [ 4] 1918 	ld	h,a
   24A3 4E            [ 7] 1919 	ld	c,(hl)
                           1920 ;src/Renderer.c:746: if(lastCellWasWall&CELL_WALL_MASK){
   24A4 CB 79         [ 8] 1921 	bit	7, c
   24A6 28 09         [12] 1922 	jr	Z,00183$
                           1923 ;src/Renderer.c:747: lastWallId=lastCellWasWall;
   24A8 DD 71 D6      [19] 1924 	ld	-42 (ix),c
                           1925 ;src/Renderer.c:748: lastCellWasWall=1;
   24AB DD 36 F3 01   [19] 1926 	ld	-13 (ix),#0x01
   24AF 18 08         [12] 1927 	jr	00347$
   24B1                    1928 00183$:
                           1929 ;src/Renderer.c:751: lastCellWasWall=0;
   24B1 DD 36 F3 00   [19] 1930 	ld	-13 (ix),#0x00
                           1931 ;src/Renderer.c:752: lastWallId=CELLTYPE_FLOOR;
   24B5 DD 36 D6 00   [19] 1932 	ld	-42 (ix),#0x00
                           1933 ;src/Renderer.c:755: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   24B9                    1934 00347$:
   24B9 DD 36 D1 00   [19] 1935 	ld	-47 (ix),#0x00
   24BD DD 36 D3 00   [19] 1936 	ld	-45 (ix),#0x00
   24C1                    1937 00264$:
                           1938 ;src/Renderer.c:757: if (xCellCount == zHeight)
   24C1 DD 7E CB      [19] 1939 	ld	a,-53 (ix)
   24C4 DD 96 D2      [19] 1940 	sub	a, -46 (ix)
   24C7 20 4B         [12] 1941 	jr	NZ,00186$
                           1942 ;src/Renderer.c:759: ++xCell;
   24C9 DD 34 D1      [23] 1943 	inc	-47 (ix)
                           1944 ;src/Renderer.c:760: xCellCount = 0;
   24CC DD 36 CB 00   [19] 1945 	ld	-53 (ix),#0x00
                           1946 ;src/Renderer.c:761: newCell=1;
   24D0 DD 36 D5 01   [19] 1947 	ld	-43 (ix),#0x01
                           1948 ;src/Renderer.c:762: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   24D4 DD 7E D1      [19] 1949 	ld	a,-47 (ix)
   24D7 DD 77 F1      [19] 1950 	ld	-15 (ix),a
   24DA DD 36 F2 00   [19] 1951 	ld	-14 (ix),#0x00
   24DE DD 7E F7      [19] 1952 	ld	a,-9 (ix)
   24E1 DD 86 F1      [19] 1953 	add	a, -15 (ix)
   24E4 DD 77 F1      [19] 1954 	ld	-15 (ix),a
   24E7 DD 7E F8      [19] 1955 	ld	a,-8 (ix)
   24EA DD 8E F2      [19] 1956 	adc	a, -14 (ix)
   24ED DD 77 F2      [19] 1957 	ld	-14 (ix),a
   24F0 DD 34 F1      [23] 1958 	inc	-15 (ix)
   24F3 20 03         [12] 1959 	jr	NZ,00655$
   24F5 DD 34 F2      [23] 1960 	inc	-14 (ix)
   24F8                    1961 00655$:
   24F8 DD 7E F1      [19] 1962 	ld	a,-15 (ix)
   24FB DD 86 E7      [19] 1963 	add	a, -25 (ix)
   24FE DD 77 F1      [19] 1964 	ld	-15 (ix),a
   2501 DD 7E F2      [19] 1965 	ld	a,-14 (ix)
   2504 DD 8E E8      [19] 1966 	adc	a, -24 (ix)
   2507 DD 77 F2      [19] 1967 	ld	-14 (ix),a
   250A DD 6E F1      [19] 1968 	ld	l,-15 (ix)
   250D DD 66 F2      [19] 1969 	ld	h,-14 (ix)
   2510 7E            [ 7] 1970 	ld	a,(hl)
   2511 DD 77 D4      [19] 1971 	ld	-44 (ix),a
   2514                    1972 00186$:
                           1973 ;src/Renderer.c:764: if(!(x%2)){
   2514 DD 7E D3      [19] 1974 	ld	a,-45 (ix)
   2517 E6 01         [ 7] 1975 	and	a, #0x01
   2519 DD 77 F1      [19] 1976 	ld	-15 (ix),a
                           1977 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   251C DD 7E D4      [19] 1978 	ld	a,-44 (ix)
   251F E6 80         [ 7] 1979 	and	a, #0x80
   2521 DD 77 EC      [19] 1980 	ld	-20 (ix),a
                           1981 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   2524 DD 7E CB      [19] 1982 	ld	a,-53 (ix)
   2527 DD 77 E5      [19] 1983 	ld	-27 (ix),a
   252A DD 36 E6 00   [19] 1984 	ld	-26 (ix),#0x00
   252E DD 7E D2      [19] 1985 	ld	a,-46 (ix)
   2531 DD 77 EA      [19] 1986 	ld	-22 (ix),a
                           1987 ;src/Renderer.c:764: if(!(x%2)){
   2534 DD 7E F1      [19] 1988 	ld	a,-15 (ix)
   2537 B7            [ 4] 1989 	or	a, a
   2538 C2 30 26      [10] 1990 	jp	NZ,00199$
                           1991 ;src/Renderer.c:765: if ((lateralWallCounter == 0)||newCell)
   253B DD 7E FA      [19] 1992 	ld	a,-6 (ix)
   253E B7            [ 4] 1993 	or	a, a
   253F 28 07         [12] 1994 	jr	Z,00195$
   2541 DD 7E D5      [19] 1995 	ld	a,-43 (ix)
   2544 B7            [ 4] 1996 	or	a, a
   2545 CA 30 26      [10] 1997 	jp	Z,00199$
   2548                    1998 00195$:
                           1999 ;src/Renderer.c:767: if (currentCellID & CELL_WALL_MASK)//Wall
   2548 DD 7E EC      [19] 2000 	ld	a,-20 (ix)
   254B B7            [ 4] 2001 	or	a, a
   254C 28 2B         [12] 2002 	jr	Z,00193$
                           2003 ;src/Renderer.c:769: lateralWallCounter = 0;//(zHeight - xCellCount);
   254E DD 36 FA 00   [19] 2004 	ld	-6 (ix),#0x00
                           2005 ;src/Renderer.c:770: lateralWallSlope = 0;
   2552 DD 36 CC 00   [19] 2006 	ld	-52 (ix),#0x00
                           2007 ;src/Renderer.c:771: xHeight = zHeight;
   2556 DD 7E D2      [19] 2008 	ld	a,-46 (ix)
   2559 DD 77 C9      [19] 2009 	ld	-55 (ix),a
                           2010 ;src/Renderer.c:772: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   255C DD 7E D4      [19] 2011 	ld	a,-44 (ix)
   255F D6 80         [ 7] 2012 	sub	a, #0x80
   2561 20 04         [12] 2013 	jr	NZ,00277$
   2563 0E 09         [ 7] 2014 	ld	c,#0x09
   2565 18 02         [12] 2015 	jr	00278$
   2567                    2016 00277$:
   2567 0E 0B         [ 7] 2017 	ld	c,#0x0B
   2569                    2018 00278$:
   2569 DD 71 C6      [19] 2019 	ld	-58 (ix),c
                           2020 ;src/Renderer.c:773: lastCellWasWall = 1;
   256C DD 36 F3 01   [19] 2021 	ld	-13 (ix),#0x01
                           2022 ;src/Renderer.c:774: lastWallId=currentCellID;
   2570 DD 7E D4      [19] 2023 	ld	a,-44 (ix)
   2573 DD 77 D6      [19] 2024 	ld	-42 (ix),a
   2576 C3 2C 26      [10] 2025 	jp	00194$
   2579                    2026 00193$:
                           2027 ;src/Renderer.c:777: if(lateralWallCounter==0){//Lateral wall not finished
   2579 DD 7E FA      [19] 2028 	ld	a,-6 (ix)
   257C B7            [ 4] 2029 	or	a, a
   257D C2 2C 26      [10] 2030 	jp	NZ,00194$
                           2031 ;src/Renderer.c:778: if (lastCellWasWall)
   2580 DD 7E F3      [19] 2032 	ld	a,-13 (ix)
   2583 B7            [ 4] 2033 	or	a, a
   2584 CA 1C 26      [10] 2034 	jp	Z,00188$
                           2035 ;src/Renderer.c:781: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   2587 DD 7E CF      [19] 2036 	ld	a,-49 (ix)
   258A DD 96 D1      [19] 2037 	sub	a, -47 (ix)
   258D 87            [ 4] 2038 	add	a, a
   258E 3C            [ 4] 2039 	inc	a
                           2040 ;src/Renderer.c:782: lateralWallSlopeCounter = lateralWallSlope / 2;
   258F DD 77 CC      [19] 2041 	ld	-52 (ix), a
   2592 CB 3F         [ 8] 2042 	srl	a
   2594 DD 77 D0      [19] 2043 	ld	-48 (ix),a
                           2044 ;src/Renderer.c:783: lateralWallCounter = lateralWallSlope * zHeight;
   2597 DD 5E D2      [19] 2045 	ld	e,-46 (ix)
   259A DD 66 CC      [19] 2046 	ld	h,-52 (ix)
   259D 2E 00         [ 7] 2047 	ld	l, #0x00
   259F 55            [ 4] 2048 	ld	d, l
   25A0 06 08         [ 7] 2049 	ld	b, #0x08
   25A2                    2050 00658$:
   25A2 29            [11] 2051 	add	hl,hl
   25A3 30 01         [12] 2052 	jr	NC,00659$
   25A5 19            [11] 2053 	add	hl,de
   25A6                    2054 00659$:
   25A6 10 FA         [13] 2055 	djnz	00658$
   25A8 DD 75 E9      [19] 2056 	ld	-23 (ix), l
   25AB 7D            [ 4] 2057 	ld	a, l
                           2058 ;src/Renderer.c:784: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   25AC DD 77 CD      [19] 2059 	ld	-51 (ix), a
   25AF E6 FC         [ 7] 2060 	and	a, #0xFC
   25B1 DD 77 E9      [19] 2061 	ld	-23 (ix), a
   25B4 CB C7         [ 8] 2062 	set	0, a
   25B6 DD 77 E9      [19] 2063 	ld	-23 (ix), a
   25B9 CB 3F         [ 8] 2064 	srl	a
   25BB CB 3F         [ 8] 2065 	srl	a
   25BD DD 96 CB      [19] 2066 	sub	a, -53 (ix)
   25C0 DD 77 FA      [19] 2067 	ld	-6 (ix),a
                           2068 ;src/Renderer.c:786: lastCellWasWall = 0;
   25C3 DD 36 F3 00   [19] 2069 	ld	-13 (ix),#0x00
                           2070 ;src/Renderer.c:787: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   25C7 DD 7E E5      [19] 2071 	ld	a,-27 (ix)
   25CA DD 77 F5      [19] 2072 	ld	-11 (ix),a
   25CD DD 7E E6      [19] 2073 	ld	a,-26 (ix)
   25D0 DD 77 F6      [19] 2074 	ld	-10 (ix),a
   25D3 DD CB F5 26   [23] 2075 	sla	-11 (ix)
   25D7 DD CB F6 16   [23] 2076 	rl	-10 (ix)
   25DB DD 7E CC      [19] 2077 	ld	a,-52 (ix)
   25DE DD 77 E3      [19] 2078 	ld	-29 (ix),a
   25E1 DD 36 E4 00   [19] 2079 	ld	-28 (ix),#0x00
   25E5 DD 6E E3      [19] 2080 	ld	l,-29 (ix)
   25E8 DD 66 E4      [19] 2081 	ld	h,-28 (ix)
   25EB E5            [11] 2082 	push	hl
   25EC DD 6E F5      [19] 2083 	ld	l,-11 (ix)
   25EF DD 66 F6      [19] 2084 	ld	h,-10 (ix)
   25F2 E5            [11] 2085 	push	hl
   25F3 CD 29 7D      [17] 2086 	call	__divsint
   25F6 F1            [10] 2087 	pop	af
   25F7 F1            [10] 2088 	pop	af
   25F8 DD 74 F6      [19] 2089 	ld	-10 (ix),h
   25FB DD 75 F5      [19] 2090 	ld	-11 (ix), l
   25FE DD 75 E9      [19] 2091 	ld	-23 (ix), l
   2601 DD 7E EA      [19] 2092 	ld	a,-22 (ix)
   2604 DD 96 E9      [19] 2093 	sub	a, -23 (ix)
   2607 DD 77 C9      [19] 2094 	ld	-55 (ix),a
                           2095 ;src/Renderer.c:788: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   260A DD 7E D6      [19] 2096 	ld	a,-42 (ix)
   260D D6 80         [ 7] 2097 	sub	a, #0x80
   260F 20 04         [12] 2098 	jr	NZ,00279$
   2611 0E 0A         [ 7] 2099 	ld	c,#0x0A
   2613 18 02         [12] 2100 	jr	00280$
   2615                    2101 00279$:
   2615 0E 0C         [ 7] 2102 	ld	c,#0x0C
   2617                    2103 00280$:
   2617 DD 71 C6      [19] 2104 	ld	-58 (ix),c
   261A 18 10         [12] 2105 	jr	00194$
   261C                    2106 00188$:
                           2107 ;src/Renderer.c:792: xHeight = 0;
   261C DD 36 C9 00   [19] 2108 	ld	-55 (ix),#0x00
                           2109 ;src/Renderer.c:793: lastCellWasWall = 0;
   2620 DD 36 F3 00   [19] 2110 	ld	-13 (ix),#0x00
                           2111 ;src/Renderer.c:794: lateralWallSlope=0;
   2624 DD 36 CC 00   [19] 2112 	ld	-52 (ix),#0x00
                           2113 ;src/Renderer.c:795: lastWallId=0;
   2628 DD 36 D6 00   [19] 2114 	ld	-42 (ix),#0x00
   262C                    2115 00194$:
                           2116 ;src/Renderer.c:799: newCell=0;
   262C DD 36 D5 00   [19] 2117 	ld	-43 (ix),#0x00
   2630                    2118 00199$:
                           2119 ;src/Renderer.c:802: if (lateralWallCounter > 0)
   2630 DD 7E FA      [19] 2120 	ld	a,-6 (ix)
   2633 B7            [ 4] 2121 	or	a, a
   2634 28 1E         [12] 2122 	jr	Z,00205$
                           2123 ;src/Renderer.c:805: if (lateralWallSlope != 0)
   2636 DD 7E CC      [19] 2124 	ld	a,-52 (ix)
   2639 B7            [ 4] 2125 	or	a, a
   263A 28 15         [12] 2126 	jr	Z,00203$
                           2127 ;src/Renderer.c:807: if (lateralWallSlopeCounter == lateralWallSlope)
   263C DD 7E CC      [19] 2128 	ld	a,-52 (ix)
   263F DD 96 D0      [19] 2129 	sub	a, -48 (ix)
   2642 20 0A         [12] 2130 	jr	NZ,00201$
                           2131 ;src/Renderer.c:809: lateralWallSlopeCounter = 0;
   2644 DD 36 D0 00   [19] 2132 	ld	-48 (ix),#0x00
                           2133 ;src/Renderer.c:810: xHeight -= 2;
   2648 DD 35 C9      [23] 2134 	dec	-55 (ix)
   264B DD 35 C9      [23] 2135 	dec	-55 (ix)
   264E                    2136 00201$:
                           2137 ;src/Renderer.c:812: ++lateralWallSlopeCounter;
   264E DD 34 D0      [23] 2138 	inc	-48 (ix)
   2651                    2139 00203$:
                           2140 ;src/Renderer.c:815: --lateralWallCounter;
   2651 DD 35 FA      [23] 2141 	dec	-6 (ix)
   2654                    2142 00205$:
                           2143 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   2654 DD 7E D2      [19] 2144 	ld	a,-46 (ix)
   2657 DD 77 F5      [19] 2145 	ld	-11 (ix),a
   265A DD 36 F6 00   [19] 2146 	ld	-10 (ix),#0x00
                           2147 ;src/Renderer.c:818: if (!(x%2))
   265E DD 7E F1      [19] 2148 	ld	a,-15 (ix)
   2661 B7            [ 4] 2149 	or	a, a
   2662 C2 F5 26      [10] 2150 	jp	NZ,00216$
                           2151 ;src/Renderer.c:821: draw_column_to_buffer_untextured(x/2, xHeight, color);
   2665 DD 7E D3      [19] 2152 	ld	a,-45 (ix)
   2668 CB 3F         [ 8] 2153 	srl	a
   266A DD 77 F1      [19] 2154 	ld	-15 (ix),a
                           2155 ;src/Renderer.c:820: if(xHeight > 0){
   266D DD 7E C9      [19] 2156 	ld	a,-55 (ix)
   2670 B7            [ 4] 2157 	or	a, a
   2671 28 11         [12] 2158 	jr	Z,00207$
                           2159 ;src/Renderer.c:821: draw_column_to_buffer_untextured(x/2, xHeight, color);
   2673 DD 66 C6      [19] 2160 	ld	h,-58 (ix)
   2676 DD 6E C9      [19] 2161 	ld	l,-55 (ix)
   2679 E5            [11] 2162 	push	hl
   267A DD 7E F1      [19] 2163 	ld	a,-15 (ix)
   267D F5            [11] 2164 	push	af
   267E 33            [ 6] 2165 	inc	sp
   267F CD 7F 1A      [17] 2166 	call	_draw_column_to_buffer_untextured
   2682 F1            [10] 2167 	pop	af
   2683 33            [ 6] 2168 	inc	sp
   2684                    2169 00207$:
                           2170 ;src/Renderer.c:824: if(!(currentCellID&CELL_WALL_MASK)){
   2684 DD 7E EC      [19] 2171 	ld	a,-20 (ix)
   2687 B7            [ 4] 2172 	or	a, a
   2688 20 6B         [12] 2173 	jr	NZ,00216$
                           2174 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   268A DD 7E E5      [19] 2175 	ld	a,-27 (ix)
   268D DD 77 EC      [19] 2176 	ld	-20 (ix),a
   2690 DD 7E E6      [19] 2177 	ld	a,-26 (ix)
   2693 DD 77 ED      [19] 2178 	ld	-19 (ix),a
   2696 3E 06         [ 7] 2179 	ld	a,#0x05+1
   2698 18 08         [12] 2180 	jr	00667$
   269A                    2181 00666$:
   269A DD CB EC 26   [23] 2182 	sla	-20 (ix)
   269E DD CB ED 16   [23] 2183 	rl	-19 (ix)
   26A2                    2184 00667$:
   26A2 3D            [ 4] 2185 	dec	a
   26A3 20 F5         [12] 2186 	jr	NZ,00666$
   26A5 DD 6E F5      [19] 2187 	ld	l,-11 (ix)
   26A8 DD 66 F6      [19] 2188 	ld	h,-10 (ix)
   26AB E5            [11] 2189 	push	hl
   26AC DD 6E EC      [19] 2190 	ld	l,-20 (ix)
   26AF DD 66 ED      [19] 2191 	ld	h,-19 (ix)
   26B2 E5            [11] 2192 	push	hl
   26B3 CD 29 7D      [17] 2193 	call	__divsint
   26B6 F1            [10] 2194 	pop	af
   26B7 F1            [10] 2195 	pop	af
   26B8 DD 74 ED      [19] 2196 	ld	-19 (ix),h
   26BB DD 75 EC      [19] 2197 	ld	-20 (ix), l
   26BE 45            [ 4] 2198 	ld	b, l
                           2199 ;src/Renderer.c:825: if(currentCellID&CELL_ENEMY_MASK){
   26BF DD 7E D4      [19] 2200 	ld	a,-44 (ix)
   26C2 E6 0F         [ 7] 2201 	and	a, #0x0F
   26C4 28 15         [12] 2202 	jr	Z,00211$
                           2203 ;src/Renderer.c:826: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   26C6 C5            [11] 2204 	push	bc
   26C7 33            [ 6] 2205 	inc	sp
   26C8 DD 66 D4      [19] 2206 	ld	h,-44 (ix)
   26CB DD 6E D2      [19] 2207 	ld	l,-46 (ix)
   26CE E5            [11] 2208 	push	hl
   26CF DD 7E F1      [19] 2209 	ld	a,-15 (ix)
   26D2 F5            [11] 2210 	push	af
   26D3 33            [ 6] 2211 	inc	sp
   26D4 CD F2 1B      [17] 2212 	call	_draw_column_to_buffer_enemy
   26D7 F1            [10] 2213 	pop	af
   26D8 F1            [10] 2214 	pop	af
   26D9 18 1A         [12] 2215 	jr	00216$
   26DB                    2216 00211$:
                           2217 ;src/Renderer.c:828: else if(currentCellID&CELL_ITEM_MASK){
   26DB DD 7E D4      [19] 2218 	ld	a,-44 (ix)
   26DE E6 70         [ 7] 2219 	and	a, #0x70
   26E0 28 13         [12] 2220 	jr	Z,00216$
                           2221 ;src/Renderer.c:829: draw_column_to_buffer_object(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   26E2 C5            [11] 2222 	push	bc
   26E3 33            [ 6] 2223 	inc	sp
   26E4 DD 66 D4      [19] 2224 	ld	h,-44 (ix)
   26E7 DD 6E D2      [19] 2225 	ld	l,-46 (ix)
   26EA E5            [11] 2226 	push	hl
   26EB DD 7E F1      [19] 2227 	ld	a,-15 (ix)
   26EE F5            [11] 2228 	push	af
   26EF 33            [ 6] 2229 	inc	sp
   26F0 CD F7 1A      [17] 2230 	call	_draw_column_to_buffer_object
   26F3 F1            [10] 2231 	pop	af
   26F4 F1            [10] 2232 	pop	af
   26F5                    2233 00216$:
                           2234 ;src/Renderer.c:834: ++xCellCount;
   26F5 DD 34 CB      [23] 2235 	inc	-53 (ix)
                           2236 ;src/Renderer.c:755: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   26F8 DD 34 D3      [23] 2237 	inc	-45 (ix)
                           2238 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   26FB 2A 78 1A      [16] 2239 	ld	hl,(_cells_in_view_array)
   26FE DD 75 E7      [19] 2240 	ld	-25 (ix),l
   2701 DD 74 E8      [19] 2241 	ld	-24 (ix),h
                           2242 ;src/Renderer.c:755: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   2704 DD 7E D3      [19] 2243 	ld	a,-45 (ix)
   2707 D6 50         [ 7] 2244 	sub	a, #0x50
   2709 DA C1 24      [10] 2245 	jp	C,00264$
                           2246 ;src/Renderer.c:841: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   270C DD 7E CA      [19] 2247 	ld	a,-54 (ix)
   270F B7            [ 4] 2248 	or	a, a
   2710 28 08         [12] 2249 	jr	Z,00281$
   2712 DD 7E FC      [19] 2250 	ld	a,-4 (ix)
   2715 DD 77 FC      [19] 2251 	ld	-4 (ix),a
   2718 18 04         [12] 2252 	jr	00282$
   271A                    2253 00281$:
   271A DD 36 FC 00   [19] 2254 	ld	-4 (ix),#0x00
   271E                    2255 00282$:
   271E DD 7E FC      [19] 2256 	ld	a,-4 (ix)
   2721 DD 77 FC      [19] 2257 	ld	-4 (ix),a
                           2258 ;src/Renderer.c:842: lateralWallSlope=0;
   2724 DD 36 FA 00   [19] 2259 	ld	-6 (ix),#0x00
                           2260 ;src/Renderer.c:843: lateralWallSlopeCounter=0;
   2728 DD 36 F7 00   [19] 2261 	ld	-9 (ix),#0x00
                           2262 ;src/Renderer.c:844: xHeight=0;
   272C DD 36 F3 00   [19] 2263 	ld	-13 (ix),#0x00
                           2264 ;src/Renderer.c:846: lateralWallCounter = 0;
   2730 DD 36 F1 00   [19] 2265 	ld	-15 (ix),#0x00
                           2266 ;src/Renderer.c:585: lineEnd = lineStart + offsetDiff * 2 + 2;
   2734 DD 7E CF      [19] 2267 	ld	a,-49 (ix)
   2737 87            [ 4] 2268 	add	a, a
   2738 DD 77 EC      [19] 2269 	ld	-20 (ix),a
   273B DD 7E C7      [19] 2270 	ld	a,-57 (ix)
   273E DD 86 EC      [19] 2271 	add	a, -20 (ix)
                           2272 ;src/Renderer.c:847: lineEnd = lineStart + offsetDiff * 2 + 2;
   2741 DD 77 EC      [19] 2273 	ld	-20 (ix), a
   2744 C6 02         [ 7] 2274 	add	a, #0x02
   2746 DD 77 C8      [19] 2275 	ld	-56 (ix),a
                           2276 ;src/Renderer.c:849: newCell=1;
   2749 DD 36 E9 01   [19] 2277 	ld	-23 (ix),#0x01
                           2278 ;src/Renderer.c:588: currentCellID = cells_in_view_array[lineEnd - 1];
   274D DD 7E C8      [19] 2279 	ld	a,-56 (ix)
   2750 DD 77 E5      [19] 2280 	ld	-27 (ix),a
   2753 DD 36 E6 00   [19] 2281 	ld	-26 (ix),#0x00
                           2282 ;src/Renderer.c:850: currentCellID = cells_in_view_array[lineEnd - 1];
   2757 DD 7E E5      [19] 2283 	ld	a,-27 (ix)
   275A C6 FF         [ 7] 2284 	add	a,#0xFF
   275C DD 77 E3      [19] 2285 	ld	-29 (ix),a
   275F DD 7E E6      [19] 2286 	ld	a,-26 (ix)
   2762 CE FF         [ 7] 2287 	adc	a,#0xFF
   2764 DD 77 E4      [19] 2288 	ld	-28 (ix),a
   2767 DD 7E E7      [19] 2289 	ld	a,-25 (ix)
   276A DD 86 E3      [19] 2290 	add	a, -29 (ix)
   276D DD 77 E3      [19] 2291 	ld	-29 (ix),a
   2770 DD 7E E8      [19] 2292 	ld	a,-24 (ix)
   2773 DD 8E E4      [19] 2293 	adc	a, -28 (ix)
   2776 DD 77 E4      [19] 2294 	ld	-28 (ix),a
   2779 DD 6E E3      [19] 2295 	ld	l,-29 (ix)
   277C DD 66 E4      [19] 2296 	ld	h,-28 (ix)
   277F 7E            [ 7] 2297 	ld	a,(hl)
   2780 DD 77 D8      [19] 2298 	ld	-40 (ix),a
                           2299 ;src/Renderer.c:852: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   2783 DD 7E E7      [19] 2300 	ld	a,-25 (ix)
   2786 DD 86 C8      [19] 2301 	add	a, -56 (ix)
   2789 DD 77 E3      [19] 2302 	ld	-29 (ix),a
   278C DD 7E E8      [19] 2303 	ld	a,-24 (ix)
   278F CE 00         [ 7] 2304 	adc	a, #0x00
   2791 DD 77 E4      [19] 2305 	ld	-28 (ix),a
   2794 DD 6E E3      [19] 2306 	ld	l,-29 (ix)
   2797 DD 66 E4      [19] 2307 	ld	h,-28 (ix)
   279A 7E            [ 7] 2308 	ld	a,(hl)
   279B DD 77 EF      [19] 2309 	ld	-17 (ix),a
                           2310 ;src/Renderer.c:853: if(lastCellWasWall&CELL_WALL_MASK){
   279E DD CB EF 7E   [20] 2311 	bit	7, -17 (ix)
   27A2 28 06         [12] 2312 	jr	Z,00219$
                           2313 ;src/Renderer.c:854: lastWallId=lastCellWasWall;
                           2314 ;src/Renderer.c:855: lastCellWasWall=1;
   27A4 DD 36 D7 01   [19] 2315 	ld	-41 (ix),#0x01
   27A8 18 08         [12] 2316 	jr	00368$
   27AA                    2317 00219$:
                           2318 ;src/Renderer.c:858: lastCellWasWall=0;
   27AA DD 36 D7 00   [19] 2319 	ld	-41 (ix),#0x00
                           2320 ;src/Renderer.c:859: lastWallId=CELLTYPE_FLOOR;
   27AE DD 36 EF 00   [19] 2321 	ld	-17 (ix),#0x00
                           2322 ;src/Renderer.c:862: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   27B2                    2323 00368$:
   27B2 DD 36 D1 00   [19] 2324 	ld	-47 (ix),#0x00
   27B6 DD 36 D3 9F   [19] 2325 	ld	-45 (ix),#0x9F
   27BA                    2326 00266$:
                           2327 ;src/Renderer.c:865: if (xCellCount == zHeight)
   27BA DD 7E D2      [19] 2328 	ld	a,-46 (ix)
   27BD DD 96 FC      [19] 2329 	sub	a, -4 (ix)
   27C0 20 50         [12] 2330 	jr	NZ,00222$
                           2331 ;src/Renderer.c:867: ++xCell;
   27C2 DD 34 D1      [23] 2332 	inc	-47 (ix)
                           2333 ;src/Renderer.c:868: xCellCount = 0;
   27C5 DD 36 FC 00   [19] 2334 	ld	-4 (ix),#0x00
                           2335 ;src/Renderer.c:869: newCell=1;
   27C9 DD 36 E9 01   [19] 2336 	ld	-23 (ix),#0x01
                           2337 ;src/Renderer.c:870: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   27CD DD 7E D1      [19] 2338 	ld	a,-47 (ix)
   27D0 DD 77 E3      [19] 2339 	ld	-29 (ix),a
   27D3 DD 36 E4 00   [19] 2340 	ld	-28 (ix),#0x00
   27D7 DD 7E E5      [19] 2341 	ld	a,-27 (ix)
   27DA DD 96 E3      [19] 2342 	sub	a, -29 (ix)
   27DD DD 77 E3      [19] 2343 	ld	-29 (ix),a
   27E0 DD 7E E6      [19] 2344 	ld	a,-26 (ix)
   27E3 DD 9E E4      [19] 2345 	sbc	a, -28 (ix)
   27E6 DD 77 E4      [19] 2346 	ld	-28 (ix),a
   27E9 DD 6E E3      [19] 2347 	ld	l,-29 (ix)
   27EC DD 66 E4      [19] 2348 	ld	h,-28 (ix)
   27EF 2B            [ 6] 2349 	dec	hl
   27F0 DD 75 E3      [19] 2350 	ld	-29 (ix),l
   27F3 DD 74 E4      [19] 2351 	ld	-28 (ix),h
   27F6 DD 7E E7      [19] 2352 	ld	a,-25 (ix)
   27F9 DD 86 E3      [19] 2353 	add	a, -29 (ix)
   27FC DD 77 E3      [19] 2354 	ld	-29 (ix),a
   27FF DD 7E E8      [19] 2355 	ld	a,-24 (ix)
   2802 DD 8E E4      [19] 2356 	adc	a, -28 (ix)
   2805 DD 77 E4      [19] 2357 	ld	-28 (ix),a
   2808 DD 6E E3      [19] 2358 	ld	l,-29 (ix)
   280B DD 66 E4      [19] 2359 	ld	h,-28 (ix)
   280E 7E            [ 7] 2360 	ld	a,(hl)
   280F DD 77 D8      [19] 2361 	ld	-40 (ix),a
   2812                    2362 00222$:
                           2363 ;src/Renderer.c:872: if(!(x%2)){
   2812 DD 7E D3      [19] 2364 	ld	a,-45 (ix)
   2815 E6 01         [ 7] 2365 	and	a, #0x01
   2817 DD 77 DB      [19] 2366 	ld	-37 (ix),a
                           2367 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   281A DD 7E D8      [19] 2368 	ld	a,-40 (ix)
   281D E6 80         [ 7] 2369 	and	a, #0x80
   281F DD 77 E3      [19] 2370 	ld	-29 (ix),a
                           2371 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   2822 DD 7E FC      [19] 2372 	ld	a,-4 (ix)
   2825 DD 77 FE      [19] 2373 	ld	-2 (ix),a
   2828 DD 36 FF 00   [19] 2374 	ld	-1 (ix),#0x00
                           2375 ;src/Renderer.c:872: if(!(x%2)){
   282C DD 7E DB      [19] 2376 	ld	a,-37 (ix)
   282F B7            [ 4] 2377 	or	a, a
   2830 C2 5E 29      [10] 2378 	jp	NZ,00235$
                           2379 ;src/Renderer.c:873: if (lateralWallCounter == 0 || newCell)
   2833 DD 7E F1      [19] 2380 	ld	a,-15 (ix)
   2836 B7            [ 4] 2381 	or	a, a
   2837 28 07         [12] 2382 	jr	Z,00231$
   2839 DD 7E E9      [19] 2383 	ld	a,-23 (ix)
   283C B7            [ 4] 2384 	or	a, a
   283D CA 5E 29      [10] 2385 	jp	Z,00235$
   2840                    2386 00231$:
                           2387 ;src/Renderer.c:875: if ( currentCellID & CELL_WALL_MASK)//Wall
   2840 DD 7E E3      [19] 2388 	ld	a,-29 (ix)
   2843 B7            [ 4] 2389 	or	a, a
   2844 28 32         [12] 2390 	jr	Z,00229$
                           2391 ;src/Renderer.c:877: lateralWallCounter = 0;
   2846 DD 36 F1 00   [19] 2392 	ld	-15 (ix),#0x00
                           2393 ;src/Renderer.c:878: lateralWallSlope = 0;
   284A DD 36 FA 00   [19] 2394 	ld	-6 (ix),#0x00
                           2395 ;src/Renderer.c:879: xHeight = zHeight;
   284E DD 7E D2      [19] 2396 	ld	a,-46 (ix)
   2851 DD 77 F3      [19] 2397 	ld	-13 (ix),a
                           2398 ;src/Renderer.c:880: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   2854 DD 7E D8      [19] 2399 	ld	a,-40 (ix)
   2857 D6 80         [ 7] 2400 	sub	a, #0x80
   2859 20 06         [12] 2401 	jr	NZ,00283$
   285B DD 36 DC 09   [19] 2402 	ld	-36 (ix),#0x09
   285F 18 04         [12] 2403 	jr	00284$
   2861                    2404 00283$:
   2861 DD 36 DC 0B   [19] 2405 	ld	-36 (ix),#0x0B
   2865                    2406 00284$:
   2865 DD 7E DC      [19] 2407 	ld	a,-36 (ix)
   2868 DD 77 C6      [19] 2408 	ld	-58 (ix),a
                           2409 ;src/Renderer.c:881: lastCellWasWall = 1;
   286B DD 36 D7 01   [19] 2410 	ld	-41 (ix),#0x01
                           2411 ;src/Renderer.c:882: lastWallId=currentCellID;
   286F DD 7E D8      [19] 2412 	ld	a,-40 (ix)
   2872 DD 77 EF      [19] 2413 	ld	-17 (ix),a
   2875 C3 5A 29      [10] 2414 	jp	00230$
   2878                    2415 00229$:
                           2416 ;src/Renderer.c:884: else if(lateralWallCounter==0){
   2878 DD 7E F1      [19] 2417 	ld	a,-15 (ix)
   287B B7            [ 4] 2418 	or	a, a
   287C C2 5A 29      [10] 2419 	jp	NZ,00230$
                           2420 ;src/Renderer.c:885: if (lastCellWasWall)
   287F DD 7E D7      [19] 2421 	ld	a,-41 (ix)
   2882 B7            [ 4] 2422 	or	a, a
   2883 CA 4A 29      [10] 2423 	jp	Z,00224$
                           2424 ;src/Renderer.c:888: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   2886 DD 7E CF      [19] 2425 	ld	a,-49 (ix)
   2889 DD 96 D1      [19] 2426 	sub	a, -47 (ix)
   288C 87            [ 4] 2427 	add	a, a
   288D 3C            [ 4] 2428 	inc	a
                           2429 ;src/Renderer.c:889: lateralWallSlopeCounter = lateralWallSlope / 2;
   288E DD 77 FA      [19] 2430 	ld	-6 (ix), a
   2891 CB 3F         [ 8] 2431 	srl	a
   2893 DD 77 F7      [19] 2432 	ld	-9 (ix),a
                           2433 ;src/Renderer.c:890: lateralWallCounter = lateralWallSlope * zHeight;
   2896 DD 5E D2      [19] 2434 	ld	e,-46 (ix)
   2899 DD 66 FA      [19] 2435 	ld	h,-6 (ix)
   289C 2E 00         [ 7] 2436 	ld	l, #0x00
   289E 55            [ 4] 2437 	ld	d, l
   289F 06 08         [ 7] 2438 	ld	b, #0x08
   28A1                    2439 00675$:
   28A1 29            [11] 2440 	add	hl,hl
   28A2 30 01         [12] 2441 	jr	NC,00676$
   28A4 19            [11] 2442 	add	hl,de
   28A5                    2443 00676$:
   28A5 10 FA         [13] 2444 	djnz	00675$
                           2445 ;src/Renderer.c:891: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   28A7 DD 75 DC      [19] 2446 	ld	-36 (ix), l
   28AA DD 75 E1      [19] 2447 	ld	-31 (ix), l
   28AD DD 36 E2 00   [19] 2448 	ld	-30 (ix),#0x00
   28B1 DD 7E DC      [19] 2449 	ld	a,-36 (ix)
   28B4 E6 03         [ 7] 2450 	and	a, #0x03
   28B6 DD 77 DC      [19] 2451 	ld	-36 (ix), a
   28B9 DD 77 DF      [19] 2452 	ld	-33 (ix),a
   28BC DD 36 E0 00   [19] 2453 	ld	-32 (ix),#0x00
   28C0 DD 7E E1      [19] 2454 	ld	a,-31 (ix)
   28C3 DD 96 DF      [19] 2455 	sub	a, -33 (ix)
   28C6 DD 77 DF      [19] 2456 	ld	-33 (ix),a
   28C9 DD 7E E2      [19] 2457 	ld	a,-30 (ix)
   28CC DD 9E E0      [19] 2458 	sbc	a, -32 (ix)
   28CF DD 77 E0      [19] 2459 	ld	-32 (ix),a
   28D2 DD 7E DF      [19] 2460 	ld	a,-33 (ix)
   28D5 C6 01         [ 7] 2461 	add	a, #0x01
   28D7 DD 77 E1      [19] 2462 	ld	-31 (ix),a
   28DA DD 7E E0      [19] 2463 	ld	a,-32 (ix)
   28DD CE 00         [ 7] 2464 	adc	a, #0x00
   28DF DD 77 E2      [19] 2465 	ld	-30 (ix),a
   28E2 DD 7E E1      [19] 2466 	ld	a,-31 (ix)
   28E5 DD 77 DD      [19] 2467 	ld	-35 (ix),a
   28E8 DD 7E E2      [19] 2468 	ld	a,-30 (ix)
   28EB DD 77 DE      [19] 2469 	ld	-34 (ix),a
   28EE DD CB E2 7E   [20] 2470 	bit	7, -30 (ix)
   28F2 28 10         [12] 2471 	jr	Z,00285$
   28F4 DD 7E DF      [19] 2472 	ld	a,-33 (ix)
   28F7 C6 04         [ 7] 2473 	add	a, #0x04
   28F9 DD 77 DD      [19] 2474 	ld	-35 (ix),a
   28FC DD 7E E0      [19] 2475 	ld	a,-32 (ix)
   28FF CE 00         [ 7] 2476 	adc	a, #0x00
   2901 DD 77 DE      [19] 2477 	ld	-34 (ix),a
   2904                    2478 00285$:
   2904 DD 4E DD      [19] 2479 	ld	c,-35 (ix)
   2907 DD 46 DE      [19] 2480 	ld	b,-34 (ix)
   290A CB 28         [ 8] 2481 	sra	b
   290C CB 19         [ 8] 2482 	rr	c
   290E CB 28         [ 8] 2483 	sra	b
   2910 CB 19         [ 8] 2484 	rr	c
   2912 DD 46 FC      [19] 2485 	ld	b,-4 (ix)
   2915 79            [ 4] 2486 	ld	a,c
   2916 90            [ 4] 2487 	sub	a, b
   2917 DD 77 F1      [19] 2488 	ld	-15 (ix),a
                           2489 ;src/Renderer.c:893: lastCellWasWall = 0;
   291A DD 36 D7 00   [19] 2490 	ld	-41 (ix),#0x00
                           2491 ;src/Renderer.c:894: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   291E DD 6E FE      [19] 2492 	ld	l,-2 (ix)
   2921 DD 66 FF      [19] 2493 	ld	h,-1 (ix)
   2924 29            [11] 2494 	add	hl, hl
   2925 DD 4E FA      [19] 2495 	ld	c,-6 (ix)
   2928 06 00         [ 7] 2496 	ld	b,#0x00
   292A C5            [11] 2497 	push	bc
   292B E5            [11] 2498 	push	hl
   292C CD 29 7D      [17] 2499 	call	__divsint
   292F F1            [10] 2500 	pop	af
   2930 F1            [10] 2501 	pop	af
   2931 DD 7E EA      [19] 2502 	ld	a,-22 (ix)
   2934 95            [ 4] 2503 	sub	a, l
   2935 DD 77 F3      [19] 2504 	ld	-13 (ix),a
                           2505 ;src/Renderer.c:895: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   2938 DD 7E EF      [19] 2506 	ld	a,-17 (ix)
   293B D6 80         [ 7] 2507 	sub	a, #0x80
   293D 20 04         [12] 2508 	jr	NZ,00286$
   293F 0E 0A         [ 7] 2509 	ld	c,#0x0A
   2941 18 02         [12] 2510 	jr	00287$
   2943                    2511 00286$:
   2943 0E 0C         [ 7] 2512 	ld	c,#0x0C
   2945                    2513 00287$:
   2945 DD 71 C6      [19] 2514 	ld	-58 (ix),c
   2948 18 10         [12] 2515 	jr	00230$
   294A                    2516 00224$:
                           2517 ;src/Renderer.c:899: xHeight = 0;
   294A DD 36 F3 00   [19] 2518 	ld	-13 (ix),#0x00
                           2519 ;src/Renderer.c:900: lastCellWasWall = 0;
   294E DD 36 D7 00   [19] 2520 	ld	-41 (ix),#0x00
                           2521 ;src/Renderer.c:901: lateralWallSlope=0;
   2952 DD 36 FA 00   [19] 2522 	ld	-6 (ix),#0x00
                           2523 ;src/Renderer.c:902: lastWallId=0;
   2956 DD 36 EF 00   [19] 2524 	ld	-17 (ix),#0x00
   295A                    2525 00230$:
                           2526 ;src/Renderer.c:905: newCell=0;
   295A DD 36 E9 00   [19] 2527 	ld	-23 (ix),#0x00
   295E                    2528 00235$:
                           2529 ;src/Renderer.c:910: if (lateralWallCounter > 0)
   295E DD 7E F1      [19] 2530 	ld	a,-15 (ix)
   2961 B7            [ 4] 2531 	or	a, a
   2962 28 1E         [12] 2532 	jr	Z,00241$
                           2533 ;src/Renderer.c:913: if (lateralWallSlope != 0)
   2964 DD 7E FA      [19] 2534 	ld	a,-6 (ix)
   2967 B7            [ 4] 2535 	or	a, a
   2968 28 15         [12] 2536 	jr	Z,00239$
                           2537 ;src/Renderer.c:915: if (lateralWallSlopeCounter == lateralWallSlope)
   296A DD 7E FA      [19] 2538 	ld	a,-6 (ix)
   296D DD 96 F7      [19] 2539 	sub	a, -9 (ix)
   2970 20 0A         [12] 2540 	jr	NZ,00237$
                           2541 ;src/Renderer.c:917: lateralWallSlopeCounter = 0;
   2972 DD 36 F7 00   [19] 2542 	ld	-9 (ix),#0x00
                           2543 ;src/Renderer.c:918: xHeight -= 2;
   2976 DD 35 F3      [23] 2544 	dec	-13 (ix)
   2979 DD 35 F3      [23] 2545 	dec	-13 (ix)
   297C                    2546 00237$:
                           2547 ;src/Renderer.c:920: ++lateralWallSlopeCounter;
   297C DD 34 F7      [23] 2548 	inc	-9 (ix)
   297F                    2549 00239$:
                           2550 ;src/Renderer.c:922: --lateralWallCounter;
   297F DD 35 F1      [23] 2551 	dec	-15 (ix)
   2982                    2552 00241$:
                           2553 ;src/Renderer.c:926: if (!(x%2))
   2982 DD 7E DB      [19] 2554 	ld	a,-37 (ix)
   2985 B7            [ 4] 2555 	or	a, a
   2986 20 74         [12] 2556 	jr	NZ,00252$
                           2557 ;src/Renderer.c:931: draw_column_to_buffer_untextured(x/2, xHeight, color);
   2988 DD 46 D3      [19] 2558 	ld	b,-45 (ix)
   298B CB 38         [ 8] 2559 	srl	b
                           2560 ;src/Renderer.c:929: if(xHeight > 0){
   298D DD 7E F3      [19] 2561 	ld	a,-13 (ix)
   2990 B7            [ 4] 2562 	or	a, a
   2991 28 10         [12] 2563 	jr	Z,00243$
                           2564 ;src/Renderer.c:931: draw_column_to_buffer_untextured(x/2, xHeight, color);
   2993 C5            [11] 2565 	push	bc
   2994 DD 66 C6      [19] 2566 	ld	h,-58 (ix)
   2997 DD 6E F3      [19] 2567 	ld	l,-13 (ix)
   299A E5            [11] 2568 	push	hl
   299B C5            [11] 2569 	push	bc
   299C 33            [ 6] 2570 	inc	sp
   299D CD 7F 1A      [17] 2571 	call	_draw_column_to_buffer_untextured
   29A0 F1            [10] 2572 	pop	af
   29A1 33            [ 6] 2573 	inc	sp
   29A2 C1            [10] 2574 	pop	bc
   29A3                    2575 00243$:
                           2576 ;src/Renderer.c:934: if(!(currentCellID&CELL_WALL_MASK)){
   29A3 DD 7E E3      [19] 2577 	ld	a,-29 (ix)
   29A6 B7            [ 4] 2578 	or	a, a
   29A7 20 53         [12] 2579 	jr	NZ,00252$
                           2580 ;src/Renderer.c:674: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   29A9 DD 7E F5      [19] 2581 	ld	a,-11 (ix)
   29AC DD 96 FE      [19] 2582 	sub	a, -2 (ix)
   29AF 6F            [ 4] 2583 	ld	l,a
   29B0 DD 7E F6      [19] 2584 	ld	a,-10 (ix)
   29B3 DD 9E FF      [19] 2585 	sbc	a, -1 (ix)
   29B6 67            [ 4] 2586 	ld	h,a
   29B7 29            [11] 2587 	add	hl, hl
   29B8 29            [11] 2588 	add	hl, hl
   29B9 29            [11] 2589 	add	hl, hl
   29BA 29            [11] 2590 	add	hl, hl
   29BB 29            [11] 2591 	add	hl, hl
   29BC C5            [11] 2592 	push	bc
   29BD DD 5E F5      [19] 2593 	ld	e,-11 (ix)
   29C0 DD 56 F6      [19] 2594 	ld	d,-10 (ix)
   29C3 D5            [11] 2595 	push	de
   29C4 E5            [11] 2596 	push	hl
   29C5 CD 29 7D      [17] 2597 	call	__divsint
   29C8 F1            [10] 2598 	pop	af
   29C9 F1            [10] 2599 	pop	af
   29CA 55            [ 4] 2600 	ld	d,l
   29CB C1            [10] 2601 	pop	bc
                           2602 ;src/Renderer.c:935: if(currentCellID&CELL_ENEMY_MASK){
   29CC DD 7E D8      [19] 2603 	ld	a,-40 (ix)
   29CF E6 0F         [ 7] 2604 	and	a, #0x0F
   29D1 28 12         [12] 2605 	jr	Z,00247$
                           2606 ;src/Renderer.c:936: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   29D3 D5            [11] 2607 	push	de
   29D4 33            [ 6] 2608 	inc	sp
   29D5 DD 66 D8      [19] 2609 	ld	h,-40 (ix)
   29D8 DD 6E D2      [19] 2610 	ld	l,-46 (ix)
   29DB E5            [11] 2611 	push	hl
   29DC C5            [11] 2612 	push	bc
   29DD 33            [ 6] 2613 	inc	sp
   29DE CD F2 1B      [17] 2614 	call	_draw_column_to_buffer_enemy
   29E1 F1            [10] 2615 	pop	af
   29E2 F1            [10] 2616 	pop	af
   29E3 18 17         [12] 2617 	jr	00252$
   29E5                    2618 00247$:
                           2619 ;src/Renderer.c:938: else if(currentCellID&CELL_ITEM_MASK){
   29E5 DD 7E D8      [19] 2620 	ld	a,-40 (ix)
   29E8 E6 70         [ 7] 2621 	and	a, #0x70
   29EA 28 10         [12] 2622 	jr	Z,00252$
                           2623 ;src/Renderer.c:939: draw_column_to_buffer_object(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   29EC D5            [11] 2624 	push	de
   29ED 33            [ 6] 2625 	inc	sp
   29EE DD 66 D8      [19] 2626 	ld	h,-40 (ix)
   29F1 DD 6E D2      [19] 2627 	ld	l,-46 (ix)
   29F4 E5            [11] 2628 	push	hl
   29F5 C5            [11] 2629 	push	bc
   29F6 33            [ 6] 2630 	inc	sp
   29F7 CD F7 1A      [17] 2631 	call	_draw_column_to_buffer_object
   29FA F1            [10] 2632 	pop	af
   29FB F1            [10] 2633 	pop	af
   29FC                    2634 00252$:
                           2635 ;src/Renderer.c:943: ++xCellCount;
   29FC DD 34 FC      [23] 2636 	inc	-4 (ix)
                           2637 ;src/Renderer.c:862: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   29FF DD 35 D3      [23] 2638 	dec	-45 (ix)
                           2639 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   2A02 2A 78 1A      [16] 2640 	ld	hl,(_cells_in_view_array)
   2A05 DD 75 E7      [19] 2641 	ld	-25 (ix),l
   2A08 DD 74 E8      [19] 2642 	ld	-24 (ix),h
                           2643 ;src/Renderer.c:862: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   2A0B DD 7E D3      [19] 2644 	ld	a,-45 (ix)
   2A0E D6 50         [ 7] 2645 	sub	a, #0x50
   2A10 D2 BA 27      [10] 2646 	jp	NC,00266$
                           2647 ;src/Renderer.c:972: lineStart = lineStart + (offsetDiff * 2) + 3;
   2A13 DD 7E EC      [19] 2648 	ld	a,-20 (ix)
   2A16 C6 03         [ 7] 2649 	add	a, #0x03
   2A18 DD 77 C7      [19] 2650 	ld	-57 (ix),a
                           2651 ;src/Renderer.c:973: zHeight += zHeight;
   2A1B DD CB D2 26   [23] 2652 	sla	-46 (ix)
                           2653 ;src/Renderer.c:974: offsetDiff = offsetDiff >> 1;
   2A1F DD CB CF 3E   [23] 2654 	srl	-49 (ix)
                           2655 ;src/Renderer.c:976: }while(z);
   2A23 DD 7E CA      [19] 2656 	ld	a,-54 (ix)
   2A26 B7            [ 4] 2657 	or	a, a
   2A27 C2 4B 24      [10] 2658 	jp	NZ,00254$
   2A2A                    2659 00268$:
   2A2A DD F9         [10] 2660 	ld	sp, ix
   2A2C DD E1         [14] 2661 	pop	ix
   2A2E C9            [10] 2662 	ret
                           2663 ;src/Renderer.c:982: void draw_minimap_to_buffer(){
                           2664 ;	---------------------------------
                           2665 ; Function draw_minimap_to_buffer
                           2666 ; ---------------------------------
   2A2F                    2667 _draw_minimap_to_buffer::
   2A2F DD E5         [15] 2668 	push	ix
   2A31 DD 21 00 00   [14] 2669 	ld	ix,#0
   2A35 DD 39         [15] 2670 	add	ix,sp
   2A37 21 F5 FF      [10] 2671 	ld	hl,#-11
   2A3A 39            [11] 2672 	add	hl,sp
   2A3B F9            [ 6] 2673 	ld	sp,hl
                           2674 ;src/Renderer.c:985: u8* ptr = MINIMAP_BUFFER;
   2A3C 01 F0 B9      [10] 2675 	ld	bc,#0xB9F0
                           2676 ;src/Renderer.c:990: y=(player_position.y-MINIMAP_HEIGHT_HALF);
   2A3F 3A 2D 18      [13] 2677 	ld	a, (#(_player_position + 0x0001) + 0)
   2A42 C6 F8         [ 7] 2678 	add	a,#0xF8
   2A44 5F            [ 4] 2679 	ld	e,a
                           2680 ;src/Renderer.c:992: for(j=0;j<MINIMAP_HEIGHT;++j){
   2A45 16 00         [ 7] 2681 	ld	d,#0x00
                           2682 ;src/Renderer.c:993: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   2A47                    2683 00141$:
   2A47 7B            [ 4] 2684 	ld	a,e
   2A48 07            [ 4] 2685 	rlca
   2A49 E6 01         [ 7] 2686 	and	a,#0x01
   2A4B DD 77 F8      [19] 2687 	ld	-8 (ix),a
   2A4E 7B            [ 4] 2688 	ld	a,e
   2A4F EE 80         [ 7] 2689 	xor	a, #0x80
   2A51 D6 A0         [ 7] 2690 	sub	a, #0xA0
   2A53 3E 00         [ 7] 2691 	ld	a,#0x00
   2A55 17            [ 4] 2692 	rla
   2A56 DD 77 FF      [19] 2693 	ld	-1 (ix),a
   2A59 DD 36 F6 00   [19] 2694 	ld	-10 (ix),#0x00
   2A5D                    2695 00125$:
                           2696 ;src/Renderer.c:994: x=(player_position.x-MINIMAP_WIDTH_HALF);
   2A5D 3A 2C 18      [13] 2697 	ld	a, (#_player_position + 0)
   2A60 C6 F8         [ 7] 2698 	add	a,#0xF8
   2A62 DD 77 F7      [19] 2699 	ld	-9 (ix),a
                           2700 ;src/Renderer.c:995: for(i=0;i<MINIMAP_WIDTH;++i){
   2A65 DD 36 F5 00   [19] 2701 	ld	-11 (ix),#0x00
   2A69                    2702 00123$:
                           2703 ;src/Renderer.c:998: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   2A69 FD 21 10 00   [14] 2704 	ld	iy,#0x0010
   2A6D FD 09         [15] 2705 	add	iy, bc
                           2706 ;src/Renderer.c:996: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
   2A6F DD CB F7 7E   [20] 2707 	bit	7, -9 (ix)
   2A73 20 15         [12] 2708 	jr	NZ,00114$
   2A75 DD 7E F7      [19] 2709 	ld	a,-9 (ix)
   2A78 EE 80         [ 7] 2710 	xor	a, #0x80
   2A7A D6 A0         [ 7] 2711 	sub	a, #0xA0
   2A7C 30 0C         [12] 2712 	jr	NC,00114$
   2A7E DD 7E F8      [19] 2713 	ld	a,-8 (ix)
   2A81 B7            [ 4] 2714 	or	a, a
   2A82 20 06         [12] 2715 	jr	NZ,00114$
   2A84 DD CB FF 46   [20] 2716 	bit	0,-1 (ix)
   2A88 20 0D         [12] 2717 	jr	NZ,00115$
   2A8A                    2718 00114$:
                           2719 ;src/Renderer.c:997: *ptr=g_colors[MINIMAP_WALL_COLOR];
   2A8A 3A 67 1A      [13] 2720 	ld	a, (#(_g_colors + 0x0001) + 0)
   2A8D 02            [ 7] 2721 	ld	(bc),a
                           2722 ;src/Renderer.c:998: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   2A8E 3A 67 1A      [13] 2723 	ld	a, (#(_g_colors + 0x0001) + 0)
   2A91 FD 77 00      [19] 2724 	ld	0 (iy), a
   2A94 C3 51 2B      [10] 2725 	jp	00116$
   2A97                    2726 00115$:
                           2727 ;src/Renderer.c:1000: else if((x==player_position.x)&&(y==player_position.y)){
   2A97 DD 7E F7      [19] 2728 	ld	a,-9 (ix)
   2A9A DD 77 FD      [19] 2729 	ld	-3 (ix),a
   2A9D DD 7E F7      [19] 2730 	ld	a,-9 (ix)
   2AA0 17            [ 4] 2731 	rla
   2AA1 9F            [ 4] 2732 	sbc	a, a
   2AA2 DD 77 FE      [19] 2733 	ld	-2 (ix),a
   2AA5 3A 2C 18      [13] 2734 	ld	a, (#_player_position + 0)
   2AA8 DD 77 F9      [19] 2735 	ld	-7 (ix),a
   2AAB DD 36 FA 00   [19] 2736 	ld	-6 (ix),#0x00
   2AAF DD 73 FB      [19] 2737 	ld	-5 (ix),e
   2AB2 7B            [ 4] 2738 	ld	a,e
   2AB3 17            [ 4] 2739 	rla
   2AB4 9F            [ 4] 2740 	sbc	a, a
   2AB5 DD 77 FC      [19] 2741 	ld	-4 (ix),a
   2AB8 DD 7E FD      [19] 2742 	ld	a,-3 (ix)
   2ABB DD 96 F9      [19] 2743 	sub	a, -7 (ix)
   2ABE 20 2E         [12] 2744 	jr	NZ,00111$
   2AC0 DD 7E FE      [19] 2745 	ld	a,-2 (ix)
   2AC3 DD 96 FA      [19] 2746 	sub	a, -6 (ix)
   2AC6 20 26         [12] 2747 	jr	NZ,00111$
   2AC8 3A 2D 18      [13] 2748 	ld	a, (#(_player_position + 0x0001) + 0)
   2ACB DD 77 F9      [19] 2749 	ld	-7 (ix),a
   2ACE DD 36 FA 00   [19] 2750 	ld	-6 (ix),#0x00
   2AD2 DD 7E FB      [19] 2751 	ld	a,-5 (ix)
   2AD5 DD 96 F9      [19] 2752 	sub	a, -7 (ix)
   2AD8 20 14         [12] 2753 	jr	NZ,00111$
   2ADA DD 7E FC      [19] 2754 	ld	a,-4 (ix)
   2ADD DD 96 FA      [19] 2755 	sub	a, -6 (ix)
   2AE0 20 0C         [12] 2756 	jr	NZ,00111$
                           2757 ;src/Renderer.c:1001: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
   2AE2 3A 6A 1A      [13] 2758 	ld	a, (#(_g_colors + 0x0004) + 0)
   2AE5 02            [ 7] 2759 	ld	(bc),a
                           2760 ;src/Renderer.c:1002: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
   2AE6 3A 6A 1A      [13] 2761 	ld	a, (#(_g_colors + 0x0004) + 0)
   2AE9 FD 77 00      [19] 2762 	ld	0 (iy), a
   2AEC 18 63         [12] 2763 	jr	00116$
   2AEE                    2764 00111$:
                           2765 ;src/Renderer.c:1005: val = (*(u8*)(MAP_MEM+x+y*MAP_WIDTH));
   2AEE DD 7E FD      [19] 2766 	ld	a, -3 (ix)
   2AF1 DD 66 FE      [19] 2767 	ld	h, -2 (ix)
   2AF4 C6 D0         [ 7] 2768 	add	a, #0xD0
   2AF6 DD 77 F9      [19] 2769 	ld	-7 (ix),a
   2AF9 7C            [ 4] 2770 	ld	a,h
   2AFA CE 88         [ 7] 2771 	adc	a, #0x88
   2AFC DD 77 FA      [19] 2772 	ld	-6 (ix),a
   2AFF DD 6E FB      [19] 2773 	ld	l,-5 (ix)
   2B02 DD 66 FC      [19] 2774 	ld	h,-4 (ix)
   2B05 29            [11] 2775 	add	hl, hl
   2B06 29            [11] 2776 	add	hl, hl
   2B07 29            [11] 2777 	add	hl, hl
   2B08 29            [11] 2778 	add	hl, hl
   2B09 29            [11] 2779 	add	hl, hl
   2B0A DD 7E F9      [19] 2780 	ld	a,-7 (ix)
   2B0D 85            [ 4] 2781 	add	a, l
   2B0E 6F            [ 4] 2782 	ld	l,a
   2B0F DD 7E FA      [19] 2783 	ld	a,-6 (ix)
   2B12 8C            [ 4] 2784 	adc	a, h
   2B13 67            [ 4] 2785 	ld	h,a
   2B14 6E            [ 7] 2786 	ld	l,(hl)
                           2787 ;src/Renderer.c:1007: if(val==CELLTYPE_DOOR){
   2B15 7D            [ 4] 2788 	ld	a,l
   2B16 D6 80         [ 7] 2789 	sub	a, #0x80
   2B18 20 0C         [12] 2790 	jr	NZ,00108$
                           2791 ;src/Renderer.c:1008: *ptr=g_colors[MINIMAP_EXIT_COLOR];
   2B1A 3A 6B 1A      [13] 2792 	ld	a, (#(_g_colors + 0x0005) + 0)
   2B1D 02            [ 7] 2793 	ld	(bc),a
                           2794 ;src/Renderer.c:1009: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
   2B1E 3A 6B 1A      [13] 2795 	ld	a, (#(_g_colors + 0x0005) + 0)
   2B21 FD 77 00      [19] 2796 	ld	0 (iy), a
   2B24 18 2B         [12] 2797 	jr	00116$
   2B26                    2798 00108$:
                           2799 ;src/Renderer.c:1011: else if(val&CELL_WALL_MASK){
   2B26 CB 7D         [ 8] 2800 	bit	7, l
   2B28 28 0C         [12] 2801 	jr	Z,00105$
                           2802 ;src/Renderer.c:1012: *ptr=g_colors[MINIMAP_WALL_COLOR];
   2B2A 3A 67 1A      [13] 2803 	ld	a, (#(_g_colors + 0x0001) + 0)
   2B2D 02            [ 7] 2804 	ld	(bc),a
                           2805 ;src/Renderer.c:1013: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   2B2E 3A 67 1A      [13] 2806 	ld	a, (#(_g_colors + 0x0001) + 0)
   2B31 FD 77 00      [19] 2807 	ld	0 (iy), a
   2B34 18 1B         [12] 2808 	jr	00116$
   2B36                    2809 00105$:
                           2810 ;src/Renderer.c:1015: else if(val&CELL_ENEMY_MASK){
   2B36 7D            [ 4] 2811 	ld	a,l
   2B37 E6 0F         [ 7] 2812 	and	a, #0x0F
   2B39 28 0C         [12] 2813 	jr	Z,00102$
                           2814 ;src/Renderer.c:1016: *ptr=g_colors[MINIMAP_ENEMY_COLOR];
   2B3B 3A 6C 1A      [13] 2815 	ld	a, (#(_g_colors + 0x0006) + 0)
   2B3E 02            [ 7] 2816 	ld	(bc),a
                           2817 ;src/Renderer.c:1017: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_ENEMY_COLOR];
   2B3F 3A 6C 1A      [13] 2818 	ld	a, (#(_g_colors + 0x0006) + 0)
   2B42 FD 77 00      [19] 2819 	ld	0 (iy), a
   2B45 18 0A         [12] 2820 	jr	00116$
   2B47                    2821 00102$:
                           2822 ;src/Renderer.c:1024: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
   2B47 3A 69 1A      [13] 2823 	ld	a, (#(_g_colors + 0x0003) + 0)
   2B4A 02            [ 7] 2824 	ld	(bc),a
                           2825 ;src/Renderer.c:1025: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
   2B4B 3A 69 1A      [13] 2826 	ld	a, (#(_g_colors + 0x0003) + 0)
   2B4E FD 77 00      [19] 2827 	ld	0 (iy), a
   2B51                    2828 00116$:
                           2829 ;src/Renderer.c:1028: ++x;
   2B51 DD 34 F7      [23] 2830 	inc	-9 (ix)
                           2831 ;src/Renderer.c:1029: ++ptr;
   2B54 03            [ 6] 2832 	inc	bc
                           2833 ;src/Renderer.c:995: for(i=0;i<MINIMAP_WIDTH;++i){
   2B55 DD 34 F5      [23] 2834 	inc	-11 (ix)
   2B58 DD 7E F5      [19] 2835 	ld	a,-11 (ix)
   2B5B D6 10         [ 7] 2836 	sub	a, #0x10
   2B5D DA 69 2A      [10] 2837 	jp	C,00123$
                           2838 ;src/Renderer.c:993: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   2B60 DD 34 F6      [23] 2839 	inc	-10 (ix)
   2B63 DD 7E F6      [19] 2840 	ld	a,-10 (ix)
   2B66 D6 04         [ 7] 2841 	sub	a, #0x04
   2B68 DA 5D 2A      [10] 2842 	jp	C,00125$
                           2843 ;src/Renderer.c:1032: ++y;
   2B6B 1C            [ 4] 2844 	inc	e
                           2845 ;src/Renderer.c:992: for(j=0;j<MINIMAP_HEIGHT;++j){
   2B6C 14            [ 4] 2846 	inc	d
   2B6D 7A            [ 4] 2847 	ld	a,d
   2B6E D6 10         [ 7] 2848 	sub	a, #0x10
   2B70 DA 47 2A      [10] 2849 	jp	C,00141$
   2B73 DD F9         [10] 2850 	ld	sp, ix
   2B75 DD E1         [14] 2851 	pop	ix
   2B77 C9            [10] 2852 	ret
                           2853 	.area _CODE
                           2854 	.area _INITIALIZER
                           2855 	.area _CABS (ABS)
