[
    QGVAR(enableArsenalAutoSettings),
    "CHECKBOX",
    ["Enable Arsenal Radio settings Saving", "Saves the current radio settings before entering the arsenal and applies them when you exit the arsenal (both ACE and BI Arsenals) or after respawning."],
    [COMPONENT_NAME, "Funtionality"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableCompatFK),
    "CHECKBOX",
    ["Enable FK Server Detection", "When loading SR settings on an FK server, it will automatically change the channel to which squad you are in."],
    [COMPONENT_NAME, "Funtionality"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableSRInteractions),
    "CHECKBOX",
    ["Enable 'SR' Interactions", "Enables both saving and loading actions for SR."],
    [COMPONENT_NAME, "Funtionality"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableLRInteractions),
    "CHECKBOX",
    ["Enable 'LR' Interactions", "Enables both saving and loading actions for LR."],
    [COMPONENT_NAME, "Funtionality"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableVLRInteractions),
    "CHECKBOX",
    ["Enable 'VLR' Interactions", "Enables both saving and loading actions for VLR."],
    [COMPONENT_NAME, "Funtionality"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableSRAndLRInteractions),
    "CHECKBOX",
    ["Enable 'SR & LR' Interactions", "Enables both saving and loading actions for 'SR & LR'."],
    [COMPONENT_NAME, "Funtionality"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableAllInteractions),
    "CHECKBOX",
    ["Enable 'All' Interactions", "Enables both saving and loading actions for 'All'."],
    [COMPONENT_NAME, "Funtionality"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(airProfile),
    "LIST",
    ["Air Profile", "Applies the specified profile when you get into crew slots of air vehicles."],
    [COMPONENT_NAME, "Vehicles"],
    [["None"] + GETPRVAR(QGVAR(profileNames),[]), ["None"] + GETPRVAR(QGVAR(profileNames),[]), 0],
    0,
    {
        private _profiles = GETPRVAR(QGVAR(profileNames),[]);

        GVAR(airProfileName) = _profiles param [_profiles find _this, ""];
    }
] call CBA_fnc_addSetting;

[
    QGVAR(landProfile),
    "LIST",
    ["Land Profile", "Applies the specified profile when you get into crew slots of land vehicles."],
    [COMPONENT_NAME, "Vehicles"],
    [["None"] + GETPRVAR(QGVAR(profileNames),[]), ["None"] + GETPRVAR(QGVAR(profileNames),[]), 0],
    0,
    {
        private _profiles = GETPRVAR(QGVAR(profileNames),[]);

        GVAR(landProfileName) = _profiles param [_profiles find _this, ""];
    }
] call CBA_fnc_addSetting;

[
    QGVAR(askSaveConfirmation),
    "CHECKBOX",
    ["Ask Save Confirmation", "Asks the player for confirmation before saving a profile."],
    [COMPONENT_NAME, "Profiles"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(askLoadConfirmation),
    "CHECKBOX",
    ["Ask Load Confirmation", "Asks the player for confirmation before loading a profile."],
    [COMPONENT_NAME, "Profiles"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(askDeleteConfirmation),
    "CHECKBOX",
    ["Ask Delete Confirmation", "Asks the player for confirmation before deleting a profile."],
    [COMPONENT_NAME, "Profiles"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(askOverwriteConfirmation),
    "CHECKBOX",
    ["Ask Overwrite Confirmation", "Asks the player for confirmation before overwriting a profile when importing/making a new profile."],
    [COMPONENT_NAME, "Profiles"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(loadColorIcon),
    "COLOR",
    ["Icon Color in Messages", "Sets the icons in the messages to this color."],
    [COMPONENT_NAME, "Profiles"],
    [1, 1, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(enableMountingAutoSettings),
    "CHECKBOX",
    ["Enable Mounting Radio settings Saving", "Saves the current radio settings before entering a vehicle and applies them when you dismount."],
    [COMPONENT_NAME, "Vehicles"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(crewStatusDefault),
    "CHECKBOX",
    ["Default Crew Status", "Sets the crew status you are by default when joining a mission. 'On' means you are crew, 'Off' means you aren't."],
    [COMPONENT_NAME, "Vehicles"],
    false
] call CBA_fnc_addSetting;
