                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module UI_GameMenu
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _cpct_setPALColour
                             12 	.globl _cpct_drawSolidBox
                             13 	.globl _entrySelected
                             14 	.globl _entryIndex
                             15 	.globl _buttonWidths
                             16 	.globl _buttonText
                             17 	.globl _entriesPosition
                             18 	.globl _ui_gamemenu_next_entry
                             19 	.globl _ui_gamemenu_previous_entry
                             20 	.globl _ui_gamemenu_unselect_entry
                             21 	.globl _ui_gamemenu_select_entry
                             22 	.globl _ui_gamemenu_render
                             23 	.globl _ui_gamemenu_get_entry
                             24 	.globl _ui_gamemenu_is_selected
                             25 ;--------------------------------------------------------
                             26 ; special function registers
                             27 ;--------------------------------------------------------
                             28 ;--------------------------------------------------------
                             29 ; ram data
                             30 ;--------------------------------------------------------
                             31 	.area _DATA
                             32 ;--------------------------------------------------------
                             33 ; ram data
                             34 ;--------------------------------------------------------
                             35 	.area _INITIALIZED
   417B                      36 _entryIndex::
   417B                      37 	.ds 1
   417C                      38 _entrySelected::
   417C                      39 	.ds 1
                             40 ;--------------------------------------------------------
                             41 ; absolute external ram data
                             42 ;--------------------------------------------------------
                             43 	.area _DABS (ABS)
                             44 ;--------------------------------------------------------
                             45 ; global & static initialisations
                             46 ;--------------------------------------------------------
                             47 	.area _HOME
                             48 	.area _GSINIT
                             49 	.area _GSFINAL
                             50 	.area _GSINIT
                             51 ;--------------------------------------------------------
                             52 ; Home
                             53 ;--------------------------------------------------------
                             54 	.area _HOME
                             55 	.area _HOME
                             56 ;--------------------------------------------------------
                             57 ; code
                             58 ;--------------------------------------------------------
                             59 	.area _CODE
                             60 ;src/UI_GameMenu.c:36: void ui_gamemenu_next_entry(){
                             61 ;	---------------------------------
                             62 ; Function ui_gamemenu_next_entry
                             63 ; ---------------------------------
   1FCD                      64 _ui_gamemenu_next_entry::
                             65 ;src/UI_GameMenu.c:37: if(entryIndex<(ENTRIES-1)){
   1FCD 3A 7B 41      [13]   66 	ld	a,(#_entryIndex + 0)
   1FD0 D6 05         [ 7]   67 	sub	a, #0x05
   1FD2 D0            [11]   68 	ret	NC
                             69 ;src/UI_GameMenu.c:38: ++entryIndex;
   1FD3 21 7B 41      [10]   70 	ld	hl, #_entryIndex+0
   1FD6 34            [11]   71 	inc	(hl)
   1FD7 C9            [10]   72 	ret
   1FD8                      73 _entriesPosition:
   1FD8 50 C5                74 	.dw #0xC550
   1FDA E3 C6                75 	.dw #0xC6E3
   1FDC 66 C5                76 	.dw #0xC566
   1FDE 84 C5                77 	.dw #0xC584
   1FE0 93 C5                78 	.dw #0xC593
   1FE2 23 C7                79 	.dw #0xC723
   1FE4                      80 _buttonText:
   1FE4 F6 1F                81 	.dw __str_0
   1FE6 F7 1F                82 	.dw __str_1
   1FE8 F6 1F                83 	.dw __str_0
   1FEA FC 1F                84 	.dw __str_2
   1FEC 03 20                85 	.dw __str_3
   1FEE 07 20                86 	.dw __str_4
   1FF0                      87 _buttonWidths:
   1FF0 06                   88 	.db #0x06	; 6
   1FF1 16                   89 	.db #0x16	; 22
   1FF2 06                   90 	.db #0x06	; 6
   1FF3 0D                   91 	.db #0x0D	; 13
   1FF4 0D                   92 	.db #0x0D	; 13
   1FF5 0D                   93 	.db #0x0D	; 13
   1FF6                      94 __str_0:
   1FF6 00                   95 	.db 0x00
   1FF7                      96 __str_1:
   1FF7 4D 4F 56 45          97 	.ascii "MOVE"
   1FFB 00                   98 	.db 0x00
   1FFC                      99 __str_2:
   1FFC 41 54 54 41 43 4B   100 	.ascii "ATTACK"
   2002 00                  101 	.db 0x00
   2003                     102 __str_3:
   2003 49 4E 56            103 	.ascii "INV"
   2006 00                  104 	.db 0x00
   2007                     105 __str_4:
   2007 50 41 55 53 45      106 	.ascii "PAUSE"
   200C 00                  107 	.db 0x00
                            108 ;src/UI_GameMenu.c:42: void ui_gamemenu_previous_entry(){
                            109 ;	---------------------------------
                            110 ; Function ui_gamemenu_previous_entry
                            111 ; ---------------------------------
   200D                     112 _ui_gamemenu_previous_entry::
                            113 ;src/UI_GameMenu.c:43: if(entryIndex>0){
   200D 3A 7B 41      [13]  114 	ld	a,(#_entryIndex + 0)
   2010 B7            [ 4]  115 	or	a, a
   2011 C8            [11]  116 	ret	Z
                            117 ;src/UI_GameMenu.c:44: --entryIndex;
   2012 21 7B 41      [10]  118 	ld	hl, #_entryIndex+0
   2015 35            [11]  119 	dec	(hl)
   2016 C9            [10]  120 	ret
                            121 ;src/UI_GameMenu.c:48: void ui_gamemenu_unselect_entry(){
                            122 ;	---------------------------------
                            123 ; Function ui_gamemenu_unselect_entry
                            124 ; ---------------------------------
   2017                     125 _ui_gamemenu_unselect_entry::
                            126 ;src/UI_GameMenu.c:49: entrySelected=0;
   2017 21 7C 41      [10]  127 	ld	hl,#_entrySelected + 0
   201A 36 00         [10]  128 	ld	(hl), #0x00
   201C C9            [10]  129 	ret
                            130 ;src/UI_GameMenu.c:52: void ui_gamemenu_select_entry(){
                            131 ;	---------------------------------
                            132 ; Function ui_gamemenu_select_entry
                            133 ; ---------------------------------
   201D                     134 _ui_gamemenu_select_entry::
                            135 ;src/UI_GameMenu.c:53: entrySelected=1;
   201D 21 7C 41      [10]  136 	ld	hl,#_entrySelected + 0
   2020 36 01         [10]  137 	ld	(hl), #0x01
   2022 C9            [10]  138 	ret
                            139 ;src/UI_GameMenu.c:56: void ui_gamemenu_render(){
                            140 ;	---------------------------------
                            141 ; Function ui_gamemenu_render
                            142 ; ---------------------------------
   2023                     143 _ui_gamemenu_render::
   2023 DD E5         [15]  144 	push	ix
   2025 DD 21 00 00   [14]  145 	ld	ix,#0
   2029 DD 39         [15]  146 	add	ix,sp
   202B 3B            [ 6]  147 	dec	sp
                            148 ;src/UI_GameMenu.c:59: cpct_setBorder(g_palette[0]);
   202C 21 95 0A      [10]  149 	ld	hl, #_g_palette + 0
   202F 46            [ 7]  150 	ld	b,(hl)
   2030 C5            [11]  151 	push	bc
   2031 33            [ 6]  152 	inc	sp
   2032 3E 10         [ 7]  153 	ld	a,#0x10
   2034 F5            [11]  154 	push	af
   2035 33            [ 6]  155 	inc	sp
   2036 CD D3 3D      [17]  156 	call	_cpct_setPALColour
                            157 ;src/UI_GameMenu.c:61: while(n){
   2039 DD 36 FF 06   [19]  158 	ld	-1 (ix),#0x06
   203D                     159 00101$:
   203D DD 7E FF      [19]  160 	ld	a,-1 (ix)
   2040 B7            [ 4]  161 	or	a, a
   2041 28 46         [12]  162 	jr	Z,00103$
                            163 ;src/UI_GameMenu.c:62: --n;
   2043 DD 35 FF      [23]  164 	dec	-1 (ix)
                            165 ;src/UI_GameMenu.c:63: color = (n==entryIndex)?((entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
   2046 3A 7B 41      [13]  166 	ld	a,(#_entryIndex + 0)
   2049 DD 96 FF      [19]  167 	sub	a, -1 (ix)
   204C 20 10         [12]  168 	jr	NZ,00106$
   204E 3A 7C 41      [13]  169 	ld	a,(#_entrySelected + 0)
   2051 B7            [ 4]  170 	or	a, a
   2052 28 05         [12]  171 	jr	Z,00108$
   2054 3A A9 0A      [13]  172 	ld	a, (#_g_colors + 4)
   2057 18 08         [12]  173 	jr	00107$
   2059                     174 00108$:
   2059 3A AA 0A      [13]  175 	ld	a, (#_g_colors + 5)
   205C 18 03         [12]  176 	jr	00107$
   205E                     177 00106$:
   205E 3A A7 0A      [13]  178 	ld	a, (#_g_colors + 2)
   2061                     179 00107$:
   2061 4F            [ 4]  180 	ld	c,a
                            181 ;src/UI_GameMenu.c:64: cpct_drawSolidBox(entriesPosition[n],color, buttonWidths[n], BUTTON_HEIGHT);
   2062 3E F0         [ 7]  182 	ld	a,#<(_buttonWidths)
   2064 DD 86 FF      [19]  183 	add	a, -1 (ix)
   2067 6F            [ 4]  184 	ld	l,a
   2068 3E 1F         [ 7]  185 	ld	a,#>(_buttonWidths)
   206A CE 00         [ 7]  186 	adc	a, #0x00
   206C 67            [ 4]  187 	ld	h,a
   206D 46            [ 7]  188 	ld	b,(hl)
   206E DD 6E FF      [19]  189 	ld	l,-1 (ix)
   2071 26 00         [ 7]  190 	ld	h,#0x00
   2073 29            [11]  191 	add	hl, hl
   2074 11 D8 1F      [10]  192 	ld	de,#_entriesPosition
   2077 19            [11]  193 	add	hl,de
   2078 5E            [ 7]  194 	ld	e,(hl)
   2079 23            [ 6]  195 	inc	hl
   207A 56            [ 7]  196 	ld	d,(hl)
   207B 3E 18         [ 7]  197 	ld	a,#0x18
   207D F5            [11]  198 	push	af
   207E 33            [ 6]  199 	inc	sp
   207F C5            [11]  200 	push	bc
   2080 D5            [11]  201 	push	de
   2081 CD 7B 3F      [17]  202 	call	_cpct_drawSolidBox
   2084 F1            [10]  203 	pop	af
   2085 F1            [10]  204 	pop	af
   2086 33            [ 6]  205 	inc	sp
   2087 18 B4         [12]  206 	jr	00101$
   2089                     207 00103$:
                            208 ;src/UI_GameMenu.c:67: cpct_setBorder(g_palette[1]);
   2089 21 96 0A      [10]  209 	ld	hl, #_g_palette + 1
   208C 46            [ 7]  210 	ld	b,(hl)
   208D C5            [11]  211 	push	bc
   208E 33            [ 6]  212 	inc	sp
   208F 3E 10         [ 7]  213 	ld	a,#0x10
   2091 F5            [11]  214 	push	af
   2092 33            [ 6]  215 	inc	sp
   2093 CD D3 3D      [17]  216 	call	_cpct_setPALColour
   2096 33            [ 6]  217 	inc	sp
   2097 DD E1         [14]  218 	pop	ix
   2099 C9            [10]  219 	ret
                            220 ;src/UI_GameMenu.c:71: u8 ui_gamemenu_get_entry(){
                            221 ;	---------------------------------
                            222 ; Function ui_gamemenu_get_entry
                            223 ; ---------------------------------
   209A                     224 _ui_gamemenu_get_entry::
                            225 ;src/UI_GameMenu.c:72: return entryIndex;
   209A FD 21 7B 41   [14]  226 	ld	iy,#_entryIndex
   209E FD 6E 00      [19]  227 	ld	l,0 (iy)
   20A1 C9            [10]  228 	ret
                            229 ;src/UI_GameMenu.c:75: u8 ui_gamemenu_is_selected(){
                            230 ;	---------------------------------
                            231 ; Function ui_gamemenu_is_selected
                            232 ; ---------------------------------
   20A2                     233 _ui_gamemenu_is_selected::
                            234 ;src/UI_GameMenu.c:76: return entrySelected;
   20A2 FD 21 7C 41   [14]  235 	ld	iy,#_entrySelected
   20A6 FD 6E 00      [19]  236 	ld	l,0 (iy)
   20A9 C9            [10]  237 	ret
                            238 	.area _CODE
                            239 	.area _INITIALIZER
   417F                     240 __xinit__entryIndex:
   417F 00                  241 	.db #0x00	; 0
   4180                     242 __xinit__entrySelected:
   4180 00                  243 	.db #0x00	; 0
                            244 	.area _CABS (ABS)
