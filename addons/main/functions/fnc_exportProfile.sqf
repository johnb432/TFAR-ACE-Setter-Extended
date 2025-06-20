#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Export a profile to the clipboard.
 *
 * Arguments:
 * 0: Profile index <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * 0 call tfar_ace_extended_main_fnc_exportProfile
 *
 * Public: No
 */

params ["_index"];

// If index is invalid
if (_index == -1) exitWith {
    [LLSTRING(invalidProfile), false, 10, 2] call ace_common_fnc_displayText;
};

// If no clipboard is available
if (GVAR(ACEClipboardLoaded) == 0 && !isServer) exitWith {
    [LLSTRING(clipboardDisabled), false, 10, 2] call ace_common_fnc_displayText;
};

private _profile = GETPRVAR(QGVAR(profileNames),[]) select _index;
private _settings = GETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),[]);

// If profile is invalid, don't copy to clipboard
if (_settings isEqualTo []) exitWith {
    [LLSTRING(invalidProfile), false, 10, 2] call ace_common_fnc_displayText;
};

_settings = str _settings;

// Copy to the clipboard
if (GVAR(ACEClipboardLoaded) != 0) then {
    if (GVAR(ACEClipboardLoaded) == 1) then {
        "ace_clipboard" callExtension (_settings + ";");
        "ace_clipboard" callExtension "--COMPLETE--";
    } else {
        "ace" callExtension ["clipboard:append", [_settings]];
        "ace" callExtension ["clipboard:complete", []];
    };
} else {
    copyToClipboard _settings;
};

[format [LLSTRING(profileCopiedClipboard), _profile], ICON_ADD, GVAR(loadColorIcon), TFAR_currentUnit, 3] call ace_common_fnc_displayTextPicture;
