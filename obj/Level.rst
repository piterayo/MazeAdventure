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
   4FA3                      30 _current_level::
   4FA3                      31 	.ds 1
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
   00BA                      60 _level_get_level::
                             61 ;src/Level.c:20: return current_level;
   00BA FD 21 A3 4F   [14]   62 	ld	iy,#_current_level
   00BE FD 6E 00      [19]   63 	ld	l,0 (iy)
   00C1 C9            [10]   64 	ret
   00C2                      65 _level_palettes:
   00C2 00                   66 	.db #0x00	; 0
   00C3 09                   67 	.db #0x09	; 9
   00C4 03                   68 	.db #0x03	; 3
   00C5 05                   69 	.db #0x05	; 5
   00C6 0A                   70 	.db #0x0A	; 10
   00C7 0E                   71 	.db #0x0E	; 14
   00C8 11                   72 	.db #0x11	; 17
   00C9 12                   73 	.db #0x12	; 18
   00CA 14                   74 	.db #0x14	; 20
   00CB 0B                   75 	.db #0x0B	; 11
   00CC 15                   76 	.db #0x15	; 21
   00CD 01                   77 	.db #0x01	; 1
   00CE 02                   78 	.db #0x02	; 2
   00CF 03                   79 	.db #0x03	; 3
   00D0 10                   80 	.db #0x10	; 16
   00D1 18                   81 	.db #0x18	; 24
   00D2 1A                   82 	.db #0x1A	; 26
   00D3 00                   83 	.db #0x00	; 0
   00D4 01                   84 	.db #0x01	; 1
   00D5 0D                   85 	.db #0x0D	; 13
   00D6 02                   86 	.db #0x02	; 2
   00D7 03                   87 	.db #0x03	; 3
   00D8 0B                   88 	.db #0x0B	; 11
   00D9 10                   89 	.db #0x10	; 16
   00DA 12                   90 	.db #0x12	; 18
   00DB 18                   91 	.db #0x18	; 24
   00DC 19                   92 	.db #0x19	; 25
   00DD 00                   93 	.db #0x00	; 0
   00DE 00                   94 	.db #0x00	; 0
   00DF 00                   95 	.db #0x00	; 0
   00E0 00                   96 	.db #0x00	; 0
   00E1 00                   97 	.db #0x00	; 0
   00E2 00                   98 	.db #0x00	; 0
   00E3 00                   99 	.db #0x00	; 0
   00E4 00                  100 	.db #0x00	; 0
   00E5 00                  101 	.db #0x00	; 0
                            102 ;src/Level.c:23: void level_set_level(u8 l) __z88dk_fastcall{
                            103 ;	---------------------------------
                            104 ; Function level_set_level
                            105 ; ---------------------------------
   00E6                     106 _level_set_level::
   00E6 FD 21 A3 4F   [14]  107 	ld	iy,#_current_level
   00EA FD 75 00      [19]  108 	ld	0 (iy),l
                            109 ;src/Level.c:24: current_level=l;
   00ED C9            [10]  110 	ret
                            111 ;src/Level.c:27: void level_init_palettes(){
                            112 ;	---------------------------------
                            113 ; Function level_init_palettes
                            114 ; ---------------------------------
   00EE                     115 _level_init_palettes::
                            116 ;src/Level.c:28: cpct_fw2hw(level_palettes[0],VARIABLE_COLORS);
   00EE 21 09 00      [10]  117 	ld	hl,#0x0009
   00F1 E5            [11]  118 	push	hl
   00F2 21 C2 00      [10]  119 	ld	hl,#_level_palettes
   00F5 E5            [11]  120 	push	hl
   00F6 CD D9 4C      [17]  121 	call	_cpct_fw2hw
                            122 ;src/Level.c:29: cpct_fw2hw(level_palettes[1],VARIABLE_COLORS);
   00F9 21 09 00      [10]  123 	ld	hl,#0x0009
   00FC E5            [11]  124 	push	hl
   00FD 21 CB 00      [10]  125 	ld	hl,#(_level_palettes + 0x0009)
   0100 E5            [11]  126 	push	hl
   0101 CD D9 4C      [17]  127 	call	_cpct_fw2hw
                            128 ;src/Level.c:30: cpct_fw2hw(level_palettes[2],VARIABLE_COLORS);
   0104 21 09 00      [10]  129 	ld	hl,#0x0009
   0107 E5            [11]  130 	push	hl
   0108 21 D4 00      [10]  131 	ld	hl,#(_level_palettes + 0x0012)
   010B E5            [11]  132 	push	hl
   010C CD D9 4C      [17]  133 	call	_cpct_fw2hw
                            134 ;src/Level.c:31: cpct_fw2hw(level_palettes[3],VARIABLE_COLORS);
   010F 21 09 00      [10]  135 	ld	hl,#0x0009
   0112 E5            [11]  136 	push	hl
   0113 21 DD 00      [10]  137 	ld	hl,#(_level_palettes + 0x001b)
   0116 E5            [11]  138 	push	hl
   0117 CD D9 4C      [17]  139 	call	_cpct_fw2hw
   011A C9            [10]  140 	ret
                            141 ;src/Level.c:34: void setLevelPalette(u8 i){
                            142 ;	---------------------------------
                            143 ; Function setLevelPalette
                            144 ; ---------------------------------
   011B                     145 _setLevelPalette::
   011B DD E5         [15]  146 	push	ix
   011D DD 21 00 00   [14]  147 	ld	ix,#0
   0121 DD 39         [15]  148 	add	ix,sp
                            149 ;src/Level.c:35: cpct_memcpy(g_palette+SHARED_COLORS, level_palettes[i],VARIABLE_COLORS);
   0123 01 C2 00      [10]  150 	ld	bc,#_level_palettes+0
   0126 DD 5E 04      [19]  151 	ld	e,4 (ix)
   0129 16 00         [ 7]  152 	ld	d,#0x00
   012B 6B            [ 4]  153 	ld	l, e
   012C 62            [ 4]  154 	ld	h, d
   012D 29            [11]  155 	add	hl, hl
   012E 29            [11]  156 	add	hl, hl
   012F 29            [11]  157 	add	hl, hl
   0130 19            [11]  158 	add	hl, de
   0131 09            [11]  159 	add	hl,bc
   0132 4D            [ 4]  160 	ld	c,l
   0133 44            [ 4]  161 	ld	b,h
   0134 21 09 00      [10]  162 	ld	hl,#0x0009
   0137 E5            [11]  163 	push	hl
   0138 C5            [11]  164 	push	bc
   0139 21 9A 0A      [10]  165 	ld	hl,#(_g_palette + 0x0007)
   013C E5            [11]  166 	push	hl
   013D CD A8 4D      [17]  167 	call	_cpct_memcpy
                            168 ;src/Level.c:36: cpct_setPalette(g_palette,16);
   0140 21 10 00      [10]  169 	ld	hl,#0x0010
   0143 E5            [11]  170 	push	hl
   0144 21 93 0A      [10]  171 	ld	hl,#_g_palette
   0147 E5            [11]  172 	push	hl
   0148 CD B9 4B      [17]  173 	call	_cpct_setPalette
   014B DD E1         [14]  174 	pop	ix
   014D C9            [10]  175 	ret
                            176 ;src/Level.c:39: void level_load_level(){
                            177 ;	---------------------------------
                            178 ; Function level_load_level
                            179 ; ---------------------------------
   014E                     180 _level_load_level::
                            181 ;src/Level.c:42: index =((current_level<8)?0:(
   014E 3A A3 4F      [13]  182 	ld	a,(#_current_level + 0)
   0151 D6 08         [ 7]  183 	sub	a, #0x08
   0153 30 04         [12]  184 	jr	NC,00103$
   0155 06 00         [ 7]  185 	ld	b,#0x00
   0157 18 23         [12]  186 	jr	00104$
   0159                     187 00103$:
                            188 ;src/Level.c:43: (current_level<24)?1:(
   0159 3A A3 4F      [13]  189 	ld	a,(#_current_level + 0)
   015C D6 18         [ 7]  190 	sub	a, #0x18
   015E 30 04         [12]  191 	jr	NC,00105$
   0160 06 01         [ 7]  192 	ld	b,#0x01
   0162 18 18         [12]  193 	jr	00106$
   0164                     194 00105$:
                            195 ;src/Level.c:44: (current_level<56)?2:(
   0164 3A A3 4F      [13]  196 	ld	a,(#_current_level + 0)
   0167 D6 38         [ 7]  197 	sub	a, #0x38
   0169 30 04         [12]  198 	jr	NC,00107$
   016B 06 02         [ 7]  199 	ld	b,#0x02
   016D 18 0D         [12]  200 	jr	00108$
   016F                     201 00107$:
                            202 ;src/Level.c:45: (current_level<120)?3:0
   016F 3A A3 4F      [13]  203 	ld	a,(#_current_level + 0)
   0172 D6 78         [ 7]  204 	sub	a, #0x78
   0174 30 04         [12]  205 	jr	NC,00109$
   0176 06 03         [ 7]  206 	ld	b,#0x03
   0178 18 02         [12]  207 	jr	00110$
   017A                     208 00109$:
   017A 06 00         [ 7]  209 	ld	b,#0x00
   017C                     210 00110$:
   017C                     211 00108$:
   017C                     212 00106$:
   017C                     213 00104$:
                            214 ;src/Level.c:48: uncompress_theme_textures(index);
   017C C5            [11]  215 	push	bc
   017D 68            [ 4]  216 	ld	l,b
   017E CD 4B 24      [17]  217 	call	_uncompress_theme_textures
   0181 C1            [10]  218 	pop	bc
                            219 ;src/Level.c:49: uncompress_enemy_textures(index);
   0182 C5            [11]  220 	push	bc
   0183 68            [ 4]  221 	ld	l,b
   0184 CD 6E 24      [17]  222 	call	_uncompress_enemy_textures
   0187 33            [ 6]  223 	inc	sp
   0188 CD 1B 01      [17]  224 	call	_setLevelPalette
   018B 33            [ 6]  225 	inc	sp
   018C C9            [10]  226 	ret
                            227 	.area _CODE
                            228 	.area _INITIALIZER
                            229 	.area _CABS (ABS)
