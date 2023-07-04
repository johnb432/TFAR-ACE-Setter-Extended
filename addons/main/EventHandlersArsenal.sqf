// When arsenals open, save current radio config
["ace_arsenal_displayOpened", {
    private _unit = TFAR_currentUnit;

    // If CBA settings for this are disabled, break
    if (!GVAR(enableArsenalAutoSettings) || {GETMVAR("ace_arsenal_center",_unit) isNotEqualTo _unit}) exitWith {};

    private _radioSR = call FUNC(activeSwRadio);

    private _dataRadioSR = if (_radioSR isNotEqualTo "") then {
        _radioSR call TFAR_fnc_getSwSettings
    } else {
        []
    };

    // Get currently active radios
    private _data = [_dataRadioSR, (_unit call TFAR_fnc_backpackLR) call TFAR_fnc_getLrSettings, [], GETMVAR("TFAR_core_isHeadsetLowered",false)];

    // If entries are nil, set them to []
    {
        if (isNil "_x" || {_x isEqualType objNull && {isNull _x}}) then {
            _data set [_forEachIndex, []];
        };
    } forEach _data;

    _unit setVariable [QGVAR(radioLoadout), _data];
}] call CBA_fnc_addEventHandler;

[missionNamespace, "arsenalOpened", {
    private _unit = TFAR_currentUnit;

    // If CBA settings for this are disabled, break
    if (!GVAR(enableArsenalAutoSettings) || {GETMVAR("BIS_fnc_arsenal_center",_unit) isNotEqualTo _unit}) exitWith {};

    private _radioSR = call FUNC(activeSwRadio);

    private _dataRadioSR = if (_radioSR isNotEqualTo "") then {
        _radioSR call TFAR_fnc_getSwSettings
    } else {
        []
    };

    // Get currently active radios
    private _data = [_dataRadioSR, (_unit call TFAR_fnc_backpackLR) call TFAR_fnc_getLrSettings, [], GETMVAR("TFAR_core_isHeadsetLowered",false)];

    // If entries are nil, set them to []
    {
        if (isNil "_x" || {_x isEqualType objNull && {isNull _x}}) then {
            _data set [_forEachIndex, []];
        };
    } forEach _data;

    _unit setVariable [QGVAR(radioLoadout), _data];
}] call BIS_fnc_addScriptedEventHandler;

private _code = {
    private _unit = TFAR_currentUnit;

    // If CBA settings for this are disabled or no previous settings were found, break
    if (!GVAR(enableArsenalAutoSettings) || {isNil {_unit getVariable QGVAR(radioLoadout)}}) exitWith {};

    // Delay setting of radios, to overwrite other mods
    [{
        // Load the SW settings when a SW is detected; However, there is a 10s timeout timer, in case a SW is never found
        [{
           call TFAR_fnc_haveSWRadio
        }, {
            (_this getVariable [QGVAR(radioLoadout), [[], [], [], false]]) params ["_SR", "", "", "_headset"];

            if (_SR isNotEqualTo []) then {
                [call FUNC(activeSwRadio), _SR] call TFAR_fnc_setSwSettings;
            };

            _headset call TFAR_fnc_setHeadsetLowered;
        }, _this, 10] call CBA_fnc_waitUntilAndExecute;

        // Load the LR settings when a LR is detected; However, there is a 10s timeout timer, in case a LR is never found
        [{
           !isNil {_this call TFAR_fnc_backpackLR}
        }, {
            (_this getVariable [QGVAR(radioLoadout), [[], [], [], false]]) params ["", "_LR", "", "_headset"];

            if (_LR isNotEqualTo []) then {
                [_this call TFAR_fnc_backpackLR, _LR] call TFAR_fnc_setLrSettings;
            };

            _headset call TFAR_fnc_setHeadsetLowered;
        }, _this, 10] call CBA_fnc_waitUntilAndExecute;
    }, _unit, 1] call CBA_fnc_waitAndExecute;
};

// When arsenals close, apply previously saved config
["ace_arsenal_displayClosed", _code] call CBA_fnc_addEventHandler;
[missionNamespace, "arsenalClosed", _code] call BIS_fnc_addScriptedEventHandler;
