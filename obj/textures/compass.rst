                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module compass
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _compass_compass_3
                             12 	.globl _compass_compass_2
                             13 	.globl _compass_compass_1
                             14 	.globl _compass_compass_0
                             15 	.globl _compass_tileset
                             16 ;--------------------------------------------------------
                             17 ; special function registers
                             18 ;--------------------------------------------------------
                             19 ;--------------------------------------------------------
                             20 ; ram data
                             21 ;--------------------------------------------------------
                             22 	.area _DATA
                             23 ;--------------------------------------------------------
                             24 ; ram data
                             25 ;--------------------------------------------------------
                             26 	.area _INITIALIZED
                             27 ;--------------------------------------------------------
                             28 ; absolute external ram data
                             29 ;--------------------------------------------------------
                             30 	.area _DABS (ABS)
                             31 ;--------------------------------------------------------
                             32 ; global & static initialisations
                             33 ;--------------------------------------------------------
                             34 	.area _HOME
                             35 	.area _GSINIT
                             36 	.area _GSFINAL
                             37 	.area _GSINIT
                             38 ;--------------------------------------------------------
                             39 ; Home
                             40 ;--------------------------------------------------------
                             41 	.area _HOME
                             42 	.area _HOME
                             43 ;--------------------------------------------------------
                             44 ; code
                             45 ;--------------------------------------------------------
                             46 	.area _CODE
                             47 	.area _CODE
   2A13                      48 _compass_tileset:
   2A13 1B 2A                49 	.dw _compass_compass_0
   2A15 9B 2A                50 	.dw _compass_compass_1
   2A17 1B 2B                51 	.dw _compass_compass_2
   2A19 9B 2B                52 	.dw _compass_compass_3
   2A1B                      53 _compass_compass_0:
   2A1B C0                   54 	.db #0xC0	; 192
   2A1C C0                   55 	.db #0xC0	; 192
   2A1D C4                   56 	.db #0xC4	; 196
   2A1E CC                   57 	.db #0xCC	; 204
   2A1F CC                   58 	.db #0xCC	; 204
   2A20 C8                   59 	.db #0xC8	; 200
   2A21 C0                   60 	.db #0xC0	; 192
   2A22 C0                   61 	.db #0xC0	; 192
   2A23 C0                   62 	.db #0xC0	; 192
   2A24 C4                   63 	.db #0xC4	; 196
   2A25 8C                   64 	.db #0x8C	; 140
   2A26 0C                   65 	.db #0x0C	; 12
   2A27 0C                   66 	.db #0x0C	; 12
   2A28 4C                   67 	.db #0x4C	; 76	'L'
   2A29 C8                   68 	.db #0xC8	; 200
   2A2A C0                   69 	.db #0xC0	; 192
   2A2B C0                   70 	.db #0xC0	; 192
   2A2C 8C                   71 	.db #0x8C	; 140
   2A2D 48                   72 	.db #0x48	; 72	'H'
   2A2E C0                   73 	.db #0xC0	; 192
   2A2F C0                   74 	.db #0xC0	; 192
   2A30 84                   75 	.db #0x84	; 132
   2A31 4C                   76 	.db #0x4C	; 76	'L'
   2A32 C0                   77 	.db #0xC0	; 192
   2A33 C4                   78 	.db #0xC4	; 196
   2A34 48                   79 	.db #0x48	; 72	'H'
   2A35 C0                   80 	.db #0xC0	; 192
   2A36 C0                   81 	.db #0xC0	; 192
   2A37 C0                   82 	.db #0xC0	; 192
   2A38 C0                   83 	.db #0xC0	; 192
   2A39 84                   84 	.db #0x84	; 132
   2A3A C8                   85 	.db #0xC8	; 200
   2A3B C4                   86 	.db #0xC4	; 196
   2A3C C0                   87 	.db #0xC0	; 192
   2A3D C0                   88 	.db #0xC0	; 192
   2A3E C0                   89 	.db #0xC0	; 192
   2A3F C0                   90 	.db #0xC0	; 192
   2A40 C0                   91 	.db #0xC0	; 192
   2A41 C0                   92 	.db #0xC0	; 192
   2A42 C8                   93 	.db #0xC8	; 200
   2A43 8C                   94 	.db #0x8C	; 140
   2A44 C0                   95 	.db #0xC0	; 192
   2A45 C0                   96 	.db #0xC0	; 192
   2A46 C0                   97 	.db #0xC0	; 192
   2A47 C0                   98 	.db #0xC0	; 192
   2A48 C0                   99 	.db #0xC0	; 192
   2A49 C0                  100 	.db #0xC0	; 192
   2A4A 4C                  101 	.db #0x4C	; 76	'L'
   2A4B CC                  102 	.db #0xCC	; 204
   2A4C CC                  103 	.db #0xCC	; 204
   2A4D CC                  104 	.db #0xCC	; 204
   2A4E CC                  105 	.db #0xCC	; 204
   2A4F C0                  106 	.db #0xC0	; 192
   2A50 C0                  107 	.db #0xC0	; 192
   2A51 C0                  108 	.db #0xC0	; 192
   2A52 C4                  109 	.db #0xC4	; 196
   2A53 CC                  110 	.db #0xCC	; 204
   2A54 CC                  111 	.db #0xCC	; 204
   2A55 CC                  112 	.db #0xCC	; 204
   2A56 CC                  113 	.db #0xCC	; 204
   2A57 C0                  114 	.db #0xC0	; 192
   2A58 C0                  115 	.db #0xC0	; 192
   2A59 C0                  116 	.db #0xC0	; 192
   2A5A C4                  117 	.db #0xC4	; 196
   2A5B 8C                  118 	.db #0x8C	; 140
   2A5C 0C                  119 	.db #0x0C	; 12
   2A5D 0C                  120 	.db #0x0C	; 12
   2A5E 0C                  121 	.db #0x0C	; 12
   2A5F C0                  122 	.db #0xC0	; 192
   2A60 C0                  123 	.db #0xC0	; 192
   2A61 C0                  124 	.db #0xC0	; 192
   2A62 C4                  125 	.db #0xC4	; 196
   2A63 C8                  126 	.db #0xC8	; 200
   2A64 C0                  127 	.db #0xC0	; 192
   2A65 C0                  128 	.db #0xC0	; 192
   2A66 30                  129 	.db #0x30	; 48	'0'
   2A67 30                  130 	.db #0x30	; 48	'0'
   2A68 C0                  131 	.db #0xC0	; 192
   2A69 C0                  132 	.db #0xC0	; 192
   2A6A C4                  133 	.db #0xC4	; 196
   2A6B 4C                  134 	.db #0x4C	; 76	'L'
   2A6C C0                  135 	.db #0xC0	; 192
   2A6D C0                  136 	.db #0xC0	; 192
   2A6E 60                  137 	.db #0x60	; 96
   2A6F C0                  138 	.db #0xC0	; 192
   2A70 C0                  139 	.db #0xC0	; 192
   2A71 C0                  140 	.db #0xC0	; 192
   2A72 8C                  141 	.db #0x8C	; 140
   2A73 C4                  142 	.db #0xC4	; 196
   2A74 C0                  143 	.db #0xC0	; 192
   2A75 C0                  144 	.db #0xC0	; 192
   2A76 30                  145 	.db #0x30	; 48	'0'
   2A77 60                  146 	.db #0x60	; 96
   2A78 C0                  147 	.db #0xC0	; 192
   2A79 C0                  148 	.db #0xC0	; 192
   2A7A C8                  149 	.db #0xC8	; 200
   2A7B 84                  150 	.db #0x84	; 132
   2A7C C8                  151 	.db #0xC8	; 200
   2A7D C0                  152 	.db #0xC0	; 192
   2A7E 60                  153 	.db #0x60	; 96
   2A7F C0                  154 	.db #0xC0	; 192
   2A80 C0                  155 	.db #0xC0	; 192
   2A81 C4                  156 	.db #0xC4	; 196
   2A82 48                  157 	.db #0x48	; 72	'H'
   2A83 C0                  158 	.db #0xC0	; 192
   2A84 4C                  159 	.db #0x4C	; 76	'L'
   2A85 C8                  160 	.db #0xC8	; 200
   2A86 30                  161 	.db #0x30	; 48	'0'
   2A87 30                  162 	.db #0x30	; 48	'0'
   2A88 C4                  163 	.db #0xC4	; 196
   2A89 8C                  164 	.db #0x8C	; 140
   2A8A C0                  165 	.db #0xC0	; 192
   2A8B C0                  166 	.db #0xC0	; 192
   2A8C 84                  167 	.db #0x84	; 132
   2A8D 4C                  168 	.db #0x4C	; 76	'L'
   2A8E CC                  169 	.db #0xCC	; 204
   2A8F CC                  170 	.db #0xCC	; 204
   2A90 8C                  171 	.db #0x8C	; 140
   2A91 48                  172 	.db #0x48	; 72	'H'
   2A92 C0                  173 	.db #0xC0	; 192
   2A93 C0                  174 	.db #0xC0	; 192
   2A94 C0                  175 	.db #0xC0	; 192
   2A95 84                  176 	.db #0x84	; 132
   2A96 0C                  177 	.db #0x0C	; 12
   2A97 0C                  178 	.db #0x0C	; 12
   2A98 48                  179 	.db #0x48	; 72	'H'
   2A99 C0                  180 	.db #0xC0	; 192
   2A9A C0                  181 	.db #0xC0	; 192
   2A9B                     182 _compass_compass_1:
   2A9B C0                  183 	.db #0xC0	; 192
   2A9C C0                  184 	.db #0xC0	; 192
   2A9D C4                  185 	.db #0xC4	; 196
   2A9E CC                  186 	.db #0xCC	; 204
   2A9F CC                  187 	.db #0xCC	; 204
   2AA0 C8                  188 	.db #0xC8	; 200
   2AA1 C0                  189 	.db #0xC0	; 192
   2AA2 C0                  190 	.db #0xC0	; 192
   2AA3 C0                  191 	.db #0xC0	; 192
   2AA4 C4                  192 	.db #0xC4	; 196
   2AA5 8C                  193 	.db #0x8C	; 140
   2AA6 4C                  194 	.db #0x4C	; 76	'L'
   2AA7 8C                  195 	.db #0x8C	; 140
   2AA8 4C                  196 	.db #0x4C	; 76	'L'
   2AA9 C8                  197 	.db #0xC8	; 200
   2AAA C0                  198 	.db #0xC0	; 192
   2AAB C0                  199 	.db #0xC0	; 192
   2AAC 8C                  200 	.db #0x8C	; 140
   2AAD 48                  201 	.db #0x48	; 72	'H'
   2AAE C4                  202 	.db #0xC4	; 196
   2AAF C8                  203 	.db #0xC8	; 200
   2AB0 84                  204 	.db #0x84	; 132
   2AB1 4C                  205 	.db #0x4C	; 76	'L'
   2AB2 C0                  206 	.db #0xC0	; 192
   2AB3 C4                  207 	.db #0xC4	; 196
   2AB4 48                  208 	.db #0x48	; 72	'H'
   2AB5 C0                  209 	.db #0xC0	; 192
   2AB6 C4                  210 	.db #0xC4	; 196
   2AB7 C8                  211 	.db #0xC8	; 200
   2AB8 C0                  212 	.db #0xC0	; 192
   2AB9 84                  213 	.db #0x84	; 132
   2ABA C8                  214 	.db #0xC8	; 200
   2ABB C4                  215 	.db #0xC4	; 196
   2ABC C0                  216 	.db #0xC0	; 192
   2ABD C0                  217 	.db #0xC0	; 192
   2ABE C4                  218 	.db #0xC4	; 196
   2ABF C8                  219 	.db #0xC8	; 200
   2AC0 C0                  220 	.db #0xC0	; 192
   2AC1 C0                  221 	.db #0xC0	; 192
   2AC2 C8                  222 	.db #0xC8	; 200
   2AC3 8C                  223 	.db #0x8C	; 140
   2AC4 C0                  224 	.db #0xC0	; 192
   2AC5 C0                  225 	.db #0xC0	; 192
   2AC6 C4                  226 	.db #0xC4	; 196
   2AC7 C8                  227 	.db #0xC8	; 200
   2AC8 C0                  228 	.db #0xC0	; 192
   2AC9 C0                  229 	.db #0xC0	; 192
   2ACA 4C                  230 	.db #0x4C	; 76	'L'
   2ACB C8                  231 	.db #0xC8	; 200
   2ACC C0                  232 	.db #0xC0	; 192
   2ACD C0                  233 	.db #0xC0	; 192
   2ACE C4                  234 	.db #0xC4	; 196
   2ACF C8                  235 	.db #0xC8	; 200
   2AD0 C0                  236 	.db #0xC0	; 192
   2AD1 C0                  237 	.db #0xC0	; 192
   2AD2 C4                  238 	.db #0xC4	; 196
   2AD3 C8                  239 	.db #0xC8	; 200
   2AD4 C0                  240 	.db #0xC0	; 192
   2AD5 C0                  241 	.db #0xC0	; 192
   2AD6 84                  242 	.db #0x84	; 132
   2AD7 48                  243 	.db #0x48	; 72	'H'
   2AD8 C0                  244 	.db #0xC0	; 192
   2AD9 C0                  245 	.db #0xC0	; 192
   2ADA C4                  246 	.db #0xC4	; 196
   2ADB C8                  247 	.db #0xC8	; 200
   2ADC C0                  248 	.db #0xC0	; 192
   2ADD C0                  249 	.db #0xC0	; 192
   2ADE 60                  250 	.db #0x60	; 96
   2ADF 90                  251 	.db #0x90	; 144
   2AE0 C0                  252 	.db #0xC0	; 192
   2AE1 C0                  253 	.db #0xC0	; 192
   2AE2 C4                  254 	.db #0xC4	; 196
   2AE3 C8                  255 	.db #0xC8	; 200
   2AE4 C0                  256 	.db #0xC0	; 192
   2AE5 C0                  257 	.db #0xC0	; 192
   2AE6 30                  258 	.db #0x30	; 48	'0'
   2AE7 90                  259 	.db #0x90	; 144
   2AE8 C0                  260 	.db #0xC0	; 192
   2AE9 C0                  261 	.db #0xC0	; 192
   2AEA C4                  262 	.db #0xC4	; 196
   2AEB 4C                  263 	.db #0x4C	; 76	'L'
   2AEC C0                  264 	.db #0xC0	; 192
   2AED C0                  265 	.db #0xC0	; 192
   2AEE 30                  266 	.db #0x30	; 48	'0'
   2AEF 90                  267 	.db #0x90	; 144
   2AF0 C0                  268 	.db #0xC0	; 192
   2AF1 C0                  269 	.db #0xC0	; 192
   2AF2 8C                  270 	.db #0x8C	; 140
   2AF3 C4                  271 	.db #0xC4	; 196
   2AF4 C0                  272 	.db #0xC0	; 192
   2AF5 C0                  273 	.db #0xC0	; 192
   2AF6 60                  274 	.db #0x60	; 96
   2AF7 30                  275 	.db #0x30	; 48	'0'
   2AF8 C0                  276 	.db #0xC0	; 192
   2AF9 C0                  277 	.db #0xC0	; 192
   2AFA C8                  278 	.db #0xC8	; 200
   2AFB 84                  279 	.db #0x84	; 132
   2AFC C8                  280 	.db #0xC8	; 200
   2AFD C0                  281 	.db #0xC0	; 192
   2AFE 60                  282 	.db #0x60	; 96
   2AFF 30                  283 	.db #0x30	; 48	'0'
   2B00 C0                  284 	.db #0xC0	; 192
   2B01 C4                  285 	.db #0xC4	; 196
   2B02 48                  286 	.db #0x48	; 72	'H'
   2B03 C0                  287 	.db #0xC0	; 192
   2B04 4C                  288 	.db #0x4C	; 76	'L'
   2B05 C8                  289 	.db #0xC8	; 200
   2B06 60                  290 	.db #0x60	; 96
   2B07 90                  291 	.db #0x90	; 144
   2B08 C4                  292 	.db #0xC4	; 196
   2B09 8C                  293 	.db #0x8C	; 140
   2B0A C0                  294 	.db #0xC0	; 192
   2B0B C0                  295 	.db #0xC0	; 192
   2B0C 84                  296 	.db #0x84	; 132
   2B0D 4C                  297 	.db #0x4C	; 76	'L'
   2B0E CC                  298 	.db #0xCC	; 204
   2B0F CC                  299 	.db #0xCC	; 204
   2B10 8C                  300 	.db #0x8C	; 140
   2B11 48                  301 	.db #0x48	; 72	'H'
   2B12 C0                  302 	.db #0xC0	; 192
   2B13 C0                  303 	.db #0xC0	; 192
   2B14 C0                  304 	.db #0xC0	; 192
   2B15 84                  305 	.db #0x84	; 132
   2B16 0C                  306 	.db #0x0C	; 12
   2B17 0C                  307 	.db #0x0C	; 12
   2B18 48                  308 	.db #0x48	; 72	'H'
   2B19 C0                  309 	.db #0xC0	; 192
   2B1A C0                  310 	.db #0xC0	; 192
   2B1B                     311 _compass_compass_2:
   2B1B C0                  312 	.db #0xC0	; 192
   2B1C C0                  313 	.db #0xC0	; 192
   2B1D C4                  314 	.db #0xC4	; 196
   2B1E CC                  315 	.db #0xCC	; 204
   2B1F CC                  316 	.db #0xCC	; 204
   2B20 C8                  317 	.db #0xC8	; 200
   2B21 C0                  318 	.db #0xC0	; 192
   2B22 C0                  319 	.db #0xC0	; 192
   2B23 C0                  320 	.db #0xC0	; 192
   2B24 C4                  321 	.db #0xC4	; 196
   2B25 8C                  322 	.db #0x8C	; 140
   2B26 0C                  323 	.db #0x0C	; 12
   2B27 0C                  324 	.db #0x0C	; 12
   2B28 4C                  325 	.db #0x4C	; 76	'L'
   2B29 C8                  326 	.db #0xC8	; 200
   2B2A C0                  327 	.db #0xC0	; 192
   2B2B C0                  328 	.db #0xC0	; 192
   2B2C 8C                  329 	.db #0x8C	; 140
   2B2D 48                  330 	.db #0x48	; 72	'H'
   2B2E C0                  331 	.db #0xC0	; 192
   2B2F C0                  332 	.db #0xC0	; 192
   2B30 84                  333 	.db #0x84	; 132
   2B31 4C                  334 	.db #0x4C	; 76	'L'
   2B32 C0                  335 	.db #0xC0	; 192
   2B33 C4                  336 	.db #0xC4	; 196
   2B34 48                  337 	.db #0x48	; 72	'H'
   2B35 C0                  338 	.db #0xC0	; 192
   2B36 C0                  339 	.db #0xC0	; 192
   2B37 C0                  340 	.db #0xC0	; 192
   2B38 C0                  341 	.db #0xC0	; 192
   2B39 84                  342 	.db #0x84	; 132
   2B3A C8                  343 	.db #0xC8	; 200
   2B3B C4                  344 	.db #0xC4	; 196
   2B3C C0                  345 	.db #0xC0	; 192
   2B3D C0                  346 	.db #0xC0	; 192
   2B3E C0                  347 	.db #0xC0	; 192
   2B3F C0                  348 	.db #0xC0	; 192
   2B40 C0                  349 	.db #0xC0	; 192
   2B41 C0                  350 	.db #0xC0	; 192
   2B42 C8                  351 	.db #0xC8	; 200
   2B43 8C                  352 	.db #0x8C	; 140
   2B44 C0                  353 	.db #0xC0	; 192
   2B45 C0                  354 	.db #0xC0	; 192
   2B46 C0                  355 	.db #0xC0	; 192
   2B47 C0                  356 	.db #0xC0	; 192
   2B48 C0                  357 	.db #0xC0	; 192
   2B49 C0                  358 	.db #0xC0	; 192
   2B4A 4C                  359 	.db #0x4C	; 76	'L'
   2B4B C8                  360 	.db #0xC8	; 200
   2B4C C0                  361 	.db #0xC0	; 192
   2B4D C0                  362 	.db #0xC0	; 192
   2B4E C0                  363 	.db #0xC0	; 192
   2B4F CC                  364 	.db #0xCC	; 204
   2B50 CC                  365 	.db #0xCC	; 204
   2B51 CC                  366 	.db #0xCC	; 204
   2B52 CC                  367 	.db #0xCC	; 204
   2B53 C8                  368 	.db #0xC8	; 200
   2B54 C0                  369 	.db #0xC0	; 192
   2B55 C0                  370 	.db #0xC0	; 192
   2B56 C0                  371 	.db #0xC0	; 192
   2B57 CC                  372 	.db #0xCC	; 204
   2B58 CC                  373 	.db #0xCC	; 204
   2B59 CC                  374 	.db #0xCC	; 204
   2B5A CC                  375 	.db #0xCC	; 204
   2B5B C8                  376 	.db #0xC8	; 200
   2B5C C0                  377 	.db #0xC0	; 192
   2B5D C0                  378 	.db #0xC0	; 192
   2B5E C0                  379 	.db #0xC0	; 192
   2B5F 0C                  380 	.db #0x0C	; 12
   2B60 0C                  381 	.db #0x0C	; 12
   2B61 0C                  382 	.db #0x0C	; 12
   2B62 4C                  383 	.db #0x4C	; 76	'L'
   2B63 C8                  384 	.db #0xC8	; 200
   2B64 C0                  385 	.db #0xC0	; 192
   2B65 90                  386 	.db #0x90	; 144
   2B66 C0                  387 	.db #0xC0	; 192
   2B67 90                  388 	.db #0x90	; 144
   2B68 C0                  389 	.db #0xC0	; 192
   2B69 C0                  390 	.db #0xC0	; 192
   2B6A C4                  391 	.db #0xC4	; 196
   2B6B 4C                  392 	.db #0x4C	; 76	'L'
   2B6C C0                  393 	.db #0xC0	; 192
   2B6D 90                  394 	.db #0x90	; 144
   2B6E C0                  395 	.db #0xC0	; 192
   2B6F 90                  396 	.db #0x90	; 144
   2B70 C0                  397 	.db #0xC0	; 192
   2B71 C0                  398 	.db #0xC0	; 192
   2B72 8C                  399 	.db #0x8C	; 140
   2B73 C4                  400 	.db #0xC4	; 196
   2B74 C0                  401 	.db #0xC0	; 192
   2B75 90                  402 	.db #0x90	; 144
   2B76 90                  403 	.db #0x90	; 144
   2B77 90                  404 	.db #0x90	; 144
   2B78 C0                  405 	.db #0xC0	; 192
   2B79 C0                  406 	.db #0xC0	; 192
   2B7A C8                  407 	.db #0xC8	; 200
   2B7B 84                  408 	.db #0x84	; 132
   2B7C C8                  409 	.db #0xC8	; 200
   2B7D C0                  410 	.db #0xC0	; 192
   2B7E 60                  411 	.db #0x60	; 96
   2B7F 60                  412 	.db #0x60	; 96
   2B80 C0                  413 	.db #0xC0	; 192
   2B81 C4                  414 	.db #0xC4	; 196
   2B82 48                  415 	.db #0x48	; 72	'H'
   2B83 C0                  416 	.db #0xC0	; 192
   2B84 4C                  417 	.db #0x4C	; 76	'L'
   2B85 C8                  418 	.db #0xC8	; 200
   2B86 60                  419 	.db #0x60	; 96
   2B87 60                  420 	.db #0x60	; 96
   2B88 C4                  421 	.db #0xC4	; 196
   2B89 8C                  422 	.db #0x8C	; 140
   2B8A C0                  423 	.db #0xC0	; 192
   2B8B C0                  424 	.db #0xC0	; 192
   2B8C 84                  425 	.db #0x84	; 132
   2B8D 4C                  426 	.db #0x4C	; 76	'L'
   2B8E CC                  427 	.db #0xCC	; 204
   2B8F CC                  428 	.db #0xCC	; 204
   2B90 8C                  429 	.db #0x8C	; 140
   2B91 48                  430 	.db #0x48	; 72	'H'
   2B92 C0                  431 	.db #0xC0	; 192
   2B93 C0                  432 	.db #0xC0	; 192
   2B94 C0                  433 	.db #0xC0	; 192
   2B95 84                  434 	.db #0x84	; 132
   2B96 0C                  435 	.db #0x0C	; 12
   2B97 0C                  436 	.db #0x0C	; 12
   2B98 48                  437 	.db #0x48	; 72	'H'
   2B99 C0                  438 	.db #0xC0	; 192
   2B9A C0                  439 	.db #0xC0	; 192
   2B9B                     440 _compass_compass_3:
   2B9B C0                  441 	.db #0xC0	; 192
   2B9C C0                  442 	.db #0xC0	; 192
   2B9D C4                  443 	.db #0xC4	; 196
   2B9E CC                  444 	.db #0xCC	; 204
   2B9F CC                  445 	.db #0xCC	; 204
   2BA0 C8                  446 	.db #0xC8	; 200
   2BA1 C0                  447 	.db #0xC0	; 192
   2BA2 C0                  448 	.db #0xC0	; 192
   2BA3 C0                  449 	.db #0xC0	; 192
   2BA4 C4                  450 	.db #0xC4	; 196
   2BA5 8C                  451 	.db #0x8C	; 140
   2BA6 0C                  452 	.db #0x0C	; 12
   2BA7 0C                  453 	.db #0x0C	; 12
   2BA8 4C                  454 	.db #0x4C	; 76	'L'
   2BA9 C8                  455 	.db #0xC8	; 200
   2BAA C0                  456 	.db #0xC0	; 192
   2BAB C0                  457 	.db #0xC0	; 192
   2BAC 8C                  458 	.db #0x8C	; 140
   2BAD 48                  459 	.db #0x48	; 72	'H'
   2BAE C0                  460 	.db #0xC0	; 192
   2BAF C0                  461 	.db #0xC0	; 192
   2BB0 84                  462 	.db #0x84	; 132
   2BB1 4C                  463 	.db #0x4C	; 76	'L'
   2BB2 C0                  464 	.db #0xC0	; 192
   2BB3 C4                  465 	.db #0xC4	; 196
   2BB4 48                  466 	.db #0x48	; 72	'H'
   2BB5 C0                  467 	.db #0xC0	; 192
   2BB6 C0                  468 	.db #0xC0	; 192
   2BB7 C0                  469 	.db #0xC0	; 192
   2BB8 C0                  470 	.db #0xC0	; 192
   2BB9 84                  471 	.db #0x84	; 132
   2BBA C8                  472 	.db #0xC8	; 200
   2BBB C4                  473 	.db #0xC4	; 196
   2BBC C0                  474 	.db #0xC0	; 192
   2BBD C0                  475 	.db #0xC0	; 192
   2BBE C0                  476 	.db #0xC0	; 192
   2BBF C0                  477 	.db #0xC0	; 192
   2BC0 C0                  478 	.db #0xC0	; 192
   2BC1 C0                  479 	.db #0xC0	; 192
   2BC2 C8                  480 	.db #0xC8	; 200
   2BC3 8C                  481 	.db #0x8C	; 140
   2BC4 C0                  482 	.db #0xC0	; 192
   2BC5 C0                  483 	.db #0xC0	; 192
   2BC6 C0                  484 	.db #0xC0	; 192
   2BC7 C0                  485 	.db #0xC0	; 192
   2BC8 C0                  486 	.db #0xC0	; 192
   2BC9 C0                  487 	.db #0xC0	; 192
   2BCA 4C                  488 	.db #0x4C	; 76	'L'
   2BCB C8                  489 	.db #0xC8	; 200
   2BCC C0                  490 	.db #0xC0	; 192
   2BCD C0                  491 	.db #0xC0	; 192
   2BCE C0                  492 	.db #0xC0	; 192
   2BCF C0                  493 	.db #0xC0	; 192
   2BD0 C0                  494 	.db #0xC0	; 192
   2BD1 C0                  495 	.db #0xC0	; 192
   2BD2 C4                  496 	.db #0xC4	; 196
   2BD3 C8                  497 	.db #0xC8	; 200
   2BD4 C0                  498 	.db #0xC0	; 192
   2BD5 C0                  499 	.db #0xC0	; 192
   2BD6 C4                  500 	.db #0xC4	; 196
   2BD7 C8                  501 	.db #0xC8	; 200
   2BD8 C0                  502 	.db #0xC0	; 192
   2BD9 C0                  503 	.db #0xC0	; 192
   2BDA C4                  504 	.db #0xC4	; 196
   2BDB C8                  505 	.db #0xC8	; 200
   2BDC C0                  506 	.db #0xC0	; 192
   2BDD C0                  507 	.db #0xC0	; 192
   2BDE C4                  508 	.db #0xC4	; 196
   2BDF C8                  509 	.db #0xC8	; 200
   2BE0 C0                  510 	.db #0xC0	; 192
   2BE1 C0                  511 	.db #0xC0	; 192
   2BE2 C4                  512 	.db #0xC4	; 196
   2BE3 C8                  513 	.db #0xC8	; 200
   2BE4 C0                  514 	.db #0xC0	; 192
   2BE5 C0                  515 	.db #0xC0	; 192
   2BE6 64                  516 	.db #0x64	; 100	'd'
   2BE7 98                  517 	.db #0x98	; 152
   2BE8 C0                  518 	.db #0xC0	; 192
   2BE9 C0                  519 	.db #0xC0	; 192
   2BEA C4                  520 	.db #0xC4	; 196
   2BEB 4C                  521 	.db #0x4C	; 76	'L'
   2BEC C0                  522 	.db #0xC0	; 192
   2BED C0                  523 	.db #0xC0	; 192
   2BEE 64                  524 	.db #0x64	; 100	'd'
   2BEF C8                  525 	.db #0xC8	; 200
   2BF0 C0                  526 	.db #0xC0	; 192
   2BF1 C0                  527 	.db #0xC0	; 192
   2BF2 8C                  528 	.db #0x8C	; 140
   2BF3 C4                  529 	.db #0xC4	; 196
   2BF4 C0                  530 	.db #0xC0	; 192
   2BF5 C0                  531 	.db #0xC0	; 192
   2BF6 64                  532 	.db #0x64	; 100	'd'
   2BF7 98                  533 	.db #0x98	; 152
   2BF8 C0                  534 	.db #0xC0	; 192
   2BF9 C0                  535 	.db #0xC0	; 192
   2BFA C8                  536 	.db #0xC8	; 200
   2BFB 84                  537 	.db #0x84	; 132
   2BFC C8                  538 	.db #0xC8	; 200
   2BFD C0                  539 	.db #0xC0	; 192
   2BFE C4                  540 	.db #0xC4	; 196
   2BFF 98                  541 	.db #0x98	; 152
   2C00 C0                  542 	.db #0xC0	; 192
   2C01 C4                  543 	.db #0xC4	; 196
   2C02 48                  544 	.db #0x48	; 72	'H'
   2C03 C0                  545 	.db #0xC0	; 192
   2C04 4C                  546 	.db #0x4C	; 76	'L'
   2C05 C8                  547 	.db #0xC8	; 200
   2C06 64                  548 	.db #0x64	; 100	'd'
   2C07 98                  549 	.db #0x98	; 152
   2C08 C4                  550 	.db #0xC4	; 196
   2C09 8C                  551 	.db #0x8C	; 140
   2C0A C0                  552 	.db #0xC0	; 192
   2C0B C0                  553 	.db #0xC0	; 192
   2C0C 84                  554 	.db #0x84	; 132
   2C0D 4C                  555 	.db #0x4C	; 76	'L'
   2C0E CC                  556 	.db #0xCC	; 204
   2C0F CC                  557 	.db #0xCC	; 204
   2C10 8C                  558 	.db #0x8C	; 140
   2C11 48                  559 	.db #0x48	; 72	'H'
   2C12 C0                  560 	.db #0xC0	; 192
   2C13 C0                  561 	.db #0xC0	; 192
   2C14 C0                  562 	.db #0xC0	; 192
   2C15 84                  563 	.db #0x84	; 132
   2C16 0C                  564 	.db #0x0C	; 12
   2C17 0C                  565 	.db #0x0C	; 12
   2C18 48                  566 	.db #0x48	; 72	'H'
   2C19 C0                  567 	.db #0xC0	; 192
   2C1A C0                  568 	.db #0xC0	; 192
                            569 	.area _INITIALIZER
                            570 	.area _CABS (ABS)
