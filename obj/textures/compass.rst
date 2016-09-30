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
                             11 	.globl _g_tile_compass_3
                             12 	.globl _g_tile_compass_2
                             13 	.globl _g_tile_compass_1
                             14 	.globl _g_tile_compass_0
                             15 	.globl _g_tile_compass
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
   5211                      48 _g_tile_compass:
   5211 19 52                49 	.dw _g_tile_compass_0
   5213 99 52                50 	.dw _g_tile_compass_1
   5215 19 53                51 	.dw _g_tile_compass_2
   5217 99 53                52 	.dw _g_tile_compass_3
   5219                      53 _g_tile_compass_0:
   5219 FF                   54 	.db #0xFF	; 255
   521A FF                   55 	.db #0xFF	; 255
   521B EE                   56 	.db #0xEE	; 238
   521C CC                   57 	.db #0xCC	; 204
   521D CC                   58 	.db #0xCC	; 204
   521E DD                   59 	.db #0xDD	; 221
   521F FF                   60 	.db #0xFF	; 255
   5220 FF                   61 	.db #0xFF	; 255
   5221 FF                   62 	.db #0xFF	; 255
   5222 EE                   63 	.db #0xEE	; 238
   5223 8C                   64 	.db #0x8C	; 140
   5224 0C                   65 	.db #0x0C	; 12
   5225 0C                   66 	.db #0x0C	; 12
   5226 4C                   67 	.db #0x4C	; 76	'L'
   5227 DD                   68 	.db #0xDD	; 221
   5228 FF                   69 	.db #0xFF	; 255
   5229 FF                   70 	.db #0xFF	; 255
   522A CC                   71 	.db #0xCC	; 204
   522B 0C                   72 	.db #0x0C	; 12
   522C 0C                   73 	.db #0x0C	; 12
   522D 0C                   74 	.db #0x0C	; 12
   522E 0C                   75 	.db #0x0C	; 12
   522F CC                   76 	.db #0xCC	; 204
   5230 FF                   77 	.db #0xFF	; 255
   5231 EE                   78 	.db #0xEE	; 238
   5232 8C                   79 	.db #0x8C	; 140
   5233 0C                   80 	.db #0x0C	; 12
   5234 0C                   81 	.db #0x0C	; 12
   5235 0C                   82 	.db #0x0C	; 12
   5236 0C                   83 	.db #0x0C	; 12
   5237 4C                   84 	.db #0x4C	; 76	'L'
   5238 DD                   85 	.db #0xDD	; 221
   5239 EE                   86 	.db #0xEE	; 238
   523A 0C                   87 	.db #0x0C	; 12
   523B 0C                   88 	.db #0x0C	; 12
   523C 0C                   89 	.db #0x0C	; 12
   523D 0C                   90 	.db #0x0C	; 12
   523E 0C                   91 	.db #0x0C	; 12
   523F 0C                   92 	.db #0x0C	; 12
   5240 DD                   93 	.db #0xDD	; 221
   5241 8C                   94 	.db #0x8C	; 140
   5242 0C                   95 	.db #0x0C	; 12
   5243 0C                   96 	.db #0x0C	; 12
   5244 0C                   97 	.db #0x0C	; 12
   5245 0C                   98 	.db #0x0C	; 12
   5246 0C                   99 	.db #0x0C	; 12
   5247 0C                  100 	.db #0x0C	; 12
   5248 4C                  101 	.db #0x4C	; 76	'L'
   5249 8C                  102 	.db #0x8C	; 140
   524A 0C                  103 	.db #0x0C	; 12
   524B 0C                  104 	.db #0x0C	; 12
   524C 0C                  105 	.db #0x0C	; 12
   524D 0C                  106 	.db #0x0C	; 12
   524E 0C                  107 	.db #0x0C	; 12
   524F 0C                  108 	.db #0x0C	; 12
   5250 4C                  109 	.db #0x4C	; 76	'L'
   5251 8C                  110 	.db #0x8C	; 140
   5252 0C                  111 	.db #0x0C	; 12
   5253 0C                  112 	.db #0x0C	; 12
   5254 0C                  113 	.db #0x0C	; 12
   5255 3F                  114 	.db #0x3F	; 63
   5256 3F                  115 	.db #0x3F	; 63
   5257 3F                  116 	.db #0x3F	; 63
   5258 6E                  117 	.db #0x6E	; 110	'n'
   5259 8C                  118 	.db #0x8C	; 140
   525A 0C                  119 	.db #0x0C	; 12
   525B 0C                  120 	.db #0x0C	; 12
   525C 0C                  121 	.db #0x0C	; 12
   525D 3F                  122 	.db #0x3F	; 63
   525E 3F                  123 	.db #0x3F	; 63
   525F 3F                  124 	.db #0x3F	; 63
   5260 6E                  125 	.db #0x6E	; 110	'n'
   5261 8C                  126 	.db #0x8C	; 140
   5262 0C                  127 	.db #0x0C	; 12
   5263 0C                  128 	.db #0x0C	; 12
   5264 0C                  129 	.db #0x0C	; 12
   5265 0C                  130 	.db #0x0C	; 12
   5266 0C                  131 	.db #0x0C	; 12
   5267 0C                  132 	.db #0x0C	; 12
   5268 4C                  133 	.db #0x4C	; 76	'L'
   5269 8C                  134 	.db #0x8C	; 140
   526A 0C                  135 	.db #0x0C	; 12
   526B 0C                  136 	.db #0x0C	; 12
   526C 0C                  137 	.db #0x0C	; 12
   526D 0C                  138 	.db #0x0C	; 12
   526E 0C                  139 	.db #0x0C	; 12
   526F 0C                  140 	.db #0x0C	; 12
   5270 4C                  141 	.db #0x4C	; 76	'L'
   5271 EE                  142 	.db #0xEE	; 238
   5272 0C                  143 	.db #0x0C	; 12
   5273 0C                  144 	.db #0x0C	; 12
   5274 0C                  145 	.db #0x0C	; 12
   5275 0C                  146 	.db #0x0C	; 12
   5276 0C                  147 	.db #0x0C	; 12
   5277 0C                  148 	.db #0x0C	; 12
   5278 DD                  149 	.db #0xDD	; 221
   5279 EE                  150 	.db #0xEE	; 238
   527A 8C                  151 	.db #0x8C	; 140
   527B 0C                  152 	.db #0x0C	; 12
   527C 0C                  153 	.db #0x0C	; 12
   527D 0C                  154 	.db #0x0C	; 12
   527E 0C                  155 	.db #0x0C	; 12
   527F 4C                  156 	.db #0x4C	; 76	'L'
   5280 DD                  157 	.db #0xDD	; 221
   5281 FF                  158 	.db #0xFF	; 255
   5282 CC                  159 	.db #0xCC	; 204
   5283 0C                  160 	.db #0x0C	; 12
   5284 0C                  161 	.db #0x0C	; 12
   5285 0C                  162 	.db #0x0C	; 12
   5286 0C                  163 	.db #0x0C	; 12
   5287 CC                  164 	.db #0xCC	; 204
   5288 FF                  165 	.db #0xFF	; 255
   5289 FF                  166 	.db #0xFF	; 255
   528A EE                  167 	.db #0xEE	; 238
   528B 8C                  168 	.db #0x8C	; 140
   528C 0C                  169 	.db #0x0C	; 12
   528D 0C                  170 	.db #0x0C	; 12
   528E 4C                  171 	.db #0x4C	; 76	'L'
   528F DD                  172 	.db #0xDD	; 221
   5290 FF                  173 	.db #0xFF	; 255
   5291 FF                  174 	.db #0xFF	; 255
   5292 FF                  175 	.db #0xFF	; 255
   5293 EE                  176 	.db #0xEE	; 238
   5294 CC                  177 	.db #0xCC	; 204
   5295 CC                  178 	.db #0xCC	; 204
   5296 DD                  179 	.db #0xDD	; 221
   5297 FF                  180 	.db #0xFF	; 255
   5298 FF                  181 	.db #0xFF	; 255
   5299                     182 _g_tile_compass_1:
   5299 FF                  183 	.db #0xFF	; 255
   529A FF                  184 	.db #0xFF	; 255
   529B EE                  185 	.db #0xEE	; 238
   529C CC                  186 	.db #0xCC	; 204
   529D CC                  187 	.db #0xCC	; 204
   529E DD                  188 	.db #0xDD	; 221
   529F FF                  189 	.db #0xFF	; 255
   52A0 FF                  190 	.db #0xFF	; 255
   52A1 FF                  191 	.db #0xFF	; 255
   52A2 EE                  192 	.db #0xEE	; 238
   52A3 8C                  193 	.db #0x8C	; 140
   52A4 1D                  194 	.db #0x1D	; 29
   52A5 2E                  195 	.db #0x2E	; 46
   52A6 4C                  196 	.db #0x4C	; 76	'L'
   52A7 DD                  197 	.db #0xDD	; 221
   52A8 FF                  198 	.db #0xFF	; 255
   52A9 FF                  199 	.db #0xFF	; 255
   52AA CC                  200 	.db #0xCC	; 204
   52AB 0C                  201 	.db #0x0C	; 12
   52AC 1D                  202 	.db #0x1D	; 29
   52AD 2E                  203 	.db #0x2E	; 46
   52AE 0C                  204 	.db #0x0C	; 12
   52AF CC                  205 	.db #0xCC	; 204
   52B0 FF                  206 	.db #0xFF	; 255
   52B1 EE                  207 	.db #0xEE	; 238
   52B2 8C                  208 	.db #0x8C	; 140
   52B3 0C                  209 	.db #0x0C	; 12
   52B4 1D                  210 	.db #0x1D	; 29
   52B5 2E                  211 	.db #0x2E	; 46
   52B6 0C                  212 	.db #0x0C	; 12
   52B7 4C                  213 	.db #0x4C	; 76	'L'
   52B8 DD                  214 	.db #0xDD	; 221
   52B9 EE                  215 	.db #0xEE	; 238
   52BA 0C                  216 	.db #0x0C	; 12
   52BB 0C                  217 	.db #0x0C	; 12
   52BC 1D                  218 	.db #0x1D	; 29
   52BD 2E                  219 	.db #0x2E	; 46
   52BE 0C                  220 	.db #0x0C	; 12
   52BF 0C                  221 	.db #0x0C	; 12
   52C0 DD                  222 	.db #0xDD	; 221
   52C1 8C                  223 	.db #0x8C	; 140
   52C2 0C                  224 	.db #0x0C	; 12
   52C3 0C                  225 	.db #0x0C	; 12
   52C4 1D                  226 	.db #0x1D	; 29
   52C5 2E                  227 	.db #0x2E	; 46
   52C6 0C                  228 	.db #0x0C	; 12
   52C7 0C                  229 	.db #0x0C	; 12
   52C8 4C                  230 	.db #0x4C	; 76	'L'
   52C9 8C                  231 	.db #0x8C	; 140
   52CA 0C                  232 	.db #0x0C	; 12
   52CB 0C                  233 	.db #0x0C	; 12
   52CC 1D                  234 	.db #0x1D	; 29
   52CD 2E                  235 	.db #0x2E	; 46
   52CE 0C                  236 	.db #0x0C	; 12
   52CF 0C                  237 	.db #0x0C	; 12
   52D0 4C                  238 	.db #0x4C	; 76	'L'
   52D1 8C                  239 	.db #0x8C	; 140
   52D2 0C                  240 	.db #0x0C	; 12
   52D3 0C                  241 	.db #0x0C	; 12
   52D4 1D                  242 	.db #0x1D	; 29
   52D5 2E                  243 	.db #0x2E	; 46
   52D6 0C                  244 	.db #0x0C	; 12
   52D7 0C                  245 	.db #0x0C	; 12
   52D8 4C                  246 	.db #0x4C	; 76	'L'
   52D9 8C                  247 	.db #0x8C	; 140
   52DA 0C                  248 	.db #0x0C	; 12
   52DB 0C                  249 	.db #0x0C	; 12
   52DC 0C                  250 	.db #0x0C	; 12
   52DD 0C                  251 	.db #0x0C	; 12
   52DE 0C                  252 	.db #0x0C	; 12
   52DF 0C                  253 	.db #0x0C	; 12
   52E0 4C                  254 	.db #0x4C	; 76	'L'
   52E1 8C                  255 	.db #0x8C	; 140
   52E2 0C                  256 	.db #0x0C	; 12
   52E3 0C                  257 	.db #0x0C	; 12
   52E4 0C                  258 	.db #0x0C	; 12
   52E5 0C                  259 	.db #0x0C	; 12
   52E6 0C                  260 	.db #0x0C	; 12
   52E7 0C                  261 	.db #0x0C	; 12
   52E8 4C                  262 	.db #0x4C	; 76	'L'
   52E9 8C                  263 	.db #0x8C	; 140
   52EA 0C                  264 	.db #0x0C	; 12
   52EB 0C                  265 	.db #0x0C	; 12
   52EC 0C                  266 	.db #0x0C	; 12
   52ED 0C                  267 	.db #0x0C	; 12
   52EE 0C                  268 	.db #0x0C	; 12
   52EF 0C                  269 	.db #0x0C	; 12
   52F0 4C                  270 	.db #0x4C	; 76	'L'
   52F1 EE                  271 	.db #0xEE	; 238
   52F2 0C                  272 	.db #0x0C	; 12
   52F3 0C                  273 	.db #0x0C	; 12
   52F4 0C                  274 	.db #0x0C	; 12
   52F5 0C                  275 	.db #0x0C	; 12
   52F6 0C                  276 	.db #0x0C	; 12
   52F7 0C                  277 	.db #0x0C	; 12
   52F8 DD                  278 	.db #0xDD	; 221
   52F9 EE                  279 	.db #0xEE	; 238
   52FA 8C                  280 	.db #0x8C	; 140
   52FB 0C                  281 	.db #0x0C	; 12
   52FC 0C                  282 	.db #0x0C	; 12
   52FD 0C                  283 	.db #0x0C	; 12
   52FE 0C                  284 	.db #0x0C	; 12
   52FF 4C                  285 	.db #0x4C	; 76	'L'
   5300 DD                  286 	.db #0xDD	; 221
   5301 FF                  287 	.db #0xFF	; 255
   5302 CC                  288 	.db #0xCC	; 204
   5303 0C                  289 	.db #0x0C	; 12
   5304 0C                  290 	.db #0x0C	; 12
   5305 0C                  291 	.db #0x0C	; 12
   5306 0C                  292 	.db #0x0C	; 12
   5307 CC                  293 	.db #0xCC	; 204
   5308 FF                  294 	.db #0xFF	; 255
   5309 FF                  295 	.db #0xFF	; 255
   530A EE                  296 	.db #0xEE	; 238
   530B 8C                  297 	.db #0x8C	; 140
   530C 0C                  298 	.db #0x0C	; 12
   530D 0C                  299 	.db #0x0C	; 12
   530E 4C                  300 	.db #0x4C	; 76	'L'
   530F DD                  301 	.db #0xDD	; 221
   5310 FF                  302 	.db #0xFF	; 255
   5311 FF                  303 	.db #0xFF	; 255
   5312 FF                  304 	.db #0xFF	; 255
   5313 EE                  305 	.db #0xEE	; 238
   5314 CC                  306 	.db #0xCC	; 204
   5315 CC                  307 	.db #0xCC	; 204
   5316 DD                  308 	.db #0xDD	; 221
   5317 FF                  309 	.db #0xFF	; 255
   5318 FF                  310 	.db #0xFF	; 255
   5319                     311 _g_tile_compass_2:
   5319 FF                  312 	.db #0xFF	; 255
   531A FF                  313 	.db #0xFF	; 255
   531B EE                  314 	.db #0xEE	; 238
   531C CC                  315 	.db #0xCC	; 204
   531D CC                  316 	.db #0xCC	; 204
   531E DD                  317 	.db #0xDD	; 221
   531F FF                  318 	.db #0xFF	; 255
   5320 FF                  319 	.db #0xFF	; 255
   5321 FF                  320 	.db #0xFF	; 255
   5322 EE                  321 	.db #0xEE	; 238
   5323 8C                  322 	.db #0x8C	; 140
   5324 0C                  323 	.db #0x0C	; 12
   5325 0C                  324 	.db #0x0C	; 12
   5326 4C                  325 	.db #0x4C	; 76	'L'
   5327 DD                  326 	.db #0xDD	; 221
   5328 FF                  327 	.db #0xFF	; 255
   5329 FF                  328 	.db #0xFF	; 255
   532A CC                  329 	.db #0xCC	; 204
   532B 0C                  330 	.db #0x0C	; 12
   532C 0C                  331 	.db #0x0C	; 12
   532D 0C                  332 	.db #0x0C	; 12
   532E 0C                  333 	.db #0x0C	; 12
   532F CC                  334 	.db #0xCC	; 204
   5330 FF                  335 	.db #0xFF	; 255
   5331 EE                  336 	.db #0xEE	; 238
   5332 8C                  337 	.db #0x8C	; 140
   5333 0C                  338 	.db #0x0C	; 12
   5334 0C                  339 	.db #0x0C	; 12
   5335 0C                  340 	.db #0x0C	; 12
   5336 0C                  341 	.db #0x0C	; 12
   5337 4C                  342 	.db #0x4C	; 76	'L'
   5338 DD                  343 	.db #0xDD	; 221
   5339 EE                  344 	.db #0xEE	; 238
   533A 0C                  345 	.db #0x0C	; 12
   533B 0C                  346 	.db #0x0C	; 12
   533C 0C                  347 	.db #0x0C	; 12
   533D 0C                  348 	.db #0x0C	; 12
   533E 0C                  349 	.db #0x0C	; 12
   533F 0C                  350 	.db #0x0C	; 12
   5340 DD                  351 	.db #0xDD	; 221
   5341 8C                  352 	.db #0x8C	; 140
   5342 0C                  353 	.db #0x0C	; 12
   5343 0C                  354 	.db #0x0C	; 12
   5344 0C                  355 	.db #0x0C	; 12
   5345 0C                  356 	.db #0x0C	; 12
   5346 0C                  357 	.db #0x0C	; 12
   5347 0C                  358 	.db #0x0C	; 12
   5348 4C                  359 	.db #0x4C	; 76	'L'
   5349 8C                  360 	.db #0x8C	; 140
   534A 0C                  361 	.db #0x0C	; 12
   534B 0C                  362 	.db #0x0C	; 12
   534C 0C                  363 	.db #0x0C	; 12
   534D 0C                  364 	.db #0x0C	; 12
   534E 0C                  365 	.db #0x0C	; 12
   534F 0C                  366 	.db #0x0C	; 12
   5350 4C                  367 	.db #0x4C	; 76	'L'
   5351 9D                  368 	.db #0x9D	; 157
   5352 3F                  369 	.db #0x3F	; 63
   5353 3F                  370 	.db #0x3F	; 63
   5354 3F                  371 	.db #0x3F	; 63
   5355 0C                  372 	.db #0x0C	; 12
   5356 0C                  373 	.db #0x0C	; 12
   5357 0C                  374 	.db #0x0C	; 12
   5358 4C                  375 	.db #0x4C	; 76	'L'
   5359 9D                  376 	.db #0x9D	; 157
   535A 3F                  377 	.db #0x3F	; 63
   535B 3F                  378 	.db #0x3F	; 63
   535C 3F                  379 	.db #0x3F	; 63
   535D 0C                  380 	.db #0x0C	; 12
   535E 0C                  381 	.db #0x0C	; 12
   535F 0C                  382 	.db #0x0C	; 12
   5360 4C                  383 	.db #0x4C	; 76	'L'
   5361 8C                  384 	.db #0x8C	; 140
   5362 0C                  385 	.db #0x0C	; 12
   5363 0C                  386 	.db #0x0C	; 12
   5364 0C                  387 	.db #0x0C	; 12
   5365 0C                  388 	.db #0x0C	; 12
   5366 0C                  389 	.db #0x0C	; 12
   5367 0C                  390 	.db #0x0C	; 12
   5368 4C                  391 	.db #0x4C	; 76	'L'
   5369 8C                  392 	.db #0x8C	; 140
   536A 0C                  393 	.db #0x0C	; 12
   536B 0C                  394 	.db #0x0C	; 12
   536C 0C                  395 	.db #0x0C	; 12
   536D 0C                  396 	.db #0x0C	; 12
   536E 0C                  397 	.db #0x0C	; 12
   536F 0C                  398 	.db #0x0C	; 12
   5370 4C                  399 	.db #0x4C	; 76	'L'
   5371 EE                  400 	.db #0xEE	; 238
   5372 0C                  401 	.db #0x0C	; 12
   5373 0C                  402 	.db #0x0C	; 12
   5374 0C                  403 	.db #0x0C	; 12
   5375 0C                  404 	.db #0x0C	; 12
   5376 0C                  405 	.db #0x0C	; 12
   5377 0C                  406 	.db #0x0C	; 12
   5378 DD                  407 	.db #0xDD	; 221
   5379 EE                  408 	.db #0xEE	; 238
   537A 8C                  409 	.db #0x8C	; 140
   537B 0C                  410 	.db #0x0C	; 12
   537C 0C                  411 	.db #0x0C	; 12
   537D 0C                  412 	.db #0x0C	; 12
   537E 0C                  413 	.db #0x0C	; 12
   537F 4C                  414 	.db #0x4C	; 76	'L'
   5380 DD                  415 	.db #0xDD	; 221
   5381 FF                  416 	.db #0xFF	; 255
   5382 CC                  417 	.db #0xCC	; 204
   5383 0C                  418 	.db #0x0C	; 12
   5384 0C                  419 	.db #0x0C	; 12
   5385 0C                  420 	.db #0x0C	; 12
   5386 0C                  421 	.db #0x0C	; 12
   5387 CC                  422 	.db #0xCC	; 204
   5388 FF                  423 	.db #0xFF	; 255
   5389 FF                  424 	.db #0xFF	; 255
   538A EE                  425 	.db #0xEE	; 238
   538B 8C                  426 	.db #0x8C	; 140
   538C 0C                  427 	.db #0x0C	; 12
   538D 0C                  428 	.db #0x0C	; 12
   538E 4C                  429 	.db #0x4C	; 76	'L'
   538F DD                  430 	.db #0xDD	; 221
   5390 FF                  431 	.db #0xFF	; 255
   5391 FF                  432 	.db #0xFF	; 255
   5392 FF                  433 	.db #0xFF	; 255
   5393 EE                  434 	.db #0xEE	; 238
   5394 CC                  435 	.db #0xCC	; 204
   5395 CC                  436 	.db #0xCC	; 204
   5396 DD                  437 	.db #0xDD	; 221
   5397 FF                  438 	.db #0xFF	; 255
   5398 FF                  439 	.db #0xFF	; 255
   5399                     440 _g_tile_compass_3:
   5399 FF                  441 	.db #0xFF	; 255
   539A FF                  442 	.db #0xFF	; 255
   539B EE                  443 	.db #0xEE	; 238
   539C CC                  444 	.db #0xCC	; 204
   539D CC                  445 	.db #0xCC	; 204
   539E DD                  446 	.db #0xDD	; 221
   539F FF                  447 	.db #0xFF	; 255
   53A0 FF                  448 	.db #0xFF	; 255
   53A1 FF                  449 	.db #0xFF	; 255
   53A2 EE                  450 	.db #0xEE	; 238
   53A3 8C                  451 	.db #0x8C	; 140
   53A4 0C                  452 	.db #0x0C	; 12
   53A5 0C                  453 	.db #0x0C	; 12
   53A6 4C                  454 	.db #0x4C	; 76	'L'
   53A7 DD                  455 	.db #0xDD	; 221
   53A8 FF                  456 	.db #0xFF	; 255
   53A9 FF                  457 	.db #0xFF	; 255
   53AA CC                  458 	.db #0xCC	; 204
   53AB 0C                  459 	.db #0x0C	; 12
   53AC 0C                  460 	.db #0x0C	; 12
   53AD 0C                  461 	.db #0x0C	; 12
   53AE 0C                  462 	.db #0x0C	; 12
   53AF CC                  463 	.db #0xCC	; 204
   53B0 FF                  464 	.db #0xFF	; 255
   53B1 EE                  465 	.db #0xEE	; 238
   53B2 8C                  466 	.db #0x8C	; 140
   53B3 0C                  467 	.db #0x0C	; 12
   53B4 0C                  468 	.db #0x0C	; 12
   53B5 0C                  469 	.db #0x0C	; 12
   53B6 0C                  470 	.db #0x0C	; 12
   53B7 4C                  471 	.db #0x4C	; 76	'L'
   53B8 DD                  472 	.db #0xDD	; 221
   53B9 EE                  473 	.db #0xEE	; 238
   53BA 0C                  474 	.db #0x0C	; 12
   53BB 0C                  475 	.db #0x0C	; 12
   53BC 0C                  476 	.db #0x0C	; 12
   53BD 0C                  477 	.db #0x0C	; 12
   53BE 0C                  478 	.db #0x0C	; 12
   53BF 0C                  479 	.db #0x0C	; 12
   53C0 DD                  480 	.db #0xDD	; 221
   53C1 8C                  481 	.db #0x8C	; 140
   53C2 0C                  482 	.db #0x0C	; 12
   53C3 0C                  483 	.db #0x0C	; 12
   53C4 0C                  484 	.db #0x0C	; 12
   53C5 0C                  485 	.db #0x0C	; 12
   53C6 0C                  486 	.db #0x0C	; 12
   53C7 0C                  487 	.db #0x0C	; 12
   53C8 4C                  488 	.db #0x4C	; 76	'L'
   53C9 8C                  489 	.db #0x8C	; 140
   53CA 0C                  490 	.db #0x0C	; 12
   53CB 0C                  491 	.db #0x0C	; 12
   53CC 0C                  492 	.db #0x0C	; 12
   53CD 0C                  493 	.db #0x0C	; 12
   53CE 0C                  494 	.db #0x0C	; 12
   53CF 0C                  495 	.db #0x0C	; 12
   53D0 4C                  496 	.db #0x4C	; 76	'L'
   53D1 8C                  497 	.db #0x8C	; 140
   53D2 0C                  498 	.db #0x0C	; 12
   53D3 0C                  499 	.db #0x0C	; 12
   53D4 0C                  500 	.db #0x0C	; 12
   53D5 0C                  501 	.db #0x0C	; 12
   53D6 0C                  502 	.db #0x0C	; 12
   53D7 0C                  503 	.db #0x0C	; 12
   53D8 4C                  504 	.db #0x4C	; 76	'L'
   53D9 8C                  505 	.db #0x8C	; 140
   53DA 0C                  506 	.db #0x0C	; 12
   53DB 0C                  507 	.db #0x0C	; 12
   53DC 1D                  508 	.db #0x1D	; 29
   53DD 2E                  509 	.db #0x2E	; 46
   53DE 0C                  510 	.db #0x0C	; 12
   53DF 0C                  511 	.db #0x0C	; 12
   53E0 4C                  512 	.db #0x4C	; 76	'L'
   53E1 8C                  513 	.db #0x8C	; 140
   53E2 0C                  514 	.db #0x0C	; 12
   53E3 0C                  515 	.db #0x0C	; 12
   53E4 1D                  516 	.db #0x1D	; 29
   53E5 2E                  517 	.db #0x2E	; 46
   53E6 0C                  518 	.db #0x0C	; 12
   53E7 0C                  519 	.db #0x0C	; 12
   53E8 4C                  520 	.db #0x4C	; 76	'L'
   53E9 8C                  521 	.db #0x8C	; 140
   53EA 0C                  522 	.db #0x0C	; 12
   53EB 0C                  523 	.db #0x0C	; 12
   53EC 1D                  524 	.db #0x1D	; 29
   53ED 2E                  525 	.db #0x2E	; 46
   53EE 0C                  526 	.db #0x0C	; 12
   53EF 0C                  527 	.db #0x0C	; 12
   53F0 4C                  528 	.db #0x4C	; 76	'L'
   53F1 EE                  529 	.db #0xEE	; 238
   53F2 0C                  530 	.db #0x0C	; 12
   53F3 0C                  531 	.db #0x0C	; 12
   53F4 1D                  532 	.db #0x1D	; 29
   53F5 2E                  533 	.db #0x2E	; 46
   53F6 0C                  534 	.db #0x0C	; 12
   53F7 0C                  535 	.db #0x0C	; 12
   53F8 DD                  536 	.db #0xDD	; 221
   53F9 EE                  537 	.db #0xEE	; 238
   53FA 8C                  538 	.db #0x8C	; 140
   53FB 0C                  539 	.db #0x0C	; 12
   53FC 1D                  540 	.db #0x1D	; 29
   53FD 2E                  541 	.db #0x2E	; 46
   53FE 0C                  542 	.db #0x0C	; 12
   53FF 4C                  543 	.db #0x4C	; 76	'L'
   5400 DD                  544 	.db #0xDD	; 221
   5401 FF                  545 	.db #0xFF	; 255
   5402 CC                  546 	.db #0xCC	; 204
   5403 0C                  547 	.db #0x0C	; 12
   5404 1D                  548 	.db #0x1D	; 29
   5405 2E                  549 	.db #0x2E	; 46
   5406 0C                  550 	.db #0x0C	; 12
   5407 CC                  551 	.db #0xCC	; 204
   5408 FF                  552 	.db #0xFF	; 255
   5409 FF                  553 	.db #0xFF	; 255
   540A EE                  554 	.db #0xEE	; 238
   540B 8C                  555 	.db #0x8C	; 140
   540C 1D                  556 	.db #0x1D	; 29
   540D 2E                  557 	.db #0x2E	; 46
   540E 4C                  558 	.db #0x4C	; 76	'L'
   540F DD                  559 	.db #0xDD	; 221
   5410 FF                  560 	.db #0xFF	; 255
   5411 FF                  561 	.db #0xFF	; 255
   5412 FF                  562 	.db #0xFF	; 255
   5413 EE                  563 	.db #0xEE	; 238
   5414 CC                  564 	.db #0xCC	; 204
   5415 CC                  565 	.db #0xCC	; 204
   5416 DD                  566 	.db #0xDD	; 221
   5417 FF                  567 	.db #0xFF	; 255
   5418 FF                  568 	.db #0xFF	; 255
                            569 	.area _INITIALIZER
                            570 	.area _CABS (ABS)
