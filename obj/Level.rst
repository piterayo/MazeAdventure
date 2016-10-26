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
   8702                      32 _current_level::
   8702                      33 	.ds 1
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
   1159                      62 _level_get_level::
                             63 ;src/Level.c:24: return current_level;
   1159 FD 21 02 87   [14]   64 	ld	iy,#_current_level
   115D FD 6E 00      [19]   65 	ld	l,0 (iy)
   1160 C9            [10]   66 	ret
   1161                      67 _menu_palette:
   1161 01                   68 	.db #0x01	; 1
   1162 02                   69 	.db #0x02	; 2
   1163 18                   70 	.db #0x18	; 24
   1164 12                   71 	.db #0x12	; 18
   1165 15                   72 	.db #0x15	; 21
   1166 10                   73 	.db #0x10	; 16
   1167 03                   74 	.db #0x03	; 3
   1168 00                   75 	.db #0x00	; 0
   1169 11                   76 	.db #0x11	; 17
   116A                      77 _level_palettes:
   116A 00                   78 	.db #0x00	; 0
   116B 09                   79 	.db #0x09	; 9
   116C 14                   80 	.db #0x14	; 20
   116D 0B                   81 	.db #0x0B	; 11
   116E 0A                   82 	.db #0x0A	; 10
   116F 0D                   83 	.db #0x0D	; 13
   1170 12                   84 	.db #0x12	; 18
   1171 03                   85 	.db #0x03	; 3
   1172 11                   86 	.db #0x11	; 17
   1173 0B                   87 	.db #0x0B	; 11
   1174 15                   88 	.db #0x15	; 21
   1175 14                   89 	.db #0x14	; 20
   1176 0A                   90 	.db #0x0A	; 10
   1177 10                   91 	.db #0x10	; 16
   1178 03                   92 	.db #0x03	; 3
   1179 18                   93 	.db #0x18	; 24
   117A 19                   94 	.db #0x19	; 25
   117B 11                   95 	.db #0x11	; 17
   117C 01                   96 	.db #0x01	; 1
   117D 0B                   97 	.db #0x0B	; 11
   117E 19                   98 	.db #0x19	; 25
   117F 18                   99 	.db #0x18	; 24
   1180 10                  100 	.db #0x10	; 16
   1181 03                  101 	.db #0x03	; 3
   1182 02                  102 	.db #0x02	; 2
   1183 12                  103 	.db #0x12	; 18
   1184 11                  104 	.db #0x11	; 17
   1185 0D                  105 	.db #0x0D	; 13
   1186 03                  106 	.db #0x03	; 3
   1187 19                  107 	.db #0x19	; 25
   1188 18                  108 	.db #0x18	; 24
   1189 1A                  109 	.db #0x1A	; 26
   118A 00                  110 	.db #0x00	; 0
   118B 00                  111 	.db #0x00	; 0
   118C 00                  112 	.db #0x00	; 0
   118D 11                  113 	.db #0x11	; 17
                            114 ;src/Level.c:27: void level_set_level(u8 l) {
                            115 ;	---------------------------------
                            116 ; Function level_set_level
                            117 ; ---------------------------------
   118E                     118 _level_set_level::
                            119 ;src/Level.c:28: current_level=l;
   118E 21 02 00      [10]  120 	ld	hl, #2+0
   1191 39            [11]  121 	add	hl, sp
   1192 7E            [ 7]  122 	ld	a, (hl)
   1193 32 02 87      [13]  123 	ld	(#_current_level + 0),a
   1196 C9            [10]  124 	ret
                            125 ;src/Level.c:31: void level_init_palettes(){
                            126 ;	---------------------------------
                            127 ; Function level_init_palettes
                            128 ; ---------------------------------
   1197                     129 _level_init_palettes::
                            130 ;src/Level.c:32: cpct_fw2hw(level_palettes[0],VARIABLE_COLORS);
   1197 21 09 00      [10]  131 	ld	hl,#0x0009
   119A E5            [11]  132 	push	hl
   119B 21 6A 11      [10]  133 	ld	hl,#_level_palettes
   119E E5            [11]  134 	push	hl
   119F CD C7 83      [17]  135 	call	_cpct_fw2hw
                            136 ;src/Level.c:33: cpct_fw2hw(level_palettes[1],VARIABLE_COLORS);
   11A2 21 09 00      [10]  137 	ld	hl,#0x0009
   11A5 E5            [11]  138 	push	hl
   11A6 21 73 11      [10]  139 	ld	hl,#(_level_palettes + 0x0009)
   11A9 E5            [11]  140 	push	hl
   11AA CD C7 83      [17]  141 	call	_cpct_fw2hw
                            142 ;src/Level.c:34: cpct_fw2hw(level_palettes[2],VARIABLE_COLORS);
   11AD 21 09 00      [10]  143 	ld	hl,#0x0009
   11B0 E5            [11]  144 	push	hl
   11B1 21 7C 11      [10]  145 	ld	hl,#(_level_palettes + 0x0012)
   11B4 E5            [11]  146 	push	hl
   11B5 CD C7 83      [17]  147 	call	_cpct_fw2hw
                            148 ;src/Level.c:35: cpct_fw2hw(level_palettes[3],VARIABLE_COLORS);
   11B8 21 09 00      [10]  149 	ld	hl,#0x0009
   11BB E5            [11]  150 	push	hl
   11BC 21 85 11      [10]  151 	ld	hl,#(_level_palettes + 0x001b)
   11BF E5            [11]  152 	push	hl
   11C0 CD C7 83      [17]  153 	call	_cpct_fw2hw
                            154 ;src/Level.c:36: cpct_fw2hw(menu_palette,VARIABLE_COLORS);
   11C3 21 09 00      [10]  155 	ld	hl,#0x0009
   11C6 E5            [11]  156 	push	hl
   11C7 21 61 11      [10]  157 	ld	hl,#_menu_palette
   11CA E5            [11]  158 	push	hl
   11CB CD C7 83      [17]  159 	call	_cpct_fw2hw
   11CE C9            [10]  160 	ret
                            161 ;src/Level.c:39: void setMenuPalette(){
                            162 ;	---------------------------------
                            163 ; Function setMenuPalette
                            164 ; ---------------------------------
   11CF                     165 _setMenuPalette::
                            166 ;src/Level.c:40: cpct_memcpy(g_palette+SHARED_COLORS, menu_palette,VARIABLE_COLORS);
   11CF 21 09 00      [10]  167 	ld	hl,#0x0009
   11D2 E5            [11]  168 	push	hl
   11D3 21 61 11      [10]  169 	ld	hl,#_menu_palette
   11D6 E5            [11]  170 	push	hl
   11D7 21 1F 1C      [10]  171 	ld	hl,#(_g_palette + 0x0007)
   11DA E5            [11]  172 	push	hl
   11DB CD 09 85      [17]  173 	call	_cpct_memcpy
                            174 ;src/Level.c:41: cpct_setPalette(g_palette,16);
   11DE 21 10 00      [10]  175 	ld	hl,#0x0010
   11E1 E5            [11]  176 	push	hl
   11E2 21 18 1C      [10]  177 	ld	hl,#_g_palette
   11E5 E5            [11]  178 	push	hl
   11E6 CD BF 7A      [17]  179 	call	_cpct_setPalette
   11E9 C9            [10]  180 	ret
                            181 ;src/Level.c:44: void setLevelPalette(u8 i){
                            182 ;	---------------------------------
                            183 ; Function setLevelPalette
                            184 ; ---------------------------------
   11EA                     185 _setLevelPalette::
   11EA DD E5         [15]  186 	push	ix
   11EC DD 21 00 00   [14]  187 	ld	ix,#0
   11F0 DD 39         [15]  188 	add	ix,sp
                            189 ;src/Level.c:45: cpct_memcpy(g_palette+SHARED_COLORS, level_palettes[i],VARIABLE_COLORS);
   11F2 01 6A 11      [10]  190 	ld	bc,#_level_palettes+0
   11F5 DD 5E 04      [19]  191 	ld	e,4 (ix)
   11F8 16 00         [ 7]  192 	ld	d,#0x00
   11FA 6B            [ 4]  193 	ld	l, e
   11FB 62            [ 4]  194 	ld	h, d
   11FC 29            [11]  195 	add	hl, hl
   11FD 29            [11]  196 	add	hl, hl
   11FE 29            [11]  197 	add	hl, hl
   11FF 19            [11]  198 	add	hl, de
   1200 09            [11]  199 	add	hl,bc
   1201 4D            [ 4]  200 	ld	c,l
   1202 44            [ 4]  201 	ld	b,h
   1203 21 09 00      [10]  202 	ld	hl,#0x0009
   1206 E5            [11]  203 	push	hl
   1207 C5            [11]  204 	push	bc
   1208 21 1F 1C      [10]  205 	ld	hl,#(_g_palette + 0x0007)
   120B E5            [11]  206 	push	hl
   120C CD 09 85      [17]  207 	call	_cpct_memcpy
                            208 ;src/Level.c:46: cpct_setPalette(g_palette,16);
   120F 21 10 00      [10]  209 	ld	hl,#0x0010
   1212 E5            [11]  210 	push	hl
   1213 21 18 1C      [10]  211 	ld	hl,#_g_palette
   1216 E5            [11]  212 	push	hl
   1217 CD BF 7A      [17]  213 	call	_cpct_setPalette
   121A DD E1         [14]  214 	pop	ix
   121C C9            [10]  215 	ret
                            216 ;src/Level.c:49: void level_load_level(){
                            217 ;	---------------------------------
                            218 ; Function level_load_level
                            219 ; ---------------------------------
   121D                     220 _level_load_level::
                            221 ;src/Level.c:50: u8 index=current_level>>3;
   121D 21 02 87      [10]  222 	ld	hl,#_current_level + 0
   1220 46            [ 7]  223 	ld	b, (hl)
   1221 CB 38         [ 8]  224 	srl	b
   1223 CB 38         [ 8]  225 	srl	b
   1225 CB 38         [ 8]  226 	srl	b
                            227 ;src/Level.c:53: enemIndex = index;
   1227 48            [ 4]  228 	ld	c,b
                            229 ;src/Level.c:55: if(current_level==KING_LEVEL) index = 3;
   1228 3A 02 87      [13]  230 	ld	a,(#_current_level + 0)
   122B D6 20         [ 7]  231 	sub	a, #0x20
   122D 20 02         [12]  232 	jr	NZ,00102$
   122F 06 03         [ 7]  233 	ld	b,#0x03
   1231                     234 00102$:
                            235 ;src/Level.c:58: uncompress_theme_textures(index);
   1231 C5            [11]  236 	push	bc
   1232 C5            [11]  237 	push	bc
   1233 33            [ 6]  238 	inc	sp
   1234 CD F3 42      [17]  239 	call	_uncompress_theme_textures
   1237 33            [ 6]  240 	inc	sp
   1238 C1            [10]  241 	pop	bc
                            242 ;src/Level.c:59: uncompress_enemy_textures(enemIndex);
   1239 C5            [11]  243 	push	bc
   123A 79            [ 4]  244 	ld	a,c
   123B F5            [11]  245 	push	af
   123C 33            [ 6]  246 	inc	sp
   123D CD 22 43      [17]  247 	call	_uncompress_enemy_textures
   1240 33            [ 6]  248 	inc	sp
   1241 CD 95 43      [17]  249 	call	_uncompress_item_textures
   1244 33            [ 6]  250 	inc	sp
   1245 CD EA 11      [17]  251 	call	_setLevelPalette
   1248 33            [ 6]  252 	inc	sp
   1249 C9            [10]  253 	ret
                            254 	.area _CODE
                            255 	.area _INITIALIZER
                            256 	.area _CABS (ABS)
