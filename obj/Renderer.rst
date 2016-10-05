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
                             12 	.globl _calculate_cells_in_view
                             13 	.globl _cpct_memset
                             14 	.globl _offsets_cells_in_view
                             15 	.globl _cells_in_view_array
                             16 	.globl _pixelMask
                             17 	.globl _g_colors
                             18 	.globl _g_palette
                             19 	.globl _render_draw_to_buffer
                             20 	.globl _draw_minimap_to_buffer
                             21 ;--------------------------------------------------------
                             22 ; special function registers
                             23 ;--------------------------------------------------------
                             24 ;--------------------------------------------------------
                             25 ; ram data
                             26 ;--------------------------------------------------------
                             27 	.area _DATA
                             28 ;--------------------------------------------------------
                             29 ; ram data
                             30 ;--------------------------------------------------------
                             31 	.area _INITIALIZED
                             32 ;--------------------------------------------------------
                             33 ; absolute external ram data
                             34 ;--------------------------------------------------------
                             35 	.area _DABS (ABS)
                             36 ;--------------------------------------------------------
                             37 ; global & static initialisations
                             38 ;--------------------------------------------------------
                             39 	.area _HOME
                             40 	.area _GSINIT
                             41 	.area _GSFINAL
                             42 	.area _GSINIT
                             43 ;--------------------------------------------------------
                             44 ; Home
                             45 ;--------------------------------------------------------
                             46 	.area _HOME
                             47 	.area _HOME
                             48 ;--------------------------------------------------------
                             49 ; code
                             50 ;--------------------------------------------------------
                             51 	.area _CODE
                             52 ;src/Renderer.c:205: void calculate_cells_in_view(){
                             53 ;	---------------------------------
                             54 ; Function calculate_cells_in_view
                             55 ; ---------------------------------
   4834                      56 _calculate_cells_in_view::
   4834 DD E5         [15]   57 	push	ix
   4836 DD 21 00 00   [14]   58 	ld	ix,#0
   483A DD 39         [15]   59 	add	ix,sp
   483C 21 F2 FF      [10]   60 	ld	hl,#-14
   483F 39            [11]   61 	add	hl,sp
   4840 F9            [ 6]   62 	ld	sp,hl
                             63 ;src/Renderer.c:207: u8 offset=0, n=0, j, i;
   4841 DD 36 FA 00   [19]   64 	ld	-6 (ix),#0x00
   4845 DD 36 F9 00   [19]   65 	ld	-7 (ix),#0x00
                             66 ;src/Renderer.c:210: if(PLAYER_direction.y!=0){
   4849 3A 2A 48      [13]   67 	ld	a,(#_PLAYER_direction + 1)
   484C DD 77 FD      [19]   68 	ld	-3 (ix), a
   484F B7            [ 4]   69 	or	a, a
   4850 28 32         [12]   70 	jr	Z,00102$
                             71 ;src/Renderer.c:211: vert=1;
   4852 DD 36 F2 01   [19]   72 	ld	-14 (ix),#0x01
                             73 ;src/Renderer.c:212: dy=PLAYER_direction.y;
   4856 DD 4E FD      [19]   74 	ld	c,-3 (ix)
   4859 DD 71 F4      [19]   75 	ld	-12 (ix),c
                             76 ;src/Renderer.c:213: dx=-PLAYER_direction.y;
   485C AF            [ 4]   77 	xor	a, a
   485D DD 96 FD      [19]   78 	sub	a, -3 (ix)
   4860 DD 77 F5      [19]   79 	ld	-11 (ix), a
                             80 ;src/Renderer.c:215: x0 = PLAYER_position.x-(17*dx);
   4863 21 27 48      [10]   81 	ld	hl,#_PLAYER_position+0
   4866 4E            [ 7]   82 	ld	c,(hl)
   4867 DD 6E F5      [19]   83 	ld	l,-11 (ix)
   486A 5D            [ 4]   84 	ld	e,l
   486B 29            [11]   85 	add	hl, hl
   486C 29            [11]   86 	add	hl, hl
   486D 29            [11]   87 	add	hl, hl
   486E 29            [11]   88 	add	hl, hl
   486F 19            [11]   89 	add	hl, de
   4870 79            [ 4]   90 	ld	a,c
   4871 95            [ 4]   91 	sub	a, l
   4872 DD 77 F6      [19]   92 	ld	-10 (ix),a
                             93 ;src/Renderer.c:216: y0 = PLAYER_position.y+(6*dy);
   4875 21 28 48      [10]   94 	ld	hl,#_PLAYER_position+1
   4878 4E            [ 7]   95 	ld	c,(hl)
   4879 DD 6E F4      [19]   96 	ld	l,-12 (ix)
   487C 5D            [ 4]   97 	ld	e,l
   487D 29            [11]   98 	add	hl, hl
   487E 19            [11]   99 	add	hl, de
   487F 29            [11]  100 	add	hl, hl
   4880 09            [11]  101 	add	hl, bc
   4881 4D            [ 4]  102 	ld	c,l
   4882 18 34         [12]  103 	jr	00103$
   4884                     104 00102$:
                            105 ;src/Renderer.c:219: vert=0;
   4884 DD 36 F2 00   [19]  106 	ld	-14 (ix),#0x00
                            107 ;src/Renderer.c:220: dy=PLAYER_direction.x;
   4888 3A 29 48      [13]  108 	ld	a,(#_PLAYER_direction + 0)
   488B DD 77 FD      [19]  109 	ld	-3 (ix), a
   488E DD 77 F4      [19]  110 	ld	-12 (ix),a
                            111 ;src/Renderer.c:221: dx=PLAYER_direction.x;
   4891 DD 7E FD      [19]  112 	ld	a,-3 (ix)
   4894 DD 77 F5      [19]  113 	ld	-11 (ix),a
                            114 ;src/Renderer.c:223: y0 = PLAYER_position.y-(17*dy);
   4897 21 28 48      [10]  115 	ld	hl, #_PLAYER_position + 1
   489A 4E            [ 7]  116 	ld	c,(hl)
   489B DD 6E F4      [19]  117 	ld	l,-12 (ix)
   489E 5D            [ 4]  118 	ld	e,l
   489F 29            [11]  119 	add	hl, hl
   48A0 29            [11]  120 	add	hl, hl
   48A1 29            [11]  121 	add	hl, hl
   48A2 29            [11]  122 	add	hl, hl
   48A3 19            [11]  123 	add	hl, de
   48A4 79            [ 4]  124 	ld	a,c
   48A5 95            [ 4]  125 	sub	a, l
   48A6 4F            [ 4]  126 	ld	c,a
                            127 ;src/Renderer.c:224: x0 = PLAYER_position.x+(6*dx);
   48A7 21 27 48      [10]  128 	ld	hl, #_PLAYER_position + 0
   48AA 46            [ 7]  129 	ld	b,(hl)
   48AB DD 7E FD      [19]  130 	ld	a,-3 (ix)
   48AE 5F            [ 4]  131 	ld	e,a
   48AF 87            [ 4]  132 	add	a, a
   48B0 83            [ 4]  133 	add	a, e
   48B1 87            [ 4]  134 	add	a, a
   48B2 5F            [ 4]  135 	ld	e,a
   48B3 68            [ 4]  136 	ld	l,b
   48B4 19            [11]  137 	add	hl, de
   48B5 DD 75 F6      [19]  138 	ld	-10 (ix),l
   48B8                     139 00103$:
                            140 ;src/Renderer.c:228: x=x0;
   48B8 DD 5E F6      [19]  141 	ld	e,-10 (ix)
                            142 ;src/Renderer.c:229: y=y0;
   48BB DD 71 F3      [19]  143 	ld	-13 (ix),c
                            144 ;src/Renderer.c:231: for(j=0;j<6;++j){
   48BE DD 7E F5      [19]  145 	ld	a,-11 (ix)
   48C1 07            [ 4]  146 	rlca
   48C2 E6 01         [ 7]  147 	and	a,#0x01
   48C4 DD 77 FD      [19]  148 	ld	-3 (ix),a
   48C7 DD 7E F4      [19]  149 	ld	a,-12 (ix)
   48CA 07            [ 4]  150 	rlca
   48CB E6 01         [ 7]  151 	and	a,#0x01
   48CD DD 77 FB      [19]  152 	ld	-5 (ix),a
   48D0 DD 36 F8 00   [19]  153 	ld	-8 (ix),#0x00
                            154 ;src/Renderer.c:233: for(i=offset;i<35-offset;++i){
   48D4                     155 00138$:
   48D4 DD 7E F9      [19]  156 	ld	a,-7 (ix)
   48D7 DD 77 FC      [19]  157 	ld	-4 (ix),a
   48DA DD 7E FA      [19]  158 	ld	a,-6 (ix)
   48DD DD 77 F7      [19]  159 	ld	-9 (ix),a
   48E0                     160 00125$:
   48E0 DD 6E FA      [19]  161 	ld	l,-6 (ix)
   48E3 26 00         [ 7]  162 	ld	h,#0x00
   48E5 3E 23         [ 7]  163 	ld	a,#0x23
   48E7 95            [ 4]  164 	sub	a, l
   48E8 6F            [ 4]  165 	ld	l,a
   48E9 3E 00         [ 7]  166 	ld	a,#0x00
   48EB 9C            [ 4]  167 	sbc	a, h
   48EC 67            [ 4]  168 	ld	h,a
   48ED DD 7E F7      [19]  169 	ld	a, -9 (ix)
   48F0 16 00         [ 7]  170 	ld	d, #0x00
   48F2 95            [ 4]  171 	sub	a, l
   48F3 7A            [ 4]  172 	ld	a,d
   48F4 9C            [ 4]  173 	sbc	a, h
   48F5 E2 FA 48      [10]  174 	jp	PO, 00181$
   48F8 EE 80         [ 7]  175 	xor	a, #0x80
   48FA                     176 00181$:
   48FA F2 79 49      [10]  177 	jp	P,00143$
                            178 ;src/Renderer.c:236: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   48FD 2A 05 4A      [16]  179 	ld	hl,(_cells_in_view_array)
   4900 7D            [ 4]  180 	ld	a,l
   4901 DD 86 FC      [19]  181 	add	a, -4 (ix)
   4904 DD 77 FE      [19]  182 	ld	-2 (ix),a
   4907 7C            [ 4]  183 	ld	a,h
   4908 CE 00         [ 7]  184 	adc	a, #0x00
   490A DD 77 FF      [19]  185 	ld	-1 (ix),a
                            186 ;src/Renderer.c:235: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
   490D CB 7B         [ 8]  187 	bit	7, e
   490F 20 41         [12]  188 	jr	NZ,00105$
   4911 7B            [ 4]  189 	ld	a,e
   4912 EE 80         [ 7]  190 	xor	a, #0x80
   4914 D6 A0         [ 7]  191 	sub	a, #0xA0
   4916 30 3A         [12]  192 	jr	NC,00105$
   4918 DD CB F3 7E   [20]  193 	bit	7, -13 (ix)
   491C 20 34         [12]  194 	jr	NZ,00105$
   491E DD 7E F3      [19]  195 	ld	a,-13 (ix)
   4921 EE 80         [ 7]  196 	xor	a, #0x80
   4923 D6 A0         [ 7]  197 	sub	a, #0xA0
   4925 30 2B         [12]  198 	jr	NC,00105$
                            199 ;src/Renderer.c:236: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   4927 7B            [ 4]  200 	ld	a,e
   4928 57            [ 4]  201 	ld	d,a
   4929 17            [ 4]  202 	rla
   492A 9F            [ 4]  203 	sbc	a, a
   492B 6F            [ 4]  204 	ld	l,a
   492C 7A            [ 4]  205 	ld	a,d
   492D C6 40         [ 7]  206 	add	a, #0x40
   492F 47            [ 4]  207 	ld	b,a
   4930 7D            [ 4]  208 	ld	a,l
   4931 CE 00         [ 7]  209 	adc	a, #0x00
   4933 57            [ 4]  210 	ld	d,a
   4934 DD 6E F3      [19]  211 	ld	l,-13 (ix)
   4937 DD 7E F3      [19]  212 	ld	a,-13 (ix)
   493A 17            [ 4]  213 	rla
   493B 9F            [ 4]  214 	sbc	a, a
   493C 67            [ 4]  215 	ld	h,a
   493D 29            [11]  216 	add	hl, hl
   493E 29            [11]  217 	add	hl, hl
   493F 29            [11]  218 	add	hl, hl
   4940 29            [11]  219 	add	hl, hl
   4941 29            [11]  220 	add	hl, hl
   4942 78            [ 4]  221 	ld	a,b
   4943 85            [ 4]  222 	add	a, l
   4944 6F            [ 4]  223 	ld	l,a
   4945 7A            [ 4]  224 	ld	a,d
   4946 8C            [ 4]  225 	adc	a, h
   4947 67            [ 4]  226 	ld	h,a
   4948 46            [ 7]  227 	ld	b,(hl)
   4949 DD 6E FE      [19]  228 	ld	l,-2 (ix)
   494C DD 66 FF      [19]  229 	ld	h,-1 (ix)
   494F 70            [ 7]  230 	ld	(hl),b
   4950 18 08         [12]  231 	jr	00106$
   4952                     232 00105$:
                            233 ;src/Renderer.c:239: cells_in_view_array[n]=1;
   4952 DD 6E FE      [19]  234 	ld	l,-2 (ix)
   4955 DD 66 FF      [19]  235 	ld	h,-1 (ix)
   4958 36 01         [10]  236 	ld	(hl),#0x01
   495A                     237 00106$:
                            238 ;src/Renderer.c:243: if(vert){
   495A DD 7E F2      [19]  239 	ld	a,-14 (ix)
   495D B7            [ 4]  240 	or	a, a
   495E 28 07         [12]  241 	jr	Z,00111$
                            242 ;src/Renderer.c:244: x+=dx;
   4960 7B            [ 4]  243 	ld	a,e
   4961 DD 86 F5      [19]  244 	add	a, -11 (ix)
   4964 5F            [ 4]  245 	ld	e,a
   4965 18 09         [12]  246 	jr	00112$
   4967                     247 00111$:
                            248 ;src/Renderer.c:247: y+=dy;
   4967 DD 7E F3      [19]  249 	ld	a,-13 (ix)
   496A DD 86 F4      [19]  250 	add	a, -12 (ix)
   496D DD 77 F3      [19]  251 	ld	-13 (ix),a
   4970                     252 00112$:
                            253 ;src/Renderer.c:249: ++n;
   4970 DD 34 FC      [23]  254 	inc	-4 (ix)
                            255 ;src/Renderer.c:233: for(i=offset;i<35-offset;++i){
   4973 DD 34 F7      [23]  256 	inc	-9 (ix)
   4976 C3 E0 48      [10]  257 	jp	00125$
   4979                     258 00143$:
   4979 DD 7E FC      [19]  259 	ld	a,-4 (ix)
   497C DD 77 F9      [19]  260 	ld	-7 (ix),a
                            261 ;src/Renderer.c:251: offset=offsets_cells_in_view[j];
   497F 3E 07         [ 7]  262 	ld	a,#<(_offsets_cells_in_view)
   4981 DD 86 F8      [19]  263 	add	a, -8 (ix)
   4984 6F            [ 4]  264 	ld	l,a
   4985 3E 4A         [ 7]  265 	ld	a,#>(_offsets_cells_in_view)
   4987 CE 00         [ 7]  266 	adc	a, #0x00
   4989 67            [ 4]  267 	ld	h,a
   498A 7E            [ 7]  268 	ld	a,(hl)
                            269 ;src/Renderer.c:255: if(dx<0) x=x0-offset;
   498B DD 77 FA      [19]  270 	ld	-6 (ix), a
   498E DD 77 FE      [19]  271 	ld	-2 (ix),a
                            272 ;src/Renderer.c:253: if(vert){
   4991 DD 7E F2      [19]  273 	ld	a,-14 (ix)
   4994 B7            [ 4]  274 	or	a, a
   4995 28 21         [12]  275 	jr	Z,00121$
                            276 ;src/Renderer.c:254: y-=dy;
   4997 DD 7E F3      [19]  277 	ld	a,-13 (ix)
   499A DD 96 F4      [19]  278 	sub	a, -12 (ix)
   499D DD 77 F3      [19]  279 	ld	-13 (ix),a
                            280 ;src/Renderer.c:255: if(dx<0) x=x0-offset;
   49A0 DD 7E FD      [19]  281 	ld	a,-3 (ix)
   49A3 B7            [ 4]  282 	or	a, a
   49A4 28 09         [12]  283 	jr	Z,00115$
   49A6 DD 7E F6      [19]  284 	ld	a,-10 (ix)
   49A9 DD 96 FE      [19]  285 	sub	a, -2 (ix)
   49AC 5F            [ 4]  286 	ld	e,a
   49AD 18 24         [12]  287 	jr	00128$
   49AF                     288 00115$:
                            289 ;src/Renderer.c:256: else x=x0+offset;
   49AF DD 7E F6      [19]  290 	ld	a,-10 (ix)
   49B2 DD 86 FE      [19]  291 	add	a, -2 (ix)
   49B5 5F            [ 4]  292 	ld	e,a
   49B6 18 1B         [12]  293 	jr	00128$
   49B8                     294 00121$:
                            295 ;src/Renderer.c:260: x-=dx;
   49B8 7B            [ 4]  296 	ld	a,e
   49B9 DD 96 F5      [19]  297 	sub	a, -11 (ix)
   49BC 5F            [ 4]  298 	ld	e,a
                            299 ;src/Renderer.c:261: if(dy<0) y=y0-offset;
   49BD DD 7E FB      [19]  300 	ld	a,-5 (ix)
   49C0 B7            [ 4]  301 	or	a, a
   49C1 28 09         [12]  302 	jr	Z,00118$
   49C3 79            [ 4]  303 	ld	a,c
   49C4 DD 96 FE      [19]  304 	sub	a, -2 (ix)
   49C7 DD 77 F3      [19]  305 	ld	-13 (ix),a
   49CA 18 07         [12]  306 	jr	00128$
   49CC                     307 00118$:
                            308 ;src/Renderer.c:262: else y=y0+offset;
   49CC 79            [ 4]  309 	ld	a,c
   49CD DD 86 FE      [19]  310 	add	a, -2 (ix)
   49D0 DD 77 F3      [19]  311 	ld	-13 (ix),a
   49D3                     312 00128$:
                            313 ;src/Renderer.c:231: for(j=0;j<6;++j){
   49D3 DD 34 F8      [23]  314 	inc	-8 (ix)
   49D6 DD 7E F8      [19]  315 	ld	a,-8 (ix)
   49D9 D6 06         [ 7]  316 	sub	a, #0x06
   49DB DA D4 48      [10]  317 	jp	C,00138$
   49DE DD F9         [10]  318 	ld	sp, ix
   49E0 DD E1         [14]  319 	pop	ix
   49E2 C9            [10]  320 	ret
   49E3                     321 _g_palette:
   49E3 08                  322 	.db #0x08	; 8
   49E4 00                  323 	.db #0x00	; 0
   49E5 0D                  324 	.db #0x0D	; 13
   49E6 1A                  325 	.db #0x1A	; 26
   49E7 06                  326 	.db #0x06	; 6
   49E8 01                  327 	.db #0x01	; 1
   49E9 09                  328 	.db #0x09	; 9
   49EA 03                  329 	.db #0x03	; 3
   49EB 18                  330 	.db #0x18	; 24
   49EC 12                  331 	.db #0x12	; 18
   49ED 05                  332 	.db #0x05	; 5
   49EE 0E                  333 	.db #0x0E	; 14
   49EF 0F                  334 	.db #0x0F	; 15
   49F0 10                  335 	.db #0x10	; 16
   49F1 11                  336 	.db #0x11	; 17
   49F2 13                  337 	.db #0x13	; 19
   49F3                     338 _g_colors:
   49F3 00                  339 	.db #0x00	; 0
   49F4 C0                  340 	.db #0xC0	; 192
   49F5 0C                  341 	.db #0x0C	; 12
   49F6 CC                  342 	.db #0xCC	; 204
   49F7 30                  343 	.db #0x30	; 48	'0'
   49F8 F0                  344 	.db #0xF0	; 240
   49F9 3C                  345 	.db #0x3C	; 60
   49FA FC                  346 	.db #0xFC	; 252
   49FB 03                  347 	.db #0x03	; 3
   49FC C3                  348 	.db #0xC3	; 195
   49FD 0F                  349 	.db #0x0F	; 15
   49FE CF                  350 	.db #0xCF	; 207
   49FF 33                  351 	.db #0x33	; 51	'3'
   4A00 F3                  352 	.db #0xF3	; 243
   4A01 3F                  353 	.db #0x3F	; 63
   4A02 FF                  354 	.db #0xFF	; 255
   4A03                     355 _pixelMask:
   4A03 AA                  356 	.db #0xAA	; 170
   4A04 55                  357 	.db #0x55	; 85	'U'
   4A05                     358 _cells_in_view_array:
   4A05 E0 38               359 	.dw #0x38E0
   4A07                     360 _offsets_cells_in_view:
   4A07 08                  361 	.db #0x08	; 8
   4A08 0C                  362 	.db #0x0C	; 12
   4A09 0E                  363 	.db #0x0E	; 14
   4A0A 0F                  364 	.db #0x0F	; 15
   4A0B 10                  365 	.db #0x10	; 16
                            366 ;src/Renderer.c:268: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
                            367 ;	---------------------------------
                            368 ; Function draw_column_to_buffer
                            369 ; ---------------------------------
   4A0C                     370 _draw_column_to_buffer::
   4A0C DD E5         [15]  371 	push	ix
   4A0E DD 21 00 00   [14]  372 	ld	ix,#0
   4A12 DD 39         [15]  373 	add	ix,sp
   4A14 21 EF FF      [10]  374 	ld	hl,#-17
   4A17 39            [11]  375 	add	hl,sp
   4A18 F9            [ 6]  376 	ld	sp,hl
                            377 ;src/Renderer.c:269: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   4A19 DD 7E 04      [19]  378 	ld	a,4 (ix)
   4A1C CB 3F         [ 8]  379 	srl	a
   4A1E C6 40         [ 7]  380 	add	a, #0x40
   4A20 DD 77 FA      [19]  381 	ld	-6 (ix),a
   4A23 3E 00         [ 7]  382 	ld	a,#0x00
   4A25 CE 29         [ 7]  383 	adc	a, #0x29
   4A27 DD 77 FB      [19]  384 	ld	-5 (ix),a
                            385 ;src/Renderer.c:271: u8 w_color, start=0,end=SCREEN_TEXTURE_HEIGHT;
   4A2A DD 36 F8 00   [19]  386 	ld	-8 (ix),#0x00
   4A2E DD 36 F9 64   [19]  387 	ld	-7 (ix),#0x64
                            388 ;src/Renderer.c:272: u8 pixMask = pixelMask[column&1];
   4A32 01 03 4A      [10]  389 	ld	bc,#_pixelMask+0
   4A35 DD 7E 04      [19]  390 	ld	a,4 (ix)
   4A38 E6 01         [ 7]  391 	and	a, #0x01
   4A3A 6F            [ 4]  392 	ld	l, a
   4A3B 26 00         [ 7]  393 	ld	h,#0x00
   4A3D 09            [11]  394 	add	hl,bc
   4A3E 7E            [ 7]  395 	ld	a,(hl)
   4A3F DD 77 F7      [19]  396 	ld	-9 (ix),a
                            397 ;src/Renderer.c:279: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
   4A42 DD 7E 06      [19]  398 	ld	a, 6 (ix)
   4A45 87            [ 4]  399 	add	a, a
   4A46 87            [ 4]  400 	add	a, a
   4A47 47            [ 4]  401 	ld	b,a
   4A48 0E 00         [ 7]  402 	ld	c,#0x00
   4A4A 21 40 04      [10]  403 	ld	hl,#0x0440
   4A4D 09            [11]  404 	add	hl,bc
   4A4E 4D            [ 4]  405 	ld	c,l
   4A4F 44            [ 4]  406 	ld	b,h
   4A50 DD 6E 07      [19]  407 	ld	l,7 (ix)
   4A53 26 00         [ 7]  408 	ld	h,#0x00
   4A55 29            [11]  409 	add	hl, hl
   4A56 29            [11]  410 	add	hl, hl
   4A57 29            [11]  411 	add	hl, hl
   4A58 29            [11]  412 	add	hl, hl
   4A59 29            [11]  413 	add	hl, hl
   4A5A 09            [11]  414 	add	hl,bc
   4A5B DD 75 F0      [19]  415 	ld	-16 (ix),l
   4A5E DD 74 F1      [19]  416 	ld	-15 (ix),h
                            417 ;src/Renderer.c:287: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
   4A61 DD 7E 05      [19]  418 	ld	a,5 (ix)
   4A64 DD 77 FE      [19]  419 	ld	-2 (ix),a
   4A67 DD 36 FF 00   [19]  420 	ld	-1 (ix),#0x00
   4A6B DD 6E FE      [19]  421 	ld	l,-2 (ix)
   4A6E DD 66 FF      [19]  422 	ld	h,-1 (ix)
   4A71 E5            [11]  423 	push	hl
   4A72 21 00 20      [10]  424 	ld	hl,#0x2000
   4A75 E5            [11]  425 	push	hl
   4A76 CD EF 64      [17]  426 	call	__divsint
   4A79 F1            [10]  427 	pop	af
   4A7A F1            [10]  428 	pop	af
   4A7B DD 75 F3      [19]  429 	ld	-13 (ix),l
   4A7E DD 74 F4      [19]  430 	ld	-12 (ix),h
                            431 ;src/Renderer.c:288: u16 wall_texture_line=0;
   4A81 DD 36 F5 00   [19]  432 	ld	-11 (ix),#0x00
   4A85 DD 36 F6 00   [19]  433 	ld	-10 (ix),#0x00
                            434 ;src/Renderer.c:293: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   4A89 DD 4E 05      [19]  435 	ld	c,5 (ix)
   4A8C CB 39         [ 8]  436 	srl	c
   4A8E 3E 32         [ 7]  437 	ld	a,#0x32
   4A90 91            [ 4]  438 	sub	a, c
                            439 ;src/Renderer.c:294: ground_height = ceiling_height + lineHeight;
   4A91 4F            [ 4]  440 	ld	c,a
   4A92 DD 86 05      [19]  441 	add	a, 5 (ix)
   4A95 DD 77 F2      [19]  442 	ld	-14 (ix),a
                            443 ;src/Renderer.c:297: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   4A98 3E 64         [ 7]  444 	ld	a,#0x64
   4A9A DD 96 05      [19]  445 	sub	a, 5 (ix)
   4A9D 30 55         [12]  446 	jr	NC,00118$
                            447 ;src/Renderer.c:298: start=(lineHeight-SCREEN_TEXTURE_HEIGHT)/2;
   4A9F DD 7E FE      [19]  448 	ld	a,-2 (ix)
   4AA2 C6 9C         [ 7]  449 	add	a,#0x9C
   4AA4 4F            [ 4]  450 	ld	c,a
   4AA5 DD 7E FF      [19]  451 	ld	a,-1 (ix)
   4AA8 CE FF         [ 7]  452 	adc	a,#0xFF
   4AAA 47            [ 4]  453 	ld	b,a
   4AAB DD 71 FC      [19]  454 	ld	-4 (ix),c
   4AAE DD 70 FD      [19]  455 	ld	-3 (ix),b
   4AB1 CB 78         [ 8]  456 	bit	7, b
   4AB3 28 10         [12]  457 	jr	Z,00112$
   4AB5 DD 7E FE      [19]  458 	ld	a,-2 (ix)
   4AB8 C6 9D         [ 7]  459 	add	a, #0x9D
   4ABA DD 77 FC      [19]  460 	ld	-4 (ix),a
   4ABD DD 7E FF      [19]  461 	ld	a,-1 (ix)
   4AC0 CE FF         [ 7]  462 	adc	a, #0xFF
   4AC2 DD 77 FD      [19]  463 	ld	-3 (ix),a
   4AC5                     464 00112$:
   4AC5 DD 4E FC      [19]  465 	ld	c,-4 (ix)
   4AC8 DD 46 FD      [19]  466 	ld	b,-3 (ix)
   4ACB CB 28         [ 8]  467 	sra	b
   4ACD CB 19         [ 8]  468 	rr	c
                            469 ;src/Renderer.c:299: end+=start;
   4ACF DD 71 F8      [19]  470 	ld	-8 (ix), c
   4AD2 79            [ 4]  471 	ld	a, c
   4AD3 C6 64         [ 7]  472 	add	a, #0x64
   4AD5 DD 77 F9      [19]  473 	ld	-7 (ix),a
                            474 ;src/Renderer.c:300: ceiling_height=0;
   4AD8 0E 00         [ 7]  475 	ld	c,#0x00
                            476 ;src/Renderer.c:301: wall_texture_line = start * wall_texture_line_add;
   4ADA DD 5E F8      [19]  477 	ld	e,-8 (ix)
   4ADD 16 00         [ 7]  478 	ld	d,#0x00
   4ADF C5            [11]  479 	push	bc
   4AE0 DD 6E F3      [19]  480 	ld	l,-13 (ix)
   4AE3 DD 66 F4      [19]  481 	ld	h,-12 (ix)
   4AE6 E5            [11]  482 	push	hl
   4AE7 D5            [11]  483 	push	de
   4AE8 CD 39 64      [17]  484 	call	__mulint
   4AEB F1            [10]  485 	pop	af
   4AEC F1            [10]  486 	pop	af
   4AED C1            [10]  487 	pop	bc
   4AEE DD 75 F5      [19]  488 	ld	-11 (ix),l
   4AF1 DD 74 F6      [19]  489 	ld	-10 (ix),h
                            490 ;src/Renderer.c:306: for(j=start;j<end;++j){
   4AF4                     491 00118$:
   4AF4 DD 7E F7      [19]  492 	ld	a,-9 (ix)
   4AF7 2F            [ 4]  493 	cpl
   4AF8 DD 77 FC      [19]  494 	ld	-4 (ix),a
   4AFB DD 5E FA      [19]  495 	ld	e,-6 (ix)
   4AFE DD 56 FB      [19]  496 	ld	d,-5 (ix)
   4B01 DD 46 F8      [19]  497 	ld	b,-8 (ix)
   4B04                     498 00108$:
   4B04 78            [ 4]  499 	ld	a,b
   4B05 DD 96 F9      [19]  500 	sub	a, -7 (ix)
   4B08 30 41         [12]  501 	jr	NC,00110$
                            502 ;src/Renderer.c:307: val =  ((*pvmem)&(~pixMask));
   4B0A 1A            [ 7]  503 	ld	a,(de)
   4B0B DD A6 FC      [19]  504 	and	a, -4 (ix)
   4B0E DD 77 EF      [19]  505 	ld	-17 (ix),a
                            506 ;src/Renderer.c:309: if((j>=ceiling_height) && (j<ground_height)){
   4B11 78            [ 4]  507 	ld	a,b
   4B12 B9            [ 4]  508 	cp	a,c
   4B13 38 2E         [12]  509 	jr	C,00104$
   4B15 DD 96 F2      [19]  510 	sub	a, -14 (ix)
   4B18 30 29         [12]  511 	jr	NC,00104$
                            512 ;src/Renderer.c:311: w_color = (*(texture+(wall_texture_line/256))&pixMask);
   4B1A DD 6E F6      [19]  513 	ld	l,-10 (ix)
   4B1D 26 00         [ 7]  514 	ld	h,#0x00
   4B1F DD 7E F0      [19]  515 	ld	a,-16 (ix)
   4B22 85            [ 4]  516 	add	a, l
   4B23 6F            [ 4]  517 	ld	l,a
   4B24 DD 7E F1      [19]  518 	ld	a,-15 (ix)
   4B27 8C            [ 4]  519 	adc	a, h
   4B28 67            [ 4]  520 	ld	h,a
   4B29 7E            [ 7]  521 	ld	a,(hl)
   4B2A DD A6 F7      [19]  522 	and	a, -9 (ix)
                            523 ;src/Renderer.c:313: *pvmem = val|w_color;
   4B2D DD B6 EF      [19]  524 	or	a, -17 (ix)
   4B30 12            [ 7]  525 	ld	(de),a
                            526 ;src/Renderer.c:315: wall_texture_line += wall_texture_line_add;
   4B31 DD 7E F5      [19]  527 	ld	a,-11 (ix)
   4B34 DD 86 F3      [19]  528 	add	a, -13 (ix)
   4B37 DD 77 F5      [19]  529 	ld	-11 (ix),a
   4B3A DD 7E F6      [19]  530 	ld	a,-10 (ix)
   4B3D DD 8E F4      [19]  531 	adc	a, -12 (ix)
   4B40 DD 77 F6      [19]  532 	ld	-10 (ix),a
   4B43                     533 00104$:
                            534 ;src/Renderer.c:317: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   4B43 21 28 00      [10]  535 	ld	hl,#0x0028
   4B46 19            [11]  536 	add	hl,de
   4B47 EB            [ 4]  537 	ex	de,hl
                            538 ;src/Renderer.c:306: for(j=start;j<end;++j){
   4B48 04            [ 4]  539 	inc	b
   4B49 18 B9         [12]  540 	jr	00108$
   4B4B                     541 00110$:
   4B4B DD F9         [10]  542 	ld	sp, ix
   4B4D DD E1         [14]  543 	pop	ix
   4B4F C9            [10]  544 	ret
                            545 ;src/Renderer.c:321: void render_draw_to_buffer(){//TODO Optimize
                            546 ;	---------------------------------
                            547 ; Function render_draw_to_buffer
                            548 ; ---------------------------------
   4B50                     549 _render_draw_to_buffer::
   4B50 DD E5         [15]  550 	push	ix
   4B52 DD 21 00 00   [14]  551 	ld	ix,#0
   4B56 DD 39         [15]  552 	add	ix,sp
   4B58 21 D3 FF      [10]  553 	ld	hl,#-45
   4B5B 39            [11]  554 	add	hl,sp
   4B5C F9            [ 6]  555 	ld	sp,hl
                            556 ;src/Renderer.c:331: u8 zHeight = 5;
   4B5D DD 36 D5 05   [19]  557 	ld	-43 (ix),#0x05
                            558 ;src/Renderer.c:337: u8 offsetDiff = 16;
   4B61 DD 36 E0 10   [19]  559 	ld	-32 (ix),#0x10
                            560 ;src/Renderer.c:342: u8 lineStart = 0;
   4B65 DD 36 D9 00   [19]  561 	ld	-39 (ix),#0x00
                            562 ;src/Renderer.c:344: u8 lateralWallWidth=0;
   4B69 DD 36 D7 00   [19]  563 	ld	-41 (ix),#0x00
                            564 ;src/Renderer.c:356: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   4B6D 21 F8 49      [10]  565 	ld	hl, #_g_colors + 5
   4B70 46            [ 7]  566 	ld	b,(hl)
   4B71 21 A8 07      [10]  567 	ld	hl,#0x07A8
   4B74 E5            [11]  568 	push	hl
   4B75 C5            [11]  569 	push	bc
   4B76 33            [ 6]  570 	inc	sp
   4B77 21 40 29      [10]  571 	ld	hl,#0x2940
   4B7A E5            [11]  572 	push	hl
   4B7B CD D0 64      [17]  573 	call	_cpct_memset
                            574 ;src/Renderer.c:357: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
   4B7E 21 F4 49      [10]  575 	ld	hl, #_g_colors + 1
   4B81 46            [ 7]  576 	ld	b,(hl)
   4B82 21 50 00      [10]  577 	ld	hl,#0x0050
   4B85 E5            [11]  578 	push	hl
   4B86 C5            [11]  579 	push	bc
   4B87 33            [ 6]  580 	inc	sp
   4B88 21 E8 30      [10]  581 	ld	hl,#0x30E8
   4B8B E5            [11]  582 	push	hl
   4B8C CD D0 64      [17]  583 	call	_cpct_memset
                            584 ;src/Renderer.c:358: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   4B8F 21 F9 49      [10]  585 	ld	hl, #_g_colors + 6
   4B92 46            [ 7]  586 	ld	b,(hl)
   4B93 21 A8 07      [10]  587 	ld	hl,#0x07A8
   4B96 E5            [11]  588 	push	hl
   4B97 C5            [11]  589 	push	bc
   4B98 33            [ 6]  590 	inc	sp
   4B99 21 38 31      [10]  591 	ld	hl,#0x3138
   4B9C E5            [11]  592 	push	hl
   4B9D CD D0 64      [17]  593 	call	_cpct_memset
                            594 ;src/Renderer.c:360: calculate_cells_in_view();
   4BA0 CD 34 48      [17]  595 	call	_calculate_cells_in_view
                            596 ;src/Renderer.c:363: do{
   4BA3 DD 36 D3 06   [19]  597 	ld	-45 (ix),#0x06
   4BA7                     598 00165$:
                            599 ;src/Renderer.c:365: --z;
   4BA7 DD 35 D3      [23]  600 	dec	-45 (ix)
                            601 ;src/Renderer.c:369: xCellCount = (z) ? (zHeight >> 1) : 0;
   4BAA DD 7E D5      [19]  602 	ld	a,-43 (ix)
   4BAD CB 3F         [ 8]  603 	srl	a
   4BAF DD 77 F9      [19]  604 	ld	-7 (ix),a
   4BB2 DD 7E D3      [19]  605 	ld	a,-45 (ix)
   4BB5 B7            [ 4]  606 	or	a, a
   4BB6 28 05         [12]  607 	jr	Z,00174$
   4BB8 DD 4E F9      [19]  608 	ld	c,-7 (ix)
   4BBB 18 02         [12]  609 	jr	00175$
   4BBD                     610 00174$:
   4BBD 0E 00         [ 7]  611 	ld	c,#0x00
   4BBF                     612 00175$:
   4BBF DD 71 FE      [19]  613 	ld	-2 (ix),c
                            614 ;src/Renderer.c:370: lateralWallSlope=0;
   4BC2 DD 36 FF 00   [19]  615 	ld	-1 (ix),#0x00
                            616 ;src/Renderer.c:371: lateralWallSlopeCounter=0;
   4BC6 DD 36 F8 00   [19]  617 	ld	-8 (ix),#0x00
                            618 ;src/Renderer.c:372: xHeight=0;
   4BCA DD 36 EA 00   [19]  619 	ld	-22 (ix),#0x00
                            620 ;src/Renderer.c:374: lateralWallCounter = 0;
   4BCE DD 36 EE 00   [19]  621 	ld	-18 (ix),#0x00
                            622 ;src/Renderer.c:376: newCell=1;
   4BD2 DD 36 F1 01   [19]  623 	ld	-15 (ix),#0x01
                            624 ;src/Renderer.c:377: currentCellID = cells_in_view_array[lineStart + 1];
   4BD6 DD 7E D9      [19]  625 	ld	a,-39 (ix)
   4BD9 DD 77 EF      [19]  626 	ld	-17 (ix),a
   4BDC DD 36 F0 00   [19]  627 	ld	-16 (ix),#0x00
   4BE0 DD 4E EF      [19]  628 	ld	c,-17 (ix)
   4BE3 DD 46 F0      [19]  629 	ld	b,-16 (ix)
   4BE6 03            [ 6]  630 	inc	bc
   4BE7 2A 05 4A      [16]  631 	ld	hl,(_cells_in_view_array)
   4BEA DD 75 E3      [19]  632 	ld	-29 (ix),l
   4BED DD 74 E4      [19]  633 	ld	-28 (ix),h
   4BF0 DD 6E E3      [19]  634 	ld	l,-29 (ix)
   4BF3 DD 66 E4      [19]  635 	ld	h,-28 (ix)
   4BF6 09            [11]  636 	add	hl,bc
   4BF7 7E            [ 7]  637 	ld	a,(hl)
   4BF8 DD 77 E9      [19]  638 	ld	-23 (ix),a
                            639 ;src/Renderer.c:379: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   4BFB DD 7E E3      [19]  640 	ld	a,-29 (ix)
   4BFE DD 86 D9      [19]  641 	add	a, -39 (ix)
   4C01 6F            [ 4]  642 	ld	l,a
   4C02 DD 7E E4      [19]  643 	ld	a,-28 (ix)
   4C05 CE 00         [ 7]  644 	adc	a, #0x00
   4C07 67            [ 4]  645 	ld	h,a
   4C08 7E            [ 7]  646 	ld	a,(hl)
   4C09 DD 77 E5      [19]  647 	ld	-27 (ix),a
                            648 ;src/Renderer.c:380: if(lastCellWasWall&CELL_WALL_MASK){
   4C0C DD CB E5 7E   [20]  649 	bit	7, -27 (ix)
   4C10 28 06         [12]  650 	jr	Z,00102$
                            651 ;src/Renderer.c:381: lastWallId=lastCellWasWall;
                            652 ;src/Renderer.c:382: lastCellWasWall=1;
   4C12 DD 36 E8 01   [19]  653 	ld	-24 (ix),#0x01
   4C16 18 08         [12]  654 	jr	00193$
   4C18                     655 00102$:
                            656 ;src/Renderer.c:385: lastCellWasWall=0;
   4C18 DD 36 E8 00   [19]  657 	ld	-24 (ix),#0x00
                            658 ;src/Renderer.c:386: lastWallId=CELLTYPE_FLOOR;
   4C1C DD 36 E5 00   [19]  659 	ld	-27 (ix),#0x00
                            660 ;src/Renderer.c:389: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   4C20                     661 00193$:
   4C20 DD 36 D6 00   [19]  662 	ld	-42 (ix),#0x00
   4C24 DD 36 D8 00   [19]  663 	ld	-40 (ix),#0x00
   4C28                     664 00168$:
                            665 ;src/Renderer.c:391: if (xCellCount == zHeight)
   4C28 DD 7E D5      [19]  666 	ld	a,-43 (ix)
   4C2B DD 96 FE      [19]  667 	sub	a, -2 (ix)
   4C2E 20 4B         [12]  668 	jr	NZ,00105$
                            669 ;src/Renderer.c:393: ++xCell;
   4C30 DD 34 D6      [23]  670 	inc	-42 (ix)
                            671 ;src/Renderer.c:394: xCellCount = 0;
   4C33 DD 36 FE 00   [19]  672 	ld	-2 (ix),#0x00
                            673 ;src/Renderer.c:395: newCell=1;
   4C37 DD 36 F1 01   [19]  674 	ld	-15 (ix),#0x01
                            675 ;src/Renderer.c:396: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   4C3B DD 7E D6      [19]  676 	ld	a,-42 (ix)
   4C3E DD 77 EC      [19]  677 	ld	-20 (ix),a
   4C41 DD 36 ED 00   [19]  678 	ld	-19 (ix),#0x00
   4C45 DD 7E EF      [19]  679 	ld	a,-17 (ix)
   4C48 DD 86 EC      [19]  680 	add	a, -20 (ix)
   4C4B DD 77 EC      [19]  681 	ld	-20 (ix),a
   4C4E DD 7E F0      [19]  682 	ld	a,-16 (ix)
   4C51 DD 8E ED      [19]  683 	adc	a, -19 (ix)
   4C54 DD 77 ED      [19]  684 	ld	-19 (ix),a
   4C57 DD 34 EC      [23]  685 	inc	-20 (ix)
   4C5A 20 03         [12]  686 	jr	NZ,00321$
   4C5C DD 34 ED      [23]  687 	inc	-19 (ix)
   4C5F                     688 00321$:
   4C5F DD 7E EC      [19]  689 	ld	a,-20 (ix)
   4C62 DD 86 E3      [19]  690 	add	a, -29 (ix)
   4C65 DD 77 EC      [19]  691 	ld	-20 (ix),a
   4C68 DD 7E ED      [19]  692 	ld	a,-19 (ix)
   4C6B DD 8E E4      [19]  693 	adc	a, -28 (ix)
   4C6E DD 77 ED      [19]  694 	ld	-19 (ix),a
   4C71 DD 6E EC      [19]  695 	ld	l,-20 (ix)
   4C74 DD 66 ED      [19]  696 	ld	h,-19 (ix)
   4C77 7E            [ 7]  697 	ld	a,(hl)
   4C78 DD 77 E9      [19]  698 	ld	-23 (ix),a
   4C7B                     699 00105$:
                            700 ;src/Renderer.c:398: if(!(x%2)){
   4C7B DD 7E D8      [19]  701 	ld	a,-40 (ix)
   4C7E E6 01         [ 7]  702 	and	a, #0x01
   4C80 DD 77 EC      [19]  703 	ld	-20 (ix),a
                            704 ;src/Renderer.c:421: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4C83 DD 7E FE      [19]  705 	ld	a,-2 (ix)
   4C86 DD 77 E6      [19]  706 	ld	-26 (ix),a
   4C89 DD 36 E7 00   [19]  707 	ld	-25 (ix),#0x00
   4C8D DD 7E D5      [19]  708 	ld	a,-43 (ix)
   4C90 DD 77 EB      [19]  709 	ld	-21 (ix),a
                            710 ;src/Renderer.c:398: if(!(x%2)){
   4C93 DD 7E EC      [19]  711 	ld	a,-20 (ix)
   4C96 B7            [ 4]  712 	or	a, a
   4C97 C2 4A 4D      [10]  713 	jp	NZ,00118$
                            714 ;src/Renderer.c:399: if ((lateralWallCounter == 0)||newCell)
   4C9A DD 7E EE      [19]  715 	ld	a,-18 (ix)
   4C9D B7            [ 4]  716 	or	a, a
   4C9E 28 07         [12]  717 	jr	Z,00114$
   4CA0 DD 7E F1      [19]  718 	ld	a,-15 (ix)
   4CA3 B7            [ 4]  719 	or	a, a
   4CA4 CA 4A 4D      [10]  720 	jp	Z,00118$
   4CA7                     721 00114$:
                            722 ;src/Renderer.c:401: if (currentCellID & CELL_WALL_MASK)//Wall
   4CA7 DD CB E9 7E   [20]  723 	bit	7, -23 (ix)
   4CAB 28 22         [12]  724 	jr	Z,00112$
                            725 ;src/Renderer.c:403: lateralWallCounter = 0;//(zHeight - xCellCount);
   4CAD DD 36 EE 00   [19]  726 	ld	-18 (ix),#0x00
                            727 ;src/Renderer.c:404: lateralWallSlope = 0;
   4CB1 DD 36 FF 00   [19]  728 	ld	-1 (ix),#0x00
                            729 ;src/Renderer.c:405: xHeight = zHeight;
   4CB5 DD 7E D5      [19]  730 	ld	a,-43 (ix)
   4CB8 DD 77 EA      [19]  731 	ld	-22 (ix),a
                            732 ;src/Renderer.c:406: color = currentCellID&0b01111111;
   4CBB DD 7E E9      [19]  733 	ld	a,-23 (ix)
   4CBE E6 7F         [ 7]  734 	and	a, #0x7F
   4CC0 DD 77 DE      [19]  735 	ld	-34 (ix),a
                            736 ;src/Renderer.c:407: lastCellWasWall = 1;
   4CC3 DD 36 E8 01   [19]  737 	ld	-24 (ix),#0x01
                            738 ;src/Renderer.c:408: lastWallId=currentCellID;
   4CC7 DD 7E E9      [19]  739 	ld	a,-23 (ix)
   4CCA DD 77 E5      [19]  740 	ld	-27 (ix),a
   4CCD 18 77         [12]  741 	jr	00113$
   4CCF                     742 00112$:
                            743 ;src/Renderer.c:411: if(lateralWallCounter==0){//Lateral wall not finished
   4CCF DD 7E EE      [19]  744 	ld	a,-18 (ix)
   4CD2 B7            [ 4]  745 	or	a, a
   4CD3 20 71         [12]  746 	jr	NZ,00113$
                            747 ;src/Renderer.c:412: if (lastCellWasWall)
   4CD5 DD 7E E8      [19]  748 	ld	a,-24 (ix)
   4CD8 B7            [ 4]  749 	or	a, a
   4CD9 28 5B         [12]  750 	jr	Z,00107$
                            751 ;src/Renderer.c:415: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   4CDB DD 7E E0      [19]  752 	ld	a,-32 (ix)
   4CDE DD 96 D6      [19]  753 	sub	a, -42 (ix)
   4CE1 87            [ 4]  754 	add	a, a
   4CE2 3C            [ 4]  755 	inc	a
                            756 ;src/Renderer.c:416: lateralWallSlopeCounter = lateralWallSlope / 2;
   4CE3 DD 77 FF      [19]  757 	ld	-1 (ix), a
   4CE6 CB 3F         [ 8]  758 	srl	a
   4CE8 DD 77 F8      [19]  759 	ld	-8 (ix),a
                            760 ;src/Renderer.c:417: lateralWallCounter = lateralWallSlope * zHeight;
   4CEB DD 5E D5      [19]  761 	ld	e,-43 (ix)
   4CEE DD 66 FF      [19]  762 	ld	h,-1 (ix)
   4CF1 2E 00         [ 7]  763 	ld	l, #0x00
   4CF3 55            [ 4]  764 	ld	d, l
   4CF4 06 08         [ 7]  765 	ld	b, #0x08
   4CF6                     766 00323$:
   4CF6 29            [11]  767 	add	hl,hl
   4CF7 30 01         [12]  768 	jr	NC,00324$
   4CF9 19            [11]  769 	add	hl,de
   4CFA                     770 00324$:
   4CFA 10 FA         [13]  771 	djnz	00323$
                            772 ;src/Renderer.c:418: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   4CFC 7D            [ 4]  773 	ld	a,l
   4CFD E6 FC         [ 7]  774 	and	a, #0xFC
   4CFF CB C7         [ 8]  775 	set	0, a
   4D01 CB 3F         [ 8]  776 	srl	a
   4D03 CB 3F         [ 8]  777 	srl	a
   4D05 DD 96 FE      [19]  778 	sub	a, -2 (ix)
                            779 ;src/Renderer.c:419: lateralWallWidth=lateralWallCounter;
   4D08 DD 77 EE      [19]  780 	ld	-18 (ix), a
   4D0B DD 77 D7      [19]  781 	ld	-41 (ix),a
                            782 ;src/Renderer.c:420: lastCellWasWall = 0;
   4D0E DD 36 E8 00   [19]  783 	ld	-24 (ix),#0x00
                            784 ;src/Renderer.c:421: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4D12 DD 6E E6      [19]  785 	ld	l,-26 (ix)
   4D15 DD 66 E7      [19]  786 	ld	h,-25 (ix)
   4D18 29            [11]  787 	add	hl, hl
   4D19 DD 4E FF      [19]  788 	ld	c,-1 (ix)
   4D1C 06 00         [ 7]  789 	ld	b,#0x00
   4D1E C5            [11]  790 	push	bc
   4D1F E5            [11]  791 	push	hl
   4D20 CD EF 64      [17]  792 	call	__divsint
   4D23 F1            [10]  793 	pop	af
   4D24 F1            [10]  794 	pop	af
   4D25 DD 7E EB      [19]  795 	ld	a,-21 (ix)
   4D28 95            [ 4]  796 	sub	a, l
   4D29 DD 77 EA      [19]  797 	ld	-22 (ix),a
                            798 ;src/Renderer.c:422: color = lastWallId&0b01111111;
   4D2C DD 7E E5      [19]  799 	ld	a,-27 (ix)
   4D2F E6 7F         [ 7]  800 	and	a, #0x7F
   4D31 DD 77 DE      [19]  801 	ld	-34 (ix),a
   4D34 18 10         [12]  802 	jr	00113$
   4D36                     803 00107$:
                            804 ;src/Renderer.c:426: xHeight = 0;
   4D36 DD 36 EA 00   [19]  805 	ld	-22 (ix),#0x00
                            806 ;src/Renderer.c:427: lastCellWasWall = 0;
   4D3A DD 36 E8 00   [19]  807 	ld	-24 (ix),#0x00
                            808 ;src/Renderer.c:428: lateralWallSlope=0;
   4D3E DD 36 FF 00   [19]  809 	ld	-1 (ix),#0x00
                            810 ;src/Renderer.c:429: lastWallId=0;
   4D42 DD 36 E5 00   [19]  811 	ld	-27 (ix),#0x00
   4D46                     812 00113$:
                            813 ;src/Renderer.c:434: newCell=0;
   4D46 DD 36 F1 00   [19]  814 	ld	-15 (ix),#0x00
   4D4A                     815 00118$:
                            816 ;src/Renderer.c:437: if (lateralWallCounter > 0)
   4D4A DD 7E EE      [19]  817 	ld	a,-18 (ix)
   4D4D B7            [ 4]  818 	or	a, a
   4D4E 28 1E         [12]  819 	jr	Z,00124$
                            820 ;src/Renderer.c:440: if (lateralWallSlope != 0)
   4D50 DD 7E FF      [19]  821 	ld	a,-1 (ix)
   4D53 B7            [ 4]  822 	or	a, a
   4D54 28 15         [12]  823 	jr	Z,00122$
                            824 ;src/Renderer.c:442: if (lateralWallSlopeCounter == lateralWallSlope)
   4D56 DD 7E FF      [19]  825 	ld	a,-1 (ix)
   4D59 DD 96 F8      [19]  826 	sub	a, -8 (ix)
   4D5C 20 0A         [12]  827 	jr	NZ,00120$
                            828 ;src/Renderer.c:444: lateralWallSlopeCounter = 0;
   4D5E DD 36 F8 00   [19]  829 	ld	-8 (ix),#0x00
                            830 ;src/Renderer.c:445: xHeight -= 2;
   4D62 DD 35 EA      [23]  831 	dec	-22 (ix)
   4D65 DD 35 EA      [23]  832 	dec	-22 (ix)
   4D68                     833 00120$:
                            834 ;src/Renderer.c:447: ++lateralWallSlopeCounter;
   4D68 DD 34 F8      [23]  835 	inc	-8 (ix)
   4D6B                     836 00122$:
                            837 ;src/Renderer.c:450: --lateralWallCounter;
   4D6B DD 35 EE      [23]  838 	dec	-18 (ix)
   4D6E                     839 00124$:
                            840 ;src/Renderer.c:461: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   4D6E DD 7E D5      [19]  841 	ld	a,-43 (ix)
   4D71 DD 77 F2      [19]  842 	ld	-14 (ix),a
   4D74 DD 36 F3 00   [19]  843 	ld	-13 (ix),#0x00
                            844 ;src/Renderer.c:453: if (!(x%2))
   4D78 DD 7E EC      [19]  845 	ld	a,-20 (ix)
   4D7B B7            [ 4]  846 	or	a, a
   4D7C 20 59         [12]  847 	jr	NZ,00131$
                            848 ;src/Renderer.c:455: if(xHeight > 0){
   4D7E DD 7E EA      [19]  849 	ld	a,-22 (ix)
   4D81 B7            [ 4]  850 	or	a, a
   4D82 28 53         [12]  851 	jr	Z,00131$
                            852 ;src/Renderer.c:456: if (lateralWallCounter > 0)
   4D84 DD 7E EE      [19]  853 	ld	a,-18 (ix)
   4D87 B7            [ 4]  854 	or	a, a
   4D88 28 1F         [12]  855 	jr	Z,00126$
                            856 ;src/Renderer.c:458: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   4D8A DD 4E D7      [19]  857 	ld	c,-41 (ix)
   4D8D 06 00         [ 7]  858 	ld	b,#0x00
   4D8F DD 5E EE      [19]  859 	ld	e,-18 (ix)
   4D92 16 00         [ 7]  860 	ld	d,#0x00
   4D94 79            [ 4]  861 	ld	a,c
   4D95 93            [ 4]  862 	sub	a, e
   4D96 6F            [ 4]  863 	ld	l,a
   4D97 78            [ 4]  864 	ld	a,b
   4D98 9A            [ 4]  865 	sbc	a, d
   4D99 67            [ 4]  866 	ld	h,a
   4D9A 29            [11]  867 	add	hl, hl
   4D9B 29            [11]  868 	add	hl, hl
   4D9C 29            [11]  869 	add	hl, hl
   4D9D 29            [11]  870 	add	hl, hl
   4D9E 29            [11]  871 	add	hl, hl
   4D9F C5            [11]  872 	push	bc
   4DA0 E5            [11]  873 	push	hl
   4DA1 CD EF 64      [17]  874 	call	__divsint
   4DA4 F1            [10]  875 	pop	af
   4DA5 F1            [10]  876 	pop	af
   4DA6 45            [ 4]  877 	ld	b,l
   4DA7 18 19         [12]  878 	jr	00127$
   4DA9                     879 00126$:
                            880 ;src/Renderer.c:461: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   4DA9 DD 6E E6      [19]  881 	ld	l,-26 (ix)
   4DAC DD 66 E7      [19]  882 	ld	h,-25 (ix)
   4DAF 29            [11]  883 	add	hl, hl
   4DB0 29            [11]  884 	add	hl, hl
   4DB1 29            [11]  885 	add	hl, hl
   4DB2 29            [11]  886 	add	hl, hl
   4DB3 29            [11]  887 	add	hl, hl
   4DB4 DD 4E F2      [19]  888 	ld	c,-14 (ix)
   4DB7 DD 46 F3      [19]  889 	ld	b,-13 (ix)
   4DBA C5            [11]  890 	push	bc
   4DBB E5            [11]  891 	push	hl
   4DBC CD EF 64      [17]  892 	call	__divsint
   4DBF F1            [10]  893 	pop	af
   4DC0 F1            [10]  894 	pop	af
   4DC1 45            [ 4]  895 	ld	b,l
   4DC2                     896 00127$:
                            897 ;src/Renderer.c:463: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   4DC2 DD 56 D8      [19]  898 	ld	d,-40 (ix)
   4DC5 CB 3A         [ 8]  899 	srl	d
   4DC7 C5            [11]  900 	push	bc
   4DC8 33            [ 6]  901 	inc	sp
   4DC9 DD 66 DE      [19]  902 	ld	h,-34 (ix)
   4DCC DD 6E EA      [19]  903 	ld	l,-22 (ix)
   4DCF E5            [11]  904 	push	hl
   4DD0 D5            [11]  905 	push	de
   4DD1 33            [ 6]  906 	inc	sp
   4DD2 CD 0C 4A      [17]  907 	call	_draw_column_to_buffer
   4DD5 F1            [10]  908 	pop	af
   4DD6 F1            [10]  909 	pop	af
   4DD7                     910 00131$:
                            911 ;src/Renderer.c:467: ++xCellCount;
   4DD7 DD 34 FE      [23]  912 	inc	-2 (ix)
                            913 ;src/Renderer.c:389: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   4DDA DD 34 D8      [23]  914 	inc	-40 (ix)
                            915 ;src/Renderer.c:377: currentCellID = cells_in_view_array[lineStart + 1];
   4DDD 2A 05 4A      [16]  916 	ld	hl,(_cells_in_view_array)
   4DE0 DD 75 E3      [19]  917 	ld	-29 (ix),l
   4DE3 DD 74 E4      [19]  918 	ld	-28 (ix),h
                            919 ;src/Renderer.c:389: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   4DE6 DD 7E D8      [19]  920 	ld	a,-40 (ix)
   4DE9 D6 50         [ 7]  921 	sub	a, #0x50
   4DEB DA 28 4C      [10]  922 	jp	C,00168$
                            923 ;src/Renderer.c:474: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   4DEE DD 7E D3      [19]  924 	ld	a,-45 (ix)
   4DF1 B7            [ 4]  925 	or	a, a
   4DF2 28 05         [12]  926 	jr	Z,00176$
   4DF4 DD 4E F9      [19]  927 	ld	c,-7 (ix)
   4DF7 18 02         [12]  928 	jr	00177$
   4DF9                     929 00176$:
   4DF9 0E 00         [ 7]  930 	ld	c,#0x00
   4DFB                     931 00177$:
   4DFB DD 71 DA      [19]  932 	ld	-38 (ix),c
                            933 ;src/Renderer.c:475: lateralWallSlope=0;
   4DFE DD 36 DF 00   [19]  934 	ld	-33 (ix),#0x00
                            935 ;src/Renderer.c:476: lateralWallSlopeCounter=0;
   4E02 DD 36 DB 00   [19]  936 	ld	-37 (ix),#0x00
                            937 ;src/Renderer.c:477: xHeight=0;
   4E06 DD 36 E2 00   [19]  938 	ld	-30 (ix),#0x00
                            939 ;src/Renderer.c:479: lateralWallCounter = 0;
   4E0A DD 36 E6 00   [19]  940 	ld	-26 (ix),#0x00
                            941 ;src/Renderer.c:480: lineEnd = lineStart + offsetDiff * 2 + 2;
   4E0E DD 7E E0      [19]  942 	ld	a,-32 (ix)
   4E11 87            [ 4]  943 	add	a, a
   4E12 4F            [ 4]  944 	ld	c,a
   4E13 DD 7E D9      [19]  945 	ld	a,-39 (ix)
   4E16 81            [ 4]  946 	add	a, c
   4E17 DD 77 EC      [19]  947 	ld	-20 (ix), a
   4E1A 4F            [ 4]  948 	ld	c, a
   4E1B 0C            [ 4]  949 	inc	c
   4E1C 0C            [ 4]  950 	inc	c
                            951 ;src/Renderer.c:482: newCell=1;
   4E1D DD 36 D4 01   [19]  952 	ld	-44 (ix),#0x01
                            953 ;src/Renderer.c:483: currentCellID = cells_in_view_array[lineEnd - 1];
   4E21 DD 71 EF      [19]  954 	ld	-17 (ix),c
   4E24 DD 36 F0 00   [19]  955 	ld	-16 (ix),#0x00
   4E28 DD 5E EF      [19]  956 	ld	e,-17 (ix)
   4E2B DD 56 F0      [19]  957 	ld	d,-16 (ix)
   4E2E 1B            [ 6]  958 	dec	de
   4E2F DD 6E E3      [19]  959 	ld	l,-29 (ix)
   4E32 DD 66 E4      [19]  960 	ld	h,-28 (ix)
   4E35 19            [11]  961 	add	hl,de
   4E36 7E            [ 7]  962 	ld	a,(hl)
   4E37 DD 77 E1      [19]  963 	ld	-31 (ix),a
                            964 ;src/Renderer.c:485: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   4E3A DD 6E E3      [19]  965 	ld	l,-29 (ix)
   4E3D DD 66 E4      [19]  966 	ld	h,-28 (ix)
   4E40 06 00         [ 7]  967 	ld	b,#0x00
   4E42 09            [11]  968 	add	hl, bc
   4E43 4E            [ 7]  969 	ld	c,(hl)
                            970 ;src/Renderer.c:486: if(lastCellWasWall&CELL_WALL_MASK){
   4E44 CB 79         [ 8]  971 	bit	7, c
   4E46 28 09         [12]  972 	jr	Z,00134$
                            973 ;src/Renderer.c:487: lastWallId=lastCellWasWall;
   4E48 DD 71 DC      [19]  974 	ld	-36 (ix),c
                            975 ;src/Renderer.c:488: lastCellWasWall=1;
   4E4B DD 36 E8 01   [19]  976 	ld	-24 (ix),#0x01
   4E4F 18 08         [12]  977 	jr	00210$
   4E51                     978 00134$:
                            979 ;src/Renderer.c:491: lastCellWasWall=0;
   4E51 DD 36 E8 00   [19]  980 	ld	-24 (ix),#0x00
                            981 ;src/Renderer.c:492: lastWallId=CELLTYPE_FLOOR;
   4E55 DD 36 DC 00   [19]  982 	ld	-36 (ix),#0x00
                            983 ;src/Renderer.c:495: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   4E59                     984 00210$:
   4E59 DD 36 D6 00   [19]  985 	ld	-42 (ix),#0x00
   4E5D DD 36 D8 9F   [19]  986 	ld	-40 (ix),#0x9F
   4E61                     987 00170$:
                            988 ;src/Renderer.c:498: if (xCellCount == zHeight)
   4E61 DD 7E D5      [19]  989 	ld	a,-43 (ix)
   4E64 DD 96 DA      [19]  990 	sub	a, -38 (ix)
   4E67 20 59         [12]  991 	jr	NZ,00137$
                            992 ;src/Renderer.c:500: ++xCell;
   4E69 DD 34 D6      [23]  993 	inc	-42 (ix)
                            994 ;src/Renderer.c:501: xCellCount = 0;
   4E6C DD 36 DA 00   [19]  995 	ld	-38 (ix),#0x00
                            996 ;src/Renderer.c:502: newCell=1;
   4E70 DD 36 D4 01   [19]  997 	ld	-44 (ix),#0x01
                            998 ;src/Renderer.c:503: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   4E74 DD 7E D6      [19]  999 	ld	a,-42 (ix)
   4E77 DD 77 E3      [19] 1000 	ld	-29 (ix),a
   4E7A DD 36 E4 00   [19] 1001 	ld	-28 (ix),#0x00
   4E7E DD 7E EF      [19] 1002 	ld	a,-17 (ix)
   4E81 DD 96 E3      [19] 1003 	sub	a, -29 (ix)
   4E84 DD 77 E3      [19] 1004 	ld	-29 (ix),a
   4E87 DD 7E F0      [19] 1005 	ld	a,-16 (ix)
   4E8A DD 9E E4      [19] 1006 	sbc	a, -28 (ix)
   4E8D DD 77 E4      [19] 1007 	ld	-28 (ix),a
   4E90 DD 6E E3      [19] 1008 	ld	l,-29 (ix)
   4E93 DD 66 E4      [19] 1009 	ld	h,-28 (ix)
   4E96 2B            [ 6] 1010 	dec	hl
   4E97 DD 75 E3      [19] 1011 	ld	-29 (ix),l
   4E9A DD 74 E4      [19] 1012 	ld	-28 (ix),h
   4E9D 2A 05 4A      [16] 1013 	ld	hl,(_cells_in_view_array)
   4EA0 DD 75 F4      [19] 1014 	ld	-12 (ix),l
   4EA3 DD 74 F5      [19] 1015 	ld	-11 (ix),h
   4EA6 DD 7E E3      [19] 1016 	ld	a,-29 (ix)
   4EA9 DD 86 F4      [19] 1017 	add	a, -12 (ix)
   4EAC DD 77 F4      [19] 1018 	ld	-12 (ix),a
   4EAF DD 7E E4      [19] 1019 	ld	a,-28 (ix)
   4EB2 DD 8E F5      [19] 1020 	adc	a, -11 (ix)
   4EB5 DD 77 F5      [19] 1021 	ld	-11 (ix),a
   4EB8 DD 6E F4      [19] 1022 	ld	l,-12 (ix)
   4EBB DD 66 F5      [19] 1023 	ld	h,-11 (ix)
   4EBE 7E            [ 7] 1024 	ld	a,(hl)
   4EBF DD 77 E1      [19] 1025 	ld	-31 (ix),a
   4EC2                    1026 00137$:
                           1027 ;src/Renderer.c:505: if(!(x%2)){
   4EC2 DD 7E D8      [19] 1028 	ld	a,-40 (ix)
   4EC5 E6 01         [ 7] 1029 	and	a, #0x01
   4EC7 DD 77 F4      [19] 1030 	ld	-12 (ix),a
                           1031 ;src/Renderer.c:421: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4ECA DD 7E DA      [19] 1032 	ld	a,-38 (ix)
   4ECD DD 77 E3      [19] 1033 	ld	-29 (ix),a
   4ED0 DD 36 E4 00   [19] 1034 	ld	-28 (ix),#0x00
                           1035 ;src/Renderer.c:505: if(!(x%2)){
   4ED4 DD 7E F4      [19] 1036 	ld	a,-12 (ix)
   4ED7 B7            [ 4] 1037 	or	a, a
   4ED8 C2 29 50      [10] 1038 	jp	NZ,00150$
                           1039 ;src/Renderer.c:506: if (lateralWallCounter == 0 || newCell)
   4EDB DD 7E E6      [19] 1040 	ld	a,-26 (ix)
   4EDE B7            [ 4] 1041 	or	a, a
   4EDF 28 07         [12] 1042 	jr	Z,00146$
   4EE1 DD 7E D4      [19] 1043 	ld	a,-44 (ix)
   4EE4 B7            [ 4] 1044 	or	a, a
   4EE5 CA 29 50      [10] 1045 	jp	Z,00150$
   4EE8                    1046 00146$:
                           1047 ;src/Renderer.c:508: if ( currentCellID & CELL_WALL_MASK)//Wall
   4EE8 DD CB E1 7E   [20] 1048 	bit	7, -31 (ix)
   4EEC 28 23         [12] 1049 	jr	Z,00144$
                           1050 ;src/Renderer.c:510: lateralWallCounter = 0;
   4EEE DD 36 E6 00   [19] 1051 	ld	-26 (ix),#0x00
                           1052 ;src/Renderer.c:511: lateralWallSlope = 0;
   4EF2 DD 36 DF 00   [19] 1053 	ld	-33 (ix),#0x00
                           1054 ;src/Renderer.c:512: xHeight = zHeight;
   4EF6 DD 7E D5      [19] 1055 	ld	a,-43 (ix)
   4EF9 DD 77 E2      [19] 1056 	ld	-30 (ix),a
                           1057 ;src/Renderer.c:513: color = currentCellID&0b01111111;
   4EFC DD 7E E1      [19] 1058 	ld	a,-31 (ix)
   4EFF E6 7F         [ 7] 1059 	and	a, #0x7F
   4F01 DD 77 DE      [19] 1060 	ld	-34 (ix),a
                           1061 ;src/Renderer.c:514: lastCellWasWall = 1;
   4F04 DD 36 E8 01   [19] 1062 	ld	-24 (ix),#0x01
                           1063 ;src/Renderer.c:515: lastWallId=currentCellID;
   4F08 DD 7E E1      [19] 1064 	ld	a,-31 (ix)
   4F0B DD 77 DC      [19] 1065 	ld	-36 (ix),a
   4F0E C3 25 50      [10] 1066 	jp	00145$
   4F11                    1067 00144$:
                           1068 ;src/Renderer.c:517: else if(lateralWallCounter==0){
   4F11 DD 7E E6      [19] 1069 	ld	a,-26 (ix)
   4F14 B7            [ 4] 1070 	or	a, a
   4F15 C2 25 50      [10] 1071 	jp	NZ,00145$
                           1072 ;src/Renderer.c:518: if (lastCellWasWall)
   4F18 DD 7E E8      [19] 1073 	ld	a,-24 (ix)
   4F1B B7            [ 4] 1074 	or	a, a
   4F1C CA 15 50      [10] 1075 	jp	Z,00139$
                           1076 ;src/Renderer.c:521: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   4F1F DD 7E E0      [19] 1077 	ld	a,-32 (ix)
   4F22 DD 96 D6      [19] 1078 	sub	a, -42 (ix)
   4F25 87            [ 4] 1079 	add	a, a
   4F26 3C            [ 4] 1080 	inc	a
                           1081 ;src/Renderer.c:522: lateralWallSlopeCounter = lateralWallSlope / 2;
   4F27 DD 77 DF      [19] 1082 	ld	-33 (ix), a
   4F2A CB 3F         [ 8] 1083 	srl	a
   4F2C DD 77 DB      [19] 1084 	ld	-37 (ix),a
                           1085 ;src/Renderer.c:523: lateralWallCounter = lateralWallSlope * zHeight;
   4F2F DD 5E D5      [19] 1086 	ld	e,-43 (ix)
   4F32 DD 66 DF      [19] 1087 	ld	h,-33 (ix)
   4F35 2E 00         [ 7] 1088 	ld	l, #0x00
   4F37 55            [ 4] 1089 	ld	d, l
   4F38 06 08         [ 7] 1090 	ld	b, #0x08
   4F3A                    1091 00331$:
   4F3A 29            [11] 1092 	add	hl,hl
   4F3B 30 01         [12] 1093 	jr	NC,00332$
   4F3D 19            [11] 1094 	add	hl,de
   4F3E                    1095 00332$:
   4F3E 10 FA         [13] 1096 	djnz	00331$
   4F40 DD 75 E5      [19] 1097 	ld	-27 (ix), l
   4F43 7D            [ 4] 1098 	ld	a, l
                           1099 ;src/Renderer.c:524: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   4F44 DD 77 DD      [19] 1100 	ld	-35 (ix), a
   4F47 DD 77 F6      [19] 1101 	ld	-10 (ix),a
   4F4A DD 36 F7 00   [19] 1102 	ld	-9 (ix),#0x00
   4F4E DD 7E DD      [19] 1103 	ld	a,-35 (ix)
   4F51 E6 03         [ 7] 1104 	and	a, #0x03
   4F53 DD 77 E5      [19] 1105 	ld	-27 (ix), a
   4F56 DD 77 FA      [19] 1106 	ld	-6 (ix),a
   4F59 DD 36 FB 00   [19] 1107 	ld	-5 (ix),#0x00
   4F5D DD 7E F6      [19] 1108 	ld	a,-10 (ix)
   4F60 DD 96 FA      [19] 1109 	sub	a, -6 (ix)
   4F63 DD 77 FA      [19] 1110 	ld	-6 (ix),a
   4F66 DD 7E F7      [19] 1111 	ld	a,-9 (ix)
   4F69 DD 9E FB      [19] 1112 	sbc	a, -5 (ix)
   4F6C DD 77 FB      [19] 1113 	ld	-5 (ix),a
   4F6F DD 7E FA      [19] 1114 	ld	a,-6 (ix)
   4F72 C6 01         [ 7] 1115 	add	a, #0x01
   4F74 DD 77 F6      [19] 1116 	ld	-10 (ix),a
   4F77 DD 7E FB      [19] 1117 	ld	a,-5 (ix)
   4F7A CE 00         [ 7] 1118 	adc	a, #0x00
   4F7C DD 77 F7      [19] 1119 	ld	-9 (ix),a
   4F7F DD 7E F6      [19] 1120 	ld	a,-10 (ix)
   4F82 DD 77 FC      [19] 1121 	ld	-4 (ix),a
   4F85 DD 7E F7      [19] 1122 	ld	a,-9 (ix)
   4F88 DD 77 FD      [19] 1123 	ld	-3 (ix),a
   4F8B DD CB F7 7E   [20] 1124 	bit	7, -9 (ix)
   4F8F 28 10         [12] 1125 	jr	Z,00178$
   4F91 DD 7E FA      [19] 1126 	ld	a,-6 (ix)
   4F94 C6 04         [ 7] 1127 	add	a, #0x04
   4F96 DD 77 FC      [19] 1128 	ld	-4 (ix),a
   4F99 DD 7E FB      [19] 1129 	ld	a,-5 (ix)
   4F9C CE 00         [ 7] 1130 	adc	a, #0x00
   4F9E DD 77 FD      [19] 1131 	ld	-3 (ix),a
   4FA1                    1132 00178$:
   4FA1 DD CB FD 2E   [23] 1133 	sra	-3 (ix)
   4FA5 DD CB FC 1E   [23] 1134 	rr	-4 (ix)
   4FA9 DD CB FD 2E   [23] 1135 	sra	-3 (ix)
   4FAD DD CB FC 1E   [23] 1136 	rr	-4 (ix)
   4FB1 DD 7E FC      [19] 1137 	ld	a,-4 (ix)
   4FB4 DD 77 FC      [19] 1138 	ld	-4 (ix),a
   4FB7 DD 4E DA      [19] 1139 	ld	c,-38 (ix)
   4FBA DD 7E FC      [19] 1140 	ld	a,-4 (ix)
   4FBD 91            [ 4] 1141 	sub	a, c
                           1142 ;src/Renderer.c:525: lateralWallWidth=lateralWallCounter;
   4FBE DD 77 E6      [19] 1143 	ld	-26 (ix), a
   4FC1 DD 77 D7      [19] 1144 	ld	-41 (ix),a
                           1145 ;src/Renderer.c:526: lastCellWasWall = 0;
   4FC4 DD 36 E8 00   [19] 1146 	ld	-24 (ix),#0x00
                           1147 ;src/Renderer.c:527: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   4FC8 DD 7E E3      [19] 1148 	ld	a,-29 (ix)
   4FCB DD 77 FC      [19] 1149 	ld	-4 (ix),a
   4FCE DD 7E E4      [19] 1150 	ld	a,-28 (ix)
   4FD1 DD 77 FD      [19] 1151 	ld	-3 (ix),a
   4FD4 DD CB FC 26   [23] 1152 	sla	-4 (ix)
   4FD8 DD CB FD 16   [23] 1153 	rl	-3 (ix)
   4FDC DD 7E DF      [19] 1154 	ld	a,-33 (ix)
   4FDF DD 77 FA      [19] 1155 	ld	-6 (ix),a
   4FE2 DD 36 FB 00   [19] 1156 	ld	-5 (ix),#0x00
   4FE6 DD 6E FA      [19] 1157 	ld	l,-6 (ix)
   4FE9 DD 66 FB      [19] 1158 	ld	h,-5 (ix)
   4FEC E5            [11] 1159 	push	hl
   4FED DD 6E FC      [19] 1160 	ld	l,-4 (ix)
   4FF0 DD 66 FD      [19] 1161 	ld	h,-3 (ix)
   4FF3 E5            [11] 1162 	push	hl
   4FF4 CD EF 64      [17] 1163 	call	__divsint
   4FF7 F1            [10] 1164 	pop	af
   4FF8 F1            [10] 1165 	pop	af
   4FF9 DD 74 FD      [19] 1166 	ld	-3 (ix),h
   4FFC DD 75 FC      [19] 1167 	ld	-4 (ix), l
   4FFF DD 75 FC      [19] 1168 	ld	-4 (ix), l
   5002 DD 7E EB      [19] 1169 	ld	a,-21 (ix)
   5005 DD 96 FC      [19] 1170 	sub	a, -4 (ix)
   5008 DD 77 E2      [19] 1171 	ld	-30 (ix),a
                           1172 ;src/Renderer.c:528: color = lastWallId&0b01111111;
   500B DD 7E DC      [19] 1173 	ld	a,-36 (ix)
   500E E6 7F         [ 7] 1174 	and	a, #0x7F
   5010 DD 77 DE      [19] 1175 	ld	-34 (ix),a
   5013 18 10         [12] 1176 	jr	00145$
   5015                    1177 00139$:
                           1178 ;src/Renderer.c:532: xHeight = 0;
   5015 DD 36 E2 00   [19] 1179 	ld	-30 (ix),#0x00
                           1180 ;src/Renderer.c:533: lastCellWasWall = 0;
   5019 DD 36 E8 00   [19] 1181 	ld	-24 (ix),#0x00
                           1182 ;src/Renderer.c:534: lateralWallSlope=0;
   501D DD 36 DF 00   [19] 1183 	ld	-33 (ix),#0x00
                           1184 ;src/Renderer.c:535: lastWallId=0;
   5021 DD 36 DC 00   [19] 1185 	ld	-36 (ix),#0x00
   5025                    1186 00145$:
                           1187 ;src/Renderer.c:538: newCell=0;
   5025 DD 36 D4 00   [19] 1188 	ld	-44 (ix),#0x00
   5029                    1189 00150$:
                           1190 ;src/Renderer.c:543: if (lateralWallCounter > 0)
   5029 DD 7E E6      [19] 1191 	ld	a,-26 (ix)
   502C B7            [ 4] 1192 	or	a, a
   502D 28 1E         [12] 1193 	jr	Z,00156$
                           1194 ;src/Renderer.c:546: if (lateralWallSlope != 0)
   502F DD 7E DF      [19] 1195 	ld	a,-33 (ix)
   5032 B7            [ 4] 1196 	or	a, a
   5033 28 15         [12] 1197 	jr	Z,00154$
                           1198 ;src/Renderer.c:548: if (lateralWallSlopeCounter == lateralWallSlope)
   5035 DD 7E DB      [19] 1199 	ld	a,-37 (ix)
   5038 DD 96 DF      [19] 1200 	sub	a, -33 (ix)
   503B 20 0A         [12] 1201 	jr	NZ,00152$
                           1202 ;src/Renderer.c:550: lateralWallSlopeCounter = 0;
   503D DD 36 DB 00   [19] 1203 	ld	-37 (ix),#0x00
                           1204 ;src/Renderer.c:551: xHeight -= 2;
   5041 DD 35 E2      [23] 1205 	dec	-30 (ix)
   5044 DD 35 E2      [23] 1206 	dec	-30 (ix)
   5047                    1207 00152$:
                           1208 ;src/Renderer.c:553: ++lateralWallSlopeCounter;
   5047 DD 34 DB      [23] 1209 	inc	-37 (ix)
   504A                    1210 00154$:
                           1211 ;src/Renderer.c:555: --lateralWallCounter;
   504A DD 35 E6      [23] 1212 	dec	-26 (ix)
   504D                    1213 00156$:
                           1214 ;src/Renderer.c:559: if (!(x%2))
   504D DD 7E F4      [19] 1215 	ld	a,-12 (ix)
   5050 B7            [ 4] 1216 	or	a, a
   5051 C2 EA 50      [10] 1217 	jp	NZ,00163$
                           1218 ;src/Renderer.c:562: if(xHeight > 0){
   5054 DD 7E E2      [19] 1219 	ld	a,-30 (ix)
   5057 B7            [ 4] 1220 	or	a, a
   5058 CA EA 50      [10] 1221 	jp	Z,00163$
                           1222 ;src/Renderer.c:564: if (lateralWallCounter > 0)
   505B DD 7E E6      [19] 1223 	ld	a,-26 (ix)
   505E B7            [ 4] 1224 	or	a, a
   505F 28 39         [12] 1225 	jr	Z,00158$
                           1226 ;src/Renderer.c:566: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   5061 DD 7E E6      [19] 1227 	ld	a,-26 (ix)
   5064 DD 77 FC      [19] 1228 	ld	-4 (ix),a
   5067 DD 36 FD 00   [19] 1229 	ld	-3 (ix),#0x00
   506B 3E 06         [ 7] 1230 	ld	a,#0x05+1
   506D 18 08         [12] 1231 	jr	00338$
   506F                    1232 00337$:
   506F DD CB FC 26   [23] 1233 	sla	-4 (ix)
   5073 DD CB FD 16   [23] 1234 	rl	-3 (ix)
   5077                    1235 00338$:
   5077 3D            [ 4] 1236 	dec	a
   5078 20 F5         [12] 1237 	jr	NZ,00337$
   507A DD 7E D7      [19] 1238 	ld	a,-41 (ix)
   507D DD 77 FA      [19] 1239 	ld	-6 (ix),a
   5080 DD 36 FB 00   [19] 1240 	ld	-5 (ix),#0x00
   5084 DD 6E FA      [19] 1241 	ld	l,-6 (ix)
   5087 DD 66 FB      [19] 1242 	ld	h,-5 (ix)
   508A E5            [11] 1243 	push	hl
   508B DD 6E FC      [19] 1244 	ld	l,-4 (ix)
   508E DD 66 FD      [19] 1245 	ld	h,-3 (ix)
   5091 E5            [11] 1246 	push	hl
   5092 CD EF 64      [17] 1247 	call	__divsint
   5095 F1            [10] 1248 	pop	af
   5096 F1            [10] 1249 	pop	af
   5097 55            [ 4] 1250 	ld	d,l
   5098 18 3B         [12] 1251 	jr	00159$
   509A                    1252 00158$:
                           1253 ;src/Renderer.c:569: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   509A DD 7E F2      [19] 1254 	ld	a,-14 (ix)
   509D DD 96 E3      [19] 1255 	sub	a, -29 (ix)
   50A0 DD 77 FC      [19] 1256 	ld	-4 (ix),a
   50A3 DD 7E F3      [19] 1257 	ld	a,-13 (ix)
   50A6 DD 9E E4      [19] 1258 	sbc	a, -28 (ix)
   50A9 DD 77 FD      [19] 1259 	ld	-3 (ix),a
   50AC 3E 06         [ 7] 1260 	ld	a,#0x05+1
   50AE 18 08         [12] 1261 	jr	00340$
   50B0                    1262 00339$:
   50B0 DD CB FC 26   [23] 1263 	sla	-4 (ix)
   50B4 DD CB FD 16   [23] 1264 	rl	-3 (ix)
   50B8                    1265 00340$:
   50B8 3D            [ 4] 1266 	dec	a
   50B9 20 F5         [12] 1267 	jr	NZ,00339$
   50BB DD 6E F2      [19] 1268 	ld	l,-14 (ix)
   50BE DD 66 F3      [19] 1269 	ld	h,-13 (ix)
   50C1 E5            [11] 1270 	push	hl
   50C2 DD 6E FC      [19] 1271 	ld	l,-4 (ix)
   50C5 DD 66 FD      [19] 1272 	ld	h,-3 (ix)
   50C8 E5            [11] 1273 	push	hl
   50C9 CD EF 64      [17] 1274 	call	__divsint
   50CC F1            [10] 1275 	pop	af
   50CD F1            [10] 1276 	pop	af
   50CE DD 74 FD      [19] 1277 	ld	-3 (ix),h
   50D1 DD 75 FC      [19] 1278 	ld	-4 (ix), l
   50D4 55            [ 4] 1279 	ld	d, l
   50D5                    1280 00159$:
                           1281 ;src/Renderer.c:572: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   50D5 DD 46 D8      [19] 1282 	ld	b,-40 (ix)
   50D8 CB 38         [ 8] 1283 	srl	b
   50DA D5            [11] 1284 	push	de
   50DB 33            [ 6] 1285 	inc	sp
   50DC DD 66 DE      [19] 1286 	ld	h,-34 (ix)
   50DF DD 6E E2      [19] 1287 	ld	l,-30 (ix)
   50E2 E5            [11] 1288 	push	hl
   50E3 C5            [11] 1289 	push	bc
   50E4 33            [ 6] 1290 	inc	sp
   50E5 CD 0C 4A      [17] 1291 	call	_draw_column_to_buffer
   50E8 F1            [10] 1292 	pop	af
   50E9 F1            [10] 1293 	pop	af
   50EA                    1294 00163$:
                           1295 ;src/Renderer.c:575: ++xCellCount;
   50EA DD 34 DA      [23] 1296 	inc	-38 (ix)
                           1297 ;src/Renderer.c:495: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   50ED DD 35 D8      [23] 1298 	dec	-40 (ix)
   50F0 DD 7E D8      [19] 1299 	ld	a,-40 (ix)
   50F3 D6 50         [ 7] 1300 	sub	a, #0x50
   50F5 D2 61 4E      [10] 1301 	jp	NC,00170$
                           1302 ;src/Renderer.c:582: lineStart = lineStart + (offsetDiff * 2) + 3;
   50F8 DD 7E EC      [19] 1303 	ld	a,-20 (ix)
   50FB C6 03         [ 7] 1304 	add	a, #0x03
   50FD DD 77 D9      [19] 1305 	ld	-39 (ix),a
                           1306 ;src/Renderer.c:583: zHeight += zHeight;
   5100 DD CB D5 26   [23] 1307 	sla	-43 (ix)
                           1308 ;src/Renderer.c:584: offsetDiff = offsetDiff >> 1;
   5104 DD CB E0 3E   [23] 1309 	srl	-32 (ix)
                           1310 ;src/Renderer.c:586: }while(z);
   5108 DD 7E D3      [19] 1311 	ld	a,-45 (ix)
   510B B7            [ 4] 1312 	or	a, a
   510C C2 A7 4B      [10] 1313 	jp	NZ,00165$
   510F DD F9         [10] 1314 	ld	sp, ix
   5111 DD E1         [14] 1315 	pop	ix
   5113 C9            [10] 1316 	ret
                           1317 ;src/Renderer.c:594: void draw_minimap_to_buffer(){
                           1318 ;	---------------------------------
                           1319 ; Function draw_minimap_to_buffer
                           1320 ; ---------------------------------
   5114                    1321 _draw_minimap_to_buffer::
   5114 DD E5         [15] 1322 	push	ix
   5116 DD 21 00 00   [14] 1323 	ld	ix,#0
   511A DD 39         [15] 1324 	add	ix,sp
   511C 21 F5 FF      [10] 1325 	ld	hl,#-11
   511F 39            [11] 1326 	add	hl,sp
   5120 F9            [ 6] 1327 	ld	sp,hl
                           1328 ;src/Renderer.c:597: u8* ptr = MINIMAP_BUFFER;
   5121 01 40 1C      [10] 1329 	ld	bc,#0x1C40
                           1330 ;src/Renderer.c:602: y=(PLAYER_position.y-MINIMAP_HEIGHT_HALF);
   5124 3A 28 48      [13] 1331 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   5127 C6 F8         [ 7] 1332 	add	a,#0xF8
   5129 5F            [ 4] 1333 	ld	e,a
                           1334 ;src/Renderer.c:604: for(j=0;j<MINIMAP_HEIGHT;++j){
   512A 16 00         [ 7] 1335 	ld	d,#0x00
                           1336 ;src/Renderer.c:605: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   512C                    1337 00135$:
   512C 7B            [ 4] 1338 	ld	a,e
   512D 07            [ 4] 1339 	rlca
   512E E6 01         [ 7] 1340 	and	a,#0x01
   5130 DD 77 F9      [19] 1341 	ld	-7 (ix),a
   5133 7B            [ 4] 1342 	ld	a,e
   5134 EE 80         [ 7] 1343 	xor	a, #0x80
   5136 D6 A0         [ 7] 1344 	sub	a, #0xA0
   5138 3E 00         [ 7] 1345 	ld	a,#0x00
   513A 17            [ 4] 1346 	rla
   513B DD 77 F8      [19] 1347 	ld	-8 (ix),a
   513E DD 36 F5 00   [19] 1348 	ld	-11 (ix),#0x00
   5142                    1349 00120$:
                           1350 ;src/Renderer.c:606: x=(PLAYER_position.x-MINIMAP_WIDTH_HALF);
   5142 3A 27 48      [13] 1351 	ld	a, (#_PLAYER_position + 0)
   5145 C6 F8         [ 7] 1352 	add	a,#0xF8
   5147 DD 77 F7      [19] 1353 	ld	-9 (ix),a
                           1354 ;src/Renderer.c:607: for(i=0;i<MINIMAP_WIDTH;++i){
   514A DD 36 F6 00   [19] 1355 	ld	-10 (ix),#0x00
   514E                    1356 00118$:
                           1357 ;src/Renderer.c:610: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   514E FD 21 10 00   [14] 1358 	ld	iy,#0x0010
   5152 FD 09         [15] 1359 	add	iy, bc
                           1360 ;src/Renderer.c:608: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
   5154 DD CB F7 7E   [20] 1361 	bit	7, -9 (ix)
   5158 20 15         [12] 1362 	jr	NZ,00109$
   515A DD 7E F7      [19] 1363 	ld	a,-9 (ix)
   515D EE 80         [ 7] 1364 	xor	a, #0x80
   515F D6 A0         [ 7] 1365 	sub	a, #0xA0
   5161 30 0C         [12] 1366 	jr	NC,00109$
   5163 DD 7E F9      [19] 1367 	ld	a,-7 (ix)
   5166 B7            [ 4] 1368 	or	a, a
   5167 20 06         [12] 1369 	jr	NZ,00109$
   5169 DD CB F8 46   [20] 1370 	bit	0,-8 (ix)
   516D 20 0D         [12] 1371 	jr	NZ,00110$
   516F                    1372 00109$:
                           1373 ;src/Renderer.c:609: *ptr=g_colors[MINIMAP_WALL_COLOR];
   516F 3A F4 49      [13] 1374 	ld	a, (#(_g_colors + 0x0001) + 0)
   5172 02            [ 7] 1375 	ld	(bc),a
                           1376 ;src/Renderer.c:610: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   5173 3A F4 49      [13] 1377 	ld	a, (#(_g_colors + 0x0001) + 0)
   5176 FD 77 00      [19] 1378 	ld	0 (iy), a
   5179 C3 26 52      [10] 1379 	jp	00111$
   517C                    1380 00110$:
                           1381 ;src/Renderer.c:612: else if((x==PLAYER_position.x)&&(y==PLAYER_position.y)){
   517C DD 7E F7      [19] 1382 	ld	a,-9 (ix)
   517F DD 77 FC      [19] 1383 	ld	-4 (ix),a
   5182 DD 7E F7      [19] 1384 	ld	a,-9 (ix)
   5185 17            [ 4] 1385 	rla
   5186 9F            [ 4] 1386 	sbc	a, a
   5187 DD 77 FD      [19] 1387 	ld	-3 (ix),a
   518A 3A 27 48      [13] 1388 	ld	a, (#_PLAYER_position + 0)
   518D DD 77 FA      [19] 1389 	ld	-6 (ix),a
   5190 DD 36 FB 00   [19] 1390 	ld	-5 (ix),#0x00
   5194 DD 73 FE      [19] 1391 	ld	-2 (ix),e
   5197 7B            [ 4] 1392 	ld	a,e
   5198 17            [ 4] 1393 	rla
   5199 9F            [ 4] 1394 	sbc	a, a
   519A DD 77 FF      [19] 1395 	ld	-1 (ix),a
   519D DD 7E FC      [19] 1396 	ld	a,-4 (ix)
   51A0 DD 96 FA      [19] 1397 	sub	a, -6 (ix)
   51A3 20 2E         [12] 1398 	jr	NZ,00106$
   51A5 DD 7E FD      [19] 1399 	ld	a,-3 (ix)
   51A8 DD 96 FB      [19] 1400 	sub	a, -5 (ix)
   51AB 20 26         [12] 1401 	jr	NZ,00106$
   51AD 3A 28 48      [13] 1402 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   51B0 DD 77 FA      [19] 1403 	ld	-6 (ix),a
   51B3 DD 36 FB 00   [19] 1404 	ld	-5 (ix),#0x00
   51B7 DD 7E FE      [19] 1405 	ld	a,-2 (ix)
   51BA DD 96 FA      [19] 1406 	sub	a, -6 (ix)
   51BD 20 14         [12] 1407 	jr	NZ,00106$
   51BF DD 7E FF      [19] 1408 	ld	a,-1 (ix)
   51C2 DD 96 FB      [19] 1409 	sub	a, -5 (ix)
   51C5 20 0C         [12] 1410 	jr	NZ,00106$
                           1411 ;src/Renderer.c:613: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
   51C7 3A F7 49      [13] 1412 	ld	a, (#(_g_colors + 0x0004) + 0)
   51CA 02            [ 7] 1413 	ld	(bc),a
                           1414 ;src/Renderer.c:614: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
   51CB 3A F7 49      [13] 1415 	ld	a, (#(_g_colors + 0x0004) + 0)
   51CE FD 77 00      [19] 1416 	ld	0 (iy), a
   51D1 18 53         [12] 1417 	jr	00111$
   51D3                    1418 00106$:
                           1419 ;src/Renderer.c:617: switch(*(u8*)(MAP_MEM+x+y*MAP_WIDTH)){
   51D3 DD 7E FC      [19] 1420 	ld	a,-4 (ix)
   51D6 C6 40         [ 7] 1421 	add	a, #0x40
   51D8 DD 77 FA      [19] 1422 	ld	-6 (ix),a
   51DB DD 7E FD      [19] 1423 	ld	a,-3 (ix)
   51DE CE 00         [ 7] 1424 	adc	a, #0x00
   51E0 DD 77 FB      [19] 1425 	ld	-5 (ix),a
   51E3 DD 6E FE      [19] 1426 	ld	l,-2 (ix)
   51E6 DD 66 FF      [19] 1427 	ld	h,-1 (ix)
   51E9 29            [11] 1428 	add	hl, hl
   51EA 29            [11] 1429 	add	hl, hl
   51EB 29            [11] 1430 	add	hl, hl
   51EC 29            [11] 1431 	add	hl, hl
   51ED 29            [11] 1432 	add	hl, hl
   51EE DD 7E FA      [19] 1433 	ld	a,-6 (ix)
   51F1 85            [ 4] 1434 	add	a, l
   51F2 6F            [ 4] 1435 	ld	l,a
   51F3 DD 7E FB      [19] 1436 	ld	a,-5 (ix)
   51F6 8C            [ 4] 1437 	adc	a, h
   51F7 67            [ 4] 1438 	ld	h,a
   51F8 6E            [ 7] 1439 	ld	l,(hl)
   51F9 7D            [ 4] 1440 	ld	a,l
   51FA B7            [ 4] 1441 	or	a, a
   51FB 28 07         [12] 1442 	jr	Z,00101$
   51FD 7D            [ 4] 1443 	ld	a,l
   51FE D6 80         [ 7] 1444 	sub	a, #0x80
   5200 28 0E         [12] 1445 	jr	Z,00102$
   5202 18 18         [12] 1446 	jr	00103$
                           1447 ;src/Renderer.c:618: case CELLTYPE_FLOOR:{
   5204                    1448 00101$:
                           1449 ;src/Renderer.c:619: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
   5204 3A F6 49      [13] 1450 	ld	a, (#(_g_colors + 0x0003) + 0)
   5207 02            [ 7] 1451 	ld	(bc),a
                           1452 ;src/Renderer.c:620: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
   5208 3A F6 49      [13] 1453 	ld	a, (#(_g_colors + 0x0003) + 0)
   520B FD 77 00      [19] 1454 	ld	0 (iy), a
                           1455 ;src/Renderer.c:621: break;
   520E 18 16         [12] 1456 	jr	00111$
                           1457 ;src/Renderer.c:623: case CELLTYPE_DOOR:{
   5210                    1458 00102$:
                           1459 ;src/Renderer.c:624: *ptr=g_colors[MINIMAP_EXIT_COLOR];
   5210 3A FB 49      [13] 1460 	ld	a, (#(_g_colors + 0x0008) + 0)
   5213 02            [ 7] 1461 	ld	(bc),a
                           1462 ;src/Renderer.c:625: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
   5214 3A FB 49      [13] 1463 	ld	a, (#(_g_colors + 0x0008) + 0)
   5217 FD 77 00      [19] 1464 	ld	0 (iy), a
                           1465 ;src/Renderer.c:626: break;
   521A 18 0A         [12] 1466 	jr	00111$
                           1467 ;src/Renderer.c:628: default:{
   521C                    1468 00103$:
                           1469 ;src/Renderer.c:629: *ptr=g_colors[MINIMAP_WALL_COLOR];
   521C 3A F4 49      [13] 1470 	ld	a, (#(_g_colors + 0x0001) + 0)
   521F 02            [ 7] 1471 	ld	(bc),a
                           1472 ;src/Renderer.c:630: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   5220 3A F4 49      [13] 1473 	ld	a, (#(_g_colors + 0x0001) + 0)
   5223 FD 77 00      [19] 1474 	ld	0 (iy), a
                           1475 ;src/Renderer.c:633: }
   5226                    1476 00111$:
                           1477 ;src/Renderer.c:635: ++x;
   5226 DD 34 F7      [23] 1478 	inc	-9 (ix)
                           1479 ;src/Renderer.c:636: ++ptr;
   5229 03            [ 6] 1480 	inc	bc
                           1481 ;src/Renderer.c:607: for(i=0;i<MINIMAP_WIDTH;++i){
   522A DD 34 F6      [23] 1482 	inc	-10 (ix)
   522D DD 7E F6      [19] 1483 	ld	a,-10 (ix)
   5230 D6 10         [ 7] 1484 	sub	a, #0x10
   5232 DA 4E 51      [10] 1485 	jp	C,00118$
                           1486 ;src/Renderer.c:605: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   5235 DD 34 F5      [23] 1487 	inc	-11 (ix)
   5238 DD 7E F5      [19] 1488 	ld	a,-11 (ix)
   523B D6 04         [ 7] 1489 	sub	a, #0x04
   523D DA 42 51      [10] 1490 	jp	C,00120$
                           1491 ;src/Renderer.c:639: ++y;
   5240 1C            [ 4] 1492 	inc	e
                           1493 ;src/Renderer.c:604: for(j=0;j<MINIMAP_HEIGHT;++j){
   5241 14            [ 4] 1494 	inc	d
   5242 7A            [ 4] 1495 	ld	a,d
   5243 D6 10         [ 7] 1496 	sub	a, #0x10
   5245 DA 2C 51      [10] 1497 	jp	C,00135$
   5248 DD F9         [10] 1498 	ld	sp, ix
   524A DD E1         [14] 1499 	pop	ix
   524C C9            [10] 1500 	ret
                           1501 	.area _CODE
                           1502 	.area _INITIALIZER
                           1503 	.area _CABS (ABS)
