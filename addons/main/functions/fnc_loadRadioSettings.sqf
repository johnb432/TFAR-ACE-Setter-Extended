#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Loads select radio configurations from a chosen profile.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Which radios should be loaded <ARRAY>
 * 2: Profile name <STRING>
 * 3: Load same type of radio (only works for LR and VLR) <BOOL>
 * 4: SR Radio <STRING>
 * 5: LR Radio <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, [true, false, false], "Test"] call tfar_ace_extended_main_fnc_loadRadioSettings
 *
 * Public: No
 */

params ["_unit", "_loadFromRadios", "_profile", "_loadSameType", "_radioSR", "_radioLR"];
_loadFromRadios params ["_doSR", "_doLR", "_doVLR"];

if (!alive _unit) exitWith {};

// If profile is invalid
if (_profile == "") exitWith {
    [LLSTRING(invalidProfile), false, 10, 2] call ace_common_fnc_displayText;
};

GETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),[]) params ["_dataSR", "_dataLR", "_dataVLR", "_headsetStatus"];

// Store all changed radios
private _textArray = [];

// If the SR settings should be loaded
if (_doSR && {_radioSR != ""} && {_dataSR isNotEqualTo []}) then {
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
    private _code = [typeOf (_radioLR select 0), "tf_encryptionCode"] call TFAR_fnc_getVehicleConfigProperty;

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
    private _code = [typeOf (_radioLR select 0), "tf_encryptionCode"] call TFAR_fnc_getVehicleConfigProperty;

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
    [LLSTRING(noSettingsLoaded), ICON_LOAD] call ace_common_fnc_displayTextPicture;
};

// Set the headset up or down
_headsetStatus call TFAR_fnc_setHeadsetLowered;

[format [LLSTRING(settingsLoadedFromProfile), _textArray joinString ", ", _profile], ICON_LOAD, GVAR(loadColorIcon), _unit, 3] call ace_common_fnc_displayTextPicture;
