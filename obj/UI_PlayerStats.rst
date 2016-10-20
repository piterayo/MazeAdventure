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
   2945                      50 _ui_playerstats_render::
                             51 ;src/UI_PlayerStats.c:21: print_transparent_text("STATS", UI_PLAYERSTATS_POSITION+1, UI_PLAYERSTATS_TEXT_COLOR);
   2945 3E 03         [ 7]   52 	ld	a,#0x03
   2947 F5            [11]   53 	push	af
   2948 33            [ 6]   54 	inc	sp
   2949 21 A1 C0      [10]   55 	ld	hl,#0xC0A1
   294C E5            [11]   56 	push	hl
   294D 21 E7 29      [10]   57 	ld	hl,#___str_0
   2950 E5            [11]   58 	push	hl
   2951 CD 70 22      [17]   59 	call	_print_transparent_text
   2954 F1            [10]   60 	pop	af
   2955 F1            [10]   61 	pop	af
   2956 33            [ 6]   62 	inc	sp
                             63 ;src/UI_PlayerStats.c:23: print_transparent_text("HP", UI_PLAYERSTATS_POSITION+160, UI_PLAYERSTATS_TEXT_COLOR);
   2957 3E 03         [ 7]   64 	ld	a,#0x03
   2959 F5            [11]   65 	push	af
   295A 33            [ 6]   66 	inc	sp
   295B 21 40 C1      [10]   67 	ld	hl,#0xC140
   295E E5            [11]   68 	push	hl
   295F 21 ED 29      [10]   69 	ld	hl,#___str_1
   2962 E5            [11]   70 	push	hl
   2963 CD 70 22      [17]   71 	call	_print_transparent_text
   2966 F1            [10]   72 	pop	af
   2967 F1            [10]   73 	pop	af
   2968 33            [ 6]   74 	inc	sp
                             75 ;src/UI_PlayerStats.c:24: cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[UI_PLAYERSTATS_HEALTHBAR_FG_COLOR], 10,4);
   2969 21 A8 0A      [10]   76 	ld	hl,#_g_colors+5
   296C 46            [ 7]   77 	ld	b,(hl)
   296D 21 0A 04      [10]   78 	ld	hl,#0x040A
   2970 E5            [11]   79 	push	hl
   2971 C5            [11]   80 	push	bc
   2972 33            [ 6]   81 	inc	sp
   2973 21 44 C9      [10]   82 	ld	hl,#0xC944
   2976 E5            [11]   83 	push	hl
   2977 CD C0 4D      [17]   84 	call	_cpct_drawSolidBox
   297A F1            [10]   85 	pop	af
   297B F1            [10]   86 	pop	af
   297C 33            [ 6]   87 	inc	sp
                             88 ;src/UI_PlayerStats.c:25: print_transparent_text(strings[0], UI_PLAYERSTATS_POSITION+240, UI_PLAYERSTATS_TEXT_COLOR);
   297D ED 4B DD 29   [20]   89 	ld	bc, (#_strings + 0)
   2981 3E 03         [ 7]   90 	ld	a,#0x03
   2983 F5            [11]   91 	push	af
   2984 33            [ 6]   92 	inc	sp
   2985 21 90 C1      [10]   93 	ld	hl,#0xC190
   2988 E5            [11]   94 	push	hl
   2989 C5            [11]   95 	push	bc
   298A CD 70 22      [17]   96 	call	_print_transparent_text
   298D F1            [10]   97 	pop	af
   298E F1            [10]   98 	pop	af
   298F 33            [ 6]   99 	inc	sp
                            100 ;src/UI_PlayerStats.c:26: print_transparent_text(strings[1], UI_PLAYERSTATS_POSITION+320, UI_PLAYERSTATS_TEXT_COLOR);
   2990 ED 4B DF 29   [20]  101 	ld	bc, (#_strings + 2)
   2994 3E 03         [ 7]  102 	ld	a,#0x03
   2996 F5            [11]  103 	push	af
   2997 33            [ 6]  104 	inc	sp
   2998 21 E0 C1      [10]  105 	ld	hl,#0xC1E0
   299B E5            [11]  106 	push	hl
   299C C5            [11]  107 	push	bc
   299D CD 70 22      [17]  108 	call	_print_transparent_text
   29A0 F1            [10]  109 	pop	af
   29A1 F1            [10]  110 	pop	af
   29A2 33            [ 6]  111 	inc	sp
                            112 ;src/UI_PlayerStats.c:27: print_transparent_text(strings[2], UI_PLAYERSTATS_POSITION+400, UI_PLAYERSTATS_TEXT_COLOR);
   29A3 ED 4B E1 29   [20]  113 	ld	bc, (#_strings + 4)
   29A7 3E 03         [ 7]  114 	ld	a,#0x03
   29A9 F5            [11]  115 	push	af
   29AA 33            [ 6]  116 	inc	sp
   29AB 21 30 C2      [10]  117 	ld	hl,#0xC230
   29AE E5            [11]  118 	push	hl
   29AF C5            [11]  119 	push	bc
   29B0 CD 70 22      [17]  120 	call	_print_transparent_text
   29B3 F1            [10]  121 	pop	af
   29B4 F1            [10]  122 	pop	af
   29B5 33            [ 6]  123 	inc	sp
                            124 ;src/UI_PlayerStats.c:28: print_transparent_text(strings[3], UI_PLAYERSTATS_POSITION+480, UI_PLAYERSTATS_TEXT_COLOR);
   29B6 ED 4B E3 29   [20]  125 	ld	bc, (#_strings + 6)
   29BA 3E 03         [ 7]  126 	ld	a,#0x03
   29BC F5            [11]  127 	push	af
   29BD 33            [ 6]  128 	inc	sp
   29BE 21 80 C2      [10]  129 	ld	hl,#0xC280
   29C1 E5            [11]  130 	push	hl
   29C2 C5            [11]  131 	push	bc
   29C3 CD 70 22      [17]  132 	call	_print_transparent_text
   29C6 F1            [10]  133 	pop	af
   29C7 F1            [10]  134 	pop	af
   29C8 33            [ 6]  135 	inc	sp
                            136 ;src/UI_PlayerStats.c:29: print_transparent_text(strings[4], UI_PLAYERSTATS_POSITION+560, UI_PLAYERSTATS_TEXT_COLOR);
   29C9 ED 4B E5 29   [20]  137 	ld	bc, (#_strings + 8)
   29CD 3E 03         [ 7]  138 	ld	a,#0x03
   29CF F5            [11]  139 	push	af
   29D0 33            [ 6]  140 	inc	sp
   29D1 21 D0 C2      [10]  141 	ld	hl,#0xC2D0
   29D4 E5            [11]  142 	push	hl
   29D5 C5            [11]  143 	push	bc
   29D6 CD 70 22      [17]  144 	call	_print_transparent_text
   29D9 F1            [10]  145 	pop	af
   29DA F1            [10]  146 	pop	af
   29DB 33            [ 6]  147 	inc	sp
   29DC C9            [10]  148 	ret
   29DD                     149 _strings:
   29DD F0 29               150 	.dw __str_2
   29DF F7 29               151 	.dw __str_3
   29E1 FE 29               152 	.dw __str_4
   29E3 05 2A               153 	.dw __str_5
   29E5 0C 2A               154 	.dw __str_6
   29E7                     155 ___str_0:
   29E7 53 54 41 54 53      156 	.ascii "STATS"
   29EC 00                  157 	.db 0x00
   29ED                     158 ___str_1:
   29ED 48 50               159 	.ascii "HP"
   29EF 00                  160 	.db 0x00
   29F0                     161 __str_2:
   29F0 20 31 30 3A 31 30   162 	.ascii " 10:10"
   29F6 00                  163 	.db 0x00
   29F7                     164 __str_3:
   29F7 2B 20 31 2E 30 30   165 	.ascii "+ 1.00"
   29FD 00                  166 	.db 0x00
   29FE                     167 __str_4:
   29FE 23 20 30 2E 30 30   168 	.ascii "# 0.00"
   2A04 00                  169 	.db 0x00
   2A05                     170 __str_5:
   2A05 26 20 20 30 30 30   171 	.ascii "&  000"
   2A0B 00                  172 	.db 0x00
   2A0C                     173 __str_6:
   2A0C 24 20 20 20 20 30   174 	.ascii "$    0"
   2A12 00                  175 	.db 0x00
                            176 	.area _CODE
                            177 	.area _INITIALIZER
                            178 	.area _CABS (ABS)
