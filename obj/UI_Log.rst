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
                             11 	.globl _ui_log_render
                             12 	.globl _print_text
                             13 	.globl _cpct_memcpy
                             14 	.globl _ui_log_textStrings
                             15 	.globl _ui_log_currentString
                             16 	.globl _ui_log_init
                             17 	.globl _ui_log_add_log
                             18 ;--------------------------------------------------------
                             19 ; special function registers
                             20 ;--------------------------------------------------------
                             21 ;--------------------------------------------------------
                             22 ; ram data
                             23 ;--------------------------------------------------------
                             24 	.area _DATA
   5B32                      25 _ui_log_currentString::
   5B32                      26 	.ds 1
   5B33                      27 _ui_log_textStrings::
   5B33                      28 	.ds 72
                             29 ;--------------------------------------------------------
                             30 ; ram data
                             31 ;--------------------------------------------------------
                             32 	.area _INITIALIZED
                             33 ;--------------------------------------------------------
                             34 ; absolute external ram data
                             35 ;--------------------------------------------------------
                             36 	.area _DABS (ABS)
                             37 ;--------------------------------------------------------
                             38 ; global & static initialisations
                             39 ;--------------------------------------------------------
                             40 	.area _HOME
                             41 	.area _GSINIT
                             42 	.area _GSFINAL
                             43 	.area _GSINIT
                             44 ;--------------------------------------------------------
                             45 ; Home
                             46 ;--------------------------------------------------------
                             47 	.area _HOME
                             48 	.area _HOME
                             49 ;--------------------------------------------------------
                             50 ; code
                             51 ;--------------------------------------------------------
                             52 	.area _CODE
                             53 ;src/UI_Log.c:16: void ui_log_init(){
                             54 ;	---------------------------------
                             55 ; Function ui_log_init
                             56 ; ---------------------------------
   2CE2                      57 _ui_log_init::
                             58 ;src/UI_Log.c:18: ui_log_currentString=0;
   2CE2 21 32 5B      [10]   59 	ld	hl,#_ui_log_currentString + 0
   2CE5 36 00         [10]   60 	ld	(hl), #0x00
                             61 ;src/UI_Log.c:19: print_text("LOG", UI_LOG_TITLE_POSITION, UI_LOG_BG_COLOR, UI_LOG_FG_COLOR);
   2CE7 21 01 03      [10]   62 	ld	hl,#0x0301
   2CEA E5            [11]   63 	push	hl
   2CEB 21 E6 C0      [10]   64 	ld	hl,#0xC0E6
   2CEE E5            [11]   65 	push	hl
   2CEF 21 20 2D      [10]   66 	ld	hl,#___str_0
   2CF2 E5            [11]   67 	push	hl
   2CF3 CD 82 26      [17]   68 	call	_print_text
   2CF6 21 06 00      [10]   69 	ld	hl,#6
   2CF9 39            [11]   70 	add	hl,sp
   2CFA F9            [ 6]   71 	ld	sp,hl
                             72 ;src/UI_Log.c:20: while(n){
   2CFB 0E 08         [ 7]   73 	ld	c,#0x08
   2CFD 11 48 00      [10]   74 	ld	de,#0x0048
   2D00                      75 00101$:
   2D00 79            [ 4]   76 	ld	a,c
   2D01 B7            [ 4]   77 	or	a, a
   2D02 C8            [11]   78 	ret	Z
                             79 ;src/UI_Log.c:21: --n;
   2D03 7B            [ 4]   80 	ld	a,e
   2D04 C6 F7         [ 7]   81 	add	a,#0xF7
   2D06 5F            [ 4]   82 	ld	e,a
   2D07 7A            [ 4]   83 	ld	a,d
   2D08 CE FF         [ 7]   84 	adc	a,#0xFF
   2D0A 57            [ 4]   85 	ld	d,a
   2D0B 0D            [ 4]   86 	dec	c
                             87 ;src/UI_Log.c:22: ui_log_textStrings[n][0]=0;
   2D0C 21 33 5B      [10]   88 	ld	hl,#_ui_log_textStrings
   2D0F 19            [11]   89 	add	hl,de
   2D10 36 00         [10]   90 	ld	(hl),#0x00
                             91 ;src/UI_Log.c:23: ui_log_textStrings[n][8]=0;
   2D12 21 33 5B      [10]   92 	ld	hl,#_ui_log_textStrings
   2D15 19            [11]   93 	add	hl,de
   2D16 D5            [11]   94 	push	de
   2D17 11 08 00      [10]   95 	ld	de,#0x0008
   2D1A 19            [11]   96 	add	hl, de
   2D1B D1            [10]   97 	pop	de
   2D1C 36 00         [10]   98 	ld	(hl),#0x00
   2D1E 18 E0         [12]   99 	jr	00101$
   2D20                     100 ___str_0:
   2D20 4C 4F 47            101 	.ascii "LOG"
   2D23 00                  102 	.db 0x00
                            103 ;src/UI_Log.c:27: void ui_log_add_log(const char* const newLog){
                            104 ;	---------------------------------
                            105 ; Function ui_log_add_log
                            106 ; ---------------------------------
   2D24                     107 _ui_log_add_log::
   2D24 DD E5         [15]  108 	push	ix
   2D26 DD 21 00 00   [14]  109 	ld	ix,#0
   2D2A DD 39         [15]  110 	add	ix,sp
                            111 ;src/UI_Log.c:29: ui_log_currentString = (ui_log_currentString+1) & 7;
   2D2C 3A 32 5B      [13]  112 	ld	a,(#_ui_log_currentString + 0)
   2D2F 3C            [ 4]  113 	inc	a
   2D30 E6 07         [ 7]  114 	and	a, #0x07
   2D32 32 32 5B      [13]  115 	ld	(#_ui_log_currentString + 0),a
                            116 ;src/UI_Log.c:31: cpct_memcpy(ui_log_textStrings[ui_log_currentString], newLog, 8);
   2D35 DD 4E 04      [19]  117 	ld	c,4 (ix)
   2D38 DD 46 05      [19]  118 	ld	b,5 (ix)
   2D3B ED 5B 32 5B   [20]  119 	ld	de,(_ui_log_currentString)
   2D3F 16 00         [ 7]  120 	ld	d,#0x00
   2D41 6B            [ 4]  121 	ld	l, e
   2D42 62            [ 4]  122 	ld	h, d
   2D43 29            [11]  123 	add	hl, hl
   2D44 29            [11]  124 	add	hl, hl
   2D45 29            [11]  125 	add	hl, hl
   2D46 19            [11]  126 	add	hl, de
   2D47 11 33 5B      [10]  127 	ld	de,#_ui_log_textStrings
   2D4A 19            [11]  128 	add	hl,de
   2D4B 11 08 00      [10]  129 	ld	de,#0x0008
   2D4E D5            [11]  130 	push	de
   2D4F C5            [11]  131 	push	bc
   2D50 E5            [11]  132 	push	hl
   2D51 CD 3C 59      [17]  133 	call	_cpct_memcpy
   2D54 DD E1         [14]  134 	pop	ix
   2D56 C9            [10]  135 	ret
                            136 ;src/UI_Log.c:35: void ui_log_render(){
                            137 ;	---------------------------------
                            138 ; Function ui_log_render
                            139 ; ---------------------------------
   2D57                     140 _ui_log_render::
   2D57 DD E5         [15]  141 	push	ix
   2D59 DD 21 00 00   [14]  142 	ld	ix,#0
   2D5D DD 39         [15]  143 	add	ix,sp
   2D5F 3B            [ 6]  144 	dec	sp
                            145 ;src/UI_Log.c:39: while(i){
   2D60 01 80 C1      [10]  146 	ld	bc,#0xC180
   2D63 DD 36 FF 08   [19]  147 	ld	-1 (ix),#0x08
   2D67                     148 00101$:
   2D67 DD 7E FF      [19]  149 	ld	a,-1 (ix)
   2D6A B7            [ 4]  150 	or	a, a
   2D6B 28 35         [12]  151 	jr	Z,00104$
                            152 ;src/UI_Log.c:40: ui_log_currentString=((ui_log_currentString+1)&7);
   2D6D 3A 32 5B      [13]  153 	ld	a,(#_ui_log_currentString + 0)
   2D70 3C            [ 4]  154 	inc	a
   2D71 E6 07         [ 7]  155 	and	a, #0x07
   2D73 32 32 5B      [13]  156 	ld	(#_ui_log_currentString + 0),a
                            157 ;src/UI_Log.c:41: print_text(ui_log_textStrings[ui_log_currentString], pos, UI_LOG_BG_COLOR, UI_LOG_FG_COLOR);
   2D76 ED 5B 32 5B   [20]  158 	ld	de,(_ui_log_currentString)
   2D7A 16 00         [ 7]  159 	ld	d,#0x00
   2D7C 6B            [ 4]  160 	ld	l, e
   2D7D 62            [ 4]  161 	ld	h, d
   2D7E 29            [11]  162 	add	hl, hl
   2D7F 29            [11]  163 	add	hl, hl
   2D80 29            [11]  164 	add	hl, hl
   2D81 19            [11]  165 	add	hl, de
   2D82 11 33 5B      [10]  166 	ld	de,#_ui_log_textStrings
   2D85 19            [11]  167 	add	hl,de
   2D86 EB            [ 4]  168 	ex	de,hl
   2D87 C5            [11]  169 	push	bc
   2D88 21 01 03      [10]  170 	ld	hl,#0x0301
   2D8B E5            [11]  171 	push	hl
   2D8C C5            [11]  172 	push	bc
   2D8D D5            [11]  173 	push	de
   2D8E CD 82 26      [17]  174 	call	_print_text
   2D91 21 06 00      [10]  175 	ld	hl,#6
   2D94 39            [11]  176 	add	hl,sp
   2D95 F9            [ 6]  177 	ld	sp,hl
   2D96 C1            [10]  178 	pop	bc
                            179 ;src/UI_Log.c:42: pos+=80;
   2D97 21 50 00      [10]  180 	ld	hl,#0x0050
   2D9A 09            [11]  181 	add	hl,bc
   2D9B 4D            [ 4]  182 	ld	c,l
   2D9C 44            [ 4]  183 	ld	b,h
                            184 ;src/UI_Log.c:43: --i;
   2D9D DD 35 FF      [23]  185 	dec	-1 (ix)
   2DA0 18 C5         [12]  186 	jr	00101$
   2DA2                     187 00104$:
   2DA2 33            [ 6]  188 	inc	sp
   2DA3 DD E1         [14]  189 	pop	ix
   2DA5 C9            [10]  190 	ret
                            191 	.area _CODE
                            192 	.area _INITIALIZER
                            193 	.area _CABS (ABS)
