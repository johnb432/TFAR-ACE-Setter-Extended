#include "script_component.hpp"

#include "EventHandlersArsenal.sqf"

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
