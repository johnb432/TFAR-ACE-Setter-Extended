#include "script_component.hpp"
/*
 * Authors: johnb43
	* Creates a new profile.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

["Create Radio Preset", [
    ["EDIT", ["Create new radio preset", "Allows you to store multiple radio presets. If you use whitespaces, it will remove those. DO NOT USE PUNCTUATION MARKS."], "", true]
],
{
    params ["_results"];
    _results params ["_newPreset"];

    // Remove spaces from the new name
    _newPreset = _newPreset splitString " " joinString "";

    private _presets = GETPRVAR(QGVAR(profileNames),[]);

    // If the new preset already exists or invalid, then quit
    if !(_newPreset isNotEqualTo "" && {!(_newPreset in _presets)}) exitWith {};

    // Add the preset to the list of presets
    _presets pushBack _newPreset;
    SETPRVAR(QGVAR(profileNames),_presets);

    SETPRVAR(FORMAT_1(QGVAR(profile%1),_newPreset),[ARR_4([],[],[],false)]);
}, {}] call zen_dialog_fnc_create;
