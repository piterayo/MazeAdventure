                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module typography_4x6_monospaced
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _typography_4x6_monospaced
                             12 ;--------------------------------------------------------
                             13 ; special function registers
                             14 ;--------------------------------------------------------
                             15 ;--------------------------------------------------------
                             16 ; ram data
                             17 ;--------------------------------------------------------
                             18 	.area _DATA
                             19 ;--------------------------------------------------------
                             20 ; ram data
                             21 ;--------------------------------------------------------
                             22 	.area _INITIALIZED
                             23 ;--------------------------------------------------------
                             24 ; absolute external ram data
                             25 ;--------------------------------------------------------
                             26 	.area _DABS (ABS)
                             27 ;--------------------------------------------------------
                             28 ; global & static initialisations
                             29 ;--------------------------------------------------------
                             30 	.area _HOME
                             31 	.area _GSINIT
                             32 	.area _GSFINAL
                             33 	.area _GSINIT
                             34 ;--------------------------------------------------------
                             35 ; Home
                             36 ;--------------------------------------------------------
                             37 	.area _HOME
                             38 	.area _HOME
                             39 ;--------------------------------------------------------
                             40 ; code
                             41 ;--------------------------------------------------------
                             42 	.area _CODE
                             43 	.area _CODE
   5AC7                      44 _typography_4x6_monospaced:
   5AC7 4C                   45 	.db #0x4C	; 76	'L'
   5AC8 4C                   46 	.db #0x4C	; 76	'L'
   5AC9 EE                   47 	.db #0xEE	; 238
   5ACA 4A                   48 	.db #0x4A	; 74	'J'
   5ACB 4E                   49 	.db #0x4E	; 78	'N'
   5ACC A8                   50 	.db #0xA8	; 168
   5ACD AA                   51 	.db #0xAA	; 170
   5ACE 4C                   52 	.db #0x4C	; 76	'L'
   5ACF 4C                   53 	.db #0x4C	; 76	'L'
   5AD0 6E                   54 	.db #0x6E	; 110	'n'
   5AD1 AA                   55 	.db #0xAA	; 170
   5AD2 AA                   56 	.db #0xAA	; 170
   5AD3 AE                   57 	.db #0xAE	; 174
   5AD4 E4                   58 	.db #0xE4	; 228
   5AD5 4C                   59 	.db #0x4C	; 76	'L'
   5AD6 8E                   60 	.db #0x8E	; 142
   5AD7 6E                   61 	.db #0x6E	; 110	'n'
   5AD8 44                   62 	.db #0x44	; 68	'D'
   5AD9 44                   63 	.db #0x44	; 68	'D'
   5ADA 00                   64 	.db #0x00	; 0
   5ADB 60                   65 	.db #0x60	; 96
   5ADC 28                   66 	.db #0x28	; 40
   5ADD 00                   67 	.db #0x00	; 0
   5ADE 06                   68 	.db #0x06	; 6
   5ADF 44                   69 	.db #0x44	; 68	'D'
   5AE0 AA                   70 	.db #0xAA	; 170
   5AE1 AA                   71 	.db #0xAA	; 170
   5AE2 88                   72 	.db #0x88	; 136
   5AE3 AA                   73 	.db #0xAA	; 170
   5AE4 42                   74 	.db #0x42	; 66	'B'
   5AE5 A8                   75 	.db #0xA8	; 168
   5AE6 EA                   76 	.db #0xEA	; 234
   5AE7 AA                   77 	.db #0xAA	; 170
   5AE8 AA                   78 	.db #0xAA	; 170
   5AE9 84                   79 	.db #0x84	; 132
   5AEA AA                   80 	.db #0xAA	; 170
   5AEB AA                   81 	.db #0xAA	; 170
   5AEC A2                   82 	.db #0xA2	; 162
   5AED AC                   83 	.db #0xAC	; 172
   5AEE A2                   84 	.db #0xA2	; 162
   5AEF 88                   85 	.db #0x88	; 136
   5AF0 82                   86 	.db #0x82	; 130
   5AF1 AA                   87 	.db #0xAA	; 170
   5AF2 4A                   88 	.db #0x4A	; 74	'J'
   5AF3 00                   89 	.db #0x00	; 0
   5AF4 90                   90 	.db #0x90	; 144
   5AF5 6C                   91 	.db #0x6C	; 108	'l'
   5AF6 4E                   92 	.db #0x4E	; 78	'N'
   5AF7 E4                   93 	.db #0xE4	; 228
   5AF8 2E                   94 	.db #0x2E	; 46
   5AF9 AC                   95 	.db #0xAC	; 172
   5AFA 8A                   96 	.db #0x8A	; 138
   5AFB 88                   97 	.db #0x88	; 136
   5AFC 8A                   98 	.db #0x8A	; 138
   5AFD 42                   99 	.db #0x42	; 66	'B'
   5AFE A8                  100 	.db #0xA8	; 168
   5AFF EE                  101 	.db #0xEE	; 238
   5B00 AA                  102 	.db #0xAA	; 170
   5B01 AA                  103 	.db #0xAA	; 170
   5B02 84                  104 	.db #0x84	; 132
   5B03 AA                  105 	.db #0xAA	; 170
   5B04 A4                  106 	.db #0xA4	; 164
   5B05 A4                  107 	.db #0xA4	; 164
   5B06 A4                  108 	.db #0xA4	; 164
   5B07 24                  109 	.db #0x24	; 36
   5B08 AC                  110 	.db #0xAC	; 172
   5B09 C4                  111 	.db #0xC4	; 196
   5B0A 4A                  112 	.db #0x4A	; 74	'J'
   5B0B 42                  113 	.db #0x42	; 66	'B'
   5B0C 04                  114 	.db #0x04	; 4
   5B0D B0                  115 	.db #0xB0	; 176
   5B0E EE                  116 	.db #0xEE	; 238
   5B0F 4A                  117 	.db #0x4A	; 74	'J'
   5B10 46                  118 	.db #0x46	; 70	'F'
   5B11 44                  119 	.db #0x44	; 68	'D'
   5B12 AA                  120 	.db #0xAA	; 170
   5B13 8A                  121 	.db #0x8A	; 138
   5B14 CC                  122 	.db #0xCC	; 204
   5B15 AE                  123 	.db #0xAE	; 174
   5B16 42                  124 	.db #0x42	; 66	'B'
   5B17 C8                  125 	.db #0xC8	; 200
   5B18 AE                  126 	.db #0xAE	; 174
   5B19 AC                  127 	.db #0xAC	; 172
   5B1A AC                  128 	.db #0xAC	; 172
   5B1B 44                  129 	.db #0x44	; 68	'D'
   5B1C AA                  130 	.db #0xAA	; 170
   5B1D A4                  131 	.db #0xA4	; 164
   5B1E 44                  132 	.db #0x44	; 68	'D'
   5B1F A4                  133 	.db #0xA4	; 164
   5B20 42                  134 	.db #0x42	; 66	'B'
   5B21 E2                  135 	.db #0xE2	; 226
   5B22 A4                  136 	.db #0xA4	; 164
   5B23 A6                  137 	.db #0xA6	; 166
   5B24 44                  138 	.db #0x44	; 68	'D'
   5B25 00                  139 	.db #0x00	; 0
   5B26 D0                  140 	.db #0xD0	; 208
   5B27 EE                  141 	.db #0xEE	; 238
   5B28 4A                  142 	.db #0x4A	; 74	'J'
   5B29 A4                  143 	.db #0xA4	; 164
   5B2A AE                  144 	.db #0xAE	; 174
   5B2B EA                  145 	.db #0xEA	; 234
   5B2C AA                  146 	.db #0xAA	; 170
   5B2D 88                  147 	.db #0x88	; 136
   5B2E AA                  148 	.db #0xAA	; 170
   5B2F 4A                  149 	.db #0x4A	; 74	'J'
   5B30 A8                  150 	.db #0xA8	; 168
   5B31 AA                  151 	.db #0xAA	; 170
   5B32 A8                  152 	.db #0xA8	; 168
   5B33 CA                  153 	.db #0xCA	; 202
   5B34 24                  154 	.db #0x24	; 36
   5B35 A4                  155 	.db #0xA4	; 164
   5B36 4A                  156 	.db #0x4A	; 74	'J'
   5B37 48                  157 	.db #0x48	; 72	'H'
   5B38 A4                  158 	.db #0xA4	; 164
   5B39 82                  159 	.db #0x82	; 130
   5B3A 22                  160 	.db #0x22	; 34
   5B3B A8                  161 	.db #0xA8	; 168
   5B3C A2                  162 	.db #0xA2	; 162
   5B3D 00                  163 	.db #0x00	; 0
   5B3E 00                  164 	.db #0x00	; 0
   5B3F A0                  165 	.db #0xA0	; 160
   5B40 6C                  166 	.db #0x6C	; 108	'l'
   5B41 EA                  167 	.db #0xEA	; 234
   5B42 AA                  168 	.db #0xAA	; 170
   5B43 4A                  169 	.db #0x4A	; 74	'J'
   5B44 AE                  170 	.db #0xAE	; 174
   5B45 4C                  171 	.db #0x4C	; 76	'L'
   5B46 E8                  172 	.db #0xE8	; 232
   5B47 EA                  173 	.db #0xEA	; 234
   5B48 44                  174 	.db #0x44	; 68	'D'
   5B49 AE                  175 	.db #0xAE	; 174
   5B4A AA                  176 	.db #0xAA	; 170
   5B4B 48                  177 	.db #0x48	; 72	'H'
   5B4C 2A                  178 	.db #0x2A	; 42
   5B4D C4                  179 	.db #0xC4	; 196
   5B4E 44                  180 	.db #0x44	; 68	'D'
   5B4F AA                  181 	.db #0xAA	; 170
   5B50 4E                  182 	.db #0x4E	; 78	'N'
   5B51 EE                  183 	.db #0xEE	; 238
   5B52 EC                  184 	.db #0xEC	; 236
   5B53 2C                  185 	.db #0x2C	; 44
   5B54 48                  186 	.db #0x48	; 72	'H'
   5B55 4C                  187 	.db #0x4C	; 76	'L'
   5B56 44                  188 	.db #0x44	; 68	'D'
   5B57 44                  189 	.db #0x44	; 68	'D'
   5B58 70                  190 	.db #0x70	; 112	'p'
   5B59 28                  191 	.db #0x28	; 40
   5B5A 44                  192 	.db #0x44	; 68	'D'
   5B5B E4                  193 	.db #0xE4	; 228
   5B5C 04                  194 	.db #0x04	; 4
                            195 	.area _INITIALIZER
                            196 	.area _CABS (ABS)
