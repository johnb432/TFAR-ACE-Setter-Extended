#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Deletes a chosen profile of given index.
 *
 * Arguments:
 * 0: Profile index <NUMBER>
 * 1: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * 0 call tfar_ace_extended_main_fnc_deleteProfile
 *
 * Public: No
 */

params ["_index", "_display"];

// If index is invalid
if (_index == -1) exitWith {
    [LLSTRING(invalidProfile), false, 10, 2] call ace_common_fnc_displayText;
};

if (isNull _display) then {
    _display = findDisplay IDD_MISSION;
};

// If still null, exit
if (isNull _display) exitWith {};

// Needs to be scheduled because of BIS_fnc_guiMessage
[_index, _display] spawn {
    params ["_index", "_display"];

    private _profiles = GETPRVAR(QGVAR(profileNames),[]);
    private _profile = _profiles select _index;

    // Wait for confimation or setting is not enabled
    if (!GVAR(askDeleteConfirmation) || {[format [LLSTRING(deleteConfirmation), _profile], localize "str_a3_a_hub_misc_mission_selection_box_title", localize "str_disp_xbox_hint_yes", localize "str_disp_xbox_hint_no", _display] call BIS_fnc_guiMessage}) then {
        // Set the profile to nil to delete variable
        SETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),nil);

        // Delete the profile from the list
        _profiles deleteAt _index;
    };
};
