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
   4D84                      48 _compass_tileset:
   4D84 8C 4D                49 	.dw _compass_compass_0
   4D86 0C 4E                50 	.dw _compass_compass_1
   4D88 8C 4E                51 	.dw _compass_compass_2
   4D8A 0C 4F                52 	.dw _compass_compass_3
   4D8C                      53 _compass_compass_0:
   4D8C C0                   54 	.db #0xC0	; 192
   4D8D C0                   55 	.db #0xC0	; 192
   4D8E C4                   56 	.db #0xC4	; 196
   4D8F CC                   57 	.db #0xCC	; 204
   4D90 CC                   58 	.db #0xCC	; 204
   4D91 C8                   59 	.db #0xC8	; 200
   4D92 C0                   60 	.db #0xC0	; 192
   4D93 C0                   61 	.db #0xC0	; 192
   4D94 C0                   62 	.db #0xC0	; 192
   4D95 C4                   63 	.db #0xC4	; 196
   4D96 8C                   64 	.db #0x8C	; 140
   4D97 0C                   65 	.db #0x0C	; 12
   4D98 0C                   66 	.db #0x0C	; 12
   4D99 4C                   67 	.db #0x4C	; 76	'L'
   4D9A C8                   68 	.db #0xC8	; 200
   4D9B C0                   69 	.db #0xC0	; 192
   4D9C C0                   70 	.db #0xC0	; 192
   4D9D 8C                   71 	.db #0x8C	; 140
   4D9E 48                   72 	.db #0x48	; 72	'H'
   4D9F C0                   73 	.db #0xC0	; 192
   4DA0 C0                   74 	.db #0xC0	; 192
   4DA1 84                   75 	.db #0x84	; 132
   4DA2 4C                   76 	.db #0x4C	; 76	'L'
   4DA3 C0                   77 	.db #0xC0	; 192
   4DA4 C4                   78 	.db #0xC4	; 196
   4DA5 48                   79 	.db #0x48	; 72	'H'
   4DA6 C0                   80 	.db #0xC0	; 192
   4DA7 C0                   81 	.db #0xC0	; 192
   4DA8 C0                   82 	.db #0xC0	; 192
   4DA9 C0                   83 	.db #0xC0	; 192
   4DAA 84                   84 	.db #0x84	; 132
   4DAB C8                   85 	.db #0xC8	; 200
   4DAC C4                   86 	.db #0xC4	; 196
   4DAD C0                   87 	.db #0xC0	; 192
   4DAE C0                   88 	.db #0xC0	; 192
   4DAF C0                   89 	.db #0xC0	; 192
   4DB0 C0                   90 	.db #0xC0	; 192
   4DB1 C0                   91 	.db #0xC0	; 192
   4DB2 C0                   92 	.db #0xC0	; 192
   4DB3 C8                   93 	.db #0xC8	; 200
   4DB4 8C                   94 	.db #0x8C	; 140
   4DB5 C0                   95 	.db #0xC0	; 192
   4DB6 C0                   96 	.db #0xC0	; 192
   4DB7 C0                   97 	.db #0xC0	; 192
   4DB8 C0                   98 	.db #0xC0	; 192
   4DB9 C0                   99 	.db #0xC0	; 192
   4DBA C0                  100 	.db #0xC0	; 192
   4DBB 4C                  101 	.db #0x4C	; 76	'L'
   4DBC CC                  102 	.db #0xCC	; 204
   4DBD CC                  103 	.db #0xCC	; 204
   4DBE CC                  104 	.db #0xCC	; 204
   4DBF CC                  105 	.db #0xCC	; 204
   4DC0 C0                  106 	.db #0xC0	; 192
   4DC1 C0                  107 	.db #0xC0	; 192
   4DC2 C0                  108 	.db #0xC0	; 192
   4DC3 C4                  109 	.db #0xC4	; 196
   4DC4 CC                  110 	.db #0xCC	; 204
   4DC5 CC                  111 	.db #0xCC	; 204
   4DC6 CC                  112 	.db #0xCC	; 204
   4DC7 CC                  113 	.db #0xCC	; 204
   4DC8 C0                  114 	.db #0xC0	; 192
   4DC9 C0                  115 	.db #0xC0	; 192
   4DCA C0                  116 	.db #0xC0	; 192
   4DCB C4                  117 	.db #0xC4	; 196
   4DCC 8C                  118 	.db #0x8C	; 140
   4DCD 0C                  119 	.db #0x0C	; 12
   4DCE 0C                  120 	.db #0x0C	; 12
   4DCF 0C                  121 	.db #0x0C	; 12
   4DD0 C0                  122 	.db #0xC0	; 192
   4DD1 C0                  123 	.db #0xC0	; 192
   4DD2 C0                  124 	.db #0xC0	; 192
   4DD3 C4                  125 	.db #0xC4	; 196
   4DD4 C8                  126 	.db #0xC8	; 200
   4DD5 C0                  127 	.db #0xC0	; 192
   4DD6 C0                  128 	.db #0xC0	; 192
   4DD7 30                  129 	.db #0x30	; 48	'0'
   4DD8 30                  130 	.db #0x30	; 48	'0'
   4DD9 C0                  131 	.db #0xC0	; 192
   4DDA C0                  132 	.db #0xC0	; 192
   4DDB C4                  133 	.db #0xC4	; 196
   4DDC 4C                  134 	.db #0x4C	; 76	'L'
   4DDD C0                  135 	.db #0xC0	; 192
   4DDE C0                  136 	.db #0xC0	; 192
   4DDF 60                  137 	.db #0x60	; 96
   4DE0 C0                  138 	.db #0xC0	; 192
   4DE1 C0                  139 	.db #0xC0	; 192
   4DE2 C0                  140 	.db #0xC0	; 192
   4DE3 8C                  141 	.db #0x8C	; 140
   4DE4 C4                  142 	.db #0xC4	; 196
   4DE5 C0                  143 	.db #0xC0	; 192
   4DE6 C0                  144 	.db #0xC0	; 192
   4DE7 30                  145 	.db #0x30	; 48	'0'
   4DE8 60                  146 	.db #0x60	; 96
   4DE9 C0                  147 	.db #0xC0	; 192
   4DEA C0                  148 	.db #0xC0	; 192
   4DEB C8                  149 	.db #0xC8	; 200
   4DEC 84                  150 	.db #0x84	; 132
   4DED C8                  151 	.db #0xC8	; 200
   4DEE C0                  152 	.db #0xC0	; 192
   4DEF 60                  153 	.db #0x60	; 96
   4DF0 C0                  154 	.db #0xC0	; 192
   4DF1 C0                  155 	.db #0xC0	; 192
   4DF2 C4                  156 	.db #0xC4	; 196
   4DF3 48                  157 	.db #0x48	; 72	'H'
   4DF4 C0                  158 	.db #0xC0	; 192
   4DF5 4C                  159 	.db #0x4C	; 76	'L'
   4DF6 C8                  160 	.db #0xC8	; 200
   4DF7 30                  161 	.db #0x30	; 48	'0'
   4DF8 30                  162 	.db #0x30	; 48	'0'
   4DF9 C4                  163 	.db #0xC4	; 196
   4DFA 8C                  164 	.db #0x8C	; 140
   4DFB C0                  165 	.db #0xC0	; 192
   4DFC C0                  166 	.db #0xC0	; 192
   4DFD 84                  167 	.db #0x84	; 132
   4DFE 4C                  168 	.db #0x4C	; 76	'L'
   4DFF CC                  169 	.db #0xCC	; 204
   4E00 CC                  170 	.db #0xCC	; 204
   4E01 8C                  171 	.db #0x8C	; 140
   4E02 48                  172 	.db #0x48	; 72	'H'
   4E03 C0                  173 	.db #0xC0	; 192
   4E04 C0                  174 	.db #0xC0	; 192
   4E05 C0                  175 	.db #0xC0	; 192
   4E06 84                  176 	.db #0x84	; 132
   4E07 0C                  177 	.db #0x0C	; 12
   4E08 0C                  178 	.db #0x0C	; 12
   4E09 48                  179 	.db #0x48	; 72	'H'
   4E0A C0                  180 	.db #0xC0	; 192
   4E0B C0                  181 	.db #0xC0	; 192
   4E0C                     182 _compass_compass_1:
   4E0C C0                  183 	.db #0xC0	; 192
   4E0D C0                  184 	.db #0xC0	; 192
   4E0E C4                  185 	.db #0xC4	; 196
   4E0F CC                  186 	.db #0xCC	; 204
   4E10 CC                  187 	.db #0xCC	; 204
   4E11 C8                  188 	.db #0xC8	; 200
   4E12 C0                  189 	.db #0xC0	; 192
   4E13 C0                  190 	.db #0xC0	; 192
   4E14 C0                  191 	.db #0xC0	; 192
   4E15 C4                  192 	.db #0xC4	; 196
   4E16 8C                  193 	.db #0x8C	; 140
   4E17 4C                  194 	.db #0x4C	; 76	'L'
   4E18 8C                  195 	.db #0x8C	; 140
   4E19 4C                  196 	.db #0x4C	; 76	'L'
   4E1A C8                  197 	.db #0xC8	; 200
   4E1B C0                  198 	.db #0xC0	; 192
   4E1C C0                  199 	.db #0xC0	; 192
   4E1D 8C                  200 	.db #0x8C	; 140
   4E1E 48                  201 	.db #0x48	; 72	'H'
   4E1F C4                  202 	.db #0xC4	; 196
   4E20 C8                  203 	.db #0xC8	; 200
   4E21 84                  204 	.db #0x84	; 132
   4E22 4C                  205 	.db #0x4C	; 76	'L'
   4E23 C0                  206 	.db #0xC0	; 192
   4E24 C4                  207 	.db #0xC4	; 196
   4E25 48                  208 	.db #0x48	; 72	'H'
   4E26 C0                  209 	.db #0xC0	; 192
   4E27 C4                  210 	.db #0xC4	; 196
   4E28 C8                  211 	.db #0xC8	; 200
   4E29 C0                  212 	.db #0xC0	; 192
   4E2A 84                  213 	.db #0x84	; 132
   4E2B C8                  214 	.db #0xC8	; 200
   4E2C C4                  215 	.db #0xC4	; 196
   4E2D C0                  216 	.db #0xC0	; 192
   4E2E C0                  217 	.db #0xC0	; 192
   4E2F C4                  218 	.db #0xC4	; 196
   4E30 C8                  219 	.db #0xC8	; 200
   4E31 C0                  220 	.db #0xC0	; 192
   4E32 C0                  221 	.db #0xC0	; 192
   4E33 C8                  222 	.db #0xC8	; 200
   4E34 8C                  223 	.db #0x8C	; 140
   4E35 C0                  224 	.db #0xC0	; 192
   4E36 C0                  225 	.db #0xC0	; 192
   4E37 C4                  226 	.db #0xC4	; 196
   4E38 C8                  227 	.db #0xC8	; 200
   4E39 C0                  228 	.db #0xC0	; 192
   4E3A C0                  229 	.db #0xC0	; 192
   4E3B 4C                  230 	.db #0x4C	; 76	'L'
   4E3C C8                  231 	.db #0xC8	; 200
   4E3D C0                  232 	.db #0xC0	; 192
   4E3E C0                  233 	.db #0xC0	; 192
   4E3F C4                  234 	.db #0xC4	; 196
   4E40 C8                  235 	.db #0xC8	; 200
   4E41 C0                  236 	.db #0xC0	; 192
   4E42 C0                  237 	.db #0xC0	; 192
   4E43 C4                  238 	.db #0xC4	; 196
   4E44 C8                  239 	.db #0xC8	; 200
   4E45 C0                  240 	.db #0xC0	; 192
   4E46 C0                  241 	.db #0xC0	; 192
   4E47 84                  242 	.db #0x84	; 132
   4E48 48                  243 	.db #0x48	; 72	'H'
   4E49 C0                  244 	.db #0xC0	; 192
   4E4A C0                  245 	.db #0xC0	; 192
   4E4B C4                  246 	.db #0xC4	; 196
   4E4C C8                  247 	.db #0xC8	; 200
   4E4D C0                  248 	.db #0xC0	; 192
   4E4E C0                  249 	.db #0xC0	; 192
   4E4F 60                  250 	.db #0x60	; 96
   4E50 90                  251 	.db #0x90	; 144
   4E51 C0                  252 	.db #0xC0	; 192
   4E52 C0                  253 	.db #0xC0	; 192
   4E53 C4                  254 	.db #0xC4	; 196
   4E54 C8                  255 	.db #0xC8	; 200
   4E55 C0                  256 	.db #0xC0	; 192
   4E56 C0                  257 	.db #0xC0	; 192
   4E57 30                  258 	.db #0x30	; 48	'0'
   4E58 90                  259 	.db #0x90	; 144
   4E59 C0                  260 	.db #0xC0	; 192
   4E5A C0                  261 	.db #0xC0	; 192
   4E5B C4                  262 	.db #0xC4	; 196
   4E5C 4C                  263 	.db #0x4C	; 76	'L'
   4E5D C0                  264 	.db #0xC0	; 192
   4E5E C0                  265 	.db #0xC0	; 192
   4E5F 30                  266 	.db #0x30	; 48	'0'
   4E60 90                  267 	.db #0x90	; 144
   4E61 C0                  268 	.db #0xC0	; 192
   4E62 C0                  269 	.db #0xC0	; 192
   4E63 8C                  270 	.db #0x8C	; 140
   4E64 C4                  271 	.db #0xC4	; 196
   4E65 C0                  272 	.db #0xC0	; 192
   4E66 C0                  273 	.db #0xC0	; 192
   4E67 60                  274 	.db #0x60	; 96
   4E68 30                  275 	.db #0x30	; 48	'0'
   4E69 C0                  276 	.db #0xC0	; 192
   4E6A C0                  277 	.db #0xC0	; 192
   4E6B C8                  278 	.db #0xC8	; 200
   4E6C 84                  279 	.db #0x84	; 132
   4E6D C8                  280 	.db #0xC8	; 200
   4E6E C0                  281 	.db #0xC0	; 192
   4E6F 60                  282 	.db #0x60	; 96
   4E70 30                  283 	.db #0x30	; 48	'0'
   4E71 C0                  284 	.db #0xC0	; 192
   4E72 C4                  285 	.db #0xC4	; 196
   4E73 48                  286 	.db #0x48	; 72	'H'
   4E74 C0                  287 	.db #0xC0	; 192
   4E75 4C                  288 	.db #0x4C	; 76	'L'
   4E76 C8                  289 	.db #0xC8	; 200
   4E77 60                  290 	.db #0x60	; 96
   4E78 90                  291 	.db #0x90	; 144
   4E79 C4                  292 	.db #0xC4	; 196
   4E7A 8C                  293 	.db #0x8C	; 140
   4E7B C0                  294 	.db #0xC0	; 192
   4E7C C0                  295 	.db #0xC0	; 192
   4E7D 84                  296 	.db #0x84	; 132
   4E7E 4C                  297 	.db #0x4C	; 76	'L'
   4E7F CC                  298 	.db #0xCC	; 204
   4E80 CC                  299 	.db #0xCC	; 204
   4E81 8C                  300 	.db #0x8C	; 140
   4E82 48                  301 	.db #0x48	; 72	'H'
   4E83 C0                  302 	.db #0xC0	; 192
   4E84 C0                  303 	.db #0xC0	; 192
   4E85 C0                  304 	.db #0xC0	; 192
   4E86 84                  305 	.db #0x84	; 132
   4E87 0C                  306 	.db #0x0C	; 12
   4E88 0C                  307 	.db #0x0C	; 12
   4E89 48                  308 	.db #0x48	; 72	'H'
   4E8A C0                  309 	.db #0xC0	; 192
   4E8B C0                  310 	.db #0xC0	; 192
   4E8C                     311 _compass_compass_2:
   4E8C C0                  312 	.db #0xC0	; 192
   4E8D C0                  313 	.db #0xC0	; 192
   4E8E C4                  314 	.db #0xC4	; 196
   4E8F CC                  315 	.db #0xCC	; 204
   4E90 CC                  316 	.db #0xCC	; 204
   4E91 C8                  317 	.db #0xC8	; 200
   4E92 C0                  318 	.db #0xC0	; 192
   4E93 C0                  319 	.db #0xC0	; 192
   4E94 C0                  320 	.db #0xC0	; 192
   4E95 C4                  321 	.db #0xC4	; 196
   4E96 8C                  322 	.db #0x8C	; 140
   4E97 0C                  323 	.db #0x0C	; 12
   4E98 0C                  324 	.db #0x0C	; 12
   4E99 4C                  325 	.db #0x4C	; 76	'L'
   4E9A C8                  326 	.db #0xC8	; 200
   4E9B C0                  327 	.db #0xC0	; 192
   4E9C C0                  328 	.db #0xC0	; 192
   4E9D 8C                  329 	.db #0x8C	; 140
   4E9E 48                  330 	.db #0x48	; 72	'H'
   4E9F C0                  331 	.db #0xC0	; 192
   4EA0 C0                  332 	.db #0xC0	; 192
   4EA1 84                  333 	.db #0x84	; 132
   4EA2 4C                  334 	.db #0x4C	; 76	'L'
   4EA3 C0                  335 	.db #0xC0	; 192
   4EA4 C4                  336 	.db #0xC4	; 196
   4EA5 48                  337 	.db #0x48	; 72	'H'
   4EA6 C0                  338 	.db #0xC0	; 192
   4EA7 C0                  339 	.db #0xC0	; 192
   4EA8 C0                  340 	.db #0xC0	; 192
   4EA9 C0                  341 	.db #0xC0	; 192
   4EAA 84                  342 	.db #0x84	; 132
   4EAB C8                  343 	.db #0xC8	; 200
   4EAC C4                  344 	.db #0xC4	; 196
   4EAD C0                  345 	.db #0xC0	; 192
   4EAE C0                  346 	.db #0xC0	; 192
   4EAF C0                  347 	.db #0xC0	; 192
   4EB0 C0                  348 	.db #0xC0	; 192
   4EB1 C0                  349 	.db #0xC0	; 192
   4EB2 C0                  350 	.db #0xC0	; 192
   4EB3 C8                  351 	.db #0xC8	; 200
   4EB4 8C                  352 	.db #0x8C	; 140
   4EB5 C0                  353 	.db #0xC0	; 192
   4EB6 C0                  354 	.db #0xC0	; 192
   4EB7 C0                  355 	.db #0xC0	; 192
   4EB8 C0                  356 	.db #0xC0	; 192
   4EB9 C0                  357 	.db #0xC0	; 192
   4EBA C0                  358 	.db #0xC0	; 192
   4EBB 4C                  359 	.db #0x4C	; 76	'L'
   4EBC C8                  360 	.db #0xC8	; 200
   4EBD C0                  361 	.db #0xC0	; 192
   4EBE C0                  362 	.db #0xC0	; 192
   4EBF C0                  363 	.db #0xC0	; 192
   4EC0 CC                  364 	.db #0xCC	; 204
   4EC1 CC                  365 	.db #0xCC	; 204
   4EC2 CC                  366 	.db #0xCC	; 204
   4EC3 CC                  367 	.db #0xCC	; 204
   4EC4 C8                  368 	.db #0xC8	; 200
   4EC5 C0                  369 	.db #0xC0	; 192
   4EC6 C0                  370 	.db #0xC0	; 192
   4EC7 C0                  371 	.db #0xC0	; 192
   4EC8 CC                  372 	.db #0xCC	; 204
   4EC9 CC                  373 	.db #0xCC	; 204
   4ECA CC                  374 	.db #0xCC	; 204
   4ECB CC                  375 	.db #0xCC	; 204
   4ECC C8                  376 	.db #0xC8	; 200
   4ECD C0                  377 	.db #0xC0	; 192
   4ECE C0                  378 	.db #0xC0	; 192
   4ECF C0                  379 	.db #0xC0	; 192
   4ED0 0C                  380 	.db #0x0C	; 12
   4ED1 0C                  381 	.db #0x0C	; 12
   4ED2 0C                  382 	.db #0x0C	; 12
   4ED3 4C                  383 	.db #0x4C	; 76	'L'
   4ED4 C8                  384 	.db #0xC8	; 200
   4ED5 C0                  385 	.db #0xC0	; 192
   4ED6 90                  386 	.db #0x90	; 144
   4ED7 C0                  387 	.db #0xC0	; 192
   4ED8 90                  388 	.db #0x90	; 144
   4ED9 C0                  389 	.db #0xC0	; 192
   4EDA C0                  390 	.db #0xC0	; 192
   4EDB C4                  391 	.db #0xC4	; 196
   4EDC 4C                  392 	.db #0x4C	; 76	'L'
   4EDD C0                  393 	.db #0xC0	; 192
   4EDE 90                  394 	.db #0x90	; 144
   4EDF C0                  395 	.db #0xC0	; 192
   4EE0 90                  396 	.db #0x90	; 144
   4EE1 C0                  397 	.db #0xC0	; 192
   4EE2 C0                  398 	.db #0xC0	; 192
   4EE3 8C                  399 	.db #0x8C	; 140
   4EE4 C4                  400 	.db #0xC4	; 196
   4EE5 C0                  401 	.db #0xC0	; 192
   4EE6 90                  402 	.db #0x90	; 144
   4EE7 90                  403 	.db #0x90	; 144
   4EE8 90                  404 	.db #0x90	; 144
   4EE9 C0                  405 	.db #0xC0	; 192
   4EEA C0                  406 	.db #0xC0	; 192
   4EEB C8                  407 	.db #0xC8	; 200
   4EEC 84                  408 	.db #0x84	; 132
   4EED C8                  409 	.db #0xC8	; 200
   4EEE C0                  410 	.db #0xC0	; 192
   4EEF 60                  411 	.db #0x60	; 96
   4EF0 60                  412 	.db #0x60	; 96
   4EF1 C0                  413 	.db #0xC0	; 192
   4EF2 C4                  414 	.db #0xC4	; 196
   4EF3 48                  415 	.db #0x48	; 72	'H'
   4EF4 C0                  416 	.db #0xC0	; 192
   4EF5 4C                  417 	.db #0x4C	; 76	'L'
   4EF6 C8                  418 	.db #0xC8	; 200
   4EF7 60                  419 	.db #0x60	; 96
   4EF8 60                  420 	.db #0x60	; 96
   4EF9 C4                  421 	.db #0xC4	; 196
   4EFA 8C                  422 	.db #0x8C	; 140
   4EFB C0                  423 	.db #0xC0	; 192
   4EFC C0                  424 	.db #0xC0	; 192
   4EFD 84                  425 	.db #0x84	; 132
   4EFE 4C                  426 	.db #0x4C	; 76	'L'
   4EFF CC                  427 	.db #0xCC	; 204
   4F00 CC                  428 	.db #0xCC	; 204
   4F01 8C                  429 	.db #0x8C	; 140
   4F02 48                  430 	.db #0x48	; 72	'H'
   4F03 C0                  431 	.db #0xC0	; 192
   4F04 C0                  432 	.db #0xC0	; 192
   4F05 C0                  433 	.db #0xC0	; 192
   4F06 84                  434 	.db #0x84	; 132
   4F07 0C                  435 	.db #0x0C	; 12
   4F08 0C                  436 	.db #0x0C	; 12
   4F09 48                  437 	.db #0x48	; 72	'H'
   4F0A C0                  438 	.db #0xC0	; 192
   4F0B C0                  439 	.db #0xC0	; 192
   4F0C                     440 _compass_compass_3:
   4F0C C0                  441 	.db #0xC0	; 192
   4F0D C0                  442 	.db #0xC0	; 192
   4F0E C4                  443 	.db #0xC4	; 196
   4F0F CC                  444 	.db #0xCC	; 204
   4F10 CC                  445 	.db #0xCC	; 204
   4F11 C8                  446 	.db #0xC8	; 200
   4F12 C0                  447 	.db #0xC0	; 192
   4F13 C0                  448 	.db #0xC0	; 192
   4F14 C0                  449 	.db #0xC0	; 192
   4F15 C4                  450 	.db #0xC4	; 196
   4F16 8C                  451 	.db #0x8C	; 140
   4F17 0C                  452 	.db #0x0C	; 12
   4F18 0C                  453 	.db #0x0C	; 12
   4F19 4C                  454 	.db #0x4C	; 76	'L'
   4F1A C8                  455 	.db #0xC8	; 200
   4F1B C0                  456 	.db #0xC0	; 192
   4F1C C0                  457 	.db #0xC0	; 192
   4F1D 8C                  458 	.db #0x8C	; 140
   4F1E 48                  459 	.db #0x48	; 72	'H'
   4F1F C0                  460 	.db #0xC0	; 192
   4F20 C0                  461 	.db #0xC0	; 192
   4F21 84                  462 	.db #0x84	; 132
   4F22 4C                  463 	.db #0x4C	; 76	'L'
   4F23 C0                  464 	.db #0xC0	; 192
   4F24 C4                  465 	.db #0xC4	; 196
   4F25 48                  466 	.db #0x48	; 72	'H'
   4F26 C0                  467 	.db #0xC0	; 192
   4F27 C0                  468 	.db #0xC0	; 192
   4F28 C0                  469 	.db #0xC0	; 192
   4F29 C0                  470 	.db #0xC0	; 192
   4F2A 84                  471 	.db #0x84	; 132
   4F2B C8                  472 	.db #0xC8	; 200
   4F2C C4                  473 	.db #0xC4	; 196
   4F2D C0                  474 	.db #0xC0	; 192
   4F2E C0                  475 	.db #0xC0	; 192
   4F2F C0                  476 	.db #0xC0	; 192
   4F30 C0                  477 	.db #0xC0	; 192
   4F31 C0                  478 	.db #0xC0	; 192
   4F32 C0                  479 	.db #0xC0	; 192
   4F33 C8                  480 	.db #0xC8	; 200
   4F34 8C                  481 	.db #0x8C	; 140
   4F35 C0                  482 	.db #0xC0	; 192
   4F36 C0                  483 	.db #0xC0	; 192
   4F37 C0                  484 	.db #0xC0	; 192
   4F38 C0                  485 	.db #0xC0	; 192
   4F39 C0                  486 	.db #0xC0	; 192
   4F3A C0                  487 	.db #0xC0	; 192
   4F3B 4C                  488 	.db #0x4C	; 76	'L'
   4F3C C8                  489 	.db #0xC8	; 200
   4F3D C0                  490 	.db #0xC0	; 192
   4F3E C0                  491 	.db #0xC0	; 192
   4F3F C0                  492 	.db #0xC0	; 192
   4F40 C0                  493 	.db #0xC0	; 192
   4F41 C0                  494 	.db #0xC0	; 192
   4F42 C0                  495 	.db #0xC0	; 192
   4F43 C4                  496 	.db #0xC4	; 196
   4F44 C8                  497 	.db #0xC8	; 200
   4F45 C0                  498 	.db #0xC0	; 192
   4F46 C0                  499 	.db #0xC0	; 192
   4F47 C4                  500 	.db #0xC4	; 196
   4F48 C8                  501 	.db #0xC8	; 200
   4F49 C0                  502 	.db #0xC0	; 192
   4F4A C0                  503 	.db #0xC0	; 192
   4F4B C4                  504 	.db #0xC4	; 196
   4F4C C8                  505 	.db #0xC8	; 200
   4F4D C0                  506 	.db #0xC0	; 192
   4F4E C0                  507 	.db #0xC0	; 192
   4F4F C4                  508 	.db #0xC4	; 196
   4F50 C8                  509 	.db #0xC8	; 200
   4F51 C0                  510 	.db #0xC0	; 192
   4F52 C0                  511 	.db #0xC0	; 192
   4F53 C4                  512 	.db #0xC4	; 196
   4F54 C8                  513 	.db #0xC8	; 200
   4F55 C0                  514 	.db #0xC0	; 192
   4F56 C0                  515 	.db #0xC0	; 192
   4F57 64                  516 	.db #0x64	; 100	'd'
   4F58 98                  517 	.db #0x98	; 152
   4F59 C0                  518 	.db #0xC0	; 192
   4F5A C0                  519 	.db #0xC0	; 192
   4F5B C4                  520 	.db #0xC4	; 196
   4F5C 4C                  521 	.db #0x4C	; 76	'L'
   4F5D C0                  522 	.db #0xC0	; 192
   4F5E C0                  523 	.db #0xC0	; 192
   4F5F 64                  524 	.db #0x64	; 100	'd'
   4F60 C8                  525 	.db #0xC8	; 200
   4F61 C0                  526 	.db #0xC0	; 192
   4F62 C0                  527 	.db #0xC0	; 192
   4F63 8C                  528 	.db #0x8C	; 140
   4F64 C4                  529 	.db #0xC4	; 196
   4F65 C0                  530 	.db #0xC0	; 192
   4F66 C0                  531 	.db #0xC0	; 192
   4F67 64                  532 	.db #0x64	; 100	'd'
   4F68 98                  533 	.db #0x98	; 152
   4F69 C0                  534 	.db #0xC0	; 192
   4F6A C0                  535 	.db #0xC0	; 192
   4F6B C8                  536 	.db #0xC8	; 200
   4F6C 84                  537 	.db #0x84	; 132
   4F6D C8                  538 	.db #0xC8	; 200
   4F6E C0                  539 	.db #0xC0	; 192
   4F6F C4                  540 	.db #0xC4	; 196
   4F70 98                  541 	.db #0x98	; 152
   4F71 C0                  542 	.db #0xC0	; 192
   4F72 C4                  543 	.db #0xC4	; 196
   4F73 48                  544 	.db #0x48	; 72	'H'
   4F74 C0                  545 	.db #0xC0	; 192
   4F75 4C                  546 	.db #0x4C	; 76	'L'
   4F76 C8                  547 	.db #0xC8	; 200
   4F77 64                  548 	.db #0x64	; 100	'd'
   4F78 98                  549 	.db #0x98	; 152
   4F79 C4                  550 	.db #0xC4	; 196
   4F7A 8C                  551 	.db #0x8C	; 140
   4F7B C0                  552 	.db #0xC0	; 192
   4F7C C0                  553 	.db #0xC0	; 192
   4F7D 84                  554 	.db #0x84	; 132
   4F7E 4C                  555 	.db #0x4C	; 76	'L'
   4F7F CC                  556 	.db #0xCC	; 204
   4F80 CC                  557 	.db #0xCC	; 204
   4F81 8C                  558 	.db #0x8C	; 140
   4F82 48                  559 	.db #0x48	; 72	'H'
   4F83 C0                  560 	.db #0xC0	; 192
   4F84 C0                  561 	.db #0xC0	; 192
   4F85 C0                  562 	.db #0xC0	; 192
   4F86 84                  563 	.db #0x84	; 132
   4F87 0C                  564 	.db #0x0C	; 12
   4F88 0C                  565 	.db #0x0C	; 12
   4F89 48                  566 	.db #0x48	; 72	'H'
   4F8A C0                  567 	.db #0xC0	; 192
   4F8B C0                  568 	.db #0xC0	; 192
                            569 	.area _INITIALIZER
                            570 	.area _CABS (ABS)
