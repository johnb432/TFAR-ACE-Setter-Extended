#include "script_component.hpp"
/*
 * Author: johnb43
 * Applies EH to check for vehicle change on selected units
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit"];

if (!isNil {_unit getVariable QGVAR(eventHandlersVehicleIDs)}) exitWith {};

// When mounting, save loadout and apply a profile's config
_unit setVariable [QGVAR(eventHandlersVehicleIDs), [
    _unit addEventHandler ["GetInMan", {
        // If CBA settings for this are disabled, break
        if (!GVAR(enableMountingAutoSettings)) exitWith {};

        params ["_unit", "", "_vehicle"];

        // If not correct type of vehicle
        if !(_vehicle isKindOf "Air" || {_vehicle isKindOf "Land"}) exitWith {};

        // Get currently active radios
        private _data = [(call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwSettings, (_unit call TFAR_fnc_backpackLR) call TFAR_fnc_getLrSettings, [], missionNamespace getVariable ["TFAR_core_isHeadsetLowered", false]];

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
    }],
    // When switching seats, apply a profile's config
    _unit addEventHandler ["SeatSwitchedMan", {
        // If CBA settings for this are disabled, break
        if (!GVAR(enableMountingAutoSettings)) exitWith {};

        params ["_unit", "", "_vehicle"];

        // If not correct type of vehicle
        if !(_vehicle isKindOf "Air" || {_vehicle isKindOf "Land"}) exitWith {};

        private _data = GETPRVAR(FORMAT_1(QGVAR(profile%1),[ARR_2(GVAR(landProfile),GVAR(airProfile))] select (_vehicle isKindOf "Air")),[]);

        // If nothing can be applied, exit
        if (isNil "_data" || {_data isEqualTo []}) exitWith {};

        private _radioLR = _unit call TFAR_fnc_vehicleLR;

        // If there is no VLR in the new seat, apply old settings
        if (isNil "_radioLR") then {
            _radioLR = _unit call TFAR_fnc_backpackLR;
            _data = _unit getVariable [QGVAR(radioLoadout), [[], [], [], false]];
        };

        [_unit, _data, call TFAR_fnc_activeSwRadio, _radioLR] call FUNC(loadVehicleSettings);
    }],
    // When leaving a vehicle, the previously saved loadout will be applied
    _unit addEventHandler ["GetOutMan", {
        // If CBA settings for this are disabled, break
        if (!GVAR(enableMountingAutoSettings)) exitWith {};

        params ["_unit", "", "_vehicle"];

        // If not correct type of vehicle
        if !(_vehicle isKindOf "Air" || {_vehicle isKindOf "Land"}) exitWith {};

        [_unit, _unit getVariable [QGVAR(radioLoadout), [[], [], [], false]], call TFAR_fnc_activeSwRadio, _unit call TFAR_fnc_backpackLR] call FUNC(loadVehicleSettings);
    }]
]];
