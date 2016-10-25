
#include "UI_Inventory.h"

#include "GameDefinitions.h"
#include "GameFunctions.h"

#include "StringUtils.h"
#include "Renderer.h"

#define UI_INVENTORY_BUTTON_POTIONS_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 43, 72))

#define UI_INVENTORY_BUTTON_SCROLLS_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 43, 72+20))

#define UI_INVENTORY_BUTTON_EXIT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 34, 72+40))


#define UI_INVENTORY_BUTTON_POTIONS_LABEL_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 26, 72+5))

#define UI_INVENTORY_BUTTON_SCROLLS_LABEL_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 26, 72+25))


#define UI_INVENTORY_BUTTON_POTIONS_TEXT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 46, 72+5))

#define UI_INVENTORY_BUTTON_SCROLLS_TEXT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 46, 72+25))

#define UI_INVENTORY_BUTTON_EXIT_TEXT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 36, 72+45))

#define UI_INVENTORY_ENTRIES 3

#define UI_INVENTORY_BUTTON_HEIGHT 16

#define UI_INVENTORY_BUTTON_WIDTH 12

u8 ui_inventory_lastEntry;
u8 ui_inventory_entryIndex;
u8 ui_inventory_entrySelected;

const void* const ui_inventory_entriesPosition[UI_INVENTORY_ENTRIES]={
    UI_INVENTORY_BUTTON_POTIONS_POSITION,
    UI_INVENTORY_BUTTON_SCROLLS_POSITION,
    UI_INVENTORY_BUTTON_EXIT_POSITION
};

const void* const ui_inventory_entriesTextPosition[UI_INVENTORY_ENTRIES]={
    UI_INVENTORY_BUTTON_POTIONS_TEXT_POSITION,
    UI_INVENTORY_BUTTON_SCROLLS_TEXT_POSITION,
    UI_INVENTORY_BUTTON_EXIT_TEXT_POSITION
};

const char* const ui_inventory_buttonText[UI_INVENTORY_ENTRIES]={
    "USE","USE","EXIT"
};

void ui_inventory_init(){
    ui_inventory_lastEntry=0;
    ui_inventory_entryIndex=0;
    ui_inventory_entrySelected=0;
}


u8 ui_inventory_get_entry(){
    return ui_inventory_entryIndex;
}

u8 ui_inventory_is_selected(){
    return ui_inventory_entrySelected;
}

void ui_inventory_next_entry(){
    if(ui_inventory_entryIndex<(UI_INVENTORY_ENTRIES-1)){
        ui_inventory_lastEntry=ui_inventory_entryIndex;
        ++ui_inventory_entryIndex;
    }
}

void ui_inventory_previous_entry(){
    if(ui_inventory_entryIndex>0){
        ui_inventory_lastEntry=ui_inventory_entryIndex;
        --ui_inventory_entryIndex;
    }
}


void ui_inventory_select_entry(){
    ui_inventory_entrySelected=1;
}

void ui_inventory_unselect_entry(){
    ui_inventory_entrySelected=0;
}

void ui_inventory_render_button(u8 n){
    u8 color;
    color = (n==ui_inventory_entryIndex)?((ui_inventory_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
    cpct_drawSolidBox(ui_inventory_entriesPosition[n],color, UI_INVENTORY_BUTTON_WIDTH, UI_INVENTORY_BUTTON_HEIGHT);
    print_transparent_text(ui_inventory_buttonText[n], ui_inventory_entriesTextPosition[n], 3);
}


void ui_inventory_render_refresh(){
    
    ui_inventory_render_button(ui_inventory_entryIndex);
    ui_inventory_render_button(ui_inventory_lastEntry);
    
    ui_inventory_lastEntry=ui_inventory_entryIndex;
}

void ui_inventory_render_all(){
    u8 n=UI_INVENTORY_ENTRIES;
    
    print_transparent_text("POTION", UI_INVENTORY_BUTTON_POTIONS_LABEL_POSITION, 3);
    print_transparent_text("SCROLL", UI_INVENTORY_BUTTON_SCROLLS_LABEL_POSITION, 3);
    
    while(n){
        --n;
        ui_inventory_render_button(n);
    }
    
     ui_inventory_lastEntry=ui_inventory_entryIndex;
}
