
#include "UI_MainMenu.h"

#include "GameDefinitions.h"

#include "StringUtils.h"
#include "Renderer.h"

#define UI_MAINMENU_BUTTON_NEWGAME_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START, 30, (200-16-4-16-4-16-4-16-4-16)))

#define UI_MAINMENU_BUTTON_LOADGAME_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START, 30, (200-16-4-16-4-16-4-16)))

#define UI_MAINMENU_BUTTON_OPTIONS_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START, 30, (200-16-4-16-4-16)))

#define UI_MAINMENU_BUTTON_CREDITS_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START, 30, (200-16-4-16)))

#define UI_MAINMENU_BUTTON_EXIT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START, 30, (200-16)))


#define UI_MAINMENU_BUTTON_NEWGAME_TEXT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START, 32, (200-16-4-16-4-16-4-16-4-16+5)))

#define UI_MAINMENU_BUTTON_LOADGAME_TEXT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START, 31, (200-16-4-16-4-16-4-16+5)))

#define UI_MAINMENU_BUTTON_OPTIONS_TEXT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START, 33, (200-16-4-16-4-16+5)))

#define UI_MAINMENU_BUTTON_CREDITS_TEXT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START, 33, (200-16-4-16+5)))

#define UI_MAINMENU_BUTTON_EXIT_TEXT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START, 36, (200-16+5)))


#define UI_MAINMENU_ENTRIES 5

#define UI_MAINMENU_BUTTON_HEIGHT 16

#define UI_MAINMENU_BUTTON_WIDTH 20

u8 ui_mainmenu_lastEntry=0;
u8 ui_mainmenu_entryIndex=0;
u8 ui_mainmenu_entrySelected=0;

const u8* const ui_mainmenu_entriesPosition[UI_MAINMENU_ENTRIES]={
    UI_MAINMENU_BUTTON_NEWGAME_POSITION,UI_MAINMENU_BUTTON_LOADGAME_POSITION,UI_MAINMENU_BUTTON_OPTIONS_POSITION,
    UI_MAINMENU_BUTTON_CREDITS_POSITION,UI_MAINMENU_BUTTON_EXIT_POSITION
};

const u8* const ui_mainmenu_entriesTextPosition[UI_MAINMENU_ENTRIES]={
    UI_MAINMENU_BUTTON_NEWGAME_TEXT_POSITION,UI_MAINMENU_BUTTON_LOADGAME_TEXT_POSITION,UI_MAINMENU_BUTTON_OPTIONS_TEXT_POSITION,
    UI_MAINMENU_BUTTON_CREDITS_TEXT_POSITION,UI_MAINMENU_BUTTON_EXIT_TEXT_POSITION
};

const char* const ui_mainmenu_buttonText[UI_MAINMENU_ENTRIES]={
    "NEW GAME","LOAD GAME","OPTIONS","CREDITS","EXIT",
};

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

void ui_mainmenu_render_button(u8 n){
    u8 color;
    color = (n==ui_mainmenu_entryIndex)?((ui_mainmenu_entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
    cpct_drawSolidBox(ui_mainmenu_entriesPosition[n],color, UI_MAINMENU_BUTTON_WIDTH, UI_MAINMENU_BUTTON_HEIGHT);
    print_transparent_text(ui_mainmenu_buttonText[n], ui_mainmenu_entriesTextPosition[n], 3);
}

void ui_mainmenu_render_refresh(){
    
    ui_mainmenu_render_button(ui_mainmenu_entryIndex);
    ui_mainmenu_render_button(ui_mainmenu_lastEntry);
        
    ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
        
}

void ui_mainmenu_render_all(){
    u8 n=UI_MAINMENU_ENTRIES;
    
    
    while(n){
        --n;
        ui_mainmenu_render_button(n);
    }
    
     ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
}

u8 ui_mainmenu_get_entry(){
    return ui_mainmenu_entryIndex;
}

u8 ui_mainmenu_is_selected(){
    return ui_mainmenu_entrySelected;
}
