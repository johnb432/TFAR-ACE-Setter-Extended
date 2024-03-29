#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Saves select radio configurations to a chosen profile.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Which radios should be saved <ARRAY>
 * 2: Profile name <STRING>
 * 3: Load same type of radio (only works for LR and VLR)
 * 4: SR Radio <STRING>
 * 5: LR Radio <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, [true, false, false], "Test"] call tfar_ace_extended_main_fnc_saveRadioSettings
 *
 * Public: No
 */

params ["_unit", "_saveToRadios", "_profile", "_saveSameType", "_radioSR", "_radioLR"];
_saveToRadios params ["_doSR", "_doLR", "_doVLR"];

if (!alive _unit) exitWith {};

// If nothing was changed
if (!_doSR && {!_doLR} && {!_doVLR}) exitWith {
    [LLSTRING(noSettingsSaved), false, 10, 2] call ace_common_fnc_displayText;
};

// If profile is invalid
if (_profile == "") exitWith {
    [LLSTRING(invalidProfile), false, 10, 2] call ace_common_fnc_displayText;
};

// Get data from selected profile
private _data = GETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),[]);

// Store all changed radios
private _textArray = [];

// If the SR settings should be saved
if (_doSR && {_radioSR != ""}) then {
    // Set the data in the first element
    _data set [0, _radioSR call TFAR_fnc_getSwSettings];

    _textArray pushBack "SR";
};

// If the LR settings should be saved
if (_doLR) then {
    // If curator, do not change LR radio
    if (_radioLR isEqualTo []) then {
        _radioLR = _unit call TFAR_fnc_backpackLR;
    };

    if (isNil "_radioLR") exitWith {};

    // If saving from a LR to a LR, saveSameType == true, if saving from VLR to LR, then not
    _data set [[2, 1] select _saveSameType, _radioLR call TFAR_fnc_getLrSettings];

    _textArray pushBack "LR";
};

// If the VLR settings should be saved
if (_doVLR) then {
    _radioLR = _unit call TFAR_fnc_vehicleLR;

    if (isNil "_radioLR") exitWith {};

    // If saving from a VLR to a VLR, saveSameType == true, if saving from LR to VLR, then not
    _data set [[1, 2] select _saveSameType, _radioLR call TFAR_fnc_getLrSettings];

    _textArray pushBack "VLR";
};

// If entries are nil, set them to []
{
    if (isNil "_x" || {_x isEqualType objNull && {isNull _x}}) then {
        _data set [_forEachIndex, []];
    };
} forEach _data;

// Save whether headset is down or up
_data set [3, GETMVAR("TFAR_core_isHeadsetLowered",false)];

SETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),_data);

[format [LLSTRING(settingsSavedToProfile), _textArray joinString ", ", _profile], ICON_SAVE, GVAR(loadColorIcon), _unit, 3] call ace_common_fnc_displayTextPicture;
