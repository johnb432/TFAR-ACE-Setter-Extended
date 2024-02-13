[
    QGVAR(enableArsenalAutoSettings),
    "CHECKBOX",
    [LSTRING(enableArsenalSaving), LSTRING(enableArsenalSavingDesc)],
    [COMPONENT_NAME, LSTRING(functionalityCategory)],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableCompatFK),
    "CHECKBOX",
    [LSTRING(enabledFkDetection), LSTRING(enabledFkDetectionDesc)],
    [COMPONENT_NAME, LSTRING(functionalityCategory)],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableSRInteractions),
    "CHECKBOX",
    [LSTRING(enableSrInteractions), LSTRING(enableSrInteractionsDesc)],
    [COMPONENT_NAME, LSTRING(functionalityCategory)],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableLRInteractions),
    "CHECKBOX",
    [LSTRING(enableLrInteractions), LSTRING(enableLrInteractionsDesc)],
    [COMPONENT_NAME, LSTRING(functionalityCategory)],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableVLRInteractions),
    "CHECKBOX",
    [LSTRING(enableVlrInteractions), LSTRING(enableVlrInteractionsDesc)],
    [COMPONENT_NAME, LSTRING(functionalityCategory)],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableSRAndLRInteractions),
    "CHECKBOX",
    [LSTRING(enableSrLrInteractions), LSTRING(enableSrLrInteractionsDesc)],
    [COMPONENT_NAME, LSTRING(functionalityCategory)],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableAllInteractions),
    "CHECKBOX",
    [LSTRING(enableAllInteractions), LSTRING(enableAllInteractionsDesc)],
    [COMPONENT_NAME, LSTRING(functionalityCategory)],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(airProfile),
    "LIST",
    [LSTRING(airProfile), LSTRING(airProfileDesc)],
    [COMPONENT_NAME, LSTRING(vehiclesCategory)],
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
    [LSTRING(landProfile), LSTRING(landProfileDesc)],
    [COMPONENT_NAME, LSTRING(vehiclesCategory)],
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
    [LSTRING(askSaveConfirmation), LSTRING(askSaveConfirmationDesc)],
    [COMPONENT_NAME, LSTRING(profilesCategory)],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(askLoadConfirmation),
    "CHECKBOX",
    [LSTRING(askLoadConfirmation), LSTRING(askLoadConfirmationDesc)],
    [COMPONENT_NAME, LSTRING(profilesCategory)],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(askDeleteConfirmation),
    "CHECKBOX",
    [LSTRING(askDeleteConfirmation), LSTRING(askDeleteConfirmationDesc)],
    [COMPONENT_NAME, LSTRING(profilesCategory)],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(askOverwriteConfirmation),
    "CHECKBOX",
    [LSTRING(askOverwriteConfirmation), LSTRING(askOverwriteConfirmationDesc)],
    [COMPONENT_NAME, LSTRING(profilesCategory)],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(loadColorIcon),
    "COLOR",
    [LSTRING(loadColorIcon), LSTRING(loadColorIconDesc)],
    [COMPONENT_NAME, LSTRING(profilesCategory)],
    [1, 1, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(enableMountingAutoSettings),
    "CHECKBOX",
    [LSTRING(enableMountingAutoSettings), LSTRING(enableMountingAutoSettingsDesc)],
    [COMPONENT_NAME, LSTRING(vehiclesCategory)],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(crewStatusDefault),
    "CHECKBOX",
    [LSTRING(crewStatusDefault), LSTRING(crewStatusDefaultDesc)],
    [COMPONENT_NAME, LSTRING(vehiclesCategory)],
    false
] call CBA_fnc_addSetting;
