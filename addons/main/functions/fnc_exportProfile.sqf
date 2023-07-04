#include "script_component.hpp"

/*
 * Author: johnb43
 * Export a profile to the clipboard.
 *
 * Arguments:
 * 0: Index <NUMBER> (default: -1)
 *
 * Return Value:
 * None
 *
 * Example:
 * 0 call tfar_ace_extended_main_fnc_exportProfile;
 *
 * Public: No
 */

params [["_index", -1, [0]]];

if (_index == -1) exitWith {
    ["The chosen index is invalid!", false, 10, 2] call ace_common_fnc_displayText;
};

// If ACE clipboard is not enabled
if (!isClass (configFile >> "ACE_Extensions" >> "ace_clipboard")) exitWith {
    ["ACE clipboard is disabled!", false, 10, 2] call ace_common_fnc_displayText;
};

private _profile = GETPRVAR(QGVAR(profileNames),[]) select _index;
private _settings = GETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),[]);

// If profile is invalid, don't copy to clipboard
if (_settings isEqualTo []) exitWith {
    ["The chosen profile is invalid!", false, 10, 2] call ace_common_fnc_displayText;
};

// Copy to the clipboard
"ace_clipboard" callExtension (str _settings + ";");
"ace_clipboard" callExtension "--COMPLETE--";

[format ["Profile '%1' has been copied to your clipboard.", _profile], ICON_LOAD, GVAR(loadColorIcon), TFAR_currentUnit, 3] call ace_common_fnc_displayTextPicture;
