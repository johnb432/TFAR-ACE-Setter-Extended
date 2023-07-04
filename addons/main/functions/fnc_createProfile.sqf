#include "script_component.hpp"

/*
 * Author: johnb43
 * Creates a new profile.
 *
 * Arguments:
 * 0: Preset <STRING> (default: "")
 * 1: Settings <ARRAY> <STRING> (default: [[], [], [], false])
 * 2: Display <DISPLAY> (default: mission display)
 *
 * Return Value:
 * None
 *
 * Example:
 * "Test" call tfar_ace_extended_main_fnc_createProfile;
 *
 * Public: No
 */

params [["_preset", "", [""]], ["_data", [[], [], [], false], ["", []], PROFILE_COUNT], ["_display", findDisplay IDD_MISSION, [displayNull]]];

// Remove whitespaces
_preset = _preset splitString WHITESPACE joinString "";

// If the new preset is invalid, exit
if (_preset isEqualTo "" || {(toLower _preset) in ["names", "none"]}) exitWith {
    ["The chosen name is invalid!", false, 10, 2] call ace_common_fnc_displayText;
};

// If empty string passed, use default
if (_data isEqualTo "") then {
    _data = [[], [], [], false];
};

// If settings are left to default, add default preset; Otherwise make string into array
if (_data isEqualType "") then {
    // If failure, parseSimpleArray returns []
    _data = parseSimpleArray _data;
};

// If not array or parsing failed, exit
if !(_data isEqualType []) exitWith {
    ["The given settings are invalid!", false, 10, 2] call ace_common_fnc_displayText;
};

// If wrong type given, exit
if !(_data params [["_dataSR", [], [[]], [0, RADIO_SETTINGS_COUNT]], ["_dataLR", [], [[]], [0, RADIO_SETTINGS_COUNT]], ["_dataVLR", [], [[]], [0, RADIO_SETTINGS_COUNT]], ["_headsetStatus", false, [true]]]) exitWith {
    ["The given settings are in the wrong format!", false, 10, 2] call ace_common_fnc_displayText;
};

// Set the UID on the SR (only required for SR); Done as a precaution if the imported profile comes from another player
if (_dataSR isNotEqualTo []) then {
    _dataSR set [7, getPlayerUID player];
};

private _presets = GETPRVAR(QGVAR(profileNames),[]);

// If preset isn't in preset list, add it and exit
if ((_presets findIf {_x == _preset}) == -1) exitWith {
    _presets pushBack _preset;

    SETPRVAR(FORMAT_1(QGVAR(profile%1),_preset),_data);
};

// Needs to be scheduled because of BIS_fnc_guiMessage
[_preset, _data, _display] spawn {
    params ["_preset", "_data", "_display"];

    // Wait for confirmation or setting is not enabled or setting was newly added
    if (!GVAR(askOverwriteConfirmation) || {[format ["Are you sure you want to overwrite profile '%1'?", _preset], "Confirmation", "Yes", "No", _display] call BIS_fnc_guiMessage}) then {
        SETPRVAR(FORMAT_1(QGVAR(profile%1),_preset),_data);
    };
};
