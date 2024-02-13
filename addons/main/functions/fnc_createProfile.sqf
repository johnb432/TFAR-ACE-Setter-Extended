#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Creates a new profile.
 *
 * Arguments:
 * 0: Profile name <STRING>
 * 1: Settings <ARRAY> <STRING> (default: [[], [], [], false])
 * 2: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * "Test" call tfar_ace_extended_main_fnc_createProfile
 *
 * Public: No
 */

params ["_profile", ["_data", [[], [], [], false], ["", []], PROFILE_COUNT], "_display"];

// Remove whitespaces
_profile = _profile splitString WHITESPACE joinString "";

// If the new profile is invalid, exit
if (_profile == "" || {(toLower _profile) in ["names", "none"]}) exitWith {
    [LLSTRING(invalidName), false, 10, 2] call ace_common_fnc_displayText;
};

// If empty string passed, use default
if (_data == "") then {
    _data = [[], [], [], false];
};

// If settings are left to default, add default profile; Otherwise make string into array
if (_data isEqualType "") then {
    // If failure, parseSimpleArray returns []
    _data = parseSimpleArray _data;
};

// If not array or parsing failed, exit
if !(_data isEqualType []) exitWith {
    [LLSTRING(invalidSettings), false, 10, 2] call ace_common_fnc_displayText;
};

// If wrong type given, exit
if !(_data params [["_dataSR", [], [[]], [0, RADIO_SETTINGS_COUNT]], ["_dataLR", [], [[]], [0, RADIO_SETTINGS_COUNT]], ["_dataVLR", [], [[]], [0, RADIO_SETTINGS_COUNT]], ["_headsetStatus", false, [true]]]) exitWith {
    [LLSTRING(wrongFormatSettings), false, 10, 2] call ace_common_fnc_displayText;
};

// Set the UID on the SR (only required for SR); Done as a precaution if the imported profile comes from another player
if (_dataSR isNotEqualTo []) then {
    _dataSR set [7, getPlayerUID player];
};

private _profiles = GETPRVAR(QGVAR(profileNames),[]);

// If profile isn't in profile list, add it and exit
if ((_profiles findIf {_x == _profile}) == -1) exitWith {
    _profiles pushBack _profile;

    SETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),_data);
};

// Needs to be scheduled because of BIS_fnc_guiMessage
[_profile, _data, _display] spawn {
    params ["_profile", "_data", "_display"];

    // Wait for confirmation or setting is not enabled
    if (!GVAR(askOverwriteConfirmation) || {[format [LLSTRING(overwriteConfirmation), _profile], localize "str_a3_a_hub_misc_mission_selection_box_title", localize "str_disp_xbox_hint_yes", localize "str_disp_xbox_hint_no", _display] call BIS_fnc_guiMessage}) then {
        SETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),_data);
    };
};
