#include "script_component.hpp"
/*
 * Author: johnb43
 * Sets the channel to whatever squad you are in, if you have the option enabled and are on an FK server.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: SR Radio <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

// Set the correct SR channel if FK compat mode is enabled and FKFramework is loaded
if !(GVAR(enableCompatFK) && {!isNil "fkf_main_fnc_addArsenal"}) exitWith {};

params ["_unit", "_radio"];

private _index = 8;

// Find in which squad the unit is in and change index accordingly
switch (((str (group _unit)) splitString " ") select 1) do {
    case "A": {_index = 0};
    case "B": {_index = 1};
    case "C": {_index = 2};
    case "D": {_index = 3};
    case "E": {_index = 4};
    case "PltHQ": {_index = 5};
    case "KNGT": {_index = 6};
    case "RPTR": {_index = 7};
    default {};
};

[_radio, _index] call TFAR_fnc_setSwChannel;
