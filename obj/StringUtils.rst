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
   1F29                      51 _integer_to_string::
   1F29 DD E5         [15]   52 	push	ix
   1F2B DD 21 00 00   [14]   53 	ld	ix,#0
   1F2F DD 39         [15]   54 	add	ix,sp
                             55 ;src/StringUtils.c:36: u8* charPosition=(u8*)&i_to_s_buffer;
   1F31 01 87 20      [10]   56 	ld	bc,#_i_to_s_buffer+0
                             57 ;src/StringUtils.c:38: switch(format){
   1F34 DD 7E 05      [19]   58 	ld	a,5 (ix)
   1F37 D6 62         [ 7]   59 	sub	a, #0x62
   1F39 28 45         [12]   60 	jr	Z,00102$
   1F3B DD 7E 05      [19]   61 	ld	a,5 (ix)
   1F3E D6 68         [ 7]   62 	sub	a, #0x68
   1F40 20 57         [12]   63 	jr	NZ,00106$
                             64 ;src/StringUtils.c:40: charPosition+=2;
   1F42 11 89 20      [10]   65 	ld	de,#_i_to_s_buffer + 2
                             66 ;src/StringUtils.c:42: *charPosition = 0;
   1F45 AF            [ 4]   67 	xor	a, a
   1F46 12            [ 7]   68 	ld	(de),a
                             69 ;src/StringUtils.c:44: --charPosition;
   1F47 1B            [ 6]   70 	dec	de
                             71 ;src/StringUtils.c:46: t=n&0x0F;
   1F48 DD 7E 04      [19]   72 	ld	a,4 (ix)
   1F4B E6 0F         [ 7]   73 	and	a, #0x0F
   1F4D 6F            [ 4]   74 	ld	l,a
                             75 ;src/StringUtils.c:47: t=t>9?t+55:t+48;
   1F4E 3E 09         [ 7]   76 	ld	a,#0x09
   1F50 95            [ 4]   77 	sub	a, l
   1F51 30 05         [12]   78 	jr	NC,00110$
   1F53 7D            [ 4]   79 	ld	a,l
   1F54 C6 37         [ 7]   80 	add	a, #0x37
   1F56 18 03         [12]   81 	jr	00111$
   1F58                      82 00110$:
   1F58 7D            [ 4]   83 	ld	a,l
   1F59 C6 30         [ 7]   84 	add	a, #0x30
   1F5B                      85 00111$:
                             86 ;src/StringUtils.c:48: *charPosition=t;
   1F5B 12            [ 7]   87 	ld	(de),a
                             88 ;src/StringUtils.c:49: n>>=4;
   1F5C DD 7E 04      [19]   89 	ld	a,4 (ix)
   1F5F 07            [ 4]   90 	rlca
   1F60 07            [ 4]   91 	rlca
   1F61 07            [ 4]   92 	rlca
   1F62 07            [ 4]   93 	rlca
   1F63 E6 0F         [ 7]   94 	and	a,#0x0F
   1F65 DD 77 04      [19]   95 	ld	4 (ix),a
                             96 ;src/StringUtils.c:50: --charPosition;
   1F68 1B            [ 6]   97 	dec	de
                             98 ;src/StringUtils.c:52: t=n>9?n+55:n+48;
   1F69 3E 09         [ 7]   99 	ld	a,#0x09
   1F6B DD 96 04      [19]  100 	sub	a, 4 (ix)
   1F6E 30 07         [12]  101 	jr	NC,00112$
   1F70 DD 7E 04      [19]  102 	ld	a,4 (ix)
   1F73 C6 37         [ 7]  103 	add	a, #0x37
   1F75 18 05         [12]  104 	jr	00113$
   1F77                     105 00112$:
   1F77 DD 7E 04      [19]  106 	ld	a,4 (ix)
   1F7A C6 30         [ 7]  107 	add	a, #0x30
   1F7C                     108 00113$:
                            109 ;src/StringUtils.c:53: *charPosition=t;
   1F7C 12            [ 7]  110 	ld	(de),a
                            111 ;src/StringUtils.c:54: break;
   1F7D C3 02 20      [10]  112 	jp	00107$
                            113 ;src/StringUtils.c:56: case 'b':{
   1F80                     114 00102$:
                            115 ;src/StringUtils.c:58: charPosition+=8;
   1F80 21 8F 20      [10]  116 	ld	hl,#_i_to_s_buffer + 8
                            117 ;src/StringUtils.c:60: while(t){
   1F83 1E 08         [ 7]  118 	ld	e,#0x08
   1F85                     119 00103$:
   1F85 7B            [ 4]  120 	ld	a,e
   1F86 B7            [ 4]  121 	or	a, a
   1F87 28 79         [12]  122 	jr	Z,00107$
                            123 ;src/StringUtils.c:61: --t;
   1F89 1D            [ 4]  124 	dec	e
                            125 ;src/StringUtils.c:62: --charPosition;
   1F8A 2B            [ 6]  126 	dec	hl
                            127 ;src/StringUtils.c:63: *charPosition=(n&1)+48;
   1F8B DD 7E 04      [19]  128 	ld	a,4 (ix)
   1F8E E6 01         [ 7]  129 	and	a, #0x01
   1F90 C6 30         [ 7]  130 	add	a, #0x30
   1F92 77            [ 7]  131 	ld	(hl),a
                            132 ;src/StringUtils.c:64: n>>=1;
   1F93 DD CB 04 3E   [23]  133 	srl	4 (ix)
   1F97 18 EC         [12]  134 	jr	00103$
                            135 ;src/StringUtils.c:68: default:{
   1F99                     136 00106$:
                            137 ;src/StringUtils.c:69: charPosition+=3;
   1F99 11 8A 20      [10]  138 	ld	de,#_i_to_s_buffer + 3
                            139 ;src/StringUtils.c:71: *charPosition = 0;
   1F9C AF            [ 4]  140 	xor	a, a
   1F9D 12            [ 7]  141 	ld	(de),a
                            142 ;src/StringUtils.c:73: --charPosition;
   1F9E 1B            [ 6]  143 	dec	de
                            144 ;src/StringUtils.c:75: *charPosition=48+(n%10);
   1F9F C5            [11]  145 	push	bc
   1FA0 D5            [11]  146 	push	de
   1FA1 3E 0A         [ 7]  147 	ld	a,#0x0A
   1FA3 F5            [11]  148 	push	af
   1FA4 33            [ 6]  149 	inc	sp
   1FA5 DD 7E 04      [19]  150 	ld	a,4 (ix)
   1FA8 F5            [11]  151 	push	af
   1FA9 33            [ 6]  152 	inc	sp
   1FAA CD CC 47      [17]  153 	call	__moduchar
   1FAD F1            [10]  154 	pop	af
   1FAE D1            [10]  155 	pop	de
   1FAF C1            [10]  156 	pop	bc
   1FB0 7D            [ 4]  157 	ld	a,l
   1FB1 C6 30         [ 7]  158 	add	a, #0x30
   1FB3 12            [ 7]  159 	ld	(de),a
                            160 ;src/StringUtils.c:76: --charPosition;
                            161 ;src/StringUtils.c:77: n/=10;
   1FB4 C5            [11]  162 	push	bc
   1FB5 3E 0A         [ 7]  163 	ld	a,#0x0A
   1FB7 F5            [11]  164 	push	af
   1FB8 33            [ 6]  165 	inc	sp
   1FB9 DD 7E 04      [19]  166 	ld	a,4 (ix)
   1FBC F5            [11]  167 	push	af
   1FBD 33            [ 6]  168 	inc	sp
   1FBE CD EB 47      [17]  169 	call	__divuchar
   1FC1 F1            [10]  170 	pop	af
   1FC2 C1            [10]  171 	pop	bc
   1FC3 DD 75 04      [19]  172 	ld	4 (ix),l
                            173 ;src/StringUtils.c:78: *charPosition=48+(n%10);
   1FC6 C5            [11]  174 	push	bc
   1FC7 3E 0A         [ 7]  175 	ld	a,#0x0A
   1FC9 F5            [11]  176 	push	af
   1FCA 33            [ 6]  177 	inc	sp
   1FCB DD 7E 04      [19]  178 	ld	a,4 (ix)
   1FCE F5            [11]  179 	push	af
   1FCF 33            [ 6]  180 	inc	sp
   1FD0 CD CC 47      [17]  181 	call	__moduchar
   1FD3 F1            [10]  182 	pop	af
   1FD4 C1            [10]  183 	pop	bc
   1FD5 7D            [ 4]  184 	ld	a,l
   1FD6 C6 30         [ 7]  185 	add	a, #0x30
   1FD8 32 88 20      [13]  186 	ld	(#(_i_to_s_buffer + 0x0001)),a
                            187 ;src/StringUtils.c:79: --charPosition;
                            188 ;src/StringUtils.c:80: n/=10;
   1FDB C5            [11]  189 	push	bc
   1FDC 3E 0A         [ 7]  190 	ld	a,#0x0A
   1FDE F5            [11]  191 	push	af
   1FDF 33            [ 6]  192 	inc	sp
   1FE0 DD 7E 04      [19]  193 	ld	a,4 (ix)
   1FE3 F5            [11]  194 	push	af
   1FE4 33            [ 6]  195 	inc	sp
   1FE5 CD EB 47      [17]  196 	call	__divuchar
   1FE8 F1            [10]  197 	pop	af
   1FE9 C1            [10]  198 	pop	bc
   1FEA DD 75 04      [19]  199 	ld	4 (ix),l
                            200 ;src/StringUtils.c:81: *charPosition=48+(n%10);
   1FED C5            [11]  201 	push	bc
   1FEE 3E 0A         [ 7]  202 	ld	a,#0x0A
   1FF0 F5            [11]  203 	push	af
   1FF1 33            [ 6]  204 	inc	sp
   1FF2 DD 7E 04      [19]  205 	ld	a,4 (ix)
   1FF5 F5            [11]  206 	push	af
   1FF6 33            [ 6]  207 	inc	sp
   1FF7 CD CC 47      [17]  208 	call	__moduchar
   1FFA F1            [10]  209 	pop	af
   1FFB C1            [10]  210 	pop	bc
   1FFC 7D            [ 4]  211 	ld	a,l
   1FFD C6 30         [ 7]  212 	add	a, #0x30
   1FFF 32 87 20      [13]  213 	ld	(#_i_to_s_buffer),a
                            214 ;src/StringUtils.c:84: }
   2002                     215 00107$:
                            216 ;src/StringUtils.c:86: return i_to_s_buffer;
   2002 69            [ 4]  217 	ld	l, c
   2003 60            [ 4]  218 	ld	h, b
   2004 DD E1         [14]  219 	pop	ix
   2006 C9            [10]  220 	ret
   2007                     221 _charArray:
   2007 FF                  222 	.db #0xFF	; 255
   2008 FF                  223 	.db #0xFF	; 255
   2009 FF                  224 	.db #0xFF	; 255
   200A FF                  225 	.db #0xFF	; 255
   200B FF                  226 	.db #0xFF	; 255
   200C FF                  227 	.db #0xFF	; 255
   200D FF                  228 	.db #0xFF	; 255
   200E FF                  229 	.db #0xFF	; 255
   200F FF                  230 	.db #0xFF	; 255
   2010 FF                  231 	.db #0xFF	; 255
   2011 FF                  232 	.db #0xFF	; 255
   2012 FF                  233 	.db #0xFF	; 255
   2013 FF                  234 	.db #0xFF	; 255
   2014 FF                  235 	.db #0xFF	; 255
   2015 FF                  236 	.db #0xFF	; 255
   2016 FF                  237 	.db #0xFF	; 255
   2017 FF                  238 	.db #0xFF	; 255
   2018 FF                  239 	.db #0xFF	; 255
   2019 FF                  240 	.db #0xFF	; 255
   201A FF                  241 	.db #0xFF	; 255
   201B FF                  242 	.db #0xFF	; 255
   201C FF                  243 	.db #0xFF	; 255
   201D FF                  244 	.db #0xFF	; 255
   201E FF                  245 	.db #0xFF	; 255
   201F FF                  246 	.db #0xFF	; 255
   2020 FF                  247 	.db #0xFF	; 255
   2021 FF                  248 	.db #0xFF	; 255
   2022 FF                  249 	.db #0xFF	; 255
   2023 FF                  250 	.db #0xFF	; 255
   2024 FF                  251 	.db #0xFF	; 255
   2025 FF                  252 	.db #0xFF	; 255
   2026 FF                  253 	.db #0xFF	; 255
   2027 29                  254 	.db #0x29	; 41
   2028 24                  255 	.db #0x24	; 36
   2029 FF                  256 	.db #0xFF	; 255
   202A 2D                  257 	.db #0x2D	; 45
   202B 2F                  258 	.db #0x2F	; 47
   202C FF                  259 	.db #0xFF	; 255
   202D 2E                  260 	.db #0x2E	; 46
   202E FF                  261 	.db #0xFF	; 255
   202F FF                  262 	.db #0xFF	; 255
   2030 FF                  263 	.db #0xFF	; 255
   2031 31                  264 	.db #0x31	; 49	'1'
   2032 2C                  265 	.db #0x2C	; 44
   2033 FF                  266 	.db #0xFF	; 255
   2034 FF                  267 	.db #0xFF	; 255
   2035 26                  268 	.db #0x26	; 38
   2036 FF                  269 	.db #0xFF	; 255
   2037 1A                  270 	.db #0x1A	; 26
   2038 1B                  271 	.db #0x1B	; 27
   2039 1C                  272 	.db #0x1C	; 28
   203A 1D                  273 	.db #0x1D	; 29
   203B 1E                  274 	.db #0x1E	; 30
   203C 1F                  275 	.db #0x1F	; 31
   203D 20                  276 	.db #0x20	; 32
   203E 21                  277 	.db #0x21	; 33
   203F 22                  278 	.db #0x22	; 34
   2040 23                  279 	.db #0x23	; 35
   2041 27                  280 	.db #0x27	; 39
   2042 FF                  281 	.db #0xFF	; 255
   2043 2A                  282 	.db #0x2A	; 42
   2044 FF                  283 	.db #0xFF	; 255
   2045 2B                  284 	.db #0x2B	; 43
   2046 25                  285 	.db #0x25	; 37
   2047 28                  286 	.db #0x28	; 40
   2048 00                  287 	.db #0x00	; 0
   2049 01                  288 	.db #0x01	; 1
   204A 02                  289 	.db #0x02	; 2
   204B 03                  290 	.db #0x03	; 3
   204C 04                  291 	.db #0x04	; 4
   204D 05                  292 	.db #0x05	; 5
   204E 06                  293 	.db #0x06	; 6
   204F 07                  294 	.db #0x07	; 7
   2050 08                  295 	.db #0x08	; 8
   2051 09                  296 	.db #0x09	; 9
   2052 0A                  297 	.db #0x0A	; 10
   2053 0B                  298 	.db #0x0B	; 11
   2054 0C                  299 	.db #0x0C	; 12
   2055 0D                  300 	.db #0x0D	; 13
   2056 0E                  301 	.db #0x0E	; 14
   2057 0F                  302 	.db #0x0F	; 15
   2058 10                  303 	.db #0x10	; 16
   2059 11                  304 	.db #0x11	; 17
   205A 12                  305 	.db #0x12	; 18
   205B 13                  306 	.db #0x13	; 19
   205C 14                  307 	.db #0x14	; 20
   205D 15                  308 	.db #0x15	; 21
   205E 16                  309 	.db #0x16	; 22
   205F 17                  310 	.db #0x17	; 23
   2060 18                  311 	.db #0x18	; 24
   2061 19                  312 	.db #0x19	; 25
   2062 FF                  313 	.db #0xFF	; 255
   2063 FF                  314 	.db #0xFF	; 255
   2064 FF                  315 	.db #0xFF	; 255
   2065 FF                  316 	.db #0xFF	; 255
   2066 FF                  317 	.db #0xFF	; 255
   2067 FF                  318 	.db #0xFF	; 255
   2068 00                  319 	.db #0x00	; 0
   2069 01                  320 	.db #0x01	; 1
   206A 02                  321 	.db #0x02	; 2
   206B 03                  322 	.db #0x03	; 3
   206C 04                  323 	.db #0x04	; 4
   206D 05                  324 	.db #0x05	; 5
   206E 06                  325 	.db #0x06	; 6
   206F 07                  326 	.db #0x07	; 7
   2070 08                  327 	.db #0x08	; 8
   2071 09                  328 	.db #0x09	; 9
   2072 0A                  329 	.db #0x0A	; 10
   2073 0B                  330 	.db #0x0B	; 11
   2074 0C                  331 	.db #0x0C	; 12
   2075 0D                  332 	.db #0x0D	; 13
   2076 0E                  333 	.db #0x0E	; 14
   2077 0F                  334 	.db #0x0F	; 15
   2078 10                  335 	.db #0x10	; 16
   2079 11                  336 	.db #0x11	; 17
   207A 12                  337 	.db #0x12	; 18
   207B 13                  338 	.db #0x13	; 19
   207C 14                  339 	.db #0x14	; 20
   207D 15                  340 	.db #0x15	; 21
   207E 16                  341 	.db #0x16	; 22
   207F 17                  342 	.db #0x17	; 23
   2080 18                  343 	.db #0x18	; 24
   2081 19                  344 	.db #0x19	; 25
   2082 FF                  345 	.db #0xFF	; 255
   2083 FF                  346 	.db #0xFF	; 255
   2084 FF                  347 	.db #0xFF	; 255
   2085 30                  348 	.db #0x30	; 48	'0'
   2086 FF                  349 	.db #0xFF	; 255
   2087                     350 _i_to_s_buffer:
   2087 00                  351 	.db #0x00	; 0
   2088 00                  352 	.db #0x00	; 0
   2089 00                  353 	.db #0x00	; 0
   208A 00                  354 	.db #0x00	; 0
   208B 00                  355 	.db #0x00	; 0
   208C 00                  356 	.db #0x00	; 0
   208D 00                  357 	.db #0x00	; 0
   208E 00                  358 	.db #0x00	; 0
   208F 00                  359 	.db #0x00	; 0
                            360 ;src/StringUtils.c:90: void print_text(void * const text, u8* position, u8 bg, u8 fg){
                            361 ;	---------------------------------
                            362 ; Function print_text
                            363 ; ---------------------------------
   2090                     364 _print_text::
   2090 DD E5         [15]  365 	push	ix
   2092 DD 21 00 00   [14]  366 	ld	ix,#0
   2096 DD 39         [15]  367 	add	ix,sp
   2098 21 EF FF      [10]  368 	ld	hl,#-17
   209B 39            [11]  369 	add	hl,sp
   209C F9            [ 6]  370 	ld	sp,hl
                            371 ;src/StringUtils.c:91: u8 val, charBitArray, spritePos, fgColor=g_colors[fg], bgColor=g_colors[bg];
   209D DD 7E 09      [19]  372 	ld	a,9 (ix)
   20A0 C6 A3         [ 7]  373 	add	a, #<(_g_colors)
   20A2 DD 77 FC      [19]  374 	ld	-4 (ix),a
   20A5 3E 00         [ 7]  375 	ld	a,#0x00
   20A7 CE 0A         [ 7]  376 	adc	a, #>(_g_colors)
   20A9 DD 77 FD      [19]  377 	ld	-3 (ix),a
   20AC DD 6E FC      [19]  378 	ld	l,-4 (ix)
   20AF DD 66 FD      [19]  379 	ld	h,-3 (ix)
   20B2 7E            [ 7]  380 	ld	a,(hl)
   20B3 DD 77 F3      [19]  381 	ld	-13 (ix),a
   20B6 3E A3         [ 7]  382 	ld	a,#<(_g_colors)
   20B8 DD 86 08      [19]  383 	add	a, 8 (ix)
   20BB DD 77 FC      [19]  384 	ld	-4 (ix),a
   20BE 3E 0A         [ 7]  385 	ld	a,#>(_g_colors)
   20C0 CE 00         [ 7]  386 	adc	a, #0x00
   20C2 DD 77 FD      [19]  387 	ld	-3 (ix),a
   20C5 DD 6E FC      [19]  388 	ld	l,-4 (ix)
   20C8 DD 66 FD      [19]  389 	ld	h,-3 (ix)
   20CB 7E            [ 7]  390 	ld	a,(hl)
   20CC DD 77 F2      [19]  391 	ld	-14 (ix),a
                            392 ;src/StringUtils.c:97: (position)+=0x2800;
   20CF DD 7E 06      [19]  393 	ld	a,6 (ix)
   20D2 C6 00         [ 7]  394 	add	a, #0x00
   20D4 DD 77 06      [19]  395 	ld	6 (ix),a
   20D7 DD 7E 07      [19]  396 	ld	a,7 (ix)
   20DA CE 28         [ 7]  397 	adc	a, #0x28
   20DC DD 77 07      [19]  398 	ld	7 (ix),a
                            399 ;src/StringUtils.c:98: if(position<0x2800){
   20DF DD 4E 06      [19]  400 	ld	c,6 (ix)
   20E2 DD 46 07      [19]  401 	ld	b,7 (ix)
   20E5 78            [ 4]  402 	ld	a,b
   20E6 D6 28         [ 7]  403 	sub	a, #0x28
   20E8 30 20         [12]  404 	jr	NC,00132$
                            405 ;src/StringUtils.c:99: position-=0x4000;
   20EA DD 7E 06      [19]  406 	ld	a,6 (ix)
   20ED C6 00         [ 7]  407 	add	a,#0x00
   20EF DD 77 06      [19]  408 	ld	6 (ix),a
   20F2 DD 7E 07      [19]  409 	ld	a,7 (ix)
   20F5 CE C0         [ 7]  410 	adc	a,#0xC0
   20F7 DD 77 07      [19]  411 	ld	7 (ix),a
                            412 ;src/StringUtils.c:100: position+=80;
   20FA DD 7E 06      [19]  413 	ld	a,6 (ix)
   20FD C6 50         [ 7]  414 	add	a, #0x50
   20FF DD 77 06      [19]  415 	ld	6 (ix),a
   2102 DD 7E 07      [19]  416 	ld	a,7 (ix)
   2105 CE 00         [ 7]  417 	adc	a, #0x00
   2107 DD 77 07      [19]  418 	ld	7 (ix),a
                            419 ;src/StringUtils.c:103: while(height){
   210A                     420 00132$:
   210A DD 36 F1 06   [19]  421 	ld	-15 (ix),#0x06
   210E DD 36 FC 96   [19]  422 	ld	-4 (ix),#0x96
   2112                     423 00110$:
   2112 DD 7E F1      [19]  424 	ld	a,-15 (ix)
   2115 B7            [ 4]  425 	or	a, a
   2116 CA 62 22      [10]  426 	jp	Z,00113$
                            427 ;src/StringUtils.c:104: --height;
   2119 DD 7E FC      [19]  428 	ld	a,-4 (ix)
   211C C6 E7         [ 7]  429 	add	a,#0xE7
   211E DD 77 FC      [19]  430 	ld	-4 (ix),a
   2121 DD 35 F1      [23]  431 	dec	-15 (ix)
                            432 ;src/StringUtils.c:105: currentChar=text;
   2124 DD 7E 04      [19]  433 	ld	a,4 (ix)
   2127 DD 77 F8      [19]  434 	ld	-8 (ix),a
   212A DD 7E 05      [19]  435 	ld	a,5 (ix)
   212D DD 77 F9      [19]  436 	ld	-7 (ix),a
                            437 ;src/StringUtils.c:106: currentPos=position;
   2130 DD 7E 06      [19]  438 	ld	a,6 (ix)
   2133 DD 77 FA      [19]  439 	ld	-6 (ix),a
   2136 DD 7E 07      [19]  440 	ld	a,7 (ix)
   2139 DD 77 FB      [19]  441 	ld	-5 (ix),a
                            442 ;src/StringUtils.c:108: while(*currentChar){
   213C                     443 00105$:
   213C DD 6E F8      [19]  444 	ld	l,-8 (ix)
   213F DD 66 F9      [19]  445 	ld	h,-7 (ix)
   2142 7E            [ 7]  446 	ld	a,(hl)
   2143 DD 77 F7      [19]  447 	ld	-9 (ix), a
   2146 B7            [ 4]  448 	or	a, a
   2147 CA 2A 22      [10]  449 	jp	Z,00107$
                            450 ;src/StringUtils.c:110: spritePos = charArray[(*currentChar)];
   214A 3E 07         [ 7]  451 	ld	a,#<(_charArray)
   214C DD 86 F7      [19]  452 	add	a, -9 (ix)
   214F DD 77 FE      [19]  453 	ld	-2 (ix),a
   2152 3E 20         [ 7]  454 	ld	a,#>(_charArray)
   2154 CE 00         [ 7]  455 	adc	a, #0x00
   2156 DD 77 FF      [19]  456 	ld	-1 (ix),a
   2159 DD 6E FE      [19]  457 	ld	l,-2 (ix)
   215C DD 66 FF      [19]  458 	ld	h,-1 (ix)
   215F 7E            [ 7]  459 	ld	a,(hl)
                            460 ;src/StringUtils.c:112: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   2160 DD 77 F4      [19]  461 	ld	-12 (ix), a
   2163 CB 3F         [ 8]  462 	srl	a
   2165 DD 77 FE      [19]  463 	ld	-2 (ix), a
   2168 DD 86 FC      [19]  464 	add	a, -4 (ix)
   216B DD 77 FE      [19]  465 	ld	-2 (ix),a
   216E C6 E4         [ 7]  466 	add	a,#<(_typography_4x6_monospaced)
   2170 DD 77 FE      [19]  467 	ld	-2 (ix),a
   2173 3E 31         [ 7]  468 	ld	a,#>(_typography_4x6_monospaced)
   2175 CE 00         [ 7]  469 	adc	a, #0x00
   2177 DD 77 FF      [19]  470 	ld	-1 (ix),a
   217A DD 6E FE      [19]  471 	ld	l,-2 (ix)
   217D DD 66 FF      [19]  472 	ld	h,-1 (ix)
   2180 7E            [ 7]  473 	ld	a,(hl)
   2181 DD 77 FE      [19]  474 	ld	-2 (ix),a
                            475 ;src/StringUtils.c:114: if(spritePos%2) charBitArray<<=4;
   2184 DD CB F4 46   [20]  476 	bit	0, -12 (ix)
   2188 28 0C         [12]  477 	jr	Z,00104$
   218A DD 7E FE      [19]  478 	ld	a,-2 (ix)
   218D 07            [ 4]  479 	rlca
   218E 07            [ 4]  480 	rlca
   218F 07            [ 4]  481 	rlca
   2190 07            [ 4]  482 	rlca
   2191 E6 F0         [ 7]  483 	and	a,#0xF0
   2193 DD 77 FE      [19]  484 	ld	-2 (ix),a
   2196                     485 00104$:
                            486 ;src/StringUtils.c:118: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   2196 DD CB FE 7E   [20]  487 	bit	7, -2 (ix)
   219A 28 05         [12]  488 	jr	Z,00115$
   219C DD 7E F3      [19]  489 	ld	a,-13 (ix)
   219F 18 03         [12]  490 	jr	00116$
   21A1                     491 00115$:
   21A1 DD 7E F2      [19]  492 	ld	a,-14 (ix)
   21A4                     493 00116$:
   21A4 E6 AA         [ 7]  494 	and	a, #0xAA
   21A6 4F            [ 4]  495 	ld	c,a
                            496 ;src/StringUtils.c:120: charBitArray<<=1;
   21A7 DD 7E FE      [19]  497 	ld	a,-2 (ix)
   21AA 87            [ 4]  498 	add	a, a
   21AB 47            [ 4]  499 	ld	b,a
                            500 ;src/StringUtils.c:122: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   21AC CB 78         [ 8]  501 	bit	7, b
   21AE 28 05         [12]  502 	jr	Z,00117$
   21B0 DD 7E F3      [19]  503 	ld	a,-13 (ix)
   21B3 18 03         [12]  504 	jr	00118$
   21B5                     505 00117$:
   21B5 DD 7E F2      [19]  506 	ld	a,-14 (ix)
   21B8                     507 00118$:
   21B8 E6 55         [ 7]  508 	and	a, #0x55
   21BA B1            [ 4]  509 	or	a, c
   21BB 4F            [ 4]  510 	ld	c,a
                            511 ;src/StringUtils.c:124: charBitArray<<=1;
   21BC 78            [ 4]  512 	ld	a,b
   21BD 87            [ 4]  513 	add	a, a
   21BE DD 77 F5      [19]  514 	ld	-11 (ix),a
                            515 ;src/StringUtils.c:126: *currentPos=val;
   21C1 DD 6E FA      [19]  516 	ld	l,-6 (ix)
   21C4 DD 66 FB      [19]  517 	ld	h,-5 (ix)
   21C7 71            [ 7]  518 	ld	(hl),c
                            519 ;src/StringUtils.c:127: ++currentPos;
   21C8 DD 7E FA      [19]  520 	ld	a,-6 (ix)
   21CB C6 01         [ 7]  521 	add	a, #0x01
   21CD DD 77 EF      [19]  522 	ld	-17 (ix),a
   21D0 DD 7E FB      [19]  523 	ld	a,-5 (ix)
   21D3 CE 00         [ 7]  524 	adc	a, #0x00
   21D5 DD 77 F0      [19]  525 	ld	-16 (ix),a
                            526 ;src/StringUtils.c:131: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   21D8 DD CB F5 7E   [20]  527 	bit	7, -11 (ix)
   21DC 28 05         [12]  528 	jr	Z,00119$
   21DE DD 7E F3      [19]  529 	ld	a,-13 (ix)
   21E1 18 03         [12]  530 	jr	00120$
   21E3                     531 00119$:
   21E3 DD 7E F2      [19]  532 	ld	a,-14 (ix)
   21E6                     533 00120$:
   21E6 E6 AA         [ 7]  534 	and	a, #0xAA
   21E8 DD 77 F6      [19]  535 	ld	-10 (ix),a
                            536 ;src/StringUtils.c:133: charBitArray<<=1;
   21EB DD 7E F5      [19]  537 	ld	a,-11 (ix)
   21EE 87            [ 4]  538 	add	a, a
                            539 ;src/StringUtils.c:135: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   21EF 07            [ 4]  540 	rlca
   21F0 30 05         [12]  541 	jr	NC,00121$
   21F2 DD 7E F3      [19]  542 	ld	a,-13 (ix)
   21F5 18 03         [12]  543 	jr	00122$
   21F7                     544 00121$:
   21F7 DD 7E F2      [19]  545 	ld	a,-14 (ix)
   21FA                     546 00122$:
   21FA E6 55         [ 7]  547 	and	a, #0x55
   21FC DD 77 FE      [19]  548 	ld	-2 (ix),a
   21FF DD 7E F6      [19]  549 	ld	a,-10 (ix)
   2202 DD B6 FE      [19]  550 	or	a, -2 (ix)
   2205 DD 77 FE      [19]  551 	ld	-2 (ix),a
                            552 ;src/StringUtils.c:139: *currentPos=val;
   2208 E1            [10]  553 	pop	hl
   2209 E5            [11]  554 	push	hl
   220A DD 7E FE      [19]  555 	ld	a,-2 (ix)
   220D 77            [ 7]  556 	ld	(hl),a
                            557 ;src/StringUtils.c:140: ++currentPos;
   220E DD 7E EF      [19]  558 	ld	a,-17 (ix)
   2211 C6 01         [ 7]  559 	add	a, #0x01
   2213 DD 77 FA      [19]  560 	ld	-6 (ix),a
   2216 DD 7E F0      [19]  561 	ld	a,-16 (ix)
   2219 CE 00         [ 7]  562 	adc	a, #0x00
   221B DD 77 FB      [19]  563 	ld	-5 (ix),a
                            564 ;src/StringUtils.c:142: ++currentChar;
   221E DD 34 F8      [23]  565 	inc	-8 (ix)
   2221 C2 3C 21      [10]  566 	jp	NZ,00105$
   2224 DD 34 F9      [23]  567 	inc	-7 (ix)
   2227 C3 3C 21      [10]  568 	jp	00105$
   222A                     569 00107$:
                            570 ;src/StringUtils.c:144: position-=0x0800;
   222A DD 7E 06      [19]  571 	ld	a,6 (ix)
   222D C6 00         [ 7]  572 	add	a,#0x00
   222F DD 77 06      [19]  573 	ld	6 (ix),a
   2232 DD 7E 07      [19]  574 	ld	a,7 (ix)
   2235 CE F8         [ 7]  575 	adc	a,#0xF8
                            576 ;src/StringUtils.c:146: if(position<0xC000){
   2237 DD 77 07      [19]  577 	ld	7 (ix), a
   223A D6 C0         [ 7]  578 	sub	a, #0xC0
   223C D2 12 21      [10]  579 	jp	NC,00110$
                            580 ;src/StringUtils.c:147: position+=0x4000;
   223F DD 7E 06      [19]  581 	ld	a,6 (ix)
   2242 C6 00         [ 7]  582 	add	a, #0x00
   2244 DD 77 06      [19]  583 	ld	6 (ix),a
   2247 DD 7E 07      [19]  584 	ld	a,7 (ix)
   224A CE 40         [ 7]  585 	adc	a, #0x40
   224C DD 77 07      [19]  586 	ld	7 (ix),a
                            587 ;src/StringUtils.c:148: position-=80;
   224F DD 7E 06      [19]  588 	ld	a,6 (ix)
   2252 C6 B0         [ 7]  589 	add	a,#0xB0
   2254 DD 77 06      [19]  590 	ld	6 (ix),a
   2257 DD 7E 07      [19]  591 	ld	a,7 (ix)
   225A CE FF         [ 7]  592 	adc	a,#0xFF
   225C DD 77 07      [19]  593 	ld	7 (ix),a
   225F C3 12 21      [10]  594 	jp	00110$
   2262                     595 00113$:
   2262 DD F9         [10]  596 	ld	sp, ix
   2264 DD E1         [14]  597 	pop	ix
   2266 C9            [10]  598 	ret
                            599 ;src/StringUtils.c:154: void print_transparent_text(void* const text, u8* position, u8 fg){
                            600 ;	---------------------------------
                            601 ; Function print_transparent_text
                            602 ; ---------------------------------
   2267                     603 _print_transparent_text::
   2267 DD E5         [15]  604 	push	ix
   2269 DD 21 00 00   [14]  605 	ld	ix,#0
   226D DD 39         [15]  606 	add	ix,sp
   226F 21 F8 FF      [10]  607 	ld	hl,#-8
   2272 39            [11]  608 	add	hl,sp
   2273 F9            [ 6]  609 	ld	sp,hl
                            610 ;src/StringUtils.c:155: u8 val, charBitArray, spritePos, color = g_colors[fg];
   2274 01 A3 0A      [10]  611 	ld	bc,#_g_colors+0
   2277 DD 6E 08      [19]  612 	ld	l,8 (ix)
   227A 26 00         [ 7]  613 	ld	h,#0x00
   227C 09            [11]  614 	add	hl,bc
   227D 4E            [ 7]  615 	ld	c,(hl)
                            616 ;src/StringUtils.c:161: (position)+=0x2800;
   227E DD 7E 06      [19]  617 	ld	a,6 (ix)
   2281 C6 00         [ 7]  618 	add	a, #0x00
   2283 DD 77 06      [19]  619 	ld	6 (ix),a
   2286 DD 7E 07      [19]  620 	ld	a,7 (ix)
   2289 CE 28         [ 7]  621 	adc	a, #0x28
   228B DD 77 07      [19]  622 	ld	7 (ix),a
                            623 ;src/StringUtils.c:162: if(position<0x2800){
   228E DD 46 06      [19]  624 	ld	b,6 (ix)
   2291 DD 5E 07      [19]  625 	ld	e,7 (ix)
   2294 7B            [ 4]  626 	ld	a,e
   2295 D6 28         [ 7]  627 	sub	a, #0x28
   2297 30 20         [12]  628 	jr	NC,00132$
                            629 ;src/StringUtils.c:163: position-=0x4000;
   2299 DD 7E 06      [19]  630 	ld	a,6 (ix)
   229C C6 00         [ 7]  631 	add	a,#0x00
   229E DD 77 06      [19]  632 	ld	6 (ix),a
   22A1 DD 7E 07      [19]  633 	ld	a,7 (ix)
   22A4 CE C0         [ 7]  634 	adc	a,#0xC0
   22A6 DD 77 07      [19]  635 	ld	7 (ix),a
                            636 ;src/StringUtils.c:164: position+=80;
   22A9 DD 7E 06      [19]  637 	ld	a,6 (ix)
   22AC C6 50         [ 7]  638 	add	a, #0x50
   22AE DD 77 06      [19]  639 	ld	6 (ix),a
   22B1 DD 7E 07      [19]  640 	ld	a,7 (ix)
   22B4 CE 00         [ 7]  641 	adc	a, #0x00
   22B6 DD 77 07      [19]  642 	ld	7 (ix),a
                            643 ;src/StringUtils.c:167: while(height){
   22B9                     644 00132$:
   22B9 79            [ 4]  645 	ld	a,c
   22BA E6 AA         [ 7]  646 	and	a, #0xAA
   22BC DD 77 FA      [19]  647 	ld	-6 (ix),a
   22BF 79            [ 4]  648 	ld	a,c
   22C0 E6 55         [ 7]  649 	and	a, #0x55
   22C2 DD 77 FB      [19]  650 	ld	-5 (ix),a
   22C5 DD 36 F8 06   [19]  651 	ld	-8 (ix),#0x06
   22C9 DD 36 F9 96   [19]  652 	ld	-7 (ix),#0x96
   22CD                     653 00118$:
   22CD DD 7E F8      [19]  654 	ld	a,-8 (ix)
   22D0 B7            [ 4]  655 	or	a, a
   22D1 CA B9 23      [10]  656 	jp	Z,00121$
                            657 ;src/StringUtils.c:168: currentChar=text;
   22D4 DD 7E 04      [19]  658 	ld	a,4 (ix)
   22D7 DD 77 FE      [19]  659 	ld	-2 (ix),a
   22DA DD 7E 05      [19]  660 	ld	a,5 (ix)
   22DD DD 77 FF      [19]  661 	ld	-1 (ix),a
                            662 ;src/StringUtils.c:169: currentPos=position;
   22E0 DD 7E 06      [19]  663 	ld	a,6 (ix)
   22E3 DD 77 FC      [19]  664 	ld	-4 (ix),a
   22E6 DD 7E 07      [19]  665 	ld	a,7 (ix)
   22E9 DD 77 FD      [19]  666 	ld	-3 (ix),a
                            667 ;src/StringUtils.c:170: --height;
   22EC DD 7E F9      [19]  668 	ld	a,-7 (ix)
   22EF C6 E7         [ 7]  669 	add	a,#0xE7
   22F1 DD 77 F9      [19]  670 	ld	-7 (ix),a
   22F4 DD 35 F8      [23]  671 	dec	-8 (ix)
                            672 ;src/StringUtils.c:171: while(*currentChar){
   22F7                     673 00113$:
   22F7 DD 6E FE      [19]  674 	ld	l,-2 (ix)
   22FA DD 66 FF      [19]  675 	ld	h,-1 (ix)
   22FD 4E            [ 7]  676 	ld	c,(hl)
   22FE 79            [ 4]  677 	ld	a,c
   22FF B7            [ 4]  678 	or	a, a
   2300 CA 81 23      [10]  679 	jp	Z,00115$
                            680 ;src/StringUtils.c:173: spritePos = charArray[(*currentChar)];
   2303 21 07 20      [10]  681 	ld	hl,#_charArray
   2306 06 00         [ 7]  682 	ld	b,#0x00
   2308 09            [11]  683 	add	hl, bc
   2309 46            [ 7]  684 	ld	b,(hl)
                            685 ;src/StringUtils.c:175: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   230A 78            [ 4]  686 	ld	a, b
   230B CB 3F         [ 8]  687 	srl	a
   230D DD 86 F9      [19]  688 	add	a, -7 (ix)
   2310 5F            [ 4]  689 	ld	e,a
   2311 21 E4 31      [10]  690 	ld	hl,#_typography_4x6_monospaced
   2314 16 00         [ 7]  691 	ld	d,#0x00
   2316 19            [11]  692 	add	hl, de
   2317 4E            [ 7]  693 	ld	c,(hl)
                            694 ;src/StringUtils.c:177: if(spritePos%2) charBitArray<<=4;
   2318 CB 40         [ 8]  695 	bit	0, b
   231A 28 08         [12]  696 	jr	Z,00104$
   231C 79            [ 4]  697 	ld	a,c
   231D 07            [ 4]  698 	rlca
   231E 07            [ 4]  699 	rlca
   231F 07            [ 4]  700 	rlca
   2320 07            [ 4]  701 	rlca
   2321 E6 F0         [ 7]  702 	and	a,#0xF0
   2323 4F            [ 4]  703 	ld	c,a
   2324                     704 00104$:
                            705 ;src/StringUtils.c:179: val=*currentPos;
   2324 DD 6E FC      [19]  706 	ld	l,-4 (ix)
   2327 DD 66 FD      [19]  707 	ld	h,-3 (ix)
   232A 5E            [ 7]  708 	ld	e,(hl)
                            709 ;src/StringUtils.c:181: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
   232B CB 79         [ 8]  710 	bit	7, c
   232D 28 07         [12]  711 	jr	Z,00106$
   232F 7B            [ 4]  712 	ld	a,e
   2330 E6 55         [ 7]  713 	and	a, #0x55
   2332 DD B6 FA      [19]  714 	or	a, -6 (ix)
   2335 5F            [ 4]  715 	ld	e,a
   2336                     716 00106$:
                            717 ;src/StringUtils.c:183: charBitArray<<=1;
   2336 CB 21         [ 8]  718 	sla	c
                            719 ;src/StringUtils.c:185: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
   2338 CB 79         [ 8]  720 	bit	7, c
   233A 28 07         [12]  721 	jr	Z,00108$
   233C 7B            [ 4]  722 	ld	a,e
   233D E6 AA         [ 7]  723 	and	a, #0xAA
   233F DD B6 FB      [19]  724 	or	a, -5 (ix)
   2342 5F            [ 4]  725 	ld	e,a
   2343                     726 00108$:
                            727 ;src/StringUtils.c:187: charBitArray<<=1;
   2343 CB 21         [ 8]  728 	sla	c
                            729 ;src/StringUtils.c:189: *currentPos=val;
   2345 DD 6E FC      [19]  730 	ld	l,-4 (ix)
   2348 DD 66 FD      [19]  731 	ld	h,-3 (ix)
   234B 73            [ 7]  732 	ld	(hl),e
                            733 ;src/StringUtils.c:190: ++currentPos;
   234C DD 5E FC      [19]  734 	ld	e,-4 (ix)
   234F DD 56 FD      [19]  735 	ld	d,-3 (ix)
   2352 13            [ 6]  736 	inc	de
                            737 ;src/StringUtils.c:192: val=*currentPos;
   2353 1A            [ 7]  738 	ld	a,(de)
   2354 47            [ 4]  739 	ld	b,a
                            740 ;src/StringUtils.c:194: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
   2355 CB 79         [ 8]  741 	bit	7, c
   2357 28 07         [12]  742 	jr	Z,00110$
   2359 78            [ 4]  743 	ld	a,b
   235A E6 55         [ 7]  744 	and	a, #0x55
   235C DD B6 FA      [19]  745 	or	a, -6 (ix)
   235F 47            [ 4]  746 	ld	b,a
   2360                     747 00110$:
                            748 ;src/StringUtils.c:196: charBitArray<<=1;
   2360 79            [ 4]  749 	ld	a,c
   2361 87            [ 4]  750 	add	a, a
                            751 ;src/StringUtils.c:198: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
   2362 07            [ 4]  752 	rlca
   2363 30 07         [12]  753 	jr	NC,00112$
   2365 78            [ 4]  754 	ld	a,b
   2366 E6 AA         [ 7]  755 	and	a, #0xAA
   2368 DD B6 FB      [19]  756 	or	a, -5 (ix)
   236B 47            [ 4]  757 	ld	b,a
   236C                     758 00112$:
                            759 ;src/StringUtils.c:202: *currentPos=val;
   236C 78            [ 4]  760 	ld	a,b
   236D 12            [ 7]  761 	ld	(de),a
                            762 ;src/StringUtils.c:203: ++currentPos;
   236E 13            [ 6]  763 	inc	de
   236F DD 73 FC      [19]  764 	ld	-4 (ix),e
   2372 DD 72 FD      [19]  765 	ld	-3 (ix),d
                            766 ;src/StringUtils.c:205: ++currentChar;
   2375 DD 34 FE      [23]  767 	inc	-2 (ix)
   2378 C2 F7 22      [10]  768 	jp	NZ,00113$
   237B DD 34 FF      [23]  769 	inc	-1 (ix)
   237E C3 F7 22      [10]  770 	jp	00113$
   2381                     771 00115$:
                            772 ;src/StringUtils.c:207: position-=0x0800;
   2381 DD 7E 06      [19]  773 	ld	a,6 (ix)
   2384 C6 00         [ 7]  774 	add	a,#0x00
   2386 DD 77 06      [19]  775 	ld	6 (ix),a
   2389 DD 7E 07      [19]  776 	ld	a,7 (ix)
   238C CE F8         [ 7]  777 	adc	a,#0xF8
                            778 ;src/StringUtils.c:209: if(position<0xC000){
   238E DD 77 07      [19]  779 	ld	7 (ix), a
   2391 D6 C0         [ 7]  780 	sub	a, #0xC0
   2393 D2 CD 22      [10]  781 	jp	NC,00118$
                            782 ;src/StringUtils.c:210: position+=0x4000;
   2396 DD 7E 06      [19]  783 	ld	a,6 (ix)
   2399 C6 00         [ 7]  784 	add	a, #0x00
   239B DD 77 06      [19]  785 	ld	6 (ix),a
   239E DD 7E 07      [19]  786 	ld	a,7 (ix)
   23A1 CE 40         [ 7]  787 	adc	a, #0x40
   23A3 DD 77 07      [19]  788 	ld	7 (ix),a
                            789 ;src/StringUtils.c:211: position-=80;
   23A6 DD 7E 06      [19]  790 	ld	a,6 (ix)
   23A9 C6 B0         [ 7]  791 	add	a,#0xB0
   23AB DD 77 06      [19]  792 	ld	6 (ix),a
   23AE DD 7E 07      [19]  793 	ld	a,7 (ix)
   23B1 CE FF         [ 7]  794 	adc	a,#0xFF
   23B3 DD 77 07      [19]  795 	ld	7 (ix),a
   23B6 C3 CD 22      [10]  796 	jp	00118$
   23B9                     797 00121$:
   23B9 DD F9         [10]  798 	ld	sp, ix
   23BB DD E1         [14]  799 	pop	ix
   23BD C9            [10]  800 	ret
                            801 	.area _CODE
                            802 	.area _INITIALIZER
                            803 	.area _CABS (ABS)
