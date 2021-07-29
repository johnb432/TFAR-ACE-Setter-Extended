#include "script_component.hpp"
/*
 * Author: johnb43
 * Makes all subentries of the interaction menu for loading from profiles.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Radio types to be loaded <ARRAY>
 * 2: Save to other type of radio (only works for LR and VLR) <BOOLEAN>
 * 3: SR Radio <STRING> (optional)
 * If arg#2 is set to true, it will save to the same type of radio (LR -> LR, VLR -> VLR). If false, not the same type (LR -> VLR, VLR -> LR).
 *
 * Return Value:
 * All interaction submenus for saving to all profiles <ARRAY>
 *
 * Public: No
 */

private _profileNames = GETPRVAR(QGVAR(profileNames),[]);

// If there are no profiles, exit
if (_profileNames isEqualTo []) exitWith {[]};

params ["_unit", "_radioSaveTypes", "_saveSameType", ["_radio", "", [""]]];

private _menus = [];

// Make menus
{
    _menus pushBack [[
        format [GVAR(profileSave%1), _x], // Action name
        _x, // Display name
        "", // Icon
        { // Statement
            // All action parameters are passed. Needs to be scheduled because of BIS_fnc_guiMessage
            (_this select 2) spawn {
                // Wait for confimation or setting is not enabled
                if (!GVAR(askSaveConfirmation) || {[format ["Are you sure you want to save to profile '%1'?", _this select 3], "Confirmation", "Yes", "No"] call BIS_fnc_guiMessage}) then {
                    _this call FUNC(saveRadioSettings);
                };
            };
        },
        {true}, // Condition
        nil, // Children actions
        [_unit, _radioSaveTypes, _saveSameType, _x, _radio] // Action parameters
    ] call ace_interact_menu_fnc_createAction, [], _unit];
} forEach _profileNames;

_menus;
