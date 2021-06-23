#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
    QGVAR(airProfile),
    "EDITBOX",
    ["Air profile", "Applies the specified profile when you get in air vehicles."],
    [COMPONENT_NAME, "Profiles"],
    "",
    false
] call CBA_fnc_addSetting;

[
    QGVAR(landProfile),
    "EDITBOX",
    ["Land profile", "Applies the specified profile when you get in land vehicles."],
    [COMPONENT_NAME, "Profiles"],
    "",
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableArsenalAutoSettings),
    "CHECKBOX",
    ["Enable automatic arsenal saving of radio settings", "Saves the current radio preset when entering the arsenal and applies it when you exit the arsenal (both ACE and BI Arsenals)."],
    [COMPONENT_NAME, "Funtionality"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableMountingAutoSettings),
    "CHECKBOX",
    ["Enable automatic mounting saving of radio settings", "Saves the current radio settings when entering a vehicle and applies this setting's profile.\nWhen dismounting, settings that were saved before mounting are applied."],
    [COMPONENT_NAME, "Funtionality"],
    true,
    false
] call CBA_fnc_addSetting;

ADDON = true;
