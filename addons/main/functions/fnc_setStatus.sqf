#include "script_component.hpp"
/*
 * Author: johnb43
 * Sets the player to a status. This is used in the vehicle mounting detection.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

GVAR(crewStatus) = true;

// If CBA settings for this are disabled, break
if (!GVAR(enableMountingAutoSettings)) exitWith {};

private _unit = call CBA_fnc_currentUnit;
private _vehicle = objectParent _unit;

// If not correct type of vehicle
if !(_vehicle isKindOf "Air" || {_vehicle isKindOf "Land"}) exitWith {};

// Get currently active radios
private _data = [(call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwSettings, (_unit call TFAR_fnc_backpackLR) call TFAR_fnc_getLrSettings, [], GETMVAR("TFAR_core_isHeadsetLowered",false)];

// If entries are nil, set them to []
{
    if (isNil "_x") then {
        _data set [_forEachIndex, []];
    };
} forEach _data;

_unit setVariable [QGVAR(radioLoadout), _data];

// If there is no VLR, don't load any settings
if (isNil {_unit call TFAR_fnc_vehicleLR}) exitWith {};

// Get data from profile
_data = GETPRVAR(FORMAT_1(QGVAR(profile%1),[ARR_2(GVAR(landProfile),GVAR(airProfile))] select (_vehicle isKindOf "Air")),[]);

// If nothing can be applied, exit
if (isNil "_data" || {_data isEqualTo []}) exitWith {};

[_unit, _data, call TFAR_fnc_activeSwRadio, _unit call TFAR_fnc_vehicleLR] call FUNC(loadVehicleSettings);
