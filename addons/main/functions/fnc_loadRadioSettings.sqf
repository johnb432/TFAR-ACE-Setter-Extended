#include "script_component.hpp"

/*
 * Author: johnb43
 * Loads select radio configurations from a chosen profile.
 *
 * Arguments:
 * 0: Unit <OBJECT> (default: player)
 * 1: Which radios should be loaded <ARRAY> (default: [false, false, false])
 * 2: Which profile is selected <STRING> (default: "")
 * 3: Load same type of radio (only works for LR and VLR) <BOOL> (default: true)
 * 4: SR Radio <STRING> (default: call FUNC(activeSwRadio))
 * 5: LR Radio <ARRAY> (default: [])
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, [true, false, false], "Test"] call tfar_ace_extended_main_fnc_loadRadioSettings;
 *
 * Public: No
 */

params [["_unit", player, [objNull]], ["_loadFromRadios", [false, false, false], [[]], [1, 2, 3]], ["_profile", "", [""]], ["_loadSameType", true, [true]], ["_radioSR", call FUNC(activeSwRadio), [""]], ["_radioLR", [], [[]]]];
_loadFromRadios params [["_doSR", false, [true]], ["_doLR", false, [true]], ["_doVLR", false, [true]]];

if (!alive _unit) exitWith {};

// If profile is invalid
if (_profile isEqualTo "") exitWith {
    ["The chosen profile is invalid!", false, 10, 2] call ace_common_fnc_displayText;
};

GETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),[]) params ["_dataSR", "_dataLR", "_dataVLR", "_headsetStatus"];

// Store all changed radios
private _textArray = [];

// If the SR settings should be loaded
if (_doSR && {_radioSR isNotEqualTo ""} && {_dataSR isNotEqualTo []}) then {
    // Load the side encryption; The radio settings in a profile will never be overwritten by using this
    private _code = [_radioSR, "tf_encryptionCode"] call TFAR_fnc_getWeaponConfigProperty;

    if (_code == "tf_guer_radio_code") then {
        _code = "tf_independent_radio_code";
    };

    _dataSR set [TFAR_CODE_OFFSET, _code];

    // Set settings
    [_radioSR, _dataSR] call TFAR_fnc_setSwSettings;
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

    // Load the side encryption; The radio settings in a profile will never be overwritten by using this
    private _code = [_radioLR, "tf_encryptionCode"] call TFAR_fnc_getWeaponConfigProperty;

    if (_code == "tf_guer_radio_code") then {
        _code = "tf_independent_radio_code";
    };

    _dataLR set [TFAR_CODE_OFFSET, _code];

    // Set settings
    [_radioLR, _dataLR] call TFAR_fnc_setLrSettings;

    _textArray pushBack "LR";
};

// If the VLR settings should be loaded
if (_doVLR && {_dataVLR isNotEqualTo []}) then {
    // If loading from a VLR to a VLR, saveSameType == true, if loading from LR to VLR, then not
    _radioLR = _unit call ([TFAR_fnc_backpackLR, TFAR_fnc_vehicleLR] select _loadSameType);

    if (isNil "_radioLR") exitWith {};

    // Load the side encryption; The radio settings in a profile will never be overwritten by using this
    private _code = [_radioLR, "tf_encryptionCode"] call TFAR_fnc_getWeaponConfigProperty;

    if (_code == "tf_guer_radio_code") then {
        _code = "tf_independent_radio_code";
    };

    _dataVLR set [TFAR_CODE_OFFSET, _code];

    // Set settings
    [_radioLR, _dataVLR] call TFAR_fnc_setLrSettings;

    _textArray pushBack "VLR";
};

// If nothing was changed
if (_textArray isEqualTo []) exitWith {
    ["No settings were loaded!", ICON_LOAD] call ace_common_fnc_displayTextPicture;
};

// Set the headset up or down
_headsetStatus call TFAR_fnc_setHeadsetLowered;

[format ["Loaded %1 settings from profile '%2'.", _textArray joinString ", ", _profile], ICON_LOAD, GVAR(loadColorIcon), _unit, 3] call ace_common_fnc_displayTextPicture;
