
#include "Renderer.h"
#include "Map.h"
#include "Structures.h"
#include "Player.h"
#include "Textures.h"



#define CELLS_IN_VIEW_DEPTH 6

const u8 g_palette[16]={
    8,//Transparent color, common for all scenes
    0,13,26, //UI black, gray, white
    6,15,//Common for all scenes, minimap
    
    1,//Sky color
    9,//Ground color
    25,3,18,5,14,15,17,19,//Scene colors
};

const u8 g_colors[16]={
  0b00000000,//0
  0b11000000,//1
  0b00001100,//2
  0b11001100,//3
  0b00110000,//4
  0b11110000,//5
  0b00111100,//6
  0b11111100,//7
  0b00000011,//8
  0b11000011,//9
  0b00001111,//10
  0b11001111,//11
  0b00110011,//12
  0b11110011,//13
  0b00111111,//14
  0b11111111 //15
};

const u8 g_pixelMask[2]={
    0b10101010, 0b01010101
};

const u8 g_texturedWalls = 1;

u8* const cells_in_view_array = (u8*)CELLS_IN_VIEW_ARRAY;

const u8 offsets_cells_in_view[5]={
    8,12,14,15,16
};

void calculate_cells_in_view(){
    
    u8 offset=0, n=0, j, i;
    i8 x0, y0, dx, dy, x=0, y=0, vert=0;
    
    if(player_direction.y!=0){
        vert=1;
        dy=player_direction.y;
        dx=-player_direction.y;
        
        x0 = player_position.x-(17*dx);
        y0 = player_position.y+(6*dy);
    }
    else{
        vert=0;
        dy=player_direction.x;
        dx=player_direction.x;
        
        y0 = player_position.y-(17*dy);
        x0 = player_position.x+(6*dx);
        
    }
    
    x=x0;
    y=y0;
    
    for(j=0;j<6;++j){
        
        for(i=offset;i<35-offset;++i){
            
            if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
                cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
            }
            else{
                cells_in_view_array[n]=CELLTYPE_WALL1;
            }
            
            
            if(vert){
                x+=dx;
            }
            else{
                y+=dy;
            }
            ++n;
        }
        offset=offsets_cells_in_view[j];
        
        if(vert){
            y-=dy;
            if(dx<0) x=x0-offset;
            else x=x0+offset;
            
        }
        else{
            x-=dx;
            if(dy<0) y=y0-offset;
            else y=y0+offset;
        }
    }
    
    
}


void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
    u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
    
    u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
    u8 pixMask = g_pixelMask[column&1];
    
    u8 val;
    
    u8 j;
    
    u8 ceiling_height;
    u8 ground_height;
    
    if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
    
    ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
    ground_height = ceiling_height + lineHeight;
    
    pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
    
    j=lineHeight;
    
    for(j;j;--j){
        val =  ((*pvmem)&(~pixMask));
        
        *pvmem = val|(w_color&pixMask);
        
        pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
    }
}

void draw_column_to_buffer_object(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
    
}

void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
    u8* pvmem;
    
    u8 color;
    u8 pixMask;
    
    u8 val;
    
    u8* texture;
    
    u8 j;
    
    u8 enemy_top_height;
    u8 ground_height;
    
        
    u16 texture_line_add;// = (256*TEXTURE_HEIGHT)/lineHeight;
    u16 texture_line=0;
    
    if(texture_column>=4 && texture_column<28){
    
        //                START POSITION          TEXTURE INDEX OFFSET           X POSITION OFFSET
        texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(index-1)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
        
        pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
        
        pixMask = g_pixelMask[column&1];
        
        ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
        lineHeight = (lineHeight*3)/4;
        enemy_top_height = ground_height - lineHeight;
        
        texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
        j=lineHeight;
        
        if(lineHeight>SCREEN_TEXTURE_HEIGHT){
            j=90;
        }
            
        pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
        
        for(j;j;--j){
            
            color= *(texture+(texture_line/256));
            
            if(color){
                val =  ((*pvmem)&(~pixMask));
                
                color = (color&pixMask);
                            
                *pvmem = val|color;
            }
            
            texture_line += texture_line_add;
                
            pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
        }
        
    }
}

void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
    u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
    
    u8 w_color;
    u8 pixMask = g_pixelMask[column&1];
    
    u8 val;
    
    //                       START POSITION          TEXTURE INDEX OFFSET           X POSITION OFFSET
    u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
    
    u8 j=lineHeight;
    
    u8 ceiling_height;
    u8 ground_height;
    
        
    u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
    u16 wall_texture_line=0;
    
    ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
    ground_height = ceiling_height + lineHeight;
    
    
    if(lineHeight>SCREEN_TEXTURE_HEIGHT){
        ceiling_height=0;
        wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
        j=SCREEN_TEXTURE_HEIGHT;
    }
        
    pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
    
    for(j;j;--j){
        
        w_color = *(texture+(wall_texture_line/256));
        
        if(w_color){
        
            val =  ((*pvmem)&(~pixMask));
            
            w_color = (w_color&pixMask);
                        
            *pvmem = val|w_color;
        
        }
        
        wall_texture_line += wall_texture_line_add;
            
        pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
    }
}

void render_draw_to_buffer(){//TODO Optimize
    
    u8 xHeight = 2;
    
    u8 x;
    i8 z=6;
    
    u8 xCell = 0;
    u8 xCellCount = 0;
    
    u8 zHeight = 5;
    
    u8 lateralWallCounter = 0;
    u8 lateralWallSlope = 0;
    u8 lateralWallSlopeCounter = 0;
    
    u8 offsetDiff = 16;
    
    u8 lastCellWasWall = 0;
    
    u8 lineEnd = 0;
    u8 lineStart = 0;
    
    u8 lateralWallWidth=0;
    
    u8 tex_column;
    u8 lastWallId;
    
    u8 newCell;
    u8 currentCellID;
    
    u8 color;
    
    //u16 temp;
    
    cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
    cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
    cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
    
    calculate_cells_in_view();
    
    if(g_texturedWalls){
            
        do{
            
            --z;
            
            //Start to center
            
            xCellCount = (z) ? (zHeight >> 1) : 0;
            lateralWallSlope=0;
            lateralWallSlopeCounter=0;
            xHeight=0;
            xCell = 0;
            lateralWallCounter = 0;
            
            newCell=1;
            currentCellID = cells_in_view_array[lineStart + 1];
            
            lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
            if(lastCellWasWall&CELL_WALL_MASK){
                lastWallId=lastCellWasWall;
                lastCellWasWall=1;
            }
            else{
                lastCellWasWall=0;
                lastWallId=CELLTYPE_FLOOR;
            }
            
            for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
            {
                if (xCellCount == zHeight)
                {
                    ++xCell;
                    xCellCount = 0;
                    newCell=1;
                    currentCellID=cells_in_view_array[xCell + lineStart + 1];
                }
                if(!(x%2)){
                    if ((lateralWallCounter == 0)||newCell)
                    {
                        if (currentCellID & CELL_WALL_MASK)//Wall
                        {
                            lateralWallCounter = 0;//(zHeight - xCellCount);
                            lateralWallSlope = 0;
                            xHeight = zHeight;
                            color = currentCellID&0b01111111;
                            lastCellWasWall = 1;
                            lastWallId=currentCellID;
                        }
                        else{
                            if(lateralWallCounter==0){//Lateral wall not finished
                                if (lastCellWasWall)
                                {
                                    
                                    lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
                                    lateralWallSlopeCounter = lateralWallSlope / 2;
                                    lateralWallCounter = lateralWallSlope * zHeight;
                                    lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
                                    lateralWallWidth=lateralWallCounter;
                                    lastCellWasWall = 0;
                                    xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
                                    color = lastWallId&0b01111111;
                                }
                                else //Dont draw
                                {
                                    xHeight = 0;
                                    lastCellWasWall = 0;
                                    lateralWallSlope=0;
                                    lastWallId=0;
                                }
                            }
                        }
                        newCell=0;
                    }
                }
                if (lateralWallCounter > 0)
                {
                
                    if (lateralWallSlope != 0)
                    {
                        if (lateralWallSlopeCounter == lateralWallSlope)
                        {
                            lateralWallSlopeCounter = 0;
                            xHeight -= 2;
                        }
                        ++lateralWallSlopeCounter;
                    }
                    
                    --lateralWallCounter;
                }
                
                if (!(x%2))
                {
                    if(xHeight > 0){
                        if (lateralWallCounter > 0)
                        {
                            tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
                        }
                        else{
                            tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
                        }
                        draw_column_to_buffer(x/2, xHeight, color,tex_column);
                    }
                        if(!(currentCellID&CELL_WALL_MASK)){
                            if(currentCellID&CELL_ENEMY_MASK){
                                draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
                            }
                            else if(currentCellID&CELL_ITEM_MASK){
                                
                            }
                        }
                }
                
                ++xCellCount;
                
            }
            
            
            ////End to center
            
            xCellCount = (z) ? (zHeight >> 1) : 0 ;
            lateralWallSlope=0;
            lateralWallSlopeCounter=0;
            xHeight=0;
            xCell = 0;
            lateralWallCounter = 0;
            lineEnd = lineStart + offsetDiff * 2 + 2;
            
            newCell=1;
            currentCellID = cells_in_view_array[lineEnd - 1];
            
            lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
            if(lastCellWasWall&CELL_WALL_MASK){
                lastWallId=lastCellWasWall;
                lastCellWasWall=1;
            }
            else{
                lastCellWasWall=0;
                lastWallId=CELLTYPE_FLOOR;
            }
            
            for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
                
            {
                if (xCellCount == zHeight)
                {
                    ++xCell;
                    xCellCount = 0;
                    newCell=1;
                    currentCellID = cells_in_view_array[lineEnd - xCell - 1];
                }
                if(!(x%2)){
                    if (lateralWallCounter == 0 || newCell)
                    {
                        if ( currentCellID & CELL_WALL_MASK)//Wall
                        {
                            lateralWallCounter = 0;
                            lateralWallSlope = 0;
                            xHeight = zHeight;
                            color = currentCellID&0b01111111;
                            lastCellWasWall = 1;
                            lastWallId=currentCellID;
                        }
                        else if(lateralWallCounter==0){
                            if (lastCellWasWall)
                            {
                                
                                lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
                                lateralWallSlopeCounter = lateralWallSlope / 2;
                                lateralWallCounter = lateralWallSlope * zHeight;
                                lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
                                lateralWallWidth=lateralWallCounter;
                                lastCellWasWall = 0;
                                xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
                                color = lastWallId&0b01111111;
                            }
                            else //Dont draw
                            {
                                xHeight = 0;
                                lastCellWasWall = 0;
                                lateralWallSlope=0;
                                lastWallId=0;
                            }
                        }
                        newCell=0;
                    }
                }
                
                
                if (lateralWallCounter > 0)
                {
                    
                    if (lateralWallSlope != 0)
                    {
                        if (lateralWallSlopeCounter == lateralWallSlope)
                        {
                            lateralWallSlopeCounter = 0;
                            xHeight -= 2;
                        }
                        ++lateralWallSlopeCounter;
                    }
                    --lateralWallCounter;
                }
                
                
                if (!(x%2))
                {
                    
                    if(xHeight > 0){
                
                        if (lateralWallCounter > 0)
                        {
                            tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
                        }
                        else{
                            tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
                        }
                        
                        draw_column_to_buffer(x/2, xHeight, color,tex_column);
                        
                    }
                        if(!(currentCellID&CELL_WALL_MASK)){
                            if(currentCellID&CELL_ENEMY_MASK){
                                draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
                            }
                            else if(currentCellID&CELL_ITEM_MASK){
                                
                            }
                        }
                }
                ++xCellCount;
                
            }
            
            
            
            
            lineStart = lineStart + (offsetDiff * 2) + 3;
            zHeight += zHeight;
            offsetDiff = offsetDiff >> 1;
            
        }while(z);
        
    }
    else{
        
        do{
            
            --z;
            
            //Start to center
            
            xCellCount = (z) ? (zHeight >> 1) : 0;
            lateralWallSlope=0;
            lateralWallSlopeCounter=0;
            xHeight=0;
            xCell = 0;
            lateralWallCounter = 0;
            
            newCell=1;
            currentCellID = cells_in_view_array[lineStart + 1];
            
            lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
            if(lastCellWasWall&CELL_WALL_MASK){
                lastWallId=lastCellWasWall;
                lastCellWasWall=1;
            }
            else{
                lastCellWasWall=0;
                lastWallId=CELLTYPE_FLOOR;
            }
            
            for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
            {
                if (xCellCount == zHeight)
                {
                    ++xCell;
                    xCellCount = 0;
                    newCell=1;
                    currentCellID=cells_in_view_array[xCell + lineStart + 1];
                }
                if(!(x%2)){
                    if ((lateralWallCounter == 0)||newCell)
                    {
                        if (currentCellID & CELL_WALL_MASK)//Wall
                        {
                            lateralWallCounter = 0;//(zHeight - xCellCount);
                            lateralWallSlope = 0;
                            xHeight = zHeight;
                            color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
                            lastCellWasWall = 1;
                            lastWallId=currentCellID;
                        }
                        else{
                            if(lateralWallCounter==0){//Lateral wall not finished
                                if (lastCellWasWall)
                                {
                                    
                                    lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
                                    lateralWallSlopeCounter = lateralWallSlope / 2;
                                    lateralWallCounter = lateralWallSlope * zHeight;
                                    lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
                                    lateralWallWidth=lateralWallCounter;
                                    lastCellWasWall = 0;
                                    xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
                                    color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
                                }
                                else //Dont draw
                                {
                                    xHeight = 0;
                                    lastCellWasWall = 0;
                                    lateralWallSlope=0;
                                    lastWallId=0;
                                }
                            }
                        }
                        newCell=0;
                    }
                }
                if (lateralWallCounter > 0)
                {
                
                    if (lateralWallSlope != 0)
                    {
                        if (lateralWallSlopeCounter == lateralWallSlope)
                        {
                            lateralWallSlopeCounter = 0;
                            xHeight -= 2;
                        }
                        ++lateralWallSlopeCounter;
                    }
                    
                    --lateralWallCounter;
                }
                
                if (!(x%2))
                {
                    if(xHeight > 0){
                        draw_column_to_buffer_untextured(x/2, xHeight, color);
                        
                    }
                        if(!(currentCellID&CELL_WALL_MASK)){
                            if(currentCellID&CELL_ENEMY_MASK){
                                draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
                            }
                            else if(currentCellID&CELL_ITEM_MASK){
                                
                            }
                        }
                }
                
                ++xCellCount;
                
            }
            
            
            ////End to center
            
            xCellCount = (z) ? (zHeight >> 1) : 0 ;
            lateralWallSlope=0;
            lateralWallSlopeCounter=0;
            xHeight=0;
            xCell = 0;
            lateralWallCounter = 0;
            lineEnd = lineStart + offsetDiff * 2 + 2;
            
            newCell=1;
            currentCellID = cells_in_view_array[lineEnd - 1];
            
            lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
            if(lastCellWasWall&CELL_WALL_MASK){
                lastWallId=lastCellWasWall;
                lastCellWasWall=1;
            }
            else{
                lastCellWasWall=0;
                lastWallId=CELLTYPE_FLOOR;
            }
            
            for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
                
            {
                if (xCellCount == zHeight)
                {
                    ++xCell;
                    xCellCount = 0;
                    newCell=1;
                    currentCellID = cells_in_view_array[lineEnd - xCell - 1];
                }
                if(!(x%2)){
                    if (lateralWallCounter == 0 || newCell)
                    {
                        if ( currentCellID & CELL_WALL_MASK)//Wall
                        {
                            lateralWallCounter = 0;
                            lateralWallSlope = 0;
                            xHeight = zHeight;
                            color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
                            lastCellWasWall = 1;
                            lastWallId=currentCellID;
                        }
                        else if(lateralWallCounter==0){
                            if (lastCellWasWall)
                            {
                                
                                lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
                                lateralWallSlopeCounter = lateralWallSlope / 2;
                                lateralWallCounter = lateralWallSlope * zHeight;
                                lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
                                lateralWallWidth=lateralWallCounter;
                                lastCellWasWall = 0;
                                xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
                                color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
                            }
                            else //Dont draw
                            {
                                xHeight = 0;
                                lastCellWasWall = 0;
                                lateralWallSlope=0;
                                lastWallId=0;
                            }
                        }
                        newCell=0;
                    }
                }
                
                
                if (lateralWallCounter > 0)
                {
                    
                    if (lateralWallSlope != 0)
                    {
                        if (lateralWallSlopeCounter == lateralWallSlope)
                        {
                            lateralWallSlopeCounter = 0;
                            xHeight -= 2;
                        }
                        ++lateralWallSlopeCounter;
                    }
                    --lateralWallCounter;
                }
                
                
                if (!(x%2))
                {
                    
                    if(xHeight > 0){
                        
                        draw_column_to_buffer_untextured(x/2, xHeight, color);
                        
                    }
                        if(!(currentCellID&CELL_WALL_MASK)){
                            if(currentCellID&CELL_ENEMY_MASK){
                                draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
                            }
                            else if(currentCellID&CELL_ITEM_MASK){
                                
                            }
                        }
                }
                ++xCellCount;
                
            }
            
            
            
            
            lineStart = lineStart + (offsetDiff * 2) + 3;
            zHeight += zHeight;
            offsetDiff = offsetDiff >> 1;
            
        }while(z);
        
    }
}


void draw_minimap_to_buffer(){
    u8 i, j, n, val;
    i8 x,y;
    u8* ptr = MINIMAP_BUFFER;
    
    //u8 (*map)[MAP_HEIGHT] = MAP_MEM;
    //u8 pixMask; 
    x=(player_position.x-MINIMAP_WIDTH_HALF);
    y=(player_position.y-MINIMAP_HEIGHT_HALF);
    
    for(j=0;j<MINIMAP_HEIGHT;++j){
        for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
            x=(player_position.x-MINIMAP_WIDTH_HALF);
            for(i=0;i<MINIMAP_WIDTH;++i){
                if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
                    *ptr=g_colors[MINIMAP_WALL_COLOR];
                    *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
                }
                else if((x==player_position.x)&&(y==player_position.y)){
                    *ptr=g_colors[MINIMAP_PLAYER_COLOR];
                    *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
                }
                else{
                    val = (*(u8*)(MAP_MEM+x+y*MAP_WIDTH));
                    
                    if(val==CELLTYPE_DOOR){
                            *ptr=g_colors[MINIMAP_EXIT_COLOR];
                            *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
                    }
                    else if(val&CELL_WALL_MASK){
                            *ptr=g_colors[MINIMAP_WALL_COLOR];
                            *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
                    }
                    else{
                            *ptr=g_colors[MINIMAP_FLOOR_COLOR];
                            *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
                    }
                }
                ++x;
                ++ptr;
            }
        }
        ++y;
    }
}