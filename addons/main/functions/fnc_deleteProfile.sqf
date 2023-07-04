#include "script_component.hpp"

/*
 * Author: johnb43
 * Deletes a chosen profile of given index.
 *
 * Arguments:
 * 0: Index <NUMBER> (default: -1)
 * 1: Display <DISPLAY> (default: displayNull)
 *
 * Return Value:
 * None
 *
 * Example:
 * 0 call tfar_ace_extended_main_fnc_deleteProfile;
 *
 * Public: No
 */

params [["_index", -1, [0]], ["_display", displayNull, [displayNull]]];

// If index is invalid
if (_index == -1) exitWith {
    ["Profile can't be deleted!", false, 10, 2] call ace_common_fnc_displayText;
};

if (isNull _display) then {
    _display = findDisplay IDD_MISSION;
};

// If still null, exit
if (isNull _display) exitWith {};

// Needs to be scheduled because of BIS_fnc_guiMessage
[_index, _display] spawn {
    params ["_index", "_display"];

    private _presets = GETPRVAR(QGVAR(profileNames),[]);
    private _profile = _presets select _index;

    // Wait for confimation or setting is not enabled
    if (!GVAR(askDeleteConfirmation) || {[format ["Are you sure you want to delete profile '%1'?", _profile], "Confirmation", "Yes", "No", _display] call BIS_fnc_guiMessage}) then {
        // Set the profile to nil to delete variable
        SETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),nil);

        // Delete the preset from the list
        _presets deleteAt _index;
    };
};
