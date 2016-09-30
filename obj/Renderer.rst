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
                             52 ;src/Renderer.c:200: void calculate_cells_in_view(){
                             53 ;	---------------------------------
                             54 ; Function calculate_cells_in_view
                             55 ; ---------------------------------
   46FB                      56 _calculate_cells_in_view::
   46FB DD E5         [15]   57 	push	ix
   46FD DD 21 00 00   [14]   58 	ld	ix,#0
   4701 DD 39         [15]   59 	add	ix,sp
   4703 21 F2 FF      [10]   60 	ld	hl,#-14
   4706 39            [11]   61 	add	hl,sp
   4707 F9            [ 6]   62 	ld	sp,hl
                             63 ;src/Renderer.c:202: u8 offset=0, n=0, j, i;
   4708 DD 36 FA 00   [19]   64 	ld	-6 (ix),#0x00
   470C DD 36 F9 00   [19]   65 	ld	-7 (ix),#0x00
                             66 ;src/Renderer.c:205: if(PLAYER_direction.y!=0){
   4710 3A F1 46      [13]   67 	ld	a,(#_PLAYER_direction + 1)
   4713 DD 77 FD      [19]   68 	ld	-3 (ix), a
   4716 B7            [ 4]   69 	or	a, a
   4717 28 32         [12]   70 	jr	Z,00102$
                             71 ;src/Renderer.c:206: vert=1;
   4719 DD 36 F2 01   [19]   72 	ld	-14 (ix),#0x01
                             73 ;src/Renderer.c:207: dy=PLAYER_direction.y;
   471D DD 4E FD      [19]   74 	ld	c,-3 (ix)
   4720 DD 71 F4      [19]   75 	ld	-12 (ix),c
                             76 ;src/Renderer.c:208: dx=-PLAYER_direction.y;
   4723 AF            [ 4]   77 	xor	a, a
   4724 DD 96 FD      [19]   78 	sub	a, -3 (ix)
   4727 DD 77 F5      [19]   79 	ld	-11 (ix), a
                             80 ;src/Renderer.c:210: x0 = PLAYER_position.x-(17*dx);
   472A 21 EE 46      [10]   81 	ld	hl,#_PLAYER_position+0
   472D 4E            [ 7]   82 	ld	c,(hl)
   472E DD 6E F5      [19]   83 	ld	l,-11 (ix)
   4731 5D            [ 4]   84 	ld	e,l
   4732 29            [11]   85 	add	hl, hl
   4733 29            [11]   86 	add	hl, hl
   4734 29            [11]   87 	add	hl, hl
   4735 29            [11]   88 	add	hl, hl
   4736 19            [11]   89 	add	hl, de
   4737 79            [ 4]   90 	ld	a,c
   4738 95            [ 4]   91 	sub	a, l
   4739 DD 77 F6      [19]   92 	ld	-10 (ix),a
                             93 ;src/Renderer.c:211: y0 = PLAYER_position.y+(6*dy);
   473C 21 EF 46      [10]   94 	ld	hl,#_PLAYER_position+1
   473F 4E            [ 7]   95 	ld	c,(hl)
   4740 DD 6E F4      [19]   96 	ld	l,-12 (ix)
   4743 5D            [ 4]   97 	ld	e,l
   4744 29            [11]   98 	add	hl, hl
   4745 19            [11]   99 	add	hl, de
   4746 29            [11]  100 	add	hl, hl
   4747 09            [11]  101 	add	hl, bc
   4748 4D            [ 4]  102 	ld	c,l
   4749 18 34         [12]  103 	jr	00103$
   474B                     104 00102$:
                            105 ;src/Renderer.c:214: vert=0;
   474B DD 36 F2 00   [19]  106 	ld	-14 (ix),#0x00
                            107 ;src/Renderer.c:215: dy=PLAYER_direction.x;
   474F 3A F0 46      [13]  108 	ld	a,(#_PLAYER_direction + 0)
   4752 DD 77 FD      [19]  109 	ld	-3 (ix), a
   4755 DD 77 F4      [19]  110 	ld	-12 (ix),a
                            111 ;src/Renderer.c:216: dx=PLAYER_direction.x;
   4758 DD 7E FD      [19]  112 	ld	a,-3 (ix)
   475B DD 77 F5      [19]  113 	ld	-11 (ix),a
                            114 ;src/Renderer.c:218: y0 = PLAYER_position.y-(17*dy);
   475E 21 EF 46      [10]  115 	ld	hl, #_PLAYER_position + 1
   4761 4E            [ 7]  116 	ld	c,(hl)
   4762 DD 6E F4      [19]  117 	ld	l,-12 (ix)
   4765 5D            [ 4]  118 	ld	e,l
   4766 29            [11]  119 	add	hl, hl
   4767 29            [11]  120 	add	hl, hl
   4768 29            [11]  121 	add	hl, hl
   4769 29            [11]  122 	add	hl, hl
   476A 19            [11]  123 	add	hl, de
   476B 79            [ 4]  124 	ld	a,c
   476C 95            [ 4]  125 	sub	a, l
   476D 4F            [ 4]  126 	ld	c,a
                            127 ;src/Renderer.c:219: x0 = PLAYER_position.x+(6*dx);
   476E 21 EE 46      [10]  128 	ld	hl, #_PLAYER_position + 0
   4771 46            [ 7]  129 	ld	b,(hl)
   4772 DD 7E FD      [19]  130 	ld	a,-3 (ix)
   4775 5F            [ 4]  131 	ld	e,a
   4776 87            [ 4]  132 	add	a, a
   4777 83            [ 4]  133 	add	a, e
   4778 87            [ 4]  134 	add	a, a
   4779 5F            [ 4]  135 	ld	e,a
   477A 68            [ 4]  136 	ld	l,b
   477B 19            [11]  137 	add	hl, de
   477C DD 75 F6      [19]  138 	ld	-10 (ix),l
   477F                     139 00103$:
                            140 ;src/Renderer.c:223: x=x0;
   477F DD 5E F6      [19]  141 	ld	e,-10 (ix)
                            142 ;src/Renderer.c:224: y=y0;
   4782 DD 71 F3      [19]  143 	ld	-13 (ix),c
                            144 ;src/Renderer.c:226: for(j=0;j<6;++j){
   4785 DD 7E F5      [19]  145 	ld	a,-11 (ix)
   4788 07            [ 4]  146 	rlca
   4789 E6 01         [ 7]  147 	and	a,#0x01
   478B DD 77 FD      [19]  148 	ld	-3 (ix),a
   478E DD 7E F4      [19]  149 	ld	a,-12 (ix)
   4791 07            [ 4]  150 	rlca
   4792 E6 01         [ 7]  151 	and	a,#0x01
   4794 DD 77 FB      [19]  152 	ld	-5 (ix),a
   4797 DD 36 F8 00   [19]  153 	ld	-8 (ix),#0x00
                            154 ;src/Renderer.c:228: for(i=offset;i<35-offset;++i){
   479B                     155 00138$:
   479B DD 7E F9      [19]  156 	ld	a,-7 (ix)
   479E DD 77 FC      [19]  157 	ld	-4 (ix),a
   47A1 DD 7E FA      [19]  158 	ld	a,-6 (ix)
   47A4 DD 77 F7      [19]  159 	ld	-9 (ix),a
   47A7                     160 00125$:
   47A7 DD 6E FA      [19]  161 	ld	l,-6 (ix)
   47AA 26 00         [ 7]  162 	ld	h,#0x00
   47AC 3E 23         [ 7]  163 	ld	a,#0x23
   47AE 95            [ 4]  164 	sub	a, l
   47AF 6F            [ 4]  165 	ld	l,a
   47B0 3E 00         [ 7]  166 	ld	a,#0x00
   47B2 9C            [ 4]  167 	sbc	a, h
   47B3 67            [ 4]  168 	ld	h,a
   47B4 DD 7E F7      [19]  169 	ld	a, -9 (ix)
   47B7 16 00         [ 7]  170 	ld	d, #0x00
   47B9 95            [ 4]  171 	sub	a, l
   47BA 7A            [ 4]  172 	ld	a,d
   47BB 9C            [ 4]  173 	sbc	a, h
   47BC E2 C1 47      [10]  174 	jp	PO, 00181$
   47BF EE 80         [ 7]  175 	xor	a, #0x80
   47C1                     176 00181$:
   47C1 F2 40 48      [10]  177 	jp	P,00143$
                            178 ;src/Renderer.c:231: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   47C4 2A CC 48      [16]  179 	ld	hl,(_cells_in_view_array)
   47C7 7D            [ 4]  180 	ld	a,l
   47C8 DD 86 FC      [19]  181 	add	a, -4 (ix)
   47CB DD 77 FE      [19]  182 	ld	-2 (ix),a
   47CE 7C            [ 4]  183 	ld	a,h
   47CF CE 00         [ 7]  184 	adc	a, #0x00
   47D1 DD 77 FF      [19]  185 	ld	-1 (ix),a
                            186 ;src/Renderer.c:230: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
   47D4 CB 7B         [ 8]  187 	bit	7, e
   47D6 20 41         [12]  188 	jr	NZ,00105$
   47D8 7B            [ 4]  189 	ld	a,e
   47D9 EE 80         [ 7]  190 	xor	a, #0x80
   47DB D6 A0         [ 7]  191 	sub	a, #0xA0
   47DD 30 3A         [12]  192 	jr	NC,00105$
   47DF DD CB F3 7E   [20]  193 	bit	7, -13 (ix)
   47E3 20 34         [12]  194 	jr	NZ,00105$
   47E5 DD 7E F3      [19]  195 	ld	a,-13 (ix)
   47E8 EE 80         [ 7]  196 	xor	a, #0x80
   47EA D6 A0         [ 7]  197 	sub	a, #0xA0
   47EC 30 2B         [12]  198 	jr	NC,00105$
                            199 ;src/Renderer.c:231: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   47EE 7B            [ 4]  200 	ld	a,e
   47EF 57            [ 4]  201 	ld	d,a
   47F0 17            [ 4]  202 	rla
   47F1 9F            [ 4]  203 	sbc	a, a
   47F2 6F            [ 4]  204 	ld	l,a
   47F3 7A            [ 4]  205 	ld	a,d
   47F4 C6 40         [ 7]  206 	add	a, #0x40
   47F6 47            [ 4]  207 	ld	b,a
   47F7 7D            [ 4]  208 	ld	a,l
   47F8 CE 00         [ 7]  209 	adc	a, #0x00
   47FA 57            [ 4]  210 	ld	d,a
   47FB DD 6E F3      [19]  211 	ld	l,-13 (ix)
   47FE DD 7E F3      [19]  212 	ld	a,-13 (ix)
   4801 17            [ 4]  213 	rla
   4802 9F            [ 4]  214 	sbc	a, a
   4803 67            [ 4]  215 	ld	h,a
   4804 29            [11]  216 	add	hl, hl
   4805 29            [11]  217 	add	hl, hl
   4806 29            [11]  218 	add	hl, hl
   4807 29            [11]  219 	add	hl, hl
   4808 29            [11]  220 	add	hl, hl
   4809 78            [ 4]  221 	ld	a,b
   480A 85            [ 4]  222 	add	a, l
   480B 6F            [ 4]  223 	ld	l,a
   480C 7A            [ 4]  224 	ld	a,d
   480D 8C            [ 4]  225 	adc	a, h
   480E 67            [ 4]  226 	ld	h,a
   480F 46            [ 7]  227 	ld	b,(hl)
   4810 DD 6E FE      [19]  228 	ld	l,-2 (ix)
   4813 DD 66 FF      [19]  229 	ld	h,-1 (ix)
   4816 70            [ 7]  230 	ld	(hl),b
   4817 18 08         [12]  231 	jr	00106$
   4819                     232 00105$:
                            233 ;src/Renderer.c:234: cells_in_view_array[n]=1;
   4819 DD 6E FE      [19]  234 	ld	l,-2 (ix)
   481C DD 66 FF      [19]  235 	ld	h,-1 (ix)
   481F 36 01         [10]  236 	ld	(hl),#0x01
   4821                     237 00106$:
                            238 ;src/Renderer.c:238: if(vert){
   4821 DD 7E F2      [19]  239 	ld	a,-14 (ix)
   4824 B7            [ 4]  240 	or	a, a
   4825 28 07         [12]  241 	jr	Z,00111$
                            242 ;src/Renderer.c:239: x+=dx;
   4827 7B            [ 4]  243 	ld	a,e
   4828 DD 86 F5      [19]  244 	add	a, -11 (ix)
   482B 5F            [ 4]  245 	ld	e,a
   482C 18 09         [12]  246 	jr	00112$
   482E                     247 00111$:
                            248 ;src/Renderer.c:242: y+=dy;
   482E DD 7E F3      [19]  249 	ld	a,-13 (ix)
   4831 DD 86 F4      [19]  250 	add	a, -12 (ix)
   4834 DD 77 F3      [19]  251 	ld	-13 (ix),a
   4837                     252 00112$:
                            253 ;src/Renderer.c:244: ++n;
   4837 DD 34 FC      [23]  254 	inc	-4 (ix)
                            255 ;src/Renderer.c:228: for(i=offset;i<35-offset;++i){
   483A DD 34 F7      [23]  256 	inc	-9 (ix)
   483D C3 A7 47      [10]  257 	jp	00125$
   4840                     258 00143$:
   4840 DD 7E FC      [19]  259 	ld	a,-4 (ix)
   4843 DD 77 F9      [19]  260 	ld	-7 (ix),a
                            261 ;src/Renderer.c:246: offset=offsets_cells_in_view[j];
   4846 3E CE         [ 7]  262 	ld	a,#<(_offsets_cells_in_view)
   4848 DD 86 F8      [19]  263 	add	a, -8 (ix)
   484B 6F            [ 4]  264 	ld	l,a
   484C 3E 48         [ 7]  265 	ld	a,#>(_offsets_cells_in_view)
   484E CE 00         [ 7]  266 	adc	a, #0x00
   4850 67            [ 4]  267 	ld	h,a
   4851 7E            [ 7]  268 	ld	a,(hl)
                            269 ;src/Renderer.c:250: if(dx<0) x=x0-offset;
   4852 DD 77 FA      [19]  270 	ld	-6 (ix), a
   4855 DD 77 FE      [19]  271 	ld	-2 (ix),a
                            272 ;src/Renderer.c:248: if(vert){
   4858 DD 7E F2      [19]  273 	ld	a,-14 (ix)
   485B B7            [ 4]  274 	or	a, a
   485C 28 21         [12]  275 	jr	Z,00121$
                            276 ;src/Renderer.c:249: y-=dy;
   485E DD 7E F3      [19]  277 	ld	a,-13 (ix)
   4861 DD 96 F4      [19]  278 	sub	a, -12 (ix)
   4864 DD 77 F3      [19]  279 	ld	-13 (ix),a
                            280 ;src/Renderer.c:250: if(dx<0) x=x0-offset;
   4867 DD 7E FD      [19]  281 	ld	a,-3 (ix)
   486A B7            [ 4]  282 	or	a, a
   486B 28 09         [12]  283 	jr	Z,00115$
   486D DD 7E F6      [19]  284 	ld	a,-10 (ix)
   4870 DD 96 FE      [19]  285 	sub	a, -2 (ix)
   4873 5F            [ 4]  286 	ld	e,a
   4874 18 24         [12]  287 	jr	00128$
   4876                     288 00115$:
                            289 ;src/Renderer.c:251: else x=x0+offset;
   4876 DD 7E F6      [19]  290 	ld	a,-10 (ix)
   4879 DD 86 FE      [19]  291 	add	a, -2 (ix)
   487C 5F            [ 4]  292 	ld	e,a
   487D 18 1B         [12]  293 	jr	00128$
   487F                     294 00121$:
                            295 ;src/Renderer.c:255: x-=dx;
   487F 7B            [ 4]  296 	ld	a,e
   4880 DD 96 F5      [19]  297 	sub	a, -11 (ix)
   4883 5F            [ 4]  298 	ld	e,a
                            299 ;src/Renderer.c:256: if(dy<0) y=y0-offset;
   4884 DD 7E FB      [19]  300 	ld	a,-5 (ix)
   4887 B7            [ 4]  301 	or	a, a
   4888 28 09         [12]  302 	jr	Z,00118$
   488A 79            [ 4]  303 	ld	a,c
   488B DD 96 FE      [19]  304 	sub	a, -2 (ix)
   488E DD 77 F3      [19]  305 	ld	-13 (ix),a
   4891 18 07         [12]  306 	jr	00128$
   4893                     307 00118$:
                            308 ;src/Renderer.c:257: else y=y0+offset;
   4893 79            [ 4]  309 	ld	a,c
   4894 DD 86 FE      [19]  310 	add	a, -2 (ix)
   4897 DD 77 F3      [19]  311 	ld	-13 (ix),a
   489A                     312 00128$:
                            313 ;src/Renderer.c:226: for(j=0;j<6;++j){
   489A DD 34 F8      [23]  314 	inc	-8 (ix)
   489D DD 7E F8      [19]  315 	ld	a,-8 (ix)
   48A0 D6 06         [ 7]  316 	sub	a, #0x06
   48A2 DA 9B 47      [10]  317 	jp	C,00138$
   48A5 DD F9         [10]  318 	ld	sp, ix
   48A7 DD E1         [14]  319 	pop	ix
   48A9 C9            [10]  320 	ret
   48AA                     321 _g_palette:
   48AA 09                  322 	.db #0x09	; 9
   48AB 01                  323 	.db #0x01	; 1
   48AC 00                  324 	.db #0x00	; 0
   48AD 0D                  325 	.db #0x0D	; 13
   48AE 03                  326 	.db #0x03	; 3
   48AF 06                  327 	.db #0x06	; 6
   48B0 05                  328 	.db #0x05	; 5
   48B1 07                  329 	.db #0x07	; 7
   48B2 08                  330 	.db #0x08	; 8
   48B3 09                  331 	.db #0x09	; 9
   48B4 0A                  332 	.db #0x0A	; 10
   48B5 0B                  333 	.db #0x0B	; 11
   48B6 0C                  334 	.db #0x0C	; 12
   48B7 0D                  335 	.db #0x0D	; 13
   48B8 0E                  336 	.db #0x0E	; 14
   48B9 0F                  337 	.db #0x0F	; 15
   48BA                     338 _g_colors:
   48BA 00                  339 	.db #0x00	; 0
   48BB C0                  340 	.db #0xC0	; 192
   48BC 0C                  341 	.db #0x0C	; 12
   48BD CC                  342 	.db #0xCC	; 204
   48BE 30                  343 	.db #0x30	; 48	'0'
   48BF F0                  344 	.db #0xF0	; 240
   48C0 3C                  345 	.db #0x3C	; 60
   48C1 FC                  346 	.db #0xFC	; 252
   48C2 03                  347 	.db #0x03	; 3
   48C3 C3                  348 	.db #0xC3	; 195
   48C4 0F                  349 	.db #0x0F	; 15
   48C5 CF                  350 	.db #0xCF	; 207
   48C6 33                  351 	.db #0x33	; 51	'3'
   48C7 F3                  352 	.db #0xF3	; 243
   48C8 3F                  353 	.db #0x3F	; 63
   48C9 FF                  354 	.db #0xFF	; 255
   48CA                     355 _pixelMask:
   48CA AA                  356 	.db #0xAA	; 170
   48CB 55                  357 	.db #0x55	; 85	'U'
   48CC                     358 _cells_in_view_array:
   48CC E0 2B               359 	.dw #0x2BE0
   48CE                     360 _offsets_cells_in_view:
   48CE 08                  361 	.db #0x08	; 8
   48CF 0C                  362 	.db #0x0C	; 12
   48D0 0E                  363 	.db #0x0E	; 14
   48D1 0F                  364 	.db #0x0F	; 15
   48D2 10                  365 	.db #0x10	; 16
                            366 ;src/Renderer.c:263: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
                            367 ;	---------------------------------
                            368 ; Function draw_column_to_buffer
                            369 ; ---------------------------------
   48D3                     370 _draw_column_to_buffer::
   48D3 DD E5         [15]  371 	push	ix
   48D5 DD 21 00 00   [14]  372 	ld	ix,#0
   48D9 DD 39         [15]  373 	add	ix,sp
   48DB 21 EF FF      [10]  374 	ld	hl,#-17
   48DE 39            [11]  375 	add	hl,sp
   48DF F9            [ 6]  376 	ld	sp,hl
                            377 ;src/Renderer.c:264: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   48E0 DD 7E 04      [19]  378 	ld	a,4 (ix)
   48E3 CB 3F         [ 8]  379 	srl	a
   48E5 C6 40         [ 7]  380 	add	a, #0x40
   48E7 DD 77 F4      [19]  381 	ld	-12 (ix),a
   48EA 3E 00         [ 7]  382 	ld	a,#0x00
   48EC CE 1C         [ 7]  383 	adc	a, #0x1C
   48EE DD 77 F5      [19]  384 	ld	-11 (ix),a
                            385 ;src/Renderer.c:266: u8 w_color, start=0,end=SCREEN_TEXTURE_HEIGHT;
   48F1 DD 36 F6 00   [19]  386 	ld	-10 (ix),#0x00
   48F5 DD 36 F7 64   [19]  387 	ld	-9 (ix),#0x64
                            388 ;src/Renderer.c:267: u8 pixMask = pixelMask[column&1];
   48F9 01 CA 48      [10]  389 	ld	bc,#_pixelMask+0
   48FC DD 7E 04      [19]  390 	ld	a,4 (ix)
   48FF E6 01         [ 7]  391 	and	a, #0x01
   4901 6F            [ 4]  392 	ld	l, a
   4902 26 00         [ 7]  393 	ld	h,#0x00
   4904 09            [11]  394 	add	hl,bc
   4905 7E            [ 7]  395 	ld	a,(hl)
   4906 DD 77 F8      [19]  396 	ld	-8 (ix),a
                            397 ;src/Renderer.c:274: u8* texture = (u8*)(UNCOMPRESSED_LEVEL_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
   4909 DD 7E 06      [19]  398 	ld	a, 6 (ix)
   490C 87            [ 4]  399 	add	a, a
   490D 87            [ 4]  400 	add	a, a
   490E 47            [ 4]  401 	ld	b,a
   490F 0E 00         [ 7]  402 	ld	c,#0x00
   4911 21 40 08      [10]  403 	ld	hl,#0x0840
   4914 09            [11]  404 	add	hl,bc
   4915 4D            [ 4]  405 	ld	c,l
   4916 44            [ 4]  406 	ld	b,h
   4917 DD 6E 07      [19]  407 	ld	l,7 (ix)
   491A 26 00         [ 7]  408 	ld	h,#0x00
   491C 29            [11]  409 	add	hl, hl
   491D 29            [11]  410 	add	hl, hl
   491E 29            [11]  411 	add	hl, hl
   491F 29            [11]  412 	add	hl, hl
   4920 29            [11]  413 	add	hl, hl
   4921 09            [11]  414 	add	hl,bc
   4922 DD 75 FA      [19]  415 	ld	-6 (ix),l
   4925 DD 74 FB      [19]  416 	ld	-5 (ix),h
                            417 ;src/Renderer.c:282: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
   4928 DD 7E 05      [19]  418 	ld	a,5 (ix)
   492B DD 77 FE      [19]  419 	ld	-2 (ix),a
   492E DD 36 FF 00   [19]  420 	ld	-1 (ix),#0x00
   4932 DD 6E FE      [19]  421 	ld	l,-2 (ix)
   4935 DD 66 FF      [19]  422 	ld	h,-1 (ix)
   4938 E5            [11]  423 	push	hl
   4939 21 00 20      [10]  424 	ld	hl,#0x2000
   493C E5            [11]  425 	push	hl
   493D CD 4E 5E      [17]  426 	call	__divsint
   4940 F1            [10]  427 	pop	af
   4941 F1            [10]  428 	pop	af
   4942 DD 75 F1      [19]  429 	ld	-15 (ix),l
   4945 DD 74 F2      [19]  430 	ld	-14 (ix),h
                            431 ;src/Renderer.c:283: u16 wall_texture_line=0;
   4948 21 00 00      [10]  432 	ld	hl,#0x0000
   494B E3            [19]  433 	ex	(sp), hl
                            434 ;src/Renderer.c:288: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   494C DD 4E 05      [19]  435 	ld	c,5 (ix)
   494F CB 39         [ 8]  436 	srl	c
   4951 3E 32         [ 7]  437 	ld	a,#0x32
   4953 91            [ 4]  438 	sub	a, c
                            439 ;src/Renderer.c:289: ground_height = ceiling_height + lineHeight;
   4954 4F            [ 4]  440 	ld	c,a
   4955 DD 86 05      [19]  441 	add	a, 5 (ix)
   4958 DD 77 F3      [19]  442 	ld	-13 (ix),a
                            443 ;src/Renderer.c:292: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   495B 3E 64         [ 7]  444 	ld	a,#0x64
   495D DD 96 05      [19]  445 	sub	a, 5 (ix)
   4960 30 52         [12]  446 	jr	NC,00118$
                            447 ;src/Renderer.c:293: start=(lineHeight-SCREEN_TEXTURE_HEIGHT)/2;
   4962 DD 7E FE      [19]  448 	ld	a,-2 (ix)
   4965 C6 9C         [ 7]  449 	add	a,#0x9C
   4967 4F            [ 4]  450 	ld	c,a
   4968 DD 7E FF      [19]  451 	ld	a,-1 (ix)
   496B CE FF         [ 7]  452 	adc	a,#0xFF
   496D 47            [ 4]  453 	ld	b,a
   496E DD 71 FC      [19]  454 	ld	-4 (ix),c
   4971 DD 70 FD      [19]  455 	ld	-3 (ix),b
   4974 CB 78         [ 8]  456 	bit	7, b
   4976 28 10         [12]  457 	jr	Z,00112$
   4978 DD 7E FE      [19]  458 	ld	a,-2 (ix)
   497B C6 9D         [ 7]  459 	add	a, #0x9D
   497D DD 77 FC      [19]  460 	ld	-4 (ix),a
   4980 DD 7E FF      [19]  461 	ld	a,-1 (ix)
   4983 CE FF         [ 7]  462 	adc	a, #0xFF
   4985 DD 77 FD      [19]  463 	ld	-3 (ix),a
   4988                     464 00112$:
   4988 DD 4E FC      [19]  465 	ld	c,-4 (ix)
   498B DD 46 FD      [19]  466 	ld	b,-3 (ix)
   498E CB 28         [ 8]  467 	sra	b
   4990 CB 19         [ 8]  468 	rr	c
                            469 ;src/Renderer.c:294: end+=start;
   4992 DD 71 F6      [19]  470 	ld	-10 (ix), c
   4995 79            [ 4]  471 	ld	a, c
   4996 C6 64         [ 7]  472 	add	a, #0x64
   4998 DD 77 F7      [19]  473 	ld	-9 (ix),a
                            474 ;src/Renderer.c:295: ceiling_height=0;
   499B 0E 00         [ 7]  475 	ld	c,#0x00
                            476 ;src/Renderer.c:296: wall_texture_line = start * wall_texture_line_add;
   499D DD 5E F6      [19]  477 	ld	e,-10 (ix)
   49A0 16 00         [ 7]  478 	ld	d,#0x00
   49A2 C5            [11]  479 	push	bc
   49A3 DD 6E F1      [19]  480 	ld	l,-15 (ix)
   49A6 DD 66 F2      [19]  481 	ld	h,-14 (ix)
   49A9 E5            [11]  482 	push	hl
   49AA D5            [11]  483 	push	de
   49AB CD 98 5D      [17]  484 	call	__mulint
   49AE F1            [10]  485 	pop	af
   49AF F1            [10]  486 	pop	af
   49B0 C1            [10]  487 	pop	bc
   49B1 33            [ 6]  488 	inc	sp
   49B2 33            [ 6]  489 	inc	sp
   49B3 E5            [11]  490 	push	hl
                            491 ;src/Renderer.c:301: for(j=start;j<end;++j){
   49B4                     492 00118$:
   49B4 DD 7E F8      [19]  493 	ld	a,-8 (ix)
   49B7 2F            [ 4]  494 	cpl
   49B8 DD 77 FC      [19]  495 	ld	-4 (ix),a
   49BB DD 5E F4      [19]  496 	ld	e,-12 (ix)
   49BE DD 56 F5      [19]  497 	ld	d,-11 (ix)
   49C1 DD 46 F6      [19]  498 	ld	b,-10 (ix)
   49C4                     499 00108$:
   49C4 78            [ 4]  500 	ld	a,b
   49C5 DD 96 F7      [19]  501 	sub	a, -9 (ix)
   49C8 30 41         [12]  502 	jr	NC,00110$
                            503 ;src/Renderer.c:302: val =  ((*pvmem)&(~pixMask));
   49CA 1A            [ 7]  504 	ld	a,(de)
   49CB DD A6 FC      [19]  505 	and	a, -4 (ix)
   49CE DD 77 F9      [19]  506 	ld	-7 (ix),a
                            507 ;src/Renderer.c:304: if((j>=ceiling_height) && (j<ground_height)){
   49D1 78            [ 4]  508 	ld	a,b
   49D2 B9            [ 4]  509 	cp	a,c
   49D3 38 2E         [12]  510 	jr	C,00104$
   49D5 DD 96 F3      [19]  511 	sub	a, -13 (ix)
   49D8 30 29         [12]  512 	jr	NC,00104$
                            513 ;src/Renderer.c:306: w_color = (*(texture+(wall_texture_line/256))&pixMask);
   49DA DD 6E F0      [19]  514 	ld	l,-16 (ix)
   49DD 26 00         [ 7]  515 	ld	h,#0x00
   49DF DD 7E FA      [19]  516 	ld	a,-6 (ix)
   49E2 85            [ 4]  517 	add	a, l
   49E3 6F            [ 4]  518 	ld	l,a
   49E4 DD 7E FB      [19]  519 	ld	a,-5 (ix)
   49E7 8C            [ 4]  520 	adc	a, h
   49E8 67            [ 4]  521 	ld	h,a
   49E9 7E            [ 7]  522 	ld	a,(hl)
   49EA DD A6 F8      [19]  523 	and	a, -8 (ix)
                            524 ;src/Renderer.c:308: *pvmem = val|w_color;
   49ED DD B6 F9      [19]  525 	or	a, -7 (ix)
   49F0 12            [ 7]  526 	ld	(de),a
                            527 ;src/Renderer.c:310: wall_texture_line += wall_texture_line_add;
   49F1 DD 7E EF      [19]  528 	ld	a,-17 (ix)
   49F4 DD 86 F1      [19]  529 	add	a, -15 (ix)
   49F7 DD 77 EF      [19]  530 	ld	-17 (ix),a
   49FA DD 7E F0      [19]  531 	ld	a,-16 (ix)
   49FD DD 8E F2      [19]  532 	adc	a, -14 (ix)
   4A00 DD 77 F0      [19]  533 	ld	-16 (ix),a
   4A03                     534 00104$:
                            535 ;src/Renderer.c:312: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   4A03 21 28 00      [10]  536 	ld	hl,#0x0028
   4A06 19            [11]  537 	add	hl,de
   4A07 EB            [ 4]  538 	ex	de,hl
                            539 ;src/Renderer.c:301: for(j=start;j<end;++j){
   4A08 04            [ 4]  540 	inc	b
   4A09 18 B9         [12]  541 	jr	00108$
   4A0B                     542 00110$:
   4A0B DD F9         [10]  543 	ld	sp, ix
   4A0D DD E1         [14]  544 	pop	ix
   4A0F C9            [10]  545 	ret
                            546 ;src/Renderer.c:316: void render_draw_to_buffer(){//TODO Optimize
                            547 ;	---------------------------------
                            548 ; Function render_draw_to_buffer
                            549 ; ---------------------------------
   4A10                     550 _render_draw_to_buffer::
   4A10 DD E5         [15]  551 	push	ix
   4A12 DD 21 00 00   [14]  552 	ld	ix,#0
   4A16 DD 39         [15]  553 	add	ix,sp
   4A18 21 D3 FF      [10]  554 	ld	hl,#-45
   4A1B 39            [11]  555 	add	hl,sp
   4A1C F9            [ 6]  556 	ld	sp,hl
                            557 ;src/Renderer.c:326: u8 zHeight = 5;
   4A1D DD 36 D5 05   [19]  558 	ld	-43 (ix),#0x05
                            559 ;src/Renderer.c:332: u8 offsetDiff = 16;
   4A21 DD 36 D3 10   [19]  560 	ld	-45 (ix),#0x10
                            561 ;src/Renderer.c:337: u8 lineStart = 0;
   4A25 DD 36 D6 00   [19]  562 	ld	-42 (ix),#0x00
                            563 ;src/Renderer.c:339: u8 lateralWallWidth=0;
   4A29 DD 36 DD 00   [19]  564 	ld	-35 (ix),#0x00
                            565 ;src/Renderer.c:351: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   4A2D 21 BB 48      [10]  566 	ld	hl, #_g_colors + 1
   4A30 46            [ 7]  567 	ld	b,(hl)
   4A31 21 A8 07      [10]  568 	ld	hl,#0x07A8
   4A34 E5            [11]  569 	push	hl
   4A35 C5            [11]  570 	push	bc
   4A36 33            [ 6]  571 	inc	sp
   4A37 21 40 1C      [10]  572 	ld	hl,#0x1C40
   4A3A E5            [11]  573 	push	hl
   4A3B CD 2F 5E      [17]  574 	call	_cpct_memset
                            575 ;src/Renderer.c:352: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
   4A3E 21 BC 48      [10]  576 	ld	hl, #_g_colors + 2
   4A41 46            [ 7]  577 	ld	b,(hl)
   4A42 21 50 00      [10]  578 	ld	hl,#0x0050
   4A45 E5            [11]  579 	push	hl
   4A46 C5            [11]  580 	push	bc
   4A47 33            [ 6]  581 	inc	sp
   4A48 21 E8 23      [10]  582 	ld	hl,#0x23E8
   4A4B E5            [11]  583 	push	hl
   4A4C CD 2F 5E      [17]  584 	call	_cpct_memset
                            585 ;src/Renderer.c:353: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   4A4F 21 BA 48      [10]  586 	ld	hl, #_g_colors + 0
   4A52 46            [ 7]  587 	ld	b,(hl)
   4A53 21 A8 07      [10]  588 	ld	hl,#0x07A8
   4A56 E5            [11]  589 	push	hl
   4A57 C5            [11]  590 	push	bc
   4A58 33            [ 6]  591 	inc	sp
   4A59 21 38 24      [10]  592 	ld	hl,#0x2438
   4A5C E5            [11]  593 	push	hl
   4A5D CD 2F 5E      [17]  594 	call	_cpct_memset
                            595 ;src/Renderer.c:355: calculate_cells_in_view();
   4A60 CD FB 46      [17]  596 	call	_calculate_cells_in_view
                            597 ;src/Renderer.c:358: do{
   4A63 DD 36 E1 06   [19]  598 	ld	-31 (ix),#0x06
   4A67                     599 00165$:
                            600 ;src/Renderer.c:360: --z;
   4A67 DD 35 E1      [23]  601 	dec	-31 (ix)
                            602 ;src/Renderer.c:364: xCellCount = (z) ? (zHeight >> 1) : 0;
   4A6A DD 7E D5      [19]  603 	ld	a,-43 (ix)
   4A6D CB 3F         [ 8]  604 	srl	a
   4A6F DD 77 F4      [19]  605 	ld	-12 (ix),a
   4A72 DD 7E E1      [19]  606 	ld	a,-31 (ix)
   4A75 B7            [ 4]  607 	or	a, a
   4A76 28 05         [12]  608 	jr	Z,00174$
   4A78 DD 4E F4      [19]  609 	ld	c,-12 (ix)
   4A7B 18 02         [12]  610 	jr	00175$
   4A7D                     611 00174$:
   4A7D 0E 00         [ 7]  612 	ld	c,#0x00
   4A7F                     613 00175$:
   4A7F DD 71 F9      [19]  614 	ld	-7 (ix),c
                            615 ;src/Renderer.c:365: lateralWallSlope=0;
   4A82 DD 36 FA 00   [19]  616 	ld	-6 (ix),#0x00
                            617 ;src/Renderer.c:366: lateralWallSlopeCounter=0;
   4A86 DD 36 F2 00   [19]  618 	ld	-14 (ix),#0x00
                            619 ;src/Renderer.c:367: xHeight=0;
   4A8A DD 36 E3 00   [19]  620 	ld	-29 (ix),#0x00
                            621 ;src/Renderer.c:369: lateralWallCounter = 0;
   4A8E DD 36 F3 00   [19]  622 	ld	-13 (ix),#0x00
                            623 ;src/Renderer.c:371: newCell=1;
   4A92 DD 36 FB 01   [19]  624 	ld	-5 (ix),#0x01
                            625 ;src/Renderer.c:372: currentCellID = cells_in_view_array[lineStart + 1];
   4A96 DD 7E D6      [19]  626 	ld	a,-42 (ix)
   4A99 DD 77 E7      [19]  627 	ld	-25 (ix),a
   4A9C DD 36 E8 00   [19]  628 	ld	-24 (ix),#0x00
   4AA0 DD 4E E7      [19]  629 	ld	c,-25 (ix)
   4AA3 DD 46 E8      [19]  630 	ld	b,-24 (ix)
   4AA6 03            [ 6]  631 	inc	bc
   4AA7 2A CC 48      [16]  632 	ld	hl,(_cells_in_view_array)
   4AAA DD 75 E4      [19]  633 	ld	-28 (ix),l
   4AAD DD 74 E5      [19]  634 	ld	-27 (ix),h
   4AB0 DD 6E E4      [19]  635 	ld	l,-28 (ix)
   4AB3 DD 66 E5      [19]  636 	ld	h,-27 (ix)
   4AB6 09            [11]  637 	add	hl,bc
   4AB7 7E            [ 7]  638 	ld	a,(hl)
   4AB8 DD 77 E9      [19]  639 	ld	-23 (ix),a
                            640 ;src/Renderer.c:374: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   4ABB DD 7E E4      [19]  641 	ld	a,-28 (ix)
   4ABE DD 86 D6      [19]  642 	add	a, -42 (ix)
   4AC1 6F            [ 4]  643 	ld	l,a
   4AC2 DD 7E E5      [19]  644 	ld	a,-27 (ix)
   4AC5 CE 00         [ 7]  645 	adc	a, #0x00
   4AC7 67            [ 4]  646 	ld	h,a
   4AC8 7E            [ 7]  647 	ld	a,(hl)
                            648 ;src/Renderer.c:375: if(lastCellWasWall<5){
   4AC9 DD 77 EA      [19]  649 	ld	-22 (ix), a
   4ACC D6 05         [ 7]  650 	sub	a, #0x05
   4ACE 30 06         [12]  651 	jr	NC,00102$
                            652 ;src/Renderer.c:376: lastWallId=lastCellWasWall;
                            653 ;src/Renderer.c:377: lastCellWasWall=1;
   4AD0 DD 36 E6 01   [19]  654 	ld	-26 (ix),#0x01
   4AD4 18 08         [12]  655 	jr	00193$
   4AD6                     656 00102$:
                            657 ;src/Renderer.c:380: lastCellWasWall=0;
   4AD6 DD 36 E6 00   [19]  658 	ld	-26 (ix),#0x00
                            659 ;src/Renderer.c:381: lastWallId=CELLTYPE_FLOOR;
   4ADA DD 36 EA FE   [19]  660 	ld	-22 (ix),#0xFE
                            661 ;src/Renderer.c:384: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   4ADE                     662 00193$:
   4ADE DD 36 D7 00   [19]  663 	ld	-41 (ix),#0x00
   4AE2 DD 36 DF 00   [19]  664 	ld	-33 (ix),#0x00
   4AE6                     665 00168$:
                            666 ;src/Renderer.c:386: if (xCellCount == zHeight)
   4AE6 DD 7E D5      [19]  667 	ld	a,-43 (ix)
   4AE9 DD 96 F9      [19]  668 	sub	a, -7 (ix)
   4AEC 20 4B         [12]  669 	jr	NZ,00105$
                            670 ;src/Renderer.c:388: ++xCell;
   4AEE DD 34 D7      [23]  671 	inc	-41 (ix)
                            672 ;src/Renderer.c:389: xCellCount = 0;
   4AF1 DD 36 F9 00   [19]  673 	ld	-7 (ix),#0x00
                            674 ;src/Renderer.c:390: newCell=1;
   4AF5 DD 36 FB 01   [19]  675 	ld	-5 (ix),#0x01
                            676 ;src/Renderer.c:391: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   4AF9 DD 7E D7      [19]  677 	ld	a,-41 (ix)
   4AFC DD 77 EB      [19]  678 	ld	-21 (ix),a
   4AFF DD 36 EC 00   [19]  679 	ld	-20 (ix),#0x00
   4B03 DD 7E E7      [19]  680 	ld	a,-25 (ix)
   4B06 DD 86 EB      [19]  681 	add	a, -21 (ix)
   4B09 DD 77 EB      [19]  682 	ld	-21 (ix),a
   4B0C DD 7E E8      [19]  683 	ld	a,-24 (ix)
   4B0F DD 8E EC      [19]  684 	adc	a, -20 (ix)
   4B12 DD 77 EC      [19]  685 	ld	-20 (ix),a
   4B15 DD 34 EB      [23]  686 	inc	-21 (ix)
   4B18 20 03         [12]  687 	jr	NZ,00320$
   4B1A DD 34 EC      [23]  688 	inc	-20 (ix)
   4B1D                     689 00320$:
   4B1D DD 7E EB      [19]  690 	ld	a,-21 (ix)
   4B20 DD 86 E4      [19]  691 	add	a, -28 (ix)
   4B23 DD 77 EB      [19]  692 	ld	-21 (ix),a
   4B26 DD 7E EC      [19]  693 	ld	a,-20 (ix)
   4B29 DD 8E E5      [19]  694 	adc	a, -27 (ix)
   4B2C DD 77 EC      [19]  695 	ld	-20 (ix),a
   4B2F DD 6E EB      [19]  696 	ld	l,-21 (ix)
   4B32 DD 66 EC      [19]  697 	ld	h,-20 (ix)
   4B35 7E            [ 7]  698 	ld	a,(hl)
   4B36 DD 77 E9      [19]  699 	ld	-23 (ix),a
   4B39                     700 00105$:
                            701 ;src/Renderer.c:393: if(!(x%2)){
   4B39 DD 7E DF      [19]  702 	ld	a,-33 (ix)
   4B3C E6 01         [ 7]  703 	and	a, #0x01
   4B3E DD 77 EB      [19]  704 	ld	-21 (ix),a
                            705 ;src/Renderer.c:415: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4B41 DD 7E F9      [19]  706 	ld	a,-7 (ix)
   4B44 DD 77 ED      [19]  707 	ld	-19 (ix),a
   4B47 DD 36 EE 00   [19]  708 	ld	-18 (ix),#0x00
   4B4B DD 7E D5      [19]  709 	ld	a,-43 (ix)
   4B4E DD 77 F1      [19]  710 	ld	-15 (ix),a
                            711 ;src/Renderer.c:393: if(!(x%2)){
   4B51 DD 7E EB      [19]  712 	ld	a,-21 (ix)
   4B54 B7            [ 4]  713 	or	a, a
   4B55 C2 05 4C      [10]  714 	jp	NZ,00118$
                            715 ;src/Renderer.c:394: if ((lateralWallCounter == 0)||newCell)
   4B58 DD 7E F3      [19]  716 	ld	a,-13 (ix)
   4B5B B7            [ 4]  717 	or	a, a
   4B5C 28 07         [12]  718 	jr	Z,00114$
   4B5E DD 7E FB      [19]  719 	ld	a,-5 (ix)
   4B61 B7            [ 4]  720 	or	a, a
   4B62 CA 05 4C      [10]  721 	jp	Z,00118$
   4B65                     722 00114$:
                            723 ;src/Renderer.c:396: if (currentCellID < 5)//Wall
   4B65 DD 7E E9      [19]  724 	ld	a,-23 (ix)
   4B68 D6 05         [ 7]  725 	sub	a, #0x05
   4B6A 30 20         [12]  726 	jr	NC,00112$
                            727 ;src/Renderer.c:398: lateralWallCounter = 0;//(zHeight - xCellCount);
   4B6C DD 36 F3 00   [19]  728 	ld	-13 (ix),#0x00
                            729 ;src/Renderer.c:399: lateralWallSlope = 0;
   4B70 DD 36 FA 00   [19]  730 	ld	-6 (ix),#0x00
                            731 ;src/Renderer.c:400: xHeight = zHeight;
   4B74 DD 7E D5      [19]  732 	ld	a,-43 (ix)
   4B77 DD 77 E3      [19]  733 	ld	-29 (ix),a
                            734 ;src/Renderer.c:401: color = currentCellID;
   4B7A DD 7E E9      [19]  735 	ld	a,-23 (ix)
   4B7D DD 77 D4      [19]  736 	ld	-44 (ix),a
                            737 ;src/Renderer.c:402: lastCellWasWall = 1;
   4B80 DD 36 E6 01   [19]  738 	ld	-26 (ix),#0x01
                            739 ;src/Renderer.c:403: lastWallId=currentCellID;
   4B84 DD 7E E9      [19]  740 	ld	a,-23 (ix)
   4B87 DD 77 EA      [19]  741 	ld	-22 (ix),a
   4B8A 18 75         [12]  742 	jr	00113$
   4B8C                     743 00112$:
                            744 ;src/Renderer.c:405: else if(lateralWallCounter==0){//Lateral wall not finished
   4B8C DD 7E F3      [19]  745 	ld	a,-13 (ix)
   4B8F B7            [ 4]  746 	or	a, a
   4B90 20 6F         [12]  747 	jr	NZ,00113$
                            748 ;src/Renderer.c:406: if (lastCellWasWall)
   4B92 DD 7E E6      [19]  749 	ld	a,-26 (ix)
   4B95 B7            [ 4]  750 	or	a, a
   4B96 28 59         [12]  751 	jr	Z,00107$
                            752 ;src/Renderer.c:409: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   4B98 DD 7E D3      [19]  753 	ld	a,-45 (ix)
   4B9B DD 96 D7      [19]  754 	sub	a, -41 (ix)
   4B9E 87            [ 4]  755 	add	a, a
   4B9F 3C            [ 4]  756 	inc	a
                            757 ;src/Renderer.c:410: lateralWallSlopeCounter = lateralWallSlope / 2;
   4BA0 DD 77 FA      [19]  758 	ld	-6 (ix), a
   4BA3 CB 3F         [ 8]  759 	srl	a
   4BA5 DD 77 F2      [19]  760 	ld	-14 (ix),a
                            761 ;src/Renderer.c:411: lateralWallCounter = lateralWallSlope * zHeight;
   4BA8 DD 5E D5      [19]  762 	ld	e,-43 (ix)
   4BAB DD 66 FA      [19]  763 	ld	h,-6 (ix)
   4BAE 2E 00         [ 7]  764 	ld	l, #0x00
   4BB0 55            [ 4]  765 	ld	d, l
   4BB1 06 08         [ 7]  766 	ld	b, #0x08
   4BB3                     767 00321$:
   4BB3 29            [11]  768 	add	hl,hl
   4BB4 30 01         [12]  769 	jr	NC,00322$
   4BB6 19            [11]  770 	add	hl,de
   4BB7                     771 00322$:
   4BB7 10 FA         [13]  772 	djnz	00321$
                            773 ;src/Renderer.c:412: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   4BB9 7D            [ 4]  774 	ld	a,l
   4BBA E6 FC         [ 7]  775 	and	a, #0xFC
   4BBC CB C7         [ 8]  776 	set	0, a
   4BBE CB 3F         [ 8]  777 	srl	a
   4BC0 CB 3F         [ 8]  778 	srl	a
   4BC2 DD 96 F9      [19]  779 	sub	a, -7 (ix)
                            780 ;src/Renderer.c:413: lateralWallWidth=lateralWallCounter;
   4BC5 DD 77 F3      [19]  781 	ld	-13 (ix), a
   4BC8 DD 77 DD      [19]  782 	ld	-35 (ix),a
                            783 ;src/Renderer.c:414: lastCellWasWall = 0;
   4BCB DD 36 E6 00   [19]  784 	ld	-26 (ix),#0x00
                            785 ;src/Renderer.c:415: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4BCF DD 6E ED      [19]  786 	ld	l,-19 (ix)
   4BD2 DD 66 EE      [19]  787 	ld	h,-18 (ix)
   4BD5 29            [11]  788 	add	hl, hl
   4BD6 DD 4E FA      [19]  789 	ld	c,-6 (ix)
   4BD9 06 00         [ 7]  790 	ld	b,#0x00
   4BDB C5            [11]  791 	push	bc
   4BDC E5            [11]  792 	push	hl
   4BDD CD 4E 5E      [17]  793 	call	__divsint
   4BE0 F1            [10]  794 	pop	af
   4BE1 F1            [10]  795 	pop	af
   4BE2 DD 7E F1      [19]  796 	ld	a,-15 (ix)
   4BE5 95            [ 4]  797 	sub	a, l
   4BE6 DD 77 E3      [19]  798 	ld	-29 (ix),a
                            799 ;src/Renderer.c:416: color = lastWallId;
   4BE9 DD 7E EA      [19]  800 	ld	a,-22 (ix)
   4BEC DD 77 D4      [19]  801 	ld	-44 (ix),a
   4BEF 18 10         [12]  802 	jr	00113$
   4BF1                     803 00107$:
                            804 ;src/Renderer.c:420: xHeight = 0;
   4BF1 DD 36 E3 00   [19]  805 	ld	-29 (ix),#0x00
                            806 ;src/Renderer.c:421: lastCellWasWall = 0;
   4BF5 DD 36 E6 00   [19]  807 	ld	-26 (ix),#0x00
                            808 ;src/Renderer.c:422: lateralWallSlope=0;
   4BF9 DD 36 FA 00   [19]  809 	ld	-6 (ix),#0x00
                            810 ;src/Renderer.c:423: lastWallId=0;
   4BFD DD 36 EA 00   [19]  811 	ld	-22 (ix),#0x00
   4C01                     812 00113$:
                            813 ;src/Renderer.c:426: newCell=0;
   4C01 DD 36 FB 00   [19]  814 	ld	-5 (ix),#0x00
   4C05                     815 00118$:
                            816 ;src/Renderer.c:429: if (lateralWallCounter > 0)
   4C05 DD 7E F3      [19]  817 	ld	a,-13 (ix)
   4C08 B7            [ 4]  818 	or	a, a
   4C09 28 1E         [12]  819 	jr	Z,00124$
                            820 ;src/Renderer.c:432: if (lateralWallSlope != 0)
   4C0B DD 7E FA      [19]  821 	ld	a,-6 (ix)
   4C0E B7            [ 4]  822 	or	a, a
   4C0F 28 15         [12]  823 	jr	Z,00122$
                            824 ;src/Renderer.c:434: if (lateralWallSlopeCounter == lateralWallSlope)
   4C11 DD 7E FA      [19]  825 	ld	a,-6 (ix)
   4C14 DD 96 F2      [19]  826 	sub	a, -14 (ix)
   4C17 20 0A         [12]  827 	jr	NZ,00120$
                            828 ;src/Renderer.c:436: lateralWallSlopeCounter = 0;
   4C19 DD 36 F2 00   [19]  829 	ld	-14 (ix),#0x00
                            830 ;src/Renderer.c:437: xHeight -= 2;
   4C1D DD 35 E3      [23]  831 	dec	-29 (ix)
   4C20 DD 35 E3      [23]  832 	dec	-29 (ix)
   4C23                     833 00120$:
                            834 ;src/Renderer.c:439: ++lateralWallSlopeCounter;
   4C23 DD 34 F2      [23]  835 	inc	-14 (ix)
   4C26                     836 00122$:
                            837 ;src/Renderer.c:442: --lateralWallCounter;
   4C26 DD 35 F3      [23]  838 	dec	-13 (ix)
   4C29                     839 00124$:
                            840 ;src/Renderer.c:453: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   4C29 DD 7E D5      [19]  841 	ld	a,-43 (ix)
   4C2C DD 77 F5      [19]  842 	ld	-11 (ix),a
   4C2F DD 36 F6 00   [19]  843 	ld	-10 (ix),#0x00
                            844 ;src/Renderer.c:445: if (!(x%2))
   4C33 DD 7E EB      [19]  845 	ld	a,-21 (ix)
   4C36 B7            [ 4]  846 	or	a, a
   4C37 20 59         [12]  847 	jr	NZ,00131$
                            848 ;src/Renderer.c:447: if(xHeight > 0){
   4C39 DD 7E E3      [19]  849 	ld	a,-29 (ix)
   4C3C B7            [ 4]  850 	or	a, a
   4C3D 28 53         [12]  851 	jr	Z,00131$
                            852 ;src/Renderer.c:448: if (lateralWallCounter > 0)
   4C3F DD 7E F3      [19]  853 	ld	a,-13 (ix)
   4C42 B7            [ 4]  854 	or	a, a
   4C43 28 1F         [12]  855 	jr	Z,00126$
                            856 ;src/Renderer.c:450: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   4C45 DD 4E DD      [19]  857 	ld	c,-35 (ix)
   4C48 06 00         [ 7]  858 	ld	b,#0x00
   4C4A DD 5E F3      [19]  859 	ld	e,-13 (ix)
   4C4D 16 00         [ 7]  860 	ld	d,#0x00
   4C4F 79            [ 4]  861 	ld	a,c
   4C50 93            [ 4]  862 	sub	a, e
   4C51 6F            [ 4]  863 	ld	l,a
   4C52 78            [ 4]  864 	ld	a,b
   4C53 9A            [ 4]  865 	sbc	a, d
   4C54 67            [ 4]  866 	ld	h,a
   4C55 29            [11]  867 	add	hl, hl
   4C56 29            [11]  868 	add	hl, hl
   4C57 29            [11]  869 	add	hl, hl
   4C58 29            [11]  870 	add	hl, hl
   4C59 29            [11]  871 	add	hl, hl
   4C5A C5            [11]  872 	push	bc
   4C5B E5            [11]  873 	push	hl
   4C5C CD 4E 5E      [17]  874 	call	__divsint
   4C5F F1            [10]  875 	pop	af
   4C60 F1            [10]  876 	pop	af
   4C61 45            [ 4]  877 	ld	b,l
   4C62 18 19         [12]  878 	jr	00127$
   4C64                     879 00126$:
                            880 ;src/Renderer.c:453: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   4C64 DD 6E ED      [19]  881 	ld	l,-19 (ix)
   4C67 DD 66 EE      [19]  882 	ld	h,-18 (ix)
   4C6A 29            [11]  883 	add	hl, hl
   4C6B 29            [11]  884 	add	hl, hl
   4C6C 29            [11]  885 	add	hl, hl
   4C6D 29            [11]  886 	add	hl, hl
   4C6E 29            [11]  887 	add	hl, hl
   4C6F DD 4E F5      [19]  888 	ld	c,-11 (ix)
   4C72 DD 46 F6      [19]  889 	ld	b,-10 (ix)
   4C75 C5            [11]  890 	push	bc
   4C76 E5            [11]  891 	push	hl
   4C77 CD 4E 5E      [17]  892 	call	__divsint
   4C7A F1            [10]  893 	pop	af
   4C7B F1            [10]  894 	pop	af
   4C7C 45            [ 4]  895 	ld	b,l
   4C7D                     896 00127$:
                            897 ;src/Renderer.c:455: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   4C7D DD 56 DF      [19]  898 	ld	d,-33 (ix)
   4C80 CB 3A         [ 8]  899 	srl	d
   4C82 C5            [11]  900 	push	bc
   4C83 33            [ 6]  901 	inc	sp
   4C84 DD 66 D4      [19]  902 	ld	h,-44 (ix)
   4C87 DD 6E E3      [19]  903 	ld	l,-29 (ix)
   4C8A E5            [11]  904 	push	hl
   4C8B D5            [11]  905 	push	de
   4C8C 33            [ 6]  906 	inc	sp
   4C8D CD D3 48      [17]  907 	call	_draw_column_to_buffer
   4C90 F1            [10]  908 	pop	af
   4C91 F1            [10]  909 	pop	af
   4C92                     910 00131$:
                            911 ;src/Renderer.c:459: ++xCellCount;
   4C92 DD 34 F9      [23]  912 	inc	-7 (ix)
                            913 ;src/Renderer.c:384: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   4C95 DD 34 DF      [23]  914 	inc	-33 (ix)
                            915 ;src/Renderer.c:372: currentCellID = cells_in_view_array[lineStart + 1];
   4C98 2A CC 48      [16]  916 	ld	hl,(_cells_in_view_array)
   4C9B DD 75 E4      [19]  917 	ld	-28 (ix),l
   4C9E DD 74 E5      [19]  918 	ld	-27 (ix),h
                            919 ;src/Renderer.c:384: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   4CA1 DD 7E DF      [19]  920 	ld	a,-33 (ix)
   4CA4 D6 50         [ 7]  921 	sub	a, #0x50
   4CA6 DA E6 4A      [10]  922 	jp	C,00168$
                            923 ;src/Renderer.c:466: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   4CA9 DD 7E E1      [19]  924 	ld	a,-31 (ix)
   4CAC B7            [ 4]  925 	or	a, a
   4CAD 28 05         [12]  926 	jr	Z,00176$
   4CAF DD 4E F4      [19]  927 	ld	c,-12 (ix)
   4CB2 18 02         [12]  928 	jr	00177$
   4CB4                     929 00176$:
   4CB4 0E 00         [ 7]  930 	ld	c,#0x00
   4CB6                     931 00177$:
   4CB6 DD 71 D9      [19]  932 	ld	-39 (ix),c
                            933 ;src/Renderer.c:467: lateralWallSlope=0;
   4CB9 DD 36 DA 00   [19]  934 	ld	-38 (ix),#0x00
                            935 ;src/Renderer.c:468: lateralWallSlopeCounter=0;
   4CBD DD 36 E2 00   [19]  936 	ld	-30 (ix),#0x00
                            937 ;src/Renderer.c:469: xHeight=0;
   4CC1 DD 36 E0 00   [19]  938 	ld	-32 (ix),#0x00
                            939 ;src/Renderer.c:471: lateralWallCounter = 0;
   4CC5 DD 36 ED 00   [19]  940 	ld	-19 (ix),#0x00
                            941 ;src/Renderer.c:472: lineEnd = lineStart + offsetDiff * 2 + 2;
   4CC9 DD 7E D3      [19]  942 	ld	a,-45 (ix)
   4CCC 87            [ 4]  943 	add	a, a
   4CCD 4F            [ 4]  944 	ld	c,a
   4CCE DD 7E D6      [19]  945 	ld	a,-42 (ix)
   4CD1 81            [ 4]  946 	add	a, c
   4CD2 DD 77 EB      [19]  947 	ld	-21 (ix), a
   4CD5 4F            [ 4]  948 	ld	c, a
   4CD6 0C            [ 4]  949 	inc	c
   4CD7 0C            [ 4]  950 	inc	c
                            951 ;src/Renderer.c:474: newCell=1;
   4CD8 DD 36 D8 01   [19]  952 	ld	-40 (ix),#0x01
                            953 ;src/Renderer.c:475: currentCellID = cells_in_view_array[lineEnd - 1];
   4CDC DD 71 E7      [19]  954 	ld	-25 (ix),c
   4CDF DD 36 E8 00   [19]  955 	ld	-24 (ix),#0x00
   4CE3 DD 5E E7      [19]  956 	ld	e,-25 (ix)
   4CE6 DD 56 E8      [19]  957 	ld	d,-24 (ix)
   4CE9 1B            [ 6]  958 	dec	de
   4CEA DD 6E E4      [19]  959 	ld	l,-28 (ix)
   4CED DD 66 E5      [19]  960 	ld	h,-27 (ix)
   4CF0 19            [11]  961 	add	hl,de
   4CF1 7E            [ 7]  962 	ld	a,(hl)
   4CF2 DD 77 DB      [19]  963 	ld	-37 (ix),a
                            964 ;src/Renderer.c:477: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   4CF5 DD 6E E4      [19]  965 	ld	l,-28 (ix)
   4CF8 DD 66 E5      [19]  966 	ld	h,-27 (ix)
   4CFB 06 00         [ 7]  967 	ld	b,#0x00
   4CFD 09            [11]  968 	add	hl, bc
   4CFE 4E            [ 7]  969 	ld	c,(hl)
                            970 ;src/Renderer.c:478: if(lastCellWasWall<5){
   4CFF 79            [ 4]  971 	ld	a,c
   4D00 D6 05         [ 7]  972 	sub	a, #0x05
   4D02 30 09         [12]  973 	jr	NC,00134$
                            974 ;src/Renderer.c:479: lastWallId=lastCellWasWall;
   4D04 DD 71 DC      [19]  975 	ld	-36 (ix),c
                            976 ;src/Renderer.c:480: lastCellWasWall=1;
   4D07 DD 36 E6 01   [19]  977 	ld	-26 (ix),#0x01
   4D0B 18 08         [12]  978 	jr	00210$
   4D0D                     979 00134$:
                            980 ;src/Renderer.c:483: lastCellWasWall=0;
   4D0D DD 36 E6 00   [19]  981 	ld	-26 (ix),#0x00
                            982 ;src/Renderer.c:484: lastWallId=CELLTYPE_FLOOR;
   4D11 DD 36 DC FE   [19]  983 	ld	-36 (ix),#0xFE
                            984 ;src/Renderer.c:487: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   4D15                     985 00210$:
   4D15 DD 36 D7 00   [19]  986 	ld	-41 (ix),#0x00
   4D19 DD 36 DF 9F   [19]  987 	ld	-33 (ix),#0x9F
   4D1D                     988 00170$:
                            989 ;src/Renderer.c:490: if (xCellCount == zHeight)
   4D1D DD 7E D5      [19]  990 	ld	a,-43 (ix)
   4D20 DD 96 D9      [19]  991 	sub	a, -39 (ix)
   4D23 20 59         [12]  992 	jr	NZ,00137$
                            993 ;src/Renderer.c:492: ++xCell;
   4D25 DD 34 D7      [23]  994 	inc	-41 (ix)
                            995 ;src/Renderer.c:493: xCellCount = 0;
   4D28 DD 36 D9 00   [19]  996 	ld	-39 (ix),#0x00
                            997 ;src/Renderer.c:494: newCell=1;
   4D2C DD 36 D8 01   [19]  998 	ld	-40 (ix),#0x01
                            999 ;src/Renderer.c:495: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   4D30 DD 7E D7      [19] 1000 	ld	a,-41 (ix)
   4D33 DD 77 E4      [19] 1001 	ld	-28 (ix),a
   4D36 DD 36 E5 00   [19] 1002 	ld	-27 (ix),#0x00
   4D3A DD 7E E7      [19] 1003 	ld	a,-25 (ix)
   4D3D DD 96 E4      [19] 1004 	sub	a, -28 (ix)
   4D40 DD 77 E4      [19] 1005 	ld	-28 (ix),a
   4D43 DD 7E E8      [19] 1006 	ld	a,-24 (ix)
   4D46 DD 9E E5      [19] 1007 	sbc	a, -27 (ix)
   4D49 DD 77 E5      [19] 1008 	ld	-27 (ix),a
   4D4C DD 6E E4      [19] 1009 	ld	l,-28 (ix)
   4D4F DD 66 E5      [19] 1010 	ld	h,-27 (ix)
   4D52 2B            [ 6] 1011 	dec	hl
   4D53 DD 75 E4      [19] 1012 	ld	-28 (ix),l
   4D56 DD 74 E5      [19] 1013 	ld	-27 (ix),h
   4D59 2A CC 48      [16] 1014 	ld	hl,(_cells_in_view_array)
   4D5C DD 75 F7      [19] 1015 	ld	-9 (ix),l
   4D5F DD 74 F8      [19] 1016 	ld	-8 (ix),h
   4D62 DD 7E E4      [19] 1017 	ld	a,-28 (ix)
   4D65 DD 86 F7      [19] 1018 	add	a, -9 (ix)
   4D68 DD 77 F7      [19] 1019 	ld	-9 (ix),a
   4D6B DD 7E E5      [19] 1020 	ld	a,-27 (ix)
   4D6E DD 8E F8      [19] 1021 	adc	a, -8 (ix)
   4D71 DD 77 F8      [19] 1022 	ld	-8 (ix),a
   4D74 DD 6E F7      [19] 1023 	ld	l,-9 (ix)
   4D77 DD 66 F8      [19] 1024 	ld	h,-8 (ix)
   4D7A 7E            [ 7] 1025 	ld	a,(hl)
   4D7B DD 77 DB      [19] 1026 	ld	-37 (ix),a
   4D7E                    1027 00137$:
                           1028 ;src/Renderer.c:497: if(!(x%2)){
   4D7E DD 7E DF      [19] 1029 	ld	a,-33 (ix)
   4D81 E6 01         [ 7] 1030 	and	a, #0x01
   4D83 DD 77 F7      [19] 1031 	ld	-9 (ix),a
                           1032 ;src/Renderer.c:415: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4D86 DD 7E D9      [19] 1033 	ld	a,-39 (ix)
   4D89 DD 77 E4      [19] 1034 	ld	-28 (ix),a
   4D8C DD 36 E5 00   [19] 1035 	ld	-27 (ix),#0x00
                           1036 ;src/Renderer.c:497: if(!(x%2)){
   4D90 DD 7E F7      [19] 1037 	ld	a,-9 (ix)
   4D93 B7            [ 4] 1038 	or	a, a
   4D94 C2 E2 4E      [10] 1039 	jp	NZ,00150$
                           1040 ;src/Renderer.c:498: if (lateralWallCounter == 0 || newCell)
   4D97 DD 7E ED      [19] 1041 	ld	a,-19 (ix)
   4D9A B7            [ 4] 1042 	or	a, a
   4D9B 28 07         [12] 1043 	jr	Z,00146$
   4D9D DD 7E D8      [19] 1044 	ld	a,-40 (ix)
   4DA0 B7            [ 4] 1045 	or	a, a
   4DA1 CA E2 4E      [10] 1046 	jp	Z,00150$
   4DA4                    1047 00146$:
                           1048 ;src/Renderer.c:500: if ( currentCellID < 5)//Wall
   4DA4 DD 7E DB      [19] 1049 	ld	a,-37 (ix)
   4DA7 D6 05         [ 7] 1050 	sub	a, #0x05
   4DA9 30 21         [12] 1051 	jr	NC,00144$
                           1052 ;src/Renderer.c:502: lateralWallCounter = 0;
   4DAB DD 36 ED 00   [19] 1053 	ld	-19 (ix),#0x00
                           1054 ;src/Renderer.c:503: lateralWallSlope = 0;
   4DAF DD 36 DA 00   [19] 1055 	ld	-38 (ix),#0x00
                           1056 ;src/Renderer.c:504: xHeight = zHeight;
   4DB3 DD 7E D5      [19] 1057 	ld	a,-43 (ix)
   4DB6 DD 77 E0      [19] 1058 	ld	-32 (ix),a
                           1059 ;src/Renderer.c:505: color = currentCellID;
   4DB9 DD 7E DB      [19] 1060 	ld	a,-37 (ix)
   4DBC DD 77 D4      [19] 1061 	ld	-44 (ix),a
                           1062 ;src/Renderer.c:506: lastCellWasWall = 1;
   4DBF DD 36 E6 01   [19] 1063 	ld	-26 (ix),#0x01
                           1064 ;src/Renderer.c:507: lastWallId=currentCellID;
   4DC3 DD 7E DB      [19] 1065 	ld	a,-37 (ix)
   4DC6 DD 77 DC      [19] 1066 	ld	-36 (ix),a
   4DC9 C3 DE 4E      [10] 1067 	jp	00145$
   4DCC                    1068 00144$:
                           1069 ;src/Renderer.c:509: else if(lateralWallCounter==0){
   4DCC DD 7E ED      [19] 1070 	ld	a,-19 (ix)
   4DCF B7            [ 4] 1071 	or	a, a
   4DD0 C2 DE 4E      [10] 1072 	jp	NZ,00145$
                           1073 ;src/Renderer.c:510: if (lastCellWasWall)
   4DD3 DD 7E E6      [19] 1074 	ld	a,-26 (ix)
   4DD6 B7            [ 4] 1075 	or	a, a
   4DD7 CA CE 4E      [10] 1076 	jp	Z,00139$
                           1077 ;src/Renderer.c:513: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   4DDA DD 7E D3      [19] 1078 	ld	a,-45 (ix)
   4DDD DD 96 D7      [19] 1079 	sub	a, -41 (ix)
   4DE0 87            [ 4] 1080 	add	a, a
   4DE1 3C            [ 4] 1081 	inc	a
                           1082 ;src/Renderer.c:514: lateralWallSlopeCounter = lateralWallSlope / 2;
   4DE2 DD 77 DA      [19] 1083 	ld	-38 (ix), a
   4DE5 CB 3F         [ 8] 1084 	srl	a
   4DE7 DD 77 E2      [19] 1085 	ld	-30 (ix),a
                           1086 ;src/Renderer.c:515: lateralWallCounter = lateralWallSlope * zHeight;
   4DEA DD 5E D5      [19] 1087 	ld	e,-43 (ix)
   4DED DD 66 DA      [19] 1088 	ld	h,-38 (ix)
   4DF0 2E 00         [ 7] 1089 	ld	l, #0x00
   4DF2 55            [ 4] 1090 	ld	d, l
   4DF3 06 08         [ 7] 1091 	ld	b, #0x08
   4DF5                    1092 00327$:
   4DF5 29            [11] 1093 	add	hl,hl
   4DF6 30 01         [12] 1094 	jr	NC,00328$
   4DF8 19            [11] 1095 	add	hl,de
   4DF9                    1096 00328$:
   4DF9 10 FA         [13] 1097 	djnz	00327$
   4DFB DD 75 EA      [19] 1098 	ld	-22 (ix), l
   4DFE 7D            [ 4] 1099 	ld	a, l
                           1100 ;src/Renderer.c:516: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   4DFF DD 77 DE      [19] 1101 	ld	-34 (ix), a
   4E02 DD 77 FC      [19] 1102 	ld	-4 (ix),a
   4E05 DD 36 FD 00   [19] 1103 	ld	-3 (ix),#0x00
   4E09 DD 7E DE      [19] 1104 	ld	a,-34 (ix)
   4E0C E6 03         [ 7] 1105 	and	a, #0x03
   4E0E DD 77 EA      [19] 1106 	ld	-22 (ix), a
   4E11 DD 77 FE      [19] 1107 	ld	-2 (ix),a
   4E14 DD 36 FF 00   [19] 1108 	ld	-1 (ix),#0x00
   4E18 DD 7E FC      [19] 1109 	ld	a,-4 (ix)
   4E1B DD 96 FE      [19] 1110 	sub	a, -2 (ix)
   4E1E DD 77 FE      [19] 1111 	ld	-2 (ix),a
   4E21 DD 7E FD      [19] 1112 	ld	a,-3 (ix)
   4E24 DD 9E FF      [19] 1113 	sbc	a, -1 (ix)
   4E27 DD 77 FF      [19] 1114 	ld	-1 (ix),a
   4E2A DD 7E FE      [19] 1115 	ld	a,-2 (ix)
   4E2D C6 01         [ 7] 1116 	add	a, #0x01
   4E2F DD 77 FC      [19] 1117 	ld	-4 (ix),a
   4E32 DD 7E FF      [19] 1118 	ld	a,-1 (ix)
   4E35 CE 00         [ 7] 1119 	adc	a, #0x00
   4E37 DD 77 FD      [19] 1120 	ld	-3 (ix),a
   4E3A DD 7E FC      [19] 1121 	ld	a,-4 (ix)
   4E3D DD 77 EF      [19] 1122 	ld	-17 (ix),a
   4E40 DD 7E FD      [19] 1123 	ld	a,-3 (ix)
   4E43 DD 77 F0      [19] 1124 	ld	-16 (ix),a
   4E46 DD CB FD 7E   [20] 1125 	bit	7, -3 (ix)
   4E4A 28 10         [12] 1126 	jr	Z,00178$
   4E4C DD 7E FE      [19] 1127 	ld	a,-2 (ix)
   4E4F C6 04         [ 7] 1128 	add	a, #0x04
   4E51 DD 77 EF      [19] 1129 	ld	-17 (ix),a
   4E54 DD 7E FF      [19] 1130 	ld	a,-1 (ix)
   4E57 CE 00         [ 7] 1131 	adc	a, #0x00
   4E59 DD 77 F0      [19] 1132 	ld	-16 (ix),a
   4E5C                    1133 00178$:
   4E5C DD CB F0 2E   [23] 1134 	sra	-16 (ix)
   4E60 DD CB EF 1E   [23] 1135 	rr	-17 (ix)
   4E64 DD CB F0 2E   [23] 1136 	sra	-16 (ix)
   4E68 DD CB EF 1E   [23] 1137 	rr	-17 (ix)
   4E6C DD 7E EF      [19] 1138 	ld	a,-17 (ix)
   4E6F DD 77 EF      [19] 1139 	ld	-17 (ix),a
   4E72 DD 4E D9      [19] 1140 	ld	c,-39 (ix)
   4E75 DD 7E EF      [19] 1141 	ld	a,-17 (ix)
   4E78 91            [ 4] 1142 	sub	a, c
                           1143 ;src/Renderer.c:517: lateralWallWidth=lateralWallCounter;
   4E79 DD 77 ED      [19] 1144 	ld	-19 (ix), a
   4E7C DD 77 DD      [19] 1145 	ld	-35 (ix),a
                           1146 ;src/Renderer.c:518: lastCellWasWall = 0;
   4E7F DD 36 E6 00   [19] 1147 	ld	-26 (ix),#0x00
                           1148 ;src/Renderer.c:519: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   4E83 DD 7E E4      [19] 1149 	ld	a,-28 (ix)
   4E86 DD 77 EF      [19] 1150 	ld	-17 (ix),a
   4E89 DD 7E E5      [19] 1151 	ld	a,-27 (ix)
   4E8C DD 77 F0      [19] 1152 	ld	-16 (ix),a
   4E8F DD CB EF 26   [23] 1153 	sla	-17 (ix)
   4E93 DD CB F0 16   [23] 1154 	rl	-16 (ix)
   4E97 DD 7E DA      [19] 1155 	ld	a,-38 (ix)
   4E9A DD 77 FE      [19] 1156 	ld	-2 (ix),a
   4E9D DD 36 FF 00   [19] 1157 	ld	-1 (ix),#0x00
   4EA1 DD 6E FE      [19] 1158 	ld	l,-2 (ix)
   4EA4 DD 66 FF      [19] 1159 	ld	h,-1 (ix)
   4EA7 E5            [11] 1160 	push	hl
   4EA8 DD 6E EF      [19] 1161 	ld	l,-17 (ix)
   4EAB DD 66 F0      [19] 1162 	ld	h,-16 (ix)
   4EAE E5            [11] 1163 	push	hl
   4EAF CD 4E 5E      [17] 1164 	call	__divsint
   4EB2 F1            [10] 1165 	pop	af
   4EB3 F1            [10] 1166 	pop	af
   4EB4 DD 74 F0      [19] 1167 	ld	-16 (ix),h
   4EB7 DD 75 EF      [19] 1168 	ld	-17 (ix), l
   4EBA DD 75 EF      [19] 1169 	ld	-17 (ix), l
   4EBD DD 7E F1      [19] 1170 	ld	a,-15 (ix)
   4EC0 DD 96 EF      [19] 1171 	sub	a, -17 (ix)
   4EC3 DD 77 E0      [19] 1172 	ld	-32 (ix),a
                           1173 ;src/Renderer.c:520: color = lastWallId;
   4EC6 DD 7E DC      [19] 1174 	ld	a,-36 (ix)
   4EC9 DD 77 D4      [19] 1175 	ld	-44 (ix),a
   4ECC 18 10         [12] 1176 	jr	00145$
   4ECE                    1177 00139$:
                           1178 ;src/Renderer.c:524: xHeight = 0;
   4ECE DD 36 E0 00   [19] 1179 	ld	-32 (ix),#0x00
                           1180 ;src/Renderer.c:525: lastCellWasWall = 0;
   4ED2 DD 36 E6 00   [19] 1181 	ld	-26 (ix),#0x00
                           1182 ;src/Renderer.c:526: lateralWallSlope=0;
   4ED6 DD 36 DA 00   [19] 1183 	ld	-38 (ix),#0x00
                           1184 ;src/Renderer.c:527: lastWallId=0;
   4EDA DD 36 DC 00   [19] 1185 	ld	-36 (ix),#0x00
   4EDE                    1186 00145$:
                           1187 ;src/Renderer.c:530: newCell=0;
   4EDE DD 36 D8 00   [19] 1188 	ld	-40 (ix),#0x00
   4EE2                    1189 00150$:
                           1190 ;src/Renderer.c:535: if (lateralWallCounter > 0)
   4EE2 DD 7E ED      [19] 1191 	ld	a,-19 (ix)
   4EE5 B7            [ 4] 1192 	or	a, a
   4EE6 28 1E         [12] 1193 	jr	Z,00156$
                           1194 ;src/Renderer.c:538: if (lateralWallSlope != 0)
   4EE8 DD 7E DA      [19] 1195 	ld	a,-38 (ix)
   4EEB B7            [ 4] 1196 	or	a, a
   4EEC 28 15         [12] 1197 	jr	Z,00154$
                           1198 ;src/Renderer.c:540: if (lateralWallSlopeCounter == lateralWallSlope)
   4EEE DD 7E E2      [19] 1199 	ld	a,-30 (ix)
   4EF1 DD 96 DA      [19] 1200 	sub	a, -38 (ix)
   4EF4 20 0A         [12] 1201 	jr	NZ,00152$
                           1202 ;src/Renderer.c:542: lateralWallSlopeCounter = 0;
   4EF6 DD 36 E2 00   [19] 1203 	ld	-30 (ix),#0x00
                           1204 ;src/Renderer.c:543: xHeight -= 2;
   4EFA DD 35 E0      [23] 1205 	dec	-32 (ix)
   4EFD DD 35 E0      [23] 1206 	dec	-32 (ix)
   4F00                    1207 00152$:
                           1208 ;src/Renderer.c:545: ++lateralWallSlopeCounter;
   4F00 DD 34 E2      [23] 1209 	inc	-30 (ix)
   4F03                    1210 00154$:
                           1211 ;src/Renderer.c:547: --lateralWallCounter;
   4F03 DD 35 ED      [23] 1212 	dec	-19 (ix)
   4F06                    1213 00156$:
                           1214 ;src/Renderer.c:551: if (!(x%2))
   4F06 DD 7E F7      [19] 1215 	ld	a,-9 (ix)
   4F09 B7            [ 4] 1216 	or	a, a
   4F0A C2 A3 4F      [10] 1217 	jp	NZ,00163$
                           1218 ;src/Renderer.c:554: if(xHeight > 0){
   4F0D DD 7E E0      [19] 1219 	ld	a,-32 (ix)
   4F10 B7            [ 4] 1220 	or	a, a
   4F11 CA A3 4F      [10] 1221 	jp	Z,00163$
                           1222 ;src/Renderer.c:556: if (lateralWallCounter > 0)
   4F14 DD 7E ED      [19] 1223 	ld	a,-19 (ix)
   4F17 B7            [ 4] 1224 	or	a, a
   4F18 28 39         [12] 1225 	jr	Z,00158$
                           1226 ;src/Renderer.c:558: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   4F1A DD 7E ED      [19] 1227 	ld	a,-19 (ix)
   4F1D DD 77 EF      [19] 1228 	ld	-17 (ix),a
   4F20 DD 36 F0 00   [19] 1229 	ld	-16 (ix),#0x00
   4F24 3E 06         [ 7] 1230 	ld	a,#0x05+1
   4F26 18 08         [12] 1231 	jr	00334$
   4F28                    1232 00333$:
   4F28 DD CB EF 26   [23] 1233 	sla	-17 (ix)
   4F2C DD CB F0 16   [23] 1234 	rl	-16 (ix)
   4F30                    1235 00334$:
   4F30 3D            [ 4] 1236 	dec	a
   4F31 20 F5         [12] 1237 	jr	NZ,00333$
   4F33 DD 7E DD      [19] 1238 	ld	a,-35 (ix)
   4F36 DD 77 FE      [19] 1239 	ld	-2 (ix),a
   4F39 DD 36 FF 00   [19] 1240 	ld	-1 (ix),#0x00
   4F3D DD 6E FE      [19] 1241 	ld	l,-2 (ix)
   4F40 DD 66 FF      [19] 1242 	ld	h,-1 (ix)
   4F43 E5            [11] 1243 	push	hl
   4F44 DD 6E EF      [19] 1244 	ld	l,-17 (ix)
   4F47 DD 66 F0      [19] 1245 	ld	h,-16 (ix)
   4F4A E5            [11] 1246 	push	hl
   4F4B CD 4E 5E      [17] 1247 	call	__divsint
   4F4E F1            [10] 1248 	pop	af
   4F4F F1            [10] 1249 	pop	af
   4F50 55            [ 4] 1250 	ld	d,l
   4F51 18 3B         [12] 1251 	jr	00159$
   4F53                    1252 00158$:
                           1253 ;src/Renderer.c:561: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   4F53 DD 7E F5      [19] 1254 	ld	a,-11 (ix)
   4F56 DD 96 E4      [19] 1255 	sub	a, -28 (ix)
   4F59 DD 77 EF      [19] 1256 	ld	-17 (ix),a
   4F5C DD 7E F6      [19] 1257 	ld	a,-10 (ix)
   4F5F DD 9E E5      [19] 1258 	sbc	a, -27 (ix)
   4F62 DD 77 F0      [19] 1259 	ld	-16 (ix),a
   4F65 3E 06         [ 7] 1260 	ld	a,#0x05+1
   4F67 18 08         [12] 1261 	jr	00336$
   4F69                    1262 00335$:
   4F69 DD CB EF 26   [23] 1263 	sla	-17 (ix)
   4F6D DD CB F0 16   [23] 1264 	rl	-16 (ix)
   4F71                    1265 00336$:
   4F71 3D            [ 4] 1266 	dec	a
   4F72 20 F5         [12] 1267 	jr	NZ,00335$
   4F74 DD 6E F5      [19] 1268 	ld	l,-11 (ix)
   4F77 DD 66 F6      [19] 1269 	ld	h,-10 (ix)
   4F7A E5            [11] 1270 	push	hl
   4F7B DD 6E EF      [19] 1271 	ld	l,-17 (ix)
   4F7E DD 66 F0      [19] 1272 	ld	h,-16 (ix)
   4F81 E5            [11] 1273 	push	hl
   4F82 CD 4E 5E      [17] 1274 	call	__divsint
   4F85 F1            [10] 1275 	pop	af
   4F86 F1            [10] 1276 	pop	af
   4F87 DD 74 F0      [19] 1277 	ld	-16 (ix),h
   4F8A DD 75 EF      [19] 1278 	ld	-17 (ix), l
   4F8D 55            [ 4] 1279 	ld	d, l
   4F8E                    1280 00159$:
                           1281 ;src/Renderer.c:564: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   4F8E DD 46 DF      [19] 1282 	ld	b,-33 (ix)
   4F91 CB 38         [ 8] 1283 	srl	b
   4F93 D5            [11] 1284 	push	de
   4F94 33            [ 6] 1285 	inc	sp
   4F95 DD 66 D4      [19] 1286 	ld	h,-44 (ix)
   4F98 DD 6E E0      [19] 1287 	ld	l,-32 (ix)
   4F9B E5            [11] 1288 	push	hl
   4F9C C5            [11] 1289 	push	bc
   4F9D 33            [ 6] 1290 	inc	sp
   4F9E CD D3 48      [17] 1291 	call	_draw_column_to_buffer
   4FA1 F1            [10] 1292 	pop	af
   4FA2 F1            [10] 1293 	pop	af
   4FA3                    1294 00163$:
                           1295 ;src/Renderer.c:567: ++xCellCount;
   4FA3 DD 34 D9      [23] 1296 	inc	-39 (ix)
                           1297 ;src/Renderer.c:487: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   4FA6 DD 35 DF      [23] 1298 	dec	-33 (ix)
   4FA9 DD 7E DF      [19] 1299 	ld	a,-33 (ix)
   4FAC D6 50         [ 7] 1300 	sub	a, #0x50
   4FAE D2 1D 4D      [10] 1301 	jp	NC,00170$
                           1302 ;src/Renderer.c:574: lineStart = lineStart + (offsetDiff * 2) + 3;
   4FB1 DD 7E EB      [19] 1303 	ld	a,-21 (ix)
   4FB4 C6 03         [ 7] 1304 	add	a, #0x03
   4FB6 DD 77 D6      [19] 1305 	ld	-42 (ix),a
                           1306 ;src/Renderer.c:575: zHeight += zHeight;
   4FB9 DD CB D5 26   [23] 1307 	sla	-43 (ix)
                           1308 ;src/Renderer.c:576: offsetDiff = offsetDiff >> 1;
   4FBD DD CB D3 3E   [23] 1309 	srl	-45 (ix)
                           1310 ;src/Renderer.c:578: }while(z);
   4FC1 DD 7E E1      [19] 1311 	ld	a,-31 (ix)
   4FC4 B7            [ 4] 1312 	or	a, a
   4FC5 C2 67 4A      [10] 1313 	jp	NZ,00165$
   4FC8 DD F9         [10] 1314 	ld	sp, ix
   4FCA DD E1         [14] 1315 	pop	ix
   4FCC C9            [10] 1316 	ret
                           1317 ;src/Renderer.c:586: void draw_minimap_to_buffer(){
                           1318 ;	---------------------------------
                           1319 ; Function draw_minimap_to_buffer
                           1320 ; ---------------------------------
   4FCD                    1321 _draw_minimap_to_buffer::
   4FCD DD E5         [15] 1322 	push	ix
   4FCF DD 21 00 00   [14] 1323 	ld	ix,#0
   4FD3 DD 39         [15] 1324 	add	ix,sp
   4FD5 21 F5 FF      [10] 1325 	ld	hl,#-11
   4FD8 39            [11] 1326 	add	hl,sp
   4FD9 F9            [ 6] 1327 	ld	sp,hl
                           1328 ;src/Renderer.c:589: u8* ptr = MINIMAP_BUFFER;
   4FDA 01 40 1C      [10] 1329 	ld	bc,#0x1C40
                           1330 ;src/Renderer.c:594: y=(PLAYER_position.y-MINIMAP_HEIGHT_HALF);
   4FDD 3A EF 46      [13] 1331 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   4FE0 C6 F8         [ 7] 1332 	add	a,#0xF8
   4FE2 5F            [ 4] 1333 	ld	e,a
                           1334 ;src/Renderer.c:596: for(j=0;j<MINIMAP_HEIGHT;++j){
   4FE3 16 00         [ 7] 1335 	ld	d,#0x00
                           1336 ;src/Renderer.c:597: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   4FE5                    1337 00133$:
   4FE5 7B            [ 4] 1338 	ld	a,e
   4FE6 07            [ 4] 1339 	rlca
   4FE7 E6 01         [ 7] 1340 	and	a,#0x01
   4FE9 DD 77 F8      [19] 1341 	ld	-8 (ix),a
   4FEC 7B            [ 4] 1342 	ld	a,e
   4FED EE 80         [ 7] 1343 	xor	a, #0x80
   4FEF D6 A0         [ 7] 1344 	sub	a, #0xA0
   4FF1 3E 00         [ 7] 1345 	ld	a,#0x00
   4FF3 17            [ 4] 1346 	rla
   4FF4 DD 77 F7      [19] 1347 	ld	-9 (ix),a
   4FF7 DD 36 F5 00   [19] 1348 	ld	-11 (ix),#0x00
   4FFB                    1349 00119$:
                           1350 ;src/Renderer.c:598: x=(PLAYER_position.x-MINIMAP_WIDTH_HALF);
   4FFB 3A EE 46      [13] 1351 	ld	a, (#_PLAYER_position + 0)
   4FFE C6 F8         [ 7] 1352 	add	a,#0xF8
   5000 DD 77 FF      [19] 1353 	ld	-1 (ix),a
                           1354 ;src/Renderer.c:599: for(i=0;i<MINIMAP_WIDTH;++i){
   5003 DD 36 F6 00   [19] 1355 	ld	-10 (ix),#0x00
   5007                    1356 00117$:
                           1357 ;src/Renderer.c:602: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   5007 FD 21 10 00   [14] 1358 	ld	iy,#0x0010
   500B FD 09         [15] 1359 	add	iy, bc
                           1360 ;src/Renderer.c:600: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
   500D DD CB FF 7E   [20] 1361 	bit	7, -1 (ix)
   5011 20 15         [12] 1362 	jr	NZ,00108$
   5013 DD 7E FF      [19] 1363 	ld	a,-1 (ix)
   5016 EE 80         [ 7] 1364 	xor	a, #0x80
   5018 D6 A0         [ 7] 1365 	sub	a, #0xA0
   501A 30 0C         [12] 1366 	jr	NC,00108$
   501C DD 7E F8      [19] 1367 	ld	a,-8 (ix)
   501F B7            [ 4] 1368 	or	a, a
   5020 20 06         [12] 1369 	jr	NZ,00108$
   5022 DD CB F7 46   [20] 1370 	bit	0,-9 (ix)
   5026 20 0D         [12] 1371 	jr	NZ,00109$
   5028                    1372 00108$:
                           1373 ;src/Renderer.c:601: *ptr=g_colors[MINIMAP_WALL_COLOR];
   5028 3A BC 48      [13] 1374 	ld	a, (#(_g_colors + 0x0002) + 0)
   502B 02            [ 7] 1375 	ld	(bc),a
                           1376 ;src/Renderer.c:602: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   502C 3A BC 48      [13] 1377 	ld	a, (#(_g_colors + 0x0002) + 0)
   502F FD 77 00      [19] 1378 	ld	0 (iy), a
   5032 C3 CC 50      [10] 1379 	jp	00110$
   5035                    1380 00109$:
                           1381 ;src/Renderer.c:604: else if((x==PLAYER_position.x)&&(y==PLAYER_position.y)){
   5035 DD 7E FF      [19] 1382 	ld	a,-1 (ix)
   5038 DD 77 FD      [19] 1383 	ld	-3 (ix),a
   503B DD 7E FF      [19] 1384 	ld	a,-1 (ix)
   503E 17            [ 4] 1385 	rla
   503F 9F            [ 4] 1386 	sbc	a, a
   5040 DD 77 FE      [19] 1387 	ld	-2 (ix),a
   5043 3A EE 46      [13] 1388 	ld	a, (#_PLAYER_position + 0)
   5046 DD 77 FB      [19] 1389 	ld	-5 (ix),a
   5049 DD 36 FC 00   [19] 1390 	ld	-4 (ix),#0x00
   504D DD 73 F9      [19] 1391 	ld	-7 (ix),e
   5050 7B            [ 4] 1392 	ld	a,e
   5051 17            [ 4] 1393 	rla
   5052 9F            [ 4] 1394 	sbc	a, a
   5053 DD 77 FA      [19] 1395 	ld	-6 (ix),a
   5056 DD 7E FD      [19] 1396 	ld	a,-3 (ix)
   5059 DD 96 FB      [19] 1397 	sub	a, -5 (ix)
   505C 20 2E         [12] 1398 	jr	NZ,00105$
   505E DD 7E FE      [19] 1399 	ld	a,-2 (ix)
   5061 DD 96 FC      [19] 1400 	sub	a, -4 (ix)
   5064 20 26         [12] 1401 	jr	NZ,00105$
   5066 3A EF 46      [13] 1402 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   5069 DD 77 FB      [19] 1403 	ld	-5 (ix),a
   506C DD 36 FC 00   [19] 1404 	ld	-4 (ix),#0x00
   5070 DD 7E F9      [19] 1405 	ld	a,-7 (ix)
   5073 DD 96 FB      [19] 1406 	sub	a, -5 (ix)
   5076 20 14         [12] 1407 	jr	NZ,00105$
   5078 DD 7E FA      [19] 1408 	ld	a,-6 (ix)
   507B DD 96 FC      [19] 1409 	sub	a, -4 (ix)
   507E 20 0C         [12] 1410 	jr	NZ,00105$
                           1411 ;src/Renderer.c:605: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
   5080 3A BF 48      [13] 1412 	ld	a, (#(_g_colors + 0x0005) + 0)
   5083 02            [ 7] 1413 	ld	(bc),a
                           1414 ;src/Renderer.c:606: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
   5084 3A BF 48      [13] 1415 	ld	a, (#(_g_colors + 0x0005) + 0)
   5087 FD 77 00      [19] 1416 	ld	0 (iy), a
   508A 18 40         [12] 1417 	jr	00110$
   508C                    1418 00105$:
                           1419 ;src/Renderer.c:609: switch(*(u8*)(MAP_MEM+x+y*MAP_WIDTH)){
   508C DD 7E FD      [19] 1420 	ld	a,-3 (ix)
   508F C6 40         [ 7] 1421 	add	a, #0x40
   5091 DD 77 FB      [19] 1422 	ld	-5 (ix),a
   5094 DD 7E FE      [19] 1423 	ld	a,-2 (ix)
   5097 CE 00         [ 7] 1424 	adc	a, #0x00
   5099 DD 77 FC      [19] 1425 	ld	-4 (ix),a
   509C DD 6E F9      [19] 1426 	ld	l,-7 (ix)
   509F DD 66 FA      [19] 1427 	ld	h,-6 (ix)
   50A2 29            [11] 1428 	add	hl, hl
   50A3 29            [11] 1429 	add	hl, hl
   50A4 29            [11] 1430 	add	hl, hl
   50A5 29            [11] 1431 	add	hl, hl
   50A6 29            [11] 1432 	add	hl, hl
   50A7 DD 7E FB      [19] 1433 	ld	a,-5 (ix)
   50AA 85            [ 4] 1434 	add	a, l
   50AB 6F            [ 4] 1435 	ld	l,a
   50AC DD 7E FC      [19] 1436 	ld	a,-4 (ix)
   50AF 8C            [ 4] 1437 	adc	a, h
   50B0 67            [ 4] 1438 	ld	h,a
   50B1 7E            [ 7] 1439 	ld	a,(hl)
   50B2 D6 FE         [ 7] 1440 	sub	a, #0xFE
   50B4 20 0C         [12] 1441 	jr	NZ,00102$
                           1442 ;src/Renderer.c:611: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
   50B6 3A BD 48      [13] 1443 	ld	a, (#(_g_colors + 0x0003) + 0)
   50B9 02            [ 7] 1444 	ld	(bc),a
                           1445 ;src/Renderer.c:612: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
   50BA 3A BD 48      [13] 1446 	ld	a, (#(_g_colors + 0x0003) + 0)
   50BD FD 77 00      [19] 1447 	ld	0 (iy), a
                           1448 ;src/Renderer.c:613: break;
   50C0 18 0A         [12] 1449 	jr	00110$
                           1450 ;src/Renderer.c:615: default:{
   50C2                    1451 00102$:
                           1452 ;src/Renderer.c:616: *ptr=g_colors[MINIMAP_WALL_COLOR];
   50C2 3A BC 48      [13] 1453 	ld	a, (#(_g_colors + 0x0002) + 0)
   50C5 02            [ 7] 1454 	ld	(bc),a
                           1455 ;src/Renderer.c:617: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   50C6 3A BC 48      [13] 1456 	ld	a, (#(_g_colors + 0x0002) + 0)
   50C9 FD 77 00      [19] 1457 	ld	0 (iy), a
                           1458 ;src/Renderer.c:620: }
   50CC                    1459 00110$:
                           1460 ;src/Renderer.c:622: ++x;
   50CC DD 34 FF      [23] 1461 	inc	-1 (ix)
                           1462 ;src/Renderer.c:623: ++ptr;
   50CF 03            [ 6] 1463 	inc	bc
                           1464 ;src/Renderer.c:599: for(i=0;i<MINIMAP_WIDTH;++i){
   50D0 DD 34 F6      [23] 1465 	inc	-10 (ix)
   50D3 DD 7E F6      [19] 1466 	ld	a,-10 (ix)
   50D6 D6 10         [ 7] 1467 	sub	a, #0x10
   50D8 DA 07 50      [10] 1468 	jp	C,00117$
                           1469 ;src/Renderer.c:597: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   50DB DD 34 F5      [23] 1470 	inc	-11 (ix)
   50DE DD 7E F5      [19] 1471 	ld	a,-11 (ix)
   50E1 D6 04         [ 7] 1472 	sub	a, #0x04
   50E3 DA FB 4F      [10] 1473 	jp	C,00119$
                           1474 ;src/Renderer.c:626: ++y;
   50E6 1C            [ 4] 1475 	inc	e
                           1476 ;src/Renderer.c:596: for(j=0;j<MINIMAP_HEIGHT;++j){
   50E7 14            [ 4] 1477 	inc	d
   50E8 7A            [ 4] 1478 	ld	a,d
   50E9 D6 10         [ 7] 1479 	sub	a, #0x10
   50EB DA E5 4F      [10] 1480 	jp	C,00133$
   50EE DD F9         [10] 1481 	ld	sp, ix
   50F0 DD E1         [14] 1482 	pop	ix
   50F2 C9            [10] 1483 	ret
                           1484 	.area _CODE
                           1485 	.area _INITIALIZER
                           1486 	.area _CABS (ABS)
