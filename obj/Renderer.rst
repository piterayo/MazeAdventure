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
                             13 	.globl _draw_column_to_buffer_untextured
                             14 	.globl _calculate_cells_in_view
                             15 	.globl _cpct_memset
                             16 	.globl _offsets_cells_in_view
                             17 	.globl _cells_in_view_array
                             18 	.globl _g_texturedWalls
                             19 	.globl _g_pixelMask
                             20 	.globl _g_colors
                             21 	.globl _g_palette
                             22 	.globl _render_draw_to_buffer
                             23 	.globl _draw_minimap_to_buffer
                             24 ;--------------------------------------------------------
                             25 ; special function registers
                             26 ;--------------------------------------------------------
                             27 ;--------------------------------------------------------
                             28 ; ram data
                             29 ;--------------------------------------------------------
                             30 	.area _DATA
                             31 ;--------------------------------------------------------
                             32 ; ram data
                             33 ;--------------------------------------------------------
                             34 	.area _INITIALIZED
                             35 ;--------------------------------------------------------
                             36 ; absolute external ram data
                             37 ;--------------------------------------------------------
                             38 	.area _DABS (ABS)
                             39 ;--------------------------------------------------------
                             40 ; global & static initialisations
                             41 ;--------------------------------------------------------
                             42 	.area _HOME
                             43 	.area _GSINIT
                             44 	.area _GSFINAL
                             45 	.area _GSINIT
                             46 ;--------------------------------------------------------
                             47 ; Home
                             48 ;--------------------------------------------------------
                             49 	.area _HOME
                             50 	.area _HOME
                             51 ;--------------------------------------------------------
                             52 ; code
                             53 ;--------------------------------------------------------
                             54 	.area _CODE
                             55 ;src/Renderer.c:207: void calculate_cells_in_view(){
                             56 ;	---------------------------------
                             57 ; Function calculate_cells_in_view
                             58 ; ---------------------------------
   48B9                      59 _calculate_cells_in_view::
   48B9 DD E5         [15]   60 	push	ix
   48BB DD 21 00 00   [14]   61 	ld	ix,#0
   48BF DD 39         [15]   62 	add	ix,sp
   48C1 21 F2 FF      [10]   63 	ld	hl,#-14
   48C4 39            [11]   64 	add	hl,sp
   48C5 F9            [ 6]   65 	ld	sp,hl
                             66 ;src/Renderer.c:209: u8 offset=0, n=0, j, i;
   48C6 DD 36 FA 00   [19]   67 	ld	-6 (ix),#0x00
   48CA DD 36 F9 00   [19]   68 	ld	-7 (ix),#0x00
                             69 ;src/Renderer.c:212: if(PLAYER_direction.y!=0){
   48CE 3A AF 48      [13]   70 	ld	a,(#_PLAYER_direction + 1)
   48D1 DD 77 FD      [19]   71 	ld	-3 (ix), a
   48D4 B7            [ 4]   72 	or	a, a
   48D5 28 32         [12]   73 	jr	Z,00102$
                             74 ;src/Renderer.c:213: vert=1;
   48D7 DD 36 F2 01   [19]   75 	ld	-14 (ix),#0x01
                             76 ;src/Renderer.c:214: dy=PLAYER_direction.y;
   48DB DD 4E FD      [19]   77 	ld	c,-3 (ix)
   48DE DD 71 F4      [19]   78 	ld	-12 (ix),c
                             79 ;src/Renderer.c:215: dx=-PLAYER_direction.y;
   48E1 AF            [ 4]   80 	xor	a, a
   48E2 DD 96 FD      [19]   81 	sub	a, -3 (ix)
   48E5 DD 77 F5      [19]   82 	ld	-11 (ix), a
                             83 ;src/Renderer.c:217: x0 = PLAYER_position.x-(17*dx);
   48E8 21 AC 48      [10]   84 	ld	hl,#_PLAYER_position+0
   48EB 4E            [ 7]   85 	ld	c,(hl)
   48EC DD 6E F5      [19]   86 	ld	l,-11 (ix)
   48EF 5D            [ 4]   87 	ld	e,l
   48F0 29            [11]   88 	add	hl, hl
   48F1 29            [11]   89 	add	hl, hl
   48F2 29            [11]   90 	add	hl, hl
   48F3 29            [11]   91 	add	hl, hl
   48F4 19            [11]   92 	add	hl, de
   48F5 79            [ 4]   93 	ld	a,c
   48F6 95            [ 4]   94 	sub	a, l
   48F7 DD 77 F6      [19]   95 	ld	-10 (ix),a
                             96 ;src/Renderer.c:218: y0 = PLAYER_position.y+(6*dy);
   48FA 21 AD 48      [10]   97 	ld	hl,#_PLAYER_position+1
   48FD 4E            [ 7]   98 	ld	c,(hl)
   48FE DD 6E F4      [19]   99 	ld	l,-12 (ix)
   4901 5D            [ 4]  100 	ld	e,l
   4902 29            [11]  101 	add	hl, hl
   4903 19            [11]  102 	add	hl, de
   4904 29            [11]  103 	add	hl, hl
   4905 09            [11]  104 	add	hl, bc
   4906 4D            [ 4]  105 	ld	c,l
   4907 18 34         [12]  106 	jr	00103$
   4909                     107 00102$:
                            108 ;src/Renderer.c:221: vert=0;
   4909 DD 36 F2 00   [19]  109 	ld	-14 (ix),#0x00
                            110 ;src/Renderer.c:222: dy=PLAYER_direction.x;
   490D 3A AE 48      [13]  111 	ld	a,(#_PLAYER_direction + 0)
   4910 DD 77 FD      [19]  112 	ld	-3 (ix), a
   4913 DD 77 F4      [19]  113 	ld	-12 (ix),a
                            114 ;src/Renderer.c:223: dx=PLAYER_direction.x;
   4916 DD 7E FD      [19]  115 	ld	a,-3 (ix)
   4919 DD 77 F5      [19]  116 	ld	-11 (ix),a
                            117 ;src/Renderer.c:225: y0 = PLAYER_position.y-(17*dy);
   491C 21 AD 48      [10]  118 	ld	hl, #_PLAYER_position + 1
   491F 4E            [ 7]  119 	ld	c,(hl)
   4920 DD 6E F4      [19]  120 	ld	l,-12 (ix)
   4923 5D            [ 4]  121 	ld	e,l
   4924 29            [11]  122 	add	hl, hl
   4925 29            [11]  123 	add	hl, hl
   4926 29            [11]  124 	add	hl, hl
   4927 29            [11]  125 	add	hl, hl
   4928 19            [11]  126 	add	hl, de
   4929 79            [ 4]  127 	ld	a,c
   492A 95            [ 4]  128 	sub	a, l
   492B 4F            [ 4]  129 	ld	c,a
                            130 ;src/Renderer.c:226: x0 = PLAYER_position.x+(6*dx);
   492C 21 AC 48      [10]  131 	ld	hl, #_PLAYER_position + 0
   492F 46            [ 7]  132 	ld	b,(hl)
   4930 DD 7E FD      [19]  133 	ld	a,-3 (ix)
   4933 5F            [ 4]  134 	ld	e,a
   4934 87            [ 4]  135 	add	a, a
   4935 83            [ 4]  136 	add	a, e
   4936 87            [ 4]  137 	add	a, a
   4937 5F            [ 4]  138 	ld	e,a
   4938 68            [ 4]  139 	ld	l,b
   4939 19            [11]  140 	add	hl, de
   493A DD 75 F6      [19]  141 	ld	-10 (ix),l
   493D                     142 00103$:
                            143 ;src/Renderer.c:230: x=x0;
   493D DD 5E F6      [19]  144 	ld	e,-10 (ix)
                            145 ;src/Renderer.c:231: y=y0;
   4940 DD 71 F3      [19]  146 	ld	-13 (ix),c
                            147 ;src/Renderer.c:233: for(j=0;j<6;++j){
   4943 DD 7E F5      [19]  148 	ld	a,-11 (ix)
   4946 07            [ 4]  149 	rlca
   4947 E6 01         [ 7]  150 	and	a,#0x01
   4949 DD 77 FD      [19]  151 	ld	-3 (ix),a
   494C DD 7E F4      [19]  152 	ld	a,-12 (ix)
   494F 07            [ 4]  153 	rlca
   4950 E6 01         [ 7]  154 	and	a,#0x01
   4952 DD 77 FB      [19]  155 	ld	-5 (ix),a
   4955 DD 36 F8 00   [19]  156 	ld	-8 (ix),#0x00
                            157 ;src/Renderer.c:235: for(i=offset;i<35-offset;++i){
   4959                     158 00138$:
   4959 DD 7E F9      [19]  159 	ld	a,-7 (ix)
   495C DD 77 FC      [19]  160 	ld	-4 (ix),a
   495F DD 7E FA      [19]  161 	ld	a,-6 (ix)
   4962 DD 77 F7      [19]  162 	ld	-9 (ix),a
   4965                     163 00125$:
   4965 DD 6E FA      [19]  164 	ld	l,-6 (ix)
   4968 26 00         [ 7]  165 	ld	h,#0x00
   496A 3E 23         [ 7]  166 	ld	a,#0x23
   496C 95            [ 4]  167 	sub	a, l
   496D 6F            [ 4]  168 	ld	l,a
   496E 3E 00         [ 7]  169 	ld	a,#0x00
   4970 9C            [ 4]  170 	sbc	a, h
   4971 67            [ 4]  171 	ld	h,a
   4972 DD 7E F7      [19]  172 	ld	a, -9 (ix)
   4975 16 00         [ 7]  173 	ld	d, #0x00
   4977 95            [ 4]  174 	sub	a, l
   4978 7A            [ 4]  175 	ld	a,d
   4979 9C            [ 4]  176 	sbc	a, h
   497A E2 7F 49      [10]  177 	jp	PO, 00181$
   497D EE 80         [ 7]  178 	xor	a, #0x80
   497F                     179 00181$:
   497F F2 FE 49      [10]  180 	jp	P,00143$
                            181 ;src/Renderer.c:238: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   4982 2A 8B 4A      [16]  182 	ld	hl,(_cells_in_view_array)
   4985 7D            [ 4]  183 	ld	a,l
   4986 DD 86 FC      [19]  184 	add	a, -4 (ix)
   4989 DD 77 FE      [19]  185 	ld	-2 (ix),a
   498C 7C            [ 4]  186 	ld	a,h
   498D CE 00         [ 7]  187 	adc	a, #0x00
   498F DD 77 FF      [19]  188 	ld	-1 (ix),a
                            189 ;src/Renderer.c:237: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
   4992 CB 7B         [ 8]  190 	bit	7, e
   4994 20 41         [12]  191 	jr	NZ,00105$
   4996 7B            [ 4]  192 	ld	a,e
   4997 EE 80         [ 7]  193 	xor	a, #0x80
   4999 D6 A0         [ 7]  194 	sub	a, #0xA0
   499B 30 3A         [12]  195 	jr	NC,00105$
   499D DD CB F3 7E   [20]  196 	bit	7, -13 (ix)
   49A1 20 34         [12]  197 	jr	NZ,00105$
   49A3 DD 7E F3      [19]  198 	ld	a,-13 (ix)
   49A6 EE 80         [ 7]  199 	xor	a, #0x80
   49A8 D6 A0         [ 7]  200 	sub	a, #0xA0
   49AA 30 2B         [12]  201 	jr	NC,00105$
                            202 ;src/Renderer.c:238: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   49AC 7B            [ 4]  203 	ld	a,e
   49AD 57            [ 4]  204 	ld	d,a
   49AE 17            [ 4]  205 	rla
   49AF 9F            [ 4]  206 	sbc	a, a
   49B0 6F            [ 4]  207 	ld	l,a
   49B1 7A            [ 4]  208 	ld	a,d
   49B2 C6 40         [ 7]  209 	add	a, #0x40
   49B4 47            [ 4]  210 	ld	b,a
   49B5 7D            [ 4]  211 	ld	a,l
   49B6 CE 00         [ 7]  212 	adc	a, #0x00
   49B8 57            [ 4]  213 	ld	d,a
   49B9 DD 6E F3      [19]  214 	ld	l,-13 (ix)
   49BC DD 7E F3      [19]  215 	ld	a,-13 (ix)
   49BF 17            [ 4]  216 	rla
   49C0 9F            [ 4]  217 	sbc	a, a
   49C1 67            [ 4]  218 	ld	h,a
   49C2 29            [11]  219 	add	hl, hl
   49C3 29            [11]  220 	add	hl, hl
   49C4 29            [11]  221 	add	hl, hl
   49C5 29            [11]  222 	add	hl, hl
   49C6 29            [11]  223 	add	hl, hl
   49C7 78            [ 4]  224 	ld	a,b
   49C8 85            [ 4]  225 	add	a, l
   49C9 6F            [ 4]  226 	ld	l,a
   49CA 7A            [ 4]  227 	ld	a,d
   49CB 8C            [ 4]  228 	adc	a, h
   49CC 67            [ 4]  229 	ld	h,a
   49CD 46            [ 7]  230 	ld	b,(hl)
   49CE DD 6E FE      [19]  231 	ld	l,-2 (ix)
   49D1 DD 66 FF      [19]  232 	ld	h,-1 (ix)
   49D4 70            [ 7]  233 	ld	(hl),b
   49D5 18 08         [12]  234 	jr	00106$
   49D7                     235 00105$:
                            236 ;src/Renderer.c:241: cells_in_view_array[n]=1;
   49D7 DD 6E FE      [19]  237 	ld	l,-2 (ix)
   49DA DD 66 FF      [19]  238 	ld	h,-1 (ix)
   49DD 36 01         [10]  239 	ld	(hl),#0x01
   49DF                     240 00106$:
                            241 ;src/Renderer.c:245: if(vert){
   49DF DD 7E F2      [19]  242 	ld	a,-14 (ix)
   49E2 B7            [ 4]  243 	or	a, a
   49E3 28 07         [12]  244 	jr	Z,00111$
                            245 ;src/Renderer.c:246: x+=dx;
   49E5 7B            [ 4]  246 	ld	a,e
   49E6 DD 86 F5      [19]  247 	add	a, -11 (ix)
   49E9 5F            [ 4]  248 	ld	e,a
   49EA 18 09         [12]  249 	jr	00112$
   49EC                     250 00111$:
                            251 ;src/Renderer.c:249: y+=dy;
   49EC DD 7E F3      [19]  252 	ld	a,-13 (ix)
   49EF DD 86 F4      [19]  253 	add	a, -12 (ix)
   49F2 DD 77 F3      [19]  254 	ld	-13 (ix),a
   49F5                     255 00112$:
                            256 ;src/Renderer.c:251: ++n;
   49F5 DD 34 FC      [23]  257 	inc	-4 (ix)
                            258 ;src/Renderer.c:235: for(i=offset;i<35-offset;++i){
   49F8 DD 34 F7      [23]  259 	inc	-9 (ix)
   49FB C3 65 49      [10]  260 	jp	00125$
   49FE                     261 00143$:
   49FE DD 7E FC      [19]  262 	ld	a,-4 (ix)
   4A01 DD 77 F9      [19]  263 	ld	-7 (ix),a
                            264 ;src/Renderer.c:253: offset=offsets_cells_in_view[j];
   4A04 3E 8D         [ 7]  265 	ld	a,#<(_offsets_cells_in_view)
   4A06 DD 86 F8      [19]  266 	add	a, -8 (ix)
   4A09 6F            [ 4]  267 	ld	l,a
   4A0A 3E 4A         [ 7]  268 	ld	a,#>(_offsets_cells_in_view)
   4A0C CE 00         [ 7]  269 	adc	a, #0x00
   4A0E 67            [ 4]  270 	ld	h,a
   4A0F 7E            [ 7]  271 	ld	a,(hl)
                            272 ;src/Renderer.c:257: if(dx<0) x=x0-offset;
   4A10 DD 77 FA      [19]  273 	ld	-6 (ix), a
   4A13 DD 77 FE      [19]  274 	ld	-2 (ix),a
                            275 ;src/Renderer.c:255: if(vert){
   4A16 DD 7E F2      [19]  276 	ld	a,-14 (ix)
   4A19 B7            [ 4]  277 	or	a, a
   4A1A 28 21         [12]  278 	jr	Z,00121$
                            279 ;src/Renderer.c:256: y-=dy;
   4A1C DD 7E F3      [19]  280 	ld	a,-13 (ix)
   4A1F DD 96 F4      [19]  281 	sub	a, -12 (ix)
   4A22 DD 77 F3      [19]  282 	ld	-13 (ix),a
                            283 ;src/Renderer.c:257: if(dx<0) x=x0-offset;
   4A25 DD 7E FD      [19]  284 	ld	a,-3 (ix)
   4A28 B7            [ 4]  285 	or	a, a
   4A29 28 09         [12]  286 	jr	Z,00115$
   4A2B DD 7E F6      [19]  287 	ld	a,-10 (ix)
   4A2E DD 96 FE      [19]  288 	sub	a, -2 (ix)
   4A31 5F            [ 4]  289 	ld	e,a
   4A32 18 24         [12]  290 	jr	00128$
   4A34                     291 00115$:
                            292 ;src/Renderer.c:258: else x=x0+offset;
   4A34 DD 7E F6      [19]  293 	ld	a,-10 (ix)
   4A37 DD 86 FE      [19]  294 	add	a, -2 (ix)
   4A3A 5F            [ 4]  295 	ld	e,a
   4A3B 18 1B         [12]  296 	jr	00128$
   4A3D                     297 00121$:
                            298 ;src/Renderer.c:262: x-=dx;
   4A3D 7B            [ 4]  299 	ld	a,e
   4A3E DD 96 F5      [19]  300 	sub	a, -11 (ix)
   4A41 5F            [ 4]  301 	ld	e,a
                            302 ;src/Renderer.c:263: if(dy<0) y=y0-offset;
   4A42 DD 7E FB      [19]  303 	ld	a,-5 (ix)
   4A45 B7            [ 4]  304 	or	a, a
   4A46 28 09         [12]  305 	jr	Z,00118$
   4A48 79            [ 4]  306 	ld	a,c
   4A49 DD 96 FE      [19]  307 	sub	a, -2 (ix)
   4A4C DD 77 F3      [19]  308 	ld	-13 (ix),a
   4A4F 18 07         [12]  309 	jr	00128$
   4A51                     310 00118$:
                            311 ;src/Renderer.c:264: else y=y0+offset;
   4A51 79            [ 4]  312 	ld	a,c
   4A52 DD 86 FE      [19]  313 	add	a, -2 (ix)
   4A55 DD 77 F3      [19]  314 	ld	-13 (ix),a
   4A58                     315 00128$:
                            316 ;src/Renderer.c:233: for(j=0;j<6;++j){
   4A58 DD 34 F8      [23]  317 	inc	-8 (ix)
   4A5B DD 7E F8      [19]  318 	ld	a,-8 (ix)
   4A5E D6 06         [ 7]  319 	sub	a, #0x06
   4A60 DA 59 49      [10]  320 	jp	C,00138$
   4A63 DD F9         [10]  321 	ld	sp, ix
   4A65 DD E1         [14]  322 	pop	ix
   4A67 C9            [10]  323 	ret
   4A68                     324 _g_palette:
   4A68 08                  325 	.db #0x08	; 8
   4A69 00                  326 	.db #0x00	; 0
   4A6A 0D                  327 	.db #0x0D	; 13
   4A6B 1A                  328 	.db #0x1A	; 26
   4A6C 06                  329 	.db #0x06	; 6
   4A6D 01                  330 	.db #0x01	; 1
   4A6E 09                  331 	.db #0x09	; 9
   4A6F 03                  332 	.db #0x03	; 3
   4A70 18                  333 	.db #0x18	; 24
   4A71 12                  334 	.db #0x12	; 18
   4A72 05                  335 	.db #0x05	; 5
   4A73 0E                  336 	.db #0x0E	; 14
   4A74 0F                  337 	.db #0x0F	; 15
   4A75 10                  338 	.db #0x10	; 16
   4A76 11                  339 	.db #0x11	; 17
   4A77 13                  340 	.db #0x13	; 19
   4A78                     341 _g_colors:
   4A78 00                  342 	.db #0x00	; 0
   4A79 C0                  343 	.db #0xC0	; 192
   4A7A 0C                  344 	.db #0x0C	; 12
   4A7B CC                  345 	.db #0xCC	; 204
   4A7C 30                  346 	.db #0x30	; 48	'0'
   4A7D F0                  347 	.db #0xF0	; 240
   4A7E 3C                  348 	.db #0x3C	; 60
   4A7F FC                  349 	.db #0xFC	; 252
   4A80 03                  350 	.db #0x03	; 3
   4A81 C3                  351 	.db #0xC3	; 195
   4A82 0F                  352 	.db #0x0F	; 15
   4A83 CF                  353 	.db #0xCF	; 207
   4A84 33                  354 	.db #0x33	; 51	'3'
   4A85 F3                  355 	.db #0xF3	; 243
   4A86 3F                  356 	.db #0x3F	; 63
   4A87 FF                  357 	.db #0xFF	; 255
   4A88                     358 _g_pixelMask:
   4A88 AA                  359 	.db #0xAA	; 170
   4A89 55                  360 	.db #0x55	; 85	'U'
   4A8A                     361 _g_texturedWalls:
   4A8A 01                  362 	.db #0x01	; 1
   4A8B                     363 _cells_in_view_array:
   4A8B E0 38               364 	.dw #0x38E0
   4A8D                     365 _offsets_cells_in_view:
   4A8D 08                  366 	.db #0x08	; 8
   4A8E 0C                  367 	.db #0x0C	; 12
   4A8F 0E                  368 	.db #0x0E	; 14
   4A90 0F                  369 	.db #0x0F	; 15
   4A91 10                  370 	.db #0x10	; 16
                            371 ;src/Renderer.c:272: void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
                            372 ;	---------------------------------
                            373 ; Function draw_column_to_buffer_untextured
                            374 ; ---------------------------------
   4A92                     375 _draw_column_to_buffer_untextured::
   4A92 DD E5         [15]  376 	push	ix
   4A94 DD 21 00 00   [14]  377 	ld	ix,#0
   4A98 DD 39         [15]  378 	add	ix,sp
   4A9A F5            [11]  379 	push	af
                            380 ;src/Renderer.c:273: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   4A9B DD 7E 04      [19]  381 	ld	a, 4 (ix)
   4A9E CB 3F         [ 8]  382 	srl	a
   4AA0 C6 40         [ 7]  383 	add	a, #0x40
   4AA2 4F            [ 4]  384 	ld	c,a
   4AA3 3E 00         [ 7]  385 	ld	a,#0x00
   4AA5 CE 29         [ 7]  386 	adc	a, #0x29
   4AA7 47            [ 4]  387 	ld	b,a
                            388 ;src/Renderer.c:275: u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
   4AA8 11 78 4A      [10]  389 	ld	de,#_g_colors+0
   4AAB DD 6E 06      [19]  390 	ld	l,6 (ix)
   4AAE 26 00         [ 7]  391 	ld	h,#0x00
   4AB0 19            [11]  392 	add	hl,de
   4AB1 7E            [ 7]  393 	ld	a,(hl)
   4AB2 DD 77 FE      [19]  394 	ld	-2 (ix),a
                            395 ;src/Renderer.c:276: u8 pixMask = g_pixelMask[column&1];
   4AB5 11 88 4A      [10]  396 	ld	de,#_g_pixelMask+0
   4AB8 DD 7E 04      [19]  397 	ld	a,4 (ix)
   4ABB E6 01         [ 7]  398 	and	a, #0x01
   4ABD 6F            [ 4]  399 	ld	l,a
   4ABE 26 00         [ 7]  400 	ld	h,#0x00
   4AC0 19            [11]  401 	add	hl,de
   4AC1 5E            [ 7]  402 	ld	e,(hl)
                            403 ;src/Renderer.c:285: if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
   4AC2 3E 64         [ 7]  404 	ld	a,#0x64
   4AC4 DD 96 05      [19]  405 	sub	a, 5 (ix)
   4AC7 30 04         [12]  406 	jr	NC,00102$
   4AC9 DD 36 05 64   [19]  407 	ld	5 (ix),#0x64
   4ACD                     408 00102$:
                            409 ;src/Renderer.c:287: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   4ACD DD 6E 05      [19]  410 	ld	l,5 (ix)
   4AD0 CB 3D         [ 8]  411 	srl	l
   4AD2 3E 32         [ 7]  412 	ld	a,#0x32
   4AD4 95            [ 4]  413 	sub	a, l
                            414 ;src/Renderer.c:290: pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
   4AD5 D5            [11]  415 	push	de
   4AD6 5F            [ 4]  416 	ld	e,a
   4AD7 16 00         [ 7]  417 	ld	d,#0x00
   4AD9 6B            [ 4]  418 	ld	l, e
   4ADA 62            [ 4]  419 	ld	h, d
   4ADB 29            [11]  420 	add	hl, hl
   4ADC 29            [11]  421 	add	hl, hl
   4ADD 19            [11]  422 	add	hl, de
   4ADE 29            [11]  423 	add	hl, hl
   4ADF 29            [11]  424 	add	hl, hl
   4AE0 29            [11]  425 	add	hl, hl
   4AE1 D1            [10]  426 	pop	de
   4AE2 09            [11]  427 	add	hl,bc
   4AE3 4D            [ 4]  428 	ld	c,l
   4AE4 44            [ 4]  429 	ld	b,h
                            430 ;src/Renderer.c:292: j=lineHeight;
   4AE5 DD 56 05      [19]  431 	ld	d,5 (ix)
                            432 ;src/Renderer.c:294: for(j;j;--j){
   4AE8 7B            [ 4]  433 	ld	a,e
   4AE9 2F            [ 4]  434 	cpl
   4AEA DD 77 FF      [19]  435 	ld	-1 (ix),a
   4AED 7B            [ 4]  436 	ld	a,e
   4AEE DD A6 FE      [19]  437 	and	a, -2 (ix)
   4AF1 5F            [ 4]  438 	ld	e,a
   4AF2                     439 00105$:
   4AF2 7A            [ 4]  440 	ld	a,d
   4AF3 B7            [ 4]  441 	or	a, a
   4AF4 28 0F         [12]  442 	jr	Z,00107$
                            443 ;src/Renderer.c:295: val =  ((*pvmem)&(~pixMask));
   4AF6 0A            [ 7]  444 	ld	a,(bc)
   4AF7 DD A6 FF      [19]  445 	and	a, -1 (ix)
                            446 ;src/Renderer.c:297: *pvmem = val|(w_color&pixMask);
   4AFA B3            [ 4]  447 	or	a, e
   4AFB 02            [ 7]  448 	ld	(bc),a
                            449 ;src/Renderer.c:299: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   4AFC 21 28 00      [10]  450 	ld	hl,#0x0028
   4AFF 09            [11]  451 	add	hl,bc
   4B00 4D            [ 4]  452 	ld	c,l
   4B01 44            [ 4]  453 	ld	b,h
                            454 ;src/Renderer.c:294: for(j;j;--j){
   4B02 15            [ 4]  455 	dec	d
   4B03 18 ED         [12]  456 	jr	00105$
   4B05                     457 00107$:
   4B05 DD F9         [10]  458 	ld	sp, ix
   4B07 DD E1         [14]  459 	pop	ix
   4B09 C9            [10]  460 	ret
                            461 ;src/Renderer.c:303: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            462 ;	---------------------------------
                            463 ; Function draw_column_to_buffer_enemy
                            464 ; ---------------------------------
   4B0A                     465 _draw_column_to_buffer_enemy::
   4B0A DD E5         [15]  466 	push	ix
   4B0C DD 21 00 00   [14]  467 	ld	ix,#0
   4B10 DD 39         [15]  468 	add	ix,sp
   4B12 21 F2 FF      [10]  469 	ld	hl,#-14
   4B15 39            [11]  470 	add	hl,sp
   4B16 F9            [ 6]  471 	ld	sp,hl
                            472 ;src/Renderer.c:320: u16 texture_line=0;
   4B17 DD 36 F6 00   [19]  473 	ld	-10 (ix),#0x00
   4B1B DD 36 F7 00   [19]  474 	ld	-9 (ix),#0x00
                            475 ;src/Renderer.c:322: if(texture_column>=4 && texture_column<28){
   4B1F DD 7E 07      [19]  476 	ld	a,7 (ix)
   4B22 D6 04         [ 7]  477 	sub	a, #0x04
   4B24 DA 43 4C      [10]  478 	jp	C,00112$
   4B27 DD 7E 07      [19]  479 	ld	a,7 (ix)
   4B2A D6 1C         [ 7]  480 	sub	a, #0x1C
   4B2C D2 43 4C      [10]  481 	jp	NC,00112$
                            482 ;src/Renderer.c:325: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(index-1)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
   4B2F DD 4E 06      [19]  483 	ld	c,6 (ix)
   4B32 06 00         [ 7]  484 	ld	b,#0x00
   4B34 0B            [ 6]  485 	dec	bc
   4B35 69            [ 4]  486 	ld	l, c
   4B36 60            [ 4]  487 	ld	h, b
   4B37 29            [11]  488 	add	hl, hl
   4B38 29            [11]  489 	add	hl, hl
   4B39 29            [11]  490 	add	hl, hl
   4B3A 09            [11]  491 	add	hl, bc
   4B3B 29            [11]  492 	add	hl, hl
   4B3C 29            [11]  493 	add	hl, hl
   4B3D 29            [11]  494 	add	hl, hl
   4B3E 29            [11]  495 	add	hl, hl
   4B3F 29            [11]  496 	add	hl, hl
   4B40 29            [11]  497 	add	hl, hl
   4B41 01 40 18      [10]  498 	ld	bc,#0x1840
   4B44 09            [11]  499 	add	hl,bc
   4B45 4D            [ 4]  500 	ld	c,l
   4B46 44            [ 4]  501 	ld	b,h
   4B47 DD 7E 07      [19]  502 	ld	a, 7 (ix)
   4B4A 16 00         [ 7]  503 	ld	d, #0x00
   4B4C C6 FC         [ 7]  504 	add	a,#0xFC
   4B4E 5F            [ 4]  505 	ld	e,a
   4B4F 7A            [ 4]  506 	ld	a,d
   4B50 CE FF         [ 7]  507 	adc	a,#0xFF
   4B52 57            [ 4]  508 	ld	d,a
   4B53 6B            [ 4]  509 	ld	l, e
   4B54 62            [ 4]  510 	ld	h, d
   4B55 29            [11]  511 	add	hl, hl
   4B56 19            [11]  512 	add	hl, de
   4B57 29            [11]  513 	add	hl, hl
   4B58 29            [11]  514 	add	hl, hl
   4B59 29            [11]  515 	add	hl, hl
   4B5A 09            [11]  516 	add	hl,bc
   4B5B 33            [ 6]  517 	inc	sp
   4B5C 33            [ 6]  518 	inc	sp
   4B5D E5            [11]  519 	push	hl
                            520 ;src/Renderer.c:327: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   4B5E DD 7E 04      [19]  521 	ld	a,4 (ix)
   4B61 CB 3F         [ 8]  522 	srl	a
   4B63 C6 40         [ 7]  523 	add	a, #0x40
   4B65 DD 77 FE      [19]  524 	ld	-2 (ix),a
   4B68 3E 00         [ 7]  525 	ld	a,#0x00
   4B6A CE 29         [ 7]  526 	adc	a, #0x29
   4B6C DD 77 FF      [19]  527 	ld	-1 (ix),a
                            528 ;src/Renderer.c:329: pixMask = g_pixelMask[column&1];
   4B6F 01 88 4A      [10]  529 	ld	bc,#_g_pixelMask+0
   4B72 DD 7E 04      [19]  530 	ld	a,4 (ix)
   4B75 E6 01         [ 7]  531 	and	a, #0x01
   4B77 6F            [ 4]  532 	ld	l, a
   4B78 26 00         [ 7]  533 	ld	h,#0x00
   4B7A 09            [11]  534 	add	hl,bc
   4B7B 7E            [ 7]  535 	ld	a,(hl)
   4B7C DD 77 F4      [19]  536 	ld	-12 (ix),a
                            537 ;src/Renderer.c:331: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
   4B7F DD 7E 05      [19]  538 	ld	a,5 (ix)
   4B82 CB 3F         [ 8]  539 	srl	a
   4B84 C6 32         [ 7]  540 	add	a, #0x32
   4B86 DD 77 F5      [19]  541 	ld	-11 (ix),a
                            542 ;src/Renderer.c:332: lineHeight = (lineHeight*3)/4;
   4B89 DD 4E 05      [19]  543 	ld	c,5 (ix)
   4B8C 06 00         [ 7]  544 	ld	b,#0x00
   4B8E 69            [ 4]  545 	ld	l, c
   4B8F 60            [ 4]  546 	ld	h, b
   4B90 29            [11]  547 	add	hl, hl
   4B91 09            [11]  548 	add	hl, bc
   4B92 DD 75 FC      [19]  549 	ld	-4 (ix),l
   4B95 DD 74 FD      [19]  550 	ld	-3 (ix),h
   4B98 DD 7E FC      [19]  551 	ld	a,-4 (ix)
   4B9B DD 77 FA      [19]  552 	ld	-6 (ix),a
   4B9E DD 7E FD      [19]  553 	ld	a,-3 (ix)
   4BA1 DD 77 FB      [19]  554 	ld	-5 (ix),a
   4BA4 DD CB FD 7E   [20]  555 	bit	7, -3 (ix)
   4BA8 28 10         [12]  556 	jr	Z,00114$
   4BAA DD 7E FC      [19]  557 	ld	a,-4 (ix)
   4BAD C6 03         [ 7]  558 	add	a, #0x03
   4BAF DD 77 FA      [19]  559 	ld	-6 (ix),a
   4BB2 DD 7E FD      [19]  560 	ld	a,-3 (ix)
   4BB5 CE 00         [ 7]  561 	adc	a, #0x00
   4BB7 DD 77 FB      [19]  562 	ld	-5 (ix),a
   4BBA                     563 00114$:
   4BBA DD 46 FA      [19]  564 	ld	b,-6 (ix)
   4BBD DD 4E FB      [19]  565 	ld	c,-5 (ix)
   4BC0 CB 29         [ 8]  566 	sra	c
   4BC2 CB 18         [ 8]  567 	rr	b
   4BC4 CB 29         [ 8]  568 	sra	c
   4BC6 CB 18         [ 8]  569 	rr	b
                            570 ;src/Renderer.c:333: enemy_top_height = ground_height - lineHeight;
   4BC8 DD 7E F5      [19]  571 	ld	a,-11 (ix)
   4BCB 90            [ 4]  572 	sub	a, b
   4BCC 4F            [ 4]  573 	ld	c,a
                            574 ;src/Renderer.c:335: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
   4BCD 58            [ 4]  575 	ld	e,b
   4BCE 16 00         [ 7]  576 	ld	d,#0x00
   4BD0 C5            [11]  577 	push	bc
   4BD1 D5            [11]  578 	push	de
   4BD2 21 00 18      [10]  579 	ld	hl,#0x1800
   4BD5 E5            [11]  580 	push	hl
   4BD6 CD BC 6C      [17]  581 	call	__divsint
   4BD9 F1            [10]  582 	pop	af
   4BDA F1            [10]  583 	pop	af
   4BDB C1            [10]  584 	pop	bc
   4BDC DD 75 F8      [19]  585 	ld	-8 (ix),l
   4BDF DD 74 F9      [19]  586 	ld	-7 (ix),h
                            587 ;src/Renderer.c:336: j=lineHeight;
   4BE2 50            [ 4]  588 	ld	d,b
                            589 ;src/Renderer.c:338: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   4BE3 3E 64         [ 7]  590 	ld	a,#0x64
   4BE5 90            [ 4]  591 	sub	a, b
   4BE6 30 02         [12]  592 	jr	NC,00102$
                            593 ;src/Renderer.c:339: j=90;
   4BE8 16 5A         [ 7]  594 	ld	d,#0x5A
   4BEA                     595 00102$:
                            596 ;src/Renderer.c:342: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
   4BEA 06 00         [ 7]  597 	ld	b,#0x00
   4BEC 69            [ 4]  598 	ld	l, c
   4BED 60            [ 4]  599 	ld	h, b
   4BEE 29            [11]  600 	add	hl, hl
   4BEF 29            [11]  601 	add	hl, hl
   4BF0 09            [11]  602 	add	hl, bc
   4BF1 29            [11]  603 	add	hl, hl
   4BF2 29            [11]  604 	add	hl, hl
   4BF3 29            [11]  605 	add	hl, hl
   4BF4 DD 7E FE      [19]  606 	ld	a,-2 (ix)
   4BF7 85            [ 4]  607 	add	a, l
   4BF8 4F            [ 4]  608 	ld	c,a
   4BF9 DD 7E FF      [19]  609 	ld	a,-1 (ix)
   4BFC 8C            [ 4]  610 	adc	a, h
   4BFD 47            [ 4]  611 	ld	b,a
                            612 ;src/Renderer.c:344: for(j;j;--j){
   4BFE DD 7E F4      [19]  613 	ld	a,-12 (ix)
   4C01 2F            [ 4]  614 	cpl
   4C02 5F            [ 4]  615 	ld	e,a
   4C03                     616 00110$:
   4C03 7A            [ 4]  617 	ld	a,d
   4C04 B7            [ 4]  618 	or	a, a
   4C05 28 3C         [12]  619 	jr	Z,00112$
                            620 ;src/Renderer.c:346: w_color= *(texture+(texture_line/256));
   4C07 DD 6E F7      [19]  621 	ld	l,-9 (ix)
   4C0A 26 00         [ 7]  622 	ld	h,#0x00
   4C0C DD 7E F2      [19]  623 	ld	a,-14 (ix)
   4C0F 85            [ 4]  624 	add	a, l
   4C10 6F            [ 4]  625 	ld	l,a
   4C11 DD 7E F3      [19]  626 	ld	a,-13 (ix)
   4C14 8C            [ 4]  627 	adc	a, h
   4C15 67            [ 4]  628 	ld	h,a
   4C16 7E            [ 7]  629 	ld	a,(hl)
                            630 ;src/Renderer.c:348: if(w_color){
   4C17 DD 77 FA      [19]  631 	ld	-6 (ix), a
   4C1A B7            [ 4]  632 	or	a, a
   4C1B 28 0B         [12]  633 	jr	Z,00104$
                            634 ;src/Renderer.c:349: val =  ((*pvmem)&(~pixMask));
   4C1D 0A            [ 7]  635 	ld	a,(bc)
   4C1E A3            [ 4]  636 	and	a, e
   4C1F 6F            [ 4]  637 	ld	l,a
                            638 ;src/Renderer.c:351: w_color = (w_color&pixMask);
   4C20 DD 7E FA      [19]  639 	ld	a,-6 (ix)
   4C23 DD A6 F4      [19]  640 	and	a, -12 (ix)
                            641 ;src/Renderer.c:353: *pvmem = val|w_color;
   4C26 B5            [ 4]  642 	or	a, l
   4C27 02            [ 7]  643 	ld	(bc),a
   4C28                     644 00104$:
                            645 ;src/Renderer.c:356: texture_line += texture_line_add;
   4C28 DD 7E F6      [19]  646 	ld	a,-10 (ix)
   4C2B DD 86 F8      [19]  647 	add	a, -8 (ix)
   4C2E DD 77 F6      [19]  648 	ld	-10 (ix),a
   4C31 DD 7E F7      [19]  649 	ld	a,-9 (ix)
   4C34 DD 8E F9      [19]  650 	adc	a, -7 (ix)
   4C37 DD 77 F7      [19]  651 	ld	-9 (ix),a
                            652 ;src/Renderer.c:358: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   4C3A 21 28 00      [10]  653 	ld	hl,#0x0028
   4C3D 09            [11]  654 	add	hl,bc
   4C3E 4D            [ 4]  655 	ld	c,l
   4C3F 44            [ 4]  656 	ld	b,h
                            657 ;src/Renderer.c:344: for(j;j;--j){
   4C40 15            [ 4]  658 	dec	d
   4C41 18 C0         [12]  659 	jr	00110$
   4C43                     660 00112$:
   4C43 DD F9         [10]  661 	ld	sp, ix
   4C45 DD E1         [14]  662 	pop	ix
   4C47 C9            [10]  663 	ret
                            664 ;src/Renderer.c:364: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
                            665 ;	---------------------------------
                            666 ; Function draw_column_to_buffer
                            667 ; ---------------------------------
   4C48                     668 _draw_column_to_buffer::
   4C48 DD E5         [15]  669 	push	ix
   4C4A DD 21 00 00   [14]  670 	ld	ix,#0
   4C4E DD 39         [15]  671 	add	ix,sp
   4C50 21 F0 FF      [10]  672 	ld	hl,#-16
   4C53 39            [11]  673 	add	hl,sp
   4C54 F9            [ 6]  674 	ld	sp,hl
                            675 ;src/Renderer.c:365: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   4C55 DD 7E 04      [19]  676 	ld	a,4 (ix)
   4C58 CB 3F         [ 8]  677 	srl	a
   4C5A C6 40         [ 7]  678 	add	a, #0x40
   4C5C DD 77 FE      [19]  679 	ld	-2 (ix),a
   4C5F 3E 00         [ 7]  680 	ld	a,#0x00
   4C61 CE 29         [ 7]  681 	adc	a, #0x29
   4C63 DD 77 FF      [19]  682 	ld	-1 (ix),a
                            683 ;src/Renderer.c:368: u8 pixMask = g_pixelMask[column&1];
   4C66 01 88 4A      [10]  684 	ld	bc,#_g_pixelMask+0
   4C69 DD 7E 04      [19]  685 	ld	a,4 (ix)
   4C6C E6 01         [ 7]  686 	and	a, #0x01
   4C6E 6F            [ 4]  687 	ld	l, a
   4C6F 26 00         [ 7]  688 	ld	h,#0x00
   4C71 09            [11]  689 	add	hl,bc
   4C72 7E            [ 7]  690 	ld	a,(hl)
   4C73 DD 77 F5      [19]  691 	ld	-11 (ix),a
                            692 ;src/Renderer.c:373: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
   4C76 DD 7E 06      [19]  693 	ld	a, 6 (ix)
   4C79 87            [ 4]  694 	add	a, a
   4C7A 87            [ 4]  695 	add	a, a
   4C7B 47            [ 4]  696 	ld	b,a
   4C7C 0E 00         [ 7]  697 	ld	c,#0x00
   4C7E 21 40 04      [10]  698 	ld	hl,#0x0440
   4C81 09            [11]  699 	add	hl,bc
   4C82 4D            [ 4]  700 	ld	c,l
   4C83 44            [ 4]  701 	ld	b,h
   4C84 DD 6E 07      [19]  702 	ld	l,7 (ix)
   4C87 26 00         [ 7]  703 	ld	h,#0x00
   4C89 29            [11]  704 	add	hl, hl
   4C8A 29            [11]  705 	add	hl, hl
   4C8B 29            [11]  706 	add	hl, hl
   4C8C 29            [11]  707 	add	hl, hl
   4C8D 29            [11]  708 	add	hl, hl
   4C8E 09            [11]  709 	add	hl,bc
   4C8F DD 75 F6      [19]  710 	ld	-10 (ix),l
   4C92 DD 74 F7      [19]  711 	ld	-9 (ix),h
                            712 ;src/Renderer.c:375: u8 j=lineHeight;
   4C95 DD 7E 05      [19]  713 	ld	a,5 (ix)
                            714 ;src/Renderer.c:381: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
   4C98 DD 77 F1      [19]  715 	ld	-15 (ix), a
   4C9B DD 77 FA      [19]  716 	ld	-6 (ix),a
   4C9E DD 36 FB 00   [19]  717 	ld	-5 (ix),#0x00
   4CA2 DD 6E FA      [19]  718 	ld	l,-6 (ix)
   4CA5 DD 66 FB      [19]  719 	ld	h,-5 (ix)
   4CA8 E5            [11]  720 	push	hl
   4CA9 21 00 20      [10]  721 	ld	hl,#0x2000
   4CAC E5            [11]  722 	push	hl
   4CAD CD BC 6C      [17]  723 	call	__divsint
   4CB0 F1            [10]  724 	pop	af
   4CB1 F1            [10]  725 	pop	af
   4CB2 DD 75 F8      [19]  726 	ld	-8 (ix),l
   4CB5 DD 74 F9      [19]  727 	ld	-7 (ix),h
                            728 ;src/Renderer.c:382: u16 wall_texture_line=0;
   4CB8 DD 36 F3 00   [19]  729 	ld	-13 (ix),#0x00
   4CBC DD 36 F4 00   [19]  730 	ld	-12 (ix),#0x00
                            731 ;src/Renderer.c:384: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   4CC0 DD 4E F1      [19]  732 	ld	c,-15 (ix)
   4CC3 CB 39         [ 8]  733 	srl	c
   4CC5 3E 32         [ 7]  734 	ld	a,#0x32
   4CC7 91            [ 4]  735 	sub	a, c
   4CC8 DD 77 F2      [19]  736 	ld	-14 (ix),a
                            737 ;src/Renderer.c:388: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   4CCB 3E 64         [ 7]  738 	ld	a,#0x64
   4CCD DD 96 F1      [19]  739 	sub	a, -15 (ix)
   4CD0 30 4B         [12]  740 	jr	NC,00102$
                            741 ;src/Renderer.c:389: ceiling_height=0;
   4CD2 DD 36 F2 00   [19]  742 	ld	-14 (ix),#0x00
                            743 ;src/Renderer.c:390: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
   4CD6 DD 7E FA      [19]  744 	ld	a,-6 (ix)
   4CD9 C6 9C         [ 7]  745 	add	a,#0x9C
   4CDB 4F            [ 4]  746 	ld	c,a
   4CDC DD 7E FB      [19]  747 	ld	a,-5 (ix)
   4CDF CE FF         [ 7]  748 	adc	a,#0xFF
   4CE1 47            [ 4]  749 	ld	b,a
   4CE2 DD 71 FC      [19]  750 	ld	-4 (ix),c
   4CE5 DD 70 FD      [19]  751 	ld	-3 (ix),b
   4CE8 CB 78         [ 8]  752 	bit	7, b
   4CEA 28 10         [12]  753 	jr	Z,00109$
   4CEC DD 7E FA      [19]  754 	ld	a,-6 (ix)
   4CEF C6 9D         [ 7]  755 	add	a, #0x9D
   4CF1 DD 77 FC      [19]  756 	ld	-4 (ix),a
   4CF4 DD 7E FB      [19]  757 	ld	a,-5 (ix)
   4CF7 CE FF         [ 7]  758 	adc	a, #0xFF
   4CF9 DD 77 FD      [19]  759 	ld	-3 (ix),a
   4CFC                     760 00109$:
   4CFC DD 4E FC      [19]  761 	ld	c,-4 (ix)
   4CFF DD 46 FD      [19]  762 	ld	b,-3 (ix)
   4D02 CB 28         [ 8]  763 	sra	b
   4D04 CB 19         [ 8]  764 	rr	c
   4D06 DD 6E F8      [19]  765 	ld	l,-8 (ix)
   4D09 DD 66 F9      [19]  766 	ld	h,-7 (ix)
   4D0C E5            [11]  767 	push	hl
   4D0D C5            [11]  768 	push	bc
   4D0E CD 06 6C      [17]  769 	call	__mulint
   4D11 F1            [10]  770 	pop	af
   4D12 F1            [10]  771 	pop	af
   4D13 DD 75 F3      [19]  772 	ld	-13 (ix),l
   4D16 DD 74 F4      [19]  773 	ld	-12 (ix),h
                            774 ;src/Renderer.c:391: j=SCREEN_TEXTURE_HEIGHT;
   4D19 DD 36 F1 64   [19]  775 	ld	-15 (ix),#0x64
   4D1D                     776 00102$:
                            777 ;src/Renderer.c:394: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
   4D1D DD 4E F2      [19]  778 	ld	c,-14 (ix)
   4D20 06 00         [ 7]  779 	ld	b,#0x00
   4D22 69            [ 4]  780 	ld	l, c
   4D23 60            [ 4]  781 	ld	h, b
   4D24 29            [11]  782 	add	hl, hl
   4D25 29            [11]  783 	add	hl, hl
   4D26 09            [11]  784 	add	hl, bc
   4D27 29            [11]  785 	add	hl, hl
   4D28 29            [11]  786 	add	hl, hl
   4D29 29            [11]  787 	add	hl, hl
   4D2A DD 7E FE      [19]  788 	ld	a,-2 (ix)
   4D2D 85            [ 4]  789 	add	a, l
   4D2E 4F            [ 4]  790 	ld	c,a
   4D2F DD 7E FF      [19]  791 	ld	a,-1 (ix)
   4D32 8C            [ 4]  792 	adc	a, h
   4D33 47            [ 4]  793 	ld	b,a
                            794 ;src/Renderer.c:396: for(j;j;--j){
   4D34 DD 7E F5      [19]  795 	ld	a,-11 (ix)
   4D37 2F            [ 4]  796 	cpl
   4D38 5F            [ 4]  797 	ld	e,a
   4D39 DD 56 F1      [19]  798 	ld	d,-15 (ix)
   4D3C                     799 00105$:
   4D3C 7A            [ 4]  800 	ld	a,d
   4D3D B7            [ 4]  801 	or	a, a
   4D3E 28 36         [12]  802 	jr	Z,00107$
                            803 ;src/Renderer.c:397: val =  ((*pvmem)&(~pixMask));
   4D40 0A            [ 7]  804 	ld	a,(bc)
   4D41 A3            [ 4]  805 	and	a, e
   4D42 DD 77 F0      [19]  806 	ld	-16 (ix),a
                            807 ;src/Renderer.c:399: w_color = (*(texture+(wall_texture_line/256))&pixMask);
   4D45 DD 7E F4      [19]  808 	ld	a, -12 (ix)
   4D48 26 00         [ 7]  809 	ld	h, #0x00
   4D4A DD 86 F6      [19]  810 	add	a, -10 (ix)
   4D4D 6F            [ 4]  811 	ld	l,a
   4D4E 7C            [ 4]  812 	ld	a,h
   4D4F DD 8E F7      [19]  813 	adc	a, -9 (ix)
   4D52 67            [ 4]  814 	ld	h,a
   4D53 7E            [ 7]  815 	ld	a,(hl)
   4D54 DD A6 F5      [19]  816 	and	a, -11 (ix)
                            817 ;src/Renderer.c:401: *pvmem = val|w_color;
   4D57 DD B6 F0      [19]  818 	or	a, -16 (ix)
   4D5A 02            [ 7]  819 	ld	(bc),a
                            820 ;src/Renderer.c:403: wall_texture_line += wall_texture_line_add;
   4D5B DD 7E F3      [19]  821 	ld	a,-13 (ix)
   4D5E DD 86 F8      [19]  822 	add	a, -8 (ix)
   4D61 DD 77 F3      [19]  823 	ld	-13 (ix),a
   4D64 DD 7E F4      [19]  824 	ld	a,-12 (ix)
   4D67 DD 8E F9      [19]  825 	adc	a, -7 (ix)
   4D6A DD 77 F4      [19]  826 	ld	-12 (ix),a
                            827 ;src/Renderer.c:405: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   4D6D 21 28 00      [10]  828 	ld	hl,#0x0028
   4D70 09            [11]  829 	add	hl,bc
   4D71 4D            [ 4]  830 	ld	c,l
   4D72 44            [ 4]  831 	ld	b,h
                            832 ;src/Renderer.c:396: for(j;j;--j){
   4D73 15            [ 4]  833 	dec	d
   4D74 18 C6         [12]  834 	jr	00105$
   4D76                     835 00107$:
   4D76 DD F9         [10]  836 	ld	sp, ix
   4D78 DD E1         [14]  837 	pop	ix
   4D7A C9            [10]  838 	ret
                            839 ;src/Renderer.c:409: void render_draw_to_buffer(){//TODO Optimize
                            840 ;	---------------------------------
                            841 ; Function render_draw_to_buffer
                            842 ; ---------------------------------
   4D7B                     843 _render_draw_to_buffer::
   4D7B DD E5         [15]  844 	push	ix
   4D7D DD 21 00 00   [14]  845 	ld	ix,#0
   4D81 DD 39         [15]  846 	add	ix,sp
   4D83 21 C2 FF      [10]  847 	ld	hl,#-62
   4D86 39            [11]  848 	add	hl,sp
   4D87 F9            [ 6]  849 	ld	sp,hl
                            850 ;src/Renderer.c:419: u8 zHeight = 5;
   4D88 DD 36 C8 05   [19]  851 	ld	-56 (ix),#0x05
                            852 ;src/Renderer.c:425: u8 offsetDiff = 16;
   4D8C DD 36 CE 10   [19]  853 	ld	-50 (ix),#0x10
                            854 ;src/Renderer.c:430: u8 lineStart = 0;
   4D90 DD 36 C9 00   [19]  855 	ld	-55 (ix),#0x00
                            856 ;src/Renderer.c:432: u8 lateralWallWidth=0;
   4D94 DD 36 C5 00   [19]  857 	ld	-59 (ix),#0x00
                            858 ;src/Renderer.c:444: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   4D98 21 7D 4A      [10]  859 	ld	hl, #_g_colors + 5
   4D9B 46            [ 7]  860 	ld	b,(hl)
   4D9C 21 A8 07      [10]  861 	ld	hl,#0x07A8
   4D9F E5            [11]  862 	push	hl
   4DA0 C5            [11]  863 	push	bc
   4DA1 33            [ 6]  864 	inc	sp
   4DA2 21 40 29      [10]  865 	ld	hl,#0x2940
   4DA5 E5            [11]  866 	push	hl
   4DA6 CD 9D 6C      [17]  867 	call	_cpct_memset
                            868 ;src/Renderer.c:445: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
   4DA9 21 79 4A      [10]  869 	ld	hl, #_g_colors + 1
   4DAC 46            [ 7]  870 	ld	b,(hl)
   4DAD 21 50 00      [10]  871 	ld	hl,#0x0050
   4DB0 E5            [11]  872 	push	hl
   4DB1 C5            [11]  873 	push	bc
   4DB2 33            [ 6]  874 	inc	sp
   4DB3 21 E8 30      [10]  875 	ld	hl,#0x30E8
   4DB6 E5            [11]  876 	push	hl
   4DB7 CD 9D 6C      [17]  877 	call	_cpct_memset
                            878 ;src/Renderer.c:446: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   4DBA 21 7E 4A      [10]  879 	ld	hl, #_g_colors + 6
   4DBD 46            [ 7]  880 	ld	b,(hl)
   4DBE 21 A8 07      [10]  881 	ld	hl,#0x07A8
   4DC1 E5            [11]  882 	push	hl
   4DC2 C5            [11]  883 	push	bc
   4DC3 33            [ 6]  884 	inc	sp
   4DC4 21 38 31      [10]  885 	ld	hl,#0x3138
   4DC7 E5            [11]  886 	push	hl
   4DC8 CD 9D 6C      [17]  887 	call	_cpct_memset
                            888 ;src/Renderer.c:448: calculate_cells_in_view();
   4DCB CD B9 48      [17]  889 	call	_calculate_cells_in_view
                            890 ;src/Renderer.c:466: currentCellID = cells_in_view_array[lineStart + 1];
   4DCE 2A 8B 4A      [16]  891 	ld	hl,(_cells_in_view_array)
   4DD1 DD 75 F8      [19]  892 	ld	-8 (ix),l
   4DD4 DD 74 F9      [19]  893 	ld	-7 (ix),h
                            894 ;src/Renderer.c:450: if(g_texturedWalls){
   4DD7 3A 8A 4A      [13]  895 	ld	a,(#_g_texturedWalls + 0)
   4DDA B7            [ 4]  896 	or	a, a
   4DDB CA 1E 53      [10]  897 	jp	Z,00358$
                            898 ;src/Renderer.c:452: do{
   4DDE DD 36 C2 06   [19]  899 	ld	-62 (ix),#0x06
   4DE2                     900 00175$:
                            901 ;src/Renderer.c:454: --z;
   4DE2 DD 35 C2      [23]  902 	dec	-62 (ix)
                            903 ;src/Renderer.c:458: xCellCount = (z) ? (zHeight >> 1) : 0;
   4DE5 DD 7E C8      [19]  904 	ld	a,-56 (ix)
   4DE8 CB 3F         [ 8]  905 	srl	a
   4DEA DD 77 FA      [19]  906 	ld	-6 (ix),a
   4DED DD 7E C2      [19]  907 	ld	a,-62 (ix)
   4DF0 B7            [ 4]  908 	or	a, a
   4DF1 28 05         [12]  909 	jr	Z,00262$
   4DF3 DD 4E FA      [19]  910 	ld	c,-6 (ix)
   4DF6 18 02         [12]  911 	jr	00263$
   4DF8                     912 00262$:
   4DF8 0E 00         [ 7]  913 	ld	c,#0x00
   4DFA                     914 00263$:
   4DFA DD 71 FB      [19]  915 	ld	-5 (ix),c
                            916 ;src/Renderer.c:459: lateralWallSlope=0;
   4DFD DD 36 FD 00   [19]  917 	ld	-3 (ix),#0x00
                            918 ;src/Renderer.c:460: lateralWallSlopeCounter=0;
   4E01 DD 36 FF 00   [19]  919 	ld	-1 (ix),#0x00
                            920 ;src/Renderer.c:461: xHeight=0;
   4E05 DD 36 FC 00   [19]  921 	ld	-4 (ix),#0x00
                            922 ;src/Renderer.c:463: lateralWallCounter = 0;
   4E09 DD 36 FE 00   [19]  923 	ld	-2 (ix),#0x00
                            924 ;src/Renderer.c:465: newCell=1;
   4E0D DD 36 F2 01   [19]  925 	ld	-14 (ix),#0x01
                            926 ;src/Renderer.c:466: currentCellID = cells_in_view_array[lineStart + 1];
   4E11 DD 7E C9      [19]  927 	ld	a,-55 (ix)
   4E14 DD 77 F6      [19]  928 	ld	-10 (ix),a
   4E17 DD 36 F7 00   [19]  929 	ld	-9 (ix),#0x00
   4E1B DD 4E F6      [19]  930 	ld	c,-10 (ix)
   4E1E DD 46 F7      [19]  931 	ld	b,-9 (ix)
   4E21 03            [ 6]  932 	inc	bc
   4E22 DD 6E F8      [19]  933 	ld	l,-8 (ix)
   4E25 DD 66 F9      [19]  934 	ld	h,-7 (ix)
   4E28 09            [11]  935 	add	hl,bc
   4E29 7E            [ 7]  936 	ld	a,(hl)
   4E2A DD 77 DC      [19]  937 	ld	-36 (ix),a
                            938 ;src/Renderer.c:468: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   4E2D DD 7E F8      [19]  939 	ld	a,-8 (ix)
   4E30 DD 86 C9      [19]  940 	add	a, -55 (ix)
   4E33 6F            [ 4]  941 	ld	l,a
   4E34 DD 7E F9      [19]  942 	ld	a,-7 (ix)
   4E37 CE 00         [ 7]  943 	adc	a, #0x00
   4E39 67            [ 4]  944 	ld	h,a
   4E3A 4E            [ 7]  945 	ld	c,(hl)
                            946 ;src/Renderer.c:469: if(lastCellWasWall&CELL_WALL_MASK){
   4E3B CB 79         [ 8]  947 	bit	7, c
   4E3D 28 09         [12]  948 	jr	Z,00102$
                            949 ;src/Renderer.c:470: lastWallId=lastCellWasWall;
   4E3F DD 71 D9      [19]  950 	ld	-39 (ix),c
                            951 ;src/Renderer.c:471: lastCellWasWall=1;
   4E42 DD 36 D7 01   [19]  952 	ld	-41 (ix),#0x01
   4E46 18 08         [12]  953 	jr	00296$
   4E48                     954 00102$:
                            955 ;src/Renderer.c:474: lastCellWasWall=0;
   4E48 DD 36 D7 00   [19]  956 	ld	-41 (ix),#0x00
                            957 ;src/Renderer.c:475: lastWallId=CELLTYPE_FLOOR;
   4E4C DD 36 D9 00   [19]  958 	ld	-39 (ix),#0x00
                            959 ;src/Renderer.c:478: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   4E50                     960 00296$:
   4E50 DD 36 C7 00   [19]  961 	ld	-57 (ix),#0x00
   4E54 DD 36 C3 00   [19]  962 	ld	-61 (ix),#0x00
   4E58                     963 00252$:
                            964 ;src/Renderer.c:480: if (xCellCount == zHeight)
   4E58 DD 7E C8      [19]  965 	ld	a,-56 (ix)
   4E5B DD 96 FB      [19]  966 	sub	a, -5 (ix)
   4E5E 20 4B         [12]  967 	jr	NZ,00105$
                            968 ;src/Renderer.c:482: ++xCell;
   4E60 DD 34 C7      [23]  969 	inc	-57 (ix)
                            970 ;src/Renderer.c:483: xCellCount = 0;
   4E63 DD 36 FB 00   [19]  971 	ld	-5 (ix),#0x00
                            972 ;src/Renderer.c:484: newCell=1;
   4E67 DD 36 F2 01   [19]  973 	ld	-14 (ix),#0x01
                            974 ;src/Renderer.c:485: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   4E6B DD 7E C7      [19]  975 	ld	a,-57 (ix)
   4E6E DD 77 DA      [19]  976 	ld	-38 (ix),a
   4E71 DD 36 DB 00   [19]  977 	ld	-37 (ix),#0x00
   4E75 DD 7E F6      [19]  978 	ld	a,-10 (ix)
   4E78 DD 86 DA      [19]  979 	add	a, -38 (ix)
   4E7B DD 77 DA      [19]  980 	ld	-38 (ix),a
   4E7E DD 7E F7      [19]  981 	ld	a,-9 (ix)
   4E81 DD 8E DB      [19]  982 	adc	a, -37 (ix)
   4E84 DD 77 DB      [19]  983 	ld	-37 (ix),a
   4E87 DD 34 DA      [23]  984 	inc	-38 (ix)
   4E8A 20 03         [12]  985 	jr	NZ,00608$
   4E8C DD 34 DB      [23]  986 	inc	-37 (ix)
   4E8F                     987 00608$:
   4E8F DD 7E F8      [19]  988 	ld	a,-8 (ix)
   4E92 DD 86 DA      [19]  989 	add	a, -38 (ix)
   4E95 DD 77 DA      [19]  990 	ld	-38 (ix),a
   4E98 DD 7E F9      [19]  991 	ld	a,-7 (ix)
   4E9B DD 8E DB      [19]  992 	adc	a, -37 (ix)
   4E9E DD 77 DB      [19]  993 	ld	-37 (ix),a
   4EA1 DD 6E DA      [19]  994 	ld	l,-38 (ix)
   4EA4 DD 66 DB      [19]  995 	ld	h,-37 (ix)
   4EA7 7E            [ 7]  996 	ld	a,(hl)
   4EA8 DD 77 DC      [19]  997 	ld	-36 (ix),a
   4EAB                     998 00105$:
                            999 ;src/Renderer.c:487: if(!(x%2)){
   4EAB DD 7E C3      [19] 1000 	ld	a,-61 (ix)
   4EAE E6 01         [ 7] 1001 	and	a, #0x01
   4EB0 DD 77 DA      [19] 1002 	ld	-38 (ix),a
                           1003 ;src/Renderer.c:490: if (currentCellID & CELL_WALL_MASK)//Wall
   4EB3 DD 7E DC      [19] 1004 	ld	a,-36 (ix)
   4EB6 E6 80         [ 7] 1005 	and	a, #0x80
   4EB8 DD 77 D8      [19] 1006 	ld	-40 (ix),a
                           1007 ;src/Renderer.c:510: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4EBB DD 7E FB      [19] 1008 	ld	a,-5 (ix)
   4EBE DD 77 EC      [19] 1009 	ld	-20 (ix),a
   4EC1 DD 36 ED 00   [19] 1010 	ld	-19 (ix),#0x00
   4EC5 DD 7E C8      [19] 1011 	ld	a,-56 (ix)
   4EC8 DD 77 E1      [19] 1012 	ld	-31 (ix),a
                           1013 ;src/Renderer.c:487: if(!(x%2)){
   4ECB DD 7E DA      [19] 1014 	ld	a,-38 (ix)
   4ECE B7            [ 4] 1015 	or	a, a
   4ECF C2 82 4F      [10] 1016 	jp	NZ,00118$
                           1017 ;src/Renderer.c:488: if ((lateralWallCounter == 0)||newCell)
   4ED2 DD 7E FE      [19] 1018 	ld	a,-2 (ix)
   4ED5 B7            [ 4] 1019 	or	a, a
   4ED6 28 07         [12] 1020 	jr	Z,00114$
   4ED8 DD 7E F2      [19] 1021 	ld	a,-14 (ix)
   4EDB B7            [ 4] 1022 	or	a, a
   4EDC CA 82 4F      [10] 1023 	jp	Z,00118$
   4EDF                    1024 00114$:
                           1025 ;src/Renderer.c:490: if (currentCellID & CELL_WALL_MASK)//Wall
   4EDF DD 7E D8      [19] 1026 	ld	a,-40 (ix)
   4EE2 B7            [ 4] 1027 	or	a, a
   4EE3 28 22         [12] 1028 	jr	Z,00112$
                           1029 ;src/Renderer.c:492: lateralWallCounter = 0;//(zHeight - xCellCount);
   4EE5 DD 36 FE 00   [19] 1030 	ld	-2 (ix),#0x00
                           1031 ;src/Renderer.c:493: lateralWallSlope = 0;
   4EE9 DD 36 FD 00   [19] 1032 	ld	-3 (ix),#0x00
                           1033 ;src/Renderer.c:494: xHeight = zHeight;
   4EED DD 7E C8      [19] 1034 	ld	a,-56 (ix)
   4EF0 DD 77 FC      [19] 1035 	ld	-4 (ix),a
                           1036 ;src/Renderer.c:495: color = currentCellID&0b01111111;
   4EF3 DD 7E DC      [19] 1037 	ld	a,-36 (ix)
   4EF6 E6 7F         [ 7] 1038 	and	a, #0x7F
   4EF8 DD 77 F3      [19] 1039 	ld	-13 (ix),a
                           1040 ;src/Renderer.c:496: lastCellWasWall = 1;
   4EFB DD 36 D7 01   [19] 1041 	ld	-41 (ix),#0x01
                           1042 ;src/Renderer.c:497: lastWallId=currentCellID;
   4EFF DD 7E DC      [19] 1043 	ld	a,-36 (ix)
   4F02 DD 77 D9      [19] 1044 	ld	-39 (ix),a
   4F05 18 77         [12] 1045 	jr	00113$
   4F07                    1046 00112$:
                           1047 ;src/Renderer.c:500: if(lateralWallCounter==0){//Lateral wall not finished
   4F07 DD 7E FE      [19] 1048 	ld	a,-2 (ix)
   4F0A B7            [ 4] 1049 	or	a, a
   4F0B 20 71         [12] 1050 	jr	NZ,00113$
                           1051 ;src/Renderer.c:501: if (lastCellWasWall)
   4F0D DD 7E D7      [19] 1052 	ld	a,-41 (ix)
   4F10 B7            [ 4] 1053 	or	a, a
   4F11 28 5B         [12] 1054 	jr	Z,00107$
                           1055 ;src/Renderer.c:504: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   4F13 DD 7E CE      [19] 1056 	ld	a,-50 (ix)
   4F16 DD 96 C7      [19] 1057 	sub	a, -57 (ix)
   4F19 87            [ 4] 1058 	add	a, a
   4F1A 3C            [ 4] 1059 	inc	a
                           1060 ;src/Renderer.c:505: lateralWallSlopeCounter = lateralWallSlope / 2;
   4F1B DD 77 FD      [19] 1061 	ld	-3 (ix), a
   4F1E CB 3F         [ 8] 1062 	srl	a
   4F20 DD 77 FF      [19] 1063 	ld	-1 (ix),a
                           1064 ;src/Renderer.c:506: lateralWallCounter = lateralWallSlope * zHeight;
   4F23 DD 5E C8      [19] 1065 	ld	e,-56 (ix)
   4F26 DD 66 FD      [19] 1066 	ld	h,-3 (ix)
   4F29 2E 00         [ 7] 1067 	ld	l, #0x00
   4F2B 55            [ 4] 1068 	ld	d, l
   4F2C 06 08         [ 7] 1069 	ld	b, #0x08
   4F2E                    1070 00609$:
   4F2E 29            [11] 1071 	add	hl,hl
   4F2F 30 01         [12] 1072 	jr	NC,00610$
   4F31 19            [11] 1073 	add	hl,de
   4F32                    1074 00610$:
   4F32 10 FA         [13] 1075 	djnz	00609$
                           1076 ;src/Renderer.c:507: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   4F34 7D            [ 4] 1077 	ld	a,l
   4F35 E6 FC         [ 7] 1078 	and	a, #0xFC
   4F37 CB C7         [ 8] 1079 	set	0, a
   4F39 CB 3F         [ 8] 1080 	srl	a
   4F3B CB 3F         [ 8] 1081 	srl	a
   4F3D DD 96 FB      [19] 1082 	sub	a, -5 (ix)
                           1083 ;src/Renderer.c:508: lateralWallWidth=lateralWallCounter;
   4F40 DD 77 FE      [19] 1084 	ld	-2 (ix), a
   4F43 DD 77 C5      [19] 1085 	ld	-59 (ix),a
                           1086 ;src/Renderer.c:509: lastCellWasWall = 0;
   4F46 DD 36 D7 00   [19] 1087 	ld	-41 (ix),#0x00
                           1088 ;src/Renderer.c:510: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4F4A DD 6E EC      [19] 1089 	ld	l,-20 (ix)
   4F4D DD 66 ED      [19] 1090 	ld	h,-19 (ix)
   4F50 29            [11] 1091 	add	hl, hl
   4F51 DD 4E FD      [19] 1092 	ld	c,-3 (ix)
   4F54 06 00         [ 7] 1093 	ld	b,#0x00
   4F56 C5            [11] 1094 	push	bc
   4F57 E5            [11] 1095 	push	hl
   4F58 CD BC 6C      [17] 1096 	call	__divsint
   4F5B F1            [10] 1097 	pop	af
   4F5C F1            [10] 1098 	pop	af
   4F5D DD 7E E1      [19] 1099 	ld	a,-31 (ix)
   4F60 95            [ 4] 1100 	sub	a, l
   4F61 DD 77 FC      [19] 1101 	ld	-4 (ix),a
                           1102 ;src/Renderer.c:511: color = lastWallId&0b01111111;
   4F64 DD 7E D9      [19] 1103 	ld	a,-39 (ix)
   4F67 E6 7F         [ 7] 1104 	and	a, #0x7F
   4F69 DD 77 F3      [19] 1105 	ld	-13 (ix),a
   4F6C 18 10         [12] 1106 	jr	00113$
   4F6E                    1107 00107$:
                           1108 ;src/Renderer.c:515: xHeight = 0;
   4F6E DD 36 FC 00   [19] 1109 	ld	-4 (ix),#0x00
                           1110 ;src/Renderer.c:516: lastCellWasWall = 0;
   4F72 DD 36 D7 00   [19] 1111 	ld	-41 (ix),#0x00
                           1112 ;src/Renderer.c:517: lateralWallSlope=0;
   4F76 DD 36 FD 00   [19] 1113 	ld	-3 (ix),#0x00
                           1114 ;src/Renderer.c:518: lastWallId=0;
   4F7A DD 36 D9 00   [19] 1115 	ld	-39 (ix),#0x00
   4F7E                    1116 00113$:
                           1117 ;src/Renderer.c:522: newCell=0;
   4F7E DD 36 F2 00   [19] 1118 	ld	-14 (ix),#0x00
   4F82                    1119 00118$:
                           1120 ;src/Renderer.c:525: if (lateralWallCounter > 0)
   4F82 DD 7E FE      [19] 1121 	ld	a,-2 (ix)
   4F85 B7            [ 4] 1122 	or	a, a
   4F86 28 1E         [12] 1123 	jr	Z,00124$
                           1124 ;src/Renderer.c:528: if (lateralWallSlope != 0)
   4F88 DD 7E FD      [19] 1125 	ld	a,-3 (ix)
   4F8B B7            [ 4] 1126 	or	a, a
   4F8C 28 15         [12] 1127 	jr	Z,00122$
                           1128 ;src/Renderer.c:530: if (lateralWallSlopeCounter == lateralWallSlope)
   4F8E DD 7E FF      [19] 1129 	ld	a,-1 (ix)
   4F91 DD 96 FD      [19] 1130 	sub	a, -3 (ix)
   4F94 20 0A         [12] 1131 	jr	NZ,00120$
                           1132 ;src/Renderer.c:532: lateralWallSlopeCounter = 0;
   4F96 DD 36 FF 00   [19] 1133 	ld	-1 (ix),#0x00
                           1134 ;src/Renderer.c:533: xHeight -= 2;
   4F9A DD 35 FC      [23] 1135 	dec	-4 (ix)
   4F9D DD 35 FC      [23] 1136 	dec	-4 (ix)
   4FA0                    1137 00120$:
                           1138 ;src/Renderer.c:535: ++lateralWallSlopeCounter;
   4FA0 DD 34 FF      [23] 1139 	inc	-1 (ix)
   4FA3                    1140 00122$:
                           1141 ;src/Renderer.c:538: --lateralWallCounter;
   4FA3 DD 35 FE      [23] 1142 	dec	-2 (ix)
   4FA6                    1143 00124$:
                           1144 ;src/Renderer.c:549: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   4FA6 DD 7E C8      [19] 1145 	ld	a,-56 (ix)
   4FA9 DD 77 F4      [19] 1146 	ld	-12 (ix),a
   4FAC DD 36 F5 00   [19] 1147 	ld	-11 (ix),#0x00
                           1148 ;src/Renderer.c:541: if (!(x%2))
   4FB0 DD 7E DA      [19] 1149 	ld	a,-38 (ix)
   4FB3 B7            [ 4] 1150 	or	a, a
   4FB4 C2 33 50      [10] 1151 	jp	NZ,00136$
                           1152 ;src/Renderer.c:543: if(xHeight > 0){
   4FB7 DD 7E FC      [19] 1153 	ld	a,-4 (ix)
   4FBA B7            [ 4] 1154 	or	a, a
   4FBB 28 76         [12] 1155 	jr	Z,00136$
                           1156 ;src/Renderer.c:549: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   4FBD DD 6E EC      [19] 1157 	ld	l,-20 (ix)
   4FC0 DD 66 ED      [19] 1158 	ld	h,-19 (ix)
   4FC3 29            [11] 1159 	add	hl, hl
   4FC4 29            [11] 1160 	add	hl, hl
   4FC5 29            [11] 1161 	add	hl, hl
   4FC6 29            [11] 1162 	add	hl, hl
   4FC7 29            [11] 1163 	add	hl, hl
   4FC8 DD 4E F4      [19] 1164 	ld	c,-12 (ix)
   4FCB DD 46 F5      [19] 1165 	ld	b,-11 (ix)
   4FCE C5            [11] 1166 	push	bc
   4FCF E5            [11] 1167 	push	hl
   4FD0 CD BC 6C      [17] 1168 	call	__divsint
   4FD3 F1            [10] 1169 	pop	af
   4FD4 F1            [10] 1170 	pop	af
   4FD5 4D            [ 4] 1171 	ld	c,l
                           1172 ;src/Renderer.c:544: if (lateralWallCounter > 0)
   4FD6 DD 7E FE      [19] 1173 	ld	a,-2 (ix)
   4FD9 B7            [ 4] 1174 	or	a, a
   4FDA 28 21         [12] 1175 	jr	Z,00126$
                           1176 ;src/Renderer.c:546: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   4FDC DD 5E C5      [19] 1177 	ld	e,-59 (ix)
   4FDF 16 00         [ 7] 1178 	ld	d,#0x00
   4FE1 DD 46 FE      [19] 1179 	ld	b,-2 (ix)
   4FE4 26 00         [ 7] 1180 	ld	h,#0x00
   4FE6 7B            [ 4] 1181 	ld	a,e
   4FE7 90            [ 4] 1182 	sub	a, b
   4FE8 6F            [ 4] 1183 	ld	l,a
   4FE9 7A            [ 4] 1184 	ld	a,d
   4FEA 9C            [ 4] 1185 	sbc	a, h
   4FEB 67            [ 4] 1186 	ld	h,a
   4FEC 29            [11] 1187 	add	hl, hl
   4FED 29            [11] 1188 	add	hl, hl
   4FEE 29            [11] 1189 	add	hl, hl
   4FEF 29            [11] 1190 	add	hl, hl
   4FF0 29            [11] 1191 	add	hl, hl
   4FF1 C5            [11] 1192 	push	bc
   4FF2 D5            [11] 1193 	push	de
   4FF3 E5            [11] 1194 	push	hl
   4FF4 CD BC 6C      [17] 1195 	call	__divsint
   4FF7 F1            [10] 1196 	pop	af
   4FF8 F1            [10] 1197 	pop	af
   4FF9 55            [ 4] 1198 	ld	d,l
   4FFA C1            [10] 1199 	pop	bc
   4FFB 18 01         [12] 1200 	jr	00127$
   4FFD                    1201 00126$:
                           1202 ;src/Renderer.c:549: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   4FFD 51            [ 4] 1203 	ld	d,c
   4FFE                    1204 00127$:
                           1205 ;src/Renderer.c:551: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   4FFE DD 46 C3      [19] 1206 	ld	b,-61 (ix)
   5001 CB 38         [ 8] 1207 	srl	b
   5003 C5            [11] 1208 	push	bc
   5004 D5            [11] 1209 	push	de
   5005 33            [ 6] 1210 	inc	sp
   5006 DD 66 F3      [19] 1211 	ld	h,-13 (ix)
   5009 DD 6E FC      [19] 1212 	ld	l,-4 (ix)
   500C E5            [11] 1213 	push	hl
   500D C5            [11] 1214 	push	bc
   500E 33            [ 6] 1215 	inc	sp
   500F CD 48 4C      [17] 1216 	call	_draw_column_to_buffer
   5012 F1            [10] 1217 	pop	af
   5013 F1            [10] 1218 	pop	af
   5014 C1            [10] 1219 	pop	bc
                           1220 ;src/Renderer.c:552: if(!(currentCellID&CELL_WALL_MASK)){
   5015 DD 7E D8      [19] 1221 	ld	a,-40 (ix)
   5018 B7            [ 4] 1222 	or	a, a
   5019 20 18         [12] 1223 	jr	NZ,00136$
                           1224 ;src/Renderer.c:553: if(currentCellID&CELL_ENEMY_MASK){
   501B DD 7E DC      [19] 1225 	ld	a,-36 (ix)
   501E E6 0F         [ 7] 1226 	and	a, #0x0F
   5020 28 11         [12] 1227 	jr	Z,00136$
                           1228 ;src/Renderer.c:554: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   5022 79            [ 4] 1229 	ld	a,c
   5023 F5            [11] 1230 	push	af
   5024 33            [ 6] 1231 	inc	sp
   5025 DD 66 DC      [19] 1232 	ld	h,-36 (ix)
   5028 DD 6E C8      [19] 1233 	ld	l,-56 (ix)
   502B E5            [11] 1234 	push	hl
   502C C5            [11] 1235 	push	bc
   502D 33            [ 6] 1236 	inc	sp
   502E CD 0A 4B      [17] 1237 	call	_draw_column_to_buffer_enemy
   5031 F1            [10] 1238 	pop	af
   5032 F1            [10] 1239 	pop	af
                           1240 ;src/Renderer.c:556: else if(currentCellID&CELL_ITEM_MASK){
   5033                    1241 00136$:
                           1242 ;src/Renderer.c:563: ++xCellCount;
   5033 DD 34 FB      [23] 1243 	inc	-5 (ix)
                           1244 ;src/Renderer.c:478: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   5036 DD 34 C3      [23] 1245 	inc	-61 (ix)
                           1246 ;src/Renderer.c:466: currentCellID = cells_in_view_array[lineStart + 1];
   5039 2A 8B 4A      [16] 1247 	ld	hl,(_cells_in_view_array)
   503C DD 75 F8      [19] 1248 	ld	-8 (ix),l
   503F DD 74 F9      [19] 1249 	ld	-7 (ix),h
                           1250 ;src/Renderer.c:478: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   5042 DD 7E C3      [19] 1251 	ld	a,-61 (ix)
   5045 D6 50         [ 7] 1252 	sub	a, #0x50
   5047 DA 58 4E      [10] 1253 	jp	C,00252$
                           1254 ;src/Renderer.c:570: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   504A DD 7E C2      [19] 1255 	ld	a,-62 (ix)
   504D B7            [ 4] 1256 	or	a, a
   504E 28 05         [12] 1257 	jr	Z,00264$
   5050 DD 4E FA      [19] 1258 	ld	c,-6 (ix)
   5053 18 02         [12] 1259 	jr	00265$
   5055                    1260 00264$:
   5055 0E 00         [ 7] 1261 	ld	c,#0x00
   5057                    1262 00265$:
   5057 DD 71 EC      [19] 1263 	ld	-20 (ix),c
                           1264 ;src/Renderer.c:571: lateralWallSlope=0;
   505A DD 36 D8 00   [19] 1265 	ld	-40 (ix),#0x00
                           1266 ;src/Renderer.c:572: lateralWallSlopeCounter=0;
   505E DD 36 DA 00   [19] 1267 	ld	-38 (ix),#0x00
                           1268 ;src/Renderer.c:573: xHeight=0;
   5062 DD 36 D7 00   [19] 1269 	ld	-41 (ix),#0x00
                           1270 ;src/Renderer.c:575: lateralWallCounter = 0;
   5066 DD 36 D9 00   [19] 1271 	ld	-39 (ix),#0x00
                           1272 ;src/Renderer.c:576: lineEnd = lineStart + offsetDiff * 2 + 2;
   506A DD 7E CE      [19] 1273 	ld	a,-50 (ix)
   506D 87            [ 4] 1274 	add	a, a
   506E 4F            [ 4] 1275 	ld	c,a
   506F DD 7E C9      [19] 1276 	ld	a,-55 (ix)
   5072 81            [ 4] 1277 	add	a, c
   5073 DD 77 DC      [19] 1278 	ld	-36 (ix), a
   5076 4F            [ 4] 1279 	ld	c, a
   5077 0C            [ 4] 1280 	inc	c
   5078 0C            [ 4] 1281 	inc	c
                           1282 ;src/Renderer.c:578: newCell=1;
   5079 DD 36 F6 01   [19] 1283 	ld	-10 (ix),#0x01
                           1284 ;src/Renderer.c:579: currentCellID = cells_in_view_array[lineEnd - 1];
   507D DD 71 EA      [19] 1285 	ld	-22 (ix),c
   5080 DD 36 EB 00   [19] 1286 	ld	-21 (ix),#0x00
   5084 DD 5E EA      [19] 1287 	ld	e,-22 (ix)
   5087 DD 56 EB      [19] 1288 	ld	d,-21 (ix)
   508A 1B            [ 6] 1289 	dec	de
   508B DD 6E F8      [19] 1290 	ld	l,-8 (ix)
   508E DD 66 F9      [19] 1291 	ld	h,-7 (ix)
   5091 19            [11] 1292 	add	hl,de
   5092 7E            [ 7] 1293 	ld	a,(hl)
   5093 DD 77 F2      [19] 1294 	ld	-14 (ix),a
                           1295 ;src/Renderer.c:581: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   5096 DD 6E F8      [19] 1296 	ld	l,-8 (ix)
   5099 DD 66 F9      [19] 1297 	ld	h,-7 (ix)
   509C 06 00         [ 7] 1298 	ld	b,#0x00
   509E 09            [11] 1299 	add	hl, bc
   509F 4E            [ 7] 1300 	ld	c,(hl)
                           1301 ;src/Renderer.c:582: if(lastCellWasWall&CELL_WALL_MASK){
   50A0 CB 79         [ 8] 1302 	bit	7, c
   50A2 28 09         [12] 1303 	jr	Z,00139$
                           1304 ;src/Renderer.c:583: lastWallId=lastCellWasWall;
   50A4 DD 71 FE      [19] 1305 	ld	-2 (ix),c
                           1306 ;src/Renderer.c:584: lastCellWasWall=1;
   50A7 DD 36 FC 01   [19] 1307 	ld	-4 (ix),#0x01
   50AB 18 08         [12] 1308 	jr	00315$
   50AD                    1309 00139$:
                           1310 ;src/Renderer.c:587: lastCellWasWall=0;
   50AD DD 36 FC 00   [19] 1311 	ld	-4 (ix),#0x00
                           1312 ;src/Renderer.c:588: lastWallId=CELLTYPE_FLOOR;
   50B1 DD 36 FE 00   [19] 1313 	ld	-2 (ix),#0x00
                           1314 ;src/Renderer.c:591: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   50B5                    1315 00315$:
   50B5 DD 36 C7 00   [19] 1316 	ld	-57 (ix),#0x00
   50B9 DD 36 C3 9F   [19] 1317 	ld	-61 (ix),#0x9F
   50BD                    1318 00254$:
                           1319 ;src/Renderer.c:594: if (xCellCount == zHeight)
   50BD DD 7E C8      [19] 1320 	ld	a,-56 (ix)
   50C0 DD 96 EC      [19] 1321 	sub	a, -20 (ix)
   50C3 20 50         [12] 1322 	jr	NZ,00142$
                           1323 ;src/Renderer.c:596: ++xCell;
   50C5 DD 34 C7      [23] 1324 	inc	-57 (ix)
                           1325 ;src/Renderer.c:597: xCellCount = 0;
   50C8 DD 36 EC 00   [19] 1326 	ld	-20 (ix),#0x00
                           1327 ;src/Renderer.c:598: newCell=1;
   50CC DD 36 F6 01   [19] 1328 	ld	-10 (ix),#0x01
                           1329 ;src/Renderer.c:599: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   50D0 DD 7E C7      [19] 1330 	ld	a,-57 (ix)
   50D3 DD 77 EE      [19] 1331 	ld	-18 (ix),a
   50D6 DD 36 EF 00   [19] 1332 	ld	-17 (ix),#0x00
   50DA DD 7E EA      [19] 1333 	ld	a,-22 (ix)
   50DD DD 96 EE      [19] 1334 	sub	a, -18 (ix)
   50E0 DD 77 EE      [19] 1335 	ld	-18 (ix),a
   50E3 DD 7E EB      [19] 1336 	ld	a,-21 (ix)
   50E6 DD 9E EF      [19] 1337 	sbc	a, -17 (ix)
   50E9 DD 77 EF      [19] 1338 	ld	-17 (ix),a
   50EC DD 6E EE      [19] 1339 	ld	l,-18 (ix)
   50EF DD 66 EF      [19] 1340 	ld	h,-17 (ix)
   50F2 2B            [ 6] 1341 	dec	hl
   50F3 DD 75 EE      [19] 1342 	ld	-18 (ix),l
   50F6 DD 74 EF      [19] 1343 	ld	-17 (ix),h
   50F9 DD 7E F8      [19] 1344 	ld	a,-8 (ix)
   50FC DD 86 EE      [19] 1345 	add	a, -18 (ix)
   50FF DD 77 EE      [19] 1346 	ld	-18 (ix),a
   5102 DD 7E F9      [19] 1347 	ld	a,-7 (ix)
   5105 DD 8E EF      [19] 1348 	adc	a, -17 (ix)
   5108 DD 77 EF      [19] 1349 	ld	-17 (ix),a
   510B DD 6E EE      [19] 1350 	ld	l,-18 (ix)
   510E DD 66 EF      [19] 1351 	ld	h,-17 (ix)
   5111 7E            [ 7] 1352 	ld	a,(hl)
   5112 DD 77 F2      [19] 1353 	ld	-14 (ix),a
   5115                    1354 00142$:
                           1355 ;src/Renderer.c:601: if(!(x%2)){
   5115 DD 7E C3      [19] 1356 	ld	a,-61 (ix)
   5118 E6 01         [ 7] 1357 	and	a, #0x01
   511A DD 77 EE      [19] 1358 	ld	-18 (ix),a
                           1359 ;src/Renderer.c:490: if (currentCellID & CELL_WALL_MASK)//Wall
   511D DD 7E F2      [19] 1360 	ld	a,-14 (ix)
   5120 E6 80         [ 7] 1361 	and	a, #0x80
   5122 DD 77 FF      [19] 1362 	ld	-1 (ix),a
                           1363 ;src/Renderer.c:510: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   5125 DD 7E EC      [19] 1364 	ld	a,-20 (ix)
   5128 DD 77 F0      [19] 1365 	ld	-16 (ix),a
   512B DD 36 F1 00   [19] 1366 	ld	-15 (ix),#0x00
                           1367 ;src/Renderer.c:601: if(!(x%2)){
   512F DD 7E EE      [19] 1368 	ld	a,-18 (ix)
   5132 B7            [ 4] 1369 	or	a, a
   5133 C2 05 52      [10] 1370 	jp	NZ,00155$
                           1371 ;src/Renderer.c:602: if (lateralWallCounter == 0 || newCell)
   5136 DD 7E D9      [19] 1372 	ld	a,-39 (ix)
   5139 B7            [ 4] 1373 	or	a, a
   513A 28 07         [12] 1374 	jr	Z,00151$
   513C DD 7E F6      [19] 1375 	ld	a,-10 (ix)
   513F B7            [ 4] 1376 	or	a, a
   5140 CA 05 52      [10] 1377 	jp	Z,00155$
   5143                    1378 00151$:
                           1379 ;src/Renderer.c:604: if ( currentCellID & CELL_WALL_MASK)//Wall
   5143 DD 7E FF      [19] 1380 	ld	a,-1 (ix)
   5146 B7            [ 4] 1381 	or	a, a
   5147 28 23         [12] 1382 	jr	Z,00149$
                           1383 ;src/Renderer.c:606: lateralWallCounter = 0;
   5149 DD 36 D9 00   [19] 1384 	ld	-39 (ix),#0x00
                           1385 ;src/Renderer.c:607: lateralWallSlope = 0;
   514D DD 36 D8 00   [19] 1386 	ld	-40 (ix),#0x00
                           1387 ;src/Renderer.c:608: xHeight = zHeight;
   5151 DD 7E C8      [19] 1388 	ld	a,-56 (ix)
   5154 DD 77 D7      [19] 1389 	ld	-41 (ix),a
                           1390 ;src/Renderer.c:609: color = currentCellID&0b01111111;
   5157 DD 7E F2      [19] 1391 	ld	a,-14 (ix)
   515A E6 7F         [ 7] 1392 	and	a, #0x7F
   515C DD 77 F3      [19] 1393 	ld	-13 (ix),a
                           1394 ;src/Renderer.c:610: lastCellWasWall = 1;
   515F DD 36 FC 01   [19] 1395 	ld	-4 (ix),#0x01
                           1396 ;src/Renderer.c:611: lastWallId=currentCellID;
   5163 DD 7E F2      [19] 1397 	ld	a,-14 (ix)
   5166 DD 77 FE      [19] 1398 	ld	-2 (ix),a
   5169 C3 01 52      [10] 1399 	jp	00150$
   516C                    1400 00149$:
                           1401 ;src/Renderer.c:613: else if(lateralWallCounter==0){
   516C DD 7E D9      [19] 1402 	ld	a,-39 (ix)
   516F B7            [ 4] 1403 	or	a, a
   5170 C2 01 52      [10] 1404 	jp	NZ,00150$
                           1405 ;src/Renderer.c:614: if (lastCellWasWall)
   5173 DD 7E FC      [19] 1406 	ld	a,-4 (ix)
   5176 B7            [ 4] 1407 	or	a, a
   5177 28 78         [12] 1408 	jr	Z,00144$
                           1409 ;src/Renderer.c:617: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   5179 DD 7E CE      [19] 1410 	ld	a,-50 (ix)
   517C DD 96 C7      [19] 1411 	sub	a, -57 (ix)
   517F 87            [ 4] 1412 	add	a, a
   5180 3C            [ 4] 1413 	inc	a
                           1414 ;src/Renderer.c:618: lateralWallSlopeCounter = lateralWallSlope / 2;
   5181 DD 77 D8      [19] 1415 	ld	-40 (ix), a
   5184 CB 3F         [ 8] 1416 	srl	a
   5186 DD 77 DA      [19] 1417 	ld	-38 (ix),a
                           1418 ;src/Renderer.c:619: lateralWallCounter = lateralWallSlope * zHeight;
   5189 DD 5E C8      [19] 1419 	ld	e,-56 (ix)
   518C DD 66 D8      [19] 1420 	ld	h,-40 (ix)
   518F 2E 00         [ 7] 1421 	ld	l, #0x00
   5191 55            [ 4] 1422 	ld	d, l
   5192 06 08         [ 7] 1423 	ld	b, #0x08
   5194                    1424 00617$:
   5194 29            [11] 1425 	add	hl,hl
   5195 30 01         [12] 1426 	jr	NC,00618$
   5197 19            [11] 1427 	add	hl,de
   5198                    1428 00618$:
   5198 10 FA         [13] 1429 	djnz	00617$
                           1430 ;src/Renderer.c:620: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   519A 4D            [ 4] 1431 	ld	c,l
   519B 06 00         [ 7] 1432 	ld	b,#0x00
   519D 7D            [ 4] 1433 	ld	a,l
   519E E6 03         [ 7] 1434 	and	a, #0x03
   51A0 5F            [ 4] 1435 	ld	e,a
   51A1 16 00         [ 7] 1436 	ld	d,#0x00
   51A3 79            [ 4] 1437 	ld	a,c
   51A4 93            [ 4] 1438 	sub	a, e
   51A5 4F            [ 4] 1439 	ld	c,a
   51A6 78            [ 4] 1440 	ld	a,b
   51A7 9A            [ 4] 1441 	sbc	a, d
   51A8 47            [ 4] 1442 	ld	b,a
   51A9 59            [ 4] 1443 	ld	e, c
   51AA 50            [ 4] 1444 	ld	d, b
   51AB 13            [ 6] 1445 	inc	de
   51AC 6B            [ 4] 1446 	ld	l, e
   51AD 62            [ 4] 1447 	ld	h, d
   51AE CB 7A         [ 8] 1448 	bit	7, d
   51B0 28 04         [12] 1449 	jr	Z,00266$
   51B2 21 04 00      [10] 1450 	ld	hl,#0x0004
   51B5 09            [11] 1451 	add	hl,bc
   51B6                    1452 00266$:
   51B6 CB 2C         [ 8] 1453 	sra	h
   51B8 CB 1D         [ 8] 1454 	rr	l
   51BA CB 2C         [ 8] 1455 	sra	h
   51BC CB 1D         [ 8] 1456 	rr	l
   51BE DD 4E EC      [19] 1457 	ld	c,-20 (ix)
   51C1 7D            [ 4] 1458 	ld	a,l
   51C2 91            [ 4] 1459 	sub	a, c
                           1460 ;src/Renderer.c:621: lateralWallWidth=lateralWallCounter;
   51C3 DD 77 D9      [19] 1461 	ld	-39 (ix), a
   51C6 DD 77 C5      [19] 1462 	ld	-59 (ix),a
                           1463 ;src/Renderer.c:622: lastCellWasWall = 0;
   51C9 DD 36 FC 00   [19] 1464 	ld	-4 (ix),#0x00
                           1465 ;src/Renderer.c:623: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   51CD DD 6E F0      [19] 1466 	ld	l,-16 (ix)
   51D0 DD 66 F1      [19] 1467 	ld	h,-15 (ix)
   51D3 29            [11] 1468 	add	hl, hl
   51D4 DD 4E D8      [19] 1469 	ld	c,-40 (ix)
   51D7 06 00         [ 7] 1470 	ld	b,#0x00
   51D9 C5            [11] 1471 	push	bc
   51DA E5            [11] 1472 	push	hl
   51DB CD BC 6C      [17] 1473 	call	__divsint
   51DE F1            [10] 1474 	pop	af
   51DF F1            [10] 1475 	pop	af
   51E0 DD 7E E1      [19] 1476 	ld	a,-31 (ix)
   51E3 95            [ 4] 1477 	sub	a, l
   51E4 DD 77 D7      [19] 1478 	ld	-41 (ix),a
                           1479 ;src/Renderer.c:624: color = lastWallId&0b01111111;
   51E7 DD 7E FE      [19] 1480 	ld	a,-2 (ix)
   51EA E6 7F         [ 7] 1481 	and	a, #0x7F
   51EC DD 77 F3      [19] 1482 	ld	-13 (ix),a
   51EF 18 10         [12] 1483 	jr	00150$
   51F1                    1484 00144$:
                           1485 ;src/Renderer.c:628: xHeight = 0;
   51F1 DD 36 D7 00   [19] 1486 	ld	-41 (ix),#0x00
                           1487 ;src/Renderer.c:629: lastCellWasWall = 0;
   51F5 DD 36 FC 00   [19] 1488 	ld	-4 (ix),#0x00
                           1489 ;src/Renderer.c:630: lateralWallSlope=0;
   51F9 DD 36 D8 00   [19] 1490 	ld	-40 (ix),#0x00
                           1491 ;src/Renderer.c:631: lastWallId=0;
   51FD DD 36 FE 00   [19] 1492 	ld	-2 (ix),#0x00
   5201                    1493 00150$:
                           1494 ;src/Renderer.c:634: newCell=0;
   5201 DD 36 F6 00   [19] 1495 	ld	-10 (ix),#0x00
   5205                    1496 00155$:
                           1497 ;src/Renderer.c:639: if (lateralWallCounter > 0)
   5205 DD 7E D9      [19] 1498 	ld	a,-39 (ix)
   5208 B7            [ 4] 1499 	or	a, a
   5209 28 1E         [12] 1500 	jr	Z,00161$
                           1501 ;src/Renderer.c:642: if (lateralWallSlope != 0)
   520B DD 7E D8      [19] 1502 	ld	a,-40 (ix)
   520E B7            [ 4] 1503 	or	a, a
   520F 28 15         [12] 1504 	jr	Z,00159$
                           1505 ;src/Renderer.c:644: if (lateralWallSlopeCounter == lateralWallSlope)
   5211 DD 7E D8      [19] 1506 	ld	a,-40 (ix)
   5214 DD 96 DA      [19] 1507 	sub	a, -38 (ix)
   5217 20 0A         [12] 1508 	jr	NZ,00157$
                           1509 ;src/Renderer.c:646: lateralWallSlopeCounter = 0;
   5219 DD 36 DA 00   [19] 1510 	ld	-38 (ix),#0x00
                           1511 ;src/Renderer.c:647: xHeight -= 2;
   521D DD 35 D7      [23] 1512 	dec	-41 (ix)
   5220 DD 35 D7      [23] 1513 	dec	-41 (ix)
   5223                    1514 00157$:
                           1515 ;src/Renderer.c:649: ++lateralWallSlopeCounter;
   5223 DD 34 DA      [23] 1516 	inc	-38 (ix)
   5226                    1517 00159$:
                           1518 ;src/Renderer.c:651: --lateralWallCounter;
   5226 DD 35 D9      [23] 1519 	dec	-39 (ix)
   5229                    1520 00161$:
                           1521 ;src/Renderer.c:655: if (!(x%2))
   5229 DD 7E EE      [19] 1522 	ld	a,-18 (ix)
   522C B7            [ 4] 1523 	or	a, a
   522D C2 ED 52      [10] 1524 	jp	NZ,00173$
                           1525 ;src/Renderer.c:658: if(xHeight > 0){
   5230 DD 7E D7      [19] 1526 	ld	a,-41 (ix)
   5233 B7            [ 4] 1527 	or	a, a
   5234 CA ED 52      [10] 1528 	jp	Z,00173$
                           1529 ;src/Renderer.c:665: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   5237 DD 7E F4      [19] 1530 	ld	a,-12 (ix)
   523A DD 96 F0      [19] 1531 	sub	a, -16 (ix)
   523D DD 77 F0      [19] 1532 	ld	-16 (ix),a
   5240 DD 7E F5      [19] 1533 	ld	a,-11 (ix)
   5243 DD 9E F1      [19] 1534 	sbc	a, -15 (ix)
   5246 DD 77 F1      [19] 1535 	ld	-15 (ix),a
   5249 3E 06         [ 7] 1536 	ld	a,#0x05+1
   524B 18 08         [12] 1537 	jr	00622$
   524D                    1538 00621$:
   524D DD CB F0 26   [23] 1539 	sla	-16 (ix)
   5251 DD CB F1 16   [23] 1540 	rl	-15 (ix)
   5255                    1541 00622$:
   5255 3D            [ 4] 1542 	dec	a
   5256 20 F5         [12] 1543 	jr	NZ,00621$
   5258 DD 6E F4      [19] 1544 	ld	l,-12 (ix)
   525B DD 66 F5      [19] 1545 	ld	h,-11 (ix)
   525E E5            [11] 1546 	push	hl
   525F DD 6E F0      [19] 1547 	ld	l,-16 (ix)
   5262 DD 66 F1      [19] 1548 	ld	h,-15 (ix)
   5265 E5            [11] 1549 	push	hl
   5266 CD BC 6C      [17] 1550 	call	__divsint
   5269 F1            [10] 1551 	pop	af
   526A F1            [10] 1552 	pop	af
   526B DD 74 F1      [19] 1553 	ld	-15 (ix),h
   526E DD 75 F0      [19] 1554 	ld	-16 (ix), l
   5271 DD 75 F0      [19] 1555 	ld	-16 (ix), l
                           1556 ;src/Renderer.c:660: if (lateralWallCounter > 0)
   5274 DD 7E D9      [19] 1557 	ld	a,-39 (ix)
   5277 B7            [ 4] 1558 	or	a, a
   5278 28 39         [12] 1559 	jr	Z,00163$
                           1560 ;src/Renderer.c:662: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   527A DD 7E D9      [19] 1561 	ld	a,-39 (ix)
   527D DD 77 EE      [19] 1562 	ld	-18 (ix),a
   5280 DD 36 EF 00   [19] 1563 	ld	-17 (ix),#0x00
   5284 3E 06         [ 7] 1564 	ld	a,#0x05+1
   5286 18 08         [12] 1565 	jr	00624$
   5288                    1566 00623$:
   5288 DD CB EE 26   [23] 1567 	sla	-18 (ix)
   528C DD CB EF 16   [23] 1568 	rl	-17 (ix)
   5290                    1569 00624$:
   5290 3D            [ 4] 1570 	dec	a
   5291 20 F5         [12] 1571 	jr	NZ,00623$
   5293 DD 7E C5      [19] 1572 	ld	a,-59 (ix)
   5296 DD 77 DF      [19] 1573 	ld	-33 (ix),a
   5299 DD 36 E0 00   [19] 1574 	ld	-32 (ix),#0x00
   529D DD 6E DF      [19] 1575 	ld	l,-33 (ix)
   52A0 DD 66 E0      [19] 1576 	ld	h,-32 (ix)
   52A3 E5            [11] 1577 	push	hl
   52A4 DD 6E EE      [19] 1578 	ld	l,-18 (ix)
   52A7 DD 66 EF      [19] 1579 	ld	h,-17 (ix)
   52AA E5            [11] 1580 	push	hl
   52AB CD BC 6C      [17] 1581 	call	__divsint
   52AE F1            [10] 1582 	pop	af
   52AF F1            [10] 1583 	pop	af
   52B0 55            [ 4] 1584 	ld	d,l
   52B1 18 03         [12] 1585 	jr	00164$
   52B3                    1586 00163$:
                           1587 ;src/Renderer.c:665: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   52B3 DD 56 F0      [19] 1588 	ld	d,-16 (ix)
   52B6                    1589 00164$:
                           1590 ;src/Renderer.c:668: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   52B6 DD 46 C3      [19] 1591 	ld	b,-61 (ix)
   52B9 CB 38         [ 8] 1592 	srl	b
   52BB C5            [11] 1593 	push	bc
   52BC D5            [11] 1594 	push	de
   52BD 33            [ 6] 1595 	inc	sp
   52BE DD 66 F3      [19] 1596 	ld	h,-13 (ix)
   52C1 DD 6E D7      [19] 1597 	ld	l,-41 (ix)
   52C4 E5            [11] 1598 	push	hl
   52C5 C5            [11] 1599 	push	bc
   52C6 33            [ 6] 1600 	inc	sp
   52C7 CD 48 4C      [17] 1601 	call	_draw_column_to_buffer
   52CA F1            [10] 1602 	pop	af
   52CB F1            [10] 1603 	pop	af
   52CC C1            [10] 1604 	pop	bc
                           1605 ;src/Renderer.c:670: if(!(currentCellID&CELL_WALL_MASK)){
   52CD DD 7E FF      [19] 1606 	ld	a,-1 (ix)
   52D0 B7            [ 4] 1607 	or	a, a
   52D1 20 1A         [12] 1608 	jr	NZ,00173$
                           1609 ;src/Renderer.c:671: if(currentCellID&CELL_ENEMY_MASK){
   52D3 DD 7E F2      [19] 1610 	ld	a,-14 (ix)
   52D6 E6 0F         [ 7] 1611 	and	a, #0x0F
   52D8 28 13         [12] 1612 	jr	Z,00173$
                           1613 ;src/Renderer.c:672: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   52DA DD 66 F0      [19] 1614 	ld	h,-16 (ix)
   52DD DD 6E F2      [19] 1615 	ld	l,-14 (ix)
   52E0 E5            [11] 1616 	push	hl
   52E1 DD 7E C8      [19] 1617 	ld	a,-56 (ix)
   52E4 F5            [11] 1618 	push	af
   52E5 33            [ 6] 1619 	inc	sp
   52E6 C5            [11] 1620 	push	bc
   52E7 33            [ 6] 1621 	inc	sp
   52E8 CD 0A 4B      [17] 1622 	call	_draw_column_to_buffer_enemy
   52EB F1            [10] 1623 	pop	af
   52EC F1            [10] 1624 	pop	af
                           1625 ;src/Renderer.c:674: else if(currentCellID&CELL_ITEM_MASK){
   52ED                    1626 00173$:
                           1627 ;src/Renderer.c:680: ++xCellCount;
   52ED DD 34 EC      [23] 1628 	inc	-20 (ix)
                           1629 ;src/Renderer.c:591: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   52F0 DD 35 C3      [23] 1630 	dec	-61 (ix)
                           1631 ;src/Renderer.c:466: currentCellID = cells_in_view_array[lineStart + 1];
   52F3 2A 8B 4A      [16] 1632 	ld	hl,(_cells_in_view_array)
   52F6 DD 75 F8      [19] 1633 	ld	-8 (ix),l
   52F9 DD 74 F9      [19] 1634 	ld	-7 (ix),h
                           1635 ;src/Renderer.c:591: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   52FC DD 7E C3      [19] 1636 	ld	a,-61 (ix)
   52FF D6 50         [ 7] 1637 	sub	a, #0x50
   5301 D2 BD 50      [10] 1638 	jp	NC,00254$
                           1639 ;src/Renderer.c:687: lineStart = lineStart + (offsetDiff * 2) + 3;
   5304 DD 7E DC      [19] 1640 	ld	a,-36 (ix)
   5307 C6 03         [ 7] 1641 	add	a, #0x03
   5309 DD 77 C9      [19] 1642 	ld	-55 (ix),a
                           1643 ;src/Renderer.c:688: zHeight += zHeight;
   530C DD CB C8 26   [23] 1644 	sla	-56 (ix)
                           1645 ;src/Renderer.c:689: offsetDiff = offsetDiff >> 1;
   5310 DD CB CE 3E   [23] 1646 	srl	-50 (ix)
                           1647 ;src/Renderer.c:691: }while(z);
   5314 DD 7E C2      [19] 1648 	ld	a,-62 (ix)
   5317 B7            [ 4] 1649 	or	a, a
   5318 C2 E2 4D      [10] 1650 	jp	NZ,00175$
   531B C3 C5 58      [10] 1651 	jp	00260$
                           1652 ;src/Renderer.c:696: do{
   531E                    1653 00358$:
   531E DD 36 C2 06   [19] 1654 	ld	-62 (ix),#0x06
   5322                    1655 00246$:
                           1656 ;src/Renderer.c:698: --z;
   5322 DD 35 C2      [23] 1657 	dec	-62 (ix)
                           1658 ;src/Renderer.c:458: xCellCount = (z) ? (zHeight >> 1) : 0;
   5325 DD 7E C8      [19] 1659 	ld	a,-56 (ix)
   5328 CB 3F         [ 8] 1660 	srl	a
   532A DD 77 DF      [19] 1661 	ld	-33 (ix),a
                           1662 ;src/Renderer.c:702: xCellCount = (z) ? (zHeight >> 1) : 0;
   532D DD 7E C2      [19] 1663 	ld	a,-62 (ix)
   5330 B7            [ 4] 1664 	or	a, a
   5331 28 05         [12] 1665 	jr	Z,00267$
   5333 DD 4E DF      [19] 1666 	ld	c,-33 (ix)
   5336 18 02         [12] 1667 	jr	00268$
   5338                    1668 00267$:
   5338 0E 00         [ 7] 1669 	ld	c,#0x00
   533A                    1670 00268$:
   533A DD 71 CF      [19] 1671 	ld	-49 (ix),c
                           1672 ;src/Renderer.c:703: lateralWallSlope=0;
   533D DD 36 C4 00   [19] 1673 	ld	-60 (ix),#0x00
                           1674 ;src/Renderer.c:704: lateralWallSlopeCounter=0;
   5341 DD 36 CD 00   [19] 1675 	ld	-51 (ix),#0x00
                           1676 ;src/Renderer.c:705: xHeight=0;
   5345 DD 36 D0 00   [19] 1677 	ld	-48 (ix),#0x00
                           1678 ;src/Renderer.c:707: lateralWallCounter = 0;
   5349 DD 36 F0 00   [19] 1679 	ld	-16 (ix),#0x00
                           1680 ;src/Renderer.c:709: newCell=1;
   534D DD 36 D1 01   [19] 1681 	ld	-47 (ix),#0x01
                           1682 ;src/Renderer.c:466: currentCellID = cells_in_view_array[lineStart + 1];
   5351 DD 7E C9      [19] 1683 	ld	a,-55 (ix)
   5354 DD 77 EE      [19] 1684 	ld	-18 (ix),a
   5357 DD 36 EF 00   [19] 1685 	ld	-17 (ix),#0x00
                           1686 ;src/Renderer.c:710: currentCellID = cells_in_view_array[lineStart + 1];
   535B DD 4E EE      [19] 1687 	ld	c,-18 (ix)
   535E DD 46 EF      [19] 1688 	ld	b,-17 (ix)
   5361 03            [ 6] 1689 	inc	bc
   5362 DD 6E F8      [19] 1690 	ld	l,-8 (ix)
   5365 DD 66 F9      [19] 1691 	ld	h,-7 (ix)
   5368 09            [11] 1692 	add	hl,bc
   5369 7E            [ 7] 1693 	ld	a,(hl)
   536A DD 77 D2      [19] 1694 	ld	-46 (ix),a
                           1695 ;src/Renderer.c:712: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   536D DD 7E F8      [19] 1696 	ld	a,-8 (ix)
   5370 DD 86 C9      [19] 1697 	add	a, -55 (ix)
   5373 6F            [ 4] 1698 	ld	l,a
   5374 DD 7E F9      [19] 1699 	ld	a,-7 (ix)
   5377 CE 00         [ 7] 1700 	adc	a, #0x00
   5379 67            [ 4] 1701 	ld	h,a
   537A 4E            [ 7] 1702 	ld	c,(hl)
                           1703 ;src/Renderer.c:713: if(lastCellWasWall&CELL_WALL_MASK){
   537B CB 79         [ 8] 1704 	bit	7, c
   537D 28 09         [12] 1705 	jr	Z,00179$
                           1706 ;src/Renderer.c:714: lastWallId=lastCellWasWall;
   537F DD 71 CB      [19] 1707 	ld	-53 (ix),c
                           1708 ;src/Renderer.c:715: lastCellWasWall=1;
   5382 DD 36 EA 01   [19] 1709 	ld	-22 (ix),#0x01
   5386 18 08         [12] 1710 	jr	00336$
   5388                    1711 00179$:
                           1712 ;src/Renderer.c:718: lastCellWasWall=0;
   5388 DD 36 EA 00   [19] 1713 	ld	-22 (ix),#0x00
                           1714 ;src/Renderer.c:719: lastWallId=CELLTYPE_FLOOR;
   538C DD 36 CB 00   [19] 1715 	ld	-53 (ix),#0x00
                           1716 ;src/Renderer.c:722: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   5390                    1717 00336$:
   5390 DD 36 C7 00   [19] 1718 	ld	-57 (ix),#0x00
   5394 DD 36 C3 00   [19] 1719 	ld	-61 (ix),#0x00
   5398                    1720 00256$:
                           1721 ;src/Renderer.c:724: if (xCellCount == zHeight)
   5398 DD 7E CF      [19] 1722 	ld	a,-49 (ix)
   539B DD 96 C8      [19] 1723 	sub	a, -56 (ix)
   539E 20 4B         [12] 1724 	jr	NZ,00182$
                           1725 ;src/Renderer.c:726: ++xCell;
   53A0 DD 34 C7      [23] 1726 	inc	-57 (ix)
                           1727 ;src/Renderer.c:727: xCellCount = 0;
   53A3 DD 36 CF 00   [19] 1728 	ld	-49 (ix),#0x00
                           1729 ;src/Renderer.c:728: newCell=1;
   53A7 DD 36 D1 01   [19] 1730 	ld	-47 (ix),#0x01
                           1731 ;src/Renderer.c:729: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   53AB DD 7E C7      [19] 1732 	ld	a,-57 (ix)
   53AE DD 77 F4      [19] 1733 	ld	-12 (ix),a
   53B1 DD 36 F5 00   [19] 1734 	ld	-11 (ix),#0x00
   53B5 DD 7E EE      [19] 1735 	ld	a,-18 (ix)
   53B8 DD 86 F4      [19] 1736 	add	a, -12 (ix)
   53BB DD 77 F4      [19] 1737 	ld	-12 (ix),a
   53BE DD 7E EF      [19] 1738 	ld	a,-17 (ix)
   53C1 DD 8E F5      [19] 1739 	adc	a, -11 (ix)
   53C4 DD 77 F5      [19] 1740 	ld	-11 (ix),a
   53C7 DD 34 F4      [23] 1741 	inc	-12 (ix)
   53CA 20 03         [12] 1742 	jr	NZ,00629$
   53CC DD 34 F5      [23] 1743 	inc	-11 (ix)
   53CF                    1744 00629$:
   53CF DD 7E F4      [19] 1745 	ld	a,-12 (ix)
   53D2 DD 86 F8      [19] 1746 	add	a, -8 (ix)
   53D5 DD 77 F4      [19] 1747 	ld	-12 (ix),a
   53D8 DD 7E F5      [19] 1748 	ld	a,-11 (ix)
   53DB DD 8E F9      [19] 1749 	adc	a, -7 (ix)
   53DE DD 77 F5      [19] 1750 	ld	-11 (ix),a
   53E1 DD 6E F4      [19] 1751 	ld	l,-12 (ix)
   53E4 DD 66 F5      [19] 1752 	ld	h,-11 (ix)
   53E7 7E            [ 7] 1753 	ld	a,(hl)
   53E8 DD 77 D2      [19] 1754 	ld	-46 (ix),a
   53EB                    1755 00182$:
                           1756 ;src/Renderer.c:731: if(!(x%2)){
   53EB DD 7E C3      [19] 1757 	ld	a,-61 (ix)
   53EE E6 01         [ 7] 1758 	and	a, #0x01
   53F0 DD 77 F4      [19] 1759 	ld	-12 (ix),a
                           1760 ;src/Renderer.c:490: if (currentCellID & CELL_WALL_MASK)//Wall
   53F3 DD 7E D2      [19] 1761 	ld	a,-46 (ix)
   53F6 E6 80         [ 7] 1762 	and	a, #0x80
   53F8 DD 77 F3      [19] 1763 	ld	-13 (ix),a
                           1764 ;src/Renderer.c:510: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   53FB DD 7E CF      [19] 1765 	ld	a,-49 (ix)
   53FE DD 77 EC      [19] 1766 	ld	-20 (ix),a
   5401 DD 36 ED 00   [19] 1767 	ld	-19 (ix),#0x00
   5405 DD 7E C8      [19] 1768 	ld	a,-56 (ix)
   5408 DD 77 E1      [19] 1769 	ld	-31 (ix),a
                           1770 ;src/Renderer.c:731: if(!(x%2)){
   540B DD 7E F4      [19] 1771 	ld	a,-12 (ix)
   540E B7            [ 4] 1772 	or	a, a
   540F C2 07 55      [10] 1773 	jp	NZ,00195$
                           1774 ;src/Renderer.c:732: if ((lateralWallCounter == 0)||newCell)
   5412 DD 7E F0      [19] 1775 	ld	a,-16 (ix)
   5415 B7            [ 4] 1776 	or	a, a
   5416 28 07         [12] 1777 	jr	Z,00191$
   5418 DD 7E D1      [19] 1778 	ld	a,-47 (ix)
   541B B7            [ 4] 1779 	or	a, a
   541C CA 07 55      [10] 1780 	jp	Z,00195$
   541F                    1781 00191$:
                           1782 ;src/Renderer.c:734: if (currentCellID & CELL_WALL_MASK)//Wall
   541F DD 7E F3      [19] 1783 	ld	a,-13 (ix)
   5422 B7            [ 4] 1784 	or	a, a
   5423 28 2B         [12] 1785 	jr	Z,00189$
                           1786 ;src/Renderer.c:736: lateralWallCounter = 0;//(zHeight - xCellCount);
   5425 DD 36 F0 00   [19] 1787 	ld	-16 (ix),#0x00
                           1788 ;src/Renderer.c:737: lateralWallSlope = 0;
   5429 DD 36 C4 00   [19] 1789 	ld	-60 (ix),#0x00
                           1790 ;src/Renderer.c:738: xHeight = zHeight;
   542D DD 7E C8      [19] 1791 	ld	a,-56 (ix)
   5430 DD 77 D0      [19] 1792 	ld	-48 (ix),a
                           1793 ;src/Renderer.c:739: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   5433 DD 7E D2      [19] 1794 	ld	a,-46 (ix)
   5436 D6 80         [ 7] 1795 	sub	a, #0x80
   5438 20 04         [12] 1796 	jr	NZ,00269$
   543A 0E 0C         [ 7] 1797 	ld	c,#0x0C
   543C 18 02         [12] 1798 	jr	00270$
   543E                    1799 00269$:
   543E 0E 0E         [ 7] 1800 	ld	c,#0x0E
   5440                    1801 00270$:
   5440 DD 71 C6      [19] 1802 	ld	-58 (ix),c
                           1803 ;src/Renderer.c:740: lastCellWasWall = 1;
   5443 DD 36 EA 01   [19] 1804 	ld	-22 (ix),#0x01
                           1805 ;src/Renderer.c:741: lastWallId=currentCellID;
   5447 DD 7E D2      [19] 1806 	ld	a,-46 (ix)
   544A DD 77 CB      [19] 1807 	ld	-53 (ix),a
   544D C3 03 55      [10] 1808 	jp	00190$
   5450                    1809 00189$:
                           1810 ;src/Renderer.c:744: if(lateralWallCounter==0){//Lateral wall not finished
   5450 DD 7E F0      [19] 1811 	ld	a,-16 (ix)
   5453 B7            [ 4] 1812 	or	a, a
   5454 C2 03 55      [10] 1813 	jp	NZ,00190$
                           1814 ;src/Renderer.c:745: if (lastCellWasWall)
   5457 DD 7E EA      [19] 1815 	ld	a,-22 (ix)
   545A B7            [ 4] 1816 	or	a, a
   545B CA F3 54      [10] 1817 	jp	Z,00184$
                           1818 ;src/Renderer.c:748: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   545E DD 7E CE      [19] 1819 	ld	a,-50 (ix)
   5461 DD 96 C7      [19] 1820 	sub	a, -57 (ix)
   5464 87            [ 4] 1821 	add	a, a
   5465 3C            [ 4] 1822 	inc	a
                           1823 ;src/Renderer.c:749: lateralWallSlopeCounter = lateralWallSlope / 2;
   5466 DD 77 C4      [19] 1824 	ld	-60 (ix), a
   5469 CB 3F         [ 8] 1825 	srl	a
   546B DD 77 CD      [19] 1826 	ld	-51 (ix),a
                           1827 ;src/Renderer.c:750: lateralWallCounter = lateralWallSlope * zHeight;
   546E DD 5E C8      [19] 1828 	ld	e,-56 (ix)
   5471 DD 66 C4      [19] 1829 	ld	h,-60 (ix)
   5474 2E 00         [ 7] 1830 	ld	l, #0x00
   5476 55            [ 4] 1831 	ld	d, l
   5477 06 08         [ 7] 1832 	ld	b, #0x08
   5479                    1833 00632$:
   5479 29            [11] 1834 	add	hl,hl
   547A 30 01         [12] 1835 	jr	NC,00633$
   547C 19            [11] 1836 	add	hl,de
   547D                    1837 00633$:
   547D 10 FA         [13] 1838 	djnz	00632$
   547F DD 75 D8      [19] 1839 	ld	-40 (ix), l
   5482 7D            [ 4] 1840 	ld	a, l
                           1841 ;src/Renderer.c:751: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   5483 DD 77 CC      [19] 1842 	ld	-52 (ix), a
   5486 E6 FC         [ 7] 1843 	and	a, #0xFC
   5488 DD 77 D8      [19] 1844 	ld	-40 (ix), a
   548B CB C7         [ 8] 1845 	set	0, a
   548D DD 77 D8      [19] 1846 	ld	-40 (ix), a
   5490 CB 3F         [ 8] 1847 	srl	a
   5492 CB 3F         [ 8] 1848 	srl	a
   5494 DD 96 CF      [19] 1849 	sub	a, -49 (ix)
   5497 DD 77 F0      [19] 1850 	ld	-16 (ix),a
                           1851 ;src/Renderer.c:753: lastCellWasWall = 0;
   549A DD 36 EA 00   [19] 1852 	ld	-22 (ix),#0x00
                           1853 ;src/Renderer.c:754: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   549E DD 7E EC      [19] 1854 	ld	a,-20 (ix)
   54A1 DD 77 DA      [19] 1855 	ld	-38 (ix),a
   54A4 DD 7E ED      [19] 1856 	ld	a,-19 (ix)
   54A7 DD 77 DB      [19] 1857 	ld	-37 (ix),a
   54AA DD CB DA 26   [23] 1858 	sla	-38 (ix)
   54AE DD CB DB 16   [23] 1859 	rl	-37 (ix)
   54B2 DD 7E C4      [19] 1860 	ld	a,-60 (ix)
   54B5 DD 77 F6      [19] 1861 	ld	-10 (ix),a
   54B8 DD 36 F7 00   [19] 1862 	ld	-9 (ix),#0x00
   54BC DD 6E F6      [19] 1863 	ld	l,-10 (ix)
   54BF DD 66 F7      [19] 1864 	ld	h,-9 (ix)
   54C2 E5            [11] 1865 	push	hl
   54C3 DD 6E DA      [19] 1866 	ld	l,-38 (ix)
   54C6 DD 66 DB      [19] 1867 	ld	h,-37 (ix)
   54C9 E5            [11] 1868 	push	hl
   54CA CD BC 6C      [17] 1869 	call	__divsint
   54CD F1            [10] 1870 	pop	af
   54CE F1            [10] 1871 	pop	af
   54CF DD 74 DB      [19] 1872 	ld	-37 (ix),h
   54D2 DD 75 DA      [19] 1873 	ld	-38 (ix), l
   54D5 DD 75 D8      [19] 1874 	ld	-40 (ix), l
   54D8 DD 7E E1      [19] 1875 	ld	a,-31 (ix)
   54DB DD 96 D8      [19] 1876 	sub	a, -40 (ix)
   54DE DD 77 D0      [19] 1877 	ld	-48 (ix),a
                           1878 ;src/Renderer.c:755: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   54E1 DD 7E CB      [19] 1879 	ld	a,-53 (ix)
   54E4 D6 80         [ 7] 1880 	sub	a, #0x80
   54E6 20 04         [12] 1881 	jr	NZ,00271$
   54E8 0E 0F         [ 7] 1882 	ld	c,#0x0F
   54EA 18 02         [12] 1883 	jr	00272$
   54EC                    1884 00271$:
   54EC 0E 0D         [ 7] 1885 	ld	c,#0x0D
   54EE                    1886 00272$:
   54EE DD 71 C6      [19] 1887 	ld	-58 (ix),c
   54F1 18 10         [12] 1888 	jr	00190$
   54F3                    1889 00184$:
                           1890 ;src/Renderer.c:759: xHeight = 0;
   54F3 DD 36 D0 00   [19] 1891 	ld	-48 (ix),#0x00
                           1892 ;src/Renderer.c:760: lastCellWasWall = 0;
   54F7 DD 36 EA 00   [19] 1893 	ld	-22 (ix),#0x00
                           1894 ;src/Renderer.c:761: lateralWallSlope=0;
   54FB DD 36 C4 00   [19] 1895 	ld	-60 (ix),#0x00
                           1896 ;src/Renderer.c:762: lastWallId=0;
   54FF DD 36 CB 00   [19] 1897 	ld	-53 (ix),#0x00
   5503                    1898 00190$:
                           1899 ;src/Renderer.c:766: newCell=0;
   5503 DD 36 D1 00   [19] 1900 	ld	-47 (ix),#0x00
   5507                    1901 00195$:
                           1902 ;src/Renderer.c:769: if (lateralWallCounter > 0)
   5507 DD 7E F0      [19] 1903 	ld	a,-16 (ix)
   550A B7            [ 4] 1904 	or	a, a
   550B 28 1E         [12] 1905 	jr	Z,00201$
                           1906 ;src/Renderer.c:772: if (lateralWallSlope != 0)
   550D DD 7E C4      [19] 1907 	ld	a,-60 (ix)
   5510 B7            [ 4] 1908 	or	a, a
   5511 28 15         [12] 1909 	jr	Z,00199$
                           1910 ;src/Renderer.c:774: if (lateralWallSlopeCounter == lateralWallSlope)
   5513 DD 7E C4      [19] 1911 	ld	a,-60 (ix)
   5516 DD 96 CD      [19] 1912 	sub	a, -51 (ix)
   5519 20 0A         [12] 1913 	jr	NZ,00197$
                           1914 ;src/Renderer.c:776: lateralWallSlopeCounter = 0;
   551B DD 36 CD 00   [19] 1915 	ld	-51 (ix),#0x00
                           1916 ;src/Renderer.c:777: xHeight -= 2;
   551F DD 35 D0      [23] 1917 	dec	-48 (ix)
   5522 DD 35 D0      [23] 1918 	dec	-48 (ix)
   5525                    1919 00197$:
                           1920 ;src/Renderer.c:779: ++lateralWallSlopeCounter;
   5525 DD 34 CD      [23] 1921 	inc	-51 (ix)
   5528                    1922 00199$:
                           1923 ;src/Renderer.c:782: --lateralWallCounter;
   5528 DD 35 F0      [23] 1924 	dec	-16 (ix)
   552B                    1925 00201$:
                           1926 ;src/Renderer.c:549: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   552B DD 7E C8      [19] 1927 	ld	a,-56 (ix)
   552E DD 77 DA      [19] 1928 	ld	-38 (ix),a
   5531 DD 36 DB 00   [19] 1929 	ld	-37 (ix),#0x00
                           1930 ;src/Renderer.c:785: if (!(x%2))
   5535 DD 7E F4      [19] 1931 	ld	a,-12 (ix)
   5538 B7            [ 4] 1932 	or	a, a
   5539 20 68         [12] 1933 	jr	NZ,00210$
                           1934 ;src/Renderer.c:787: if(xHeight > 0){
   553B DD 7E D0      [19] 1935 	ld	a,-48 (ix)
   553E B7            [ 4] 1936 	or	a, a
   553F 28 62         [12] 1937 	jr	Z,00210$
                           1938 ;src/Renderer.c:788: draw_column_to_buffer_untextured(x/2, xHeight, color);
   5541 DD 7E C3      [19] 1939 	ld	a,-61 (ix)
   5544 CB 3F         [ 8] 1940 	srl	a
   5546 DD 77 F4      [19] 1941 	ld	-12 (ix),a
   5549 DD 66 C6      [19] 1942 	ld	h,-58 (ix)
   554C DD 6E D0      [19] 1943 	ld	l,-48 (ix)
   554F E5            [11] 1944 	push	hl
   5550 DD 7E F4      [19] 1945 	ld	a,-12 (ix)
   5553 F5            [11] 1946 	push	af
   5554 33            [ 6] 1947 	inc	sp
   5555 CD 92 4A      [17] 1948 	call	_draw_column_to_buffer_untextured
   5558 F1            [10] 1949 	pop	af
   5559 33            [ 6] 1950 	inc	sp
                           1951 ;src/Renderer.c:790: if(!(currentCellID&CELL_WALL_MASK)){
   555A DD 7E F3      [19] 1952 	ld	a,-13 (ix)
   555D B7            [ 4] 1953 	or	a, a
   555E 20 43         [12] 1954 	jr	NZ,00210$
                           1955 ;src/Renderer.c:791: if(currentCellID&CELL_ENEMY_MASK){
   5560 DD 7E D2      [19] 1956 	ld	a,-46 (ix)
   5563 E6 0F         [ 7] 1957 	and	a, #0x0F
   5565 28 3C         [12] 1958 	jr	Z,00210$
                           1959 ;src/Renderer.c:792: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   5567 3E 06         [ 7] 1960 	ld	a,#0x05+1
   5569 18 08         [12] 1961 	jr	00642$
   556B                    1962 00641$:
   556B DD CB EC 26   [23] 1963 	sla	-20 (ix)
   556F DD CB ED 16   [23] 1964 	rl	-19 (ix)
   5573                    1965 00642$:
   5573 3D            [ 4] 1966 	dec	a
   5574 20 F5         [12] 1967 	jr	NZ,00641$
   5576 DD 6E DA      [19] 1968 	ld	l,-38 (ix)
   5579 DD 66 DB      [19] 1969 	ld	h,-37 (ix)
   557C E5            [11] 1970 	push	hl
   557D DD 6E EC      [19] 1971 	ld	l,-20 (ix)
   5580 DD 66 ED      [19] 1972 	ld	h,-19 (ix)
   5583 E5            [11] 1973 	push	hl
   5584 CD BC 6C      [17] 1974 	call	__divsint
   5587 F1            [10] 1975 	pop	af
   5588 F1            [10] 1976 	pop	af
   5589 DD 74 ED      [19] 1977 	ld	-19 (ix),h
   558C DD 75 EC      [19] 1978 	ld	-20 (ix), l
   558F 45            [ 4] 1979 	ld	b, l
   5590 C5            [11] 1980 	push	bc
   5591 33            [ 6] 1981 	inc	sp
   5592 DD 66 D2      [19] 1982 	ld	h,-46 (ix)
   5595 DD 6E C8      [19] 1983 	ld	l,-56 (ix)
   5598 E5            [11] 1984 	push	hl
   5599 DD 7E F4      [19] 1985 	ld	a,-12 (ix)
   559C F5            [11] 1986 	push	af
   559D 33            [ 6] 1987 	inc	sp
   559E CD 0A 4B      [17] 1988 	call	_draw_column_to_buffer_enemy
   55A1 F1            [10] 1989 	pop	af
   55A2 F1            [10] 1990 	pop	af
                           1991 ;src/Renderer.c:794: else if(currentCellID&CELL_ITEM_MASK){
   55A3                    1992 00210$:
                           1993 ;src/Renderer.c:801: ++xCellCount;
   55A3 DD 34 CF      [23] 1994 	inc	-49 (ix)
                           1995 ;src/Renderer.c:722: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   55A6 DD 34 C3      [23] 1996 	inc	-61 (ix)
                           1997 ;src/Renderer.c:466: currentCellID = cells_in_view_array[lineStart + 1];
   55A9 2A 8B 4A      [16] 1998 	ld	hl,(_cells_in_view_array)
   55AC DD 75 F8      [19] 1999 	ld	-8 (ix),l
   55AF DD 74 F9      [19] 2000 	ld	-7 (ix),h
                           2001 ;src/Renderer.c:722: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   55B2 DD 7E C3      [19] 2002 	ld	a,-61 (ix)
   55B5 D6 50         [ 7] 2003 	sub	a, #0x50
   55B7 DA 98 53      [10] 2004 	jp	C,00256$
                           2005 ;src/Renderer.c:808: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   55BA DD 7E C2      [19] 2006 	ld	a,-62 (ix)
   55BD B7            [ 4] 2007 	or	a, a
   55BE 28 08         [12] 2008 	jr	Z,00273$
   55C0 DD 7E DF      [19] 2009 	ld	a,-33 (ix)
   55C3 DD 77 DF      [19] 2010 	ld	-33 (ix),a
   55C6 18 04         [12] 2011 	jr	00274$
   55C8                    2012 00273$:
   55C8 DD 36 DF 00   [19] 2013 	ld	-33 (ix),#0x00
   55CC                    2014 00274$:
   55CC DD 7E DF      [19] 2015 	ld	a,-33 (ix)
   55CF DD 77 DF      [19] 2016 	ld	-33 (ix),a
                           2017 ;src/Renderer.c:809: lateralWallSlope=0;
   55D2 DD 36 F0 00   [19] 2018 	ld	-16 (ix),#0x00
                           2019 ;src/Renderer.c:810: lateralWallSlopeCounter=0;
   55D6 DD 36 EE 00   [19] 2020 	ld	-18 (ix),#0x00
                           2021 ;src/Renderer.c:811: xHeight=0;
   55DA DD 36 EA 00   [19] 2022 	ld	-22 (ix),#0x00
                           2023 ;src/Renderer.c:813: lateralWallCounter = 0;
   55DE DD 36 F4 00   [19] 2024 	ld	-12 (ix),#0x00
                           2025 ;src/Renderer.c:576: lineEnd = lineStart + offsetDiff * 2 + 2;
   55E2 DD 7E CE      [19] 2026 	ld	a,-50 (ix)
   55E5 87            [ 4] 2027 	add	a, a
   55E6 DD 77 F3      [19] 2028 	ld	-13 (ix),a
   55E9 DD 7E C9      [19] 2029 	ld	a,-55 (ix)
   55EC DD 86 F3      [19] 2030 	add	a, -13 (ix)
                           2031 ;src/Renderer.c:814: lineEnd = lineStart + offsetDiff * 2 + 2;
   55EF DD 77 F3      [19] 2032 	ld	-13 (ix), a
   55F2 C6 02         [ 7] 2033 	add	a, #0x02
   55F4 DD 77 CA      [19] 2034 	ld	-54 (ix),a
                           2035 ;src/Renderer.c:816: newCell=1;
   55F7 DD 36 EC 01   [19] 2036 	ld	-20 (ix),#0x01
                           2037 ;src/Renderer.c:579: currentCellID = cells_in_view_array[lineEnd - 1];
   55FB DD 7E CA      [19] 2038 	ld	a,-54 (ix)
   55FE DD 77 F6      [19] 2039 	ld	-10 (ix),a
   5601 DD 36 F7 00   [19] 2040 	ld	-9 (ix),#0x00
                           2041 ;src/Renderer.c:817: currentCellID = cells_in_view_array[lineEnd - 1];
   5605 DD 7E F6      [19] 2042 	ld	a,-10 (ix)
   5608 C6 FF         [ 7] 2043 	add	a,#0xFF
   560A DD 77 DD      [19] 2044 	ld	-35 (ix),a
   560D DD 7E F7      [19] 2045 	ld	a,-9 (ix)
   5610 CE FF         [ 7] 2046 	adc	a,#0xFF
   5612 DD 77 DE      [19] 2047 	ld	-34 (ix),a
   5615 DD 7E F8      [19] 2048 	ld	a,-8 (ix)
   5618 DD 86 DD      [19] 2049 	add	a, -35 (ix)
   561B DD 77 DD      [19] 2050 	ld	-35 (ix),a
   561E DD 7E F9      [19] 2051 	ld	a,-7 (ix)
   5621 DD 8E DE      [19] 2052 	adc	a, -34 (ix)
   5624 DD 77 DE      [19] 2053 	ld	-34 (ix),a
   5627 DD 6E DD      [19] 2054 	ld	l,-35 (ix)
   562A DD 66 DE      [19] 2055 	ld	h,-34 (ix)
   562D 7E            [ 7] 2056 	ld	a,(hl)
   562E DD 77 DD      [19] 2057 	ld	-35 (ix),a
                           2058 ;src/Renderer.c:819: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   5631 DD 7E F8      [19] 2059 	ld	a,-8 (ix)
   5634 DD 86 CA      [19] 2060 	add	a, -54 (ix)
   5637 DD 77 D5      [19] 2061 	ld	-43 (ix),a
   563A DD 7E F9      [19] 2062 	ld	a,-7 (ix)
   563D CE 00         [ 7] 2063 	adc	a, #0x00
   563F DD 77 D6      [19] 2064 	ld	-42 (ix),a
   5642 DD 6E D5      [19] 2065 	ld	l,-43 (ix)
   5645 DD 66 D6      [19] 2066 	ld	h,-42 (ix)
   5648 7E            [ 7] 2067 	ld	a,(hl)
   5649 DD 77 D5      [19] 2068 	ld	-43 (ix),a
                           2069 ;src/Renderer.c:820: if(lastCellWasWall&CELL_WALL_MASK){
   564C DD CB D5 7E   [20] 2070 	bit	7, -43 (ix)
   5650 28 0C         [12] 2071 	jr	Z,00213$
                           2072 ;src/Renderer.c:821: lastWallId=lastCellWasWall;
   5652 DD 7E D5      [19] 2073 	ld	a,-43 (ix)
   5655 DD 77 D5      [19] 2074 	ld	-43 (ix),a
                           2075 ;src/Renderer.c:822: lastCellWasWall=1;
   5658 DD 36 D8 01   [19] 2076 	ld	-40 (ix),#0x01
   565C 18 08         [12] 2077 	jr	00356$
   565E                    2078 00213$:
                           2079 ;src/Renderer.c:825: lastCellWasWall=0;
   565E DD 36 D8 00   [19] 2080 	ld	-40 (ix),#0x00
                           2081 ;src/Renderer.c:826: lastWallId=CELLTYPE_FLOOR;
   5662 DD 36 D5 00   [19] 2082 	ld	-43 (ix),#0x00
                           2083 ;src/Renderer.c:829: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   5666                    2084 00356$:
   5666 DD 36 C7 00   [19] 2085 	ld	-57 (ix),#0x00
   566A DD 36 C3 9F   [19] 2086 	ld	-61 (ix),#0x9F
   566E                    2087 00258$:
                           2088 ;src/Renderer.c:832: if (xCellCount == zHeight)
   566E DD 7E C8      [19] 2089 	ld	a,-56 (ix)
   5671 DD 96 DF      [19] 2090 	sub	a, -33 (ix)
   5674 20 50         [12] 2091 	jr	NZ,00216$
                           2092 ;src/Renderer.c:834: ++xCell;
   5676 DD 34 C7      [23] 2093 	inc	-57 (ix)
                           2094 ;src/Renderer.c:835: xCellCount = 0;
   5679 DD 36 DF 00   [19] 2095 	ld	-33 (ix),#0x00
                           2096 ;src/Renderer.c:836: newCell=1;
   567D DD 36 EC 01   [19] 2097 	ld	-20 (ix),#0x01
                           2098 ;src/Renderer.c:837: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   5681 DD 7E C7      [19] 2099 	ld	a,-57 (ix)
   5684 DD 77 E4      [19] 2100 	ld	-28 (ix),a
   5687 DD 36 E5 00   [19] 2101 	ld	-27 (ix),#0x00
   568B DD 7E F6      [19] 2102 	ld	a,-10 (ix)
   568E DD 96 E4      [19] 2103 	sub	a, -28 (ix)
   5691 DD 77 E4      [19] 2104 	ld	-28 (ix),a
   5694 DD 7E F7      [19] 2105 	ld	a,-9 (ix)
   5697 DD 9E E5      [19] 2106 	sbc	a, -27 (ix)
   569A DD 77 E5      [19] 2107 	ld	-27 (ix),a
   569D DD 6E E4      [19] 2108 	ld	l,-28 (ix)
   56A0 DD 66 E5      [19] 2109 	ld	h,-27 (ix)
   56A3 2B            [ 6] 2110 	dec	hl
   56A4 DD 75 E4      [19] 2111 	ld	-28 (ix),l
   56A7 DD 74 E5      [19] 2112 	ld	-27 (ix),h
   56AA DD 7E F8      [19] 2113 	ld	a,-8 (ix)
   56AD DD 86 E4      [19] 2114 	add	a, -28 (ix)
   56B0 DD 77 E4      [19] 2115 	ld	-28 (ix),a
   56B3 DD 7E F9      [19] 2116 	ld	a,-7 (ix)
   56B6 DD 8E E5      [19] 2117 	adc	a, -27 (ix)
   56B9 DD 77 E5      [19] 2118 	ld	-27 (ix),a
   56BC DD 6E E4      [19] 2119 	ld	l,-28 (ix)
   56BF DD 66 E5      [19] 2120 	ld	h,-27 (ix)
   56C2 7E            [ 7] 2121 	ld	a,(hl)
   56C3 DD 77 DD      [19] 2122 	ld	-35 (ix),a
   56C6                    2123 00216$:
                           2124 ;src/Renderer.c:839: if(!(x%2)){
   56C6 DD 7E C3      [19] 2125 	ld	a,-61 (ix)
   56C9 E6 01         [ 7] 2126 	and	a, #0x01
   56CB DD 77 E4      [19] 2127 	ld	-28 (ix),a
                           2128 ;src/Renderer.c:490: if (currentCellID & CELL_WALL_MASK)//Wall
   56CE DD 7E DD      [19] 2129 	ld	a,-35 (ix)
   56D1 E6 80         [ 7] 2130 	and	a, #0x80
   56D3 DD 77 D7      [19] 2131 	ld	-41 (ix),a
                           2132 ;src/Renderer.c:510: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   56D6 DD 7E DF      [19] 2133 	ld	a,-33 (ix)
   56D9 DD 77 E8      [19] 2134 	ld	-24 (ix),a
   56DC DD 36 E9 00   [19] 2135 	ld	-23 (ix),#0x00
                           2136 ;src/Renderer.c:839: if(!(x%2)){
   56E0 DD 7E E4      [19] 2137 	ld	a,-28 (ix)
   56E3 B7            [ 4] 2138 	or	a, a
   56E4 C2 12 58      [10] 2139 	jp	NZ,00229$
                           2140 ;src/Renderer.c:840: if (lateralWallCounter == 0 || newCell)
   56E7 DD 7E F4      [19] 2141 	ld	a,-12 (ix)
   56EA B7            [ 4] 2142 	or	a, a
   56EB 28 07         [12] 2143 	jr	Z,00225$
   56ED DD 7E EC      [19] 2144 	ld	a,-20 (ix)
   56F0 B7            [ 4] 2145 	or	a, a
   56F1 CA 12 58      [10] 2146 	jp	Z,00229$
   56F4                    2147 00225$:
                           2148 ;src/Renderer.c:842: if ( currentCellID & CELL_WALL_MASK)//Wall
   56F4 DD 7E D7      [19] 2149 	ld	a,-41 (ix)
   56F7 B7            [ 4] 2150 	or	a, a
   56F8 28 32         [12] 2151 	jr	Z,00223$
                           2152 ;src/Renderer.c:844: lateralWallCounter = 0;
   56FA DD 36 F4 00   [19] 2153 	ld	-12 (ix),#0x00
                           2154 ;src/Renderer.c:845: lateralWallSlope = 0;
   56FE DD 36 F0 00   [19] 2155 	ld	-16 (ix),#0x00
                           2156 ;src/Renderer.c:846: xHeight = zHeight;
   5702 DD 7E C8      [19] 2157 	ld	a,-56 (ix)
   5705 DD 77 EA      [19] 2158 	ld	-22 (ix),a
                           2159 ;src/Renderer.c:847: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   5708 DD 7E DD      [19] 2160 	ld	a,-35 (ix)
   570B D6 80         [ 7] 2161 	sub	a, #0x80
   570D 20 06         [12] 2162 	jr	NZ,00275$
   570F DD 36 D9 0C   [19] 2163 	ld	-39 (ix),#0x0C
   5713 18 04         [12] 2164 	jr	00276$
   5715                    2165 00275$:
   5715 DD 36 D9 0E   [19] 2166 	ld	-39 (ix),#0x0E
   5719                    2167 00276$:
   5719 DD 7E D9      [19] 2168 	ld	a,-39 (ix)
   571C DD 77 C6      [19] 2169 	ld	-58 (ix),a
                           2170 ;src/Renderer.c:848: lastCellWasWall = 1;
   571F DD 36 D8 01   [19] 2171 	ld	-40 (ix),#0x01
                           2172 ;src/Renderer.c:849: lastWallId=currentCellID;
   5723 DD 7E DD      [19] 2173 	ld	a,-35 (ix)
   5726 DD 77 D5      [19] 2174 	ld	-43 (ix),a
   5729 C3 0E 58      [10] 2175 	jp	00224$
   572C                    2176 00223$:
                           2177 ;src/Renderer.c:851: else if(lateralWallCounter==0){
   572C DD 7E F4      [19] 2178 	ld	a,-12 (ix)
   572F B7            [ 4] 2179 	or	a, a
   5730 C2 0E 58      [10] 2180 	jp	NZ,00224$
                           2181 ;src/Renderer.c:852: if (lastCellWasWall)
   5733 DD 7E D8      [19] 2182 	ld	a,-40 (ix)
   5736 B7            [ 4] 2183 	or	a, a
   5737 CA FE 57      [10] 2184 	jp	Z,00218$
                           2185 ;src/Renderer.c:855: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   573A DD 7E CE      [19] 2186 	ld	a,-50 (ix)
   573D DD 96 C7      [19] 2187 	sub	a, -57 (ix)
   5740 87            [ 4] 2188 	add	a, a
   5741 3C            [ 4] 2189 	inc	a
                           2190 ;src/Renderer.c:856: lateralWallSlopeCounter = lateralWallSlope / 2;
   5742 DD 77 F0      [19] 2191 	ld	-16 (ix), a
   5745 CB 3F         [ 8] 2192 	srl	a
   5747 DD 77 EE      [19] 2193 	ld	-18 (ix),a
                           2194 ;src/Renderer.c:857: lateralWallCounter = lateralWallSlope * zHeight;
   574A DD 5E C8      [19] 2195 	ld	e,-56 (ix)
   574D DD 66 F0      [19] 2196 	ld	h,-16 (ix)
   5750 2E 00         [ 7] 2197 	ld	l, #0x00
   5752 55            [ 4] 2198 	ld	d, l
   5753 06 08         [ 7] 2199 	ld	b, #0x08
   5755                    2200 00648$:
   5755 29            [11] 2201 	add	hl,hl
   5756 30 01         [12] 2202 	jr	NC,00649$
   5758 19            [11] 2203 	add	hl,de
   5759                    2204 00649$:
   5759 10 FA         [13] 2205 	djnz	00648$
                           2206 ;src/Renderer.c:858: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   575B DD 75 D9      [19] 2207 	ld	-39 (ix), l
   575E DD 75 E6      [19] 2208 	ld	-26 (ix), l
   5761 DD 36 E7 00   [19] 2209 	ld	-25 (ix),#0x00
   5765 DD 7E D9      [19] 2210 	ld	a,-39 (ix)
   5768 E6 03         [ 7] 2211 	and	a, #0x03
   576A DD 77 D9      [19] 2212 	ld	-39 (ix), a
   576D DD 77 D3      [19] 2213 	ld	-45 (ix),a
   5770 DD 36 D4 00   [19] 2214 	ld	-44 (ix),#0x00
   5774 DD 7E E6      [19] 2215 	ld	a,-26 (ix)
   5777 DD 96 D3      [19] 2216 	sub	a, -45 (ix)
   577A DD 77 D3      [19] 2217 	ld	-45 (ix),a
   577D DD 7E E7      [19] 2218 	ld	a,-25 (ix)
   5780 DD 9E D4      [19] 2219 	sbc	a, -44 (ix)
   5783 DD 77 D4      [19] 2220 	ld	-44 (ix),a
   5786 DD 7E D3      [19] 2221 	ld	a,-45 (ix)
   5789 C6 01         [ 7] 2222 	add	a, #0x01
   578B DD 77 E6      [19] 2223 	ld	-26 (ix),a
   578E DD 7E D4      [19] 2224 	ld	a,-44 (ix)
   5791 CE 00         [ 7] 2225 	adc	a, #0x00
   5793 DD 77 E7      [19] 2226 	ld	-25 (ix),a
   5796 DD 7E E6      [19] 2227 	ld	a,-26 (ix)
   5799 DD 77 E2      [19] 2228 	ld	-30 (ix),a
   579C DD 7E E7      [19] 2229 	ld	a,-25 (ix)
   579F DD 77 E3      [19] 2230 	ld	-29 (ix),a
   57A2 DD CB E7 7E   [20] 2231 	bit	7, -25 (ix)
   57A6 28 10         [12] 2232 	jr	Z,00277$
   57A8 DD 7E D3      [19] 2233 	ld	a,-45 (ix)
   57AB C6 04         [ 7] 2234 	add	a, #0x04
   57AD DD 77 E2      [19] 2235 	ld	-30 (ix),a
   57B0 DD 7E D4      [19] 2236 	ld	a,-44 (ix)
   57B3 CE 00         [ 7] 2237 	adc	a, #0x00
   57B5 DD 77 E3      [19] 2238 	ld	-29 (ix),a
   57B8                    2239 00277$:
   57B8 DD 4E E2      [19] 2240 	ld	c,-30 (ix)
   57BB DD 46 E3      [19] 2241 	ld	b,-29 (ix)
   57BE CB 28         [ 8] 2242 	sra	b
   57C0 CB 19         [ 8] 2243 	rr	c
   57C2 CB 28         [ 8] 2244 	sra	b
   57C4 CB 19         [ 8] 2245 	rr	c
   57C6 DD 46 DF      [19] 2246 	ld	b,-33 (ix)
   57C9 79            [ 4] 2247 	ld	a,c
   57CA 90            [ 4] 2248 	sub	a, b
   57CB DD 77 F4      [19] 2249 	ld	-12 (ix),a
                           2250 ;src/Renderer.c:860: lastCellWasWall = 0;
   57CE DD 36 D8 00   [19] 2251 	ld	-40 (ix),#0x00
                           2252 ;src/Renderer.c:861: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   57D2 DD 6E E8      [19] 2253 	ld	l,-24 (ix)
   57D5 DD 66 E9      [19] 2254 	ld	h,-23 (ix)
   57D8 29            [11] 2255 	add	hl, hl
   57D9 DD 4E F0      [19] 2256 	ld	c,-16 (ix)
   57DC 06 00         [ 7] 2257 	ld	b,#0x00
   57DE C5            [11] 2258 	push	bc
   57DF E5            [11] 2259 	push	hl
   57E0 CD BC 6C      [17] 2260 	call	__divsint
   57E3 F1            [10] 2261 	pop	af
   57E4 F1            [10] 2262 	pop	af
   57E5 DD 7E E1      [19] 2263 	ld	a,-31 (ix)
   57E8 95            [ 4] 2264 	sub	a, l
   57E9 DD 77 EA      [19] 2265 	ld	-22 (ix),a
                           2266 ;src/Renderer.c:862: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   57EC DD 7E D5      [19] 2267 	ld	a,-43 (ix)
   57EF D6 80         [ 7] 2268 	sub	a, #0x80
   57F1 20 04         [12] 2269 	jr	NZ,00278$
   57F3 0E 0F         [ 7] 2270 	ld	c,#0x0F
   57F5 18 02         [12] 2271 	jr	00279$
   57F7                    2272 00278$:
   57F7 0E 0D         [ 7] 2273 	ld	c,#0x0D
   57F9                    2274 00279$:
   57F9 DD 71 C6      [19] 2275 	ld	-58 (ix),c
   57FC 18 10         [12] 2276 	jr	00224$
   57FE                    2277 00218$:
                           2278 ;src/Renderer.c:866: xHeight = 0;
   57FE DD 36 EA 00   [19] 2279 	ld	-22 (ix),#0x00
                           2280 ;src/Renderer.c:867: lastCellWasWall = 0;
   5802 DD 36 D8 00   [19] 2281 	ld	-40 (ix),#0x00
                           2282 ;src/Renderer.c:868: lateralWallSlope=0;
   5806 DD 36 F0 00   [19] 2283 	ld	-16 (ix),#0x00
                           2284 ;src/Renderer.c:869: lastWallId=0;
   580A DD 36 D5 00   [19] 2285 	ld	-43 (ix),#0x00
   580E                    2286 00224$:
                           2287 ;src/Renderer.c:872: newCell=0;
   580E DD 36 EC 00   [19] 2288 	ld	-20 (ix),#0x00
   5812                    2289 00229$:
                           2290 ;src/Renderer.c:877: if (lateralWallCounter > 0)
   5812 DD 7E F4      [19] 2291 	ld	a,-12 (ix)
   5815 B7            [ 4] 2292 	or	a, a
   5816 28 1E         [12] 2293 	jr	Z,00235$
                           2294 ;src/Renderer.c:880: if (lateralWallSlope != 0)
   5818 DD 7E F0      [19] 2295 	ld	a,-16 (ix)
   581B B7            [ 4] 2296 	or	a, a
   581C 28 15         [12] 2297 	jr	Z,00233$
                           2298 ;src/Renderer.c:882: if (lateralWallSlopeCounter == lateralWallSlope)
   581E DD 7E F0      [19] 2299 	ld	a,-16 (ix)
   5821 DD 96 EE      [19] 2300 	sub	a, -18 (ix)
   5824 20 0A         [12] 2301 	jr	NZ,00231$
                           2302 ;src/Renderer.c:884: lateralWallSlopeCounter = 0;
   5826 DD 36 EE 00   [19] 2303 	ld	-18 (ix),#0x00
                           2304 ;src/Renderer.c:885: xHeight -= 2;
   582A DD 35 EA      [23] 2305 	dec	-22 (ix)
   582D DD 35 EA      [23] 2306 	dec	-22 (ix)
   5830                    2307 00231$:
                           2308 ;src/Renderer.c:887: ++lateralWallSlopeCounter;
   5830 DD 34 EE      [23] 2309 	inc	-18 (ix)
   5833                    2310 00233$:
                           2311 ;src/Renderer.c:889: --lateralWallCounter;
   5833 DD 35 F4      [23] 2312 	dec	-12 (ix)
   5836                    2313 00235$:
                           2314 ;src/Renderer.c:893: if (!(x%2))
   5836 DD 7E E4      [19] 2315 	ld	a,-28 (ix)
   5839 B7            [ 4] 2316 	or	a, a
   583A 20 5B         [12] 2317 	jr	NZ,00244$
                           2318 ;src/Renderer.c:896: if(xHeight > 0){
   583C DD 7E EA      [19] 2319 	ld	a,-22 (ix)
   583F B7            [ 4] 2320 	or	a, a
   5840 28 55         [12] 2321 	jr	Z,00244$
                           2322 ;src/Renderer.c:898: draw_column_to_buffer_untextured(x/2, xHeight, color);
   5842 DD 46 C3      [19] 2323 	ld	b,-61 (ix)
   5845 CB 38         [ 8] 2324 	srl	b
   5847 C5            [11] 2325 	push	bc
   5848 DD 66 C6      [19] 2326 	ld	h,-58 (ix)
   584B DD 6E EA      [19] 2327 	ld	l,-22 (ix)
   584E E5            [11] 2328 	push	hl
   584F C5            [11] 2329 	push	bc
   5850 33            [ 6] 2330 	inc	sp
   5851 CD 92 4A      [17] 2331 	call	_draw_column_to_buffer_untextured
   5854 F1            [10] 2332 	pop	af
   5855 33            [ 6] 2333 	inc	sp
   5856 C1            [10] 2334 	pop	bc
                           2335 ;src/Renderer.c:900: if(!(currentCellID&CELL_WALL_MASK)){
   5857 DD 7E D7      [19] 2336 	ld	a,-41 (ix)
   585A B7            [ 4] 2337 	or	a, a
   585B 20 3A         [12] 2338 	jr	NZ,00244$
                           2339 ;src/Renderer.c:901: if(currentCellID&CELL_ENEMY_MASK){
   585D DD 7E DD      [19] 2340 	ld	a,-35 (ix)
   5860 E6 0F         [ 7] 2341 	and	a, #0x0F
   5862 28 33         [12] 2342 	jr	Z,00244$
                           2343 ;src/Renderer.c:902: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   5864 DD 7E DA      [19] 2344 	ld	a,-38 (ix)
   5867 DD 96 E8      [19] 2345 	sub	a, -24 (ix)
   586A 6F            [ 4] 2346 	ld	l,a
   586B DD 7E DB      [19] 2347 	ld	a,-37 (ix)
   586E DD 9E E9      [19] 2348 	sbc	a, -23 (ix)
   5871 67            [ 4] 2349 	ld	h,a
   5872 29            [11] 2350 	add	hl, hl
   5873 29            [11] 2351 	add	hl, hl
   5874 29            [11] 2352 	add	hl, hl
   5875 29            [11] 2353 	add	hl, hl
   5876 29            [11] 2354 	add	hl, hl
   5877 C5            [11] 2355 	push	bc
   5878 DD 5E DA      [19] 2356 	ld	e,-38 (ix)
   587B DD 56 DB      [19] 2357 	ld	d,-37 (ix)
   587E D5            [11] 2358 	push	de
   587F E5            [11] 2359 	push	hl
   5880 CD BC 6C      [17] 2360 	call	__divsint
   5883 F1            [10] 2361 	pop	af
   5884 F1            [10] 2362 	pop	af
   5885 55            [ 4] 2363 	ld	d,l
   5886 C1            [10] 2364 	pop	bc
   5887 D5            [11] 2365 	push	de
   5888 33            [ 6] 2366 	inc	sp
   5889 DD 66 DD      [19] 2367 	ld	h,-35 (ix)
   588C DD 6E C8      [19] 2368 	ld	l,-56 (ix)
   588F E5            [11] 2369 	push	hl
   5890 C5            [11] 2370 	push	bc
   5891 33            [ 6] 2371 	inc	sp
   5892 CD 0A 4B      [17] 2372 	call	_draw_column_to_buffer_enemy
   5895 F1            [10] 2373 	pop	af
   5896 F1            [10] 2374 	pop	af
                           2375 ;src/Renderer.c:904: else if(currentCellID&CELL_ITEM_MASK){
   5897                    2376 00244$:
                           2377 ;src/Renderer.c:910: ++xCellCount;
   5897 DD 34 DF      [23] 2378 	inc	-33 (ix)
                           2379 ;src/Renderer.c:829: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   589A DD 35 C3      [23] 2380 	dec	-61 (ix)
                           2381 ;src/Renderer.c:466: currentCellID = cells_in_view_array[lineStart + 1];
   589D 2A 8B 4A      [16] 2382 	ld	hl,(_cells_in_view_array)
   58A0 DD 75 F8      [19] 2383 	ld	-8 (ix),l
   58A3 DD 74 F9      [19] 2384 	ld	-7 (ix),h
                           2385 ;src/Renderer.c:829: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   58A6 DD 7E C3      [19] 2386 	ld	a,-61 (ix)
   58A9 D6 50         [ 7] 2387 	sub	a, #0x50
   58AB D2 6E 56      [10] 2388 	jp	NC,00258$
                           2389 ;src/Renderer.c:917: lineStart = lineStart + (offsetDiff * 2) + 3;
   58AE DD 7E F3      [19] 2390 	ld	a,-13 (ix)
   58B1 C6 03         [ 7] 2391 	add	a, #0x03
   58B3 DD 77 C9      [19] 2392 	ld	-55 (ix),a
                           2393 ;src/Renderer.c:918: zHeight += zHeight;
   58B6 DD CB C8 26   [23] 2394 	sla	-56 (ix)
                           2395 ;src/Renderer.c:919: offsetDiff = offsetDiff >> 1;
   58BA DD CB CE 3E   [23] 2396 	srl	-50 (ix)
                           2397 ;src/Renderer.c:921: }while(z);
   58BE DD 7E C2      [19] 2398 	ld	a,-62 (ix)
   58C1 B7            [ 4] 2399 	or	a, a
   58C2 C2 22 53      [10] 2400 	jp	NZ,00246$
   58C5                    2401 00260$:
   58C5 DD F9         [10] 2402 	ld	sp, ix
   58C7 DD E1         [14] 2403 	pop	ix
   58C9 C9            [10] 2404 	ret
                           2405 ;src/Renderer.c:929: void draw_minimap_to_buffer(){
                           2406 ;	---------------------------------
                           2407 ; Function draw_minimap_to_buffer
                           2408 ; ---------------------------------
   58CA                    2409 _draw_minimap_to_buffer::
   58CA DD E5         [15] 2410 	push	ix
   58CC DD 21 00 00   [14] 2411 	ld	ix,#0
   58D0 DD 39         [15] 2412 	add	ix,sp
   58D2 21 F5 FF      [10] 2413 	ld	hl,#-11
   58D5 39            [11] 2414 	add	hl,sp
   58D6 F9            [ 6] 2415 	ld	sp,hl
                           2416 ;src/Renderer.c:932: u8* ptr = MINIMAP_BUFFER;
   58D7 01 40 1C      [10] 2417 	ld	bc,#0x1C40
                           2418 ;src/Renderer.c:937: y=(PLAYER_position.y-MINIMAP_HEIGHT_HALF);
   58DA 3A AD 48      [13] 2419 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   58DD C6 F8         [ 7] 2420 	add	a,#0xF8
   58DF 5F            [ 4] 2421 	ld	e,a
                           2422 ;src/Renderer.c:939: for(j=0;j<MINIMAP_HEIGHT;++j){
   58E0 16 00         [ 7] 2423 	ld	d,#0x00
                           2424 ;src/Renderer.c:940: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   58E2                    2425 00135$:
   58E2 7B            [ 4] 2426 	ld	a,e
   58E3 07            [ 4] 2427 	rlca
   58E4 E6 01         [ 7] 2428 	and	a,#0x01
   58E6 DD 77 F9      [19] 2429 	ld	-7 (ix),a
   58E9 7B            [ 4] 2430 	ld	a,e
   58EA EE 80         [ 7] 2431 	xor	a, #0x80
   58EC D6 A0         [ 7] 2432 	sub	a, #0xA0
   58EE 3E 00         [ 7] 2433 	ld	a,#0x00
   58F0 17            [ 4] 2434 	rla
   58F1 DD 77 FA      [19] 2435 	ld	-6 (ix),a
   58F4 DD 36 F6 00   [19] 2436 	ld	-10 (ix),#0x00
   58F8                    2437 00120$:
                           2438 ;src/Renderer.c:941: x=(PLAYER_position.x-MINIMAP_WIDTH_HALF);
   58F8 3A AC 48      [13] 2439 	ld	a, (#_PLAYER_position + 0)
   58FB C6 F8         [ 7] 2440 	add	a,#0xF8
   58FD DD 77 FF      [19] 2441 	ld	-1 (ix),a
                           2442 ;src/Renderer.c:942: for(i=0;i<MINIMAP_WIDTH;++i){
   5900 DD 36 F5 00   [19] 2443 	ld	-11 (ix),#0x00
   5904                    2444 00118$:
                           2445 ;src/Renderer.c:945: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   5904 FD 21 10 00   [14] 2446 	ld	iy,#0x0010
   5908 FD 09         [15] 2447 	add	iy, bc
                           2448 ;src/Renderer.c:943: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
   590A DD CB FF 7E   [20] 2449 	bit	7, -1 (ix)
   590E 20 15         [12] 2450 	jr	NZ,00109$
   5910 DD 7E FF      [19] 2451 	ld	a,-1 (ix)
   5913 EE 80         [ 7] 2452 	xor	a, #0x80
   5915 D6 A0         [ 7] 2453 	sub	a, #0xA0
   5917 30 0C         [12] 2454 	jr	NC,00109$
   5919 DD 7E F9      [19] 2455 	ld	a,-7 (ix)
   591C B7            [ 4] 2456 	or	a, a
   591D 20 06         [12] 2457 	jr	NZ,00109$
   591F DD CB FA 46   [20] 2458 	bit	0,-6 (ix)
   5923 20 0D         [12] 2459 	jr	NZ,00110$
   5925                    2460 00109$:
                           2461 ;src/Renderer.c:944: *ptr=g_colors[MINIMAP_WALL_COLOR];
   5925 3A 79 4A      [13] 2462 	ld	a, (#(_g_colors + 0x0001) + 0)
   5928 02            [ 7] 2463 	ld	(bc),a
                           2464 ;src/Renderer.c:945: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   5929 3A 79 4A      [13] 2465 	ld	a, (#(_g_colors + 0x0001) + 0)
   592C FD 77 00      [19] 2466 	ld	0 (iy), a
   592F C3 DC 59      [10] 2467 	jp	00111$
   5932                    2468 00110$:
                           2469 ;src/Renderer.c:947: else if((x==PLAYER_position.x)&&(y==PLAYER_position.y)){
   5932 DD 7E FF      [19] 2470 	ld	a,-1 (ix)
   5935 DD 77 F7      [19] 2471 	ld	-9 (ix),a
   5938 DD 7E FF      [19] 2472 	ld	a,-1 (ix)
   593B 17            [ 4] 2473 	rla
   593C 9F            [ 4] 2474 	sbc	a, a
   593D DD 77 F8      [19] 2475 	ld	-8 (ix),a
   5940 3A AC 48      [13] 2476 	ld	a, (#_PLAYER_position + 0)
   5943 DD 77 FD      [19] 2477 	ld	-3 (ix),a
   5946 DD 36 FE 00   [19] 2478 	ld	-2 (ix),#0x00
   594A DD 73 FB      [19] 2479 	ld	-5 (ix),e
   594D 7B            [ 4] 2480 	ld	a,e
   594E 17            [ 4] 2481 	rla
   594F 9F            [ 4] 2482 	sbc	a, a
   5950 DD 77 FC      [19] 2483 	ld	-4 (ix),a
   5953 DD 7E F7      [19] 2484 	ld	a,-9 (ix)
   5956 DD 96 FD      [19] 2485 	sub	a, -3 (ix)
   5959 20 2E         [12] 2486 	jr	NZ,00106$
   595B DD 7E F8      [19] 2487 	ld	a,-8 (ix)
   595E DD 96 FE      [19] 2488 	sub	a, -2 (ix)
   5961 20 26         [12] 2489 	jr	NZ,00106$
   5963 3A AD 48      [13] 2490 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   5966 DD 77 FD      [19] 2491 	ld	-3 (ix),a
   5969 DD 36 FE 00   [19] 2492 	ld	-2 (ix),#0x00
   596D DD 7E FB      [19] 2493 	ld	a,-5 (ix)
   5970 DD 96 FD      [19] 2494 	sub	a, -3 (ix)
   5973 20 14         [12] 2495 	jr	NZ,00106$
   5975 DD 7E FC      [19] 2496 	ld	a,-4 (ix)
   5978 DD 96 FE      [19] 2497 	sub	a, -2 (ix)
   597B 20 0C         [12] 2498 	jr	NZ,00106$
                           2499 ;src/Renderer.c:948: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
   597D 3A 7C 4A      [13] 2500 	ld	a, (#(_g_colors + 0x0004) + 0)
   5980 02            [ 7] 2501 	ld	(bc),a
                           2502 ;src/Renderer.c:949: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
   5981 3A 7C 4A      [13] 2503 	ld	a, (#(_g_colors + 0x0004) + 0)
   5984 FD 77 00      [19] 2504 	ld	0 (iy), a
   5987 18 53         [12] 2505 	jr	00111$
   5989                    2506 00106$:
                           2507 ;src/Renderer.c:952: switch(*(u8*)(MAP_MEM+x+y*MAP_WIDTH)){
   5989 DD 7E F7      [19] 2508 	ld	a,-9 (ix)
   598C C6 40         [ 7] 2509 	add	a, #0x40
   598E DD 77 FD      [19] 2510 	ld	-3 (ix),a
   5991 DD 7E F8      [19] 2511 	ld	a,-8 (ix)
   5994 CE 00         [ 7] 2512 	adc	a, #0x00
   5996 DD 77 FE      [19] 2513 	ld	-2 (ix),a
   5999 DD 6E FB      [19] 2514 	ld	l,-5 (ix)
   599C DD 66 FC      [19] 2515 	ld	h,-4 (ix)
   599F 29            [11] 2516 	add	hl, hl
   59A0 29            [11] 2517 	add	hl, hl
   59A1 29            [11] 2518 	add	hl, hl
   59A2 29            [11] 2519 	add	hl, hl
   59A3 29            [11] 2520 	add	hl, hl
   59A4 DD 7E FD      [19] 2521 	ld	a,-3 (ix)
   59A7 85            [ 4] 2522 	add	a, l
   59A8 6F            [ 4] 2523 	ld	l,a
   59A9 DD 7E FE      [19] 2524 	ld	a,-2 (ix)
   59AC 8C            [ 4] 2525 	adc	a, h
   59AD 67            [ 4] 2526 	ld	h,a
   59AE 6E            [ 7] 2527 	ld	l,(hl)
   59AF 7D            [ 4] 2528 	ld	a,l
   59B0 B7            [ 4] 2529 	or	a, a
   59B1 28 07         [12] 2530 	jr	Z,00101$
   59B3 7D            [ 4] 2531 	ld	a,l
   59B4 D6 80         [ 7] 2532 	sub	a, #0x80
   59B6 28 0E         [12] 2533 	jr	Z,00102$
   59B8 18 18         [12] 2534 	jr	00103$
                           2535 ;src/Renderer.c:953: case CELLTYPE_FLOOR:{
   59BA                    2536 00101$:
                           2537 ;src/Renderer.c:954: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
   59BA 3A 7B 4A      [13] 2538 	ld	a, (#(_g_colors + 0x0003) + 0)
   59BD 02            [ 7] 2539 	ld	(bc),a
                           2540 ;src/Renderer.c:955: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
   59BE 3A 7B 4A      [13] 2541 	ld	a, (#(_g_colors + 0x0003) + 0)
   59C1 FD 77 00      [19] 2542 	ld	0 (iy), a
                           2543 ;src/Renderer.c:956: break;
   59C4 18 16         [12] 2544 	jr	00111$
                           2545 ;src/Renderer.c:958: case CELLTYPE_DOOR:{
   59C6                    2546 00102$:
                           2547 ;src/Renderer.c:959: *ptr=g_colors[MINIMAP_EXIT_COLOR];
   59C6 3A 80 4A      [13] 2548 	ld	a, (#(_g_colors + 0x0008) + 0)
   59C9 02            [ 7] 2549 	ld	(bc),a
                           2550 ;src/Renderer.c:960: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
   59CA 3A 80 4A      [13] 2551 	ld	a, (#(_g_colors + 0x0008) + 0)
   59CD FD 77 00      [19] 2552 	ld	0 (iy), a
                           2553 ;src/Renderer.c:961: break;
   59D0 18 0A         [12] 2554 	jr	00111$
                           2555 ;src/Renderer.c:963: default:{
   59D2                    2556 00103$:
                           2557 ;src/Renderer.c:964: *ptr=g_colors[MINIMAP_WALL_COLOR];
   59D2 3A 79 4A      [13] 2558 	ld	a, (#(_g_colors + 0x0001) + 0)
   59D5 02            [ 7] 2559 	ld	(bc),a
                           2560 ;src/Renderer.c:965: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   59D6 3A 79 4A      [13] 2561 	ld	a, (#(_g_colors + 0x0001) + 0)
   59D9 FD 77 00      [19] 2562 	ld	0 (iy), a
                           2563 ;src/Renderer.c:968: }
   59DC                    2564 00111$:
                           2565 ;src/Renderer.c:970: ++x;
   59DC DD 34 FF      [23] 2566 	inc	-1 (ix)
                           2567 ;src/Renderer.c:971: ++ptr;
   59DF 03            [ 6] 2568 	inc	bc
                           2569 ;src/Renderer.c:942: for(i=0;i<MINIMAP_WIDTH;++i){
   59E0 DD 34 F5      [23] 2570 	inc	-11 (ix)
   59E3 DD 7E F5      [19] 2571 	ld	a,-11 (ix)
   59E6 D6 10         [ 7] 2572 	sub	a, #0x10
   59E8 DA 04 59      [10] 2573 	jp	C,00118$
                           2574 ;src/Renderer.c:940: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   59EB DD 34 F6      [23] 2575 	inc	-10 (ix)
   59EE DD 7E F6      [19] 2576 	ld	a,-10 (ix)
   59F1 D6 04         [ 7] 2577 	sub	a, #0x04
   59F3 DA F8 58      [10] 2578 	jp	C,00120$
                           2579 ;src/Renderer.c:974: ++y;
   59F6 1C            [ 4] 2580 	inc	e
                           2581 ;src/Renderer.c:939: for(j=0;j<MINIMAP_HEIGHT;++j){
   59F7 14            [ 4] 2582 	inc	d
   59F8 7A            [ 4] 2583 	ld	a,d
   59F9 D6 10         [ 7] 2584 	sub	a, #0x10
   59FB DA E2 58      [10] 2585 	jp	C,00135$
   59FE DD F9         [10] 2586 	ld	sp, ix
   5A00 DD E1         [14] 2587 	pop	ix
   5A02 C9            [10] 2588 	ret
                           2589 	.area _CODE
                           2590 	.area _INITIALIZER
                           2591 	.area _CABS (ABS)
