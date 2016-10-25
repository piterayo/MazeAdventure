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
   7D62                      32 _current_level::
   7D62                      33 	.ds 1
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
   0FA7                      62 _level_get_level::
                             63 ;src/Level.c:24: return current_level;
   0FA7 FD 21 62 7D   [14]   64 	ld	iy,#_current_level
   0FAB FD 6E 00      [19]   65 	ld	l,0 (iy)
   0FAE C9            [10]   66 	ret
   0FAF                      67 _menu_palette:
   0FAF 01                   68 	.db #0x01	; 1
   0FB0 02                   69 	.db #0x02	; 2
   0FB1 18                   70 	.db #0x18	; 24
   0FB2 12                   71 	.db #0x12	; 18
   0FB3 15                   72 	.db #0x15	; 21
   0FB4 10                   73 	.db #0x10	; 16
   0FB5 03                   74 	.db #0x03	; 3
   0FB6 00                   75 	.db #0x00	; 0
   0FB7 11                   76 	.db #0x11	; 17
   0FB8                      77 _level_palettes:
   0FB8 00                   78 	.db #0x00	; 0
   0FB9 09                   79 	.db #0x09	; 9
   0FBA 14                   80 	.db #0x14	; 20
   0FBB 0B                   81 	.db #0x0B	; 11
   0FBC 0A                   82 	.db #0x0A	; 10
   0FBD 0D                   83 	.db #0x0D	; 13
   0FBE 12                   84 	.db #0x12	; 18
   0FBF 03                   85 	.db #0x03	; 3
   0FC0 11                   86 	.db #0x11	; 17
   0FC1 0B                   87 	.db #0x0B	; 11
   0FC2 15                   88 	.db #0x15	; 21
   0FC3 14                   89 	.db #0x14	; 20
   0FC4 0A                   90 	.db #0x0A	; 10
   0FC5 10                   91 	.db #0x10	; 16
   0FC6 03                   92 	.db #0x03	; 3
   0FC7 18                   93 	.db #0x18	; 24
   0FC8 19                   94 	.db #0x19	; 25
   0FC9 11                   95 	.db #0x11	; 17
   0FCA 01                   96 	.db #0x01	; 1
   0FCB 0B                   97 	.db #0x0B	; 11
   0FCC 19                   98 	.db #0x19	; 25
   0FCD 18                   99 	.db #0x18	; 24
   0FCE 10                  100 	.db #0x10	; 16
   0FCF 03                  101 	.db #0x03	; 3
   0FD0 02                  102 	.db #0x02	; 2
   0FD1 12                  103 	.db #0x12	; 18
   0FD2 11                  104 	.db #0x11	; 17
   0FD3 0D                  105 	.db #0x0D	; 13
   0FD4 03                  106 	.db #0x03	; 3
   0FD5 19                  107 	.db #0x19	; 25
   0FD6 18                  108 	.db #0x18	; 24
   0FD7 1A                  109 	.db #0x1A	; 26
   0FD8 00                  110 	.db #0x00	; 0
   0FD9 00                  111 	.db #0x00	; 0
   0FDA 00                  112 	.db #0x00	; 0
   0FDB 11                  113 	.db #0x11	; 17
                            114 ;src/Level.c:27: void level_set_level(u8 l) {
                            115 ;	---------------------------------
                            116 ; Function level_set_level
                            117 ; ---------------------------------
   0FDC                     118 _level_set_level::
                            119 ;src/Level.c:28: current_level=l;
   0FDC 21 02 00      [10]  120 	ld	hl, #2+0
   0FDF 39            [11]  121 	add	hl, sp
   0FE0 7E            [ 7]  122 	ld	a, (hl)
   0FE1 32 62 7D      [13]  123 	ld	(#_current_level + 0),a
   0FE4 C9            [10]  124 	ret
                            125 ;src/Level.c:31: void level_init_palettes(){
                            126 ;	---------------------------------
                            127 ; Function level_init_palettes
                            128 ; ---------------------------------
   0FE5                     129 _level_init_palettes::
                            130 ;src/Level.c:32: cpct_fw2hw(level_palettes[0],VARIABLE_COLORS);
   0FE5 21 09 00      [10]  131 	ld	hl,#0x0009
   0FE8 E5            [11]  132 	push	hl
   0FE9 21 B8 0F      [10]  133 	ld	hl,#_level_palettes
   0FEC E5            [11]  134 	push	hl
   0FED CD 2A 7A      [17]  135 	call	_cpct_fw2hw
                            136 ;src/Level.c:33: cpct_fw2hw(level_palettes[1],VARIABLE_COLORS);
   0FF0 21 09 00      [10]  137 	ld	hl,#0x0009
   0FF3 E5            [11]  138 	push	hl
   0FF4 21 C1 0F      [10]  139 	ld	hl,#(_level_palettes + 0x0009)
   0FF7 E5            [11]  140 	push	hl
   0FF8 CD 2A 7A      [17]  141 	call	_cpct_fw2hw
                            142 ;src/Level.c:34: cpct_fw2hw(level_palettes[2],VARIABLE_COLORS);
   0FFB 21 09 00      [10]  143 	ld	hl,#0x0009
   0FFE E5            [11]  144 	push	hl
   0FFF 21 CA 0F      [10]  145 	ld	hl,#(_level_palettes + 0x0012)
   1002 E5            [11]  146 	push	hl
   1003 CD 2A 7A      [17]  147 	call	_cpct_fw2hw
                            148 ;src/Level.c:35: cpct_fw2hw(level_palettes[3],VARIABLE_COLORS);
   1006 21 09 00      [10]  149 	ld	hl,#0x0009
   1009 E5            [11]  150 	push	hl
   100A 21 D3 0F      [10]  151 	ld	hl,#(_level_palettes + 0x001b)
   100D E5            [11]  152 	push	hl
   100E CD 2A 7A      [17]  153 	call	_cpct_fw2hw
                            154 ;src/Level.c:36: cpct_fw2hw(menu_palette,VARIABLE_COLORS);
   1011 21 09 00      [10]  155 	ld	hl,#0x0009
   1014 E5            [11]  156 	push	hl
   1015 21 AF 0F      [10]  157 	ld	hl,#_menu_palette
   1018 E5            [11]  158 	push	hl
   1019 CD 2A 7A      [17]  159 	call	_cpct_fw2hw
   101C C9            [10]  160 	ret
                            161 ;src/Level.c:39: void setMenuPalette(){
                            162 ;	---------------------------------
                            163 ; Function setMenuPalette
                            164 ; ---------------------------------
   101D                     165 _setMenuPalette::
                            166 ;src/Level.c:40: cpct_memcpy(g_palette+SHARED_COLORS, menu_palette,VARIABLE_COLORS);
   101D 21 09 00      [10]  167 	ld	hl,#0x0009
   1020 E5            [11]  168 	push	hl
   1021 21 AF 0F      [10]  169 	ld	hl,#_menu_palette
   1024 E5            [11]  170 	push	hl
   1025 21 5D 1A      [10]  171 	ld	hl,#(_g_palette + 0x0007)
   1028 E5            [11]  172 	push	hl
   1029 CD 6C 7B      [17]  173 	call	_cpct_memcpy
                            174 ;src/Level.c:41: cpct_setPalette(g_palette,16);
   102C 21 10 00      [10]  175 	ld	hl,#0x0010
   102F E5            [11]  176 	push	hl
   1030 21 56 1A      [10]  177 	ld	hl,#_g_palette
   1033 E5            [11]  178 	push	hl
   1034 CD 4B 79      [17]  179 	call	_cpct_setPalette
   1037 C9            [10]  180 	ret
                            181 ;src/Level.c:44: void setLevelPalette(u8 i){
                            182 ;	---------------------------------
                            183 ; Function setLevelPalette
                            184 ; ---------------------------------
   1038                     185 _setLevelPalette::
   1038 DD E5         [15]  186 	push	ix
   103A DD 21 00 00   [14]  187 	ld	ix,#0
   103E DD 39         [15]  188 	add	ix,sp
                            189 ;src/Level.c:45: cpct_memcpy(g_palette+SHARED_COLORS, level_palettes[i],VARIABLE_COLORS);
   1040 01 B8 0F      [10]  190 	ld	bc,#_level_palettes+0
   1043 DD 5E 04      [19]  191 	ld	e,4 (ix)
   1046 16 00         [ 7]  192 	ld	d,#0x00
   1048 6B            [ 4]  193 	ld	l, e
   1049 62            [ 4]  194 	ld	h, d
   104A 29            [11]  195 	add	hl, hl
   104B 29            [11]  196 	add	hl, hl
   104C 29            [11]  197 	add	hl, hl
   104D 19            [11]  198 	add	hl, de
   104E 09            [11]  199 	add	hl,bc
   104F 4D            [ 4]  200 	ld	c,l
   1050 44            [ 4]  201 	ld	b,h
   1051 21 09 00      [10]  202 	ld	hl,#0x0009
   1054 E5            [11]  203 	push	hl
   1055 C5            [11]  204 	push	bc
   1056 21 5D 1A      [10]  205 	ld	hl,#(_g_palette + 0x0007)
   1059 E5            [11]  206 	push	hl
   105A CD 6C 7B      [17]  207 	call	_cpct_memcpy
                            208 ;src/Level.c:46: cpct_setPalette(g_palette,16);
   105D 21 10 00      [10]  209 	ld	hl,#0x0010
   1060 E5            [11]  210 	push	hl
   1061 21 56 1A      [10]  211 	ld	hl,#_g_palette
   1064 E5            [11]  212 	push	hl
   1065 CD 4B 79      [17]  213 	call	_cpct_setPalette
   1068 DD E1         [14]  214 	pop	ix
   106A C9            [10]  215 	ret
                            216 ;src/Level.c:49: void level_load_level(){
                            217 ;	---------------------------------
                            218 ; Function level_load_level
                            219 ; ---------------------------------
   106B                     220 _level_load_level::
                            221 ;src/Level.c:50: u8 index=current_level>>3;
   106B 21 62 7D      [10]  222 	ld	hl,#_current_level + 0
   106E 46            [ 7]  223 	ld	b, (hl)
   106F CB 38         [ 8]  224 	srl	b
   1071 CB 38         [ 8]  225 	srl	b
   1073 CB 38         [ 8]  226 	srl	b
                            227 ;src/Level.c:53: enemIndex = index;
   1075 48            [ 4]  228 	ld	c,b
                            229 ;src/Level.c:55: if(current_level==KING_LEVEL) index = 3;
   1076 3A 62 7D      [13]  230 	ld	a,(#_current_level + 0)
   1079 D6 20         [ 7]  231 	sub	a, #0x20
   107B 20 02         [12]  232 	jr	NZ,00102$
   107D 06 03         [ 7]  233 	ld	b,#0x03
   107F                     234 00102$:
                            235 ;src/Level.c:58: uncompress_theme_textures(index);
   107F C5            [11]  236 	push	bc
   1080 C5            [11]  237 	push	bc
   1081 33            [ 6]  238 	inc	sp
   1082 CD 7F 41      [17]  239 	call	_uncompress_theme_textures
   1085 33            [ 6]  240 	inc	sp
   1086 C1            [10]  241 	pop	bc
                            242 ;src/Level.c:59: uncompress_enemy_textures(enemIndex);
   1087 C5            [11]  243 	push	bc
   1088 79            [ 4]  244 	ld	a,c
   1089 F5            [11]  245 	push	af
   108A 33            [ 6]  246 	inc	sp
   108B CD AE 41      [17]  247 	call	_uncompress_enemy_textures
   108E 33            [ 6]  248 	inc	sp
   108F CD 21 42      [17]  249 	call	_uncompress_item_textures
   1092 33            [ 6]  250 	inc	sp
   1093 CD 38 10      [17]  251 	call	_setLevelPalette
   1096 33            [ 6]  252 	inc	sp
   1097 C9            [10]  253 	ret
                            254 	.area _CODE
                            255 	.area _INITIALIZER
                            256 	.area _CABS (ABS)
