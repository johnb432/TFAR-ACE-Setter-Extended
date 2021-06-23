#include "script_component.hpp"
/*
 * Author: johnb43
 * Makes all subentries of the interaction menu for loading from profiles.
 *
 * Arguments:
 * 0: Arguments from interaction <ARRAY>
 * 1: Radio types to be loaded <ARRAY>
 * 2: Save to other type of radio (only works for LR and VLR) <BOOLEAN>
 * If arg#2 is set to true, it will save to the same type of radio (LR -> LR, VLR -> VLR). If false, not the same type (LR -> VLR, VLR -> LR).
 *
 * Return Value:
 * All interaction submenus for saving to all profiles <ARRAY>
 *
 * Public: No
 */

params ["_menuArgs", "_radioSaveTypes", "_saveSameType"];
_menuArgs params ["_target", "_player", "_args"];

private _profileNames = GETPRVAR(QGVAR(profileNames),[]);

if (_profileNames isEqualTo []) exitWith {};

private _menus = [];

{
    _menus pushBack [[
        format [GVAR(profileSave%1), _x], //Action name
        _x,
        "", //Icon
        { //Statement
            (_this select 2) call FUNC(saveRadioSettings);
        },
        {true}, //Condition
        nil,
        [_radioSaveTypes, _saveSameType, _x] //Action parameters
    ] call ace_interact_menu_fnc_createAction, [], _player];
} forEach _profileNames;

_menus;
