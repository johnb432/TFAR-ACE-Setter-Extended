#include "script_component.hpp"

/*
 * Author: johnb43
 * Loads the saved settings in a vehicle.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Radio data <ARRAY>
 * 2: LR Radio <STRING|ARRAY>
 * 3: SR Radio <STRING> (optional)
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, [[], [], [], false], player call TFAR_fnc_vehicleLR] call tfar_ace_extended_main_fnc_loadVehicleSettings;
 *
 * Public: No
 */

params [["_unit", player, [objNull]], ["_data", [[], [], [], false], [[]]], ["_radioLR", [], [[]]], ["_radioSR", call FUNC(activeSwRadio), [""]]];
_data params [["_dataSR", [], [[]]], ["_dataLR", [], [[]]], ["_dataVLR", [], [[]]], ["_headsetStatus", false, [true]]];

if (!alive _unit) exitWith {};

// Load side encryption. However, the radio settings in a profile will never be overwritten
private _code = switch (side _unit) do {
    case east: {tfar_radiocode_east};
    case west: {tfar_radiocode_west};
    default {tfar_radiocode_independent};
};

// If a SW is found and the settings are not [], load them
if (_radioSR isNotEqualTo "" && {_dataSR isNotEqualTo []}) then {
    // Set settings
    [_radioSR, _dataSR] call TFAR_fnc_setSwSettings;
    [_radioSR, _code] call TFAR_fnc_setSwRadioCode;
    [_unit, _radioSR] call FUNC(setChannelFK);
};

// If a LR is found and the settings are not [], load them
if (_radioLR isNotEqualTo [] && {_dataLR isNotEqualTo [] || {_dataVLR isNotEqualTo []}}) then {
    // Set settings; Apply VLR to VLR if possible, otherwise a mix of settings (LR -> VLR, VLR -> LR, LR -> LR)
    [_radioLR, [_dataLR, _dataVLR] select (_dataVLR isNotEqualTo [])] call TFAR_fnc_setLrSettings;
    [_radioLR, _code] call TFAR_fnc_setLrRadioCode;
};

// Set the headset up or down
if (!isNil "_headsetStatus") then {
    _headsetStatus call TFAR_fnc_setHeadsetLowered;
};
