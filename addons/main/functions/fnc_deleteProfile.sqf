#include "script_component.hpp"
/*
 * Authors: johnb43
	* Deletes a chosen profile.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

["Delete Radio Preset", [
    ["COMBO", ["Delete Radio Preset", "Allows you to select a preset to delete."], [GETPRVAR(QGVAR(profileNames),[]), GETPRVAR(QGVAR(profileNames),[]), 0], false]
],
{
    params ["_results"];
    _results params ["_selectedPreset"];

    // Set the profile to nil to delete variable
    SETPRVAR(FORMAT_1(QGVAR(profile%1),_selectedPreset),nil);

    private _presets = GETPRVAR(QGVAR(profileNames),[]);

    // Delete the preset from the list if it's in there
    private _index = _presets findIf {_x isEqualTo _selectedPreset};
    if (_index isEqualTo -1) exitWith {};

    _presets deleteAt _index;
    SETPRVAR(QGVAR(profileNames),_presets);
}, {}] call zen_dialog_fnc_create;
