                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module UI_PlayerStats
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _print_transparent_text
                             12 	.globl _cpct_drawSolidBox
                             13 	.globl _strings
                             14 	.globl _ui_playerstats_render
                             15 ;--------------------------------------------------------
                             16 ; special function registers
                             17 ;--------------------------------------------------------
                             18 ;--------------------------------------------------------
                             19 ; ram data
                             20 ;--------------------------------------------------------
                             21 	.area _DATA
                             22 ;--------------------------------------------------------
                             23 ; ram data
                             24 ;--------------------------------------------------------
                             25 	.area _INITIALIZED
                             26 ;--------------------------------------------------------
                             27 ; absolute external ram data
                             28 ;--------------------------------------------------------
                             29 	.area _DABS (ABS)
                             30 ;--------------------------------------------------------
                             31 ; global & static initialisations
                             32 ;--------------------------------------------------------
                             33 	.area _HOME
                             34 	.area _GSINIT
                             35 	.area _GSFINAL
                             36 	.area _GSINIT
                             37 ;--------------------------------------------------------
                             38 ; Home
                             39 ;--------------------------------------------------------
                             40 	.area _HOME
                             41 	.area _HOME
                             42 ;--------------------------------------------------------
                             43 ; code
                             44 ;--------------------------------------------------------
                             45 	.area _CODE
                             46 ;src/UI_PlayerStats.c:16: void ui_playerstats_render(){
                             47 ;	---------------------------------
                             48 ; Function ui_playerstats_render
                             49 ; ---------------------------------
   2A86                      50 _ui_playerstats_render::
                             51 ;src/UI_PlayerStats.c:17: print_transparent_text("STATS", UI_PLAYERSTATS_POSITION+1, UI_PLAYERSTATS_TEXT_COLOR);
   2A86 3E 03         [ 7]   52 	ld	a,#0x03
   2A88 F5            [11]   53 	push	af
   2A89 33            [ 6]   54 	inc	sp
   2A8A 21 A1 C0      [10]   55 	ld	hl,#0xC0A1
   2A8D E5            [11]   56 	push	hl
   2A8E 21 28 2B      [10]   57 	ld	hl,#___str_0
   2A91 E5            [11]   58 	push	hl
   2A92 CD 67 22      [17]   59 	call	_print_transparent_text
   2A95 F1            [10]   60 	pop	af
   2A96 F1            [10]   61 	pop	af
   2A97 33            [ 6]   62 	inc	sp
                             63 ;src/UI_PlayerStats.c:19: print_transparent_text("HP", UI_PLAYERSTATS_POSITION+160, UI_PLAYERSTATS_TEXT_COLOR);
   2A98 3E 03         [ 7]   64 	ld	a,#0x03
   2A9A F5            [11]   65 	push	af
   2A9B 33            [ 6]   66 	inc	sp
   2A9C 21 40 C1      [10]   67 	ld	hl,#0xC140
   2A9F E5            [11]   68 	push	hl
   2AA0 21 2E 2B      [10]   69 	ld	hl,#___str_1
   2AA3 E5            [11]   70 	push	hl
   2AA4 CD 67 22      [17]   71 	call	_print_transparent_text
   2AA7 F1            [10]   72 	pop	af
   2AA8 F1            [10]   73 	pop	af
   2AA9 33            [ 6]   74 	inc	sp
                             75 ;src/UI_PlayerStats.c:20: cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[7], 10,4);
   2AAA 21 AA 0A      [10]   76 	ld	hl,#_g_colors+7
   2AAD 46            [ 7]   77 	ld	b,(hl)
   2AAE 21 0A 04      [10]   78 	ld	hl,#0x040A
   2AB1 E5            [11]   79 	push	hl
   2AB2 C5            [11]   80 	push	bc
   2AB3 33            [ 6]   81 	inc	sp
   2AB4 21 44 C9      [10]   82 	ld	hl,#0xC944
   2AB7 E5            [11]   83 	push	hl
   2AB8 CD CB 48      [17]   84 	call	_cpct_drawSolidBox
   2ABB F1            [10]   85 	pop	af
   2ABC F1            [10]   86 	pop	af
   2ABD 33            [ 6]   87 	inc	sp
                             88 ;src/UI_PlayerStats.c:21: print_transparent_text(strings[0], UI_PLAYERSTATS_POSITION+240, UI_PLAYERSTATS_TEXT_COLOR);
   2ABE ED 4B 1E 2B   [20]   89 	ld	bc, (#_strings + 0)
   2AC2 3E 03         [ 7]   90 	ld	a,#0x03
   2AC4 F5            [11]   91 	push	af
   2AC5 33            [ 6]   92 	inc	sp
   2AC6 21 90 C1      [10]   93 	ld	hl,#0xC190
   2AC9 E5            [11]   94 	push	hl
   2ACA C5            [11]   95 	push	bc
   2ACB CD 67 22      [17]   96 	call	_print_transparent_text
   2ACE F1            [10]   97 	pop	af
   2ACF F1            [10]   98 	pop	af
   2AD0 33            [ 6]   99 	inc	sp
                            100 ;src/UI_PlayerStats.c:22: print_transparent_text(strings[1], UI_PLAYERSTATS_POSITION+320, UI_PLAYERSTATS_TEXT_COLOR);
   2AD1 ED 4B 20 2B   [20]  101 	ld	bc, (#_strings + 2)
   2AD5 3E 03         [ 7]  102 	ld	a,#0x03
   2AD7 F5            [11]  103 	push	af
   2AD8 33            [ 6]  104 	inc	sp
   2AD9 21 E0 C1      [10]  105 	ld	hl,#0xC1E0
   2ADC E5            [11]  106 	push	hl
   2ADD C5            [11]  107 	push	bc
   2ADE CD 67 22      [17]  108 	call	_print_transparent_text
   2AE1 F1            [10]  109 	pop	af
   2AE2 F1            [10]  110 	pop	af
   2AE3 33            [ 6]  111 	inc	sp
                            112 ;src/UI_PlayerStats.c:23: print_transparent_text(strings[2], UI_PLAYERSTATS_POSITION+400, UI_PLAYERSTATS_TEXT_COLOR);
   2AE4 ED 4B 22 2B   [20]  113 	ld	bc, (#_strings + 4)
   2AE8 3E 03         [ 7]  114 	ld	a,#0x03
   2AEA F5            [11]  115 	push	af
   2AEB 33            [ 6]  116 	inc	sp
   2AEC 21 30 C2      [10]  117 	ld	hl,#0xC230
   2AEF E5            [11]  118 	push	hl
   2AF0 C5            [11]  119 	push	bc
   2AF1 CD 67 22      [17]  120 	call	_print_transparent_text
   2AF4 F1            [10]  121 	pop	af
   2AF5 F1            [10]  122 	pop	af
   2AF6 33            [ 6]  123 	inc	sp
                            124 ;src/UI_PlayerStats.c:24: print_transparent_text(strings[3], UI_PLAYERSTATS_POSITION+480, UI_PLAYERSTATS_TEXT_COLOR);
   2AF7 ED 4B 24 2B   [20]  125 	ld	bc, (#_strings + 6)
   2AFB 3E 03         [ 7]  126 	ld	a,#0x03
   2AFD F5            [11]  127 	push	af
   2AFE 33            [ 6]  128 	inc	sp
   2AFF 21 80 C2      [10]  129 	ld	hl,#0xC280
   2B02 E5            [11]  130 	push	hl
   2B03 C5            [11]  131 	push	bc
   2B04 CD 67 22      [17]  132 	call	_print_transparent_text
   2B07 F1            [10]  133 	pop	af
   2B08 F1            [10]  134 	pop	af
   2B09 33            [ 6]  135 	inc	sp
                            136 ;src/UI_PlayerStats.c:25: print_transparent_text(strings[4], UI_PLAYERSTATS_POSITION+560, UI_PLAYERSTATS_TEXT_COLOR);
   2B0A ED 4B 26 2B   [20]  137 	ld	bc, (#_strings + 8)
   2B0E 3E 03         [ 7]  138 	ld	a,#0x03
   2B10 F5            [11]  139 	push	af
   2B11 33            [ 6]  140 	inc	sp
   2B12 21 D0 C2      [10]  141 	ld	hl,#0xC2D0
   2B15 E5            [11]  142 	push	hl
   2B16 C5            [11]  143 	push	bc
   2B17 CD 67 22      [17]  144 	call	_print_transparent_text
   2B1A F1            [10]  145 	pop	af
   2B1B F1            [10]  146 	pop	af
   2B1C 33            [ 6]  147 	inc	sp
   2B1D C9            [10]  148 	ret
   2B1E                     149 _strings:
   2B1E 31 2B               150 	.dw __str_2
   2B20 38 2B               151 	.dw __str_3
   2B22 3F 2B               152 	.dw __str_4
   2B24 46 2B               153 	.dw __str_5
   2B26 4D 2B               154 	.dw __str_6
   2B28                     155 ___str_0:
   2B28 53 54 41 54 53      156 	.ascii "STATS"
   2B2D 00                  157 	.db 0x00
   2B2E                     158 ___str_1:
   2B2E 48 50               159 	.ascii "HP"
   2B30 00                  160 	.db 0x00
   2B31                     161 __str_2:
   2B31 20 31 30 3A 31 30   162 	.ascii " 10:10"
   2B37 00                  163 	.db 0x00
   2B38                     164 __str_3:
   2B38 2B 20 31 2E 30 30   165 	.ascii "+ 1.00"
   2B3E 00                  166 	.db 0x00
   2B3F                     167 __str_4:
   2B3F 23 20 30 2E 30 30   168 	.ascii "# 0.00"
   2B45 00                  169 	.db 0x00
   2B46                     170 __str_5:
   2B46 26 20 20 30 30 30   171 	.ascii "&  000"
   2B4C 00                  172 	.db 0x00
   2B4D                     173 __str_6:
   2B4D 24 20 20 20 20 30   174 	.ascii "$    0"
   2B53 00                  175 	.db 0x00
                            176 	.area _CODE
                            177 	.area _INITIALIZER
                            178 	.area _CABS (ABS)
