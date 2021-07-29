#include "script_component.hpp"
/*
 * Author: johnb43
 * Loads the saved settings in a vehicle.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_data", "_radioSR", "_radioLR"];
_data params ["_SR", "_LR", "_VLR", "_headsetStatus"];

// Load side encryption. However, the radio settings in a profile will never be overwritten
private _code = tfar_radiocode_independent;

switch (side _unit) do {
    case east: {_code = tfar_radiocode_east};
    case west: {_code = tfar_radiocode_west};
    default {};
};

// If a SW is found and the settings are not [], load them
if (!isNil {_radioSR} && {_SR isNotEqualTo []}) then {
    // Set settings
    [_radioSR, _SR] call TFAR_fnc_setSwSettings;
    [_radioSR, _code] call TFAR_fnc_setSwRadioCode;
    [_unit, _radioSR] call FUNC(setChannelFK);
};

// If a LR is found and the settings are not [], load them
if (!isNil {_radioLR} && {_LR isNotEqualTo [] || {_VLR isNotEqualTo []}}) then {
    // Set settings; Apply VLR to VLR if possible, otherwise a mix of settings (LR -> VLR, VLR -> LR, LR -> LR)
    [_radioLR, [_LR, _VLR] select (_VLR isNotEqualto [])] call TFAR_fnc_setLrSettings;
    [_radioLR, _code] call TFAR_fnc_setLrRadioCode;
};

// Set the headset up or down
if (!isNil "_headsetStatus") then {
    _headsetStatus call TFAR_fnc_setHeadsetLowered;
};
