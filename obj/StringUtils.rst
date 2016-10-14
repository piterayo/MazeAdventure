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
   1E6D                      51 _integer_to_string::
   1E6D DD E5         [15]   52 	push	ix
   1E6F DD 21 00 00   [14]   53 	ld	ix,#0
   1E73 DD 39         [15]   54 	add	ix,sp
                             55 ;src/StringUtils.c:36: u8* charPosition=(u8*)&i_to_s_buffer;
   1E75 01 CB 1F      [10]   56 	ld	bc,#_i_to_s_buffer+0
                             57 ;src/StringUtils.c:38: switch(format){
   1E78 DD 7E 05      [19]   58 	ld	a,5 (ix)
   1E7B D6 62         [ 7]   59 	sub	a, #0x62
   1E7D 28 45         [12]   60 	jr	Z,00102$
   1E7F DD 7E 05      [19]   61 	ld	a,5 (ix)
   1E82 D6 68         [ 7]   62 	sub	a, #0x68
   1E84 20 57         [12]   63 	jr	NZ,00106$
                             64 ;src/StringUtils.c:40: charPosition+=2;
   1E86 11 CD 1F      [10]   65 	ld	de,#_i_to_s_buffer + 2
                             66 ;src/StringUtils.c:42: *charPosition = 0;
   1E89 AF            [ 4]   67 	xor	a, a
   1E8A 12            [ 7]   68 	ld	(de),a
                             69 ;src/StringUtils.c:44: --charPosition;
   1E8B 1B            [ 6]   70 	dec	de
                             71 ;src/StringUtils.c:46: t=n&0x0F;
   1E8C DD 7E 04      [19]   72 	ld	a,4 (ix)
   1E8F E6 0F         [ 7]   73 	and	a, #0x0F
   1E91 6F            [ 4]   74 	ld	l,a
                             75 ;src/StringUtils.c:47: t=t>9?t+55:t+48;
   1E92 3E 09         [ 7]   76 	ld	a,#0x09
   1E94 95            [ 4]   77 	sub	a, l
   1E95 30 05         [12]   78 	jr	NC,00110$
   1E97 7D            [ 4]   79 	ld	a,l
   1E98 C6 37         [ 7]   80 	add	a, #0x37
   1E9A 18 03         [12]   81 	jr	00111$
   1E9C                      82 00110$:
   1E9C 7D            [ 4]   83 	ld	a,l
   1E9D C6 30         [ 7]   84 	add	a, #0x30
   1E9F                      85 00111$:
                             86 ;src/StringUtils.c:48: *charPosition=t;
   1E9F 12            [ 7]   87 	ld	(de),a
                             88 ;src/StringUtils.c:49: n>>=4;
   1EA0 DD 7E 04      [19]   89 	ld	a,4 (ix)
   1EA3 07            [ 4]   90 	rlca
   1EA4 07            [ 4]   91 	rlca
   1EA5 07            [ 4]   92 	rlca
   1EA6 07            [ 4]   93 	rlca
   1EA7 E6 0F         [ 7]   94 	and	a,#0x0F
   1EA9 DD 77 04      [19]   95 	ld	4 (ix),a
                             96 ;src/StringUtils.c:50: --charPosition;
   1EAC 1B            [ 6]   97 	dec	de
                             98 ;src/StringUtils.c:52: t=n>9?n+55:n+48;
   1EAD 3E 09         [ 7]   99 	ld	a,#0x09
   1EAF DD 96 04      [19]  100 	sub	a, 4 (ix)
   1EB2 30 07         [12]  101 	jr	NC,00112$
   1EB4 DD 7E 04      [19]  102 	ld	a,4 (ix)
   1EB7 C6 37         [ 7]  103 	add	a, #0x37
   1EB9 18 05         [12]  104 	jr	00113$
   1EBB                     105 00112$:
   1EBB DD 7E 04      [19]  106 	ld	a,4 (ix)
   1EBE C6 30         [ 7]  107 	add	a, #0x30
   1EC0                     108 00113$:
                            109 ;src/StringUtils.c:53: *charPosition=t;
   1EC0 12            [ 7]  110 	ld	(de),a
                            111 ;src/StringUtils.c:54: break;
   1EC1 C3 46 1F      [10]  112 	jp	00107$
                            113 ;src/StringUtils.c:56: case 'b':{
   1EC4                     114 00102$:
                            115 ;src/StringUtils.c:58: charPosition+=8;
   1EC4 21 D3 1F      [10]  116 	ld	hl,#_i_to_s_buffer + 8
                            117 ;src/StringUtils.c:60: while(t){
   1EC7 1E 08         [ 7]  118 	ld	e,#0x08
   1EC9                     119 00103$:
   1EC9 7B            [ 4]  120 	ld	a,e
   1ECA B7            [ 4]  121 	or	a, a
   1ECB 28 79         [12]  122 	jr	Z,00107$
                            123 ;src/StringUtils.c:61: --t;
   1ECD 1D            [ 4]  124 	dec	e
                            125 ;src/StringUtils.c:62: --charPosition;
   1ECE 2B            [ 6]  126 	dec	hl
                            127 ;src/StringUtils.c:63: *charPosition=(n&1)+48;
   1ECF DD 7E 04      [19]  128 	ld	a,4 (ix)
   1ED2 E6 01         [ 7]  129 	and	a, #0x01
   1ED4 C6 30         [ 7]  130 	add	a, #0x30
   1ED6 77            [ 7]  131 	ld	(hl),a
                            132 ;src/StringUtils.c:64: n>>=1;
   1ED7 DD CB 04 3E   [23]  133 	srl	4 (ix)
   1EDB 18 EC         [12]  134 	jr	00103$
                            135 ;src/StringUtils.c:68: default:{
   1EDD                     136 00106$:
                            137 ;src/StringUtils.c:69: charPosition+=3;
   1EDD 11 CE 1F      [10]  138 	ld	de,#_i_to_s_buffer + 3
                            139 ;src/StringUtils.c:71: *charPosition = 0;
   1EE0 AF            [ 4]  140 	xor	a, a
   1EE1 12            [ 7]  141 	ld	(de),a
                            142 ;src/StringUtils.c:73: --charPosition;
   1EE2 1B            [ 6]  143 	dec	de
                            144 ;src/StringUtils.c:75: *charPosition=48+(n%10);
   1EE3 C5            [11]  145 	push	bc
   1EE4 D5            [11]  146 	push	de
   1EE5 3E 0A         [ 7]  147 	ld	a,#0x0A
   1EE7 F5            [11]  148 	push	af
   1EE8 33            [ 6]  149 	inc	sp
   1EE9 DD 7E 04      [19]  150 	ld	a,4 (ix)
   1EEC F5            [11]  151 	push	af
   1EED 33            [ 6]  152 	inc	sp
   1EEE CD 18 46      [17]  153 	call	__moduchar
   1EF1 F1            [10]  154 	pop	af
   1EF2 D1            [10]  155 	pop	de
   1EF3 C1            [10]  156 	pop	bc
   1EF4 7D            [ 4]  157 	ld	a,l
   1EF5 C6 30         [ 7]  158 	add	a, #0x30
   1EF7 12            [ 7]  159 	ld	(de),a
                            160 ;src/StringUtils.c:76: --charPosition;
                            161 ;src/StringUtils.c:77: n/=10;
   1EF8 C5            [11]  162 	push	bc
   1EF9 3E 0A         [ 7]  163 	ld	a,#0x0A
   1EFB F5            [11]  164 	push	af
   1EFC 33            [ 6]  165 	inc	sp
   1EFD DD 7E 04      [19]  166 	ld	a,4 (ix)
   1F00 F5            [11]  167 	push	af
   1F01 33            [ 6]  168 	inc	sp
   1F02 CD 37 46      [17]  169 	call	__divuchar
   1F05 F1            [10]  170 	pop	af
   1F06 C1            [10]  171 	pop	bc
   1F07 DD 75 04      [19]  172 	ld	4 (ix),l
                            173 ;src/StringUtils.c:78: *charPosition=48+(n%10);
   1F0A C5            [11]  174 	push	bc
   1F0B 3E 0A         [ 7]  175 	ld	a,#0x0A
   1F0D F5            [11]  176 	push	af
   1F0E 33            [ 6]  177 	inc	sp
   1F0F DD 7E 04      [19]  178 	ld	a,4 (ix)
   1F12 F5            [11]  179 	push	af
   1F13 33            [ 6]  180 	inc	sp
   1F14 CD 18 46      [17]  181 	call	__moduchar
   1F17 F1            [10]  182 	pop	af
   1F18 C1            [10]  183 	pop	bc
   1F19 7D            [ 4]  184 	ld	a,l
   1F1A C6 30         [ 7]  185 	add	a, #0x30
   1F1C 32 CC 1F      [13]  186 	ld	(#(_i_to_s_buffer + 0x0001)),a
                            187 ;src/StringUtils.c:79: --charPosition;
                            188 ;src/StringUtils.c:80: n/=10;
   1F1F C5            [11]  189 	push	bc
   1F20 3E 0A         [ 7]  190 	ld	a,#0x0A
   1F22 F5            [11]  191 	push	af
   1F23 33            [ 6]  192 	inc	sp
   1F24 DD 7E 04      [19]  193 	ld	a,4 (ix)
   1F27 F5            [11]  194 	push	af
   1F28 33            [ 6]  195 	inc	sp
   1F29 CD 37 46      [17]  196 	call	__divuchar
   1F2C F1            [10]  197 	pop	af
   1F2D C1            [10]  198 	pop	bc
   1F2E DD 75 04      [19]  199 	ld	4 (ix),l
                            200 ;src/StringUtils.c:81: *charPosition=48+(n%10);
   1F31 C5            [11]  201 	push	bc
   1F32 3E 0A         [ 7]  202 	ld	a,#0x0A
   1F34 F5            [11]  203 	push	af
   1F35 33            [ 6]  204 	inc	sp
   1F36 DD 7E 04      [19]  205 	ld	a,4 (ix)
   1F39 F5            [11]  206 	push	af
   1F3A 33            [ 6]  207 	inc	sp
   1F3B CD 18 46      [17]  208 	call	__moduchar
   1F3E F1            [10]  209 	pop	af
   1F3F C1            [10]  210 	pop	bc
   1F40 7D            [ 4]  211 	ld	a,l
   1F41 C6 30         [ 7]  212 	add	a, #0x30
   1F43 32 CB 1F      [13]  213 	ld	(#_i_to_s_buffer),a
                            214 ;src/StringUtils.c:84: }
   1F46                     215 00107$:
                            216 ;src/StringUtils.c:86: return i_to_s_buffer;
   1F46 69            [ 4]  217 	ld	l, c
   1F47 60            [ 4]  218 	ld	h, b
   1F48 DD E1         [14]  219 	pop	ix
   1F4A C9            [10]  220 	ret
   1F4B                     221 _charArray:
   1F4B FF                  222 	.db #0xFF	; 255
   1F4C FF                  223 	.db #0xFF	; 255
   1F4D FF                  224 	.db #0xFF	; 255
   1F4E FF                  225 	.db #0xFF	; 255
   1F4F FF                  226 	.db #0xFF	; 255
   1F50 FF                  227 	.db #0xFF	; 255
   1F51 FF                  228 	.db #0xFF	; 255
   1F52 FF                  229 	.db #0xFF	; 255
   1F53 FF                  230 	.db #0xFF	; 255
   1F54 FF                  231 	.db #0xFF	; 255
   1F55 FF                  232 	.db #0xFF	; 255
   1F56 FF                  233 	.db #0xFF	; 255
   1F57 FF                  234 	.db #0xFF	; 255
   1F58 FF                  235 	.db #0xFF	; 255
   1F59 FF                  236 	.db #0xFF	; 255
   1F5A FF                  237 	.db #0xFF	; 255
   1F5B FF                  238 	.db #0xFF	; 255
   1F5C FF                  239 	.db #0xFF	; 255
   1F5D FF                  240 	.db #0xFF	; 255
   1F5E FF                  241 	.db #0xFF	; 255
   1F5F FF                  242 	.db #0xFF	; 255
   1F60 FF                  243 	.db #0xFF	; 255
   1F61 FF                  244 	.db #0xFF	; 255
   1F62 FF                  245 	.db #0xFF	; 255
   1F63 FF                  246 	.db #0xFF	; 255
   1F64 FF                  247 	.db #0xFF	; 255
   1F65 FF                  248 	.db #0xFF	; 255
   1F66 FF                  249 	.db #0xFF	; 255
   1F67 FF                  250 	.db #0xFF	; 255
   1F68 FF                  251 	.db #0xFF	; 255
   1F69 FF                  252 	.db #0xFF	; 255
   1F6A FF                  253 	.db #0xFF	; 255
   1F6B 29                  254 	.db #0x29	; 41
   1F6C 24                  255 	.db #0x24	; 36
   1F6D FF                  256 	.db #0xFF	; 255
   1F6E 2D                  257 	.db #0x2D	; 45
   1F6F 2F                  258 	.db #0x2F	; 47
   1F70 FF                  259 	.db #0xFF	; 255
   1F71 2E                  260 	.db #0x2E	; 46
   1F72 FF                  261 	.db #0xFF	; 255
   1F73 FF                  262 	.db #0xFF	; 255
   1F74 FF                  263 	.db #0xFF	; 255
   1F75 31                  264 	.db #0x31	; 49	'1'
   1F76 2C                  265 	.db #0x2C	; 44
   1F77 FF                  266 	.db #0xFF	; 255
   1F78 FF                  267 	.db #0xFF	; 255
   1F79 26                  268 	.db #0x26	; 38
   1F7A FF                  269 	.db #0xFF	; 255
   1F7B 1A                  270 	.db #0x1A	; 26
   1F7C 1B                  271 	.db #0x1B	; 27
   1F7D 1C                  272 	.db #0x1C	; 28
   1F7E 1D                  273 	.db #0x1D	; 29
   1F7F 1E                  274 	.db #0x1E	; 30
   1F80 1F                  275 	.db #0x1F	; 31
   1F81 20                  276 	.db #0x20	; 32
   1F82 21                  277 	.db #0x21	; 33
   1F83 22                  278 	.db #0x22	; 34
   1F84 23                  279 	.db #0x23	; 35
   1F85 27                  280 	.db #0x27	; 39
   1F86 FF                  281 	.db #0xFF	; 255
   1F87 2A                  282 	.db #0x2A	; 42
   1F88 FF                  283 	.db #0xFF	; 255
   1F89 2B                  284 	.db #0x2B	; 43
   1F8A 25                  285 	.db #0x25	; 37
   1F8B 28                  286 	.db #0x28	; 40
   1F8C 00                  287 	.db #0x00	; 0
   1F8D 01                  288 	.db #0x01	; 1
   1F8E 02                  289 	.db #0x02	; 2
   1F8F 03                  290 	.db #0x03	; 3
   1F90 04                  291 	.db #0x04	; 4
   1F91 05                  292 	.db #0x05	; 5
   1F92 06                  293 	.db #0x06	; 6
   1F93 07                  294 	.db #0x07	; 7
   1F94 08                  295 	.db #0x08	; 8
   1F95 09                  296 	.db #0x09	; 9
   1F96 0A                  297 	.db #0x0A	; 10
   1F97 0B                  298 	.db #0x0B	; 11
   1F98 0C                  299 	.db #0x0C	; 12
   1F99 0D                  300 	.db #0x0D	; 13
   1F9A 0E                  301 	.db #0x0E	; 14
   1F9B 0F                  302 	.db #0x0F	; 15
   1F9C 10                  303 	.db #0x10	; 16
   1F9D 11                  304 	.db #0x11	; 17
   1F9E 12                  305 	.db #0x12	; 18
   1F9F 13                  306 	.db #0x13	; 19
   1FA0 14                  307 	.db #0x14	; 20
   1FA1 15                  308 	.db #0x15	; 21
   1FA2 16                  309 	.db #0x16	; 22
   1FA3 17                  310 	.db #0x17	; 23
   1FA4 18                  311 	.db #0x18	; 24
   1FA5 19                  312 	.db #0x19	; 25
   1FA6 FF                  313 	.db #0xFF	; 255
   1FA7 FF                  314 	.db #0xFF	; 255
   1FA8 FF                  315 	.db #0xFF	; 255
   1FA9 FF                  316 	.db #0xFF	; 255
   1FAA FF                  317 	.db #0xFF	; 255
   1FAB FF                  318 	.db #0xFF	; 255
   1FAC 00                  319 	.db #0x00	; 0
   1FAD 01                  320 	.db #0x01	; 1
   1FAE 02                  321 	.db #0x02	; 2
   1FAF 03                  322 	.db #0x03	; 3
   1FB0 04                  323 	.db #0x04	; 4
   1FB1 05                  324 	.db #0x05	; 5
   1FB2 06                  325 	.db #0x06	; 6
   1FB3 07                  326 	.db #0x07	; 7
   1FB4 08                  327 	.db #0x08	; 8
   1FB5 09                  328 	.db #0x09	; 9
   1FB6 0A                  329 	.db #0x0A	; 10
   1FB7 0B                  330 	.db #0x0B	; 11
   1FB8 0C                  331 	.db #0x0C	; 12
   1FB9 0D                  332 	.db #0x0D	; 13
   1FBA 0E                  333 	.db #0x0E	; 14
   1FBB 0F                  334 	.db #0x0F	; 15
   1FBC 10                  335 	.db #0x10	; 16
   1FBD 11                  336 	.db #0x11	; 17
   1FBE 12                  337 	.db #0x12	; 18
   1FBF 13                  338 	.db #0x13	; 19
   1FC0 14                  339 	.db #0x14	; 20
   1FC1 15                  340 	.db #0x15	; 21
   1FC2 16                  341 	.db #0x16	; 22
   1FC3 17                  342 	.db #0x17	; 23
   1FC4 18                  343 	.db #0x18	; 24
   1FC5 19                  344 	.db #0x19	; 25
   1FC6 FF                  345 	.db #0xFF	; 255
   1FC7 FF                  346 	.db #0xFF	; 255
   1FC8 FF                  347 	.db #0xFF	; 255
   1FC9 30                  348 	.db #0x30	; 48	'0'
   1FCA FF                  349 	.db #0xFF	; 255
   1FCB                     350 _i_to_s_buffer:
   1FCB 00                  351 	.db #0x00	; 0
   1FCC 00                  352 	.db #0x00	; 0
   1FCD 00                  353 	.db #0x00	; 0
   1FCE 00                  354 	.db #0x00	; 0
   1FCF 00                  355 	.db #0x00	; 0
   1FD0 00                  356 	.db #0x00	; 0
   1FD1 00                  357 	.db #0x00	; 0
   1FD2 00                  358 	.db #0x00	; 0
   1FD3 00                  359 	.db #0x00	; 0
                            360 ;src/StringUtils.c:90: void print_text(void * const text, u8* position, u8 bg, u8 fg){
                            361 ;	---------------------------------
                            362 ; Function print_text
                            363 ; ---------------------------------
   1FD4                     364 _print_text::
   1FD4 DD E5         [15]  365 	push	ix
   1FD6 DD 21 00 00   [14]  366 	ld	ix,#0
   1FDA DD 39         [15]  367 	add	ix,sp
   1FDC 21 EF FF      [10]  368 	ld	hl,#-17
   1FDF 39            [11]  369 	add	hl,sp
   1FE0 F9            [ 6]  370 	ld	sp,hl
                            371 ;src/StringUtils.c:91: u8 val, charBitArray, spritePos, fgColor=g_colors[fg], bgColor=g_colors[bg];
   1FE1 DD 7E 09      [19]  372 	ld	a,9 (ix)
   1FE4 C6 B2         [ 7]  373 	add	a, #<(_g_colors)
   1FE6 DD 77 FC      [19]  374 	ld	-4 (ix),a
   1FE9 3E 00         [ 7]  375 	ld	a,#0x00
   1FEB CE 0A         [ 7]  376 	adc	a, #>(_g_colors)
   1FED DD 77 FD      [19]  377 	ld	-3 (ix),a
   1FF0 DD 6E FC      [19]  378 	ld	l,-4 (ix)
   1FF3 DD 66 FD      [19]  379 	ld	h,-3 (ix)
   1FF6 7E            [ 7]  380 	ld	a,(hl)
   1FF7 DD 77 F3      [19]  381 	ld	-13 (ix),a
   1FFA 3E B2         [ 7]  382 	ld	a,#<(_g_colors)
   1FFC DD 86 08      [19]  383 	add	a, 8 (ix)
   1FFF DD 77 FC      [19]  384 	ld	-4 (ix),a
   2002 3E 0A         [ 7]  385 	ld	a,#>(_g_colors)
   2004 CE 00         [ 7]  386 	adc	a, #0x00
   2006 DD 77 FD      [19]  387 	ld	-3 (ix),a
   2009 DD 6E FC      [19]  388 	ld	l,-4 (ix)
   200C DD 66 FD      [19]  389 	ld	h,-3 (ix)
   200F 7E            [ 7]  390 	ld	a,(hl)
   2010 DD 77 F2      [19]  391 	ld	-14 (ix),a
                            392 ;src/StringUtils.c:97: (position)+=0x2800;
   2013 DD 7E 06      [19]  393 	ld	a,6 (ix)
   2016 C6 00         [ 7]  394 	add	a, #0x00
   2018 DD 77 06      [19]  395 	ld	6 (ix),a
   201B DD 7E 07      [19]  396 	ld	a,7 (ix)
   201E CE 28         [ 7]  397 	adc	a, #0x28
   2020 DD 77 07      [19]  398 	ld	7 (ix),a
                            399 ;src/StringUtils.c:98: if(position<0x2800){
   2023 DD 4E 06      [19]  400 	ld	c,6 (ix)
   2026 DD 46 07      [19]  401 	ld	b,7 (ix)
   2029 78            [ 4]  402 	ld	a,b
   202A D6 28         [ 7]  403 	sub	a, #0x28
   202C 30 20         [12]  404 	jr	NC,00132$
                            405 ;src/StringUtils.c:99: position-=0x4000;
   202E DD 7E 06      [19]  406 	ld	a,6 (ix)
   2031 C6 00         [ 7]  407 	add	a,#0x00
   2033 DD 77 06      [19]  408 	ld	6 (ix),a
   2036 DD 7E 07      [19]  409 	ld	a,7 (ix)
   2039 CE C0         [ 7]  410 	adc	a,#0xC0
   203B DD 77 07      [19]  411 	ld	7 (ix),a
                            412 ;src/StringUtils.c:100: position+=80;
   203E DD 7E 06      [19]  413 	ld	a,6 (ix)
   2041 C6 50         [ 7]  414 	add	a, #0x50
   2043 DD 77 06      [19]  415 	ld	6 (ix),a
   2046 DD 7E 07      [19]  416 	ld	a,7 (ix)
   2049 CE 00         [ 7]  417 	adc	a, #0x00
   204B DD 77 07      [19]  418 	ld	7 (ix),a
                            419 ;src/StringUtils.c:103: while(height){
   204E                     420 00132$:
   204E DD 36 F1 06   [19]  421 	ld	-15 (ix),#0x06
   2052 DD 36 FC 96   [19]  422 	ld	-4 (ix),#0x96
   2056                     423 00110$:
   2056 DD 7E F1      [19]  424 	ld	a,-15 (ix)
   2059 B7            [ 4]  425 	or	a, a
   205A CA A6 21      [10]  426 	jp	Z,00113$
                            427 ;src/StringUtils.c:104: --height;
   205D DD 7E FC      [19]  428 	ld	a,-4 (ix)
   2060 C6 E7         [ 7]  429 	add	a,#0xE7
   2062 DD 77 FC      [19]  430 	ld	-4 (ix),a
   2065 DD 35 F1      [23]  431 	dec	-15 (ix)
                            432 ;src/StringUtils.c:105: currentChar=text;
   2068 DD 7E 04      [19]  433 	ld	a,4 (ix)
   206B DD 77 F8      [19]  434 	ld	-8 (ix),a
   206E DD 7E 05      [19]  435 	ld	a,5 (ix)
   2071 DD 77 F9      [19]  436 	ld	-7 (ix),a
                            437 ;src/StringUtils.c:106: currentPos=position;
   2074 DD 7E 06      [19]  438 	ld	a,6 (ix)
   2077 DD 77 FA      [19]  439 	ld	-6 (ix),a
   207A DD 7E 07      [19]  440 	ld	a,7 (ix)
   207D DD 77 FB      [19]  441 	ld	-5 (ix),a
                            442 ;src/StringUtils.c:108: while(*currentChar){
   2080                     443 00105$:
   2080 DD 6E F8      [19]  444 	ld	l,-8 (ix)
   2083 DD 66 F9      [19]  445 	ld	h,-7 (ix)
   2086 7E            [ 7]  446 	ld	a,(hl)
   2087 DD 77 F7      [19]  447 	ld	-9 (ix), a
   208A B7            [ 4]  448 	or	a, a
   208B CA 6E 21      [10]  449 	jp	Z,00107$
                            450 ;src/StringUtils.c:110: spritePos = charArray[(*currentChar)];
   208E 3E 4B         [ 7]  451 	ld	a,#<(_charArray)
   2090 DD 86 F7      [19]  452 	add	a, -9 (ix)
   2093 DD 77 FE      [19]  453 	ld	-2 (ix),a
   2096 3E 1F         [ 7]  454 	ld	a,#>(_charArray)
   2098 CE 00         [ 7]  455 	adc	a, #0x00
   209A DD 77 FF      [19]  456 	ld	-1 (ix),a
   209D DD 6E FE      [19]  457 	ld	l,-2 (ix)
   20A0 DD 66 FF      [19]  458 	ld	h,-1 (ix)
   20A3 7E            [ 7]  459 	ld	a,(hl)
                            460 ;src/StringUtils.c:112: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   20A4 DD 77 F4      [19]  461 	ld	-12 (ix), a
   20A7 CB 3F         [ 8]  462 	srl	a
   20A9 DD 77 FE      [19]  463 	ld	-2 (ix), a
   20AC DD 86 FC      [19]  464 	add	a, -4 (ix)
   20AF DD 77 FE      [19]  465 	ld	-2 (ix),a
   20B2 C6 30         [ 7]  466 	add	a,#<(_typography_4x6_monospaced)
   20B4 DD 77 FE      [19]  467 	ld	-2 (ix),a
   20B7 3E 30         [ 7]  468 	ld	a,#>(_typography_4x6_monospaced)
   20B9 CE 00         [ 7]  469 	adc	a, #0x00
   20BB DD 77 FF      [19]  470 	ld	-1 (ix),a
   20BE DD 6E FE      [19]  471 	ld	l,-2 (ix)
   20C1 DD 66 FF      [19]  472 	ld	h,-1 (ix)
   20C4 7E            [ 7]  473 	ld	a,(hl)
   20C5 DD 77 FE      [19]  474 	ld	-2 (ix),a
                            475 ;src/StringUtils.c:114: if(spritePos%2) charBitArray<<=4;
   20C8 DD CB F4 46   [20]  476 	bit	0, -12 (ix)
   20CC 28 0C         [12]  477 	jr	Z,00104$
   20CE DD 7E FE      [19]  478 	ld	a,-2 (ix)
   20D1 07            [ 4]  479 	rlca
   20D2 07            [ 4]  480 	rlca
   20D3 07            [ 4]  481 	rlca
   20D4 07            [ 4]  482 	rlca
   20D5 E6 F0         [ 7]  483 	and	a,#0xF0
   20D7 DD 77 FE      [19]  484 	ld	-2 (ix),a
   20DA                     485 00104$:
                            486 ;src/StringUtils.c:118: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   20DA DD CB FE 7E   [20]  487 	bit	7, -2 (ix)
   20DE 28 05         [12]  488 	jr	Z,00115$
   20E0 DD 7E F3      [19]  489 	ld	a,-13 (ix)
   20E3 18 03         [12]  490 	jr	00116$
   20E5                     491 00115$:
   20E5 DD 7E F2      [19]  492 	ld	a,-14 (ix)
   20E8                     493 00116$:
   20E8 E6 AA         [ 7]  494 	and	a, #0xAA
   20EA 4F            [ 4]  495 	ld	c,a
                            496 ;src/StringUtils.c:120: charBitArray<<=1;
   20EB DD 7E FE      [19]  497 	ld	a,-2 (ix)
   20EE 87            [ 4]  498 	add	a, a
   20EF 47            [ 4]  499 	ld	b,a
                            500 ;src/StringUtils.c:122: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   20F0 CB 78         [ 8]  501 	bit	7, b
   20F2 28 05         [12]  502 	jr	Z,00117$
   20F4 DD 7E F3      [19]  503 	ld	a,-13 (ix)
   20F7 18 03         [12]  504 	jr	00118$
   20F9                     505 00117$:
   20F9 DD 7E F2      [19]  506 	ld	a,-14 (ix)
   20FC                     507 00118$:
   20FC E6 55         [ 7]  508 	and	a, #0x55
   20FE B1            [ 4]  509 	or	a, c
   20FF 4F            [ 4]  510 	ld	c,a
                            511 ;src/StringUtils.c:124: charBitArray<<=1;
   2100 78            [ 4]  512 	ld	a,b
   2101 87            [ 4]  513 	add	a, a
   2102 DD 77 F5      [19]  514 	ld	-11 (ix),a
                            515 ;src/StringUtils.c:126: *currentPos=val;
   2105 DD 6E FA      [19]  516 	ld	l,-6 (ix)
   2108 DD 66 FB      [19]  517 	ld	h,-5 (ix)
   210B 71            [ 7]  518 	ld	(hl),c
                            519 ;src/StringUtils.c:127: ++currentPos;
   210C DD 7E FA      [19]  520 	ld	a,-6 (ix)
   210F C6 01         [ 7]  521 	add	a, #0x01
   2111 DD 77 EF      [19]  522 	ld	-17 (ix),a
   2114 DD 7E FB      [19]  523 	ld	a,-5 (ix)
   2117 CE 00         [ 7]  524 	adc	a, #0x00
   2119 DD 77 F0      [19]  525 	ld	-16 (ix),a
                            526 ;src/StringUtils.c:131: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   211C DD CB F5 7E   [20]  527 	bit	7, -11 (ix)
   2120 28 05         [12]  528 	jr	Z,00119$
   2122 DD 7E F3      [19]  529 	ld	a,-13 (ix)
   2125 18 03         [12]  530 	jr	00120$
   2127                     531 00119$:
   2127 DD 7E F2      [19]  532 	ld	a,-14 (ix)
   212A                     533 00120$:
   212A E6 AA         [ 7]  534 	and	a, #0xAA
   212C DD 77 F6      [19]  535 	ld	-10 (ix),a
                            536 ;src/StringUtils.c:133: charBitArray<<=1;
   212F DD 7E F5      [19]  537 	ld	a,-11 (ix)
   2132 87            [ 4]  538 	add	a, a
                            539 ;src/StringUtils.c:135: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   2133 07            [ 4]  540 	rlca
   2134 30 05         [12]  541 	jr	NC,00121$
   2136 DD 7E F3      [19]  542 	ld	a,-13 (ix)
   2139 18 03         [12]  543 	jr	00122$
   213B                     544 00121$:
   213B DD 7E F2      [19]  545 	ld	a,-14 (ix)
   213E                     546 00122$:
   213E E6 55         [ 7]  547 	and	a, #0x55
   2140 DD 77 FE      [19]  548 	ld	-2 (ix),a
   2143 DD 7E F6      [19]  549 	ld	a,-10 (ix)
   2146 DD B6 FE      [19]  550 	or	a, -2 (ix)
   2149 DD 77 FE      [19]  551 	ld	-2 (ix),a
                            552 ;src/StringUtils.c:139: *currentPos=val;
   214C E1            [10]  553 	pop	hl
   214D E5            [11]  554 	push	hl
   214E DD 7E FE      [19]  555 	ld	a,-2 (ix)
   2151 77            [ 7]  556 	ld	(hl),a
                            557 ;src/StringUtils.c:140: ++currentPos;
   2152 DD 7E EF      [19]  558 	ld	a,-17 (ix)
   2155 C6 01         [ 7]  559 	add	a, #0x01
   2157 DD 77 FA      [19]  560 	ld	-6 (ix),a
   215A DD 7E F0      [19]  561 	ld	a,-16 (ix)
   215D CE 00         [ 7]  562 	adc	a, #0x00
   215F DD 77 FB      [19]  563 	ld	-5 (ix),a
                            564 ;src/StringUtils.c:142: ++currentChar;
   2162 DD 34 F8      [23]  565 	inc	-8 (ix)
   2165 C2 80 20      [10]  566 	jp	NZ,00105$
   2168 DD 34 F9      [23]  567 	inc	-7 (ix)
   216B C3 80 20      [10]  568 	jp	00105$
   216E                     569 00107$:
                            570 ;src/StringUtils.c:144: position-=0x0800;
   216E DD 7E 06      [19]  571 	ld	a,6 (ix)
   2171 C6 00         [ 7]  572 	add	a,#0x00
   2173 DD 77 06      [19]  573 	ld	6 (ix),a
   2176 DD 7E 07      [19]  574 	ld	a,7 (ix)
   2179 CE F8         [ 7]  575 	adc	a,#0xF8
                            576 ;src/StringUtils.c:146: if(position<0xC000){
   217B DD 77 07      [19]  577 	ld	7 (ix), a
   217E D6 C0         [ 7]  578 	sub	a, #0xC0
   2180 D2 56 20      [10]  579 	jp	NC,00110$
                            580 ;src/StringUtils.c:147: position+=0x4000;
   2183 DD 7E 06      [19]  581 	ld	a,6 (ix)
   2186 C6 00         [ 7]  582 	add	a, #0x00
   2188 DD 77 06      [19]  583 	ld	6 (ix),a
   218B DD 7E 07      [19]  584 	ld	a,7 (ix)
   218E CE 40         [ 7]  585 	adc	a, #0x40
   2190 DD 77 07      [19]  586 	ld	7 (ix),a
                            587 ;src/StringUtils.c:148: position-=80;
   2193 DD 7E 06      [19]  588 	ld	a,6 (ix)
   2196 C6 B0         [ 7]  589 	add	a,#0xB0
   2198 DD 77 06      [19]  590 	ld	6 (ix),a
   219B DD 7E 07      [19]  591 	ld	a,7 (ix)
   219E CE FF         [ 7]  592 	adc	a,#0xFF
   21A0 DD 77 07      [19]  593 	ld	7 (ix),a
   21A3 C3 56 20      [10]  594 	jp	00110$
   21A6                     595 00113$:
   21A6 DD F9         [10]  596 	ld	sp, ix
   21A8 DD E1         [14]  597 	pop	ix
   21AA C9            [10]  598 	ret
                            599 ;src/StringUtils.c:154: void print_transparent_text(void* const text, u8* position, u8 fg){
                            600 ;	---------------------------------
                            601 ; Function print_transparent_text
                            602 ; ---------------------------------
   21AB                     603 _print_transparent_text::
   21AB DD E5         [15]  604 	push	ix
   21AD DD 21 00 00   [14]  605 	ld	ix,#0
   21B1 DD 39         [15]  606 	add	ix,sp
   21B3 21 F8 FF      [10]  607 	ld	hl,#-8
   21B6 39            [11]  608 	add	hl,sp
   21B7 F9            [ 6]  609 	ld	sp,hl
                            610 ;src/StringUtils.c:155: u8 val, charBitArray, spritePos, color = g_colors[fg];
   21B8 01 B2 0A      [10]  611 	ld	bc,#_g_colors+0
   21BB DD 6E 08      [19]  612 	ld	l,8 (ix)
   21BE 26 00         [ 7]  613 	ld	h,#0x00
   21C0 09            [11]  614 	add	hl,bc
   21C1 4E            [ 7]  615 	ld	c,(hl)
                            616 ;src/StringUtils.c:161: (position)+=0x2800;
   21C2 DD 7E 06      [19]  617 	ld	a,6 (ix)
   21C5 C6 00         [ 7]  618 	add	a, #0x00
   21C7 DD 77 06      [19]  619 	ld	6 (ix),a
   21CA DD 7E 07      [19]  620 	ld	a,7 (ix)
   21CD CE 28         [ 7]  621 	adc	a, #0x28
   21CF DD 77 07      [19]  622 	ld	7 (ix),a
                            623 ;src/StringUtils.c:162: if(position<0x2800){
   21D2 DD 46 06      [19]  624 	ld	b,6 (ix)
   21D5 DD 5E 07      [19]  625 	ld	e,7 (ix)
   21D8 7B            [ 4]  626 	ld	a,e
   21D9 D6 28         [ 7]  627 	sub	a, #0x28
   21DB 30 20         [12]  628 	jr	NC,00132$
                            629 ;src/StringUtils.c:163: position-=0x4000;
   21DD DD 7E 06      [19]  630 	ld	a,6 (ix)
   21E0 C6 00         [ 7]  631 	add	a,#0x00
   21E2 DD 77 06      [19]  632 	ld	6 (ix),a
   21E5 DD 7E 07      [19]  633 	ld	a,7 (ix)
   21E8 CE C0         [ 7]  634 	adc	a,#0xC0
   21EA DD 77 07      [19]  635 	ld	7 (ix),a
                            636 ;src/StringUtils.c:164: position+=80;
   21ED DD 7E 06      [19]  637 	ld	a,6 (ix)
   21F0 C6 50         [ 7]  638 	add	a, #0x50
   21F2 DD 77 06      [19]  639 	ld	6 (ix),a
   21F5 DD 7E 07      [19]  640 	ld	a,7 (ix)
   21F8 CE 00         [ 7]  641 	adc	a, #0x00
   21FA DD 77 07      [19]  642 	ld	7 (ix),a
                            643 ;src/StringUtils.c:167: while(height){
   21FD                     644 00132$:
   21FD 79            [ 4]  645 	ld	a,c
   21FE E6 AA         [ 7]  646 	and	a, #0xAA
   2200 DD 77 FA      [19]  647 	ld	-6 (ix),a
   2203 79            [ 4]  648 	ld	a,c
   2204 E6 55         [ 7]  649 	and	a, #0x55
   2206 DD 77 FB      [19]  650 	ld	-5 (ix),a
   2209 DD 36 F8 06   [19]  651 	ld	-8 (ix),#0x06
   220D DD 36 F9 96   [19]  652 	ld	-7 (ix),#0x96
   2211                     653 00118$:
   2211 DD 7E F8      [19]  654 	ld	a,-8 (ix)
   2214 B7            [ 4]  655 	or	a, a
   2215 CA FD 22      [10]  656 	jp	Z,00121$
                            657 ;src/StringUtils.c:168: currentChar=text;
   2218 DD 7E 04      [19]  658 	ld	a,4 (ix)
   221B DD 77 FE      [19]  659 	ld	-2 (ix),a
   221E DD 7E 05      [19]  660 	ld	a,5 (ix)
   2221 DD 77 FF      [19]  661 	ld	-1 (ix),a
                            662 ;src/StringUtils.c:169: currentPos=position;
   2224 DD 7E 06      [19]  663 	ld	a,6 (ix)
   2227 DD 77 FC      [19]  664 	ld	-4 (ix),a
   222A DD 7E 07      [19]  665 	ld	a,7 (ix)
   222D DD 77 FD      [19]  666 	ld	-3 (ix),a
                            667 ;src/StringUtils.c:170: --height;
   2230 DD 7E F9      [19]  668 	ld	a,-7 (ix)
   2233 C6 E7         [ 7]  669 	add	a,#0xE7
   2235 DD 77 F9      [19]  670 	ld	-7 (ix),a
   2238 DD 35 F8      [23]  671 	dec	-8 (ix)
                            672 ;src/StringUtils.c:171: while(*currentChar){
   223B                     673 00113$:
   223B DD 6E FE      [19]  674 	ld	l,-2 (ix)
   223E DD 66 FF      [19]  675 	ld	h,-1 (ix)
   2241 4E            [ 7]  676 	ld	c,(hl)
   2242 79            [ 4]  677 	ld	a,c
   2243 B7            [ 4]  678 	or	a, a
   2244 CA C5 22      [10]  679 	jp	Z,00115$
                            680 ;src/StringUtils.c:173: spritePos = charArray[(*currentChar)];
   2247 21 4B 1F      [10]  681 	ld	hl,#_charArray
   224A 06 00         [ 7]  682 	ld	b,#0x00
   224C 09            [11]  683 	add	hl, bc
   224D 46            [ 7]  684 	ld	b,(hl)
                            685 ;src/StringUtils.c:175: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   224E 78            [ 4]  686 	ld	a, b
   224F CB 3F         [ 8]  687 	srl	a
   2251 DD 86 F9      [19]  688 	add	a, -7 (ix)
   2254 5F            [ 4]  689 	ld	e,a
   2255 21 30 30      [10]  690 	ld	hl,#_typography_4x6_monospaced
   2258 16 00         [ 7]  691 	ld	d,#0x00
   225A 19            [11]  692 	add	hl, de
   225B 4E            [ 7]  693 	ld	c,(hl)
                            694 ;src/StringUtils.c:177: if(spritePos%2) charBitArray<<=4;
   225C CB 40         [ 8]  695 	bit	0, b
   225E 28 08         [12]  696 	jr	Z,00104$
   2260 79            [ 4]  697 	ld	a,c
   2261 07            [ 4]  698 	rlca
   2262 07            [ 4]  699 	rlca
   2263 07            [ 4]  700 	rlca
   2264 07            [ 4]  701 	rlca
   2265 E6 F0         [ 7]  702 	and	a,#0xF0
   2267 4F            [ 4]  703 	ld	c,a
   2268                     704 00104$:
                            705 ;src/StringUtils.c:179: val=*currentPos;
   2268 DD 6E FC      [19]  706 	ld	l,-4 (ix)
   226B DD 66 FD      [19]  707 	ld	h,-3 (ix)
   226E 5E            [ 7]  708 	ld	e,(hl)
                            709 ;src/StringUtils.c:181: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
   226F CB 79         [ 8]  710 	bit	7, c
   2271 28 07         [12]  711 	jr	Z,00106$
   2273 7B            [ 4]  712 	ld	a,e
   2274 E6 55         [ 7]  713 	and	a, #0x55
   2276 DD B6 FA      [19]  714 	or	a, -6 (ix)
   2279 5F            [ 4]  715 	ld	e,a
   227A                     716 00106$:
                            717 ;src/StringUtils.c:183: charBitArray<<=1;
   227A CB 21         [ 8]  718 	sla	c
                            719 ;src/StringUtils.c:185: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
   227C CB 79         [ 8]  720 	bit	7, c
   227E 28 07         [12]  721 	jr	Z,00108$
   2280 7B            [ 4]  722 	ld	a,e
   2281 E6 AA         [ 7]  723 	and	a, #0xAA
   2283 DD B6 FB      [19]  724 	or	a, -5 (ix)
   2286 5F            [ 4]  725 	ld	e,a
   2287                     726 00108$:
                            727 ;src/StringUtils.c:187: charBitArray<<=1;
   2287 CB 21         [ 8]  728 	sla	c
                            729 ;src/StringUtils.c:189: *currentPos=val;
   2289 DD 6E FC      [19]  730 	ld	l,-4 (ix)
   228C DD 66 FD      [19]  731 	ld	h,-3 (ix)
   228F 73            [ 7]  732 	ld	(hl),e
                            733 ;src/StringUtils.c:190: ++currentPos;
   2290 DD 5E FC      [19]  734 	ld	e,-4 (ix)
   2293 DD 56 FD      [19]  735 	ld	d,-3 (ix)
   2296 13            [ 6]  736 	inc	de
                            737 ;src/StringUtils.c:192: val=*currentPos;
   2297 1A            [ 7]  738 	ld	a,(de)
   2298 47            [ 4]  739 	ld	b,a
                            740 ;src/StringUtils.c:194: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
   2299 CB 79         [ 8]  741 	bit	7, c
   229B 28 07         [12]  742 	jr	Z,00110$
   229D 78            [ 4]  743 	ld	a,b
   229E E6 55         [ 7]  744 	and	a, #0x55
   22A0 DD B6 FA      [19]  745 	or	a, -6 (ix)
   22A3 47            [ 4]  746 	ld	b,a
   22A4                     747 00110$:
                            748 ;src/StringUtils.c:196: charBitArray<<=1;
   22A4 79            [ 4]  749 	ld	a,c
   22A5 87            [ 4]  750 	add	a, a
                            751 ;src/StringUtils.c:198: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
   22A6 07            [ 4]  752 	rlca
   22A7 30 07         [12]  753 	jr	NC,00112$
   22A9 78            [ 4]  754 	ld	a,b
   22AA E6 AA         [ 7]  755 	and	a, #0xAA
   22AC DD B6 FB      [19]  756 	or	a, -5 (ix)
   22AF 47            [ 4]  757 	ld	b,a
   22B0                     758 00112$:
                            759 ;src/StringUtils.c:202: *currentPos=val;
   22B0 78            [ 4]  760 	ld	a,b
   22B1 12            [ 7]  761 	ld	(de),a
                            762 ;src/StringUtils.c:203: ++currentPos;
   22B2 13            [ 6]  763 	inc	de
   22B3 DD 73 FC      [19]  764 	ld	-4 (ix),e
   22B6 DD 72 FD      [19]  765 	ld	-3 (ix),d
                            766 ;src/StringUtils.c:205: ++currentChar;
   22B9 DD 34 FE      [23]  767 	inc	-2 (ix)
   22BC C2 3B 22      [10]  768 	jp	NZ,00113$
   22BF DD 34 FF      [23]  769 	inc	-1 (ix)
   22C2 C3 3B 22      [10]  770 	jp	00113$
   22C5                     771 00115$:
                            772 ;src/StringUtils.c:207: position-=0x0800;
   22C5 DD 7E 06      [19]  773 	ld	a,6 (ix)
   22C8 C6 00         [ 7]  774 	add	a,#0x00
   22CA DD 77 06      [19]  775 	ld	6 (ix),a
   22CD DD 7E 07      [19]  776 	ld	a,7 (ix)
   22D0 CE F8         [ 7]  777 	adc	a,#0xF8
                            778 ;src/StringUtils.c:209: if(position<0xC000){
   22D2 DD 77 07      [19]  779 	ld	7 (ix), a
   22D5 D6 C0         [ 7]  780 	sub	a, #0xC0
   22D7 D2 11 22      [10]  781 	jp	NC,00118$
                            782 ;src/StringUtils.c:210: position+=0x4000;
   22DA DD 7E 06      [19]  783 	ld	a,6 (ix)
   22DD C6 00         [ 7]  784 	add	a, #0x00
   22DF DD 77 06      [19]  785 	ld	6 (ix),a
   22E2 DD 7E 07      [19]  786 	ld	a,7 (ix)
   22E5 CE 40         [ 7]  787 	adc	a, #0x40
   22E7 DD 77 07      [19]  788 	ld	7 (ix),a
                            789 ;src/StringUtils.c:211: position-=80;
   22EA DD 7E 06      [19]  790 	ld	a,6 (ix)
   22ED C6 B0         [ 7]  791 	add	a,#0xB0
   22EF DD 77 06      [19]  792 	ld	6 (ix),a
   22F2 DD 7E 07      [19]  793 	ld	a,7 (ix)
   22F5 CE FF         [ 7]  794 	adc	a,#0xFF
   22F7 DD 77 07      [19]  795 	ld	7 (ix),a
   22FA C3 11 22      [10]  796 	jp	00118$
   22FD                     797 00121$:
   22FD DD F9         [10]  798 	ld	sp, ix
   22FF DD E1         [14]  799 	pop	ix
   2301 C9            [10]  800 	ret
                            801 	.area _CODE
                            802 	.area _INITIALIZER
                            803 	.area _CABS (ABS)
