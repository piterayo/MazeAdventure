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
                             12 	.globl _uncompress_enemy_textures
                             13 	.globl _uncompress_theme_textures
                             14 	.globl _cpct_setPalette
                             15 	.globl _cpct_fw2hw
                             16 	.globl _cpct_memcpy
                             17 	.globl _current_level
                             18 	.globl _level_palettes
                             19 	.globl _level_get_level
                             20 	.globl _level_set_level
                             21 	.globl _level_init_palettes
                             22 	.globl _level_load_level
                             23 ;--------------------------------------------------------
                             24 ; special function registers
                             25 ;--------------------------------------------------------
                             26 ;--------------------------------------------------------
                             27 ; ram data
                             28 ;--------------------------------------------------------
                             29 	.area _DATA
   4AA8                      30 _current_level::
   4AA8                      31 	.ds 1
                             32 ;--------------------------------------------------------
                             33 ; ram data
                             34 ;--------------------------------------------------------
                             35 	.area _INITIALIZED
                             36 ;--------------------------------------------------------
                             37 ; absolute external ram data
                             38 ;--------------------------------------------------------
                             39 	.area _DABS (ABS)
                             40 ;--------------------------------------------------------
                             41 ; global & static initialisations
                             42 ;--------------------------------------------------------
                             43 	.area _HOME
                             44 	.area _GSINIT
                             45 	.area _GSFINAL
                             46 	.area _GSINIT
                             47 ;--------------------------------------------------------
                             48 ; Home
                             49 ;--------------------------------------------------------
                             50 	.area _HOME
                             51 	.area _HOME
                             52 ;--------------------------------------------------------
                             53 ; code
                             54 ;--------------------------------------------------------
                             55 	.area _CODE
                             56 ;src/Level.c:19: u8 level_get_level(){
                             57 ;	---------------------------------
                             58 ; Function level_get_level
                             59 ; ---------------------------------
   00B5                      60 _level_get_level::
                             61 ;src/Level.c:20: return current_level;
   00B5 FD 21 A8 4A   [14]   62 	ld	iy,#_current_level
   00B9 FD 6E 00      [19]   63 	ld	l,0 (iy)
   00BC C9            [10]   64 	ret
   00BD                      65 _level_palettes:
   00BD 00                   66 	.db #0x00	; 0
   00BE 09                   67 	.db #0x09	; 9
   00BF 03                   68 	.db #0x03	; 3
   00C0 12                   69 	.db #0x12	; 18
   00C1 0A                   70 	.db #0x0A	; 10
   00C2 14                   71 	.db #0x14	; 20
   00C3 00                   72 	.db #0x00	; 0
   00C4 04                   73 	.db #0x04	; 4
   00C5 11                   74 	.db #0x11	; 17
   00C6 0E                   75 	.db #0x0E	; 14
   00C7 0B                   76 	.db #0x0B	; 11
   00C8 15                   77 	.db #0x15	; 21
   00C9 03                   78 	.db #0x03	; 3
   00CA 09                   79 	.db #0x09	; 9
   00CB 19                   80 	.db #0x19	; 25
   00CC 0F                   81 	.db #0x0F	; 15
   00CD 01                   82 	.db #0x01	; 1
   00CE 02                   83 	.db #0x02	; 2
   00CF 11                   84 	.db #0x11	; 17
   00D0 0E                   85 	.db #0x0E	; 14
   00D1 00                   86 	.db #0x00	; 0
   00D2 00                   87 	.db #0x00	; 0
   00D3 00                   88 	.db #0x00	; 0
   00D4 00                   89 	.db #0x00	; 0
   00D5 00                   90 	.db #0x00	; 0
   00D6 00                   91 	.db #0x00	; 0
   00D7 00                   92 	.db #0x00	; 0
   00D8 00                   93 	.db #0x00	; 0
   00D9 00                   94 	.db #0x00	; 0
   00DA 00                   95 	.db #0x00	; 0
   00DB 00                   96 	.db #0x00	; 0
   00DC 00                   97 	.db #0x00	; 0
   00DD 00                   98 	.db #0x00	; 0
   00DE 00                   99 	.db #0x00	; 0
   00DF 00                  100 	.db #0x00	; 0
   00E0 00                  101 	.db #0x00	; 0
   00E1 00                  102 	.db #0x00	; 0
   00E2 00                  103 	.db #0x00	; 0
   00E3 00                  104 	.db #0x00	; 0
   00E4 00                  105 	.db #0x00	; 0
                            106 ;src/Level.c:23: void level_set_level(u8 l){
                            107 ;	---------------------------------
                            108 ; Function level_set_level
                            109 ; ---------------------------------
   00E5                     110 _level_set_level::
                            111 ;src/Level.c:24: current_level=l;
   00E5 21 02 00      [10]  112 	ld	hl, #2+0
   00E8 39            [11]  113 	add	hl, sp
   00E9 7E            [ 7]  114 	ld	a, (hl)
   00EA 32 A8 4A      [13]  115 	ld	(#_current_level + 0),a
   00ED C9            [10]  116 	ret
                            117 ;src/Level.c:27: void level_init_palettes(){
                            118 ;	---------------------------------
                            119 ; Function level_init_palettes
                            120 ; ---------------------------------
   00EE                     121 _level_init_palettes::
                            122 ;src/Level.c:28: cpct_fw2hw(level_palettes[0],VARIABLE_COLORS);
   00EE 21 0A 00      [10]  123 	ld	hl,#0x000A
   00F1 E5            [11]  124 	push	hl
   00F2 21 BD 00      [10]  125 	ld	hl,#_level_palettes
   00F5 E5            [11]  126 	push	hl
   00F6 CD 29 48      [17]  127 	call	_cpct_fw2hw
                            128 ;src/Level.c:29: cpct_fw2hw(level_palettes[1],VARIABLE_COLORS);
   00F9 21 0A 00      [10]  129 	ld	hl,#0x000A
   00FC E5            [11]  130 	push	hl
   00FD 21 C7 00      [10]  131 	ld	hl,#(_level_palettes + 0x000a)
   0100 E5            [11]  132 	push	hl
   0101 CD 29 48      [17]  133 	call	_cpct_fw2hw
                            134 ;src/Level.c:30: cpct_fw2hw(level_palettes[2],VARIABLE_COLORS);
   0104 21 0A 00      [10]  135 	ld	hl,#0x000A
   0107 E5            [11]  136 	push	hl
   0108 21 D1 00      [10]  137 	ld	hl,#(_level_palettes + 0x0014)
   010B E5            [11]  138 	push	hl
   010C CD 29 48      [17]  139 	call	_cpct_fw2hw
                            140 ;src/Level.c:31: cpct_fw2hw(level_palettes[3],VARIABLE_COLORS);
   010F 21 0A 00      [10]  141 	ld	hl,#0x000A
   0112 E5            [11]  142 	push	hl
   0113 21 DB 00      [10]  143 	ld	hl,#(_level_palettes + 0x001e)
   0116 E5            [11]  144 	push	hl
   0117 CD 29 48      [17]  145 	call	_cpct_fw2hw
   011A C9            [10]  146 	ret
                            147 ;src/Level.c:34: void setLevelPalette(u8 i){
                            148 ;	---------------------------------
                            149 ; Function setLevelPalette
                            150 ; ---------------------------------
   011B                     151 _setLevelPalette::
   011B DD E5         [15]  152 	push	ix
   011D DD 21 00 00   [14]  153 	ld	ix,#0
   0121 DD 39         [15]  154 	add	ix,sp
                            155 ;src/Level.c:35: cpct_memcpy(g_palette+SHARED_COLORS, level_palettes[i],VARIABLE_COLORS);
   0123 01 BD 00      [10]  156 	ld	bc,#_level_palettes+0
   0126 DD 5E 04      [19]  157 	ld	e,4 (ix)
   0129 16 00         [ 7]  158 	ld	d,#0x00
   012B 6B            [ 4]  159 	ld	l, e
   012C 62            [ 4]  160 	ld	h, d
   012D 29            [11]  161 	add	hl, hl
   012E 29            [11]  162 	add	hl, hl
   012F 19            [11]  163 	add	hl, de
   0130 29            [11]  164 	add	hl, hl
   0131 09            [11]  165 	add	hl,bc
   0132 4D            [ 4]  166 	ld	c,l
   0133 44            [ 4]  167 	ld	b,h
   0134 21 0A 00      [10]  168 	ld	hl,#0x000A
   0137 E5            [11]  169 	push	hl
   0138 C5            [11]  170 	push	bc
   0139 21 99 0A      [10]  171 	ld	hl,#(_g_palette + 0x0006)
   013C E5            [11]  172 	push	hl
   013D CD B3 48      [17]  173 	call	_cpct_memcpy
                            174 ;src/Level.c:36: cpct_setPalette(g_palette,16);
   0140 21 10 00      [10]  175 	ld	hl,#0x0010
   0143 E5            [11]  176 	push	hl
   0144 21 93 0A      [10]  177 	ld	hl,#_g_palette
   0147 E5            [11]  178 	push	hl
   0148 CD 04 47      [17]  179 	call	_cpct_setPalette
   014B DD E1         [14]  180 	pop	ix
   014D C9            [10]  181 	ret
                            182 ;src/Level.c:39: void level_load_level(){
                            183 ;	---------------------------------
                            184 ; Function level_load_level
                            185 ; ---------------------------------
   014E                     186 _level_load_level::
                            187 ;src/Level.c:42: index =((current_level<8)?0:(
   014E 3A A8 4A      [13]  188 	ld	a,(#_current_level + 0)
   0151 D6 08         [ 7]  189 	sub	a, #0x08
   0153 30 04         [12]  190 	jr	NC,00103$
   0155 06 00         [ 7]  191 	ld	b,#0x00
   0157 18 23         [12]  192 	jr	00104$
   0159                     193 00103$:
                            194 ;src/Level.c:43: (current_level<24)?1:(
   0159 3A A8 4A      [13]  195 	ld	a,(#_current_level + 0)
   015C D6 18         [ 7]  196 	sub	a, #0x18
   015E 30 04         [12]  197 	jr	NC,00105$
   0160 06 01         [ 7]  198 	ld	b,#0x01
   0162 18 18         [12]  199 	jr	00106$
   0164                     200 00105$:
                            201 ;src/Level.c:44: (current_level<56)?2:(
   0164 3A A8 4A      [13]  202 	ld	a,(#_current_level + 0)
   0167 D6 38         [ 7]  203 	sub	a, #0x38
   0169 30 04         [12]  204 	jr	NC,00107$
   016B 06 02         [ 7]  205 	ld	b,#0x02
   016D 18 0D         [12]  206 	jr	00108$
   016F                     207 00107$:
                            208 ;src/Level.c:45: (current_level<120)?4:0
   016F 3A A8 4A      [13]  209 	ld	a,(#_current_level + 0)
   0172 D6 78         [ 7]  210 	sub	a, #0x78
   0174 30 04         [12]  211 	jr	NC,00109$
   0176 06 04         [ 7]  212 	ld	b,#0x04
   0178 18 02         [12]  213 	jr	00110$
   017A                     214 00109$:
   017A 06 00         [ 7]  215 	ld	b,#0x00
   017C                     216 00110$:
   017C                     217 00108$:
   017C                     218 00106$:
   017C                     219 00104$:
                            220 ;src/Level.c:48: uncompress_theme_textures(index);
   017C C5            [11]  221 	push	bc
   017D C5            [11]  222 	push	bc
   017E 33            [ 6]  223 	inc	sp
   017F CD 7C 24      [17]  224 	call	_uncompress_theme_textures
   0182 33            [ 6]  225 	inc	sp
   0183 C1            [10]  226 	pop	bc
                            227 ;src/Level.c:49: uncompress_enemy_textures(index);
   0184 C5            [11]  228 	push	bc
   0185 C5            [11]  229 	push	bc
   0186 33            [ 6]  230 	inc	sp
   0187 CD 27 25      [17]  231 	call	_uncompress_enemy_textures
   018A 33            [ 6]  232 	inc	sp
   018B 33            [ 6]  233 	inc	sp
   018C CD 1B 01      [17]  234 	call	_setLevelPalette
   018F 33            [ 6]  235 	inc	sp
   0190 C9            [10]  236 	ret
                            237 	.area _CODE
                            238 	.area _INITIALIZER
                            239 	.area _CABS (ABS)
