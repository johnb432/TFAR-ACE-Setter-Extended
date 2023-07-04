#include "script_component.hpp"

/*
 * Author: johnb43
 * Makes all subentries of the interaction menu for loading from profiles.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Radio types to be loaded <ARRAY>
 * 2: Load from other type of radio (only works for LR and VLR) <BOOL> (default: true)
 * 3: SR Radio <STRING> (default: call FUNC(activeSwRadio))
 * 4: LR Radio <ARRAY> (default: [])
 * If arg#2 is set to true, it will load the same type of radio (LR -> LR, VLR -> VLR). If false, not the same type (LR -> VLR, VLR -> LR).
 *
 * Return Value:
 * All interaction submenus for loading from all profiles <ARRAY>
 *
 * Example:
 * [player, [true, false, false]] call tfar_ace_extended_main_fnc_profileMenusLoad;
 *
 * Public: No
 */

private _profileNames = GETPRVAR(QGVAR(profileNames),[]);

// If there are no profiles
if (_profileNames isEqualTo []) exitWith {[]};

params ["_unit", "_loadFromRadios", ["_loadSameType", true, [true]], ["_radioSR", call FUNC(activeSwRadio), [""]], ["_radioLR", [], [[]]]];

// Open in Zeus interface if needed
private _display = findDisplay IDD_RSCDISPLAYCURATOR;

if (isNull _display) then {
    _display = findDisplay IDD_MISSION;
};

// Make menus
_profileNames apply {[
    [
        format [GVAR(profileLoad_%1), _x], // Action name
        _x, // Display name
        "", // Icon
        { // Statement
            // All action parameters are passed; Needs to be scheduled because of BIS_fnc_guiMessage
            (_this select 2) spawn {
                // Wait for confimation or setting is not enabled
                if (!GVAR(askLoadConfirmation) || {[format ["Are you sure you want to load from profile '%1'?", _this select 2], "Confirmation", "Yes", "No", _this select 6] call BIS_fnc_guiMessage}) then {
                    _this call FUNC(loadRadioSettings);
                };
            };
        },
        { // Condition
            private _args = _this select 2;
            GETPRVAR(FORMAT_1(QGVAR(profile%1),_args select 2),[]) params ["_dataSR", "_dataLR", "_dataVLR"];
            (_args select 1) params ["_doSR", "_doLR", "_doVLR"];

            // Do not show load options from profiles where radios in question are not defined
            (!_doSR || {_dataSR isNotEqualTo []}) && {!_doLR || {_dataLR isNotEqualTo []}} && {!_doVLR || {_dataVLR isNotEqualTo []}};
        },
        nil, // Children actions
        [_unit, _loadFromRadios, _x, _loadSameType, _radioSR, _radioLR, _display] // Action parameters
    ] call ace_interact_menu_fnc_createAction, [], _unit];
}
