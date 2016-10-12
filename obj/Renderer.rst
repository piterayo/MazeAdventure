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
   588C                      60 _calculate_cells_in_view::
   588C DD E5         [15]   61 	push	ix
   588E DD 21 00 00   [14]   62 	ld	ix,#0
   5892 DD 39         [15]   63 	add	ix,sp
   5894 21 F2 FF      [10]   64 	ld	hl,#-14
   5897 39            [11]   65 	add	hl,sp
   5898 F9            [ 6]   66 	ld	sp,hl
                             67 ;src/Renderer.c:55: u8 offset=0, n=0, j, i;
   5899 DD 36 FA 00   [19]   68 	ld	-6 (ix),#0x00
   589D DD 36 F9 00   [19]   69 	ld	-7 (ix),#0x00
                             70 ;src/Renderer.c:58: if(PLAYER_direction.y!=0){
   58A1 3A 82 58      [13]   71 	ld	a,(#_PLAYER_direction + 1)
   58A4 DD 77 FD      [19]   72 	ld	-3 (ix), a
   58A7 B7            [ 4]   73 	or	a, a
   58A8 28 32         [12]   74 	jr	Z,00102$
                             75 ;src/Renderer.c:59: vert=1;
   58AA DD 36 F2 01   [19]   76 	ld	-14 (ix),#0x01
                             77 ;src/Renderer.c:60: dy=PLAYER_direction.y;
   58AE DD 4E FD      [19]   78 	ld	c,-3 (ix)
   58B1 DD 71 F4      [19]   79 	ld	-12 (ix),c
                             80 ;src/Renderer.c:61: dx=-PLAYER_direction.y;
   58B4 AF            [ 4]   81 	xor	a, a
   58B5 DD 96 FD      [19]   82 	sub	a, -3 (ix)
   58B8 DD 77 F5      [19]   83 	ld	-11 (ix), a
                             84 ;src/Renderer.c:63: x0 = PLAYER_position.x-(17*dx);
   58BB 21 7F 58      [10]   85 	ld	hl,#_PLAYER_position+0
   58BE 4E            [ 7]   86 	ld	c,(hl)
   58BF DD 6E F5      [19]   87 	ld	l,-11 (ix)
   58C2 5D            [ 4]   88 	ld	e,l
   58C3 29            [11]   89 	add	hl, hl
   58C4 29            [11]   90 	add	hl, hl
   58C5 29            [11]   91 	add	hl, hl
   58C6 29            [11]   92 	add	hl, hl
   58C7 19            [11]   93 	add	hl, de
   58C8 79            [ 4]   94 	ld	a,c
   58C9 95            [ 4]   95 	sub	a, l
   58CA DD 77 F6      [19]   96 	ld	-10 (ix),a
                             97 ;src/Renderer.c:64: y0 = PLAYER_position.y+(6*dy);
   58CD 21 80 58      [10]   98 	ld	hl,#_PLAYER_position+1
   58D0 4E            [ 7]   99 	ld	c,(hl)
   58D1 DD 6E F4      [19]  100 	ld	l,-12 (ix)
   58D4 5D            [ 4]  101 	ld	e,l
   58D5 29            [11]  102 	add	hl, hl
   58D6 19            [11]  103 	add	hl, de
   58D7 29            [11]  104 	add	hl, hl
   58D8 09            [11]  105 	add	hl, bc
   58D9 4D            [ 4]  106 	ld	c,l
   58DA 18 34         [12]  107 	jr	00103$
   58DC                     108 00102$:
                            109 ;src/Renderer.c:67: vert=0;
   58DC DD 36 F2 00   [19]  110 	ld	-14 (ix),#0x00
                            111 ;src/Renderer.c:68: dy=PLAYER_direction.x;
   58E0 3A 81 58      [13]  112 	ld	a,(#_PLAYER_direction + 0)
   58E3 DD 77 FD      [19]  113 	ld	-3 (ix), a
   58E6 DD 77 F4      [19]  114 	ld	-12 (ix),a
                            115 ;src/Renderer.c:69: dx=PLAYER_direction.x;
   58E9 DD 7E FD      [19]  116 	ld	a,-3 (ix)
   58EC DD 77 F5      [19]  117 	ld	-11 (ix),a
                            118 ;src/Renderer.c:71: y0 = PLAYER_position.y-(17*dy);
   58EF 21 80 58      [10]  119 	ld	hl, #_PLAYER_position + 1
   58F2 4E            [ 7]  120 	ld	c,(hl)
   58F3 DD 6E F4      [19]  121 	ld	l,-12 (ix)
   58F6 5D            [ 4]  122 	ld	e,l
   58F7 29            [11]  123 	add	hl, hl
   58F8 29            [11]  124 	add	hl, hl
   58F9 29            [11]  125 	add	hl, hl
   58FA 29            [11]  126 	add	hl, hl
   58FB 19            [11]  127 	add	hl, de
   58FC 79            [ 4]  128 	ld	a,c
   58FD 95            [ 4]  129 	sub	a, l
   58FE 4F            [ 4]  130 	ld	c,a
                            131 ;src/Renderer.c:72: x0 = PLAYER_position.x+(6*dx);
   58FF 21 7F 58      [10]  132 	ld	hl, #_PLAYER_position + 0
   5902 46            [ 7]  133 	ld	b,(hl)
   5903 DD 7E FD      [19]  134 	ld	a,-3 (ix)
   5906 5F            [ 4]  135 	ld	e,a
   5907 87            [ 4]  136 	add	a, a
   5908 83            [ 4]  137 	add	a, e
   5909 87            [ 4]  138 	add	a, a
   590A 5F            [ 4]  139 	ld	e,a
   590B 68            [ 4]  140 	ld	l,b
   590C 19            [11]  141 	add	hl, de
   590D DD 75 F6      [19]  142 	ld	-10 (ix),l
   5910                     143 00103$:
                            144 ;src/Renderer.c:76: x=x0;
   5910 DD 5E F6      [19]  145 	ld	e,-10 (ix)
                            146 ;src/Renderer.c:77: y=y0;
   5913 DD 71 F3      [19]  147 	ld	-13 (ix),c
                            148 ;src/Renderer.c:79: for(j=0;j<6;++j){
   5916 DD 7E F5      [19]  149 	ld	a,-11 (ix)
   5919 07            [ 4]  150 	rlca
   591A E6 01         [ 7]  151 	and	a,#0x01
   591C DD 77 FD      [19]  152 	ld	-3 (ix),a
   591F DD 7E F4      [19]  153 	ld	a,-12 (ix)
   5922 07            [ 4]  154 	rlca
   5923 E6 01         [ 7]  155 	and	a,#0x01
   5925 DD 77 FB      [19]  156 	ld	-5 (ix),a
   5928 DD 36 F8 00   [19]  157 	ld	-8 (ix),#0x00
                            158 ;src/Renderer.c:81: for(i=offset;i<35-offset;++i){
   592C                     159 00138$:
   592C DD 7E F9      [19]  160 	ld	a,-7 (ix)
   592F DD 77 FC      [19]  161 	ld	-4 (ix),a
   5932 DD 7E FA      [19]  162 	ld	a,-6 (ix)
   5935 DD 77 F7      [19]  163 	ld	-9 (ix),a
   5938                     164 00125$:
   5938 DD 6E FA      [19]  165 	ld	l,-6 (ix)
   593B 26 00         [ 7]  166 	ld	h,#0x00
   593D 3E 23         [ 7]  167 	ld	a,#0x23
   593F 95            [ 4]  168 	sub	a, l
   5940 6F            [ 4]  169 	ld	l,a
   5941 3E 00         [ 7]  170 	ld	a,#0x00
   5943 9C            [ 4]  171 	sbc	a, h
   5944 67            [ 4]  172 	ld	h,a
   5945 DD 7E F7      [19]  173 	ld	a, -9 (ix)
   5948 16 00         [ 7]  174 	ld	d, #0x00
   594A 95            [ 4]  175 	sub	a, l
   594B 7A            [ 4]  176 	ld	a,d
   594C 9C            [ 4]  177 	sbc	a, h
   594D E2 52 59      [10]  178 	jp	PO, 00181$
   5950 EE 80         [ 7]  179 	xor	a, #0x80
   5952                     180 00181$:
   5952 F2 D1 59      [10]  181 	jp	P,00143$
                            182 ;src/Renderer.c:84: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   5955 2A 5E 5A      [16]  183 	ld	hl,(_cells_in_view_array)
   5958 7D            [ 4]  184 	ld	a,l
   5959 DD 86 FC      [19]  185 	add	a, -4 (ix)
   595C DD 77 FE      [19]  186 	ld	-2 (ix),a
   595F 7C            [ 4]  187 	ld	a,h
   5960 CE 00         [ 7]  188 	adc	a, #0x00
   5962 DD 77 FF      [19]  189 	ld	-1 (ix),a
                            190 ;src/Renderer.c:83: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
   5965 CB 7B         [ 8]  191 	bit	7, e
   5967 20 41         [12]  192 	jr	NZ,00105$
   5969 7B            [ 4]  193 	ld	a,e
   596A EE 80         [ 7]  194 	xor	a, #0x80
   596C D6 A0         [ 7]  195 	sub	a, #0xA0
   596E 30 3A         [12]  196 	jr	NC,00105$
   5970 DD CB F3 7E   [20]  197 	bit	7, -13 (ix)
   5974 20 34         [12]  198 	jr	NZ,00105$
   5976 DD 7E F3      [19]  199 	ld	a,-13 (ix)
   5979 EE 80         [ 7]  200 	xor	a, #0x80
   597B D6 A0         [ 7]  201 	sub	a, #0xA0
   597D 30 2B         [12]  202 	jr	NC,00105$
                            203 ;src/Renderer.c:84: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   597F 7B            [ 4]  204 	ld	a,e
   5980 57            [ 4]  205 	ld	d,a
   5981 17            [ 4]  206 	rla
   5982 9F            [ 4]  207 	sbc	a, a
   5983 6F            [ 4]  208 	ld	l,a
   5984 7A            [ 4]  209 	ld	a,d
   5985 C6 40         [ 7]  210 	add	a, #0x40
   5987 47            [ 4]  211 	ld	b,a
   5988 7D            [ 4]  212 	ld	a,l
   5989 CE 00         [ 7]  213 	adc	a, #0x00
   598B 57            [ 4]  214 	ld	d,a
   598C DD 6E F3      [19]  215 	ld	l,-13 (ix)
   598F DD 7E F3      [19]  216 	ld	a,-13 (ix)
   5992 17            [ 4]  217 	rla
   5993 9F            [ 4]  218 	sbc	a, a
   5994 67            [ 4]  219 	ld	h,a
   5995 29            [11]  220 	add	hl, hl
   5996 29            [11]  221 	add	hl, hl
   5997 29            [11]  222 	add	hl, hl
   5998 29            [11]  223 	add	hl, hl
   5999 29            [11]  224 	add	hl, hl
   599A 78            [ 4]  225 	ld	a,b
   599B 85            [ 4]  226 	add	a, l
   599C 6F            [ 4]  227 	ld	l,a
   599D 7A            [ 4]  228 	ld	a,d
   599E 8C            [ 4]  229 	adc	a, h
   599F 67            [ 4]  230 	ld	h,a
   59A0 46            [ 7]  231 	ld	b,(hl)
   59A1 DD 6E FE      [19]  232 	ld	l,-2 (ix)
   59A4 DD 66 FF      [19]  233 	ld	h,-1 (ix)
   59A7 70            [ 7]  234 	ld	(hl),b
   59A8 18 08         [12]  235 	jr	00106$
   59AA                     236 00105$:
                            237 ;src/Renderer.c:87: cells_in_view_array[n]=CELLTYPE_WALL1;
   59AA DD 6E FE      [19]  238 	ld	l,-2 (ix)
   59AD DD 66 FF      [19]  239 	ld	h,-1 (ix)
   59B0 36 81         [10]  240 	ld	(hl),#0x81
   59B2                     241 00106$:
                            242 ;src/Renderer.c:91: if(vert){
   59B2 DD 7E F2      [19]  243 	ld	a,-14 (ix)
   59B5 B7            [ 4]  244 	or	a, a
   59B6 28 07         [12]  245 	jr	Z,00111$
                            246 ;src/Renderer.c:92: x+=dx;
   59B8 7B            [ 4]  247 	ld	a,e
   59B9 DD 86 F5      [19]  248 	add	a, -11 (ix)
   59BC 5F            [ 4]  249 	ld	e,a
   59BD 18 09         [12]  250 	jr	00112$
   59BF                     251 00111$:
                            252 ;src/Renderer.c:95: y+=dy;
   59BF DD 7E F3      [19]  253 	ld	a,-13 (ix)
   59C2 DD 86 F4      [19]  254 	add	a, -12 (ix)
   59C5 DD 77 F3      [19]  255 	ld	-13 (ix),a
   59C8                     256 00112$:
                            257 ;src/Renderer.c:97: ++n;
   59C8 DD 34 FC      [23]  258 	inc	-4 (ix)
                            259 ;src/Renderer.c:81: for(i=offset;i<35-offset;++i){
   59CB DD 34 F7      [23]  260 	inc	-9 (ix)
   59CE C3 38 59      [10]  261 	jp	00125$
   59D1                     262 00143$:
   59D1 DD 7E FC      [19]  263 	ld	a,-4 (ix)
   59D4 DD 77 F9      [19]  264 	ld	-7 (ix),a
                            265 ;src/Renderer.c:99: offset=offsets_cells_in_view[j];
   59D7 3E 60         [ 7]  266 	ld	a,#<(_offsets_cells_in_view)
   59D9 DD 86 F8      [19]  267 	add	a, -8 (ix)
   59DC 6F            [ 4]  268 	ld	l,a
   59DD 3E 5A         [ 7]  269 	ld	a,#>(_offsets_cells_in_view)
   59DF CE 00         [ 7]  270 	adc	a, #0x00
   59E1 67            [ 4]  271 	ld	h,a
   59E2 7E            [ 7]  272 	ld	a,(hl)
                            273 ;src/Renderer.c:103: if(dx<0) x=x0-offset;
   59E3 DD 77 FA      [19]  274 	ld	-6 (ix), a
   59E6 DD 77 FE      [19]  275 	ld	-2 (ix),a
                            276 ;src/Renderer.c:101: if(vert){
   59E9 DD 7E F2      [19]  277 	ld	a,-14 (ix)
   59EC B7            [ 4]  278 	or	a, a
   59ED 28 21         [12]  279 	jr	Z,00121$
                            280 ;src/Renderer.c:102: y-=dy;
   59EF DD 7E F3      [19]  281 	ld	a,-13 (ix)
   59F2 DD 96 F4      [19]  282 	sub	a, -12 (ix)
   59F5 DD 77 F3      [19]  283 	ld	-13 (ix),a
                            284 ;src/Renderer.c:103: if(dx<0) x=x0-offset;
   59F8 DD 7E FD      [19]  285 	ld	a,-3 (ix)
   59FB B7            [ 4]  286 	or	a, a
   59FC 28 09         [12]  287 	jr	Z,00115$
   59FE DD 7E F6      [19]  288 	ld	a,-10 (ix)
   5A01 DD 96 FE      [19]  289 	sub	a, -2 (ix)
   5A04 5F            [ 4]  290 	ld	e,a
   5A05 18 24         [12]  291 	jr	00128$
   5A07                     292 00115$:
                            293 ;src/Renderer.c:104: else x=x0+offset;
   5A07 DD 7E F6      [19]  294 	ld	a,-10 (ix)
   5A0A DD 86 FE      [19]  295 	add	a, -2 (ix)
   5A0D 5F            [ 4]  296 	ld	e,a
   5A0E 18 1B         [12]  297 	jr	00128$
   5A10                     298 00121$:
                            299 ;src/Renderer.c:108: x-=dx;
   5A10 7B            [ 4]  300 	ld	a,e
   5A11 DD 96 F5      [19]  301 	sub	a, -11 (ix)
   5A14 5F            [ 4]  302 	ld	e,a
                            303 ;src/Renderer.c:109: if(dy<0) y=y0-offset;
   5A15 DD 7E FB      [19]  304 	ld	a,-5 (ix)
   5A18 B7            [ 4]  305 	or	a, a
   5A19 28 09         [12]  306 	jr	Z,00118$
   5A1B 79            [ 4]  307 	ld	a,c
   5A1C DD 96 FE      [19]  308 	sub	a, -2 (ix)
   5A1F DD 77 F3      [19]  309 	ld	-13 (ix),a
   5A22 18 07         [12]  310 	jr	00128$
   5A24                     311 00118$:
                            312 ;src/Renderer.c:110: else y=y0+offset;
   5A24 79            [ 4]  313 	ld	a,c
   5A25 DD 86 FE      [19]  314 	add	a, -2 (ix)
   5A28 DD 77 F3      [19]  315 	ld	-13 (ix),a
   5A2B                     316 00128$:
                            317 ;src/Renderer.c:79: for(j=0;j<6;++j){
   5A2B DD 34 F8      [23]  318 	inc	-8 (ix)
   5A2E DD 7E F8      [19]  319 	ld	a,-8 (ix)
   5A31 D6 06         [ 7]  320 	sub	a, #0x06
   5A33 DA 2C 59      [10]  321 	jp	C,00138$
   5A36 DD F9         [10]  322 	ld	sp, ix
   5A38 DD E1         [14]  323 	pop	ix
   5A3A C9            [10]  324 	ret
   5A3B                     325 _g_palette:
   5A3B 08                  326 	.db #0x08	; 8
   5A3C 00                  327 	.db #0x00	; 0
   5A3D 0D                  328 	.db #0x0D	; 13
   5A3E 1A                  329 	.db #0x1A	; 26
   5A3F 06                  330 	.db #0x06	; 6
   5A40 18                  331 	.db #0x18	; 24
   5A41 19                  332 	.db #0x19	; 25
   5A42 01                  333 	.db #0x01	; 1
   5A43 09                  334 	.db #0x09	; 9
   5A44 03                  335 	.db #0x03	; 3
   5A45 12                  336 	.db #0x12	; 18
   5A46 05                  337 	.db #0x05	; 5
   5A47 0E                  338 	.db #0x0E	; 14
   5A48 0F                  339 	.db #0x0F	; 15
   5A49 11                  340 	.db #0x11	; 17
   5A4A 13                  341 	.db #0x13	; 19
   5A4B                     342 _g_colors:
   5A4B 00                  343 	.db #0x00	; 0
   5A4C C0                  344 	.db #0xC0	; 192
   5A4D 0C                  345 	.db #0x0C	; 12
   5A4E CC                  346 	.db #0xCC	; 204
   5A4F 30                  347 	.db #0x30	; 48	'0'
   5A50 F0                  348 	.db #0xF0	; 240
   5A51 3C                  349 	.db #0x3C	; 60
   5A52 FC                  350 	.db #0xFC	; 252
   5A53 03                  351 	.db #0x03	; 3
   5A54 C3                  352 	.db #0xC3	; 195
   5A55 0F                  353 	.db #0x0F	; 15
   5A56 CF                  354 	.db #0xCF	; 207
   5A57 33                  355 	.db #0x33	; 51	'3'
   5A58 F3                  356 	.db #0xF3	; 243
   5A59 3F                  357 	.db #0x3F	; 63
   5A5A FF                  358 	.db #0xFF	; 255
   5A5B                     359 _g_pixelMask:
   5A5B AA                  360 	.db #0xAA	; 170
   5A5C 55                  361 	.db #0x55	; 85	'U'
   5A5D                     362 _g_texturedWalls:
   5A5D 01                  363 	.db #0x01	; 1
   5A5E                     364 _cells_in_view_array:
   5A5E E0 3C               365 	.dw #0x3CE0
   5A60                     366 _offsets_cells_in_view:
   5A60 08                  367 	.db #0x08	; 8
   5A61 0C                  368 	.db #0x0C	; 12
   5A62 0E                  369 	.db #0x0E	; 14
   5A63 0F                  370 	.db #0x0F	; 15
   5A64 10                  371 	.db #0x10	; 16
                            372 ;src/Renderer.c:118: void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
                            373 ;	---------------------------------
                            374 ; Function draw_column_to_buffer_untextured
                            375 ; ---------------------------------
   5A65                     376 _draw_column_to_buffer_untextured::
   5A65 DD E5         [15]  377 	push	ix
   5A67 DD 21 00 00   [14]  378 	ld	ix,#0
   5A6B DD 39         [15]  379 	add	ix,sp
   5A6D F5            [11]  380 	push	af
                            381 ;src/Renderer.c:119: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   5A6E DD 7E 04      [19]  382 	ld	a, 4 (ix)
   5A71 CB 3F         [ 8]  383 	srl	a
   5A73 C6 40         [ 7]  384 	add	a, #0x40
   5A75 4F            [ 4]  385 	ld	c,a
   5A76 3E 00         [ 7]  386 	ld	a,#0x00
   5A78 CE 29         [ 7]  387 	adc	a, #0x29
   5A7A 47            [ 4]  388 	ld	b,a
                            389 ;src/Renderer.c:121: u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
   5A7B 11 4B 5A      [10]  390 	ld	de,#_g_colors+0
   5A7E DD 6E 06      [19]  391 	ld	l,6 (ix)
   5A81 26 00         [ 7]  392 	ld	h,#0x00
   5A83 19            [11]  393 	add	hl,de
   5A84 7E            [ 7]  394 	ld	a,(hl)
   5A85 DD 77 FE      [19]  395 	ld	-2 (ix),a
                            396 ;src/Renderer.c:122: u8 pixMask = g_pixelMask[column&1];
   5A88 11 5B 5A      [10]  397 	ld	de,#_g_pixelMask+0
   5A8B DD 7E 04      [19]  398 	ld	a,4 (ix)
   5A8E E6 01         [ 7]  399 	and	a, #0x01
   5A90 6F            [ 4]  400 	ld	l,a
   5A91 26 00         [ 7]  401 	ld	h,#0x00
   5A93 19            [11]  402 	add	hl,de
   5A94 5E            [ 7]  403 	ld	e,(hl)
                            404 ;src/Renderer.c:131: if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
   5A95 3E 64         [ 7]  405 	ld	a,#0x64
   5A97 DD 96 05      [19]  406 	sub	a, 5 (ix)
   5A9A 30 04         [12]  407 	jr	NC,00102$
   5A9C DD 36 05 64   [19]  408 	ld	5 (ix),#0x64
   5AA0                     409 00102$:
                            410 ;src/Renderer.c:133: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   5AA0 DD 6E 05      [19]  411 	ld	l,5 (ix)
   5AA3 CB 3D         [ 8]  412 	srl	l
   5AA5 3E 32         [ 7]  413 	ld	a,#0x32
   5AA7 95            [ 4]  414 	sub	a, l
                            415 ;src/Renderer.c:136: pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
   5AA8 D5            [11]  416 	push	de
   5AA9 5F            [ 4]  417 	ld	e,a
   5AAA 16 00         [ 7]  418 	ld	d,#0x00
   5AAC 6B            [ 4]  419 	ld	l, e
   5AAD 62            [ 4]  420 	ld	h, d
   5AAE 29            [11]  421 	add	hl, hl
   5AAF 29            [11]  422 	add	hl, hl
   5AB0 19            [11]  423 	add	hl, de
   5AB1 29            [11]  424 	add	hl, hl
   5AB2 29            [11]  425 	add	hl, hl
   5AB3 29            [11]  426 	add	hl, hl
   5AB4 D1            [10]  427 	pop	de
   5AB5 09            [11]  428 	add	hl,bc
   5AB6 4D            [ 4]  429 	ld	c,l
   5AB7 44            [ 4]  430 	ld	b,h
                            431 ;src/Renderer.c:138: j=lineHeight;
   5AB8 DD 56 05      [19]  432 	ld	d,5 (ix)
                            433 ;src/Renderer.c:140: for(j;j;--j){
   5ABB 7B            [ 4]  434 	ld	a,e
   5ABC 2F            [ 4]  435 	cpl
   5ABD DD 77 FF      [19]  436 	ld	-1 (ix),a
   5AC0 7B            [ 4]  437 	ld	a,e
   5AC1 DD A6 FE      [19]  438 	and	a, -2 (ix)
   5AC4 5F            [ 4]  439 	ld	e,a
   5AC5                     440 00105$:
   5AC5 7A            [ 4]  441 	ld	a,d
   5AC6 B7            [ 4]  442 	or	a, a
   5AC7 28 0F         [12]  443 	jr	Z,00107$
                            444 ;src/Renderer.c:141: val =  ((*pvmem)&(~pixMask));
   5AC9 0A            [ 7]  445 	ld	a,(bc)
   5ACA DD A6 FF      [19]  446 	and	a, -1 (ix)
                            447 ;src/Renderer.c:143: *pvmem = val|(w_color&pixMask);
   5ACD B3            [ 4]  448 	or	a, e
   5ACE 02            [ 7]  449 	ld	(bc),a
                            450 ;src/Renderer.c:145: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   5ACF 21 28 00      [10]  451 	ld	hl,#0x0028
   5AD2 09            [11]  452 	add	hl,bc
   5AD3 4D            [ 4]  453 	ld	c,l
   5AD4 44            [ 4]  454 	ld	b,h
                            455 ;src/Renderer.c:140: for(j;j;--j){
   5AD5 15            [ 4]  456 	dec	d
   5AD6 18 ED         [12]  457 	jr	00105$
   5AD8                     458 00107$:
   5AD8 DD F9         [10]  459 	ld	sp, ix
   5ADA DD E1         [14]  460 	pop	ix
   5ADC C9            [10]  461 	ret
                            462 ;src/Renderer.c:149: void draw_column_to_buffer_object(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            463 ;	---------------------------------
                            464 ; Function draw_column_to_buffer_object
                            465 ; ---------------------------------
   5ADD                     466 _draw_column_to_buffer_object::
                            467 ;src/Renderer.c:151: }
   5ADD C9            [10]  468 	ret
                            469 ;src/Renderer.c:153: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            470 ;	---------------------------------
                            471 ; Function draw_column_to_buffer_enemy
                            472 ; ---------------------------------
   5ADE                     473 _draw_column_to_buffer_enemy::
   5ADE DD E5         [15]  474 	push	ix
   5AE0 DD 21 00 00   [14]  475 	ld	ix,#0
   5AE4 DD 39         [15]  476 	add	ix,sp
   5AE6 21 F2 FF      [10]  477 	ld	hl,#-14
   5AE9 39            [11]  478 	add	hl,sp
   5AEA F9            [ 6]  479 	ld	sp,hl
                            480 ;src/Renderer.c:170: u16 texture_line=0;
   5AEB DD 36 F5 00   [19]  481 	ld	-11 (ix),#0x00
   5AEF DD 36 F6 00   [19]  482 	ld	-10 (ix),#0x00
                            483 ;src/Renderer.c:172: if(texture_column>=4 && texture_column<28){
   5AF3 DD 7E 07      [19]  484 	ld	a,7 (ix)
   5AF6 D6 04         [ 7]  485 	sub	a, #0x04
   5AF8 DA 17 5C      [10]  486 	jp	C,00112$
   5AFB DD 7E 07      [19]  487 	ld	a,7 (ix)
   5AFE D6 1C         [ 7]  488 	sub	a, #0x1C
   5B00 D2 17 5C      [10]  489 	jp	NC,00112$
                            490 ;src/Renderer.c:175: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(index-1)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
   5B03 DD 4E 06      [19]  491 	ld	c,6 (ix)
   5B06 06 00         [ 7]  492 	ld	b,#0x00
   5B08 0B            [ 6]  493 	dec	bc
   5B09 69            [ 4]  494 	ld	l, c
   5B0A 60            [ 4]  495 	ld	h, b
   5B0B 29            [11]  496 	add	hl, hl
   5B0C 29            [11]  497 	add	hl, hl
   5B0D 29            [11]  498 	add	hl, hl
   5B0E 09            [11]  499 	add	hl, bc
   5B0F 29            [11]  500 	add	hl, hl
   5B10 29            [11]  501 	add	hl, hl
   5B11 29            [11]  502 	add	hl, hl
   5B12 29            [11]  503 	add	hl, hl
   5B13 29            [11]  504 	add	hl, hl
   5B14 29            [11]  505 	add	hl, hl
   5B15 01 40 18      [10]  506 	ld	bc,#0x1840
   5B18 09            [11]  507 	add	hl,bc
   5B19 4D            [ 4]  508 	ld	c,l
   5B1A 44            [ 4]  509 	ld	b,h
   5B1B DD 7E 07      [19]  510 	ld	a, 7 (ix)
   5B1E 16 00         [ 7]  511 	ld	d, #0x00
   5B20 C6 FC         [ 7]  512 	add	a,#0xFC
   5B22 5F            [ 4]  513 	ld	e,a
   5B23 7A            [ 4]  514 	ld	a,d
   5B24 CE FF         [ 7]  515 	adc	a,#0xFF
   5B26 57            [ 4]  516 	ld	d,a
   5B27 6B            [ 4]  517 	ld	l, e
   5B28 62            [ 4]  518 	ld	h, d
   5B29 29            [11]  519 	add	hl, hl
   5B2A 19            [11]  520 	add	hl, de
   5B2B 29            [11]  521 	add	hl, hl
   5B2C 29            [11]  522 	add	hl, hl
   5B2D 29            [11]  523 	add	hl, hl
   5B2E 09            [11]  524 	add	hl,bc
   5B2F 33            [ 6]  525 	inc	sp
   5B30 33            [ 6]  526 	inc	sp
   5B31 E5            [11]  527 	push	hl
                            528 ;src/Renderer.c:177: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   5B32 DD 7E 04      [19]  529 	ld	a,4 (ix)
   5B35 CB 3F         [ 8]  530 	srl	a
   5B37 C6 40         [ 7]  531 	add	a, #0x40
   5B39 DD 77 FC      [19]  532 	ld	-4 (ix),a
   5B3C 3E 00         [ 7]  533 	ld	a,#0x00
   5B3E CE 29         [ 7]  534 	adc	a, #0x29
   5B40 DD 77 FD      [19]  535 	ld	-3 (ix),a
                            536 ;src/Renderer.c:179: pixMask = g_pixelMask[column&1];
   5B43 01 5B 5A      [10]  537 	ld	bc,#_g_pixelMask+0
   5B46 DD 7E 04      [19]  538 	ld	a,4 (ix)
   5B49 E6 01         [ 7]  539 	and	a, #0x01
   5B4B 6F            [ 4]  540 	ld	l, a
   5B4C 26 00         [ 7]  541 	ld	h,#0x00
   5B4E 09            [11]  542 	add	hl,bc
   5B4F 7E            [ 7]  543 	ld	a,(hl)
   5B50 DD 77 F4      [19]  544 	ld	-12 (ix),a
                            545 ;src/Renderer.c:181: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
   5B53 DD 7E 05      [19]  546 	ld	a,5 (ix)
   5B56 CB 3F         [ 8]  547 	srl	a
   5B58 C6 32         [ 7]  548 	add	a, #0x32
   5B5A DD 77 F9      [19]  549 	ld	-7 (ix),a
                            550 ;src/Renderer.c:182: lineHeight = (lineHeight*3)/4;
   5B5D DD 4E 05      [19]  551 	ld	c,5 (ix)
   5B60 06 00         [ 7]  552 	ld	b,#0x00
   5B62 69            [ 4]  553 	ld	l, c
   5B63 60            [ 4]  554 	ld	h, b
   5B64 29            [11]  555 	add	hl, hl
   5B65 09            [11]  556 	add	hl, bc
   5B66 DD 75 FA      [19]  557 	ld	-6 (ix),l
   5B69 DD 74 FB      [19]  558 	ld	-5 (ix),h
   5B6C DD 7E FA      [19]  559 	ld	a,-6 (ix)
   5B6F DD 77 FE      [19]  560 	ld	-2 (ix),a
   5B72 DD 7E FB      [19]  561 	ld	a,-5 (ix)
   5B75 DD 77 FF      [19]  562 	ld	-1 (ix),a
   5B78 DD CB FB 7E   [20]  563 	bit	7, -5 (ix)
   5B7C 28 10         [12]  564 	jr	Z,00114$
   5B7E DD 7E FA      [19]  565 	ld	a,-6 (ix)
   5B81 C6 03         [ 7]  566 	add	a, #0x03
   5B83 DD 77 FE      [19]  567 	ld	-2 (ix),a
   5B86 DD 7E FB      [19]  568 	ld	a,-5 (ix)
   5B89 CE 00         [ 7]  569 	adc	a, #0x00
   5B8B DD 77 FF      [19]  570 	ld	-1 (ix),a
   5B8E                     571 00114$:
   5B8E DD 46 FE      [19]  572 	ld	b,-2 (ix)
   5B91 DD 4E FF      [19]  573 	ld	c,-1 (ix)
   5B94 CB 29         [ 8]  574 	sra	c
   5B96 CB 18         [ 8]  575 	rr	b
   5B98 CB 29         [ 8]  576 	sra	c
   5B9A CB 18         [ 8]  577 	rr	b
                            578 ;src/Renderer.c:183: enemy_top_height = ground_height - lineHeight;
   5B9C DD 7E F9      [19]  579 	ld	a,-7 (ix)
   5B9F 90            [ 4]  580 	sub	a, b
   5BA0 4F            [ 4]  581 	ld	c,a
                            582 ;src/Renderer.c:185: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
   5BA1 58            [ 4]  583 	ld	e,b
   5BA2 16 00         [ 7]  584 	ld	d,#0x00
   5BA4 C5            [11]  585 	push	bc
   5BA5 D5            [11]  586 	push	de
   5BA6 21 00 18      [10]  587 	ld	hl,#0x1800
   5BA9 E5            [11]  588 	push	hl
   5BAA CD F0 8F      [17]  589 	call	__divsint
   5BAD F1            [10]  590 	pop	af
   5BAE F1            [10]  591 	pop	af
   5BAF C1            [10]  592 	pop	bc
   5BB0 DD 75 F7      [19]  593 	ld	-9 (ix),l
   5BB3 DD 74 F8      [19]  594 	ld	-8 (ix),h
                            595 ;src/Renderer.c:186: j=lineHeight;
   5BB6 50            [ 4]  596 	ld	d,b
                            597 ;src/Renderer.c:188: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   5BB7 3E 64         [ 7]  598 	ld	a,#0x64
   5BB9 90            [ 4]  599 	sub	a, b
   5BBA 30 02         [12]  600 	jr	NC,00102$
                            601 ;src/Renderer.c:189: j=90;
   5BBC 16 5A         [ 7]  602 	ld	d,#0x5A
   5BBE                     603 00102$:
                            604 ;src/Renderer.c:192: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
   5BBE 06 00         [ 7]  605 	ld	b,#0x00
   5BC0 69            [ 4]  606 	ld	l, c
   5BC1 60            [ 4]  607 	ld	h, b
   5BC2 29            [11]  608 	add	hl, hl
   5BC3 29            [11]  609 	add	hl, hl
   5BC4 09            [11]  610 	add	hl, bc
   5BC5 29            [11]  611 	add	hl, hl
   5BC6 29            [11]  612 	add	hl, hl
   5BC7 29            [11]  613 	add	hl, hl
   5BC8 DD 7E FC      [19]  614 	ld	a,-4 (ix)
   5BCB 85            [ 4]  615 	add	a, l
   5BCC 4F            [ 4]  616 	ld	c,a
   5BCD DD 7E FD      [19]  617 	ld	a,-3 (ix)
   5BD0 8C            [ 4]  618 	adc	a, h
   5BD1 47            [ 4]  619 	ld	b,a
                            620 ;src/Renderer.c:194: for(j;j;--j){
   5BD2 DD 7E F4      [19]  621 	ld	a,-12 (ix)
   5BD5 2F            [ 4]  622 	cpl
   5BD6 5F            [ 4]  623 	ld	e,a
   5BD7                     624 00110$:
   5BD7 7A            [ 4]  625 	ld	a,d
   5BD8 B7            [ 4]  626 	or	a, a
   5BD9 28 3C         [12]  627 	jr	Z,00112$
                            628 ;src/Renderer.c:196: color= *(texture+(texture_line/256));
   5BDB DD 6E F6      [19]  629 	ld	l,-10 (ix)
   5BDE 26 00         [ 7]  630 	ld	h,#0x00
   5BE0 DD 7E F2      [19]  631 	ld	a,-14 (ix)
   5BE3 85            [ 4]  632 	add	a, l
   5BE4 6F            [ 4]  633 	ld	l,a
   5BE5 DD 7E F3      [19]  634 	ld	a,-13 (ix)
   5BE8 8C            [ 4]  635 	adc	a, h
   5BE9 67            [ 4]  636 	ld	h,a
   5BEA 7E            [ 7]  637 	ld	a,(hl)
                            638 ;src/Renderer.c:198: if(color){
   5BEB DD 77 FE      [19]  639 	ld	-2 (ix), a
   5BEE B7            [ 4]  640 	or	a, a
   5BEF 28 0B         [12]  641 	jr	Z,00104$
                            642 ;src/Renderer.c:199: val =  ((*pvmem)&(~pixMask));
   5BF1 0A            [ 7]  643 	ld	a,(bc)
   5BF2 A3            [ 4]  644 	and	a, e
   5BF3 6F            [ 4]  645 	ld	l,a
                            646 ;src/Renderer.c:201: color = (color&pixMask);
   5BF4 DD 7E FE      [19]  647 	ld	a,-2 (ix)
   5BF7 DD A6 F4      [19]  648 	and	a, -12 (ix)
                            649 ;src/Renderer.c:203: *pvmem = val|color;
   5BFA B5            [ 4]  650 	or	a, l
   5BFB 02            [ 7]  651 	ld	(bc),a
   5BFC                     652 00104$:
                            653 ;src/Renderer.c:206: texture_line += texture_line_add;
   5BFC DD 7E F5      [19]  654 	ld	a,-11 (ix)
   5BFF DD 86 F7      [19]  655 	add	a, -9 (ix)
   5C02 DD 77 F5      [19]  656 	ld	-11 (ix),a
   5C05 DD 7E F6      [19]  657 	ld	a,-10 (ix)
   5C08 DD 8E F8      [19]  658 	adc	a, -8 (ix)
   5C0B DD 77 F6      [19]  659 	ld	-10 (ix),a
                            660 ;src/Renderer.c:208: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   5C0E 21 28 00      [10]  661 	ld	hl,#0x0028
   5C11 09            [11]  662 	add	hl,bc
   5C12 4D            [ 4]  663 	ld	c,l
   5C13 44            [ 4]  664 	ld	b,h
                            665 ;src/Renderer.c:194: for(j;j;--j){
   5C14 15            [ 4]  666 	dec	d
   5C15 18 C0         [12]  667 	jr	00110$
   5C17                     668 00112$:
   5C17 DD F9         [10]  669 	ld	sp, ix
   5C19 DD E1         [14]  670 	pop	ix
   5C1B C9            [10]  671 	ret
                            672 ;src/Renderer.c:214: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
                            673 ;	---------------------------------
                            674 ; Function draw_column_to_buffer
                            675 ; ---------------------------------
   5C1C                     676 _draw_column_to_buffer::
   5C1C DD E5         [15]  677 	push	ix
   5C1E DD 21 00 00   [14]  678 	ld	ix,#0
   5C22 DD 39         [15]  679 	add	ix,sp
   5C24 21 F1 FF      [10]  680 	ld	hl,#-15
   5C27 39            [11]  681 	add	hl,sp
   5C28 F9            [ 6]  682 	ld	sp,hl
                            683 ;src/Renderer.c:215: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   5C29 DD 7E 04      [19]  684 	ld	a,4 (ix)
   5C2C CB 3F         [ 8]  685 	srl	a
   5C2E C6 40         [ 7]  686 	add	a, #0x40
   5C30 DD 77 FE      [19]  687 	ld	-2 (ix),a
   5C33 3E 00         [ 7]  688 	ld	a,#0x00
   5C35 CE 29         [ 7]  689 	adc	a, #0x29
   5C37 DD 77 FF      [19]  690 	ld	-1 (ix),a
                            691 ;src/Renderer.c:218: u8 pixMask = g_pixelMask[column&1];
   5C3A 01 5B 5A      [10]  692 	ld	bc,#_g_pixelMask+0
   5C3D DD 7E 04      [19]  693 	ld	a,4 (ix)
   5C40 E6 01         [ 7]  694 	and	a, #0x01
   5C42 6F            [ 4]  695 	ld	l, a
   5C43 26 00         [ 7]  696 	ld	h,#0x00
   5C45 09            [11]  697 	add	hl,bc
   5C46 7E            [ 7]  698 	ld	a,(hl)
   5C47 DD 77 F2      [19]  699 	ld	-14 (ix),a
                            700 ;src/Renderer.c:223: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
   5C4A DD 7E 06      [19]  701 	ld	a, 6 (ix)
   5C4D 87            [ 4]  702 	add	a, a
   5C4E 87            [ 4]  703 	add	a, a
   5C4F 47            [ 4]  704 	ld	b,a
   5C50 0E 00         [ 7]  705 	ld	c,#0x00
   5C52 21 40 04      [10]  706 	ld	hl,#0x0440
   5C55 09            [11]  707 	add	hl,bc
   5C56 4D            [ 4]  708 	ld	c,l
   5C57 44            [ 4]  709 	ld	b,h
   5C58 DD 6E 07      [19]  710 	ld	l,7 (ix)
   5C5B 26 00         [ 7]  711 	ld	h,#0x00
   5C5D 29            [11]  712 	add	hl, hl
   5C5E 29            [11]  713 	add	hl, hl
   5C5F 29            [11]  714 	add	hl, hl
   5C60 29            [11]  715 	add	hl, hl
   5C61 29            [11]  716 	add	hl, hl
   5C62 09            [11]  717 	add	hl,bc
   5C63 DD 75 F6      [19]  718 	ld	-10 (ix),l
   5C66 DD 74 F7      [19]  719 	ld	-9 (ix),h
                            720 ;src/Renderer.c:225: u8 j=lineHeight;
   5C69 DD 7E 05      [19]  721 	ld	a,5 (ix)
                            722 ;src/Renderer.c:231: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
   5C6C DD 77 F3      [19]  723 	ld	-13 (ix), a
   5C6F DD 77 FA      [19]  724 	ld	-6 (ix),a
   5C72 DD 36 FB 00   [19]  725 	ld	-5 (ix),#0x00
   5C76 DD 6E FA      [19]  726 	ld	l,-6 (ix)
   5C79 DD 66 FB      [19]  727 	ld	h,-5 (ix)
   5C7C E5            [11]  728 	push	hl
   5C7D 21 00 20      [10]  729 	ld	hl,#0x2000
   5C80 E5            [11]  730 	push	hl
   5C81 CD F0 8F      [17]  731 	call	__divsint
   5C84 F1            [10]  732 	pop	af
   5C85 F1            [10]  733 	pop	af
   5C86 DD 75 F4      [19]  734 	ld	-12 (ix),l
   5C89 DD 74 F5      [19]  735 	ld	-11 (ix),h
                            736 ;src/Renderer.c:232: u16 wall_texture_line=0;
   5C8C DD 36 F8 00   [19]  737 	ld	-8 (ix),#0x00
   5C90 DD 36 F9 00   [19]  738 	ld	-7 (ix),#0x00
                            739 ;src/Renderer.c:234: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   5C94 DD 4E F3      [19]  740 	ld	c,-13 (ix)
   5C97 CB 39         [ 8]  741 	srl	c
   5C99 3E 32         [ 7]  742 	ld	a,#0x32
   5C9B 91            [ 4]  743 	sub	a, c
   5C9C DD 77 F1      [19]  744 	ld	-15 (ix),a
                            745 ;src/Renderer.c:238: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   5C9F 3E 64         [ 7]  746 	ld	a,#0x64
   5CA1 DD 96 F3      [19]  747 	sub	a, -13 (ix)
   5CA4 30 4B         [12]  748 	jr	NC,00102$
                            749 ;src/Renderer.c:239: ceiling_height=0;
   5CA6 DD 36 F1 00   [19]  750 	ld	-15 (ix),#0x00
                            751 ;src/Renderer.c:240: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
   5CAA DD 7E FA      [19]  752 	ld	a,-6 (ix)
   5CAD C6 9C         [ 7]  753 	add	a,#0x9C
   5CAF 4F            [ 4]  754 	ld	c,a
   5CB0 DD 7E FB      [19]  755 	ld	a,-5 (ix)
   5CB3 CE FF         [ 7]  756 	adc	a,#0xFF
   5CB5 47            [ 4]  757 	ld	b,a
   5CB6 DD 71 FC      [19]  758 	ld	-4 (ix),c
   5CB9 DD 70 FD      [19]  759 	ld	-3 (ix),b
   5CBC CB 78         [ 8]  760 	bit	7, b
   5CBE 28 10         [12]  761 	jr	Z,00111$
   5CC0 DD 7E FA      [19]  762 	ld	a,-6 (ix)
   5CC3 C6 9D         [ 7]  763 	add	a, #0x9D
   5CC5 DD 77 FC      [19]  764 	ld	-4 (ix),a
   5CC8 DD 7E FB      [19]  765 	ld	a,-5 (ix)
   5CCB CE FF         [ 7]  766 	adc	a, #0xFF
   5CCD DD 77 FD      [19]  767 	ld	-3 (ix),a
   5CD0                     768 00111$:
   5CD0 DD 4E FC      [19]  769 	ld	c,-4 (ix)
   5CD3 DD 46 FD      [19]  770 	ld	b,-3 (ix)
   5CD6 CB 28         [ 8]  771 	sra	b
   5CD8 CB 19         [ 8]  772 	rr	c
   5CDA DD 6E F4      [19]  773 	ld	l,-12 (ix)
   5CDD DD 66 F5      [19]  774 	ld	h,-11 (ix)
   5CE0 E5            [11]  775 	push	hl
   5CE1 C5            [11]  776 	push	bc
   5CE2 CD 49 8E      [17]  777 	call	__mulint
   5CE5 F1            [10]  778 	pop	af
   5CE6 F1            [10]  779 	pop	af
   5CE7 DD 75 F8      [19]  780 	ld	-8 (ix),l
   5CEA DD 74 F9      [19]  781 	ld	-7 (ix),h
                            782 ;src/Renderer.c:241: j=SCREEN_TEXTURE_HEIGHT;
   5CED DD 36 F3 64   [19]  783 	ld	-13 (ix),#0x64
   5CF1                     784 00102$:
                            785 ;src/Renderer.c:244: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
   5CF1 DD 4E F1      [19]  786 	ld	c,-15 (ix)
   5CF4 06 00         [ 7]  787 	ld	b,#0x00
   5CF6 69            [ 4]  788 	ld	l, c
   5CF7 60            [ 4]  789 	ld	h, b
   5CF8 29            [11]  790 	add	hl, hl
   5CF9 29            [11]  791 	add	hl, hl
   5CFA 09            [11]  792 	add	hl, bc
   5CFB 29            [11]  793 	add	hl, hl
   5CFC 29            [11]  794 	add	hl, hl
   5CFD 29            [11]  795 	add	hl, hl
   5CFE DD 7E FE      [19]  796 	ld	a,-2 (ix)
   5D01 85            [ 4]  797 	add	a, l
   5D02 4F            [ 4]  798 	ld	c,a
   5D03 DD 7E FF      [19]  799 	ld	a,-1 (ix)
   5D06 8C            [ 4]  800 	adc	a, h
   5D07 47            [ 4]  801 	ld	b,a
                            802 ;src/Renderer.c:246: for(j;j;--j){
   5D08 DD 7E F2      [19]  803 	ld	a,-14 (ix)
   5D0B 2F            [ 4]  804 	cpl
   5D0C DD 77 FC      [19]  805 	ld	-4 (ix),a
   5D0F DD 56 F3      [19]  806 	ld	d,-13 (ix)
   5D12                     807 00107$:
   5D12 7A            [ 4]  808 	ld	a,d
   5D13 B7            [ 4]  809 	or	a, a
   5D14 28 39         [12]  810 	jr	Z,00109$
                            811 ;src/Renderer.c:248: w_color = *(texture+(wall_texture_line/256));
   5D16 DD 7E F9      [19]  812 	ld	a, -7 (ix)
   5D19 26 00         [ 7]  813 	ld	h, #0x00
   5D1B DD 86 F6      [19]  814 	add	a, -10 (ix)
   5D1E 6F            [ 4]  815 	ld	l,a
   5D1F 7C            [ 4]  816 	ld	a,h
   5D20 DD 8E F7      [19]  817 	adc	a, -9 (ix)
   5D23 67            [ 4]  818 	ld	h,a
   5D24 5E            [ 7]  819 	ld	e,(hl)
                            820 ;src/Renderer.c:250: if(w_color){
   5D25 7B            [ 4]  821 	ld	a,e
   5D26 B7            [ 4]  822 	or	a, a
   5D27 28 0B         [12]  823 	jr	Z,00104$
                            824 ;src/Renderer.c:252: val =  ((*pvmem)&(~pixMask));
   5D29 0A            [ 7]  825 	ld	a,(bc)
   5D2A DD A6 FC      [19]  826 	and	a, -4 (ix)
   5D2D 6F            [ 4]  827 	ld	l,a
                            828 ;src/Renderer.c:254: w_color = (w_color&pixMask);
   5D2E 7B            [ 4]  829 	ld	a,e
   5D2F DD A6 F2      [19]  830 	and	a, -14 (ix)
                            831 ;src/Renderer.c:256: *pvmem = val|w_color;
   5D32 B5            [ 4]  832 	or	a, l
   5D33 02            [ 7]  833 	ld	(bc),a
   5D34                     834 00104$:
                            835 ;src/Renderer.c:260: wall_texture_line += wall_texture_line_add;
   5D34 DD 7E F8      [19]  836 	ld	a,-8 (ix)
   5D37 DD 86 F4      [19]  837 	add	a, -12 (ix)
   5D3A DD 77 F8      [19]  838 	ld	-8 (ix),a
   5D3D DD 7E F9      [19]  839 	ld	a,-7 (ix)
   5D40 DD 8E F5      [19]  840 	adc	a, -11 (ix)
   5D43 DD 77 F9      [19]  841 	ld	-7 (ix),a
                            842 ;src/Renderer.c:262: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   5D46 21 28 00      [10]  843 	ld	hl,#0x0028
   5D49 09            [11]  844 	add	hl,bc
   5D4A 4D            [ 4]  845 	ld	c,l
   5D4B 44            [ 4]  846 	ld	b,h
                            847 ;src/Renderer.c:246: for(j;j;--j){
   5D4C 15            [ 4]  848 	dec	d
   5D4D 18 C3         [12]  849 	jr	00107$
   5D4F                     850 00109$:
   5D4F DD F9         [10]  851 	ld	sp, ix
   5D51 DD E1         [14]  852 	pop	ix
   5D53 C9            [10]  853 	ret
                            854 ;src/Renderer.c:266: void render_draw_to_buffer(){//TODO Optimize
                            855 ;	---------------------------------
                            856 ; Function render_draw_to_buffer
                            857 ; ---------------------------------
   5D54                     858 _render_draw_to_buffer::
   5D54 DD E5         [15]  859 	push	ix
   5D56 DD 21 00 00   [14]  860 	ld	ix,#0
   5D5A DD 39         [15]  861 	add	ix,sp
   5D5C 21 C6 FF      [10]  862 	ld	hl,#-58
   5D5F 39            [11]  863 	add	hl,sp
   5D60 F9            [ 6]  864 	ld	sp,hl
                            865 ;src/Renderer.c:276: u8 zHeight = 5;
   5D61 DD 36 D0 05   [19]  866 	ld	-48 (ix),#0x05
                            867 ;src/Renderer.c:282: u8 offsetDiff = 16;
   5D65 DD 36 D4 10   [19]  868 	ld	-44 (ix),#0x10
                            869 ;src/Renderer.c:287: u8 lineStart = 0;
   5D69 DD 36 D2 00   [19]  870 	ld	-46 (ix),#0x00
                            871 ;src/Renderer.c:289: u8 lateralWallWidth=0;
   5D6D DD 36 C6 00   [19]  872 	ld	-58 (ix),#0x00
                            873 ;src/Renderer.c:301: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   5D71 21 52 5A      [10]  874 	ld	hl, #_g_colors + 7
   5D74 46            [ 7]  875 	ld	b,(hl)
   5D75 21 A8 07      [10]  876 	ld	hl,#0x07A8
   5D78 E5            [11]  877 	push	hl
   5D79 C5            [11]  878 	push	bc
   5D7A 33            [ 6]  879 	inc	sp
   5D7B 21 40 29      [10]  880 	ld	hl,#0x2940
   5D7E E5            [11]  881 	push	hl
   5D7F CD F1 8E      [17]  882 	call	_cpct_memset
                            883 ;src/Renderer.c:302: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
   5D82 21 4C 5A      [10]  884 	ld	hl, #_g_colors + 1
   5D85 46            [ 7]  885 	ld	b,(hl)
   5D86 21 50 00      [10]  886 	ld	hl,#0x0050
   5D89 E5            [11]  887 	push	hl
   5D8A C5            [11]  888 	push	bc
   5D8B 33            [ 6]  889 	inc	sp
   5D8C 21 E8 30      [10]  890 	ld	hl,#0x30E8
   5D8F E5            [11]  891 	push	hl
   5D90 CD F1 8E      [17]  892 	call	_cpct_memset
                            893 ;src/Renderer.c:303: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   5D93 21 53 5A      [10]  894 	ld	hl, #_g_colors + 8
   5D96 46            [ 7]  895 	ld	b,(hl)
   5D97 21 A8 07      [10]  896 	ld	hl,#0x07A8
   5D9A E5            [11]  897 	push	hl
   5D9B C5            [11]  898 	push	bc
   5D9C 33            [ 6]  899 	inc	sp
   5D9D 21 38 31      [10]  900 	ld	hl,#0x3138
   5DA0 E5            [11]  901 	push	hl
   5DA1 CD F1 8E      [17]  902 	call	_cpct_memset
                            903 ;src/Renderer.c:305: calculate_cells_in_view();
   5DA4 CD 8C 58      [17]  904 	call	_calculate_cells_in_view
                            905 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   5DA7 2A 5E 5A      [16]  906 	ld	hl,(_cells_in_view_array)
   5DAA DD 75 E0      [19]  907 	ld	-32 (ix),l
   5DAD DD 74 E1      [19]  908 	ld	-31 (ix),h
                            909 ;src/Renderer.c:307: if(g_texturedWalls){
   5DB0 3A 5D 5A      [13]  910 	ld	a,(#_g_texturedWalls + 0)
   5DB3 B7            [ 4]  911 	or	a, a
   5DB4 CA FC 62      [10]  912 	jp	Z,00358$
                            913 ;src/Renderer.c:309: do{
   5DB7 DD 36 CB 06   [19]  914 	ld	-53 (ix),#0x06
   5DBB                     915 00175$:
                            916 ;src/Renderer.c:311: --z;
   5DBB DD 35 CB      [23]  917 	dec	-53 (ix)
                            918 ;src/Renderer.c:315: xCellCount = (z) ? (zHeight >> 1) : 0;
   5DBE DD 7E D0      [19]  919 	ld	a,-48 (ix)
   5DC1 CB 3F         [ 8]  920 	srl	a
   5DC3 DD 77 E6      [19]  921 	ld	-26 (ix),a
   5DC6 DD 7E CB      [19]  922 	ld	a,-53 (ix)
   5DC9 B7            [ 4]  923 	or	a, a
   5DCA 28 05         [12]  924 	jr	Z,00262$
   5DCC DD 4E E6      [19]  925 	ld	c,-26 (ix)
   5DCF 18 02         [12]  926 	jr	00263$
   5DD1                     927 00262$:
   5DD1 0E 00         [ 7]  928 	ld	c,#0x00
   5DD3                     929 00263$:
   5DD3 DD 71 E8      [19]  930 	ld	-24 (ix),c
                            931 ;src/Renderer.c:316: lateralWallSlope=0;
   5DD6 DD 36 EC 00   [19]  932 	ld	-20 (ix),#0x00
                            933 ;src/Renderer.c:317: lateralWallSlopeCounter=0;
   5DDA DD 36 F9 00   [19]  934 	ld	-7 (ix),#0x00
                            935 ;src/Renderer.c:318: xHeight=0;
   5DDE DD 36 D7 00   [19]  936 	ld	-41 (ix),#0x00
                            937 ;src/Renderer.c:320: lateralWallCounter = 0;
   5DE2 DD 36 E9 00   [19]  938 	ld	-23 (ix),#0x00
                            939 ;src/Renderer.c:322: newCell=1;
   5DE6 DD 36 F6 01   [19]  940 	ld	-10 (ix),#0x01
                            941 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   5DEA DD 7E D2      [19]  942 	ld	a,-46 (ix)
   5DED DD 77 FE      [19]  943 	ld	-2 (ix),a
   5DF0 DD 36 FF 00   [19]  944 	ld	-1 (ix),#0x00
   5DF4 DD 4E FE      [19]  945 	ld	c,-2 (ix)
   5DF7 DD 46 FF      [19]  946 	ld	b,-1 (ix)
   5DFA 03            [ 6]  947 	inc	bc
   5DFB DD 6E E0      [19]  948 	ld	l,-32 (ix)
   5DFE DD 66 E1      [19]  949 	ld	h,-31 (ix)
   5E01 09            [11]  950 	add	hl,bc
   5E02 7E            [ 7]  951 	ld	a,(hl)
   5E03 DD 77 E2      [19]  952 	ld	-30 (ix),a
                            953 ;src/Renderer.c:325: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   5E06 DD 7E E0      [19]  954 	ld	a,-32 (ix)
   5E09 DD 86 D2      [19]  955 	add	a, -46 (ix)
   5E0C 6F            [ 4]  956 	ld	l,a
   5E0D DD 7E E1      [19]  957 	ld	a,-31 (ix)
   5E10 CE 00         [ 7]  958 	adc	a, #0x00
   5E12 67            [ 4]  959 	ld	h,a
   5E13 4E            [ 7]  960 	ld	c,(hl)
                            961 ;src/Renderer.c:326: if(lastCellWasWall&CELL_WALL_MASK){
   5E14 CB 79         [ 8]  962 	bit	7, c
   5E16 28 09         [12]  963 	jr	Z,00102$
                            964 ;src/Renderer.c:327: lastWallId=lastCellWasWall;
   5E18 DD 71 E5      [19]  965 	ld	-27 (ix),c
                            966 ;src/Renderer.c:328: lastCellWasWall=1;
   5E1B DD 36 E7 01   [19]  967 	ld	-25 (ix),#0x01
   5E1F 18 08         [12]  968 	jr	00296$
   5E21                     969 00102$:
                            970 ;src/Renderer.c:331: lastCellWasWall=0;
   5E21 DD 36 E7 00   [19]  971 	ld	-25 (ix),#0x00
                            972 ;src/Renderer.c:332: lastWallId=CELLTYPE_FLOOR;
   5E25 DD 36 E5 00   [19]  973 	ld	-27 (ix),#0x00
                            974 ;src/Renderer.c:335: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   5E29                     975 00296$:
   5E29 DD 36 CE 00   [19]  976 	ld	-50 (ix),#0x00
   5E2D DD 36 D6 00   [19]  977 	ld	-42 (ix),#0x00
   5E31                     978 00252$:
                            979 ;src/Renderer.c:337: if (xCellCount == zHeight)
   5E31 DD 7E D0      [19]  980 	ld	a,-48 (ix)
   5E34 DD 96 E8      [19]  981 	sub	a, -24 (ix)
   5E37 20 4B         [12]  982 	jr	NZ,00105$
                            983 ;src/Renderer.c:339: ++xCell;
   5E39 DD 34 CE      [23]  984 	inc	-50 (ix)
                            985 ;src/Renderer.c:340: xCellCount = 0;
   5E3C DD 36 E8 00   [19]  986 	ld	-24 (ix),#0x00
                            987 ;src/Renderer.c:341: newCell=1;
   5E40 DD 36 F6 01   [19]  988 	ld	-10 (ix),#0x01
                            989 ;src/Renderer.c:342: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   5E44 DD 7E CE      [19]  990 	ld	a,-50 (ix)
   5E47 DD 77 ED      [19]  991 	ld	-19 (ix),a
   5E4A DD 36 EE 00   [19]  992 	ld	-18 (ix),#0x00
   5E4E DD 7E FE      [19]  993 	ld	a,-2 (ix)
   5E51 DD 86 ED      [19]  994 	add	a, -19 (ix)
   5E54 DD 77 ED      [19]  995 	ld	-19 (ix),a
   5E57 DD 7E FF      [19]  996 	ld	a,-1 (ix)
   5E5A DD 8E EE      [19]  997 	adc	a, -18 (ix)
   5E5D DD 77 EE      [19]  998 	ld	-18 (ix),a
   5E60 DD 34 ED      [23]  999 	inc	-19 (ix)
   5E63 20 03         [12] 1000 	jr	NZ,00608$
   5E65 DD 34 EE      [23] 1001 	inc	-18 (ix)
   5E68                    1002 00608$:
   5E68 DD 7E E0      [19] 1003 	ld	a,-32 (ix)
   5E6B DD 86 ED      [19] 1004 	add	a, -19 (ix)
   5E6E DD 77 ED      [19] 1005 	ld	-19 (ix),a
   5E71 DD 7E E1      [19] 1006 	ld	a,-31 (ix)
   5E74 DD 8E EE      [19] 1007 	adc	a, -18 (ix)
   5E77 DD 77 EE      [19] 1008 	ld	-18 (ix),a
   5E7A DD 6E ED      [19] 1009 	ld	l,-19 (ix)
   5E7D DD 66 EE      [19] 1010 	ld	h,-18 (ix)
   5E80 7E            [ 7] 1011 	ld	a,(hl)
   5E81 DD 77 E2      [19] 1012 	ld	-30 (ix),a
   5E84                    1013 00105$:
                           1014 ;src/Renderer.c:344: if(!(x%2)){
   5E84 DD 7E D6      [19] 1015 	ld	a,-42 (ix)
   5E87 E6 01         [ 7] 1016 	and	a, #0x01
   5E89 DD 77 ED      [19] 1017 	ld	-19 (ix),a
                           1018 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   5E8C DD 7E E2      [19] 1019 	ld	a,-30 (ix)
   5E8F E6 80         [ 7] 1020 	and	a, #0x80
   5E91 DD 77 F3      [19] 1021 	ld	-13 (ix),a
                           1022 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   5E94 DD 7E E8      [19] 1023 	ld	a,-24 (ix)
   5E97 DD 77 F7      [19] 1024 	ld	-9 (ix),a
   5E9A DD 36 F8 00   [19] 1025 	ld	-8 (ix),#0x00
   5E9E DD 7E D0      [19] 1026 	ld	a,-48 (ix)
   5EA1 DD 77 FA      [19] 1027 	ld	-6 (ix),a
                           1028 ;src/Renderer.c:344: if(!(x%2)){
   5EA4 DD 7E ED      [19] 1029 	ld	a,-19 (ix)
   5EA7 B7            [ 4] 1030 	or	a, a
   5EA8 C2 5B 5F      [10] 1031 	jp	NZ,00118$
                           1032 ;src/Renderer.c:345: if ((lateralWallCounter == 0)||newCell)
   5EAB DD 7E E9      [19] 1033 	ld	a,-23 (ix)
   5EAE B7            [ 4] 1034 	or	a, a
   5EAF 28 07         [12] 1035 	jr	Z,00114$
   5EB1 DD 7E F6      [19] 1036 	ld	a,-10 (ix)
   5EB4 B7            [ 4] 1037 	or	a, a
   5EB5 CA 5B 5F      [10] 1038 	jp	Z,00118$
   5EB8                    1039 00114$:
                           1040 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   5EB8 DD 7E F3      [19] 1041 	ld	a,-13 (ix)
   5EBB B7            [ 4] 1042 	or	a, a
   5EBC 28 22         [12] 1043 	jr	Z,00112$
                           1044 ;src/Renderer.c:349: lateralWallCounter = 0;//(zHeight - xCellCount);
   5EBE DD 36 E9 00   [19] 1045 	ld	-23 (ix),#0x00
                           1046 ;src/Renderer.c:350: lateralWallSlope = 0;
   5EC2 DD 36 EC 00   [19] 1047 	ld	-20 (ix),#0x00
                           1048 ;src/Renderer.c:351: xHeight = zHeight;
   5EC6 DD 7E D0      [19] 1049 	ld	a,-48 (ix)
   5EC9 DD 77 D7      [19] 1050 	ld	-41 (ix),a
                           1051 ;src/Renderer.c:352: color = currentCellID&0b01111111;
   5ECC DD 7E E2      [19] 1052 	ld	a,-30 (ix)
   5ECF E6 7F         [ 7] 1053 	and	a, #0x7F
   5ED1 DD 77 FB      [19] 1054 	ld	-5 (ix),a
                           1055 ;src/Renderer.c:353: lastCellWasWall = 1;
   5ED4 DD 36 E7 01   [19] 1056 	ld	-25 (ix),#0x01
                           1057 ;src/Renderer.c:354: lastWallId=currentCellID;
   5ED8 DD 7E E2      [19] 1058 	ld	a,-30 (ix)
   5EDB DD 77 E5      [19] 1059 	ld	-27 (ix),a
   5EDE 18 77         [12] 1060 	jr	00113$
   5EE0                    1061 00112$:
                           1062 ;src/Renderer.c:357: if(lateralWallCounter==0){//Lateral wall not finished
   5EE0 DD 7E E9      [19] 1063 	ld	a,-23 (ix)
   5EE3 B7            [ 4] 1064 	or	a, a
   5EE4 20 71         [12] 1065 	jr	NZ,00113$
                           1066 ;src/Renderer.c:358: if (lastCellWasWall)
   5EE6 DD 7E E7      [19] 1067 	ld	a,-25 (ix)
   5EE9 B7            [ 4] 1068 	or	a, a
   5EEA 28 5B         [12] 1069 	jr	Z,00107$
                           1070 ;src/Renderer.c:361: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   5EEC DD 7E D4      [19] 1071 	ld	a,-44 (ix)
   5EEF DD 96 CE      [19] 1072 	sub	a, -50 (ix)
   5EF2 87            [ 4] 1073 	add	a, a
   5EF3 3C            [ 4] 1074 	inc	a
                           1075 ;src/Renderer.c:362: lateralWallSlopeCounter = lateralWallSlope / 2;
   5EF4 DD 77 EC      [19] 1076 	ld	-20 (ix), a
   5EF7 CB 3F         [ 8] 1077 	srl	a
   5EF9 DD 77 F9      [19] 1078 	ld	-7 (ix),a
                           1079 ;src/Renderer.c:363: lateralWallCounter = lateralWallSlope * zHeight;
   5EFC DD 5E D0      [19] 1080 	ld	e,-48 (ix)
   5EFF DD 66 EC      [19] 1081 	ld	h,-20 (ix)
   5F02 2E 00         [ 7] 1082 	ld	l, #0x00
   5F04 55            [ 4] 1083 	ld	d, l
   5F05 06 08         [ 7] 1084 	ld	b, #0x08
   5F07                    1085 00609$:
   5F07 29            [11] 1086 	add	hl,hl
   5F08 30 01         [12] 1087 	jr	NC,00610$
   5F0A 19            [11] 1088 	add	hl,de
   5F0B                    1089 00610$:
   5F0B 10 FA         [13] 1090 	djnz	00609$
                           1091 ;src/Renderer.c:364: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   5F0D 7D            [ 4] 1092 	ld	a,l
   5F0E E6 FC         [ 7] 1093 	and	a, #0xFC
   5F10 CB C7         [ 8] 1094 	set	0, a
   5F12 CB 3F         [ 8] 1095 	srl	a
   5F14 CB 3F         [ 8] 1096 	srl	a
   5F16 DD 96 E8      [19] 1097 	sub	a, -24 (ix)
                           1098 ;src/Renderer.c:365: lateralWallWidth=lateralWallCounter;
   5F19 DD 77 E9      [19] 1099 	ld	-23 (ix), a
   5F1C DD 77 C6      [19] 1100 	ld	-58 (ix),a
                           1101 ;src/Renderer.c:366: lastCellWasWall = 0;
   5F1F DD 36 E7 00   [19] 1102 	ld	-25 (ix),#0x00
                           1103 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   5F23 DD 6E F7      [19] 1104 	ld	l,-9 (ix)
   5F26 DD 66 F8      [19] 1105 	ld	h,-8 (ix)
   5F29 29            [11] 1106 	add	hl, hl
   5F2A DD 4E EC      [19] 1107 	ld	c,-20 (ix)
   5F2D 06 00         [ 7] 1108 	ld	b,#0x00
   5F2F C5            [11] 1109 	push	bc
   5F30 E5            [11] 1110 	push	hl
   5F31 CD F0 8F      [17] 1111 	call	__divsint
   5F34 F1            [10] 1112 	pop	af
   5F35 F1            [10] 1113 	pop	af
   5F36 DD 7E FA      [19] 1114 	ld	a,-6 (ix)
   5F39 95            [ 4] 1115 	sub	a, l
   5F3A DD 77 D7      [19] 1116 	ld	-41 (ix),a
                           1117 ;src/Renderer.c:368: color = lastWallId&0b01111111;
   5F3D DD 7E E5      [19] 1118 	ld	a,-27 (ix)
   5F40 E6 7F         [ 7] 1119 	and	a, #0x7F
   5F42 DD 77 FB      [19] 1120 	ld	-5 (ix),a
   5F45 18 10         [12] 1121 	jr	00113$
   5F47                    1122 00107$:
                           1123 ;src/Renderer.c:372: xHeight = 0;
   5F47 DD 36 D7 00   [19] 1124 	ld	-41 (ix),#0x00
                           1125 ;src/Renderer.c:373: lastCellWasWall = 0;
   5F4B DD 36 E7 00   [19] 1126 	ld	-25 (ix),#0x00
                           1127 ;src/Renderer.c:374: lateralWallSlope=0;
   5F4F DD 36 EC 00   [19] 1128 	ld	-20 (ix),#0x00
                           1129 ;src/Renderer.c:375: lastWallId=0;
   5F53 DD 36 E5 00   [19] 1130 	ld	-27 (ix),#0x00
   5F57                    1131 00113$:
                           1132 ;src/Renderer.c:379: newCell=0;
   5F57 DD 36 F6 00   [19] 1133 	ld	-10 (ix),#0x00
   5F5B                    1134 00118$:
                           1135 ;src/Renderer.c:382: if (lateralWallCounter > 0)
   5F5B DD 7E E9      [19] 1136 	ld	a,-23 (ix)
   5F5E B7            [ 4] 1137 	or	a, a
   5F5F 28 1E         [12] 1138 	jr	Z,00124$
                           1139 ;src/Renderer.c:385: if (lateralWallSlope != 0)
   5F61 DD 7E EC      [19] 1140 	ld	a,-20 (ix)
   5F64 B7            [ 4] 1141 	or	a, a
   5F65 28 15         [12] 1142 	jr	Z,00122$
                           1143 ;src/Renderer.c:387: if (lateralWallSlopeCounter == lateralWallSlope)
   5F67 DD 7E F9      [19] 1144 	ld	a,-7 (ix)
   5F6A DD 96 EC      [19] 1145 	sub	a, -20 (ix)
   5F6D 20 0A         [12] 1146 	jr	NZ,00120$
                           1147 ;src/Renderer.c:389: lateralWallSlopeCounter = 0;
   5F6F DD 36 F9 00   [19] 1148 	ld	-7 (ix),#0x00
                           1149 ;src/Renderer.c:390: xHeight -= 2;
   5F73 DD 35 D7      [23] 1150 	dec	-41 (ix)
   5F76 DD 35 D7      [23] 1151 	dec	-41 (ix)
   5F79                    1152 00120$:
                           1153 ;src/Renderer.c:392: ++lateralWallSlopeCounter;
   5F79 DD 34 F9      [23] 1154 	inc	-7 (ix)
   5F7C                    1155 00122$:
                           1156 ;src/Renderer.c:395: --lateralWallCounter;
   5F7C DD 35 E9      [23] 1157 	dec	-23 (ix)
   5F7F                    1158 00124$:
                           1159 ;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   5F7F DD 7E D0      [19] 1160 	ld	a,-48 (ix)
   5F82 DD 77 FC      [19] 1161 	ld	-4 (ix),a
   5F85 DD 36 FD 00   [19] 1162 	ld	-3 (ix),#0x00
                           1163 ;src/Renderer.c:398: if (!(x%2))
   5F89 DD 7E ED      [19] 1164 	ld	a,-19 (ix)
   5F8C B7            [ 4] 1165 	or	a, a
   5F8D C2 0E 60      [10] 1166 	jp	NZ,00136$
                           1167 ;src/Renderer.c:408: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   5F90 DD 46 D6      [19] 1168 	ld	b,-42 (ix)
   5F93 CB 38         [ 8] 1169 	srl	b
                           1170 ;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   5F95 DD 6E F7      [19] 1171 	ld	l,-9 (ix)
   5F98 DD 66 F8      [19] 1172 	ld	h,-8 (ix)
   5F9B 29            [11] 1173 	add	hl, hl
   5F9C 29            [11] 1174 	add	hl, hl
   5F9D 29            [11] 1175 	add	hl, hl
   5F9E 29            [11] 1176 	add	hl, hl
   5F9F 29            [11] 1177 	add	hl, hl
   5FA0 C5            [11] 1178 	push	bc
   5FA1 DD 5E FC      [19] 1179 	ld	e,-4 (ix)
   5FA4 DD 56 FD      [19] 1180 	ld	d,-3 (ix)
   5FA7 D5            [11] 1181 	push	de
   5FA8 E5            [11] 1182 	push	hl
   5FA9 CD F0 8F      [17] 1183 	call	__divsint
   5FAC F1            [10] 1184 	pop	af
   5FAD F1            [10] 1185 	pop	af
   5FAE C1            [10] 1186 	pop	bc
   5FAF 4D            [ 4] 1187 	ld	c,l
                           1188 ;src/Renderer.c:400: if(xHeight > 0){
   5FB0 DD 7E D7      [19] 1189 	ld	a,-41 (ix)
   5FB3 B7            [ 4] 1190 	or	a, a
   5FB4 28 3A         [12] 1191 	jr	Z,00129$
                           1192 ;src/Renderer.c:401: if (lateralWallCounter > 0)
   5FB6 DD 7E E9      [19] 1193 	ld	a,-23 (ix)
   5FB9 B7            [ 4] 1194 	or	a, a
   5FBA 28 21         [12] 1195 	jr	Z,00126$
                           1196 ;src/Renderer.c:403: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   5FBC DD 5E C6      [19] 1197 	ld	e,-58 (ix)
   5FBF 16 00         [ 7] 1198 	ld	d,#0x00
   5FC1 DD 6E E9      [19] 1199 	ld	l,-23 (ix)
   5FC4 26 00         [ 7] 1200 	ld	h,#0x00
   5FC6 7B            [ 4] 1201 	ld	a,e
   5FC7 95            [ 4] 1202 	sub	a, l
   5FC8 6F            [ 4] 1203 	ld	l,a
   5FC9 7A            [ 4] 1204 	ld	a,d
   5FCA 9C            [ 4] 1205 	sbc	a, h
   5FCB 67            [ 4] 1206 	ld	h,a
   5FCC 29            [11] 1207 	add	hl, hl
   5FCD 29            [11] 1208 	add	hl, hl
   5FCE 29            [11] 1209 	add	hl, hl
   5FCF 29            [11] 1210 	add	hl, hl
   5FD0 29            [11] 1211 	add	hl, hl
   5FD1 C5            [11] 1212 	push	bc
   5FD2 D5            [11] 1213 	push	de
   5FD3 E5            [11] 1214 	push	hl
   5FD4 CD F0 8F      [17] 1215 	call	__divsint
   5FD7 F1            [10] 1216 	pop	af
   5FD8 F1            [10] 1217 	pop	af
   5FD9 C1            [10] 1218 	pop	bc
   5FDA 55            [ 4] 1219 	ld	d,l
   5FDB 18 01         [12] 1220 	jr	00127$
   5FDD                    1221 00126$:
                           1222 ;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   5FDD 51            [ 4] 1223 	ld	d,c
   5FDE                    1224 00127$:
                           1225 ;src/Renderer.c:408: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   5FDE C5            [11] 1226 	push	bc
   5FDF D5            [11] 1227 	push	de
   5FE0 33            [ 6] 1228 	inc	sp
   5FE1 DD 66 FB      [19] 1229 	ld	h,-5 (ix)
   5FE4 DD 6E D7      [19] 1230 	ld	l,-41 (ix)
   5FE7 E5            [11] 1231 	push	hl
   5FE8 C5            [11] 1232 	push	bc
   5FE9 33            [ 6] 1233 	inc	sp
   5FEA CD 1C 5C      [17] 1234 	call	_draw_column_to_buffer
   5FED F1            [10] 1235 	pop	af
   5FEE F1            [10] 1236 	pop	af
   5FEF C1            [10] 1237 	pop	bc
   5FF0                    1238 00129$:
                           1239 ;src/Renderer.c:410: if(!(currentCellID&CELL_WALL_MASK)){
   5FF0 DD 7E F3      [19] 1240 	ld	a,-13 (ix)
   5FF3 B7            [ 4] 1241 	or	a, a
   5FF4 20 18         [12] 1242 	jr	NZ,00136$
                           1243 ;src/Renderer.c:411: if(currentCellID&CELL_ENEMY_MASK){
   5FF6 DD 7E E2      [19] 1244 	ld	a,-30 (ix)
   5FF9 E6 0F         [ 7] 1245 	and	a, #0x0F
   5FFB 28 11         [12] 1246 	jr	Z,00136$
                           1247 ;src/Renderer.c:412: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   5FFD 79            [ 4] 1248 	ld	a,c
   5FFE F5            [11] 1249 	push	af
   5FFF 33            [ 6] 1250 	inc	sp
   6000 DD 66 E2      [19] 1251 	ld	h,-30 (ix)
   6003 DD 6E D0      [19] 1252 	ld	l,-48 (ix)
   6006 E5            [11] 1253 	push	hl
   6007 C5            [11] 1254 	push	bc
   6008 33            [ 6] 1255 	inc	sp
   6009 CD DE 5A      [17] 1256 	call	_draw_column_to_buffer_enemy
   600C F1            [10] 1257 	pop	af
   600D F1            [10] 1258 	pop	af
                           1259 ;src/Renderer.c:414: else if(currentCellID&CELL_ITEM_MASK){
   600E                    1260 00136$:
                           1261 ;src/Renderer.c:420: ++xCellCount;
   600E DD 34 E8      [23] 1262 	inc	-24 (ix)
                           1263 ;src/Renderer.c:335: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   6011 DD 34 D6      [23] 1264 	inc	-42 (ix)
                           1265 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   6014 2A 5E 5A      [16] 1266 	ld	hl,(_cells_in_view_array)
   6017 DD 75 E0      [19] 1267 	ld	-32 (ix),l
   601A DD 74 E1      [19] 1268 	ld	-31 (ix),h
                           1269 ;src/Renderer.c:335: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   601D DD 7E D6      [19] 1270 	ld	a,-42 (ix)
   6020 D6 50         [ 7] 1271 	sub	a, #0x50
   6022 DA 31 5E      [10] 1272 	jp	C,00252$
                           1273 ;src/Renderer.c:427: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   6025 DD 7E CB      [19] 1274 	ld	a,-53 (ix)
   6028 B7            [ 4] 1275 	or	a, a
   6029 28 05         [12] 1276 	jr	Z,00264$
   602B DD 4E E6      [19] 1277 	ld	c,-26 (ix)
   602E 18 02         [12] 1278 	jr	00265$
   6030                    1279 00264$:
   6030 0E 00         [ 7] 1280 	ld	c,#0x00
   6032                    1281 00265$:
   6032 DD 71 F7      [19] 1282 	ld	-9 (ix),c
                           1283 ;src/Renderer.c:428: lateralWallSlope=0;
   6035 DD 36 F3 00   [19] 1284 	ld	-13 (ix),#0x00
                           1285 ;src/Renderer.c:429: lateralWallSlopeCounter=0;
   6039 DD 36 ED 00   [19] 1286 	ld	-19 (ix),#0x00
                           1287 ;src/Renderer.c:430: xHeight=0;
   603D DD 36 E7 00   [19] 1288 	ld	-25 (ix),#0x00
                           1289 ;src/Renderer.c:432: lateralWallCounter = 0;
   6041 DD 36 E5 00   [19] 1290 	ld	-27 (ix),#0x00
                           1291 ;src/Renderer.c:433: lineEnd = lineStart + offsetDiff * 2 + 2;
   6045 DD 7E D4      [19] 1292 	ld	a,-44 (ix)
   6048 87            [ 4] 1293 	add	a, a
   6049 4F            [ 4] 1294 	ld	c,a
   604A DD 7E D2      [19] 1295 	ld	a,-46 (ix)
   604D 81            [ 4] 1296 	add	a, c
   604E DD 77 E2      [19] 1297 	ld	-30 (ix), a
   6051 4F            [ 4] 1298 	ld	c, a
   6052 0C            [ 4] 1299 	inc	c
   6053 0C            [ 4] 1300 	inc	c
                           1301 ;src/Renderer.c:435: newCell=1;
   6054 DD 36 FE 01   [19] 1302 	ld	-2 (ix),#0x01
                           1303 ;src/Renderer.c:436: currentCellID = cells_in_view_array[lineEnd - 1];
   6058 DD 71 DE      [19] 1304 	ld	-34 (ix),c
   605B DD 36 DF 00   [19] 1305 	ld	-33 (ix),#0x00
   605F DD 5E DE      [19] 1306 	ld	e,-34 (ix)
   6062 DD 56 DF      [19] 1307 	ld	d,-33 (ix)
   6065 1B            [ 6] 1308 	dec	de
   6066 DD 6E E0      [19] 1309 	ld	l,-32 (ix)
   6069 DD 66 E1      [19] 1310 	ld	h,-31 (ix)
   606C 19            [11] 1311 	add	hl,de
   606D 7E            [ 7] 1312 	ld	a,(hl)
   606E DD 77 F6      [19] 1313 	ld	-10 (ix),a
                           1314 ;src/Renderer.c:438: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   6071 DD 6E E0      [19] 1315 	ld	l,-32 (ix)
   6074 DD 66 E1      [19] 1316 	ld	h,-31 (ix)
   6077 06 00         [ 7] 1317 	ld	b,#0x00
   6079 09            [11] 1318 	add	hl, bc
   607A 4E            [ 7] 1319 	ld	c,(hl)
                           1320 ;src/Renderer.c:439: if(lastCellWasWall&CELL_WALL_MASK){
   607B CB 79         [ 8] 1321 	bit	7, c
   607D 28 09         [12] 1322 	jr	Z,00139$
                           1323 ;src/Renderer.c:440: lastWallId=lastCellWasWall;
   607F DD 71 E9      [19] 1324 	ld	-23 (ix),c
                           1325 ;src/Renderer.c:441: lastCellWasWall=1;
   6082 DD 36 D7 01   [19] 1326 	ld	-41 (ix),#0x01
   6086 18 08         [12] 1327 	jr	00315$
   6088                    1328 00139$:
                           1329 ;src/Renderer.c:444: lastCellWasWall=0;
   6088 DD 36 D7 00   [19] 1330 	ld	-41 (ix),#0x00
                           1331 ;src/Renderer.c:445: lastWallId=CELLTYPE_FLOOR;
   608C DD 36 E9 00   [19] 1332 	ld	-23 (ix),#0x00
                           1333 ;src/Renderer.c:448: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   6090                    1334 00315$:
   6090 DD 36 CE 00   [19] 1335 	ld	-50 (ix),#0x00
   6094 DD 36 D6 9F   [19] 1336 	ld	-42 (ix),#0x9F
   6098                    1337 00254$:
                           1338 ;src/Renderer.c:451: if (xCellCount == zHeight)
   6098 DD 7E D0      [19] 1339 	ld	a,-48 (ix)
   609B DD 96 F7      [19] 1340 	sub	a, -9 (ix)
   609E 20 50         [12] 1341 	jr	NZ,00142$
                           1342 ;src/Renderer.c:453: ++xCell;
   60A0 DD 34 CE      [23] 1343 	inc	-50 (ix)
                           1344 ;src/Renderer.c:454: xCellCount = 0;
   60A3 DD 36 F7 00   [19] 1345 	ld	-9 (ix),#0x00
                           1346 ;src/Renderer.c:455: newCell=1;
   60A7 DD 36 FE 01   [19] 1347 	ld	-2 (ix),#0x01
                           1348 ;src/Renderer.c:456: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   60AB DD 7E CE      [19] 1349 	ld	a,-50 (ix)
   60AE DD 77 EF      [19] 1350 	ld	-17 (ix),a
   60B1 DD 36 F0 00   [19] 1351 	ld	-16 (ix),#0x00
   60B5 DD 7E DE      [19] 1352 	ld	a,-34 (ix)
   60B8 DD 96 EF      [19] 1353 	sub	a, -17 (ix)
   60BB DD 77 EF      [19] 1354 	ld	-17 (ix),a
   60BE DD 7E DF      [19] 1355 	ld	a,-33 (ix)
   60C1 DD 9E F0      [19] 1356 	sbc	a, -16 (ix)
   60C4 DD 77 F0      [19] 1357 	ld	-16 (ix),a
   60C7 DD 6E EF      [19] 1358 	ld	l,-17 (ix)
   60CA DD 66 F0      [19] 1359 	ld	h,-16 (ix)
   60CD 2B            [ 6] 1360 	dec	hl
   60CE DD 75 EF      [19] 1361 	ld	-17 (ix),l
   60D1 DD 74 F0      [19] 1362 	ld	-16 (ix),h
   60D4 DD 7E E0      [19] 1363 	ld	a,-32 (ix)
   60D7 DD 86 EF      [19] 1364 	add	a, -17 (ix)
   60DA DD 77 EF      [19] 1365 	ld	-17 (ix),a
   60DD DD 7E E1      [19] 1366 	ld	a,-31 (ix)
   60E0 DD 8E F0      [19] 1367 	adc	a, -16 (ix)
   60E3 DD 77 F0      [19] 1368 	ld	-16 (ix),a
   60E6 DD 6E EF      [19] 1369 	ld	l,-17 (ix)
   60E9 DD 66 F0      [19] 1370 	ld	h,-16 (ix)
   60EC 7E            [ 7] 1371 	ld	a,(hl)
   60ED DD 77 F6      [19] 1372 	ld	-10 (ix),a
   60F0                    1373 00142$:
                           1374 ;src/Renderer.c:458: if(!(x%2)){
   60F0 DD 7E D6      [19] 1375 	ld	a,-42 (ix)
   60F3 E6 01         [ 7] 1376 	and	a, #0x01
   60F5 DD 77 EF      [19] 1377 	ld	-17 (ix),a
                           1378 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   60F8 DD 7E F6      [19] 1379 	ld	a,-10 (ix)
   60FB E6 80         [ 7] 1380 	and	a, #0x80
   60FD DD 77 F9      [19] 1381 	ld	-7 (ix),a
                           1382 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   6100 DD 7E F7      [19] 1383 	ld	a,-9 (ix)
   6103 DD 77 DA      [19] 1384 	ld	-38 (ix),a
   6106 DD 36 DB 00   [19] 1385 	ld	-37 (ix),#0x00
                           1386 ;src/Renderer.c:458: if(!(x%2)){
   610A DD 7E EF      [19] 1387 	ld	a,-17 (ix)
   610D B7            [ 4] 1388 	or	a, a
   610E C2 E0 61      [10] 1389 	jp	NZ,00155$
                           1390 ;src/Renderer.c:459: if (lateralWallCounter == 0 || newCell)
   6111 DD 7E E5      [19] 1391 	ld	a,-27 (ix)
   6114 B7            [ 4] 1392 	or	a, a
   6115 28 07         [12] 1393 	jr	Z,00151$
   6117 DD 7E FE      [19] 1394 	ld	a,-2 (ix)
   611A B7            [ 4] 1395 	or	a, a
   611B CA E0 61      [10] 1396 	jp	Z,00155$
   611E                    1397 00151$:
                           1398 ;src/Renderer.c:461: if ( currentCellID & CELL_WALL_MASK)//Wall
   611E DD 7E F9      [19] 1399 	ld	a,-7 (ix)
   6121 B7            [ 4] 1400 	or	a, a
   6122 28 23         [12] 1401 	jr	Z,00149$
                           1402 ;src/Renderer.c:463: lateralWallCounter = 0;
   6124 DD 36 E5 00   [19] 1403 	ld	-27 (ix),#0x00
                           1404 ;src/Renderer.c:464: lateralWallSlope = 0;
   6128 DD 36 F3 00   [19] 1405 	ld	-13 (ix),#0x00
                           1406 ;src/Renderer.c:465: xHeight = zHeight;
   612C DD 7E D0      [19] 1407 	ld	a,-48 (ix)
   612F DD 77 E7      [19] 1408 	ld	-25 (ix),a
                           1409 ;src/Renderer.c:466: color = currentCellID&0b01111111;
   6132 DD 7E F6      [19] 1410 	ld	a,-10 (ix)
   6135 E6 7F         [ 7] 1411 	and	a, #0x7F
   6137 DD 77 FB      [19] 1412 	ld	-5 (ix),a
                           1413 ;src/Renderer.c:467: lastCellWasWall = 1;
   613A DD 36 D7 01   [19] 1414 	ld	-41 (ix),#0x01
                           1415 ;src/Renderer.c:468: lastWallId=currentCellID;
   613E DD 7E F6      [19] 1416 	ld	a,-10 (ix)
   6141 DD 77 E9      [19] 1417 	ld	-23 (ix),a
   6144 C3 DC 61      [10] 1418 	jp	00150$
   6147                    1419 00149$:
                           1420 ;src/Renderer.c:470: else if(lateralWallCounter==0){
   6147 DD 7E E5      [19] 1421 	ld	a,-27 (ix)
   614A B7            [ 4] 1422 	or	a, a
   614B C2 DC 61      [10] 1423 	jp	NZ,00150$
                           1424 ;src/Renderer.c:471: if (lastCellWasWall)
   614E DD 7E D7      [19] 1425 	ld	a,-41 (ix)
   6151 B7            [ 4] 1426 	or	a, a
   6152 28 78         [12] 1427 	jr	Z,00144$
                           1428 ;src/Renderer.c:474: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   6154 DD 7E D4      [19] 1429 	ld	a,-44 (ix)
   6157 DD 96 CE      [19] 1430 	sub	a, -50 (ix)
   615A 87            [ 4] 1431 	add	a, a
   615B 3C            [ 4] 1432 	inc	a
                           1433 ;src/Renderer.c:475: lateralWallSlopeCounter = lateralWallSlope / 2;
   615C DD 77 F3      [19] 1434 	ld	-13 (ix), a
   615F CB 3F         [ 8] 1435 	srl	a
   6161 DD 77 ED      [19] 1436 	ld	-19 (ix),a
                           1437 ;src/Renderer.c:476: lateralWallCounter = lateralWallSlope * zHeight;
   6164 DD 5E D0      [19] 1438 	ld	e,-48 (ix)
   6167 DD 66 F3      [19] 1439 	ld	h,-13 (ix)
   616A 2E 00         [ 7] 1440 	ld	l, #0x00
   616C 55            [ 4] 1441 	ld	d, l
   616D 06 08         [ 7] 1442 	ld	b, #0x08
   616F                    1443 00617$:
   616F 29            [11] 1444 	add	hl,hl
   6170 30 01         [12] 1445 	jr	NC,00618$
   6172 19            [11] 1446 	add	hl,de
   6173                    1447 00618$:
   6173 10 FA         [13] 1448 	djnz	00617$
                           1449 ;src/Renderer.c:477: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   6175 4D            [ 4] 1450 	ld	c,l
   6176 06 00         [ 7] 1451 	ld	b,#0x00
   6178 7D            [ 4] 1452 	ld	a,l
   6179 E6 03         [ 7] 1453 	and	a, #0x03
   617B 5F            [ 4] 1454 	ld	e,a
   617C 16 00         [ 7] 1455 	ld	d,#0x00
   617E 79            [ 4] 1456 	ld	a,c
   617F 93            [ 4] 1457 	sub	a, e
   6180 4F            [ 4] 1458 	ld	c,a
   6181 78            [ 4] 1459 	ld	a,b
   6182 9A            [ 4] 1460 	sbc	a, d
   6183 47            [ 4] 1461 	ld	b,a
   6184 59            [ 4] 1462 	ld	e, c
   6185 50            [ 4] 1463 	ld	d, b
   6186 13            [ 6] 1464 	inc	de
   6187 6B            [ 4] 1465 	ld	l, e
   6188 62            [ 4] 1466 	ld	h, d
   6189 CB 7A         [ 8] 1467 	bit	7, d
   618B 28 04         [12] 1468 	jr	Z,00266$
   618D 21 04 00      [10] 1469 	ld	hl,#0x0004
   6190 09            [11] 1470 	add	hl,bc
   6191                    1471 00266$:
   6191 CB 2C         [ 8] 1472 	sra	h
   6193 CB 1D         [ 8] 1473 	rr	l
   6195 CB 2C         [ 8] 1474 	sra	h
   6197 CB 1D         [ 8] 1475 	rr	l
   6199 DD 4E F7      [19] 1476 	ld	c,-9 (ix)
   619C 7D            [ 4] 1477 	ld	a,l
   619D 91            [ 4] 1478 	sub	a, c
                           1479 ;src/Renderer.c:478: lateralWallWidth=lateralWallCounter;
   619E DD 77 E5      [19] 1480 	ld	-27 (ix), a
   61A1 DD 77 C6      [19] 1481 	ld	-58 (ix),a
                           1482 ;src/Renderer.c:479: lastCellWasWall = 0;
   61A4 DD 36 D7 00   [19] 1483 	ld	-41 (ix),#0x00
                           1484 ;src/Renderer.c:480: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   61A8 DD 6E DA      [19] 1485 	ld	l,-38 (ix)
   61AB DD 66 DB      [19] 1486 	ld	h,-37 (ix)
   61AE 29            [11] 1487 	add	hl, hl
   61AF DD 4E F3      [19] 1488 	ld	c,-13 (ix)
   61B2 06 00         [ 7] 1489 	ld	b,#0x00
   61B4 C5            [11] 1490 	push	bc
   61B5 E5            [11] 1491 	push	hl
   61B6 CD F0 8F      [17] 1492 	call	__divsint
   61B9 F1            [10] 1493 	pop	af
   61BA F1            [10] 1494 	pop	af
   61BB DD 7E FA      [19] 1495 	ld	a,-6 (ix)
   61BE 95            [ 4] 1496 	sub	a, l
   61BF DD 77 E7      [19] 1497 	ld	-25 (ix),a
                           1498 ;src/Renderer.c:481: color = lastWallId&0b01111111;
   61C2 DD 7E E9      [19] 1499 	ld	a,-23 (ix)
   61C5 E6 7F         [ 7] 1500 	and	a, #0x7F
   61C7 DD 77 FB      [19] 1501 	ld	-5 (ix),a
   61CA 18 10         [12] 1502 	jr	00150$
   61CC                    1503 00144$:
                           1504 ;src/Renderer.c:485: xHeight = 0;
   61CC DD 36 E7 00   [19] 1505 	ld	-25 (ix),#0x00
                           1506 ;src/Renderer.c:486: lastCellWasWall = 0;
   61D0 DD 36 D7 00   [19] 1507 	ld	-41 (ix),#0x00
                           1508 ;src/Renderer.c:487: lateralWallSlope=0;
   61D4 DD 36 F3 00   [19] 1509 	ld	-13 (ix),#0x00
                           1510 ;src/Renderer.c:488: lastWallId=0;
   61D8 DD 36 E9 00   [19] 1511 	ld	-23 (ix),#0x00
   61DC                    1512 00150$:
                           1513 ;src/Renderer.c:491: newCell=0;
   61DC DD 36 FE 00   [19] 1514 	ld	-2 (ix),#0x00
   61E0                    1515 00155$:
                           1516 ;src/Renderer.c:496: if (lateralWallCounter > 0)
   61E0 DD 7E E5      [19] 1517 	ld	a,-27 (ix)
   61E3 B7            [ 4] 1518 	or	a, a
   61E4 28 1E         [12] 1519 	jr	Z,00161$
                           1520 ;src/Renderer.c:499: if (lateralWallSlope != 0)
   61E6 DD 7E F3      [19] 1521 	ld	a,-13 (ix)
   61E9 B7            [ 4] 1522 	or	a, a
   61EA 28 15         [12] 1523 	jr	Z,00159$
                           1524 ;src/Renderer.c:501: if (lateralWallSlopeCounter == lateralWallSlope)
   61EC DD 7E F3      [19] 1525 	ld	a,-13 (ix)
   61EF DD 96 ED      [19] 1526 	sub	a, -19 (ix)
   61F2 20 0A         [12] 1527 	jr	NZ,00157$
                           1528 ;src/Renderer.c:503: lateralWallSlopeCounter = 0;
   61F4 DD 36 ED 00   [19] 1529 	ld	-19 (ix),#0x00
                           1530 ;src/Renderer.c:504: xHeight -= 2;
   61F8 DD 35 E7      [23] 1531 	dec	-25 (ix)
   61FB DD 35 E7      [23] 1532 	dec	-25 (ix)
   61FE                    1533 00157$:
                           1534 ;src/Renderer.c:506: ++lateralWallSlopeCounter;
   61FE DD 34 ED      [23] 1535 	inc	-19 (ix)
   6201                    1536 00159$:
                           1537 ;src/Renderer.c:508: --lateralWallCounter;
   6201 DD 35 E5      [23] 1538 	dec	-27 (ix)
   6204                    1539 00161$:
                           1540 ;src/Renderer.c:512: if (!(x%2))
   6204 DD 7E EF      [19] 1541 	ld	a,-17 (ix)
   6207 B7            [ 4] 1542 	or	a, a
   6208 C2 CB 62      [10] 1543 	jp	NZ,00173$
                           1544 ;src/Renderer.c:525: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   620B DD 7E D6      [19] 1545 	ld	a,-42 (ix)
   620E CB 3F         [ 8] 1546 	srl	a
   6210 DD 77 EF      [19] 1547 	ld	-17 (ix),a
                           1548 ;src/Renderer.c:522: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   6213 DD 7E FC      [19] 1549 	ld	a,-4 (ix)
   6216 DD 96 DA      [19] 1550 	sub	a, -38 (ix)
   6219 DD 77 DA      [19] 1551 	ld	-38 (ix),a
   621C DD 7E FD      [19] 1552 	ld	a,-3 (ix)
   621F DD 9E DB      [19] 1553 	sbc	a, -37 (ix)
   6222 DD 77 DB      [19] 1554 	ld	-37 (ix),a
   6225 3E 06         [ 7] 1555 	ld	a,#0x05+1
   6227 18 08         [12] 1556 	jr	00622$
   6229                    1557 00621$:
   6229 DD CB DA 26   [23] 1558 	sla	-38 (ix)
   622D DD CB DB 16   [23] 1559 	rl	-37 (ix)
   6231                    1560 00622$:
   6231 3D            [ 4] 1561 	dec	a
   6232 20 F5         [12] 1562 	jr	NZ,00621$
   6234 DD 6E FC      [19] 1563 	ld	l,-4 (ix)
   6237 DD 66 FD      [19] 1564 	ld	h,-3 (ix)
   623A E5            [11] 1565 	push	hl
   623B DD 6E DA      [19] 1566 	ld	l,-38 (ix)
   623E DD 66 DB      [19] 1567 	ld	h,-37 (ix)
   6241 E5            [11] 1568 	push	hl
   6242 CD F0 8F      [17] 1569 	call	__divsint
   6245 F1            [10] 1570 	pop	af
   6246 F1            [10] 1571 	pop	af
   6247 DD 74 DB      [19] 1572 	ld	-37 (ix),h
   624A DD 75 DA      [19] 1573 	ld	-38 (ix), l
   624D DD 75 DA      [19] 1574 	ld	-38 (ix), l
                           1575 ;src/Renderer.c:515: if(xHeight > 0){
   6250 DD 7E E7      [19] 1576 	ld	a,-25 (ix)
   6253 B7            [ 4] 1577 	or	a, a
   6254 28 55         [12] 1578 	jr	Z,00166$
                           1579 ;src/Renderer.c:517: if (lateralWallCounter > 0)
   6256 DD 7E E5      [19] 1580 	ld	a,-27 (ix)
   6259 B7            [ 4] 1581 	or	a, a
   625A 28 39         [12] 1582 	jr	Z,00163$
                           1583 ;src/Renderer.c:519: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   625C DD 7E E5      [19] 1584 	ld	a,-27 (ix)
   625F DD 77 E3      [19] 1585 	ld	-29 (ix),a
   6262 DD 36 E4 00   [19] 1586 	ld	-28 (ix),#0x00
   6266 3E 06         [ 7] 1587 	ld	a,#0x05+1
   6268 18 08         [12] 1588 	jr	00624$
   626A                    1589 00623$:
   626A DD CB E3 26   [23] 1590 	sla	-29 (ix)
   626E DD CB E4 16   [23] 1591 	rl	-28 (ix)
   6272                    1592 00624$:
   6272 3D            [ 4] 1593 	dec	a
   6273 20 F5         [12] 1594 	jr	NZ,00623$
   6275 DD 7E C6      [19] 1595 	ld	a,-58 (ix)
   6278 DD 77 F1      [19] 1596 	ld	-15 (ix),a
   627B DD 36 F2 00   [19] 1597 	ld	-14 (ix),#0x00
   627F DD 6E F1      [19] 1598 	ld	l,-15 (ix)
   6282 DD 66 F2      [19] 1599 	ld	h,-14 (ix)
   6285 E5            [11] 1600 	push	hl
   6286 DD 6E E3      [19] 1601 	ld	l,-29 (ix)
   6289 DD 66 E4      [19] 1602 	ld	h,-28 (ix)
   628C E5            [11] 1603 	push	hl
   628D CD F0 8F      [17] 1604 	call	__divsint
   6290 F1            [10] 1605 	pop	af
   6291 F1            [10] 1606 	pop	af
   6292 45            [ 4] 1607 	ld	b,l
   6293 18 03         [12] 1608 	jr	00164$
   6295                    1609 00163$:
                           1610 ;src/Renderer.c:522: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   6295 DD 46 DA      [19] 1611 	ld	b,-38 (ix)
   6298                    1612 00164$:
                           1613 ;src/Renderer.c:525: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   6298 C5            [11] 1614 	push	bc
   6299 33            [ 6] 1615 	inc	sp
   629A DD 66 FB      [19] 1616 	ld	h,-5 (ix)
   629D DD 6E E7      [19] 1617 	ld	l,-25 (ix)
   62A0 E5            [11] 1618 	push	hl
   62A1 DD 7E EF      [19] 1619 	ld	a,-17 (ix)
   62A4 F5            [11] 1620 	push	af
   62A5 33            [ 6] 1621 	inc	sp
   62A6 CD 1C 5C      [17] 1622 	call	_draw_column_to_buffer
   62A9 F1            [10] 1623 	pop	af
   62AA F1            [10] 1624 	pop	af
   62AB                    1625 00166$:
                           1626 ;src/Renderer.c:528: if(!(currentCellID&CELL_WALL_MASK)){
   62AB DD 7E F9      [19] 1627 	ld	a,-7 (ix)
   62AE B7            [ 4] 1628 	or	a, a
   62AF 20 1A         [12] 1629 	jr	NZ,00173$
                           1630 ;src/Renderer.c:529: if(currentCellID&CELL_ENEMY_MASK){
   62B1 DD 7E F6      [19] 1631 	ld	a,-10 (ix)
   62B4 E6 0F         [ 7] 1632 	and	a, #0x0F
   62B6 28 13         [12] 1633 	jr	Z,00173$
                           1634 ;src/Renderer.c:530: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   62B8 DD 66 DA      [19] 1635 	ld	h,-38 (ix)
   62BB DD 6E F6      [19] 1636 	ld	l,-10 (ix)
   62BE E5            [11] 1637 	push	hl
   62BF DD 66 D0      [19] 1638 	ld	h,-48 (ix)
   62C2 DD 6E EF      [19] 1639 	ld	l,-17 (ix)
   62C5 E5            [11] 1640 	push	hl
   62C6 CD DE 5A      [17] 1641 	call	_draw_column_to_buffer_enemy
   62C9 F1            [10] 1642 	pop	af
   62CA F1            [10] 1643 	pop	af
                           1644 ;src/Renderer.c:532: else if(currentCellID&CELL_ITEM_MASK){
   62CB                    1645 00173$:
                           1646 ;src/Renderer.c:537: ++xCellCount;
   62CB DD 34 F7      [23] 1647 	inc	-9 (ix)
                           1648 ;src/Renderer.c:448: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   62CE DD 35 D6      [23] 1649 	dec	-42 (ix)
                           1650 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   62D1 2A 5E 5A      [16] 1651 	ld	hl,(_cells_in_view_array)
   62D4 DD 75 E0      [19] 1652 	ld	-32 (ix),l
   62D7 DD 74 E1      [19] 1653 	ld	-31 (ix),h
                           1654 ;src/Renderer.c:448: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   62DA DD 7E D6      [19] 1655 	ld	a,-42 (ix)
   62DD D6 50         [ 7] 1656 	sub	a, #0x50
   62DF D2 98 60      [10] 1657 	jp	NC,00254$
                           1658 ;src/Renderer.c:544: lineStart = lineStart + (offsetDiff * 2) + 3;
   62E2 DD 7E E2      [19] 1659 	ld	a,-30 (ix)
   62E5 C6 03         [ 7] 1660 	add	a, #0x03
   62E7 DD 77 D2      [19] 1661 	ld	-46 (ix),a
                           1662 ;src/Renderer.c:545: zHeight += zHeight;
   62EA DD CB D0 26   [23] 1663 	sla	-48 (ix)
                           1664 ;src/Renderer.c:546: offsetDiff = offsetDiff >> 1;
   62EE DD CB D4 3E   [23] 1665 	srl	-44 (ix)
                           1666 ;src/Renderer.c:548: }while(z);
   62F2 DD 7E CB      [19] 1667 	ld	a,-53 (ix)
   62F5 B7            [ 4] 1668 	or	a, a
   62F6 C2 BB 5D      [10] 1669 	jp	NZ,00175$
   62F9 C3 A9 68      [10] 1670 	jp	00260$
                           1671 ;src/Renderer.c:553: do{
   62FC                    1672 00358$:
   62FC DD 36 CB 06   [19] 1673 	ld	-53 (ix),#0x06
   6300                    1674 00246$:
                           1675 ;src/Renderer.c:555: --z;
   6300 DD 35 CB      [23] 1676 	dec	-53 (ix)
                           1677 ;src/Renderer.c:315: xCellCount = (z) ? (zHeight >> 1) : 0;
   6303 DD 7E D0      [19] 1678 	ld	a,-48 (ix)
   6306 CB 3F         [ 8] 1679 	srl	a
   6308 DD 77 F1      [19] 1680 	ld	-15 (ix),a
                           1681 ;src/Renderer.c:559: xCellCount = (z) ? (zHeight >> 1) : 0;
   630B DD 7E CB      [19] 1682 	ld	a,-53 (ix)
   630E B7            [ 4] 1683 	or	a, a
   630F 28 05         [12] 1684 	jr	Z,00267$
   6311 DD 4E F1      [19] 1685 	ld	c,-15 (ix)
   6314 18 02         [12] 1686 	jr	00268$
   6316                    1687 00267$:
   6316 0E 00         [ 7] 1688 	ld	c,#0x00
   6318                    1689 00268$:
   6318 DD 71 CA      [19] 1690 	ld	-54 (ix),c
                           1691 ;src/Renderer.c:560: lateralWallSlope=0;
   631B DD 36 D5 00   [19] 1692 	ld	-43 (ix),#0x00
                           1693 ;src/Renderer.c:561: lateralWallSlopeCounter=0;
   631F DD 36 C9 00   [19] 1694 	ld	-55 (ix),#0x00
                           1695 ;src/Renderer.c:562: xHeight=0;
   6323 DD 36 CF 00   [19] 1696 	ld	-49 (ix),#0x00
                           1697 ;src/Renderer.c:564: lateralWallCounter = 0;
   6327 DD 36 E3 00   [19] 1698 	ld	-29 (ix),#0x00
                           1699 ;src/Renderer.c:566: newCell=1;
   632B DD 36 CD 01   [19] 1700 	ld	-51 (ix),#0x01
                           1701 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   632F DD 7E D2      [19] 1702 	ld	a,-46 (ix)
   6332 DD 77 DA      [19] 1703 	ld	-38 (ix),a
   6335 DD 36 DB 00   [19] 1704 	ld	-37 (ix),#0x00
                           1705 ;src/Renderer.c:567: currentCellID = cells_in_view_array[lineStart + 1];
   6339 DD 4E DA      [19] 1706 	ld	c,-38 (ix)
   633C DD 46 DB      [19] 1707 	ld	b,-37 (ix)
   633F 03            [ 6] 1708 	inc	bc
   6340 DD 6E E0      [19] 1709 	ld	l,-32 (ix)
   6343 DD 66 E1      [19] 1710 	ld	h,-31 (ix)
   6346 09            [11] 1711 	add	hl,bc
   6347 7E            [ 7] 1712 	ld	a,(hl)
   6348 DD 77 CC      [19] 1713 	ld	-52 (ix),a
                           1714 ;src/Renderer.c:569: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   634B DD 7E E0      [19] 1715 	ld	a,-32 (ix)
   634E DD 86 D2      [19] 1716 	add	a, -46 (ix)
   6351 6F            [ 4] 1717 	ld	l,a
   6352 DD 7E E1      [19] 1718 	ld	a,-31 (ix)
   6355 CE 00         [ 7] 1719 	adc	a, #0x00
   6357 67            [ 4] 1720 	ld	h,a
   6358 4E            [ 7] 1721 	ld	c,(hl)
                           1722 ;src/Renderer.c:570: if(lastCellWasWall&CELL_WALL_MASK){
   6359 CB 79         [ 8] 1723 	bit	7, c
   635B 28 09         [12] 1724 	jr	Z,00179$
                           1725 ;src/Renderer.c:571: lastWallId=lastCellWasWall;
   635D DD 71 D1      [19] 1726 	ld	-47 (ix),c
                           1727 ;src/Renderer.c:572: lastCellWasWall=1;
   6360 DD 36 EF 01   [19] 1728 	ld	-17 (ix),#0x01
   6364 18 08         [12] 1729 	jr	00336$
   6366                    1730 00179$:
                           1731 ;src/Renderer.c:575: lastCellWasWall=0;
   6366 DD 36 EF 00   [19] 1732 	ld	-17 (ix),#0x00
                           1733 ;src/Renderer.c:576: lastWallId=CELLTYPE_FLOOR;
   636A DD 36 D1 00   [19] 1734 	ld	-47 (ix),#0x00
                           1735 ;src/Renderer.c:579: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   636E                    1736 00336$:
   636E DD 36 CE 00   [19] 1737 	ld	-50 (ix),#0x00
   6372 DD 36 D6 00   [19] 1738 	ld	-42 (ix),#0x00
   6376                    1739 00256$:
                           1740 ;src/Renderer.c:581: if (xCellCount == zHeight)
   6376 DD 7E CA      [19] 1741 	ld	a,-54 (ix)
   6379 DD 96 D0      [19] 1742 	sub	a, -48 (ix)
   637C 20 4B         [12] 1743 	jr	NZ,00182$
                           1744 ;src/Renderer.c:583: ++xCell;
   637E DD 34 CE      [23] 1745 	inc	-50 (ix)
                           1746 ;src/Renderer.c:584: xCellCount = 0;
   6381 DD 36 CA 00   [19] 1747 	ld	-54 (ix),#0x00
                           1748 ;src/Renderer.c:585: newCell=1;
   6385 DD 36 CD 01   [19] 1749 	ld	-51 (ix),#0x01
                           1750 ;src/Renderer.c:586: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   6389 DD 7E CE      [19] 1751 	ld	a,-50 (ix)
   638C DD 77 DE      [19] 1752 	ld	-34 (ix),a
   638F DD 36 DF 00   [19] 1753 	ld	-33 (ix),#0x00
   6393 DD 7E DA      [19] 1754 	ld	a,-38 (ix)
   6396 DD 86 DE      [19] 1755 	add	a, -34 (ix)
   6399 DD 77 DE      [19] 1756 	ld	-34 (ix),a
   639C DD 7E DB      [19] 1757 	ld	a,-37 (ix)
   639F DD 8E DF      [19] 1758 	adc	a, -33 (ix)
   63A2 DD 77 DF      [19] 1759 	ld	-33 (ix),a
   63A5 DD 34 DE      [23] 1760 	inc	-34 (ix)
   63A8 20 03         [12] 1761 	jr	NZ,00629$
   63AA DD 34 DF      [23] 1762 	inc	-33 (ix)
   63AD                    1763 00629$:
   63AD DD 7E DE      [19] 1764 	ld	a,-34 (ix)
   63B0 DD 86 E0      [19] 1765 	add	a, -32 (ix)
   63B3 DD 77 DE      [19] 1766 	ld	-34 (ix),a
   63B6 DD 7E DF      [19] 1767 	ld	a,-33 (ix)
   63B9 DD 8E E1      [19] 1768 	adc	a, -31 (ix)
   63BC DD 77 DF      [19] 1769 	ld	-33 (ix),a
   63BF DD 6E DE      [19] 1770 	ld	l,-34 (ix)
   63C2 DD 66 DF      [19] 1771 	ld	h,-33 (ix)
   63C5 7E            [ 7] 1772 	ld	a,(hl)
   63C6 DD 77 CC      [19] 1773 	ld	-52 (ix),a
   63C9                    1774 00182$:
                           1775 ;src/Renderer.c:588: if(!(x%2)){
   63C9 DD 7E D6      [19] 1776 	ld	a,-42 (ix)
   63CC E6 01         [ 7] 1777 	and	a, #0x01
   63CE DD 77 DE      [19] 1778 	ld	-34 (ix),a
                           1779 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   63D1 DD 7E CC      [19] 1780 	ld	a,-52 (ix)
   63D4 E6 80         [ 7] 1781 	and	a, #0x80
   63D6 DD 77 FC      [19] 1782 	ld	-4 (ix),a
                           1783 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   63D9 DD 7E CA      [19] 1784 	ld	a,-54 (ix)
   63DC DD 77 F7      [19] 1785 	ld	-9 (ix),a
   63DF DD 36 F8 00   [19] 1786 	ld	-8 (ix),#0x00
   63E3 DD 7E D0      [19] 1787 	ld	a,-48 (ix)
   63E6 DD 77 FB      [19] 1788 	ld	-5 (ix),a
                           1789 ;src/Renderer.c:588: if(!(x%2)){
   63E9 DD 7E DE      [19] 1790 	ld	a,-34 (ix)
   63EC B7            [ 4] 1791 	or	a, a
   63ED C2 E5 64      [10] 1792 	jp	NZ,00195$
                           1793 ;src/Renderer.c:589: if ((lateralWallCounter == 0)||newCell)
   63F0 DD 7E E3      [19] 1794 	ld	a,-29 (ix)
   63F3 B7            [ 4] 1795 	or	a, a
   63F4 28 07         [12] 1796 	jr	Z,00191$
   63F6 DD 7E CD      [19] 1797 	ld	a,-51 (ix)
   63F9 B7            [ 4] 1798 	or	a, a
   63FA CA E5 64      [10] 1799 	jp	Z,00195$
   63FD                    1800 00191$:
                           1801 ;src/Renderer.c:591: if (currentCellID & CELL_WALL_MASK)//Wall
   63FD DD 7E FC      [19] 1802 	ld	a,-4 (ix)
   6400 B7            [ 4] 1803 	or	a, a
   6401 28 2B         [12] 1804 	jr	Z,00189$
                           1805 ;src/Renderer.c:593: lateralWallCounter = 0;//(zHeight - xCellCount);
   6403 DD 36 E3 00   [19] 1806 	ld	-29 (ix),#0x00
                           1807 ;src/Renderer.c:594: lateralWallSlope = 0;
   6407 DD 36 D5 00   [19] 1808 	ld	-43 (ix),#0x00
                           1809 ;src/Renderer.c:595: xHeight = zHeight;
   640B DD 7E D0      [19] 1810 	ld	a,-48 (ix)
   640E DD 77 CF      [19] 1811 	ld	-49 (ix),a
                           1812 ;src/Renderer.c:596: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   6411 DD 7E CC      [19] 1813 	ld	a,-52 (ix)
   6414 D6 80         [ 7] 1814 	sub	a, #0x80
   6416 20 04         [12] 1815 	jr	NZ,00269$
   6418 0E 0C         [ 7] 1816 	ld	c,#0x0C
   641A 18 02         [12] 1817 	jr	00270$
   641C                    1818 00269$:
   641C 0E 0E         [ 7] 1819 	ld	c,#0x0E
   641E                    1820 00270$:
   641E DD 71 C8      [19] 1821 	ld	-56 (ix),c
                           1822 ;src/Renderer.c:597: lastCellWasWall = 1;
   6421 DD 36 EF 01   [19] 1823 	ld	-17 (ix),#0x01
                           1824 ;src/Renderer.c:598: lastWallId=currentCellID;
   6425 DD 7E CC      [19] 1825 	ld	a,-52 (ix)
   6428 DD 77 D1      [19] 1826 	ld	-47 (ix),a
   642B C3 E1 64      [10] 1827 	jp	00190$
   642E                    1828 00189$:
                           1829 ;src/Renderer.c:601: if(lateralWallCounter==0){//Lateral wall not finished
   642E DD 7E E3      [19] 1830 	ld	a,-29 (ix)
   6431 B7            [ 4] 1831 	or	a, a
   6432 C2 E1 64      [10] 1832 	jp	NZ,00190$
                           1833 ;src/Renderer.c:602: if (lastCellWasWall)
   6435 DD 7E EF      [19] 1834 	ld	a,-17 (ix)
   6438 B7            [ 4] 1835 	or	a, a
   6439 CA D1 64      [10] 1836 	jp	Z,00184$
                           1837 ;src/Renderer.c:605: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   643C DD 7E D4      [19] 1838 	ld	a,-44 (ix)
   643F DD 96 CE      [19] 1839 	sub	a, -50 (ix)
   6442 87            [ 4] 1840 	add	a, a
   6443 3C            [ 4] 1841 	inc	a
                           1842 ;src/Renderer.c:606: lateralWallSlopeCounter = lateralWallSlope / 2;
   6444 DD 77 D5      [19] 1843 	ld	-43 (ix), a
   6447 CB 3F         [ 8] 1844 	srl	a
   6449 DD 77 C9      [19] 1845 	ld	-55 (ix),a
                           1846 ;src/Renderer.c:607: lateralWallCounter = lateralWallSlope * zHeight;
   644C DD 5E D0      [19] 1847 	ld	e,-48 (ix)
   644F DD 66 D5      [19] 1848 	ld	h,-43 (ix)
   6452 2E 00         [ 7] 1849 	ld	l, #0x00
   6454 55            [ 4] 1850 	ld	d, l
   6455 06 08         [ 7] 1851 	ld	b, #0x08
   6457                    1852 00632$:
   6457 29            [11] 1853 	add	hl,hl
   6458 30 01         [12] 1854 	jr	NC,00633$
   645A 19            [11] 1855 	add	hl,de
   645B                    1856 00633$:
   645B 10 FA         [13] 1857 	djnz	00632$
   645D DD 75 FA      [19] 1858 	ld	-6 (ix), l
   6460 7D            [ 4] 1859 	ld	a, l
                           1860 ;src/Renderer.c:608: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   6461 DD 77 C7      [19] 1861 	ld	-57 (ix), a
   6464 E6 FC         [ 7] 1862 	and	a, #0xFC
   6466 DD 77 FA      [19] 1863 	ld	-6 (ix), a
   6469 CB C7         [ 8] 1864 	set	0, a
   646B DD 77 FA      [19] 1865 	ld	-6 (ix), a
   646E CB 3F         [ 8] 1866 	srl	a
   6470 CB 3F         [ 8] 1867 	srl	a
   6472 DD 96 CA      [19] 1868 	sub	a, -54 (ix)
   6475 DD 77 E3      [19] 1869 	ld	-29 (ix),a
                           1870 ;src/Renderer.c:610: lastCellWasWall = 0;
   6478 DD 36 EF 00   [19] 1871 	ld	-17 (ix),#0x00
                           1872 ;src/Renderer.c:611: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   647C DD 7E F7      [19] 1873 	ld	a,-9 (ix)
   647F DD 77 ED      [19] 1874 	ld	-19 (ix),a
   6482 DD 7E F8      [19] 1875 	ld	a,-8 (ix)
   6485 DD 77 EE      [19] 1876 	ld	-18 (ix),a
   6488 DD CB ED 26   [23] 1877 	sla	-19 (ix)
   648C DD CB EE 16   [23] 1878 	rl	-18 (ix)
   6490 DD 7E D5      [19] 1879 	ld	a,-43 (ix)
   6493 DD 77 FE      [19] 1880 	ld	-2 (ix),a
   6496 DD 36 FF 00   [19] 1881 	ld	-1 (ix),#0x00
   649A DD 6E FE      [19] 1882 	ld	l,-2 (ix)
   649D DD 66 FF      [19] 1883 	ld	h,-1 (ix)
   64A0 E5            [11] 1884 	push	hl
   64A1 DD 6E ED      [19] 1885 	ld	l,-19 (ix)
   64A4 DD 66 EE      [19] 1886 	ld	h,-18 (ix)
   64A7 E5            [11] 1887 	push	hl
   64A8 CD F0 8F      [17] 1888 	call	__divsint
   64AB F1            [10] 1889 	pop	af
   64AC F1            [10] 1890 	pop	af
   64AD DD 74 EE      [19] 1891 	ld	-18 (ix),h
   64B0 DD 75 ED      [19] 1892 	ld	-19 (ix), l
   64B3 DD 75 FA      [19] 1893 	ld	-6 (ix), l
   64B6 DD 7E FB      [19] 1894 	ld	a,-5 (ix)
   64B9 DD 96 FA      [19] 1895 	sub	a, -6 (ix)
   64BC DD 77 CF      [19] 1896 	ld	-49 (ix),a
                           1897 ;src/Renderer.c:612: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   64BF DD 7E D1      [19] 1898 	ld	a,-47 (ix)
   64C2 D6 80         [ 7] 1899 	sub	a, #0x80
   64C4 20 04         [12] 1900 	jr	NZ,00271$
   64C6 0E 0F         [ 7] 1901 	ld	c,#0x0F
   64C8 18 02         [12] 1902 	jr	00272$
   64CA                    1903 00271$:
   64CA 0E 0D         [ 7] 1904 	ld	c,#0x0D
   64CC                    1905 00272$:
   64CC DD 71 C8      [19] 1906 	ld	-56 (ix),c
   64CF 18 10         [12] 1907 	jr	00190$
   64D1                    1908 00184$:
                           1909 ;src/Renderer.c:616: xHeight = 0;
   64D1 DD 36 CF 00   [19] 1910 	ld	-49 (ix),#0x00
                           1911 ;src/Renderer.c:617: lastCellWasWall = 0;
   64D5 DD 36 EF 00   [19] 1912 	ld	-17 (ix),#0x00
                           1913 ;src/Renderer.c:618: lateralWallSlope=0;
   64D9 DD 36 D5 00   [19] 1914 	ld	-43 (ix),#0x00
                           1915 ;src/Renderer.c:619: lastWallId=0;
   64DD DD 36 D1 00   [19] 1916 	ld	-47 (ix),#0x00
   64E1                    1917 00190$:
                           1918 ;src/Renderer.c:623: newCell=0;
   64E1 DD 36 CD 00   [19] 1919 	ld	-51 (ix),#0x00
   64E5                    1920 00195$:
                           1921 ;src/Renderer.c:626: if (lateralWallCounter > 0)
   64E5 DD 7E E3      [19] 1922 	ld	a,-29 (ix)
   64E8 B7            [ 4] 1923 	or	a, a
   64E9 28 1E         [12] 1924 	jr	Z,00201$
                           1925 ;src/Renderer.c:629: if (lateralWallSlope != 0)
   64EB DD 7E D5      [19] 1926 	ld	a,-43 (ix)
   64EE B7            [ 4] 1927 	or	a, a
   64EF 28 15         [12] 1928 	jr	Z,00199$
                           1929 ;src/Renderer.c:631: if (lateralWallSlopeCounter == lateralWallSlope)
   64F1 DD 7E D5      [19] 1930 	ld	a,-43 (ix)
   64F4 DD 96 C9      [19] 1931 	sub	a, -55 (ix)
   64F7 20 0A         [12] 1932 	jr	NZ,00197$
                           1933 ;src/Renderer.c:633: lateralWallSlopeCounter = 0;
   64F9 DD 36 C9 00   [19] 1934 	ld	-55 (ix),#0x00
                           1935 ;src/Renderer.c:634: xHeight -= 2;
   64FD DD 35 CF      [23] 1936 	dec	-49 (ix)
   6500 DD 35 CF      [23] 1937 	dec	-49 (ix)
   6503                    1938 00197$:
                           1939 ;src/Renderer.c:636: ++lateralWallSlopeCounter;
   6503 DD 34 C9      [23] 1940 	inc	-55 (ix)
   6506                    1941 00199$:
                           1942 ;src/Renderer.c:639: --lateralWallCounter;
   6506 DD 35 E3      [23] 1943 	dec	-29 (ix)
   6509                    1944 00201$:
                           1945 ;src/Renderer.c:406: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   6509 DD 7E D0      [19] 1946 	ld	a,-48 (ix)
   650C DD 77 ED      [19] 1947 	ld	-19 (ix),a
   650F DD 36 EE 00   [19] 1948 	ld	-18 (ix),#0x00
                           1949 ;src/Renderer.c:642: if (!(x%2))
   6513 DD 7E DE      [19] 1950 	ld	a,-34 (ix)
   6516 B7            [ 4] 1951 	or	a, a
   6517 20 74         [12] 1952 	jr	NZ,00210$
                           1953 ;src/Renderer.c:645: draw_column_to_buffer_untextured(x/2, xHeight, color);
   6519 DD 7E D6      [19] 1954 	ld	a,-42 (ix)
   651C CB 3F         [ 8] 1955 	srl	a
   651E DD 77 DE      [19] 1956 	ld	-34 (ix),a
                           1957 ;src/Renderer.c:644: if(xHeight > 0){
   6521 DD 7E CF      [19] 1958 	ld	a,-49 (ix)
   6524 B7            [ 4] 1959 	or	a, a
   6525 28 11         [12] 1960 	jr	Z,00203$
                           1961 ;src/Renderer.c:645: draw_column_to_buffer_untextured(x/2, xHeight, color);
   6527 DD 66 C8      [19] 1962 	ld	h,-56 (ix)
   652A DD 6E CF      [19] 1963 	ld	l,-49 (ix)
   652D E5            [11] 1964 	push	hl
   652E DD 7E DE      [19] 1965 	ld	a,-34 (ix)
   6531 F5            [11] 1966 	push	af
   6532 33            [ 6] 1967 	inc	sp
   6533 CD 65 5A      [17] 1968 	call	_draw_column_to_buffer_untextured
   6536 F1            [10] 1969 	pop	af
   6537 33            [ 6] 1970 	inc	sp
   6538                    1971 00203$:
                           1972 ;src/Renderer.c:648: if(!(currentCellID&CELL_WALL_MASK)){
   6538 DD 7E FC      [19] 1973 	ld	a,-4 (ix)
   653B B7            [ 4] 1974 	or	a, a
   653C 20 4F         [12] 1975 	jr	NZ,00210$
                           1976 ;src/Renderer.c:649: if(currentCellID&CELL_ENEMY_MASK){
   653E DD 7E CC      [19] 1977 	ld	a,-52 (ix)
   6541 E6 0F         [ 7] 1978 	and	a, #0x0F
   6543 28 48         [12] 1979 	jr	Z,00210$
                           1980 ;src/Renderer.c:650: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   6545 DD 7E F7      [19] 1981 	ld	a,-9 (ix)
   6548 DD 77 FC      [19] 1982 	ld	-4 (ix),a
   654B DD 7E F8      [19] 1983 	ld	a,-8 (ix)
   654E DD 77 FD      [19] 1984 	ld	-3 (ix),a
   6551 3E 06         [ 7] 1985 	ld	a,#0x05+1
   6553 18 08         [12] 1986 	jr	00642$
   6555                    1987 00641$:
   6555 DD CB FC 26   [23] 1988 	sla	-4 (ix)
   6559 DD CB FD 16   [23] 1989 	rl	-3 (ix)
   655D                    1990 00642$:
   655D 3D            [ 4] 1991 	dec	a
   655E 20 F5         [12] 1992 	jr	NZ,00641$
   6560 DD 6E ED      [19] 1993 	ld	l,-19 (ix)
   6563 DD 66 EE      [19] 1994 	ld	h,-18 (ix)
   6566 E5            [11] 1995 	push	hl
   6567 DD 6E FC      [19] 1996 	ld	l,-4 (ix)
   656A DD 66 FD      [19] 1997 	ld	h,-3 (ix)
   656D E5            [11] 1998 	push	hl
   656E CD F0 8F      [17] 1999 	call	__divsint
   6571 F1            [10] 2000 	pop	af
   6572 F1            [10] 2001 	pop	af
   6573 DD 74 FD      [19] 2002 	ld	-3 (ix),h
   6576 DD 75 FC      [19] 2003 	ld	-4 (ix), l
   6579 45            [ 4] 2004 	ld	b, l
   657A C5            [11] 2005 	push	bc
   657B 33            [ 6] 2006 	inc	sp
   657C DD 66 CC      [19] 2007 	ld	h,-52 (ix)
   657F DD 6E D0      [19] 2008 	ld	l,-48 (ix)
   6582 E5            [11] 2009 	push	hl
   6583 DD 7E DE      [19] 2010 	ld	a,-34 (ix)
   6586 F5            [11] 2011 	push	af
   6587 33            [ 6] 2012 	inc	sp
   6588 CD DE 5A      [17] 2013 	call	_draw_column_to_buffer_enemy
   658B F1            [10] 2014 	pop	af
   658C F1            [10] 2015 	pop	af
                           2016 ;src/Renderer.c:652: else if(currentCellID&CELL_ITEM_MASK){
   658D                    2017 00210$:
                           2018 ;src/Renderer.c:658: ++xCellCount;
   658D DD 34 CA      [23] 2019 	inc	-54 (ix)
                           2020 ;src/Renderer.c:579: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   6590 DD 34 D6      [23] 2021 	inc	-42 (ix)
                           2022 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   6593 2A 5E 5A      [16] 2023 	ld	hl,(_cells_in_view_array)
   6596 DD 75 E0      [19] 2024 	ld	-32 (ix),l
   6599 DD 74 E1      [19] 2025 	ld	-31 (ix),h
                           2026 ;src/Renderer.c:579: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   659C DD 7E D6      [19] 2027 	ld	a,-42 (ix)
   659F D6 50         [ 7] 2028 	sub	a, #0x50
   65A1 DA 76 63      [10] 2029 	jp	C,00256$
                           2030 ;src/Renderer.c:665: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   65A4 DD 7E CB      [19] 2031 	ld	a,-53 (ix)
   65A7 B7            [ 4] 2032 	or	a, a
   65A8 28 08         [12] 2033 	jr	Z,00273$
   65AA DD 7E F1      [19] 2034 	ld	a,-15 (ix)
   65AD DD 77 F1      [19] 2035 	ld	-15 (ix),a
   65B0 18 04         [12] 2036 	jr	00274$
   65B2                    2037 00273$:
   65B2 DD 36 F1 00   [19] 2038 	ld	-15 (ix),#0x00
   65B6                    2039 00274$:
   65B6 DD 7E F1      [19] 2040 	ld	a,-15 (ix)
   65B9 DD 77 F1      [19] 2041 	ld	-15 (ix),a
                           2042 ;src/Renderer.c:666: lateralWallSlope=0;
   65BC DD 36 E3 00   [19] 2043 	ld	-29 (ix),#0x00
                           2044 ;src/Renderer.c:667: lateralWallSlopeCounter=0;
   65C0 DD 36 DA 00   [19] 2045 	ld	-38 (ix),#0x00
                           2046 ;src/Renderer.c:668: xHeight=0;
   65C4 DD 36 EF 00   [19] 2047 	ld	-17 (ix),#0x00
                           2048 ;src/Renderer.c:670: lateralWallCounter = 0;
   65C8 DD 36 DE 00   [19] 2049 	ld	-34 (ix),#0x00
                           2050 ;src/Renderer.c:433: lineEnd = lineStart + offsetDiff * 2 + 2;
   65CC DD 7E D4      [19] 2051 	ld	a,-44 (ix)
   65CF 87            [ 4] 2052 	add	a, a
   65D0 DD 77 FC      [19] 2053 	ld	-4 (ix),a
   65D3 DD 7E D2      [19] 2054 	ld	a,-46 (ix)
   65D6 DD 86 FC      [19] 2055 	add	a, -4 (ix)
                           2056 ;src/Renderer.c:671: lineEnd = lineStart + offsetDiff * 2 + 2;
   65D9 DD 77 FC      [19] 2057 	ld	-4 (ix), a
   65DC C6 02         [ 7] 2058 	add	a, #0x02
   65DE DD 77 D3      [19] 2059 	ld	-45 (ix),a
                           2060 ;src/Renderer.c:673: newCell=1;
   65E1 DD 36 FA 01   [19] 2061 	ld	-6 (ix),#0x01
                           2062 ;src/Renderer.c:436: currentCellID = cells_in_view_array[lineEnd - 1];
   65E5 DD 7E D3      [19] 2063 	ld	a,-45 (ix)
   65E8 DD 77 F7      [19] 2064 	ld	-9 (ix),a
   65EB DD 36 F8 00   [19] 2065 	ld	-8 (ix),#0x00
                           2066 ;src/Renderer.c:674: currentCellID = cells_in_view_array[lineEnd - 1];
   65EF DD 7E F7      [19] 2067 	ld	a,-9 (ix)
   65F2 C6 FF         [ 7] 2068 	add	a,#0xFF
   65F4 DD 77 FE      [19] 2069 	ld	-2 (ix),a
   65F7 DD 7E F8      [19] 2070 	ld	a,-8 (ix)
   65FA CE FF         [ 7] 2071 	adc	a,#0xFF
   65FC DD 77 FF      [19] 2072 	ld	-1 (ix),a
   65FF DD 7E E0      [19] 2073 	ld	a,-32 (ix)
   6602 DD 86 FE      [19] 2074 	add	a, -2 (ix)
   6605 DD 77 FE      [19] 2075 	ld	-2 (ix),a
   6608 DD 7E E1      [19] 2076 	ld	a,-31 (ix)
   660B DD 8E FF      [19] 2077 	adc	a, -1 (ix)
   660E DD 77 FF      [19] 2078 	ld	-1 (ix),a
   6611 DD 6E FE      [19] 2079 	ld	l,-2 (ix)
   6614 DD 66 FF      [19] 2080 	ld	h,-1 (ix)
   6617 7E            [ 7] 2081 	ld	a,(hl)
   6618 DD 77 F3      [19] 2082 	ld	-13 (ix),a
                           2083 ;src/Renderer.c:676: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   661B DD 7E E0      [19] 2084 	ld	a,-32 (ix)
   661E DD 86 D3      [19] 2085 	add	a, -45 (ix)
   6621 DD 77 FE      [19] 2086 	ld	-2 (ix),a
   6624 DD 7E E1      [19] 2087 	ld	a,-31 (ix)
   6627 CE 00         [ 7] 2088 	adc	a, #0x00
   6629 DD 77 FF      [19] 2089 	ld	-1 (ix),a
   662C DD 6E FE      [19] 2090 	ld	l,-2 (ix)
   662F DD 66 FF      [19] 2091 	ld	h,-1 (ix)
   6632 7E            [ 7] 2092 	ld	a,(hl)
   6633 DD 77 E7      [19] 2093 	ld	-25 (ix),a
                           2094 ;src/Renderer.c:677: if(lastCellWasWall&CELL_WALL_MASK){
   6636 DD CB E7 7E   [20] 2095 	bit	7, -25 (ix)
   663A 28 06         [12] 2096 	jr	Z,00213$
                           2097 ;src/Renderer.c:678: lastWallId=lastCellWasWall;
                           2098 ;src/Renderer.c:679: lastCellWasWall=1;
   663C DD 36 E5 01   [19] 2099 	ld	-27 (ix),#0x01
   6640 18 08         [12] 2100 	jr	00356$
   6642                    2101 00213$:
                           2102 ;src/Renderer.c:682: lastCellWasWall=0;
   6642 DD 36 E5 00   [19] 2103 	ld	-27 (ix),#0x00
                           2104 ;src/Renderer.c:683: lastWallId=CELLTYPE_FLOOR;
   6646 DD 36 E7 00   [19] 2105 	ld	-25 (ix),#0x00
                           2106 ;src/Renderer.c:686: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   664A                    2107 00356$:
   664A DD 36 CE 00   [19] 2108 	ld	-50 (ix),#0x00
   664E DD 36 D6 9F   [19] 2109 	ld	-42 (ix),#0x9F
   6652                    2110 00258$:
                           2111 ;src/Renderer.c:689: if (xCellCount == zHeight)
   6652 DD 7E D0      [19] 2112 	ld	a,-48 (ix)
   6655 DD 96 F1      [19] 2113 	sub	a, -15 (ix)
   6658 20 50         [12] 2114 	jr	NZ,00216$
                           2115 ;src/Renderer.c:691: ++xCell;
   665A DD 34 CE      [23] 2116 	inc	-50 (ix)
                           2117 ;src/Renderer.c:692: xCellCount = 0;
   665D DD 36 F1 00   [19] 2118 	ld	-15 (ix),#0x00
                           2119 ;src/Renderer.c:693: newCell=1;
   6661 DD 36 FA 01   [19] 2120 	ld	-6 (ix),#0x01
                           2121 ;src/Renderer.c:694: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   6665 DD 7E CE      [19] 2122 	ld	a,-50 (ix)
   6668 DD 77 FE      [19] 2123 	ld	-2 (ix),a
   666B DD 36 FF 00   [19] 2124 	ld	-1 (ix),#0x00
   666F DD 7E F7      [19] 2125 	ld	a,-9 (ix)
   6672 DD 96 FE      [19] 2126 	sub	a, -2 (ix)
   6675 DD 77 FE      [19] 2127 	ld	-2 (ix),a
   6678 DD 7E F8      [19] 2128 	ld	a,-8 (ix)
   667B DD 9E FF      [19] 2129 	sbc	a, -1 (ix)
   667E DD 77 FF      [19] 2130 	ld	-1 (ix),a
   6681 DD 6E FE      [19] 2131 	ld	l,-2 (ix)
   6684 DD 66 FF      [19] 2132 	ld	h,-1 (ix)
   6687 2B            [ 6] 2133 	dec	hl
   6688 DD 75 FE      [19] 2134 	ld	-2 (ix),l
   668B DD 74 FF      [19] 2135 	ld	-1 (ix),h
   668E DD 7E E0      [19] 2136 	ld	a,-32 (ix)
   6691 DD 86 FE      [19] 2137 	add	a, -2 (ix)
   6694 DD 77 FE      [19] 2138 	ld	-2 (ix),a
   6697 DD 7E E1      [19] 2139 	ld	a,-31 (ix)
   669A DD 8E FF      [19] 2140 	adc	a, -1 (ix)
   669D DD 77 FF      [19] 2141 	ld	-1 (ix),a
   66A0 DD 6E FE      [19] 2142 	ld	l,-2 (ix)
   66A3 DD 66 FF      [19] 2143 	ld	h,-1 (ix)
   66A6 7E            [ 7] 2144 	ld	a,(hl)
   66A7 DD 77 F3      [19] 2145 	ld	-13 (ix),a
   66AA                    2146 00216$:
                           2147 ;src/Renderer.c:696: if(!(x%2)){
   66AA DD 7E D6      [19] 2148 	ld	a,-42 (ix)
   66AD E6 01         [ 7] 2149 	and	a, #0x01
   66AF DD 77 E2      [19] 2150 	ld	-30 (ix),a
                           2151 ;src/Renderer.c:347: if (currentCellID & CELL_WALL_MASK)//Wall
   66B2 DD 7E F3      [19] 2152 	ld	a,-13 (ix)
   66B5 E6 80         [ 7] 2153 	and	a, #0x80
   66B7 DD 77 FE      [19] 2154 	ld	-2 (ix),a
                           2155 ;src/Renderer.c:367: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   66BA DD 7E F1      [19] 2156 	ld	a,-15 (ix)
   66BD DD 77 F4      [19] 2157 	ld	-12 (ix),a
   66C0 DD 36 F5 00   [19] 2158 	ld	-11 (ix),#0x00
                           2159 ;src/Renderer.c:696: if(!(x%2)){
   66C4 DD 7E E2      [19] 2160 	ld	a,-30 (ix)
   66C7 B7            [ 4] 2161 	or	a, a
   66C8 C2 F6 67      [10] 2162 	jp	NZ,00229$
                           2163 ;src/Renderer.c:697: if (lateralWallCounter == 0 || newCell)
   66CB DD 7E DE      [19] 2164 	ld	a,-34 (ix)
   66CE B7            [ 4] 2165 	or	a, a
   66CF 28 07         [12] 2166 	jr	Z,00225$
   66D1 DD 7E FA      [19] 2167 	ld	a,-6 (ix)
   66D4 B7            [ 4] 2168 	or	a, a
   66D5 CA F6 67      [10] 2169 	jp	Z,00229$
   66D8                    2170 00225$:
                           2171 ;src/Renderer.c:699: if ( currentCellID & CELL_WALL_MASK)//Wall
   66D8 DD 7E FE      [19] 2172 	ld	a,-2 (ix)
   66DB B7            [ 4] 2173 	or	a, a
   66DC 28 32         [12] 2174 	jr	Z,00223$
                           2175 ;src/Renderer.c:701: lateralWallCounter = 0;
   66DE DD 36 DE 00   [19] 2176 	ld	-34 (ix),#0x00
                           2177 ;src/Renderer.c:702: lateralWallSlope = 0;
   66E2 DD 36 E3 00   [19] 2178 	ld	-29 (ix),#0x00
                           2179 ;src/Renderer.c:703: xHeight = zHeight;
   66E6 DD 7E D0      [19] 2180 	ld	a,-48 (ix)
   66E9 DD 77 EF      [19] 2181 	ld	-17 (ix),a
                           2182 ;src/Renderer.c:704: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   66EC DD 7E F3      [19] 2183 	ld	a,-13 (ix)
   66EF D6 80         [ 7] 2184 	sub	a, #0x80
   66F1 20 06         [12] 2185 	jr	NZ,00275$
   66F3 DD 36 F6 0C   [19] 2186 	ld	-10 (ix),#0x0C
   66F7 18 04         [12] 2187 	jr	00276$
   66F9                    2188 00275$:
   66F9 DD 36 F6 0E   [19] 2189 	ld	-10 (ix),#0x0E
   66FD                    2190 00276$:
   66FD DD 7E F6      [19] 2191 	ld	a,-10 (ix)
   6700 DD 77 C8      [19] 2192 	ld	-56 (ix),a
                           2193 ;src/Renderer.c:705: lastCellWasWall = 1;
   6703 DD 36 E5 01   [19] 2194 	ld	-27 (ix),#0x01
                           2195 ;src/Renderer.c:706: lastWallId=currentCellID;
   6707 DD 7E F3      [19] 2196 	ld	a,-13 (ix)
   670A DD 77 E7      [19] 2197 	ld	-25 (ix),a
   670D C3 F2 67      [10] 2198 	jp	00224$
   6710                    2199 00223$:
                           2200 ;src/Renderer.c:708: else if(lateralWallCounter==0){
   6710 DD 7E DE      [19] 2201 	ld	a,-34 (ix)
   6713 B7            [ 4] 2202 	or	a, a
   6714 C2 F2 67      [10] 2203 	jp	NZ,00224$
                           2204 ;src/Renderer.c:709: if (lastCellWasWall)
   6717 DD 7E E5      [19] 2205 	ld	a,-27 (ix)
   671A B7            [ 4] 2206 	or	a, a
   671B CA E2 67      [10] 2207 	jp	Z,00218$
                           2208 ;src/Renderer.c:712: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   671E DD 7E D4      [19] 2209 	ld	a,-44 (ix)
   6721 DD 96 CE      [19] 2210 	sub	a, -50 (ix)
   6724 87            [ 4] 2211 	add	a, a
   6725 3C            [ 4] 2212 	inc	a
                           2213 ;src/Renderer.c:713: lateralWallSlopeCounter = lateralWallSlope / 2;
   6726 DD 77 E3      [19] 2214 	ld	-29 (ix), a
   6729 CB 3F         [ 8] 2215 	srl	a
   672B DD 77 DA      [19] 2216 	ld	-38 (ix),a
                           2217 ;src/Renderer.c:714: lateralWallCounter = lateralWallSlope * zHeight;
   672E DD 5E D0      [19] 2218 	ld	e,-48 (ix)
   6731 DD 66 E3      [19] 2219 	ld	h,-29 (ix)
   6734 2E 00         [ 7] 2220 	ld	l, #0x00
   6736 55            [ 4] 2221 	ld	d, l
   6737 06 08         [ 7] 2222 	ld	b, #0x08
   6739                    2223 00648$:
   6739 29            [11] 2224 	add	hl,hl
   673A 30 01         [12] 2225 	jr	NC,00649$
   673C 19            [11] 2226 	add	hl,de
   673D                    2227 00649$:
   673D 10 FA         [13] 2228 	djnz	00648$
                           2229 ;src/Renderer.c:715: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   673F DD 75 F6      [19] 2230 	ld	-10 (ix), l
   6742 DD 75 EA      [19] 2231 	ld	-22 (ix), l
   6745 DD 36 EB 00   [19] 2232 	ld	-21 (ix),#0x00
   6749 DD 7E F6      [19] 2233 	ld	a,-10 (ix)
   674C E6 03         [ 7] 2234 	and	a, #0x03
   674E DD 77 F6      [19] 2235 	ld	-10 (ix), a
   6751 DD 77 D8      [19] 2236 	ld	-40 (ix),a
   6754 DD 36 D9 00   [19] 2237 	ld	-39 (ix),#0x00
   6758 DD 7E EA      [19] 2238 	ld	a,-22 (ix)
   675B DD 96 D8      [19] 2239 	sub	a, -40 (ix)
   675E DD 77 D8      [19] 2240 	ld	-40 (ix),a
   6761 DD 7E EB      [19] 2241 	ld	a,-21 (ix)
   6764 DD 9E D9      [19] 2242 	sbc	a, -39 (ix)
   6767 DD 77 D9      [19] 2243 	ld	-39 (ix),a
   676A DD 7E D8      [19] 2244 	ld	a,-40 (ix)
   676D C6 01         [ 7] 2245 	add	a, #0x01
   676F DD 77 EA      [19] 2246 	ld	-22 (ix),a
   6772 DD 7E D9      [19] 2247 	ld	a,-39 (ix)
   6775 CE 00         [ 7] 2248 	adc	a, #0x00
   6777 DD 77 EB      [19] 2249 	ld	-21 (ix),a
   677A DD 7E EA      [19] 2250 	ld	a,-22 (ix)
   677D DD 77 DC      [19] 2251 	ld	-36 (ix),a
   6780 DD 7E EB      [19] 2252 	ld	a,-21 (ix)
   6783 DD 77 DD      [19] 2253 	ld	-35 (ix),a
   6786 DD CB EB 7E   [20] 2254 	bit	7, -21 (ix)
   678A 28 10         [12] 2255 	jr	Z,00277$
   678C DD 7E D8      [19] 2256 	ld	a,-40 (ix)
   678F C6 04         [ 7] 2257 	add	a, #0x04
   6791 DD 77 DC      [19] 2258 	ld	-36 (ix),a
   6794 DD 7E D9      [19] 2259 	ld	a,-39 (ix)
   6797 CE 00         [ 7] 2260 	adc	a, #0x00
   6799 DD 77 DD      [19] 2261 	ld	-35 (ix),a
   679C                    2262 00277$:
   679C DD 4E DC      [19] 2263 	ld	c,-36 (ix)
   679F DD 46 DD      [19] 2264 	ld	b,-35 (ix)
   67A2 CB 28         [ 8] 2265 	sra	b
   67A4 CB 19         [ 8] 2266 	rr	c
   67A6 CB 28         [ 8] 2267 	sra	b
   67A8 CB 19         [ 8] 2268 	rr	c
   67AA DD 46 F1      [19] 2269 	ld	b,-15 (ix)
   67AD 79            [ 4] 2270 	ld	a,c
   67AE 90            [ 4] 2271 	sub	a, b
   67AF DD 77 DE      [19] 2272 	ld	-34 (ix),a
                           2273 ;src/Renderer.c:717: lastCellWasWall = 0;
   67B2 DD 36 E5 00   [19] 2274 	ld	-27 (ix),#0x00
                           2275 ;src/Renderer.c:718: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   67B6 DD 6E F4      [19] 2276 	ld	l,-12 (ix)
   67B9 DD 66 F5      [19] 2277 	ld	h,-11 (ix)
   67BC 29            [11] 2278 	add	hl, hl
   67BD DD 4E E3      [19] 2279 	ld	c,-29 (ix)
   67C0 06 00         [ 7] 2280 	ld	b,#0x00
   67C2 C5            [11] 2281 	push	bc
   67C3 E5            [11] 2282 	push	hl
   67C4 CD F0 8F      [17] 2283 	call	__divsint
   67C7 F1            [10] 2284 	pop	af
   67C8 F1            [10] 2285 	pop	af
   67C9 DD 7E FB      [19] 2286 	ld	a,-5 (ix)
   67CC 95            [ 4] 2287 	sub	a, l
   67CD DD 77 EF      [19] 2288 	ld	-17 (ix),a
                           2289 ;src/Renderer.c:719: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   67D0 DD 7E E7      [19] 2290 	ld	a,-25 (ix)
   67D3 D6 80         [ 7] 2291 	sub	a, #0x80
   67D5 20 04         [12] 2292 	jr	NZ,00278$
   67D7 0E 0F         [ 7] 2293 	ld	c,#0x0F
   67D9 18 02         [12] 2294 	jr	00279$
   67DB                    2295 00278$:
   67DB 0E 0D         [ 7] 2296 	ld	c,#0x0D
   67DD                    2297 00279$:
   67DD DD 71 C8      [19] 2298 	ld	-56 (ix),c
   67E0 18 10         [12] 2299 	jr	00224$
   67E2                    2300 00218$:
                           2301 ;src/Renderer.c:723: xHeight = 0;
   67E2 DD 36 EF 00   [19] 2302 	ld	-17 (ix),#0x00
                           2303 ;src/Renderer.c:724: lastCellWasWall = 0;
   67E6 DD 36 E5 00   [19] 2304 	ld	-27 (ix),#0x00
                           2305 ;src/Renderer.c:725: lateralWallSlope=0;
   67EA DD 36 E3 00   [19] 2306 	ld	-29 (ix),#0x00
                           2307 ;src/Renderer.c:726: lastWallId=0;
   67EE DD 36 E7 00   [19] 2308 	ld	-25 (ix),#0x00
   67F2                    2309 00224$:
                           2310 ;src/Renderer.c:729: newCell=0;
   67F2 DD 36 FA 00   [19] 2311 	ld	-6 (ix),#0x00
   67F6                    2312 00229$:
                           2313 ;src/Renderer.c:734: if (lateralWallCounter > 0)
   67F6 DD 7E DE      [19] 2314 	ld	a,-34 (ix)
   67F9 B7            [ 4] 2315 	or	a, a
   67FA 28 1E         [12] 2316 	jr	Z,00235$
                           2317 ;src/Renderer.c:737: if (lateralWallSlope != 0)
   67FC DD 7E E3      [19] 2318 	ld	a,-29 (ix)
   67FF B7            [ 4] 2319 	or	a, a
   6800 28 15         [12] 2320 	jr	Z,00233$
                           2321 ;src/Renderer.c:739: if (lateralWallSlopeCounter == lateralWallSlope)
   6802 DD 7E E3      [19] 2322 	ld	a,-29 (ix)
   6805 DD 96 DA      [19] 2323 	sub	a, -38 (ix)
   6808 20 0A         [12] 2324 	jr	NZ,00231$
                           2325 ;src/Renderer.c:741: lateralWallSlopeCounter = 0;
   680A DD 36 DA 00   [19] 2326 	ld	-38 (ix),#0x00
                           2327 ;src/Renderer.c:742: xHeight -= 2;
   680E DD 35 EF      [23] 2328 	dec	-17 (ix)
   6811 DD 35 EF      [23] 2329 	dec	-17 (ix)
   6814                    2330 00231$:
                           2331 ;src/Renderer.c:744: ++lateralWallSlopeCounter;
   6814 DD 34 DA      [23] 2332 	inc	-38 (ix)
   6817                    2333 00233$:
                           2334 ;src/Renderer.c:746: --lateralWallCounter;
   6817 DD 35 DE      [23] 2335 	dec	-34 (ix)
   681A                    2336 00235$:
                           2337 ;src/Renderer.c:750: if (!(x%2))
   681A DD 7E E2      [19] 2338 	ld	a,-30 (ix)
   681D B7            [ 4] 2339 	or	a, a
   681E 20 5B         [12] 2340 	jr	NZ,00244$
                           2341 ;src/Renderer.c:755: draw_column_to_buffer_untextured(x/2, xHeight, color);
   6820 DD 46 D6      [19] 2342 	ld	b,-42 (ix)
   6823 CB 38         [ 8] 2343 	srl	b
                           2344 ;src/Renderer.c:753: if(xHeight > 0){
   6825 DD 7E EF      [19] 2345 	ld	a,-17 (ix)
   6828 B7            [ 4] 2346 	or	a, a
   6829 28 10         [12] 2347 	jr	Z,00237$
                           2348 ;src/Renderer.c:755: draw_column_to_buffer_untextured(x/2, xHeight, color);
   682B C5            [11] 2349 	push	bc
   682C DD 66 C8      [19] 2350 	ld	h,-56 (ix)
   682F DD 6E EF      [19] 2351 	ld	l,-17 (ix)
   6832 E5            [11] 2352 	push	hl
   6833 C5            [11] 2353 	push	bc
   6834 33            [ 6] 2354 	inc	sp
   6835 CD 65 5A      [17] 2355 	call	_draw_column_to_buffer_untextured
   6838 F1            [10] 2356 	pop	af
   6839 33            [ 6] 2357 	inc	sp
   683A C1            [10] 2358 	pop	bc
   683B                    2359 00237$:
                           2360 ;src/Renderer.c:758: if(!(currentCellID&CELL_WALL_MASK)){
   683B DD 7E FE      [19] 2361 	ld	a,-2 (ix)
   683E B7            [ 4] 2362 	or	a, a
   683F 20 3A         [12] 2363 	jr	NZ,00244$
                           2364 ;src/Renderer.c:759: if(currentCellID&CELL_ENEMY_MASK){
   6841 DD 7E F3      [19] 2365 	ld	a,-13 (ix)
   6844 E6 0F         [ 7] 2366 	and	a, #0x0F
   6846 28 33         [12] 2367 	jr	Z,00244$
                           2368 ;src/Renderer.c:760: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   6848 DD 7E ED      [19] 2369 	ld	a,-19 (ix)
   684B DD 96 F4      [19] 2370 	sub	a, -12 (ix)
   684E 6F            [ 4] 2371 	ld	l,a
   684F DD 7E EE      [19] 2372 	ld	a,-18 (ix)
   6852 DD 9E F5      [19] 2373 	sbc	a, -11 (ix)
   6855 67            [ 4] 2374 	ld	h,a
   6856 29            [11] 2375 	add	hl, hl
   6857 29            [11] 2376 	add	hl, hl
   6858 29            [11] 2377 	add	hl, hl
   6859 29            [11] 2378 	add	hl, hl
   685A 29            [11] 2379 	add	hl, hl
   685B C5            [11] 2380 	push	bc
   685C DD 5E ED      [19] 2381 	ld	e,-19 (ix)
   685F DD 56 EE      [19] 2382 	ld	d,-18 (ix)
   6862 D5            [11] 2383 	push	de
   6863 E5            [11] 2384 	push	hl
   6864 CD F0 8F      [17] 2385 	call	__divsint
   6867 F1            [10] 2386 	pop	af
   6868 F1            [10] 2387 	pop	af
   6869 55            [ 4] 2388 	ld	d,l
   686A C1            [10] 2389 	pop	bc
   686B D5            [11] 2390 	push	de
   686C 33            [ 6] 2391 	inc	sp
   686D DD 66 F3      [19] 2392 	ld	h,-13 (ix)
   6870 DD 6E D0      [19] 2393 	ld	l,-48 (ix)
   6873 E5            [11] 2394 	push	hl
   6874 C5            [11] 2395 	push	bc
   6875 33            [ 6] 2396 	inc	sp
   6876 CD DE 5A      [17] 2397 	call	_draw_column_to_buffer_enemy
   6879 F1            [10] 2398 	pop	af
   687A F1            [10] 2399 	pop	af
                           2400 ;src/Renderer.c:762: else if(currentCellID&CELL_ITEM_MASK){
   687B                    2401 00244$:
                           2402 ;src/Renderer.c:767: ++xCellCount;
   687B DD 34 F1      [23] 2403 	inc	-15 (ix)
                           2404 ;src/Renderer.c:686: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   687E DD 35 D6      [23] 2405 	dec	-42 (ix)
                           2406 ;src/Renderer.c:323: currentCellID = cells_in_view_array[lineStart + 1];
   6881 2A 5E 5A      [16] 2407 	ld	hl,(_cells_in_view_array)
   6884 DD 75 E0      [19] 2408 	ld	-32 (ix),l
   6887 DD 74 E1      [19] 2409 	ld	-31 (ix),h
                           2410 ;src/Renderer.c:686: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   688A DD 7E D6      [19] 2411 	ld	a,-42 (ix)
   688D D6 50         [ 7] 2412 	sub	a, #0x50
   688F D2 52 66      [10] 2413 	jp	NC,00258$
                           2414 ;src/Renderer.c:774: lineStart = lineStart + (offsetDiff * 2) + 3;
   6892 DD 7E FC      [19] 2415 	ld	a,-4 (ix)
   6895 C6 03         [ 7] 2416 	add	a, #0x03
   6897 DD 77 D2      [19] 2417 	ld	-46 (ix),a
                           2418 ;src/Renderer.c:775: zHeight += zHeight;
   689A DD CB D0 26   [23] 2419 	sla	-48 (ix)
                           2420 ;src/Renderer.c:776: offsetDiff = offsetDiff >> 1;
   689E DD CB D4 3E   [23] 2421 	srl	-44 (ix)
                           2422 ;src/Renderer.c:778: }while(z);
   68A2 DD 7E CB      [19] 2423 	ld	a,-53 (ix)
   68A5 B7            [ 4] 2424 	or	a, a
   68A6 C2 00 63      [10] 2425 	jp	NZ,00246$
   68A9                    2426 00260$:
   68A9 DD F9         [10] 2427 	ld	sp, ix
   68AB DD E1         [14] 2428 	pop	ix
   68AD C9            [10] 2429 	ret
                           2430 ;src/Renderer.c:784: void draw_minimap_to_buffer(){
                           2431 ;	---------------------------------
                           2432 ; Function draw_minimap_to_buffer
                           2433 ; ---------------------------------
   68AE                    2434 _draw_minimap_to_buffer::
   68AE DD E5         [15] 2435 	push	ix
   68B0 DD 21 00 00   [14] 2436 	ld	ix,#0
   68B4 DD 39         [15] 2437 	add	ix,sp
   68B6 21 F5 FF      [10] 2438 	ld	hl,#-11
   68B9 39            [11] 2439 	add	hl,sp
   68BA F9            [ 6] 2440 	ld	sp,hl
                           2441 ;src/Renderer.c:787: u8* ptr = MINIMAP_BUFFER;
   68BB 01 E0 38      [10] 2442 	ld	bc,#0x38E0
                           2443 ;src/Renderer.c:792: y=(PLAYER_position.y-MINIMAP_HEIGHT_HALF);
   68BE 3A 80 58      [13] 2444 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   68C1 C6 F8         [ 7] 2445 	add	a,#0xF8
   68C3 5F            [ 4] 2446 	ld	e,a
                           2447 ;src/Renderer.c:794: for(j=0;j<MINIMAP_HEIGHT;++j){
   68C4 16 00         [ 7] 2448 	ld	d,#0x00
                           2449 ;src/Renderer.c:795: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   68C6                    2450 00137$:
   68C6 7B            [ 4] 2451 	ld	a,e
   68C7 07            [ 4] 2452 	rlca
   68C8 E6 01         [ 7] 2453 	and	a,#0x01
   68CA DD 77 FD      [19] 2454 	ld	-3 (ix),a
   68CD 7B            [ 4] 2455 	ld	a,e
   68CE EE 80         [ 7] 2456 	xor	a, #0x80
   68D0 D6 A0         [ 7] 2457 	sub	a, #0xA0
   68D2 3E 00         [ 7] 2458 	ld	a,#0x00
   68D4 17            [ 4] 2459 	rla
   68D5 DD 77 FC      [19] 2460 	ld	-4 (ix),a
   68D8 DD 36 F5 00   [19] 2461 	ld	-11 (ix),#0x00
   68DC                    2462 00122$:
                           2463 ;src/Renderer.c:796: x=(PLAYER_position.x-MINIMAP_WIDTH_HALF);
   68DC 3A 7F 58      [13] 2464 	ld	a, (#_PLAYER_position + 0)
   68DF C6 F8         [ 7] 2465 	add	a,#0xF8
   68E1 DD 77 F7      [19] 2466 	ld	-9 (ix),a
                           2467 ;src/Renderer.c:797: for(i=0;i<MINIMAP_WIDTH;++i){
   68E4 DD 36 F6 00   [19] 2468 	ld	-10 (ix),#0x00
   68E8                    2469 00120$:
                           2470 ;src/Renderer.c:800: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   68E8 FD 21 10 00   [14] 2471 	ld	iy,#0x0010
   68EC FD 09         [15] 2472 	add	iy, bc
                           2473 ;src/Renderer.c:798: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
   68EE DD CB F7 7E   [20] 2474 	bit	7, -9 (ix)
   68F2 20 15         [12] 2475 	jr	NZ,00111$
   68F4 DD 7E F7      [19] 2476 	ld	a,-9 (ix)
   68F7 EE 80         [ 7] 2477 	xor	a, #0x80
   68F9 D6 A0         [ 7] 2478 	sub	a, #0xA0
   68FB 30 0C         [12] 2479 	jr	NC,00111$
   68FD DD 7E FD      [19] 2480 	ld	a,-3 (ix)
   6900 B7            [ 4] 2481 	or	a, a
   6901 20 06         [12] 2482 	jr	NZ,00111$
   6903 DD CB FC 46   [20] 2483 	bit	0,-4 (ix)
   6907 20 0D         [12] 2484 	jr	NZ,00112$
   6909                    2485 00111$:
                           2486 ;src/Renderer.c:799: *ptr=g_colors[MINIMAP_WALL_COLOR];
   6909 3A 4C 5A      [13] 2487 	ld	a, (#(_g_colors + 0x0001) + 0)
   690C 02            [ 7] 2488 	ld	(bc),a
                           2489 ;src/Renderer.c:800: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   690D 3A 4C 5A      [13] 2490 	ld	a, (#(_g_colors + 0x0001) + 0)
   6910 FD 77 00      [19] 2491 	ld	0 (iy), a
   6913 C3 BD 69      [10] 2492 	jp	00113$
   6916                    2493 00112$:
                           2494 ;src/Renderer.c:802: else if((x==PLAYER_position.x)&&(y==PLAYER_position.y)){
   6916 DD 7E F7      [19] 2495 	ld	a,-9 (ix)
   6919 DD 77 FE      [19] 2496 	ld	-2 (ix),a
   691C DD 7E F7      [19] 2497 	ld	a,-9 (ix)
   691F 17            [ 4] 2498 	rla
   6920 9F            [ 4] 2499 	sbc	a, a
   6921 DD 77 FF      [19] 2500 	ld	-1 (ix),a
   6924 3A 7F 58      [13] 2501 	ld	a, (#_PLAYER_position + 0)
   6927 DD 77 F8      [19] 2502 	ld	-8 (ix),a
   692A DD 36 F9 00   [19] 2503 	ld	-7 (ix),#0x00
   692E DD 73 FA      [19] 2504 	ld	-6 (ix),e
   6931 7B            [ 4] 2505 	ld	a,e
   6932 17            [ 4] 2506 	rla
   6933 9F            [ 4] 2507 	sbc	a, a
   6934 DD 77 FB      [19] 2508 	ld	-5 (ix),a
   6937 DD 7E FE      [19] 2509 	ld	a,-2 (ix)
   693A DD 96 F8      [19] 2510 	sub	a, -8 (ix)
   693D 20 2E         [12] 2511 	jr	NZ,00108$
   693F DD 7E FF      [19] 2512 	ld	a,-1 (ix)
   6942 DD 96 F9      [19] 2513 	sub	a, -7 (ix)
   6945 20 26         [12] 2514 	jr	NZ,00108$
   6947 3A 80 58      [13] 2515 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   694A DD 77 F8      [19] 2516 	ld	-8 (ix),a
   694D DD 36 F9 00   [19] 2517 	ld	-7 (ix),#0x00
   6951 DD 7E FA      [19] 2518 	ld	a,-6 (ix)
   6954 DD 96 F8      [19] 2519 	sub	a, -8 (ix)
   6957 20 14         [12] 2520 	jr	NZ,00108$
   6959 DD 7E FB      [19] 2521 	ld	a,-5 (ix)
   695C DD 96 F9      [19] 2522 	sub	a, -7 (ix)
   695F 20 0C         [12] 2523 	jr	NZ,00108$
                           2524 ;src/Renderer.c:803: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
   6961 3A 4F 5A      [13] 2525 	ld	a, (#(_g_colors + 0x0004) + 0)
   6964 02            [ 7] 2526 	ld	(bc),a
                           2527 ;src/Renderer.c:804: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
   6965 3A 4F 5A      [13] 2528 	ld	a, (#(_g_colors + 0x0004) + 0)
   6968 FD 77 00      [19] 2529 	ld	0 (iy), a
   696B 18 50         [12] 2530 	jr	00113$
   696D                    2531 00108$:
                           2532 ;src/Renderer.c:807: val = (*(u8*)(MAP_MEM+x+y*MAP_WIDTH));
   696D DD 7E FE      [19] 2533 	ld	a,-2 (ix)
   6970 C6 40         [ 7] 2534 	add	a, #0x40
   6972 DD 77 F8      [19] 2535 	ld	-8 (ix),a
   6975 DD 7E FF      [19] 2536 	ld	a,-1 (ix)
   6978 CE 00         [ 7] 2537 	adc	a, #0x00
   697A DD 77 F9      [19] 2538 	ld	-7 (ix),a
   697D DD 6E FA      [19] 2539 	ld	l,-6 (ix)
   6980 DD 66 FB      [19] 2540 	ld	h,-5 (ix)
   6983 29            [11] 2541 	add	hl, hl
   6984 29            [11] 2542 	add	hl, hl
   6985 29            [11] 2543 	add	hl, hl
   6986 29            [11] 2544 	add	hl, hl
   6987 29            [11] 2545 	add	hl, hl
   6988 DD 7E F8      [19] 2546 	ld	a,-8 (ix)
   698B 85            [ 4] 2547 	add	a, l
   698C 6F            [ 4] 2548 	ld	l,a
   698D DD 7E F9      [19] 2549 	ld	a,-7 (ix)
   6990 8C            [ 4] 2550 	adc	a, h
   6991 67            [ 4] 2551 	ld	h,a
   6992 66            [ 7] 2552 	ld	h,(hl)
                           2553 ;src/Renderer.c:809: if(val==CELLTYPE_DOOR){
   6993 7C            [ 4] 2554 	ld	a,h
   6994 D6 80         [ 7] 2555 	sub	a, #0x80
   6996 20 0C         [12] 2556 	jr	NZ,00105$
                           2557 ;src/Renderer.c:810: *ptr=g_colors[MINIMAP_EXIT_COLOR];
   6998 3A 53 5A      [13] 2558 	ld	a, (#(_g_colors + 0x0008) + 0)
   699B 02            [ 7] 2559 	ld	(bc),a
                           2560 ;src/Renderer.c:811: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
   699C 3A 53 5A      [13] 2561 	ld	a, (#(_g_colors + 0x0008) + 0)
   699F FD 77 00      [19] 2562 	ld	0 (iy), a
   69A2 18 19         [12] 2563 	jr	00113$
   69A4                    2564 00105$:
                           2565 ;src/Renderer.c:813: else if(val&CELL_WALL_MASK){
   69A4 29            [11] 2566 	add	hl, hl
   69A5 30 0C         [12] 2567 	jr	NC,00102$
                           2568 ;src/Renderer.c:814: *ptr=g_colors[MINIMAP_WALL_COLOR];
   69A7 3A 4C 5A      [13] 2569 	ld	a, (#(_g_colors + 0x0001) + 0)
   69AA 02            [ 7] 2570 	ld	(bc),a
                           2571 ;src/Renderer.c:815: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   69AB 3A 4C 5A      [13] 2572 	ld	a, (#(_g_colors + 0x0001) + 0)
   69AE FD 77 00      [19] 2573 	ld	0 (iy), a
   69B1 18 0A         [12] 2574 	jr	00113$
   69B3                    2575 00102$:
                           2576 ;src/Renderer.c:818: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
   69B3 3A 4E 5A      [13] 2577 	ld	a, (#(_g_colors + 0x0003) + 0)
   69B6 02            [ 7] 2578 	ld	(bc),a
                           2579 ;src/Renderer.c:819: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
   69B7 3A 4E 5A      [13] 2580 	ld	a, (#(_g_colors + 0x0003) + 0)
   69BA FD 77 00      [19] 2581 	ld	0 (iy), a
   69BD                    2582 00113$:
                           2583 ;src/Renderer.c:822: ++x;
   69BD DD 34 F7      [23] 2584 	inc	-9 (ix)
                           2585 ;src/Renderer.c:823: ++ptr;
   69C0 03            [ 6] 2586 	inc	bc
                           2587 ;src/Renderer.c:797: for(i=0;i<MINIMAP_WIDTH;++i){
   69C1 DD 34 F6      [23] 2588 	inc	-10 (ix)
   69C4 DD 7E F6      [19] 2589 	ld	a,-10 (ix)
   69C7 D6 10         [ 7] 2590 	sub	a, #0x10
   69C9 DA E8 68      [10] 2591 	jp	C,00120$
                           2592 ;src/Renderer.c:795: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   69CC DD 34 F5      [23] 2593 	inc	-11 (ix)
   69CF DD 7E F5      [19] 2594 	ld	a,-11 (ix)
   69D2 D6 04         [ 7] 2595 	sub	a, #0x04
   69D4 DA DC 68      [10] 2596 	jp	C,00122$
                           2597 ;src/Renderer.c:826: ++y;
   69D7 1C            [ 4] 2598 	inc	e
                           2599 ;src/Renderer.c:794: for(j=0;j<MINIMAP_HEIGHT;++j){
   69D8 14            [ 4] 2600 	inc	d
   69D9 7A            [ 4] 2601 	ld	a,d
   69DA D6 10         [ 7] 2602 	sub	a, #0x10
   69DC DA C6 68      [10] 2603 	jp	C,00137$
   69DF DD F9         [10] 2604 	ld	sp, ix
   69E1 DD E1         [14] 2605 	pop	ix
   69E3 C9            [10] 2606 	ret
                           2607 	.area _CODE
                           2608 	.area _INITIALIZER
                           2609 	.area _CABS (ABS)
