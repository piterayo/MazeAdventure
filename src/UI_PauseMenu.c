
#include "UI_PauseMenu.h"


#include "GameDefinitions.h"

#include "StringUtils.h"
#include "Renderer.h"

#define UI_PAUSEMENU_BUTTON_CONTINUE_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 26, 40))

#define UI_PAUSEMENU_BUTTON_OPTIONS_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 26, 72))

#define UI_PAUSEMENU_BUTTON_SAVE_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 26, 104))

#define UI_PAUSEMENU_BUTTON_EXIT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 26, 136))


#define UI_PAUSEMENU_BUTTON_CONTINUE_TEXT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 32, 49))

#define UI_PAUSEMENU_BUTTON_OPTIONS_TEXT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 34, 81))

#define UI_PAUSEMENU_BUTTON_SAVE_TEXT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 27, 113))

#define UI_PAUSEMENU_BUTTON_EXIT_TEXT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 36, 145))

#define UI_PAUSEMENU_ENTRIES 4

#define UI_PAUSEMENU_BUTTON_HEIGHT 24

#define UI_PAUSEMENU_BUTTON_WIDTH 28

u8 ui_pausemenu_lastEntry;
u8 ui_pausemenu_entryIndex;
u8 ui_pausemenu_entrySelected;

const void* const ui_pausemenu_entriesPosition[UI_PAUSEMENU_ENTRIES]={
    UI_PAUSEMENU_BUTTON_CONTINUE_POSITION,
    UI_PAUSEMENU_BUTTON_OPTIONS_POSITION,
    UI_PAUSEMENU_BUTTON_SAVE_POSITION,
    UI_PAUSEMENU_BUTTON_EXIT_POSITION
};

const void* const ui_pausemenu_entriesTextPosition[UI_PAUSEMENU_ENTRIES]={
    UI_PAUSEMENU_BUTTON_CONTINUE_TEXT_POSITION,
    UI_PAUSEMENU_BUTTON_OPTIONS_TEXT_POSITION,
    UI_PAUSEMENU_BUTTON_SAVE_TEXT_POSITION,
    UI_PAUSEMENU_BUTTON_EXIT_TEXT_POSITION
};

const char* const ui_pausemenu_buttonText[UI_PAUSEMENU_ENTRIES]={
    "CONTINUE","OPTIONS","SAVE AND EXIT","EXIT"
};



void ui_pausemenu_init(){
    ui_pausemenu_lastEntry=0;
    ui_pausemenu_entryIndex=0;
    ui_pausemenu_entrySelected=0;
}

u8 ui_pausemenu_get_entry(){
    return ui_pausemenu_entryIndex;
}

u8 ui_pausemenu_is_selected(){
    return ui_pausemenu_entrySelected;
}

void ui_pausemenu_next_entry(){
    if(ui_pausemenu_entryIndex<(UI_PAUSEMENU_ENTRIES-1)){
        ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
        ++ui_pausemenu_entryIndex;
    }
}

void ui_pausemenu_previous_entry(){
    if(ui_pausemenu_entryIndex>0){
        ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
        --ui_pausemenu_entryIndex;
    }
}

void ui_pausemenu_select_entry(){
    ui_pausemenu_entrySelected=1;
}

void ui_pausemenu_unselect_entry(){
    ui_pausemenu_entrySelected=0;
}

void ui_pausemenu_render_button(u8 n){
    u8 color;
    color = (n==ui_pausemenu_entryIndex)?((ui_pausemenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
    cpct_drawSolidBox(ui_pausemenu_entriesPosition[n],color, UI_PAUSEMENU_BUTTON_WIDTH, UI_PAUSEMENU_BUTTON_HEIGHT);
    print_transparent_text(ui_pausemenu_buttonText[n], ui_pausemenu_entriesTextPosition[n], 3);
}

void ui_pausemenu_render_refresh(){
    
    ui_pausemenu_render_button(ui_pausemenu_entryIndex);
    ui_pausemenu_render_button(ui_pausemenu_lastEntry);
    
    ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
}

void ui_pausemenu_render_all(){
    u8 n=UI_PAUSEMENU_ENTRIES;
    
    
    while(n){
        --n;
        ui_pausemenu_render_button(n);
    }
    
     ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
}

