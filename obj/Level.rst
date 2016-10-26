                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module Level
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _setLevelPalette
                             12 	.globl _setMenuPalette
                             13 	.globl _uncompress_enemy_textures
                             14 	.globl _uncompress_theme_textures
                             15 	.globl _cpct_setPalette
                             16 	.globl _cpct_fw2hw
                             17 	.globl _cpct_memcpy
                             18 	.globl _current_level
                             19 	.globl _level_palettes
                             20 	.globl _menu_palette
                             21 	.globl _level_get_level
                             22 	.globl _level_set_level
                             23 	.globl _level_init_palettes
                             24 	.globl _level_load_level
                             25 ;--------------------------------------------------------
                             26 ; special function registers
                             27 ;--------------------------------------------------------
                             28 ;--------------------------------------------------------
                             29 ; ram data
                             30 ;--------------------------------------------------------
                             31 	.area _DATA
   7D88                      32 _current_level::
   7D88                      33 	.ds 1
                             34 ;--------------------------------------------------------
                             35 ; ram data
                             36 ;--------------------------------------------------------
                             37 	.area _INITIALIZED
                             38 ;--------------------------------------------------------
                             39 ; absolute external ram data
                             40 ;--------------------------------------------------------
                             41 	.area _DABS (ABS)
                             42 ;--------------------------------------------------------
                             43 ; global & static initialisations
                             44 ;--------------------------------------------------------
                             45 	.area _HOME
                             46 	.area _GSINIT
                             47 	.area _GSFINAL
                             48 	.area _GSINIT
                             49 ;--------------------------------------------------------
                             50 ; Home
                             51 ;--------------------------------------------------------
                             52 	.area _HOME
                             53 	.area _HOME
                             54 ;--------------------------------------------------------
                             55 ; code
                             56 ;--------------------------------------------------------
                             57 	.area _CODE
                             58 ;src/Level.c:23: u8 level_get_level(){
                             59 ;	---------------------------------
                             60 ; Function level_get_level
                             61 ; ---------------------------------
   0FF0                      62 _level_get_level::
                             63 ;src/Level.c:24: return current_level;
   0FF0 FD 21 88 7D   [14]   64 	ld	iy,#_current_level
   0FF4 FD 6E 00      [19]   65 	ld	l,0 (iy)
   0FF7 C9            [10]   66 	ret
   0FF8                      67 _menu_palette:
   0FF8 01                   68 	.db #0x01	; 1
   0FF9 02                   69 	.db #0x02	; 2
   0FFA 18                   70 	.db #0x18	; 24
   0FFB 12                   71 	.db #0x12	; 18
   0FFC 15                   72 	.db #0x15	; 21
   0FFD 10                   73 	.db #0x10	; 16
   0FFE 03                   74 	.db #0x03	; 3
   0FFF 00                   75 	.db #0x00	; 0
   1000 11                   76 	.db #0x11	; 17
   1001                      77 _level_palettes:
   1001 00                   78 	.db #0x00	; 0
   1002 09                   79 	.db #0x09	; 9
   1003 14                   80 	.db #0x14	; 20
   1004 0B                   81 	.db #0x0B	; 11
   1005 0A                   82 	.db #0x0A	; 10
   1006 0D                   83 	.db #0x0D	; 13
   1007 12                   84 	.db #0x12	; 18
   1008 03                   85 	.db #0x03	; 3
   1009 11                   86 	.db #0x11	; 17
   100A 0B                   87 	.db #0x0B	; 11
   100B 15                   88 	.db #0x15	; 21
   100C 14                   89 	.db #0x14	; 20
   100D 0A                   90 	.db #0x0A	; 10
   100E 10                   91 	.db #0x10	; 16
   100F 03                   92 	.db #0x03	; 3
   1010 18                   93 	.db #0x18	; 24
   1011 19                   94 	.db #0x19	; 25
   1012 11                   95 	.db #0x11	; 17
   1013 01                   96 	.db #0x01	; 1
   1014 0B                   97 	.db #0x0B	; 11
   1015 19                   98 	.db #0x19	; 25
   1016 18                   99 	.db #0x18	; 24
   1017 10                  100 	.db #0x10	; 16
   1018 03                  101 	.db #0x03	; 3
   1019 02                  102 	.db #0x02	; 2
   101A 12                  103 	.db #0x12	; 18
   101B 11                  104 	.db #0x11	; 17
   101C 0D                  105 	.db #0x0D	; 13
   101D 03                  106 	.db #0x03	; 3
   101E 19                  107 	.db #0x19	; 25
   101F 18                  108 	.db #0x18	; 24
   1020 1A                  109 	.db #0x1A	; 26
   1021 00                  110 	.db #0x00	; 0
   1022 00                  111 	.db #0x00	; 0
   1023 00                  112 	.db #0x00	; 0
   1024 11                  113 	.db #0x11	; 17
                            114 ;src/Level.c:27: void level_set_level(u8 l) {
                            115 ;	---------------------------------
                            116 ; Function level_set_level
                            117 ; ---------------------------------
   1025                     118 _level_set_level::
                            119 ;src/Level.c:28: current_level=l;
   1025 21 02 00      [10]  120 	ld	hl, #2+0
   1028 39            [11]  121 	add	hl, sp
   1029 7E            [ 7]  122 	ld	a, (hl)
   102A 32 88 7D      [13]  123 	ld	(#_current_level + 0),a
   102D C9            [10]  124 	ret
                            125 ;src/Level.c:31: void level_init_palettes(){
                            126 ;	---------------------------------
                            127 ; Function level_init_palettes
                            128 ; ---------------------------------
   102E                     129 _level_init_palettes::
                            130 ;src/Level.c:32: cpct_fw2hw(level_palettes[0],VARIABLE_COLORS);
   102E 21 09 00      [10]  131 	ld	hl,#0x0009
   1031 E5            [11]  132 	push	hl
   1032 21 01 10      [10]  133 	ld	hl,#_level_palettes
   1035 E5            [11]  134 	push	hl
   1036 CD 50 7A      [17]  135 	call	_cpct_fw2hw
                            136 ;src/Level.c:33: cpct_fw2hw(level_palettes[1],VARIABLE_COLORS);
   1039 21 09 00      [10]  137 	ld	hl,#0x0009
   103C E5            [11]  138 	push	hl
   103D 21 0A 10      [10]  139 	ld	hl,#(_level_palettes + 0x0009)
   1040 E5            [11]  140 	push	hl
   1041 CD 50 7A      [17]  141 	call	_cpct_fw2hw
                            142 ;src/Level.c:34: cpct_fw2hw(level_palettes[2],VARIABLE_COLORS);
   1044 21 09 00      [10]  143 	ld	hl,#0x0009
   1047 E5            [11]  144 	push	hl
   1048 21 13 10      [10]  145 	ld	hl,#(_level_palettes + 0x0012)
   104B E5            [11]  146 	push	hl
   104C CD 50 7A      [17]  147 	call	_cpct_fw2hw
                            148 ;src/Level.c:35: cpct_fw2hw(level_palettes[3],VARIABLE_COLORS);
   104F 21 09 00      [10]  149 	ld	hl,#0x0009
   1052 E5            [11]  150 	push	hl
   1053 21 1C 10      [10]  151 	ld	hl,#(_level_palettes + 0x001b)
   1056 E5            [11]  152 	push	hl
   1057 CD 50 7A      [17]  153 	call	_cpct_fw2hw
                            154 ;src/Level.c:36: cpct_fw2hw(menu_palette,VARIABLE_COLORS);
   105A 21 09 00      [10]  155 	ld	hl,#0x0009
   105D E5            [11]  156 	push	hl
   105E 21 F8 0F      [10]  157 	ld	hl,#_menu_palette
   1061 E5            [11]  158 	push	hl
   1062 CD 50 7A      [17]  159 	call	_cpct_fw2hw
   1065 C9            [10]  160 	ret
                            161 ;src/Level.c:39: void setMenuPalette(){
                            162 ;	---------------------------------
                            163 ; Function setMenuPalette
                            164 ; ---------------------------------
   1066                     165 _setMenuPalette::
                            166 ;src/Level.c:40: cpct_memcpy(g_palette+SHARED_COLORS, menu_palette,VARIABLE_COLORS);
   1066 21 09 00      [10]  167 	ld	hl,#0x0009
   1069 E5            [11]  168 	push	hl
   106A 21 F8 0F      [10]  169 	ld	hl,#_menu_palette
   106D E5            [11]  170 	push	hl
   106E 21 A6 1A      [10]  171 	ld	hl,#(_g_palette + 0x0007)
   1071 E5            [11]  172 	push	hl
   1072 CD 92 7B      [17]  173 	call	_cpct_memcpy
                            174 ;src/Level.c:41: cpct_setPalette(g_palette,16);
   1075 21 10 00      [10]  175 	ld	hl,#0x0010
   1078 E5            [11]  176 	push	hl
   1079 21 9F 1A      [10]  177 	ld	hl,#_g_palette
   107C E5            [11]  178 	push	hl
   107D CD 71 79      [17]  179 	call	_cpct_setPalette
   1080 C9            [10]  180 	ret
                            181 ;src/Level.c:44: void setLevelPalette(u8 i){
                            182 ;	---------------------------------
                            183 ; Function setLevelPalette
                            184 ; ---------------------------------
   1081                     185 _setLevelPalette::
   1081 DD E5         [15]  186 	push	ix
   1083 DD 21 00 00   [14]  187 	ld	ix,#0
   1087 DD 39         [15]  188 	add	ix,sp
                            189 ;src/Level.c:45: cpct_memcpy(g_palette+SHARED_COLORS, level_palettes[i],VARIABLE_COLORS);
   1089 01 01 10      [10]  190 	ld	bc,#_level_palettes+0
   108C DD 5E 04      [19]  191 	ld	e,4 (ix)
   108F 16 00         [ 7]  192 	ld	d,#0x00
   1091 6B            [ 4]  193 	ld	l, e
   1092 62            [ 4]  194 	ld	h, d
   1093 29            [11]  195 	add	hl, hl
   1094 29            [11]  196 	add	hl, hl
   1095 29            [11]  197 	add	hl, hl
   1096 19            [11]  198 	add	hl, de
   1097 09            [11]  199 	add	hl,bc
   1098 4D            [ 4]  200 	ld	c,l
   1099 44            [ 4]  201 	ld	b,h
   109A 21 09 00      [10]  202 	ld	hl,#0x0009
   109D E5            [11]  203 	push	hl
   109E C5            [11]  204 	push	bc
   109F 21 A6 1A      [10]  205 	ld	hl,#(_g_palette + 0x0007)
   10A2 E5            [11]  206 	push	hl
   10A3 CD 92 7B      [17]  207 	call	_cpct_memcpy
                            208 ;src/Level.c:46: cpct_setPalette(g_palette,16);
   10A6 21 10 00      [10]  209 	ld	hl,#0x0010
   10A9 E5            [11]  210 	push	hl
   10AA 21 9F 1A      [10]  211 	ld	hl,#_g_palette
   10AD E5            [11]  212 	push	hl
   10AE CD 71 79      [17]  213 	call	_cpct_setPalette
   10B1 DD E1         [14]  214 	pop	ix
   10B3 C9            [10]  215 	ret
                            216 ;src/Level.c:49: void level_load_level(){
                            217 ;	---------------------------------
                            218 ; Function level_load_level
                            219 ; ---------------------------------
   10B4                     220 _level_load_level::
                            221 ;src/Level.c:50: u8 index=current_level>>3;
   10B4 21 88 7D      [10]  222 	ld	hl,#_current_level + 0
   10B7 46            [ 7]  223 	ld	b, (hl)
   10B8 CB 38         [ 8]  224 	srl	b
   10BA CB 38         [ 8]  225 	srl	b
   10BC CB 38         [ 8]  226 	srl	b
                            227 ;src/Level.c:53: enemIndex = index;
   10BE 48            [ 4]  228 	ld	c,b
                            229 ;src/Level.c:55: if(current_level==KING_LEVEL) index = 3;
   10BF 3A 88 7D      [13]  230 	ld	a,(#_current_level + 0)
   10C2 D6 20         [ 7]  231 	sub	a, #0x20
   10C4 20 02         [12]  232 	jr	NZ,00102$
   10C6 06 03         [ 7]  233 	ld	b,#0x03
   10C8                     234 00102$:
                            235 ;src/Level.c:58: uncompress_theme_textures(index);
   10C8 C5            [11]  236 	push	bc
   10C9 C5            [11]  237 	push	bc
   10CA 33            [ 6]  238 	inc	sp
   10CB CD A5 41      [17]  239 	call	_uncompress_theme_textures
   10CE 33            [ 6]  240 	inc	sp
   10CF C1            [10]  241 	pop	bc
                            242 ;src/Level.c:59: uncompress_enemy_textures(enemIndex);
   10D0 C5            [11]  243 	push	bc
   10D1 79            [ 4]  244 	ld	a,c
   10D2 F5            [11]  245 	push	af
   10D3 33            [ 6]  246 	inc	sp
   10D4 CD D4 41      [17]  247 	call	_uncompress_enemy_textures
   10D7 33            [ 6]  248 	inc	sp
   10D8 CD 47 42      [17]  249 	call	_uncompress_item_textures
   10DB 33            [ 6]  250 	inc	sp
   10DC CD 81 10      [17]  251 	call	_setLevelPalette
   10DF 33            [ 6]  252 	inc	sp
   10E0 C9            [10]  253 	ret
                            254 	.area _CODE
                            255 	.area _INITIALIZER
                            256 	.area _CABS (ABS)
