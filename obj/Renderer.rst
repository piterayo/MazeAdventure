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
   1A67                      61 _calculate_cells_in_view::
   1A67 DD E5         [15]   62 	push	ix
   1A69 DD 21 00 00   [14]   63 	ld	ix,#0
   1A6D DD 39         [15]   64 	add	ix,sp
   1A6F 21 F2 FF      [10]   65 	ld	hl,#-14
   1A72 39            [11]   66 	add	hl,sp
   1A73 F9            [ 6]   67 	ld	sp,hl
                             68 ;src/Renderer.c:53: u8 offset=0, n=0, j, i;
   1A74 DD 36 FA 00   [19]   69 	ld	-6 (ix),#0x00
   1A78 DD 36 F9 00   [19]   70 	ld	-7 (ix),#0x00
                             71 ;src/Renderer.c:56: if(player_direction.y!=0){
   1A7C 21 F1 19      [10]   72 	ld	hl, #_player_direction + 1
   1A7F 7E            [ 7]   73 	ld	a,(hl)
   1A80 DD 77 FC      [19]   74 	ld	-4 (ix), a
   1A83 B7            [ 4]   75 	or	a, a
   1A84 28 32         [12]   76 	jr	Z,00102$
                             77 ;src/Renderer.c:57: vert=1;
   1A86 DD 36 F2 01   [19]   78 	ld	-14 (ix),#0x01
                             79 ;src/Renderer.c:58: dy=player_direction.y;
   1A8A DD 4E FC      [19]   80 	ld	c,-4 (ix)
   1A8D DD 71 F4      [19]   81 	ld	-12 (ix),c
                             82 ;src/Renderer.c:59: dx=-player_direction.y;
   1A90 AF            [ 4]   83 	xor	a, a
   1A91 DD 96 FC      [19]   84 	sub	a, -4 (ix)
   1A94 DD 77 F5      [19]   85 	ld	-11 (ix), a
                             86 ;src/Renderer.c:61: x0 = player_position.x-(17*dx);
   1A97 21 EE 19      [10]   87 	ld	hl,#_player_position+0
   1A9A 4E            [ 7]   88 	ld	c,(hl)
   1A9B DD 6E F5      [19]   89 	ld	l,-11 (ix)
   1A9E 5D            [ 4]   90 	ld	e,l
   1A9F 29            [11]   91 	add	hl, hl
   1AA0 29            [11]   92 	add	hl, hl
   1AA1 29            [11]   93 	add	hl, hl
   1AA2 29            [11]   94 	add	hl, hl
   1AA3 19            [11]   95 	add	hl, de
   1AA4 79            [ 4]   96 	ld	a,c
   1AA5 95            [ 4]   97 	sub	a, l
   1AA6 DD 77 F6      [19]   98 	ld	-10 (ix),a
                             99 ;src/Renderer.c:62: y0 = player_position.y+(6*dy);
   1AA9 21 EF 19      [10]  100 	ld	hl,#_player_position+1
   1AAC 4E            [ 7]  101 	ld	c,(hl)
   1AAD DD 6E F4      [19]  102 	ld	l,-12 (ix)
   1AB0 5D            [ 4]  103 	ld	e,l
   1AB1 29            [11]  104 	add	hl, hl
   1AB2 19            [11]  105 	add	hl, de
   1AB3 29            [11]  106 	add	hl, hl
   1AB4 09            [11]  107 	add	hl, bc
   1AB5 4D            [ 4]  108 	ld	c,l
   1AB6 18 35         [12]  109 	jr	00103$
   1AB8                     110 00102$:
                            111 ;src/Renderer.c:65: vert=0;
   1AB8 DD 36 F2 00   [19]  112 	ld	-14 (ix),#0x00
                            113 ;src/Renderer.c:66: dy=player_direction.x;
   1ABC 21 F0 19      [10]  114 	ld	hl, #_player_direction + 0
   1ABF 7E            [ 7]  115 	ld	a,(hl)
   1AC0 DD 77 FC      [19]  116 	ld	-4 (ix), a
   1AC3 DD 77 F4      [19]  117 	ld	-12 (ix),a
                            118 ;src/Renderer.c:67: dx=player_direction.x;
   1AC6 DD 7E FC      [19]  119 	ld	a,-4 (ix)
   1AC9 DD 77 F5      [19]  120 	ld	-11 (ix),a
                            121 ;src/Renderer.c:69: y0 = player_position.y-(17*dy);
   1ACC 21 EF 19      [10]  122 	ld	hl, #_player_position + 1
   1ACF 4E            [ 7]  123 	ld	c,(hl)
   1AD0 DD 6E F4      [19]  124 	ld	l,-12 (ix)
   1AD3 5D            [ 4]  125 	ld	e,l
   1AD4 29            [11]  126 	add	hl, hl
   1AD5 29            [11]  127 	add	hl, hl
   1AD6 29            [11]  128 	add	hl, hl
   1AD7 29            [11]  129 	add	hl, hl
   1AD8 19            [11]  130 	add	hl, de
   1AD9 79            [ 4]  131 	ld	a,c
   1ADA 95            [ 4]  132 	sub	a, l
   1ADB 4F            [ 4]  133 	ld	c,a
                            134 ;src/Renderer.c:70: x0 = player_position.x+(6*dx);
   1ADC 21 EE 19      [10]  135 	ld	hl, #_player_position + 0
   1ADF 46            [ 7]  136 	ld	b,(hl)
   1AE0 DD 7E FC      [19]  137 	ld	a,-4 (ix)
   1AE3 5F            [ 4]  138 	ld	e,a
   1AE4 87            [ 4]  139 	add	a, a
   1AE5 83            [ 4]  140 	add	a, e
   1AE6 87            [ 4]  141 	add	a, a
   1AE7 5F            [ 4]  142 	ld	e,a
   1AE8 68            [ 4]  143 	ld	l,b
   1AE9 19            [11]  144 	add	hl, de
   1AEA DD 75 F6      [19]  145 	ld	-10 (ix),l
   1AED                     146 00103$:
                            147 ;src/Renderer.c:74: x=x0;
   1AED DD 5E F6      [19]  148 	ld	e,-10 (ix)
                            149 ;src/Renderer.c:75: y=y0;
   1AF0 DD 71 F3      [19]  150 	ld	-13 (ix),c
                            151 ;src/Renderer.c:77: for(j=0;j<6;++j){
   1AF3 DD 7E F5      [19]  152 	ld	a,-11 (ix)
   1AF6 07            [ 4]  153 	rlca
   1AF7 E6 01         [ 7]  154 	and	a,#0x01
   1AF9 DD 77 FC      [19]  155 	ld	-4 (ix),a
   1AFC DD 7E F4      [19]  156 	ld	a,-12 (ix)
   1AFF 07            [ 4]  157 	rlca
   1B00 E6 01         [ 7]  158 	and	a,#0x01
   1B02 DD 77 FF      [19]  159 	ld	-1 (ix),a
   1B05 DD 36 F8 00   [19]  160 	ld	-8 (ix),#0x00
                            161 ;src/Renderer.c:79: for(i=offset;i<35-offset;++i){
   1B09                     162 00138$:
   1B09 DD 7E F9      [19]  163 	ld	a,-7 (ix)
   1B0C DD 77 FB      [19]  164 	ld	-5 (ix),a
   1B0F DD 7E FA      [19]  165 	ld	a,-6 (ix)
   1B12 DD 77 F7      [19]  166 	ld	-9 (ix),a
   1B15                     167 00125$:
   1B15 DD 6E FA      [19]  168 	ld	l,-6 (ix)
   1B18 26 00         [ 7]  169 	ld	h,#0x00
   1B1A 3E 23         [ 7]  170 	ld	a,#0x23
   1B1C 95            [ 4]  171 	sub	a, l
   1B1D 6F            [ 4]  172 	ld	l,a
   1B1E 3E 00         [ 7]  173 	ld	a,#0x00
   1B20 9C            [ 4]  174 	sbc	a, h
   1B21 67            [ 4]  175 	ld	h,a
   1B22 DD 7E F7      [19]  176 	ld	a, -9 (ix)
   1B25 16 00         [ 7]  177 	ld	d, #0x00
   1B27 95            [ 4]  178 	sub	a, l
   1B28 7A            [ 4]  179 	ld	a,d
   1B29 9C            [ 4]  180 	sbc	a, h
   1B2A E2 2F 1B      [10]  181 	jp	PO, 00181$
   1B2D EE 80         [ 7]  182 	xor	a, #0x80
   1B2F                     183 00181$:
   1B2F F2 AE 1B      [10]  184 	jp	P,00143$
                            185 ;src/Renderer.c:82: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   1B32 2A 3A 1C      [16]  186 	ld	hl,(_cells_in_view_array)
   1B35 7D            [ 4]  187 	ld	a,l
   1B36 DD 86 FB      [19]  188 	add	a, -5 (ix)
   1B39 DD 77 FD      [19]  189 	ld	-3 (ix),a
   1B3C 7C            [ 4]  190 	ld	a,h
   1B3D CE 00         [ 7]  191 	adc	a, #0x00
   1B3F DD 77 FE      [19]  192 	ld	-2 (ix),a
                            193 ;src/Renderer.c:81: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
   1B42 CB 7B         [ 8]  194 	bit	7, e
   1B44 20 41         [12]  195 	jr	NZ,00105$
   1B46 7B            [ 4]  196 	ld	a,e
   1B47 EE 80         [ 7]  197 	xor	a, #0x80
   1B49 D6 A0         [ 7]  198 	sub	a, #0xA0
   1B4B 30 3A         [12]  199 	jr	NC,00105$
   1B4D DD CB F3 7E   [20]  200 	bit	7, -13 (ix)
   1B51 20 34         [12]  201 	jr	NZ,00105$
   1B53 DD 7E F3      [19]  202 	ld	a,-13 (ix)
   1B56 EE 80         [ 7]  203 	xor	a, #0x80
   1B58 D6 A0         [ 7]  204 	sub	a, #0xA0
   1B5A 30 2B         [12]  205 	jr	NC,00105$
                            206 ;src/Renderer.c:82: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   1B5C 7B            [ 4]  207 	ld	a,e
   1B5D 6F            [ 4]  208 	ld	l,a
   1B5E 17            [ 4]  209 	rla
   1B5F 9F            [ 4]  210 	sbc	a, a
   1B60 67            [ 4]  211 	ld	h,a
   1B61 7D            [ 4]  212 	ld	a,l
   1B62 C6 D0         [ 7]  213 	add	a, #0xD0
   1B64 47            [ 4]  214 	ld	b,a
   1B65 7C            [ 4]  215 	ld	a,h
   1B66 CE 88         [ 7]  216 	adc	a, #0x88
   1B68 57            [ 4]  217 	ld	d,a
   1B69 DD 6E F3      [19]  218 	ld	l,-13 (ix)
   1B6C DD 7E F3      [19]  219 	ld	a,-13 (ix)
   1B6F 17            [ 4]  220 	rla
   1B70 9F            [ 4]  221 	sbc	a, a
   1B71 67            [ 4]  222 	ld	h,a
   1B72 29            [11]  223 	add	hl, hl
   1B73 29            [11]  224 	add	hl, hl
   1B74 29            [11]  225 	add	hl, hl
   1B75 29            [11]  226 	add	hl, hl
   1B76 29            [11]  227 	add	hl, hl
   1B77 7D            [ 4]  228 	ld	a,l
   1B78 80            [ 4]  229 	add	a, b
   1B79 6F            [ 4]  230 	ld	l,a
   1B7A 7C            [ 4]  231 	ld	a,h
   1B7B 8A            [ 4]  232 	adc	a, d
   1B7C 67            [ 4]  233 	ld	h,a
   1B7D 46            [ 7]  234 	ld	b,(hl)
   1B7E DD 6E FD      [19]  235 	ld	l,-3 (ix)
   1B81 DD 66 FE      [19]  236 	ld	h,-2 (ix)
   1B84 70            [ 7]  237 	ld	(hl),b
   1B85 18 08         [12]  238 	jr	00106$
   1B87                     239 00105$:
                            240 ;src/Renderer.c:85: cells_in_view_array[n]=CELLTYPE_WALL1;
   1B87 DD 6E FD      [19]  241 	ld	l,-3 (ix)
   1B8A DD 66 FE      [19]  242 	ld	h,-2 (ix)
   1B8D 36 81         [10]  243 	ld	(hl),#0x81
   1B8F                     244 00106$:
                            245 ;src/Renderer.c:89: if(vert){
   1B8F DD 7E F2      [19]  246 	ld	a,-14 (ix)
   1B92 B7            [ 4]  247 	or	a, a
   1B93 28 07         [12]  248 	jr	Z,00111$
                            249 ;src/Renderer.c:90: x+=dx;
   1B95 7B            [ 4]  250 	ld	a,e
   1B96 DD 86 F5      [19]  251 	add	a, -11 (ix)
   1B99 5F            [ 4]  252 	ld	e,a
   1B9A 18 09         [12]  253 	jr	00112$
   1B9C                     254 00111$:
                            255 ;src/Renderer.c:93: y+=dy;
   1B9C DD 7E F3      [19]  256 	ld	a,-13 (ix)
   1B9F DD 86 F4      [19]  257 	add	a, -12 (ix)
   1BA2 DD 77 F3      [19]  258 	ld	-13 (ix),a
   1BA5                     259 00112$:
                            260 ;src/Renderer.c:95: ++n;
   1BA5 DD 34 FB      [23]  261 	inc	-5 (ix)
                            262 ;src/Renderer.c:79: for(i=offset;i<35-offset;++i){
   1BA8 DD 34 F7      [23]  263 	inc	-9 (ix)
   1BAB C3 15 1B      [10]  264 	jp	00125$
   1BAE                     265 00143$:
   1BAE DD 7E FB      [19]  266 	ld	a,-5 (ix)
   1BB1 DD 77 F9      [19]  267 	ld	-7 (ix),a
                            268 ;src/Renderer.c:97: offset=offsets_cells_in_view[j];
   1BB4 3E 3C         [ 7]  269 	ld	a,#<(_offsets_cells_in_view)
   1BB6 DD 86 F8      [19]  270 	add	a, -8 (ix)
   1BB9 6F            [ 4]  271 	ld	l,a
   1BBA 3E 1C         [ 7]  272 	ld	a,#>(_offsets_cells_in_view)
   1BBC CE 00         [ 7]  273 	adc	a, #0x00
   1BBE 67            [ 4]  274 	ld	h,a
   1BBF 7E            [ 7]  275 	ld	a,(hl)
                            276 ;src/Renderer.c:101: if(dx<0) x=x0-offset;
   1BC0 DD 77 FA      [19]  277 	ld	-6 (ix), a
   1BC3 DD 77 FD      [19]  278 	ld	-3 (ix),a
                            279 ;src/Renderer.c:99: if(vert){
   1BC6 DD 7E F2      [19]  280 	ld	a,-14 (ix)
   1BC9 B7            [ 4]  281 	or	a, a
   1BCA 28 21         [12]  282 	jr	Z,00121$
                            283 ;src/Renderer.c:100: y-=dy;
   1BCC DD 7E F3      [19]  284 	ld	a,-13 (ix)
   1BCF DD 96 F4      [19]  285 	sub	a, -12 (ix)
   1BD2 DD 77 F3      [19]  286 	ld	-13 (ix),a
                            287 ;src/Renderer.c:101: if(dx<0) x=x0-offset;
   1BD5 DD 7E FC      [19]  288 	ld	a,-4 (ix)
   1BD8 B7            [ 4]  289 	or	a, a
   1BD9 28 09         [12]  290 	jr	Z,00115$
   1BDB DD 7E F6      [19]  291 	ld	a,-10 (ix)
   1BDE DD 96 FD      [19]  292 	sub	a, -3 (ix)
   1BE1 5F            [ 4]  293 	ld	e,a
   1BE2 18 24         [12]  294 	jr	00128$
   1BE4                     295 00115$:
                            296 ;src/Renderer.c:102: else x=x0+offset;
   1BE4 DD 7E F6      [19]  297 	ld	a,-10 (ix)
   1BE7 DD 86 FD      [19]  298 	add	a, -3 (ix)
   1BEA 5F            [ 4]  299 	ld	e,a
   1BEB 18 1B         [12]  300 	jr	00128$
   1BED                     301 00121$:
                            302 ;src/Renderer.c:106: x-=dx;
   1BED 7B            [ 4]  303 	ld	a,e
   1BEE DD 96 F5      [19]  304 	sub	a, -11 (ix)
   1BF1 5F            [ 4]  305 	ld	e,a
                            306 ;src/Renderer.c:107: if(dy<0) y=y0-offset;
   1BF2 DD 7E FF      [19]  307 	ld	a,-1 (ix)
   1BF5 B7            [ 4]  308 	or	a, a
   1BF6 28 09         [12]  309 	jr	Z,00118$
   1BF8 79            [ 4]  310 	ld	a,c
   1BF9 DD 96 FD      [19]  311 	sub	a, -3 (ix)
   1BFC DD 77 F3      [19]  312 	ld	-13 (ix),a
   1BFF 18 07         [12]  313 	jr	00128$
   1C01                     314 00118$:
                            315 ;src/Renderer.c:108: else y=y0+offset;
   1C01 79            [ 4]  316 	ld	a,c
   1C02 DD 86 FD      [19]  317 	add	a, -3 (ix)
   1C05 DD 77 F3      [19]  318 	ld	-13 (ix),a
   1C08                     319 00128$:
                            320 ;src/Renderer.c:77: for(j=0;j<6;++j){
   1C08 DD 34 F8      [23]  321 	inc	-8 (ix)
   1C0B DD 7E F8      [19]  322 	ld	a,-8 (ix)
   1C0E D6 06         [ 7]  323 	sub	a, #0x06
   1C10 DA 09 1B      [10]  324 	jp	C,00138$
   1C13 DD F9         [10]  325 	ld	sp, ix
   1C15 DD E1         [14]  326 	pop	ix
   1C17 C9            [10]  327 	ret
   1C18                     328 _g_palette:
   1C18 08                  329 	.db #0x08	; 8
   1C19 00                  330 	.db #0x00	; 0
   1C1A 0D                  331 	.db #0x0D	; 13
   1C1B 1A                  332 	.db #0x1A	; 26
   1C1C 06                  333 	.db #0x06	; 6
   1C1D 09                  334 	.db #0x09	; 9
   1C1E 0F                  335 	.db #0x0F	; 15
   1C1F 00                  336 	.db #0x00	; 0
   1C20 00                  337 	.db #0x00	; 0
   1C21 00                  338 	.db #0x00	; 0
   1C22 00                  339 	.db #0x00	; 0
   1C23 00                  340 	.db #0x00	; 0
   1C24 00                  341 	.db #0x00	; 0
   1C25 00                  342 	.db #0x00	; 0
   1C26 00                  343 	.db #0x00	; 0
   1C27 00                  344 	.db #0x00	; 0
   1C28                     345 _g_colors:
   1C28 00                  346 	.db #0x00	; 0
   1C29 C0                  347 	.db #0xC0	; 192
   1C2A 0C                  348 	.db #0x0C	; 12
   1C2B CC                  349 	.db #0xCC	; 204
   1C2C 30                  350 	.db #0x30	; 48	'0'
   1C2D F0                  351 	.db #0xF0	; 240
   1C2E 3C                  352 	.db #0x3C	; 60
   1C2F FC                  353 	.db #0xFC	; 252
   1C30 03                  354 	.db #0x03	; 3
   1C31 C3                  355 	.db #0xC3	; 195
   1C32 0F                  356 	.db #0x0F	; 15
   1C33 CF                  357 	.db #0xCF	; 207
   1C34 33                  358 	.db #0x33	; 51	'3'
   1C35 F3                  359 	.db #0xF3	; 243
   1C36 3F                  360 	.db #0x3F	; 63
   1C37 FF                  361 	.db #0xFF	; 255
   1C38                     362 _g_pixelMask:
   1C38 AA                  363 	.db #0xAA	; 170
   1C39 55                  364 	.db #0x55	; 85	'U'
   1C3A                     365 _cells_in_view_array:
   1C3A F0 BD               366 	.dw #0xBDF0
   1C3C                     367 _offsets_cells_in_view:
   1C3C 08                  368 	.db #0x08	; 8
   1C3D 0C                  369 	.db #0x0C	; 12
   1C3E 0E                  370 	.db #0x0E	; 14
   1C3F 0F                  371 	.db #0x0F	; 15
   1C40 10                  372 	.db #0x10	; 16
                            373 ;src/Renderer.c:116: void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
                            374 ;	---------------------------------
                            375 ; Function draw_column_to_buffer_untextured
                            376 ; ---------------------------------
   1C41                     377 _draw_column_to_buffer_untextured::
   1C41 DD E5         [15]  378 	push	ix
   1C43 DD 21 00 00   [14]  379 	ld	ix,#0
   1C47 DD 39         [15]  380 	add	ix,sp
   1C49 F5            [11]  381 	push	af
                            382 ;src/Renderer.c:117: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1C4A DD 7E 04      [19]  383 	ld	a, 4 (ix)
   1C4D CB 3F         [ 8]  384 	srl	a
   1C4F C6 50         [ 7]  385 	add	a, #0x50
   1C51 4F            [ 4]  386 	ld	c,a
   1C52 3E 00         [ 7]  387 	ld	a,#0x00
   1C54 CE AA         [ 7]  388 	adc	a, #0xAA
   1C56 47            [ 4]  389 	ld	b,a
                            390 ;src/Renderer.c:119: u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
   1C57 11 28 1C      [10]  391 	ld	de,#_g_colors+0
   1C5A DD 6E 06      [19]  392 	ld	l,6 (ix)
   1C5D 26 00         [ 7]  393 	ld	h,#0x00
   1C5F 19            [11]  394 	add	hl,de
   1C60 7E            [ 7]  395 	ld	a,(hl)
   1C61 DD 77 FE      [19]  396 	ld	-2 (ix),a
                            397 ;src/Renderer.c:120: u8 pixMask = g_pixelMask[column&1];
   1C64 11 38 1C      [10]  398 	ld	de,#_g_pixelMask+0
   1C67 DD 7E 04      [19]  399 	ld	a,4 (ix)
   1C6A E6 01         [ 7]  400 	and	a, #0x01
   1C6C 6F            [ 4]  401 	ld	l,a
   1C6D 26 00         [ 7]  402 	ld	h,#0x00
   1C6F 19            [11]  403 	add	hl,de
   1C70 5E            [ 7]  404 	ld	e,(hl)
                            405 ;src/Renderer.c:129: if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
   1C71 3E 64         [ 7]  406 	ld	a,#0x64
   1C73 DD 96 05      [19]  407 	sub	a, 5 (ix)
   1C76 30 04         [12]  408 	jr	NC,00102$
   1C78 DD 36 05 64   [19]  409 	ld	5 (ix),#0x64
   1C7C                     410 00102$:
                            411 ;src/Renderer.c:131: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   1C7C DD 6E 05      [19]  412 	ld	l,5 (ix)
   1C7F CB 3D         [ 8]  413 	srl	l
   1C81 3E 32         [ 7]  414 	ld	a,#0x32
   1C83 95            [ 4]  415 	sub	a, l
                            416 ;src/Renderer.c:134: pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
   1C84 D5            [11]  417 	push	de
   1C85 5F            [ 4]  418 	ld	e,a
   1C86 16 00         [ 7]  419 	ld	d,#0x00
   1C88 6B            [ 4]  420 	ld	l, e
   1C89 62            [ 4]  421 	ld	h, d
   1C8A 29            [11]  422 	add	hl, hl
   1C8B 29            [11]  423 	add	hl, hl
   1C8C 19            [11]  424 	add	hl, de
   1C8D 29            [11]  425 	add	hl, hl
   1C8E 29            [11]  426 	add	hl, hl
   1C8F 29            [11]  427 	add	hl, hl
   1C90 D1            [10]  428 	pop	de
   1C91 09            [11]  429 	add	hl,bc
   1C92 4D            [ 4]  430 	ld	c,l
   1C93 44            [ 4]  431 	ld	b,h
                            432 ;src/Renderer.c:136: j=lineHeight;
   1C94 DD 56 05      [19]  433 	ld	d,5 (ix)
                            434 ;src/Renderer.c:138: for(j;j;--j){
   1C97 7B            [ 4]  435 	ld	a,e
   1C98 2F            [ 4]  436 	cpl
   1C99 DD 77 FF      [19]  437 	ld	-1 (ix),a
   1C9C 7B            [ 4]  438 	ld	a,e
   1C9D DD A6 FE      [19]  439 	and	a, -2 (ix)
   1CA0 5F            [ 4]  440 	ld	e,a
   1CA1                     441 00105$:
   1CA1 7A            [ 4]  442 	ld	a,d
   1CA2 B7            [ 4]  443 	or	a, a
   1CA3 28 0F         [12]  444 	jr	Z,00107$
                            445 ;src/Renderer.c:139: val =  ((*pvmem)&(~pixMask));
   1CA5 0A            [ 7]  446 	ld	a,(bc)
   1CA6 DD A6 FF      [19]  447 	and	a, -1 (ix)
                            448 ;src/Renderer.c:141: *pvmem = val|(w_color&pixMask);
   1CA9 B3            [ 4]  449 	or	a, e
   1CAA 02            [ 7]  450 	ld	(bc),a
                            451 ;src/Renderer.c:143: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   1CAB 21 28 00      [10]  452 	ld	hl,#0x0028
   1CAE 09            [11]  453 	add	hl,bc
   1CAF 4D            [ 4]  454 	ld	c,l
   1CB0 44            [ 4]  455 	ld	b,h
                            456 ;src/Renderer.c:138: for(j;j;--j){
   1CB1 15            [ 4]  457 	dec	d
   1CB2 18 ED         [12]  458 	jr	00105$
   1CB4                     459 00107$:
   1CB4 DD F9         [10]  460 	ld	sp, ix
   1CB6 DD E1         [14]  461 	pop	ix
   1CB8 C9            [10]  462 	ret
                            463 ;src/Renderer.c:147: void draw_column_to_buffer_object(u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            464 ;	---------------------------------
                            465 ; Function draw_column_to_buffer_object
                            466 ; ---------------------------------
   1CB9                     467 _draw_column_to_buffer_object::
   1CB9 DD E5         [15]  468 	push	ix
   1CBB DD 21 00 00   [14]  469 	ld	ix,#0
   1CBF DD 39         [15]  470 	add	ix,sp
   1CC1 21 F7 FF      [10]  471 	ld	hl,#-9
   1CC4 39            [11]  472 	add	hl,sp
   1CC5 F9            [ 6]  473 	ld	sp,hl
                            474 ;src/Renderer.c:164: u16 texture_line=0;
   1CC6 21 00 00      [10]  475 	ld	hl,#0x0000
   1CC9 E3            [19]  476 	ex	(sp), hl
                            477 ;src/Renderer.c:167: if(texture_column>=8 && texture_column<24){
   1CCA DD 7E 07      [19]  478 	ld	a,7 (ix)
   1CCD D6 08         [ 7]  479 	sub	a, #0x08
   1CCF DA AF 1D      [10]  480 	jp	C,00110$
   1CD2 DD 7E 07      [19]  481 	ld	a,7 (ix)
   1CD5 D6 18         [ 7]  482 	sub	a, #0x18
   1CD7 D2 AF 1D      [10]  483 	jp	NC,00110$
                            484 ;src/Renderer.c:169: index = index>>4;
   1CDA DD 7E 06      [19]  485 	ld	a,6 (ix)
   1CDD 07            [ 4]  486 	rlca
   1CDE 07            [ 4]  487 	rlca
   1CDF 07            [ 4]  488 	rlca
   1CE0 07            [ 4]  489 	rlca
   1CE1 E6 0F         [ 7]  490 	and	a,#0x0F
                            491 ;src/Renderer.c:172: texture = (u8*)(UNCOMPRESSED_OBJECT_TEXTURES + ((ITEM_SPRITE_WIDTH*ITEM_SPRITE_HEIGHT)*(item_get_at(index-1)->type)) + ((texture_column-8)*ITEM_SPRITE_WIDTH));
   1CE3 DD 77 06      [19]  492 	ld	6 (ix), a
   1CE6 47            [ 4]  493 	ld	b, a
   1CE7 05            [ 4]  494 	dec	b
   1CE8 C5            [11]  495 	push	bc
   1CE9 33            [ 6]  496 	inc	sp
   1CEA CD 69 0D      [17]  497 	call	_item_get_at
   1CED 33            [ 6]  498 	inc	sp
   1CEE 23            [ 6]  499 	inc	hl
   1CEF 23            [ 6]  500 	inc	hl
   1CF0 23            [ 6]  501 	inc	hl
   1CF1 46            [ 7]  502 	ld	b, (hl)
   1CF2 0E 00         [ 7]  503 	ld	c,#0x00
   1CF4 21 50 A5      [10]  504 	ld	hl,#0xA550
   1CF7 09            [11]  505 	add	hl,bc
   1CF8 4D            [ 4]  506 	ld	c,l
   1CF9 44            [ 4]  507 	ld	b,h
   1CFA DD 7E 07      [19]  508 	ld	a, 7 (ix)
   1CFD 16 00         [ 7]  509 	ld	d, #0x00
   1CFF C6 F8         [ 7]  510 	add	a,#0xF8
   1D01 6F            [ 4]  511 	ld	l,a
   1D02 7A            [ 4]  512 	ld	a,d
   1D03 CE FF         [ 7]  513 	adc	a,#0xFF
   1D05 67            [ 4]  514 	ld	h,a
   1D06 29            [11]  515 	add	hl, hl
   1D07 29            [11]  516 	add	hl, hl
   1D08 29            [11]  517 	add	hl, hl
   1D09 29            [11]  518 	add	hl, hl
   1D0A 09            [11]  519 	add	hl,bc
   1D0B DD 75 FC      [19]  520 	ld	-4 (ix),l
   1D0E DD 74 FD      [19]  521 	ld	-3 (ix),h
                            522 ;src/Renderer.c:174: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1D11 DD 7E 04      [19]  523 	ld	a, 4 (ix)
   1D14 CB 3F         [ 8]  524 	srl	a
   1D16 C6 50         [ 7]  525 	add	a, #0x50
   1D18 4F            [ 4]  526 	ld	c,a
   1D19 3E 00         [ 7]  527 	ld	a,#0x00
   1D1B CE AA         [ 7]  528 	adc	a, #0xAA
   1D1D 47            [ 4]  529 	ld	b,a
                            530 ;src/Renderer.c:176: pixMask = g_pixelMask[column&1];
   1D1E 11 38 1C      [10]  531 	ld	de,#_g_pixelMask+0
   1D21 DD 7E 04      [19]  532 	ld	a,4 (ix)
   1D24 E6 01         [ 7]  533 	and	a, #0x01
   1D26 6F            [ 4]  534 	ld	l,a
   1D27 26 00         [ 7]  535 	ld	h,#0x00
   1D29 19            [11]  536 	add	hl,de
   1D2A 7E            [ 7]  537 	ld	a,(hl)
   1D2B DD 77 FB      [19]  538 	ld	-5 (ix),a
                            539 ;src/Renderer.c:178: lineHeight = (lineHeight)/2;
   1D2E DD CB 05 3E   [23]  540 	srl	5 (ix)
                            541 ;src/Renderer.c:179: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight/2);
   1D32 DD 7E 05      [19]  542 	ld	a,5 (ix)
   1D35 CB 3F         [ 8]  543 	srl	a
   1D37 C6 32         [ 7]  544 	add	a, #0x32
                            545 ;src/Renderer.c:180: item_top_height = ground_height - lineHeight;
   1D39 DD 96 05      [19]  546 	sub	a, 5 (ix)
   1D3C 5F            [ 4]  547 	ld	e,a
                            548 ;src/Renderer.c:182: texture_line_add = (256*ITEM_SPRITE_HEIGHT)/lineHeight;
   1D3D DD 6E 05      [19]  549 	ld	l,5 (ix)
   1D40 26 00         [ 7]  550 	ld	h,#0x00
   1D42 C5            [11]  551 	push	bc
   1D43 D5            [11]  552 	push	de
   1D44 E5            [11]  553 	push	hl
   1D45 21 00 10      [10]  554 	ld	hl,#0x1000
   1D48 E5            [11]  555 	push	hl
   1D49 CD E8 85      [17]  556 	call	__divsint
   1D4C F1            [10]  557 	pop	af
   1D4D F1            [10]  558 	pop	af
   1D4E D1            [10]  559 	pop	de
   1D4F C1            [10]  560 	pop	bc
   1D50 DD 75 F9      [19]  561 	ld	-7 (ix),l
   1D53 DD 74 FA      [19]  562 	ld	-6 (ix),h
                            563 ;src/Renderer.c:183: j=lineHeight;
   1D56 DD 7E 05      [19]  564 	ld	a,5 (ix)
   1D59 DD 77 FE      [19]  565 	ld	-2 (ix),a
                            566 ;src/Renderer.c:189: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * item_top_height;
   1D5C 16 00         [ 7]  567 	ld	d,#0x00
   1D5E 6B            [ 4]  568 	ld	l, e
   1D5F 62            [ 4]  569 	ld	h, d
   1D60 29            [11]  570 	add	hl, hl
   1D61 29            [11]  571 	add	hl, hl
   1D62 19            [11]  572 	add	hl, de
   1D63 29            [11]  573 	add	hl, hl
   1D64 29            [11]  574 	add	hl, hl
   1D65 29            [11]  575 	add	hl, hl
   1D66 09            [11]  576 	add	hl,bc
   1D67 4D            [ 4]  577 	ld	c,l
   1D68 44            [ 4]  578 	ld	b,h
                            579 ;src/Renderer.c:191: for(j;j;--j){
   1D69 DD 7E FB      [19]  580 	ld	a,-5 (ix)
   1D6C 2F            [ 4]  581 	cpl
   1D6D DD 77 FF      [19]  582 	ld	-1 (ix),a
   1D70                     583 00108$:
   1D70 DD 7E FE      [19]  584 	ld	a,-2 (ix)
   1D73 B7            [ 4]  585 	or	a, a
   1D74 28 39         [12]  586 	jr	Z,00110$
                            587 ;src/Renderer.c:193: color= *(texture+(texture_line/256));
   1D76 DD 5E F8      [19]  588 	ld	e,-8 (ix)
   1D79 16 00         [ 7]  589 	ld	d,#0x00
   1D7B DD 6E FC      [19]  590 	ld	l,-4 (ix)
   1D7E DD 66 FD      [19]  591 	ld	h,-3 (ix)
   1D81 19            [11]  592 	add	hl,de
   1D82 5E            [ 7]  593 	ld	e,(hl)
                            594 ;src/Renderer.c:195: if(color){
   1D83 7B            [ 4]  595 	ld	a,e
   1D84 B7            [ 4]  596 	or	a, a
   1D85 28 0B         [12]  597 	jr	Z,00102$
                            598 ;src/Renderer.c:196: val =  ((*pvmem)&(~pixMask));
   1D87 0A            [ 7]  599 	ld	a,(bc)
   1D88 DD A6 FF      [19]  600 	and	a, -1 (ix)
   1D8B 6F            [ 4]  601 	ld	l,a
                            602 ;src/Renderer.c:198: color = (color&pixMask);
   1D8C 7B            [ 4]  603 	ld	a,e
   1D8D DD A6 FB      [19]  604 	and	a, -5 (ix)
                            605 ;src/Renderer.c:200: *pvmem = val|color;
   1D90 B5            [ 4]  606 	or	a, l
   1D91 02            [ 7]  607 	ld	(bc),a
   1D92                     608 00102$:
                            609 ;src/Renderer.c:203: texture_line += texture_line_add;
   1D92 DD 7E F7      [19]  610 	ld	a,-9 (ix)
   1D95 DD 86 F9      [19]  611 	add	a, -7 (ix)
   1D98 DD 77 F7      [19]  612 	ld	-9 (ix),a
   1D9B DD 7E F8      [19]  613 	ld	a,-8 (ix)
   1D9E DD 8E FA      [19]  614 	adc	a, -6 (ix)
   1DA1 DD 77 F8      [19]  615 	ld	-8 (ix),a
                            616 ;src/Renderer.c:205: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   1DA4 21 28 00      [10]  617 	ld	hl,#0x0028
   1DA7 09            [11]  618 	add	hl,bc
   1DA8 4D            [ 4]  619 	ld	c,l
   1DA9 44            [ 4]  620 	ld	b,h
                            621 ;src/Renderer.c:191: for(j;j;--j){
   1DAA DD 35 FE      [23]  622 	dec	-2 (ix)
   1DAD 18 C1         [12]  623 	jr	00108$
   1DAF                     624 00110$:
   1DAF DD F9         [10]  625 	ld	sp, ix
   1DB1 DD E1         [14]  626 	pop	ix
   1DB3 C9            [10]  627 	ret
                            628 ;src/Renderer.c:212: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            629 ;	---------------------------------
                            630 ; Function draw_column_to_buffer_enemy
                            631 ; ---------------------------------
   1DB4                     632 _draw_column_to_buffer_enemy::
   1DB4 DD E5         [15]  633 	push	ix
   1DB6 DD 21 00 00   [14]  634 	ld	ix,#0
   1DBA DD 39         [15]  635 	add	ix,sp
   1DBC 21 F2 FF      [10]  636 	ld	hl,#-14
   1DBF 39            [11]  637 	add	hl,sp
   1DC0 F9            [ 6]  638 	ld	sp,hl
                            639 ;src/Renderer.c:229: u16 texture_line=0;
   1DC1 DD 36 F7 00   [19]  640 	ld	-9 (ix),#0x00
   1DC5 DD 36 F8 00   [19]  641 	ld	-8 (ix),#0x00
                            642 ;src/Renderer.c:231: if(texture_column>=4 && texture_column<28){
   1DC9 DD 7E 07      [19]  643 	ld	a,7 (ix)
   1DCC D6 04         [ 7]  644 	sub	a, #0x04
   1DCE DA F5 1E      [10]  645 	jp	C,00112$
   1DD1 DD 7E 07      [19]  646 	ld	a,7 (ix)
   1DD4 D6 1C         [ 7]  647 	sub	a, #0x1C
   1DD6 D2 F5 1E      [10]  648 	jp	NC,00112$
                            649 ;src/Renderer.c:234: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(enemy_get_at(index-1)->type)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
   1DD9 DD 46 06      [19]  650 	ld	b,6 (ix)
   1DDC 05            [ 4]  651 	dec	b
   1DDD C5            [11]  652 	push	bc
   1DDE 33            [ 6]  653 	inc	sp
   1DDF CD 40 01      [17]  654 	call	_enemy_get_at
   1DE2 33            [ 6]  655 	inc	sp
   1DE3 23            [ 6]  656 	inc	hl
   1DE4 4E            [ 7]  657 	ld	c,(hl)
   1DE5 06 00         [ 7]  658 	ld	b,#0x00
   1DE7 69            [ 4]  659 	ld	l, c
   1DE8 60            [ 4]  660 	ld	h, b
   1DE9 29            [11]  661 	add	hl, hl
   1DEA 29            [11]  662 	add	hl, hl
   1DEB 29            [11]  663 	add	hl, hl
   1DEC 09            [11]  664 	add	hl, bc
   1DED 29            [11]  665 	add	hl, hl
   1DEE 29            [11]  666 	add	hl, hl
   1DEF 29            [11]  667 	add	hl, hl
   1DF0 29            [11]  668 	add	hl, hl
   1DF1 29            [11]  669 	add	hl, hl
   1DF2 29            [11]  670 	add	hl, hl
   1DF3 01 D0 A0      [10]  671 	ld	bc,#0xA0D0
   1DF6 09            [11]  672 	add	hl,bc
   1DF7 4D            [ 4]  673 	ld	c,l
   1DF8 44            [ 4]  674 	ld	b,h
   1DF9 DD 7E 07      [19]  675 	ld	a, 7 (ix)
   1DFC 16 00         [ 7]  676 	ld	d, #0x00
   1DFE C6 FC         [ 7]  677 	add	a,#0xFC
   1E00 5F            [ 4]  678 	ld	e,a
   1E01 7A            [ 4]  679 	ld	a,d
   1E02 CE FF         [ 7]  680 	adc	a,#0xFF
   1E04 57            [ 4]  681 	ld	d,a
   1E05 6B            [ 4]  682 	ld	l, e
   1E06 62            [ 4]  683 	ld	h, d
   1E07 29            [11]  684 	add	hl, hl
   1E08 19            [11]  685 	add	hl, de
   1E09 29            [11]  686 	add	hl, hl
   1E0A 29            [11]  687 	add	hl, hl
   1E0B 29            [11]  688 	add	hl, hl
   1E0C 09            [11]  689 	add	hl,bc
   1E0D 33            [ 6]  690 	inc	sp
   1E0E 33            [ 6]  691 	inc	sp
   1E0F E5            [11]  692 	push	hl
                            693 ;src/Renderer.c:236: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1E10 DD 7E 04      [19]  694 	ld	a,4 (ix)
   1E13 CB 3F         [ 8]  695 	srl	a
   1E15 C6 50         [ 7]  696 	add	a, #0x50
   1E17 DD 77 FA      [19]  697 	ld	-6 (ix),a
   1E1A 3E 00         [ 7]  698 	ld	a,#0x00
   1E1C CE AA         [ 7]  699 	adc	a, #0xAA
   1E1E DD 77 FB      [19]  700 	ld	-5 (ix),a
                            701 ;src/Renderer.c:238: pixMask = g_pixelMask[column&1];
   1E21 01 38 1C      [10]  702 	ld	bc,#_g_pixelMask+0
   1E24 DD 7E 04      [19]  703 	ld	a,4 (ix)
   1E27 E6 01         [ 7]  704 	and	a, #0x01
   1E29 6F            [ 4]  705 	ld	l, a
   1E2A 26 00         [ 7]  706 	ld	h,#0x00
   1E2C 09            [11]  707 	add	hl,bc
   1E2D 7E            [ 7]  708 	ld	a,(hl)
   1E2E DD 77 F9      [19]  709 	ld	-7 (ix),a
                            710 ;src/Renderer.c:240: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
   1E31 DD 7E 05      [19]  711 	ld	a,5 (ix)
   1E34 CB 3F         [ 8]  712 	srl	a
   1E36 C6 32         [ 7]  713 	add	a, #0x32
   1E38 DD 77 F4      [19]  714 	ld	-12 (ix),a
                            715 ;src/Renderer.c:241: lineHeight = (lineHeight*3)/4;
   1E3B DD 4E 05      [19]  716 	ld	c,5 (ix)
   1E3E 06 00         [ 7]  717 	ld	b,#0x00
   1E40 69            [ 4]  718 	ld	l, c
   1E41 60            [ 4]  719 	ld	h, b
   1E42 29            [11]  720 	add	hl, hl
   1E43 09            [11]  721 	add	hl, bc
   1E44 DD 75 FE      [19]  722 	ld	-2 (ix),l
   1E47 DD 74 FF      [19]  723 	ld	-1 (ix),h
   1E4A DD 7E FE      [19]  724 	ld	a,-2 (ix)
   1E4D DD 77 FC      [19]  725 	ld	-4 (ix),a
   1E50 DD 7E FF      [19]  726 	ld	a,-1 (ix)
   1E53 DD 77 FD      [19]  727 	ld	-3 (ix),a
   1E56 DD CB FF 7E   [20]  728 	bit	7, -1 (ix)
   1E5A 28 10         [12]  729 	jr	Z,00114$
   1E5C DD 7E FE      [19]  730 	ld	a,-2 (ix)
   1E5F C6 03         [ 7]  731 	add	a, #0x03
   1E61 DD 77 FC      [19]  732 	ld	-4 (ix),a
   1E64 DD 7E FF      [19]  733 	ld	a,-1 (ix)
   1E67 CE 00         [ 7]  734 	adc	a, #0x00
   1E69 DD 77 FD      [19]  735 	ld	-3 (ix),a
   1E6C                     736 00114$:
   1E6C DD 46 FC      [19]  737 	ld	b,-4 (ix)
   1E6F DD 4E FD      [19]  738 	ld	c,-3 (ix)
   1E72 CB 29         [ 8]  739 	sra	c
   1E74 CB 18         [ 8]  740 	rr	b
   1E76 CB 29         [ 8]  741 	sra	c
   1E78 CB 18         [ 8]  742 	rr	b
                            743 ;src/Renderer.c:242: enemy_top_height = ground_height - lineHeight;
   1E7A DD 7E F4      [19]  744 	ld	a,-12 (ix)
   1E7D 90            [ 4]  745 	sub	a, b
   1E7E 4F            [ 4]  746 	ld	c,a
                            747 ;src/Renderer.c:244: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
   1E7F 58            [ 4]  748 	ld	e,b
   1E80 16 00         [ 7]  749 	ld	d,#0x00
   1E82 C5            [11]  750 	push	bc
   1E83 D5            [11]  751 	push	de
   1E84 21 00 18      [10]  752 	ld	hl,#0x1800
   1E87 E5            [11]  753 	push	hl
   1E88 CD E8 85      [17]  754 	call	__divsint
   1E8B F1            [10]  755 	pop	af
   1E8C F1            [10]  756 	pop	af
   1E8D C1            [10]  757 	pop	bc
   1E8E DD 75 F5      [19]  758 	ld	-11 (ix),l
   1E91 DD 74 F6      [19]  759 	ld	-10 (ix),h
                            760 ;src/Renderer.c:245: j=lineHeight;
   1E94 50            [ 4]  761 	ld	d,b
                            762 ;src/Renderer.c:247: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   1E95 3E 64         [ 7]  763 	ld	a,#0x64
   1E97 90            [ 4]  764 	sub	a, b
   1E98 30 02         [12]  765 	jr	NC,00102$
                            766 ;src/Renderer.c:248: j=90;
   1E9A 16 5A         [ 7]  767 	ld	d,#0x5A
   1E9C                     768 00102$:
                            769 ;src/Renderer.c:251: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
   1E9C 06 00         [ 7]  770 	ld	b,#0x00
   1E9E 69            [ 4]  771 	ld	l, c
   1E9F 60            [ 4]  772 	ld	h, b
   1EA0 29            [11]  773 	add	hl, hl
   1EA1 29            [11]  774 	add	hl, hl
   1EA2 09            [11]  775 	add	hl, bc
   1EA3 29            [11]  776 	add	hl, hl
   1EA4 29            [11]  777 	add	hl, hl
   1EA5 29            [11]  778 	add	hl, hl
   1EA6 DD 7E FA      [19]  779 	ld	a,-6 (ix)
   1EA9 85            [ 4]  780 	add	a, l
   1EAA 4F            [ 4]  781 	ld	c,a
   1EAB DD 7E FB      [19]  782 	ld	a,-5 (ix)
   1EAE 8C            [ 4]  783 	adc	a, h
   1EAF 47            [ 4]  784 	ld	b,a
                            785 ;src/Renderer.c:253: for(j;j;--j){
   1EB0 DD 7E F9      [19]  786 	ld	a,-7 (ix)
   1EB3 2F            [ 4]  787 	cpl
   1EB4 5F            [ 4]  788 	ld	e,a
   1EB5                     789 00110$:
   1EB5 7A            [ 4]  790 	ld	a,d
   1EB6 B7            [ 4]  791 	or	a, a
   1EB7 28 3C         [12]  792 	jr	Z,00112$
                            793 ;src/Renderer.c:255: color= *(texture+(texture_line/256));
   1EB9 DD 6E F8      [19]  794 	ld	l,-8 (ix)
   1EBC 26 00         [ 7]  795 	ld	h,#0x00
   1EBE DD 7E F2      [19]  796 	ld	a,-14 (ix)
   1EC1 85            [ 4]  797 	add	a, l
   1EC2 6F            [ 4]  798 	ld	l,a
   1EC3 DD 7E F3      [19]  799 	ld	a,-13 (ix)
   1EC6 8C            [ 4]  800 	adc	a, h
   1EC7 67            [ 4]  801 	ld	h,a
   1EC8 7E            [ 7]  802 	ld	a,(hl)
                            803 ;src/Renderer.c:257: if(color){
   1EC9 DD 77 FC      [19]  804 	ld	-4 (ix), a
   1ECC B7            [ 4]  805 	or	a, a
   1ECD 28 0B         [12]  806 	jr	Z,00104$
                            807 ;src/Renderer.c:258: val =  ((*pvmem)&(~pixMask));
   1ECF 0A            [ 7]  808 	ld	a,(bc)
   1ED0 A3            [ 4]  809 	and	a, e
   1ED1 6F            [ 4]  810 	ld	l,a
                            811 ;src/Renderer.c:260: color = (color&pixMask);
   1ED2 DD 7E FC      [19]  812 	ld	a,-4 (ix)
   1ED5 DD A6 F9      [19]  813 	and	a, -7 (ix)
                            814 ;src/Renderer.c:262: *pvmem = val|color;
   1ED8 B5            [ 4]  815 	or	a, l
   1ED9 02            [ 7]  816 	ld	(bc),a
   1EDA                     817 00104$:
                            818 ;src/Renderer.c:265: texture_line += texture_line_add;
   1EDA DD 7E F7      [19]  819 	ld	a,-9 (ix)
   1EDD DD 86 F5      [19]  820 	add	a, -11 (ix)
   1EE0 DD 77 F7      [19]  821 	ld	-9 (ix),a
   1EE3 DD 7E F8      [19]  822 	ld	a,-8 (ix)
   1EE6 DD 8E F6      [19]  823 	adc	a, -10 (ix)
   1EE9 DD 77 F8      [19]  824 	ld	-8 (ix),a
                            825 ;src/Renderer.c:267: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   1EEC 21 28 00      [10]  826 	ld	hl,#0x0028
   1EEF 09            [11]  827 	add	hl,bc
   1EF0 4D            [ 4]  828 	ld	c,l
   1EF1 44            [ 4]  829 	ld	b,h
                            830 ;src/Renderer.c:253: for(j;j;--j){
   1EF2 15            [ 4]  831 	dec	d
   1EF3 18 C0         [12]  832 	jr	00110$
   1EF5                     833 00112$:
   1EF5 DD F9         [10]  834 	ld	sp, ix
   1EF7 DD E1         [14]  835 	pop	ix
   1EF9 C9            [10]  836 	ret
                            837 ;src/Renderer.c:359: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
                            838 ;	---------------------------------
                            839 ; Function draw_column_to_buffer
                            840 ; ---------------------------------
   1EFA                     841 _draw_column_to_buffer::
   1EFA DD E5         [15]  842 	push	ix
   1EFC DD 21 00 00   [14]  843 	ld	ix,#0
   1F00 DD 39         [15]  844 	add	ix,sp
   1F02 21 F1 FF      [10]  845 	ld	hl,#-15
   1F05 39            [11]  846 	add	hl,sp
   1F06 F9            [ 6]  847 	ld	sp,hl
                            848 ;src/Renderer.c:360: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1F07 DD 7E 04      [19]  849 	ld	a,4 (ix)
   1F0A CB 3F         [ 8]  850 	srl	a
   1F0C C6 50         [ 7]  851 	add	a, #0x50
   1F0E DD 77 FA      [19]  852 	ld	-6 (ix),a
   1F11 3E 00         [ 7]  853 	ld	a,#0x00
   1F13 CE AA         [ 7]  854 	adc	a, #0xAA
   1F15 DD 77 FB      [19]  855 	ld	-5 (ix),a
                            856 ;src/Renderer.c:363: u8 pixMask = g_pixelMask[column&1];
   1F18 01 38 1C      [10]  857 	ld	bc,#_g_pixelMask+0
   1F1B DD 7E 04      [19]  858 	ld	a,4 (ix)
   1F1E E6 01         [ 7]  859 	and	a, #0x01
   1F20 6F            [ 4]  860 	ld	l, a
   1F21 26 00         [ 7]  861 	ld	h,#0x00
   1F23 09            [11]  862 	add	hl,bc
   1F24 7E            [ 7]  863 	ld	a,(hl)
   1F25 DD 77 F3      [19]  864 	ld	-13 (ix),a
                            865 ;src/Renderer.c:368: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
   1F28 DD 7E 06      [19]  866 	ld	a, 6 (ix)
   1F2B 87            [ 4]  867 	add	a, a
   1F2C 87            [ 4]  868 	add	a, a
   1F2D 47            [ 4]  869 	ld	b,a
   1F2E 0E 00         [ 7]  870 	ld	c,#0x00
   1F30 21 D0 8C      [10]  871 	ld	hl,#0x8CD0
   1F33 09            [11]  872 	add	hl,bc
   1F34 4D            [ 4]  873 	ld	c,l
   1F35 44            [ 4]  874 	ld	b,h
   1F36 DD 6E 07      [19]  875 	ld	l,7 (ix)
   1F39 26 00         [ 7]  876 	ld	h,#0x00
   1F3B 29            [11]  877 	add	hl, hl
   1F3C 29            [11]  878 	add	hl, hl
   1F3D 29            [11]  879 	add	hl, hl
   1F3E 29            [11]  880 	add	hl, hl
   1F3F 29            [11]  881 	add	hl, hl
   1F40 09            [11]  882 	add	hl,bc
   1F41 DD 75 F6      [19]  883 	ld	-10 (ix),l
   1F44 DD 74 F7      [19]  884 	ld	-9 (ix),h
                            885 ;src/Renderer.c:370: u8 j=lineHeight;
   1F47 DD 7E 05      [19]  886 	ld	a,5 (ix)
                            887 ;src/Renderer.c:376: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
   1F4A DD 77 F5      [19]  888 	ld	-11 (ix), a
   1F4D DD 77 FE      [19]  889 	ld	-2 (ix),a
   1F50 DD 36 FF 00   [19]  890 	ld	-1 (ix),#0x00
   1F54 DD 6E FE      [19]  891 	ld	l,-2 (ix)
   1F57 DD 66 FF      [19]  892 	ld	h,-1 (ix)
   1F5A E5            [11]  893 	push	hl
   1F5B 21 00 20      [10]  894 	ld	hl,#0x2000
   1F5E E5            [11]  895 	push	hl
   1F5F CD E8 85      [17]  896 	call	__divsint
   1F62 F1            [10]  897 	pop	af
   1F63 F1            [10]  898 	pop	af
   1F64 DD 75 F8      [19]  899 	ld	-8 (ix),l
   1F67 DD 74 F9      [19]  900 	ld	-7 (ix),h
                            901 ;src/Renderer.c:377: u16 wall_texture_line=0;
   1F6A 21 00 00      [10]  902 	ld	hl,#0x0000
   1F6D E3            [19]  903 	ex	(sp), hl
                            904 ;src/Renderer.c:379: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   1F6E DD 4E F5      [19]  905 	ld	c,-11 (ix)
   1F71 CB 39         [ 8]  906 	srl	c
   1F73 3E 32         [ 7]  907 	ld	a,#0x32
   1F75 91            [ 4]  908 	sub	a, c
   1F76 DD 77 F4      [19]  909 	ld	-12 (ix),a
                            910 ;src/Renderer.c:383: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   1F79 3E 64         [ 7]  911 	ld	a,#0x64
   1F7B DD 96 F5      [19]  912 	sub	a, -11 (ix)
   1F7E 30 48         [12]  913 	jr	NC,00102$
                            914 ;src/Renderer.c:384: ceiling_height=0;
   1F80 DD 36 F4 00   [19]  915 	ld	-12 (ix),#0x00
                            916 ;src/Renderer.c:385: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
   1F84 DD 7E FE      [19]  917 	ld	a,-2 (ix)
   1F87 C6 9C         [ 7]  918 	add	a,#0x9C
   1F89 4F            [ 4]  919 	ld	c,a
   1F8A DD 7E FF      [19]  920 	ld	a,-1 (ix)
   1F8D CE FF         [ 7]  921 	adc	a,#0xFF
   1F8F 47            [ 4]  922 	ld	b,a
   1F90 DD 71 FC      [19]  923 	ld	-4 (ix),c
   1F93 DD 70 FD      [19]  924 	ld	-3 (ix),b
   1F96 CB 78         [ 8]  925 	bit	7, b
   1F98 28 10         [12]  926 	jr	Z,00111$
   1F9A DD 7E FE      [19]  927 	ld	a,-2 (ix)
   1F9D C6 9D         [ 7]  928 	add	a, #0x9D
   1F9F DD 77 FC      [19]  929 	ld	-4 (ix),a
   1FA2 DD 7E FF      [19]  930 	ld	a,-1 (ix)
   1FA5 CE FF         [ 7]  931 	adc	a, #0xFF
   1FA7 DD 77 FD      [19]  932 	ld	-3 (ix),a
   1FAA                     933 00111$:
   1FAA DD 4E FC      [19]  934 	ld	c,-4 (ix)
   1FAD DD 46 FD      [19]  935 	ld	b,-3 (ix)
   1FB0 CB 28         [ 8]  936 	sra	b
   1FB2 CB 19         [ 8]  937 	rr	c
   1FB4 DD 6E F8      [19]  938 	ld	l,-8 (ix)
   1FB7 DD 66 F9      [19]  939 	ld	h,-7 (ix)
   1FBA E5            [11]  940 	push	hl
   1FBB C5            [11]  941 	push	bc
   1FBC CD E4 83      [17]  942 	call	__mulint
   1FBF F1            [10]  943 	pop	af
   1FC0 F1            [10]  944 	pop	af
   1FC1 33            [ 6]  945 	inc	sp
   1FC2 33            [ 6]  946 	inc	sp
   1FC3 E5            [11]  947 	push	hl
                            948 ;src/Renderer.c:386: j=SCREEN_TEXTURE_HEIGHT;
   1FC4 DD 36 F5 64   [19]  949 	ld	-11 (ix),#0x64
   1FC8                     950 00102$:
                            951 ;src/Renderer.c:389: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
   1FC8 DD 4E F4      [19]  952 	ld	c,-12 (ix)
   1FCB 06 00         [ 7]  953 	ld	b,#0x00
   1FCD 69            [ 4]  954 	ld	l, c
   1FCE 60            [ 4]  955 	ld	h, b
   1FCF 29            [11]  956 	add	hl, hl
   1FD0 29            [11]  957 	add	hl, hl
   1FD1 09            [11]  958 	add	hl, bc
   1FD2 29            [11]  959 	add	hl, hl
   1FD3 29            [11]  960 	add	hl, hl
   1FD4 29            [11]  961 	add	hl, hl
   1FD5 DD 7E FA      [19]  962 	ld	a,-6 (ix)
   1FD8 85            [ 4]  963 	add	a, l
   1FD9 4F            [ 4]  964 	ld	c,a
   1FDA DD 7E FB      [19]  965 	ld	a,-5 (ix)
   1FDD 8C            [ 4]  966 	adc	a, h
   1FDE 47            [ 4]  967 	ld	b,a
                            968 ;src/Renderer.c:391: for(j;j;--j){
   1FDF DD 7E F3      [19]  969 	ld	a,-13 (ix)
   1FE2 2F            [ 4]  970 	cpl
   1FE3 DD 77 FC      [19]  971 	ld	-4 (ix),a
   1FE6 DD 56 F5      [19]  972 	ld	d,-11 (ix)
   1FE9                     973 00107$:
   1FE9 7A            [ 4]  974 	ld	a,d
   1FEA B7            [ 4]  975 	or	a, a
   1FEB 28 39         [12]  976 	jr	Z,00109$
                            977 ;src/Renderer.c:393: w_color = *(texture+(wall_texture_line/256));
   1FED DD 7E F2      [19]  978 	ld	a, -14 (ix)
   1FF0 26 00         [ 7]  979 	ld	h, #0x00
   1FF2 DD 86 F6      [19]  980 	add	a, -10 (ix)
   1FF5 6F            [ 4]  981 	ld	l,a
   1FF6 7C            [ 4]  982 	ld	a,h
   1FF7 DD 8E F7      [19]  983 	adc	a, -9 (ix)
   1FFA 67            [ 4]  984 	ld	h,a
   1FFB 5E            [ 7]  985 	ld	e,(hl)
                            986 ;src/Renderer.c:395: if(w_color){
   1FFC 7B            [ 4]  987 	ld	a,e
   1FFD B7            [ 4]  988 	or	a, a
   1FFE 28 0B         [12]  989 	jr	Z,00104$
                            990 ;src/Renderer.c:397: val =  ((*pvmem)&(~pixMask));
   2000 0A            [ 7]  991 	ld	a,(bc)
   2001 DD A6 FC      [19]  992 	and	a, -4 (ix)
   2004 6F            [ 4]  993 	ld	l,a
                            994 ;src/Renderer.c:399: w_color = (w_color&pixMask);
   2005 7B            [ 4]  995 	ld	a,e
   2006 DD A6 F3      [19]  996 	and	a, -13 (ix)
                            997 ;src/Renderer.c:401: *pvmem = val|w_color;
   2009 B5            [ 4]  998 	or	a, l
   200A 02            [ 7]  999 	ld	(bc),a
   200B                    1000 00104$:
                           1001 ;src/Renderer.c:405: wall_texture_line += wall_texture_line_add;
   200B DD 7E F1      [19] 1002 	ld	a,-15 (ix)
   200E DD 86 F8      [19] 1003 	add	a, -8 (ix)
   2011 DD 77 F1      [19] 1004 	ld	-15 (ix),a
   2014 DD 7E F2      [19] 1005 	ld	a,-14 (ix)
   2017 DD 8E F9      [19] 1006 	adc	a, -7 (ix)
   201A DD 77 F2      [19] 1007 	ld	-14 (ix),a
                           1008 ;src/Renderer.c:407: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   201D 21 28 00      [10] 1009 	ld	hl,#0x0028
   2020 09            [11] 1010 	add	hl,bc
   2021 4D            [ 4] 1011 	ld	c,l
   2022 44            [ 4] 1012 	ld	b,h
                           1013 ;src/Renderer.c:391: for(j;j;--j){
   2023 15            [ 4] 1014 	dec	d
   2024 18 C3         [12] 1015 	jr	00107$
   2026                    1016 00109$:
   2026 DD F9         [10] 1017 	ld	sp, ix
   2028 DD E1         [14] 1018 	pop	ix
   202A C9            [10] 1019 	ret
                           1020 ;src/Renderer.c:411: void render_draw_to_buffer(){//TODO Optimize
                           1021 ;	---------------------------------
                           1022 ; Function render_draw_to_buffer
                           1023 ; ---------------------------------
   202B                    1024 _render_draw_to_buffer::
   202B DD E5         [15] 1025 	push	ix
   202D DD 21 00 00   [14] 1026 	ld	ix,#0
   2031 DD 39         [15] 1027 	add	ix,sp
   2033 21 C6 FF      [10] 1028 	ld	hl,#-58
   2036 39            [11] 1029 	add	hl,sp
   2037 F9            [ 6] 1030 	ld	sp,hl
                           1031 ;src/Renderer.c:423: u8 zHeight = 5;
   2038 DD 36 D2 05   [19] 1032 	ld	-46 (ix),#0x05
                           1033 ;src/Renderer.c:433: u8 offsetDiff = 16;
   203C DD 36 CF 10   [19] 1034 	ld	-49 (ix),#0x10
                           1035 ;src/Renderer.c:438: u8 lineStart = 0;
   2040 DD 36 C7 00   [19] 1036 	ld	-57 (ix),#0x00
                           1037 ;src/Renderer.c:440: u8 lateralWallWidth=0;
   2044 DD 36 CE 00   [19] 1038 	ld	-50 (ix),#0x00
                           1039 ;src/Renderer.c:452: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   2048 21 2F 1C      [10] 1040 	ld	hl, #_g_colors + 7
   204B 46            [ 7] 1041 	ld	b,(hl)
   204C 21 A8 07      [10] 1042 	ld	hl,#0x07A8
   204F E5            [11] 1043 	push	hl
   2050 C5            [11] 1044 	push	bc
   2051 33            [ 6] 1045 	inc	sp
   2052 21 50 AA      [10] 1046 	ld	hl,#0xAA50
   2055 E5            [11] 1047 	push	hl
   2056 CD 11 85      [17] 1048 	call	_cpct_memset
                           1049 ;src/Renderer.c:453: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
   2059 21 29 1C      [10] 1050 	ld	hl, #_g_colors + 1
   205C 46            [ 7] 1051 	ld	b,(hl)
   205D 21 50 00      [10] 1052 	ld	hl,#0x0050
   2060 E5            [11] 1053 	push	hl
   2061 C5            [11] 1054 	push	bc
   2062 33            [ 6] 1055 	inc	sp
   2063 21 F8 B1      [10] 1056 	ld	hl,#0xB1F8
   2066 E5            [11] 1057 	push	hl
   2067 CD 11 85      [17] 1058 	call	_cpct_memset
                           1059 ;src/Renderer.c:454: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   206A 21 30 1C      [10] 1060 	ld	hl, #_g_colors + 8
   206D 46            [ 7] 1061 	ld	b,(hl)
   206E 21 A8 07      [10] 1062 	ld	hl,#0x07A8
   2071 E5            [11] 1063 	push	hl
   2072 C5            [11] 1064 	push	bc
   2073 33            [ 6] 1065 	inc	sp
   2074 21 48 B2      [10] 1066 	ld	hl,#0xB248
   2077 E5            [11] 1067 	push	hl
   2078 CD 11 85      [17] 1068 	call	_cpct_memset
                           1069 ;src/Renderer.c:456: calculate_cells_in_view();
   207B CD 67 1A      [17] 1070 	call	_calculate_cells_in_view
                           1071 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   207E 2A 3A 1C      [16] 1072 	ld	hl,(_cells_in_view_array)
   2081 DD 75 E7      [19] 1073 	ld	-25 (ix),l
   2084 DD 74 E8      [19] 1074 	ld	-24 (ix),h
                           1075 ;src/Renderer.c:458: if(textures_on){
   2087 3A D8 86      [13] 1076 	ld	a,(#_textures_on + 0)
   208A B7            [ 4] 1077 	or	a, a
   208B CA 09 26      [10] 1078 	jp	Z,00370$
                           1079 ;src/Renderer.c:460: do{
   208E DD 36 CA 06   [19] 1080 	ld	-54 (ix),#0x06
   2092                    1081 00179$:
                           1082 ;src/Renderer.c:462: --z;
   2092 DD 35 CA      [23] 1083 	dec	-54 (ix)
                           1084 ;src/Renderer.c:466: xCellCount = (z) ? (zHeight >> 1) : 0;
   2095 DD 7E D2      [19] 1085 	ld	a,-46 (ix)
   2098 CB 3F         [ 8] 1086 	srl	a
   209A DD 77 EB      [19] 1087 	ld	-21 (ix),a
   209D DD 7E CA      [19] 1088 	ld	a,-54 (ix)
   20A0 B7            [ 4] 1089 	or	a, a
   20A1 28 05         [12] 1090 	jr	Z,00270$
   20A3 DD 4E EB      [19] 1091 	ld	c,-21 (ix)
   20A6 18 02         [12] 1092 	jr	00271$
   20A8                    1093 00270$:
   20A8 0E 00         [ 7] 1094 	ld	c,#0x00
   20AA                    1095 00271$:
   20AA DD 71 EE      [19] 1096 	ld	-18 (ix),c
                           1097 ;src/Renderer.c:467: lateralWallSlope=0;
   20AD DD 36 F0 00   [19] 1098 	ld	-16 (ix),#0x00
                           1099 ;src/Renderer.c:468: lateralWallSlopeCounter=0;
   20B1 DD 36 F9 00   [19] 1100 	ld	-7 (ix),#0x00
                           1101 ;src/Renderer.c:469: xHeight=0;
   20B5 DD 36 DA 00   [19] 1102 	ld	-38 (ix),#0x00
                           1103 ;src/Renderer.c:472: lateralWallCounter = 0;
   20B9 DD 36 D9 00   [19] 1104 	ld	-39 (ix),#0x00
                           1105 ;src/Renderer.c:474: newCell=1;
   20BD DD 36 DC 01   [19] 1106 	ld	-36 (ix),#0x01
                           1107 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   20C1 DD 7E C7      [19] 1108 	ld	a,-57 (ix)
   20C4 DD 77 E3      [19] 1109 	ld	-29 (ix),a
   20C7 DD 36 E4 00   [19] 1110 	ld	-28 (ix),#0x00
   20CB DD 4E E3      [19] 1111 	ld	c,-29 (ix)
   20CE DD 46 E4      [19] 1112 	ld	b,-28 (ix)
   20D1 03            [ 6] 1113 	inc	bc
   20D2 DD 6E E7      [19] 1114 	ld	l,-25 (ix)
   20D5 DD 66 E8      [19] 1115 	ld	h,-24 (ix)
   20D8 09            [11] 1116 	add	hl,bc
   20D9 7E            [ 7] 1117 	ld	a,(hl)
   20DA DD 77 DB      [19] 1118 	ld	-37 (ix),a
                           1119 ;src/Renderer.c:477: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   20DD DD 7E E7      [19] 1120 	ld	a,-25 (ix)
   20E0 DD 86 C7      [19] 1121 	add	a, -57 (ix)
   20E3 6F            [ 4] 1122 	ld	l,a
   20E4 DD 7E E8      [19] 1123 	ld	a,-24 (ix)
   20E7 CE 00         [ 7] 1124 	adc	a, #0x00
   20E9 67            [ 4] 1125 	ld	h,a
   20EA 4E            [ 7] 1126 	ld	c,(hl)
                           1127 ;src/Renderer.c:478: if(lastCellWasWall&CELL_WALL_MASK){
   20EB CB 79         [ 8] 1128 	bit	7, c
   20ED 28 09         [12] 1129 	jr	Z,00102$
                           1130 ;src/Renderer.c:479: lastWallId=lastCellWasWall;
   20EF DD 71 D7      [19] 1131 	ld	-41 (ix),c
                           1132 ;src/Renderer.c:480: lastCellWasWall=1;
   20F2 DD 36 EF 01   [19] 1133 	ld	-17 (ix),#0x01
   20F6 18 08         [12] 1134 	jr	00305$
   20F8                    1135 00102$:
                           1136 ;src/Renderer.c:483: lastCellWasWall=0;
   20F8 DD 36 EF 00   [19] 1137 	ld	-17 (ix),#0x00
                           1138 ;src/Renderer.c:484: lastWallId=CELLTYPE_FLOOR;
   20FC DD 36 D7 00   [19] 1139 	ld	-41 (ix),#0x00
                           1140 ;src/Renderer.c:487: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   2100                    1141 00305$:
   2100 DD 36 D1 00   [19] 1142 	ld	-47 (ix),#0x00
   2104 DD 36 D3 00   [19] 1143 	ld	-45 (ix),#0x00
   2108                    1144 00260$:
                           1145 ;src/Renderer.c:489: if (xCellCount == zHeight)
   2108 DD 7E D2      [19] 1146 	ld	a,-46 (ix)
   210B DD 96 EE      [19] 1147 	sub	a, -18 (ix)
   210E 20 4B         [12] 1148 	jr	NZ,00105$
                           1149 ;src/Renderer.c:491: ++xCell;
   2110 DD 34 D1      [23] 1150 	inc	-47 (ix)
                           1151 ;src/Renderer.c:492: xCellCount = 0;
   2113 DD 36 EE 00   [19] 1152 	ld	-18 (ix),#0x00
                           1153 ;src/Renderer.c:493: newCell=1;
   2117 DD 36 DC 01   [19] 1154 	ld	-36 (ix),#0x01
                           1155 ;src/Renderer.c:494: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   211B DD 7E D1      [19] 1156 	ld	a,-47 (ix)
   211E DD 77 F5      [19] 1157 	ld	-11 (ix),a
   2121 DD 36 F6 00   [19] 1158 	ld	-10 (ix),#0x00
   2125 DD 7E E3      [19] 1159 	ld	a,-29 (ix)
   2128 DD 86 F5      [19] 1160 	add	a, -11 (ix)
   212B DD 77 F5      [19] 1161 	ld	-11 (ix),a
   212E DD 7E E4      [19] 1162 	ld	a,-28 (ix)
   2131 DD 8E F6      [19] 1163 	adc	a, -10 (ix)
   2134 DD 77 F6      [19] 1164 	ld	-10 (ix),a
   2137 DD 34 F5      [23] 1165 	inc	-11 (ix)
   213A 20 03         [12] 1166 	jr	NZ,00632$
   213C DD 34 F6      [23] 1167 	inc	-10 (ix)
   213F                    1168 00632$:
   213F DD 7E E7      [19] 1169 	ld	a,-25 (ix)
   2142 DD 86 F5      [19] 1170 	add	a, -11 (ix)
   2145 DD 77 F5      [19] 1171 	ld	-11 (ix),a
   2148 DD 7E E8      [19] 1172 	ld	a,-24 (ix)
   214B DD 8E F6      [19] 1173 	adc	a, -10 (ix)
   214E DD 77 F6      [19] 1174 	ld	-10 (ix),a
   2151 DD 6E F5      [19] 1175 	ld	l,-11 (ix)
   2154 DD 66 F6      [19] 1176 	ld	h,-10 (ix)
   2157 7E            [ 7] 1177 	ld	a,(hl)
   2158 DD 77 DB      [19] 1178 	ld	-37 (ix),a
   215B                    1179 00105$:
                           1180 ;src/Renderer.c:496: if(!(x%2)){
   215B DD 7E D3      [19] 1181 	ld	a,-45 (ix)
   215E E6 01         [ 7] 1182 	and	a, #0x01
   2160 DD 77 F5      [19] 1183 	ld	-11 (ix),a
                           1184 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   2163 DD 7E DB      [19] 1185 	ld	a,-37 (ix)
   2166 E6 80         [ 7] 1186 	and	a, #0x80
   2168 DD 77 D8      [19] 1187 	ld	-40 (ix),a
                           1188 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   216B DD 7E EE      [19] 1189 	ld	a,-18 (ix)
   216E DD 77 E5      [19] 1190 	ld	-27 (ix),a
   2171 DD 36 E6 00   [19] 1191 	ld	-26 (ix),#0x00
   2175 DD 7E D2      [19] 1192 	ld	a,-46 (ix)
   2178 DD 77 E9      [19] 1193 	ld	-23 (ix),a
                           1194 ;src/Renderer.c:496: if(!(x%2)){
   217B DD 7E F5      [19] 1195 	ld	a,-11 (ix)
   217E B7            [ 4] 1196 	or	a, a
   217F C2 32 22      [10] 1197 	jp	NZ,00118$
                           1198 ;src/Renderer.c:497: if ((lateralWallCounter == 0)||newCell)
   2182 DD 7E D9      [19] 1199 	ld	a,-39 (ix)
   2185 B7            [ 4] 1200 	or	a, a
   2186 28 07         [12] 1201 	jr	Z,00114$
   2188 DD 7E DC      [19] 1202 	ld	a,-36 (ix)
   218B B7            [ 4] 1203 	or	a, a
   218C CA 32 22      [10] 1204 	jp	Z,00118$
   218F                    1205 00114$:
                           1206 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   218F DD 7E D8      [19] 1207 	ld	a,-40 (ix)
   2192 B7            [ 4] 1208 	or	a, a
   2193 28 22         [12] 1209 	jr	Z,00112$
                           1210 ;src/Renderer.c:501: lateralWallCounter = 0;//(zHeight - xCellCount);
   2195 DD 36 D9 00   [19] 1211 	ld	-39 (ix),#0x00
                           1212 ;src/Renderer.c:502: lateralWallSlope = 0;
   2199 DD 36 F0 00   [19] 1213 	ld	-16 (ix),#0x00
                           1214 ;src/Renderer.c:503: xHeight = zHeight;
   219D DD 7E D2      [19] 1215 	ld	a,-46 (ix)
   21A0 DD 77 DA      [19] 1216 	ld	-38 (ix),a
                           1217 ;src/Renderer.c:504: color = currentCellID&0b01111111;
   21A3 DD 7E DB      [19] 1218 	ld	a,-37 (ix)
   21A6 E6 7F         [ 7] 1219 	and	a, #0x7F
   21A8 DD 77 EA      [19] 1220 	ld	-22 (ix),a
                           1221 ;src/Renderer.c:505: lastCellWasWall = 1;
   21AB DD 36 EF 01   [19] 1222 	ld	-17 (ix),#0x01
                           1223 ;src/Renderer.c:506: lastWallId=currentCellID;
   21AF DD 7E DB      [19] 1224 	ld	a,-37 (ix)
   21B2 DD 77 D7      [19] 1225 	ld	-41 (ix),a
   21B5 18 77         [12] 1226 	jr	00113$
   21B7                    1227 00112$:
                           1228 ;src/Renderer.c:509: if(lateralWallCounter==0){//Lateral wall not finished
   21B7 DD 7E D9      [19] 1229 	ld	a,-39 (ix)
   21BA B7            [ 4] 1230 	or	a, a
   21BB 20 71         [12] 1231 	jr	NZ,00113$
                           1232 ;src/Renderer.c:510: if (lastCellWasWall)
   21BD DD 7E EF      [19] 1233 	ld	a,-17 (ix)
   21C0 B7            [ 4] 1234 	or	a, a
   21C1 28 5B         [12] 1235 	jr	Z,00107$
                           1236 ;src/Renderer.c:513: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   21C3 DD 7E CF      [19] 1237 	ld	a,-49 (ix)
   21C6 DD 96 D1      [19] 1238 	sub	a, -47 (ix)
   21C9 87            [ 4] 1239 	add	a, a
   21CA 3C            [ 4] 1240 	inc	a
                           1241 ;src/Renderer.c:514: lateralWallSlopeCounter = lateralWallSlope / 2;
   21CB DD 77 F0      [19] 1242 	ld	-16 (ix), a
   21CE CB 3F         [ 8] 1243 	srl	a
   21D0 DD 77 F9      [19] 1244 	ld	-7 (ix),a
                           1245 ;src/Renderer.c:515: lateralWallCounter = lateralWallSlope * zHeight;
   21D3 DD 5E D2      [19] 1246 	ld	e,-46 (ix)
   21D6 DD 66 F0      [19] 1247 	ld	h,-16 (ix)
   21D9 2E 00         [ 7] 1248 	ld	l, #0x00
   21DB 55            [ 4] 1249 	ld	d, l
   21DC 06 08         [ 7] 1250 	ld	b, #0x08
   21DE                    1251 00633$:
   21DE 29            [11] 1252 	add	hl,hl
   21DF 30 01         [12] 1253 	jr	NC,00634$
   21E1 19            [11] 1254 	add	hl,de
   21E2                    1255 00634$:
   21E2 10 FA         [13] 1256 	djnz	00633$
                           1257 ;src/Renderer.c:516: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   21E4 7D            [ 4] 1258 	ld	a,l
   21E5 E6 FC         [ 7] 1259 	and	a, #0xFC
   21E7 CB C7         [ 8] 1260 	set	0, a
   21E9 CB 3F         [ 8] 1261 	srl	a
   21EB CB 3F         [ 8] 1262 	srl	a
   21ED DD 96 EE      [19] 1263 	sub	a, -18 (ix)
                           1264 ;src/Renderer.c:517: lateralWallWidth=lateralWallCounter;
   21F0 DD 77 D9      [19] 1265 	ld	-39 (ix), a
   21F3 DD 77 CE      [19] 1266 	ld	-50 (ix),a
                           1267 ;src/Renderer.c:518: lastCellWasWall = 0;
   21F6 DD 36 EF 00   [19] 1268 	ld	-17 (ix),#0x00
                           1269 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   21FA DD 6E E5      [19] 1270 	ld	l,-27 (ix)
   21FD DD 66 E6      [19] 1271 	ld	h,-26 (ix)
   2200 29            [11] 1272 	add	hl, hl
   2201 DD 4E F0      [19] 1273 	ld	c,-16 (ix)
   2204 06 00         [ 7] 1274 	ld	b,#0x00
   2206 C5            [11] 1275 	push	bc
   2207 E5            [11] 1276 	push	hl
   2208 CD E8 85      [17] 1277 	call	__divsint
   220B F1            [10] 1278 	pop	af
   220C F1            [10] 1279 	pop	af
   220D DD 7E E9      [19] 1280 	ld	a,-23 (ix)
   2210 95            [ 4] 1281 	sub	a, l
   2211 DD 77 DA      [19] 1282 	ld	-38 (ix),a
                           1283 ;src/Renderer.c:520: color = lastWallId&0b01111111;
   2214 DD 7E D7      [19] 1284 	ld	a,-41 (ix)
   2217 E6 7F         [ 7] 1285 	and	a, #0x7F
   2219 DD 77 EA      [19] 1286 	ld	-22 (ix),a
   221C 18 10         [12] 1287 	jr	00113$
   221E                    1288 00107$:
                           1289 ;src/Renderer.c:524: xHeight = 0;
   221E DD 36 DA 00   [19] 1290 	ld	-38 (ix),#0x00
                           1291 ;src/Renderer.c:525: lastCellWasWall = 0;
   2222 DD 36 EF 00   [19] 1292 	ld	-17 (ix),#0x00
                           1293 ;src/Renderer.c:526: lateralWallSlope=0;
   2226 DD 36 F0 00   [19] 1294 	ld	-16 (ix),#0x00
                           1295 ;src/Renderer.c:527: lastWallId=0;
   222A DD 36 D7 00   [19] 1296 	ld	-41 (ix),#0x00
   222E                    1297 00113$:
                           1298 ;src/Renderer.c:531: newCell=0;
   222E DD 36 DC 00   [19] 1299 	ld	-36 (ix),#0x00
   2232                    1300 00118$:
                           1301 ;src/Renderer.c:534: if (lateralWallCounter > 0)
   2232 DD 7E D9      [19] 1302 	ld	a,-39 (ix)
   2235 B7            [ 4] 1303 	or	a, a
   2236 28 1E         [12] 1304 	jr	Z,00124$
                           1305 ;src/Renderer.c:537: if (lateralWallSlope != 0)
   2238 DD 7E F0      [19] 1306 	ld	a,-16 (ix)
   223B B7            [ 4] 1307 	or	a, a
   223C 28 15         [12] 1308 	jr	Z,00122$
                           1309 ;src/Renderer.c:539: if (lateralWallSlopeCounter == lateralWallSlope)
   223E DD 7E F9      [19] 1310 	ld	a,-7 (ix)
   2241 DD 96 F0      [19] 1311 	sub	a, -16 (ix)
   2244 20 0A         [12] 1312 	jr	NZ,00120$
                           1313 ;src/Renderer.c:541: lateralWallSlopeCounter = 0;
   2246 DD 36 F9 00   [19] 1314 	ld	-7 (ix),#0x00
                           1315 ;src/Renderer.c:542: xHeight -= 2;
   224A DD 35 DA      [23] 1316 	dec	-38 (ix)
   224D DD 35 DA      [23] 1317 	dec	-38 (ix)
   2250                    1318 00120$:
                           1319 ;src/Renderer.c:544: ++lateralWallSlopeCounter;
   2250 DD 34 F9      [23] 1320 	inc	-7 (ix)
   2253                    1321 00122$:
                           1322 ;src/Renderer.c:547: --lateralWallCounter;
   2253 DD 35 D9      [23] 1323 	dec	-39 (ix)
   2256                    1324 00124$:
                           1325 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   2256 DD 7E D2      [19] 1326 	ld	a,-46 (ix)
   2259 DD 77 EC      [19] 1327 	ld	-20 (ix),a
   225C DD 36 ED 00   [19] 1328 	ld	-19 (ix),#0x00
                           1329 ;src/Renderer.c:550: if (!(x%2))
   2260 DD 7E F5      [19] 1330 	ld	a,-11 (ix)
   2263 B7            [ 4] 1331 	or	a, a
   2264 C2 FF 22      [10] 1332 	jp	NZ,00138$
                           1333 ;src/Renderer.c:560: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   2267 DD 46 D3      [19] 1334 	ld	b,-45 (ix)
   226A CB 38         [ 8] 1335 	srl	b
                           1336 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   226C DD 6E E5      [19] 1337 	ld	l,-27 (ix)
   226F DD 66 E6      [19] 1338 	ld	h,-26 (ix)
   2272 29            [11] 1339 	add	hl, hl
   2273 29            [11] 1340 	add	hl, hl
   2274 29            [11] 1341 	add	hl, hl
   2275 29            [11] 1342 	add	hl, hl
   2276 29            [11] 1343 	add	hl, hl
   2277 C5            [11] 1344 	push	bc
   2278 DD 5E EC      [19] 1345 	ld	e,-20 (ix)
   227B DD 56 ED      [19] 1346 	ld	d,-19 (ix)
   227E D5            [11] 1347 	push	de
   227F E5            [11] 1348 	push	hl
   2280 CD E8 85      [17] 1349 	call	__divsint
   2283 F1            [10] 1350 	pop	af
   2284 F1            [10] 1351 	pop	af
   2285 C1            [10] 1352 	pop	bc
   2286 4D            [ 4] 1353 	ld	c,l
                           1354 ;src/Renderer.c:552: if(xHeight > 0){
   2287 DD 7E DA      [19] 1355 	ld	a,-38 (ix)
   228A B7            [ 4] 1356 	or	a, a
   228B 28 3A         [12] 1357 	jr	Z,00129$
                           1358 ;src/Renderer.c:553: if (lateralWallCounter > 0)
   228D DD 7E D9      [19] 1359 	ld	a,-39 (ix)
   2290 B7            [ 4] 1360 	or	a, a
   2291 28 21         [12] 1361 	jr	Z,00126$
                           1362 ;src/Renderer.c:555: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   2293 DD 5E CE      [19] 1363 	ld	e,-50 (ix)
   2296 16 00         [ 7] 1364 	ld	d,#0x00
   2298 DD 6E D9      [19] 1365 	ld	l,-39 (ix)
   229B 26 00         [ 7] 1366 	ld	h,#0x00
   229D 7B            [ 4] 1367 	ld	a,e
   229E 95            [ 4] 1368 	sub	a, l
   229F 6F            [ 4] 1369 	ld	l,a
   22A0 7A            [ 4] 1370 	ld	a,d
   22A1 9C            [ 4] 1371 	sbc	a, h
   22A2 67            [ 4] 1372 	ld	h,a
   22A3 29            [11] 1373 	add	hl, hl
   22A4 29            [11] 1374 	add	hl, hl
   22A5 29            [11] 1375 	add	hl, hl
   22A6 29            [11] 1376 	add	hl, hl
   22A7 29            [11] 1377 	add	hl, hl
   22A8 C5            [11] 1378 	push	bc
   22A9 D5            [11] 1379 	push	de
   22AA E5            [11] 1380 	push	hl
   22AB CD E8 85      [17] 1381 	call	__divsint
   22AE F1            [10] 1382 	pop	af
   22AF F1            [10] 1383 	pop	af
   22B0 55            [ 4] 1384 	ld	d,l
   22B1 C1            [10] 1385 	pop	bc
   22B2 18 01         [12] 1386 	jr	00127$
   22B4                    1387 00126$:
                           1388 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   22B4 51            [ 4] 1389 	ld	d,c
   22B5                    1390 00127$:
                           1391 ;src/Renderer.c:560: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   22B5 C5            [11] 1392 	push	bc
   22B6 D5            [11] 1393 	push	de
   22B7 33            [ 6] 1394 	inc	sp
   22B8 DD 66 EA      [19] 1395 	ld	h,-22 (ix)
   22BB DD 6E DA      [19] 1396 	ld	l,-38 (ix)
   22BE E5            [11] 1397 	push	hl
   22BF C5            [11] 1398 	push	bc
   22C0 33            [ 6] 1399 	inc	sp
   22C1 CD FA 1E      [17] 1400 	call	_draw_column_to_buffer
   22C4 F1            [10] 1401 	pop	af
   22C5 F1            [10] 1402 	pop	af
   22C6 C1            [10] 1403 	pop	bc
   22C7                    1404 00129$:
                           1405 ;src/Renderer.c:562: if(!(currentCellID&CELL_WALL_MASK)){
   22C7 DD 7E D8      [19] 1406 	ld	a,-40 (ix)
   22CA B7            [ 4] 1407 	or	a, a
   22CB 20 32         [12] 1408 	jr	NZ,00138$
                           1409 ;src/Renderer.c:563: if(currentCellID&CELL_ENEMY_MASK){
   22CD DD 7E DB      [19] 1410 	ld	a,-37 (ix)
   22D0 E6 0F         [ 7] 1411 	and	a, #0x0F
   22D2 28 13         [12] 1412 	jr	Z,00133$
                           1413 ;src/Renderer.c:564: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   22D4 79            [ 4] 1414 	ld	a,c
   22D5 F5            [11] 1415 	push	af
   22D6 33            [ 6] 1416 	inc	sp
   22D7 DD 66 DB      [19] 1417 	ld	h,-37 (ix)
   22DA DD 6E D2      [19] 1418 	ld	l,-46 (ix)
   22DD E5            [11] 1419 	push	hl
   22DE C5            [11] 1420 	push	bc
   22DF 33            [ 6] 1421 	inc	sp
   22E0 CD B4 1D      [17] 1422 	call	_draw_column_to_buffer_enemy
   22E3 F1            [10] 1423 	pop	af
   22E4 F1            [10] 1424 	pop	af
   22E5 18 18         [12] 1425 	jr	00138$
   22E7                    1426 00133$:
                           1427 ;src/Renderer.c:566: else if(currentCellID&CELL_ITEM_MASK){
   22E7 DD 7E DB      [19] 1428 	ld	a,-37 (ix)
   22EA E6 70         [ 7] 1429 	and	a, #0x70
   22EC 28 11         [12] 1430 	jr	Z,00138$
                           1431 ;src/Renderer.c:567: draw_column_to_buffer_object(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   22EE 79            [ 4] 1432 	ld	a,c
   22EF F5            [11] 1433 	push	af
   22F0 33            [ 6] 1434 	inc	sp
   22F1 DD 66 DB      [19] 1435 	ld	h,-37 (ix)
   22F4 DD 6E D2      [19] 1436 	ld	l,-46 (ix)
   22F7 E5            [11] 1437 	push	hl
   22F8 C5            [11] 1438 	push	bc
   22F9 33            [ 6] 1439 	inc	sp
   22FA CD B9 1C      [17] 1440 	call	_draw_column_to_buffer_object
   22FD F1            [10] 1441 	pop	af
   22FE F1            [10] 1442 	pop	af
   22FF                    1443 00138$:
                           1444 ;src/Renderer.c:572: ++xCellCount;
   22FF DD 34 EE      [23] 1445 	inc	-18 (ix)
                           1446 ;src/Renderer.c:487: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   2302 DD 34 D3      [23] 1447 	inc	-45 (ix)
                           1448 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   2305 2A 3A 1C      [16] 1449 	ld	hl,(_cells_in_view_array)
   2308 DD 75 E7      [19] 1450 	ld	-25 (ix),l
   230B DD 74 E8      [19] 1451 	ld	-24 (ix),h
                           1452 ;src/Renderer.c:487: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   230E DD 7E D3      [19] 1453 	ld	a,-45 (ix)
   2311 D6 50         [ 7] 1454 	sub	a, #0x50
   2313 DA 08 21      [10] 1455 	jp	C,00260$
                           1456 ;src/Renderer.c:579: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   2316 DD 7E CA      [19] 1457 	ld	a,-54 (ix)
   2319 B7            [ 4] 1458 	or	a, a
   231A 28 05         [12] 1459 	jr	Z,00272$
   231C DD 4E EB      [19] 1460 	ld	c,-21 (ix)
   231F 18 02         [12] 1461 	jr	00273$
   2321                    1462 00272$:
   2321 0E 00         [ 7] 1463 	ld	c,#0x00
   2323                    1464 00273$:
   2323 DD 71 E5      [19] 1465 	ld	-27 (ix),c
                           1466 ;src/Renderer.c:580: lateralWallSlope=0;
   2326 DD 36 D8 00   [19] 1467 	ld	-40 (ix),#0x00
                           1468 ;src/Renderer.c:581: lateralWallSlopeCounter=0;
   232A DD 36 F5 00   [19] 1469 	ld	-11 (ix),#0x00
                           1470 ;src/Renderer.c:582: xHeight=0;
   232E DD 36 EF 00   [19] 1471 	ld	-17 (ix),#0x00
                           1472 ;src/Renderer.c:584: lateralWallCounter = 0;
   2332 DD 36 D7 00   [19] 1473 	ld	-41 (ix),#0x00
                           1474 ;src/Renderer.c:585: lineEnd = lineStart + offsetDiff * 2 + 2;
   2336 DD 7E CF      [19] 1475 	ld	a,-49 (ix)
   2339 87            [ 4] 1476 	add	a, a
   233A 4F            [ 4] 1477 	ld	c,a
   233B DD 7E C7      [19] 1478 	ld	a,-57 (ix)
   233E 81            [ 4] 1479 	add	a, c
   233F DD 77 DB      [19] 1480 	ld	-37 (ix), a
   2342 4F            [ 4] 1481 	ld	c, a
   2343 0C            [ 4] 1482 	inc	c
   2344 0C            [ 4] 1483 	inc	c
                           1484 ;src/Renderer.c:587: newCell=1;
   2345 DD 36 E3 01   [19] 1485 	ld	-29 (ix),#0x01
                           1486 ;src/Renderer.c:588: currentCellID = cells_in_view_array[lineEnd - 1];
   2349 DD 71 F1      [19] 1487 	ld	-15 (ix),c
   234C DD 36 F2 00   [19] 1488 	ld	-14 (ix),#0x00
   2350 DD 5E F1      [19] 1489 	ld	e,-15 (ix)
   2353 DD 56 F2      [19] 1490 	ld	d,-14 (ix)
   2356 1B            [ 6] 1491 	dec	de
   2357 DD 6E E7      [19] 1492 	ld	l,-25 (ix)
   235A DD 66 E8      [19] 1493 	ld	h,-24 (ix)
   235D 19            [11] 1494 	add	hl,de
   235E 7E            [ 7] 1495 	ld	a,(hl)
   235F DD 77 DC      [19] 1496 	ld	-36 (ix),a
                           1497 ;src/Renderer.c:590: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   2362 DD 6E E7      [19] 1498 	ld	l,-25 (ix)
   2365 DD 66 E8      [19] 1499 	ld	h,-24 (ix)
   2368 06 00         [ 7] 1500 	ld	b,#0x00
   236A 09            [11] 1501 	add	hl, bc
   236B 4E            [ 7] 1502 	ld	c,(hl)
                           1503 ;src/Renderer.c:591: if(lastCellWasWall&CELL_WALL_MASK){
   236C CB 79         [ 8] 1504 	bit	7, c
   236E 28 09         [12] 1505 	jr	Z,00141$
                           1506 ;src/Renderer.c:592: lastWallId=lastCellWasWall;
   2370 DD 71 D9      [19] 1507 	ld	-39 (ix),c
                           1508 ;src/Renderer.c:593: lastCellWasWall=1;
   2373 DD 36 DA 01   [19] 1509 	ld	-38 (ix),#0x01
   2377 18 08         [12] 1510 	jr	00325$
   2379                    1511 00141$:
                           1512 ;src/Renderer.c:596: lastCellWasWall=0;
   2379 DD 36 DA 00   [19] 1513 	ld	-38 (ix),#0x00
                           1514 ;src/Renderer.c:597: lastWallId=CELLTYPE_FLOOR;
   237D DD 36 D9 00   [19] 1515 	ld	-39 (ix),#0x00
                           1516 ;src/Renderer.c:600: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   2381                    1517 00325$:
   2381 DD 36 D1 00   [19] 1518 	ld	-47 (ix),#0x00
   2385 DD 36 D3 9F   [19] 1519 	ld	-45 (ix),#0x9F
   2389                    1520 00262$:
                           1521 ;src/Renderer.c:603: if (xCellCount == zHeight)
   2389 DD 7E D2      [19] 1522 	ld	a,-46 (ix)
   238C DD 96 E5      [19] 1523 	sub	a, -27 (ix)
   238F 20 50         [12] 1524 	jr	NZ,00144$
                           1525 ;src/Renderer.c:605: ++xCell;
   2391 DD 34 D1      [23] 1526 	inc	-47 (ix)
                           1527 ;src/Renderer.c:606: xCellCount = 0;
   2394 DD 36 E5 00   [19] 1528 	ld	-27 (ix),#0x00
                           1529 ;src/Renderer.c:607: newCell=1;
   2398 DD 36 E3 01   [19] 1530 	ld	-29 (ix),#0x01
                           1531 ;src/Renderer.c:608: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   239C DD 7E D1      [19] 1532 	ld	a,-47 (ix)
   239F DD 77 F3      [19] 1533 	ld	-13 (ix),a
   23A2 DD 36 F4 00   [19] 1534 	ld	-12 (ix),#0x00
   23A6 DD 7E F1      [19] 1535 	ld	a,-15 (ix)
   23A9 DD 96 F3      [19] 1536 	sub	a, -13 (ix)
   23AC DD 77 F3      [19] 1537 	ld	-13 (ix),a
   23AF DD 7E F2      [19] 1538 	ld	a,-14 (ix)
   23B2 DD 9E F4      [19] 1539 	sbc	a, -12 (ix)
   23B5 DD 77 F4      [19] 1540 	ld	-12 (ix),a
   23B8 DD 6E F3      [19] 1541 	ld	l,-13 (ix)
   23BB DD 66 F4      [19] 1542 	ld	h,-12 (ix)
   23BE 2B            [ 6] 1543 	dec	hl
   23BF DD 75 F3      [19] 1544 	ld	-13 (ix),l
   23C2 DD 74 F4      [19] 1545 	ld	-12 (ix),h
   23C5 DD 7E E7      [19] 1546 	ld	a,-25 (ix)
   23C8 DD 86 F3      [19] 1547 	add	a, -13 (ix)
   23CB DD 77 F3      [19] 1548 	ld	-13 (ix),a
   23CE DD 7E E8      [19] 1549 	ld	a,-24 (ix)
   23D1 DD 8E F4      [19] 1550 	adc	a, -12 (ix)
   23D4 DD 77 F4      [19] 1551 	ld	-12 (ix),a
   23D7 DD 6E F3      [19] 1552 	ld	l,-13 (ix)
   23DA DD 66 F4      [19] 1553 	ld	h,-12 (ix)
   23DD 7E            [ 7] 1554 	ld	a,(hl)
   23DE DD 77 DC      [19] 1555 	ld	-36 (ix),a
   23E1                    1556 00144$:
                           1557 ;src/Renderer.c:610: if(!(x%2)){
   23E1 DD 7E D3      [19] 1558 	ld	a,-45 (ix)
   23E4 E6 01         [ 7] 1559 	and	a, #0x01
   23E6 DD 77 F3      [19] 1560 	ld	-13 (ix),a
                           1561 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   23E9 DD 7E DC      [19] 1562 	ld	a,-36 (ix)
   23EC E6 80         [ 7] 1563 	and	a, #0x80
   23EE DD 77 F9      [19] 1564 	ld	-7 (ix),a
                           1565 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   23F1 DD 7E E5      [19] 1566 	ld	a,-27 (ix)
   23F4 DD 77 F7      [19] 1567 	ld	-9 (ix),a
   23F7 DD 36 F8 00   [19] 1568 	ld	-8 (ix),#0x00
                           1569 ;src/Renderer.c:610: if(!(x%2)){
   23FB DD 7E F3      [19] 1570 	ld	a,-13 (ix)
   23FE B7            [ 4] 1571 	or	a, a
   23FF C2 D1 24      [10] 1572 	jp	NZ,00157$
                           1573 ;src/Renderer.c:611: if (lateralWallCounter == 0 || newCell)
   2402 DD 7E D7      [19] 1574 	ld	a,-41 (ix)
   2405 B7            [ 4] 1575 	or	a, a
   2406 28 07         [12] 1576 	jr	Z,00153$
   2408 DD 7E E3      [19] 1577 	ld	a,-29 (ix)
   240B B7            [ 4] 1578 	or	a, a
   240C CA D1 24      [10] 1579 	jp	Z,00157$
   240F                    1580 00153$:
                           1581 ;src/Renderer.c:613: if ( currentCellID & CELL_WALL_MASK)//Wall
   240F DD 7E F9      [19] 1582 	ld	a,-7 (ix)
   2412 B7            [ 4] 1583 	or	a, a
   2413 28 23         [12] 1584 	jr	Z,00151$
                           1585 ;src/Renderer.c:615: lateralWallCounter = 0;
   2415 DD 36 D7 00   [19] 1586 	ld	-41 (ix),#0x00
                           1587 ;src/Renderer.c:616: lateralWallSlope = 0;
   2419 DD 36 D8 00   [19] 1588 	ld	-40 (ix),#0x00
                           1589 ;src/Renderer.c:617: xHeight = zHeight;
   241D DD 7E D2      [19] 1590 	ld	a,-46 (ix)
   2420 DD 77 EF      [19] 1591 	ld	-17 (ix),a
                           1592 ;src/Renderer.c:618: color = currentCellID&0b01111111;
   2423 DD 7E DC      [19] 1593 	ld	a,-36 (ix)
   2426 E6 7F         [ 7] 1594 	and	a, #0x7F
   2428 DD 77 EA      [19] 1595 	ld	-22 (ix),a
                           1596 ;src/Renderer.c:619: lastCellWasWall = 1;
   242B DD 36 DA 01   [19] 1597 	ld	-38 (ix),#0x01
                           1598 ;src/Renderer.c:620: lastWallId=currentCellID;
   242F DD 7E DC      [19] 1599 	ld	a,-36 (ix)
   2432 DD 77 D9      [19] 1600 	ld	-39 (ix),a
   2435 C3 CD 24      [10] 1601 	jp	00152$
   2438                    1602 00151$:
                           1603 ;src/Renderer.c:622: else if(lateralWallCounter==0){
   2438 DD 7E D7      [19] 1604 	ld	a,-41 (ix)
   243B B7            [ 4] 1605 	or	a, a
   243C C2 CD 24      [10] 1606 	jp	NZ,00152$
                           1607 ;src/Renderer.c:623: if (lastCellWasWall)
   243F DD 7E DA      [19] 1608 	ld	a,-38 (ix)
   2442 B7            [ 4] 1609 	or	a, a
   2443 28 78         [12] 1610 	jr	Z,00146$
                           1611 ;src/Renderer.c:626: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   2445 DD 7E CF      [19] 1612 	ld	a,-49 (ix)
   2448 DD 96 D1      [19] 1613 	sub	a, -47 (ix)
   244B 87            [ 4] 1614 	add	a, a
   244C 3C            [ 4] 1615 	inc	a
                           1616 ;src/Renderer.c:627: lateralWallSlopeCounter = lateralWallSlope / 2;
   244D DD 77 D8      [19] 1617 	ld	-40 (ix), a
   2450 CB 3F         [ 8] 1618 	srl	a
   2452 DD 77 F5      [19] 1619 	ld	-11 (ix),a
                           1620 ;src/Renderer.c:628: lateralWallCounter = lateralWallSlope * zHeight;
   2455 DD 5E D2      [19] 1621 	ld	e,-46 (ix)
   2458 DD 66 D8      [19] 1622 	ld	h,-40 (ix)
   245B 2E 00         [ 7] 1623 	ld	l, #0x00
   245D 55            [ 4] 1624 	ld	d, l
   245E 06 08         [ 7] 1625 	ld	b, #0x08
   2460                    1626 00642$:
   2460 29            [11] 1627 	add	hl,hl
   2461 30 01         [12] 1628 	jr	NC,00643$
   2463 19            [11] 1629 	add	hl,de
   2464                    1630 00643$:
   2464 10 FA         [13] 1631 	djnz	00642$
                           1632 ;src/Renderer.c:629: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   2466 4D            [ 4] 1633 	ld	c,l
   2467 06 00         [ 7] 1634 	ld	b,#0x00
   2469 7D            [ 4] 1635 	ld	a,l
   246A E6 03         [ 7] 1636 	and	a, #0x03
   246C 5F            [ 4] 1637 	ld	e,a
   246D 16 00         [ 7] 1638 	ld	d,#0x00
   246F 79            [ 4] 1639 	ld	a,c
   2470 93            [ 4] 1640 	sub	a, e
   2471 4F            [ 4] 1641 	ld	c,a
   2472 78            [ 4] 1642 	ld	a,b
   2473 9A            [ 4] 1643 	sbc	a, d
   2474 47            [ 4] 1644 	ld	b,a
   2475 59            [ 4] 1645 	ld	e, c
   2476 50            [ 4] 1646 	ld	d, b
   2477 13            [ 6] 1647 	inc	de
   2478 6B            [ 4] 1648 	ld	l, e
   2479 62            [ 4] 1649 	ld	h, d
   247A CB 7A         [ 8] 1650 	bit	7, d
   247C 28 04         [12] 1651 	jr	Z,00274$
   247E 21 04 00      [10] 1652 	ld	hl,#0x0004
   2481 09            [11] 1653 	add	hl,bc
   2482                    1654 00274$:
   2482 CB 2C         [ 8] 1655 	sra	h
   2484 CB 1D         [ 8] 1656 	rr	l
   2486 CB 2C         [ 8] 1657 	sra	h
   2488 CB 1D         [ 8] 1658 	rr	l
   248A DD 4E E5      [19] 1659 	ld	c,-27 (ix)
   248D 7D            [ 4] 1660 	ld	a,l
   248E 91            [ 4] 1661 	sub	a, c
                           1662 ;src/Renderer.c:630: lateralWallWidth=lateralWallCounter;
   248F DD 77 D7      [19] 1663 	ld	-41 (ix), a
   2492 DD 77 CE      [19] 1664 	ld	-50 (ix),a
                           1665 ;src/Renderer.c:631: lastCellWasWall = 0;
   2495 DD 36 DA 00   [19] 1666 	ld	-38 (ix),#0x00
                           1667 ;src/Renderer.c:632: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   2499 DD 6E F7      [19] 1668 	ld	l,-9 (ix)
   249C DD 66 F8      [19] 1669 	ld	h,-8 (ix)
   249F 29            [11] 1670 	add	hl, hl
   24A0 DD 4E D8      [19] 1671 	ld	c,-40 (ix)
   24A3 06 00         [ 7] 1672 	ld	b,#0x00
   24A5 C5            [11] 1673 	push	bc
   24A6 E5            [11] 1674 	push	hl
   24A7 CD E8 85      [17] 1675 	call	__divsint
   24AA F1            [10] 1676 	pop	af
   24AB F1            [10] 1677 	pop	af
   24AC DD 7E E9      [19] 1678 	ld	a,-23 (ix)
   24AF 95            [ 4] 1679 	sub	a, l
   24B0 DD 77 EF      [19] 1680 	ld	-17 (ix),a
                           1681 ;src/Renderer.c:633: color = lastWallId&0b01111111;
   24B3 DD 7E D9      [19] 1682 	ld	a,-39 (ix)
   24B6 E6 7F         [ 7] 1683 	and	a, #0x7F
   24B8 DD 77 EA      [19] 1684 	ld	-22 (ix),a
   24BB 18 10         [12] 1685 	jr	00152$
   24BD                    1686 00146$:
                           1687 ;src/Renderer.c:637: xHeight = 0;
   24BD DD 36 EF 00   [19] 1688 	ld	-17 (ix),#0x00
                           1689 ;src/Renderer.c:638: lastCellWasWall = 0;
   24C1 DD 36 DA 00   [19] 1690 	ld	-38 (ix),#0x00
                           1691 ;src/Renderer.c:639: lateralWallSlope=0;
   24C5 DD 36 D8 00   [19] 1692 	ld	-40 (ix),#0x00
                           1693 ;src/Renderer.c:640: lastWallId=0;
   24C9 DD 36 D9 00   [19] 1694 	ld	-39 (ix),#0x00
   24CD                    1695 00152$:
                           1696 ;src/Renderer.c:643: newCell=0;
   24CD DD 36 E3 00   [19] 1697 	ld	-29 (ix),#0x00
   24D1                    1698 00157$:
                           1699 ;src/Renderer.c:648: if (lateralWallCounter > 0)
   24D1 DD 7E D7      [19] 1700 	ld	a,-41 (ix)
   24D4 B7            [ 4] 1701 	or	a, a
   24D5 28 1E         [12] 1702 	jr	Z,00163$
                           1703 ;src/Renderer.c:651: if (lateralWallSlope != 0)
   24D7 DD 7E D8      [19] 1704 	ld	a,-40 (ix)
   24DA B7            [ 4] 1705 	or	a, a
   24DB 28 15         [12] 1706 	jr	Z,00161$
                           1707 ;src/Renderer.c:653: if (lateralWallSlopeCounter == lateralWallSlope)
   24DD DD 7E D8      [19] 1708 	ld	a,-40 (ix)
   24E0 DD 96 F5      [19] 1709 	sub	a, -11 (ix)
   24E3 20 0A         [12] 1710 	jr	NZ,00159$
                           1711 ;src/Renderer.c:655: lateralWallSlopeCounter = 0;
   24E5 DD 36 F5 00   [19] 1712 	ld	-11 (ix),#0x00
                           1713 ;src/Renderer.c:656: xHeight -= 2;
   24E9 DD 35 EF      [23] 1714 	dec	-17 (ix)
   24EC DD 35 EF      [23] 1715 	dec	-17 (ix)
   24EF                    1716 00159$:
                           1717 ;src/Renderer.c:658: ++lateralWallSlopeCounter;
   24EF DD 34 F5      [23] 1718 	inc	-11 (ix)
   24F2                    1719 00161$:
                           1720 ;src/Renderer.c:660: --lateralWallCounter;
   24F2 DD 35 D7      [23] 1721 	dec	-41 (ix)
   24F5                    1722 00163$:
                           1723 ;src/Renderer.c:664: if (!(x%2))
   24F5 DD 7E F3      [19] 1724 	ld	a,-13 (ix)
   24F8 B7            [ 4] 1725 	or	a, a
   24F9 C2 D8 25      [10] 1726 	jp	NZ,00177$
                           1727 ;src/Renderer.c:677: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   24FC DD 7E D3      [19] 1728 	ld	a,-45 (ix)
   24FF CB 3F         [ 8] 1729 	srl	a
   2501 DD 77 F3      [19] 1730 	ld	-13 (ix),a
                           1731 ;src/Renderer.c:674: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   2504 DD 7E EC      [19] 1732 	ld	a,-20 (ix)
   2507 DD 96 F7      [19] 1733 	sub	a, -9 (ix)
   250A DD 77 F7      [19] 1734 	ld	-9 (ix),a
   250D DD 7E ED      [19] 1735 	ld	a,-19 (ix)
   2510 DD 9E F8      [19] 1736 	sbc	a, -8 (ix)
   2513 DD 77 F8      [19] 1737 	ld	-8 (ix),a
   2516 3E 06         [ 7] 1738 	ld	a,#0x05+1
   2518 18 08         [12] 1739 	jr	00647$
   251A                    1740 00646$:
   251A DD CB F7 26   [23] 1741 	sla	-9 (ix)
   251E DD CB F8 16   [23] 1742 	rl	-8 (ix)
   2522                    1743 00647$:
   2522 3D            [ 4] 1744 	dec	a
   2523 20 F5         [12] 1745 	jr	NZ,00646$
   2525 DD 6E EC      [19] 1746 	ld	l,-20 (ix)
   2528 DD 66 ED      [19] 1747 	ld	h,-19 (ix)
   252B E5            [11] 1748 	push	hl
   252C DD 6E F7      [19] 1749 	ld	l,-9 (ix)
   252F DD 66 F8      [19] 1750 	ld	h,-8 (ix)
   2532 E5            [11] 1751 	push	hl
   2533 CD E8 85      [17] 1752 	call	__divsint
   2536 F1            [10] 1753 	pop	af
   2537 F1            [10] 1754 	pop	af
   2538 DD 74 F8      [19] 1755 	ld	-8 (ix),h
   253B DD 75 F7      [19] 1756 	ld	-9 (ix), l
   253E DD 75 F7      [19] 1757 	ld	-9 (ix), l
                           1758 ;src/Renderer.c:667: if(xHeight > 0){
   2541 DD 7E EF      [19] 1759 	ld	a,-17 (ix)
   2544 B7            [ 4] 1760 	or	a, a
   2545 28 55         [12] 1761 	jr	Z,00168$
                           1762 ;src/Renderer.c:669: if (lateralWallCounter > 0)
   2547 DD 7E D7      [19] 1763 	ld	a,-41 (ix)
   254A B7            [ 4] 1764 	or	a, a
   254B 28 39         [12] 1765 	jr	Z,00165$
                           1766 ;src/Renderer.c:671: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   254D DD 7E D7      [19] 1767 	ld	a,-41 (ix)
   2550 DD 77 FA      [19] 1768 	ld	-6 (ix),a
   2553 DD 36 FB 00   [19] 1769 	ld	-5 (ix),#0x00
   2557 3E 06         [ 7] 1770 	ld	a,#0x05+1
   2559 18 08         [12] 1771 	jr	00649$
   255B                    1772 00648$:
   255B DD CB FA 26   [23] 1773 	sla	-6 (ix)
   255F DD CB FB 16   [23] 1774 	rl	-5 (ix)
   2563                    1775 00649$:
   2563 3D            [ 4] 1776 	dec	a
   2564 20 F5         [12] 1777 	jr	NZ,00648$
   2566 DD 7E CE      [19] 1778 	ld	a,-50 (ix)
   2569 DD 77 FC      [19] 1779 	ld	-4 (ix),a
   256C DD 36 FD 00   [19] 1780 	ld	-3 (ix),#0x00
   2570 DD 6E FC      [19] 1781 	ld	l,-4 (ix)
   2573 DD 66 FD      [19] 1782 	ld	h,-3 (ix)
   2576 E5            [11] 1783 	push	hl
   2577 DD 6E FA      [19] 1784 	ld	l,-6 (ix)
   257A DD 66 FB      [19] 1785 	ld	h,-5 (ix)
   257D E5            [11] 1786 	push	hl
   257E CD E8 85      [17] 1787 	call	__divsint
   2581 F1            [10] 1788 	pop	af
   2582 F1            [10] 1789 	pop	af
   2583 45            [ 4] 1790 	ld	b,l
   2584 18 03         [12] 1791 	jr	00166$
   2586                    1792 00165$:
                           1793 ;src/Renderer.c:674: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   2586 DD 46 F7      [19] 1794 	ld	b,-9 (ix)
   2589                    1795 00166$:
                           1796 ;src/Renderer.c:677: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   2589 C5            [11] 1797 	push	bc
   258A 33            [ 6] 1798 	inc	sp
   258B DD 66 EA      [19] 1799 	ld	h,-22 (ix)
   258E DD 6E EF      [19] 1800 	ld	l,-17 (ix)
   2591 E5            [11] 1801 	push	hl
   2592 DD 7E F3      [19] 1802 	ld	a,-13 (ix)
   2595 F5            [11] 1803 	push	af
   2596 33            [ 6] 1804 	inc	sp
   2597 CD FA 1E      [17] 1805 	call	_draw_column_to_buffer
   259A F1            [10] 1806 	pop	af
   259B F1            [10] 1807 	pop	af
   259C                    1808 00168$:
                           1809 ;src/Renderer.c:680: if(!(currentCellID&CELL_WALL_MASK)){
   259C DD 7E F9      [19] 1810 	ld	a,-7 (ix)
   259F B7            [ 4] 1811 	or	a, a
   25A0 20 36         [12] 1812 	jr	NZ,00177$
                           1813 ;src/Renderer.c:681: if(currentCellID&CELL_ENEMY_MASK){
   25A2 DD 7E DC      [19] 1814 	ld	a,-36 (ix)
   25A5 E6 0F         [ 7] 1815 	and	a, #0x0F
   25A7 28 15         [12] 1816 	jr	Z,00172$
                           1817 ;src/Renderer.c:682: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   25A9 DD 66 F7      [19] 1818 	ld	h,-9 (ix)
   25AC DD 6E DC      [19] 1819 	ld	l,-36 (ix)
   25AF E5            [11] 1820 	push	hl
   25B0 DD 66 D2      [19] 1821 	ld	h,-46 (ix)
   25B3 DD 6E F3      [19] 1822 	ld	l,-13 (ix)
   25B6 E5            [11] 1823 	push	hl
   25B7 CD B4 1D      [17] 1824 	call	_draw_column_to_buffer_enemy
   25BA F1            [10] 1825 	pop	af
   25BB F1            [10] 1826 	pop	af
   25BC 18 1A         [12] 1827 	jr	00177$
   25BE                    1828 00172$:
                           1829 ;src/Renderer.c:684: else if(currentCellID&CELL_ITEM_MASK){
   25BE DD 7E DC      [19] 1830 	ld	a,-36 (ix)
   25C1 E6 70         [ 7] 1831 	and	a, #0x70
   25C3 28 13         [12] 1832 	jr	Z,00177$
                           1833 ;src/Renderer.c:685: draw_column_to_buffer_object(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   25C5 DD 66 F7      [19] 1834 	ld	h,-9 (ix)
   25C8 DD 6E DC      [19] 1835 	ld	l,-36 (ix)
   25CB E5            [11] 1836 	push	hl
   25CC DD 66 D2      [19] 1837 	ld	h,-46 (ix)
   25CF DD 6E F3      [19] 1838 	ld	l,-13 (ix)
   25D2 E5            [11] 1839 	push	hl
   25D3 CD B9 1C      [17] 1840 	call	_draw_column_to_buffer_object
   25D6 F1            [10] 1841 	pop	af
   25D7 F1            [10] 1842 	pop	af
   25D8                    1843 00177$:
                           1844 ;src/Renderer.c:689: ++xCellCount;
   25D8 DD 34 E5      [23] 1845 	inc	-27 (ix)
                           1846 ;src/Renderer.c:600: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   25DB DD 35 D3      [23] 1847 	dec	-45 (ix)
                           1848 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   25DE 2A 3A 1C      [16] 1849 	ld	hl,(_cells_in_view_array)
   25E1 DD 75 E7      [19] 1850 	ld	-25 (ix),l
   25E4 DD 74 E8      [19] 1851 	ld	-24 (ix),h
                           1852 ;src/Renderer.c:600: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   25E7 DD 7E D3      [19] 1853 	ld	a,-45 (ix)
   25EA D6 50         [ 7] 1854 	sub	a, #0x50
   25EC D2 89 23      [10] 1855 	jp	NC,00262$
                           1856 ;src/Renderer.c:720: lineStart = lineStart + (offsetDiff * 2) + 3;
   25EF DD 7E DB      [19] 1857 	ld	a,-37 (ix)
   25F2 C6 03         [ 7] 1858 	add	a, #0x03
   25F4 DD 77 C7      [19] 1859 	ld	-57 (ix),a
                           1860 ;src/Renderer.c:721: zHeight += zHeight;
   25F7 DD CB D2 26   [23] 1861 	sla	-46 (ix)
                           1862 ;src/Renderer.c:722: offsetDiff = offsetDiff >> 1;
   25FB DD CB CF 3E   [23] 1863 	srl	-49 (ix)
                           1864 ;src/Renderer.c:724: }while(z);
   25FF DD 7E CA      [19] 1865 	ld	a,-54 (ix)
   2602 B7            [ 4] 1866 	or	a, a
   2603 C2 92 20      [10] 1867 	jp	NZ,00179$
   2606 C3 EC 2B      [10] 1868 	jp	00268$
                           1869 ;src/Renderer.c:729: do{
   2609                    1870 00370$:
   2609 DD 36 CA 06   [19] 1871 	ld	-54 (ix),#0x06
   260D                    1872 00254$:
                           1873 ;src/Renderer.c:731: --z;
   260D DD 35 CA      [23] 1874 	dec	-54 (ix)
                           1875 ;src/Renderer.c:466: xCellCount = (z) ? (zHeight >> 1) : 0;
   2610 DD 7E D2      [19] 1876 	ld	a,-46 (ix)
   2613 CB 3F         [ 8] 1877 	srl	a
   2615 DD 77 FC      [19] 1878 	ld	-4 (ix),a
                           1879 ;src/Renderer.c:735: xCellCount = (z) ? (zHeight >> 1) : 0;
   2618 DD 7E CA      [19] 1880 	ld	a,-54 (ix)
   261B B7            [ 4] 1881 	or	a, a
   261C 28 05         [12] 1882 	jr	Z,00275$
   261E DD 4E FC      [19] 1883 	ld	c,-4 (ix)
   2621 18 02         [12] 1884 	jr	00276$
   2623                    1885 00275$:
   2623 0E 00         [ 7] 1886 	ld	c,#0x00
   2625                    1887 00276$:
   2625 DD 71 CB      [19] 1888 	ld	-53 (ix),c
                           1889 ;src/Renderer.c:736: lateralWallSlope=0;
   2628 DD 36 CC 00   [19] 1890 	ld	-52 (ix),#0x00
                           1891 ;src/Renderer.c:737: lateralWallSlopeCounter=0;
   262C DD 36 D0 00   [19] 1892 	ld	-48 (ix),#0x00
                           1893 ;src/Renderer.c:738: xHeight=0;
   2630 DD 36 C9 00   [19] 1894 	ld	-55 (ix),#0x00
                           1895 ;src/Renderer.c:740: lateralWallCounter = 0;
   2634 DD 36 FA 00   [19] 1896 	ld	-6 (ix),#0x00
                           1897 ;src/Renderer.c:742: newCell=1;
   2638 DD 36 D5 01   [19] 1898 	ld	-43 (ix),#0x01
                           1899 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   263C DD 7E C7      [19] 1900 	ld	a,-57 (ix)
   263F DD 77 F7      [19] 1901 	ld	-9 (ix),a
   2642 DD 36 F8 00   [19] 1902 	ld	-8 (ix),#0x00
                           1903 ;src/Renderer.c:743: currentCellID = cells_in_view_array[lineStart + 1];
   2646 DD 4E F7      [19] 1904 	ld	c,-9 (ix)
   2649 DD 46 F8      [19] 1905 	ld	b,-8 (ix)
   264C 03            [ 6] 1906 	inc	bc
   264D DD 6E E7      [19] 1907 	ld	l,-25 (ix)
   2650 DD 66 E8      [19] 1908 	ld	h,-24 (ix)
   2653 09            [11] 1909 	add	hl,bc
   2654 7E            [ 7] 1910 	ld	a,(hl)
   2655 DD 77 D4      [19] 1911 	ld	-44 (ix),a
                           1912 ;src/Renderer.c:745: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   2658 DD 7E E7      [19] 1913 	ld	a,-25 (ix)
   265B DD 86 C7      [19] 1914 	add	a, -57 (ix)
   265E 6F            [ 4] 1915 	ld	l,a
   265F DD 7E E8      [19] 1916 	ld	a,-24 (ix)
   2662 CE 00         [ 7] 1917 	adc	a, #0x00
   2664 67            [ 4] 1918 	ld	h,a
   2665 4E            [ 7] 1919 	ld	c,(hl)
                           1920 ;src/Renderer.c:746: if(lastCellWasWall&CELL_WALL_MASK){
   2666 CB 79         [ 8] 1921 	bit	7, c
   2668 28 09         [12] 1922 	jr	Z,00183$
                           1923 ;src/Renderer.c:747: lastWallId=lastCellWasWall;
   266A DD 71 D6      [19] 1924 	ld	-42 (ix),c
                           1925 ;src/Renderer.c:748: lastCellWasWall=1;
   266D DD 36 F3 01   [19] 1926 	ld	-13 (ix),#0x01
   2671 18 08         [12] 1927 	jr	00347$
   2673                    1928 00183$:
                           1929 ;src/Renderer.c:751: lastCellWasWall=0;
   2673 DD 36 F3 00   [19] 1930 	ld	-13 (ix),#0x00
                           1931 ;src/Renderer.c:752: lastWallId=CELLTYPE_FLOOR;
   2677 DD 36 D6 00   [19] 1932 	ld	-42 (ix),#0x00
                           1933 ;src/Renderer.c:755: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   267B                    1934 00347$:
   267B DD 36 D1 00   [19] 1935 	ld	-47 (ix),#0x00
   267F DD 36 D3 00   [19] 1936 	ld	-45 (ix),#0x00
   2683                    1937 00264$:
                           1938 ;src/Renderer.c:757: if (xCellCount == zHeight)
   2683 DD 7E CB      [19] 1939 	ld	a,-53 (ix)
   2686 DD 96 D2      [19] 1940 	sub	a, -46 (ix)
   2689 20 4B         [12] 1941 	jr	NZ,00186$
                           1942 ;src/Renderer.c:759: ++xCell;
   268B DD 34 D1      [23] 1943 	inc	-47 (ix)
                           1944 ;src/Renderer.c:760: xCellCount = 0;
   268E DD 36 CB 00   [19] 1945 	ld	-53 (ix),#0x00
                           1946 ;src/Renderer.c:761: newCell=1;
   2692 DD 36 D5 01   [19] 1947 	ld	-43 (ix),#0x01
                           1948 ;src/Renderer.c:762: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   2696 DD 7E D1      [19] 1949 	ld	a,-47 (ix)
   2699 DD 77 F1      [19] 1950 	ld	-15 (ix),a
   269C DD 36 F2 00   [19] 1951 	ld	-14 (ix),#0x00
   26A0 DD 7E F7      [19] 1952 	ld	a,-9 (ix)
   26A3 DD 86 F1      [19] 1953 	add	a, -15 (ix)
   26A6 DD 77 F1      [19] 1954 	ld	-15 (ix),a
   26A9 DD 7E F8      [19] 1955 	ld	a,-8 (ix)
   26AC DD 8E F2      [19] 1956 	adc	a, -14 (ix)
   26AF DD 77 F2      [19] 1957 	ld	-14 (ix),a
   26B2 DD 34 F1      [23] 1958 	inc	-15 (ix)
   26B5 20 03         [12] 1959 	jr	NZ,00655$
   26B7 DD 34 F2      [23] 1960 	inc	-14 (ix)
   26BA                    1961 00655$:
   26BA DD 7E F1      [19] 1962 	ld	a,-15 (ix)
   26BD DD 86 E7      [19] 1963 	add	a, -25 (ix)
   26C0 DD 77 F1      [19] 1964 	ld	-15 (ix),a
   26C3 DD 7E F2      [19] 1965 	ld	a,-14 (ix)
   26C6 DD 8E E8      [19] 1966 	adc	a, -24 (ix)
   26C9 DD 77 F2      [19] 1967 	ld	-14 (ix),a
   26CC DD 6E F1      [19] 1968 	ld	l,-15 (ix)
   26CF DD 66 F2      [19] 1969 	ld	h,-14 (ix)
   26D2 7E            [ 7] 1970 	ld	a,(hl)
   26D3 DD 77 D4      [19] 1971 	ld	-44 (ix),a
   26D6                    1972 00186$:
                           1973 ;src/Renderer.c:764: if(!(x%2)){
   26D6 DD 7E D3      [19] 1974 	ld	a,-45 (ix)
   26D9 E6 01         [ 7] 1975 	and	a, #0x01
   26DB DD 77 F1      [19] 1976 	ld	-15 (ix),a
                           1977 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   26DE DD 7E D4      [19] 1978 	ld	a,-44 (ix)
   26E1 E6 80         [ 7] 1979 	and	a, #0x80
   26E3 DD 77 EC      [19] 1980 	ld	-20 (ix),a
                           1981 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   26E6 DD 7E CB      [19] 1982 	ld	a,-53 (ix)
   26E9 DD 77 E5      [19] 1983 	ld	-27 (ix),a
   26EC DD 36 E6 00   [19] 1984 	ld	-26 (ix),#0x00
   26F0 DD 7E D2      [19] 1985 	ld	a,-46 (ix)
   26F3 DD 77 EA      [19] 1986 	ld	-22 (ix),a
                           1987 ;src/Renderer.c:764: if(!(x%2)){
   26F6 DD 7E F1      [19] 1988 	ld	a,-15 (ix)
   26F9 B7            [ 4] 1989 	or	a, a
   26FA C2 F2 27      [10] 1990 	jp	NZ,00199$
                           1991 ;src/Renderer.c:765: if ((lateralWallCounter == 0)||newCell)
   26FD DD 7E FA      [19] 1992 	ld	a,-6 (ix)
   2700 B7            [ 4] 1993 	or	a, a
   2701 28 07         [12] 1994 	jr	Z,00195$
   2703 DD 7E D5      [19] 1995 	ld	a,-43 (ix)
   2706 B7            [ 4] 1996 	or	a, a
   2707 CA F2 27      [10] 1997 	jp	Z,00199$
   270A                    1998 00195$:
                           1999 ;src/Renderer.c:767: if (currentCellID & CELL_WALL_MASK)//Wall
   270A DD 7E EC      [19] 2000 	ld	a,-20 (ix)
   270D B7            [ 4] 2001 	or	a, a
   270E 28 2B         [12] 2002 	jr	Z,00193$
                           2003 ;src/Renderer.c:769: lateralWallCounter = 0;//(zHeight - xCellCount);
   2710 DD 36 FA 00   [19] 2004 	ld	-6 (ix),#0x00
                           2005 ;src/Renderer.c:770: lateralWallSlope = 0;
   2714 DD 36 CC 00   [19] 2006 	ld	-52 (ix),#0x00
                           2007 ;src/Renderer.c:771: xHeight = zHeight;
   2718 DD 7E D2      [19] 2008 	ld	a,-46 (ix)
   271B DD 77 C9      [19] 2009 	ld	-55 (ix),a
                           2010 ;src/Renderer.c:772: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   271E DD 7E D4      [19] 2011 	ld	a,-44 (ix)
   2721 D6 80         [ 7] 2012 	sub	a, #0x80
   2723 20 04         [12] 2013 	jr	NZ,00277$
   2725 0E 09         [ 7] 2014 	ld	c,#0x09
   2727 18 02         [12] 2015 	jr	00278$
   2729                    2016 00277$:
   2729 0E 0B         [ 7] 2017 	ld	c,#0x0B
   272B                    2018 00278$:
   272B DD 71 C6      [19] 2019 	ld	-58 (ix),c
                           2020 ;src/Renderer.c:773: lastCellWasWall = 1;
   272E DD 36 F3 01   [19] 2021 	ld	-13 (ix),#0x01
                           2022 ;src/Renderer.c:774: lastWallId=currentCellID;
   2732 DD 7E D4      [19] 2023 	ld	a,-44 (ix)
   2735 DD 77 D6      [19] 2024 	ld	-42 (ix),a
   2738 C3 EE 27      [10] 2025 	jp	00194$
   273B                    2026 00193$:
                           2027 ;src/Renderer.c:777: if(lateralWallCounter==0){//Lateral wall not finished
   273B DD 7E FA      [19] 2028 	ld	a,-6 (ix)
   273E B7            [ 4] 2029 	or	a, a
   273F C2 EE 27      [10] 2030 	jp	NZ,00194$
                           2031 ;src/Renderer.c:778: if (lastCellWasWall)
   2742 DD 7E F3      [19] 2032 	ld	a,-13 (ix)
   2745 B7            [ 4] 2033 	or	a, a
   2746 CA DE 27      [10] 2034 	jp	Z,00188$
                           2035 ;src/Renderer.c:781: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   2749 DD 7E CF      [19] 2036 	ld	a,-49 (ix)
   274C DD 96 D1      [19] 2037 	sub	a, -47 (ix)
   274F 87            [ 4] 2038 	add	a, a
   2750 3C            [ 4] 2039 	inc	a
                           2040 ;src/Renderer.c:782: lateralWallSlopeCounter = lateralWallSlope / 2;
   2751 DD 77 CC      [19] 2041 	ld	-52 (ix), a
   2754 CB 3F         [ 8] 2042 	srl	a
   2756 DD 77 D0      [19] 2043 	ld	-48 (ix),a
                           2044 ;src/Renderer.c:783: lateralWallCounter = lateralWallSlope * zHeight;
   2759 DD 5E D2      [19] 2045 	ld	e,-46 (ix)
   275C DD 66 CC      [19] 2046 	ld	h,-52 (ix)
   275F 2E 00         [ 7] 2047 	ld	l, #0x00
   2761 55            [ 4] 2048 	ld	d, l
   2762 06 08         [ 7] 2049 	ld	b, #0x08
   2764                    2050 00658$:
   2764 29            [11] 2051 	add	hl,hl
   2765 30 01         [12] 2052 	jr	NC,00659$
   2767 19            [11] 2053 	add	hl,de
   2768                    2054 00659$:
   2768 10 FA         [13] 2055 	djnz	00658$
   276A DD 75 E9      [19] 2056 	ld	-23 (ix), l
   276D 7D            [ 4] 2057 	ld	a, l
                           2058 ;src/Renderer.c:784: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   276E DD 77 CD      [19] 2059 	ld	-51 (ix), a
   2771 E6 FC         [ 7] 2060 	and	a, #0xFC
   2773 DD 77 E9      [19] 2061 	ld	-23 (ix), a
   2776 CB C7         [ 8] 2062 	set	0, a
   2778 DD 77 E9      [19] 2063 	ld	-23 (ix), a
   277B CB 3F         [ 8] 2064 	srl	a
   277D CB 3F         [ 8] 2065 	srl	a
   277F DD 96 CB      [19] 2066 	sub	a, -53 (ix)
   2782 DD 77 FA      [19] 2067 	ld	-6 (ix),a
                           2068 ;src/Renderer.c:786: lastCellWasWall = 0;
   2785 DD 36 F3 00   [19] 2069 	ld	-13 (ix),#0x00
                           2070 ;src/Renderer.c:787: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   2789 DD 7E E5      [19] 2071 	ld	a,-27 (ix)
   278C DD 77 F5      [19] 2072 	ld	-11 (ix),a
   278F DD 7E E6      [19] 2073 	ld	a,-26 (ix)
   2792 DD 77 F6      [19] 2074 	ld	-10 (ix),a
   2795 DD CB F5 26   [23] 2075 	sla	-11 (ix)
   2799 DD CB F6 16   [23] 2076 	rl	-10 (ix)
   279D DD 7E CC      [19] 2077 	ld	a,-52 (ix)
   27A0 DD 77 E3      [19] 2078 	ld	-29 (ix),a
   27A3 DD 36 E4 00   [19] 2079 	ld	-28 (ix),#0x00
   27A7 DD 6E E3      [19] 2080 	ld	l,-29 (ix)
   27AA DD 66 E4      [19] 2081 	ld	h,-28 (ix)
   27AD E5            [11] 2082 	push	hl
   27AE DD 6E F5      [19] 2083 	ld	l,-11 (ix)
   27B1 DD 66 F6      [19] 2084 	ld	h,-10 (ix)
   27B4 E5            [11] 2085 	push	hl
   27B5 CD E8 85      [17] 2086 	call	__divsint
   27B8 F1            [10] 2087 	pop	af
   27B9 F1            [10] 2088 	pop	af
   27BA DD 74 F6      [19] 2089 	ld	-10 (ix),h
   27BD DD 75 F5      [19] 2090 	ld	-11 (ix), l
   27C0 DD 75 E9      [19] 2091 	ld	-23 (ix), l
   27C3 DD 7E EA      [19] 2092 	ld	a,-22 (ix)
   27C6 DD 96 E9      [19] 2093 	sub	a, -23 (ix)
   27C9 DD 77 C9      [19] 2094 	ld	-55 (ix),a
                           2095 ;src/Renderer.c:788: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   27CC DD 7E D6      [19] 2096 	ld	a,-42 (ix)
   27CF D6 80         [ 7] 2097 	sub	a, #0x80
   27D1 20 04         [12] 2098 	jr	NZ,00279$
   27D3 0E 0A         [ 7] 2099 	ld	c,#0x0A
   27D5 18 02         [12] 2100 	jr	00280$
   27D7                    2101 00279$:
   27D7 0E 0C         [ 7] 2102 	ld	c,#0x0C
   27D9                    2103 00280$:
   27D9 DD 71 C6      [19] 2104 	ld	-58 (ix),c
   27DC 18 10         [12] 2105 	jr	00194$
   27DE                    2106 00188$:
                           2107 ;src/Renderer.c:792: xHeight = 0;
   27DE DD 36 C9 00   [19] 2108 	ld	-55 (ix),#0x00
                           2109 ;src/Renderer.c:793: lastCellWasWall = 0;
   27E2 DD 36 F3 00   [19] 2110 	ld	-13 (ix),#0x00
                           2111 ;src/Renderer.c:794: lateralWallSlope=0;
   27E6 DD 36 CC 00   [19] 2112 	ld	-52 (ix),#0x00
                           2113 ;src/Renderer.c:795: lastWallId=0;
   27EA DD 36 D6 00   [19] 2114 	ld	-42 (ix),#0x00
   27EE                    2115 00194$:
                           2116 ;src/Renderer.c:799: newCell=0;
   27EE DD 36 D5 00   [19] 2117 	ld	-43 (ix),#0x00
   27F2                    2118 00199$:
                           2119 ;src/Renderer.c:802: if (lateralWallCounter > 0)
   27F2 DD 7E FA      [19] 2120 	ld	a,-6 (ix)
   27F5 B7            [ 4] 2121 	or	a, a
   27F6 28 1E         [12] 2122 	jr	Z,00205$
                           2123 ;src/Renderer.c:805: if (lateralWallSlope != 0)
   27F8 DD 7E CC      [19] 2124 	ld	a,-52 (ix)
   27FB B7            [ 4] 2125 	or	a, a
   27FC 28 15         [12] 2126 	jr	Z,00203$
                           2127 ;src/Renderer.c:807: if (lateralWallSlopeCounter == lateralWallSlope)
   27FE DD 7E CC      [19] 2128 	ld	a,-52 (ix)
   2801 DD 96 D0      [19] 2129 	sub	a, -48 (ix)
   2804 20 0A         [12] 2130 	jr	NZ,00201$
                           2131 ;src/Renderer.c:809: lateralWallSlopeCounter = 0;
   2806 DD 36 D0 00   [19] 2132 	ld	-48 (ix),#0x00
                           2133 ;src/Renderer.c:810: xHeight -= 2;
   280A DD 35 C9      [23] 2134 	dec	-55 (ix)
   280D DD 35 C9      [23] 2135 	dec	-55 (ix)
   2810                    2136 00201$:
                           2137 ;src/Renderer.c:812: ++lateralWallSlopeCounter;
   2810 DD 34 D0      [23] 2138 	inc	-48 (ix)
   2813                    2139 00203$:
                           2140 ;src/Renderer.c:815: --lateralWallCounter;
   2813 DD 35 FA      [23] 2141 	dec	-6 (ix)
   2816                    2142 00205$:
                           2143 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   2816 DD 7E D2      [19] 2144 	ld	a,-46 (ix)
   2819 DD 77 F5      [19] 2145 	ld	-11 (ix),a
   281C DD 36 F6 00   [19] 2146 	ld	-10 (ix),#0x00
                           2147 ;src/Renderer.c:818: if (!(x%2))
   2820 DD 7E F1      [19] 2148 	ld	a,-15 (ix)
   2823 B7            [ 4] 2149 	or	a, a
   2824 C2 B7 28      [10] 2150 	jp	NZ,00216$
                           2151 ;src/Renderer.c:821: draw_column_to_buffer_untextured(x/2, xHeight, color);
   2827 DD 7E D3      [19] 2152 	ld	a,-45 (ix)
   282A CB 3F         [ 8] 2153 	srl	a
   282C DD 77 F1      [19] 2154 	ld	-15 (ix),a
                           2155 ;src/Renderer.c:820: if(xHeight > 0){
   282F DD 7E C9      [19] 2156 	ld	a,-55 (ix)
   2832 B7            [ 4] 2157 	or	a, a
   2833 28 11         [12] 2158 	jr	Z,00207$
                           2159 ;src/Renderer.c:821: draw_column_to_buffer_untextured(x/2, xHeight, color);
   2835 DD 66 C6      [19] 2160 	ld	h,-58 (ix)
   2838 DD 6E C9      [19] 2161 	ld	l,-55 (ix)
   283B E5            [11] 2162 	push	hl
   283C DD 7E F1      [19] 2163 	ld	a,-15 (ix)
   283F F5            [11] 2164 	push	af
   2840 33            [ 6] 2165 	inc	sp
   2841 CD 41 1C      [17] 2166 	call	_draw_column_to_buffer_untextured
   2844 F1            [10] 2167 	pop	af
   2845 33            [ 6] 2168 	inc	sp
   2846                    2169 00207$:
                           2170 ;src/Renderer.c:824: if(!(currentCellID&CELL_WALL_MASK)){
   2846 DD 7E EC      [19] 2171 	ld	a,-20 (ix)
   2849 B7            [ 4] 2172 	or	a, a
   284A 20 6B         [12] 2173 	jr	NZ,00216$
                           2174 ;src/Renderer.c:558: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   284C DD 7E E5      [19] 2175 	ld	a,-27 (ix)
   284F DD 77 EC      [19] 2176 	ld	-20 (ix),a
   2852 DD 7E E6      [19] 2177 	ld	a,-26 (ix)
   2855 DD 77 ED      [19] 2178 	ld	-19 (ix),a
   2858 3E 06         [ 7] 2179 	ld	a,#0x05+1
   285A 18 08         [12] 2180 	jr	00667$
   285C                    2181 00666$:
   285C DD CB EC 26   [23] 2182 	sla	-20 (ix)
   2860 DD CB ED 16   [23] 2183 	rl	-19 (ix)
   2864                    2184 00667$:
   2864 3D            [ 4] 2185 	dec	a
   2865 20 F5         [12] 2186 	jr	NZ,00666$
   2867 DD 6E F5      [19] 2187 	ld	l,-11 (ix)
   286A DD 66 F6      [19] 2188 	ld	h,-10 (ix)
   286D E5            [11] 2189 	push	hl
   286E DD 6E EC      [19] 2190 	ld	l,-20 (ix)
   2871 DD 66 ED      [19] 2191 	ld	h,-19 (ix)
   2874 E5            [11] 2192 	push	hl
   2875 CD E8 85      [17] 2193 	call	__divsint
   2878 F1            [10] 2194 	pop	af
   2879 F1            [10] 2195 	pop	af
   287A DD 74 ED      [19] 2196 	ld	-19 (ix),h
   287D DD 75 EC      [19] 2197 	ld	-20 (ix), l
   2880 45            [ 4] 2198 	ld	b, l
                           2199 ;src/Renderer.c:825: if(currentCellID&CELL_ENEMY_MASK){
   2881 DD 7E D4      [19] 2200 	ld	a,-44 (ix)
   2884 E6 0F         [ 7] 2201 	and	a, #0x0F
   2886 28 15         [12] 2202 	jr	Z,00211$
                           2203 ;src/Renderer.c:826: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   2888 C5            [11] 2204 	push	bc
   2889 33            [ 6] 2205 	inc	sp
   288A DD 66 D4      [19] 2206 	ld	h,-44 (ix)
   288D DD 6E D2      [19] 2207 	ld	l,-46 (ix)
   2890 E5            [11] 2208 	push	hl
   2891 DD 7E F1      [19] 2209 	ld	a,-15 (ix)
   2894 F5            [11] 2210 	push	af
   2895 33            [ 6] 2211 	inc	sp
   2896 CD B4 1D      [17] 2212 	call	_draw_column_to_buffer_enemy
   2899 F1            [10] 2213 	pop	af
   289A F1            [10] 2214 	pop	af
   289B 18 1A         [12] 2215 	jr	00216$
   289D                    2216 00211$:
                           2217 ;src/Renderer.c:828: else if(currentCellID&CELL_ITEM_MASK){
   289D DD 7E D4      [19] 2218 	ld	a,-44 (ix)
   28A0 E6 70         [ 7] 2219 	and	a, #0x70
   28A2 28 13         [12] 2220 	jr	Z,00216$
                           2221 ;src/Renderer.c:829: draw_column_to_buffer_object(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   28A4 C5            [11] 2222 	push	bc
   28A5 33            [ 6] 2223 	inc	sp
   28A6 DD 66 D4      [19] 2224 	ld	h,-44 (ix)
   28A9 DD 6E D2      [19] 2225 	ld	l,-46 (ix)
   28AC E5            [11] 2226 	push	hl
   28AD DD 7E F1      [19] 2227 	ld	a,-15 (ix)
   28B0 F5            [11] 2228 	push	af
   28B1 33            [ 6] 2229 	inc	sp
   28B2 CD B9 1C      [17] 2230 	call	_draw_column_to_buffer_object
   28B5 F1            [10] 2231 	pop	af
   28B6 F1            [10] 2232 	pop	af
   28B7                    2233 00216$:
                           2234 ;src/Renderer.c:834: ++xCellCount;
   28B7 DD 34 CB      [23] 2235 	inc	-53 (ix)
                           2236 ;src/Renderer.c:755: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   28BA DD 34 D3      [23] 2237 	inc	-45 (ix)
                           2238 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   28BD 2A 3A 1C      [16] 2239 	ld	hl,(_cells_in_view_array)
   28C0 DD 75 E7      [19] 2240 	ld	-25 (ix),l
   28C3 DD 74 E8      [19] 2241 	ld	-24 (ix),h
                           2242 ;src/Renderer.c:755: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   28C6 DD 7E D3      [19] 2243 	ld	a,-45 (ix)
   28C9 D6 50         [ 7] 2244 	sub	a, #0x50
   28CB DA 83 26      [10] 2245 	jp	C,00264$
                           2246 ;src/Renderer.c:841: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   28CE DD 7E CA      [19] 2247 	ld	a,-54 (ix)
   28D1 B7            [ 4] 2248 	or	a, a
   28D2 28 08         [12] 2249 	jr	Z,00281$
   28D4 DD 7E FC      [19] 2250 	ld	a,-4 (ix)
   28D7 DD 77 FC      [19] 2251 	ld	-4 (ix),a
   28DA 18 04         [12] 2252 	jr	00282$
   28DC                    2253 00281$:
   28DC DD 36 FC 00   [19] 2254 	ld	-4 (ix),#0x00
   28E0                    2255 00282$:
   28E0 DD 7E FC      [19] 2256 	ld	a,-4 (ix)
   28E3 DD 77 FC      [19] 2257 	ld	-4 (ix),a
                           2258 ;src/Renderer.c:842: lateralWallSlope=0;
   28E6 DD 36 FA 00   [19] 2259 	ld	-6 (ix),#0x00
                           2260 ;src/Renderer.c:843: lateralWallSlopeCounter=0;
   28EA DD 36 F7 00   [19] 2261 	ld	-9 (ix),#0x00
                           2262 ;src/Renderer.c:844: xHeight=0;
   28EE DD 36 F3 00   [19] 2263 	ld	-13 (ix),#0x00
                           2264 ;src/Renderer.c:846: lateralWallCounter = 0;
   28F2 DD 36 F1 00   [19] 2265 	ld	-15 (ix),#0x00
                           2266 ;src/Renderer.c:585: lineEnd = lineStart + offsetDiff * 2 + 2;
   28F6 DD 7E CF      [19] 2267 	ld	a,-49 (ix)
   28F9 87            [ 4] 2268 	add	a, a
   28FA DD 77 EC      [19] 2269 	ld	-20 (ix),a
   28FD DD 7E C7      [19] 2270 	ld	a,-57 (ix)
   2900 DD 86 EC      [19] 2271 	add	a, -20 (ix)
                           2272 ;src/Renderer.c:847: lineEnd = lineStart + offsetDiff * 2 + 2;
   2903 DD 77 EC      [19] 2273 	ld	-20 (ix), a
   2906 C6 02         [ 7] 2274 	add	a, #0x02
   2908 DD 77 C8      [19] 2275 	ld	-56 (ix),a
                           2276 ;src/Renderer.c:849: newCell=1;
   290B DD 36 E9 01   [19] 2277 	ld	-23 (ix),#0x01
                           2278 ;src/Renderer.c:588: currentCellID = cells_in_view_array[lineEnd - 1];
   290F DD 7E C8      [19] 2279 	ld	a,-56 (ix)
   2912 DD 77 E5      [19] 2280 	ld	-27 (ix),a
   2915 DD 36 E6 00   [19] 2281 	ld	-26 (ix),#0x00
                           2282 ;src/Renderer.c:850: currentCellID = cells_in_view_array[lineEnd - 1];
   2919 DD 7E E5      [19] 2283 	ld	a,-27 (ix)
   291C C6 FF         [ 7] 2284 	add	a,#0xFF
   291E DD 77 E3      [19] 2285 	ld	-29 (ix),a
   2921 DD 7E E6      [19] 2286 	ld	a,-26 (ix)
   2924 CE FF         [ 7] 2287 	adc	a,#0xFF
   2926 DD 77 E4      [19] 2288 	ld	-28 (ix),a
   2929 DD 7E E7      [19] 2289 	ld	a,-25 (ix)
   292C DD 86 E3      [19] 2290 	add	a, -29 (ix)
   292F DD 77 E3      [19] 2291 	ld	-29 (ix),a
   2932 DD 7E E8      [19] 2292 	ld	a,-24 (ix)
   2935 DD 8E E4      [19] 2293 	adc	a, -28 (ix)
   2938 DD 77 E4      [19] 2294 	ld	-28 (ix),a
   293B DD 6E E3      [19] 2295 	ld	l,-29 (ix)
   293E DD 66 E4      [19] 2296 	ld	h,-28 (ix)
   2941 7E            [ 7] 2297 	ld	a,(hl)
   2942 DD 77 D8      [19] 2298 	ld	-40 (ix),a
                           2299 ;src/Renderer.c:852: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   2945 DD 7E E7      [19] 2300 	ld	a,-25 (ix)
   2948 DD 86 C8      [19] 2301 	add	a, -56 (ix)
   294B DD 77 E3      [19] 2302 	ld	-29 (ix),a
   294E DD 7E E8      [19] 2303 	ld	a,-24 (ix)
   2951 CE 00         [ 7] 2304 	adc	a, #0x00
   2953 DD 77 E4      [19] 2305 	ld	-28 (ix),a
   2956 DD 6E E3      [19] 2306 	ld	l,-29 (ix)
   2959 DD 66 E4      [19] 2307 	ld	h,-28 (ix)
   295C 7E            [ 7] 2308 	ld	a,(hl)
   295D DD 77 EF      [19] 2309 	ld	-17 (ix),a
                           2310 ;src/Renderer.c:853: if(lastCellWasWall&CELL_WALL_MASK){
   2960 DD CB EF 7E   [20] 2311 	bit	7, -17 (ix)
   2964 28 06         [12] 2312 	jr	Z,00219$
                           2313 ;src/Renderer.c:854: lastWallId=lastCellWasWall;
                           2314 ;src/Renderer.c:855: lastCellWasWall=1;
   2966 DD 36 D7 01   [19] 2315 	ld	-41 (ix),#0x01
   296A 18 08         [12] 2316 	jr	00368$
   296C                    2317 00219$:
                           2318 ;src/Renderer.c:858: lastCellWasWall=0;
   296C DD 36 D7 00   [19] 2319 	ld	-41 (ix),#0x00
                           2320 ;src/Renderer.c:859: lastWallId=CELLTYPE_FLOOR;
   2970 DD 36 EF 00   [19] 2321 	ld	-17 (ix),#0x00
                           2322 ;src/Renderer.c:862: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   2974                    2323 00368$:
   2974 DD 36 D1 00   [19] 2324 	ld	-47 (ix),#0x00
   2978 DD 36 D3 9F   [19] 2325 	ld	-45 (ix),#0x9F
   297C                    2326 00266$:
                           2327 ;src/Renderer.c:865: if (xCellCount == zHeight)
   297C DD 7E D2      [19] 2328 	ld	a,-46 (ix)
   297F DD 96 FC      [19] 2329 	sub	a, -4 (ix)
   2982 20 50         [12] 2330 	jr	NZ,00222$
                           2331 ;src/Renderer.c:867: ++xCell;
   2984 DD 34 D1      [23] 2332 	inc	-47 (ix)
                           2333 ;src/Renderer.c:868: xCellCount = 0;
   2987 DD 36 FC 00   [19] 2334 	ld	-4 (ix),#0x00
                           2335 ;src/Renderer.c:869: newCell=1;
   298B DD 36 E9 01   [19] 2336 	ld	-23 (ix),#0x01
                           2337 ;src/Renderer.c:870: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   298F DD 7E D1      [19] 2338 	ld	a,-47 (ix)
   2992 DD 77 E3      [19] 2339 	ld	-29 (ix),a
   2995 DD 36 E4 00   [19] 2340 	ld	-28 (ix),#0x00
   2999 DD 7E E5      [19] 2341 	ld	a,-27 (ix)
   299C DD 96 E3      [19] 2342 	sub	a, -29 (ix)
   299F DD 77 E3      [19] 2343 	ld	-29 (ix),a
   29A2 DD 7E E6      [19] 2344 	ld	a,-26 (ix)
   29A5 DD 9E E4      [19] 2345 	sbc	a, -28 (ix)
   29A8 DD 77 E4      [19] 2346 	ld	-28 (ix),a
   29AB DD 6E E3      [19] 2347 	ld	l,-29 (ix)
   29AE DD 66 E4      [19] 2348 	ld	h,-28 (ix)
   29B1 2B            [ 6] 2349 	dec	hl
   29B2 DD 75 E3      [19] 2350 	ld	-29 (ix),l
   29B5 DD 74 E4      [19] 2351 	ld	-28 (ix),h
   29B8 DD 7E E7      [19] 2352 	ld	a,-25 (ix)
   29BB DD 86 E3      [19] 2353 	add	a, -29 (ix)
   29BE DD 77 E3      [19] 2354 	ld	-29 (ix),a
   29C1 DD 7E E8      [19] 2355 	ld	a,-24 (ix)
   29C4 DD 8E E4      [19] 2356 	adc	a, -28 (ix)
   29C7 DD 77 E4      [19] 2357 	ld	-28 (ix),a
   29CA DD 6E E3      [19] 2358 	ld	l,-29 (ix)
   29CD DD 66 E4      [19] 2359 	ld	h,-28 (ix)
   29D0 7E            [ 7] 2360 	ld	a,(hl)
   29D1 DD 77 D8      [19] 2361 	ld	-40 (ix),a
   29D4                    2362 00222$:
                           2363 ;src/Renderer.c:872: if(!(x%2)){
   29D4 DD 7E D3      [19] 2364 	ld	a,-45 (ix)
   29D7 E6 01         [ 7] 2365 	and	a, #0x01
   29D9 DD 77 DB      [19] 2366 	ld	-37 (ix),a
                           2367 ;src/Renderer.c:499: if (currentCellID & CELL_WALL_MASK)//Wall
   29DC DD 7E D8      [19] 2368 	ld	a,-40 (ix)
   29DF E6 80         [ 7] 2369 	and	a, #0x80
   29E1 DD 77 E3      [19] 2370 	ld	-29 (ix),a
                           2371 ;src/Renderer.c:519: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   29E4 DD 7E FC      [19] 2372 	ld	a,-4 (ix)
   29E7 DD 77 FE      [19] 2373 	ld	-2 (ix),a
   29EA DD 36 FF 00   [19] 2374 	ld	-1 (ix),#0x00
                           2375 ;src/Renderer.c:872: if(!(x%2)){
   29EE DD 7E DB      [19] 2376 	ld	a,-37 (ix)
   29F1 B7            [ 4] 2377 	or	a, a
   29F2 C2 20 2B      [10] 2378 	jp	NZ,00235$
                           2379 ;src/Renderer.c:873: if (lateralWallCounter == 0 || newCell)
   29F5 DD 7E F1      [19] 2380 	ld	a,-15 (ix)
   29F8 B7            [ 4] 2381 	or	a, a
   29F9 28 07         [12] 2382 	jr	Z,00231$
   29FB DD 7E E9      [19] 2383 	ld	a,-23 (ix)
   29FE B7            [ 4] 2384 	or	a, a
   29FF CA 20 2B      [10] 2385 	jp	Z,00235$
   2A02                    2386 00231$:
                           2387 ;src/Renderer.c:875: if ( currentCellID & CELL_WALL_MASK)//Wall
   2A02 DD 7E E3      [19] 2388 	ld	a,-29 (ix)
   2A05 B7            [ 4] 2389 	or	a, a
   2A06 28 32         [12] 2390 	jr	Z,00229$
                           2391 ;src/Renderer.c:877: lateralWallCounter = 0;
   2A08 DD 36 F1 00   [19] 2392 	ld	-15 (ix),#0x00
                           2393 ;src/Renderer.c:878: lateralWallSlope = 0;
   2A0C DD 36 FA 00   [19] 2394 	ld	-6 (ix),#0x00
                           2395 ;src/Renderer.c:879: xHeight = zHeight;
   2A10 DD 7E D2      [19] 2396 	ld	a,-46 (ix)
   2A13 DD 77 F3      [19] 2397 	ld	-13 (ix),a
                           2398 ;src/Renderer.c:880: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   2A16 DD 7E D8      [19] 2399 	ld	a,-40 (ix)
   2A19 D6 80         [ 7] 2400 	sub	a, #0x80
   2A1B 20 06         [12] 2401 	jr	NZ,00283$
   2A1D DD 36 DC 09   [19] 2402 	ld	-36 (ix),#0x09
   2A21 18 04         [12] 2403 	jr	00284$
   2A23                    2404 00283$:
   2A23 DD 36 DC 0B   [19] 2405 	ld	-36 (ix),#0x0B
   2A27                    2406 00284$:
   2A27 DD 7E DC      [19] 2407 	ld	a,-36 (ix)
   2A2A DD 77 C6      [19] 2408 	ld	-58 (ix),a
                           2409 ;src/Renderer.c:881: lastCellWasWall = 1;
   2A2D DD 36 D7 01   [19] 2410 	ld	-41 (ix),#0x01
                           2411 ;src/Renderer.c:882: lastWallId=currentCellID;
   2A31 DD 7E D8      [19] 2412 	ld	a,-40 (ix)
   2A34 DD 77 EF      [19] 2413 	ld	-17 (ix),a
   2A37 C3 1C 2B      [10] 2414 	jp	00230$
   2A3A                    2415 00229$:
                           2416 ;src/Renderer.c:884: else if(lateralWallCounter==0){
   2A3A DD 7E F1      [19] 2417 	ld	a,-15 (ix)
   2A3D B7            [ 4] 2418 	or	a, a
   2A3E C2 1C 2B      [10] 2419 	jp	NZ,00230$
                           2420 ;src/Renderer.c:885: if (lastCellWasWall)
   2A41 DD 7E D7      [19] 2421 	ld	a,-41 (ix)
   2A44 B7            [ 4] 2422 	or	a, a
   2A45 CA 0C 2B      [10] 2423 	jp	Z,00224$
                           2424 ;src/Renderer.c:888: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   2A48 DD 7E CF      [19] 2425 	ld	a,-49 (ix)
   2A4B DD 96 D1      [19] 2426 	sub	a, -47 (ix)
   2A4E 87            [ 4] 2427 	add	a, a
   2A4F 3C            [ 4] 2428 	inc	a
                           2429 ;src/Renderer.c:889: lateralWallSlopeCounter = lateralWallSlope / 2;
   2A50 DD 77 FA      [19] 2430 	ld	-6 (ix), a
   2A53 CB 3F         [ 8] 2431 	srl	a
   2A55 DD 77 F7      [19] 2432 	ld	-9 (ix),a
                           2433 ;src/Renderer.c:890: lateralWallCounter = lateralWallSlope * zHeight;
   2A58 DD 5E D2      [19] 2434 	ld	e,-46 (ix)
   2A5B DD 66 FA      [19] 2435 	ld	h,-6 (ix)
   2A5E 2E 00         [ 7] 2436 	ld	l, #0x00
   2A60 55            [ 4] 2437 	ld	d, l
   2A61 06 08         [ 7] 2438 	ld	b, #0x08
   2A63                    2439 00675$:
   2A63 29            [11] 2440 	add	hl,hl
   2A64 30 01         [12] 2441 	jr	NC,00676$
   2A66 19            [11] 2442 	add	hl,de
   2A67                    2443 00676$:
   2A67 10 FA         [13] 2444 	djnz	00675$
                           2445 ;src/Renderer.c:891: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   2A69 DD 75 DC      [19] 2446 	ld	-36 (ix), l
   2A6C DD 75 E1      [19] 2447 	ld	-31 (ix), l
   2A6F DD 36 E2 00   [19] 2448 	ld	-30 (ix),#0x00
   2A73 DD 7E DC      [19] 2449 	ld	a,-36 (ix)
   2A76 E6 03         [ 7] 2450 	and	a, #0x03
   2A78 DD 77 DC      [19] 2451 	ld	-36 (ix), a
   2A7B DD 77 DF      [19] 2452 	ld	-33 (ix),a
   2A7E DD 36 E0 00   [19] 2453 	ld	-32 (ix),#0x00
   2A82 DD 7E E1      [19] 2454 	ld	a,-31 (ix)
   2A85 DD 96 DF      [19] 2455 	sub	a, -33 (ix)
   2A88 DD 77 DF      [19] 2456 	ld	-33 (ix),a
   2A8B DD 7E E2      [19] 2457 	ld	a,-30 (ix)
   2A8E DD 9E E0      [19] 2458 	sbc	a, -32 (ix)
   2A91 DD 77 E0      [19] 2459 	ld	-32 (ix),a
   2A94 DD 7E DF      [19] 2460 	ld	a,-33 (ix)
   2A97 C6 01         [ 7] 2461 	add	a, #0x01
   2A99 DD 77 E1      [19] 2462 	ld	-31 (ix),a
   2A9C DD 7E E0      [19] 2463 	ld	a,-32 (ix)
   2A9F CE 00         [ 7] 2464 	adc	a, #0x00
   2AA1 DD 77 E2      [19] 2465 	ld	-30 (ix),a
   2AA4 DD 7E E1      [19] 2466 	ld	a,-31 (ix)
   2AA7 DD 77 DD      [19] 2467 	ld	-35 (ix),a
   2AAA DD 7E E2      [19] 2468 	ld	a,-30 (ix)
   2AAD DD 77 DE      [19] 2469 	ld	-34 (ix),a
   2AB0 DD CB E2 7E   [20] 2470 	bit	7, -30 (ix)
   2AB4 28 10         [12] 2471 	jr	Z,00285$
   2AB6 DD 7E DF      [19] 2472 	ld	a,-33 (ix)
   2AB9 C6 04         [ 7] 2473 	add	a, #0x04
   2ABB DD 77 DD      [19] 2474 	ld	-35 (ix),a
   2ABE DD 7E E0      [19] 2475 	ld	a,-32 (ix)
   2AC1 CE 00         [ 7] 2476 	adc	a, #0x00
   2AC3 DD 77 DE      [19] 2477 	ld	-34 (ix),a
   2AC6                    2478 00285$:
   2AC6 DD 4E DD      [19] 2479 	ld	c,-35 (ix)
   2AC9 DD 46 DE      [19] 2480 	ld	b,-34 (ix)
   2ACC CB 28         [ 8] 2481 	sra	b
   2ACE CB 19         [ 8] 2482 	rr	c
   2AD0 CB 28         [ 8] 2483 	sra	b
   2AD2 CB 19         [ 8] 2484 	rr	c
   2AD4 DD 46 FC      [19] 2485 	ld	b,-4 (ix)
   2AD7 79            [ 4] 2486 	ld	a,c
   2AD8 90            [ 4] 2487 	sub	a, b
   2AD9 DD 77 F1      [19] 2488 	ld	-15 (ix),a
                           2489 ;src/Renderer.c:893: lastCellWasWall = 0;
   2ADC DD 36 D7 00   [19] 2490 	ld	-41 (ix),#0x00
                           2491 ;src/Renderer.c:894: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   2AE0 DD 6E FE      [19] 2492 	ld	l,-2 (ix)
   2AE3 DD 66 FF      [19] 2493 	ld	h,-1 (ix)
   2AE6 29            [11] 2494 	add	hl, hl
   2AE7 DD 4E FA      [19] 2495 	ld	c,-6 (ix)
   2AEA 06 00         [ 7] 2496 	ld	b,#0x00
   2AEC C5            [11] 2497 	push	bc
   2AED E5            [11] 2498 	push	hl
   2AEE CD E8 85      [17] 2499 	call	__divsint
   2AF1 F1            [10] 2500 	pop	af
   2AF2 F1            [10] 2501 	pop	af
   2AF3 DD 7E EA      [19] 2502 	ld	a,-22 (ix)
   2AF6 95            [ 4] 2503 	sub	a, l
   2AF7 DD 77 F3      [19] 2504 	ld	-13 (ix),a
                           2505 ;src/Renderer.c:895: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   2AFA DD 7E EF      [19] 2506 	ld	a,-17 (ix)
   2AFD D6 80         [ 7] 2507 	sub	a, #0x80
   2AFF 20 04         [12] 2508 	jr	NZ,00286$
   2B01 0E 0A         [ 7] 2509 	ld	c,#0x0A
   2B03 18 02         [12] 2510 	jr	00287$
   2B05                    2511 00286$:
   2B05 0E 0C         [ 7] 2512 	ld	c,#0x0C
   2B07                    2513 00287$:
   2B07 DD 71 C6      [19] 2514 	ld	-58 (ix),c
   2B0A 18 10         [12] 2515 	jr	00230$
   2B0C                    2516 00224$:
                           2517 ;src/Renderer.c:899: xHeight = 0;
   2B0C DD 36 F3 00   [19] 2518 	ld	-13 (ix),#0x00
                           2519 ;src/Renderer.c:900: lastCellWasWall = 0;
   2B10 DD 36 D7 00   [19] 2520 	ld	-41 (ix),#0x00
                           2521 ;src/Renderer.c:901: lateralWallSlope=0;
   2B14 DD 36 FA 00   [19] 2522 	ld	-6 (ix),#0x00
                           2523 ;src/Renderer.c:902: lastWallId=0;
   2B18 DD 36 EF 00   [19] 2524 	ld	-17 (ix),#0x00
   2B1C                    2525 00230$:
                           2526 ;src/Renderer.c:905: newCell=0;
   2B1C DD 36 E9 00   [19] 2527 	ld	-23 (ix),#0x00
   2B20                    2528 00235$:
                           2529 ;src/Renderer.c:910: if (lateralWallCounter > 0)
   2B20 DD 7E F1      [19] 2530 	ld	a,-15 (ix)
   2B23 B7            [ 4] 2531 	or	a, a
   2B24 28 1E         [12] 2532 	jr	Z,00241$
                           2533 ;src/Renderer.c:913: if (lateralWallSlope != 0)
   2B26 DD 7E FA      [19] 2534 	ld	a,-6 (ix)
   2B29 B7            [ 4] 2535 	or	a, a
   2B2A 28 15         [12] 2536 	jr	Z,00239$
                           2537 ;src/Renderer.c:915: if (lateralWallSlopeCounter == lateralWallSlope)
   2B2C DD 7E FA      [19] 2538 	ld	a,-6 (ix)
   2B2F DD 96 F7      [19] 2539 	sub	a, -9 (ix)
   2B32 20 0A         [12] 2540 	jr	NZ,00237$
                           2541 ;src/Renderer.c:917: lateralWallSlopeCounter = 0;
   2B34 DD 36 F7 00   [19] 2542 	ld	-9 (ix),#0x00
                           2543 ;src/Renderer.c:918: xHeight -= 2;
   2B38 DD 35 F3      [23] 2544 	dec	-13 (ix)
   2B3B DD 35 F3      [23] 2545 	dec	-13 (ix)
   2B3E                    2546 00237$:
                           2547 ;src/Renderer.c:920: ++lateralWallSlopeCounter;
   2B3E DD 34 F7      [23] 2548 	inc	-9 (ix)
   2B41                    2549 00239$:
                           2550 ;src/Renderer.c:922: --lateralWallCounter;
   2B41 DD 35 F1      [23] 2551 	dec	-15 (ix)
   2B44                    2552 00241$:
                           2553 ;src/Renderer.c:926: if (!(x%2))
   2B44 DD 7E DB      [19] 2554 	ld	a,-37 (ix)
   2B47 B7            [ 4] 2555 	or	a, a
   2B48 20 74         [12] 2556 	jr	NZ,00252$
                           2557 ;src/Renderer.c:931: draw_column_to_buffer_untextured(x/2, xHeight, color);
   2B4A DD 46 D3      [19] 2558 	ld	b,-45 (ix)
   2B4D CB 38         [ 8] 2559 	srl	b
                           2560 ;src/Renderer.c:929: if(xHeight > 0){
   2B4F DD 7E F3      [19] 2561 	ld	a,-13 (ix)
   2B52 B7            [ 4] 2562 	or	a, a
   2B53 28 10         [12] 2563 	jr	Z,00243$
                           2564 ;src/Renderer.c:931: draw_column_to_buffer_untextured(x/2, xHeight, color);
   2B55 C5            [11] 2565 	push	bc
   2B56 DD 66 C6      [19] 2566 	ld	h,-58 (ix)
   2B59 DD 6E F3      [19] 2567 	ld	l,-13 (ix)
   2B5C E5            [11] 2568 	push	hl
   2B5D C5            [11] 2569 	push	bc
   2B5E 33            [ 6] 2570 	inc	sp
   2B5F CD 41 1C      [17] 2571 	call	_draw_column_to_buffer_untextured
   2B62 F1            [10] 2572 	pop	af
   2B63 33            [ 6] 2573 	inc	sp
   2B64 C1            [10] 2574 	pop	bc
   2B65                    2575 00243$:
                           2576 ;src/Renderer.c:934: if(!(currentCellID&CELL_WALL_MASK)){
   2B65 DD 7E E3      [19] 2577 	ld	a,-29 (ix)
   2B68 B7            [ 4] 2578 	or	a, a
   2B69 20 53         [12] 2579 	jr	NZ,00252$
                           2580 ;src/Renderer.c:674: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   2B6B DD 7E F5      [19] 2581 	ld	a,-11 (ix)
   2B6E DD 96 FE      [19] 2582 	sub	a, -2 (ix)
   2B71 6F            [ 4] 2583 	ld	l,a
   2B72 DD 7E F6      [19] 2584 	ld	a,-10 (ix)
   2B75 DD 9E FF      [19] 2585 	sbc	a, -1 (ix)
   2B78 67            [ 4] 2586 	ld	h,a
   2B79 29            [11] 2587 	add	hl, hl
   2B7A 29            [11] 2588 	add	hl, hl
   2B7B 29            [11] 2589 	add	hl, hl
   2B7C 29            [11] 2590 	add	hl, hl
   2B7D 29            [11] 2591 	add	hl, hl
   2B7E C5            [11] 2592 	push	bc
   2B7F DD 5E F5      [19] 2593 	ld	e,-11 (ix)
   2B82 DD 56 F6      [19] 2594 	ld	d,-10 (ix)
   2B85 D5            [11] 2595 	push	de
   2B86 E5            [11] 2596 	push	hl
   2B87 CD E8 85      [17] 2597 	call	__divsint
   2B8A F1            [10] 2598 	pop	af
   2B8B F1            [10] 2599 	pop	af
   2B8C 55            [ 4] 2600 	ld	d,l
   2B8D C1            [10] 2601 	pop	bc
                           2602 ;src/Renderer.c:935: if(currentCellID&CELL_ENEMY_MASK){
   2B8E DD 7E D8      [19] 2603 	ld	a,-40 (ix)
   2B91 E6 0F         [ 7] 2604 	and	a, #0x0F
   2B93 28 12         [12] 2605 	jr	Z,00247$
                           2606 ;src/Renderer.c:936: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   2B95 D5            [11] 2607 	push	de
   2B96 33            [ 6] 2608 	inc	sp
   2B97 DD 66 D8      [19] 2609 	ld	h,-40 (ix)
   2B9A DD 6E D2      [19] 2610 	ld	l,-46 (ix)
   2B9D E5            [11] 2611 	push	hl
   2B9E C5            [11] 2612 	push	bc
   2B9F 33            [ 6] 2613 	inc	sp
   2BA0 CD B4 1D      [17] 2614 	call	_draw_column_to_buffer_enemy
   2BA3 F1            [10] 2615 	pop	af
   2BA4 F1            [10] 2616 	pop	af
   2BA5 18 17         [12] 2617 	jr	00252$
   2BA7                    2618 00247$:
                           2619 ;src/Renderer.c:938: else if(currentCellID&CELL_ITEM_MASK){
   2BA7 DD 7E D8      [19] 2620 	ld	a,-40 (ix)
   2BAA E6 70         [ 7] 2621 	and	a, #0x70
   2BAC 28 10         [12] 2622 	jr	Z,00252$
                           2623 ;src/Renderer.c:939: draw_column_to_buffer_object(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   2BAE D5            [11] 2624 	push	de
   2BAF 33            [ 6] 2625 	inc	sp
   2BB0 DD 66 D8      [19] 2626 	ld	h,-40 (ix)
   2BB3 DD 6E D2      [19] 2627 	ld	l,-46 (ix)
   2BB6 E5            [11] 2628 	push	hl
   2BB7 C5            [11] 2629 	push	bc
   2BB8 33            [ 6] 2630 	inc	sp
   2BB9 CD B9 1C      [17] 2631 	call	_draw_column_to_buffer_object
   2BBC F1            [10] 2632 	pop	af
   2BBD F1            [10] 2633 	pop	af
   2BBE                    2634 00252$:
                           2635 ;src/Renderer.c:943: ++xCellCount;
   2BBE DD 34 FC      [23] 2636 	inc	-4 (ix)
                           2637 ;src/Renderer.c:862: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   2BC1 DD 35 D3      [23] 2638 	dec	-45 (ix)
                           2639 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineStart + 1];
   2BC4 2A 3A 1C      [16] 2640 	ld	hl,(_cells_in_view_array)
   2BC7 DD 75 E7      [19] 2641 	ld	-25 (ix),l
   2BCA DD 74 E8      [19] 2642 	ld	-24 (ix),h
                           2643 ;src/Renderer.c:862: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   2BCD DD 7E D3      [19] 2644 	ld	a,-45 (ix)
   2BD0 D6 50         [ 7] 2645 	sub	a, #0x50
   2BD2 D2 7C 29      [10] 2646 	jp	NC,00266$
                           2647 ;src/Renderer.c:972: lineStart = lineStart + (offsetDiff * 2) + 3;
   2BD5 DD 7E EC      [19] 2648 	ld	a,-20 (ix)
   2BD8 C6 03         [ 7] 2649 	add	a, #0x03
   2BDA DD 77 C7      [19] 2650 	ld	-57 (ix),a
                           2651 ;src/Renderer.c:973: zHeight += zHeight;
   2BDD DD CB D2 26   [23] 2652 	sla	-46 (ix)
                           2653 ;src/Renderer.c:974: offsetDiff = offsetDiff >> 1;
   2BE1 DD CB CF 3E   [23] 2654 	srl	-49 (ix)
                           2655 ;src/Renderer.c:976: }while(z);
   2BE5 DD 7E CA      [19] 2656 	ld	a,-54 (ix)
   2BE8 B7            [ 4] 2657 	or	a, a
   2BE9 C2 0D 26      [10] 2658 	jp	NZ,00254$
   2BEC                    2659 00268$:
   2BEC DD F9         [10] 2660 	ld	sp, ix
   2BEE DD E1         [14] 2661 	pop	ix
   2BF0 C9            [10] 2662 	ret
                           2663 ;src/Renderer.c:982: void draw_minimap_to_buffer(){
                           2664 ;	---------------------------------
                           2665 ; Function draw_minimap_to_buffer
                           2666 ; ---------------------------------
   2BF1                    2667 _draw_minimap_to_buffer::
   2BF1 DD E5         [15] 2668 	push	ix
   2BF3 DD 21 00 00   [14] 2669 	ld	ix,#0
   2BF7 DD 39         [15] 2670 	add	ix,sp
   2BF9 21 F5 FF      [10] 2671 	ld	hl,#-11
   2BFC 39            [11] 2672 	add	hl,sp
   2BFD F9            [ 6] 2673 	ld	sp,hl
                           2674 ;src/Renderer.c:985: u8* ptr = MINIMAP_BUFFER;
   2BFE 01 F0 B9      [10] 2675 	ld	bc,#0xB9F0
                           2676 ;src/Renderer.c:990: y=(player_position.y-MINIMAP_HEIGHT_HALF);
   2C01 3A EF 19      [13] 2677 	ld	a, (#(_player_position + 0x0001) + 0)
   2C04 C6 F8         [ 7] 2678 	add	a,#0xF8
   2C06 5F            [ 4] 2679 	ld	e,a
                           2680 ;src/Renderer.c:992: for(j=0;j<MINIMAP_HEIGHT;++j){
   2C07 16 00         [ 7] 2681 	ld	d,#0x00
                           2682 ;src/Renderer.c:993: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   2C09                    2683 00141$:
   2C09 7B            [ 4] 2684 	ld	a,e
   2C0A 07            [ 4] 2685 	rlca
   2C0B E6 01         [ 7] 2686 	and	a,#0x01
   2C0D DD 77 F8      [19] 2687 	ld	-8 (ix),a
   2C10 7B            [ 4] 2688 	ld	a,e
   2C11 EE 80         [ 7] 2689 	xor	a, #0x80
   2C13 D6 A0         [ 7] 2690 	sub	a, #0xA0
   2C15 3E 00         [ 7] 2691 	ld	a,#0x00
   2C17 17            [ 4] 2692 	rla
   2C18 DD 77 F7      [19] 2693 	ld	-9 (ix),a
   2C1B DD 36 F6 00   [19] 2694 	ld	-10 (ix),#0x00
   2C1F                    2695 00125$:
                           2696 ;src/Renderer.c:994: x=(player_position.x-MINIMAP_WIDTH_HALF);
   2C1F 3A EE 19      [13] 2697 	ld	a, (#_player_position + 0)
   2C22 C6 F8         [ 7] 2698 	add	a,#0xF8
   2C24 DD 77 FF      [19] 2699 	ld	-1 (ix),a
                           2700 ;src/Renderer.c:995: for(i=0;i<MINIMAP_WIDTH;++i){
   2C27 DD 36 F5 00   [19] 2701 	ld	-11 (ix),#0x00
   2C2B                    2702 00123$:
                           2703 ;src/Renderer.c:998: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   2C2B FD 21 10 00   [14] 2704 	ld	iy,#0x0010
   2C2F FD 09         [15] 2705 	add	iy, bc
                           2706 ;src/Renderer.c:996: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
   2C31 DD CB FF 7E   [20] 2707 	bit	7, -1 (ix)
   2C35 20 15         [12] 2708 	jr	NZ,00114$
   2C37 DD 7E FF      [19] 2709 	ld	a,-1 (ix)
   2C3A EE 80         [ 7] 2710 	xor	a, #0x80
   2C3C D6 A0         [ 7] 2711 	sub	a, #0xA0
   2C3E 30 0C         [12] 2712 	jr	NC,00114$
   2C40 DD 7E F8      [19] 2713 	ld	a,-8 (ix)
   2C43 B7            [ 4] 2714 	or	a, a
   2C44 20 06         [12] 2715 	jr	NZ,00114$
   2C46 DD CB F7 46   [20] 2716 	bit	0,-9 (ix)
   2C4A 20 0D         [12] 2717 	jr	NZ,00115$
   2C4C                    2718 00114$:
                           2719 ;src/Renderer.c:997: *ptr=g_colors[MINIMAP_WALL_COLOR];
   2C4C 3A 29 1C      [13] 2720 	ld	a, (#(_g_colors + 0x0001) + 0)
   2C4F 02            [ 7] 2721 	ld	(bc),a
                           2722 ;src/Renderer.c:998: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   2C50 3A 29 1C      [13] 2723 	ld	a, (#(_g_colors + 0x0001) + 0)
   2C53 FD 77 00      [19] 2724 	ld	0 (iy), a
   2C56 C3 13 2D      [10] 2725 	jp	00116$
   2C59                    2726 00115$:
                           2727 ;src/Renderer.c:1000: else if((x==player_position.x)&&(y==player_position.y)){
   2C59 DD 7E FF      [19] 2728 	ld	a,-1 (ix)
   2C5C DD 77 FD      [19] 2729 	ld	-3 (ix),a
   2C5F DD 7E FF      [19] 2730 	ld	a,-1 (ix)
   2C62 17            [ 4] 2731 	rla
   2C63 9F            [ 4] 2732 	sbc	a, a
   2C64 DD 77 FE      [19] 2733 	ld	-2 (ix),a
   2C67 3A EE 19      [13] 2734 	ld	a, (#_player_position + 0)
   2C6A DD 77 F9      [19] 2735 	ld	-7 (ix),a
   2C6D DD 36 FA 00   [19] 2736 	ld	-6 (ix),#0x00
   2C71 DD 73 FB      [19] 2737 	ld	-5 (ix),e
   2C74 7B            [ 4] 2738 	ld	a,e
   2C75 17            [ 4] 2739 	rla
   2C76 9F            [ 4] 2740 	sbc	a, a
   2C77 DD 77 FC      [19] 2741 	ld	-4 (ix),a
   2C7A DD 7E FD      [19] 2742 	ld	a,-3 (ix)
   2C7D DD 96 F9      [19] 2743 	sub	a, -7 (ix)
   2C80 20 2E         [12] 2744 	jr	NZ,00111$
   2C82 DD 7E FE      [19] 2745 	ld	a,-2 (ix)
   2C85 DD 96 FA      [19] 2746 	sub	a, -6 (ix)
   2C88 20 26         [12] 2747 	jr	NZ,00111$
   2C8A 3A EF 19      [13] 2748 	ld	a, (#(_player_position + 0x0001) + 0)
   2C8D DD 77 F9      [19] 2749 	ld	-7 (ix),a
   2C90 DD 36 FA 00   [19] 2750 	ld	-6 (ix),#0x00
   2C94 DD 7E FB      [19] 2751 	ld	a,-5 (ix)
   2C97 DD 96 F9      [19] 2752 	sub	a, -7 (ix)
   2C9A 20 14         [12] 2753 	jr	NZ,00111$
   2C9C DD 7E FC      [19] 2754 	ld	a,-4 (ix)
   2C9F DD 96 FA      [19] 2755 	sub	a, -6 (ix)
   2CA2 20 0C         [12] 2756 	jr	NZ,00111$
                           2757 ;src/Renderer.c:1001: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
   2CA4 3A 2C 1C      [13] 2758 	ld	a, (#(_g_colors + 0x0004) + 0)
   2CA7 02            [ 7] 2759 	ld	(bc),a
                           2760 ;src/Renderer.c:1002: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
   2CA8 3A 2C 1C      [13] 2761 	ld	a, (#(_g_colors + 0x0004) + 0)
   2CAB FD 77 00      [19] 2762 	ld	0 (iy), a
   2CAE 18 63         [12] 2763 	jr	00116$
   2CB0                    2764 00111$:
                           2765 ;src/Renderer.c:1005: val = (*(u8*)(MAP_MEM+x+y*MAP_WIDTH));
   2CB0 DD 7E FD      [19] 2766 	ld	a, -3 (ix)
   2CB3 DD 66 FE      [19] 2767 	ld	h, -2 (ix)
   2CB6 C6 D0         [ 7] 2768 	add	a, #0xD0
   2CB8 DD 77 F9      [19] 2769 	ld	-7 (ix),a
   2CBB 7C            [ 4] 2770 	ld	a,h
   2CBC CE 88         [ 7] 2771 	adc	a, #0x88
   2CBE DD 77 FA      [19] 2772 	ld	-6 (ix),a
   2CC1 DD 6E FB      [19] 2773 	ld	l,-5 (ix)
   2CC4 DD 66 FC      [19] 2774 	ld	h,-4 (ix)
   2CC7 29            [11] 2775 	add	hl, hl
   2CC8 29            [11] 2776 	add	hl, hl
   2CC9 29            [11] 2777 	add	hl, hl
   2CCA 29            [11] 2778 	add	hl, hl
   2CCB 29            [11] 2779 	add	hl, hl
   2CCC DD 7E F9      [19] 2780 	ld	a,-7 (ix)
   2CCF 85            [ 4] 2781 	add	a, l
   2CD0 6F            [ 4] 2782 	ld	l,a
   2CD1 DD 7E FA      [19] 2783 	ld	a,-6 (ix)
   2CD4 8C            [ 4] 2784 	adc	a, h
   2CD5 67            [ 4] 2785 	ld	h,a
   2CD6 6E            [ 7] 2786 	ld	l,(hl)
                           2787 ;src/Renderer.c:1007: if(val==CELLTYPE_DOOR){
   2CD7 7D            [ 4] 2788 	ld	a,l
   2CD8 D6 80         [ 7] 2789 	sub	a, #0x80
   2CDA 20 0C         [12] 2790 	jr	NZ,00108$
                           2791 ;src/Renderer.c:1008: *ptr=g_colors[MINIMAP_EXIT_COLOR];
   2CDC 3A 2D 1C      [13] 2792 	ld	a, (#(_g_colors + 0x0005) + 0)
   2CDF 02            [ 7] 2793 	ld	(bc),a
                           2794 ;src/Renderer.c:1009: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
   2CE0 3A 2D 1C      [13] 2795 	ld	a, (#(_g_colors + 0x0005) + 0)
   2CE3 FD 77 00      [19] 2796 	ld	0 (iy), a
   2CE6 18 2B         [12] 2797 	jr	00116$
   2CE8                    2798 00108$:
                           2799 ;src/Renderer.c:1011: else if(val&CELL_WALL_MASK){
   2CE8 CB 7D         [ 8] 2800 	bit	7, l
   2CEA 28 0C         [12] 2801 	jr	Z,00105$
                           2802 ;src/Renderer.c:1012: *ptr=g_colors[MINIMAP_WALL_COLOR];
   2CEC 3A 29 1C      [13] 2803 	ld	a, (#(_g_colors + 0x0001) + 0)
   2CEF 02            [ 7] 2804 	ld	(bc),a
                           2805 ;src/Renderer.c:1013: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   2CF0 3A 29 1C      [13] 2806 	ld	a, (#(_g_colors + 0x0001) + 0)
   2CF3 FD 77 00      [19] 2807 	ld	0 (iy), a
   2CF6 18 1B         [12] 2808 	jr	00116$
   2CF8                    2809 00105$:
                           2810 ;src/Renderer.c:1015: else if(val&CELL_ENEMY_MASK){
   2CF8 7D            [ 4] 2811 	ld	a,l
   2CF9 E6 0F         [ 7] 2812 	and	a, #0x0F
   2CFB 28 0C         [12] 2813 	jr	Z,00102$
                           2814 ;src/Renderer.c:1016: *ptr=g_colors[MINIMAP_ENEMY_COLOR];
   2CFD 3A 2E 1C      [13] 2815 	ld	a, (#(_g_colors + 0x0006) + 0)
   2D00 02            [ 7] 2816 	ld	(bc),a
                           2817 ;src/Renderer.c:1017: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_ENEMY_COLOR];
   2D01 3A 2E 1C      [13] 2818 	ld	a, (#(_g_colors + 0x0006) + 0)
   2D04 FD 77 00      [19] 2819 	ld	0 (iy), a
   2D07 18 0A         [12] 2820 	jr	00116$
   2D09                    2821 00102$:
                           2822 ;src/Renderer.c:1024: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
   2D09 3A 2B 1C      [13] 2823 	ld	a, (#(_g_colors + 0x0003) + 0)
   2D0C 02            [ 7] 2824 	ld	(bc),a
                           2825 ;src/Renderer.c:1025: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
   2D0D 3A 2B 1C      [13] 2826 	ld	a, (#(_g_colors + 0x0003) + 0)
   2D10 FD 77 00      [19] 2827 	ld	0 (iy), a
   2D13                    2828 00116$:
                           2829 ;src/Renderer.c:1028: ++x;
   2D13 DD 34 FF      [23] 2830 	inc	-1 (ix)
                           2831 ;src/Renderer.c:1029: ++ptr;
   2D16 03            [ 6] 2832 	inc	bc
                           2833 ;src/Renderer.c:995: for(i=0;i<MINIMAP_WIDTH;++i){
   2D17 DD 34 F5      [23] 2834 	inc	-11 (ix)
   2D1A DD 7E F5      [19] 2835 	ld	a,-11 (ix)
   2D1D D6 10         [ 7] 2836 	sub	a, #0x10
   2D1F DA 2B 2C      [10] 2837 	jp	C,00123$
                           2838 ;src/Renderer.c:993: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   2D22 DD 34 F6      [23] 2839 	inc	-10 (ix)
   2D25 DD 7E F6      [19] 2840 	ld	a,-10 (ix)
   2D28 D6 04         [ 7] 2841 	sub	a, #0x04
   2D2A DA 1F 2C      [10] 2842 	jp	C,00125$
                           2843 ;src/Renderer.c:1032: ++y;
   2D2D 1C            [ 4] 2844 	inc	e
                           2845 ;src/Renderer.c:992: for(j=0;j<MINIMAP_HEIGHT;++j){
   2D2E 14            [ 4] 2846 	inc	d
   2D2F 7A            [ 4] 2847 	ld	a,d
   2D30 D6 10         [ 7] 2848 	sub	a, #0x10
   2D32 DA 09 2C      [10] 2849 	jp	C,00141$
   2D35 DD F9         [10] 2850 	ld	sp, ix
   2D37 DD E1         [14] 2851 	pop	ix
   2D39 C9            [10] 2852 	ret
                           2853 	.area _CODE
                           2854 	.area _INITIALIZER
                           2855 	.area _CABS (ABS)
