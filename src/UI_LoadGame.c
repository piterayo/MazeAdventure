
#include "UI_LoadGame.h"

#include "GameDefinitions.h"
#include "GameFunctions.h"

#include "StringUtils.h"
#include "Renderer.h"

#include "StringInput.h"

#define UI_LOADGAME_BUTTON_LOAD_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 24, 79+12+10))

#define UI_LOADGAME_BUTTON_EXIT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 42, 79+12+10))


#define UI_LOADGAME_STRING_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 22, 79+12))


#define UI_LOADGAME_BUTTON_LOAD_TEXT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 26, 79+12+10+5))

#define UI_LOADGAME_BUTTON_EXIT_TEXT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 44, 79+12+10+5))

#define UI_LOADGAME_ENTRIES 2

#define UI_LOADGAME_BUTTON_HEIGHT 16

#define UI_LOADGAME_BUTTON_WIDTH 12

u8 ui_loadgame_lastEntry;
u8 ui_loadgame_entryIndex;
u8 ui_loadgame_entrySelected;

const void* const ui_loadgame_entriesPosition[UI_LOADGAME_ENTRIES]={
    UI_LOADGAME_BUTTON_LOAD_POSITION,
    UI_LOADGAME_BUTTON_EXIT_POSITION
};

const void* const ui_loadgame_entriesTextPosition[UI_LOADGAME_ENTRIES]={
    UI_LOADGAME_BUTTON_LOAD_TEXT_POSITION,
    UI_LOADGAME_BUTTON_EXIT_TEXT_POSITION
};

const char* const ui_loadgame_buttonText[UI_LOADGAME_ENTRIES]={
    "LOAD","EXIT"
};

void ui_loadgame_init(){
    ui_loadgame_lastEntry=0;
    ui_loadgame_entryIndex=0;
    ui_loadgame_entrySelected=0;
}


u8 ui_loadgame_get_entry(){
    return ui_loadgame_entryIndex;
}

u8 ui_loadgame_is_selected(){
    return ui_loadgame_entrySelected;
}

void ui_loadgame_next_entry(){
    if(ui_loadgame_entryIndex<(UI_LOADGAME_ENTRIES-1)){
        ui_loadgame_lastEntry=ui_loadgame_entryIndex;
        ++ui_loadgame_entryIndex;
    }
}

void ui_loadgame_previous_entry(){
    if(ui_loadgame_entryIndex>0){
        ui_loadgame_lastEntry=ui_loadgame_entryIndex;
        --ui_loadgame_entryIndex;
    }
}


void ui_loadgame_select_entry(){
    ui_loadgame_entrySelected=1;
}

void ui_loadgame_unselect_entry(){
    ui_loadgame_entrySelected=0;
}

void ui_loadgame_render_button(u8 n){
    u8 color;
    color = (n==ui_loadgame_entryIndex)?((ui_loadgame_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
    cpct_drawSolidBox(ui_loadgame_entriesPosition[n],color, UI_LOADGAME_BUTTON_WIDTH, UI_LOADGAME_BUTTON_HEIGHT);
    print_transparent_text(ui_loadgame_buttonText[n], ui_loadgame_entriesTextPosition[n], 3);
}


void ui_loadgame_render_all(){
    u8 n=UI_LOADGAME_ENTRIES;
    
    cpct_drawSolidBox(UI_LOADGAME_STRING_POSITION, g_colors[1], 36,6);
    print_text(ui_stringinput_get_string(),UI_LOADGAME_STRING_POSITION, 1,3);
    
    while(n){
        --n;
        ui_loadgame_render_button(n);
    }
    
     ui_loadgame_lastEntry=ui_loadgame_entryIndex;
}
