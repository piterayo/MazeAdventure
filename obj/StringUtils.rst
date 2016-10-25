                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module StringUtils
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _i_to_s_buffer
                             12 	.globl _charArray
                             13 	.globl _integer_to_string
                             14 	.globl _print_text
                             15 	.globl _print_transparent_text
                             16 ;--------------------------------------------------------
                             17 ; special function registers
                             18 ;--------------------------------------------------------
                             19 ;--------------------------------------------------------
                             20 ; ram data
                             21 ;--------------------------------------------------------
                             22 	.area _DATA
                             23 ;--------------------------------------------------------
                             24 ; ram data
                             25 ;--------------------------------------------------------
                             26 	.area _INITIALIZED
                             27 ;--------------------------------------------------------
                             28 ; absolute external ram data
                             29 ;--------------------------------------------------------
                             30 	.area _DABS (ABS)
                             31 ;--------------------------------------------------------
                             32 ; global & static initialisations
                             33 ;--------------------------------------------------------
                             34 	.area _HOME
                             35 	.area _GSINIT
                             36 	.area _GSFINAL
                             37 	.area _GSINIT
                             38 ;--------------------------------------------------------
                             39 ; Home
                             40 ;--------------------------------------------------------
                             41 	.area _HOME
                             42 	.area _HOME
                             43 ;--------------------------------------------------------
                             44 ; code
                             45 ;--------------------------------------------------------
                             46 	.area _CODE
                             47 ;src/StringUtils.c:35: void* integer_to_string(u8 n, u8 format){
                             48 ;	---------------------------------
                             49 ; Function integer_to_string
                             50 ; ---------------------------------
   3C5E                      51 _integer_to_string::
   3C5E DD E5         [15]   52 	push	ix
   3C60 DD 21 00 00   [14]   53 	ld	ix,#0
   3C64 DD 39         [15]   54 	add	ix,sp
                             55 ;src/StringUtils.c:36: u8* charPosition=(u8*)&i_to_s_buffer;
   3C66 01 BC 3D      [10]   56 	ld	bc,#_i_to_s_buffer+0
                             57 ;src/StringUtils.c:38: switch(format){
   3C69 DD 7E 05      [19]   58 	ld	a,5 (ix)
   3C6C D6 62         [ 7]   59 	sub	a, #0x62
   3C6E 28 45         [12]   60 	jr	Z,00102$
   3C70 DD 7E 05      [19]   61 	ld	a,5 (ix)
   3C73 D6 68         [ 7]   62 	sub	a, #0x68
   3C75 20 57         [12]   63 	jr	NZ,00106$
                             64 ;src/StringUtils.c:40: charPosition+=2;
   3C77 11 BE 3D      [10]   65 	ld	de,#_i_to_s_buffer + 2
                             66 ;src/StringUtils.c:42: *charPosition = 0;
   3C7A AF            [ 4]   67 	xor	a, a
   3C7B 12            [ 7]   68 	ld	(de),a
                             69 ;src/StringUtils.c:44: --charPosition;
   3C7C 1B            [ 6]   70 	dec	de
                             71 ;src/StringUtils.c:46: t=n&0x0F;
   3C7D DD 7E 04      [19]   72 	ld	a,4 (ix)
   3C80 E6 0F         [ 7]   73 	and	a, #0x0F
   3C82 6F            [ 4]   74 	ld	l,a
                             75 ;src/StringUtils.c:47: t=t>9?t+55:t+48;
   3C83 3E 09         [ 7]   76 	ld	a,#0x09
   3C85 95            [ 4]   77 	sub	a, l
   3C86 30 05         [12]   78 	jr	NC,00110$
   3C88 7D            [ 4]   79 	ld	a,l
   3C89 C6 37         [ 7]   80 	add	a, #0x37
   3C8B 18 03         [12]   81 	jr	00111$
   3C8D                      82 00110$:
   3C8D 7D            [ 4]   83 	ld	a,l
   3C8E C6 30         [ 7]   84 	add	a, #0x30
   3C90                      85 00111$:
                             86 ;src/StringUtils.c:48: *charPosition=t;
   3C90 12            [ 7]   87 	ld	(de),a
                             88 ;src/StringUtils.c:49: n>>=4;
   3C91 DD 7E 04      [19]   89 	ld	a,4 (ix)
   3C94 07            [ 4]   90 	rlca
   3C95 07            [ 4]   91 	rlca
   3C96 07            [ 4]   92 	rlca
   3C97 07            [ 4]   93 	rlca
   3C98 E6 0F         [ 7]   94 	and	a,#0x0F
   3C9A DD 77 04      [19]   95 	ld	4 (ix),a
                             96 ;src/StringUtils.c:50: --charPosition;
   3C9D 1B            [ 6]   97 	dec	de
                             98 ;src/StringUtils.c:52: t=n>9?n+55:n+48;
   3C9E 3E 09         [ 7]   99 	ld	a,#0x09
   3CA0 DD 96 04      [19]  100 	sub	a, 4 (ix)
   3CA3 30 07         [12]  101 	jr	NC,00112$
   3CA5 DD 7E 04      [19]  102 	ld	a,4 (ix)
   3CA8 C6 37         [ 7]  103 	add	a, #0x37
   3CAA 18 05         [12]  104 	jr	00113$
   3CAC                     105 00112$:
   3CAC DD 7E 04      [19]  106 	ld	a,4 (ix)
   3CAF C6 30         [ 7]  107 	add	a, #0x30
   3CB1                     108 00113$:
                            109 ;src/StringUtils.c:53: *charPosition=t;
   3CB1 12            [ 7]  110 	ld	(de),a
                            111 ;src/StringUtils.c:54: break;
   3CB2 C3 37 3D      [10]  112 	jp	00107$
                            113 ;src/StringUtils.c:56: case 'b':{
   3CB5                     114 00102$:
                            115 ;src/StringUtils.c:58: charPosition+=8;
   3CB5 21 C4 3D      [10]  116 	ld	hl,#_i_to_s_buffer + 8
                            117 ;src/StringUtils.c:60: while(t){
   3CB8 1E 08         [ 7]  118 	ld	e,#0x08
   3CBA                     119 00103$:
   3CBA 7B            [ 4]  120 	ld	a,e
   3CBB B7            [ 4]  121 	or	a, a
   3CBC 28 79         [12]  122 	jr	Z,00107$
                            123 ;src/StringUtils.c:61: --t;
   3CBE 1D            [ 4]  124 	dec	e
                            125 ;src/StringUtils.c:62: --charPosition;
   3CBF 2B            [ 6]  126 	dec	hl
                            127 ;src/StringUtils.c:63: *charPosition=(n&1)+48;
   3CC0 DD 7E 04      [19]  128 	ld	a,4 (ix)
   3CC3 E6 01         [ 7]  129 	and	a, #0x01
   3CC5 C6 30         [ 7]  130 	add	a, #0x30
   3CC7 77            [ 7]  131 	ld	(hl),a
                            132 ;src/StringUtils.c:64: n>>=1;
   3CC8 DD CB 04 3E   [23]  133 	srl	4 (ix)
   3CCC 18 EC         [12]  134 	jr	00103$
                            135 ;src/StringUtils.c:68: default:{
   3CCE                     136 00106$:
                            137 ;src/StringUtils.c:69: charPosition+=3;
   3CCE 11 BF 3D      [10]  138 	ld	de,#_i_to_s_buffer + 3
                            139 ;src/StringUtils.c:71: *charPosition = 0;
   3CD1 AF            [ 4]  140 	xor	a, a
   3CD2 12            [ 7]  141 	ld	(de),a
                            142 ;src/StringUtils.c:73: --charPosition;
   3CD3 1B            [ 6]  143 	dec	de
                            144 ;src/StringUtils.c:75: *charPosition=48+(n%10);
   3CD4 C5            [11]  145 	push	bc
   3CD5 D5            [11]  146 	push	de
   3CD6 3E 0A         [ 7]  147 	ld	a,#0x0A
   3CD8 F5            [11]  148 	push	af
   3CD9 33            [ 6]  149 	inc	sp
   3CDA DD 7E 04      [19]  150 	ld	a,4 (ix)
   3CDD F5            [11]  151 	push	af
   3CDE 33            [ 6]  152 	inc	sp
   3CDF CD 13 7A      [17]  153 	call	__moduchar
   3CE2 F1            [10]  154 	pop	af
   3CE3 D1            [10]  155 	pop	de
   3CE4 C1            [10]  156 	pop	bc
   3CE5 7D            [ 4]  157 	ld	a,l
   3CE6 C6 30         [ 7]  158 	add	a, #0x30
   3CE8 12            [ 7]  159 	ld	(de),a
                            160 ;src/StringUtils.c:76: --charPosition;
                            161 ;src/StringUtils.c:77: n/=10;
   3CE9 C5            [11]  162 	push	bc
   3CEA 3E 0A         [ 7]  163 	ld	a,#0x0A
   3CEC F5            [11]  164 	push	af
   3CED 33            [ 6]  165 	inc	sp
   3CEE DD 7E 04      [19]  166 	ld	a,4 (ix)
   3CF1 F5            [11]  167 	push	af
   3CF2 33            [ 6]  168 	inc	sp
   3CF3 CD 9C 78      [17]  169 	call	__divuchar
   3CF6 F1            [10]  170 	pop	af
   3CF7 C1            [10]  171 	pop	bc
   3CF8 DD 75 04      [19]  172 	ld	4 (ix),l
                            173 ;src/StringUtils.c:78: *charPosition=48+(n%10);
   3CFB C5            [11]  174 	push	bc
   3CFC 3E 0A         [ 7]  175 	ld	a,#0x0A
   3CFE F5            [11]  176 	push	af
   3CFF 33            [ 6]  177 	inc	sp
   3D00 DD 7E 04      [19]  178 	ld	a,4 (ix)
   3D03 F5            [11]  179 	push	af
   3D04 33            [ 6]  180 	inc	sp
   3D05 CD 13 7A      [17]  181 	call	__moduchar
   3D08 F1            [10]  182 	pop	af
   3D09 C1            [10]  183 	pop	bc
   3D0A 7D            [ 4]  184 	ld	a,l
   3D0B C6 30         [ 7]  185 	add	a, #0x30
   3D0D 32 BD 3D      [13]  186 	ld	(#(_i_to_s_buffer + 0x0001)),a
                            187 ;src/StringUtils.c:79: --charPosition;
                            188 ;src/StringUtils.c:80: n/=10;
   3D10 C5            [11]  189 	push	bc
   3D11 3E 0A         [ 7]  190 	ld	a,#0x0A
   3D13 F5            [11]  191 	push	af
   3D14 33            [ 6]  192 	inc	sp
   3D15 DD 7E 04      [19]  193 	ld	a,4 (ix)
   3D18 F5            [11]  194 	push	af
   3D19 33            [ 6]  195 	inc	sp
   3D1A CD 9C 78      [17]  196 	call	__divuchar
   3D1D F1            [10]  197 	pop	af
   3D1E C1            [10]  198 	pop	bc
   3D1F DD 75 04      [19]  199 	ld	4 (ix),l
                            200 ;src/StringUtils.c:81: *charPosition=48+(n%10);
   3D22 C5            [11]  201 	push	bc
   3D23 3E 0A         [ 7]  202 	ld	a,#0x0A
   3D25 F5            [11]  203 	push	af
   3D26 33            [ 6]  204 	inc	sp
   3D27 DD 7E 04      [19]  205 	ld	a,4 (ix)
   3D2A F5            [11]  206 	push	af
   3D2B 33            [ 6]  207 	inc	sp
   3D2C CD 13 7A      [17]  208 	call	__moduchar
   3D2F F1            [10]  209 	pop	af
   3D30 C1            [10]  210 	pop	bc
   3D31 7D            [ 4]  211 	ld	a,l
   3D32 C6 30         [ 7]  212 	add	a, #0x30
   3D34 32 BC 3D      [13]  213 	ld	(#_i_to_s_buffer),a
                            214 ;src/StringUtils.c:84: }
   3D37                     215 00107$:
                            216 ;src/StringUtils.c:86: return i_to_s_buffer;
   3D37 69            [ 4]  217 	ld	l, c
   3D38 60            [ 4]  218 	ld	h, b
   3D39 DD E1         [14]  219 	pop	ix
   3D3B C9            [10]  220 	ret
   3D3C                     221 _charArray:
   3D3C 29                  222 	.db #0x29	; 41
   3D3D 29                  223 	.db #0x29	; 41
   3D3E 29                  224 	.db #0x29	; 41
   3D3F 29                  225 	.db #0x29	; 41
   3D40 29                  226 	.db #0x29	; 41
   3D41 29                  227 	.db #0x29	; 41
   3D42 29                  228 	.db #0x29	; 41
   3D43 29                  229 	.db #0x29	; 41
   3D44 29                  230 	.db #0x29	; 41
   3D45 29                  231 	.db #0x29	; 41
   3D46 29                  232 	.db #0x29	; 41
   3D47 29                  233 	.db #0x29	; 41
   3D48 29                  234 	.db #0x29	; 41
   3D49 29                  235 	.db #0x29	; 41
   3D4A 29                  236 	.db #0x29	; 41
   3D4B 29                  237 	.db #0x29	; 41
   3D4C 29                  238 	.db #0x29	; 41
   3D4D 29                  239 	.db #0x29	; 41
   3D4E 29                  240 	.db #0x29	; 41
   3D4F 29                  241 	.db #0x29	; 41
   3D50 29                  242 	.db #0x29	; 41
   3D51 29                  243 	.db #0x29	; 41
   3D52 29                  244 	.db #0x29	; 41
   3D53 29                  245 	.db #0x29	; 41
   3D54 29                  246 	.db #0x29	; 41
   3D55 29                  247 	.db #0x29	; 41
   3D56 29                  248 	.db #0x29	; 41
   3D57 29                  249 	.db #0x29	; 41
   3D58 29                  250 	.db #0x29	; 41
   3D59 29                  251 	.db #0x29	; 41
   3D5A 29                  252 	.db #0x29	; 41
   3D5B 29                  253 	.db #0x29	; 41
   3D5C 29                  254 	.db #0x29	; 41
   3D5D 24                  255 	.db #0x24	; 36
   3D5E 29                  256 	.db #0x29	; 41
   3D5F 2D                  257 	.db #0x2D	; 45
   3D60 2F                  258 	.db #0x2F	; 47
   3D61 29                  259 	.db #0x29	; 41
   3D62 2E                  260 	.db #0x2E	; 46
   3D63 29                  261 	.db #0x29	; 41
   3D64 29                  262 	.db #0x29	; 41
   3D65 29                  263 	.db #0x29	; 41
   3D66 31                  264 	.db #0x31	; 49	'1'
   3D67 2C                  265 	.db #0x2C	; 44
   3D68 29                  266 	.db #0x29	; 41
   3D69 29                  267 	.db #0x29	; 41
   3D6A 26                  268 	.db #0x26	; 38
   3D6B 29                  269 	.db #0x29	; 41
   3D6C 1A                  270 	.db #0x1A	; 26
   3D6D 1B                  271 	.db #0x1B	; 27
   3D6E 1C                  272 	.db #0x1C	; 28
   3D6F 1D                  273 	.db #0x1D	; 29
   3D70 1E                  274 	.db #0x1E	; 30
   3D71 1F                  275 	.db #0x1F	; 31
   3D72 20                  276 	.db #0x20	; 32
   3D73 21                  277 	.db #0x21	; 33
   3D74 22                  278 	.db #0x22	; 34
   3D75 23                  279 	.db #0x23	; 35
   3D76 27                  280 	.db #0x27	; 39
   3D77 29                  281 	.db #0x29	; 41
   3D78 2A                  282 	.db #0x2A	; 42
   3D79 29                  283 	.db #0x29	; 41
   3D7A 2B                  284 	.db #0x2B	; 43
   3D7B 25                  285 	.db #0x25	; 37
   3D7C 28                  286 	.db #0x28	; 40
   3D7D 00                  287 	.db #0x00	; 0
   3D7E 01                  288 	.db #0x01	; 1
   3D7F 02                  289 	.db #0x02	; 2
   3D80 03                  290 	.db #0x03	; 3
   3D81 04                  291 	.db #0x04	; 4
   3D82 05                  292 	.db #0x05	; 5
   3D83 06                  293 	.db #0x06	; 6
   3D84 07                  294 	.db #0x07	; 7
   3D85 08                  295 	.db #0x08	; 8
   3D86 09                  296 	.db #0x09	; 9
   3D87 0A                  297 	.db #0x0A	; 10
   3D88 0B                  298 	.db #0x0B	; 11
   3D89 0C                  299 	.db #0x0C	; 12
   3D8A 0D                  300 	.db #0x0D	; 13
   3D8B 0E                  301 	.db #0x0E	; 14
   3D8C 0F                  302 	.db #0x0F	; 15
   3D8D 10                  303 	.db #0x10	; 16
   3D8E 11                  304 	.db #0x11	; 17
   3D8F 12                  305 	.db #0x12	; 18
   3D90 13                  306 	.db #0x13	; 19
   3D91 14                  307 	.db #0x14	; 20
   3D92 15                  308 	.db #0x15	; 21
   3D93 16                  309 	.db #0x16	; 22
   3D94 17                  310 	.db #0x17	; 23
   3D95 18                  311 	.db #0x18	; 24
   3D96 19                  312 	.db #0x19	; 25
   3D97 29                  313 	.db #0x29	; 41
   3D98 29                  314 	.db #0x29	; 41
   3D99 29                  315 	.db #0x29	; 41
   3D9A 29                  316 	.db #0x29	; 41
   3D9B 29                  317 	.db #0x29	; 41
   3D9C 29                  318 	.db #0x29	; 41
   3D9D 00                  319 	.db #0x00	; 0
   3D9E 01                  320 	.db #0x01	; 1
   3D9F 02                  321 	.db #0x02	; 2
   3DA0 03                  322 	.db #0x03	; 3
   3DA1 04                  323 	.db #0x04	; 4
   3DA2 05                  324 	.db #0x05	; 5
   3DA3 06                  325 	.db #0x06	; 6
   3DA4 07                  326 	.db #0x07	; 7
   3DA5 08                  327 	.db #0x08	; 8
   3DA6 09                  328 	.db #0x09	; 9
   3DA7 0A                  329 	.db #0x0A	; 10
   3DA8 0B                  330 	.db #0x0B	; 11
   3DA9 0C                  331 	.db #0x0C	; 12
   3DAA 0D                  332 	.db #0x0D	; 13
   3DAB 0E                  333 	.db #0x0E	; 14
   3DAC 0F                  334 	.db #0x0F	; 15
   3DAD 10                  335 	.db #0x10	; 16
   3DAE 11                  336 	.db #0x11	; 17
   3DAF 12                  337 	.db #0x12	; 18
   3DB0 13                  338 	.db #0x13	; 19
   3DB1 14                  339 	.db #0x14	; 20
   3DB2 15                  340 	.db #0x15	; 21
   3DB3 16                  341 	.db #0x16	; 22
   3DB4 17                  342 	.db #0x17	; 23
   3DB5 18                  343 	.db #0x18	; 24
   3DB6 19                  344 	.db #0x19	; 25
   3DB7 29                  345 	.db #0x29	; 41
   3DB8 29                  346 	.db #0x29	; 41
   3DB9 29                  347 	.db #0x29	; 41
   3DBA 30                  348 	.db #0x30	; 48	'0'
   3DBB 29                  349 	.db #0x29	; 41
   3DBC                     350 _i_to_s_buffer:
   3DBC 00                  351 	.db #0x00	; 0
   3DBD 00                  352 	.db #0x00	; 0
   3DBE 00                  353 	.db #0x00	; 0
   3DBF 00                  354 	.db #0x00	; 0
   3DC0 00                  355 	.db #0x00	; 0
   3DC1 00                  356 	.db #0x00	; 0
   3DC2 00                  357 	.db #0x00	; 0
   3DC3 00                  358 	.db #0x00	; 0
   3DC4 00                  359 	.db #0x00	; 0
                            360 ;src/StringUtils.c:90: void print_text(void * const text, u8* position, u8 bg, u8 fg){
                            361 ;	---------------------------------
                            362 ; Function print_text
                            363 ; ---------------------------------
   3DC5                     364 _print_text::
   3DC5 DD E5         [15]  365 	push	ix
   3DC7 DD 21 00 00   [14]  366 	ld	ix,#0
   3DCB DD 39         [15]  367 	add	ix,sp
   3DCD 21 EF FF      [10]  368 	ld	hl,#-17
   3DD0 39            [11]  369 	add	hl,sp
   3DD1 F9            [ 6]  370 	ld	sp,hl
                            371 ;src/StringUtils.c:91: u8 val, charBitArray, spritePos, fgColor=g_colors[fg], bgColor=g_colors[bg];
   3DD2 DD 7E 09      [19]  372 	ld	a,9 (ix)
   3DD5 C6 66         [ 7]  373 	add	a, #<(_g_colors)
   3DD7 DD 77 F9      [19]  374 	ld	-7 (ix),a
   3DDA 3E 00         [ 7]  375 	ld	a,#0x00
   3DDC CE 1A         [ 7]  376 	adc	a, #>(_g_colors)
   3DDE DD 77 FA      [19]  377 	ld	-6 (ix),a
   3DE1 DD 6E F9      [19]  378 	ld	l,-7 (ix)
   3DE4 DD 66 FA      [19]  379 	ld	h,-6 (ix)
   3DE7 7E            [ 7]  380 	ld	a,(hl)
   3DE8 DD 77 F3      [19]  381 	ld	-13 (ix),a
   3DEB 3E 66         [ 7]  382 	ld	a,#<(_g_colors)
   3DED DD 86 08      [19]  383 	add	a, 8 (ix)
   3DF0 DD 77 F9      [19]  384 	ld	-7 (ix),a
   3DF3 3E 1A         [ 7]  385 	ld	a,#>(_g_colors)
   3DF5 CE 00         [ 7]  386 	adc	a, #0x00
   3DF7 DD 77 FA      [19]  387 	ld	-6 (ix),a
   3DFA DD 6E F9      [19]  388 	ld	l,-7 (ix)
   3DFD DD 66 FA      [19]  389 	ld	h,-6 (ix)
   3E00 7E            [ 7]  390 	ld	a,(hl)
   3E01 DD 77 F2      [19]  391 	ld	-14 (ix),a
                            392 ;src/StringUtils.c:97: (position)+=0x2800;
   3E04 DD 7E 06      [19]  393 	ld	a,6 (ix)
   3E07 C6 00         [ 7]  394 	add	a, #0x00
   3E09 DD 77 06      [19]  395 	ld	6 (ix),a
   3E0C DD 7E 07      [19]  396 	ld	a,7 (ix)
   3E0F CE 28         [ 7]  397 	adc	a, #0x28
   3E11 DD 77 07      [19]  398 	ld	7 (ix),a
                            399 ;src/StringUtils.c:98: if(position<0x2800){
   3E14 DD 4E 06      [19]  400 	ld	c,6 (ix)
   3E17 DD 46 07      [19]  401 	ld	b,7 (ix)
   3E1A 78            [ 4]  402 	ld	a,b
   3E1B D6 28         [ 7]  403 	sub	a, #0x28
   3E1D 30 20         [12]  404 	jr	NC,00132$
                            405 ;src/StringUtils.c:99: position-=0x4000;
   3E1F DD 7E 06      [19]  406 	ld	a,6 (ix)
   3E22 C6 00         [ 7]  407 	add	a,#0x00
   3E24 DD 77 06      [19]  408 	ld	6 (ix),a
   3E27 DD 7E 07      [19]  409 	ld	a,7 (ix)
   3E2A CE C0         [ 7]  410 	adc	a,#0xC0
   3E2C DD 77 07      [19]  411 	ld	7 (ix),a
                            412 ;src/StringUtils.c:100: position+=80;
   3E2F DD 7E 06      [19]  413 	ld	a,6 (ix)
   3E32 C6 50         [ 7]  414 	add	a, #0x50
   3E34 DD 77 06      [19]  415 	ld	6 (ix),a
   3E37 DD 7E 07      [19]  416 	ld	a,7 (ix)
   3E3A CE 00         [ 7]  417 	adc	a, #0x00
   3E3C DD 77 07      [19]  418 	ld	7 (ix),a
                            419 ;src/StringUtils.c:103: while(height){
   3E3F                     420 00132$:
   3E3F DD 36 EF 06   [19]  421 	ld	-17 (ix),#0x06
   3E43 DD 36 F9 96   [19]  422 	ld	-7 (ix),#0x96
   3E47                     423 00110$:
   3E47 DD 7E EF      [19]  424 	ld	a,-17 (ix)
   3E4A B7            [ 4]  425 	or	a, a
   3E4B CA 9B 3F      [10]  426 	jp	Z,00113$
                            427 ;src/StringUtils.c:104: --height;
   3E4E DD 7E F9      [19]  428 	ld	a,-7 (ix)
   3E51 C6 E7         [ 7]  429 	add	a,#0xE7
   3E53 DD 77 F9      [19]  430 	ld	-7 (ix),a
   3E56 DD 35 EF      [23]  431 	dec	-17 (ix)
                            432 ;src/StringUtils.c:105: currentChar=text;
   3E59 DD 7E 04      [19]  433 	ld	a,4 (ix)
   3E5C DD 77 F7      [19]  434 	ld	-9 (ix),a
   3E5F DD 7E 05      [19]  435 	ld	a,5 (ix)
   3E62 DD 77 F8      [19]  436 	ld	-8 (ix),a
                            437 ;src/StringUtils.c:106: currentPos=position;
   3E65 DD 7E 06      [19]  438 	ld	a,6 (ix)
   3E68 DD 77 FE      [19]  439 	ld	-2 (ix),a
   3E6B DD 7E 07      [19]  440 	ld	a,7 (ix)
   3E6E DD 77 FF      [19]  441 	ld	-1 (ix),a
                            442 ;src/StringUtils.c:108: while(*currentChar){
   3E71                     443 00105$:
   3E71 DD 6E F7      [19]  444 	ld	l,-9 (ix)
   3E74 DD 66 F8      [19]  445 	ld	h,-8 (ix)
   3E77 7E            [ 7]  446 	ld	a,(hl)
   3E78 DD 77 FD      [19]  447 	ld	-3 (ix), a
   3E7B B7            [ 4]  448 	or	a, a
   3E7C CA 63 3F      [10]  449 	jp	Z,00107$
                            450 ;src/StringUtils.c:110: spritePos = charArray[(*currentChar)];
   3E7F 3E 3C         [ 7]  451 	ld	a,#<(_charArray)
   3E81 DD 86 FD      [19]  452 	add	a, -3 (ix)
   3E84 DD 77 FB      [19]  453 	ld	-5 (ix),a
   3E87 3E 3D         [ 7]  454 	ld	a,#>(_charArray)
   3E89 CE 00         [ 7]  455 	adc	a, #0x00
   3E8B DD 77 FC      [19]  456 	ld	-4 (ix),a
   3E8E DD 6E FB      [19]  457 	ld	l,-5 (ix)
   3E91 DD 66 FC      [19]  458 	ld	h,-4 (ix)
   3E94 7E            [ 7]  459 	ld	a,(hl)
                            460 ;src/StringUtils.c:112: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   3E95 DD 77 F4      [19]  461 	ld	-12 (ix), a
   3E98 CB 3F         [ 8]  462 	srl	a
   3E9A DD 77 FB      [19]  463 	ld	-5 (ix), a
   3E9D DD 86 F9      [19]  464 	add	a, -7 (ix)
   3EA0 DD 77 FB      [19]  465 	ld	-5 (ix),a
   3EA3 C6 C7         [ 7]  466 	add	a,#<(_typography_4x6_monospaced)
   3EA5 DD 77 FB      [19]  467 	ld	-5 (ix),a
   3EA8 3E 5A         [ 7]  468 	ld	a,#>(_typography_4x6_monospaced)
   3EAA CE 00         [ 7]  469 	adc	a, #0x00
   3EAC DD 77 FC      [19]  470 	ld	-4 (ix),a
   3EAF DD 6E FB      [19]  471 	ld	l,-5 (ix)
   3EB2 DD 66 FC      [19]  472 	ld	h,-4 (ix)
   3EB5 7E            [ 7]  473 	ld	a,(hl)
   3EB6 DD 77 FB      [19]  474 	ld	-5 (ix),a
                            475 ;src/StringUtils.c:114: if(spritePos%2) charBitArray<<=4;
   3EB9 DD CB F4 46   [20]  476 	bit	0, -12 (ix)
   3EBD 28 0C         [12]  477 	jr	Z,00104$
   3EBF DD 7E FB      [19]  478 	ld	a,-5 (ix)
   3EC2 07            [ 4]  479 	rlca
   3EC3 07            [ 4]  480 	rlca
   3EC4 07            [ 4]  481 	rlca
   3EC5 07            [ 4]  482 	rlca
   3EC6 E6 F0         [ 7]  483 	and	a,#0xF0
   3EC8 DD 77 FB      [19]  484 	ld	-5 (ix),a
   3ECB                     485 00104$:
                            486 ;src/StringUtils.c:118: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   3ECB DD CB FB 7E   [20]  487 	bit	7, -5 (ix)
   3ECF 28 05         [12]  488 	jr	Z,00115$
   3ED1 DD 7E F3      [19]  489 	ld	a,-13 (ix)
   3ED4 18 03         [12]  490 	jr	00116$
   3ED6                     491 00115$:
   3ED6 DD 7E F2      [19]  492 	ld	a,-14 (ix)
   3ED9                     493 00116$:
   3ED9 E6 AA         [ 7]  494 	and	a, #0xAA
   3EDB 4F            [ 4]  495 	ld	c,a
                            496 ;src/StringUtils.c:120: charBitArray<<=1;
   3EDC DD 7E FB      [19]  497 	ld	a,-5 (ix)
   3EDF 87            [ 4]  498 	add	a, a
   3EE0 47            [ 4]  499 	ld	b,a
                            500 ;src/StringUtils.c:122: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   3EE1 CB 78         [ 8]  501 	bit	7, b
   3EE3 28 05         [12]  502 	jr	Z,00117$
   3EE5 DD 7E F3      [19]  503 	ld	a,-13 (ix)
   3EE8 18 03         [12]  504 	jr	00118$
   3EEA                     505 00117$:
   3EEA DD 7E F2      [19]  506 	ld	a,-14 (ix)
   3EED                     507 00118$:
   3EED E6 55         [ 7]  508 	and	a, #0x55
   3EEF B1            [ 4]  509 	or	a, c
   3EF0 4F            [ 4]  510 	ld	c,a
                            511 ;src/StringUtils.c:124: charBitArray<<=1;
   3EF1 78            [ 4]  512 	ld	a,b
   3EF2 87            [ 4]  513 	add	a, a
   3EF3 DD 77 F5      [19]  514 	ld	-11 (ix),a
                            515 ;src/StringUtils.c:126: *currentPos=val;
   3EF6 DD 6E FE      [19]  516 	ld	l,-2 (ix)
   3EF9 DD 66 FF      [19]  517 	ld	h,-1 (ix)
   3EFC 71            [ 7]  518 	ld	(hl),c
                            519 ;src/StringUtils.c:127: ++currentPos;
   3EFD DD 7E FE      [19]  520 	ld	a,-2 (ix)
   3F00 C6 01         [ 7]  521 	add	a, #0x01
   3F02 DD 77 F0      [19]  522 	ld	-16 (ix),a
   3F05 DD 7E FF      [19]  523 	ld	a,-1 (ix)
   3F08 CE 00         [ 7]  524 	adc	a, #0x00
   3F0A DD 77 F1      [19]  525 	ld	-15 (ix),a
                            526 ;src/StringUtils.c:131: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   3F0D DD CB F5 7E   [20]  527 	bit	7, -11 (ix)
   3F11 28 05         [12]  528 	jr	Z,00119$
   3F13 DD 7E F3      [19]  529 	ld	a,-13 (ix)
   3F16 18 03         [12]  530 	jr	00120$
   3F18                     531 00119$:
   3F18 DD 7E F2      [19]  532 	ld	a,-14 (ix)
   3F1B                     533 00120$:
   3F1B E6 AA         [ 7]  534 	and	a, #0xAA
   3F1D DD 77 F6      [19]  535 	ld	-10 (ix),a
                            536 ;src/StringUtils.c:133: charBitArray<<=1;
   3F20 DD 7E F5      [19]  537 	ld	a,-11 (ix)
   3F23 87            [ 4]  538 	add	a, a
                            539 ;src/StringUtils.c:135: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   3F24 07            [ 4]  540 	rlca
   3F25 30 05         [12]  541 	jr	NC,00121$
   3F27 DD 7E F3      [19]  542 	ld	a,-13 (ix)
   3F2A 18 03         [12]  543 	jr	00122$
   3F2C                     544 00121$:
   3F2C DD 7E F2      [19]  545 	ld	a,-14 (ix)
   3F2F                     546 00122$:
   3F2F E6 55         [ 7]  547 	and	a, #0x55
   3F31 DD 77 FB      [19]  548 	ld	-5 (ix),a
   3F34 DD 7E F6      [19]  549 	ld	a,-10 (ix)
   3F37 DD B6 FB      [19]  550 	or	a, -5 (ix)
   3F3A DD 77 FB      [19]  551 	ld	-5 (ix),a
                            552 ;src/StringUtils.c:139: *currentPos=val;
   3F3D DD 6E F0      [19]  553 	ld	l,-16 (ix)
   3F40 DD 66 F1      [19]  554 	ld	h,-15 (ix)
   3F43 DD 7E FB      [19]  555 	ld	a,-5 (ix)
   3F46 77            [ 7]  556 	ld	(hl),a
                            557 ;src/StringUtils.c:140: ++currentPos;
   3F47 DD 7E F0      [19]  558 	ld	a,-16 (ix)
   3F4A C6 01         [ 7]  559 	add	a, #0x01
   3F4C DD 77 FE      [19]  560 	ld	-2 (ix),a
   3F4F DD 7E F1      [19]  561 	ld	a,-15 (ix)
   3F52 CE 00         [ 7]  562 	adc	a, #0x00
   3F54 DD 77 FF      [19]  563 	ld	-1 (ix),a
                            564 ;src/StringUtils.c:142: ++currentChar;
   3F57 DD 34 F7      [23]  565 	inc	-9 (ix)
   3F5A C2 71 3E      [10]  566 	jp	NZ,00105$
   3F5D DD 34 F8      [23]  567 	inc	-8 (ix)
   3F60 C3 71 3E      [10]  568 	jp	00105$
   3F63                     569 00107$:
                            570 ;src/StringUtils.c:144: position-=0x0800;
   3F63 DD 7E 06      [19]  571 	ld	a,6 (ix)
   3F66 C6 00         [ 7]  572 	add	a,#0x00
   3F68 DD 77 06      [19]  573 	ld	6 (ix),a
   3F6B DD 7E 07      [19]  574 	ld	a,7 (ix)
   3F6E CE F8         [ 7]  575 	adc	a,#0xF8
                            576 ;src/StringUtils.c:146: if(position<0xC000){
   3F70 DD 77 07      [19]  577 	ld	7 (ix), a
   3F73 D6 C0         [ 7]  578 	sub	a, #0xC0
   3F75 D2 47 3E      [10]  579 	jp	NC,00110$
                            580 ;src/StringUtils.c:147: position+=0x4000;
   3F78 DD 7E 06      [19]  581 	ld	a,6 (ix)
   3F7B C6 00         [ 7]  582 	add	a, #0x00
   3F7D DD 77 06      [19]  583 	ld	6 (ix),a
   3F80 DD 7E 07      [19]  584 	ld	a,7 (ix)
   3F83 CE 40         [ 7]  585 	adc	a, #0x40
   3F85 DD 77 07      [19]  586 	ld	7 (ix),a
                            587 ;src/StringUtils.c:148: position-=80;
   3F88 DD 7E 06      [19]  588 	ld	a,6 (ix)
   3F8B C6 B0         [ 7]  589 	add	a,#0xB0
   3F8D DD 77 06      [19]  590 	ld	6 (ix),a
   3F90 DD 7E 07      [19]  591 	ld	a,7 (ix)
   3F93 CE FF         [ 7]  592 	adc	a,#0xFF
   3F95 DD 77 07      [19]  593 	ld	7 (ix),a
   3F98 C3 47 3E      [10]  594 	jp	00110$
   3F9B                     595 00113$:
   3F9B DD F9         [10]  596 	ld	sp, ix
   3F9D DD E1         [14]  597 	pop	ix
   3F9F C9            [10]  598 	ret
                            599 ;src/StringUtils.c:154: void print_transparent_text(void* const text, u8* position, u8 fg){
                            600 ;	---------------------------------
                            601 ; Function print_transparent_text
                            602 ; ---------------------------------
   3FA0                     603 _print_transparent_text::
   3FA0 DD E5         [15]  604 	push	ix
   3FA2 DD 21 00 00   [14]  605 	ld	ix,#0
   3FA6 DD 39         [15]  606 	add	ix,sp
   3FA8 21 F8 FF      [10]  607 	ld	hl,#-8
   3FAB 39            [11]  608 	add	hl,sp
   3FAC F9            [ 6]  609 	ld	sp,hl
                            610 ;src/StringUtils.c:155: u8 val, charBitArray, spritePos, color = g_colors[fg];
   3FAD 01 66 1A      [10]  611 	ld	bc,#_g_colors+0
   3FB0 DD 6E 08      [19]  612 	ld	l,8 (ix)
   3FB3 26 00         [ 7]  613 	ld	h,#0x00
   3FB5 09            [11]  614 	add	hl,bc
   3FB6 4E            [ 7]  615 	ld	c,(hl)
                            616 ;src/StringUtils.c:161: (position)+=0x2800;
   3FB7 DD 7E 06      [19]  617 	ld	a,6 (ix)
   3FBA C6 00         [ 7]  618 	add	a, #0x00
   3FBC DD 77 06      [19]  619 	ld	6 (ix),a
   3FBF DD 7E 07      [19]  620 	ld	a,7 (ix)
   3FC2 CE 28         [ 7]  621 	adc	a, #0x28
   3FC4 DD 77 07      [19]  622 	ld	7 (ix),a
                            623 ;src/StringUtils.c:162: if(position<0x2800){
   3FC7 DD 46 06      [19]  624 	ld	b,6 (ix)
   3FCA DD 5E 07      [19]  625 	ld	e,7 (ix)
   3FCD 7B            [ 4]  626 	ld	a,e
   3FCE D6 28         [ 7]  627 	sub	a, #0x28
   3FD0 30 20         [12]  628 	jr	NC,00132$
                            629 ;src/StringUtils.c:163: position-=0x4000;
   3FD2 DD 7E 06      [19]  630 	ld	a,6 (ix)
   3FD5 C6 00         [ 7]  631 	add	a,#0x00
   3FD7 DD 77 06      [19]  632 	ld	6 (ix),a
   3FDA DD 7E 07      [19]  633 	ld	a,7 (ix)
   3FDD CE C0         [ 7]  634 	adc	a,#0xC0
   3FDF DD 77 07      [19]  635 	ld	7 (ix),a
                            636 ;src/StringUtils.c:164: position+=80;
   3FE2 DD 7E 06      [19]  637 	ld	a,6 (ix)
   3FE5 C6 50         [ 7]  638 	add	a, #0x50
   3FE7 DD 77 06      [19]  639 	ld	6 (ix),a
   3FEA DD 7E 07      [19]  640 	ld	a,7 (ix)
   3FED CE 00         [ 7]  641 	adc	a, #0x00
   3FEF DD 77 07      [19]  642 	ld	7 (ix),a
                            643 ;src/StringUtils.c:167: while(height){
   3FF2                     644 00132$:
   3FF2 79            [ 4]  645 	ld	a,c
   3FF3 E6 AA         [ 7]  646 	and	a, #0xAA
   3FF5 DD 77 FA      [19]  647 	ld	-6 (ix),a
   3FF8 79            [ 4]  648 	ld	a,c
   3FF9 E6 55         [ 7]  649 	and	a, #0x55
   3FFB DD 77 FB      [19]  650 	ld	-5 (ix),a
   3FFE DD 36 F8 06   [19]  651 	ld	-8 (ix),#0x06
   4002 DD 36 F9 96   [19]  652 	ld	-7 (ix),#0x96
   4006                     653 00118$:
   4006 DD 7E F8      [19]  654 	ld	a,-8 (ix)
   4009 B7            [ 4]  655 	or	a, a
   400A CA F2 40      [10]  656 	jp	Z,00121$
                            657 ;src/StringUtils.c:168: currentChar=text;
   400D DD 7E 04      [19]  658 	ld	a,4 (ix)
   4010 DD 77 FE      [19]  659 	ld	-2 (ix),a
   4013 DD 7E 05      [19]  660 	ld	a,5 (ix)
   4016 DD 77 FF      [19]  661 	ld	-1 (ix),a
                            662 ;src/StringUtils.c:169: currentPos=position;
   4019 DD 7E 06      [19]  663 	ld	a,6 (ix)
   401C DD 77 FC      [19]  664 	ld	-4 (ix),a
   401F DD 7E 07      [19]  665 	ld	a,7 (ix)
   4022 DD 77 FD      [19]  666 	ld	-3 (ix),a
                            667 ;src/StringUtils.c:170: --height;
   4025 DD 7E F9      [19]  668 	ld	a,-7 (ix)
   4028 C6 E7         [ 7]  669 	add	a,#0xE7
   402A DD 77 F9      [19]  670 	ld	-7 (ix),a
   402D DD 35 F8      [23]  671 	dec	-8 (ix)
                            672 ;src/StringUtils.c:171: while(*currentChar){
   4030                     673 00113$:
   4030 DD 6E FE      [19]  674 	ld	l,-2 (ix)
   4033 DD 66 FF      [19]  675 	ld	h,-1 (ix)
   4036 4E            [ 7]  676 	ld	c,(hl)
   4037 79            [ 4]  677 	ld	a,c
   4038 B7            [ 4]  678 	or	a, a
   4039 CA BA 40      [10]  679 	jp	Z,00115$
                            680 ;src/StringUtils.c:173: spritePos = charArray[(*currentChar)];
   403C 21 3C 3D      [10]  681 	ld	hl,#_charArray
   403F 06 00         [ 7]  682 	ld	b,#0x00
   4041 09            [11]  683 	add	hl, bc
   4042 46            [ 7]  684 	ld	b,(hl)
                            685 ;src/StringUtils.c:175: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   4043 78            [ 4]  686 	ld	a, b
   4044 CB 3F         [ 8]  687 	srl	a
   4046 DD 86 F9      [19]  688 	add	a, -7 (ix)
   4049 5F            [ 4]  689 	ld	e,a
   404A 21 C7 5A      [10]  690 	ld	hl,#_typography_4x6_monospaced
   404D 16 00         [ 7]  691 	ld	d,#0x00
   404F 19            [11]  692 	add	hl, de
   4050 4E            [ 7]  693 	ld	c,(hl)
                            694 ;src/StringUtils.c:177: if(spritePos%2) charBitArray<<=4;
   4051 CB 40         [ 8]  695 	bit	0, b
   4053 28 08         [12]  696 	jr	Z,00104$
   4055 79            [ 4]  697 	ld	a,c
   4056 07            [ 4]  698 	rlca
   4057 07            [ 4]  699 	rlca
   4058 07            [ 4]  700 	rlca
   4059 07            [ 4]  701 	rlca
   405A E6 F0         [ 7]  702 	and	a,#0xF0
   405C 4F            [ 4]  703 	ld	c,a
   405D                     704 00104$:
                            705 ;src/StringUtils.c:179: val=*currentPos;
   405D DD 6E FC      [19]  706 	ld	l,-4 (ix)
   4060 DD 66 FD      [19]  707 	ld	h,-3 (ix)
   4063 5E            [ 7]  708 	ld	e,(hl)
                            709 ;src/StringUtils.c:181: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
   4064 CB 79         [ 8]  710 	bit	7, c
   4066 28 07         [12]  711 	jr	Z,00106$
   4068 7B            [ 4]  712 	ld	a,e
   4069 E6 55         [ 7]  713 	and	a, #0x55
   406B DD B6 FA      [19]  714 	or	a, -6 (ix)
   406E 5F            [ 4]  715 	ld	e,a
   406F                     716 00106$:
                            717 ;src/StringUtils.c:183: charBitArray<<=1;
   406F CB 21         [ 8]  718 	sla	c
                            719 ;src/StringUtils.c:185: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
   4071 CB 79         [ 8]  720 	bit	7, c
   4073 28 07         [12]  721 	jr	Z,00108$
   4075 7B            [ 4]  722 	ld	a,e
   4076 E6 AA         [ 7]  723 	and	a, #0xAA
   4078 DD B6 FB      [19]  724 	or	a, -5 (ix)
   407B 5F            [ 4]  725 	ld	e,a
   407C                     726 00108$:
                            727 ;src/StringUtils.c:187: charBitArray<<=1;
   407C CB 21         [ 8]  728 	sla	c
                            729 ;src/StringUtils.c:189: *currentPos=val;
   407E DD 6E FC      [19]  730 	ld	l,-4 (ix)
   4081 DD 66 FD      [19]  731 	ld	h,-3 (ix)
   4084 73            [ 7]  732 	ld	(hl),e
                            733 ;src/StringUtils.c:190: ++currentPos;
   4085 DD 5E FC      [19]  734 	ld	e,-4 (ix)
   4088 DD 56 FD      [19]  735 	ld	d,-3 (ix)
   408B 13            [ 6]  736 	inc	de
                            737 ;src/StringUtils.c:192: val=*currentPos;
   408C 1A            [ 7]  738 	ld	a,(de)
   408D 47            [ 4]  739 	ld	b,a
                            740 ;src/StringUtils.c:194: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
   408E CB 79         [ 8]  741 	bit	7, c
   4090 28 07         [12]  742 	jr	Z,00110$
   4092 78            [ 4]  743 	ld	a,b
   4093 E6 55         [ 7]  744 	and	a, #0x55
   4095 DD B6 FA      [19]  745 	or	a, -6 (ix)
   4098 47            [ 4]  746 	ld	b,a
   4099                     747 00110$:
                            748 ;src/StringUtils.c:196: charBitArray<<=1;
   4099 79            [ 4]  749 	ld	a,c
   409A 87            [ 4]  750 	add	a, a
                            751 ;src/StringUtils.c:198: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
   409B 07            [ 4]  752 	rlca
   409C 30 07         [12]  753 	jr	NC,00112$
   409E 78            [ 4]  754 	ld	a,b
   409F E6 AA         [ 7]  755 	and	a, #0xAA
   40A1 DD B6 FB      [19]  756 	or	a, -5 (ix)
   40A4 47            [ 4]  757 	ld	b,a
   40A5                     758 00112$:
                            759 ;src/StringUtils.c:202: *currentPos=val;
   40A5 78            [ 4]  760 	ld	a,b
   40A6 12            [ 7]  761 	ld	(de),a
                            762 ;src/StringUtils.c:203: ++currentPos;
   40A7 13            [ 6]  763 	inc	de
   40A8 DD 73 FC      [19]  764 	ld	-4 (ix),e
   40AB DD 72 FD      [19]  765 	ld	-3 (ix),d
                            766 ;src/StringUtils.c:205: ++currentChar;
   40AE DD 34 FE      [23]  767 	inc	-2 (ix)
   40B1 C2 30 40      [10]  768 	jp	NZ,00113$
   40B4 DD 34 FF      [23]  769 	inc	-1 (ix)
   40B7 C3 30 40      [10]  770 	jp	00113$
   40BA                     771 00115$:
                            772 ;src/StringUtils.c:207: position-=0x0800;
   40BA DD 7E 06      [19]  773 	ld	a,6 (ix)
   40BD C6 00         [ 7]  774 	add	a,#0x00
   40BF DD 77 06      [19]  775 	ld	6 (ix),a
   40C2 DD 7E 07      [19]  776 	ld	a,7 (ix)
   40C5 CE F8         [ 7]  777 	adc	a,#0xF8
                            778 ;src/StringUtils.c:209: if(position<0xC000){
   40C7 DD 77 07      [19]  779 	ld	7 (ix), a
   40CA D6 C0         [ 7]  780 	sub	a, #0xC0
   40CC D2 06 40      [10]  781 	jp	NC,00118$
                            782 ;src/StringUtils.c:210: position+=0x4000;
   40CF DD 7E 06      [19]  783 	ld	a,6 (ix)
   40D2 C6 00         [ 7]  784 	add	a, #0x00
   40D4 DD 77 06      [19]  785 	ld	6 (ix),a
   40D7 DD 7E 07      [19]  786 	ld	a,7 (ix)
   40DA CE 40         [ 7]  787 	adc	a, #0x40
   40DC DD 77 07      [19]  788 	ld	7 (ix),a
                            789 ;src/StringUtils.c:211: position-=80;
   40DF DD 7E 06      [19]  790 	ld	a,6 (ix)
   40E2 C6 B0         [ 7]  791 	add	a,#0xB0
   40E4 DD 77 06      [19]  792 	ld	6 (ix),a
   40E7 DD 7E 07      [19]  793 	ld	a,7 (ix)
   40EA CE FF         [ 7]  794 	adc	a,#0xFF
   40EC DD 77 07      [19]  795 	ld	7 (ix),a
   40EF C3 06 40      [10]  796 	jp	00118$
   40F2                     797 00121$:
   40F2 DD F9         [10]  798 	ld	sp, ix
   40F4 DD E1         [14]  799 	pop	ix
   40F6 C9            [10]  800 	ret
                            801 	.area _CODE
                            802 	.area _INITIALIZER
                            803 	.area _CABS (ABS)
