#include "script_component.hpp"

/*
 * Author: johnb43
 * Loads the saved settings in a vehicle.
 *
 * Arguments:
 * 0: Unit <OBJECT> (default: player)
 * 1: Radio data <ARRAY> (default: [[], [], [], false])
 * 2: LR Radio <ARRAY> (default: [])
 * 3: SR Radio <STRING> (default: call FUNC(activeSwRadio))
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, [[], [], [], false], player call TFAR_fnc_vehicleLR] call tfar_ace_extended_main_fnc_loadVehicleSettings;
 *
 * Public: No
 */

params [["_unit", player, [objNull]], ["_data", [[], [], [], false], [[]], PROFILE_COUNT], ["_radioLR", [], [[]]], ["_radioSR", call FUNC(activeSwRadio), [""]]];
_data params [["_dataSR", [], [[]], [0, RADIO_SETTINGS_COUNT]], ["_dataLR", [], [[]], [0, RADIO_SETTINGS_COUNT]], ["_dataVLR", [], [[]], [0, RADIO_SETTINGS_COUNT]], ["_headsetStatus", false, [true]]];

if (!alive _unit) exitWith {};

// If a SW is found and the settings are not [], load them
if (_radioSR isNotEqualTo "" && {_dataSR isNotEqualTo []}) then {
    // Load the side encryption; The radio settings in a profile will never be overwritten by using this
    private _code = [_radioSR, "tf_encryptionCode"] call TFAR_fnc_getWeaponConfigProperty;

    if (_code == "tf_guer_radio_code") then {
        _code = "tf_independent_radio_code";
    };

    _dataSR set [TFAR_CODE_OFFSET, _code];

    // Set settings
    [_radioSR, _dataSR] call TFAR_fnc_setSwSettings;
    [_unit, _radioSR] call FUNC(setChannelFK);
};

// If a LR is found and the settings are not [], load them
if (_radioLR isNotEqualTo [] && {_dataLR isNotEqualTo [] || {_dataVLR isNotEqualTo []}}) then {
    // Apply VLR to VLR if possible, otherwise a mix of settings (LR -> VLR, VLR -> LR, LR -> LR)
    _dataLR = [_dataLR, _dataVLR] select (_dataVLR isNotEqualTo []);

    // Load the side encryption; The radio settings in a profile will never be overwritten by using this
    private _code = [_radioLR, "tf_encryptionCode"] call TFAR_fnc_getWeaponConfigProperty;

    if (_code == "tf_guer_radio_code") then {
        _code = "tf_independent_radio_code";
    };

    _dataLR set [TFAR_CODE_OFFSET, _code];

    // Set settings
    [_radioLR, _dataLR] call TFAR_fnc_setLrSettings;
};

// Set the headset up or down
_headsetStatus call TFAR_fnc_setHeadsetLowered;
