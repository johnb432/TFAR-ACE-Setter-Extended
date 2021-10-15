#include "script_component.hpp"
/*
 * Author: johnb43
 * Deletes a chosen profile of given index.
 *
 * Arguments:
 * 0: Index <INTEGER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

// Needs to be scheduled because of BIS_fnc_guiMessage
_this spawn {
    private _presets = GETPRVAR(QGVAR(profileNames),[]);
    private _profile = _presets select _this;

    // Wait for confimation or setting is not enabled
    if (!GVAR(askDeleteConfirmation) || {[format ["Are you sure you want to delete profile '%1'?", _profile], "Confirmation", "Yes", "No"] call BIS_fnc_guiMessage}) then {
        // Set the profile to nil to delete variable
        SETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),nil);

        // Delete the preset from the list
        _presets deleteAt _this;
        SETPRVAR(QGVAR(profileNames),_presets);
    };
};
