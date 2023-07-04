#include "script_component.hpp"

/*
 * Author: johnb43
 * Sets the channel to whatever squad you are in, if you have the option enabled and are on an FK server.
 *
 * Arguments:
 * 0: Unit <OBJECT> (default: player)
 * 1: SR Radio <STRING> (default: call FUNC(activeSwRadio))
 *
 * Return Value:
 * None
 *
 * Example:
 * player call tfar_ace_extended_main_fnc_setChannelFK;
 *
 * Public: No
 */

// Set the correct SR channel if FK compat mode is enabled and FKFramework is loaded
if !(GVAR(enableCompatFK) && {!isNil "fkf_main_fnc_addArsenal"}) exitWith {};

params [["_unit", player, [objNull]], ["_radioSR", call FUNC(activeSwRadio), [""]]];

if !(alive _unit && {_radioSR isNotEqualTo ""}) exitWith {};

// Find in which squad the unit is in and change index accordingly
private _index = switch (((str group _unit) splitString " ") select 1) do {
    case "A": {0};
    case "B": {1};
    case "C": {2};
    case "D": {3};
    case "E": {4};
    case "PltHQ": {5};
    case "KNGT": {6};
    case "RPTR": {7};
    default {8};
};

[_radioSR, _index] call TFAR_fnc_setSwChannel;
