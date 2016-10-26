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
   7DD3                      26 _ui_log_currentString::
   7DD3                      27 	.ds 1
   7DD4                      28 _ui_log_textStrings::
   7DD4                      29 	.ds 80
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
   473F                      58 _ui_log_init::
                             59 ;src/UI_Log.c:20: ui_log_currentString=0;
   473F 21 D3 7D      [10]   60 	ld	hl,#_ui_log_currentString + 0
   4742 36 00         [10]   61 	ld	(hl), #0x00
                             62 ;src/UI_Log.c:21: print_text("LOG", UI_LOG_TITLE_POSITION, UI_LOG_BG_COLOR, 3);
   4744 21 01 03      [10]   63 	ld	hl,#0x0301
   4747 E5            [11]   64 	push	hl
   4748 21 E6 C0      [10]   65 	ld	hl,#0xC0E6
   474B E5            [11]   66 	push	hl
   474C 21 7D 47      [10]   67 	ld	hl,#___str_0
   474F E5            [11]   68 	push	hl
   4750 CD EB 3D      [17]   69 	call	_print_text
   4753 21 06 00      [10]   70 	ld	hl,#6
   4756 39            [11]   71 	add	hl,sp
   4757 F9            [ 6]   72 	ld	sp,hl
                             73 ;src/UI_Log.c:22: while(n){
   4758 0E 08         [ 7]   74 	ld	c,#0x08
   475A 11 50 00      [10]   75 	ld	de,#0x0050
   475D                      76 00101$:
   475D 79            [ 4]   77 	ld	a,c
   475E B7            [ 4]   78 	or	a, a
   475F C8            [11]   79 	ret	Z
                             80 ;src/UI_Log.c:23: --n;
   4760 7B            [ 4]   81 	ld	a,e
   4761 C6 F6         [ 7]   82 	add	a,#0xF6
   4763 5F            [ 4]   83 	ld	e,a
   4764 7A            [ 4]   84 	ld	a,d
   4765 CE FF         [ 7]   85 	adc	a,#0xFF
   4767 57            [ 4]   86 	ld	d,a
   4768 0D            [ 4]   87 	dec	c
                             88 ;src/UI_Log.c:24: ui_log_textStrings[n][0]=0;
   4769 21 D4 7D      [10]   89 	ld	hl,#_ui_log_textStrings
   476C 19            [11]   90 	add	hl,de
   476D 36 00         [10]   91 	ld	(hl),#0x00
                             92 ;src/UI_Log.c:25: ui_log_textStrings[n][8]=0;
   476F 21 D4 7D      [10]   93 	ld	hl,#_ui_log_textStrings
   4772 19            [11]   94 	add	hl,de
   4773 D5            [11]   95 	push	de
   4774 11 08 00      [10]   96 	ld	de,#0x0008
   4777 19            [11]   97 	add	hl, de
   4778 D1            [10]   98 	pop	de
   4779 36 00         [10]   99 	ld	(hl),#0x00
   477B 18 E0         [12]  100 	jr	00101$
   477D                     101 ___str_0:
   477D 4C 4F 47            102 	.ascii "LOG"
   4780 00                  103 	.db 0x00
                            104 ;src/UI_Log.c:29: void ui_log_add_log(const char* const newLog, u8 color){
                            105 ;	---------------------------------
                            106 ; Function ui_log_add_log
                            107 ; ---------------------------------
   4781                     108 _ui_log_add_log::
   4781 DD E5         [15]  109 	push	ix
   4783 DD 21 00 00   [14]  110 	ld	ix,#0
   4787 DD 39         [15]  111 	add	ix,sp
                            112 ;src/UI_Log.c:31: ui_log_currentString = (ui_log_currentString+1) & 7;
   4789 3A D3 7D      [13]  113 	ld	a,(#_ui_log_currentString + 0)
   478C 3C            [ 4]  114 	inc	a
   478D E6 07         [ 7]  115 	and	a, #0x07
   478F 32 D3 7D      [13]  116 	ld	(#_ui_log_currentString + 0),a
                            117 ;src/UI_Log.c:33: cpct_memcpy(ui_log_textStrings[ui_log_currentString], newLog, 8);
   4792 DD 4E 04      [19]  118 	ld	c,4 (ix)
   4795 DD 46 05      [19]  119 	ld	b,5 (ix)
   4798 ED 5B D3 7D   [20]  120 	ld	de,(_ui_log_currentString)
   479C 16 00         [ 7]  121 	ld	d,#0x00
   479E 6B            [ 4]  122 	ld	l, e
   479F 62            [ 4]  123 	ld	h, d
   47A0 29            [11]  124 	add	hl, hl
   47A1 29            [11]  125 	add	hl, hl
   47A2 19            [11]  126 	add	hl, de
   47A3 29            [11]  127 	add	hl, hl
   47A4 11 D4 7D      [10]  128 	ld	de,#_ui_log_textStrings
   47A7 19            [11]  129 	add	hl,de
   47A8 11 08 00      [10]  130 	ld	de,#0x0008
   47AB D5            [11]  131 	push	de
   47AC C5            [11]  132 	push	bc
   47AD E5            [11]  133 	push	hl
   47AE CD 92 7B      [17]  134 	call	_cpct_memcpy
                            135 ;src/UI_Log.c:34: ui_log_textStrings[ui_log_currentString][9] = color;
   47B1 ED 4B D3 7D   [20]  136 	ld	bc,(_ui_log_currentString)
   47B5 06 00         [ 7]  137 	ld	b,#0x00
   47B7 69            [ 4]  138 	ld	l, c
   47B8 60            [ 4]  139 	ld	h, b
   47B9 29            [11]  140 	add	hl, hl
   47BA 29            [11]  141 	add	hl, hl
   47BB 09            [11]  142 	add	hl, bc
   47BC 29            [11]  143 	add	hl, hl
   47BD 11 D4 7D      [10]  144 	ld	de,#_ui_log_textStrings
   47C0 19            [11]  145 	add	hl,de
   47C1 01 09 00      [10]  146 	ld	bc,#0x0009
   47C4 09            [11]  147 	add	hl,bc
   47C5 DD 7E 06      [19]  148 	ld	a,6 (ix)
   47C8 77            [ 7]  149 	ld	(hl),a
   47C9 DD E1         [14]  150 	pop	ix
   47CB C9            [10]  151 	ret
                            152 ;src/UI_Log.c:38: void ui_log_render(){
                            153 ;	---------------------------------
                            154 ; Function ui_log_render
                            155 ; ---------------------------------
   47CC                     156 _ui_log_render::
   47CC DD E5         [15]  157 	push	ix
   47CE DD 21 00 00   [14]  158 	ld	ix,#0
   47D2 DD 39         [15]  159 	add	ix,sp
   47D4 3B            [ 6]  160 	dec	sp
                            161 ;src/UI_Log.c:41: cpct_drawSolidBox(UI_LOG_POSITION, g_colors[1], 16, 64);
   47D5 21 B0 1A      [10]  162 	ld	hl,#_g_colors+1
   47D8 46            [ 7]  163 	ld	b,(hl)
   47D9 21 10 40      [10]  164 	ld	hl,#0x4010
   47DC E5            [11]  165 	push	hl
   47DD C5            [11]  166 	push	bc
   47DE 33            [ 6]  167 	inc	sp
   47DF 21 80 C1      [10]  168 	ld	hl,#0xC180
   47E2 E5            [11]  169 	push	hl
   47E3 CD B8 7B      [17]  170 	call	_cpct_drawSolidBox
   47E6 F1            [10]  171 	pop	af
   47E7 F1            [10]  172 	pop	af
   47E8 33            [ 6]  173 	inc	sp
                            174 ;src/UI_Log.c:42: while(i){
   47E9 01 80 C1      [10]  175 	ld	bc,#0xC180
   47EC DD 36 FF 08   [19]  176 	ld	-1 (ix),#0x08
   47F0                     177 00101$:
   47F0 DD 7E FF      [19]  178 	ld	a,-1 (ix)
   47F3 B7            [ 4]  179 	or	a, a
   47F4 28 45         [12]  180 	jr	Z,00104$
                            181 ;src/UI_Log.c:43: ui_log_currentString=((ui_log_currentString+1)&7);
   47F6 3A D3 7D      [13]  182 	ld	a,(#_ui_log_currentString + 0)
   47F9 3C            [ 4]  183 	inc	a
   47FA E6 07         [ 7]  184 	and	a, #0x07
   47FC 32 D3 7D      [13]  185 	ld	(#_ui_log_currentString + 0),a
                            186 ;src/UI_Log.c:44: print_text(ui_log_textStrings[ui_log_currentString], pos, UI_LOG_BG_COLOR, ui_log_textStrings[ui_log_currentString][9]);
   47FF ED 5B D3 7D   [20]  187 	ld	de,(_ui_log_currentString)
   4803 16 00         [ 7]  188 	ld	d,#0x00
   4805 6B            [ 4]  189 	ld	l, e
   4806 62            [ 4]  190 	ld	h, d
   4807 29            [11]  191 	add	hl, hl
   4808 29            [11]  192 	add	hl, hl
   4809 19            [11]  193 	add	hl, de
   480A 29            [11]  194 	add	hl, hl
   480B 5D            [ 4]  195 	ld	e,l
   480C 54            [ 4]  196 	ld	d,h
   480D FD 21 D4 7D   [14]  197 	ld	iy,#_ui_log_textStrings
   4811 FD 19         [15]  198 	add	iy, de
   4813 FD 66 09      [19]  199 	ld	h,9 (iy)
   4816 3E D4         [ 7]  200 	ld	a,#<(_ui_log_textStrings)
   4818 83            [ 4]  201 	add	a, e
   4819 5F            [ 4]  202 	ld	e,a
   481A 3E 7D         [ 7]  203 	ld	a,#>(_ui_log_textStrings)
   481C 8A            [ 4]  204 	adc	a, d
   481D 57            [ 4]  205 	ld	d,a
   481E C5            [11]  206 	push	bc
   481F E5            [11]  207 	push	hl
   4820 33            [ 6]  208 	inc	sp
   4821 3E 01         [ 7]  209 	ld	a,#0x01
   4823 F5            [11]  210 	push	af
   4824 33            [ 6]  211 	inc	sp
   4825 C5            [11]  212 	push	bc
   4826 D5            [11]  213 	push	de
   4827 CD EB 3D      [17]  214 	call	_print_text
   482A 21 06 00      [10]  215 	ld	hl,#6
   482D 39            [11]  216 	add	hl,sp
   482E F9            [ 6]  217 	ld	sp,hl
   482F C1            [10]  218 	pop	bc
                            219 ;src/UI_Log.c:45: pos+=80;
   4830 21 50 00      [10]  220 	ld	hl,#0x0050
   4833 09            [11]  221 	add	hl,bc
   4834 4D            [ 4]  222 	ld	c,l
   4835 44            [ 4]  223 	ld	b,h
                            224 ;src/UI_Log.c:46: --i;
   4836 DD 35 FF      [23]  225 	dec	-1 (ix)
   4839 18 B5         [12]  226 	jr	00101$
   483B                     227 00104$:
   483B 33            [ 6]  228 	inc	sp
   483C DD E1         [14]  229 	pop	ix
   483E C9            [10]  230 	ret
                            231 	.area _CODE
                            232 	.area _INITIALIZER
                            233 	.area _CABS (ABS)
