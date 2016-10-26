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
   3DD2                      51 _integer_to_string::
   3DD2 DD E5         [15]   52 	push	ix
   3DD4 DD 21 00 00   [14]   53 	ld	ix,#0
   3DD8 DD 39         [15]   54 	add	ix,sp
                             55 ;src/StringUtils.c:36: u8* charPosition=(u8*)&i_to_s_buffer;
   3DDA 01 30 3F      [10]   56 	ld	bc,#_i_to_s_buffer+0
                             57 ;src/StringUtils.c:38: switch(format){
   3DDD DD 7E 05      [19]   58 	ld	a,5 (ix)
   3DE0 D6 62         [ 7]   59 	sub	a, #0x62
   3DE2 28 45         [12]   60 	jr	Z,00102$
   3DE4 DD 7E 05      [19]   61 	ld	a,5 (ix)
   3DE7 D6 68         [ 7]   62 	sub	a, #0x68
   3DE9 20 57         [12]   63 	jr	NZ,00106$
                             64 ;src/StringUtils.c:40: charPosition+=2;
   3DEB 11 32 3F      [10]   65 	ld	de,#_i_to_s_buffer + 2
                             66 ;src/StringUtils.c:42: *charPosition = 0;
   3DEE AF            [ 4]   67 	xor	a, a
   3DEF 12            [ 7]   68 	ld	(de),a
                             69 ;src/StringUtils.c:44: --charPosition;
   3DF0 1B            [ 6]   70 	dec	de
                             71 ;src/StringUtils.c:46: t=n&0x0F;
   3DF1 DD 7E 04      [19]   72 	ld	a,4 (ix)
   3DF4 E6 0F         [ 7]   73 	and	a, #0x0F
   3DF6 6F            [ 4]   74 	ld	l,a
                             75 ;src/StringUtils.c:47: t=t>9?t+55:t+48;
   3DF7 3E 09         [ 7]   76 	ld	a,#0x09
   3DF9 95            [ 4]   77 	sub	a, l
   3DFA 30 05         [12]   78 	jr	NC,00110$
   3DFC 7D            [ 4]   79 	ld	a,l
   3DFD C6 37         [ 7]   80 	add	a, #0x37
   3DFF 18 03         [12]   81 	jr	00111$
   3E01                      82 00110$:
   3E01 7D            [ 4]   83 	ld	a,l
   3E02 C6 30         [ 7]   84 	add	a, #0x30
   3E04                      85 00111$:
                             86 ;src/StringUtils.c:48: *charPosition=t;
   3E04 12            [ 7]   87 	ld	(de),a
                             88 ;src/StringUtils.c:49: n>>=4;
   3E05 DD 7E 04      [19]   89 	ld	a,4 (ix)
   3E08 07            [ 4]   90 	rlca
   3E09 07            [ 4]   91 	rlca
   3E0A 07            [ 4]   92 	rlca
   3E0B 07            [ 4]   93 	rlca
   3E0C E6 0F         [ 7]   94 	and	a,#0x0F
   3E0E DD 77 04      [19]   95 	ld	4 (ix),a
                             96 ;src/StringUtils.c:50: --charPosition;
   3E11 1B            [ 6]   97 	dec	de
                             98 ;src/StringUtils.c:52: t=n>9?n+55:n+48;
   3E12 3E 09         [ 7]   99 	ld	a,#0x09
   3E14 DD 96 04      [19]  100 	sub	a, 4 (ix)
   3E17 30 07         [12]  101 	jr	NC,00112$
   3E19 DD 7E 04      [19]  102 	ld	a,4 (ix)
   3E1C C6 37         [ 7]  103 	add	a, #0x37
   3E1E 18 05         [12]  104 	jr	00113$
   3E20                     105 00112$:
   3E20 DD 7E 04      [19]  106 	ld	a,4 (ix)
   3E23 C6 30         [ 7]  107 	add	a, #0x30
   3E25                     108 00113$:
                            109 ;src/StringUtils.c:53: *charPosition=t;
   3E25 12            [ 7]  110 	ld	(de),a
                            111 ;src/StringUtils.c:54: break;
   3E26 C3 AB 3E      [10]  112 	jp	00107$
                            113 ;src/StringUtils.c:56: case 'b':{
   3E29                     114 00102$:
                            115 ;src/StringUtils.c:58: charPosition+=8;
   3E29 21 38 3F      [10]  116 	ld	hl,#_i_to_s_buffer + 8
                            117 ;src/StringUtils.c:60: while(t){
   3E2C 1E 08         [ 7]  118 	ld	e,#0x08
   3E2E                     119 00103$:
   3E2E 7B            [ 4]  120 	ld	a,e
   3E2F B7            [ 4]  121 	or	a, a
   3E30 28 79         [12]  122 	jr	Z,00107$
                            123 ;src/StringUtils.c:61: --t;
   3E32 1D            [ 4]  124 	dec	e
                            125 ;src/StringUtils.c:62: --charPosition;
   3E33 2B            [ 6]  126 	dec	hl
                            127 ;src/StringUtils.c:63: *charPosition=(n&1)+48;
   3E34 DD 7E 04      [19]  128 	ld	a,4 (ix)
   3E37 E6 01         [ 7]  129 	and	a, #0x01
   3E39 C6 30         [ 7]  130 	add	a, #0x30
   3E3B 77            [ 7]  131 	ld	(hl),a
                            132 ;src/StringUtils.c:64: n>>=1;
   3E3C DD CB 04 3E   [23]  133 	srl	4 (ix)
   3E40 18 EC         [12]  134 	jr	00103$
                            135 ;src/StringUtils.c:68: default:{
   3E42                     136 00106$:
                            137 ;src/StringUtils.c:69: charPosition+=3;
   3E42 11 33 3F      [10]  138 	ld	de,#_i_to_s_buffer + 3
                            139 ;src/StringUtils.c:71: *charPosition = 0;
   3E45 AF            [ 4]  140 	xor	a, a
   3E46 12            [ 7]  141 	ld	(de),a
                            142 ;src/StringUtils.c:73: --charPosition;
   3E47 1B            [ 6]  143 	dec	de
                            144 ;src/StringUtils.c:75: *charPosition=48+(n%10);
   3E48 C5            [11]  145 	push	bc
   3E49 D5            [11]  146 	push	de
   3E4A 3E 0A         [ 7]  147 	ld	a,#0x0A
   3E4C F5            [11]  148 	push	af
   3E4D 33            [ 6]  149 	inc	sp
   3E4E DD 7E 04      [19]  150 	ld	a,4 (ix)
   3E51 F5            [11]  151 	push	af
   3E52 33            [ 6]  152 	inc	sp
   3E53 CD B0 83      [17]  153 	call	__moduchar
   3E56 F1            [10]  154 	pop	af
   3E57 D1            [10]  155 	pop	de
   3E58 C1            [10]  156 	pop	bc
   3E59 7D            [ 4]  157 	ld	a,l
   3E5A C6 30         [ 7]  158 	add	a, #0x30
   3E5C 12            [ 7]  159 	ld	(de),a
                            160 ;src/StringUtils.c:76: --charPosition;
                            161 ;src/StringUtils.c:77: n/=10;
   3E5D C5            [11]  162 	push	bc
   3E5E 3E 0A         [ 7]  163 	ld	a,#0x0A
   3E60 F5            [11]  164 	push	af
   3E61 33            [ 6]  165 	inc	sp
   3E62 DD 7E 04      [19]  166 	ld	a,4 (ix)
   3E65 F5            [11]  167 	push	af
   3E66 33            [ 6]  168 	inc	sp
   3E67 CD 10 7A      [17]  169 	call	__divuchar
   3E6A F1            [10]  170 	pop	af
   3E6B C1            [10]  171 	pop	bc
   3E6C DD 75 04      [19]  172 	ld	4 (ix),l
                            173 ;src/StringUtils.c:78: *charPosition=48+(n%10);
   3E6F C5            [11]  174 	push	bc
   3E70 3E 0A         [ 7]  175 	ld	a,#0x0A
   3E72 F5            [11]  176 	push	af
   3E73 33            [ 6]  177 	inc	sp
   3E74 DD 7E 04      [19]  178 	ld	a,4 (ix)
   3E77 F5            [11]  179 	push	af
   3E78 33            [ 6]  180 	inc	sp
   3E79 CD B0 83      [17]  181 	call	__moduchar
   3E7C F1            [10]  182 	pop	af
   3E7D C1            [10]  183 	pop	bc
   3E7E 7D            [ 4]  184 	ld	a,l
   3E7F C6 30         [ 7]  185 	add	a, #0x30
   3E81 32 31 3F      [13]  186 	ld	(#(_i_to_s_buffer + 0x0001)),a
                            187 ;src/StringUtils.c:79: --charPosition;
                            188 ;src/StringUtils.c:80: n/=10;
   3E84 C5            [11]  189 	push	bc
   3E85 3E 0A         [ 7]  190 	ld	a,#0x0A
   3E87 F5            [11]  191 	push	af
   3E88 33            [ 6]  192 	inc	sp
   3E89 DD 7E 04      [19]  193 	ld	a,4 (ix)
   3E8C F5            [11]  194 	push	af
   3E8D 33            [ 6]  195 	inc	sp
   3E8E CD 10 7A      [17]  196 	call	__divuchar
   3E91 F1            [10]  197 	pop	af
   3E92 C1            [10]  198 	pop	bc
   3E93 DD 75 04      [19]  199 	ld	4 (ix),l
                            200 ;src/StringUtils.c:81: *charPosition=48+(n%10);
   3E96 C5            [11]  201 	push	bc
   3E97 3E 0A         [ 7]  202 	ld	a,#0x0A
   3E99 F5            [11]  203 	push	af
   3E9A 33            [ 6]  204 	inc	sp
   3E9B DD 7E 04      [19]  205 	ld	a,4 (ix)
   3E9E F5            [11]  206 	push	af
   3E9F 33            [ 6]  207 	inc	sp
   3EA0 CD B0 83      [17]  208 	call	__moduchar
   3EA3 F1            [10]  209 	pop	af
   3EA4 C1            [10]  210 	pop	bc
   3EA5 7D            [ 4]  211 	ld	a,l
   3EA6 C6 30         [ 7]  212 	add	a, #0x30
   3EA8 32 30 3F      [13]  213 	ld	(#_i_to_s_buffer),a
                            214 ;src/StringUtils.c:84: }
   3EAB                     215 00107$:
                            216 ;src/StringUtils.c:86: return i_to_s_buffer;
   3EAB 69            [ 4]  217 	ld	l, c
   3EAC 60            [ 4]  218 	ld	h, b
   3EAD DD E1         [14]  219 	pop	ix
   3EAF C9            [10]  220 	ret
   3EB0                     221 _charArray:
   3EB0 29                  222 	.db #0x29	; 41
   3EB1 29                  223 	.db #0x29	; 41
   3EB2 29                  224 	.db #0x29	; 41
   3EB3 29                  225 	.db #0x29	; 41
   3EB4 29                  226 	.db #0x29	; 41
   3EB5 29                  227 	.db #0x29	; 41
   3EB6 29                  228 	.db #0x29	; 41
   3EB7 29                  229 	.db #0x29	; 41
   3EB8 29                  230 	.db #0x29	; 41
   3EB9 29                  231 	.db #0x29	; 41
   3EBA 29                  232 	.db #0x29	; 41
   3EBB 29                  233 	.db #0x29	; 41
   3EBC 29                  234 	.db #0x29	; 41
   3EBD 29                  235 	.db #0x29	; 41
   3EBE 29                  236 	.db #0x29	; 41
   3EBF 29                  237 	.db #0x29	; 41
   3EC0 29                  238 	.db #0x29	; 41
   3EC1 29                  239 	.db #0x29	; 41
   3EC2 29                  240 	.db #0x29	; 41
   3EC3 29                  241 	.db #0x29	; 41
   3EC4 29                  242 	.db #0x29	; 41
   3EC5 29                  243 	.db #0x29	; 41
   3EC6 29                  244 	.db #0x29	; 41
   3EC7 29                  245 	.db #0x29	; 41
   3EC8 29                  246 	.db #0x29	; 41
   3EC9 29                  247 	.db #0x29	; 41
   3ECA 29                  248 	.db #0x29	; 41
   3ECB 29                  249 	.db #0x29	; 41
   3ECC 29                  250 	.db #0x29	; 41
   3ECD 29                  251 	.db #0x29	; 41
   3ECE 29                  252 	.db #0x29	; 41
   3ECF 29                  253 	.db #0x29	; 41
   3ED0 29                  254 	.db #0x29	; 41
   3ED1 24                  255 	.db #0x24	; 36
   3ED2 29                  256 	.db #0x29	; 41
   3ED3 2D                  257 	.db #0x2D	; 45
   3ED4 2F                  258 	.db #0x2F	; 47
   3ED5 29                  259 	.db #0x29	; 41
   3ED6 2E                  260 	.db #0x2E	; 46
   3ED7 29                  261 	.db #0x29	; 41
   3ED8 29                  262 	.db #0x29	; 41
   3ED9 29                  263 	.db #0x29	; 41
   3EDA 31                  264 	.db #0x31	; 49	'1'
   3EDB 2C                  265 	.db #0x2C	; 44
   3EDC 29                  266 	.db #0x29	; 41
   3EDD 29                  267 	.db #0x29	; 41
   3EDE 26                  268 	.db #0x26	; 38
   3EDF 29                  269 	.db #0x29	; 41
   3EE0 1A                  270 	.db #0x1A	; 26
   3EE1 1B                  271 	.db #0x1B	; 27
   3EE2 1C                  272 	.db #0x1C	; 28
   3EE3 1D                  273 	.db #0x1D	; 29
   3EE4 1E                  274 	.db #0x1E	; 30
   3EE5 1F                  275 	.db #0x1F	; 31
   3EE6 20                  276 	.db #0x20	; 32
   3EE7 21                  277 	.db #0x21	; 33
   3EE8 22                  278 	.db #0x22	; 34
   3EE9 23                  279 	.db #0x23	; 35
   3EEA 27                  280 	.db #0x27	; 39
   3EEB 29                  281 	.db #0x29	; 41
   3EEC 2A                  282 	.db #0x2A	; 42
   3EED 29                  283 	.db #0x29	; 41
   3EEE 2B                  284 	.db #0x2B	; 43
   3EEF 25                  285 	.db #0x25	; 37
   3EF0 28                  286 	.db #0x28	; 40
   3EF1 00                  287 	.db #0x00	; 0
   3EF2 01                  288 	.db #0x01	; 1
   3EF3 02                  289 	.db #0x02	; 2
   3EF4 03                  290 	.db #0x03	; 3
   3EF5 04                  291 	.db #0x04	; 4
   3EF6 05                  292 	.db #0x05	; 5
   3EF7 06                  293 	.db #0x06	; 6
   3EF8 07                  294 	.db #0x07	; 7
   3EF9 08                  295 	.db #0x08	; 8
   3EFA 09                  296 	.db #0x09	; 9
   3EFB 0A                  297 	.db #0x0A	; 10
   3EFC 0B                  298 	.db #0x0B	; 11
   3EFD 0C                  299 	.db #0x0C	; 12
   3EFE 0D                  300 	.db #0x0D	; 13
   3EFF 0E                  301 	.db #0x0E	; 14
   3F00 0F                  302 	.db #0x0F	; 15
   3F01 10                  303 	.db #0x10	; 16
   3F02 11                  304 	.db #0x11	; 17
   3F03 12                  305 	.db #0x12	; 18
   3F04 13                  306 	.db #0x13	; 19
   3F05 14                  307 	.db #0x14	; 20
   3F06 15                  308 	.db #0x15	; 21
   3F07 16                  309 	.db #0x16	; 22
   3F08 17                  310 	.db #0x17	; 23
   3F09 18                  311 	.db #0x18	; 24
   3F0A 19                  312 	.db #0x19	; 25
   3F0B 29                  313 	.db #0x29	; 41
   3F0C 29                  314 	.db #0x29	; 41
   3F0D 29                  315 	.db #0x29	; 41
   3F0E 29                  316 	.db #0x29	; 41
   3F0F 29                  317 	.db #0x29	; 41
   3F10 29                  318 	.db #0x29	; 41
   3F11 00                  319 	.db #0x00	; 0
   3F12 01                  320 	.db #0x01	; 1
   3F13 02                  321 	.db #0x02	; 2
   3F14 03                  322 	.db #0x03	; 3
   3F15 04                  323 	.db #0x04	; 4
   3F16 05                  324 	.db #0x05	; 5
   3F17 06                  325 	.db #0x06	; 6
   3F18 07                  326 	.db #0x07	; 7
   3F19 08                  327 	.db #0x08	; 8
   3F1A 09                  328 	.db #0x09	; 9
   3F1B 0A                  329 	.db #0x0A	; 10
   3F1C 0B                  330 	.db #0x0B	; 11
   3F1D 0C                  331 	.db #0x0C	; 12
   3F1E 0D                  332 	.db #0x0D	; 13
   3F1F 0E                  333 	.db #0x0E	; 14
   3F20 0F                  334 	.db #0x0F	; 15
   3F21 10                  335 	.db #0x10	; 16
   3F22 11                  336 	.db #0x11	; 17
   3F23 12                  337 	.db #0x12	; 18
   3F24 13                  338 	.db #0x13	; 19
   3F25 14                  339 	.db #0x14	; 20
   3F26 15                  340 	.db #0x15	; 21
   3F27 16                  341 	.db #0x16	; 22
   3F28 17                  342 	.db #0x17	; 23
   3F29 18                  343 	.db #0x18	; 24
   3F2A 19                  344 	.db #0x19	; 25
   3F2B 29                  345 	.db #0x29	; 41
   3F2C 29                  346 	.db #0x29	; 41
   3F2D 29                  347 	.db #0x29	; 41
   3F2E 30                  348 	.db #0x30	; 48	'0'
   3F2F 29                  349 	.db #0x29	; 41
   3F30                     350 _i_to_s_buffer:
   3F30 00                  351 	.db #0x00	; 0
   3F31 00                  352 	.db #0x00	; 0
   3F32 00                  353 	.db #0x00	; 0
   3F33 00                  354 	.db #0x00	; 0
   3F34 00                  355 	.db #0x00	; 0
   3F35 00                  356 	.db #0x00	; 0
   3F36 00                  357 	.db #0x00	; 0
   3F37 00                  358 	.db #0x00	; 0
   3F38 00                  359 	.db #0x00	; 0
                            360 ;src/StringUtils.c:90: void print_text(void * const text, u8* position, u8 bg, u8 fg){
                            361 ;	---------------------------------
                            362 ; Function print_text
                            363 ; ---------------------------------
   3F39                     364 _print_text::
   3F39 DD E5         [15]  365 	push	ix
   3F3B DD 21 00 00   [14]  366 	ld	ix,#0
   3F3F DD 39         [15]  367 	add	ix,sp
   3F41 21 EF FF      [10]  368 	ld	hl,#-17
   3F44 39            [11]  369 	add	hl,sp
   3F45 F9            [ 6]  370 	ld	sp,hl
                            371 ;src/StringUtils.c:91: u8 val, charBitArray, spritePos, fgColor=g_colors[fg], bgColor=g_colors[bg];
   3F46 DD 7E 09      [19]  372 	ld	a,9 (ix)
   3F49 C6 28         [ 7]  373 	add	a, #<(_g_colors)
   3F4B DD 77 F9      [19]  374 	ld	-7 (ix),a
   3F4E 3E 00         [ 7]  375 	ld	a,#0x00
   3F50 CE 1C         [ 7]  376 	adc	a, #>(_g_colors)
   3F52 DD 77 FA      [19]  377 	ld	-6 (ix),a
   3F55 DD 6E F9      [19]  378 	ld	l,-7 (ix)
   3F58 DD 66 FA      [19]  379 	ld	h,-6 (ix)
   3F5B 7E            [ 7]  380 	ld	a,(hl)
   3F5C DD 77 F3      [19]  381 	ld	-13 (ix),a
   3F5F 3E 28         [ 7]  382 	ld	a,#<(_g_colors)
   3F61 DD 86 08      [19]  383 	add	a, 8 (ix)
   3F64 DD 77 F9      [19]  384 	ld	-7 (ix),a
   3F67 3E 1C         [ 7]  385 	ld	a,#>(_g_colors)
   3F69 CE 00         [ 7]  386 	adc	a, #0x00
   3F6B DD 77 FA      [19]  387 	ld	-6 (ix),a
   3F6E DD 6E F9      [19]  388 	ld	l,-7 (ix)
   3F71 DD 66 FA      [19]  389 	ld	h,-6 (ix)
   3F74 7E            [ 7]  390 	ld	a,(hl)
   3F75 DD 77 F2      [19]  391 	ld	-14 (ix),a
                            392 ;src/StringUtils.c:97: (position)+=0x2800;
   3F78 DD 7E 06      [19]  393 	ld	a,6 (ix)
   3F7B C6 00         [ 7]  394 	add	a, #0x00
   3F7D DD 77 06      [19]  395 	ld	6 (ix),a
   3F80 DD 7E 07      [19]  396 	ld	a,7 (ix)
   3F83 CE 28         [ 7]  397 	adc	a, #0x28
   3F85 DD 77 07      [19]  398 	ld	7 (ix),a
                            399 ;src/StringUtils.c:98: if(position<0x2800){
   3F88 DD 4E 06      [19]  400 	ld	c,6 (ix)
   3F8B DD 46 07      [19]  401 	ld	b,7 (ix)
   3F8E 78            [ 4]  402 	ld	a,b
   3F8F D6 28         [ 7]  403 	sub	a, #0x28
   3F91 30 20         [12]  404 	jr	NC,00132$
                            405 ;src/StringUtils.c:99: position-=0x4000;
   3F93 DD 7E 06      [19]  406 	ld	a,6 (ix)
   3F96 C6 00         [ 7]  407 	add	a,#0x00
   3F98 DD 77 06      [19]  408 	ld	6 (ix),a
   3F9B DD 7E 07      [19]  409 	ld	a,7 (ix)
   3F9E CE C0         [ 7]  410 	adc	a,#0xC0
   3FA0 DD 77 07      [19]  411 	ld	7 (ix),a
                            412 ;src/StringUtils.c:100: position+=80;
   3FA3 DD 7E 06      [19]  413 	ld	a,6 (ix)
   3FA6 C6 50         [ 7]  414 	add	a, #0x50
   3FA8 DD 77 06      [19]  415 	ld	6 (ix),a
   3FAB DD 7E 07      [19]  416 	ld	a,7 (ix)
   3FAE CE 00         [ 7]  417 	adc	a, #0x00
   3FB0 DD 77 07      [19]  418 	ld	7 (ix),a
                            419 ;src/StringUtils.c:103: while(height){
   3FB3                     420 00132$:
   3FB3 DD 36 EF 06   [19]  421 	ld	-17 (ix),#0x06
   3FB7 DD 36 F9 96   [19]  422 	ld	-7 (ix),#0x96
   3FBB                     423 00110$:
   3FBB DD 7E EF      [19]  424 	ld	a,-17 (ix)
   3FBE B7            [ 4]  425 	or	a, a
   3FBF CA 0F 41      [10]  426 	jp	Z,00113$
                            427 ;src/StringUtils.c:104: --height;
   3FC2 DD 7E F9      [19]  428 	ld	a,-7 (ix)
   3FC5 C6 E7         [ 7]  429 	add	a,#0xE7
   3FC7 DD 77 F9      [19]  430 	ld	-7 (ix),a
   3FCA DD 35 EF      [23]  431 	dec	-17 (ix)
                            432 ;src/StringUtils.c:105: currentChar=text;
   3FCD DD 7E 04      [19]  433 	ld	a,4 (ix)
   3FD0 DD 77 F7      [19]  434 	ld	-9 (ix),a
   3FD3 DD 7E 05      [19]  435 	ld	a,5 (ix)
   3FD6 DD 77 F8      [19]  436 	ld	-8 (ix),a
                            437 ;src/StringUtils.c:106: currentPos=position;
   3FD9 DD 7E 06      [19]  438 	ld	a,6 (ix)
   3FDC DD 77 FE      [19]  439 	ld	-2 (ix),a
   3FDF DD 7E 07      [19]  440 	ld	a,7 (ix)
   3FE2 DD 77 FF      [19]  441 	ld	-1 (ix),a
                            442 ;src/StringUtils.c:108: while(*currentChar){
   3FE5                     443 00105$:
   3FE5 DD 6E F7      [19]  444 	ld	l,-9 (ix)
   3FE8 DD 66 F8      [19]  445 	ld	h,-8 (ix)
   3FEB 7E            [ 7]  446 	ld	a,(hl)
   3FEC DD 77 FD      [19]  447 	ld	-3 (ix), a
   3FEF B7            [ 4]  448 	or	a, a
   3FF0 CA D7 40      [10]  449 	jp	Z,00107$
                            450 ;src/StringUtils.c:110: spritePos = charArray[(*currentChar)];
   3FF3 3E B0         [ 7]  451 	ld	a,#<(_charArray)
   3FF5 DD 86 FD      [19]  452 	add	a, -3 (ix)
   3FF8 DD 77 FB      [19]  453 	ld	-5 (ix),a
   3FFB 3E 3E         [ 7]  454 	ld	a,#>(_charArray)
   3FFD CE 00         [ 7]  455 	adc	a, #0x00
   3FFF DD 77 FC      [19]  456 	ld	-4 (ix),a
   4002 DD 6E FB      [19]  457 	ld	l,-5 (ix)
   4005 DD 66 FC      [19]  458 	ld	h,-4 (ix)
   4008 7E            [ 7]  459 	ld	a,(hl)
                            460 ;src/StringUtils.c:112: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   4009 DD 77 F4      [19]  461 	ld	-12 (ix), a
   400C CB 3F         [ 8]  462 	srl	a
   400E DD 77 FB      [19]  463 	ld	-5 (ix), a
   4011 DD 86 F9      [19]  464 	add	a, -7 (ix)
   4014 DD 77 FB      [19]  465 	ld	-5 (ix),a
   4017 C6 3B         [ 7]  466 	add	a,#<(_typography_4x6_monospaced)
   4019 DD 77 FB      [19]  467 	ld	-5 (ix),a
   401C 3E 5C         [ 7]  468 	ld	a,#>(_typography_4x6_monospaced)
   401E CE 00         [ 7]  469 	adc	a, #0x00
   4020 DD 77 FC      [19]  470 	ld	-4 (ix),a
   4023 DD 6E FB      [19]  471 	ld	l,-5 (ix)
   4026 DD 66 FC      [19]  472 	ld	h,-4 (ix)
   4029 7E            [ 7]  473 	ld	a,(hl)
   402A DD 77 FB      [19]  474 	ld	-5 (ix),a
                            475 ;src/StringUtils.c:114: if(spritePos%2) charBitArray<<=4;
   402D DD CB F4 46   [20]  476 	bit	0, -12 (ix)
   4031 28 0C         [12]  477 	jr	Z,00104$
   4033 DD 7E FB      [19]  478 	ld	a,-5 (ix)
   4036 07            [ 4]  479 	rlca
   4037 07            [ 4]  480 	rlca
   4038 07            [ 4]  481 	rlca
   4039 07            [ 4]  482 	rlca
   403A E6 F0         [ 7]  483 	and	a,#0xF0
   403C DD 77 FB      [19]  484 	ld	-5 (ix),a
   403F                     485 00104$:
                            486 ;src/StringUtils.c:118: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   403F DD CB FB 7E   [20]  487 	bit	7, -5 (ix)
   4043 28 05         [12]  488 	jr	Z,00115$
   4045 DD 7E F3      [19]  489 	ld	a,-13 (ix)
   4048 18 03         [12]  490 	jr	00116$
   404A                     491 00115$:
   404A DD 7E F2      [19]  492 	ld	a,-14 (ix)
   404D                     493 00116$:
   404D E6 AA         [ 7]  494 	and	a, #0xAA
   404F 4F            [ 4]  495 	ld	c,a
                            496 ;src/StringUtils.c:120: charBitArray<<=1;
   4050 DD 7E FB      [19]  497 	ld	a,-5 (ix)
   4053 87            [ 4]  498 	add	a, a
   4054 47            [ 4]  499 	ld	b,a
                            500 ;src/StringUtils.c:122: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   4055 CB 78         [ 8]  501 	bit	7, b
   4057 28 05         [12]  502 	jr	Z,00117$
   4059 DD 7E F3      [19]  503 	ld	a,-13 (ix)
   405C 18 03         [12]  504 	jr	00118$
   405E                     505 00117$:
   405E DD 7E F2      [19]  506 	ld	a,-14 (ix)
   4061                     507 00118$:
   4061 E6 55         [ 7]  508 	and	a, #0x55
   4063 B1            [ 4]  509 	or	a, c
   4064 4F            [ 4]  510 	ld	c,a
                            511 ;src/StringUtils.c:124: charBitArray<<=1;
   4065 78            [ 4]  512 	ld	a,b
   4066 87            [ 4]  513 	add	a, a
   4067 DD 77 F5      [19]  514 	ld	-11 (ix),a
                            515 ;src/StringUtils.c:126: *currentPos=val;
   406A DD 6E FE      [19]  516 	ld	l,-2 (ix)
   406D DD 66 FF      [19]  517 	ld	h,-1 (ix)
   4070 71            [ 7]  518 	ld	(hl),c
                            519 ;src/StringUtils.c:127: ++currentPos;
   4071 DD 7E FE      [19]  520 	ld	a,-2 (ix)
   4074 C6 01         [ 7]  521 	add	a, #0x01
   4076 DD 77 F0      [19]  522 	ld	-16 (ix),a
   4079 DD 7E FF      [19]  523 	ld	a,-1 (ix)
   407C CE 00         [ 7]  524 	adc	a, #0x00
   407E DD 77 F1      [19]  525 	ld	-15 (ix),a
                            526 ;src/StringUtils.c:131: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   4081 DD CB F5 7E   [20]  527 	bit	7, -11 (ix)
   4085 28 05         [12]  528 	jr	Z,00119$
   4087 DD 7E F3      [19]  529 	ld	a,-13 (ix)
   408A 18 03         [12]  530 	jr	00120$
   408C                     531 00119$:
   408C DD 7E F2      [19]  532 	ld	a,-14 (ix)
   408F                     533 00120$:
   408F E6 AA         [ 7]  534 	and	a, #0xAA
   4091 DD 77 F6      [19]  535 	ld	-10 (ix),a
                            536 ;src/StringUtils.c:133: charBitArray<<=1;
   4094 DD 7E F5      [19]  537 	ld	a,-11 (ix)
   4097 87            [ 4]  538 	add	a, a
                            539 ;src/StringUtils.c:135: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   4098 07            [ 4]  540 	rlca
   4099 30 05         [12]  541 	jr	NC,00121$
   409B DD 7E F3      [19]  542 	ld	a,-13 (ix)
   409E 18 03         [12]  543 	jr	00122$
   40A0                     544 00121$:
   40A0 DD 7E F2      [19]  545 	ld	a,-14 (ix)
   40A3                     546 00122$:
   40A3 E6 55         [ 7]  547 	and	a, #0x55
   40A5 DD 77 FB      [19]  548 	ld	-5 (ix),a
   40A8 DD 7E F6      [19]  549 	ld	a,-10 (ix)
   40AB DD B6 FB      [19]  550 	or	a, -5 (ix)
   40AE DD 77 FB      [19]  551 	ld	-5 (ix),a
                            552 ;src/StringUtils.c:139: *currentPos=val;
   40B1 DD 6E F0      [19]  553 	ld	l,-16 (ix)
   40B4 DD 66 F1      [19]  554 	ld	h,-15 (ix)
   40B7 DD 7E FB      [19]  555 	ld	a,-5 (ix)
   40BA 77            [ 7]  556 	ld	(hl),a
                            557 ;src/StringUtils.c:140: ++currentPos;
   40BB DD 7E F0      [19]  558 	ld	a,-16 (ix)
   40BE C6 01         [ 7]  559 	add	a, #0x01
   40C0 DD 77 FE      [19]  560 	ld	-2 (ix),a
   40C3 DD 7E F1      [19]  561 	ld	a,-15 (ix)
   40C6 CE 00         [ 7]  562 	adc	a, #0x00
   40C8 DD 77 FF      [19]  563 	ld	-1 (ix),a
                            564 ;src/StringUtils.c:142: ++currentChar;
   40CB DD 34 F7      [23]  565 	inc	-9 (ix)
   40CE C2 E5 3F      [10]  566 	jp	NZ,00105$
   40D1 DD 34 F8      [23]  567 	inc	-8 (ix)
   40D4 C3 E5 3F      [10]  568 	jp	00105$
   40D7                     569 00107$:
                            570 ;src/StringUtils.c:144: position-=0x0800;
   40D7 DD 7E 06      [19]  571 	ld	a,6 (ix)
   40DA C6 00         [ 7]  572 	add	a,#0x00
   40DC DD 77 06      [19]  573 	ld	6 (ix),a
   40DF DD 7E 07      [19]  574 	ld	a,7 (ix)
   40E2 CE F8         [ 7]  575 	adc	a,#0xF8
                            576 ;src/StringUtils.c:146: if(position<0xC000){
   40E4 DD 77 07      [19]  577 	ld	7 (ix), a
   40E7 D6 C0         [ 7]  578 	sub	a, #0xC0
   40E9 D2 BB 3F      [10]  579 	jp	NC,00110$
                            580 ;src/StringUtils.c:147: position+=0x4000;
   40EC DD 7E 06      [19]  581 	ld	a,6 (ix)
   40EF C6 00         [ 7]  582 	add	a, #0x00
   40F1 DD 77 06      [19]  583 	ld	6 (ix),a
   40F4 DD 7E 07      [19]  584 	ld	a,7 (ix)
   40F7 CE 40         [ 7]  585 	adc	a, #0x40
   40F9 DD 77 07      [19]  586 	ld	7 (ix),a
                            587 ;src/StringUtils.c:148: position-=80;
   40FC DD 7E 06      [19]  588 	ld	a,6 (ix)
   40FF C6 B0         [ 7]  589 	add	a,#0xB0
   4101 DD 77 06      [19]  590 	ld	6 (ix),a
   4104 DD 7E 07      [19]  591 	ld	a,7 (ix)
   4107 CE FF         [ 7]  592 	adc	a,#0xFF
   4109 DD 77 07      [19]  593 	ld	7 (ix),a
   410C C3 BB 3F      [10]  594 	jp	00110$
   410F                     595 00113$:
   410F DD F9         [10]  596 	ld	sp, ix
   4111 DD E1         [14]  597 	pop	ix
   4113 C9            [10]  598 	ret
                            599 ;src/StringUtils.c:154: void print_transparent_text(void* const text, u8* position, u8 fg){
                            600 ;	---------------------------------
                            601 ; Function print_transparent_text
                            602 ; ---------------------------------
   4114                     603 _print_transparent_text::
   4114 DD E5         [15]  604 	push	ix
   4116 DD 21 00 00   [14]  605 	ld	ix,#0
   411A DD 39         [15]  606 	add	ix,sp
   411C 21 F8 FF      [10]  607 	ld	hl,#-8
   411F 39            [11]  608 	add	hl,sp
   4120 F9            [ 6]  609 	ld	sp,hl
                            610 ;src/StringUtils.c:155: u8 val, charBitArray, spritePos, color = g_colors[fg];
   4121 01 28 1C      [10]  611 	ld	bc,#_g_colors+0
   4124 DD 6E 08      [19]  612 	ld	l,8 (ix)
   4127 26 00         [ 7]  613 	ld	h,#0x00
   4129 09            [11]  614 	add	hl,bc
   412A 4E            [ 7]  615 	ld	c,(hl)
                            616 ;src/StringUtils.c:161: (position)+=0x2800;
   412B DD 7E 06      [19]  617 	ld	a,6 (ix)
   412E C6 00         [ 7]  618 	add	a, #0x00
   4130 DD 77 06      [19]  619 	ld	6 (ix),a
   4133 DD 7E 07      [19]  620 	ld	a,7 (ix)
   4136 CE 28         [ 7]  621 	adc	a, #0x28
   4138 DD 77 07      [19]  622 	ld	7 (ix),a
                            623 ;src/StringUtils.c:162: if(position<0x2800){
   413B DD 46 06      [19]  624 	ld	b,6 (ix)
   413E DD 5E 07      [19]  625 	ld	e,7 (ix)
   4141 7B            [ 4]  626 	ld	a,e
   4142 D6 28         [ 7]  627 	sub	a, #0x28
   4144 30 20         [12]  628 	jr	NC,00132$
                            629 ;src/StringUtils.c:163: position-=0x4000;
   4146 DD 7E 06      [19]  630 	ld	a,6 (ix)
   4149 C6 00         [ 7]  631 	add	a,#0x00
   414B DD 77 06      [19]  632 	ld	6 (ix),a
   414E DD 7E 07      [19]  633 	ld	a,7 (ix)
   4151 CE C0         [ 7]  634 	adc	a,#0xC0
   4153 DD 77 07      [19]  635 	ld	7 (ix),a
                            636 ;src/StringUtils.c:164: position+=80;
   4156 DD 7E 06      [19]  637 	ld	a,6 (ix)
   4159 C6 50         [ 7]  638 	add	a, #0x50
   415B DD 77 06      [19]  639 	ld	6 (ix),a
   415E DD 7E 07      [19]  640 	ld	a,7 (ix)
   4161 CE 00         [ 7]  641 	adc	a, #0x00
   4163 DD 77 07      [19]  642 	ld	7 (ix),a
                            643 ;src/StringUtils.c:167: while(height){
   4166                     644 00132$:
   4166 79            [ 4]  645 	ld	a,c
   4167 E6 AA         [ 7]  646 	and	a, #0xAA
   4169 DD 77 FA      [19]  647 	ld	-6 (ix),a
   416C 79            [ 4]  648 	ld	a,c
   416D E6 55         [ 7]  649 	and	a, #0x55
   416F DD 77 FB      [19]  650 	ld	-5 (ix),a
   4172 DD 36 F8 06   [19]  651 	ld	-8 (ix),#0x06
   4176 DD 36 F9 96   [19]  652 	ld	-7 (ix),#0x96
   417A                     653 00118$:
   417A DD 7E F8      [19]  654 	ld	a,-8 (ix)
   417D B7            [ 4]  655 	or	a, a
   417E CA 66 42      [10]  656 	jp	Z,00121$
                            657 ;src/StringUtils.c:168: currentChar=text;
   4181 DD 7E 04      [19]  658 	ld	a,4 (ix)
   4184 DD 77 FE      [19]  659 	ld	-2 (ix),a
   4187 DD 7E 05      [19]  660 	ld	a,5 (ix)
   418A DD 77 FF      [19]  661 	ld	-1 (ix),a
                            662 ;src/StringUtils.c:169: currentPos=position;
   418D DD 7E 06      [19]  663 	ld	a,6 (ix)
   4190 DD 77 FC      [19]  664 	ld	-4 (ix),a
   4193 DD 7E 07      [19]  665 	ld	a,7 (ix)
   4196 DD 77 FD      [19]  666 	ld	-3 (ix),a
                            667 ;src/StringUtils.c:170: --height;
   4199 DD 7E F9      [19]  668 	ld	a,-7 (ix)
   419C C6 E7         [ 7]  669 	add	a,#0xE7
   419E DD 77 F9      [19]  670 	ld	-7 (ix),a
   41A1 DD 35 F8      [23]  671 	dec	-8 (ix)
                            672 ;src/StringUtils.c:171: while(*currentChar){
   41A4                     673 00113$:
   41A4 DD 6E FE      [19]  674 	ld	l,-2 (ix)
   41A7 DD 66 FF      [19]  675 	ld	h,-1 (ix)
   41AA 4E            [ 7]  676 	ld	c,(hl)
   41AB 79            [ 4]  677 	ld	a,c
   41AC B7            [ 4]  678 	or	a, a
   41AD CA 2E 42      [10]  679 	jp	Z,00115$
                            680 ;src/StringUtils.c:173: spritePos = charArray[(*currentChar)];
   41B0 21 B0 3E      [10]  681 	ld	hl,#_charArray
   41B3 06 00         [ 7]  682 	ld	b,#0x00
   41B5 09            [11]  683 	add	hl, bc
   41B6 46            [ 7]  684 	ld	b,(hl)
                            685 ;src/StringUtils.c:175: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   41B7 78            [ 4]  686 	ld	a, b
   41B8 CB 3F         [ 8]  687 	srl	a
   41BA DD 86 F9      [19]  688 	add	a, -7 (ix)
   41BD 5F            [ 4]  689 	ld	e,a
   41BE 21 3B 5C      [10]  690 	ld	hl,#_typography_4x6_monospaced
   41C1 16 00         [ 7]  691 	ld	d,#0x00
   41C3 19            [11]  692 	add	hl, de
   41C4 4E            [ 7]  693 	ld	c,(hl)
                            694 ;src/StringUtils.c:177: if(spritePos%2) charBitArray<<=4;
   41C5 CB 40         [ 8]  695 	bit	0, b
   41C7 28 08         [12]  696 	jr	Z,00104$
   41C9 79            [ 4]  697 	ld	a,c
   41CA 07            [ 4]  698 	rlca
   41CB 07            [ 4]  699 	rlca
   41CC 07            [ 4]  700 	rlca
   41CD 07            [ 4]  701 	rlca
   41CE E6 F0         [ 7]  702 	and	a,#0xF0
   41D0 4F            [ 4]  703 	ld	c,a
   41D1                     704 00104$:
                            705 ;src/StringUtils.c:179: val=*currentPos;
   41D1 DD 6E FC      [19]  706 	ld	l,-4 (ix)
   41D4 DD 66 FD      [19]  707 	ld	h,-3 (ix)
   41D7 5E            [ 7]  708 	ld	e,(hl)
                            709 ;src/StringUtils.c:181: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
   41D8 CB 79         [ 8]  710 	bit	7, c
   41DA 28 07         [12]  711 	jr	Z,00106$
   41DC 7B            [ 4]  712 	ld	a,e
   41DD E6 55         [ 7]  713 	and	a, #0x55
   41DF DD B6 FA      [19]  714 	or	a, -6 (ix)
   41E2 5F            [ 4]  715 	ld	e,a
   41E3                     716 00106$:
                            717 ;src/StringUtils.c:183: charBitArray<<=1;
   41E3 CB 21         [ 8]  718 	sla	c
                            719 ;src/StringUtils.c:185: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
   41E5 CB 79         [ 8]  720 	bit	7, c
   41E7 28 07         [12]  721 	jr	Z,00108$
   41E9 7B            [ 4]  722 	ld	a,e
   41EA E6 AA         [ 7]  723 	and	a, #0xAA
   41EC DD B6 FB      [19]  724 	or	a, -5 (ix)
   41EF 5F            [ 4]  725 	ld	e,a
   41F0                     726 00108$:
                            727 ;src/StringUtils.c:187: charBitArray<<=1;
   41F0 CB 21         [ 8]  728 	sla	c
                            729 ;src/StringUtils.c:189: *currentPos=val;
   41F2 DD 6E FC      [19]  730 	ld	l,-4 (ix)
   41F5 DD 66 FD      [19]  731 	ld	h,-3 (ix)
   41F8 73            [ 7]  732 	ld	(hl),e
                            733 ;src/StringUtils.c:190: ++currentPos;
   41F9 DD 5E FC      [19]  734 	ld	e,-4 (ix)
   41FC DD 56 FD      [19]  735 	ld	d,-3 (ix)
   41FF 13            [ 6]  736 	inc	de
                            737 ;src/StringUtils.c:192: val=*currentPos;
   4200 1A            [ 7]  738 	ld	a,(de)
   4201 47            [ 4]  739 	ld	b,a
                            740 ;src/StringUtils.c:194: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
   4202 CB 79         [ 8]  741 	bit	7, c
   4204 28 07         [12]  742 	jr	Z,00110$
   4206 78            [ 4]  743 	ld	a,b
   4207 E6 55         [ 7]  744 	and	a, #0x55
   4209 DD B6 FA      [19]  745 	or	a, -6 (ix)
   420C 47            [ 4]  746 	ld	b,a
   420D                     747 00110$:
                            748 ;src/StringUtils.c:196: charBitArray<<=1;
   420D 79            [ 4]  749 	ld	a,c
   420E 87            [ 4]  750 	add	a, a
                            751 ;src/StringUtils.c:198: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
   420F 07            [ 4]  752 	rlca
   4210 30 07         [12]  753 	jr	NC,00112$
   4212 78            [ 4]  754 	ld	a,b
   4213 E6 AA         [ 7]  755 	and	a, #0xAA
   4215 DD B6 FB      [19]  756 	or	a, -5 (ix)
   4218 47            [ 4]  757 	ld	b,a
   4219                     758 00112$:
                            759 ;src/StringUtils.c:202: *currentPos=val;
   4219 78            [ 4]  760 	ld	a,b
   421A 12            [ 7]  761 	ld	(de),a
                            762 ;src/StringUtils.c:203: ++currentPos;
   421B 13            [ 6]  763 	inc	de
   421C DD 73 FC      [19]  764 	ld	-4 (ix),e
   421F DD 72 FD      [19]  765 	ld	-3 (ix),d
                            766 ;src/StringUtils.c:205: ++currentChar;
   4222 DD 34 FE      [23]  767 	inc	-2 (ix)
   4225 C2 A4 41      [10]  768 	jp	NZ,00113$
   4228 DD 34 FF      [23]  769 	inc	-1 (ix)
   422B C3 A4 41      [10]  770 	jp	00113$
   422E                     771 00115$:
                            772 ;src/StringUtils.c:207: position-=0x0800;
   422E DD 7E 06      [19]  773 	ld	a,6 (ix)
   4231 C6 00         [ 7]  774 	add	a,#0x00
   4233 DD 77 06      [19]  775 	ld	6 (ix),a
   4236 DD 7E 07      [19]  776 	ld	a,7 (ix)
   4239 CE F8         [ 7]  777 	adc	a,#0xF8
                            778 ;src/StringUtils.c:209: if(position<0xC000){
   423B DD 77 07      [19]  779 	ld	7 (ix), a
   423E D6 C0         [ 7]  780 	sub	a, #0xC0
   4240 D2 7A 41      [10]  781 	jp	NC,00118$
                            782 ;src/StringUtils.c:210: position+=0x4000;
   4243 DD 7E 06      [19]  783 	ld	a,6 (ix)
   4246 C6 00         [ 7]  784 	add	a, #0x00
   4248 DD 77 06      [19]  785 	ld	6 (ix),a
   424B DD 7E 07      [19]  786 	ld	a,7 (ix)
   424E CE 40         [ 7]  787 	adc	a, #0x40
   4250 DD 77 07      [19]  788 	ld	7 (ix),a
                            789 ;src/StringUtils.c:211: position-=80;
   4253 DD 7E 06      [19]  790 	ld	a,6 (ix)
   4256 C6 B0         [ 7]  791 	add	a,#0xB0
   4258 DD 77 06      [19]  792 	ld	6 (ix),a
   425B DD 7E 07      [19]  793 	ld	a,7 (ix)
   425E CE FF         [ 7]  794 	adc	a,#0xFF
   4260 DD 77 07      [19]  795 	ld	7 (ix),a
   4263 C3 7A 41      [10]  796 	jp	00118$
   4266                     797 00121$:
   4266 DD F9         [10]  798 	ld	sp, ix
   4268 DD E1         [14]  799 	pop	ix
   426A C9            [10]  800 	ret
                            801 	.area _CODE
                            802 	.area _INITIALIZER
                            803 	.area _CABS (ABS)
