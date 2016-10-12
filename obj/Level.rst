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
   4178                      30 _current_level::
   4178                      31 	.ds 1
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
   00CF                      60 _level_get_level::
                             61 ;src/Level.c:20: return current_level;
   00CF FD 21 78 41   [14]   62 	ld	iy,#_current_level
   00D3 FD 6E 00      [19]   63 	ld	l,0 (iy)
   00D6 C9            [10]   64 	ret
   00D7                      65 _level_palettes:
   00D7 00                   66 	.db #0x00	; 0
   00D8 09                   67 	.db #0x09	; 9
   00D9 03                   68 	.db #0x03	; 3
   00DA 12                   69 	.db #0x12	; 18
   00DB 0A                   70 	.db #0x0A	; 10
   00DC 14                   71 	.db #0x14	; 20
   00DD 00                   72 	.db #0x00	; 0
   00DE 04                   73 	.db #0x04	; 4
   00DF 11                   74 	.db #0x11	; 17
   00E0 0E                   75 	.db #0x0E	; 14
   00E1 0B                   76 	.db #0x0B	; 11
   00E2 15                   77 	.db #0x15	; 21
   00E3 03                   78 	.db #0x03	; 3
   00E4 09                   79 	.db #0x09	; 9
   00E5 19                   80 	.db #0x19	; 25
   00E6 0F                   81 	.db #0x0F	; 15
   00E7 01                   82 	.db #0x01	; 1
   00E8 02                   83 	.db #0x02	; 2
   00E9 11                   84 	.db #0x11	; 17
   00EA 0E                   85 	.db #0x0E	; 14
   00EB 00                   86 	.db #0x00	; 0
   00EC 00                   87 	.db #0x00	; 0
   00ED 00                   88 	.db #0x00	; 0
   00EE 00                   89 	.db #0x00	; 0
   00EF 00                   90 	.db #0x00	; 0
   00F0 00                   91 	.db #0x00	; 0
   00F1 00                   92 	.db #0x00	; 0
   00F2 00                   93 	.db #0x00	; 0
   00F3 00                   94 	.db #0x00	; 0
   00F4 00                   95 	.db #0x00	; 0
   00F5 00                   96 	.db #0x00	; 0
   00F6 00                   97 	.db #0x00	; 0
   00F7 00                   98 	.db #0x00	; 0
   00F8 00                   99 	.db #0x00	; 0
   00F9 00                  100 	.db #0x00	; 0
   00FA 00                  101 	.db #0x00	; 0
   00FB 00                  102 	.db #0x00	; 0
   00FC 00                  103 	.db #0x00	; 0
   00FD 00                  104 	.db #0x00	; 0
   00FE 00                  105 	.db #0x00	; 0
                            106 ;src/Level.c:23: void level_set_level(u8 l){
                            107 ;	---------------------------------
                            108 ; Function level_set_level
                            109 ; ---------------------------------
   00FF                     110 _level_set_level::
                            111 ;src/Level.c:24: current_level=l;
   00FF 21 02 00      [10]  112 	ld	hl, #2+0
   0102 39            [11]  113 	add	hl, sp
   0103 7E            [ 7]  114 	ld	a, (hl)
   0104 32 78 41      [13]  115 	ld	(#_current_level + 0),a
   0107 C9            [10]  116 	ret
                            117 ;src/Level.c:27: void level_init_palettes(){
                            118 ;	---------------------------------
                            119 ; Function level_init_palettes
                            120 ; ---------------------------------
   0108                     121 _level_init_palettes::
                            122 ;src/Level.c:28: cpct_fw2hw(level_palettes[0],VARIABLE_COLORS);
   0108 21 0A 00      [10]  123 	ld	hl,#0x000A
   010B E5            [11]  124 	push	hl
   010C 21 D7 00      [10]  125 	ld	hl,#_level_palettes
   010F E5            [11]  126 	push	hl
   0110 CD A0 3E      [17]  127 	call	_cpct_fw2hw
                            128 ;src/Level.c:29: cpct_fw2hw(level_palettes[1],VARIABLE_COLORS);
   0113 21 0A 00      [10]  129 	ld	hl,#0x000A
   0116 E5            [11]  130 	push	hl
   0117 21 E1 00      [10]  131 	ld	hl,#(_level_palettes + 0x000a)
   011A E5            [11]  132 	push	hl
   011B CD A0 3E      [17]  133 	call	_cpct_fw2hw
                            134 ;src/Level.c:30: cpct_fw2hw(level_palettes[2],VARIABLE_COLORS);
   011E 21 0A 00      [10]  135 	ld	hl,#0x000A
   0121 E5            [11]  136 	push	hl
   0122 21 EB 00      [10]  137 	ld	hl,#(_level_palettes + 0x0014)
   0125 E5            [11]  138 	push	hl
   0126 CD A0 3E      [17]  139 	call	_cpct_fw2hw
                            140 ;src/Level.c:31: cpct_fw2hw(level_palettes[3],VARIABLE_COLORS);
   0129 21 0A 00      [10]  141 	ld	hl,#0x000A
   012C E5            [11]  142 	push	hl
   012D 21 F5 00      [10]  143 	ld	hl,#(_level_palettes + 0x001e)
   0130 E5            [11]  144 	push	hl
   0131 CD A0 3E      [17]  145 	call	_cpct_fw2hw
   0134 C9            [10]  146 	ret
                            147 ;src/Level.c:34: void setLevelPalette(u8 i){
                            148 ;	---------------------------------
                            149 ; Function setLevelPalette
                            150 ; ---------------------------------
   0135                     151 _setLevelPalette::
   0135 DD E5         [15]  152 	push	ix
   0137 DD 21 00 00   [14]  153 	ld	ix,#0
   013B DD 39         [15]  154 	add	ix,sp
                            155 ;src/Level.c:35: cpct_memcpy(g_palette+SHARED_COLORS, level_palettes[i],VARIABLE_COLORS);
   013D 01 D7 00      [10]  156 	ld	bc,#_level_palettes+0
   0140 DD 5E 04      [19]  157 	ld	e,4 (ix)
   0143 16 00         [ 7]  158 	ld	d,#0x00
   0145 6B            [ 4]  159 	ld	l, e
   0146 62            [ 4]  160 	ld	h, d
   0147 29            [11]  161 	add	hl, hl
   0148 29            [11]  162 	add	hl, hl
   0149 19            [11]  163 	add	hl, de
   014A 29            [11]  164 	add	hl, hl
   014B 09            [11]  165 	add	hl,bc
   014C 4D            [ 4]  166 	ld	c,l
   014D 44            [ 4]  167 	ld	b,h
   014E 21 0A 00      [10]  168 	ld	hl,#0x000A
   0151 E5            [11]  169 	push	hl
   0152 C5            [11]  170 	push	bc
   0153 21 9B 0A      [10]  171 	ld	hl,#(_g_palette + 0x0006)
   0156 E5            [11]  172 	push	hl
   0157 CD 55 3F      [17]  173 	call	_cpct_memcpy
                            174 ;src/Level.c:36: cpct_setPalette(g_palette,16);
   015A 21 10 00      [10]  175 	ld	hl,#0x0010
   015D E5            [11]  176 	push	hl
   015E 21 95 0A      [10]  177 	ld	hl,#_g_palette
   0161 E5            [11]  178 	push	hl
   0162 CD BC 3D      [17]  179 	call	_cpct_setPalette
   0165 DD E1         [14]  180 	pop	ix
   0167 C9            [10]  181 	ret
                            182 ;src/Level.c:39: void level_load_level(){
                            183 ;	---------------------------------
                            184 ; Function level_load_level
                            185 ; ---------------------------------
   0168                     186 _level_load_level::
                            187 ;src/Level.c:42: index =((current_level<8)?0:(
   0168 3A 78 41      [13]  188 	ld	a,(#_current_level + 0)
   016B D6 08         [ 7]  189 	sub	a, #0x08
   016D 30 04         [12]  190 	jr	NC,00103$
   016F 06 00         [ 7]  191 	ld	b,#0x00
   0171 18 23         [12]  192 	jr	00104$
   0173                     193 00103$:
                            194 ;src/Level.c:43: (current_level<24)?1:(
   0173 3A 78 41      [13]  195 	ld	a,(#_current_level + 0)
   0176 D6 18         [ 7]  196 	sub	a, #0x18
   0178 30 04         [12]  197 	jr	NC,00105$
   017A 06 01         [ 7]  198 	ld	b,#0x01
   017C 18 18         [12]  199 	jr	00106$
   017E                     200 00105$:
                            201 ;src/Level.c:44: (current_level<56)?2:(
   017E 3A 78 41      [13]  202 	ld	a,(#_current_level + 0)
   0181 D6 38         [ 7]  203 	sub	a, #0x38
   0183 30 04         [12]  204 	jr	NC,00107$
   0185 06 02         [ 7]  205 	ld	b,#0x02
   0187 18 0D         [12]  206 	jr	00108$
   0189                     207 00107$:
                            208 ;src/Level.c:45: (current_level<120)?4:0
   0189 3A 78 41      [13]  209 	ld	a,(#_current_level + 0)
   018C D6 78         [ 7]  210 	sub	a, #0x78
   018E 30 04         [12]  211 	jr	NC,00109$
   0190 06 04         [ 7]  212 	ld	b,#0x04
   0192 18 02         [12]  213 	jr	00110$
   0194                     214 00109$:
   0194 06 00         [ 7]  215 	ld	b,#0x00
   0196                     216 00110$:
   0196                     217 00108$:
   0196                     218 00106$:
   0196                     219 00104$:
                            220 ;src/Level.c:48: uncompress_theme_textures(index);
   0196 C5            [11]  221 	push	bc
   0197 C5            [11]  222 	push	bc
   0198 33            [ 6]  223 	inc	sp
   0199 CD 76 1E      [17]  224 	call	_uncompress_theme_textures
   019C 33            [ 6]  225 	inc	sp
   019D C1            [10]  226 	pop	bc
                            227 ;src/Level.c:49: uncompress_enemy_textures(index);
   019E C5            [11]  228 	push	bc
   019F C5            [11]  229 	push	bc
   01A0 33            [ 6]  230 	inc	sp
   01A1 CD 21 1F      [17]  231 	call	_uncompress_enemy_textures
   01A4 33            [ 6]  232 	inc	sp
   01A5 33            [ 6]  233 	inc	sp
   01A6 CD 35 01      [17]  234 	call	_setLevelPalette
   01A9 33            [ 6]  235 	inc	sp
   01AA C9            [10]  236 	ret
                            237 	.area _CODE
                            238 	.area _INITIALIZER
                            239 	.area _CABS (ABS)
