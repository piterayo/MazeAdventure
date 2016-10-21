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
                             46 ;src/UI_PlayerStats.c:20: void ui_playerstats_render(){
                             47 ;	---------------------------------
                             48 ; Function ui_playerstats_render
                             49 ; ---------------------------------
   2FF2                      50 _ui_playerstats_render::
                             51 ;src/UI_PlayerStats.c:21: print_transparent_text("STATS", UI_PLAYERSTATS_POSITION+1, UI_PLAYERSTATS_TEXT_COLOR);
   2FF2 3E 03         [ 7]   52 	ld	a,#0x03
   2FF4 F5            [11]   53 	push	af
   2FF5 33            [ 6]   54 	inc	sp
   2FF6 21 A1 C0      [10]   55 	ld	hl,#0xC0A1
   2FF9 E5            [11]   56 	push	hl
   2FFA 21 94 30      [10]   57 	ld	hl,#___str_0
   2FFD E5            [11]   58 	push	hl
   2FFE CD 59 28      [17]   59 	call	_print_transparent_text
   3001 F1            [10]   60 	pop	af
   3002 F1            [10]   61 	pop	af
   3003 33            [ 6]   62 	inc	sp
                             63 ;src/UI_PlayerStats.c:23: print_transparent_text("HP", UI_PLAYERSTATS_POSITION+160, UI_PLAYERSTATS_TEXT_COLOR);
   3004 3E 03         [ 7]   64 	ld	a,#0x03
   3006 F5            [11]   65 	push	af
   3007 33            [ 6]   66 	inc	sp
   3008 21 40 C1      [10]   67 	ld	hl,#0xC140
   300B E5            [11]   68 	push	hl
   300C 21 9A 30      [10]   69 	ld	hl,#___str_1
   300F E5            [11]   70 	push	hl
   3010 CD 59 28      [17]   71 	call	_print_transparent_text
   3013 F1            [10]   72 	pop	af
   3014 F1            [10]   73 	pop	af
   3015 33            [ 6]   74 	inc	sp
                             75 ;src/UI_PlayerStats.c:24: cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[UI_PLAYERSTATS_HEALTHBAR_FG_COLOR], 10,4);
   3016 21 6B 10      [10]   76 	ld	hl,#_g_colors+5
   3019 46            [ 7]   77 	ld	b,(hl)
   301A 21 0A 04      [10]   78 	ld	hl,#0x040A
   301D E5            [11]   79 	push	hl
   301E C5            [11]   80 	push	bc
   301F 33            [ 6]   81 	inc	sp
   3020 21 44 C9      [10]   82 	ld	hl,#0xC944
   3023 E5            [11]   83 	push	hl
   3024 CD 62 59      [17]   84 	call	_cpct_drawSolidBox
   3027 F1            [10]   85 	pop	af
   3028 F1            [10]   86 	pop	af
   3029 33            [ 6]   87 	inc	sp
                             88 ;src/UI_PlayerStats.c:25: print_transparent_text(strings[0], UI_PLAYERSTATS_POSITION+240, UI_PLAYERSTATS_TEXT_COLOR);
   302A ED 4B 8A 30   [20]   89 	ld	bc, (#_strings + 0)
   302E 3E 03         [ 7]   90 	ld	a,#0x03
   3030 F5            [11]   91 	push	af
   3031 33            [ 6]   92 	inc	sp
   3032 21 90 C1      [10]   93 	ld	hl,#0xC190
   3035 E5            [11]   94 	push	hl
   3036 C5            [11]   95 	push	bc
   3037 CD 59 28      [17]   96 	call	_print_transparent_text
   303A F1            [10]   97 	pop	af
   303B F1            [10]   98 	pop	af
   303C 33            [ 6]   99 	inc	sp
                            100 ;src/UI_PlayerStats.c:26: print_transparent_text(strings[1], UI_PLAYERSTATS_POSITION+320, UI_PLAYERSTATS_TEXT_COLOR);
   303D ED 4B 8C 30   [20]  101 	ld	bc, (#_strings + 2)
   3041 3E 03         [ 7]  102 	ld	a,#0x03
   3043 F5            [11]  103 	push	af
   3044 33            [ 6]  104 	inc	sp
   3045 21 E0 C1      [10]  105 	ld	hl,#0xC1E0
   3048 E5            [11]  106 	push	hl
   3049 C5            [11]  107 	push	bc
   304A CD 59 28      [17]  108 	call	_print_transparent_text
   304D F1            [10]  109 	pop	af
   304E F1            [10]  110 	pop	af
   304F 33            [ 6]  111 	inc	sp
                            112 ;src/UI_PlayerStats.c:27: print_transparent_text(strings[2], UI_PLAYERSTATS_POSITION+400, UI_PLAYERSTATS_TEXT_COLOR);
   3050 ED 4B 8E 30   [20]  113 	ld	bc, (#_strings + 4)
   3054 3E 03         [ 7]  114 	ld	a,#0x03
   3056 F5            [11]  115 	push	af
   3057 33            [ 6]  116 	inc	sp
   3058 21 30 C2      [10]  117 	ld	hl,#0xC230
   305B E5            [11]  118 	push	hl
   305C C5            [11]  119 	push	bc
   305D CD 59 28      [17]  120 	call	_print_transparent_text
   3060 F1            [10]  121 	pop	af
   3061 F1            [10]  122 	pop	af
   3062 33            [ 6]  123 	inc	sp
                            124 ;src/UI_PlayerStats.c:28: print_transparent_text(strings[3], UI_PLAYERSTATS_POSITION+480, UI_PLAYERSTATS_TEXT_COLOR);
   3063 ED 4B 90 30   [20]  125 	ld	bc, (#_strings + 6)
   3067 3E 03         [ 7]  126 	ld	a,#0x03
   3069 F5            [11]  127 	push	af
   306A 33            [ 6]  128 	inc	sp
   306B 21 80 C2      [10]  129 	ld	hl,#0xC280
   306E E5            [11]  130 	push	hl
   306F C5            [11]  131 	push	bc
   3070 CD 59 28      [17]  132 	call	_print_transparent_text
   3073 F1            [10]  133 	pop	af
   3074 F1            [10]  134 	pop	af
   3075 33            [ 6]  135 	inc	sp
                            136 ;src/UI_PlayerStats.c:29: print_transparent_text(strings[4], UI_PLAYERSTATS_POSITION+560, UI_PLAYERSTATS_TEXT_COLOR);
   3076 ED 4B 92 30   [20]  137 	ld	bc, (#_strings + 8)
   307A 3E 03         [ 7]  138 	ld	a,#0x03
   307C F5            [11]  139 	push	af
   307D 33            [ 6]  140 	inc	sp
   307E 21 D0 C2      [10]  141 	ld	hl,#0xC2D0
   3081 E5            [11]  142 	push	hl
   3082 C5            [11]  143 	push	bc
   3083 CD 59 28      [17]  144 	call	_print_transparent_text
   3086 F1            [10]  145 	pop	af
   3087 F1            [10]  146 	pop	af
   3088 33            [ 6]  147 	inc	sp
   3089 C9            [10]  148 	ret
   308A                     149 _strings:
   308A 9D 30               150 	.dw __str_2
   308C A4 30               151 	.dw __str_3
   308E AB 30               152 	.dw __str_4
   3090 B2 30               153 	.dw __str_5
   3092 B9 30               154 	.dw __str_6
   3094                     155 ___str_0:
   3094 53 54 41 54 53      156 	.ascii "STATS"
   3099 00                  157 	.db 0x00
   309A                     158 ___str_1:
   309A 48 50               159 	.ascii "HP"
   309C 00                  160 	.db 0x00
   309D                     161 __str_2:
   309D 20 31 30 3A 31 30   162 	.ascii " 10:10"
   30A3 00                  163 	.db 0x00
   30A4                     164 __str_3:
   30A4 2B 20 31 2E 30 30   165 	.ascii "+ 1.00"
   30AA 00                  166 	.db 0x00
   30AB                     167 __str_4:
   30AB 23 20 30 2E 30 30   168 	.ascii "# 0.00"
   30B1 00                  169 	.db 0x00
   30B2                     170 __str_5:
   30B2 26 20 20 30 30 30   171 	.ascii "&  000"
   30B8 00                  172 	.db 0x00
   30B9                     173 __str_6:
   30B9 24 20 20 20 20 30   174 	.ascii "$    0"
   30BF 00                  175 	.db 0x00
                            176 	.area _CODE
                            177 	.area _INITIALIZER
                            178 	.area _CABS (ABS)
