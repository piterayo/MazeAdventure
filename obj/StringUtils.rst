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
   251B                      51 _integer_to_string::
   251B DD E5         [15]   52 	push	ix
   251D DD 21 00 00   [14]   53 	ld	ix,#0
   2521 DD 39         [15]   54 	add	ix,sp
                             55 ;src/StringUtils.c:36: u8* charPosition=(u8*)&i_to_s_buffer;
   2523 01 79 26      [10]   56 	ld	bc,#_i_to_s_buffer+0
                             57 ;src/StringUtils.c:38: switch(format){
   2526 DD 7E 05      [19]   58 	ld	a,5 (ix)
   2529 D6 62         [ 7]   59 	sub	a, #0x62
   252B 28 45         [12]   60 	jr	Z,00102$
   252D DD 7E 05      [19]   61 	ld	a,5 (ix)
   2530 D6 68         [ 7]   62 	sub	a, #0x68
   2532 20 57         [12]   63 	jr	NZ,00106$
                             64 ;src/StringUtils.c:40: charPosition+=2;
   2534 11 7B 26      [10]   65 	ld	de,#_i_to_s_buffer + 2
                             66 ;src/StringUtils.c:42: *charPosition = 0;
   2537 AF            [ 4]   67 	xor	a, a
   2538 12            [ 7]   68 	ld	(de),a
                             69 ;src/StringUtils.c:44: --charPosition;
   2539 1B            [ 6]   70 	dec	de
                             71 ;src/StringUtils.c:46: t=n&0x0F;
   253A DD 7E 04      [19]   72 	ld	a,4 (ix)
   253D E6 0F         [ 7]   73 	and	a, #0x0F
   253F 6F            [ 4]   74 	ld	l,a
                             75 ;src/StringUtils.c:47: t=t>9?t+55:t+48;
   2540 3E 09         [ 7]   76 	ld	a,#0x09
   2542 95            [ 4]   77 	sub	a, l
   2543 30 05         [12]   78 	jr	NC,00110$
   2545 7D            [ 4]   79 	ld	a,l
   2546 C6 37         [ 7]   80 	add	a, #0x37
   2548 18 03         [12]   81 	jr	00111$
   254A                      82 00110$:
   254A 7D            [ 4]   83 	ld	a,l
   254B C6 30         [ 7]   84 	add	a, #0x30
   254D                      85 00111$:
                             86 ;src/StringUtils.c:48: *charPosition=t;
   254D 12            [ 7]   87 	ld	(de),a
                             88 ;src/StringUtils.c:49: n>>=4;
   254E DD 7E 04      [19]   89 	ld	a,4 (ix)
   2551 07            [ 4]   90 	rlca
   2552 07            [ 4]   91 	rlca
   2553 07            [ 4]   92 	rlca
   2554 07            [ 4]   93 	rlca
   2555 E6 0F         [ 7]   94 	and	a,#0x0F
   2557 DD 77 04      [19]   95 	ld	4 (ix),a
                             96 ;src/StringUtils.c:50: --charPosition;
   255A 1B            [ 6]   97 	dec	de
                             98 ;src/StringUtils.c:52: t=n>9?n+55:n+48;
   255B 3E 09         [ 7]   99 	ld	a,#0x09
   255D DD 96 04      [19]  100 	sub	a, 4 (ix)
   2560 30 07         [12]  101 	jr	NC,00112$
   2562 DD 7E 04      [19]  102 	ld	a,4 (ix)
   2565 C6 37         [ 7]  103 	add	a, #0x37
   2567 18 05         [12]  104 	jr	00113$
   2569                     105 00112$:
   2569 DD 7E 04      [19]  106 	ld	a,4 (ix)
   256C C6 30         [ 7]  107 	add	a, #0x30
   256E                     108 00113$:
                            109 ;src/StringUtils.c:53: *charPosition=t;
   256E 12            [ 7]  110 	ld	(de),a
                            111 ;src/StringUtils.c:54: break;
   256F C3 F4 25      [10]  112 	jp	00107$
                            113 ;src/StringUtils.c:56: case 'b':{
   2572                     114 00102$:
                            115 ;src/StringUtils.c:58: charPosition+=8;
   2572 21 81 26      [10]  116 	ld	hl,#_i_to_s_buffer + 8
                            117 ;src/StringUtils.c:60: while(t){
   2575 1E 08         [ 7]  118 	ld	e,#0x08
   2577                     119 00103$:
   2577 7B            [ 4]  120 	ld	a,e
   2578 B7            [ 4]  121 	or	a, a
   2579 28 79         [12]  122 	jr	Z,00107$
                            123 ;src/StringUtils.c:61: --t;
   257B 1D            [ 4]  124 	dec	e
                            125 ;src/StringUtils.c:62: --charPosition;
   257C 2B            [ 6]  126 	dec	hl
                            127 ;src/StringUtils.c:63: *charPosition=(n&1)+48;
   257D DD 7E 04      [19]  128 	ld	a,4 (ix)
   2580 E6 01         [ 7]  129 	and	a, #0x01
   2582 C6 30         [ 7]  130 	add	a, #0x30
   2584 77            [ 7]  131 	ld	(hl),a
                            132 ;src/StringUtils.c:64: n>>=1;
   2585 DD CB 04 3E   [23]  133 	srl	4 (ix)
   2589 18 EC         [12]  134 	jr	00103$
                            135 ;src/StringUtils.c:68: default:{
   258B                     136 00106$:
                            137 ;src/StringUtils.c:69: charPosition+=3;
   258B 11 7C 26      [10]  138 	ld	de,#_i_to_s_buffer + 3
                            139 ;src/StringUtils.c:71: *charPosition = 0;
   258E AF            [ 4]  140 	xor	a, a
   258F 12            [ 7]  141 	ld	(de),a
                            142 ;src/StringUtils.c:73: --charPosition;
   2590 1B            [ 6]  143 	dec	de
                            144 ;src/StringUtils.c:75: *charPosition=48+(n%10);
   2591 C5            [11]  145 	push	bc
   2592 D5            [11]  146 	push	de
   2593 3E 0A         [ 7]  147 	ld	a,#0x0A
   2595 F5            [11]  148 	push	af
   2596 33            [ 6]  149 	inc	sp
   2597 DD 7E 04      [19]  150 	ld	a,4 (ix)
   259A F5            [11]  151 	push	af
   259B 33            [ 6]  152 	inc	sp
   259C CD 23 58      [17]  153 	call	__moduchar
   259F F1            [10]  154 	pop	af
   25A0 D1            [10]  155 	pop	de
   25A1 C1            [10]  156 	pop	bc
   25A2 7D            [ 4]  157 	ld	a,l
   25A3 C6 30         [ 7]  158 	add	a, #0x30
   25A5 12            [ 7]  159 	ld	(de),a
                            160 ;src/StringUtils.c:76: --charPosition;
                            161 ;src/StringUtils.c:77: n/=10;
   25A6 C5            [11]  162 	push	bc
   25A7 3E 0A         [ 7]  163 	ld	a,#0x0A
   25A9 F5            [11]  164 	push	af
   25AA 33            [ 6]  165 	inc	sp
   25AB DD 7E 04      [19]  166 	ld	a,4 (ix)
   25AE F5            [11]  167 	push	af
   25AF 33            [ 6]  168 	inc	sp
   25B0 CD 42 58      [17]  169 	call	__divuchar
   25B3 F1            [10]  170 	pop	af
   25B4 C1            [10]  171 	pop	bc
   25B5 DD 75 04      [19]  172 	ld	4 (ix),l
                            173 ;src/StringUtils.c:78: *charPosition=48+(n%10);
   25B8 C5            [11]  174 	push	bc
   25B9 3E 0A         [ 7]  175 	ld	a,#0x0A
   25BB F5            [11]  176 	push	af
   25BC 33            [ 6]  177 	inc	sp
   25BD DD 7E 04      [19]  178 	ld	a,4 (ix)
   25C0 F5            [11]  179 	push	af
   25C1 33            [ 6]  180 	inc	sp
   25C2 CD 23 58      [17]  181 	call	__moduchar
   25C5 F1            [10]  182 	pop	af
   25C6 C1            [10]  183 	pop	bc
   25C7 7D            [ 4]  184 	ld	a,l
   25C8 C6 30         [ 7]  185 	add	a, #0x30
   25CA 32 7A 26      [13]  186 	ld	(#(_i_to_s_buffer + 0x0001)),a
                            187 ;src/StringUtils.c:79: --charPosition;
                            188 ;src/StringUtils.c:80: n/=10;
   25CD C5            [11]  189 	push	bc
   25CE 3E 0A         [ 7]  190 	ld	a,#0x0A
   25D0 F5            [11]  191 	push	af
   25D1 33            [ 6]  192 	inc	sp
   25D2 DD 7E 04      [19]  193 	ld	a,4 (ix)
   25D5 F5            [11]  194 	push	af
   25D6 33            [ 6]  195 	inc	sp
   25D7 CD 42 58      [17]  196 	call	__divuchar
   25DA F1            [10]  197 	pop	af
   25DB C1            [10]  198 	pop	bc
   25DC DD 75 04      [19]  199 	ld	4 (ix),l
                            200 ;src/StringUtils.c:81: *charPosition=48+(n%10);
   25DF C5            [11]  201 	push	bc
   25E0 3E 0A         [ 7]  202 	ld	a,#0x0A
   25E2 F5            [11]  203 	push	af
   25E3 33            [ 6]  204 	inc	sp
   25E4 DD 7E 04      [19]  205 	ld	a,4 (ix)
   25E7 F5            [11]  206 	push	af
   25E8 33            [ 6]  207 	inc	sp
   25E9 CD 23 58      [17]  208 	call	__moduchar
   25EC F1            [10]  209 	pop	af
   25ED C1            [10]  210 	pop	bc
   25EE 7D            [ 4]  211 	ld	a,l
   25EF C6 30         [ 7]  212 	add	a, #0x30
   25F1 32 79 26      [13]  213 	ld	(#_i_to_s_buffer),a
                            214 ;src/StringUtils.c:84: }
   25F4                     215 00107$:
                            216 ;src/StringUtils.c:86: return i_to_s_buffer;
   25F4 69            [ 4]  217 	ld	l, c
   25F5 60            [ 4]  218 	ld	h, b
   25F6 DD E1         [14]  219 	pop	ix
   25F8 C9            [10]  220 	ret
   25F9                     221 _charArray:
   25F9 FF                  222 	.db #0xFF	; 255
   25FA FF                  223 	.db #0xFF	; 255
   25FB FF                  224 	.db #0xFF	; 255
   25FC FF                  225 	.db #0xFF	; 255
   25FD FF                  226 	.db #0xFF	; 255
   25FE FF                  227 	.db #0xFF	; 255
   25FF FF                  228 	.db #0xFF	; 255
   2600 FF                  229 	.db #0xFF	; 255
   2601 FF                  230 	.db #0xFF	; 255
   2602 FF                  231 	.db #0xFF	; 255
   2603 FF                  232 	.db #0xFF	; 255
   2604 FF                  233 	.db #0xFF	; 255
   2605 FF                  234 	.db #0xFF	; 255
   2606 FF                  235 	.db #0xFF	; 255
   2607 FF                  236 	.db #0xFF	; 255
   2608 FF                  237 	.db #0xFF	; 255
   2609 FF                  238 	.db #0xFF	; 255
   260A FF                  239 	.db #0xFF	; 255
   260B FF                  240 	.db #0xFF	; 255
   260C FF                  241 	.db #0xFF	; 255
   260D FF                  242 	.db #0xFF	; 255
   260E FF                  243 	.db #0xFF	; 255
   260F FF                  244 	.db #0xFF	; 255
   2610 FF                  245 	.db #0xFF	; 255
   2611 FF                  246 	.db #0xFF	; 255
   2612 FF                  247 	.db #0xFF	; 255
   2613 FF                  248 	.db #0xFF	; 255
   2614 FF                  249 	.db #0xFF	; 255
   2615 FF                  250 	.db #0xFF	; 255
   2616 FF                  251 	.db #0xFF	; 255
   2617 FF                  252 	.db #0xFF	; 255
   2618 FF                  253 	.db #0xFF	; 255
   2619 29                  254 	.db #0x29	; 41
   261A 24                  255 	.db #0x24	; 36
   261B FF                  256 	.db #0xFF	; 255
   261C 2D                  257 	.db #0x2D	; 45
   261D 2F                  258 	.db #0x2F	; 47
   261E FF                  259 	.db #0xFF	; 255
   261F 2E                  260 	.db #0x2E	; 46
   2620 FF                  261 	.db #0xFF	; 255
   2621 FF                  262 	.db #0xFF	; 255
   2622 FF                  263 	.db #0xFF	; 255
   2623 31                  264 	.db #0x31	; 49	'1'
   2624 2C                  265 	.db #0x2C	; 44
   2625 FF                  266 	.db #0xFF	; 255
   2626 FF                  267 	.db #0xFF	; 255
   2627 26                  268 	.db #0x26	; 38
   2628 FF                  269 	.db #0xFF	; 255
   2629 1A                  270 	.db #0x1A	; 26
   262A 1B                  271 	.db #0x1B	; 27
   262B 1C                  272 	.db #0x1C	; 28
   262C 1D                  273 	.db #0x1D	; 29
   262D 1E                  274 	.db #0x1E	; 30
   262E 1F                  275 	.db #0x1F	; 31
   262F 20                  276 	.db #0x20	; 32
   2630 21                  277 	.db #0x21	; 33
   2631 22                  278 	.db #0x22	; 34
   2632 23                  279 	.db #0x23	; 35
   2633 27                  280 	.db #0x27	; 39
   2634 FF                  281 	.db #0xFF	; 255
   2635 2A                  282 	.db #0x2A	; 42
   2636 FF                  283 	.db #0xFF	; 255
   2637 2B                  284 	.db #0x2B	; 43
   2638 25                  285 	.db #0x25	; 37
   2639 28                  286 	.db #0x28	; 40
   263A 00                  287 	.db #0x00	; 0
   263B 01                  288 	.db #0x01	; 1
   263C 02                  289 	.db #0x02	; 2
   263D 03                  290 	.db #0x03	; 3
   263E 04                  291 	.db #0x04	; 4
   263F 05                  292 	.db #0x05	; 5
   2640 06                  293 	.db #0x06	; 6
   2641 07                  294 	.db #0x07	; 7
   2642 08                  295 	.db #0x08	; 8
   2643 09                  296 	.db #0x09	; 9
   2644 0A                  297 	.db #0x0A	; 10
   2645 0B                  298 	.db #0x0B	; 11
   2646 0C                  299 	.db #0x0C	; 12
   2647 0D                  300 	.db #0x0D	; 13
   2648 0E                  301 	.db #0x0E	; 14
   2649 0F                  302 	.db #0x0F	; 15
   264A 10                  303 	.db #0x10	; 16
   264B 11                  304 	.db #0x11	; 17
   264C 12                  305 	.db #0x12	; 18
   264D 13                  306 	.db #0x13	; 19
   264E 14                  307 	.db #0x14	; 20
   264F 15                  308 	.db #0x15	; 21
   2650 16                  309 	.db #0x16	; 22
   2651 17                  310 	.db #0x17	; 23
   2652 18                  311 	.db #0x18	; 24
   2653 19                  312 	.db #0x19	; 25
   2654 FF                  313 	.db #0xFF	; 255
   2655 FF                  314 	.db #0xFF	; 255
   2656 FF                  315 	.db #0xFF	; 255
   2657 FF                  316 	.db #0xFF	; 255
   2658 FF                  317 	.db #0xFF	; 255
   2659 FF                  318 	.db #0xFF	; 255
   265A 00                  319 	.db #0x00	; 0
   265B 01                  320 	.db #0x01	; 1
   265C 02                  321 	.db #0x02	; 2
   265D 03                  322 	.db #0x03	; 3
   265E 04                  323 	.db #0x04	; 4
   265F 05                  324 	.db #0x05	; 5
   2660 06                  325 	.db #0x06	; 6
   2661 07                  326 	.db #0x07	; 7
   2662 08                  327 	.db #0x08	; 8
   2663 09                  328 	.db #0x09	; 9
   2664 0A                  329 	.db #0x0A	; 10
   2665 0B                  330 	.db #0x0B	; 11
   2666 0C                  331 	.db #0x0C	; 12
   2667 0D                  332 	.db #0x0D	; 13
   2668 0E                  333 	.db #0x0E	; 14
   2669 0F                  334 	.db #0x0F	; 15
   266A 10                  335 	.db #0x10	; 16
   266B 11                  336 	.db #0x11	; 17
   266C 12                  337 	.db #0x12	; 18
   266D 13                  338 	.db #0x13	; 19
   266E 14                  339 	.db #0x14	; 20
   266F 15                  340 	.db #0x15	; 21
   2670 16                  341 	.db #0x16	; 22
   2671 17                  342 	.db #0x17	; 23
   2672 18                  343 	.db #0x18	; 24
   2673 19                  344 	.db #0x19	; 25
   2674 FF                  345 	.db #0xFF	; 255
   2675 FF                  346 	.db #0xFF	; 255
   2676 FF                  347 	.db #0xFF	; 255
   2677 30                  348 	.db #0x30	; 48	'0'
   2678 FF                  349 	.db #0xFF	; 255
   2679                     350 _i_to_s_buffer:
   2679 00                  351 	.db #0x00	; 0
   267A 00                  352 	.db #0x00	; 0
   267B 00                  353 	.db #0x00	; 0
   267C 00                  354 	.db #0x00	; 0
   267D 00                  355 	.db #0x00	; 0
   267E 00                  356 	.db #0x00	; 0
   267F 00                  357 	.db #0x00	; 0
   2680 00                  358 	.db #0x00	; 0
   2681 00                  359 	.db #0x00	; 0
                            360 ;src/StringUtils.c:90: void print_text(void * const text, u8* position, u8 bg, u8 fg){
                            361 ;	---------------------------------
                            362 ; Function print_text
                            363 ; ---------------------------------
   2682                     364 _print_text::
   2682 DD E5         [15]  365 	push	ix
   2684 DD 21 00 00   [14]  366 	ld	ix,#0
   2688 DD 39         [15]  367 	add	ix,sp
   268A 21 EF FF      [10]  368 	ld	hl,#-17
   268D 39            [11]  369 	add	hl,sp
   268E F9            [ 6]  370 	ld	sp,hl
                            371 ;src/StringUtils.c:91: u8 val, charBitArray, spritePos, fgColor=g_colors[fg], bgColor=g_colors[bg];
   268F DD 7E 09      [19]  372 	ld	a,9 (ix)
   2692 C6 66         [ 7]  373 	add	a, #<(_g_colors)
   2694 DD 77 FC      [19]  374 	ld	-4 (ix),a
   2697 3E 00         [ 7]  375 	ld	a,#0x00
   2699 CE 10         [ 7]  376 	adc	a, #>(_g_colors)
   269B DD 77 FD      [19]  377 	ld	-3 (ix),a
   269E DD 6E FC      [19]  378 	ld	l,-4 (ix)
   26A1 DD 66 FD      [19]  379 	ld	h,-3 (ix)
   26A4 7E            [ 7]  380 	ld	a,(hl)
   26A5 DD 77 F3      [19]  381 	ld	-13 (ix),a
   26A8 3E 66         [ 7]  382 	ld	a,#<(_g_colors)
   26AA DD 86 08      [19]  383 	add	a, 8 (ix)
   26AD DD 77 FC      [19]  384 	ld	-4 (ix),a
   26B0 3E 10         [ 7]  385 	ld	a,#>(_g_colors)
   26B2 CE 00         [ 7]  386 	adc	a, #0x00
   26B4 DD 77 FD      [19]  387 	ld	-3 (ix),a
   26B7 DD 6E FC      [19]  388 	ld	l,-4 (ix)
   26BA DD 66 FD      [19]  389 	ld	h,-3 (ix)
   26BD 7E            [ 7]  390 	ld	a,(hl)
   26BE DD 77 F2      [19]  391 	ld	-14 (ix),a
                            392 ;src/StringUtils.c:97: (position)+=0x2800;
   26C1 DD 7E 06      [19]  393 	ld	a,6 (ix)
   26C4 C6 00         [ 7]  394 	add	a, #0x00
   26C6 DD 77 06      [19]  395 	ld	6 (ix),a
   26C9 DD 7E 07      [19]  396 	ld	a,7 (ix)
   26CC CE 28         [ 7]  397 	adc	a, #0x28
   26CE DD 77 07      [19]  398 	ld	7 (ix),a
                            399 ;src/StringUtils.c:98: if(position<0x2800){
   26D1 DD 4E 06      [19]  400 	ld	c,6 (ix)
   26D4 DD 46 07      [19]  401 	ld	b,7 (ix)
   26D7 78            [ 4]  402 	ld	a,b
   26D8 D6 28         [ 7]  403 	sub	a, #0x28
   26DA 30 20         [12]  404 	jr	NC,00132$
                            405 ;src/StringUtils.c:99: position-=0x4000;
   26DC DD 7E 06      [19]  406 	ld	a,6 (ix)
   26DF C6 00         [ 7]  407 	add	a,#0x00
   26E1 DD 77 06      [19]  408 	ld	6 (ix),a
   26E4 DD 7E 07      [19]  409 	ld	a,7 (ix)
   26E7 CE C0         [ 7]  410 	adc	a,#0xC0
   26E9 DD 77 07      [19]  411 	ld	7 (ix),a
                            412 ;src/StringUtils.c:100: position+=80;
   26EC DD 7E 06      [19]  413 	ld	a,6 (ix)
   26EF C6 50         [ 7]  414 	add	a, #0x50
   26F1 DD 77 06      [19]  415 	ld	6 (ix),a
   26F4 DD 7E 07      [19]  416 	ld	a,7 (ix)
   26F7 CE 00         [ 7]  417 	adc	a, #0x00
   26F9 DD 77 07      [19]  418 	ld	7 (ix),a
                            419 ;src/StringUtils.c:103: while(height){
   26FC                     420 00132$:
   26FC DD 36 F1 06   [19]  421 	ld	-15 (ix),#0x06
   2700 DD 36 FC 96   [19]  422 	ld	-4 (ix),#0x96
   2704                     423 00110$:
   2704 DD 7E F1      [19]  424 	ld	a,-15 (ix)
   2707 B7            [ 4]  425 	or	a, a
   2708 CA 54 28      [10]  426 	jp	Z,00113$
                            427 ;src/StringUtils.c:104: --height;
   270B DD 7E FC      [19]  428 	ld	a,-4 (ix)
   270E C6 E7         [ 7]  429 	add	a,#0xE7
   2710 DD 77 FC      [19]  430 	ld	-4 (ix),a
   2713 DD 35 F1      [23]  431 	dec	-15 (ix)
                            432 ;src/StringUtils.c:105: currentChar=text;
   2716 DD 7E 04      [19]  433 	ld	a,4 (ix)
   2719 DD 77 F8      [19]  434 	ld	-8 (ix),a
   271C DD 7E 05      [19]  435 	ld	a,5 (ix)
   271F DD 77 F9      [19]  436 	ld	-7 (ix),a
                            437 ;src/StringUtils.c:106: currentPos=position;
   2722 DD 7E 06      [19]  438 	ld	a,6 (ix)
   2725 DD 77 FA      [19]  439 	ld	-6 (ix),a
   2728 DD 7E 07      [19]  440 	ld	a,7 (ix)
   272B DD 77 FB      [19]  441 	ld	-5 (ix),a
                            442 ;src/StringUtils.c:108: while(*currentChar){
   272E                     443 00105$:
   272E DD 6E F8      [19]  444 	ld	l,-8 (ix)
   2731 DD 66 F9      [19]  445 	ld	h,-7 (ix)
   2734 7E            [ 7]  446 	ld	a,(hl)
   2735 DD 77 F7      [19]  447 	ld	-9 (ix), a
   2738 B7            [ 4]  448 	or	a, a
   2739 CA 1C 28      [10]  449 	jp	Z,00107$
                            450 ;src/StringUtils.c:110: spritePos = charArray[(*currentChar)];
   273C 3E F9         [ 7]  451 	ld	a,#<(_charArray)
   273E DD 86 F7      [19]  452 	add	a, -9 (ix)
   2741 DD 77 FE      [19]  453 	ld	-2 (ix),a
   2744 3E 25         [ 7]  454 	ld	a,#>(_charArray)
   2746 CE 00         [ 7]  455 	adc	a, #0x00
   2748 DD 77 FF      [19]  456 	ld	-1 (ix),a
   274B DD 6E FE      [19]  457 	ld	l,-2 (ix)
   274E DD 66 FF      [19]  458 	ld	h,-1 (ix)
   2751 7E            [ 7]  459 	ld	a,(hl)
                            460 ;src/StringUtils.c:112: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   2752 DD 77 F4      [19]  461 	ld	-12 (ix), a
   2755 CB 3F         [ 8]  462 	srl	a
   2757 DD 77 FE      [19]  463 	ld	-2 (ix), a
   275A DD 86 FC      [19]  464 	add	a, -4 (ix)
   275D DD 77 FE      [19]  465 	ld	-2 (ix),a
   2760 C6 31         [ 7]  466 	add	a,#<(_typography_4x6_monospaced)
   2762 DD 77 FE      [19]  467 	ld	-2 (ix),a
   2765 3E 39         [ 7]  468 	ld	a,#>(_typography_4x6_monospaced)
   2767 CE 00         [ 7]  469 	adc	a, #0x00
   2769 DD 77 FF      [19]  470 	ld	-1 (ix),a
   276C DD 6E FE      [19]  471 	ld	l,-2 (ix)
   276F DD 66 FF      [19]  472 	ld	h,-1 (ix)
   2772 7E            [ 7]  473 	ld	a,(hl)
   2773 DD 77 FE      [19]  474 	ld	-2 (ix),a
                            475 ;src/StringUtils.c:114: if(spritePos%2) charBitArray<<=4;
   2776 DD CB F4 46   [20]  476 	bit	0, -12 (ix)
   277A 28 0C         [12]  477 	jr	Z,00104$
   277C DD 7E FE      [19]  478 	ld	a,-2 (ix)
   277F 07            [ 4]  479 	rlca
   2780 07            [ 4]  480 	rlca
   2781 07            [ 4]  481 	rlca
   2782 07            [ 4]  482 	rlca
   2783 E6 F0         [ 7]  483 	and	a,#0xF0
   2785 DD 77 FE      [19]  484 	ld	-2 (ix),a
   2788                     485 00104$:
                            486 ;src/StringUtils.c:118: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   2788 DD CB FE 7E   [20]  487 	bit	7, -2 (ix)
   278C 28 05         [12]  488 	jr	Z,00115$
   278E DD 7E F3      [19]  489 	ld	a,-13 (ix)
   2791 18 03         [12]  490 	jr	00116$
   2793                     491 00115$:
   2793 DD 7E F2      [19]  492 	ld	a,-14 (ix)
   2796                     493 00116$:
   2796 E6 AA         [ 7]  494 	and	a, #0xAA
   2798 4F            [ 4]  495 	ld	c,a
                            496 ;src/StringUtils.c:120: charBitArray<<=1;
   2799 DD 7E FE      [19]  497 	ld	a,-2 (ix)
   279C 87            [ 4]  498 	add	a, a
   279D 47            [ 4]  499 	ld	b,a
                            500 ;src/StringUtils.c:122: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   279E CB 78         [ 8]  501 	bit	7, b
   27A0 28 05         [12]  502 	jr	Z,00117$
   27A2 DD 7E F3      [19]  503 	ld	a,-13 (ix)
   27A5 18 03         [12]  504 	jr	00118$
   27A7                     505 00117$:
   27A7 DD 7E F2      [19]  506 	ld	a,-14 (ix)
   27AA                     507 00118$:
   27AA E6 55         [ 7]  508 	and	a, #0x55
   27AC B1            [ 4]  509 	or	a, c
   27AD 4F            [ 4]  510 	ld	c,a
                            511 ;src/StringUtils.c:124: charBitArray<<=1;
   27AE 78            [ 4]  512 	ld	a,b
   27AF 87            [ 4]  513 	add	a, a
   27B0 DD 77 F5      [19]  514 	ld	-11 (ix),a
                            515 ;src/StringUtils.c:126: *currentPos=val;
   27B3 DD 6E FA      [19]  516 	ld	l,-6 (ix)
   27B6 DD 66 FB      [19]  517 	ld	h,-5 (ix)
   27B9 71            [ 7]  518 	ld	(hl),c
                            519 ;src/StringUtils.c:127: ++currentPos;
   27BA DD 7E FA      [19]  520 	ld	a,-6 (ix)
   27BD C6 01         [ 7]  521 	add	a, #0x01
   27BF DD 77 EF      [19]  522 	ld	-17 (ix),a
   27C2 DD 7E FB      [19]  523 	ld	a,-5 (ix)
   27C5 CE 00         [ 7]  524 	adc	a, #0x00
   27C7 DD 77 F0      [19]  525 	ld	-16 (ix),a
                            526 ;src/StringUtils.c:131: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
   27CA DD CB F5 7E   [20]  527 	bit	7, -11 (ix)
   27CE 28 05         [12]  528 	jr	Z,00119$
   27D0 DD 7E F3      [19]  529 	ld	a,-13 (ix)
   27D3 18 03         [12]  530 	jr	00120$
   27D5                     531 00119$:
   27D5 DD 7E F2      [19]  532 	ld	a,-14 (ix)
   27D8                     533 00120$:
   27D8 E6 AA         [ 7]  534 	and	a, #0xAA
   27DA DD 77 F6      [19]  535 	ld	-10 (ix),a
                            536 ;src/StringUtils.c:133: charBitArray<<=1;
   27DD DD 7E F5      [19]  537 	ld	a,-11 (ix)
   27E0 87            [ 4]  538 	add	a, a
                            539 ;src/StringUtils.c:135: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
   27E1 07            [ 4]  540 	rlca
   27E2 30 05         [12]  541 	jr	NC,00121$
   27E4 DD 7E F3      [19]  542 	ld	a,-13 (ix)
   27E7 18 03         [12]  543 	jr	00122$
   27E9                     544 00121$:
   27E9 DD 7E F2      [19]  545 	ld	a,-14 (ix)
   27EC                     546 00122$:
   27EC E6 55         [ 7]  547 	and	a, #0x55
   27EE DD 77 FE      [19]  548 	ld	-2 (ix),a
   27F1 DD 7E F6      [19]  549 	ld	a,-10 (ix)
   27F4 DD B6 FE      [19]  550 	or	a, -2 (ix)
   27F7 DD 77 FE      [19]  551 	ld	-2 (ix),a
                            552 ;src/StringUtils.c:139: *currentPos=val;
   27FA E1            [10]  553 	pop	hl
   27FB E5            [11]  554 	push	hl
   27FC DD 7E FE      [19]  555 	ld	a,-2 (ix)
   27FF 77            [ 7]  556 	ld	(hl),a
                            557 ;src/StringUtils.c:140: ++currentPos;
   2800 DD 7E EF      [19]  558 	ld	a,-17 (ix)
   2803 C6 01         [ 7]  559 	add	a, #0x01
   2805 DD 77 FA      [19]  560 	ld	-6 (ix),a
   2808 DD 7E F0      [19]  561 	ld	a,-16 (ix)
   280B CE 00         [ 7]  562 	adc	a, #0x00
   280D DD 77 FB      [19]  563 	ld	-5 (ix),a
                            564 ;src/StringUtils.c:142: ++currentChar;
   2810 DD 34 F8      [23]  565 	inc	-8 (ix)
   2813 C2 2E 27      [10]  566 	jp	NZ,00105$
   2816 DD 34 F9      [23]  567 	inc	-7 (ix)
   2819 C3 2E 27      [10]  568 	jp	00105$
   281C                     569 00107$:
                            570 ;src/StringUtils.c:144: position-=0x0800;
   281C DD 7E 06      [19]  571 	ld	a,6 (ix)
   281F C6 00         [ 7]  572 	add	a,#0x00
   2821 DD 77 06      [19]  573 	ld	6 (ix),a
   2824 DD 7E 07      [19]  574 	ld	a,7 (ix)
   2827 CE F8         [ 7]  575 	adc	a,#0xF8
                            576 ;src/StringUtils.c:146: if(position<0xC000){
   2829 DD 77 07      [19]  577 	ld	7 (ix), a
   282C D6 C0         [ 7]  578 	sub	a, #0xC0
   282E D2 04 27      [10]  579 	jp	NC,00110$
                            580 ;src/StringUtils.c:147: position+=0x4000;
   2831 DD 7E 06      [19]  581 	ld	a,6 (ix)
   2834 C6 00         [ 7]  582 	add	a, #0x00
   2836 DD 77 06      [19]  583 	ld	6 (ix),a
   2839 DD 7E 07      [19]  584 	ld	a,7 (ix)
   283C CE 40         [ 7]  585 	adc	a, #0x40
   283E DD 77 07      [19]  586 	ld	7 (ix),a
                            587 ;src/StringUtils.c:148: position-=80;
   2841 DD 7E 06      [19]  588 	ld	a,6 (ix)
   2844 C6 B0         [ 7]  589 	add	a,#0xB0
   2846 DD 77 06      [19]  590 	ld	6 (ix),a
   2849 DD 7E 07      [19]  591 	ld	a,7 (ix)
   284C CE FF         [ 7]  592 	adc	a,#0xFF
   284E DD 77 07      [19]  593 	ld	7 (ix),a
   2851 C3 04 27      [10]  594 	jp	00110$
   2854                     595 00113$:
   2854 DD F9         [10]  596 	ld	sp, ix
   2856 DD E1         [14]  597 	pop	ix
   2858 C9            [10]  598 	ret
                            599 ;src/StringUtils.c:154: void print_transparent_text(void* const text, u8* position, u8 fg){
                            600 ;	---------------------------------
                            601 ; Function print_transparent_text
                            602 ; ---------------------------------
   2859                     603 _print_transparent_text::
   2859 DD E5         [15]  604 	push	ix
   285B DD 21 00 00   [14]  605 	ld	ix,#0
   285F DD 39         [15]  606 	add	ix,sp
   2861 21 F8 FF      [10]  607 	ld	hl,#-8
   2864 39            [11]  608 	add	hl,sp
   2865 F9            [ 6]  609 	ld	sp,hl
                            610 ;src/StringUtils.c:155: u8 val, charBitArray, spritePos, color = g_colors[fg];
   2866 01 66 10      [10]  611 	ld	bc,#_g_colors+0
   2869 DD 6E 08      [19]  612 	ld	l,8 (ix)
   286C 26 00         [ 7]  613 	ld	h,#0x00
   286E 09            [11]  614 	add	hl,bc
   286F 4E            [ 7]  615 	ld	c,(hl)
                            616 ;src/StringUtils.c:161: (position)+=0x2800;
   2870 DD 7E 06      [19]  617 	ld	a,6 (ix)
   2873 C6 00         [ 7]  618 	add	a, #0x00
   2875 DD 77 06      [19]  619 	ld	6 (ix),a
   2878 DD 7E 07      [19]  620 	ld	a,7 (ix)
   287B CE 28         [ 7]  621 	adc	a, #0x28
   287D DD 77 07      [19]  622 	ld	7 (ix),a
                            623 ;src/StringUtils.c:162: if(position<0x2800){
   2880 DD 46 06      [19]  624 	ld	b,6 (ix)
   2883 DD 5E 07      [19]  625 	ld	e,7 (ix)
   2886 7B            [ 4]  626 	ld	a,e
   2887 D6 28         [ 7]  627 	sub	a, #0x28
   2889 30 20         [12]  628 	jr	NC,00132$
                            629 ;src/StringUtils.c:163: position-=0x4000;
   288B DD 7E 06      [19]  630 	ld	a,6 (ix)
   288E C6 00         [ 7]  631 	add	a,#0x00
   2890 DD 77 06      [19]  632 	ld	6 (ix),a
   2893 DD 7E 07      [19]  633 	ld	a,7 (ix)
   2896 CE C0         [ 7]  634 	adc	a,#0xC0
   2898 DD 77 07      [19]  635 	ld	7 (ix),a
                            636 ;src/StringUtils.c:164: position+=80;
   289B DD 7E 06      [19]  637 	ld	a,6 (ix)
   289E C6 50         [ 7]  638 	add	a, #0x50
   28A0 DD 77 06      [19]  639 	ld	6 (ix),a
   28A3 DD 7E 07      [19]  640 	ld	a,7 (ix)
   28A6 CE 00         [ 7]  641 	adc	a, #0x00
   28A8 DD 77 07      [19]  642 	ld	7 (ix),a
                            643 ;src/StringUtils.c:167: while(height){
   28AB                     644 00132$:
   28AB 79            [ 4]  645 	ld	a,c
   28AC E6 AA         [ 7]  646 	and	a, #0xAA
   28AE DD 77 FA      [19]  647 	ld	-6 (ix),a
   28B1 79            [ 4]  648 	ld	a,c
   28B2 E6 55         [ 7]  649 	and	a, #0x55
   28B4 DD 77 FB      [19]  650 	ld	-5 (ix),a
   28B7 DD 36 F8 06   [19]  651 	ld	-8 (ix),#0x06
   28BB DD 36 F9 96   [19]  652 	ld	-7 (ix),#0x96
   28BF                     653 00118$:
   28BF DD 7E F8      [19]  654 	ld	a,-8 (ix)
   28C2 B7            [ 4]  655 	or	a, a
   28C3 CA AB 29      [10]  656 	jp	Z,00121$
                            657 ;src/StringUtils.c:168: currentChar=text;
   28C6 DD 7E 04      [19]  658 	ld	a,4 (ix)
   28C9 DD 77 FE      [19]  659 	ld	-2 (ix),a
   28CC DD 7E 05      [19]  660 	ld	a,5 (ix)
   28CF DD 77 FF      [19]  661 	ld	-1 (ix),a
                            662 ;src/StringUtils.c:169: currentPos=position;
   28D2 DD 7E 06      [19]  663 	ld	a,6 (ix)
   28D5 DD 77 FC      [19]  664 	ld	-4 (ix),a
   28D8 DD 7E 07      [19]  665 	ld	a,7 (ix)
   28DB DD 77 FD      [19]  666 	ld	-3 (ix),a
                            667 ;src/StringUtils.c:170: --height;
   28DE DD 7E F9      [19]  668 	ld	a,-7 (ix)
   28E1 C6 E7         [ 7]  669 	add	a,#0xE7
   28E3 DD 77 F9      [19]  670 	ld	-7 (ix),a
   28E6 DD 35 F8      [23]  671 	dec	-8 (ix)
                            672 ;src/StringUtils.c:171: while(*currentChar){
   28E9                     673 00113$:
   28E9 DD 6E FE      [19]  674 	ld	l,-2 (ix)
   28EC DD 66 FF      [19]  675 	ld	h,-1 (ix)
   28EF 4E            [ 7]  676 	ld	c,(hl)
   28F0 79            [ 4]  677 	ld	a,c
   28F1 B7            [ 4]  678 	or	a, a
   28F2 CA 73 29      [10]  679 	jp	Z,00115$
                            680 ;src/StringUtils.c:173: spritePos = charArray[(*currentChar)];
   28F5 21 F9 25      [10]  681 	ld	hl,#_charArray
   28F8 06 00         [ 7]  682 	ld	b,#0x00
   28FA 09            [11]  683 	add	hl, bc
   28FB 46            [ 7]  684 	ld	b,(hl)
                            685 ;src/StringUtils.c:175: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
   28FC 78            [ 4]  686 	ld	a, b
   28FD CB 3F         [ 8]  687 	srl	a
   28FF DD 86 F9      [19]  688 	add	a, -7 (ix)
   2902 5F            [ 4]  689 	ld	e,a
   2903 21 31 39      [10]  690 	ld	hl,#_typography_4x6_monospaced
   2906 16 00         [ 7]  691 	ld	d,#0x00
   2908 19            [11]  692 	add	hl, de
   2909 4E            [ 7]  693 	ld	c,(hl)
                            694 ;src/StringUtils.c:177: if(spritePos%2) charBitArray<<=4;
   290A CB 40         [ 8]  695 	bit	0, b
   290C 28 08         [12]  696 	jr	Z,00104$
   290E 79            [ 4]  697 	ld	a,c
   290F 07            [ 4]  698 	rlca
   2910 07            [ 4]  699 	rlca
   2911 07            [ 4]  700 	rlca
   2912 07            [ 4]  701 	rlca
   2913 E6 F0         [ 7]  702 	and	a,#0xF0
   2915 4F            [ 4]  703 	ld	c,a
   2916                     704 00104$:
                            705 ;src/StringUtils.c:179: val=*currentPos;
   2916 DD 6E FC      [19]  706 	ld	l,-4 (ix)
   2919 DD 66 FD      [19]  707 	ld	h,-3 (ix)
   291C 5E            [ 7]  708 	ld	e,(hl)
                            709 ;src/StringUtils.c:181: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
   291D CB 79         [ 8]  710 	bit	7, c
   291F 28 07         [12]  711 	jr	Z,00106$
   2921 7B            [ 4]  712 	ld	a,e
   2922 E6 55         [ 7]  713 	and	a, #0x55
   2924 DD B6 FA      [19]  714 	or	a, -6 (ix)
   2927 5F            [ 4]  715 	ld	e,a
   2928                     716 00106$:
                            717 ;src/StringUtils.c:183: charBitArray<<=1;
   2928 CB 21         [ 8]  718 	sla	c
                            719 ;src/StringUtils.c:185: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
   292A CB 79         [ 8]  720 	bit	7, c
   292C 28 07         [12]  721 	jr	Z,00108$
   292E 7B            [ 4]  722 	ld	a,e
   292F E6 AA         [ 7]  723 	and	a, #0xAA
   2931 DD B6 FB      [19]  724 	or	a, -5 (ix)
   2934 5F            [ 4]  725 	ld	e,a
   2935                     726 00108$:
                            727 ;src/StringUtils.c:187: charBitArray<<=1;
   2935 CB 21         [ 8]  728 	sla	c
                            729 ;src/StringUtils.c:189: *currentPos=val;
   2937 DD 6E FC      [19]  730 	ld	l,-4 (ix)
   293A DD 66 FD      [19]  731 	ld	h,-3 (ix)
   293D 73            [ 7]  732 	ld	(hl),e
                            733 ;src/StringUtils.c:190: ++currentPos;
   293E DD 5E FC      [19]  734 	ld	e,-4 (ix)
   2941 DD 56 FD      [19]  735 	ld	d,-3 (ix)
   2944 13            [ 6]  736 	inc	de
                            737 ;src/StringUtils.c:192: val=*currentPos;
   2945 1A            [ 7]  738 	ld	a,(de)
   2946 47            [ 4]  739 	ld	b,a
                            740 ;src/StringUtils.c:194: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
   2947 CB 79         [ 8]  741 	bit	7, c
   2949 28 07         [12]  742 	jr	Z,00110$
   294B 78            [ 4]  743 	ld	a,b
   294C E6 55         [ 7]  744 	and	a, #0x55
   294E DD B6 FA      [19]  745 	or	a, -6 (ix)
   2951 47            [ 4]  746 	ld	b,a
   2952                     747 00110$:
                            748 ;src/StringUtils.c:196: charBitArray<<=1;
   2952 79            [ 4]  749 	ld	a,c
   2953 87            [ 4]  750 	add	a, a
                            751 ;src/StringUtils.c:198: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
   2954 07            [ 4]  752 	rlca
   2955 30 07         [12]  753 	jr	NC,00112$
   2957 78            [ 4]  754 	ld	a,b
   2958 E6 AA         [ 7]  755 	and	a, #0xAA
   295A DD B6 FB      [19]  756 	or	a, -5 (ix)
   295D 47            [ 4]  757 	ld	b,a
   295E                     758 00112$:
                            759 ;src/StringUtils.c:202: *currentPos=val;
   295E 78            [ 4]  760 	ld	a,b
   295F 12            [ 7]  761 	ld	(de),a
                            762 ;src/StringUtils.c:203: ++currentPos;
   2960 13            [ 6]  763 	inc	de
   2961 DD 73 FC      [19]  764 	ld	-4 (ix),e
   2964 DD 72 FD      [19]  765 	ld	-3 (ix),d
                            766 ;src/StringUtils.c:205: ++currentChar;
   2967 DD 34 FE      [23]  767 	inc	-2 (ix)
   296A C2 E9 28      [10]  768 	jp	NZ,00113$
   296D DD 34 FF      [23]  769 	inc	-1 (ix)
   2970 C3 E9 28      [10]  770 	jp	00113$
   2973                     771 00115$:
                            772 ;src/StringUtils.c:207: position-=0x0800;
   2973 DD 7E 06      [19]  773 	ld	a,6 (ix)
   2976 C6 00         [ 7]  774 	add	a,#0x00
   2978 DD 77 06      [19]  775 	ld	6 (ix),a
   297B DD 7E 07      [19]  776 	ld	a,7 (ix)
   297E CE F8         [ 7]  777 	adc	a,#0xF8
                            778 ;src/StringUtils.c:209: if(position<0xC000){
   2980 DD 77 07      [19]  779 	ld	7 (ix), a
   2983 D6 C0         [ 7]  780 	sub	a, #0xC0
   2985 D2 BF 28      [10]  781 	jp	NC,00118$
                            782 ;src/StringUtils.c:210: position+=0x4000;
   2988 DD 7E 06      [19]  783 	ld	a,6 (ix)
   298B C6 00         [ 7]  784 	add	a, #0x00
   298D DD 77 06      [19]  785 	ld	6 (ix),a
   2990 DD 7E 07      [19]  786 	ld	a,7 (ix)
   2993 CE 40         [ 7]  787 	adc	a, #0x40
   2995 DD 77 07      [19]  788 	ld	7 (ix),a
                            789 ;src/StringUtils.c:211: position-=80;
   2998 DD 7E 06      [19]  790 	ld	a,6 (ix)
   299B C6 B0         [ 7]  791 	add	a,#0xB0
   299D DD 77 06      [19]  792 	ld	6 (ix),a
   29A0 DD 7E 07      [19]  793 	ld	a,7 (ix)
   29A3 CE FF         [ 7]  794 	adc	a,#0xFF
   29A5 DD 77 07      [19]  795 	ld	7 (ix),a
   29A8 C3 BF 28      [10]  796 	jp	00118$
   29AB                     797 00121$:
   29AB DD F9         [10]  798 	ld	sp, ix
   29AD DD E1         [14]  799 	pop	ix
   29AF C9            [10]  800 	ret
                            801 	.area _CODE
                            802 	.area _INITIALIZER
                            803 	.area _CABS (ABS)
