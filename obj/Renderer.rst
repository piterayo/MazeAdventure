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
   483A                      56 _calculate_cells_in_view::
   483A DD E5         [15]   57 	push	ix
   483C DD 21 00 00   [14]   58 	ld	ix,#0
   4840 DD 39         [15]   59 	add	ix,sp
   4842 21 F2 FF      [10]   60 	ld	hl,#-14
   4845 39            [11]   61 	add	hl,sp
   4846 F9            [ 6]   62 	ld	sp,hl
                             63 ;src/Renderer.c:207: u8 offset=0, n=0, j, i;
   4847 DD 36 FA 00   [19]   64 	ld	-6 (ix),#0x00
   484B DD 36 F9 00   [19]   65 	ld	-7 (ix),#0x00
                             66 ;src/Renderer.c:210: if(PLAYER_direction.y!=0){
   484F 3A 30 48      [13]   67 	ld	a,(#_PLAYER_direction + 1)
   4852 DD 77 FC      [19]   68 	ld	-4 (ix), a
   4855 B7            [ 4]   69 	or	a, a
   4856 28 32         [12]   70 	jr	Z,00102$
                             71 ;src/Renderer.c:211: vert=1;
   4858 DD 36 F2 01   [19]   72 	ld	-14 (ix),#0x01
                             73 ;src/Renderer.c:212: dy=PLAYER_direction.y;
   485C DD 4E FC      [19]   74 	ld	c,-4 (ix)
   485F DD 71 F4      [19]   75 	ld	-12 (ix),c
                             76 ;src/Renderer.c:213: dx=-PLAYER_direction.y;
   4862 AF            [ 4]   77 	xor	a, a
   4863 DD 96 FC      [19]   78 	sub	a, -4 (ix)
   4866 DD 77 F5      [19]   79 	ld	-11 (ix), a
                             80 ;src/Renderer.c:215: x0 = PLAYER_position.x-(17*dx);
   4869 21 2D 48      [10]   81 	ld	hl,#_PLAYER_position+0
   486C 4E            [ 7]   82 	ld	c,(hl)
   486D DD 6E F5      [19]   83 	ld	l,-11 (ix)
   4870 5D            [ 4]   84 	ld	e,l
   4871 29            [11]   85 	add	hl, hl
   4872 29            [11]   86 	add	hl, hl
   4873 29            [11]   87 	add	hl, hl
   4874 29            [11]   88 	add	hl, hl
   4875 19            [11]   89 	add	hl, de
   4876 79            [ 4]   90 	ld	a,c
   4877 95            [ 4]   91 	sub	a, l
   4878 DD 77 F6      [19]   92 	ld	-10 (ix),a
                             93 ;src/Renderer.c:216: y0 = PLAYER_position.y+(6*dy);
   487B 21 2E 48      [10]   94 	ld	hl,#_PLAYER_position+1
   487E 4E            [ 7]   95 	ld	c,(hl)
   487F DD 6E F4      [19]   96 	ld	l,-12 (ix)
   4882 5D            [ 4]   97 	ld	e,l
   4883 29            [11]   98 	add	hl, hl
   4884 19            [11]   99 	add	hl, de
   4885 29            [11]  100 	add	hl, hl
   4886 09            [11]  101 	add	hl, bc
   4887 4D            [ 4]  102 	ld	c,l
   4888 18 34         [12]  103 	jr	00103$
   488A                     104 00102$:
                            105 ;src/Renderer.c:219: vert=0;
   488A DD 36 F2 00   [19]  106 	ld	-14 (ix),#0x00
                            107 ;src/Renderer.c:220: dy=PLAYER_direction.x;
   488E 3A 2F 48      [13]  108 	ld	a,(#_PLAYER_direction + 0)
   4891 DD 77 FC      [19]  109 	ld	-4 (ix), a
   4894 DD 77 F4      [19]  110 	ld	-12 (ix),a
                            111 ;src/Renderer.c:221: dx=PLAYER_direction.x;
   4897 DD 7E FC      [19]  112 	ld	a,-4 (ix)
   489A DD 77 F5      [19]  113 	ld	-11 (ix),a
                            114 ;src/Renderer.c:223: y0 = PLAYER_position.y-(17*dy);
   489D 21 2E 48      [10]  115 	ld	hl, #_PLAYER_position + 1
   48A0 4E            [ 7]  116 	ld	c,(hl)
   48A1 DD 6E F4      [19]  117 	ld	l,-12 (ix)
   48A4 5D            [ 4]  118 	ld	e,l
   48A5 29            [11]  119 	add	hl, hl
   48A6 29            [11]  120 	add	hl, hl
   48A7 29            [11]  121 	add	hl, hl
   48A8 29            [11]  122 	add	hl, hl
   48A9 19            [11]  123 	add	hl, de
   48AA 79            [ 4]  124 	ld	a,c
   48AB 95            [ 4]  125 	sub	a, l
   48AC 4F            [ 4]  126 	ld	c,a
                            127 ;src/Renderer.c:224: x0 = PLAYER_position.x+(6*dx);
   48AD 21 2D 48      [10]  128 	ld	hl, #_PLAYER_position + 0
   48B0 46            [ 7]  129 	ld	b,(hl)
   48B1 DD 7E FC      [19]  130 	ld	a,-4 (ix)
   48B4 5F            [ 4]  131 	ld	e,a
   48B5 87            [ 4]  132 	add	a, a
   48B6 83            [ 4]  133 	add	a, e
   48B7 87            [ 4]  134 	add	a, a
   48B8 5F            [ 4]  135 	ld	e,a
   48B9 68            [ 4]  136 	ld	l,b
   48BA 19            [11]  137 	add	hl, de
   48BB DD 75 F6      [19]  138 	ld	-10 (ix),l
   48BE                     139 00103$:
                            140 ;src/Renderer.c:228: x=x0;
   48BE DD 5E F6      [19]  141 	ld	e,-10 (ix)
                            142 ;src/Renderer.c:229: y=y0;
   48C1 DD 71 F3      [19]  143 	ld	-13 (ix),c
                            144 ;src/Renderer.c:231: for(j=0;j<6;++j){
   48C4 DD 7E F5      [19]  145 	ld	a,-11 (ix)
   48C7 07            [ 4]  146 	rlca
   48C8 E6 01         [ 7]  147 	and	a,#0x01
   48CA DD 77 FC      [19]  148 	ld	-4 (ix),a
   48CD DD 7E F4      [19]  149 	ld	a,-12 (ix)
   48D0 07            [ 4]  150 	rlca
   48D1 E6 01         [ 7]  151 	and	a,#0x01
   48D3 DD 77 FF      [19]  152 	ld	-1 (ix),a
   48D6 DD 36 F8 00   [19]  153 	ld	-8 (ix),#0x00
                            154 ;src/Renderer.c:233: for(i=offset;i<35-offset;++i){
   48DA                     155 00138$:
   48DA DD 7E F9      [19]  156 	ld	a,-7 (ix)
   48DD DD 77 FB      [19]  157 	ld	-5 (ix),a
   48E0 DD 7E FA      [19]  158 	ld	a,-6 (ix)
   48E3 DD 77 F7      [19]  159 	ld	-9 (ix),a
   48E6                     160 00125$:
   48E6 DD 6E FA      [19]  161 	ld	l,-6 (ix)
   48E9 26 00         [ 7]  162 	ld	h,#0x00
   48EB 3E 23         [ 7]  163 	ld	a,#0x23
   48ED 95            [ 4]  164 	sub	a, l
   48EE 6F            [ 4]  165 	ld	l,a
   48EF 3E 00         [ 7]  166 	ld	a,#0x00
   48F1 9C            [ 4]  167 	sbc	a, h
   48F2 67            [ 4]  168 	ld	h,a
   48F3 DD 7E F7      [19]  169 	ld	a, -9 (ix)
   48F6 16 00         [ 7]  170 	ld	d, #0x00
   48F8 95            [ 4]  171 	sub	a, l
   48F9 7A            [ 4]  172 	ld	a,d
   48FA 9C            [ 4]  173 	sbc	a, h
   48FB E2 00 49      [10]  174 	jp	PO, 00181$
   48FE EE 80         [ 7]  175 	xor	a, #0x80
   4900                     176 00181$:
   4900 F2 7F 49      [10]  177 	jp	P,00143$
                            178 ;src/Renderer.c:236: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   4903 2A 0B 4A      [16]  179 	ld	hl,(_cells_in_view_array)
   4906 7D            [ 4]  180 	ld	a,l
   4907 DD 86 FB      [19]  181 	add	a, -5 (ix)
   490A DD 77 FD      [19]  182 	ld	-3 (ix),a
   490D 7C            [ 4]  183 	ld	a,h
   490E CE 00         [ 7]  184 	adc	a, #0x00
   4910 DD 77 FE      [19]  185 	ld	-2 (ix),a
                            186 ;src/Renderer.c:235: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
   4913 CB 7B         [ 8]  187 	bit	7, e
   4915 20 41         [12]  188 	jr	NZ,00105$
   4917 7B            [ 4]  189 	ld	a,e
   4918 EE 80         [ 7]  190 	xor	a, #0x80
   491A D6 A0         [ 7]  191 	sub	a, #0xA0
   491C 30 3A         [12]  192 	jr	NC,00105$
   491E DD CB F3 7E   [20]  193 	bit	7, -13 (ix)
   4922 20 34         [12]  194 	jr	NZ,00105$
   4924 DD 7E F3      [19]  195 	ld	a,-13 (ix)
   4927 EE 80         [ 7]  196 	xor	a, #0x80
   4929 D6 A0         [ 7]  197 	sub	a, #0xA0
   492B 30 2B         [12]  198 	jr	NC,00105$
                            199 ;src/Renderer.c:236: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   492D 7B            [ 4]  200 	ld	a,e
   492E 57            [ 4]  201 	ld	d,a
   492F 17            [ 4]  202 	rla
   4930 9F            [ 4]  203 	sbc	a, a
   4931 6F            [ 4]  204 	ld	l,a
   4932 7A            [ 4]  205 	ld	a,d
   4933 C6 40         [ 7]  206 	add	a, #0x40
   4935 47            [ 4]  207 	ld	b,a
   4936 7D            [ 4]  208 	ld	a,l
   4937 CE 00         [ 7]  209 	adc	a, #0x00
   4939 57            [ 4]  210 	ld	d,a
   493A DD 6E F3      [19]  211 	ld	l,-13 (ix)
   493D DD 7E F3      [19]  212 	ld	a,-13 (ix)
   4940 17            [ 4]  213 	rla
   4941 9F            [ 4]  214 	sbc	a, a
   4942 67            [ 4]  215 	ld	h,a
   4943 29            [11]  216 	add	hl, hl
   4944 29            [11]  217 	add	hl, hl
   4945 29            [11]  218 	add	hl, hl
   4946 29            [11]  219 	add	hl, hl
   4947 29            [11]  220 	add	hl, hl
   4948 78            [ 4]  221 	ld	a,b
   4949 85            [ 4]  222 	add	a, l
   494A 6F            [ 4]  223 	ld	l,a
   494B 7A            [ 4]  224 	ld	a,d
   494C 8C            [ 4]  225 	adc	a, h
   494D 67            [ 4]  226 	ld	h,a
   494E 46            [ 7]  227 	ld	b,(hl)
   494F DD 6E FD      [19]  228 	ld	l,-3 (ix)
   4952 DD 66 FE      [19]  229 	ld	h,-2 (ix)
   4955 70            [ 7]  230 	ld	(hl),b
   4956 18 08         [12]  231 	jr	00106$
   4958                     232 00105$:
                            233 ;src/Renderer.c:239: cells_in_view_array[n]=1;
   4958 DD 6E FD      [19]  234 	ld	l,-3 (ix)
   495B DD 66 FE      [19]  235 	ld	h,-2 (ix)
   495E 36 01         [10]  236 	ld	(hl),#0x01
   4960                     237 00106$:
                            238 ;src/Renderer.c:243: if(vert){
   4960 DD 7E F2      [19]  239 	ld	a,-14 (ix)
   4963 B7            [ 4]  240 	or	a, a
   4964 28 07         [12]  241 	jr	Z,00111$
                            242 ;src/Renderer.c:244: x+=dx;
   4966 7B            [ 4]  243 	ld	a,e
   4967 DD 86 F5      [19]  244 	add	a, -11 (ix)
   496A 5F            [ 4]  245 	ld	e,a
   496B 18 09         [12]  246 	jr	00112$
   496D                     247 00111$:
                            248 ;src/Renderer.c:247: y+=dy;
   496D DD 7E F3      [19]  249 	ld	a,-13 (ix)
   4970 DD 86 F4      [19]  250 	add	a, -12 (ix)
   4973 DD 77 F3      [19]  251 	ld	-13 (ix),a
   4976                     252 00112$:
                            253 ;src/Renderer.c:249: ++n;
   4976 DD 34 FB      [23]  254 	inc	-5 (ix)
                            255 ;src/Renderer.c:233: for(i=offset;i<35-offset;++i){
   4979 DD 34 F7      [23]  256 	inc	-9 (ix)
   497C C3 E6 48      [10]  257 	jp	00125$
   497F                     258 00143$:
   497F DD 7E FB      [19]  259 	ld	a,-5 (ix)
   4982 DD 77 F9      [19]  260 	ld	-7 (ix),a
                            261 ;src/Renderer.c:251: offset=offsets_cells_in_view[j];
   4985 3E 0D         [ 7]  262 	ld	a,#<(_offsets_cells_in_view)
   4987 DD 86 F8      [19]  263 	add	a, -8 (ix)
   498A 6F            [ 4]  264 	ld	l,a
   498B 3E 4A         [ 7]  265 	ld	a,#>(_offsets_cells_in_view)
   498D CE 00         [ 7]  266 	adc	a, #0x00
   498F 67            [ 4]  267 	ld	h,a
   4990 7E            [ 7]  268 	ld	a,(hl)
                            269 ;src/Renderer.c:255: if(dx<0) x=x0-offset;
   4991 DD 77 FA      [19]  270 	ld	-6 (ix), a
   4994 DD 77 FD      [19]  271 	ld	-3 (ix),a
                            272 ;src/Renderer.c:253: if(vert){
   4997 DD 7E F2      [19]  273 	ld	a,-14 (ix)
   499A B7            [ 4]  274 	or	a, a
   499B 28 21         [12]  275 	jr	Z,00121$
                            276 ;src/Renderer.c:254: y-=dy;
   499D DD 7E F3      [19]  277 	ld	a,-13 (ix)
   49A0 DD 96 F4      [19]  278 	sub	a, -12 (ix)
   49A3 DD 77 F3      [19]  279 	ld	-13 (ix),a
                            280 ;src/Renderer.c:255: if(dx<0) x=x0-offset;
   49A6 DD 7E FC      [19]  281 	ld	a,-4 (ix)
   49A9 B7            [ 4]  282 	or	a, a
   49AA 28 09         [12]  283 	jr	Z,00115$
   49AC DD 7E F6      [19]  284 	ld	a,-10 (ix)
   49AF DD 96 FD      [19]  285 	sub	a, -3 (ix)
   49B2 5F            [ 4]  286 	ld	e,a
   49B3 18 24         [12]  287 	jr	00128$
   49B5                     288 00115$:
                            289 ;src/Renderer.c:256: else x=x0+offset;
   49B5 DD 7E F6      [19]  290 	ld	a,-10 (ix)
   49B8 DD 86 FD      [19]  291 	add	a, -3 (ix)
   49BB 5F            [ 4]  292 	ld	e,a
   49BC 18 1B         [12]  293 	jr	00128$
   49BE                     294 00121$:
                            295 ;src/Renderer.c:260: x-=dx;
   49BE 7B            [ 4]  296 	ld	a,e
   49BF DD 96 F5      [19]  297 	sub	a, -11 (ix)
   49C2 5F            [ 4]  298 	ld	e,a
                            299 ;src/Renderer.c:261: if(dy<0) y=y0-offset;
   49C3 DD 7E FF      [19]  300 	ld	a,-1 (ix)
   49C6 B7            [ 4]  301 	or	a, a
   49C7 28 09         [12]  302 	jr	Z,00118$
   49C9 79            [ 4]  303 	ld	a,c
   49CA DD 96 FD      [19]  304 	sub	a, -3 (ix)
   49CD DD 77 F3      [19]  305 	ld	-13 (ix),a
   49D0 18 07         [12]  306 	jr	00128$
   49D2                     307 00118$:
                            308 ;src/Renderer.c:262: else y=y0+offset;
   49D2 79            [ 4]  309 	ld	a,c
   49D3 DD 86 FD      [19]  310 	add	a, -3 (ix)
   49D6 DD 77 F3      [19]  311 	ld	-13 (ix),a
   49D9                     312 00128$:
                            313 ;src/Renderer.c:231: for(j=0;j<6;++j){
   49D9 DD 34 F8      [23]  314 	inc	-8 (ix)
   49DC DD 7E F8      [19]  315 	ld	a,-8 (ix)
   49DF D6 06         [ 7]  316 	sub	a, #0x06
   49E1 DA DA 48      [10]  317 	jp	C,00138$
   49E4 DD F9         [10]  318 	ld	sp, ix
   49E6 DD E1         [14]  319 	pop	ix
   49E8 C9            [10]  320 	ret
   49E9                     321 _g_palette:
   49E9 08                  322 	.db #0x08	; 8
   49EA 00                  323 	.db #0x00	; 0
   49EB 0D                  324 	.db #0x0D	; 13
   49EC 1A                  325 	.db #0x1A	; 26
   49ED 06                  326 	.db #0x06	; 6
   49EE 01                  327 	.db #0x01	; 1
   49EF 09                  328 	.db #0x09	; 9
   49F0 03                  329 	.db #0x03	; 3
   49F1 18                  330 	.db #0x18	; 24
   49F2 12                  331 	.db #0x12	; 18
   49F3 05                  332 	.db #0x05	; 5
   49F4 0E                  333 	.db #0x0E	; 14
   49F5 0F                  334 	.db #0x0F	; 15
   49F6 10                  335 	.db #0x10	; 16
   49F7 11                  336 	.db #0x11	; 17
   49F8 13                  337 	.db #0x13	; 19
   49F9                     338 _g_colors:
   49F9 00                  339 	.db #0x00	; 0
   49FA C0                  340 	.db #0xC0	; 192
   49FB 0C                  341 	.db #0x0C	; 12
   49FC CC                  342 	.db #0xCC	; 204
   49FD 30                  343 	.db #0x30	; 48	'0'
   49FE F0                  344 	.db #0xF0	; 240
   49FF 3C                  345 	.db #0x3C	; 60
   4A00 FC                  346 	.db #0xFC	; 252
   4A01 03                  347 	.db #0x03	; 3
   4A02 C3                  348 	.db #0xC3	; 195
   4A03 0F                  349 	.db #0x0F	; 15
   4A04 CF                  350 	.db #0xCF	; 207
   4A05 33                  351 	.db #0x33	; 51	'3'
   4A06 F3                  352 	.db #0xF3	; 243
   4A07 3F                  353 	.db #0x3F	; 63
   4A08 FF                  354 	.db #0xFF	; 255
   4A09                     355 _pixelMask:
   4A09 AA                  356 	.db #0xAA	; 170
   4A0A 55                  357 	.db #0x55	; 85	'U'
   4A0B                     358 _cells_in_view_array:
   4A0B E0 3A               359 	.dw #0x3AE0
   4A0D                     360 _offsets_cells_in_view:
   4A0D 08                  361 	.db #0x08	; 8
   4A0E 0C                  362 	.db #0x0C	; 12
   4A0F 0E                  363 	.db #0x0E	; 14
   4A10 0F                  364 	.db #0x0F	; 15
   4A11 10                  365 	.db #0x10	; 16
                            366 ;src/Renderer.c:268: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
                            367 ;	---------------------------------
                            368 ; Function draw_column_to_buffer
                            369 ; ---------------------------------
   4A12                     370 _draw_column_to_buffer::
   4A12 DD E5         [15]  371 	push	ix
   4A14 DD 21 00 00   [14]  372 	ld	ix,#0
   4A18 DD 39         [15]  373 	add	ix,sp
   4A1A 21 EF FF      [10]  374 	ld	hl,#-17
   4A1D 39            [11]  375 	add	hl,sp
   4A1E F9            [ 6]  376 	ld	sp,hl
                            377 ;src/Renderer.c:269: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   4A1F DD 7E 04      [19]  378 	ld	a,4 (ix)
   4A22 CB 3F         [ 8]  379 	srl	a
   4A24 C6 40         [ 7]  380 	add	a, #0x40
   4A26 DD 77 FA      [19]  381 	ld	-6 (ix),a
   4A29 3E 00         [ 7]  382 	ld	a,#0x00
   4A2B CE 2B         [ 7]  383 	adc	a, #0x2B
   4A2D DD 77 FB      [19]  384 	ld	-5 (ix),a
                            385 ;src/Renderer.c:271: u8 w_color, start=0,end=SCREEN_TEXTURE_HEIGHT;
   4A30 DD 36 F8 00   [19]  386 	ld	-8 (ix),#0x00
   4A34 DD 36 F9 64   [19]  387 	ld	-7 (ix),#0x64
                            388 ;src/Renderer.c:272: u8 pixMask = pixelMask[column&1];
   4A38 01 09 4A      [10]  389 	ld	bc,#_pixelMask+0
   4A3B DD 7E 04      [19]  390 	ld	a,4 (ix)
   4A3E E6 01         [ 7]  391 	and	a, #0x01
   4A40 6F            [ 4]  392 	ld	l, a
   4A41 26 00         [ 7]  393 	ld	h,#0x00
   4A43 09            [11]  394 	add	hl,bc
   4A44 7E            [ 7]  395 	ld	a,(hl)
   4A45 DD 77 F7      [19]  396 	ld	-9 (ix),a
                            397 ;src/Renderer.c:279: u8* texture = (u8*)(UNCOMPRESSED_SHARED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
   4A48 DD 7E 06      [19]  398 	ld	a, 6 (ix)
   4A4B 87            [ 4]  399 	add	a, a
   4A4C 87            [ 4]  400 	add	a, a
   4A4D 47            [ 4]  401 	ld	b,a
   4A4E 0E 00         [ 7]  402 	ld	c,#0x00
   4A50 21 40 04      [10]  403 	ld	hl,#0x0440
   4A53 09            [11]  404 	add	hl,bc
   4A54 4D            [ 4]  405 	ld	c,l
   4A55 44            [ 4]  406 	ld	b,h
   4A56 DD 6E 07      [19]  407 	ld	l,7 (ix)
   4A59 26 00         [ 7]  408 	ld	h,#0x00
   4A5B 29            [11]  409 	add	hl, hl
   4A5C 29            [11]  410 	add	hl, hl
   4A5D 29            [11]  411 	add	hl, hl
   4A5E 29            [11]  412 	add	hl, hl
   4A5F 29            [11]  413 	add	hl, hl
   4A60 09            [11]  414 	add	hl,bc
   4A61 DD 75 F0      [19]  415 	ld	-16 (ix),l
   4A64 DD 74 F1      [19]  416 	ld	-15 (ix),h
                            417 ;src/Renderer.c:287: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
   4A67 DD 7E 05      [19]  418 	ld	a,5 (ix)
   4A6A DD 77 FE      [19]  419 	ld	-2 (ix),a
   4A6D DD 36 FF 00   [19]  420 	ld	-1 (ix),#0x00
   4A71 DD 6E FE      [19]  421 	ld	l,-2 (ix)
   4A74 DD 66 FF      [19]  422 	ld	h,-1 (ix)
   4A77 E5            [11]  423 	push	hl
   4A78 21 00 20      [10]  424 	ld	hl,#0x2000
   4A7B E5            [11]  425 	push	hl
   4A7C CD 4A 64      [17]  426 	call	__divsint
   4A7F F1            [10]  427 	pop	af
   4A80 F1            [10]  428 	pop	af
   4A81 DD 75 F3      [19]  429 	ld	-13 (ix),l
   4A84 DD 74 F4      [19]  430 	ld	-12 (ix),h
                            431 ;src/Renderer.c:288: u16 wall_texture_line=0;
   4A87 DD 36 F5 00   [19]  432 	ld	-11 (ix),#0x00
   4A8B DD 36 F6 00   [19]  433 	ld	-10 (ix),#0x00
                            434 ;src/Renderer.c:293: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   4A8F DD 4E 05      [19]  435 	ld	c,5 (ix)
   4A92 CB 39         [ 8]  436 	srl	c
   4A94 3E 32         [ 7]  437 	ld	a,#0x32
   4A96 91            [ 4]  438 	sub	a, c
                            439 ;src/Renderer.c:294: ground_height = ceiling_height + lineHeight;
   4A97 4F            [ 4]  440 	ld	c,a
   4A98 DD 86 05      [19]  441 	add	a, 5 (ix)
   4A9B DD 77 F2      [19]  442 	ld	-14 (ix),a
                            443 ;src/Renderer.c:297: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   4A9E 3E 64         [ 7]  444 	ld	a,#0x64
   4AA0 DD 96 05      [19]  445 	sub	a, 5 (ix)
   4AA3 30 55         [12]  446 	jr	NC,00118$
                            447 ;src/Renderer.c:298: start=(lineHeight-SCREEN_TEXTURE_HEIGHT)/2;
   4AA5 DD 7E FE      [19]  448 	ld	a,-2 (ix)
   4AA8 C6 9C         [ 7]  449 	add	a,#0x9C
   4AAA 4F            [ 4]  450 	ld	c,a
   4AAB DD 7E FF      [19]  451 	ld	a,-1 (ix)
   4AAE CE FF         [ 7]  452 	adc	a,#0xFF
   4AB0 47            [ 4]  453 	ld	b,a
   4AB1 DD 71 FC      [19]  454 	ld	-4 (ix),c
   4AB4 DD 70 FD      [19]  455 	ld	-3 (ix),b
   4AB7 CB 78         [ 8]  456 	bit	7, b
   4AB9 28 10         [12]  457 	jr	Z,00112$
   4ABB DD 7E FE      [19]  458 	ld	a,-2 (ix)
   4ABE C6 9D         [ 7]  459 	add	a, #0x9D
   4AC0 DD 77 FC      [19]  460 	ld	-4 (ix),a
   4AC3 DD 7E FF      [19]  461 	ld	a,-1 (ix)
   4AC6 CE FF         [ 7]  462 	adc	a, #0xFF
   4AC8 DD 77 FD      [19]  463 	ld	-3 (ix),a
   4ACB                     464 00112$:
   4ACB DD 4E FC      [19]  465 	ld	c,-4 (ix)
   4ACE DD 46 FD      [19]  466 	ld	b,-3 (ix)
   4AD1 CB 28         [ 8]  467 	sra	b
   4AD3 CB 19         [ 8]  468 	rr	c
                            469 ;src/Renderer.c:299: end+=start;
   4AD5 DD 71 F8      [19]  470 	ld	-8 (ix), c
   4AD8 79            [ 4]  471 	ld	a, c
   4AD9 C6 64         [ 7]  472 	add	a, #0x64
   4ADB DD 77 F9      [19]  473 	ld	-7 (ix),a
                            474 ;src/Renderer.c:300: ceiling_height=0;
   4ADE 0E 00         [ 7]  475 	ld	c,#0x00
                            476 ;src/Renderer.c:301: wall_texture_line = start * wall_texture_line_add;
   4AE0 DD 5E F8      [19]  477 	ld	e,-8 (ix)
   4AE3 16 00         [ 7]  478 	ld	d,#0x00
   4AE5 C5            [11]  479 	push	bc
   4AE6 DD 6E F3      [19]  480 	ld	l,-13 (ix)
   4AE9 DD 66 F4      [19]  481 	ld	h,-12 (ix)
   4AEC E5            [11]  482 	push	hl
   4AED D5            [11]  483 	push	de
   4AEE CD 94 63      [17]  484 	call	__mulint
   4AF1 F1            [10]  485 	pop	af
   4AF2 F1            [10]  486 	pop	af
   4AF3 C1            [10]  487 	pop	bc
   4AF4 DD 75 F5      [19]  488 	ld	-11 (ix),l
   4AF7 DD 74 F6      [19]  489 	ld	-10 (ix),h
                            490 ;src/Renderer.c:306: for(j=start;j<end;++j){
   4AFA                     491 00118$:
   4AFA DD 7E F7      [19]  492 	ld	a,-9 (ix)
   4AFD 2F            [ 4]  493 	cpl
   4AFE DD 77 FC      [19]  494 	ld	-4 (ix),a
   4B01 DD 5E FA      [19]  495 	ld	e,-6 (ix)
   4B04 DD 56 FB      [19]  496 	ld	d,-5 (ix)
   4B07 DD 46 F8      [19]  497 	ld	b,-8 (ix)
   4B0A                     498 00108$:
   4B0A 78            [ 4]  499 	ld	a,b
   4B0B DD 96 F9      [19]  500 	sub	a, -7 (ix)
   4B0E 30 41         [12]  501 	jr	NC,00110$
                            502 ;src/Renderer.c:307: val =  ((*pvmem)&(~pixMask));
   4B10 1A            [ 7]  503 	ld	a,(de)
   4B11 DD A6 FC      [19]  504 	and	a, -4 (ix)
   4B14 DD 77 EF      [19]  505 	ld	-17 (ix),a
                            506 ;src/Renderer.c:309: if((j>=ceiling_height) && (j<ground_height)){
   4B17 78            [ 4]  507 	ld	a,b
   4B18 B9            [ 4]  508 	cp	a,c
   4B19 38 2E         [12]  509 	jr	C,00104$
   4B1B DD 96 F2      [19]  510 	sub	a, -14 (ix)
   4B1E 30 29         [12]  511 	jr	NC,00104$
                            512 ;src/Renderer.c:311: w_color = (*(texture+(wall_texture_line/256))&pixMask);
   4B20 DD 6E F6      [19]  513 	ld	l,-10 (ix)
   4B23 26 00         [ 7]  514 	ld	h,#0x00
   4B25 DD 7E F0      [19]  515 	ld	a,-16 (ix)
   4B28 85            [ 4]  516 	add	a, l
   4B29 6F            [ 4]  517 	ld	l,a
   4B2A DD 7E F1      [19]  518 	ld	a,-15 (ix)
   4B2D 8C            [ 4]  519 	adc	a, h
   4B2E 67            [ 4]  520 	ld	h,a
   4B2F 7E            [ 7]  521 	ld	a,(hl)
   4B30 DD A6 F7      [19]  522 	and	a, -9 (ix)
                            523 ;src/Renderer.c:313: *pvmem = val|w_color;
   4B33 DD B6 EF      [19]  524 	or	a, -17 (ix)
   4B36 12            [ 7]  525 	ld	(de),a
                            526 ;src/Renderer.c:315: wall_texture_line += wall_texture_line_add;
   4B37 DD 7E F5      [19]  527 	ld	a,-11 (ix)
   4B3A DD 86 F3      [19]  528 	add	a, -13 (ix)
   4B3D DD 77 F5      [19]  529 	ld	-11 (ix),a
   4B40 DD 7E F6      [19]  530 	ld	a,-10 (ix)
   4B43 DD 8E F4      [19]  531 	adc	a, -12 (ix)
   4B46 DD 77 F6      [19]  532 	ld	-10 (ix),a
   4B49                     533 00104$:
                            534 ;src/Renderer.c:317: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   4B49 21 28 00      [10]  535 	ld	hl,#0x0028
   4B4C 19            [11]  536 	add	hl,de
   4B4D EB            [ 4]  537 	ex	de,hl
                            538 ;src/Renderer.c:306: for(j=start;j<end;++j){
   4B4E 04            [ 4]  539 	inc	b
   4B4F 18 B9         [12]  540 	jr	00108$
   4B51                     541 00110$:
   4B51 DD F9         [10]  542 	ld	sp, ix
   4B53 DD E1         [14]  543 	pop	ix
   4B55 C9            [10]  544 	ret
                            545 ;src/Renderer.c:321: void render_draw_to_buffer(){//TODO Optimize
                            546 ;	---------------------------------
                            547 ; Function render_draw_to_buffer
                            548 ; ---------------------------------
   4B56                     549 _render_draw_to_buffer::
   4B56 DD E5         [15]  550 	push	ix
   4B58 DD 21 00 00   [14]  551 	ld	ix,#0
   4B5C DD 39         [15]  552 	add	ix,sp
   4B5E 21 D3 FF      [10]  553 	ld	hl,#-45
   4B61 39            [11]  554 	add	hl,sp
   4B62 F9            [ 6]  555 	ld	sp,hl
                            556 ;src/Renderer.c:331: u8 zHeight = 5;
   4B63 DD 36 D7 05   [19]  557 	ld	-41 (ix),#0x05
                            558 ;src/Renderer.c:337: u8 offsetDiff = 16;
   4B67 DD 36 DE 10   [19]  559 	ld	-34 (ix),#0x10
                            560 ;src/Renderer.c:342: u8 lineStart = 0;
   4B6B DD 36 DD 00   [19]  561 	ld	-35 (ix),#0x00
                            562 ;src/Renderer.c:344: u8 lateralWallWidth=0;
   4B6F DD 36 DC 00   [19]  563 	ld	-36 (ix),#0x00
                            564 ;src/Renderer.c:356: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   4B73 21 FE 49      [10]  565 	ld	hl, #_g_colors + 5
   4B76 46            [ 7]  566 	ld	b,(hl)
   4B77 21 A8 07      [10]  567 	ld	hl,#0x07A8
   4B7A E5            [11]  568 	push	hl
   4B7B C5            [11]  569 	push	bc
   4B7C 33            [ 6]  570 	inc	sp
   4B7D 21 40 2B      [10]  571 	ld	hl,#0x2B40
   4B80 E5            [11]  572 	push	hl
   4B81 CD 2B 64      [17]  573 	call	_cpct_memset
                            574 ;src/Renderer.c:357: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
   4B84 21 FA 49      [10]  575 	ld	hl, #_g_colors + 1
   4B87 46            [ 7]  576 	ld	b,(hl)
   4B88 21 50 00      [10]  577 	ld	hl,#0x0050
   4B8B E5            [11]  578 	push	hl
   4B8C C5            [11]  579 	push	bc
   4B8D 33            [ 6]  580 	inc	sp
   4B8E 21 E8 32      [10]  581 	ld	hl,#0x32E8
   4B91 E5            [11]  582 	push	hl
   4B92 CD 2B 64      [17]  583 	call	_cpct_memset
                            584 ;src/Renderer.c:358: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   4B95 21 FF 49      [10]  585 	ld	hl, #_g_colors + 6
   4B98 46            [ 7]  586 	ld	b,(hl)
   4B99 21 A8 07      [10]  587 	ld	hl,#0x07A8
   4B9C E5            [11]  588 	push	hl
   4B9D C5            [11]  589 	push	bc
   4B9E 33            [ 6]  590 	inc	sp
   4B9F 21 38 33      [10]  591 	ld	hl,#0x3338
   4BA2 E5            [11]  592 	push	hl
   4BA3 CD 2B 64      [17]  593 	call	_cpct_memset
                            594 ;src/Renderer.c:360: calculate_cells_in_view();
   4BA6 CD 3A 48      [17]  595 	call	_calculate_cells_in_view
                            596 ;src/Renderer.c:363: do{
   4BA9 DD 36 D4 06   [19]  597 	ld	-44 (ix),#0x06
   4BAD                     598 00165$:
                            599 ;src/Renderer.c:365: --z;
   4BAD DD 35 D4      [23]  600 	dec	-44 (ix)
                            601 ;src/Renderer.c:369: xCellCount = (z) ? (zHeight >> 1) : 0;
   4BB0 DD 7E D7      [19]  602 	ld	a,-41 (ix)
   4BB3 CB 3F         [ 8]  603 	srl	a
   4BB5 DD 77 F1      [19]  604 	ld	-15 (ix),a
   4BB8 DD 7E D4      [19]  605 	ld	a,-44 (ix)
   4BBB B7            [ 4]  606 	or	a, a
   4BBC 28 05         [12]  607 	jr	Z,00174$
   4BBE DD 4E F1      [19]  608 	ld	c,-15 (ix)
   4BC1 18 02         [12]  609 	jr	00175$
   4BC3                     610 00174$:
   4BC3 0E 00         [ 7]  611 	ld	c,#0x00
   4BC5                     612 00175$:
   4BC5 DD 71 F6      [19]  613 	ld	-10 (ix),c
                            614 ;src/Renderer.c:370: lateralWallSlope=0;
   4BC8 DD 36 F7 00   [19]  615 	ld	-9 (ix),#0x00
                            616 ;src/Renderer.c:371: lateralWallSlopeCounter=0;
   4BCC DD 36 F0 00   [19]  617 	ld	-16 (ix),#0x00
                            618 ;src/Renderer.c:372: xHeight=0;
   4BD0 DD 36 E5 00   [19]  619 	ld	-27 (ix),#0x00
                            620 ;src/Renderer.c:374: lateralWallCounter = 0;
   4BD4 DD 36 E6 00   [19]  621 	ld	-26 (ix),#0x00
                            622 ;src/Renderer.c:376: newCell=1;
   4BD8 DD 36 E9 01   [19]  623 	ld	-23 (ix),#0x01
                            624 ;src/Renderer.c:377: currentCellID = cells_in_view_array[lineStart + 1];
   4BDC DD 7E DD      [19]  625 	ld	a,-35 (ix)
   4BDF DD 77 EA      [19]  626 	ld	-22 (ix),a
   4BE2 DD 36 EB 00   [19]  627 	ld	-21 (ix),#0x00
   4BE6 DD 4E EA      [19]  628 	ld	c,-22 (ix)
   4BE9 DD 46 EB      [19]  629 	ld	b,-21 (ix)
   4BEC 03            [ 6]  630 	inc	bc
   4BED 2A 0B 4A      [16]  631 	ld	hl,(_cells_in_view_array)
   4BF0 DD 75 EC      [19]  632 	ld	-20 (ix),l
   4BF3 DD 74 ED      [19]  633 	ld	-19 (ix),h
   4BF6 DD 6E EC      [19]  634 	ld	l,-20 (ix)
   4BF9 DD 66 ED      [19]  635 	ld	h,-19 (ix)
   4BFC 09            [11]  636 	add	hl,bc
   4BFD 7E            [ 7]  637 	ld	a,(hl)
   4BFE DD 77 F2      [19]  638 	ld	-14 (ix),a
                            639 ;src/Renderer.c:379: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   4C01 DD 7E EC      [19]  640 	ld	a,-20 (ix)
   4C04 DD 86 DD      [19]  641 	add	a, -35 (ix)
   4C07 6F            [ 4]  642 	ld	l,a
   4C08 DD 7E ED      [19]  643 	ld	a,-19 (ix)
   4C0B CE 00         [ 7]  644 	adc	a, #0x00
   4C0D 67            [ 4]  645 	ld	h,a
   4C0E 7E            [ 7]  646 	ld	a,(hl)
                            647 ;src/Renderer.c:380: if(lastCellWasWall<5){
   4C0F DD 77 F5      [19]  648 	ld	-11 (ix), a
   4C12 D6 05         [ 7]  649 	sub	a, #0x05
   4C14 30 06         [12]  650 	jr	NC,00102$
                            651 ;src/Renderer.c:381: lastWallId=lastCellWasWall;
                            652 ;src/Renderer.c:382: lastCellWasWall=1;
   4C16 DD 36 F8 01   [19]  653 	ld	-8 (ix),#0x01
   4C1A 18 08         [12]  654 	jr	00193$
   4C1C                     655 00102$:
                            656 ;src/Renderer.c:385: lastCellWasWall=0;
   4C1C DD 36 F8 00   [19]  657 	ld	-8 (ix),#0x00
                            658 ;src/Renderer.c:386: lastWallId=CELLTYPE_FLOOR;
   4C20 DD 36 F5 FE   [19]  659 	ld	-11 (ix),#0xFE
                            660 ;src/Renderer.c:389: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   4C24                     661 00193$:
   4C24 DD 36 D6 00   [19]  662 	ld	-42 (ix),#0x00
   4C28 DD 36 E2 00   [19]  663 	ld	-30 (ix),#0x00
   4C2C                     664 00168$:
                            665 ;src/Renderer.c:391: if (xCellCount == zHeight)
   4C2C DD 7E D7      [19]  666 	ld	a,-41 (ix)
   4C2F DD 96 F6      [19]  667 	sub	a, -10 (ix)
   4C32 20 4B         [12]  668 	jr	NZ,00105$
                            669 ;src/Renderer.c:393: ++xCell;
   4C34 DD 34 D6      [23]  670 	inc	-42 (ix)
                            671 ;src/Renderer.c:394: xCellCount = 0;
   4C37 DD 36 F6 00   [19]  672 	ld	-10 (ix),#0x00
                            673 ;src/Renderer.c:395: newCell=1;
   4C3B DD 36 E9 01   [19]  674 	ld	-23 (ix),#0x01
                            675 ;src/Renderer.c:396: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   4C3F DD 7E D6      [19]  676 	ld	a,-42 (ix)
   4C42 DD 77 F9      [19]  677 	ld	-7 (ix),a
   4C45 DD 36 FA 00   [19]  678 	ld	-6 (ix),#0x00
   4C49 DD 7E EA      [19]  679 	ld	a,-22 (ix)
   4C4C DD 86 F9      [19]  680 	add	a, -7 (ix)
   4C4F DD 77 F9      [19]  681 	ld	-7 (ix),a
   4C52 DD 7E EB      [19]  682 	ld	a,-21 (ix)
   4C55 DD 8E FA      [19]  683 	adc	a, -6 (ix)
   4C58 DD 77 FA      [19]  684 	ld	-6 (ix),a
   4C5B DD 34 F9      [23]  685 	inc	-7 (ix)
   4C5E 20 03         [12]  686 	jr	NZ,00320$
   4C60 DD 34 FA      [23]  687 	inc	-6 (ix)
   4C63                     688 00320$:
   4C63 DD 7E F9      [19]  689 	ld	a,-7 (ix)
   4C66 DD 86 EC      [19]  690 	add	a, -20 (ix)
   4C69 DD 77 F9      [19]  691 	ld	-7 (ix),a
   4C6C DD 7E FA      [19]  692 	ld	a,-6 (ix)
   4C6F DD 8E ED      [19]  693 	adc	a, -19 (ix)
   4C72 DD 77 FA      [19]  694 	ld	-6 (ix),a
   4C75 DD 6E F9      [19]  695 	ld	l,-7 (ix)
   4C78 DD 66 FA      [19]  696 	ld	h,-6 (ix)
   4C7B 7E            [ 7]  697 	ld	a,(hl)
   4C7C DD 77 F2      [19]  698 	ld	-14 (ix),a
   4C7F                     699 00105$:
                            700 ;src/Renderer.c:398: if(!(x%2)){
   4C7F DD 7E E2      [19]  701 	ld	a,-30 (ix)
   4C82 E6 01         [ 7]  702 	and	a, #0x01
   4C84 DD 77 F9      [19]  703 	ld	-7 (ix),a
                            704 ;src/Renderer.c:420: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4C87 DD 7E F6      [19]  705 	ld	a,-10 (ix)
   4C8A DD 77 FB      [19]  706 	ld	-5 (ix),a
   4C8D DD 36 FC 00   [19]  707 	ld	-4 (ix),#0x00
   4C91 DD 7E D7      [19]  708 	ld	a,-41 (ix)
   4C94 DD 77 FD      [19]  709 	ld	-3 (ix),a
                            710 ;src/Renderer.c:398: if(!(x%2)){
   4C97 DD 7E F9      [19]  711 	ld	a,-7 (ix)
   4C9A B7            [ 4]  712 	or	a, a
   4C9B C2 4B 4D      [10]  713 	jp	NZ,00118$
                            714 ;src/Renderer.c:399: if ((lateralWallCounter == 0)||newCell)
   4C9E DD 7E E6      [19]  715 	ld	a,-26 (ix)
   4CA1 B7            [ 4]  716 	or	a, a
   4CA2 28 07         [12]  717 	jr	Z,00114$
   4CA4 DD 7E E9      [19]  718 	ld	a,-23 (ix)
   4CA7 B7            [ 4]  719 	or	a, a
   4CA8 CA 4B 4D      [10]  720 	jp	Z,00118$
   4CAB                     721 00114$:
                            722 ;src/Renderer.c:401: if (currentCellID < 5)//Wall
   4CAB DD 7E F2      [19]  723 	ld	a,-14 (ix)
   4CAE D6 05         [ 7]  724 	sub	a, #0x05
   4CB0 30 20         [12]  725 	jr	NC,00112$
                            726 ;src/Renderer.c:403: lateralWallCounter = 0;//(zHeight - xCellCount);
   4CB2 DD 36 E6 00   [19]  727 	ld	-26 (ix),#0x00
                            728 ;src/Renderer.c:404: lateralWallSlope = 0;
   4CB6 DD 36 F7 00   [19]  729 	ld	-9 (ix),#0x00
                            730 ;src/Renderer.c:405: xHeight = zHeight;
   4CBA DD 7E D7      [19]  731 	ld	a,-41 (ix)
   4CBD DD 77 E5      [19]  732 	ld	-27 (ix),a
                            733 ;src/Renderer.c:406: color = currentCellID;
   4CC0 DD 7E F2      [19]  734 	ld	a,-14 (ix)
   4CC3 DD 77 D5      [19]  735 	ld	-43 (ix),a
                            736 ;src/Renderer.c:407: lastCellWasWall = 1;
   4CC6 DD 36 F8 01   [19]  737 	ld	-8 (ix),#0x01
                            738 ;src/Renderer.c:408: lastWallId=currentCellID;
   4CCA DD 7E F2      [19]  739 	ld	a,-14 (ix)
   4CCD DD 77 F5      [19]  740 	ld	-11 (ix),a
   4CD0 18 75         [12]  741 	jr	00113$
   4CD2                     742 00112$:
                            743 ;src/Renderer.c:410: else if(lateralWallCounter==0){//Lateral wall not finished
   4CD2 DD 7E E6      [19]  744 	ld	a,-26 (ix)
   4CD5 B7            [ 4]  745 	or	a, a
   4CD6 20 6F         [12]  746 	jr	NZ,00113$
                            747 ;src/Renderer.c:411: if (lastCellWasWall)
   4CD8 DD 7E F8      [19]  748 	ld	a,-8 (ix)
   4CDB B7            [ 4]  749 	or	a, a
   4CDC 28 59         [12]  750 	jr	Z,00107$
                            751 ;src/Renderer.c:414: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   4CDE DD 7E DE      [19]  752 	ld	a,-34 (ix)
   4CE1 DD 96 D6      [19]  753 	sub	a, -42 (ix)
   4CE4 87            [ 4]  754 	add	a, a
   4CE5 3C            [ 4]  755 	inc	a
                            756 ;src/Renderer.c:415: lateralWallSlopeCounter = lateralWallSlope / 2;
   4CE6 DD 77 F7      [19]  757 	ld	-9 (ix), a
   4CE9 CB 3F         [ 8]  758 	srl	a
   4CEB DD 77 F0      [19]  759 	ld	-16 (ix),a
                            760 ;src/Renderer.c:416: lateralWallCounter = lateralWallSlope * zHeight;
   4CEE DD 5E D7      [19]  761 	ld	e,-41 (ix)
   4CF1 DD 66 F7      [19]  762 	ld	h,-9 (ix)
   4CF4 2E 00         [ 7]  763 	ld	l, #0x00
   4CF6 55            [ 4]  764 	ld	d, l
   4CF7 06 08         [ 7]  765 	ld	b, #0x08
   4CF9                     766 00321$:
   4CF9 29            [11]  767 	add	hl,hl
   4CFA 30 01         [12]  768 	jr	NC,00322$
   4CFC 19            [11]  769 	add	hl,de
   4CFD                     770 00322$:
   4CFD 10 FA         [13]  771 	djnz	00321$
                            772 ;src/Renderer.c:417: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   4CFF 7D            [ 4]  773 	ld	a,l
   4D00 E6 FC         [ 7]  774 	and	a, #0xFC
   4D02 CB C7         [ 8]  775 	set	0, a
   4D04 CB 3F         [ 8]  776 	srl	a
   4D06 CB 3F         [ 8]  777 	srl	a
   4D08 DD 96 F6      [19]  778 	sub	a, -10 (ix)
                            779 ;src/Renderer.c:418: lateralWallWidth=lateralWallCounter;
   4D0B DD 77 E6      [19]  780 	ld	-26 (ix), a
   4D0E DD 77 DC      [19]  781 	ld	-36 (ix),a
                            782 ;src/Renderer.c:419: lastCellWasWall = 0;
   4D11 DD 36 F8 00   [19]  783 	ld	-8 (ix),#0x00
                            784 ;src/Renderer.c:420: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4D15 DD 6E FB      [19]  785 	ld	l,-5 (ix)
   4D18 DD 66 FC      [19]  786 	ld	h,-4 (ix)
   4D1B 29            [11]  787 	add	hl, hl
   4D1C DD 4E F7      [19]  788 	ld	c,-9 (ix)
   4D1F 06 00         [ 7]  789 	ld	b,#0x00
   4D21 C5            [11]  790 	push	bc
   4D22 E5            [11]  791 	push	hl
   4D23 CD 4A 64      [17]  792 	call	__divsint
   4D26 F1            [10]  793 	pop	af
   4D27 F1            [10]  794 	pop	af
   4D28 DD 7E FD      [19]  795 	ld	a,-3 (ix)
   4D2B 95            [ 4]  796 	sub	a, l
   4D2C DD 77 E5      [19]  797 	ld	-27 (ix),a
                            798 ;src/Renderer.c:421: color = lastWallId;
   4D2F DD 7E F5      [19]  799 	ld	a,-11 (ix)
   4D32 DD 77 D5      [19]  800 	ld	-43 (ix),a
   4D35 18 10         [12]  801 	jr	00113$
   4D37                     802 00107$:
                            803 ;src/Renderer.c:425: xHeight = 0;
   4D37 DD 36 E5 00   [19]  804 	ld	-27 (ix),#0x00
                            805 ;src/Renderer.c:426: lastCellWasWall = 0;
   4D3B DD 36 F8 00   [19]  806 	ld	-8 (ix),#0x00
                            807 ;src/Renderer.c:427: lateralWallSlope=0;
   4D3F DD 36 F7 00   [19]  808 	ld	-9 (ix),#0x00
                            809 ;src/Renderer.c:428: lastWallId=0;
   4D43 DD 36 F5 00   [19]  810 	ld	-11 (ix),#0x00
   4D47                     811 00113$:
                            812 ;src/Renderer.c:432: newCell=0;
   4D47 DD 36 E9 00   [19]  813 	ld	-23 (ix),#0x00
   4D4B                     814 00118$:
                            815 ;src/Renderer.c:435: if (lateralWallCounter > 0)
   4D4B DD 7E E6      [19]  816 	ld	a,-26 (ix)
   4D4E B7            [ 4]  817 	or	a, a
   4D4F 28 1E         [12]  818 	jr	Z,00124$
                            819 ;src/Renderer.c:438: if (lateralWallSlope != 0)
   4D51 DD 7E F7      [19]  820 	ld	a,-9 (ix)
   4D54 B7            [ 4]  821 	or	a, a
   4D55 28 15         [12]  822 	jr	Z,00122$
                            823 ;src/Renderer.c:440: if (lateralWallSlopeCounter == lateralWallSlope)
   4D57 DD 7E F7      [19]  824 	ld	a,-9 (ix)
   4D5A DD 96 F0      [19]  825 	sub	a, -16 (ix)
   4D5D 20 0A         [12]  826 	jr	NZ,00120$
                            827 ;src/Renderer.c:442: lateralWallSlopeCounter = 0;
   4D5F DD 36 F0 00   [19]  828 	ld	-16 (ix),#0x00
                            829 ;src/Renderer.c:443: xHeight -= 2;
   4D63 DD 35 E5      [23]  830 	dec	-27 (ix)
   4D66 DD 35 E5      [23]  831 	dec	-27 (ix)
   4D69                     832 00120$:
                            833 ;src/Renderer.c:445: ++lateralWallSlopeCounter;
   4D69 DD 34 F0      [23]  834 	inc	-16 (ix)
   4D6C                     835 00122$:
                            836 ;src/Renderer.c:448: --lateralWallCounter;
   4D6C DD 35 E6      [23]  837 	dec	-26 (ix)
   4D6F                     838 00124$:
                            839 ;src/Renderer.c:459: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   4D6F DD 7E D7      [19]  840 	ld	a,-41 (ix)
   4D72 DD 77 FE      [19]  841 	ld	-2 (ix),a
   4D75 DD 36 FF 00   [19]  842 	ld	-1 (ix),#0x00
                            843 ;src/Renderer.c:451: if (!(x%2))
   4D79 DD 7E F9      [19]  844 	ld	a,-7 (ix)
   4D7C B7            [ 4]  845 	or	a, a
   4D7D 20 59         [12]  846 	jr	NZ,00131$
                            847 ;src/Renderer.c:453: if(xHeight > 0){
   4D7F DD 7E E5      [19]  848 	ld	a,-27 (ix)
   4D82 B7            [ 4]  849 	or	a, a
   4D83 28 53         [12]  850 	jr	Z,00131$
                            851 ;src/Renderer.c:454: if (lateralWallCounter > 0)
   4D85 DD 7E E6      [19]  852 	ld	a,-26 (ix)
   4D88 B7            [ 4]  853 	or	a, a
   4D89 28 1F         [12]  854 	jr	Z,00126$
                            855 ;src/Renderer.c:456: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   4D8B DD 4E DC      [19]  856 	ld	c,-36 (ix)
   4D8E 06 00         [ 7]  857 	ld	b,#0x00
   4D90 DD 5E E6      [19]  858 	ld	e,-26 (ix)
   4D93 16 00         [ 7]  859 	ld	d,#0x00
   4D95 79            [ 4]  860 	ld	a,c
   4D96 93            [ 4]  861 	sub	a, e
   4D97 6F            [ 4]  862 	ld	l,a
   4D98 78            [ 4]  863 	ld	a,b
   4D99 9A            [ 4]  864 	sbc	a, d
   4D9A 67            [ 4]  865 	ld	h,a
   4D9B 29            [11]  866 	add	hl, hl
   4D9C 29            [11]  867 	add	hl, hl
   4D9D 29            [11]  868 	add	hl, hl
   4D9E 29            [11]  869 	add	hl, hl
   4D9F 29            [11]  870 	add	hl, hl
   4DA0 C5            [11]  871 	push	bc
   4DA1 E5            [11]  872 	push	hl
   4DA2 CD 4A 64      [17]  873 	call	__divsint
   4DA5 F1            [10]  874 	pop	af
   4DA6 F1            [10]  875 	pop	af
   4DA7 45            [ 4]  876 	ld	b,l
   4DA8 18 19         [12]  877 	jr	00127$
   4DAA                     878 00126$:
                            879 ;src/Renderer.c:459: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   4DAA DD 6E FB      [19]  880 	ld	l,-5 (ix)
   4DAD DD 66 FC      [19]  881 	ld	h,-4 (ix)
   4DB0 29            [11]  882 	add	hl, hl
   4DB1 29            [11]  883 	add	hl, hl
   4DB2 29            [11]  884 	add	hl, hl
   4DB3 29            [11]  885 	add	hl, hl
   4DB4 29            [11]  886 	add	hl, hl
   4DB5 DD 4E FE      [19]  887 	ld	c,-2 (ix)
   4DB8 DD 46 FF      [19]  888 	ld	b,-1 (ix)
   4DBB C5            [11]  889 	push	bc
   4DBC E5            [11]  890 	push	hl
   4DBD CD 4A 64      [17]  891 	call	__divsint
   4DC0 F1            [10]  892 	pop	af
   4DC1 F1            [10]  893 	pop	af
   4DC2 45            [ 4]  894 	ld	b,l
   4DC3                     895 00127$:
                            896 ;src/Renderer.c:461: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   4DC3 DD 56 E2      [19]  897 	ld	d,-30 (ix)
   4DC6 CB 3A         [ 8]  898 	srl	d
   4DC8 C5            [11]  899 	push	bc
   4DC9 33            [ 6]  900 	inc	sp
   4DCA DD 66 D5      [19]  901 	ld	h,-43 (ix)
   4DCD DD 6E E5      [19]  902 	ld	l,-27 (ix)
   4DD0 E5            [11]  903 	push	hl
   4DD1 D5            [11]  904 	push	de
   4DD2 33            [ 6]  905 	inc	sp
   4DD3 CD 12 4A      [17]  906 	call	_draw_column_to_buffer
   4DD6 F1            [10]  907 	pop	af
   4DD7 F1            [10]  908 	pop	af
   4DD8                     909 00131$:
                            910 ;src/Renderer.c:465: ++xCellCount;
   4DD8 DD 34 F6      [23]  911 	inc	-10 (ix)
                            912 ;src/Renderer.c:389: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   4DDB DD 34 E2      [23]  913 	inc	-30 (ix)
                            914 ;src/Renderer.c:377: currentCellID = cells_in_view_array[lineStart + 1];
   4DDE 2A 0B 4A      [16]  915 	ld	hl,(_cells_in_view_array)
   4DE1 DD 75 EC      [19]  916 	ld	-20 (ix),l
   4DE4 DD 74 ED      [19]  917 	ld	-19 (ix),h
                            918 ;src/Renderer.c:389: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   4DE7 DD 7E E2      [19]  919 	ld	a,-30 (ix)
   4DEA D6 50         [ 7]  920 	sub	a, #0x50
   4DEC DA 2C 4C      [10]  921 	jp	C,00168$
                            922 ;src/Renderer.c:472: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   4DEF DD 7E D4      [19]  923 	ld	a,-44 (ix)
   4DF2 B7            [ 4]  924 	or	a, a
   4DF3 28 05         [12]  925 	jr	Z,00176$
   4DF5 DD 4E F1      [19]  926 	ld	c,-15 (ix)
   4DF8 18 02         [12]  927 	jr	00177$
   4DFA                     928 00176$:
   4DFA 0E 00         [ 7]  929 	ld	c,#0x00
   4DFC                     930 00177$:
   4DFC DD 71 D8      [19]  931 	ld	-40 (ix),c
                            932 ;src/Renderer.c:473: lateralWallSlope=0;
   4DFF DD 36 D9 00   [19]  933 	ld	-39 (ix),#0x00
                            934 ;src/Renderer.c:474: lateralWallSlopeCounter=0;
   4E03 DD 36 E1 00   [19]  935 	ld	-31 (ix),#0x00
                            936 ;src/Renderer.c:475: xHeight=0;
   4E07 DD 36 D3 00   [19]  937 	ld	-45 (ix),#0x00
                            938 ;src/Renderer.c:477: lateralWallCounter = 0;
   4E0B DD 36 FB 00   [19]  939 	ld	-5 (ix),#0x00
                            940 ;src/Renderer.c:478: lineEnd = lineStart + offsetDiff * 2 + 2;
   4E0F DD 7E DE      [19]  941 	ld	a,-34 (ix)
   4E12 87            [ 4]  942 	add	a, a
   4E13 4F            [ 4]  943 	ld	c,a
   4E14 DD 7E DD      [19]  944 	ld	a,-35 (ix)
   4E17 81            [ 4]  945 	add	a, c
   4E18 DD 77 F9      [19]  946 	ld	-7 (ix), a
   4E1B 4F            [ 4]  947 	ld	c, a
   4E1C 0C            [ 4]  948 	inc	c
   4E1D 0C            [ 4]  949 	inc	c
                            950 ;src/Renderer.c:480: newCell=1;
   4E1E DD 36 DF 01   [19]  951 	ld	-33 (ix),#0x01
                            952 ;src/Renderer.c:481: currentCellID = cells_in_view_array[lineEnd - 1];
   4E22 DD 71 EA      [19]  953 	ld	-22 (ix),c
   4E25 DD 36 EB 00   [19]  954 	ld	-21 (ix),#0x00
   4E29 DD 5E EA      [19]  955 	ld	e,-22 (ix)
   4E2C DD 56 EB      [19]  956 	ld	d,-21 (ix)
   4E2F 1B            [ 6]  957 	dec	de
   4E30 DD 6E EC      [19]  958 	ld	l,-20 (ix)
   4E33 DD 66 ED      [19]  959 	ld	h,-19 (ix)
   4E36 19            [11]  960 	add	hl,de
   4E37 7E            [ 7]  961 	ld	a,(hl)
   4E38 DD 77 E0      [19]  962 	ld	-32 (ix),a
                            963 ;src/Renderer.c:483: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   4E3B DD 6E EC      [19]  964 	ld	l,-20 (ix)
   4E3E DD 66 ED      [19]  965 	ld	h,-19 (ix)
   4E41 06 00         [ 7]  966 	ld	b,#0x00
   4E43 09            [11]  967 	add	hl, bc
   4E44 4E            [ 7]  968 	ld	c,(hl)
                            969 ;src/Renderer.c:484: if(lastCellWasWall<5){
   4E45 79            [ 4]  970 	ld	a,c
   4E46 D6 05         [ 7]  971 	sub	a, #0x05
   4E48 30 09         [12]  972 	jr	NC,00134$
                            973 ;src/Renderer.c:485: lastWallId=lastCellWasWall;
   4E4A DD 71 DB      [19]  974 	ld	-37 (ix),c
                            975 ;src/Renderer.c:486: lastCellWasWall=1;
   4E4D DD 36 F8 01   [19]  976 	ld	-8 (ix),#0x01
   4E51 18 08         [12]  977 	jr	00210$
   4E53                     978 00134$:
                            979 ;src/Renderer.c:489: lastCellWasWall=0;
   4E53 DD 36 F8 00   [19]  980 	ld	-8 (ix),#0x00
                            981 ;src/Renderer.c:490: lastWallId=CELLTYPE_FLOOR;
   4E57 DD 36 DB FE   [19]  982 	ld	-37 (ix),#0xFE
                            983 ;src/Renderer.c:493: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   4E5B                     984 00210$:
   4E5B DD 36 D6 00   [19]  985 	ld	-42 (ix),#0x00
   4E5F DD 36 E2 9F   [19]  986 	ld	-30 (ix),#0x9F
   4E63                     987 00170$:
                            988 ;src/Renderer.c:496: if (xCellCount == zHeight)
   4E63 DD 7E D7      [19]  989 	ld	a,-41 (ix)
   4E66 DD 96 D8      [19]  990 	sub	a, -40 (ix)
   4E69 20 59         [12]  991 	jr	NZ,00137$
                            992 ;src/Renderer.c:498: ++xCell;
   4E6B DD 34 D6      [23]  993 	inc	-42 (ix)
                            994 ;src/Renderer.c:499: xCellCount = 0;
   4E6E DD 36 D8 00   [19]  995 	ld	-40 (ix),#0x00
                            996 ;src/Renderer.c:500: newCell=1;
   4E72 DD 36 DF 01   [19]  997 	ld	-33 (ix),#0x01
                            998 ;src/Renderer.c:501: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   4E76 DD 7E D6      [19]  999 	ld	a,-42 (ix)
   4E79 DD 77 EC      [19] 1000 	ld	-20 (ix),a
   4E7C DD 36 ED 00   [19] 1001 	ld	-19 (ix),#0x00
   4E80 DD 7E EA      [19] 1002 	ld	a,-22 (ix)
   4E83 DD 96 EC      [19] 1003 	sub	a, -20 (ix)
   4E86 DD 77 EC      [19] 1004 	ld	-20 (ix),a
   4E89 DD 7E EB      [19] 1005 	ld	a,-21 (ix)
   4E8C DD 9E ED      [19] 1006 	sbc	a, -19 (ix)
   4E8F DD 77 ED      [19] 1007 	ld	-19 (ix),a
   4E92 DD 6E EC      [19] 1008 	ld	l,-20 (ix)
   4E95 DD 66 ED      [19] 1009 	ld	h,-19 (ix)
   4E98 2B            [ 6] 1010 	dec	hl
   4E99 DD 75 EC      [19] 1011 	ld	-20 (ix),l
   4E9C DD 74 ED      [19] 1012 	ld	-19 (ix),h
   4E9F 2A 0B 4A      [16] 1013 	ld	hl,(_cells_in_view_array)
   4EA2 DD 75 E3      [19] 1014 	ld	-29 (ix),l
   4EA5 DD 74 E4      [19] 1015 	ld	-28 (ix),h
   4EA8 DD 7E EC      [19] 1016 	ld	a,-20 (ix)
   4EAB DD 86 E3      [19] 1017 	add	a, -29 (ix)
   4EAE DD 77 E3      [19] 1018 	ld	-29 (ix),a
   4EB1 DD 7E ED      [19] 1019 	ld	a,-19 (ix)
   4EB4 DD 8E E4      [19] 1020 	adc	a, -28 (ix)
   4EB7 DD 77 E4      [19] 1021 	ld	-28 (ix),a
   4EBA DD 6E E3      [19] 1022 	ld	l,-29 (ix)
   4EBD DD 66 E4      [19] 1023 	ld	h,-28 (ix)
   4EC0 7E            [ 7] 1024 	ld	a,(hl)
   4EC1 DD 77 E0      [19] 1025 	ld	-32 (ix),a
   4EC4                    1026 00137$:
                           1027 ;src/Renderer.c:503: if(!(x%2)){
   4EC4 DD 7E E2      [19] 1028 	ld	a,-30 (ix)
   4EC7 E6 01         [ 7] 1029 	and	a, #0x01
   4EC9 DD 77 E3      [19] 1030 	ld	-29 (ix),a
                           1031 ;src/Renderer.c:420: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4ECC DD 7E D8      [19] 1032 	ld	a,-40 (ix)
   4ECF DD 77 EC      [19] 1033 	ld	-20 (ix),a
   4ED2 DD 36 ED 00   [19] 1034 	ld	-19 (ix),#0x00
                           1035 ;src/Renderer.c:503: if(!(x%2)){
   4ED6 DD 7E E3      [19] 1036 	ld	a,-29 (ix)
   4ED9 B7            [ 4] 1037 	or	a, a
   4EDA C2 28 50      [10] 1038 	jp	NZ,00150$
                           1039 ;src/Renderer.c:504: if (lateralWallCounter == 0 || newCell)
   4EDD DD 7E FB      [19] 1040 	ld	a,-5 (ix)
   4EE0 B7            [ 4] 1041 	or	a, a
   4EE1 28 07         [12] 1042 	jr	Z,00146$
   4EE3 DD 7E DF      [19] 1043 	ld	a,-33 (ix)
   4EE6 B7            [ 4] 1044 	or	a, a
   4EE7 CA 28 50      [10] 1045 	jp	Z,00150$
   4EEA                    1046 00146$:
                           1047 ;src/Renderer.c:506: if ( currentCellID < 5)//Wall
   4EEA DD 7E E0      [19] 1048 	ld	a,-32 (ix)
   4EED D6 05         [ 7] 1049 	sub	a, #0x05
   4EEF 30 21         [12] 1050 	jr	NC,00144$
                           1051 ;src/Renderer.c:508: lateralWallCounter = 0;
   4EF1 DD 36 FB 00   [19] 1052 	ld	-5 (ix),#0x00
                           1053 ;src/Renderer.c:509: lateralWallSlope = 0;
   4EF5 DD 36 D9 00   [19] 1054 	ld	-39 (ix),#0x00
                           1055 ;src/Renderer.c:510: xHeight = zHeight;
   4EF9 DD 7E D7      [19] 1056 	ld	a,-41 (ix)
   4EFC DD 77 D3      [19] 1057 	ld	-45 (ix),a
                           1058 ;src/Renderer.c:511: color = currentCellID;
   4EFF DD 7E E0      [19] 1059 	ld	a,-32 (ix)
   4F02 DD 77 D5      [19] 1060 	ld	-43 (ix),a
                           1061 ;src/Renderer.c:512: lastCellWasWall = 1;
   4F05 DD 36 F8 01   [19] 1062 	ld	-8 (ix),#0x01
                           1063 ;src/Renderer.c:513: lastWallId=currentCellID;
   4F09 DD 7E E0      [19] 1064 	ld	a,-32 (ix)
   4F0C DD 77 DB      [19] 1065 	ld	-37 (ix),a
   4F0F C3 24 50      [10] 1066 	jp	00145$
   4F12                    1067 00144$:
                           1068 ;src/Renderer.c:515: else if(lateralWallCounter==0){
   4F12 DD 7E FB      [19] 1069 	ld	a,-5 (ix)
   4F15 B7            [ 4] 1070 	or	a, a
   4F16 C2 24 50      [10] 1071 	jp	NZ,00145$
                           1072 ;src/Renderer.c:516: if (lastCellWasWall)
   4F19 DD 7E F8      [19] 1073 	ld	a,-8 (ix)
   4F1C B7            [ 4] 1074 	or	a, a
   4F1D CA 14 50      [10] 1075 	jp	Z,00139$
                           1076 ;src/Renderer.c:519: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   4F20 DD 7E DE      [19] 1077 	ld	a,-34 (ix)
   4F23 DD 96 D6      [19] 1078 	sub	a, -42 (ix)
   4F26 87            [ 4] 1079 	add	a, a
   4F27 3C            [ 4] 1080 	inc	a
                           1081 ;src/Renderer.c:520: lateralWallSlopeCounter = lateralWallSlope / 2;
   4F28 DD 77 D9      [19] 1082 	ld	-39 (ix), a
   4F2B CB 3F         [ 8] 1083 	srl	a
   4F2D DD 77 E1      [19] 1084 	ld	-31 (ix),a
                           1085 ;src/Renderer.c:521: lateralWallCounter = lateralWallSlope * zHeight;
   4F30 DD 5E D7      [19] 1086 	ld	e,-41 (ix)
   4F33 DD 66 D9      [19] 1087 	ld	h,-39 (ix)
   4F36 2E 00         [ 7] 1088 	ld	l, #0x00
   4F38 55            [ 4] 1089 	ld	d, l
   4F39 06 08         [ 7] 1090 	ld	b, #0x08
   4F3B                    1091 00327$:
   4F3B 29            [11] 1092 	add	hl,hl
   4F3C 30 01         [12] 1093 	jr	NC,00328$
   4F3E 19            [11] 1094 	add	hl,de
   4F3F                    1095 00328$:
   4F3F 10 FA         [13] 1096 	djnz	00327$
   4F41 DD 75 F5      [19] 1097 	ld	-11 (ix), l
   4F44 7D            [ 4] 1098 	ld	a, l
                           1099 ;src/Renderer.c:522: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   4F45 DD 77 DA      [19] 1100 	ld	-38 (ix), a
   4F48 DD 77 EE      [19] 1101 	ld	-18 (ix),a
   4F4B DD 36 EF 00   [19] 1102 	ld	-17 (ix),#0x00
   4F4F DD 7E DA      [19] 1103 	ld	a,-38 (ix)
   4F52 E6 03         [ 7] 1104 	and	a, #0x03
   4F54 DD 77 F5      [19] 1105 	ld	-11 (ix), a
   4F57 DD 77 F3      [19] 1106 	ld	-13 (ix),a
   4F5A DD 36 F4 00   [19] 1107 	ld	-12 (ix),#0x00
   4F5E DD 7E EE      [19] 1108 	ld	a,-18 (ix)
   4F61 DD 96 F3      [19] 1109 	sub	a, -13 (ix)
   4F64 DD 77 F3      [19] 1110 	ld	-13 (ix),a
   4F67 DD 7E EF      [19] 1111 	ld	a,-17 (ix)
   4F6A DD 9E F4      [19] 1112 	sbc	a, -12 (ix)
   4F6D DD 77 F4      [19] 1113 	ld	-12 (ix),a
   4F70 DD 7E F3      [19] 1114 	ld	a,-13 (ix)
   4F73 C6 01         [ 7] 1115 	add	a, #0x01
   4F75 DD 77 EE      [19] 1116 	ld	-18 (ix),a
   4F78 DD 7E F4      [19] 1117 	ld	a,-12 (ix)
   4F7B CE 00         [ 7] 1118 	adc	a, #0x00
   4F7D DD 77 EF      [19] 1119 	ld	-17 (ix),a
   4F80 DD 7E EE      [19] 1120 	ld	a,-18 (ix)
   4F83 DD 77 E7      [19] 1121 	ld	-25 (ix),a
   4F86 DD 7E EF      [19] 1122 	ld	a,-17 (ix)
   4F89 DD 77 E8      [19] 1123 	ld	-24 (ix),a
   4F8C DD CB EF 7E   [20] 1124 	bit	7, -17 (ix)
   4F90 28 10         [12] 1125 	jr	Z,00178$
   4F92 DD 7E F3      [19] 1126 	ld	a,-13 (ix)
   4F95 C6 04         [ 7] 1127 	add	a, #0x04
   4F97 DD 77 E7      [19] 1128 	ld	-25 (ix),a
   4F9A DD 7E F4      [19] 1129 	ld	a,-12 (ix)
   4F9D CE 00         [ 7] 1130 	adc	a, #0x00
   4F9F DD 77 E8      [19] 1131 	ld	-24 (ix),a
   4FA2                    1132 00178$:
   4FA2 DD CB E8 2E   [23] 1133 	sra	-24 (ix)
   4FA6 DD CB E7 1E   [23] 1134 	rr	-25 (ix)
   4FAA DD CB E8 2E   [23] 1135 	sra	-24 (ix)
   4FAE DD CB E7 1E   [23] 1136 	rr	-25 (ix)
   4FB2 DD 7E E7      [19] 1137 	ld	a,-25 (ix)
   4FB5 DD 77 E7      [19] 1138 	ld	-25 (ix),a
   4FB8 DD 4E D8      [19] 1139 	ld	c,-40 (ix)
   4FBB DD 7E E7      [19] 1140 	ld	a,-25 (ix)
   4FBE 91            [ 4] 1141 	sub	a, c
                           1142 ;src/Renderer.c:523: lateralWallWidth=lateralWallCounter;
   4FBF DD 77 FB      [19] 1143 	ld	-5 (ix), a
   4FC2 DD 77 DC      [19] 1144 	ld	-36 (ix),a
                           1145 ;src/Renderer.c:524: lastCellWasWall = 0;
   4FC5 DD 36 F8 00   [19] 1146 	ld	-8 (ix),#0x00
                           1147 ;src/Renderer.c:525: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   4FC9 DD 7E EC      [19] 1148 	ld	a,-20 (ix)
   4FCC DD 77 E7      [19] 1149 	ld	-25 (ix),a
   4FCF DD 7E ED      [19] 1150 	ld	a,-19 (ix)
   4FD2 DD 77 E8      [19] 1151 	ld	-24 (ix),a
   4FD5 DD CB E7 26   [23] 1152 	sla	-25 (ix)
   4FD9 DD CB E8 16   [23] 1153 	rl	-24 (ix)
   4FDD DD 7E D9      [19] 1154 	ld	a,-39 (ix)
   4FE0 DD 77 F3      [19] 1155 	ld	-13 (ix),a
   4FE3 DD 36 F4 00   [19] 1156 	ld	-12 (ix),#0x00
   4FE7 DD 6E F3      [19] 1157 	ld	l,-13 (ix)
   4FEA DD 66 F4      [19] 1158 	ld	h,-12 (ix)
   4FED E5            [11] 1159 	push	hl
   4FEE DD 6E E7      [19] 1160 	ld	l,-25 (ix)
   4FF1 DD 66 E8      [19] 1161 	ld	h,-24 (ix)
   4FF4 E5            [11] 1162 	push	hl
   4FF5 CD 4A 64      [17] 1163 	call	__divsint
   4FF8 F1            [10] 1164 	pop	af
   4FF9 F1            [10] 1165 	pop	af
   4FFA DD 74 E8      [19] 1166 	ld	-24 (ix),h
   4FFD DD 75 E7      [19] 1167 	ld	-25 (ix), l
   5000 DD 75 E7      [19] 1168 	ld	-25 (ix), l
   5003 DD 7E FD      [19] 1169 	ld	a,-3 (ix)
   5006 DD 96 E7      [19] 1170 	sub	a, -25 (ix)
   5009 DD 77 D3      [19] 1171 	ld	-45 (ix),a
                           1172 ;src/Renderer.c:526: color = lastWallId;
   500C DD 7E DB      [19] 1173 	ld	a,-37 (ix)
   500F DD 77 D5      [19] 1174 	ld	-43 (ix),a
   5012 18 10         [12] 1175 	jr	00145$
   5014                    1176 00139$:
                           1177 ;src/Renderer.c:530: xHeight = 0;
   5014 DD 36 D3 00   [19] 1178 	ld	-45 (ix),#0x00
                           1179 ;src/Renderer.c:531: lastCellWasWall = 0;
   5018 DD 36 F8 00   [19] 1180 	ld	-8 (ix),#0x00
                           1181 ;src/Renderer.c:532: lateralWallSlope=0;
   501C DD 36 D9 00   [19] 1182 	ld	-39 (ix),#0x00
                           1183 ;src/Renderer.c:533: lastWallId=0;
   5020 DD 36 DB 00   [19] 1184 	ld	-37 (ix),#0x00
   5024                    1185 00145$:
                           1186 ;src/Renderer.c:536: newCell=0;
   5024 DD 36 DF 00   [19] 1187 	ld	-33 (ix),#0x00
   5028                    1188 00150$:
                           1189 ;src/Renderer.c:541: if (lateralWallCounter > 0)
   5028 DD 7E FB      [19] 1190 	ld	a,-5 (ix)
   502B B7            [ 4] 1191 	or	a, a
   502C 28 1E         [12] 1192 	jr	Z,00156$
                           1193 ;src/Renderer.c:544: if (lateralWallSlope != 0)
   502E DD 7E D9      [19] 1194 	ld	a,-39 (ix)
   5031 B7            [ 4] 1195 	or	a, a
   5032 28 15         [12] 1196 	jr	Z,00154$
                           1197 ;src/Renderer.c:546: if (lateralWallSlopeCounter == lateralWallSlope)
   5034 DD 7E E1      [19] 1198 	ld	a,-31 (ix)
   5037 DD 96 D9      [19] 1199 	sub	a, -39 (ix)
   503A 20 0A         [12] 1200 	jr	NZ,00152$
                           1201 ;src/Renderer.c:548: lateralWallSlopeCounter = 0;
   503C DD 36 E1 00   [19] 1202 	ld	-31 (ix),#0x00
                           1203 ;src/Renderer.c:549: xHeight -= 2;
   5040 DD 35 D3      [23] 1204 	dec	-45 (ix)
   5043 DD 35 D3      [23] 1205 	dec	-45 (ix)
   5046                    1206 00152$:
                           1207 ;src/Renderer.c:551: ++lateralWallSlopeCounter;
   5046 DD 34 E1      [23] 1208 	inc	-31 (ix)
   5049                    1209 00154$:
                           1210 ;src/Renderer.c:553: --lateralWallCounter;
   5049 DD 35 FB      [23] 1211 	dec	-5 (ix)
   504C                    1212 00156$:
                           1213 ;src/Renderer.c:557: if (!(x%2))
   504C DD 7E E3      [19] 1214 	ld	a,-29 (ix)
   504F B7            [ 4] 1215 	or	a, a
   5050 C2 E9 50      [10] 1216 	jp	NZ,00163$
                           1217 ;src/Renderer.c:560: if(xHeight > 0){
   5053 DD 7E D3      [19] 1218 	ld	a,-45 (ix)
   5056 B7            [ 4] 1219 	or	a, a
   5057 CA E9 50      [10] 1220 	jp	Z,00163$
                           1221 ;src/Renderer.c:562: if (lateralWallCounter > 0)
   505A DD 7E FB      [19] 1222 	ld	a,-5 (ix)
   505D B7            [ 4] 1223 	or	a, a
   505E 28 39         [12] 1224 	jr	Z,00158$
                           1225 ;src/Renderer.c:564: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   5060 DD 7E FB      [19] 1226 	ld	a,-5 (ix)
   5063 DD 77 E7      [19] 1227 	ld	-25 (ix),a
   5066 DD 36 E8 00   [19] 1228 	ld	-24 (ix),#0x00
   506A 3E 06         [ 7] 1229 	ld	a,#0x05+1
   506C 18 08         [12] 1230 	jr	00334$
   506E                    1231 00333$:
   506E DD CB E7 26   [23] 1232 	sla	-25 (ix)
   5072 DD CB E8 16   [23] 1233 	rl	-24 (ix)
   5076                    1234 00334$:
   5076 3D            [ 4] 1235 	dec	a
   5077 20 F5         [12] 1236 	jr	NZ,00333$
   5079 DD 7E DC      [19] 1237 	ld	a,-36 (ix)
   507C DD 77 F3      [19] 1238 	ld	-13 (ix),a
   507F DD 36 F4 00   [19] 1239 	ld	-12 (ix),#0x00
   5083 DD 6E F3      [19] 1240 	ld	l,-13 (ix)
   5086 DD 66 F4      [19] 1241 	ld	h,-12 (ix)
   5089 E5            [11] 1242 	push	hl
   508A DD 6E E7      [19] 1243 	ld	l,-25 (ix)
   508D DD 66 E8      [19] 1244 	ld	h,-24 (ix)
   5090 E5            [11] 1245 	push	hl
   5091 CD 4A 64      [17] 1246 	call	__divsint
   5094 F1            [10] 1247 	pop	af
   5095 F1            [10] 1248 	pop	af
   5096 55            [ 4] 1249 	ld	d,l
   5097 18 3B         [12] 1250 	jr	00159$
   5099                    1251 00158$:
                           1252 ;src/Renderer.c:567: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   5099 DD 7E FE      [19] 1253 	ld	a,-2 (ix)
   509C DD 96 EC      [19] 1254 	sub	a, -20 (ix)
   509F DD 77 E7      [19] 1255 	ld	-25 (ix),a
   50A2 DD 7E FF      [19] 1256 	ld	a,-1 (ix)
   50A5 DD 9E ED      [19] 1257 	sbc	a, -19 (ix)
   50A8 DD 77 E8      [19] 1258 	ld	-24 (ix),a
   50AB 3E 06         [ 7] 1259 	ld	a,#0x05+1
   50AD 18 08         [12] 1260 	jr	00336$
   50AF                    1261 00335$:
   50AF DD CB E7 26   [23] 1262 	sla	-25 (ix)
   50B3 DD CB E8 16   [23] 1263 	rl	-24 (ix)
   50B7                    1264 00336$:
   50B7 3D            [ 4] 1265 	dec	a
   50B8 20 F5         [12] 1266 	jr	NZ,00335$
   50BA DD 6E FE      [19] 1267 	ld	l,-2 (ix)
   50BD DD 66 FF      [19] 1268 	ld	h,-1 (ix)
   50C0 E5            [11] 1269 	push	hl
   50C1 DD 6E E7      [19] 1270 	ld	l,-25 (ix)
   50C4 DD 66 E8      [19] 1271 	ld	h,-24 (ix)
   50C7 E5            [11] 1272 	push	hl
   50C8 CD 4A 64      [17] 1273 	call	__divsint
   50CB F1            [10] 1274 	pop	af
   50CC F1            [10] 1275 	pop	af
   50CD DD 74 E8      [19] 1276 	ld	-24 (ix),h
   50D0 DD 75 E7      [19] 1277 	ld	-25 (ix), l
   50D3 55            [ 4] 1278 	ld	d, l
   50D4                    1279 00159$:
                           1280 ;src/Renderer.c:570: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   50D4 DD 46 E2      [19] 1281 	ld	b,-30 (ix)
   50D7 CB 38         [ 8] 1282 	srl	b
   50D9 D5            [11] 1283 	push	de
   50DA 33            [ 6] 1284 	inc	sp
   50DB DD 66 D5      [19] 1285 	ld	h,-43 (ix)
   50DE DD 6E D3      [19] 1286 	ld	l,-45 (ix)
   50E1 E5            [11] 1287 	push	hl
   50E2 C5            [11] 1288 	push	bc
   50E3 33            [ 6] 1289 	inc	sp
   50E4 CD 12 4A      [17] 1290 	call	_draw_column_to_buffer
   50E7 F1            [10] 1291 	pop	af
   50E8 F1            [10] 1292 	pop	af
   50E9                    1293 00163$:
                           1294 ;src/Renderer.c:573: ++xCellCount;
   50E9 DD 34 D8      [23] 1295 	inc	-40 (ix)
                           1296 ;src/Renderer.c:493: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   50EC DD 35 E2      [23] 1297 	dec	-30 (ix)
   50EF DD 7E E2      [19] 1298 	ld	a,-30 (ix)
   50F2 D6 50         [ 7] 1299 	sub	a, #0x50
   50F4 D2 63 4E      [10] 1300 	jp	NC,00170$
                           1301 ;src/Renderer.c:580: lineStart = lineStart + (offsetDiff * 2) + 3;
   50F7 DD 7E F9      [19] 1302 	ld	a,-7 (ix)
   50FA C6 03         [ 7] 1303 	add	a, #0x03
   50FC DD 77 DD      [19] 1304 	ld	-35 (ix),a
                           1305 ;src/Renderer.c:581: zHeight += zHeight;
   50FF DD CB D7 26   [23] 1306 	sla	-41 (ix)
                           1307 ;src/Renderer.c:582: offsetDiff = offsetDiff >> 1;
   5103 DD CB DE 3E   [23] 1308 	srl	-34 (ix)
                           1309 ;src/Renderer.c:584: }while(z);
   5107 DD 7E D4      [19] 1310 	ld	a,-44 (ix)
   510A B7            [ 4] 1311 	or	a, a
   510B C2 AD 4B      [10] 1312 	jp	NZ,00165$
   510E DD F9         [10] 1313 	ld	sp, ix
   5110 DD E1         [14] 1314 	pop	ix
   5112 C9            [10] 1315 	ret
                           1316 ;src/Renderer.c:592: void draw_minimap_to_buffer(){
                           1317 ;	---------------------------------
                           1318 ; Function draw_minimap_to_buffer
                           1319 ; ---------------------------------
   5113                    1320 _draw_minimap_to_buffer::
   5113 DD E5         [15] 1321 	push	ix
   5115 DD 21 00 00   [14] 1322 	ld	ix,#0
   5119 DD 39         [15] 1323 	add	ix,sp
   511B 21 F5 FF      [10] 1324 	ld	hl,#-11
   511E 39            [11] 1325 	add	hl,sp
   511F F9            [ 6] 1326 	ld	sp,hl
                           1327 ;src/Renderer.c:595: u8* ptr = MINIMAP_BUFFER;
   5120 01 40 1C      [10] 1328 	ld	bc,#0x1C40
                           1329 ;src/Renderer.c:600: y=(PLAYER_position.y-MINIMAP_HEIGHT_HALF);
   5123 3A 2E 48      [13] 1330 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   5126 C6 F8         [ 7] 1331 	add	a,#0xF8
   5128 5F            [ 4] 1332 	ld	e,a
                           1333 ;src/Renderer.c:602: for(j=0;j<MINIMAP_HEIGHT;++j){
   5129 16 00         [ 7] 1334 	ld	d,#0x00
                           1335 ;src/Renderer.c:603: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   512B                    1336 00135$:
   512B 7B            [ 4] 1337 	ld	a,e
   512C 07            [ 4] 1338 	rlca
   512D E6 01         [ 7] 1339 	and	a,#0x01
   512F DD 77 F7      [19] 1340 	ld	-9 (ix),a
   5132 7B            [ 4] 1341 	ld	a,e
   5133 EE 80         [ 7] 1342 	xor	a, #0x80
   5135 D6 A0         [ 7] 1343 	sub	a, #0xA0
   5137 3E 00         [ 7] 1344 	ld	a,#0x00
   5139 17            [ 4] 1345 	rla
   513A DD 77 FF      [19] 1346 	ld	-1 (ix),a
   513D DD 36 F6 00   [19] 1347 	ld	-10 (ix),#0x00
   5141                    1348 00120$:
                           1349 ;src/Renderer.c:604: x=(PLAYER_position.x-MINIMAP_WIDTH_HALF);
   5141 3A 2D 48      [13] 1350 	ld	a, (#_PLAYER_position + 0)
   5144 C6 F8         [ 7] 1351 	add	a,#0xF8
   5146 DD 77 F8      [19] 1352 	ld	-8 (ix),a
                           1353 ;src/Renderer.c:605: for(i=0;i<MINIMAP_WIDTH;++i){
   5149 DD 36 F5 00   [19] 1354 	ld	-11 (ix),#0x00
   514D                    1355 00118$:
                           1356 ;src/Renderer.c:608: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   514D FD 21 10 00   [14] 1357 	ld	iy,#0x0010
   5151 FD 09         [15] 1358 	add	iy, bc
                           1359 ;src/Renderer.c:606: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
   5153 DD CB F8 7E   [20] 1360 	bit	7, -8 (ix)
   5157 20 15         [12] 1361 	jr	NZ,00109$
   5159 DD 7E F8      [19] 1362 	ld	a,-8 (ix)
   515C EE 80         [ 7] 1363 	xor	a, #0x80
   515E D6 A0         [ 7] 1364 	sub	a, #0xA0
   5160 30 0C         [12] 1365 	jr	NC,00109$
   5162 DD 7E F7      [19] 1366 	ld	a,-9 (ix)
   5165 B7            [ 4] 1367 	or	a, a
   5166 20 06         [12] 1368 	jr	NZ,00109$
   5168 DD CB FF 46   [20] 1369 	bit	0,-1 (ix)
   516C 20 0D         [12] 1370 	jr	NZ,00110$
   516E                    1371 00109$:
                           1372 ;src/Renderer.c:607: *ptr=g_colors[MINIMAP_WALL_COLOR];
   516E 3A FA 49      [13] 1373 	ld	a, (#(_g_colors + 0x0001) + 0)
   5171 02            [ 7] 1374 	ld	(bc),a
                           1375 ;src/Renderer.c:608: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   5172 3A FA 49      [13] 1376 	ld	a, (#(_g_colors + 0x0001) + 0)
   5175 FD 77 00      [19] 1377 	ld	0 (iy), a
   5178 C3 23 52      [10] 1378 	jp	00111$
   517B                    1379 00110$:
                           1380 ;src/Renderer.c:610: else if((x==PLAYER_position.x)&&(y==PLAYER_position.y)){
   517B DD 7E F8      [19] 1381 	ld	a,-8 (ix)
   517E DD 77 FD      [19] 1382 	ld	-3 (ix),a
   5181 DD 7E F8      [19] 1383 	ld	a,-8 (ix)
   5184 17            [ 4] 1384 	rla
   5185 9F            [ 4] 1385 	sbc	a, a
   5186 DD 77 FE      [19] 1386 	ld	-2 (ix),a
   5189 3A 2D 48      [13] 1387 	ld	a, (#_PLAYER_position + 0)
   518C DD 77 F9      [19] 1388 	ld	-7 (ix),a
   518F DD 36 FA 00   [19] 1389 	ld	-6 (ix),#0x00
   5193 DD 73 FB      [19] 1390 	ld	-5 (ix),e
   5196 7B            [ 4] 1391 	ld	a,e
   5197 17            [ 4] 1392 	rla
   5198 9F            [ 4] 1393 	sbc	a, a
   5199 DD 77 FC      [19] 1394 	ld	-4 (ix),a
   519C DD 7E FD      [19] 1395 	ld	a,-3 (ix)
   519F DD 96 F9      [19] 1396 	sub	a, -7 (ix)
   51A2 20 2E         [12] 1397 	jr	NZ,00106$
   51A4 DD 7E FE      [19] 1398 	ld	a,-2 (ix)
   51A7 DD 96 FA      [19] 1399 	sub	a, -6 (ix)
   51AA 20 26         [12] 1400 	jr	NZ,00106$
   51AC 3A 2E 48      [13] 1401 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   51AF DD 77 F9      [19] 1402 	ld	-7 (ix),a
   51B2 DD 36 FA 00   [19] 1403 	ld	-6 (ix),#0x00
   51B6 DD 7E FB      [19] 1404 	ld	a,-5 (ix)
   51B9 DD 96 F9      [19] 1405 	sub	a, -7 (ix)
   51BC 20 14         [12] 1406 	jr	NZ,00106$
   51BE DD 7E FC      [19] 1407 	ld	a,-4 (ix)
   51C1 DD 96 FA      [19] 1408 	sub	a, -6 (ix)
   51C4 20 0C         [12] 1409 	jr	NZ,00106$
                           1410 ;src/Renderer.c:611: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
   51C6 3A FD 49      [13] 1411 	ld	a, (#(_g_colors + 0x0004) + 0)
   51C9 02            [ 7] 1412 	ld	(bc),a
                           1413 ;src/Renderer.c:612: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
   51CA 3A FD 49      [13] 1414 	ld	a, (#(_g_colors + 0x0004) + 0)
   51CD FD 77 00      [19] 1415 	ld	0 (iy), a
   51D0 18 51         [12] 1416 	jr	00111$
   51D2                    1417 00106$:
                           1418 ;src/Renderer.c:615: switch(*(u8*)(MAP_MEM+x+y*MAP_WIDTH)){
   51D2 DD 7E FD      [19] 1419 	ld	a,-3 (ix)
   51D5 C6 40         [ 7] 1420 	add	a, #0x40
   51D7 DD 77 F9      [19] 1421 	ld	-7 (ix),a
   51DA DD 7E FE      [19] 1422 	ld	a,-2 (ix)
   51DD CE 00         [ 7] 1423 	adc	a, #0x00
   51DF DD 77 FA      [19] 1424 	ld	-6 (ix),a
   51E2 DD 6E FB      [19] 1425 	ld	l,-5 (ix)
   51E5 DD 66 FC      [19] 1426 	ld	h,-4 (ix)
   51E8 29            [11] 1427 	add	hl, hl
   51E9 29            [11] 1428 	add	hl, hl
   51EA 29            [11] 1429 	add	hl, hl
   51EB 29            [11] 1430 	add	hl, hl
   51EC 29            [11] 1431 	add	hl, hl
   51ED DD 7E F9      [19] 1432 	ld	a,-7 (ix)
   51F0 85            [ 4] 1433 	add	a, l
   51F1 6F            [ 4] 1434 	ld	l,a
   51F2 DD 7E FA      [19] 1435 	ld	a,-6 (ix)
   51F5 8C            [ 4] 1436 	adc	a, h
   51F6 67            [ 4] 1437 	ld	h,a
   51F7 6E            [ 7] 1438 	ld	l,(hl)
   51F8 7D            [ 4] 1439 	ld	a,l
   51F9 B7            [ 4] 1440 	or	a, a
   51FA 28 11         [12] 1441 	jr	Z,00102$
   51FC 7D            [ 4] 1442 	ld	a,l
   51FD D6 FE         [ 7] 1443 	sub	a, #0xFE
   51FF 20 18         [12] 1444 	jr	NZ,00103$
                           1445 ;src/Renderer.c:617: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
   5201 3A FC 49      [13] 1446 	ld	a, (#(_g_colors + 0x0003) + 0)
   5204 02            [ 7] 1447 	ld	(bc),a
                           1448 ;src/Renderer.c:618: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
   5205 3A FC 49      [13] 1449 	ld	a, (#(_g_colors + 0x0003) + 0)
   5208 FD 77 00      [19] 1450 	ld	0 (iy), a
                           1451 ;src/Renderer.c:619: break;
   520B 18 16         [12] 1452 	jr	00111$
                           1453 ;src/Renderer.c:621: case CELLTYPE_DOOR:{
   520D                    1454 00102$:
                           1455 ;src/Renderer.c:622: *ptr=g_colors[MINIMAP_EXIT_COLOR];
   520D 3A 01 4A      [13] 1456 	ld	a, (#(_g_colors + 0x0008) + 0)
   5210 02            [ 7] 1457 	ld	(bc),a
                           1458 ;src/Renderer.c:623: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
   5211 3A 01 4A      [13] 1459 	ld	a, (#(_g_colors + 0x0008) + 0)
   5214 FD 77 00      [19] 1460 	ld	0 (iy), a
                           1461 ;src/Renderer.c:624: break;
   5217 18 0A         [12] 1462 	jr	00111$
                           1463 ;src/Renderer.c:626: default:{
   5219                    1464 00103$:
                           1465 ;src/Renderer.c:627: *ptr=g_colors[MINIMAP_WALL_COLOR];
   5219 3A FA 49      [13] 1466 	ld	a, (#(_g_colors + 0x0001) + 0)
   521C 02            [ 7] 1467 	ld	(bc),a
                           1468 ;src/Renderer.c:628: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   521D 3A FA 49      [13] 1469 	ld	a, (#(_g_colors + 0x0001) + 0)
   5220 FD 77 00      [19] 1470 	ld	0 (iy), a
                           1471 ;src/Renderer.c:631: }
   5223                    1472 00111$:
                           1473 ;src/Renderer.c:633: ++x;
   5223 DD 34 F8      [23] 1474 	inc	-8 (ix)
                           1475 ;src/Renderer.c:634: ++ptr;
   5226 03            [ 6] 1476 	inc	bc
                           1477 ;src/Renderer.c:605: for(i=0;i<MINIMAP_WIDTH;++i){
   5227 DD 34 F5      [23] 1478 	inc	-11 (ix)
   522A DD 7E F5      [19] 1479 	ld	a,-11 (ix)
   522D D6 10         [ 7] 1480 	sub	a, #0x10
   522F DA 4D 51      [10] 1481 	jp	C,00118$
                           1482 ;src/Renderer.c:603: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   5232 DD 34 F6      [23] 1483 	inc	-10 (ix)
   5235 DD 7E F6      [19] 1484 	ld	a,-10 (ix)
   5238 D6 04         [ 7] 1485 	sub	a, #0x04
   523A DA 41 51      [10] 1486 	jp	C,00120$
                           1487 ;src/Renderer.c:637: ++y;
   523D 1C            [ 4] 1488 	inc	e
                           1489 ;src/Renderer.c:602: for(j=0;j<MINIMAP_HEIGHT;++j){
   523E 14            [ 4] 1490 	inc	d
   523F 7A            [ 4] 1491 	ld	a,d
   5240 D6 10         [ 7] 1492 	sub	a, #0x10
   5242 DA 2B 51      [10] 1493 	jp	C,00135$
   5245 DD F9         [10] 1494 	ld	sp, ix
   5247 DD E1         [14] 1495 	pop	ix
   5249 C9            [10] 1496 	ret
                           1497 	.area _CODE
                           1498 	.area _INITIALIZER
                           1499 	.area _CABS (ABS)
