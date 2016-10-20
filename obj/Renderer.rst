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
                             56 ;src/Renderer.c:50: void calculate_cells_in_view(){
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
                             67 ;src/Renderer.c:52: u8 offset=0, n=0, j, i;
   08F4 DD 36 FA 00   [19]   68 	ld	-6 (ix),#0x00
   08F8 DD 36 F9 00   [19]   69 	ld	-7 (ix),#0x00
                             70 ;src/Renderer.c:55: if(player_direction.y!=0){
   08FC 21 8C 08      [10]   71 	ld	hl, #_player_direction + 1
   08FF 7E            [ 7]   72 	ld	a,(hl)
   0900 DD 77 FB      [19]   73 	ld	-5 (ix), a
   0903 B7            [ 4]   74 	or	a, a
   0904 28 32         [12]   75 	jr	Z,00102$
                             76 ;src/Renderer.c:56: vert=1;
   0906 DD 36 F2 01   [19]   77 	ld	-14 (ix),#0x01
                             78 ;src/Renderer.c:57: dy=player_direction.y;
   090A DD 4E FB      [19]   79 	ld	c,-5 (ix)
   090D DD 71 F4      [19]   80 	ld	-12 (ix),c
                             81 ;src/Renderer.c:58: dx=-player_direction.y;
   0910 AF            [ 4]   82 	xor	a, a
   0911 DD 96 FB      [19]   83 	sub	a, -5 (ix)
   0914 DD 77 F5      [19]   84 	ld	-11 (ix), a
                             85 ;src/Renderer.c:60: x0 = player_position.x-(17*dx);
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
                             98 ;src/Renderer.c:61: y0 = player_position.y+(6*dy);
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
                            110 ;src/Renderer.c:64: vert=0;
   0938 DD 36 F2 00   [19]  111 	ld	-14 (ix),#0x00
                            112 ;src/Renderer.c:65: dy=player_direction.x;
   093C 21 8B 08      [10]  113 	ld	hl, #_player_direction + 0
   093F 7E            [ 7]  114 	ld	a,(hl)
   0940 DD 77 FB      [19]  115 	ld	-5 (ix), a
   0943 DD 77 F4      [19]  116 	ld	-12 (ix),a
                            117 ;src/Renderer.c:66: dx=player_direction.x;
   0946 DD 7E FB      [19]  118 	ld	a,-5 (ix)
   0949 DD 77 F5      [19]  119 	ld	-11 (ix),a
                            120 ;src/Renderer.c:68: y0 = player_position.y-(17*dy);
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
                            133 ;src/Renderer.c:69: x0 = player_position.x+(6*dx);
   095C 21 89 08      [10]  134 	ld	hl, #_player_position + 0
   095F 46            [ 7]  135 	ld	b,(hl)
   0960 DD 7E FB      [19]  136 	ld	a,-5 (ix)
   0963 5F            [ 4]  137 	ld	e,a
   0964 87            [ 4]  138 	add	a, a
   0965 83            [ 4]  139 	add	a, e
   0966 87            [ 4]  140 	add	a, a
   0967 5F            [ 4]  141 	ld	e,a
   0968 68            [ 4]  142 	ld	l,b
   0969 19            [11]  143 	add	hl, de
   096A DD 75 F6      [19]  144 	ld	-10 (ix),l
   096D                     145 00103$:
                            146 ;src/Renderer.c:73: x=x0;
   096D DD 5E F6      [19]  147 	ld	e,-10 (ix)
                            148 ;src/Renderer.c:74: y=y0;
   0970 DD 71 F3      [19]  149 	ld	-13 (ix),c
                            150 ;src/Renderer.c:76: for(j=0;j<6;++j){
   0973 DD 7E F5      [19]  151 	ld	a,-11 (ix)
   0976 07            [ 4]  152 	rlca
   0977 E6 01         [ 7]  153 	and	a,#0x01
   0979 DD 77 FB      [19]  154 	ld	-5 (ix),a
   097C DD 7E F4      [19]  155 	ld	a,-12 (ix)
   097F 07            [ 4]  156 	rlca
   0980 E6 01         [ 7]  157 	and	a,#0x01
   0982 DD 77 FD      [19]  158 	ld	-3 (ix),a
   0985 DD 36 F8 00   [19]  159 	ld	-8 (ix),#0x00
                            160 ;src/Renderer.c:78: for(i=offset;i<35-offset;++i){
   0989                     161 00138$:
   0989 DD 7E F9      [19]  162 	ld	a,-7 (ix)
   098C DD 77 FC      [19]  163 	ld	-4 (ix),a
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
                            184 ;src/Renderer.c:81: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   09B2 2A B6 0A      [16]  185 	ld	hl,(_cells_in_view_array)
   09B5 7D            [ 4]  186 	ld	a,l
   09B6 DD 86 FC      [19]  187 	add	a, -4 (ix)
   09B9 DD 77 FE      [19]  188 	ld	-2 (ix),a
   09BC 7C            [ 4]  189 	ld	a,h
   09BD CE 00         [ 7]  190 	adc	a, #0x00
   09BF DD 77 FF      [19]  191 	ld	-1 (ix),a
                            192 ;src/Renderer.c:80: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
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
                            205 ;src/Renderer.c:81: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   09DC 7B            [ 4]  206 	ld	a,e
   09DD 57            [ 4]  207 	ld	d,a
   09DE 17            [ 4]  208 	rla
   09DF 9F            [ 4]  209 	sbc	a, a
   09E0 42            [ 4]  210 	ld	b, d
   09E1 C6 70         [ 7]  211 	add	a,#0x70
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
   09F9 DD 6E FE      [19]  230 	ld	l,-2 (ix)
   09FC DD 66 FF      [19]  231 	ld	h,-1 (ix)
   09FF 70            [ 7]  232 	ld	(hl),b
   0A00 18 08         [12]  233 	jr	00106$
   0A02                     234 00105$:
                            235 ;src/Renderer.c:84: cells_in_view_array[n]=CELLTYPE_WALL1;
   0A02 DD 6E FE      [19]  236 	ld	l,-2 (ix)
   0A05 DD 66 FF      [19]  237 	ld	h,-1 (ix)
   0A08 36 81         [10]  238 	ld	(hl),#0x81
   0A0A                     239 00106$:
                            240 ;src/Renderer.c:88: if(vert){
   0A0A DD 7E F2      [19]  241 	ld	a,-14 (ix)
   0A0D B7            [ 4]  242 	or	a, a
   0A0E 28 07         [12]  243 	jr	Z,00111$
                            244 ;src/Renderer.c:89: x+=dx;
   0A10 7B            [ 4]  245 	ld	a,e
   0A11 DD 86 F5      [19]  246 	add	a, -11 (ix)
   0A14 5F            [ 4]  247 	ld	e,a
   0A15 18 09         [12]  248 	jr	00112$
   0A17                     249 00111$:
                            250 ;src/Renderer.c:92: y+=dy;
   0A17 DD 7E F3      [19]  251 	ld	a,-13 (ix)
   0A1A DD 86 F4      [19]  252 	add	a, -12 (ix)
   0A1D DD 77 F3      [19]  253 	ld	-13 (ix),a
   0A20                     254 00112$:
                            255 ;src/Renderer.c:94: ++n;
   0A20 DD 34 FC      [23]  256 	inc	-4 (ix)
                            257 ;src/Renderer.c:78: for(i=offset;i<35-offset;++i){
   0A23 DD 34 F7      [23]  258 	inc	-9 (ix)
   0A26 C3 95 09      [10]  259 	jp	00125$
   0A29                     260 00143$:
   0A29 DD 7E FC      [19]  261 	ld	a,-4 (ix)
   0A2C DD 77 F9      [19]  262 	ld	-7 (ix),a
                            263 ;src/Renderer.c:96: offset=offsets_cells_in_view[j];
   0A2F 3E B8         [ 7]  264 	ld	a,#<(_offsets_cells_in_view)
   0A31 DD 86 F8      [19]  265 	add	a, -8 (ix)
   0A34 6F            [ 4]  266 	ld	l,a
   0A35 3E 0A         [ 7]  267 	ld	a,#>(_offsets_cells_in_view)
   0A37 CE 00         [ 7]  268 	adc	a, #0x00
   0A39 67            [ 4]  269 	ld	h,a
   0A3A 7E            [ 7]  270 	ld	a,(hl)
                            271 ;src/Renderer.c:100: if(dx<0) x=x0-offset;
   0A3B DD 77 FA      [19]  272 	ld	-6 (ix), a
   0A3E DD 77 FE      [19]  273 	ld	-2 (ix),a
                            274 ;src/Renderer.c:98: if(vert){
   0A41 DD 7E F2      [19]  275 	ld	a,-14 (ix)
   0A44 B7            [ 4]  276 	or	a, a
   0A45 28 21         [12]  277 	jr	Z,00121$
                            278 ;src/Renderer.c:99: y-=dy;
   0A47 DD 7E F3      [19]  279 	ld	a,-13 (ix)
   0A4A DD 96 F4      [19]  280 	sub	a, -12 (ix)
   0A4D DD 77 F3      [19]  281 	ld	-13 (ix),a
                            282 ;src/Renderer.c:100: if(dx<0) x=x0-offset;
   0A50 DD 7E FB      [19]  283 	ld	a,-5 (ix)
   0A53 B7            [ 4]  284 	or	a, a
   0A54 28 09         [12]  285 	jr	Z,00115$
   0A56 DD 7E F6      [19]  286 	ld	a,-10 (ix)
   0A59 DD 96 FE      [19]  287 	sub	a, -2 (ix)
   0A5C 5F            [ 4]  288 	ld	e,a
   0A5D 18 24         [12]  289 	jr	00128$
   0A5F                     290 00115$:
                            291 ;src/Renderer.c:101: else x=x0+offset;
   0A5F DD 7E F6      [19]  292 	ld	a,-10 (ix)
   0A62 DD 86 FE      [19]  293 	add	a, -2 (ix)
   0A65 5F            [ 4]  294 	ld	e,a
   0A66 18 1B         [12]  295 	jr	00128$
   0A68                     296 00121$:
                            297 ;src/Renderer.c:105: x-=dx;
   0A68 7B            [ 4]  298 	ld	a,e
   0A69 DD 96 F5      [19]  299 	sub	a, -11 (ix)
   0A6C 5F            [ 4]  300 	ld	e,a
                            301 ;src/Renderer.c:106: if(dy<0) y=y0-offset;
   0A6D DD 7E FD      [19]  302 	ld	a,-3 (ix)
   0A70 B7            [ 4]  303 	or	a, a
   0A71 28 09         [12]  304 	jr	Z,00118$
   0A73 79            [ 4]  305 	ld	a,c
   0A74 DD 96 FE      [19]  306 	sub	a, -2 (ix)
   0A77 DD 77 F3      [19]  307 	ld	-13 (ix),a
   0A7A 18 07         [12]  308 	jr	00128$
   0A7C                     309 00118$:
                            310 ;src/Renderer.c:107: else y=y0+offset;
   0A7C 79            [ 4]  311 	ld	a,c
   0A7D DD 86 FE      [19]  312 	add	a, -2 (ix)
   0A80 DD 77 F3      [19]  313 	ld	-13 (ix),a
   0A83                     314 00128$:
                            315 ;src/Renderer.c:76: for(j=0;j<6;++j){
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
   0A98 09                  329 	.db #0x09	; 9
   0A99 0F                  330 	.db #0x0F	; 15
   0A9A 00                  331 	.db #0x00	; 0
   0A9B 00                  332 	.db #0x00	; 0
   0A9C 00                  333 	.db #0x00	; 0
   0A9D 00                  334 	.db #0x00	; 0
   0A9E 00                  335 	.db #0x00	; 0
   0A9F 00                  336 	.db #0x00	; 0
   0AA0 00                  337 	.db #0x00	; 0
   0AA1 00                  338 	.db #0x00	; 0
   0AA2 00                  339 	.db #0x00	; 0
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
   0AB6 A0 AE               363 	.dw #0xAEA0
   0AB8                     364 _offsets_cells_in_view:
   0AB8 08                  365 	.db #0x08	; 8
   0AB9 0C                  366 	.db #0x0C	; 12
   0ABA 0E                  367 	.db #0x0E	; 14
   0ABB 0F                  368 	.db #0x0F	; 15
   0ABC 10                  369 	.db #0x10	; 16
                            370 ;src/Renderer.c:115: void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
                            371 ;	---------------------------------
                            372 ; Function draw_column_to_buffer_untextured
                            373 ; ---------------------------------
   0ABD                     374 _draw_column_to_buffer_untextured::
   0ABD DD E5         [15]  375 	push	ix
   0ABF DD 21 00 00   [14]  376 	ld	ix,#0
   0AC3 DD 39         [15]  377 	add	ix,sp
   0AC5 F5            [11]  378 	push	af
                            379 ;src/Renderer.c:116: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   0AC6 DD 7E 04      [19]  380 	ld	a, 4 (ix)
   0AC9 CB 3F         [ 8]  381 	srl	a
   0ACB 4F            [ 4]  382 	ld	c,a
   0ACC 3E 00         [ 7]  383 	ld	a,#0x00
   0ACE C6 9B         [ 7]  384 	add	a,#0x9B
   0AD0 47            [ 4]  385 	ld	b,a
                            386 ;src/Renderer.c:118: u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
   0AD1 11 A3 0A      [10]  387 	ld	de,#_g_colors+0
   0AD4 DD 6E 06      [19]  388 	ld	l,6 (ix)
   0AD7 26 00         [ 7]  389 	ld	h,#0x00
   0AD9 19            [11]  390 	add	hl,de
   0ADA 7E            [ 7]  391 	ld	a,(hl)
   0ADB DD 77 FE      [19]  392 	ld	-2 (ix),a
                            393 ;src/Renderer.c:119: u8 pixMask = g_pixelMask[column&1];
   0ADE 11 B3 0A      [10]  394 	ld	de,#_g_pixelMask+0
   0AE1 DD 7E 04      [19]  395 	ld	a,4 (ix)
   0AE4 E6 01         [ 7]  396 	and	a, #0x01
   0AE6 6F            [ 4]  397 	ld	l,a
   0AE7 26 00         [ 7]  398 	ld	h,#0x00
   0AE9 19            [11]  399 	add	hl,de
   0AEA 5E            [ 7]  400 	ld	e,(hl)
                            401 ;src/Renderer.c:128: if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
   0AEB 3E 64         [ 7]  402 	ld	a,#0x64
   0AED DD 96 05      [19]  403 	sub	a, 5 (ix)
   0AF0 30 04         [12]  404 	jr	NC,00102$
   0AF2 DD 36 05 64   [19]  405 	ld	5 (ix),#0x64
   0AF6                     406 00102$:
                            407 ;src/Renderer.c:130: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   0AF6 DD 6E 05      [19]  408 	ld	l,5 (ix)
   0AF9 CB 3D         [ 8]  409 	srl	l
   0AFB 3E 32         [ 7]  410 	ld	a,#0x32
   0AFD 95            [ 4]  411 	sub	a, l
                            412 ;src/Renderer.c:133: pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
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
                            428 ;src/Renderer.c:135: j=lineHeight;
   0B0E DD 56 05      [19]  429 	ld	d,5 (ix)
                            430 ;src/Renderer.c:137: for(j;j;--j){
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
                            441 ;src/Renderer.c:138: val =  ((*pvmem)&(~pixMask));
   0B1F 0A            [ 7]  442 	ld	a,(bc)
   0B20 DD A6 FF      [19]  443 	and	a, -1 (ix)
                            444 ;src/Renderer.c:140: *pvmem = val|(w_color&pixMask);
   0B23 B3            [ 4]  445 	or	a, e
   0B24 02            [ 7]  446 	ld	(bc),a
                            447 ;src/Renderer.c:142: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   0B25 21 28 00      [10]  448 	ld	hl,#0x0028
   0B28 09            [11]  449 	add	hl,bc
   0B29 4D            [ 4]  450 	ld	c,l
   0B2A 44            [ 4]  451 	ld	b,h
                            452 ;src/Renderer.c:137: for(j;j;--j){
   0B2B 15            [ 4]  453 	dec	d
   0B2C 18 ED         [12]  454 	jr	00105$
   0B2E                     455 00107$:
   0B2E DD F9         [10]  456 	ld	sp, ix
   0B30 DD E1         [14]  457 	pop	ix
   0B32 C9            [10]  458 	ret
                            459 ;src/Renderer.c:146: void draw_column_to_buffer_object(u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            460 ;	---------------------------------
                            461 ; Function draw_column_to_buffer_object
                            462 ; ---------------------------------
   0B33                     463 _draw_column_to_buffer_object::
                            464 ;src/Renderer.c:148: }
   0B33 C9            [10]  465 	ret
                            466 ;src/Renderer.c:151: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
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
                            477 ;src/Renderer.c:168: u16 texture_line=0;
   0B41 DD 36 F8 00   [19]  478 	ld	-8 (ix),#0x00
   0B45 DD 36 F9 00   [19]  479 	ld	-7 (ix),#0x00
                            480 ;src/Renderer.c:170: if(texture_column>=4 && texture_column<28){
   0B49 DD 7E 07      [19]  481 	ld	a,7 (ix)
   0B4C D6 04         [ 7]  482 	sub	a, #0x04
   0B4E DA 70 0C      [10]  483 	jp	C,00112$
   0B51 DD 7E 07      [19]  484 	ld	a,7 (ix)
   0B54 D6 1C         [ 7]  485 	sub	a, #0x1C
   0B56 D2 70 0C      [10]  486 	jp	NC,00112$
                            487 ;src/Renderer.c:173: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(index-1)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
   0B59 DD 4E 06      [19]  488 	ld	c,6 (ix)
   0B5C 06 00         [ 7]  489 	ld	b,#0x00
   0B5E 0B            [ 6]  490 	dec	bc
   0B5F 69            [ 4]  491 	ld	l, c
   0B60 60            [ 4]  492 	ld	h, b
   0B61 29            [11]  493 	add	hl, hl
   0B62 29            [11]  494 	add	hl, hl
   0B63 29            [11]  495 	add	hl, hl
   0B64 09            [11]  496 	add	hl, bc
   0B65 29            [11]  497 	add	hl, hl
   0B66 29            [11]  498 	add	hl, hl
   0B67 29            [11]  499 	add	hl, hl
   0B68 29            [11]  500 	add	hl, hl
   0B69 29            [11]  501 	add	hl, hl
   0B6A 29            [11]  502 	add	hl, hl
   0B6B 01 00 88      [10]  503 	ld	bc,#0x8800
   0B6E 09            [11]  504 	add	hl,bc
   0B6F 4D            [ 4]  505 	ld	c,l
   0B70 44            [ 4]  506 	ld	b,h
   0B71 DD 7E 07      [19]  507 	ld	a, 7 (ix)
   0B74 16 00         [ 7]  508 	ld	d, #0x00
   0B76 C6 FC         [ 7]  509 	add	a,#0xFC
   0B78 5F            [ 4]  510 	ld	e,a
   0B79 7A            [ 4]  511 	ld	a,d
   0B7A CE FF         [ 7]  512 	adc	a,#0xFF
   0B7C 57            [ 4]  513 	ld	d,a
   0B7D 6B            [ 4]  514 	ld	l, e
   0B7E 62            [ 4]  515 	ld	h, d
   0B7F 29            [11]  516 	add	hl, hl
   0B80 19            [11]  517 	add	hl, de
   0B81 29            [11]  518 	add	hl, hl
   0B82 29            [11]  519 	add	hl, hl
   0B83 29            [11]  520 	add	hl, hl
   0B84 09            [11]  521 	add	hl,bc
   0B85 DD 75 F6      [19]  522 	ld	-10 (ix),l
   0B88 DD 74 F7      [19]  523 	ld	-9 (ix),h
                            524 ;src/Renderer.c:175: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   0B8B DD 7E 04      [19]  525 	ld	a,4 (ix)
   0B8E CB 3F         [ 8]  526 	srl	a
   0B90 C6 00         [ 7]  527 	add	a, #0x00
   0B92 DD 77 FA      [19]  528 	ld	-6 (ix),a
   0B95 3E 00         [ 7]  529 	ld	a,#0x00
   0B97 CE 9B         [ 7]  530 	adc	a, #0x9B
   0B99 DD 77 FB      [19]  531 	ld	-5 (ix),a
                            532 ;src/Renderer.c:177: pixMask = g_pixelMask[column&1];
   0B9C 01 B3 0A      [10]  533 	ld	bc,#_g_pixelMask+0
   0B9F DD 7E 04      [19]  534 	ld	a,4 (ix)
   0BA2 E6 01         [ 7]  535 	and	a, #0x01
   0BA4 6F            [ 4]  536 	ld	l, a
   0BA5 26 00         [ 7]  537 	ld	h,#0x00
   0BA7 09            [11]  538 	add	hl,bc
   0BA8 7E            [ 7]  539 	ld	a,(hl)
   0BA9 DD 77 F2      [19]  540 	ld	-14 (ix),a
                            541 ;src/Renderer.c:179: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
   0BAC DD 7E 05      [19]  542 	ld	a,5 (ix)
   0BAF CB 3F         [ 8]  543 	srl	a
   0BB1 C6 32         [ 7]  544 	add	a, #0x32
   0BB3 DD 77 F5      [19]  545 	ld	-11 (ix),a
                            546 ;src/Renderer.c:180: lineHeight = (lineHeight*3)/4;
   0BB6 DD 4E 05      [19]  547 	ld	c,5 (ix)
   0BB9 06 00         [ 7]  548 	ld	b,#0x00
   0BBB 69            [ 4]  549 	ld	l, c
   0BBC 60            [ 4]  550 	ld	h, b
   0BBD 29            [11]  551 	add	hl, hl
   0BBE 09            [11]  552 	add	hl, bc
   0BBF DD 75 FE      [19]  553 	ld	-2 (ix),l
   0BC2 DD 74 FF      [19]  554 	ld	-1 (ix),h
   0BC5 DD 7E FE      [19]  555 	ld	a,-2 (ix)
   0BC8 DD 77 FC      [19]  556 	ld	-4 (ix),a
   0BCB DD 7E FF      [19]  557 	ld	a,-1 (ix)
   0BCE DD 77 FD      [19]  558 	ld	-3 (ix),a
   0BD1 DD CB FF 7E   [20]  559 	bit	7, -1 (ix)
   0BD5 28 10         [12]  560 	jr	Z,00114$
   0BD7 DD 7E FE      [19]  561 	ld	a,-2 (ix)
   0BDA C6 03         [ 7]  562 	add	a, #0x03
   0BDC DD 77 FC      [19]  563 	ld	-4 (ix),a
   0BDF DD 7E FF      [19]  564 	ld	a,-1 (ix)
   0BE2 CE 00         [ 7]  565 	adc	a, #0x00
   0BE4 DD 77 FD      [19]  566 	ld	-3 (ix),a
   0BE7                     567 00114$:
   0BE7 DD 46 FC      [19]  568 	ld	b,-4 (ix)
   0BEA DD 4E FD      [19]  569 	ld	c,-3 (ix)
   0BED CB 29         [ 8]  570 	sra	c
   0BEF CB 18         [ 8]  571 	rr	b
   0BF1 CB 29         [ 8]  572 	sra	c
   0BF3 CB 18         [ 8]  573 	rr	b
                            574 ;src/Renderer.c:181: enemy_top_height = ground_height - lineHeight;
   0BF5 DD 7E F5      [19]  575 	ld	a,-11 (ix)
   0BF8 90            [ 4]  576 	sub	a, b
   0BF9 4F            [ 4]  577 	ld	c,a
                            578 ;src/Renderer.c:183: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
   0BFA 58            [ 4]  579 	ld	e,b
   0BFB 16 00         [ 7]  580 	ld	d,#0x00
   0BFD C5            [11]  581 	push	bc
   0BFE D5            [11]  582 	push	de
   0BFF 21 00 18      [10]  583 	ld	hl,#0x1800
   0C02 E5            [11]  584 	push	hl
   0C03 CD 79 4E      [17]  585 	call	__divsint
   0C06 F1            [10]  586 	pop	af
   0C07 F1            [10]  587 	pop	af
   0C08 C1            [10]  588 	pop	bc
   0C09 DD 75 F3      [19]  589 	ld	-13 (ix),l
   0C0C DD 74 F4      [19]  590 	ld	-12 (ix),h
                            591 ;src/Renderer.c:184: j=lineHeight;
   0C0F 50            [ 4]  592 	ld	d,b
                            593 ;src/Renderer.c:186: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   0C10 3E 64         [ 7]  594 	ld	a,#0x64
   0C12 90            [ 4]  595 	sub	a, b
   0C13 30 02         [12]  596 	jr	NC,00102$
                            597 ;src/Renderer.c:187: j=90;
   0C15 16 5A         [ 7]  598 	ld	d,#0x5A
   0C17                     599 00102$:
                            600 ;src/Renderer.c:190: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
   0C17 06 00         [ 7]  601 	ld	b,#0x00
   0C19 69            [ 4]  602 	ld	l, c
   0C1A 60            [ 4]  603 	ld	h, b
   0C1B 29            [11]  604 	add	hl, hl
   0C1C 29            [11]  605 	add	hl, hl
   0C1D 09            [11]  606 	add	hl, bc
   0C1E 29            [11]  607 	add	hl, hl
   0C1F 29            [11]  608 	add	hl, hl
   0C20 29            [11]  609 	add	hl, hl
   0C21 DD 7E FA      [19]  610 	ld	a,-6 (ix)
   0C24 85            [ 4]  611 	add	a, l
   0C25 4F            [ 4]  612 	ld	c,a
   0C26 DD 7E FB      [19]  613 	ld	a,-5 (ix)
   0C29 8C            [ 4]  614 	adc	a, h
   0C2A 47            [ 4]  615 	ld	b,a
                            616 ;src/Renderer.c:192: for(j;j;--j){
   0C2B DD 7E F2      [19]  617 	ld	a,-14 (ix)
   0C2E 2F            [ 4]  618 	cpl
   0C2F 5F            [ 4]  619 	ld	e,a
   0C30                     620 00110$:
   0C30 7A            [ 4]  621 	ld	a,d
   0C31 B7            [ 4]  622 	or	a, a
   0C32 28 3C         [12]  623 	jr	Z,00112$
                            624 ;src/Renderer.c:194: color= *(texture+(texture_line/256));
   0C34 DD 6E F9      [19]  625 	ld	l,-7 (ix)
   0C37 26 00         [ 7]  626 	ld	h,#0x00
   0C39 DD 7E F6      [19]  627 	ld	a,-10 (ix)
   0C3C 85            [ 4]  628 	add	a, l
   0C3D 6F            [ 4]  629 	ld	l,a
   0C3E DD 7E F7      [19]  630 	ld	a,-9 (ix)
   0C41 8C            [ 4]  631 	adc	a, h
   0C42 67            [ 4]  632 	ld	h,a
   0C43 7E            [ 7]  633 	ld	a,(hl)
                            634 ;src/Renderer.c:196: if(color){
   0C44 DD 77 FC      [19]  635 	ld	-4 (ix), a
   0C47 B7            [ 4]  636 	or	a, a
   0C48 28 0B         [12]  637 	jr	Z,00104$
                            638 ;src/Renderer.c:197: val =  ((*pvmem)&(~pixMask));
   0C4A 0A            [ 7]  639 	ld	a,(bc)
   0C4B A3            [ 4]  640 	and	a, e
   0C4C 6F            [ 4]  641 	ld	l,a
                            642 ;src/Renderer.c:199: color = (color&pixMask);
   0C4D DD 7E FC      [19]  643 	ld	a,-4 (ix)
   0C50 DD A6 F2      [19]  644 	and	a, -14 (ix)
                            645 ;src/Renderer.c:201: *pvmem = val|color;
   0C53 B5            [ 4]  646 	or	a, l
   0C54 02            [ 7]  647 	ld	(bc),a
   0C55                     648 00104$:
                            649 ;src/Renderer.c:204: texture_line += texture_line_add;
   0C55 DD 7E F8      [19]  650 	ld	a,-8 (ix)
   0C58 DD 86 F3      [19]  651 	add	a, -13 (ix)
   0C5B DD 77 F8      [19]  652 	ld	-8 (ix),a
   0C5E DD 7E F9      [19]  653 	ld	a,-7 (ix)
   0C61 DD 8E F4      [19]  654 	adc	a, -12 (ix)
   0C64 DD 77 F9      [19]  655 	ld	-7 (ix),a
                            656 ;src/Renderer.c:206: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   0C67 21 28 00      [10]  657 	ld	hl,#0x0028
   0C6A 09            [11]  658 	add	hl,bc
   0C6B 4D            [ 4]  659 	ld	c,l
   0C6C 44            [ 4]  660 	ld	b,h
                            661 ;src/Renderer.c:192: for(j;j;--j){
   0C6D 15            [ 4]  662 	dec	d
   0C6E 18 C0         [12]  663 	jr	00110$
   0C70                     664 00112$:
   0C70 DD F9         [10]  665 	ld	sp, ix
   0C72 DD E1         [14]  666 	pop	ix
   0C74 C9            [10]  667 	ret
                            668 ;src/Renderer.c:298: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
                            669 ;	---------------------------------
                            670 ; Function draw_column_to_buffer
                            671 ; ---------------------------------
   0C75                     672 _draw_column_to_buffer::
   0C75 DD E5         [15]  673 	push	ix
   0C77 DD 21 00 00   [14]  674 	ld	ix,#0
   0C7B DD 39         [15]  675 	add	ix,sp
   0C7D 21 F1 FF      [10]  676 	ld	hl,#-15
   0C80 39            [11]  677 	add	hl,sp
   0C81 F9            [ 6]  678 	ld	sp,hl
                            679 ;src/Renderer.c:299: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   0C82 DD 7E 04      [19]  680 	ld	a,4 (ix)
   0C85 CB 3F         [ 8]  681 	srl	a
   0C87 C6 00         [ 7]  682 	add	a, #0x00
   0C89 DD 77 FA      [19]  683 	ld	-6 (ix),a
   0C8C 3E 00         [ 7]  684 	ld	a,#0x00
   0C8E CE 9B         [ 7]  685 	adc	a, #0x9B
   0C90 DD 77 FB      [19]  686 	ld	-5 (ix),a
                            687 ;src/Renderer.c:302: u8 pixMask = g_pixelMask[column&1];
   0C93 01 B3 0A      [10]  688 	ld	bc,#_g_pixelMask+0
   0C96 DD 7E 04      [19]  689 	ld	a,4 (ix)
   0C99 E6 01         [ 7]  690 	and	a, #0x01
   0C9B 6F            [ 4]  691 	ld	l, a
   0C9C 26 00         [ 7]  692 	ld	h,#0x00
   0C9E 09            [11]  693 	add	hl,bc
   0C9F 7E            [ 7]  694 	ld	a,(hl)
   0CA0 DD 77 F3      [19]  695 	ld	-13 (ix),a
                            696 ;src/Renderer.c:307: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
   0CA3 DD 7E 06      [19]  697 	ld	a, 6 (ix)
   0CA6 87            [ 4]  698 	add	a, a
   0CA7 87            [ 4]  699 	add	a, a
   0CA8 47            [ 4]  700 	ld	b,a
   0CA9 0E 00         [ 7]  701 	ld	c,#0x00
   0CAB 21 00 74      [10]  702 	ld	hl,#0x7400
   0CAE 09            [11]  703 	add	hl,bc
   0CAF 4D            [ 4]  704 	ld	c,l
   0CB0 44            [ 4]  705 	ld	b,h
   0CB1 DD 6E 07      [19]  706 	ld	l,7 (ix)
   0CB4 26 00         [ 7]  707 	ld	h,#0x00
   0CB6 29            [11]  708 	add	hl, hl
   0CB7 29            [11]  709 	add	hl, hl
   0CB8 29            [11]  710 	add	hl, hl
   0CB9 29            [11]  711 	add	hl, hl
   0CBA 29            [11]  712 	add	hl, hl
   0CBB 09            [11]  713 	add	hl,bc
   0CBC DD 75 F4      [19]  714 	ld	-12 (ix),l
   0CBF DD 74 F5      [19]  715 	ld	-11 (ix),h
                            716 ;src/Renderer.c:309: u8 j=lineHeight;
   0CC2 DD 7E 05      [19]  717 	ld	a,5 (ix)
                            718 ;src/Renderer.c:315: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
   0CC5 DD 77 F1      [19]  719 	ld	-15 (ix), a
   0CC8 DD 77 FE      [19]  720 	ld	-2 (ix),a
   0CCB DD 36 FF 00   [19]  721 	ld	-1 (ix),#0x00
   0CCF DD 6E FE      [19]  722 	ld	l,-2 (ix)
   0CD2 DD 66 FF      [19]  723 	ld	h,-1 (ix)
   0CD5 E5            [11]  724 	push	hl
   0CD6 21 00 20      [10]  725 	ld	hl,#0x2000
   0CD9 E5            [11]  726 	push	hl
   0CDA CD 79 4E      [17]  727 	call	__divsint
   0CDD F1            [10]  728 	pop	af
   0CDE F1            [10]  729 	pop	af
   0CDF DD 75 F8      [19]  730 	ld	-8 (ix),l
   0CE2 DD 74 F9      [19]  731 	ld	-7 (ix),h
                            732 ;src/Renderer.c:316: u16 wall_texture_line=0;
   0CE5 DD 36 F6 00   [19]  733 	ld	-10 (ix),#0x00
   0CE9 DD 36 F7 00   [19]  734 	ld	-9 (ix),#0x00
                            735 ;src/Renderer.c:318: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   0CED DD 4E F1      [19]  736 	ld	c,-15 (ix)
   0CF0 CB 39         [ 8]  737 	srl	c
   0CF2 3E 32         [ 7]  738 	ld	a,#0x32
   0CF4 91            [ 4]  739 	sub	a, c
   0CF5 DD 77 F2      [19]  740 	ld	-14 (ix),a
                            741 ;src/Renderer.c:322: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   0CF8 3E 64         [ 7]  742 	ld	a,#0x64
   0CFA DD 96 F1      [19]  743 	sub	a, -15 (ix)
   0CFD 30 4B         [12]  744 	jr	NC,00102$
                            745 ;src/Renderer.c:323: ceiling_height=0;
   0CFF DD 36 F2 00   [19]  746 	ld	-14 (ix),#0x00
                            747 ;src/Renderer.c:324: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
   0D03 DD 7E FE      [19]  748 	ld	a,-2 (ix)
   0D06 C6 9C         [ 7]  749 	add	a,#0x9C
   0D08 4F            [ 4]  750 	ld	c,a
   0D09 DD 7E FF      [19]  751 	ld	a,-1 (ix)
   0D0C CE FF         [ 7]  752 	adc	a,#0xFF
   0D0E 47            [ 4]  753 	ld	b,a
   0D0F DD 71 FC      [19]  754 	ld	-4 (ix),c
   0D12 DD 70 FD      [19]  755 	ld	-3 (ix),b
   0D15 CB 78         [ 8]  756 	bit	7, b
   0D17 28 10         [12]  757 	jr	Z,00111$
   0D19 DD 7E FE      [19]  758 	ld	a,-2 (ix)
   0D1C C6 9D         [ 7]  759 	add	a, #0x9D
   0D1E DD 77 FC      [19]  760 	ld	-4 (ix),a
   0D21 DD 7E FF      [19]  761 	ld	a,-1 (ix)
   0D24 CE FF         [ 7]  762 	adc	a, #0xFF
   0D26 DD 77 FD      [19]  763 	ld	-3 (ix),a
   0D29                     764 00111$:
   0D29 DD 4E FC      [19]  765 	ld	c,-4 (ix)
   0D2C DD 46 FD      [19]  766 	ld	b,-3 (ix)
   0D2F CB 28         [ 8]  767 	sra	b
   0D31 CB 19         [ 8]  768 	rr	c
   0D33 DD 6E F8      [19]  769 	ld	l,-8 (ix)
   0D36 DD 66 F9      [19]  770 	ld	h,-7 (ix)
   0D39 E5            [11]  771 	push	hl
   0D3A C5            [11]  772 	push	bc
   0D3B CD F6 4C      [17]  773 	call	__mulint
   0D3E F1            [10]  774 	pop	af
   0D3F F1            [10]  775 	pop	af
   0D40 DD 75 F6      [19]  776 	ld	-10 (ix),l
   0D43 DD 74 F7      [19]  777 	ld	-9 (ix),h
                            778 ;src/Renderer.c:325: j=SCREEN_TEXTURE_HEIGHT;
   0D46 DD 36 F1 64   [19]  779 	ld	-15 (ix),#0x64
   0D4A                     780 00102$:
                            781 ;src/Renderer.c:328: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
   0D4A DD 4E F2      [19]  782 	ld	c,-14 (ix)
   0D4D 06 00         [ 7]  783 	ld	b,#0x00
   0D4F 69            [ 4]  784 	ld	l, c
   0D50 60            [ 4]  785 	ld	h, b
   0D51 29            [11]  786 	add	hl, hl
   0D52 29            [11]  787 	add	hl, hl
   0D53 09            [11]  788 	add	hl, bc
   0D54 29            [11]  789 	add	hl, hl
   0D55 29            [11]  790 	add	hl, hl
   0D56 29            [11]  791 	add	hl, hl
   0D57 DD 7E FA      [19]  792 	ld	a,-6 (ix)
   0D5A 85            [ 4]  793 	add	a, l
   0D5B 4F            [ 4]  794 	ld	c,a
   0D5C DD 7E FB      [19]  795 	ld	a,-5 (ix)
   0D5F 8C            [ 4]  796 	adc	a, h
   0D60 47            [ 4]  797 	ld	b,a
                            798 ;src/Renderer.c:330: for(j;j;--j){
   0D61 DD 7E F3      [19]  799 	ld	a,-13 (ix)
   0D64 2F            [ 4]  800 	cpl
   0D65 DD 77 FC      [19]  801 	ld	-4 (ix),a
   0D68 DD 56 F1      [19]  802 	ld	d,-15 (ix)
   0D6B                     803 00107$:
   0D6B 7A            [ 4]  804 	ld	a,d
   0D6C B7            [ 4]  805 	or	a, a
   0D6D 28 39         [12]  806 	jr	Z,00109$
                            807 ;src/Renderer.c:332: w_color = *(texture+(wall_texture_line/256));
   0D6F DD 7E F7      [19]  808 	ld	a, -9 (ix)
   0D72 26 00         [ 7]  809 	ld	h, #0x00
   0D74 DD 86 F4      [19]  810 	add	a, -12 (ix)
   0D77 6F            [ 4]  811 	ld	l,a
   0D78 7C            [ 4]  812 	ld	a,h
   0D79 DD 8E F5      [19]  813 	adc	a, -11 (ix)
   0D7C 67            [ 4]  814 	ld	h,a
   0D7D 5E            [ 7]  815 	ld	e,(hl)
                            816 ;src/Renderer.c:334: if(w_color){
   0D7E 7B            [ 4]  817 	ld	a,e
   0D7F B7            [ 4]  818 	or	a, a
   0D80 28 0B         [12]  819 	jr	Z,00104$
                            820 ;src/Renderer.c:336: val =  ((*pvmem)&(~pixMask));
   0D82 0A            [ 7]  821 	ld	a,(bc)
   0D83 DD A6 FC      [19]  822 	and	a, -4 (ix)
   0D86 6F            [ 4]  823 	ld	l,a
                            824 ;src/Renderer.c:338: w_color = (w_color&pixMask);
   0D87 7B            [ 4]  825 	ld	a,e
   0D88 DD A6 F3      [19]  826 	and	a, -13 (ix)
                            827 ;src/Renderer.c:340: *pvmem = val|w_color;
   0D8B B5            [ 4]  828 	or	a, l
   0D8C 02            [ 7]  829 	ld	(bc),a
   0D8D                     830 00104$:
                            831 ;src/Renderer.c:344: wall_texture_line += wall_texture_line_add;
   0D8D DD 7E F6      [19]  832 	ld	a,-10 (ix)
   0D90 DD 86 F8      [19]  833 	add	a, -8 (ix)
   0D93 DD 77 F6      [19]  834 	ld	-10 (ix),a
   0D96 DD 7E F7      [19]  835 	ld	a,-9 (ix)
   0D99 DD 8E F9      [19]  836 	adc	a, -7 (ix)
   0D9C DD 77 F7      [19]  837 	ld	-9 (ix),a
                            838 ;src/Renderer.c:346: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   0D9F 21 28 00      [10]  839 	ld	hl,#0x0028
   0DA2 09            [11]  840 	add	hl,bc
   0DA3 4D            [ 4]  841 	ld	c,l
   0DA4 44            [ 4]  842 	ld	b,h
                            843 ;src/Renderer.c:330: for(j;j;--j){
   0DA5 15            [ 4]  844 	dec	d
   0DA6 18 C3         [12]  845 	jr	00107$
   0DA8                     846 00109$:
   0DA8 DD F9         [10]  847 	ld	sp, ix
   0DAA DD E1         [14]  848 	pop	ix
   0DAC C9            [10]  849 	ret
                            850 ;src/Renderer.c:350: void render_draw_to_buffer(){//TODO Optimize
                            851 ;	---------------------------------
                            852 ; Function render_draw_to_buffer
                            853 ; ---------------------------------
   0DAD                     854 _render_draw_to_buffer::
   0DAD DD E5         [15]  855 	push	ix
   0DAF DD 21 00 00   [14]  856 	ld	ix,#0
   0DB3 DD 39         [15]  857 	add	ix,sp
   0DB5 21 C6 FF      [10]  858 	ld	hl,#-58
   0DB8 39            [11]  859 	add	hl,sp
   0DB9 F9            [ 6]  860 	ld	sp,hl
                            861 ;src/Renderer.c:362: u8 zHeight = 5;
   0DBA DD 36 CC 05   [19]  862 	ld	-52 (ix),#0x05
                            863 ;src/Renderer.c:372: u8 offsetDiff = 16;
   0DBE DD 36 CE 10   [19]  864 	ld	-50 (ix),#0x10
                            865 ;src/Renderer.c:377: u8 lineStart = 0;
   0DC2 DD 36 C7 00   [19]  866 	ld	-57 (ix),#0x00
                            867 ;src/Renderer.c:379: u8 lateralWallWidth=0;
   0DC6 DD 36 C6 00   [19]  868 	ld	-58 (ix),#0x00
                            869 ;src/Renderer.c:391: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   0DCA 21 AA 0A      [10]  870 	ld	hl, #_g_colors + 7
   0DCD 46            [ 7]  871 	ld	b,(hl)
   0DCE 21 A8 07      [10]  872 	ld	hl,#0x07A8
   0DD1 E5            [11]  873 	push	hl
   0DD2 C5            [11]  874 	push	bc
   0DD3 33            [ 6]  875 	inc	sp
   0DD4 21 00 9B      [10]  876 	ld	hl,#0x9B00
   0DD7 E5            [11]  877 	push	hl
   0DD8 CD 9A 4D      [17]  878 	call	_cpct_memset
                            879 ;src/Renderer.c:392: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
   0DDB 21 A4 0A      [10]  880 	ld	hl, #_g_colors + 1
   0DDE 46            [ 7]  881 	ld	b,(hl)
   0DDF 21 50 00      [10]  882 	ld	hl,#0x0050
   0DE2 E5            [11]  883 	push	hl
   0DE3 C5            [11]  884 	push	bc
   0DE4 33            [ 6]  885 	inc	sp
   0DE5 21 A8 A2      [10]  886 	ld	hl,#0xA2A8
   0DE8 E5            [11]  887 	push	hl
   0DE9 CD 9A 4D      [17]  888 	call	_cpct_memset
                            889 ;src/Renderer.c:393: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   0DEC 21 AB 0A      [10]  890 	ld	hl, #_g_colors + 8
   0DEF 46            [ 7]  891 	ld	b,(hl)
   0DF0 21 A8 07      [10]  892 	ld	hl,#0x07A8
   0DF3 E5            [11]  893 	push	hl
   0DF4 C5            [11]  894 	push	bc
   0DF5 33            [ 6]  895 	inc	sp
   0DF6 21 F8 A2      [10]  896 	ld	hl,#0xA2F8
   0DF9 E5            [11]  897 	push	hl
   0DFA CD 9A 4D      [17]  898 	call	_cpct_memset
                            899 ;src/Renderer.c:395: calculate_cells_in_view();
   0DFD CD E7 08      [17]  900 	call	_calculate_cells_in_view
                            901 ;src/Renderer.c:414: currentCellID = cells_in_view_array[lineStart + 1];
   0E00 2A B6 0A      [16]  902 	ld	hl,(_cells_in_view_array)
   0E03 DD 75 DF      [19]  903 	ld	-33 (ix),l
   0E06 DD 74 E0      [19]  904 	ld	-32 (ix),h
                            905 ;src/Renderer.c:397: if(g_texturedWalls){
   0E09 3A B5 0A      [13]  906 	ld	a,(#_g_texturedWalls + 0)
   0E0C B7            [ 4]  907 	or	a, a
   0E0D CA 55 13      [10]  908 	jp	Z,00358$
                            909 ;src/Renderer.c:399: do{
   0E10 DD 36 C9 06   [19]  910 	ld	-55 (ix),#0x06
   0E14                     911 00175$:
                            912 ;src/Renderer.c:401: --z;
   0E14 DD 35 C9      [23]  913 	dec	-55 (ix)
                            914 ;src/Renderer.c:405: xCellCount = (z) ? (zHeight >> 1) : 0;
   0E17 DD 7E CC      [19]  915 	ld	a,-52 (ix)
   0E1A CB 3F         [ 8]  916 	srl	a
   0E1C DD 77 E8      [19]  917 	ld	-24 (ix),a
   0E1F DD 7E C9      [19]  918 	ld	a,-55 (ix)
   0E22 B7            [ 4]  919 	or	a, a
   0E23 28 05         [12]  920 	jr	Z,00262$
   0E25 DD 4E E8      [19]  921 	ld	c,-24 (ix)
   0E28 18 02         [12]  922 	jr	00263$
   0E2A                     923 00262$:
   0E2A 0E 00         [ 7]  924 	ld	c,#0x00
   0E2C                     925 00263$:
   0E2C DD 71 EA      [19]  926 	ld	-22 (ix),c
                            927 ;src/Renderer.c:406: lateralWallSlope=0;
   0E2F DD 36 EE 00   [19]  928 	ld	-18 (ix),#0x00
                            929 ;src/Renderer.c:407: lateralWallSlopeCounter=0;
   0E33 DD 36 FA 00   [19]  930 	ld	-6 (ix),#0x00
                            931 ;src/Renderer.c:408: xHeight=0;
   0E37 DD 36 EB 00   [19]  932 	ld	-21 (ix),#0x00
                            933 ;src/Renderer.c:411: lateralWallCounter = 0;
   0E3B DD 36 F8 00   [19]  934 	ld	-8 (ix),#0x00
                            935 ;src/Renderer.c:413: newCell=1;
   0E3F DD 36 FF 01   [19]  936 	ld	-1 (ix),#0x01
                            937 ;src/Renderer.c:414: currentCellID = cells_in_view_array[lineStart + 1];
   0E43 DD 7E C7      [19]  938 	ld	a,-57 (ix)
   0E46 DD 77 E3      [19]  939 	ld	-29 (ix),a
   0E49 DD 36 E4 00   [19]  940 	ld	-28 (ix),#0x00
   0E4D DD 4E E3      [19]  941 	ld	c,-29 (ix)
   0E50 DD 46 E4      [19]  942 	ld	b,-28 (ix)
   0E53 03            [ 6]  943 	inc	bc
   0E54 DD 6E DF      [19]  944 	ld	l,-33 (ix)
   0E57 DD 66 E0      [19]  945 	ld	h,-32 (ix)
   0E5A 09            [11]  946 	add	hl,bc
   0E5B 7E            [ 7]  947 	ld	a,(hl)
   0E5C DD 77 E7      [19]  948 	ld	-25 (ix),a
                            949 ;src/Renderer.c:416: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   0E5F DD 7E DF      [19]  950 	ld	a,-33 (ix)
   0E62 DD 86 C7      [19]  951 	add	a, -57 (ix)
   0E65 6F            [ 4]  952 	ld	l,a
   0E66 DD 7E E0      [19]  953 	ld	a,-32 (ix)
   0E69 CE 00         [ 7]  954 	adc	a, #0x00
   0E6B 67            [ 4]  955 	ld	h,a
   0E6C 4E            [ 7]  956 	ld	c,(hl)
                            957 ;src/Renderer.c:417: if(lastCellWasWall&CELL_WALL_MASK){
   0E6D CB 79         [ 8]  958 	bit	7, c
   0E6F 28 09         [12]  959 	jr	Z,00102$
                            960 ;src/Renderer.c:418: lastWallId=lastCellWasWall;
   0E71 DD 71 E9      [19]  961 	ld	-23 (ix),c
                            962 ;src/Renderer.c:419: lastCellWasWall=1;
   0E74 DD 36 EF 01   [19]  963 	ld	-17 (ix),#0x01
   0E78 18 08         [12]  964 	jr	00296$
   0E7A                     965 00102$:
                            966 ;src/Renderer.c:422: lastCellWasWall=0;
   0E7A DD 36 EF 00   [19]  967 	ld	-17 (ix),#0x00
                            968 ;src/Renderer.c:423: lastWallId=CELLTYPE_FLOOR;
   0E7E DD 36 E9 00   [19]  969 	ld	-23 (ix),#0x00
                            970 ;src/Renderer.c:426: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   0E82                     971 00296$:
   0E82 DD 36 D6 00   [19]  972 	ld	-42 (ix),#0x00
   0E86 DD 36 CA 00   [19]  973 	ld	-54 (ix),#0x00
   0E8A                     974 00252$:
                            975 ;src/Renderer.c:428: if (xCellCount == zHeight)
   0E8A DD 7E CC      [19]  976 	ld	a,-52 (ix)
   0E8D DD 96 EA      [19]  977 	sub	a, -22 (ix)
   0E90 20 4B         [12]  978 	jr	NZ,00105$
                            979 ;src/Renderer.c:430: ++xCell;
   0E92 DD 34 D6      [23]  980 	inc	-42 (ix)
                            981 ;src/Renderer.c:431: xCellCount = 0;
   0E95 DD 36 EA 00   [19]  982 	ld	-22 (ix),#0x00
                            983 ;src/Renderer.c:432: newCell=1;
   0E99 DD 36 FF 01   [19]  984 	ld	-1 (ix),#0x01
                            985 ;src/Renderer.c:433: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   0E9D DD 7E D6      [19]  986 	ld	a,-42 (ix)
   0EA0 DD 77 F4      [19]  987 	ld	-12 (ix),a
   0EA3 DD 36 F5 00   [19]  988 	ld	-11 (ix),#0x00
   0EA7 DD 7E E3      [19]  989 	ld	a,-29 (ix)
   0EAA DD 86 F4      [19]  990 	add	a, -12 (ix)
   0EAD DD 77 F4      [19]  991 	ld	-12 (ix),a
   0EB0 DD 7E E4      [19]  992 	ld	a,-28 (ix)
   0EB3 DD 8E F5      [19]  993 	adc	a, -11 (ix)
   0EB6 DD 77 F5      [19]  994 	ld	-11 (ix),a
   0EB9 DD 34 F4      [23]  995 	inc	-12 (ix)
   0EBC 20 03         [12]  996 	jr	NZ,00608$
   0EBE DD 34 F5      [23]  997 	inc	-11 (ix)
   0EC1                     998 00608$:
   0EC1 DD 7E DF      [19]  999 	ld	a,-33 (ix)
   0EC4 DD 86 F4      [19] 1000 	add	a, -12 (ix)
   0EC7 DD 77 F4      [19] 1001 	ld	-12 (ix),a
   0ECA DD 7E E0      [19] 1002 	ld	a,-32 (ix)
   0ECD DD 8E F5      [19] 1003 	adc	a, -11 (ix)
   0ED0 DD 77 F5      [19] 1004 	ld	-11 (ix),a
   0ED3 DD 6E F4      [19] 1005 	ld	l,-12 (ix)
   0ED6 DD 66 F5      [19] 1006 	ld	h,-11 (ix)
   0ED9 7E            [ 7] 1007 	ld	a,(hl)
   0EDA DD 77 E7      [19] 1008 	ld	-25 (ix),a
   0EDD                    1009 00105$:
                           1010 ;src/Renderer.c:435: if(!(x%2)){
   0EDD DD 7E CA      [19] 1011 	ld	a,-54 (ix)
   0EE0 E6 01         [ 7] 1012 	and	a, #0x01
   0EE2 DD 77 F4      [19] 1013 	ld	-12 (ix),a
                           1014 ;src/Renderer.c:438: if (currentCellID & CELL_WALL_MASK)//Wall
   0EE5 DD 7E E7      [19] 1015 	ld	a,-25 (ix)
   0EE8 E6 80         [ 7] 1016 	and	a, #0x80
   0EEA DD 77 F9      [19] 1017 	ld	-7 (ix),a
                           1018 ;src/Renderer.c:458: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   0EED DD 7E EA      [19] 1019 	ld	a,-22 (ix)
   0EF0 DD 77 FB      [19] 1020 	ld	-5 (ix),a
   0EF3 DD 36 FC 00   [19] 1021 	ld	-4 (ix),#0x00
   0EF7 DD 7E CC      [19] 1022 	ld	a,-52 (ix)
   0EFA DD 77 FD      [19] 1023 	ld	-3 (ix),a
                           1024 ;src/Renderer.c:435: if(!(x%2)){
   0EFD DD 7E F4      [19] 1025 	ld	a,-12 (ix)
   0F00 B7            [ 4] 1026 	or	a, a
   0F01 C2 B4 0F      [10] 1027 	jp	NZ,00118$
                           1028 ;src/Renderer.c:436: if ((lateralWallCounter == 0)||newCell)
   0F04 DD 7E F8      [19] 1029 	ld	a,-8 (ix)
   0F07 B7            [ 4] 1030 	or	a, a
   0F08 28 07         [12] 1031 	jr	Z,00114$
   0F0A DD 7E FF      [19] 1032 	ld	a,-1 (ix)
   0F0D B7            [ 4] 1033 	or	a, a
   0F0E CA B4 0F      [10] 1034 	jp	Z,00118$
   0F11                    1035 00114$:
                           1036 ;src/Renderer.c:438: if (currentCellID & CELL_WALL_MASK)//Wall
   0F11 DD 7E F9      [19] 1037 	ld	a,-7 (ix)
   0F14 B7            [ 4] 1038 	or	a, a
   0F15 28 22         [12] 1039 	jr	Z,00112$
                           1040 ;src/Renderer.c:440: lateralWallCounter = 0;//(zHeight - xCellCount);
   0F17 DD 36 F8 00   [19] 1041 	ld	-8 (ix),#0x00
                           1042 ;src/Renderer.c:441: lateralWallSlope = 0;
   0F1B DD 36 EE 00   [19] 1043 	ld	-18 (ix),#0x00
                           1044 ;src/Renderer.c:442: xHeight = zHeight;
   0F1F DD 7E CC      [19] 1045 	ld	a,-52 (ix)
   0F22 DD 77 EB      [19] 1046 	ld	-21 (ix),a
                           1047 ;src/Renderer.c:443: color = currentCellID&0b01111111;
   0F25 DD 7E E7      [19] 1048 	ld	a,-25 (ix)
   0F28 E6 7F         [ 7] 1049 	and	a, #0x7F
   0F2A DD 77 FE      [19] 1050 	ld	-2 (ix),a
                           1051 ;src/Renderer.c:444: lastCellWasWall = 1;
   0F2D DD 36 EF 01   [19] 1052 	ld	-17 (ix),#0x01
                           1053 ;src/Renderer.c:445: lastWallId=currentCellID;
   0F31 DD 7E E7      [19] 1054 	ld	a,-25 (ix)
   0F34 DD 77 E9      [19] 1055 	ld	-23 (ix),a
   0F37 18 77         [12] 1056 	jr	00113$
   0F39                    1057 00112$:
                           1058 ;src/Renderer.c:448: if(lateralWallCounter==0){//Lateral wall not finished
   0F39 DD 7E F8      [19] 1059 	ld	a,-8 (ix)
   0F3C B7            [ 4] 1060 	or	a, a
   0F3D 20 71         [12] 1061 	jr	NZ,00113$
                           1062 ;src/Renderer.c:449: if (lastCellWasWall)
   0F3F DD 7E EF      [19] 1063 	ld	a,-17 (ix)
   0F42 B7            [ 4] 1064 	or	a, a
   0F43 28 5B         [12] 1065 	jr	Z,00107$
                           1066 ;src/Renderer.c:452: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   0F45 DD 7E CE      [19] 1067 	ld	a,-50 (ix)
   0F48 DD 96 D6      [19] 1068 	sub	a, -42 (ix)
   0F4B 87            [ 4] 1069 	add	a, a
   0F4C 3C            [ 4] 1070 	inc	a
                           1071 ;src/Renderer.c:453: lateralWallSlopeCounter = lateralWallSlope / 2;
   0F4D DD 77 EE      [19] 1072 	ld	-18 (ix), a
   0F50 CB 3F         [ 8] 1073 	srl	a
   0F52 DD 77 FA      [19] 1074 	ld	-6 (ix),a
                           1075 ;src/Renderer.c:454: lateralWallCounter = lateralWallSlope * zHeight;
   0F55 DD 5E CC      [19] 1076 	ld	e,-52 (ix)
   0F58 DD 66 EE      [19] 1077 	ld	h,-18 (ix)
   0F5B 2E 00         [ 7] 1078 	ld	l, #0x00
   0F5D 55            [ 4] 1079 	ld	d, l
   0F5E 06 08         [ 7] 1080 	ld	b, #0x08
   0F60                    1081 00609$:
   0F60 29            [11] 1082 	add	hl,hl
   0F61 30 01         [12] 1083 	jr	NC,00610$
   0F63 19            [11] 1084 	add	hl,de
   0F64                    1085 00610$:
   0F64 10 FA         [13] 1086 	djnz	00609$
                           1087 ;src/Renderer.c:455: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   0F66 7D            [ 4] 1088 	ld	a,l
   0F67 E6 FC         [ 7] 1089 	and	a, #0xFC
   0F69 CB C7         [ 8] 1090 	set	0, a
   0F6B CB 3F         [ 8] 1091 	srl	a
   0F6D CB 3F         [ 8] 1092 	srl	a
   0F6F DD 96 EA      [19] 1093 	sub	a, -22 (ix)
                           1094 ;src/Renderer.c:456: lateralWallWidth=lateralWallCounter;
   0F72 DD 77 F8      [19] 1095 	ld	-8 (ix), a
   0F75 DD 77 C6      [19] 1096 	ld	-58 (ix),a
                           1097 ;src/Renderer.c:457: lastCellWasWall = 0;
   0F78 DD 36 EF 00   [19] 1098 	ld	-17 (ix),#0x00
                           1099 ;src/Renderer.c:458: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   0F7C DD 6E FB      [19] 1100 	ld	l,-5 (ix)
   0F7F DD 66 FC      [19] 1101 	ld	h,-4 (ix)
   0F82 29            [11] 1102 	add	hl, hl
   0F83 DD 4E EE      [19] 1103 	ld	c,-18 (ix)
   0F86 06 00         [ 7] 1104 	ld	b,#0x00
   0F88 C5            [11] 1105 	push	bc
   0F89 E5            [11] 1106 	push	hl
   0F8A CD 79 4E      [17] 1107 	call	__divsint
   0F8D F1            [10] 1108 	pop	af
   0F8E F1            [10] 1109 	pop	af
   0F8F DD 7E FD      [19] 1110 	ld	a,-3 (ix)
   0F92 95            [ 4] 1111 	sub	a, l
   0F93 DD 77 EB      [19] 1112 	ld	-21 (ix),a
                           1113 ;src/Renderer.c:459: color = lastWallId&0b01111111;
   0F96 DD 7E E9      [19] 1114 	ld	a,-23 (ix)
   0F99 E6 7F         [ 7] 1115 	and	a, #0x7F
   0F9B DD 77 FE      [19] 1116 	ld	-2 (ix),a
   0F9E 18 10         [12] 1117 	jr	00113$
   0FA0                    1118 00107$:
                           1119 ;src/Renderer.c:463: xHeight = 0;
   0FA0 DD 36 EB 00   [19] 1120 	ld	-21 (ix),#0x00
                           1121 ;src/Renderer.c:464: lastCellWasWall = 0;
   0FA4 DD 36 EF 00   [19] 1122 	ld	-17 (ix),#0x00
                           1123 ;src/Renderer.c:465: lateralWallSlope=0;
   0FA8 DD 36 EE 00   [19] 1124 	ld	-18 (ix),#0x00
                           1125 ;src/Renderer.c:466: lastWallId=0;
   0FAC DD 36 E9 00   [19] 1126 	ld	-23 (ix),#0x00
   0FB0                    1127 00113$:
                           1128 ;src/Renderer.c:470: newCell=0;
   0FB0 DD 36 FF 00   [19] 1129 	ld	-1 (ix),#0x00
   0FB4                    1130 00118$:
                           1131 ;src/Renderer.c:473: if (lateralWallCounter > 0)
   0FB4 DD 7E F8      [19] 1132 	ld	a,-8 (ix)
   0FB7 B7            [ 4] 1133 	or	a, a
   0FB8 28 1E         [12] 1134 	jr	Z,00124$
                           1135 ;src/Renderer.c:476: if (lateralWallSlope != 0)
   0FBA DD 7E EE      [19] 1136 	ld	a,-18 (ix)
   0FBD B7            [ 4] 1137 	or	a, a
   0FBE 28 15         [12] 1138 	jr	Z,00122$
                           1139 ;src/Renderer.c:478: if (lateralWallSlopeCounter == lateralWallSlope)
   0FC0 DD 7E FA      [19] 1140 	ld	a,-6 (ix)
   0FC3 DD 96 EE      [19] 1141 	sub	a, -18 (ix)
   0FC6 20 0A         [12] 1142 	jr	NZ,00120$
                           1143 ;src/Renderer.c:480: lateralWallSlopeCounter = 0;
   0FC8 DD 36 FA 00   [19] 1144 	ld	-6 (ix),#0x00
                           1145 ;src/Renderer.c:481: xHeight -= 2;
   0FCC DD 35 EB      [23] 1146 	dec	-21 (ix)
   0FCF DD 35 EB      [23] 1147 	dec	-21 (ix)
   0FD2                    1148 00120$:
                           1149 ;src/Renderer.c:483: ++lateralWallSlopeCounter;
   0FD2 DD 34 FA      [23] 1150 	inc	-6 (ix)
   0FD5                    1151 00122$:
                           1152 ;src/Renderer.c:486: --lateralWallCounter;
   0FD5 DD 35 F8      [23] 1153 	dec	-8 (ix)
   0FD8                    1154 00124$:
                           1155 ;src/Renderer.c:497: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   0FD8 DD 7E CC      [19] 1156 	ld	a,-52 (ix)
   0FDB DD 77 DD      [19] 1157 	ld	-35 (ix),a
   0FDE DD 36 DE 00   [19] 1158 	ld	-34 (ix),#0x00
                           1159 ;src/Renderer.c:489: if (!(x%2))
   0FE2 DD 7E F4      [19] 1160 	ld	a,-12 (ix)
   0FE5 B7            [ 4] 1161 	or	a, a
   0FE6 C2 67 10      [10] 1162 	jp	NZ,00136$
                           1163 ;src/Renderer.c:499: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   0FE9 DD 46 CA      [19] 1164 	ld	b,-54 (ix)
   0FEC CB 38         [ 8] 1165 	srl	b
                           1166 ;src/Renderer.c:497: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   0FEE DD 6E FB      [19] 1167 	ld	l,-5 (ix)
   0FF1 DD 66 FC      [19] 1168 	ld	h,-4 (ix)
   0FF4 29            [11] 1169 	add	hl, hl
   0FF5 29            [11] 1170 	add	hl, hl
   0FF6 29            [11] 1171 	add	hl, hl
   0FF7 29            [11] 1172 	add	hl, hl
   0FF8 29            [11] 1173 	add	hl, hl
   0FF9 C5            [11] 1174 	push	bc
   0FFA DD 5E DD      [19] 1175 	ld	e,-35 (ix)
   0FFD DD 56 DE      [19] 1176 	ld	d,-34 (ix)
   1000 D5            [11] 1177 	push	de
   1001 E5            [11] 1178 	push	hl
   1002 CD 79 4E      [17] 1179 	call	__divsint
   1005 F1            [10] 1180 	pop	af
   1006 F1            [10] 1181 	pop	af
   1007 C1            [10] 1182 	pop	bc
   1008 4D            [ 4] 1183 	ld	c,l
                           1184 ;src/Renderer.c:491: if(xHeight > 0){
   1009 DD 7E EB      [19] 1185 	ld	a,-21 (ix)
   100C B7            [ 4] 1186 	or	a, a
   100D 28 3A         [12] 1187 	jr	Z,00129$
                           1188 ;src/Renderer.c:492: if (lateralWallCounter > 0)
   100F DD 7E F8      [19] 1189 	ld	a,-8 (ix)
   1012 B7            [ 4] 1190 	or	a, a
   1013 28 21         [12] 1191 	jr	Z,00126$
                           1192 ;src/Renderer.c:494: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   1015 DD 5E C6      [19] 1193 	ld	e,-58 (ix)
   1018 16 00         [ 7] 1194 	ld	d,#0x00
   101A DD 6E F8      [19] 1195 	ld	l,-8 (ix)
   101D 26 00         [ 7] 1196 	ld	h,#0x00
   101F 7B            [ 4] 1197 	ld	a,e
   1020 95            [ 4] 1198 	sub	a, l
   1021 6F            [ 4] 1199 	ld	l,a
   1022 7A            [ 4] 1200 	ld	a,d
   1023 9C            [ 4] 1201 	sbc	a, h
   1024 67            [ 4] 1202 	ld	h,a
   1025 29            [11] 1203 	add	hl, hl
   1026 29            [11] 1204 	add	hl, hl
   1027 29            [11] 1205 	add	hl, hl
   1028 29            [11] 1206 	add	hl, hl
   1029 29            [11] 1207 	add	hl, hl
   102A C5            [11] 1208 	push	bc
   102B D5            [11] 1209 	push	de
   102C E5            [11] 1210 	push	hl
   102D CD 79 4E      [17] 1211 	call	__divsint
   1030 F1            [10] 1212 	pop	af
   1031 F1            [10] 1213 	pop	af
   1032 C1            [10] 1214 	pop	bc
   1033 55            [ 4] 1215 	ld	d,l
   1034 18 01         [12] 1216 	jr	00127$
   1036                    1217 00126$:
                           1218 ;src/Renderer.c:497: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   1036 51            [ 4] 1219 	ld	d,c
   1037                    1220 00127$:
                           1221 ;src/Renderer.c:499: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   1037 C5            [11] 1222 	push	bc
   1038 D5            [11] 1223 	push	de
   1039 33            [ 6] 1224 	inc	sp
   103A DD 66 FE      [19] 1225 	ld	h,-2 (ix)
   103D DD 6E EB      [19] 1226 	ld	l,-21 (ix)
   1040 E5            [11] 1227 	push	hl
   1041 C5            [11] 1228 	push	bc
   1042 33            [ 6] 1229 	inc	sp
   1043 CD 75 0C      [17] 1230 	call	_draw_column_to_buffer
   1046 F1            [10] 1231 	pop	af
   1047 F1            [10] 1232 	pop	af
   1048 C1            [10] 1233 	pop	bc
   1049                    1234 00129$:
                           1235 ;src/Renderer.c:501: if(!(currentCellID&CELL_WALL_MASK)){
   1049 DD 7E F9      [19] 1236 	ld	a,-7 (ix)
   104C B7            [ 4] 1237 	or	a, a
   104D 20 18         [12] 1238 	jr	NZ,00136$
                           1239 ;src/Renderer.c:502: if(currentCellID&CELL_ENEMY_MASK){
   104F DD 7E E7      [19] 1240 	ld	a,-25 (ix)
   1052 E6 0F         [ 7] 1241 	and	a, #0x0F
   1054 28 11         [12] 1242 	jr	Z,00136$
                           1243 ;src/Renderer.c:503: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   1056 79            [ 4] 1244 	ld	a,c
   1057 F5            [11] 1245 	push	af
   1058 33            [ 6] 1246 	inc	sp
   1059 DD 66 E7      [19] 1247 	ld	h,-25 (ix)
   105C DD 6E CC      [19] 1248 	ld	l,-52 (ix)
   105F E5            [11] 1249 	push	hl
   1060 C5            [11] 1250 	push	bc
   1061 33            [ 6] 1251 	inc	sp
   1062 CD 34 0B      [17] 1252 	call	_draw_column_to_buffer_enemy
   1065 F1            [10] 1253 	pop	af
   1066 F1            [10] 1254 	pop	af
                           1255 ;src/Renderer.c:505: else if(currentCellID&CELL_ITEM_MASK){
   1067                    1256 00136$:
                           1257 ;src/Renderer.c:511: ++xCellCount;
   1067 DD 34 EA      [23] 1258 	inc	-22 (ix)
                           1259 ;src/Renderer.c:426: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   106A DD 34 CA      [23] 1260 	inc	-54 (ix)
                           1261 ;src/Renderer.c:414: currentCellID = cells_in_view_array[lineStart + 1];
   106D 2A B6 0A      [16] 1262 	ld	hl,(_cells_in_view_array)
   1070 DD 75 DF      [19] 1263 	ld	-33 (ix),l
   1073 DD 74 E0      [19] 1264 	ld	-32 (ix),h
                           1265 ;src/Renderer.c:426: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   1076 DD 7E CA      [19] 1266 	ld	a,-54 (ix)
   1079 D6 50         [ 7] 1267 	sub	a, #0x50
   107B DA 8A 0E      [10] 1268 	jp	C,00252$
                           1269 ;src/Renderer.c:518: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   107E DD 7E C9      [19] 1270 	ld	a,-55 (ix)
   1081 B7            [ 4] 1271 	or	a, a
   1082 28 05         [12] 1272 	jr	Z,00264$
   1084 DD 4E E8      [19] 1273 	ld	c,-24 (ix)
   1087 18 02         [12] 1274 	jr	00265$
   1089                    1275 00264$:
   1089 0E 00         [ 7] 1276 	ld	c,#0x00
   108B                    1277 00265$:
   108B DD 71 FB      [19] 1278 	ld	-5 (ix),c
                           1279 ;src/Renderer.c:519: lateralWallSlope=0;
   108E DD 36 F9 00   [19] 1280 	ld	-7 (ix),#0x00
                           1281 ;src/Renderer.c:520: lateralWallSlopeCounter=0;
   1092 DD 36 F4 00   [19] 1282 	ld	-12 (ix),#0x00
                           1283 ;src/Renderer.c:521: xHeight=0;
   1096 DD 36 EF 00   [19] 1284 	ld	-17 (ix),#0x00
                           1285 ;src/Renderer.c:523: lateralWallCounter = 0;
   109A DD 36 E9 00   [19] 1286 	ld	-23 (ix),#0x00
                           1287 ;src/Renderer.c:524: lineEnd = lineStart + offsetDiff * 2 + 2;
   109E DD 7E CE      [19] 1288 	ld	a,-50 (ix)
   10A1 87            [ 4] 1289 	add	a, a
   10A2 4F            [ 4] 1290 	ld	c,a
   10A3 DD 7E C7      [19] 1291 	ld	a,-57 (ix)
   10A6 81            [ 4] 1292 	add	a, c
   10A7 DD 77 E7      [19] 1293 	ld	-25 (ix), a
   10AA 4F            [ 4] 1294 	ld	c, a
   10AB 0C            [ 4] 1295 	inc	c
   10AC 0C            [ 4] 1296 	inc	c
                           1297 ;src/Renderer.c:526: newCell=1;
   10AD DD 36 E3 01   [19] 1298 	ld	-29 (ix),#0x01
                           1299 ;src/Renderer.c:527: currentCellID = cells_in_view_array[lineEnd - 1];
   10B1 DD 71 F0      [19] 1300 	ld	-16 (ix),c
   10B4 DD 36 F1 00   [19] 1301 	ld	-15 (ix),#0x00
   10B8 DD 5E F0      [19] 1302 	ld	e,-16 (ix)
   10BB DD 56 F1      [19] 1303 	ld	d,-15 (ix)
   10BE 1B            [ 6] 1304 	dec	de
   10BF DD 6E DF      [19] 1305 	ld	l,-33 (ix)
   10C2 DD 66 E0      [19] 1306 	ld	h,-32 (ix)
   10C5 19            [11] 1307 	add	hl,de
   10C6 7E            [ 7] 1308 	ld	a,(hl)
   10C7 DD 77 FF      [19] 1309 	ld	-1 (ix),a
                           1310 ;src/Renderer.c:529: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   10CA DD 6E DF      [19] 1311 	ld	l,-33 (ix)
   10CD DD 66 E0      [19] 1312 	ld	h,-32 (ix)
   10D0 06 00         [ 7] 1313 	ld	b,#0x00
   10D2 09            [11] 1314 	add	hl, bc
   10D3 4E            [ 7] 1315 	ld	c,(hl)
                           1316 ;src/Renderer.c:530: if(lastCellWasWall&CELL_WALL_MASK){
   10D4 CB 79         [ 8] 1317 	bit	7, c
   10D6 28 09         [12] 1318 	jr	Z,00139$
                           1319 ;src/Renderer.c:531: lastWallId=lastCellWasWall;
   10D8 DD 71 F8      [19] 1320 	ld	-8 (ix),c
                           1321 ;src/Renderer.c:532: lastCellWasWall=1;
   10DB DD 36 EB 01   [19] 1322 	ld	-21 (ix),#0x01
   10DF 18 08         [12] 1323 	jr	00315$
   10E1                    1324 00139$:
                           1325 ;src/Renderer.c:535: lastCellWasWall=0;
   10E1 DD 36 EB 00   [19] 1326 	ld	-21 (ix),#0x00
                           1327 ;src/Renderer.c:536: lastWallId=CELLTYPE_FLOOR;
   10E5 DD 36 F8 00   [19] 1328 	ld	-8 (ix),#0x00
                           1329 ;src/Renderer.c:539: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   10E9                    1330 00315$:
   10E9 DD 36 D6 00   [19] 1331 	ld	-42 (ix),#0x00
   10ED DD 36 CA 9F   [19] 1332 	ld	-54 (ix),#0x9F
   10F1                    1333 00254$:
                           1334 ;src/Renderer.c:542: if (xCellCount == zHeight)
   10F1 DD 7E CC      [19] 1335 	ld	a,-52 (ix)
   10F4 DD 96 FB      [19] 1336 	sub	a, -5 (ix)
   10F7 20 50         [12] 1337 	jr	NZ,00142$
                           1338 ;src/Renderer.c:544: ++xCell;
   10F9 DD 34 D6      [23] 1339 	inc	-42 (ix)
                           1340 ;src/Renderer.c:545: xCellCount = 0;
   10FC DD 36 FB 00   [19] 1341 	ld	-5 (ix),#0x00
                           1342 ;src/Renderer.c:546: newCell=1;
   1100 DD 36 E3 01   [19] 1343 	ld	-29 (ix),#0x01
                           1344 ;src/Renderer.c:547: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   1104 DD 7E D6      [19] 1345 	ld	a,-42 (ix)
   1107 DD 77 D9      [19] 1346 	ld	-39 (ix),a
   110A DD 36 DA 00   [19] 1347 	ld	-38 (ix),#0x00
   110E DD 7E F0      [19] 1348 	ld	a,-16 (ix)
   1111 DD 96 D9      [19] 1349 	sub	a, -39 (ix)
   1114 DD 77 D9      [19] 1350 	ld	-39 (ix),a
   1117 DD 7E F1      [19] 1351 	ld	a,-15 (ix)
   111A DD 9E DA      [19] 1352 	sbc	a, -38 (ix)
   111D DD 77 DA      [19] 1353 	ld	-38 (ix),a
   1120 DD 6E D9      [19] 1354 	ld	l,-39 (ix)
   1123 DD 66 DA      [19] 1355 	ld	h,-38 (ix)
   1126 2B            [ 6] 1356 	dec	hl
   1127 DD 75 D9      [19] 1357 	ld	-39 (ix),l
   112A DD 74 DA      [19] 1358 	ld	-38 (ix),h
   112D DD 7E DF      [19] 1359 	ld	a,-33 (ix)
   1130 DD 86 D9      [19] 1360 	add	a, -39 (ix)
   1133 DD 77 D9      [19] 1361 	ld	-39 (ix),a
   1136 DD 7E E0      [19] 1362 	ld	a,-32 (ix)
   1139 DD 8E DA      [19] 1363 	adc	a, -38 (ix)
   113C DD 77 DA      [19] 1364 	ld	-38 (ix),a
   113F DD 6E D9      [19] 1365 	ld	l,-39 (ix)
   1142 DD 66 DA      [19] 1366 	ld	h,-38 (ix)
   1145 7E            [ 7] 1367 	ld	a,(hl)
   1146 DD 77 FF      [19] 1368 	ld	-1 (ix),a
   1149                    1369 00142$:
                           1370 ;src/Renderer.c:549: if(!(x%2)){
   1149 DD 7E CA      [19] 1371 	ld	a,-54 (ix)
   114C E6 01         [ 7] 1372 	and	a, #0x01
   114E DD 77 D9      [19] 1373 	ld	-39 (ix),a
                           1374 ;src/Renderer.c:438: if (currentCellID & CELL_WALL_MASK)//Wall
   1151 DD 7E FF      [19] 1375 	ld	a,-1 (ix)
   1154 E6 80         [ 7] 1376 	and	a, #0x80
   1156 DD 77 FA      [19] 1377 	ld	-6 (ix),a
                           1378 ;src/Renderer.c:458: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   1159 DD 7E FB      [19] 1379 	ld	a,-5 (ix)
   115C DD 77 E5      [19] 1380 	ld	-27 (ix),a
   115F DD 36 E6 00   [19] 1381 	ld	-26 (ix),#0x00
                           1382 ;src/Renderer.c:549: if(!(x%2)){
   1163 DD 7E D9      [19] 1383 	ld	a,-39 (ix)
   1166 B7            [ 4] 1384 	or	a, a
   1167 C2 39 12      [10] 1385 	jp	NZ,00155$
                           1386 ;src/Renderer.c:550: if (lateralWallCounter == 0 || newCell)
   116A DD 7E E9      [19] 1387 	ld	a,-23 (ix)
   116D B7            [ 4] 1388 	or	a, a
   116E 28 07         [12] 1389 	jr	Z,00151$
   1170 DD 7E E3      [19] 1390 	ld	a,-29 (ix)
   1173 B7            [ 4] 1391 	or	a, a
   1174 CA 39 12      [10] 1392 	jp	Z,00155$
   1177                    1393 00151$:
                           1394 ;src/Renderer.c:552: if ( currentCellID & CELL_WALL_MASK)//Wall
   1177 DD 7E FA      [19] 1395 	ld	a,-6 (ix)
   117A B7            [ 4] 1396 	or	a, a
   117B 28 23         [12] 1397 	jr	Z,00149$
                           1398 ;src/Renderer.c:554: lateralWallCounter = 0;
   117D DD 36 E9 00   [19] 1399 	ld	-23 (ix),#0x00
                           1400 ;src/Renderer.c:555: lateralWallSlope = 0;
   1181 DD 36 F9 00   [19] 1401 	ld	-7 (ix),#0x00
                           1402 ;src/Renderer.c:556: xHeight = zHeight;
   1185 DD 7E CC      [19] 1403 	ld	a,-52 (ix)
   1188 DD 77 EF      [19] 1404 	ld	-17 (ix),a
                           1405 ;src/Renderer.c:557: color = currentCellID&0b01111111;
   118B DD 7E FF      [19] 1406 	ld	a,-1 (ix)
   118E E6 7F         [ 7] 1407 	and	a, #0x7F
   1190 DD 77 FE      [19] 1408 	ld	-2 (ix),a
                           1409 ;src/Renderer.c:558: lastCellWasWall = 1;
   1193 DD 36 EB 01   [19] 1410 	ld	-21 (ix),#0x01
                           1411 ;src/Renderer.c:559: lastWallId=currentCellID;
   1197 DD 7E FF      [19] 1412 	ld	a,-1 (ix)
   119A DD 77 F8      [19] 1413 	ld	-8 (ix),a
   119D C3 35 12      [10] 1414 	jp	00150$
   11A0                    1415 00149$:
                           1416 ;src/Renderer.c:561: else if(lateralWallCounter==0){
   11A0 DD 7E E9      [19] 1417 	ld	a,-23 (ix)
   11A3 B7            [ 4] 1418 	or	a, a
   11A4 C2 35 12      [10] 1419 	jp	NZ,00150$
                           1420 ;src/Renderer.c:562: if (lastCellWasWall)
   11A7 DD 7E EB      [19] 1421 	ld	a,-21 (ix)
   11AA B7            [ 4] 1422 	or	a, a
   11AB 28 78         [12] 1423 	jr	Z,00144$
                           1424 ;src/Renderer.c:565: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   11AD DD 7E CE      [19] 1425 	ld	a,-50 (ix)
   11B0 DD 96 D6      [19] 1426 	sub	a, -42 (ix)
   11B3 87            [ 4] 1427 	add	a, a
   11B4 3C            [ 4] 1428 	inc	a
                           1429 ;src/Renderer.c:566: lateralWallSlopeCounter = lateralWallSlope / 2;
   11B5 DD 77 F9      [19] 1430 	ld	-7 (ix), a
   11B8 CB 3F         [ 8] 1431 	srl	a
   11BA DD 77 F4      [19] 1432 	ld	-12 (ix),a
                           1433 ;src/Renderer.c:567: lateralWallCounter = lateralWallSlope * zHeight;
   11BD DD 5E CC      [19] 1434 	ld	e,-52 (ix)
   11C0 DD 66 F9      [19] 1435 	ld	h,-7 (ix)
   11C3 2E 00         [ 7] 1436 	ld	l, #0x00
   11C5 55            [ 4] 1437 	ld	d, l
   11C6 06 08         [ 7] 1438 	ld	b, #0x08
   11C8                    1439 00617$:
   11C8 29            [11] 1440 	add	hl,hl
   11C9 30 01         [12] 1441 	jr	NC,00618$
   11CB 19            [11] 1442 	add	hl,de
   11CC                    1443 00618$:
   11CC 10 FA         [13] 1444 	djnz	00617$
                           1445 ;src/Renderer.c:568: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   11CE 4D            [ 4] 1446 	ld	c,l
   11CF 06 00         [ 7] 1447 	ld	b,#0x00
   11D1 7D            [ 4] 1448 	ld	a,l
   11D2 E6 03         [ 7] 1449 	and	a, #0x03
   11D4 5F            [ 4] 1450 	ld	e,a
   11D5 16 00         [ 7] 1451 	ld	d,#0x00
   11D7 79            [ 4] 1452 	ld	a,c
   11D8 93            [ 4] 1453 	sub	a, e
   11D9 4F            [ 4] 1454 	ld	c,a
   11DA 78            [ 4] 1455 	ld	a,b
   11DB 9A            [ 4] 1456 	sbc	a, d
   11DC 47            [ 4] 1457 	ld	b,a
   11DD 59            [ 4] 1458 	ld	e, c
   11DE 50            [ 4] 1459 	ld	d, b
   11DF 13            [ 6] 1460 	inc	de
   11E0 6B            [ 4] 1461 	ld	l, e
   11E1 62            [ 4] 1462 	ld	h, d
   11E2 CB 7A         [ 8] 1463 	bit	7, d
   11E4 28 04         [12] 1464 	jr	Z,00266$
   11E6 21 04 00      [10] 1465 	ld	hl,#0x0004
   11E9 09            [11] 1466 	add	hl,bc
   11EA                    1467 00266$:
   11EA CB 2C         [ 8] 1468 	sra	h
   11EC CB 1D         [ 8] 1469 	rr	l
   11EE CB 2C         [ 8] 1470 	sra	h
   11F0 CB 1D         [ 8] 1471 	rr	l
   11F2 DD 4E FB      [19] 1472 	ld	c,-5 (ix)
   11F5 7D            [ 4] 1473 	ld	a,l
   11F6 91            [ 4] 1474 	sub	a, c
                           1475 ;src/Renderer.c:569: lateralWallWidth=lateralWallCounter;
   11F7 DD 77 E9      [19] 1476 	ld	-23 (ix), a
   11FA DD 77 C6      [19] 1477 	ld	-58 (ix),a
                           1478 ;src/Renderer.c:570: lastCellWasWall = 0;
   11FD DD 36 EB 00   [19] 1479 	ld	-21 (ix),#0x00
                           1480 ;src/Renderer.c:571: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   1201 DD 6E E5      [19] 1481 	ld	l,-27 (ix)
   1204 DD 66 E6      [19] 1482 	ld	h,-26 (ix)
   1207 29            [11] 1483 	add	hl, hl
   1208 DD 4E F9      [19] 1484 	ld	c,-7 (ix)
   120B 06 00         [ 7] 1485 	ld	b,#0x00
   120D C5            [11] 1486 	push	bc
   120E E5            [11] 1487 	push	hl
   120F CD 79 4E      [17] 1488 	call	__divsint
   1212 F1            [10] 1489 	pop	af
   1213 F1            [10] 1490 	pop	af
   1214 DD 7E FD      [19] 1491 	ld	a,-3 (ix)
   1217 95            [ 4] 1492 	sub	a, l
   1218 DD 77 EF      [19] 1493 	ld	-17 (ix),a
                           1494 ;src/Renderer.c:572: color = lastWallId&0b01111111;
   121B DD 7E F8      [19] 1495 	ld	a,-8 (ix)
   121E E6 7F         [ 7] 1496 	and	a, #0x7F
   1220 DD 77 FE      [19] 1497 	ld	-2 (ix),a
   1223 18 10         [12] 1498 	jr	00150$
   1225                    1499 00144$:
                           1500 ;src/Renderer.c:576: xHeight = 0;
   1225 DD 36 EF 00   [19] 1501 	ld	-17 (ix),#0x00
                           1502 ;src/Renderer.c:577: lastCellWasWall = 0;
   1229 DD 36 EB 00   [19] 1503 	ld	-21 (ix),#0x00
                           1504 ;src/Renderer.c:578: lateralWallSlope=0;
   122D DD 36 F9 00   [19] 1505 	ld	-7 (ix),#0x00
                           1506 ;src/Renderer.c:579: lastWallId=0;
   1231 DD 36 F8 00   [19] 1507 	ld	-8 (ix),#0x00
   1235                    1508 00150$:
                           1509 ;src/Renderer.c:582: newCell=0;
   1235 DD 36 E3 00   [19] 1510 	ld	-29 (ix),#0x00
   1239                    1511 00155$:
                           1512 ;src/Renderer.c:587: if (lateralWallCounter > 0)
   1239 DD 7E E9      [19] 1513 	ld	a,-23 (ix)
   123C B7            [ 4] 1514 	or	a, a
   123D 28 1E         [12] 1515 	jr	Z,00161$
                           1516 ;src/Renderer.c:590: if (lateralWallSlope != 0)
   123F DD 7E F9      [19] 1517 	ld	a,-7 (ix)
   1242 B7            [ 4] 1518 	or	a, a
   1243 28 15         [12] 1519 	jr	Z,00159$
                           1520 ;src/Renderer.c:592: if (lateralWallSlopeCounter == lateralWallSlope)
   1245 DD 7E F9      [19] 1521 	ld	a,-7 (ix)
   1248 DD 96 F4      [19] 1522 	sub	a, -12 (ix)
   124B 20 0A         [12] 1523 	jr	NZ,00157$
                           1524 ;src/Renderer.c:594: lateralWallSlopeCounter = 0;
   124D DD 36 F4 00   [19] 1525 	ld	-12 (ix),#0x00
                           1526 ;src/Renderer.c:595: xHeight -= 2;
   1251 DD 35 EF      [23] 1527 	dec	-17 (ix)
   1254 DD 35 EF      [23] 1528 	dec	-17 (ix)
   1257                    1529 00157$:
                           1530 ;src/Renderer.c:597: ++lateralWallSlopeCounter;
   1257 DD 34 F4      [23] 1531 	inc	-12 (ix)
   125A                    1532 00159$:
                           1533 ;src/Renderer.c:599: --lateralWallCounter;
   125A DD 35 E9      [23] 1534 	dec	-23 (ix)
   125D                    1535 00161$:
                           1536 ;src/Renderer.c:603: if (!(x%2))
   125D DD 7E D9      [19] 1537 	ld	a,-39 (ix)
   1260 B7            [ 4] 1538 	or	a, a
   1261 C2 24 13      [10] 1539 	jp	NZ,00173$
                           1540 ;src/Renderer.c:616: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   1264 DD 7E CA      [19] 1541 	ld	a,-54 (ix)
   1267 CB 3F         [ 8] 1542 	srl	a
   1269 DD 77 D9      [19] 1543 	ld	-39 (ix),a
                           1544 ;src/Renderer.c:613: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   126C DD 7E DD      [19] 1545 	ld	a,-35 (ix)
   126F DD 96 E5      [19] 1546 	sub	a, -27 (ix)
   1272 DD 77 E5      [19] 1547 	ld	-27 (ix),a
   1275 DD 7E DE      [19] 1548 	ld	a,-34 (ix)
   1278 DD 9E E6      [19] 1549 	sbc	a, -26 (ix)
   127B DD 77 E6      [19] 1550 	ld	-26 (ix),a
   127E 3E 06         [ 7] 1551 	ld	a,#0x05+1
   1280 18 08         [12] 1552 	jr	00622$
   1282                    1553 00621$:
   1282 DD CB E5 26   [23] 1554 	sla	-27 (ix)
   1286 DD CB E6 16   [23] 1555 	rl	-26 (ix)
   128A                    1556 00622$:
   128A 3D            [ 4] 1557 	dec	a
   128B 20 F5         [12] 1558 	jr	NZ,00621$
   128D DD 6E DD      [19] 1559 	ld	l,-35 (ix)
   1290 DD 66 DE      [19] 1560 	ld	h,-34 (ix)
   1293 E5            [11] 1561 	push	hl
   1294 DD 6E E5      [19] 1562 	ld	l,-27 (ix)
   1297 DD 66 E6      [19] 1563 	ld	h,-26 (ix)
   129A E5            [11] 1564 	push	hl
   129B CD 79 4E      [17] 1565 	call	__divsint
   129E F1            [10] 1566 	pop	af
   129F F1            [10] 1567 	pop	af
   12A0 DD 74 E6      [19] 1568 	ld	-26 (ix),h
   12A3 DD 75 E5      [19] 1569 	ld	-27 (ix), l
   12A6 DD 75 E5      [19] 1570 	ld	-27 (ix), l
                           1571 ;src/Renderer.c:606: if(xHeight > 0){
   12A9 DD 7E EF      [19] 1572 	ld	a,-17 (ix)
   12AC B7            [ 4] 1573 	or	a, a
   12AD 28 55         [12] 1574 	jr	Z,00166$
                           1575 ;src/Renderer.c:608: if (lateralWallCounter > 0)
   12AF DD 7E E9      [19] 1576 	ld	a,-23 (ix)
   12B2 B7            [ 4] 1577 	or	a, a
   12B3 28 39         [12] 1578 	jr	Z,00163$
                           1579 ;src/Renderer.c:610: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   12B5 DD 7E E9      [19] 1580 	ld	a,-23 (ix)
   12B8 DD 77 F2      [19] 1581 	ld	-14 (ix),a
   12BB DD 36 F3 00   [19] 1582 	ld	-13 (ix),#0x00
   12BF 3E 06         [ 7] 1583 	ld	a,#0x05+1
   12C1 18 08         [12] 1584 	jr	00624$
   12C3                    1585 00623$:
   12C3 DD CB F2 26   [23] 1586 	sla	-14 (ix)
   12C7 DD CB F3 16   [23] 1587 	rl	-13 (ix)
   12CB                    1588 00624$:
   12CB 3D            [ 4] 1589 	dec	a
   12CC 20 F5         [12] 1590 	jr	NZ,00623$
   12CE DD 7E C6      [19] 1591 	ld	a,-58 (ix)
   12D1 DD 77 F6      [19] 1592 	ld	-10 (ix),a
   12D4 DD 36 F7 00   [19] 1593 	ld	-9 (ix),#0x00
   12D8 DD 6E F6      [19] 1594 	ld	l,-10 (ix)
   12DB DD 66 F7      [19] 1595 	ld	h,-9 (ix)
   12DE E5            [11] 1596 	push	hl
   12DF DD 6E F2      [19] 1597 	ld	l,-14 (ix)
   12E2 DD 66 F3      [19] 1598 	ld	h,-13 (ix)
   12E5 E5            [11] 1599 	push	hl
   12E6 CD 79 4E      [17] 1600 	call	__divsint
   12E9 F1            [10] 1601 	pop	af
   12EA F1            [10] 1602 	pop	af
   12EB 45            [ 4] 1603 	ld	b,l
   12EC 18 03         [12] 1604 	jr	00164$
   12EE                    1605 00163$:
                           1606 ;src/Renderer.c:613: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   12EE DD 46 E5      [19] 1607 	ld	b,-27 (ix)
   12F1                    1608 00164$:
                           1609 ;src/Renderer.c:616: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   12F1 C5            [11] 1610 	push	bc
   12F2 33            [ 6] 1611 	inc	sp
   12F3 DD 66 FE      [19] 1612 	ld	h,-2 (ix)
   12F6 DD 6E EF      [19] 1613 	ld	l,-17 (ix)
   12F9 E5            [11] 1614 	push	hl
   12FA DD 7E D9      [19] 1615 	ld	a,-39 (ix)
   12FD F5            [11] 1616 	push	af
   12FE 33            [ 6] 1617 	inc	sp
   12FF CD 75 0C      [17] 1618 	call	_draw_column_to_buffer
   1302 F1            [10] 1619 	pop	af
   1303 F1            [10] 1620 	pop	af
   1304                    1621 00166$:
                           1622 ;src/Renderer.c:619: if(!(currentCellID&CELL_WALL_MASK)){
   1304 DD 7E FA      [19] 1623 	ld	a,-6 (ix)
   1307 B7            [ 4] 1624 	or	a, a
   1308 20 1A         [12] 1625 	jr	NZ,00173$
                           1626 ;src/Renderer.c:620: if(currentCellID&CELL_ENEMY_MASK){
   130A DD 7E FF      [19] 1627 	ld	a,-1 (ix)
   130D E6 0F         [ 7] 1628 	and	a, #0x0F
   130F 28 13         [12] 1629 	jr	Z,00173$
                           1630 ;src/Renderer.c:621: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   1311 DD 66 E5      [19] 1631 	ld	h,-27 (ix)
   1314 DD 6E FF      [19] 1632 	ld	l,-1 (ix)
   1317 E5            [11] 1633 	push	hl
   1318 DD 66 CC      [19] 1634 	ld	h,-52 (ix)
   131B DD 6E D9      [19] 1635 	ld	l,-39 (ix)
   131E E5            [11] 1636 	push	hl
   131F CD 34 0B      [17] 1637 	call	_draw_column_to_buffer_enemy
   1322 F1            [10] 1638 	pop	af
   1323 F1            [10] 1639 	pop	af
                           1640 ;src/Renderer.c:623: else if(currentCellID&CELL_ITEM_MASK){
   1324                    1641 00173$:
                           1642 ;src/Renderer.c:628: ++xCellCount;
   1324 DD 34 FB      [23] 1643 	inc	-5 (ix)
                           1644 ;src/Renderer.c:539: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   1327 DD 35 CA      [23] 1645 	dec	-54 (ix)
                           1646 ;src/Renderer.c:414: currentCellID = cells_in_view_array[lineStart + 1];
   132A 2A B6 0A      [16] 1647 	ld	hl,(_cells_in_view_array)
   132D DD 75 DF      [19] 1648 	ld	-33 (ix),l
   1330 DD 74 E0      [19] 1649 	ld	-32 (ix),h
                           1650 ;src/Renderer.c:539: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   1333 DD 7E CA      [19] 1651 	ld	a,-54 (ix)
   1336 D6 50         [ 7] 1652 	sub	a, #0x50
   1338 D2 F1 10      [10] 1653 	jp	NC,00254$
                           1654 ;src/Renderer.c:659: lineStart = lineStart + (offsetDiff * 2) + 3;
   133B DD 7E E7      [19] 1655 	ld	a,-25 (ix)
   133E C6 03         [ 7] 1656 	add	a, #0x03
   1340 DD 77 C7      [19] 1657 	ld	-57 (ix),a
                           1658 ;src/Renderer.c:660: zHeight += zHeight;
   1343 DD CB CC 26   [23] 1659 	sla	-52 (ix)
                           1660 ;src/Renderer.c:661: offsetDiff = offsetDiff >> 1;
   1347 DD CB CE 3E   [23] 1661 	srl	-50 (ix)
                           1662 ;src/Renderer.c:663: }while(z);
   134B DD 7E C9      [19] 1663 	ld	a,-55 (ix)
   134E B7            [ 4] 1664 	or	a, a
   134F C2 14 0E      [10] 1665 	jp	NZ,00175$
   1352 C3 02 19      [10] 1666 	jp	00260$
                           1667 ;src/Renderer.c:668: do{
   1355                    1668 00358$:
   1355 DD 36 C9 06   [19] 1669 	ld	-55 (ix),#0x06
   1359                    1670 00246$:
                           1671 ;src/Renderer.c:670: --z;
   1359 DD 35 C9      [23] 1672 	dec	-55 (ix)
                           1673 ;src/Renderer.c:405: xCellCount = (z) ? (zHeight >> 1) : 0;
   135C DD 7E CC      [19] 1674 	ld	a,-52 (ix)
   135F CB 3F         [ 8] 1675 	srl	a
   1361 DD 77 F6      [19] 1676 	ld	-10 (ix),a
                           1677 ;src/Renderer.c:674: xCellCount = (z) ? (zHeight >> 1) : 0;
   1364 DD 7E C9      [19] 1678 	ld	a,-55 (ix)
   1367 B7            [ 4] 1679 	or	a, a
   1368 28 05         [12] 1680 	jr	Z,00267$
   136A DD 4E F6      [19] 1681 	ld	c,-10 (ix)
   136D 18 02         [12] 1682 	jr	00268$
   136F                    1683 00267$:
   136F 0E 00         [ 7] 1684 	ld	c,#0x00
   1371                    1685 00268$:
   1371 DD 71 D5      [19] 1686 	ld	-43 (ix),c
                           1687 ;src/Renderer.c:675: lateralWallSlope=0;
   1374 DD 36 D0 00   [19] 1688 	ld	-48 (ix),#0x00
                           1689 ;src/Renderer.c:676: lateralWallSlopeCounter=0;
   1378 DD 36 CF 00   [19] 1690 	ld	-49 (ix),#0x00
                           1691 ;src/Renderer.c:677: xHeight=0;
   137C DD 36 CD 00   [19] 1692 	ld	-51 (ix),#0x00
                           1693 ;src/Renderer.c:679: lateralWallCounter = 0;
   1380 DD 36 F2 00   [19] 1694 	ld	-14 (ix),#0x00
                           1695 ;src/Renderer.c:681: newCell=1;
   1384 DD 36 D3 01   [19] 1696 	ld	-45 (ix),#0x01
                           1697 ;src/Renderer.c:414: currentCellID = cells_in_view_array[lineStart + 1];
   1388 DD 7E C7      [19] 1698 	ld	a,-57 (ix)
   138B DD 77 E5      [19] 1699 	ld	-27 (ix),a
   138E DD 36 E6 00   [19] 1700 	ld	-26 (ix),#0x00
                           1701 ;src/Renderer.c:682: currentCellID = cells_in_view_array[lineStart + 1];
   1392 DD 4E E5      [19] 1702 	ld	c,-27 (ix)
   1395 DD 46 E6      [19] 1703 	ld	b,-26 (ix)
   1398 03            [ 6] 1704 	inc	bc
   1399 DD 6E DF      [19] 1705 	ld	l,-33 (ix)
   139C DD 66 E0      [19] 1706 	ld	h,-32 (ix)
   139F 09            [11] 1707 	add	hl,bc
   13A0 7E            [ 7] 1708 	ld	a,(hl)
   13A1 DD 77 D2      [19] 1709 	ld	-46 (ix),a
                           1710 ;src/Renderer.c:684: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   13A4 DD 7E DF      [19] 1711 	ld	a,-33 (ix)
   13A7 DD 86 C7      [19] 1712 	add	a, -57 (ix)
   13AA 6F            [ 4] 1713 	ld	l,a
   13AB DD 7E E0      [19] 1714 	ld	a,-32 (ix)
   13AE CE 00         [ 7] 1715 	adc	a, #0x00
   13B0 67            [ 4] 1716 	ld	h,a
   13B1 4E            [ 7] 1717 	ld	c,(hl)
                           1718 ;src/Renderer.c:685: if(lastCellWasWall&CELL_WALL_MASK){
   13B2 CB 79         [ 8] 1719 	bit	7, c
   13B4 28 09         [12] 1720 	jr	Z,00179$
                           1721 ;src/Renderer.c:686: lastWallId=lastCellWasWall;
   13B6 DD 71 D4      [19] 1722 	ld	-44 (ix),c
                           1723 ;src/Renderer.c:687: lastCellWasWall=1;
   13B9 DD 36 D9 01   [19] 1724 	ld	-39 (ix),#0x01
   13BD 18 08         [12] 1725 	jr	00336$
   13BF                    1726 00179$:
                           1727 ;src/Renderer.c:690: lastCellWasWall=0;
   13BF DD 36 D9 00   [19] 1728 	ld	-39 (ix),#0x00
                           1729 ;src/Renderer.c:691: lastWallId=CELLTYPE_FLOOR;
   13C3 DD 36 D4 00   [19] 1730 	ld	-44 (ix),#0x00
                           1731 ;src/Renderer.c:694: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   13C7                    1732 00336$:
   13C7 DD 36 D6 00   [19] 1733 	ld	-42 (ix),#0x00
   13CB DD 36 CA 00   [19] 1734 	ld	-54 (ix),#0x00
   13CF                    1735 00256$:
                           1736 ;src/Renderer.c:696: if (xCellCount == zHeight)
   13CF DD 7E D5      [19] 1737 	ld	a,-43 (ix)
   13D2 DD 96 CC      [19] 1738 	sub	a, -52 (ix)
   13D5 20 4B         [12] 1739 	jr	NZ,00182$
                           1740 ;src/Renderer.c:698: ++xCell;
   13D7 DD 34 D6      [23] 1741 	inc	-42 (ix)
                           1742 ;src/Renderer.c:699: xCellCount = 0;
   13DA DD 36 D5 00   [19] 1743 	ld	-43 (ix),#0x00
                           1744 ;src/Renderer.c:700: newCell=1;
   13DE DD 36 D3 01   [19] 1745 	ld	-45 (ix),#0x01
                           1746 ;src/Renderer.c:701: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   13E2 DD 7E D6      [19] 1747 	ld	a,-42 (ix)
   13E5 DD 77 F0      [19] 1748 	ld	-16 (ix),a
   13E8 DD 36 F1 00   [19] 1749 	ld	-15 (ix),#0x00
   13EC DD 7E E5      [19] 1750 	ld	a,-27 (ix)
   13EF DD 86 F0      [19] 1751 	add	a, -16 (ix)
   13F2 DD 77 F0      [19] 1752 	ld	-16 (ix),a
   13F5 DD 7E E6      [19] 1753 	ld	a,-26 (ix)
   13F8 DD 8E F1      [19] 1754 	adc	a, -15 (ix)
   13FB DD 77 F1      [19] 1755 	ld	-15 (ix),a
   13FE DD 34 F0      [23] 1756 	inc	-16 (ix)
   1401 20 03         [12] 1757 	jr	NZ,00629$
   1403 DD 34 F1      [23] 1758 	inc	-15 (ix)
   1406                    1759 00629$:
   1406 DD 7E F0      [19] 1760 	ld	a,-16 (ix)
   1409 DD 86 DF      [19] 1761 	add	a, -33 (ix)
   140C DD 77 F0      [19] 1762 	ld	-16 (ix),a
   140F DD 7E F1      [19] 1763 	ld	a,-15 (ix)
   1412 DD 8E E0      [19] 1764 	adc	a, -32 (ix)
   1415 DD 77 F1      [19] 1765 	ld	-15 (ix),a
   1418 DD 6E F0      [19] 1766 	ld	l,-16 (ix)
   141B DD 66 F1      [19] 1767 	ld	h,-15 (ix)
   141E 7E            [ 7] 1768 	ld	a,(hl)
   141F DD 77 D2      [19] 1769 	ld	-46 (ix),a
   1422                    1770 00182$:
                           1771 ;src/Renderer.c:703: if(!(x%2)){
   1422 DD 7E CA      [19] 1772 	ld	a,-54 (ix)
   1425 E6 01         [ 7] 1773 	and	a, #0x01
   1427 DD 77 F0      [19] 1774 	ld	-16 (ix),a
                           1775 ;src/Renderer.c:438: if (currentCellID & CELL_WALL_MASK)//Wall
   142A DD 7E D2      [19] 1776 	ld	a,-46 (ix)
   142D E6 80         [ 7] 1777 	and	a, #0x80
   142F DD 77 DD      [19] 1778 	ld	-35 (ix),a
                           1779 ;src/Renderer.c:458: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   1432 DD 7E D5      [19] 1780 	ld	a,-43 (ix)
   1435 DD 77 FB      [19] 1781 	ld	-5 (ix),a
   1438 DD 36 FC 00   [19] 1782 	ld	-4 (ix),#0x00
   143C DD 7E CC      [19] 1783 	ld	a,-52 (ix)
   143F DD 77 FE      [19] 1784 	ld	-2 (ix),a
                           1785 ;src/Renderer.c:703: if(!(x%2)){
   1442 DD 7E F0      [19] 1786 	ld	a,-16 (ix)
   1445 B7            [ 4] 1787 	or	a, a
   1446 C2 3E 15      [10] 1788 	jp	NZ,00195$
                           1789 ;src/Renderer.c:704: if ((lateralWallCounter == 0)||newCell)
   1449 DD 7E F2      [19] 1790 	ld	a,-14 (ix)
   144C B7            [ 4] 1791 	or	a, a
   144D 28 07         [12] 1792 	jr	Z,00191$
   144F DD 7E D3      [19] 1793 	ld	a,-45 (ix)
   1452 B7            [ 4] 1794 	or	a, a
   1453 CA 3E 15      [10] 1795 	jp	Z,00195$
   1456                    1796 00191$:
                           1797 ;src/Renderer.c:706: if (currentCellID & CELL_WALL_MASK)//Wall
   1456 DD 7E DD      [19] 1798 	ld	a,-35 (ix)
   1459 B7            [ 4] 1799 	or	a, a
   145A 28 2B         [12] 1800 	jr	Z,00189$
                           1801 ;src/Renderer.c:708: lateralWallCounter = 0;//(zHeight - xCellCount);
   145C DD 36 F2 00   [19] 1802 	ld	-14 (ix),#0x00
                           1803 ;src/Renderer.c:709: lateralWallSlope = 0;
   1460 DD 36 D0 00   [19] 1804 	ld	-48 (ix),#0x00
                           1805 ;src/Renderer.c:710: xHeight = zHeight;
   1464 DD 7E CC      [19] 1806 	ld	a,-52 (ix)
   1467 DD 77 CD      [19] 1807 	ld	-51 (ix),a
                           1808 ;src/Renderer.c:711: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   146A DD 7E D2      [19] 1809 	ld	a,-46 (ix)
   146D D6 80         [ 7] 1810 	sub	a, #0x80
   146F 20 04         [12] 1811 	jr	NZ,00269$
   1471 0E 09         [ 7] 1812 	ld	c,#0x09
   1473 18 02         [12] 1813 	jr	00270$
   1475                    1814 00269$:
   1475 0E 0B         [ 7] 1815 	ld	c,#0x0B
   1477                    1816 00270$:
   1477 DD 71 D1      [19] 1817 	ld	-47 (ix),c
                           1818 ;src/Renderer.c:712: lastCellWasWall = 1;
   147A DD 36 D9 01   [19] 1819 	ld	-39 (ix),#0x01
                           1820 ;src/Renderer.c:713: lastWallId=currentCellID;
   147E DD 7E D2      [19] 1821 	ld	a,-46 (ix)
   1481 DD 77 D4      [19] 1822 	ld	-44 (ix),a
   1484 C3 3A 15      [10] 1823 	jp	00190$
   1487                    1824 00189$:
                           1825 ;src/Renderer.c:716: if(lateralWallCounter==0){//Lateral wall not finished
   1487 DD 7E F2      [19] 1826 	ld	a,-14 (ix)
   148A B7            [ 4] 1827 	or	a, a
   148B C2 3A 15      [10] 1828 	jp	NZ,00190$
                           1829 ;src/Renderer.c:717: if (lastCellWasWall)
   148E DD 7E D9      [19] 1830 	ld	a,-39 (ix)
   1491 B7            [ 4] 1831 	or	a, a
   1492 CA 2A 15      [10] 1832 	jp	Z,00184$
                           1833 ;src/Renderer.c:720: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   1495 DD 7E CE      [19] 1834 	ld	a,-50 (ix)
   1498 DD 96 D6      [19] 1835 	sub	a, -42 (ix)
   149B 87            [ 4] 1836 	add	a, a
   149C 3C            [ 4] 1837 	inc	a
                           1838 ;src/Renderer.c:721: lateralWallSlopeCounter = lateralWallSlope / 2;
   149D DD 77 D0      [19] 1839 	ld	-48 (ix), a
   14A0 CB 3F         [ 8] 1840 	srl	a
   14A2 DD 77 CF      [19] 1841 	ld	-49 (ix),a
                           1842 ;src/Renderer.c:722: lateralWallCounter = lateralWallSlope * zHeight;
   14A5 DD 5E CC      [19] 1843 	ld	e,-52 (ix)
   14A8 DD 66 D0      [19] 1844 	ld	h,-48 (ix)
   14AB 2E 00         [ 7] 1845 	ld	l, #0x00
   14AD 55            [ 4] 1846 	ld	d, l
   14AE 06 08         [ 7] 1847 	ld	b, #0x08
   14B0                    1848 00632$:
   14B0 29            [11] 1849 	add	hl,hl
   14B1 30 01         [12] 1850 	jr	NC,00633$
   14B3 19            [11] 1851 	add	hl,de
   14B4                    1852 00633$:
   14B4 10 FA         [13] 1853 	djnz	00632$
   14B6 DD 75 FD      [19] 1854 	ld	-3 (ix), l
   14B9 7D            [ 4] 1855 	ld	a, l
                           1856 ;src/Renderer.c:723: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   14BA DD 77 CB      [19] 1857 	ld	-53 (ix), a
   14BD E6 FC         [ 7] 1858 	and	a, #0xFC
   14BF DD 77 FD      [19] 1859 	ld	-3 (ix), a
   14C2 CB C7         [ 8] 1860 	set	0, a
   14C4 DD 77 FD      [19] 1861 	ld	-3 (ix), a
   14C7 CB 3F         [ 8] 1862 	srl	a
   14C9 CB 3F         [ 8] 1863 	srl	a
   14CB DD 96 D5      [19] 1864 	sub	a, -43 (ix)
   14CE DD 77 F2      [19] 1865 	ld	-14 (ix),a
                           1866 ;src/Renderer.c:725: lastCellWasWall = 0;
   14D1 DD 36 D9 00   [19] 1867 	ld	-39 (ix),#0x00
                           1868 ;src/Renderer.c:726: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   14D5 DD 7E FB      [19] 1869 	ld	a,-5 (ix)
   14D8 DD 77 F4      [19] 1870 	ld	-12 (ix),a
   14DB DD 7E FC      [19] 1871 	ld	a,-4 (ix)
   14DE DD 77 F5      [19] 1872 	ld	-11 (ix),a
   14E1 DD CB F4 26   [23] 1873 	sla	-12 (ix)
   14E5 DD CB F5 16   [23] 1874 	rl	-11 (ix)
   14E9 DD 7E D0      [19] 1875 	ld	a,-48 (ix)
   14EC DD 77 E3      [19] 1876 	ld	-29 (ix),a
   14EF DD 36 E4 00   [19] 1877 	ld	-28 (ix),#0x00
   14F3 DD 6E E3      [19] 1878 	ld	l,-29 (ix)
   14F6 DD 66 E4      [19] 1879 	ld	h,-28 (ix)
   14F9 E5            [11] 1880 	push	hl
   14FA DD 6E F4      [19] 1881 	ld	l,-12 (ix)
   14FD DD 66 F5      [19] 1882 	ld	h,-11 (ix)
   1500 E5            [11] 1883 	push	hl
   1501 CD 79 4E      [17] 1884 	call	__divsint
   1504 F1            [10] 1885 	pop	af
   1505 F1            [10] 1886 	pop	af
   1506 DD 74 F5      [19] 1887 	ld	-11 (ix),h
   1509 DD 75 F4      [19] 1888 	ld	-12 (ix), l
   150C DD 75 FD      [19] 1889 	ld	-3 (ix), l
   150F DD 7E FE      [19] 1890 	ld	a,-2 (ix)
   1512 DD 96 FD      [19] 1891 	sub	a, -3 (ix)
   1515 DD 77 CD      [19] 1892 	ld	-51 (ix),a
                           1893 ;src/Renderer.c:727: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   1518 DD 7E D4      [19] 1894 	ld	a,-44 (ix)
   151B D6 80         [ 7] 1895 	sub	a, #0x80
   151D 20 04         [12] 1896 	jr	NZ,00271$
   151F 0E 0A         [ 7] 1897 	ld	c,#0x0A
   1521 18 02         [12] 1898 	jr	00272$
   1523                    1899 00271$:
   1523 0E 0C         [ 7] 1900 	ld	c,#0x0C
   1525                    1901 00272$:
   1525 DD 71 D1      [19] 1902 	ld	-47 (ix),c
   1528 18 10         [12] 1903 	jr	00190$
   152A                    1904 00184$:
                           1905 ;src/Renderer.c:731: xHeight = 0;
   152A DD 36 CD 00   [19] 1906 	ld	-51 (ix),#0x00
                           1907 ;src/Renderer.c:732: lastCellWasWall = 0;
   152E DD 36 D9 00   [19] 1908 	ld	-39 (ix),#0x00
                           1909 ;src/Renderer.c:733: lateralWallSlope=0;
   1532 DD 36 D0 00   [19] 1910 	ld	-48 (ix),#0x00
                           1911 ;src/Renderer.c:734: lastWallId=0;
   1536 DD 36 D4 00   [19] 1912 	ld	-44 (ix),#0x00
   153A                    1913 00190$:
                           1914 ;src/Renderer.c:738: newCell=0;
   153A DD 36 D3 00   [19] 1915 	ld	-45 (ix),#0x00
   153E                    1916 00195$:
                           1917 ;src/Renderer.c:741: if (lateralWallCounter > 0)
   153E DD 7E F2      [19] 1918 	ld	a,-14 (ix)
   1541 B7            [ 4] 1919 	or	a, a
   1542 28 1E         [12] 1920 	jr	Z,00201$
                           1921 ;src/Renderer.c:744: if (lateralWallSlope != 0)
   1544 DD 7E D0      [19] 1922 	ld	a,-48 (ix)
   1547 B7            [ 4] 1923 	or	a, a
   1548 28 15         [12] 1924 	jr	Z,00199$
                           1925 ;src/Renderer.c:746: if (lateralWallSlopeCounter == lateralWallSlope)
   154A DD 7E D0      [19] 1926 	ld	a,-48 (ix)
   154D DD 96 CF      [19] 1927 	sub	a, -49 (ix)
   1550 20 0A         [12] 1928 	jr	NZ,00197$
                           1929 ;src/Renderer.c:748: lateralWallSlopeCounter = 0;
   1552 DD 36 CF 00   [19] 1930 	ld	-49 (ix),#0x00
                           1931 ;src/Renderer.c:749: xHeight -= 2;
   1556 DD 35 CD      [23] 1932 	dec	-51 (ix)
   1559 DD 35 CD      [23] 1933 	dec	-51 (ix)
   155C                    1934 00197$:
                           1935 ;src/Renderer.c:751: ++lateralWallSlopeCounter;
   155C DD 34 CF      [23] 1936 	inc	-49 (ix)
   155F                    1937 00199$:
                           1938 ;src/Renderer.c:754: --lateralWallCounter;
   155F DD 35 F2      [23] 1939 	dec	-14 (ix)
   1562                    1940 00201$:
                           1941 ;src/Renderer.c:497: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   1562 DD 7E CC      [19] 1942 	ld	a,-52 (ix)
   1565 DD 77 F4      [19] 1943 	ld	-12 (ix),a
   1568 DD 36 F5 00   [19] 1944 	ld	-11 (ix),#0x00
                           1945 ;src/Renderer.c:757: if (!(x%2))
   156C DD 7E F0      [19] 1946 	ld	a,-16 (ix)
   156F B7            [ 4] 1947 	or	a, a
   1570 20 74         [12] 1948 	jr	NZ,00210$
                           1949 ;src/Renderer.c:760: draw_column_to_buffer_untextured(x/2, xHeight, color);
   1572 DD 7E CA      [19] 1950 	ld	a,-54 (ix)
   1575 CB 3F         [ 8] 1951 	srl	a
   1577 DD 77 F0      [19] 1952 	ld	-16 (ix),a
                           1953 ;src/Renderer.c:759: if(xHeight > 0){
   157A DD 7E CD      [19] 1954 	ld	a,-51 (ix)
   157D B7            [ 4] 1955 	or	a, a
   157E 28 11         [12] 1956 	jr	Z,00203$
                           1957 ;src/Renderer.c:760: draw_column_to_buffer_untextured(x/2, xHeight, color);
   1580 DD 66 D1      [19] 1958 	ld	h,-47 (ix)
   1583 DD 6E CD      [19] 1959 	ld	l,-51 (ix)
   1586 E5            [11] 1960 	push	hl
   1587 DD 7E F0      [19] 1961 	ld	a,-16 (ix)
   158A F5            [11] 1962 	push	af
   158B 33            [ 6] 1963 	inc	sp
   158C CD BD 0A      [17] 1964 	call	_draw_column_to_buffer_untextured
   158F F1            [10] 1965 	pop	af
   1590 33            [ 6] 1966 	inc	sp
   1591                    1967 00203$:
                           1968 ;src/Renderer.c:763: if(!(currentCellID&CELL_WALL_MASK)){
   1591 DD 7E DD      [19] 1969 	ld	a,-35 (ix)
   1594 B7            [ 4] 1970 	or	a, a
   1595 20 4F         [12] 1971 	jr	NZ,00210$
                           1972 ;src/Renderer.c:764: if(currentCellID&CELL_ENEMY_MASK){
   1597 DD 7E D2      [19] 1973 	ld	a,-46 (ix)
   159A E6 0F         [ 7] 1974 	and	a, #0x0F
   159C 28 48         [12] 1975 	jr	Z,00210$
                           1976 ;src/Renderer.c:765: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   159E DD 7E FB      [19] 1977 	ld	a,-5 (ix)
   15A1 DD 77 DD      [19] 1978 	ld	-35 (ix),a
   15A4 DD 7E FC      [19] 1979 	ld	a,-4 (ix)
   15A7 DD 77 DE      [19] 1980 	ld	-34 (ix),a
   15AA 3E 06         [ 7] 1981 	ld	a,#0x05+1
   15AC 18 08         [12] 1982 	jr	00642$
   15AE                    1983 00641$:
   15AE DD CB DD 26   [23] 1984 	sla	-35 (ix)
   15B2 DD CB DE 16   [23] 1985 	rl	-34 (ix)
   15B6                    1986 00642$:
   15B6 3D            [ 4] 1987 	dec	a
   15B7 20 F5         [12] 1988 	jr	NZ,00641$
   15B9 DD 6E F4      [19] 1989 	ld	l,-12 (ix)
   15BC DD 66 F5      [19] 1990 	ld	h,-11 (ix)
   15BF E5            [11] 1991 	push	hl
   15C0 DD 6E DD      [19] 1992 	ld	l,-35 (ix)
   15C3 DD 66 DE      [19] 1993 	ld	h,-34 (ix)
   15C6 E5            [11] 1994 	push	hl
   15C7 CD 79 4E      [17] 1995 	call	__divsint
   15CA F1            [10] 1996 	pop	af
   15CB F1            [10] 1997 	pop	af
   15CC DD 74 DE      [19] 1998 	ld	-34 (ix),h
   15CF DD 75 DD      [19] 1999 	ld	-35 (ix), l
   15D2 45            [ 4] 2000 	ld	b, l
   15D3 C5            [11] 2001 	push	bc
   15D4 33            [ 6] 2002 	inc	sp
   15D5 DD 66 D2      [19] 2003 	ld	h,-46 (ix)
   15D8 DD 6E CC      [19] 2004 	ld	l,-52 (ix)
   15DB E5            [11] 2005 	push	hl
   15DC DD 7E F0      [19] 2006 	ld	a,-16 (ix)
   15DF F5            [11] 2007 	push	af
   15E0 33            [ 6] 2008 	inc	sp
   15E1 CD 34 0B      [17] 2009 	call	_draw_column_to_buffer_enemy
   15E4 F1            [10] 2010 	pop	af
   15E5 F1            [10] 2011 	pop	af
                           2012 ;src/Renderer.c:767: else if(currentCellID&CELL_ITEM_MASK){
   15E6                    2013 00210$:
                           2014 ;src/Renderer.c:773: ++xCellCount;
   15E6 DD 34 D5      [23] 2015 	inc	-43 (ix)
                           2016 ;src/Renderer.c:694: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   15E9 DD 34 CA      [23] 2017 	inc	-54 (ix)
                           2018 ;src/Renderer.c:414: currentCellID = cells_in_view_array[lineStart + 1];
   15EC 2A B6 0A      [16] 2019 	ld	hl,(_cells_in_view_array)
   15EF DD 75 DF      [19] 2020 	ld	-33 (ix),l
   15F2 DD 74 E0      [19] 2021 	ld	-32 (ix),h
                           2022 ;src/Renderer.c:694: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   15F5 DD 7E CA      [19] 2023 	ld	a,-54 (ix)
   15F8 D6 50         [ 7] 2024 	sub	a, #0x50
   15FA DA CF 13      [10] 2025 	jp	C,00256$
                           2026 ;src/Renderer.c:780: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   15FD DD 7E C9      [19] 2027 	ld	a,-55 (ix)
   1600 B7            [ 4] 2028 	or	a, a
   1601 28 08         [12] 2029 	jr	Z,00273$
   1603 DD 7E F6      [19] 2030 	ld	a,-10 (ix)
   1606 DD 77 F6      [19] 2031 	ld	-10 (ix),a
   1609 18 04         [12] 2032 	jr	00274$
   160B                    2033 00273$:
   160B DD 36 F6 00   [19] 2034 	ld	-10 (ix),#0x00
   160F                    2035 00274$:
   160F DD 7E F6      [19] 2036 	ld	a,-10 (ix)
   1612 DD 77 F6      [19] 2037 	ld	-10 (ix),a
                           2038 ;src/Renderer.c:781: lateralWallSlope=0;
   1615 DD 36 F2 00   [19] 2039 	ld	-14 (ix),#0x00
                           2040 ;src/Renderer.c:782: lateralWallSlopeCounter=0;
   1619 DD 36 E5 00   [19] 2041 	ld	-27 (ix),#0x00
                           2042 ;src/Renderer.c:783: xHeight=0;
   161D DD 36 D9 00   [19] 2043 	ld	-39 (ix),#0x00
                           2044 ;src/Renderer.c:785: lateralWallCounter = 0;
   1621 DD 36 F0 00   [19] 2045 	ld	-16 (ix),#0x00
                           2046 ;src/Renderer.c:524: lineEnd = lineStart + offsetDiff * 2 + 2;
   1625 DD 7E CE      [19] 2047 	ld	a,-50 (ix)
   1628 87            [ 4] 2048 	add	a, a
   1629 DD 77 DD      [19] 2049 	ld	-35 (ix),a
   162C DD 7E C7      [19] 2050 	ld	a,-57 (ix)
   162F DD 86 DD      [19] 2051 	add	a, -35 (ix)
                           2052 ;src/Renderer.c:786: lineEnd = lineStart + offsetDiff * 2 + 2;
   1632 DD 77 DD      [19] 2053 	ld	-35 (ix), a
   1635 C6 02         [ 7] 2054 	add	a, #0x02
   1637 DD 77 C8      [19] 2055 	ld	-56 (ix),a
                           2056 ;src/Renderer.c:788: newCell=1;
   163A DD 36 FD 01   [19] 2057 	ld	-3 (ix),#0x01
                           2058 ;src/Renderer.c:527: currentCellID = cells_in_view_array[lineEnd - 1];
   163E DD 7E C8      [19] 2059 	ld	a,-56 (ix)
   1641 DD 77 FB      [19] 2060 	ld	-5 (ix),a
   1644 DD 36 FC 00   [19] 2061 	ld	-4 (ix),#0x00
                           2062 ;src/Renderer.c:789: currentCellID = cells_in_view_array[lineEnd - 1];
   1648 DD 7E FB      [19] 2063 	ld	a,-5 (ix)
   164B C6 FF         [ 7] 2064 	add	a,#0xFF
   164D DD 77 E3      [19] 2065 	ld	-29 (ix),a
   1650 DD 7E FC      [19] 2066 	ld	a,-4 (ix)
   1653 CE FF         [ 7] 2067 	adc	a,#0xFF
   1655 DD 77 E4      [19] 2068 	ld	-28 (ix),a
   1658 DD 7E DF      [19] 2069 	ld	a,-33 (ix)
   165B DD 86 E3      [19] 2070 	add	a, -29 (ix)
   165E DD 77 E3      [19] 2071 	ld	-29 (ix),a
   1661 DD 7E E0      [19] 2072 	ld	a,-32 (ix)
   1664 DD 8E E4      [19] 2073 	adc	a, -28 (ix)
   1667 DD 77 E4      [19] 2074 	ld	-28 (ix),a
   166A DD 6E E3      [19] 2075 	ld	l,-29 (ix)
   166D DD 66 E4      [19] 2076 	ld	h,-28 (ix)
   1670 7E            [ 7] 2077 	ld	a,(hl)
   1671 DD 77 F9      [19] 2078 	ld	-7 (ix),a
                           2079 ;src/Renderer.c:791: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   1674 DD 7E DF      [19] 2080 	ld	a,-33 (ix)
   1677 DD 86 C8      [19] 2081 	add	a, -56 (ix)
   167A DD 77 E3      [19] 2082 	ld	-29 (ix),a
   167D DD 7E E0      [19] 2083 	ld	a,-32 (ix)
   1680 CE 00         [ 7] 2084 	adc	a, #0x00
   1682 DD 77 E4      [19] 2085 	ld	-28 (ix),a
   1685 DD 6E E3      [19] 2086 	ld	l,-29 (ix)
   1688 DD 66 E4      [19] 2087 	ld	h,-28 (ix)
   168B 7E            [ 7] 2088 	ld	a,(hl)
   168C DD 77 EF      [19] 2089 	ld	-17 (ix),a
                           2090 ;src/Renderer.c:792: if(lastCellWasWall&CELL_WALL_MASK){
   168F DD CB EF 7E   [20] 2091 	bit	7, -17 (ix)
   1693 28 06         [12] 2092 	jr	Z,00213$
                           2093 ;src/Renderer.c:793: lastWallId=lastCellWasWall;
                           2094 ;src/Renderer.c:794: lastCellWasWall=1;
   1695 DD 36 E9 01   [19] 2095 	ld	-23 (ix),#0x01
   1699 18 08         [12] 2096 	jr	00356$
   169B                    2097 00213$:
                           2098 ;src/Renderer.c:797: lastCellWasWall=0;
   169B DD 36 E9 00   [19] 2099 	ld	-23 (ix),#0x00
                           2100 ;src/Renderer.c:798: lastWallId=CELLTYPE_FLOOR;
   169F DD 36 EF 00   [19] 2101 	ld	-17 (ix),#0x00
                           2102 ;src/Renderer.c:801: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   16A3                    2103 00356$:
   16A3 DD 36 D6 00   [19] 2104 	ld	-42 (ix),#0x00
   16A7 DD 36 CA 9F   [19] 2105 	ld	-54 (ix),#0x9F
   16AB                    2106 00258$:
                           2107 ;src/Renderer.c:804: if (xCellCount == zHeight)
   16AB DD 7E CC      [19] 2108 	ld	a,-52 (ix)
   16AE DD 96 F6      [19] 2109 	sub	a, -10 (ix)
   16B1 20 50         [12] 2110 	jr	NZ,00216$
                           2111 ;src/Renderer.c:806: ++xCell;
   16B3 DD 34 D6      [23] 2112 	inc	-42 (ix)
                           2113 ;src/Renderer.c:807: xCellCount = 0;
   16B6 DD 36 F6 00   [19] 2114 	ld	-10 (ix),#0x00
                           2115 ;src/Renderer.c:808: newCell=1;
   16BA DD 36 FD 01   [19] 2116 	ld	-3 (ix),#0x01
                           2117 ;src/Renderer.c:809: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   16BE DD 7E D6      [19] 2118 	ld	a,-42 (ix)
   16C1 DD 77 E3      [19] 2119 	ld	-29 (ix),a
   16C4 DD 36 E4 00   [19] 2120 	ld	-28 (ix),#0x00
   16C8 DD 7E FB      [19] 2121 	ld	a,-5 (ix)
   16CB DD 96 E3      [19] 2122 	sub	a, -29 (ix)
   16CE DD 77 E3      [19] 2123 	ld	-29 (ix),a
   16D1 DD 7E FC      [19] 2124 	ld	a,-4 (ix)
   16D4 DD 9E E4      [19] 2125 	sbc	a, -28 (ix)
   16D7 DD 77 E4      [19] 2126 	ld	-28 (ix),a
   16DA DD 6E E3      [19] 2127 	ld	l,-29 (ix)
   16DD DD 66 E4      [19] 2128 	ld	h,-28 (ix)
   16E0 2B            [ 6] 2129 	dec	hl
   16E1 DD 75 E3      [19] 2130 	ld	-29 (ix),l
   16E4 DD 74 E4      [19] 2131 	ld	-28 (ix),h
   16E7 DD 7E DF      [19] 2132 	ld	a,-33 (ix)
   16EA DD 86 E3      [19] 2133 	add	a, -29 (ix)
   16ED DD 77 E3      [19] 2134 	ld	-29 (ix),a
   16F0 DD 7E E0      [19] 2135 	ld	a,-32 (ix)
   16F3 DD 8E E4      [19] 2136 	adc	a, -28 (ix)
   16F6 DD 77 E4      [19] 2137 	ld	-28 (ix),a
   16F9 DD 6E E3      [19] 2138 	ld	l,-29 (ix)
   16FC DD 66 E4      [19] 2139 	ld	h,-28 (ix)
   16FF 7E            [ 7] 2140 	ld	a,(hl)
   1700 DD 77 F9      [19] 2141 	ld	-7 (ix),a
   1703                    2142 00216$:
                           2143 ;src/Renderer.c:811: if(!(x%2)){
   1703 DD 7E CA      [19] 2144 	ld	a,-54 (ix)
   1706 E6 01         [ 7] 2145 	and	a, #0x01
   1708 DD 77 E7      [19] 2146 	ld	-25 (ix),a
                           2147 ;src/Renderer.c:438: if (currentCellID & CELL_WALL_MASK)//Wall
   170B DD 7E F9      [19] 2148 	ld	a,-7 (ix)
   170E E6 80         [ 7] 2149 	and	a, #0x80
   1710 DD 77 E3      [19] 2150 	ld	-29 (ix),a
                           2151 ;src/Renderer.c:458: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   1713 DD 7E F6      [19] 2152 	ld	a,-10 (ix)
   1716 DD 77 EC      [19] 2153 	ld	-20 (ix),a
   1719 DD 36 ED 00   [19] 2154 	ld	-19 (ix),#0x00
                           2155 ;src/Renderer.c:811: if(!(x%2)){
   171D DD 7E E7      [19] 2156 	ld	a,-25 (ix)
   1720 B7            [ 4] 2157 	or	a, a
   1721 C2 4F 18      [10] 2158 	jp	NZ,00229$
                           2159 ;src/Renderer.c:812: if (lateralWallCounter == 0 || newCell)
   1724 DD 7E F0      [19] 2160 	ld	a,-16 (ix)
   1727 B7            [ 4] 2161 	or	a, a
   1728 28 07         [12] 2162 	jr	Z,00225$
   172A DD 7E FD      [19] 2163 	ld	a,-3 (ix)
   172D B7            [ 4] 2164 	or	a, a
   172E CA 4F 18      [10] 2165 	jp	Z,00229$
   1731                    2166 00225$:
                           2167 ;src/Renderer.c:814: if ( currentCellID & CELL_WALL_MASK)//Wall
   1731 DD 7E E3      [19] 2168 	ld	a,-29 (ix)
   1734 B7            [ 4] 2169 	or	a, a
   1735 28 32         [12] 2170 	jr	Z,00223$
                           2171 ;src/Renderer.c:816: lateralWallCounter = 0;
   1737 DD 36 F0 00   [19] 2172 	ld	-16 (ix),#0x00
                           2173 ;src/Renderer.c:817: lateralWallSlope = 0;
   173B DD 36 F2 00   [19] 2174 	ld	-14 (ix),#0x00
                           2175 ;src/Renderer.c:818: xHeight = zHeight;
   173F DD 7E CC      [19] 2176 	ld	a,-52 (ix)
   1742 DD 77 D9      [19] 2177 	ld	-39 (ix),a
                           2178 ;src/Renderer.c:819: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   1745 DD 7E F9      [19] 2179 	ld	a,-7 (ix)
   1748 D6 80         [ 7] 2180 	sub	a, #0x80
   174A 20 06         [12] 2181 	jr	NZ,00275$
   174C DD 36 FF 09   [19] 2182 	ld	-1 (ix),#0x09
   1750 18 04         [12] 2183 	jr	00276$
   1752                    2184 00275$:
   1752 DD 36 FF 0B   [19] 2185 	ld	-1 (ix),#0x0B
   1756                    2186 00276$:
   1756 DD 7E FF      [19] 2187 	ld	a,-1 (ix)
   1759 DD 77 D1      [19] 2188 	ld	-47 (ix),a
                           2189 ;src/Renderer.c:820: lastCellWasWall = 1;
   175C DD 36 E9 01   [19] 2190 	ld	-23 (ix),#0x01
                           2191 ;src/Renderer.c:821: lastWallId=currentCellID;
   1760 DD 7E F9      [19] 2192 	ld	a,-7 (ix)
   1763 DD 77 EF      [19] 2193 	ld	-17 (ix),a
   1766 C3 4B 18      [10] 2194 	jp	00224$
   1769                    2195 00223$:
                           2196 ;src/Renderer.c:823: else if(lateralWallCounter==0){
   1769 DD 7E F0      [19] 2197 	ld	a,-16 (ix)
   176C B7            [ 4] 2198 	or	a, a
   176D C2 4B 18      [10] 2199 	jp	NZ,00224$
                           2200 ;src/Renderer.c:824: if (lastCellWasWall)
   1770 DD 7E E9      [19] 2201 	ld	a,-23 (ix)
   1773 B7            [ 4] 2202 	or	a, a
   1774 CA 3B 18      [10] 2203 	jp	Z,00218$
                           2204 ;src/Renderer.c:827: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   1777 DD 7E CE      [19] 2205 	ld	a,-50 (ix)
   177A DD 96 D6      [19] 2206 	sub	a, -42 (ix)
   177D 87            [ 4] 2207 	add	a, a
   177E 3C            [ 4] 2208 	inc	a
                           2209 ;src/Renderer.c:828: lateralWallSlopeCounter = lateralWallSlope / 2;
   177F DD 77 F2      [19] 2210 	ld	-14 (ix), a
   1782 CB 3F         [ 8] 2211 	srl	a
   1784 DD 77 E5      [19] 2212 	ld	-27 (ix),a
                           2213 ;src/Renderer.c:829: lateralWallCounter = lateralWallSlope * zHeight;
   1787 DD 5E CC      [19] 2214 	ld	e,-52 (ix)
   178A DD 66 F2      [19] 2215 	ld	h,-14 (ix)
   178D 2E 00         [ 7] 2216 	ld	l, #0x00
   178F 55            [ 4] 2217 	ld	d, l
   1790 06 08         [ 7] 2218 	ld	b, #0x08
   1792                    2219 00648$:
   1792 29            [11] 2220 	add	hl,hl
   1793 30 01         [12] 2221 	jr	NC,00649$
   1795 19            [11] 2222 	add	hl,de
   1796                    2223 00649$:
   1796 10 FA         [13] 2224 	djnz	00648$
                           2225 ;src/Renderer.c:830: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   1798 DD 75 FF      [19] 2226 	ld	-1 (ix), l
   179B DD 75 D7      [19] 2227 	ld	-41 (ix), l
   179E DD 36 D8 00   [19] 2228 	ld	-40 (ix),#0x00
   17A2 DD 7E FF      [19] 2229 	ld	a,-1 (ix)
   17A5 E6 03         [ 7] 2230 	and	a, #0x03
   17A7 DD 77 FF      [19] 2231 	ld	-1 (ix), a
   17AA DD 77 DB      [19] 2232 	ld	-37 (ix),a
   17AD DD 36 DC 00   [19] 2233 	ld	-36 (ix),#0x00
   17B1 DD 7E D7      [19] 2234 	ld	a,-41 (ix)
   17B4 DD 96 DB      [19] 2235 	sub	a, -37 (ix)
   17B7 DD 77 DB      [19] 2236 	ld	-37 (ix),a
   17BA DD 7E D8      [19] 2237 	ld	a,-40 (ix)
   17BD DD 9E DC      [19] 2238 	sbc	a, -36 (ix)
   17C0 DD 77 DC      [19] 2239 	ld	-36 (ix),a
   17C3 DD 7E DB      [19] 2240 	ld	a,-37 (ix)
   17C6 C6 01         [ 7] 2241 	add	a, #0x01
   17C8 DD 77 D7      [19] 2242 	ld	-41 (ix),a
   17CB DD 7E DC      [19] 2243 	ld	a,-36 (ix)
   17CE CE 00         [ 7] 2244 	adc	a, #0x00
   17D0 DD 77 D8      [19] 2245 	ld	-40 (ix),a
   17D3 DD 7E D7      [19] 2246 	ld	a,-41 (ix)
   17D6 DD 77 E1      [19] 2247 	ld	-31 (ix),a
   17D9 DD 7E D8      [19] 2248 	ld	a,-40 (ix)
   17DC DD 77 E2      [19] 2249 	ld	-30 (ix),a
   17DF DD CB D8 7E   [20] 2250 	bit	7, -40 (ix)
   17E3 28 10         [12] 2251 	jr	Z,00277$
   17E5 DD 7E DB      [19] 2252 	ld	a,-37 (ix)
   17E8 C6 04         [ 7] 2253 	add	a, #0x04
   17EA DD 77 E1      [19] 2254 	ld	-31 (ix),a
   17ED DD 7E DC      [19] 2255 	ld	a,-36 (ix)
   17F0 CE 00         [ 7] 2256 	adc	a, #0x00
   17F2 DD 77 E2      [19] 2257 	ld	-30 (ix),a
   17F5                    2258 00277$:
   17F5 DD 4E E1      [19] 2259 	ld	c,-31 (ix)
   17F8 DD 46 E2      [19] 2260 	ld	b,-30 (ix)
   17FB CB 28         [ 8] 2261 	sra	b
   17FD CB 19         [ 8] 2262 	rr	c
   17FF CB 28         [ 8] 2263 	sra	b
   1801 CB 19         [ 8] 2264 	rr	c
   1803 DD 46 F6      [19] 2265 	ld	b,-10 (ix)
   1806 79            [ 4] 2266 	ld	a,c
   1807 90            [ 4] 2267 	sub	a, b
   1808 DD 77 F0      [19] 2268 	ld	-16 (ix),a
                           2269 ;src/Renderer.c:832: lastCellWasWall = 0;
   180B DD 36 E9 00   [19] 2270 	ld	-23 (ix),#0x00
                           2271 ;src/Renderer.c:833: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   180F DD 6E EC      [19] 2272 	ld	l,-20 (ix)
   1812 DD 66 ED      [19] 2273 	ld	h,-19 (ix)
   1815 29            [11] 2274 	add	hl, hl
   1816 DD 4E F2      [19] 2275 	ld	c,-14 (ix)
   1819 06 00         [ 7] 2276 	ld	b,#0x00
   181B C5            [11] 2277 	push	bc
   181C E5            [11] 2278 	push	hl
   181D CD 79 4E      [17] 2279 	call	__divsint
   1820 F1            [10] 2280 	pop	af
   1821 F1            [10] 2281 	pop	af
   1822 DD 7E FE      [19] 2282 	ld	a,-2 (ix)
   1825 95            [ 4] 2283 	sub	a, l
   1826 DD 77 D9      [19] 2284 	ld	-39 (ix),a
                           2285 ;src/Renderer.c:834: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   1829 DD 7E EF      [19] 2286 	ld	a,-17 (ix)
   182C D6 80         [ 7] 2287 	sub	a, #0x80
   182E 20 04         [12] 2288 	jr	NZ,00278$
   1830 0E 0A         [ 7] 2289 	ld	c,#0x0A
   1832 18 02         [12] 2290 	jr	00279$
   1834                    2291 00278$:
   1834 0E 0C         [ 7] 2292 	ld	c,#0x0C
   1836                    2293 00279$:
   1836 DD 71 D1      [19] 2294 	ld	-47 (ix),c
   1839 18 10         [12] 2295 	jr	00224$
   183B                    2296 00218$:
                           2297 ;src/Renderer.c:838: xHeight = 0;
   183B DD 36 D9 00   [19] 2298 	ld	-39 (ix),#0x00
                           2299 ;src/Renderer.c:839: lastCellWasWall = 0;
   183F DD 36 E9 00   [19] 2300 	ld	-23 (ix),#0x00
                           2301 ;src/Renderer.c:840: lateralWallSlope=0;
   1843 DD 36 F2 00   [19] 2302 	ld	-14 (ix),#0x00
                           2303 ;src/Renderer.c:841: lastWallId=0;
   1847 DD 36 EF 00   [19] 2304 	ld	-17 (ix),#0x00
   184B                    2305 00224$:
                           2306 ;src/Renderer.c:844: newCell=0;
   184B DD 36 FD 00   [19] 2307 	ld	-3 (ix),#0x00
   184F                    2308 00229$:
                           2309 ;src/Renderer.c:849: if (lateralWallCounter > 0)
   184F DD 7E F0      [19] 2310 	ld	a,-16 (ix)
   1852 B7            [ 4] 2311 	or	a, a
   1853 28 1E         [12] 2312 	jr	Z,00235$
                           2313 ;src/Renderer.c:852: if (lateralWallSlope != 0)
   1855 DD 7E F2      [19] 2314 	ld	a,-14 (ix)
   1858 B7            [ 4] 2315 	or	a, a
   1859 28 15         [12] 2316 	jr	Z,00233$
                           2317 ;src/Renderer.c:854: if (lateralWallSlopeCounter == lateralWallSlope)
   185B DD 7E F2      [19] 2318 	ld	a,-14 (ix)
   185E DD 96 E5      [19] 2319 	sub	a, -27 (ix)
   1861 20 0A         [12] 2320 	jr	NZ,00231$
                           2321 ;src/Renderer.c:856: lateralWallSlopeCounter = 0;
   1863 DD 36 E5 00   [19] 2322 	ld	-27 (ix),#0x00
                           2323 ;src/Renderer.c:857: xHeight -= 2;
   1867 DD 35 D9      [23] 2324 	dec	-39 (ix)
   186A DD 35 D9      [23] 2325 	dec	-39 (ix)
   186D                    2326 00231$:
                           2327 ;src/Renderer.c:859: ++lateralWallSlopeCounter;
   186D DD 34 E5      [23] 2328 	inc	-27 (ix)
   1870                    2329 00233$:
                           2330 ;src/Renderer.c:861: --lateralWallCounter;
   1870 DD 35 F0      [23] 2331 	dec	-16 (ix)
   1873                    2332 00235$:
                           2333 ;src/Renderer.c:865: if (!(x%2))
   1873 DD 7E E7      [19] 2334 	ld	a,-25 (ix)
   1876 B7            [ 4] 2335 	or	a, a
   1877 20 5B         [12] 2336 	jr	NZ,00244$
                           2337 ;src/Renderer.c:870: draw_column_to_buffer_untextured(x/2, xHeight, color);
   1879 DD 46 CA      [19] 2338 	ld	b,-54 (ix)
   187C CB 38         [ 8] 2339 	srl	b
                           2340 ;src/Renderer.c:868: if(xHeight > 0){
   187E DD 7E D9      [19] 2341 	ld	a,-39 (ix)
   1881 B7            [ 4] 2342 	or	a, a
   1882 28 10         [12] 2343 	jr	Z,00237$
                           2344 ;src/Renderer.c:870: draw_column_to_buffer_untextured(x/2, xHeight, color);
   1884 C5            [11] 2345 	push	bc
   1885 DD 66 D1      [19] 2346 	ld	h,-47 (ix)
   1888 DD 6E D9      [19] 2347 	ld	l,-39 (ix)
   188B E5            [11] 2348 	push	hl
   188C C5            [11] 2349 	push	bc
   188D 33            [ 6] 2350 	inc	sp
   188E CD BD 0A      [17] 2351 	call	_draw_column_to_buffer_untextured
   1891 F1            [10] 2352 	pop	af
   1892 33            [ 6] 2353 	inc	sp
   1893 C1            [10] 2354 	pop	bc
   1894                    2355 00237$:
                           2356 ;src/Renderer.c:873: if(!(currentCellID&CELL_WALL_MASK)){
   1894 DD 7E E3      [19] 2357 	ld	a,-29 (ix)
   1897 B7            [ 4] 2358 	or	a, a
   1898 20 3A         [12] 2359 	jr	NZ,00244$
                           2360 ;src/Renderer.c:874: if(currentCellID&CELL_ENEMY_MASK){
   189A DD 7E F9      [19] 2361 	ld	a,-7 (ix)
   189D E6 0F         [ 7] 2362 	and	a, #0x0F
   189F 28 33         [12] 2363 	jr	Z,00244$
                           2364 ;src/Renderer.c:875: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   18A1 DD 7E F4      [19] 2365 	ld	a,-12 (ix)
   18A4 DD 96 EC      [19] 2366 	sub	a, -20 (ix)
   18A7 6F            [ 4] 2367 	ld	l,a
   18A8 DD 7E F5      [19] 2368 	ld	a,-11 (ix)
   18AB DD 9E ED      [19] 2369 	sbc	a, -19 (ix)
   18AE 67            [ 4] 2370 	ld	h,a
   18AF 29            [11] 2371 	add	hl, hl
   18B0 29            [11] 2372 	add	hl, hl
   18B1 29            [11] 2373 	add	hl, hl
   18B2 29            [11] 2374 	add	hl, hl
   18B3 29            [11] 2375 	add	hl, hl
   18B4 C5            [11] 2376 	push	bc
   18B5 DD 5E F4      [19] 2377 	ld	e,-12 (ix)
   18B8 DD 56 F5      [19] 2378 	ld	d,-11 (ix)
   18BB D5            [11] 2379 	push	de
   18BC E5            [11] 2380 	push	hl
   18BD CD 79 4E      [17] 2381 	call	__divsint
   18C0 F1            [10] 2382 	pop	af
   18C1 F1            [10] 2383 	pop	af
   18C2 55            [ 4] 2384 	ld	d,l
   18C3 C1            [10] 2385 	pop	bc
   18C4 D5            [11] 2386 	push	de
   18C5 33            [ 6] 2387 	inc	sp
   18C6 DD 66 F9      [19] 2388 	ld	h,-7 (ix)
   18C9 DD 6E CC      [19] 2389 	ld	l,-52 (ix)
   18CC E5            [11] 2390 	push	hl
   18CD C5            [11] 2391 	push	bc
   18CE 33            [ 6] 2392 	inc	sp
   18CF CD 34 0B      [17] 2393 	call	_draw_column_to_buffer_enemy
   18D2 F1            [10] 2394 	pop	af
   18D3 F1            [10] 2395 	pop	af
                           2396 ;src/Renderer.c:877: else if(currentCellID&CELL_ITEM_MASK){
   18D4                    2397 00244$:
                           2398 ;src/Renderer.c:882: ++xCellCount;
   18D4 DD 34 F6      [23] 2399 	inc	-10 (ix)
                           2400 ;src/Renderer.c:801: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   18D7 DD 35 CA      [23] 2401 	dec	-54 (ix)
                           2402 ;src/Renderer.c:414: currentCellID = cells_in_view_array[lineStart + 1];
   18DA 2A B6 0A      [16] 2403 	ld	hl,(_cells_in_view_array)
   18DD DD 75 DF      [19] 2404 	ld	-33 (ix),l
   18E0 DD 74 E0      [19] 2405 	ld	-32 (ix),h
                           2406 ;src/Renderer.c:801: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   18E3 DD 7E CA      [19] 2407 	ld	a,-54 (ix)
   18E6 D6 50         [ 7] 2408 	sub	a, #0x50
   18E8 D2 AB 16      [10] 2409 	jp	NC,00258$
                           2410 ;src/Renderer.c:911: lineStart = lineStart + (offsetDiff * 2) + 3;
   18EB DD 7E DD      [19] 2411 	ld	a,-35 (ix)
   18EE C6 03         [ 7] 2412 	add	a, #0x03
   18F0 DD 77 C7      [19] 2413 	ld	-57 (ix),a
                           2414 ;src/Renderer.c:912: zHeight += zHeight;
   18F3 DD CB CC 26   [23] 2415 	sla	-52 (ix)
                           2416 ;src/Renderer.c:913: offsetDiff = offsetDiff >> 1;
   18F7 DD CB CE 3E   [23] 2417 	srl	-50 (ix)
                           2418 ;src/Renderer.c:915: }while(z);
   18FB DD 7E C9      [19] 2419 	ld	a,-55 (ix)
   18FE B7            [ 4] 2420 	or	a, a
   18FF C2 59 13      [10] 2421 	jp	NZ,00246$
   1902                    2422 00260$:
   1902 DD F9         [10] 2423 	ld	sp, ix
   1904 DD E1         [14] 2424 	pop	ix
   1906 C9            [10] 2425 	ret
                           2426 ;src/Renderer.c:921: void draw_minimap_to_buffer(){
                           2427 ;	---------------------------------
                           2428 ; Function draw_minimap_to_buffer
                           2429 ; ---------------------------------
   1907                    2430 _draw_minimap_to_buffer::
   1907 DD E5         [15] 2431 	push	ix
   1909 DD 21 00 00   [14] 2432 	ld	ix,#0
   190D DD 39         [15] 2433 	add	ix,sp
   190F 21 F5 FF      [10] 2434 	ld	hl,#-11
   1912 39            [11] 2435 	add	hl,sp
   1913 F9            [ 6] 2436 	ld	sp,hl
                           2437 ;src/Renderer.c:924: u8* ptr = MINIMAP_BUFFER;
   1914 01 A0 AA      [10] 2438 	ld	bc,#0xAAA0
                           2439 ;src/Renderer.c:929: y=(player_position.y-MINIMAP_HEIGHT_HALF);
   1917 3A 8A 08      [13] 2440 	ld	a, (#(_player_position + 0x0001) + 0)
   191A C6 F8         [ 7] 2441 	add	a,#0xF8
   191C 5F            [ 4] 2442 	ld	e,a
                           2443 ;src/Renderer.c:931: for(j=0;j<MINIMAP_HEIGHT;++j){
   191D 16 00         [ 7] 2444 	ld	d,#0x00
                           2445 ;src/Renderer.c:932: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   191F                    2446 00137$:
   191F 7B            [ 4] 2447 	ld	a,e
   1920 07            [ 4] 2448 	rlca
   1921 E6 01         [ 7] 2449 	and	a,#0x01
   1923 DD 77 FA      [19] 2450 	ld	-6 (ix),a
   1926 7B            [ 4] 2451 	ld	a,e
   1927 EE 80         [ 7] 2452 	xor	a, #0x80
   1929 D6 A0         [ 7] 2453 	sub	a, #0xA0
   192B 3E 00         [ 7] 2454 	ld	a,#0x00
   192D 17            [ 4] 2455 	rla
   192E DD 77 FD      [19] 2456 	ld	-3 (ix),a
   1931 DD 36 F5 00   [19] 2457 	ld	-11 (ix),#0x00
   1935                    2458 00122$:
                           2459 ;src/Renderer.c:933: x=(player_position.x-MINIMAP_WIDTH_HALF);
   1935 3A 89 08      [13] 2460 	ld	a, (#_player_position + 0)
   1938 C6 F8         [ 7] 2461 	add	a,#0xF8
   193A DD 77 F7      [19] 2462 	ld	-9 (ix),a
                           2463 ;src/Renderer.c:934: for(i=0;i<MINIMAP_WIDTH;++i){
   193D DD 36 F6 00   [19] 2464 	ld	-10 (ix),#0x00
   1941                    2465 00120$:
                           2466 ;src/Renderer.c:937: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   1941 FD 21 10 00   [14] 2467 	ld	iy,#0x0010
   1945 FD 09         [15] 2468 	add	iy, bc
                           2469 ;src/Renderer.c:935: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
   1947 DD CB F7 7E   [20] 2470 	bit	7, -9 (ix)
   194B 20 15         [12] 2471 	jr	NZ,00111$
   194D DD 7E F7      [19] 2472 	ld	a,-9 (ix)
   1950 EE 80         [ 7] 2473 	xor	a, #0x80
   1952 D6 A0         [ 7] 2474 	sub	a, #0xA0
   1954 30 0C         [12] 2475 	jr	NC,00111$
   1956 DD 7E FA      [19] 2476 	ld	a,-6 (ix)
   1959 B7            [ 4] 2477 	or	a, a
   195A 20 06         [12] 2478 	jr	NZ,00111$
   195C DD CB FD 46   [20] 2479 	bit	0,-3 (ix)
   1960 20 0D         [12] 2480 	jr	NZ,00112$
   1962                    2481 00111$:
                           2482 ;src/Renderer.c:936: *ptr=g_colors[MINIMAP_WALL_COLOR];
   1962 3A A4 0A      [13] 2483 	ld	a, (#(_g_colors + 0x0001) + 0)
   1965 02            [ 7] 2484 	ld	(bc),a
                           2485 ;src/Renderer.c:937: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   1966 3A A4 0A      [13] 2486 	ld	a, (#(_g_colors + 0x0001) + 0)
   1969 FD 77 00      [19] 2487 	ld	0 (iy), a
   196C C3 16 1A      [10] 2488 	jp	00113$
   196F                    2489 00112$:
                           2490 ;src/Renderer.c:939: else if((x==player_position.x)&&(y==player_position.y)){
   196F DD 7E F7      [19] 2491 	ld	a,-9 (ix)
   1972 DD 77 FB      [19] 2492 	ld	-5 (ix),a
   1975 DD 7E F7      [19] 2493 	ld	a,-9 (ix)
   1978 17            [ 4] 2494 	rla
   1979 9F            [ 4] 2495 	sbc	a, a
   197A DD 77 FC      [19] 2496 	ld	-4 (ix),a
   197D 3A 89 08      [13] 2497 	ld	a, (#_player_position + 0)
   1980 DD 77 FE      [19] 2498 	ld	-2 (ix),a
   1983 DD 36 FF 00   [19] 2499 	ld	-1 (ix),#0x00
   1987 DD 73 F8      [19] 2500 	ld	-8 (ix),e
   198A 7B            [ 4] 2501 	ld	a,e
   198B 17            [ 4] 2502 	rla
   198C 9F            [ 4] 2503 	sbc	a, a
   198D DD 77 F9      [19] 2504 	ld	-7 (ix),a
   1990 DD 7E FB      [19] 2505 	ld	a,-5 (ix)
   1993 DD 96 FE      [19] 2506 	sub	a, -2 (ix)
   1996 20 2E         [12] 2507 	jr	NZ,00108$
   1998 DD 7E FC      [19] 2508 	ld	a,-4 (ix)
   199B DD 96 FF      [19] 2509 	sub	a, -1 (ix)
   199E 20 26         [12] 2510 	jr	NZ,00108$
   19A0 3A 8A 08      [13] 2511 	ld	a, (#(_player_position + 0x0001) + 0)
   19A3 DD 77 FE      [19] 2512 	ld	-2 (ix),a
   19A6 DD 36 FF 00   [19] 2513 	ld	-1 (ix),#0x00
   19AA DD 7E F8      [19] 2514 	ld	a,-8 (ix)
   19AD DD 96 FE      [19] 2515 	sub	a, -2 (ix)
   19B0 20 14         [12] 2516 	jr	NZ,00108$
   19B2 DD 7E F9      [19] 2517 	ld	a,-7 (ix)
   19B5 DD 96 FF      [19] 2518 	sub	a, -1 (ix)
   19B8 20 0C         [12] 2519 	jr	NZ,00108$
                           2520 ;src/Renderer.c:940: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
   19BA 3A A7 0A      [13] 2521 	ld	a, (#(_g_colors + 0x0004) + 0)
   19BD 02            [ 7] 2522 	ld	(bc),a
                           2523 ;src/Renderer.c:941: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
   19BE 3A A7 0A      [13] 2524 	ld	a, (#(_g_colors + 0x0004) + 0)
   19C1 FD 77 00      [19] 2525 	ld	0 (iy), a
   19C4 18 50         [12] 2526 	jr	00113$
   19C6                    2527 00108$:
                           2528 ;src/Renderer.c:944: val = (*(u8*)(MAP_MEM+x+y*MAP_WIDTH));
   19C6 DD 7E FB      [19] 2529 	ld	a,-5 (ix)
   19C9 C6 00         [ 7] 2530 	add	a, #0x00
   19CB DD 77 FE      [19] 2531 	ld	-2 (ix),a
   19CE DD 7E FC      [19] 2532 	ld	a,-4 (ix)
   19D1 CE 70         [ 7] 2533 	adc	a, #0x70
   19D3 DD 77 FF      [19] 2534 	ld	-1 (ix),a
   19D6 DD 6E F8      [19] 2535 	ld	l,-8 (ix)
   19D9 DD 66 F9      [19] 2536 	ld	h,-7 (ix)
   19DC 29            [11] 2537 	add	hl, hl
   19DD 29            [11] 2538 	add	hl, hl
   19DE 29            [11] 2539 	add	hl, hl
   19DF 29            [11] 2540 	add	hl, hl
   19E0 29            [11] 2541 	add	hl, hl
   19E1 DD 7E FE      [19] 2542 	ld	a,-2 (ix)
   19E4 85            [ 4] 2543 	add	a, l
   19E5 6F            [ 4] 2544 	ld	l,a
   19E6 DD 7E FF      [19] 2545 	ld	a,-1 (ix)
   19E9 8C            [ 4] 2546 	adc	a, h
   19EA 67            [ 4] 2547 	ld	h,a
   19EB 66            [ 7] 2548 	ld	h,(hl)
                           2549 ;src/Renderer.c:946: if(val==CELLTYPE_DOOR){
   19EC 7C            [ 4] 2550 	ld	a,h
   19ED D6 80         [ 7] 2551 	sub	a, #0x80
   19EF 20 0C         [12] 2552 	jr	NZ,00105$
                           2553 ;src/Renderer.c:947: *ptr=g_colors[MINIMAP_EXIT_COLOR];
   19F1 3A A8 0A      [13] 2554 	ld	a, (#(_g_colors + 0x0005) + 0)
   19F4 02            [ 7] 2555 	ld	(bc),a
                           2556 ;src/Renderer.c:948: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
   19F5 3A A8 0A      [13] 2557 	ld	a, (#(_g_colors + 0x0005) + 0)
   19F8 FD 77 00      [19] 2558 	ld	0 (iy), a
   19FB 18 19         [12] 2559 	jr	00113$
   19FD                    2560 00105$:
                           2561 ;src/Renderer.c:950: else if(val&CELL_WALL_MASK){
   19FD 29            [11] 2562 	add	hl, hl
   19FE 30 0C         [12] 2563 	jr	NC,00102$
                           2564 ;src/Renderer.c:951: *ptr=g_colors[MINIMAP_WALL_COLOR];
   1A00 3A A4 0A      [13] 2565 	ld	a, (#(_g_colors + 0x0001) + 0)
   1A03 02            [ 7] 2566 	ld	(bc),a
                           2567 ;src/Renderer.c:952: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   1A04 3A A4 0A      [13] 2568 	ld	a, (#(_g_colors + 0x0001) + 0)
   1A07 FD 77 00      [19] 2569 	ld	0 (iy), a
   1A0A 18 0A         [12] 2570 	jr	00113$
   1A0C                    2571 00102$:
                           2572 ;src/Renderer.c:955: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
   1A0C 3A A6 0A      [13] 2573 	ld	a, (#(_g_colors + 0x0003) + 0)
   1A0F 02            [ 7] 2574 	ld	(bc),a
                           2575 ;src/Renderer.c:956: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
   1A10 3A A6 0A      [13] 2576 	ld	a, (#(_g_colors + 0x0003) + 0)
   1A13 FD 77 00      [19] 2577 	ld	0 (iy), a
   1A16                    2578 00113$:
                           2579 ;src/Renderer.c:959: ++x;
   1A16 DD 34 F7      [23] 2580 	inc	-9 (ix)
                           2581 ;src/Renderer.c:960: ++ptr;
   1A19 03            [ 6] 2582 	inc	bc
                           2583 ;src/Renderer.c:934: for(i=0;i<MINIMAP_WIDTH;++i){
   1A1A DD 34 F6      [23] 2584 	inc	-10 (ix)
   1A1D DD 7E F6      [19] 2585 	ld	a,-10 (ix)
   1A20 D6 10         [ 7] 2586 	sub	a, #0x10
   1A22 DA 41 19      [10] 2587 	jp	C,00120$
                           2588 ;src/Renderer.c:932: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   1A25 DD 34 F5      [23] 2589 	inc	-11 (ix)
   1A28 DD 7E F5      [19] 2590 	ld	a,-11 (ix)
   1A2B D6 04         [ 7] 2591 	sub	a, #0x04
   1A2D DA 35 19      [10] 2592 	jp	C,00122$
                           2593 ;src/Renderer.c:963: ++y;
   1A30 1C            [ 4] 2594 	inc	e
                           2595 ;src/Renderer.c:931: for(j=0;j<MINIMAP_HEIGHT;++j){
   1A31 14            [ 4] 2596 	inc	d
   1A32 7A            [ 4] 2597 	ld	a,d
   1A33 D6 10         [ 7] 2598 	sub	a, #0x10
   1A35 DA 1F 19      [10] 2599 	jp	C,00137$
   1A38 DD F9         [10] 2600 	ld	sp, ix
   1A3A DD E1         [14] 2601 	pop	ix
   1A3C C9            [10] 2602 	ret
                           2603 	.area _CODE
                           2604 	.area _INITIALIZER
                           2605 	.area _CABS (ABS)
