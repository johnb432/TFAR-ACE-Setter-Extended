#include "script_component.hpp"
/*
 * Author: johnb43
 * Loads select radio configurations from a chosen profile.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Which radios should be loaded <ARRAY>
 * 2: Load other type of radio (only works for LR and VLR) <BOOLEAN>
 * 3: Which profile is selected <STRING>
 * 4: SR Radio <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_loadFromRadios", "_loadSameType", "_profile", "_radio"];
_loadFromRadios params ["_doSR", "_doLR", "_doVLR"];

GETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),[]) params ["_SR", "_LR", "_VLR", "_headsetStatus"];

// If SR radio is specifically defined, choose that over the active SR
_radio = [_radio, call TFAR_fnc_activeSwRadio] select (_radio isEqualTo "");

// Load the side encryption. However, the radio settings in a profile will never be overwritten by using this
private _code = tfar_radiocode_independent;

switch (side _unit) do {
    case east: {_code = tfar_radiocode_east};
    case west: {_code = tfar_radiocode_west};
    default {};
};

// Store all changed radios
private _textArray = [];

// If the SR settings should be loaded
if (_doSR && {_SR isNotEqualTo []}) then {
    // Set settings
    [_radio, _SR] call TFAR_fnc_setSwSettings;
    [_radio, _code] call TFAR_fnc_setSwRadioCode;
    [_unit, _radio] call FUNC(setChannelFK);

    _textArray pushBack "SR";
};

// If the LR settings should be loaded
if (_doLR && {_LR isNotEqualTo []}) then {
    // If loading from a LR to a LR, saveSameType == true, if loading from VLR to LR, then not
    _radio = _unit call ([TFAR_fnc_vehicleLR, TFAR_fnc_backpackLR] select _loadSameType);
    [_radio, _LR] call TFAR_fnc_setLrSettings;
    [_radio, _code] call TFAR_fnc_setLrRadioCode;

    _textArray pushBack "LR";
};

// If the VLR settings should be loaded
if (_doVLR && {_VLR isNotEqualTo []}) then {
    // If loading from a VLR to a VLR, saveSameType == true, if loading from LR to VLR, then not
    _radio = _unit call ([TFAR_fnc_backpackLR, TFAR_fnc_vehicleLR] select _loadSameType);
    [_radio, _VLR] call TFAR_fnc_setLrSettings;
    [_radio, _code] call TFAR_fnc_setLrRadioCode;

    _textArray pushBack "VLR";
};

// Set the headset up or down
if (!isNil "_headsetStatus") then {
    _headsetStatus call TFAR_fnc_setHeadsetLowered;
};

// If nothing was changed
if (_textArray isEqualTo []) exitWith {
    ["No settings were loaded!", ICON_LOAD] call ace_common_fnc_displayTextPicture;
};

// Change text accordingly
private _text = "";

{
    _text = _text + _x + ([", ", ""] select (_forEachIndex isEqualTo (count _textArray - 1)));
} forEach _textArray;

[format ["Loaded %1 settings from profile '%2'.", _text, _profile], ICON_LOAD, GVAR(loadColorIcon), _unit, 3] call ace_common_fnc_displayTextPicture;
