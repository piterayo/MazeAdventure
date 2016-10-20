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
   1F32                      51 _integer_to_string::
   1F32 DD E5         [15]   52 	push	ix
   1F34 DD 21 00 00   [14]   53 	ld	ix,#0
   1F38 DD 39         [15]   54 	add	ix,sp
                             55 ;src/StringUtils.c:36: u8* charPosition=(u8*)&i_to_s_buffer;
   1F3A 01 90 20      [10]   56 	ld	bc,#_i_to_s_buffer+0
                             57 ;src/StringUtils.c:38: switch(format){
   1F3D DD 7E 05      [19]   58 	ld	a,5 (ix)
   1F40 D6 62         [ 7]   59 	sub	a, #0x62
   1F42 28 45         [12]   60 	jr	Z,00102$
   1F44 DD 7E 05      [19]   61 	ld	a,5 (ix)
   1F47 D6 68         [ 7]   62 	sub	a, #0x68
   1F49 20 57         [12]   63 	jr	NZ,00106$
                             64 ;src/StringUtils.c:40: charPosition+=2;
   1F4B 11 92 20      [10]   65 	ld	de,#_i_to_s_buffer + 2
                             66 ;src/StringUtils.c:42: *charPosition = 0;
   1F4E AF            [ 4]   67 	xor	a, a
   1F4F 12            [ 7]   68 	ld	(de),a
                             69 ;src/StringUtils.c:44: --charPosition;
   1F50 1B            [ 6]   70 	dec	de
                             71 ;src/StringUtils.c:46: t=n&0x0F;
   1F51 DD 7E 04      [19]   72 	ld	a,4 (ix)
   1F54 E6 0F         [ 7]   73 	and	a, #0x0F
   1F56 6F            [ 4]   74 	ld	l,a
                             75 ;src/StringUtils.c:47: t=t>9?t+55:t+48;
   1F57 3E 09         [ 7]   76 	ld	a,#0x09
   1F59 95            [ 4]   77 	sub	a, l
   1F5A 30 05         [12]   78 	jr	NC,00110$
   1F5C 7D            [ 4]   79 	ld	a,l
   1F5D C6 37         [ 7]   80 	add	a, #0x37
   1F5F 18 03         [12]   81 	jr	00111$
   1F61                      82 00110$:
   1F61 7D            [ 4]   83 	ld	a,l
   1F62 C6 30         [ 7]   84 	add	a, #0x30
   1F64                      85 00111$:
                             86 ;src/StringUtils.c:48: *charPosition=t;
   1F64 12            [ 7]   87 	ld	(de),a
                             88 ;src/StringUtils.c:49: n>>=4;
   1F65 DD 7E 04      [19]   89 	ld	a,4 (ix)
   1F68 07            [ 4]   90 	rlca
   1F69 07            [ 4]   91 	rlca
   1F6A 07            [ 4]   92 	rlca
   1F6B 07            [ 4]   93 	rlca
   1F6C E6 0F         [ 7]   94 	and	a,#0x0F
   1F6E DD 77 04      [19]   95 	ld	4 (ix),a
                             96 ;src/StringUtils.c:50: --charPosition;
   1F71 1B            [ 6]   97 	dec	de
                             98 ;src/StringUtils.c:52: t=n>9?n+55:n+48;
   1F72 3E 09         [ 7]   99 	ld	a,#0x09
   1F74 DD 96 04      [19]  100 	sub	a, 4 (ix)
   1F77 30 07         [12]  101 	jr	NC,00112$
   1F79 DD 7E 04      [19]  102 	ld	a,4 (ix)
   1F7C C6 37         [ 7]  103 	add	a, #0x37
   1F7E 18 05         [12]  104 	jr	00113$
   1F80                     105 00112$:
   1F80 DD 7E 04      [19]  106 	ld	a,4 (ix)
   1F83 C6 30         [ 7]  107 	add	a, #0x30
   1F85                     108 00113$:
                            109 ;src/StringUtils.c:53: *charPosition=t;
   1F85 12            [ 7]  110 	ld	(de),a
                            111 ;src/StringUtils.c:54: break;
   1F86 C3 0B 20      [10]  112 	jp	00107$
                            113 ;src/StringUtils.c:56: case 'b':{
   1F89                     114 00102$:
                            115 ;src/StringUtils.c:58: charPosition+=8;
   1F89 21 98 20      [10]  116 	ld	hl,#_i_to_s_buffer + 8
                            117 ;src/StringUtils.c:60: while(t){
   1F8C 1E 08         [ 7]  118 	ld	e,#0x08
   1F8E                     119 00103$:
   1F8E 7B            [ 4]  120 	ld	a,e
   1F8F B7            [ 4]  121 	or	a, a
   1F90 28 79         [12]  122 	jr	Z,00107$
                            123 ;src/StringUtils.c:61: --t;
   1F92 1D            [ 4]  124 	dec	e
                            125 ;src/StringUtils.c:62: --charPosition;
   1F93 2B            [ 6]  126 	dec	hl
                            127 ;src/StringUtils.c:63: *charPosition=(n&1)+48;
   1F94 DD 7E 04      [19]  128 	ld	a,4 (ix)
   1F97 E6 01         [ 7]  129 	and	a, #0x01
   1F99 C6 30         [ 7]  130 	add	a, #0x30
   1F9B 77            [ 7]  131 	ld	(hl),a
                            132 ;src/StringUtils.c:64: n>>=1;
   1F9C DD CB 04 3E   [23]  133 	srl	4 (ix)
   1FA0 18 EC         [12]  134 	jr	00103$
                            135 ;src/StringUtils.c:68: default:{
   1FA2                     136 00106$:
                            137 ;src/StringUtils.c:69: charPosition+=3;
   1FA2 11 93 20      [10]  138 	ld	de,#_i_to_s_buffer + 3
                            139 ;src/StringUtils.c:71: *charPosition = 0;
   1FA5 AF            [ 4]  140 	xor	a, a
   1FA6 12            [ 7]  141 	ld	(de),a
                            142 ;src/StringUtils.c:73: --charPosition;
   1FA7 1B            [ 6]  143 	dec	de
                            144 ;src/StringUtils.c:75: *charPosition=48+(n%10);
   1FA8 C5            [11]  145 	push	bc
   1FA9 D5            [11]  146 	push	de
   1FAA 3E 0A         [ 7]  147 	ld	a,#0x0A
   1FAC F5            [11]  148 	push	af
   1FAD 33            [ 6]  149 	inc	sp
   1FAE DD 7E 04      [19]  150 	ld	a,4 (ix)
   1FB1 F5            [11]  151 	push	af
   1FB2 33            [ 6]  152 	inc	sp
   1FB3 CD 81 4C      [17]  153 	call	__moduchar
   1FB6 F1            [10]  154 	pop	af
   1FB7 D1            [10]  155 	pop	de
   1FB8 C1            [10]  156 	pop	bc
   1FB9 7D            [ 4]  157 	ld	a,l
   1FBA C6 30         [ 7]  158 	add	a, #0x30
   1FBC 12            [ 7]  159 	ld	(de),a
                            160 ;src/StringUtils.c:76: --charPosition;
                            161 ;src/StringUtils.c:77: n/=10;
   1FBD C5            [11]  162 	push	bc
   1FBE 3E 0A         [ 7]  163 	ld	a,#0x0A
   1FC0 F5            [11]  164 	push	af
   1FC1 33            [ 6]  165 	inc	sp
   1FC2 DD 7E 04      [19]  166 	ld	a,4 (ix)
   1FC5 F5            [11]  167 	push	af
   1FC6 33            [ 6]  168 	inc	sp
   1FC7 CD A0 4C      [17]  169 	call	__divuchar
   1FCA F1            [10]  170 	pop	af
   1FCB C1            [10]  171 	pop	bc
   1FCC DD 75 04      [19]  172 	ld	4 (ix),l
                            173 ;src/StringUtils.c:78: *charPosition=48+(n%10);
   1FCF C5            [11]  174 	push	bc
   1FD0 3E 0A         [ 7]  175 	ld	a,#0x0A
   1FD2 F5            [11]  176 	push	af
   1FD3 33            [ 6]  177 	inc	sp
   1FD4 DD 7E 04      [19]  178 	ld	a,4 (ix)
   1FD7 F5            [11]  179 	push	af
   1FD8 33            [ 6]  180 	inc	sp
   1FD9 CD 81 4C      [17]  181 	call	__moduchar
   1FDC F1            [10]  182 	pop	af
   1FDD C1            [10]  183 	pop	bc
   1FDE 7D            [ 4]  184 	ld	a,l
   1FDF C6 30         [ 7]  185 	add	a, #0x30
   1FE1 32 91 20      [13]  186 	ld	(#(_i_to_s_buffer + 0x0001)),a
                            187 ;src/StringUtils.c:79: --charPosition;
                            188 ;src/StringUtils.c:80: n/=10;
   1FE4 C5            [11]  189 	push	bc
   1FE5 3E 0A         [ 7]  190 	ld	a,#0x0A
   1FE7 F5            [11]  191 	push	af
   1FE8 33            [ 6]  192 	inc	sp
   1FE9 DD 7E 04      [19]  193 	ld	a,4 (ix)
   1FEC F5            [11]  194 	push	af
   1FED 33            [ 6]  195 	inc	sp
   1FEE CD A0 4C      [17]  196 	call	__divuchar
   1FF1 F1            [10]  197 	pop	af
   1FF2 C1            [10]  198 	pop	bc
   1FF3 DD 75 04      [19]  199 	ld	4 (ix),l
                            200 ;src/StringUtils.c:81: *charPosition=48+(n%10);
   1FF6 C5            [11]  201 	push	bc
   1FF7 3E 0A         [ 7]  202 	ld	a,#0x0A
   1FF9 F5            [11]  203 	push	af
   1FFA 33            [ 6]  204 	inc	sp
   1FFB DD 7E 04      [19]  205 	ld	a,4 (ix)
   1FFE F5            [11]  206 	push	af
   1FFF 33            [ 6]  207 	inc	sp
   2000 CD 81 4C      [17]  208 	call	__moduchar
   2003 F1            [10]  209 	pop	af
   2004 C1            [10]  210 	pop	bc
   2005 7D            [ 4]  211 	ld	a,l
   2006 C6 30         [ 7]  212 	add	a, #0x30
   2008 32 90 20      [13]  213 	ld	(#_i_to_s_buffer),a
                            214 ;src/StringUtils.c:84: }
   200B                     215 00107$:
                            216 ;src/StringUtils.c:86: return i_to_s_buffer;
   200B 69            [ 4]  217 	ld	l, c
   200C 60            [ 4]  218 	ld	h, b
   200D DD E1         [14]  219 	pop	ix
   200F C9            [10]  220 	ret
   2010                     221 _charArray:
   2010 FF                  222 	.db #0xFF	; 255
   2011 FF                  223 	.db #0xFF	; 255
   2012 FF                  224 	.db #0xFF	; 255
   2013 FF                  225 	.db #0xFF	; 255
   2014 FF                  226 	.db #0xFF	; 255
   2015 FF                  227 	.db #0xFF	; 255
   2016 FF                  228 	.db #0xFF	; 255
   2017 FF                  229 	.db #0xFF	; 255
   2018 FF                  230 	.db #0xFF	; 255
   2019 FF                  231 	.db #0xFF	; 255
   201A FF                  232 	.db #0xFF	; 255
   201B FF                  233 	.db #0xFF	; 255
   201C FF                  234 	.db #0xFF	; 255
   201D FF                  235 	.db #0xFF	; 255
   201E FF                  236 	.db #0xFF	; 255
   201F FF                  237 	.db #0xFF	; 255
   2020 FF                  238 	.db #0xFF	; 255
   2021 FF                  239 	.db #0xFF	; 255
   2022 FF                  240 	.db #0xFF	; 255
   2023 FF                  241 	.db #0xFF	; 255
   2024 FF                  242 	.db #0xFF	; 255
   2025 FF                  243 	.db #0xFF	; 255
   2026 FF                  244 	.db #0xFF	; 255
   2027 FF                  245 	.db #0xFF	; 255
   2028 FF                  246 	.db #0xFF	; 255
   2029 FF                  247 	.db #0xFF	; 255
   202A FF                  248 	.db #0xFF	; 255
   202B FF                  249 	.db #0xFF	; 255
   202C FF                  250 	.db #0xFF	; 255
   202D FF                  251 	.db #0xFF	; 255
   202E FF                  252 	.db #0xFF	; 255
   202F FF                  253 	.db #0xFF	; 255
   2030 29                  254 	.db #0x29	; 41
   2031 24                  255 	.db #0x24	; 36
   2032 FF                  256 	.db #0xFF	; 255
   2033 2D                  257 	.db #0x2D	; 45
   2034 2F                  258 	.db #0x2F	; 47
   2035 FF                  259 	.db #0xFF	; 255
   2036 2E                  260 	.db #0x2E	; 46
   2037 FF                  261 	.db #0xFF	; 255
   2038 FF                  262 	.db #0xFF	; 255
   2039 FF                  263 	.db #0xFF	; 255
   203A 31                  264 	.db #0x31	; 49	'1'
   203B 2C                  265 	.db #0x2C	; 44
   203C FF                  266 	.db #0xFF	; 255
   203D FF                  267 	.db #0xFF	; 255
   203E 26                  268 	.db #0x26	; 38
   203F FF                  269 	.db #0xFF	; 255
   2040 1A                  270 	.db #0x1A	; 26
   2041 1B                  271 	.db #0x1B	; 27
   2042 1C                  272 	.db #0x1C	; 28
   2043 1D                  273 	.db #0x1D	; 29
   2044 1E                  274 	.db #0x1E	; 30
   2045 1F                  275 	.db #0x1F	; 31
   2046 20                  276 	.db #0x20	; 32
   2047 21                  277 	.db #0x21	; 33
   2048 22                  278 	.db #0x22	; 34
   2049 23                  279 	.db #0x23	; 35
   204A 27                  280 	.db #0x27	; 39
   204B FF                  281 	.db #0xFF	; 255
   204C 2A                  282 	.db #0x2A	; 42
   204D FF                  283 	.db #0xFF	; 255
   204E 2B                  284 	.db #0x2B	; 43
   204F 25                  285 	.db #0x25	; 37
   2050 28                  286 	.db #0x28	; 40
   2051 00                  287 	.db #0x00	; 0
   2052 01                  288 	.db #0x01	; 1
   2053 02                  289 	.db #0x02	; 2
   2054 03                  290 	.db #0x03	; 3
   2055 04                  291 	.db #0x04	; 4
   2056 05                  292 	.db #0x05	; 5
   2057 06                  293 	.db #0x06	; 6
   2058 07                  294 	.db #0x07	; 7
   2059 08                  295 	.db #0x08	; 8
   205A 09                  296 	.db #0x09	; 9
   205B 0A                  297 	.db #0x0A	; 10
   205C 0B                  298 	.db #0x0B	; 11
   205D 0C                  299 	.db #0x0C	; 12
   205E 0D                  300 	.db #0x0D	; 13
   205F 0E                  301 	.db #0x0E	; 14
   2060 0F                  302 	.db #0x0F	; 15
   2061 10                  303 	.db #0x10	; 16
   2062 11                  304 	.db #0x11	; 17
   2063 12                  305 	.db #0x12	; 18
   2064 13                  306 	.db #0x13	; 19
   2065 14                  307 	.db #0x14	; 20
   2066 15                  308 	.db #0x15	; 21
   2067 16                  309 	.db #0x16	; 22
   2068 17                  310 	.db #0x17	; 23
   2069 18                  311 	.db #0x18	; 24
   206A 19                  312 	.db #0x19	; 25
   206B FF                  313 	.db #0xFF	; 255
   206C FF                  314 	.db #0xFF	; 255
   206D FF                  315 	.db #0xFF	; 255
   206E FF                  316 	.db #0xFF	; 255
   206F FF                  317 	.db #0xFF	; 255
   2070 FF                  318 	.db #0xFF	; 255
   2071 00                  319 	.db #0x00	; 0
   2072 01                  320 	.db #0x01	; 1
   2073 02                  321 	.db #0x02	; 2
   2074 03                  322 	.db #0x03	; 3
   2075 04                  323 	.db #0x04	; 4
   2076 05                  324 	.db #0x05	; 5
   2077 06                  325 	.db #0x06	; 6
   2078 07                  326 	.db #0x07	; 7
   2079 08                  327 	.db #0x08	; 8
   207A 09                  328 	.db #0x09	; 9
   207B 0A                  329 	.db #0x0A	; 10
   207C 0B                  330 	.db #0x0B	; 11
   207D 0C                  331 	.db #0x0C	; 12
   207E 0D                  332 	.db #0x0D	; 13
   207F 0E                  333 	.db #0x0E	; 14
   2080 0F                  334 	.db #0x0F	; 15
   2081 10                  335 	.db #0x10	; 16
   2082 11                  336 	.db #0x11	; 17
   2083 12                  337 	.db #0x12	; 18
   2084 13                  338 	.db #0x13	; 19
   2085 14                  339 	.db #0x14	; 20
   2086 15                  340 	.db #0x15	; 21
   2087 16                  341 	.db #0x16	; 22
   2088 17                  342 	.db #0x17	; 23
   2089 18                  343 	.db #0x18	; 24
   208A 19                  344 	.db #0x19	; 25
   208B FF                  345 	.db #0xFF	; 255
   208C FF                  346 	.db #0xFF	; 255
   208D FF                  347 	.db #0xFF	; 255
   208E 30                  348 	.db #0x30	; 48	'0'
   208F FF                  349 	.db #0xFF	; 255
   2090                     350 _i_to_s_buffer:
   2090 00                  351 	.db #0x00	; 0
   2091 00                  352 	.db #0x00	; 0
   2092 00                  353 	.db #0x00	; 0
   2093 00                  354 	.db #0x00	; 0
   2094 00                  355 	.db #0x00	; 0
   2095 00                  356 	.db #0x00	; 0
   2096 00                  357 	.db #0x00	; 0
   2097 00                  358 	.db #0x00	; 0
   2098 00                  359 	.db #0x00	; 0
                            360 ;src/StringUtils.c:90: void print_text(void * const text, u8* position, u8 bg, u8 fg){
                            361 ;	---------------------------------
                            362 ; Function print_text
                            363 ; ---------------------------------
   2099                     364 _print_text::
   2099 DD E5         [15]  365 	push	ix
   209B DD 21 00 00   [14]  366 	ld	ix,#0
   209F DD 39         [15]  367 	add	ix,sp
   20A1 21 EF FF      [10]  368 	ld	hl,#-17
   20A4 39            [11]  369 	add	hl,sp
   20A5 F9            [ 6]  370 	ld	sp,hl
                            371 ;src/StringUtils.c:91: u8 val, charBitArray, spritePos, fgColor=g_colors[fg], bgColor=g_colors[bg];
   20A6 DD 7E 09      [19]  372 	ld	a,9 (ix)
   20A9 C6 A3         [ 7]  373 	add	a, #<(_g_colors)
   20AB DD 77 FC      [19]  374 	ld	-4 (ix),a
   20AE 3E 00         [ 7]  375 	ld	a,#0x00
   20B0 CE 0A         [ 7]  376 	adc	a, #>(_g_colors)
   20B2 DD 77 FD      [19]  377 	ld	-3 (ix),a
   20B5 DD 6E FC      [19]  378 	ld	l,-4 (ix)
   20B8 DD 66 FD      [19]  379 	ld	h,-3 (ix)
   20BB 7E            [ 7]  380 	ld	a,(hl)
   20BC DD 77 F3      [19]  381 	ld	-13 (ix),a
   20BF 3E A3         [ 7]  382 	ld	a,#<(_g_colors)
   20C1 DD 86 08      [19]  383 	add	a, 8 (ix)
   20C4 DD 77 FC      [19]  384 	ld	-4 (ix),a
   20C7 3E 0A         [ 7]  385 	ld	a,#>(_g_colors)
   20C9 CE 00         [ 7]  386 	adc	a, #0x00
   20CB DD 77 FD      [19]  387 	ld	-3 (ix),a
   20CE DD 6E FC      [19]  388 	ld	l,-4 (ix)
   20D1 DD 66 FD      [19]  389 	ld	h,-3 (ix)
   20D4 7E            [ 7]  390 	ld	a,(hl)
   20D5 DD 77 F2      [19]  391 	ld	-14 (ix),a
                            392 ;src/StringUtils.c:97: (position)+=0x2800;
   20D8 DD 7E 06      [19]  393 	ld	a,6 (ix)
   20DB C6 00         [ 7]  394 	add	a, #0x00
   20DD DD 77 06      [19]  395 	ld	6 (ix),a
   20E0 DD 7E 07      [19]  396 	ld	a,7 (ix)
   20E3 CE 28         [ 7]  397 	adc	a, #0x28
   20E5 DD 77 07      [19]  398 	ld	7 (ix),a
                            399 ;src/StringUtils.c:98: if(position<0x2800){
   20E8 DD 4E 06      [19]  400 	ld	c,6 (ix)
   20EB DD 46 07      [19]  401 	ld	b,7 (ix)
   20EE 78            [ 4]  402 	ld	a,b
   20EF D6 28         [ 7]  403 	sub	a, #0x28
   20F1 30 20         [12]  404 	jr	NC,00132$
                            405 ;src/StringUtils.c:99: position-=0x4000;
   20F3 DD 7E 06      [19]  406 	ld	a,6 (ix)
   20F6 C6 00         [ 7]  407 	add	a,#0x00
   20F8 DD 77 06      [19]  408 	ld	6 (ix),a
   20FB DD 7E 07      [19]  409 	ld	a,7 (ix)
   20FE CE C0         [ 7]  410 	adc	a,#0xC0
   2100 DD 77 07      [19]  411 	ld	7 (ix),a
                            412 ;src/StringUtils.c:100: position+=80;
   2103 DD 7E 06      [19]  413 	ld	a,6 (ix)
   2106 C6 50         [ 7]  414 	add	a, #0x50
   2108 DD 77 06      [19]  415 	ld	6 (ix),a
   210B DD 7E 07      [19]  416 	ld	a,7 (ix)
   210E CE 00         [ 7]  417 	adc	a, #0x00
   2110 DD 77 07      [19]  418 	ld	7 (ix),a
                            419 ;src/StringUtils.c:103: while(height){
   2113                     420 00132$:
   2113 DD 36 F1 06   [19]  421 	ld	-15 (ix),#0x06
   2117 DD 36 FC 96   [19]  422 	ld	-4 (ix),#0x96
   211B                     423 00110$:
   211B DD 7E F1      [19]  424 	ld	a,-15 (ix)
   211E B7            [ 4]  425 	or	a, a
   211F CA 6B 22      [10]  426 	jp	Z,00113$
                            427 ;src/StringUtils.c:104: --height;
   2122 DD 7E FC      [19]  428 	ld	a,-4 (ix)
   2125 C6 E7         [ 7]  429 	add	a,#0xE7
   2127 DD 77 FC      [19]  430 	ld	-4 (ix),a
   212A DD 35 F1      [23]  431 	dec	-15 (ix)
                            432 ;src/StringUtils.c:105: currentChar=text;
   212D DD 7E 04      [19]  433 	ld	a,4 (ix)
   2130 DD 77 F8      [19]  434 	ld	-8 (ix),a
   2133 DD 7E 05      [19]  435 	ld	a,5 (ix)
   2136 DD 77 F9      [19]  436 	ld	-7 (ix),a
                            437 ;src/StringUtils.c:106: currentPos=position;
   2139 DD 7E 06      [19]  438 	ld	a,6 (ix)
   213C DD 77 FA      [19]  439 	ld	-6 (ix),a
   213F DD 7E 07      [19]  440 	ld	a,7 (ix)
   2142 DD 77 FB      [19]  441 	ld	-5 (ix),a
                            442 ;src/StringUtils.c:108: while(*currentChar){
   2145                     443 00105$:
   2145 DD 6E F8      [19]  444 	ld	l,-8 (ix)
   2148 DD 66 F9      [19]  445 	ld	h,-7 (ix)
   214B 7E            [ 7]  446 	ld	a,(hl)
   214C DD 77 F7      [19]  447 	ld	-9 (ix), a
   214F B7            [ 4]  448 	or	a, a
   2150 CA 33 22      [10]  449 	jp	Z,00107$
                            450 ;src/StringUtils.c:110: spritePos = charArray[(*currentChar)];
   2153 3E 10         [ 7]  451 	ld	a,#<(_charArray)
   2155 DD 86 F7      [19]  452 	add	a, -9 (ix)
   2158 DD 77 FE      [19]  453 	ld	-2 (ix),a
   215B 3E 20         [ 7]  454 	ld	a,#>(_charArray)
   215D CE 00         [ 7]  455 	adc	a, #0x00
   215F DD 77 FF      [19]  456 	ld	-1 (ix),a
   2162 DD 6E FE      [19]  457 	ld	l,-2 (ix)
   2165 DD 66 FF      [19]  458 	ld	h,-1 (ix)
   2168 7E            [ 7]  459 	ld	a,(hl)
                            460 ;src/StringUtils.c:112: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   2169 DD 77 F4      [19]  461 	ld	-12 (ix), a
   216C CB 3F         [ 8]  462 	srl	a
   216E DD 77 FE      [19]  463 	ld	-2 (ix), a
   2171 DD 86 FC      [19]  464 	add	a, -4 (ix)
   2174 DD 77 FE      [19]  465 	ld	-2 (ix),a
   2177 C6 84         [ 7]  466 	add	a,#<(_typography_4x6_monospaced)
   2179 DD 77 FE      [19]  467 	ld	-2 (ix),a
   217C 3E 32         [ 7]  468 	ld	a,#>(_typography_4x6_monospaced)
   217E CE 00         [ 7]  469 	adc	a, #0x00
   2180 DD 77 FF      [19]  470 	ld	-1 (ix),a
   2183 DD 6E FE      [19]  471 	ld	l,-2 (ix)
   2186 DD 66 FF      [19]  472 	ld	h,-1 (ix)
   2189 7E            [ 7]  473 	ld	a,(hl)
   218A DD 77 FE      [19]  474 	ld	-2 (ix),a
                            475 ;src/StringUtils.c:114: if(spritePos%2) charBitArray<<=4;
   218D DD CB F4 46   [20]  476 	bit	0, -12 (ix)
   2191 28 0C         [12]  477 	jr	Z,00104$
   2193 DD 7E FE      [19]  478 	ld	a,-2 (ix)
   2196 07            [ 4]  479 	rlca
   2197 07            [ 4]  480 	rlca
   2198 07            [ 4]  481 	rlca
   2199 07            [ 4]  482 	rlca
   219A E6 F0         [ 7]  483 	and	a,#0xF0
   219C DD 77 FE      [19]  484 	ld	-2 (ix),a
   219F                     485 00104$:
                            486 ;src/StringUtils.c:118: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   219F DD CB FE 7E   [20]  487 	bit	7, -2 (ix)
   21A3 28 05         [12]  488 	jr	Z,00115$
   21A5 DD 7E F3      [19]  489 	ld	a,-13 (ix)
   21A8 18 03         [12]  490 	jr	00116$
   21AA                     491 00115$:
   21AA DD 7E F2      [19]  492 	ld	a,-14 (ix)
   21AD                     493 00116$:
   21AD E6 AA         [ 7]  494 	and	a, #0xAA
   21AF 4F            [ 4]  495 	ld	c,a
                            496 ;src/StringUtils.c:120: charBitArray<<=1;
   21B0 DD 7E FE      [19]  497 	ld	a,-2 (ix)
   21B3 87            [ 4]  498 	add	a, a
   21B4 47            [ 4]  499 	ld	b,a
                            500 ;src/StringUtils.c:122: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   21B5 CB 78         [ 8]  501 	bit	7, b
   21B7 28 05         [12]  502 	jr	Z,00117$
   21B9 DD 7E F3      [19]  503 	ld	a,-13 (ix)
   21BC 18 03         [12]  504 	jr	00118$
   21BE                     505 00117$:
   21BE DD 7E F2      [19]  506 	ld	a,-14 (ix)
   21C1                     507 00118$:
   21C1 E6 55         [ 7]  508 	and	a, #0x55
   21C3 B1            [ 4]  509 	or	a, c
   21C4 4F            [ 4]  510 	ld	c,a
                            511 ;src/StringUtils.c:124: charBitArray<<=1;
   21C5 78            [ 4]  512 	ld	a,b
   21C6 87            [ 4]  513 	add	a, a
   21C7 DD 77 F5      [19]  514 	ld	-11 (ix),a
                            515 ;src/StringUtils.c:126: *currentPos=val;
   21CA DD 6E FA      [19]  516 	ld	l,-6 (ix)
   21CD DD 66 FB      [19]  517 	ld	h,-5 (ix)
   21D0 71            [ 7]  518 	ld	(hl),c
                            519 ;src/StringUtils.c:127: ++currentPos;
   21D1 DD 7E FA      [19]  520 	ld	a,-6 (ix)
   21D4 C6 01         [ 7]  521 	add	a, #0x01
   21D6 DD 77 EF      [19]  522 	ld	-17 (ix),a
   21D9 DD 7E FB      [19]  523 	ld	a,-5 (ix)
   21DC CE 00         [ 7]  524 	adc	a, #0x00
   21DE DD 77 F0      [19]  525 	ld	-16 (ix),a
                            526 ;src/StringUtils.c:131: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   21E1 DD CB F5 7E   [20]  527 	bit	7, -11 (ix)
   21E5 28 05         [12]  528 	jr	Z,00119$
   21E7 DD 7E F3      [19]  529 	ld	a,-13 (ix)
   21EA 18 03         [12]  530 	jr	00120$
   21EC                     531 00119$:
   21EC DD 7E F2      [19]  532 	ld	a,-14 (ix)
   21EF                     533 00120$:
   21EF E6 AA         [ 7]  534 	and	a, #0xAA
   21F1 DD 77 F6      [19]  535 	ld	-10 (ix),a
                            536 ;src/StringUtils.c:133: charBitArray<<=1;
   21F4 DD 7E F5      [19]  537 	ld	a,-11 (ix)
   21F7 87            [ 4]  538 	add	a, a
                            539 ;src/StringUtils.c:135: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   21F8 07            [ 4]  540 	rlca
   21F9 30 05         [12]  541 	jr	NC,00121$
   21FB DD 7E F3      [19]  542 	ld	a,-13 (ix)
   21FE 18 03         [12]  543 	jr	00122$
   2200                     544 00121$:
   2200 DD 7E F2      [19]  545 	ld	a,-14 (ix)
   2203                     546 00122$:
   2203 E6 55         [ 7]  547 	and	a, #0x55
   2205 DD 77 FE      [19]  548 	ld	-2 (ix),a
   2208 DD 7E F6      [19]  549 	ld	a,-10 (ix)
   220B DD B6 FE      [19]  550 	or	a, -2 (ix)
   220E DD 77 FE      [19]  551 	ld	-2 (ix),a
                            552 ;src/StringUtils.c:139: *currentPos=val;
   2211 E1            [10]  553 	pop	hl
   2212 E5            [11]  554 	push	hl
   2213 DD 7E FE      [19]  555 	ld	a,-2 (ix)
   2216 77            [ 7]  556 	ld	(hl),a
                            557 ;src/StringUtils.c:140: ++currentPos;
   2217 DD 7E EF      [19]  558 	ld	a,-17 (ix)
   221A C6 01         [ 7]  559 	add	a, #0x01
   221C DD 77 FA      [19]  560 	ld	-6 (ix),a
   221F DD 7E F0      [19]  561 	ld	a,-16 (ix)
   2222 CE 00         [ 7]  562 	adc	a, #0x00
   2224 DD 77 FB      [19]  563 	ld	-5 (ix),a
                            564 ;src/StringUtils.c:142: ++currentChar;
   2227 DD 34 F8      [23]  565 	inc	-8 (ix)
   222A C2 45 21      [10]  566 	jp	NZ,00105$
   222D DD 34 F9      [23]  567 	inc	-7 (ix)
   2230 C3 45 21      [10]  568 	jp	00105$
   2233                     569 00107$:
                            570 ;src/StringUtils.c:144: position-=0x0800;
   2233 DD 7E 06      [19]  571 	ld	a,6 (ix)
   2236 C6 00         [ 7]  572 	add	a,#0x00
   2238 DD 77 06      [19]  573 	ld	6 (ix),a
   223B DD 7E 07      [19]  574 	ld	a,7 (ix)
   223E CE F8         [ 7]  575 	adc	a,#0xF8
                            576 ;src/StringUtils.c:146: if(position<0xC000){
   2240 DD 77 07      [19]  577 	ld	7 (ix), a
   2243 D6 C0         [ 7]  578 	sub	a, #0xC0
   2245 D2 1B 21      [10]  579 	jp	NC,00110$
                            580 ;src/StringUtils.c:147: position+=0x4000;
   2248 DD 7E 06      [19]  581 	ld	a,6 (ix)
   224B C6 00         [ 7]  582 	add	a, #0x00
   224D DD 77 06      [19]  583 	ld	6 (ix),a
   2250 DD 7E 07      [19]  584 	ld	a,7 (ix)
   2253 CE 40         [ 7]  585 	adc	a, #0x40
   2255 DD 77 07      [19]  586 	ld	7 (ix),a
                            587 ;src/StringUtils.c:148: position-=80;
   2258 DD 7E 06      [19]  588 	ld	a,6 (ix)
   225B C6 B0         [ 7]  589 	add	a,#0xB0
   225D DD 77 06      [19]  590 	ld	6 (ix),a
   2260 DD 7E 07      [19]  591 	ld	a,7 (ix)
   2263 CE FF         [ 7]  592 	adc	a,#0xFF
   2265 DD 77 07      [19]  593 	ld	7 (ix),a
   2268 C3 1B 21      [10]  594 	jp	00110$
   226B                     595 00113$:
   226B DD F9         [10]  596 	ld	sp, ix
   226D DD E1         [14]  597 	pop	ix
   226F C9            [10]  598 	ret
                            599 ;src/StringUtils.c:154: void print_transparent_text(void* const text, u8* position, u8 fg){
                            600 ;	---------------------------------
                            601 ; Function print_transparent_text
                            602 ; ---------------------------------
   2270                     603 _print_transparent_text::
   2270 DD E5         [15]  604 	push	ix
   2272 DD 21 00 00   [14]  605 	ld	ix,#0
   2276 DD 39         [15]  606 	add	ix,sp
   2278 21 F8 FF      [10]  607 	ld	hl,#-8
   227B 39            [11]  608 	add	hl,sp
   227C F9            [ 6]  609 	ld	sp,hl
                            610 ;src/StringUtils.c:155: u8 val, charBitArray, spritePos, color = g_colors[fg];
   227D 01 A3 0A      [10]  611 	ld	bc,#_g_colors+0
   2280 DD 6E 08      [19]  612 	ld	l,8 (ix)
   2283 26 00         [ 7]  613 	ld	h,#0x00
   2285 09            [11]  614 	add	hl,bc
   2286 4E            [ 7]  615 	ld	c,(hl)
                            616 ;src/StringUtils.c:161: (position)+=0x2800;
   2287 DD 7E 06      [19]  617 	ld	a,6 (ix)
   228A C6 00         [ 7]  618 	add	a, #0x00
   228C DD 77 06      [19]  619 	ld	6 (ix),a
   228F DD 7E 07      [19]  620 	ld	a,7 (ix)
   2292 CE 28         [ 7]  621 	adc	a, #0x28
   2294 DD 77 07      [19]  622 	ld	7 (ix),a
                            623 ;src/StringUtils.c:162: if(position<0x2800){
   2297 DD 46 06      [19]  624 	ld	b,6 (ix)
   229A DD 5E 07      [19]  625 	ld	e,7 (ix)
   229D 7B            [ 4]  626 	ld	a,e
   229E D6 28         [ 7]  627 	sub	a, #0x28
   22A0 30 20         [12]  628 	jr	NC,00132$
                            629 ;src/StringUtils.c:163: position-=0x4000;
   22A2 DD 7E 06      [19]  630 	ld	a,6 (ix)
   22A5 C6 00         [ 7]  631 	add	a,#0x00
   22A7 DD 77 06      [19]  632 	ld	6 (ix),a
   22AA DD 7E 07      [19]  633 	ld	a,7 (ix)
   22AD CE C0         [ 7]  634 	adc	a,#0xC0
   22AF DD 77 07      [19]  635 	ld	7 (ix),a
                            636 ;src/StringUtils.c:164: position+=80;
   22B2 DD 7E 06      [19]  637 	ld	a,6 (ix)
   22B5 C6 50         [ 7]  638 	add	a, #0x50
   22B7 DD 77 06      [19]  639 	ld	6 (ix),a
   22BA DD 7E 07      [19]  640 	ld	a,7 (ix)
   22BD CE 00         [ 7]  641 	adc	a, #0x00
   22BF DD 77 07      [19]  642 	ld	7 (ix),a
                            643 ;src/StringUtils.c:167: while(height){
   22C2                     644 00132$:
   22C2 79            [ 4]  645 	ld	a,c
   22C3 E6 AA         [ 7]  646 	and	a, #0xAA
   22C5 DD 77 FA      [19]  647 	ld	-6 (ix),a
   22C8 79            [ 4]  648 	ld	a,c
   22C9 E6 55         [ 7]  649 	and	a, #0x55
   22CB DD 77 FB      [19]  650 	ld	-5 (ix),a
   22CE DD 36 F8 06   [19]  651 	ld	-8 (ix),#0x06
   22D2 DD 36 F9 96   [19]  652 	ld	-7 (ix),#0x96
   22D6                     653 00118$:
   22D6 DD 7E F8      [19]  654 	ld	a,-8 (ix)
   22D9 B7            [ 4]  655 	or	a, a
   22DA CA C2 23      [10]  656 	jp	Z,00121$
                            657 ;src/StringUtils.c:168: currentChar=text;
   22DD DD 7E 04      [19]  658 	ld	a,4 (ix)
   22E0 DD 77 FE      [19]  659 	ld	-2 (ix),a
   22E3 DD 7E 05      [19]  660 	ld	a,5 (ix)
   22E6 DD 77 FF      [19]  661 	ld	-1 (ix),a
                            662 ;src/StringUtils.c:169: currentPos=position;
   22E9 DD 7E 06      [19]  663 	ld	a,6 (ix)
   22EC DD 77 FC      [19]  664 	ld	-4 (ix),a
   22EF DD 7E 07      [19]  665 	ld	a,7 (ix)
   22F2 DD 77 FD      [19]  666 	ld	-3 (ix),a
                            667 ;src/StringUtils.c:170: --height;
   22F5 DD 7E F9      [19]  668 	ld	a,-7 (ix)
   22F8 C6 E7         [ 7]  669 	add	a,#0xE7
   22FA DD 77 F9      [19]  670 	ld	-7 (ix),a
   22FD DD 35 F8      [23]  671 	dec	-8 (ix)
                            672 ;src/StringUtils.c:171: while(*currentChar){
   2300                     673 00113$:
   2300 DD 6E FE      [19]  674 	ld	l,-2 (ix)
   2303 DD 66 FF      [19]  675 	ld	h,-1 (ix)
   2306 4E            [ 7]  676 	ld	c,(hl)
   2307 79            [ 4]  677 	ld	a,c
   2308 B7            [ 4]  678 	or	a, a
   2309 CA 8A 23      [10]  679 	jp	Z,00115$
                            680 ;src/StringUtils.c:173: spritePos = charArray[(*currentChar)];
   230C 21 10 20      [10]  681 	ld	hl,#_charArray
   230F 06 00         [ 7]  682 	ld	b,#0x00
   2311 09            [11]  683 	add	hl, bc
   2312 46            [ 7]  684 	ld	b,(hl)
                            685 ;src/StringUtils.c:175: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   2313 78            [ 4]  686 	ld	a, b
   2314 CB 3F         [ 8]  687 	srl	a
   2316 DD 86 F9      [19]  688 	add	a, -7 (ix)
   2319 5F            [ 4]  689 	ld	e,a
   231A 21 84 32      [10]  690 	ld	hl,#_typography_4x6_monospaced
   231D 16 00         [ 7]  691 	ld	d,#0x00
   231F 19            [11]  692 	add	hl, de
   2320 4E            [ 7]  693 	ld	c,(hl)
                            694 ;src/StringUtils.c:177: if(spritePos%2) charBitArray<<=4;
   2321 CB 40         [ 8]  695 	bit	0, b
   2323 28 08         [12]  696 	jr	Z,00104$
   2325 79            [ 4]  697 	ld	a,c
   2326 07            [ 4]  698 	rlca
   2327 07            [ 4]  699 	rlca
   2328 07            [ 4]  700 	rlca
   2329 07            [ 4]  701 	rlca
   232A E6 F0         [ 7]  702 	and	a,#0xF0
   232C 4F            [ 4]  703 	ld	c,a
   232D                     704 00104$:
                            705 ;src/StringUtils.c:179: val=*currentPos;
   232D DD 6E FC      [19]  706 	ld	l,-4 (ix)
   2330 DD 66 FD      [19]  707 	ld	h,-3 (ix)
   2333 5E            [ 7]  708 	ld	e,(hl)
                            709 ;src/StringUtils.c:181: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
   2334 CB 79         [ 8]  710 	bit	7, c
   2336 28 07         [12]  711 	jr	Z,00106$
   2338 7B            [ 4]  712 	ld	a,e
   2339 E6 55         [ 7]  713 	and	a, #0x55
   233B DD B6 FA      [19]  714 	or	a, -6 (ix)
   233E 5F            [ 4]  715 	ld	e,a
   233F                     716 00106$:
                            717 ;src/StringUtils.c:183: charBitArray<<=1;
   233F CB 21         [ 8]  718 	sla	c
                            719 ;src/StringUtils.c:185: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
   2341 CB 79         [ 8]  720 	bit	7, c
   2343 28 07         [12]  721 	jr	Z,00108$
   2345 7B            [ 4]  722 	ld	a,e
   2346 E6 AA         [ 7]  723 	and	a, #0xAA
   2348 DD B6 FB      [19]  724 	or	a, -5 (ix)
   234B 5F            [ 4]  725 	ld	e,a
   234C                     726 00108$:
                            727 ;src/StringUtils.c:187: charBitArray<<=1;
   234C CB 21         [ 8]  728 	sla	c
                            729 ;src/StringUtils.c:189: *currentPos=val;
   234E DD 6E FC      [19]  730 	ld	l,-4 (ix)
   2351 DD 66 FD      [19]  731 	ld	h,-3 (ix)
   2354 73            [ 7]  732 	ld	(hl),e
                            733 ;src/StringUtils.c:190: ++currentPos;
   2355 DD 5E FC      [19]  734 	ld	e,-4 (ix)
   2358 DD 56 FD      [19]  735 	ld	d,-3 (ix)
   235B 13            [ 6]  736 	inc	de
                            737 ;src/StringUtils.c:192: val=*currentPos;
   235C 1A            [ 7]  738 	ld	a,(de)
   235D 47            [ 4]  739 	ld	b,a
                            740 ;src/StringUtils.c:194: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
   235E CB 79         [ 8]  741 	bit	7, c
   2360 28 07         [12]  742 	jr	Z,00110$
   2362 78            [ 4]  743 	ld	a,b
   2363 E6 55         [ 7]  744 	and	a, #0x55
   2365 DD B6 FA      [19]  745 	or	a, -6 (ix)
   2368 47            [ 4]  746 	ld	b,a
   2369                     747 00110$:
                            748 ;src/StringUtils.c:196: charBitArray<<=1;
   2369 79            [ 4]  749 	ld	a,c
   236A 87            [ 4]  750 	add	a, a
                            751 ;src/StringUtils.c:198: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
   236B 07            [ 4]  752 	rlca
   236C 30 07         [12]  753 	jr	NC,00112$
   236E 78            [ 4]  754 	ld	a,b
   236F E6 AA         [ 7]  755 	and	a, #0xAA
   2371 DD B6 FB      [19]  756 	or	a, -5 (ix)
   2374 47            [ 4]  757 	ld	b,a
   2375                     758 00112$:
                            759 ;src/StringUtils.c:202: *currentPos=val;
   2375 78            [ 4]  760 	ld	a,b
   2376 12            [ 7]  761 	ld	(de),a
                            762 ;src/StringUtils.c:203: ++currentPos;
   2377 13            [ 6]  763 	inc	de
   2378 DD 73 FC      [19]  764 	ld	-4 (ix),e
   237B DD 72 FD      [19]  765 	ld	-3 (ix),d
                            766 ;src/StringUtils.c:205: ++currentChar;
   237E DD 34 FE      [23]  767 	inc	-2 (ix)
   2381 C2 00 23      [10]  768 	jp	NZ,00113$
   2384 DD 34 FF      [23]  769 	inc	-1 (ix)
   2387 C3 00 23      [10]  770 	jp	00113$
   238A                     771 00115$:
                            772 ;src/StringUtils.c:207: position-=0x0800;
   238A DD 7E 06      [19]  773 	ld	a,6 (ix)
   238D C6 00         [ 7]  774 	add	a,#0x00
   238F DD 77 06      [19]  775 	ld	6 (ix),a
   2392 DD 7E 07      [19]  776 	ld	a,7 (ix)
   2395 CE F8         [ 7]  777 	adc	a,#0xF8
                            778 ;src/StringUtils.c:209: if(position<0xC000){
   2397 DD 77 07      [19]  779 	ld	7 (ix), a
   239A D6 C0         [ 7]  780 	sub	a, #0xC0
   239C D2 D6 22      [10]  781 	jp	NC,00118$
                            782 ;src/StringUtils.c:210: position+=0x4000;
   239F DD 7E 06      [19]  783 	ld	a,6 (ix)
   23A2 C6 00         [ 7]  784 	add	a, #0x00
   23A4 DD 77 06      [19]  785 	ld	6 (ix),a
   23A7 DD 7E 07      [19]  786 	ld	a,7 (ix)
   23AA CE 40         [ 7]  787 	adc	a, #0x40
   23AC DD 77 07      [19]  788 	ld	7 (ix),a
                            789 ;src/StringUtils.c:211: position-=80;
   23AF DD 7E 06      [19]  790 	ld	a,6 (ix)
   23B2 C6 B0         [ 7]  791 	add	a,#0xB0
   23B4 DD 77 06      [19]  792 	ld	6 (ix),a
   23B7 DD 7E 07      [19]  793 	ld	a,7 (ix)
   23BA CE FF         [ 7]  794 	adc	a,#0xFF
   23BC DD 77 07      [19]  795 	ld	7 (ix),a
   23BF C3 D6 22      [10]  796 	jp	00118$
   23C2                     797 00121$:
   23C2 DD F9         [10]  798 	ld	sp, ix
   23C4 DD E1         [14]  799 	pop	ix
   23C6 C9            [10]  800 	ret
                            801 	.area _CODE
                            802 	.area _INITIALIZER
                            803 	.area _CABS (ABS)
