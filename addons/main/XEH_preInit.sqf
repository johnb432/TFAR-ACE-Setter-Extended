#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// CBA Settings
#include "initSettings.sqf"

// CBA Keybinds
private _str = format ["%1 %2", localize "STR_TFAR_CORE_key_SW_Channel", 9];

// Add Keybind for Channel 9 on SR
[COMPONENT_NAME, QGVAR(SWChannel9), [_str, _str], {
    // Returns if event was handled or not
    8 call TFAR_fnc_processSWChannelKeys
}, {}, [DIK_NUMPAD9, [false, false, false]]] call CBA_fnc_addKeybind;

ADDON = true;
