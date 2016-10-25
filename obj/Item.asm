;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module Item
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _item_new_item
	.globl _ui_log_render
	.globl _ui_log_add_log
	.globl _level_get_level
	.globl _ui_playerstats_render_key
	.globl _ui_playerstats_render_scrolls
	.globl _ui_playerstats_render_potions
	.globl _ui_playerstats_render_defense
	.globl _ui_playerstats_render_attack
	.globl _ui_playerstats_render_hp
	.globl _cpct_getRandom_mxor_u16
	.globl _cpct_getRandom_mxor_u8
	.globl _cpct_memset
	.globl _itemArray
	.globl _item_spawnedKey
	.globl _activeItems
	.globl _item_get_at
	.globl _item_init_items
	.globl _item_try_new_spawn
	.globl _item_try_new_spawn_at
	.globl _item_pick_item
	.globl _item_destroy_item
	.globl _item_use_potion
	.globl _item_use_scroll
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_activeItems::
	.ds 1
_item_spawnedKey::
	.ds 1
_itemArray::
	.ds 35
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/Item.c:23: Item* item_get_at(u8 index){
;	---------------------------------
; Function item_get_at
; ---------------------------------
_item_get_at::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Item.c:24: return (itemArray+index);
	ld	bc,#_itemArray+0
	ld	e,4 (ix)
	ld	d,#0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl,bc
	pop	ix
	ret
;src/Item.c:27: void item_init_items(){
;	---------------------------------
; Function item_init_items
; ---------------------------------
_item_init_items::
;src/Item.c:28: cpct_memset(itemArray, 0, ITEM_MAX_ITEMS*sizeof(Item));
	ld	hl,#0x0023
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	hl,#_itemArray
	push	hl
	call	_cpct_memset
;src/Item.c:29: activeItems=0;
	ld	hl,#_activeItems + 0
	ld	(hl), #0x00
;src/Item.c:30: item_spawnedKey=0;
	ld	hl,#_item_spawnedKey + 0
	ld	(hl), #0x00
	ret
;src/Item.c:39: u8 item_try_new_spawn(){
;	---------------------------------
; Function item_try_new_spawn
; ---------------------------------
_item_try_new_spawn::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;src/Item.c:42: pos.x=cpct_getRandom_mxor_u8()%MAP_WIDTH;
	ld	hl,#0x0000
	add	hl,sp
	push	hl
	call	_cpct_getRandom_mxor_u8
	ld	a,l
	pop	hl
	and	a, #0x1F
	ld	(hl),a
;src/Item.c:43: pos.y=cpct_getRandom_mxor_u8()%MAP_HEIGHT;
	ld	hl,#0x0000
	add	hl,sp
	ld	c,l
	ld	b,h
	ld	e, c
	ld	d, b
	inc	de
	push	bc
	push	de
	call	_cpct_getRandom_mxor_u8
	pop	de
	pop	bc
	ld	a,l
	and	a, #0x1F
	ld	(de),a
;src/Item.c:45: return (item_try_new_spawn_at(&pos));
	push	bc
	call	_item_try_new_spawn_at
	ld	sp,ix
	pop	ix
	ret
;src/Item.c:48: void item_new_item(Vec2u* pos){
;	---------------------------------
; Function item_new_item
; ---------------------------------
_item_new_item::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-13
	add	hl,sp
	ld	sp,hl
;src/Item.c:50: Item* item=(itemArray+ITEM_MAX_ITEMS);
	ld	-6 (ix),#<((_itemArray + 0x0023))
	ld	-5 (ix),#>((_itemArray + 0x0023))
;src/Item.c:54: x=pos->x;
	ld	a,4 (ix)
	ld	-8 (ix),a
	ld	a,5 (ix)
	ld	-7 (ix),a
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	a,(hl)
	ld	-11 (ix),a
;src/Item.c:55: y=pos->y;
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	inc	hl
	ld	a,(hl)
	ld	-10 (ix),a
;src/Item.c:57: while(i){
	ld	-9 (ix),#0x07
00114$:
	ld	a,-9 (ix)
	or	a, a
	jp	Z,00117$
;src/Item.c:58: --i;
	dec	-9 (ix)
	ld	a,-9 (ix)
	ld	-8 (ix),a
;src/Item.c:59: --item;
	ld	a,-6 (ix)
	add	a,#0xFB
	ld	-6 (ix),a
	ld	a,-5 (ix)
	adc	a,#0xFF
	ld	-5 (ix),a
	ld	a,-6 (ix)
	ld	-13 (ix),a
	ld	a,-5 (ix)
	ld	-12 (ix),a
;src/Item.c:60: if(item->value==0){
	ld	a,-6 (ix)
	add	a, #0x04
	ld	-2 (ix),a
	ld	a,-5 (ix)
	adc	a, #0x00
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	or	a, a
	jr	NZ,00114$
;src/Item.c:61: item->id=i;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	a,-9 (ix)
	ld	(hl),a
;src/Item.c:64: item->type=0;
	pop	bc
	push	bc
	inc	bc
	inc	bc
	inc	bc
;src/Item.c:63: if((!item_spawnedKey) && (((cpct_getRandom_mxor_u8()%16)==0)||level_get_level()==KING_LEVEL)){//1/16 is key
	ld	a,(#_item_spawnedKey + 0)
	or	a, a
	jr	NZ,00102$
	push	bc
	call	_cpct_getRandom_mxor_u8
	pop	bc
	ld	a,l
	and	a, #0x0F
	jr	Z,00101$
	push	bc
	call	_level_get_level
	pop	bc
	ld	a,l
	sub	a, #0x20
	jr	NZ,00102$
00101$:
;src/Item.c:64: item->type=0;
	xor	a, a
	ld	(bc),a
;src/Item.c:65: item_spawnedKey=1;
	ld	hl,#_item_spawnedKey + 0
	ld	(hl), #0x01
	jr	00103$
00102$:
;src/Item.c:70: item->type = (cpct_getRandom_mxor_u8()&3)+1;
	push	bc
	call	_cpct_getRandom_mxor_u8
	pop	bc
	ld	a,l
	and	a, #0x03
	inc	a
	ld	(bc),a
00103$:
;src/Item.c:74: if(item->type == 1){
	ld	a,(bc)
	ld	-6 (ix), a
	dec	a
	jr	NZ,00110$
;src/Item.c:75: item->value = 48 +level_get_level() + (cpct_getRandom_mxor_u8()&7);
	call	_level_get_level
	ld	-3 (ix), l
	ld	a, l
	add	a, #0x30
	ld	-3 (ix),a
	call	_cpct_getRandom_mxor_u8
	ld	-4 (ix), l
	ld	a, l
	and	a, #0x07
	ld	-4 (ix),a
	ld	a,-3 (ix)
	add	a, -4 (ix)
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),a
	jr	00111$
00110$:
;src/Item.c:77: else if(item->type == 2){
	ld	a,-6 (ix)
	sub	a, #0x02
	jr	NZ,00107$
;src/Item.c:78: item->value = 4 + level_get_level() + (cpct_getRandom_mxor_u8()&7);
	call	_level_get_level
	ld	-4 (ix),l
	inc	-4 (ix)
	inc	-4 (ix)
	inc	-4 (ix)
	inc	-4 (ix)
	call	_cpct_getRandom_mxor_u8
	ld	-3 (ix), l
	ld	a, l
	and	a, #0x07
	ld	-3 (ix),a
	ld	a,-4 (ix)
	add	a, -3 (ix)
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),a
	jr	00111$
00107$:
;src/Item.c:81: item->value=1;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),#0x01
00111$:
;src/Item.c:84: item->position.x = x;
	pop	bc
	push	bc
	inc	bc
	ld	a,-11 (ix)
	ld	(bc),a
;src/Item.c:85: item->position.y = y;
	inc	bc
	ld	a,-10 (ix)
	ld	(bc),a
;src/Item.c:87: map[x+(y*MAP_WIDTH)] |=((i+1)<<4);
	ld	a,-11 (ix)
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
	ld	a,-10 (ix)
	ld	-6 (ix),a
	ld	-5 (ix),#0x00
	ld	a,#0x05+1
	jr	00155$
00154$:
	sla	-6 (ix)
	rl	-5 (ix)
00155$:
	dec	a
	jr	NZ,00154$
	ld	a,-2 (ix)
	add	a, -6 (ix)
	ld	-2 (ix),a
	ld	a,-1 (ix)
	adc	a, -5 (ix)
	ld	-1 (ix),a
	ld	a,-2 (ix)
	add	a, #0xD0
	ld	-2 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x88
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-4 (ix),a
	ld	a,-8 (ix)
	inc	a
	ld	-3 (ix), a
	rlca
	rlca
	rlca
	rlca
	and	a,#0xF0
	ld	-3 (ix),a
	ld	a,-4 (ix)
	or	a, -3 (ix)
	ld	-4 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,-4 (ix)
	ld	(hl),a
;src/Item.c:89: ++activeItems;
	ld	hl, #_activeItems+0
	inc	(hl)
;src/Item.c:90: break;
00117$:
	ld	sp, ix
	pop	ix
	ret
;src/Item.c:95: u8 item_try_new_spawn_at(Vec2u* pos){
;	---------------------------------
; Function item_try_new_spawn_at
; ---------------------------------
_item_try_new_spawn_at::
;src/Item.c:107: return 0;
	ld	l,#0x00
	ret
;src/Item.c:110: void item_pick_item(Item* i){
;	---------------------------------
; Function item_pick_item
; ---------------------------------
_item_pick_item::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;src/Item.c:112: switch(i->type){
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	e,(hl)
	ld	a,#0x04
	sub	a, e
	jp	C,00106$
;src/Item.c:120: player_attack_value=(i->value>player_attack_value)?i->value:player_attack_value;
	ld	hl,#0x0004
	add	hl,bc
	ld	-2 (ix),l
	ld	-1 (ix),h
;src/Item.c:112: switch(i->type){
	ld	d,#0x00
	ld	hl,#00125$
	add	hl,de
	add	hl,de
;src/Item.c:113: case 0:{//key
	jp	(hl)
00125$:
	jr	00101$
	jr	00102$
	jr	00103$
	jr	00104$
	jr	00105$
00101$:
;src/Item.c:114: player_has_key=1;
	ld	hl,#_player_has_key + 0
	ld	(hl), #0x01
;src/Item.c:115: ui_playerstats_render_key();
	push	bc
	call	_ui_playerstats_render_key
	pop	bc
;src/Item.c:116: object = "KEY";
	ld	de,#___str_0+0
;src/Item.c:117: break;
	jr	00106$
;src/Item.c:119: case 1:{
00102$:
;src/Item.c:120: player_attack_value=(i->value>player_attack_value)?i->value:player_attack_value;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	e,(hl)
	ld	a,(#_player_attack_value)
	sub	a, e
	jr	C,00110$
	ld	hl,#_player_attack_value + 0
	ld	e, (hl)
00110$:
	ld	hl,#_player_attack_value + 0
	ld	(hl), e
;src/Item.c:121: ui_playerstats_render_attack();
	push	bc
	call	_ui_playerstats_render_attack
	pop	bc
;src/Item.c:122: object="SWORD";
	ld	de,#___str_1
;src/Item.c:123: break;
	jr	00106$
;src/Item.c:125: case 2:{
00103$:
;src/Item.c:126: player_defense_value = (i->value>player_defense_value)?i->value:player_defense_value;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	e,(hl)
	ld	a,(#_player_defense_value)
	sub	a, e
	jr	C,00112$
	ld	hl,#_player_defense_value + 0
	ld	e, (hl)
00112$:
	ld	hl,#_player_defense_value + 0
	ld	(hl), e
;src/Item.c:127: ui_playerstats_render_defense();
	push	bc
	call	_ui_playerstats_render_defense
	pop	bc
;src/Item.c:128: object="ARMOR";
	ld	de,#___str_2
;src/Item.c:129: break;
	jr	00106$
;src/Item.c:131: case 3:{
00104$:
;src/Item.c:132: ++player_potion_count;
	ld	hl, #_player_potion_count+0
	inc	(hl)
;src/Item.c:133: ui_playerstats_render_potions();
	push	bc
	call	_ui_playerstats_render_potions
	pop	bc
;src/Item.c:134: object="POTION";
	ld	de,#___str_3
;src/Item.c:135: break;
	jr	00106$
;src/Item.c:137: case 4:{
00105$:
;src/Item.c:138: ++player_scroll_count;
	ld	hl, #_player_scroll_count+0
	inc	(hl)
;src/Item.c:139: ui_playerstats_render_scrolls();
	push	bc
	call	_ui_playerstats_render_scrolls
	pop	bc
;src/Item.c:140: object="SCROLL";
	ld	de,#___str_4
;src/Item.c:143: }
00106$:
;src/Item.c:145: ui_log_add_log("PICKED",3);
	push	bc
	push	de
	ld	a,#0x03
	push	af
	inc	sp
	ld	hl,#___str_5
	push	hl
	call	_ui_log_add_log
	pop	af
	inc	sp
	pop	de
	ld	a,#0x06
	push	af
	inc	sp
	push	de
	call	_ui_log_add_log
	pop	af
	inc	sp
	call	_ui_log_render
	call	_item_destroy_item
	ld	sp,ix
	pop	ix
	ret
___str_0:
	.ascii "KEY"
	.db 0x00
___str_1:
	.ascii "SWORD"
	.db 0x00
___str_2:
	.ascii "ARMOR"
	.db 0x00
___str_3:
	.ascii "POTION"
	.db 0x00
___str_4:
	.ascii "SCROLL"
	.db 0x00
___str_5:
	.ascii "PICKED"
	.db 0x00
;src/Item.c:152: void item_destroy_item(Item* i){
;	---------------------------------
; Function item_destroy_item
; ---------------------------------
_item_destroy_item::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/Item.c:153: u8* mapPos = (u8*)(MAP_MEM + i->position.x + (i->position.y*MAP_WIDTH));
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	l, e
	ld	h, d
	inc	hl
	ld	c,(hl)
	ld	b,#0x00
	ld	hl,#0x88D0
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	l,(hl)
	ld	h,#0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl,bc
	ld	c,l
	ld	b,h
;src/Item.c:155: --activeItems;
	ld	hl, #_activeItems+0
	dec	(hl)
;src/Item.c:157: i->value=0;
	inc	de
	inc	de
	inc	de
	inc	de
	xor	a, a
	ld	(de),a
;src/Item.c:159: *mapPos = *mapPos&(CELL_WALL_MASK|CELL_ENEMY_MASK);
	ld	a,(bc)
	and	a, #0x8F
	ld	(bc),a
	pop	ix
	ret
;src/Item.c:163: u8 item_use_potion(){
;	---------------------------------
; Function item_use_potion
; ---------------------------------
_item_use_potion::
;src/Item.c:164: if(player_potion_count){
	ld	a,(#_player_potion_count + 0)
	or	a, a
	jr	Z,00105$
;src/Item.c:165: --player_potion_count;
	ld	hl, #_player_potion_count+0
	dec	(hl)
;src/Item.c:166: if(player_health_points<(255-ITEM_POTION_HEAL)){
	ld	a,(#_player_health_points + 0)
	sub	a, #0x80
	jr	NC,00102$
;src/Item.c:167: player_health_points+=ITEM_POTION_HEAL;
	ld	hl,#_player_health_points
	ld	a,(hl)
	add	a, #0x7F
	ld	(hl),a
	jr	00103$
00102$:
;src/Item.c:170: player_health_points=255;
	ld	hl,#_player_health_points + 0
	ld	(hl), #0xFF
00103$:
;src/Item.c:172: ui_playerstats_render_hp();
	call	_ui_playerstats_render_hp
;src/Item.c:173: return 1;
	ld	l,#0x01
	ret
00105$:
;src/Item.c:175: return 0;
	ld	l,#0x00
	ret
;src/Item.c:178: u8 item_use_scroll(){
;	---------------------------------
; Function item_use_scroll
; ---------------------------------
_item_use_scroll::
;src/Item.c:179: u16 pos = (cpct_getRandom_mxor_u16()%1024);
	call	_cpct_getRandom_mxor_u16
	ld	c,l
	ld	a,h
	and	a, #0x03
	ld	b,a
;src/Item.c:180: if(player_scroll_count){
	ld	a,(#_player_scroll_count + 0)
	or	a, a
	jr	Z,00105$
;src/Item.c:181: while(*(u8*)(MAP_MEM+pos)!=CELLTYPE_FLOOR){
00101$:
	ld	hl,#0x88D0
	add	hl,bc
	ld	a,(hl)
	or	a, a
	jr	Z,00103$
;src/Item.c:182: pos = (pos+1)%1024;
	inc	bc
	ld	a,b
	and	a, #0x03
	ld	b,a
	jr	00101$
00103$:
;src/Item.c:184: --player_scroll_count;
	ld	hl, #_player_scroll_count+0
	dec	(hl)
;src/Item.c:185: *(u8*)&(player_position.x) = (pos%MAP_WIDTH);
	ld	a,c
	and	a, #0x1F
	ld	e,a
	ld	hl,#_player_position
	ld	(hl),e
;src/Item.c:186: *(u8*)&(player_position.y) = (pos/MAP_HEIGHT);
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	hl,#(_player_position + 0x0001)
	ld	(hl),c
;src/Item.c:187: return 1;
	ld	l,#0x01
	ret
00105$:
;src/Item.c:189: return 0;
	ld	l,#0x00
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
