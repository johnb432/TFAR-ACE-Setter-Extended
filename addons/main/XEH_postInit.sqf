#include "script_component.hpp"

#include "EventHandlersArsenal.sqf"

GVAR(crewStatus) = GVAR(crewStatusDefault);

["unit", {
    params ["_newUnit", "_oldUnit"];

    private _eventIDs = _oldUnit getVariable QGVAR(eventHandlersVehicleIDs);

    // Remove old EH
    if (!isNil "_eventIDs") then {
        _eventIDs params ["_getIn", "_switchSeat", "_getOut"];

        _oldUnit removeEventHandler ["GetInMan", _getIn];
        _oldUnit removeEventHandler ["SeatSwitchedMan", _switchSeat];
        _oldUnit removeEventHandler ["GetOutMan", _getOut];

        _oldUnit setVariable [QGVAR(eventHandlersVehicleIDs), nil];
    };

    _newUnit call FUNC(eventHandlersVehicle);
}, true] call CBA_fnc_addPlayerEventHandler;

// Add radio range sorting
[[[5, 12], []], QGVAR(radioRangeSort), "Sort by radio range", {
    params ["_itemCfg"];

    // If the LR is disabled, filter it out immediately; However, SRs don't have it, so check if config entry exists
    if (isNumber (_itemCfg >> "tf_hasLRradio") && {getNumber (_itemCfg >> "tf_hasLRradio") isEqualTo 0}) exitWith {0};

    getNumber (_itemCfg >> "tf_range");
}] call ace_arsenal_fnc_addSort;
