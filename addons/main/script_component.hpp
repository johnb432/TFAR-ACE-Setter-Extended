#define COMPONENT main
#include "script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_TFAR_ACE_EXTENDED
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_TFAR_ACE_EXTENDED
    #define DEBUG_SETTINGS DEBUG_SETTINGS_TFAR_ACE_EXTENDED
#endif

#include "script_macros.hpp"

// Include BI DIK codes
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
