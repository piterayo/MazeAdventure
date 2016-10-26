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
   3C84                      51 _integer_to_string::
   3C84 DD E5         [15]   52 	push	ix
   3C86 DD 21 00 00   [14]   53 	ld	ix,#0
   3C8A DD 39         [15]   54 	add	ix,sp
                             55 ;src/StringUtils.c:36: u8* charPosition=(u8*)&i_to_s_buffer;
   3C8C 01 E2 3D      [10]   56 	ld	bc,#_i_to_s_buffer+0
                             57 ;src/StringUtils.c:38: switch(format){
   3C8F DD 7E 05      [19]   58 	ld	a,5 (ix)
   3C92 D6 62         [ 7]   59 	sub	a, #0x62
   3C94 28 45         [12]   60 	jr	Z,00102$
   3C96 DD 7E 05      [19]   61 	ld	a,5 (ix)
   3C99 D6 68         [ 7]   62 	sub	a, #0x68
   3C9B 20 57         [12]   63 	jr	NZ,00106$
                             64 ;src/StringUtils.c:40: charPosition+=2;
   3C9D 11 E4 3D      [10]   65 	ld	de,#_i_to_s_buffer + 2
                             66 ;src/StringUtils.c:42: *charPosition = 0;
   3CA0 AF            [ 4]   67 	xor	a, a
   3CA1 12            [ 7]   68 	ld	(de),a
                             69 ;src/StringUtils.c:44: --charPosition;
   3CA2 1B            [ 6]   70 	dec	de
                             71 ;src/StringUtils.c:46: t=n&0x0F;
   3CA3 DD 7E 04      [19]   72 	ld	a,4 (ix)
   3CA6 E6 0F         [ 7]   73 	and	a, #0x0F
   3CA8 6F            [ 4]   74 	ld	l,a
                             75 ;src/StringUtils.c:47: t=t>9?t+55:t+48;
   3CA9 3E 09         [ 7]   76 	ld	a,#0x09
   3CAB 95            [ 4]   77 	sub	a, l
   3CAC 30 05         [12]   78 	jr	NC,00110$
   3CAE 7D            [ 4]   79 	ld	a,l
   3CAF C6 37         [ 7]   80 	add	a, #0x37
   3CB1 18 03         [12]   81 	jr	00111$
   3CB3                      82 00110$:
   3CB3 7D            [ 4]   83 	ld	a,l
   3CB4 C6 30         [ 7]   84 	add	a, #0x30
   3CB6                      85 00111$:
                             86 ;src/StringUtils.c:48: *charPosition=t;
   3CB6 12            [ 7]   87 	ld	(de),a
                             88 ;src/StringUtils.c:49: n>>=4;
   3CB7 DD 7E 04      [19]   89 	ld	a,4 (ix)
   3CBA 07            [ 4]   90 	rlca
   3CBB 07            [ 4]   91 	rlca
   3CBC 07            [ 4]   92 	rlca
   3CBD 07            [ 4]   93 	rlca
   3CBE E6 0F         [ 7]   94 	and	a,#0x0F
   3CC0 DD 77 04      [19]   95 	ld	4 (ix),a
                             96 ;src/StringUtils.c:50: --charPosition;
   3CC3 1B            [ 6]   97 	dec	de
                             98 ;src/StringUtils.c:52: t=n>9?n+55:n+48;
   3CC4 3E 09         [ 7]   99 	ld	a,#0x09
   3CC6 DD 96 04      [19]  100 	sub	a, 4 (ix)
   3CC9 30 07         [12]  101 	jr	NC,00112$
   3CCB DD 7E 04      [19]  102 	ld	a,4 (ix)
   3CCE C6 37         [ 7]  103 	add	a, #0x37
   3CD0 18 05         [12]  104 	jr	00113$
   3CD2                     105 00112$:
   3CD2 DD 7E 04      [19]  106 	ld	a,4 (ix)
   3CD5 C6 30         [ 7]  107 	add	a, #0x30
   3CD7                     108 00113$:
                            109 ;src/StringUtils.c:53: *charPosition=t;
   3CD7 12            [ 7]  110 	ld	(de),a
                            111 ;src/StringUtils.c:54: break;
   3CD8 C3 5D 3D      [10]  112 	jp	00107$
                            113 ;src/StringUtils.c:56: case 'b':{
   3CDB                     114 00102$:
                            115 ;src/StringUtils.c:58: charPosition+=8;
   3CDB 21 EA 3D      [10]  116 	ld	hl,#_i_to_s_buffer + 8
                            117 ;src/StringUtils.c:60: while(t){
   3CDE 1E 08         [ 7]  118 	ld	e,#0x08
   3CE0                     119 00103$:
   3CE0 7B            [ 4]  120 	ld	a,e
   3CE1 B7            [ 4]  121 	or	a, a
   3CE2 28 79         [12]  122 	jr	Z,00107$
                            123 ;src/StringUtils.c:61: --t;
   3CE4 1D            [ 4]  124 	dec	e
                            125 ;src/StringUtils.c:62: --charPosition;
   3CE5 2B            [ 6]  126 	dec	hl
                            127 ;src/StringUtils.c:63: *charPosition=(n&1)+48;
   3CE6 DD 7E 04      [19]  128 	ld	a,4 (ix)
   3CE9 E6 01         [ 7]  129 	and	a, #0x01
   3CEB C6 30         [ 7]  130 	add	a, #0x30
   3CED 77            [ 7]  131 	ld	(hl),a
                            132 ;src/StringUtils.c:64: n>>=1;
   3CEE DD CB 04 3E   [23]  133 	srl	4 (ix)
   3CF2 18 EC         [12]  134 	jr	00103$
                            135 ;src/StringUtils.c:68: default:{
   3CF4                     136 00106$:
                            137 ;src/StringUtils.c:69: charPosition+=3;
   3CF4 11 E5 3D      [10]  138 	ld	de,#_i_to_s_buffer + 3
                            139 ;src/StringUtils.c:71: *charPosition = 0;
   3CF7 AF            [ 4]  140 	xor	a, a
   3CF8 12            [ 7]  141 	ld	(de),a
                            142 ;src/StringUtils.c:73: --charPosition;
   3CF9 1B            [ 6]  143 	dec	de
                            144 ;src/StringUtils.c:75: *charPosition=48+(n%10);
   3CFA C5            [11]  145 	push	bc
   3CFB D5            [11]  146 	push	de
   3CFC 3E 0A         [ 7]  147 	ld	a,#0x0A
   3CFE F5            [11]  148 	push	af
   3CFF 33            [ 6]  149 	inc	sp
   3D00 DD 7E 04      [19]  150 	ld	a,4 (ix)
   3D03 F5            [11]  151 	push	af
   3D04 33            [ 6]  152 	inc	sp
   3D05 CD 39 7A      [17]  153 	call	__moduchar
   3D08 F1            [10]  154 	pop	af
   3D09 D1            [10]  155 	pop	de
   3D0A C1            [10]  156 	pop	bc
   3D0B 7D            [ 4]  157 	ld	a,l
   3D0C C6 30         [ 7]  158 	add	a, #0x30
   3D0E 12            [ 7]  159 	ld	(de),a
                            160 ;src/StringUtils.c:76: --charPosition;
                            161 ;src/StringUtils.c:77: n/=10;
   3D0F C5            [11]  162 	push	bc
   3D10 3E 0A         [ 7]  163 	ld	a,#0x0A
   3D12 F5            [11]  164 	push	af
   3D13 33            [ 6]  165 	inc	sp
   3D14 DD 7E 04      [19]  166 	ld	a,4 (ix)
   3D17 F5            [11]  167 	push	af
   3D18 33            [ 6]  168 	inc	sp
   3D19 CD C2 78      [17]  169 	call	__divuchar
   3D1C F1            [10]  170 	pop	af
   3D1D C1            [10]  171 	pop	bc
   3D1E DD 75 04      [19]  172 	ld	4 (ix),l
                            173 ;src/StringUtils.c:78: *charPosition=48+(n%10);
   3D21 C5            [11]  174 	push	bc
   3D22 3E 0A         [ 7]  175 	ld	a,#0x0A
   3D24 F5            [11]  176 	push	af
   3D25 33            [ 6]  177 	inc	sp
   3D26 DD 7E 04      [19]  178 	ld	a,4 (ix)
   3D29 F5            [11]  179 	push	af
   3D2A 33            [ 6]  180 	inc	sp
   3D2B CD 39 7A      [17]  181 	call	__moduchar
   3D2E F1            [10]  182 	pop	af
   3D2F C1            [10]  183 	pop	bc
   3D30 7D            [ 4]  184 	ld	a,l
   3D31 C6 30         [ 7]  185 	add	a, #0x30
   3D33 32 E3 3D      [13]  186 	ld	(#(_i_to_s_buffer + 0x0001)),a
                            187 ;src/StringUtils.c:79: --charPosition;
                            188 ;src/StringUtils.c:80: n/=10;
   3D36 C5            [11]  189 	push	bc
   3D37 3E 0A         [ 7]  190 	ld	a,#0x0A
   3D39 F5            [11]  191 	push	af
   3D3A 33            [ 6]  192 	inc	sp
   3D3B DD 7E 04      [19]  193 	ld	a,4 (ix)
   3D3E F5            [11]  194 	push	af
   3D3F 33            [ 6]  195 	inc	sp
   3D40 CD C2 78      [17]  196 	call	__divuchar
   3D43 F1            [10]  197 	pop	af
   3D44 C1            [10]  198 	pop	bc
   3D45 DD 75 04      [19]  199 	ld	4 (ix),l
                            200 ;src/StringUtils.c:81: *charPosition=48+(n%10);
   3D48 C5            [11]  201 	push	bc
   3D49 3E 0A         [ 7]  202 	ld	a,#0x0A
   3D4B F5            [11]  203 	push	af
   3D4C 33            [ 6]  204 	inc	sp
   3D4D DD 7E 04      [19]  205 	ld	a,4 (ix)
   3D50 F5            [11]  206 	push	af
   3D51 33            [ 6]  207 	inc	sp
   3D52 CD 39 7A      [17]  208 	call	__moduchar
   3D55 F1            [10]  209 	pop	af
   3D56 C1            [10]  210 	pop	bc
   3D57 7D            [ 4]  211 	ld	a,l
   3D58 C6 30         [ 7]  212 	add	a, #0x30
   3D5A 32 E2 3D      [13]  213 	ld	(#_i_to_s_buffer),a
                            214 ;src/StringUtils.c:84: }
   3D5D                     215 00107$:
                            216 ;src/StringUtils.c:86: return i_to_s_buffer;
   3D5D 69            [ 4]  217 	ld	l, c
   3D5E 60            [ 4]  218 	ld	h, b
   3D5F DD E1         [14]  219 	pop	ix
   3D61 C9            [10]  220 	ret
   3D62                     221 _charArray:
   3D62 29                  222 	.db #0x29	; 41
   3D63 29                  223 	.db #0x29	; 41
   3D64 29                  224 	.db #0x29	; 41
   3D65 29                  225 	.db #0x29	; 41
   3D66 29                  226 	.db #0x29	; 41
   3D67 29                  227 	.db #0x29	; 41
   3D68 29                  228 	.db #0x29	; 41
   3D69 29                  229 	.db #0x29	; 41
   3D6A 29                  230 	.db #0x29	; 41
   3D6B 29                  231 	.db #0x29	; 41
   3D6C 29                  232 	.db #0x29	; 41
   3D6D 29                  233 	.db #0x29	; 41
   3D6E 29                  234 	.db #0x29	; 41
   3D6F 29                  235 	.db #0x29	; 41
   3D70 29                  236 	.db #0x29	; 41
   3D71 29                  237 	.db #0x29	; 41
   3D72 29                  238 	.db #0x29	; 41
   3D73 29                  239 	.db #0x29	; 41
   3D74 29                  240 	.db #0x29	; 41
   3D75 29                  241 	.db #0x29	; 41
   3D76 29                  242 	.db #0x29	; 41
   3D77 29                  243 	.db #0x29	; 41
   3D78 29                  244 	.db #0x29	; 41
   3D79 29                  245 	.db #0x29	; 41
   3D7A 29                  246 	.db #0x29	; 41
   3D7B 29                  247 	.db #0x29	; 41
   3D7C 29                  248 	.db #0x29	; 41
   3D7D 29                  249 	.db #0x29	; 41
   3D7E 29                  250 	.db #0x29	; 41
   3D7F 29                  251 	.db #0x29	; 41
   3D80 29                  252 	.db #0x29	; 41
   3D81 29                  253 	.db #0x29	; 41
   3D82 29                  254 	.db #0x29	; 41
   3D83 24                  255 	.db #0x24	; 36
   3D84 29                  256 	.db #0x29	; 41
   3D85 2D                  257 	.db #0x2D	; 45
   3D86 2F                  258 	.db #0x2F	; 47
   3D87 29                  259 	.db #0x29	; 41
   3D88 2E                  260 	.db #0x2E	; 46
   3D89 29                  261 	.db #0x29	; 41
   3D8A 29                  262 	.db #0x29	; 41
   3D8B 29                  263 	.db #0x29	; 41
   3D8C 31                  264 	.db #0x31	; 49	'1'
   3D8D 2C                  265 	.db #0x2C	; 44
   3D8E 29                  266 	.db #0x29	; 41
   3D8F 29                  267 	.db #0x29	; 41
   3D90 26                  268 	.db #0x26	; 38
   3D91 29                  269 	.db #0x29	; 41
   3D92 1A                  270 	.db #0x1A	; 26
   3D93 1B                  271 	.db #0x1B	; 27
   3D94 1C                  272 	.db #0x1C	; 28
   3D95 1D                  273 	.db #0x1D	; 29
   3D96 1E                  274 	.db #0x1E	; 30
   3D97 1F                  275 	.db #0x1F	; 31
   3D98 20                  276 	.db #0x20	; 32
   3D99 21                  277 	.db #0x21	; 33
   3D9A 22                  278 	.db #0x22	; 34
   3D9B 23                  279 	.db #0x23	; 35
   3D9C 27                  280 	.db #0x27	; 39
   3D9D 29                  281 	.db #0x29	; 41
   3D9E 2A                  282 	.db #0x2A	; 42
   3D9F 29                  283 	.db #0x29	; 41
   3DA0 2B                  284 	.db #0x2B	; 43
   3DA1 25                  285 	.db #0x25	; 37
   3DA2 28                  286 	.db #0x28	; 40
   3DA3 00                  287 	.db #0x00	; 0
   3DA4 01                  288 	.db #0x01	; 1
   3DA5 02                  289 	.db #0x02	; 2
   3DA6 03                  290 	.db #0x03	; 3
   3DA7 04                  291 	.db #0x04	; 4
   3DA8 05                  292 	.db #0x05	; 5
   3DA9 06                  293 	.db #0x06	; 6
   3DAA 07                  294 	.db #0x07	; 7
   3DAB 08                  295 	.db #0x08	; 8
   3DAC 09                  296 	.db #0x09	; 9
   3DAD 0A                  297 	.db #0x0A	; 10
   3DAE 0B                  298 	.db #0x0B	; 11
   3DAF 0C                  299 	.db #0x0C	; 12
   3DB0 0D                  300 	.db #0x0D	; 13
   3DB1 0E                  301 	.db #0x0E	; 14
   3DB2 0F                  302 	.db #0x0F	; 15
   3DB3 10                  303 	.db #0x10	; 16
   3DB4 11                  304 	.db #0x11	; 17
   3DB5 12                  305 	.db #0x12	; 18
   3DB6 13                  306 	.db #0x13	; 19
   3DB7 14                  307 	.db #0x14	; 20
   3DB8 15                  308 	.db #0x15	; 21
   3DB9 16                  309 	.db #0x16	; 22
   3DBA 17                  310 	.db #0x17	; 23
   3DBB 18                  311 	.db #0x18	; 24
   3DBC 19                  312 	.db #0x19	; 25
   3DBD 29                  313 	.db #0x29	; 41
   3DBE 29                  314 	.db #0x29	; 41
   3DBF 29                  315 	.db #0x29	; 41
   3DC0 29                  316 	.db #0x29	; 41
   3DC1 29                  317 	.db #0x29	; 41
   3DC2 29                  318 	.db #0x29	; 41
   3DC3 00                  319 	.db #0x00	; 0
   3DC4 01                  320 	.db #0x01	; 1
   3DC5 02                  321 	.db #0x02	; 2
   3DC6 03                  322 	.db #0x03	; 3
   3DC7 04                  323 	.db #0x04	; 4
   3DC8 05                  324 	.db #0x05	; 5
   3DC9 06                  325 	.db #0x06	; 6
   3DCA 07                  326 	.db #0x07	; 7
   3DCB 08                  327 	.db #0x08	; 8
   3DCC 09                  328 	.db #0x09	; 9
   3DCD 0A                  329 	.db #0x0A	; 10
   3DCE 0B                  330 	.db #0x0B	; 11
   3DCF 0C                  331 	.db #0x0C	; 12
   3DD0 0D                  332 	.db #0x0D	; 13
   3DD1 0E                  333 	.db #0x0E	; 14
   3DD2 0F                  334 	.db #0x0F	; 15
   3DD3 10                  335 	.db #0x10	; 16
   3DD4 11                  336 	.db #0x11	; 17
   3DD5 12                  337 	.db #0x12	; 18
   3DD6 13                  338 	.db #0x13	; 19
   3DD7 14                  339 	.db #0x14	; 20
   3DD8 15                  340 	.db #0x15	; 21
   3DD9 16                  341 	.db #0x16	; 22
   3DDA 17                  342 	.db #0x17	; 23
   3DDB 18                  343 	.db #0x18	; 24
   3DDC 19                  344 	.db #0x19	; 25
   3DDD 29                  345 	.db #0x29	; 41
   3DDE 29                  346 	.db #0x29	; 41
   3DDF 29                  347 	.db #0x29	; 41
   3DE0 30                  348 	.db #0x30	; 48	'0'
   3DE1 29                  349 	.db #0x29	; 41
   3DE2                     350 _i_to_s_buffer:
   3DE2 00                  351 	.db #0x00	; 0
   3DE3 00                  352 	.db #0x00	; 0
   3DE4 00                  353 	.db #0x00	; 0
   3DE5 00                  354 	.db #0x00	; 0
   3DE6 00                  355 	.db #0x00	; 0
   3DE7 00                  356 	.db #0x00	; 0
   3DE8 00                  357 	.db #0x00	; 0
   3DE9 00                  358 	.db #0x00	; 0
   3DEA 00                  359 	.db #0x00	; 0
                            360 ;src/StringUtils.c:90: void print_text(void * const text, u8* position, u8 bg, u8 fg){
                            361 ;	---------------------------------
                            362 ; Function print_text
                            363 ; ---------------------------------
   3DEB                     364 _print_text::
   3DEB DD E5         [15]  365 	push	ix
   3DED DD 21 00 00   [14]  366 	ld	ix,#0
   3DF1 DD 39         [15]  367 	add	ix,sp
   3DF3 21 EF FF      [10]  368 	ld	hl,#-17
   3DF6 39            [11]  369 	add	hl,sp
   3DF7 F9            [ 6]  370 	ld	sp,hl
                            371 ;src/StringUtils.c:91: u8 val, charBitArray, spritePos, fgColor=g_colors[fg], bgColor=g_colors[bg];
   3DF8 DD 7E 09      [19]  372 	ld	a,9 (ix)
   3DFB C6 AF         [ 7]  373 	add	a, #<(_g_colors)
   3DFD DD 77 F9      [19]  374 	ld	-7 (ix),a
   3E00 3E 00         [ 7]  375 	ld	a,#0x00
   3E02 CE 1A         [ 7]  376 	adc	a, #>(_g_colors)
   3E04 DD 77 FA      [19]  377 	ld	-6 (ix),a
   3E07 DD 6E F9      [19]  378 	ld	l,-7 (ix)
   3E0A DD 66 FA      [19]  379 	ld	h,-6 (ix)
   3E0D 7E            [ 7]  380 	ld	a,(hl)
   3E0E DD 77 F3      [19]  381 	ld	-13 (ix),a
   3E11 3E AF         [ 7]  382 	ld	a,#<(_g_colors)
   3E13 DD 86 08      [19]  383 	add	a, 8 (ix)
   3E16 DD 77 F9      [19]  384 	ld	-7 (ix),a
   3E19 3E 1A         [ 7]  385 	ld	a,#>(_g_colors)
   3E1B CE 00         [ 7]  386 	adc	a, #0x00
   3E1D DD 77 FA      [19]  387 	ld	-6 (ix),a
   3E20 DD 6E F9      [19]  388 	ld	l,-7 (ix)
   3E23 DD 66 FA      [19]  389 	ld	h,-6 (ix)
   3E26 7E            [ 7]  390 	ld	a,(hl)
   3E27 DD 77 F2      [19]  391 	ld	-14 (ix),a
                            392 ;src/StringUtils.c:97: (position)+=0x2800;
   3E2A DD 7E 06      [19]  393 	ld	a,6 (ix)
   3E2D C6 00         [ 7]  394 	add	a, #0x00
   3E2F DD 77 06      [19]  395 	ld	6 (ix),a
   3E32 DD 7E 07      [19]  396 	ld	a,7 (ix)
   3E35 CE 28         [ 7]  397 	adc	a, #0x28
   3E37 DD 77 07      [19]  398 	ld	7 (ix),a
                            399 ;src/StringUtils.c:98: if(position<0x2800){
   3E3A DD 4E 06      [19]  400 	ld	c,6 (ix)
   3E3D DD 46 07      [19]  401 	ld	b,7 (ix)
   3E40 78            [ 4]  402 	ld	a,b
   3E41 D6 28         [ 7]  403 	sub	a, #0x28
   3E43 30 20         [12]  404 	jr	NC,00132$
                            405 ;src/StringUtils.c:99: position-=0x4000;
   3E45 DD 7E 06      [19]  406 	ld	a,6 (ix)
   3E48 C6 00         [ 7]  407 	add	a,#0x00
   3E4A DD 77 06      [19]  408 	ld	6 (ix),a
   3E4D DD 7E 07      [19]  409 	ld	a,7 (ix)
   3E50 CE C0         [ 7]  410 	adc	a,#0xC0
   3E52 DD 77 07      [19]  411 	ld	7 (ix),a
                            412 ;src/StringUtils.c:100: position+=80;
   3E55 DD 7E 06      [19]  413 	ld	a,6 (ix)
   3E58 C6 50         [ 7]  414 	add	a, #0x50
   3E5A DD 77 06      [19]  415 	ld	6 (ix),a
   3E5D DD 7E 07      [19]  416 	ld	a,7 (ix)
   3E60 CE 00         [ 7]  417 	adc	a, #0x00
   3E62 DD 77 07      [19]  418 	ld	7 (ix),a
                            419 ;src/StringUtils.c:103: while(height){
   3E65                     420 00132$:
   3E65 DD 36 EF 06   [19]  421 	ld	-17 (ix),#0x06
   3E69 DD 36 F9 96   [19]  422 	ld	-7 (ix),#0x96
   3E6D                     423 00110$:
   3E6D DD 7E EF      [19]  424 	ld	a,-17 (ix)
   3E70 B7            [ 4]  425 	or	a, a
   3E71 CA C1 3F      [10]  426 	jp	Z,00113$
                            427 ;src/StringUtils.c:104: --height;
   3E74 DD 7E F9      [19]  428 	ld	a,-7 (ix)
   3E77 C6 E7         [ 7]  429 	add	a,#0xE7
   3E79 DD 77 F9      [19]  430 	ld	-7 (ix),a
   3E7C DD 35 EF      [23]  431 	dec	-17 (ix)
                            432 ;src/StringUtils.c:105: currentChar=text;
   3E7F DD 7E 04      [19]  433 	ld	a,4 (ix)
   3E82 DD 77 F7      [19]  434 	ld	-9 (ix),a
   3E85 DD 7E 05      [19]  435 	ld	a,5 (ix)
   3E88 DD 77 F8      [19]  436 	ld	-8 (ix),a
                            437 ;src/StringUtils.c:106: currentPos=position;
   3E8B DD 7E 06      [19]  438 	ld	a,6 (ix)
   3E8E DD 77 FE      [19]  439 	ld	-2 (ix),a
   3E91 DD 7E 07      [19]  440 	ld	a,7 (ix)
   3E94 DD 77 FF      [19]  441 	ld	-1 (ix),a
                            442 ;src/StringUtils.c:108: while(*currentChar){
   3E97                     443 00105$:
   3E97 DD 6E F7      [19]  444 	ld	l,-9 (ix)
   3E9A DD 66 F8      [19]  445 	ld	h,-8 (ix)
   3E9D 7E            [ 7]  446 	ld	a,(hl)
   3E9E DD 77 FD      [19]  447 	ld	-3 (ix), a
   3EA1 B7            [ 4]  448 	or	a, a
   3EA2 CA 89 3F      [10]  449 	jp	Z,00107$
                            450 ;src/StringUtils.c:110: spritePos = charArray[(*currentChar)];
   3EA5 3E 62         [ 7]  451 	ld	a,#<(_charArray)
   3EA7 DD 86 FD      [19]  452 	add	a, -3 (ix)
   3EAA DD 77 FB      [19]  453 	ld	-5 (ix),a
   3EAD 3E 3D         [ 7]  454 	ld	a,#>(_charArray)
   3EAF CE 00         [ 7]  455 	adc	a, #0x00
   3EB1 DD 77 FC      [19]  456 	ld	-4 (ix),a
   3EB4 DD 6E FB      [19]  457 	ld	l,-5 (ix)
   3EB7 DD 66 FC      [19]  458 	ld	h,-4 (ix)
   3EBA 7E            [ 7]  459 	ld	a,(hl)
                            460 ;src/StringUtils.c:112: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   3EBB DD 77 F4      [19]  461 	ld	-12 (ix), a
   3EBE CB 3F         [ 8]  462 	srl	a
   3EC0 DD 77 FB      [19]  463 	ld	-5 (ix), a
   3EC3 DD 86 F9      [19]  464 	add	a, -7 (ix)
   3EC6 DD 77 FB      [19]  465 	ld	-5 (ix),a
   3EC9 C6 ED         [ 7]  466 	add	a,#<(_typography_4x6_monospaced)
   3ECB DD 77 FB      [19]  467 	ld	-5 (ix),a
   3ECE 3E 5A         [ 7]  468 	ld	a,#>(_typography_4x6_monospaced)
   3ED0 CE 00         [ 7]  469 	adc	a, #0x00
   3ED2 DD 77 FC      [19]  470 	ld	-4 (ix),a
   3ED5 DD 6E FB      [19]  471 	ld	l,-5 (ix)
   3ED8 DD 66 FC      [19]  472 	ld	h,-4 (ix)
   3EDB 7E            [ 7]  473 	ld	a,(hl)
   3EDC DD 77 FB      [19]  474 	ld	-5 (ix),a
                            475 ;src/StringUtils.c:114: if(spritePos%2) charBitArray<<=4;
   3EDF DD CB F4 46   [20]  476 	bit	0, -12 (ix)
   3EE3 28 0C         [12]  477 	jr	Z,00104$
   3EE5 DD 7E FB      [19]  478 	ld	a,-5 (ix)
   3EE8 07            [ 4]  479 	rlca
   3EE9 07            [ 4]  480 	rlca
   3EEA 07            [ 4]  481 	rlca
   3EEB 07            [ 4]  482 	rlca
   3EEC E6 F0         [ 7]  483 	and	a,#0xF0
   3EEE DD 77 FB      [19]  484 	ld	-5 (ix),a
   3EF1                     485 00104$:
                            486 ;src/StringUtils.c:118: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   3EF1 DD CB FB 7E   [20]  487 	bit	7, -5 (ix)
   3EF5 28 05         [12]  488 	jr	Z,00115$
   3EF7 DD 7E F3      [19]  489 	ld	a,-13 (ix)
   3EFA 18 03         [12]  490 	jr	00116$
   3EFC                     491 00115$:
   3EFC DD 7E F2      [19]  492 	ld	a,-14 (ix)
   3EFF                     493 00116$:
   3EFF E6 AA         [ 7]  494 	and	a, #0xAA
   3F01 4F            [ 4]  495 	ld	c,a
                            496 ;src/StringUtils.c:120: charBitArray<<=1;
   3F02 DD 7E FB      [19]  497 	ld	a,-5 (ix)
   3F05 87            [ 4]  498 	add	a, a
   3F06 47            [ 4]  499 	ld	b,a
                            500 ;src/StringUtils.c:122: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   3F07 CB 78         [ 8]  501 	bit	7, b
   3F09 28 05         [12]  502 	jr	Z,00117$
   3F0B DD 7E F3      [19]  503 	ld	a,-13 (ix)
   3F0E 18 03         [12]  504 	jr	00118$
   3F10                     505 00117$:
   3F10 DD 7E F2      [19]  506 	ld	a,-14 (ix)
   3F13                     507 00118$:
   3F13 E6 55         [ 7]  508 	and	a, #0x55
   3F15 B1            [ 4]  509 	or	a, c
   3F16 4F            [ 4]  510 	ld	c,a
                            511 ;src/StringUtils.c:124: charBitArray<<=1;
   3F17 78            [ 4]  512 	ld	a,b
   3F18 87            [ 4]  513 	add	a, a
   3F19 DD 77 F5      [19]  514 	ld	-11 (ix),a
                            515 ;src/StringUtils.c:126: *currentPos=val;
   3F1C DD 6E FE      [19]  516 	ld	l,-2 (ix)
   3F1F DD 66 FF      [19]  517 	ld	h,-1 (ix)
   3F22 71            [ 7]  518 	ld	(hl),c
                            519 ;src/StringUtils.c:127: ++currentPos;
   3F23 DD 7E FE      [19]  520 	ld	a,-2 (ix)
   3F26 C6 01         [ 7]  521 	add	a, #0x01
   3F28 DD 77 F0      [19]  522 	ld	-16 (ix),a
   3F2B DD 7E FF      [19]  523 	ld	a,-1 (ix)
   3F2E CE 00         [ 7]  524 	adc	a, #0x00
   3F30 DD 77 F1      [19]  525 	ld	-15 (ix),a
                            526 ;src/StringUtils.c:131: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   3F33 DD CB F5 7E   [20]  527 	bit	7, -11 (ix)
   3F37 28 05         [12]  528 	jr	Z,00119$
   3F39 DD 7E F3      [19]  529 	ld	a,-13 (ix)
   3F3C 18 03         [12]  530 	jr	00120$
   3F3E                     531 00119$:
   3F3E DD 7E F2      [19]  532 	ld	a,-14 (ix)
   3F41                     533 00120$:
   3F41 E6 AA         [ 7]  534 	and	a, #0xAA
   3F43 DD 77 F6      [19]  535 	ld	-10 (ix),a
                            536 ;src/StringUtils.c:133: charBitArray<<=1;
   3F46 DD 7E F5      [19]  537 	ld	a,-11 (ix)
   3F49 87            [ 4]  538 	add	a, a
                            539 ;src/StringUtils.c:135: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   3F4A 07            [ 4]  540 	rlca
   3F4B 30 05         [12]  541 	jr	NC,00121$
   3F4D DD 7E F3      [19]  542 	ld	a,-13 (ix)
   3F50 18 03         [12]  543 	jr	00122$
   3F52                     544 00121$:
   3F52 DD 7E F2      [19]  545 	ld	a,-14 (ix)
   3F55                     546 00122$:
   3F55 E6 55         [ 7]  547 	and	a, #0x55
   3F57 DD 77 FB      [19]  548 	ld	-5 (ix),a
   3F5A DD 7E F6      [19]  549 	ld	a,-10 (ix)
   3F5D DD B6 FB      [19]  550 	or	a, -5 (ix)
   3F60 DD 77 FB      [19]  551 	ld	-5 (ix),a
                            552 ;src/StringUtils.c:139: *currentPos=val;
   3F63 DD 6E F0      [19]  553 	ld	l,-16 (ix)
   3F66 DD 66 F1      [19]  554 	ld	h,-15 (ix)
   3F69 DD 7E FB      [19]  555 	ld	a,-5 (ix)
   3F6C 77            [ 7]  556 	ld	(hl),a
                            557 ;src/StringUtils.c:140: ++currentPos;
   3F6D DD 7E F0      [19]  558 	ld	a,-16 (ix)
   3F70 C6 01         [ 7]  559 	add	a, #0x01
   3F72 DD 77 FE      [19]  560 	ld	-2 (ix),a
   3F75 DD 7E F1      [19]  561 	ld	a,-15 (ix)
   3F78 CE 00         [ 7]  562 	adc	a, #0x00
   3F7A DD 77 FF      [19]  563 	ld	-1 (ix),a
                            564 ;src/StringUtils.c:142: ++currentChar;
   3F7D DD 34 F7      [23]  565 	inc	-9 (ix)
   3F80 C2 97 3E      [10]  566 	jp	NZ,00105$
   3F83 DD 34 F8      [23]  567 	inc	-8 (ix)
   3F86 C3 97 3E      [10]  568 	jp	00105$
   3F89                     569 00107$:
                            570 ;src/StringUtils.c:144: position-=0x0800;
   3F89 DD 7E 06      [19]  571 	ld	a,6 (ix)
   3F8C C6 00         [ 7]  572 	add	a,#0x00
   3F8E DD 77 06      [19]  573 	ld	6 (ix),a
   3F91 DD 7E 07      [19]  574 	ld	a,7 (ix)
   3F94 CE F8         [ 7]  575 	adc	a,#0xF8
                            576 ;src/StringUtils.c:146: if(position<0xC000){
   3F96 DD 77 07      [19]  577 	ld	7 (ix), a
   3F99 D6 C0         [ 7]  578 	sub	a, #0xC0
   3F9B D2 6D 3E      [10]  579 	jp	NC,00110$
                            580 ;src/StringUtils.c:147: position+=0x4000;
   3F9E DD 7E 06      [19]  581 	ld	a,6 (ix)
   3FA1 C6 00         [ 7]  582 	add	a, #0x00
   3FA3 DD 77 06      [19]  583 	ld	6 (ix),a
   3FA6 DD 7E 07      [19]  584 	ld	a,7 (ix)
   3FA9 CE 40         [ 7]  585 	adc	a, #0x40
   3FAB DD 77 07      [19]  586 	ld	7 (ix),a
                            587 ;src/StringUtils.c:148: position-=80;
   3FAE DD 7E 06      [19]  588 	ld	a,6 (ix)
   3FB1 C6 B0         [ 7]  589 	add	a,#0xB0
   3FB3 DD 77 06      [19]  590 	ld	6 (ix),a
   3FB6 DD 7E 07      [19]  591 	ld	a,7 (ix)
   3FB9 CE FF         [ 7]  592 	adc	a,#0xFF
   3FBB DD 77 07      [19]  593 	ld	7 (ix),a
   3FBE C3 6D 3E      [10]  594 	jp	00110$
   3FC1                     595 00113$:
   3FC1 DD F9         [10]  596 	ld	sp, ix
   3FC3 DD E1         [14]  597 	pop	ix
   3FC5 C9            [10]  598 	ret
                            599 ;src/StringUtils.c:154: void print_transparent_text(void* const text, u8* position, u8 fg){
                            600 ;	---------------------------------
                            601 ; Function print_transparent_text
                            602 ; ---------------------------------
   3FC6                     603 _print_transparent_text::
   3FC6 DD E5         [15]  604 	push	ix
   3FC8 DD 21 00 00   [14]  605 	ld	ix,#0
   3FCC DD 39         [15]  606 	add	ix,sp
   3FCE 21 F8 FF      [10]  607 	ld	hl,#-8
   3FD1 39            [11]  608 	add	hl,sp
   3FD2 F9            [ 6]  609 	ld	sp,hl
                            610 ;src/StringUtils.c:155: u8 val, charBitArray, spritePos, color = g_colors[fg];
   3FD3 01 AF 1A      [10]  611 	ld	bc,#_g_colors+0
   3FD6 DD 6E 08      [19]  612 	ld	l,8 (ix)
   3FD9 26 00         [ 7]  613 	ld	h,#0x00
   3FDB 09            [11]  614 	add	hl,bc
   3FDC 4E            [ 7]  615 	ld	c,(hl)
                            616 ;src/StringUtils.c:161: (position)+=0x2800;
   3FDD DD 7E 06      [19]  617 	ld	a,6 (ix)
   3FE0 C6 00         [ 7]  618 	add	a, #0x00
   3FE2 DD 77 06      [19]  619 	ld	6 (ix),a
   3FE5 DD 7E 07      [19]  620 	ld	a,7 (ix)
   3FE8 CE 28         [ 7]  621 	adc	a, #0x28
   3FEA DD 77 07      [19]  622 	ld	7 (ix),a
                            623 ;src/StringUtils.c:162: if(position<0x2800){
   3FED DD 46 06      [19]  624 	ld	b,6 (ix)
   3FF0 DD 5E 07      [19]  625 	ld	e,7 (ix)
   3FF3 7B            [ 4]  626 	ld	a,e
   3FF4 D6 28         [ 7]  627 	sub	a, #0x28
   3FF6 30 20         [12]  628 	jr	NC,00132$
                            629 ;src/StringUtils.c:163: position-=0x4000;
   3FF8 DD 7E 06      [19]  630 	ld	a,6 (ix)
   3FFB C6 00         [ 7]  631 	add	a,#0x00
   3FFD DD 77 06      [19]  632 	ld	6 (ix),a
   4000 DD 7E 07      [19]  633 	ld	a,7 (ix)
   4003 CE C0         [ 7]  634 	adc	a,#0xC0
   4005 DD 77 07      [19]  635 	ld	7 (ix),a
                            636 ;src/StringUtils.c:164: position+=80;
   4008 DD 7E 06      [19]  637 	ld	a,6 (ix)
   400B C6 50         [ 7]  638 	add	a, #0x50
   400D DD 77 06      [19]  639 	ld	6 (ix),a
   4010 DD 7E 07      [19]  640 	ld	a,7 (ix)
   4013 CE 00         [ 7]  641 	adc	a, #0x00
   4015 DD 77 07      [19]  642 	ld	7 (ix),a
                            643 ;src/StringUtils.c:167: while(height){
   4018                     644 00132$:
   4018 79            [ 4]  645 	ld	a,c
   4019 E6 AA         [ 7]  646 	and	a, #0xAA
   401B DD 77 FA      [19]  647 	ld	-6 (ix),a
   401E 79            [ 4]  648 	ld	a,c
   401F E6 55         [ 7]  649 	and	a, #0x55
   4021 DD 77 FB      [19]  650 	ld	-5 (ix),a
   4024 DD 36 F8 06   [19]  651 	ld	-8 (ix),#0x06
   4028 DD 36 F9 96   [19]  652 	ld	-7 (ix),#0x96
   402C                     653 00118$:
   402C DD 7E F8      [19]  654 	ld	a,-8 (ix)
   402F B7            [ 4]  655 	or	a, a
   4030 CA 18 41      [10]  656 	jp	Z,00121$
                            657 ;src/StringUtils.c:168: currentChar=text;
   4033 DD 7E 04      [19]  658 	ld	a,4 (ix)
   4036 DD 77 FE      [19]  659 	ld	-2 (ix),a
   4039 DD 7E 05      [19]  660 	ld	a,5 (ix)
   403C DD 77 FF      [19]  661 	ld	-1 (ix),a
                            662 ;src/StringUtils.c:169: currentPos=position;
   403F DD 7E 06      [19]  663 	ld	a,6 (ix)
   4042 DD 77 FC      [19]  664 	ld	-4 (ix),a
   4045 DD 7E 07      [19]  665 	ld	a,7 (ix)
   4048 DD 77 FD      [19]  666 	ld	-3 (ix),a
                            667 ;src/StringUtils.c:170: --height;
   404B DD 7E F9      [19]  668 	ld	a,-7 (ix)
   404E C6 E7         [ 7]  669 	add	a,#0xE7
   4050 DD 77 F9      [19]  670 	ld	-7 (ix),a
   4053 DD 35 F8      [23]  671 	dec	-8 (ix)
                            672 ;src/StringUtils.c:171: while(*currentChar){
   4056                     673 00113$:
   4056 DD 6E FE      [19]  674 	ld	l,-2 (ix)
   4059 DD 66 FF      [19]  675 	ld	h,-1 (ix)
   405C 4E            [ 7]  676 	ld	c,(hl)
   405D 79            [ 4]  677 	ld	a,c
   405E B7            [ 4]  678 	or	a, a
   405F CA E0 40      [10]  679 	jp	Z,00115$
                            680 ;src/StringUtils.c:173: spritePos = charArray[(*currentChar)];
   4062 21 62 3D      [10]  681 	ld	hl,#_charArray
   4065 06 00         [ 7]  682 	ld	b,#0x00
   4067 09            [11]  683 	add	hl, bc
   4068 46            [ 7]  684 	ld	b,(hl)
                            685 ;src/StringUtils.c:175: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   4069 78            [ 4]  686 	ld	a, b
   406A CB 3F         [ 8]  687 	srl	a
   406C DD 86 F9      [19]  688 	add	a, -7 (ix)
   406F 5F            [ 4]  689 	ld	e,a
   4070 21 ED 5A      [10]  690 	ld	hl,#_typography_4x6_monospaced
   4073 16 00         [ 7]  691 	ld	d,#0x00
   4075 19            [11]  692 	add	hl, de
   4076 4E            [ 7]  693 	ld	c,(hl)
                            694 ;src/StringUtils.c:177: if(spritePos%2) charBitArray<<=4;
   4077 CB 40         [ 8]  695 	bit	0, b
   4079 28 08         [12]  696 	jr	Z,00104$
   407B 79            [ 4]  697 	ld	a,c
   407C 07            [ 4]  698 	rlca
   407D 07            [ 4]  699 	rlca
   407E 07            [ 4]  700 	rlca
   407F 07            [ 4]  701 	rlca
   4080 E6 F0         [ 7]  702 	and	a,#0xF0
   4082 4F            [ 4]  703 	ld	c,a
   4083                     704 00104$:
                            705 ;src/StringUtils.c:179: val=*currentPos;
   4083 DD 6E FC      [19]  706 	ld	l,-4 (ix)
   4086 DD 66 FD      [19]  707 	ld	h,-3 (ix)
   4089 5E            [ 7]  708 	ld	e,(hl)
                            709 ;src/StringUtils.c:181: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
   408A CB 79         [ 8]  710 	bit	7, c
   408C 28 07         [12]  711 	jr	Z,00106$
   408E 7B            [ 4]  712 	ld	a,e
   408F E6 55         [ 7]  713 	and	a, #0x55
   4091 DD B6 FA      [19]  714 	or	a, -6 (ix)
   4094 5F            [ 4]  715 	ld	e,a
   4095                     716 00106$:
                            717 ;src/StringUtils.c:183: charBitArray<<=1;
   4095 CB 21         [ 8]  718 	sla	c
                            719 ;src/StringUtils.c:185: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
   4097 CB 79         [ 8]  720 	bit	7, c
   4099 28 07         [12]  721 	jr	Z,00108$
   409B 7B            [ 4]  722 	ld	a,e
   409C E6 AA         [ 7]  723 	and	a, #0xAA
   409E DD B6 FB      [19]  724 	or	a, -5 (ix)
   40A1 5F            [ 4]  725 	ld	e,a
   40A2                     726 00108$:
                            727 ;src/StringUtils.c:187: charBitArray<<=1;
   40A2 CB 21         [ 8]  728 	sla	c
                            729 ;src/StringUtils.c:189: *currentPos=val;
   40A4 DD 6E FC      [19]  730 	ld	l,-4 (ix)
   40A7 DD 66 FD      [19]  731 	ld	h,-3 (ix)
   40AA 73            [ 7]  732 	ld	(hl),e
                            733 ;src/StringUtils.c:190: ++currentPos;
   40AB DD 5E FC      [19]  734 	ld	e,-4 (ix)
   40AE DD 56 FD      [19]  735 	ld	d,-3 (ix)
   40B1 13            [ 6]  736 	inc	de
                            737 ;src/StringUtils.c:192: val=*currentPos;
   40B2 1A            [ 7]  738 	ld	a,(de)
   40B3 47            [ 4]  739 	ld	b,a
                            740 ;src/StringUtils.c:194: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
   40B4 CB 79         [ 8]  741 	bit	7, c
   40B6 28 07         [12]  742 	jr	Z,00110$
   40B8 78            [ 4]  743 	ld	a,b
   40B9 E6 55         [ 7]  744 	and	a, #0x55
   40BB DD B6 FA      [19]  745 	or	a, -6 (ix)
   40BE 47            [ 4]  746 	ld	b,a
   40BF                     747 00110$:
                            748 ;src/StringUtils.c:196: charBitArray<<=1;
   40BF 79            [ 4]  749 	ld	a,c
   40C0 87            [ 4]  750 	add	a, a
                            751 ;src/StringUtils.c:198: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
   40C1 07            [ 4]  752 	rlca
   40C2 30 07         [12]  753 	jr	NC,00112$
   40C4 78            [ 4]  754 	ld	a,b
   40C5 E6 AA         [ 7]  755 	and	a, #0xAA
   40C7 DD B6 FB      [19]  756 	or	a, -5 (ix)
   40CA 47            [ 4]  757 	ld	b,a
   40CB                     758 00112$:
                            759 ;src/StringUtils.c:202: *currentPos=val;
   40CB 78            [ 4]  760 	ld	a,b
   40CC 12            [ 7]  761 	ld	(de),a
                            762 ;src/StringUtils.c:203: ++currentPos;
   40CD 13            [ 6]  763 	inc	de
   40CE DD 73 FC      [19]  764 	ld	-4 (ix),e
   40D1 DD 72 FD      [19]  765 	ld	-3 (ix),d
                            766 ;src/StringUtils.c:205: ++currentChar;
   40D4 DD 34 FE      [23]  767 	inc	-2 (ix)
   40D7 C2 56 40      [10]  768 	jp	NZ,00113$
   40DA DD 34 FF      [23]  769 	inc	-1 (ix)
   40DD C3 56 40      [10]  770 	jp	00113$
   40E0                     771 00115$:
                            772 ;src/StringUtils.c:207: position-=0x0800;
   40E0 DD 7E 06      [19]  773 	ld	a,6 (ix)
   40E3 C6 00         [ 7]  774 	add	a,#0x00
   40E5 DD 77 06      [19]  775 	ld	6 (ix),a
   40E8 DD 7E 07      [19]  776 	ld	a,7 (ix)
   40EB CE F8         [ 7]  777 	adc	a,#0xF8
                            778 ;src/StringUtils.c:209: if(position<0xC000){
   40ED DD 77 07      [19]  779 	ld	7 (ix), a
   40F0 D6 C0         [ 7]  780 	sub	a, #0xC0
   40F2 D2 2C 40      [10]  781 	jp	NC,00118$
                            782 ;src/StringUtils.c:210: position+=0x4000;
   40F5 DD 7E 06      [19]  783 	ld	a,6 (ix)
   40F8 C6 00         [ 7]  784 	add	a, #0x00
   40FA DD 77 06      [19]  785 	ld	6 (ix),a
   40FD DD 7E 07      [19]  786 	ld	a,7 (ix)
   4100 CE 40         [ 7]  787 	adc	a, #0x40
   4102 DD 77 07      [19]  788 	ld	7 (ix),a
                            789 ;src/StringUtils.c:211: position-=80;
   4105 DD 7E 06      [19]  790 	ld	a,6 (ix)
   4108 C6 B0         [ 7]  791 	add	a,#0xB0
   410A DD 77 06      [19]  792 	ld	6 (ix),a
   410D DD 7E 07      [19]  793 	ld	a,7 (ix)
   4110 CE FF         [ 7]  794 	adc	a,#0xFF
   4112 DD 77 07      [19]  795 	ld	7 (ix),a
   4115 C3 2C 40      [10]  796 	jp	00118$
   4118                     797 00121$:
   4118 DD F9         [10]  798 	ld	sp, ix
   411A DD E1         [14]  799 	pop	ix
   411C C9            [10]  800 	ret
                            801 	.area _CODE
                            802 	.area _INITIALIZER
                            803 	.area _CABS (ABS)
