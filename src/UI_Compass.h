#ifndef UI_COMPASS_H
#define UI_COMPASS_H

#include <cpctelera.h>
#include "GameDefinitions.h"

#define COMPASS_POSITION    (SCREEN_PTR_AT(CPCT_VMEM_START, 36, 0))

extern void renderCompass();

#endif
