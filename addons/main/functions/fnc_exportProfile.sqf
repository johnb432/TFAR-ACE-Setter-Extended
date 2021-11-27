#include "script_component.hpp"
/*
 * Author: johnb43
 * Export a profile to the clipboard.
 *
 * Arguments:
 * 0: Index <INTEGER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

private _profile = GETPRVAR(QGVAR(profileNames),[]) select _this;
private _settings = GETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),[]);

// If profile is invalid, don't copy to clipboard
if (_settings isEqualTo []) exitWith {
    ["The chosen profile is invalid!", false, 10, 2] call ace_common_fnc_displayText;
};

// Copy to the clipboard
"ace_clipboard" callExtension (str _settings + ";");
"ace_clipboard" callExtension "--COMPLETE--";

[format ["Profile '%1' has been copied to your clipboard.", _profile], ICON_LOAD, GVAR(loadColorIcon), call CBA_fnc_currentUnit, 3] call ace_common_fnc_displayTextPicture;
