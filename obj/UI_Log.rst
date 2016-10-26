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
   874D                      26 _ui_log_currentString::
   874D                      27 	.ds 1
   874E                      28 _ui_log_textStrings::
   874E                      29 	.ds 80
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
   488D                      58 _ui_log_init::
                             59 ;src/UI_Log.c:20: ui_log_currentString=0;
   488D 21 4D 87      [10]   60 	ld	hl,#_ui_log_currentString + 0
   4890 36 00         [10]   61 	ld	(hl), #0x00
                             62 ;src/UI_Log.c:21: print_text("LOG", UI_LOG_TITLE_POSITION, UI_LOG_BG_COLOR, 3);
   4892 21 01 03      [10]   63 	ld	hl,#0x0301
   4895 E5            [11]   64 	push	hl
   4896 21 E6 C0      [10]   65 	ld	hl,#0xC0E6
   4899 E5            [11]   66 	push	hl
   489A 21 CB 48      [10]   67 	ld	hl,#___str_0
   489D E5            [11]   68 	push	hl
   489E CD 39 3F      [17]   69 	call	_print_text
   48A1 21 06 00      [10]   70 	ld	hl,#6
   48A4 39            [11]   71 	add	hl,sp
   48A5 F9            [ 6]   72 	ld	sp,hl
                             73 ;src/UI_Log.c:22: while(n){
   48A6 0E 08         [ 7]   74 	ld	c,#0x08
   48A8 11 50 00      [10]   75 	ld	de,#0x0050
   48AB                      76 00101$:
   48AB 79            [ 4]   77 	ld	a,c
   48AC B7            [ 4]   78 	or	a, a
   48AD C8            [11]   79 	ret	Z
                             80 ;src/UI_Log.c:23: --n;
   48AE 7B            [ 4]   81 	ld	a,e
   48AF C6 F6         [ 7]   82 	add	a,#0xF6
   48B1 5F            [ 4]   83 	ld	e,a
   48B2 7A            [ 4]   84 	ld	a,d
   48B3 CE FF         [ 7]   85 	adc	a,#0xFF
   48B5 57            [ 4]   86 	ld	d,a
   48B6 0D            [ 4]   87 	dec	c
                             88 ;src/UI_Log.c:24: ui_log_textStrings[n][0]=0;
   48B7 21 4E 87      [10]   89 	ld	hl,#_ui_log_textStrings
   48BA 19            [11]   90 	add	hl,de
   48BB 36 00         [10]   91 	ld	(hl),#0x00
                             92 ;src/UI_Log.c:25: ui_log_textStrings[n][8]=0;
   48BD 21 4E 87      [10]   93 	ld	hl,#_ui_log_textStrings
   48C0 19            [11]   94 	add	hl,de
   48C1 D5            [11]   95 	push	de
   48C2 11 08 00      [10]   96 	ld	de,#0x0008
   48C5 19            [11]   97 	add	hl, de
   48C6 D1            [10]   98 	pop	de
   48C7 36 00         [10]   99 	ld	(hl),#0x00
   48C9 18 E0         [12]  100 	jr	00101$
   48CB                     101 ___str_0:
   48CB 4C 4F 47            102 	.ascii "LOG"
   48CE 00                  103 	.db 0x00
                            104 ;src/UI_Log.c:29: void ui_log_add_log(const char* const newLog, u8 color){
                            105 ;	---------------------------------
                            106 ; Function ui_log_add_log
                            107 ; ---------------------------------
   48CF                     108 _ui_log_add_log::
   48CF DD E5         [15]  109 	push	ix
   48D1 DD 21 00 00   [14]  110 	ld	ix,#0
   48D5 DD 39         [15]  111 	add	ix,sp
                            112 ;src/UI_Log.c:31: ui_log_currentString = (ui_log_currentString+1) & 7;
   48D7 3A 4D 87      [13]  113 	ld	a,(#_ui_log_currentString + 0)
   48DA 3C            [ 4]  114 	inc	a
   48DB E6 07         [ 7]  115 	and	a, #0x07
   48DD 32 4D 87      [13]  116 	ld	(#_ui_log_currentString + 0),a
                            117 ;src/UI_Log.c:33: cpct_memcpy(ui_log_textStrings[ui_log_currentString], newLog, 8);
   48E0 DD 4E 04      [19]  118 	ld	c,4 (ix)
   48E3 DD 46 05      [19]  119 	ld	b,5 (ix)
   48E6 ED 5B 4D 87   [20]  120 	ld	de,(_ui_log_currentString)
   48EA 16 00         [ 7]  121 	ld	d,#0x00
   48EC 6B            [ 4]  122 	ld	l, e
   48ED 62            [ 4]  123 	ld	h, d
   48EE 29            [11]  124 	add	hl, hl
   48EF 29            [11]  125 	add	hl, hl
   48F0 19            [11]  126 	add	hl, de
   48F1 29            [11]  127 	add	hl, hl
   48F2 11 4E 87      [10]  128 	ld	de,#_ui_log_textStrings
   48F5 19            [11]  129 	add	hl,de
   48F6 11 08 00      [10]  130 	ld	de,#0x0008
   48F9 D5            [11]  131 	push	de
   48FA C5            [11]  132 	push	bc
   48FB E5            [11]  133 	push	hl
   48FC CD 09 85      [17]  134 	call	_cpct_memcpy
                            135 ;src/UI_Log.c:34: ui_log_textStrings[ui_log_currentString][9] = color;
   48FF ED 4B 4D 87   [20]  136 	ld	bc,(_ui_log_currentString)
   4903 06 00         [ 7]  137 	ld	b,#0x00
   4905 69            [ 4]  138 	ld	l, c
   4906 60            [ 4]  139 	ld	h, b
   4907 29            [11]  140 	add	hl, hl
   4908 29            [11]  141 	add	hl, hl
   4909 09            [11]  142 	add	hl, bc
   490A 29            [11]  143 	add	hl, hl
   490B 11 4E 87      [10]  144 	ld	de,#_ui_log_textStrings
   490E 19            [11]  145 	add	hl,de
   490F 01 09 00      [10]  146 	ld	bc,#0x0009
   4912 09            [11]  147 	add	hl,bc
   4913 DD 7E 06      [19]  148 	ld	a,6 (ix)
   4916 77            [ 7]  149 	ld	(hl),a
   4917 DD E1         [14]  150 	pop	ix
   4919 C9            [10]  151 	ret
                            152 ;src/UI_Log.c:38: void ui_log_render(){
                            153 ;	---------------------------------
                            154 ; Function ui_log_render
                            155 ; ---------------------------------
   491A                     156 _ui_log_render::
   491A DD E5         [15]  157 	push	ix
   491C DD 21 00 00   [14]  158 	ld	ix,#0
   4920 DD 39         [15]  159 	add	ix,sp
   4922 3B            [ 6]  160 	dec	sp
                            161 ;src/UI_Log.c:41: cpct_drawSolidBox(UI_LOG_POSITION, g_colors[1], 16, 64);
   4923 21 29 1C      [10]  162 	ld	hl,#_g_colors+1
   4926 46            [ 7]  163 	ld	b,(hl)
   4927 21 10 40      [10]  164 	ld	hl,#0x4010
   492A E5            [11]  165 	push	hl
   492B C5            [11]  166 	push	bc
   492C 33            [ 6]  167 	inc	sp
   492D 21 80 C1      [10]  168 	ld	hl,#0xC180
   4930 E5            [11]  169 	push	hl
   4931 CD 2F 85      [17]  170 	call	_cpct_drawSolidBox
   4934 F1            [10]  171 	pop	af
   4935 F1            [10]  172 	pop	af
   4936 33            [ 6]  173 	inc	sp
                            174 ;src/UI_Log.c:42: while(i){
   4937 01 80 C1      [10]  175 	ld	bc,#0xC180
   493A DD 36 FF 08   [19]  176 	ld	-1 (ix),#0x08
   493E                     177 00101$:
   493E DD 7E FF      [19]  178 	ld	a,-1 (ix)
   4941 B7            [ 4]  179 	or	a, a
   4942 28 45         [12]  180 	jr	Z,00104$
                            181 ;src/UI_Log.c:43: ui_log_currentString=((ui_log_currentString+1)&7);
   4944 3A 4D 87      [13]  182 	ld	a,(#_ui_log_currentString + 0)
   4947 3C            [ 4]  183 	inc	a
   4948 E6 07         [ 7]  184 	and	a, #0x07
   494A 32 4D 87      [13]  185 	ld	(#_ui_log_currentString + 0),a
                            186 ;src/UI_Log.c:44: print_text(ui_log_textStrings[ui_log_currentString], pos, UI_LOG_BG_COLOR, ui_log_textStrings[ui_log_currentString][9]);
   494D ED 5B 4D 87   [20]  187 	ld	de,(_ui_log_currentString)
   4951 16 00         [ 7]  188 	ld	d,#0x00
   4953 6B            [ 4]  189 	ld	l, e
   4954 62            [ 4]  190 	ld	h, d
   4955 29            [11]  191 	add	hl, hl
   4956 29            [11]  192 	add	hl, hl
   4957 19            [11]  193 	add	hl, de
   4958 29            [11]  194 	add	hl, hl
   4959 5D            [ 4]  195 	ld	e,l
   495A 54            [ 4]  196 	ld	d,h
   495B FD 21 4E 87   [14]  197 	ld	iy,#_ui_log_textStrings
   495F FD 19         [15]  198 	add	iy, de
   4961 FD 66 09      [19]  199 	ld	h,9 (iy)
   4964 3E 4E         [ 7]  200 	ld	a,#<(_ui_log_textStrings)
   4966 83            [ 4]  201 	add	a, e
   4967 5F            [ 4]  202 	ld	e,a
   4968 3E 87         [ 7]  203 	ld	a,#>(_ui_log_textStrings)
   496A 8A            [ 4]  204 	adc	a, d
   496B 57            [ 4]  205 	ld	d,a
   496C C5            [11]  206 	push	bc
   496D E5            [11]  207 	push	hl
   496E 33            [ 6]  208 	inc	sp
   496F 3E 01         [ 7]  209 	ld	a,#0x01
   4971 F5            [11]  210 	push	af
   4972 33            [ 6]  211 	inc	sp
   4973 C5            [11]  212 	push	bc
   4974 D5            [11]  213 	push	de
   4975 CD 39 3F      [17]  214 	call	_print_text
   4978 21 06 00      [10]  215 	ld	hl,#6
   497B 39            [11]  216 	add	hl,sp
   497C F9            [ 6]  217 	ld	sp,hl
   497D C1            [10]  218 	pop	bc
                            219 ;src/UI_Log.c:45: pos+=80;
   497E 21 50 00      [10]  220 	ld	hl,#0x0050
   4981 09            [11]  221 	add	hl,bc
   4982 4D            [ 4]  222 	ld	c,l
   4983 44            [ 4]  223 	ld	b,h
                            224 ;src/UI_Log.c:46: --i;
   4984 DD 35 FF      [23]  225 	dec	-1 (ix)
   4987 18 B5         [12]  226 	jr	00101$
   4989                     227 00104$:
   4989 33            [ 6]  228 	inc	sp
   498A DD E1         [14]  229 	pop	ix
   498C C9            [10]  230 	ret
                            231 	.area _CODE
                            232 	.area _INITIALIZER
                            233 	.area _CABS (ABS)
