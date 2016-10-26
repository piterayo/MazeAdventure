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
   4DAA                      48 _compass_tileset:
   4DAA B2 4D                49 	.dw _compass_compass_0
   4DAC 32 4E                50 	.dw _compass_compass_1
   4DAE B2 4E                51 	.dw _compass_compass_2
   4DB0 32 4F                52 	.dw _compass_compass_3
   4DB2                      53 _compass_compass_0:
   4DB2 C0                   54 	.db #0xC0	; 192
   4DB3 C0                   55 	.db #0xC0	; 192
   4DB4 C4                   56 	.db #0xC4	; 196
   4DB5 CC                   57 	.db #0xCC	; 204
   4DB6 CC                   58 	.db #0xCC	; 204
   4DB7 C8                   59 	.db #0xC8	; 200
   4DB8 C0                   60 	.db #0xC0	; 192
   4DB9 C0                   61 	.db #0xC0	; 192
   4DBA C0                   62 	.db #0xC0	; 192
   4DBB C4                   63 	.db #0xC4	; 196
   4DBC 8C                   64 	.db #0x8C	; 140
   4DBD 0C                   65 	.db #0x0C	; 12
   4DBE 0C                   66 	.db #0x0C	; 12
   4DBF 4C                   67 	.db #0x4C	; 76	'L'
   4DC0 C8                   68 	.db #0xC8	; 200
   4DC1 C0                   69 	.db #0xC0	; 192
   4DC2 C0                   70 	.db #0xC0	; 192
   4DC3 8C                   71 	.db #0x8C	; 140
   4DC4 48                   72 	.db #0x48	; 72	'H'
   4DC5 C0                   73 	.db #0xC0	; 192
   4DC6 C0                   74 	.db #0xC0	; 192
   4DC7 84                   75 	.db #0x84	; 132
   4DC8 4C                   76 	.db #0x4C	; 76	'L'
   4DC9 C0                   77 	.db #0xC0	; 192
   4DCA C4                   78 	.db #0xC4	; 196
   4DCB 48                   79 	.db #0x48	; 72	'H'
   4DCC C0                   80 	.db #0xC0	; 192
   4DCD C0                   81 	.db #0xC0	; 192
   4DCE C0                   82 	.db #0xC0	; 192
   4DCF C0                   83 	.db #0xC0	; 192
   4DD0 84                   84 	.db #0x84	; 132
   4DD1 C8                   85 	.db #0xC8	; 200
   4DD2 C4                   86 	.db #0xC4	; 196
   4DD3 C0                   87 	.db #0xC0	; 192
   4DD4 C0                   88 	.db #0xC0	; 192
   4DD5 C0                   89 	.db #0xC0	; 192
   4DD6 C0                   90 	.db #0xC0	; 192
   4DD7 C0                   91 	.db #0xC0	; 192
   4DD8 C0                   92 	.db #0xC0	; 192
   4DD9 C8                   93 	.db #0xC8	; 200
   4DDA 8C                   94 	.db #0x8C	; 140
   4DDB C0                   95 	.db #0xC0	; 192
   4DDC C0                   96 	.db #0xC0	; 192
   4DDD C0                   97 	.db #0xC0	; 192
   4DDE C0                   98 	.db #0xC0	; 192
   4DDF C0                   99 	.db #0xC0	; 192
   4DE0 C0                  100 	.db #0xC0	; 192
   4DE1 4C                  101 	.db #0x4C	; 76	'L'
   4DE2 CC                  102 	.db #0xCC	; 204
   4DE3 CC                  103 	.db #0xCC	; 204
   4DE4 CC                  104 	.db #0xCC	; 204
   4DE5 CC                  105 	.db #0xCC	; 204
   4DE6 C0                  106 	.db #0xC0	; 192
   4DE7 C0                  107 	.db #0xC0	; 192
   4DE8 C0                  108 	.db #0xC0	; 192
   4DE9 C4                  109 	.db #0xC4	; 196
   4DEA CC                  110 	.db #0xCC	; 204
   4DEB CC                  111 	.db #0xCC	; 204
   4DEC CC                  112 	.db #0xCC	; 204
   4DED CC                  113 	.db #0xCC	; 204
   4DEE C0                  114 	.db #0xC0	; 192
   4DEF C0                  115 	.db #0xC0	; 192
   4DF0 C0                  116 	.db #0xC0	; 192
   4DF1 C4                  117 	.db #0xC4	; 196
   4DF2 8C                  118 	.db #0x8C	; 140
   4DF3 0C                  119 	.db #0x0C	; 12
   4DF4 0C                  120 	.db #0x0C	; 12
   4DF5 0C                  121 	.db #0x0C	; 12
   4DF6 C0                  122 	.db #0xC0	; 192
   4DF7 C0                  123 	.db #0xC0	; 192
   4DF8 C0                  124 	.db #0xC0	; 192
   4DF9 C4                  125 	.db #0xC4	; 196
   4DFA C8                  126 	.db #0xC8	; 200
   4DFB C0                  127 	.db #0xC0	; 192
   4DFC C0                  128 	.db #0xC0	; 192
   4DFD 30                  129 	.db #0x30	; 48	'0'
   4DFE 30                  130 	.db #0x30	; 48	'0'
   4DFF C0                  131 	.db #0xC0	; 192
   4E00 C0                  132 	.db #0xC0	; 192
   4E01 C4                  133 	.db #0xC4	; 196
   4E02 4C                  134 	.db #0x4C	; 76	'L'
   4E03 C0                  135 	.db #0xC0	; 192
   4E04 C0                  136 	.db #0xC0	; 192
   4E05 60                  137 	.db #0x60	; 96
   4E06 C0                  138 	.db #0xC0	; 192
   4E07 C0                  139 	.db #0xC0	; 192
   4E08 C0                  140 	.db #0xC0	; 192
   4E09 8C                  141 	.db #0x8C	; 140
   4E0A C4                  142 	.db #0xC4	; 196
   4E0B C0                  143 	.db #0xC0	; 192
   4E0C C0                  144 	.db #0xC0	; 192
   4E0D 30                  145 	.db #0x30	; 48	'0'
   4E0E 60                  146 	.db #0x60	; 96
   4E0F C0                  147 	.db #0xC0	; 192
   4E10 C0                  148 	.db #0xC0	; 192
   4E11 C8                  149 	.db #0xC8	; 200
   4E12 84                  150 	.db #0x84	; 132
   4E13 C8                  151 	.db #0xC8	; 200
   4E14 C0                  152 	.db #0xC0	; 192
   4E15 60                  153 	.db #0x60	; 96
   4E16 C0                  154 	.db #0xC0	; 192
   4E17 C0                  155 	.db #0xC0	; 192
   4E18 C4                  156 	.db #0xC4	; 196
   4E19 48                  157 	.db #0x48	; 72	'H'
   4E1A C0                  158 	.db #0xC0	; 192
   4E1B 4C                  159 	.db #0x4C	; 76	'L'
   4E1C C8                  160 	.db #0xC8	; 200
   4E1D 30                  161 	.db #0x30	; 48	'0'
   4E1E 30                  162 	.db #0x30	; 48	'0'
   4E1F C4                  163 	.db #0xC4	; 196
   4E20 8C                  164 	.db #0x8C	; 140
   4E21 C0                  165 	.db #0xC0	; 192
   4E22 C0                  166 	.db #0xC0	; 192
   4E23 84                  167 	.db #0x84	; 132
   4E24 4C                  168 	.db #0x4C	; 76	'L'
   4E25 CC                  169 	.db #0xCC	; 204
   4E26 CC                  170 	.db #0xCC	; 204
   4E27 8C                  171 	.db #0x8C	; 140
   4E28 48                  172 	.db #0x48	; 72	'H'
   4E29 C0                  173 	.db #0xC0	; 192
   4E2A C0                  174 	.db #0xC0	; 192
   4E2B C0                  175 	.db #0xC0	; 192
   4E2C 84                  176 	.db #0x84	; 132
   4E2D 0C                  177 	.db #0x0C	; 12
   4E2E 0C                  178 	.db #0x0C	; 12
   4E2F 48                  179 	.db #0x48	; 72	'H'
   4E30 C0                  180 	.db #0xC0	; 192
   4E31 C0                  181 	.db #0xC0	; 192
   4E32                     182 _compass_compass_1:
   4E32 C0                  183 	.db #0xC0	; 192
   4E33 C0                  184 	.db #0xC0	; 192
   4E34 C4                  185 	.db #0xC4	; 196
   4E35 CC                  186 	.db #0xCC	; 204
   4E36 CC                  187 	.db #0xCC	; 204
   4E37 C8                  188 	.db #0xC8	; 200
   4E38 C0                  189 	.db #0xC0	; 192
   4E39 C0                  190 	.db #0xC0	; 192
   4E3A C0                  191 	.db #0xC0	; 192
   4E3B C4                  192 	.db #0xC4	; 196
   4E3C 8C                  193 	.db #0x8C	; 140
   4E3D 4C                  194 	.db #0x4C	; 76	'L'
   4E3E 8C                  195 	.db #0x8C	; 140
   4E3F 4C                  196 	.db #0x4C	; 76	'L'
   4E40 C8                  197 	.db #0xC8	; 200
   4E41 C0                  198 	.db #0xC0	; 192
   4E42 C0                  199 	.db #0xC0	; 192
   4E43 8C                  200 	.db #0x8C	; 140
   4E44 48                  201 	.db #0x48	; 72	'H'
   4E45 C4                  202 	.db #0xC4	; 196
   4E46 C8                  203 	.db #0xC8	; 200
   4E47 84                  204 	.db #0x84	; 132
   4E48 4C                  205 	.db #0x4C	; 76	'L'
   4E49 C0                  206 	.db #0xC0	; 192
   4E4A C4                  207 	.db #0xC4	; 196
   4E4B 48                  208 	.db #0x48	; 72	'H'
   4E4C C0                  209 	.db #0xC0	; 192
   4E4D C4                  210 	.db #0xC4	; 196
   4E4E C8                  211 	.db #0xC8	; 200
   4E4F C0                  212 	.db #0xC0	; 192
   4E50 84                  213 	.db #0x84	; 132
   4E51 C8                  214 	.db #0xC8	; 200
   4E52 C4                  215 	.db #0xC4	; 196
   4E53 C0                  216 	.db #0xC0	; 192
   4E54 C0                  217 	.db #0xC0	; 192
   4E55 C4                  218 	.db #0xC4	; 196
   4E56 C8                  219 	.db #0xC8	; 200
   4E57 C0                  220 	.db #0xC0	; 192
   4E58 C0                  221 	.db #0xC0	; 192
   4E59 C8                  222 	.db #0xC8	; 200
   4E5A 8C                  223 	.db #0x8C	; 140
   4E5B C0                  224 	.db #0xC0	; 192
   4E5C C0                  225 	.db #0xC0	; 192
   4E5D C4                  226 	.db #0xC4	; 196
   4E5E C8                  227 	.db #0xC8	; 200
   4E5F C0                  228 	.db #0xC0	; 192
   4E60 C0                  229 	.db #0xC0	; 192
   4E61 4C                  230 	.db #0x4C	; 76	'L'
   4E62 C8                  231 	.db #0xC8	; 200
   4E63 C0                  232 	.db #0xC0	; 192
   4E64 C0                  233 	.db #0xC0	; 192
   4E65 C4                  234 	.db #0xC4	; 196
   4E66 C8                  235 	.db #0xC8	; 200
   4E67 C0                  236 	.db #0xC0	; 192
   4E68 C0                  237 	.db #0xC0	; 192
   4E69 C4                  238 	.db #0xC4	; 196
   4E6A C8                  239 	.db #0xC8	; 200
   4E6B C0                  240 	.db #0xC0	; 192
   4E6C C0                  241 	.db #0xC0	; 192
   4E6D 84                  242 	.db #0x84	; 132
   4E6E 48                  243 	.db #0x48	; 72	'H'
   4E6F C0                  244 	.db #0xC0	; 192
   4E70 C0                  245 	.db #0xC0	; 192
   4E71 C4                  246 	.db #0xC4	; 196
   4E72 C8                  247 	.db #0xC8	; 200
   4E73 C0                  248 	.db #0xC0	; 192
   4E74 C0                  249 	.db #0xC0	; 192
   4E75 60                  250 	.db #0x60	; 96
   4E76 90                  251 	.db #0x90	; 144
   4E77 C0                  252 	.db #0xC0	; 192
   4E78 C0                  253 	.db #0xC0	; 192
   4E79 C4                  254 	.db #0xC4	; 196
   4E7A C8                  255 	.db #0xC8	; 200
   4E7B C0                  256 	.db #0xC0	; 192
   4E7C C0                  257 	.db #0xC0	; 192
   4E7D 30                  258 	.db #0x30	; 48	'0'
   4E7E 90                  259 	.db #0x90	; 144
   4E7F C0                  260 	.db #0xC0	; 192
   4E80 C0                  261 	.db #0xC0	; 192
   4E81 C4                  262 	.db #0xC4	; 196
   4E82 4C                  263 	.db #0x4C	; 76	'L'
   4E83 C0                  264 	.db #0xC0	; 192
   4E84 C0                  265 	.db #0xC0	; 192
   4E85 30                  266 	.db #0x30	; 48	'0'
   4E86 90                  267 	.db #0x90	; 144
   4E87 C0                  268 	.db #0xC0	; 192
   4E88 C0                  269 	.db #0xC0	; 192
   4E89 8C                  270 	.db #0x8C	; 140
   4E8A C4                  271 	.db #0xC4	; 196
   4E8B C0                  272 	.db #0xC0	; 192
   4E8C C0                  273 	.db #0xC0	; 192
   4E8D 60                  274 	.db #0x60	; 96
   4E8E 30                  275 	.db #0x30	; 48	'0'
   4E8F C0                  276 	.db #0xC0	; 192
   4E90 C0                  277 	.db #0xC0	; 192
   4E91 C8                  278 	.db #0xC8	; 200
   4E92 84                  279 	.db #0x84	; 132
   4E93 C8                  280 	.db #0xC8	; 200
   4E94 C0                  281 	.db #0xC0	; 192
   4E95 60                  282 	.db #0x60	; 96
   4E96 30                  283 	.db #0x30	; 48	'0'
   4E97 C0                  284 	.db #0xC0	; 192
   4E98 C4                  285 	.db #0xC4	; 196
   4E99 48                  286 	.db #0x48	; 72	'H'
   4E9A C0                  287 	.db #0xC0	; 192
   4E9B 4C                  288 	.db #0x4C	; 76	'L'
   4E9C C8                  289 	.db #0xC8	; 200
   4E9D 60                  290 	.db #0x60	; 96
   4E9E 90                  291 	.db #0x90	; 144
   4E9F C4                  292 	.db #0xC4	; 196
   4EA0 8C                  293 	.db #0x8C	; 140
   4EA1 C0                  294 	.db #0xC0	; 192
   4EA2 C0                  295 	.db #0xC0	; 192
   4EA3 84                  296 	.db #0x84	; 132
   4EA4 4C                  297 	.db #0x4C	; 76	'L'
   4EA5 CC                  298 	.db #0xCC	; 204
   4EA6 CC                  299 	.db #0xCC	; 204
   4EA7 8C                  300 	.db #0x8C	; 140
   4EA8 48                  301 	.db #0x48	; 72	'H'
   4EA9 C0                  302 	.db #0xC0	; 192
   4EAA C0                  303 	.db #0xC0	; 192
   4EAB C0                  304 	.db #0xC0	; 192
   4EAC 84                  305 	.db #0x84	; 132
   4EAD 0C                  306 	.db #0x0C	; 12
   4EAE 0C                  307 	.db #0x0C	; 12
   4EAF 48                  308 	.db #0x48	; 72	'H'
   4EB0 C0                  309 	.db #0xC0	; 192
   4EB1 C0                  310 	.db #0xC0	; 192
   4EB2                     311 _compass_compass_2:
   4EB2 C0                  312 	.db #0xC0	; 192
   4EB3 C0                  313 	.db #0xC0	; 192
   4EB4 C4                  314 	.db #0xC4	; 196
   4EB5 CC                  315 	.db #0xCC	; 204
   4EB6 CC                  316 	.db #0xCC	; 204
   4EB7 C8                  317 	.db #0xC8	; 200
   4EB8 C0                  318 	.db #0xC0	; 192
   4EB9 C0                  319 	.db #0xC0	; 192
   4EBA C0                  320 	.db #0xC0	; 192
   4EBB C4                  321 	.db #0xC4	; 196
   4EBC 8C                  322 	.db #0x8C	; 140
   4EBD 0C                  323 	.db #0x0C	; 12
   4EBE 0C                  324 	.db #0x0C	; 12
   4EBF 4C                  325 	.db #0x4C	; 76	'L'
   4EC0 C8                  326 	.db #0xC8	; 200
   4EC1 C0                  327 	.db #0xC0	; 192
   4EC2 C0                  328 	.db #0xC0	; 192
   4EC3 8C                  329 	.db #0x8C	; 140
   4EC4 48                  330 	.db #0x48	; 72	'H'
   4EC5 C0                  331 	.db #0xC0	; 192
   4EC6 C0                  332 	.db #0xC0	; 192
   4EC7 84                  333 	.db #0x84	; 132
   4EC8 4C                  334 	.db #0x4C	; 76	'L'
   4EC9 C0                  335 	.db #0xC0	; 192
   4ECA C4                  336 	.db #0xC4	; 196
   4ECB 48                  337 	.db #0x48	; 72	'H'
   4ECC C0                  338 	.db #0xC0	; 192
   4ECD C0                  339 	.db #0xC0	; 192
   4ECE C0                  340 	.db #0xC0	; 192
   4ECF C0                  341 	.db #0xC0	; 192
   4ED0 84                  342 	.db #0x84	; 132
   4ED1 C8                  343 	.db #0xC8	; 200
   4ED2 C4                  344 	.db #0xC4	; 196
   4ED3 C0                  345 	.db #0xC0	; 192
   4ED4 C0                  346 	.db #0xC0	; 192
   4ED5 C0                  347 	.db #0xC0	; 192
   4ED6 C0                  348 	.db #0xC0	; 192
   4ED7 C0                  349 	.db #0xC0	; 192
   4ED8 C0                  350 	.db #0xC0	; 192
   4ED9 C8                  351 	.db #0xC8	; 200
   4EDA 8C                  352 	.db #0x8C	; 140
   4EDB C0                  353 	.db #0xC0	; 192
   4EDC C0                  354 	.db #0xC0	; 192
   4EDD C0                  355 	.db #0xC0	; 192
   4EDE C0                  356 	.db #0xC0	; 192
   4EDF C0                  357 	.db #0xC0	; 192
   4EE0 C0                  358 	.db #0xC0	; 192
   4EE1 4C                  359 	.db #0x4C	; 76	'L'
   4EE2 C8                  360 	.db #0xC8	; 200
   4EE3 C0                  361 	.db #0xC0	; 192
   4EE4 C0                  362 	.db #0xC0	; 192
   4EE5 C0                  363 	.db #0xC0	; 192
   4EE6 CC                  364 	.db #0xCC	; 204
   4EE7 CC                  365 	.db #0xCC	; 204
   4EE8 CC                  366 	.db #0xCC	; 204
   4EE9 CC                  367 	.db #0xCC	; 204
   4EEA C8                  368 	.db #0xC8	; 200
   4EEB C0                  369 	.db #0xC0	; 192
   4EEC C0                  370 	.db #0xC0	; 192
   4EED C0                  371 	.db #0xC0	; 192
   4EEE CC                  372 	.db #0xCC	; 204
   4EEF CC                  373 	.db #0xCC	; 204
   4EF0 CC                  374 	.db #0xCC	; 204
   4EF1 CC                  375 	.db #0xCC	; 204
   4EF2 C8                  376 	.db #0xC8	; 200
   4EF3 C0                  377 	.db #0xC0	; 192
   4EF4 C0                  378 	.db #0xC0	; 192
   4EF5 C0                  379 	.db #0xC0	; 192
   4EF6 0C                  380 	.db #0x0C	; 12
   4EF7 0C                  381 	.db #0x0C	; 12
   4EF8 0C                  382 	.db #0x0C	; 12
   4EF9 4C                  383 	.db #0x4C	; 76	'L'
   4EFA C8                  384 	.db #0xC8	; 200
   4EFB C0                  385 	.db #0xC0	; 192
   4EFC 90                  386 	.db #0x90	; 144
   4EFD C0                  387 	.db #0xC0	; 192
   4EFE 90                  388 	.db #0x90	; 144
   4EFF C0                  389 	.db #0xC0	; 192
   4F00 C0                  390 	.db #0xC0	; 192
   4F01 C4                  391 	.db #0xC4	; 196
   4F02 4C                  392 	.db #0x4C	; 76	'L'
   4F03 C0                  393 	.db #0xC0	; 192
   4F04 90                  394 	.db #0x90	; 144
   4F05 C0                  395 	.db #0xC0	; 192
   4F06 90                  396 	.db #0x90	; 144
   4F07 C0                  397 	.db #0xC0	; 192
   4F08 C0                  398 	.db #0xC0	; 192
   4F09 8C                  399 	.db #0x8C	; 140
   4F0A C4                  400 	.db #0xC4	; 196
   4F0B C0                  401 	.db #0xC0	; 192
   4F0C 90                  402 	.db #0x90	; 144
   4F0D 90                  403 	.db #0x90	; 144
   4F0E 90                  404 	.db #0x90	; 144
   4F0F C0                  405 	.db #0xC0	; 192
   4F10 C0                  406 	.db #0xC0	; 192
   4F11 C8                  407 	.db #0xC8	; 200
   4F12 84                  408 	.db #0x84	; 132
   4F13 C8                  409 	.db #0xC8	; 200
   4F14 C0                  410 	.db #0xC0	; 192
   4F15 60                  411 	.db #0x60	; 96
   4F16 60                  412 	.db #0x60	; 96
   4F17 C0                  413 	.db #0xC0	; 192
   4F18 C4                  414 	.db #0xC4	; 196
   4F19 48                  415 	.db #0x48	; 72	'H'
   4F1A C0                  416 	.db #0xC0	; 192
   4F1B 4C                  417 	.db #0x4C	; 76	'L'
   4F1C C8                  418 	.db #0xC8	; 200
   4F1D 60                  419 	.db #0x60	; 96
   4F1E 60                  420 	.db #0x60	; 96
   4F1F C4                  421 	.db #0xC4	; 196
   4F20 8C                  422 	.db #0x8C	; 140
   4F21 C0                  423 	.db #0xC0	; 192
   4F22 C0                  424 	.db #0xC0	; 192
   4F23 84                  425 	.db #0x84	; 132
   4F24 4C                  426 	.db #0x4C	; 76	'L'
   4F25 CC                  427 	.db #0xCC	; 204
   4F26 CC                  428 	.db #0xCC	; 204
   4F27 8C                  429 	.db #0x8C	; 140
   4F28 48                  430 	.db #0x48	; 72	'H'
   4F29 C0                  431 	.db #0xC0	; 192
   4F2A C0                  432 	.db #0xC0	; 192
   4F2B C0                  433 	.db #0xC0	; 192
   4F2C 84                  434 	.db #0x84	; 132
   4F2D 0C                  435 	.db #0x0C	; 12
   4F2E 0C                  436 	.db #0x0C	; 12
   4F2F 48                  437 	.db #0x48	; 72	'H'
   4F30 C0                  438 	.db #0xC0	; 192
   4F31 C0                  439 	.db #0xC0	; 192
   4F32                     440 _compass_compass_3:
   4F32 C0                  441 	.db #0xC0	; 192
   4F33 C0                  442 	.db #0xC0	; 192
   4F34 C4                  443 	.db #0xC4	; 196
   4F35 CC                  444 	.db #0xCC	; 204
   4F36 CC                  445 	.db #0xCC	; 204
   4F37 C8                  446 	.db #0xC8	; 200
   4F38 C0                  447 	.db #0xC0	; 192
   4F39 C0                  448 	.db #0xC0	; 192
   4F3A C0                  449 	.db #0xC0	; 192
   4F3B C4                  450 	.db #0xC4	; 196
   4F3C 8C                  451 	.db #0x8C	; 140
   4F3D 0C                  452 	.db #0x0C	; 12
   4F3E 0C                  453 	.db #0x0C	; 12
   4F3F 4C                  454 	.db #0x4C	; 76	'L'
   4F40 C8                  455 	.db #0xC8	; 200
   4F41 C0                  456 	.db #0xC0	; 192
   4F42 C0                  457 	.db #0xC0	; 192
   4F43 8C                  458 	.db #0x8C	; 140
   4F44 48                  459 	.db #0x48	; 72	'H'
   4F45 C0                  460 	.db #0xC0	; 192
   4F46 C0                  461 	.db #0xC0	; 192
   4F47 84                  462 	.db #0x84	; 132
   4F48 4C                  463 	.db #0x4C	; 76	'L'
   4F49 C0                  464 	.db #0xC0	; 192
   4F4A C4                  465 	.db #0xC4	; 196
   4F4B 48                  466 	.db #0x48	; 72	'H'
   4F4C C0                  467 	.db #0xC0	; 192
   4F4D C0                  468 	.db #0xC0	; 192
   4F4E C0                  469 	.db #0xC0	; 192
   4F4F C0                  470 	.db #0xC0	; 192
   4F50 84                  471 	.db #0x84	; 132
   4F51 C8                  472 	.db #0xC8	; 200
   4F52 C4                  473 	.db #0xC4	; 196
   4F53 C0                  474 	.db #0xC0	; 192
   4F54 C0                  475 	.db #0xC0	; 192
   4F55 C0                  476 	.db #0xC0	; 192
   4F56 C0                  477 	.db #0xC0	; 192
   4F57 C0                  478 	.db #0xC0	; 192
   4F58 C0                  479 	.db #0xC0	; 192
   4F59 C8                  480 	.db #0xC8	; 200
   4F5A 8C                  481 	.db #0x8C	; 140
   4F5B C0                  482 	.db #0xC0	; 192
   4F5C C0                  483 	.db #0xC0	; 192
   4F5D C0                  484 	.db #0xC0	; 192
   4F5E C0                  485 	.db #0xC0	; 192
   4F5F C0                  486 	.db #0xC0	; 192
   4F60 C0                  487 	.db #0xC0	; 192
   4F61 4C                  488 	.db #0x4C	; 76	'L'
   4F62 C8                  489 	.db #0xC8	; 200
   4F63 C0                  490 	.db #0xC0	; 192
   4F64 C0                  491 	.db #0xC0	; 192
   4F65 C0                  492 	.db #0xC0	; 192
   4F66 C0                  493 	.db #0xC0	; 192
   4F67 C0                  494 	.db #0xC0	; 192
   4F68 C0                  495 	.db #0xC0	; 192
   4F69 C4                  496 	.db #0xC4	; 196
   4F6A C8                  497 	.db #0xC8	; 200
   4F6B C0                  498 	.db #0xC0	; 192
   4F6C C0                  499 	.db #0xC0	; 192
   4F6D C4                  500 	.db #0xC4	; 196
   4F6E C8                  501 	.db #0xC8	; 200
   4F6F C0                  502 	.db #0xC0	; 192
   4F70 C0                  503 	.db #0xC0	; 192
   4F71 C4                  504 	.db #0xC4	; 196
   4F72 C8                  505 	.db #0xC8	; 200
   4F73 C0                  506 	.db #0xC0	; 192
   4F74 C0                  507 	.db #0xC0	; 192
   4F75 C4                  508 	.db #0xC4	; 196
   4F76 C8                  509 	.db #0xC8	; 200
   4F77 C0                  510 	.db #0xC0	; 192
   4F78 C0                  511 	.db #0xC0	; 192
   4F79 C4                  512 	.db #0xC4	; 196
   4F7A C8                  513 	.db #0xC8	; 200
   4F7B C0                  514 	.db #0xC0	; 192
   4F7C C0                  515 	.db #0xC0	; 192
   4F7D 64                  516 	.db #0x64	; 100	'd'
   4F7E 98                  517 	.db #0x98	; 152
   4F7F C0                  518 	.db #0xC0	; 192
   4F80 C0                  519 	.db #0xC0	; 192
   4F81 C4                  520 	.db #0xC4	; 196
   4F82 4C                  521 	.db #0x4C	; 76	'L'
   4F83 C0                  522 	.db #0xC0	; 192
   4F84 C0                  523 	.db #0xC0	; 192
   4F85 64                  524 	.db #0x64	; 100	'd'
   4F86 C8                  525 	.db #0xC8	; 200
   4F87 C0                  526 	.db #0xC0	; 192
   4F88 C0                  527 	.db #0xC0	; 192
   4F89 8C                  528 	.db #0x8C	; 140
   4F8A C4                  529 	.db #0xC4	; 196
   4F8B C0                  530 	.db #0xC0	; 192
   4F8C C0                  531 	.db #0xC0	; 192
   4F8D 64                  532 	.db #0x64	; 100	'd'
   4F8E 98                  533 	.db #0x98	; 152
   4F8F C0                  534 	.db #0xC0	; 192
   4F90 C0                  535 	.db #0xC0	; 192
   4F91 C8                  536 	.db #0xC8	; 200
   4F92 84                  537 	.db #0x84	; 132
   4F93 C8                  538 	.db #0xC8	; 200
   4F94 C0                  539 	.db #0xC0	; 192
   4F95 C4                  540 	.db #0xC4	; 196
   4F96 98                  541 	.db #0x98	; 152
   4F97 C0                  542 	.db #0xC0	; 192
   4F98 C4                  543 	.db #0xC4	; 196
   4F99 48                  544 	.db #0x48	; 72	'H'
   4F9A C0                  545 	.db #0xC0	; 192
   4F9B 4C                  546 	.db #0x4C	; 76	'L'
   4F9C C8                  547 	.db #0xC8	; 200
   4F9D 64                  548 	.db #0x64	; 100	'd'
   4F9E 98                  549 	.db #0x98	; 152
   4F9F C4                  550 	.db #0xC4	; 196
   4FA0 8C                  551 	.db #0x8C	; 140
   4FA1 C0                  552 	.db #0xC0	; 192
   4FA2 C0                  553 	.db #0xC0	; 192
   4FA3 84                  554 	.db #0x84	; 132
   4FA4 4C                  555 	.db #0x4C	; 76	'L'
   4FA5 CC                  556 	.db #0xCC	; 204
   4FA6 CC                  557 	.db #0xCC	; 204
   4FA7 8C                  558 	.db #0x8C	; 140
   4FA8 48                  559 	.db #0x48	; 72	'H'
   4FA9 C0                  560 	.db #0xC0	; 192
   4FAA C0                  561 	.db #0xC0	; 192
   4FAB C0                  562 	.db #0xC0	; 192
   4FAC 84                  563 	.db #0x84	; 132
   4FAD 0C                  564 	.db #0x0C	; 12
   4FAE 0C                  565 	.db #0x0C	; 12
   4FAF 48                  566 	.db #0x48	; 72	'H'
   4FB0 C0                  567 	.db #0xC0	; 192
   4FB1 C0                  568 	.db #0xC0	; 192
                            569 	.area _INITIALIZER
                            570 	.area _CABS (ABS)
