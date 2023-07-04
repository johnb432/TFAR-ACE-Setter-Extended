#include "script_component.hpp"

/*
 * Author: johnb43
 * Makes all subentries of the interaction menu for loading from profiles.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Radio types to be saved <ARRAY>
 * 2: Save to same type of radio (only works for LR and VLR) <BOOL> (default: true)
 * 3: SR Radio <STRING> (default: call FUNC(activeSwRadio))
 * 4: LR Radio <ARRAY> (default: [])
 * If arg#2 is set to true, it will save to the same type of radio (LR -> LR, VLR -> VLR). If false, not the same type (LR -> VLR, VLR -> LR).
 *
 * Return Value:
 * All interaction submenus for saving to all profiles <ARRAY>
 *
 * Example:
 * [player, [true, false, false]] call tfar_ace_extended_main_fnc_profileMenusSave;
 *
 * Public: No
 */

private _profileNames = GETPRVAR(QGVAR(profileNames),[]);

// If there are no profiles
if (_profileNames isEqualTo []) exitWith {[]};

params ["_unit", "_saveFromRadios", ["_saveSameType", true, [true]], ["_radioSR", call FUNC(activeSwRadio), [""]], ["_radioLR", [], [[]]]];

// Open in Zeus interface if needed
private _display = findDisplay IDD_RSCDISPLAYCURATOR;

if (isNull _display) then {
    _display = findDisplay IDD_MISSION;
};

// Make menus
_profileNames apply {[
    [
        format [GVAR(profileSave_%1), _x], // Action name
        _x, // Display name
        "", // Icon
        { // Statement
            // All action parameters are passed; Needs to be scheduled because of BIS_fnc_guiMessage
            (_this select 2) spawn {
                // Wait for confimation or setting is not enabled
                if (!GVAR(askSaveConfirmation) || {[format ["Are you sure you want to save to profile '%1'?", _this select 2], "Confirmation", "Yes", "No", _this select 6] call BIS_fnc_guiMessage}) then {
                    _this call FUNC(saveRadioSettings);
                };
            };
        },
        {true}, // Condition
        nil, // Children actions
        [_unit, _saveFromRadios, _x, _saveSameType, _radioSR, _radioLR, _display] // Action parameters
    ] call ace_interact_menu_fnc_createAction, [], _unit];
}
