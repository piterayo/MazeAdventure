
#include "UI_PlayerStats.h"
#include "Renderer.h"
#include "StringUtils.h"

#include "Player.h"

#define UI_PLAYERSTATS_POSITION 0xC000+160

#define UI_PLAYERSTATS_WIDTH 20

#define UI_PLAYERSTATS_TEXT_COLOR 3

#define UI_PLAYERSTATS_BG_TEXT_COLOR 1

#define UI_PLAYERSTATS_HEALTHBAR_FG_COLOR 5

#define UI_PLAYERSTATS_HEALTHBAR_BG_COLOR 4

const char* const strings[5]={
    "+","#","&","~","$",
};

void ui_playerstats_render_all(){
    print_text("STATS", UI_PLAYERSTATS_POSITION+1,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
    ui_playerstats_render_hp();
    ui_playerstats_render_attack();
    ui_playerstats_render_defense();
    ui_playerstats_render_potions();
    ui_playerstats_render_scrolls();
    ui_playerstats_render_key();
    
}

void ui_playerstats_render_hp(){
    u8 h = 1+((u16)player_health_points*9)/255;
    print_text("HP", UI_PLAYERSTATS_POSITION+160,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
    
    
    cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[UI_PLAYERSTATS_HEALTHBAR_BG_COLOR], 10,4);
    if(!player_is_dead) cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[UI_PLAYERSTATS_HEALTHBAR_FG_COLOR], h,4);

}

void ui_playerstats_render_attack(){
    print_text(strings[0], UI_PLAYERSTATS_POSITION+320,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
    print_text(integer_to_string(player_attack_value,'d'), UI_PLAYERSTATS_POSITION+324,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
}

void ui_playerstats_render_defense(){
    print_text(strings[1], UI_PLAYERSTATS_POSITION+400,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
    print_text(integer_to_string(player_defense_value,'d'), UI_PLAYERSTATS_POSITION+404,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
}

void ui_playerstats_render_potions(){
    print_text(strings[2], UI_PLAYERSTATS_POSITION+480,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
    print_text(integer_to_string(player_potion_count,'d'), UI_PLAYERSTATS_POSITION+484,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
}

void ui_playerstats_render_scrolls(){
    print_text(strings[3], UI_PLAYERSTATS_POSITION+560,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
    print_text(integer_to_string(player_scroll_count,'d'), UI_PLAYERSTATS_POSITION+564, UI_PLAYERSTATS_BG_TEXT_COLOR,UI_PLAYERSTATS_TEXT_COLOR);
}

void ui_playerstats_render_key(){
    print_text(strings[4], UI_PLAYERSTATS_POSITION+640,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
    if(player_has_key){
        print_text("YES", UI_PLAYERSTATS_POSITION+644,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
    }
    else{
        print_text("NO", UI_PLAYERSTATS_POSITION+646,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
    }
}
