#include "script_component.hpp"
/*
 * Author: johnb43
 * Makes all subentries of the interaction menu for loading from profiles.
 *
 * Arguments:
 * 0: Arguments from interaction <ARRAY>
 * 1: Radio types to be loaded from <ARRAY>
 * 2: Load other type of radio (only works for LR and VLR) <BOOLEAN>
 * If arg#2 is set to true, it will load the same type of radio (LR -> LR, VLR -> VLR). If false, not the same type (LR -> VLR, VLR -> LR).
 *
 * Return Value:
 * All interaction submenus for loading from all profiles <ARRAY>
 *
 * Public: No
 */

params ["_menuArgs", "_radioLoadTypes", "_loadSameType"];
_menuArgs params ["_target", "_player", "_args"];

private _profileNames = GETPRVAR(QGVAR(profileNames),[]);

if (_profileNames isEqualTo []) exitWith {};

private _menus = [];

{
    _menus pushBack [[
        format [GVAR(profileLoad%1), _x], //Action name
        _x,
        "", //Icon
        { //Statement
            (_this select 2) call FUNC(loadRadioSettings);
        },
        {
            GETPRVAR(FORMAT_1(QGVAR(profile%1),_this select 2 select 2),[]) params ["_SR", "_LR", "_VLR"];
            (_this select 2 select 0) params ["_doSR", "_doLR", "_doVLR"];

            // Check if the profile has anything stored
            if (_doSR && {_SR isEqualTo []}) exitWith {false};
            if (_doLR && {_LR isEqualTo []}) exitWith {false};
            if (_doVLR && {_VLR isEqualTo []}) exitWith {false};

            true;
        }, //Condition
        nil,
        [_radioLoadTypes, _loadSameType, _x] //Action parameters
    ] call ace_interact_menu_fnc_createAction, [], _player];
} forEach _profileNames;

_menus;
