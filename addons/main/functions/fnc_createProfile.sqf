#include "script_component.hpp"

/*
 * Author: johnb43
 * Creates a new profile.
 *
 * Arguments:
 * 0: Preset <STRING>
 * 1: Settings <ARRAY>/<STRING containing ARRAY> (optional)
 *
 * Return Value:
 * None
 *
 * Example:
 * "Test" call tfar_ace_extended_main_fnc_createProfile;
 *
 * Public: No
 */

params [["_preset", "", [""]], ["_settings", [[], [], [], false], ["", []]], ["_display", findDisplay IDD_MISSION, [displayNull]]];

// Remove whitespaces
_preset = _preset splitString " " joinString "";

// If the new preset is invalid
if (_preset isEqualTo "" || {(toLower _preset) in ["names", "none"]}) exitWith {
    ["The chosen name is invalid!", false, 10, 2] call ace_common_fnc_displayText;
};

// If empty string passed, use default
if (_settings isEqualTo "") then {
    _settings = [[], [], [], false];
};

// If settings are left to default, add default preset; Otherwise make string into array
if (_settings isEqualType "") then {
    // If failure, parseSimpleArray returns []
    _settings = parseSimpleArray _settings;
};

// If not array or parsing failed
if !(_settings isEqualType []) exitWith {
    ["The given settings are invalid!", false, 10, 2] call ace_common_fnc_displayText;
};

// Set the UID on the SR (only required for SR); Done as a precaution if the imported profile comes from another player
private _dataSR = _settings param [0, []];

if (_dataSR isNotEqualTo []) then {
    _dataSR set [7, getPlayerUID player];
};

private _presets = GETPRVAR(QGVAR(profileNames),[]);
private _index = _presets findIf {_x == _preset};

// If preset isn't in preset list, add it; Make everything lowercase for string comparison
if (_index isEqualTo -1) exitWith {
    _presets pushBack _preset;

    SETPRVAR(FORMAT_1(QGVAR(profile%1),_preset),_settings);
};

// Needs to be scheduled because of BIS_fnc_guiMessage
[_preset, _settings, _display] spawn {
    params ["_preset", "_settings", "_display"];

    // Wait for confirmation or setting is not enabled or setting was newly added
    if (!GVAR(askOverwriteConfirmation) || {[format ["Are you sure you want to overwrite profile '%1'?", _preset], "Confirmation", "Yes", "No", _display] call BIS_fnc_guiMessage}) then {
        SETPRVAR(FORMAT_1(QGVAR(profile%1),_preset),_settings);
    };
};
