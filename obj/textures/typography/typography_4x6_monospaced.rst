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
   5BA5                      44 _typography_4x6_monospaced:
   5BA5 4C                   45 	.db #0x4C	; 76	'L'
   5BA6 4C                   46 	.db #0x4C	; 76	'L'
   5BA7 EE                   47 	.db #0xEE	; 238
   5BA8 4A                   48 	.db #0x4A	; 74	'J'
   5BA9 4E                   49 	.db #0x4E	; 78	'N'
   5BAA A8                   50 	.db #0xA8	; 168
   5BAB AA                   51 	.db #0xAA	; 170
   5BAC 4C                   52 	.db #0x4C	; 76	'L'
   5BAD 4C                   53 	.db #0x4C	; 76	'L'
   5BAE 6E                   54 	.db #0x6E	; 110	'n'
   5BAF AA                   55 	.db #0xAA	; 170
   5BB0 AA                   56 	.db #0xAA	; 170
   5BB1 AE                   57 	.db #0xAE	; 174
   5BB2 E4                   58 	.db #0xE4	; 228
   5BB3 4C                   59 	.db #0x4C	; 76	'L'
   5BB4 8E                   60 	.db #0x8E	; 142
   5BB5 6E                   61 	.db #0x6E	; 110	'n'
   5BB6 44                   62 	.db #0x44	; 68	'D'
   5BB7 44                   63 	.db #0x44	; 68	'D'
   5BB8 00                   64 	.db #0x00	; 0
   5BB9 60                   65 	.db #0x60	; 96
   5BBA 28                   66 	.db #0x28	; 40
   5BBB 00                   67 	.db #0x00	; 0
   5BBC 06                   68 	.db #0x06	; 6
   5BBD 44                   69 	.db #0x44	; 68	'D'
   5BBE AA                   70 	.db #0xAA	; 170
   5BBF AA                   71 	.db #0xAA	; 170
   5BC0 88                   72 	.db #0x88	; 136
   5BC1 AA                   73 	.db #0xAA	; 170
   5BC2 42                   74 	.db #0x42	; 66	'B'
   5BC3 A8                   75 	.db #0xA8	; 168
   5BC4 EA                   76 	.db #0xEA	; 234
   5BC5 AA                   77 	.db #0xAA	; 170
   5BC6 AA                   78 	.db #0xAA	; 170
   5BC7 84                   79 	.db #0x84	; 132
   5BC8 AA                   80 	.db #0xAA	; 170
   5BC9 AA                   81 	.db #0xAA	; 170
   5BCA A2                   82 	.db #0xA2	; 162
   5BCB AC                   83 	.db #0xAC	; 172
   5BCC A2                   84 	.db #0xA2	; 162
   5BCD 88                   85 	.db #0x88	; 136
   5BCE 82                   86 	.db #0x82	; 130
   5BCF AA                   87 	.db #0xAA	; 170
   5BD0 4A                   88 	.db #0x4A	; 74	'J'
   5BD1 00                   89 	.db #0x00	; 0
   5BD2 90                   90 	.db #0x90	; 144
   5BD3 6C                   91 	.db #0x6C	; 108	'l'
   5BD4 4E                   92 	.db #0x4E	; 78	'N'
   5BD5 E4                   93 	.db #0xE4	; 228
   5BD6 2E                   94 	.db #0x2E	; 46
   5BD7 AC                   95 	.db #0xAC	; 172
   5BD8 8A                   96 	.db #0x8A	; 138
   5BD9 88                   97 	.db #0x88	; 136
   5BDA 8A                   98 	.db #0x8A	; 138
   5BDB 42                   99 	.db #0x42	; 66	'B'
   5BDC A8                  100 	.db #0xA8	; 168
   5BDD EE                  101 	.db #0xEE	; 238
   5BDE AA                  102 	.db #0xAA	; 170
   5BDF AA                  103 	.db #0xAA	; 170
   5BE0 84                  104 	.db #0x84	; 132
   5BE1 AA                  105 	.db #0xAA	; 170
   5BE2 A4                  106 	.db #0xA4	; 164
   5BE3 A4                  107 	.db #0xA4	; 164
   5BE4 A4                  108 	.db #0xA4	; 164
   5BE5 24                  109 	.db #0x24	; 36
   5BE6 AC                  110 	.db #0xAC	; 172
   5BE7 C4                  111 	.db #0xC4	; 196
   5BE8 4A                  112 	.db #0x4A	; 74	'J'
   5BE9 42                  113 	.db #0x42	; 66	'B'
   5BEA 04                  114 	.db #0x04	; 4
   5BEB B0                  115 	.db #0xB0	; 176
   5BEC EE                  116 	.db #0xEE	; 238
   5BED 4A                  117 	.db #0x4A	; 74	'J'
   5BEE 46                  118 	.db #0x46	; 70	'F'
   5BEF 44                  119 	.db #0x44	; 68	'D'
   5BF0 AA                  120 	.db #0xAA	; 170
   5BF1 8A                  121 	.db #0x8A	; 138
   5BF2 CC                  122 	.db #0xCC	; 204
   5BF3 AE                  123 	.db #0xAE	; 174
   5BF4 42                  124 	.db #0x42	; 66	'B'
   5BF5 C8                  125 	.db #0xC8	; 200
   5BF6 AE                  126 	.db #0xAE	; 174
   5BF7 AC                  127 	.db #0xAC	; 172
   5BF8 AC                  128 	.db #0xAC	; 172
   5BF9 44                  129 	.db #0x44	; 68	'D'
   5BFA AA                  130 	.db #0xAA	; 170
   5BFB A4                  131 	.db #0xA4	; 164
   5BFC 44                  132 	.db #0x44	; 68	'D'
   5BFD A4                  133 	.db #0xA4	; 164
   5BFE 42                  134 	.db #0x42	; 66	'B'
   5BFF E2                  135 	.db #0xE2	; 226
   5C00 A4                  136 	.db #0xA4	; 164
   5C01 A6                  137 	.db #0xA6	; 166
   5C02 44                  138 	.db #0x44	; 68	'D'
   5C03 00                  139 	.db #0x00	; 0
   5C04 D0                  140 	.db #0xD0	; 208
   5C05 EE                  141 	.db #0xEE	; 238
   5C06 4A                  142 	.db #0x4A	; 74	'J'
   5C07 A4                  143 	.db #0xA4	; 164
   5C08 AE                  144 	.db #0xAE	; 174
   5C09 EA                  145 	.db #0xEA	; 234
   5C0A AA                  146 	.db #0xAA	; 170
   5C0B 88                  147 	.db #0x88	; 136
   5C0C AA                  148 	.db #0xAA	; 170
   5C0D 4A                  149 	.db #0x4A	; 74	'J'
   5C0E A8                  150 	.db #0xA8	; 168
   5C0F AA                  151 	.db #0xAA	; 170
   5C10 A8                  152 	.db #0xA8	; 168
   5C11 CA                  153 	.db #0xCA	; 202
   5C12 24                  154 	.db #0x24	; 36
   5C13 A4                  155 	.db #0xA4	; 164
   5C14 4A                  156 	.db #0x4A	; 74	'J'
   5C15 48                  157 	.db #0x48	; 72	'H'
   5C16 A4                  158 	.db #0xA4	; 164
   5C17 82                  159 	.db #0x82	; 130
   5C18 22                  160 	.db #0x22	; 34
   5C19 A8                  161 	.db #0xA8	; 168
   5C1A A2                  162 	.db #0xA2	; 162
   5C1B 00                  163 	.db #0x00	; 0
   5C1C 00                  164 	.db #0x00	; 0
   5C1D A0                  165 	.db #0xA0	; 160
   5C1E 6C                  166 	.db #0x6C	; 108	'l'
   5C1F EA                  167 	.db #0xEA	; 234
   5C20 AA                  168 	.db #0xAA	; 170
   5C21 4A                  169 	.db #0x4A	; 74	'J'
   5C22 AE                  170 	.db #0xAE	; 174
   5C23 4C                  171 	.db #0x4C	; 76	'L'
   5C24 E8                  172 	.db #0xE8	; 232
   5C25 EA                  173 	.db #0xEA	; 234
   5C26 44                  174 	.db #0x44	; 68	'D'
   5C27 AE                  175 	.db #0xAE	; 174
   5C28 AA                  176 	.db #0xAA	; 170
   5C29 48                  177 	.db #0x48	; 72	'H'
   5C2A 2A                  178 	.db #0x2A	; 42
   5C2B C4                  179 	.db #0xC4	; 196
   5C2C 44                  180 	.db #0x44	; 68	'D'
   5C2D AA                  181 	.db #0xAA	; 170
   5C2E 4E                  182 	.db #0x4E	; 78	'N'
   5C2F EE                  183 	.db #0xEE	; 238
   5C30 EC                  184 	.db #0xEC	; 236
   5C31 2C                  185 	.db #0x2C	; 44
   5C32 48                  186 	.db #0x48	; 72	'H'
   5C33 4C                  187 	.db #0x4C	; 76	'L'
   5C34 44                  188 	.db #0x44	; 68	'D'
   5C35 44                  189 	.db #0x44	; 68	'D'
   5C36 70                  190 	.db #0x70	; 112	'p'
   5C37 28                  191 	.db #0x28	; 40
   5C38 44                  192 	.db #0x44	; 68	'D'
   5C39 E4                  193 	.db #0xE4	; 228
   5C3A 04                  194 	.db #0x04	; 4
                            195 	.area _INITIALIZER
                            196 	.area _CABS (ABS)
