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
                             47 ;src/StringUtils.c:25: void* integer_to_string(u8 n, u8 format){
                             48 ;	---------------------------------
                             49 ; Function integer_to_string
                             50 ; ---------------------------------
   1DDA                      51 _integer_to_string::
   1DDA DD E5         [15]   52 	push	ix
   1DDC DD 21 00 00   [14]   53 	ld	ix,#0
   1DE0 DD 39         [15]   54 	add	ix,sp
                             55 ;src/StringUtils.c:26: u8* charPosition=(u8*)&i_to_s_buffer;
   1DE2 01 38 1F      [10]   56 	ld	bc,#_i_to_s_buffer+0
                             57 ;src/StringUtils.c:28: switch(format){
   1DE5 DD 7E 05      [19]   58 	ld	a,5 (ix)
   1DE8 D6 62         [ 7]   59 	sub	a, #0x62
   1DEA 28 45         [12]   60 	jr	Z,00102$
   1DEC DD 7E 05      [19]   61 	ld	a,5 (ix)
   1DEF D6 68         [ 7]   62 	sub	a, #0x68
   1DF1 20 57         [12]   63 	jr	NZ,00106$
                             64 ;src/StringUtils.c:30: charPosition+=2;
   1DF3 11 3A 1F      [10]   65 	ld	de,#_i_to_s_buffer + 2
                             66 ;src/StringUtils.c:32: *charPosition = 0;
   1DF6 AF            [ 4]   67 	xor	a, a
   1DF7 12            [ 7]   68 	ld	(de),a
                             69 ;src/StringUtils.c:34: --charPosition;
   1DF8 1B            [ 6]   70 	dec	de
                             71 ;src/StringUtils.c:36: t=n%16;
   1DF9 DD 7E 04      [19]   72 	ld	a,4 (ix)
   1DFC E6 0F         [ 7]   73 	and	a, #0x0F
   1DFE 6F            [ 4]   74 	ld	l,a
                             75 ;src/StringUtils.c:37: t=t>9?t+64:t+48;
   1DFF 3E 09         [ 7]   76 	ld	a,#0x09
   1E01 95            [ 4]   77 	sub	a, l
   1E02 30 05         [12]   78 	jr	NC,00110$
   1E04 7D            [ 4]   79 	ld	a,l
   1E05 C6 40         [ 7]   80 	add	a, #0x40
   1E07 18 03         [12]   81 	jr	00111$
   1E09                      82 00110$:
   1E09 7D            [ 4]   83 	ld	a,l
   1E0A C6 30         [ 7]   84 	add	a, #0x30
   1E0C                      85 00111$:
                             86 ;src/StringUtils.c:38: *charPosition=t;
   1E0C 12            [ 7]   87 	ld	(de),a
                             88 ;src/StringUtils.c:39: n/=16;
   1E0D DD 7E 04      [19]   89 	ld	a,4 (ix)
   1E10 07            [ 4]   90 	rlca
   1E11 07            [ 4]   91 	rlca
   1E12 07            [ 4]   92 	rlca
   1E13 07            [ 4]   93 	rlca
   1E14 E6 0F         [ 7]   94 	and	a,#0x0F
   1E16 DD 77 04      [19]   95 	ld	4 (ix),a
                             96 ;src/StringUtils.c:40: --charPosition;
   1E19 1B            [ 6]   97 	dec	de
                             98 ;src/StringUtils.c:42: t=n%16;
   1E1A DD 7E 04      [19]   99 	ld	a,4 (ix)
   1E1D E6 0F         [ 7]  100 	and	a, #0x0F
   1E1F 6F            [ 4]  101 	ld	l,a
                            102 ;src/StringUtils.c:43: t=t>9?t+64:t+48;
   1E20 3E 09         [ 7]  103 	ld	a,#0x09
   1E22 95            [ 4]  104 	sub	a, l
   1E23 30 05         [12]  105 	jr	NC,00112$
   1E25 7D            [ 4]  106 	ld	a,l
   1E26 C6 40         [ 7]  107 	add	a, #0x40
   1E28 18 03         [12]  108 	jr	00113$
   1E2A                     109 00112$:
   1E2A 7D            [ 4]  110 	ld	a,l
   1E2B C6 30         [ 7]  111 	add	a, #0x30
   1E2D                     112 00113$:
                            113 ;src/StringUtils.c:44: *charPosition=t;
   1E2D 12            [ 7]  114 	ld	(de),a
                            115 ;src/StringUtils.c:45: break;
   1E2E C3 B3 1E      [10]  116 	jp	00107$
                            117 ;src/StringUtils.c:47: case 'b':{
   1E31                     118 00102$:
                            119 ;src/StringUtils.c:49: charPosition+=8;
   1E31 21 40 1F      [10]  120 	ld	hl,#_i_to_s_buffer + 8
                            121 ;src/StringUtils.c:51: while(t){
   1E34 1E 08         [ 7]  122 	ld	e,#0x08
   1E36                     123 00103$:
   1E36 7B            [ 4]  124 	ld	a,e
   1E37 B7            [ 4]  125 	or	a, a
   1E38 28 79         [12]  126 	jr	Z,00107$
                            127 ;src/StringUtils.c:52: --t;
   1E3A 1D            [ 4]  128 	dec	e
                            129 ;src/StringUtils.c:53: --charPosition;
   1E3B 2B            [ 6]  130 	dec	hl
                            131 ;src/StringUtils.c:54: *charPosition=(n&1)+48;
   1E3C DD 7E 04      [19]  132 	ld	a,4 (ix)
   1E3F E6 01         [ 7]  133 	and	a, #0x01
   1E41 C6 30         [ 7]  134 	add	a, #0x30
   1E43 77            [ 7]  135 	ld	(hl),a
                            136 ;src/StringUtils.c:55: n>>=1;
   1E44 DD CB 04 3E   [23]  137 	srl	4 (ix)
   1E48 18 EC         [12]  138 	jr	00103$
                            139 ;src/StringUtils.c:59: default:{
   1E4A                     140 00106$:
                            141 ;src/StringUtils.c:60: charPosition+=3;
   1E4A 11 3B 1F      [10]  142 	ld	de,#_i_to_s_buffer + 3
                            143 ;src/StringUtils.c:62: *charPosition = 0;
   1E4D AF            [ 4]  144 	xor	a, a
   1E4E 12            [ 7]  145 	ld	(de),a
                            146 ;src/StringUtils.c:64: --charPosition;
   1E4F 1B            [ 6]  147 	dec	de
                            148 ;src/StringUtils.c:66: *charPosition=48+(n%10);
   1E50 C5            [11]  149 	push	bc
   1E51 D5            [11]  150 	push	de
   1E52 3E 0A         [ 7]  151 	ld	a,#0x0A
   1E54 F5            [11]  152 	push	af
   1E55 33            [ 6]  153 	inc	sp
   1E56 DD 7E 04      [19]  154 	ld	a,4 (ix)
   1E59 F5            [11]  155 	push	af
   1E5A 33            [ 6]  156 	inc	sp
   1E5B CD 45 42      [17]  157 	call	__moduchar
   1E5E F1            [10]  158 	pop	af
   1E5F D1            [10]  159 	pop	de
   1E60 C1            [10]  160 	pop	bc
   1E61 7D            [ 4]  161 	ld	a,l
   1E62 C6 30         [ 7]  162 	add	a, #0x30
   1E64 12            [ 7]  163 	ld	(de),a
                            164 ;src/StringUtils.c:67: --charPosition;
                            165 ;src/StringUtils.c:68: n/=10;
   1E65 C5            [11]  166 	push	bc
   1E66 3E 0A         [ 7]  167 	ld	a,#0x0A
   1E68 F5            [11]  168 	push	af
   1E69 33            [ 6]  169 	inc	sp
   1E6A DD 7E 04      [19]  170 	ld	a,4 (ix)
   1E6D F5            [11]  171 	push	af
   1E6E 33            [ 6]  172 	inc	sp
   1E6F CD 64 42      [17]  173 	call	__divuchar
   1E72 F1            [10]  174 	pop	af
   1E73 C1            [10]  175 	pop	bc
   1E74 DD 75 04      [19]  176 	ld	4 (ix),l
                            177 ;src/StringUtils.c:69: *charPosition=48+(n%10);
   1E77 C5            [11]  178 	push	bc
   1E78 3E 0A         [ 7]  179 	ld	a,#0x0A
   1E7A F5            [11]  180 	push	af
   1E7B 33            [ 6]  181 	inc	sp
   1E7C DD 7E 04      [19]  182 	ld	a,4 (ix)
   1E7F F5            [11]  183 	push	af
   1E80 33            [ 6]  184 	inc	sp
   1E81 CD 45 42      [17]  185 	call	__moduchar
   1E84 F1            [10]  186 	pop	af
   1E85 C1            [10]  187 	pop	bc
   1E86 7D            [ 4]  188 	ld	a,l
   1E87 C6 30         [ 7]  189 	add	a, #0x30
   1E89 32 39 1F      [13]  190 	ld	(#(_i_to_s_buffer + 0x0001)),a
                            191 ;src/StringUtils.c:70: --charPosition;
                            192 ;src/StringUtils.c:71: n/=10;
   1E8C C5            [11]  193 	push	bc
   1E8D 3E 0A         [ 7]  194 	ld	a,#0x0A
   1E8F F5            [11]  195 	push	af
   1E90 33            [ 6]  196 	inc	sp
   1E91 DD 7E 04      [19]  197 	ld	a,4 (ix)
   1E94 F5            [11]  198 	push	af
   1E95 33            [ 6]  199 	inc	sp
   1E96 CD 64 42      [17]  200 	call	__divuchar
   1E99 F1            [10]  201 	pop	af
   1E9A C1            [10]  202 	pop	bc
   1E9B DD 75 04      [19]  203 	ld	4 (ix),l
                            204 ;src/StringUtils.c:72: *charPosition=48+(n%10);
   1E9E C5            [11]  205 	push	bc
   1E9F 3E 0A         [ 7]  206 	ld	a,#0x0A
   1EA1 F5            [11]  207 	push	af
   1EA2 33            [ 6]  208 	inc	sp
   1EA3 DD 7E 04      [19]  209 	ld	a,4 (ix)
   1EA6 F5            [11]  210 	push	af
   1EA7 33            [ 6]  211 	inc	sp
   1EA8 CD 45 42      [17]  212 	call	__moduchar
   1EAB F1            [10]  213 	pop	af
   1EAC C1            [10]  214 	pop	bc
   1EAD 7D            [ 4]  215 	ld	a,l
   1EAE C6 30         [ 7]  216 	add	a, #0x30
   1EB0 32 38 1F      [13]  217 	ld	(#_i_to_s_buffer),a
                            218 ;src/StringUtils.c:75: }
   1EB3                     219 00107$:
                            220 ;src/StringUtils.c:77: return i_to_s_buffer;
   1EB3 69            [ 4]  221 	ld	l, c
   1EB4 60            [ 4]  222 	ld	h, b
   1EB5 DD E1         [14]  223 	pop	ix
   1EB7 C9            [10]  224 	ret
   1EB8                     225 _charArray:
   1EB8 FF                  226 	.db #0xFF	; 255
   1EB9 FF                  227 	.db #0xFF	; 255
   1EBA FF                  228 	.db #0xFF	; 255
   1EBB FF                  229 	.db #0xFF	; 255
   1EBC FF                  230 	.db #0xFF	; 255
   1EBD FF                  231 	.db #0xFF	; 255
   1EBE FF                  232 	.db #0xFF	; 255
   1EBF FF                  233 	.db #0xFF	; 255
   1EC0 FF                  234 	.db #0xFF	; 255
   1EC1 FF                  235 	.db #0xFF	; 255
   1EC2 FF                  236 	.db #0xFF	; 255
   1EC3 FF                  237 	.db #0xFF	; 255
   1EC4 FF                  238 	.db #0xFF	; 255
   1EC5 FF                  239 	.db #0xFF	; 255
   1EC6 FF                  240 	.db #0xFF	; 255
   1EC7 FF                  241 	.db #0xFF	; 255
   1EC8 FF                  242 	.db #0xFF	; 255
   1EC9 FF                  243 	.db #0xFF	; 255
   1ECA FF                  244 	.db #0xFF	; 255
   1ECB FF                  245 	.db #0xFF	; 255
   1ECC FF                  246 	.db #0xFF	; 255
   1ECD FF                  247 	.db #0xFF	; 255
   1ECE FF                  248 	.db #0xFF	; 255
   1ECF FF                  249 	.db #0xFF	; 255
   1ED0 FF                  250 	.db #0xFF	; 255
   1ED1 FF                  251 	.db #0xFF	; 255
   1ED2 FF                  252 	.db #0xFF	; 255
   1ED3 FF                  253 	.db #0xFF	; 255
   1ED4 FF                  254 	.db #0xFF	; 255
   1ED5 FF                  255 	.db #0xFF	; 255
   1ED6 FF                  256 	.db #0xFF	; 255
   1ED7 FF                  257 	.db #0xFF	; 255
   1ED8 29                  258 	.db #0x29	; 41
   1ED9 24                  259 	.db #0x24	; 36
   1EDA FF                  260 	.db #0xFF	; 255
   1EDB 2D                  261 	.db #0x2D	; 45
   1EDC 2F                  262 	.db #0x2F	; 47
   1EDD FF                  263 	.db #0xFF	; 255
   1EDE 2E                  264 	.db #0x2E	; 46
   1EDF FF                  265 	.db #0xFF	; 255
   1EE0 FF                  266 	.db #0xFF	; 255
   1EE1 FF                  267 	.db #0xFF	; 255
   1EE2 31                  268 	.db #0x31	; 49	'1'
   1EE3 2C                  269 	.db #0x2C	; 44
   1EE4 FF                  270 	.db #0xFF	; 255
   1EE5 FF                  271 	.db #0xFF	; 255
   1EE6 26                  272 	.db #0x26	; 38
   1EE7 FF                  273 	.db #0xFF	; 255
   1EE8 1A                  274 	.db #0x1A	; 26
   1EE9 1B                  275 	.db #0x1B	; 27
   1EEA 1C                  276 	.db #0x1C	; 28
   1EEB 1D                  277 	.db #0x1D	; 29
   1EEC 1E                  278 	.db #0x1E	; 30
   1EED 1F                  279 	.db #0x1F	; 31
   1EEE 20                  280 	.db #0x20	; 32
   1EEF 21                  281 	.db #0x21	; 33
   1EF0 22                  282 	.db #0x22	; 34
   1EF1 23                  283 	.db #0x23	; 35
   1EF2 27                  284 	.db #0x27	; 39
   1EF3 FF                  285 	.db #0xFF	; 255
   1EF4 2A                  286 	.db #0x2A	; 42
   1EF5 FF                  287 	.db #0xFF	; 255
   1EF6 2B                  288 	.db #0x2B	; 43
   1EF7 25                  289 	.db #0x25	; 37
   1EF8 28                  290 	.db #0x28	; 40
   1EF9 00                  291 	.db #0x00	; 0
   1EFA 01                  292 	.db #0x01	; 1
   1EFB 02                  293 	.db #0x02	; 2
   1EFC 03                  294 	.db #0x03	; 3
   1EFD 04                  295 	.db #0x04	; 4
   1EFE 05                  296 	.db #0x05	; 5
   1EFF 06                  297 	.db #0x06	; 6
   1F00 07                  298 	.db #0x07	; 7
   1F01 08                  299 	.db #0x08	; 8
   1F02 09                  300 	.db #0x09	; 9
   1F03 0A                  301 	.db #0x0A	; 10
   1F04 0B                  302 	.db #0x0B	; 11
   1F05 0C                  303 	.db #0x0C	; 12
   1F06 0D                  304 	.db #0x0D	; 13
   1F07 0E                  305 	.db #0x0E	; 14
   1F08 0F                  306 	.db #0x0F	; 15
   1F09 10                  307 	.db #0x10	; 16
   1F0A 11                  308 	.db #0x11	; 17
   1F0B 12                  309 	.db #0x12	; 18
   1F0C 13                  310 	.db #0x13	; 19
   1F0D 14                  311 	.db #0x14	; 20
   1F0E 15                  312 	.db #0x15	; 21
   1F0F 16                  313 	.db #0x16	; 22
   1F10 17                  314 	.db #0x17	; 23
   1F11 18                  315 	.db #0x18	; 24
   1F12 19                  316 	.db #0x19	; 25
   1F13 FF                  317 	.db #0xFF	; 255
   1F14 FF                  318 	.db #0xFF	; 255
   1F15 FF                  319 	.db #0xFF	; 255
   1F16 FF                  320 	.db #0xFF	; 255
   1F17 FF                  321 	.db #0xFF	; 255
   1F18 FF                  322 	.db #0xFF	; 255
   1F19 00                  323 	.db #0x00	; 0
   1F1A 01                  324 	.db #0x01	; 1
   1F1B 02                  325 	.db #0x02	; 2
   1F1C 03                  326 	.db #0x03	; 3
   1F1D 04                  327 	.db #0x04	; 4
   1F1E 05                  328 	.db #0x05	; 5
   1F1F 06                  329 	.db #0x06	; 6
   1F20 07                  330 	.db #0x07	; 7
   1F21 08                  331 	.db #0x08	; 8
   1F22 09                  332 	.db #0x09	; 9
   1F23 0A                  333 	.db #0x0A	; 10
   1F24 0B                  334 	.db #0x0B	; 11
   1F25 0C                  335 	.db #0x0C	; 12
   1F26 0D                  336 	.db #0x0D	; 13
   1F27 0E                  337 	.db #0x0E	; 14
   1F28 0F                  338 	.db #0x0F	; 15
   1F29 10                  339 	.db #0x10	; 16
   1F2A 11                  340 	.db #0x11	; 17
   1F2B 12                  341 	.db #0x12	; 18
   1F2C 13                  342 	.db #0x13	; 19
   1F2D 14                  343 	.db #0x14	; 20
   1F2E 15                  344 	.db #0x15	; 21
   1F2F 16                  345 	.db #0x16	; 22
   1F30 17                  346 	.db #0x17	; 23
   1F31 18                  347 	.db #0x18	; 24
   1F32 19                  348 	.db #0x19	; 25
   1F33 FF                  349 	.db #0xFF	; 255
   1F34 FF                  350 	.db #0xFF	; 255
   1F35 FF                  351 	.db #0xFF	; 255
   1F36 30                  352 	.db #0x30	; 48	'0'
   1F37 FF                  353 	.db #0xFF	; 255
   1F38                     354 _i_to_s_buffer:
   1F38 00                  355 	.db #0x00	; 0
   1F39 00                  356 	.db #0x00	; 0
   1F3A 00                  357 	.db #0x00	; 0
   1F3B 00                  358 	.db #0x00	; 0
   1F3C 00                  359 	.db #0x00	; 0
   1F3D 00                  360 	.db #0x00	; 0
   1F3E 00                  361 	.db #0x00	; 0
   1F3F 00                  362 	.db #0x00	; 0
   1F40 00                  363 	.db #0x00	; 0
                            364 ;src/StringUtils.c:81: void print_text(void * const text, u8* position, u8 bg, u8 fg){
                            365 ;	---------------------------------
                            366 ; Function print_text
                            367 ; ---------------------------------
   1F41                     368 _print_text::
   1F41 DD E5         [15]  369 	push	ix
   1F43 DD 21 00 00   [14]  370 	ld	ix,#0
   1F47 DD 39         [15]  371 	add	ix,sp
   1F49 21 F1 FF      [10]  372 	ld	hl,#-15
   1F4C 39            [11]  373 	add	hl,sp
   1F4D F9            [ 6]  374 	ld	sp,hl
                            375 ;src/StringUtils.c:82: u8 val, charBitArray, spritePos, fgColor=g_colors[fg], bgColor=g_colors[bg];
   1F4E DD 7E 09      [19]  376 	ld	a,9 (ix)
   1F51 C6 A5         [ 7]  377 	add	a, #<(_g_colors)
   1F53 DD 77 FE      [19]  378 	ld	-2 (ix),a
   1F56 3E 00         [ 7]  379 	ld	a,#0x00
   1F58 CE 0A         [ 7]  380 	adc	a, #>(_g_colors)
   1F5A DD 77 FF      [19]  381 	ld	-1 (ix),a
   1F5D DD 6E FE      [19]  382 	ld	l,-2 (ix)
   1F60 DD 66 FF      [19]  383 	ld	h,-1 (ix)
   1F63 7E            [ 7]  384 	ld	a,(hl)
   1F64 DD 77 F4      [19]  385 	ld	-12 (ix),a
   1F67 3E A5         [ 7]  386 	ld	a,#<(_g_colors)
   1F69 DD 86 08      [19]  387 	add	a, 8 (ix)
   1F6C DD 77 FE      [19]  388 	ld	-2 (ix),a
   1F6F 3E 0A         [ 7]  389 	ld	a,#>(_g_colors)
   1F71 CE 00         [ 7]  390 	adc	a, #0x00
   1F73 DD 77 FF      [19]  391 	ld	-1 (ix),a
   1F76 DD 6E FE      [19]  392 	ld	l,-2 (ix)
   1F79 DD 66 FF      [19]  393 	ld	h,-1 (ix)
   1F7C 7E            [ 7]  394 	ld	a,(hl)
   1F7D DD 77 F2      [19]  395 	ld	-14 (ix),a
                            396 ;src/StringUtils.c:88: position+=10240;
   1F80 DD 7E 06      [19]  397 	ld	a,6 (ix)
   1F83 C6 00         [ 7]  398 	add	a, #0x00
   1F85 DD 77 06      [19]  399 	ld	6 (ix),a
   1F88 DD 7E 07      [19]  400 	ld	a,7 (ix)
   1F8B CE 28         [ 7]  401 	adc	a, #0x28
   1F8D DD 77 07      [19]  402 	ld	7 (ix),a
                            403 ;src/StringUtils.c:90: while(height){
   1F90 DD 36 F1 06   [19]  404 	ld	-15 (ix),#0x06
   1F94 DD 7E 06      [19]  405 	ld	a,6 (ix)
   1F97 DD 77 FE      [19]  406 	ld	-2 (ix),a
   1F9A DD 7E 07      [19]  407 	ld	a,7 (ix)
   1F9D DD 77 FF      [19]  408 	ld	-1 (ix),a
   1FA0 DD 36 FB 96   [19]  409 	ld	-5 (ix),#0x96
   1FA4                     410 00106$:
   1FA4 DD 7E F1      [19]  411 	ld	a,-15 (ix)
   1FA7 B7            [ 4]  412 	or	a, a
   1FA8 CA A9 20      [10]  413 	jp	Z,00109$
                            414 ;src/StringUtils.c:91: --height;
   1FAB DD 7E FB      [19]  415 	ld	a,-5 (ix)
   1FAE C6 E7         [ 7]  416 	add	a,#0xE7
   1FB0 DD 77 FB      [19]  417 	ld	-5 (ix),a
   1FB3 DD 35 F1      [23]  418 	dec	-15 (ix)
                            419 ;src/StringUtils.c:92: currentChar=text;
   1FB6 DD 7E 04      [19]  420 	ld	a,4 (ix)
   1FB9 DD 77 F9      [19]  421 	ld	-7 (ix),a
   1FBC DD 7E 05      [19]  422 	ld	a,5 (ix)
   1FBF DD 77 FA      [19]  423 	ld	-6 (ix),a
                            424 ;src/StringUtils.c:93: currentPos=position;
   1FC2 DD 7E FE      [19]  425 	ld	a,-2 (ix)
   1FC5 DD 77 FC      [19]  426 	ld	-4 (ix),a
   1FC8 DD 7E FF      [19]  427 	ld	a,-1 (ix)
   1FCB DD 77 FD      [19]  428 	ld	-3 (ix),a
                            429 ;src/StringUtils.c:95: while(*currentChar){
   1FCE                     430 00103$:
   1FCE DD 6E F9      [19]  431 	ld	l,-7 (ix)
   1FD1 DD 66 FA      [19]  432 	ld	h,-6 (ix)
   1FD4 7E            [ 7]  433 	ld	a,(hl)
   1FD5 DD 77 F6      [19]  434 	ld	-10 (ix), a
   1FD8 B7            [ 4]  435 	or	a, a
   1FD9 CA 96 20      [10]  436 	jp	Z,00105$
                            437 ;src/StringUtils.c:97: spritePos = charArray[(*currentChar)];
   1FDC 3E B8         [ 7]  438 	ld	a,#<(_charArray)
   1FDE DD 86 F6      [19]  439 	add	a, -10 (ix)
   1FE1 DD 77 F7      [19]  440 	ld	-9 (ix),a
   1FE4 3E 1E         [ 7]  441 	ld	a,#>(_charArray)
   1FE6 CE 00         [ 7]  442 	adc	a, #0x00
   1FE8 DD 77 F8      [19]  443 	ld	-8 (ix),a
   1FEB DD 6E F7      [19]  444 	ld	l,-9 (ix)
   1FEE DD 66 F8      [19]  445 	ld	h,-8 (ix)
   1FF1 7E            [ 7]  446 	ld	a,(hl)
                            447 ;src/StringUtils.c:99: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   1FF2 DD 77 F3      [19]  448 	ld	-13 (ix), a
   1FF5 CB 3F         [ 8]  449 	srl	a
   1FF7 DD 77 F7      [19]  450 	ld	-9 (ix), a
   1FFA DD 86 FB      [19]  451 	add	a, -5 (ix)
   1FFD DD 77 F7      [19]  452 	ld	-9 (ix),a
   2000 C6 5D         [ 7]  453 	add	a,#<(_typography_4x6_monospaced)
   2002 DD 77 F7      [19]  454 	ld	-9 (ix),a
   2005 3E 2C         [ 7]  455 	ld	a,#>(_typography_4x6_monospaced)
   2007 CE 00         [ 7]  456 	adc	a, #0x00
   2009 DD 77 F8      [19]  457 	ld	-8 (ix),a
   200C DD 6E F7      [19]  458 	ld	l,-9 (ix)
   200F DD 66 F8      [19]  459 	ld	h,-8 (ix)
   2012 7E            [ 7]  460 	ld	a,(hl)
   2013 DD 77 F7      [19]  461 	ld	-9 (ix),a
                            462 ;src/StringUtils.c:101: if(spritePos%2) charBitArray<<=4;
   2016 DD CB F3 46   [20]  463 	bit	0, -13 (ix)
   201A 28 0C         [12]  464 	jr	Z,00102$
   201C DD 7E F7      [19]  465 	ld	a,-9 (ix)
   201F 07            [ 4]  466 	rlca
   2020 07            [ 4]  467 	rlca
   2021 07            [ 4]  468 	rlca
   2022 07            [ 4]  469 	rlca
   2023 E6 F0         [ 7]  470 	and	a,#0xF0
   2025 DD 77 F7      [19]  471 	ld	-9 (ix),a
   2028                     472 00102$:
                            473 ;src/StringUtils.c:105: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   2028 DD CB F7 7E   [20]  474 	bit	7, -9 (ix)
   202C 28 05         [12]  475 	jr	Z,00111$
   202E DD 7E F4      [19]  476 	ld	a,-12 (ix)
   2031 18 03         [12]  477 	jr	00112$
   2033                     478 00111$:
   2033 DD 7E F2      [19]  479 	ld	a,-14 (ix)
   2036                     480 00112$:
   2036 E6 AA         [ 7]  481 	and	a, #0xAA
   2038 4F            [ 4]  482 	ld	c,a
                            483 ;src/StringUtils.c:107: charBitArray<<=1;
   2039 DD 7E F7      [19]  484 	ld	a,-9 (ix)
   203C 87            [ 4]  485 	add	a, a
   203D 47            [ 4]  486 	ld	b,a
                            487 ;src/StringUtils.c:109: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   203E CB 78         [ 8]  488 	bit	7, b
   2040 28 05         [12]  489 	jr	Z,00113$
   2042 DD 7E F4      [19]  490 	ld	a,-12 (ix)
   2045 18 03         [12]  491 	jr	00114$
   2047                     492 00113$:
   2047 DD 7E F2      [19]  493 	ld	a,-14 (ix)
   204A                     494 00114$:
   204A E6 55         [ 7]  495 	and	a, #0x55
   204C B1            [ 4]  496 	or	a, c
   204D 5F            [ 4]  497 	ld	e,a
                            498 ;src/StringUtils.c:111: charBitArray<<=1;
   204E 78            [ 4]  499 	ld	a,b
   204F 87            [ 4]  500 	add	a, a
   2050 4F            [ 4]  501 	ld	c,a
                            502 ;src/StringUtils.c:113: *currentPos=val;
   2051 DD 6E FC      [19]  503 	ld	l,-4 (ix)
   2054 DD 66 FD      [19]  504 	ld	h,-3 (ix)
   2057 73            [ 7]  505 	ld	(hl),e
                            506 ;src/StringUtils.c:114: ++currentPos;
   2058 DD 5E FC      [19]  507 	ld	e,-4 (ix)
   205B DD 56 FD      [19]  508 	ld	d,-3 (ix)
   205E 13            [ 6]  509 	inc	de
                            510 ;src/StringUtils.c:118: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   205F CB 79         [ 8]  511 	bit	7, c
   2061 28 05         [12]  512 	jr	Z,00115$
   2063 DD 7E F4      [19]  513 	ld	a,-12 (ix)
   2066 18 03         [12]  514 	jr	00116$
   2068                     515 00115$:
   2068 DD 7E F2      [19]  516 	ld	a,-14 (ix)
   206B                     517 00116$:
   206B E6 AA         [ 7]  518 	and	a, #0xAA
   206D DD 77 F5      [19]  519 	ld	-11 (ix),a
                            520 ;src/StringUtils.c:120: charBitArray<<=1;
   2070 79            [ 4]  521 	ld	a,c
   2071 87            [ 4]  522 	add	a, a
                            523 ;src/StringUtils.c:122: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   2072 07            [ 4]  524 	rlca
   2073 30 05         [12]  525 	jr	NC,00117$
   2075 DD 7E F4      [19]  526 	ld	a,-12 (ix)
   2078 18 03         [12]  527 	jr	00118$
   207A                     528 00117$:
   207A DD 7E F2      [19]  529 	ld	a,-14 (ix)
   207D                     530 00118$:
   207D E6 55         [ 7]  531 	and	a, #0x55
   207F DD B6 F5      [19]  532 	or	a, -11 (ix)
                            533 ;src/StringUtils.c:126: *currentPos=val;
   2082 12            [ 7]  534 	ld	(de),a
                            535 ;src/StringUtils.c:127: ++currentPos;
   2083 13            [ 6]  536 	inc	de
   2084 DD 73 FC      [19]  537 	ld	-4 (ix),e
   2087 DD 72 FD      [19]  538 	ld	-3 (ix),d
                            539 ;src/StringUtils.c:129: ++currentChar;
   208A DD 34 F9      [23]  540 	inc	-7 (ix)
   208D C2 CE 1F      [10]  541 	jp	NZ,00103$
   2090 DD 34 FA      [23]  542 	inc	-6 (ix)
   2093 C3 CE 1F      [10]  543 	jp	00103$
   2096                     544 00105$:
                            545 ;src/StringUtils.c:131: position-=(2048);
   2096 DD 7E FE      [19]  546 	ld	a,-2 (ix)
   2099 C6 00         [ 7]  547 	add	a,#0x00
   209B DD 77 FE      [19]  548 	ld	-2 (ix),a
   209E DD 7E FF      [19]  549 	ld	a,-1 (ix)
   20A1 CE F8         [ 7]  550 	adc	a,#0xF8
   20A3 DD 77 FF      [19]  551 	ld	-1 (ix),a
   20A6 C3 A4 1F      [10]  552 	jp	00106$
   20A9                     553 00109$:
   20A9 DD F9         [10]  554 	ld	sp, ix
   20AB DD E1         [14]  555 	pop	ix
   20AD C9            [10]  556 	ret
                            557 ;src/StringUtils.c:136: void print_transparent_text(void* const text, u8* position, u8 fg){
                            558 ;	---------------------------------
                            559 ; Function print_transparent_text
                            560 ; ---------------------------------
   20AE                     561 _print_transparent_text::
   20AE DD E5         [15]  562 	push	ix
   20B0 DD 21 00 00   [14]  563 	ld	ix,#0
   20B4 DD 39         [15]  564 	add	ix,sp
   20B6 21 F5 FF      [10]  565 	ld	hl,#-11
   20B9 39            [11]  566 	add	hl,sp
   20BA F9            [ 6]  567 	ld	sp,hl
                            568 ;src/StringUtils.c:143: position+=10240;
   20BB DD 7E 06      [19]  569 	ld	a,6 (ix)
   20BE C6 00         [ 7]  570 	add	a, #0x00
   20C0 DD 77 06      [19]  571 	ld	6 (ix),a
   20C3 DD 7E 07      [19]  572 	ld	a,7 (ix)
   20C6 CE 28         [ 7]  573 	adc	a, #0x28
   20C8 DD 77 07      [19]  574 	ld	7 (ix),a
                            575 ;src/StringUtils.c:145: while(height){
   20CB DD 7E 08      [19]  576 	ld	a,8 (ix)
   20CE C6 A5         [ 7]  577 	add	a, #<(_g_colors)
   20D0 DD 77 F7      [19]  578 	ld	-9 (ix),a
   20D3 3E 00         [ 7]  579 	ld	a,#0x00
   20D5 CE 0A         [ 7]  580 	adc	a, #>(_g_colors)
   20D7 DD 77 F8      [19]  581 	ld	-8 (ix),a
   20DA DD 36 F5 06   [19]  582 	ld	-11 (ix),#0x06
   20DE DD 7E 06      [19]  583 	ld	a,6 (ix)
   20E1 DD 77 FC      [19]  584 	ld	-4 (ix),a
   20E4 DD 7E 07      [19]  585 	ld	a,7 (ix)
   20E7 DD 77 FD      [19]  586 	ld	-3 (ix),a
   20EA DD 36 FB 96   [19]  587 	ld	-5 (ix),#0x96
   20EE                     588 00114$:
   20EE DD 7E F5      [19]  589 	ld	a,-11 (ix)
   20F1 B7            [ 4]  590 	or	a, a
   20F2 CA E1 21      [10]  591 	jp	Z,00117$
                            592 ;src/StringUtils.c:146: currentChar=text;
   20F5 DD 7E 04      [19]  593 	ld	a,4 (ix)
   20F8 DD 77 F9      [19]  594 	ld	-7 (ix),a
   20FB DD 7E 05      [19]  595 	ld	a,5 (ix)
   20FE DD 77 FA      [19]  596 	ld	-6 (ix),a
                            597 ;src/StringUtils.c:147: currentPos=position;
   2101 DD 7E FC      [19]  598 	ld	a,-4 (ix)
   2104 DD 77 FE      [19]  599 	ld	-2 (ix),a
   2107 DD 7E FD      [19]  600 	ld	a,-3 (ix)
   210A DD 77 FF      [19]  601 	ld	-1 (ix),a
                            602 ;src/StringUtils.c:148: --height;
   210D DD 7E FB      [19]  603 	ld	a,-5 (ix)
   2110 C6 E7         [ 7]  604 	add	a,#0xE7
   2112 DD 77 FB      [19]  605 	ld	-5 (ix),a
   2115 DD 35 F5      [23]  606 	dec	-11 (ix)
                            607 ;src/StringUtils.c:149: while(*currentChar){
   2118                     608 00111$:
   2118 DD 6E F9      [19]  609 	ld	l,-7 (ix)
   211B DD 66 FA      [19]  610 	ld	h,-6 (ix)
   211E 4E            [ 7]  611 	ld	c,(hl)
   211F 79            [ 4]  612 	ld	a,c
   2120 B7            [ 4]  613 	or	a, a
   2121 CA CE 21      [10]  614 	jp	Z,00113$
                            615 ;src/StringUtils.c:151: spritePos = charArray[(*currentChar)];
   2124 21 B8 1E      [10]  616 	ld	hl,#_charArray
   2127 06 00         [ 7]  617 	ld	b,#0x00
   2129 09            [11]  618 	add	hl, bc
   212A 46            [ 7]  619 	ld	b,(hl)
                            620 ;src/StringUtils.c:153: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   212B 78            [ 4]  621 	ld	a, b
   212C CB 3F         [ 8]  622 	srl	a
   212E DD 86 FB      [19]  623 	add	a, -5 (ix)
   2131 5F            [ 4]  624 	ld	e,a
   2132 21 5D 2C      [10]  625 	ld	hl,#_typography_4x6_monospaced
   2135 16 00         [ 7]  626 	ld	d,#0x00
   2137 19            [11]  627 	add	hl, de
   2138 4E            [ 7]  628 	ld	c,(hl)
                            629 ;src/StringUtils.c:155: if(spritePos%2) charBitArray<<=4;
   2139 CB 40         [ 8]  630 	bit	0, b
   213B 28 08         [12]  631 	jr	Z,00102$
   213D 79            [ 4]  632 	ld	a,c
   213E 07            [ 4]  633 	rlca
   213F 07            [ 4]  634 	rlca
   2140 07            [ 4]  635 	rlca
   2141 07            [ 4]  636 	rlca
   2142 E6 F0         [ 7]  637 	and	a,#0xF0
   2144 4F            [ 4]  638 	ld	c,a
   2145                     639 00102$:
                            640 ;src/StringUtils.c:157: val=*currentPos;
   2145 DD 6E FE      [19]  641 	ld	l,-2 (ix)
   2148 DD 66 FF      [19]  642 	ld	h,-1 (ix)
   214B 46            [ 7]  643 	ld	b,(hl)
                            644 ;src/StringUtils.c:159: if(charBitArray&0b10000000) val = (g_colors[fg]&0b10101010)|(val&0b01010101);
   214C CB 79         [ 8]  645 	bit	7, c
   214E 28 0F         [12]  646 	jr	Z,00104$
   2150 DD 6E F7      [19]  647 	ld	l,-9 (ix)
   2153 DD 66 F8      [19]  648 	ld	h,-8 (ix)
   2156 7E            [ 7]  649 	ld	a,(hl)
   2157 E6 AA         [ 7]  650 	and	a, #0xAA
   2159 5F            [ 4]  651 	ld	e,a
   215A 78            [ 4]  652 	ld	a,b
   215B E6 55         [ 7]  653 	and	a, #0x55
   215D B3            [ 4]  654 	or	a, e
   215E 47            [ 4]  655 	ld	b,a
   215F                     656 00104$:
                            657 ;src/StringUtils.c:161: charBitArray<<=1;
   215F CB 21         [ 8]  658 	sla	c
                            659 ;src/StringUtils.c:163: if(charBitArray&0b10000000) val = (g_colors[fg]&0b01010101)|(val&0b10101010);
   2161 CB 79         [ 8]  660 	bit	7, c
   2163 28 0F         [12]  661 	jr	Z,00106$
   2165 DD 6E F7      [19]  662 	ld	l,-9 (ix)
   2168 DD 66 F8      [19]  663 	ld	h,-8 (ix)
   216B 7E            [ 7]  664 	ld	a,(hl)
   216C E6 55         [ 7]  665 	and	a, #0x55
   216E 5F            [ 4]  666 	ld	e,a
   216F 78            [ 4]  667 	ld	a,b
   2170 E6 AA         [ 7]  668 	and	a, #0xAA
   2172 B3            [ 4]  669 	or	a, e
   2173 47            [ 4]  670 	ld	b,a
   2174                     671 00106$:
                            672 ;src/StringUtils.c:165: charBitArray<<=1;
   2174 CB 21         [ 8]  673 	sla	c
                            674 ;src/StringUtils.c:167: *currentPos=val;
   2176 DD 6E FE      [19]  675 	ld	l,-2 (ix)
   2179 DD 66 FF      [19]  676 	ld	h,-1 (ix)
   217C 70            [ 7]  677 	ld	(hl),b
                            678 ;src/StringUtils.c:168: ++currentPos;
   217D DD 5E FE      [19]  679 	ld	e,-2 (ix)
   2180 DD 56 FF      [19]  680 	ld	d,-1 (ix)
   2183 13            [ 6]  681 	inc	de
                            682 ;src/StringUtils.c:170: val=*currentPos;
   2184 1A            [ 7]  683 	ld	a,(de)
   2185 DD 77 F6      [19]  684 	ld	-10 (ix),a
                            685 ;src/StringUtils.c:172: if(charBitArray&0b10000000) val = (g_colors[fg]&0b10101010)|(val&0b01010101);
   2188 CB 79         [ 8]  686 	bit	7, c
   218A 28 13         [12]  687 	jr	Z,00108$
   218C DD 6E F7      [19]  688 	ld	l,-9 (ix)
   218F DD 66 F8      [19]  689 	ld	h,-8 (ix)
   2192 7E            [ 7]  690 	ld	a,(hl)
   2193 E6 AA         [ 7]  691 	and	a, #0xAA
   2195 47            [ 4]  692 	ld	b,a
   2196 DD 7E F6      [19]  693 	ld	a,-10 (ix)
   2199 E6 55         [ 7]  694 	and	a, #0x55
   219B B0            [ 4]  695 	or	a, b
   219C DD 77 F6      [19]  696 	ld	-10 (ix),a
   219F                     697 00108$:
                            698 ;src/StringUtils.c:174: charBitArray<<=1;
   219F 79            [ 4]  699 	ld	a,c
   21A0 87            [ 4]  700 	add	a, a
                            701 ;src/StringUtils.c:176: if(charBitArray&0b10000000) val = (g_colors[fg]&0b01010101)|(val&0b10101010);
   21A1 07            [ 4]  702 	rlca
   21A2 30 13         [12]  703 	jr	NC,00110$
   21A4 DD 6E F7      [19]  704 	ld	l,-9 (ix)
   21A7 DD 66 F8      [19]  705 	ld	h,-8 (ix)
   21AA 7E            [ 7]  706 	ld	a,(hl)
   21AB E6 55         [ 7]  707 	and	a, #0x55
   21AD 4F            [ 4]  708 	ld	c,a
   21AE DD 7E F6      [19]  709 	ld	a,-10 (ix)
   21B1 E6 AA         [ 7]  710 	and	a, #0xAA
   21B3 B1            [ 4]  711 	or	a, c
   21B4 DD 77 F6      [19]  712 	ld	-10 (ix),a
   21B7                     713 00110$:
                            714 ;src/StringUtils.c:180: *currentPos=val;
   21B7 DD 7E F6      [19]  715 	ld	a,-10 (ix)
   21BA 12            [ 7]  716 	ld	(de),a
                            717 ;src/StringUtils.c:181: ++currentPos;
   21BB 13            [ 6]  718 	inc	de
   21BC DD 73 FE      [19]  719 	ld	-2 (ix),e
   21BF DD 72 FF      [19]  720 	ld	-1 (ix),d
                            721 ;src/StringUtils.c:183: ++currentChar;
   21C2 DD 34 F9      [23]  722 	inc	-7 (ix)
   21C5 C2 18 21      [10]  723 	jp	NZ,00111$
   21C8 DD 34 FA      [23]  724 	inc	-6 (ix)
   21CB C3 18 21      [10]  725 	jp	00111$
   21CE                     726 00113$:
                            727 ;src/StringUtils.c:185: position-=(2048);
   21CE DD 7E FC      [19]  728 	ld	a,-4 (ix)
   21D1 C6 00         [ 7]  729 	add	a,#0x00
   21D3 DD 77 FC      [19]  730 	ld	-4 (ix),a
   21D6 DD 7E FD      [19]  731 	ld	a,-3 (ix)
   21D9 CE F8         [ 7]  732 	adc	a,#0xF8
   21DB DD 77 FD      [19]  733 	ld	-3 (ix),a
   21DE C3 EE 20      [10]  734 	jp	00114$
   21E1                     735 00117$:
   21E1 DD F9         [10]  736 	ld	sp, ix
   21E3 DD E1         [14]  737 	pop	ix
   21E5 C9            [10]  738 	ret
                            739 	.area _CODE
                            740 	.area _INITIALIZER
                            741 	.area _CABS (ABS)
