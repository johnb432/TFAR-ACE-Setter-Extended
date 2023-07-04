#include "script_component.hpp"

/*
 * Author: johnb43
 * Applies EH to check for vehicle change on a unit.
 *
 * Arguments:
 * 0: Unit <OBJECT> (default: player)
 *
 * Return Value:
 * None
 *
 * Example:
 * player call tfar_ace_extended_main_fnc_eventHandlersVehicle;
 *
 * Public: No
 */

params [["_unit", player, [objNull]]];

if (isNull _unit || {!isNil {_unit getVariable QGVAR(vehicleEhIDs)}}) exitWith {};

// When mounting, save loadout and apply a profile's config
_unit setVariable [QGVAR(vehicleEhIDs), [
    _unit addEventHandler ["GetInMan", {
        // If CBA settings for this are disabled
        if (!GVAR(enableMountingAutoSettings) || {!GVAR(crewStatus)}) exitWith {};

        params ["_unit", "", "_vehicle"];

        // If not correct type of vehicle
        if !(_vehicle isKindOf "Air" || {_vehicle isKindOf "Land"}) exitWith {};

        private _radioSR = call FUNC(activeSwRadio);

        private _dataRadioSR = if (_radioSR isNotEqualTo "") then {
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

        // If there is no VLR, don't load any settings
        if (isNil {_unit call TFAR_fnc_vehicleLR}) exitWith {};

        // Get data from profile
        _data = GETPRVAR(FORMAT_1(QGVAR(profile%1),[ARR_2(GVAR(landProfileName),GVAR(airProfileName))] select (_vehicle isKindOf "Air")),[]);

        // If nothing can be applied, exit
        if (isNil "_data" || {_data isEqualTo []}) exitWith {};

        [_unit, _data, _unit call TFAR_fnc_vehicleLR] call FUNC(loadVehicleSettings);
    }],
    // When switching seats, apply a profile's config
    _unit addEventHandler ["SeatSwitchedMan", {
        // If CBA settings for this are disabled
        if (!GVAR(enableMountingAutoSettings) || {!GVAR(crewStatus)}) exitWith {};

        params ["_unit", "", "_vehicle"];

        // If not correct type of vehicle
        if !(_vehicle isKindOf "Air" || {_vehicle isKindOf "Land"}) exitWith {};

        private _data = GETPRVAR(FORMAT_1(QGVAR(profile%1),[ARR_2(GVAR(landProfileName),GVAR(airProfileName))] select (_vehicle isKindOf "Air")),[]);

        // If nothing can be applied
        if (isNil "_data" || {_data isEqualTo []}) exitWith {};

        private _radioLR = _unit call TFAR_fnc_vehicleLR;

        // If there is no VLR in the new seat, apply old settings
        if (isNil "_radioLR") then {
            _radioLR = _unit call TFAR_fnc_backpackLR;
            _data = _unit getVariable [QGVAR(radioLoadout), [[], [], [], false]];
        };

        [_unit, _data, _radioLR] call FUNC(loadVehicleSettings);
    }],
    // When leaving a vehicle, the previously saved loadout will be applied
    _unit addEventHandler ["GetOutMan", {
        // If CBA settings for this are disabled
        if (!GVAR(enableMountingAutoSettings) || {!GVAR(crewStatus)}) exitWith {};

        params ["_unit", "", "_vehicle"];

        // If not correct type of vehicle
        if !(_vehicle isKindOf "Air" || {_vehicle isKindOf "Land"}) exitWith {};

        [_unit, _unit getVariable [QGVAR(radioLoadout), [[], [], [], false]], _unit call TFAR_fnc_backpackLR] call FUNC(loadVehicleSettings);
    }]
]];
