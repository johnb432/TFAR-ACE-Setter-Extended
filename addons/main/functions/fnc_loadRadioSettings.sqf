#include "script_component.hpp"

/*
 * Author: johnb43
 * Loads select radio configurations from a chosen profile.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Which radios should be loaded <ARRAY>
 * 2: Which profile is selected <STRING>
 * 3: Load other type of radio (only works for LR and VLR) <BOOLEAN> (optional)
 * 4: SR Radio <STRING> (optional)
 * 5: LR Radio <ARRAY> (optional)
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, [true, false, false], "Test"] call tfar_ace_extended_main_fnc_loadRadioSettings;
 *
 * Public: No
 */

params [["_unit", player, [objNull]], ["_loadFromRadios", [false, false, false], [[]]], ["_profile", "", [""]], ["_loadSameType", true, [true]], ["_radioSR", call FUNC(activeSwRadio), [""]], ["_radioLR", [], [[]]]];
_loadFromRadios params [["_doSR", false, [true]], ["_doLR", false, [true]], ["_doVLR", false, [true]]];

if (!alive _unit) exitWith {};

// If profile is invalid
if (_profile isEqualTo "") exitWith {
    ["The chosen profile is invalid!", false, 10, 2] call ace_common_fnc_displayText;
};

GETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),[]) params ["_dataSR", "_dataLR", "_dataVLR", "_headsetStatus"];

// Load the side encryption; The radio settings in a profile will never be overwritten by using this
private _code = switch (side _unit) do {
    case east: {tfar_radiocode_east};
    case west: {tfar_radiocode_west};
    default {tfar_radiocode_independent};
};

// Store all changed radios
private _textArray = [];

// If the SR settings should be loaded
if (_doSR && {_radioSR isNotEqualTo ""} && {_dataSR isNotEqualTo []}) then {
    // Set settings
    [_radioSR, _dataSR] call TFAR_fnc_setSwSettings;
    [_radioSR, _code] call TFAR_fnc_setSwRadioCode;
    [_unit, _radioSR] call FUNC(setChannelFK);

    _textArray pushBack "SR";
};

// If the LR settings should be loaded
if (_doLR && {_dataLR isNotEqualTo []}) then {
    // If curator, do not change LR radio
    if (_radioLR isEqualTo []) then {
        // If loading from a LR to a LR, saveSameType == true, if loading from VLR to LR, then not
        _radioLR = _unit call ([TFAR_fnc_vehicleLR, TFAR_fnc_backpackLR] select _loadSameType);
    };

    if (isNil "_radioLR") exitWith {};

    [_radioLR, _dataLR] call TFAR_fnc_setLrSettings;
    [_radioLR, _code] call TFAR_fnc_setLrRadioCode;

    _textArray pushBack "LR";
};

// If the VLR settings should be loaded
if (_doVLR && {_dataVLR isNotEqualTo []}) then {
    // If loading from a VLR to a VLR, saveSameType == true, if loading from LR to VLR, then not
    _radioLR = _unit call ([TFAR_fnc_backpackLR, TFAR_fnc_vehicleLR] select _loadSameType);

    if (isNil "_radioLR") exitWith {};

    [_radioLR, _dataVLR] call TFAR_fnc_setLrSettings;
    [_radioLR, _code] call TFAR_fnc_setLrRadioCode;

    _textArray pushBack "VLR";
};

// If nothing was changed
if (_textArray isEqualTo []) exitWith {
    ["No settings were loaded!", ICON_LOAD] call ace_common_fnc_displayTextPicture;
};

// Set the headset up or down
if (!isNil "_headsetStatus") then {
    _headsetStatus call TFAR_fnc_setHeadsetLowered;
};

// Change text accordingly
private _text = "";
private _count = count _textArray - 1;

{
    _text = _text + _x + ([", ", ""] select (_forEachIndex isEqualTo _count));
} forEach _textArray;

[format ["Loaded %1 settings from profile '%2'.", _text, _profile], ICON_LOAD, GVAR(loadColorIcon), _unit, 3] call ace_common_fnc_displayTextPicture;
