#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
    QGVAR(airProfile),
    "EDITBOX",
    ["Air profile", "Applies the specified profile when you get in air vehicles."],
    [COMPONENT_NAME, "Vehicles"],
    "",
    false
] call CBA_fnc_addSetting;

[
    QGVAR(landProfile),
    "EDITBOX",
    ["Land profile", "Applies the specified profile when you get in land vehicles."],
    [COMPONENT_NAME, "Vehicles"],
    "",
    false
] call CBA_fnc_addSetting;

[
    QGVAR(askSaveConfirmation),
    "CHECKBOX",
    ["Ask save confirmation", "Asks the player for confirmation before saving a profile."],
    [COMPONENT_NAME, "Profiles"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(askLoadConfirmation),
    "CHECKBOX",
    ["Ask load confirmation", "Asks the player for confirmation before loading a profile."],
    [COMPONENT_NAME, "Profiles"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(askDeleteConfirmation),
    "CHECKBOX",
    ["Ask delete confirmation", "Asks the player for confirmation before deleting a profile."],
    [COMPONENT_NAME, "Profiles"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableArsenalAutoSettings),
    "CHECKBOX",
    ["Enable arsenal radio settings saving", "Saves the current radio settings before entering the arsenal and applies them when you exit the arsenal (both ACE and BI Arsenals)."],
    [COMPONENT_NAME, "Funtionality"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableMountingAutoSettings),
    "CHECKBOX",
    ["Enable mounting radio settings saving", "Saves the current radio settings before entering a vehicle and applies them when you dismount."],
    [COMPONENT_NAME, "Vehicles"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableCompatFK),
    "CHECKBOX",
    ["Enable FK Server detection", "When loading SR settings on an FK server, it will automatically change the channel to which squad you are in."],
    [COMPONENT_NAME, "Funtionality"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableSRInteractions),
    "CHECKBOX",
    ["Enable 'SR' interactions", "Enables both saving and loading actions for SR."],
    [COMPONENT_NAME, "Funtionality"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableLRInteractions),
    "CHECKBOX",
    ["Enable 'LR' interactions", "Enables both saving and loading actions for LR."],
    [COMPONENT_NAME, "Funtionality"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableVLRInteractions),
    "CHECKBOX",
    ["Enable 'VLR' interactions", "Enables both saving and loading actions for VLR."],
    [COMPONENT_NAME, "Funtionality"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableSRAndLRInteractions),
    "CHECKBOX",
    ["Enable 'SR & LR' interactions", "Enables both saving and loading actions for 'SR & LR'."],
    [COMPONENT_NAME, "Funtionality"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableAllInteractions),
    "CHECKBOX",
    ["Enable 'All' interactions", "Enables both saving and loading actions for 'All'."],
    [COMPONENT_NAME, "Funtionality"],
    true,
    false
] call CBA_fnc_addSetting;

ADDON = true;
