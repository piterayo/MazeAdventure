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
                             56 ;src/Renderer.c:208: void calculate_cells_in_view(){
                             57 ;	---------------------------------
                             58 ; Function calculate_cells_in_view
                             59 ; ---------------------------------
   49C7                      60 _calculate_cells_in_view::
   49C7 DD E5         [15]   61 	push	ix
   49C9 DD 21 00 00   [14]   62 	ld	ix,#0
   49CD DD 39         [15]   63 	add	ix,sp
   49CF 21 F2 FF      [10]   64 	ld	hl,#-14
   49D2 39            [11]   65 	add	hl,sp
   49D3 F9            [ 6]   66 	ld	sp,hl
                             67 ;src/Renderer.c:210: u8 offset=0, n=0, j, i;
   49D4 DD 36 FA 00   [19]   68 	ld	-6 (ix),#0x00
   49D8 DD 36 F9 00   [19]   69 	ld	-7 (ix),#0x00
                             70 ;src/Renderer.c:213: if(PLAYER_direction.y!=0){
   49DC 3A BD 49      [13]   71 	ld	a,(#_PLAYER_direction + 1)
   49DF DD 77 FD      [19]   72 	ld	-3 (ix), a
   49E2 B7            [ 4]   73 	or	a, a
   49E3 28 32         [12]   74 	jr	Z,00102$
                             75 ;src/Renderer.c:214: vert=1;
   49E5 DD 36 F2 01   [19]   76 	ld	-14 (ix),#0x01
                             77 ;src/Renderer.c:215: dy=PLAYER_direction.y;
   49E9 DD 4E FD      [19]   78 	ld	c,-3 (ix)
   49EC DD 71 F4      [19]   79 	ld	-12 (ix),c
                             80 ;src/Renderer.c:216: dx=-PLAYER_direction.y;
   49EF AF            [ 4]   81 	xor	a, a
   49F0 DD 96 FD      [19]   82 	sub	a, -3 (ix)
   49F3 DD 77 F5      [19]   83 	ld	-11 (ix), a
                             84 ;src/Renderer.c:218: x0 = PLAYER_position.x-(17*dx);
   49F6 21 BA 49      [10]   85 	ld	hl,#_PLAYER_position+0
   49F9 4E            [ 7]   86 	ld	c,(hl)
   49FA DD 6E F5      [19]   87 	ld	l,-11 (ix)
   49FD 5D            [ 4]   88 	ld	e,l
   49FE 29            [11]   89 	add	hl, hl
   49FF 29            [11]   90 	add	hl, hl
   4A00 29            [11]   91 	add	hl, hl
   4A01 29            [11]   92 	add	hl, hl
   4A02 19            [11]   93 	add	hl, de
   4A03 79            [ 4]   94 	ld	a,c
   4A04 95            [ 4]   95 	sub	a, l
   4A05 DD 77 F6      [19]   96 	ld	-10 (ix),a
                             97 ;src/Renderer.c:219: y0 = PLAYER_position.y+(6*dy);
   4A08 21 BB 49      [10]   98 	ld	hl,#_PLAYER_position+1
   4A0B 4E            [ 7]   99 	ld	c,(hl)
   4A0C DD 6E F4      [19]  100 	ld	l,-12 (ix)
   4A0F 5D            [ 4]  101 	ld	e,l
   4A10 29            [11]  102 	add	hl, hl
   4A11 19            [11]  103 	add	hl, de
   4A12 29            [11]  104 	add	hl, hl
   4A13 09            [11]  105 	add	hl, bc
   4A14 4D            [ 4]  106 	ld	c,l
   4A15 18 34         [12]  107 	jr	00103$
   4A17                     108 00102$:
                            109 ;src/Renderer.c:222: vert=0;
   4A17 DD 36 F2 00   [19]  110 	ld	-14 (ix),#0x00
                            111 ;src/Renderer.c:223: dy=PLAYER_direction.x;
   4A1B 3A BC 49      [13]  112 	ld	a,(#_PLAYER_direction + 0)
   4A1E DD 77 FD      [19]  113 	ld	-3 (ix), a
   4A21 DD 77 F4      [19]  114 	ld	-12 (ix),a
                            115 ;src/Renderer.c:224: dx=PLAYER_direction.x;
   4A24 DD 7E FD      [19]  116 	ld	a,-3 (ix)
   4A27 DD 77 F5      [19]  117 	ld	-11 (ix),a
                            118 ;src/Renderer.c:226: y0 = PLAYER_position.y-(17*dy);
   4A2A 21 BB 49      [10]  119 	ld	hl, #_PLAYER_position + 1
   4A2D 4E            [ 7]  120 	ld	c,(hl)
   4A2E DD 6E F4      [19]  121 	ld	l,-12 (ix)
   4A31 5D            [ 4]  122 	ld	e,l
   4A32 29            [11]  123 	add	hl, hl
   4A33 29            [11]  124 	add	hl, hl
   4A34 29            [11]  125 	add	hl, hl
   4A35 29            [11]  126 	add	hl, hl
   4A36 19            [11]  127 	add	hl, de
   4A37 79            [ 4]  128 	ld	a,c
   4A38 95            [ 4]  129 	sub	a, l
   4A39 4F            [ 4]  130 	ld	c,a
                            131 ;src/Renderer.c:227: x0 = PLAYER_position.x+(6*dx);
   4A3A 21 BA 49      [10]  132 	ld	hl, #_PLAYER_position + 0
   4A3D 46            [ 7]  133 	ld	b,(hl)
   4A3E DD 7E FD      [19]  134 	ld	a,-3 (ix)
   4A41 5F            [ 4]  135 	ld	e,a
   4A42 87            [ 4]  136 	add	a, a
   4A43 83            [ 4]  137 	add	a, e
   4A44 87            [ 4]  138 	add	a, a
   4A45 5F            [ 4]  139 	ld	e,a
   4A46 68            [ 4]  140 	ld	l,b
   4A47 19            [11]  141 	add	hl, de
   4A48 DD 75 F6      [19]  142 	ld	-10 (ix),l
   4A4B                     143 00103$:
                            144 ;src/Renderer.c:231: x=x0;
   4A4B DD 5E F6      [19]  145 	ld	e,-10 (ix)
                            146 ;src/Renderer.c:232: y=y0;
   4A4E DD 71 F3      [19]  147 	ld	-13 (ix),c
                            148 ;src/Renderer.c:234: for(j=0;j<6;++j){
   4A51 DD 7E F5      [19]  149 	ld	a,-11 (ix)
   4A54 07            [ 4]  150 	rlca
   4A55 E6 01         [ 7]  151 	and	a,#0x01
   4A57 DD 77 FD      [19]  152 	ld	-3 (ix),a
   4A5A DD 7E F4      [19]  153 	ld	a,-12 (ix)
   4A5D 07            [ 4]  154 	rlca
   4A5E E6 01         [ 7]  155 	and	a,#0x01
   4A60 DD 77 FB      [19]  156 	ld	-5 (ix),a
   4A63 DD 36 F8 00   [19]  157 	ld	-8 (ix),#0x00
                            158 ;src/Renderer.c:236: for(i=offset;i<35-offset;++i){
   4A67                     159 00138$:
   4A67 DD 7E F9      [19]  160 	ld	a,-7 (ix)
   4A6A DD 77 FC      [19]  161 	ld	-4 (ix),a
   4A6D DD 7E FA      [19]  162 	ld	a,-6 (ix)
   4A70 DD 77 F7      [19]  163 	ld	-9 (ix),a
   4A73                     164 00125$:
   4A73 DD 6E FA      [19]  165 	ld	l,-6 (ix)
   4A76 26 00         [ 7]  166 	ld	h,#0x00
   4A78 3E 23         [ 7]  167 	ld	a,#0x23
   4A7A 95            [ 4]  168 	sub	a, l
   4A7B 6F            [ 4]  169 	ld	l,a
   4A7C 3E 00         [ 7]  170 	ld	a,#0x00
   4A7E 9C            [ 4]  171 	sbc	a, h
   4A7F 67            [ 4]  172 	ld	h,a
   4A80 DD 7E F7      [19]  173 	ld	a, -9 (ix)
   4A83 16 00         [ 7]  174 	ld	d, #0x00
   4A85 95            [ 4]  175 	sub	a, l
   4A86 7A            [ 4]  176 	ld	a,d
   4A87 9C            [ 4]  177 	sbc	a, h
   4A88 E2 8D 4A      [10]  178 	jp	PO, 00181$
   4A8B EE 80         [ 7]  179 	xor	a, #0x80
   4A8D                     180 00181$:
   4A8D F2 0C 4B      [10]  181 	jp	P,00143$
                            182 ;src/Renderer.c:239: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   4A90 2A 99 4B      [16]  183 	ld	hl,(_cells_in_view_array)
   4A93 7D            [ 4]  184 	ld	a,l
   4A94 DD 86 FC      [19]  185 	add	a, -4 (ix)
   4A97 DD 77 FE      [19]  186 	ld	-2 (ix),a
   4A9A 7C            [ 4]  187 	ld	a,h
   4A9B CE 00         [ 7]  188 	adc	a, #0x00
   4A9D DD 77 FF      [19]  189 	ld	-1 (ix),a
                            190 ;src/Renderer.c:238: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
   4AA0 CB 7B         [ 8]  191 	bit	7, e
   4AA2 20 41         [12]  192 	jr	NZ,00105$
   4AA4 7B            [ 4]  193 	ld	a,e
   4AA5 EE 80         [ 7]  194 	xor	a, #0x80
   4AA7 D6 A0         [ 7]  195 	sub	a, #0xA0
   4AA9 30 3A         [12]  196 	jr	NC,00105$
   4AAB DD CB F3 7E   [20]  197 	bit	7, -13 (ix)
   4AAF 20 34         [12]  198 	jr	NZ,00105$
   4AB1 DD 7E F3      [19]  199 	ld	a,-13 (ix)
   4AB4 EE 80         [ 7]  200 	xor	a, #0x80
   4AB6 D6 A0         [ 7]  201 	sub	a, #0xA0
   4AB8 30 2B         [12]  202 	jr	NC,00105$
                            203 ;src/Renderer.c:239: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   4ABA 7B            [ 4]  204 	ld	a,e
   4ABB 57            [ 4]  205 	ld	d,a
   4ABC 17            [ 4]  206 	rla
   4ABD 9F            [ 4]  207 	sbc	a, a
   4ABE 6F            [ 4]  208 	ld	l,a
   4ABF 7A            [ 4]  209 	ld	a,d
   4AC0 C6 40         [ 7]  210 	add	a, #0x40
   4AC2 47            [ 4]  211 	ld	b,a
   4AC3 7D            [ 4]  212 	ld	a,l
   4AC4 CE 00         [ 7]  213 	adc	a, #0x00
   4AC6 57            [ 4]  214 	ld	d,a
   4AC7 DD 6E F3      [19]  215 	ld	l,-13 (ix)
   4ACA DD 7E F3      [19]  216 	ld	a,-13 (ix)
   4ACD 17            [ 4]  217 	rla
   4ACE 9F            [ 4]  218 	sbc	a, a
   4ACF 67            [ 4]  219 	ld	h,a
   4AD0 29            [11]  220 	add	hl, hl
   4AD1 29            [11]  221 	add	hl, hl
   4AD2 29            [11]  222 	add	hl, hl
   4AD3 29            [11]  223 	add	hl, hl
   4AD4 29            [11]  224 	add	hl, hl
   4AD5 78            [ 4]  225 	ld	a,b
   4AD6 85            [ 4]  226 	add	a, l
   4AD7 6F            [ 4]  227 	ld	l,a
   4AD8 7A            [ 4]  228 	ld	a,d
   4AD9 8C            [ 4]  229 	adc	a, h
   4ADA 67            [ 4]  230 	ld	h,a
   4ADB 46            [ 7]  231 	ld	b,(hl)
   4ADC DD 6E FE      [19]  232 	ld	l,-2 (ix)
   4ADF DD 66 FF      [19]  233 	ld	h,-1 (ix)
   4AE2 70            [ 7]  234 	ld	(hl),b
   4AE3 18 08         [12]  235 	jr	00106$
   4AE5                     236 00105$:
                            237 ;src/Renderer.c:242: cells_in_view_array[n]=CELLTYPE_WALL1;
   4AE5 DD 6E FE      [19]  238 	ld	l,-2 (ix)
   4AE8 DD 66 FF      [19]  239 	ld	h,-1 (ix)
   4AEB 36 81         [10]  240 	ld	(hl),#0x81
   4AED                     241 00106$:
                            242 ;src/Renderer.c:246: if(vert){
   4AED DD 7E F2      [19]  243 	ld	a,-14 (ix)
   4AF0 B7            [ 4]  244 	or	a, a
   4AF1 28 07         [12]  245 	jr	Z,00111$
                            246 ;src/Renderer.c:247: x+=dx;
   4AF3 7B            [ 4]  247 	ld	a,e
   4AF4 DD 86 F5      [19]  248 	add	a, -11 (ix)
   4AF7 5F            [ 4]  249 	ld	e,a
   4AF8 18 09         [12]  250 	jr	00112$
   4AFA                     251 00111$:
                            252 ;src/Renderer.c:250: y+=dy;
   4AFA DD 7E F3      [19]  253 	ld	a,-13 (ix)
   4AFD DD 86 F4      [19]  254 	add	a, -12 (ix)
   4B00 DD 77 F3      [19]  255 	ld	-13 (ix),a
   4B03                     256 00112$:
                            257 ;src/Renderer.c:252: ++n;
   4B03 DD 34 FC      [23]  258 	inc	-4 (ix)
                            259 ;src/Renderer.c:236: for(i=offset;i<35-offset;++i){
   4B06 DD 34 F7      [23]  260 	inc	-9 (ix)
   4B09 C3 73 4A      [10]  261 	jp	00125$
   4B0C                     262 00143$:
   4B0C DD 7E FC      [19]  263 	ld	a,-4 (ix)
   4B0F DD 77 F9      [19]  264 	ld	-7 (ix),a
                            265 ;src/Renderer.c:254: offset=offsets_cells_in_view[j];
   4B12 3E 9B         [ 7]  266 	ld	a,#<(_offsets_cells_in_view)
   4B14 DD 86 F8      [19]  267 	add	a, -8 (ix)
   4B17 6F            [ 4]  268 	ld	l,a
   4B18 3E 4B         [ 7]  269 	ld	a,#>(_offsets_cells_in_view)
   4B1A CE 00         [ 7]  270 	adc	a, #0x00
   4B1C 67            [ 4]  271 	ld	h,a
   4B1D 7E            [ 7]  272 	ld	a,(hl)
                            273 ;src/Renderer.c:258: if(dx<0) x=x0-offset;
   4B1E DD 77 FA      [19]  274 	ld	-6 (ix), a
   4B21 DD 77 FE      [19]  275 	ld	-2 (ix),a
                            276 ;src/Renderer.c:256: if(vert){
   4B24 DD 7E F2      [19]  277 	ld	a,-14 (ix)
   4B27 B7            [ 4]  278 	or	a, a
   4B28 28 21         [12]  279 	jr	Z,00121$
                            280 ;src/Renderer.c:257: y-=dy;
   4B2A DD 7E F3      [19]  281 	ld	a,-13 (ix)
   4B2D DD 96 F4      [19]  282 	sub	a, -12 (ix)
   4B30 DD 77 F3      [19]  283 	ld	-13 (ix),a
                            284 ;src/Renderer.c:258: if(dx<0) x=x0-offset;
   4B33 DD 7E FD      [19]  285 	ld	a,-3 (ix)
   4B36 B7            [ 4]  286 	or	a, a
   4B37 28 09         [12]  287 	jr	Z,00115$
   4B39 DD 7E F6      [19]  288 	ld	a,-10 (ix)
   4B3C DD 96 FE      [19]  289 	sub	a, -2 (ix)
   4B3F 5F            [ 4]  290 	ld	e,a
   4B40 18 24         [12]  291 	jr	00128$
   4B42                     292 00115$:
                            293 ;src/Renderer.c:259: else x=x0+offset;
   4B42 DD 7E F6      [19]  294 	ld	a,-10 (ix)
   4B45 DD 86 FE      [19]  295 	add	a, -2 (ix)
   4B48 5F            [ 4]  296 	ld	e,a
   4B49 18 1B         [12]  297 	jr	00128$
   4B4B                     298 00121$:
                            299 ;src/Renderer.c:263: x-=dx;
   4B4B 7B            [ 4]  300 	ld	a,e
   4B4C DD 96 F5      [19]  301 	sub	a, -11 (ix)
   4B4F 5F            [ 4]  302 	ld	e,a
                            303 ;src/Renderer.c:264: if(dy<0) y=y0-offset;
   4B50 DD 7E FB      [19]  304 	ld	a,-5 (ix)
   4B53 B7            [ 4]  305 	or	a, a
   4B54 28 09         [12]  306 	jr	Z,00118$
   4B56 79            [ 4]  307 	ld	a,c
   4B57 DD 96 FE      [19]  308 	sub	a, -2 (ix)
   4B5A DD 77 F3      [19]  309 	ld	-13 (ix),a
   4B5D 18 07         [12]  310 	jr	00128$
   4B5F                     311 00118$:
                            312 ;src/Renderer.c:265: else y=y0+offset;
   4B5F 79            [ 4]  313 	ld	a,c
   4B60 DD 86 FE      [19]  314 	add	a, -2 (ix)
   4B63 DD 77 F3      [19]  315 	ld	-13 (ix),a
   4B66                     316 00128$:
                            317 ;src/Renderer.c:234: for(j=0;j<6;++j){
   4B66 DD 34 F8      [23]  318 	inc	-8 (ix)
   4B69 DD 7E F8      [19]  319 	ld	a,-8 (ix)
   4B6C D6 06         [ 7]  320 	sub	a, #0x06
   4B6E DA 67 4A      [10]  321 	jp	C,00138$
   4B71 DD F9         [10]  322 	ld	sp, ix
   4B73 DD E1         [14]  323 	pop	ix
   4B75 C9            [10]  324 	ret
   4B76                     325 _g_palette:
   4B76 08                  326 	.db #0x08	; 8
   4B77 00                  327 	.db #0x00	; 0
   4B78 0D                  328 	.db #0x0D	; 13
   4B79 1A                  329 	.db #0x1A	; 26
   4B7A 06                  330 	.db #0x06	; 6
   4B7B 18                  331 	.db #0x18	; 24
   4B7C 19                  332 	.db #0x19	; 25
   4B7D 01                  333 	.db #0x01	; 1
   4B7E 09                  334 	.db #0x09	; 9
   4B7F 03                  335 	.db #0x03	; 3
   4B80 12                  336 	.db #0x12	; 18
   4B81 05                  337 	.db #0x05	; 5
   4B82 0E                  338 	.db #0x0E	; 14
   4B83 0F                  339 	.db #0x0F	; 15
   4B84 11                  340 	.db #0x11	; 17
   4B85 13                  341 	.db #0x13	; 19
   4B86                     342 _g_colors:
   4B86 00                  343 	.db #0x00	; 0
   4B87 C0                  344 	.db #0xC0	; 192
   4B88 0C                  345 	.db #0x0C	; 12
   4B89 CC                  346 	.db #0xCC	; 204
   4B8A 30                  347 	.db #0x30	; 48	'0'
   4B8B F0                  348 	.db #0xF0	; 240
   4B8C 3C                  349 	.db #0x3C	; 60
   4B8D FC                  350 	.db #0xFC	; 252
   4B8E 03                  351 	.db #0x03	; 3
   4B8F C3                  352 	.db #0xC3	; 195
   4B90 0F                  353 	.db #0x0F	; 15
   4B91 CF                  354 	.db #0xCF	; 207
   4B92 33                  355 	.db #0x33	; 51	'3'
   4B93 F3                  356 	.db #0xF3	; 243
   4B94 3F                  357 	.db #0x3F	; 63
   4B95 FF                  358 	.db #0xFF	; 255
   4B96                     359 _g_pixelMask:
   4B96 AA                  360 	.db #0xAA	; 170
   4B97 55                  361 	.db #0x55	; 85	'U'
   4B98                     362 _g_texturedWalls:
   4B98 01                  363 	.db #0x01	; 1
   4B99                     364 _cells_in_view_array:
   4B99 E0 38               365 	.dw #0x38E0
   4B9B                     366 _offsets_cells_in_view:
   4B9B 08                  367 	.db #0x08	; 8
   4B9C 0C                  368 	.db #0x0C	; 12
   4B9D 0E                  369 	.db #0x0E	; 14
   4B9E 0F                  370 	.db #0x0F	; 15
   4B9F 10                  371 	.db #0x10	; 16
                            372 ;src/Renderer.c:273: void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
                            373 ;	---------------------------------
                            374 ; Function draw_column_to_buffer_untextured
                            375 ; ---------------------------------
   4BA0                     376 _draw_column_to_buffer_untextured::
   4BA0 DD E5         [15]  377 	push	ix
   4BA2 DD 21 00 00   [14]  378 	ld	ix,#0
   4BA6 DD 39         [15]  379 	add	ix,sp
   4BA8 F5            [11]  380 	push	af
                            381 ;src/Renderer.c:274: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   4BA9 DD 7E 04      [19]  382 	ld	a, 4 (ix)
   4BAC CB 3F         [ 8]  383 	srl	a
   4BAE C6 40         [ 7]  384 	add	a, #0x40
   4BB0 4F            [ 4]  385 	ld	c,a
   4BB1 3E 00         [ 7]  386 	ld	a,#0x00
   4BB3 CE 29         [ 7]  387 	adc	a, #0x29
   4BB5 47            [ 4]  388 	ld	b,a
                            389 ;src/Renderer.c:276: u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
   4BB6 11 86 4B      [10]  390 	ld	de,#_g_colors+0
   4BB9 DD 6E 06      [19]  391 	ld	l,6 (ix)
   4BBC 26 00         [ 7]  392 	ld	h,#0x00
   4BBE 19            [11]  393 	add	hl,de
   4BBF 7E            [ 7]  394 	ld	a,(hl)
   4BC0 DD 77 FE      [19]  395 	ld	-2 (ix),a
                            396 ;src/Renderer.c:277: u8 pixMask = g_pixelMask[column&1];
   4BC3 11 96 4B      [10]  397 	ld	de,#_g_pixelMask+0
   4BC6 DD 7E 04      [19]  398 	ld	a,4 (ix)
   4BC9 E6 01         [ 7]  399 	and	a, #0x01
   4BCB 6F            [ 4]  400 	ld	l,a
   4BCC 26 00         [ 7]  401 	ld	h,#0x00
   4BCE 19            [11]  402 	add	hl,de
   4BCF 5E            [ 7]  403 	ld	e,(hl)
                            404 ;src/Renderer.c:286: if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
   4BD0 3E 64         [ 7]  405 	ld	a,#0x64
   4BD2 DD 96 05      [19]  406 	sub	a, 5 (ix)
   4BD5 30 04         [12]  407 	jr	NC,00102$
   4BD7 DD 36 05 64   [19]  408 	ld	5 (ix),#0x64
   4BDB                     409 00102$:
                            410 ;src/Renderer.c:288: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   4BDB DD 6E 05      [19]  411 	ld	l,5 (ix)
   4BDE CB 3D         [ 8]  412 	srl	l
   4BE0 3E 32         [ 7]  413 	ld	a,#0x32
   4BE2 95            [ 4]  414 	sub	a, l
                            415 ;src/Renderer.c:291: pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
   4BE3 D5            [11]  416 	push	de
   4BE4 5F            [ 4]  417 	ld	e,a
   4BE5 16 00         [ 7]  418 	ld	d,#0x00
   4BE7 6B            [ 4]  419 	ld	l, e
   4BE8 62            [ 4]  420 	ld	h, d
   4BE9 29            [11]  421 	add	hl, hl
   4BEA 29            [11]  422 	add	hl, hl
   4BEB 19            [11]  423 	add	hl, de
   4BEC 29            [11]  424 	add	hl, hl
   4BED 29            [11]  425 	add	hl, hl
   4BEE 29            [11]  426 	add	hl, hl
   4BEF D1            [10]  427 	pop	de
   4BF0 09            [11]  428 	add	hl,bc
   4BF1 4D            [ 4]  429 	ld	c,l
   4BF2 44            [ 4]  430 	ld	b,h
                            431 ;src/Renderer.c:293: j=lineHeight;
   4BF3 DD 56 05      [19]  432 	ld	d,5 (ix)
                            433 ;src/Renderer.c:295: for(j;j;--j){
   4BF6 7B            [ 4]  434 	ld	a,e
   4BF7 2F            [ 4]  435 	cpl
   4BF8 DD 77 FF      [19]  436 	ld	-1 (ix),a
   4BFB 7B            [ 4]  437 	ld	a,e
   4BFC DD A6 FE      [19]  438 	and	a, -2 (ix)
   4BFF 5F            [ 4]  439 	ld	e,a
   4C00                     440 00105$:
   4C00 7A            [ 4]  441 	ld	a,d
   4C01 B7            [ 4]  442 	or	a, a
   4C02 28 0F         [12]  443 	jr	Z,00107$
                            444 ;src/Renderer.c:296: val =  ((*pvmem)&(~pixMask));
   4C04 0A            [ 7]  445 	ld	a,(bc)
   4C05 DD A6 FF      [19]  446 	and	a, -1 (ix)
                            447 ;src/Renderer.c:298: *pvmem = val|(w_color&pixMask);
   4C08 B3            [ 4]  448 	or	a, e
   4C09 02            [ 7]  449 	ld	(bc),a
                            450 ;src/Renderer.c:300: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   4C0A 21 28 00      [10]  451 	ld	hl,#0x0028
   4C0D 09            [11]  452 	add	hl,bc
   4C0E 4D            [ 4]  453 	ld	c,l
   4C0F 44            [ 4]  454 	ld	b,h
                            455 ;src/Renderer.c:295: for(j;j;--j){
   4C10 15            [ 4]  456 	dec	d
   4C11 18 ED         [12]  457 	jr	00105$
   4C13                     458 00107$:
   4C13 DD F9         [10]  459 	ld	sp, ix
   4C15 DD E1         [14]  460 	pop	ix
   4C17 C9            [10]  461 	ret
                            462 ;src/Renderer.c:304: void draw_column_to_buffer_object(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            463 ;	---------------------------------
                            464 ; Function draw_column_to_buffer_object
                            465 ; ---------------------------------
   4C18                     466 _draw_column_to_buffer_object::
                            467 ;src/Renderer.c:306: }
   4C18 C9            [10]  468 	ret
                            469 ;src/Renderer.c:308: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            470 ;	---------------------------------
                            471 ; Function draw_column_to_buffer_enemy
                            472 ; ---------------------------------
   4C19                     473 _draw_column_to_buffer_enemy::
   4C19 DD E5         [15]  474 	push	ix
   4C1B DD 21 00 00   [14]  475 	ld	ix,#0
   4C1F DD 39         [15]  476 	add	ix,sp
   4C21 21 F2 FF      [10]  477 	ld	hl,#-14
   4C24 39            [11]  478 	add	hl,sp
   4C25 F9            [ 6]  479 	ld	sp,hl
                            480 ;src/Renderer.c:325: u16 texture_line=0;
   4C26 DD 36 F7 00   [19]  481 	ld	-9 (ix),#0x00
   4C2A DD 36 F8 00   [19]  482 	ld	-8 (ix),#0x00
                            483 ;src/Renderer.c:327: if(texture_column>=4 && texture_column<28){
   4C2E DD 7E 07      [19]  484 	ld	a,7 (ix)
   4C31 D6 04         [ 7]  485 	sub	a, #0x04
   4C33 DA 52 4D      [10]  486 	jp	C,00112$
   4C36 DD 7E 07      [19]  487 	ld	a,7 (ix)
   4C39 D6 1C         [ 7]  488 	sub	a, #0x1C
   4C3B D2 52 4D      [10]  489 	jp	NC,00112$
                            490 ;src/Renderer.c:330: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(index-1)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
   4C3E DD 4E 06      [19]  491 	ld	c,6 (ix)
   4C41 06 00         [ 7]  492 	ld	b,#0x00
   4C43 0B            [ 6]  493 	dec	bc
   4C44 69            [ 4]  494 	ld	l, c
   4C45 60            [ 4]  495 	ld	h, b
   4C46 29            [11]  496 	add	hl, hl
   4C47 29            [11]  497 	add	hl, hl
   4C48 29            [11]  498 	add	hl, hl
   4C49 09            [11]  499 	add	hl, bc
   4C4A 29            [11]  500 	add	hl, hl
   4C4B 29            [11]  501 	add	hl, hl
   4C4C 29            [11]  502 	add	hl, hl
   4C4D 29            [11]  503 	add	hl, hl
   4C4E 29            [11]  504 	add	hl, hl
   4C4F 29            [11]  505 	add	hl, hl
   4C50 01 40 18      [10]  506 	ld	bc,#0x1840
   4C53 09            [11]  507 	add	hl,bc
   4C54 4D            [ 4]  508 	ld	c,l
   4C55 44            [ 4]  509 	ld	b,h
   4C56 DD 7E 07      [19]  510 	ld	a, 7 (ix)
   4C59 16 00         [ 7]  511 	ld	d, #0x00
   4C5B C6 FC         [ 7]  512 	add	a,#0xFC
   4C5D 5F            [ 4]  513 	ld	e,a
   4C5E 7A            [ 4]  514 	ld	a,d
   4C5F CE FF         [ 7]  515 	adc	a,#0xFF
   4C61 57            [ 4]  516 	ld	d,a
   4C62 6B            [ 4]  517 	ld	l, e
   4C63 62            [ 4]  518 	ld	h, d
   4C64 29            [11]  519 	add	hl, hl
   4C65 19            [11]  520 	add	hl, de
   4C66 29            [11]  521 	add	hl, hl
   4C67 29            [11]  522 	add	hl, hl
   4C68 29            [11]  523 	add	hl, hl
   4C69 09            [11]  524 	add	hl,bc
   4C6A DD 75 F5      [19]  525 	ld	-11 (ix),l
   4C6D DD 74 F6      [19]  526 	ld	-10 (ix),h
                            527 ;src/Renderer.c:332: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   4C70 DD 7E 04      [19]  528 	ld	a,4 (ix)
   4C73 CB 3F         [ 8]  529 	srl	a
   4C75 C6 40         [ 7]  530 	add	a, #0x40
   4C77 DD 77 FA      [19]  531 	ld	-6 (ix),a
   4C7A 3E 00         [ 7]  532 	ld	a,#0x00
   4C7C CE 29         [ 7]  533 	adc	a, #0x29
   4C7E DD 77 FB      [19]  534 	ld	-5 (ix),a
                            535 ;src/Renderer.c:334: pixMask = g_pixelMask[column&1];
   4C81 01 96 4B      [10]  536 	ld	bc,#_g_pixelMask+0
   4C84 DD 7E 04      [19]  537 	ld	a,4 (ix)
   4C87 E6 01         [ 7]  538 	and	a, #0x01
   4C89 6F            [ 4]  539 	ld	l, a
   4C8A 26 00         [ 7]  540 	ld	h,#0x00
   4C8C 09            [11]  541 	add	hl,bc
   4C8D 7E            [ 7]  542 	ld	a,(hl)
   4C8E DD 77 F9      [19]  543 	ld	-7 (ix),a
                            544 ;src/Renderer.c:336: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
   4C91 DD 7E 05      [19]  545 	ld	a,5 (ix)
   4C94 CB 3F         [ 8]  546 	srl	a
   4C96 C6 32         [ 7]  547 	add	a, #0x32
   4C98 DD 77 F4      [19]  548 	ld	-12 (ix),a
                            549 ;src/Renderer.c:337: lineHeight = (lineHeight*3)/4;
   4C9B DD 4E 05      [19]  550 	ld	c,5 (ix)
   4C9E 06 00         [ 7]  551 	ld	b,#0x00
   4CA0 69            [ 4]  552 	ld	l, c
   4CA1 60            [ 4]  553 	ld	h, b
   4CA2 29            [11]  554 	add	hl, hl
   4CA3 09            [11]  555 	add	hl, bc
   4CA4 DD 75 FE      [19]  556 	ld	-2 (ix),l
   4CA7 DD 74 FF      [19]  557 	ld	-1 (ix),h
   4CAA DD 7E FE      [19]  558 	ld	a,-2 (ix)
   4CAD DD 77 FC      [19]  559 	ld	-4 (ix),a
   4CB0 DD 7E FF      [19]  560 	ld	a,-1 (ix)
   4CB3 DD 77 FD      [19]  561 	ld	-3 (ix),a
   4CB6 DD CB FF 7E   [20]  562 	bit	7, -1 (ix)
   4CBA 28 10         [12]  563 	jr	Z,00114$
   4CBC DD 7E FE      [19]  564 	ld	a,-2 (ix)
   4CBF C6 03         [ 7]  565 	add	a, #0x03
   4CC1 DD 77 FC      [19]  566 	ld	-4 (ix),a
   4CC4 DD 7E FF      [19]  567 	ld	a,-1 (ix)
   4CC7 CE 00         [ 7]  568 	adc	a, #0x00
   4CC9 DD 77 FD      [19]  569 	ld	-3 (ix),a
   4CCC                     570 00114$:
   4CCC DD 46 FC      [19]  571 	ld	b,-4 (ix)
   4CCF DD 4E FD      [19]  572 	ld	c,-3 (ix)
   4CD2 CB 29         [ 8]  573 	sra	c
   4CD4 CB 18         [ 8]  574 	rr	b
   4CD6 CB 29         [ 8]  575 	sra	c
   4CD8 CB 18         [ 8]  576 	rr	b
                            577 ;src/Renderer.c:338: enemy_top_height = ground_height - lineHeight;
   4CDA DD 7E F4      [19]  578 	ld	a,-12 (ix)
   4CDD 90            [ 4]  579 	sub	a, b
   4CDE 4F            [ 4]  580 	ld	c,a
                            581 ;src/Renderer.c:340: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
   4CDF 58            [ 4]  582 	ld	e,b
   4CE0 16 00         [ 7]  583 	ld	d,#0x00
   4CE2 C5            [11]  584 	push	bc
   4CE3 D5            [11]  585 	push	de
   4CE4 21 00 18      [10]  586 	ld	hl,#0x1800
   4CE7 E5            [11]  587 	push	hl
   4CE8 CD E8 75      [17]  588 	call	__divsint
   4CEB F1            [10]  589 	pop	af
   4CEC F1            [10]  590 	pop	af
   4CED C1            [10]  591 	pop	bc
   4CEE 33            [ 6]  592 	inc	sp
   4CEF 33            [ 6]  593 	inc	sp
   4CF0 E5            [11]  594 	push	hl
                            595 ;src/Renderer.c:341: j=lineHeight;
   4CF1 50            [ 4]  596 	ld	d,b
                            597 ;src/Renderer.c:343: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   4CF2 3E 64         [ 7]  598 	ld	a,#0x64
   4CF4 90            [ 4]  599 	sub	a, b
   4CF5 30 02         [12]  600 	jr	NC,00102$
                            601 ;src/Renderer.c:344: j=90;
   4CF7 16 5A         [ 7]  602 	ld	d,#0x5A
   4CF9                     603 00102$:
                            604 ;src/Renderer.c:347: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
   4CF9 06 00         [ 7]  605 	ld	b,#0x00
   4CFB 69            [ 4]  606 	ld	l, c
   4CFC 60            [ 4]  607 	ld	h, b
   4CFD 29            [11]  608 	add	hl, hl
   4CFE 29            [11]  609 	add	hl, hl
   4CFF 09            [11]  610 	add	hl, bc
   4D00 29            [11]  611 	add	hl, hl
   4D01 29            [11]  612 	add	hl, hl
   4D02 29            [11]  613 	add	hl, hl
   4D03 DD 7E FA      [19]  614 	ld	a,-6 (ix)
   4D06 85            [ 4]  615 	add	a, l
   4D07 4F            [ 4]  616 	ld	c,a
   4D08 DD 7E FB      [19]  617 	ld	a,-5 (ix)
   4D0B 8C            [ 4]  618 	adc	a, h
   4D0C 47            [ 4]  619 	ld	b,a
                            620 ;src/Renderer.c:349: for(j;j;--j){
   4D0D DD 7E F9      [19]  621 	ld	a,-7 (ix)
   4D10 2F            [ 4]  622 	cpl
   4D11 5F            [ 4]  623 	ld	e,a
   4D12                     624 00110$:
   4D12 7A            [ 4]  625 	ld	a,d
   4D13 B7            [ 4]  626 	or	a, a
   4D14 28 3C         [12]  627 	jr	Z,00112$
                            628 ;src/Renderer.c:351: color= *(texture+(texture_line/256));
   4D16 DD 6E F8      [19]  629 	ld	l,-8 (ix)
   4D19 26 00         [ 7]  630 	ld	h,#0x00
   4D1B DD 7E F5      [19]  631 	ld	a,-11 (ix)
   4D1E 85            [ 4]  632 	add	a, l
   4D1F 6F            [ 4]  633 	ld	l,a
   4D20 DD 7E F6      [19]  634 	ld	a,-10 (ix)
   4D23 8C            [ 4]  635 	adc	a, h
   4D24 67            [ 4]  636 	ld	h,a
   4D25 7E            [ 7]  637 	ld	a,(hl)
                            638 ;src/Renderer.c:353: if(color){
   4D26 DD 77 FC      [19]  639 	ld	-4 (ix), a
   4D29 B7            [ 4]  640 	or	a, a
   4D2A 28 0B         [12]  641 	jr	Z,00104$
                            642 ;src/Renderer.c:354: val =  ((*pvmem)&(~pixMask));
   4D2C 0A            [ 7]  643 	ld	a,(bc)
   4D2D A3            [ 4]  644 	and	a, e
   4D2E 6F            [ 4]  645 	ld	l,a
                            646 ;src/Renderer.c:356: color = (color&pixMask);
   4D2F DD 7E FC      [19]  647 	ld	a,-4 (ix)
   4D32 DD A6 F9      [19]  648 	and	a, -7 (ix)
                            649 ;src/Renderer.c:358: *pvmem = val|color;
   4D35 B5            [ 4]  650 	or	a, l
   4D36 02            [ 7]  651 	ld	(bc),a
   4D37                     652 00104$:
                            653 ;src/Renderer.c:361: texture_line += texture_line_add;
   4D37 DD 7E F7      [19]  654 	ld	a,-9 (ix)
   4D3A DD 86 F2      [19]  655 	add	a, -14 (ix)
   4D3D DD 77 F7      [19]  656 	ld	-9 (ix),a
   4D40 DD 7E F8      [19]  657 	ld	a,-8 (ix)
   4D43 DD 8E F3      [19]  658 	adc	a, -13 (ix)
   4D46 DD 77 F8      [19]  659 	ld	-8 (ix),a
                            660 ;src/Renderer.c:363: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   4D49 21 28 00      [10]  661 	ld	hl,#0x0028
   4D4C 09            [11]  662 	add	hl,bc
   4D4D 4D            [ 4]  663 	ld	c,l
   4D4E 44            [ 4]  664 	ld	b,h
                            665 ;src/Renderer.c:349: for(j;j;--j){
   4D4F 15            [ 4]  666 	dec	d
   4D50 18 C0         [12]  667 	jr	00110$
   4D52                     668 00112$:
   4D52 DD F9         [10]  669 	ld	sp, ix
   4D54 DD E1         [14]  670 	pop	ix
   4D56 C9            [10]  671 	ret
                            672 ;src/Renderer.c:369: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
                            673 ;	---------------------------------
                            674 ; Function draw_column_to_buffer
                            675 ; ---------------------------------
   4D57                     676 _draw_column_to_buffer::
   4D57 DD E5         [15]  677 	push	ix
   4D59 DD 21 00 00   [14]  678 	ld	ix,#0
   4D5D DD 39         [15]  679 	add	ix,sp
   4D5F 21 F1 FF      [10]  680 	ld	hl,#-15
   4D62 39            [11]  681 	add	hl,sp
   4D63 F9            [ 6]  682 	ld	sp,hl
                            683 ;src/Renderer.c:370: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   4D64 DD 7E 04      [19]  684 	ld	a,4 (ix)
   4D67 CB 3F         [ 8]  685 	srl	a
   4D69 C6 40         [ 7]  686 	add	a, #0x40
   4D6B DD 77 FE      [19]  687 	ld	-2 (ix),a
   4D6E 3E 00         [ 7]  688 	ld	a,#0x00
   4D70 CE 29         [ 7]  689 	adc	a, #0x29
   4D72 DD 77 FF      [19]  690 	ld	-1 (ix),a
                            691 ;src/Renderer.c:373: u8 pixMask = g_pixelMask[column&1];
   4D75 01 96 4B      [10]  692 	ld	bc,#_g_pixelMask+0
   4D78 DD 7E 04      [19]  693 	ld	a,4 (ix)
   4D7B E6 01         [ 7]  694 	and	a, #0x01
   4D7D 6F            [ 4]  695 	ld	l, a
   4D7E 26 00         [ 7]  696 	ld	h,#0x00
   4D80 09            [11]  697 	add	hl,bc
   4D81 7E            [ 7]  698 	ld	a,(hl)
   4D82 DD 77 F7      [19]  699 	ld	-9 (ix),a
                            700 ;src/Renderer.c:378: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
   4D85 DD 7E 06      [19]  701 	ld	a, 6 (ix)
   4D88 87            [ 4]  702 	add	a, a
   4D89 87            [ 4]  703 	add	a, a
   4D8A 47            [ 4]  704 	ld	b,a
   4D8B 0E 00         [ 7]  705 	ld	c,#0x00
   4D8D 21 40 04      [10]  706 	ld	hl,#0x0440
   4D90 09            [11]  707 	add	hl,bc
   4D91 4D            [ 4]  708 	ld	c,l
   4D92 44            [ 4]  709 	ld	b,h
   4D93 DD 6E 07      [19]  710 	ld	l,7 (ix)
   4D96 26 00         [ 7]  711 	ld	h,#0x00
   4D98 29            [11]  712 	add	hl, hl
   4D99 29            [11]  713 	add	hl, hl
   4D9A 29            [11]  714 	add	hl, hl
   4D9B 29            [11]  715 	add	hl, hl
   4D9C 29            [11]  716 	add	hl, hl
   4D9D 09            [11]  717 	add	hl,bc
   4D9E DD 75 F8      [19]  718 	ld	-8 (ix),l
   4DA1 DD 74 F9      [19]  719 	ld	-7 (ix),h
                            720 ;src/Renderer.c:380: u8 j=lineHeight;
   4DA4 DD 7E 05      [19]  721 	ld	a,5 (ix)
                            722 ;src/Renderer.c:386: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
   4DA7 DD 77 F6      [19]  723 	ld	-10 (ix), a
   4DAA DD 77 FA      [19]  724 	ld	-6 (ix),a
   4DAD DD 36 FB 00   [19]  725 	ld	-5 (ix),#0x00
   4DB1 DD 6E FA      [19]  726 	ld	l,-6 (ix)
   4DB4 DD 66 FB      [19]  727 	ld	h,-5 (ix)
   4DB7 E5            [11]  728 	push	hl
   4DB8 21 00 20      [10]  729 	ld	hl,#0x2000
   4DBB E5            [11]  730 	push	hl
   4DBC CD E8 75      [17]  731 	call	__divsint
   4DBF F1            [10]  732 	pop	af
   4DC0 F1            [10]  733 	pop	af
   4DC1 DD 75 F2      [19]  734 	ld	-14 (ix),l
   4DC4 DD 74 F3      [19]  735 	ld	-13 (ix),h
                            736 ;src/Renderer.c:387: u16 wall_texture_line=0;
   4DC7 DD 36 F4 00   [19]  737 	ld	-12 (ix),#0x00
   4DCB DD 36 F5 00   [19]  738 	ld	-11 (ix),#0x00
                            739 ;src/Renderer.c:389: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   4DCF DD 4E F6      [19]  740 	ld	c,-10 (ix)
   4DD2 CB 39         [ 8]  741 	srl	c
   4DD4 3E 32         [ 7]  742 	ld	a,#0x32
   4DD6 91            [ 4]  743 	sub	a, c
   4DD7 DD 77 F1      [19]  744 	ld	-15 (ix),a
                            745 ;src/Renderer.c:393: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   4DDA 3E 64         [ 7]  746 	ld	a,#0x64
   4DDC DD 96 F6      [19]  747 	sub	a, -10 (ix)
   4DDF 30 4B         [12]  748 	jr	NC,00102$
                            749 ;src/Renderer.c:394: ceiling_height=0;
   4DE1 DD 36 F1 00   [19]  750 	ld	-15 (ix),#0x00
                            751 ;src/Renderer.c:395: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
   4DE5 DD 7E FA      [19]  752 	ld	a,-6 (ix)
   4DE8 C6 9C         [ 7]  753 	add	a,#0x9C
   4DEA 4F            [ 4]  754 	ld	c,a
   4DEB DD 7E FB      [19]  755 	ld	a,-5 (ix)
   4DEE CE FF         [ 7]  756 	adc	a,#0xFF
   4DF0 47            [ 4]  757 	ld	b,a
   4DF1 DD 71 FC      [19]  758 	ld	-4 (ix),c
   4DF4 DD 70 FD      [19]  759 	ld	-3 (ix),b
   4DF7 CB 78         [ 8]  760 	bit	7, b
   4DF9 28 10         [12]  761 	jr	Z,00111$
   4DFB DD 7E FA      [19]  762 	ld	a,-6 (ix)
   4DFE C6 9D         [ 7]  763 	add	a, #0x9D
   4E00 DD 77 FC      [19]  764 	ld	-4 (ix),a
   4E03 DD 7E FB      [19]  765 	ld	a,-5 (ix)
   4E06 CE FF         [ 7]  766 	adc	a, #0xFF
   4E08 DD 77 FD      [19]  767 	ld	-3 (ix),a
   4E0B                     768 00111$:
   4E0B DD 4E FC      [19]  769 	ld	c,-4 (ix)
   4E0E DD 46 FD      [19]  770 	ld	b,-3 (ix)
   4E11 CB 28         [ 8]  771 	sra	b
   4E13 CB 19         [ 8]  772 	rr	c
   4E15 DD 6E F2      [19]  773 	ld	l,-14 (ix)
   4E18 DD 66 F3      [19]  774 	ld	h,-13 (ix)
   4E1B E5            [11]  775 	push	hl
   4E1C C5            [11]  776 	push	bc
   4E1D CD 2A 75      [17]  777 	call	__mulint
   4E20 F1            [10]  778 	pop	af
   4E21 F1            [10]  779 	pop	af
   4E22 DD 75 F4      [19]  780 	ld	-12 (ix),l
   4E25 DD 74 F5      [19]  781 	ld	-11 (ix),h
                            782 ;src/Renderer.c:396: j=SCREEN_TEXTURE_HEIGHT;
   4E28 DD 36 F6 64   [19]  783 	ld	-10 (ix),#0x64
   4E2C                     784 00102$:
                            785 ;src/Renderer.c:399: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
   4E2C DD 4E F1      [19]  786 	ld	c,-15 (ix)
   4E2F 06 00         [ 7]  787 	ld	b,#0x00
   4E31 69            [ 4]  788 	ld	l, c
   4E32 60            [ 4]  789 	ld	h, b
   4E33 29            [11]  790 	add	hl, hl
   4E34 29            [11]  791 	add	hl, hl
   4E35 09            [11]  792 	add	hl, bc
   4E36 29            [11]  793 	add	hl, hl
   4E37 29            [11]  794 	add	hl, hl
   4E38 29            [11]  795 	add	hl, hl
   4E39 DD 7E FE      [19]  796 	ld	a,-2 (ix)
   4E3C 85            [ 4]  797 	add	a, l
   4E3D 4F            [ 4]  798 	ld	c,a
   4E3E DD 7E FF      [19]  799 	ld	a,-1 (ix)
   4E41 8C            [ 4]  800 	adc	a, h
   4E42 47            [ 4]  801 	ld	b,a
                            802 ;src/Renderer.c:401: for(j;j;--j){
   4E43 DD 7E F7      [19]  803 	ld	a,-9 (ix)
   4E46 2F            [ 4]  804 	cpl
   4E47 DD 77 FC      [19]  805 	ld	-4 (ix),a
   4E4A DD 56 F6      [19]  806 	ld	d,-10 (ix)
   4E4D                     807 00107$:
   4E4D 7A            [ 4]  808 	ld	a,d
   4E4E B7            [ 4]  809 	or	a, a
   4E4F 28 39         [12]  810 	jr	Z,00109$
                            811 ;src/Renderer.c:403: w_color = *(texture+(wall_texture_line/256));
   4E51 DD 7E F5      [19]  812 	ld	a, -11 (ix)
   4E54 26 00         [ 7]  813 	ld	h, #0x00
   4E56 DD 86 F8      [19]  814 	add	a, -8 (ix)
   4E59 6F            [ 4]  815 	ld	l,a
   4E5A 7C            [ 4]  816 	ld	a,h
   4E5B DD 8E F9      [19]  817 	adc	a, -7 (ix)
   4E5E 67            [ 4]  818 	ld	h,a
   4E5F 5E            [ 7]  819 	ld	e,(hl)
                            820 ;src/Renderer.c:405: if(w_color){
   4E60 7B            [ 4]  821 	ld	a,e
   4E61 B7            [ 4]  822 	or	a, a
   4E62 28 0B         [12]  823 	jr	Z,00104$
                            824 ;src/Renderer.c:407: val =  ((*pvmem)&(~pixMask));
   4E64 0A            [ 7]  825 	ld	a,(bc)
   4E65 DD A6 FC      [19]  826 	and	a, -4 (ix)
   4E68 6F            [ 4]  827 	ld	l,a
                            828 ;src/Renderer.c:409: w_color = (w_color&pixMask);
   4E69 7B            [ 4]  829 	ld	a,e
   4E6A DD A6 F7      [19]  830 	and	a, -9 (ix)
                            831 ;src/Renderer.c:411: *pvmem = val|w_color;
   4E6D B5            [ 4]  832 	or	a, l
   4E6E 02            [ 7]  833 	ld	(bc),a
   4E6F                     834 00104$:
                            835 ;src/Renderer.c:415: wall_texture_line += wall_texture_line_add;
   4E6F DD 7E F4      [19]  836 	ld	a,-12 (ix)
   4E72 DD 86 F2      [19]  837 	add	a, -14 (ix)
   4E75 DD 77 F4      [19]  838 	ld	-12 (ix),a
   4E78 DD 7E F5      [19]  839 	ld	a,-11 (ix)
   4E7B DD 8E F3      [19]  840 	adc	a, -13 (ix)
   4E7E DD 77 F5      [19]  841 	ld	-11 (ix),a
                            842 ;src/Renderer.c:417: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   4E81 21 28 00      [10]  843 	ld	hl,#0x0028
   4E84 09            [11]  844 	add	hl,bc
   4E85 4D            [ 4]  845 	ld	c,l
   4E86 44            [ 4]  846 	ld	b,h
                            847 ;src/Renderer.c:401: for(j;j;--j){
   4E87 15            [ 4]  848 	dec	d
   4E88 18 C3         [12]  849 	jr	00107$
   4E8A                     850 00109$:
   4E8A DD F9         [10]  851 	ld	sp, ix
   4E8C DD E1         [14]  852 	pop	ix
   4E8E C9            [10]  853 	ret
                            854 ;src/Renderer.c:421: void render_draw_to_buffer(){//TODO Optimize
                            855 ;	---------------------------------
                            856 ; Function render_draw_to_buffer
                            857 ; ---------------------------------
   4E8F                     858 _render_draw_to_buffer::
   4E8F DD E5         [15]  859 	push	ix
   4E91 DD 21 00 00   [14]  860 	ld	ix,#0
   4E95 DD 39         [15]  861 	add	ix,sp
   4E97 21 C6 FF      [10]  862 	ld	hl,#-58
   4E9A 39            [11]  863 	add	hl,sp
   4E9B F9            [ 6]  864 	ld	sp,hl
                            865 ;src/Renderer.c:431: u8 zHeight = 5;
   4E9C DD 36 D5 05   [19]  866 	ld	-43 (ix),#0x05
                            867 ;src/Renderer.c:437: u8 offsetDiff = 16;
   4EA0 DD 36 CA 10   [19]  868 	ld	-54 (ix),#0x10
                            869 ;src/Renderer.c:442: u8 lineStart = 0;
   4EA4 DD 36 CF 00   [19]  870 	ld	-49 (ix),#0x00
                            871 ;src/Renderer.c:444: u8 lateralWallWidth=0;
   4EA8 DD 36 D3 00   [19]  872 	ld	-45 (ix),#0x00
                            873 ;src/Renderer.c:456: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   4EAC 21 8D 4B      [10]  874 	ld	hl, #_g_colors + 7
   4EAF 46            [ 7]  875 	ld	b,(hl)
   4EB0 21 A8 07      [10]  876 	ld	hl,#0x07A8
   4EB3 E5            [11]  877 	push	hl
   4EB4 C5            [11]  878 	push	bc
   4EB5 33            [ 6]  879 	inc	sp
   4EB6 21 40 29      [10]  880 	ld	hl,#0x2940
   4EB9 E5            [11]  881 	push	hl
   4EBA CD C1 75      [17]  882 	call	_cpct_memset
                            883 ;src/Renderer.c:457: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
   4EBD 21 87 4B      [10]  884 	ld	hl, #_g_colors + 1
   4EC0 46            [ 7]  885 	ld	b,(hl)
   4EC1 21 50 00      [10]  886 	ld	hl,#0x0050
   4EC4 E5            [11]  887 	push	hl
   4EC5 C5            [11]  888 	push	bc
   4EC6 33            [ 6]  889 	inc	sp
   4EC7 21 E8 30      [10]  890 	ld	hl,#0x30E8
   4ECA E5            [11]  891 	push	hl
   4ECB CD C1 75      [17]  892 	call	_cpct_memset
                            893 ;src/Renderer.c:458: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   4ECE 21 8E 4B      [10]  894 	ld	hl, #_g_colors + 8
   4ED1 46            [ 7]  895 	ld	b,(hl)
   4ED2 21 A8 07      [10]  896 	ld	hl,#0x07A8
   4ED5 E5            [11]  897 	push	hl
   4ED6 C5            [11]  898 	push	bc
   4ED7 33            [ 6]  899 	inc	sp
   4ED8 21 38 31      [10]  900 	ld	hl,#0x3138
   4EDB E5            [11]  901 	push	hl
   4EDC CD C1 75      [17]  902 	call	_cpct_memset
                            903 ;src/Renderer.c:460: calculate_cells_in_view();
   4EDF CD C7 49      [17]  904 	call	_calculate_cells_in_view
                            905 ;src/Renderer.c:478: currentCellID = cells_in_view_array[lineStart + 1];
   4EE2 2A 99 4B      [16]  906 	ld	hl,(_cells_in_view_array)
   4EE5 DD 75 E0      [19]  907 	ld	-32 (ix),l
   4EE8 DD 74 E1      [19]  908 	ld	-31 (ix),h
                            909 ;src/Renderer.c:462: if(g_texturedWalls){
   4EEB 3A 98 4B      [13]  910 	ld	a,(#_g_texturedWalls + 0)
   4EEE B7            [ 4]  911 	or	a, a
   4EEF CA 37 54      [10]  912 	jp	Z,00358$
                            913 ;src/Renderer.c:464: do{
   4EF2 DD 36 C8 06   [19]  914 	ld	-56 (ix),#0x06
   4EF6                     915 00175$:
                            916 ;src/Renderer.c:466: --z;
   4EF6 DD 35 C8      [23]  917 	dec	-56 (ix)
                            918 ;src/Renderer.c:470: xCellCount = (z) ? (zHeight >> 1) : 0;
   4EF9 DD 7E D5      [19]  919 	ld	a,-43 (ix)
   4EFC CB 3F         [ 8]  920 	srl	a
   4EFE DD 77 E6      [19]  921 	ld	-26 (ix),a
   4F01 DD 7E C8      [19]  922 	ld	a,-56 (ix)
   4F04 B7            [ 4]  923 	or	a, a
   4F05 28 05         [12]  924 	jr	Z,00262$
   4F07 DD 4E E6      [19]  925 	ld	c,-26 (ix)
   4F0A 18 02         [12]  926 	jr	00263$
   4F0C                     927 00262$:
   4F0C 0E 00         [ 7]  928 	ld	c,#0x00
   4F0E                     929 00263$:
   4F0E DD 71 E8      [19]  930 	ld	-24 (ix),c
                            931 ;src/Renderer.c:471: lateralWallSlope=0;
   4F11 DD 36 EC 00   [19]  932 	ld	-20 (ix),#0x00
                            933 ;src/Renderer.c:472: lateralWallSlopeCounter=0;
   4F15 DD 36 F9 00   [19]  934 	ld	-7 (ix),#0x00
                            935 ;src/Renderer.c:473: xHeight=0;
   4F19 DD 36 D7 00   [19]  936 	ld	-41 (ix),#0x00
                            937 ;src/Renderer.c:475: lateralWallCounter = 0;
   4F1D DD 36 E9 00   [19]  938 	ld	-23 (ix),#0x00
                            939 ;src/Renderer.c:477: newCell=1;
   4F21 DD 36 F6 01   [19]  940 	ld	-10 (ix),#0x01
                            941 ;src/Renderer.c:478: currentCellID = cells_in_view_array[lineStart + 1];
   4F25 DD 7E CF      [19]  942 	ld	a,-49 (ix)
   4F28 DD 77 FE      [19]  943 	ld	-2 (ix),a
   4F2B DD 36 FF 00   [19]  944 	ld	-1 (ix),#0x00
   4F2F DD 4E FE      [19]  945 	ld	c,-2 (ix)
   4F32 DD 46 FF      [19]  946 	ld	b,-1 (ix)
   4F35 03            [ 6]  947 	inc	bc
   4F36 DD 6E E0      [19]  948 	ld	l,-32 (ix)
   4F39 DD 66 E1      [19]  949 	ld	h,-31 (ix)
   4F3C 09            [11]  950 	add	hl,bc
   4F3D 7E            [ 7]  951 	ld	a,(hl)
   4F3E DD 77 E2      [19]  952 	ld	-30 (ix),a
                            953 ;src/Renderer.c:480: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   4F41 DD 7E E0      [19]  954 	ld	a,-32 (ix)
   4F44 DD 86 CF      [19]  955 	add	a, -49 (ix)
   4F47 6F            [ 4]  956 	ld	l,a
   4F48 DD 7E E1      [19]  957 	ld	a,-31 (ix)
   4F4B CE 00         [ 7]  958 	adc	a, #0x00
   4F4D 67            [ 4]  959 	ld	h,a
   4F4E 4E            [ 7]  960 	ld	c,(hl)
                            961 ;src/Renderer.c:481: if(lastCellWasWall&CELL_WALL_MASK){
   4F4F CB 79         [ 8]  962 	bit	7, c
   4F51 28 09         [12]  963 	jr	Z,00102$
                            964 ;src/Renderer.c:482: lastWallId=lastCellWasWall;
   4F53 DD 71 E5      [19]  965 	ld	-27 (ix),c
                            966 ;src/Renderer.c:483: lastCellWasWall=1;
   4F56 DD 36 E7 01   [19]  967 	ld	-25 (ix),#0x01
   4F5A 18 08         [12]  968 	jr	00296$
   4F5C                     969 00102$:
                            970 ;src/Renderer.c:486: lastCellWasWall=0;
   4F5C DD 36 E7 00   [19]  971 	ld	-25 (ix),#0x00
                            972 ;src/Renderer.c:487: lastWallId=CELLTYPE_FLOOR;
   4F60 DD 36 E5 00   [19]  973 	ld	-27 (ix),#0x00
                            974 ;src/Renderer.c:490: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   4F64                     975 00296$:
   4F64 DD 36 D2 00   [19]  976 	ld	-46 (ix),#0x00
   4F68 DD 36 D6 00   [19]  977 	ld	-42 (ix),#0x00
   4F6C                     978 00252$:
                            979 ;src/Renderer.c:492: if (xCellCount == zHeight)
   4F6C DD 7E D5      [19]  980 	ld	a,-43 (ix)
   4F6F DD 96 E8      [19]  981 	sub	a, -24 (ix)
   4F72 20 4B         [12]  982 	jr	NZ,00105$
                            983 ;src/Renderer.c:494: ++xCell;
   4F74 DD 34 D2      [23]  984 	inc	-46 (ix)
                            985 ;src/Renderer.c:495: xCellCount = 0;
   4F77 DD 36 E8 00   [19]  986 	ld	-24 (ix),#0x00
                            987 ;src/Renderer.c:496: newCell=1;
   4F7B DD 36 F6 01   [19]  988 	ld	-10 (ix),#0x01
                            989 ;src/Renderer.c:497: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   4F7F DD 7E D2      [19]  990 	ld	a,-46 (ix)
   4F82 DD 77 ED      [19]  991 	ld	-19 (ix),a
   4F85 DD 36 EE 00   [19]  992 	ld	-18 (ix),#0x00
   4F89 DD 7E FE      [19]  993 	ld	a,-2 (ix)
   4F8C DD 86 ED      [19]  994 	add	a, -19 (ix)
   4F8F DD 77 ED      [19]  995 	ld	-19 (ix),a
   4F92 DD 7E FF      [19]  996 	ld	a,-1 (ix)
   4F95 DD 8E EE      [19]  997 	adc	a, -18 (ix)
   4F98 DD 77 EE      [19]  998 	ld	-18 (ix),a
   4F9B DD 34 ED      [23]  999 	inc	-19 (ix)
   4F9E 20 03         [12] 1000 	jr	NZ,00608$
   4FA0 DD 34 EE      [23] 1001 	inc	-18 (ix)
   4FA3                    1002 00608$:
   4FA3 DD 7E E0      [19] 1003 	ld	a,-32 (ix)
   4FA6 DD 86 ED      [19] 1004 	add	a, -19 (ix)
   4FA9 DD 77 ED      [19] 1005 	ld	-19 (ix),a
   4FAC DD 7E E1      [19] 1006 	ld	a,-31 (ix)
   4FAF DD 8E EE      [19] 1007 	adc	a, -18 (ix)
   4FB2 DD 77 EE      [19] 1008 	ld	-18 (ix),a
   4FB5 DD 6E ED      [19] 1009 	ld	l,-19 (ix)
   4FB8 DD 66 EE      [19] 1010 	ld	h,-18 (ix)
   4FBB 7E            [ 7] 1011 	ld	a,(hl)
   4FBC DD 77 E2      [19] 1012 	ld	-30 (ix),a
   4FBF                    1013 00105$:
                           1014 ;src/Renderer.c:499: if(!(x%2)){
   4FBF DD 7E D6      [19] 1015 	ld	a,-42 (ix)
   4FC2 E6 01         [ 7] 1016 	and	a, #0x01
   4FC4 DD 77 ED      [19] 1017 	ld	-19 (ix),a
                           1018 ;src/Renderer.c:502: if (currentCellID & CELL_WALL_MASK)//Wall
   4FC7 DD 7E E2      [19] 1019 	ld	a,-30 (ix)
   4FCA E6 80         [ 7] 1020 	and	a, #0x80
   4FCC DD 77 F3      [19] 1021 	ld	-13 (ix),a
                           1022 ;src/Renderer.c:522: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   4FCF DD 7E E8      [19] 1023 	ld	a,-24 (ix)
   4FD2 DD 77 F7      [19] 1024 	ld	-9 (ix),a
   4FD5 DD 36 F8 00   [19] 1025 	ld	-8 (ix),#0x00
   4FD9 DD 7E D5      [19] 1026 	ld	a,-43 (ix)
   4FDC DD 77 FA      [19] 1027 	ld	-6 (ix),a
                           1028 ;src/Renderer.c:499: if(!(x%2)){
   4FDF DD 7E ED      [19] 1029 	ld	a,-19 (ix)
   4FE2 B7            [ 4] 1030 	or	a, a
   4FE3 C2 96 50      [10] 1031 	jp	NZ,00118$
                           1032 ;src/Renderer.c:500: if ((lateralWallCounter == 0)||newCell)
   4FE6 DD 7E E9      [19] 1033 	ld	a,-23 (ix)
   4FE9 B7            [ 4] 1034 	or	a, a
   4FEA 28 07         [12] 1035 	jr	Z,00114$
   4FEC DD 7E F6      [19] 1036 	ld	a,-10 (ix)
   4FEF B7            [ 4] 1037 	or	a, a
   4FF0 CA 96 50      [10] 1038 	jp	Z,00118$
   4FF3                    1039 00114$:
                           1040 ;src/Renderer.c:502: if (currentCellID & CELL_WALL_MASK)//Wall
   4FF3 DD 7E F3      [19] 1041 	ld	a,-13 (ix)
   4FF6 B7            [ 4] 1042 	or	a, a
   4FF7 28 22         [12] 1043 	jr	Z,00112$
                           1044 ;src/Renderer.c:504: lateralWallCounter = 0;//(zHeight - xCellCount);
   4FF9 DD 36 E9 00   [19] 1045 	ld	-23 (ix),#0x00
                           1046 ;src/Renderer.c:505: lateralWallSlope = 0;
   4FFD DD 36 EC 00   [19] 1047 	ld	-20 (ix),#0x00
                           1048 ;src/Renderer.c:506: xHeight = zHeight;
   5001 DD 7E D5      [19] 1049 	ld	a,-43 (ix)
   5004 DD 77 D7      [19] 1050 	ld	-41 (ix),a
                           1051 ;src/Renderer.c:507: color = currentCellID&0b01111111;
   5007 DD 7E E2      [19] 1052 	ld	a,-30 (ix)
   500A E6 7F         [ 7] 1053 	and	a, #0x7F
   500C DD 77 FB      [19] 1054 	ld	-5 (ix),a
                           1055 ;src/Renderer.c:508: lastCellWasWall = 1;
   500F DD 36 E7 01   [19] 1056 	ld	-25 (ix),#0x01
                           1057 ;src/Renderer.c:509: lastWallId=currentCellID;
   5013 DD 7E E2      [19] 1058 	ld	a,-30 (ix)
   5016 DD 77 E5      [19] 1059 	ld	-27 (ix),a
   5019 18 77         [12] 1060 	jr	00113$
   501B                    1061 00112$:
                           1062 ;src/Renderer.c:512: if(lateralWallCounter==0){//Lateral wall not finished
   501B DD 7E E9      [19] 1063 	ld	a,-23 (ix)
   501E B7            [ 4] 1064 	or	a, a
   501F 20 71         [12] 1065 	jr	NZ,00113$
                           1066 ;src/Renderer.c:513: if (lastCellWasWall)
   5021 DD 7E E7      [19] 1067 	ld	a,-25 (ix)
   5024 B7            [ 4] 1068 	or	a, a
   5025 28 5B         [12] 1069 	jr	Z,00107$
                           1070 ;src/Renderer.c:516: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   5027 DD 7E CA      [19] 1071 	ld	a,-54 (ix)
   502A DD 96 D2      [19] 1072 	sub	a, -46 (ix)
   502D 87            [ 4] 1073 	add	a, a
   502E 3C            [ 4] 1074 	inc	a
                           1075 ;src/Renderer.c:517: lateralWallSlopeCounter = lateralWallSlope / 2;
   502F DD 77 EC      [19] 1076 	ld	-20 (ix), a
   5032 CB 3F         [ 8] 1077 	srl	a
   5034 DD 77 F9      [19] 1078 	ld	-7 (ix),a
                           1079 ;src/Renderer.c:518: lateralWallCounter = lateralWallSlope * zHeight;
   5037 DD 5E D5      [19] 1080 	ld	e,-43 (ix)
   503A DD 66 EC      [19] 1081 	ld	h,-20 (ix)
   503D 2E 00         [ 7] 1082 	ld	l, #0x00
   503F 55            [ 4] 1083 	ld	d, l
   5040 06 08         [ 7] 1084 	ld	b, #0x08
   5042                    1085 00609$:
   5042 29            [11] 1086 	add	hl,hl
   5043 30 01         [12] 1087 	jr	NC,00610$
   5045 19            [11] 1088 	add	hl,de
   5046                    1089 00610$:
   5046 10 FA         [13] 1090 	djnz	00609$
                           1091 ;src/Renderer.c:519: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   5048 7D            [ 4] 1092 	ld	a,l
   5049 E6 FC         [ 7] 1093 	and	a, #0xFC
   504B CB C7         [ 8] 1094 	set	0, a
   504D CB 3F         [ 8] 1095 	srl	a
   504F CB 3F         [ 8] 1096 	srl	a
   5051 DD 96 E8      [19] 1097 	sub	a, -24 (ix)
                           1098 ;src/Renderer.c:520: lateralWallWidth=lateralWallCounter;
   5054 DD 77 E9      [19] 1099 	ld	-23 (ix), a
   5057 DD 77 D3      [19] 1100 	ld	-45 (ix),a
                           1101 ;src/Renderer.c:521: lastCellWasWall = 0;
   505A DD 36 E7 00   [19] 1102 	ld	-25 (ix),#0x00
                           1103 ;src/Renderer.c:522: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   505E DD 6E F7      [19] 1104 	ld	l,-9 (ix)
   5061 DD 66 F8      [19] 1105 	ld	h,-8 (ix)
   5064 29            [11] 1106 	add	hl, hl
   5065 DD 4E EC      [19] 1107 	ld	c,-20 (ix)
   5068 06 00         [ 7] 1108 	ld	b,#0x00
   506A C5            [11] 1109 	push	bc
   506B E5            [11] 1110 	push	hl
   506C CD E8 75      [17] 1111 	call	__divsint
   506F F1            [10] 1112 	pop	af
   5070 F1            [10] 1113 	pop	af
   5071 DD 7E FA      [19] 1114 	ld	a,-6 (ix)
   5074 95            [ 4] 1115 	sub	a, l
   5075 DD 77 D7      [19] 1116 	ld	-41 (ix),a
                           1117 ;src/Renderer.c:523: color = lastWallId&0b01111111;
   5078 DD 7E E5      [19] 1118 	ld	a,-27 (ix)
   507B E6 7F         [ 7] 1119 	and	a, #0x7F
   507D DD 77 FB      [19] 1120 	ld	-5 (ix),a
   5080 18 10         [12] 1121 	jr	00113$
   5082                    1122 00107$:
                           1123 ;src/Renderer.c:527: xHeight = 0;
   5082 DD 36 D7 00   [19] 1124 	ld	-41 (ix),#0x00
                           1125 ;src/Renderer.c:528: lastCellWasWall = 0;
   5086 DD 36 E7 00   [19] 1126 	ld	-25 (ix),#0x00
                           1127 ;src/Renderer.c:529: lateralWallSlope=0;
   508A DD 36 EC 00   [19] 1128 	ld	-20 (ix),#0x00
                           1129 ;src/Renderer.c:530: lastWallId=0;
   508E DD 36 E5 00   [19] 1130 	ld	-27 (ix),#0x00
   5092                    1131 00113$:
                           1132 ;src/Renderer.c:534: newCell=0;
   5092 DD 36 F6 00   [19] 1133 	ld	-10 (ix),#0x00
   5096                    1134 00118$:
                           1135 ;src/Renderer.c:537: if (lateralWallCounter > 0)
   5096 DD 7E E9      [19] 1136 	ld	a,-23 (ix)
   5099 B7            [ 4] 1137 	or	a, a
   509A 28 1E         [12] 1138 	jr	Z,00124$
                           1139 ;src/Renderer.c:540: if (lateralWallSlope != 0)
   509C DD 7E EC      [19] 1140 	ld	a,-20 (ix)
   509F B7            [ 4] 1141 	or	a, a
   50A0 28 15         [12] 1142 	jr	Z,00122$
                           1143 ;src/Renderer.c:542: if (lateralWallSlopeCounter == lateralWallSlope)
   50A2 DD 7E F9      [19] 1144 	ld	a,-7 (ix)
   50A5 DD 96 EC      [19] 1145 	sub	a, -20 (ix)
   50A8 20 0A         [12] 1146 	jr	NZ,00120$
                           1147 ;src/Renderer.c:544: lateralWallSlopeCounter = 0;
   50AA DD 36 F9 00   [19] 1148 	ld	-7 (ix),#0x00
                           1149 ;src/Renderer.c:545: xHeight -= 2;
   50AE DD 35 D7      [23] 1150 	dec	-41 (ix)
   50B1 DD 35 D7      [23] 1151 	dec	-41 (ix)
   50B4                    1152 00120$:
                           1153 ;src/Renderer.c:547: ++lateralWallSlopeCounter;
   50B4 DD 34 F9      [23] 1154 	inc	-7 (ix)
   50B7                    1155 00122$:
                           1156 ;src/Renderer.c:550: --lateralWallCounter;
   50B7 DD 35 E9      [23] 1157 	dec	-23 (ix)
   50BA                    1158 00124$:
                           1159 ;src/Renderer.c:561: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   50BA DD 7E D5      [19] 1160 	ld	a,-43 (ix)
   50BD DD 77 FC      [19] 1161 	ld	-4 (ix),a
   50C0 DD 36 FD 00   [19] 1162 	ld	-3 (ix),#0x00
                           1163 ;src/Renderer.c:553: if (!(x%2))
   50C4 DD 7E ED      [19] 1164 	ld	a,-19 (ix)
   50C7 B7            [ 4] 1165 	or	a, a
   50C8 C2 49 51      [10] 1166 	jp	NZ,00136$
                           1167 ;src/Renderer.c:563: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   50CB DD 46 D6      [19] 1168 	ld	b,-42 (ix)
   50CE CB 38         [ 8] 1169 	srl	b
                           1170 ;src/Renderer.c:561: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   50D0 DD 6E F7      [19] 1171 	ld	l,-9 (ix)
   50D3 DD 66 F8      [19] 1172 	ld	h,-8 (ix)
   50D6 29            [11] 1173 	add	hl, hl
   50D7 29            [11] 1174 	add	hl, hl
   50D8 29            [11] 1175 	add	hl, hl
   50D9 29            [11] 1176 	add	hl, hl
   50DA 29            [11] 1177 	add	hl, hl
   50DB C5            [11] 1178 	push	bc
   50DC DD 5E FC      [19] 1179 	ld	e,-4 (ix)
   50DF DD 56 FD      [19] 1180 	ld	d,-3 (ix)
   50E2 D5            [11] 1181 	push	de
   50E3 E5            [11] 1182 	push	hl
   50E4 CD E8 75      [17] 1183 	call	__divsint
   50E7 F1            [10] 1184 	pop	af
   50E8 F1            [10] 1185 	pop	af
   50E9 C1            [10] 1186 	pop	bc
   50EA 4D            [ 4] 1187 	ld	c,l
                           1188 ;src/Renderer.c:555: if(xHeight > 0){
   50EB DD 7E D7      [19] 1189 	ld	a,-41 (ix)
   50EE B7            [ 4] 1190 	or	a, a
   50EF 28 3A         [12] 1191 	jr	Z,00129$
                           1192 ;src/Renderer.c:556: if (lateralWallCounter > 0)
   50F1 DD 7E E9      [19] 1193 	ld	a,-23 (ix)
   50F4 B7            [ 4] 1194 	or	a, a
   50F5 28 21         [12] 1195 	jr	Z,00126$
                           1196 ;src/Renderer.c:558: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   50F7 DD 5E D3      [19] 1197 	ld	e,-45 (ix)
   50FA 16 00         [ 7] 1198 	ld	d,#0x00
   50FC DD 6E E9      [19] 1199 	ld	l,-23 (ix)
   50FF 26 00         [ 7] 1200 	ld	h,#0x00
   5101 7B            [ 4] 1201 	ld	a,e
   5102 95            [ 4] 1202 	sub	a, l
   5103 6F            [ 4] 1203 	ld	l,a
   5104 7A            [ 4] 1204 	ld	a,d
   5105 9C            [ 4] 1205 	sbc	a, h
   5106 67            [ 4] 1206 	ld	h,a
   5107 29            [11] 1207 	add	hl, hl
   5108 29            [11] 1208 	add	hl, hl
   5109 29            [11] 1209 	add	hl, hl
   510A 29            [11] 1210 	add	hl, hl
   510B 29            [11] 1211 	add	hl, hl
   510C C5            [11] 1212 	push	bc
   510D D5            [11] 1213 	push	de
   510E E5            [11] 1214 	push	hl
   510F CD E8 75      [17] 1215 	call	__divsint
   5112 F1            [10] 1216 	pop	af
   5113 F1            [10] 1217 	pop	af
   5114 C1            [10] 1218 	pop	bc
   5115 55            [ 4] 1219 	ld	d,l
   5116 18 01         [12] 1220 	jr	00127$
   5118                    1221 00126$:
                           1222 ;src/Renderer.c:561: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   5118 51            [ 4] 1223 	ld	d,c
   5119                    1224 00127$:
                           1225 ;src/Renderer.c:563: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   5119 C5            [11] 1226 	push	bc
   511A D5            [11] 1227 	push	de
   511B 33            [ 6] 1228 	inc	sp
   511C DD 66 FB      [19] 1229 	ld	h,-5 (ix)
   511F DD 6E D7      [19] 1230 	ld	l,-41 (ix)
   5122 E5            [11] 1231 	push	hl
   5123 C5            [11] 1232 	push	bc
   5124 33            [ 6] 1233 	inc	sp
   5125 CD 57 4D      [17] 1234 	call	_draw_column_to_buffer
   5128 F1            [10] 1235 	pop	af
   5129 F1            [10] 1236 	pop	af
   512A C1            [10] 1237 	pop	bc
   512B                    1238 00129$:
                           1239 ;src/Renderer.c:565: if(!(currentCellID&CELL_WALL_MASK)){
   512B DD 7E F3      [19] 1240 	ld	a,-13 (ix)
   512E B7            [ 4] 1241 	or	a, a
   512F 20 18         [12] 1242 	jr	NZ,00136$
                           1243 ;src/Renderer.c:566: if(currentCellID&CELL_ENEMY_MASK){
   5131 DD 7E E2      [19] 1244 	ld	a,-30 (ix)
   5134 E6 0F         [ 7] 1245 	and	a, #0x0F
   5136 28 11         [12] 1246 	jr	Z,00136$
                           1247 ;src/Renderer.c:567: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   5138 79            [ 4] 1248 	ld	a,c
   5139 F5            [11] 1249 	push	af
   513A 33            [ 6] 1250 	inc	sp
   513B DD 66 E2      [19] 1251 	ld	h,-30 (ix)
   513E DD 6E D5      [19] 1252 	ld	l,-43 (ix)
   5141 E5            [11] 1253 	push	hl
   5142 C5            [11] 1254 	push	bc
   5143 33            [ 6] 1255 	inc	sp
   5144 CD 19 4C      [17] 1256 	call	_draw_column_to_buffer_enemy
   5147 F1            [10] 1257 	pop	af
   5148 F1            [10] 1258 	pop	af
                           1259 ;src/Renderer.c:569: else if(currentCellID&CELL_ITEM_MASK){
   5149                    1260 00136$:
                           1261 ;src/Renderer.c:575: ++xCellCount;
   5149 DD 34 E8      [23] 1262 	inc	-24 (ix)
                           1263 ;src/Renderer.c:490: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   514C DD 34 D6      [23] 1264 	inc	-42 (ix)
                           1265 ;src/Renderer.c:478: currentCellID = cells_in_view_array[lineStart + 1];
   514F 2A 99 4B      [16] 1266 	ld	hl,(_cells_in_view_array)
   5152 DD 75 E0      [19] 1267 	ld	-32 (ix),l
   5155 DD 74 E1      [19] 1268 	ld	-31 (ix),h
                           1269 ;src/Renderer.c:490: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   5158 DD 7E D6      [19] 1270 	ld	a,-42 (ix)
   515B D6 50         [ 7] 1271 	sub	a, #0x50
   515D DA 6C 4F      [10] 1272 	jp	C,00252$
                           1273 ;src/Renderer.c:582: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   5160 DD 7E C8      [19] 1274 	ld	a,-56 (ix)
   5163 B7            [ 4] 1275 	or	a, a
   5164 28 05         [12] 1276 	jr	Z,00264$
   5166 DD 4E E6      [19] 1277 	ld	c,-26 (ix)
   5169 18 02         [12] 1278 	jr	00265$
   516B                    1279 00264$:
   516B 0E 00         [ 7] 1280 	ld	c,#0x00
   516D                    1281 00265$:
   516D DD 71 F7      [19] 1282 	ld	-9 (ix),c
                           1283 ;src/Renderer.c:583: lateralWallSlope=0;
   5170 DD 36 F3 00   [19] 1284 	ld	-13 (ix),#0x00
                           1285 ;src/Renderer.c:584: lateralWallSlopeCounter=0;
   5174 DD 36 ED 00   [19] 1286 	ld	-19 (ix),#0x00
                           1287 ;src/Renderer.c:585: xHeight=0;
   5178 DD 36 E7 00   [19] 1288 	ld	-25 (ix),#0x00
                           1289 ;src/Renderer.c:587: lateralWallCounter = 0;
   517C DD 36 E5 00   [19] 1290 	ld	-27 (ix),#0x00
                           1291 ;src/Renderer.c:588: lineEnd = lineStart + offsetDiff * 2 + 2;
   5180 DD 7E CA      [19] 1292 	ld	a,-54 (ix)
   5183 87            [ 4] 1293 	add	a, a
   5184 4F            [ 4] 1294 	ld	c,a
   5185 DD 7E CF      [19] 1295 	ld	a,-49 (ix)
   5188 81            [ 4] 1296 	add	a, c
   5189 DD 77 E2      [19] 1297 	ld	-30 (ix), a
   518C 4F            [ 4] 1298 	ld	c, a
   518D 0C            [ 4] 1299 	inc	c
   518E 0C            [ 4] 1300 	inc	c
                           1301 ;src/Renderer.c:590: newCell=1;
   518F DD 36 FE 01   [19] 1302 	ld	-2 (ix),#0x01
                           1303 ;src/Renderer.c:591: currentCellID = cells_in_view_array[lineEnd - 1];
   5193 DD 71 DE      [19] 1304 	ld	-34 (ix),c
   5196 DD 36 DF 00   [19] 1305 	ld	-33 (ix),#0x00
   519A DD 5E DE      [19] 1306 	ld	e,-34 (ix)
   519D DD 56 DF      [19] 1307 	ld	d,-33 (ix)
   51A0 1B            [ 6] 1308 	dec	de
   51A1 DD 6E E0      [19] 1309 	ld	l,-32 (ix)
   51A4 DD 66 E1      [19] 1310 	ld	h,-31 (ix)
   51A7 19            [11] 1311 	add	hl,de
   51A8 7E            [ 7] 1312 	ld	a,(hl)
   51A9 DD 77 F6      [19] 1313 	ld	-10 (ix),a
                           1314 ;src/Renderer.c:593: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   51AC DD 6E E0      [19] 1315 	ld	l,-32 (ix)
   51AF DD 66 E1      [19] 1316 	ld	h,-31 (ix)
   51B2 06 00         [ 7] 1317 	ld	b,#0x00
   51B4 09            [11] 1318 	add	hl, bc
   51B5 4E            [ 7] 1319 	ld	c,(hl)
                           1320 ;src/Renderer.c:594: if(lastCellWasWall&CELL_WALL_MASK){
   51B6 CB 79         [ 8] 1321 	bit	7, c
   51B8 28 09         [12] 1322 	jr	Z,00139$
                           1323 ;src/Renderer.c:595: lastWallId=lastCellWasWall;
   51BA DD 71 E9      [19] 1324 	ld	-23 (ix),c
                           1325 ;src/Renderer.c:596: lastCellWasWall=1;
   51BD DD 36 D7 01   [19] 1326 	ld	-41 (ix),#0x01
   51C1 18 08         [12] 1327 	jr	00315$
   51C3                    1328 00139$:
                           1329 ;src/Renderer.c:599: lastCellWasWall=0;
   51C3 DD 36 D7 00   [19] 1330 	ld	-41 (ix),#0x00
                           1331 ;src/Renderer.c:600: lastWallId=CELLTYPE_FLOOR;
   51C7 DD 36 E9 00   [19] 1332 	ld	-23 (ix),#0x00
                           1333 ;src/Renderer.c:603: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   51CB                    1334 00315$:
   51CB DD 36 D2 00   [19] 1335 	ld	-46 (ix),#0x00
   51CF DD 36 D6 9F   [19] 1336 	ld	-42 (ix),#0x9F
   51D3                    1337 00254$:
                           1338 ;src/Renderer.c:606: if (xCellCount == zHeight)
   51D3 DD 7E D5      [19] 1339 	ld	a,-43 (ix)
   51D6 DD 96 F7      [19] 1340 	sub	a, -9 (ix)
   51D9 20 50         [12] 1341 	jr	NZ,00142$
                           1342 ;src/Renderer.c:608: ++xCell;
   51DB DD 34 D2      [23] 1343 	inc	-46 (ix)
                           1344 ;src/Renderer.c:609: xCellCount = 0;
   51DE DD 36 F7 00   [19] 1345 	ld	-9 (ix),#0x00
                           1346 ;src/Renderer.c:610: newCell=1;
   51E2 DD 36 FE 01   [19] 1347 	ld	-2 (ix),#0x01
                           1348 ;src/Renderer.c:611: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   51E6 DD 7E D2      [19] 1349 	ld	a,-46 (ix)
   51E9 DD 77 EF      [19] 1350 	ld	-17 (ix),a
   51EC DD 36 F0 00   [19] 1351 	ld	-16 (ix),#0x00
   51F0 DD 7E DE      [19] 1352 	ld	a,-34 (ix)
   51F3 DD 96 EF      [19] 1353 	sub	a, -17 (ix)
   51F6 DD 77 EF      [19] 1354 	ld	-17 (ix),a
   51F9 DD 7E DF      [19] 1355 	ld	a,-33 (ix)
   51FC DD 9E F0      [19] 1356 	sbc	a, -16 (ix)
   51FF DD 77 F0      [19] 1357 	ld	-16 (ix),a
   5202 DD 6E EF      [19] 1358 	ld	l,-17 (ix)
   5205 DD 66 F0      [19] 1359 	ld	h,-16 (ix)
   5208 2B            [ 6] 1360 	dec	hl
   5209 DD 75 EF      [19] 1361 	ld	-17 (ix),l
   520C DD 74 F0      [19] 1362 	ld	-16 (ix),h
   520F DD 7E E0      [19] 1363 	ld	a,-32 (ix)
   5212 DD 86 EF      [19] 1364 	add	a, -17 (ix)
   5215 DD 77 EF      [19] 1365 	ld	-17 (ix),a
   5218 DD 7E E1      [19] 1366 	ld	a,-31 (ix)
   521B DD 8E F0      [19] 1367 	adc	a, -16 (ix)
   521E DD 77 F0      [19] 1368 	ld	-16 (ix),a
   5221 DD 6E EF      [19] 1369 	ld	l,-17 (ix)
   5224 DD 66 F0      [19] 1370 	ld	h,-16 (ix)
   5227 7E            [ 7] 1371 	ld	a,(hl)
   5228 DD 77 F6      [19] 1372 	ld	-10 (ix),a
   522B                    1373 00142$:
                           1374 ;src/Renderer.c:613: if(!(x%2)){
   522B DD 7E D6      [19] 1375 	ld	a,-42 (ix)
   522E E6 01         [ 7] 1376 	and	a, #0x01
   5230 DD 77 EF      [19] 1377 	ld	-17 (ix),a
                           1378 ;src/Renderer.c:502: if (currentCellID & CELL_WALL_MASK)//Wall
   5233 DD 7E F6      [19] 1379 	ld	a,-10 (ix)
   5236 E6 80         [ 7] 1380 	and	a, #0x80
   5238 DD 77 F9      [19] 1381 	ld	-7 (ix),a
                           1382 ;src/Renderer.c:522: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   523B DD 7E F7      [19] 1383 	ld	a,-9 (ix)
   523E DD 77 DA      [19] 1384 	ld	-38 (ix),a
   5241 DD 36 DB 00   [19] 1385 	ld	-37 (ix),#0x00
                           1386 ;src/Renderer.c:613: if(!(x%2)){
   5245 DD 7E EF      [19] 1387 	ld	a,-17 (ix)
   5248 B7            [ 4] 1388 	or	a, a
   5249 C2 1B 53      [10] 1389 	jp	NZ,00155$
                           1390 ;src/Renderer.c:614: if (lateralWallCounter == 0 || newCell)
   524C DD 7E E5      [19] 1391 	ld	a,-27 (ix)
   524F B7            [ 4] 1392 	or	a, a
   5250 28 07         [12] 1393 	jr	Z,00151$
   5252 DD 7E FE      [19] 1394 	ld	a,-2 (ix)
   5255 B7            [ 4] 1395 	or	a, a
   5256 CA 1B 53      [10] 1396 	jp	Z,00155$
   5259                    1397 00151$:
                           1398 ;src/Renderer.c:616: if ( currentCellID & CELL_WALL_MASK)//Wall
   5259 DD 7E F9      [19] 1399 	ld	a,-7 (ix)
   525C B7            [ 4] 1400 	or	a, a
   525D 28 23         [12] 1401 	jr	Z,00149$
                           1402 ;src/Renderer.c:618: lateralWallCounter = 0;
   525F DD 36 E5 00   [19] 1403 	ld	-27 (ix),#0x00
                           1404 ;src/Renderer.c:619: lateralWallSlope = 0;
   5263 DD 36 F3 00   [19] 1405 	ld	-13 (ix),#0x00
                           1406 ;src/Renderer.c:620: xHeight = zHeight;
   5267 DD 7E D5      [19] 1407 	ld	a,-43 (ix)
   526A DD 77 E7      [19] 1408 	ld	-25 (ix),a
                           1409 ;src/Renderer.c:621: color = currentCellID&0b01111111;
   526D DD 7E F6      [19] 1410 	ld	a,-10 (ix)
   5270 E6 7F         [ 7] 1411 	and	a, #0x7F
   5272 DD 77 FB      [19] 1412 	ld	-5 (ix),a
                           1413 ;src/Renderer.c:622: lastCellWasWall = 1;
   5275 DD 36 D7 01   [19] 1414 	ld	-41 (ix),#0x01
                           1415 ;src/Renderer.c:623: lastWallId=currentCellID;
   5279 DD 7E F6      [19] 1416 	ld	a,-10 (ix)
   527C DD 77 E9      [19] 1417 	ld	-23 (ix),a
   527F C3 17 53      [10] 1418 	jp	00150$
   5282                    1419 00149$:
                           1420 ;src/Renderer.c:625: else if(lateralWallCounter==0){
   5282 DD 7E E5      [19] 1421 	ld	a,-27 (ix)
   5285 B7            [ 4] 1422 	or	a, a
   5286 C2 17 53      [10] 1423 	jp	NZ,00150$
                           1424 ;src/Renderer.c:626: if (lastCellWasWall)
   5289 DD 7E D7      [19] 1425 	ld	a,-41 (ix)
   528C B7            [ 4] 1426 	or	a, a
   528D 28 78         [12] 1427 	jr	Z,00144$
                           1428 ;src/Renderer.c:629: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   528F DD 7E CA      [19] 1429 	ld	a,-54 (ix)
   5292 DD 96 D2      [19] 1430 	sub	a, -46 (ix)
   5295 87            [ 4] 1431 	add	a, a
   5296 3C            [ 4] 1432 	inc	a
                           1433 ;src/Renderer.c:630: lateralWallSlopeCounter = lateralWallSlope / 2;
   5297 DD 77 F3      [19] 1434 	ld	-13 (ix), a
   529A CB 3F         [ 8] 1435 	srl	a
   529C DD 77 ED      [19] 1436 	ld	-19 (ix),a
                           1437 ;src/Renderer.c:631: lateralWallCounter = lateralWallSlope * zHeight;
   529F DD 5E D5      [19] 1438 	ld	e,-43 (ix)
   52A2 DD 66 F3      [19] 1439 	ld	h,-13 (ix)
   52A5 2E 00         [ 7] 1440 	ld	l, #0x00
   52A7 55            [ 4] 1441 	ld	d, l
   52A8 06 08         [ 7] 1442 	ld	b, #0x08
   52AA                    1443 00617$:
   52AA 29            [11] 1444 	add	hl,hl
   52AB 30 01         [12] 1445 	jr	NC,00618$
   52AD 19            [11] 1446 	add	hl,de
   52AE                    1447 00618$:
   52AE 10 FA         [13] 1448 	djnz	00617$
                           1449 ;src/Renderer.c:632: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   52B0 4D            [ 4] 1450 	ld	c,l
   52B1 06 00         [ 7] 1451 	ld	b,#0x00
   52B3 7D            [ 4] 1452 	ld	a,l
   52B4 E6 03         [ 7] 1453 	and	a, #0x03
   52B6 5F            [ 4] 1454 	ld	e,a
   52B7 16 00         [ 7] 1455 	ld	d,#0x00
   52B9 79            [ 4] 1456 	ld	a,c
   52BA 93            [ 4] 1457 	sub	a, e
   52BB 4F            [ 4] 1458 	ld	c,a
   52BC 78            [ 4] 1459 	ld	a,b
   52BD 9A            [ 4] 1460 	sbc	a, d
   52BE 47            [ 4] 1461 	ld	b,a
   52BF 59            [ 4] 1462 	ld	e, c
   52C0 50            [ 4] 1463 	ld	d, b
   52C1 13            [ 6] 1464 	inc	de
   52C2 6B            [ 4] 1465 	ld	l, e
   52C3 62            [ 4] 1466 	ld	h, d
   52C4 CB 7A         [ 8] 1467 	bit	7, d
   52C6 28 04         [12] 1468 	jr	Z,00266$
   52C8 21 04 00      [10] 1469 	ld	hl,#0x0004
   52CB 09            [11] 1470 	add	hl,bc
   52CC                    1471 00266$:
   52CC CB 2C         [ 8] 1472 	sra	h
   52CE CB 1D         [ 8] 1473 	rr	l
   52D0 CB 2C         [ 8] 1474 	sra	h
   52D2 CB 1D         [ 8] 1475 	rr	l
   52D4 DD 4E F7      [19] 1476 	ld	c,-9 (ix)
   52D7 7D            [ 4] 1477 	ld	a,l
   52D8 91            [ 4] 1478 	sub	a, c
                           1479 ;src/Renderer.c:633: lateralWallWidth=lateralWallCounter;
   52D9 DD 77 E5      [19] 1480 	ld	-27 (ix), a
   52DC DD 77 D3      [19] 1481 	ld	-45 (ix),a
                           1482 ;src/Renderer.c:634: lastCellWasWall = 0;
   52DF DD 36 D7 00   [19] 1483 	ld	-41 (ix),#0x00
                           1484 ;src/Renderer.c:635: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   52E3 DD 6E DA      [19] 1485 	ld	l,-38 (ix)
   52E6 DD 66 DB      [19] 1486 	ld	h,-37 (ix)
   52E9 29            [11] 1487 	add	hl, hl
   52EA DD 4E F3      [19] 1488 	ld	c,-13 (ix)
   52ED 06 00         [ 7] 1489 	ld	b,#0x00
   52EF C5            [11] 1490 	push	bc
   52F0 E5            [11] 1491 	push	hl
   52F1 CD E8 75      [17] 1492 	call	__divsint
   52F4 F1            [10] 1493 	pop	af
   52F5 F1            [10] 1494 	pop	af
   52F6 DD 7E FA      [19] 1495 	ld	a,-6 (ix)
   52F9 95            [ 4] 1496 	sub	a, l
   52FA DD 77 E7      [19] 1497 	ld	-25 (ix),a
                           1498 ;src/Renderer.c:636: color = lastWallId&0b01111111;
   52FD DD 7E E9      [19] 1499 	ld	a,-23 (ix)
   5300 E6 7F         [ 7] 1500 	and	a, #0x7F
   5302 DD 77 FB      [19] 1501 	ld	-5 (ix),a
   5305 18 10         [12] 1502 	jr	00150$
   5307                    1503 00144$:
                           1504 ;src/Renderer.c:640: xHeight = 0;
   5307 DD 36 E7 00   [19] 1505 	ld	-25 (ix),#0x00
                           1506 ;src/Renderer.c:641: lastCellWasWall = 0;
   530B DD 36 D7 00   [19] 1507 	ld	-41 (ix),#0x00
                           1508 ;src/Renderer.c:642: lateralWallSlope=0;
   530F DD 36 F3 00   [19] 1509 	ld	-13 (ix),#0x00
                           1510 ;src/Renderer.c:643: lastWallId=0;
   5313 DD 36 E9 00   [19] 1511 	ld	-23 (ix),#0x00
   5317                    1512 00150$:
                           1513 ;src/Renderer.c:646: newCell=0;
   5317 DD 36 FE 00   [19] 1514 	ld	-2 (ix),#0x00
   531B                    1515 00155$:
                           1516 ;src/Renderer.c:651: if (lateralWallCounter > 0)
   531B DD 7E E5      [19] 1517 	ld	a,-27 (ix)
   531E B7            [ 4] 1518 	or	a, a
   531F 28 1E         [12] 1519 	jr	Z,00161$
                           1520 ;src/Renderer.c:654: if (lateralWallSlope != 0)
   5321 DD 7E F3      [19] 1521 	ld	a,-13 (ix)
   5324 B7            [ 4] 1522 	or	a, a
   5325 28 15         [12] 1523 	jr	Z,00159$
                           1524 ;src/Renderer.c:656: if (lateralWallSlopeCounter == lateralWallSlope)
   5327 DD 7E F3      [19] 1525 	ld	a,-13 (ix)
   532A DD 96 ED      [19] 1526 	sub	a, -19 (ix)
   532D 20 0A         [12] 1527 	jr	NZ,00157$
                           1528 ;src/Renderer.c:658: lateralWallSlopeCounter = 0;
   532F DD 36 ED 00   [19] 1529 	ld	-19 (ix),#0x00
                           1530 ;src/Renderer.c:659: xHeight -= 2;
   5333 DD 35 E7      [23] 1531 	dec	-25 (ix)
   5336 DD 35 E7      [23] 1532 	dec	-25 (ix)
   5339                    1533 00157$:
                           1534 ;src/Renderer.c:661: ++lateralWallSlopeCounter;
   5339 DD 34 ED      [23] 1535 	inc	-19 (ix)
   533C                    1536 00159$:
                           1537 ;src/Renderer.c:663: --lateralWallCounter;
   533C DD 35 E5      [23] 1538 	dec	-27 (ix)
   533F                    1539 00161$:
                           1540 ;src/Renderer.c:667: if (!(x%2))
   533F DD 7E EF      [19] 1541 	ld	a,-17 (ix)
   5342 B7            [ 4] 1542 	or	a, a
   5343 C2 06 54      [10] 1543 	jp	NZ,00173$
                           1544 ;src/Renderer.c:680: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   5346 DD 7E D6      [19] 1545 	ld	a,-42 (ix)
   5349 CB 3F         [ 8] 1546 	srl	a
   534B DD 77 EF      [19] 1547 	ld	-17 (ix),a
                           1548 ;src/Renderer.c:677: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   534E DD 7E FC      [19] 1549 	ld	a,-4 (ix)
   5351 DD 96 DA      [19] 1550 	sub	a, -38 (ix)
   5354 DD 77 DA      [19] 1551 	ld	-38 (ix),a
   5357 DD 7E FD      [19] 1552 	ld	a,-3 (ix)
   535A DD 9E DB      [19] 1553 	sbc	a, -37 (ix)
   535D DD 77 DB      [19] 1554 	ld	-37 (ix),a
   5360 3E 06         [ 7] 1555 	ld	a,#0x05+1
   5362 18 08         [12] 1556 	jr	00622$
   5364                    1557 00621$:
   5364 DD CB DA 26   [23] 1558 	sla	-38 (ix)
   5368 DD CB DB 16   [23] 1559 	rl	-37 (ix)
   536C                    1560 00622$:
   536C 3D            [ 4] 1561 	dec	a
   536D 20 F5         [12] 1562 	jr	NZ,00621$
   536F DD 6E FC      [19] 1563 	ld	l,-4 (ix)
   5372 DD 66 FD      [19] 1564 	ld	h,-3 (ix)
   5375 E5            [11] 1565 	push	hl
   5376 DD 6E DA      [19] 1566 	ld	l,-38 (ix)
   5379 DD 66 DB      [19] 1567 	ld	h,-37 (ix)
   537C E5            [11] 1568 	push	hl
   537D CD E8 75      [17] 1569 	call	__divsint
   5380 F1            [10] 1570 	pop	af
   5381 F1            [10] 1571 	pop	af
   5382 DD 74 DB      [19] 1572 	ld	-37 (ix),h
   5385 DD 75 DA      [19] 1573 	ld	-38 (ix), l
   5388 DD 75 DA      [19] 1574 	ld	-38 (ix), l
                           1575 ;src/Renderer.c:670: if(xHeight > 0){
   538B DD 7E E7      [19] 1576 	ld	a,-25 (ix)
   538E B7            [ 4] 1577 	or	a, a
   538F 28 55         [12] 1578 	jr	Z,00166$
                           1579 ;src/Renderer.c:672: if (lateralWallCounter > 0)
   5391 DD 7E E5      [19] 1580 	ld	a,-27 (ix)
   5394 B7            [ 4] 1581 	or	a, a
   5395 28 39         [12] 1582 	jr	Z,00163$
                           1583 ;src/Renderer.c:674: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   5397 DD 7E E5      [19] 1584 	ld	a,-27 (ix)
   539A DD 77 E3      [19] 1585 	ld	-29 (ix),a
   539D DD 36 E4 00   [19] 1586 	ld	-28 (ix),#0x00
   53A1 3E 06         [ 7] 1587 	ld	a,#0x05+1
   53A3 18 08         [12] 1588 	jr	00624$
   53A5                    1589 00623$:
   53A5 DD CB E3 26   [23] 1590 	sla	-29 (ix)
   53A9 DD CB E4 16   [23] 1591 	rl	-28 (ix)
   53AD                    1592 00624$:
   53AD 3D            [ 4] 1593 	dec	a
   53AE 20 F5         [12] 1594 	jr	NZ,00623$
   53B0 DD 7E D3      [19] 1595 	ld	a,-45 (ix)
   53B3 DD 77 F1      [19] 1596 	ld	-15 (ix),a
   53B6 DD 36 F2 00   [19] 1597 	ld	-14 (ix),#0x00
   53BA DD 6E F1      [19] 1598 	ld	l,-15 (ix)
   53BD DD 66 F2      [19] 1599 	ld	h,-14 (ix)
   53C0 E5            [11] 1600 	push	hl
   53C1 DD 6E E3      [19] 1601 	ld	l,-29 (ix)
   53C4 DD 66 E4      [19] 1602 	ld	h,-28 (ix)
   53C7 E5            [11] 1603 	push	hl
   53C8 CD E8 75      [17] 1604 	call	__divsint
   53CB F1            [10] 1605 	pop	af
   53CC F1            [10] 1606 	pop	af
   53CD 45            [ 4] 1607 	ld	b,l
   53CE 18 03         [12] 1608 	jr	00164$
   53D0                    1609 00163$:
                           1610 ;src/Renderer.c:677: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   53D0 DD 46 DA      [19] 1611 	ld	b,-38 (ix)
   53D3                    1612 00164$:
                           1613 ;src/Renderer.c:680: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   53D3 C5            [11] 1614 	push	bc
   53D4 33            [ 6] 1615 	inc	sp
   53D5 DD 66 FB      [19] 1616 	ld	h,-5 (ix)
   53D8 DD 6E E7      [19] 1617 	ld	l,-25 (ix)
   53DB E5            [11] 1618 	push	hl
   53DC DD 7E EF      [19] 1619 	ld	a,-17 (ix)
   53DF F5            [11] 1620 	push	af
   53E0 33            [ 6] 1621 	inc	sp
   53E1 CD 57 4D      [17] 1622 	call	_draw_column_to_buffer
   53E4 F1            [10] 1623 	pop	af
   53E5 F1            [10] 1624 	pop	af
   53E6                    1625 00166$:
                           1626 ;src/Renderer.c:683: if(!(currentCellID&CELL_WALL_MASK)){
   53E6 DD 7E F9      [19] 1627 	ld	a,-7 (ix)
   53E9 B7            [ 4] 1628 	or	a, a
   53EA 20 1A         [12] 1629 	jr	NZ,00173$
                           1630 ;src/Renderer.c:684: if(currentCellID&CELL_ENEMY_MASK){
   53EC DD 7E F6      [19] 1631 	ld	a,-10 (ix)
   53EF E6 0F         [ 7] 1632 	and	a, #0x0F
   53F1 28 13         [12] 1633 	jr	Z,00173$
                           1634 ;src/Renderer.c:685: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   53F3 DD 66 DA      [19] 1635 	ld	h,-38 (ix)
   53F6 DD 6E F6      [19] 1636 	ld	l,-10 (ix)
   53F9 E5            [11] 1637 	push	hl
   53FA DD 66 D5      [19] 1638 	ld	h,-43 (ix)
   53FD DD 6E EF      [19] 1639 	ld	l,-17 (ix)
   5400 E5            [11] 1640 	push	hl
   5401 CD 19 4C      [17] 1641 	call	_draw_column_to_buffer_enemy
   5404 F1            [10] 1642 	pop	af
   5405 F1            [10] 1643 	pop	af
                           1644 ;src/Renderer.c:687: else if(currentCellID&CELL_ITEM_MASK){
   5406                    1645 00173$:
                           1646 ;src/Renderer.c:692: ++xCellCount;
   5406 DD 34 F7      [23] 1647 	inc	-9 (ix)
                           1648 ;src/Renderer.c:603: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   5409 DD 35 D6      [23] 1649 	dec	-42 (ix)
                           1650 ;src/Renderer.c:478: currentCellID = cells_in_view_array[lineStart + 1];
   540C 2A 99 4B      [16] 1651 	ld	hl,(_cells_in_view_array)
   540F DD 75 E0      [19] 1652 	ld	-32 (ix),l
   5412 DD 74 E1      [19] 1653 	ld	-31 (ix),h
                           1654 ;src/Renderer.c:603: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   5415 DD 7E D6      [19] 1655 	ld	a,-42 (ix)
   5418 D6 50         [ 7] 1656 	sub	a, #0x50
   541A D2 D3 51      [10] 1657 	jp	NC,00254$
                           1658 ;src/Renderer.c:699: lineStart = lineStart + (offsetDiff * 2) + 3;
   541D DD 7E E2      [19] 1659 	ld	a,-30 (ix)
   5420 C6 03         [ 7] 1660 	add	a, #0x03
   5422 DD 77 CF      [19] 1661 	ld	-49 (ix),a
                           1662 ;src/Renderer.c:700: zHeight += zHeight;
   5425 DD CB D5 26   [23] 1663 	sla	-43 (ix)
                           1664 ;src/Renderer.c:701: offsetDiff = offsetDiff >> 1;
   5429 DD CB CA 3E   [23] 1665 	srl	-54 (ix)
                           1666 ;src/Renderer.c:703: }while(z);
   542D DD 7E C8      [19] 1667 	ld	a,-56 (ix)
   5430 B7            [ 4] 1668 	or	a, a
   5431 C2 F6 4E      [10] 1669 	jp	NZ,00175$
   5434 C3 E4 59      [10] 1670 	jp	00260$
                           1671 ;src/Renderer.c:708: do{
   5437                    1672 00358$:
   5437 DD 36 C8 06   [19] 1673 	ld	-56 (ix),#0x06
   543B                    1674 00246$:
                           1675 ;src/Renderer.c:710: --z;
   543B DD 35 C8      [23] 1676 	dec	-56 (ix)
                           1677 ;src/Renderer.c:470: xCellCount = (z) ? (zHeight >> 1) : 0;
   543E DD 7E D5      [19] 1678 	ld	a,-43 (ix)
   5441 CB 3F         [ 8] 1679 	srl	a
   5443 DD 77 F1      [19] 1680 	ld	-15 (ix),a
                           1681 ;src/Renderer.c:714: xCellCount = (z) ? (zHeight >> 1) : 0;
   5446 DD 7E C8      [19] 1682 	ld	a,-56 (ix)
   5449 B7            [ 4] 1683 	or	a, a
   544A 28 05         [12] 1684 	jr	Z,00267$
   544C DD 4E F1      [19] 1685 	ld	c,-15 (ix)
   544F 18 02         [12] 1686 	jr	00268$
   5451                    1687 00267$:
   5451 0E 00         [ 7] 1688 	ld	c,#0x00
   5453                    1689 00268$:
   5453 DD 71 C9      [19] 1690 	ld	-55 (ix),c
                           1691 ;src/Renderer.c:715: lateralWallSlope=0;
   5456 DD 36 D4 00   [19] 1692 	ld	-44 (ix),#0x00
                           1693 ;src/Renderer.c:716: lateralWallSlopeCounter=0;
   545A DD 36 C6 00   [19] 1694 	ld	-58 (ix),#0x00
                           1695 ;src/Renderer.c:717: xHeight=0;
   545E DD 36 D1 00   [19] 1696 	ld	-47 (ix),#0x00
                           1697 ;src/Renderer.c:719: lateralWallCounter = 0;
   5462 DD 36 E3 00   [19] 1698 	ld	-29 (ix),#0x00
                           1699 ;src/Renderer.c:721: newCell=1;
   5466 DD 36 CC 01   [19] 1700 	ld	-52 (ix),#0x01
                           1701 ;src/Renderer.c:478: currentCellID = cells_in_view_array[lineStart + 1];
   546A DD 7E CF      [19] 1702 	ld	a,-49 (ix)
   546D DD 77 DA      [19] 1703 	ld	-38 (ix),a
   5470 DD 36 DB 00   [19] 1704 	ld	-37 (ix),#0x00
                           1705 ;src/Renderer.c:722: currentCellID = cells_in_view_array[lineStart + 1];
   5474 DD 4E DA      [19] 1706 	ld	c,-38 (ix)
   5477 DD 46 DB      [19] 1707 	ld	b,-37 (ix)
   547A 03            [ 6] 1708 	inc	bc
   547B DD 6E E0      [19] 1709 	ld	l,-32 (ix)
   547E DD 66 E1      [19] 1710 	ld	h,-31 (ix)
   5481 09            [11] 1711 	add	hl,bc
   5482 7E            [ 7] 1712 	ld	a,(hl)
   5483 DD 77 CB      [19] 1713 	ld	-53 (ix),a
                           1714 ;src/Renderer.c:724: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   5486 DD 7E E0      [19] 1715 	ld	a,-32 (ix)
   5489 DD 86 CF      [19] 1716 	add	a, -49 (ix)
   548C 6F            [ 4] 1717 	ld	l,a
   548D DD 7E E1      [19] 1718 	ld	a,-31 (ix)
   5490 CE 00         [ 7] 1719 	adc	a, #0x00
   5492 67            [ 4] 1720 	ld	h,a
   5493 4E            [ 7] 1721 	ld	c,(hl)
                           1722 ;src/Renderer.c:725: if(lastCellWasWall&CELL_WALL_MASK){
   5494 CB 79         [ 8] 1723 	bit	7, c
   5496 28 09         [12] 1724 	jr	Z,00179$
                           1725 ;src/Renderer.c:726: lastWallId=lastCellWasWall;
   5498 DD 71 C7      [19] 1726 	ld	-57 (ix),c
                           1727 ;src/Renderer.c:727: lastCellWasWall=1;
   549B DD 36 EF 01   [19] 1728 	ld	-17 (ix),#0x01
   549F 18 08         [12] 1729 	jr	00336$
   54A1                    1730 00179$:
                           1731 ;src/Renderer.c:730: lastCellWasWall=0;
   54A1 DD 36 EF 00   [19] 1732 	ld	-17 (ix),#0x00
                           1733 ;src/Renderer.c:731: lastWallId=CELLTYPE_FLOOR;
   54A5 DD 36 C7 00   [19] 1734 	ld	-57 (ix),#0x00
                           1735 ;src/Renderer.c:734: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   54A9                    1736 00336$:
   54A9 DD 36 D2 00   [19] 1737 	ld	-46 (ix),#0x00
   54AD DD 36 D6 00   [19] 1738 	ld	-42 (ix),#0x00
   54B1                    1739 00256$:
                           1740 ;src/Renderer.c:736: if (xCellCount == zHeight)
   54B1 DD 7E C9      [19] 1741 	ld	a,-55 (ix)
   54B4 DD 96 D5      [19] 1742 	sub	a, -43 (ix)
   54B7 20 4B         [12] 1743 	jr	NZ,00182$
                           1744 ;src/Renderer.c:738: ++xCell;
   54B9 DD 34 D2      [23] 1745 	inc	-46 (ix)
                           1746 ;src/Renderer.c:739: xCellCount = 0;
   54BC DD 36 C9 00   [19] 1747 	ld	-55 (ix),#0x00
                           1748 ;src/Renderer.c:740: newCell=1;
   54C0 DD 36 CC 01   [19] 1749 	ld	-52 (ix),#0x01
                           1750 ;src/Renderer.c:741: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   54C4 DD 7E D2      [19] 1751 	ld	a,-46 (ix)
   54C7 DD 77 DE      [19] 1752 	ld	-34 (ix),a
   54CA DD 36 DF 00   [19] 1753 	ld	-33 (ix),#0x00
   54CE DD 7E DA      [19] 1754 	ld	a,-38 (ix)
   54D1 DD 86 DE      [19] 1755 	add	a, -34 (ix)
   54D4 DD 77 DE      [19] 1756 	ld	-34 (ix),a
   54D7 DD 7E DB      [19] 1757 	ld	a,-37 (ix)
   54DA DD 8E DF      [19] 1758 	adc	a, -33 (ix)
   54DD DD 77 DF      [19] 1759 	ld	-33 (ix),a
   54E0 DD 34 DE      [23] 1760 	inc	-34 (ix)
   54E3 20 03         [12] 1761 	jr	NZ,00629$
   54E5 DD 34 DF      [23] 1762 	inc	-33 (ix)
   54E8                    1763 00629$:
   54E8 DD 7E DE      [19] 1764 	ld	a,-34 (ix)
   54EB DD 86 E0      [19] 1765 	add	a, -32 (ix)
   54EE DD 77 DE      [19] 1766 	ld	-34 (ix),a
   54F1 DD 7E DF      [19] 1767 	ld	a,-33 (ix)
   54F4 DD 8E E1      [19] 1768 	adc	a, -31 (ix)
   54F7 DD 77 DF      [19] 1769 	ld	-33 (ix),a
   54FA DD 6E DE      [19] 1770 	ld	l,-34 (ix)
   54FD DD 66 DF      [19] 1771 	ld	h,-33 (ix)
   5500 7E            [ 7] 1772 	ld	a,(hl)
   5501 DD 77 CB      [19] 1773 	ld	-53 (ix),a
   5504                    1774 00182$:
                           1775 ;src/Renderer.c:743: if(!(x%2)){
   5504 DD 7E D6      [19] 1776 	ld	a,-42 (ix)
   5507 E6 01         [ 7] 1777 	and	a, #0x01
   5509 DD 77 DE      [19] 1778 	ld	-34 (ix),a
                           1779 ;src/Renderer.c:502: if (currentCellID & CELL_WALL_MASK)//Wall
   550C DD 7E CB      [19] 1780 	ld	a,-53 (ix)
   550F E6 80         [ 7] 1781 	and	a, #0x80
   5511 DD 77 FC      [19] 1782 	ld	-4 (ix),a
                           1783 ;src/Renderer.c:522: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   5514 DD 7E C9      [19] 1784 	ld	a,-55 (ix)
   5517 DD 77 F7      [19] 1785 	ld	-9 (ix),a
   551A DD 36 F8 00   [19] 1786 	ld	-8 (ix),#0x00
   551E DD 7E D5      [19] 1787 	ld	a,-43 (ix)
   5521 DD 77 FB      [19] 1788 	ld	-5 (ix),a
                           1789 ;src/Renderer.c:743: if(!(x%2)){
   5524 DD 7E DE      [19] 1790 	ld	a,-34 (ix)
   5527 B7            [ 4] 1791 	or	a, a
   5528 C2 20 56      [10] 1792 	jp	NZ,00195$
                           1793 ;src/Renderer.c:744: if ((lateralWallCounter == 0)||newCell)
   552B DD 7E E3      [19] 1794 	ld	a,-29 (ix)
   552E B7            [ 4] 1795 	or	a, a
   552F 28 07         [12] 1796 	jr	Z,00191$
   5531 DD 7E CC      [19] 1797 	ld	a,-52 (ix)
   5534 B7            [ 4] 1798 	or	a, a
   5535 CA 20 56      [10] 1799 	jp	Z,00195$
   5538                    1800 00191$:
                           1801 ;src/Renderer.c:746: if (currentCellID & CELL_WALL_MASK)//Wall
   5538 DD 7E FC      [19] 1802 	ld	a,-4 (ix)
   553B B7            [ 4] 1803 	or	a, a
   553C 28 2B         [12] 1804 	jr	Z,00189$
                           1805 ;src/Renderer.c:748: lateralWallCounter = 0;//(zHeight - xCellCount);
   553E DD 36 E3 00   [19] 1806 	ld	-29 (ix),#0x00
                           1807 ;src/Renderer.c:749: lateralWallSlope = 0;
   5542 DD 36 D4 00   [19] 1808 	ld	-44 (ix),#0x00
                           1809 ;src/Renderer.c:750: xHeight = zHeight;
   5546 DD 7E D5      [19] 1810 	ld	a,-43 (ix)
   5549 DD 77 D1      [19] 1811 	ld	-47 (ix),a
                           1812 ;src/Renderer.c:751: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   554C DD 7E CB      [19] 1813 	ld	a,-53 (ix)
   554F D6 80         [ 7] 1814 	sub	a, #0x80
   5551 20 04         [12] 1815 	jr	NZ,00269$
   5553 0E 0C         [ 7] 1816 	ld	c,#0x0C
   5555 18 02         [12] 1817 	jr	00270$
   5557                    1818 00269$:
   5557 0E 0E         [ 7] 1819 	ld	c,#0x0E
   5559                    1820 00270$:
   5559 DD 71 CE      [19] 1821 	ld	-50 (ix),c
                           1822 ;src/Renderer.c:752: lastCellWasWall = 1;
   555C DD 36 EF 01   [19] 1823 	ld	-17 (ix),#0x01
                           1824 ;src/Renderer.c:753: lastWallId=currentCellID;
   5560 DD 7E CB      [19] 1825 	ld	a,-53 (ix)
   5563 DD 77 C7      [19] 1826 	ld	-57 (ix),a
   5566 C3 1C 56      [10] 1827 	jp	00190$
   5569                    1828 00189$:
                           1829 ;src/Renderer.c:756: if(lateralWallCounter==0){//Lateral wall not finished
   5569 DD 7E E3      [19] 1830 	ld	a,-29 (ix)
   556C B7            [ 4] 1831 	or	a, a
   556D C2 1C 56      [10] 1832 	jp	NZ,00190$
                           1833 ;src/Renderer.c:757: if (lastCellWasWall)
   5570 DD 7E EF      [19] 1834 	ld	a,-17 (ix)
   5573 B7            [ 4] 1835 	or	a, a
   5574 CA 0C 56      [10] 1836 	jp	Z,00184$
                           1837 ;src/Renderer.c:760: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   5577 DD 7E CA      [19] 1838 	ld	a,-54 (ix)
   557A DD 96 D2      [19] 1839 	sub	a, -46 (ix)
   557D 87            [ 4] 1840 	add	a, a
   557E 3C            [ 4] 1841 	inc	a
                           1842 ;src/Renderer.c:761: lateralWallSlopeCounter = lateralWallSlope / 2;
   557F DD 77 D4      [19] 1843 	ld	-44 (ix), a
   5582 CB 3F         [ 8] 1844 	srl	a
   5584 DD 77 C6      [19] 1845 	ld	-58 (ix),a
                           1846 ;src/Renderer.c:762: lateralWallCounter = lateralWallSlope * zHeight;
   5587 DD 5E D5      [19] 1847 	ld	e,-43 (ix)
   558A DD 66 D4      [19] 1848 	ld	h,-44 (ix)
   558D 2E 00         [ 7] 1849 	ld	l, #0x00
   558F 55            [ 4] 1850 	ld	d, l
   5590 06 08         [ 7] 1851 	ld	b, #0x08
   5592                    1852 00632$:
   5592 29            [11] 1853 	add	hl,hl
   5593 30 01         [12] 1854 	jr	NC,00633$
   5595 19            [11] 1855 	add	hl,de
   5596                    1856 00633$:
   5596 10 FA         [13] 1857 	djnz	00632$
   5598 DD 75 FA      [19] 1858 	ld	-6 (ix), l
   559B 7D            [ 4] 1859 	ld	a, l
                           1860 ;src/Renderer.c:763: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   559C DD 77 D0      [19] 1861 	ld	-48 (ix), a
   559F E6 FC         [ 7] 1862 	and	a, #0xFC
   55A1 DD 77 FA      [19] 1863 	ld	-6 (ix), a
   55A4 CB C7         [ 8] 1864 	set	0, a
   55A6 DD 77 FA      [19] 1865 	ld	-6 (ix), a
   55A9 CB 3F         [ 8] 1866 	srl	a
   55AB CB 3F         [ 8] 1867 	srl	a
   55AD DD 96 C9      [19] 1868 	sub	a, -55 (ix)
   55B0 DD 77 E3      [19] 1869 	ld	-29 (ix),a
                           1870 ;src/Renderer.c:765: lastCellWasWall = 0;
   55B3 DD 36 EF 00   [19] 1871 	ld	-17 (ix),#0x00
                           1872 ;src/Renderer.c:766: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   55B7 DD 7E F7      [19] 1873 	ld	a,-9 (ix)
   55BA DD 77 ED      [19] 1874 	ld	-19 (ix),a
   55BD DD 7E F8      [19] 1875 	ld	a,-8 (ix)
   55C0 DD 77 EE      [19] 1876 	ld	-18 (ix),a
   55C3 DD CB ED 26   [23] 1877 	sla	-19 (ix)
   55C7 DD CB EE 16   [23] 1878 	rl	-18 (ix)
   55CB DD 7E D4      [19] 1879 	ld	a,-44 (ix)
   55CE DD 77 FE      [19] 1880 	ld	-2 (ix),a
   55D1 DD 36 FF 00   [19] 1881 	ld	-1 (ix),#0x00
   55D5 DD 6E FE      [19] 1882 	ld	l,-2 (ix)
   55D8 DD 66 FF      [19] 1883 	ld	h,-1 (ix)
   55DB E5            [11] 1884 	push	hl
   55DC DD 6E ED      [19] 1885 	ld	l,-19 (ix)
   55DF DD 66 EE      [19] 1886 	ld	h,-18 (ix)
   55E2 E5            [11] 1887 	push	hl
   55E3 CD E8 75      [17] 1888 	call	__divsint
   55E6 F1            [10] 1889 	pop	af
   55E7 F1            [10] 1890 	pop	af
   55E8 DD 74 EE      [19] 1891 	ld	-18 (ix),h
   55EB DD 75 ED      [19] 1892 	ld	-19 (ix), l
   55EE DD 75 FA      [19] 1893 	ld	-6 (ix), l
   55F1 DD 7E FB      [19] 1894 	ld	a,-5 (ix)
   55F4 DD 96 FA      [19] 1895 	sub	a, -6 (ix)
   55F7 DD 77 D1      [19] 1896 	ld	-47 (ix),a
                           1897 ;src/Renderer.c:767: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   55FA DD 7E C7      [19] 1898 	ld	a,-57 (ix)
   55FD D6 80         [ 7] 1899 	sub	a, #0x80
   55FF 20 04         [12] 1900 	jr	NZ,00271$
   5601 0E 0F         [ 7] 1901 	ld	c,#0x0F
   5603 18 02         [12] 1902 	jr	00272$
   5605                    1903 00271$:
   5605 0E 0D         [ 7] 1904 	ld	c,#0x0D
   5607                    1905 00272$:
   5607 DD 71 CE      [19] 1906 	ld	-50 (ix),c
   560A 18 10         [12] 1907 	jr	00190$
   560C                    1908 00184$:
                           1909 ;src/Renderer.c:771: xHeight = 0;
   560C DD 36 D1 00   [19] 1910 	ld	-47 (ix),#0x00
                           1911 ;src/Renderer.c:772: lastCellWasWall = 0;
   5610 DD 36 EF 00   [19] 1912 	ld	-17 (ix),#0x00
                           1913 ;src/Renderer.c:773: lateralWallSlope=0;
   5614 DD 36 D4 00   [19] 1914 	ld	-44 (ix),#0x00
                           1915 ;src/Renderer.c:774: lastWallId=0;
   5618 DD 36 C7 00   [19] 1916 	ld	-57 (ix),#0x00
   561C                    1917 00190$:
                           1918 ;src/Renderer.c:778: newCell=0;
   561C DD 36 CC 00   [19] 1919 	ld	-52 (ix),#0x00
   5620                    1920 00195$:
                           1921 ;src/Renderer.c:781: if (lateralWallCounter > 0)
   5620 DD 7E E3      [19] 1922 	ld	a,-29 (ix)
   5623 B7            [ 4] 1923 	or	a, a
   5624 28 1E         [12] 1924 	jr	Z,00201$
                           1925 ;src/Renderer.c:784: if (lateralWallSlope != 0)
   5626 DD 7E D4      [19] 1926 	ld	a,-44 (ix)
   5629 B7            [ 4] 1927 	or	a, a
   562A 28 15         [12] 1928 	jr	Z,00199$
                           1929 ;src/Renderer.c:786: if (lateralWallSlopeCounter == lateralWallSlope)
   562C DD 7E D4      [19] 1930 	ld	a,-44 (ix)
   562F DD 96 C6      [19] 1931 	sub	a, -58 (ix)
   5632 20 0A         [12] 1932 	jr	NZ,00197$
                           1933 ;src/Renderer.c:788: lateralWallSlopeCounter = 0;
   5634 DD 36 C6 00   [19] 1934 	ld	-58 (ix),#0x00
                           1935 ;src/Renderer.c:789: xHeight -= 2;
   5638 DD 35 D1      [23] 1936 	dec	-47 (ix)
   563B DD 35 D1      [23] 1937 	dec	-47 (ix)
   563E                    1938 00197$:
                           1939 ;src/Renderer.c:791: ++lateralWallSlopeCounter;
   563E DD 34 C6      [23] 1940 	inc	-58 (ix)
   5641                    1941 00199$:
                           1942 ;src/Renderer.c:794: --lateralWallCounter;
   5641 DD 35 E3      [23] 1943 	dec	-29 (ix)
   5644                    1944 00201$:
                           1945 ;src/Renderer.c:561: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   5644 DD 7E D5      [19] 1946 	ld	a,-43 (ix)
   5647 DD 77 ED      [19] 1947 	ld	-19 (ix),a
   564A DD 36 EE 00   [19] 1948 	ld	-18 (ix),#0x00
                           1949 ;src/Renderer.c:797: if (!(x%2))
   564E DD 7E DE      [19] 1950 	ld	a,-34 (ix)
   5651 B7            [ 4] 1951 	or	a, a
   5652 20 74         [12] 1952 	jr	NZ,00210$
                           1953 ;src/Renderer.c:800: draw_column_to_buffer_untextured(x/2, xHeight, color);
   5654 DD 7E D6      [19] 1954 	ld	a,-42 (ix)
   5657 CB 3F         [ 8] 1955 	srl	a
   5659 DD 77 DE      [19] 1956 	ld	-34 (ix),a
                           1957 ;src/Renderer.c:799: if(xHeight > 0){
   565C DD 7E D1      [19] 1958 	ld	a,-47 (ix)
   565F B7            [ 4] 1959 	or	a, a
   5660 28 11         [12] 1960 	jr	Z,00203$
                           1961 ;src/Renderer.c:800: draw_column_to_buffer_untextured(x/2, xHeight, color);
   5662 DD 66 CE      [19] 1962 	ld	h,-50 (ix)
   5665 DD 6E D1      [19] 1963 	ld	l,-47 (ix)
   5668 E5            [11] 1964 	push	hl
   5669 DD 7E DE      [19] 1965 	ld	a,-34 (ix)
   566C F5            [11] 1966 	push	af
   566D 33            [ 6] 1967 	inc	sp
   566E CD A0 4B      [17] 1968 	call	_draw_column_to_buffer_untextured
   5671 F1            [10] 1969 	pop	af
   5672 33            [ 6] 1970 	inc	sp
   5673                    1971 00203$:
                           1972 ;src/Renderer.c:803: if(!(currentCellID&CELL_WALL_MASK)){
   5673 DD 7E FC      [19] 1973 	ld	a,-4 (ix)
   5676 B7            [ 4] 1974 	or	a, a
   5677 20 4F         [12] 1975 	jr	NZ,00210$
                           1976 ;src/Renderer.c:804: if(currentCellID&CELL_ENEMY_MASK){
   5679 DD 7E CB      [19] 1977 	ld	a,-53 (ix)
   567C E6 0F         [ 7] 1978 	and	a, #0x0F
   567E 28 48         [12] 1979 	jr	Z,00210$
                           1980 ;src/Renderer.c:805: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   5680 DD 7E F7      [19] 1981 	ld	a,-9 (ix)
   5683 DD 77 FC      [19] 1982 	ld	-4 (ix),a
   5686 DD 7E F8      [19] 1983 	ld	a,-8 (ix)
   5689 DD 77 FD      [19] 1984 	ld	-3 (ix),a
   568C 3E 06         [ 7] 1985 	ld	a,#0x05+1
   568E 18 08         [12] 1986 	jr	00642$
   5690                    1987 00641$:
   5690 DD CB FC 26   [23] 1988 	sla	-4 (ix)
   5694 DD CB FD 16   [23] 1989 	rl	-3 (ix)
   5698                    1990 00642$:
   5698 3D            [ 4] 1991 	dec	a
   5699 20 F5         [12] 1992 	jr	NZ,00641$
   569B DD 6E ED      [19] 1993 	ld	l,-19 (ix)
   569E DD 66 EE      [19] 1994 	ld	h,-18 (ix)
   56A1 E5            [11] 1995 	push	hl
   56A2 DD 6E FC      [19] 1996 	ld	l,-4 (ix)
   56A5 DD 66 FD      [19] 1997 	ld	h,-3 (ix)
   56A8 E5            [11] 1998 	push	hl
   56A9 CD E8 75      [17] 1999 	call	__divsint
   56AC F1            [10] 2000 	pop	af
   56AD F1            [10] 2001 	pop	af
   56AE DD 74 FD      [19] 2002 	ld	-3 (ix),h
   56B1 DD 75 FC      [19] 2003 	ld	-4 (ix), l
   56B4 45            [ 4] 2004 	ld	b, l
   56B5 C5            [11] 2005 	push	bc
   56B6 33            [ 6] 2006 	inc	sp
   56B7 DD 66 CB      [19] 2007 	ld	h,-53 (ix)
   56BA DD 6E D5      [19] 2008 	ld	l,-43 (ix)
   56BD E5            [11] 2009 	push	hl
   56BE DD 7E DE      [19] 2010 	ld	a,-34 (ix)
   56C1 F5            [11] 2011 	push	af
   56C2 33            [ 6] 2012 	inc	sp
   56C3 CD 19 4C      [17] 2013 	call	_draw_column_to_buffer_enemy
   56C6 F1            [10] 2014 	pop	af
   56C7 F1            [10] 2015 	pop	af
                           2016 ;src/Renderer.c:807: else if(currentCellID&CELL_ITEM_MASK){
   56C8                    2017 00210$:
                           2018 ;src/Renderer.c:813: ++xCellCount;
   56C8 DD 34 C9      [23] 2019 	inc	-55 (ix)
                           2020 ;src/Renderer.c:734: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   56CB DD 34 D6      [23] 2021 	inc	-42 (ix)
                           2022 ;src/Renderer.c:478: currentCellID = cells_in_view_array[lineStart + 1];
   56CE 2A 99 4B      [16] 2023 	ld	hl,(_cells_in_view_array)
   56D1 DD 75 E0      [19] 2024 	ld	-32 (ix),l
   56D4 DD 74 E1      [19] 2025 	ld	-31 (ix),h
                           2026 ;src/Renderer.c:734: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   56D7 DD 7E D6      [19] 2027 	ld	a,-42 (ix)
   56DA D6 50         [ 7] 2028 	sub	a, #0x50
   56DC DA B1 54      [10] 2029 	jp	C,00256$
                           2030 ;src/Renderer.c:820: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   56DF DD 7E C8      [19] 2031 	ld	a,-56 (ix)
   56E2 B7            [ 4] 2032 	or	a, a
   56E3 28 08         [12] 2033 	jr	Z,00273$
   56E5 DD 7E F1      [19] 2034 	ld	a,-15 (ix)
   56E8 DD 77 F1      [19] 2035 	ld	-15 (ix),a
   56EB 18 04         [12] 2036 	jr	00274$
   56ED                    2037 00273$:
   56ED DD 36 F1 00   [19] 2038 	ld	-15 (ix),#0x00
   56F1                    2039 00274$:
   56F1 DD 7E F1      [19] 2040 	ld	a,-15 (ix)
   56F4 DD 77 F1      [19] 2041 	ld	-15 (ix),a
                           2042 ;src/Renderer.c:821: lateralWallSlope=0;
   56F7 DD 36 E3 00   [19] 2043 	ld	-29 (ix),#0x00
                           2044 ;src/Renderer.c:822: lateralWallSlopeCounter=0;
   56FB DD 36 DA 00   [19] 2045 	ld	-38 (ix),#0x00
                           2046 ;src/Renderer.c:823: xHeight=0;
   56FF DD 36 EF 00   [19] 2047 	ld	-17 (ix),#0x00
                           2048 ;src/Renderer.c:825: lateralWallCounter = 0;
   5703 DD 36 DE 00   [19] 2049 	ld	-34 (ix),#0x00
                           2050 ;src/Renderer.c:588: lineEnd = lineStart + offsetDiff * 2 + 2;
   5707 DD 7E CA      [19] 2051 	ld	a,-54 (ix)
   570A 87            [ 4] 2052 	add	a, a
   570B DD 77 FC      [19] 2053 	ld	-4 (ix),a
   570E DD 7E CF      [19] 2054 	ld	a,-49 (ix)
   5711 DD 86 FC      [19] 2055 	add	a, -4 (ix)
                           2056 ;src/Renderer.c:826: lineEnd = lineStart + offsetDiff * 2 + 2;
   5714 DD 77 FC      [19] 2057 	ld	-4 (ix), a
   5717 C6 02         [ 7] 2058 	add	a, #0x02
   5719 DD 77 CD      [19] 2059 	ld	-51 (ix),a
                           2060 ;src/Renderer.c:828: newCell=1;
   571C DD 36 FA 01   [19] 2061 	ld	-6 (ix),#0x01
                           2062 ;src/Renderer.c:591: currentCellID = cells_in_view_array[lineEnd - 1];
   5720 DD 7E CD      [19] 2063 	ld	a,-51 (ix)
   5723 DD 77 F7      [19] 2064 	ld	-9 (ix),a
   5726 DD 36 F8 00   [19] 2065 	ld	-8 (ix),#0x00
                           2066 ;src/Renderer.c:829: currentCellID = cells_in_view_array[lineEnd - 1];
   572A DD 7E F7      [19] 2067 	ld	a,-9 (ix)
   572D C6 FF         [ 7] 2068 	add	a,#0xFF
   572F DD 77 FE      [19] 2069 	ld	-2 (ix),a
   5732 DD 7E F8      [19] 2070 	ld	a,-8 (ix)
   5735 CE FF         [ 7] 2071 	adc	a,#0xFF
   5737 DD 77 FF      [19] 2072 	ld	-1 (ix),a
   573A DD 7E E0      [19] 2073 	ld	a,-32 (ix)
   573D DD 86 FE      [19] 2074 	add	a, -2 (ix)
   5740 DD 77 FE      [19] 2075 	ld	-2 (ix),a
   5743 DD 7E E1      [19] 2076 	ld	a,-31 (ix)
   5746 DD 8E FF      [19] 2077 	adc	a, -1 (ix)
   5749 DD 77 FF      [19] 2078 	ld	-1 (ix),a
   574C DD 6E FE      [19] 2079 	ld	l,-2 (ix)
   574F DD 66 FF      [19] 2080 	ld	h,-1 (ix)
   5752 7E            [ 7] 2081 	ld	a,(hl)
   5753 DD 77 F3      [19] 2082 	ld	-13 (ix),a
                           2083 ;src/Renderer.c:831: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   5756 DD 7E E0      [19] 2084 	ld	a,-32 (ix)
   5759 DD 86 CD      [19] 2085 	add	a, -51 (ix)
   575C DD 77 FE      [19] 2086 	ld	-2 (ix),a
   575F DD 7E E1      [19] 2087 	ld	a,-31 (ix)
   5762 CE 00         [ 7] 2088 	adc	a, #0x00
   5764 DD 77 FF      [19] 2089 	ld	-1 (ix),a
   5767 DD 6E FE      [19] 2090 	ld	l,-2 (ix)
   576A DD 66 FF      [19] 2091 	ld	h,-1 (ix)
   576D 7E            [ 7] 2092 	ld	a,(hl)
   576E DD 77 E7      [19] 2093 	ld	-25 (ix),a
                           2094 ;src/Renderer.c:832: if(lastCellWasWall&CELL_WALL_MASK){
   5771 DD CB E7 7E   [20] 2095 	bit	7, -25 (ix)
   5775 28 06         [12] 2096 	jr	Z,00213$
                           2097 ;src/Renderer.c:833: lastWallId=lastCellWasWall;
                           2098 ;src/Renderer.c:834: lastCellWasWall=1;
   5777 DD 36 E5 01   [19] 2099 	ld	-27 (ix),#0x01
   577B 18 08         [12] 2100 	jr	00356$
   577D                    2101 00213$:
                           2102 ;src/Renderer.c:837: lastCellWasWall=0;
   577D DD 36 E5 00   [19] 2103 	ld	-27 (ix),#0x00
                           2104 ;src/Renderer.c:838: lastWallId=CELLTYPE_FLOOR;
   5781 DD 36 E7 00   [19] 2105 	ld	-25 (ix),#0x00
                           2106 ;src/Renderer.c:841: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   5785                    2107 00356$:
   5785 DD 36 D2 00   [19] 2108 	ld	-46 (ix),#0x00
   5789 DD 36 D6 9F   [19] 2109 	ld	-42 (ix),#0x9F
   578D                    2110 00258$:
                           2111 ;src/Renderer.c:844: if (xCellCount == zHeight)
   578D DD 7E D5      [19] 2112 	ld	a,-43 (ix)
   5790 DD 96 F1      [19] 2113 	sub	a, -15 (ix)
   5793 20 50         [12] 2114 	jr	NZ,00216$
                           2115 ;src/Renderer.c:846: ++xCell;
   5795 DD 34 D2      [23] 2116 	inc	-46 (ix)
                           2117 ;src/Renderer.c:847: xCellCount = 0;
   5798 DD 36 F1 00   [19] 2118 	ld	-15 (ix),#0x00
                           2119 ;src/Renderer.c:848: newCell=1;
   579C DD 36 FA 01   [19] 2120 	ld	-6 (ix),#0x01
                           2121 ;src/Renderer.c:849: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   57A0 DD 7E D2      [19] 2122 	ld	a,-46 (ix)
   57A3 DD 77 FE      [19] 2123 	ld	-2 (ix),a
   57A6 DD 36 FF 00   [19] 2124 	ld	-1 (ix),#0x00
   57AA DD 7E F7      [19] 2125 	ld	a,-9 (ix)
   57AD DD 96 FE      [19] 2126 	sub	a, -2 (ix)
   57B0 DD 77 FE      [19] 2127 	ld	-2 (ix),a
   57B3 DD 7E F8      [19] 2128 	ld	a,-8 (ix)
   57B6 DD 9E FF      [19] 2129 	sbc	a, -1 (ix)
   57B9 DD 77 FF      [19] 2130 	ld	-1 (ix),a
   57BC DD 6E FE      [19] 2131 	ld	l,-2 (ix)
   57BF DD 66 FF      [19] 2132 	ld	h,-1 (ix)
   57C2 2B            [ 6] 2133 	dec	hl
   57C3 DD 75 FE      [19] 2134 	ld	-2 (ix),l
   57C6 DD 74 FF      [19] 2135 	ld	-1 (ix),h
   57C9 DD 7E E0      [19] 2136 	ld	a,-32 (ix)
   57CC DD 86 FE      [19] 2137 	add	a, -2 (ix)
   57CF DD 77 FE      [19] 2138 	ld	-2 (ix),a
   57D2 DD 7E E1      [19] 2139 	ld	a,-31 (ix)
   57D5 DD 8E FF      [19] 2140 	adc	a, -1 (ix)
   57D8 DD 77 FF      [19] 2141 	ld	-1 (ix),a
   57DB DD 6E FE      [19] 2142 	ld	l,-2 (ix)
   57DE DD 66 FF      [19] 2143 	ld	h,-1 (ix)
   57E1 7E            [ 7] 2144 	ld	a,(hl)
   57E2 DD 77 F3      [19] 2145 	ld	-13 (ix),a
   57E5                    2146 00216$:
                           2147 ;src/Renderer.c:851: if(!(x%2)){
   57E5 DD 7E D6      [19] 2148 	ld	a,-42 (ix)
   57E8 E6 01         [ 7] 2149 	and	a, #0x01
   57EA DD 77 E2      [19] 2150 	ld	-30 (ix),a
                           2151 ;src/Renderer.c:502: if (currentCellID & CELL_WALL_MASK)//Wall
   57ED DD 7E F3      [19] 2152 	ld	a,-13 (ix)
   57F0 E6 80         [ 7] 2153 	and	a, #0x80
   57F2 DD 77 FE      [19] 2154 	ld	-2 (ix),a
                           2155 ;src/Renderer.c:522: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   57F5 DD 7E F1      [19] 2156 	ld	a,-15 (ix)
   57F8 DD 77 F4      [19] 2157 	ld	-12 (ix),a
   57FB DD 36 F5 00   [19] 2158 	ld	-11 (ix),#0x00
                           2159 ;src/Renderer.c:851: if(!(x%2)){
   57FF DD 7E E2      [19] 2160 	ld	a,-30 (ix)
   5802 B7            [ 4] 2161 	or	a, a
   5803 C2 31 59      [10] 2162 	jp	NZ,00229$
                           2163 ;src/Renderer.c:852: if (lateralWallCounter == 0 || newCell)
   5806 DD 7E DE      [19] 2164 	ld	a,-34 (ix)
   5809 B7            [ 4] 2165 	or	a, a
   580A 28 07         [12] 2166 	jr	Z,00225$
   580C DD 7E FA      [19] 2167 	ld	a,-6 (ix)
   580F B7            [ 4] 2168 	or	a, a
   5810 CA 31 59      [10] 2169 	jp	Z,00229$
   5813                    2170 00225$:
                           2171 ;src/Renderer.c:854: if ( currentCellID & CELL_WALL_MASK)//Wall
   5813 DD 7E FE      [19] 2172 	ld	a,-2 (ix)
   5816 B7            [ 4] 2173 	or	a, a
   5817 28 32         [12] 2174 	jr	Z,00223$
                           2175 ;src/Renderer.c:856: lateralWallCounter = 0;
   5819 DD 36 DE 00   [19] 2176 	ld	-34 (ix),#0x00
                           2177 ;src/Renderer.c:857: lateralWallSlope = 0;
   581D DD 36 E3 00   [19] 2178 	ld	-29 (ix),#0x00
                           2179 ;src/Renderer.c:858: xHeight = zHeight;
   5821 DD 7E D5      [19] 2180 	ld	a,-43 (ix)
   5824 DD 77 EF      [19] 2181 	ld	-17 (ix),a
                           2182 ;src/Renderer.c:859: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   5827 DD 7E F3      [19] 2183 	ld	a,-13 (ix)
   582A D6 80         [ 7] 2184 	sub	a, #0x80
   582C 20 06         [12] 2185 	jr	NZ,00275$
   582E DD 36 F6 0C   [19] 2186 	ld	-10 (ix),#0x0C
   5832 18 04         [12] 2187 	jr	00276$
   5834                    2188 00275$:
   5834 DD 36 F6 0E   [19] 2189 	ld	-10 (ix),#0x0E
   5838                    2190 00276$:
   5838 DD 7E F6      [19] 2191 	ld	a,-10 (ix)
   583B DD 77 CE      [19] 2192 	ld	-50 (ix),a
                           2193 ;src/Renderer.c:860: lastCellWasWall = 1;
   583E DD 36 E5 01   [19] 2194 	ld	-27 (ix),#0x01
                           2195 ;src/Renderer.c:861: lastWallId=currentCellID;
   5842 DD 7E F3      [19] 2196 	ld	a,-13 (ix)
   5845 DD 77 E7      [19] 2197 	ld	-25 (ix),a
   5848 C3 2D 59      [10] 2198 	jp	00224$
   584B                    2199 00223$:
                           2200 ;src/Renderer.c:863: else if(lateralWallCounter==0){
   584B DD 7E DE      [19] 2201 	ld	a,-34 (ix)
   584E B7            [ 4] 2202 	or	a, a
   584F C2 2D 59      [10] 2203 	jp	NZ,00224$
                           2204 ;src/Renderer.c:864: if (lastCellWasWall)
   5852 DD 7E E5      [19] 2205 	ld	a,-27 (ix)
   5855 B7            [ 4] 2206 	or	a, a
   5856 CA 1D 59      [10] 2207 	jp	Z,00218$
                           2208 ;src/Renderer.c:867: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   5859 DD 7E CA      [19] 2209 	ld	a,-54 (ix)
   585C DD 96 D2      [19] 2210 	sub	a, -46 (ix)
   585F 87            [ 4] 2211 	add	a, a
   5860 3C            [ 4] 2212 	inc	a
                           2213 ;src/Renderer.c:868: lateralWallSlopeCounter = lateralWallSlope / 2;
   5861 DD 77 E3      [19] 2214 	ld	-29 (ix), a
   5864 CB 3F         [ 8] 2215 	srl	a
   5866 DD 77 DA      [19] 2216 	ld	-38 (ix),a
                           2217 ;src/Renderer.c:869: lateralWallCounter = lateralWallSlope * zHeight;
   5869 DD 5E D5      [19] 2218 	ld	e,-43 (ix)
   586C DD 66 E3      [19] 2219 	ld	h,-29 (ix)
   586F 2E 00         [ 7] 2220 	ld	l, #0x00
   5871 55            [ 4] 2221 	ld	d, l
   5872 06 08         [ 7] 2222 	ld	b, #0x08
   5874                    2223 00648$:
   5874 29            [11] 2224 	add	hl,hl
   5875 30 01         [12] 2225 	jr	NC,00649$
   5877 19            [11] 2226 	add	hl,de
   5878                    2227 00649$:
   5878 10 FA         [13] 2228 	djnz	00648$
                           2229 ;src/Renderer.c:870: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   587A DD 75 F6      [19] 2230 	ld	-10 (ix), l
   587D DD 75 EA      [19] 2231 	ld	-22 (ix), l
   5880 DD 36 EB 00   [19] 2232 	ld	-21 (ix),#0x00
   5884 DD 7E F6      [19] 2233 	ld	a,-10 (ix)
   5887 E6 03         [ 7] 2234 	and	a, #0x03
   5889 DD 77 F6      [19] 2235 	ld	-10 (ix), a
   588C DD 77 D8      [19] 2236 	ld	-40 (ix),a
   588F DD 36 D9 00   [19] 2237 	ld	-39 (ix),#0x00
   5893 DD 7E EA      [19] 2238 	ld	a,-22 (ix)
   5896 DD 96 D8      [19] 2239 	sub	a, -40 (ix)
   5899 DD 77 D8      [19] 2240 	ld	-40 (ix),a
   589C DD 7E EB      [19] 2241 	ld	a,-21 (ix)
   589F DD 9E D9      [19] 2242 	sbc	a, -39 (ix)
   58A2 DD 77 D9      [19] 2243 	ld	-39 (ix),a
   58A5 DD 7E D8      [19] 2244 	ld	a,-40 (ix)
   58A8 C6 01         [ 7] 2245 	add	a, #0x01
   58AA DD 77 EA      [19] 2246 	ld	-22 (ix),a
   58AD DD 7E D9      [19] 2247 	ld	a,-39 (ix)
   58B0 CE 00         [ 7] 2248 	adc	a, #0x00
   58B2 DD 77 EB      [19] 2249 	ld	-21 (ix),a
   58B5 DD 7E EA      [19] 2250 	ld	a,-22 (ix)
   58B8 DD 77 DC      [19] 2251 	ld	-36 (ix),a
   58BB DD 7E EB      [19] 2252 	ld	a,-21 (ix)
   58BE DD 77 DD      [19] 2253 	ld	-35 (ix),a
   58C1 DD CB EB 7E   [20] 2254 	bit	7, -21 (ix)
   58C5 28 10         [12] 2255 	jr	Z,00277$
   58C7 DD 7E D8      [19] 2256 	ld	a,-40 (ix)
   58CA C6 04         [ 7] 2257 	add	a, #0x04
   58CC DD 77 DC      [19] 2258 	ld	-36 (ix),a
   58CF DD 7E D9      [19] 2259 	ld	a,-39 (ix)
   58D2 CE 00         [ 7] 2260 	adc	a, #0x00
   58D4 DD 77 DD      [19] 2261 	ld	-35 (ix),a
   58D7                    2262 00277$:
   58D7 DD 4E DC      [19] 2263 	ld	c,-36 (ix)
   58DA DD 46 DD      [19] 2264 	ld	b,-35 (ix)
   58DD CB 28         [ 8] 2265 	sra	b
   58DF CB 19         [ 8] 2266 	rr	c
   58E1 CB 28         [ 8] 2267 	sra	b
   58E3 CB 19         [ 8] 2268 	rr	c
   58E5 DD 46 F1      [19] 2269 	ld	b,-15 (ix)
   58E8 79            [ 4] 2270 	ld	a,c
   58E9 90            [ 4] 2271 	sub	a, b
   58EA DD 77 DE      [19] 2272 	ld	-34 (ix),a
                           2273 ;src/Renderer.c:872: lastCellWasWall = 0;
   58ED DD 36 E5 00   [19] 2274 	ld	-27 (ix),#0x00
                           2275 ;src/Renderer.c:873: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   58F1 DD 6E F4      [19] 2276 	ld	l,-12 (ix)
   58F4 DD 66 F5      [19] 2277 	ld	h,-11 (ix)
   58F7 29            [11] 2278 	add	hl, hl
   58F8 DD 4E E3      [19] 2279 	ld	c,-29 (ix)
   58FB 06 00         [ 7] 2280 	ld	b,#0x00
   58FD C5            [11] 2281 	push	bc
   58FE E5            [11] 2282 	push	hl
   58FF CD E8 75      [17] 2283 	call	__divsint
   5902 F1            [10] 2284 	pop	af
   5903 F1            [10] 2285 	pop	af
   5904 DD 7E FB      [19] 2286 	ld	a,-5 (ix)
   5907 95            [ 4] 2287 	sub	a, l
   5908 DD 77 EF      [19] 2288 	ld	-17 (ix),a
                           2289 ;src/Renderer.c:874: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   590B DD 7E E7      [19] 2290 	ld	a,-25 (ix)
   590E D6 80         [ 7] 2291 	sub	a, #0x80
   5910 20 04         [12] 2292 	jr	NZ,00278$
   5912 0E 0F         [ 7] 2293 	ld	c,#0x0F
   5914 18 02         [12] 2294 	jr	00279$
   5916                    2295 00278$:
   5916 0E 0D         [ 7] 2296 	ld	c,#0x0D
   5918                    2297 00279$:
   5918 DD 71 CE      [19] 2298 	ld	-50 (ix),c
   591B 18 10         [12] 2299 	jr	00224$
   591D                    2300 00218$:
                           2301 ;src/Renderer.c:878: xHeight = 0;
   591D DD 36 EF 00   [19] 2302 	ld	-17 (ix),#0x00
                           2303 ;src/Renderer.c:879: lastCellWasWall = 0;
   5921 DD 36 E5 00   [19] 2304 	ld	-27 (ix),#0x00
                           2305 ;src/Renderer.c:880: lateralWallSlope=0;
   5925 DD 36 E3 00   [19] 2306 	ld	-29 (ix),#0x00
                           2307 ;src/Renderer.c:881: lastWallId=0;
   5929 DD 36 E7 00   [19] 2308 	ld	-25 (ix),#0x00
   592D                    2309 00224$:
                           2310 ;src/Renderer.c:884: newCell=0;
   592D DD 36 FA 00   [19] 2311 	ld	-6 (ix),#0x00
   5931                    2312 00229$:
                           2313 ;src/Renderer.c:889: if (lateralWallCounter > 0)
   5931 DD 7E DE      [19] 2314 	ld	a,-34 (ix)
   5934 B7            [ 4] 2315 	or	a, a
   5935 28 1E         [12] 2316 	jr	Z,00235$
                           2317 ;src/Renderer.c:892: if (lateralWallSlope != 0)
   5937 DD 7E E3      [19] 2318 	ld	a,-29 (ix)
   593A B7            [ 4] 2319 	or	a, a
   593B 28 15         [12] 2320 	jr	Z,00233$
                           2321 ;src/Renderer.c:894: if (lateralWallSlopeCounter == lateralWallSlope)
   593D DD 7E E3      [19] 2322 	ld	a,-29 (ix)
   5940 DD 96 DA      [19] 2323 	sub	a, -38 (ix)
   5943 20 0A         [12] 2324 	jr	NZ,00231$
                           2325 ;src/Renderer.c:896: lateralWallSlopeCounter = 0;
   5945 DD 36 DA 00   [19] 2326 	ld	-38 (ix),#0x00
                           2327 ;src/Renderer.c:897: xHeight -= 2;
   5949 DD 35 EF      [23] 2328 	dec	-17 (ix)
   594C DD 35 EF      [23] 2329 	dec	-17 (ix)
   594F                    2330 00231$:
                           2331 ;src/Renderer.c:899: ++lateralWallSlopeCounter;
   594F DD 34 DA      [23] 2332 	inc	-38 (ix)
   5952                    2333 00233$:
                           2334 ;src/Renderer.c:901: --lateralWallCounter;
   5952 DD 35 DE      [23] 2335 	dec	-34 (ix)
   5955                    2336 00235$:
                           2337 ;src/Renderer.c:905: if (!(x%2))
   5955 DD 7E E2      [19] 2338 	ld	a,-30 (ix)
   5958 B7            [ 4] 2339 	or	a, a
   5959 20 5B         [12] 2340 	jr	NZ,00244$
                           2341 ;src/Renderer.c:910: draw_column_to_buffer_untextured(x/2, xHeight, color);
   595B DD 46 D6      [19] 2342 	ld	b,-42 (ix)
   595E CB 38         [ 8] 2343 	srl	b
                           2344 ;src/Renderer.c:908: if(xHeight > 0){
   5960 DD 7E EF      [19] 2345 	ld	a,-17 (ix)
   5963 B7            [ 4] 2346 	or	a, a
   5964 28 10         [12] 2347 	jr	Z,00237$
                           2348 ;src/Renderer.c:910: draw_column_to_buffer_untextured(x/2, xHeight, color);
   5966 C5            [11] 2349 	push	bc
   5967 DD 66 CE      [19] 2350 	ld	h,-50 (ix)
   596A DD 6E EF      [19] 2351 	ld	l,-17 (ix)
   596D E5            [11] 2352 	push	hl
   596E C5            [11] 2353 	push	bc
   596F 33            [ 6] 2354 	inc	sp
   5970 CD A0 4B      [17] 2355 	call	_draw_column_to_buffer_untextured
   5973 F1            [10] 2356 	pop	af
   5974 33            [ 6] 2357 	inc	sp
   5975 C1            [10] 2358 	pop	bc
   5976                    2359 00237$:
                           2360 ;src/Renderer.c:913: if(!(currentCellID&CELL_WALL_MASK)){
   5976 DD 7E FE      [19] 2361 	ld	a,-2 (ix)
   5979 B7            [ 4] 2362 	or	a, a
   597A 20 3A         [12] 2363 	jr	NZ,00244$
                           2364 ;src/Renderer.c:914: if(currentCellID&CELL_ENEMY_MASK){
   597C DD 7E F3      [19] 2365 	ld	a,-13 (ix)
   597F E6 0F         [ 7] 2366 	and	a, #0x0F
   5981 28 33         [12] 2367 	jr	Z,00244$
                           2368 ;src/Renderer.c:915: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   5983 DD 7E ED      [19] 2369 	ld	a,-19 (ix)
   5986 DD 96 F4      [19] 2370 	sub	a, -12 (ix)
   5989 6F            [ 4] 2371 	ld	l,a
   598A DD 7E EE      [19] 2372 	ld	a,-18 (ix)
   598D DD 9E F5      [19] 2373 	sbc	a, -11 (ix)
   5990 67            [ 4] 2374 	ld	h,a
   5991 29            [11] 2375 	add	hl, hl
   5992 29            [11] 2376 	add	hl, hl
   5993 29            [11] 2377 	add	hl, hl
   5994 29            [11] 2378 	add	hl, hl
   5995 29            [11] 2379 	add	hl, hl
   5996 C5            [11] 2380 	push	bc
   5997 DD 5E ED      [19] 2381 	ld	e,-19 (ix)
   599A DD 56 EE      [19] 2382 	ld	d,-18 (ix)
   599D D5            [11] 2383 	push	de
   599E E5            [11] 2384 	push	hl
   599F CD E8 75      [17] 2385 	call	__divsint
   59A2 F1            [10] 2386 	pop	af
   59A3 F1            [10] 2387 	pop	af
   59A4 55            [ 4] 2388 	ld	d,l
   59A5 C1            [10] 2389 	pop	bc
   59A6 D5            [11] 2390 	push	de
   59A7 33            [ 6] 2391 	inc	sp
   59A8 DD 66 F3      [19] 2392 	ld	h,-13 (ix)
   59AB DD 6E D5      [19] 2393 	ld	l,-43 (ix)
   59AE E5            [11] 2394 	push	hl
   59AF C5            [11] 2395 	push	bc
   59B0 33            [ 6] 2396 	inc	sp
   59B1 CD 19 4C      [17] 2397 	call	_draw_column_to_buffer_enemy
   59B4 F1            [10] 2398 	pop	af
   59B5 F1            [10] 2399 	pop	af
                           2400 ;src/Renderer.c:917: else if(currentCellID&CELL_ITEM_MASK){
   59B6                    2401 00244$:
                           2402 ;src/Renderer.c:922: ++xCellCount;
   59B6 DD 34 F1      [23] 2403 	inc	-15 (ix)
                           2404 ;src/Renderer.c:841: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   59B9 DD 35 D6      [23] 2405 	dec	-42 (ix)
                           2406 ;src/Renderer.c:478: currentCellID = cells_in_view_array[lineStart + 1];
   59BC 2A 99 4B      [16] 2407 	ld	hl,(_cells_in_view_array)
   59BF DD 75 E0      [19] 2408 	ld	-32 (ix),l
   59C2 DD 74 E1      [19] 2409 	ld	-31 (ix),h
                           2410 ;src/Renderer.c:841: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   59C5 DD 7E D6      [19] 2411 	ld	a,-42 (ix)
   59C8 D6 50         [ 7] 2412 	sub	a, #0x50
   59CA D2 8D 57      [10] 2413 	jp	NC,00258$
                           2414 ;src/Renderer.c:929: lineStart = lineStart + (offsetDiff * 2) + 3;
   59CD DD 7E FC      [19] 2415 	ld	a,-4 (ix)
   59D0 C6 03         [ 7] 2416 	add	a, #0x03
   59D2 DD 77 CF      [19] 2417 	ld	-49 (ix),a
                           2418 ;src/Renderer.c:930: zHeight += zHeight;
   59D5 DD CB D5 26   [23] 2419 	sla	-43 (ix)
                           2420 ;src/Renderer.c:931: offsetDiff = offsetDiff >> 1;
   59D9 DD CB CA 3E   [23] 2421 	srl	-54 (ix)
                           2422 ;src/Renderer.c:933: }while(z);
   59DD DD 7E C8      [19] 2423 	ld	a,-56 (ix)
   59E0 B7            [ 4] 2424 	or	a, a
   59E1 C2 3B 54      [10] 2425 	jp	NZ,00246$
   59E4                    2426 00260$:
   59E4 DD F9         [10] 2427 	ld	sp, ix
   59E6 DD E1         [14] 2428 	pop	ix
   59E8 C9            [10] 2429 	ret
                           2430 ;src/Renderer.c:941: void draw_minimap_to_buffer(){
                           2431 ;	---------------------------------
                           2432 ; Function draw_minimap_to_buffer
                           2433 ; ---------------------------------
   59E9                    2434 _draw_minimap_to_buffer::
   59E9 DD E5         [15] 2435 	push	ix
   59EB DD 21 00 00   [14] 2436 	ld	ix,#0
   59EF DD 39         [15] 2437 	add	ix,sp
   59F1 21 F5 FF      [10] 2438 	ld	hl,#-11
   59F4 39            [11] 2439 	add	hl,sp
   59F5 F9            [ 6] 2440 	ld	sp,hl
                           2441 ;src/Renderer.c:944: u8* ptr = MINIMAP_BUFFER;
   59F6 01 40 1C      [10] 2442 	ld	bc,#0x1C40
                           2443 ;src/Renderer.c:949: y=(PLAYER_position.y-MINIMAP_HEIGHT_HALF);
   59F9 3A BB 49      [13] 2444 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   59FC C6 F8         [ 7] 2445 	add	a,#0xF8
   59FE 5F            [ 4] 2446 	ld	e,a
                           2447 ;src/Renderer.c:951: for(j=0;j<MINIMAP_HEIGHT;++j){
   59FF 16 00         [ 7] 2448 	ld	d,#0x00
                           2449 ;src/Renderer.c:952: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   5A01                    2450 00137$:
   5A01 7B            [ 4] 2451 	ld	a,e
   5A02 07            [ 4] 2452 	rlca
   5A03 E6 01         [ 7] 2453 	and	a,#0x01
   5A05 DD 77 FF      [19] 2454 	ld	-1 (ix),a
   5A08 7B            [ 4] 2455 	ld	a,e
   5A09 EE 80         [ 7] 2456 	xor	a, #0x80
   5A0B D6 A0         [ 7] 2457 	sub	a, #0xA0
   5A0D 3E 00         [ 7] 2458 	ld	a,#0x00
   5A0F 17            [ 4] 2459 	rla
   5A10 DD 77 FE      [19] 2460 	ld	-2 (ix),a
   5A13 DD 36 F6 00   [19] 2461 	ld	-10 (ix),#0x00
   5A17                    2462 00122$:
                           2463 ;src/Renderer.c:953: x=(PLAYER_position.x-MINIMAP_WIDTH_HALF);
   5A17 3A BA 49      [13] 2464 	ld	a, (#_PLAYER_position + 0)
   5A1A C6 F8         [ 7] 2465 	add	a,#0xF8
   5A1C DD 77 FB      [19] 2466 	ld	-5 (ix),a
                           2467 ;src/Renderer.c:954: for(i=0;i<MINIMAP_WIDTH;++i){
   5A1F DD 36 F5 00   [19] 2468 	ld	-11 (ix),#0x00
   5A23                    2469 00120$:
                           2470 ;src/Renderer.c:957: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   5A23 FD 21 10 00   [14] 2471 	ld	iy,#0x0010
   5A27 FD 09         [15] 2472 	add	iy, bc
                           2473 ;src/Renderer.c:955: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
   5A29 DD CB FB 7E   [20] 2474 	bit	7, -5 (ix)
   5A2D 20 15         [12] 2475 	jr	NZ,00111$
   5A2F DD 7E FB      [19] 2476 	ld	a,-5 (ix)
   5A32 EE 80         [ 7] 2477 	xor	a, #0x80
   5A34 D6 A0         [ 7] 2478 	sub	a, #0xA0
   5A36 30 0C         [12] 2479 	jr	NC,00111$
   5A38 DD 7E FF      [19] 2480 	ld	a,-1 (ix)
   5A3B B7            [ 4] 2481 	or	a, a
   5A3C 20 06         [12] 2482 	jr	NZ,00111$
   5A3E DD CB FE 46   [20] 2483 	bit	0,-2 (ix)
   5A42 20 0D         [12] 2484 	jr	NZ,00112$
   5A44                    2485 00111$:
                           2486 ;src/Renderer.c:956: *ptr=g_colors[MINIMAP_WALL_COLOR];
   5A44 3A 87 4B      [13] 2487 	ld	a, (#(_g_colors + 0x0001) + 0)
   5A47 02            [ 7] 2488 	ld	(bc),a
                           2489 ;src/Renderer.c:957: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   5A48 3A 87 4B      [13] 2490 	ld	a, (#(_g_colors + 0x0001) + 0)
   5A4B FD 77 00      [19] 2491 	ld	0 (iy), a
   5A4E C3 F8 5A      [10] 2492 	jp	00113$
   5A51                    2493 00112$:
                           2494 ;src/Renderer.c:959: else if((x==PLAYER_position.x)&&(y==PLAYER_position.y)){
   5A51 DD 7E FB      [19] 2495 	ld	a,-5 (ix)
   5A54 DD 77 FC      [19] 2496 	ld	-4 (ix),a
   5A57 DD 7E FB      [19] 2497 	ld	a,-5 (ix)
   5A5A 17            [ 4] 2498 	rla
   5A5B 9F            [ 4] 2499 	sbc	a, a
   5A5C DD 77 FD      [19] 2500 	ld	-3 (ix),a
   5A5F 3A BA 49      [13] 2501 	ld	a, (#_PLAYER_position + 0)
   5A62 DD 77 F7      [19] 2502 	ld	-9 (ix),a
   5A65 DD 36 F8 00   [19] 2503 	ld	-8 (ix),#0x00
   5A69 DD 73 F9      [19] 2504 	ld	-7 (ix),e
   5A6C 7B            [ 4] 2505 	ld	a,e
   5A6D 17            [ 4] 2506 	rla
   5A6E 9F            [ 4] 2507 	sbc	a, a
   5A6F DD 77 FA      [19] 2508 	ld	-6 (ix),a
   5A72 DD 7E FC      [19] 2509 	ld	a,-4 (ix)
   5A75 DD 96 F7      [19] 2510 	sub	a, -9 (ix)
   5A78 20 2E         [12] 2511 	jr	NZ,00108$
   5A7A DD 7E FD      [19] 2512 	ld	a,-3 (ix)
   5A7D DD 96 F8      [19] 2513 	sub	a, -8 (ix)
   5A80 20 26         [12] 2514 	jr	NZ,00108$
   5A82 3A BB 49      [13] 2515 	ld	a, (#(_PLAYER_position + 0x0001) + 0)
   5A85 DD 77 F7      [19] 2516 	ld	-9 (ix),a
   5A88 DD 36 F8 00   [19] 2517 	ld	-8 (ix),#0x00
   5A8C DD 7E F9      [19] 2518 	ld	a,-7 (ix)
   5A8F DD 96 F7      [19] 2519 	sub	a, -9 (ix)
   5A92 20 14         [12] 2520 	jr	NZ,00108$
   5A94 DD 7E FA      [19] 2521 	ld	a,-6 (ix)
   5A97 DD 96 F8      [19] 2522 	sub	a, -8 (ix)
   5A9A 20 0C         [12] 2523 	jr	NZ,00108$
                           2524 ;src/Renderer.c:960: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
   5A9C 3A 8A 4B      [13] 2525 	ld	a, (#(_g_colors + 0x0004) + 0)
   5A9F 02            [ 7] 2526 	ld	(bc),a
                           2527 ;src/Renderer.c:961: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
   5AA0 3A 8A 4B      [13] 2528 	ld	a, (#(_g_colors + 0x0004) + 0)
   5AA3 FD 77 00      [19] 2529 	ld	0 (iy), a
   5AA6 18 50         [12] 2530 	jr	00113$
   5AA8                    2531 00108$:
                           2532 ;src/Renderer.c:964: val = (*(u8*)(MAP_MEM+x+y*MAP_WIDTH));
   5AA8 DD 7E FC      [19] 2533 	ld	a,-4 (ix)
   5AAB C6 40         [ 7] 2534 	add	a, #0x40
   5AAD DD 77 F7      [19] 2535 	ld	-9 (ix),a
   5AB0 DD 7E FD      [19] 2536 	ld	a,-3 (ix)
   5AB3 CE 00         [ 7] 2537 	adc	a, #0x00
   5AB5 DD 77 F8      [19] 2538 	ld	-8 (ix),a
   5AB8 DD 6E F9      [19] 2539 	ld	l,-7 (ix)
   5ABB DD 66 FA      [19] 2540 	ld	h,-6 (ix)
   5ABE 29            [11] 2541 	add	hl, hl
   5ABF 29            [11] 2542 	add	hl, hl
   5AC0 29            [11] 2543 	add	hl, hl
   5AC1 29            [11] 2544 	add	hl, hl
   5AC2 29            [11] 2545 	add	hl, hl
   5AC3 DD 7E F7      [19] 2546 	ld	a,-9 (ix)
   5AC6 85            [ 4] 2547 	add	a, l
   5AC7 6F            [ 4] 2548 	ld	l,a
   5AC8 DD 7E F8      [19] 2549 	ld	a,-8 (ix)
   5ACB 8C            [ 4] 2550 	adc	a, h
   5ACC 67            [ 4] 2551 	ld	h,a
   5ACD 66            [ 7] 2552 	ld	h,(hl)
                           2553 ;src/Renderer.c:966: if(val==CELLTYPE_DOOR){
   5ACE 7C            [ 4] 2554 	ld	a,h
   5ACF D6 80         [ 7] 2555 	sub	a, #0x80
   5AD1 20 0C         [12] 2556 	jr	NZ,00105$
                           2557 ;src/Renderer.c:967: *ptr=g_colors[MINIMAP_EXIT_COLOR];
   5AD3 3A 8E 4B      [13] 2558 	ld	a, (#(_g_colors + 0x0008) + 0)
   5AD6 02            [ 7] 2559 	ld	(bc),a
                           2560 ;src/Renderer.c:968: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
   5AD7 3A 8E 4B      [13] 2561 	ld	a, (#(_g_colors + 0x0008) + 0)
   5ADA FD 77 00      [19] 2562 	ld	0 (iy), a
   5ADD 18 19         [12] 2563 	jr	00113$
   5ADF                    2564 00105$:
                           2565 ;src/Renderer.c:970: else if(val&CELL_WALL_MASK){
   5ADF 29            [11] 2566 	add	hl, hl
   5AE0 30 0C         [12] 2567 	jr	NC,00102$
                           2568 ;src/Renderer.c:971: *ptr=g_colors[MINIMAP_WALL_COLOR];
   5AE2 3A 87 4B      [13] 2569 	ld	a, (#(_g_colors + 0x0001) + 0)
   5AE5 02            [ 7] 2570 	ld	(bc),a
                           2571 ;src/Renderer.c:972: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   5AE6 3A 87 4B      [13] 2572 	ld	a, (#(_g_colors + 0x0001) + 0)
   5AE9 FD 77 00      [19] 2573 	ld	0 (iy), a
   5AEC 18 0A         [12] 2574 	jr	00113$
   5AEE                    2575 00102$:
                           2576 ;src/Renderer.c:975: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
   5AEE 3A 89 4B      [13] 2577 	ld	a, (#(_g_colors + 0x0003) + 0)
   5AF1 02            [ 7] 2578 	ld	(bc),a
                           2579 ;src/Renderer.c:976: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
   5AF2 3A 89 4B      [13] 2580 	ld	a, (#(_g_colors + 0x0003) + 0)
   5AF5 FD 77 00      [19] 2581 	ld	0 (iy), a
   5AF8                    2582 00113$:
                           2583 ;src/Renderer.c:979: ++x;
   5AF8 DD 34 FB      [23] 2584 	inc	-5 (ix)
                           2585 ;src/Renderer.c:980: ++ptr;
   5AFB 03            [ 6] 2586 	inc	bc
                           2587 ;src/Renderer.c:954: for(i=0;i<MINIMAP_WIDTH;++i){
   5AFC DD 34 F5      [23] 2588 	inc	-11 (ix)
   5AFF DD 7E F5      [19] 2589 	ld	a,-11 (ix)
   5B02 D6 10         [ 7] 2590 	sub	a, #0x10
   5B04 DA 23 5A      [10] 2591 	jp	C,00120$
                           2592 ;src/Renderer.c:952: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   5B07 DD 34 F6      [23] 2593 	inc	-10 (ix)
   5B0A DD 7E F6      [19] 2594 	ld	a,-10 (ix)
   5B0D D6 04         [ 7] 2595 	sub	a, #0x04
   5B0F DA 17 5A      [10] 2596 	jp	C,00122$
                           2597 ;src/Renderer.c:983: ++y;
   5B12 1C            [ 4] 2598 	inc	e
                           2599 ;src/Renderer.c:951: for(j=0;j<MINIMAP_HEIGHT;++j){
   5B13 14            [ 4] 2600 	inc	d
   5B14 7A            [ 4] 2601 	ld	a,d
   5B15 D6 10         [ 7] 2602 	sub	a, #0x10
   5B17 DA 01 5A      [10] 2603 	jp	C,00137$
   5B1A DD F9         [10] 2604 	ld	sp, ix
   5B1C DD E1         [14] 2605 	pop	ix
   5B1E C9            [10] 2606 	ret
                           2607 	.area _CODE
                           2608 	.area _INITIALIZER
                           2609 	.area _CABS (ABS)
