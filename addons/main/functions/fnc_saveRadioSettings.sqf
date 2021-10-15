#include "script_component.hpp"
/*
 * Author: johnb43
 * Saves select radio configurations to a chosen profile.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Which radios should be saved <ARRAY>
 * 2: Load other type of radio (only works for LR and VLR) <BOOLEAN>
 * 3: Which profile is selected <STRING>
 * 4: SR Radio <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_saveToRadios", "_saveSameType", "_profile", "_radio"];
_saveToRadios params ["_doSR", "_doLR", "_doVLR"];

// Get data from selected profile
private _data = GETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),[]);

// Store all changed radios
private _textArray = [];

// If the SR settings should be saved
if (_doSR) then {
    // Set the data in the first element
    _data set [0, ([_radio, call TFAR_fnc_activeSwRadio] select (_radio isEqualTo "")) call TFAR_fnc_getSwSettings];

    _textArray pushBack "SR";
};

// If the LR settings should be saved
if (_doLR) then {
    // If saving from a LR to a LR, saveSameType == true, if saving from VLR to LR, then not
    _data set [[2, 1] select _saveSameType, (_unit call TFAR_fnc_backpackLR) call TFAR_fnc_getLrSettings];

    _textArray pushBack "LR";
};

// If the VLR settings should be saved
if (_doVLR) then {
    // If saving from a VLR to a VLR, saveSameType == true, if saving from LR to VLR, then not
    _data set [[1, 2] select _saveSameType, (_unit call TFAR_fnc_vehicleLR) call TFAR_fnc_getLrSettings];

    _textArray pushBack "VLR";
};

// If entries are nil, set them to []
{
    if (isNil "_x") then {
        _data set [_forEachIndex, []];
    };
} forEach _data;

// Save whether headset is down or up
_data set [3, GETMVAR("TFAR_core_isHeadsetLowered",false)];

SETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),_data);

// Change text accordingly
private _text = "";

{
    _text = _text + _x + ([", ", ""] select (_forEachIndex isEqualTo (count _textArray - 1)));
} forEach _textArray;

[format ["Saved %1 settings to profile '%2'.", _text, _profile], ICON_SAVE, GVAR(loadColorIcon), _unit, 3] call ace_common_fnc_displayTextPicture;
