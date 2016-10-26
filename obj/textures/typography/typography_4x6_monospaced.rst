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
   5C3B                      44 _typography_4x6_monospaced:
   5C3B 4C                   45 	.db #0x4C	; 76	'L'
   5C3C 4C                   46 	.db #0x4C	; 76	'L'
   5C3D EE                   47 	.db #0xEE	; 238
   5C3E 4A                   48 	.db #0x4A	; 74	'J'
   5C3F 4E                   49 	.db #0x4E	; 78	'N'
   5C40 A8                   50 	.db #0xA8	; 168
   5C41 AA                   51 	.db #0xAA	; 170
   5C42 4C                   52 	.db #0x4C	; 76	'L'
   5C43 4C                   53 	.db #0x4C	; 76	'L'
   5C44 6E                   54 	.db #0x6E	; 110	'n'
   5C45 AA                   55 	.db #0xAA	; 170
   5C46 AA                   56 	.db #0xAA	; 170
   5C47 AE                   57 	.db #0xAE	; 174
   5C48 E4                   58 	.db #0xE4	; 228
   5C49 4C                   59 	.db #0x4C	; 76	'L'
   5C4A 8E                   60 	.db #0x8E	; 142
   5C4B 6E                   61 	.db #0x6E	; 110	'n'
   5C4C 44                   62 	.db #0x44	; 68	'D'
   5C4D 44                   63 	.db #0x44	; 68	'D'
   5C4E 00                   64 	.db #0x00	; 0
   5C4F 60                   65 	.db #0x60	; 96
   5C50 28                   66 	.db #0x28	; 40
   5C51 00                   67 	.db #0x00	; 0
   5C52 06                   68 	.db #0x06	; 6
   5C53 44                   69 	.db #0x44	; 68	'D'
   5C54 AA                   70 	.db #0xAA	; 170
   5C55 AA                   71 	.db #0xAA	; 170
   5C56 88                   72 	.db #0x88	; 136
   5C57 AA                   73 	.db #0xAA	; 170
   5C58 42                   74 	.db #0x42	; 66	'B'
   5C59 A8                   75 	.db #0xA8	; 168
   5C5A EA                   76 	.db #0xEA	; 234
   5C5B AA                   77 	.db #0xAA	; 170
   5C5C AA                   78 	.db #0xAA	; 170
   5C5D 84                   79 	.db #0x84	; 132
   5C5E AA                   80 	.db #0xAA	; 170
   5C5F AA                   81 	.db #0xAA	; 170
   5C60 A2                   82 	.db #0xA2	; 162
   5C61 AC                   83 	.db #0xAC	; 172
   5C62 A2                   84 	.db #0xA2	; 162
   5C63 88                   85 	.db #0x88	; 136
   5C64 82                   86 	.db #0x82	; 130
   5C65 AA                   87 	.db #0xAA	; 170
   5C66 4A                   88 	.db #0x4A	; 74	'J'
   5C67 00                   89 	.db #0x00	; 0
   5C68 90                   90 	.db #0x90	; 144
   5C69 6C                   91 	.db #0x6C	; 108	'l'
   5C6A 4E                   92 	.db #0x4E	; 78	'N'
   5C6B E4                   93 	.db #0xE4	; 228
   5C6C 2E                   94 	.db #0x2E	; 46
   5C6D AC                   95 	.db #0xAC	; 172
   5C6E 8A                   96 	.db #0x8A	; 138
   5C6F 88                   97 	.db #0x88	; 136
   5C70 8A                   98 	.db #0x8A	; 138
   5C71 42                   99 	.db #0x42	; 66	'B'
   5C72 A8                  100 	.db #0xA8	; 168
   5C73 EE                  101 	.db #0xEE	; 238
   5C74 AA                  102 	.db #0xAA	; 170
   5C75 AA                  103 	.db #0xAA	; 170
   5C76 84                  104 	.db #0x84	; 132
   5C77 AA                  105 	.db #0xAA	; 170
   5C78 A4                  106 	.db #0xA4	; 164
   5C79 A4                  107 	.db #0xA4	; 164
   5C7A A4                  108 	.db #0xA4	; 164
   5C7B 24                  109 	.db #0x24	; 36
   5C7C AC                  110 	.db #0xAC	; 172
   5C7D C4                  111 	.db #0xC4	; 196
   5C7E 4A                  112 	.db #0x4A	; 74	'J'
   5C7F 42                  113 	.db #0x42	; 66	'B'
   5C80 04                  114 	.db #0x04	; 4
   5C81 B0                  115 	.db #0xB0	; 176
   5C82 EE                  116 	.db #0xEE	; 238
   5C83 4A                  117 	.db #0x4A	; 74	'J'
   5C84 46                  118 	.db #0x46	; 70	'F'
   5C85 44                  119 	.db #0x44	; 68	'D'
   5C86 AA                  120 	.db #0xAA	; 170
   5C87 8A                  121 	.db #0x8A	; 138
   5C88 CC                  122 	.db #0xCC	; 204
   5C89 AE                  123 	.db #0xAE	; 174
   5C8A 42                  124 	.db #0x42	; 66	'B'
   5C8B C8                  125 	.db #0xC8	; 200
   5C8C AE                  126 	.db #0xAE	; 174
   5C8D AC                  127 	.db #0xAC	; 172
   5C8E AC                  128 	.db #0xAC	; 172
   5C8F 44                  129 	.db #0x44	; 68	'D'
   5C90 AA                  130 	.db #0xAA	; 170
   5C91 A4                  131 	.db #0xA4	; 164
   5C92 44                  132 	.db #0x44	; 68	'D'
   5C93 A4                  133 	.db #0xA4	; 164
   5C94 42                  134 	.db #0x42	; 66	'B'
   5C95 E2                  135 	.db #0xE2	; 226
   5C96 A4                  136 	.db #0xA4	; 164
   5C97 A6                  137 	.db #0xA6	; 166
   5C98 44                  138 	.db #0x44	; 68	'D'
   5C99 00                  139 	.db #0x00	; 0
   5C9A D0                  140 	.db #0xD0	; 208
   5C9B EE                  141 	.db #0xEE	; 238
   5C9C 4A                  142 	.db #0x4A	; 74	'J'
   5C9D A4                  143 	.db #0xA4	; 164
   5C9E AE                  144 	.db #0xAE	; 174
   5C9F EA                  145 	.db #0xEA	; 234
   5CA0 AA                  146 	.db #0xAA	; 170
   5CA1 88                  147 	.db #0x88	; 136
   5CA2 AA                  148 	.db #0xAA	; 170
   5CA3 4A                  149 	.db #0x4A	; 74	'J'
   5CA4 A8                  150 	.db #0xA8	; 168
   5CA5 AA                  151 	.db #0xAA	; 170
   5CA6 A8                  152 	.db #0xA8	; 168
   5CA7 CA                  153 	.db #0xCA	; 202
   5CA8 24                  154 	.db #0x24	; 36
   5CA9 A4                  155 	.db #0xA4	; 164
   5CAA 4A                  156 	.db #0x4A	; 74	'J'
   5CAB 48                  157 	.db #0x48	; 72	'H'
   5CAC A4                  158 	.db #0xA4	; 164
   5CAD 82                  159 	.db #0x82	; 130
   5CAE 22                  160 	.db #0x22	; 34
   5CAF A8                  161 	.db #0xA8	; 168
   5CB0 A2                  162 	.db #0xA2	; 162
   5CB1 00                  163 	.db #0x00	; 0
   5CB2 00                  164 	.db #0x00	; 0
   5CB3 A0                  165 	.db #0xA0	; 160
   5CB4 6C                  166 	.db #0x6C	; 108	'l'
   5CB5 EA                  167 	.db #0xEA	; 234
   5CB6 AA                  168 	.db #0xAA	; 170
   5CB7 4A                  169 	.db #0x4A	; 74	'J'
   5CB8 AE                  170 	.db #0xAE	; 174
   5CB9 4C                  171 	.db #0x4C	; 76	'L'
   5CBA E8                  172 	.db #0xE8	; 232
   5CBB EA                  173 	.db #0xEA	; 234
   5CBC 44                  174 	.db #0x44	; 68	'D'
   5CBD AE                  175 	.db #0xAE	; 174
   5CBE AA                  176 	.db #0xAA	; 170
   5CBF 48                  177 	.db #0x48	; 72	'H'
   5CC0 2A                  178 	.db #0x2A	; 42
   5CC1 C4                  179 	.db #0xC4	; 196
   5CC2 44                  180 	.db #0x44	; 68	'D'
   5CC3 AA                  181 	.db #0xAA	; 170
   5CC4 4E                  182 	.db #0x4E	; 78	'N'
   5CC5 EE                  183 	.db #0xEE	; 238
   5CC6 EC                  184 	.db #0xEC	; 236
   5CC7 2C                  185 	.db #0x2C	; 44
   5CC8 48                  186 	.db #0x48	; 72	'H'
   5CC9 4C                  187 	.db #0x4C	; 76	'L'
   5CCA 44                  188 	.db #0x44	; 68	'D'
   5CCB 44                  189 	.db #0x44	; 68	'D'
   5CCC 70                  190 	.db #0x70	; 112	'p'
   5CCD 28                  191 	.db #0x28	; 40
   5CCE 44                  192 	.db #0x44	; 68	'D'
   5CCF E4                  193 	.db #0xE4	; 228
   5CD0 04                  194 	.db #0x04	; 4
                            195 	.area _INITIALIZER
                            196 	.area _CABS (ABS)
