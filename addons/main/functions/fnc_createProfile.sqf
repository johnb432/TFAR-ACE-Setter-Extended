#include "script_component.hpp"
/*
 * Author: johnb43
 * Creates a new profile.
 *
 * Arguments:
 * 0: Preset <STRING>
 * 1: Settings <ARRAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_preset", "_settings"];

// Remove whitespaces
_preset = _preset splitString " " joinString "";

// If the new preset is invalid, then quit
if (_preset isEqualTo "" || toLower _preset isEqualTo "names") exitWith {
    hint "The chosen name is invalid!";
};

// If settings are left to default, add default preset; otherwise make string into array
_settings = parseSimpleArray (["[[], [], [], false]", _settings] select (_settings isNotEqualTo ""));

// Set the UID on the SR (only required for SR). Done as a precaution if the imported profile comes from another player
if ((_settings select 0) isNotEqualTo []) then {
    (_settings select 0) set [7, getPlayerUID player];
};

private _presets = GETPRVAR(QGVAR(profileNames),[]);

// If preset isn't in preset list, add it. Make everything lowercase for string comparison
if !((toLower _preset) in (_presets apply {toLower _x})) then {
    _presets pushBack _preset;

    SETPRVAR(QGVAR(profileNames),_presets);
    SETPRVAR(FORMAT_1(QGVAR(profile%1),_preset),_settings);
} else {
    // If preset is already in the list, it's going to overwrite it. Ask for confirmation if necessary. Needs to be scheduled because of BIS_fnc_guiMessage
    [_preset, _settings] spawn {
        params ["_preset", "_settings"];
        // Wait for confirmation or setting is not enabled
        if (!GVAR(askOverwriteConfirmation) || {[format ["Are you sure you want to overwrite profile '%1'?", _preset], "Confirmation", "Yes", "No"] call BIS_fnc_guiMessage}) then {
            // Overwrite profile
            SETPRVAR(FORMAT_1(QGVAR(profile%1),_preset),_settings);
        };
    };
};
