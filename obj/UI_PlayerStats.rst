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
                             11 	.globl _integer_to_string
                             12 	.globl _print_text
                             13 	.globl _cpct_drawSolidBox
                             14 	.globl _strings
                             15 	.globl _ui_playerstats_render_all
                             16 	.globl _ui_playerstats_render_hp
                             17 	.globl _ui_playerstats_render_attack
                             18 	.globl _ui_playerstats_render_defense
                             19 	.globl _ui_playerstats_render_potions
                             20 	.globl _ui_playerstats_render_scrolls
                             21 	.globl _ui_playerstats_render_key
                             22 ;--------------------------------------------------------
                             23 ; special function registers
                             24 ;--------------------------------------------------------
                             25 ;--------------------------------------------------------
                             26 ; ram data
                             27 ;--------------------------------------------------------
                             28 	.area _DATA
                             29 ;--------------------------------------------------------
                             30 ; ram data
                             31 ;--------------------------------------------------------
                             32 	.area _INITIALIZED
                             33 ;--------------------------------------------------------
                             34 ; absolute external ram data
                             35 ;--------------------------------------------------------
                             36 	.area _DABS (ABS)
                             37 ;--------------------------------------------------------
                             38 ; global & static initialisations
                             39 ;--------------------------------------------------------
                             40 	.area _HOME
                             41 	.area _GSINIT
                             42 	.area _GSFINAL
                             43 	.area _GSINIT
                             44 ;--------------------------------------------------------
                             45 ; Home
                             46 ;--------------------------------------------------------
                             47 	.area _HOME
                             48 	.area _HOME
                             49 ;--------------------------------------------------------
                             50 ; code
                             51 ;--------------------------------------------------------
                             52 	.area _CODE
                             53 ;src/UI_PlayerStats.c:24: void ui_playerstats_render_all(){
                             54 ;	---------------------------------
                             55 ; Function ui_playerstats_render_all
                             56 ; ---------------------------------
   4BE5                      57 _ui_playerstats_render_all::
                             58 ;src/UI_PlayerStats.c:25: print_text("STATS", UI_PLAYERSTATS_POSITION+1,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4BE5 21 01 03      [10]   59 	ld	hl,#0x0301
   4BE8 E5            [11]   60 	push	hl
   4BE9 21 A1 C0      [10]   61 	ld	hl,#0xC0A1
   4BEC E5            [11]   62 	push	hl
   4BED 21 15 4C      [10]   63 	ld	hl,#___str_0
   4BF0 E5            [11]   64 	push	hl
   4BF1 CD EB 3D      [17]   65 	call	_print_text
   4BF4 21 06 00      [10]   66 	ld	hl,#6
   4BF7 39            [11]   67 	add	hl,sp
   4BF8 F9            [ 6]   68 	ld	sp,hl
                             69 ;src/UI_PlayerStats.c:26: ui_playerstats_render_hp();
   4BF9 CD 25 4C      [17]   70 	call	_ui_playerstats_render_hp
                             71 ;src/UI_PlayerStats.c:27: ui_playerstats_render_attack();
   4BFC CD 86 4C      [17]   72 	call	_ui_playerstats_render_attack
                             73 ;src/UI_PlayerStats.c:28: ui_playerstats_render_defense();
   4BFF CD BC 4C      [17]   74 	call	_ui_playerstats_render_defense
                             75 ;src/UI_PlayerStats.c:29: ui_playerstats_render_potions();
   4C02 CD F2 4C      [17]   76 	call	_ui_playerstats_render_potions
                             77 ;src/UI_PlayerStats.c:30: ui_playerstats_render_scrolls();
   4C05 CD 28 4D      [17]   78 	call	_ui_playerstats_render_scrolls
                             79 ;src/UI_PlayerStats.c:31: ui_playerstats_render_key();
   4C08 C3 5E 4D      [10]   80 	jp  _ui_playerstats_render_key
   4C0B                      81 _strings:
   4C0B 1B 4C                82 	.dw __str_1
   4C0D 1D 4C                83 	.dw __str_2
   4C0F 1F 4C                84 	.dw __str_3
   4C11 21 4C                85 	.dw __str_4
   4C13 23 4C                86 	.dw __str_5
   4C15                      87 ___str_0:
   4C15 53 54 41 54 53       88 	.ascii "STATS"
   4C1A 00                   89 	.db 0x00
   4C1B                      90 __str_1:
   4C1B 2B                   91 	.ascii "+"
   4C1C 00                   92 	.db 0x00
   4C1D                      93 __str_2:
   4C1D 23                   94 	.ascii "#"
   4C1E 00                   95 	.db 0x00
   4C1F                      96 __str_3:
   4C1F 26                   97 	.ascii "&"
   4C20 00                   98 	.db 0x00
   4C21                      99 __str_4:
   4C21 7E                  100 	.ascii "~"
   4C22 00                  101 	.db 0x00
   4C23                     102 __str_5:
   4C23 24                  103 	.ascii "$"
   4C24 00                  104 	.db 0x00
                            105 ;src/UI_PlayerStats.c:35: void ui_playerstats_render_hp(){
                            106 ;	---------------------------------
                            107 ; Function ui_playerstats_render_hp
                            108 ; ---------------------------------
   4C25                     109 _ui_playerstats_render_hp::
                            110 ;src/UI_PlayerStats.c:36: u8 h = 1+((u16)player_health_points*9)/255;
   4C25 21 8D 7D      [10]  111 	ld	hl,#_player_health_points + 0
   4C28 4E            [ 7]  112 	ld	c, (hl)
   4C29 06 00         [ 7]  113 	ld	b,#0x00
   4C2B 69            [ 4]  114 	ld	l, c
   4C2C 60            [ 4]  115 	ld	h, b
   4C2D 29            [11]  116 	add	hl, hl
   4C2E 29            [11]  117 	add	hl, hl
   4C2F 29            [11]  118 	add	hl, hl
   4C30 09            [11]  119 	add	hl, bc
   4C31 01 FF 00      [10]  120 	ld	bc,#0x00FF
   4C34 C5            [11]  121 	push	bc
   4C35 E5            [11]  122 	push	hl
   4C36 CD BA 78      [17]  123 	call	__divuint
   4C39 F1            [10]  124 	pop	af
   4C3A F1            [10]  125 	pop	af
   4C3B 45            [ 4]  126 	ld	b,l
   4C3C 04            [ 4]  127 	inc	b
                            128 ;src/UI_PlayerStats.c:37: print_text("HP", UI_PLAYERSTATS_POSITION+160,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4C3D C5            [11]  129 	push	bc
   4C3E 21 01 03      [10]  130 	ld	hl,#0x0301
   4C41 E5            [11]  131 	push	hl
   4C42 21 40 C1      [10]  132 	ld	hl,#0xC140
   4C45 E5            [11]  133 	push	hl
   4C46 21 83 4C      [10]  134 	ld	hl,#___str_6
   4C49 E5            [11]  135 	push	hl
   4C4A CD EB 3D      [17]  136 	call	_print_text
   4C4D 21 06 00      [10]  137 	ld	hl,#6
   4C50 39            [11]  138 	add	hl,sp
   4C51 F9            [ 6]  139 	ld	sp,hl
   4C52 C1            [10]  140 	pop	bc
                            141 ;src/UI_PlayerStats.c:40: cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[UI_PLAYERSTATS_HEALTHBAR_BG_COLOR], 10,4);
   4C53 21 B3 1A      [10]  142 	ld	hl, #_g_colors + 4
   4C56 56            [ 7]  143 	ld	d,(hl)
   4C57 C5            [11]  144 	push	bc
   4C58 21 0A 04      [10]  145 	ld	hl,#0x040A
   4C5B E5            [11]  146 	push	hl
   4C5C D5            [11]  147 	push	de
   4C5D 33            [ 6]  148 	inc	sp
   4C5E 21 44 C9      [10]  149 	ld	hl,#0xC944
   4C61 E5            [11]  150 	push	hl
   4C62 CD B8 7B      [17]  151 	call	_cpct_drawSolidBox
   4C65 F1            [10]  152 	pop	af
   4C66 F1            [10]  153 	pop	af
   4C67 33            [ 6]  154 	inc	sp
   4C68 C1            [10]  155 	pop	bc
                            156 ;src/UI_PlayerStats.c:41: if(!player_is_dead) cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[UI_PLAYERSTATS_HEALTHBAR_FG_COLOR], h,4);
   4C69 3A 8E 7D      [13]  157 	ld	a,(#_player_is_dead + 0)
   4C6C B7            [ 4]  158 	or	a, a
   4C6D C0            [11]  159 	ret	NZ
   4C6E 21 B4 1A      [10]  160 	ld	hl, #_g_colors + 5
   4C71 56            [ 7]  161 	ld	d,(hl)
   4C72 3E 04         [ 7]  162 	ld	a,#0x04
   4C74 F5            [11]  163 	push	af
   4C75 33            [ 6]  164 	inc	sp
   4C76 4A            [ 4]  165 	ld	c, d
   4C77 C5            [11]  166 	push	bc
   4C78 21 44 C9      [10]  167 	ld	hl,#0xC944
   4C7B E5            [11]  168 	push	hl
   4C7C CD B8 7B      [17]  169 	call	_cpct_drawSolidBox
   4C7F F1            [10]  170 	pop	af
   4C80 F1            [10]  171 	pop	af
   4C81 33            [ 6]  172 	inc	sp
   4C82 C9            [10]  173 	ret
   4C83                     174 ___str_6:
   4C83 48 50               175 	.ascii "HP"
   4C85 00                  176 	.db 0x00
                            177 ;src/UI_PlayerStats.c:45: void ui_playerstats_render_attack(){
                            178 ;	---------------------------------
                            179 ; Function ui_playerstats_render_attack
                            180 ; ---------------------------------
   4C86                     181 _ui_playerstats_render_attack::
                            182 ;src/UI_PlayerStats.c:46: print_text(strings[0], UI_PLAYERSTATS_POSITION+320,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4C86 ED 4B 0B 4C   [20]  183 	ld	bc, (#_strings + 0)
   4C8A 21 01 03      [10]  184 	ld	hl,#0x0301
   4C8D E5            [11]  185 	push	hl
   4C8E 21 E0 C1      [10]  186 	ld	hl,#0xC1E0
   4C91 E5            [11]  187 	push	hl
   4C92 C5            [11]  188 	push	bc
   4C93 CD EB 3D      [17]  189 	call	_print_text
   4C96 21 06 00      [10]  190 	ld	hl,#6
   4C99 39            [11]  191 	add	hl,sp
   4C9A F9            [ 6]  192 	ld	sp,hl
                            193 ;src/UI_PlayerStats.c:47: print_text(integer_to_string(player_attack_value,'d'), UI_PLAYERSTATS_POSITION+324,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4C9B 3E 64         [ 7]  194 	ld	a,#0x64
   4C9D F5            [11]  195 	push	af
   4C9E 33            [ 6]  196 	inc	sp
   4C9F 3A 8C 7D      [13]  197 	ld	a,(_player_attack_value)
   4CA2 F5            [11]  198 	push	af
   4CA3 33            [ 6]  199 	inc	sp
   4CA4 CD 84 3C      [17]  200 	call	_integer_to_string
   4CA7 F1            [10]  201 	pop	af
   4CA8 4D            [ 4]  202 	ld	c,l
   4CA9 44            [ 4]  203 	ld	b,h
   4CAA 21 01 03      [10]  204 	ld	hl,#0x0301
   4CAD E5            [11]  205 	push	hl
   4CAE 21 E4 C1      [10]  206 	ld	hl,#0xC1E4
   4CB1 E5            [11]  207 	push	hl
   4CB2 C5            [11]  208 	push	bc
   4CB3 CD EB 3D      [17]  209 	call	_print_text
   4CB6 21 06 00      [10]  210 	ld	hl,#6
   4CB9 39            [11]  211 	add	hl,sp
   4CBA F9            [ 6]  212 	ld	sp,hl
   4CBB C9            [10]  213 	ret
                            214 ;src/UI_PlayerStats.c:50: void ui_playerstats_render_defense(){
                            215 ;	---------------------------------
                            216 ; Function ui_playerstats_render_defense
                            217 ; ---------------------------------
   4CBC                     218 _ui_playerstats_render_defense::
                            219 ;src/UI_PlayerStats.c:51: print_text(strings[1], UI_PLAYERSTATS_POSITION+400,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4CBC ED 4B 0D 4C   [20]  220 	ld	bc, (#(_strings + 0x0002) + 0)
   4CC0 21 01 03      [10]  221 	ld	hl,#0x0301
   4CC3 E5            [11]  222 	push	hl
   4CC4 21 30 C2      [10]  223 	ld	hl,#0xC230
   4CC7 E5            [11]  224 	push	hl
   4CC8 C5            [11]  225 	push	bc
   4CC9 CD EB 3D      [17]  226 	call	_print_text
   4CCC 21 06 00      [10]  227 	ld	hl,#6
   4CCF 39            [11]  228 	add	hl,sp
   4CD0 F9            [ 6]  229 	ld	sp,hl
                            230 ;src/UI_PlayerStats.c:52: print_text(integer_to_string(player_defense_value,'d'), UI_PLAYERSTATS_POSITION+404,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4CD1 3E 64         [ 7]  231 	ld	a,#0x64
   4CD3 F5            [11]  232 	push	af
   4CD4 33            [ 6]  233 	inc	sp
   4CD5 3A 8B 7D      [13]  234 	ld	a,(_player_defense_value)
   4CD8 F5            [11]  235 	push	af
   4CD9 33            [ 6]  236 	inc	sp
   4CDA CD 84 3C      [17]  237 	call	_integer_to_string
   4CDD F1            [10]  238 	pop	af
   4CDE 4D            [ 4]  239 	ld	c,l
   4CDF 44            [ 4]  240 	ld	b,h
   4CE0 21 01 03      [10]  241 	ld	hl,#0x0301
   4CE3 E5            [11]  242 	push	hl
   4CE4 21 34 C2      [10]  243 	ld	hl,#0xC234
   4CE7 E5            [11]  244 	push	hl
   4CE8 C5            [11]  245 	push	bc
   4CE9 CD EB 3D      [17]  246 	call	_print_text
   4CEC 21 06 00      [10]  247 	ld	hl,#6
   4CEF 39            [11]  248 	add	hl,sp
   4CF0 F9            [ 6]  249 	ld	sp,hl
   4CF1 C9            [10]  250 	ret
                            251 ;src/UI_PlayerStats.c:55: void ui_playerstats_render_potions(){
                            252 ;	---------------------------------
                            253 ; Function ui_playerstats_render_potions
                            254 ; ---------------------------------
   4CF2                     255 _ui_playerstats_render_potions::
                            256 ;src/UI_PlayerStats.c:56: print_text(strings[2], UI_PLAYERSTATS_POSITION+480,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4CF2 ED 4B 0F 4C   [20]  257 	ld	bc, (#(_strings + 0x0004) + 0)
   4CF6 21 01 03      [10]  258 	ld	hl,#0x0301
   4CF9 E5            [11]  259 	push	hl
   4CFA 21 80 C2      [10]  260 	ld	hl,#0xC280
   4CFD E5            [11]  261 	push	hl
   4CFE C5            [11]  262 	push	bc
   4CFF CD EB 3D      [17]  263 	call	_print_text
   4D02 21 06 00      [10]  264 	ld	hl,#6
   4D05 39            [11]  265 	add	hl,sp
   4D06 F9            [ 6]  266 	ld	sp,hl
                            267 ;src/UI_PlayerStats.c:57: print_text(integer_to_string(player_potion_count,'d'), UI_PLAYERSTATS_POSITION+484,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4D07 3E 64         [ 7]  268 	ld	a,#0x64
   4D09 F5            [11]  269 	push	af
   4D0A 33            [ 6]  270 	inc	sp
   4D0B 3A 90 7D      [13]  271 	ld	a,(_player_potion_count)
   4D0E F5            [11]  272 	push	af
   4D0F 33            [ 6]  273 	inc	sp
   4D10 CD 84 3C      [17]  274 	call	_integer_to_string
   4D13 F1            [10]  275 	pop	af
   4D14 4D            [ 4]  276 	ld	c,l
   4D15 44            [ 4]  277 	ld	b,h
   4D16 21 01 03      [10]  278 	ld	hl,#0x0301
   4D19 E5            [11]  279 	push	hl
   4D1A 21 84 C2      [10]  280 	ld	hl,#0xC284
   4D1D E5            [11]  281 	push	hl
   4D1E C5            [11]  282 	push	bc
   4D1F CD EB 3D      [17]  283 	call	_print_text
   4D22 21 06 00      [10]  284 	ld	hl,#6
   4D25 39            [11]  285 	add	hl,sp
   4D26 F9            [ 6]  286 	ld	sp,hl
   4D27 C9            [10]  287 	ret
                            288 ;src/UI_PlayerStats.c:60: void ui_playerstats_render_scrolls(){
                            289 ;	---------------------------------
                            290 ; Function ui_playerstats_render_scrolls
                            291 ; ---------------------------------
   4D28                     292 _ui_playerstats_render_scrolls::
                            293 ;src/UI_PlayerStats.c:61: print_text(strings[3], UI_PLAYERSTATS_POSITION+560,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4D28 ED 4B 11 4C   [20]  294 	ld	bc, (#(_strings + 0x0006) + 0)
   4D2C 21 01 03      [10]  295 	ld	hl,#0x0301
   4D2F E5            [11]  296 	push	hl
   4D30 21 D0 C2      [10]  297 	ld	hl,#0xC2D0
   4D33 E5            [11]  298 	push	hl
   4D34 C5            [11]  299 	push	bc
   4D35 CD EB 3D      [17]  300 	call	_print_text
   4D38 21 06 00      [10]  301 	ld	hl,#6
   4D3B 39            [11]  302 	add	hl,sp
   4D3C F9            [ 6]  303 	ld	sp,hl
                            304 ;src/UI_PlayerStats.c:62: print_text(integer_to_string(player_scroll_count,'d'), UI_PLAYERSTATS_POSITION+564, UI_PLAYERSTATS_BG_TEXT_COLOR,UI_PLAYERSTATS_TEXT_COLOR);
   4D3D 3E 64         [ 7]  305 	ld	a,#0x64
   4D3F F5            [11]  306 	push	af
   4D40 33            [ 6]  307 	inc	sp
   4D41 3A 91 7D      [13]  308 	ld	a,(_player_scroll_count)
   4D44 F5            [11]  309 	push	af
   4D45 33            [ 6]  310 	inc	sp
   4D46 CD 84 3C      [17]  311 	call	_integer_to_string
   4D49 F1            [10]  312 	pop	af
   4D4A 4D            [ 4]  313 	ld	c,l
   4D4B 44            [ 4]  314 	ld	b,h
   4D4C 21 01 03      [10]  315 	ld	hl,#0x0301
   4D4F E5            [11]  316 	push	hl
   4D50 21 D4 C2      [10]  317 	ld	hl,#0xC2D4
   4D53 E5            [11]  318 	push	hl
   4D54 C5            [11]  319 	push	bc
   4D55 CD EB 3D      [17]  320 	call	_print_text
   4D58 21 06 00      [10]  321 	ld	hl,#6
   4D5B 39            [11]  322 	add	hl,sp
   4D5C F9            [ 6]  323 	ld	sp,hl
   4D5D C9            [10]  324 	ret
                            325 ;src/UI_PlayerStats.c:65: void ui_playerstats_render_key(){
                            326 ;	---------------------------------
                            327 ; Function ui_playerstats_render_key
                            328 ; ---------------------------------
   4D5E                     329 _ui_playerstats_render_key::
                            330 ;src/UI_PlayerStats.c:66: print_text(strings[4], UI_PLAYERSTATS_POSITION+640,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4D5E ED 4B 13 4C   [20]  331 	ld	bc, (#(_strings + 0x0008) + 0)
   4D62 21 01 03      [10]  332 	ld	hl,#0x0301
   4D65 E5            [11]  333 	push	hl
   4D66 21 20 C3      [10]  334 	ld	hl,#0xC320
   4D69 E5            [11]  335 	push	hl
   4D6A C5            [11]  336 	push	bc
   4D6B CD EB 3D      [17]  337 	call	_print_text
   4D6E 21 06 00      [10]  338 	ld	hl,#6
   4D71 39            [11]  339 	add	hl,sp
   4D72 F9            [ 6]  340 	ld	sp,hl
                            341 ;src/UI_PlayerStats.c:67: if(player_has_key){
   4D73 3A 8F 7D      [13]  342 	ld	a,(#_player_has_key + 0)
   4D76 B7            [ 4]  343 	or	a, a
   4D77 28 15         [12]  344 	jr	Z,00102$
                            345 ;src/UI_PlayerStats.c:68: print_text("YES", UI_PLAYERSTATS_POSITION+644,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4D79 21 01 03      [10]  346 	ld	hl,#0x0301
   4D7C E5            [11]  347 	push	hl
   4D7D 21 24 C3      [10]  348 	ld	hl,#0xC324
   4D80 E5            [11]  349 	push	hl
   4D81 21 A3 4D      [10]  350 	ld	hl,#___str_7
   4D84 E5            [11]  351 	push	hl
   4D85 CD EB 3D      [17]  352 	call	_print_text
   4D88 21 06 00      [10]  353 	ld	hl,#6
   4D8B 39            [11]  354 	add	hl,sp
   4D8C F9            [ 6]  355 	ld	sp,hl
   4D8D C9            [10]  356 	ret
   4D8E                     357 00102$:
                            358 ;src/UI_PlayerStats.c:71: print_text("NO", UI_PLAYERSTATS_POSITION+646,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4D8E 21 01 03      [10]  359 	ld	hl,#0x0301
   4D91 E5            [11]  360 	push	hl
   4D92 21 26 C3      [10]  361 	ld	hl,#0xC326
   4D95 E5            [11]  362 	push	hl
   4D96 21 A7 4D      [10]  363 	ld	hl,#___str_8
   4D99 E5            [11]  364 	push	hl
   4D9A CD EB 3D      [17]  365 	call	_print_text
   4D9D 21 06 00      [10]  366 	ld	hl,#6
   4DA0 39            [11]  367 	add	hl,sp
   4DA1 F9            [ 6]  368 	ld	sp,hl
   4DA2 C9            [10]  369 	ret
   4DA3                     370 ___str_7:
   4DA3 59 45 53            371 	.ascii "YES"
   4DA6 00                  372 	.db 0x00
   4DA7                     373 ___str_8:
   4DA7 4E 4F               374 	.ascii "NO"
   4DA9 00                  375 	.db 0x00
                            376 	.area _CODE
                            377 	.area _INITIALIZER
                            378 	.area _CABS (ABS)
