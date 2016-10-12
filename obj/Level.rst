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
                             17 	.globl _level_palettes
                             18 	.globl _level_init_palettes
                             19 	.globl _level_load_level
                             20 ;--------------------------------------------------------
                             21 ; special function registers
                             22 ;--------------------------------------------------------
                             23 ;--------------------------------------------------------
                             24 ; ram data
                             25 ;--------------------------------------------------------
                             26 	.area _DATA
                             27 ;--------------------------------------------------------
                             28 ; ram data
                             29 ;--------------------------------------------------------
                             30 	.area _INITIALIZED
                             31 ;--------------------------------------------------------
                             32 ; absolute external ram data
                             33 ;--------------------------------------------------------
                             34 	.area _DABS (ABS)
                             35 ;--------------------------------------------------------
                             36 ; global & static initialisations
                             37 ;--------------------------------------------------------
                             38 	.area _HOME
                             39 	.area _GSINIT
                             40 	.area _GSFINAL
                             41 	.area _GSINIT
                             42 ;--------------------------------------------------------
                             43 ; Home
                             44 ;--------------------------------------------------------
                             45 	.area _HOME
                             46 	.area _HOME
                             47 ;--------------------------------------------------------
                             48 ; code
                             49 ;--------------------------------------------------------
                             50 	.area _CODE
                             51 ;src/Level.c:14: void level_init_palettes(){
                             52 ;	---------------------------------
                             53 ; Function level_init_palettes
                             54 ; ---------------------------------
   5045                      55 _level_init_palettes::
                             56 ;src/Level.c:15: cpct_fw2hw(level_palettes[0],9);
   5045 21 09 00      [10]   57 	ld	hl,#0x0009
   5048 E5            [11]   58 	push	hl
   5049 21 72 50      [10]   59 	ld	hl,#_level_palettes
   504C E5            [11]   60 	push	hl
   504D CD 2C 8E      [17]   61 	call	_cpct_fw2hw
                             62 ;src/Level.c:16: cpct_fw2hw(level_palettes[1],9);
   5050 21 09 00      [10]   63 	ld	hl,#0x0009
   5053 E5            [11]   64 	push	hl
   5054 21 7B 50      [10]   65 	ld	hl,#(_level_palettes + 0x0009)
   5057 E5            [11]   66 	push	hl
   5058 CD 2C 8E      [17]   67 	call	_cpct_fw2hw
                             68 ;src/Level.c:17: cpct_fw2hw(level_palettes[2],9);
   505B 21 09 00      [10]   69 	ld	hl,#0x0009
   505E E5            [11]   70 	push	hl
   505F 21 84 50      [10]   71 	ld	hl,#(_level_palettes + 0x0012)
   5062 E5            [11]   72 	push	hl
   5063 CD 2C 8E      [17]   73 	call	_cpct_fw2hw
                             74 ;src/Level.c:18: cpct_fw2hw(level_palettes[3],9);
   5066 21 09 00      [10]   75 	ld	hl,#0x0009
   5069 E5            [11]   76 	push	hl
   506A 21 8D 50      [10]   77 	ld	hl,#(_level_palettes + 0x001b)
   506D E5            [11]   78 	push	hl
   506E CD 2C 8E      [17]   79 	call	_cpct_fw2hw
   5071 C9            [10]   80 	ret
   5072                      81 _level_palettes:
   5072 05                   82 	.db #0x05	; 5
   5073 0A                   83 	.db #0x0A	; 10
   5074 11                   84 	.db #0x11	; 17
   5075 0E                   85 	.db #0x0E	; 14
   5076 0C                   86 	.db #0x0C	; 12
   5077 09                   87 	.db #0x09	; 9
   5078 0F                   88 	.db #0x0F	; 15
   5079 01                   89 	.db #0x01	; 1
   507A 02                   90 	.db #0x02	; 2
   507B 14                   91 	.db #0x14	; 20
   507C 13                   92 	.db #0x13	; 19
   507D 11                   93 	.db #0x11	; 17
   507E 0E                   94 	.db #0x0E	; 14
   507F 12                   95 	.db #0x12	; 18
   5080 09                   96 	.db #0x09	; 9
   5081 0F                   97 	.db #0x0F	; 15
   5082 03                   98 	.db #0x03	; 3
   5083 0A                   99 	.db #0x0A	; 10
   5084 00                  100 	.db #0x00	; 0
   5085 00                  101 	.db #0x00	; 0
   5086 00                  102 	.db #0x00	; 0
   5087 00                  103 	.db #0x00	; 0
   5088 00                  104 	.db #0x00	; 0
   5089 00                  105 	.db #0x00	; 0
   508A 00                  106 	.db #0x00	; 0
   508B 00                  107 	.db #0x00	; 0
   508C 00                  108 	.db #0x00	; 0
   508D 00                  109 	.db #0x00	; 0
   508E 00                  110 	.db #0x00	; 0
   508F 00                  111 	.db #0x00	; 0
   5090 00                  112 	.db #0x00	; 0
   5091 00                  113 	.db #0x00	; 0
   5092 00                  114 	.db #0x00	; 0
   5093 00                  115 	.db #0x00	; 0
   5094 00                  116 	.db #0x00	; 0
   5095 00                  117 	.db #0x00	; 0
                            118 ;src/Level.c:21: void setLevelPalette(u8 i){
                            119 ;	---------------------------------
                            120 ; Function setLevelPalette
                            121 ; ---------------------------------
   5096                     122 _setLevelPalette::
   5096 DD E5         [15]  123 	push	ix
   5098 DD 21 00 00   [14]  124 	ld	ix,#0
   509C DD 39         [15]  125 	add	ix,sp
                            126 ;src/Level.c:22: cpct_memcpy(g_palette+7, level_palettes[i],9);
   509E 01 72 50      [10]  127 	ld	bc,#_level_palettes+0
   50A1 DD 5E 04      [19]  128 	ld	e,4 (ix)
   50A4 16 00         [ 7]  129 	ld	d,#0x00
   50A6 6B            [ 4]  130 	ld	l, e
   50A7 62            [ 4]  131 	ld	h, d
   50A8 29            [11]  132 	add	hl, hl
   50A9 29            [11]  133 	add	hl, hl
   50AA 29            [11]  134 	add	hl, hl
   50AB 19            [11]  135 	add	hl, de
   50AC 09            [11]  136 	add	hl,bc
   50AD 4D            [ 4]  137 	ld	c,l
   50AE 44            [ 4]  138 	ld	b,h
   50AF 21 09 00      [10]  139 	ld	hl,#0x0009
   50B2 E5            [11]  140 	push	hl
   50B3 C5            [11]  141 	push	bc
   50B4 21 42 5A      [10]  142 	ld	hl,#(_g_palette + 0x0007)
   50B7 E5            [11]  143 	push	hl
   50B8 CD FF 8E      [17]  144 	call	_cpct_memcpy
                            145 ;src/Level.c:23: cpct_setPalette(g_palette,16);
   50BB 21 10 00      [10]  146 	ld	hl,#0x0010
   50BE E5            [11]  147 	push	hl
   50BF 21 3B 5A      [10]  148 	ld	hl,#_g_palette
   50C2 E5            [11]  149 	push	hl
   50C3 CD 97 8C      [17]  150 	call	_cpct_setPalette
   50C6 DD E1         [14]  151 	pop	ix
   50C8 C9            [10]  152 	ret
                            153 ;src/Level.c:26: void level_load_level(u8 l){
                            154 ;	---------------------------------
                            155 ; Function level_load_level
                            156 ; ---------------------------------
   50C9                     157 _level_load_level::
                            158 ;src/Level.c:29: index =((l<8)?0:(
   50C9 21 02 00      [10]  159 	ld	hl, #2+0
   50CC 39            [11]  160 	add	hl, sp
   50CD 7E            [ 7]  161 	ld	a, (hl)
   50CE D6 08         [ 7]  162 	sub	a, #0x08
   50D0 30 04         [12]  163 	jr	NC,00103$
   50D2 06 00         [ 7]  164 	ld	b,#0x00
   50D4 18 29         [12]  165 	jr	00104$
   50D6                     166 00103$:
                            167 ;src/Level.c:30: (l<24)?1:(
   50D6 21 02 00      [10]  168 	ld	hl, #2+0
   50D9 39            [11]  169 	add	hl, sp
   50DA 7E            [ 7]  170 	ld	a, (hl)
   50DB D6 18         [ 7]  171 	sub	a, #0x18
   50DD 30 04         [12]  172 	jr	NC,00105$
   50DF 06 01         [ 7]  173 	ld	b,#0x01
   50E1 18 1C         [12]  174 	jr	00106$
   50E3                     175 00105$:
                            176 ;src/Level.c:31: (l<56)?2:(
   50E3 21 02 00      [10]  177 	ld	hl, #2+0
   50E6 39            [11]  178 	add	hl, sp
   50E7 7E            [ 7]  179 	ld	a, (hl)
   50E8 D6 38         [ 7]  180 	sub	a, #0x38
   50EA 30 04         [12]  181 	jr	NC,00107$
   50EC 06 02         [ 7]  182 	ld	b,#0x02
   50EE 18 0F         [12]  183 	jr	00108$
   50F0                     184 00107$:
                            185 ;src/Level.c:32: (l<120)?4:0
   50F0 21 02 00      [10]  186 	ld	hl, #2+0
   50F3 39            [11]  187 	add	hl, sp
   50F4 7E            [ 7]  188 	ld	a, (hl)
   50F5 D6 78         [ 7]  189 	sub	a, #0x78
   50F7 30 04         [12]  190 	jr	NC,00109$
   50F9 06 04         [ 7]  191 	ld	b,#0x04
   50FB 18 02         [12]  192 	jr	00110$
   50FD                     193 00109$:
   50FD 06 00         [ 7]  194 	ld	b,#0x00
   50FF                     195 00110$:
   50FF                     196 00108$:
   50FF                     197 00106$:
   50FF                     198 00104$:
                            199 ;src/Level.c:35: uncompress_theme_textures(index);
   50FF C5            [11]  200 	push	bc
   5100 C5            [11]  201 	push	bc
   5101 33            [ 6]  202 	inc	sp
   5102 CD 2F 6E      [17]  203 	call	_uncompress_theme_textures
   5105 33            [ 6]  204 	inc	sp
   5106 C1            [10]  205 	pop	bc
                            206 ;src/Level.c:36: uncompress_enemy_textures(index);
   5107 C5            [11]  207 	push	bc
   5108 C5            [11]  208 	push	bc
   5109 33            [ 6]  209 	inc	sp
   510A CD D9 6E      [17]  210 	call	_uncompress_enemy_textures
   510D 33            [ 6]  211 	inc	sp
   510E 33            [ 6]  212 	inc	sp
   510F CD 96 50      [17]  213 	call	_setLevelPalette
   5112 33            [ 6]  214 	inc	sp
   5113 C9            [10]  215 	ret
                            216 	.area _CODE
                            217 	.area _INITIALIZER
                            218 	.area _CABS (ABS)
