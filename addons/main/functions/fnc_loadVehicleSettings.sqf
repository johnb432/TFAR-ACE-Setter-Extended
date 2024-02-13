#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Loads the saved settings in a vehicle.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Radio data <ARRAY>
 * 2: LR Radio <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, [[], [], [], false], player call TFAR_fnc_vehicleLR] call tfar_ace_extended_main_fnc_loadVehicleSettings
 *
 * Public: No
 */

params ["_unit", "_data", "_radioLR"];
_data params ["_dataSR", "_dataLR", "_dataVLR", "_headsetStatus"];

if (!alive _unit) exitWith {};

private _radioSR = call FUNC(activeSwRadio);

// If a SW is found and the settings are not [], load them
if (_radioSR != "" && {_dataSR isNotEqualTo []}) then {
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
    private _code = [typeOf (_radioLR select 0), "tf_encryptionCode"] call TFAR_fnc_getVehicleConfigProperty;

    if (_code == "tf_guer_radio_code") then {
        _code = "tf_independent_radio_code";
    };

    _dataLR set [TFAR_CODE_OFFSET, _code];

    // Set settings
    [_radioLR, _dataLR] call TFAR_fnc_setLrSettings;
};

// Set the headset up or down
_headsetStatus call TFAR_fnc_setHeadsetLowered;
