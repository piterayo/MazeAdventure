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
                             52 ;src/Renderer.c:206: void calculate_cells_in_view(){
                             53 ;	---------------------------------
                             54 ; Function calculate_cells_in_view
                             55 ; ---------------------------------
   46E1                      56 _calculate_cells_in_view::
   46E1 DD E5         [15]   57 	push	ix
   46E3 DD 21 00 00   [14]   58 	ld	ix,#0
   46E7 DD 39         [15]   59 	add	ix,sp
   46E9 21 F2 FF      [10]   60 	ld	hl,#-14
   46EC 39            [11]   61 	add	hl,sp
   46ED F9            [ 6]   62 	ld	sp,hl
                             63 ;src/Renderer.c:208: u8 offset=0, n=0, j, i;
   46EE DD 36 FA 00   [19]   64 	ld	-6 (ix),#0x00
   46F2 DD 36 F9 00   [19]   65 	ld	-7 (ix),#0x00
                             66 ;src/Renderer.c:211: if(PLAYER_direction.y!=0){
   46F6 3A D7 46      [13]   67 	ld	a,(#_PLAYER_direction + 1)
   46F9 DD 77 FC      [19]   68 	ld	-4 (ix), a
   46FC B7            [ 4]   69 	or	a, a
   46FD 28 32         [12]   70 	jr	Z,00102$
                             71 ;src/Renderer.c:212: vert=1;
   46FF DD 36 F2 01   [19]   72 	ld	-14 (ix),#0x01
                             73 ;src/Renderer.c:213: dy=PLAYER_direction.y;
   4703 DD 4E FC      [19]   74 	ld	c,-4 (ix)
   4706 DD 71 F4      [19]   75 	ld	-12 (ix),c
                             76 ;src/Renderer.c:214: dx=-PLAYER_direction.y;
   4709 AF            [ 4]   77 	xor	a, a
   470A DD 96 FC      [19]   78 	sub	a, -4 (ix)
   470D DD 77 F5      [19]   79 	ld	-11 (ix), a
                             80 ;src/Renderer.c:216: x0 = PLAYER_position.x-(17*dx);
   4710 21 D4 46      [10]   81 	ld	hl,#_PLAYER_position+0
   4713 4E            [ 7]   82 	ld	c,(hl)
   4714 DD 6E F5      [19]   83 	ld	l,-11 (ix)
   4717 5D            [ 4]   84 	ld	e,l
   4718 29            [11]   85 	add	hl, hl
   4719 29            [11]   86 	add	hl, hl
   471A 29            [11]   87 	add	hl, hl
   471B 29            [11]   88 	add	hl, hl
   471C 19            [11]   89 	add	hl, de
   471D 79            [ 4]   90 	ld	a,c
   471E 95            [ 4]   91 	sub	a, l
   471F DD 77 F6      [19]   92 	ld	-10 (ix),a
                             93 ;src/Renderer.c:217: y0 = PLAYER_position.y+(6*dy);
   4722 21 D5 46      [10]   94 	ld	hl,#_PLAYER_position+1
   4725 4E            [ 7]   95 	ld	c,(hl)
   4726 DD 6E F4      [19]   96 	ld	l,-12 (ix)
   4729 5D            [ 4]   97 	ld	e,l
   472A 29            [11]   98 	add	hl, hl
   472B 19            [11]   99 	add	hl, de
   472C 29            [11]  100 	add	hl, hl
   472D 09            [11]  101 	add	hl, bc
   472E 4D            [ 4]  102 	ld	c,l
   472F 18 34         [12]  103 	jr	00103$
   4731                     104 00102$:
                            105 ;src/Renderer.c:220: vert=0;
   4731 DD 36 F2 00   [19]  106 	ld	-14 (ix),#0x00
                            107 ;src/Renderer.c:221: dy=PLAYER_direction.x;
   4735 3A D6 46      [13]  108 	ld	a,(#_PLAYER_direction + 0)
   4738 DD 77 FC      [19]  109 	ld	-4 (ix), a
   473B DD 77 F4      [19]  110 	ld	-12 (ix),a
                            111 ;src/Renderer.c:222: dx=PLAYER_direction.x;
   473E DD 7E FC      [19]  112 	ld	a,-4 (ix)
   4741 DD 77 F5      [19]  113 	ld	-11 (ix),a
                            114 ;src/Renderer.c:224: y0 = PLAYER_position.y-(17*dy);
   4744 21 D5 46      [10]  115 	ld	hl, #_PLAYER_position + 1
   4747 4E            [ 7]  116 	ld	c,(hl)
   4748 DD 6E F4      [19]  117 	ld	l,-12 (ix)
   474B 5D            [ 4]  118 	ld	e,l
   474C 29            [11]  119 	add	hl, hl
   474D 29            [11]  120 	add	hl, hl
   474E 29            [11]  121 	add	hl, hl
   474F 29            [11]  122 	add	hl, hl
   4750 19            [11]  123 	add	hl, de
   4751 79            [ 4]  124 	ld	a,c
   4752 95            [ 4]  125 	sub	a, l
   4753 4F            [ 4]  126 	ld	c,a
                            127 ;src/Renderer.c:225: x0 = PLAYER_position.x+(6*dx);
   4754 21 D4 46      [10]  128 	ld	hl, #_PLAYER_position + 0
   4757 46            [ 7]  129 	ld	b,(hl)
   4758 DD 7E FC      [19]  130 	ld	a,-4 (ix)
   475B 5F            [ 4]  131 	ld	e,a
   475C 87            [ 4]  132 	add	a, a
   475D 83            [ 4]  133 	add	a, e
   475E 87            [ 4]  134 	add	a, a
   475F 5F            [ 4]  135 	ld	e,a
   4760 68            [ 4]  136 	ld	l,b
   4761 19            [11]  137 	add	hl, de
   4762 DD 75 F6      [19]  138 	ld	-10 (ix),l
   4765                     139 00103$:
                            140 ;src/Renderer.c:229: x=x0;
   4765 DD 5E F6      [19]  141 	ld	e,-10 (ix)
                            142 ;src/Renderer.c:230: y=y0;
   4768 DD 71 F3      [19]  143 	ld	-13 (ix),c
                            144 ;src/Renderer.c:232: for(j=0;j<6;++j){
   476B DD 7E F5      [19]  145 	ld	a,-11 (ix)
   476E 07            [ 4]  146 	rlca
   476F E6 01         [ 7]  147 	and	a,#0x01
   4771 DD 77 FC      [19]  148 	ld	-4 (ix),a
   4774 DD 7E F4      [19]  149 	ld	a,-12 (ix)
   4777 07            [ 4]  150 	rlca
   4778 E6 01         [ 7]  151 	and	a,#0x01
   477A DD 77 FF      [19]  152 	ld	-1 (ix),a
   477D DD 36 F8 00   [19]  153 	ld	-8 (ix),#0x00
                            154 ;src/Renderer.c:234: for(i=offset;i<35-offset;++i){
   4781                     155 00138$:
   4781 DD 7E F9      [19]  156 	ld	a,-7 (ix)
   4784 DD 77 FB      [19]  157 	ld	-5 (ix),a
   4787 DD 7E FA      [19]  158 	ld	a,-6 (ix)
   478A DD 77 F7      [19]  159 	ld	-9 (ix),a
   478D                     160 00125$:
   478D DD 6E FA      [19]  161 	ld	l,-6 (ix)
   4790 26 00         [ 7]  162 	ld	h,#0x00
   4792 3E 23         [ 7]  163 	ld	a,#0x23
   4794 95            [ 4]  164 	sub	a, l
   4795 6F            [ 4]  165 	ld	l,a
   4796 3E 00         [ 7]  166 	ld	a,#0x00
   4798 9C            [ 4]  167 	sbc	a, h
   4799 67            [ 4]  168 	ld	h,a
   479A DD 7E F7      [19]  169 	ld	a, -9 (ix)
   479D 16 00         [ 7]  170 	ld	d, #0x00
   479F 95            [ 4]  171 	sub	a, l
   47A0 7A            [ 4]  172 	ld	a,d
   47A1 9C            [ 4]  173 	sbc	a, h
   47A2 E2 A7 47      [10]  174 	jp	PO, 00181$
   47A5 EE 80         [ 7]  175 	xor	a, #0x80
   47A7                     176 00181$:
   47A7 F2 26 48      [10]  177 	jp	P,00143$
                            178 ;src/Renderer.c:237: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   47AA 2A B2 48      [16]  179 	ld	hl,(_cells_in_view_array)
   47AD 7D            [ 4]  180 	ld	a,l
   47AE DD 86 FB      [19]  181 	add	a, -5 (ix)
   47B1 DD 77 FD      [19]  182 	ld	-3 (ix),a
   47B4 7C            [ 4]  183 	ld	a,h
   47B5 CE 00         [ 7]  184 	adc	a, #0x00
   47B7 DD 77 FE      [19]  185 	ld	-2 (ix),a
                            186 ;src/Renderer.c:236: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
   47BA CB 7B         [ 8]  187 	bit	7, e
   47BC 20 41         [12]  188 	jr	NZ,00105$
   47BE 7B            [ 4]  189 	ld	a,e
   47BF EE 80         [ 7]  190 	xor	a, #0x80
   47C1 D6 A0         [ 7]  191 	sub	a, #0xA0
   47C3 30 3A         [12]  192 	jr	NC,00105$
   47C5 DD CB F3 7E   [20]  193 	bit	7, -13 (ix)
   47C9 20 34         [12]  194 	jr	NZ,00105$
   47CB DD 7E F3      [19]  195 	ld	a,-13 (ix)
   47CE EE 80         [ 7]  196 	xor	a, #0x80
   47D0 D6 A0         [ 7]  197 	sub	a, #0xA0
   47D2 30 2B         [12]  198 	jr	NC,00105$
                            199 ;src/Renderer.c:237: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   47D4 7B            [ 4]  200 	ld	a,e
   47D5 57            [ 4]  201 	ld	d,a
   47D6 17            [ 4]  202 	rla
   47D7 9F            [ 4]  203 	sbc	a, a
   47D8 6F            [ 4]  204 	ld	l,a
   47D9 7A            [ 4]  205 	ld	a,d
   47DA C6 40         [ 7]  206 	add	a, #0x40
   47DC 47            [ 4]  207 	ld	b,a
   47DD 7D            [ 4]  208 	ld	a,l
   47DE CE 00         [ 7]  209 	adc	a, #0x00
   47E0 57            [ 4]  210 	ld	d,a
   47E1 DD 6E F3      [19]  211 	ld	l,-13 (ix)
   47E4 DD 7E F3      [19]  212 	ld	a,-13 (ix)
   47E7 17            [ 4]  213 	rla
   47E8 9F            [ 4]  214 	sbc	a, a
   47E9 67            [ 4]  215 	ld	h,a
   47EA 29            [11]  216 	add	hl, hl
   47EB 29            [11]  217 	add	hl, hl
   47EC 29            [11]  218 	add	hl, hl
   47ED 29            [11]  219 	add	hl, hl
   47EE 29            [11]  220 	add	hl, hl
   47EF 78            [ 4]  221 	ld	a,b
   47F0 85            [ 4]  222 	add	a, l
   47F1 6F            [ 4]  223 	ld	l,a
   47F2 7A            [ 4]  224 	ld	a,d
   47F3 8C            [ 4]  225 	adc	a, h
   47F4 67            [ 4]  226 	ld	h,a
   47F5 46            [ 7]  227 	ld	b,(hl)
   47F6 DD 6E FD      [19]  228 	ld	l,-3 (ix)
   47F9 DD 66 FE      [19]  229 	ld	h,-2 (ix)
   47FC 70            [ 7]  230 	ld	(hl),b
   47FD 18 08         [12]  231 	jr	00106$
   47FF                     232 00105$:
                            233 ;src/Renderer.c:240: cells_in_view_array[n]=1;
   47FF DD 6E FD      [19]  234 	ld	l,-3 (ix)
   4802 DD 66 FE      [19]  235 	ld	h,-2 (ix)
   4805 36 01         [10]  236 	ld	(hl),#0x01
   4807                     237 00106$:
                            238 ;src/Renderer.c:244: if(vert){
   4807 DD 7E F2      [19]  239 	ld	a,-14 (ix)
   480A B7            [ 4]  240 	or	a, a
   480B 28 07         [12]  241 	jr	Z,00111$
                            242 ;src/Renderer.c:245: x+=dx;
   480D 7B            [ 4]  243 	ld	a,e
   480E DD 86 F5      [19]  244 	add	a, -11 (ix)
   4811 5F            [ 4]  245 	ld	e,a
   4812 18 09         [12]  246 	jr	00112$
   4814                     247 00111$:
                            248 ;src/Renderer.c:248: y+=dy;
   4814 DD 7E F3      [19]  249 	ld	a,-13 (ix)
   4817 DD 86 F4      [19]  250 	add	a, -12 (ix)
   481A DD 77 F3      [19]  251 	ld	-13 (ix),a
   481D                     252 00112$:
                            253 ;src/Renderer.c:250: ++n;
   481D DD 34 FB      [23]  254 	inc	-5 (ix)
                            255 ;src/Renderer.c:234: for(i=offset;i<35-offset;++i){
   4820 DD 34 F7      [23]  256 	inc	-9 (ix)
   4823 C3 8D 47      [10]  257 	jp	00125$
   4826                     258 00143$:
   4826 DD 7E FB      [19]  259 	ld	a,-5 (ix)
   4829 DD 77 F9      [19]  260 	ld	-7 (ix),a
                            261 ;src/Renderer.c:252: offset=offsets_cells_in_view[j];
   482C 3E B4         [ 7]  262 	ld	a,#<(_offsets_cells_in_view)
   482E DD 86 F8      [19]  263 	add	a, -8 (ix)
   4831 6F            [ 4]  264 	ld	l,a
   4832 3E 48         [ 7]  265 	ld	a,#>(_offsets_cells_in_view)
   4834 CE 00         [ 7]  266 	adc	a, #0x00
   4836 67            [ 4]  267 	ld	h,a
   4837 7E            [ 7]  268 	ld	a,(hl)
                            269 ;src/Renderer.c:256: if(dx<0) x=x0-offset;
   4838 DD 77 FA      [19]  270 	ld	-6 (ix), a
   483B DD 77 FD      [19]  271 	ld	-3 (ix),a
                            272 ;src/Renderer.c:254: if(vert){
   483E DD 7E F2      [19]  273 	ld	a,-14 (ix)
   4841 B7            [ 4]  274 	or	a, a
   4842 28 21         [12]  275 	jr	Z,00121$
                            276 ;src/Renderer.c:255: y-=dy;
   4844 DD 7E F3      [19]  277 	ld	a,-13 (ix)
   4847 DD 96 F4      [19]  278 	sub	a, -12 (ix)
   484A DD 77 F3      [19]  279 	ld	-13 (ix),a
                            280 ;src/Renderer.c:256: if(dx<0) x=x0-offset;
   484D DD 7E FC      [19]  281 	ld	a,-4 (ix)
   4850 B7            [ 4]  282 	or	a, a
   4851 28 09         [12]  283 	jr	Z,00115$
   4853 DD 7E F6      [19]  284 	ld	a,-10 (ix)
   4856 DD 96 FD      [19]  285 	sub	a, -3 (ix)
   4859 5F            [ 4]  286 	ld	e,a
   485A 18 24         [12]  287 	jr	00128$
   485C                     288 00115$:
                            289 ;src/Renderer.c:257: else x=x0+offset;
   485C DD 7E F6      [19]  290 	ld	a,-10 (ix)
   485F DD 86 FD      [19]  291 	add	a, -3 (ix)
   4862 5F            [ 4]  292 	ld	e,a
   4863 18 1B         [12]  293 	jr	00128$
   4865                     294 00121$:
                            295 ;src/Renderer.c:261: x-=dx;
   4865 7B            [ 4]  296 	ld	a,e
   4866 DD 96 F5      [19]  297 	sub	a, -11 (ix)
   4869 5F            [ 4]  298 	ld	e,a
                            299 ;src/Renderer.c:262: if(dy<0) y=y0-offset;
   486A DD 7E FF      [19]  300 	ld	a,-1 (ix)
   486D B7            [ 4]  301 	or	a, a
   486E 28 09         [12]  302 	jr	Z,00118$
   4870 79            [ 4]  303 	ld	a,c
   4871 DD 96 FD      [19]  304 	sub	a, -3 (ix)
   4874 DD 77 F3      [19]  305 	ld	-13 (ix),a
   4877 18 07         [12]  306 	jr	00128$
   4879                     307 00118$:
                            308 ;src/Renderer.c:263: else y=y0+offset;
   4879 79            [ 4]  309 	ld	a,c
   487A DD 86 FD      [19]  310 	add	a, -3 (ix)
   487D DD 77 F3      [19]  311 	ld	-13 (ix),a
   4880                     312 00128$:
                            313 ;src/Renderer.c:232: for(j=0;j<6;++j){
   4880 DD 34 F8      [23]  314 	inc	-8 (ix)
   4883 DD 7E F8      [19]  315 	ld	a,-8 (ix)
   4886 D6 06         [ 7]  316 	sub	a, #0x06
   4888 DA 81 47      [10]  317 	jp	C,00138$
   488B DD F9         [10]  318 	ld	sp, ix
   488D DD E1         [14]  319 	pop	ix
   488F C9            [10]  320 	ret
   4890                     321 _g_palette:
   4890 08                  322 	.db #0x08	; 8
   4891 00                  323 	.db #0x00	; 0
   4892 0D                  324 	.db #0x0D	; 13
   4893 1A                  325 	.db #0x1A	; 26
   4894 06                  326 	.db #0x06	; 6
   4895 01                  327 	.db #0x01	; 1
   4896 09                  328 	.db #0x09	; 9
   4897 03                  329 	.db #0x03	; 3
   4898 18                  330 	.db #0x18	; 24
   4899 12                  331 	.db #0x12	; 18
   489A 05                  332 	.db #0x05	; 5
   489B 0E                  333 	.db #0x0E	; 14
   489C 0F                  334 	.db #0x0F	; 15
   489D 10                  335 	.db #0x10	; 16
   489E 11                  336 	.db #0x11	; 17
   489F 13                  337 	.db #0x13	; 19
   48A0                     338 _g_colors:
   48A0 00                  339 	.db #0x00	; 0
   48A1 C0                  340 	.db #0xC0	; 192
   48A2 0C                  341 	.db #0x0C	; 12
   48A3 CC                  342 	.db #0xCC	; 204
   48A4 30                  343 	.db #0x30	; 48	'0'
   48A5 F0                  344 	.db #0xF0	; 240
   48A6 3C                  345 	.db #0x3C	; 60
   48A7 FC                  346 	.db #0xFC	; 252
   48A8 03                  347 	.db #0x03	; 3
   48A9 C3                  348 	.db #0xC3	; 195
   48AA 0F                  349 	.db #0x0F	; 15
   48AB CF                  350 	.db #0xCF	; 207
   48AC 33                  351 	.db #0x33	; 51	'3'
   48AD F3                  352 	.db #0xF3	; 243
   48AE 3F                  353 	.db #0x3F	; 63
   48AF FF                  354 	.db #0xFF	; 255
   48B0                     355 _pixelMask:
   48B0 AA                  356 	.db #0xAA	; 170
   48B1 55                  357 	.db #0x55	; 85	'U'
   48B2                     358 _cells_in_view_array:
   48B2 E0 3A               359 	.dw #0x3AE0
   48B4                     360 _offsets_cells_in_view:
   48B4 08                  361 	.db #0x08	; 8
   48B5 0C                  362 	.db #0x0C	; 12
   48B6 0E                  363 	.db #0x0E	; 14
   48B7 0F                  364 	.db #0x0F	; 15
   48B8 10                  365 	.db #0x10	; 16
                            366 ;src/Renderer.c:269: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
                            367 ;	---------------------------------
                            368 ; Function draw_column_to_buffer
                            369 ; ---------------------------------
   48B9                     370 _draw_column_to_buffer::
   48B9 DD E5         [15]  371 	push	ix
   48BB DD 21 00 00   [14]  372 	ld	ix,#0
   48BF DD 39         [15]  373 	add	ix,sp
   48C1 21 EF FF      [10]  374 	ld	hl,#-17
   48C4 39            [11]  375 	add	hl,sp
   48C5 F9            [ 6]  376 	ld	sp,hl
                            377 ;src/Renderer.c:270: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   48C6 DD 7E 04      [19]  378 	ld	a,4 (ix)
   48C9 CB 3F         [ 8]  379 	srl	a
   48CB C6 40         [ 7]  380 	add	a, #0x40
   48CD DD 77 FA      [19]  381 	ld	-6 (ix),a
   48D0 3E 00         [ 7]  382 	ld	a,#0x00
   48D2 CE 2B         [ 7]  383 	adc	a, #0x2B
   48D4 DD 77 FB      [19]  384 	ld	-5 (ix),a
                            385 ;src/Renderer.c:272: u8 w_color, start=0,end=SCREEN_TEXTURE_HEIGHT;
   48D7 DD 36 F8 00   [19]  386 	ld	-8 (ix),#0x00
   48DB DD 36 F9 64   [19]  387 	ld	-7 (ix),#0x64
                            388 ;src/Renderer.c:273: u8 pixMask = pixelMask[column&1];
   48DF 01 B0 48      [10]  389 	ld	bc,#_pixelMask+0
   48E2 DD 7E 04      [19]  390 	ld	a,4 (ix)
   48E5 E6 01         [ 7]  391 	and	a, #0x01
   48E7 6F            [ 4]  392 	ld	l, a
   48E8 26 00         [ 7]  393 	ld	h,#0x00
   48EA 09            [11]  394 	add	hl,bc
   48EB 7E            [ 7]  395 	ld	a,(hl)
   48EC DD 77 F7      [19]  396 	ld	-9 (ix),a
                            397 ;src/Renderer.c:280: u8* texture = (u8*)(UNCOMPRESSED_LEVEL_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
   48EF DD 7E 06      [19]  398 	ld	a, 6 (ix)
   48F2 87            [ 4]  399 	add	a, a
   48F3 87            [ 4]  400 	add	a, a
   48F4 47            [ 4]  401 	ld	b,a
   48F5 0E 00         [ 7]  402 	ld	c,#0x00
   48F7 21 40 08      [10]  403 	ld	hl,#0x0840
   48FA 09            [11]  404 	add	hl,bc
   48FB 4D            [ 4]  405 	ld	c,l
   48FC 44            [ 4]  406 	ld	b,h
   48FD DD 6E 07      [19]  407 	ld	l,7 (ix)
   4900 26 00         [ 7]  408 	ld	h,#0x00
   4902 29            [11]  409 	add	hl, hl
   4903 29            [11]  410 	add	hl, hl
   4904 29            [11]  411 	add	hl, hl
   4905 29            [11]  412 	add	hl, hl
   4906 29            [11]  413 	add	hl, hl
   4907 09            [11]  414 	add	hl,bc
   4908 DD 75 F0      [19]  415 	ld	-16 (ix),l
   490B DD 74 F1      [19]  416 	ld	-15 (ix),h
                            417 ;src/Renderer.c:288: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
   490E DD 7E 05      [19]  418 	ld	a,5 (ix)
   4911 DD 77 FE      [19]  419 	ld	-2 (ix),a
   4914 DD 36 FF 00   [19]  420 	ld	-1 (ix),#0x00
   4918 DD 6E FE      [19]  421 	ld	l,-2 (ix)
   491B DD 66 FF      [19]  422 	ld	h,-1 (ix)
   491E E5            [11]  423 	push	hl
   491F 21 00 20      [10]  424 	ld	hl,#0x2000
   4922 E5            [11]  425 	push	hl
   4923 CD 78 5F      [17]  426 	call	__divsint
   4926 F1            [10]  427 	pop	af
   4927 F1            [10]  428 	pop	af
   4928 DD 75 F3      [19]  429 	ld	-13 (ix),l
   492B DD 74 F4      [19]  430 	ld	-12 (ix),h
                            431 ;src/Renderer.c:289: u16 wall_texture_line=0;
   492E DD 36 F5 00   [19]  432 	ld	-11 (ix),#0x00
   4932 DD 36 F6 00   [19]  433 	ld	-10 (ix),#0x00
                            434 ;src/Renderer.c:294: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   4936 DD 4E 05      [19]  435 	ld	c,5 (ix)
   4939 CB 39         [ 8]  436 	srl	c
   493B 3E 32         [ 7]  437 	ld	a,#0x32
   493D 91            [ 4]  438 	sub	a, c
                            439 ;src/Renderer.c:295: ground_height = ceiling_height + lineHeight;
   493E 4F            [ 4]  440 	ld	c,a
   493F DD 86 05      [19]  441 	add	a, 5 (ix)
   4942 DD 77 F2      [19]  442 	ld	-14 (ix),a
                            443 ;src/Renderer.c:298: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   4945 3E 64         [ 7]  444 	ld	a,#0x64
   4947 DD 96 05      [19]  445 	sub	a, 5 (ix)
   494A 30 55         [12]  446 	jr	NC,00118$
                            447 ;src/Renderer.c:299: start=(lineHeight-SCREEN_TEXTURE_HEIGHT)/2;
   494C DD 7E FE      [19]  448 	ld	a,-2 (ix)
   494F C6 9C         [ 7]  449 	add	a,#0x9C
   4951 4F            [ 4]  450 	ld	c,a
   4952 DD 7E FF      [19]  451 	ld	a,-1 (ix)
   4955 CE FF         [ 7]  452 	adc	a,#0xFF
   4957 47            [ 4]  453 	ld	b,a
   4958 DD 71 FC      [19]  454 	ld	-4 (ix),c
   495B DD 70 FD      [19]  455 	ld	-3 (ix),b
   495E CB 78         [ 8]  456 	bit	7, b
   4960 28 10         [12]  457 	jr	Z,00112$
   4962 DD 7E FE      [19]  458 	ld	a,-2 (ix)
   4965 C6 9D         [ 7]  459 	add	a, #0x9D
   4967 DD 77 FC      [19]  460 	ld	-4 (ix),a
   496A DD 7E FF      [19]  461 	ld	a,-1 (ix)
   496D CE FF         [ 7]  462 	adc	a, #0xFF
   496F DD 77 FD      [19]  463 	ld	-3 (ix),a
   4972                     464 00112$:
   4972 DD 4E FC      [19]  465 	ld	c,-4 (ix)
   4975 DD 46 FD      [19]  466 	ld	b,-3 (ix)
   4978 CB 28         [ 8]  467 	sra	b
   497A CB 19         [ 8]  468 	rr	c
                            469 ;src/Renderer.c:300: end+=start;
   497C DD 71 F8      [19]  470 	ld	-8 (ix), c
   497F 79            [ 4]  471 	ld	a, c
   4980 C6 64         [ 7]  472 	add	a, #0x64
   4982 DD 77 F9      [19]  473 	ld	-7 (ix),a
                            474 ;src/Renderer.c:301: ceiling_height=0;
   4985 0E 00         [ 7]  475 	ld	c,#0x00
                            476 ;src/Renderer.c:302: wall_texture_line = start * wall_texture_line_add;
   4987 DD 5E F8      [19]  477 	ld	e,-8 (ix)
   498A 16 00         [ 7]  478 	ld	d,#0x00
   498C C5            [11]  479 	push	bc
   498D DD 6E F3      [19]  480 	ld	l,-13 (ix)
   4990 DD 66 F4      [19]  481 	ld	h,-12 (ix)
   4993 E5            [11]  482 	push	hl
   4994 D5            [11]  483 	push	de
   4995 CD C2 5E      [17]  484 	call	__mulint
   4998 F1            [10]  485 	pop	af
   4999 F1            [10]  486 	pop	af
   499A C1            [10]  487 	pop	bc
   499B DD 75 F5      [19]  488 	ld	-11 (ix),l
   499E DD 74 F6      [19]  489 	ld	-10 (ix),h
                            490 ;src/Renderer.c:307: for(j=start;j<end;++j){
   49A1                     491 00118$:
   49A1 DD 7E F7      [19]  492 	ld	a,-9 (ix)
   49A4 2F            [ 4]  493 	cpl
   49A5 DD 77 FC      [19]  494 	ld	-4 (ix),a
   49A8 DD 5E FA      [19]  495 	ld	e,-6 (ix)
   49AB DD 56 FB      [19]  496 	ld	d,-5 (ix)
   49AE DD 46 F8      [19]  497 	ld	b,-8 (ix)
   49B1                     498 00108$:
   49B1 78            [ 4]  499 	ld	a,b
   49B2 DD 96 F9      [19]  500 	sub	a, -7 (ix)
   49B5 30 41         [12]  501 	jr	NC,00110$
                            502 ;src/Renderer.c:308: val =  ((*pvmem)&(~pixMask));
   49B7 1A            [ 7]  503 	ld	a,(de)
   49B8 DD A6 FC      [19]  504 	and	a, -4 (ix)
   49BB DD 77 EF      [19]  505 	ld	-17 (ix),a
                            506 ;src/Renderer.c:310: if((j>=ceiling_height) && (j<ground_height)){
   49BE 78            [ 4]  507 	ld	a,b
   49BF B9            [ 4]  508 	cp	a,c
   49C0 38 2E         [12]  509 	jr	C,00104$
   49C2 DD 96 F2      [19]  510 	sub	a, -14 (ix)
   49C5 30 29         [12]  511 	jr	NC,00104$
                            512 ;src/Renderer.c:312: w_color = (*(texture+(wall_texture_line/256))&pixMask);
   49C7 DD 6E F6      [19]  513 	ld	l,-10 (ix)
   49CA 26 00         [ 7]  514 	ld	h,#0x00
   49CC DD 7E F0      [19]  515 	ld	a,-16 (ix)
   49CF 85            [ 4]  516 	add	a, l
   49D0 6F            [ 4]  517 	ld	l,a
   49D1 DD 7E F1      [19]  518 	ld	a,-15 (ix)
   49D4 8C            [ 4]  519 	adc	a, h
   49D5 67            [ 4]  520 	ld	h,a
   49D6 7E            [ 7]  521 	ld	a,(hl)
   49D7 DD A6 F7      [19]  522 	and	a, -9 (ix)
                            523 ;src/Renderer.c:314: *pvmem = val|w_color;
   49DA DD B6 EF      [19]  524 	or	a, -17 (ix)
   49DD 12            [ 7]  525 	ld	(de),a
                            526 ;src/Renderer.c:316: wall_texture_line += wall_texture_line_add;
   49DE DD 7E F5      [19]  527 	ld	a,-11 (ix)
   49E1 DD 86 F3      [19]  528 	add	a, -13 (ix)
   49E4 DD 77 F5      [19]  529 	ld	-11 (ix),a
   49E7 DD 7E F6      [19]  530 	ld	a,-10 (ix)
   49EA DD 8E F4      [19]  531 	adc	a, -12 (ix)
   49ED DD 77 F6      [19]  532 	ld	-10 (ix),a
   49F0                     533 00104$:
                            534 ;src/Renderer.c:318: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   49F0 21 28 00      [10]  535 	ld	hl,#0x0028
   49F3 19            [11]  536 	add	hl,de
   49F4 EB            [ 4]  537 	ex	de,hl
                            538 ;src/Renderer.c:307: for(j=start;j<end;++j){
   49F5 04            [ 4]  539 	inc	b
   49F6 18 B9         [12]  540 	jr	00108$
   49F8                     541 00110$:
   49F8 DD F9         [10]  542 	ld	sp, ix
   49FA DD E1         [14]  543 	pop	ix
   49FC C9            [10]  544 	ret
                            545 ;src/Renderer.c:322: void render_draw_to_buffer(){//TODO Optimize
                            546 ;	---------------------------------
                            547 ; Function render_draw_to_buffer
                            548 ; ---------------------------------
   49FD                     549 _render_draw_to_buffer::
   49FD DD E5         [15]  550 	push	ix
   49FF DD 21 00 00   [14]  551 	ld	ix,#0
   4A03 DD 39         [15]  552 	add	ix,sp
   4A05 21 D3 FF      [10]  553 	ld	hl,#-45
   4A08 39            [11]  554 	add	hl,sp
   4A09 F9            [ 6]  555 	ld	sp,hl
                            556 ;src/Renderer.c:332: u8 zHeight = 5;
   4A0A DD 36 D7 05   [19]  557 	ld	-41 (ix),#0x05
                            558 ;src/Renderer.c:338: u8 offsetDiff = 16;
   4A0E DD 36 DE 10   [19]  559 	ld	-34 (ix),#0x10
                            560 ;src/Renderer.c:343: u8 lineStart = 0;
   4A12 DD 36 DD 00   [19]  561 	ld	-35 (ix),#0x00
                            562 ;src/Renderer.c:345: u8 lateralWallWidth=0;
   4A16 DD 36 DC 00   [19]  563 	ld	-36 (ix),#0x00
                            564 ;src/Renderer.c:357: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   4A1A 21 A5 48      [10]  565 	ld	hl, #_g_colors + 5
   4A1D 46            [ 7]  566 	ld	b,(hl)
   4A1E 21 A8 07      [10]  567 	ld	hl,#0x07A8
   4A21 E5            [11]  568 	push	hl
   4A22 C5            [11]  569 	push	bc
   4A23 33            [ 6]  570 	inc	sp
   4A24 21 40 2B      [10]  571 	ld	hl,#0x2B40
   4A27 E5            [11]  572 	push	hl
   4A28 CD 59 5F      [17]  573 	call	_cpct_memset
                            574 ;src/Renderer.c:358: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
   4A2B 21 A1 48      [10]  575 	ld	hl, #_g_colors + 1
   4A2E 46            [ 7]  576 	ld	b,(hl)
   4A2F 21 50 00      [10]  577 	ld	hl,#0x0050
   4A32 E5            [11]  578 	push	hl
   4A33 C5            [11]  579 	push	bc
   4A34 33            [ 6]  580 	inc	sp
   4A35 21 E8 32      [10]  581 	ld	hl,#0x32E8
   4A38 E5            [11]  582 	push	hl
   4A39 CD 59 5F      [17]  583 	call	_cpct_memset
                            584 ;src/Renderer.c:359: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   4A3C 21 A6 48      [10]  585 	ld	hl, #_g_colors + 6
   4A3F 46            [ 7]  586 	ld	b,(hl)
   4A40 21 A8 07      [10]  587 	ld	hl,#0x07A8
   4A43 E5            [11]  588 	push	hl
   4A44 C5            [11]  589 	push	bc
   4A45 33            [ 6]  590 	inc	sp
   4A46 21 38 33      [10]  591 	ld	hl,#0x3338
   4A49 E5            [11]  592 	push	hl
   4A4A CD 59 5F      [17]  593 	call	_cpct_memset
                            594 ;src/Renderer.c:361: calculate_cells_in_view();
   4A4D CD E1 46      [17]  595 	call	_calculate_cells_in_view
                            596 ;src/Renderer.c:364: do{
   4A50 DD 36 D4 06   [19]  597 	ld	-44 (ix),#0x06
   4A54                     598 00165$:
                            599 ;src/Renderer.c:366: --z;
   4A54 DD 35 D4      [23]  600 	dec	-44 (ix)
                            601 ;src/Renderer.c:370: xCellCount = (z) ? (zHeight >> 1) : 0;
   4A57 DD 7E D7      [19]  602 	ld	a,-41 (ix)
   4A5A CB 3F         [ 8]  603 	srl	a
   4A5C DD 77 F1      [19]  604 	ld	-15 (ix),a
   4A5F DD 7E D4      [19]  605 	ld	a,-44 (ix)
   4A62 B7            [ 4]  606 	or	a, a
   4A63 28 05         [12]  607 	jr	Z,00174$
   4A65 DD 4E F1      [19]  608 	ld	c,-15 (ix)
   4A68 18 02         [12]  609 	jr	00175$
   4A6A                     610 00174$:
   4A6A 0E 00         [ 7]  611 	ld	c,#0x00
   4A6C                     612 00175$:
   4A6C DD 71 F6      [19]  613 	ld	-10 (ix),c
                            614 ;src/Renderer.c:371: lateralWallSlope=0;
   4A6F DD 36 F7 00   [19]  615 	ld	-9 (ix),#0x00
                            616 ;src/Renderer.c:372: lateralWallSlopeCounter=0;
   4A73 DD 36 F0 00   [19]  617 	ld	-16 (ix),#0x00
                            618 ;src/Renderer.c:373: xHeight=0;
   4A77 DD 36 E5 00   [19]  619 	ld	-27 (ix),#0x00
                            620 ;src/Renderer.c:375: lateralWallCounter = 0;
   4A7B DD 36 E6 00   [19]  621 	ld	-26 (ix),#0x00
                            622 ;src/Renderer.c:377: newCell=1;
   4A7F DD 36 E9 01   [19]  623 	ld	-23 (ix),#0x01
                            624 ;src/Renderer.c:378: currentCellID = cells_in_view_array[lineStart + 1];
   4A83 DD 7E DD      [19]  625 	ld	a,-35 (ix)
   4A86 DD 77 EA      [19]  626 	ld	-22 (ix),a
   4A89 DD 36 EB 00   [19]  627 	ld	-21 (ix),#0x00
   4A8D DD 4E EA      [19]  628 	ld	c,-22 (ix)
   4A90 DD 46 EB      [19]  629 	ld	b,-21 (ix)
   4A93 03            [ 6]  630 	inc	bc
   4A94 2A B2 48      [16]  631 	ld	hl,(_cells_in_view_array)
   4A97 DD 75 EC      [19]  632 	ld	-20 (ix),l
   4A9A DD 74 ED      [19]  633 	ld	-19 (ix),h
   4A9D DD 6E EC      [19]  634 	ld	l,-20 (ix)
   4AA0 DD 66 ED      [19]  635 	ld	h,-19 (ix)
   4AA3 09            [11]  636 	add	hl,bc
   4AA4 7E            [ 7]  637 	ld	a,(hl)
   4AA5 DD 77 F2      [19]  638 	ld	-14 (ix),a
                            639 ;src/Renderer.c:380: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   4AA8 DD 7E EC      [19]  640 	ld	a,-20 (ix)
   4AAB DD 86 DD      [19]  641 	add	a, -35 (ix)
   4AAE 6F            [ 4]  642 	ld	l,a
   4AAF DD 7E ED      [19]  643 	ld	a,-19 (ix)
   4AB2 CE 00         [ 7]  644 	adc	a, #0x00
   4AB4 67            [ 4]  645 	ld	h,a
   4AB5 7E            [ 7]  646 	ld	a,(hl)
                            647 ;src/Renderer.c:381: if(lastCellWasWall<5){
   4AB6 DD 77 F5      [19]  648 	ld	-11 (ix), a
   4AB9 D6 05         [ 7]  649 	sub	a, #0x05
   4ABB 30 06         [12]  650 	jr	NC,00102$
                            651 ;src/Renderer.c:382: lastWallId=lastCellWasWall;
                            652 ;src/Renderer.c:383: lastCellWasWall=1;
   4ABD DD 36 F8 01   [19]  653 	ld	-8 (ix),#0x01
   4AC1 18 08         [12]  654 	jr	00193$
   4AC3                     655 00102$:
                            656 ;src/Renderer.c:386: lastCellWasWall=0;
   4AC3 DD 36 F8 00   [19]  657 	ld	-8 (ix),#0x00
                            658 ;src/Renderer.c:387: lastWallId=CELLTYPE_FLOOR;
   4AC7 DD 36 F5 FE   [19]  659 	ld	-11 (ix),#0xFE
                            660 ;src/Renderer.c:390: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   4ACB                     661 00193$:
   4ACB DD 36 D6 00   [19]  662 	ld	-42 (ix),#0x00
   4ACF DD 36 E2 00   [19]  663 	ld	-30 (ix),#0x00
   4AD3                     664 00168$:
                            665 ;src/Renderer.c:392: if (xCellCount == zHeight)
   4AD3 DD 7E D7      [19]  666 	ld	a,-41 (ix)
   4AD6 DD 96 F6      [19]  667 	sub	a, -10 (ix)
   4AD9 20 4B         [12]  668 	jr	NZ,00105$
                            669 ;src/Renderer.c:394: ++xCell;
   4ADB DD 34 D6      [23]  670 	inc	-42 (ix)
                            671 ;src/Renderer.c:395: xCellCount = 0;
   4ADE DD 36 F6 00   [19]  672 	ld	-10 (ix),#0x00
                            673 ;src/Renderer.c:396: newCell=1;
   4AE2 DD 36 E9 01   [19]  674 	ld	-23 (ix),#0x01
                            675 ;src/Renderer.c:397: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   4AE6 DD 7E D6      [19]  676 	ld	a,-42 (ix)
   4AE9 DD 77 F9      [19]  677 	ld	-7 (ix),a
   4AEC DD 36 FA 00   [19]  678 	ld	-6 (ix),#0x00
   4AF0 DD 7E EA      [19]  679 	ld	a,-22 (ix)
   4AF3 DD 86 F9      [19]  680 	add	a, -7 (ix)
   4AF6 DD 77 F9      [19]  681 	ld	-7 (ix),a
   4AF9 DD 7E EB      [19]  682 	ld	a,-21 (ix)
   4AFC DD 8E FA      [19]  683 	adc	a, -6 (ix)
   4AFF DD 77 FA      [19]  684 	ld	-6 (ix),a
   4B02 DD 34 F9      [23]  685 	inc	-7 (ix)
   4B05 20 03         [12]  686 	jr	NZ,00320$
   4B07 DD 34 FA      [23]  687 	inc	-6 (ix)
   4B0A                     688 00320$:
   4B0A DD 7E F9      [19]  689 	ld	a,-7 (ix)
   4B0D DD 86 EC      [19]  690 	add	a, -20 (ix)
   4B10 DD 77 F9      [19]  691 	ld	-7 (ix),a
   4B13 DD 7E FA      [19]  692 	ld	a,-6 (ix)
   4B16 DD 8E ED      [19]  693 	adc	a, -19 (ix)
   4B19 DD 77 FA      [19]  694 	ld	-6 (ix),a
   4B1C DD 6E F9      [19]  695 	ld	l,-7 (ix)
   4B1F DD 66 FA      [19]  696 	ld	h,-6 (ix)
   4B22 7E            [ 7]  697 	ld	a,(hl)
   4B23 DD 77 F2      [19]  698 	ld	-14 (ix),a
   4B26                     699 00105$:
                            700 ;src/Renderer.c:399: if(!(x%2)){
   4B26 DD 7E E2      [19]  701 	ld	a,-30 (ix)
   4B29 E6 01         [ 7]  702 	and	a, #0x01
   4B2B DD 77 F9      [19]  703 	ld	-7 (ix),a
                            704 ;src/Renderer.c:421: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4B2E DD 7E F6      [19]  705 	ld	a,-10 (ix)
   4B31 DD 77 FB      [19]  706 	ld	-5 (ix),a
   4B34 DD 36 FC 00   [19]  707 	ld	-4 (ix),#0x00
   4B38 DD 7E D7      [19]  708 	ld	a,-41 (ix)
   4B3B DD 77 FD      [19]  709 	ld	-3 (ix),a
                            710 ;src/Renderer.c:399: if(!(x%2)){
   4B3E DD 7E F9      [19]  711 	ld	a,-7 (ix)
   4B41 B7            [ 4]  712 	or	a, a
   4B42 C2 F2 4B      [10]  713 	jp	NZ,00118$
                            714 ;src/Renderer.c:400: if ((lateralWallCounter == 0)||newCell)
   4B45 DD 7E E6      [19]  715 	ld	a,-26 (ix)
   4B48 B7            [ 4]  716 	or	a, a
   4B49 28 07         [12]  717 	jr	Z,00114$
   4B4B DD 7E E9      [19]  718 	ld	a,-23 (ix)
   4B4E B7            [ 4]  719 	or	a, a
   4B4F CA F2 4B      [10]  720 	jp	Z,00118$
   4B52                     721 00114$:
                            722 ;src/Renderer.c:402: if (currentCellID < 5)//Wall
   4B52 DD 7E F2      [19]  723 	ld	a,-14 (ix)
   4B55 D6 05         [ 7]  724 	sub	a, #0x05
   4B57 30 20         [12]  725 	jr	NC,00112$
                            726 ;src/Renderer.c:404: lateralWallCounter = 0;//(zHeight - xCellCount);
   4B59 DD 36 E6 00   [19]  727 	ld	-26 (ix),#0x00
                            728 ;src/Renderer.c:405: lateralWallSlope = 0;
   4B5D DD 36 F7 00   [19]  729 	ld	-9 (ix),#0x00
                            730 ;src/Renderer.c:406: xHeight = zHeight;
   4B61 DD 7E D7      [19]  731 	ld	a,-41 (ix)
   4B64 DD 77 E5      [19]  732 	ld	-27 (ix),a
                            733 ;src/Renderer.c:407: color = currentCellID;
   4B67 DD 7E F2      [19]  734 	ld	a,-14 (ix)
   4B6A DD 77 D5      [19]  735 	ld	-43 (ix),a
                            736 ;src/Renderer.c:408: lastCellWasWall = 1;
   4B6D DD 36 F8 01   [19]  737 	ld	-8 (ix),#0x01
                            738 ;src/Renderer.c:409: lastWallId=currentCellID;
   4B71 DD 7E F2      [19]  739 	ld	a,-14 (ix)
   4B74 DD 77 F5      [19]  740 	ld	-11 (ix),a
   4B77 18 75         [12]  741 	jr	00113$
   4B79                     742 00112$:
                            743 ;src/Renderer.c:411: else if(lateralWallCounter==0){//Lateral wall not finished
   4B79 DD 7E E6      [19]  744 	ld	a,-26 (ix)
   4B7C B7            [ 4]  745 	or	a, a
   4B7D 20 6F         [12]  746 	jr	NZ,00113$
                            747 ;src/Renderer.c:412: if (lastCellWasWall)
   4B7F DD 7E F8      [19]  748 	ld	a,-8 (ix)
   4B82 B7            [ 4]  749 	or	a, a
   4B83 28 59         [12]  750 	jr	Z,00107$
                            751 ;src/Renderer.c:415: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   4B85 DD 7E DE      [19]  752 	ld	a,-34 (ix)
   4B88 DD 96 D6      [19]  753 	sub	a, -42 (ix)
   4B8B 87            [ 4]  754 	add	a, a
   4B8C 3C            [ 4]  755 	inc	a
                            756 ;src/Renderer.c:416: lateralWallSlopeCounter = lateralWallSlope / 2;
   4B8D DD 77 F7      [19]  757 	ld	-9 (ix), a
   4B90 CB 3F         [ 8]  758 	srl	a
   4B92 DD 77 F0      [19]  759 	ld	-16 (ix),a
                            760 ;src/Renderer.c:417: lateralWallCounter = lateralWallSlope * zHeight;
   4B95 DD 5E D7      [19]  761 	ld	e,-41 (ix)
   4B98 DD 66 F7      [19]  762 	ld	h,-9 (ix)
   4B9B 2E 00         [ 7]  763 	ld	l, #0x00
   4B9D 55            [ 4]  764 	ld	d, l
   4B9E 06 08         [ 7]  765 	ld	b, #0x08
   4BA0                     766 00321$:
   4BA0 29            [11]  767 	add	hl,hl
   4BA1 30 01         [12]  768 	jr	NC,00322$
   4BA3 19            [11]  769 	add	hl,de
   4BA4                     770 00322$:
   4BA4 10 FA         [13]  771 	djnz	00321$
                            772 ;src/Renderer.c:418: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   4BA6 7D            [ 4]  773 	ld	a,l
   4BA7 E6 FC         [ 7]  774 	and	a, #0xFC
   4BA9 CB C7         [ 8]  775 	set	0, a
   4BAB CB 3F         [ 8]  776 	srl	a
   4BAD CB 3F         [ 8]  777 	srl	a
   4BAF DD 96 F6      [19]  778 	sub	a, -10 (ix)
                            779 ;src/Renderer.c:419: lateralWallWidth=lateralWallCounter;
   4BB2 DD 77 E6      [19]  780 	ld	-26 (ix), a
   4BB5 DD 77 DC      [19]  781 	ld	-36 (ix),a
                            782 ;src/Renderer.c:420: lastCellWasWall = 0;
   4BB8 DD 36 F8 00   [19]  783 	ld	-8 (ix),#0x00
                            784 ;src/Renderer.c:421: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4BBC DD 6E FB      [19]  785 	ld	l,-5 (ix)
   4BBF DD 66 FC      [19]  786 	ld	h,-4 (ix)
   4BC2 29            [11]  787 	add	hl, hl
   4BC3 DD 4E F7      [19]  788 	ld	c,-9 (ix)
   4BC6 06 00         [ 7]  789 	ld	b,#0x00
   4BC8 C5            [11]  790 	push	bc
   4BC9 E5            [11]  791 	push	hl
   4BCA CD 78 5F      [17]  792 	call	__divsint
   4BCD F1            [10]  793 	pop	af
   4BCE F1            [10]  794 	pop	af
   4BCF DD 7E FD      [19]  795 	ld	a,-3 (ix)
   4BD2 95            [ 4]  796 	sub	a, l
   4BD3 DD 77 E5      [19]  797 	ld	-27 (ix),a
                            798 ;src/Renderer.c:422: color = lastWallId;
   4BD6 DD 7E F5      [19]  799 	ld	a,-11 (ix)
   4BD9 DD 77 D5      [19]  800 	ld	-43 (ix),a
   4BDC 18 10         [12]  801 	jr	00113$
   4BDE                     802 00107$:
                            803 ;src/Renderer.c:426: xHeight = 0;
   4BDE DD 36 E5 00   [19]  804 	ld	-27 (ix),#0x00
                            805 ;src/Renderer.c:427: lastCellWasWall = 0;
   4BE2 DD 36 F8 00   [19]  806 	ld	-8 (ix),#0x00
                            807 ;src/Renderer.c:428: lateralWallSlope=0;
   4BE6 DD 36 F7 00   [19]  808 	ld	-9 (ix),#0x00
                            809 ;src/Renderer.c:429: lastWallId=0;
   4BEA DD 36 F5 00   [19]  810 	ld	-11 (ix),#0x00
   4BEE                     811 00113$:
                            812 ;src/Renderer.c:432: newCell=0;
   4BEE DD 36 E9 00   [19]  813 	ld	-23 (ix),#0x00
   4BF2                     814 00118$:
                            815 ;src/Renderer.c:435: if (lateralWallCounter > 0)
   4BF2 DD 7E E6      [19]  816 	ld	a,-26 (ix)
   4BF5 B7            [ 4]  817 	or	a, a
   4BF6 28 1E         [12]  818 	jr	Z,00124$
                            819 ;src/Renderer.c:438: if (lateralWallSlope != 0)
   4BF8 DD 7E F7      [19]  820 	ld	a,-9 (ix)
   4BFB B7            [ 4]  821 	or	a, a
   4BFC 28 15         [12]  822 	jr	Z,00122$
                            823 ;src/Renderer.c:440: if (lateralWallSlopeCounter == lateralWallSlope)
   4BFE DD 7E F7      [19]  824 	ld	a,-9 (ix)
   4C01 DD 96 F0      [19]  825 	sub	a, -16 (ix)
   4C04 20 0A         [12]  826 	jr	NZ,00120$
                            827 ;src/Renderer.c:442: lateralWallSlopeCounter = 0;
   4C06 DD 36 F0 00   [19]  828 	ld	-16 (ix),#0x00
                            829 ;src/Renderer.c:443: xHeight -= 2;
   4C0A DD 35 E5      [23]  830 	dec	-27 (ix)
   4C0D DD 35 E5      [23]  831 	dec	-27 (ix)
   4C10                     832 00120$:
                            833 ;src/Renderer.c:445: ++lateralWallSlopeCounter;
   4C10 DD 34 F0      [23]  834 	inc	-16 (ix)
   4C13                     835 00122$:
                            836 ;src/Renderer.c:448: --lateralWallCounter;
   4C13 DD 35 E6      [23]  837 	dec	-26 (ix)
   4C16                     838 00124$:
                            839 ;src/Renderer.c:459: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   4C16 DD 7E D7      [19]  840 	ld	a,-41 (ix)
   4C19 DD 77 FE      [19]  841 	ld	-2 (ix),a
   4C1C DD 36 FF 00   [19]  842 	ld	-1 (ix),#0x00
                            843 ;src/Renderer.c:451: if (!(x%2))
   4C20 DD 7E F9      [19]  844 	ld	a,-7 (ix)
   4C23 B7            [ 4]  845 	or	a, a
   4C24 20 59         [12]  846 	jr	NZ,00131$
                            847 ;src/Renderer.c:453: if(xHeight > 0){
   4C26 DD 7E E5      [19]  848 	ld	a,-27 (ix)
   4C29 B7            [ 4]  849 	or	a, a
   4C2A 28 53         [12]  850 	jr	Z,00131$
                            851 ;src/Renderer.c:454: if (lateralWallCounter > 0)
   4C2C DD 7E E6      [19]  852 	ld	a,-26 (ix)
   4C2F B7            [ 4]  853 	or	a, a
   4C30 28 1F         [12]  854 	jr	Z,00126$
                            855 ;src/Renderer.c:456: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   4C32 DD 4E DC      [19]  856 	ld	c,-36 (ix)
   4C35 06 00         [ 7]  857 	ld	b,#0x00
   4C37 DD 5E E6      [19]  858 	ld	e,-26 (ix)
   4C3A 16 00         [ 7]  859 	ld	d,#0x00
   4C3C 79            [ 4]  860 	ld	a,c
   4C3D 93            [ 4]  861 	sub	a, e
   4C3E 6F            [ 4]  862 	ld	l,a
   4C3F 78            [ 4]  863 	ld	a,b
   4C40 9A            [ 4]  864 	sbc	a, d
   4C41 67            [ 4]  865 	ld	h,a
   4C42 29            [11]  866 	add	hl, hl
   4C43 29            [11]  867 	add	hl, hl
   4C44 29            [11]  868 	add	hl, hl
   4C45 29            [11]  869 	add	hl, hl
   4C46 29            [11]  870 	add	hl, hl
   4C47 C5            [11]  871 	push	bc
   4C48 E5            [11]  872 	push	hl
   4C49 CD 78 5F      [17]  873 	call	__divsint
   4C4C F1            [10]  874 	pop	af
   4C4D F1            [10]  875 	pop	af
   4C4E 45            [ 4]  876 	ld	b,l
   4C4F 18 19         [12]  877 	jr	00127$
   4C51                     878 00126$:
                            879 ;src/Renderer.c:459: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   4C51 DD 6E FB      [19]  880 	ld	l,-5 (ix)
   4C54 DD 66 FC      [19]  881 	ld	h,-4 (ix)
   4C57 29            [11]  882 	add	hl, hl
   4C58 29            [11]  883 	add	hl, hl
   4C59 29            [11]  884 	add	hl, hl
   4C5A 29            [11]  885 	add	hl, hl
   4C5B 29            [11]  886 	add	hl, hl
   4C5C DD 4E FE      [19]  887 	ld	c,-2 (ix)
   4C5F DD 46 FF      [19]  888 	ld	b,-1 (ix)
   4C62 C5            [11]  889 	push	bc
   4C63 E5            [11]  890 	push	hl
   4C64 CD 78 5F      [17]  891 	call	__divsint
   4C67 F1            [10]  892 	pop	af
   4C68 F1            [10]  893 	pop	af
   4C69 45            [ 4]  894 	ld	b,l
   4C6A                     895 00127$:
                            896 ;src/Renderer.c:461: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   4C6A DD 56 E2      [19]  897 	ld	d,-30 (ix)
   4C6D CB 3A         [ 8]  898 	srl	d
   4C6F C5            [11]  899 	push	bc
   4C70 33            [ 6]  900 	inc	sp
   4C71 DD 66 D5      [19]  901 	ld	h,-43 (ix)
   4C74 DD 6E E5      [19]  902 	ld	l,-27 (ix)
   4C77 E5            [11]  903 	push	hl
   4C78 D5            [11]  904 	push	de
   4C79 33            [ 6]  905 	inc	sp
   4C7A CD B9 48      [17]  906 	call	_draw_column_to_buffer
   4C7D F1            [10]  907 	pop	af
   4C7E F1            [10]  908 	pop	af
   4C7F                     909 00131$:
                            910 ;src/Renderer.c:465: ++xCellCount;
   4C7F DD 34 F6      [23]  911 	inc	-10 (ix)
                            912 ;src/Renderer.c:390: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   4C82 DD 34 E2      [23]  913 	inc	-30 (ix)
                            914 ;src/Renderer.c:378: currentCellID = cells_in_view_array[lineStart + 1];
   4C85 2A B2 48      [16]  915 	ld	hl,(_cells_in_view_array)
   4C88 DD 75 EC      [19]  916 	ld	-20 (ix),l
   4C8B DD 74 ED      [19]  917 	ld	-19 (ix),h
                            918 ;src/Renderer.c:390: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   4C8E DD 7E E2      [19]  919 	ld	a,-30 (ix)
   4C91 D6 50         [ 7]  920 	sub	a, #0x50
   4C93 DA D3 4A      [10]  921 	jp	C,00168$
                            922 ;src/Renderer.c:472: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   4C96 DD 7E D4      [19]  923 	ld	a,-44 (ix)
   4C99 B7            [ 4]  924 	or	a, a
   4C9A 28 05         [12]  925 	jr	Z,00176$
   4C9C DD 4E F1      [19]  926 	ld	c,-15 (ix)
   4C9F 18 02         [12]  927 	jr	00177$
   4CA1                     928 00176$:
   4CA1 0E 00         [ 7]  929 	ld	c,#0x00
   4CA3                     930 00177$:
   4CA3 DD 71 D8      [19]  931 	ld	-40 (ix),c
                            932 ;src/Renderer.c:473: lateralWallSlope=0;
   4CA6 DD 36 D9 00   [19]  933 	ld	-39 (ix),#0x00
                            934 ;src/Renderer.c:474: lateralWallSlopeCounter=0;
   4CAA DD 36 E1 00   [19]  935 	ld	-31 (ix),#0x00
                            936 ;src/Renderer.c:475: xHeight=0;
   4CAE DD 36 D3 00   [19]  937 	ld	-45 (ix),#0x00
                            938 ;src/Renderer.c:477: lateralWallCounter = 0;
   4CB2 DD 36 FB 00   [19]  939 	ld	-5 (ix),#0x00
                            940 ;src/Renderer.c:478: lineEnd = lineStart + offsetDiff * 2 + 2;
   4CB6 DD 7E DE      [19]  941 	ld	a,-34 (ix)
   4CB9 87            [ 4]  942 	add	a, a
   4CBA 4F            [ 4]  943 	ld	c,a
   4CBB DD 7E DD      [19]  944 	ld	a,-35 (ix)
   4CBE 81            [ 4]  945 	add	a, c
   4CBF DD 77 F9      [19]  946 	ld	-7 (ix), a
   4CC2 4F            [ 4]  947 	ld	c, a
   4CC3 0C            [ 4]  948 	inc	c
   4CC4 0C            [ 4]  949 	inc	c
                            950 ;src/Renderer.c:480: newCell=1;
   4CC5 DD 36 DF 01   [19]  951 	ld	-33 (ix),#0x01
                            952 ;src/Renderer.c:481: currentCellID = cells_in_view_array[lineEnd - 1];
   4CC9 DD 71 EA      [19]  953 	ld	-22 (ix),c
   4CCC DD 36 EB 00   [19]  954 	ld	-21 (ix),#0x00
   4CD0 DD 5E EA      [19]  955 	ld	e,-22 (ix)
   4CD3 DD 56 EB      [19]  956 	ld	d,-21 (ix)
   4CD6 1B            [ 6]  957 	dec	de
   4CD7 DD 6E EC      [19]  958 	ld	l,-20 (ix)
   4CDA DD 66 ED      [19]  959 	ld	h,-19 (ix)
   4CDD 19            [11]  960 	add	hl,de
   4CDE 7E            [ 7]  961 	ld	a,(hl)
   4CDF DD 77 E0      [19]  962 	ld	-32 (ix),a
                            963 ;src/Renderer.c:483: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   4CE2 DD 6E EC      [19]  964 	ld	l,-20 (ix)
   4CE5 DD 66 ED      [19]  965 	ld	h,-19 (ix)
   4CE8 06 00         [ 7]  966 	ld	b,#0x00
   4CEA 09            [11]  967 	add	hl, bc
   4CEB 4E            [ 7]  968 	ld	c,(hl)
                            969 ;src/Renderer.c:484: if(lastCellWasWall<5){
   4CEC 79            [ 4]  970 	ld	a,c
   4CED D6 05         [ 7]  971 	sub	a, #0x05
   4CEF 30 09         [12]  972 	jr	NC,00134$
                            973 ;src/Renderer.c:485: lastWallId=lastCellWasWall;
   4CF1 DD 71 DB      [19]  974 	ld	-37 (ix),c
                            975 ;src/Renderer.c:486: lastCellWasWall=1;
   4CF4 DD 36 F8 01   [19]  976 	ld	-8 (ix),#0x01
   4CF8 18 08         [12]  977 	jr	00210$
   4CFA                     978 00134$:
                            979 ;src/Renderer.c:489: lastCellWasWall=0;
   4CFA DD 36 F8 00   [19]  980 	ld	-8 (ix),#0x00
                            981 ;src/Renderer.c:490: lastWallId=CELLTYPE_FLOOR;
   4CFE DD 36 DB FE   [19]  982 	ld	-37 (ix),#0xFE
                            983 ;src/Renderer.c:493: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   4D02                     984 00210$:
   4D02 DD 36 D6 00   [19]  985 	ld	-42 (ix),#0x00
   4D06 DD 36 E2 9F   [19]  986 	ld	-30 (ix),#0x9F
   4D0A                     987 00170$:
                            988 ;src/Renderer.c:496: if (xCellCount == zHeight)
   4D0A DD 7E D7      [19]  989 	ld	a,-41 (ix)
   4D0D DD 96 D8      [19]  990 	sub	a, -40 (ix)
   4D10 20 59         [12]  991 	jr	NZ,00137$
                            992 ;src/Renderer.c:498: ++xCell;
   4D12 DD 34 D6      [23]  993 	inc	-42 (ix)
                            994 ;src/Renderer.c:499: xCellCount = 0;
   4D15 DD 36 D8 00   [19]  995 	ld	-40 (ix),#0x00
                            996 ;src/Renderer.c:500: newCell=1;
   4D19 DD 36 DF 01   [19]  997 	ld	-33 (ix),#0x01
                            998 ;src/Renderer.c:501: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   4D1D DD 7E D6      [19]  999 	ld	a,-42 (ix)
   4D20 DD 77 EC      [19] 1000 	ld	-20 (ix),a
   4D23 DD 36 ED 00   [19] 1001 	ld	-19 (ix),#0x00
   4D27 DD 7E EA      [19] 1002 	ld	a,-22 (ix)
   4D2A DD 96 EC      [19] 1003 	sub	a, -20 (ix)
   4D2D DD 77 EC      [19] 1004 	ld	-20 (ix),a
   4D30 DD 7E EB      [19] 1005 	ld	a,-21 (ix)
   4D33 DD 9E ED      [19] 1006 	sbc	a, -19 (ix)
   4D36 DD 77 ED      [19] 1007 	ld	-19 (ix),a
   4D39 DD 6E EC      [19] 1008 	ld	l,-20 (ix)
   4D3C DD 66 ED      [19] 1009 	ld	h,-19 (ix)
   4D3F 2B            [ 6] 1010 	dec	hl
   4D40 DD 75 EC      [19] 1011 	ld	-20 (ix),l
   4D43 DD 74 ED      [19] 1012 	ld	-19 (ix),h
   4D46 2A B2 48      [16] 1013 	ld	hl,(_cells_in_view_array)
   4D49 DD 75 E3      [19] 1014 	ld	-29 (ix),l
   4D4C DD 74 E4      [19] 1015 	ld	-28 (ix),h
   4D4F DD 7E EC      [19] 1016 	ld	a,-20 (ix)
   4D52 DD 86 E3      [19] 1017 	add	a, -29 (ix)
   4D55 DD 77 E3      [19] 1018 	ld	-29 (ix),a
   4D58 DD 7E ED      [19] 1019 	ld	a,-19 (ix)
   4D5B DD 8E E4      [19] 1020 	adc	a, -28 (ix)
   4D5E DD 77 E4      [19] 1021 	ld	-28 (ix),a
   4D61 DD 6E E3      [19] 1022 	ld	l,-29 (ix)
   4D64 DD 66 E4      [19] 1023 	ld	h,-28 (ix)
   4D67 7E            [ 7] 1024 	ld	a,(hl)
   4D68 DD 77 E0      [19] 1025 	ld	-32 (ix),a
   4D6B                    1026 00137$:
                           1027 ;src/Renderer.c:503: if(!(x%2)){
   4D6B DD 7E E2      [19] 1028 	ld	a,-30 (ix)
   4D6E E6 01         [ 7] 1029 	and	a, #0x01
   4D70 DD 77 E3      [19] 1030 	ld	-29 (ix),a
                           1031 ;src/Renderer.c:421: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4D73 DD 7E D8      [19] 1032 	ld	a,-40 (ix)
   4D76 DD 77 EC      [19] 1033 	ld	-20 (ix),a
   4D79 DD 36 ED 00   [19] 1034 	ld	-19 (ix),#0x00
                           1035 ;src/Renderer.c:503: if(!(x%2)){
   4D7D DD 7E E3      [19] 1036 	ld	a,-29 (ix)
   4D80 B7            [ 4] 1037 	or	a, a
   4D81 C2 CF 4E      [10] 1038 	jp	NZ,00150$
                           1039 ;src/Renderer.c:504: if (lateralWallCounter == 0 || newCell)
   4D84 DD 7E FB      [19] 1040 	ld	a,-5 (ix)
   4D87 B7            [ 4] 1041 	or	a, a
   4D88 28 07         [12] 1042 	jr	Z,00146$
   4D8A DD 7E DF      [19] 1043 	ld	a,-33 (ix)
   4D8D B7            [ 4] 1044 	or	a, a
   4D8E CA CF 4E      [10] 1045 	jp	Z,00150$
   4D91                    1046 00146$:
                           1047 ;src/Renderer.c:506: if ( currentCellID < 5)//Wall
   4D91 DD 7E E0      [19] 1048 	ld	a,-32 (ix)
   4D94 D6 05         [ 7] 1049 	sub	a, #0x05
   4D96 30 21         [12] 1050 	jr	NC,00144$
                           1051 ;src/Renderer.c:508: lateralWallCounter = 0;
   4D98 DD 36 FB 00   [19] 1052 	ld	-5 (ix),#0x00
                           1053 ;src/Renderer.c:509: lateralWallSlope = 0;
   4D9C DD 36 D9 00   [19] 1054 	ld	-39 (ix),#0x00
                           1055 ;src/Renderer.c:510: xHeight = zHeight;
   4DA0 DD 7E D7      [19] 1056 	ld	a,-41 (ix)
   4DA3 DD 77 D3      [19] 1057 	ld	-45 (ix),a
                           1058 ;src/Renderer.c:511: color = currentCellID;
   4DA6 DD 7E E0      [19] 1059 	ld	a,-32 (ix)
   4DA9 DD 77 D5      [19] 1060 	ld	-43 (ix),a
                           1061 ;src/Renderer.c:512: lastCellWasWall = 1;
   4DAC DD 36 F8 01   [19] 1062 	ld	-8 (ix),#0x01
                           1063 ;src/Renderer.c:513: lastWallId=currentCellID;
   4DB0 DD 7E E0      [19] 1064 	ld	a,-32 (ix)
   4DB3 DD 77 DB      [19] 1065 	ld	-37 (ix),a
   4DB6 C3 CB 4E      [10] 1066 	jp	00145$
   4DB9                    1067 00144$:
                           1068 ;src/Renderer.c:515: else if(lateralWallCounter==0){
   4DB9 DD 7E FB      [19] 1069 	ld	a,-5 (ix)
   4DBC B7            [ 4] 1070 	or	a, a
   4DBD C2 CB 4E      [10] 1071 	jp	NZ,00145$
                           1072 ;src/Renderer.c:516: if (lastCellWasWall)
   4DC0 DD 7E F8      [19] 1073 	ld	a,-8 (ix)
   4DC3 B7            [ 4] 1074 	or	a, a
   4DC4 CA BB 4E      [10] 1075 	jp	Z,00139$
                           1076 ;src/Renderer.c:519: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   4DC7 DD 7E DE      [19] 1077 	ld	a,-34 (ix)
   4DCA DD 96 D6      [19] 1078 	sub	a, -42 (ix)
   4DCD 87            [ 4] 1079 	add	a, a
   4DCE 3C            [ 4] 1080 	inc	a
                           1081 ;src/Renderer.c:520: lateralWallSlopeCounter = lateralWallSlope / 2;
   4DCF DD 77 D9      [19] 1082 	ld	-39 (ix), a
   4DD2 CB 3F         [ 8] 1083 	srl	a
   4DD4 DD 77 E1      [19] 1084 	ld	-31 (ix),a
                           1085 ;src/Renderer.c:521: lateralWallCounter = lateralWallSlope * zHeight;
   4DD7 DD 5E D7      [19] 1086 	ld	e,-41 (ix)
   4DDA DD 66 D9      [19] 1087 	ld	h,-39 (ix)
   4DDD 2E 00         [ 7] 1088 	ld	l, #0x00
   4DDF 55            [ 4] 1089 	ld	d, l
   4DE0 06 08         [ 7] 1090 	ld	b, #0x08
   4DE2                    1091 00327$:
   4DE2 29            [11] 1092 	add	hl,hl
   4DE3 30 01         [12] 1093 	jr	NC,00328$
   4DE5 19            [11] 1094 	add	hl,de
   4DE6                    1095 00328$:
   4DE6 10 FA         [13] 1096 	djnz	00327$
   4DE8 DD 75 F5      [19] 1097 	ld	-11 (ix), l
   4DEB 7D            [ 4] 1098 	ld	a, l
                           1099 ;src/Renderer.c:522: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   4DEC DD 77 DA      [19] 1100 	ld	-38 (ix), a
   4DEF DD 77 EE      [19] 1101 	ld	-18 (ix),a
   4DF2 DD 36 EF 00   [19] 1102 	ld	-17 (ix),#0x00
   4DF6 DD 7E DA      [19] 1103 	ld	a,-38 (ix)
   4DF9 E6 03         [ 7] 1104 	and	a, #0x03
   4DFB DD 77 F5      [19] 1105 	ld	-11 (ix), a
   4DFE DD 77 F3      [19] 1106 	ld	-13 (ix),a
   4E01 DD 36 F4 00   [19] 1107 	ld	-12 (ix),#0x00
   4E05 DD 7E EE      [19] 1108 	ld	a,-18 (ix)
   4E08 DD 96 F3      [19] 1109 	sub	a, -13 (ix)
   4E0B DD 77 F3      [19] 1110 	ld	-13 (ix),a
   4E0E DD 7E EF      [19] 1111 	ld	a,-17 (ix)
   4E11 DD 9E F4      [19] 1112 	sbc	a, -12 (ix)
   4E14 DD 77 F4      [19] 1113 	ld	-12 (ix),a
   4E17 DD 7E F3      [19] 1114 	ld	a,-13 (ix)
   4E1A C6 01         [ 7] 1115 	add	a, #0x01
   4E1C DD 77 EE      [19] 1116 	ld	-18 (ix),a
   4E1F DD 7E F4      [19] 1117 	ld	a,-12 (ix)
   4E22 CE 00         [ 7] 1118 	adc	a, #0x00
   4E24 DD 77 EF      [19] 1119 	ld	-17 (ix),a
   4E27 DD 7E EE      [19] 1120 	ld	a,-18 (ix)
   4E2A DD 77 E7      [19] 1121 	ld	-25 (ix),a
   4E2D DD 7E EF      [19] 1122 	ld	a,-17 (ix)
   4E30 DD 77 E8      [19] 1123 	ld	-24 (ix),a
   4E33 DD CB EF 7E   [20] 1124 	bit	7, -17 (ix)
   4E37 28 10         [12] 1125 	jr	Z,00178$
   4E39 DD 7E F3      [19] 1126 	ld	a,-13 (ix)
   4E3C C6 04         [ 7] 1127 	add	a, #0x04
   4E3E DD 77 E7      [19] 1128 	ld	-25 (ix),a
   4E41 DD 7E F4      [19] 1129 	ld	a,-12 (ix)
   4E44 CE 00         [ 7] 1130 	adc	a, #0x00
   4E46 DD 77 E8      [19] 1131 	ld	-24 (ix),a
   4E49                    1132 00178$:
   4E49 DD CB E8 2E   [23] 1133 	sra	-24 (ix)
   4E4D DD CB E7 1E   [23] 1134 	rr	-25 (ix)
   4E51 DD CB E8 2E   [23] 1135 	sra	-24 (ix)
   4E55 DD CB E7 1E   [23] 1136 	rr	-25 (ix)
   4E59 DD 7E E7      [19] 1137 	ld	a,-25 (ix)
   4E5C DD 77 E7      [19] 1138 	ld	-25 (ix),a
   4E5F DD 4E D8      [19] 1139 	ld	c,-40 (ix)
   4E62 DD 7E E7      [19] 1140 	ld	a,-25 (ix)
   4E65 91            [ 4] 1141 	sub	a, c
                           1142 ;src/Renderer.c:523: lateralWallWidth=lateralWallCounter;
   4E66 DD 77 FB      [19] 1143 	ld	-5 (ix), a
   4E69 DD 77 DC      [19] 1144 	ld	-36 (ix),a
                           1145 ;src/Renderer.c:524: lastCellWasWall = 0;
   4E6C DD 36 F8 00   [19] 1146 	ld	-8 (ix),#0x00
                           1147 ;src/Renderer.c:525: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   4E70 DD 7E EC      [19] 1148 	ld	a,-20 (ix)
   4E73 DD 77 E7      [19] 1149 	ld	-25 (ix),a
   4E76 DD 7E ED      [19] 1150 	ld	a,-19 (ix)
   4E79 DD 77 E8      [19] 1151 	ld	-24 (ix),a
   4E7C DD CB E7 26   [23] 1152 	sla	-25 (ix)
   4E80 DD CB E8 16   [23] 1153 	rl	-24 (ix)
   4E84 DD 7E D9      [19] 1154 	ld	a,-39 (ix)
   4E87 DD 77 F3      [19] 1155 	ld	-13 (ix),a
   4E8A DD 36 F4 00   [19] 1156 	ld	-12 (ix),#0x00
   4E8E DD 6E F3      [19] 1157 	ld	l,-13 (ix)
   4E91 DD 66 F4      [19] 1158 	ld	h,-12 (ix)
   4E94 E5            [11] 1159 	push	hl
   4E95 DD 6E E7      [19] 1160 	ld	l,-25 (ix)
   4E98 DD 66 E8      [19] 1161 	ld	h,-24 (ix)
   4E9B E5            [11] 1162 	push	hl
   4E9C CD 78 5F      [17] 1163 	call	__divsint
   4E9F F1            [10] 1164 	pop	af
   4EA0 F1            [10] 1165 	pop	af
   4EA1 DD 74 E8      [19] 1166 	ld	-24 (ix),h
   4EA4 DD 75 E7      [19] 1167 	ld	-25 (ix), l
   4EA7 DD 75 E7      [19] 1168 	ld	-25 (ix), l
   4EAA DD 7E FD      [19] 1169 	ld	a,-3 (ix)
   4EAD DD 96 E7      [19] 1170 	sub	a, -25 (ix)
   4EB0 DD 77 D3      [19] 1171 	ld	-45 (ix),a
                           1172 ;src/Renderer.c:526: color = lastWallId;
   4EB3 DD 7E DB      [19] 1173 	ld	a,-37 (ix)
   4EB6 DD 77 D5      [19] 1174 	ld	-43 (ix),a
   4EB9 18 10         [12] 1175 	jr	00145$
   4EBB                    1176 00139$:
                           1177 ;src/Renderer.c:530: xHeight = 0;
   4EBB DD 36 D3 00   [19] 1178 	ld	-45 (ix),#0x00
                           1179 ;src/Renderer.c:531: lastCellWasWall = 0;
   4EBF DD 36 F8 00   [19] 1180 	ld	-8 (ix),#0x00
                           1181 ;src/Renderer.c:532: lateralWallSlope=0;
   4EC3 DD 36 D9 00   [19] 1182 	ld	-39 (ix),#0x00
                           1183 ;src/Renderer.c:533: lastWallId=0;
   4EC7 DD 36 DB 00   [19] 1184 	ld	-37 (ix),#0x00
   4ECB                    1185 00145$:
                           1186 ;src/Renderer.c:536: newCell=0;
   4ECB DD 36 DF 00   [19] 1187 	ld	-33 (ix),#0x00
   4ECF                    1188 00150$:
                           1189 ;src/Renderer.c:541: if (lateralWallCounter > 0)
   4ECF DD 7E FB      [19] 1190 	ld	a,-5 (ix)
   4ED2 B7            [ 4] 1191 	or	a, a
   4ED3 28 1E         [12] 1192 	jr	Z,00156$
                           1193 ;src/Renderer.c:544: if (lateralWallSlope != 0)
   4ED5 DD 7E D9      [19] 1194 	ld	a,-39 (ix)
   4ED8 B7            [ 4] 1195 	or	a, a
   4ED9 28 15         [12] 1196 	jr	Z,00154$
                           1197 ;src/Renderer.c:546: if (lateralWallSlopeCounter == lateralWallSlope)
   4EDB DD 7E E1      [19] 1198 	ld	a,-31 (ix)
   4EDE DD 96 D9      [19] 1199 	sub	a, -39 (ix)
   4EE1 20 0A         [12] 1200 	jr	NZ,00152$
                           1201 ;src/Renderer.c:548: lateralWallSlopeCounter = 0;
   4EE3 DD 36 E1 00   [19] 1202 	ld	-31 (ix),#0x00
                           1203 ;src/Renderer.c:549: xHeight -= 2;
   4EE7 DD 35 D3      [23] 1204 	dec	-45 (ix)
   4EEA DD 35 D3      [23] 1205 	dec	-45 (ix)
   4EED                    1206 00152$:
                           1207 ;src/Renderer.c:551: ++lateralWallSlopeCounter;
   4EED DD 34 E1      [23] 1208 	inc	-31 (ix)
   4EF0                    1209 00154$:
                           1210 ;src/Renderer.c:553: --lateralWallCounter;
   4EF0 DD 35 FB      [23] 1211 	dec	-5 (ix)
   4EF3                    1212 00156$:
                           1213 ;src/Renderer.c:557: if (!(x%2))
   4EF3 DD 7E E3      [19] 1214 	ld	a,-29 (ix)
   4EF6 B7            [ 4] 1215 	or	a, a
   4EF7 C2 90 4F      [10] 1216 	jp	NZ,00163$
                           1217 ;src/Renderer.c:560: if(xHeight > 0){
   4EFA DD 7E D3      [19] 1218 	ld	a,-45 (ix)
   4EFD B7            [ 4] 1219 	or	a, a
   4EFE CA 90 4F      [10] 1220 	jp	Z,00163$
                           1221 ;src/Renderer.c:562: if (lateralWallCounter > 0)
   4F01 DD 7E FB      [19] 1222 	ld	a,-5 (ix)
   4F04 B7            [ 4] 1223 	or	a, a
   4F05 28 39         [12] 1224 	jr	Z,00158$
                           1225 ;src/Renderer.c:564: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   4F07 DD 7E FB      [19] 1226 	ld	a,-5 (ix)
   4F0A DD 77 E7      [19] 1227 	ld	-25 (ix),a
   4F0D DD 36 E8 00   [19] 1228 	ld	-24 (ix),#0x00
   4F11 3E 06         [ 7] 1229 	ld	a,#0x05+1
   4F13 18 08         [12] 1230 	jr	00334$
   4F15                    1231 00333$:
   4F15 DD CB E7 26   [23] 1232 	sla	-25 (ix)
   4F19 DD CB E8 16   [23] 1233 	rl	-24 (ix)
   4F1D                    1234 00334$:
   4F1D 3D            [ 4] 1235 	dec	a
   4F1E 20 F5         [12] 1236 	jr	NZ,00333$
   4F20 DD 7E DC      [19] 1237 	ld	a,-36 (ix)
   4F23 DD 77 F3      [19] 1238 	ld	-13 (ix),a
   4F26 DD 36 F4 00   [19] 1239 	ld	-12 (ix),#0x00
   4F2A DD 6E F3      [19] 1240 	ld	l,-13 (ix)
   4F2D DD 66 F4      [19] 1241 	ld	h,-12 (ix)
   4F30 E5            [11] 1242 	push	hl
   4F31 DD 6E E7      [19] 1243 	ld	l,-25 (ix)
   4F34 DD 66 E8      [19] 1244 	ld	h,-24 (ix)
   4F37 E5            [11] 1245 	push	hl
   4F38 CD 78 5F      [17] 1246 	call	__divsint
   4F3B F1            [10] 1247 	pop	af
   4F3C F1            [10] 1248 	pop	af
   4F3D 55            [ 4] 1249 	ld	d,l
   4F3E 18 3B         [12] 1250 	jr	00159$
   4F40                    1251 00158$:
                           1252 ;src/Renderer.c:567: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   4F40 DD 7E FE      [19] 1253 	ld	a,-2 (ix)
   4F43 DD 96 EC      [19] 1254 	sub	a, -20 (ix)
   4F46 DD 77 E7      [19] 1255 	ld	-25 (ix),a
   4F49 DD 7E FF      [19] 1256 	ld	a,-1 (ix)
   4F4C DD 9E ED      [19] 1257 	sbc	a, -19 (ix)
   4F4F DD 77 E8      [19] 1258 	ld	-24 (ix),a
   4F52 3E 06         [ 7] 1259 	ld	a,#0x05+1
   4F54 18 08         [12] 1260 	jr	00336$
   4F56                    1261 00335$:
   4F56 DD CB E7 26   [23] 1262 	sla	-25 (ix)
   4F5A DD CB E8 16   [23] 1263 	rl	-24 (ix)
   4F5E                    1264 00336$:
   4F5E 3D            [ 4] 1265 	dec	a
   4F5F 20 F5         [12] 1266 	jr	NZ,00335$
   4F61 DD 6E FE      [19] 1267 	ld	l,-2 (ix)
   4F64 DD 66 FF      [19] 1268 	ld	h,-1 (ix)
   4F67 E5            [11] 1269 	push	hl
   4F68 DD 6E E7      [19] 1270 	ld	l,-25 (ix)
   4F6B DD 66 E8      [19] 1271 	ld	h,-24 (ix)
   4F6E E5            [11] 1272 	push	hl
   4F6F CD 78 5F      [17] 1273 	call	__divsint
   4F72 F1            [10] 1274 	pop	af
   4F73 F1            [10] 1275 	pop	af
   4F74 DD 74 E8      [19] 1276 	ld	-24 (ix),h
   4F77 DD 75 E7      [19] 1277 	ld	-25 (ix), l
   4F7A 55            [ 4] 1278 	ld	d, l
   4F7B                    1279 00159$:
                           1280 ;src/Renderer.c:570: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   4F7B DD 46 E2      [19] 1281 	ld	b,-30 (ix)
   4F7E CB 38         [ 8] 1282 	srl	b
   4F80 D5            [11] 1283 	push	de
   4F81 33            [ 6] 1284 	inc	sp
   4F82 DD 66 D5      [19] 1285 	ld	h,-43 (ix)
   4F85 DD 6E D3      [19] 1286 	ld	l,-45 (ix)
   4F88 E5            [11] 1287 	push	hl
   4F89 C5            [11] 1288 	push	bc
   4F8A 33            [ 6] 1289 	inc	sp
   4F8B CD B9 48      [17] 1290 	call	_draw_column_to_buffer
   4F8E F1            [10] 1291 	pop	af
   4F8F F1            [10] 1292 	pop	af
   4F90                    1293 00163$:
                           1294 ;src/Renderer.c:573: ++xCellCount;
   4F90 DD 34 D8      [23] 1295 	inc	-40 (ix)
                           1296 ;src/Renderer.c:493: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   4F93 DD 35 E2      [23] 1297 	dec	-30 (ix)
   4F96 DD 7E E2      [19] 1298 	ld	a,-30 (ix)
   4F99 D6 50         [ 7] 1299 	sub	a, #0x50
   4F9B D2 0A 4D      [10] 1300 	jp	NC,00170$
                           1301 ;src/Renderer.c:580: lineStart = lineStart + (offsetDiff * 2) + 3;
   4F9E DD 7E F9      [19] 1302 	ld	a,-7 (ix)
   4FA1 C6 03         [ 7] 1303 	add	a, #0x03
   4FA3 DD 77 DD      [19] 1304 	ld	-35 (ix),a
                           1305 ;src/Renderer.c:581: zHeight += zHeight;
   4FA6 DD CB D7 26   [23] 1306 	sla	-41 (ix)
                           1307 ;src/Renderer.c:582: offsetDiff = offsetDiff >> 1;
   4FAA DD CB DE 3E   [23] 1308 	srl	-34 (ix)
                           1309 ;src/Renderer.c:584: }while(z);
   4FAE DD 7E D4      [19] 1310 	ld	a,-44 (ix)
   4FB1 B7            [ 4] 1311 	or	a, a
   4FB2 C2 54 4A      [10] 1312 	jp	NZ,00165$
   4FB5 DD F9         [10] 1313 	ld	sp, ix
   4FB7 DD E1         [14] 1314 	pop	ix
   4FB9 C9            [10] 1315 	ret
                           1316 ;src/Renderer.c:592: void draw_minimap_to_buffer(){
                           1317 ;	---------------------------------
                           1318 ; Function draw_minimap_to_buffer
                           1319 ; ---------------------------------
   4FBA                    1320 _draw_minimap_to_buffer::
   4FBA DD E5         [15] 1321 	push	ix
   4FBC DD 21 00 00   [14] 1322 	ld	ix,#0
   4FC0 DD 39         [15] 1323 	add	ix,sp
   4FC2 21 F5 FF      [10] 1324 	ld	hl,#-11
   4FC5 39            [11] 1325 	add	hl,sp
   4FC6 F9            [ 6] 1326 	ld	sp,hl
                           1327 ;src/Renderer.c:595: u8* ptr = MINIMAP_BUFFER;
   4FC7 01 40 1C      [10] 1328 	ld	bc,#0x1C40
                           1329 ;src/Renderer.c:600: y=(PLAYER_position.y-MINIMAP_HEIGHT_HALF);
   4FCA 3A D5 46      [13] 1330 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   4FCD C6 F8         [ 7] 1331 	add	a,#0xF8
   4FCF 5F            [ 4] 1332 	ld	e,a
                           1333 ;src/Renderer.c:602: for(j=0;j<MINIMAP_HEIGHT;++j){
   4FD0 16 00         [ 7] 1334 	ld	d,#0x00
                           1335 ;src/Renderer.c:603: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   4FD2                    1336 00133$:
   4FD2 7B            [ 4] 1337 	ld	a,e
   4FD3 07            [ 4] 1338 	rlca
   4FD4 E6 01         [ 7] 1339 	and	a,#0x01
   4FD6 DD 77 FF      [19] 1340 	ld	-1 (ix),a
   4FD9 7B            [ 4] 1341 	ld	a,e
   4FDA EE 80         [ 7] 1342 	xor	a, #0x80
   4FDC D6 A0         [ 7] 1343 	sub	a, #0xA0
   4FDE 3E 00         [ 7] 1344 	ld	a,#0x00
   4FE0 17            [ 4] 1345 	rla
   4FE1 DD 77 FE      [19] 1346 	ld	-2 (ix),a
   4FE4 DD 36 F6 00   [19] 1347 	ld	-10 (ix),#0x00
   4FE8                    1348 00119$:
                           1349 ;src/Renderer.c:604: x=(PLAYER_position.x-MINIMAP_WIDTH_HALF);
   4FE8 3A D4 46      [13] 1350 	ld	a, (#_PLAYER_position + 0)
   4FEB C6 F8         [ 7] 1351 	add	a,#0xF8
   4FED DD 77 FD      [19] 1352 	ld	-3 (ix),a
                           1353 ;src/Renderer.c:605: for(i=0;i<MINIMAP_WIDTH;++i){
   4FF0 DD 36 F5 00   [19] 1354 	ld	-11 (ix),#0x00
   4FF4                    1355 00117$:
                           1356 ;src/Renderer.c:608: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   4FF4 FD 21 10 00   [14] 1357 	ld	iy,#0x0010
   4FF8 FD 09         [15] 1358 	add	iy, bc
                           1359 ;src/Renderer.c:606: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
   4FFA DD CB FD 7E   [20] 1360 	bit	7, -3 (ix)
   4FFE 20 15         [12] 1361 	jr	NZ,00108$
   5000 DD 7E FD      [19] 1362 	ld	a,-3 (ix)
   5003 EE 80         [ 7] 1363 	xor	a, #0x80
   5005 D6 A0         [ 7] 1364 	sub	a, #0xA0
   5007 30 0C         [12] 1365 	jr	NC,00108$
   5009 DD 7E FF      [19] 1366 	ld	a,-1 (ix)
   500C B7            [ 4] 1367 	or	a, a
   500D 20 06         [12] 1368 	jr	NZ,00108$
   500F DD CB FE 46   [20] 1369 	bit	0,-2 (ix)
   5013 20 0D         [12] 1370 	jr	NZ,00109$
   5015                    1371 00108$:
                           1372 ;src/Renderer.c:607: *ptr=g_colors[MINIMAP_WALL_COLOR];
   5015 3A A1 48      [13] 1373 	ld	a, (#(_g_colors + 0x0001) + 0)
   5018 02            [ 7] 1374 	ld	(bc),a
                           1375 ;src/Renderer.c:608: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   5019 3A A1 48      [13] 1376 	ld	a, (#(_g_colors + 0x0001) + 0)
   501C FD 77 00      [19] 1377 	ld	0 (iy), a
   501F C3 B9 50      [10] 1378 	jp	00110$
   5022                    1379 00109$:
                           1380 ;src/Renderer.c:610: else if((x==PLAYER_position.x)&&(y==PLAYER_position.y)){
   5022 DD 7E FD      [19] 1381 	ld	a,-3 (ix)
   5025 DD 77 FB      [19] 1382 	ld	-5 (ix),a
   5028 DD 7E FD      [19] 1383 	ld	a,-3 (ix)
   502B 17            [ 4] 1384 	rla
   502C 9F            [ 4] 1385 	sbc	a, a
   502D DD 77 FC      [19] 1386 	ld	-4 (ix),a
   5030 3A D4 46      [13] 1387 	ld	a, (#_PLAYER_position + 0)
   5033 DD 77 F9      [19] 1388 	ld	-7 (ix),a
   5036 DD 36 FA 00   [19] 1389 	ld	-6 (ix),#0x00
   503A DD 73 F7      [19] 1390 	ld	-9 (ix),e
   503D 7B            [ 4] 1391 	ld	a,e
   503E 17            [ 4] 1392 	rla
   503F 9F            [ 4] 1393 	sbc	a, a
   5040 DD 77 F8      [19] 1394 	ld	-8 (ix),a
   5043 DD 7E FB      [19] 1395 	ld	a,-5 (ix)
   5046 DD 96 F9      [19] 1396 	sub	a, -7 (ix)
   5049 20 2E         [12] 1397 	jr	NZ,00105$
   504B DD 7E FC      [19] 1398 	ld	a,-4 (ix)
   504E DD 96 FA      [19] 1399 	sub	a, -6 (ix)
   5051 20 26         [12] 1400 	jr	NZ,00105$
   5053 3A D5 46      [13] 1401 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   5056 DD 77 F9      [19] 1402 	ld	-7 (ix),a
   5059 DD 36 FA 00   [19] 1403 	ld	-6 (ix),#0x00
   505D DD 7E F7      [19] 1404 	ld	a,-9 (ix)
   5060 DD 96 F9      [19] 1405 	sub	a, -7 (ix)
   5063 20 14         [12] 1406 	jr	NZ,00105$
   5065 DD 7E F8      [19] 1407 	ld	a,-8 (ix)
   5068 DD 96 FA      [19] 1408 	sub	a, -6 (ix)
   506B 20 0C         [12] 1409 	jr	NZ,00105$
                           1410 ;src/Renderer.c:611: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
   506D 3A A5 48      [13] 1411 	ld	a, (#(_g_colors + 0x0005) + 0)
   5070 02            [ 7] 1412 	ld	(bc),a
                           1413 ;src/Renderer.c:612: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
   5071 3A A5 48      [13] 1414 	ld	a, (#(_g_colors + 0x0005) + 0)
   5074 FD 77 00      [19] 1415 	ld	0 (iy), a
   5077 18 40         [12] 1416 	jr	00110$
   5079                    1417 00105$:
                           1418 ;src/Renderer.c:615: switch(*(u8*)(MAP_MEM+x+y*MAP_WIDTH)){
   5079 DD 7E FB      [19] 1419 	ld	a,-5 (ix)
   507C C6 40         [ 7] 1420 	add	a, #0x40
   507E DD 77 F9      [19] 1421 	ld	-7 (ix),a
   5081 DD 7E FC      [19] 1422 	ld	a,-4 (ix)
   5084 CE 00         [ 7] 1423 	adc	a, #0x00
   5086 DD 77 FA      [19] 1424 	ld	-6 (ix),a
   5089 DD 6E F7      [19] 1425 	ld	l,-9 (ix)
   508C DD 66 F8      [19] 1426 	ld	h,-8 (ix)
   508F 29            [11] 1427 	add	hl, hl
   5090 29            [11] 1428 	add	hl, hl
   5091 29            [11] 1429 	add	hl, hl
   5092 29            [11] 1430 	add	hl, hl
   5093 29            [11] 1431 	add	hl, hl
   5094 DD 7E F9      [19] 1432 	ld	a,-7 (ix)
   5097 85            [ 4] 1433 	add	a, l
   5098 6F            [ 4] 1434 	ld	l,a
   5099 DD 7E FA      [19] 1435 	ld	a,-6 (ix)
   509C 8C            [ 4] 1436 	adc	a, h
   509D 67            [ 4] 1437 	ld	h,a
   509E 7E            [ 7] 1438 	ld	a,(hl)
   509F D6 FE         [ 7] 1439 	sub	a, #0xFE
   50A1 20 0C         [12] 1440 	jr	NZ,00102$
                           1441 ;src/Renderer.c:617: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
   50A3 3A A3 48      [13] 1442 	ld	a, (#(_g_colors + 0x0003) + 0)
   50A6 02            [ 7] 1443 	ld	(bc),a
                           1444 ;src/Renderer.c:618: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
   50A7 3A A3 48      [13] 1445 	ld	a, (#(_g_colors + 0x0003) + 0)
   50AA FD 77 00      [19] 1446 	ld	0 (iy), a
                           1447 ;src/Renderer.c:619: break;
   50AD 18 0A         [12] 1448 	jr	00110$
                           1449 ;src/Renderer.c:621: default:{
   50AF                    1450 00102$:
                           1451 ;src/Renderer.c:622: *ptr=g_colors[MINIMAP_WALL_COLOR];
   50AF 3A A1 48      [13] 1452 	ld	a, (#(_g_colors + 0x0001) + 0)
   50B2 02            [ 7] 1453 	ld	(bc),a
                           1454 ;src/Renderer.c:623: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   50B3 3A A1 48      [13] 1455 	ld	a, (#(_g_colors + 0x0001) + 0)
   50B6 FD 77 00      [19] 1456 	ld	0 (iy), a
                           1457 ;src/Renderer.c:626: }
   50B9                    1458 00110$:
                           1459 ;src/Renderer.c:628: ++x;
   50B9 DD 34 FD      [23] 1460 	inc	-3 (ix)
                           1461 ;src/Renderer.c:629: ++ptr;
   50BC 03            [ 6] 1462 	inc	bc
                           1463 ;src/Renderer.c:605: for(i=0;i<MINIMAP_WIDTH;++i){
   50BD DD 34 F5      [23] 1464 	inc	-11 (ix)
   50C0 DD 7E F5      [19] 1465 	ld	a,-11 (ix)
   50C3 D6 10         [ 7] 1466 	sub	a, #0x10
   50C5 DA F4 4F      [10] 1467 	jp	C,00117$
                           1468 ;src/Renderer.c:603: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   50C8 DD 34 F6      [23] 1469 	inc	-10 (ix)
   50CB DD 7E F6      [19] 1470 	ld	a,-10 (ix)
   50CE D6 04         [ 7] 1471 	sub	a, #0x04
   50D0 DA E8 4F      [10] 1472 	jp	C,00119$
                           1473 ;src/Renderer.c:632: ++y;
   50D3 1C            [ 4] 1474 	inc	e
                           1475 ;src/Renderer.c:602: for(j=0;j<MINIMAP_HEIGHT;++j){
   50D4 14            [ 4] 1476 	inc	d
   50D5 7A            [ 4] 1477 	ld	a,d
   50D6 D6 10         [ 7] 1478 	sub	a, #0x10
   50D8 DA D2 4F      [10] 1479 	jp	C,00133$
   50DB DD F9         [10] 1480 	ld	sp, ix
   50DD DD E1         [14] 1481 	pop	ix
   50DF C9            [10] 1482 	ret
                           1483 	.area _CODE
                           1484 	.area _INITIALIZER
                           1485 	.area _CABS (ABS)
