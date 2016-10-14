
#include "UI_MainMenu.h"

#include "StringUtils.h"
#include "Renderer.h"

#define UI_MAINMENU_BUTTON_NEWGAME_POSITION 0xc410
#define UI_MAINMENU_BUTTON_LOADGAME_POSITION 0xe4b0

#define UI_MAINMENU_BUTTON_OPTIONS_POSITION 0xc5a0

#define UI_MAINMENU_BUTTON_CREDITS_POSITION 0xe640

#define UI_MAINMENU_BUTTON_EXIT_POSITION 0xc730

#define UI_MAINMENU_ENTRIES 5

#define UI_MAINMENU_BUTTON_HEIGHT 16

u8 ui_mainmenu_lastEntry=0;
u8 ui_mainmenu_entryIndex=0;
u8 ui_mainmenu_entrySelected=0;

const u8* const ui_mainmenu_entriesPosition[UI_MAINMENU_ENTRIES]={
    UI_MAINMENU_BUTTON_NEWGAME_POSITION,UI_MAINMENU_BUTTON_LOADGAME_POSITION,UI_MAINMENU_BUTTON_OPTIONS_POSITION,
    UI_MAINMENU_BUTTON_CREDITS_POSITION,UI_MAINMENU_BUTTON_EXIT_POSITION
};

const char* const ui_mainmenu_buttonText[UI_MAINMENU_ENTRIES]={
    "NEW GAME","LOAD GAME","OPTIONS","CREDITS","EXIT",
};

const u8 ui_mainmenu_buttonWidths=20;

void ui_mainmenu_init(){
    ui_mainmenu_lastEntry=0;
    ui_mainmenu_entryIndex=0;
    ui_mainmenu_entrySelected=0;
}

void ui_mainmenu_next_entry(){
    if(ui_mainmenu_entryIndex<(UI_MAINMENU_ENTRIES-1)){
        ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
        ++ui_mainmenu_entryIndex;
    }
}

void ui_mainmenu_previous_entry(){
    if(ui_mainmenu_entryIndex>0){
        ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
        --ui_mainmenu_entryIndex;
    }
}

void ui_mainmenu_unselect_entry(){
    ui_mainmenu_entrySelected=0;
}

void ui_mainmenu_select_entry(){
    ui_mainmenu_entrySelected=1;
}


void ui_mainmenu_render_refresh(){
    u8 color;
    
    color = (ui_mainmenu_entrySelected)? g_colors[4]: g_colors[5];
    cpct_drawSolidBox(ui_mainmenu_entriesPosition[ui_mainmenu_entryIndex],color, ui_mainmenu_buttonWidths, UI_MAINMENU_BUTTON_HEIGHT);
    print_transparent_text(ui_mainmenu_buttonText[ui_mainmenu_entryIndex], ui_mainmenu_entriesPosition[ui_mainmenu_entryIndex], 3);
    
    if(ui_mainmenu_lastEntry!=ui_mainmenu_entryIndex){
        color = g_colors[2];
        cpct_drawSolidBox(ui_mainmenu_entriesPosition[ui_mainmenu_lastEntry],color, ui_mainmenu_buttonWidths, UI_MAINMENU_BUTTON_HEIGHT);
        print_transparent_text(ui_mainmenu_buttonText[ui_mainmenu_lastEntry], ui_mainmenu_entriesPosition[ui_mainmenu_lastEntry], 3);
        ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
    }
        
        
        
}

void ui_mainmenu_render_all(){
    u8 n=UI_MAINMENU_ENTRIES, color;
    
    
    while(n){
        --n;
        color = (n==ui_mainmenu_entryIndex)?((ui_mainmenu_entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
        cpct_drawSolidBox(ui_mainmenu_entriesPosition[n],color, ui_mainmenu_buttonWidths, UI_MAINMENU_BUTTON_HEIGHT);
        print_transparent_text(ui_mainmenu_buttonText[n], ui_mainmenu_entriesPosition[n], 3);
    }
    
     ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
}

u8 ui_mainmenu_get_entry(){
    return ui_mainmenu_entryIndex;
}

u8 ui_mainmenu_is_selected(){
    return ui_mainmenu_entrySelected;
}
