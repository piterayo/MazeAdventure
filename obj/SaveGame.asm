;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module SaveGame
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _savegame_decrypt_save
	.globl _savegame_to_string
	.globl _savegame_checksave
	.globl _savegame_string_to_save
	.globl _str_cmp
	.globl _map_get_seed
	.globl _level_get_level
	.globl _level_set_level
	.globl _player_init
	.globl _statemanager_set_state
	.globl _saveString
	.globl _save
	.globl _saveArray
	.globl _savegame_Save
	.globl _savegame_Load
	.globl _savegame_get_saveString
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_save::
	.ds 9
_saveString::
	.ds 19
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
;src/SaveGame.c:31: u8 str_cmp(char* a, char* b){
;	---------------------------------
; Function str_cmp
; ---------------------------------
_str_cmp::
;src/SaveGame.c:32: u8 sum=0;
	ld	c,#0x00
;src/SaveGame.c:33: while(*a){
	pop	de
	pop	hl
	push	hl
	push	de
00101$:
	ld	b,(hl)
	ld	a,b
	or	a, a
	jr	Z,00112$
;src/SaveGame.c:34: sum+=*a;
	ld	a,c
	add	a, b
	ld	c,a
;src/SaveGame.c:35: ++a;
	inc	hl
	jr	00101$
;src/SaveGame.c:38: while(*b){
00112$:
	ld	hl, #4
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
00104$:
	ld	a,(de)
	ld	b,a
	or	a, a
	jr	Z,00106$
;src/SaveGame.c:39: sum-=*b;
	ld	a,c
	sub	a, b
	ld	c,a
;src/SaveGame.c:40: ++b;
	inc	de
	jr	00104$
00106$:
;src/SaveGame.c:43: return sum;
	ld	l,c
	ret
_saveArray:
	.dw _save
;src/SaveGame.c:46: void savegame_string_to_save(char* in){
;	---------------------------------
; Function savegame_string_to_save
; ---------------------------------
_savegame_string_to_save::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src/SaveGame.c:51: while(i<SAVEDATA_SIZE){
	ld	c,#0x00
00106$:
	ld	a,c
	sub	a, #0x09
	jr	NC,00111$
;src/SaveGame.c:52: val=0;
	ld	b,#0x00
;src/SaveGame.c:53: for(j=2;j;--j){
	ld	e,#0x02
	ld	l,4 (ix)
	ld	h,5 (ix)
00109$:
;src/SaveGame.c:54: val=val<<4;
	ld	a,b
	rlca
	rlca
	rlca
	rlca
	and	a,#0xF0
	ld	-1 (ix),a
;src/SaveGame.c:55: if((*in)>47 && (*in)<=57){//Number
	ld	b,(hl)
	ld	a,#0x2F
	sub	a, b
	jr	NC,00102$
	ld	a,#0x39
	sub	a, b
	jr	C,00102$
;src/SaveGame.c:56: val=val|(*in)-48;
	ld	a,b
	add	a,#0xD0
	or	a, -1 (ix)
	ld	b,a
	jr	00103$
00102$:
;src/SaveGame.c:59: val=val|(*in)-65+10;
	ld	a,b
	add	a, #0xC9
	or	a, -1 (ix)
	ld	b,a
00103$:
;src/SaveGame.c:61: ++in;
	inc	hl
;src/SaveGame.c:53: for(j=2;j;--j){
	ld	d,e
	dec	d
	ld	a,d
	ld	e,a
	or	a, a
	jr	NZ,00109$
;src/SaveGame.c:64: saveArray[i]=val;
	ld	4 (ix),l
	ld	5 (ix),h
	ld	hl,(_saveArray)
	ld	e,c
	ld	d,#0x00
	add	hl,de
	ld	(hl),b
;src/SaveGame.c:65: ++i;
	inc	c
	jr	00106$
00111$:
	inc	sp
	pop	ix
	ret
;src/SaveGame.c:71: u8 savegame_checksave(){
;	---------------------------------
; Function savegame_checksave
; ---------------------------------
_savegame_checksave::
;src/SaveGame.c:73: u8 checksum=0;
;src/SaveGame.c:76: while(i){
	ld	bc,#0x0800
00101$:
	ld	a,b
	or	a, a
	jr	Z,00103$
;src/SaveGame.c:77: --i;
	dec	b
;src/SaveGame.c:78: checksum+=(saveArray[i]^SAVE_MASK);
	ld	hl,(_saveArray)
	ld	e,b
	ld	d,#0x00
	add	hl,de
	ld	a,(hl)
	xor	a, #0xDB
	ld	e, a
	add	a,c
	ld	c,a
	jr	00101$
00103$:
;src/SaveGame.c:80: checksum=checksum^CHECKSUM_MASK^SAVE_MASK;
	ld	a,c
	xor	a, #0x71
	ld	c,a
;src/SaveGame.c:81: return (checksum==save.checksum);
	ld	hl, #(_save + 0x0008) + 0
	ld	b,(hl)
	ld	a,c
	sub	a, b
	jr	NZ,00115$
	ld	a,#0x01
	jr	00116$
00115$:
	xor	a,a
00116$:
	ld	l,a
	ret
;src/SaveGame.c:86: void savegame_to_string(){
;	---------------------------------
; Function savegame_to_string
; ---------------------------------
_savegame_to_string::
;src/SaveGame.c:89: char* string = saveString;
	ld	de,#_saveString
;src/SaveGame.c:90: saveString[SAVESTRING_SIZE-1]=0;
	ld	hl,#(_saveString + 0x0012)
	ld	(hl),#0x00
;src/SaveGame.c:93: while(i<SAVEDATA_SIZE){
	ld	c,#0x00
00107$:
	ld	a,c
	sub	a, #0x09
	ret	NC
;src/SaveGame.c:94: val = saveArray[i]>>4;
	ld	hl,(_saveArray)
	ld	b,#0x00
	add	hl, bc
	ld	a,(hl)
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0F
;src/SaveGame.c:95: if(val<10) *string=48+val;
	ld	b,a
	sub	a, #0x0A
	jr	NC,00102$
	ld	a,b
	add	a, #0x30
	ld	(de),a
	jr	00103$
00102$:
;src/SaveGame.c:96: else *string=65+(val-10);
	ld	a,b
	add	a, #0x37
	ld	(de),a
00103$:
;src/SaveGame.c:98: ++string;
	inc	de
;src/SaveGame.c:99: val = saveArray[i]&0x0F;
	ld	hl,(_saveArray)
	ld	b,#0x00
	add	hl, bc
	ld	a,(hl)
	and	a, #0x0F
;src/SaveGame.c:100: if(val<10) *string=48+val;
	ld	b,a
	sub	a, #0x0A
	jr	NC,00105$
	ld	a,b
	add	a, #0x30
	ld	(de),a
	jr	00106$
00105$:
;src/SaveGame.c:101: else *string=65+(val-10);
	ld	a,b
	add	a, #0x37
	ld	(de),a
00106$:
;src/SaveGame.c:103: ++string;
	inc	de
;src/SaveGame.c:104: ++i;
	inc	c
	jr	00107$
;src/SaveGame.c:108: void savegame_Save(){
;	---------------------------------
; Function savegame_Save
; ---------------------------------
_savegame_Save::
;src/SaveGame.c:112: save.seed = map_get_seed();
	call	_map_get_seed
	ld	c,l
	ld	b,h
	ld	(_save), bc
;src/SaveGame.c:114: save.potions = player_potion_count;
	ld	hl,#(_save + 0x0002)
	ld	a,(#_player_potion_count + 0)
	ld	(hl),a
;src/SaveGame.c:115: save.scrolls = player_scroll_count;
	ld	hl,#(_save + 0x0003)
	ld	a,(#_player_scroll_count + 0)
	ld	(hl),a
;src/SaveGame.c:117: save.player_hp = player_health_points;
	ld	hl,#(_save + 0x0004)
	ld	a,(#_player_health_points + 0)
	ld	(hl),a
;src/SaveGame.c:118: save.player_attack = player_attack_value;
	ld	hl,#(_save + 0x0005)
	ld	a,(#_player_attack_value + 0)
	ld	(hl),a
;src/SaveGame.c:119: save.player_defense = player_defense_value;
	ld	hl,#(_save + 0x0006)
	ld	a,(#_player_defense_value + 0)
	ld	(hl),a
;src/SaveGame.c:121: save.level = level_get_level();
	call	_level_get_level
	ld	c,l
	ld	hl,#(_save + 0x0007)
	ld	(hl),c
;src/SaveGame.c:123: save.checksum=0;
	ld	bc,#_save + 8
	xor	a, a
	ld	(bc),a
;src/SaveGame.c:124: while(i){
	ld	e,#0x08
00101$:
	ld	a,e
	or	a, a
	jr	Z,00103$
;src/SaveGame.c:125: --i;
	dec	e
;src/SaveGame.c:126: save.checksum+=saveArray[i];
	ld	a,(bc)
	ld	d,a
	ld	hl,(_saveArray)
	ld	a,e
	add	a, l
	ld	l,a
	ld	a,#0x00
	adc	a, h
	ld	h,a
	ld	l,(hl)
	ld	a,d
	add	a, l
	ld	(bc),a
	jr	00101$
00103$:
;src/SaveGame.c:131: while(i){
	ld	e,#0x09
00104$:
	ld	a,e
	or	a, a
	jr	Z,00106$
;src/SaveGame.c:132: --i;
	dec	e
;src/SaveGame.c:133: saveArray[i] = saveArray[i]^SAVE_MASK;
	ld	hl,(_saveArray)
	ld	d,#0x00
	add	hl, de
	ld	a,(hl)
	xor	a, #0xDB
	ld	(hl),a
	jr	00104$
00106$:
;src/SaveGame.c:136: save.checksum = save.checksum^CHECKSUM_MASK;
	ld	a,(bc)
	xor	a, #0xAA
	ld	(bc),a
;src/SaveGame.c:138: savegame_to_string();
	jp  _savegame_to_string
;src/SaveGame.c:142: void savegame_decrypt_save(){
;	---------------------------------
; Function savegame_decrypt_save
; ---------------------------------
_savegame_decrypt_save::
;src/SaveGame.c:145: while(i){
	ld	c,#0x09
00101$:
	ld	a,c
	or	a, a
	ret	Z
;src/SaveGame.c:146: --i;
	dec	c
;src/SaveGame.c:147: saveArray[i] = saveArray[i]^SAVE_MASK;
	ld	hl,(_saveArray)
	ld	e,c
	ld	d,#0x00
	add	hl,de
	ld	a,(hl)
	xor	a, #0xDB
	ld	(hl),a
	jr	00101$
;src/SaveGame.c:151: u8 savegame_Load(char * loadstring){
;	---------------------------------
; Function savegame_Load
; ---------------------------------
_savegame_Load::
;src/SaveGame.c:152: if(!str_cmp(loadstring,"CAMELOT WARRIORS")){
	ld	hl,#___str_0
	push	hl
	ld	hl, #4
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_str_cmp
	pop	af
	pop	af
	ld	a,l
	or	a, a
	jr	NZ,00104$
;src/SaveGame.c:153: level_set_level(0);
	xor	a, a
	push	af
	inc	sp
	call	_level_set_level
	inc	sp
;src/SaveGame.c:154: camelot_warriors_mode=1;
	ld	hl,#_camelot_warriors_mode + 0
	ld	(hl), #0x01
;src/SaveGame.c:155: player_init();
	call	_player_init
;src/SaveGame.c:156: statemanager_set_state(STATE_LOADLEVEL);
	ld	a,#0x03
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/SaveGame.c:158: return 1;
	ld	l,#0x01
	ret
00104$:
;src/SaveGame.c:161: savegame_string_to_save(loadstring);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_savegame_string_to_save
	pop	af
;src/SaveGame.c:162: if(savegame_checksave()){
	call	_savegame_checksave
	ld	a,l
	or	a, a
	jr	Z,00105$
;src/SaveGame.c:163: savegame_decrypt_save();
	call	_savegame_decrypt_save
;src/SaveGame.c:164: level_set_level(save.level);
	ld	hl, #_save + 7
	ld	b,(hl)
	push	bc
	inc	sp
	call	_level_set_level
	inc	sp
;src/SaveGame.c:166: player_health_points=save.player_hp;
	ld	a,(#_save + 4)
	ld	(#_player_health_points + 0),a
;src/SaveGame.c:167: player_attack_value=save.player_attack;
	ld	a,(#_save + 5)
	ld	(#_player_attack_value + 0),a
;src/SaveGame.c:168: player_defense_value=save.player_defense;
	ld	a,(#_save + 6)
	ld	(#_player_defense_value + 0),a
;src/SaveGame.c:170: player_potion_count = save.potions;
	ld	a,(#_save + 2)
	ld	(#_player_potion_count + 0),a
;src/SaveGame.c:171: player_scroll_count = save.scrolls;
	ld	a,(#_save + 3)
	ld	(#_player_scroll_count + 0),a
;src/SaveGame.c:173: level_seed=save.seed;
	ld	hl, #_save + 0
	ld	a,(hl)
	ld	iy,#_level_seed
	ld	0 (iy),a
	inc	hl
	ld	a,(hl)
	ld	(#_level_seed + 1),a
;src/SaveGame.c:175: statemanager_set_state(STATE_LOADLEVEL);
	ld	a,#0x03
	push	af
	inc	sp
	call	_statemanager_set_state
	inc	sp
;src/SaveGame.c:177: return 1;
	ld	l,#0x01
	ret
00105$:
;src/SaveGame.c:180: return 0;
	ld	l,#0x00
	ret
___str_0:
	.ascii "CAMELOT WARRIORS"
	.db 0x00
;src/SaveGame.c:183: char* savegame_get_saveString(){
;	---------------------------------
; Function savegame_get_saveString
; ---------------------------------
_savegame_get_saveString::
;src/SaveGame.c:184: return saveString;
	ld	hl,#_saveString
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
