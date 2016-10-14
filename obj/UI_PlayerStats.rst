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
   28D2                      50 _ui_playerstats_render::
                             51 ;src/UI_PlayerStats.c:17: print_transparent_text("STATS", UI_PLAYERSTATS_POSITION+1, UI_PLAYERSTATS_TEXT_COLOR);
   28D2 3E 03         [ 7]   52 	ld	a,#0x03
   28D4 F5            [11]   53 	push	af
   28D5 33            [ 6]   54 	inc	sp
   28D6 21 A1 C0      [10]   55 	ld	hl,#0xC0A1
   28D9 E5            [11]   56 	push	hl
   28DA 21 74 29      [10]   57 	ld	hl,#___str_0
   28DD E5            [11]   58 	push	hl
   28DE CD AB 21      [17]   59 	call	_print_transparent_text
   28E1 F1            [10]   60 	pop	af
   28E2 F1            [10]   61 	pop	af
   28E3 33            [ 6]   62 	inc	sp
                             63 ;src/UI_PlayerStats.c:19: print_transparent_text("HP", UI_PLAYERSTATS_POSITION+160, UI_PLAYERSTATS_TEXT_COLOR);
   28E4 3E 03         [ 7]   64 	ld	a,#0x03
   28E6 F5            [11]   65 	push	af
   28E7 33            [ 6]   66 	inc	sp
   28E8 21 40 C1      [10]   67 	ld	hl,#0xC140
   28EB E5            [11]   68 	push	hl
   28EC 21 7A 29      [10]   69 	ld	hl,#___str_1
   28EF E5            [11]   70 	push	hl
   28F0 CD AB 21      [17]   71 	call	_print_transparent_text
   28F3 F1            [10]   72 	pop	af
   28F4 F1            [10]   73 	pop	af
   28F5 33            [ 6]   74 	inc	sp
                             75 ;src/UI_PlayerStats.c:20: cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[7], 10,4);
   28F6 21 B9 0A      [10]   76 	ld	hl,#_g_colors+7
   28F9 46            [ 7]   77 	ld	b,(hl)
   28FA 21 0A 04      [10]   78 	ld	hl,#0x040A
   28FD E5            [11]   79 	push	hl
   28FE C5            [11]   80 	push	bc
   28FF 33            [ 6]   81 	inc	sp
   2900 21 44 C9      [10]   82 	ld	hl,#0xC944
   2903 E5            [11]   83 	push	hl
   2904 CD 17 47      [17]   84 	call	_cpct_drawSolidBox
   2907 F1            [10]   85 	pop	af
   2908 F1            [10]   86 	pop	af
   2909 33            [ 6]   87 	inc	sp
                             88 ;src/UI_PlayerStats.c:21: print_transparent_text(strings[0], UI_PLAYERSTATS_POSITION+240, UI_PLAYERSTATS_TEXT_COLOR);
   290A ED 4B 6A 29   [20]   89 	ld	bc, (#_strings + 0)
   290E 3E 03         [ 7]   90 	ld	a,#0x03
   2910 F5            [11]   91 	push	af
   2911 33            [ 6]   92 	inc	sp
   2912 21 90 C1      [10]   93 	ld	hl,#0xC190
   2915 E5            [11]   94 	push	hl
   2916 C5            [11]   95 	push	bc
   2917 CD AB 21      [17]   96 	call	_print_transparent_text
   291A F1            [10]   97 	pop	af
   291B F1            [10]   98 	pop	af
   291C 33            [ 6]   99 	inc	sp
                            100 ;src/UI_PlayerStats.c:22: print_transparent_text(strings[1], UI_PLAYERSTATS_POSITION+320, UI_PLAYERSTATS_TEXT_COLOR);
   291D ED 4B 6C 29   [20]  101 	ld	bc, (#_strings + 2)
   2921 3E 03         [ 7]  102 	ld	a,#0x03
   2923 F5            [11]  103 	push	af
   2924 33            [ 6]  104 	inc	sp
   2925 21 E0 C1      [10]  105 	ld	hl,#0xC1E0
   2928 E5            [11]  106 	push	hl
   2929 C5            [11]  107 	push	bc
   292A CD AB 21      [17]  108 	call	_print_transparent_text
   292D F1            [10]  109 	pop	af
   292E F1            [10]  110 	pop	af
   292F 33            [ 6]  111 	inc	sp
                            112 ;src/UI_PlayerStats.c:23: print_transparent_text(strings[2], UI_PLAYERSTATS_POSITION+400, UI_PLAYERSTATS_TEXT_COLOR);
   2930 ED 4B 6E 29   [20]  113 	ld	bc, (#_strings + 4)
   2934 3E 03         [ 7]  114 	ld	a,#0x03
   2936 F5            [11]  115 	push	af
   2937 33            [ 6]  116 	inc	sp
   2938 21 30 C2      [10]  117 	ld	hl,#0xC230
   293B E5            [11]  118 	push	hl
   293C C5            [11]  119 	push	bc
   293D CD AB 21      [17]  120 	call	_print_transparent_text
   2940 F1            [10]  121 	pop	af
   2941 F1            [10]  122 	pop	af
   2942 33            [ 6]  123 	inc	sp
                            124 ;src/UI_PlayerStats.c:24: print_transparent_text(strings[3], UI_PLAYERSTATS_POSITION+480, UI_PLAYERSTATS_TEXT_COLOR);
   2943 ED 4B 70 29   [20]  125 	ld	bc, (#_strings + 6)
   2947 3E 03         [ 7]  126 	ld	a,#0x03
   2949 F5            [11]  127 	push	af
   294A 33            [ 6]  128 	inc	sp
   294B 21 80 C2      [10]  129 	ld	hl,#0xC280
   294E E5            [11]  130 	push	hl
   294F C5            [11]  131 	push	bc
   2950 CD AB 21      [17]  132 	call	_print_transparent_text
   2953 F1            [10]  133 	pop	af
   2954 F1            [10]  134 	pop	af
   2955 33            [ 6]  135 	inc	sp
                            136 ;src/UI_PlayerStats.c:25: print_transparent_text(strings[4], UI_PLAYERSTATS_POSITION+560, UI_PLAYERSTATS_TEXT_COLOR);
   2956 ED 4B 72 29   [20]  137 	ld	bc, (#_strings + 8)
   295A 3E 03         [ 7]  138 	ld	a,#0x03
   295C F5            [11]  139 	push	af
   295D 33            [ 6]  140 	inc	sp
   295E 21 D0 C2      [10]  141 	ld	hl,#0xC2D0
   2961 E5            [11]  142 	push	hl
   2962 C5            [11]  143 	push	bc
   2963 CD AB 21      [17]  144 	call	_print_transparent_text
   2966 F1            [10]  145 	pop	af
   2967 F1            [10]  146 	pop	af
   2968 33            [ 6]  147 	inc	sp
   2969 C9            [10]  148 	ret
   296A                     149 _strings:
   296A 7D 29               150 	.dw __str_2
   296C 84 29               151 	.dw __str_3
   296E 8B 29               152 	.dw __str_4
   2970 92 29               153 	.dw __str_5
   2972 99 29               154 	.dw __str_6
   2974                     155 ___str_0:
   2974 53 54 41 54 53      156 	.ascii "STATS"
   2979 00                  157 	.db 0x00
   297A                     158 ___str_1:
   297A 48 50               159 	.ascii "HP"
   297C 00                  160 	.db 0x00
   297D                     161 __str_2:
   297D 20 31 30 3A 31 30   162 	.ascii " 10:10"
   2983 00                  163 	.db 0x00
   2984                     164 __str_3:
   2984 2B 20 31 2E 30 30   165 	.ascii "+ 1.00"
   298A 00                  166 	.db 0x00
   298B                     167 __str_4:
   298B 23 20 30 2E 30 30   168 	.ascii "# 0.00"
   2991 00                  169 	.db 0x00
   2992                     170 __str_5:
   2992 26 20 20 30 30 30   171 	.ascii "&  000"
   2998 00                  172 	.db 0x00
   2999                     173 __str_6:
   2999 24 20 20 20 20 30   174 	.ascii "$    0"
   299F 00                  175 	.db 0x00
                            176 	.area _CODE
                            177 	.area _INITIALIZER
                            178 	.area _CABS (ABS)
