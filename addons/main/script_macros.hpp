#include "\x\cba\addons\main\script_macros_common.hpp"

// This part includes parts of the CBA and ACE3 macro libraries
#define GETPRVAR(var1,var2) (profileNamespace getVariable [ARR_2(var1,var2)])
#define SETPRVAR(var1,var2) (profileNamespace setVariable [ARR_2(var1,var2)])

#define GETMVAR(var1,var2) (missionNamespace getVariable [ARR_2(var1,var2)])

// From TFAR
#define TFAR_CODE_OFFSET 4

#define ASCII_NEWLINE 10
#define ASCII_CARRIAGE_RETURN 13
#define ASCII_TAB 9
#define ASCII_SPACE 32
#define WHITESPACE toString [ASCII_NEWLINE, ASCII_CARRIAGE_RETURN, ASCII_TAB, ASCII_SPACE]

#define DELETE_PROFILE 0
#define EXPORT_PROFILE 1

#define PROFILE_COUNT 4
#define RADIO_SETTINGS_COUNT 10

#define EXCEPTIONS exceptions[] = {"isNotInside","isNotSitting","isNotSwimming"}

#define ICON_ROOT QPATHTOF(ui\interact_root.paa)
#define ICON_SAVE QPATHTOF(ui\save.paa)
#define ICON_LOAD QPATHTOF(ui\load.paa)
#define ICON_ADD "\A3\ui_f\data\gui\cfg\cursors\add_gs.paa"
#define ICON_DELETE "\A3\ui_f\data\igui\cfg\commandbar\unitcombatmode_ca.paa"
#define ICON_PERSON "\a3\Modules_F_Bootcamp\Data\PortraitPunishment.paa"
#define ICON_SR QPATHTOF(ui\sr.paa)
#define ICON_LR QPATHTOF(ui\lr.paa)
#define ICON_VLR QPATHTOF(ui\vlr_plane.paa)

#define IDC_OK 1 // emulate "OK" button
#define IDC_CANCEL 2 // emulate "Cancel" button

#define IDD_MISSION 46
#define IDD_RSCDISPLAYCURATOR 312
#define IDD_EDIT_BOX_NAME 123
#define IDD_EDIT_BOX_SETTINGS 124
#define IDD_LIST_SELECTED 125

#define POS_W(var1) var1 * _wOff
#define POS_H(var1) var1 * _hOff
#define POS_X(var1) POS_W(var1) + _xOff
#define POS_Y(var1) POS_H(var1) + _yOff

#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif
