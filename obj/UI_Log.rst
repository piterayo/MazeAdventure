                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module UI_Log
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _print_text
                             12 	.globl _cpct_drawSolidBox
                             13 	.globl _cpct_memcpy
                             14 	.globl _ui_log_textStrings
                             15 	.globl _ui_log_currentString
                             16 	.globl _ui_log_init
                             17 	.globl _ui_log_add_log
                             18 	.globl _ui_log_render
                             19 ;--------------------------------------------------------
                             20 ; special function registers
                             21 ;--------------------------------------------------------
                             22 ;--------------------------------------------------------
                             23 ; ram data
                             24 ;--------------------------------------------------------
                             25 	.area _DATA
   7E8B                      26 _ui_log_currentString::
   7E8B                      27 	.ds 1
   7E8C                      28 _ui_log_textStrings::
   7E8C                      29 	.ds 80
                             30 ;--------------------------------------------------------
                             31 ; ram data
                             32 ;--------------------------------------------------------
                             33 	.area _INITIALIZED
                             34 ;--------------------------------------------------------
                             35 ; absolute external ram data
                             36 ;--------------------------------------------------------
                             37 	.area _DABS (ABS)
                             38 ;--------------------------------------------------------
                             39 ; global & static initialisations
                             40 ;--------------------------------------------------------
                             41 	.area _HOME
                             42 	.area _GSINIT
                             43 	.area _GSFINAL
                             44 	.area _GSINIT
                             45 ;--------------------------------------------------------
                             46 ; Home
                             47 ;--------------------------------------------------------
                             48 	.area _HOME
                             49 	.area _HOME
                             50 ;--------------------------------------------------------
                             51 ; code
                             52 ;--------------------------------------------------------
                             53 	.area _CODE
                             54 ;src/UI_Log.c:18: void ui_log_init(){
                             55 ;	---------------------------------
                             56 ; Function ui_log_init
                             57 ; ---------------------------------
   4719                      58 _ui_log_init::
                             59 ;src/UI_Log.c:20: ui_log_currentString=0;
   4719 21 8B 7E      [10]   60 	ld	hl,#_ui_log_currentString + 0
   471C 36 00         [10]   61 	ld	(hl), #0x00
                             62 ;src/UI_Log.c:21: print_text("LOG", UI_LOG_TITLE_POSITION, UI_LOG_BG_COLOR, 3);
   471E 21 01 03      [10]   63 	ld	hl,#0x0301
   4721 E5            [11]   64 	push	hl
   4722 21 E6 C0      [10]   65 	ld	hl,#0xC0E6
   4725 E5            [11]   66 	push	hl
   4726 21 57 47      [10]   67 	ld	hl,#___str_0
   4729 E5            [11]   68 	push	hl
   472A CD C5 3D      [17]   69 	call	_print_text
   472D 21 06 00      [10]   70 	ld	hl,#6
   4730 39            [11]   71 	add	hl,sp
   4731 F9            [ 6]   72 	ld	sp,hl
                             73 ;src/UI_Log.c:22: while(n){
   4732 0E 08         [ 7]   74 	ld	c,#0x08
   4734 11 50 00      [10]   75 	ld	de,#0x0050
   4737                      76 00101$:
   4737 79            [ 4]   77 	ld	a,c
   4738 B7            [ 4]   78 	or	a, a
   4739 C8            [11]   79 	ret	Z
                             80 ;src/UI_Log.c:23: --n;
   473A 7B            [ 4]   81 	ld	a,e
   473B C6 F6         [ 7]   82 	add	a,#0xF6
   473D 5F            [ 4]   83 	ld	e,a
   473E 7A            [ 4]   84 	ld	a,d
   473F CE FF         [ 7]   85 	adc	a,#0xFF
   4741 57            [ 4]   86 	ld	d,a
   4742 0D            [ 4]   87 	dec	c
                             88 ;src/UI_Log.c:24: ui_log_textStrings[n][0]=0;
   4743 21 8C 7E      [10]   89 	ld	hl,#_ui_log_textStrings
   4746 19            [11]   90 	add	hl,de
   4747 36 00         [10]   91 	ld	(hl),#0x00
                             92 ;src/UI_Log.c:25: ui_log_textStrings[n][8]=0;
   4749 21 8C 7E      [10]   93 	ld	hl,#_ui_log_textStrings
   474C 19            [11]   94 	add	hl,de
   474D D5            [11]   95 	push	de
   474E 11 08 00      [10]   96 	ld	de,#0x0008
   4751 19            [11]   97 	add	hl, de
   4752 D1            [10]   98 	pop	de
   4753 36 00         [10]   99 	ld	(hl),#0x00
   4755 18 E0         [12]  100 	jr	00101$
   4757                     101 ___str_0:
   4757 4C 4F 47            102 	.ascii "LOG"
   475A 00                  103 	.db 0x00
                            104 ;src/UI_Log.c:29: void ui_log_add_log(const char* const newLog, u8 color){
                            105 ;	---------------------------------
                            106 ; Function ui_log_add_log
                            107 ; ---------------------------------
   475B                     108 _ui_log_add_log::
   475B DD E5         [15]  109 	push	ix
   475D DD 21 00 00   [14]  110 	ld	ix,#0
   4761 DD 39         [15]  111 	add	ix,sp
                            112 ;src/UI_Log.c:31: ui_log_currentString = (ui_log_currentString+1) & 7;
   4763 3A 8B 7E      [13]  113 	ld	a,(#_ui_log_currentString + 0)
   4766 3C            [ 4]  114 	inc	a
   4767 E6 07         [ 7]  115 	and	a, #0x07
   4769 32 8B 7E      [13]  116 	ld	(#_ui_log_currentString + 0),a
                            117 ;src/UI_Log.c:33: cpct_memcpy(ui_log_textStrings[ui_log_currentString], newLog, 8);
   476C DD 4E 04      [19]  118 	ld	c,4 (ix)
   476F DD 46 05      [19]  119 	ld	b,5 (ix)
   4772 ED 5B 8B 7E   [20]  120 	ld	de,(_ui_log_currentString)
   4776 16 00         [ 7]  121 	ld	d,#0x00
   4778 6B            [ 4]  122 	ld	l, e
   4779 62            [ 4]  123 	ld	h, d
   477A 29            [11]  124 	add	hl, hl
   477B 29            [11]  125 	add	hl, hl
   477C 19            [11]  126 	add	hl, de
   477D 29            [11]  127 	add	hl, hl
   477E 11 8C 7E      [10]  128 	ld	de,#_ui_log_textStrings
   4781 19            [11]  129 	add	hl,de
   4782 11 08 00      [10]  130 	ld	de,#0x0008
   4785 D5            [11]  131 	push	de
   4786 C5            [11]  132 	push	bc
   4787 E5            [11]  133 	push	hl
   4788 CD 4A 7C      [17]  134 	call	_cpct_memcpy
                            135 ;src/UI_Log.c:34: ui_log_textStrings[ui_log_currentString][9] = color;
   478B ED 4B 8B 7E   [20]  136 	ld	bc,(_ui_log_currentString)
   478F 06 00         [ 7]  137 	ld	b,#0x00
   4791 69            [ 4]  138 	ld	l, c
   4792 60            [ 4]  139 	ld	h, b
   4793 29            [11]  140 	add	hl, hl
   4794 29            [11]  141 	add	hl, hl
   4795 09            [11]  142 	add	hl, bc
   4796 29            [11]  143 	add	hl, hl
   4797 11 8C 7E      [10]  144 	ld	de,#_ui_log_textStrings
   479A 19            [11]  145 	add	hl,de
   479B 01 09 00      [10]  146 	ld	bc,#0x0009
   479E 09            [11]  147 	add	hl,bc
   479F DD 7E 06      [19]  148 	ld	a,6 (ix)
   47A2 77            [ 7]  149 	ld	(hl),a
   47A3 DD E1         [14]  150 	pop	ix
   47A5 C9            [10]  151 	ret
                            152 ;src/UI_Log.c:38: void ui_log_render(){
                            153 ;	---------------------------------
                            154 ; Function ui_log_render
                            155 ; ---------------------------------
   47A6                     156 _ui_log_render::
   47A6 DD E5         [15]  157 	push	ix
   47A8 DD 21 00 00   [14]  158 	ld	ix,#0
   47AC DD 39         [15]  159 	add	ix,sp
   47AE 3B            [ 6]  160 	dec	sp
                            161 ;src/UI_Log.c:41: cpct_drawSolidBox(UI_LOG_POSITION, g_colors[1], 16, 64);
   47AF 21 67 1A      [10]  162 	ld	hl,#_g_colors+1
   47B2 46            [ 7]  163 	ld	b,(hl)
   47B3 21 10 40      [10]  164 	ld	hl,#0x4010
   47B6 E5            [11]  165 	push	hl
   47B7 C5            [11]  166 	push	bc
   47B8 33            [ 6]  167 	inc	sp
   47B9 21 80 C1      [10]  168 	ld	hl,#0xC180
   47BC E5            [11]  169 	push	hl
   47BD CD 70 7C      [17]  170 	call	_cpct_drawSolidBox
   47C0 F1            [10]  171 	pop	af
   47C1 F1            [10]  172 	pop	af
   47C2 33            [ 6]  173 	inc	sp
                            174 ;src/UI_Log.c:42: while(i){
   47C3 01 80 C1      [10]  175 	ld	bc,#0xC180
   47C6 DD 36 FF 08   [19]  176 	ld	-1 (ix),#0x08
   47CA                     177 00101$:
   47CA DD 7E FF      [19]  178 	ld	a,-1 (ix)
   47CD B7            [ 4]  179 	or	a, a
   47CE 28 45         [12]  180 	jr	Z,00104$
                            181 ;src/UI_Log.c:43: ui_log_currentString=((ui_log_currentString+1)&7);
   47D0 3A 8B 7E      [13]  182 	ld	a,(#_ui_log_currentString + 0)
   47D3 3C            [ 4]  183 	inc	a
   47D4 E6 07         [ 7]  184 	and	a, #0x07
   47D6 32 8B 7E      [13]  185 	ld	(#_ui_log_currentString + 0),a
                            186 ;src/UI_Log.c:44: print_text(ui_log_textStrings[ui_log_currentString], pos, UI_LOG_BG_COLOR, ui_log_textStrings[ui_log_currentString][9]);
   47D9 ED 5B 8B 7E   [20]  187 	ld	de,(_ui_log_currentString)
   47DD 16 00         [ 7]  188 	ld	d,#0x00
   47DF 6B            [ 4]  189 	ld	l, e
   47E0 62            [ 4]  190 	ld	h, d
   47E1 29            [11]  191 	add	hl, hl
   47E2 29            [11]  192 	add	hl, hl
   47E3 19            [11]  193 	add	hl, de
   47E4 29            [11]  194 	add	hl, hl
   47E5 5D            [ 4]  195 	ld	e,l
   47E6 54            [ 4]  196 	ld	d,h
   47E7 FD 21 8C 7E   [14]  197 	ld	iy,#_ui_log_textStrings
   47EB FD 19         [15]  198 	add	iy, de
   47ED FD 66 09      [19]  199 	ld	h,9 (iy)
   47F0 3E 8C         [ 7]  200 	ld	a,#<(_ui_log_textStrings)
   47F2 83            [ 4]  201 	add	a, e
   47F3 5F            [ 4]  202 	ld	e,a
   47F4 3E 7E         [ 7]  203 	ld	a,#>(_ui_log_textStrings)
   47F6 8A            [ 4]  204 	adc	a, d
   47F7 57            [ 4]  205 	ld	d,a
   47F8 C5            [11]  206 	push	bc
   47F9 E5            [11]  207 	push	hl
   47FA 33            [ 6]  208 	inc	sp
   47FB 3E 01         [ 7]  209 	ld	a,#0x01
   47FD F5            [11]  210 	push	af
   47FE 33            [ 6]  211 	inc	sp
   47FF C5            [11]  212 	push	bc
   4800 D5            [11]  213 	push	de
   4801 CD C5 3D      [17]  214 	call	_print_text
   4804 21 06 00      [10]  215 	ld	hl,#6
   4807 39            [11]  216 	add	hl,sp
   4808 F9            [ 6]  217 	ld	sp,hl
   4809 C1            [10]  218 	pop	bc
                            219 ;src/UI_Log.c:45: pos+=80;
   480A 21 50 00      [10]  220 	ld	hl,#0x0050
   480D 09            [11]  221 	add	hl,bc
   480E 4D            [ 4]  222 	ld	c,l
   480F 44            [ 4]  223 	ld	b,h
                            224 ;src/UI_Log.c:46: --i;
   4810 DD 35 FF      [23]  225 	dec	-1 (ix)
   4813 18 B5         [12]  226 	jr	00101$
   4815                     227 00104$:
   4815 33            [ 6]  228 	inc	sp
   4816 DD E1         [14]  229 	pop	ix
   4818 C9            [10]  230 	ret
                            231 	.area _CODE
                            232 	.area _INITIALIZER
                            233 	.area _CABS (ABS)
