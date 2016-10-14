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
   2C5D                      44 _typography_4x6_monospaced:
   2C5D 4C                   45 	.db #0x4C	; 76	'L'
   2C5E 4C                   46 	.db #0x4C	; 76	'L'
   2C5F EE                   47 	.db #0xEE	; 238
   2C60 4A                   48 	.db #0x4A	; 74	'J'
   2C61 4E                   49 	.db #0x4E	; 78	'N'
   2C62 A8                   50 	.db #0xA8	; 168
   2C63 AA                   51 	.db #0xAA	; 170
   2C64 4C                   52 	.db #0x4C	; 76	'L'
   2C65 4C                   53 	.db #0x4C	; 76	'L'
   2C66 6E                   54 	.db #0x6E	; 110	'n'
   2C67 AA                   55 	.db #0xAA	; 170
   2C68 AA                   56 	.db #0xAA	; 170
   2C69 AE                   57 	.db #0xAE	; 174
   2C6A E4                   58 	.db #0xE4	; 228
   2C6B 4C                   59 	.db #0x4C	; 76	'L'
   2C6C 8E                   60 	.db #0x8E	; 142
   2C6D 6E                   61 	.db #0x6E	; 110	'n'
   2C6E 44                   62 	.db #0x44	; 68	'D'
   2C6F 44                   63 	.db #0x44	; 68	'D'
   2C70 00                   64 	.db #0x00	; 0
   2C71 60                   65 	.db #0x60	; 96
   2C72 28                   66 	.db #0x28	; 40
   2C73 00                   67 	.db #0x00	; 0
   2C74 06                   68 	.db #0x06	; 6
   2C75 44                   69 	.db #0x44	; 68	'D'
   2C76 AA                   70 	.db #0xAA	; 170
   2C77 AA                   71 	.db #0xAA	; 170
   2C78 88                   72 	.db #0x88	; 136
   2C79 AA                   73 	.db #0xAA	; 170
   2C7A 42                   74 	.db #0x42	; 66	'B'
   2C7B A8                   75 	.db #0xA8	; 168
   2C7C EA                   76 	.db #0xEA	; 234
   2C7D AA                   77 	.db #0xAA	; 170
   2C7E AA                   78 	.db #0xAA	; 170
   2C7F 84                   79 	.db #0x84	; 132
   2C80 AA                   80 	.db #0xAA	; 170
   2C81 AA                   81 	.db #0xAA	; 170
   2C82 A2                   82 	.db #0xA2	; 162
   2C83 AC                   83 	.db #0xAC	; 172
   2C84 A2                   84 	.db #0xA2	; 162
   2C85 88                   85 	.db #0x88	; 136
   2C86 82                   86 	.db #0x82	; 130
   2C87 AA                   87 	.db #0xAA	; 170
   2C88 4A                   88 	.db #0x4A	; 74	'J'
   2C89 00                   89 	.db #0x00	; 0
   2C8A 90                   90 	.db #0x90	; 144
   2C8B 6C                   91 	.db #0x6C	; 108	'l'
   2C8C 4E                   92 	.db #0x4E	; 78	'N'
   2C8D E4                   93 	.db #0xE4	; 228
   2C8E 2E                   94 	.db #0x2E	; 46
   2C8F AC                   95 	.db #0xAC	; 172
   2C90 8A                   96 	.db #0x8A	; 138
   2C91 88                   97 	.db #0x88	; 136
   2C92 8A                   98 	.db #0x8A	; 138
   2C93 42                   99 	.db #0x42	; 66	'B'
   2C94 A8                  100 	.db #0xA8	; 168
   2C95 EE                  101 	.db #0xEE	; 238
   2C96 AA                  102 	.db #0xAA	; 170
   2C97 AA                  103 	.db #0xAA	; 170
   2C98 84                  104 	.db #0x84	; 132
   2C99 AA                  105 	.db #0xAA	; 170
   2C9A A4                  106 	.db #0xA4	; 164
   2C9B A4                  107 	.db #0xA4	; 164
   2C9C A4                  108 	.db #0xA4	; 164
   2C9D 24                  109 	.db #0x24	; 36
   2C9E AC                  110 	.db #0xAC	; 172
   2C9F C4                  111 	.db #0xC4	; 196
   2CA0 4A                  112 	.db #0x4A	; 74	'J'
   2CA1 42                  113 	.db #0x42	; 66	'B'
   2CA2 04                  114 	.db #0x04	; 4
   2CA3 B0                  115 	.db #0xB0	; 176
   2CA4 EE                  116 	.db #0xEE	; 238
   2CA5 4A                  117 	.db #0x4A	; 74	'J'
   2CA6 46                  118 	.db #0x46	; 70	'F'
   2CA7 44                  119 	.db #0x44	; 68	'D'
   2CA8 AA                  120 	.db #0xAA	; 170
   2CA9 8A                  121 	.db #0x8A	; 138
   2CAA CC                  122 	.db #0xCC	; 204
   2CAB AE                  123 	.db #0xAE	; 174
   2CAC 42                  124 	.db #0x42	; 66	'B'
   2CAD C8                  125 	.db #0xC8	; 200
   2CAE AE                  126 	.db #0xAE	; 174
   2CAF AC                  127 	.db #0xAC	; 172
   2CB0 AC                  128 	.db #0xAC	; 172
   2CB1 44                  129 	.db #0x44	; 68	'D'
   2CB2 AA                  130 	.db #0xAA	; 170
   2CB3 A4                  131 	.db #0xA4	; 164
   2CB4 44                  132 	.db #0x44	; 68	'D'
   2CB5 A4                  133 	.db #0xA4	; 164
   2CB6 42                  134 	.db #0x42	; 66	'B'
   2CB7 E2                  135 	.db #0xE2	; 226
   2CB8 A4                  136 	.db #0xA4	; 164
   2CB9 A6                  137 	.db #0xA6	; 166
   2CBA 44                  138 	.db #0x44	; 68	'D'
   2CBB 00                  139 	.db #0x00	; 0
   2CBC D0                  140 	.db #0xD0	; 208
   2CBD EE                  141 	.db #0xEE	; 238
   2CBE 4A                  142 	.db #0x4A	; 74	'J'
   2CBF A4                  143 	.db #0xA4	; 164
   2CC0 AE                  144 	.db #0xAE	; 174
   2CC1 EA                  145 	.db #0xEA	; 234
   2CC2 AA                  146 	.db #0xAA	; 170
   2CC3 88                  147 	.db #0x88	; 136
   2CC4 AA                  148 	.db #0xAA	; 170
   2CC5 4A                  149 	.db #0x4A	; 74	'J'
   2CC6 A8                  150 	.db #0xA8	; 168
   2CC7 AA                  151 	.db #0xAA	; 170
   2CC8 A8                  152 	.db #0xA8	; 168
   2CC9 CA                  153 	.db #0xCA	; 202
   2CCA 24                  154 	.db #0x24	; 36
   2CCB A4                  155 	.db #0xA4	; 164
   2CCC 4A                  156 	.db #0x4A	; 74	'J'
   2CCD 48                  157 	.db #0x48	; 72	'H'
   2CCE A4                  158 	.db #0xA4	; 164
   2CCF 82                  159 	.db #0x82	; 130
   2CD0 22                  160 	.db #0x22	; 34
   2CD1 A8                  161 	.db #0xA8	; 168
   2CD2 A2                  162 	.db #0xA2	; 162
   2CD3 00                  163 	.db #0x00	; 0
   2CD4 00                  164 	.db #0x00	; 0
   2CD5 A0                  165 	.db #0xA0	; 160
   2CD6 6C                  166 	.db #0x6C	; 108	'l'
   2CD7 EA                  167 	.db #0xEA	; 234
   2CD8 AA                  168 	.db #0xAA	; 170
   2CD9 4A                  169 	.db #0x4A	; 74	'J'
   2CDA AE                  170 	.db #0xAE	; 174
   2CDB 4C                  171 	.db #0x4C	; 76	'L'
   2CDC E8                  172 	.db #0xE8	; 232
   2CDD EA                  173 	.db #0xEA	; 234
   2CDE 44                  174 	.db #0x44	; 68	'D'
   2CDF AE                  175 	.db #0xAE	; 174
   2CE0 AA                  176 	.db #0xAA	; 170
   2CE1 48                  177 	.db #0x48	; 72	'H'
   2CE2 2A                  178 	.db #0x2A	; 42
   2CE3 C4                  179 	.db #0xC4	; 196
   2CE4 44                  180 	.db #0x44	; 68	'D'
   2CE5 AA                  181 	.db #0xAA	; 170
   2CE6 4E                  182 	.db #0x4E	; 78	'N'
   2CE7 EE                  183 	.db #0xEE	; 238
   2CE8 EC                  184 	.db #0xEC	; 236
   2CE9 2C                  185 	.db #0x2C	; 44
   2CEA 48                  186 	.db #0x48	; 72	'H'
   2CEB 4C                  187 	.db #0x4C	; 76	'L'
   2CEC 44                  188 	.db #0x44	; 68	'D'
   2CED 44                  189 	.db #0x44	; 68	'D'
   2CEE 70                  190 	.db #0x70	; 112	'p'
   2CEF 28                  191 	.db #0x28	; 40
   2CF0 44                  192 	.db #0x44	; 68	'D'
   2CF1 E4                  193 	.db #0xE4	; 228
   2CF2 04                  194 	.db #0x04	; 4
                            195 	.area _INITIALIZER
                            196 	.area _CABS (ABS)
