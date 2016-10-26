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
   4D33                      57 _ui_playerstats_render_all::
                             58 ;src/UI_PlayerStats.c:25: print_text("STATS", UI_PLAYERSTATS_POSITION+1,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4D33 21 01 03      [10]   59 	ld	hl,#0x0301
   4D36 E5            [11]   60 	push	hl
   4D37 21 A1 C0      [10]   61 	ld	hl,#0xC0A1
   4D3A E5            [11]   62 	push	hl
   4D3B 21 63 4D      [10]   63 	ld	hl,#___str_0
   4D3E E5            [11]   64 	push	hl
   4D3F CD 39 3F      [17]   65 	call	_print_text
   4D42 21 06 00      [10]   66 	ld	hl,#6
   4D45 39            [11]   67 	add	hl,sp
   4D46 F9            [ 6]   68 	ld	sp,hl
                             69 ;src/UI_PlayerStats.c:26: ui_playerstats_render_hp();
   4D47 CD 73 4D      [17]   70 	call	_ui_playerstats_render_hp
                             71 ;src/UI_PlayerStats.c:27: ui_playerstats_render_attack();
   4D4A CD D4 4D      [17]   72 	call	_ui_playerstats_render_attack
                             73 ;src/UI_PlayerStats.c:28: ui_playerstats_render_defense();
   4D4D CD 0A 4E      [17]   74 	call	_ui_playerstats_render_defense
                             75 ;src/UI_PlayerStats.c:29: ui_playerstats_render_potions();
   4D50 CD 40 4E      [17]   76 	call	_ui_playerstats_render_potions
                             77 ;src/UI_PlayerStats.c:30: ui_playerstats_render_scrolls();
   4D53 CD 76 4E      [17]   78 	call	_ui_playerstats_render_scrolls
                             79 ;src/UI_PlayerStats.c:31: ui_playerstats_render_key();
   4D56 C3 AC 4E      [10]   80 	jp  _ui_playerstats_render_key
   4D59                      81 _strings:
   4D59 69 4D                82 	.dw __str_1
   4D5B 6B 4D                83 	.dw __str_2
   4D5D 6D 4D                84 	.dw __str_3
   4D5F 6F 4D                85 	.dw __str_4
   4D61 71 4D                86 	.dw __str_5
   4D63                      87 ___str_0:
   4D63 53 54 41 54 53       88 	.ascii "STATS"
   4D68 00                   89 	.db 0x00
   4D69                      90 __str_1:
   4D69 2B                   91 	.ascii "+"
   4D6A 00                   92 	.db 0x00
   4D6B                      93 __str_2:
   4D6B 23                   94 	.ascii "#"
   4D6C 00                   95 	.db 0x00
   4D6D                      96 __str_3:
   4D6D 26                   97 	.ascii "&"
   4D6E 00                   98 	.db 0x00
   4D6F                      99 __str_4:
   4D6F 7E                  100 	.ascii "~"
   4D70 00                  101 	.db 0x00
   4D71                     102 __str_5:
   4D71 24                  103 	.ascii "$"
   4D72 00                  104 	.db 0x00
                            105 ;src/UI_PlayerStats.c:35: void ui_playerstats_render_hp(){
                            106 ;	---------------------------------
                            107 ; Function ui_playerstats_render_hp
                            108 ; ---------------------------------
   4D73                     109 _ui_playerstats_render_hp::
                            110 ;src/UI_PlayerStats.c:36: u8 h = 1+((u16)player_health_points*9)/255;
   4D73 21 07 87      [10]  111 	ld	hl,#_player_health_points + 0
   4D76 4E            [ 7]  112 	ld	c, (hl)
   4D77 06 00         [ 7]  113 	ld	b,#0x00
   4D79 69            [ 4]  114 	ld	l, c
   4D7A 60            [ 4]  115 	ld	h, b
   4D7B 29            [11]  116 	add	hl, hl
   4D7C 29            [11]  117 	add	hl, hl
   4D7D 29            [11]  118 	add	hl, hl
   4D7E 09            [11]  119 	add	hl, bc
   4D7F 01 FF 00      [10]  120 	ld	bc,#0x00FF
   4D82 C5            [11]  121 	push	bc
   4D83 E5            [11]  122 	push	hl
   4D84 CD 08 7A      [17]  123 	call	__divuint
   4D87 F1            [10]  124 	pop	af
   4D88 F1            [10]  125 	pop	af
   4D89 45            [ 4]  126 	ld	b,l
   4D8A 04            [ 4]  127 	inc	b
                            128 ;src/UI_PlayerStats.c:37: print_text("HP", UI_PLAYERSTATS_POSITION+160,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4D8B C5            [11]  129 	push	bc
   4D8C 21 01 03      [10]  130 	ld	hl,#0x0301
   4D8F E5            [11]  131 	push	hl
   4D90 21 40 C1      [10]  132 	ld	hl,#0xC140
   4D93 E5            [11]  133 	push	hl
   4D94 21 D1 4D      [10]  134 	ld	hl,#___str_6
   4D97 E5            [11]  135 	push	hl
   4D98 CD 39 3F      [17]  136 	call	_print_text
   4D9B 21 06 00      [10]  137 	ld	hl,#6
   4D9E 39            [11]  138 	add	hl,sp
   4D9F F9            [ 6]  139 	ld	sp,hl
   4DA0 C1            [10]  140 	pop	bc
                            141 ;src/UI_PlayerStats.c:40: cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[UI_PLAYERSTATS_HEALTHBAR_BG_COLOR], 10,4);
   4DA1 21 2C 1C      [10]  142 	ld	hl, #_g_colors + 4
   4DA4 56            [ 7]  143 	ld	d,(hl)
   4DA5 C5            [11]  144 	push	bc
   4DA6 21 0A 04      [10]  145 	ld	hl,#0x040A
   4DA9 E5            [11]  146 	push	hl
   4DAA D5            [11]  147 	push	de
   4DAB 33            [ 6]  148 	inc	sp
   4DAC 21 44 C9      [10]  149 	ld	hl,#0xC944
   4DAF E5            [11]  150 	push	hl
   4DB0 CD 2F 85      [17]  151 	call	_cpct_drawSolidBox
   4DB3 F1            [10]  152 	pop	af
   4DB4 F1            [10]  153 	pop	af
   4DB5 33            [ 6]  154 	inc	sp
   4DB6 C1            [10]  155 	pop	bc
                            156 ;src/UI_PlayerStats.c:41: if(!player_is_dead) cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[UI_PLAYERSTATS_HEALTHBAR_FG_COLOR], h,4);
   4DB7 3A 08 87      [13]  157 	ld	a,(#_player_is_dead + 0)
   4DBA B7            [ 4]  158 	or	a, a
   4DBB C0            [11]  159 	ret	NZ
   4DBC 21 2D 1C      [10]  160 	ld	hl, #_g_colors + 5
   4DBF 56            [ 7]  161 	ld	d,(hl)
   4DC0 3E 04         [ 7]  162 	ld	a,#0x04
   4DC2 F5            [11]  163 	push	af
   4DC3 33            [ 6]  164 	inc	sp
   4DC4 4A            [ 4]  165 	ld	c, d
   4DC5 C5            [11]  166 	push	bc
   4DC6 21 44 C9      [10]  167 	ld	hl,#0xC944
   4DC9 E5            [11]  168 	push	hl
   4DCA CD 2F 85      [17]  169 	call	_cpct_drawSolidBox
   4DCD F1            [10]  170 	pop	af
   4DCE F1            [10]  171 	pop	af
   4DCF 33            [ 6]  172 	inc	sp
   4DD0 C9            [10]  173 	ret
   4DD1                     174 ___str_6:
   4DD1 48 50               175 	.ascii "HP"
   4DD3 00                  176 	.db 0x00
                            177 ;src/UI_PlayerStats.c:45: void ui_playerstats_render_attack(){
                            178 ;	---------------------------------
                            179 ; Function ui_playerstats_render_attack
                            180 ; ---------------------------------
   4DD4                     181 _ui_playerstats_render_attack::
                            182 ;src/UI_PlayerStats.c:46: print_text(strings[0], UI_PLAYERSTATS_POSITION+320,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4DD4 ED 4B 59 4D   [20]  183 	ld	bc, (#_strings + 0)
   4DD8 21 01 03      [10]  184 	ld	hl,#0x0301
   4DDB E5            [11]  185 	push	hl
   4DDC 21 E0 C1      [10]  186 	ld	hl,#0xC1E0
   4DDF E5            [11]  187 	push	hl
   4DE0 C5            [11]  188 	push	bc
   4DE1 CD 39 3F      [17]  189 	call	_print_text
   4DE4 21 06 00      [10]  190 	ld	hl,#6
   4DE7 39            [11]  191 	add	hl,sp
   4DE8 F9            [ 6]  192 	ld	sp,hl
                            193 ;src/UI_PlayerStats.c:47: print_text(integer_to_string(player_attack_value,'d'), UI_PLAYERSTATS_POSITION+324,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4DE9 3E 64         [ 7]  194 	ld	a,#0x64
   4DEB F5            [11]  195 	push	af
   4DEC 33            [ 6]  196 	inc	sp
   4DED 3A 06 87      [13]  197 	ld	a,(_player_attack_value)
   4DF0 F5            [11]  198 	push	af
   4DF1 33            [ 6]  199 	inc	sp
   4DF2 CD D2 3D      [17]  200 	call	_integer_to_string
   4DF5 F1            [10]  201 	pop	af
   4DF6 4D            [ 4]  202 	ld	c,l
   4DF7 44            [ 4]  203 	ld	b,h
   4DF8 21 01 03      [10]  204 	ld	hl,#0x0301
   4DFB E5            [11]  205 	push	hl
   4DFC 21 E4 C1      [10]  206 	ld	hl,#0xC1E4
   4DFF E5            [11]  207 	push	hl
   4E00 C5            [11]  208 	push	bc
   4E01 CD 39 3F      [17]  209 	call	_print_text
   4E04 21 06 00      [10]  210 	ld	hl,#6
   4E07 39            [11]  211 	add	hl,sp
   4E08 F9            [ 6]  212 	ld	sp,hl
   4E09 C9            [10]  213 	ret
                            214 ;src/UI_PlayerStats.c:50: void ui_playerstats_render_defense(){
                            215 ;	---------------------------------
                            216 ; Function ui_playerstats_render_defense
                            217 ; ---------------------------------
   4E0A                     218 _ui_playerstats_render_defense::
                            219 ;src/UI_PlayerStats.c:51: print_text(strings[1], UI_PLAYERSTATS_POSITION+400,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4E0A ED 4B 5B 4D   [20]  220 	ld	bc, (#(_strings + 0x0002) + 0)
   4E0E 21 01 03      [10]  221 	ld	hl,#0x0301
   4E11 E5            [11]  222 	push	hl
   4E12 21 30 C2      [10]  223 	ld	hl,#0xC230
   4E15 E5            [11]  224 	push	hl
   4E16 C5            [11]  225 	push	bc
   4E17 CD 39 3F      [17]  226 	call	_print_text
   4E1A 21 06 00      [10]  227 	ld	hl,#6
   4E1D 39            [11]  228 	add	hl,sp
   4E1E F9            [ 6]  229 	ld	sp,hl
                            230 ;src/UI_PlayerStats.c:52: print_text(integer_to_string(player_defense_value,'d'), UI_PLAYERSTATS_POSITION+404,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4E1F 3E 64         [ 7]  231 	ld	a,#0x64
   4E21 F5            [11]  232 	push	af
   4E22 33            [ 6]  233 	inc	sp
   4E23 3A 05 87      [13]  234 	ld	a,(_player_defense_value)
   4E26 F5            [11]  235 	push	af
   4E27 33            [ 6]  236 	inc	sp
   4E28 CD D2 3D      [17]  237 	call	_integer_to_string
   4E2B F1            [10]  238 	pop	af
   4E2C 4D            [ 4]  239 	ld	c,l
   4E2D 44            [ 4]  240 	ld	b,h
   4E2E 21 01 03      [10]  241 	ld	hl,#0x0301
   4E31 E5            [11]  242 	push	hl
   4E32 21 34 C2      [10]  243 	ld	hl,#0xC234
   4E35 E5            [11]  244 	push	hl
   4E36 C5            [11]  245 	push	bc
   4E37 CD 39 3F      [17]  246 	call	_print_text
   4E3A 21 06 00      [10]  247 	ld	hl,#6
   4E3D 39            [11]  248 	add	hl,sp
   4E3E F9            [ 6]  249 	ld	sp,hl
   4E3F C9            [10]  250 	ret
                            251 ;src/UI_PlayerStats.c:55: void ui_playerstats_render_potions(){
                            252 ;	---------------------------------
                            253 ; Function ui_playerstats_render_potions
                            254 ; ---------------------------------
   4E40                     255 _ui_playerstats_render_potions::
                            256 ;src/UI_PlayerStats.c:56: print_text(strings[2], UI_PLAYERSTATS_POSITION+480,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4E40 ED 4B 5D 4D   [20]  257 	ld	bc, (#(_strings + 0x0004) + 0)
   4E44 21 01 03      [10]  258 	ld	hl,#0x0301
   4E47 E5            [11]  259 	push	hl
   4E48 21 80 C2      [10]  260 	ld	hl,#0xC280
   4E4B E5            [11]  261 	push	hl
   4E4C C5            [11]  262 	push	bc
   4E4D CD 39 3F      [17]  263 	call	_print_text
   4E50 21 06 00      [10]  264 	ld	hl,#6
   4E53 39            [11]  265 	add	hl,sp
   4E54 F9            [ 6]  266 	ld	sp,hl
                            267 ;src/UI_PlayerStats.c:57: print_text(integer_to_string(player_potion_count,'d'), UI_PLAYERSTATS_POSITION+484,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4E55 3E 64         [ 7]  268 	ld	a,#0x64
   4E57 F5            [11]  269 	push	af
   4E58 33            [ 6]  270 	inc	sp
   4E59 3A 0A 87      [13]  271 	ld	a,(_player_potion_count)
   4E5C F5            [11]  272 	push	af
   4E5D 33            [ 6]  273 	inc	sp
   4E5E CD D2 3D      [17]  274 	call	_integer_to_string
   4E61 F1            [10]  275 	pop	af
   4E62 4D            [ 4]  276 	ld	c,l
   4E63 44            [ 4]  277 	ld	b,h
   4E64 21 01 03      [10]  278 	ld	hl,#0x0301
   4E67 E5            [11]  279 	push	hl
   4E68 21 84 C2      [10]  280 	ld	hl,#0xC284
   4E6B E5            [11]  281 	push	hl
   4E6C C5            [11]  282 	push	bc
   4E6D CD 39 3F      [17]  283 	call	_print_text
   4E70 21 06 00      [10]  284 	ld	hl,#6
   4E73 39            [11]  285 	add	hl,sp
   4E74 F9            [ 6]  286 	ld	sp,hl
   4E75 C9            [10]  287 	ret
                            288 ;src/UI_PlayerStats.c:60: void ui_playerstats_render_scrolls(){
                            289 ;	---------------------------------
                            290 ; Function ui_playerstats_render_scrolls
                            291 ; ---------------------------------
   4E76                     292 _ui_playerstats_render_scrolls::
                            293 ;src/UI_PlayerStats.c:61: print_text(strings[3], UI_PLAYERSTATS_POSITION+560,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4E76 ED 4B 5F 4D   [20]  294 	ld	bc, (#(_strings + 0x0006) + 0)
   4E7A 21 01 03      [10]  295 	ld	hl,#0x0301
   4E7D E5            [11]  296 	push	hl
   4E7E 21 D0 C2      [10]  297 	ld	hl,#0xC2D0
   4E81 E5            [11]  298 	push	hl
   4E82 C5            [11]  299 	push	bc
   4E83 CD 39 3F      [17]  300 	call	_print_text
   4E86 21 06 00      [10]  301 	ld	hl,#6
   4E89 39            [11]  302 	add	hl,sp
   4E8A F9            [ 6]  303 	ld	sp,hl
                            304 ;src/UI_PlayerStats.c:62: print_text(integer_to_string(player_scroll_count,'d'), UI_PLAYERSTATS_POSITION+564, UI_PLAYERSTATS_BG_TEXT_COLOR,UI_PLAYERSTATS_TEXT_COLOR);
   4E8B 3E 64         [ 7]  305 	ld	a,#0x64
   4E8D F5            [11]  306 	push	af
   4E8E 33            [ 6]  307 	inc	sp
   4E8F 3A 0B 87      [13]  308 	ld	a,(_player_scroll_count)
   4E92 F5            [11]  309 	push	af
   4E93 33            [ 6]  310 	inc	sp
   4E94 CD D2 3D      [17]  311 	call	_integer_to_string
   4E97 F1            [10]  312 	pop	af
   4E98 4D            [ 4]  313 	ld	c,l
   4E99 44            [ 4]  314 	ld	b,h
   4E9A 21 01 03      [10]  315 	ld	hl,#0x0301
   4E9D E5            [11]  316 	push	hl
   4E9E 21 D4 C2      [10]  317 	ld	hl,#0xC2D4
   4EA1 E5            [11]  318 	push	hl
   4EA2 C5            [11]  319 	push	bc
   4EA3 CD 39 3F      [17]  320 	call	_print_text
   4EA6 21 06 00      [10]  321 	ld	hl,#6
   4EA9 39            [11]  322 	add	hl,sp
   4EAA F9            [ 6]  323 	ld	sp,hl
   4EAB C9            [10]  324 	ret
                            325 ;src/UI_PlayerStats.c:65: void ui_playerstats_render_key(){
                            326 ;	---------------------------------
                            327 ; Function ui_playerstats_render_key
                            328 ; ---------------------------------
   4EAC                     329 _ui_playerstats_render_key::
                            330 ;src/UI_PlayerStats.c:66: print_text(strings[4], UI_PLAYERSTATS_POSITION+640,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4EAC ED 4B 61 4D   [20]  331 	ld	bc, (#(_strings + 0x0008) + 0)
   4EB0 21 01 03      [10]  332 	ld	hl,#0x0301
   4EB3 E5            [11]  333 	push	hl
   4EB4 21 20 C3      [10]  334 	ld	hl,#0xC320
   4EB7 E5            [11]  335 	push	hl
   4EB8 C5            [11]  336 	push	bc
   4EB9 CD 39 3F      [17]  337 	call	_print_text
   4EBC 21 06 00      [10]  338 	ld	hl,#6
   4EBF 39            [11]  339 	add	hl,sp
   4EC0 F9            [ 6]  340 	ld	sp,hl
                            341 ;src/UI_PlayerStats.c:67: if(player_has_key){
   4EC1 3A 09 87      [13]  342 	ld	a,(#_player_has_key + 0)
   4EC4 B7            [ 4]  343 	or	a, a
   4EC5 28 15         [12]  344 	jr	Z,00102$
                            345 ;src/UI_PlayerStats.c:68: print_text("YES", UI_PLAYERSTATS_POSITION+644,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4EC7 21 01 03      [10]  346 	ld	hl,#0x0301
   4ECA E5            [11]  347 	push	hl
   4ECB 21 24 C3      [10]  348 	ld	hl,#0xC324
   4ECE E5            [11]  349 	push	hl
   4ECF 21 F1 4E      [10]  350 	ld	hl,#___str_7
   4ED2 E5            [11]  351 	push	hl
   4ED3 CD 39 3F      [17]  352 	call	_print_text
   4ED6 21 06 00      [10]  353 	ld	hl,#6
   4ED9 39            [11]  354 	add	hl,sp
   4EDA F9            [ 6]  355 	ld	sp,hl
   4EDB C9            [10]  356 	ret
   4EDC                     357 00102$:
                            358 ;src/UI_PlayerStats.c:71: print_text("NO", UI_PLAYERSTATS_POSITION+646,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4EDC 21 01 03      [10]  359 	ld	hl,#0x0301
   4EDF E5            [11]  360 	push	hl
   4EE0 21 26 C3      [10]  361 	ld	hl,#0xC326
   4EE3 E5            [11]  362 	push	hl
   4EE4 21 F5 4E      [10]  363 	ld	hl,#___str_8
   4EE7 E5            [11]  364 	push	hl
   4EE8 CD 39 3F      [17]  365 	call	_print_text
   4EEB 21 06 00      [10]  366 	ld	hl,#6
   4EEE 39            [11]  367 	add	hl,sp
   4EEF F9            [ 6]  368 	ld	sp,hl
   4EF0 C9            [10]  369 	ret
   4EF1                     370 ___str_7:
   4EF1 59 45 53            371 	.ascii "YES"
   4EF4 00                  372 	.db 0x00
   4EF5                     373 ___str_8:
   4EF5 4E 4F               374 	.ascii "NO"
   4EF7 00                  375 	.db 0x00
                            376 	.area _CODE
                            377 	.area _INITIALIZER
                            378 	.area _CABS (ABS)
