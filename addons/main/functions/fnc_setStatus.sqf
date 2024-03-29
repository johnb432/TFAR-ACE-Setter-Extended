#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Sets the player to a status. This is used in the vehicle mounting detection.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * player call tfar_ace_extended_main_fnc_setStatus
 *
 * Public: No
 */

GVAR(crewStatus) = true;

// If CBA settings for this are disabled, exit
if (!GVAR(enableMountingAutoSettings)) exitWith {};

params ["_unit"];

private _vehicle = objectParent _unit;

// If not correct type of vehicle
if !(_vehicle isKindOf "Air" || {_vehicle isKindOf "Land"}) exitWith {};

private _radioSR = call FUNC(activeSwRadio);

private _dataRadioSR = if (_radioSR != "") then {
    _radioSR call TFAR_fnc_getSwSettings
} else {
    []
};

// Get currently active radios
private _data = [_dataRadioSR, (_unit call TFAR_fnc_backpackLR) call TFAR_fnc_getLrSettings, [], GETMVAR("TFAR_core_isHeadsetLowered",false)];

// If entries are nil, set them to []
{
    if (isNil "_x" || {_x isEqualType objNull && {isNull _x}}) then {
        _data set [_forEachIndex, []];
    };
} forEach _data;

_unit setVariable [QGVAR(radioLoadout), _data];

private _radioVLR = _unit call TFAR_fnc_vehicleLR;

// If there is no VLR, don't load any settings
if (isNil "_radioVLR") exitWith {};

// Get data from profile
_data = GETPRVAR(FORMAT_1(QGVAR(profile%1),[ARR_2(GVAR(landProfileName),GVAR(airProfileName))] select (_vehicle isKindOf "Air")),[]);

// If nothing can be applied, exit
if (_data isEqualTo []) exitWith {};

[_unit, _data, _radioVLR] call FUNC(loadVehicleSettings);
