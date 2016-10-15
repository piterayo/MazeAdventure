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
   08E7                      60 _calculate_cells_in_view::
   08E7 DD E5         [15]   61 	push	ix
   08E9 DD 21 00 00   [14]   62 	ld	ix,#0
   08ED DD 39         [15]   63 	add	ix,sp
   08EF 21 F2 FF      [10]   64 	ld	hl,#-14
   08F2 39            [11]   65 	add	hl,sp
   08F3 F9            [ 6]   66 	ld	sp,hl
                             67 ;src/Renderer.c:55: u8 offset=0, n=0, j, i;
   08F4 DD 36 FA 00   [19]   68 	ld	-6 (ix),#0x00
   08F8 DD 36 F9 00   [19]   69 	ld	-7 (ix),#0x00
                             70 ;src/Renderer.c:58: if(player_direction.y!=0){
   08FC 21 8C 08      [10]   71 	ld	hl, #_player_direction + 1
   08FF 7E            [ 7]   72 	ld	a,(hl)
   0900 DD 77 FE      [19]   73 	ld	-2 (ix), a
   0903 B7            [ 4]   74 	or	a, a
   0904 28 32         [12]   75 	jr	Z,00102$
                             76 ;src/Renderer.c:59: vert=1;
   0906 DD 36 F2 01   [19]   77 	ld	-14 (ix),#0x01
                             78 ;src/Renderer.c:60: dy=player_direction.y;
   090A DD 4E FE      [19]   79 	ld	c,-2 (ix)
   090D DD 71 F4      [19]   80 	ld	-12 (ix),c
                             81 ;src/Renderer.c:61: dx=-player_direction.y;
   0910 AF            [ 4]   82 	xor	a, a
   0911 DD 96 FE      [19]   83 	sub	a, -2 (ix)
   0914 DD 77 F5      [19]   84 	ld	-11 (ix), a
                             85 ;src/Renderer.c:63: x0 = player_position.x-(17*dx);
   0917 21 89 08      [10]   86 	ld	hl,#_player_position+0
   091A 4E            [ 7]   87 	ld	c,(hl)
   091B DD 6E F5      [19]   88 	ld	l,-11 (ix)
   091E 5D            [ 4]   89 	ld	e,l
   091F 29            [11]   90 	add	hl, hl
   0920 29            [11]   91 	add	hl, hl
   0921 29            [11]   92 	add	hl, hl
   0922 29            [11]   93 	add	hl, hl
   0923 19            [11]   94 	add	hl, de
   0924 79            [ 4]   95 	ld	a,c
   0925 95            [ 4]   96 	sub	a, l
   0926 DD 77 F6      [19]   97 	ld	-10 (ix),a
                             98 ;src/Renderer.c:64: y0 = player_position.y+(6*dy);
   0929 21 8A 08      [10]   99 	ld	hl,#_player_position+1
   092C 4E            [ 7]  100 	ld	c,(hl)
   092D DD 6E F4      [19]  101 	ld	l,-12 (ix)
   0930 5D            [ 4]  102 	ld	e,l
   0931 29            [11]  103 	add	hl, hl
   0932 19            [11]  104 	add	hl, de
   0933 29            [11]  105 	add	hl, hl
   0934 09            [11]  106 	add	hl, bc
   0935 4D            [ 4]  107 	ld	c,l
   0936 18 35         [12]  108 	jr	00103$
   0938                     109 00102$:
                            110 ;src/Renderer.c:67: vert=0;
   0938 DD 36 F2 00   [19]  111 	ld	-14 (ix),#0x00
                            112 ;src/Renderer.c:68: dy=player_direction.x;
   093C 21 8B 08      [10]  113 	ld	hl, #_player_direction + 0
   093F 7E            [ 7]  114 	ld	a,(hl)
   0940 DD 77 FE      [19]  115 	ld	-2 (ix), a
   0943 DD 77 F4      [19]  116 	ld	-12 (ix),a
                            117 ;src/Renderer.c:69: dx=player_direction.x;
   0946 DD 7E FE      [19]  118 	ld	a,-2 (ix)
   0949 DD 77 F5      [19]  119 	ld	-11 (ix),a
                            120 ;src/Renderer.c:71: y0 = player_position.y-(17*dy);
   094C 21 8A 08      [10]  121 	ld	hl, #_player_position + 1
   094F 4E            [ 7]  122 	ld	c,(hl)
   0950 DD 6E F4      [19]  123 	ld	l,-12 (ix)
   0953 5D            [ 4]  124 	ld	e,l
   0954 29            [11]  125 	add	hl, hl
   0955 29            [11]  126 	add	hl, hl
   0956 29            [11]  127 	add	hl, hl
   0957 29            [11]  128 	add	hl, hl
   0958 19            [11]  129 	add	hl, de
   0959 79            [ 4]  130 	ld	a,c
   095A 95            [ 4]  131 	sub	a, l
   095B 4F            [ 4]  132 	ld	c,a
                            133 ;src/Renderer.c:72: x0 = player_position.x+(6*dx);
   095C 21 89 08      [10]  134 	ld	hl, #_player_position + 0
   095F 46            [ 7]  135 	ld	b,(hl)
   0960 DD 7E FE      [19]  136 	ld	a,-2 (ix)
   0963 5F            [ 4]  137 	ld	e,a
   0964 87            [ 4]  138 	add	a, a
   0965 83            [ 4]  139 	add	a, e
   0966 87            [ 4]  140 	add	a, a
   0967 5F            [ 4]  141 	ld	e,a
   0968 68            [ 4]  142 	ld	l,b
   0969 19            [11]  143 	add	hl, de
   096A DD 75 F6      [19]  144 	ld	-10 (ix),l
   096D                     145 00103$:
                            146 ;src/Renderer.c:76: x=x0;
   096D DD 5E F6      [19]  147 	ld	e,-10 (ix)
                            148 ;src/Renderer.c:77: y=y0;
   0970 DD 71 F3      [19]  149 	ld	-13 (ix),c
                            150 ;src/Renderer.c:79: for(j=0;j<6;++j){
   0973 DD 7E F5      [19]  151 	ld	a,-11 (ix)
   0976 07            [ 4]  152 	rlca
   0977 E6 01         [ 7]  153 	and	a,#0x01
   0979 DD 77 FE      [19]  154 	ld	-2 (ix),a
   097C DD 7E F4      [19]  155 	ld	a,-12 (ix)
   097F 07            [ 4]  156 	rlca
   0980 E6 01         [ 7]  157 	and	a,#0x01
   0982 DD 77 FD      [19]  158 	ld	-3 (ix),a
   0985 DD 36 F8 00   [19]  159 	ld	-8 (ix),#0x00
                            160 ;src/Renderer.c:81: for(i=offset;i<35-offset;++i){
   0989                     161 00138$:
   0989 DD 7E F9      [19]  162 	ld	a,-7 (ix)
   098C DD 77 FF      [19]  163 	ld	-1 (ix),a
   098F DD 7E FA      [19]  164 	ld	a,-6 (ix)
   0992 DD 77 F7      [19]  165 	ld	-9 (ix),a
   0995                     166 00125$:
   0995 DD 6E FA      [19]  167 	ld	l,-6 (ix)
   0998 26 00         [ 7]  168 	ld	h,#0x00
   099A 3E 23         [ 7]  169 	ld	a,#0x23
   099C 95            [ 4]  170 	sub	a, l
   099D 6F            [ 4]  171 	ld	l,a
   099E 3E 00         [ 7]  172 	ld	a,#0x00
   09A0 9C            [ 4]  173 	sbc	a, h
   09A1 67            [ 4]  174 	ld	h,a
   09A2 DD 7E F7      [19]  175 	ld	a, -9 (ix)
   09A5 16 00         [ 7]  176 	ld	d, #0x00
   09A7 95            [ 4]  177 	sub	a, l
   09A8 7A            [ 4]  178 	ld	a,d
   09A9 9C            [ 4]  179 	sbc	a, h
   09AA E2 AF 09      [10]  180 	jp	PO, 00181$
   09AD EE 80         [ 7]  181 	xor	a, #0x80
   09AF                     182 00181$:
   09AF F2 29 0A      [10]  183 	jp	P,00143$
                            184 ;src/Renderer.c:84: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   09B2 2A B6 0A      [16]  185 	ld	hl,(_cells_in_view_array)
   09B5 7D            [ 4]  186 	ld	a,l
   09B6 DD 86 FF      [19]  187 	add	a, -1 (ix)
   09B9 DD 77 FB      [19]  188 	ld	-5 (ix),a
   09BC 7C            [ 4]  189 	ld	a,h
   09BD CE 00         [ 7]  190 	adc	a, #0x00
   09BF DD 77 FC      [19]  191 	ld	-4 (ix),a
                            192 ;src/Renderer.c:83: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
   09C2 CB 7B         [ 8]  193 	bit	7, e
   09C4 20 3C         [12]  194 	jr	NZ,00105$
   09C6 7B            [ 4]  195 	ld	a,e
   09C7 EE 80         [ 7]  196 	xor	a, #0x80
   09C9 D6 A0         [ 7]  197 	sub	a, #0xA0
   09CB 30 35         [12]  198 	jr	NC,00105$
   09CD DD CB F3 7E   [20]  199 	bit	7, -13 (ix)
   09D1 20 2F         [12]  200 	jr	NZ,00105$
   09D3 DD 7E F3      [19]  201 	ld	a,-13 (ix)
   09D6 EE 80         [ 7]  202 	xor	a, #0x80
   09D8 D6 A0         [ 7]  203 	sub	a, #0xA0
   09DA 30 26         [12]  204 	jr	NC,00105$
                            205 ;src/Renderer.c:84: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   09DC 7B            [ 4]  206 	ld	a,e
   09DD 57            [ 4]  207 	ld	d,a
   09DE 17            [ 4]  208 	rla
   09DF 9F            [ 4]  209 	sbc	a, a
   09E0 42            [ 4]  210 	ld	b, d
   09E1 C6 60         [ 7]  211 	add	a,#0x60
   09E3 57            [ 4]  212 	ld	d,a
   09E4 DD 6E F3      [19]  213 	ld	l,-13 (ix)
   09E7 DD 7E F3      [19]  214 	ld	a,-13 (ix)
   09EA 17            [ 4]  215 	rla
   09EB 9F            [ 4]  216 	sbc	a, a
   09EC 67            [ 4]  217 	ld	h,a
   09ED 29            [11]  218 	add	hl, hl
   09EE 29            [11]  219 	add	hl, hl
   09EF 29            [11]  220 	add	hl, hl
   09F0 29            [11]  221 	add	hl, hl
   09F1 29            [11]  222 	add	hl, hl
   09F2 78            [ 4]  223 	ld	a,b
   09F3 85            [ 4]  224 	add	a, l
   09F4 6F            [ 4]  225 	ld	l,a
   09F5 7A            [ 4]  226 	ld	a,d
   09F6 8C            [ 4]  227 	adc	a, h
   09F7 67            [ 4]  228 	ld	h,a
   09F8 46            [ 7]  229 	ld	b,(hl)
   09F9 DD 6E FB      [19]  230 	ld	l,-5 (ix)
   09FC DD 66 FC      [19]  231 	ld	h,-4 (ix)
   09FF 70            [ 7]  232 	ld	(hl),b
   0A00 18 08         [12]  233 	jr	00106$
   0A02                     234 00105$:
                            235 ;src/Renderer.c:87: cells_in_view_array[n]=CELLTYPE_WALL1;
   0A02 DD 6E FB      [19]  236 	ld	l,-5 (ix)
   0A05 DD 66 FC      [19]  237 	ld	h,-4 (ix)
   0A08 36 81         [10]  238 	ld	(hl),#0x81
   0A0A                     239 00106$:
                            240 ;src/Renderer.c:91: if(vert){
   0A0A DD 7E F2      [19]  241 	ld	a,-14 (ix)
   0A0D B7            [ 4]  242 	or	a, a
   0A0E 28 07         [12]  243 	jr	Z,00111$
                            244 ;src/Renderer.c:92: x+=dx;
   0A10 7B            [ 4]  245 	ld	a,e
   0A11 DD 86 F5      [19]  246 	add	a, -11 (ix)
   0A14 5F            [ 4]  247 	ld	e,a
   0A15 18 09         [12]  248 	jr	00112$
   0A17                     249 00111$:
                            250 ;src/Renderer.c:95: y+=dy;
   0A17 DD 7E F3      [19]  251 	ld	a,-13 (ix)
   0A1A DD 86 F4      [19]  252 	add	a, -12 (ix)
   0A1D DD 77 F3      [19]  253 	ld	-13 (ix),a
   0A20                     254 00112$:
                            255 ;src/Renderer.c:97: ++n;
   0A20 DD 34 FF      [23]  256 	inc	-1 (ix)
                            257 ;src/Renderer.c:81: for(i=offset;i<35-offset;++i){
   0A23 DD 34 F7      [23]  258 	inc	-9 (ix)
   0A26 C3 95 09      [10]  259 	jp	00125$
   0A29                     260 00143$:
   0A29 DD 7E FF      [19]  261 	ld	a,-1 (ix)
   0A2C DD 77 F9      [19]  262 	ld	-7 (ix),a
                            263 ;src/Renderer.c:99: offset=offsets_cells_in_view[j];
   0A2F 3E B8         [ 7]  264 	ld	a,#<(_offsets_cells_in_view)
   0A31 DD 86 F8      [19]  265 	add	a, -8 (ix)
   0A34 6F            [ 4]  266 	ld	l,a
   0A35 3E 0A         [ 7]  267 	ld	a,#>(_offsets_cells_in_view)
   0A37 CE 00         [ 7]  268 	adc	a, #0x00
   0A39 67            [ 4]  269 	ld	h,a
   0A3A 7E            [ 7]  270 	ld	a,(hl)
                            271 ;src/Renderer.c:103: if(dx<0) x=x0-offset;
   0A3B DD 77 FA      [19]  272 	ld	-6 (ix), a
   0A3E DD 77 FB      [19]  273 	ld	-5 (ix),a
                            274 ;src/Renderer.c:101: if(vert){
   0A41 DD 7E F2      [19]  275 	ld	a,-14 (ix)
   0A44 B7            [ 4]  276 	or	a, a
   0A45 28 21         [12]  277 	jr	Z,00121$
                            278 ;src/Renderer.c:102: y-=dy;
   0A47 DD 7E F3      [19]  279 	ld	a,-13 (ix)
   0A4A DD 96 F4      [19]  280 	sub	a, -12 (ix)
   0A4D DD 77 F3      [19]  281 	ld	-13 (ix),a
                            282 ;src/Renderer.c:103: if(dx<0) x=x0-offset;
   0A50 DD 7E FE      [19]  283 	ld	a,-2 (ix)
   0A53 B7            [ 4]  284 	or	a, a
   0A54 28 09         [12]  285 	jr	Z,00115$
   0A56 DD 7E F6      [19]  286 	ld	a,-10 (ix)
   0A59 DD 96 FB      [19]  287 	sub	a, -5 (ix)
   0A5C 5F            [ 4]  288 	ld	e,a
   0A5D 18 24         [12]  289 	jr	00128$
   0A5F                     290 00115$:
                            291 ;src/Renderer.c:104: else x=x0+offset;
   0A5F DD 7E F6      [19]  292 	ld	a,-10 (ix)
   0A62 DD 86 FB      [19]  293 	add	a, -5 (ix)
   0A65 5F            [ 4]  294 	ld	e,a
   0A66 18 1B         [12]  295 	jr	00128$
   0A68                     296 00121$:
                            297 ;src/Renderer.c:108: x-=dx;
   0A68 7B            [ 4]  298 	ld	a,e
   0A69 DD 96 F5      [19]  299 	sub	a, -11 (ix)
   0A6C 5F            [ 4]  300 	ld	e,a
                            301 ;src/Renderer.c:109: if(dy<0) y=y0-offset;
   0A6D DD 7E FD      [19]  302 	ld	a,-3 (ix)
   0A70 B7            [ 4]  303 	or	a, a
   0A71 28 09         [12]  304 	jr	Z,00118$
   0A73 79            [ 4]  305 	ld	a,c
   0A74 DD 96 FB      [19]  306 	sub	a, -5 (ix)
   0A77 DD 77 F3      [19]  307 	ld	-13 (ix),a
   0A7A 18 07         [12]  308 	jr	00128$
   0A7C                     309 00118$:
                            310 ;src/Renderer.c:110: else y=y0+offset;
   0A7C 79            [ 4]  311 	ld	a,c
   0A7D DD 86 FB      [19]  312 	add	a, -5 (ix)
   0A80 DD 77 F3      [19]  313 	ld	-13 (ix),a
   0A83                     314 00128$:
                            315 ;src/Renderer.c:79: for(j=0;j<6;++j){
   0A83 DD 34 F8      [23]  316 	inc	-8 (ix)
   0A86 DD 7E F8      [19]  317 	ld	a,-8 (ix)
   0A89 D6 06         [ 7]  318 	sub	a, #0x06
   0A8B DA 89 09      [10]  319 	jp	C,00138$
   0A8E DD F9         [10]  320 	ld	sp, ix
   0A90 DD E1         [14]  321 	pop	ix
   0A92 C9            [10]  322 	ret
   0A93                     323 _g_palette:
   0A93 08                  324 	.db #0x08	; 8
   0A94 00                  325 	.db #0x00	; 0
   0A95 0D                  326 	.db #0x0D	; 13
   0A96 1A                  327 	.db #0x1A	; 26
   0A97 06                  328 	.db #0x06	; 6
   0A98 0F                  329 	.db #0x0F	; 15
   0A99 01                  330 	.db #0x01	; 1
   0A9A 09                  331 	.db #0x09	; 9
   0A9B 19                  332 	.db #0x19	; 25
   0A9C 03                  333 	.db #0x03	; 3
   0A9D 12                  334 	.db #0x12	; 18
   0A9E 05                  335 	.db #0x05	; 5
   0A9F 0E                  336 	.db #0x0E	; 14
   0AA0 0F                  337 	.db #0x0F	; 15
   0AA1 11                  338 	.db #0x11	; 17
   0AA2 13                  339 	.db #0x13	; 19
   0AA3                     340 _g_colors:
   0AA3 00                  341 	.db #0x00	; 0
   0AA4 C0                  342 	.db #0xC0	; 192
   0AA5 0C                  343 	.db #0x0C	; 12
   0AA6 CC                  344 	.db #0xCC	; 204
   0AA7 30                  345 	.db #0x30	; 48	'0'
   0AA8 F0                  346 	.db #0xF0	; 240
   0AA9 3C                  347 	.db #0x3C	; 60
   0AAA FC                  348 	.db #0xFC	; 252
   0AAB 03                  349 	.db #0x03	; 3
   0AAC C3                  350 	.db #0xC3	; 195
   0AAD 0F                  351 	.db #0x0F	; 15
   0AAE CF                  352 	.db #0xCF	; 207
   0AAF 33                  353 	.db #0x33	; 51	'3'
   0AB0 F3                  354 	.db #0xF3	; 243
   0AB1 3F                  355 	.db #0x3F	; 63
   0AB2 FF                  356 	.db #0xFF	; 255
   0AB3                     357 _g_pixelMask:
   0AB3 AA                  358 	.db #0xAA	; 170
   0AB4 55                  359 	.db #0x55	; 85	'U'
   0AB5                     360 _g_texturedWalls:
   0AB5 01                  361 	.db #0x01	; 1
   0AB6                     362 _cells_in_view_array:
   0AB6 A0 9E               363 	.dw #0x9EA0
   0AB8                     364 _offsets_cells_in_view:
   0AB8 08                  365 	.db #0x08	; 8
   0AB9 0C                  366 	.db #0x0C	; 12
   0ABA 0E                  367 	.db #0x0E	; 14
   0ABB 0F                  368 	.db #0x0F	; 15
   0ABC 10                  369 	.db #0x10	; 16
                            370 ;src/Renderer.c:118: void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
                            371 ;	---------------------------------
                            372 ; Function draw_column_to_buffer_untextured
                            373 ; ---------------------------------
   0ABD                     374 _draw_column_to_buffer_untextured::
   0ABD DD E5         [15]  375 	push	ix
   0ABF DD 21 00 00   [14]  376 	ld	ix,#0
   0AC3 DD 39         [15]  377 	add	ix,sp
   0AC5 F5            [11]  378 	push	af
                            379 ;src/Renderer.c:119: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   0AC6 DD 7E 04      [19]  380 	ld	a, 4 (ix)
   0AC9 CB 3F         [ 8]  381 	srl	a
   0ACB 4F            [ 4]  382 	ld	c,a
   0ACC 3E 00         [ 7]  383 	ld	a,#0x00
   0ACE C6 8B         [ 7]  384 	add	a,#0x8B
   0AD0 47            [ 4]  385 	ld	b,a
                            386 ;src/Renderer.c:121: u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
   0AD1 11 A3 0A      [10]  387 	ld	de,#_g_colors+0
   0AD4 DD 6E 06      [19]  388 	ld	l,6 (ix)
   0AD7 26 00         [ 7]  389 	ld	h,#0x00
   0AD9 19            [11]  390 	add	hl,de
   0ADA 7E            [ 7]  391 	ld	a,(hl)
   0ADB DD 77 FE      [19]  392 	ld	-2 (ix),a
                            393 ;src/Renderer.c:122: u8 pixMask = g_pixelMask[column&1];
   0ADE 11 B3 0A      [10]  394 	ld	de,#_g_pixelMask+0
   0AE1 DD 7E 04      [19]  395 	ld	a,4 (ix)
   0AE4 E6 01         [ 7]  396 	and	a, #0x01
   0AE6 6F            [ 4]  397 	ld	l,a
   0AE7 26 00         [ 7]  398 	ld	h,#0x00
   0AE9 19            [11]  399 	add	hl,de
   0AEA 5E            [ 7]  400 	ld	e,(hl)
                            401 ;src/Renderer.c:131: if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
   0AEB 3E 64         [ 7]  402 	ld	a,#0x64
   0AED DD 96 05      [19]  403 	sub	a, 5 (ix)
   0AF0 30 04         [12]  404 	jr	NC,00102$
   0AF2 DD 36 05 64   [19]  405 	ld	5 (ix),#0x64
   0AF6                     406 00102$:
                            407 ;src/Renderer.c:133: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   0AF6 DD 6E 05      [19]  408 	ld	l,5 (ix)
   0AF9 CB 3D         [ 8]  409 	srl	l
   0AFB 3E 32         [ 7]  410 	ld	a,#0x32
   0AFD 95            [ 4]  411 	sub	a, l
                            412 ;src/Renderer.c:136: pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
   0AFE D5            [11]  413 	push	de
   0AFF 5F            [ 4]  414 	ld	e,a
   0B00 16 00         [ 7]  415 	ld	d,#0x00
   0B02 6B            [ 4]  416 	ld	l, e
   0B03 62            [ 4]  417 	ld	h, d
   0B04 29            [11]  418 	add	hl, hl
   0B05 29            [11]  419 	add	hl, hl
   0B06 19            [11]  420 	add	hl, de
   0B07 29            [11]  421 	add	hl, hl
   0B08 29            [11]  422 	add	hl, hl
   0B09 29            [11]  423 	add	hl, hl
   0B0A D1            [10]  424 	pop	de
   0B0B 09            [11]  425 	add	hl,bc
   0B0C 4D            [ 4]  426 	ld	c,l
   0B0D 44            [ 4]  427 	ld	b,h
                            428 ;src/Renderer.c:138: j=lineHeight;
   0B0E DD 56 05      [19]  429 	ld	d,5 (ix)
                            430 ;src/Renderer.c:140: for(j;j;--j){
   0B11 7B            [ 4]  431 	ld	a,e
   0B12 2F            [ 4]  432 	cpl
   0B13 DD 77 FF      [19]  433 	ld	-1 (ix),a
   0B16 7B            [ 4]  434 	ld	a,e
   0B17 DD A6 FE      [19]  435 	and	a, -2 (ix)
   0B1A 5F            [ 4]  436 	ld	e,a
   0B1B                     437 00105$:
   0B1B 7A            [ 4]  438 	ld	a,d
   0B1C B7            [ 4]  439 	or	a, a
   0B1D 28 0F         [12]  440 	jr	Z,00107$
                            441 ;src/Renderer.c:141: val =  ((*pvmem)&(~pixMask));
   0B1F 0A            [ 7]  442 	ld	a,(bc)
   0B20 DD A6 FF      [19]  443 	and	a, -1 (ix)
                            444 ;src/Renderer.c:143: *pvmem = val|(w_color&pixMask);
   0B23 B3            [ 4]  445 	or	a, e
   0B24 02            [ 7]  446 	ld	(bc),a
                            447 ;src/Renderer.c:145: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   0B25 21 28 00      [10]  448 	ld	hl,#0x0028
   0B28 09            [11]  449 	add	hl,bc
   0B29 4D            [ 4]  450 	ld	c,l
   0B2A 44            [ 4]  451 	ld	b,h
                            452 ;src/Renderer.c:140: for(j;j;--j){
   0B2B 15            [ 4]  453 	dec	d
   0B2C 18 ED         [12]  454 	jr	00105$
   0B2E                     455 00107$:
   0B2E DD F9         [10]  456 	ld	sp, ix
   0B30 DD E1         [14]  457 	pop	ix
   0B32 C9            [10]  458 	ret
                            459 ;src/Renderer.c:149: void draw_column_to_buffer_object(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            460 ;	---------------------------------
                            461 ; Function draw_column_to_buffer_object
                            462 ; ---------------------------------
   0B33                     463 _draw_column_to_buffer_object::
                            464 ;src/Renderer.c:151: }
   0B33 C9            [10]  465 	ret
                            466 ;src/Renderer.c:153: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            467 ;	---------------------------------
                            468 ; Function draw_column_to_buffer_enemy
                            469 ; ---------------------------------
   0B34                     470 _draw_column_to_buffer_enemy::
   0B34 DD E5         [15]  471 	push	ix
   0B36 DD 21 00 00   [14]  472 	ld	ix,#0
   0B3A DD 39         [15]  473 	add	ix,sp
   0B3C 21 F2 FF      [10]  474 	ld	hl,#-14
   0B3F 39            [11]  475 	add	hl,sp
   0B40 F9            [ 6]  476 	ld	sp,hl
                            477 ;src/Renderer.c:170: u16 texture_line=0;
   0B41 21 00 00      [10]  478 	ld	hl,#0x0000
   0B44 E3            [19]  479 	ex	(sp), hl
                            480 ;src/Renderer.c:172: if(texture_column>=4 && texture_column<28){
   0B45 DD 7E 07      [19]  481 	ld	a,7 (ix)
   0B48 D6 04         [ 7]  482 	sub	a, #0x04
   0B4A DA 6C 0C      [10]  483 	jp	C,00112$
   0B4D DD 7E 07      [19]  484 	ld	a,7 (ix)
   0B50 D6 1C         [ 7]  485 	sub	a, #0x1C
   0B52 D2 6C 0C      [10]  486 	jp	NC,00112$
                            487 ;src/Renderer.c:175: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(index-1)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
   0B55 DD 4E 06      [19]  488 	ld	c,6 (ix)
   0B58 06 00         [ 7]  489 	ld	b,#0x00
   0B5A 0B            [ 6]  490 	dec	bc
   0B5B 69            [ 4]  491 	ld	l, c
   0B5C 60            [ 4]  492 	ld	h, b
   0B5D 29            [11]  493 	add	hl, hl
   0B5E 29            [11]  494 	add	hl, hl
   0B5F 29            [11]  495 	add	hl, hl
   0B60 09            [11]  496 	add	hl, bc
   0B61 29            [11]  497 	add	hl, hl
   0B62 29            [11]  498 	add	hl, hl
   0B63 29            [11]  499 	add	hl, hl
   0B64 29            [11]  500 	add	hl, hl
   0B65 29            [11]  501 	add	hl, hl
   0B66 29            [11]  502 	add	hl, hl
   0B67 01 00 78      [10]  503 	ld	bc,#0x7800
   0B6A 09            [11]  504 	add	hl,bc
   0B6B 4D            [ 4]  505 	ld	c,l
   0B6C 44            [ 4]  506 	ld	b,h
   0B6D DD 7E 07      [19]  507 	ld	a, 7 (ix)
   0B70 16 00         [ 7]  508 	ld	d, #0x00
   0B72 C6 FC         [ 7]  509 	add	a,#0xFC
   0B74 5F            [ 4]  510 	ld	e,a
   0B75 7A            [ 4]  511 	ld	a,d
   0B76 CE FF         [ 7]  512 	adc	a,#0xFF
   0B78 57            [ 4]  513 	ld	d,a
   0B79 6B            [ 4]  514 	ld	l, e
   0B7A 62            [ 4]  515 	ld	h, d
   0B7B 29            [11]  516 	add	hl, hl
   0B7C 19            [11]  517 	add	hl, de
   0B7D 29            [11]  518 	add	hl, hl
   0B7E 29            [11]  519 	add	hl, hl
   0B7F 29            [11]  520 	add	hl, hl
   0B80 09            [11]  521 	add	hl,bc
   0B81 DD 75 F7      [19]  522 	ld	-9 (ix),l
   0B84 DD 74 F8      [19]  523 	ld	-8 (ix),h
                            524 ;src/Renderer.c:177: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   0B87 DD 7E 04      [19]  525 	ld	a,4 (ix)
   0B8A CB 3F         [ 8]  526 	srl	a
   0B8C C6 00         [ 7]  527 	add	a, #0x00
   0B8E DD 77 FA      [19]  528 	ld	-6 (ix),a
   0B91 3E 00         [ 7]  529 	ld	a,#0x00
   0B93 CE 8B         [ 7]  530 	adc	a, #0x8B
   0B95 DD 77 FB      [19]  531 	ld	-5 (ix),a
                            532 ;src/Renderer.c:179: pixMask = g_pixelMask[column&1];
   0B98 01 B3 0A      [10]  533 	ld	bc,#_g_pixelMask+0
   0B9B DD 7E 04      [19]  534 	ld	a,4 (ix)
   0B9E E6 01         [ 7]  535 	and	a, #0x01
   0BA0 6F            [ 4]  536 	ld	l, a
   0BA1 26 00         [ 7]  537 	ld	h,#0x00
   0BA3 09            [11]  538 	add	hl,bc
   0BA4 7E            [ 7]  539 	ld	a,(hl)
   0BA5 DD 77 F9      [19]  540 	ld	-7 (ix),a
                            541 ;src/Renderer.c:181: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
   0BA8 DD 7E 05      [19]  542 	ld	a,5 (ix)
   0BAB CB 3F         [ 8]  543 	srl	a
   0BAD C6 32         [ 7]  544 	add	a, #0x32
   0BAF DD 77 F6      [19]  545 	ld	-10 (ix),a
                            546 ;src/Renderer.c:182: lineHeight = (lineHeight*3)/4;
   0BB2 DD 4E 05      [19]  547 	ld	c,5 (ix)
   0BB5 06 00         [ 7]  548 	ld	b,#0x00
   0BB7 69            [ 4]  549 	ld	l, c
   0BB8 60            [ 4]  550 	ld	h, b
   0BB9 29            [11]  551 	add	hl, hl
   0BBA 09            [11]  552 	add	hl, bc
   0BBB DD 75 FE      [19]  553 	ld	-2 (ix),l
   0BBE DD 74 FF      [19]  554 	ld	-1 (ix),h
   0BC1 DD 7E FE      [19]  555 	ld	a,-2 (ix)
   0BC4 DD 77 FC      [19]  556 	ld	-4 (ix),a
   0BC7 DD 7E FF      [19]  557 	ld	a,-1 (ix)
   0BCA DD 77 FD      [19]  558 	ld	-3 (ix),a
   0BCD DD CB FF 7E   [20]  559 	bit	7, -1 (ix)
   0BD1 28 10         [12]  560 	jr	Z,00114$
   0BD3 DD 7E FE      [19]  561 	ld	a,-2 (ix)
   0BD6 C6 03         [ 7]  562 	add	a, #0x03
   0BD8 DD 77 FC      [19]  563 	ld	-4 (ix),a
   0BDB DD 7E FF      [19]  564 	ld	a,-1 (ix)
   0BDE CE 00         [ 7]  565 	adc	a, #0x00
   0BE0 DD 77 FD      [19]  566 	ld	-3 (ix),a
   0BE3                     567 00114$:
   0BE3 DD 46 FC      [19]  568 	ld	b,-4 (ix)
   0BE6 DD 4E FD      [19]  569 	ld	c,-3 (ix)
   0BE9 CB 29         [ 8]  570 	sra	c
   0BEB CB 18         [ 8]  571 	rr	b
   0BED CB 29         [ 8]  572 	sra	c
   0BEF CB 18         [ 8]  573 	rr	b
                            574 ;src/Renderer.c:183: enemy_top_height = ground_height - lineHeight;
   0BF1 DD 7E F6      [19]  575 	ld	a,-10 (ix)
   0BF4 90            [ 4]  576 	sub	a, b
   0BF5 4F            [ 4]  577 	ld	c,a
                            578 ;src/Renderer.c:185: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
   0BF6 58            [ 4]  579 	ld	e,b
   0BF7 16 00         [ 7]  580 	ld	d,#0x00
   0BF9 C5            [11]  581 	push	bc
   0BFA D5            [11]  582 	push	de
   0BFB 21 00 18      [10]  583 	ld	hl,#0x1800
   0BFE E5            [11]  584 	push	hl
   0BFF CD 84 49      [17]  585 	call	__divsint
   0C02 F1            [10]  586 	pop	af
   0C03 F1            [10]  587 	pop	af
   0C04 C1            [10]  588 	pop	bc
   0C05 DD 75 F4      [19]  589 	ld	-12 (ix),l
   0C08 DD 74 F5      [19]  590 	ld	-11 (ix),h
                            591 ;src/Renderer.c:186: j=lineHeight;
   0C0B 50            [ 4]  592 	ld	d,b
                            593 ;src/Renderer.c:188: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   0C0C 3E 64         [ 7]  594 	ld	a,#0x64
   0C0E 90            [ 4]  595 	sub	a, b
   0C0F 30 02         [12]  596 	jr	NC,00102$
                            597 ;src/Renderer.c:189: j=90;
   0C11 16 5A         [ 7]  598 	ld	d,#0x5A
   0C13                     599 00102$:
                            600 ;src/Renderer.c:192: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
   0C13 06 00         [ 7]  601 	ld	b,#0x00
   0C15 69            [ 4]  602 	ld	l, c
   0C16 60            [ 4]  603 	ld	h, b
   0C17 29            [11]  604 	add	hl, hl
   0C18 29            [11]  605 	add	hl, hl
   0C19 09            [11]  606 	add	hl, bc
   0C1A 29            [11]  607 	add	hl, hl
   0C1B 29            [11]  608 	add	hl, hl
   0C1C 29            [11]  609 	add	hl, hl
   0C1D DD 7E FA      [19]  610 	ld	a,-6 (ix)
   0C20 85            [ 4]  611 	add	a, l
   0C21 4F            [ 4]  612 	ld	c,a
   0C22 DD 7E FB      [19]  613 	ld	a,-5 (ix)
   0C25 8C            [ 4]  614 	adc	a, h
   0C26 47            [ 4]  615 	ld	b,a
                            616 ;src/Renderer.c:194: for(j;j;--j){
   0C27 DD 7E F9      [19]  617 	ld	a,-7 (ix)
   0C2A 2F            [ 4]  618 	cpl
   0C2B 5F            [ 4]  619 	ld	e,a
   0C2C                     620 00110$:
   0C2C 7A            [ 4]  621 	ld	a,d
   0C2D B7            [ 4]  622 	or	a, a
   0C2E 28 3C         [12]  623 	jr	Z,00112$
                            624 ;src/Renderer.c:196: color= *(texture+(texture_line/256));
   0C30 DD 6E F3      [19]  625 	ld	l,-13 (ix)
   0C33 26 00         [ 7]  626 	ld	h,#0x00
   0C35 DD 7E F7      [19]  627 	ld	a,-9 (ix)
   0C38 85            [ 4]  628 	add	a, l
   0C39 6F            [ 4]  629 	ld	l,a
   0C3A DD 7E F8      [19]  630 	ld	a,-8 (ix)
   0C3D 8C            [ 4]  631 	adc	a, h
   0C3E 67            [ 4]  632 	ld	h,a
   0C3F 7E            [ 7]  633 	ld	a,(hl)
                            634 ;src/Renderer.c:198: if(color){
   0C40 DD 77 FC      [19]  635 	ld	-4 (ix), a
   0C43 B7            [ 4]  636 	or	a, a
   0C44 28 0B         [12]  637 	jr	Z,00104$
                            638 ;src/Renderer.c:199: val =  ((*pvmem)&(~pixMask));
   0C46 0A            [ 7]  639 	ld	a,(bc)
   0C47 A3            [ 4]  640 	and	a, e
   0C48 6F            [ 4]  641 	ld	l,a
                            642 ;src/Renderer.c:201: color = (color&pixMask);
   0C49 DD 7E FC      [19]  643 	ld	a,-4 (ix)
   0C4C DD A6 F9      [19]  644 	and	a, -7 (ix)
                            645 ;src/Renderer.c:203: *pvmem = val|color;
   0C4F B5            [ 4]  646 	or	a, l
   0C50 02            [ 7]  647 	ld	(bc),a
   0C51                     648 00104$:
                            649 ;src/Renderer.c:206: texture_line += texture_line_add;
   0C51 DD 7E F2      [19]  650 	ld	a,-14 (ix)
   0C54 DD 86 F4      [19]  651 	add	a, -12 (ix)
   0C57 DD 77 F2      [19]  652 	ld	-14 (ix),a
   0C5A DD 7E F3      [19]  653 	ld	a,-13 (ix)
   0C5D DD 8E F5      [19]  654 	adc	a, -11 (ix)
   0C60 DD 77 F3      [19]  655 	ld	-13 (ix),a
                            656 ;src/Renderer.c:208: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   0C63 21 28 00      [10]  657 	ld	hl,#0x0028
   0C66 09            [11]  658 	add	hl,bc
   0C67 4D            [ 4]  659 	ld	c,l
   0C68 44            [ 4]  660 	ld	b,h
                            661 ;src/Renderer.c:194: for(j;j;--j){
   0C69 15            [ 4]  662 	dec	d
   0C6A 18 C0         [12]  663 	jr	00110$
   0C6C                     664 00112$:
   0C6C DD F9         [10]  665 	ld	sp, ix
   0C6E DD E1         [14]  666 	pop	ix
   0C70 C9            [10]  667 	ret
                            668 ;src/Renderer.c:214: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
                            669 ;	---------------------------------
                            670 ; Function draw_column_to_buffer
                            671 ; ---------------------------------
   0C71                     672 _draw_column_to_buffer::
   0C71 DD E5         [15]  673 	push	ix
   0C73 DD 21 00 00   [14]  674 	ld	ix,#0
   0C77 DD 39         [15]  675 	add	ix,sp
   0C79 21 F1 FF      [10]  676 	ld	hl,#-15
   0C7C 39            [11]  677 	add	hl,sp
   0C7D F9            [ 6]  678 	ld	sp,hl
                            679 ;src/Renderer.c:215: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   0C7E DD 7E 04      [19]  680 	ld	a,4 (ix)
   0C81 CB 3F         [ 8]  681 	srl	a
   0C83 C6 00         [ 7]  682 	add	a, #0x00
   0C85 DD 77 FE      [19]  683 	ld	-2 (ix),a
   0C88 3E 00         [ 7]  684 	ld	a,#0x00
   0C8A CE 8B         [ 7]  685 	adc	a, #0x8B
   0C8C DD 77 FF      [19]  686 	ld	-1 (ix),a
                            687 ;src/Renderer.c:218: u8 pixMask = g_pixelMask[column&1];
   0C8F 01 B3 0A      [10]  688 	ld	bc,#_g_pixelMask+0
   0C92 DD 7E 04      [19]  689 	ld	a,4 (ix)
   0C95 E6 01         [ 7]  690 	and	a, #0x01
   0C97 6F            [ 4]  691 	ld	l, a
   0C98 26 00         [ 7]  692 	ld	h,#0x00
   0C9A 09            [11]  693 	add	hl,bc
   0C9B 7E            [ 7]  694 	ld	a,(hl)
   0C9C DD 77 F1      [19]  695 	ld	-15 (ix),a
                            696 ;src/Renderer.c:223: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
   0C9F DD 7E 06      [19]  697 	ld	a, 6 (ix)
   0CA2 87            [ 4]  698 	add	a, a
   0CA3 87            [ 4]  699 	add	a, a
   0CA4 47            [ 4]  700 	ld	b,a
   0CA5 0E 00         [ 7]  701 	ld	c,#0x00
   0CA7 21 00 64      [10]  702 	ld	hl,#0x6400
   0CAA 09            [11]  703 	add	hl,bc
   0CAB 4D            [ 4]  704 	ld	c,l
   0CAC 44            [ 4]  705 	ld	b,h
   0CAD DD 6E 07      [19]  706 	ld	l,7 (ix)
   0CB0 26 00         [ 7]  707 	ld	h,#0x00
   0CB2 29            [11]  708 	add	hl, hl
   0CB3 29            [11]  709 	add	hl, hl
   0CB4 29            [11]  710 	add	hl, hl
   0CB5 29            [11]  711 	add	hl, hl
   0CB6 29            [11]  712 	add	hl, hl
   0CB7 09            [11]  713 	add	hl,bc
   0CB8 DD 75 F6      [19]  714 	ld	-10 (ix),l
   0CBB DD 74 F7      [19]  715 	ld	-9 (ix),h
                            716 ;src/Renderer.c:225: u8 j=lineHeight;
   0CBE DD 7E 05      [19]  717 	ld	a,5 (ix)
                            718 ;src/Renderer.c:231: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
   0CC1 DD 77 F5      [19]  719 	ld	-11 (ix), a
   0CC4 DD 77 FC      [19]  720 	ld	-4 (ix),a
   0CC7 DD 36 FD 00   [19]  721 	ld	-3 (ix),#0x00
   0CCB DD 6E FC      [19]  722 	ld	l,-4 (ix)
   0CCE DD 66 FD      [19]  723 	ld	h,-3 (ix)
   0CD1 E5            [11]  724 	push	hl
   0CD2 21 00 20      [10]  725 	ld	hl,#0x2000
   0CD5 E5            [11]  726 	push	hl
   0CD6 CD 84 49      [17]  727 	call	__divsint
   0CD9 F1            [10]  728 	pop	af
   0CDA F1            [10]  729 	pop	af
   0CDB DD 75 F2      [19]  730 	ld	-14 (ix),l
   0CDE DD 74 F3      [19]  731 	ld	-13 (ix),h
                            732 ;src/Renderer.c:232: u16 wall_texture_line=0;
   0CE1 DD 36 F8 00   [19]  733 	ld	-8 (ix),#0x00
   0CE5 DD 36 F9 00   [19]  734 	ld	-7 (ix),#0x00
                            735 ;src/Renderer.c:234: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   0CE9 DD 4E F5      [19]  736 	ld	c,-11 (ix)
   0CEC CB 39         [ 8]  737 	srl	c
   0CEE 3E 32         [ 7]  738 	ld	a,#0x32
   0CF0 91            [ 4]  739 	sub	a, c
   0CF1 DD 77 F4      [19]  740 	ld	-12 (ix),a
                            741 ;src/Renderer.c:238: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   0CF4 3E 64         [ 7]  742 	ld	a,#0x64
   0CF6 DD 96 F5      [19]  743 	sub	a, -11 (ix)
   0CF9 30 4B         [12]  744 	jr	NC,00102$
                            745 ;src/Renderer.c:239: ceiling_height=0;
   0CFB DD 36 F4 00   [19]  746 	ld	-12 (ix),#0x00
                            747 ;src/Renderer.c:240: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
   0CFF DD 7E FC      [19]  748 	ld	a,-4 (ix)
   0D02 C6 9C         [ 7]  749 	add	a,#0x9C
   0D04 4F            [ 4]  750 	ld	c,a
   0D05 DD 7E FD      [19]  751 	ld	a,-3 (ix)
   0D08 CE FF         [ 7]  752 	adc	a,#0xFF
   0D0A 47            [ 4]  753 	ld	b,a
   0D0B DD 71 FA      [19]  754 	ld	-6 (ix),c
   0D0E DD 70 FB      [19]  755 	ld	-5 (ix),b
   0D11 CB 78         [ 8]  756 	bit	7, b
   0D13 28 10         [12]  757 	jr	Z,00111$
   0D15 DD 7E FC      [19]  758 	ld	a,-4 (ix)
   0D18 C6 9D         [ 7]  759 	add	a, #0x9D
   0D1A DD 77 FA      [19]  760 	ld	-6 (ix),a
   0D1D DD 7E FD      [19]  761 	ld	a,-3 (ix)
   0D20 CE FF         [ 7]  762 	adc	a, #0xFF
   0D22 DD 77 FB      [19]  763 	ld	-5 (ix),a
   0D25                     764 00111$:
   0D25 DD 4E FA      [19]  765 	ld	c,-6 (ix)
   0D28 DD 46 FB      [19]  766 	ld	b,-5 (ix)
   0D2B CB 28         [ 8]  767 	sra	b
   0D2D CB 19         [ 8]  768 	rr	c
   0D2F DD 6E F2      [19]  769 	ld	l,-14 (ix)
   0D32 DD 66 F3      [19]  770 	ld	h,-13 (ix)
   0D35 E5            [11]  771 	push	hl
   0D36 C5            [11]  772 	push	bc
   0D37 CD 46 48      [17]  773 	call	__mulint
   0D3A F1            [10]  774 	pop	af
   0D3B F1            [10]  775 	pop	af
   0D3C DD 75 F8      [19]  776 	ld	-8 (ix),l
   0D3F DD 74 F9      [19]  777 	ld	-7 (ix),h
                            778 ;src/Renderer.c:241: j=SCREEN_TEXTURE_HEIGHT;
   0D42 DD 36 F5 64   [19]  779 	ld	-11 (ix),#0x64
   0D46                     780 00102$:
                            781 ;src/Renderer.c:244: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
   0D46 DD 4E F4      [19]  782 	ld	c,-12 (ix)
   0D49 06 00         [ 7]  783 	ld	b,#0x00
   0D4B 69            [ 4]  784 	ld	l, c
   0D4C 60            [ 4]  785 	ld	h, b
   0D4D 29            [11]  786 	add	hl, hl
   0D4E 29            [11]  787 	add	hl, hl
   0D4F 09            [11]  788 	add	hl, bc
   0D50 29            [11]  789 	add	hl, hl
   0D51 29            [11]  790 	add	hl, hl
   0D52 29            [11]  791 	add	hl, hl
   0D53 DD 7E FE      [19]  792 	ld	a,-2 (ix)
   0D56 85            [ 4]  793 	add	a, l
   0D57 4F            [ 4]  794 	ld	c,a
   0D58 DD 7E FF      [19]  795 	ld	a,-1 (ix)
   0D5B 8C            [ 4]  796 	adc	a, h
   0D5C 47            [ 4]  797 	ld	b,a
                            798 ;src/Renderer.c:246: for(j;j;--j){
   0D5D DD 7E F1      [19]  799 	ld	a,-15 (ix)
   0D60 2F            [ 4]  800 	cpl
   0D61 DD 77 FA      [19]  801 	ld	-6 (ix),a
   0D64 DD 56 F5      [19]  802 	ld	d,-11 (ix)
   0D67                     803 00107$:
   0D67 7A            [ 4]  804 	ld	a,d
   0D68 B7            [ 4]  805 	or	a, a
   0D69 28 39         [12]  806 	jr	Z,00109$
                            807 ;src/Renderer.c:248: w_color = *(texture+(wall_texture_line/256));
   0D6B DD 7E F9      [19]  808 	ld	a, -7 (ix)
   0D6E 26 00         [ 7]  809 	ld	h, #0x00
   0D70 DD 86 F6      [19]  810 	add	a, -10 (ix)
   0D73 6F            [ 4]  811 	ld	l,a
   0D74 7C            [ 4]  812 	ld	a,h
   0D75 DD 8E F7      [19]  813 	adc	a, -9 (ix)
   0D78 67            [ 4]  814 	ld	h,a
   0D79 5E            [ 7]  815 	ld	e,(hl)
                            816 ;src/Renderer.c:250: if(w_color){
   0D7A 7B            [ 4]  817 	ld	a,e
   0D7B B7            [ 4]  818 	or	a, a
   0D7C 28 0B         [12]  819 	jr	Z,00104$
                            820 ;src/Renderer.c:252: val =  ((*pvmem)&(~pixMask));
   0D7E 0A            [ 7]  821 	ld	a,(bc)
   0D7F DD A6 FA      [19]  822 	and	a, -6 (ix)
   0D82 6F            [ 4]  823 	ld	l,a
                            824 ;src/Renderer.c:254: w_color = (w_color&pixMask);
   0D83 7B            [ 4]  825 	ld	a,e
   0D84 DD A6 F1      [19]  826 	and	a, -15 (ix)
                            827 ;src/Renderer.c:256: *pvmem = val|w_color;
   0D87 B5            [ 4]  828 	or	a, l
   0D88 02            [ 7]  829 	ld	(bc),a
   0D89                     830 00104$:
                            831 ;src/Renderer.c:260: wall_texture_line += wall_texture_line_add;
   0D89 DD 7E F8      [19]  832 	ld	a,-8 (ix)
   0D8C DD 86 F2      [19]  833 	add	a, -14 (ix)
   0D8F DD 77 F8      [19]  834 	ld	-8 (ix),a
   0D92 DD 7E F9      [19]  835 	ld	a,-7 (ix)
   0D95 DD 8E F3      [19]  836 	adc	a, -13 (ix)
   0D98 DD 77 F9      [19]  837 	ld	-7 (ix),a
                            838 ;src/Renderer.c:262: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   0D9B 21 28 00      [10]  839 	ld	hl,#0x0028
   0D9E 09            [11]  840 	add	hl,bc
   0D9F 4D            [ 4]  841 	ld	c,l
   0DA0 44            [ 4]  842 	ld	b,h
                            843 ;src/Renderer.c:246: for(j;j;--j){
   0DA1 15            [ 4]  844 	dec	d
   0DA2 18 C3         [12]  845 	jr	00107$
   0DA4                     846 00109$:
   0DA4 DD F9         [10]  847 	ld	sp, ix
   0DA6 DD E1         [14]  848 	pop	ix
   0DA8 C9            [10]  849 	ret
                            850 ;src/Renderer.c:266: void render_draw_to_buffer(){//TODO Optimize
                            851 ;	---------------------------------
                            852 ; Function render_draw_to_buffer
                            853 ; ---------------------------------
   0DA9                     854 _render_draw_to_buffer::
   0DA9 DD E5         [15]  855 	push	ix
   0DAB DD 21 00 00   [14]  856 	ld	ix,#0
   0DAF DD 39         [15]  857 	add	ix,sp
   0DB1 21 C6 FF      [10]  858 	ld	hl,#-58
   0DB4 39            [11]  859 	add	hl,sp
   0DB5 F9            [ 6]  860 	ld	sp,hl
                            861 ;src/Renderer.c:276: u8 zHeight = 5;
   0DB6 DD 36 C8 05   [19]  862 	ld	-56 (ix),#0x05
                            863 ;src/Renderer.c:282: u8 offsetDiff = 16;
   0DBA DD 36 CE 10   [19]  864 	ld	-50 (ix),#0x10
                            865 ;src/Renderer.c:287: u8 lineStart = 0;
   0DBE DD 36 CC 00   [19]  866 	ld	-52 (ix),#0x00
                            867 ;src/Renderer.c:289: u8 lateralWallWidth=0;
   0DC2 DD 36 CB 00   [19]  868 	ld	-53 (ix),#0x00
                            869 ;src/Renderer.c:301: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   0DC6 21 A9 0A      [10]  870 	ld	hl, #_g_colors + 6
   0DC9 46            [ 7]  871 	ld	b,(hl)
   0DCA 21 A8 07      [10]  872 	ld	hl,#0x07A8
   0DCD E5            [11]  873 	push	hl
   0DCE C5            [11]  874 	push	bc
   0DCF 33            [ 6]  875 	inc	sp
   0DD0 21 00 8B      [10]  876 	ld	hl,#0x8B00
   0DD3 E5            [11]  877 	push	hl
   0DD4 CD A5 48      [17]  878 	call	_cpct_memset
                            879 ;src/Renderer.c:302: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
   0DD7 21 A4 0A      [10]  880 	ld	hl, #_g_colors + 1
   0DDA 46            [ 7]  881 	ld	b,(hl)
   0DDB 21 50 00      [10]  882 	ld	hl,#0x0050
   0DDE E5            [11]  883 	push	hl
   0DDF C5            [11]  884 	push	bc
   0DE0 33            [ 6]  885 	inc	sp
   0DE1 21 A8 92      [10]  886 	ld	hl,#0x92A8
   0DE4 E5            [11]  887 	push	hl
   0DE5 CD A5 48      [17]  888 	call	_cpct_memset
                            889 ;src/Renderer.c:303: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   0DE8 21 AA 0A      [10]  890 	ld	hl, #_g_colors + 7
   0DEB 46            [ 7]  891 	ld	b,(hl)
   0DEC 21 A8 07      [10]  892 	ld	hl,#0x07A8
   0DEF E5            [11]  893 	push	hl
   0DF0 C5            [11]  894 	push	bc
   0DF1 33            [ 6]  895 	inc	sp
   0DF2 21 F8 92      [10]  896 	ld	hl,#0x92F8
   0DF5 E5            [11]  897 	push	hl
   0DF6 CD A5 48      [17]  898 	call	_cpct_memset
                            899 ;src/Renderer.c:305: calculate_cells_in_view();
   0DF9 CD E7 08      [17]  900 	call	_calculate_cells_in_view
                            901 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   0DFC 2A B6 0A      [16]  902 	ld	hl,(_cells_in_view_array)
   0DFF DD 75 E8      [19]  903 	ld	-24 (ix),l
   0E02 DD 74 E9      [19]  904 	ld	-23 (ix),h
                            905 ;src/Renderer.c:307: if(g_texturedWalls){
   0E05 3A B5 0A      [13]  906 	ld	a,(#_g_texturedWalls + 0)
   0E08 B7            [ 4]  907 	or	a, a
   0E09 CA 51 13      [10]  908 	jp	Z,00358$
                            909 ;src/Renderer.c:309: do{
   0E0C DD 36 C6 06   [19]  910 	ld	-58 (ix),#0x06
   0E10                     911 00175$:
                            912 ;src/Renderer.c:311: --z;
   0E10 DD 35 C6      [23]  913 	dec	-58 (ix)
                            914 ;src/Renderer.c:315: xCellCount = (z) ? (zHeight >> 1) : 0;
   0E13 DD 7E C8      [19]  915 	ld	a,-56 (ix)
   0E16 CB 3F         [ 8]  916 	srl	a
   0E18 DD 77 EE      [19]  917 	ld	-18 (ix),a
   0E1B DD 7E C6      [19]  918 	ld	a,-58 (ix)
   0E1E B7            [ 4]  919 	or	a, a
   0E1F 28 05         [12]  920 	jr	Z,00262$
   0E21 DD 4E EE      [19]  921 	ld	c,-18 (ix)
   0E24 18 02         [12]  922 	jr	00263$
   0E26                     923 00262$:
   0E26 0E 00         [ 7]  924 	ld	c,#0x00
   0E28                     925 00263$:
   0E28 DD 71 F1      [19]  926 	ld	-15 (ix),c
                            927 ;src/Renderer.c:316: lateralWallSlope=0;
   0E2B DD 36 F3 00   [19]  928 	ld	-13 (ix),#0x00
                            929 ;src/Renderer.c:317: lateralWallSlopeCounter=0;
   0E2F DD 36 FB 00   [19]  930 	ld	-5 (ix),#0x00
                            931 ;src/Renderer.c:318: xHeight=0;
   0E33 DD 36 E0 00   [19]  932 	ld	-32 (ix),#0x00
                            933 ;src/Renderer.c:320: lateralWallCounter = 0;
   0E37 DD 36 D7 00   [19]  934 	ld	-41 (ix),#0x00
                            935 ;src/Renderer.c:322: newCell=1;
   0E3B DD 36 DB 01   [19]  936 	ld	-37 (ix),#0x01
                            937 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   0E3F DD 7E CC      [19]  938 	ld	a,-52 (ix)
   0E42 DD 77 E2      [19]  939 	ld	-30 (ix),a
   0E45 DD 36 E3 00   [19]  940 	ld	-29 (ix),#0x00
   0E49 DD 4E E2      [19]  941 	ld	c,-30 (ix)
   0E4C DD 46 E3      [19]  942 	ld	b,-29 (ix)
   0E4F 03            [ 6]  943 	inc	bc
   0E50 DD 6E E8      [19]  944 	ld	l,-24 (ix)
   0E53 DD 66 E9      [19]  945 	ld	h,-23 (ix)
   0E56 09            [11]  946 	add	hl,bc
   0E57 7E            [ 7]  947 	ld	a,(hl)
   0E58 DD 77 DA      [19]  948 	ld	-38 (ix),a
                            949 ;src/Renderer.c:325: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   0E5B DD 7E E8      [19]  950 	ld	a,-24 (ix)
   0E5E DD 86 CC      [19]  951 	add	a, -52 (ix)
   0E61 6F            [ 4]  952 	ld	l,a
   0E62 DD 7E E9      [19]  953 	ld	a,-23 (ix)
   0E65 CE 00         [ 7]  954 	adc	a, #0x00
   0E67 67            [ 4]  955 	ld	h,a
   0E68 4E            [ 7]  956 	ld	c,(hl)
                            957 ;src/Renderer.c:326: if(lastCellWasWall&CELL_WALL_MASK){
   0E69 CB 79         [ 8]  958 	bit	7, c
   0E6B 28 09         [12]  959 	jr	Z,00102$
                            960 ;src/Renderer.c:327: lastWallId=lastCellWasWall;
   0E6D DD 71 DE      [19]  961 	ld	-34 (ix),c
                            962 ;src/Renderer.c:328: lastCellWasWall=1;
   0E70 DD 36 E1 01   [19]  963 	ld	-31 (ix),#0x01
   0E74 18 08         [12]  964 	jr	00296$
   0E76                     965 00102$:
                            966 ;src/Renderer.c:331: lastCellWasWall=0;
   0E76 DD 36 E1 00   [19]  967 	ld	-31 (ix),#0x00
                            968 ;src/Renderer.c:332: lastWallId=CELLTYPE_FLOOR;
   0E7A DD 36 DE 00   [19]  969 	ld	-34 (ix),#0x00
                            970 ;src/Renderer.c:335: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   0E7E                     971 00296$:
   0E7E DD 36 CA 00   [19]  972 	ld	-54 (ix),#0x00
   0E82 DD 36 C7 00   [19]  973 	ld	-57 (ix),#0x00
   0E86                     974 00252$:
                            975 ;src/Renderer.c:337: if (xCellCount == zHeight)
   0E86 DD 7E C8      [19]  976 	ld	a,-56 (ix)
   0E89 DD 96 F1      [19]  977 	sub	a, -15 (ix)
   0E8C 20 4B         [12]  978 	jr	NZ,00105$
                            979 ;src/Renderer.c:339: ++xCell;
   0E8E DD 34 CA      [23]  980 	inc	-54 (ix)
                            981 ;src/Renderer.c:340: xCellCount = 0;
   0E91 DD 36 F1 00   [19]  982 	ld	-15 (ix),#0x00
                            983 ;src/Renderer.c:341: newCell=1;
   0E95 DD 36 DB 01   [19]  984 	ld	-37 (ix),#0x01
                            985 ;src/Renderer.c:342: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   0E99 DD 7E CA      [19]  986 	ld	a,-54 (ix)
   0E9C DD 77 E6      [19]  987 	ld	-26 (ix),a
   0E9F DD 36 E7 00   [19]  988 	ld	-25 (ix),#0x00
   0EA3 DD 7E E2      [19]  989 	ld	a,-30 (ix)
   0EA6 DD 86 E6      [19]  990 	add	a, -26 (ix)
   0EA9 DD 77 E6      [19]  991 	ld	-26 (ix),a
   0EAC DD 7E E3      [19]  992 	ld	a,-29 (ix)
   0EAF DD 8E E7      [19]  993 	adc	a, -25 (ix)
   0EB2 DD 77 E7      [19]  994 	ld	-25 (ix),a
   0EB5 DD 34 E6      [23]  995 	inc	-26 (ix)
   0EB8 20 03         [12]  996 	jr	NZ,00608$
   0EBA DD 34 E7      [23]  997 	inc	-25 (ix)
   0EBD                     998 00608$:
   0EBD DD 7E E8      [19]  999 	ld	a,-24 (ix)
   0EC0 DD 86 E6      [19] 1000 	add	a, -26 (ix)
   0EC3 DD 77 E6      [19] 1001 	ld	-26 (ix),a
   0EC6 DD 7E E9      [19] 1002 	ld	a,-23 (ix)
   0EC9 DD 8E E7      [19] 1003 	adc	a, -25 (ix)
   0ECC DD 77 E7      [19] 1004 	ld	-25 (ix),a
   0ECF DD 6E E6      [19] 1005 	ld	l,-26 (ix)
   0ED2 DD 66 E7      [19] 1006 	ld	h,-25 (ix)
   0ED5 7E            [ 7] 1007 	ld	a,(hl)
   0ED6 DD 77 DA      [19] 1008 	ld	-38 (ix),a
   0ED9                    1009 00105$:
                           1010 ;src/Renderer.c:344: if(!(x%2)){
   0ED9 DD 7E C7      [19] 1011 	ld	a,-57 (ix)
   0EDC E6 01         [ 7] 1012 	and	a, #0x01
   0EDE DD 77 E6      [19] 1013 	ld	-26 (ix),a
                           1014 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   0EE1 DD 7E DA      [19] 1015 	ld	a,-38 (ix)
   0EE4 E6 80         [ 7] 1016 	and	a, #0x80
   0EE6 DD 77 DF      [19] 1017 	ld	-33 (ix),a
                           1018 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   0EE9 DD 7E F1      [19] 1019 	ld	a,-15 (ix)
   0EEC DD 77 D8      [19] 1020 	ld	-40 (ix),a
   0EEF DD 36 D9 00   [19] 1021 	ld	-39 (ix),#0x00
   0EF3 DD 7E C8      [19] 1022 	ld	a,-56 (ix)
   0EF6 DD 77 F2      [19] 1023 	ld	-14 (ix),a
                           1024 ;src/Renderer.c:344: if(!(x%2)){
   0EF9 DD 7E E6      [19] 1025 	ld	a,-26 (ix)
   0EFC B7            [ 4] 1026 	or	a, a
   0EFD C2 B0 0F      [10] 1027 	jp	NZ,00118$
                           1028 ;src/Renderer.c:345: if ((lateralWallCounter == 0)||newCell)
   0F00 DD 7E D7      [19] 1029 	ld	a,-41 (ix)
   0F03 B7            [ 4] 1030 	or	a, a
   0F04 28 07         [12] 1031 	jr	Z,00114$
   0F06 DD 7E DB      [19] 1032 	ld	a,-37 (ix)
   0F09 B7            [ 4] 1033 	or	a, a
   0F0A CA B0 0F      [10] 1034 	jp	Z,00118$
   0F0D                    1035 00114$:
                           1036 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   0F0D DD 7E DF      [19] 1037 	ld	a,-33 (ix)
   0F10 B7            [ 4] 1038 	or	a, a
   0F11 28 22         [12] 1039 	jr	Z,00112$
                           1040 ;src/Renderer.c:349: lateralWallCounter = 0;//(zHeight - xCellCount);
   0F13 DD 36 D7 00   [19] 1041 	ld	-41 (ix),#0x00
                           1042 ;src/Renderer.c:350: lateralWallSlope = 0;
   0F17 DD 36 F3 00   [19] 1043 	ld	-13 (ix),#0x00
                           1044 ;src/Renderer.c:351: xHeight = zHeight;
   0F1B DD 7E C8      [19] 1045 	ld	a,-56 (ix)
   0F1E DD 77 E0      [19] 1046 	ld	-32 (ix),a
                           1047 ;src/Renderer.c:352: color = currentCellID&0b01111111;
   0F21 DD 7E DA      [19] 1048 	ld	a,-38 (ix)
   0F24 E6 7F         [ 7] 1049 	and	a, #0x7F
   0F26 DD 77 F8      [19] 1050 	ld	-8 (ix),a
                           1051 ;src/Renderer.c:353: lastCellWasWall = 1;
   0F29 DD 36 E1 01   [19] 1052 	ld	-31 (ix),#0x01
                           1053 ;src/Renderer.c:354: lastWallId=currentCellID;
   0F2D DD 7E DA      [19] 1054 	ld	a,-38 (ix)
   0F30 DD 77 DE      [19] 1055 	ld	-34 (ix),a
   0F33 18 77         [12] 1056 	jr	00113$
   0F35                    1057 00112$:
                           1058 ;src/Renderer.c:357: if(lateralWallCounter==0){//Lateral wall not finished
   0F35 DD 7E D7      [19] 1059 	ld	a,-41 (ix)
   0F38 B7            [ 4] 1060 	or	a, a
   0F39 20 71         [12] 1061 	jr	NZ,00113$
                           1062 ;src/Renderer.c:358: if (lastCellWasWall)
   0F3B DD 7E E1      [19] 1063 	ld	a,-31 (ix)
   0F3E B7            [ 4] 1064 	or	a, a
   0F3F 28 5B         [12] 1065 	jr	Z,00107$
                           1066 ;src/Renderer.c:361: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   0F41 DD 7E CE      [19] 1067 	ld	a,-50 (ix)
   0F44 DD 96 CA      [19] 1068 	sub	a, -54 (ix)
   0F47 87            [ 4] 1069 	add	a, a
   0F48 3C            [ 4] 1070 	inc	a
                           1071 ;src/Renderer.c:362: lateralWallSlopeCounter = lateralWallSlope / 2;
   0F49 DD 77 F3      [19] 1072 	ld	-13 (ix), a
   0F4C CB 3F         [ 8] 1073 	srl	a
   0F4E DD 77 FB      [19] 1074 	ld	-5 (ix),a
                           1075 ;src/Renderer.c:363: lateralWallCounter = lateralWallSlope * zHeight;
   0F51 DD 5E C8      [19] 1076 	ld	e,-56 (ix)
   0F54 DD 66 F3      [19] 1077 	ld	h,-13 (ix)
   0F57 2E 00         [ 7] 1078 	ld	l, #0x00
   0F59 55            [ 4] 1079 	ld	d, l
   0F5A 06 08         [ 7] 1080 	ld	b, #0x08
   0F5C                    1081 00609$:
   0F5C 29            [11] 1082 	add	hl,hl
   0F5D 30 01         [12] 1083 	jr	NC,00610$
   0F5F 19            [11] 1084 	add	hl,de
   0F60                    1085 00610$:
   0F60 10 FA         [13] 1086 	djnz	00609$
                           1087 ;src/Renderer.c:364: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   0F62 7D            [ 4] 1088 	ld	a,l
   0F63 E6 FC         [ 7] 1089 	and	a, #0xFC
   0F65 CB C7         [ 8] 1090 	set	0, a
   0F67 CB 3F         [ 8] 1091 	srl	a
   0F69 CB 3F         [ 8] 1092 	srl	a
   0F6B DD 96 F1      [19] 1093 	sub	a, -15 (ix)
                           1094 ;src/Renderer.c:365: lateralWallWidth=lateralWallCounter;
   0F6E DD 77 D7      [19] 1095 	ld	-41 (ix), a
   0F71 DD 77 CB      [19] 1096 	ld	-53 (ix),a
                           1097 ;src/Renderer.c:366: lastCellWasWall = 0;
   0F74 DD 36 E1 00   [19] 1098 	ld	-31 (ix),#0x00
                           1099 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   0F78 DD 6E D8      [19] 1100 	ld	l,-40 (ix)
   0F7B DD 66 D9      [19] 1101 	ld	h,-39 (ix)
   0F7E 29            [11] 1102 	add	hl, hl
   0F7F DD 4E F3      [19] 1103 	ld	c,-13 (ix)
   0F82 06 00         [ 7] 1104 	ld	b,#0x00
   0F84 C5            [11] 1105 	push	bc
   0F85 E5            [11] 1106 	push	hl
   0F86 CD 84 49      [17] 1107 	call	__divsint
   0F89 F1            [10] 1108 	pop	af
   0F8A F1            [10] 1109 	pop	af
   0F8B DD 7E F2      [19] 1110 	ld	a,-14 (ix)
   0F8E 95            [ 4] 1111 	sub	a, l
   0F8F DD 77 E0      [19] 1112 	ld	-32 (ix),a
                           1113 ;src/Renderer.c:368: color = lastWallId&0b01111111;
   0F92 DD 7E DE      [19] 1114 	ld	a,-34 (ix)
   0F95 E6 7F         [ 7] 1115 	and	a, #0x7F
   0F97 DD 77 F8      [19] 1116 	ld	-8 (ix),a
   0F9A 18 10         [12] 1117 	jr	00113$
   0F9C                    1118 00107$:
                           1119 ;src/Renderer.c:372: xHeight = 0;
   0F9C DD 36 E0 00   [19] 1120 	ld	-32 (ix),#0x00
                           1121 ;src/Renderer.c:373: lastCellWasWall = 0;
   0FA0 DD 36 E1 00   [19] 1122 	ld	-31 (ix),#0x00
                           1123 ;src/Renderer.c:374: lateralWallSlope=0;
   0FA4 DD 36 F3 00   [19] 1124 	ld	-13 (ix),#0x00
                           1125 ;src/Renderer.c:375: lastWallId=0;
   0FA8 DD 36 DE 00   [19] 1126 	ld	-34 (ix),#0x00
   0FAC                    1127 00113$:
                           1128 ;src/Renderer.c:379: newCell=0;
   0FAC DD 36 DB 00   [19] 1129 	ld	-37 (ix),#0x00
   0FB0                    1130 00118$:
                           1131 ;src/Renderer.c:382: if (lateralWallCounter > 0)
   0FB0 DD 7E D7      [19] 1132 	ld	a,-41 (ix)
   0FB3 B7            [ 4] 1133 	or	a, a
   0FB4 28 1E         [12] 1134 	jr	Z,00124$
                           1135 ;src/Renderer.c:385: if (lateralWallSlope != 0)
   0FB6 DD 7E F3      [19] 1136 	ld	a,-13 (ix)
   0FB9 B7            [ 4] 1137 	or	a, a
   0FBA 28 15         [12] 1138 	jr	Z,00122$
                           1139 ;src/Renderer.c:387: if (lateralWallSlopeCounter == lateralWallSlope)
   0FBC DD 7E FB      [19] 1140 	ld	a,-5 (ix)
   0FBF DD 96 F3      [19] 1141 	sub	a, -13 (ix)
   0FC2 20 0A         [12] 1142 	jr	NZ,00120$
                           1143 ;src/Renderer.c:389: lateralWallSlopeCounter = 0;
   0FC4 DD 36 FB 00   [19] 1144 	ld	-5 (ix),#0x00
                           1145 ;src/Renderer.c:390: xHeight -= 2;
   0FC8 DD 35 E0      [23] 1146 	dec	-32 (ix)
   0FCB DD 35 E0      [23] 1147 	dec	-32 (ix)
   0FCE                    1148 00120$:
                           1149 ;src/Renderer.c:392: ++lateralWallSlopeCounter;
   0FCE DD 34 FB      [23] 1150 	inc	-5 (ix)
   0FD1                    1151 00122$:
                           1152 ;src/Renderer.c:395: --lateralWallCounter;
   0FD1 DD 35 D7      [23] 1153 	dec	-41 (ix)
   0FD4                    1154 00124$:
                           1155 ;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   0FD4 DD 7E C8      [19] 1156 	ld	a,-56 (ix)
   0FD7 DD 77 FE      [19] 1157 	ld	-2 (ix),a
   0FDA DD 36 FF 00   [19] 1158 	ld	-1 (ix),#0x00
                           1159 ;src/Renderer.c:398: if (!(x%2))
   0FDE DD 7E E6      [19] 1160 	ld	a,-26 (ix)
   0FE1 B7            [ 4] 1161 	or	a, a
   0FE2 C2 63 10      [10] 1162 	jp	NZ,00136$
                           1163 ;src/Renderer.c:408: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   0FE5 DD 46 C7      [19] 1164 	ld	b,-57 (ix)
   0FE8 CB 38         [ 8] 1165 	srl	b
                           1166 ;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   0FEA DD 6E D8      [19] 1167 	ld	l,-40 (ix)
   0FED DD 66 D9      [19] 1168 	ld	h,-39 (ix)
   0FF0 29            [11] 1169 	add	hl, hl
   0FF1 29            [11] 1170 	add	hl, hl
   0FF2 29            [11] 1171 	add	hl, hl
   0FF3 29            [11] 1172 	add	hl, hl
   0FF4 29            [11] 1173 	add	hl, hl
   0FF5 C5            [11] 1174 	push	bc
   0FF6 DD 5E FE      [19] 1175 	ld	e,-2 (ix)
   0FF9 DD 56 FF      [19] 1176 	ld	d,-1 (ix)
   0FFC D5            [11] 1177 	push	de
   0FFD E5            [11] 1178 	push	hl
   0FFE CD 84 49      [17] 1179 	call	__divsint
   1001 F1            [10] 1180 	pop	af
   1002 F1            [10] 1181 	pop	af
   1003 C1            [10] 1182 	pop	bc
   1004 4D            [ 4] 1183 	ld	c,l
                           1184 ;src/Renderer.c:400: if(xHeight > 0){
   1005 DD 7E E0      [19] 1185 	ld	a,-32 (ix)
   1008 B7            [ 4] 1186 	or	a, a
   1009 28 3A         [12] 1187 	jr	Z,00129$
                           1188 ;src/Renderer.c:401: if (lateralWallCounter > 0)
   100B DD 7E D7      [19] 1189 	ld	a,-41 (ix)
   100E B7            [ 4] 1190 	or	a, a
   100F 28 21         [12] 1191 	jr	Z,00126$
                           1192 ;src/Renderer.c:403: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   1011 DD 5E CB      [19] 1193 	ld	e,-53 (ix)
   1014 16 00         [ 7] 1194 	ld	d,#0x00
   1016 DD 6E D7      [19] 1195 	ld	l,-41 (ix)
   1019 26 00         [ 7] 1196 	ld	h,#0x00
   101B 7B            [ 4] 1197 	ld	a,e
   101C 95            [ 4] 1198 	sub	a, l
   101D 6F            [ 4] 1199 	ld	l,a
   101E 7A            [ 4] 1200 	ld	a,d
   101F 9C            [ 4] 1201 	sbc	a, h
   1020 67            [ 4] 1202 	ld	h,a
   1021 29            [11] 1203 	add	hl, hl
   1022 29            [11] 1204 	add	hl, hl
   1023 29            [11] 1205 	add	hl, hl
   1024 29            [11] 1206 	add	hl, hl
   1025 29            [11] 1207 	add	hl, hl
   1026 C5            [11] 1208 	push	bc
   1027 D5            [11] 1209 	push	de
   1028 E5            [11] 1210 	push	hl
   1029 CD 84 49      [17] 1211 	call	__divsint
   102C F1            [10] 1212 	pop	af
   102D F1            [10] 1213 	pop	af
   102E C1            [10] 1214 	pop	bc
   102F 55            [ 4] 1215 	ld	d,l
   1030 18 01         [12] 1216 	jr	00127$
   1032                    1217 00126$:
                           1218 ;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   1032 51            [ 4] 1219 	ld	d,c
   1033                    1220 00127$:
                           1221 ;src/Renderer.c:408: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   1033 C5            [11] 1222 	push	bc
   1034 D5            [11] 1223 	push	de
   1035 33            [ 6] 1224 	inc	sp
   1036 DD 66 F8      [19] 1225 	ld	h,-8 (ix)
   1039 DD 6E E0      [19] 1226 	ld	l,-32 (ix)
   103C E5            [11] 1227 	push	hl
   103D C5            [11] 1228 	push	bc
   103E 33            [ 6] 1229 	inc	sp
   103F CD 71 0C      [17] 1230 	call	_draw_column_to_buffer
   1042 F1            [10] 1231 	pop	af
   1043 F1            [10] 1232 	pop	af
   1044 C1            [10] 1233 	pop	bc
   1045                    1234 00129$:
                           1235 ;src/Renderer.c:410: if(!(currentCellID&CELL_WALL_MASK)){
   1045 DD 7E DF      [19] 1236 	ld	a,-33 (ix)
   1048 B7            [ 4] 1237 	or	a, a
   1049 20 18         [12] 1238 	jr	NZ,00136$
                           1239 ;src/Renderer.c:411: if(currentCellID&CELL_ENEMY_MASK){
   104B DD 7E DA      [19] 1240 	ld	a,-38 (ix)
   104E E6 0F         [ 7] 1241 	and	a, #0x0F
   1050 28 11         [12] 1242 	jr	Z,00136$
                           1243 ;src/Renderer.c:412: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   1052 79            [ 4] 1244 	ld	a,c
   1053 F5            [11] 1245 	push	af
   1054 33            [ 6] 1246 	inc	sp
   1055 DD 66 DA      [19] 1247 	ld	h,-38 (ix)
   1058 DD 6E C8      [19] 1248 	ld	l,-56 (ix)
   105B E5            [11] 1249 	push	hl
   105C C5            [11] 1250 	push	bc
   105D 33            [ 6] 1251 	inc	sp
   105E CD 34 0B      [17] 1252 	call	_draw_column_to_buffer_enemy
   1061 F1            [10] 1253 	pop	af
   1062 F1            [10] 1254 	pop	af
                           1255 ;src/Renderer.c:414: else if(currentCellID&CELL_ITEM_MASK){
   1063                    1256 00136$:
                           1257 ;src/Renderer.c:420: ++xCellCount;
   1063 DD 34 F1      [23] 1258 	inc	-15 (ix)
                           1259 ;src/Renderer.c:335: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   1066 DD 34 C7      [23] 1260 	inc	-57 (ix)
                           1261 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   1069 2A B6 0A      [16] 1262 	ld	hl,(_cells_in_view_array)
   106C DD 75 E8      [19] 1263 	ld	-24 (ix),l
   106F DD 74 E9      [19] 1264 	ld	-23 (ix),h
                           1265 ;src/Renderer.c:335: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   1072 DD 7E C7      [19] 1266 	ld	a,-57 (ix)
   1075 D6 50         [ 7] 1267 	sub	a, #0x50
   1077 DA 86 0E      [10] 1268 	jp	C,00252$
                           1269 ;src/Renderer.c:427: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   107A DD 7E C6      [19] 1270 	ld	a,-58 (ix)
   107D B7            [ 4] 1271 	or	a, a
   107E 28 05         [12] 1272 	jr	Z,00264$
   1080 DD 4E EE      [19] 1273 	ld	c,-18 (ix)
   1083 18 02         [12] 1274 	jr	00265$
   1085                    1275 00264$:
   1085 0E 00         [ 7] 1276 	ld	c,#0x00
   1087                    1277 00265$:
   1087 DD 71 D8      [19] 1278 	ld	-40 (ix),c
                           1279 ;src/Renderer.c:428: lateralWallSlope=0;
   108A DD 36 DF 00   [19] 1280 	ld	-33 (ix),#0x00
                           1281 ;src/Renderer.c:429: lateralWallSlopeCounter=0;
   108E DD 36 E6 00   [19] 1282 	ld	-26 (ix),#0x00
                           1283 ;src/Renderer.c:430: xHeight=0;
   1092 DD 36 E1 00   [19] 1284 	ld	-31 (ix),#0x00
                           1285 ;src/Renderer.c:432: lateralWallCounter = 0;
   1096 DD 36 DE 00   [19] 1286 	ld	-34 (ix),#0x00
                           1287 ;src/Renderer.c:433: lineEnd = lineStart + offsetDiff * 2 + 2;
   109A DD 7E CE      [19] 1288 	ld	a,-50 (ix)
   109D 87            [ 4] 1289 	add	a, a
   109E 4F            [ 4] 1290 	ld	c,a
   109F DD 7E CC      [19] 1291 	ld	a,-52 (ix)
   10A2 81            [ 4] 1292 	add	a, c
   10A3 DD 77 DA      [19] 1293 	ld	-38 (ix), a
   10A6 4F            [ 4] 1294 	ld	c, a
   10A7 0C            [ 4] 1295 	inc	c
   10A8 0C            [ 4] 1296 	inc	c
                           1297 ;src/Renderer.c:435: newCell=1;
   10A9 DD 36 E2 01   [19] 1298 	ld	-30 (ix),#0x01
                           1299 ;src/Renderer.c:436: currentCellID = cells_in_view_array[lineEnd - 1];
   10AD DD 71 DC      [19] 1300 	ld	-36 (ix),c
   10B0 DD 36 DD 00   [19] 1301 	ld	-35 (ix),#0x00
   10B4 DD 5E DC      [19] 1302 	ld	e,-36 (ix)
   10B7 DD 56 DD      [19] 1303 	ld	d,-35 (ix)
   10BA 1B            [ 6] 1304 	dec	de
   10BB DD 6E E8      [19] 1305 	ld	l,-24 (ix)
   10BE DD 66 E9      [19] 1306 	ld	h,-23 (ix)
   10C1 19            [11] 1307 	add	hl,de
   10C2 7E            [ 7] 1308 	ld	a,(hl)
   10C3 DD 77 DB      [19] 1309 	ld	-37 (ix),a
                           1310 ;src/Renderer.c:438: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   10C6 DD 6E E8      [19] 1311 	ld	l,-24 (ix)
   10C9 DD 66 E9      [19] 1312 	ld	h,-23 (ix)
   10CC 06 00         [ 7] 1313 	ld	b,#0x00
   10CE 09            [11] 1314 	add	hl, bc
   10CF 4E            [ 7] 1315 	ld	c,(hl)
                           1316 ;src/Renderer.c:439: if(lastCellWasWall&CELL_WALL_MASK){
   10D0 CB 79         [ 8] 1317 	bit	7, c
   10D2 28 09         [12] 1318 	jr	Z,00139$
                           1319 ;src/Renderer.c:440: lastWallId=lastCellWasWall;
   10D4 DD 71 D7      [19] 1320 	ld	-41 (ix),c
                           1321 ;src/Renderer.c:441: lastCellWasWall=1;
   10D7 DD 36 E0 01   [19] 1322 	ld	-32 (ix),#0x01
   10DB 18 08         [12] 1323 	jr	00315$
   10DD                    1324 00139$:
                           1325 ;src/Renderer.c:444: lastCellWasWall=0;
   10DD DD 36 E0 00   [19] 1326 	ld	-32 (ix),#0x00
                           1327 ;src/Renderer.c:445: lastWallId=CELLTYPE_FLOOR;
   10E1 DD 36 D7 00   [19] 1328 	ld	-41 (ix),#0x00
                           1329 ;src/Renderer.c:448: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   10E5                    1330 00315$:
   10E5 DD 36 CA 00   [19] 1331 	ld	-54 (ix),#0x00
   10E9 DD 36 C7 9F   [19] 1332 	ld	-57 (ix),#0x9F
   10ED                    1333 00254$:
                           1334 ;src/Renderer.c:451: if (xCellCount == zHeight)
   10ED DD 7E C8      [19] 1335 	ld	a,-56 (ix)
   10F0 DD 96 D8      [19] 1336 	sub	a, -40 (ix)
   10F3 20 50         [12] 1337 	jr	NZ,00142$
                           1338 ;src/Renderer.c:453: ++xCell;
   10F5 DD 34 CA      [23] 1339 	inc	-54 (ix)
                           1340 ;src/Renderer.c:454: xCellCount = 0;
   10F8 DD 36 D8 00   [19] 1341 	ld	-40 (ix),#0x00
                           1342 ;src/Renderer.c:455: newCell=1;
   10FC DD 36 E2 01   [19] 1343 	ld	-30 (ix),#0x01
                           1344 ;src/Renderer.c:456: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   1100 DD 7E CA      [19] 1345 	ld	a,-54 (ix)
   1103 DD 77 E4      [19] 1346 	ld	-28 (ix),a
   1106 DD 36 E5 00   [19] 1347 	ld	-27 (ix),#0x00
   110A DD 7E DC      [19] 1348 	ld	a,-36 (ix)
   110D DD 96 E4      [19] 1349 	sub	a, -28 (ix)
   1110 DD 77 E4      [19] 1350 	ld	-28 (ix),a
   1113 DD 7E DD      [19] 1351 	ld	a,-35 (ix)
   1116 DD 9E E5      [19] 1352 	sbc	a, -27 (ix)
   1119 DD 77 E5      [19] 1353 	ld	-27 (ix),a
   111C DD 6E E4      [19] 1354 	ld	l,-28 (ix)
   111F DD 66 E5      [19] 1355 	ld	h,-27 (ix)
   1122 2B            [ 6] 1356 	dec	hl
   1123 DD 75 E4      [19] 1357 	ld	-28 (ix),l
   1126 DD 74 E5      [19] 1358 	ld	-27 (ix),h
   1129 DD 7E E8      [19] 1359 	ld	a,-24 (ix)
   112C DD 86 E4      [19] 1360 	add	a, -28 (ix)
   112F DD 77 E4      [19] 1361 	ld	-28 (ix),a
   1132 DD 7E E9      [19] 1362 	ld	a,-23 (ix)
   1135 DD 8E E5      [19] 1363 	adc	a, -27 (ix)
   1138 DD 77 E5      [19] 1364 	ld	-27 (ix),a
   113B DD 6E E4      [19] 1365 	ld	l,-28 (ix)
   113E DD 66 E5      [19] 1366 	ld	h,-27 (ix)
   1141 7E            [ 7] 1367 	ld	a,(hl)
   1142 DD 77 DB      [19] 1368 	ld	-37 (ix),a
   1145                    1369 00142$:
                           1370 ;src/Renderer.c:458: if(!(x%2)){
   1145 DD 7E C7      [19] 1371 	ld	a,-57 (ix)
   1148 E6 01         [ 7] 1372 	and	a, #0x01
   114A DD 77 E4      [19] 1373 	ld	-28 (ix),a
                           1374 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   114D DD 7E DB      [19] 1375 	ld	a,-37 (ix)
   1150 E6 80         [ 7] 1376 	and	a, #0x80
   1152 DD 77 FB      [19] 1377 	ld	-5 (ix),a
                           1378 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   1155 DD 7E D8      [19] 1379 	ld	a,-40 (ix)
   1158 DD 77 EA      [19] 1380 	ld	-22 (ix),a
   115B DD 36 EB 00   [19] 1381 	ld	-21 (ix),#0x00
                           1382 ;src/Renderer.c:458: if(!(x%2)){
   115F DD 7E E4      [19] 1383 	ld	a,-28 (ix)
   1162 B7            [ 4] 1384 	or	a, a
   1163 C2 35 12      [10] 1385 	jp	NZ,00155$
                           1386 ;src/Renderer.c:459: if (lateralWallCounter == 0 || newCell)
   1166 DD 7E DE      [19] 1387 	ld	a,-34 (ix)
   1169 B7            [ 4] 1388 	or	a, a
   116A 28 07         [12] 1389 	jr	Z,00151$
   116C DD 7E E2      [19] 1390 	ld	a,-30 (ix)
   116F B7            [ 4] 1391 	or	a, a
   1170 CA 35 12      [10] 1392 	jp	Z,00155$
   1173                    1393 00151$:
                           1394 ;src/Renderer.c:461: if ( currentCellID & CELL_WALL_MASK)//Wall
   1173 DD 7E FB      [19] 1395 	ld	a,-5 (ix)
   1176 B7            [ 4] 1396 	or	a, a
   1177 28 23         [12] 1397 	jr	Z,00149$
                           1398 ;src/Renderer.c:463: lateralWallCounter = 0;
   1179 DD 36 DE 00   [19] 1399 	ld	-34 (ix),#0x00
                           1400 ;src/Renderer.c:464: lateralWallSlope = 0;
   117D DD 36 DF 00   [19] 1401 	ld	-33 (ix),#0x00
                           1402 ;src/Renderer.c:465: xHeight = zHeight;
   1181 DD 7E C8      [19] 1403 	ld	a,-56 (ix)
   1184 DD 77 E1      [19] 1404 	ld	-31 (ix),a
                           1405 ;src/Renderer.c:466: color = currentCellID&0b01111111;
   1187 DD 7E DB      [19] 1406 	ld	a,-37 (ix)
   118A E6 7F         [ 7] 1407 	and	a, #0x7F
   118C DD 77 F8      [19] 1408 	ld	-8 (ix),a
                           1409 ;src/Renderer.c:467: lastCellWasWall = 1;
   118F DD 36 E0 01   [19] 1410 	ld	-32 (ix),#0x01
                           1411 ;src/Renderer.c:468: lastWallId=currentCellID;
   1193 DD 7E DB      [19] 1412 	ld	a,-37 (ix)
   1196 DD 77 D7      [19] 1413 	ld	-41 (ix),a
   1199 C3 31 12      [10] 1414 	jp	00150$
   119C                    1415 00149$:
                           1416 ;src/Renderer.c:470: else if(lateralWallCounter==0){
   119C DD 7E DE      [19] 1417 	ld	a,-34 (ix)
   119F B7            [ 4] 1418 	or	a, a
   11A0 C2 31 12      [10] 1419 	jp	NZ,00150$
                           1420 ;src/Renderer.c:471: if (lastCellWasWall)
   11A3 DD 7E E0      [19] 1421 	ld	a,-32 (ix)
   11A6 B7            [ 4] 1422 	or	a, a
   11A7 28 78         [12] 1423 	jr	Z,00144$
                           1424 ;src/Renderer.c:474: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   11A9 DD 7E CE      [19] 1425 	ld	a,-50 (ix)
   11AC DD 96 CA      [19] 1426 	sub	a, -54 (ix)
   11AF 87            [ 4] 1427 	add	a, a
   11B0 3C            [ 4] 1428 	inc	a
                           1429 ;src/Renderer.c:475: lateralWallSlopeCounter = lateralWallSlope / 2;
   11B1 DD 77 DF      [19] 1430 	ld	-33 (ix), a
   11B4 CB 3F         [ 8] 1431 	srl	a
   11B6 DD 77 E6      [19] 1432 	ld	-26 (ix),a
                           1433 ;src/Renderer.c:476: lateralWallCounter = lateralWallSlope * zHeight;
   11B9 DD 5E C8      [19] 1434 	ld	e,-56 (ix)
   11BC DD 66 DF      [19] 1435 	ld	h,-33 (ix)
   11BF 2E 00         [ 7] 1436 	ld	l, #0x00
   11C1 55            [ 4] 1437 	ld	d, l
   11C2 06 08         [ 7] 1438 	ld	b, #0x08
   11C4                    1439 00617$:
   11C4 29            [11] 1440 	add	hl,hl
   11C5 30 01         [12] 1441 	jr	NC,00618$
   11C7 19            [11] 1442 	add	hl,de
   11C8                    1443 00618$:
   11C8 10 FA         [13] 1444 	djnz	00617$
                           1445 ;src/Renderer.c:477: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   11CA 4D            [ 4] 1446 	ld	c,l
   11CB 06 00         [ 7] 1447 	ld	b,#0x00
   11CD 7D            [ 4] 1448 	ld	a,l
   11CE E6 03         [ 7] 1449 	and	a, #0x03
   11D0 5F            [ 4] 1450 	ld	e,a
   11D1 16 00         [ 7] 1451 	ld	d,#0x00
   11D3 79            [ 4] 1452 	ld	a,c
   11D4 93            [ 4] 1453 	sub	a, e
   11D5 4F            [ 4] 1454 	ld	c,a
   11D6 78            [ 4] 1455 	ld	a,b
   11D7 9A            [ 4] 1456 	sbc	a, d
   11D8 47            [ 4] 1457 	ld	b,a
   11D9 59            [ 4] 1458 	ld	e, c
   11DA 50            [ 4] 1459 	ld	d, b
   11DB 13            [ 6] 1460 	inc	de
   11DC 6B            [ 4] 1461 	ld	l, e
   11DD 62            [ 4] 1462 	ld	h, d
   11DE CB 7A         [ 8] 1463 	bit	7, d
   11E0 28 04         [12] 1464 	jr	Z,00266$
   11E2 21 04 00      [10] 1465 	ld	hl,#0x0004
   11E5 09            [11] 1466 	add	hl,bc
   11E6                    1467 00266$:
   11E6 CB 2C         [ 8] 1468 	sra	h
   11E8 CB 1D         [ 8] 1469 	rr	l
   11EA CB 2C         [ 8] 1470 	sra	h
   11EC CB 1D         [ 8] 1471 	rr	l
   11EE DD 4E D8      [19] 1472 	ld	c,-40 (ix)
   11F1 7D            [ 4] 1473 	ld	a,l
   11F2 91            [ 4] 1474 	sub	a, c
                           1475 ;src/Renderer.c:478: lateralWallWidth=lateralWallCounter;
   11F3 DD 77 DE      [19] 1476 	ld	-34 (ix), a
   11F6 DD 77 CB      [19] 1477 	ld	-53 (ix),a
                           1478 ;src/Renderer.c:479: lastCellWasWall = 0;
   11F9 DD 36 E0 00   [19] 1479 	ld	-32 (ix),#0x00
                           1480 ;src/Renderer.c:480: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   11FD DD 6E EA      [19] 1481 	ld	l,-22 (ix)
   1200 DD 66 EB      [19] 1482 	ld	h,-21 (ix)
   1203 29            [11] 1483 	add	hl, hl
   1204 DD 4E DF      [19] 1484 	ld	c,-33 (ix)
   1207 06 00         [ 7] 1485 	ld	b,#0x00
   1209 C5            [11] 1486 	push	bc
   120A E5            [11] 1487 	push	hl
   120B CD 84 49      [17] 1488 	call	__divsint
   120E F1            [10] 1489 	pop	af
   120F F1            [10] 1490 	pop	af
   1210 DD 7E F2      [19] 1491 	ld	a,-14 (ix)
   1213 95            [ 4] 1492 	sub	a, l
   1214 DD 77 E1      [19] 1493 	ld	-31 (ix),a
                           1494 ;src/Renderer.c:481: color = lastWallId&0b01111111;
   1217 DD 7E D7      [19] 1495 	ld	a,-41 (ix)
   121A E6 7F         [ 7] 1496 	and	a, #0x7F
   121C DD 77 F8      [19] 1497 	ld	-8 (ix),a
   121F 18 10         [12] 1498 	jr	00150$
   1221                    1499 00144$:
                           1500 ;src/Renderer.c:485: xHeight = 0;
   1221 DD 36 E1 00   [19] 1501 	ld	-31 (ix),#0x00
                           1502 ;src/Renderer.c:486: lastCellWasWall = 0;
   1225 DD 36 E0 00   [19] 1503 	ld	-32 (ix),#0x00
                           1504 ;src/Renderer.c:487: lateralWallSlope=0;
   1229 DD 36 DF 00   [19] 1505 	ld	-33 (ix),#0x00
                           1506 ;src/Renderer.c:488: lastWallId=0;
   122D DD 36 D7 00   [19] 1507 	ld	-41 (ix),#0x00
   1231                    1508 00150$:
                           1509 ;src/Renderer.c:491: newCell=0;
   1231 DD 36 E2 00   [19] 1510 	ld	-30 (ix),#0x00
   1235                    1511 00155$:
                           1512 ;src/Renderer.c:496: if (lateralWallCounter > 0)
   1235 DD 7E DE      [19] 1513 	ld	a,-34 (ix)
   1238 B7            [ 4] 1514 	or	a, a
   1239 28 1E         [12] 1515 	jr	Z,00161$
                           1516 ;src/Renderer.c:499: if (lateralWallSlope != 0)
   123B DD 7E DF      [19] 1517 	ld	a,-33 (ix)
   123E B7            [ 4] 1518 	or	a, a
   123F 28 15         [12] 1519 	jr	Z,00159$
                           1520 ;src/Renderer.c:501: if (lateralWallSlopeCounter == lateralWallSlope)
   1241 DD 7E DF      [19] 1521 	ld	a,-33 (ix)
   1244 DD 96 E6      [19] 1522 	sub	a, -26 (ix)
   1247 20 0A         [12] 1523 	jr	NZ,00157$
                           1524 ;src/Renderer.c:503: lateralWallSlopeCounter = 0;
   1249 DD 36 E6 00   [19] 1525 	ld	-26 (ix),#0x00
                           1526 ;src/Renderer.c:504: xHeight -= 2;
   124D DD 35 E1      [23] 1527 	dec	-31 (ix)
   1250 DD 35 E1      [23] 1528 	dec	-31 (ix)
   1253                    1529 00157$:
                           1530 ;src/Renderer.c:506: ++lateralWallSlopeCounter;
   1253 DD 34 E6      [23] 1531 	inc	-26 (ix)
   1256                    1532 00159$:
                           1533 ;src/Renderer.c:508: --lateralWallCounter;
   1256 DD 35 DE      [23] 1534 	dec	-34 (ix)
   1259                    1535 00161$:
                           1536 ;src/Renderer.c:512: if (!(x%2))
   1259 DD 7E E4      [19] 1537 	ld	a,-28 (ix)
   125C B7            [ 4] 1538 	or	a, a
   125D C2 20 13      [10] 1539 	jp	NZ,00173$
                           1540 ;src/Renderer.c:525: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   1260 DD 7E C7      [19] 1541 	ld	a,-57 (ix)
   1263 CB 3F         [ 8] 1542 	srl	a
   1265 DD 77 E4      [19] 1543 	ld	-28 (ix),a
                           1544 ;src/Renderer.c:522: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   1268 DD 7E FE      [19] 1545 	ld	a,-2 (ix)
   126B DD 96 EA      [19] 1546 	sub	a, -22 (ix)
   126E DD 77 EA      [19] 1547 	ld	-22 (ix),a
   1271 DD 7E FF      [19] 1548 	ld	a,-1 (ix)
   1274 DD 9E EB      [19] 1549 	sbc	a, -21 (ix)
   1277 DD 77 EB      [19] 1550 	ld	-21 (ix),a
   127A 3E 06         [ 7] 1551 	ld	a,#0x05+1
   127C 18 08         [12] 1552 	jr	00622$
   127E                    1553 00621$:
   127E DD CB EA 26   [23] 1554 	sla	-22 (ix)
   1282 DD CB EB 16   [23] 1555 	rl	-21 (ix)
   1286                    1556 00622$:
   1286 3D            [ 4] 1557 	dec	a
   1287 20 F5         [12] 1558 	jr	NZ,00621$
   1289 DD 6E FE      [19] 1559 	ld	l,-2 (ix)
   128C DD 66 FF      [19] 1560 	ld	h,-1 (ix)
   128F E5            [11] 1561 	push	hl
   1290 DD 6E EA      [19] 1562 	ld	l,-22 (ix)
   1293 DD 66 EB      [19] 1563 	ld	h,-21 (ix)
   1296 E5            [11] 1564 	push	hl
   1297 CD 84 49      [17] 1565 	call	__divsint
   129A F1            [10] 1566 	pop	af
   129B F1            [10] 1567 	pop	af
   129C DD 74 EB      [19] 1568 	ld	-21 (ix),h
   129F DD 75 EA      [19] 1569 	ld	-22 (ix), l
   12A2 DD 75 EA      [19] 1570 	ld	-22 (ix), l
                           1571 ;src/Renderer.c:515: if(xHeight > 0){
   12A5 DD 7E E1      [19] 1572 	ld	a,-31 (ix)
   12A8 B7            [ 4] 1573 	or	a, a
   12A9 28 55         [12] 1574 	jr	Z,00166$
                           1575 ;src/Renderer.c:517: if (lateralWallCounter > 0)
   12AB DD 7E DE      [19] 1576 	ld	a,-34 (ix)
   12AE B7            [ 4] 1577 	or	a, a
   12AF 28 39         [12] 1578 	jr	Z,00163$
                           1579 ;src/Renderer.c:519: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   12B1 DD 7E DE      [19] 1580 	ld	a,-34 (ix)
   12B4 DD 77 EC      [19] 1581 	ld	-20 (ix),a
   12B7 DD 36 ED 00   [19] 1582 	ld	-19 (ix),#0x00
   12BB 3E 06         [ 7] 1583 	ld	a,#0x05+1
   12BD 18 08         [12] 1584 	jr	00624$
   12BF                    1585 00623$:
   12BF DD CB EC 26   [23] 1586 	sla	-20 (ix)
   12C3 DD CB ED 16   [23] 1587 	rl	-19 (ix)
   12C7                    1588 00624$:
   12C7 3D            [ 4] 1589 	dec	a
   12C8 20 F5         [12] 1590 	jr	NZ,00623$
   12CA DD 7E CB      [19] 1591 	ld	a,-53 (ix)
   12CD DD 77 EF      [19] 1592 	ld	-17 (ix),a
   12D0 DD 36 F0 00   [19] 1593 	ld	-16 (ix),#0x00
   12D4 DD 6E EF      [19] 1594 	ld	l,-17 (ix)
   12D7 DD 66 F0      [19] 1595 	ld	h,-16 (ix)
   12DA E5            [11] 1596 	push	hl
   12DB DD 6E EC      [19] 1597 	ld	l,-20 (ix)
   12DE DD 66 ED      [19] 1598 	ld	h,-19 (ix)
   12E1 E5            [11] 1599 	push	hl
   12E2 CD 84 49      [17] 1600 	call	__divsint
   12E5 F1            [10] 1601 	pop	af
   12E6 F1            [10] 1602 	pop	af
   12E7 45            [ 4] 1603 	ld	b,l
   12E8 18 03         [12] 1604 	jr	00164$
   12EA                    1605 00163$:
                           1606 ;src/Renderer.c:522: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   12EA DD 46 EA      [19] 1607 	ld	b,-22 (ix)
   12ED                    1608 00164$:
                           1609 ;src/Renderer.c:525: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   12ED C5            [11] 1610 	push	bc
   12EE 33            [ 6] 1611 	inc	sp
   12EF DD 66 F8      [19] 1612 	ld	h,-8 (ix)
   12F2 DD 6E E1      [19] 1613 	ld	l,-31 (ix)
   12F5 E5            [11] 1614 	push	hl
   12F6 DD 7E E4      [19] 1615 	ld	a,-28 (ix)
   12F9 F5            [11] 1616 	push	af
   12FA 33            [ 6] 1617 	inc	sp
   12FB CD 71 0C      [17] 1618 	call	_draw_column_to_buffer
   12FE F1            [10] 1619 	pop	af
   12FF F1            [10] 1620 	pop	af
   1300                    1621 00166$:
                           1622 ;src/Renderer.c:528: if(!(currentCellID&CELL_WALL_MASK)){
   1300 DD 7E FB      [19] 1623 	ld	a,-5 (ix)
   1303 B7            [ 4] 1624 	or	a, a
   1304 20 1A         [12] 1625 	jr	NZ,00173$
                           1626 ;src/Renderer.c:529: if(currentCellID&CELL_ENEMY_MASK){
   1306 DD 7E DB      [19] 1627 	ld	a,-37 (ix)
   1309 E6 0F         [ 7] 1628 	and	a, #0x0F
   130B 28 13         [12] 1629 	jr	Z,00173$
                           1630 ;src/Renderer.c:530: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   130D DD 66 EA      [19] 1631 	ld	h,-22 (ix)
   1310 DD 6E DB      [19] 1632 	ld	l,-37 (ix)
   1313 E5            [11] 1633 	push	hl
   1314 DD 66 C8      [19] 1634 	ld	h,-56 (ix)
   1317 DD 6E E4      [19] 1635 	ld	l,-28 (ix)
   131A E5            [11] 1636 	push	hl
   131B CD 34 0B      [17] 1637 	call	_draw_column_to_buffer_enemy
   131E F1            [10] 1638 	pop	af
   131F F1            [10] 1639 	pop	af
                           1640 ;src/Renderer.c:532: else if(currentCellID&CELL_ITEM_MASK){
   1320                    1641 00173$:
                           1642 ;src/Renderer.c:537: ++xCellCount;
   1320 DD 34 D8      [23] 1643 	inc	-40 (ix)
                           1644 ;src/Renderer.c:448: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   1323 DD 35 C7      [23] 1645 	dec	-57 (ix)
                           1646 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   1326 2A B6 0A      [16] 1647 	ld	hl,(_cells_in_view_array)
   1329 DD 75 E8      [19] 1648 	ld	-24 (ix),l
   132C DD 74 E9      [19] 1649 	ld	-23 (ix),h
                           1650 ;src/Renderer.c:448: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   132F DD 7E C7      [19] 1651 	ld	a,-57 (ix)
   1332 D6 50         [ 7] 1652 	sub	a, #0x50
   1334 D2 ED 10      [10] 1653 	jp	NC,00254$
                           1654 ;src/Renderer.c:544: lineStart = lineStart + (offsetDiff * 2) + 3;
   1337 DD 7E DA      [19] 1655 	ld	a,-38 (ix)
   133A C6 03         [ 7] 1656 	add	a, #0x03
   133C DD 77 CC      [19] 1657 	ld	-52 (ix),a
                           1658 ;src/Renderer.c:545: zHeight += zHeight;
   133F DD CB C8 26   [23] 1659 	sla	-56 (ix)
                           1660 ;src/Renderer.c:546: offsetDiff = offsetDiff >> 1;
   1343 DD CB CE 3E   [23] 1661 	srl	-50 (ix)
                           1662 ;src/Renderer.c:548: }while(z);
   1347 DD 7E C6      [19] 1663 	ld	a,-58 (ix)
   134A B7            [ 4] 1664 	or	a, a
   134B C2 10 0E      [10] 1665 	jp	NZ,00175$
   134E C3 FE 18      [10] 1666 	jp	00260$
                           1667 ;src/Renderer.c:553: do{
   1351                    1668 00358$:
   1351 DD 36 C6 06   [19] 1669 	ld	-58 (ix),#0x06
   1355                    1670 00246$:
                           1671 ;src/Renderer.c:555: --z;
   1355 DD 35 C6      [23] 1672 	dec	-58 (ix)
                           1673 ;src/Renderer.c:315: xCellCount = (z) ? (zHeight >> 1) : 0;
   1358 DD 7E C8      [19] 1674 	ld	a,-56 (ix)
   135B CB 3F         [ 8] 1675 	srl	a
   135D DD 77 EF      [19] 1676 	ld	-17 (ix),a
                           1677 ;src/Renderer.c:559: xCellCount = (z) ? (zHeight >> 1) : 0;
   1360 DD 7E C6      [19] 1678 	ld	a,-58 (ix)
   1363 B7            [ 4] 1679 	or	a, a
   1364 28 05         [12] 1680 	jr	Z,00267$
   1366 DD 4E EF      [19] 1681 	ld	c,-17 (ix)
   1369 18 02         [12] 1682 	jr	00268$
   136B                    1683 00267$:
   136B 0E 00         [ 7] 1684 	ld	c,#0x00
   136D                    1685 00268$:
   136D DD 71 C9      [19] 1686 	ld	-55 (ix),c
                           1687 ;src/Renderer.c:560: lateralWallSlope=0;
   1370 DD 36 D4 00   [19] 1688 	ld	-44 (ix),#0x00
                           1689 ;src/Renderer.c:561: lateralWallSlopeCounter=0;
   1374 DD 36 CF 00   [19] 1690 	ld	-49 (ix),#0x00
                           1691 ;src/Renderer.c:562: xHeight=0;
   1378 DD 36 D6 00   [19] 1692 	ld	-42 (ix),#0x00
                           1693 ;src/Renderer.c:564: lateralWallCounter = 0;
   137C DD 36 EC 00   [19] 1694 	ld	-20 (ix),#0x00
                           1695 ;src/Renderer.c:566: newCell=1;
   1380 DD 36 D2 01   [19] 1696 	ld	-46 (ix),#0x01
                           1697 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   1384 DD 7E CC      [19] 1698 	ld	a,-52 (ix)
   1387 DD 77 EA      [19] 1699 	ld	-22 (ix),a
   138A DD 36 EB 00   [19] 1700 	ld	-21 (ix),#0x00
                           1701 ;src/Renderer.c:567: currentCellID = cells_in_view_array[lineStart + 1];
   138E DD 4E EA      [19] 1702 	ld	c,-22 (ix)
   1391 DD 46 EB      [19] 1703 	ld	b,-21 (ix)
   1394 03            [ 6] 1704 	inc	bc
   1395 DD 6E E8      [19] 1705 	ld	l,-24 (ix)
   1398 DD 66 E9      [19] 1706 	ld	h,-23 (ix)
   139B 09            [11] 1707 	add	hl,bc
   139C 7E            [ 7] 1708 	ld	a,(hl)
   139D DD 77 D1      [19] 1709 	ld	-47 (ix),a
                           1710 ;src/Renderer.c:569: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   13A0 DD 7E E8      [19] 1711 	ld	a,-24 (ix)
   13A3 DD 86 CC      [19] 1712 	add	a, -52 (ix)
   13A6 6F            [ 4] 1713 	ld	l,a
   13A7 DD 7E E9      [19] 1714 	ld	a,-23 (ix)
   13AA CE 00         [ 7] 1715 	adc	a, #0x00
   13AC 67            [ 4] 1716 	ld	h,a
   13AD 4E            [ 7] 1717 	ld	c,(hl)
                           1718 ;src/Renderer.c:570: if(lastCellWasWall&CELL_WALL_MASK){
   13AE CB 79         [ 8] 1719 	bit	7, c
   13B0 28 09         [12] 1720 	jr	Z,00179$
                           1721 ;src/Renderer.c:571: lastWallId=lastCellWasWall;
   13B2 DD 71 D3      [19] 1722 	ld	-45 (ix),c
                           1723 ;src/Renderer.c:572: lastCellWasWall=1;
   13B5 DD 36 E4 01   [19] 1724 	ld	-28 (ix),#0x01
   13B9 18 08         [12] 1725 	jr	00336$
   13BB                    1726 00179$:
                           1727 ;src/Renderer.c:575: lastCellWasWall=0;
   13BB DD 36 E4 00   [19] 1728 	ld	-28 (ix),#0x00
                           1729 ;src/Renderer.c:576: lastWallId=CELLTYPE_FLOOR;
   13BF DD 36 D3 00   [19] 1730 	ld	-45 (ix),#0x00
                           1731 ;src/Renderer.c:579: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   13C3                    1732 00336$:
   13C3 DD 36 CA 00   [19] 1733 	ld	-54 (ix),#0x00
   13C7 DD 36 C7 00   [19] 1734 	ld	-57 (ix),#0x00
   13CB                    1735 00256$:
                           1736 ;src/Renderer.c:581: if (xCellCount == zHeight)
   13CB DD 7E C9      [19] 1737 	ld	a,-55 (ix)
   13CE DD 96 C8      [19] 1738 	sub	a, -56 (ix)
   13D1 20 4B         [12] 1739 	jr	NZ,00182$
                           1740 ;src/Renderer.c:583: ++xCell;
   13D3 DD 34 CA      [23] 1741 	inc	-54 (ix)
                           1742 ;src/Renderer.c:584: xCellCount = 0;
   13D6 DD 36 C9 00   [19] 1743 	ld	-55 (ix),#0x00
                           1744 ;src/Renderer.c:585: newCell=1;
   13DA DD 36 D2 01   [19] 1745 	ld	-46 (ix),#0x01
                           1746 ;src/Renderer.c:586: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   13DE DD 7E CA      [19] 1747 	ld	a,-54 (ix)
   13E1 DD 77 DC      [19] 1748 	ld	-36 (ix),a
   13E4 DD 36 DD 00   [19] 1749 	ld	-35 (ix),#0x00
   13E8 DD 7E EA      [19] 1750 	ld	a,-22 (ix)
   13EB DD 86 DC      [19] 1751 	add	a, -36 (ix)
   13EE DD 77 DC      [19] 1752 	ld	-36 (ix),a
   13F1 DD 7E EB      [19] 1753 	ld	a,-21 (ix)
   13F4 DD 8E DD      [19] 1754 	adc	a, -35 (ix)
   13F7 DD 77 DD      [19] 1755 	ld	-35 (ix),a
   13FA DD 34 DC      [23] 1756 	inc	-36 (ix)
   13FD 20 03         [12] 1757 	jr	NZ,00629$
   13FF DD 34 DD      [23] 1758 	inc	-35 (ix)
   1402                    1759 00629$:
   1402 DD 7E DC      [19] 1760 	ld	a,-36 (ix)
   1405 DD 86 E8      [19] 1761 	add	a, -24 (ix)
   1408 DD 77 DC      [19] 1762 	ld	-36 (ix),a
   140B DD 7E DD      [19] 1763 	ld	a,-35 (ix)
   140E DD 8E E9      [19] 1764 	adc	a, -23 (ix)
   1411 DD 77 DD      [19] 1765 	ld	-35 (ix),a
   1414 DD 6E DC      [19] 1766 	ld	l,-36 (ix)
   1417 DD 66 DD      [19] 1767 	ld	h,-35 (ix)
   141A 7E            [ 7] 1768 	ld	a,(hl)
   141B DD 77 D1      [19] 1769 	ld	-47 (ix),a
   141E                    1770 00182$:
                           1771 ;src/Renderer.c:588: if(!(x%2)){
   141E DD 7E C7      [19] 1772 	ld	a,-57 (ix)
   1421 E6 01         [ 7] 1773 	and	a, #0x01
   1423 DD 77 DC      [19] 1774 	ld	-36 (ix),a
                           1775 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   1426 DD 7E D1      [19] 1776 	ld	a,-47 (ix)
   1429 E6 80         [ 7] 1777 	and	a, #0x80
   142B DD 77 FE      [19] 1778 	ld	-2 (ix),a
                           1779 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   142E DD 7E C9      [19] 1780 	ld	a,-55 (ix)
   1431 DD 77 D8      [19] 1781 	ld	-40 (ix),a
   1434 DD 36 D9 00   [19] 1782 	ld	-39 (ix),#0x00
   1438 DD 7E C8      [19] 1783 	ld	a,-56 (ix)
   143B DD 77 F8      [19] 1784 	ld	-8 (ix),a
                           1785 ;src/Renderer.c:588: if(!(x%2)){
   143E DD 7E DC      [19] 1786 	ld	a,-36 (ix)
   1441 B7            [ 4] 1787 	or	a, a
   1442 C2 3A 15      [10] 1788 	jp	NZ,00195$
                           1789 ;src/Renderer.c:589: if ((lateralWallCounter == 0)||newCell)
   1445 DD 7E EC      [19] 1790 	ld	a,-20 (ix)
   1448 B7            [ 4] 1791 	or	a, a
   1449 28 07         [12] 1792 	jr	Z,00191$
   144B DD 7E D2      [19] 1793 	ld	a,-46 (ix)
   144E B7            [ 4] 1794 	or	a, a
   144F CA 3A 15      [10] 1795 	jp	Z,00195$
   1452                    1796 00191$:
                           1797 ;src/Renderer.c:591: if (currentCellID & CELL_WALL_MASK)//Wall
   1452 DD 7E FE      [19] 1798 	ld	a,-2 (ix)
   1455 B7            [ 4] 1799 	or	a, a
   1456 28 2B         [12] 1800 	jr	Z,00189$
                           1801 ;src/Renderer.c:593: lateralWallCounter = 0;//(zHeight - xCellCount);
   1458 DD 36 EC 00   [19] 1802 	ld	-20 (ix),#0x00
                           1803 ;src/Renderer.c:594: lateralWallSlope = 0;
   145C DD 36 D4 00   [19] 1804 	ld	-44 (ix),#0x00
                           1805 ;src/Renderer.c:595: xHeight = zHeight;
   1460 DD 7E C8      [19] 1806 	ld	a,-56 (ix)
   1463 DD 77 D6      [19] 1807 	ld	-42 (ix),a
                           1808 ;src/Renderer.c:596: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   1466 DD 7E D1      [19] 1809 	ld	a,-47 (ix)
   1469 D6 80         [ 7] 1810 	sub	a, #0x80
   146B 20 04         [12] 1811 	jr	NZ,00269$
   146D 0E 0C         [ 7] 1812 	ld	c,#0x0C
   146F 18 02         [12] 1813 	jr	00270$
   1471                    1814 00269$:
   1471 0E 0E         [ 7] 1815 	ld	c,#0x0E
   1473                    1816 00270$:
   1473 DD 71 D0      [19] 1817 	ld	-48 (ix),c
                           1818 ;src/Renderer.c:597: lastCellWasWall = 1;
   1476 DD 36 E4 01   [19] 1819 	ld	-28 (ix),#0x01
                           1820 ;src/Renderer.c:598: lastWallId=currentCellID;
   147A DD 7E D1      [19] 1821 	ld	a,-47 (ix)
   147D DD 77 D3      [19] 1822 	ld	-45 (ix),a
   1480 C3 36 15      [10] 1823 	jp	00190$
   1483                    1824 00189$:
                           1825 ;src/Renderer.c:601: if(lateralWallCounter==0){//Lateral wall not finished
   1483 DD 7E EC      [19] 1826 	ld	a,-20 (ix)
   1486 B7            [ 4] 1827 	or	a, a
   1487 C2 36 15      [10] 1828 	jp	NZ,00190$
                           1829 ;src/Renderer.c:602: if (lastCellWasWall)
   148A DD 7E E4      [19] 1830 	ld	a,-28 (ix)
   148D B7            [ 4] 1831 	or	a, a
   148E CA 26 15      [10] 1832 	jp	Z,00184$
                           1833 ;src/Renderer.c:605: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   1491 DD 7E CE      [19] 1834 	ld	a,-50 (ix)
   1494 DD 96 CA      [19] 1835 	sub	a, -54 (ix)
   1497 87            [ 4] 1836 	add	a, a
   1498 3C            [ 4] 1837 	inc	a
                           1838 ;src/Renderer.c:606: lateralWallSlopeCounter = lateralWallSlope / 2;
   1499 DD 77 D4      [19] 1839 	ld	-44 (ix), a
   149C CB 3F         [ 8] 1840 	srl	a
   149E DD 77 CF      [19] 1841 	ld	-49 (ix),a
                           1842 ;src/Renderer.c:607: lateralWallCounter = lateralWallSlope * zHeight;
   14A1 DD 5E C8      [19] 1843 	ld	e,-56 (ix)
   14A4 DD 66 D4      [19] 1844 	ld	h,-44 (ix)
   14A7 2E 00         [ 7] 1845 	ld	l, #0x00
   14A9 55            [ 4] 1846 	ld	d, l
   14AA 06 08         [ 7] 1847 	ld	b, #0x08
   14AC                    1848 00632$:
   14AC 29            [11] 1849 	add	hl,hl
   14AD 30 01         [12] 1850 	jr	NC,00633$
   14AF 19            [11] 1851 	add	hl,de
   14B0                    1852 00633$:
   14B0 10 FA         [13] 1853 	djnz	00632$
   14B2 DD 75 F2      [19] 1854 	ld	-14 (ix), l
   14B5 7D            [ 4] 1855 	ld	a, l
                           1856 ;src/Renderer.c:608: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   14B6 DD 77 D5      [19] 1857 	ld	-43 (ix), a
   14B9 E6 FC         [ 7] 1858 	and	a, #0xFC
   14BB DD 77 F2      [19] 1859 	ld	-14 (ix), a
   14BE CB C7         [ 8] 1860 	set	0, a
   14C0 DD 77 F2      [19] 1861 	ld	-14 (ix), a
   14C3 CB 3F         [ 8] 1862 	srl	a
   14C5 CB 3F         [ 8] 1863 	srl	a
   14C7 DD 96 C9      [19] 1864 	sub	a, -55 (ix)
   14CA DD 77 EC      [19] 1865 	ld	-20 (ix),a
                           1866 ;src/Renderer.c:610: lastCellWasWall = 0;
   14CD DD 36 E4 00   [19] 1867 	ld	-28 (ix),#0x00
                           1868 ;src/Renderer.c:611: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   14D1 DD 7E D8      [19] 1869 	ld	a,-40 (ix)
   14D4 DD 77 E6      [19] 1870 	ld	-26 (ix),a
   14D7 DD 7E D9      [19] 1871 	ld	a,-39 (ix)
   14DA DD 77 E7      [19] 1872 	ld	-25 (ix),a
   14DD DD CB E6 26   [23] 1873 	sla	-26 (ix)
   14E1 DD CB E7 16   [23] 1874 	rl	-25 (ix)
   14E5 DD 7E D4      [19] 1875 	ld	a,-44 (ix)
   14E8 DD 77 E2      [19] 1876 	ld	-30 (ix),a
   14EB DD 36 E3 00   [19] 1877 	ld	-29 (ix),#0x00
   14EF DD 6E E2      [19] 1878 	ld	l,-30 (ix)
   14F2 DD 66 E3      [19] 1879 	ld	h,-29 (ix)
   14F5 E5            [11] 1880 	push	hl
   14F6 DD 6E E6      [19] 1881 	ld	l,-26 (ix)
   14F9 DD 66 E7      [19] 1882 	ld	h,-25 (ix)
   14FC E5            [11] 1883 	push	hl
   14FD CD 84 49      [17] 1884 	call	__divsint
   1500 F1            [10] 1885 	pop	af
   1501 F1            [10] 1886 	pop	af
   1502 DD 74 E7      [19] 1887 	ld	-25 (ix),h
   1505 DD 75 E6      [19] 1888 	ld	-26 (ix), l
   1508 DD 75 F2      [19] 1889 	ld	-14 (ix), l
   150B DD 7E F8      [19] 1890 	ld	a,-8 (ix)
   150E DD 96 F2      [19] 1891 	sub	a, -14 (ix)
   1511 DD 77 D6      [19] 1892 	ld	-42 (ix),a
                           1893 ;src/Renderer.c:612: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   1514 DD 7E D3      [19] 1894 	ld	a,-45 (ix)
   1517 D6 80         [ 7] 1895 	sub	a, #0x80
   1519 20 04         [12] 1896 	jr	NZ,00271$
   151B 0E 0F         [ 7] 1897 	ld	c,#0x0F
   151D 18 02         [12] 1898 	jr	00272$
   151F                    1899 00271$:
   151F 0E 0D         [ 7] 1900 	ld	c,#0x0D
   1521                    1901 00272$:
   1521 DD 71 D0      [19] 1902 	ld	-48 (ix),c
   1524 18 10         [12] 1903 	jr	00190$
   1526                    1904 00184$:
                           1905 ;src/Renderer.c:616: xHeight = 0;
   1526 DD 36 D6 00   [19] 1906 	ld	-42 (ix),#0x00
                           1907 ;src/Renderer.c:617: lastCellWasWall = 0;
   152A DD 36 E4 00   [19] 1908 	ld	-28 (ix),#0x00
                           1909 ;src/Renderer.c:618: lateralWallSlope=0;
   152E DD 36 D4 00   [19] 1910 	ld	-44 (ix),#0x00
                           1911 ;src/Renderer.c:619: lastWallId=0;
   1532 DD 36 D3 00   [19] 1912 	ld	-45 (ix),#0x00
   1536                    1913 00190$:
                           1914 ;src/Renderer.c:623: newCell=0;
   1536 DD 36 D2 00   [19] 1915 	ld	-46 (ix),#0x00
   153A                    1916 00195$:
                           1917 ;src/Renderer.c:626: if (lateralWallCounter > 0)
   153A DD 7E EC      [19] 1918 	ld	a,-20 (ix)
   153D B7            [ 4] 1919 	or	a, a
   153E 28 1E         [12] 1920 	jr	Z,00201$
                           1921 ;src/Renderer.c:629: if (lateralWallSlope != 0)
   1540 DD 7E D4      [19] 1922 	ld	a,-44 (ix)
   1543 B7            [ 4] 1923 	or	a, a
   1544 28 15         [12] 1924 	jr	Z,00199$
                           1925 ;src/Renderer.c:631: if (lateralWallSlopeCounter == lateralWallSlope)
   1546 DD 7E D4      [19] 1926 	ld	a,-44 (ix)
   1549 DD 96 CF      [19] 1927 	sub	a, -49 (ix)
   154C 20 0A         [12] 1928 	jr	NZ,00197$
                           1929 ;src/Renderer.c:633: lateralWallSlopeCounter = 0;
   154E DD 36 CF 00   [19] 1930 	ld	-49 (ix),#0x00
                           1931 ;src/Renderer.c:634: xHeight -= 2;
   1552 DD 35 D6      [23] 1932 	dec	-42 (ix)
   1555 DD 35 D6      [23] 1933 	dec	-42 (ix)
   1558                    1934 00197$:
                           1935 ;src/Renderer.c:636: ++lateralWallSlopeCounter;
   1558 DD 34 CF      [23] 1936 	inc	-49 (ix)
   155B                    1937 00199$:
                           1938 ;src/Renderer.c:639: --lateralWallCounter;
   155B DD 35 EC      [23] 1939 	dec	-20 (ix)
   155E                    1940 00201$:
                           1941 ;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   155E DD 7E C8      [19] 1942 	ld	a,-56 (ix)
   1561 DD 77 E6      [19] 1943 	ld	-26 (ix),a
   1564 DD 36 E7 00   [19] 1944 	ld	-25 (ix),#0x00
                           1945 ;src/Renderer.c:642: if (!(x%2))
   1568 DD 7E DC      [19] 1946 	ld	a,-36 (ix)
   156B B7            [ 4] 1947 	or	a, a
   156C 20 74         [12] 1948 	jr	NZ,00210$
                           1949 ;src/Renderer.c:645: draw_column_to_buffer_untextured(x/2, xHeight, color);
   156E DD 7E C7      [19] 1950 	ld	a,-57 (ix)
   1571 CB 3F         [ 8] 1951 	srl	a
   1573 DD 77 DC      [19] 1952 	ld	-36 (ix),a
                           1953 ;src/Renderer.c:644: if(xHeight > 0){
   1576 DD 7E D6      [19] 1954 	ld	a,-42 (ix)
   1579 B7            [ 4] 1955 	or	a, a
   157A 28 11         [12] 1956 	jr	Z,00203$
                           1957 ;src/Renderer.c:645: draw_column_to_buffer_untextured(x/2, xHeight, color);
   157C DD 66 D0      [19] 1958 	ld	h,-48 (ix)
   157F DD 6E D6      [19] 1959 	ld	l,-42 (ix)
   1582 E5            [11] 1960 	push	hl
   1583 DD 7E DC      [19] 1961 	ld	a,-36 (ix)
   1586 F5            [11] 1962 	push	af
   1587 33            [ 6] 1963 	inc	sp
   1588 CD BD 0A      [17] 1964 	call	_draw_column_to_buffer_untextured
   158B F1            [10] 1965 	pop	af
   158C 33            [ 6] 1966 	inc	sp
   158D                    1967 00203$:
                           1968 ;src/Renderer.c:648: if(!(currentCellID&CELL_WALL_MASK)){
   158D DD 7E FE      [19] 1969 	ld	a,-2 (ix)
   1590 B7            [ 4] 1970 	or	a, a
   1591 20 4F         [12] 1971 	jr	NZ,00210$
                           1972 ;src/Renderer.c:649: if(currentCellID&CELL_ENEMY_MASK){
   1593 DD 7E D1      [19] 1973 	ld	a,-47 (ix)
   1596 E6 0F         [ 7] 1974 	and	a, #0x0F
   1598 28 48         [12] 1975 	jr	Z,00210$
                           1976 ;src/Renderer.c:650: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   159A DD 7E D8      [19] 1977 	ld	a,-40 (ix)
   159D DD 77 FE      [19] 1978 	ld	-2 (ix),a
   15A0 DD 7E D9      [19] 1979 	ld	a,-39 (ix)
   15A3 DD 77 FF      [19] 1980 	ld	-1 (ix),a
   15A6 3E 06         [ 7] 1981 	ld	a,#0x05+1
   15A8 18 08         [12] 1982 	jr	00642$
   15AA                    1983 00641$:
   15AA DD CB FE 26   [23] 1984 	sla	-2 (ix)
   15AE DD CB FF 16   [23] 1985 	rl	-1 (ix)
   15B2                    1986 00642$:
   15B2 3D            [ 4] 1987 	dec	a
   15B3 20 F5         [12] 1988 	jr	NZ,00641$
   15B5 DD 6E E6      [19] 1989 	ld	l,-26 (ix)
   15B8 DD 66 E7      [19] 1990 	ld	h,-25 (ix)
   15BB E5            [11] 1991 	push	hl
   15BC DD 6E FE      [19] 1992 	ld	l,-2 (ix)
   15BF DD 66 FF      [19] 1993 	ld	h,-1 (ix)
   15C2 E5            [11] 1994 	push	hl
   15C3 CD 84 49      [17] 1995 	call	__divsint
   15C6 F1            [10] 1996 	pop	af
   15C7 F1            [10] 1997 	pop	af
   15C8 DD 74 FF      [19] 1998 	ld	-1 (ix),h
   15CB DD 75 FE      [19] 1999 	ld	-2 (ix), l
   15CE 45            [ 4] 2000 	ld	b, l
   15CF C5            [11] 2001 	push	bc
   15D0 33            [ 6] 2002 	inc	sp
   15D1 DD 66 D1      [19] 2003 	ld	h,-47 (ix)
   15D4 DD 6E C8      [19] 2004 	ld	l,-56 (ix)
   15D7 E5            [11] 2005 	push	hl
   15D8 DD 7E DC      [19] 2006 	ld	a,-36 (ix)
   15DB F5            [11] 2007 	push	af
   15DC 33            [ 6] 2008 	inc	sp
   15DD CD 34 0B      [17] 2009 	call	_draw_column_to_buffer_enemy
   15E0 F1            [10] 2010 	pop	af
   15E1 F1            [10] 2011 	pop	af
                           2012 ;src/Renderer.c:652: else if(currentCellID&CELL_ITEM_MASK){
   15E2                    2013 00210$:
                           2014 ;src/Renderer.c:658: ++xCellCount;
   15E2 DD 34 C9      [23] 2015 	inc	-55 (ix)
                           2016 ;src/Renderer.c:579: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   15E5 DD 34 C7      [23] 2017 	inc	-57 (ix)
                           2018 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   15E8 2A B6 0A      [16] 2019 	ld	hl,(_cells_in_view_array)
   15EB DD 75 E8      [19] 2020 	ld	-24 (ix),l
   15EE DD 74 E9      [19] 2021 	ld	-23 (ix),h
                           2022 ;src/Renderer.c:579: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   15F1 DD 7E C7      [19] 2023 	ld	a,-57 (ix)
   15F4 D6 50         [ 7] 2024 	sub	a, #0x50
   15F6 DA CB 13      [10] 2025 	jp	C,00256$
                           2026 ;src/Renderer.c:665: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   15F9 DD 7E C6      [19] 2027 	ld	a,-58 (ix)
   15FC B7            [ 4] 2028 	or	a, a
   15FD 28 08         [12] 2029 	jr	Z,00273$
   15FF DD 7E EF      [19] 2030 	ld	a,-17 (ix)
   1602 DD 77 EF      [19] 2031 	ld	-17 (ix),a
   1605 18 04         [12] 2032 	jr	00274$
   1607                    2033 00273$:
   1607 DD 36 EF 00   [19] 2034 	ld	-17 (ix),#0x00
   160B                    2035 00274$:
   160B DD 7E EF      [19] 2036 	ld	a,-17 (ix)
   160E DD 77 EF      [19] 2037 	ld	-17 (ix),a
                           2038 ;src/Renderer.c:666: lateralWallSlope=0;
   1611 DD 36 EC 00   [19] 2039 	ld	-20 (ix),#0x00
                           2040 ;src/Renderer.c:667: lateralWallSlopeCounter=0;
   1615 DD 36 EA 00   [19] 2041 	ld	-22 (ix),#0x00
                           2042 ;src/Renderer.c:668: xHeight=0;
   1619 DD 36 E4 00   [19] 2043 	ld	-28 (ix),#0x00
                           2044 ;src/Renderer.c:670: lateralWallCounter = 0;
   161D DD 36 DC 00   [19] 2045 	ld	-36 (ix),#0x00
                           2046 ;src/Renderer.c:433: lineEnd = lineStart + offsetDiff * 2 + 2;
   1621 DD 7E CE      [19] 2047 	ld	a,-50 (ix)
   1624 87            [ 4] 2048 	add	a, a
   1625 DD 77 FE      [19] 2049 	ld	-2 (ix),a
   1628 DD 7E CC      [19] 2050 	ld	a,-52 (ix)
   162B DD 86 FE      [19] 2051 	add	a, -2 (ix)
                           2052 ;src/Renderer.c:671: lineEnd = lineStart + offsetDiff * 2 + 2;
   162E DD 77 FE      [19] 2053 	ld	-2 (ix), a
   1631 C6 02         [ 7] 2054 	add	a, #0x02
   1633 DD 77 CD      [19] 2055 	ld	-51 (ix),a
                           2056 ;src/Renderer.c:673: newCell=1;
   1636 DD 36 F2 01   [19] 2057 	ld	-14 (ix),#0x01
                           2058 ;src/Renderer.c:436: currentCellID = cells_in_view_array[lineEnd - 1];
   163A DD 7E CD      [19] 2059 	ld	a,-51 (ix)
   163D DD 77 D8      [19] 2060 	ld	-40 (ix),a
   1640 DD 36 D9 00   [19] 2061 	ld	-39 (ix),#0x00
                           2062 ;src/Renderer.c:674: currentCellID = cells_in_view_array[lineEnd - 1];
   1644 DD 7E D8      [19] 2063 	ld	a,-40 (ix)
   1647 C6 FF         [ 7] 2064 	add	a,#0xFF
   1649 DD 77 E2      [19] 2065 	ld	-30 (ix),a
   164C DD 7E D9      [19] 2066 	ld	a,-39 (ix)
   164F CE FF         [ 7] 2067 	adc	a,#0xFF
   1651 DD 77 E3      [19] 2068 	ld	-29 (ix),a
   1654 DD 7E E8      [19] 2069 	ld	a,-24 (ix)
   1657 DD 86 E2      [19] 2070 	add	a, -30 (ix)
   165A DD 77 E2      [19] 2071 	ld	-30 (ix),a
   165D DD 7E E9      [19] 2072 	ld	a,-23 (ix)
   1660 DD 8E E3      [19] 2073 	adc	a, -29 (ix)
   1663 DD 77 E3      [19] 2074 	ld	-29 (ix),a
   1666 DD 6E E2      [19] 2075 	ld	l,-30 (ix)
   1669 DD 66 E3      [19] 2076 	ld	h,-29 (ix)
   166C 7E            [ 7] 2077 	ld	a,(hl)
   166D DD 77 DF      [19] 2078 	ld	-33 (ix),a
                           2079 ;src/Renderer.c:676: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   1670 DD 7E E8      [19] 2080 	ld	a,-24 (ix)
   1673 DD 86 CD      [19] 2081 	add	a, -51 (ix)
   1676 DD 77 E2      [19] 2082 	ld	-30 (ix),a
   1679 DD 7E E9      [19] 2083 	ld	a,-23 (ix)
   167C CE 00         [ 7] 2084 	adc	a, #0x00
   167E DD 77 E3      [19] 2085 	ld	-29 (ix),a
   1681 DD 6E E2      [19] 2086 	ld	l,-30 (ix)
   1684 DD 66 E3      [19] 2087 	ld	h,-29 (ix)
   1687 7E            [ 7] 2088 	ld	a,(hl)
   1688 DD 77 E1      [19] 2089 	ld	-31 (ix),a
                           2090 ;src/Renderer.c:677: if(lastCellWasWall&CELL_WALL_MASK){
   168B DD CB E1 7E   [20] 2091 	bit	7, -31 (ix)
   168F 28 06         [12] 2092 	jr	Z,00213$
                           2093 ;src/Renderer.c:678: lastWallId=lastCellWasWall;
                           2094 ;src/Renderer.c:679: lastCellWasWall=1;
   1691 DD 36 DE 01   [19] 2095 	ld	-34 (ix),#0x01
   1695 18 08         [12] 2096 	jr	00356$
   1697                    2097 00213$:
                           2098 ;src/Renderer.c:682: lastCellWasWall=0;
   1697 DD 36 DE 00   [19] 2099 	ld	-34 (ix),#0x00
                           2100 ;src/Renderer.c:683: lastWallId=CELLTYPE_FLOOR;
   169B DD 36 E1 00   [19] 2101 	ld	-31 (ix),#0x00
                           2102 ;src/Renderer.c:686: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   169F                    2103 00356$:
   169F DD 36 CA 00   [19] 2104 	ld	-54 (ix),#0x00
   16A3 DD 36 C7 9F   [19] 2105 	ld	-57 (ix),#0x9F
   16A7                    2106 00258$:
                           2107 ;src/Renderer.c:689: if (xCellCount == zHeight)
   16A7 DD 7E C8      [19] 2108 	ld	a,-56 (ix)
   16AA DD 96 EF      [19] 2109 	sub	a, -17 (ix)
   16AD 20 50         [12] 2110 	jr	NZ,00216$
                           2111 ;src/Renderer.c:691: ++xCell;
   16AF DD 34 CA      [23] 2112 	inc	-54 (ix)
                           2113 ;src/Renderer.c:692: xCellCount = 0;
   16B2 DD 36 EF 00   [19] 2114 	ld	-17 (ix),#0x00
                           2115 ;src/Renderer.c:693: newCell=1;
   16B6 DD 36 F2 01   [19] 2116 	ld	-14 (ix),#0x01
                           2117 ;src/Renderer.c:694: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   16BA DD 7E CA      [19] 2118 	ld	a,-54 (ix)
   16BD DD 77 E2      [19] 2119 	ld	-30 (ix),a
   16C0 DD 36 E3 00   [19] 2120 	ld	-29 (ix),#0x00
   16C4 DD 7E D8      [19] 2121 	ld	a,-40 (ix)
   16C7 DD 96 E2      [19] 2122 	sub	a, -30 (ix)
   16CA DD 77 E2      [19] 2123 	ld	-30 (ix),a
   16CD DD 7E D9      [19] 2124 	ld	a,-39 (ix)
   16D0 DD 9E E3      [19] 2125 	sbc	a, -29 (ix)
   16D3 DD 77 E3      [19] 2126 	ld	-29 (ix),a
   16D6 DD 6E E2      [19] 2127 	ld	l,-30 (ix)
   16D9 DD 66 E3      [19] 2128 	ld	h,-29 (ix)
   16DC 2B            [ 6] 2129 	dec	hl
   16DD DD 75 E2      [19] 2130 	ld	-30 (ix),l
   16E0 DD 74 E3      [19] 2131 	ld	-29 (ix),h
   16E3 DD 7E E8      [19] 2132 	ld	a,-24 (ix)
   16E6 DD 86 E2      [19] 2133 	add	a, -30 (ix)
   16E9 DD 77 E2      [19] 2134 	ld	-30 (ix),a
   16EC DD 7E E9      [19] 2135 	ld	a,-23 (ix)
   16EF DD 8E E3      [19] 2136 	adc	a, -29 (ix)
   16F2 DD 77 E3      [19] 2137 	ld	-29 (ix),a
   16F5 DD 6E E2      [19] 2138 	ld	l,-30 (ix)
   16F8 DD 66 E3      [19] 2139 	ld	h,-29 (ix)
   16FB 7E            [ 7] 2140 	ld	a,(hl)
   16FC DD 77 DF      [19] 2141 	ld	-33 (ix),a
   16FF                    2142 00216$:
                           2143 ;src/Renderer.c:696: if(!(x%2)){
   16FF DD 7E C7      [19] 2144 	ld	a,-57 (ix)
   1702 E6 01         [ 7] 2145 	and	a, #0x01
   1704 DD 77 DA      [19] 2146 	ld	-38 (ix),a
                           2147 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   1707 DD 7E DF      [19] 2148 	ld	a,-33 (ix)
   170A E6 80         [ 7] 2149 	and	a, #0x80
   170C DD 77 E2      [19] 2150 	ld	-30 (ix),a
                           2151 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   170F DD 7E EF      [19] 2152 	ld	a,-17 (ix)
   1712 DD 77 F4      [19] 2153 	ld	-12 (ix),a
   1715 DD 36 F5 00   [19] 2154 	ld	-11 (ix),#0x00
                           2155 ;src/Renderer.c:696: if(!(x%2)){
   1719 DD 7E DA      [19] 2156 	ld	a,-38 (ix)
   171C B7            [ 4] 2157 	or	a, a
   171D C2 4B 18      [10] 2158 	jp	NZ,00229$
                           2159 ;src/Renderer.c:697: if (lateralWallCounter == 0 || newCell)
   1720 DD 7E DC      [19] 2160 	ld	a,-36 (ix)
   1723 B7            [ 4] 2161 	or	a, a
   1724 28 07         [12] 2162 	jr	Z,00225$
   1726 DD 7E F2      [19] 2163 	ld	a,-14 (ix)
   1729 B7            [ 4] 2164 	or	a, a
   172A CA 4B 18      [10] 2165 	jp	Z,00229$
   172D                    2166 00225$:
                           2167 ;src/Renderer.c:699: if ( currentCellID & CELL_WALL_MASK)//Wall
   172D DD 7E E2      [19] 2168 	ld	a,-30 (ix)
   1730 B7            [ 4] 2169 	or	a, a
   1731 28 32         [12] 2170 	jr	Z,00223$
                           2171 ;src/Renderer.c:701: lateralWallCounter = 0;
   1733 DD 36 DC 00   [19] 2172 	ld	-36 (ix),#0x00
                           2173 ;src/Renderer.c:702: lateralWallSlope = 0;
   1737 DD 36 EC 00   [19] 2174 	ld	-20 (ix),#0x00
                           2175 ;src/Renderer.c:703: xHeight = zHeight;
   173B DD 7E C8      [19] 2176 	ld	a,-56 (ix)
   173E DD 77 E4      [19] 2177 	ld	-28 (ix),a
                           2178 ;src/Renderer.c:704: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   1741 DD 7E DF      [19] 2179 	ld	a,-33 (ix)
   1744 D6 80         [ 7] 2180 	sub	a, #0x80
   1746 20 06         [12] 2181 	jr	NZ,00275$
   1748 DD 36 DB 0C   [19] 2182 	ld	-37 (ix),#0x0C
   174C 18 04         [12] 2183 	jr	00276$
   174E                    2184 00275$:
   174E DD 36 DB 0E   [19] 2185 	ld	-37 (ix),#0x0E
   1752                    2186 00276$:
   1752 DD 7E DB      [19] 2187 	ld	a,-37 (ix)
   1755 DD 77 D0      [19] 2188 	ld	-48 (ix),a
                           2189 ;src/Renderer.c:705: lastCellWasWall = 1;
   1758 DD 36 DE 01   [19] 2190 	ld	-34 (ix),#0x01
                           2191 ;src/Renderer.c:706: lastWallId=currentCellID;
   175C DD 7E DF      [19] 2192 	ld	a,-33 (ix)
   175F DD 77 E1      [19] 2193 	ld	-31 (ix),a
   1762 C3 47 18      [10] 2194 	jp	00224$
   1765                    2195 00223$:
                           2196 ;src/Renderer.c:708: else if(lateralWallCounter==0){
   1765 DD 7E DC      [19] 2197 	ld	a,-36 (ix)
   1768 B7            [ 4] 2198 	or	a, a
   1769 C2 47 18      [10] 2199 	jp	NZ,00224$
                           2200 ;src/Renderer.c:709: if (lastCellWasWall)
   176C DD 7E DE      [19] 2201 	ld	a,-34 (ix)
   176F B7            [ 4] 2202 	or	a, a
   1770 CA 37 18      [10] 2203 	jp	Z,00218$
                           2204 ;src/Renderer.c:712: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   1773 DD 7E CE      [19] 2205 	ld	a,-50 (ix)
   1776 DD 96 CA      [19] 2206 	sub	a, -54 (ix)
   1779 87            [ 4] 2207 	add	a, a
   177A 3C            [ 4] 2208 	inc	a
                           2209 ;src/Renderer.c:713: lateralWallSlopeCounter = lateralWallSlope / 2;
   177B DD 77 EC      [19] 2210 	ld	-20 (ix), a
   177E CB 3F         [ 8] 2211 	srl	a
   1780 DD 77 EA      [19] 2212 	ld	-22 (ix),a
                           2213 ;src/Renderer.c:714: lateralWallCounter = lateralWallSlope * zHeight;
   1783 DD 5E C8      [19] 2214 	ld	e,-56 (ix)
   1786 DD 66 EC      [19] 2215 	ld	h,-20 (ix)
   1789 2E 00         [ 7] 2216 	ld	l, #0x00
   178B 55            [ 4] 2217 	ld	d, l
   178C 06 08         [ 7] 2218 	ld	b, #0x08
   178E                    2219 00648$:
   178E 29            [11] 2220 	add	hl,hl
   178F 30 01         [12] 2221 	jr	NC,00649$
   1791 19            [11] 2222 	add	hl,de
   1792                    2223 00649$:
   1792 10 FA         [13] 2224 	djnz	00648$
                           2225 ;src/Renderer.c:715: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   1794 DD 75 DB      [19] 2226 	ld	-37 (ix), l
   1797 DD 75 F6      [19] 2227 	ld	-10 (ix), l
   179A DD 36 F7 00   [19] 2228 	ld	-9 (ix),#0x00
   179E DD 7E DB      [19] 2229 	ld	a,-37 (ix)
   17A1 E6 03         [ 7] 2230 	and	a, #0x03
   17A3 DD 77 DB      [19] 2231 	ld	-37 (ix), a
   17A6 DD 77 F9      [19] 2232 	ld	-7 (ix),a
   17A9 DD 36 FA 00   [19] 2233 	ld	-6 (ix),#0x00
   17AD DD 7E F6      [19] 2234 	ld	a,-10 (ix)
   17B0 DD 96 F9      [19] 2235 	sub	a, -7 (ix)
   17B3 DD 77 F9      [19] 2236 	ld	-7 (ix),a
   17B6 DD 7E F7      [19] 2237 	ld	a,-9 (ix)
   17B9 DD 9E FA      [19] 2238 	sbc	a, -6 (ix)
   17BC DD 77 FA      [19] 2239 	ld	-6 (ix),a
   17BF DD 7E F9      [19] 2240 	ld	a,-7 (ix)
   17C2 C6 01         [ 7] 2241 	add	a, #0x01
   17C4 DD 77 F6      [19] 2242 	ld	-10 (ix),a
   17C7 DD 7E FA      [19] 2243 	ld	a,-6 (ix)
   17CA CE 00         [ 7] 2244 	adc	a, #0x00
   17CC DD 77 F7      [19] 2245 	ld	-9 (ix),a
   17CF DD 7E F6      [19] 2246 	ld	a,-10 (ix)
   17D2 DD 77 FC      [19] 2247 	ld	-4 (ix),a
   17D5 DD 7E F7      [19] 2248 	ld	a,-9 (ix)
   17D8 DD 77 FD      [19] 2249 	ld	-3 (ix),a
   17DB DD CB F7 7E   [20] 2250 	bit	7, -9 (ix)
   17DF 28 10         [12] 2251 	jr	Z,00277$
   17E1 DD 7E F9      [19] 2252 	ld	a,-7 (ix)
   17E4 C6 04         [ 7] 2253 	add	a, #0x04
   17E6 DD 77 FC      [19] 2254 	ld	-4 (ix),a
   17E9 DD 7E FA      [19] 2255 	ld	a,-6 (ix)
   17EC CE 00         [ 7] 2256 	adc	a, #0x00
   17EE DD 77 FD      [19] 2257 	ld	-3 (ix),a
   17F1                    2258 00277$:
   17F1 DD 4E FC      [19] 2259 	ld	c,-4 (ix)
   17F4 DD 46 FD      [19] 2260 	ld	b,-3 (ix)
   17F7 CB 28         [ 8] 2261 	sra	b
   17F9 CB 19         [ 8] 2262 	rr	c
   17FB CB 28         [ 8] 2263 	sra	b
   17FD CB 19         [ 8] 2264 	rr	c
   17FF DD 46 EF      [19] 2265 	ld	b,-17 (ix)
   1802 79            [ 4] 2266 	ld	a,c
   1803 90            [ 4] 2267 	sub	a, b
   1804 DD 77 DC      [19] 2268 	ld	-36 (ix),a
                           2269 ;src/Renderer.c:717: lastCellWasWall = 0;
   1807 DD 36 DE 00   [19] 2270 	ld	-34 (ix),#0x00
                           2271 ;src/Renderer.c:718: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   180B DD 6E F4      [19] 2272 	ld	l,-12 (ix)
   180E DD 66 F5      [19] 2273 	ld	h,-11 (ix)
   1811 29            [11] 2274 	add	hl, hl
   1812 DD 4E EC      [19] 2275 	ld	c,-20 (ix)
   1815 06 00         [ 7] 2276 	ld	b,#0x00
   1817 C5            [11] 2277 	push	bc
   1818 E5            [11] 2278 	push	hl
   1819 CD 84 49      [17] 2279 	call	__divsint
   181C F1            [10] 2280 	pop	af
   181D F1            [10] 2281 	pop	af
   181E DD 7E F8      [19] 2282 	ld	a,-8 (ix)
   1821 95            [ 4] 2283 	sub	a, l
   1822 DD 77 E4      [19] 2284 	ld	-28 (ix),a
                           2285 ;src/Renderer.c:719: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   1825 DD 7E E1      [19] 2286 	ld	a,-31 (ix)
   1828 D6 80         [ 7] 2287 	sub	a, #0x80
   182A 20 04         [12] 2288 	jr	NZ,00278$
   182C 0E 0F         [ 7] 2289 	ld	c,#0x0F
   182E 18 02         [12] 2290 	jr	00279$
   1830                    2291 00278$:
   1830 0E 0D         [ 7] 2292 	ld	c,#0x0D
   1832                    2293 00279$:
   1832 DD 71 D0      [19] 2294 	ld	-48 (ix),c
   1835 18 10         [12] 2295 	jr	00224$
   1837                    2296 00218$:
                           2297 ;src/Renderer.c:723: xHeight = 0;
   1837 DD 36 E4 00   [19] 2298 	ld	-28 (ix),#0x00
                           2299 ;src/Renderer.c:724: lastCellWasWall = 0;
   183B DD 36 DE 00   [19] 2300 	ld	-34 (ix),#0x00
                           2301 ;src/Renderer.c:725: lateralWallSlope=0;
   183F DD 36 EC 00   [19] 2302 	ld	-20 (ix),#0x00
                           2303 ;src/Renderer.c:726: lastWallId=0;
   1843 DD 36 E1 00   [19] 2304 	ld	-31 (ix),#0x00
   1847                    2305 00224$:
                           2306 ;src/Renderer.c:729: newCell=0;
   1847 DD 36 F2 00   [19] 2307 	ld	-14 (ix),#0x00
   184B                    2308 00229$:
                           2309 ;src/Renderer.c:734: if (lateralWallCounter > 0)
   184B DD 7E DC      [19] 2310 	ld	a,-36 (ix)
   184E B7            [ 4] 2311 	or	a, a
   184F 28 1E         [12] 2312 	jr	Z,00235$
                           2313 ;src/Renderer.c:737: if (lateralWallSlope != 0)
   1851 DD 7E EC      [19] 2314 	ld	a,-20 (ix)
   1854 B7            [ 4] 2315 	or	a, a
   1855 28 15         [12] 2316 	jr	Z,00233$
                           2317 ;src/Renderer.c:739: if (lateralWallSlopeCounter == lateralWallSlope)
   1857 DD 7E EC      [19] 2318 	ld	a,-20 (ix)
   185A DD 96 EA      [19] 2319 	sub	a, -22 (ix)
   185D 20 0A         [12] 2320 	jr	NZ,00231$
                           2321 ;src/Renderer.c:741: lateralWallSlopeCounter = 0;
   185F DD 36 EA 00   [19] 2322 	ld	-22 (ix),#0x00
                           2323 ;src/Renderer.c:742: xHeight -= 2;
   1863 DD 35 E4      [23] 2324 	dec	-28 (ix)
   1866 DD 35 E4      [23] 2325 	dec	-28 (ix)
   1869                    2326 00231$:
                           2327 ;src/Renderer.c:744: ++lateralWallSlopeCounter;
   1869 DD 34 EA      [23] 2328 	inc	-22 (ix)
   186C                    2329 00233$:
                           2330 ;src/Renderer.c:746: --lateralWallCounter;
   186C DD 35 DC      [23] 2331 	dec	-36 (ix)
   186F                    2332 00235$:
                           2333 ;src/Renderer.c:750: if (!(x%2))
   186F DD 7E DA      [19] 2334 	ld	a,-38 (ix)
   1872 B7            [ 4] 2335 	or	a, a
   1873 20 5B         [12] 2336 	jr	NZ,00244$
                           2337 ;src/Renderer.c:755: draw_column_to_buffer_untextured(x/2, xHeight, color);
   1875 DD 46 C7      [19] 2338 	ld	b,-57 (ix)
   1878 CB 38         [ 8] 2339 	srl	b
                           2340 ;src/Renderer.c:753: if(xHeight > 0){
   187A DD 7E E4      [19] 2341 	ld	a,-28 (ix)
   187D B7            [ 4] 2342 	or	a, a
   187E 28 10         [12] 2343 	jr	Z,00237$
                           2344 ;src/Renderer.c:755: draw_column_to_buffer_untextured(x/2, xHeight, color);
   1880 C5            [11] 2345 	push	bc
   1881 DD 66 D0      [19] 2346 	ld	h,-48 (ix)
   1884 DD 6E E4      [19] 2347 	ld	l,-28 (ix)
   1887 E5            [11] 2348 	push	hl
   1888 C5            [11] 2349 	push	bc
   1889 33            [ 6] 2350 	inc	sp
   188A CD BD 0A      [17] 2351 	call	_draw_column_to_buffer_untextured
   188D F1            [10] 2352 	pop	af
   188E 33            [ 6] 2353 	inc	sp
   188F C1            [10] 2354 	pop	bc
   1890                    2355 00237$:
                           2356 ;src/Renderer.c:758: if(!(currentCellID&CELL_WALL_MASK)){
   1890 DD 7E E2      [19] 2357 	ld	a,-30 (ix)
   1893 B7            [ 4] 2358 	or	a, a
   1894 20 3A         [12] 2359 	jr	NZ,00244$
                           2360 ;src/Renderer.c:759: if(currentCellID&CELL_ENEMY_MASK){
   1896 DD 7E DF      [19] 2361 	ld	a,-33 (ix)
   1899 E6 0F         [ 7] 2362 	and	a, #0x0F
   189B 28 33         [12] 2363 	jr	Z,00244$
                           2364 ;src/Renderer.c:760: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   189D DD 7E E6      [19] 2365 	ld	a,-26 (ix)
   18A0 DD 96 F4      [19] 2366 	sub	a, -12 (ix)
   18A3 6F            [ 4] 2367 	ld	l,a
   18A4 DD 7E E7      [19] 2368 	ld	a,-25 (ix)
   18A7 DD 9E F5      [19] 2369 	sbc	a, -11 (ix)
   18AA 67            [ 4] 2370 	ld	h,a
   18AB 29            [11] 2371 	add	hl, hl
   18AC 29            [11] 2372 	add	hl, hl
   18AD 29            [11] 2373 	add	hl, hl
   18AE 29            [11] 2374 	add	hl, hl
   18AF 29            [11] 2375 	add	hl, hl
   18B0 C5            [11] 2376 	push	bc
   18B1 DD 5E E6      [19] 2377 	ld	e,-26 (ix)
   18B4 DD 56 E7      [19] 2378 	ld	d,-25 (ix)
   18B7 D5            [11] 2379 	push	de
   18B8 E5            [11] 2380 	push	hl
   18B9 CD 84 49      [17] 2381 	call	__divsint
   18BC F1            [10] 2382 	pop	af
   18BD F1            [10] 2383 	pop	af
   18BE 55            [ 4] 2384 	ld	d,l
   18BF C1            [10] 2385 	pop	bc
   18C0 D5            [11] 2386 	push	de
   18C1 33            [ 6] 2387 	inc	sp
   18C2 DD 66 DF      [19] 2388 	ld	h,-33 (ix)
   18C5 DD 6E C8      [19] 2389 	ld	l,-56 (ix)
   18C8 E5            [11] 2390 	push	hl
   18C9 C5            [11] 2391 	push	bc
   18CA 33            [ 6] 2392 	inc	sp
   18CB CD 34 0B      [17] 2393 	call	_draw_column_to_buffer_enemy
   18CE F1            [10] 2394 	pop	af
   18CF F1            [10] 2395 	pop	af
                           2396 ;src/Renderer.c:762: else if(currentCellID&CELL_ITEM_MASK){
   18D0                    2397 00244$:
                           2398 ;src/Renderer.c:767: ++xCellCount;
   18D0 DD 34 EF      [23] 2399 	inc	-17 (ix)
                           2400 ;src/Renderer.c:686: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   18D3 DD 35 C7      [23] 2401 	dec	-57 (ix)
                           2402 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   18D6 2A B6 0A      [16] 2403 	ld	hl,(_cells_in_view_array)
   18D9 DD 75 E8      [19] 2404 	ld	-24 (ix),l
   18DC DD 74 E9      [19] 2405 	ld	-23 (ix),h
                           2406 ;src/Renderer.c:686: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   18DF DD 7E C7      [19] 2407 	ld	a,-57 (ix)
   18E2 D6 50         [ 7] 2408 	sub	a, #0x50
   18E4 D2 A7 16      [10] 2409 	jp	NC,00258$
                           2410 ;src/Renderer.c:774: lineStart = lineStart + (offsetDiff * 2) + 3;
   18E7 DD 7E FE      [19] 2411 	ld	a,-2 (ix)
   18EA C6 03         [ 7] 2412 	add	a, #0x03
   18EC DD 77 CC      [19] 2413 	ld	-52 (ix),a
                           2414 ;src/Renderer.c:775: zHeight += zHeight;
   18EF DD CB C8 26   [23] 2415 	sla	-56 (ix)
                           2416 ;src/Renderer.c:776: offsetDiff = offsetDiff >> 1;
   18F3 DD CB CE 3E   [23] 2417 	srl	-50 (ix)
                           2418 ;src/Renderer.c:778: }while(z);
   18F7 DD 7E C6      [19] 2419 	ld	a,-58 (ix)
   18FA B7            [ 4] 2420 	or	a, a
   18FB C2 55 13      [10] 2421 	jp	NZ,00246$
   18FE                    2422 00260$:
   18FE DD F9         [10] 2423 	ld	sp, ix
   1900 DD E1         [14] 2424 	pop	ix
   1902 C9            [10] 2425 	ret
                           2426 ;src/Renderer.c:784: void draw_minimap_to_buffer(){
                           2427 ;	---------------------------------
                           2428 ; Function draw_minimap_to_buffer
                           2429 ; ---------------------------------
   1903                    2430 _draw_minimap_to_buffer::
   1903 DD E5         [15] 2431 	push	ix
   1905 DD 21 00 00   [14] 2432 	ld	ix,#0
   1909 DD 39         [15] 2433 	add	ix,sp
   190B 21 F5 FF      [10] 2434 	ld	hl,#-11
   190E 39            [11] 2435 	add	hl,sp
   190F F9            [ 6] 2436 	ld	sp,hl
                           2437 ;src/Renderer.c:787: u8* ptr = MINIMAP_BUFFER;
   1910 01 A0 9A      [10] 2438 	ld	bc,#0x9AA0
                           2439 ;src/Renderer.c:792: y=(player_position.y-MINIMAP_HEIGHT_HALF);
   1913 3A 8A 08      [13] 2440 	ld	a, (#(_player_position + 0x0001) + 0)
   1916 C6 F8         [ 7] 2441 	add	a,#0xF8
   1918 5F            [ 4] 2442 	ld	e,a
                           2443 ;src/Renderer.c:794: for(j=0;j<MINIMAP_HEIGHT;++j){
   1919 16 00         [ 7] 2444 	ld	d,#0x00
                           2445 ;src/Renderer.c:795: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   191B                    2446 00137$:
   191B 7B            [ 4] 2447 	ld	a,e
   191C 07            [ 4] 2448 	rlca
   191D E6 01         [ 7] 2449 	and	a,#0x01
   191F DD 77 FA      [19] 2450 	ld	-6 (ix),a
   1922 7B            [ 4] 2451 	ld	a,e
   1923 EE 80         [ 7] 2452 	xor	a, #0x80
   1925 D6 A0         [ 7] 2453 	sub	a, #0xA0
   1927 3E 00         [ 7] 2454 	ld	a,#0x00
   1929 17            [ 4] 2455 	rla
   192A DD 77 FF      [19] 2456 	ld	-1 (ix),a
   192D DD 36 F6 00   [19] 2457 	ld	-10 (ix),#0x00
   1931                    2458 00122$:
                           2459 ;src/Renderer.c:796: x=(player_position.x-MINIMAP_WIDTH_HALF);
   1931 3A 89 08      [13] 2460 	ld	a, (#_player_position + 0)
   1934 C6 F8         [ 7] 2461 	add	a,#0xF8
   1936 DD 77 F9      [19] 2462 	ld	-7 (ix),a
                           2463 ;src/Renderer.c:797: for(i=0;i<MINIMAP_WIDTH;++i){
   1939 DD 36 F5 00   [19] 2464 	ld	-11 (ix),#0x00
   193D                    2465 00120$:
                           2466 ;src/Renderer.c:800: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   193D FD 21 10 00   [14] 2467 	ld	iy,#0x0010
   1941 FD 09         [15] 2468 	add	iy, bc
                           2469 ;src/Renderer.c:798: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
   1943 DD CB F9 7E   [20] 2470 	bit	7, -7 (ix)
   1947 20 15         [12] 2471 	jr	NZ,00111$
   1949 DD 7E F9      [19] 2472 	ld	a,-7 (ix)
   194C EE 80         [ 7] 2473 	xor	a, #0x80
   194E D6 A0         [ 7] 2474 	sub	a, #0xA0
   1950 30 0C         [12] 2475 	jr	NC,00111$
   1952 DD 7E FA      [19] 2476 	ld	a,-6 (ix)
   1955 B7            [ 4] 2477 	or	a, a
   1956 20 06         [12] 2478 	jr	NZ,00111$
   1958 DD CB FF 46   [20] 2479 	bit	0,-1 (ix)
   195C 20 0D         [12] 2480 	jr	NZ,00112$
   195E                    2481 00111$:
                           2482 ;src/Renderer.c:799: *ptr=g_colors[MINIMAP_WALL_COLOR];
   195E 3A A4 0A      [13] 2483 	ld	a, (#(_g_colors + 0x0001) + 0)
   1961 02            [ 7] 2484 	ld	(bc),a
                           2485 ;src/Renderer.c:800: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   1962 3A A4 0A      [13] 2486 	ld	a, (#(_g_colors + 0x0001) + 0)
   1965 FD 77 00      [19] 2487 	ld	0 (iy), a
   1968 C3 12 1A      [10] 2488 	jp	00113$
   196B                    2489 00112$:
                           2490 ;src/Renderer.c:802: else if((x==player_position.x)&&(y==player_position.y)){
   196B DD 7E F9      [19] 2491 	ld	a,-7 (ix)
   196E DD 77 FD      [19] 2492 	ld	-3 (ix),a
   1971 DD 7E F9      [19] 2493 	ld	a,-7 (ix)
   1974 17            [ 4] 2494 	rla
   1975 9F            [ 4] 2495 	sbc	a, a
   1976 DD 77 FE      [19] 2496 	ld	-2 (ix),a
   1979 3A 89 08      [13] 2497 	ld	a, (#_player_position + 0)
   197C DD 77 F7      [19] 2498 	ld	-9 (ix),a
   197F DD 36 F8 00   [19] 2499 	ld	-8 (ix),#0x00
   1983 DD 73 FB      [19] 2500 	ld	-5 (ix),e
   1986 7B            [ 4] 2501 	ld	a,e
   1987 17            [ 4] 2502 	rla
   1988 9F            [ 4] 2503 	sbc	a, a
   1989 DD 77 FC      [19] 2504 	ld	-4 (ix),a
   198C DD 7E FD      [19] 2505 	ld	a,-3 (ix)
   198F DD 96 F7      [19] 2506 	sub	a, -9 (ix)
   1992 20 2E         [12] 2507 	jr	NZ,00108$
   1994 DD 7E FE      [19] 2508 	ld	a,-2 (ix)
   1997 DD 96 F8      [19] 2509 	sub	a, -8 (ix)
   199A 20 26         [12] 2510 	jr	NZ,00108$
   199C 3A 8A 08      [13] 2511 	ld	a, (#(_player_position + 0x0001) + 0)
   199F DD 77 F7      [19] 2512 	ld	-9 (ix),a
   19A2 DD 36 F8 00   [19] 2513 	ld	-8 (ix),#0x00
   19A6 DD 7E FB      [19] 2514 	ld	a,-5 (ix)
   19A9 DD 96 F7      [19] 2515 	sub	a, -9 (ix)
   19AC 20 14         [12] 2516 	jr	NZ,00108$
   19AE DD 7E FC      [19] 2517 	ld	a,-4 (ix)
   19B1 DD 96 F8      [19] 2518 	sub	a, -8 (ix)
   19B4 20 0C         [12] 2519 	jr	NZ,00108$
                           2520 ;src/Renderer.c:803: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
   19B6 3A A7 0A      [13] 2521 	ld	a, (#(_g_colors + 0x0004) + 0)
   19B9 02            [ 7] 2522 	ld	(bc),a
                           2523 ;src/Renderer.c:804: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
   19BA 3A A7 0A      [13] 2524 	ld	a, (#(_g_colors + 0x0004) + 0)
   19BD FD 77 00      [19] 2525 	ld	0 (iy), a
   19C0 18 50         [12] 2526 	jr	00113$
   19C2                    2527 00108$:
                           2528 ;src/Renderer.c:807: val = (*(u8*)(MAP_MEM+x+y*MAP_WIDTH));
   19C2 DD 7E FD      [19] 2529 	ld	a,-3 (ix)
   19C5 C6 00         [ 7] 2530 	add	a, #0x00
   19C7 DD 77 F7      [19] 2531 	ld	-9 (ix),a
   19CA DD 7E FE      [19] 2532 	ld	a,-2 (ix)
   19CD CE 60         [ 7] 2533 	adc	a, #0x60
   19CF DD 77 F8      [19] 2534 	ld	-8 (ix),a
   19D2 DD 6E FB      [19] 2535 	ld	l,-5 (ix)
   19D5 DD 66 FC      [19] 2536 	ld	h,-4 (ix)
   19D8 29            [11] 2537 	add	hl, hl
   19D9 29            [11] 2538 	add	hl, hl
   19DA 29            [11] 2539 	add	hl, hl
   19DB 29            [11] 2540 	add	hl, hl
   19DC 29            [11] 2541 	add	hl, hl
   19DD DD 7E F7      [19] 2542 	ld	a,-9 (ix)
   19E0 85            [ 4] 2543 	add	a, l
   19E1 6F            [ 4] 2544 	ld	l,a
   19E2 DD 7E F8      [19] 2545 	ld	a,-8 (ix)
   19E5 8C            [ 4] 2546 	adc	a, h
   19E6 67            [ 4] 2547 	ld	h,a
   19E7 66            [ 7] 2548 	ld	h,(hl)
                           2549 ;src/Renderer.c:809: if(val==CELLTYPE_DOOR){
   19E8 7C            [ 4] 2550 	ld	a,h
   19E9 D6 80         [ 7] 2551 	sub	a, #0x80
   19EB 20 0C         [12] 2552 	jr	NZ,00105$
                           2553 ;src/Renderer.c:810: *ptr=g_colors[MINIMAP_EXIT_COLOR];
   19ED 3A A8 0A      [13] 2554 	ld	a, (#(_g_colors + 0x0005) + 0)
   19F0 02            [ 7] 2555 	ld	(bc),a
                           2556 ;src/Renderer.c:811: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
   19F1 3A A8 0A      [13] 2557 	ld	a, (#(_g_colors + 0x0005) + 0)
   19F4 FD 77 00      [19] 2558 	ld	0 (iy), a
   19F7 18 19         [12] 2559 	jr	00113$
   19F9                    2560 00105$:
                           2561 ;src/Renderer.c:813: else if(val&CELL_WALL_MASK){
   19F9 29            [11] 2562 	add	hl, hl
   19FA 30 0C         [12] 2563 	jr	NC,00102$
                           2564 ;src/Renderer.c:814: *ptr=g_colors[MINIMAP_WALL_COLOR];
   19FC 3A A4 0A      [13] 2565 	ld	a, (#(_g_colors + 0x0001) + 0)
   19FF 02            [ 7] 2566 	ld	(bc),a
                           2567 ;src/Renderer.c:815: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   1A00 3A A4 0A      [13] 2568 	ld	a, (#(_g_colors + 0x0001) + 0)
   1A03 FD 77 00      [19] 2569 	ld	0 (iy), a
   1A06 18 0A         [12] 2570 	jr	00113$
   1A08                    2571 00102$:
                           2572 ;src/Renderer.c:818: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
   1A08 3A A6 0A      [13] 2573 	ld	a, (#(_g_colors + 0x0003) + 0)
   1A0B 02            [ 7] 2574 	ld	(bc),a
                           2575 ;src/Renderer.c:819: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
   1A0C 3A A6 0A      [13] 2576 	ld	a, (#(_g_colors + 0x0003) + 0)
   1A0F FD 77 00      [19] 2577 	ld	0 (iy), a
   1A12                    2578 00113$:
                           2579 ;src/Renderer.c:822: ++x;
   1A12 DD 34 F9      [23] 2580 	inc	-7 (ix)
                           2581 ;src/Renderer.c:823: ++ptr;
   1A15 03            [ 6] 2582 	inc	bc
                           2583 ;src/Renderer.c:797: for(i=0;i<MINIMAP_WIDTH;++i){
   1A16 DD 34 F5      [23] 2584 	inc	-11 (ix)
   1A19 DD 7E F5      [19] 2585 	ld	a,-11 (ix)
   1A1C D6 10         [ 7] 2586 	sub	a, #0x10
   1A1E DA 3D 19      [10] 2587 	jp	C,00120$
                           2588 ;src/Renderer.c:795: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   1A21 DD 34 F6      [23] 2589 	inc	-10 (ix)
   1A24 DD 7E F6      [19] 2590 	ld	a,-10 (ix)
   1A27 D6 04         [ 7] 2591 	sub	a, #0x04
   1A29 DA 31 19      [10] 2592 	jp	C,00122$
                           2593 ;src/Renderer.c:826: ++y;
   1A2C 1C            [ 4] 2594 	inc	e
                           2595 ;src/Renderer.c:794: for(j=0;j<MINIMAP_HEIGHT;++j){
   1A2D 14            [ 4] 2596 	inc	d
   1A2E 7A            [ 4] 2597 	ld	a,d
   1A2F D6 10         [ 7] 2598 	sub	a, #0x10
   1A31 DA 1B 19      [10] 2599 	jp	C,00137$
   1A34 DD F9         [10] 2600 	ld	sp, ix
   1A36 DD E1         [14] 2601 	pop	ix
   1A38 C9            [10] 2602 	ret
                           2603 	.area _CODE
                           2604 	.area _INITIALIZER
                           2605 	.area _CABS (ABS)
